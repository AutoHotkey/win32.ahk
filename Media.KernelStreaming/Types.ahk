#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, HANDLE, HRESULT, LUID, PWSTR, RECT, SIZE}
#Import "..\Media\Types.ahk" {TIMECODE_SAMPLE}
#Import "..\Media.DirectShow\Types.ahk" {IMediaSample, IMemAllocator, IPin}
#Import "..\Media.MediaFoundation\Types.ahk" {AM_MEDIA_TYPE}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct IKsPropertySet extends IUnknown {
    static IID := "{31EFAC30-515C-11D0-A9AA-00AA0061BE93}"
    Set(guidPropSet, dwPropID, pInstanceData, pPropData)
      => ComCall(3, this.p, GUID.Ptr, guidPropSet, UInt32, dwPropID, Struct.Ptr, pInstanceData, UInt32, pInstanceData.Size, Struct.Ptr, pPropData, UInt32, pPropData.Size)
    Get(guidPropSet, dwPropID, pInstanceData, pPropData, pcbReturned)
      => ComCall(4, this.p, GUID.Ptr, guidPropSet, UInt32, dwPropID, Struct.Ptr, pInstanceData, UInt32, pInstanceData.Size, Struct.Ptr, pPropData, UInt32, pPropData.Size, UInt32.Ptr, pcbReturned)
    QuerySupported(guidPropSet, dwPropID, pTypeSupport)
      => ComCall(5, this.p, GUID.Ptr, guidPropSet, UInt32, dwPropID, UInt32.Ptr, pTypeSupport)
}
struct IKsTopologyInfo extends IUnknown {
    static IID := "{720D4AC0-7533-11D0-A5D6-28DB04C10000}"
    get_NumCategories(pdwNumCategories)
      => ComCall(3, this.p, UInt32.Ptr, pdwNumCategories)
    get_Category(dwIndex, pCategory)
      => ComCall(4, this.p, UInt32, dwIndex, GUID.Ptr, pCategory)
    get_NumConnections(pdwNumConnections)
      => ComCall(5, this.p, UInt32.Ptr, pdwNumConnections)
    get_ConnectionInfo(dwIndex, pConnectionInfo)
      => ComCall(6, this.p, UInt32, dwIndex, KSTOPOLOGY_CONNECTION.Ptr, pConnectionInfo)
    get_NodeName(dwNodeId, pwchNodeName?, pdwNameLen)
      => ComCall(7, this.p, UInt32, dwNodeId, PWSTR, pwchNodeName?, UInt32, pwchNodeName?.Size ?? 0, UInt32.Ptr, pdwNameLen)
    get_NumNodes(pdwNumNodes)
      => ComCall(8, this.p, UInt32.Ptr, pdwNumNodes)
    get_NodeType(dwNodeId, pNodeType)
      => ComCall(9, this.p, UInt32, dwNodeId, GUID.Ptr, pNodeType)
    CreateNodeInstance(dwNodeId, iid, ppvObject)
      => ComCall(10, this.p, UInt32, dwNodeId, GUID.Ptr, iid, Struct.Ptr.Ptr, ppvObject)
}
struct IKsNodeControl extends IUnknown {
    static IID := "{11737C14-24A7-4BB5-81A0-0D003813B0C4}"
    put_NodeId(dwNodeId)
      => ComCall(3, this.p, UInt32, dwNodeId)
    put_KsControl(pKsControl)
      => ComCall(4, this.p, Struct.Ptr, pKsControl)
}
struct KSSTREAM_HEADER {
    Size : UInt32
    TypeSpecificFlags : UInt32
    PresentationTime : KSTIME
    Duration : Int64
    FrameExtent : UInt32
    DataUsed : UInt32
    Data : Struct.Ptr
    OptionsFlags : UInt32
    Reserved : UInt32
}
struct KSNODEPROPERTY_AUDIO_3D_LISTENER {
    NodeProperty : KSNODEPROPERTY
    ListenerId : Struct.Ptr
}
struct KSNODEPROPERTY_AUDIO_PROPERTY {
    NodeProperty : KSNODEPROPERTY
    AppContext : Struct.Ptr
    Length : UInt32
}
struct IKsControl extends IUnknown {
    static IID := "{28F54685-06FD-11D2-B27A-00A0C9223196}"
    KsProperty(Property, PropertyLength, PropertyData, DataLength, BytesReturned)
      => ComCall(3, this.p, KSIDENTIFIER.Ptr, Property, UInt32, PropertyLength, Struct.Ptr, PropertyData, UInt32, DataLength, UInt32.Ptr, BytesReturned)
    KsMethod(Method, MethodLength, MethodData, DataLength, BytesReturned)
      => ComCall(4, this.p, KSIDENTIFIER.Ptr, Method, UInt32, MethodLength, Struct.Ptr, MethodData, UInt32, DataLength, UInt32.Ptr, BytesReturned)
    KsEvent(Event, EventLength, EventData, DataLength, BytesReturned)
      => ComCall(5, this.p, KSIDENTIFIER.Ptr, Event, UInt32, EventLength, Struct.Ptr, EventData, UInt32, DataLength, UInt32.Ptr, BytesReturned)
}
struct IKsFormatSupport extends IUnknown {
    static IID := "{3CB4A69D-BB6F-4D2B-95B7-452D2C155DB5}"
    IsFormatSupported(pKsFormat, cbFormat, pbSupported)
      => ComCall(3, this.p, KSDATAFORMAT.Ptr, pKsFormat, UInt32, cbFormat, BOOL.Ptr, pbSupported)
    GetDevicePreferredFormat(ppKsFormat)
      => ComCall(4, this.p, KSDATAFORMAT.Ptr.Ptr, ppKsFormat)
}
struct IKsJackDescription extends IUnknown {
    static IID := "{4509F757-2D46-4637-8E62-CE7DB944F57B}"
    GetJackCount(pcJacks)
      => ComCall(3, this.p, UInt32.Ptr, pcJacks)
    GetJackDescription(nJack, pDescription)
      => ComCall(4, this.p, UInt32, nJack, KSJACK_DESCRIPTION.Ptr, pDescription)
}
struct IKsJackDescription2 extends IUnknown {
    static IID := "{478F3A9B-E0C9-4827-9228-6F5505FFE76A}"
    GetJackCount(pcJacks)
      => ComCall(3, this.p, UInt32.Ptr, pcJacks)
    GetJackDescription2(nJack, pDescription2)
      => ComCall(4, this.p, UInt32, nJack, KSJACK_DESCRIPTION2.Ptr, pDescription2)
}
struct IKsJackDescription3 extends IUnknown {
    static IID := "{E3F6778B-6660-4CC8-A291-ECC4192D9967}"
    GetJackCount(pcJacks)
      => ComCall(3, this.p, UInt32.Ptr, pcJacks)
    GetJackDescription3(nJack, pDescription3)
      => ComCall(4, this.p, UInt32, nJack, KSJACK_DESCRIPTION3.Ptr, pDescription3)
}
struct IKsJackSinkInformation extends IUnknown {
    static IID := "{D9BD72ED-290F-4581-9FF3-61027A8FE532}"
    GetJackSinkInformation(pJackSinkInformation)
      => ComCall(3, this.p, KSJACK_SINK_INFORMATION.Ptr, pJackSinkInformation)
}
struct IKsJackContainerId extends IUnknown {
    static IID := "{C99AF463-D629-4EC4-8C00-E54D68154248}"
    GetJackContainerId(pJackContainerId)
      => ComCall(3, this.p, GUID.Ptr, pJackContainerId)
}
struct KSRESET extends Int32 {
    static KSRESET_BEGIN := 0
    static KSRESET_END := 1
}
struct KSSTATE extends Int32 {
    static KSSTATE_STOP := 0
    static KSSTATE_ACQUIRE := 1
    static KSSTATE_PAUSE := 2
    static KSSTATE_RUN := 3
}
struct KSPRIORITY {
    PriorityClass : UInt32
    PrioritySubClass : UInt32
}
struct KSIDENTIFIER {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Alignment : Int64
        }
        struct _Anonymous_e__Struct {
            Set : GUID
            Id : UInt32
            Flags : UInt32
        }
    }
}
struct KSP_NODE {
    Property : KSIDENTIFIER
    NodeId : UInt32
    Reserved : UInt32
}
struct KSM_NODE {
    Method : KSIDENTIFIER
    NodeId : UInt32
    Reserved : UInt32
}
struct KSE_NODE {
    Event : KSIDENTIFIER
    NodeId : UInt32
    Reserved : UInt32
}
struct KSMULTIPLE_ITEM {
    Size : UInt32
    Count : UInt32
}
struct KSPROPERTY_DESCRIPTION {
    AccessFlags : UInt32
    DescriptionSize : UInt32
    PropTypeSet : KSIDENTIFIER
    MembersListCount : UInt32
    Reserved : UInt32
}
struct KSPROPERTY_MEMBERSHEADER {
    MembersFlags : UInt32
    MembersSize : UInt32
    MembersCount : UInt32
    Flags : UInt32
}
struct KSPROPERTY_BOUNDS_LONG {
    union {
        Anonymous1 : this._Anonymous1_e__Struct
        Anonymous2 : this._Anonymous2_e__Struct
    }
    struct _Anonymous1_e__Struct {
        SignedMinimum : Int32
        SignedMaximum : Int32
    }
    struct _Anonymous2_e__Struct {
        UnsignedMinimum : UInt32
        UnsignedMaximum : UInt32
    }
}
struct KSPROPERTY_BOUNDS_LONGLONG {
    union {
        Anonymous1 : this._Anonymous1_e__Struct
        Anonymous2 : this._Anonymous2_e__Struct
    }
    struct _Anonymous1_e__Struct {
        SignedMinimum : Int64
        SignedMaximum : Int64
    }
    struct _Anonymous2_e__Struct {
        UnsignedMinimum : Int64
        UnsignedMaximum : Int64
    }
}
struct KSPROPERTY_STEPPING_LONG {
    SteppingDelta : UInt32
    Reserved : UInt32
    Bounds : KSPROPERTY_BOUNDS_LONG
}
struct KSPROPERTY_STEPPING_LONGLONG {
    SteppingDelta : Int64
    Bounds : KSPROPERTY_BOUNDS_LONGLONG
}
struct KSEVENTDATA {
    NotificationType : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            EventHandle : this._EventHandle_e__Struct
            SemaphoreHandle : this._SemaphoreHandle_e__Struct
            Alignment : this._Alignment_e__Struct
        }
        struct _EventHandle_e__Struct {
            Event : HANDLE
            Reserved : IntPtr[2]
        }
        struct _SemaphoreHandle_e__Struct {
            Semaphore : HANDLE
            Reserved : UInt32
            Adjustment : Int32
        }
        struct _Alignment_e__Struct {
            Unused : Struct.Ptr
            Alignment : IntPtr[2]
        }
    }
}
struct KSQUERYBUFFER {
    Event : KSIDENTIFIER
    EventData : KSEVENTDATA.Ptr
    Reserved : Struct.Ptr
}
struct KSRELATIVEEVENT {
    Size : UInt32
    Flags : UInt32
    Anonymous : this._Anonymous_e__Union
    Reserved : Struct.Ptr
    Event : KSIDENTIFIER
    EventData : KSEVENTDATA
    struct _Anonymous_e__Union {
        union {
            ObjectHandle : HANDLE
            ObjectPointer : Struct.Ptr
        }
    }
}
struct KSEVENT_TIME_MARK {
    EventData : KSEVENTDATA
    MarkTime : Int64
}
struct KSEVENT_TIME_INTERVAL {
    EventData : KSEVENTDATA
    TimeBase : Int64
    Interval : Int64
}
struct KSINTERVAL {
    TimeBase : Int64
    Interval : Int64
}
struct KSPROPERTY_GENERAL extends Int32 {
    static KSPROPERTY_GENERAL_COMPONENTID := 0
}
struct KSCOMPONENTID {
    Manufacturer : GUID
    Product : GUID
    Component : GUID
    Name : GUID
    Version : UInt32
    Revision : UInt32
}
struct KSMETHOD_STREAMIO extends Int32 {
    static KSMETHOD_STREAMIO_READ := 0
    static KSMETHOD_STREAMIO_WRITE := 1
}
struct KSPROPERTY_MEDIASEEKING extends Int32 {
    static KSPROPERTY_MEDIASEEKING_CAPABILITIES := 0
    static KSPROPERTY_MEDIASEEKING_FORMATS := 1
    static KSPROPERTY_MEDIASEEKING_TIMEFORMAT := 2
    static KSPROPERTY_MEDIASEEKING_POSITION := 3
    static KSPROPERTY_MEDIASEEKING_STOPPOSITION := 4
    static KSPROPERTY_MEDIASEEKING_POSITIONS := 5
    static KSPROPERTY_MEDIASEEKING_DURATION := 6
    static KSPROPERTY_MEDIASEEKING_AVAILABLE := 7
    static KSPROPERTY_MEDIASEEKING_PREROLL := 8
    static KSPROPERTY_MEDIASEEKING_CONVERTTIMEFORMAT := 9
}
struct KS_SEEKING_FLAGS extends Int32 {
    static KS_SEEKING_NoPositioning := 0
    static KS_SEEKING_AbsolutePositioning := 1
    static KS_SEEKING_RelativePositioning := 2
    static KS_SEEKING_IncrementalPositioning := 3
    static KS_SEEKING_PositioningBitsMask := 3
    static KS_SEEKING_SeekToKeyFrame := 4
    static KS_SEEKING_ReturnTime := 8
}
struct KS_SEEKING_CAPABILITIES extends Int32 {
    static KS_SEEKING_CanSeekAbsolute := 1
    static KS_SEEKING_CanSeekForwards := 2
    static KS_SEEKING_CanSeekBackwards := 4
    static KS_SEEKING_CanGetCurrentPos := 8
    static KS_SEEKING_CanGetStopPos := 16
    static KS_SEEKING_CanGetDuration := 32
    static KS_SEEKING_CanPlayBackwards := 64
}
struct KSPROPERTY_POSITIONS {
    Current : Int64
    Stop : Int64
    CurrentFlags : KS_SEEKING_FLAGS
    StopFlags : KS_SEEKING_FLAGS
}
struct KSPROPERTY_MEDIAAVAILABLE {
    Earliest : Int64
    Latest : Int64
}
struct KSP_TIMEFORMAT {
    Property : KSIDENTIFIER
    SourceFormat : GUID
    TargetFormat : GUID
    Time : Int64
}
struct KSPROPERTY_TOPOLOGY extends Int32 {
    static KSPROPERTY_TOPOLOGY_CATEGORIES := 0
    static KSPROPERTY_TOPOLOGY_NODES := 1
    static KSPROPERTY_TOPOLOGY_CONNECTIONS := 2
    static KSPROPERTY_TOPOLOGY_NAME := 3
}
struct KSTOPOLOGY_CONNECTION {
    FromNode : UInt32
    FromNodePin : UInt32
    ToNode : UInt32
    ToNodePin : UInt32
}
struct KSTOPOLOGY {
    CategoriesCount : UInt32
    Categories : GUID.Ptr
    TopologyNodesCount : UInt32
    TopologyNodes : GUID.Ptr
    TopologyConnectionsCount : UInt32
    TopologyConnections : KSTOPOLOGY_CONNECTION.Ptr
    TopologyNodesNames : GUID.Ptr
    Reserved : UInt32
}
struct KSNODE_CREATE {
    CreateFlags : UInt32
    Node : UInt32
}
struct KSINTERFACE_STANDARD extends Int32 {
    static KSINTERFACE_STANDARD_STREAMING := 0
    static KSINTERFACE_STANDARD_LOOPED_STREAMING := 1
    static KSINTERFACE_STANDARD_CONTROL := 2
}
struct KSINTERFACE_FILEIO extends Int32 {
    static KSINTERFACE_FILEIO_STREAMING := 0
}
struct KSPROPERTY_PIN extends Int32 {
    static KSPROPERTY_PIN_CINSTANCES := 0
    static KSPROPERTY_PIN_CTYPES := 1
    static KSPROPERTY_PIN_DATAFLOW := 2
    static KSPROPERTY_PIN_DATARANGES := 3
    static KSPROPERTY_PIN_DATAINTERSECTION := 4
    static KSPROPERTY_PIN_INTERFACES := 5
    static KSPROPERTY_PIN_MEDIUMS := 6
    static KSPROPERTY_PIN_COMMUNICATION := 7
    static KSPROPERTY_PIN_GLOBALCINSTANCES := 8
    static KSPROPERTY_PIN_NECESSARYINSTANCES := 9
    static KSPROPERTY_PIN_PHYSICALCONNECTION := 10
    static KSPROPERTY_PIN_CATEGORY := 11
    static KSPROPERTY_PIN_NAME := 12
    static KSPROPERTY_PIN_CONSTRAINEDDATARANGES := 13
    static KSPROPERTY_PIN_PROPOSEDATAFORMAT := 14
    static KSPROPERTY_PIN_PROPOSEDATAFORMAT2 := 15
    static KSPROPERTY_PIN_MODEDATAFORMATS := 16
}
struct KSP_PIN {
    Property : KSIDENTIFIER
    PinId : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Reserved : UInt32
            Flags : UInt32
        }
    }
}
struct KSE_PIN {
    Event : KSIDENTIFIER
    PinId : UInt32
    Reserved : UInt32
}
struct KSPIN_CINSTANCES {
    PossibleCount : UInt32
    CurrentCount : UInt32
}
struct KSPIN_DATAFLOW extends Int32 {
    static KSPIN_DATAFLOW_IN := 1
    static KSPIN_DATAFLOW_OUT := 2
}
struct KSDATAFORMAT {
    union {
        Anonymous : this._Anonymous_e__Struct
        Alignment : Int64
    }
    struct _Anonymous_e__Struct {
        FormatSize : UInt32
        Flags : UInt32
        SampleSize : UInt32
        Reserved : UInt32
        MajorFormat : GUID
        SubFormat : GUID
        Specifier : GUID
    }
}
struct KSATTRIBUTE {
    Size : UInt32
    Flags : UInt32
    Attribute : GUID
}
struct KSPIN_COMMUNICATION extends Int32 {
    static KSPIN_COMMUNICATION_NONE := 0
    static KSPIN_COMMUNICATION_SINK := 1
    static KSPIN_COMMUNICATION_SOURCE := 2
    static KSPIN_COMMUNICATION_BOTH := 3
    static KSPIN_COMMUNICATION_BRIDGE := 4
}
struct KSPIN_CONNECT {
    Interface : KSIDENTIFIER
    Medium : KSIDENTIFIER
    PinId : UInt32
    PinToHandle : HANDLE
    Priority : KSPRIORITY
}
struct KSPIN_PHYSICALCONNECTION {
    Size : UInt32
    Pin : UInt32
    SymbolicLinkName : UInt16[1]
}
struct KSEVENT_PINCAPS_CHANGENOTIFICATIONS extends Int32 {
    static KSEVENT_PINCAPS_FORMATCHANGE := 0
    static KSEVENT_PINCAPS_JACKINFOCHANGE := 1
    static KSEVENT_PINCAPS_INVALIDATECLIENTS := 2
}
struct KSEVENT_VOLUMELIMIT extends Int32 {
    static KSEVENT_VOLUMELIMIT_CHANGED := 0
}
struct KSPROPERTY_QUALITY extends Int32 {
    static KSPROPERTY_QUALITY_REPORT := 0
    static KSPROPERTY_QUALITY_ERROR := 1
}
struct KSPROPERTY_CONNECTION extends Int32 {
    static KSPROPERTY_CONNECTION_STATE := 0
    static KSPROPERTY_CONNECTION_PRIORITY := 1
    static KSPROPERTY_CONNECTION_DATAFORMAT := 2
    static KSPROPERTY_CONNECTION_ALLOCATORFRAMING := 3
    static KSPROPERTY_CONNECTION_PROPOSEDATAFORMAT := 4
    static KSPROPERTY_CONNECTION_ACQUIREORDERING := 5
    static KSPROPERTY_CONNECTION_ALLOCATORFRAMING_EX := 6
    static KSPROPERTY_CONNECTION_STARTAT := 7
}
struct KSALLOCATOR_FRAMING {
    Anonymous1 : this._Anonymous1_e__Union
    PoolType : UInt32
    Frames : UInt32
    FrameSize : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    Reserved : UInt32
    struct _Anonymous1_e__Union {
        union {
            OptionsFlags : UInt32
            RequirementsFlags : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            FileAlignment : UInt32
            FramePitch : Int32
        }
    }
}
struct KS_FRAMING_RANGE {
    MinFrameSize : UInt32
    MaxFrameSize : UInt32
    Stepping : UInt32
}
struct KS_FRAMING_RANGE_WEIGHTED {
    Range : KS_FRAMING_RANGE
    InPlaceWeight : UInt32
    NotInPlaceWeight : UInt32
}
struct KS_COMPRESSION {
    RatioNumerator : UInt32
    RatioDenominator : UInt32
    RatioConstantMargin : UInt32
}
struct KS_FRAMING_ITEM {
    MemoryType : GUID
    BusType : GUID
    MemoryFlags : UInt32
    BusFlags : UInt32
    Flags : UInt32
    Frames : UInt32
    Anonymous : this._Anonymous_e__Union
    MemoryTypeWeight : UInt32
    PhysicalRange : KS_FRAMING_RANGE
    FramingRange : KS_FRAMING_RANGE_WEIGHTED
    struct _Anonymous_e__Union {
        union {
            FileAlignment : UInt32
            FramePitch : Int32
        }
    }
}
struct KSALLOCATOR_FRAMING_EX {
    CountItems : UInt32
    PinFlags : UInt32
    OutputCompression : KS_COMPRESSION
    PinWeight : UInt32
    FramingItem : KS_FRAMING_ITEM[1]
}
struct KSEVENT_STREAMALLOCATOR extends Int32 {
    static KSEVENT_STREAMALLOCATOR_INTERNAL_FREEFRAME := 0
    static KSEVENT_STREAMALLOCATOR_FREEFRAME := 1
}
struct KSMETHOD_STREAMALLOCATOR extends Int32 {
    static KSMETHOD_STREAMALLOCATOR_ALLOC := 0
    static KSMETHOD_STREAMALLOCATOR_FREE := 1
}
struct KSSTREAMALLOCATOR_STATUS {
    Framing : KSALLOCATOR_FRAMING
    AllocatedFrames : UInt32
    Reserved : UInt32
}
struct KSSTREAMALLOCATOR_STATUS_EX {
    Framing : KSALLOCATOR_FRAMING_EX
    AllocatedFrames : UInt32
    Reserved : UInt32
}
struct KSTIME {
    Time : Int64
    Numerator : UInt32
    Denominator : UInt32
}
struct KSSTREAM_METADATA_INFO {
    BufferSize : UInt32
    UsedSize : UInt32
    Data : Struct.Ptr
    SystemVa : Struct.Ptr
    Flags : UInt32
    Reserved : UInt32
}
struct KSSTREAM_UVC_METADATATYPE_TIMESTAMP {
    PresentationTimeStamp : UInt32
    SourceClockReference : UInt32
    Anonymous : this._Anonymous_e__Union
    Reserved0 : UInt16
    Reserved1 : UInt32
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            SCRToken : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct KSSTREAM_UVC_METADATA {
    StartOfFrameTimestamp : KSSTREAM_UVC_METADATATYPE_TIMESTAMP
    EndOfFrameTimestamp : KSSTREAM_UVC_METADATATYPE_TIMESTAMP
}
struct KSPIN_MDL_CACHING_EVENT extends Int32 {
    static KSPIN_MDL_CACHING_NOTIFY_CLEANUP := 0
    static KSPIN_MDL_CACHING_NOTIFY_CLEANALL_WAIT := 1
    static KSPIN_MDL_CACHING_NOTIFY_CLEANALL_NOWAIT := 2
    static KSPIN_MDL_CACHING_NOTIFY_ADDSAMPLE := 3
}
struct KSPIN_MDL_CACHING_NOTIFICATION {
    Event : KSPIN_MDL_CACHING_EVENT
    Buffer : Struct.Ptr
}
struct KSPIN_MDL_CACHING_NOTIFICATION32 {
    Event : KSPIN_MDL_CACHING_EVENT
    Buffer : UInt32
}
struct KSPROPERTY_STREAMINTERFACE extends Int32 {
    static KSPROPERTY_STREAMINTERFACE_HEADERSIZE := 0
}
struct KSPROPERTY_STREAM extends Int32 {
    static KSPROPERTY_STREAM_ALLOCATOR := 0
    static KSPROPERTY_STREAM_QUALITY := 1
    static KSPROPERTY_STREAM_DEGRADATION := 2
    static KSPROPERTY_STREAM_MASTERCLOCK := 3
    static KSPROPERTY_STREAM_TIMEFORMAT := 4
    static KSPROPERTY_STREAM_PRESENTATIONTIME := 5
    static KSPROPERTY_STREAM_PRESENTATIONEXTENT := 6
    static KSPROPERTY_STREAM_FRAMETIME := 7
    static KSPROPERTY_STREAM_RATECAPABILITY := 8
    static KSPROPERTY_STREAM_RATE := 9
    static KSPROPERTY_STREAM_PIPE_ID := 10
}
struct KSPPROPERTY_ALLOCATOR_MDLCACHING extends Int32 {
    static KSPROPERTY_ALLOCATOR_CLEANUP_CACHEDMDLPAGES := 1
}
struct KSQUALITY_MANAGER {
    QualityManager : HANDLE
    Context : Struct.Ptr
}
struct KSFRAMETIME {
    Duration : Int64
    FrameFlags : UInt32
    Reserved : UInt32
}
struct KSRATE {
    PresentationStart : Int64
    Duration : Int64
    Interface : KSIDENTIFIER
    Rate : Int32
    Flags : UInt32
}
struct KSRATE_CAPABILITY {
    Property : KSIDENTIFIER
    Rate : KSRATE
}
struct KSCLOCK_CREATE {
    CreateFlags : UInt32
}
struct KSCORRELATED_TIME {
    Time : Int64
    SystemTime : Int64
}
struct KSRESOLUTION {
    Granularity : Int64
    Error : Int64
}
struct KSPROPERTY_CLOCK extends Int32 {
    static KSPROPERTY_CLOCK_TIME := 0
    static KSPROPERTY_CLOCK_PHYSICALTIME := 1
    static KSPROPERTY_CLOCK_CORRELATEDTIME := 2
    static KSPROPERTY_CLOCK_CORRELATEDPHYSICALTIME := 3
    static KSPROPERTY_CLOCK_RESOLUTION := 4
    static KSPROPERTY_CLOCK_STATE := 5
}
struct KSEVENT_CLOCK_POSITION extends Int32 {
    static KSEVENT_CLOCK_INTERVAL_MARK := 0
    static KSEVENT_CLOCK_POSITION_MARK := 1
}
struct KSEVENT_CONNECTION extends Int32 {
    static KSEVENT_CONNECTION_POSITIONUPDATE := 0
    static KSEVENT_CONNECTION_DATADISCONTINUITY := 1
    static KSEVENT_CONNECTION_TIMEDISCONTINUITY := 2
    static KSEVENT_CONNECTION_PRIORITY := 3
    static KSEVENT_CONNECTION_ENDOFSTREAM := 4
}
struct KSQUALITY {
    Context : Struct.Ptr
    Proportion : UInt32
    DeltaTime : Int64
}
struct KSERROR {
    Context : Struct.Ptr
    Status : UInt32
}
struct KSDEVICE_THERMAL_STATE extends Int32 {
    static KSDEVICE_THERMAL_STATE_LOW := 0
    static KSDEVICE_THERMAL_STATE_HIGH := 1
}
struct KSEVENT_DEVICE extends Int32 {
    static KSEVENT_DEVICE_LOST := 0
    static KSEVENT_DEVICE_PREEMPTED := 1
    static KSEVENT_DEVICE_THERMAL_HIGH := 2
    static KSEVENT_DEVICE_THERMAL_LOW := 3
}
struct KSDEGRADE_STANDARD extends Int32 {
    static KSDEGRADE_STANDARD_SAMPLE := 0
    static KSDEGRADE_STANDARD_QUALITY := 1
    static KSDEGRADE_STANDARD_COMPUTATION := 2
    static KSDEGRADE_STANDARD_SKIP := 3
}
struct KSPROPERTY_SERIALHDR {
    PropertySet : GUID
    Count : UInt32
}
struct KSPROPERTY_SERIAL {
    PropTypeSet : KSIDENTIFIER
    Id : UInt32
    PropertyLength : UInt32
}
struct MF_MDL_SHARED_PAYLOAD_KEY {
    union {
        combined : this._combined_e__Struct
        GMDLHandle : GUID
    }
    struct _combined_e__Struct {
        pHandle : UInt32
        fHandle : UInt32
        uPayload : Int64
    }
}
struct KSMULTIPLE_DATA_PROP {
    Property : KSIDENTIFIER
    MultipleItem : KSMULTIPLE_ITEM
}
struct KSINTERFACE_MEDIA extends Int32 {
    static KSINTERFACE_MEDIA_MUSIC := 0
    static KSINTERFACE_MEDIA_WAVE_BUFFERED := 1
    static KSINTERFACE_MEDIA_WAVE_QUEUED := 2
}
struct KSAUDIO_POSITION {
    PlayOffset : Int64
    WriteOffset : Int64
}
struct KSAUDIO_PRESENTATION_POSITION {
    u64PositionInBlocks : Int64
    u64QPCPosition : Int64
}
struct CONSTRICTOR_OPTION extends Int32 {
    static CONSTRICTOR_OPTION_DISABLE := 0
    static CONSTRICTOR_OPTION_MUTE := 1
}
struct KSAUDIO_PACKETSIZE_PROCESSINGMODE_CONSTRAINT {
    ProcessingMode : GUID
    SamplesPerProcessingPacket : UInt32
    ProcessingPacketDurationInHns : UInt32
}
struct KSAUDIO_PACKETSIZE_CONSTRAINTS {
    MinPacketPeriodInHns : UInt32
    PacketSizeFileAlignment : UInt32
    Reserved : UInt32
    NumProcessingModeConstraints : UInt32
    ProcessingModeConstraints : KSAUDIO_PACKETSIZE_PROCESSINGMODE_CONSTRAINT[1]
}
struct KSAUDIO_PACKETSIZE_CONSTRAINTS2 {
    MinPacketPeriodInHns : UInt32
    PacketSizeFileAlignment : UInt32
    MaxPacketSizeInBytes : UInt32
    NumProcessingModeConstraints : UInt32
    ProcessingModeConstraints : KSAUDIO_PACKETSIZE_PROCESSINGMODE_CONSTRAINT[1]
}
struct KSMICARRAY_MICTYPE extends Int32 {
    static KSMICARRAY_MICTYPE_OMNIDIRECTIONAL := 0
    static KSMICARRAY_MICTYPE_SUBCARDIOID := 1
    static KSMICARRAY_MICTYPE_CARDIOID := 2
    static KSMICARRAY_MICTYPE_SUPERCARDIOID := 3
    static KSMICARRAY_MICTYPE_HYPERCARDIOID := 4
    static KSMICARRAY_MICTYPE_8SHAPED := 5
    static KSMICARRAY_MICTYPE_VENDORDEFINED := 15
}
struct KSAUDIO_MICROPHONE_COORDINATES {
    usType : UInt16
    wXCoord : Int16
    wYCoord : Int16
    wZCoord : Int16
    wVerticalAngle : Int16
    wHorizontalAngle : Int16
}
struct KSMICARRAY_MICARRAYTYPE extends Int32 {
    static KSMICARRAY_MICARRAYTYPE_LINEAR := 0
    static KSMICARRAY_MICARRAYTYPE_PLANAR := 1
    static KSMICARRAY_MICARRAYTYPE_3D := 2
}
struct KSAUDIO_MIC_ARRAY_GEOMETRY {
    usVersion : UInt16
    usMicArrayType : UInt16
    wVerticalAngleBegin : Int16
    wVerticalAngleEnd : Int16
    wHorizontalAngleBegin : Int16
    wHorizontalAngleEnd : Int16
    usFrequencyBandLo : UInt16
    usFrequencyBandHi : UInt16
    usNumberOfMicrophones : UInt16
    KsMicCoord : KSAUDIO_MICROPHONE_COORDINATES[1]
}
struct DS3DVECTOR {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    struct _Anonymous1_e__Union {
        union {
            x : Float32
            dvX : Float32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            y : Float32
            dvY : Float32
        }
    }
    struct _Anonymous3_e__Union {
        union {
            z : Float32
            dvZ : Float32
        }
    }
}
struct KSPROPERTY_DIRECTSOUND3DLISTENER extends Int32 {
    static KSPROPERTY_DIRECTSOUND3DLISTENER_ALL := 0
    static KSPROPERTY_DIRECTSOUND3DLISTENER_POSITION := 1
    static KSPROPERTY_DIRECTSOUND3DLISTENER_VELOCITY := 2
    static KSPROPERTY_DIRECTSOUND3DLISTENER_ORIENTATION := 3
    static KSPROPERTY_DIRECTSOUND3DLISTENER_DISTANCEFACTOR := 4
    static KSPROPERTY_DIRECTSOUND3DLISTENER_ROLLOFFFACTOR := 5
    static KSPROPERTY_DIRECTSOUND3DLISTENER_DOPPLERFACTOR := 6
    static KSPROPERTY_DIRECTSOUND3DLISTENER_BATCH := 7
    static KSPROPERTY_DIRECTSOUND3DLISTENER_ALLOCATION := 8
}
struct KSDS3D_LISTENER_ALL {
    Position : DS3DVECTOR
    Velocity : DS3DVECTOR
    OrientFront : DS3DVECTOR
    OrientTop : DS3DVECTOR
    DistanceFactor : Float32
    RolloffFactor : Float32
    DopplerFactor : Float32
}
struct KSDS3D_LISTENER_ORIENTATION {
    Front : DS3DVECTOR
    Top : DS3DVECTOR
}
struct KSPROPERTY_DIRECTSOUND3DBUFFER extends Int32 {
    static KSPROPERTY_DIRECTSOUND3DBUFFER_ALL := 0
    static KSPROPERTY_DIRECTSOUND3DBUFFER_POSITION := 1
    static KSPROPERTY_DIRECTSOUND3DBUFFER_VELOCITY := 2
    static KSPROPERTY_DIRECTSOUND3DBUFFER_CONEANGLES := 3
    static KSPROPERTY_DIRECTSOUND3DBUFFER_CONEORIENTATION := 4
    static KSPROPERTY_DIRECTSOUND3DBUFFER_CONEOUTSIDEVOLUME := 5
    static KSPROPERTY_DIRECTSOUND3DBUFFER_MINDISTANCE := 6
    static KSPROPERTY_DIRECTSOUND3DBUFFER_MAXDISTANCE := 7
    static KSPROPERTY_DIRECTSOUND3DBUFFER_MODE := 8
}
struct KSDS3D_BUFFER_ALL {
    Position : DS3DVECTOR
    Velocity : DS3DVECTOR
    InsideConeAngle : UInt32
    OutsideConeAngle : UInt32
    ConeOrientation : DS3DVECTOR
    ConeOutsideVolume : Int32
    MinDistance : Float32
    MaxDistance : Float32
    Mode : UInt32
}
struct KSDS3D_BUFFER_CONE_ANGLES {
    InsideConeAngle : UInt32
    OutsideConeAngle : UInt32
}
struct KSDS3D_HRTF_PARAMS_MSG {
    Size : UInt32
    Enabled : UInt32
    SwapChannels : BOOL
    ZeroAzimuth : BOOL
    CrossFadeOutput : BOOL
    FilterSize : UInt32
}
struct KSDS3D_HRTF_FILTER_QUALITY extends Int32 {
    static FULL_FILTER := 0
    static LIGHT_FILTER := 1
    static KSDS3D_FILTER_QUALITY_COUNT := 2
}
struct KSDS3D_HRTF_INIT_MSG {
    Size : UInt32
    Quality : KSDS3D_HRTF_FILTER_QUALITY
    SampleRate : Float32
    MaxFilterSize : UInt32
    FilterTransientMuteLength : UInt32
    FilterOverlapBufferLength : UInt32
    OutputOverlapBufferLength : UInt32
    Reserved : UInt32
}
struct KSDS3D_HRTF_COEFF_FORMAT extends Int32 {
    static FLOAT_COEFF := 0
    static SHORT_COEFF := 1
    static KSDS3D_COEFF_COUNT := 2
}
struct KSDS3D_HRTF_FILTER_METHOD extends Int32 {
    static DIRECT_FORM := 0
    static CASCADE_FORM := 1
    static KSDS3D_FILTER_METHOD_COUNT := 2
}
struct KSDS3D_HRTF_FILTER_VERSION extends Int32 {
    static DS3D_HRTF_VERSION_1 := 0
}
struct KSDS3D_HRTF_FILTER_FORMAT_MSG {
    FilterMethod : KSDS3D_HRTF_FILTER_METHOD
    CoeffFormat : KSDS3D_HRTF_COEFF_FORMAT
    Version : KSDS3D_HRTF_FILTER_VERSION
    Reserved : UInt32
}
struct KSPROPERTY_HRTF3D extends Int32 {
    static KSPROPERTY_HRTF3D_PARAMS := 0
    static KSPROPERTY_HRTF3D_INITIALIZE := 1
    static KSPROPERTY_HRTF3D_FILTER_FORMAT := 2
}
struct KSDS3D_ITD_PARAMS {
    Channel : Int32
    VolSmoothScale : Float32
    TotalDryAttenuation : Float32
    TotalWetAttenuation : Float32
    SmoothFrequency : Int32
    Delay : Int32
}
struct KSDS3D_ITD_PARAMS_MSG {
    Enabled : UInt32
    LeftParams : KSDS3D_ITD_PARAMS
    RightParams : KSDS3D_ITD_PARAMS
    Reserved : UInt32
}
struct KSPROPERTY_ITD3D extends Int32 {
    static KSPROPERTY_ITD3D_PARAMS := 0
}
struct KSDATARANGE_AUDIO {
    DataRange : KSDATAFORMAT
    MaximumChannels : UInt32
    MinimumBitsPerSample : UInt32
    MaximumBitsPerSample : UInt32
    MinimumSampleFrequency : UInt32
    MaximumSampleFrequency : UInt32
}
struct KSPROPERTY_BIBLIOGRAPHIC extends Int32 {
    static KSPROPERTY_BIBLIOGRAPHIC_LEADER := 1380207648
    static KSPROPERTY_BIBLIOGRAPHIC_LCCN := 808529952
    static KSPROPERTY_BIBLIOGRAPHIC_ISBN := 808595488
    static KSPROPERTY_BIBLIOGRAPHIC_ISSN := 842149920
    static KSPROPERTY_BIBLIOGRAPHIC_CATALOGINGSOURCE := 808726560
    static KSPROPERTY_BIBLIOGRAPHIC_MAINPERSONALNAME := 808464672
    static KSPROPERTY_BIBLIOGRAPHIC_MAINCORPORATEBODY := 808530208
    static KSPROPERTY_BIBLIOGRAPHIC_MAINMEETINGNAME := 825307424
    static KSPROPERTY_BIBLIOGRAPHIC_MAINUNIFORMTITLE := 808661280
    static KSPROPERTY_BIBLIOGRAPHIC_UNIFORMTITLE := 808727072
    static KSPROPERTY_BIBLIOGRAPHIC_TITLESTATEMENT := 892613152
    static KSPROPERTY_BIBLIOGRAPHIC_VARYINGFORMTITLE := 909390368
    static KSPROPERTY_BIBLIOGRAPHIC_PUBLICATION := 808858144
    static KSPROPERTY_BIBLIOGRAPHIC_PHYSICALDESCRIPTION := 808465184
    static KSPROPERTY_BIBLIOGRAPHIC_ADDEDENTRYTITLE := 808727584
    static KSPROPERTY_BIBLIOGRAPHIC_SERIESSTATEMENT := 809055264
    static KSPROPERTY_BIBLIOGRAPHIC_GENERALNOTE := 808465696
    static KSPROPERTY_BIBLIOGRAPHIC_BIBLIOGRAPHYNOTE := 875574560
    static KSPROPERTY_BIBLIOGRAPHIC_CONTENTSNOTE := 892351776
    static KSPROPERTY_BIBLIOGRAPHIC_CREATIONCREDIT := 942683424
    static KSPROPERTY_BIBLIOGRAPHIC_CITATION := 808531232
    static KSPROPERTY_BIBLIOGRAPHIC_PARTICIPANT := 825308448
    static KSPROPERTY_BIBLIOGRAPHIC_SUMMARY := 808596768
    static KSPROPERTY_BIBLIOGRAPHIC_TARGETAUDIENCE := 825373984
    static KSPROPERTY_BIBLIOGRAPHIC_ADDEDFORMAVAILABLE := 808662304
    static KSPROPERTY_BIBLIOGRAPHIC_SYSTEMDETAILS := 942880032
    static KSPROPERTY_BIBLIOGRAPHIC_AWARDS := 909653280
    static KSPROPERTY_BIBLIOGRAPHIC_ADDEDENTRYPERSONALNAME := 808465952
    static KSPROPERTY_BIBLIOGRAPHIC_ADDEDENTRYTOPICALTERM := 808793632
    static KSPROPERTY_BIBLIOGRAPHIC_ADDEDENTRYGEOGRAPHIC := 825570848
    static KSPROPERTY_BIBLIOGRAPHIC_INDEXTERMGENRE := 892679712
    static KSPROPERTY_BIBLIOGRAPHIC_INDEXTERMCURRICULUM := 943011360
    static KSPROPERTY_BIBLIOGRAPHIC_ADDEDENTRYUNIFORMTITLE := 808662816
    static KSPROPERTY_BIBLIOGRAPHIC_ADDEDENTRYRELATED := 808728352
    static KSPROPERTY_BIBLIOGRAPHIC_SERIESSTATEMENTPERSONALNAME := 808466464
    static KSPROPERTY_BIBLIOGRAPHIC_SERIESSTATEMENTUNIFORMTITLE := 808663072
}
struct KSPROPERTY_TOPOLOGYNODE extends Int32 {
    static KSPROPERTY_TOPOLOGYNODE_ENABLE := 1
    static KSPROPERTY_TOPOLOGYNODE_RESET := 2
}
struct KSPROPERTY_RTAUDIO extends Int32 {
    static KSPROPERTY_RTAUDIO_GETPOSITIONFUNCTION := 0
    static KSPROPERTY_RTAUDIO_BUFFER := 1
    static KSPROPERTY_RTAUDIO_HWLATENCY := 2
    static KSPROPERTY_RTAUDIO_POSITIONREGISTER := 3
    static KSPROPERTY_RTAUDIO_CLOCKREGISTER := 4
    static KSPROPERTY_RTAUDIO_BUFFER_WITH_NOTIFICATION := 5
    static KSPROPERTY_RTAUDIO_REGISTER_NOTIFICATION_EVENT := 6
    static KSPROPERTY_RTAUDIO_UNREGISTER_NOTIFICATION_EVENT := 7
    static KSPROPERTY_RTAUDIO_QUERY_NOTIFICATION_SUPPORT := 8
    static KSPROPERTY_RTAUDIO_PACKETCOUNT := 9
    static KSPROPERTY_RTAUDIO_PRESENTATION_POSITION := 10
    static KSPROPERTY_RTAUDIO_GETREADPACKET := 11
    static KSPROPERTY_RTAUDIO_SETWRITEPACKET := 12
    static KSPROPERTY_RTAUDIO_PACKETVREGISTER := 13
}
struct KSRTAUDIO_BUFFER_PROPERTY {
    Property : KSIDENTIFIER
    BaseAddress : Struct.Ptr
    RequestedBufferSize : UInt32
}
struct KSRTAUDIO_BUFFER_PROPERTY32 {
    Property : KSIDENTIFIER
    BaseAddress : UInt32
    RequestedBufferSize : UInt32
}
struct KSRTAUDIO_BUFFER_PROPERTY_WITH_NOTIFICATION {
    Property : KSIDENTIFIER
    BaseAddress : Struct.Ptr
    RequestedBufferSize : UInt32
    NotificationCount : UInt32
}
struct KSRTAUDIO_BUFFER_PROPERTY_WITH_NOTIFICATION32 {
    Property : KSIDENTIFIER
    BaseAddress : UInt32
    RequestedBufferSize : UInt32
    NotificationCount : UInt32
}
struct KSRTAUDIO_BUFFER {
    BufferAddress : Struct.Ptr
    ActualBufferSize : UInt32
    CallMemoryBarrier : BOOL
}
struct KSRTAUDIO_BUFFER32 {
    BufferAddress : UInt32
    ActualBufferSize : UInt32
    CallMemoryBarrier : BOOL
}
struct KSRTAUDIO_HWLATENCY {
    FifoSize : UInt32
    ChipsetDelay : UInt32
    CodecDelay : UInt32
}
struct KSRTAUDIO_HWREGISTER_PROPERTY {
    Property : KSIDENTIFIER
    BaseAddress : Struct.Ptr
}
struct KSRTAUDIO_HWREGISTER_PROPERTY32 {
    Property : KSIDENTIFIER
    BaseAddress : UInt32
}
struct KSRTAUDIO_HWREGISTER {
    Register : Struct.Ptr
    Width : UInt32
    Numerator : Int64
    Denominator : Int64
    Accuracy : UInt32
}
struct KSRTAUDIO_HWREGISTER32 {
    Register : UInt32
    Width : UInt32
    Numerator : Int64
    Denominator : Int64
    Accuracy : UInt32
}
struct KSRTAUDIO_NOTIFICATION_EVENT_PROPERTY {
    Property : KSIDENTIFIER
    NotificationEvent : HANDLE
}
struct KSRTAUDIO_NOTIFICATION_EVENT_PROPERTY32 {
    Property : KSIDENTIFIER
    NotificationEvent : UInt32
}
struct KSRTAUDIO_GETREADPACKET_INFO {
    PacketNumber : UInt32
    Flags : UInt32
    PerformanceCounterValue : Int64
    MoreData : BOOL
}
struct KSRTAUDIO_SETWRITEPACKET_INFO {
    PacketNumber : UInt32
    Flags : UInt32
    EosPacketLength : UInt32
}
struct KSRTAUDIO_PACKETVREGISTER_PROPERTY {
    Property : KSIDENTIFIER
    BaseAddress : Struct.Ptr
}
struct KSRTAUDIO_PACKETVREGISTER {
    CompletedPacketCount : Int64.Ptr
    CompletedPacketQPC : Int64.Ptr
    CompletedPacketHash : Int64.Ptr
}
struct KSPROPERTY_BTAUDIO extends Int32 {
    static KSPROPERTY_ONESHOT_RECONNECT := 0
    static KSPROPERTY_ONESHOT_DISCONNECT := 1
}
struct KSPROPERTY_DRMAUDIOSTREAM extends Int32 {
    static KSPROPERTY_DRMAUDIOSTREAM_CONTENTID := 0
}
struct KSPROPERTY_INTERLEAVEDAUDIO extends Int32 {
    static KSPROPERTY_INTERLEAVEDAUDIO_FORMATINFORMATION := 1
}
struct INTERLEAVED_AUDIO_FORMAT_INFORMATION {
    Size : UInt32
    PrimaryChannelCount : UInt32
    PrimaryChannelStartPosition : UInt32
    PrimaryChannelMask : UInt32
    InterleavedChannelCount : UInt32
    InterleavedChannelStartPosition : UInt32
    InterleavedChannelMask : UInt32
}
struct KSSOUNDDETECTORPROPERTY {
    Property : KSIDENTIFIER
    EventId : GUID
}
struct KSPROPERTY_SOUNDDETECTOR extends Int32 {
    static KSPROPERTY_SOUNDDETECTOR_SUPPORTEDPATTERNS := 1
    static KSPROPERTY_SOUNDDETECTOR_PATTERNS := 2
    static KSPROPERTY_SOUNDDETECTOR_ARMED := 3
    static KSPROPERTY_SOUNDDETECTOR_MATCHRESULT := 4
    static KSPROPERTY_SOUNDDETECTOR_RESET := 5
    static KSPROPERTY_SOUNDDETECTOR_STREAMINGSUPPORT := 6
}
struct SOUNDDETECTOR_PATTERNHEADER {
    Size : UInt32
    PatternType : GUID
}
struct KSEVENT_SOUNDDETECTOR extends Int32 {
    static KSEVENT_SOUNDDETECTOR_MATCHDETECTED := 1
}
struct KSPROPERTY_AUDIO extends Int32 {
    static KSPROPERTY_AUDIO_LATENCY := 1
    static KSPROPERTY_AUDIO_COPY_PROTECTION := 2
    static KSPROPERTY_AUDIO_CHANNEL_CONFIG := 3
    static KSPROPERTY_AUDIO_VOLUMELEVEL := 4
    static KSPROPERTY_AUDIO_POSITION := 5
    static KSPROPERTY_AUDIO_DYNAMIC_RANGE := 6
    static KSPROPERTY_AUDIO_QUALITY := 7
    static KSPROPERTY_AUDIO_SAMPLING_RATE := 8
    static KSPROPERTY_AUDIO_DYNAMIC_SAMPLING_RATE := 9
    static KSPROPERTY_AUDIO_MIX_LEVEL_TABLE := 10
    static KSPROPERTY_AUDIO_MIX_LEVEL_CAPS := 11
    static KSPROPERTY_AUDIO_MUX_SOURCE := 12
    static KSPROPERTY_AUDIO_MUTE := 13
    static KSPROPERTY_AUDIO_BASS := 14
    static KSPROPERTY_AUDIO_MID := 15
    static KSPROPERTY_AUDIO_TREBLE := 16
    static KSPROPERTY_AUDIO_BASS_BOOST := 17
    static KSPROPERTY_AUDIO_EQ_LEVEL := 18
    static KSPROPERTY_AUDIO_NUM_EQ_BANDS := 19
    static KSPROPERTY_AUDIO_EQ_BANDS := 20
    static KSPROPERTY_AUDIO_AGC := 21
    static KSPROPERTY_AUDIO_DELAY := 22
    static KSPROPERTY_AUDIO_LOUDNESS := 23
    static KSPROPERTY_AUDIO_WIDE_MODE := 24
    static KSPROPERTY_AUDIO_WIDENESS := 25
    static KSPROPERTY_AUDIO_REVERB_LEVEL := 26
    static KSPROPERTY_AUDIO_CHORUS_LEVEL := 27
    static KSPROPERTY_AUDIO_DEV_SPECIFIC := 28
    static KSPROPERTY_AUDIO_DEMUX_DEST := 29
    static KSPROPERTY_AUDIO_STEREO_ENHANCE := 30
    static KSPROPERTY_AUDIO_MANUFACTURE_GUID := 31
    static KSPROPERTY_AUDIO_PRODUCT_GUID := 32
    static KSPROPERTY_AUDIO_CPU_RESOURCES := 33
    static KSPROPERTY_AUDIO_STEREO_SPEAKER_GEOMETRY := 34
    static KSPROPERTY_AUDIO_SURROUND_ENCODE := 35
    static KSPROPERTY_AUDIO_3D_INTERFACE := 36
    static KSPROPERTY_AUDIO_PEAKMETER := 37
    static KSPROPERTY_AUDIO_ALGORITHM_INSTANCE := 38
    static KSPROPERTY_AUDIO_FILTER_STATE := 39
    static KSPROPERTY_AUDIO_PREFERRED_STATUS := 40
    static KSPROPERTY_AUDIO_PEQ_MAX_BANDS := 41
    static KSPROPERTY_AUDIO_PEQ_NUM_BANDS := 42
    static KSPROPERTY_AUDIO_PEQ_BAND_CENTER_FREQ := 43
    static KSPROPERTY_AUDIO_PEQ_BAND_Q_FACTOR := 44
    static KSPROPERTY_AUDIO_PEQ_BAND_LEVEL := 45
    static KSPROPERTY_AUDIO_CHORUS_MODULATION_RATE := 46
    static KSPROPERTY_AUDIO_CHORUS_MODULATION_DEPTH := 47
    static KSPROPERTY_AUDIO_REVERB_TIME := 48
    static KSPROPERTY_AUDIO_REVERB_DELAY_FEEDBACK := 49
    static KSPROPERTY_AUDIO_POSITIONEX := 50
    static KSPROPERTY_AUDIO_MIC_ARRAY_GEOMETRY := 51
    static KSPROPERTY_AUDIO_PRESENTATION_POSITION := 52
    static KSPROPERTY_AUDIO_WAVERT_CURRENT_WRITE_POSITION := 53
    static KSPROPERTY_AUDIO_LINEAR_BUFFER_POSITION := 54
    static KSPROPERTY_AUDIO_PEAKMETER2 := 55
    static KSPROPERTY_AUDIO_WAVERT_CURRENT_WRITE_LASTBUFFER_POSITION := 56
    static KSPROPERTY_AUDIO_VOLUMELIMIT_ENGAGED := 57
    static KSPROPERTY_AUDIO_MIC_SENSITIVITY := 58
    static KSPROPERTY_AUDIO_MIC_SNR := 59
    static KSPROPERTY_AUDIO_MIC_SENSITIVITY2 := 60
}
struct KSAUDIO_COPY_PROTECTION {
    fCopyrighted : BOOL
    fOriginal : BOOL
}
struct KSAUDIO_CHANNEL_CONFIG {
    ActiveSpeakerPositions : Int32
}
struct KSAUDIO_DYNAMIC_RANGE {
    QuietCompression : UInt32
    LoudCompression : UInt32
}
struct KSAUDIO_MIXLEVEL {
    Mute : BOOL
    Level : Int32
}
struct KSAUDIO_MIX_CAPS {
    Mute : BOOL
    Minimum : Int32
    Maximum : Int32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Reset : Int32
            Resolution : Int32
        }
    }
}
struct KSAUDIO_MIXCAP_TABLE {
    InputChannels : UInt32
    OutputChannels : UInt32
    Capabilities : KSAUDIO_MIX_CAPS[1]
}
struct KSAUDIO_POSITIONEX {
    TimerFrequency : Int64
    TimeStamp1 : Int64
    Position : KSAUDIO_POSITION
    TimeStamp2 : Int64
}
struct KSPROPERTY_TELEPHONY_CONTROL extends Int32 {
    static KSPROPERTY_TELEPHONY_PROVIDERID := 0
    static KSPROPERTY_TELEPHONY_CALLINFO := 1
    static KSPROPERTY_TELEPHONY_CALLCONTROL := 2
    static KSPROPERTY_TELEPHONY_PROVIDERCHANGE := 3
    static KSPROPERTY_TELEPHONY_CALLHOLD := 4
    static KSPROPERTY_TELEPHONY_MUTE_TX := 5
}
struct TELEPHONY_CALLTYPE extends Int32 {
    static TELEPHONY_CALLTYPE_CIRCUITSWITCHED := 0
    static TELEPHONY_CALLTYPE_PACKETSWITCHED_LTE := 1
    static TELEPHONY_CALLTYPE_PACKETSWITCHED_WLAN := 2
}
struct TELEPHONY_CALLCONTROLOP extends Int32 {
    static TELEPHONY_CALLCONTROLOP_DISABLE := 0
    static TELEPHONY_CALLCONTROLOP_ENABLE := 1
}
struct KSTELEPHONY_CALLCONTROL {
    CallType : TELEPHONY_CALLTYPE
    CallControlOp : TELEPHONY_CALLCONTROLOP
}
struct TELEPHONY_PROVIDERCHANGEOP extends Int32 {
    static TELEPHONY_PROVIDERCHANGEOP_END := 0
    static TELEPHONY_PROVIDERCHANGEOP_BEGIN := 1
    static TELEPHONY_PROVIDERCHANGEOP_CANCEL := 2
}
struct KSTELEPHONY_PROVIDERCHANGE {
    CallType : TELEPHONY_CALLTYPE
    ProviderChangeOp : TELEPHONY_PROVIDERCHANGEOP
}
struct TELEPHONY_CALLSTATE extends Int32 {
    static TELEPHONY_CALLSTATE_DISABLED := 0
    static TELEPHONY_CALLSTATE_ENABLED := 1
    static TELEPHONY_CALLSTATE_HOLD := 2
    static TELEPHONY_CALLSTATE_PROVIDERTRANSITION := 3
}
struct KSTELEPHONY_CALLINFO {
    CallType : TELEPHONY_CALLTYPE
    CallState : TELEPHONY_CALLSTATE
}
struct KSPROPERTY_TELEPHONY_TOPOLOGY extends Int32 {
    static KSPROPERTY_TELEPHONY_ENDPOINTIDPAIR := 0
    static KSPROPERTY_TELEPHONY_VOLUME := 1
}
struct KSTOPOLOGY_ENDPOINTID {
    TopologyName : UInt16[260]
    PinId : UInt32
}
struct KSTOPOLOGY_ENDPOINTIDPAIR {
    RenderEndpoint : KSTOPOLOGY_ENDPOINTID
    CaptureEndpoint : KSTOPOLOGY_ENDPOINTID
}
struct KSPROPERTY_FMRX_TOPOLOGY extends Int32 {
    static KSPROPERTY_FMRX_ENDPOINTID := 0
    static KSPROPERTY_FMRX_VOLUME := 1
    static KSPROPERTY_FMRX_ANTENNAENDPOINTID := 2
}
struct KSPROPERTY_FMRX_CONTROL extends Int32 {
    static KSPROPERTY_FMRX_STATE := 0
}
struct KSEVENT_TELEPHONY extends Int32 {
    static KSEVENT_TELEPHONY_ENDPOINTPAIRS_CHANGED := 0
}
struct KSMETHOD_WAVETABLE extends Int32 {
    static KSMETHOD_WAVETABLE_WAVE_ALLOC := 0
    static KSMETHOD_WAVETABLE_WAVE_FREE := 1
    static KSMETHOD_WAVETABLE_WAVE_FIND := 2
    static KSMETHOD_WAVETABLE_WAVE_WRITE := 3
}
struct KSWAVETABLE_WAVE_DESC {
    Identifier : KSIDENTIFIER
    Size : UInt32
    Looped : BOOL
    LoopPoint : UInt32
    InROM : BOOL
    Format : KSDATAFORMAT
}
struct KSPROPERTY_WAVE extends Int32 {
    static KSPROPERTY_WAVE_COMPATIBLE_CAPABILITIES := 0
    static KSPROPERTY_WAVE_INPUT_CAPABILITIES := 1
    static KSPROPERTY_WAVE_OUTPUT_CAPABILITIES := 2
    static KSPROPERTY_WAVE_BUFFER := 3
    static KSPROPERTY_WAVE_FREQUENCY := 4
    static KSPROPERTY_WAVE_VOLUME := 5
    static KSPROPERTY_WAVE_PAN := 6
}
struct KSWAVE_COMPATCAPS {
    ulDeviceType : UInt32
}
struct KSWAVE_INPUT_CAPABILITIES {
    MaximumChannelsPerConnection : UInt32
    MinimumBitsPerSample : UInt32
    MaximumBitsPerSample : UInt32
    MinimumSampleFrequency : UInt32
    MaximumSampleFrequency : UInt32
    TotalConnections : UInt32
    ActiveConnections : UInt32
}
struct KSWAVE_OUTPUT_CAPABILITIES {
    MaximumChannelsPerConnection : UInt32
    MinimumBitsPerSample : UInt32
    MaximumBitsPerSample : UInt32
    MinimumSampleFrequency : UInt32
    MaximumSampleFrequency : UInt32
    TotalConnections : UInt32
    StaticConnections : UInt32
    StreamingConnections : UInt32
    ActiveConnections : UInt32
    ActiveStaticConnections : UInt32
    ActiveStreamingConnections : UInt32
    Total3DConnections : UInt32
    Static3DConnections : UInt32
    Streaming3DConnections : UInt32
    Active3DConnections : UInt32
    ActiveStatic3DConnections : UInt32
    ActiveStreaming3DConnections : UInt32
    TotalSampleMemory : UInt32
    FreeSampleMemory : UInt32
    LargestFreeContiguousSampleMemory : UInt32
}
struct KSWAVE_VOLUME {
    LeftAttenuation : Int32
    RightAttenuation : Int32
}
struct KSWAVE_BUFFER {
    Attributes : UInt32
    BufferSize : UInt32
    BufferAddress : Struct.Ptr
}
struct KSDATARANGE_MUSIC {
    DataRange : KSDATAFORMAT
    Technology : GUID
    Channels : UInt32
    Notes : UInt32
    ChannelMask : UInt32
}
struct KSPROPERTY_CYCLIC extends Int32 {
    static KSPROPERTY_CYCLIC_POSITION := 0
}
struct KSEVENT_AUDIO_CONTROL_CHANGE extends Int32 {
    static KSEVENT_CONTROL_CHANGE := 0
}
struct KSEVENT_LOOPEDSTREAMING extends Int32 {
    static KSEVENT_LOOPEDSTREAMING_POSITION := 0
}
struct LOOPEDSTREAMING_POSITION_EVENT_DATA {
    KsEventData : KSEVENTDATA
    Position : Int64
}
struct KSNODEPROPERTY {
    Property : KSIDENTIFIER
    NodeId : UInt32
    Reserved : UInt32
}
struct KSNODEPROPERTY_AUDIO_CHANNEL {
    NodeProperty : KSNODEPROPERTY
    Channel : Int32
    Reserved : UInt32
}
struct KSNODEPROPERTY_AUDIO_DEV_SPECIFIC {
    NodeProperty : KSNODEPROPERTY
    DevSpecificId : UInt32
    DeviceInfo : UInt32
    Length : UInt32
}
struct KSPROPERTY_MIDILOOPEDSTREAMING extends Int32 {
    static KSPROPERTY_MIDILOOPEDSTREAMING_BUFFER := 0
    static KSPROPERTY_MIDILOOPEDSTREAMING_REGISTERS := 1
    static KSPROPERTY_MIDILOOPEDSTREAMING_NOTIFICATION_EVENT := 2
}
struct KSMIDILOOPED_BUFFER {
    BufferAddress : Struct.Ptr
    ActualBufferSize : UInt32
}
struct KSMIDILOOPED_REGISTERS {
    WritePosition : Struct.Ptr
    ReadPosition : Struct.Ptr
}
struct KSMIDILOOPED_EVENT {
    WriteEvent : HANDLE
}
struct KSMIDILOOPED_EVENT2 {
    WriteEvent : HANDLE
    ReadEvent : HANDLE
}
struct KSMIDILOOPED_BUFFER_PROPERTY {
    Property : KSIDENTIFIER
    RequestedBufferSize : UInt32
}
struct UMPDATAFORMAT {
    Position : Int64
    ByteCount : UInt32
}
struct KSMUSICFORMAT {
    TimeDeltaMs : UInt32
    ByteCount : UInt32
}
struct KSPROPERTY_MPEG2VID extends Int32 {
    static KSPROPERTY_MPEG2VID_MODES := 0
    static KSPROPERTY_MPEG2VID_CUR_MODE := 1
    static KSPROPERTY_MPEG2VID_4_3_RECT := 2
    static KSPROPERTY_MPEG2VID_16_9_RECT := 3
    static KSPROPERTY_MPEG2VID_16_9_PANSCAN := 4
}
struct KSMPEGVID_RECT {
    StartX : UInt32
    StartY : UInt32
    EndX : UInt32
    EndY : UInt32
}
struct KSPROPERTY_AC3 extends Int32 {
    static KSPROPERTY_AC3_ERROR_CONCEALMENT := 1
    static KSPROPERTY_AC3_ALTERNATE_AUDIO := 2
    static KSPROPERTY_AC3_DOWNMIX := 3
    static KSPROPERTY_AC3_BIT_STREAM_MODE := 4
    static KSPROPERTY_AC3_DIALOGUE_LEVEL := 5
    static KSPROPERTY_AC3_LANGUAGE_CODE := 6
    static KSPROPERTY_AC3_ROOM_TYPE := 7
}
struct KSAC3_ERROR_CONCEALMENT {
    fRepeatPreviousBlock : BOOL
    fErrorInCurrentBlock : BOOL
}
struct KSAC3_ALTERNATE_AUDIO {
    fStereo : BOOL
    DualMode : UInt32
}
struct KSAC3_DOWNMIX {
    fDownMix : BOOL
    fDolbySurround : BOOL
}
struct KSAC3_BIT_STREAM_MODE {
    BitStreamMode : Int32
}
struct KSAC3_DIALOGUE_LEVEL {
    DialogueLevel : UInt32
}
struct KSAC3_ROOM_TYPE {
    fLargeRoom : BOOL
}
struct KSPROPERTY_AUDDECOUT extends Int32 {
    static KSPROPERTY_AUDDECOUT_MODES := 0
    static KSPROPERTY_AUDDECOUT_CUR_MODE := 1
}
struct KSPROPERTY_DVDSUBPIC extends Int32 {
    static KSPROPERTY_DVDSUBPIC_PALETTE := 0
    static KSPROPERTY_DVDSUBPIC_HLI := 1
    static KSPROPERTY_DVDSUBPIC_COMPOSIT_ON := 2
}
struct KS_DVD_YCrCb {
    Reserved : UInt8
    Y : UInt8
    Cr : UInt8
    Cb : UInt8
}
struct KS_DVD_YUV {
    Reserved : UInt8
    Y : UInt8
    V : UInt8
    U : UInt8
}
struct KSPROPERTY_SPPAL {
    sppal : KS_DVD_YUV[16]
}
struct KS_COLCON {
    _bitfield1 : UInt8
    _bitfield2 : UInt8
    _bitfield3 : UInt8
    _bitfield4 : UInt8
}
struct KSPROPERTY_SPHLI {
    HLISS : UInt16
    Reserved : UInt16
    StartPTM : UInt32
    EndPTM : UInt32
    StartX : UInt16
    StartY : UInt16
    StopX : UInt16
    StopY : UInt16
    ColCon : KS_COLCON
}
struct KSPROPERTY_COPYPROT extends Int32 {
    static KSPROPERTY_DVDCOPY_CHLG_KEY := 1
    static KSPROPERTY_DVDCOPY_DVD_KEY1 := 2
    static KSPROPERTY_DVDCOPY_DEC_KEY2 := 3
    static KSPROPERTY_DVDCOPY_TITLE_KEY := 4
    static KSPROPERTY_COPY_MACROVISION := 5
    static KSPROPERTY_DVDCOPY_REGION := 6
    static KSPROPERTY_DVDCOPY_SET_COPY_STATE := 7
    static KSPROPERTY_DVDCOPY_DISC_KEY := 128
}
struct KS_DVDCOPY_CHLGKEY {
    ChlgKey : UInt8[10]
    Reserved : UInt8[2]
}
struct KS_DVDCOPY_BUSKEY {
    BusKey : UInt8[5]
    Reserved : UInt8[1]
}
struct KS_DVDCOPY_DISCKEY {
    DiscKey : UInt8[2048]
}
struct KS_DVDCOPY_REGION {
    Reserved : UInt8
    RegionData : UInt8
    Reserved2 : UInt8[2]
}
struct KS_DVDCOPY_TITLEKEY {
    KeyFlags : UInt32
    ReservedNT : UInt32[2]
    TitleKey : UInt8[6]
    Reserved : UInt8[2]
}
struct KS_COPY_MACROVISION {
    MACROVISIONLevel : UInt32
}
struct KS_DVDCOPY_SET_COPY_STATE {
    DVDCopyState : UInt32
}
struct KS_DVDCOPYSTATE extends Int32 {
    static KS_DVDCOPYSTATE_INITIALIZE := 0
    static KS_DVDCOPYSTATE_INITIALIZE_TITLE := 1
    static KS_DVDCOPYSTATE_AUTHENTICATION_NOT_REQUIRED := 2
    static KS_DVDCOPYSTATE_AUTHENTICATION_REQUIRED := 3
    static KS_DVDCOPYSTATE_DONE := 4
}
struct KS_COPY_MACROVISION_LEVEL extends Int32 {
    static KS_MACROVISION_DISABLED := 0
    static KS_MACROVISION_LEVEL1 := 1
    static KS_MACROVISION_LEVEL2 := 2
    static KS_MACROVISION_LEVEL3 := 3
}
struct KS_RGBQUAD {
    rgbBlue : UInt8
    rgbGreen : UInt8
    rgbRed : UInt8
    rgbReserved : UInt8
}
struct KS_BITMAPINFOHEADER {
    biSize : UInt32
    biWidth : Int32
    biHeight : Int32
    biPlanes : UInt16
    biBitCount : UInt16
    biCompression : UInt32
    biSizeImage : UInt32
    biXPelsPerMeter : Int32
    biYPelsPerMeter : Int32
    biClrUsed : UInt32
    biClrImportant : UInt32
}
struct KS_TRUECOLORINFO {
    dwBitMasks : UInt32[3]
    bmiColors : KS_RGBQUAD[256]
}
struct KS_VIDEOINFOHEADER {
    rcSource : RECT
    rcTarget : RECT
    dwBitRate : UInt32
    dwBitErrorRate : UInt32
    AvgTimePerFrame : Int64
    bmiHeader : KS_BITMAPINFOHEADER
}
struct KS_VIDEOINFO {
    rcSource : RECT
    rcTarget : RECT
    dwBitRate : UInt32
    dwBitErrorRate : UInt32
    AvgTimePerFrame : Int64
    bmiHeader : KS_BITMAPINFOHEADER
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            bmiColors : KS_RGBQUAD[256]
            dwBitMasks : UInt32[3]
            TrueColorInfo : KS_TRUECOLORINFO
        }
    }
}
struct KS_VBIINFOHEADER {
    StartLine : UInt32
    EndLine : UInt32
    SamplingFrequency : UInt32
    MinLineStartTime : UInt32
    MaxLineStartTime : UInt32
    ActualLineStartTime : UInt32
    ActualLineEndTime : UInt32
    VideoStandard : UInt32
    SamplesPerLine : UInt32
    StrideInBytes : UInt32
    BufferSize : UInt32
}
struct KS_ANALOGVIDEOINFO {
    rcSource : RECT
    rcTarget : RECT
    dwActiveWidth : UInt32
    dwActiveHeight : UInt32
    AvgTimePerFrame : Int64
}
struct KS_TVTUNER_CHANGE_INFO {
    dwFlags : UInt32
    dwCountryCode : UInt32
    dwAnalogVideoStandard : UInt32
    dwChannel : UInt32
}
struct KS_MPEG2Level extends Int32 {
    static KS_MPEG2Level_Low := 0
    static KS_MPEG2Level_Main := 1
    static KS_MPEG2Level_High1440 := 2
    static KS_MPEG2Level_High := 3
}
struct KS_MPEG2Profile extends Int32 {
    static KS_MPEG2Profile_Simple := 0
    static KS_MPEG2Profile_Main := 1
    static KS_MPEG2Profile_SNRScalable := 2
    static KS_MPEG2Profile_SpatiallyScalable := 3
    static KS_MPEG2Profile_High := 4
}
struct KS_VIDEOINFOHEADER2 {
    rcSource : RECT
    rcTarget : RECT
    dwBitRate : UInt32
    dwBitErrorRate : UInt32
    AvgTimePerFrame : Int64
    dwInterlaceFlags : UInt32
    dwCopyProtectFlags : UInt32
    dwPictAspectRatioX : UInt32
    dwPictAspectRatioY : UInt32
    Anonymous : this._Anonymous_e__Union
    dwReserved2 : UInt32
    bmiHeader : KS_BITMAPINFOHEADER
    struct _Anonymous_e__Union {
        union {
            dwControlFlags : UInt32
            dwReserved1 : UInt32
        }
    }
}
struct KS_MPEG1VIDEOINFO {
    hdr : KS_VIDEOINFOHEADER
    dwStartTimeCode : UInt32
    cbSequenceHeader : UInt32
    bSequenceHeader : UInt8[1]
}
struct KS_MPEGVIDEOINFO2 {
    hdr : KS_VIDEOINFOHEADER2
    dwStartTimeCode : UInt32
    cbSequenceHeader : UInt32
    dwProfile : UInt32
    dwLevel : UInt32
    dwFlags : UInt32
    bSequenceHeader : UInt32[1]
}
struct KS_H264VIDEOINFO {
    wWidth : UInt16
    wHeight : UInt16
    wSARwidth : UInt16
    wSARheight : UInt16
    wProfile : UInt16
    bLevelIDC : UInt8
    wConstrainedToolset : UInt16
    bmSupportedUsages : UInt32
    bmCapabilities : UInt16
    bmSVCCapabilities : UInt32
    bmMVCCapabilities : UInt32
    dwFrameInterval : UInt32
    bMaxCodecConfigDelay : UInt8
    bmSupportedSliceModes : UInt8
    bmSupportedSyncFrameTypes : UInt8
    bResolutionScaling : UInt8
    bSimulcastSupport : UInt8
    bmSupportedRateControlModes : UInt8
    wMaxMBperSecOneResolutionNoScalability : UInt16
    wMaxMBperSecTwoResolutionsNoScalability : UInt16
    wMaxMBperSecThreeResolutionsNoScalability : UInt16
    wMaxMBperSecFourResolutionsNoScalability : UInt16
    wMaxMBperSecOneResolutionTemporalScalability : UInt16
    wMaxMBperSecTwoResolutionsTemporalScalablility : UInt16
    wMaxMBperSecThreeResolutionsTemporalScalability : UInt16
    wMaxMBperSecFourResolutionsTemporalScalability : UInt16
    wMaxMBperSecOneResolutionTemporalQualityScalability : UInt16
    wMaxMBperSecTwoResolutionsTemporalQualityScalability : UInt16
    wMaxMBperSecThreeResolutionsTemporalQualityScalablity : UInt16
    wMaxMBperSecFourResolutionsTemporalQualityScalability : UInt16
    wMaxMBperSecOneResolutionTemporalSpatialScalability : UInt16
    wMaxMBperSecTwoResolutionsTemporalSpatialScalability : UInt16
    wMaxMBperSecThreeResolutionsTemporalSpatialScalablity : UInt16
    wMaxMBperSecFourResolutionsTemporalSpatialScalability : UInt16
    wMaxMBperSecOneResolutionFullScalability : UInt16
    wMaxMBperSecTwoResolutionsFullScalability : UInt16
    wMaxMBperSecThreeResolutionsFullScalability : UInt16
    wMaxMBperSecFourResolutionsFullScalability : UInt16
}
struct KS_MPEGAUDIOINFO {
    dwFlags : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwReserved3 : UInt32
}
struct KS_DATAFORMAT_VIDEOINFOHEADER {
    DataFormat : KSDATAFORMAT
    VideoInfoHeader : KS_VIDEOINFOHEADER
}
struct KS_DATAFORMAT_VIDEOINFOHEADER2 {
    DataFormat : KSDATAFORMAT
    VideoInfoHeader2 : KS_VIDEOINFOHEADER2
}
struct KS_DATAFORMAT_MPEGVIDEOINFO2 {
    DataFormat : KSDATAFORMAT
    MpegVideoInfoHeader2 : KS_MPEGVIDEOINFO2
}
struct KS_DATAFORMAT_H264VIDEOINFO {
    DataFormat : KSDATAFORMAT
    H264VideoInfoHeader : KS_H264VIDEOINFO
}
struct KS_DATAFORMAT_IMAGEINFO {
    DataFormat : KSDATAFORMAT
    ImageInfoHeader : KS_BITMAPINFOHEADER
}
struct KS_DATAFORMAT_VIDEOINFO_PALETTE {
    DataFormat : KSDATAFORMAT
    VideoInfo : KS_VIDEOINFO
}
struct KS_DATAFORMAT_VBIINFOHEADER {
    DataFormat : KSDATAFORMAT
    VBIInfoHeader : KS_VBIINFOHEADER
}
struct KS_VIDEO_STREAM_CONFIG_CAPS {
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
struct KS_DATARANGE_VIDEO {
    DataRange : KSDATAFORMAT
    bFixedSizeSamples : BOOL
    bTemporalCompression : BOOL
    StreamDescriptionFlags : UInt32
    MemoryAllocationFlags : UInt32
    ConfigCaps : KS_VIDEO_STREAM_CONFIG_CAPS
    VideoInfoHeader : KS_VIDEOINFOHEADER
}
struct KS_DATARANGE_VIDEO2 {
    DataRange : KSDATAFORMAT
    bFixedSizeSamples : BOOL
    bTemporalCompression : BOOL
    StreamDescriptionFlags : UInt32
    MemoryAllocationFlags : UInt32
    ConfigCaps : KS_VIDEO_STREAM_CONFIG_CAPS
    VideoInfoHeader : KS_VIDEOINFOHEADER2
}
struct KS_DATARANGE_MPEG1_VIDEO {
    DataRange : KSDATAFORMAT
    bFixedSizeSamples : BOOL
    bTemporalCompression : BOOL
    StreamDescriptionFlags : UInt32
    MemoryAllocationFlags : UInt32
    ConfigCaps : KS_VIDEO_STREAM_CONFIG_CAPS
    VideoInfoHeader : KS_MPEG1VIDEOINFO
}
struct KS_DATARANGE_MPEG2_VIDEO {
    DataRange : KSDATAFORMAT
    bFixedSizeSamples : BOOL
    bTemporalCompression : BOOL
    StreamDescriptionFlags : UInt32
    MemoryAllocationFlags : UInt32
    ConfigCaps : KS_VIDEO_STREAM_CONFIG_CAPS
    VideoInfoHeader : KS_MPEGVIDEOINFO2
}
struct KS_DATARANGE_H264_VIDEO {
    DataRange : KSDATAFORMAT
    bFixedSizeSamples : BOOL
    bTemporalCompression : BOOL
    StreamDescriptionFlags : UInt32
    MemoryAllocationFlags : UInt32
    ConfigCaps : KS_VIDEO_STREAM_CONFIG_CAPS
    VideoInfoHeader : KS_H264VIDEOINFO
}
struct KS_DATARANGE_IMAGE {
    DataRange : KSDATAFORMAT
    ConfigCaps : KS_VIDEO_STREAM_CONFIG_CAPS
    ImageInfoHeader : KS_BITMAPINFOHEADER
}
struct KS_DATARANGE_VIDEO_PALETTE {
    DataRange : KSDATAFORMAT
    bFixedSizeSamples : BOOL
    bTemporalCompression : BOOL
    StreamDescriptionFlags : UInt32
    MemoryAllocationFlags : UInt32
    ConfigCaps : KS_VIDEO_STREAM_CONFIG_CAPS
    VideoInfo : KS_VIDEOINFO
}
struct KS_DATARANGE_VIDEO_VBI {
    DataRange : KSDATAFORMAT
    bFixedSizeSamples : BOOL
    bTemporalCompression : BOOL
    StreamDescriptionFlags : UInt32
    MemoryAllocationFlags : UInt32
    ConfigCaps : KS_VIDEO_STREAM_CONFIG_CAPS
    VBIInfoHeader : KS_VBIINFOHEADER
}
struct KS_DATARANGE_ANALOGVIDEO {
    DataRange : KSDATAFORMAT
    AnalogVideoInfo : KS_ANALOGVIDEOINFO
}
struct KSPROPERTY_VBICAP extends Int32 {
    static KSPROPERTY_VBICAP_PROPERTIES_PROTECTION := 1
}
struct VBICAP_PROPERTIES_PROTECTION_S {
    Property : KSIDENTIFIER
    StreamIndex : UInt32
    Status : UInt32
}
struct NABTSFEC_BUFFER {
    dataSize : UInt32
    groupID : UInt16
    Reserved : UInt16
    data : UInt8[448]
}
struct KSPROPERTY_VBICODECFILTERING extends Int32 {
    static KSPROPERTY_VBICODECFILTERING_SCANLINES_REQUESTED_BIT_ARRAY := 1
    static KSPROPERTY_VBICODECFILTERING_SCANLINES_DISCOVERED_BIT_ARRAY := 2
    static KSPROPERTY_VBICODECFILTERING_SUBSTREAMS_REQUESTED_BIT_ARRAY := 3
    static KSPROPERTY_VBICODECFILTERING_SUBSTREAMS_DISCOVERED_BIT_ARRAY := 4
    static KSPROPERTY_VBICODECFILTERING_STATISTICS := 5
}
struct VBICODECFILTERING_SCANLINES {
    DwordBitArray : UInt32[32]
}
struct VBICODECFILTERING_NABTS_SUBSTREAMS {
    SubstreamMask : UInt32[128]
}
struct VBICODECFILTERING_CC_SUBSTREAMS {
    SubstreamMask : UInt32
}
struct CC_BYTE_PAIR {
    Decoded : UInt8[2]
    Reserved : UInt16
}
struct CC_HW_FIELD {
    ScanlinesRequested : VBICODECFILTERING_SCANLINES
    fieldFlags : UInt32
    PictureNumber : Int64
    Lines : CC_BYTE_PAIR[12]
}
struct NABTS_BUFFER_LINE {
    Confidence : UInt8
    Bytes : UInt8[36]
}
struct NABTS_BUFFER {
    ScanlinesRequested : VBICODECFILTERING_SCANLINES
    PictureNumber : Int64
    NabtsLines : NABTS_BUFFER_LINE[11]
}
struct WST_BUFFER_LINE {
    Confidence : UInt8
    Bytes : UInt8[42]
}
struct WST_BUFFER {
    ScanlinesRequested : VBICODECFILTERING_SCANLINES
    WstLines : WST_BUFFER_LINE[17]
}
struct VBICODECFILTERING_STATISTICS_COMMON {
    InputSRBsProcessed : UInt32
    OutputSRBsProcessed : UInt32
    SRBsIgnored : UInt32
    InputSRBsMissing : UInt32
    OutputSRBsMissing : UInt32
    OutputFailures : UInt32
    InternalErrors : UInt32
    ExternalErrors : UInt32
    InputDiscontinuities : UInt32
    DSPFailures : UInt32
    TvTunerChanges : UInt32
    VBIHeaderChanges : UInt32
    LineConfidenceAvg : UInt32
    BytesOutput : UInt32
}
struct VBICODECFILTERING_STATISTICS_COMMON_PIN {
    SRBsProcessed : UInt32
    SRBsIgnored : UInt32
    SRBsMissing : UInt32
    InternalErrors : UInt32
    ExternalErrors : UInt32
    Discontinuities : UInt32
    LineConfidenceAvg : UInt32
    BytesOutput : UInt32
}
struct VBICODECFILTERING_STATISTICS_NABTS {
    Common : VBICODECFILTERING_STATISTICS_COMMON
    FECBundleBadLines : UInt32
    FECQueueOverflows : UInt32
    FECCorrectedLines : UInt32
    FECUncorrectableLines : UInt32
    BundlesProcessed : UInt32
    BundlesSent2IP : UInt32
    FilteredLines : UInt32
}
struct VBICODECFILTERING_STATISTICS_NABTS_PIN {
    Common : VBICODECFILTERING_STATISTICS_COMMON_PIN
}
struct VBICODECFILTERING_STATISTICS_CC {
    Common : VBICODECFILTERING_STATISTICS_COMMON
}
struct VBICODECFILTERING_STATISTICS_CC_PIN {
    Common : VBICODECFILTERING_STATISTICS_COMMON_PIN
}
struct VBICODECFILTERING_STATISTICS_TELETEXT {
    Common : VBICODECFILTERING_STATISTICS_COMMON
}
struct VBICODECFILTERING_STATISTICS_TELETEXT_PIN {
    Common : VBICODECFILTERING_STATISTICS_COMMON_PIN
}
struct KSPROPERTY_VBICODECFILTERING_SCANLINES_S {
    Property : KSIDENTIFIER
    Scanlines : VBICODECFILTERING_SCANLINES
}
struct KSPROPERTY_VBICODECFILTERING_NABTS_SUBSTREAMS_S {
    Property : KSIDENTIFIER
    Substreams : VBICODECFILTERING_NABTS_SUBSTREAMS
}
struct KSPROPERTY_VBICODECFILTERING_CC_SUBSTREAMS_S {
    Property : KSIDENTIFIER
    Substreams : VBICODECFILTERING_CC_SUBSTREAMS
}
struct KSPROPERTY_VBICODECFILTERING_STATISTICS_COMMON_S {
    Property : KSIDENTIFIER
    Statistics : VBICODECFILTERING_STATISTICS_COMMON
}
struct KSPROPERTY_VBICODECFILTERING_STATISTICS_COMMON_PIN_S {
    Property : KSIDENTIFIER
    Statistics : VBICODECFILTERING_STATISTICS_COMMON_PIN
}
struct KSPROPERTY_VBICODECFILTERING_STATISTICS_NABTS_S {
    Property : KSIDENTIFIER
    Statistics : VBICODECFILTERING_STATISTICS_NABTS
}
struct KSPROPERTY_VBICODECFILTERING_STATISTICS_NABTS_PIN_S {
    Property : KSIDENTIFIER
    Statistics : VBICODECFILTERING_STATISTICS_NABTS_PIN
}
struct KSPROPERTY_VBICODECFILTERING_STATISTICS_CC_S {
    Property : KSIDENTIFIER
    Statistics : VBICODECFILTERING_STATISTICS_CC
}
struct KSPROPERTY_VBICODECFILTERING_STATISTICS_CC_PIN_S {
    Property : KSIDENTIFIER
    Statistics : VBICODECFILTERING_STATISTICS_CC_PIN
}
struct CAPTURE_MEMORY_ALLOCATION_FLAGS extends Int32 {
    static KS_CAPTURE_ALLOC_INVALID := 0
    static KS_CAPTURE_ALLOC_SYSTEM := 1
    static KS_CAPTURE_ALLOC_VRAM := 2
    static KS_CAPTURE_ALLOC_SYSTEM_AGP := 4
    static KS_CAPTURE_ALLOC_VRAM_MAPPED := 8
    static KS_CAPTURE_ALLOC_SECURE_BUFFER := 16
}
struct KSPROPERTY_VIDMEM_TRANSPORT extends Int32 {
    static KSPROPERTY_DISPLAY_ADAPTER_GUID := 1
    static KSPROPERTY_PREFERRED_CAPTURE_SURFACE := 2
    static KSPROPERTY_CURRENT_CAPTURE_SURFACE := 3
    static KSPROPERTY_MAP_CAPTURE_HANDLE_TO_VRAM_ADDRESS := 4
}
struct VRAM_SURFACE_INFO {
    hSurface : IntPtr
    VramPhysicalAddress : Int64
    cbCaptured : UInt32
    dwWidth : UInt32
    dwHeight : UInt32
    dwLinearSize : UInt32
    lPitch : Int32
    ullReserved : Int64[16]
}
struct VRAM_SURFACE_INFO_PROPERTY_S {
    Property : KSIDENTIFIER
    pVramSurfaceInfo : VRAM_SURFACE_INFO.Ptr
}
struct SECURE_BUFFER_INFO {
    guidBufferIdentifier : GUID
    cbBufferSize : UInt32
    cbCaptured : UInt32
    ullReserved : Int64[16]
}
struct KSPROPERTY_MPEG4_MEDIATYPE_ATTRIBUTES extends Int32 {
    static KSPROPERTY_MPEG4_MEDIATYPE_SD_BOX := 1
}
struct KSEVENT_DYNAMICFORMATCHANGE extends Int32 {
    static KSEVENT_DYNAMIC_FORMAT_CHANGE := 0
}
struct VIDEOFORMAT_DX12 {
    Header : KSATTRIBUTE
    resourceLayout : UInt32
    resourceFlags : UInt32
    customLayout : GUID
}
struct KS_FRAME_INFO {
    ExtendedHeaderSize : UInt32
    dwFrameFlags : UInt32
    PictureNumber : Int64
    DropCount : Int64
    hDirectDraw : HANDLE
    hSurfaceHandle : HANDLE
    DirectDrawRect : RECT
    Anonymous1 : this._Anonymous1_e__Union
    Reserved2 : UInt32
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            lSurfacePitch : Int32
            Reserved1 : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            FrameCompletionNumber : Int64
        }
        struct _Anonymous_e__Struct {
            Reserved3 : UInt32
            Reserved4 : UInt32
        }
    }
}
struct KS_VBI_FRAME_INFO {
    ExtendedHeaderSize : UInt32
    dwFrameFlags : UInt32
    PictureNumber : Int64
    DropCount : Int64
    dwSamplingFrequency : UInt32
    TvTunerChangeInfo : KS_TVTUNER_CHANGE_INFO
    VBIInfoHeader : KS_VBIINFOHEADER
}
struct KS_AnalogVideoStandard extends Int32 {
    static KS_AnalogVideo_None := 0
    static KS_AnalogVideo_NTSC_M := 1
    static KS_AnalogVideo_NTSC_M_J := 2
    static KS_AnalogVideo_NTSC_433 := 4
    static KS_AnalogVideo_PAL_B := 16
    static KS_AnalogVideo_PAL_D := 32
    static KS_AnalogVideo_PAL_G := 64
    static KS_AnalogVideo_PAL_H := 128
    static KS_AnalogVideo_PAL_I := 256
    static KS_AnalogVideo_PAL_M := 512
    static KS_AnalogVideo_PAL_N := 1024
    static KS_AnalogVideo_PAL_60 := 2048
    static KS_AnalogVideo_SECAM_B := 4096
    static KS_AnalogVideo_SECAM_D := 8192
    static KS_AnalogVideo_SECAM_G := 16384
    static KS_AnalogVideo_SECAM_H := 32768
    static KS_AnalogVideo_SECAM_K := 65536
    static KS_AnalogVideo_SECAM_K1 := 131072
    static KS_AnalogVideo_SECAM_L := 262144
    static KS_AnalogVideo_SECAM_L1 := 524288
    static KS_AnalogVideo_PAL_N_COMBO := 1048576
}
struct KSPROPERTY_ALLOCATOR_CONTROL extends Int32 {
    static KSPROPERTY_ALLOCATOR_CONTROL_HONOR_COUNT := 0
    static KSPROPERTY_ALLOCATOR_CONTROL_SURFACE_SIZE := 1
    static KSPROPERTY_ALLOCATOR_CONTROL_CAPTURE_CAPS := 2
    static KSPROPERTY_ALLOCATOR_CONTROL_CAPTURE_INTERLEAVE := 3
}
struct KSPROPERTY_ALLOCATOR_CONTROL_SURFACE_SIZE_S {
    CX : UInt32
    CY : UInt32
}
struct KSPROPERTY_ALLOCATOR_CONTROL_CAPTURE_CAPS_S {
    InterleavedCapSupported : UInt32
}
struct KSPROPERTY_ALLOCATOR_CONTROL_CAPTURE_INTERLEAVE_S {
    InterleavedCapPossible : UInt32
}
struct KSPROPERTY_VIDCAP_VIDEOPROCAMP extends Int32 {
    static KSPROPERTY_VIDEOPROCAMP_BRIGHTNESS := 0
    static KSPROPERTY_VIDEOPROCAMP_CONTRAST := 1
    static KSPROPERTY_VIDEOPROCAMP_HUE := 2
    static KSPROPERTY_VIDEOPROCAMP_SATURATION := 3
    static KSPROPERTY_VIDEOPROCAMP_SHARPNESS := 4
    static KSPROPERTY_VIDEOPROCAMP_GAMMA := 5
    static KSPROPERTY_VIDEOPROCAMP_COLORENABLE := 6
    static KSPROPERTY_VIDEOPROCAMP_WHITEBALANCE := 7
    static KSPROPERTY_VIDEOPROCAMP_BACKLIGHT_COMPENSATION := 8
    static KSPROPERTY_VIDEOPROCAMP_GAIN := 9
    static KSPROPERTY_VIDEOPROCAMP_DIGITAL_MULTIPLIER := 10
    static KSPROPERTY_VIDEOPROCAMP_DIGITAL_MULTIPLIER_LIMIT := 11
    static KSPROPERTY_VIDEOPROCAMP_WHITEBALANCE_COMPONENT := 12
    static KSPROPERTY_VIDEOPROCAMP_POWERLINE_FREQUENCY := 13
}
struct KSPROPERTY_VIDEOPROCAMP_S {
    Property : KSIDENTIFIER
    Value : Int32
    Flags : UInt32
    Capabilities : UInt32
}
struct KSPROPERTY_VIDEOPROCAMP_NODE_S {
    NodeProperty : KSP_NODE
    Value : Int32
    Flags : UInt32
    Capabilities : UInt32
}
struct KSPROPERTY_VIDEOPROCAMP_S2 {
    Property : KSIDENTIFIER
    Value1 : Int32
    Flags : UInt32
    Capabilities : UInt32
    Value2 : Int32
}
struct KSPROPERTY_VIDEOPROCAMP_NODE_S2 {
    NodeProperty : KSP_NODE
    Value1 : Int32
    Flags : UInt32
    Capabilities : UInt32
    Value2 : Int32
}
struct KSPROPERTY_VIDCAP_SELECTOR extends Int32 {
    static KSPROPERTY_SELECTOR_SOURCE_NODE_ID := 0
    static KSPROPERTY_SELECTOR_NUM_SOURCES := 1
}
struct KSPROPERTY_SELECTOR_S {
    Property : KSIDENTIFIER
    Value : Int32
    Flags : UInt32
    Capabilities : UInt32
}
struct KSPROPERTY_SELECTOR_NODE_S {
    NodeProperty : KSP_NODE
    Value : Int32
    Flags : UInt32
    Capabilities : UInt32
}
struct KSPROPERTY_TUNER extends Int32 {
    static KSPROPERTY_TUNER_CAPS := 0
    static KSPROPERTY_TUNER_MODE_CAPS := 1
    static KSPROPERTY_TUNER_MODE := 2
    static KSPROPERTY_TUNER_STANDARD := 3
    static KSPROPERTY_TUNER_FREQUENCY := 4
    static KSPROPERTY_TUNER_INPUT := 5
    static KSPROPERTY_TUNER_STATUS := 6
    static KSPROPERTY_TUNER_IF_MEDIUM := 7
    static KSPROPERTY_TUNER_SCAN_CAPS := 8
    static KSPROPERTY_TUNER_SCAN_STATUS := 9
    static KSPROPERTY_TUNER_STANDARD_MODE := 10
    static KSPROPERTY_TUNER_NETWORKTYPE_SCAN_CAPS := 11
}
struct KSPROPERTY_TUNER_MODES extends Int32 {
    static KSPROPERTY_TUNER_MODE_TV := 1
    static KSPROPERTY_TUNER_MODE_FM_RADIO := 2
    static KSPROPERTY_TUNER_MODE_AM_RADIO := 4
    static KSPROPERTY_TUNER_MODE_DSS := 8
    static KSPROPERTY_TUNER_MODE_ATSC := 16
}
struct KS_TUNER_TUNING_FLAGS extends Int32 {
    static KS_TUNER_TUNING_EXACT := 1
    static KS_TUNER_TUNING_FINE := 2
    static KS_TUNER_TUNING_COARSE := 3
}
struct KS_TUNER_STRATEGY extends Int32 {
    static KS_TUNER_STRATEGY_PLL := 1
    static KS_TUNER_STRATEGY_SIGNAL_STRENGTH := 2
    static KS_TUNER_STRATEGY_DRIVER_TUNES := 4
}
struct KSPROPERTY_TUNER_CAPS_S {
    Property : KSIDENTIFIER
    ModesSupported : UInt32
    VideoMedium : KSIDENTIFIER
    TVAudioMedium : KSIDENTIFIER
    RadioAudioMedium : KSIDENTIFIER
}
struct KSPROPERTY_TUNER_IF_MEDIUM_S {
    Property : KSIDENTIFIER
    IFMedium : KSIDENTIFIER
}
struct KSPROPERTY_TUNER_MODE_CAPS_S {
    Property : KSIDENTIFIER
    Mode : UInt32
    StandardsSupported : UInt32
    MinFrequency : UInt32
    MaxFrequency : UInt32
    TuningGranularity : UInt32
    NumberOfInputs : UInt32
    SettlingTime : UInt32
    Strategy : UInt32
}
struct KSPROPERTY_TUNER_MODE_S {
    Property : KSIDENTIFIER
    Mode : UInt32
}
struct KSPROPERTY_TUNER_FREQUENCY_S {
    Property : KSIDENTIFIER
    Frequency : UInt32
    LastFrequency : UInt32
    TuningFlags : UInt32
    VideoSubChannel : UInt32
    AudioSubChannel : UInt32
    Channel : UInt32
    Country : UInt32
}
struct KSPROPERTY_TUNER_STANDARD_S {
    Property : KSIDENTIFIER
    Standard : UInt32
}
struct KSPROPERTY_TUNER_STANDARD_MODE_S {
    Property : KSIDENTIFIER
    AutoDetect : BOOL
}
struct KSPROPERTY_TUNER_INPUT_S {
    Property : KSIDENTIFIER
    InputIndex : UInt32
}
struct KSPROPERTY_TUNER_STATUS_S {
    Property : KSIDENTIFIER
    CurrentFrequency : UInt32
    PLLOffset : UInt32
    SignalStrength : UInt32
    Busy : UInt32
}
struct TunerLockType extends Int32 {
    static Tuner_LockType_None := 0
    static Tuner_LockType_Within_Scan_Sensing_Range := 1
    static Tuner_LockType_Locked := 2
}
struct TUNER_ANALOG_CAPS_S {
    Mode : UInt32
    StandardsSupported : UInt32
    MinFrequency : UInt32
    MaxFrequency : UInt32
    TuningGranularity : UInt32
    SettlingTime : UInt32
    ScanSensingRange : UInt32
    FineTuneSensingRange : UInt32
}
struct KSEVENT_TUNER extends Int32 {
    static KSEVENT_TUNER_CHANGED := 0
    static KSEVENT_TUNER_INITIATE_SCAN := 1
}
struct KSPROPERTY_TUNER_SCAN_CAPS_S {
    Property : KSIDENTIFIER
    fSupportsHardwareAssistedScanning : BOOL
    SupportedBroadcastStandards : UInt32
    GUIDBucket : Struct.Ptr
    lengthofBucket : UInt32
}
struct KSPROPERTY_TUNER_NETWORKTYPE_SCAN_CAPS_S {
    Property : KSIDENTIFIER
    NetworkType : GUID
    BufferSize : UInt32
    NetworkTunerCapabilities : Struct.Ptr
}
struct KSPROPERTY_TUNER_SCAN_STATUS_S {
    Property : KSIDENTIFIER
    LockStatus : TunerLockType
    CurrentFrequency : UInt32
}
struct KSEVENT_TUNER_INITIATE_SCAN_S {
    EventData : KSEVENTDATA
    StartFrequency : UInt32
    EndFrequency : UInt32
}
struct KSPROPERTY_VIDCAP_VIDEOENCODER extends Int32 {
    static KSPROPERTY_VIDEOENCODER_CAPS := 0
    static KSPROPERTY_VIDEOENCODER_STANDARD := 1
    static KSPROPERTY_VIDEOENCODER_COPYPROTECTION := 2
    static KSPROPERTY_VIDEOENCODER_CC_ENABLE := 3
}
struct KSPROPERTY_VIDEOENCODER_S {
    Property : KSIDENTIFIER
    Value : Int32
    Flags : UInt32
    Capabilities : UInt32
}
struct KSPROPERTY_VIDCAP_VIDEODECODER extends Int32 {
    static KSPROPERTY_VIDEODECODER_CAPS := 0
    static KSPROPERTY_VIDEODECODER_STANDARD := 1
    static KSPROPERTY_VIDEODECODER_STATUS := 2
    static KSPROPERTY_VIDEODECODER_OUTPUT_ENABLE := 3
    static KSPROPERTY_VIDEODECODER_VCR_TIMING := 4
    static KSPROPERTY_VIDEODECODER_STATUS2 := 5
}
struct KS_VIDEODECODER_FLAGS extends Int32 {
    static KS_VIDEODECODER_FLAGS_CAN_DISABLE_OUTPUT := 1
    static KS_VIDEODECODER_FLAGS_CAN_USE_VCR_LOCKING := 2
    static KS_VIDEODECODER_FLAGS_CAN_INDICATE_LOCKED := 4
}
struct KSPROPERTY_VIDEODECODER_CAPS_S {
    Property : KSIDENTIFIER
    StandardsSupported : UInt32
    Capabilities : UInt32
    SettlingTime : UInt32
    HSyncPerVSync : UInt32
}
struct KSPROPERTY_VIDEODECODER_STATUS_S {
    Property : KSIDENTIFIER
    NumberOfLines : UInt32
    SignalLocked : UInt32
}
struct KSPROPERTY_VIDEODECODER_STATUS2_S {
    Property : KSIDENTIFIER
    NumberOfLines : UInt32
    SignalLocked : UInt32
    ChromaLock : UInt32
}
struct KSPROPERTY_VIDEODECODER_S {
    Property : KSIDENTIFIER
    Value : UInt32
}
struct KSEVENT_VIDEODECODER extends Int32 {
    static KSEVENT_VIDEODECODER_CHANGED := 0
}
struct KSEVENT_CAMERACONTROL extends Int32 {
    static KSEVENT_CAMERACONTROL_FOCUS := 0
    static KSEVENT_CAMERACONTROL_ZOOM := 1
}
struct KSPROPERTY_VIDCAP_CAMERACONTROL extends Int32 {
    static KSPROPERTY_CAMERACONTROL_PAN := 0
    static KSPROPERTY_CAMERACONTROL_TILT := 1
    static KSPROPERTY_CAMERACONTROL_ROLL := 2
    static KSPROPERTY_CAMERACONTROL_ZOOM := 3
    static KSPROPERTY_CAMERACONTROL_EXPOSURE := 4
    static KSPROPERTY_CAMERACONTROL_IRIS := 5
    static KSPROPERTY_CAMERACONTROL_FOCUS := 6
    static KSPROPERTY_CAMERACONTROL_SCANMODE := 7
    static KSPROPERTY_CAMERACONTROL_PRIVACY := 8
    static KSPROPERTY_CAMERACONTROL_PANTILT := 9
    static KSPROPERTY_CAMERACONTROL_PAN_RELATIVE := 10
    static KSPROPERTY_CAMERACONTROL_TILT_RELATIVE := 11
    static KSPROPERTY_CAMERACONTROL_ROLL_RELATIVE := 12
    static KSPROPERTY_CAMERACONTROL_ZOOM_RELATIVE := 13
    static KSPROPERTY_CAMERACONTROL_EXPOSURE_RELATIVE := 14
    static KSPROPERTY_CAMERACONTROL_IRIS_RELATIVE := 15
    static KSPROPERTY_CAMERACONTROL_FOCUS_RELATIVE := 16
    static KSPROPERTY_CAMERACONTROL_PANTILT_RELATIVE := 17
    static KSPROPERTY_CAMERACONTROL_FOCAL_LENGTH := 18
    static KSPROPERTY_CAMERACONTROL_AUTO_EXPOSURE_PRIORITY := 19
}
struct KS_CameraControlAsyncOperation extends Int32 {
    static KS_CAMERACONTROL_ASYNC_START := 1
    static KS_CAMERACONTROL_ASYNC_STOP := 2
    static KS_CAMERACONTROL_ASYNC_RESET := 3
}
struct KSPROPERTY_CAMERACONTROL_S_EX {
    Property : KSIDENTIFIER
    Value : Int32
    Flags : UInt32
    Capabilities : UInt32
    FocusRect : RECT
}
struct KSPROPERTY_CAMERACONTROL_S {
    Property : KSIDENTIFIER
    Value : Int32
    Flags : UInt32
    Capabilities : UInt32
}
struct KSPROPERTY_CAMERACONTROL_NODE_S {
    NodeProperty : KSP_NODE
    Value : Int32
    Flags : UInt32
    Capabilities : UInt32
}
struct KSPROPERTY_CAMERACONTROL_S2 {
    Property : KSIDENTIFIER
    Value1 : Int32
    Flags : UInt32
    Capabilities : UInt32
    Value2 : Int32
}
struct KSPROPERTY_CAMERACONTROL_NODE_S2 {
    NodeProperty : KSP_NODE
    Value1 : Int32
    Flags : UInt32
    Capabilities : UInt32
    Value2 : Int32
}
struct KSPROPERTY_CAMERACONTROL_FOCAL_LENGTH_S {
    Property : KSIDENTIFIER
    lOcularFocalLength : Int32
    lObjectiveFocalLengthMin : Int32
    lObjectiveFocalLengthMax : Int32
}
struct KSPROPERTY_CAMERACONTROL_NODE_FOCAL_LENGTH_S {
    NodeProperty : KSNODEPROPERTY
    lOcularFocalLength : Int32
    lObjectiveFocalLengthMin : Int32
    lObjectiveFocalLengthMax : Int32
}
struct KSPROPERTY_CAMERACONTROL_FLASH extends Int32 {
    static KSPROPERTY_CAMERACONTROL_FLASH_PROPERTY_ID := 0
}
struct KSPROPERTY_CAMERACONTROL_FLASH_S {
    Flash : UInt32
    Capabilities : UInt32
}
struct KSPROPERTY_CAMERACONTROL_VIDEO_STABILIZATION_MODE extends Int32 {
    static KSPROPERTY_CAMERACONTROL_VIDEO_STABILIZATION_MODE_PROPERTY_ID := 0
}
struct KSPROPERTY_CAMERACONTROL_VIDEOSTABILIZATION_MODE_S {
    VideoStabilizationMode : UInt32
    Capabilities : UInt32
}
struct KSPROPERTY_CAMERACONTROL_REGION_OF_INTEREST extends Int32 {
    static KSPROPERTY_CAMERACONTROL_REGION_OF_INTEREST_PROPERTY_ID := 0
}
struct KSPROPERTY_CAMERACONTROL_REGION_OF_INTEREST_S {
    FocusRect : RECT
    AutoFocusLock : BOOL
    AutoExposureLock : BOOL
    AutoWhitebalanceLock : BOOL
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Capabilities : UInt32
            Configuration : UInt32
        }
    }
}
struct KSPROPERTY_CAMERACONTROL_IMAGE_PIN_CAPABILITY extends Int32 {
    static KSPROPERTY_CAMERACONTROL_IMAGE_PIN_CAPABILITY_PROPERTY_ID := 0
}
struct KSPROPERTY_CAMERACONTROL_IMAGE_PIN_CAPABILITY_S {
    Capabilities : UInt32
    Reserved0 : UInt32
}
struct KSPROPERTY_CAMERACONTROL_EXTENDED_PROPERTY extends Int32 {
    static KSPROPERTY_CAMERACONTROL_EXTENDED_PHOTOMODE := 0
    static KSPROPERTY_CAMERACONTROL_EXTENDED_PHOTOFRAMERATE := 1
    static KSPROPERTY_CAMERACONTROL_EXTENDED_PHOTOMAXFRAMERATE := 2
    static KSPROPERTY_CAMERACONTROL_EXTENDED_PHOTOTRIGGERTIME := 3
    static KSPROPERTY_CAMERACONTROL_EXTENDED_WARMSTART := 4
    static KSPROPERTY_CAMERACONTROL_EXTENDED_MAXVIDFPS_PHOTORES := 5
    static KSPROPERTY_CAMERACONTROL_EXTENDED_PHOTOTHUMBNAIL := 6
    static KSPROPERTY_CAMERACONTROL_EXTENDED_SCENEMODE := 7
    static KSPROPERTY_CAMERACONTROL_EXTENDED_TORCHMODE := 8
    static KSPROPERTY_CAMERACONTROL_EXTENDED_FLASHMODE := 9
    static KSPROPERTY_CAMERACONTROL_EXTENDED_OPTIMIZATIONHINT := 10
    static KSPROPERTY_CAMERACONTROL_EXTENDED_WHITEBALANCEMODE := 11
    static KSPROPERTY_CAMERACONTROL_EXTENDED_EXPOSUREMODE := 12
    static KSPROPERTY_CAMERACONTROL_EXTENDED_FOCUSMODE := 13
    static KSPROPERTY_CAMERACONTROL_EXTENDED_ISO := 14
    static KSPROPERTY_CAMERACONTROL_EXTENDED_FIELDOFVIEW := 15
    static KSPROPERTY_CAMERACONTROL_EXTENDED_EVCOMPENSATION := 16
    static KSPROPERTY_CAMERACONTROL_EXTENDED_CAMERAANGLEOFFSET := 17
    static KSPROPERTY_CAMERACONTROL_EXTENDED_METADATA := 18
    static KSPROPERTY_CAMERACONTROL_EXTENDED_FOCUSPRIORITY := 19
    static KSPROPERTY_CAMERACONTROL_EXTENDED_FOCUSSTATE := 20
    static KSPROPERTY_CAMERACONTROL_EXTENDED_ROI_CONFIGCAPS := 21
    static KSPROPERTY_CAMERACONTROL_EXTENDED_ROI_ISPCONTROL := 22
    static KSPROPERTY_CAMERACONTROL_EXTENDED_PHOTOCONFIRMATION := 23
    static KSPROPERTY_CAMERACONTROL_EXTENDED_ZOOM := 24
    static KSPROPERTY_CAMERACONTROL_EXTENDED_MCC := 25
    static KSPROPERTY_CAMERACONTROL_EXTENDED_ISO_ADVANCED := 26
    static KSPROPERTY_CAMERACONTROL_EXTENDED_VIDEOSTABILIZATION := 27
    static KSPROPERTY_CAMERACONTROL_EXTENDED_VFR := 28
    static KSPROPERTY_CAMERACONTROL_EXTENDED_FACEDETECTION := 29
    static KSPROPERTY_CAMERACONTROL_EXTENDED_VIDEOHDR := 30
    static KSPROPERTY_CAMERACONTROL_EXTENDED_HISTOGRAM := 31
    static KSPROPERTY_CAMERACONTROL_EXTENDED_OIS := 32
    static KSPROPERTY_CAMERACONTROL_EXTENDED_ADVANCEDPHOTO := 33
    static KSPROPERTY_CAMERACONTROL_EXTENDED_PROFILE := 34
    static KSPROPERTY_CAMERACONTROL_EXTENDED_FACEAUTH_MODE := 35
    static KSPROPERTY_CAMERACONTROL_EXTENDED_SECURE_MODE := 36
    static KSPROPERTY_CAMERACONTROL_EXTENDED_VIDEOTEMPORALDENOISING := 37
    static KSPROPERTY_CAMERACONTROL_EXTENDED_IRTORCHMODE := 38
    static KSPROPERTY_CAMERACONTROL_EXTENDED_RELATIVEPANELOPTIMIZATION := 39
    static KSPROPERTY_CAMERACONTROL_EXTENDED_EYEGAZECORRECTION := 40
    static KSPROPERTY_CAMERACONTROL_EXTENDED_BACKGROUNDSEGMENTATION := 41
    static KSPROPERTY_CAMERACONTROL_EXTENDED_DIGITALWINDOW_CONFIGCAPS := 42
    static KSPROPERTY_CAMERACONTROL_EXTENDED_DIGITALWINDOW := 43
    static KSPROPERTY_CAMERACONTROL_EXTENDED_FRAMERATE_THROTTLE := 44
    static KSPROPERTY_CAMERACONTROL_EXTENDED_FIELDOFVIEW2_CONFIGCAPS := 45
    static KSPROPERTY_CAMERACONTROL_EXTENDED_FIELDOFVIEW2 := 46
    static KSPROPERTY_CAMERACONTROL_EXTENDED_END := 47
    static KSPROPERTY_CAMERACONTROL_EXTENDED_END2 := 47
}
struct KSEVENT_CAMERAEVENT extends Int32 {
    static KSEVENT_PHOTO_SAMPLE_SCANNED := 0
}
struct KSCAMERA_EXTENDEDPROP_WHITEBALANCE_MODE extends Int32 {
    static KSCAMERA_EXTENDEDPROP_WHITEBALANCE_TEMPERATURE := 1
    static KSCAMERA_EXTENDEDPROP_WHITEBALANCE_PRESET := 2
}
struct KSCAMERA_EXTENDEDPROP_WBPRESET extends Int32 {
    static KSCAMERA_EXTENDEDPROP_WBPRESET_CLOUDY := 1
    static KSCAMERA_EXTENDEDPROP_WBPRESET_DAYLIGHT := 2
    static KSCAMERA_EXTENDEDPROP_WBPRESET_FLASH := 3
    static KSCAMERA_EXTENDEDPROP_WBPRESET_FLUORESCENT := 4
    static KSCAMERA_EXTENDEDPROP_WBPRESET_TUNGSTEN := 5
    static KSCAMERA_EXTENDEDPROP_WBPRESET_CANDLELIGHT := 6
}
struct KSPROPERTY_CAMERA_PHOTOTRIGGERTIME_FLAGS extends Int32 {
    static KSPROPERTY_CAMERA_PHOTOTRIGGERTIME_CLEAR := 0
    static KSPROPERTY_CAMERA_PHOTOTRIGGERTIME_SET := 1
}
struct KSCAMERA_EXTENDEDPROP_HEADER {
    Version : UInt32
    PinId : UInt32
    Size : UInt32
    Result : UInt32
    Flags : Int64
    Capability : Int64
}
struct KSCAMERA_EXTENDEDPROP_VALUE {
    Value : this._Value_e__Union
    struct _Value_e__Union {
        union {
            dbl : Float64
            ull : Int64
            ul : UInt32
            ratio : Int64
            l : Int32
            ll : Int64
        }
    }
}
struct KSCAMERA_MAXVIDEOFPS_FORPHOTORES {
    PhotoResWidth : UInt32
    PhotoResHeight : UInt32
    PreviewFPSNum : UInt32
    PreviewFPSDenom : UInt32
    CaptureFPSNum : UInt32
    CaptureFPSDenom : UInt32
}
struct KSCAMERA_EXTENDEDPROP_PHOTOMODE {
    RequestedHistoryFrames : UInt32
    MaxHistoryFrames : UInt32
    SubMode : UInt32
    Reserved : UInt32
}
struct KSCAMERA_EXTENDEDPROP_VIDEOPROCSETTING {
    Mode : UInt32
    Min : Int32
    Max : Int32
    Step : Int32
    VideoProc : KSCAMERA_EXTENDEDPROP_VALUE
    Reserved : Int64
}
struct KSCAMERA_EXTENDEDPROP_EVCOMPENSATION {
    Mode : UInt32
    Min : Int32
    Max : Int32
    Value : Int32
    Reserved : Int64
}
struct KSCAMERA_EXTENDEDPROP_FIELDOFVIEW {
    NormalizedFocalLengthX : UInt32
    NormalizedFocalLengthY : UInt32
    Flag : UInt32
    Reserved : UInt32
}
struct KSCAMERA_EXTENDEDPROP_CAMERAOFFSET {
    PitchAngle : Int32
    YawAngle : Int32
    Flag : UInt32
    Reserved : UInt32
}
struct KSCAMERA_EXTENDEDPROP_METADATAINFO {
    BufferAlignment : Int32
    MaxMetadataBufferSize : UInt32
}
struct KSCAMERA_EXTENDEDPROP_MetadataAlignment extends Int32 {
    static KSCAMERA_EXTENDEDPROP_MetadataAlignment_16 := 4
    static KSCAMERA_EXTENDEDPROP_MetadataAlignment_32 := 5
    static KSCAMERA_EXTENDEDPROP_MetadataAlignment_64 := 6
    static KSCAMERA_EXTENDEDPROP_MetadataAlignment_128 := 7
    static KSCAMERA_EXTENDEDPROP_MetadataAlignment_256 := 8
    static KSCAMERA_EXTENDEDPROP_MetadataAlignment_512 := 9
    static KSCAMERA_EXTENDEDPROP_MetadataAlignment_1024 := 10
    static KSCAMERA_EXTENDEDPROP_MetadataAlignment_2048 := 11
    static KSCAMERA_EXTENDEDPROP_MetadataAlignment_4096 := 12
    static KSCAMERA_EXTENDEDPROP_MetadataAlignment_8192 := 13
}
struct KSCAMERA_MetadataId extends Int32 {
    static MetadataId_Standard_Start := 1
    static MetadataId_PhotoConfirmation := 1
    static MetadataId_UsbVideoHeader := 2
    static MetadataId_CaptureStats := 3
    static MetadataId_CameraExtrinsics := 4
    static MetadataId_CameraIntrinsics := 5
    static MetadataId_FrameIllumination := 6
    static MetadataId_DigitalWindow := 7
    static MetadataId_BackgroundSegmentationMask := 8
    static MetadataId_Standard_End := 8
    static MetadataId_Custom_Start := -2147483648
}
struct KSCAMERA_METADATA_ITEMHEADER {
    MetadataId : UInt32
    Size : UInt32
}
struct KSCAMERA_METADATA_PHOTOCONFIRMATION {
    Header : KSCAMERA_METADATA_ITEMHEADER
    PhotoConfirmationIndex : UInt32
    Reserved : UInt32
}
struct KSCAMERA_METADATA_FRAMEILLUMINATION {
    Header : KSCAMERA_METADATA_ITEMHEADER
    Flags : UInt32
    Reserved : UInt32
}
struct KSCAMERA_METADATA_CAPTURESTATS {
    Header : KSCAMERA_METADATA_ITEMHEADER
    Flags : UInt32
    Reserved : UInt32
    ExposureTime : Int64
    ExposureCompensationFlags : Int64
    ExposureCompensationValue : Int32
    IsoSpeed : UInt32
    FocusState : UInt32
    LensPosition : UInt32
    WhiteBalance : UInt32
    Flash : UInt32
    FlashPower : UInt32
    ZoomFactor : UInt32
    SceneMode : Int64
    SensorFramerate : Int64
}
struct KSCAMERA_EXTENDEDPROP_FOCUSSTATE extends Int32 {
    static KSCAMERA_EXTENDEDPROP_FOCUSSTATE_UNINITIALIZED := 0
    static KSCAMERA_EXTENDEDPROP_FOCUSSTATE_LOST := 1
    static KSCAMERA_EXTENDEDPROP_FOCUSSTATE_SEARCHING := 2
    static KSCAMERA_EXTENDEDPROP_FOCUSSTATE_FOCUSED := 3
    static KSCAMERA_EXTENDEDPROP_FOCUSSTATE_FAILED := 4
}
struct KSCAMERA_EXTENDEDPROP_ROI_CONFIGCAPSHEADER {
    Size : UInt32
    ConfigCapCount : UInt32
    Reserved : Int64
}
struct KSCAMERA_EXTENDEDPROP_ROI_CONFIGCAPS {
    ControlId : UInt32
    MaxNumberOfROIs : UInt32
    Capability : Int64
}
struct KSCAMERA_EXTENDEDPROP_ROI_ISPCONTROLHEADER {
    Size : UInt32
    ControlCount : UInt32
    Reserved : Int64
}
struct KSCAMERA_EXTENDEDPROP_ROI_ISPCONTROL {
    ControlId : UInt32
    ROICount : UInt32
    Result : UInt32
    Reserved : UInt32
}
struct KSCAMERA_EXTENDEDPROP_ROI_INFO {
    Region : RECT
    Flags : Int64
    Weight : Int32
    RegionOfInterestType : Int32
}
struct KSCAMERA_EXTENDEDPROP_ROITYPE extends Int32 {
    static KSCAMERA_EXTENDEDPROP_ROITYPE_UNKNOWN := 0
    static KSCAMERA_EXTENDEDPROP_ROITYPE_FACE := 1
}
struct KSCAMERA_EXTENDEDPROP_ROI_WHITEBALANCE {
    ROIInfo : KSCAMERA_EXTENDEDPROP_ROI_INFO
    Reserved : Int64
}
struct KSCAMERA_EXTENDEDPROP_ROI_EXPOSURE {
    ROIInfo : KSCAMERA_EXTENDEDPROP_ROI_INFO
    Reserved : Int64
}
struct KSCAMERA_EXTENDEDPROP_ROI_FOCUS {
    ROIInfo : KSCAMERA_EXTENDEDPROP_ROI_INFO
    Reserved : Int64
}
struct KSPROPERTY_CAMERACONTROL_PERFRAMESETTING_PROPERTY extends Int32 {
    static KSPROPERTY_CAMERACONTROL_PERFRAMESETTING_CAPABILITY := 0
    static KSPROPERTY_CAMERACONTROL_PERFRAMESETTING_SET := 1
    static KSPROPERTY_CAMERACONTROL_PERFRAMESETTING_CLEAR := 2
}
struct KSCAMERA_PERFRAMESETTING_ITEM_TYPE extends Int32 {
    static KSCAMERA_PERFRAMESETTING_ITEM_EXPOSURE_TIME := 1
    static KSCAMERA_PERFRAMESETTING_ITEM_FLASH := 2
    static KSCAMERA_PERFRAMESETTING_ITEM_EXPOSURE_COMPENSATION := 3
    static KSCAMERA_PERFRAMESETTING_ITEM_ISO := 4
    static KSCAMERA_PERFRAMESETTING_ITEM_FOCUS := 5
    static KSCAMERA_PERFRAMESETTING_ITEM_PHOTOCONFIRMATION := 6
    static KSCAMERA_PERFRAMESETTING_ITEM_CUSTOM := 7
}
struct KSCAMERA_PERFRAMESETTING_CAP_ITEM_HEADER {
    Size : UInt32
    Type : UInt32
    Flags : Int64
}
struct KSCAMERA_PERFRAMESETTING_CAP_HEADER {
    Size : UInt32
    ItemCount : UInt32
    Flags : Int64
}
struct KSCAMERA_PERFRAMESETTING_CUSTOM_ITEM {
    Size : UInt32
    Reserved : UInt32
    Id : GUID
}
struct KSCAMERA_PERFRAMESETTING_ITEM_HEADER {
    Size : UInt32
    Type : UInt32
    Flags : Int64
}
struct KSCAMERA_PERFRAMESETTING_FRAME_HEADER {
    Size : UInt32
    Id : UInt32
    ItemCount : UInt32
    Reserved : UInt32
}
struct KSCAMERA_PERFRAMESETTING_HEADER {
    Size : UInt32
    FrameCount : UInt32
    Id : GUID
    Flags : Int64
    LoopCount : UInt32
    Reserved : UInt32
}
struct KSCAMERA_EXTENDEDPROP_DIGITALWINDOW_SETTING {
    OriginX : Int32
    OriginY : Int32
    WindowSize : Int32
    Reserved : UInt32
}
struct KSCAMERA_METADATA_DIGITALWINDOW {
    Header : KSCAMERA_METADATA_ITEMHEADER
    Window : KSCAMERA_EXTENDEDPROP_DIGITALWINDOW_SETTING
}
struct KSCAMERA_EXTENDEDPROP_DIGITALWINDOW_CONFIGCAPSHEADER {
    Size : UInt32
    Count : UInt32
}
struct KSCAMERA_EXTENDEDPROP_DIGITALWINDOW_CONFIGCAPS {
    ResolutionX : Int32
    ResolutionY : Int32
    PorchTop : Int32
    PorchLeft : Int32
    PorchBottom : Int32
    PorchRight : Int32
    NonUpscalingWindowSize : Int32
    MinWindowSize : Int32
    MaxWindowSize : Int32
    Reserved : Int32
}
struct KSCAMERA_EXTENDEDPROP_FIELDOFVIEW2_CONFIGCAPS {
    DefaultDiagonalFieldOfViewInDegrees : UInt16
    DiscreteFoVStopsCount : UInt16
    DiscreteFoVStops : UInt16[360]
    Reserved : UInt32
}
struct KSCAMERA_EXTENDEDPROP_BACKGROUNDSEGMENTATION_CONFIGCAPS {
    Resolution : SIZE
    MaxFrameRate : this._MaxFrameRate_e__Struct
    MaskResolution : SIZE
    SubType : GUID
    struct _MaxFrameRate_e__Struct {
        Numerator : Int32
        Denominator : Int32
    }
}
struct KSCAMERA_METADATA_BACKGROUNDSEGMENTATIONMASK {
    Header : KSCAMERA_METADATA_ITEMHEADER
    MaskCoverageBoundingBox : RECT
    MaskResolution : SIZE
    ForegroundBoundingBox : RECT
    MaskData : UInt8[1]
}
struct KSCAMERA_EXTENDEDPROP_PROFILE {
    ProfileId : GUID
    Index : UInt32
    Reserved : UInt32
}
struct KSCAMERA_PROFILE_MEDIAINFO {
    Resolution : this._Resolution_e__Struct
    MaxFrameRate : this._MaxFrameRate_e__Struct
    Flags : Int64
    Data0 : UInt32
    Data1 : UInt32
    Data2 : UInt32
    Data3 : UInt32
    struct _Resolution_e__Struct {
        X : UInt32
        Y : UInt32
    }
    struct _MaxFrameRate_e__Struct {
        Numerator : UInt32
        Denominator : UInt32
    }
}
struct KSCAMERA_PROFILE_PININFO {
    PinCategory : GUID
    Anonymous : this._Anonymous_e__Union
    MediaInfoCount : UInt32
    MediaInfos : KSCAMERA_PROFILE_MEDIAINFO.Ptr
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Reserved : UInt32
        }
        struct _Anonymous_e__Struct {
            PinIndex : UInt16
            ProfileSensorType : UInt16
        }
    }
}
struct KSCAMERA_PROFILE_INFO {
    ProfileId : GUID
    Index : UInt32
    PinCount : UInt32
    Pins : KSCAMERA_PROFILE_PININFO.Ptr
}
struct KSCAMERA_PROFILE_CONCURRENCYINFO {
    ReferenceGuid : GUID
    Reserved : UInt32
    ProfileCount : UInt32
    Profiles : KSCAMERA_PROFILE_INFO.Ptr
}
struct KSDEVICE_PROFILE_INFO {
    Type : UInt32
    Size : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Camera : this._Camera_e__Struct
        }
        struct _Camera_e__Struct {
            Info : KSCAMERA_PROFILE_INFO
            Reserved : UInt32
            ConcurrencyCount : UInt32
            Concurrency : KSCAMERA_PROFILE_CONCURRENCYINFO.Ptr
        }
    }
}
struct WNF_KSCAMERA_STREAMSTATE_INFO {
    ProcessId : UInt32
    SessionId : UInt32
    StreamState : UInt32
    Reserved : UInt32
}
struct KSPROPERTY_NETWORKCAMERACONTROL_NTPINFO_TYPE extends Int32 {
    static KSPROPERTY_NETWORKCAMERACONTROL_NTPINFO_TYPE_DISABLE := 0
    static KSPROPERTY_NETWORKCAMERACONTROL_NTPINFO_TYPE_HOSTNTP := 1
    static KSPROPERTY_NETWORKCAMERACONTROL_NTPINFO_TYPE_CUSTOM := 2
}
struct KSPROPERTY_NETWORKCAMERACONTROL_NTPINFO_HEADER {
    Size : UInt32
    Type : KSPROPERTY_NETWORKCAMERACONTROL_NTPINFO_TYPE
}
struct KSPROPERTY_NETWORKCAMERACONTROL_PROPERTY extends Int32 {
    static KSPROPERTY_NETWORKCAMERACONTROL_NTP := 0
    static KSPROPERTY_NETWORKCAMERACONTROL_URI := 1
    static KSPROPERTY_NETWORKCAMERACONTROL_METADATA := 2
    static KSPROPERTY_NETWORKCAMERACONTROL_EVENTTOPICS_XML := 3
}
struct KSPROPERTY_NETWORKCAMERACONTROL_METADATA_TYPE extends Int32 {
    static KSPROPERTY_NETWORKCAMERACONTROL_METADATA_TYPE_EVENTSINFO := 0
}
struct KSPROPERTY_NETWORKCAMERACONTROL_METADATA_INFO {
    MetadataItems : UInt32
    Size : UInt32
    PTZStatus : BOOL
    Events : BOOL
    Analytics : BOOL
    Reserved : BOOL
}
struct KSPROPERTY_NETWORKCAMERACONTROL_EVENT_INFO {
    Header : KSCAMERA_METADATA_ITEMHEADER
    EventFilter : UInt16[1]
}
struct KSPROPERTY_EXTDEVICE extends Int32 {
    static KSPROPERTY_EXTDEVICE_ID := 0
    static KSPROPERTY_EXTDEVICE_VERSION := 1
    static KSPROPERTY_EXTDEVICE_POWER_STATE := 2
    static KSPROPERTY_EXTDEVICE_PORT := 3
    static KSPROPERTY_EXTDEVICE_CAPABILITIES := 4
}
struct DEVCAPS {
    CanRecord : Int32
    CanRecordStrobe : Int32
    HasAudio : Int32
    HasVideo : Int32
    UsesFiles : Int32
    CanSave : Int32
    DeviceType : Int32
    TCRead : Int32
    TCWrite : Int32
    CTLRead : Int32
    IndexRead : Int32
    Preroll : Int32
    Postroll : Int32
    SyncAcc : Int32
    NormRate : Int32
    CanPreview : Int32
    CanMonitorSrc : Int32
    CanTest : Int32
    VideoIn : Int32
    AudioIn : Int32
    Calibrate : Int32
    SeekType : Int32
    SimulatedHardware : Int32
}
struct KSPROPERTY_EXTDEVICE_S {
    Property : KSIDENTIFIER
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            Capabilities : DEVCAPS
            DevPort : UInt32
            PowerState : UInt32
            pawchString : UInt16[260]
            NodeUniqueID : UInt32[2]
        }
    }
}
struct KSPROPERTY_EXTXPORT extends Int32 {
    static KSPROPERTY_EXTXPORT_CAPABILITIES := 0
    static KSPROPERTY_EXTXPORT_INPUT_SIGNAL_MODE := 1
    static KSPROPERTY_EXTXPORT_OUTPUT_SIGNAL_MODE := 2
    static KSPROPERTY_EXTXPORT_LOAD_MEDIUM := 3
    static KSPROPERTY_EXTXPORT_MEDIUM_INFO := 4
    static KSPROPERTY_EXTXPORT_STATE := 5
    static KSPROPERTY_EXTXPORT_STATE_NOTIFY := 6
    static KSPROPERTY_EXTXPORT_TIMECODE_SEARCH := 7
    static KSPROPERTY_EXTXPORT_ATN_SEARCH := 8
    static KSPROPERTY_EXTXPORT_RTC_SEARCH := 9
    static KSPROPERTY_RAW_AVC_CMD := 10
}
struct TRANSPORTSTATUS {
    Mode : Int32
    LastError : Int32
    RecordInhibit : Int32
    ServoLock : Int32
    MediaPresent : Int32
    MediaLength : Int32
    MediaSize : Int32
    MediaTrackCount : Int32
    MediaTrackLength : Int32
    MediaTrackSide : Int32
    MediaType : Int32
    LinkMode : Int32
    NotifyOn : Int32
}
struct TRANSPORTBASICPARMS {
    TimeFormat : Int32
    TimeReference : Int32
    Superimpose : Int32
    EndStopAction : Int32
    RecordFormat : Int32
    StepFrames : Int32
    SetpField : Int32
    Preroll : Int32
    RecPreroll : Int32
    Postroll : Int32
    EditDelay : Int32
    PlayTCDelay : Int32
    RecTCDelay : Int32
    EditField : Int32
    FrameServo : Int32
    ColorFrameServo : Int32
    ServoRef : Int32
    WarnGenlock : Int32
    SetTracking : Int32
    VolumeName : Int8[40]
    Ballistic : Int32[20]
    Speed : Int32
    CounterFormat : Int32
    TunerChannel : Int32
    TunerNumber : Int32
    TimerEvent : Int32
    TimerStartDay : Int32
    TimerStartTime : Int32
    TimerStopDay : Int32
    TimerStopTime : Int32
}
struct TRANSPORTVIDEOPARMS {
    OutputMode : Int32
    Input : Int32
}
struct TRANSPORTAUDIOPARMS {
    EnableOutput : Int32
    EnableRecord : Int32
    EnableSelsync : Int32
    Input : Int32
    MonitorSource : Int32
}
struct MEDIUM_INFO {
    MediaPresent : BOOL
    MediaType : UInt32
    RecordInhibit : BOOL
}
struct TRANSPORT_STATE {
    Mode : UInt32
    State : UInt32
}
struct KSPROPERTY_EXTXPORT_S {
    Property : KSIDENTIFIER
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            Capabilities : UInt32
            SignalMode : UInt32
            LoadMedium : UInt32
            MediumInfo : MEDIUM_INFO
            XPrtState : TRANSPORT_STATE
            Timecode : this._Timecode_e__Struct
            dwTimecode : UInt32
            dwAbsTrackNumber : UInt32
            RawAVC : this._RawAVC_e__Struct
        }
        struct _Timecode_e__Struct {
            frame : UInt8
            second : UInt8
            minute : UInt8
            hour : UInt8
        }
        struct _RawAVC_e__Struct {
            PayloadSize : UInt32
            Payload : UInt8[512]
        }
    }
}
struct KSPROPERTY_EXTXPORT_NODE_S {
    NodeProperty : KSP_NODE
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            Capabilities : UInt32
            SignalMode : UInt32
            LoadMedium : UInt32
            MediumInfo : MEDIUM_INFO
            XPrtState : TRANSPORT_STATE
            Timecode : this._Timecode_e__Struct
            dwTimecode : UInt32
            dwAbsTrackNumber : UInt32
            RawAVC : this._RawAVC_e__Struct
        }
        struct _Timecode_e__Struct {
            frame : UInt8
            second : UInt8
            minute : UInt8
            hour : UInt8
        }
        struct _RawAVC_e__Struct {
            PayloadSize : UInt32
            Payload : UInt8[512]
        }
    }
}
struct KSPROPERTY_TIMECODE extends Int32 {
    static KSPROPERTY_TIMECODE_READER := 0
    static KSPROPERTY_ATN_READER := 1
    static KSPROPERTY_RTC_READER := 2
}
struct KSPROPERTY_TIMECODE_S {
    Property : KSIDENTIFIER
    TimecodeSamp : TIMECODE_SAMPLE
}
struct KSPROPERTY_TIMECODE_NODE_S {
    NodeProperty : KSP_NODE
    TimecodeSamp : TIMECODE_SAMPLE
}
struct KSEVENT_DEVCMD extends Int32 {
    static KSEVENT_EXTDEV_COMMAND_NOTIFY_INTERIM_READY := 0
    static KSEVENT_EXTDEV_COMMAND_CONTROL_INTERIM_READY := 1
    static KSEVENT_EXTDEV_COMMAND_BUSRESET := 2
    static KSEVENT_EXTDEV_TIMECODE_UPDATE := 3
    static KSEVENT_EXTDEV_OPERATION_MODE_UPDATE := 4
    static KSEVENT_EXTDEV_TRANSPORT_STATE_UPDATE := 5
    static KSEVENT_EXTDEV_NOTIFY_REMOVAL := 6
    static KSEVENT_EXTDEV_NOTIFY_MEDIUM_CHANGE := 7
}
struct KSPROPERTY_VIDCAP_CROSSBAR extends Int32 {
    static KSPROPERTY_CROSSBAR_CAPS := 0
    static KSPROPERTY_CROSSBAR_PININFO := 1
    static KSPROPERTY_CROSSBAR_CAN_ROUTE := 2
    static KSPROPERTY_CROSSBAR_ROUTE := 3
    static KSPROPERTY_CROSSBAR_INPUT_ACTIVE := 4
}
struct KSPROPERTY_CROSSBAR_CAPS_S {
    Property : KSIDENTIFIER
    NumberOfInputs : UInt32
    NumberOfOutputs : UInt32
}
struct KSPROPERTY_CROSSBAR_PININFO_S {
    Property : KSIDENTIFIER
    Direction : KSPIN_DATAFLOW
    Index : UInt32
    PinType : UInt32
    RelatedPinIndex : UInt32
    Medium : KSIDENTIFIER
}
struct KSPROPERTY_CROSSBAR_ROUTE_S {
    Property : KSIDENTIFIER
    IndexInputPin : UInt32
    IndexOutputPin : UInt32
    CanRoute : UInt32
}
struct KSPROPERTY_CROSSBAR_ACTIVE_S {
    Property : KSIDENTIFIER
    IndexInputPin : UInt32
    Active : UInt32
}
struct KSEVENT_CROSSBAR extends Int32 {
    static KSEVENT_CROSSBAR_CHANGED := 0
}
struct KS_PhysicalConnectorType extends Int32 {
    static KS_PhysConn_Video_Tuner := 1
    static KS_PhysConn_Video_Composite := 2
    static KS_PhysConn_Video_SVideo := 3
    static KS_PhysConn_Video_RGB := 4
    static KS_PhysConn_Video_YRYBY := 5
    static KS_PhysConn_Video_SerialDigital := 6
    static KS_PhysConn_Video_ParallelDigital := 7
    static KS_PhysConn_Video_SCSI := 8
    static KS_PhysConn_Video_AUX := 9
    static KS_PhysConn_Video_1394 := 10
    static KS_PhysConn_Video_USB := 11
    static KS_PhysConn_Video_VideoDecoder := 12
    static KS_PhysConn_Video_VideoEncoder := 13
    static KS_PhysConn_Video_SCART := 14
    static KS_PhysConn_Audio_Tuner := 4096
    static KS_PhysConn_Audio_Line := 4097
    static KS_PhysConn_Audio_Mic := 4098
    static KS_PhysConn_Audio_AESDigital := 4099
    static KS_PhysConn_Audio_SPDIFDigital := 4100
    static KS_PhysConn_Audio_SCSI := 4101
    static KS_PhysConn_Audio_AUX := 4102
    static KS_PhysConn_Audio_1394 := 4103
    static KS_PhysConn_Audio_USB := 4104
    static KS_PhysConn_Audio_AudioDecoder := 4105
}
struct KSPROPERTY_VIDCAP_TVAUDIO extends Int32 {
    static KSPROPERTY_TVAUDIO_CAPS := 0
    static KSPROPERTY_TVAUDIO_MODE := 1
    static KSPROPERTY_TVAUDIO_CURRENTLY_AVAILABLE_MODES := 2
}
struct KSPROPERTY_TVAUDIO_CAPS_S {
    Property : KSIDENTIFIER
    Capabilities : UInt32
    InputMedium : KSIDENTIFIER
    OutputMedium : KSIDENTIFIER
}
struct KSPROPERTY_TVAUDIO_S {
    Property : KSIDENTIFIER
    Mode : UInt32
}
struct KSEVENT_TVAUDIO extends Int32 {
    static KSEVENT_TVAUDIO_CHANGED := 0
}
struct KSPROPERTY_VIDCAP_VIDEOCOMPRESSION extends Int32 {
    static KSPROPERTY_VIDEOCOMPRESSION_GETINFO := 0
    static KSPROPERTY_VIDEOCOMPRESSION_KEYFRAME_RATE := 1
    static KSPROPERTY_VIDEOCOMPRESSION_PFRAMES_PER_KEYFRAME := 2
    static KSPROPERTY_VIDEOCOMPRESSION_QUALITY := 3
    static KSPROPERTY_VIDEOCOMPRESSION_OVERRIDE_KEYFRAME := 4
    static KSPROPERTY_VIDEOCOMPRESSION_OVERRIDE_FRAME_SIZE := 5
    static KSPROPERTY_VIDEOCOMPRESSION_WINDOWSIZE := 6
}
struct KS_CompressionCaps extends Int32 {
    static KS_CompressionCaps_CanQuality := 1
    static KS_CompressionCaps_CanCrunch := 2
    static KS_CompressionCaps_CanKeyFrame := 4
    static KS_CompressionCaps_CanBFrame := 8
    static KS_CompressionCaps_CanWindow := 16
}
struct KS_VideoStreamingHints extends Int32 {
    static KS_StreamingHint_FrameInterval := 256
    static KS_StreamingHint_KeyFrameRate := 512
    static KS_StreamingHint_PFrameRate := 1024
    static KS_StreamingHint_CompQuality := 2048
    static KS_StreamingHint_CompWindowSize := 4096
}
struct KSPROPERTY_VIDEOCOMPRESSION_GETINFO_S {
    Property : KSIDENTIFIER
    StreamIndex : UInt32
    DefaultKeyFrameRate : Int32
    DefaultPFrameRate : Int32
    DefaultQuality : Int32
    NumberOfQualitySettings : Int32
    Capabilities : Int32
}
struct KSPROPERTY_VIDEOCOMPRESSION_S {
    Property : KSIDENTIFIER
    StreamIndex : UInt32
    Value : Int32
}
struct KSPROPERTY_VIDEOCOMPRESSION_S1 {
    Property : KSIDENTIFIER
    StreamIndex : UInt32
    Value : Int32
    Flags : UInt32
}
struct KSPROPERTY_OVERLAYUPDATE extends Int32 {
    static KSPROPERTY_OVERLAYUPDATE_INTERESTS := 0
    static KSPROPERTY_OVERLAYUPDATE_CLIPLIST := 1
    static KSPROPERTY_OVERLAYUPDATE_PALETTE := 2
    static KSPROPERTY_OVERLAYUPDATE_COLORKEY := 4
    static KSPROPERTY_OVERLAYUPDATE_VIDEOPOSITION := 8
    static KSPROPERTY_OVERLAYUPDATE_DISPLAYCHANGE := 16
    static KSPROPERTY_OVERLAYUPDATE_COLORREF := 268435456
}
struct KSDISPLAYCHANGE {
    PelsWidth : UInt32
    PelsHeight : UInt32
    BitsPerPel : UInt32
    DeviceID : UInt16[1]
}
struct KSPROPERTY_VIDCAP_VIDEOCONTROL extends Int32 {
    static KSPROPERTY_VIDEOCONTROL_CAPS := 0
    static KSPROPERTY_VIDEOCONTROL_ACTUAL_FRAME_RATE := 1
    static KSPROPERTY_VIDEOCONTROL_FRAME_RATES := 2
    static KSPROPERTY_VIDEOCONTROL_MODE := 3
}
struct KS_VideoControlFlags extends Int32 {
    static KS_VideoControlFlag_FlipHorizontal := 1
    static KS_VideoControlFlag_FlipVertical := 2
    static KS_Obsolete_VideoControlFlag_ExternalTriggerEnable := 16
    static KS_Obsolete_VideoControlFlag_Trigger := 32
    static KS_VideoControlFlag_ExternalTriggerEnable := 4
    static KS_VideoControlFlag_Trigger := 8
    static KS_VideoControlFlag_IndependentImagePin := 64
    static KS_VideoControlFlag_StillCapturePreviewFrame := 128
    static KS_VideoControlFlag_StartPhotoSequenceCapture := 256
    static KS_VideoControlFlag_StopPhotoSequenceCapture := 512
}
struct KSPROPERTY_VIDEOCONTROL_CAPS_S {
    Property : KSIDENTIFIER
    StreamIndex : UInt32
    VideoControlCaps : UInt32
}
struct KSPROPERTY_VIDEOCONTROL_MODE_S {
    Property : KSIDENTIFIER
    StreamIndex : UInt32
    Mode : Int32
}
struct KSPROPERTY_VIDEOCONTROL_ACTUAL_FRAME_RATE_S {
    Property : KSIDENTIFIER
    StreamIndex : UInt32
    RangeIndex : UInt32
    Dimensions : SIZE
    CurrentActualFrameRate : Int64
    CurrentMaxAvailableFrameRate : Int64
}
struct KSPROPERTY_VIDEOCONTROL_FRAME_RATES_S {
    Property : KSIDENTIFIER
    StreamIndex : UInt32
    RangeIndex : UInt32
    Dimensions : SIZE
}
struct KSPROPERTY_VIDCAP_DROPPEDFRAMES extends Int32 {
    static KSPROPERTY_DROPPEDFRAMES_CURRENT := 0
}
struct KSPROPERTY_DROPPEDFRAMES_CURRENT_S {
    Property : KSIDENTIFIER
    PictureNumber : Int64
    DropCount : Int64
    AverageFrameSize : UInt32
}
struct KSPROPERTY_VPCONFIG extends Int32 {
    static KSPROPERTY_VPCONFIG_NUMCONNECTINFO := 0
    static KSPROPERTY_VPCONFIG_GETCONNECTINFO := 1
    static KSPROPERTY_VPCONFIG_SETCONNECTINFO := 2
    static KSPROPERTY_VPCONFIG_VPDATAINFO := 3
    static KSPROPERTY_VPCONFIG_MAXPIXELRATE := 4
    static KSPROPERTY_VPCONFIG_INFORMVPINPUT := 5
    static KSPROPERTY_VPCONFIG_NUMVIDEOFORMAT := 6
    static KSPROPERTY_VPCONFIG_GETVIDEOFORMAT := 7
    static KSPROPERTY_VPCONFIG_SETVIDEOFORMAT := 8
    static KSPROPERTY_VPCONFIG_INVERTPOLARITY := 9
    static KSPROPERTY_VPCONFIG_DECIMATIONCAPABILITY := 10
    static KSPROPERTY_VPCONFIG_SCALEFACTOR := 11
    static KSPROPERTY_VPCONFIG_DDRAWHANDLE := 12
    static KSPROPERTY_VPCONFIG_VIDEOPORTID := 13
    static KSPROPERTY_VPCONFIG_DDRAWSURFACEHANDLE := 14
    static KSPROPERTY_VPCONFIG_SURFACEPARAMS := 15
}
struct KS_AMPixAspectRatio extends Int32 {
    static KS_PixAspectRatio_NTSC4x3 := 0
    static KS_PixAspectRatio_NTSC16x9 := 1
    static KS_PixAspectRatio_PAL4x3 := 2
    static KS_PixAspectRatio_PAL16x9 := 3
}
struct KS_AMVP_SELECTFORMATBY extends Int32 {
    static KS_AMVP_DO_NOT_CARE := 0
    static KS_AMVP_BEST_BANDWIDTH := 1
    static KS_AMVP_INPUT_SAME_AS_OUTPUT := 2
}
struct KS_AMVP_MODE extends Int32 {
    static KS_AMVP_MODE_WEAVE := 0
    static KS_AMVP_MODE_BOBINTERLEAVED := 1
    static KS_AMVP_MODE_BOBNONINTERLEAVED := 2
    static KS_AMVP_MODE_SKIPEVEN := 3
    static KS_AMVP_MODE_SKIPODD := 4
}
struct KS_AMVPDIMINFO {
    dwFieldWidth : UInt32
    dwFieldHeight : UInt32
    dwVBIWidth : UInt32
    dwVBIHeight : UInt32
    rcValidRegion : RECT
}
struct KS_AMVPDATAINFO {
    dwSize : UInt32
    dwMicrosecondsPerField : UInt32
    amvpDimInfo : KS_AMVPDIMINFO
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
struct KS_AMVPSIZE {
    dwWidth : UInt32
    dwHeight : UInt32
}
struct KSVPMAXPIXELRATE {
    Size : KS_AMVPSIZE
    MaxPixelsPerSecond : UInt32
    Reserved : UInt32
}
struct KSVPSIZE_PROP {
    Property : KSIDENTIFIER
    Size : KS_AMVPSIZE
}
struct KSVPSURFACEPARAMS {
    dwPitch : UInt32
    dwXOrigin : UInt32
    dwYOrigin : UInt32
}
struct KSEVENT_VPNOTIFY extends Int32 {
    static KSEVENT_VPNOTIFY_FORMATCHANGE := 0
}
struct KSEVENT_VIDCAPTOSTI extends Int32 {
    static KSEVENT_VIDCAPTOSTI_EXT_TRIGGER := 0
    static KSEVENT_VIDCAP_AUTO_UPDATE := 1
    static KSEVENT_VIDCAP_SEARCH := 2
}
struct KSPROPERTY_EXTENSION_UNIT extends Int32 {
    static KSPROPERTY_EXTENSION_UNIT_INFO := 0
    static KSPROPERTY_EXTENSION_UNIT_CONTROL := 1
    static KSPROPERTY_EXTENSION_UNIT_PASS_THROUGH := 65535
}
struct KSEVENT_VPVBINOTIFY extends Int32 {
    static KSEVENT_VPVBINOTIFY_FORMATCHANGE := 0
}
struct KSGOP_USERDATA {
    sc : UInt32
    reserved1 : UInt32
    cFields : UInt8
    l21Data : CHAR[3]
}
struct KS_AM_PROPERTY_TS_RATE_CHANGE extends Int32 {
    static KS_AM_RATE_SimpleRateChange := 1
    static KS_AM_RATE_ExactRateChange := 2
    static KS_AM_RATE_MaxFullDataRate := 3
    static KS_AM_RATE_Step := 4
}
struct KS_AM_SimpleRateChange {
    StartTime : Int64
    Rate : Int32
}
struct KS_AM_ExactRateChange {
    OutputZeroTime : Int64
    Rate : Int32
}
struct KSPROPERTY_JACK extends Int32 {
    static KSPROPERTY_JACK_DESCRIPTION := 1
    static KSPROPERTY_JACK_DESCRIPTION2 := 2
    static KSPROPERTY_JACK_SINK_INFO := 3
    static KSPROPERTY_JACK_CONTAINERID := 4
    static KSPROPERTY_JACK_DESCRIPTION3 := 5
}
struct EPcxConnectionType extends Int32 {
    static eConnTypeUnknown := 0
    static eConnType3Point5mm := 1
    static eConnTypeQuarter := 2
    static eConnTypeAtapiInternal := 3
    static eConnTypeRCA := 4
    static eConnTypeOptical := 5
    static eConnTypeOtherDigital := 6
    static eConnTypeOtherAnalog := 7
    static eConnTypeMultichannelAnalogDIN := 8
    static eConnTypeXlrProfessional := 9
    static eConnTypeRJ11Modem := 10
    static eConnTypeCombination := 11
}
struct EPcxGeoLocation extends Int32 {
    static eGeoLocRear := 1
    static eGeoLocFront := 2
    static eGeoLocLeft := 3
    static eGeoLocRight := 4
    static eGeoLocTop := 5
    static eGeoLocBottom := 6
    static eGeoLocRearPanel := 7
    static eGeoLocRiser := 8
    static eGeoLocInsideMobileLid := 9
    static eGeoLocDrivebay := 10
    static eGeoLocHDMI := 11
    static eGeoLocOutsideMobileLid := 12
    static eGeoLocATAPI := 13
    static eGeoLocNotApplicable := 14
    static eGeoLocReserved6 := 15
    static EPcxGeoLocation_enum_count := 16
}
struct EPcxGenLocation extends Int32 {
    static eGenLocPrimaryBox := 0
    static eGenLocInternal := 1
    static eGenLocSeparate := 2
    static eGenLocOther := 3
    static EPcxGenLocation_enum_count := 4
}
struct EPxcPortConnection extends Int32 {
    static ePortConnJack := 0
    static ePortConnIntegratedDevice := 1
    static ePortConnBothIntegratedAndJack := 2
    static ePortConnUnknown := 3
}
struct KSJACK_DESCRIPTION {
    ChannelMapping : UInt32
    Color : UInt32
    ConnectionType : EPcxConnectionType
    GeoLocation : EPcxGeoLocation
    GenLocation : EPcxGenLocation
    PortConnection : EPxcPortConnection
    IsConnected : BOOL
}
struct KSJACK_SINK_CONNECTIONTYPE extends Int32 {
    static KSJACK_SINK_CONNECTIONTYPE_HDMI := 0
    static KSJACK_SINK_CONNECTIONTYPE_DISPLAYPORT := 1
}
struct KSJACK_SINK_INFORMATION {
    ConnType : KSJACK_SINK_CONNECTIONTYPE
    ManufacturerId : UInt16
    ProductId : UInt16
    AudioLatency : UInt16
    HDCPCapable : BOOL
    AICapable : BOOL
    SinkDescriptionLength : UInt8
    SinkDescription : UInt16[32]
    PortId : LUID
}
struct KSJACK_DESCRIPTION2 {
    DeviceStateInfo : UInt32
    JackCapabilities : UInt32
}
struct KSJACK_DESCRIPTION3 {
    ConfigId : UInt32
}
struct KSPROPERTY_AUDIOPOSTURE extends Int32 {
    static KSPROPERTY_AUDIOPOSTURE_ORIENTATION := 1
}
struct AUDIOPOSTURE_ORIENTATION extends Int32 {
    static AUDIOPOSTURE_ORIENTATION_NOTROTATED := 0
    static AUDIOPOSTURE_ORIENTATION_ROTATED90DEGREESCOUNTERCLOCKWISE := 1
    static AUDIOPOSTURE_ORIENTATION_ROTATED180DEGREESCOUNTERCLOCKWISE := 2
    static AUDIOPOSTURE_ORIENTATION_ROTATED270DEGREESCOUNTERCLOCKWISE := 3
}
struct KSPROPERTY_AUDIOENGINE extends Int32 {
    static KSPROPERTY_AUDIOENGINE_LFXENABLE := 0
    static KSPROPERTY_AUDIOENGINE_GFXENABLE := 1
    static KSPROPERTY_AUDIOENGINE_MIXFORMAT := 2
    static KSPROPERTY_AUDIOENGINE_DEVICEFORMAT := 4
    static KSPROPERTY_AUDIOENGINE_SUPPORTEDDEVICEFORMATS := 5
    static KSPROPERTY_AUDIOENGINE_DESCRIPTOR := 6
    static KSPROPERTY_AUDIOENGINE_BUFFER_SIZE_RANGE := 7
    static KSPROPERTY_AUDIOENGINE_LOOPBACK_PROTECTION := 8
    static KSPROPERTY_AUDIOENGINE_VOLUMELEVEL := 9
    static KSPROPERTY_AUDIOENGINE_DEVICECONTROLS := 10
}
struct KSAUDIOENGINE_DESCRIPTOR {
    nHostPinId : UInt32
    nOffloadPinId : UInt32
    nLoopbackPinId : UInt32
}
struct KSAUDIOENGINE_BUFFER_SIZE_RANGE {
    MinBufferBytes : UInt32
    MaxBufferBytes : UInt32
}
struct AUDIO_CURVE_TYPE extends Int32 {
    static AUDIO_CURVE_TYPE_NONE := 0
    static AUDIO_CURVE_TYPE_WINDOWS_FADE := 1
}
struct KSAUDIOENGINE_VOLUMELEVEL {
    TargetVolume : Int32
    CurveType : AUDIO_CURVE_TYPE
    CurveDuration : Int64
}
struct EDeviceControlUseType extends Int32 {
    static eDeviceControlUseMissing := 0
    static eDeviceControlUsePrimary := 1
    static eDeviceControlUseSecondary := 2
}
struct KSAUDIOENGINE_DEVICECONTROLS {
    Volume : EDeviceControlUseType
    Mute : EDeviceControlUseType
    PeakMeter : EDeviceControlUseType
}
struct KSPROPERTY_AUDIOSIGNALPROCESSING extends Int32 {
    static KSPROPERTY_AUDIOSIGNALPROCESSING_MODES := 0
}
struct KSATTRIBUTE_AUDIOSIGNALPROCESSING_MODE {
    AttributeHeader : KSATTRIBUTE
    SignalProcessingMode : GUID
}
struct KSPROPERTY_AUDIOLOOPBACK extends Int32 {
    static KSPROPERTY_AUDIOLOOPBACK_TAPPOINT_CAPS := 0
}
struct AUDIOLOOPBACK_TAPPOINT_TYPE extends Int32 {
    static AUDIOLOOPBACK_TAPPOINT_PREVOLUMEMUTE := 0
    static AUDIOLOOPBACK_TAPPOINT_POSTVOLUMEMUTE := 1
}
struct KSATTRIBUTE_AUDIOLOOPBACK_TAPPOINT {
    AttributeHeader : KSATTRIBUTE
    TapPoint : AUDIOLOOPBACK_TAPPOINT_TYPE
}
struct KSPROPERTY_AUDIORESOURCEMANAGEMENT extends Int32 {
    static KSPROPERTY_AUDIORESOURCEMANAGEMENT_RESOURCEGROUP := 0
}
struct AUDIORESOURCEMANAGEMENT_RESOURCEGROUP {
    ResourceGroupAcquired : BOOL
    ResourceGroupName : UInt16[256]
}
struct KSPROPERTY_AUDIOMODULE extends Int32 {
    static KSPROPERTY_AUDIOMODULE_DESCRIPTORS := 1
    static KSPROPERTY_AUDIOMODULE_COMMAND := 2
    static KSPROPERTY_AUDIOMODULE_NOTIFICATION_DEVICE_ID := 3
}
struct KSAUDIOMODULE_DESCRIPTOR {
    ClassId : GUID
    InstanceId : UInt32
    VersionMajor : UInt32
    VersionMinor : UInt32
    Name : UInt16[128]
}
struct KSAUDIOMODULE_PROPERTY {
    Property : KSIDENTIFIER
    ClassId : GUID
    InstanceId : UInt32
}
struct KSAUDIOMODULE_NOTIFICATION {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ProviderId : this._ProviderId_e__Struct
            Alignment : Int64
        }
        struct _ProviderId_e__Struct {
            DeviceId : GUID
            ClassId : GUID
            InstanceId : UInt32
            Reserved : UInt32
        }
    }
}
struct KSALLOCATORMODE extends Int32 {
    static KsAllocatorMode_User := 0
    static KsAllocatorMode_Kernel := 1
}
struct FRAMING_PROP extends Int32 {
    static FramingProp_Uninitialized := 0
    static FramingProp_None := 1
    static FramingProp_Old := 2
    static FramingProp_Ex := 3
}
struct FRAMING_CACHE_OPS extends Int32 {
    static Framing_Cache_Update := 0
    static Framing_Cache_ReadLast := 1
    static Framing_Cache_ReadOrig := 2
    static Framing_Cache_Write := 3
}
struct OPTIMAL_WEIGHT_TOTALS {
    MinTotalNominator : Int64
    MaxTotalNominator : Int64
    TotalDenominator : Int64
}
struct PIPE_STATE extends Int32 {
    static PipeState_DontCare := 0
    static PipeState_RangeNotFixed := 1
    static PipeState_RangeFixed := 2
    static PipeState_CompressionUnknown := 3
    static PipeState_Finalized := 4
}
struct PIPE_DIMENSIONS {
    AllocatorPin : KS_COMPRESSION
    MaxExpansionPin : KS_COMPRESSION
    EndPin : KS_COMPRESSION
}
struct PIPE_ALLOCATOR_PLACE extends Int32 {
    static Pipe_Allocator_None := 0
    static Pipe_Allocator_FirstPin := 1
    static Pipe_Allocator_LastPin := 2
    static Pipe_Allocator_MiddlePin := 3
}
struct KS_LogicalMemoryType extends Int32 {
    static KS_MemoryTypeDontCare := 0
    static KS_MemoryTypeKernelPaged := 1
    static KS_MemoryTypeKernelNonPaged := 2
    static KS_MemoryTypeDeviceHostMapped := 3
    static KS_MemoryTypeDeviceSpecific := 4
    static KS_MemoryTypeUser := 5
    static KS_MemoryTypeAnyHost := 6
}
struct PIPE_TERMINATION {
    Flags : UInt32
    OutsideFactors : UInt32
    Weigth : UInt32
    PhysicalRange : KS_FRAMING_RANGE
    OptimalRange : KS_FRAMING_RANGE_WEIGHTED
    Compression : KS_COMPRESSION
}
struct ALLOCATOR_PROPERTIES_EX {
    cBuffers : Int32
    cbBuffer : Int32
    cbAlign : Int32
    cbPrefix : Int32
    MemoryType : GUID
    BusType : GUID
    State : PIPE_STATE
    Input : PIPE_TERMINATION
    Output : PIPE_TERMINATION
    Strategy : UInt32
    Flags : UInt32
    Weight : UInt32
    LogicalMemoryType : KS_LogicalMemoryType
    AllocatorPlace : PIPE_ALLOCATOR_PLACE
    Dimensions : PIPE_DIMENSIONS
    PhysicalRange : KS_FRAMING_RANGE
    PrevSegment : IKsAllocatorEx
    CountNextSegments : UInt32
    NextSegments : IKsAllocatorEx.Ptr
    InsideFactors : UInt32
    NumberPins : UInt32
}
struct IKsClockPropertySet extends IUnknown {
    static IID := "{5C5CBD84-E755-11D0-AC18-00A0C9223196}"
    KsGetTime(Time)
      => ComCall(3, this.p, Int64.Ptr, Time)
    KsSetTime(Time)
      => ComCall(4, this.p, Int64, Time)
    KsGetPhysicalTime(Time)
      => ComCall(5, this.p, Int64.Ptr, Time)
    KsSetPhysicalTime(Time)
      => ComCall(6, this.p, Int64, Time)
    KsGetCorrelatedTime(CorrelatedTime)
      => ComCall(7, this.p, KSCORRELATED_TIME.Ptr, CorrelatedTime)
    KsSetCorrelatedTime(CorrelatedTime)
      => ComCall(8, this.p, KSCORRELATED_TIME.Ptr, CorrelatedTime)
    KsGetCorrelatedPhysicalTime(CorrelatedTime)
      => ComCall(9, this.p, KSCORRELATED_TIME.Ptr, CorrelatedTime)
    KsSetCorrelatedPhysicalTime(CorrelatedTime)
      => ComCall(10, this.p, KSCORRELATED_TIME.Ptr, CorrelatedTime)
    KsGetResolution(Resolution)
      => ComCall(11, this.p, KSRESOLUTION.Ptr, Resolution)
    KsGetState(State)
      => ComCall(12, this.p, KSSTATE.Ptr, State)
}
struct IKsAllocator extends IUnknown {
    static IID := "{8DA64899-C0D9-11D0-8413-0000F822FE8A}"
    KsGetAllocatorHandle()
      => ComCall(3, this.p, HANDLE)
    KsGetAllocatorMode()
      => ComCall(4, this.p, KSALLOCATORMODE)
    KsGetAllocatorStatus(AllocatorStatus)
      => ComCall(5, this.p, KSSTREAMALLOCATOR_STATUS.Ptr, AllocatorStatus)
    KsSetAllocatorMode(Mode)
      => ComCall(6, this.p, KSALLOCATORMODE, Mode, "void")
}
struct IKsAllocatorEx extends IKsAllocator {
    static IID := "{091BB63A-603F-11D1-B067-00A0C9062802}"
    KsGetProperties()
      => ComCall(7, this.p, ALLOCATOR_PROPERTIES_EX.Ptr)
    KsSetProperties(param0)
      => ComCall(8, this.p, ALLOCATOR_PROPERTIES_EX.Ptr, param0, "void")
    KsSetAllocatorHandle(AllocatorHandle)
      => ComCall(9, this.p, HANDLE, AllocatorHandle, "void")
    KsCreateAllocatorAndGetHandle(KsPin)
      => ComCall(10, this.p, IKsPin, KsPin, HANDLE)
}
struct KSPEEKOPERATION extends Int32 {
    static KsPeekOperation_PeekOnly := 0
    static KsPeekOperation_AddRef := 1
}
struct IKsPin extends IUnknown {
    static IID := "{B61178D1-A2D9-11CF-9E53-00AA00A216A1}"
    KsQueryMediums(MediumList)
      => ComCall(3, this.p, KSMULTIPLE_ITEM.Ptr.Ptr, MediumList)
    KsQueryInterfaces(InterfaceList)
      => ComCall(4, this.p, KSMULTIPLE_ITEM.Ptr.Ptr, InterfaceList)
    KsCreateSinkPinHandle(Interface, Medium)
      => ComCall(5, this.p, KSIDENTIFIER.Ptr, Interface, KSIDENTIFIER.Ptr, Medium)
    KsGetCurrentCommunication(Communication?, Interface?, Medium?)
      => ComCall(6, this.p, KSPIN_COMMUNICATION.Ptr, Communication?, KSIDENTIFIER.Ptr, Interface?, KSIDENTIFIER.Ptr, Medium?)
    KsPropagateAcquire()
      => ComCall(7, this.p)
    KsDeliver(Sample, Flags)
      => ComCall(8, this.p, IMediaSample, Sample, UInt32, Flags)
    KsMediaSamplesCompleted(StreamSegment)
      => ComCall(9, this.p, KSSTREAM_SEGMENT.Ptr, StreamSegment)
    KsPeekAllocator(Operation)
      => ComCall(10, this.p, KSPEEKOPERATION, Operation, IMemAllocator)
    KsReceiveAllocator(MemAllocator?)
      => ComCall(11, this.p, IMemAllocator, MemAllocator?)
    KsRenegotiateAllocator()
      => ComCall(12, this.p)
    KsIncrementPendingIoCount()
      => ComCall(13, this.p, Int32)
    KsDecrementPendingIoCount()
      => ComCall(14, this.p, Int32)
    KsQualityNotify(Proportion, TimeDelta)
      => ComCall(15, this.p, UInt32, Proportion, Int64, TimeDelta)
}
struct IKsPinEx extends IKsPin {
    static IID := "{7BB38260-D19C-11D2-B38A-00A0C95EC22E}"
    KsNotifyError(Sample, hr)
      => ComCall(16, this.p, IMediaSample, Sample, HRESULT, hr, "void")
}
struct IKsPinPipe extends IUnknown {
    static IID := "{E539CD90-A8B4-11D1-8189-00A0C9062802}"
    KsGetPinFramingCache(FramingEx, FramingProp, Option)
      => ComCall(3, this.p, KSALLOCATOR_FRAMING_EX.Ptr.Ptr, FramingEx, FRAMING_PROP.Ptr, FramingProp, FRAMING_CACHE_OPS, Option)
    KsSetPinFramingCache(FramingEx, FramingProp, Option)
      => ComCall(4, this.p, KSALLOCATOR_FRAMING_EX.Ptr, FramingEx, FRAMING_PROP.Ptr, FramingProp, FRAMING_CACHE_OPS, Option)
    KsGetConnectedPin()
      => ComCall(5, this.p, IPin)
    KsGetPipe(Operation)
      => ComCall(6, this.p, KSPEEKOPERATION, Operation, IKsAllocatorEx)
    KsSetPipe(KsAllocator)
      => ComCall(7, this.p, IKsAllocatorEx, KsAllocator)
    KsGetPipeAllocatorFlag()
      => ComCall(8, this.p, UInt32)
    KsSetPipeAllocatorFlag(Flag)
      => ComCall(9, this.p, UInt32, Flag)
    KsGetPinBusCache()
      => ComCall(10, this.p, GUID)
    KsSetPinBusCache(Bus)
      => ComCall(11, this.p, GUID, Bus)
    KsGetPinName()
      => ComCall(12, this.p, PWSTR)
    KsGetFilterName()
      => ComCall(13, this.p, PWSTR)
}
struct IKsPinFactory extends IUnknown {
    static IID := "{CD5EBE6B-8B6E-11D1-8AE0-00A0C9223196}"
    KsPinFactory(PinFactory)
      => ComCall(3, this.p, UInt32.Ptr, PinFactory)
}
struct KSIOOPERATION extends Int32 {
    static KsIoOperation_Write := 0
    static KsIoOperation_Read := 1
}
struct IKsDataTypeHandler extends IUnknown {
    static IID := "{5FFBAA02-49A3-11D0-9F36-00AA00A216A1}"
    KsCompleteIoOperation(Sample, StreamHeader, IoOperation, Cancelled)
      => ComCall(3, this.p, IMediaSample, Sample, Struct.Ptr, StreamHeader, KSIOOPERATION, IoOperation, BOOL, Cancelled)
    KsIsMediaTypeInRanges(DataRanges)
      => ComCall(4, this.p, Struct.Ptr, DataRanges)
    KsPrepareIoOperation(Sample, StreamHeader, IoOperation)
      => ComCall(5, this.p, IMediaSample, Sample, Struct.Ptr, StreamHeader, KSIOOPERATION, IoOperation)
    KsQueryExtendedSize(ExtendedSize)
      => ComCall(6, this.p, UInt32.Ptr, ExtendedSize)
    KsSetMediaType(AmMediaType)
      => ComCall(7, this.p, AM_MEDIA_TYPE.Ptr, AmMediaType)
}
struct IKsDataTypeCompletion extends IUnknown {
    static IID := "{827D1A0E-0F73-11D2-B27A-00A0C9223196}"
    KsCompleteMediaType(FilterHandle, PinFactoryId, AmMediaType)
      => ComCall(3, this.p, HANDLE, FilterHandle, UInt32, PinFactoryId, AM_MEDIA_TYPE.Ptr, AmMediaType)
}
struct IKsInterfaceHandler extends IUnknown {
    static IID := "{D3ABC7E0-9A61-11D0-A40D-00A0C9223196}"
    KsSetPin(KsPin)
      => ComCall(3, this.p, IKsPin, KsPin)
    KsProcessMediaSamples(KsDataTypeHandler, SampleList, IoOperation, StreamSegment)
      => ComCall(4, this.p, IKsDataTypeHandler, KsDataTypeHandler, IMediaSample.Ptr, SampleList, Int32.Ptr, SampleList.Length, KSIOOPERATION, IoOperation, KSSTREAM_SEGMENT.Ptr.Ptr, StreamSegment)
    KsCompleteIo(StreamSegment)
      => ComCall(5, this.p, KSSTREAM_SEGMENT.Ptr, StreamSegment)
}
struct KSSTREAM_SEGMENT {
    KsInterfaceHandler : IKsInterfaceHandler
    KsDataTypeHandler : IKsDataTypeHandler
    IoOperation : KSIOOPERATION
    CompletionEvent : HANDLE
}
struct IKsObject extends IUnknown {
    static IID := "{423C13A2-2070-11D0-9EF7-00AA00A216A1}"
    KsGetObjectHandle()
      => ComCall(3, this.p, HANDLE)
}
struct IKsQualityForwarder extends IKsObject {
    static IID := "{97EBAACB-95BD-11D0-A3EA-00A0C9223196}"
    KsFlushClient(Pin)
      => ComCall(4, this.p, IKsPin, Pin, "void")
}
struct IKsNotifyEvent extends IUnknown {
    static IID := "{412BD695-F84B-46C1-AC73-54196DBC8FA7}"
    KsNotifyEvent(Event, lParam1, lParam2)
      => ComCall(3, this.p, UInt32, Event, IntPtr, lParam1, IntPtr, lParam2)
}
struct IKsAggregateControl extends IUnknown {
    static IID := "{7F40EAC0-3947-11D2-874E-00A0C9223196}"
    KsAddAggregate(AggregateClass)
      => ComCall(3, this.p, GUID.Ptr, AggregateClass)
    KsRemoveAggregate(AggregateClass)
      => ComCall(4, this.p, GUID.Ptr, AggregateClass)
}
struct IKsTopology extends IUnknown {
    static IID := "{28F54683-06FD-11D2-B27A-00A0C9223196}"
    CreateNodeInstance(NodeId, Flags, DesiredAccess, UnkOuter?, InterfaceId, Interface)
      => ComCall(3, this.p, UInt32, NodeId, UInt32, Flags, UInt32, DesiredAccess, IUnknown, UnkOuter?, GUID.Ptr, InterfaceId, Struct.Ptr.Ptr, Interface)
}
