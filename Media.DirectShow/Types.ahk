#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, BSTR, COLORREF, HANDLE, HRESULT, HWND, PAPCFUNC, POINT, PSTR, PWSTR, RECT, SIZE, VARIANT_BOOL}
#Import "..\Graphics.Direct3D9\Types.ahk" {D3DFORMAT, D3DPOOL, IDirect3DDevice9, IDirect3DSurface9}
#Import "..\Graphics.DirectDraw\Types.ahk" {DDCAPS_DX7, DDCOLORCONTROL, DDCOLORKEY, DDPIXELFORMAT, DDSCAPS2, DDSURFACEDESC, DDVIDEOPORTCONNECT, IDirectDraw, IDirectDraw7, IDirectDrawPalette, IDirectDrawSurface, IDirectDrawSurface7}
#Import "..\Graphics.Gdi\Types.ahk" {BITMAPINFO, BITMAPINFOHEADER, HDC, HMONITOR, PALETTEENTRY, RGBQUAD, RGNDATA}
#Import "..\Media\Types.ahk" {IReferenceClock, TIMECODE, TIMECODE_SAMPLE}
#Import "..\Media.Audio\Types.ahk" {WAVEFORMATEX}
#Import "..\Media.Audio.DirectSound\Types.ahk" {IDirectSound, IDirectSoundBuffer}
#Import "..\Media.MediaFoundation\Types.ahk" {AM_MEDIA_TYPE, DXVA2_AYUVSample16, DXVA2_AYUVSample8, DXVA2_ExtendedFormat, DXVA2_FilterValues, DXVA2_Fixed32, DXVA2_ProcAmpValues, DXVA2_ValueRange, DXVA2_VideoDesc, DXVA2_VideoProcessorCaps}
#Import "..\Media.WindowsMediaFormat\Types.ahk" {INSSBuffer3, IWMPlayerTimestampHook, IWMProfile}
#Import "..\System.Com\Types.ahk" {IBindCtx, IDispatch, IEnumMoniker, IErrorLog, IMoniker, IPersist, IUnknown, SAFEARRAY}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IPropertyBag}
#Import "..\System.Diagnostics.Etw\Types.ahk" {EVENT_TRACE_HEADER}
#Import "..\System.Ole\Types.ahk" {CAUUID}
#Import "..\System.Registry\Types.ahk" {HKEY}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HACCEL, SHOW_WINDOW_CMD}

struct OA_BOOL extends Int32 {
    static OATRUE := -1
    static OAFALSE := 0
}
struct MPEGLAYER3WAVEFORMAT_FLAGS extends UInt32 {
    static MPEGLAYER3_FLAG_PADDING_ISO := 0
    static MPEGLAYER3_FLAG_PADDING_ON := 1
    static MPEGLAYER3_FLAG_PADDING_OFF := 2
}
struct AMVP_SELECT_FORMAT_BY extends Int32 {
    static AMVP_DO_NOT_CARE := 0
    static AMVP_BEST_BANDWIDTH := 1
    static AMVP_INPUT_SAME_AS_OUTPUT := 2
}
struct AMVP_MODE extends Int32 {
    static AMVP_MODE_WEAVE := 0
    static AMVP_MODE_BOBINTERLEAVED := 1
    static AMVP_MODE_BOBNONINTERLEAVED := 2
    static AMVP_MODE_SKIPEVEN := 3
    static AMVP_MODE_SKIPODD := 4
}
struct AMVPSIZE {
    dwWidth : UInt32
    dwHeight : UInt32
}
struct AMVPDIMINFO {
    dwFieldWidth : UInt32
    dwFieldHeight : UInt32
    dwVBIWidth : UInt32
    dwVBIHeight : UInt32
    rcValidRegion : RECT
}
struct AMVPDATAINFO {
    dwSize : UInt32
    dwMicrosecondsPerField : UInt32
    amvpDimInfo : AMVPDIMINFO
    dwPictAspectRatioX : UInt32
    dwPictAspectRatioY : UInt32
    bEnableDoubleClock : BOOL
    bEnableVACT : BOOL
    bDataIsInterlaced : BOOL
    lHalfLinesOdd : Int32
    bFieldPolarityInverted : BOOL
    dwNumLinesInVREF : UInt32
    lHalfLinesEven : Int32
    dwReserved1 : UInt32
}
struct ICreateDevEnum extends IUnknown {
    static IID := "{29840822-5B84-11D0-BD3B-00A0C911CE86}"
    CreateClassEnumerator(clsidDeviceClass, ppEnumMoniker, dwFlags)
      => ComCall(3, this.p, GUID.Ptr, clsidDeviceClass, IEnumMoniker.Ptr, ppEnumMoniker, UInt32, dwFlags)
}
struct PIN_DIRECTION extends Int32 {
    static PINDIR_INPUT := 0
    static PINDIR_OUTPUT := 1
}
struct ALLOCATOR_PROPERTIES {
    cBuffers : Int32
    cbBuffer : Int32
    cbAlign : Int32
    cbPrefix : Int32
}
struct PIN_INFO {
    pFilter : IBaseFilter
    dir : PIN_DIRECTION
    achName : UInt16[128]
}
struct IPin extends IUnknown {
    static IID := "{56A86891-0AD4-11CE-B03A-0020AF0BA770}"
    Connect(pReceivePin, pmt?)
      => ComCall(3, this.p, IPin, pReceivePin, AM_MEDIA_TYPE.Ptr, pmt?)
    ReceiveConnection(pConnector, pmt)
      => ComCall(4, this.p, IPin, pConnector, AM_MEDIA_TYPE.Ptr, pmt)
    Disconnect()
      => ComCall(5, this.p)
    ConnectedTo(pPin)
      => ComCall(6, this.p, IPin.Ptr, pPin)
    ConnectionMediaType(pmt)
      => ComCall(7, this.p, AM_MEDIA_TYPE.Ptr, pmt)
    QueryPinInfo(pInfo)
      => ComCall(8, this.p, PIN_INFO.Ptr, pInfo)
    QueryDirection(pPinDir)
      => ComCall(9, this.p, PIN_DIRECTION.Ptr, pPinDir)
    QueryId(Id)
      => ComCall(10, this.p, PWSTR.Ptr, Id)
    QueryAccept(pmt)
      => ComCall(11, this.p, AM_MEDIA_TYPE.Ptr, pmt)
    EnumMediaTypes(ppEnum)
      => ComCall(12, this.p, IEnumMediaTypes.Ptr, ppEnum)
    QueryInternalConnections(apPin?)
      => ComCall(13, this.p, IPin.Ptr, apPin?, UInt32.Ptr, apPin?.Length ?? 0)
    EndOfStream()
      => ComCall(14, this.p)
    BeginFlush()
      => ComCall(15, this.p)
    EndFlush()
      => ComCall(16, this.p)
    NewSegment(tStart, tStop, dRate)
      => ComCall(17, this.p, Int64, tStart, Int64, tStop, Float64, dRate)
}
struct IEnumPins extends IUnknown {
    static IID := "{56A86892-0AD4-11CE-B03A-0020AF0BA770}"
    Next(ppPins, pcFetched?)
      => ComCall(3, this.p, UInt32, ppPins.Length, IPin.Ptr, ppPins, UInt32.Ptr, pcFetched?)
    Skip(cPins)
      => ComCall(4, this.p, UInt32, cPins)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumPins.Ptr, ppEnum)
}
struct IEnumMediaTypes extends IUnknown {
    static IID := "{89C31040-846B-11CE-97D3-00AA0055595A}"
    Next(ppMediaTypes, pcFetched?)
      => ComCall(3, this.p, UInt32, ppMediaTypes.Length, AM_MEDIA_TYPE.Ptr.Ptr, ppMediaTypes, UInt32.Ptr, pcFetched?)
    Skip(cMediaTypes)
      => ComCall(4, this.p, UInt32, cMediaTypes)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumMediaTypes.Ptr, ppEnum)
}
struct IFilterGraph extends IUnknown {
    static IID := "{56A8689F-0AD4-11CE-B03A-0020AF0BA770}"
    AddFilter(pFilter, pName)
      => ComCall(3, this.p, IBaseFilter, pFilter, "Str", pName)
    RemoveFilter(pFilter)
      => ComCall(4, this.p, IBaseFilter, pFilter)
    EnumFilters(ppEnum)
      => ComCall(5, this.p, IEnumFilters.Ptr, ppEnum)
    FindFilterByName(pName, ppFilter)
      => ComCall(6, this.p, "Str", pName, IBaseFilter.Ptr, ppFilter)
    ConnectDirect(ppinOut, ppinIn, pmt?)
      => ComCall(7, this.p, IPin, ppinOut, IPin, ppinIn, AM_MEDIA_TYPE.Ptr, pmt?)
    Reconnect(ppin)
      => ComCall(8, this.p, IPin, ppin)
    Disconnect(ppin)
      => ComCall(9, this.p, IPin, ppin)
    SetDefaultSyncSource()
      => ComCall(10, this.p)
}
struct IEnumFilters extends IUnknown {
    static IID := "{56A86893-0AD4-11CE-B03A-0020AF0BA770}"
    Next(ppFilter, pcFetched?)
      => ComCall(3, this.p, UInt32, ppFilter.Length, IBaseFilter.Ptr, ppFilter, UInt32.Ptr, pcFetched?)
    Skip(cFilters)
      => ComCall(4, this.p, UInt32, cFilters)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumFilters.Ptr, ppEnum)
}
struct FILTER_STATE extends Int32 {
    static State_Stopped := 0
    static State_Paused := 1
    static State_Running := 2
}
struct IMediaFilter extends IPersist {
    static IID := "{56A86899-0AD4-11CE-B03A-0020AF0BA770}"
    Stop()
      => ComCall(4, this.p)
    Pause()
      => ComCall(5, this.p)
    Run(tStart)
      => ComCall(6, this.p, Int64, tStart)
    GetState(dwMilliSecsTimeout, State)
      => ComCall(7, this.p, UInt32, dwMilliSecsTimeout, FILTER_STATE.Ptr, State)
    SetSyncSource(pClock?)
      => ComCall(8, this.p, IReferenceClock, pClock?)
    GetSyncSource(pClock)
      => ComCall(9, this.p, IReferenceClock.Ptr, pClock)
}
struct FILTER_INFO {
    achName : UInt16[128]
    pGraph : IFilterGraph
}
struct IBaseFilter extends IMediaFilter {
    static IID := "{56A86895-0AD4-11CE-B03A-0020AF0BA770}"
    EnumPins(ppEnum)
      => ComCall(10, this.p, IEnumPins.Ptr, ppEnum)
    FindPin(Id, ppPin)
      => ComCall(11, this.p, "Str", Id, IPin.Ptr, ppPin)
    QueryFilterInfo(pInfo)
      => ComCall(12, this.p, FILTER_INFO.Ptr, pInfo)
    JoinFilterGraph(pGraph?, pName?)
      => ComCall(13, this.p, IFilterGraph, pGraph?, "Str", pName?)
    QueryVendorInfo(pVendorInfo)
      => ComCall(14, this.p, PWSTR.Ptr, pVendorInfo)
}
struct IMediaSample extends IUnknown {
    static IID := "{56A8689A-0AD4-11CE-B03A-0020AF0BA770}"
    GetPointer(ppBuffer)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, ppBuffer)
    GetSize()
      => ComCall(4, this.p, Int32)
    GetTime(pTimeStart, pTimeEnd)
      => ComCall(5, this.p, Int64.Ptr, pTimeStart, Int64.Ptr, pTimeEnd)
    SetTime(pTimeStart?, pTimeEnd?)
      => ComCall(6, this.p, Int64.Ptr, pTimeStart?, Int64.Ptr, pTimeEnd?)
    IsSyncPoint()
      => ComCall(7, this.p)
    SetSyncPoint(bIsSyncPoint)
      => ComCall(8, this.p, BOOL, bIsSyncPoint)
    IsPreroll()
      => ComCall(9, this.p)
    SetPreroll(bIsPreroll)
      => ComCall(10, this.p, BOOL, bIsPreroll)
    GetActualDataLength()
      => ComCall(11, this.p, Int32)
    SetActualDataLength(__MIDL__IMediaSample0000)
      => ComCall(12, this.p, Int32, __MIDL__IMediaSample0000)
    GetMediaType(ppMediaType)
      => ComCall(13, this.p, AM_MEDIA_TYPE.Ptr.Ptr, ppMediaType)
    SetMediaType(pMediaType)
      => ComCall(14, this.p, AM_MEDIA_TYPE.Ptr, pMediaType)
    IsDiscontinuity()
      => ComCall(15, this.p)
    SetDiscontinuity(bDiscontinuity)
      => ComCall(16, this.p, BOOL, bDiscontinuity)
    GetMediaTime(pTimeStart, pTimeEnd)
      => ComCall(17, this.p, Int64.Ptr, pTimeStart, Int64.Ptr, pTimeEnd)
    SetMediaTime(pTimeStart?, pTimeEnd?)
      => ComCall(18, this.p, Int64.Ptr, pTimeStart?, Int64.Ptr, pTimeEnd?)
}
struct AM_SAMPLE_PROPERTY_FLAGS extends Int32 {
    static AM_SAMPLE_SPLICEPOINT := 1
    static AM_SAMPLE_PREROLL := 2
    static AM_SAMPLE_DATADISCONTINUITY := 4
    static AM_SAMPLE_TYPECHANGED := 8
    static AM_SAMPLE_TIMEVALID := 16
    static AM_SAMPLE_TIMEDISCONTINUITY := 64
    static AM_SAMPLE_FLUSH_ON_PAUSE := 128
    static AM_SAMPLE_STOPVALID := 256
    static AM_SAMPLE_ENDOFSTREAM := 512
    static AM_STREAM_MEDIA := 0
    static AM_STREAM_CONTROL := 1
}
struct AM_SAMPLE2_PROPERTIES {
    cbData : UInt32
    dwTypeSpecificFlags : UInt32
    dwSampleFlags : UInt32
    lActual : Int32
    tStart : Int64
    tStop : Int64
    dwStreamId : UInt32
    pMediaType : AM_MEDIA_TYPE.Ptr
    pbBuffer : UInt8.Ptr
    cbBuffer : Int32
}
struct IMediaSample2 extends IMediaSample {
    static IID := "{36B73884-C2C8-11CF-8B46-00805F6CEF60}"
    GetProperties(pbProperties)
      => ComCall(19, this.p, UInt32, pbProperties.Size, UInt8.Ptr, pbProperties)
    SetProperties(pbProperties)
      => ComCall(20, this.p, UInt32, pbProperties.Size, UInt8.Ptr, pbProperties)
}
struct IMediaSample2Config extends IUnknown {
    static IID := "{68961E68-832B-41EA-BC91-63593F3E70E3}"
    GetSurface(ppDirect3DSurface9)
      => ComCall(3, this.p, IUnknown.Ptr, ppDirect3DSurface9)
}
struct IMemAllocator extends IUnknown {
    static IID := "{56A8689C-0AD4-11CE-B03A-0020AF0BA770}"
    SetProperties(pRequest, pActual)
      => ComCall(3, this.p, ALLOCATOR_PROPERTIES.Ptr, pRequest, ALLOCATOR_PROPERTIES.Ptr, pActual)
    GetProperties(pProps)
      => ComCall(4, this.p, ALLOCATOR_PROPERTIES.Ptr, pProps)
    Commit()
      => ComCall(5, this.p)
    Decommit()
      => ComCall(6, this.p)
    GetBuffer(ppBuffer, pStartTime?, pEndTime?, dwFlags)
      => ComCall(7, this.p, IMediaSample.Ptr, ppBuffer, Int64.Ptr, pStartTime?, Int64.Ptr, pEndTime?, UInt32, dwFlags)
    ReleaseBuffer(pBuffer)
      => ComCall(8, this.p, IMediaSample, pBuffer)
}
struct IMemAllocatorCallbackTemp extends IMemAllocator {
    static IID := "{379A0CF0-C1DE-11D2-ABF5-00A0C905F375}"
    SetNotify(pNotify)
      => ComCall(9, this.p, IMemAllocatorNotifyCallbackTemp, pNotify)
    GetFreeCount(plBuffersFree)
      => ComCall(10, this.p, Int32.Ptr, plBuffersFree)
}
struct IMemAllocatorNotifyCallbackTemp extends IUnknown {
    static IID := "{92980B30-C1DE-11D2-ABF5-00A0C905F375}"
    NotifyRelease()
      => ComCall(3, this.p)
}
struct IMemInputPin extends IUnknown {
    static IID := "{56A8689D-0AD4-11CE-B03A-0020AF0BA770}"
    GetAllocator(ppAllocator)
      => ComCall(3, this.p, IMemAllocator.Ptr, ppAllocator)
    NotifyAllocator(pAllocator, bReadOnly)
      => ComCall(4, this.p, IMemAllocator, pAllocator, BOOL, bReadOnly)
    GetAllocatorRequirements(pProps)
      => ComCall(5, this.p, ALLOCATOR_PROPERTIES.Ptr, pProps)
    Receive(pSample)
      => ComCall(6, this.p, IMediaSample, pSample)
    ReceiveMultiple(pSamples, nSamplesProcessed)
      => ComCall(7, this.p, IMediaSample.Ptr, pSamples, Int32, pSamples.Length, Int32.Ptr, nSamplesProcessed)
    ReceiveCanBlock()
      => ComCall(8, this.p)
}
struct IAMovieSetup extends IUnknown {
    static IID := "{A3D8CEC0-7E5A-11CF-BBC5-00805F6CEF20}"
    Register()
      => ComCall(3, this.p)
    Unregister()
      => ComCall(4, this.p)
}
struct AM_SEEKING_SEEKING_FLAGS extends Int32 {
    static AM_SEEKING_NoPositioning := 0
    static AM_SEEKING_AbsolutePositioning := 1
    static AM_SEEKING_RelativePositioning := 2
    static AM_SEEKING_IncrementalPositioning := 3
    static AM_SEEKING_PositioningBitsMask := 3
    static AM_SEEKING_SeekToKeyFrame := 4
    static AM_SEEKING_ReturnTime := 8
    static AM_SEEKING_Segment := 16
    static AM_SEEKING_NoFlush := 32
}
struct AM_SEEKING_SEEKING_CAPABILITIES extends Int32 {
    static AM_SEEKING_CanSeekAbsolute := 1
    static AM_SEEKING_CanSeekForwards := 2
    static AM_SEEKING_CanSeekBackwards := 4
    static AM_SEEKING_CanGetCurrentPos := 8
    static AM_SEEKING_CanGetStopPos := 16
    static AM_SEEKING_CanGetDuration := 32
    static AM_SEEKING_CanPlayBackwards := 64
    static AM_SEEKING_CanDoSegments := 128
    static AM_SEEKING_Source := 256
}
struct IMediaSeeking extends IUnknown {
    static IID := "{36B73880-C2C8-11CF-8B46-00805F6CEF60}"
    GetCapabilities(pCapabilities)
      => ComCall(3, this.p, UInt32.Ptr, pCapabilities)
    CheckCapabilities(pCapabilities)
      => ComCall(4, this.p, UInt32.Ptr, pCapabilities)
    IsFormatSupported(pFormat)
      => ComCall(5, this.p, GUID.Ptr, pFormat)
    QueryPreferredFormat(pFormat)
      => ComCall(6, this.p, GUID.Ptr, pFormat)
    GetTimeFormat(pFormat)
      => ComCall(7, this.p, GUID.Ptr, pFormat)
    IsUsingTimeFormat(pFormat)
      => ComCall(8, this.p, GUID.Ptr, pFormat)
    SetTimeFormat(pFormat)
      => ComCall(9, this.p, GUID.Ptr, pFormat)
    GetDuration(pDuration)
      => ComCall(10, this.p, Int64.Ptr, pDuration)
    GetStopPosition(pStop)
      => ComCall(11, this.p, Int64.Ptr, pStop)
    GetCurrentPosition(pCurrent)
      => ComCall(12, this.p, Int64.Ptr, pCurrent)
    ConvertTimeFormat(pTarget, pTargetFormat?, Source, pSourceFormat?)
      => ComCall(13, this.p, Int64.Ptr, pTarget, GUID.Ptr, pTargetFormat?, Int64, Source, GUID.Ptr, pSourceFormat?)
    SetPositions(pCurrent?, dwCurrentFlags, pStop?, dwStopFlags)
      => ComCall(14, this.p, Int64.Ptr, pCurrent?, UInt32, dwCurrentFlags, Int64.Ptr, pStop?, UInt32, dwStopFlags)
    GetPositions(pCurrent?, pStop?)
      => ComCall(15, this.p, Int64.Ptr, pCurrent?, Int64.Ptr, pStop?)
    GetAvailable(pEarliest?, pLatest?)
      => ComCall(16, this.p, Int64.Ptr, pEarliest?, Int64.Ptr, pLatest?)
    SetRate(dRate)
      => ComCall(17, this.p, Float64, dRate)
    GetRate(pdRate)
      => ComCall(18, this.p, Float64.Ptr, pdRate)
    GetPreroll(pllPreroll)
      => ComCall(19, this.p, Int64.Ptr, pllPreroll)
}
struct AM_MEDIAEVENT_FLAGS extends Int32 {
    static AM_MEDIAEVENT_NONOTIFY := 1
}
struct REGFILTER {
    Clsid : GUID
    Name : PWSTR
}
struct IEnumRegFilters extends IUnknown {
    static IID := "{56A868A4-0AD4-11CE-B03A-0020AF0BA770}"
    Next(apRegFilter, pcFetched?)
      => ComCall(3, this.p, UInt32, apRegFilter.Length, REGFILTER.Ptr.Ptr, apRegFilter, UInt32.Ptr, pcFetched?)
    Skip(cFilters)
      => ComCall(4, this.p, UInt32, cFilters)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumRegFilters.Ptr, ppEnum)
}
struct IFILTERMAPPER_MERIT extends Int32 {
    static MERIT_PREFERRED := 8388608
    static MERIT_NORMAL := 6291456
    static MERIT_UNLIKELY := 4194304
    static MERIT_DO_NOT_USE := 2097152
    static MERIT_SW_COMPRESSOR := 1048576
    static MERIT_HW_COMPRESSOR := 1048656
}
struct IFilterMapper extends IUnknown {
    static IID := "{56A868A3-0AD4-11CE-B03A-0020AF0BA770}"
    RegisterFilter(clsid, Name, dwMerit)
      => ComCall(3, this.p, GUID, clsid, "Str", Name, UInt32, dwMerit)
    RegisterFilterInstance(clsid, Name, MRId)
      => ComCall(4, this.p, GUID, clsid, "Str", Name, GUID.Ptr, MRId)
    RegisterPin(Filter, Name, bRendered, bOutput, bZero, bMany, ConnectsToFilter, ConnectsToPin)
      => ComCall(5, this.p, GUID, Filter, "Str", Name, BOOL, bRendered, BOOL, bOutput, BOOL, bZero, BOOL, bMany, GUID, ConnectsToFilter, "Str", ConnectsToPin)
    RegisterPinType(clsFilter, strName, clsMajorType, clsSubType)
      => ComCall(6, this.p, GUID, clsFilter, "Str", strName, GUID, clsMajorType, GUID, clsSubType)
    UnregisterFilter(Filter)
      => ComCall(7, this.p, GUID, Filter)
    UnregisterFilterInstance(MRId)
      => ComCall(8, this.p, GUID, MRId)
    UnregisterPin(Filter, Name)
      => ComCall(9, this.p, GUID, Filter, "Str", Name)
    EnumMatchingFilters(ppEnum, dwMerit, bInputNeeded, clsInMaj, clsInSub, bRender, bOututNeeded, clsOutMaj, clsOutSub)
      => ComCall(10, this.p, IEnumRegFilters.Ptr, ppEnum, UInt32, dwMerit, BOOL, bInputNeeded, GUID, clsInMaj, GUID, clsInSub, BOOL, bRender, BOOL, bOututNeeded, GUID, clsOutMaj, GUID, clsOutSub)
}
struct REGPINTYPES {
    clsMajorType : GUID.Ptr
    clsMinorType : GUID.Ptr
}
struct REGFILTERPINS {
    strName : PWSTR
    bRendered : BOOL
    bOutput : BOOL
    bZero : BOOL
    bMany : BOOL
    clsConnectsToFilter : GUID.Ptr
    strConnectsToPin : PWSTR
    nMediaTypes : UInt32
    lpMediaType : REGPINTYPES.Ptr
}
struct REGPINMEDIUM {
    clsMedium : GUID
    dw1 : UInt32
    dw2 : UInt32
}
struct REG_PINFLAG extends Int32 {
    static REG_PINFLAG_B_ZERO := 1
    static REG_PINFLAG_B_RENDERER := 2
    static REG_PINFLAG_B_MANY := 4
    static REG_PINFLAG_B_OUTPUT := 8
}
struct REGFILTERPINS2 {
    dwFlags : UInt32
    cInstances : UInt32
    nMediaTypes : UInt32
    lpMediaType : REGPINTYPES.Ptr
    nMediums : UInt32
    lpMedium : REGPINMEDIUM.Ptr
    clsPinCategory : GUID.Ptr
}
struct REGFILTER2 {
    dwVersion : UInt32
    dwMerit : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
        }
        struct _Anonymous1_e__Struct {
            cPins : UInt32
            rgPins : REGFILTERPINS.Ptr
        }
        struct _Anonymous2_e__Struct {
            cPins2 : UInt32
            rgPins2 : REGFILTERPINS2.Ptr
        }
    }
}
struct IFilterMapper2 extends IUnknown {
    static IID := "{B79BB0B0-33C1-11D1-ABE1-00A0C905F375}"
    CreateCategory(clsidCategory, dwCategoryMerit, Description)
      => ComCall(3, this.p, GUID.Ptr, clsidCategory, UInt32, dwCategoryMerit, "Str", Description)
    UnregisterFilter(pclsidCategory, szInstance, Filter)
      => ComCall(4, this.p, GUID.Ptr, pclsidCategory, "Str", szInstance, GUID.Ptr, Filter)
    RegisterFilter(clsidFilter, Name, ppMoniker?, pclsidCategory, szInstance, prf2)
      => ComCall(5, this.p, GUID.Ptr, clsidFilter, "Str", Name, IMoniker.Ptr, ppMoniker?, GUID.Ptr, pclsidCategory, "Str", szInstance, REGFILTER2.Ptr, prf2)
    EnumMatchingFilters(ppEnum, dwFlags, bExactMatch, dwMerit, bInputNeeded, cInputTypes, pInputTypes?, pMedIn?, pPinCategoryIn?, bRender, bOutputNeeded, cOutputTypes, pOutputTypes?, pMedOut?, pPinCategoryOut?)
      => ComCall(6, this.p, IEnumMoniker.Ptr, ppEnum, UInt32, dwFlags, BOOL, bExactMatch, UInt32, dwMerit, BOOL, bInputNeeded, UInt32, cInputTypes, GUID.Ptr, pInputTypes?, REGPINMEDIUM.Ptr, pMedIn?, GUID.Ptr, pPinCategoryIn?, BOOL, bRender, BOOL, bOutputNeeded, UInt32, cOutputTypes, GUID.Ptr, pOutputTypes?, REGPINMEDIUM.Ptr, pMedOut?, GUID.Ptr, pPinCategoryOut?)
}
struct IFilterMapper3 extends IFilterMapper2 {
    static IID := "{B79BB0B1-33C1-11D1-ABE1-00A0C905F375}"
    GetICreateDevEnum(ppEnum)
      => ComCall(7, this.p, ICreateDevEnum.Ptr, ppEnum)
}
struct QualityMessageType extends Int32 {
    static Famine := 0
    static Flood := 1
}
struct Quality {
    Type : QualityMessageType
    Proportion : Int32
    Late : Int64
    TimeStamp : Int64
}
struct IQualityControl extends IUnknown {
    static IID := "{56A868A5-0AD4-11CE-B03A-0020AF0BA770}"
    Notify(pSelf, q)
      => ComCall(3, this.p, IBaseFilter, pSelf, Quality, q)
    SetSink(piqc)
      => ComCall(4, this.p, IQualityControl, piqc)
}
struct COLORKEY_TYPE extends Int32 {
    static CK_NOCOLORKEY := 0
    static CK_INDEX := 1
    static CK_RGB := 2
}
struct COLORKEY {
    KeyType : UInt32
    PaletteIndex : UInt32
    LowColorValue : COLORREF
    HighColorValue : COLORREF
}
struct ADVISE_TYPE extends Int32 {
    static ADVISE_NONE := 0
    static ADVISE_CLIPPING := 1
    static ADVISE_PALETTE := 2
    static ADVISE_COLORKEY := 4
    static ADVISE_POSITION := 8
    static ADVISE_DISPLAY_CHANGE := 16
}
struct IOverlayNotify extends IUnknown {
    static IID := "{56A868A0-0AD4-11CE-B03A-0020AF0BA770}"
    OnPaletteChange(dwColors, pPalette)
      => ComCall(3, this.p, UInt32, dwColors, PALETTEENTRY.Ptr, pPalette)
    OnClipChange(pSourceRect, pDestinationRect, pRgnData)
      => ComCall(4, this.p, RECT.Ptr, pSourceRect, RECT.Ptr, pDestinationRect, RGNDATA.Ptr, pRgnData)
    OnColorKeyChange(pColorKey)
      => ComCall(5, this.p, COLORKEY.Ptr, pColorKey)
    OnPositionChange(pSourceRect, pDestinationRect)
      => ComCall(6, this.p, RECT.Ptr, pSourceRect, RECT.Ptr, pDestinationRect)
}
struct IOverlayNotify2 extends IOverlayNotify {
    static IID := "{680EFA10-D535-11D1-87C8-00A0C9223196}"
    OnDisplayChange(hMonitor1)
      => ComCall(7, this.p, HMONITOR, hMonitor1)
}
struct IOverlay extends IUnknown {
    static IID := "{56A868A1-0AD4-11CE-B03A-0020AF0BA770}"
    GetPalette(pdwColors, ppPalette)
      => ComCall(3, this.p, UInt32.Ptr, pdwColors, PALETTEENTRY.Ptr.Ptr, ppPalette)
    SetPalette(pPalette)
      => ComCall(4, this.p, UInt32, pPalette.Length, PALETTEENTRY.Ptr, pPalette)
    GetDefaultColorKey(pColorKey)
      => ComCall(5, this.p, COLORKEY.Ptr, pColorKey)
    GetColorKey(pColorKey)
      => ComCall(6, this.p, COLORKEY.Ptr, pColorKey)
    SetColorKey(pColorKey)
      => ComCall(7, this.p, COLORKEY.Ptr, pColorKey)
    GetWindowHandle(pHwnd)
      => ComCall(8, this.p, HWND.Ptr, pHwnd)
    GetClipList(pSourceRect, pDestinationRect, ppRgnData)
      => ComCall(9, this.p, RECT.Ptr, pSourceRect, RECT.Ptr, pDestinationRect, RGNDATA.Ptr.Ptr, ppRgnData)
    GetVideoPosition(pSourceRect, pDestinationRect)
      => ComCall(10, this.p, RECT.Ptr, pSourceRect, RECT.Ptr, pDestinationRect)
    Advise(pOverlayNotify, dwInterests)
      => ComCall(11, this.p, IOverlayNotify, pOverlayNotify, UInt32, dwInterests)
    Unadvise()
      => ComCall(12, this.p)
}
struct IMediaEventSink extends IUnknown {
    static IID := "{56A868A2-0AD4-11CE-B03A-0020AF0BA770}"
    Notify(EventCode, EventParam1, EventParam2)
      => ComCall(3, this.p, Int32, EventCode, IntPtr, EventParam1, IntPtr, EventParam2)
}
struct IFileSourceFilter extends IUnknown {
    static IID := "{56A868A6-0AD4-11CE-B03A-0020AF0BA770}"
    Load(pszFileName, pmt?)
      => ComCall(3, this.p, "Str", pszFileName, AM_MEDIA_TYPE.Ptr, pmt?)
    GetCurFile(ppszFileName, pmt?)
      => ComCall(4, this.p, PWSTR.Ptr, ppszFileName, AM_MEDIA_TYPE.Ptr, pmt?)
}
struct IFileSinkFilter extends IUnknown {
    static IID := "{A2104830-7C70-11CF-8BCE-00AA00A3F1A6}"
    SetFileName(pszFileName, pmt?)
      => ComCall(3, this.p, "Str", pszFileName, AM_MEDIA_TYPE.Ptr, pmt?)
    GetCurFile(ppszFileName, pmt)
      => ComCall(4, this.p, PWSTR.Ptr, ppszFileName, AM_MEDIA_TYPE.Ptr, pmt)
}
struct IFileSinkFilter2 extends IFileSinkFilter {
    static IID := "{00855B90-CE1B-11D0-BD4F-00A0C911CE86}"
    SetMode(dwFlags)
      => ComCall(5, this.p, UInt32, dwFlags)
    GetMode(pdwFlags)
      => ComCall(6, this.p, UInt32.Ptr, pdwFlags)
}
struct AM_FILESINK_FLAGS extends Int32 {
    static AM_FILE_OVERWRITE := 1
}
struct IGraphBuilder extends IFilterGraph {
    static IID := "{56A868A9-0AD4-11CE-B03A-0020AF0BA770}"
    Connect(ppinOut, ppinIn)
      => ComCall(11, this.p, IPin, ppinOut, IPin, ppinIn)
    Render(ppinOut)
      => ComCall(12, this.p, IPin, ppinOut)
    RenderFile(lpcwstrFile, lpcwstrPlayList?)
      => ComCall(13, this.p, "Str", lpcwstrFile, "Str", lpcwstrPlayList?)
    AddSourceFilter(lpcwstrFileName, lpcwstrFilterName?, ppFilter)
      => ComCall(14, this.p, "Str", lpcwstrFileName, "Str", lpcwstrFilterName?, IBaseFilter.Ptr, ppFilter)
    SetLogFile(hFile)
      => ComCall(15, this.p, IntPtr, hFile)
    Abort()
      => ComCall(16, this.p)
    ShouldOperationContinue()
      => ComCall(17, this.p)
}
struct ICaptureGraphBuilder extends IUnknown {
    static IID := "{BF87B6E0-8C27-11D0-B3F0-00AA003761C5}"
    SetFiltergraph(pfg)
      => ComCall(3, this.p, IGraphBuilder, pfg)
    GetFiltergraph(ppfg)
      => ComCall(4, this.p, IGraphBuilder.Ptr, ppfg)
    SetOutputFileName(pType, lpstrFile, ppf, ppSink)
      => ComCall(5, this.p, GUID.Ptr, pType, "Str", lpstrFile, IBaseFilter.Ptr, ppf, IFileSinkFilter.Ptr, ppSink)
    FindInterface(pCategory?, pf, riid, ppint)
      => ComCall(6, this.p, GUID.Ptr, pCategory?, IBaseFilter, pf, GUID.Ptr, riid, Struct.Ptr.Ptr, ppint)
    RenderStream(pCategory?, pSource, pfCompressor, pfRenderer)
      => ComCall(7, this.p, GUID.Ptr, pCategory?, IUnknown, pSource, IBaseFilter, pfCompressor, IBaseFilter, pfRenderer)
    ControlStream(pCategory?, pFilter, pstart, pstop, wStartCookie, wStopCookie)
      => ComCall(8, this.p, GUID.Ptr, pCategory?, IBaseFilter, pFilter, Int64.Ptr, pstart, Int64.Ptr, pstop, UInt16, wStartCookie, UInt16, wStopCookie)
    AllocCapFile(lpstr, dwlSize)
      => ComCall(9, this.p, "Str", lpstr, Int64, dwlSize)
    CopyCaptureFile(lpwstrOld, lpwstrNew, fAllowEscAbort, pCallback)
      => ComCall(10, this.p, "Str", lpwstrOld, "Str", lpwstrNew, Int32, fAllowEscAbort, IAMCopyCaptureFileProgress, pCallback)
}
struct IAMCopyCaptureFileProgress extends IUnknown {
    static IID := "{670D1D20-A068-11D0-B3F0-00AA003761C5}"
    Progress(iProgress)
      => ComCall(3, this.p, Int32, iProgress)
}
struct ICaptureGraphBuilder2 extends IUnknown {
    static IID := "{93E5A4E0-2D50-11D2-ABFA-00A0C9C6E38D}"
    SetFiltergraph(pfg)
      => ComCall(3, this.p, IGraphBuilder, pfg)
    GetFiltergraph(ppfg)
      => ComCall(4, this.p, IGraphBuilder.Ptr, ppfg)
    SetOutputFileName(pType, lpstrFile, ppf, ppSink?)
      => ComCall(5, this.p, GUID.Ptr, pType, "Str", lpstrFile, IBaseFilter.Ptr, ppf, IFileSinkFilter.Ptr, ppSink?)
    FindInterface(pCategory?, pType?, pf, riid, ppint)
      => ComCall(6, this.p, GUID.Ptr, pCategory?, GUID.Ptr, pType?, IBaseFilter, pf, GUID.Ptr, riid, Struct.Ptr.Ptr, ppint)
    RenderStream(pCategory?, pType, pSource, pfCompressor, pfRenderer)
      => ComCall(7, this.p, GUID.Ptr, pCategory?, GUID.Ptr, pType, IUnknown, pSource, IBaseFilter, pfCompressor, IBaseFilter, pfRenderer)
    ControlStream(pCategory, pType, pFilter, pstart?, pstop?, wStartCookie, wStopCookie)
      => ComCall(8, this.p, GUID.Ptr, pCategory, GUID.Ptr, pType, IBaseFilter, pFilter, Int64.Ptr, pstart?, Int64.Ptr, pstop?, UInt16, wStartCookie, UInt16, wStopCookie)
    AllocCapFile(lpstr, dwlSize)
      => ComCall(9, this.p, "Str", lpstr, Int64, dwlSize)
    CopyCaptureFile(lpwstrOld, lpwstrNew, fAllowEscAbort, pCallback)
      => ComCall(10, this.p, "Str", lpwstrOld, "Str", lpwstrNew, Int32, fAllowEscAbort, IAMCopyCaptureFileProgress, pCallback)
    FindPin(pSource, pindir, pCategory?, pType?, fUnconnected, num, ppPin)
      => ComCall(11, this.p, IUnknown, pSource, PIN_DIRECTION, pindir, GUID.Ptr, pCategory?, GUID.Ptr, pType?, BOOL, fUnconnected, Int32, num, IPin.Ptr, ppPin)
}
struct AM_RENSDEREXFLAGS extends Int32 {
    static AM_RENDEREX_RENDERTOEXISTINGRENDERERS := 1
}
struct IFilterGraph2 extends IGraphBuilder {
    static IID := "{36B73882-C2C8-11CF-8B46-00805F6CEF60}"
    AddSourceFilterForMoniker(pMoniker, pCtx, lpcwstrFilterName, ppFilter)
      => ComCall(18, this.p, IMoniker, pMoniker, IBindCtx, pCtx, "Str", lpcwstrFilterName, IBaseFilter.Ptr, ppFilter)
    ReconnectEx(ppin, pmt?)
      => ComCall(19, this.p, IPin, ppin, AM_MEDIA_TYPE.Ptr, pmt?)
    RenderEx(pPinOut, dwFlags)
      => ComCall(20, this.p, IPin, pPinOut, UInt32, dwFlags, "Ptr", 0)
}
struct IFilterGraph3 extends IFilterGraph2 {
    static IID := "{AAF38154-B80B-422F-91E6-B66467509A07}"
    SetSyncSourceEx(pClockForMostOfFilterGraph, pClockForFilter, pFilter)
      => ComCall(21, this.p, IReferenceClock, pClockForMostOfFilterGraph, IReferenceClock, pClockForFilter, IBaseFilter, pFilter)
}
struct IStreamBuilder extends IUnknown {
    static IID := "{56A868BF-0AD4-11CE-B03A-0020AF0BA770}"
    Render(ppinOut, pGraph)
      => ComCall(3, this.p, IPin, ppinOut, IGraphBuilder, pGraph)
    Backout(ppinOut, pGraph)
      => ComCall(4, this.p, IPin, ppinOut, IGraphBuilder, pGraph)
}
struct IAsyncReader extends IUnknown {
    static IID := "{56A868AA-0AD4-11CE-B03A-0020AF0BA770}"
    RequestAllocator(pPreferred, pProps, ppActual)
      => ComCall(3, this.p, IMemAllocator, pPreferred, ALLOCATOR_PROPERTIES.Ptr, pProps, IMemAllocator.Ptr, ppActual)
    Request(pSample, dwUser)
      => ComCall(4, this.p, IMediaSample, pSample, IntPtr, dwUser)
    WaitForNext(dwTimeout, ppSample?, pdwUser)
      => ComCall(5, this.p, UInt32, dwTimeout, IMediaSample.Ptr, ppSample?, IntPtr.Ptr, pdwUser)
    SyncReadAligned(pSample)
      => ComCall(6, this.p, IMediaSample, pSample)
    SyncRead(llPosition, pBuffer)
      => ComCall(7, this.p, Int64, llPosition, Int32, pBuffer.Size, UInt8.Ptr, pBuffer)
    Length(pTotal, pAvailable)
      => ComCall(8, this.p, Int64.Ptr, pTotal, Int64.Ptr, pAvailable)
    BeginFlush()
      => ComCall(9, this.p)
    EndFlush()
      => ComCall(10, this.p)
}
struct IGraphVersion extends IUnknown {
    static IID := "{56A868AB-0AD4-11CE-B03A-0020AF0BA770}"
    QueryVersion(pVersion)
      => ComCall(3, this.p, Int32.Ptr, pVersion)
}
struct IResourceConsumer extends IUnknown {
    static IID := "{56A868AD-0AD4-11CE-B03A-0020AF0BA770}"
    AcquireResource(idResource)
      => ComCall(3, this.p, Int32, idResource)
    ReleaseResource(idResource)
      => ComCall(4, this.p, Int32, idResource)
}
struct IResourceManager extends IUnknown {
    static IID := "{56A868AC-0AD4-11CE-B03A-0020AF0BA770}"
    Register(pName, cResource, plToken)
      => ComCall(3, this.p, "Str", pName, Int32, cResource, Int32.Ptr, plToken)
    RegisterGroup(pName, palTokens, plToken)
      => ComCall(4, this.p, "Str", pName, Int32, palTokens.Length, Int32.Ptr, palTokens, Int32.Ptr, plToken)
    RequestResource(idResource, pFocusObject, pConsumer)
      => ComCall(5, this.p, Int32, idResource, IUnknown, pFocusObject, IResourceConsumer, pConsumer)
    NotifyAcquire(idResource, pConsumer, hr)
      => ComCall(6, this.p, Int32, idResource, IResourceConsumer, pConsumer, HRESULT, hr)
    NotifyRelease(idResource, pConsumer, bStillWant)
      => ComCall(7, this.p, Int32, idResource, IResourceConsumer, pConsumer, BOOL, bStillWant)
    CancelRequest(idResource, pConsumer)
      => ComCall(8, this.p, Int32, idResource, IResourceConsumer, pConsumer)
    SetFocus(pFocusObject)
      => ComCall(9, this.p, IUnknown, pFocusObject)
    ReleaseFocus(pFocusObject)
      => ComCall(10, this.p, IUnknown, pFocusObject)
}
struct IDistributorNotify extends IUnknown {
    static IID := "{56A868AF-0AD4-11CE-B03A-0020AF0BA770}"
    Stop()
      => ComCall(3, this.p)
    Pause()
      => ComCall(4, this.p)
    Run(tStart)
      => ComCall(5, this.p, Int64, tStart)
    SetSyncSource(pClock)
      => ComCall(6, this.p, IReferenceClock, pClock)
    NotifyGraphChange()
      => ComCall(7, this.p)
}
struct AM_STREAM_INFO_FLAGS extends Int32 {
    static AM_STREAM_INFO_START_DEFINED := 1
    static AM_STREAM_INFO_STOP_DEFINED := 2
    static AM_STREAM_INFO_DISCARDING := 4
    static AM_STREAM_INFO_STOP_SEND_EXTRA := 16
}
struct AM_STREAM_INFO {
    tStart : Int64
    tStop : Int64
    dwStartCookie : UInt32
    dwStopCookie : UInt32
    dwFlags : UInt32
}
struct IAMStreamControl extends IUnknown {
    static IID := "{36B73881-C2C8-11CF-8B46-00805F6CEF60}"
    StartAt(ptStart?, dwCookie)
      => ComCall(3, this.p, Int64.Ptr, ptStart?, UInt32, dwCookie)
    StopAt(ptStop?, bSendExtra, dwCookie)
      => ComCall(4, this.p, Int64.Ptr, ptStop?, BOOL, bSendExtra, UInt32, dwCookie)
    GetInfo(pInfo)
      => ComCall(5, this.p, AM_STREAM_INFO.Ptr, pInfo)
}
struct ISeekingPassThru extends IUnknown {
    static IID := "{36B73883-C2C8-11CF-8B46-00805F6CEF60}"
    Init(bSupportRendering, pPin)
      => ComCall(3, this.p, BOOL, bSupportRendering, IPin, pPin)
}
struct VIDEO_STREAM_CONFIG_CAPS {
    guid : GUID
    VideoStandard : UInt32
    InputSize : SIZE
    MinCroppingSize : SIZE
    MaxCroppingSize : SIZE
    CropGranularityX : Int32
    CropGranularityY : Int32
    CropAlignX : Int32
    CropAlignY : Int32
    MinOutputSize : SIZE
    MaxOutputSize : SIZE
    OutputGranularityX : Int32
    OutputGranularityY : Int32
    StretchTapsX : Int32
    StretchTapsY : Int32
    ShrinkTapsX : Int32
    ShrinkTapsY : Int32
    MinFrameInterval : Int64
    MaxFrameInterval : Int64
    MinBitsPerSecond : Int32
    MaxBitsPerSecond : Int32
}
struct AUDIO_STREAM_CONFIG_CAPS {
    guid : GUID
    MinimumChannels : UInt32
    MaximumChannels : UInt32
    ChannelsGranularity : UInt32
    MinimumBitsPerSample : UInt32
    MaximumBitsPerSample : UInt32
    BitsPerSampleGranularity : UInt32
    MinimumSampleFrequency : UInt32
    MaximumSampleFrequency : UInt32
    SampleFrequencyGranularity : UInt32
}
struct IAMStreamConfig extends IUnknown {
    static IID := "{C6E13340-30AC-11D0-A18C-00A0C9118956}"
    SetFormat(pmt)
      => ComCall(3, this.p, AM_MEDIA_TYPE.Ptr, pmt)
    GetFormat(ppmt)
      => ComCall(4, this.p, AM_MEDIA_TYPE.Ptr.Ptr, ppmt)
    GetNumberOfCapabilities(piCount, piSize)
      => ComCall(5, this.p, Int32.Ptr, piCount, Int32.Ptr, piSize)
    GetStreamCaps(iIndex, ppmt, pSCC)
      => ComCall(6, this.p, Int32, iIndex, AM_MEDIA_TYPE.Ptr.Ptr, ppmt, UInt8.Ptr, pSCC)
}
struct InterleavingMode extends Int32 {
    static INTERLEAVE_NONE := 0
    static INTERLEAVE_CAPTURE := 1
    static INTERLEAVE_FULL := 2
    static INTERLEAVE_NONE_BUFFERED := 3
}
struct IConfigInterleaving extends IUnknown {
    static IID := "{BEE3D220-157B-11D0-BD23-00A0C911CE86}"
    put_Mode(mode)
      => ComCall(3, this.p, InterleavingMode, mode)
    get_Mode(pMode)
      => ComCall(4, this.p, InterleavingMode.Ptr, pMode)
    put_Interleaving(prtInterleave, prtPreroll)
      => ComCall(5, this.p, Int64.Ptr, prtInterleave, Int64.Ptr, prtPreroll)
    get_Interleaving(prtInterleave, prtPreroll)
      => ComCall(6, this.p, Int64.Ptr, prtInterleave, Int64.Ptr, prtPreroll)
}
struct IConfigAviMux extends IUnknown {
    static IID := "{5ACD6AA0-F482-11CE-8B67-00AA00A3F1A6}"
    SetMasterStream(iStream)
      => ComCall(3, this.p, Int32, iStream)
    GetMasterStream(pStream)
      => ComCall(4, this.p, Int32.Ptr, pStream)
    SetOutputCompatibilityIndex(fOldIndex)
      => ComCall(5, this.p, BOOL, fOldIndex)
    GetOutputCompatibilityIndex(pfOldIndex)
      => ComCall(6, this.p, BOOL.Ptr, pfOldIndex)
}
struct CompressionCaps extends Int32 {
    static CompressionCaps_CanQuality := 1
    static CompressionCaps_CanCrunch := 2
    static CompressionCaps_CanKeyFrame := 4
    static CompressionCaps_CanBFrame := 8
    static CompressionCaps_CanWindow := 16
}
struct IAMVideoCompression extends IUnknown {
    static IID := "{C6E13343-30AC-11D0-A18C-00A0C9118956}"
    put_KeyFrameRate(KeyFrameRate)
      => ComCall(3, this.p, Int32, KeyFrameRate)
    get_KeyFrameRate(pKeyFrameRate)
      => ComCall(4, this.p, Int32.Ptr, pKeyFrameRate)
    put_PFramesPerKeyFrame(PFramesPerKeyFrame)
      => ComCall(5, this.p, Int32, PFramesPerKeyFrame)
    get_PFramesPerKeyFrame(pPFramesPerKeyFrame)
      => ComCall(6, this.p, Int32.Ptr, pPFramesPerKeyFrame)
    put_Quality(Quality)
      => ComCall(7, this.p, Float64, Quality)
    get_Quality(pQuality)
      => ComCall(8, this.p, Float64.Ptr, pQuality)
    put_WindowSize(WindowSize)
      => ComCall(9, this.p, Int64, WindowSize)
    get_WindowSize(pWindowSize)
      => ComCall(10, this.p, Int64.Ptr, pWindowSize)
    GetInfo(pszVersion?, pcbVersion := pszVersion.Size, pszDescription?, pcbDescription := pszDescription.Size, pDefaultKeyFrameRate?, pDefaultPFramesPerKey?, pDefaultQuality?, pCapabilities?)
      => ComCall(11, this.p, PWSTR, pszVersion?, Int32.Ptr, pcbVersion?, PWSTR, pszDescription?, Int32.Ptr, pcbDescription?, Int32.Ptr, pDefaultKeyFrameRate?, Int32.Ptr, pDefaultPFramesPerKey?, Float64.Ptr, pDefaultQuality?, Int32.Ptr, pCapabilities?)
    OverrideKeyFrame(FrameNumber)
      => ComCall(12, this.p, Int32, FrameNumber)
    OverrideFrameSize(FrameNumber, Size)
      => ComCall(13, this.p, Int32, FrameNumber, Int32, Size)
}
struct VfwCaptureDialogs extends Int32 {
    static VfwCaptureDialog_Source := 1
    static VfwCaptureDialog_Format := 2
    static VfwCaptureDialog_Display := 4
}
struct VfwCompressDialogs extends Int32 {
    static VfwCompressDialog_Config := 1
    static VfwCompressDialog_About := 2
    static VfwCompressDialog_QueryConfig := 4
    static VfwCompressDialog_QueryAbout := 8
}
struct IAMVfwCaptureDialogs extends IUnknown {
    static IID := "{D8D715A0-6E5E-11D0-B3F0-00AA003761C5}"
    HasDialog(iDialog)
      => ComCall(3, this.p, Int32, iDialog)
    ShowDialog(iDialog, hwnd1)
      => ComCall(4, this.p, Int32, iDialog, HWND, hwnd1)
    SendDriverMessage(iDialog, uMsg, dw1, dw2)
      => ComCall(5, this.p, Int32, iDialog, Int32, uMsg, Int32, dw1, Int32, dw2)
}
struct IAMVfwCompressDialogs extends IUnknown {
    static IID := "{D8D715A3-6E5E-11D0-B3F0-00AA003761C5}"
    ShowDialog(iDialog, hwnd1)
      => ComCall(3, this.p, Int32, iDialog, HWND, hwnd1)
    GetState(pState, pcbState)
      => ComCall(4, this.p, Struct.Ptr, pState, Int32.Ptr, pcbState)
    SetState(pState)
      => ComCall(5, this.p, Struct.Ptr, pState, Int32, pState.Size)
    SendDriverMessage(uMsg, dw1, dw2)
      => ComCall(6, this.p, Int32, uMsg, Int32, dw1, Int32, dw2)
}
struct IAMDroppedFrames extends IUnknown {
    static IID := "{C6E13344-30AC-11D0-A18C-00A0C9118956}"
    GetNumDropped(plDropped)
      => ComCall(3, this.p, Int32.Ptr, plDropped)
    GetNumNotDropped(plNotDropped)
      => ComCall(4, this.p, Int32.Ptr, plNotDropped)
    GetDroppedInfo(lSize, plArray, plNumCopied)
      => ComCall(5, this.p, Int32, lSize, Int32.Ptr, plArray, Int32.Ptr, plNumCopied)
    GetAverageFrameSize(plAverageSize)
      => ComCall(6, this.p, Int32.Ptr, plAverageSize)
}
struct IAMAudioInputMixer extends IUnknown {
    static IID := "{54C39221-8380-11D0-B3F0-00AA003761C5}"
    put_Enable(fEnable)
      => ComCall(3, this.p, BOOL, fEnable)
    get_Enable(pfEnable)
      => ComCall(4, this.p, BOOL.Ptr, pfEnable)
    put_Mono(fMono)
      => ComCall(5, this.p, BOOL, fMono)
    get_Mono(pfMono)
      => ComCall(6, this.p, BOOL.Ptr, pfMono)
    put_MixLevel(Level)
      => ComCall(7, this.p, Float64, Level)
    get_MixLevel(pLevel)
      => ComCall(8, this.p, Float64.Ptr, pLevel)
    put_Pan(Pan)
      => ComCall(9, this.p, Float64, Pan)
    get_Pan(pPan)
      => ComCall(10, this.p, Float64.Ptr, pPan)
    put_Loudness(fLoudness)
      => ComCall(11, this.p, BOOL, fLoudness)
    get_Loudness(pfLoudness)
      => ComCall(12, this.p, BOOL.Ptr, pfLoudness)
    put_Treble(Treble)
      => ComCall(13, this.p, Float64, Treble)
    get_Treble(pTreble)
      => ComCall(14, this.p, Float64.Ptr, pTreble)
    get_TrebleRange(pRange)
      => ComCall(15, this.p, Float64.Ptr, pRange)
    put_Bass(Bass)
      => ComCall(16, this.p, Float64, Bass)
    get_Bass(pBass)
      => ComCall(17, this.p, Float64.Ptr, pBass)
    get_BassRange(pRange)
      => ComCall(18, this.p, Float64.Ptr, pRange)
}
struct IAMBufferNegotiation extends IUnknown {
    static IID := "{56ED71A0-AF5F-11D0-B3F0-00AA003761C5}"
    SuggestAllocatorProperties(pprop)
      => ComCall(3, this.p, ALLOCATOR_PROPERTIES.Ptr, pprop)
    GetAllocatorProperties(pprop)
      => ComCall(4, this.p, ALLOCATOR_PROPERTIES.Ptr, pprop)
}
struct AnalogVideoStandard extends Int32 {
    static AnalogVideo_None := 0
    static AnalogVideo_NTSC_M := 1
    static AnalogVideo_NTSC_M_J := 2
    static AnalogVideo_NTSC_433 := 4
    static AnalogVideo_PAL_B := 16
    static AnalogVideo_PAL_D := 32
    static AnalogVideo_PAL_G := 64
    static AnalogVideo_PAL_H := 128
    static AnalogVideo_PAL_I := 256
    static AnalogVideo_PAL_M := 512
    static AnalogVideo_PAL_N := 1024
    static AnalogVideo_PAL_60 := 2048
    static AnalogVideo_SECAM_B := 4096
    static AnalogVideo_SECAM_D := 8192
    static AnalogVideo_SECAM_G := 16384
    static AnalogVideo_SECAM_H := 32768
    static AnalogVideo_SECAM_K := 65536
    static AnalogVideo_SECAM_K1 := 131072
    static AnalogVideo_SECAM_L := 262144
    static AnalogVideo_SECAM_L1 := 524288
    static AnalogVideo_PAL_N_COMBO := 1048576
    static AnalogVideoMask_MCE_NTSC := 1052167
    static AnalogVideoMask_MCE_PAL := 496
    static AnalogVideoMask_MCE_SECAM := 1044480
}
struct TunerInputType extends Int32 {
    static TunerInputCable := 0
    static TunerInputAntenna := 1
}
struct VideoCopyProtectionType extends Int32 {
    static VideoCopyProtectionMacrovisionBasic := 0
    static VideoCopyProtectionMacrovisionCBI := 1
}
struct PhysicalConnectorType extends Int32 {
    static PhysConn_Video_Tuner := 1
    static PhysConn_Video_Composite := 2
    static PhysConn_Video_SVideo := 3
    static PhysConn_Video_RGB := 4
    static PhysConn_Video_YRYBY := 5
    static PhysConn_Video_SerialDigital := 6
    static PhysConn_Video_ParallelDigital := 7
    static PhysConn_Video_SCSI := 8
    static PhysConn_Video_AUX := 9
    static PhysConn_Video_1394 := 10
    static PhysConn_Video_USB := 11
    static PhysConn_Video_VideoDecoder := 12
    static PhysConn_Video_VideoEncoder := 13
    static PhysConn_Video_SCART := 14
    static PhysConn_Video_Black := 15
    static PhysConn_Audio_Tuner := 4096
    static PhysConn_Audio_Line := 4097
    static PhysConn_Audio_Mic := 4098
    static PhysConn_Audio_AESDigital := 4099
    static PhysConn_Audio_SPDIFDigital := 4100
    static PhysConn_Audio_SCSI := 4101
    static PhysConn_Audio_AUX := 4102
    static PhysConn_Audio_1394 := 4103
    static PhysConn_Audio_USB := 4104
    static PhysConn_Audio_AudioDecoder := 4105
}
struct IAMAnalogVideoDecoder extends IUnknown {
    static IID := "{C6E13350-30AC-11D0-A18C-00A0C9118956}"
    get_AvailableTVFormats(lAnalogVideoStandard)
      => ComCall(3, this.p, Int32.Ptr, lAnalogVideoStandard)
    put_TVFormat(lAnalogVideoStandard)
      => ComCall(4, this.p, Int32, lAnalogVideoStandard)
    get_TVFormat(plAnalogVideoStandard)
      => ComCall(5, this.p, Int32.Ptr, plAnalogVideoStandard)
    get_HorizontalLocked(plLocked)
      => ComCall(6, this.p, Int32.Ptr, plLocked)
    put_VCRHorizontalLocking(lVCRHorizontalLocking)
      => ComCall(7, this.p, Int32, lVCRHorizontalLocking)
    get_VCRHorizontalLocking(plVCRHorizontalLocking)
      => ComCall(8, this.p, Int32.Ptr, plVCRHorizontalLocking)
    get_NumberOfLines(plNumberOfLines)
      => ComCall(9, this.p, Int32.Ptr, plNumberOfLines)
    put_OutputEnable(lOutputEnable)
      => ComCall(10, this.p, Int32, lOutputEnable)
    get_OutputEnable(plOutputEnable)
      => ComCall(11, this.p, Int32.Ptr, plOutputEnable)
}
struct VideoProcAmpProperty extends Int32 {
    static VideoProcAmp_Brightness := 0
    static VideoProcAmp_Contrast := 1
    static VideoProcAmp_Hue := 2
    static VideoProcAmp_Saturation := 3
    static VideoProcAmp_Sharpness := 4
    static VideoProcAmp_Gamma := 5
    static VideoProcAmp_ColorEnable := 6
    static VideoProcAmp_WhiteBalance := 7
    static VideoProcAmp_BacklightCompensation := 8
    static VideoProcAmp_Gain := 9
}
struct VideoProcAmpFlags extends Int32 {
    static VideoProcAmp_Flags_Auto := 1
    static VideoProcAmp_Flags_Manual := 2
}
struct IAMVideoProcAmp extends IUnknown {
    static IID := "{C6E13360-30AC-11D0-A18C-00A0C9118956}"
    GetRange(Property, pMin, pMax, pSteppingDelta, pDefault, pCapsFlags)
      => ComCall(3, this.p, Int32, Property, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlags)
    Set(Property, lValue, Flags)
      => ComCall(4, this.p, Int32, Property, Int32, lValue, Int32, Flags)
    Get(Property, lValue, Flags)
      => ComCall(5, this.p, Int32, Property, Int32.Ptr, lValue, Int32.Ptr, Flags)
}
struct CameraControlProperty extends Int32 {
    static CameraControl_Pan := 0
    static CameraControl_Tilt := 1
    static CameraControl_Roll := 2
    static CameraControl_Zoom := 3
    static CameraControl_Exposure := 4
    static CameraControl_Iris := 5
    static CameraControl_Focus := 6
}
struct CameraControlFlags extends Int32 {
    static CameraControl_Flags_Auto := 1
    static CameraControl_Flags_Manual := 2
}
struct IAMCameraControl extends IUnknown {
    static IID := "{C6E13370-30AC-11D0-A18C-00A0C9118956}"
    GetRange(Property, pMin, pMax, pSteppingDelta, pDefault, pCapsFlags)
      => ComCall(3, this.p, Int32, Property, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlags)
    Set(Property, lValue, Flags)
      => ComCall(4, this.p, Int32, Property, Int32, lValue, Int32, Flags)
    Get(Property, lValue, Flags)
      => ComCall(5, this.p, Int32, Property, Int32.Ptr, lValue, Int32.Ptr, Flags)
}
struct VideoControlFlags extends Int32 {
    static VideoControlFlag_FlipHorizontal := 1
    static VideoControlFlag_FlipVertical := 2
    static VideoControlFlag_ExternalTriggerEnable := 4
    static VideoControlFlag_Trigger := 8
}
struct IAMVideoControl extends IUnknown {
    static IID := "{6A2E0670-28E4-11D0-A18C-00A0C9118956}"
    GetCaps(pPin, pCapsFlags)
      => ComCall(3, this.p, IPin, pPin, Int32.Ptr, pCapsFlags)
    SetMode(pPin, Mode)
      => ComCall(4, this.p, IPin, pPin, Int32, Mode)
    GetMode(pPin, Mode)
      => ComCall(5, this.p, IPin, pPin, Int32.Ptr, Mode)
    GetCurrentActualFrameRate(pPin, ActualFrameRate)
      => ComCall(6, this.p, IPin, pPin, Int64.Ptr, ActualFrameRate)
    GetMaxAvailableFrameRate(pPin, iIndex, Dimensions, MaxAvailableFrameRate)
      => ComCall(7, this.p, IPin, pPin, Int32, iIndex, SIZE, Dimensions, Int64.Ptr, MaxAvailableFrameRate)
    GetFrameRateList(pPin, iIndex, Dimensions, ListSize, FrameRates)
      => ComCall(8, this.p, IPin, pPin, Int32, iIndex, SIZE, Dimensions, Int32.Ptr, ListSize, Int64.Ptr.Ptr, FrameRates)
}
struct IAMCrossbar extends IUnknown {
    static IID := "{C6E13380-30AC-11D0-A18C-00A0C9118956}"
    get_PinCounts(OutputPinCount, InputPinCount)
      => ComCall(3, this.p, Int32.Ptr, OutputPinCount, Int32.Ptr, InputPinCount)
    CanRoute(OutputPinIndex, InputPinIndex)
      => ComCall(4, this.p, Int32, OutputPinIndex, Int32, InputPinIndex)
    Route(OutputPinIndex, InputPinIndex)
      => ComCall(5, this.p, Int32, OutputPinIndex, Int32, InputPinIndex)
    get_IsRoutedTo(OutputPinIndex, InputPinIndex)
      => ComCall(6, this.p, Int32, OutputPinIndex, Int32.Ptr, InputPinIndex)
    get_CrossbarPinInfo(IsInputPin, PinIndex, PinIndexRelated, PhysicalType)
      => ComCall(7, this.p, BOOL, IsInputPin, Int32, PinIndex, Int32.Ptr, PinIndexRelated, Int32.Ptr, PhysicalType)
}
struct AMTunerSubChannel extends Int32 {
    static AMTUNER_SUBCHAN_NO_TUNE := -2
    static AMTUNER_SUBCHAN_DEFAULT := -1
}
struct AMTunerSignalStrength extends Int32 {
    static AMTUNER_HASNOSIGNALSTRENGTH := -1
    static AMTUNER_NOSIGNAL := 0
    static AMTUNER_SIGNALPRESENT := 1
}
struct AMTunerModeType extends Int32 {
    static AMTUNER_MODE_DEFAULT := 0
    static AMTUNER_MODE_TV := 1
    static AMTUNER_MODE_FM_RADIO := 2
    static AMTUNER_MODE_AM_RADIO := 4
    static AMTUNER_MODE_DSS := 8
}
struct AMTunerEventType extends Int32 {
    static AMTUNER_EVENT_CHANGED := 1
}
struct IAMTuner extends IUnknown {
    static IID := "{211A8761-03AC-11D1-8D13-00AA00BD8339}"
    put_Channel(lChannel, lVideoSubChannel, lAudioSubChannel)
      => ComCall(3, this.p, Int32, lChannel, Int32, lVideoSubChannel, Int32, lAudioSubChannel)
    get_Channel(plChannel, plVideoSubChannel, plAudioSubChannel)
      => ComCall(4, this.p, Int32.Ptr, plChannel, Int32.Ptr, plVideoSubChannel, Int32.Ptr, plAudioSubChannel)
    ChannelMinMax(lChannelMin, lChannelMax)
      => ComCall(5, this.p, Int32.Ptr, lChannelMin, Int32.Ptr, lChannelMax)
    put_CountryCode(lCountryCode)
      => ComCall(6, this.p, Int32, lCountryCode)
    get_CountryCode(plCountryCode)
      => ComCall(7, this.p, Int32.Ptr, plCountryCode)
    put_TuningSpace(lTuningSpace)
      => ComCall(8, this.p, Int32, lTuningSpace)
    get_TuningSpace(plTuningSpace)
      => ComCall(9, this.p, Int32.Ptr, plTuningSpace)
    Logon(hCurrentUser)
      => ComCall(10, this.p, HANDLE, hCurrentUser)
    Logout()
      => ComCall(11, this.p)
    SignalPresent(plSignalStrength)
      => ComCall(12, this.p, Int32.Ptr, plSignalStrength)
    put_Mode(lMode)
      => ComCall(13, this.p, AMTunerModeType, lMode)
    get_Mode(plMode)
      => ComCall(14, this.p, AMTunerModeType.Ptr, plMode)
    GetAvailableModes(plModes)
      => ComCall(15, this.p, Int32.Ptr, plModes)
    RegisterNotificationCallBack(pNotify, lEvents)
      => ComCall(16, this.p, IAMTunerNotification, pNotify, Int32, lEvents)
    UnRegisterNotificationCallBack(pNotify)
      => ComCall(17, this.p, IAMTunerNotification, pNotify)
}
struct IAMTunerNotification extends IUnknown {
    static IID := "{211A8760-03AC-11D1-8D13-00AA00BD8339}"
    OnEvent(Event)
      => ComCall(3, this.p, AMTunerEventType, Event)
}
struct IAMTVTuner extends IAMTuner {
    static IID := "{211A8766-03AC-11D1-8D13-00AA00BD8339}"
    get_AvailableTVFormats(lAnalogVideoStandard)
      => ComCall(18, this.p, Int32.Ptr, lAnalogVideoStandard)
    get_TVFormat(plAnalogVideoStandard)
      => ComCall(19, this.p, Int32.Ptr, plAnalogVideoStandard)
    AutoTune(lChannel, plFoundSignal)
      => ComCall(20, this.p, Int32, lChannel, Int32.Ptr, plFoundSignal)
    StoreAutoTune()
      => ComCall(21, this.p)
    get_NumInputConnections(plNumInputConnections)
      => ComCall(22, this.p, Int32.Ptr, plNumInputConnections)
    put_InputType(lIndex, InputType)
      => ComCall(23, this.p, Int32, lIndex, TunerInputType, InputType)
    get_InputType(lIndex, pInputType)
      => ComCall(24, this.p, Int32, lIndex, TunerInputType.Ptr, pInputType)
    put_ConnectInput(lIndex)
      => ComCall(25, this.p, Int32, lIndex)
    get_ConnectInput(plIndex)
      => ComCall(26, this.p, Int32.Ptr, plIndex)
    get_VideoFrequency(lFreq)
      => ComCall(27, this.p, Int32.Ptr, lFreq)
    get_AudioFrequency(lFreq)
      => ComCall(28, this.p, Int32.Ptr, lFreq)
}
struct IBPCSatelliteTuner extends IAMTuner {
    static IID := "{211A8765-03AC-11D1-8D13-00AA00BD8339}"
    get_DefaultSubChannelTypes(plDefaultVideoType, plDefaultAudioType)
      => ComCall(18, this.p, Int32.Ptr, plDefaultVideoType, Int32.Ptr, plDefaultAudioType)
    put_DefaultSubChannelTypes(lDefaultVideoType, lDefaultAudioType)
      => ComCall(19, this.p, Int32, lDefaultVideoType, Int32, lDefaultAudioType)
    IsTapingPermitted()
      => ComCall(20, this.p)
}
struct TVAudioMode extends Int32 {
    static AMTVAUDIO_MODE_MONO := 1
    static AMTVAUDIO_MODE_STEREO := 2
    static AMTVAUDIO_MODE_LANG_A := 16
    static AMTVAUDIO_MODE_LANG_B := 32
    static AMTVAUDIO_MODE_LANG_C := 64
    static AMTVAUDIO_PRESET_STEREO := 512
    static AMTVAUDIO_PRESET_LANG_A := 4096
    static AMTVAUDIO_PRESET_LANG_B := 8192
    static AMTVAUDIO_PRESET_LANG_C := 16384
}
struct AMTVAudioEventType extends Int32 {
    static AMTVAUDIO_EVENT_CHANGED := 1
}
struct IAMTVAudio extends IUnknown {
    static IID := "{83EC1C30-23D1-11D1-99E6-00A0C9560266}"
    GetHardwareSupportedTVAudioModes(plModes)
      => ComCall(3, this.p, Int32.Ptr, plModes)
    GetAvailableTVAudioModes(plModes)
      => ComCall(4, this.p, Int32.Ptr, plModes)
    get_TVAudioMode(plMode)
      => ComCall(5, this.p, Int32.Ptr, plMode)
    put_TVAudioMode(lMode)
      => ComCall(6, this.p, Int32, lMode)
    RegisterNotificationCallBack(pNotify, lEvents)
      => ComCall(7, this.p, IAMTunerNotification, pNotify, Int32, lEvents)
    UnRegisterNotificationCallBack(pNotify)
      => ComCall(8, this.p, IAMTunerNotification, pNotify)
}
struct IAMTVAudioNotification extends IUnknown {
    static IID := "{83EC1C33-23D1-11D1-99E6-00A0C9560266}"
    OnEvent(Event)
      => ComCall(3, this.p, AMTVAudioEventType, Event)
}
struct IAMAnalogVideoEncoder extends IUnknown {
    static IID := "{C6E133B0-30AC-11D0-A18C-00A0C9118956}"
    get_AvailableTVFormats(lAnalogVideoStandard)
      => ComCall(3, this.p, Int32.Ptr, lAnalogVideoStandard)
    put_TVFormat(lAnalogVideoStandard)
      => ComCall(4, this.p, Int32, lAnalogVideoStandard)
    get_TVFormat(plAnalogVideoStandard)
      => ComCall(5, this.p, Int32.Ptr, plAnalogVideoStandard)
    put_CopyProtection(lVideoCopyProtection)
      => ComCall(6, this.p, Int32, lVideoCopyProtection)
    get_CopyProtection(lVideoCopyProtection)
      => ComCall(7, this.p, Int32.Ptr, lVideoCopyProtection)
    put_CCEnable(lCCEnable)
      => ComCall(8, this.p, Int32, lCCEnable)
    get_CCEnable(lCCEnable)
      => ComCall(9, this.p, Int32.Ptr, lCCEnable)
}
struct AMPROPERTY_PIN extends Int32 {
    static AMPROPERTY_PIN_CATEGORY := 0
    static AMPROPERTY_PIN_MEDIUM := 1
}
struct IMediaPropertyBag extends IPropertyBag {
    static IID := "{6025A880-C0D5-11D0-BD4E-00A0C911CE86}"
    EnumProperty(iProperty, pvarPropertyName, pvarPropertyValue)
      => ComCall(5, this.p, UInt32, iProperty, VARIANT.Ptr, pvarPropertyName, VARIANT.Ptr, pvarPropertyValue)
}
struct IPersistMediaPropertyBag extends IPersist {
    static IID := "{5738E040-B67F-11D0-BD4D-00A0C911CE86}"
    InitNew()
      => ComCall(4, this.p)
    Load(pPropBag, pErrorLog)
      => ComCall(5, this.p, IMediaPropertyBag, pPropBag, IErrorLog, pErrorLog)
    Save(pPropBag, fClearDirty, fSaveAllProperties)
      => ComCall(6, this.p, IMediaPropertyBag, pPropBag, BOOL, fClearDirty, BOOL, fSaveAllProperties)
}
struct IAMPhysicalPinInfo extends IUnknown {
    static IID := "{F938C991-3029-11CF-8C44-00AA006B6814}"
    GetPhysicalType(pType, ppszType)
      => ComCall(3, this.p, Int32.Ptr, pType, PWSTR.Ptr, ppszType)
}
struct IAMExtDevice extends IUnknown {
    static IID := "{B5730A90-1A2C-11CF-8C23-00AA006B6814}"
    GetCapability(Capability, pValue, pdblValue)
      => ComCall(3, this.p, Int32, Capability, Int32.Ptr, pValue, Float64.Ptr, pdblValue)
    get_ExternalDeviceID(ppszData)
      => ComCall(4, this.p, PWSTR.Ptr, ppszData)
    get_ExternalDeviceVersion(ppszData)
      => ComCall(5, this.p, PWSTR.Ptr, ppszData)
    put_DevicePower(PowerMode)
      => ComCall(6, this.p, Int32, PowerMode)
    get_DevicePower(pPowerMode)
      => ComCall(7, this.p, Int32.Ptr, pPowerMode)
    Calibrate(hEvent, Mode, pStatus)
      => ComCall(8, this.p, IntPtr, hEvent, Int32, Mode, Int32.Ptr, pStatus)
    put_DevicePort(DevicePort)
      => ComCall(9, this.p, Int32, DevicePort)
    get_DevicePort(pDevicePort)
      => ComCall(10, this.p, Int32.Ptr, pDevicePort)
}
struct IAMExtTransport extends IUnknown {
    static IID := "{A03CD5F0-3045-11CF-8C44-00AA006B6814}"
    GetCapability(Capability, pValue, pdblValue)
      => ComCall(3, this.p, Int32, Capability, Int32.Ptr, pValue, Float64.Ptr, pdblValue)
    put_MediaState(State)
      => ComCall(4, this.p, Int32, State)
    get_MediaState(pState)
      => ComCall(5, this.p, Int32.Ptr, pState)
    put_LocalControl(State)
      => ComCall(6, this.p, Int32, State)
    get_LocalControl(pState)
      => ComCall(7, this.p, Int32.Ptr, pState)
    GetStatus(StatusItem, pValue)
      => ComCall(8, this.p, Int32, StatusItem, Int32.Ptr, pValue)
    GetTransportBasicParameters(Param, pValue, ppszData)
      => ComCall(9, this.p, Int32, Param, Int32.Ptr, pValue, PWSTR.Ptr, ppszData)
    SetTransportBasicParameters(Param, Value, pszData)
      => ComCall(10, this.p, Int32, Param, Int32, Value, "Str", pszData)
    GetTransportVideoParameters(Param, pValue)
      => ComCall(11, this.p, Int32, Param, Int32.Ptr, pValue)
    SetTransportVideoParameters(Param, Value)
      => ComCall(12, this.p, Int32, Param, Int32, Value)
    GetTransportAudioParameters(Param, pValue)
      => ComCall(13, this.p, Int32, Param, Int32.Ptr, pValue)
    SetTransportAudioParameters(Param, Value)
      => ComCall(14, this.p, Int32, Param, Int32, Value)
    put_Mode(Mode)
      => ComCall(15, this.p, Int32, Mode)
    get_Mode(pMode)
      => ComCall(16, this.p, Int32.Ptr, pMode)
    put_Rate(dblRate)
      => ComCall(17, this.p, Float64, dblRate)
    get_Rate(pdblRate)
      => ComCall(18, this.p, Float64.Ptr, pdblRate)
    GetChase(pEnabled, pOffset, phEvent)
      => ComCall(19, this.p, Int32.Ptr, pEnabled, Int32.Ptr, pOffset, IntPtr.Ptr, phEvent)
    SetChase(Enable, Offset, hEvent)
      => ComCall(20, this.p, Int32, Enable, Int32, Offset, IntPtr, hEvent)
    GetBump(pSpeed, pDuration)
      => ComCall(21, this.p, Int32.Ptr, pSpeed, Int32.Ptr, pDuration)
    SetBump(Speed, Duration)
      => ComCall(22, this.p, Int32, Speed, Int32, Duration)
    get_AntiClogControl(pEnabled)
      => ComCall(23, this.p, Int32.Ptr, pEnabled)
    put_AntiClogControl(Enable)
      => ComCall(24, this.p, Int32, Enable)
    GetEditPropertySet(EditID, pState)
      => ComCall(25, this.p, Int32, EditID, Int32.Ptr, pState)
    SetEditPropertySet(pEditID, State)
      => ComCall(26, this.p, Int32.Ptr, pEditID, Int32, State)
    GetEditProperty(EditID, Param, pValue)
      => ComCall(27, this.p, Int32, EditID, Int32, Param, Int32.Ptr, pValue)
    SetEditProperty(EditID, Param, Value)
      => ComCall(28, this.p, Int32, EditID, Int32, Param, Int32, Value)
    get_EditStart(pValue)
      => ComCall(29, this.p, Int32.Ptr, pValue)
    put_EditStart(Value)
      => ComCall(30, this.p, Int32, Value)
}
struct IAMTimecodeReader extends IUnknown {
    static IID := "{9B496CE1-811B-11CF-8C77-00AA006B6814}"
    GetTCRMode(Param, pValue)
      => ComCall(3, this.p, Int32, Param, Int32.Ptr, pValue)
    SetTCRMode(Param, Value)
      => ComCall(4, this.p, Int32, Param, Int32, Value)
    put_VITCLine(Line)
      => ComCall(5, this.p, Int32, Line)
    get_VITCLine(pLine)
      => ComCall(6, this.p, Int32.Ptr, pLine)
    GetTimecode(pTimecodeSample)
      => ComCall(7, this.p, TIMECODE_SAMPLE.Ptr, pTimecodeSample)
}
struct IAMTimecodeGenerator extends IUnknown {
    static IID := "{9B496CE0-811B-11CF-8C77-00AA006B6814}"
    GetTCGMode(Param, pValue)
      => ComCall(3, this.p, Int32, Param, Int32.Ptr, pValue)
    SetTCGMode(Param, Value)
      => ComCall(4, this.p, Int32, Param, Int32, Value)
    put_VITCLine(Line)
      => ComCall(5, this.p, Int32, Line)
    get_VITCLine(pLine)
      => ComCall(6, this.p, Int32.Ptr, pLine)
    SetTimecode(pTimecodeSample)
      => ComCall(7, this.p, TIMECODE_SAMPLE.Ptr, pTimecodeSample)
    GetTimecode(pTimecodeSample)
      => ComCall(8, this.p, TIMECODE_SAMPLE.Ptr, pTimecodeSample)
}
struct IAMTimecodeDisplay extends IUnknown {
    static IID := "{9B496CE2-811B-11CF-8C77-00AA006B6814}"
    GetTCDisplayEnable(pState)
      => ComCall(3, this.p, Int32.Ptr, pState)
    SetTCDisplayEnable(State)
      => ComCall(4, this.p, Int32, State)
    GetTCDisplay(Param, pValue)
      => ComCall(5, this.p, Int32, Param, Int32.Ptr, pValue)
    SetTCDisplay(Param, Value)
      => ComCall(6, this.p, Int32, Param, Int32, Value)
}
struct IAMDevMemoryAllocator extends IUnknown {
    static IID := "{C6545BF0-E76B-11D0-BD52-00A0C911CE86}"
    GetInfo(pdwcbTotalFree, pdwcbLargestFree, pdwcbTotalMemory, pdwcbMinimumChunk)
      => ComCall(3, this.p, UInt32.Ptr, pdwcbTotalFree, UInt32.Ptr, pdwcbLargestFree, UInt32.Ptr, pdwcbTotalMemory, UInt32.Ptr, pdwcbMinimumChunk)
    CheckMemory(pBuffer)
      => ComCall(4, this.p, UInt8.Ptr, pBuffer)
    Alloc(ppBuffer, pdwcbBuffer)
      => ComCall(5, this.p, UInt8.Ptr.Ptr, ppBuffer, UInt32.Ptr, pdwcbBuffer)
    Free(pBuffer)
      => ComCall(6, this.p, UInt8.Ptr, pBuffer)
    GetDevMemoryObject(ppUnkInnner, pUnkOuter)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnkInnner, IUnknown, pUnkOuter)
}
struct IAMDevMemoryControl extends IUnknown {
    static IID := "{C6545BF1-E76B-11D0-BD52-00A0C911CE86}"
    QueryWriteSync()
      => ComCall(3, this.p)
    WriteSync()
      => ComCall(4, this.p)
    GetDevId(pdwDevId)
      => ComCall(5, this.p, UInt32.Ptr, pdwDevId)
}
struct AMSTREAMSELECTINFOFLAGS extends Int32 {
    static AMSTREAMSELECTINFO_ENABLED := 1
    static AMSTREAMSELECTINFO_EXCLUSIVE := 2
}
struct AMSTREAMSELECTENABLEFLAGS extends Int32 {
    static AMSTREAMSELECTENABLE_ENABLE := 1
    static AMSTREAMSELECTENABLE_ENABLEALL := 2
}
struct IAMStreamSelect extends IUnknown {
    static IID := "{C1960960-17F5-11D1-ABE1-00A0C905F375}"
    Count(pcStreams)
      => ComCall(3, this.p, UInt32.Ptr, pcStreams)
    Info(lIndex, ppmt?, pdwFlags?, plcid?, pdwGroup?, ppszName?, ppObject?, ppUnk?)
      => ComCall(4, this.p, Int32, lIndex, AM_MEDIA_TYPE.Ptr.Ptr, ppmt?, UInt32.Ptr, pdwFlags?, UInt32.Ptr, plcid?, UInt32.Ptr, pdwGroup?, PWSTR.Ptr, ppszName?, IUnknown.Ptr, ppObject?, IUnknown.Ptr, ppUnk?)
    Enable(lIndex, dwFlags)
      => ComCall(5, this.p, Int32, lIndex, UInt32, dwFlags)
}
struct AMRESCTL_RESERVEFLAGS extends Int32 {
    static AMRESCTL_RESERVEFLAGS_RESERVE := 0
    static AMRESCTL_RESERVEFLAGS_UNRESERVE := 1
}
struct IAMResourceControl extends IUnknown {
    static IID := "{8389D2D0-77D7-11D1-ABE6-00A0C905F375}"
    Reserve(dwFlags)
      => ComCall(3, this.p, UInt32, dwFlags, "Ptr", 0)
}
struct IAMClockAdjust extends IUnknown {
    static IID := "{4D5466B0-A49C-11D1-ABE8-00A0C905F375}"
    SetClockDelta(rtDelta)
      => ComCall(3, this.p, Int64, rtDelta)
}
struct AM_FILTER_MISC_FLAGS extends Int32 {
    static AM_FILTER_MISC_FLAGS_IS_RENDERER := 1
    static AM_FILTER_MISC_FLAGS_IS_SOURCE := 2
}
struct IAMFilterMiscFlags extends IUnknown {
    static IID := "{2DD74950-A890-11D1-ABE8-00A0C905F375}"
    GetMiscFlags()
      => ComCall(3, this.p, UInt32)
}
struct IDrawVideoImage extends IUnknown {
    static IID := "{48EFB120-AB49-11D2-AED2-00A0C995E8D5}"
    DrawVideoImageBegin()
      => ComCall(3, this.p)
    DrawVideoImageEnd()
      => ComCall(4, this.p)
    DrawVideoImageDraw(hdc1, lprcSrc, lprcDst)
      => ComCall(5, this.p, HDC, hdc1, RECT.Ptr, lprcSrc, RECT.Ptr, lprcDst)
}
struct IDecimateVideoImage extends IUnknown {
    static IID := "{2E5EA3E0-E924-11D2-B6DA-00A0C995E8DF}"
    SetDecimationImageSize(lWidth, lHeight)
      => ComCall(3, this.p, Int32, lWidth, Int32, lHeight)
    ResetDecimationImageSize()
      => ComCall(4, this.p)
}
struct DECIMATION_USAGE extends Int32 {
    static DECIMATION_LEGACY := 0
    static DECIMATION_USE_DECODER_ONLY := 1
    static DECIMATION_USE_VIDEOPORT_ONLY := 2
    static DECIMATION_USE_OVERLAY_ONLY := 3
    static DECIMATION_DEFAULT := 4
}
struct IAMVideoDecimationProperties extends IUnknown {
    static IID := "{60D32930-13DA-11D3-9EC6-C4FCAEF5C7BE}"
    QueryDecimationUsage(lpUsage)
      => ComCall(3, this.p, DECIMATION_USAGE.Ptr, lpUsage)
    SetDecimationUsage(Usage)
      => ComCall(4, this.p, DECIMATION_USAGE, Usage)
}
struct IVideoFrameStep extends IUnknown {
    static IID := "{E46A9787-2B71-444D-A4B5-1FAB7B708D6A}"
    Step(dwFrames, pStepObject?)
      => ComCall(3, this.p, UInt32, dwFrames, IUnknown, pStepObject?)
    CanStep(bMultiple, pStepObject?)
      => ComCall(4, this.p, Int32, bMultiple, IUnknown, pStepObject?)
    CancelStep()
      => ComCall(5, this.p)
}
struct AM_PUSHSOURCE_FLAGS extends Int32 {
    static AM_PUSHSOURCECAPS_INTERNAL_RM := 1
    static AM_PUSHSOURCECAPS_NOT_LIVE := 2
    static AM_PUSHSOURCECAPS_PRIVATE_CLOCK := 4
    static AM_PUSHSOURCEREQS_USE_STREAM_CLOCK := 65536
    static AM_PUSHSOURCEREQS_USE_CLOCK_CHAIN := 131072
}
struct IAMLatency extends IUnknown {
    static IID := "{62EA93BA-EC62-11D2-B770-00C04FB6BD3D}"
    GetLatency(prtLatency)
      => ComCall(3, this.p, Int64.Ptr, prtLatency)
}
struct IAMPushSource extends IAMLatency {
    static IID := "{F185FE76-E64E-11D2-B76E-00C04FB6BD3D}"
    GetPushSourceFlags(pFlags)
      => ComCall(4, this.p, UInt32.Ptr, pFlags)
    SetPushSourceFlags(Flags)
      => ComCall(5, this.p, UInt32, Flags)
    SetStreamOffset(rtOffset)
      => ComCall(6, this.p, Int64, rtOffset)
    GetStreamOffset(prtOffset)
      => ComCall(7, this.p, Int64.Ptr, prtOffset)
    GetMaxStreamOffset(prtMaxOffset)
      => ComCall(8, this.p, Int64.Ptr, prtMaxOffset)
    SetMaxStreamOffset(rtMaxOffset)
      => ComCall(9, this.p, Int64, rtMaxOffset)
}
struct IAMDeviceRemoval extends IUnknown {
    static IID := "{F90A6130-B658-11D2-AE49-0000F8754B99}"
    DeviceInfo(pclsidInterfaceClass, pwszSymbolicLink)
      => ComCall(3, this.p, GUID.Ptr, pclsidInterfaceClass, PWSTR.Ptr, pwszSymbolicLink)
    Reassociate()
      => ComCall(4, this.p)
    Disassociate()
      => ComCall(5, this.p)
}
struct DVINFO {
    dwDVAAuxSrc : UInt32
    dwDVAAuxCtl : UInt32
    dwDVAAuxSrc1 : UInt32
    dwDVAAuxCtl1 : UInt32
    dwDVVAuxSrc : UInt32
    dwDVVAuxCtl : UInt32
    dwDVReserved : UInt32[2]
}
struct DVENCODERRESOLUTION extends Int32 {
    static DVENCODERRESOLUTION_720x480 := 2012
    static DVENCODERRESOLUTION_360x240 := 2013
    static DVENCODERRESOLUTION_180x120 := 2014
    static DVENCODERRESOLUTION_88x60 := 2015
}
struct DVENCODERVIDEOFORMAT extends Int32 {
    static DVENCODERVIDEOFORMAT_NTSC := 2000
    static DVENCODERVIDEOFORMAT_PAL := 2001
}
struct DVENCODERFORMAT extends Int32 {
    static DVENCODERFORMAT_DVSD := 2007
    static DVENCODERFORMAT_DVHD := 2008
    static DVENCODERFORMAT_DVSL := 2009
}
struct IDVEnc extends IUnknown {
    static IID := "{D18E17A0-AACB-11D0-AFB0-00AA00B67A42}"
    get_IFormatResolution(VideoFormat, DVFormat, Resolution, fDVInfo, sDVInfo)
      => ComCall(3, this.p, Int32.Ptr, VideoFormat, Int32.Ptr, DVFormat, Int32.Ptr, Resolution, UInt8, fDVInfo, DVINFO.Ptr, sDVInfo)
    put_IFormatResolution(VideoFormat, DVFormat, Resolution, fDVInfo, sDVInfo)
      => ComCall(4, this.p, Int32, VideoFormat, Int32, DVFormat, Int32, Resolution, UInt8, fDVInfo, DVINFO.Ptr, sDVInfo)
}
struct DVDECODERRESOLUTION extends Int32 {
    static DVDECODERRESOLUTION_720x480 := 1000
    static DVDECODERRESOLUTION_360x240 := 1001
    static DVDECODERRESOLUTION_180x120 := 1002
    static DVDECODERRESOLUTION_88x60 := 1003
}
struct DVRESOLUTION extends Int32 {
    static DVRESOLUTION_FULL := 1000
    static DVRESOLUTION_HALF := 1001
    static DVRESOLUTION_QUARTER := 1002
    static DVRESOLUTION_DC := 1003
}
struct IIPDVDec extends IUnknown {
    static IID := "{B8E8BD60-0BFE-11D0-AF91-00AA00B67A42}"
    get_IPDisplay(displayPix)
      => ComCall(3, this.p, Int32.Ptr, displayPix)
    put_IPDisplay(displayPix)
      => ComCall(4, this.p, Int32, displayPix)
}
struct IDVRGB219 extends IUnknown {
    static IID := "{58473A19-2BC8-4663-8012-25F81BABDDD1}"
    SetRGB219(bState)
      => ComCall(3, this.p, BOOL, bState)
}
struct IDVSplitter extends IUnknown {
    static IID := "{92A3A302-DA7C-4A1F-BA7E-1802BB5D2D02}"
    DiscardAlternateVideoFrames(nDiscard)
      => ComCall(3, this.p, Int32, nDiscard)
}
struct AM_AUDIO_RENDERER_STAT_PARAM extends Int32 {
    static AM_AUDREND_STAT_PARAM_BREAK_COUNT := 1
    static AM_AUDREND_STAT_PARAM_SLAVE_MODE := 2
    static AM_AUDREND_STAT_PARAM_SILENCE_DUR := 3
    static AM_AUDREND_STAT_PARAM_LAST_BUFFER_DUR := 4
    static AM_AUDREND_STAT_PARAM_DISCONTINUITIES := 5
    static AM_AUDREND_STAT_PARAM_SLAVE_RATE := 6
    static AM_AUDREND_STAT_PARAM_SLAVE_DROPWRITE_DUR := 7
    static AM_AUDREND_STAT_PARAM_SLAVE_HIGHLOWERROR := 8
    static AM_AUDREND_STAT_PARAM_SLAVE_LASTHIGHLOWERROR := 9
    static AM_AUDREND_STAT_PARAM_SLAVE_ACCUMERROR := 10
    static AM_AUDREND_STAT_PARAM_BUFFERFULLNESS := 11
    static AM_AUDREND_STAT_PARAM_JITTER := 12
}
struct IAMAudioRendererStats extends IUnknown {
    static IID := "{22320CB2-D41A-11D2-BF7C-D7CB9DF0BF93}"
    GetStatParam(dwParam, pdwParam1, pdwParam2)
      => ComCall(3, this.p, UInt32, dwParam, UInt32.Ptr, pdwParam1, UInt32.Ptr, pdwParam2)
}
struct AM_INTF_SEARCH_FLAGS extends Int32 {
    static AM_INTF_SEARCH_INPUT_PIN := 1
    static AM_INTF_SEARCH_OUTPUT_PIN := 2
    static AM_INTF_SEARCH_FILTER := 4
}
struct IAMGraphStreams extends IUnknown {
    static IID := "{632105FA-072E-11D3-8AF9-00C04FB6BD3D}"
    FindUpstreamInterface(pPin, riid, ppvInterface, dwFlags)
      => ComCall(3, this.p, IPin, pPin, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvInterface, UInt32, dwFlags)
    SyncUsingStreamOffset(bUseStreamOffset)
      => ComCall(4, this.p, BOOL, bUseStreamOffset)
    SetMaxGraphLatency(rtMaxGraphLatency)
      => ComCall(5, this.p, Int64, rtMaxGraphLatency)
}
struct AMOVERLAYFX extends Int32 {
    static AMOVERFX_NOFX := 0
    static AMOVERFX_MIRRORLEFTRIGHT := 2
    static AMOVERFX_MIRRORUPDOWN := 4
    static AMOVERFX_DEINTERLACE := 8
}
struct IAMOverlayFX extends IUnknown {
    static IID := "{62FAE250-7E65-4460-BFC9-6398B322073C}"
    QueryOverlayFXCaps(lpdwOverlayFXCaps)
      => ComCall(3, this.p, UInt32.Ptr, lpdwOverlayFXCaps)
    SetOverlayFX(dwOverlayFX)
      => ComCall(4, this.p, UInt32, dwOverlayFX)
    GetOverlayFX(lpdwOverlayFX)
      => ComCall(5, this.p, UInt32.Ptr, lpdwOverlayFX)
}
struct IAMOpenProgress extends IUnknown {
    static IID := "{8E1C39A1-DE53-11CF-AA63-0080C744528D}"
    QueryProgress(pllTotal, pllCurrent)
      => ComCall(3, this.p, Int64.Ptr, pllTotal, Int64.Ptr, pllCurrent)
    AbortOperation()
      => ComCall(4, this.p)
}
struct IMpeg2Demultiplexer extends IUnknown {
    static IID := "{436EEE9C-264F-4242-90E1-4E330C107512}"
    CreateOutputPin(pMediaType, pszPinName, ppIPin)
      => ComCall(3, this.p, AM_MEDIA_TYPE.Ptr, pMediaType, "Str", pszPinName, IPin.Ptr, ppIPin)
    SetOutputPinMediaType(pszPinName, pMediaType)
      => ComCall(4, this.p, "Str", pszPinName, AM_MEDIA_TYPE.Ptr, pMediaType)
    DeleteOutputPin(pszPinName)
      => ComCall(5, this.p, "Str", pszPinName)
}
struct STREAM_ID_MAP {
    stream_id : UInt32
    dwMediaSampleContent : UInt32
    ulSubstreamFilterValue : UInt32
    iDataOffset : Int32
}
struct IEnumStreamIdMap extends IUnknown {
    static IID := "{945C1566-6202-46FC-96C7-D87F289C6534}"
    Next(pStreamIdMap, pcReceived?)
      => ComCall(3, this.p, UInt32, pStreamIdMap.Length, STREAM_ID_MAP.Ptr, pStreamIdMap, UInt32.Ptr, pcReceived?)
    Skip(cRecords)
      => ComCall(4, this.p, UInt32, cRecords)
    Reset()
      => ComCall(5, this.p)
    Clone(ppIEnumStreamIdMap)
      => ComCall(6, this.p, IEnumStreamIdMap.Ptr, ppIEnumStreamIdMap)
}
struct IMPEG2StreamIdMap extends IUnknown {
    static IID := "{D0E04C47-25B8-4369-925A-362A01D95444}"
    MapStreamId(ulStreamId, MediaSampleContent, ulSubstreamFilterValue, iDataOffset)
      => ComCall(3, this.p, UInt32, ulStreamId, UInt32, MediaSampleContent, UInt32, ulSubstreamFilterValue, Int32, iDataOffset)
    UnmapStreamId(pulStreamId)
      => ComCall(4, this.p, UInt32, pulStreamId.Length, UInt32.Ptr, pulStreamId)
    EnumStreamIdMap(ppIEnumStreamIdMap)
      => ComCall(5, this.p, IEnumStreamIdMap.Ptr, ppIEnumStreamIdMap)
}
struct IRegisterServiceProvider extends IUnknown {
    static IID := "{7B3A2F01-0751-48DD-B556-004785171C54}"
    RegisterService(guidService, pUnkObject)
      => ComCall(3, this.p, GUID.Ptr, guidService, IUnknown, pUnkObject)
}
struct IAMClockSlave extends IUnknown {
    static IID := "{9FD52741-176D-4B36-8F51-CA8F933223BE}"
    SetErrorTolerance(dwTolerance)
      => ComCall(3, this.p, UInt32, dwTolerance)
    GetErrorTolerance(pdwTolerance)
      => ComCall(4, this.p, UInt32.Ptr, pdwTolerance)
}
struct IAMGraphBuilderCallback extends IUnknown {
    static IID := "{4995F511-9DDB-4F12-BD3B-F04611807B79}"
    SelectedFilter(pMon)
      => ComCall(3, this.p, IMoniker, pMon)
    CreatedFilter(pFil)
      => ComCall(4, this.p, IBaseFilter, pFil)
}
struct IAMFilterGraphCallback extends IUnknown {
    static IID := "{56A868FD-0AD4-11CE-B0A3-0020AF0BA770}"
    UnableToRender(pPin)
      => ComCall(3, this.p, IPin, pPin)
}
struct IGetCapabilitiesKey extends IUnknown {
    static IID := "{A8809222-07BB-48EA-951C-33158100625B}"
    GetCapabilitiesKey(pHKey)
      => ComCall(3, this.p, HKEY.Ptr, pHKey)
}
struct IEncoderAPI extends IUnknown {
    static IID := "{70423839-6ACC-4B23-B079-21DBF08156A5}"
    IsSupported(Api)
      => ComCall(3, this.p, GUID.Ptr, Api)
    IsAvailable(Api)
      => ComCall(4, this.p, GUID.Ptr, Api)
    GetParameterRange(Api, ValueMin, ValueMax, SteppingDelta)
      => ComCall(5, this.p, GUID.Ptr, Api, VARIANT.Ptr, ValueMin, VARIANT.Ptr, ValueMax, VARIANT.Ptr, SteppingDelta)
    GetParameterValues(Api, Values, ValuesCount)
      => ComCall(6, this.p, GUID.Ptr, Api, VARIANT.Ptr.Ptr, Values, UInt32.Ptr, ValuesCount)
    GetDefaultValue(Api, Value)
      => ComCall(7, this.p, GUID.Ptr, Api, VARIANT.Ptr, Value)
    GetValue(Api, Value)
      => ComCall(8, this.p, GUID.Ptr, Api, VARIANT.Ptr, Value)
    SetValue(Api, Value)
      => ComCall(9, this.p, GUID.Ptr, Api, VARIANT.Ptr, Value)
}
struct IVideoEncoder extends IEncoderAPI {
    static IID := "{02997C3B-8E1B-460E-9270-545E0DE9563E}"
}
struct IAMDecoderCaps extends IUnknown {
    static IID := "{C0DFF467-D499-4986-972B-E1D9090FA941}"
    GetDecoderCaps(dwCapIndex, lpdwCap)
      => ComCall(3, this.p, UInt32, dwCapIndex, UInt32.Ptr, lpdwCap)
}
struct AMCOPPSignature {
    Signature : UInt8[256]
}
struct AMCOPPCommand {
    macKDI : GUID
    guidCommandID : GUID
    dwSequence : UInt32
    cbSizeData : UInt32
    CommandData : UInt8[4056]
}
struct AMCOPPStatusInput {
    rApp : GUID
    guidStatusRequestID : GUID
    dwSequence : UInt32
    cbSizeData : UInt32
    StatusData : UInt8[4056]
}
struct AMCOPPStatusOutput {
    macKDI : GUID
    cbSizeData : UInt32
    COPPStatus : UInt8[4076]
}
struct IAMCertifiedOutputProtection extends IUnknown {
    static IID := "{6FEDED3E-0FF1-4901-A2F1-43F7012C8515}"
    KeyExchange(pRandom, VarLenCertGH, pdwLengthCertGH)
      => ComCall(3, this.p, GUID.Ptr, pRandom, UInt8.Ptr.Ptr, VarLenCertGH, UInt32.Ptr, pdwLengthCertGH)
    SessionSequenceStart(pSig)
      => ComCall(4, this.p, AMCOPPSignature.Ptr, pSig)
    ProtectionCommand(cmd)
      => ComCall(5, this.p, AMCOPPCommand.Ptr, cmd)
    ProtectionStatus(pStatusInput, pStatusOutput)
      => ComCall(6, this.p, AMCOPPStatusInput.Ptr, pStatusInput, AMCOPPStatusOutput.Ptr, pStatusOutput)
}
struct IAMAsyncReaderTimestampScaling extends IUnknown {
    static IID := "{CF7B26FC-9A00-485B-8147-3E789D5E8F67}"
    GetTimestampMode(pfRaw)
      => ComCall(3, this.p, BOOL.Ptr, pfRaw)
    SetTimestampMode(fRaw)
      => ComCall(4, this.p, BOOL, fRaw)
}
struct IAMPluginControl extends IUnknown {
    static IID := "{0E26A181-F40C-4635-8786-976284B52981}"
    GetPreferredClsid(subType, clsid)
      => ComCall(3, this.p, GUID.Ptr, subType, GUID.Ptr, clsid)
    GetPreferredClsidByIndex(index, subType, clsid)
      => ComCall(4, this.p, UInt32, index, GUID.Ptr, subType, GUID.Ptr, clsid)
    SetPreferredClsid(subType, clsid?)
      => ComCall(5, this.p, GUID.Ptr, subType, GUID.Ptr, clsid?)
    IsDisabled(clsid)
      => ComCall(6, this.p, GUID.Ptr, clsid)
    GetDisabledByIndex(index, clsid)
      => ComCall(7, this.p, UInt32, index, GUID.Ptr, clsid)
    SetDisabled(clsid, disabled)
      => ComCall(8, this.p, GUID.Ptr, clsid, BOOL, disabled)
    IsLegacyDisabled(dllName)
      => ComCall(9, this.p, "Str", dllName)
}
struct IPinConnection extends IUnknown {
    static IID := "{4A9A62D3-27D4-403D-91E9-89F540E55534}"
    DynamicQueryAccept(pmt)
      => ComCall(3, this.p, AM_MEDIA_TYPE.Ptr, pmt)
    NotifyEndOfStream(hNotifyEvent)
      => ComCall(4, this.p, HANDLE, hNotifyEvent)
    IsEndPin()
      => ComCall(5, this.p)
    DynamicDisconnect()
      => ComCall(6, this.p)
}
struct IPinFlowControl extends IUnknown {
    static IID := "{C56E9858-DBF3-4F6B-8119-384AF2060DEB}"
    Block(dwBlockFlags, hEvent)
      => ComCall(3, this.p, UInt32, dwBlockFlags, HANDLE, hEvent)
}
struct AM_PIN_FLOW_CONTROL_BLOCK_FLAGS extends Int32 {
    static AM_PIN_FLOW_CONTROL_BLOCK := 1
}
struct AM_GRAPH_CONFIG_RECONNECT_FLAGS extends Int32 {
    static AM_GRAPH_CONFIG_RECONNECT_DIRECTCONNECT := 1
    static AM_GRAPH_CONFIG_RECONNECT_CACHE_REMOVED_FILTERS := 2
    static AM_GRAPH_CONFIG_RECONNECT_USE_ONLY_CACHED_FILTERS := 4
}
struct REM_FILTER_FLAGS extends Int32 {
    static REMFILTERF_LEAVECONNECTED := 1
}
struct AM_FILTER_FLAGS extends Int32 {
    static AM_FILTER_FLAGS_REMOVABLE := 1
}
struct IGraphConfig extends IUnknown {
    static IID := "{03A1EB8E-32BF-4245-8502-114D08A9CB88}"
    Reconnect(pOutputPin, pInputPin, pmtFirstConnection, pUsingFilter, hAbortEvent, dwFlags)
      => ComCall(3, this.p, IPin, pOutputPin, IPin, pInputPin, AM_MEDIA_TYPE.Ptr, pmtFirstConnection, IBaseFilter, pUsingFilter, HANDLE, hAbortEvent, UInt32, dwFlags)
    Reconfigure(pCallback, pvContext, dwFlags, hAbortEvent)
      => ComCall(4, this.p, IGraphConfigCallback, pCallback, Struct.Ptr, pvContext, UInt32, dwFlags, HANDLE, hAbortEvent)
    AddFilterToCache(pFilter)
      => ComCall(5, this.p, IBaseFilter, pFilter)
    EnumCacheFilter(pEnum)
      => ComCall(6, this.p, IEnumFilters.Ptr, pEnum)
    RemoveFilterFromCache(pFilter)
      => ComCall(7, this.p, IBaseFilter, pFilter)
    GetStartTime(prtStart)
      => ComCall(8, this.p, Int64.Ptr, prtStart)
    PushThroughData(pOutputPin, pConnection, hEventAbort)
      => ComCall(9, this.p, IPin, pOutputPin, IPinConnection, pConnection, HANDLE, hEventAbort)
    SetFilterFlags(pFilter, dwFlags)
      => ComCall(10, this.p, IBaseFilter, pFilter, UInt32, dwFlags)
    GetFilterFlags(pFilter, pdwFlags)
      => ComCall(11, this.p, IBaseFilter, pFilter, UInt32.Ptr, pdwFlags)
    RemoveFilterEx(pFilter, Flags)
      => ComCall(12, this.p, IBaseFilter, pFilter, UInt32, Flags)
}
struct IGraphConfigCallback extends IUnknown {
    static IID := "{ADE0FD60-D19D-11D2-ABF6-00A0C905F375}"
    Reconfigure(pvContext, dwFlags)
      => ComCall(3, this.p, Struct.Ptr, pvContext, UInt32, dwFlags)
}
struct IFilterChain extends IUnknown {
    static IID := "{DCFBDCF6-0DC2-45F5-9AB2-7C330EA09C29}"
    StartChain(pStartFilter, pEndFilter)
      => ComCall(3, this.p, IBaseFilter, pStartFilter, IBaseFilter, pEndFilter)
    PauseChain(pStartFilter, pEndFilter)
      => ComCall(4, this.p, IBaseFilter, pStartFilter, IBaseFilter, pEndFilter)
    StopChain(pStartFilter, pEndFilter)
      => ComCall(5, this.p, IBaseFilter, pStartFilter, IBaseFilter, pEndFilter)
    RemoveChain(pStartFilter, pEndFilter)
      => ComCall(6, this.p, IBaseFilter, pStartFilter, IBaseFilter, pEndFilter)
}
struct VMRPresentationFlags extends Int32 {
    static VMRSample_SyncPoint := 1
    static VMRSample_Preroll := 2
    static VMRSample_Discontinuity := 4
    static VMRSample_TimeValid := 8
    static VMRSample_SrcDstRectsValid := 16
}
struct VMRPRESENTATIONINFO {
    dwFlags : UInt32
    lpSurf : IDirectDrawSurface7
    rtStart : Int64
    rtEnd : Int64
    szAspectRatio : SIZE
    rcSrc : RECT
    rcDst : RECT
    dwTypeSpecificFlags : UInt32
    dwInterlaceFlags : UInt32
}
struct IVMRImagePresenter extends IUnknown {
    static IID := "{CE704FE7-E71E-41FB-BAA2-C4403E1182F5}"
    StartPresenting(dwUserID)
      => ComCall(3, this.p, IntPtr, dwUserID)
    StopPresenting(dwUserID)
      => ComCall(4, this.p, IntPtr, dwUserID)
    PresentImage(dwUserID, lpPresInfo)
      => ComCall(5, this.p, IntPtr, dwUserID, VMRPRESENTATIONINFO.Ptr, lpPresInfo)
}
struct VMRSurfaceAllocationFlags extends Int32 {
    static AMAP_PIXELFORMAT_VALID := 1
    static AMAP_3D_TARGET := 2
    static AMAP_ALLOW_SYSMEM := 4
    static AMAP_FORCE_SYSMEM := 8
    static AMAP_DIRECTED_FLIP := 16
    static AMAP_DXVA_TARGET := 32
}
struct VMRALLOCATIONINFO {
    dwFlags : UInt32
    lpHdr : BITMAPINFOHEADER.Ptr
    lpPixFmt : DDPIXELFORMAT.Ptr
    szAspectRatio : SIZE
    dwMinBuffers : UInt32
    dwMaxBuffers : UInt32
    dwInterlaceFlags : UInt32
    szNativeSize : SIZE
}
struct IVMRSurfaceAllocator extends IUnknown {
    static IID := "{31CE832E-4484-458B-8CCA-F4D7E3DB0B52}"
    AllocateSurface(dwUserID, lpAllocInfo, lpdwActualBuffers, lplpSurface)
      => ComCall(3, this.p, IntPtr, dwUserID, VMRALLOCATIONINFO.Ptr, lpAllocInfo, UInt32.Ptr, lpdwActualBuffers, IDirectDrawSurface7.Ptr, lplpSurface)
    FreeSurface(dwID)
      => ComCall(4, this.p, IntPtr, dwID)
    PrepareSurface(dwUserID, lpSurface, dwSurfaceFlags)
      => ComCall(5, this.p, IntPtr, dwUserID, IDirectDrawSurface7, lpSurface, UInt32, dwSurfaceFlags)
    AdviseNotify(lpIVMRSurfAllocNotify)
      => ComCall(6, this.p, IVMRSurfaceAllocatorNotify, lpIVMRSurfAllocNotify)
}
struct IVMRSurfaceAllocatorNotify extends IUnknown {
    static IID := "{AADA05A8-5A4E-4729-AF0B-CEA27AED51E2}"
    AdviseSurfaceAllocator(dwUserID, lpIVRMSurfaceAllocator)
      => ComCall(3, this.p, IntPtr, dwUserID, IVMRSurfaceAllocator, lpIVRMSurfaceAllocator)
    SetDDrawDevice(lpDDrawDevice, hMonitor1)
      => ComCall(4, this.p, IDirectDraw7, lpDDrawDevice, HMONITOR, hMonitor1)
    ChangeDDrawDevice(lpDDrawDevice, hMonitor1)
      => ComCall(5, this.p, IDirectDraw7, lpDDrawDevice, HMONITOR, hMonitor1)
    RestoreDDrawSurfaces()
      => ComCall(6, this.p)
    NotifyEvent(EventCode, Param1, Param2)
      => ComCall(7, this.p, Int32, EventCode, IntPtr, Param1, IntPtr, Param2)
    SetBorderColor(clrBorder)
      => ComCall(8, this.p, COLORREF, clrBorder)
}
struct VMR_ASPECT_RATIO_MODE extends Int32 {
    static VMR_ARMODE_NONE := 0
    static VMR_ARMODE_LETTER_BOX := 1
}
struct IVMRWindowlessControl extends IUnknown {
    static IID := "{0EB1088C-4DCD-46F0-878F-39DAE86A51B7}"
    GetNativeVideoSize(lpWidth, lpHeight, lpARWidth, lpARHeight)
      => ComCall(3, this.p, Int32.Ptr, lpWidth, Int32.Ptr, lpHeight, Int32.Ptr, lpARWidth, Int32.Ptr, lpARHeight)
    GetMinIdealVideoSize(lpWidth, lpHeight)
      => ComCall(4, this.p, Int32.Ptr, lpWidth, Int32.Ptr, lpHeight)
    GetMaxIdealVideoSize(lpWidth, lpHeight)
      => ComCall(5, this.p, Int32.Ptr, lpWidth, Int32.Ptr, lpHeight)
    SetVideoPosition(lpSRCRect, lpDSTRect)
      => ComCall(6, this.p, RECT.Ptr, lpSRCRect, RECT.Ptr, lpDSTRect)
    GetVideoPosition(lpSRCRect, lpDSTRect)
      => ComCall(7, this.p, RECT.Ptr, lpSRCRect, RECT.Ptr, lpDSTRect)
    GetAspectRatioMode(lpAspectRatioMode)
      => ComCall(8, this.p, UInt32.Ptr, lpAspectRatioMode)
    SetAspectRatioMode(AspectRatioMode)
      => ComCall(9, this.p, UInt32, AspectRatioMode)
    SetVideoClippingWindow(hwnd1)
      => ComCall(10, this.p, HWND, hwnd1)
    RepaintVideo(hwnd1, hdc1)
      => ComCall(11, this.p, HWND, hwnd1, HDC, hdc1)
    DisplayModeChanged()
      => ComCall(12, this.p)
    GetCurrentImage(lpDib)
      => ComCall(13, this.p, UInt8.Ptr.Ptr, lpDib)
    SetBorderColor(Clr)
      => ComCall(14, this.p, COLORREF, Clr)
    GetBorderColor(lpClr)
      => ComCall(15, this.p, COLORREF.Ptr, lpClr)
    SetColorKey(Clr)
      => ComCall(16, this.p, COLORREF, Clr)
    GetColorKey(lpClr)
      => ComCall(17, this.p, COLORREF.Ptr, lpClr)
}
struct VMRMixerPrefs extends Int32 {
    static MixerPref_NoDecimation := 1
    static MixerPref_DecimateOutput := 2
    static MixerPref_ARAdjustXorY := 4
    static MixerPref_DecimationReserved := 8
    static MixerPref_DecimateMask := 15
    static MixerPref_BiLinearFiltering := 16
    static MixerPref_PointFiltering := 32
    static MixerPref_FilteringMask := 240
    static MixerPref_RenderTargetRGB := 256
    static MixerPref_RenderTargetYUV := 4096
    static MixerPref_RenderTargetYUV420 := 512
    static MixerPref_RenderTargetYUV422 := 1024
    static MixerPref_RenderTargetYUV444 := 2048
    static MixerPref_RenderTargetReserved := 57344
    static MixerPref_RenderTargetMask := 65280
    static MixerPref_DynamicSwitchToBOB := 65536
    static MixerPref_DynamicDecimateBy2 := 131072
    static MixerPref_DynamicReserved := 786432
    static MixerPref_DynamicMask := 983040
}
struct NORMALIZEDRECT {
    left : Float32
    top : Float32
    right : Float32
    bottom : Float32
}
struct IVMRMixerControl extends IUnknown {
    static IID := "{1C1A17B0-BED0-415D-974B-DC6696131599}"
    SetAlpha(dwStreamID, Alpha)
      => ComCall(3, this.p, UInt32, dwStreamID, Float32, Alpha)
    GetAlpha(dwStreamID, pAlpha)
      => ComCall(4, this.p, UInt32, dwStreamID, Float32.Ptr, pAlpha)
    SetZOrder(dwStreamID, dwZ)
      => ComCall(5, this.p, UInt32, dwStreamID, UInt32, dwZ)
    GetZOrder(dwStreamID, pZ)
      => ComCall(6, this.p, UInt32, dwStreamID, UInt32.Ptr, pZ)
    SetOutputRect(dwStreamID, pRect)
      => ComCall(7, this.p, UInt32, dwStreamID, NORMALIZEDRECT.Ptr, pRect)
    GetOutputRect(dwStreamID, pRect)
      => ComCall(8, this.p, UInt32, dwStreamID, NORMALIZEDRECT.Ptr, pRect)
    SetBackgroundClr(ClrBkg)
      => ComCall(9, this.p, COLORREF, ClrBkg)
    GetBackgroundClr(lpClrBkg)
      => ComCall(10, this.p, COLORREF.Ptr, lpClrBkg)
    SetMixingPrefs(dwMixerPrefs)
      => ComCall(11, this.p, UInt32, dwMixerPrefs)
    GetMixingPrefs(pdwMixerPrefs)
      => ComCall(12, this.p, UInt32.Ptr, pdwMixerPrefs)
}
struct VMRGUID {
    pGUID : GUID.Ptr
    GUID : GUID
}
struct VMRMONITORINFO {
    guid : VMRGUID
    rcMonitor : RECT
    hMon : HMONITOR
    dwFlags : UInt32
    szDevice : UInt16[32]
    szDescription : UInt16[256]
    liDriverVersion : Int64
    dwVendorId : UInt32
    dwDeviceId : UInt32
    dwSubSysId : UInt32
    dwRevision : UInt32
}
struct IVMRMonitorConfig extends IUnknown {
    static IID := "{9CF0B1B6-FBAA-4B7F-88CF-CF1F130A0DCE}"
    SetMonitor(pGUID)
      => ComCall(3, this.p, VMRGUID.Ptr, pGUID)
    GetMonitor(pGUID)
      => ComCall(4, this.p, VMRGUID.Ptr, pGUID)
    SetDefaultMonitor(pGUID)
      => ComCall(5, this.p, VMRGUID.Ptr, pGUID)
    GetDefaultMonitor(pGUID)
      => ComCall(6, this.p, VMRGUID.Ptr, pGUID)
    GetAvailableMonitors(pInfo, pdwNumDevices)
      => ComCall(7, this.p, VMRMONITORINFO.Ptr, pInfo, UInt32, pInfo.Length, UInt32.Ptr, pdwNumDevices)
}
struct VMRRenderPrefs extends Int32 {
    static RenderPrefs_RestrictToInitialMonitor := 0
    static RenderPrefs_ForceOffscreen := 1
    static RenderPrefs_ForceOverlays := 2
    static RenderPrefs_AllowOverlays := 0
    static RenderPrefs_AllowOffscreen := 0
    static RenderPrefs_DoNotRenderColorKeyAndBorder := 8
    static RenderPrefs_Reserved := 16
    static RenderPrefs_PreferAGPMemWhenMixing := 32
    static RenderPrefs_Mask := 63
}
struct VMRMode extends Int32 {
    static VMRMode_Windowed := 1
    static VMRMode_Windowless := 2
    static VMRMode_Renderless := 4
    static VMRMode_Mask := 7
}
struct STREAMIF_CONSTANTS extends Int32 {
    static MAX_NUMBER_OF_STREAMS := 16
}
struct IVMRFilterConfig extends IUnknown {
    static IID := "{9E5530C5-7034-48B4-BB46-0B8A6EFC8E36}"
    SetImageCompositor(lpVMRImgCompositor)
      => ComCall(3, this.p, IVMRImageCompositor, lpVMRImgCompositor)
    SetNumberOfStreams(dwMaxStreams)
      => ComCall(4, this.p, UInt32, dwMaxStreams)
    GetNumberOfStreams(pdwMaxStreams)
      => ComCall(5, this.p, UInt32.Ptr, pdwMaxStreams)
    SetRenderingPrefs(dwRenderFlags)
      => ComCall(6, this.p, UInt32, dwRenderFlags)
    GetRenderingPrefs(pdwRenderFlags)
      => ComCall(7, this.p, UInt32.Ptr, pdwRenderFlags)
    SetRenderingMode(Mode)
      => ComCall(8, this.p, UInt32, Mode)
    GetRenderingMode(pMode)
      => ComCall(9, this.p, UInt32.Ptr, pMode)
}
struct IVMRAspectRatioControl extends IUnknown {
    static IID := "{EDE80B5C-BAD6-4623-B537-65586C9F8DFD}"
    GetAspectRatioMode(lpdwARMode)
      => ComCall(3, this.p, UInt32.Ptr, lpdwARMode)
    SetAspectRatioMode(dwARMode)
      => ComCall(4, this.p, UInt32, dwARMode)
}
struct VMRDeinterlacePrefs extends Int32 {
    static DeinterlacePref_NextBest := 1
    static DeinterlacePref_BOB := 2
    static DeinterlacePref_Weave := 4
    static DeinterlacePref_Mask := 7
}
struct VMRDeinterlaceTech extends Int32 {
    static DeinterlaceTech_Unknown := 0
    static DeinterlaceTech_BOBLineReplicate := 1
    static DeinterlaceTech_BOBVerticalStretch := 2
    static DeinterlaceTech_MedianFiltering := 4
    static DeinterlaceTech_EdgeFiltering := 16
    static DeinterlaceTech_FieldAdaptive := 32
    static DeinterlaceTech_PixelAdaptive := 64
    static DeinterlaceTech_MotionVectorSteered := 128
}
struct VMRFrequency {
    dwNumerator : UInt32
    dwDenominator : UInt32
}
struct VMRVideoDesc {
    dwSize : UInt32
    dwSampleWidth : UInt32
    dwSampleHeight : UInt32
    SingleFieldPerSample : BOOL
    dwFourCC : UInt32
    InputSampleFreq : VMRFrequency
    OutputFrameFreq : VMRFrequency
}
struct VMRDeinterlaceCaps {
    dwSize : UInt32
    dwNumPreviousOutputFrames : UInt32
    dwNumForwardRefSamples : UInt32
    dwNumBackwardRefSamples : UInt32
    DeinterlaceTechnology : VMRDeinterlaceTech
}
struct IVMRDeinterlaceControl extends IUnknown {
    static IID := "{BB057577-0DB8-4E6A-87A7-1A8C9A505A0F}"
    GetNumberOfDeinterlaceModes(lpVideoDescription, lpdwNumDeinterlaceModes, lpDeinterlaceModes)
      => ComCall(3, this.p, VMRVideoDesc.Ptr, lpVideoDescription, UInt32.Ptr, lpdwNumDeinterlaceModes, GUID.Ptr, lpDeinterlaceModes)
    GetDeinterlaceModeCaps(lpDeinterlaceMode, lpVideoDescription, lpDeinterlaceCaps)
      => ComCall(4, this.p, GUID.Ptr, lpDeinterlaceMode, VMRVideoDesc.Ptr, lpVideoDescription, VMRDeinterlaceCaps.Ptr, lpDeinterlaceCaps)
    GetDeinterlaceMode(dwStreamID, lpDeinterlaceMode)
      => ComCall(5, this.p, UInt32, dwStreamID, GUID.Ptr, lpDeinterlaceMode)
    SetDeinterlaceMode(dwStreamID, lpDeinterlaceMode)
      => ComCall(6, this.p, UInt32, dwStreamID, GUID.Ptr, lpDeinterlaceMode)
    GetDeinterlacePrefs(lpdwDeinterlacePrefs)
      => ComCall(7, this.p, UInt32.Ptr, lpdwDeinterlacePrefs)
    SetDeinterlacePrefs(dwDeinterlacePrefs)
      => ComCall(8, this.p, UInt32, dwDeinterlacePrefs)
    GetActualDeinterlaceMode(dwStreamID, lpDeinterlaceMode)
      => ComCall(9, this.p, UInt32, dwStreamID, GUID.Ptr, lpDeinterlaceMode)
}
struct VMRALPHABITMAP {
    dwFlags : UInt32
    hdc : HDC
    pDDS : IDirectDrawSurface7
    rSrc : RECT
    rDest : NORMALIZEDRECT
    fAlpha : Float32
    clrSrcKey : COLORREF
}
struct IVMRMixerBitmap extends IUnknown {
    static IID := "{1E673275-0257-40AA-AF20-7C608D4A0428}"
    SetAlphaBitmap(pBmpParms)
      => ComCall(3, this.p, VMRALPHABITMAP.Ptr, pBmpParms)
    UpdateAlphaBitmapParameters(pBmpParms)
      => ComCall(4, this.p, VMRALPHABITMAP.Ptr, pBmpParms)
    GetAlphaBitmapParameters(pBmpParms)
      => ComCall(5, this.p, VMRALPHABITMAP.Ptr, pBmpParms)
}
struct VMRVIDEOSTREAMINFO {
    pddsVideoSurface : IDirectDrawSurface7
    dwWidth : UInt32
    dwHeight : UInt32
    dwStrmID : UInt32
    fAlpha : Float32
    ddClrKey : DDCOLORKEY
    rNormal : NORMALIZEDRECT
}
struct IVMRImageCompositor extends IUnknown {
    static IID := "{7A4FB5AF-479F-4074-BB40-CE6722E43C82}"
    InitCompositionTarget(pD3DDevice, pddsRenderTarget)
      => ComCall(3, this.p, IUnknown, pD3DDevice, IDirectDrawSurface7, pddsRenderTarget)
    TermCompositionTarget(pD3DDevice, pddsRenderTarget)
      => ComCall(4, this.p, IUnknown, pD3DDevice, IDirectDrawSurface7, pddsRenderTarget)
    SetStreamMediaType(dwStrmID, pmt, fTexture)
      => ComCall(5, this.p, UInt32, dwStrmID, AM_MEDIA_TYPE.Ptr, pmt, BOOL, fTexture)
    CompositeImage(pD3DDevice, pddsRenderTarget, pmtRenderTarget, rtStart, rtEnd, dwClrBkGnd, pVideoStreamInfo, cStreams)
      => ComCall(6, this.p, IUnknown, pD3DDevice, IDirectDrawSurface7, pddsRenderTarget, AM_MEDIA_TYPE.Ptr, pmtRenderTarget, Int64, rtStart, Int64, rtEnd, UInt32, dwClrBkGnd, VMRVIDEOSTREAMINFO.Ptr, pVideoStreamInfo, UInt32, cStreams)
}
struct IVMRVideoStreamControl extends IUnknown {
    static IID := "{058D1F11-2A54-4BEF-BD54-DF706626B727}"
    SetColorKey(lpClrKey)
      => ComCall(3, this.p, DDCOLORKEY.Ptr, lpClrKey)
    GetColorKey(lpClrKey)
      => ComCall(4, this.p, DDCOLORKEY.Ptr, lpClrKey)
    SetStreamActiveState(fActive)
      => ComCall(5, this.p, BOOL, fActive)
    GetStreamActiveState(lpfActive)
      => ComCall(6, this.p, BOOL.Ptr, lpfActive)
}
struct IVMRSurface extends IUnknown {
    static IID := "{A9849BBE-9EC8-4263-B764-62730F0D15D0}"
    IsSurfaceLocked()
      => ComCall(3, this.p)
    LockSurface(lpSurface)
      => ComCall(4, this.p, UInt8.Ptr.Ptr, lpSurface)
    UnlockSurface()
      => ComCall(5, this.p)
    GetSurface(lplpSurface)
      => ComCall(6, this.p, IDirectDrawSurface7.Ptr, lplpSurface)
}
struct IVMRImagePresenterConfig extends IUnknown {
    static IID := "{9F3A1C85-8555-49BA-935F-BE5B5B29D178}"
    SetRenderingPrefs(dwRenderFlags)
      => ComCall(3, this.p, UInt32, dwRenderFlags)
    GetRenderingPrefs(dwRenderFlags)
      => ComCall(4, this.p, UInt32.Ptr, dwRenderFlags)
}
struct IVMRImagePresenterExclModeConfig extends IVMRImagePresenterConfig {
    static IID := "{E6F7CE40-4673-44F1-8F77-5499D68CB4EA}"
    SetXlcModeDDObjAndPrimarySurface(lpDDObj, lpPrimarySurf)
      => ComCall(5, this.p, IDirectDraw7, lpDDObj, IDirectDrawSurface7, lpPrimarySurf)
    GetXlcModeDDObjAndPrimarySurface(lpDDObj, lpPrimarySurf)
      => ComCall(6, this.p, IDirectDraw7.Ptr, lpDDObj, IDirectDrawSurface7.Ptr, lpPrimarySurf)
}
struct IVPManager extends IUnknown {
    static IID := "{AAC18C18-E186-46D2-825D-A1F8DC8E395A}"
    SetVideoPortIndex(dwVideoPortIndex)
      => ComCall(3, this.p, UInt32, dwVideoPortIndex)
    GetVideoPortIndex(pdwVideoPortIndex)
      => ComCall(4, this.p, UInt32.Ptr, pdwVideoPortIndex)
}
struct DVD_DOMAIN extends Int32 {
    static DVD_DOMAIN_FirstPlay := 1
    static DVD_DOMAIN_VideoManagerMenu := 2
    static DVD_DOMAIN_VideoTitleSetMenu := 3
    static DVD_DOMAIN_Title := 4
    static DVD_DOMAIN_Stop := 5
}
struct DVD_MENU_ID extends Int32 {
    static DVD_MENU_Title := 2
    static DVD_MENU_Root := 3
    static DVD_MENU_Subpicture := 4
    static DVD_MENU_Audio := 5
    static DVD_MENU_Angle := 6
    static DVD_MENU_Chapter := 7
}
struct DVD_DISC_SIDE extends Int32 {
    static DVD_SIDE_A := 1
    static DVD_SIDE_B := 2
}
struct DVD_PREFERRED_DISPLAY_MODE extends Int32 {
    static DISPLAY_CONTENT_DEFAULT := 0
    static DISPLAY_16x9 := 1
    static DISPLAY_4x3_PANSCAN_PREFERRED := 2
    static DISPLAY_4x3_LETTERBOX_PREFERRED := 3
}
struct DVD_ATR {
    ulCAT : UInt32
    pbATRI : UInt8[768]
}
struct DVD_FRAMERATE extends Int32 {
    static DVD_FPS_25 := 1
    static DVD_FPS_30NonDrop := 3
}
struct DVD_TIMECODE {
    _bitfield : UInt32
}
struct DVD_NavCmdType extends Int32 {
    static DVD_NavCmdType_Pre := 1
    static DVD_NavCmdType_Post := 2
    static DVD_NavCmdType_Cell := 3
    static DVD_NavCmdType_Button := 4
}
struct DVD_TIMECODE_FLAGS extends Int32 {
    static DVD_TC_FLAG_25fps := 1
    static DVD_TC_FLAG_30fps := 2
    static DVD_TC_FLAG_DropFrame := 4
    static DVD_TC_FLAG_Interpolated := 8
}
struct DVD_HMSF_TIMECODE {
    bHours : UInt8
    bMinutes : UInt8
    bSeconds : UInt8
    bFrames : UInt8
}
struct DVD_PLAYBACK_LOCATION2 {
    TitleNum : UInt32
    ChapterNum : UInt32
    TimeCode : DVD_HMSF_TIMECODE
    TimeCodeFlags : UInt32
}
struct DVD_PLAYBACK_LOCATION {
    TitleNum : UInt32
    ChapterNum : UInt32
    TimeCode : UInt32
}
struct VALID_UOP_FLAG extends Int32 {
    static UOP_FLAG_Play_Title_Or_AtTime := 1
    static UOP_FLAG_Play_Chapter := 2
    static UOP_FLAG_Play_Title := 4
    static UOP_FLAG_Stop := 8
    static UOP_FLAG_ReturnFromSubMenu := 16
    static UOP_FLAG_Play_Chapter_Or_AtTime := 32
    static UOP_FLAG_PlayPrev_Or_Replay_Chapter := 64
    static UOP_FLAG_PlayNext_Chapter := 128
    static UOP_FLAG_Play_Forwards := 256
    static UOP_FLAG_Play_Backwards := 512
    static UOP_FLAG_ShowMenu_Title := 1024
    static UOP_FLAG_ShowMenu_Root := 2048
    static UOP_FLAG_ShowMenu_SubPic := 4096
    static UOP_FLAG_ShowMenu_Audio := 8192
    static UOP_FLAG_ShowMenu_Angle := 16384
    static UOP_FLAG_ShowMenu_Chapter := 32768
    static UOP_FLAG_Resume := 65536
    static UOP_FLAG_Select_Or_Activate_Button := 131072
    static UOP_FLAG_Still_Off := 262144
    static UOP_FLAG_Pause_On := 524288
    static UOP_FLAG_Select_Audio_Stream := 1048576
    static UOP_FLAG_Select_SubPic_Stream := 2097152
    static UOP_FLAG_Select_Angle := 4194304
    static UOP_FLAG_Select_Karaoke_Audio_Presentation_Mode := 8388608
    static UOP_FLAG_Select_Video_Mode_Preference := 16777216
}
struct DVD_CMD_FLAGS extends Int32 {
    static DVD_CMD_FLAG_None := 0
    static DVD_CMD_FLAG_Flush := 1
    static DVD_CMD_FLAG_SendEvents := 2
    static DVD_CMD_FLAG_Block := 4
    static DVD_CMD_FLAG_StartWhenRendered := 8
    static DVD_CMD_FLAG_EndAfterRendered := 16
}
struct DVD_OPTION_FLAG extends Int32 {
    static DVD_ResetOnStop := 1
    static DVD_NotifyParentalLevelChange := 2
    static DVD_HMSF_TimeCodeEvents := 3
    static DVD_AudioDuringFFwdRew := 4
    static DVD_EnableNonblockingAPIs := 5
    static DVD_CacheSizeInMB := 6
    static DVD_EnablePortableBookmarks := 7
    static DVD_EnableExtendedCopyProtectErrors := 8
    static DVD_NotifyPositionChange := 9
    static DVD_IncreaseOutputControl := 10
    static DVD_EnableStreaming := 11
    static DVD_EnableESOutput := 12
    static DVD_EnableTitleLength := 13
    static DVD_DisableStillThrottle := 14
    static DVD_EnableLoggingEvents := 15
    static DVD_MaxReadBurstInKB := 16
    static DVD_ReadBurstPeriodInMS := 17
    static DVD_RestartDisc := 18
    static DVD_EnableCC := 19
}
struct DVD_RELATIVE_BUTTON extends Int32 {
    static DVD_Relative_Upper := 1
    static DVD_Relative_Lower := 2
    static DVD_Relative_Left := 3
    static DVD_Relative_Right := 4
}
struct DVD_PARENTAL_LEVEL extends Int32 {
    static DVD_PARENTAL_LEVEL_8 := 32768
    static DVD_PARENTAL_LEVEL_7 := 16384
    static DVD_PARENTAL_LEVEL_6 := 8192
    static DVD_PARENTAL_LEVEL_5 := 4096
    static DVD_PARENTAL_LEVEL_4 := 2048
    static DVD_PARENTAL_LEVEL_3 := 1024
    static DVD_PARENTAL_LEVEL_2 := 512
    static DVD_PARENTAL_LEVEL_1 := 256
}
struct DVD_AUDIO_LANG_EXT extends Int32 {
    static DVD_AUD_EXT_NotSpecified := 0
    static DVD_AUD_EXT_Captions := 1
    static DVD_AUD_EXT_VisuallyImpaired := 2
    static DVD_AUD_EXT_DirectorComments1 := 3
    static DVD_AUD_EXT_DirectorComments2 := 4
}
struct DVD_SUBPICTURE_LANG_EXT extends Int32 {
    static DVD_SP_EXT_NotSpecified := 0
    static DVD_SP_EXT_Caption_Normal := 1
    static DVD_SP_EXT_Caption_Big := 2
    static DVD_SP_EXT_Caption_Children := 3
    static DVD_SP_EXT_CC_Normal := 5
    static DVD_SP_EXT_CC_Big := 6
    static DVD_SP_EXT_CC_Children := 7
    static DVD_SP_EXT_Forced := 9
    static DVD_SP_EXT_DirectorComments_Normal := 13
    static DVD_SP_EXT_DirectorComments_Big := 14
    static DVD_SP_EXT_DirectorComments_Children := 15
}
struct DVD_AUDIO_APPMODE extends Int32 {
    static DVD_AudioMode_None := 0
    static DVD_AudioMode_Karaoke := 1
    static DVD_AudioMode_Surround := 2
    static DVD_AudioMode_Other := 3
}
struct DVD_AUDIO_FORMAT extends Int32 {
    static DVD_AudioFormat_AC3 := 0
    static DVD_AudioFormat_MPEG1 := 1
    static DVD_AudioFormat_MPEG1_DRC := 2
    static DVD_AudioFormat_MPEG2 := 3
    static DVD_AudioFormat_MPEG2_DRC := 4
    static DVD_AudioFormat_LPCM := 5
    static DVD_AudioFormat_DTS := 6
    static DVD_AudioFormat_SDDS := 7
    static DVD_AudioFormat_Other := 8
}
struct DVD_KARAOKE_DOWNMIX extends Int32 {
    static DVD_Mix_0to0 := 1
    static DVD_Mix_1to0 := 2
    static DVD_Mix_2to0 := 4
    static DVD_Mix_3to0 := 8
    static DVD_Mix_4to0 := 16
    static DVD_Mix_Lto0 := 32
    static DVD_Mix_Rto0 := 64
    static DVD_Mix_0to1 := 256
    static DVD_Mix_1to1 := 512
    static DVD_Mix_2to1 := 1024
    static DVD_Mix_3to1 := 2048
    static DVD_Mix_4to1 := 4096
    static DVD_Mix_Lto1 := 8192
    static DVD_Mix_Rto1 := 16384
}
struct DVD_AudioAttributes {
    AppMode : DVD_AUDIO_APPMODE
    AppModeData : UInt8
    AudioFormat : DVD_AUDIO_FORMAT
    Language : UInt32
    LanguageExtension : DVD_AUDIO_LANG_EXT
    fHasMultichannelInfo : BOOL
    dwFrequency : UInt32
    bQuantization : UInt8
    bNumberOfChannels : UInt8
    dwReserved : UInt32[2]
}
struct DVD_MUA_MixingInfo {
    fMixTo0 : BOOL
    fMixTo1 : BOOL
    fMix0InPhase : BOOL
    fMix1InPhase : BOOL
    dwSpeakerPosition : UInt32
}
struct DVD_MUA_Coeff {
    log2_alpha : Float64
    log2_beta : Float64
}
struct DVD_MultichannelAudioAttributes {
    Info : DVD_MUA_MixingInfo[8]
    Coeff : DVD_MUA_Coeff[8]
}
struct DVD_KARAOKE_CONTENTS extends Int32 {
    static DVD_Karaoke_GuideVocal1 := 1
    static DVD_Karaoke_GuideVocal2 := 2
    static DVD_Karaoke_GuideMelody1 := 4
    static DVD_Karaoke_GuideMelody2 := 8
    static DVD_Karaoke_GuideMelodyA := 16
    static DVD_Karaoke_GuideMelodyB := 32
    static DVD_Karaoke_SoundEffectA := 64
    static DVD_Karaoke_SoundEffectB := 128
}
struct DVD_KARAOKE_ASSIGNMENT extends Int32 {
    static DVD_Assignment_reserved0 := 0
    static DVD_Assignment_reserved1 := 1
    static DVD_Assignment_LR := 2
    static DVD_Assignment_LRM := 3
    static DVD_Assignment_LR1 := 4
    static DVD_Assignment_LRM1 := 5
    static DVD_Assignment_LR12 := 6
    static DVD_Assignment_LRM12 := 7
}
struct DVD_KaraokeAttributes {
    bVersion : UInt8
    fMasterOfCeremoniesInGuideVocal1 : BOOL
    fDuet : BOOL
    ChannelAssignment : DVD_KARAOKE_ASSIGNMENT
    wChannelContents : UInt16[8]
}
struct DVD_VIDEO_COMPRESSION extends Int32 {
    static DVD_VideoCompression_Other := 0
    static DVD_VideoCompression_MPEG1 := 1
    static DVD_VideoCompression_MPEG2 := 2
}
struct DVD_VideoAttributes {
    fPanscanPermitted : BOOL
    fLetterboxPermitted : BOOL
    ulAspectX : UInt32
    ulAspectY : UInt32
    ulFrameRate : UInt32
    ulFrameHeight : UInt32
    Compression : DVD_VIDEO_COMPRESSION
    fLine21Field1InGOP : BOOL
    fLine21Field2InGOP : BOOL
    ulSourceResolutionX : UInt32
    ulSourceResolutionY : UInt32
    fIsSourceLetterboxed : BOOL
    fIsFilmMode : BOOL
}
struct DVD_SUBPICTURE_TYPE extends Int32 {
    static DVD_SPType_NotSpecified := 0
    static DVD_SPType_Language := 1
    static DVD_SPType_Other := 2
}
struct DVD_SUBPICTURE_CODING extends Int32 {
    static DVD_SPCoding_RunLength := 0
    static DVD_SPCoding_Extended := 1
    static DVD_SPCoding_Other := 2
}
struct DVD_SubpictureAttributes {
    Type : DVD_SUBPICTURE_TYPE
    CodingMode : DVD_SUBPICTURE_CODING
    Language : UInt32
    LanguageExtension : DVD_SUBPICTURE_LANG_EXT
}
struct DVD_TITLE_APPMODE extends Int32 {
    static DVD_AppMode_Not_Specified := 0
    static DVD_AppMode_Karaoke := 1
    static DVD_AppMode_Other := 3
}
struct DVD_TitleAttributes {
    Anonymous : this._Anonymous_e__Union
    VideoAttributes : DVD_VideoAttributes
    ulNumberOfAudioStreams : UInt32
    AudioAttributes : DVD_AudioAttributes[8]
    MultichannelAudioAttributes : DVD_MultichannelAudioAttributes[8]
    ulNumberOfSubpictureStreams : UInt32
    SubpictureAttributes : DVD_SubpictureAttributes[32]
    struct _Anonymous_e__Union {
        union {
            AppMode : DVD_TITLE_APPMODE
            TitleLength : DVD_HMSF_TIMECODE
        }
    }
}
struct DVD_MenuAttributes {
    fCompatibleRegion : BOOL[8]
    VideoAttributes : DVD_VideoAttributes
    fAudioPresent : BOOL
    AudioAttributes : DVD_AudioAttributes
    fSubpicturePresent : BOOL
    SubpictureAttributes : DVD_SubpictureAttributes
}
struct IDvdControl extends IUnknown {
    static IID := "{A70EFE61-E2A3-11D0-A9BE-00AA0061BE93}"
    TitlePlay(ulTitle)
      => ComCall(3, this.p, UInt32, ulTitle)
    ChapterPlay(ulTitle, ulChapter)
      => ComCall(4, this.p, UInt32, ulTitle, UInt32, ulChapter)
    TimePlay(ulTitle, bcdTime)
      => ComCall(5, this.p, UInt32, ulTitle, UInt32, bcdTime)
    StopForResume()
      => ComCall(6, this.p)
    GoUp()
      => ComCall(7, this.p)
    TimeSearch(bcdTime)
      => ComCall(8, this.p, UInt32, bcdTime)
    ChapterSearch(ulChapter)
      => ComCall(9, this.p, UInt32, ulChapter)
    PrevPGSearch()
      => ComCall(10, this.p)
    TopPGSearch()
      => ComCall(11, this.p)
    NextPGSearch()
      => ComCall(12, this.p)
    ForwardScan(dwSpeed)
      => ComCall(13, this.p, Float64, dwSpeed)
    BackwardScan(dwSpeed)
      => ComCall(14, this.p, Float64, dwSpeed)
    MenuCall(MenuID)
      => ComCall(15, this.p, DVD_MENU_ID, MenuID)
    Resume()
      => ComCall(16, this.p)
    UpperButtonSelect()
      => ComCall(17, this.p)
    LowerButtonSelect()
      => ComCall(18, this.p)
    LeftButtonSelect()
      => ComCall(19, this.p)
    RightButtonSelect()
      => ComCall(20, this.p)
    ButtonActivate()
      => ComCall(21, this.p)
    ButtonSelectAndActivate(ulButton)
      => ComCall(22, this.p, UInt32, ulButton)
    StillOff()
      => ComCall(23, this.p)
    PauseOn()
      => ComCall(24, this.p)
    PauseOff()
      => ComCall(25, this.p)
    MenuLanguageSelect(Language)
      => ComCall(26, this.p, UInt32, Language)
    AudioStreamChange(ulAudio)
      => ComCall(27, this.p, UInt32, ulAudio)
    SubpictureStreamChange(ulSubPicture, bDisplay)
      => ComCall(28, this.p, UInt32, ulSubPicture, BOOL, bDisplay)
    AngleChange(ulAngle)
      => ComCall(29, this.p, UInt32, ulAngle)
    ParentalLevelSelect(ulParentalLevel)
      => ComCall(30, this.p, UInt32, ulParentalLevel)
    ParentalCountrySelect(wCountry)
      => ComCall(31, this.p, UInt16, wCountry)
    KaraokeAudioPresentationModeChange(ulMode)
      => ComCall(32, this.p, UInt32, ulMode)
    VideoModePreferrence(ulPreferredDisplayMode)
      => ComCall(33, this.p, UInt32, ulPreferredDisplayMode)
    SetRoot(pszPath)
      => ComCall(34, this.p, "Str", pszPath)
    MouseActivate(point1)
      => ComCall(35, this.p, POINT, point1)
    MouseSelect(point1)
      => ComCall(36, this.p, POINT, point1)
    ChapterPlayAutoStop(ulTitle, ulChapter, ulChaptersToPlay)
      => ComCall(37, this.p, UInt32, ulTitle, UInt32, ulChapter, UInt32, ulChaptersToPlay)
}
struct IDvdInfo extends IUnknown {
    static IID := "{A70EFE60-E2A3-11D0-A9BE-00AA0061BE93}"
    GetCurrentDomain(pDomain)
      => ComCall(3, this.p, DVD_DOMAIN.Ptr, pDomain)
    GetCurrentLocation(pLocation)
      => ComCall(4, this.p, DVD_PLAYBACK_LOCATION.Ptr, pLocation)
    GetTotalTitleTime(pulTotalTime)
      => ComCall(5, this.p, UInt32.Ptr, pulTotalTime)
    GetCurrentButton(pulButtonsAvailable, pulCurrentButton)
      => ComCall(6, this.p, UInt32.Ptr, pulButtonsAvailable, UInt32.Ptr, pulCurrentButton)
    GetCurrentAngle(pulAnglesAvailable, pulCurrentAngle)
      => ComCall(7, this.p, UInt32.Ptr, pulAnglesAvailable, UInt32.Ptr, pulCurrentAngle)
    GetCurrentAudio(pulStreamsAvailable, pulCurrentStream)
      => ComCall(8, this.p, UInt32.Ptr, pulStreamsAvailable, UInt32.Ptr, pulCurrentStream)
    GetCurrentSubpicture(pulStreamsAvailable, pulCurrentStream, pIsDisabled)
      => ComCall(9, this.p, UInt32.Ptr, pulStreamsAvailable, UInt32.Ptr, pulCurrentStream, BOOL.Ptr, pIsDisabled)
    GetCurrentUOPS(pUOP)
      => ComCall(10, this.p, UInt32.Ptr, pUOP)
    GetAllSPRMs(pRegisterArray)
      => ComCall(11, this.p, UInt16.Ptr.Ptr, pRegisterArray)
    GetAllGPRMs(pRegisterArray)
      => ComCall(12, this.p, UInt16.Ptr.Ptr, pRegisterArray)
    GetAudioLanguage(ulStream, pLanguage)
      => ComCall(13, this.p, UInt32, ulStream, UInt32.Ptr, pLanguage)
    GetSubpictureLanguage(ulStream, pLanguage)
      => ComCall(14, this.p, UInt32, ulStream, UInt32.Ptr, pLanguage)
    GetTitleAttributes(ulTitle, pATR)
      => ComCall(15, this.p, UInt32, ulTitle, DVD_ATR.Ptr, pATR)
    GetVMGAttributes(pATR)
      => ComCall(16, this.p, DVD_ATR.Ptr, pATR)
    GetCurrentVideoAttributes(pATR)
      => ComCall(17, this.p, UInt8.Ptr.Ptr, pATR)
    GetCurrentAudioAttributes(pATR)
      => ComCall(18, this.p, UInt8.Ptr.Ptr, pATR)
    GetCurrentSubpictureAttributes(pATR)
      => ComCall(19, this.p, UInt8.Ptr.Ptr, pATR)
    GetCurrentVolumeInfo(pulNumOfVol, pulThisVolNum, pSide, pulNumOfTitles)
      => ComCall(20, this.p, UInt32.Ptr, pulNumOfVol, UInt32.Ptr, pulThisVolNum, DVD_DISC_SIDE.Ptr, pSide, UInt32.Ptr, pulNumOfTitles)
    GetDVDTextInfo(pTextManager, pulActualSize)
      => ComCall(21, this.p, UInt8.Ptr, pTextManager, UInt32, pTextManager.Size, UInt32.Ptr, pulActualSize)
    GetPlayerParentalLevel(pulParentalLevel, pulCountryCode)
      => ComCall(22, this.p, UInt32.Ptr, pulParentalLevel, UInt32.Ptr, pulCountryCode)
    GetNumberOfChapters(ulTitle, pulNumberOfChapters)
      => ComCall(23, this.p, UInt32, ulTitle, UInt32.Ptr, pulNumberOfChapters)
    GetTitleParentalLevels(ulTitle, pulParentalLevels)
      => ComCall(24, this.p, UInt32, ulTitle, UInt32.Ptr, pulParentalLevels)
    GetRoot(pRoot, pulActualSize)
      => ComCall(25, this.p, PSTR, pRoot, UInt32, pRoot.Length, UInt32.Ptr, pulActualSize)
}
struct IDvdCmd extends IUnknown {
    static IID := "{5A4A97E4-94EE-4A55-9751-74B5643AA27D}"
    WaitForStart()
      => ComCall(3, this.p)
    WaitForEnd()
      => ComCall(4, this.p)
}
struct IDvdState extends IUnknown {
    static IID := "{86303D6D-1C4A-4087-AB42-F711167048EF}"
    GetDiscID(pullUniqueID)
      => ComCall(3, this.p, Int64.Ptr, pullUniqueID)
    GetParentalLevel(pulParentalLevel)
      => ComCall(4, this.p, UInt32.Ptr, pulParentalLevel)
}
struct IDvdControl2 extends IUnknown {
    static IID := "{33BC7430-EEC0-11D2-8201-00A0C9D74842}"
    PlayTitle(ulTitle, dwFlags, ppCmd)
      => ComCall(3, this.p, UInt32, ulTitle, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    PlayChapterInTitle(ulTitle, ulChapter, dwFlags, ppCmd)
      => ComCall(4, this.p, UInt32, ulTitle, UInt32, ulChapter, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    PlayAtTimeInTitle(ulTitle, pStartTime, dwFlags, ppCmd)
      => ComCall(5, this.p, UInt32, ulTitle, DVD_HMSF_TIMECODE.Ptr, pStartTime, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    Stop()
      => ComCall(6, this.p)
    ReturnFromSubmenu(dwFlags, ppCmd)
      => ComCall(7, this.p, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    PlayAtTime(pTime, dwFlags, ppCmd)
      => ComCall(8, this.p, DVD_HMSF_TIMECODE.Ptr, pTime, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    PlayChapter(ulChapter, dwFlags, ppCmd)
      => ComCall(9, this.p, UInt32, ulChapter, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    PlayPrevChapter(dwFlags, ppCmd)
      => ComCall(10, this.p, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    ReplayChapter(dwFlags, ppCmd)
      => ComCall(11, this.p, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    PlayNextChapter(dwFlags, ppCmd)
      => ComCall(12, this.p, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    PlayForwards(dSpeed, dwFlags, ppCmd)
      => ComCall(13, this.p, Float64, dSpeed, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    PlayBackwards(dSpeed, dwFlags, ppCmd)
      => ComCall(14, this.p, Float64, dSpeed, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    ShowMenu(MenuID, dwFlags, ppCmd)
      => ComCall(15, this.p, DVD_MENU_ID, MenuID, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    Resume(dwFlags, ppCmd)
      => ComCall(16, this.p, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    SelectRelativeButton(buttonDir)
      => ComCall(17, this.p, DVD_RELATIVE_BUTTON, buttonDir)
    ActivateButton()
      => ComCall(18, this.p)
    SelectButton(ulButton)
      => ComCall(19, this.p, UInt32, ulButton)
    SelectAndActivateButton(ulButton)
      => ComCall(20, this.p, UInt32, ulButton)
    StillOff()
      => ComCall(21, this.p)
    Pause(bState)
      => ComCall(22, this.p, BOOL, bState)
    SelectAudioStream(ulAudio, dwFlags, ppCmd)
      => ComCall(23, this.p, UInt32, ulAudio, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    SelectSubpictureStream(ulSubPicture, dwFlags, ppCmd)
      => ComCall(24, this.p, UInt32, ulSubPicture, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    SetSubpictureState(bState, dwFlags, ppCmd)
      => ComCall(25, this.p, BOOL, bState, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    SelectAngle(ulAngle, dwFlags, ppCmd)
      => ComCall(26, this.p, UInt32, ulAngle, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    SelectParentalLevel(ulParentalLevel)
      => ComCall(27, this.p, UInt32, ulParentalLevel)
    SelectParentalCountry(bCountry)
      => ComCall(28, this.p, UInt8.Ptr, bCountry)
    SelectKaraokeAudioPresentationMode(ulMode)
      => ComCall(29, this.p, UInt32, ulMode)
    SelectVideoModePreference(ulPreferredDisplayMode)
      => ComCall(30, this.p, UInt32, ulPreferredDisplayMode)
    SetDVDDirectory(pszwPath)
      => ComCall(31, this.p, "Str", pszwPath)
    ActivateAtPosition(point1)
      => ComCall(32, this.p, POINT, point1)
    SelectAtPosition(point1)
      => ComCall(33, this.p, POINT, point1)
    PlayChaptersAutoStop(ulTitle, ulChapter, ulChaptersToPlay, dwFlags, ppCmd)
      => ComCall(34, this.p, UInt32, ulTitle, UInt32, ulChapter, UInt32, ulChaptersToPlay, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    AcceptParentalLevelChange(bAccept)
      => ComCall(35, this.p, BOOL, bAccept)
    SetOption(flag, fState)
      => ComCall(36, this.p, DVD_OPTION_FLAG, flag, BOOL, fState)
    SetState(pState, dwFlags, ppCmd)
      => ComCall(37, this.p, IDvdState, pState, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    PlayPeriodInTitleAutoStop(ulTitle, pStartTime, pEndTime, dwFlags, ppCmd)
      => ComCall(38, this.p, UInt32, ulTitle, DVD_HMSF_TIMECODE.Ptr, pStartTime, DVD_HMSF_TIMECODE.Ptr, pEndTime, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    SetGPRM(ulIndex, wValue, dwFlags, ppCmd)
      => ComCall(39, this.p, UInt32, ulIndex, UInt16, wValue, UInt32, dwFlags, IDvdCmd.Ptr, ppCmd)
    SelectDefaultMenuLanguage(Language)
      => ComCall(40, this.p, UInt32, Language)
    SelectDefaultAudioLanguage(Language, audioExtension)
      => ComCall(41, this.p, UInt32, Language, DVD_AUDIO_LANG_EXT, audioExtension)
    SelectDefaultSubpictureLanguage(Language, subpictureExtension)
      => ComCall(42, this.p, UInt32, Language, DVD_SUBPICTURE_LANG_EXT, subpictureExtension)
}
struct DVD_TextStringType extends Int32 {
    static DVD_Struct_Volume := 1
    static DVD_Struct_Title := 2
    static DVD_Struct_ParentalID := 3
    static DVD_Struct_PartOfTitle := 4
    static DVD_Struct_Cell := 5
    static DVD_Stream_Audio := 16
    static DVD_Stream_Subpicture := 17
    static DVD_Stream_Angle := 18
    static DVD_Channel_Audio := 32
    static DVD_General_Name := 48
    static DVD_General_Comments := 49
    static DVD_Title_Series := 56
    static DVD_Title_Movie := 57
    static DVD_Title_Video := 58
    static DVD_Title_Album := 59
    static DVD_Title_Song := 60
    static DVD_Title_Other := 63
    static DVD_Title_Sub_Series := 64
    static DVD_Title_Sub_Movie := 65
    static DVD_Title_Sub_Video := 66
    static DVD_Title_Sub_Album := 67
    static DVD_Title_Sub_Song := 68
    static DVD_Title_Sub_Other := 71
    static DVD_Title_Orig_Series := 72
    static DVD_Title_Orig_Movie := 73
    static DVD_Title_Orig_Video := 74
    static DVD_Title_Orig_Album := 75
    static DVD_Title_Orig_Song := 76
    static DVD_Title_Orig_Other := 79
    static DVD_Other_Scene := 80
    static DVD_Other_Cut := 81
    static DVD_Other_Take := 82
}
struct DVD_TextCharSet extends Int32 {
    static DVD_CharSet_Unicode := 0
    static DVD_CharSet_ISO646 := 1
    static DVD_CharSet_JIS_Roman_Kanji := 2
    static DVD_CharSet_ISO8859_1 := 3
    static DVD_CharSet_ShiftJIS_Kanji_Roman_Katakana := 4
}
struct DVD_DECODER_CAPS {
    dwSize : UInt32
    dwAudioCaps : UInt32
    dFwdMaxRateVideo : Float64
    dFwdMaxRateAudio : Float64
    dFwdMaxRateSP : Float64
    dBwdMaxRateVideo : Float64
    dBwdMaxRateAudio : Float64
    dBwdMaxRateSP : Float64
    dwRes1 : UInt32
    dwRes2 : UInt32
    dwRes3 : UInt32
    dwRes4 : UInt32
}
struct IDvdInfo2 extends IUnknown {
    static IID := "{34151510-EEC0-11D2-8201-00A0C9D74842}"
    GetCurrentDomain(pDomain)
      => ComCall(3, this.p, DVD_DOMAIN.Ptr, pDomain)
    GetCurrentLocation(pLocation)
      => ComCall(4, this.p, DVD_PLAYBACK_LOCATION2.Ptr, pLocation)
    GetTotalTitleTime(pTotalTime, ulTimeCodeFlags)
      => ComCall(5, this.p, DVD_HMSF_TIMECODE.Ptr, pTotalTime, UInt32.Ptr, ulTimeCodeFlags)
    GetCurrentButton(pulButtonsAvailable, pulCurrentButton)
      => ComCall(6, this.p, UInt32.Ptr, pulButtonsAvailable, UInt32.Ptr, pulCurrentButton)
    GetCurrentAngle(pulAnglesAvailable, pulCurrentAngle)
      => ComCall(7, this.p, UInt32.Ptr, pulAnglesAvailable, UInt32.Ptr, pulCurrentAngle)
    GetCurrentAudio(pulStreamsAvailable, pulCurrentStream)
      => ComCall(8, this.p, UInt32.Ptr, pulStreamsAvailable, UInt32.Ptr, pulCurrentStream)
    GetCurrentSubpicture(pulStreamsAvailable, pulCurrentStream, pbIsDisabled)
      => ComCall(9, this.p, UInt32.Ptr, pulStreamsAvailable, UInt32.Ptr, pulCurrentStream, BOOL.Ptr, pbIsDisabled)
    GetCurrentUOPS(pulUOPs)
      => ComCall(10, this.p, UInt32.Ptr, pulUOPs)
    GetAllSPRMs(pRegisterArray)
      => ComCall(11, this.p, UInt16.Ptr.Ptr, pRegisterArray)
    GetAllGPRMs(pRegisterArray)
      => ComCall(12, this.p, UInt16.Ptr.Ptr, pRegisterArray)
    GetAudioLanguage(ulStream, pLanguage)
      => ComCall(13, this.p, UInt32, ulStream, UInt32.Ptr, pLanguage)
    GetSubpictureLanguage(ulStream, pLanguage)
      => ComCall(14, this.p, UInt32, ulStream, UInt32.Ptr, pLanguage)
    GetTitleAttributes(ulTitle, pMenu, pTitle)
      => ComCall(15, this.p, UInt32, ulTitle, DVD_MenuAttributes.Ptr, pMenu, DVD_TitleAttributes.Ptr, pTitle)
    GetVMGAttributes(pATR)
      => ComCall(16, this.p, DVD_MenuAttributes.Ptr, pATR)
    GetCurrentVideoAttributes(pATR)
      => ComCall(17, this.p, DVD_VideoAttributes.Ptr, pATR)
    GetAudioAttributes(ulStream, pATR)
      => ComCall(18, this.p, UInt32, ulStream, DVD_AudioAttributes.Ptr, pATR)
    GetKaraokeAttributes(ulStream, pAttributes)
      => ComCall(19, this.p, UInt32, ulStream, DVD_KaraokeAttributes.Ptr, pAttributes)
    GetSubpictureAttributes(ulStream, pATR)
      => ComCall(20, this.p, UInt32, ulStream, DVD_SubpictureAttributes.Ptr, pATR)
    GetDVDVolumeInfo(pulNumOfVolumes, pulVolume, pSide, pulNumOfTitles)
      => ComCall(21, this.p, UInt32.Ptr, pulNumOfVolumes, UInt32.Ptr, pulVolume, DVD_DISC_SIDE.Ptr, pSide, UInt32.Ptr, pulNumOfTitles)
    GetDVDTextNumberOfLanguages(pulNumOfLangs)
      => ComCall(22, this.p, UInt32.Ptr, pulNumOfLangs)
    GetDVDTextLanguageInfo(ulLangIndex, pulNumOfStrings, pLangCode, pbCharacterSet)
      => ComCall(23, this.p, UInt32, ulLangIndex, UInt32.Ptr, pulNumOfStrings, UInt32.Ptr, pLangCode, DVD_TextCharSet.Ptr, pbCharacterSet)
    GetDVDTextStringAsNative(ulLangIndex, ulStringIndex, pbBuffer, ulMaxBufferSize, pulActualSize, pType)
      => ComCall(24, this.p, UInt32, ulLangIndex, UInt32, ulStringIndex, UInt8.Ptr, pbBuffer, UInt32, ulMaxBufferSize, UInt32.Ptr, pulActualSize, DVD_TextStringType.Ptr, pType)
    GetDVDTextStringAsUnicode(ulLangIndex, ulStringIndex, pchwBuffer, ulMaxBufferSize, pulActualSize, pType)
      => ComCall(25, this.p, UInt32, ulLangIndex, UInt32, ulStringIndex, PWSTR, pchwBuffer, UInt32, ulMaxBufferSize, UInt32.Ptr, pulActualSize, DVD_TextStringType.Ptr, pType)
    GetPlayerParentalLevel(pulParentalLevel, pbCountryCode)
      => ComCall(26, this.p, UInt32.Ptr, pulParentalLevel, UInt8.Ptr, pbCountryCode)
    GetNumberOfChapters(ulTitle, pulNumOfChapters)
      => ComCall(27, this.p, UInt32, ulTitle, UInt32.Ptr, pulNumOfChapters)
    GetTitleParentalLevels(ulTitle, pulParentalLevels)
      => ComCall(28, this.p, UInt32, ulTitle, UInt32.Ptr, pulParentalLevels)
    GetDVDDirectory(pszwPath, pulActualSize)
      => ComCall(29, this.p, PWSTR, pszwPath, UInt32, pszwPath.Length, UInt32.Ptr, pulActualSize)
    IsAudioStreamEnabled(ulStreamNum, pbEnabled)
      => ComCall(30, this.p, UInt32, ulStreamNum, BOOL.Ptr, pbEnabled)
    GetDiscID(pszwPath, pullDiscID)
      => ComCall(31, this.p, "Str", pszwPath, Int64.Ptr, pullDiscID)
    GetState(pStateData)
      => ComCall(32, this.p, IDvdState.Ptr, pStateData)
    GetMenuLanguages(pLanguages, ulMaxLanguages, pulActualLanguages)
      => ComCall(33, this.p, UInt32.Ptr, pLanguages, UInt32, ulMaxLanguages, UInt32.Ptr, pulActualLanguages)
    GetButtonAtPosition(point1, pulButtonIndex)
      => ComCall(34, this.p, POINT, point1, UInt32.Ptr, pulButtonIndex)
    GetCmdFromEvent(lParam1, pCmdObj)
      => ComCall(35, this.p, IntPtr, lParam1, IDvdCmd.Ptr, pCmdObj)
    GetDefaultMenuLanguage(pLanguage)
      => ComCall(36, this.p, UInt32.Ptr, pLanguage)
    GetDefaultAudioLanguage(pLanguage, pAudioExtension)
      => ComCall(37, this.p, UInt32.Ptr, pLanguage, DVD_AUDIO_LANG_EXT.Ptr, pAudioExtension)
    GetDefaultSubpictureLanguage(pLanguage, pSubpictureExtension)
      => ComCall(38, this.p, UInt32.Ptr, pLanguage, DVD_SUBPICTURE_LANG_EXT.Ptr, pSubpictureExtension)
    GetDecoderCaps(pCaps)
      => ComCall(39, this.p, DVD_DECODER_CAPS.Ptr, pCaps)
    GetButtonRect(ulButton, pRect)
      => ComCall(40, this.p, UInt32, ulButton, RECT.Ptr, pRect)
    IsSubpictureStreamEnabled(ulStreamNum, pbEnabled)
      => ComCall(41, this.p, UInt32, ulStreamNum, BOOL.Ptr, pbEnabled)
}
struct AM_DVD_GRAPH_FLAGS extends Int32 {
    static AM_DVD_HWDEC_PREFER := 1
    static AM_DVD_HWDEC_ONLY := 2
    static AM_DVD_SWDEC_PREFER := 4
    static AM_DVD_SWDEC_ONLY := 8
    static AM_DVD_NOVPE := 256
    static AM_DVD_DO_NOT_CLEAR := 512
    static AM_DVD_VMR9_ONLY := 2048
    static AM_DVD_EVR_ONLY := 4096
    static AM_DVD_EVR_QOS := 8192
    static AM_DVD_ADAPT_GRAPH := 16384
    static AM_DVD_MASK := 65535
}
struct AM_DVD_STREAM_FLAGS extends Int32 {
    static AM_DVD_STREAM_VIDEO := 1
    static AM_DVD_STREAM_AUDIO := 2
    static AM_DVD_STREAM_SUBPIC := 4
}
struct AM_DVD_RENDERSTATUS {
    hrVPEStatus : HRESULT
    bDvdVolInvalid : BOOL
    bDvdVolUnknown : BOOL
    bNoLine21In : BOOL
    bNoLine21Out : BOOL
    iNumStreams : Int32
    iNumStreamsFailed : Int32
    dwFailedStreamsFlag : UInt32
}
struct IDvdGraphBuilder extends IUnknown {
    static IID := "{FCC152B6-F372-11D0-8E00-00C04FD7C08B}"
    GetFiltergraph(ppGB)
      => ComCall(3, this.p, IGraphBuilder.Ptr, ppGB)
    GetDvdInterface(riid, ppvIF)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvIF)
    RenderDvdVideoVolume(lpcwszPathName, dwFlags, pStatus)
      => ComCall(5, this.p, "Str", lpcwszPathName, UInt32, dwFlags, AM_DVD_RENDERSTATUS.Ptr, pStatus)
}
struct IDDrawExclModeVideo extends IUnknown {
    static IID := "{153ACC21-D83B-11D1-82BF-00A0C9696C8F}"
    SetDDrawObject(pDDrawObject)
      => ComCall(3, this.p, IDirectDraw, pDDrawObject)
    GetDDrawObject(ppDDrawObject, pbUsingExternal)
      => ComCall(4, this.p, IDirectDraw.Ptr, ppDDrawObject, BOOL.Ptr, pbUsingExternal)
    SetDDrawSurface(pDDrawSurface)
      => ComCall(5, this.p, IDirectDrawSurface, pDDrawSurface)
    GetDDrawSurface(ppDDrawSurface, pbUsingExternal)
      => ComCall(6, this.p, IDirectDrawSurface.Ptr, ppDDrawSurface, BOOL.Ptr, pbUsingExternal)
    SetDrawParameters(prcSource, prcTarget)
      => ComCall(7, this.p, RECT.Ptr, prcSource, RECT.Ptr, prcTarget)
    GetNativeVideoProps(pdwVideoWidth, pdwVideoHeight, pdwPictAspectRatioX, pdwPictAspectRatioY)
      => ComCall(8, this.p, UInt32.Ptr, pdwVideoWidth, UInt32.Ptr, pdwVideoHeight, UInt32.Ptr, pdwPictAspectRatioX, UInt32.Ptr, pdwPictAspectRatioY)
    SetCallbackInterface(pCallback, dwFlags)
      => ComCall(9, this.p, IDDrawExclModeVideoCallback, pCallback, UInt32, dwFlags)
}
struct AM_OVERLAY_NOTIFY_FLAGS extends Int32 {
    static AM_OVERLAY_NOTIFY_VISIBLE_CHANGE := 1
    static AM_OVERLAY_NOTIFY_SOURCE_CHANGE := 2
    static AM_OVERLAY_NOTIFY_DEST_CHANGE := 4
}
struct IDDrawExclModeVideoCallback extends IUnknown {
    static IID := "{913C24A0-20AB-11D2-9038-00A0C9697298}"
    OnUpdateOverlay(bBefore, dwFlags, bOldVisible, prcOldSrc, prcOldDest, bNewVisible, prcNewSrc, prcNewDest)
      => ComCall(3, this.p, BOOL, bBefore, UInt32, dwFlags, BOOL, bOldVisible, RECT.Ptr, prcOldSrc, RECT.Ptr, prcOldDest, BOOL, bNewVisible, RECT.Ptr, prcNewSrc, RECT.Ptr, prcNewDest)
    OnUpdateColorKey(pKey, dwColor)
      => ComCall(4, this.p, COLORKEY.Ptr, pKey, UInt32, dwColor)
    OnUpdateSize(dwWidth, dwHeight, dwARWidth, dwARHeight)
      => ComCall(5, this.p, UInt32, dwWidth, UInt32, dwHeight, UInt32, dwARWidth, UInt32, dwARHeight)
}
struct BDA_TEMPLATE_CONNECTION {
    FromNodeType : UInt32
    FromNodePinType : UInt32
    ToNodeType : UInt32
    ToNodePinType : UInt32
}
struct BDA_TEMPLATE_PIN_JOINT {
    uliTemplateConnection : UInt32
    ulcInstancesMax : UInt32
}
struct BDA_EVENT_ID extends Int32 {
    static BDA_EVENT_SIGNAL_LOSS := 0
    static BDA_EVENT_SIGNAL_LOCK := 1
    static BDA_EVENT_DATA_START := 2
    static BDA_EVENT_DATA_STOP := 3
    static BDA_EVENT_CHANNEL_ACQUIRED := 4
    static BDA_EVENT_CHANNEL_LOST := 5
    static BDA_EVENT_CHANNEL_SOURCE_CHANGED := 6
    static BDA_EVENT_CHANNEL_ACTIVATED := 7
    static BDA_EVENT_CHANNEL_DEACTIVATED := 8
    static BDA_EVENT_SUBCHANNEL_ACQUIRED := 9
    static BDA_EVENT_SUBCHANNEL_LOST := 10
    static BDA_EVENT_SUBCHANNEL_SOURCE_CHANGED := 11
    static BDA_EVENT_SUBCHANNEL_ACTIVATED := 12
    static BDA_EVENT_SUBCHANNEL_DEACTIVATED := 13
    static BDA_EVENT_ACCESS_GRANTED := 14
    static BDA_EVENT_ACCESS_DENIED := 15
    static BDA_EVENT_OFFER_EXTENDED := 16
    static BDA_EVENT_PURCHASE_COMPLETED := 17
    static BDA_EVENT_SMART_CARD_INSERTED := 18
    static BDA_EVENT_SMART_CARD_REMOVED := 19
}
struct KS_BDA_FRAME_INFO {
    ExtendedHeaderSize : UInt32
    dwFrameFlags : UInt32
    ulEvent : UInt32
    ulChannelNumber : UInt32
    ulSubchannelNumber : UInt32
    ulReason : UInt32
}
struct BDA_ETHERNET_ADDRESS {
    rgbAddress : UInt8[6]
}
struct BDA_ETHERNET_ADDRESS_LIST {
    ulcAddresses : UInt32
    rgAddressl : BDA_ETHERNET_ADDRESS[1]
}
struct BDA_MULTICAST_MODE extends Int32 {
    static BDA_PROMISCUOUS_MULTICAST := 0
    static BDA_FILTERED_MULTICAST := 1
    static BDA_NO_MULTICAST := 2
}
struct BDA_IPv4_ADDRESS {
    rgbAddress : UInt8[4]
}
struct BDA_IPv4_ADDRESS_LIST {
    ulcAddresses : UInt32
    rgAddressl : BDA_IPv4_ADDRESS[1]
}
struct BDA_IPv6_ADDRESS {
    rgbAddress : UInt8[6]
}
struct BDA_IPv6_ADDRESS_LIST {
    ulcAddresses : UInt32
    rgAddressl : BDA_IPv6_ADDRESS[1]
}
struct BDA_SIGNAL_STATE extends Int32 {
    static BDA_SIGNAL_UNAVAILABLE := 0
    static BDA_SIGNAL_INACTIVE := 1
    static BDA_SIGNAL_ACTIVE := 2
}
struct BDA_CHANGE_STATE extends Int32 {
    static BDA_CHANGES_COMPLETE := 0
    static BDA_CHANGES_PENDING := 1
}
struct BDANODE_DESCRIPTOR {
    ulBdaNodeType : UInt32
    guidFunction : GUID
    guidName : GUID
}
struct BDA_TABLE_SECTION {
    ulPrimarySectionId : UInt32
    ulSecondarySectionId : UInt32
    ulcbSectionLength : UInt32
    argbSectionData : UInt32[1]
}
struct BDA_DISEQC_SEND {
    ulRequestId : UInt32
    ulPacketLength : UInt32
    argbPacketData : UInt8[8]
}
struct BDA_DISEQC_RESPONSE {
    ulRequestId : UInt32
    ulPacketLength : UInt32
    argbPacketData : UInt8[8]
}
struct MEDIA_SAMPLE_CONTENT extends Int32 {
    static MEDIA_TRANSPORT_PACKET := 0
    static MEDIA_ELEMENTARY_STREAM := 1
    static MEDIA_MPEG2_PSI := 2
    static MEDIA_TRANSPORT_PAYLOAD := 3
}
struct PID_MAP {
    ulPID : UInt32
    MediaSampleContent : MEDIA_SAMPLE_CONTENT
}
struct BDA_PID_MAP {
    MediaSampleContent : MEDIA_SAMPLE_CONTENT
    ulcPIDs : UInt32
    aulPIDs : UInt32[1]
}
struct BDA_PID_UNMAP {
    ulcPIDs : UInt32
    aulPIDs : UInt32[1]
}
struct BDA_CA_MODULE_UI {
    ulFormat : UInt32
    ulbcDesc : UInt32
    ulDesc : UInt32[1]
}
struct BDA_PROGRAM_PID_LIST {
    ulProgramNumber : UInt32
    ulcPIDs : UInt32
    ulPID : UInt32[1]
}
struct BDA_DRM_DRMSTATUS {
    lResult : Int32
    DRMuuid : GUID
    ulDrmUuidListStringSize : UInt32
    argbDrmUuidListString : GUID[1]
}
struct BDA_WMDRM_STATUS {
    lResult : Int32
    ulMaxCaptureTokenSize : UInt32
    uMaxStreamingPid : UInt32
    ulMaxLicense : UInt32
    ulMinSecurityLevel : UInt32
    ulRevInfoSequenceNumber : UInt32
    ulRevInfoIssuedTime : Int64
    ulRevListVersion : UInt32
    ulRevInfoTTL : UInt32
    ulState : UInt32
}
struct BDA_WMDRM_KEYINFOLIST {
    lResult : Int32
    ulKeyuuidBufferLen : UInt32
    argKeyuuidBuffer : GUID[1]
}
struct BDA_BUFFER {
    lResult : Int32
    ulBufferSize : UInt32
    argbBuffer : UInt8[1]
}
struct BDA_WMDRM_RENEWLICENSE {
    lResult : Int32
    ulDescrambleStatus : UInt32
    ulXmrLicenseOutputLength : UInt32
    argbXmrLicenceOutputBuffer : UInt8[1]
}
struct BDA_WMDRMTUNER_PIDPROTECTION {
    lResult : Int32
    uuidKeyID : GUID
}
struct BDA_WMDRMTUNER_PURCHASEENTITLEMENT {
    lResult : Int32
    ulDescrambleStatus : UInt32
    ulCaptureTokenLength : UInt32
    argbCaptureTokenBuffer : UInt8[1]
}
struct BDA_TUNER_TUNERSTATE {
    lResult : Int32
    ulTuneLength : UInt32
    argbTuneData : UInt8[1]
}
struct BDA_TUNER_DIAGNOSTICS {
    lResult : Int32
    ulSignalLevel : UInt32
    ulSignalLevelQuality : UInt32
    ulSignalNoiseRatio : UInt32
}
struct BDA_STRING {
    lResult : Int32
    ulStringSize : UInt32
    argbString : UInt8[1]
}
struct BDA_SCAN_CAPABILTIES {
    lResult : Int32
    ul64AnalogStandardsSupported : Int64
}
struct BDA_SCAN_STATE {
    lResult : Int32
    ulSignalLock : UInt32
    ulSecondsLeft : UInt32
    ulCurrentFrequency : UInt32
}
struct BDA_SCAN_START {
    lResult : Int32
    LowerFrequency : UInt32
    HigerFrequency : UInt32
}
struct BDA_GDDS_DATATYPE {
    lResult : Int32
    uuidDataType : GUID
}
struct BDA_GDDS_DATA {
    lResult : Int32
    ulDataLength : UInt32
    ulPercentageProgress : UInt32
    argbData : UInt8[1]
}
struct BDA_USERACTIVITY_INTERVAL {
    lResult : Int32
    ulActivityInterval : UInt32
}
struct BDA_CAS_CHECK_ENTITLEMENTTOKEN {
    lResult : Int32
    ulDescrambleStatus : UInt32
}
struct BDA_CAS_CLOSE_MMIDIALOG {
    lResult : Int32
    SessionResult : UInt32
}
struct BDA_CAS_REQUESTTUNERDATA {
    ucRequestPriority : UInt8
    ucRequestReason : UInt8
    ucRequestConsequences : UInt8
    ulEstimatedTime : UInt32
}
struct BDA_CAS_OPENMMIDATA {
    ulDialogNumber : UInt32
    ulDialogRequest : UInt32
    uuidDialogType : GUID
    usDialogDataLength : UInt16
    argbDialogData : UInt8[1]
}
struct BDA_CAS_CLOSEMMIDATA {
    ulDialogNumber : UInt32
}
struct ISDBCAS_REQUEST_ID extends Int32 {
    static ISDBCAS_REQUEST_ID_EMG := 56
    static ISDBCAS_REQUEST_ID_EMD := 58
}
struct BDA_ISDBCAS_REQUESTHEADER {
    bInstruction : UInt8
    bReserved : UInt8[3]
    ulDataLength : UInt32
    argbIsdbCommand : UInt8[1]
}
struct BDA_ISDBCAS_RESPONSEDATA {
    lResult : Int32
    ulRequestID : UInt32
    ulIsdbStatus : UInt32
    ulIsdbDataSize : UInt32
    argbIsdbCommandData : UInt8[1]
}
struct BDA_ISDBCAS_EMG_REQ {
    bCLA : UInt8
    bINS : UInt8
    bP1 : UInt8
    bP2 : UInt8
    bLC : UInt8
    bCardId : UInt8[6]
    bProtocol : UInt8
    bCABroadcasterGroupId : UInt8
    bMessageControl : UInt8
    bMessageCode : UInt8[1]
}
struct MUX_PID_TYPE extends Int32 {
    static PID_OTHER := -1
    static PID_ELEMENTARY_STREAM := 0
    static PID_MPEG2_SECTION_PSI_SI := 1
}
struct BDA_MUX_PIDLISTITEM {
    usPIDNumber : UInt16
    usProgramNumber : UInt16
    ePIDType : MUX_PID_TYPE
}
struct BDA_TS_SELECTORINFO {
    bTSInfolength : UInt8
    bReserved : UInt8[2]
    guidNetworkType : GUID
    bTSIDCount : UInt8
    usTSID : UInt16[1]
}
struct BDA_TS_SELECTORINFO_ISDBS_EXT {
    bTMCC : UInt8[48]
}
struct BDA_DVBT2_L1_SIGNALLING_DATA {
    L1Pre_TYPE : UInt8
    L1Pre_BWT_S1_S2 : UInt8
    L1Pre_REPETITION_GUARD_PAPR : UInt8
    L1Pre_MOD_COD_FEC : UInt8
    L1Pre_POSTSIZE_INFO_PILOT : UInt8[5]
    L1Pre_TX_ID_AVAIL : UInt8
    L1Pre_CELL_ID : UInt8[2]
    L1Pre_NETWORK_ID : UInt8[2]
    L1Pre_T2SYSTEM_ID : UInt8[2]
    L1Pre_NUM_T2_FRAMES : UInt8
    L1Pre_NUM_DATA_REGENFLAG_L1POSTEXT : UInt8[2]
    L1Pre_NUMRF_CURRENTRF_RESERVED : UInt8[2]
    L1Pre_CRC32 : UInt8[4]
    L1PostData : UInt8[1]
}
struct BDA_RATING_PINRESET {
    bPinLength : UInt8
    argbNewPin : UInt8[1]
}
struct DVBSystemType extends Int32 {
    static DVB_Cable := 0
    static DVB_Terrestrial := 1
    static DVB_Satellite := 2
    static ISDB_Terrestrial := 3
    static ISDB_Satellite := 4
}
struct BDA_Channel extends Int32 {
    static BDA_UNDEFINED_CHANNEL := -1
}
struct ComponentCategory extends Int32 {
    static CategoryNotSet := -1
    static CategoryOther := 0
    static CategoryVideo := 1
    static CategoryAudio := 2
    static CategoryText := 3
    static CategorySubtitles := 4
    static CategoryCaptions := 5
    static CategorySuperimpose := 6
    static CategoryData := 7
    static CATEGORY_COUNT := 8
}
struct ComponentStatus extends Int32 {
    static StatusActive := 0
    static StatusInactive := 1
    static StatusUnavailable := 2
}
struct MPEG2StreamType extends Int32 {
    static BDA_UNITIALIZED_MPEG2STREAMTYPE := -1
    static Reserved1 := 0
    static ISO_IEC_11172_2_VIDEO := 1
    static ISO_IEC_13818_2_VIDEO := 2
    static ISO_IEC_11172_3_AUDIO := 3
    static ISO_IEC_13818_3_AUDIO := 4
    static ISO_IEC_13818_1_PRIVATE_SECTION := 5
    static ISO_IEC_13818_1_PES := 6
    static ISO_IEC_13522_MHEG := 7
    static ANNEX_A_DSM_CC := 8
    static ITU_T_REC_H_222_1 := 9
    static ISO_IEC_13818_6_TYPE_A := 10
    static ISO_IEC_13818_6_TYPE_B := 11
    static ISO_IEC_13818_6_TYPE_C := 12
    static ISO_IEC_13818_6_TYPE_D := 13
    static ISO_IEC_13818_1_AUXILIARY := 14
    static ISO_IEC_13818_7_AUDIO := 15
    static ISO_IEC_14496_2_VISUAL := 16
    static ISO_IEC_14496_3_AUDIO := 17
    static ISO_IEC_14496_1_IN_PES := 18
    static ISO_IEC_14496_1_IN_SECTION := 19
    static ISO_IEC_13818_6_DOWNLOAD := 20
    static METADATA_IN_PES := 21
    static METADATA_IN_SECTION := 22
    static METADATA_IN_DATA_CAROUSEL := 23
    static METADATA_IN_OBJECT_CAROUSEL := 24
    static METADATA_IN_DOWNLOAD_PROTOCOL := 25
    static IRPM_STREAMM := 26
    static ITU_T_H264 := 27
    static ISO_IEC_13818_1_RESERVED := 28
    static USER_PRIVATE := 16
    static HEVC_VIDEO_OR_TEMPORAL_VIDEO := 36
    static HEVC_TEMPORAL_VIDEO_SUBSET := 37
    static MPEG_H_AUDIO := 45
    static MPEG_H_AUDIO_MS := 46
    static ISO_IEC_USER_PRIVATE := 128
    static DOLBY_AC3_AUDIO := 129
    static DOLBY_DIGITAL_PLUS_AUDIO_ATSC := 135
}
struct MPEG2_TRANSPORT_STRIDE {
    dwOffset : UInt32
    dwPacketLength : UInt32
    dwStride : UInt32
}
struct ATSCComponentTypeFlags extends Int32 {
    static ATSCCT_AC3 := 1
}
struct BinaryConvolutionCodeRate extends Int32 {
    static BDA_BCC_RATE_NOT_SET := -1
    static BDA_BCC_RATE_NOT_DEFINED := 0
    static BDA_BCC_RATE_1_2 := 1
    static BDA_BCC_RATE_2_3 := 2
    static BDA_BCC_RATE_3_4 := 3
    static BDA_BCC_RATE_3_5 := 4
    static BDA_BCC_RATE_4_5 := 5
    static BDA_BCC_RATE_5_6 := 6
    static BDA_BCC_RATE_5_11 := 7
    static BDA_BCC_RATE_7_8 := 8
    static BDA_BCC_RATE_1_4 := 9
    static BDA_BCC_RATE_1_3 := 10
    static BDA_BCC_RATE_2_5 := 11
    static BDA_BCC_RATE_6_7 := 12
    static BDA_BCC_RATE_8_9 := 13
    static BDA_BCC_RATE_9_10 := 14
    static BDA_BCC_RATE_MAX := 15
}
struct FECMethod extends Int32 {
    static BDA_FEC_METHOD_NOT_SET := -1
    static BDA_FEC_METHOD_NOT_DEFINED := 0
    static BDA_FEC_VITERBI := 1
    static BDA_FEC_RS_204_188 := 2
    static BDA_FEC_LDPC := 3
    static BDA_FEC_BCH := 4
    static BDA_FEC_RS_147_130 := 5
    static BDA_FEC_MAX := 6
}
struct ModulationType extends Int32 {
    static BDA_MOD_NOT_SET := -1
    static BDA_MOD_NOT_DEFINED := 0
    static BDA_MOD_16QAM := 1
    static BDA_MOD_32QAM := 2
    static BDA_MOD_64QAM := 3
    static BDA_MOD_80QAM := 4
    static BDA_MOD_96QAM := 5
    static BDA_MOD_112QAM := 6
    static BDA_MOD_128QAM := 7
    static BDA_MOD_160QAM := 8
    static BDA_MOD_192QAM := 9
    static BDA_MOD_224QAM := 10
    static BDA_MOD_256QAM := 11
    static BDA_MOD_320QAM := 12
    static BDA_MOD_384QAM := 13
    static BDA_MOD_448QAM := 14
    static BDA_MOD_512QAM := 15
    static BDA_MOD_640QAM := 16
    static BDA_MOD_768QAM := 17
    static BDA_MOD_896QAM := 18
    static BDA_MOD_1024QAM := 19
    static BDA_MOD_QPSK := 20
    static BDA_MOD_BPSK := 21
    static BDA_MOD_OQPSK := 22
    static BDA_MOD_8VSB := 23
    static BDA_MOD_16VSB := 24
    static BDA_MOD_ANALOG_AMPLITUDE := 25
    static BDA_MOD_ANALOG_FREQUENCY := 26
    static BDA_MOD_8PSK := 27
    static BDA_MOD_RF := 28
    static BDA_MOD_16APSK := 29
    static BDA_MOD_32APSK := 30
    static BDA_MOD_NBC_QPSK := 31
    static BDA_MOD_NBC_8PSK := 32
    static BDA_MOD_DIRECTV := 33
    static BDA_MOD_ISDB_T_TMCC := 34
    static BDA_MOD_ISDB_S_TMCC := 35
    static BDA_MOD_MAX := 36
}
struct ScanModulationTypes extends Int32 {
    static BDA_SCAN_MOD_16QAM := 1
    static BDA_SCAN_MOD_32QAM := 2
    static BDA_SCAN_MOD_64QAM := 4
    static BDA_SCAN_MOD_80QAM := 8
    static BDA_SCAN_MOD_96QAM := 16
    static BDA_SCAN_MOD_112QAM := 32
    static BDA_SCAN_MOD_128QAM := 64
    static BDA_SCAN_MOD_160QAM := 128
    static BDA_SCAN_MOD_192QAM := 256
    static BDA_SCAN_MOD_224QAM := 512
    static BDA_SCAN_MOD_256QAM := 1024
    static BDA_SCAN_MOD_320QAM := 2048
    static BDA_SCAN_MOD_384QAM := 4096
    static BDA_SCAN_MOD_448QAM := 8192
    static BDA_SCAN_MOD_512QAM := 16384
    static BDA_SCAN_MOD_640QAM := 32768
    static BDA_SCAN_MOD_768QAM := 65536
    static BDA_SCAN_MOD_896QAM := 131072
    static BDA_SCAN_MOD_1024QAM := 262144
    static BDA_SCAN_MOD_QPSK := 524288
    static BDA_SCAN_MOD_BPSK := 1048576
    static BDA_SCAN_MOD_OQPSK := 2097152
    static BDA_SCAN_MOD_8VSB := 4194304
    static BDA_SCAN_MOD_16VSB := 8388608
    static BDA_SCAN_MOD_AM_RADIO := 16777216
    static BDA_SCAN_MOD_FM_RADIO := 33554432
    static BDA_SCAN_MOD_8PSK := 67108864
    static BDA_SCAN_MOD_RF := 134217728
    static ScanModulationTypesMask_MCE_DigitalCable := 11
    static ScanModulationTypesMask_MCE_TerrestrialATSC := 23
    static ScanModulationTypesMask_MCE_AnalogTv := 28
    static ScanModulationTypesMask_MCE_All_TV := -1
    static ScanModulationTypesMask_DVBC := 75
    static BDA_SCAN_MOD_16APSK := 268435456
    static BDA_SCAN_MOD_32APSK := 536870912
}
struct SpectralInversion extends Int32 {
    static BDA_SPECTRAL_INVERSION_NOT_SET := -1
    static BDA_SPECTRAL_INVERSION_NOT_DEFINED := 0
    static BDA_SPECTRAL_INVERSION_AUTOMATIC := 1
    static BDA_SPECTRAL_INVERSION_NORMAL := 2
    static BDA_SPECTRAL_INVERSION_INVERTED := 3
    static BDA_SPECTRAL_INVERSION_MAX := 4
}
struct Polarisation extends Int32 {
    static BDA_POLARISATION_NOT_SET := -1
    static BDA_POLARISATION_NOT_DEFINED := 0
    static BDA_POLARISATION_LINEAR_H := 1
    static BDA_POLARISATION_LINEAR_V := 2
    static BDA_POLARISATION_CIRCULAR_L := 3
    static BDA_POLARISATION_CIRCULAR_R := 4
    static BDA_POLARISATION_MAX := 5
}
struct LNB_Source extends Int32 {
    static BDA_LNB_SOURCE_NOT_SET := -1
    static BDA_LNB_SOURCE_NOT_DEFINED := 0
    static BDA_LNB_SOURCE_A := 1
    static BDA_LNB_SOURCE_B := 2
    static BDA_LNB_SOURCE_C := 3
    static BDA_LNB_SOURCE_D := 4
    static BDA_LNB_SOURCE_MAX := 5
}
struct GuardInterval extends Int32 {
    static BDA_GUARD_NOT_SET := -1
    static BDA_GUARD_NOT_DEFINED := 0
    static BDA_GUARD_1_32 := 1
    static BDA_GUARD_1_16 := 2
    static BDA_GUARD_1_8 := 3
    static BDA_GUARD_1_4 := 4
    static BDA_GUARD_1_128 := 5
    static BDA_GUARD_19_128 := 6
    static BDA_GUARD_19_256 := 7
    static BDA_GUARD_MAX := 8
}
struct HierarchyAlpha extends Int32 {
    static BDA_HALPHA_NOT_SET := -1
    static BDA_HALPHA_NOT_DEFINED := 0
    static BDA_HALPHA_1 := 1
    static BDA_HALPHA_2 := 2
    static BDA_HALPHA_4 := 3
    static BDA_HALPHA_MAX := 4
}
struct TransmissionMode extends Int32 {
    static BDA_XMIT_MODE_NOT_SET := -1
    static BDA_XMIT_MODE_NOT_DEFINED := 0
    static BDA_XMIT_MODE_2K := 1
    static BDA_XMIT_MODE_8K := 2
    static BDA_XMIT_MODE_4K := 3
    static BDA_XMIT_MODE_2K_INTERLEAVED := 4
    static BDA_XMIT_MODE_4K_INTERLEAVED := 5
    static BDA_XMIT_MODE_1K := 6
    static BDA_XMIT_MODE_16K := 7
    static BDA_XMIT_MODE_32K := 8
    static BDA_XMIT_MODE_MAX := 9
}
struct RollOff extends Int32 {
    static BDA_ROLL_OFF_NOT_SET := -1
    static BDA_ROLL_OFF_NOT_DEFINED := 0
    static BDA_ROLL_OFF_20 := 1
    static BDA_ROLL_OFF_25 := 2
    static BDA_ROLL_OFF_35 := 3
    static BDA_ROLL_OFF_MAX := 4
}
struct Pilot extends Int32 {
    static BDA_PILOT_NOT_SET := -1
    static BDA_PILOT_NOT_DEFINED := 0
    static BDA_PILOT_OFF := 1
    static BDA_PILOT_ON := 2
    static BDA_PILOT_MAX := 3
}
struct BDA_SIGNAL_TIMEOUTS {
    ulCarrierTimeoutMs : UInt32
    ulScanningTimeoutMs : UInt32
    ulTuningTimeoutMs : UInt32
}
struct BDA_Frequency extends Int32 {
    static BDA_FREQUENCY_NOT_SET := -1
    static BDA_FREQUENCY_NOT_DEFINED := 0
}
struct BDA_Range extends Int32 {
    static BDA_RANGE_NOT_SET := -1
    static BDA_RANGE_NOT_DEFINED := 0
}
struct BDA_Channel_Bandwidth extends Int32 {
    static BDA_CHAN_BANDWITH_NOT_SET := -1
    static BDA_CHAN_BANDWITH_NOT_DEFINED := 0
}
struct BDA_Frequency_Multiplier extends Int32 {
    static BDA_FREQUENCY_MULTIPLIER_NOT_SET := -1
    static BDA_FREQUENCY_MULTIPLIER_NOT_DEFINED := 0
}
struct BDA_Comp_Flags extends Int32 {
    static BDACOMP_NOT_DEFINED := 0
    static BDACOMP_EXCLUDE_TS_FROM_TR := 1
    static BDACOMP_INCLUDE_LOCATOR_IN_TR := 2
    static BDACOMP_INCLUDE_COMPONENTS_IN_TR := 4
}
struct ApplicationTypeType extends Int32 {
    static SCTE28_ConditionalAccess := 0
    static SCTE28_POD_Host_Binding_Information := 1
    static SCTE28_IPService := 2
    static SCTE28_NetworkInterface_SCTE55_2 := 3
    static SCTE28_NetworkInterface_SCTE55_1 := 4
    static SCTE28_CopyProtection := 5
    static SCTE28_Diagnostic := 6
    static SCTE28_Undesignated := 7
    static SCTE28_Reserved := 8
}
struct BDA_CONDITIONALACCESS_REQUESTTYPE extends Int32 {
    static CONDITIONALACCESS_ACCESS_UNSPECIFIED := 0
    static CONDITIONALACCESS_ACCESS_NOT_POSSIBLE := 1
    static CONDITIONALACCESS_ACCESS_POSSIBLE := 2
    static CONDITIONALACCESS_ACCESS_POSSIBLE_NO_STREAMING_DISRUPTION := 3
}
struct BDA_CONDITIONALACCESS_MMICLOSEREASON extends Int32 {
    static CONDITIONALACCESS_UNSPECIFIED := 0
    static CONDITIONALACCESS_CLOSED_ITSELF := 1
    static CONDITIONALACCESS_TUNER_REQUESTED_CLOSE := 2
    static CONDITIONALACCESS_DIALOG_TIMEOUT := 3
    static CONDITIONALACCESS_DIALOG_FOCUS_CHANGE := 4
    static CONDITIONALACCESS_DIALOG_USER_DISMISSED := 5
    static CONDITIONALACCESS_DIALOG_USER_NOT_AVAILABLE := 6
}
struct BDA_CONDITIONALACCESS_SESSION_RESULT extends Int32 {
    static CONDITIONALACCESS_SUCCESSFULL := 0
    static CONDITIONALACCESS_ENDED_NOCHANGE := 1
    static CONDITIONALACCESS_ABORTED := 2
}
struct BDA_DISCOVERY_STATE extends Int32 {
    static BDA_DISCOVERY_UNSPECIFIED := 0
    static BDA_DISCOVERY_REQUIRED := 1
    static BDA_DISCOVERY_COMPLETE := 2
}
struct SmartCardStatusType extends Int32 {
    static CardInserted := 0
    static CardRemoved := 1
    static CardError := 2
    static CardDataChanged := 3
    static CardFirmwareUpgrade := 4
}
struct SmartCardAssociationType extends Int32 {
    static NotAssociated := 0
    static Associated := 1
    static AssociationUnknown := 2
}
struct LocationCodeSchemeType extends Int32 {
    static SCTE_18 := 0
}
struct EALocationCodeType {
    LocationCodeScheme : LocationCodeSchemeType
    state_code : UInt8
    county_subdivision : UInt8
    county_code : UInt16
}
struct EntitlementType extends Int32 {
    static Entitled := 0
    static NotEntitled := 1
    static TechnicalFailure := 2
}
struct UICloseReasonType extends Int32 {
    static NotReady := 0
    static UserClosed := 1
    static SystemClosed := 2
    static DeviceClosed := 3
    static ErrorClosed := 4
}
struct SmartCardApplication {
    ApplicationType : ApplicationTypeType
    ApplicationVersion : UInt16
    pbstrApplicationName : BSTR
    pbstrApplicationURL : BSTR
}
struct BDA_DrmPairingError extends Int32 {
    static BDA_DrmPairing_Succeeded := 0
    static BDA_DrmPairing_HardwareFailure := 1
    static BDA_DrmPairing_NeedRevocationData := 2
    static BDA_DrmPairing_NeedIndiv := 3
    static BDA_DrmPairing_Other := 4
    static BDA_DrmPairing_DrmInitFailed := 5
    static BDA_DrmPairing_DrmNotPaired := 6
    static BDA_DrmPairing_DrmRePairSoon := 7
    static BDA_DrmPairing_Aborted := 8
    static BDA_DrmPairing_NeedSDKUpdate := 9
}
struct IBDA_NetworkProvider extends IUnknown {
    static IID := "{FD501041-8EBE-11CE-8183-00AA00577DA2}"
    PutSignalSource(ulSignalSource)
      => ComCall(3, this.p, UInt32, ulSignalSource)
    GetSignalSource(pulSignalSource)
      => ComCall(4, this.p, UInt32.Ptr, pulSignalSource)
    GetNetworkType(pguidNetworkType)
      => ComCall(5, this.p, GUID.Ptr, pguidNetworkType)
    PutTuningSpace(guidTuningSpace)
      => ComCall(6, this.p, GUID.Ptr, guidTuningSpace)
    GetTuningSpace(pguidTuingSpace)
      => ComCall(7, this.p, GUID.Ptr, pguidTuingSpace)
    RegisterDeviceFilter(pUnkFilterControl, ppvRegisitrationContext)
      => ComCall(8, this.p, IUnknown, pUnkFilterControl, UInt32.Ptr, ppvRegisitrationContext)
    UnRegisterDeviceFilter(pvRegistrationContext)
      => ComCall(9, this.p, UInt32, pvRegistrationContext)
}
struct IBDA_EthernetFilter extends IUnknown {
    static IID := "{71985F43-1CA1-11D3-9CC8-00C04F7971E0}"
    GetMulticastListSize(pulcbAddresses)
      => ComCall(3, this.p, UInt32.Ptr, pulcbAddresses)
    PutMulticastList(pAddressList)
      => ComCall(4, this.p, UInt32, pAddressList.Length, UInt8.Ptr, pAddressList)
    GetMulticastList(pAddressList)
      => ComCall(5, this.p, UInt32.Ptr, pAddressList.Length, UInt8.Ptr, pAddressList)
    PutMulticastMode(ulModeMask)
      => ComCall(6, this.p, UInt32, ulModeMask)
    GetMulticastMode(pulModeMask)
      => ComCall(7, this.p, UInt32.Ptr, pulModeMask)
}
struct IBDA_IPV4Filter extends IUnknown {
    static IID := "{71985F44-1CA1-11D3-9CC8-00C04F7971E0}"
    GetMulticastListSize(pulcbAddresses)
      => ComCall(3, this.p, UInt32.Ptr, pulcbAddresses)
    PutMulticastList(pAddressList)
      => ComCall(4, this.p, UInt32, pAddressList.Length, UInt8.Ptr, pAddressList)
    GetMulticastList(pAddressList)
      => ComCall(5, this.p, UInt32.Ptr, pAddressList.Length, UInt8.Ptr, pAddressList)
    PutMulticastMode(ulModeMask)
      => ComCall(6, this.p, UInt32, ulModeMask)
    GetMulticastMode(pulModeMask)
      => ComCall(7, this.p, UInt32.Ptr, pulModeMask)
}
struct IBDA_IPV6Filter extends IUnknown {
    static IID := "{E1785A74-2A23-4FB3-9245-A8F88017EF33}"
    GetMulticastListSize(pulcbAddresses)
      => ComCall(3, this.p, UInt32.Ptr, pulcbAddresses)
    PutMulticastList(pAddressList)
      => ComCall(4, this.p, UInt32, pAddressList.Length, UInt8.Ptr, pAddressList)
    GetMulticastList(pAddressList)
      => ComCall(5, this.p, UInt32.Ptr, pAddressList.Length, UInt8.Ptr, pAddressList)
    PutMulticastMode(ulModeMask)
      => ComCall(6, this.p, UInt32, ulModeMask)
    GetMulticastMode(pulModeMask)
      => ComCall(7, this.p, UInt32.Ptr, pulModeMask)
}
struct IBDA_DeviceControl extends IUnknown {
    static IID := "{FD0A5AF3-B41D-11D2-9C95-00C04F7971E0}"
    StartChanges()
      => ComCall(3, this.p)
    CheckChanges()
      => ComCall(4, this.p)
    CommitChanges()
      => ComCall(5, this.p)
    GetChangeState(pState)
      => ComCall(6, this.p, UInt32.Ptr, pState)
}
struct IBDA_PinControl extends IUnknown {
    static IID := "{0DED49D5-A8B7-4D5D-97A1-12B0C195874D}"
    GetPinID(pulPinID)
      => ComCall(3, this.p, UInt32.Ptr, pulPinID)
    GetPinType(pulPinType)
      => ComCall(4, this.p, UInt32.Ptr, pulPinType)
    RegistrationContext(pulRegistrationCtx)
      => ComCall(5, this.p, UInt32.Ptr, pulRegistrationCtx)
}
struct IBDA_SignalProperties extends IUnknown {
    static IID := "{D2F1644B-B409-11D2-BC69-00A0C9EE9E16}"
    PutNetworkType(guidNetworkType)
      => ComCall(3, this.p, GUID.Ptr, guidNetworkType)
    GetNetworkType(pguidNetworkType)
      => ComCall(4, this.p, GUID.Ptr, pguidNetworkType)
    PutSignalSource(ulSignalSource)
      => ComCall(5, this.p, UInt32, ulSignalSource)
    GetSignalSource(pulSignalSource)
      => ComCall(6, this.p, UInt32.Ptr, pulSignalSource)
    PutTuningSpace(guidTuningSpace)
      => ComCall(7, this.p, GUID.Ptr, guidTuningSpace)
    GetTuningSpace(pguidTuingSpace)
      => ComCall(8, this.p, GUID.Ptr, pguidTuingSpace)
}
struct IBDA_SignalStatistics extends IUnknown {
    static IID := "{1347D106-CF3A-428A-A5CB-AC0D9A2A4338}"
    put_SignalStrength(lDbStrength)
      => ComCall(3, this.p, Int32, lDbStrength)
    get_SignalStrength(plDbStrength)
      => ComCall(4, this.p, Int32.Ptr, plDbStrength)
    put_SignalQuality(lPercentQuality)
      => ComCall(5, this.p, Int32, lPercentQuality)
    get_SignalQuality(plPercentQuality)
      => ComCall(6, this.p, Int32.Ptr, plPercentQuality)
    put_SignalPresent(fPresent)
      => ComCall(7, this.p, BOOLEAN, fPresent)
    get_SignalPresent(pfPresent)
      => ComCall(8, this.p, UInt8.Ptr, pfPresent)
    put_SignalLocked(fLocked)
      => ComCall(9, this.p, BOOLEAN, fLocked)
    get_SignalLocked(pfLocked)
      => ComCall(10, this.p, UInt8.Ptr, pfLocked)
    put_SampleTime(lmsSampleTime)
      => ComCall(11, this.p, Int32, lmsSampleTime)
    get_SampleTime(plmsSampleTime)
      => ComCall(12, this.p, Int32.Ptr, plmsSampleTime)
}
struct IBDA_Topology extends IUnknown {
    static IID := "{79B56888-7FEA-4690-B45D-38FD3C7849BE}"
    GetNodeTypes(pulcNodeTypes, rgulNodeTypes)
      => ComCall(3, this.p, UInt32.Ptr, pulcNodeTypes, UInt32, rgulNodeTypes.Length, UInt32.Ptr, rgulNodeTypes)
    GetNodeDescriptors(ulcNodeDescriptors, rgNodeDescriptors)
      => ComCall(4, this.p, UInt32.Ptr, ulcNodeDescriptors, UInt32, rgNodeDescriptors.Length, BDANODE_DESCRIPTOR.Ptr, rgNodeDescriptors)
    GetNodeInterfaces(ulNodeType, pulcInterfaces, rgguidInterfaces)
      => ComCall(5, this.p, UInt32, ulNodeType, UInt32.Ptr, pulcInterfaces, UInt32, rgguidInterfaces.Length, GUID.Ptr, rgguidInterfaces)
    GetPinTypes(pulcPinTypes, rgulPinTypes)
      => ComCall(6, this.p, UInt32.Ptr, pulcPinTypes, UInt32, rgulPinTypes.Length, UInt32.Ptr, rgulPinTypes)
    GetTemplateConnections(pulcConnections, rgConnections)
      => ComCall(7, this.p, UInt32.Ptr, pulcConnections, UInt32, rgConnections.Length, BDA_TEMPLATE_CONNECTION.Ptr, rgConnections)
    CreatePin(ulPinType, pulPinId)
      => ComCall(8, this.p, UInt32, ulPinType, UInt32.Ptr, pulPinId)
    DeletePin(ulPinId)
      => ComCall(9, this.p, UInt32, ulPinId)
    SetMediaType(ulPinId, pMediaType)
      => ComCall(10, this.p, UInt32, ulPinId, AM_MEDIA_TYPE.Ptr, pMediaType)
    SetMedium(ulPinId, pMedium)
      => ComCall(11, this.p, UInt32, ulPinId, REGPINMEDIUM.Ptr, pMedium)
    CreateTopology(ulInputPinId, ulOutputPinId)
      => ComCall(12, this.p, UInt32, ulInputPinId, UInt32, ulOutputPinId)
    GetControlNode(ulInputPinId, ulOutputPinId, ulNodeType, ppControlNode)
      => ComCall(13, this.p, UInt32, ulInputPinId, UInt32, ulOutputPinId, UInt32, ulNodeType, IUnknown.Ptr, ppControlNode)
}
struct IBDA_VoidTransform extends IUnknown {
    static IID := "{71985F46-1CA1-11D3-9CC8-00C04F7971E0}"
    Start()
      => ComCall(3, this.p)
    Stop()
      => ComCall(4, this.p)
}
struct IBDA_NullTransform extends IUnknown {
    static IID := "{DDF15B0D-BD25-11D2-9CA0-00C04F7971E0}"
    Start()
      => ComCall(3, this.p)
    Stop()
      => ComCall(4, this.p)
}
struct IBDA_FrequencyFilter extends IUnknown {
    static IID := "{71985F47-1CA1-11D3-9CC8-00C04F7971E0}"
    put_Autotune(ulTransponder)
      => ComCall(3, this.p, UInt32, ulTransponder)
    get_Autotune(pulTransponder)
      => ComCall(4, this.p, UInt32.Ptr, pulTransponder)
    put_Frequency(ulFrequency)
      => ComCall(5, this.p, UInt32, ulFrequency)
    get_Frequency(pulFrequency)
      => ComCall(6, this.p, UInt32.Ptr, pulFrequency)
    put_Polarity(Polarity)
      => ComCall(7, this.p, Polarisation, Polarity)
    get_Polarity(pPolarity)
      => ComCall(8, this.p, Polarisation.Ptr, pPolarity)
    put_Range(ulRange)
      => ComCall(9, this.p, UInt32, ulRange)
    get_Range(pulRange)
      => ComCall(10, this.p, UInt32.Ptr, pulRange)
    put_Bandwidth(ulBandwidth)
      => ComCall(11, this.p, UInt32, ulBandwidth)
    get_Bandwidth(pulBandwidth)
      => ComCall(12, this.p, UInt32.Ptr, pulBandwidth)
    put_FrequencyMultiplier(ulMultiplier)
      => ComCall(13, this.p, UInt32, ulMultiplier)
    get_FrequencyMultiplier(pulMultiplier)
      => ComCall(14, this.p, UInt32.Ptr, pulMultiplier)
}
struct IBDA_LNBInfo extends IUnknown {
    static IID := "{992CF102-49F9-4719-A664-C4F23E2408F4}"
    put_LocalOscilatorFrequencyLowBand(ulLOFLow)
      => ComCall(3, this.p, UInt32, ulLOFLow)
    get_LocalOscilatorFrequencyLowBand(pulLOFLow)
      => ComCall(4, this.p, UInt32.Ptr, pulLOFLow)
    put_LocalOscilatorFrequencyHighBand(ulLOFHigh)
      => ComCall(5, this.p, UInt32, ulLOFHigh)
    get_LocalOscilatorFrequencyHighBand(pulLOFHigh)
      => ComCall(6, this.p, UInt32.Ptr, pulLOFHigh)
    put_HighLowSwitchFrequency(ulSwitchFrequency)
      => ComCall(7, this.p, UInt32, ulSwitchFrequency)
    get_HighLowSwitchFrequency(pulSwitchFrequency)
      => ComCall(8, this.p, UInt32.Ptr, pulSwitchFrequency)
}
struct IBDA_DiseqCommand extends IUnknown {
    static IID := "{F84E2AB0-3C6B-45E3-A0FC-8669D4B81F11}"
    put_EnableDiseqCommands(bEnable)
      => ComCall(3, this.p, BOOLEAN, bEnable)
    put_DiseqLNBSource(ulLNBSource)
      => ComCall(4, this.p, UInt32, ulLNBSource)
    put_DiseqUseToneBurst(bUseToneBurst)
      => ComCall(5, this.p, BOOLEAN, bUseToneBurst)
    put_DiseqRepeats(ulRepeats)
      => ComCall(6, this.p, UInt32, ulRepeats)
    put_DiseqSendCommand(ulRequestId, pbCommand)
      => ComCall(7, this.p, UInt32, ulRequestId, UInt32, pbCommand.Length, UInt8.Ptr, pbCommand)
    get_DiseqResponse(ulRequestId, pbResponse)
      => ComCall(8, this.p, UInt32, ulRequestId, UInt32.Ptr, pbResponse.Length, UInt8.Ptr, pbResponse)
}
struct IBDA_AutoDemodulate extends IUnknown {
    static IID := "{DDF15B12-BD25-11D2-9CA0-00C04F7971E0}"
    put_AutoDemodulate()
      => ComCall(3, this.p)
}
struct IBDA_AutoDemodulateEx extends IBDA_AutoDemodulate {
    static IID := "{34518D13-1182-48E6-B28F-B24987787326}"
    get_SupportedDeviceNodeTypes(ulcDeviceNodeTypesMax, pulcDeviceNodeTypes, pguidDeviceNodeTypes)
      => ComCall(4, this.p, UInt32, ulcDeviceNodeTypesMax, UInt32.Ptr, pulcDeviceNodeTypes, GUID.Ptr, pguidDeviceNodeTypes)
    get_SupportedVideoFormats(pulAMTunerModeType, pulAnalogVideoStandard)
      => ComCall(5, this.p, UInt32.Ptr, pulAMTunerModeType, UInt32.Ptr, pulAnalogVideoStandard)
    get_AuxInputCount(pulCompositeCount, pulSvideoCount)
      => ComCall(6, this.p, UInt32.Ptr, pulCompositeCount, UInt32.Ptr, pulSvideoCount)
}
struct IBDA_DigitalDemodulator extends IUnknown {
    static IID := "{EF30F379-985B-4D10-B640-A79D5E04E1E0}"
    put_ModulationType(pModulationType)
      => ComCall(3, this.p, ModulationType.Ptr, pModulationType)
    get_ModulationType(pModulationType)
      => ComCall(4, this.p, ModulationType.Ptr, pModulationType)
    put_InnerFECMethod(pFECMethod)
      => ComCall(5, this.p, FECMethod.Ptr, pFECMethod)
    get_InnerFECMethod(pFECMethod)
      => ComCall(6, this.p, FECMethod.Ptr, pFECMethod)
    put_InnerFECRate(pFECRate)
      => ComCall(7, this.p, BinaryConvolutionCodeRate.Ptr, pFECRate)
    get_InnerFECRate(pFECRate)
      => ComCall(8, this.p, BinaryConvolutionCodeRate.Ptr, pFECRate)
    put_OuterFECMethod(pFECMethod)
      => ComCall(9, this.p, FECMethod.Ptr, pFECMethod)
    get_OuterFECMethod(pFECMethod)
      => ComCall(10, this.p, FECMethod.Ptr, pFECMethod)
    put_OuterFECRate(pFECRate)
      => ComCall(11, this.p, BinaryConvolutionCodeRate.Ptr, pFECRate)
    get_OuterFECRate(pFECRate)
      => ComCall(12, this.p, BinaryConvolutionCodeRate.Ptr, pFECRate)
    put_SymbolRate(pSymbolRate)
      => ComCall(13, this.p, UInt32.Ptr, pSymbolRate)
    get_SymbolRate(pSymbolRate)
      => ComCall(14, this.p, UInt32.Ptr, pSymbolRate)
    put_SpectralInversion(pSpectralInversion)
      => ComCall(15, this.p, SpectralInversion.Ptr, pSpectralInversion)
    get_SpectralInversion(pSpectralInversion)
      => ComCall(16, this.p, SpectralInversion.Ptr, pSpectralInversion)
}
struct IBDA_DigitalDemodulator2 extends IBDA_DigitalDemodulator {
    static IID := "{525ED3EE-5CF3-4E1E-9A06-5368A84F9A6E}"
    put_GuardInterval(pGuardInterval)
      => ComCall(17, this.p, GuardInterval.Ptr, pGuardInterval)
    get_GuardInterval(pGuardInterval)
      => ComCall(18, this.p, GuardInterval.Ptr, pGuardInterval)
    put_TransmissionMode(pTransmissionMode)
      => ComCall(19, this.p, TransmissionMode.Ptr, pTransmissionMode)
    get_TransmissionMode(pTransmissionMode)
      => ComCall(20, this.p, TransmissionMode.Ptr, pTransmissionMode)
    put_RollOff(pRollOff)
      => ComCall(21, this.p, RollOff.Ptr, pRollOff)
    get_RollOff(pRollOff)
      => ComCall(22, this.p, RollOff.Ptr, pRollOff)
    put_Pilot(pPilot)
      => ComCall(23, this.p, Pilot.Ptr, pPilot)
    get_Pilot(pPilot)
      => ComCall(24, this.p, Pilot.Ptr, pPilot)
}
struct IBDA_DigitalDemodulator3 extends IBDA_DigitalDemodulator2 {
    static IID := "{13F19604-7D32-4359-93A2-A05205D90AC9}"
    put_SignalTimeouts(pSignalTimeouts)
      => ComCall(25, this.p, BDA_SIGNAL_TIMEOUTS.Ptr, pSignalTimeouts)
    get_SignalTimeouts(pSignalTimeouts)
      => ComCall(26, this.p, BDA_SIGNAL_TIMEOUTS.Ptr, pSignalTimeouts)
    put_PLPNumber(pPLPNumber)
      => ComCall(27, this.p, UInt32.Ptr, pPLPNumber)
    get_PLPNumber(pPLPNumber)
      => ComCall(28, this.p, UInt32.Ptr, pPLPNumber)
}
struct KSPROPERTY_IPSINK extends Int32 {
    static KSPROPERTY_IPSINK_MULTICASTLIST := 0
    static KSPROPERTY_IPSINK_ADAPTER_DESCRIPTION := 1
    static KSPROPERTY_IPSINK_ADAPTER_ADDRESS := 2
}
struct ICCSubStreamFiltering extends IUnknown {
    static IID := "{4B2BD7EA-8347-467B-8DBF-62F784929CC3}"
    get_SubstreamTypes(pTypes)
      => ComCall(3, this.p, Int32.Ptr, pTypes)
    put_SubstreamTypes(Types)
      => ComCall(4, this.p, Int32, Types)
}
struct IBDA_IPSinkControl extends IUnknown {
    static IID := "{3F4DC8E2-4050-11D3-8F4B-00C04F7971E2}"
    GetMulticastList(pulcbSize, pbBuffer)
      => ComCall(3, this.p, UInt32.Ptr, pulcbSize, UInt8.Ptr.Ptr, pbBuffer)
    GetAdapterIPAddress(pulcbSize, pbBuffer)
      => ComCall(4, this.p, UInt32.Ptr, pulcbSize, UInt8.Ptr.Ptr, pbBuffer)
}
struct IBDA_IPSinkInfo extends IUnknown {
    static IID := "{A750108F-492E-4D51-95F7-649B23FF7AD7}"
    get_MulticastList(ppbAddressList)
      => ComCall(3, this.p, UInt32.Ptr, ppbAddressList.Length, UInt8.Ptr.Ptr, ppbAddressList)
    get_AdapterIPAddress(pbstrBuffer)
      => ComCall(4, this.p, BSTR.Ptr, pbstrBuffer)
    get_AdapterDescription(pbstrBuffer)
      => ComCall(5, this.p, BSTR.Ptr, pbstrBuffer)
}
struct IEnumPIDMap extends IUnknown {
    static IID := "{AFB6C2A2-2C41-11D3-8A60-0000F81E0E4A}"
    Next(pPIDMap, pcReceived)
      => ComCall(3, this.p, UInt32, pPIDMap.Length, PID_MAP.Ptr, pPIDMap, UInt32.Ptr, pcReceived)
    Skip(cRecords)
      => ComCall(4, this.p, UInt32, cRecords)
    Reset()
      => ComCall(5, this.p)
    Clone(ppIEnumPIDMap)
      => ComCall(6, this.p, IEnumPIDMap.Ptr, ppIEnumPIDMap)
}
struct IMPEG2PIDMap extends IUnknown {
    static IID := "{AFB6C2A1-2C41-11D3-8A60-0000F81E0E4A}"
    MapPID(culPID, pulPID, MediaSampleContent)
      => ComCall(3, this.p, UInt32, culPID, UInt32.Ptr, pulPID, MEDIA_SAMPLE_CONTENT, MediaSampleContent)
    UnmapPID(culPID, pulPID)
      => ComCall(4, this.p, UInt32, culPID, UInt32.Ptr, pulPID)
    EnumPIDMap(pIEnumPIDMap)
      => ComCall(5, this.p, IEnumPIDMap.Ptr, pIEnumPIDMap)
}
struct IFrequencyMap extends IUnknown {
    static IID := "{06FB45C1-693C-4EA7-B79F-7A6A54D8DEF2}"
    get_FrequencyMapping(ulCount, ppulList)
      => ComCall(3, this.p, UInt32.Ptr, ulCount, UInt32.Ptr.Ptr, ppulList)
    put_FrequencyMapping(pList)
      => ComCall(4, this.p, UInt32, pList.Length, UInt32.Ptr, pList)
    get_CountryCode(pulCountryCode)
      => ComCall(5, this.p, UInt32.Ptr, pulCountryCode)
    put_CountryCode(ulCountryCode)
      => ComCall(6, this.p, UInt32, ulCountryCode)
    get_DefaultFrequencyMapping(ulCountryCode, pulCount, ppulList)
      => ComCall(7, this.p, UInt32, ulCountryCode, UInt32.Ptr, pulCount, UInt32.Ptr.Ptr, ppulList)
    get_CountryCodeList(pulCount, ppulList)
      => ComCall(8, this.p, UInt32.Ptr, pulCount, UInt32.Ptr.Ptr, ppulList)
}
struct IBDA_EasMessage extends IUnknown {
    static IID := "{D806973D-3EBE-46DE-8FBB-6358FE784208}"
    get_EasMessage(ulEventID, ppEASObject)
      => ComCall(3, this.p, UInt32, ulEventID, IUnknown.Ptr, ppEASObject)
}
struct IBDA_TransportStreamInfo extends IUnknown {
    static IID := "{8E882535-5F86-47AB-86CF-C281A72A0549}"
    get_PatTableTickCount(pPatTickCount)
      => ComCall(3, this.p, UInt32.Ptr, pPatTickCount)
}
struct IBDA_ConditionalAccess extends IUnknown {
    static IID := "{CD51F1E0-7BE9-4123-8482-A2A796C0A6B0}"
    get_SmartCardStatus(pCardStatus, pCardAssociation, pbstrCardError, pfOOBLocked)
      => ComCall(3, this.p, SmartCardStatusType.Ptr, pCardStatus, SmartCardAssociationType.Ptr, pCardAssociation, BSTR.Ptr, pbstrCardError, VARIANT_BOOL.Ptr, pfOOBLocked)
    get_SmartCardInfo(pbstrCardName, pbstrCardManufacturer, pfDaylightSavings, pbyRatingRegion, plTimeZoneOffsetMinutes, pbstrLanguage, pEALocationCode)
      => ComCall(4, this.p, BSTR.Ptr, pbstrCardName, BSTR.Ptr, pbstrCardManufacturer, VARIANT_BOOL.Ptr, pfDaylightSavings, UInt8.Ptr, pbyRatingRegion, Int32.Ptr, plTimeZoneOffsetMinutes, BSTR.Ptr, pbstrLanguage, EALocationCodeType.Ptr, pEALocationCode)
    get_SmartCardApplications(pulcApplications, rgApplications)
      => ComCall(5, this.p, UInt32.Ptr, pulcApplications, UInt32, rgApplications.Length, SmartCardApplication.Ptr, rgApplications)
    get_Entitlement(usVirtualChannel, pEntitlement)
      => ComCall(6, this.p, UInt16, usVirtualChannel, EntitlementType.Ptr, pEntitlement)
    TuneByChannel(usVirtualChannel)
      => ComCall(7, this.p, UInt16, usVirtualChannel)
    SetProgram(usProgramNumber)
      => ComCall(8, this.p, UInt16, usProgramNumber)
    AddProgram(usProgramNumber)
      => ComCall(9, this.p, UInt16, usProgramNumber)
    RemoveProgram(usProgramNumber)
      => ComCall(10, this.p, UInt16, usProgramNumber)
    GetModuleUI(byDialogNumber, pbstrURL)
      => ComCall(11, this.p, UInt8, byDialogNumber, BSTR.Ptr, pbstrURL)
    InformUIClosed(byDialogNumber, CloseReason)
      => ComCall(12, this.p, UInt8, byDialogNumber, UICloseReasonType, CloseReason)
}
struct IBDA_DiagnosticProperties extends IPropertyBag {
    static IID := "{20E80CB5-C543-4C1B-8EB3-49E719EEE7D4}"
}
struct IBDA_DRM extends IUnknown {
    static IID := "{F98D88B0-1992-4CD6-A6D9-B9AFAB99330D}"
    GetDRMPairingStatus(pdwStatus, phError)
      => ComCall(3, this.p, UInt32.Ptr, pdwStatus, HRESULT.Ptr, phError)
    PerformDRMPairing(fSync)
      => ComCall(4, this.p, BOOL, fSync)
}
struct IBDA_NameValueService extends IUnknown {
    static IID := "{7F0B3150-7B81-4AD4-98E3-7E9097094301}"
    GetValueNameByIndex(ulIndex, pbstrName)
      => ComCall(3, this.p, UInt32, ulIndex, BSTR.Ptr, pbstrName)
    GetValue(bstrName, bstrLanguage, pbstrValue)
      => ComCall(4, this.p, BSTR, bstrName, BSTR, bstrLanguage, BSTR.Ptr, pbstrValue)
    SetValue(ulDialogRequest, bstrLanguage, bstrName, bstrValue, ulReserved)
      => ComCall(5, this.p, UInt32, ulDialogRequest, BSTR, bstrLanguage, BSTR, bstrName, BSTR, bstrValue, UInt32, ulReserved)
}
struct IBDA_ConditionalAccessEx extends IUnknown {
    static IID := "{497C3418-23CB-44BA-BB62-769F506FCEA7}"
    CheckEntitlementToken(ulDialogRequest, bstrLanguage, RequestType, pbEntitlementToken, pulDescrambleStatus)
      => ComCall(3, this.p, UInt32, ulDialogRequest, BSTR, bstrLanguage, BDA_CONDITIONALACCESS_REQUESTTYPE, RequestType, UInt32, pbEntitlementToken.Length, UInt8.Ptr, pbEntitlementToken, UInt32.Ptr, pulDescrambleStatus)
    SetCaptureToken(pbCaptureToken)
      => ComCall(4, this.p, UInt32, pbCaptureToken.Length, UInt8.Ptr, pbCaptureToken)
    OpenBroadcastMmi(ulDialogRequest, bstrLanguage, EventId)
      => ComCall(5, this.p, UInt32, ulDialogRequest, BSTR, bstrLanguage, UInt32, EventId)
    CloseMmiDialog(ulDialogRequest, bstrLanguage, ulDialogNumber, ReasonCode, pulSessionResult)
      => ComCall(6, this.p, UInt32, ulDialogRequest, BSTR, bstrLanguage, UInt32, ulDialogNumber, BDA_CONDITIONALACCESS_MMICLOSEREASON, ReasonCode, UInt32.Ptr, pulSessionResult)
    CreateDialogRequestNumber(pulDialogRequestNumber)
      => ComCall(7, this.p, UInt32.Ptr, pulDialogRequestNumber)
}
struct IBDA_ISDBConditionalAccess extends IUnknown {
    static IID := "{5E68C627-16C2-4E6C-B1E2-D00170CDAA0F}"
    SetIsdbCasRequest(ulRequestId, pbRequestBuffer)
      => ComCall(3, this.p, UInt32, ulRequestId, UInt32, pbRequestBuffer.Length, UInt8.Ptr, pbRequestBuffer)
}
struct IBDA_EventingService extends IUnknown {
    static IID := "{207C413F-00DC-4C61-BAD6-6FEE1FF07064}"
    CompleteEvent(ulEventID, ulEventResult)
      => ComCall(3, this.p, UInt32, ulEventID, UInt32, ulEventResult)
}
struct IBDA_AUX extends IUnknown {
    static IID := "{7DEF4C09-6E66-4567-A819-F0E17F4A81AB}"
    QueryCapabilities(pdwNumAuxInputsBSTR)
      => ComCall(3, this.p, UInt32.Ptr, pdwNumAuxInputsBSTR)
    EnumCapability(dwIndex, dwInputID, pConnectorType, ConnTypeNum, NumVideoStds, AnalogStds)
      => ComCall(4, this.p, UInt32, dwIndex, UInt32.Ptr, dwInputID, GUID.Ptr, pConnectorType, UInt32.Ptr, ConnTypeNum, UInt32.Ptr, NumVideoStds, Int64.Ptr, AnalogStds)
}
struct IBDA_Encoder extends IUnknown {
    static IID := "{3A8BAD59-59FE-4559-A0BA-396CFAA98AE3}"
    QueryCapabilities(NumAudioFmts, NumVideoFmts)
      => ComCall(3, this.p, UInt32.Ptr, NumAudioFmts, UInt32.Ptr, NumVideoFmts)
    EnumAudioCapability(FmtIndex, MethodID, AlgorithmType, SamplingRate, BitDepth, NumChannels)
      => ComCall(4, this.p, UInt32, FmtIndex, UInt32.Ptr, MethodID, UInt32.Ptr, AlgorithmType, UInt32.Ptr, SamplingRate, UInt32.Ptr, BitDepth, UInt32.Ptr, NumChannels)
    EnumVideoCapability(FmtIndex, MethodID, AlgorithmType, VerticalSize, HorizontalSize, AspectRatio, FrameRateCode, ProgressiveSequence)
      => ComCall(5, this.p, UInt32, FmtIndex, UInt32.Ptr, MethodID, UInt32.Ptr, AlgorithmType, UInt32.Ptr, VerticalSize, UInt32.Ptr, HorizontalSize, UInt32.Ptr, AspectRatio, UInt32.Ptr, FrameRateCode, UInt32.Ptr, ProgressiveSequence)
    SetParameters(AudioBitrateMode, AudioBitrate, AudioMethodID, AudioProgram, VideoBitrateMode, VideoBitrate, VideoMethodID)
      => ComCall(6, this.p, UInt32, AudioBitrateMode, UInt32, AudioBitrate, UInt32, AudioMethodID, UInt32, AudioProgram, UInt32, VideoBitrateMode, UInt32, VideoBitrate, UInt32, VideoMethodID)
    GetState(AudioBitrateMax, AudioBitrateMin, AudioBitrateMode, AudioBitrateStepping, AudioBitrate, AudioMethodID, AvailableAudioPrograms, AudioProgram, VideoBitrateMax, VideoBitrateMin, VideoBitrateMode, VideoBitrate, VideoBitrateStepping, VideoMethodID, SignalSourceID, SignalFormat, SignalLock, SignalLevel, SignalToNoiseRatio)
      => ComCall(7, this.p, UInt32.Ptr, AudioBitrateMax, UInt32.Ptr, AudioBitrateMin, UInt32.Ptr, AudioBitrateMode, UInt32.Ptr, AudioBitrateStepping, UInt32.Ptr, AudioBitrate, UInt32.Ptr, AudioMethodID, UInt32.Ptr, AvailableAudioPrograms, UInt32.Ptr, AudioProgram, UInt32.Ptr, VideoBitrateMax, UInt32.Ptr, VideoBitrateMin, UInt32.Ptr, VideoBitrateMode, UInt32.Ptr, VideoBitrate, UInt32.Ptr, VideoBitrateStepping, UInt32.Ptr, VideoMethodID, UInt32.Ptr, SignalSourceID, Int64.Ptr, SignalFormat, BOOL.Ptr, SignalLock, Int32.Ptr, SignalLevel, UInt32.Ptr, SignalToNoiseRatio)
}
struct IBDA_FDC extends IUnknown {
    static IID := "{138ADC7E-58AE-437F-B0B4-C9FE19D5B4AC}"
    GetStatus(CurrentBitrate, CarrierLock, CurrentFrequency, CurrentSpectrumInversion, CurrentPIDList, CurrentTIDList, Overflow)
      => ComCall(3, this.p, UInt32.Ptr, CurrentBitrate, BOOL.Ptr, CarrierLock, UInt32.Ptr, CurrentFrequency, BOOL.Ptr, CurrentSpectrumInversion, BSTR.Ptr, CurrentPIDList, BSTR.Ptr, CurrentTIDList, BOOL.Ptr, Overflow)
    RequestTables(TableIDs)
      => ComCall(4, this.p, BSTR, TableIDs)
    AddPid(PidsToAdd, RemainingFilterEntries)
      => ComCall(5, this.p, BSTR, PidsToAdd, UInt32.Ptr, RemainingFilterEntries)
    RemovePid(PidsToRemove)
      => ComCall(6, this.p, BSTR, PidsToRemove)
    AddTid(TidsToAdd, CurrentTidList)
      => ComCall(7, this.p, BSTR, TidsToAdd, BSTR.Ptr, CurrentTidList)
    RemoveTid(TidsToRemove)
      => ComCall(8, this.p, BSTR, TidsToRemove)
    GetTableSection(Pid, MaxBufferSize, ActualSize, SecBuffer)
      => ComCall(9, this.p, UInt32.Ptr, Pid, UInt32, MaxBufferSize, UInt32.Ptr, ActualSize, UInt8.Ptr, SecBuffer)
}
struct IBDA_GuideDataDeliveryService extends IUnknown {
    static IID := "{C0AFCB73-23E7-4BC6-BAFA-FDC167B4719F}"
    GetGuideDataType(pguidDataType)
      => ComCall(3, this.p, GUID.Ptr, pguidDataType)
    GetGuideData(pulcbBufferLen, pbBuffer, pulGuideDataPercentageProgress)
      => ComCall(4, this.p, UInt32.Ptr, pulcbBufferLen, UInt8.Ptr, pbBuffer, UInt32.Ptr, pulGuideDataPercentageProgress)
    RequestGuideDataUpdate()
      => ComCall(5, this.p)
    GetTuneXmlFromServiceIdx(ul64ServiceIdx, pbstrTuneXml)
      => ComCall(6, this.p, Int64, ul64ServiceIdx, BSTR.Ptr, pbstrTuneXml)
    GetServices(pulcbBufferLen, pbBuffer)
      => ComCall(7, this.p, UInt32.Ptr, pulcbBufferLen, UInt8.Ptr, pbBuffer)
    GetServiceInfoFromTuneXml(bstrTuneXml, pbstrServiceDescription)
      => ComCall(8, this.p, BSTR, bstrTuneXml, BSTR.Ptr, pbstrServiceDescription)
}
struct IBDA_DRMService extends IUnknown {
    static IID := "{BFF6B5BB-B0AE-484C-9DCA-73528FB0B46E}"
    SetDRM(puuidNewDrm)
      => ComCall(3, this.p, GUID.Ptr, puuidNewDrm)
    GetDRMStatus(pbstrDrmUuidList, DrmUuid)
      => ComCall(4, this.p, BSTR.Ptr, pbstrDrmUuidList, GUID.Ptr, DrmUuid)
}
struct IBDA_WMDRMSession extends IUnknown {
    static IID := "{4BE6FA3D-07CD-4139-8B80-8C18BA3AEC88}"
    GetStatus(MaxCaptureToken, MaxStreamingPid, MaxLicense, MinSecurityLevel, RevInfoSequenceNumber, RevInfoIssuedTime, RevInfoTTL, RevListVersion, ulState)
      => ComCall(3, this.p, UInt32.Ptr, MaxCaptureToken, UInt32.Ptr, MaxStreamingPid, UInt32.Ptr, MaxLicense, UInt32.Ptr, MinSecurityLevel, UInt32.Ptr, RevInfoSequenceNumber, Int64.Ptr, RevInfoIssuedTime, UInt32.Ptr, RevInfoTTL, UInt32.Ptr, RevListVersion, UInt32.Ptr, ulState)
    SetRevInfo(pbRevInfo)
      => ComCall(4, this.p, UInt32, pbRevInfo.Length, UInt8.Ptr, pbRevInfo)
    SetCrl(pbCrlLen)
      => ComCall(5, this.p, UInt32, pbCrlLen.Length, UInt8.Ptr, pbCrlLen)
    TransactMessage(pbRequest, pulcbResponse, pbResponse)
      => ComCall(6, this.p, UInt32, pbRequest.Length, UInt8.Ptr, pbRequest, UInt32.Ptr, pulcbResponse, UInt8.Ptr, pbResponse)
    GetLicense(uuidKey, pulPackageLen, pbPackage)
      => ComCall(7, this.p, GUID.Ptr, uuidKey, UInt32.Ptr, pulPackageLen, UInt8.Ptr, pbPackage)
    ReissueLicense(uuidKey)
      => ComCall(8, this.p, GUID.Ptr, uuidKey)
    RenewLicense(pbInXmrLicense, pbEntitlementToken, pulDescrambleStatus, pulOutXmrLicenseLen, pbOutXmrLicense)
      => ComCall(9, this.p, UInt32, pbInXmrLicense.Length, UInt8.Ptr, pbInXmrLicense, UInt32, pbEntitlementToken.Length, UInt8.Ptr, pbEntitlementToken, UInt32.Ptr, pulDescrambleStatus, UInt32.Ptr, pulOutXmrLicenseLen, UInt8.Ptr, pbOutXmrLicense)
    GetKeyInfo(pulKeyInfoLen, pbKeyInfo)
      => ComCall(10, this.p, UInt32.Ptr, pulKeyInfoLen, UInt8.Ptr, pbKeyInfo)
}
struct IBDA_WMDRMTuner extends IUnknown {
    static IID := "{86D979CF-A8A7-4F94-B5FB-14C0ACA68FE6}"
    PurchaseEntitlement(ulDialogRequest, bstrLanguage, pbPurchaseToken, pulDescrambleStatus, pulCaptureTokenLen, pbCaptureToken)
      => ComCall(3, this.p, UInt32, ulDialogRequest, BSTR, bstrLanguage, UInt32, pbPurchaseToken.Length, UInt8.Ptr, pbPurchaseToken, UInt32.Ptr, pulDescrambleStatus, UInt32.Ptr, pulCaptureTokenLen, UInt8.Ptr, pbCaptureToken)
    CancelCaptureToken(pbCaptureToken)
      => ComCall(4, this.p, UInt32, pbCaptureToken.Length, UInt8.Ptr, pbCaptureToken)
    SetPidProtection(ulPid, uuidKey)
      => ComCall(5, this.p, UInt32, ulPid, GUID.Ptr, uuidKey)
    GetPidProtection(pulPid, uuidKey)
      => ComCall(6, this.p, UInt32, pulPid, GUID.Ptr, uuidKey)
    SetSyncValue(ulSyncValue)
      => ComCall(7, this.p, UInt32, ulSyncValue)
    GetStartCodeProfile(pulStartCodeProfileLen, pbStartCodeProfile)
      => ComCall(8, this.p, UInt32.Ptr, pulStartCodeProfileLen, UInt8.Ptr, pbStartCodeProfile)
}
struct IBDA_DRIDRMService extends IUnknown {
    static IID := "{1F9BC2A5-44A3-4C52-AAB1-0BBCE5A1381D}"
    SetDRM(bstrNewDrm)
      => ComCall(3, this.p, BSTR, bstrNewDrm)
    GetDRMStatus(pbstrDrmUuidList, DrmUuid)
      => ComCall(4, this.p, BSTR.Ptr, pbstrDrmUuidList, GUID.Ptr, DrmUuid)
    GetPairingStatus(penumPairingStatus)
      => ComCall(5, this.p, BDA_DrmPairingError.Ptr, penumPairingStatus)
}
struct IBDA_DRIWMDRMSession extends IUnknown {
    static IID := "{05C690F8-56DB-4BB2-B053-79C12098BB26}"
    AcknowledgeLicense(hrLicenseAck)
      => ComCall(3, this.p, HRESULT, hrLicenseAck)
    ProcessLicenseChallenge(pbLicenseMessage, pdwcbLicenseResponse, ppbLicenseResponse)
      => ComCall(4, this.p, UInt32, pbLicenseMessage.Length, UInt8.Ptr, pbLicenseMessage, UInt32.Ptr, pdwcbLicenseResponse, UInt8.Ptr.Ptr, ppbLicenseResponse)
    ProcessRegistrationChallenge(pbRegistrationMessage, pdwcbRegistrationResponse, ppbRegistrationResponse)
      => ComCall(5, this.p, UInt32, pbRegistrationMessage.Length, UInt8.Ptr, pbRegistrationMessage, UInt32.Ptr, pdwcbRegistrationResponse, UInt8.Ptr.Ptr, ppbRegistrationResponse)
    SetRevInfo(pbRevInfo, pdwResponse)
      => ComCall(6, this.p, UInt32, pbRevInfo.Length, UInt8.Ptr, pbRevInfo, UInt32.Ptr, pdwResponse)
    SetCrl(pbCrlLen, pdwResponse)
      => ComCall(7, this.p, UInt32, pbCrlLen.Length, UInt8.Ptr, pbCrlLen, UInt32.Ptr, pdwResponse)
    GetHMSAssociationData()
      => ComCall(8, this.p)
    GetLastCardeaError(pdwError)
      => ComCall(9, this.p, UInt32.Ptr, pdwError)
}
struct IBDA_MUX extends IUnknown {
    static IID := "{942AAFEC-4C05-4C74-B8EB-8706C2A4943F}"
    SetPidList(pbPidListBuffer)
      => ComCall(3, this.p, UInt32, pbPidListBuffer.Length, BDA_MUX_PIDLISTITEM.Ptr, pbPidListBuffer)
    GetPidList(pulPidListCount, pbPidListBuffer)
      => ComCall(4, this.p, UInt32.Ptr, pulPidListCount, BDA_MUX_PIDLISTITEM.Ptr, pbPidListBuffer)
}
struct IBDA_TransportStreamSelector extends IUnknown {
    static IID := "{1DCFAFE9-B45E-41B3-BB2A-561EB129AE98}"
    SetTSID(usTSID)
      => ComCall(3, this.p, UInt16, usTSID)
    GetTSInformation(pbTSInformationBuffer)
      => ComCall(4, this.p, UInt32.Ptr, pbTSInformationBuffer.Length, UInt8.Ptr, pbTSInformationBuffer)
}
struct IBDA_UserActivityService extends IUnknown {
    static IID := "{53B14189-E478-4B7A-A1FF-506DB4B99DFE}"
    SetCurrentTunerUseReason(dwUseReason)
      => ComCall(3, this.p, UInt32, dwUseReason)
    GetUserActivityInterval(pdwActivityInterval)
      => ComCall(4, this.p, UInt32.Ptr, pdwActivityInterval)
    UserActivityDetected()
      => ComCall(5, this.p)
}
struct IESEvent extends IUnknown {
    static IID := "{1F0E5357-AF43-44E6-8547-654C645145D2}"
    GetEventId(pdwEventId)
      => ComCall(3, this.p, UInt32.Ptr, pdwEventId)
    GetEventType(pguidEventType)
      => ComCall(4, this.p, GUID.Ptr, pguidEventType)
    SetCompletionStatus(dwResult)
      => ComCall(5, this.p, UInt32, dwResult)
    GetData(pbData)
      => ComCall(6, this.p, SAFEARRAY.Ptr.Ptr, pbData)
    GetStringData(pbstrData)
      => ComCall(7, this.p, BSTR.Ptr, pbstrData)
}
struct IESEvents extends IUnknown {
    static IID := "{ABD414BF-CFE5-4E5E-AF5B-4B4E49C5BFEB}"
    OnESEventReceived(guidEventType, pESEvent)
      => ComCall(3, this.p, GUID, guidEventType, IESEvent, pESEvent)
}
struct IBroadcastEvent extends IUnknown {
    static IID := "{3B21263F-26E8-489D-AAC4-924F7EFD9511}"
    Fire(EventID)
      => ComCall(3, this.p, GUID, EventID)
}
struct IBroadcastEventEx extends IBroadcastEvent {
    static IID := "{3D9E3887-1929-423F-8021-43682DE95448}"
    FireEx(EventID, Param1, Param2, Param3, Param4)
      => ComCall(4, this.p, GUID, EventID, UInt32, Param1, UInt32, Param2, UInt32, Param3, UInt32, Param4)
}
struct IAMNetShowConfig extends IDispatch {
    static IID := "{FA2AA8F1-8B62-11D0-A520-000000000000}"
    get_BufferingTime(pBufferingTime)
      => ComCall(7, this.p, Float64.Ptr, pBufferingTime)
    put_BufferingTime(BufferingTime)
      => ComCall(8, this.p, Float64, BufferingTime)
    get_UseFixedUDPPort(pUseFixedUDPPort)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pUseFixedUDPPort)
    put_UseFixedUDPPort(UseFixedUDPPort)
      => ComCall(10, this.p, VARIANT_BOOL, UseFixedUDPPort)
    get_FixedUDPPort(pFixedUDPPort)
      => ComCall(11, this.p, Int32.Ptr, pFixedUDPPort)
    put_FixedUDPPort(FixedUDPPort)
      => ComCall(12, this.p, Int32, FixedUDPPort)
    get_UseHTTPProxy(pUseHTTPProxy)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pUseHTTPProxy)
    put_UseHTTPProxy(UseHTTPProxy)
      => ComCall(14, this.p, VARIANT_BOOL, UseHTTPProxy)
    get_EnableAutoProxy(pEnableAutoProxy)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, pEnableAutoProxy)
    put_EnableAutoProxy(EnableAutoProxy)
      => ComCall(16, this.p, VARIANT_BOOL, EnableAutoProxy)
    get_HTTPProxyHost(pbstrHTTPProxyHost)
      => ComCall(17, this.p, BSTR.Ptr, pbstrHTTPProxyHost)
    put_HTTPProxyHost(bstrHTTPProxyHost)
      => ComCall(18, this.p, BSTR, bstrHTTPProxyHost)
    get_HTTPProxyPort(pHTTPProxyPort)
      => ComCall(19, this.p, Int32.Ptr, pHTTPProxyPort)
    put_HTTPProxyPort(HTTPProxyPort)
      => ComCall(20, this.p, Int32, HTTPProxyPort)
    get_EnableMulticast(pEnableMulticast)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, pEnableMulticast)
    put_EnableMulticast(EnableMulticast)
      => ComCall(22, this.p, VARIANT_BOOL, EnableMulticast)
    get_EnableUDP(pEnableUDP)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, pEnableUDP)
    put_EnableUDP(EnableUDP)
      => ComCall(24, this.p, VARIANT_BOOL, EnableUDP)
    get_EnableTCP(pEnableTCP)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, pEnableTCP)
    put_EnableTCP(EnableTCP)
      => ComCall(26, this.p, VARIANT_BOOL, EnableTCP)
    get_EnableHTTP(pEnableHTTP)
      => ComCall(27, this.p, VARIANT_BOOL.Ptr, pEnableHTTP)
    put_EnableHTTP(EnableHTTP)
      => ComCall(28, this.p, VARIANT_BOOL, EnableHTTP)
}
struct IAMChannelInfo extends IDispatch {
    static IID := "{FA2AA8F2-8B62-11D0-A520-000000000000}"
    get_ChannelName(pbstrChannelName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrChannelName)
    get_ChannelDescription(pbstrChannelDescription)
      => ComCall(8, this.p, BSTR.Ptr, pbstrChannelDescription)
    get_ChannelURL(pbstrChannelURL)
      => ComCall(9, this.p, BSTR.Ptr, pbstrChannelURL)
    get_ContactAddress(pbstrContactAddress)
      => ComCall(10, this.p, BSTR.Ptr, pbstrContactAddress)
    get_ContactPhone(pbstrContactPhone)
      => ComCall(11, this.p, BSTR.Ptr, pbstrContactPhone)
    get_ContactEmail(pbstrContactEmail)
      => ComCall(12, this.p, BSTR.Ptr, pbstrContactEmail)
}
struct IAMNetworkStatus extends IDispatch {
    static IID := "{FA2AA8F3-8B62-11D0-A520-000000000000}"
    get_ReceivedPackets(pReceivedPackets)
      => ComCall(7, this.p, Int32.Ptr, pReceivedPackets)
    get_RecoveredPackets(pRecoveredPackets)
      => ComCall(8, this.p, Int32.Ptr, pRecoveredPackets)
    get_LostPackets(pLostPackets)
      => ComCall(9, this.p, Int32.Ptr, pLostPackets)
    get_ReceptionQuality(pReceptionQuality)
      => ComCall(10, this.p, Int32.Ptr, pReceptionQuality)
    get_BufferingCount(pBufferingCount)
      => ComCall(11, this.p, Int32.Ptr, pBufferingCount)
    get_IsBroadcast(pIsBroadcast)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, pIsBroadcast)
    get_BufferingProgress(pBufferingProgress)
      => ComCall(13, this.p, Int32.Ptr, pBufferingProgress)
}
struct AMExtendedSeekingCapabilities extends Int32 {
    static AM_EXSEEK_CANSEEK := 1
    static AM_EXSEEK_CANSCAN := 2
    static AM_EXSEEK_MARKERSEEK := 4
    static AM_EXSEEK_SCANWITHOUTCLOCK := 8
    static AM_EXSEEK_NOSTANDARDREPAINT := 16
    static AM_EXSEEK_BUFFERING := 32
    static AM_EXSEEK_SENDS_VIDEOFRAMEREADY := 64
}
struct IAMExtendedSeeking extends IDispatch {
    static IID := "{FA2AA8F9-8B62-11D0-A520-000000000000}"
    get_ExSeekCapabilities(pExCapabilities)
      => ComCall(7, this.p, Int32.Ptr, pExCapabilities)
    get_MarkerCount(pMarkerCount)
      => ComCall(8, this.p, Int32.Ptr, pMarkerCount)
    get_CurrentMarker(pCurrentMarker)
      => ComCall(9, this.p, Int32.Ptr, pCurrentMarker)
    GetMarkerTime(MarkerNum, pMarkerTime)
      => ComCall(10, this.p, Int32, MarkerNum, Float64.Ptr, pMarkerTime)
    GetMarkerName(MarkerNum, pbstrMarkerName)
      => ComCall(11, this.p, Int32, MarkerNum, BSTR.Ptr, pbstrMarkerName)
    put_PlaybackSpeed(Speed)
      => ComCall(12, this.p, Float64, Speed)
    get_PlaybackSpeed(pSpeed)
      => ComCall(13, this.p, Float64.Ptr, pSpeed)
}
struct IAMNetShowExProps extends IDispatch {
    static IID := "{FA2AA8F5-8B62-11D0-A520-000000000000}"
    get_SourceProtocol(pSourceProtocol)
      => ComCall(7, this.p, Int32.Ptr, pSourceProtocol)
    get_Bandwidth(pBandwidth)
      => ComCall(8, this.p, Int32.Ptr, pBandwidth)
    get_ErrorCorrection(pbstrErrorCorrection)
      => ComCall(9, this.p, BSTR.Ptr, pbstrErrorCorrection)
    get_CodecCount(pCodecCount)
      => ComCall(10, this.p, Int32.Ptr, pCodecCount)
    GetCodecInstalled(CodecNum, pCodecInstalled)
      => ComCall(11, this.p, Int32, CodecNum, VARIANT_BOOL.Ptr, pCodecInstalled)
    GetCodecDescription(CodecNum, pbstrCodecDescription)
      => ComCall(12, this.p, Int32, CodecNum, BSTR.Ptr, pbstrCodecDescription)
    GetCodecURL(CodecNum, pbstrCodecURL)
      => ComCall(13, this.p, Int32, CodecNum, BSTR.Ptr, pbstrCodecURL)
    get_CreationDate(pCreationDate)
      => ComCall(14, this.p, Float64.Ptr, pCreationDate)
    get_SourceLink(pbstrSourceLink)
      => ComCall(15, this.p, BSTR.Ptr, pbstrSourceLink)
}
struct IAMExtendedErrorInfo extends IDispatch {
    static IID := "{FA2AA8F6-8B62-11D0-A520-000000000000}"
    get_HasError(pHasError)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pHasError)
    get_ErrorDescription(pbstrErrorDescription)
      => ComCall(8, this.p, BSTR.Ptr, pbstrErrorDescription)
    get_ErrorCode(pErrorCode)
      => ComCall(9, this.p, Int32.Ptr, pErrorCode)
}
struct IAMMediaContent extends IDispatch {
    static IID := "{FA2AA8F4-8B62-11D0-A520-000000000000}"
    get_AuthorName(pbstrAuthorName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrAuthorName)
    get_Title(pbstrTitle)
      => ComCall(8, this.p, BSTR.Ptr, pbstrTitle)
    get_Rating(pbstrRating)
      => ComCall(9, this.p, BSTR.Ptr, pbstrRating)
    get_Description(pbstrDescription)
      => ComCall(10, this.p, BSTR.Ptr, pbstrDescription)
    get_Copyright(pbstrCopyright)
      => ComCall(11, this.p, BSTR.Ptr, pbstrCopyright)
    get_BaseURL(pbstrBaseURL)
      => ComCall(12, this.p, BSTR.Ptr, pbstrBaseURL)
    get_LogoURL(pbstrLogoURL)
      => ComCall(13, this.p, BSTR.Ptr, pbstrLogoURL)
    get_LogoIconURL(pbstrLogoURL)
      => ComCall(14, this.p, BSTR.Ptr, pbstrLogoURL)
    get_WatermarkURL(pbstrWatermarkURL)
      => ComCall(15, this.p, BSTR.Ptr, pbstrWatermarkURL)
    get_MoreInfoURL(pbstrMoreInfoURL)
      => ComCall(16, this.p, BSTR.Ptr, pbstrMoreInfoURL)
    get_MoreInfoBannerImage(pbstrMoreInfoBannerImage)
      => ComCall(17, this.p, BSTR.Ptr, pbstrMoreInfoBannerImage)
    get_MoreInfoBannerURL(pbstrMoreInfoBannerURL)
      => ComCall(18, this.p, BSTR.Ptr, pbstrMoreInfoBannerURL)
    get_MoreInfoText(pbstrMoreInfoText)
      => ComCall(19, this.p, BSTR.Ptr, pbstrMoreInfoText)
}
struct IAMMediaContent2 extends IDispatch {
    static IID := "{CE8F78C1-74D9-11D2-B09D-00A0C9A81117}"
    get_MediaParameter(EntryNum, bstrName, pbstrValue)
      => ComCall(7, this.p, Int32, EntryNum, BSTR, bstrName, BSTR.Ptr, pbstrValue)
    get_MediaParameterName(EntryNum, Index, pbstrName)
      => ComCall(8, this.p, Int32, EntryNum, Int32, Index, BSTR.Ptr, pbstrName)
    get_PlaylistCount(pNumberEntries)
      => ComCall(9, this.p, Int32.Ptr, pNumberEntries)
}
struct IAMNetShowPreroll extends IDispatch {
    static IID := "{AAE7E4E2-6388-11D1-8D93-006097C9A2B2}"
    put_Preroll(fPreroll)
      => ComCall(7, this.p, VARIANT_BOOL, fPreroll)
    get_Preroll(pfPreroll)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, pfPreroll)
}
struct IDShowPlugin extends IUnknown {
    static IID := "{4746B7C8-700E-11D1-BECC-00C04FB6E937}"
    get_URL(pURL)
      => ComCall(3, this.p, BSTR.Ptr, pURL)
    get_UserAgent(pUserAgent)
      => ComCall(4, this.p, BSTR.Ptr, pUserAgent)
}
struct IAMDirectSound extends IUnknown {
    static IID := "{546F4260-D53E-11CF-B3F0-00AA003761C5}"
    GetDirectSoundInterface(lplpds)
      => ComCall(3, this.p, IDirectSound.Ptr, lplpds)
    GetPrimaryBufferInterface(lplpdsb)
      => ComCall(4, this.p, IDirectSoundBuffer.Ptr, lplpdsb)
    GetSecondaryBufferInterface(lplpdsb)
      => ComCall(5, this.p, IDirectSoundBuffer.Ptr, lplpdsb)
    ReleaseDirectSoundInterface(lpds)
      => ComCall(6, this.p, IDirectSound, lpds)
    ReleasePrimaryBufferInterface(lpdsb)
      => ComCall(7, this.p, IDirectSoundBuffer, lpdsb)
    ReleaseSecondaryBufferInterface(lpdsb)
      => ComCall(8, this.p, IDirectSoundBuffer, lpdsb)
    SetFocusWindow(param0, param1)
      => ComCall(9, this.p, HWND, param0, BOOL, param1)
    GetFocusWindow(param0, param1)
      => ComCall(10, this.p, HWND.Ptr, param0, BOOL.Ptr, param1)
}
struct AM_LINE21_CCLEVEL extends Int32 {
    static AM_L21_CCLEVEL_TC2 := 0
}
struct AM_LINE21_CCSERVICE extends Int32 {
    static AM_L21_CCSERVICE_None := 0
    static AM_L21_CCSERVICE_Caption1 := 1
    static AM_L21_CCSERVICE_Caption2 := 2
    static AM_L21_CCSERVICE_Text1 := 3
    static AM_L21_CCSERVICE_Text2 := 4
    static AM_L21_CCSERVICE_XDS := 5
    static AM_L21_CCSERVICE_DefChannel := 10
    static AM_L21_CCSERVICE_Invalid := 11
}
struct AM_LINE21_CCSTATE extends Int32 {
    static AM_L21_CCSTATE_Off := 0
    static AM_L21_CCSTATE_On := 1
}
struct AM_LINE21_CCSTYLE extends Int32 {
    static AM_L21_CCSTYLE_None := 0
    static AM_L21_CCSTYLE_PopOn := 1
    static AM_L21_CCSTYLE_PaintOn := 2
    static AM_L21_CCSTYLE_RollUp := 3
}
struct AM_LINE21_DRAWBGMODE extends Int32 {
    static AM_L21_DRAWBGMODE_Opaque := 0
    static AM_L21_DRAWBGMODE_Transparent := 1
}
struct IAMLine21Decoder extends IUnknown {
    static IID := "{6E8D4A21-310C-11D0-B79A-00AA003767A7}"
    GetDecoderLevel(lpLevel)
      => ComCall(3, this.p, AM_LINE21_CCLEVEL.Ptr, lpLevel)
    GetCurrentService(lpService)
      => ComCall(4, this.p, AM_LINE21_CCSERVICE.Ptr, lpService)
    SetCurrentService(Service)
      => ComCall(5, this.p, AM_LINE21_CCSERVICE, Service)
    GetServiceState(lpState)
      => ComCall(6, this.p, AM_LINE21_CCSTATE.Ptr, lpState)
    SetServiceState(State)
      => ComCall(7, this.p, AM_LINE21_CCSTATE, State)
    GetOutputFormat(lpbmih)
      => ComCall(8, this.p, BITMAPINFOHEADER.Ptr, lpbmih)
    SetOutputFormat(lpbmi)
      => ComCall(9, this.p, BITMAPINFO.Ptr, lpbmi)
    GetBackgroundColor(pdwPhysColor)
      => ComCall(10, this.p, UInt32.Ptr, pdwPhysColor)
    SetBackgroundColor(dwPhysColor)
      => ComCall(11, this.p, UInt32, dwPhysColor)
    GetRedrawAlways(lpbOption)
      => ComCall(12, this.p, BOOL.Ptr, lpbOption)
    SetRedrawAlways(bOption)
      => ComCall(13, this.p, BOOL, bOption)
    GetDrawBackgroundMode(lpMode)
      => ComCall(14, this.p, AM_LINE21_DRAWBGMODE.Ptr, lpMode)
    SetDrawBackgroundMode(Mode)
      => ComCall(15, this.p, AM_LINE21_DRAWBGMODE, Mode)
}
struct IAMParse extends IUnknown {
    static IID := "{C47A3420-005C-11D2-9038-00A0C9697298}"
    GetParseTime(prtCurrent)
      => ComCall(3, this.p, Int64.Ptr, prtCurrent)
    SetParseTime(rtCurrent)
      => ComCall(4, this.p, Int64, rtCurrent)
    Flush()
      => ComCall(5, this.p)
}
struct IAMCollection extends IDispatch {
    static IID := "{56A868B9-0AD4-11CE-B03A-0020AF0BA770}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    Item(lItem, ppUnk)
      => ComCall(8, this.p, Int32, lItem, IUnknown.Ptr, ppUnk)
    get__NewEnum(ppUnk)
      => ComCall(9, this.p, IUnknown.Ptr, ppUnk)
}
struct IMediaControl extends IDispatch {
    static IID := "{56A868B1-0AD4-11CE-B03A-0020AF0BA770}"
    Run()
      => ComCall(7, this.p)
    Pause()
      => ComCall(8, this.p)
    Stop()
      => ComCall(9, this.p)
    GetState(msTimeout, pfs)
      => ComCall(10, this.p, Int32, msTimeout, Int32.Ptr, pfs)
    RenderFile(strFilename)
      => ComCall(11, this.p, BSTR, strFilename)
    AddSourceFilter(strFilename, ppUnk)
      => ComCall(12, this.p, BSTR, strFilename, IDispatch.Ptr, ppUnk)
    get_FilterCollection(ppUnk)
      => ComCall(13, this.p, IDispatch.Ptr, ppUnk)
    get_RegFilterCollection(ppUnk)
      => ComCall(14, this.p, IDispatch.Ptr, ppUnk)
    StopWhenReady()
      => ComCall(15, this.p)
}
struct IMediaEvent extends IDispatch {
    static IID := "{56A868B6-0AD4-11CE-B03A-0020AF0BA770}"
    GetEventHandle(hEvent)
      => ComCall(7, this.p, IntPtr.Ptr, hEvent)
    GetEvent(lEventCode, lParam1, lParam2, msTimeout)
      => ComCall(8, this.p, Int32.Ptr, lEventCode, IntPtr.Ptr, lParam1, IntPtr.Ptr, lParam2, Int32, msTimeout)
    WaitForCompletion(msTimeout, pEvCode)
      => ComCall(9, this.p, Int32, msTimeout, Int32.Ptr, pEvCode)
    CancelDefaultHandling(lEvCode)
      => ComCall(10, this.p, Int32, lEvCode)
    RestoreDefaultHandling(lEvCode)
      => ComCall(11, this.p, Int32, lEvCode)
    FreeEventParams(lEvCode, lParam1, lParam2)
      => ComCall(12, this.p, Int32, lEvCode, IntPtr, lParam1, IntPtr, lParam2)
}
struct IMediaEventEx extends IMediaEvent {
    static IID := "{56A868C0-0AD4-11CE-B03A-0020AF0BA770}"
    SetNotifyWindow(hwnd, lMsg, lInstanceData)
      => ComCall(13, this.p, IntPtr, hwnd, Int32, lMsg, IntPtr, lInstanceData)
    SetNotifyFlags(lNoNotifyFlags)
      => ComCall(14, this.p, Int32, lNoNotifyFlags)
    GetNotifyFlags(lplNoNotifyFlags)
      => ComCall(15, this.p, Int32.Ptr, lplNoNotifyFlags)
}
struct IMediaPosition extends IDispatch {
    static IID := "{56A868B2-0AD4-11CE-B03A-0020AF0BA770}"
    get_Duration(plength)
      => ComCall(7, this.p, Float64.Ptr, plength)
    put_CurrentPosition(llTime)
      => ComCall(8, this.p, Float64, llTime)
    get_CurrentPosition(pllTime)
      => ComCall(9, this.p, Float64.Ptr, pllTime)
    get_StopTime(pllTime)
      => ComCall(10, this.p, Float64.Ptr, pllTime)
    put_StopTime(llTime)
      => ComCall(11, this.p, Float64, llTime)
    get_PrerollTime(pllTime)
      => ComCall(12, this.p, Float64.Ptr, pllTime)
    put_PrerollTime(llTime)
      => ComCall(13, this.p, Float64, llTime)
    put_Rate(dRate)
      => ComCall(14, this.p, Float64, dRate)
    get_Rate(pdRate)
      => ComCall(15, this.p, Float64.Ptr, pdRate)
    CanSeekForward(pCanSeekForward)
      => ComCall(16, this.p, Int32.Ptr, pCanSeekForward)
    CanSeekBackward(pCanSeekBackward)
      => ComCall(17, this.p, Int32.Ptr, pCanSeekBackward)
}
struct IBasicAudio extends IDispatch {
    static IID := "{56A868B3-0AD4-11CE-B03A-0020AF0BA770}"
    put_Volume(lVolume)
      => ComCall(7, this.p, Int32, lVolume)
    get_Volume(plVolume)
      => ComCall(8, this.p, Int32.Ptr, plVolume)
    put_Balance(lBalance)
      => ComCall(9, this.p, Int32, lBalance)
    get_Balance(plBalance)
      => ComCall(10, this.p, Int32.Ptr, plBalance)
}
struct IVideoWindow extends IDispatch {
    static IID := "{56A868B4-0AD4-11CE-B03A-0020AF0BA770}"
    put_Caption(strCaption)
      => ComCall(7, this.p, BSTR, strCaption)
    get_Caption(strCaption)
      => ComCall(8, this.p, BSTR.Ptr, strCaption)
    put_WindowStyle(WindowStyle)
      => ComCall(9, this.p, Int32, WindowStyle)
    get_WindowStyle(WindowStyle)
      => ComCall(10, this.p, Int32.Ptr, WindowStyle)
    put_WindowStyleEx(WindowStyleEx)
      => ComCall(11, this.p, Int32, WindowStyleEx)
    get_WindowStyleEx(WindowStyleEx)
      => ComCall(12, this.p, Int32.Ptr, WindowStyleEx)
    put_AutoShow(AutoShow)
      => ComCall(13, this.p, Int32, AutoShow)
    get_AutoShow(AutoShow)
      => ComCall(14, this.p, Int32.Ptr, AutoShow)
    put_WindowState(WindowState)
      => ComCall(15, this.p, Int32, WindowState)
    get_WindowState(WindowState)
      => ComCall(16, this.p, SHOW_WINDOW_CMD.Ptr, WindowState)
    put_BackgroundPalette(BackgroundPalette)
      => ComCall(17, this.p, Int32, BackgroundPalette)
    get_BackgroundPalette(pBackgroundPalette)
      => ComCall(18, this.p, Int32.Ptr, pBackgroundPalette)
    put_Visible(Visible)
      => ComCall(19, this.p, Int32, Visible)
    get_Visible(pVisible)
      => ComCall(20, this.p, Int32.Ptr, pVisible)
    put_Left(Left)
      => ComCall(21, this.p, Int32, Left)
    get_Left(pLeft)
      => ComCall(22, this.p, Int32.Ptr, pLeft)
    put_Width(Width)
      => ComCall(23, this.p, Int32, Width)
    get_Width(pWidth)
      => ComCall(24, this.p, Int32.Ptr, pWidth)
    put_Top(Top)
      => ComCall(25, this.p, Int32, Top)
    get_Top(pTop)
      => ComCall(26, this.p, Int32.Ptr, pTop)
    put_Height(Height)
      => ComCall(27, this.p, Int32, Height)
    get_Height(pHeight)
      => ComCall(28, this.p, Int32.Ptr, pHeight)
    put_Owner(Owner)
      => ComCall(29, this.p, IntPtr, Owner)
    get_Owner(Owner)
      => ComCall(30, this.p, IntPtr.Ptr, Owner)
    put_MessageDrain(Drain)
      => ComCall(31, this.p, IntPtr, Drain)
    get_MessageDrain(Drain)
      => ComCall(32, this.p, IntPtr.Ptr, Drain)
    get_BorderColor(Color)
      => ComCall(33, this.p, Int32.Ptr, Color)
    put_BorderColor(Color)
      => ComCall(34, this.p, Int32, Color)
    get_FullScreenMode(FullScreenMode)
      => ComCall(35, this.p, Int32.Ptr, FullScreenMode)
    put_FullScreenMode(FullScreenMode)
      => ComCall(36, this.p, Int32, FullScreenMode)
    SetWindowForeground(Focus)
      => ComCall(37, this.p, Int32, Focus)
    NotifyOwnerMessage(hwnd, uMsg, wParam, lParam)
      => ComCall(38, this.p, IntPtr, hwnd, Int32, uMsg, IntPtr, wParam, IntPtr, lParam)
    SetWindowPosition(Left, Top, Width, Height)
      => ComCall(39, this.p, Int32, Left, Int32, Top, Int32, Width, Int32, Height)
    GetWindowPosition(pLeft, pTop, pWidth, pHeight)
      => ComCall(40, this.p, Int32.Ptr, pLeft, Int32.Ptr, pTop, Int32.Ptr, pWidth, Int32.Ptr, pHeight)
    GetMinIdealImageSize(pWidth, pHeight)
      => ComCall(41, this.p, Int32.Ptr, pWidth, Int32.Ptr, pHeight)
    GetMaxIdealImageSize(pWidth, pHeight)
      => ComCall(42, this.p, Int32.Ptr, pWidth, Int32.Ptr, pHeight)
    GetRestorePosition(pLeft, pTop, pWidth, pHeight)
      => ComCall(43, this.p, Int32.Ptr, pLeft, Int32.Ptr, pTop, Int32.Ptr, pWidth, Int32.Ptr, pHeight)
    HideCursor(HideCursor)
      => ComCall(44, this.p, OA_BOOL, HideCursor)
    IsCursorHidden(CursorHidden)
      => ComCall(45, this.p, Int32.Ptr, CursorHidden)
}
struct IBasicVideo extends IDispatch {
    static IID := "{56A868B5-0AD4-11CE-B03A-0020AF0BA770}"
    get_AvgTimePerFrame(pAvgTimePerFrame)
      => ComCall(7, this.p, Float64.Ptr, pAvgTimePerFrame)
    get_BitRate(pBitRate)
      => ComCall(8, this.p, Int32.Ptr, pBitRate)
    get_BitErrorRate(pBitErrorRate)
      => ComCall(9, this.p, Int32.Ptr, pBitErrorRate)
    get_VideoWidth(pVideoWidth)
      => ComCall(10, this.p, Int32.Ptr, pVideoWidth)
    get_VideoHeight(pVideoHeight)
      => ComCall(11, this.p, Int32.Ptr, pVideoHeight)
    put_SourceLeft(SourceLeft)
      => ComCall(12, this.p, Int32, SourceLeft)
    get_SourceLeft(pSourceLeft)
      => ComCall(13, this.p, Int32.Ptr, pSourceLeft)
    put_SourceWidth(SourceWidth)
      => ComCall(14, this.p, Int32, SourceWidth)
    get_SourceWidth(pSourceWidth)
      => ComCall(15, this.p, Int32.Ptr, pSourceWidth)
    put_SourceTop(SourceTop)
      => ComCall(16, this.p, Int32, SourceTop)
    get_SourceTop(pSourceTop)
      => ComCall(17, this.p, Int32.Ptr, pSourceTop)
    put_SourceHeight(SourceHeight)
      => ComCall(18, this.p, Int32, SourceHeight)
    get_SourceHeight(pSourceHeight)
      => ComCall(19, this.p, Int32.Ptr, pSourceHeight)
    put_DestinationLeft(DestinationLeft)
      => ComCall(20, this.p, Int32, DestinationLeft)
    get_DestinationLeft(pDestinationLeft)
      => ComCall(21, this.p, Int32.Ptr, pDestinationLeft)
    put_DestinationWidth(DestinationWidth)
      => ComCall(22, this.p, Int32, DestinationWidth)
    get_DestinationWidth(pDestinationWidth)
      => ComCall(23, this.p, Int32.Ptr, pDestinationWidth)
    put_DestinationTop(DestinationTop)
      => ComCall(24, this.p, Int32, DestinationTop)
    get_DestinationTop(pDestinationTop)
      => ComCall(25, this.p, Int32.Ptr, pDestinationTop)
    put_DestinationHeight(DestinationHeight)
      => ComCall(26, this.p, Int32, DestinationHeight)
    get_DestinationHeight(pDestinationHeight)
      => ComCall(27, this.p, Int32.Ptr, pDestinationHeight)
    SetSourcePosition(Left, Top, Width, Height)
      => ComCall(28, this.p, Int32, Left, Int32, Top, Int32, Width, Int32, Height)
    GetSourcePosition(pLeft, pTop, pWidth, pHeight)
      => ComCall(29, this.p, Int32.Ptr, pLeft, Int32.Ptr, pTop, Int32.Ptr, pWidth, Int32.Ptr, pHeight)
    SetDefaultSourcePosition()
      => ComCall(30, this.p)
    SetDestinationPosition(Left, Top, Width, Height)
      => ComCall(31, this.p, Int32, Left, Int32, Top, Int32, Width, Int32, Height)
    GetDestinationPosition(pLeft, pTop, pWidth, pHeight)
      => ComCall(32, this.p, Int32.Ptr, pLeft, Int32.Ptr, pTop, Int32.Ptr, pWidth, Int32.Ptr, pHeight)
    SetDefaultDestinationPosition()
      => ComCall(33, this.p)
    GetVideoSize(pWidth, pHeight)
      => ComCall(34, this.p, Int32.Ptr, pWidth, Int32.Ptr, pHeight)
    GetVideoPaletteEntries(StartIndex, Entries, pRetrieved, pPalette)
      => ComCall(35, this.p, Int32, StartIndex, Int32, Entries, Int32.Ptr, pRetrieved, Int32.Ptr, pPalette)
    GetCurrentImage(pBufferSize, pDIBImage)
      => ComCall(36, this.p, Int32.Ptr, pBufferSize, Int32.Ptr, pDIBImage)
    IsUsingDefaultSource()
      => ComCall(37, this.p)
    IsUsingDefaultDestination()
      => ComCall(38, this.p)
}
struct IBasicVideo2 extends IBasicVideo {
    static IID := "{329BB360-F6EA-11D1-9038-00A0C9697298}"
    GetPreferredAspectRatio(plAspectX, plAspectY)
      => ComCall(39, this.p, Int32.Ptr, plAspectX, Int32.Ptr, plAspectY)
}
struct IDeferredCommand extends IUnknown {
    static IID := "{56A868B8-0AD4-11CE-B03A-0020AF0BA770}"
    Cancel()
      => ComCall(3, this.p)
    Confidence(pConfidence)
      => ComCall(4, this.p, Int32.Ptr, pConfidence)
    Postpone(newtime)
      => ComCall(5, this.p, Float64, newtime)
    GetHResult(phrResult)
      => ComCall(6, this.p, HRESULT.Ptr, phrResult)
}
struct IQueueCommand extends IUnknown {
    static IID := "{56A868B7-0AD4-11CE-B03A-0020AF0BA770}"
    InvokeAtStreamTime(pCmd, time, iid, dispidMethod, wFlags, cArgs, pDispParams, pvarResult, puArgErr)
      => ComCall(3, this.p, IDeferredCommand.Ptr, pCmd, Float64, time, GUID.Ptr, iid, Int32, dispidMethod, Int16, wFlags, Int32, cArgs, VARIANT.Ptr, pDispParams, VARIANT.Ptr, pvarResult, Int16.Ptr, puArgErr)
    InvokeAtPresentationTime(pCmd, time, iid, dispidMethod, wFlags, cArgs, pDispParams, pvarResult, puArgErr)
      => ComCall(4, this.p, IDeferredCommand.Ptr, pCmd, Float64, time, GUID.Ptr, iid, Int32, dispidMethod, Int16, wFlags, Int32, cArgs, VARIANT.Ptr, pDispParams, VARIANT.Ptr, pvarResult, Int16.Ptr, puArgErr)
}
struct IFilterInfo extends IDispatch {
    static IID := "{56A868BA-0AD4-11CE-B03A-0020AF0BA770}"
    FindPin(strPinID, ppUnk)
      => ComCall(7, this.p, BSTR, strPinID, IDispatch.Ptr, ppUnk)
    get_Name(strName)
      => ComCall(8, this.p, BSTR.Ptr, strName)
    get_VendorInfo(strVendorInfo)
      => ComCall(9, this.p, BSTR.Ptr, strVendorInfo)
    get_Filter(ppUnk)
      => ComCall(10, this.p, IUnknown.Ptr, ppUnk)
    get_Pins(ppUnk)
      => ComCall(11, this.p, IDispatch.Ptr, ppUnk)
    get_IsFileSource(pbIsSource)
      => ComCall(12, this.p, Int32.Ptr, pbIsSource)
    get_Filename(pstrFilename)
      => ComCall(13, this.p, BSTR.Ptr, pstrFilename)
    put_Filename(strFilename)
      => ComCall(14, this.p, BSTR, strFilename)
}
struct IRegFilterInfo extends IDispatch {
    static IID := "{56A868BB-0AD4-11CE-B03A-0020AF0BA770}"
    get_Name(strName)
      => ComCall(7, this.p, BSTR.Ptr, strName)
    Filter(ppUnk)
      => ComCall(8, this.p, IDispatch.Ptr, ppUnk)
}
struct IMediaTypeInfo extends IDispatch {
    static IID := "{56A868BC-0AD4-11CE-B03A-0020AF0BA770}"
    get_Type(strType)
      => ComCall(7, this.p, BSTR.Ptr, strType)
    get_Subtype(strType)
      => ComCall(8, this.p, BSTR.Ptr, strType)
}
struct IPinInfo extends IDispatch {
    static IID := "{56A868BD-0AD4-11CE-B03A-0020AF0BA770}"
    get_Pin(ppUnk)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnk)
    get_ConnectedTo(ppUnk)
      => ComCall(8, this.p, IDispatch.Ptr, ppUnk)
    get_ConnectionMediaType(ppUnk)
      => ComCall(9, this.p, IDispatch.Ptr, ppUnk)
    get_FilterInfo(ppUnk)
      => ComCall(10, this.p, IDispatch.Ptr, ppUnk)
    get_Name(ppUnk)
      => ComCall(11, this.p, BSTR.Ptr, ppUnk)
    get_Direction(ppDirection)
      => ComCall(12, this.p, Int32.Ptr, ppDirection)
    get_PinID(strPinID)
      => ComCall(13, this.p, BSTR.Ptr, strPinID)
    get_MediaTypes(ppUnk)
      => ComCall(14, this.p, IDispatch.Ptr, ppUnk)
    Connect(pPin?)
      => ComCall(15, this.p, IUnknown, pPin?)
    ConnectDirect(pPin?)
      => ComCall(16, this.p, IUnknown, pPin?)
    ConnectWithType(pPin?, pMediaType?)
      => ComCall(17, this.p, IUnknown, pPin?, IDispatch, pMediaType?)
    Disconnect()
      => ComCall(18, this.p)
    Render()
      => ComCall(19, this.p)
}
struct IAMStats extends IDispatch {
    static IID := "{BC9BCF80-DCD2-11D2-ABF6-00A0C905F375}"
    Reset()
      => ComCall(7, this.p)
    get_Count(plCount)
      => ComCall(8, this.p, Int32.Ptr, plCount)
    GetValueByIndex(lIndex, szName, lCount, dLast, dAverage, dStdDev, dMin, dMax)
      => ComCall(9, this.p, Int32, lIndex, BSTR.Ptr, szName, Int32.Ptr, lCount, Float64.Ptr, dLast, Float64.Ptr, dAverage, Float64.Ptr, dStdDev, Float64.Ptr, dMin, Float64.Ptr, dMax)
    GetValueByName(szName, lIndex, lCount, dLast, dAverage, dStdDev, dMin, dMax)
      => ComCall(10, this.p, BSTR, szName, Int32.Ptr, lIndex, Int32.Ptr, lCount, Float64.Ptr, dLast, Float64.Ptr, dAverage, Float64.Ptr, dStdDev, Float64.Ptr, dMin, Float64.Ptr, dMax)
    GetIndex(szName, lCreate, plIndex)
      => ComCall(11, this.p, BSTR, szName, Int32, lCreate, Int32.Ptr, plIndex)
    AddValue(lIndex, dValue)
      => ComCall(12, this.p, Int32, lIndex, Float64, dValue)
}
struct AMVAUncompBufferInfo {
    dwMinNumSurfaces : UInt32
    dwMaxNumSurfaces : UInt32
    ddUncompPixelFormat : DDPIXELFORMAT
}
struct AMVAUncompDataInfo {
    dwUncompWidth : UInt32
    dwUncompHeight : UInt32
    ddUncompPixelFormat : DDPIXELFORMAT
}
struct AMVAInternalMemInfo {
    dwScratchMemAlloc : UInt32
}
struct AMVACompBufferInfo {
    dwNumCompBuffers : UInt32
    dwWidthToCreate : UInt32
    dwHeightToCreate : UInt32
    dwBytesToAllocate : UInt32
    ddCompCaps : DDSCAPS2
    ddPixelFormat : DDPIXELFORMAT
}
struct AMVABeginFrameInfo {
    dwDestSurfaceIndex : UInt32
    pInputData : Struct.Ptr
    dwSizeInputData : UInt32
    pOutputData : Struct.Ptr
    dwSizeOutputData : UInt32
}
struct AMVAEndFrameInfo {
    dwSizeMiscData : UInt32
    pMiscData : Struct.Ptr
}
struct AMVABUFFERINFO {
    dwTypeIndex : UInt32
    dwBufferIndex : UInt32
    dwDataOffset : UInt32
    dwDataSize : UInt32
}
struct IAMVideoAcceleratorNotify extends IUnknown {
    static IID := "{256A6A21-FBAD-11D1-82BF-00A0C9696C8F}"
    GetUncompSurfacesInfo(pGuid, pUncompBufferInfo)
      => ComCall(3, this.p, GUID.Ptr, pGuid, AMVAUncompBufferInfo.Ptr, pUncompBufferInfo)
    SetUncompSurfacesInfo(dwActualUncompSurfacesAllocated)
      => ComCall(4, this.p, UInt32, dwActualUncompSurfacesAllocated)
    GetCreateVideoAcceleratorData(pGuid, pdwSizeMiscData, ppMiscData)
      => ComCall(5, this.p, GUID.Ptr, pGuid, UInt32.Ptr, pdwSizeMiscData, Struct.Ptr.Ptr, ppMiscData)
}
struct IAMVideoAccelerator extends IUnknown {
    static IID := "{256A6A22-FBAD-11D1-82BF-00A0C9696C8F}"
    GetVideoAcceleratorGUIDs(pGuidsSupported?)
      => ComCall(3, this.p, UInt32.Ptr, pGuidsSupported?.Length ?? 0, GUID.Ptr, pGuidsSupported?)
    GetUncompFormatsSupported(pGuid, pFormatsSupported?)
      => ComCall(4, this.p, GUID.Ptr, pGuid, UInt32.Ptr, pFormatsSupported?.Length ?? 0, DDPIXELFORMAT.Ptr, pFormatsSupported?)
    GetInternalMemInfo(pGuid, pamvaUncompDataInfo, pamvaInternalMemInfo)
      => ComCall(5, this.p, GUID.Ptr, pGuid, AMVAUncompDataInfo.Ptr, pamvaUncompDataInfo, AMVAInternalMemInfo.Ptr, pamvaInternalMemInfo)
    GetCompBufferInfo(pGuid, pamvaUncompDataInfo, pamvaCompBufferInfo?)
      => ComCall(6, this.p, GUID.Ptr, pGuid, AMVAUncompDataInfo.Ptr, pamvaUncompDataInfo, UInt32.Ptr, pamvaCompBufferInfo?.Length ?? 0, AMVACompBufferInfo.Ptr, pamvaCompBufferInfo?)
    GetInternalCompBufferInfo(pamvaCompBufferInfo?)
      => ComCall(7, this.p, UInt32.Ptr, pamvaCompBufferInfo?.Length ?? 0, AMVACompBufferInfo.Ptr, pamvaCompBufferInfo?)
    BeginFrame(amvaBeginFrameInfo)
      => ComCall(8, this.p, AMVABeginFrameInfo.Ptr, amvaBeginFrameInfo)
    EndFrame(pEndFrameInfo)
      => ComCall(9, this.p, AMVAEndFrameInfo.Ptr, pEndFrameInfo)
    GetBuffer(dwTypeIndex, dwBufferIndex, bReadOnly, ppBuffer, lpStride)
      => ComCall(10, this.p, UInt32, dwTypeIndex, UInt32, dwBufferIndex, BOOL, bReadOnly, Struct.Ptr.Ptr, ppBuffer, Int32.Ptr, lpStride)
    ReleaseBuffer(dwTypeIndex, dwBufferIndex)
      => ComCall(11, this.p, UInt32, dwTypeIndex, UInt32, dwBufferIndex)
    Execute(dwFunction, lpPrivateInputData, cbPrivateInputData, lpPrivateOutputDat, cbPrivateOutputData, pamvaBufferInfo)
      => ComCall(12, this.p, UInt32, dwFunction, Struct.Ptr, lpPrivateInputData, UInt32, cbPrivateInputData, Struct.Ptr, lpPrivateOutputDat, UInt32, cbPrivateOutputData, UInt32, pamvaBufferInfo.Length, AMVABUFFERINFO.Ptr, pamvaBufferInfo)
    QueryRenderStatus(dwTypeIndex, dwBufferIndex, dwFlags)
      => ComCall(13, this.p, UInt32, dwTypeIndex, UInt32, dwBufferIndex, UInt32, dwFlags)
    DisplayFrame(dwFlipToIndex, pMediaSample)
      => ComCall(14, this.p, UInt32, dwFlipToIndex, IMediaSample, pMediaSample)
}
struct AM_WST_PAGE {
    dwPageNr : UInt32
    dwSubPageNr : UInt32
    pucPageData : UInt8.Ptr
}
struct AM_WST_LEVEL extends Int32 {
    static AM_WST_LEVEL_1_5 := 0
}
struct AM_WST_SERVICE extends Int32 {
    static AM_WST_SERVICE_None := 0
    static AM_WST_SERVICE_Text := 1
    static AM_WST_SERVICE_IDS := 2
    static AM_WST_SERVICE_Invalid := 3
}
struct AM_WST_STATE extends Int32 {
    static AM_WST_STATE_Off := 0
    static AM_WST_STATE_On := 1
}
struct AM_WST_STYLE extends Int32 {
    static AM_WST_STYLE_None := 0
    static AM_WST_STYLE_Invers := 1
}
struct AM_WST_DRAWBGMODE extends Int32 {
    static AM_WST_DRAWBGMODE_Opaque := 0
    static AM_WST_DRAWBGMODE_Transparent := 1
}
struct IAMWstDecoder extends IUnknown {
    static IID := "{C056DE21-75C2-11D3-A184-00105AEF9F33}"
    GetDecoderLevel(lpLevel)
      => ComCall(3, this.p, AM_WST_LEVEL.Ptr, lpLevel)
    GetCurrentService(lpService)
      => ComCall(4, this.p, AM_WST_SERVICE.Ptr, lpService)
    GetServiceState(lpState)
      => ComCall(5, this.p, AM_WST_STATE.Ptr, lpState)
    SetServiceState(State)
      => ComCall(6, this.p, AM_WST_STATE, State)
    GetOutputFormat(lpbmih)
      => ComCall(7, this.p, BITMAPINFOHEADER.Ptr, lpbmih)
    SetOutputFormat(lpbmi)
      => ComCall(8, this.p, BITMAPINFO.Ptr, lpbmi)
    GetBackgroundColor(pdwPhysColor)
      => ComCall(9, this.p, UInt32.Ptr, pdwPhysColor)
    SetBackgroundColor(dwPhysColor)
      => ComCall(10, this.p, UInt32, dwPhysColor)
    GetRedrawAlways(lpbOption)
      => ComCall(11, this.p, BOOL.Ptr, lpbOption)
    SetRedrawAlways(bOption)
      => ComCall(12, this.p, BOOL, bOption)
    GetDrawBackgroundMode(lpMode)
      => ComCall(13, this.p, AM_WST_DRAWBGMODE.Ptr, lpMode)
    SetDrawBackgroundMode(Mode)
      => ComCall(14, this.p, AM_WST_DRAWBGMODE, Mode)
    SetAnswerMode(bAnswer)
      => ComCall(15, this.p, BOOL, bAnswer)
    GetAnswerMode(pbAnswer)
      => ComCall(16, this.p, BOOL.Ptr, pbAnswer)
    SetHoldPage(bHoldPage)
      => ComCall(17, this.p, BOOL, bHoldPage)
    GetHoldPage(pbHoldPage)
      => ComCall(18, this.p, BOOL.Ptr, pbHoldPage)
    GetCurrentPage(pWstPage)
      => ComCall(19, this.p, AM_WST_PAGE.Ptr, pWstPage)
    SetCurrentPage(WstPage)
      => ComCall(20, this.p, AM_WST_PAGE, WstPage)
}
struct ISelector extends IUnknown {
    static IID := "{1ABDAECA-68B6-4F83-9371-B413907C7B9F}"
    get_NumSources(pdwNumSources)
      => ComCall(3, this.p, UInt32.Ptr, pdwNumSources)
    get_SourceNodeId(pdwPinId)
      => ComCall(4, this.p, UInt32.Ptr, pdwPinId)
    put_SourceNodeId(dwPinId)
      => ComCall(5, this.p, UInt32, dwPinId)
}
struct ICameraControl extends IUnknown {
    static IID := "{2BA1785D-4D1B-44EF-85E8-C7F1D3F20184}"
    get_Exposure(pValue, pFlags)
      => ComCall(3, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Exposure(Value, Flags)
      => ComCall(4, this.p, Int32, Value, Int32, Flags)
    getRange_Exposure(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(5, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_Focus(pValue, pFlags)
      => ComCall(6, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Focus(Value, Flags)
      => ComCall(7, this.p, Int32, Value, Int32, Flags)
    getRange_Focus(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(8, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_Iris(pValue, pFlags)
      => ComCall(9, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Iris(Value, Flags)
      => ComCall(10, this.p, Int32, Value, Int32, Flags)
    getRange_Iris(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(11, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_Zoom(pValue, pFlags)
      => ComCall(12, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Zoom(Value, Flags)
      => ComCall(13, this.p, Int32, Value, Int32, Flags)
    getRange_Zoom(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(14, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_FocalLengths(plOcularFocalLength, plObjectiveFocalLengthMin, plObjectiveFocalLengthMax)
      => ComCall(15, this.p, Int32.Ptr, plOcularFocalLength, Int32.Ptr, plObjectiveFocalLengthMin, Int32.Ptr, plObjectiveFocalLengthMax)
    get_Pan(pValue, pFlags)
      => ComCall(16, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Pan(Value, Flags)
      => ComCall(17, this.p, Int32, Value, Int32, Flags)
    getRange_Pan(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(18, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_Tilt(pValue, pFlags)
      => ComCall(19, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Tilt(Value, Flags)
      => ComCall(20, this.p, Int32, Value, Int32, Flags)
    getRange_Tilt(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(21, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_PanTilt(pPanValue, pTiltValue, pFlags)
      => ComCall(22, this.p, Int32.Ptr, pPanValue, Int32.Ptr, pTiltValue, Int32.Ptr, pFlags)
    put_PanTilt(PanValue, TiltValue, Flags)
      => ComCall(23, this.p, Int32, PanValue, Int32, TiltValue, Int32, Flags)
    get_Roll(pValue, pFlags)
      => ComCall(24, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Roll(Value, Flags)
      => ComCall(25, this.p, Int32, Value, Int32, Flags)
    getRange_Roll(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(26, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_ExposureRelative(pValue, pFlags)
      => ComCall(27, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_ExposureRelative(Value, Flags)
      => ComCall(28, this.p, Int32, Value, Int32, Flags)
    getRange_ExposureRelative(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(29, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_FocusRelative(pValue, pFlags)
      => ComCall(30, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_FocusRelative(Value, Flags)
      => ComCall(31, this.p, Int32, Value, Int32, Flags)
    getRange_FocusRelative(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(32, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_IrisRelative(pValue, pFlags)
      => ComCall(33, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_IrisRelative(Value, Flags)
      => ComCall(34, this.p, Int32, Value, Int32, Flags)
    getRange_IrisRelative(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(35, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_ZoomRelative(pValue, pFlags)
      => ComCall(36, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_ZoomRelative(Value, Flags)
      => ComCall(37, this.p, Int32, Value, Int32, Flags)
    getRange_ZoomRelative(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(38, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_PanRelative(pValue, pFlags)
      => ComCall(39, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_PanRelative(Value, Flags)
      => ComCall(40, this.p, Int32, Value, Int32, Flags)
    get_TiltRelative(pValue, pFlags)
      => ComCall(41, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_TiltRelative(Value, Flags)
      => ComCall(42, this.p, Int32, Value, Int32, Flags)
    getRange_TiltRelative(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(43, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_PanTiltRelative(pPanValue, pTiltValue, pFlags)
      => ComCall(44, this.p, Int32.Ptr, pPanValue, Int32.Ptr, pTiltValue, Int32.Ptr, pFlags)
    put_PanTiltRelative(PanValue, TiltValue, Flags)
      => ComCall(45, this.p, Int32, PanValue, Int32, TiltValue, Int32, Flags)
    getRange_PanRelative(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(46, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_RollRelative(pValue, pFlags)
      => ComCall(47, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_RollRelative(Value, Flags)
      => ComCall(48, this.p, Int32, Value, Int32, Flags)
    getRange_RollRelative(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(49, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_ScanMode(pValue, pFlags)
      => ComCall(50, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_ScanMode(Value, Flags)
      => ComCall(51, this.p, Int32, Value, Int32, Flags)
    get_PrivacyMode(pValue, pFlags)
      => ComCall(52, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_PrivacyMode(Value, Flags)
      => ComCall(53, this.p, Int32, Value, Int32, Flags)
}
struct IVideoProcAmp extends IUnknown {
    static IID := "{4050560E-42A7-413A-85C2-09269A2D0F44}"
    get_BacklightCompensation(pValue, pFlags)
      => ComCall(3, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_BacklightCompensation(Value, Flags)
      => ComCall(4, this.p, Int32, Value, Int32, Flags)
    getRange_BacklightCompensation(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(5, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_Brightness(pValue, pFlags)
      => ComCall(6, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Brightness(Value, Flags)
      => ComCall(7, this.p, Int32, Value, Int32, Flags)
    getRange_Brightness(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(8, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_ColorEnable(pValue, pFlags)
      => ComCall(9, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_ColorEnable(Value, Flags)
      => ComCall(10, this.p, Int32, Value, Int32, Flags)
    getRange_ColorEnable(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(11, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_Contrast(pValue, pFlags)
      => ComCall(12, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Contrast(Value, Flags)
      => ComCall(13, this.p, Int32, Value, Int32, Flags)
    getRange_Contrast(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(14, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_Gamma(pValue, pFlags)
      => ComCall(15, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Gamma(Value, Flags)
      => ComCall(16, this.p, Int32, Value, Int32, Flags)
    getRange_Gamma(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(17, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_Saturation(pValue, pFlags)
      => ComCall(18, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Saturation(Value, Flags)
      => ComCall(19, this.p, Int32, Value, Int32, Flags)
    getRange_Saturation(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(20, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_Sharpness(pValue, pFlags)
      => ComCall(21, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Sharpness(Value, Flags)
      => ComCall(22, this.p, Int32, Value, Int32, Flags)
    getRange_Sharpness(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(23, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_WhiteBalance(pValue, pFlags)
      => ComCall(24, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_WhiteBalance(Value, Flags)
      => ComCall(25, this.p, Int32, Value, Int32, Flags)
    getRange_WhiteBalance(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(26, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_Gain(pValue, pFlags)
      => ComCall(27, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Gain(Value, Flags)
      => ComCall(28, this.p, Int32, Value, Int32, Flags)
    getRange_Gain(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(29, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_Hue(pValue, pFlags)
      => ComCall(30, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_Hue(Value, Flags)
      => ComCall(31, this.p, Int32, Value, Int32, Flags)
    getRange_Hue(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(32, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_DigitalMultiplier(pValue, pFlags)
      => ComCall(33, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_DigitalMultiplier(Value, Flags)
      => ComCall(34, this.p, Int32, Value, Int32, Flags)
    getRange_DigitalMultiplier(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(35, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_PowerlineFrequency(pValue, pFlags)
      => ComCall(36, this.p, Int32.Ptr, pValue, Int32.Ptr, pFlags)
    put_PowerlineFrequency(Value, Flags)
      => ComCall(37, this.p, Int32, Value, Int32, Flags)
    getRange_PowerlineFrequency(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(38, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
    get_WhiteBalanceComponent(pValue1, pValue2, pFlags)
      => ComCall(39, this.p, Int32.Ptr, pValue1, Int32.Ptr, pValue2, Int32.Ptr, pFlags)
    put_WhiteBalanceComponent(Value1, Value2, Flags)
      => ComCall(40, this.p, Int32, Value1, Int32, Value2, Int32, Flags)
    getRange_WhiteBalanceComponent(pMin, pMax, pSteppingDelta, pDefault, pCapsFlag)
      => ComCall(41, this.p, Int32.Ptr, pMin, Int32.Ptr, pMax, Int32.Ptr, pSteppingDelta, Int32.Ptr, pDefault, Int32.Ptr, pCapsFlag)
}
struct IAMWMBufferPass extends IUnknown {
    static IID := "{6DD816D7-E740-4123-9E24-2444412644D8}"
    SetNotify(pCallback)
      => ComCall(3, this.p, IAMWMBufferPassCallback, pCallback)
}
struct IAMWMBufferPassCallback extends IUnknown {
    static IID := "{B25B8372-D2D2-44B2-8653-1B8DAE332489}"
    Notify(pNSSBuffer3, pPin, prtStart, prtEnd)
      => ComCall(3, this.p, INSSBuffer3, pNSSBuffer3, IPin, pPin, Int64.Ptr, prtStart, Int64.Ptr, prtEnd)
}
struct IConfigAsfWriter extends IUnknown {
    static IID := "{45086030-F7E4-486A-B504-826BB5792A3B}"
    ConfigureFilterUsingProfileId(dwProfileId)
      => ComCall(3, this.p, UInt32, dwProfileId)
    GetCurrentProfileId(pdwProfileId)
      => ComCall(4, this.p, UInt32.Ptr, pdwProfileId)
    ConfigureFilterUsingProfileGuid(guidProfile)
      => ComCall(5, this.p, GUID.Ptr, guidProfile)
    GetCurrentProfileGuid(pProfileGuid)
      => ComCall(6, this.p, GUID.Ptr, pProfileGuid)
    ConfigureFilterUsingProfile(pProfile)
      => ComCall(7, this.p, IWMProfile, pProfile)
    GetCurrentProfile(ppProfile)
      => ComCall(8, this.p, IWMProfile.Ptr, ppProfile)
    SetIndexMode(bIndexFile)
      => ComCall(9, this.p, BOOL, bIndexFile)
    GetIndexMode(pbIndexFile)
      => ComCall(10, this.p, BOOL.Ptr, pbIndexFile)
}
struct IConfigAsfWriter2 extends IConfigAsfWriter {
    static IID := "{7989CCAA-53F0-44F0-884A-F3B03F6AE066}"
    StreamNumFromPin(pPin, pwStreamNum)
      => ComCall(11, this.p, IPin, pPin, UInt16.Ptr, pwStreamNum)
    SetParam(dwParam, dwParam1, dwParam2)
      => ComCall(12, this.p, UInt32, dwParam, UInt32, dwParam1, UInt32, dwParam2)
    GetParam(dwParam, pdwParam1, pdwParam2)
      => ComCall(13, this.p, UInt32, dwParam, UInt32.Ptr, pdwParam1, UInt32.Ptr, pdwParam2)
    ResetMultiPassState()
      => ComCall(14, this.p)
}
struct STREAM_TYPE extends Int32 {
    static STREAMTYPE_READ := 0
    static STREAMTYPE_WRITE := 1
    static STREAMTYPE_TRANSFORM := 2
}
struct STREAM_STATE extends Int32 {
    static STREAMSTATE_STOP := 0
    static STREAMSTATE_RUN := 1
}
struct COMPLETION_STATUS_FLAGS extends Int32 {
    static COMPSTAT_NOUPDATEOK := 1
    static COMPSTAT_WAIT := 2
    static COMPSTAT_ABORT := 4
}
struct MMSSF_GET_INFORMATION_FLAGS extends Int32 {
    static MMSSF_HASCLOCK := 1
    static MMSSF_SUPPORTSEEK := 2
    static MMSSF_ASYNCHRONOUS := 4
}
struct SSUPDATE_TYPE extends Int32 {
    static SSUPDATE_ASYNC := 1
    static SSUPDATE_CONTINUOUS := 2
}
struct IMultiMediaStream extends IUnknown {
    static IID := "{B502D1BC-9A57-11D0-8FDE-00C04FD9189D}"
    GetInformation(pdwFlags, pStreamType)
      => ComCall(3, this.p, MMSSF_GET_INFORMATION_FLAGS.Ptr, pdwFlags, STREAM_TYPE.Ptr, pStreamType)
    GetMediaStream(idPurpose, ppMediaStream)
      => ComCall(4, this.p, GUID.Ptr, idPurpose, IMediaStream.Ptr, ppMediaStream)
    EnumMediaStreams(Index, ppMediaStream)
      => ComCall(5, this.p, Int32, Index, IMediaStream.Ptr, ppMediaStream)
    GetState(pCurrentState)
      => ComCall(6, this.p, STREAM_STATE.Ptr, pCurrentState)
    SetState(NewState)
      => ComCall(7, this.p, STREAM_STATE, NewState)
    GetTime(pCurrentTime)
      => ComCall(8, this.p, Int64.Ptr, pCurrentTime)
    GetDuration(pDuration)
      => ComCall(9, this.p, Int64.Ptr, pDuration)
    Seek(SeekTime)
      => ComCall(10, this.p, Int64, SeekTime)
    GetEndOfStreamEventHandle(phEOS)
      => ComCall(11, this.p, HANDLE.Ptr, phEOS)
}
struct IMediaStream extends IUnknown {
    static IID := "{B502D1BD-9A57-11D0-8FDE-00C04FD9189D}"
    GetMultiMediaStream(ppMultiMediaStream)
      => ComCall(3, this.p, IMultiMediaStream.Ptr, ppMultiMediaStream)
    GetInformation(pPurposeId, pType)
      => ComCall(4, this.p, GUID.Ptr, pPurposeId, STREAM_TYPE.Ptr, pType)
    SetSameFormat(pStreamThatHasDesiredFormat, dwFlags)
      => ComCall(5, this.p, IMediaStream, pStreamThatHasDesiredFormat, UInt32, dwFlags)
    AllocateSample(dwFlags, ppSample)
      => ComCall(6, this.p, UInt32, dwFlags, IStreamSample.Ptr, ppSample)
    CreateSharedSample(pExistingSample, dwFlags, ppNewSample)
      => ComCall(7, this.p, IStreamSample, pExistingSample, UInt32, dwFlags, IStreamSample.Ptr, ppNewSample)
    SendEndOfStream(dwFlags)
      => ComCall(8, this.p, UInt32, dwFlags)
}
struct IStreamSample extends IUnknown {
    static IID := "{B502D1BE-9A57-11D0-8FDE-00C04FD9189D}"
    GetMediaStream(ppMediaStream)
      => ComCall(3, this.p, IMediaStream.Ptr, ppMediaStream)
    GetSampleTimes(pStartTime, pEndTime, pCurrentTime)
      => ComCall(4, this.p, Int64.Ptr, pStartTime, Int64.Ptr, pEndTime, Int64.Ptr, pCurrentTime)
    SetSampleTimes(pStartTime, pEndTime)
      => ComCall(5, this.p, Int64.Ptr, pStartTime, Int64.Ptr, pEndTime)
    Update(dwFlags, hEvent, pfnAPC, dwAPCData)
      => ComCall(6, this.p, UInt32, dwFlags, HANDLE, hEvent, PAPCFUNC, pfnAPC, IntPtr, dwAPCData)
    CompletionStatus(dwFlags, dwMilliseconds)
      => ComCall(7, this.p, UInt32, dwFlags, UInt32, dwMilliseconds)
}
struct DDSFF_FLAGS extends Int32 {
    static DDSFF_PROGRESSIVERENDER := 1
}
struct IDirectDrawMediaStream extends IMediaStream {
    static IID := "{F4104FCE-9A70-11D0-8FDE-00C04FD9189D}"
    GetFormat(pDDSDCurrent, ppDirectDrawPalette, pDDSDDesired, pdwFlags)
      => ComCall(9, this.p, DDSURFACEDESC.Ptr, pDDSDCurrent, IDirectDrawPalette.Ptr, ppDirectDrawPalette, DDSURFACEDESC.Ptr, pDDSDDesired, UInt32.Ptr, pdwFlags)
    SetFormat(pDDSurfaceDesc, pDirectDrawPalette)
      => ComCall(10, this.p, DDSURFACEDESC.Ptr, pDDSurfaceDesc, IDirectDrawPalette, pDirectDrawPalette)
    GetDirectDraw(ppDirectDraw)
      => ComCall(11, this.p, IDirectDraw.Ptr, ppDirectDraw)
    SetDirectDraw(pDirectDraw)
      => ComCall(12, this.p, IDirectDraw, pDirectDraw)
    CreateSample(pSurface, pRect, dwFlags, ppSample)
      => ComCall(13, this.p, IDirectDrawSurface, pSurface, RECT.Ptr, pRect, UInt32, dwFlags, IDirectDrawStreamSample.Ptr, ppSample)
    GetTimePerFrame(pFrameTime)
      => ComCall(14, this.p, Int64.Ptr, pFrameTime)
}
struct IDirectDrawStreamSample extends IStreamSample {
    static IID := "{F4104FCF-9A70-11D0-8FDE-00C04FD9189D}"
    GetSurface(ppDirectDrawSurface, pRect)
      => ComCall(8, this.p, IDirectDrawSurface.Ptr, ppDirectDrawSurface, RECT.Ptr, pRect)
    SetRect(pRect)
      => ComCall(9, this.p, RECT.Ptr, pRect)
}
struct IAudioMediaStream extends IMediaStream {
    static IID := "{F7537560-A3BE-11D0-8212-00C04FC32C45}"
    GetFormat(pWaveFormatCurrent)
      => ComCall(9, this.p, WAVEFORMATEX.Ptr, pWaveFormatCurrent)
    SetFormat(lpWaveFormat)
      => ComCall(10, this.p, WAVEFORMATEX.Ptr, lpWaveFormat)
    CreateSample(pAudioData, dwFlags, ppSample)
      => ComCall(11, this.p, IAudioData, pAudioData, UInt32, dwFlags, IAudioStreamSample.Ptr, ppSample)
}
struct IAudioStreamSample extends IStreamSample {
    static IID := "{345FEE00-ABA5-11D0-8212-00C04FC32C45}"
    GetAudioData(ppAudio)
      => ComCall(8, this.p, IAudioData.Ptr, ppAudio)
}
struct IMemoryData extends IUnknown {
    static IID := "{327FC560-AF60-11D0-8212-00C04FC32C45}"
    SetBuffer(cbSize, pbData, dwFlags)
      => ComCall(3, this.p, UInt32, cbSize, UInt8.Ptr, pbData, UInt32, dwFlags)
    GetInfo(pdwLength, ppbData, pcbActualData)
      => ComCall(4, this.p, UInt32.Ptr, pdwLength, UInt8.Ptr.Ptr, ppbData, UInt32.Ptr, pcbActualData)
    SetActual(cbDataValid)
      => ComCall(5, this.p, UInt32, cbDataValid)
}
struct IAudioData extends IMemoryData {
    static IID := "{54C719C0-AF60-11D0-8212-00C04FC32C45}"
    GetFormat(pWaveFormatCurrent)
      => ComCall(6, this.p, WAVEFORMATEX.Ptr, pWaveFormatCurrent)
    SetFormat(lpWaveFormat)
      => ComCall(7, this.p, WAVEFORMATEX.Ptr, lpWaveFormat)
}
struct AMMSF_MMS_INIT_FLAGS extends Int32 {
    static AMMSF_NOGRAPHTHREAD := 1
}
struct AMMSF_MS_FLAGS extends Int32 {
    static AMMSF_ADDDEFAULTRENDERER := 1
    static AMMSF_CREATEPEER := 2
    static AMMSF_STOPIFNOSAMPLES := 4
    static AMMSF_NOSTALL := 8
}
struct AMMSF_RENDER_FLAGS extends Int32 {
    static AMMSF_RENDERTYPEMASK := 3
    static AMMSF_RENDERTOEXISTING := 0
    static AMMSF_RENDERALLSTREAMS := 1
    static AMMSF_NORENDER := 2
    static AMMSF_NOCLOCK := 4
    static AMMSF_RUN := 8
}
struct OUTPUT_STATE extends Int32 {
    static Disabled := 0
    static ReadData := 1
    static RenderData := 2
}
struct IAMMultiMediaStream extends IMultiMediaStream {
    static IID := "{BEBE595C-9A6F-11D0-8FDE-00C04FD9189D}"
    Initialize(StreamType, dwFlags, pFilterGraph)
      => ComCall(12, this.p, STREAM_TYPE, StreamType, UInt32, dwFlags, IGraphBuilder, pFilterGraph)
    GetFilterGraph(ppGraphBuilder)
      => ComCall(13, this.p, IGraphBuilder.Ptr, ppGraphBuilder)
    GetFilter(ppFilter)
      => ComCall(14, this.p, IMediaStreamFilter.Ptr, ppFilter)
    AddMediaStream(pStreamObject, PurposeId, dwFlags, ppNewStream)
      => ComCall(15, this.p, IUnknown, pStreamObject, GUID.Ptr, PurposeId, UInt32, dwFlags, IMediaStream.Ptr, ppNewStream)
    OpenFile(pszFileName, dwFlags)
      => ComCall(16, this.p, "Str", pszFileName, UInt32, dwFlags)
    OpenMoniker(pCtx, pMoniker, dwFlags)
      => ComCall(17, this.p, IBindCtx, pCtx, IMoniker, pMoniker, UInt32, dwFlags)
    Render(dwFlags)
      => ComCall(18, this.p, UInt32, dwFlags)
}
struct IAMMediaStream extends IMediaStream {
    static IID := "{BEBE595D-9A6F-11D0-8FDE-00C04FD9189D}"
    Initialize(pSourceObject, dwFlags, PurposeId, StreamType)
      => ComCall(9, this.p, IUnknown, pSourceObject, UInt32, dwFlags, GUID.Ptr, PurposeId, STREAM_TYPE, StreamType)
    SetState(State)
      => ComCall(10, this.p, FILTER_STATE, State)
    JoinAMMultiMediaStream(pAMMultiMediaStream)
      => ComCall(11, this.p, IAMMultiMediaStream, pAMMultiMediaStream)
    JoinFilter(pMediaStreamFilter)
      => ComCall(12, this.p, IMediaStreamFilter, pMediaStreamFilter)
    JoinFilterGraph(pFilterGraph)
      => ComCall(13, this.p, IFilterGraph, pFilterGraph)
}
struct IMediaStreamFilter extends IBaseFilter {
    static IID := "{BEBE595E-9A6F-11D0-8FDE-00C04FD9189D}"
    AddMediaStream(pAMMediaStream)
      => ComCall(15, this.p, IAMMediaStream, pAMMediaStream)
    GetMediaStream(idPurpose, ppMediaStream)
      => ComCall(16, this.p, GUID.Ptr, idPurpose, IMediaStream.Ptr, ppMediaStream)
    EnumMediaStreams(Index, ppMediaStream)
      => ComCall(17, this.p, Int32, Index, IMediaStream.Ptr, ppMediaStream)
    SupportSeeking(bRenderer)
      => ComCall(18, this.p, BOOL, bRenderer)
    ReferenceTimeToStreamTime(pTime)
      => ComCall(19, this.p, Int64.Ptr, pTime)
    GetCurrentStreamTime(pCurrentStreamTime)
      => ComCall(20, this.p, Int64.Ptr, pCurrentStreamTime)
    WaitUntil(WaitStreamTime)
      => ComCall(21, this.p, Int64, WaitStreamTime)
    Flush(bCancelEOS)
      => ComCall(22, this.p, BOOL, bCancelEOS)
    EndOfStream()
      => ComCall(23, this.p)
}
struct IDirectDrawMediaSampleAllocator extends IUnknown {
    static IID := "{AB6B4AFC-F6E4-11D0-900D-00C04FD9189D}"
    GetDirectDraw(ppDirectDraw)
      => ComCall(3, this.p, IDirectDraw.Ptr, ppDirectDraw)
}
struct IDirectDrawMediaSample extends IUnknown {
    static IID := "{AB6B4AFE-F6E4-11D0-900D-00C04FD9189D}"
    GetSurfaceAndReleaseLock(ppDirectDrawSurface, pRect)
      => ComCall(3, this.p, IDirectDrawSurface.Ptr, ppDirectDrawSurface, RECT.Ptr, pRect)
    LockMediaSamplePointer()
      => ComCall(4, this.p)
}
struct IAMMediaTypeStream extends IMediaStream {
    static IID := "{AB6B4AFA-F6E4-11D0-900D-00C04FD9189D}"
    GetFormat(pMediaType, dwFlags)
      => ComCall(9, this.p, AM_MEDIA_TYPE.Ptr, pMediaType, UInt32, dwFlags)
    SetFormat(pMediaType, dwFlags)
      => ComCall(10, this.p, AM_MEDIA_TYPE.Ptr, pMediaType, UInt32, dwFlags)
    CreateSample(lSampleSize, pbBuffer, dwFlags, pUnkOuter, ppAMMediaTypeSample)
      => ComCall(11, this.p, Int32, lSampleSize, UInt8.Ptr, pbBuffer, UInt32, dwFlags, IUnknown, pUnkOuter, IAMMediaTypeSample.Ptr, ppAMMediaTypeSample)
    GetStreamAllocatorRequirements(pProps)
      => ComCall(12, this.p, ALLOCATOR_PROPERTIES.Ptr, pProps)
    SetStreamAllocatorRequirements(pProps)
      => ComCall(13, this.p, ALLOCATOR_PROPERTIES.Ptr, pProps)
}
struct IAMMediaTypeSample extends IStreamSample {
    static IID := "{AB6B4AFB-F6E4-11D0-900D-00C04FD9189D}"
    SetPointer(pBuffer)
      => ComCall(8, this.p, UInt8.Ptr, pBuffer, Int32, pBuffer.Length)
    GetPointer(ppBuffer)
      => ComCall(9, this.p, UInt8.Ptr.Ptr, ppBuffer)
    GetSize()
      => ComCall(10, this.p, Int32)
    GetTime(pTimeStart, pTimeEnd)
      => ComCall(11, this.p, Int64.Ptr, pTimeStart, Int64.Ptr, pTimeEnd)
    SetTime(pTimeStart, pTimeEnd)
      => ComCall(12, this.p, Int64.Ptr, pTimeStart, Int64.Ptr, pTimeEnd)
    IsSyncPoint()
      => ComCall(13, this.p)
    SetSyncPoint(bIsSyncPoint)
      => ComCall(14, this.p, BOOL, bIsSyncPoint)
    IsPreroll()
      => ComCall(15, this.p)
    SetPreroll(bIsPreroll)
      => ComCall(16, this.p, BOOL, bIsPreroll)
    GetActualDataLength()
      => ComCall(17, this.p, Int32)
    SetActualDataLength(__MIDL__IAMMediaTypeSample0000)
      => ComCall(18, this.p, Int32, __MIDL__IAMMediaTypeSample0000)
    GetMediaType(ppMediaType)
      => ComCall(19, this.p, AM_MEDIA_TYPE.Ptr.Ptr, ppMediaType)
    SetMediaType(pMediaType)
      => ComCall(20, this.p, AM_MEDIA_TYPE.Ptr, pMediaType)
    IsDiscontinuity()
      => ComCall(21, this.p)
    SetDiscontinuity(bDiscontinuity)
      => ComCall(22, this.p, BOOL, bDiscontinuity)
    GetMediaTime(pTimeStart, pTimeEnd)
      => ComCall(23, this.p, Int64.Ptr, pTimeStart, Int64.Ptr, pTimeEnd)
    SetMediaTime(pTimeStart, pTimeEnd)
      => ComCall(24, this.p, Int64.Ptr, pTimeStart, Int64.Ptr, pTimeEnd)
}
struct IDirectDrawVideo extends IUnknown {
    static IID := "{36D39EB0-DD75-11CE-BF0E-00AA0055595A}"
    GetSwitches(pSwitches)
      => ComCall(3, this.p, UInt32.Ptr, pSwitches)
    SetSwitches(Switches)
      => ComCall(4, this.p, UInt32, Switches)
    GetCaps(pCaps)
      => ComCall(5, this.p, DDCAPS_DX7.Ptr, pCaps)
    GetEmulatedCaps(pCaps)
      => ComCall(6, this.p, DDCAPS_DX7.Ptr, pCaps)
    GetSurfaceDesc(pSurfaceDesc)
      => ComCall(7, this.p, DDSURFACEDESC.Ptr, pSurfaceDesc)
    GetFourCCCodes(pCount, pCodes)
      => ComCall(8, this.p, UInt32.Ptr, pCount, UInt32.Ptr, pCodes)
    SetDirectDraw(pDirectDraw)
      => ComCall(9, this.p, IDirectDraw, pDirectDraw)
    GetDirectDraw(ppDirectDraw)
      => ComCall(10, this.p, IDirectDraw.Ptr, ppDirectDraw)
    GetSurfaceType(pSurfaceType)
      => ComCall(11, this.p, UInt32.Ptr, pSurfaceType)
    SetDefault()
      => ComCall(12, this.p)
    UseScanLine(UseScanLine)
      => ComCall(13, this.p, Int32, UseScanLine)
    CanUseScanLine(UseScanLine)
      => ComCall(14, this.p, Int32.Ptr, UseScanLine)
    UseOverlayStretch(UseOverlayStretch)
      => ComCall(15, this.p, Int32, UseOverlayStretch)
    CanUseOverlayStretch(UseOverlayStretch)
      => ComCall(16, this.p, Int32.Ptr, UseOverlayStretch)
    UseWhenFullScreen(UseWhenFullScreen)
      => ComCall(17, this.p, Int32, UseWhenFullScreen)
    WillUseFullScreen(UseWhenFullScreen)
      => ComCall(18, this.p, Int32.Ptr, UseWhenFullScreen)
}
struct IQualProp extends IUnknown {
    static IID := "{1BD0ECB0-F8E2-11CE-AAC6-0020AF0B99A3}"
    get_FramesDroppedInRenderer(pcFrames)
      => ComCall(3, this.p, Int32.Ptr, pcFrames)
    get_FramesDrawn(pcFramesDrawn)
      => ComCall(4, this.p, Int32.Ptr, pcFramesDrawn)
    get_AvgFrameRate(piAvgFrameRate)
      => ComCall(5, this.p, Int32.Ptr, piAvgFrameRate)
    get_Jitter(iJitter)
      => ComCall(6, this.p, Int32.Ptr, iJitter)
    get_AvgSyncOffset(piAvg)
      => ComCall(7, this.p, Int32.Ptr, piAvg)
    get_DevSyncOffset(piDev)
      => ComCall(8, this.p, Int32.Ptr, piDev)
}
struct IFullScreenVideo extends IUnknown {
    static IID := "{DD1D7110-7836-11CF-BF47-00AA0055595A}"
    CountModes(pModes)
      => ComCall(3, this.p, Int32.Ptr, pModes)
    GetModeInfo(Mode, pWidth, pHeight, pDepth)
      => ComCall(4, this.p, Int32, Mode, Int32.Ptr, pWidth, Int32.Ptr, pHeight, Int32.Ptr, pDepth)
    GetCurrentMode(pMode)
      => ComCall(5, this.p, Int32.Ptr, pMode)
    IsModeAvailable(Mode)
      => ComCall(6, this.p, Int32, Mode)
    IsModeEnabled(Mode)
      => ComCall(7, this.p, Int32, Mode)
    SetEnabled(Mode, bEnabled)
      => ComCall(8, this.p, Int32, Mode, Int32, bEnabled)
    GetClipFactor(pClipFactor)
      => ComCall(9, this.p, Int32.Ptr, pClipFactor)
    SetClipFactor(ClipFactor)
      => ComCall(10, this.p, Int32, ClipFactor)
    SetMessageDrain(hwnd1)
      => ComCall(11, this.p, HWND, hwnd1)
    GetMessageDrain(hwnd)
      => ComCall(12, this.p, HWND.Ptr, hwnd)
    SetMonitor(Monitor)
      => ComCall(13, this.p, Int32, Monitor)
    GetMonitor(Monitor)
      => ComCall(14, this.p, Int32.Ptr, Monitor)
    HideOnDeactivate(Hide)
      => ComCall(15, this.p, Int32, Hide)
    IsHideOnDeactivate()
      => ComCall(16, this.p)
    SetCaption(strCaption)
      => ComCall(17, this.p, BSTR, strCaption)
    GetCaption(pstrCaption)
      => ComCall(18, this.p, BSTR.Ptr, pstrCaption)
    SetDefault()
      => ComCall(19, this.p)
}
struct IFullScreenVideoEx extends IFullScreenVideo {
    static IID := "{53479470-F1DD-11CF-BC42-00AA00AC74F6}"
    SetAcceleratorTable(hwnd1, hAccel1)
      => ComCall(20, this.p, HWND, hwnd1, HACCEL, hAccel1)
    GetAcceleratorTable(phwnd, phAccel)
      => ComCall(21, this.p, HWND.Ptr, phwnd, HACCEL.Ptr, phAccel)
    KeepPixelAspectRatio(KeepAspect)
      => ComCall(22, this.p, Int32, KeepAspect)
    IsKeepPixelAspectRatio(pKeepAspect)
      => ComCall(23, this.p, Int32.Ptr, pKeepAspect)
}
struct IBaseVideoMixer extends IUnknown {
    static IID := "{61DED640-E912-11CE-A099-00AA00479A58}"
    SetLeadPin(iPin)
      => ComCall(3, this.p, Int32, iPin)
    GetLeadPin(piPin)
      => ComCall(4, this.p, Int32.Ptr, piPin)
    GetInputPinCount(piPinCount)
      => ComCall(5, this.p, Int32.Ptr, piPinCount)
    IsUsingClock(pbValue)
      => ComCall(6, this.p, Int32.Ptr, pbValue)
    SetUsingClock(bValue)
      => ComCall(7, this.p, Int32, bValue)
    GetClockPeriod(pbValue)
      => ComCall(8, this.p, Int32.Ptr, pbValue)
    SetClockPeriod(bValue)
      => ComCall(9, this.p, Int32, bValue)
}
struct TRUECOLORINFO {
    dwBitMasks : UInt32[3]
    bmiColors : RGBQUAD[256]
}
struct VIDEOINFO {
    rcSource : RECT
    rcTarget : RECT
    dwBitRate : UInt32
    dwBitErrorRate : UInt32
    AvgTimePerFrame : Int64
    bmiHeader : BITMAPINFOHEADER
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            bmiColors : RGBQUAD[256]
            dwBitMasks : UInt32[3]
            TrueColorInfo : TRUECOLORINFO
        }
    }
}
struct ANALOGVIDEOINFO {
    rcSource : RECT
    rcTarget : RECT
    dwActiveWidth : UInt32
    dwActiveHeight : UInt32
    AvgTimePerFrame : Int64
}
struct AM_PROPERTY_FRAMESTEP extends Int32 {
    static AM_PROPERTY_FRAMESTEP_STEP := 1
    static AM_PROPERTY_FRAMESTEP_CANCEL := 2
    static AM_PROPERTY_FRAMESTEP_CANSTEP := 3
    static AM_PROPERTY_FRAMESTEP_CANSTEPMULTIPLE := 4
}
struct AM_FRAMESTEP_STEP {
    dwFramesToStep : UInt32
}
struct IDMOWrapperFilter extends IUnknown {
    static IID := "{52D6F586-9F0F-4824-8FC8-E32CA04930C2}"
    Init(clsidDMO, catDMO)
      => ComCall(3, this.p, GUID.Ptr, clsidDMO, GUID.Ptr, catDMO)
}
struct IMixerOCXNotify extends IUnknown {
    static IID := "{81A3BD31-DEE1-11D1-8508-00A0C91F9CA0}"
    OnInvalidateRect(lpcRect)
      => ComCall(3, this.p, RECT.Ptr, lpcRect)
    OnStatusChange(ulStatusFlags)
      => ComCall(4, this.p, UInt32, ulStatusFlags)
    OnDataChange(ulDataFlags)
      => ComCall(5, this.p, UInt32, ulDataFlags)
}
struct IMixerOCX extends IUnknown {
    static IID := "{81A3BD32-DEE1-11D1-8508-00A0C91F9CA0}"
    OnDisplayChange(ulBitsPerPixel, ulScreenWidth, ulScreenHeight)
      => ComCall(3, this.p, UInt32, ulBitsPerPixel, UInt32, ulScreenWidth, UInt32, ulScreenHeight)
    GetAspectRatio(pdwPictAspectRatioX, pdwPictAspectRatioY)
      => ComCall(4, this.p, UInt32.Ptr, pdwPictAspectRatioX, UInt32.Ptr, pdwPictAspectRatioY)
    GetVideoSize(pdwVideoWidth, pdwVideoHeight)
      => ComCall(5, this.p, UInt32.Ptr, pdwVideoWidth, UInt32.Ptr, pdwVideoHeight)
    GetStatus(pdwStatus)
      => ComCall(6, this.p, UInt32.Ptr.Ptr, pdwStatus)
    OnDraw(hdcDraw, prcDraw)
      => ComCall(7, this.p, HDC, hdcDraw, RECT.Ptr, prcDraw)
    SetDrawRegion(lpptTopLeftSC, prcDrawCC, lprcClip)
      => ComCall(8, this.p, POINT.Ptr, lpptTopLeftSC, RECT.Ptr, prcDrawCC, RECT.Ptr, lprcClip)
    Advise(pmdns)
      => ComCall(9, this.p, IMixerOCXNotify, pmdns)
    UnAdvise()
      => ComCall(10, this.p)
}
struct AM_ASPECT_RATIO_MODE extends Int32 {
    static AM_ARMODE_STRETCHED := 0
    static AM_ARMODE_LETTER_BOX := 1
    static AM_ARMODE_CROP := 2
    static AM_ARMODE_STRETCHED_AS_PRIMARY := 3
}
struct IMixerPinConfig extends IUnknown {
    static IID := "{593CDDE1-0759-11D1-9E69-00C04FD7C15B}"
    SetRelativePosition(dwLeft, dwTop, dwRight, dwBottom)
      => ComCall(3, this.p, UInt32, dwLeft, UInt32, dwTop, UInt32, dwRight, UInt32, dwBottom)
    GetRelativePosition(pdwLeft, pdwTop, pdwRight, pdwBottom)
      => ComCall(4, this.p, UInt32.Ptr, pdwLeft, UInt32.Ptr, pdwTop, UInt32.Ptr, pdwRight, UInt32.Ptr, pdwBottom)
    SetZOrder(dwZOrder)
      => ComCall(5, this.p, UInt32, dwZOrder)
    GetZOrder(pdwZOrder)
      => ComCall(6, this.p, UInt32.Ptr, pdwZOrder)
    SetColorKey(pColorKey)
      => ComCall(7, this.p, COLORKEY.Ptr, pColorKey)
    GetColorKey(pColorKey, pColor)
      => ComCall(8, this.p, COLORKEY.Ptr, pColorKey, UInt32.Ptr, pColor)
    SetBlendingParameter(dwBlendingParameter)
      => ComCall(9, this.p, UInt32, dwBlendingParameter)
    GetBlendingParameter(pdwBlendingParameter)
      => ComCall(10, this.p, UInt32.Ptr, pdwBlendingParameter)
    SetAspectRatioMode(amAspectRatioMode)
      => ComCall(11, this.p, AM_ASPECT_RATIO_MODE, amAspectRatioMode)
    GetAspectRatioMode(pamAspectRatioMode)
      => ComCall(12, this.p, AM_ASPECT_RATIO_MODE.Ptr, pamAspectRatioMode)
    SetStreamTransparent(bStreamTransparent)
      => ComCall(13, this.p, BOOL, bStreamTransparent)
    GetStreamTransparent(pbStreamTransparent)
      => ComCall(14, this.p, BOOL.Ptr, pbStreamTransparent)
}
struct IMixerPinConfig2 extends IMixerPinConfig {
    static IID := "{EBF47182-8764-11D1-9E69-00C04FD7C15B}"
    SetOverlaySurfaceColorControls(pColorControl)
      => ComCall(15, this.p, DDCOLORCONTROL.Ptr, pColorControl)
    GetOverlaySurfaceColorControls(pColorControl)
      => ComCall(16, this.p, DDCOLORCONTROL.Ptr, pColorControl)
}
struct AM_MPEGSTREAMTYPE {
    dwStreamId : UInt32
    dwReserved : UInt32
    mt : AM_MEDIA_TYPE
    bFormat : UInt8[1]
}
struct AM_MPEGSYSTEMTYPE {
    dwBitRate : UInt32
    cStreams : UInt32
    Streams : AM_MPEGSTREAMTYPE[1]
}
struct IMpegAudioDecoder extends IUnknown {
    static IID := "{B45DD570-3C77-11D1-ABE1-00A0C905F375}"
    get_FrequencyDivider(pDivider)
      => ComCall(3, this.p, UInt32.Ptr, pDivider)
    put_FrequencyDivider(Divider)
      => ComCall(4, this.p, UInt32, Divider)
    get_DecoderAccuracy(pAccuracy)
      => ComCall(5, this.p, UInt32.Ptr, pAccuracy)
    put_DecoderAccuracy(Accuracy)
      => ComCall(6, this.p, UInt32, Accuracy)
    get_Stereo(pStereo)
      => ComCall(7, this.p, UInt32.Ptr, pStereo)
    put_Stereo(Stereo)
      => ComCall(8, this.p, UInt32, Stereo)
    get_DecoderWordSize(pWordSize)
      => ComCall(9, this.p, UInt32.Ptr, pWordSize)
    put_DecoderWordSize(WordSize)
      => ComCall(10, this.p, UInt32, WordSize)
    get_IntegerDecode(pIntDecode)
      => ComCall(11, this.p, UInt32.Ptr, pIntDecode)
    put_IntegerDecode(IntDecode)
      => ComCall(12, this.p, UInt32, IntDecode)
    get_DualMode(pIntDecode)
      => ComCall(13, this.p, UInt32.Ptr, pIntDecode)
    put_DualMode(IntDecode)
      => ComCall(14, this.p, UInt32, IntDecode)
    get_AudioFormat(lpFmt)
      => ComCall(15, this.p, MPEG1WAVEFORMAT.Ptr, lpFmt)
}
struct VMR9PresentationFlags extends Int32 {
    static VMR9Sample_SyncPoint := 1
    static VMR9Sample_Preroll := 2
    static VMR9Sample_Discontinuity := 4
    static VMR9Sample_TimeValid := 8
    static VMR9Sample_SrcDstRectsValid := 16
}
struct VMR9PresentationInfo {
    dwFlags : UInt32
    lpSurf : IDirect3DSurface9
    rtStart : Int64
    rtEnd : Int64
    szAspectRatio : SIZE
    rcSrc : RECT
    rcDst : RECT
    dwReserved1 : UInt32
    dwReserved2 : UInt32
}
struct IVMRImagePresenter9 extends IUnknown {
    static IID := "{69188C61-12A3-40F0-8FFC-342E7B433FD7}"
    StartPresenting(dwUserID)
      => ComCall(3, this.p, IntPtr, dwUserID)
    StopPresenting(dwUserID)
      => ComCall(4, this.p, IntPtr, dwUserID)
    PresentImage(dwUserID, lpPresInfo)
      => ComCall(5, this.p, IntPtr, dwUserID, VMR9PresentationInfo.Ptr, lpPresInfo)
}
struct VMR9SurfaceAllocationFlags extends Int32 {
    static VMR9AllocFlag_3DRenderTarget := 1
    static VMR9AllocFlag_DXVATarget := 2
    static VMR9AllocFlag_TextureSurface := 4
    static VMR9AllocFlag_OffscreenSurface := 8
    static VMR9AllocFlag_RGBDynamicSwitch := 16
    static VMR9AllocFlag_UsageReserved := 224
    static VMR9AllocFlag_UsageMask := 255
}
struct VMR9AllocationInfo {
    dwFlags : UInt32
    dwWidth : UInt32
    dwHeight : UInt32
    Format : D3DFORMAT
    Pool : D3DPOOL
    MinBuffers : UInt32
    szAspectRatio : SIZE
    szNativeSize : SIZE
}
struct IVMRSurfaceAllocator9 extends IUnknown {
    static IID := "{8D5148EA-3F5D-46CF-9DF1-D1B896EEDB1F}"
    InitializeDevice(dwUserID, lpAllocInfo, lpNumBuffers)
      => ComCall(3, this.p, IntPtr, dwUserID, VMR9AllocationInfo.Ptr, lpAllocInfo, UInt32.Ptr, lpNumBuffers)
    TerminateDevice(dwID)
      => ComCall(4, this.p, IntPtr, dwID)
    GetSurface(dwUserID, SurfaceIndex, SurfaceFlags, lplpSurface)
      => ComCall(5, this.p, IntPtr, dwUserID, UInt32, SurfaceIndex, UInt32, SurfaceFlags, IDirect3DSurface9.Ptr, lplpSurface)
    AdviseNotify(lpIVMRSurfAllocNotify)
      => ComCall(6, this.p, IVMRSurfaceAllocatorNotify9, lpIVMRSurfAllocNotify)
}
struct IVMRSurfaceAllocatorEx9 extends IVMRSurfaceAllocator9 {
    static IID := "{6DE9A68A-A928-4522-BF57-655AE3866456}"
    GetSurfaceEx(dwUserID, SurfaceIndex, SurfaceFlags, lplpSurface, lprcDst)
      => ComCall(7, this.p, IntPtr, dwUserID, UInt32, SurfaceIndex, UInt32, SurfaceFlags, IDirect3DSurface9.Ptr, lplpSurface, RECT.Ptr, lprcDst)
}
struct IVMRSurfaceAllocatorNotify9 extends IUnknown {
    static IID := "{DCA3F5DF-BB3A-4D03-BD81-84614BFBFA0C}"
    AdviseSurfaceAllocator(dwUserID, lpIVRMSurfaceAllocator)
      => ComCall(3, this.p, IntPtr, dwUserID, IVMRSurfaceAllocator9, lpIVRMSurfaceAllocator)
    SetD3DDevice(lpD3DDevice, hMonitor1)
      => ComCall(4, this.p, IDirect3DDevice9, lpD3DDevice, HMONITOR, hMonitor1)
    ChangeD3DDevice(lpD3DDevice, hMonitor1)
      => ComCall(5, this.p, IDirect3DDevice9, lpD3DDevice, HMONITOR, hMonitor1)
    AllocateSurfaceHelper(lpAllocInfo, lpNumBuffers, lplpSurface)
      => ComCall(6, this.p, VMR9AllocationInfo.Ptr, lpAllocInfo, UInt32.Ptr, lpNumBuffers, IDirect3DSurface9.Ptr, lplpSurface)
    NotifyEvent(EventCode, Param1, Param2)
      => ComCall(7, this.p, Int32, EventCode, IntPtr, Param1, IntPtr, Param2)
}
struct VMR9AspectRatioMode extends Int32 {
    static VMR9ARMode_None := 0
    static VMR9ARMode_LetterBox := 1
}
struct IVMRWindowlessControl9 extends IUnknown {
    static IID := "{8F537D09-F85E-4414-B23B-502E54C79927}"
    GetNativeVideoSize(lpWidth, lpHeight, lpARWidth, lpARHeight)
      => ComCall(3, this.p, Int32.Ptr, lpWidth, Int32.Ptr, lpHeight, Int32.Ptr, lpARWidth, Int32.Ptr, lpARHeight)
    GetMinIdealVideoSize(lpWidth, lpHeight)
      => ComCall(4, this.p, Int32.Ptr, lpWidth, Int32.Ptr, lpHeight)
    GetMaxIdealVideoSize(lpWidth, lpHeight)
      => ComCall(5, this.p, Int32.Ptr, lpWidth, Int32.Ptr, lpHeight)
    SetVideoPosition(lpSRCRect, lpDSTRect)
      => ComCall(6, this.p, RECT.Ptr, lpSRCRect, RECT.Ptr, lpDSTRect)
    GetVideoPosition(lpSRCRect, lpDSTRect)
      => ComCall(7, this.p, RECT.Ptr, lpSRCRect, RECT.Ptr, lpDSTRect)
    GetAspectRatioMode(lpAspectRatioMode)
      => ComCall(8, this.p, UInt32.Ptr, lpAspectRatioMode)
    SetAspectRatioMode(AspectRatioMode)
      => ComCall(9, this.p, UInt32, AspectRatioMode)
    SetVideoClippingWindow(hwnd1)
      => ComCall(10, this.p, HWND, hwnd1)
    RepaintVideo(hwnd1, hdc1)
      => ComCall(11, this.p, HWND, hwnd1, HDC, hdc1)
    DisplayModeChanged()
      => ComCall(12, this.p)
    GetCurrentImage(lpDib)
      => ComCall(13, this.p, UInt8.Ptr.Ptr, lpDib)
    SetBorderColor(Clr)
      => ComCall(14, this.p, COLORREF, Clr)
    GetBorderColor(lpClr)
      => ComCall(15, this.p, COLORREF.Ptr, lpClr)
}
struct VMR9MixerPrefs extends Int32 {
    static MixerPref9_NoDecimation := 1
    static MixerPref9_DecimateOutput := 2
    static MixerPref9_ARAdjustXorY := 4
    static MixerPref9_NonSquareMixing := 8
    static MixerPref9_DecimateMask := 15
    static MixerPref9_BiLinearFiltering := 16
    static MixerPref9_PointFiltering := 32
    static MixerPref9_AnisotropicFiltering := 64
    static MixerPref9_PyramidalQuadFiltering := 128
    static MixerPref9_GaussianQuadFiltering := 256
    static MixerPref9_FilteringReserved := 3584
    static MixerPref9_FilteringMask := 4080
    static MixerPref9_RenderTargetRGB := 4096
    static MixerPref9_RenderTargetYUV := 8192
    static MixerPref9_RenderTargetReserved := 1032192
    static MixerPref9_RenderTargetMask := 1044480
    static MixerPref9_DynamicSwitchToBOB := 1048576
    static MixerPref9_DynamicDecimateBy2 := 2097152
    static MixerPref9_DynamicReserved := 12582912
    static MixerPref9_DynamicMask := 15728640
}
struct VMR9NormalizedRect {
    left : Float32
    top : Float32
    right : Float32
    bottom : Float32
}
struct VMR9ProcAmpControlFlags extends Int32 {
    static ProcAmpControl9_Brightness := 1
    static ProcAmpControl9_Contrast := 2
    static ProcAmpControl9_Hue := 4
    static ProcAmpControl9_Saturation := 8
    static ProcAmpControl9_Mask := 15
}
struct VMR9ProcAmpControl {
    dwSize : UInt32
    dwFlags : UInt32
    Brightness : Float32
    Contrast : Float32
    Hue : Float32
    Saturation : Float32
}
struct VMR9ProcAmpControlRange {
    dwSize : UInt32
    dwProperty : VMR9ProcAmpControlFlags
    MinValue : Float32
    MaxValue : Float32
    DefaultValue : Float32
    StepSize : Float32
}
struct IVMRMixerControl9 extends IUnknown {
    static IID := "{1A777EAA-47C8-4930-B2C9-8FEE1C1B0F3B}"
    SetAlpha(dwStreamID, Alpha)
      => ComCall(3, this.p, UInt32, dwStreamID, Float32, Alpha)
    GetAlpha(dwStreamID, pAlpha)
      => ComCall(4, this.p, UInt32, dwStreamID, Float32.Ptr, pAlpha)
    SetZOrder(dwStreamID, dwZ)
      => ComCall(5, this.p, UInt32, dwStreamID, UInt32, dwZ)
    GetZOrder(dwStreamID, pZ)
      => ComCall(6, this.p, UInt32, dwStreamID, UInt32.Ptr, pZ)
    SetOutputRect(dwStreamID, pRect)
      => ComCall(7, this.p, UInt32, dwStreamID, VMR9NormalizedRect.Ptr, pRect)
    GetOutputRect(dwStreamID, pRect)
      => ComCall(8, this.p, UInt32, dwStreamID, VMR9NormalizedRect.Ptr, pRect)
    SetBackgroundClr(ClrBkg)
      => ComCall(9, this.p, COLORREF, ClrBkg)
    GetBackgroundClr(lpClrBkg)
      => ComCall(10, this.p, COLORREF.Ptr, lpClrBkg)
    SetMixingPrefs(dwMixerPrefs)
      => ComCall(11, this.p, UInt32, dwMixerPrefs)
    GetMixingPrefs(pdwMixerPrefs)
      => ComCall(12, this.p, UInt32.Ptr, pdwMixerPrefs)
    SetProcAmpControl(dwStreamID, lpClrControl)
      => ComCall(13, this.p, UInt32, dwStreamID, VMR9ProcAmpControl.Ptr, lpClrControl)
    GetProcAmpControl(dwStreamID, lpClrControl)
      => ComCall(14, this.p, UInt32, dwStreamID, VMR9ProcAmpControl.Ptr, lpClrControl)
    GetProcAmpControlRange(dwStreamID, lpClrControl)
      => ComCall(15, this.p, UInt32, dwStreamID, VMR9ProcAmpControlRange.Ptr, lpClrControl)
}
struct VMR9AlphaBitmap {
    dwFlags : UInt32
    hdc : HDC
    pDDS : IDirect3DSurface9
    rSrc : RECT
    rDest : VMR9NormalizedRect
    fAlpha : Float32
    clrSrcKey : COLORREF
    dwFilterMode : UInt32
}
struct VMR9AlphaBitmapFlags extends Int32 {
    static VMR9AlphaBitmap_Disable := 1
    static VMR9AlphaBitmap_hDC := 2
    static VMR9AlphaBitmap_EntireDDS := 4
    static VMR9AlphaBitmap_SrcColorKey := 8
    static VMR9AlphaBitmap_SrcRect := 16
    static VMR9AlphaBitmap_FilterMode := 32
}
struct IVMRMixerBitmap9 extends IUnknown {
    static IID := "{CED175E5-1935-4820-81BD-FF6AD00C9108}"
    SetAlphaBitmap(pBmpParms)
      => ComCall(3, this.p, VMR9AlphaBitmap.Ptr, pBmpParms)
    UpdateAlphaBitmapParameters(pBmpParms)
      => ComCall(4, this.p, VMR9AlphaBitmap.Ptr, pBmpParms)
    GetAlphaBitmapParameters(pBmpParms)
      => ComCall(5, this.p, VMR9AlphaBitmap.Ptr, pBmpParms)
}
struct IVMRSurface9 extends IUnknown {
    static IID := "{DFC581A1-6E1F-4C3A-8D0A-5E9792EA2AFC}"
    IsSurfaceLocked()
      => ComCall(3, this.p)
    LockSurface(lpSurface)
      => ComCall(4, this.p, UInt8.Ptr.Ptr, lpSurface)
    UnlockSurface()
      => ComCall(5, this.p)
    GetSurface(lplpSurface)
      => ComCall(6, this.p, IDirect3DSurface9.Ptr, lplpSurface)
}
struct VMR9RenderPrefs extends Int32 {
    static RenderPrefs9_DoNotRenderBorder := 1
    static RenderPrefs9_Mask := 1
}
struct IVMRImagePresenterConfig9 extends IUnknown {
    static IID := "{45C15CAB-6E22-420A-8043-AE1F0AC02C7D}"
    SetRenderingPrefs(dwRenderFlags)
      => ComCall(3, this.p, UInt32, dwRenderFlags)
    GetRenderingPrefs(dwRenderFlags)
      => ComCall(4, this.p, UInt32.Ptr, dwRenderFlags)
}
struct IVMRVideoStreamControl9 extends IUnknown {
    static IID := "{D0CFE38B-93E7-4772-8957-0400C49A4485}"
    SetStreamActiveState(fActive)
      => ComCall(3, this.p, BOOL, fActive)
    GetStreamActiveState(lpfActive)
      => ComCall(4, this.p, BOOL.Ptr, lpfActive)
}
struct VMR9Mode extends Int32 {
    static VMR9Mode_Windowed := 1
    static VMR9Mode_Windowless := 2
    static VMR9Mode_Renderless := 4
    static VMR9Mode_Mask := 7
}
struct IVMRFilterConfig9 extends IUnknown {
    static IID := "{5A804648-4F66-4867-9C43-4F5C822CF1B8}"
    SetImageCompositor(lpVMRImgCompositor)
      => ComCall(3, this.p, IVMRImageCompositor9, lpVMRImgCompositor)
    SetNumberOfStreams(dwMaxStreams)
      => ComCall(4, this.p, UInt32, dwMaxStreams)
    GetNumberOfStreams(pdwMaxStreams)
      => ComCall(5, this.p, UInt32.Ptr, pdwMaxStreams)
    SetRenderingPrefs(dwRenderFlags)
      => ComCall(6, this.p, UInt32, dwRenderFlags)
    GetRenderingPrefs(pdwRenderFlags)
      => ComCall(7, this.p, UInt32.Ptr, pdwRenderFlags)
    SetRenderingMode(Mode)
      => ComCall(8, this.p, UInt32, Mode)
    GetRenderingMode(pMode)
      => ComCall(9, this.p, UInt32.Ptr, pMode)
}
struct IVMRAspectRatioControl9 extends IUnknown {
    static IID := "{00D96C29-BBDE-4EFC-9901-BB5036392146}"
    GetAspectRatioMode(lpdwARMode)
      => ComCall(3, this.p, UInt32.Ptr, lpdwARMode)
    SetAspectRatioMode(dwARMode)
      => ComCall(4, this.p, UInt32, dwARMode)
}
struct VMR9MonitorInfo {
    uDevID : UInt32
    rcMonitor : RECT
    hMon : HMONITOR
    dwFlags : UInt32
    szDevice : UInt16[32]
    szDescription : UInt16[512]
    liDriverVersion : Int64
    dwVendorId : UInt32
    dwDeviceId : UInt32
    dwSubSysId : UInt32
    dwRevision : UInt32
}
struct IVMRMonitorConfig9 extends IUnknown {
    static IID := "{46C2E457-8BA0-4EEF-B80B-0680F0978749}"
    SetMonitor(uDev)
      => ComCall(3, this.p, UInt32, uDev)
    GetMonitor(puDev)
      => ComCall(4, this.p, UInt32.Ptr, puDev)
    SetDefaultMonitor(uDev)
      => ComCall(5, this.p, UInt32, uDev)
    GetDefaultMonitor(puDev)
      => ComCall(6, this.p, UInt32.Ptr, puDev)
    GetAvailableMonitors(pInfo, pdwNumDevices)
      => ComCall(7, this.p, VMR9MonitorInfo.Ptr, pInfo, UInt32, pInfo.Length, UInt32.Ptr, pdwNumDevices)
}
struct VMR9DeinterlacePrefs extends Int32 {
    static DeinterlacePref9_NextBest := 1
    static DeinterlacePref9_BOB := 2
    static DeinterlacePref9_Weave := 4
    static DeinterlacePref9_Mask := 7
}
struct VMR9DeinterlaceTech extends Int32 {
    static DeinterlaceTech9_Unknown := 0
    static DeinterlaceTech9_BOBLineReplicate := 1
    static DeinterlaceTech9_BOBVerticalStretch := 2
    static DeinterlaceTech9_MedianFiltering := 4
    static DeinterlaceTech9_EdgeFiltering := 16
    static DeinterlaceTech9_FieldAdaptive := 32
    static DeinterlaceTech9_PixelAdaptive := 64
    static DeinterlaceTech9_MotionVectorSteered := 128
}
struct VMR9Frequency {
    dwNumerator : UInt32
    dwDenominator : UInt32
}
struct VMR9_SampleFormat extends Int32 {
    static VMR9_SampleReserved := 1
    static VMR9_SampleProgressiveFrame := 2
    static VMR9_SampleFieldInterleavedEvenFirst := 3
    static VMR9_SampleFieldInterleavedOddFirst := 4
    static VMR9_SampleFieldSingleEven := 5
    static VMR9_SampleFieldSingleOdd := 6
}
struct VMR9VideoDesc {
    dwSize : UInt32
    dwSampleWidth : UInt32
    dwSampleHeight : UInt32
    SampleFormat : VMR9_SampleFormat
    dwFourCC : UInt32
    InputSampleFreq : VMR9Frequency
    OutputFrameFreq : VMR9Frequency
}
struct VMR9DeinterlaceCaps {
    dwSize : UInt32
    dwNumPreviousOutputFrames : UInt32
    dwNumForwardRefSamples : UInt32
    dwNumBackwardRefSamples : UInt32
    DeinterlaceTechnology : VMR9DeinterlaceTech
}
struct IVMRDeinterlaceControl9 extends IUnknown {
    static IID := "{A215FB8D-13C2-4F7F-993C-003D6271A459}"
    GetNumberOfDeinterlaceModes(lpVideoDescription, lpdwNumDeinterlaceModes, lpDeinterlaceModes)
      => ComCall(3, this.p, VMR9VideoDesc.Ptr, lpVideoDescription, UInt32.Ptr, lpdwNumDeinterlaceModes, GUID.Ptr, lpDeinterlaceModes)
    GetDeinterlaceModeCaps(lpDeinterlaceMode, lpVideoDescription, lpDeinterlaceCaps)
      => ComCall(4, this.p, GUID.Ptr, lpDeinterlaceMode, VMR9VideoDesc.Ptr, lpVideoDescription, VMR9DeinterlaceCaps.Ptr, lpDeinterlaceCaps)
    GetDeinterlaceMode(dwStreamID, lpDeinterlaceMode)
      => ComCall(5, this.p, UInt32, dwStreamID, GUID.Ptr, lpDeinterlaceMode)
    SetDeinterlaceMode(dwStreamID, lpDeinterlaceMode)
      => ComCall(6, this.p, UInt32, dwStreamID, GUID.Ptr, lpDeinterlaceMode)
    GetDeinterlacePrefs(lpdwDeinterlacePrefs)
      => ComCall(7, this.p, UInt32.Ptr, lpdwDeinterlacePrefs)
    SetDeinterlacePrefs(dwDeinterlacePrefs)
      => ComCall(8, this.p, UInt32, dwDeinterlacePrefs)
    GetActualDeinterlaceMode(dwStreamID, lpDeinterlaceMode)
      => ComCall(9, this.p, UInt32, dwStreamID, GUID.Ptr, lpDeinterlaceMode)
}
struct VMR9VideoStreamInfo {
    pddsVideoSurface : IDirect3DSurface9
    dwWidth : UInt32
    dwHeight : UInt32
    dwStrmID : UInt32
    fAlpha : Float32
    rNormal : VMR9NormalizedRect
    rtStart : Int64
    rtEnd : Int64
    SampleFormat : VMR9_SampleFormat
}
struct IVMRImageCompositor9 extends IUnknown {
    static IID := "{4A5C89EB-DF51-4654-AC2A-E48E02BBABF6}"
    InitCompositionDevice(pD3DDevice)
      => ComCall(3, this.p, IUnknown, pD3DDevice)
    TermCompositionDevice(pD3DDevice)
      => ComCall(4, this.p, IUnknown, pD3DDevice)
    SetStreamMediaType(dwStrmID, pmt, fTexture)
      => ComCall(5, this.p, UInt32, dwStrmID, AM_MEDIA_TYPE.Ptr, pmt, BOOL, fTexture)
    CompositeImage(pD3DDevice, pddsRenderTarget, pmtRenderTarget, rtStart, rtEnd, dwClrBkGnd, pVideoStreamInfo, cStreams)
      => ComCall(6, this.p, IUnknown, pD3DDevice, IDirect3DSurface9, pddsRenderTarget, AM_MEDIA_TYPE.Ptr, pmtRenderTarget, Int64, rtStart, Int64, rtEnd, UInt32, dwClrBkGnd, VMR9VideoStreamInfo.Ptr, pVideoStreamInfo, UInt32, cStreams)
}
struct IVPBaseConfig extends IUnknown {
    GetConnectInfo(pddVPConnectInfo?)
      => ComCall(3, this.p, UInt32.Ptr, pddVPConnectInfo?.Length ?? 0, DDVIDEOPORTCONNECT.Ptr, pddVPConnectInfo?)
    SetConnectInfo(dwChosenEntry)
      => ComCall(4, this.p, UInt32, dwChosenEntry)
    GetVPDataInfo(pamvpDataInfo)
      => ComCall(5, this.p, AMVPDATAINFO.Ptr, pamvpDataInfo)
    GetMaxPixelRate(pamvpSize, pdwMaxPixelsPerSecond)
      => ComCall(6, this.p, AMVPSIZE.Ptr, pamvpSize, UInt32.Ptr, pdwMaxPixelsPerSecond)
    InformVPInputFormats(dwNumFormats, pDDPixelFormats)
      => ComCall(7, this.p, UInt32, dwNumFormats, DDPIXELFORMAT.Ptr, pDDPixelFormats)
    GetVideoFormats(pddPixelFormats?)
      => ComCall(8, this.p, UInt32.Ptr, pddPixelFormats?.Length ?? 0, DDPIXELFORMAT.Ptr, pddPixelFormats?)
    SetVideoFormat(dwChosenEntry)
      => ComCall(9, this.p, UInt32, dwChosenEntry)
    SetInvertPolarity()
      => ComCall(10, this.p)
    GetOverlaySurface(ppddOverlaySurface)
      => ComCall(11, this.p, IDirectDrawSurface.Ptr, ppddOverlaySurface)
    SetDirectDrawKernelHandle(dwDDKernelHandle)
      => ComCall(12, this.p, IntPtr, dwDDKernelHandle)
    SetVideoPortID(dwVideoPortID)
      => ComCall(13, this.p, UInt32, dwVideoPortID)
    SetDDSurfaceKernelHandles(cHandles, rgDDKernelHandles)
      => ComCall(14, this.p, UInt32, cHandles, IntPtr.Ptr, rgDDKernelHandles)
    SetSurfaceParameters(dwPitch, dwXOrigin, dwYOrigin)
      => ComCall(15, this.p, UInt32, dwPitch, UInt32, dwXOrigin, UInt32, dwYOrigin)
}
struct IVPConfig extends IVPBaseConfig {
    static IID := "{BC29A660-30E3-11D0-9E69-00C04FD7C15B}"
    IsVPDecimationAllowed(pbIsDecimationAllowed)
      => ComCall(16, this.p, BOOL.Ptr, pbIsDecimationAllowed)
    SetScalingFactors(pamvpSize)
      => ComCall(17, this.p, AMVPSIZE.Ptr, pamvpSize)
}
struct IVPVBIConfig extends IVPBaseConfig {
    static IID := "{EC529B00-1A1F-11D1-BAD9-00609744111A}"
}
struct IVPBaseNotify extends IUnknown {
    RenegotiateVPParameters()
      => ComCall(3, this.p)
}
struct IVPNotify extends IVPBaseNotify {
    static IID := "{C76794A1-D6C5-11D0-9E69-00C04FD7C15B}"
    SetDeinterlaceMode(mode)
      => ComCall(4, this.p, AMVP_MODE, mode)
    GetDeinterlaceMode(pMode)
      => ComCall(5, this.p, AMVP_MODE.Ptr, pMode)
}
struct IVPNotify2 extends IVPNotify {
    static IID := "{EBF47183-8764-11D1-9E69-00C04FD7C15B}"
    SetVPSyncMaster(bVPSyncMaster)
      => ComCall(6, this.p, BOOL, bVPSyncMaster)
    GetVPSyncMaster(pbVPSyncMaster)
      => ComCall(7, this.p, BOOL.Ptr, pbVPSyncMaster)
}
struct IVPVBINotify extends IVPBaseNotify {
    static IID := "{EC529B01-1A1F-11D1-BAD9-00609744111A}"
}
struct RIFFCHUNK {
    fcc : UInt32
    cb : UInt32
}
struct RIFFLIST {
    fcc : UInt32
    cb : UInt32
    fccListType : UInt32
}
struct AVIMAINHEADER {
    fcc : UInt32
    cb : UInt32
    dwMicroSecPerFrame : UInt32
    dwMaxBytesPerSec : UInt32
    dwPaddingGranularity : UInt32
    dwFlags : UInt32
    dwTotalFrames : UInt32
    dwInitialFrames : UInt32
    dwStreams : UInt32
    dwSuggestedBufferSize : UInt32
    dwWidth : UInt32
    dwHeight : UInt32
    dwReserved : UInt32[4]
}
struct AVIEXTHEADER {
    fcc : UInt32
    cb : UInt32
    dwGrandFrames : UInt32
    dwFuture : UInt32[61]
}
struct AVISTREAMHEADER_1 {
    fcc : UInt32
    cb : UInt32
    fccType : UInt32
    fccHandler : UInt32
    dwFlags : UInt32
    wPriority : UInt16
    wLanguage : UInt16
    dwInitialFrames : UInt32
    dwScale : UInt32
    dwRate : UInt32
    dwStart : UInt32
    dwLength : UInt32
    dwSuggestedBufferSize : UInt32
    dwQuality : UInt32
    dwSampleSize : UInt32
    rcFrame : this._rcFrame_e__Struct
    struct _rcFrame_e__Struct {
        left : Int16
        top : Int16
        right : Int16
        bottom : Int16
    }
}
struct AVIOLDINDEX {
    fcc : UInt32
    cb : UInt32
    aIndex : this._avioldindex_entry[1]
    struct _avioldindex_entry {
        dwChunkId : UInt32
        dwFlags : UInt32
        dwOffset : UInt32
        dwSize : UInt32
    }
}
struct TIMECODEDATA {
    time : TIMECODE
    dwSMPTEflags : UInt32
    dwUser : UInt32
}
struct AVIMETAINDEX {
    fcc : UInt32
    cb : UInt32
    wLongsPerEntry : UInt16
    bIndexSubType : UInt8
    bIndexType : UInt8
    nEntriesInUse : UInt32
    dwChunkId : UInt32
    dwReserved : UInt32[3]
    adwIndex : UInt32[1]
}
struct AVISUPERINDEX {
    fcc : UInt32
    cb : UInt32
    wLongsPerEntry : UInt16
    bIndexSubType : UInt8
    bIndexType : UInt8
    nEntriesInUse : UInt32
    dwChunkId : UInt32
    dwReserved : UInt32[3]
    aIndex : this._avisuperindex_entry[1022]
    struct _avisuperindex_entry {
        qwOffset : Int64
        dwSize : UInt32
        dwDuration : UInt32
    }
}
struct AVISTDINDEX_ENTRY {
    dwOffset : UInt32
    dwSize : UInt32
}
struct AVISTDINDEX {
    fcc : UInt32
    cb : UInt32
    wLongsPerEntry : UInt16
    bIndexSubType : UInt8
    bIndexType : UInt8
    nEntriesInUse : UInt32
    dwChunkId : UInt32
    qwBaseOffset : Int64
    dwReserved_3 : UInt32
    aIndex : AVISTDINDEX_ENTRY[2044]
}
struct AVITIMEDINDEX_ENTRY {
    dwOffset : UInt32
    dwSize : UInt32
    dwDuration : UInt32
}
struct AVITIMEDINDEX {
    fcc : UInt32
    cb : UInt32
    wLongsPerEntry : UInt16
    bIndexSubType : UInt8
    bIndexType : UInt8
    nEntriesInUse : UInt32
    dwChunkId : UInt32
    qwBaseOffset : Int64
    dwReserved_3 : UInt32
    aIndex : AVITIMEDINDEX_ENTRY[1362]
    adwTrailingFill : UInt32[2734]
}
struct AVITIMECODEINDEX {
    fcc : UInt32
    cb : UInt32
    wLongsPerEntry : UInt16
    bIndexSubType : UInt8
    bIndexType : UInt8
    nEntriesInUse : UInt32
    dwChunkId : UInt32
    dwReserved : UInt32[3]
    aIndex : TIMECODEDATA[1022]
}
struct AVITCDLINDEX_ENTRY {
    dwTick : UInt32
    time : TIMECODE
    dwSMPTEflags : UInt32
    dwUser : UInt32
    szReelId : Int8[12]
}
struct AVITCDLINDEX {
    fcc : UInt32
    cb : UInt32
    wLongsPerEntry : UInt16
    bIndexSubType : UInt8
    bIndexType : UInt8
    nEntriesInUse : UInt32
    dwChunkId : UInt32
    dwReserved : UInt32[3]
    aIndex : AVITCDLINDEX_ENTRY[584]
    adwTrailingFill : UInt32[3512]
}
struct AVIFIELDINDEX {
    fcc : UInt32
    cb : UInt32
    wLongsPerEntry : UInt16
    bIndexSubType : UInt8
    bIndexType : UInt8
    nEntriesInUse : UInt32
    dwChunkId : UInt32
    qwBaseOffset : Int64
    dwReserved3 : UInt32
    aIndex : this._avifieldindex_entry[1]
    struct _avifieldindex_entry {
        dwOffset : UInt32
        dwSize : UInt32
        dwOffsetField2 : UInt32
    }
}
struct MainAVIHeader {
    dwMicroSecPerFrame : UInt32
    dwMaxBytesPerSec : UInt32
    dwPaddingGranularity : UInt32
    dwFlags : UInt32
    dwTotalFrames : UInt32
    dwInitialFrames : UInt32
    dwStreams : UInt32
    dwSuggestedBufferSize : UInt32
    dwWidth : UInt32
    dwHeight : UInt32
    dwReserved : UInt32[4]
}
struct AVIStreamHeader_2 {
    fccType : UInt32
    fccHandler : UInt32
    dwFlags : UInt32
    wPriority : UInt16
    wLanguage : UInt16
    dwInitialFrames : UInt32
    dwScale : UInt32
    dwRate : UInt32
    dwStart : UInt32
    dwLength : UInt32
    dwSuggestedBufferSize : UInt32
    dwQuality : UInt32
    dwSampleSize : UInt32
    rcFrame : RECT
}
struct AVIINDEXENTRY {
    ckid : UInt32
    dwFlags : UInt32
    dwChunkOffset : UInt32
    dwChunkLength : UInt32
}
struct AVIPALCHANGE {
    bFirstEntry : UInt8
    bNumEntries : UInt8
    wFlags : UInt16
    peNew : PALETTEENTRY[1]
}
struct AM_PROPERTY_AC3 extends Int32 {
    static AM_PROPERTY_AC3_ERROR_CONCEALMENT := 1
    static AM_PROPERTY_AC3_ALTERNATE_AUDIO := 2
    static AM_PROPERTY_AC3_DOWNMIX := 3
    static AM_PROPERTY_AC3_BIT_STREAM_MODE := 4
    static AM_PROPERTY_AC3_DIALOGUE_LEVEL := 5
    static AM_PROPERTY_AC3_LANGUAGE_CODE := 6
    static AM_PROPERTY_AC3_ROOM_TYPE := 7
}
struct AM_AC3_ERROR_CONCEALMENT {
    fRepeatPreviousBlock : BOOL
    fErrorInCurrentBlock : BOOL
}
struct AM_AC3_ALTERNATE_AUDIO {
    fStereo : BOOL
    DualMode : UInt32
}
struct AM_AC3_DOWNMIX {
    fDownMix : BOOL
    fDolbySurround : BOOL
}
struct AM_AC3_BIT_STREAM_MODE {
    BitStreamMode : Int32
}
struct AM_AC3_DIALOGUE_LEVEL {
    DialogueLevel : UInt32
}
struct AM_AC3_ROOM_TYPE {
    fLargeRoom : BOOL
}
struct AM_PROPERTY_DVDSUBPIC extends Int32 {
    static AM_PROPERTY_DVDSUBPIC_PALETTE := 0
    static AM_PROPERTY_DVDSUBPIC_HLI := 1
    static AM_PROPERTY_DVDSUBPIC_COMPOSIT_ON := 2
}
struct AM_DVD_YUV {
    Reserved : UInt8
    Y : UInt8
    U : UInt8
    V : UInt8
}
struct AM_PROPERTY_SPPAL {
    sppal : AM_DVD_YUV[16]
}
struct AM_COLCON {
    _bitfield1 : UInt8
    _bitfield2 : UInt8
    _bitfield3 : UInt8
    _bitfield4 : UInt8
}
struct AM_PROPERTY_SPHLI {
    HLISS : UInt16
    Reserved : UInt16
    StartPTM : UInt32
    EndPTM : UInt32
    StartX : UInt16
    StartY : UInt16
    StopX : UInt16
    StopY : UInt16
    ColCon : AM_COLCON
}
struct AM_PROPERTY_DVDCOPYPROT extends Int32 {
    static AM_PROPERTY_DVDCOPY_CHLG_KEY := 1
    static AM_PROPERTY_DVDCOPY_DVD_KEY1 := 2
    static AM_PROPERTY_DVDCOPY_DEC_KEY2 := 3
    static AM_PROPERTY_DVDCOPY_TITLE_KEY := 4
    static AM_PROPERTY_COPY_MACROVISION := 5
    static AM_PROPERTY_DVDCOPY_REGION := 6
    static AM_PROPERTY_DVDCOPY_SET_COPY_STATE := 7
    static AM_PROPERTY_COPY_ANALOG_COMPONENT := 8
    static AM_PROPERTY_COPY_DIGITAL_CP := 9
    static AM_PROPERTY_COPY_DVD_SRM := 10
    static AM_PROPERTY_DVDCOPY_SUPPORTS_NEW_KEYCOUNT := 11
    static AM_PROPERTY_DVDCOPY_DISC_KEY := 128
}
struct AM_DIGITAL_CP extends Int32 {
    static AM_DIGITAL_CP_OFF := 0
    static AM_DIGITAL_CP_ON := 1
    static AM_DIGITAL_CP_DVD_COMPLIANT := 2
}
struct AM_DVDCOPY_CHLGKEY {
    ChlgKey : UInt8[10]
    Reserved : UInt8[2]
}
struct AM_DVDCOPY_BUSKEY {
    BusKey : UInt8[5]
    Reserved : UInt8[1]
}
struct AM_DVDCOPY_DISCKEY {
    DiscKey : UInt8[2048]
}
struct AM_DVDCOPY_TITLEKEY {
    KeyFlags : UInt32
    Reserved1 : UInt32[2]
    TitleKey : UInt8[6]
    Reserved2 : UInt8[2]
}
struct AM_COPY_MACROVISION {
    MACROVISIONLevel : UInt32
}
struct AM_DVDCOPY_SET_COPY_STATE {
    DVDCopyState : UInt32
}
struct AM_DVDCOPYSTATE extends Int32 {
    static AM_DVDCOPYSTATE_INITIALIZE := 0
    static AM_DVDCOPYSTATE_INITIALIZE_TITLE := 1
    static AM_DVDCOPYSTATE_AUTHENTICATION_NOT_REQUIRED := 2
    static AM_DVDCOPYSTATE_AUTHENTICATION_REQUIRED := 3
    static AM_DVDCOPYSTATE_DONE := 4
}
struct AM_COPY_MACROVISION_LEVEL extends Int32 {
    static AM_MACROVISION_DISABLED := 0
    static AM_MACROVISION_LEVEL1 := 1
    static AM_MACROVISION_LEVEL2 := 2
    static AM_MACROVISION_LEVEL3 := 3
}
struct AM_MPEG2Level extends Int32 {
    static AM_MPEG2Level_Low := 1
    static AM_MPEG2Level_Main := 2
    static AM_MPEG2Level_High1440 := 3
    static AM_MPEG2Level_High := 4
}
struct AM_MPEG2Profile extends Int32 {
    static AM_MPEG2Profile_Simple := 1
    static AM_MPEG2Profile_Main := 2
    static AM_MPEG2Profile_SNRScalable := 3
    static AM_MPEG2Profile_SpatiallyScalable := 4
    static AM_MPEG2Profile_High := 5
}
struct AM_DvdKaraokeData {
    dwDownmix : UInt32
    dwSpeakerAssignment : UInt32
}
struct AM_PROPERTY_DVDKARAOKE extends Int32 {
    static AM_PROPERTY_DVDKARAOKE_ENABLE := 0
    static AM_PROPERTY_DVDKARAOKE_DATA := 1
}
struct AM_PROPERTY_TS_RATE_CHANGE extends Int32 {
    static AM_RATE_SimpleRateChange := 1
    static AM_RATE_ExactRateChange := 2
    static AM_RATE_MaxFullDataRate := 3
    static AM_RATE_Step := 4
    static AM_RATE_UseRateVersion := 5
    static AM_RATE_QueryFullFrameRate := 6
    static AM_RATE_QueryLastRateSegPTS := 7
    static AM_RATE_CorrectTS := 8
    static AM_RATE_ReverseMaxFullDataRate := 9
    static AM_RATE_ResetOnTimeDisc := 10
    static AM_RATE_QueryMapping := 11
}
struct AM_PROPERTY_DVD_RATE_CHANGE extends Int32 {
    static AM_RATE_ChangeRate := 1
    static AM_RATE_FullDataRateMax := 2
    static AM_RATE_ReverseDecode := 3
    static AM_RATE_DecoderPosition := 4
    static AM_RATE_DecoderVersion := 5
}
struct AM_SimpleRateChange {
    StartTime : Int64
    Rate : Int32
}
struct AM_QueryRate {
    lMaxForwardFullFrame : Int32
    lMaxReverseFullFrame : Int32
}
struct AM_ExactRateChange {
    OutputZeroTime : Int64
    Rate : Int32
}
struct AM_DVD_ChangeRate {
    StartInTime : Int64
    StartOutTime : Int64
    Rate : Int32
}
struct DVD_PLAY_DIRECTION extends Int32 {
    static DVD_DIR_FORWARD := 0
    static DVD_DIR_BACKWARD := 1
}
struct DVD_ERROR extends Int32 {
    static DVD_ERROR_Unexpected := 1
    static DVD_ERROR_CopyProtectFail := 2
    static DVD_ERROR_InvalidDVD1_0Disc := 3
    static DVD_ERROR_InvalidDiscRegion := 4
    static DVD_ERROR_LowParentalLevel := 5
    static DVD_ERROR_MacrovisionFail := 6
    static DVD_ERROR_IncompatibleSystemAndDecoderRegions := 7
    static DVD_ERROR_IncompatibleDiscAndDecoderRegions := 8
    static DVD_ERROR_CopyProtectOutputFail := 9
    static DVD_ERROR_CopyProtectOutputNotSupported := 10
}
struct DVD_WARNING extends Int32 {
    static DVD_WARNING_InvalidDVD1_0Disc := 1
    static DVD_WARNING_FormatNotSupported := 2
    static DVD_WARNING_IllegalNavCommand := 3
    static DVD_WARNING_Open := 4
    static DVD_WARNING_Seek := 5
    static DVD_WARNING_Read := 6
}
struct DVD_PB_STOPPED extends Int32 {
    static DVD_PB_STOPPED_Other := 0
    static DVD_PB_STOPPED_NoBranch := 1
    static DVD_PB_STOPPED_NoFirstPlayDomain := 2
    static DVD_PB_STOPPED_StopCommand := 3
    static DVD_PB_STOPPED_Reset := 4
    static DVD_PB_STOPPED_DiscEjected := 5
    static DVD_PB_STOPPED_IllegalNavCommand := 6
    static DVD_PB_STOPPED_PlayPeriodAutoStop := 7
    static DVD_PB_STOPPED_PlayChapterAutoStop := 8
    static DVD_PB_STOPPED_ParentalFailure := 9
    static DVD_PB_STOPPED_RegionFailure := 10
    static DVD_PB_STOPPED_MacrovisionFailure := 11
    static DVD_PB_STOPPED_DiscReadError := 12
    static DVD_PB_STOPPED_CopyProtectFailure := 13
    static DVD_PB_STOPPED_CopyProtectOutputFailure := 14
    static DVD_PB_STOPPED_CopyProtectOutputNotSupported := 15
}
struct AMGETERRORTEXTPROCA extends FunctionPointer {
    static Types := [HRESULT, PSTR, UInt32, BOOL]
}
struct AMGETERRORTEXTPROCW extends FunctionPointer {
    static Types := [HRESULT, PWSTR, UInt32, BOOL]
}
struct SNDDEV_ERR extends Int32 {
    static SNDDEV_ERROR_Open := 1
    static SNDDEV_ERROR_Close := 2
    static SNDDEV_ERROR_GetCaps := 3
    static SNDDEV_ERROR_PrepareHeader := 4
    static SNDDEV_ERROR_UnprepareHeader := 5
    static SNDDEV_ERROR_Reset := 6
    static SNDDEV_ERROR_Restart := 7
    static SNDDEV_ERROR_GetPosition := 8
    static SNDDEV_ERROR_Write := 9
    static SNDDEV_ERROR_Pause := 10
    static SNDDEV_ERROR_Stop := 11
    static SNDDEV_ERROR_Start := 12
    static SNDDEV_ERROR_AddBuffer := 13
    static SNDDEV_ERROR_Query := 14
}
struct MP_TYPE extends Int32 {
    static MPT_INT := 0
    static MPT_FLOAT := 1
    static MPT_BOOL := 2
    static MPT_ENUM := 3
    static MPT_MAX := 4
}
struct MP_CURVE_TYPE extends Int32 {
    static MP_CURVE_JUMP := 1
    static MP_CURVE_LINEAR := 2
    static MP_CURVE_SQUARE := 4
    static MP_CURVE_INVSQUARE := 8
    static MP_CURVE_SINE := 16
}
struct MP_PARAMINFO {
    mpType : MP_TYPE
    mopCaps : UInt32
    mpdMinValue : Float32
    mpdMaxValue : Float32
    mpdNeutralValue : Float32
    szUnitText : UInt16[32]
    szLabel : UInt16[32]
}
struct MP_ENVELOPE_SEGMENT {
    rtStart : Int64
    rtEnd : Int64
    valStart : Float32
    valEnd : Float32
    iCurve : MP_CURVE_TYPE
    flags : UInt32
}
struct IMediaParamInfo extends IUnknown {
    static IID := "{6D6CBB60-A223-44AA-842F-A2F06750BE6D}"
    GetParamCount(pdwParams)
      => ComCall(3, this.p, UInt32.Ptr, pdwParams)
    GetParamInfo(dwParamIndex, pInfo)
      => ComCall(4, this.p, UInt32, dwParamIndex, MP_PARAMINFO.Ptr, pInfo)
    GetParamText(dwParamIndex, ppwchText)
      => ComCall(5, this.p, UInt32, dwParamIndex, UInt16.Ptr.Ptr, ppwchText)
    GetNumTimeFormats(pdwNumTimeFormats)
      => ComCall(6, this.p, UInt32.Ptr, pdwNumTimeFormats)
    GetSupportedTimeFormat(dwFormatIndex, pguidTimeFormat)
      => ComCall(7, this.p, UInt32, dwFormatIndex, GUID.Ptr, pguidTimeFormat)
    GetCurrentTimeFormat(pguidTimeFormat, pTimeData)
      => ComCall(8, this.p, GUID.Ptr, pguidTimeFormat, UInt32.Ptr, pTimeData)
}
struct IMediaParams extends IUnknown {
    static IID := "{6D6CBB61-A223-44AA-842F-A2F06750BE6E}"
    GetParam(dwParamIndex, pValue)
      => ComCall(3, this.p, UInt32, dwParamIndex, Float32.Ptr, pValue)
    SetParam(dwParamIndex, value)
      => ComCall(4, this.p, UInt32, dwParamIndex, Float32, value)
    AddEnvelope(dwParamIndex, cSegments, pEnvelopeSegments)
      => ComCall(5, this.p, UInt32, dwParamIndex, UInt32, cSegments, MP_ENVELOPE_SEGMENT.Ptr, pEnvelopeSegments)
    FlushEnvelope(dwParamIndex, refTimeStart, refTimeEnd)
      => ComCall(6, this.p, UInt32, dwParamIndex, Int64, refTimeStart, Int64, refTimeEnd)
    SetTimeFormat(guidTimeFormat, mpTimeData)
      => ComCall(7, this.p, GUID, guidTimeFormat, UInt32, mpTimeData)
}
struct VFW_FILTERLIST {
    cFilters : UInt32
    aClsId : GUID[1]
}
struct DXVA2_SampleFlags extends Int32 {
    static DXVA2_SampleFlag_Palette_Changed := 1
    static DXVA2_SampleFlag_SrcRect_Changed := 2
    static DXVA2_SampleFlag_DstRect_Changed := 4
    static DXVA2_SampleFlag_ColorData_Changed := 8
    static DXVA2_SampleFlag_PlanarAlpha_Changed := 16
    static DXVA2_SampleFlag_RFF := 65536
    static DXVA2_SampleFlag_TFF := 131072
    static DXVA2_SampleFlag_RFF_TFF_Present := 262144
    static DXVA2_SampleFlagsMask := -65505
}
struct DXVA2_DestinationFlags extends Int32 {
    static DXVA2_DestinationFlag_Background_Changed := 1
    static DXVA2_DestinationFlag_TargetRect_Changed := 2
    static DXVA2_DestinationFlag_ColorData_Changed := 4
    static DXVA2_DestinationFlag_Alpha_Changed := 8
    static DXVA2_DestinationFlag_RFF := 65536
    static DXVA2_DestinationFlag_TFF := 131072
    static DXVA2_DestinationFlag_RFF_TFF_Present := 262144
    static DXVA2_DestinationFlagMask := -65521
}
struct DXVA2_VIDEOSAMPLE {
    Start : Int64
    End : Int64
    SampleFormat : DXVA2_ExtendedFormat
    SampleFlags : UInt32
    SrcResource : Struct.Ptr
    SrcRect : RECT
    DstRect : RECT
    Pal : DXVA2_AYUVSample8[16]
    PlanarAlpha : DXVA2_Fixed32
}
struct DXVA2_VIDEOPROCESSBLT {
    TargetFrame : Int64
    TargetRect : RECT
    ConstrictionSize : SIZE
    StreamingFlags : UInt32
    BackgroundColor : DXVA2_AYUVSample16
    DestFormat : DXVA2_ExtendedFormat
    DestFlags : UInt32
    ProcAmpValues : DXVA2_ProcAmpValues
    Alpha : DXVA2_Fixed32
    NoiseFilterLuma : DXVA2_FilterValues
    NoiseFilterChroma : DXVA2_FilterValues
    DetailFilterLuma : DXVA2_FilterValues
    DetailFilterChroma : DXVA2_FilterValues
    pSrcSurfaces : DXVA2_VIDEOSAMPLE.Ptr
    NumSrcSurfaces : UInt32
}
struct PDXVA2SW_GETVIDEOPROCESSORRENDERTARGETCOUNT extends FunctionPointer {
    static Types := [DXVA2_VideoDesc.Ptr, UInt32.Ptr, HRESULT]
}
struct PDXVA2SW_GETVIDEOPROCESSORRENDERTARGETS extends FunctionPointer {
    static Types := [DXVA2_VideoDesc.Ptr, UInt32, D3DFORMAT.Ptr, HRESULT]
}
struct PDXVA2SW_GETVIDEOPROCESSORCAPS extends FunctionPointer {
    static Types := [DXVA2_VideoDesc.Ptr, D3DFORMAT, DXVA2_VideoProcessorCaps.Ptr, HRESULT]
}
struct PDXVA2SW_GETVIDEOPROCESSORSUBSTREAMFORMATCOUNT extends FunctionPointer {
    static Types := [DXVA2_VideoDesc.Ptr, D3DFORMAT, UInt32.Ptr, HRESULT]
}
struct PDXVA2SW_GETVIDEOPROCESSORSUBSTREAMFORMATS extends FunctionPointer {
    static Types := [DXVA2_VideoDesc.Ptr, D3DFORMAT, UInt32, D3DFORMAT.Ptr, HRESULT]
}
struct PDXVA2SW_GETPROCAMPRANGE extends FunctionPointer {
    static Types := [DXVA2_VideoDesc.Ptr, D3DFORMAT, UInt32, DXVA2_ValueRange.Ptr, HRESULT]
}
struct PDXVA2SW_GETFILTERPROPERTYRANGE extends FunctionPointer {
    static Types := [DXVA2_VideoDesc.Ptr, D3DFORMAT, UInt32, DXVA2_ValueRange.Ptr, HRESULT]
}
struct PDXVA2SW_CREATEVIDEOPROCESSDEVICE extends FunctionPointer {
    static Types := [IDirect3DDevice9, DXVA2_VideoDesc.Ptr, D3DFORMAT, UInt32, HANDLE.Ptr, HRESULT]
}
struct PDXVA2SW_DESTROYVIDEOPROCESSDEVICE extends FunctionPointer {
    static Types := [HANDLE, HRESULT]
}
struct PDXVA2SW_VIDEOPROCESSBEGINFRAME extends FunctionPointer {
    static Types := [HANDLE, HRESULT]
}
struct PDXVA2SW_VIDEOPROCESSENDFRAME extends FunctionPointer {
    static Types := [HANDLE, HANDLE.Ptr, HRESULT]
}
struct PDXVA2SW_VIDEOPROCESSSETRENDERTARGET extends FunctionPointer {
    static Types := [HANDLE, IDirect3DSurface9, HRESULT]
}
struct PDXVA2SW_VIDEOPROCESSBLT extends FunctionPointer {
    static Types := [HANDLE, DXVA2_VIDEOPROCESSBLT.Ptr, HRESULT]
}
struct DXVA2SW_CALLBACKS {
    Size : UInt32
    GetVideoProcessorRenderTargetCount : PDXVA2SW_GETVIDEOPROCESSORRENDERTARGETCOUNT
    GetVideoProcessorRenderTargets : PDXVA2SW_GETVIDEOPROCESSORRENDERTARGETS
    GetVideoProcessorCaps : PDXVA2SW_GETVIDEOPROCESSORCAPS
    GetVideoProcessorSubStreamFormatCount : PDXVA2SW_GETVIDEOPROCESSORSUBSTREAMFORMATCOUNT
    GetVideoProcessorSubStreamFormats : PDXVA2SW_GETVIDEOPROCESSORSUBSTREAMFORMATS
    GetProcAmpRange : PDXVA2SW_GETPROCAMPRANGE
    GetFilterPropertyRange : PDXVA2SW_GETFILTERPROPERTYRANGE
    CreateVideoProcessDevice : PDXVA2SW_CREATEVIDEOPROCESSDEVICE
    DestroyVideoProcessDevice : PDXVA2SW_DESTROYVIDEOPROCESSDEVICE
    VideoProcessBeginFrame : PDXVA2SW_VIDEOPROCESSBEGINFRAME
    VideoProcessEndFrame : PDXVA2SW_VIDEOPROCESSENDFRAME
    VideoProcessSetRenderTarget : PDXVA2SW_VIDEOPROCESSSETRENDERTARGET
    VideoProcessBlt : PDXVA2SW_VIDEOPROCESSBLT
}
struct DXVA2Trace_DecodeDevCreatedData {
    wmiHeader : EVENT_TRACE_HEADER
    pObject : Int64
    pD3DDevice : Int64
    DeviceGuid : GUID
    Width : UInt32
    Height : UInt32
    Enter : BOOL
}
struct DXVA2Trace_DecodeDeviceData {
    wmiHeader : EVENT_TRACE_HEADER
    pObject : Int64
    Enter : BOOL
}
struct DXVA2Trace_DecodeDevBeginFrameData {
    wmiHeader : EVENT_TRACE_HEADER
    pObject : Int64
    pRenderTarget : Int64
    Enter : BOOL
}
struct DXVA2Trace_DecodeDevGetBufferData {
    wmiHeader : EVENT_TRACE_HEADER
    pObject : Int64
    BufferType : UInt32
    Enter : BOOL
}
struct DXVA2Trace_VideoProcessDevCreatedData {
    wmiHeader : EVENT_TRACE_HEADER
    pObject : Int64
    pD3DDevice : Int64
    DeviceGuid : GUID
    RTFourCC : UInt32
    Width : UInt32
    Height : UInt32
    Enter : BOOL
}
struct DXVA2Trace_VideoProcessDeviceData {
    wmiHeader : EVENT_TRACE_HEADER
    pObject : Int64
    Enter : BOOL
}
struct DXVA2TraceVideoProcessBltData {
    wmiHeader : EVENT_TRACE_HEADER
    pObject : Int64
    pRenderTarget : Int64
    TargetFrameTime : Int64
    TargetRect : RECT
    Enter : BOOL
}
struct AMPlayListItemFlags extends Int32 {
    static AMPLAYLISTITEM_CANSKIP := 1
    static AMPLAYLISTITEM_CANBIND := 2
}
struct IAMPlayListItem extends IUnknown {
    static IID := "{56A868FF-0AD4-11CE-B03A-0020AF0BA770}"
    GetFlags(pdwFlags)
      => ComCall(3, this.p, UInt32.Ptr, pdwFlags)
    GetSourceCount(pdwSources)
      => ComCall(4, this.p, UInt32.Ptr, pdwSources)
    GetSourceURL(dwSourceIndex, pbstrURL)
      => ComCall(5, this.p, UInt32, dwSourceIndex, BSTR.Ptr, pbstrURL)
    GetSourceStart(dwSourceIndex, prtStart)
      => ComCall(6, this.p, UInt32, dwSourceIndex, Int64.Ptr, prtStart)
    GetSourceDuration(dwSourceIndex, prtDuration)
      => ComCall(7, this.p, UInt32, dwSourceIndex, Int64.Ptr, prtDuration)
    GetSourceStartMarker(dwSourceIndex, pdwMarker)
      => ComCall(8, this.p, UInt32, dwSourceIndex, UInt32.Ptr, pdwMarker)
    GetSourceEndMarker(dwSourceIndex, pdwMarker)
      => ComCall(9, this.p, UInt32, dwSourceIndex, UInt32.Ptr, pdwMarker)
    GetSourceStartMarkerName(dwSourceIndex, pbstrStartMarker)
      => ComCall(10, this.p, UInt32, dwSourceIndex, BSTR.Ptr, pbstrStartMarker)
    GetSourceEndMarkerName(dwSourceIndex, pbstrEndMarker)
      => ComCall(11, this.p, UInt32, dwSourceIndex, BSTR.Ptr, pbstrEndMarker)
    GetLinkURL(pbstrURL)
      => ComCall(12, this.p, BSTR.Ptr, pbstrURL)
    GetScanDuration(dwSourceIndex, prtScanDuration)
      => ComCall(13, this.p, UInt32, dwSourceIndex, Int64.Ptr, prtScanDuration)
}
struct AMPlayListFlags extends Int32 {
    static AMPLAYLIST_STARTINSCANMODE := 1
    static AMPLAYLIST_FORCEBANNER := 2
}
struct AMPlayListEventFlags extends Int32 {
    static AMPLAYLISTEVENT_RESUME := 0
    static AMPLAYLISTEVENT_BREAK := 1
    static AMPLAYLISTEVENT_NEXT := 2
    static AMPLAYLISTEVENT_MASK := 15
    static AMPLAYLISTEVENT_REFRESH := 16
}
struct IAMPlayList extends IUnknown {
    static IID := "{56A868FE-0AD4-11CE-B03A-0020AF0BA770}"
    GetFlags(pdwFlags)
      => ComCall(3, this.p, UInt32.Ptr, pdwFlags)
    GetItemCount(pdwItems)
      => ComCall(4, this.p, UInt32.Ptr, pdwItems)
    GetItem(dwItemIndex, ppItem)
      => ComCall(5, this.p, UInt32, dwItemIndex, IAMPlayListItem.Ptr, ppItem)
    GetNamedEvent(pwszEventName, dwItemIndex, ppItem, pdwFlags)
      => ComCall(6, this.p, "Str", pwszEventName, UInt32, dwItemIndex, IAMPlayListItem.Ptr, ppItem, UInt32.Ptr, pdwFlags)
    GetRepeatInfo(pdwRepeatCount, pdwRepeatStart, pdwRepeatEnd)
      => ComCall(7, this.p, UInt32.Ptr, pdwRepeatCount, UInt32.Ptr, pdwRepeatStart, UInt32.Ptr, pdwRepeatEnd)
}
struct ISpecifyParticularPages extends IUnknown {
    static IID := "{4C437B91-6E9E-11D1-A704-006097C4E476}"
    GetPages(guidWhatPages, pPages)
      => ComCall(3, this.p, GUID.Ptr, guidWhatPages, CAUUID.Ptr, pPages)
}
struct IAMRebuild extends IUnknown {
    static IID := "{02EF04DD-7580-11D1-BECE-00C04FB6E937}"
    RebuildNow()
      => ComCall(3, this.p)
}
struct IBufferingTime extends IUnknown {
    static IID := "{1E00486A-78DD-11D2-8DD3-006097C9A2B2}"
    GetBufferingTime(pdwMilliseconds)
      => ComCall(3, this.p, UInt32.Ptr, pdwMilliseconds)
    SetBufferingTime(dwMilliseconds)
      => ComCall(4, this.p, UInt32, dwMilliseconds)
}
struct MPEG1WAVEFORMAT {
    wfx : WAVEFORMATEX
    fwHeadLayer : UInt16
    dwHeadBitrate : UInt32
    fwHeadMode : UInt16
    fwHeadModeExt : UInt16
    wHeadEmphasis : UInt16
    fwHeadFlags : UInt16
    dwPTSLow : UInt32
    dwPTSHigh : UInt32
}
struct MPEGLAYER3WAVEFORMAT {
    wfx : WAVEFORMATEX
    wID : UInt16
    fdwFlags : MPEGLAYER3WAVEFORMAT_FLAGS
    nBlockSize : UInt16
    nFramesPerBlock : UInt16
    nCodecDelay : UInt16
}
struct HEAACWAVEINFO {
    wfx : WAVEFORMATEX
    wPayloadType : UInt16
    wAudioProfileLevelIndication : UInt16
    wStructType : UInt16
    wReserved1 : UInt16
    dwReserved2 : UInt32
}
struct HEAACWAVEFORMAT {
    wfInfo : HEAACWAVEINFO
    pbAudioSpecificConfig : UInt8[1]
}
struct IWMCodecAMVideoAccelerator extends IUnknown {
    static IID := "{D98EE251-34E0-4A2D-9312-9B4C788D9FA1}"
    SetAcceleratorInterface(pIAMVA)
      => ComCall(3, this.p, IAMVideoAccelerator, pIAMVA)
    NegotiateConnection(pMediaType)
      => ComCall(4, this.p, AM_MEDIA_TYPE.Ptr, pMediaType)
    SetPlayerNotify(pHook)
      => ComCall(5, this.p, IWMPlayerTimestampHook, pHook)
}
struct IWMCodecVideoAccelerator extends IUnknown {
    static IID := "{990641B0-739F-4E94-A808-9888DA8F75AF}"
    NegotiateConnection(pIAMVA, pMediaType)
      => ComCall(3, this.p, IAMVideoAccelerator, pIAMVA, AM_MEDIA_TYPE.Ptr, pMediaType)
    SetPlayerNotify(pHook)
      => ComCall(4, this.p, IWMPlayerTimestampHook, pHook)
}
struct VIDEOENCODER_BITRATE_MODE extends Int32 {
    static ConstantBitRate := 0
    static VariableBitRateAverage := 1
    static VariableBitRatePeak := 2
}
struct DXVA_COPPSetProtectionLevelCmdData {
    ProtType : UInt32
    ProtLevel : UInt32
    ExtendedInfoChangeMask : UInt32
    ExtendedInfoData : UInt32
}
struct COPP_HDCP_Protection_Level extends Int32 {
    static COPP_HDCP_Level0 := 0
    static COPP_HDCP_LevelMin := 0
    static COPP_HDCP_Level1 := 1
    static COPP_HDCP_LevelMax := 1
    static COPP_HDCP_ForceDWORD := 2147483647
}
struct COPP_CGMSA_Protection_Level extends Int32 {
    static COPP_CGMSA_Disabled := 0
    static COPP_CGMSA_LevelMin := 0
    static COPP_CGMSA_CopyFreely := 1
    static COPP_CGMSA_CopyNoMore := 2
    static COPP_CGMSA_CopyOneGeneration := 3
    static COPP_CGMSA_CopyNever := 4
    static COPP_CGMSA_RedistributionControlRequired := 8
    static COPP_CGMSA_LevelMax := 12
    static COPP_CGMSA_ForceDWORD := 2147483647
}
struct COPP_ACP_Protection_Level extends Int32 {
    static COPP_ACP_Level0 := 0
    static COPP_ACP_LevelMin := 0
    static COPP_ACP_Level1 := 1
    static COPP_ACP_Level2 := 2
    static COPP_ACP_Level3 := 3
    static COPP_ACP_LevelMax := 3
    static COPP_ACP_ForceDWORD := 2147483647
}
struct DXVA_COPPSetSignalingCmdData {
    ActiveTVProtectionStandard : UInt32
    AspectRatioChangeMask1 : UInt32
    AspectRatioData1 : UInt32
    AspectRatioChangeMask2 : UInt32
    AspectRatioData2 : UInt32
    AspectRatioChangeMask3 : UInt32
    AspectRatioData3 : UInt32
    ExtendedInfoChangeMask : UInt32[4]
    ExtendedInfoData : UInt32[4]
    Reserved : UInt32
}
struct COPP_TVProtectionStandard extends Int32 {
    static COPP_ProtectionStandard_Unknown := -2147483648
    static COPP_ProtectionStandard_None := 0
    static COPP_ProtectionStandard_IEC61880_525i := 1
    static COPP_ProtectionStandard_IEC61880_2_525i := 2
    static COPP_ProtectionStandard_IEC62375_625p := 4
    static COPP_ProtectionStandard_EIA608B_525 := 8
    static COPP_ProtectionStandard_EN300294_625i := 16
    static COPP_ProtectionStandard_CEA805A_TypeA_525p := 32
    static COPP_ProtectionStandard_CEA805A_TypeA_750p := 64
    static COPP_ProtectionStandard_CEA805A_TypeA_1125i := 128
    static COPP_ProtectionStandard_CEA805A_TypeB_525p := 256
    static COPP_ProtectionStandard_CEA805A_TypeB_750p := 512
    static COPP_ProtectionStandard_CEA805A_TypeB_1125i := 1024
    static COPP_ProtectionStandard_ARIBTRB15_525i := 2048
    static COPP_ProtectionStandard_ARIBTRB15_525p := 4096
    static COPP_ProtectionStandard_ARIBTRB15_750p := 8192
    static COPP_ProtectionStandard_ARIBTRB15_1125i := 16384
    static COPP_ProtectionStandard_Mask := -2147450881
    static COPP_ProtectionStandard_Reserved := 2147450880
}
struct COPP_ImageAspectRatio_EN300294 extends Int32 {
    static COPP_AspectRatio_EN300294_FullFormat4by3 := 0
    static COPP_AspectRatio_EN300294_Box14by9Center := 1
    static COPP_AspectRatio_EN300294_Box14by9Top := 2
    static COPP_AspectRatio_EN300294_Box16by9Center := 3
    static COPP_AspectRatio_EN300294_Box16by9Top := 4
    static COPP_AspectRatio_EN300294_BoxGT16by9Center := 5
    static COPP_AspectRatio_EN300294_FullFormat4by3ProtectedCenter := 6
    static COPP_AspectRatio_EN300294_FullFormat16by9Anamorphic := 7
    static COPP_AspectRatio_ForceDWORD := 2147483647
}
struct COPP_StatusFlags extends Int32 {
    static COPP_StatusNormal := 0
    static COPP_LinkLost := 1
    static COPP_RenegotiationRequired := 2
    static COPP_StatusFlagsReserved := -4
}
struct DXVA_COPPStatusData {
    rApp : GUID
    dwFlags : UInt32
    dwData : UInt32
    ExtendedInfoValidMask : UInt32
    ExtendedInfoData : UInt32
}
struct DXVA_COPPStatusDisplayData {
    rApp : GUID
    dwFlags : UInt32
    DisplayWidth : UInt32
    DisplayHeight : UInt32
    Format : UInt32
    d3dFormat : UInt32
    FreqNumerator : UInt32
    FreqDenominator : UInt32
}
struct COPP_StatusHDCPFlags extends Int32 {
    static COPP_HDCPRepeater := 1
    static COPP_HDCPFlagsReserved := -2
}
struct DXVA_COPPStatusHDCPKeyData {
    rApp : GUID
    dwFlags : UInt32
    dwHDCPFlags : UInt32
    BKey : GUID
    Reserved1 : GUID
    Reserved2 : GUID
}
struct COPP_ConnectorType extends Int32 {
    static COPP_ConnectorType_Unknown := -1
    static COPP_ConnectorType_VGA := 0
    static COPP_ConnectorType_SVideo := 1
    static COPP_ConnectorType_CompositeVideo := 2
    static COPP_ConnectorType_ComponentVideo := 3
    static COPP_ConnectorType_DVI := 4
    static COPP_ConnectorType_HDMI := 5
    static COPP_ConnectorType_LVDS := 6
    static COPP_ConnectorType_TMDS := 7
    static COPP_ConnectorType_D_JPN := 8
    static COPP_ConnectorType_Internal := -2147483648
    static COPP_ConnectorType_ForceDWORD := 2147483647
}
struct COPP_BusType extends Int32 {
    static COPP_BusType_Unknown := 0
    static COPP_BusType_PCI := 1
    static COPP_BusType_PCIX := 2
    static COPP_BusType_PCIExpress := 3
    static COPP_BusType_AGP := 4
    static COPP_BusType_Integrated := -2147483648
    static COPP_BusType_ForceDWORD := 2147483647
}
struct DXVA_COPPStatusSignalingCmdData {
    rApp : GUID
    dwFlags : UInt32
    AvailableTVProtectionStandards : UInt32
    ActiveTVProtectionStandard : UInt32
    TVType : UInt32
    AspectRatioValidMask1 : UInt32
    AspectRatioData1 : UInt32
    AspectRatioValidMask2 : UInt32
    AspectRatioData2 : UInt32
    AspectRatioValidMask3 : UInt32
    AspectRatioData3 : UInt32
    ExtendedInfoValidMask : UInt32[4]
    ExtendedInfoData : UInt32[4]
}
