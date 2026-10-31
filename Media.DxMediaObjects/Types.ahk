#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct DMO_MEDIA_TYPE {
    majortype : GUID
    subtype : GUID
    bFixedSizeSamples : BOOL
    bTemporalCompression : BOOL
    lSampleSize : UInt32
    formattype : GUID
    pUnk : IUnknown
    cbFormat : UInt32
    pbFormat : UInt8.Ptr
}
struct DMO_INPUT_DATA_BUFFER_FLAGS extends Int32 {
    static DMO_INPUT_DATA_BUFFERF_SYNCPOINT := 1
    static DMO_INPUT_DATA_BUFFERF_TIME := 2
    static DMO_INPUT_DATA_BUFFERF_TIMELENGTH := 4
    static DMO_INPUT_DATA_BUFFERF_DISCONTINUITY := 8
}
struct DMO_OUTPUT_DATA_BUFFER_FLAGS extends Int32 {
    static DMO_OUTPUT_DATA_BUFFERF_SYNCPOINT := 1
    static DMO_OUTPUT_DATA_BUFFERF_TIME := 2
    static DMO_OUTPUT_DATA_BUFFERF_TIMELENGTH := 4
    static DMO_OUTPUT_DATA_BUFFERF_DISCONTINUITY := 8
    static DMO_OUTPUT_DATA_BUFFERF_INCOMPLETE := 16777216
}
struct DMO_INPUT_STATUS_FLAGS extends Int32 {
    static DMO_INPUT_STATUSF_ACCEPT_DATA := 1
}
struct DMO_INPUT_STREAM_INFO_FLAGS extends Int32 {
    static DMO_INPUT_STREAMF_WHOLE_SAMPLES := 1
    static DMO_INPUT_STREAMF_SINGLE_SAMPLE_PER_BUFFER := 2
    static DMO_INPUT_STREAMF_FIXED_SAMPLE_SIZE := 4
    static DMO_INPUT_STREAMF_HOLDS_BUFFERS := 8
}
struct DMO_OUTPUT_STREAM_INFO_FLAGS extends Int32 {
    static DMO_OUTPUT_STREAMF_WHOLE_SAMPLES := 1
    static DMO_OUTPUT_STREAMF_SINGLE_SAMPLE_PER_BUFFER := 2
    static DMO_OUTPUT_STREAMF_FIXED_SAMPLE_SIZE := 4
    static DMO_OUTPUT_STREAMF_DISCARDABLE := 8
    static DMO_OUTPUT_STREAMF_OPTIONAL := 16
}
struct DMO_SET_TYPE_FLAGS extends Int32 {
    static DMO_SET_TYPEF_TEST_ONLY := 1
    static DMO_SET_TYPEF_CLEAR := 2
}
struct DMO_PROCESS_OUTPUT_FLAGS extends Int32 {
    static DMO_PROCESS_OUTPUT_DISCARD_WHEN_NO_BUFFER := 1
}
struct IMediaBuffer extends IUnknown {
    static IID := "{59EFF8B9-938C-4A26-82F2-95CB84CDC837}"
    SetLength(cbLength)
      => ComCall(3, this.p, UInt32, cbLength)
    GetMaxLength(pcbMaxLength)
      => ComCall(4, this.p, UInt32.Ptr, pcbMaxLength)
    GetBufferAndLength(ppBuffer?, pcbLength?)
      => ComCall(5, this.p, UInt8.Ptr.Ptr, ppBuffer?, UInt32.Ptr, pcbLength?)
}
struct DMO_OUTPUT_DATA_BUFFER {
    pBuffer : IMediaBuffer
    dwStatus : UInt32
    rtTimestamp : Int64
    rtTimelength : Int64
}
struct IMediaObject extends IUnknown {
    static IID := "{D8AD0F58-5494-4102-97C5-EC798E59BCF4}"
    GetStreamCount(pcInputStreams, pcOutputStreams)
      => ComCall(3, this.p, UInt32.Ptr, pcInputStreams, UInt32.Ptr, pcOutputStreams)
    GetInputStreamInfo(dwInputStreamIndex, pdwFlags)
      => ComCall(4, this.p, UInt32, dwInputStreamIndex, UInt32.Ptr, pdwFlags)
    GetOutputStreamInfo(dwOutputStreamIndex, pdwFlags)
      => ComCall(5, this.p, UInt32, dwOutputStreamIndex, UInt32.Ptr, pdwFlags)
    GetInputType(dwInputStreamIndex, dwTypeIndex, pmt?)
      => ComCall(6, this.p, UInt32, dwInputStreamIndex, UInt32, dwTypeIndex, DMO_MEDIA_TYPE.Ptr, pmt?)
    GetOutputType(dwOutputStreamIndex, dwTypeIndex, pmt?)
      => ComCall(7, this.p, UInt32, dwOutputStreamIndex, UInt32, dwTypeIndex, DMO_MEDIA_TYPE.Ptr, pmt?)
    SetInputType(dwInputStreamIndex, pmt?, dwFlags)
      => ComCall(8, this.p, UInt32, dwInputStreamIndex, DMO_MEDIA_TYPE.Ptr, pmt?, UInt32, dwFlags)
    SetOutputType(dwOutputStreamIndex, pmt?, dwFlags)
      => ComCall(9, this.p, UInt32, dwOutputStreamIndex, DMO_MEDIA_TYPE.Ptr, pmt?, UInt32, dwFlags)
    GetInputCurrentType(dwInputStreamIndex, pmt)
      => ComCall(10, this.p, UInt32, dwInputStreamIndex, DMO_MEDIA_TYPE.Ptr, pmt)
    GetOutputCurrentType(dwOutputStreamIndex, pmt)
      => ComCall(11, this.p, UInt32, dwOutputStreamIndex, DMO_MEDIA_TYPE.Ptr, pmt)
    GetInputSizeInfo(dwInputStreamIndex, pcbSize, pcbMaxLookahead, pcbAlignment)
      => ComCall(12, this.p, UInt32, dwInputStreamIndex, UInt32.Ptr, pcbSize, UInt32.Ptr, pcbMaxLookahead, UInt32.Ptr, pcbAlignment)
    GetOutputSizeInfo(dwOutputStreamIndex, pcbSize, pcbAlignment)
      => ComCall(13, this.p, UInt32, dwOutputStreamIndex, UInt32.Ptr, pcbSize, UInt32.Ptr, pcbAlignment)
    GetInputMaxLatency(dwInputStreamIndex, prtMaxLatency)
      => ComCall(14, this.p, UInt32, dwInputStreamIndex, Int64.Ptr, prtMaxLatency)
    SetInputMaxLatency(dwInputStreamIndex, rtMaxLatency)
      => ComCall(15, this.p, UInt32, dwInputStreamIndex, Int64, rtMaxLatency)
    Flush()
      => ComCall(16, this.p)
    Discontinuity(dwInputStreamIndex)
      => ComCall(17, this.p, UInt32, dwInputStreamIndex)
    AllocateStreamingResources()
      => ComCall(18, this.p)
    FreeStreamingResources()
      => ComCall(19, this.p)
    GetInputStatus(dwInputStreamIndex, dwFlags)
      => ComCall(20, this.p, UInt32, dwInputStreamIndex, UInt32.Ptr, dwFlags)
    ProcessInput(dwInputStreamIndex, pBuffer, dwFlags, rtTimestamp, rtTimelength)
      => ComCall(21, this.p, UInt32, dwInputStreamIndex, IMediaBuffer, pBuffer, UInt32, dwFlags, Int64, rtTimestamp, Int64, rtTimelength)
    ProcessOutput(dwFlags, pOutputBuffers, pdwStatus)
      => ComCall(22, this.p, UInt32, dwFlags, UInt32, pOutputBuffers.Length, DMO_OUTPUT_DATA_BUFFER.Ptr, pOutputBuffers, UInt32.Ptr, pdwStatus)
    Lock(bLock)
      => ComCall(23, this.p, Int32, bLock)
}
struct IEnumDMO extends IUnknown {
    static IID := "{2C3CD98A-2BFA-4A53-9C27-5249BA64BA0F}"
    Next(pCLSID, Names, pcItemsFetched)
      => ComCall(3, this.p, UInt32, Names.Length, GUID.Ptr, pCLSID, PWSTR.Ptr, Names, UInt32.Ptr, pcItemsFetched)
    Skip(cItemsToSkip)
      => ComCall(4, this.p, UInt32, cItemsToSkip)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumDMO.Ptr, ppEnum)
}
struct DMO_INPLACE_PROCESS_FLAGS extends Int32 {
    static DMO_INPLACE_NORMAL := 0
    static DMO_INPLACE_ZERO := 1
}
struct IMediaObjectInPlace extends IUnknown {
    static IID := "{651B9AD0-0FC7-4AA9-9538-D89931010741}"
    Process(pData, refTimeStart, dwFlags)
      => ComCall(3, this.p, UInt32, pData.Size, UInt8.Ptr, pData, Int64, refTimeStart, UInt32, dwFlags)
    Clone(ppMediaObject)
      => ComCall(4, this.p, IMediaObjectInPlace.Ptr, ppMediaObject)
    GetLatency(pLatencyTime)
      => ComCall(5, this.p, Int64.Ptr, pLatencyTime)
}
struct DMO_QUALITY_STATUS_FLAGS extends Int32 {
    static DMO_QUALITY_STATUS_ENABLED := 1
}
struct IDMOQualityControl extends IUnknown {
    static IID := "{65ABEA96-CF36-453F-AF8A-705E98F16260}"
    SetNow(rtNow)
      => ComCall(3, this.p, Int64, rtNow)
    SetStatus(dwFlags)
      => ComCall(4, this.p, UInt32, dwFlags)
    GetStatus(pdwFlags)
      => ComCall(5, this.p, UInt32.Ptr, pdwFlags)
}
struct DMO_VIDEO_OUTPUT_STREAM_FLAGS extends Int32 {
    static DMO_VOSF_NEEDS_PREVIOUS_SAMPLE := 1
}
struct IDMOVideoOutputOptimizations extends IUnknown {
    static IID := "{BE8F4F4E-5B16-4D29-B350-7F6B5D9298AC}"
    QueryOperationModePreferences(ulOutputStreamIndex, pdwRequestedCapabilities)
      => ComCall(3, this.p, UInt32, ulOutputStreamIndex, UInt32.Ptr, pdwRequestedCapabilities)
    SetOperationMode(ulOutputStreamIndex, dwEnabledFeatures)
      => ComCall(4, this.p, UInt32, ulOutputStreamIndex, UInt32, dwEnabledFeatures)
    GetCurrentOperationMode(ulOutputStreamIndex, pdwEnabledFeatures)
      => ComCall(5, this.p, UInt32, ulOutputStreamIndex, UInt32.Ptr, pdwEnabledFeatures)
    GetCurrentSampleRequirements(ulOutputStreamIndex, pdwRequestedFeatures)
      => ComCall(6, this.p, UInt32, ulOutputStreamIndex, UInt32.Ptr, pdwRequestedFeatures)
}
struct DMO_PARTIAL_MEDIATYPE {
    type : GUID
    subtype : GUID
}
struct DMO_REGISTER_FLAGS extends Int32 {
    static DMO_REGISTERF_IS_KEYED := 1
}
struct DMO_ENUM_FLAGS extends Int32 {
    static DMO_ENUMF_INCLUDE_KEYED := 1
}
