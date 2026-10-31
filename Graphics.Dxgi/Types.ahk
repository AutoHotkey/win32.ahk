#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HMODULE, HRESULT, HWND, LUID, POINT, PSTR, PWSTR, RECT}
#Import "..\Graphics.Dxgi.Common\Types.ahk" {DXGI_ALPHA_MODE, DXGI_COLOR_SPACE_TYPE, DXGI_FORMAT, DXGI_GAMMA_CONTROL, DXGI_GAMMA_CONTROL_CAPABILITIES, DXGI_MODE_DESC, DXGI_MODE_ROTATION, DXGI_MODE_SCALING, DXGI_MODE_SCANLINE_ORDER, DXGI_RATIONAL, DXGI_SAMPLE_DESC}
#Import "..\Graphics.Gdi\Types.ahk" {HDC, HMONITOR}
#Import "..\Security\Types.ahk" {SECURITY_ATTRIBUTES}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct DXGI_RGBA {
    r : Float32
    g : Float32
    b : Float32
    a : Float32
}
struct DXGI_USAGE extends UInt32 {
    static DXGI_USAGE_SHADER_INPUT := 16
    static DXGI_USAGE_RENDER_TARGET_OUTPUT := 32
    static DXGI_USAGE_BACK_BUFFER := 64
    static DXGI_USAGE_SHARED := 128
    static DXGI_USAGE_READ_ONLY := 256
    static DXGI_USAGE_DISCARD_ON_PRESENT := 512
    static DXGI_USAGE_UNORDERED_ACCESS := 1024
}
struct DXGI_PRESENT extends UInt32 {
    static DXGI_PRESENT_TEST := 1
    static DXGI_PRESENT_DO_NOT_SEQUENCE := 2
    static DXGI_PRESENT_RESTART := 4
    static DXGI_PRESENT_DO_NOT_WAIT := 8
    static DXGI_PRESENT_STEREO_PREFER_RIGHT := 16
    static DXGI_PRESENT_STEREO_TEMPORARY_MONO := 32
    static DXGI_PRESENT_RESTRICT_TO_OUTPUT := 64
    static DXGI_PRESENT_USE_DURATION := 256
    static DXGI_PRESENT_ALLOW_TEARING := 512
}
struct DXGI_ENUM_MODES extends UInt32 {
    static DXGI_ENUM_MODES_INTERLACED := 1
    static DXGI_ENUM_MODES_SCALING := 2
    static DXGI_ENUM_MODES_STEREO := 4
    static DXGI_ENUM_MODES_DISABLED_STEREO := 8
}
struct DXGI_MWA_FLAGS extends UInt32 {
    static DXGI_MWA_NO_WINDOW_CHANGES := 1
    static DXGI_MWA_NO_ALT_ENTER := 2
    static DXGI_MWA_NO_PRINT_SCREEN := 4
    static DXGI_MWA_VALID := 7
}
struct DXGI_MAP_FLAGS extends UInt32 {
    static DXGI_MAP_READ := 1
    static DXGI_MAP_WRITE := 2
    static DXGI_MAP_DISCARD := 4
}
struct DXGI_RESOURCE_PRIORITY extends UInt32 {
    static DXGI_RESOURCE_PRIORITY_MINIMUM := 671088640
    static DXGI_RESOURCE_PRIORITY_LOW := 1342177280
    static DXGI_RESOURCE_PRIORITY_NORMAL := 2013265920
    static DXGI_RESOURCE_PRIORITY_HIGH := 2684354560
    static DXGI_RESOURCE_PRIORITY_MAXIMUM := 3355443200
}
struct DXGI_SHARED_RESOURCE_RW extends UInt32 {
    static DXGI_SHARED_RESOURCE_READ := 2147483648
    static DXGI_SHARED_RESOURCE_WRITE := 1
}
struct DXGI_CREATE_FACTORY_FLAGS extends UInt32 {
    static DXGI_CREATE_FACTORY_DEBUG := 1
}
struct DXGI_FRAME_STATISTICS {
    PresentCount : UInt32
    PresentRefreshCount : UInt32
    SyncRefreshCount : UInt32
    SyncQPCTime : Int64
    SyncGPUTime : Int64
}
struct DXGI_MAPPED_RECT {
    Pitch : Int32
    pBits : UInt8.Ptr
}
struct DXGI_ADAPTER_DESC {
    Description : UInt16[128]
    VendorId : UInt32
    DeviceId : UInt32
    SubSysId : UInt32
    Revision : UInt32
    DedicatedVideoMemory : IntPtr
    DedicatedSystemMemory : IntPtr
    SharedSystemMemory : IntPtr
    AdapterLuid : LUID
}
struct DXGI_OUTPUT_DESC {
    DeviceName : UInt16[32]
    DesktopCoordinates : RECT
    AttachedToDesktop : BOOL
    Rotation : DXGI_MODE_ROTATION
    Monitor : HMONITOR
}
struct DXGI_SHARED_RESOURCE {
    Handle : HANDLE
}
struct DXGI_RESIDENCY extends Int32 {
    static DXGI_RESIDENCY_FULLY_RESIDENT := 1
    static DXGI_RESIDENCY_RESIDENT_IN_SHARED_MEMORY := 2
    static DXGI_RESIDENCY_EVICTED_TO_DISK := 3
}
struct DXGI_SURFACE_DESC {
    Width : UInt32
    Height : UInt32
    Format : DXGI_FORMAT
    SampleDesc : DXGI_SAMPLE_DESC
}
struct DXGI_SWAP_EFFECT extends Int32 {
    static DXGI_SWAP_EFFECT_DISCARD := 0
    static DXGI_SWAP_EFFECT_SEQUENTIAL := 1
    static DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL := 3
    static DXGI_SWAP_EFFECT_FLIP_DISCARD := 4
}
struct DXGI_SWAP_CHAIN_FLAG extends Int32 {
    static DXGI_SWAP_CHAIN_FLAG_NONPREROTATED := 1
    static DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH := 2
    static DXGI_SWAP_CHAIN_FLAG_GDI_COMPATIBLE := 4
    static DXGI_SWAP_CHAIN_FLAG_RESTRICTED_CONTENT := 8
    static DXGI_SWAP_CHAIN_FLAG_RESTRICT_SHARED_RESOURCE_DRIVER := 16
    static DXGI_SWAP_CHAIN_FLAG_DISPLAY_ONLY := 32
    static DXGI_SWAP_CHAIN_FLAG_FRAME_LATENCY_WAITABLE_OBJECT := 64
    static DXGI_SWAP_CHAIN_FLAG_FOREGROUND_LAYER := 128
    static DXGI_SWAP_CHAIN_FLAG_FULLSCREEN_VIDEO := 256
    static DXGI_SWAP_CHAIN_FLAG_YUV_VIDEO := 512
    static DXGI_SWAP_CHAIN_FLAG_HW_PROTECTED := 1024
    static DXGI_SWAP_CHAIN_FLAG_ALLOW_TEARING := 2048
    static DXGI_SWAP_CHAIN_FLAG_RESTRICTED_TO_ALL_HOLOGRAPHIC_DISPLAYS := 4096
    static DXGI_SWAP_CHAIN_FLAG_USE_DEFAULT_COLOR_SPACE := 32768
}
struct DXGI_SWAP_CHAIN_DESC {
    BufferDesc : DXGI_MODE_DESC
    SampleDesc : DXGI_SAMPLE_DESC
    BufferUsage : DXGI_USAGE
    BufferCount : UInt32
    OutputWindow : HWND
    Windowed : BOOL
    SwapEffect : DXGI_SWAP_EFFECT
    Flags : UInt32
}
struct IDXGIObject extends IUnknown {
    static IID := "{AEC22FB8-76F3-4639-9BE0-28EB43A67A2E}"
    SetPrivateData(Name, pData)
      => ComCall(3, this.p, GUID.Ptr, Name, UInt32, pData.Size, Struct.Ptr, pData)
    SetPrivateDataInterface(Name, pUnknown?)
      => ComCall(4, this.p, GUID.Ptr, Name, IUnknown, pUnknown?)
    GetPrivateData(Name, pDataSize, pData)
      => ComCall(5, this.p, GUID.Ptr, Name, UInt32.Ptr, pDataSize, Struct.Ptr, pData)
    GetParent(riid, ppParent)
      => ComCall(6, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppParent)
}
struct IDXGIDeviceSubObject extends IDXGIObject {
    static IID := "{3D3E0379-F9DE-4D58-BB6C-18D62992F1A6}"
    GetDevice(riid, ppDevice)
      => ComCall(7, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppDevice)
}
struct IDXGIResource extends IDXGIDeviceSubObject {
    static IID := "{035F3AB4-482E-4E50-B41F-8A7F8BD8960B}"
    GetSharedHandle(pSharedHandle)
      => ComCall(8, this.p, HANDLE.Ptr, pSharedHandle)
    GetUsage(pUsage)
      => ComCall(9, this.p, DXGI_USAGE.Ptr, pUsage)
    SetEvictionPriority(EvictionPriority)
      => ComCall(10, this.p, DXGI_RESOURCE_PRIORITY, EvictionPriority)
    GetEvictionPriority(pEvictionPriority)
      => ComCall(11, this.p, DXGI_RESOURCE_PRIORITY.Ptr, pEvictionPriority)
}
struct IDXGIKeyedMutex extends IDXGIDeviceSubObject {
    static IID := "{9D8E1289-D7B3-465F-8126-250E349AF85D}"
    AcquireSync(Key, dwMilliseconds)
      => ComCall(8, this.p, Int64, Key, UInt32, dwMilliseconds)
    ReleaseSync(Key)
      => ComCall(9, this.p, Int64, Key)
}
struct IDXGISurface extends IDXGIDeviceSubObject {
    static IID := "{CAFCB56C-6AC3-4889-BF47-9E23BBD260EC}"
    GetDesc(pDesc)
      => ComCall(8, this.p, DXGI_SURFACE_DESC.Ptr, pDesc)
    Map(pLockedRect, MapFlags)
      => ComCall(9, this.p, DXGI_MAPPED_RECT.Ptr, pLockedRect, DXGI_MAP_FLAGS, MapFlags)
    Unmap()
      => ComCall(10, this.p)
}
struct IDXGISurface1 extends IDXGISurface {
    static IID := "{4AE63092-6327-4C1B-80AE-BFE12EA32B86}"
    GetDC(Discard, phdc)
      => ComCall(11, this.p, BOOL, Discard, HDC.Ptr, phdc)
    ReleaseDC(pDirtyRect?)
      => ComCall(12, this.p, RECT.Ptr, pDirtyRect?)
}
struct IDXGIAdapter extends IDXGIObject {
    static IID := "{2411E7E1-12AC-4CCF-BD14-9798E8534DC0}"
    EnumOutputs(Output, ppOutput)
      => ComCall(7, this.p, UInt32, Output, IDXGIOutput.Ptr, ppOutput, HRESULT)
    GetDesc(pDesc)
      => ComCall(8, this.p, DXGI_ADAPTER_DESC.Ptr, pDesc)
    CheckInterfaceSupport(InterfaceName, pUMDVersion)
      => ComCall(9, this.p, GUID.Ptr, InterfaceName, Int64.Ptr, pUMDVersion)
}
struct IDXGIOutput extends IDXGIObject {
    static IID := "{AE02EEDB-C735-4690-8D52-5A8DC20213AA}"
    GetDesc(pDesc)
      => ComCall(7, this.p, DXGI_OUTPUT_DESC.Ptr, pDesc)
    GetDisplayModeList(EnumFormat, Flags, pDesc?)
      => ComCall(8, this.p, DXGI_FORMAT, EnumFormat, DXGI_ENUM_MODES, Flags, UInt32.Ptr, pDesc?.Length ?? 0, DXGI_MODE_DESC.Ptr, pDesc?)
    FindClosestMatchingMode(pModeToMatch, pClosestMatch, pConcernedDevice?)
      => ComCall(9, this.p, DXGI_MODE_DESC.Ptr, pModeToMatch, DXGI_MODE_DESC.Ptr, pClosestMatch, IUnknown, pConcernedDevice?)
    WaitForVBlank()
      => ComCall(10, this.p)
    TakeOwnership(pDevice, Exclusive)
      => ComCall(11, this.p, IUnknown, pDevice, BOOL, Exclusive)
    ReleaseOwnership()
      => ComCall(12, this.p, "void")
    GetGammaControlCapabilities(pGammaCaps)
      => ComCall(13, this.p, DXGI_GAMMA_CONTROL_CAPABILITIES.Ptr, pGammaCaps)
    SetGammaControl(pArray)
      => ComCall(14, this.p, DXGI_GAMMA_CONTROL.Ptr, pArray)
    GetGammaControl(pArray)
      => ComCall(15, this.p, DXGI_GAMMA_CONTROL.Ptr, pArray)
    SetDisplaySurface(pScanoutSurface)
      => ComCall(16, this.p, IDXGISurface, pScanoutSurface)
    GetDisplaySurfaceData(pDestination)
      => ComCall(17, this.p, IDXGISurface, pDestination)
    GetFrameStatistics(pStats)
      => ComCall(18, this.p, DXGI_FRAME_STATISTICS.Ptr, pStats)
}
struct IDXGISwapChain extends IDXGIDeviceSubObject {
    static IID := "{310D36A0-D2E7-4C0A-AA04-6A9D23B8886A}"
    Present(SyncInterval, Flags)
      => ComCall(8, this.p, UInt32, SyncInterval, DXGI_PRESENT, Flags)
    GetBuffer(Buffer, riid, ppSurface)
      => ComCall(9, this.p, UInt32, Buffer, GUID.Ptr, riid, Struct.Ptr.Ptr, ppSurface)
    SetFullscreenState(Fullscreen, pTarget?)
      => ComCall(10, this.p, BOOL, Fullscreen, IDXGIOutput, pTarget?)
    GetFullscreenState(pFullscreen?, ppTarget?)
      => ComCall(11, this.p, BOOL.Ptr, pFullscreen?, IDXGIOutput.Ptr, ppTarget?)
    GetDesc(pDesc)
      => ComCall(12, this.p, DXGI_SWAP_CHAIN_DESC.Ptr, pDesc)
    ResizeBuffers(BufferCount, Width, Height, NewFormat, SwapChainFlags)
      => ComCall(13, this.p, UInt32, BufferCount, UInt32, Width, UInt32, Height, DXGI_FORMAT, NewFormat, UInt32, SwapChainFlags)
    ResizeTarget(pNewTargetParameters)
      => ComCall(14, this.p, DXGI_MODE_DESC.Ptr, pNewTargetParameters)
    GetContainingOutput(ppOutput)
      => ComCall(15, this.p, IDXGIOutput.Ptr, ppOutput)
    GetFrameStatistics(pStats)
      => ComCall(16, this.p, DXGI_FRAME_STATISTICS.Ptr, pStats)
    GetLastPresentCount(pLastPresentCount)
      => ComCall(17, this.p, UInt32.Ptr, pLastPresentCount)
}
struct IDXGIFactory extends IDXGIObject {
    static IID := "{7B7166EC-21C7-44AE-B21A-C9AE321AE369}"
    EnumAdapters(Adapter, ppAdapter)
      => ComCall(7, this.p, UInt32, Adapter, IDXGIAdapter.Ptr, ppAdapter)
    MakeWindowAssociation(WindowHandle, Flags)
      => ComCall(8, this.p, HWND, WindowHandle, DXGI_MWA_FLAGS, Flags)
    GetWindowAssociation(pWindowHandle)
      => ComCall(9, this.p, HWND.Ptr, pWindowHandle)
    CreateSwapChain(pDevice, pDesc, ppSwapChain)
      => ComCall(10, this.p, IUnknown, pDevice, DXGI_SWAP_CHAIN_DESC.Ptr, pDesc, IDXGISwapChain.Ptr, ppSwapChain)
    CreateSoftwareAdapter(Module, ppAdapter)
      => ComCall(11, this.p, HMODULE, Module, IDXGIAdapter.Ptr, ppAdapter)
}
struct IDXGIDevice extends IDXGIObject {
    static IID := "{54EC77FA-1377-44E6-8C32-88FD5F44C84C}"
    GetAdapter(pAdapter)
      => ComCall(7, this.p, IDXGIAdapter.Ptr, pAdapter)
    CreateSurface(pDesc, Usage, pSharedResource?, ppSurface)
      => ComCall(8, this.p, DXGI_SURFACE_DESC.Ptr, pDesc, UInt32, ppSurface.Length, DXGI_USAGE, Usage, DXGI_SHARED_RESOURCE.Ptr, pSharedResource?, IDXGISurface.Ptr, ppSurface)
    QueryResourceResidency(ppResources, pResidencyStatus)
      => ComCall(9, this.p, IUnknown.Ptr, ppResources, DXGI_RESIDENCY.Ptr, pResidencyStatus, UInt32, pResidencyStatus.Length)
    SetGPUThreadPriority(Priority)
      => ComCall(10, this.p, Int32, Priority)
    GetGPUThreadPriority(pPriority)
      => ComCall(11, this.p, Int32.Ptr, pPriority)
}
struct DXGI_ADAPTER_FLAG extends Int32 {
    static DXGI_ADAPTER_FLAG_NONE := 0
    static DXGI_ADAPTER_FLAG_REMOTE := 1
    static DXGI_ADAPTER_FLAG_SOFTWARE := 2
}
struct DXGI_ADAPTER_DESC1 {
    Description : UInt16[128]
    VendorId : UInt32
    DeviceId : UInt32
    SubSysId : UInt32
    Revision : UInt32
    DedicatedVideoMemory : IntPtr
    DedicatedSystemMemory : IntPtr
    SharedSystemMemory : IntPtr
    AdapterLuid : LUID
    Flags : UInt32
}
struct DXGI_DISPLAY_COLOR_SPACE {
    PrimaryCoordinates : Float32[16]
    WhitePoints : Float32[32]
}
struct IDXGIFactory1 extends IDXGIFactory {
    static IID := "{770AAE78-F26F-4DBA-A829-253C83D1B387}"
    EnumAdapters1(Adapter, ppAdapter)
      => ComCall(12, this.p, UInt32, Adapter, IDXGIAdapter1.Ptr, ppAdapter, HRESULT)
    IsCurrent()
      => ComCall(13, this.p, BOOL)
}
struct IDXGIAdapter1 extends IDXGIAdapter {
    static IID := "{29038F61-3839-4626-91FD-086879011A05}"
    GetDesc1(pDesc)
      => ComCall(10, this.p, DXGI_ADAPTER_DESC1.Ptr, pDesc)
}
struct IDXGIDevice1 extends IDXGIDevice {
    static IID := "{77DB970F-6276-48BA-BA28-070143B4392C}"
    SetMaximumFrameLatency(MaxLatency)
      => ComCall(12, this.p, UInt32, MaxLatency)
    GetMaximumFrameLatency(pMaxLatency)
      => ComCall(13, this.p, UInt32.Ptr, pMaxLatency)
}
struct IDXGIDisplayControl extends IUnknown {
    static IID := "{EA9DBF1A-C88E-4486-854A-98AA0138F30C}"
    IsStereoEnabled()
      => ComCall(3, this.p, BOOL)
    SetStereoEnabled(enabled)
      => ComCall(4, this.p, BOOL, enabled, "void")
}
struct DXGI_OUTDUPL_MOVE_RECT {
    SourcePoint : POINT
    DestinationRect : RECT
}
struct DXGI_OUTDUPL_DESC {
    ModeDesc : DXGI_MODE_DESC
    Rotation : DXGI_MODE_ROTATION
    DesktopImageInSystemMemory : BOOL
}
struct DXGI_OUTDUPL_POINTER_POSITION {
    Position : POINT
    Visible : BOOL
}
struct DXGI_OUTDUPL_POINTER_SHAPE_TYPE extends Int32 {
    static DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MONOCHROME := 1
    static DXGI_OUTDUPL_POINTER_SHAPE_TYPE_COLOR := 2
    static DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MASKED_COLOR := 4
}
struct DXGI_OUTDUPL_POINTER_SHAPE_INFO {
    Type : UInt32
    Width : UInt32
    Height : UInt32
    Pitch : UInt32
    HotSpot : POINT
}
struct DXGI_OUTDUPL_FRAME_INFO {
    LastPresentTime : Int64
    LastMouseUpdateTime : Int64
    AccumulatedFrames : UInt32
    RectsCoalesced : BOOL
    ProtectedContentMaskedOut : BOOL
    PointerPosition : DXGI_OUTDUPL_POINTER_POSITION
    TotalMetadataBufferSize : UInt32
    PointerShapeBufferSize : UInt32
}
struct IDXGIOutputDuplication extends IDXGIObject {
    static IID := "{191CFAC3-A341-470D-B26E-A864F428319C}"
    GetDesc(pDesc)
      => ComCall(7, this.p, DXGI_OUTDUPL_DESC.Ptr, pDesc, "void")
    AcquireNextFrame(TimeoutInMilliseconds, pFrameInfo, ppDesktopResource)
      => ComCall(8, this.p, UInt32, TimeoutInMilliseconds, DXGI_OUTDUPL_FRAME_INFO.Ptr, pFrameInfo, IDXGIResource.Ptr, ppDesktopResource)
    GetFrameDirtyRects(pDirtyRectsBuffer, pDirtyRectsBufferSizeRequired)
      => ComCall(9, this.p, UInt32, pDirtyRectsBuffer.Size, RECT.Ptr, pDirtyRectsBuffer, UInt32.Ptr, pDirtyRectsBufferSizeRequired)
    GetFrameMoveRects(pMoveRectBuffer, pMoveRectsBufferSizeRequired)
      => ComCall(10, this.p, UInt32, pMoveRectBuffer.Size, DXGI_OUTDUPL_MOVE_RECT.Ptr, pMoveRectBuffer, UInt32.Ptr, pMoveRectsBufferSizeRequired)
    GetFramePointerShape(pPointerShapeBuffer, pPointerShapeBufferSizeRequired, pPointerShapeInfo)
      => ComCall(11, this.p, UInt32, pPointerShapeBuffer.Size, Struct.Ptr, pPointerShapeBuffer, UInt32.Ptr, pPointerShapeBufferSizeRequired, DXGI_OUTDUPL_POINTER_SHAPE_INFO.Ptr, pPointerShapeInfo)
    MapDesktopSurface(pLockedRect)
      => ComCall(12, this.p, DXGI_MAPPED_RECT.Ptr, pLockedRect)
    UnMapDesktopSurface()
      => ComCall(13, this.p)
    ReleaseFrame()
      => ComCall(14, this.p)
}
struct IDXGISurface2 extends IDXGISurface1 {
    static IID := "{ABA496DD-B617-4CB8-A866-BC44D7EB1FA2}"
    GetResource(riid, ppParentResource, pSubresourceIndex)
      => ComCall(13, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppParentResource, UInt32.Ptr, pSubresourceIndex)
}
struct IDXGIResource1 extends IDXGIResource {
    static IID := "{30961379-4609-4A41-998E-54FE567EE0C1}"
    CreateSubresourceSurface(index, ppSurface)
      => ComCall(12, this.p, UInt32, index, IDXGISurface2.Ptr, ppSurface)
    CreateSharedHandle(pAttributes?, dwAccess, lpName?, pHandle)
      => ComCall(13, this.p, SECURITY_ATTRIBUTES.Ptr, pAttributes?, UInt32, dwAccess, "Str", lpName?, HANDLE.Ptr, pHandle)
}
struct DXGI_OFFER_RESOURCE_PRIORITY extends Int32 {
    static DXGI_OFFER_RESOURCE_PRIORITY_LOW := 1
    static DXGI_OFFER_RESOURCE_PRIORITY_NORMAL := 2
    static DXGI_OFFER_RESOURCE_PRIORITY_HIGH := 3
}
struct IDXGIDevice2 extends IDXGIDevice1 {
    static IID := "{05008617-FBFD-4051-A790-144884B4F6A9}"
    OfferResources(ppResources, Priority)
      => ComCall(14, this.p, UInt32, ppResources.Length, IDXGIResource.Ptr, ppResources, DXGI_OFFER_RESOURCE_PRIORITY, Priority)
    ReclaimResources(ppResources, pDiscarded?)
      => ComCall(15, this.p, UInt32, pDiscarded?.Length ?? 0, IDXGIResource.Ptr, ppResources, BOOL.Ptr, pDiscarded?)
    EnqueueSetEvent(hEvent)
      => ComCall(16, this.p, HANDLE, hEvent)
}
struct DXGI_MODE_DESC1 {
    Width : UInt32
    Height : UInt32
    RefreshRate : DXGI_RATIONAL
    Format : DXGI_FORMAT
    ScanlineOrdering : DXGI_MODE_SCANLINE_ORDER
    Scaling : DXGI_MODE_SCALING
    Stereo : BOOL
}
struct DXGI_SCALING extends Int32 {
    static DXGI_SCALING_STRETCH := 0
    static DXGI_SCALING_NONE := 1
    static DXGI_SCALING_ASPECT_RATIO_STRETCH := 2
}
struct DXGI_SWAP_CHAIN_DESC1 {
    Width : UInt32
    Height : UInt32
    Format : DXGI_FORMAT
    Stereo : BOOL
    SampleDesc : DXGI_SAMPLE_DESC
    BufferUsage : DXGI_USAGE
    BufferCount : UInt32
    Scaling : DXGI_SCALING
    SwapEffect : DXGI_SWAP_EFFECT
    AlphaMode : DXGI_ALPHA_MODE
    Flags : UInt32
}
struct DXGI_SWAP_CHAIN_FULLSCREEN_DESC {
    RefreshRate : DXGI_RATIONAL
    ScanlineOrdering : DXGI_MODE_SCANLINE_ORDER
    Scaling : DXGI_MODE_SCALING
    Windowed : BOOL
}
struct DXGI_PRESENT_PARAMETERS {
    DirtyRectsCount : UInt32
    pDirtyRects : RECT.Ptr
    pScrollRect : RECT.Ptr
    pScrollOffset : POINT.Ptr
}
struct IDXGISwapChain1 extends IDXGISwapChain {
    static IID := "{790A45F7-0D42-4876-983A-0A55CFE6F4AA}"
    GetDesc1(pDesc)
      => ComCall(18, this.p, DXGI_SWAP_CHAIN_DESC1.Ptr, pDesc)
    GetFullscreenDesc(pDesc)
      => ComCall(19, this.p, DXGI_SWAP_CHAIN_FULLSCREEN_DESC.Ptr, pDesc)
    GetHwnd(pHwnd)
      => ComCall(20, this.p, HWND.Ptr, pHwnd)
    GetCoreWindow(refiid, ppUnk)
      => ComCall(21, this.p, GUID.Ptr, refiid, Struct.Ptr.Ptr, ppUnk)
    Present1(SyncInterval, PresentFlags, pPresentParameters)
      => ComCall(22, this.p, UInt32, SyncInterval, DXGI_PRESENT, PresentFlags, DXGI_PRESENT_PARAMETERS.Ptr, pPresentParameters)
    IsTemporaryMonoSupported()
      => ComCall(23, this.p, BOOL)
    GetRestrictToOutput(ppRestrictToOutput)
      => ComCall(24, this.p, IDXGIOutput.Ptr, ppRestrictToOutput)
    SetBackgroundColor(pColor)
      => ComCall(25, this.p, DXGI_RGBA.Ptr, pColor)
    GetBackgroundColor(pColor)
      => ComCall(26, this.p, DXGI_RGBA.Ptr, pColor)
    SetRotation(Rotation)
      => ComCall(27, this.p, DXGI_MODE_ROTATION, Rotation)
    GetRotation(pRotation)
      => ComCall(28, this.p, DXGI_MODE_ROTATION.Ptr, pRotation)
}
struct IDXGIFactory2 extends IDXGIFactory1 {
    static IID := "{50C83A1C-E072-4C48-87B0-3630FA36A6D0}"
    IsWindowedStereoEnabled()
      => ComCall(14, this.p, BOOL)
    CreateSwapChainForHwnd(pDevice, hWnd1, pDesc, pFullscreenDesc?, pRestrictToOutput?, ppSwapChain)
      => ComCall(15, this.p, IUnknown, pDevice, HWND, hWnd1, DXGI_SWAP_CHAIN_DESC1.Ptr, pDesc, DXGI_SWAP_CHAIN_FULLSCREEN_DESC.Ptr, pFullscreenDesc?, IDXGIOutput, pRestrictToOutput?, IDXGISwapChain1.Ptr, ppSwapChain)
    CreateSwapChainForCoreWindow(pDevice, pWindow, pDesc, pRestrictToOutput?, ppSwapChain)
      => ComCall(16, this.p, IUnknown, pDevice, IUnknown, pWindow, DXGI_SWAP_CHAIN_DESC1.Ptr, pDesc, IDXGIOutput, pRestrictToOutput?, IDXGISwapChain1.Ptr, ppSwapChain)
    GetSharedResourceAdapterLuid(hResource, pLuid)
      => ComCall(17, this.p, HANDLE, hResource, LUID.Ptr, pLuid)
    RegisterStereoStatusWindow(WindowHandle, wMsg, pdwCookie)
      => ComCall(18, this.p, HWND, WindowHandle, UInt32, wMsg, UInt32.Ptr, pdwCookie)
    RegisterStereoStatusEvent(hEvent, pdwCookie)
      => ComCall(19, this.p, HANDLE, hEvent, UInt32.Ptr, pdwCookie)
    UnregisterStereoStatus(dwCookie)
      => ComCall(20, this.p, UInt32, dwCookie, "void")
    RegisterOcclusionStatusWindow(WindowHandle, wMsg, pdwCookie)
      => ComCall(21, this.p, HWND, WindowHandle, UInt32, wMsg, UInt32.Ptr, pdwCookie)
    RegisterOcclusionStatusEvent(hEvent, pdwCookie)
      => ComCall(22, this.p, HANDLE, hEvent, UInt32.Ptr, pdwCookie)
    UnregisterOcclusionStatus(dwCookie)
      => ComCall(23, this.p, UInt32, dwCookie, "void")
    CreateSwapChainForComposition(pDevice, pDesc, pRestrictToOutput?, ppSwapChain)
      => ComCall(24, this.p, IUnknown, pDevice, DXGI_SWAP_CHAIN_DESC1.Ptr, pDesc, IDXGIOutput, pRestrictToOutput?, IDXGISwapChain1.Ptr, ppSwapChain)
}
struct DXGI_GRAPHICS_PREEMPTION_GRANULARITY extends Int32 {
    static DXGI_GRAPHICS_PREEMPTION_DMA_BUFFER_BOUNDARY := 0
    static DXGI_GRAPHICS_PREEMPTION_PRIMITIVE_BOUNDARY := 1
    static DXGI_GRAPHICS_PREEMPTION_TRIANGLE_BOUNDARY := 2
    static DXGI_GRAPHICS_PREEMPTION_PIXEL_BOUNDARY := 3
    static DXGI_GRAPHICS_PREEMPTION_INSTRUCTION_BOUNDARY := 4
}
struct DXGI_COMPUTE_PREEMPTION_GRANULARITY extends Int32 {
    static DXGI_COMPUTE_PREEMPTION_DMA_BUFFER_BOUNDARY := 0
    static DXGI_COMPUTE_PREEMPTION_DISPATCH_BOUNDARY := 1
    static DXGI_COMPUTE_PREEMPTION_THREAD_GROUP_BOUNDARY := 2
    static DXGI_COMPUTE_PREEMPTION_THREAD_BOUNDARY := 3
    static DXGI_COMPUTE_PREEMPTION_INSTRUCTION_BOUNDARY := 4
}
struct DXGI_ADAPTER_DESC2 {
    Description : UInt16[128]
    VendorId : UInt32
    DeviceId : UInt32
    SubSysId : UInt32
    Revision : UInt32
    DedicatedVideoMemory : IntPtr
    DedicatedSystemMemory : IntPtr
    SharedSystemMemory : IntPtr
    AdapterLuid : LUID
    Flags : UInt32
    GraphicsPreemptionGranularity : DXGI_GRAPHICS_PREEMPTION_GRANULARITY
    ComputePreemptionGranularity : DXGI_COMPUTE_PREEMPTION_GRANULARITY
}
struct IDXGIAdapter2 extends IDXGIAdapter1 {
    static IID := "{0AA1AE0A-FA0E-4B84-8644-E05FF8E5ACB5}"
    GetDesc2(pDesc)
      => ComCall(11, this.p, DXGI_ADAPTER_DESC2.Ptr, pDesc)
}
struct IDXGIOutput1 extends IDXGIOutput {
    static IID := "{00CDDEA8-939B-4B83-A340-A685226666CC}"
    GetDisplayModeList1(EnumFormat, Flags, pDesc?)
      => ComCall(19, this.p, DXGI_FORMAT, EnumFormat, DXGI_ENUM_MODES, Flags, UInt32.Ptr, pDesc?.Length ?? 0, DXGI_MODE_DESC1.Ptr, pDesc?)
    FindClosestMatchingMode1(pModeToMatch, pClosestMatch, pConcernedDevice?)
      => ComCall(20, this.p, DXGI_MODE_DESC1.Ptr, pModeToMatch, DXGI_MODE_DESC1.Ptr, pClosestMatch, IUnknown, pConcernedDevice?)
    GetDisplaySurfaceData1(pDestination)
      => ComCall(21, this.p, IDXGIResource, pDestination)
    DuplicateOutput(pDevice, ppOutputDuplication)
      => ComCall(22, this.p, IUnknown, pDevice, IDXGIOutputDuplication.Ptr, ppOutputDuplication)
}
struct IDXGIDevice3 extends IDXGIDevice2 {
    static IID := "{6007896C-3244-4AFD-BF18-A6D3BEDA5023}"
    Trim()
      => ComCall(17, this.p, "void")
}
struct DXGI_MATRIX_3X2_F {
    _11 : Float32
    _12 : Float32
    _21 : Float32
    _22 : Float32
    _31 : Float32
    _32 : Float32
}
struct IDXGISwapChain2 extends IDXGISwapChain1 {
    static IID := "{A8BE2AC4-199F-4946-B331-79599FB98DE7}"
    SetSourceSize(Width, Height)
      => ComCall(29, this.p, UInt32, Width, UInt32, Height)
    GetSourceSize(pWidth, pHeight)
      => ComCall(30, this.p, UInt32.Ptr, pWidth, UInt32.Ptr, pHeight)
    SetMaximumFrameLatency(MaxLatency)
      => ComCall(31, this.p, UInt32, MaxLatency)
    GetMaximumFrameLatency(pMaxLatency)
      => ComCall(32, this.p, UInt32.Ptr, pMaxLatency)
    GetFrameLatencyWaitableObject()
      => ComCall(33, this.p, HANDLE)
    SetMatrixTransform(pMatrix)
      => ComCall(34, this.p, DXGI_MATRIX_3X2_F.Ptr, pMatrix)
    GetMatrixTransform(pMatrix)
      => ComCall(35, this.p, DXGI_MATRIX_3X2_F.Ptr, pMatrix)
}
struct IDXGIOutput2 extends IDXGIOutput1 {
    static IID := "{595E39D1-2724-4663-99B1-DA969DE28364}"
    SupportsOverlays()
      => ComCall(23, this.p, BOOL)
}
struct IDXGIFactory3 extends IDXGIFactory2 {
    static IID := "{25483823-CD46-4C7D-86CA-47AA95B837BD}"
    GetCreationFlags()
      => ComCall(25, this.p, DXGI_CREATE_FACTORY_FLAGS)
}
struct DXGI_DECODE_SWAP_CHAIN_DESC {
    Flags : UInt32
}
struct DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS extends Int32 {
    static DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_NOMINAL_RANGE := 1
    static DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_BT709 := 2
    static DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_xvYCC := 4
}
struct IDXGIDecodeSwapChain extends IUnknown {
    static IID := "{2633066B-4514-4C7A-8FD8-12EA98059D18}"
    PresentBuffer(BufferToPresent, SyncInterval, Flags)
      => ComCall(3, this.p, UInt32, BufferToPresent, UInt32, SyncInterval, DXGI_PRESENT, Flags)
    SetSourceRect(pRect)
      => ComCall(4, this.p, RECT.Ptr, pRect)
    SetTargetRect(pRect)
      => ComCall(5, this.p, RECT.Ptr, pRect)
    SetDestSize(Width, Height)
      => ComCall(6, this.p, UInt32, Width, UInt32, Height)
    GetSourceRect(pRect)
      => ComCall(7, this.p, RECT.Ptr, pRect)
    GetTargetRect(pRect)
      => ComCall(8, this.p, RECT.Ptr, pRect)
    GetDestSize(pWidth, pHeight)
      => ComCall(9, this.p, UInt32.Ptr, pWidth, UInt32.Ptr, pHeight)
    SetColorSpace(ColorSpace)
      => ComCall(10, this.p, DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS, ColorSpace)
    GetColorSpace()
      => ComCall(11, this.p, DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS)
}
struct IDXGIFactoryMedia extends IUnknown {
    static IID := "{41E7D1F2-A591-4F7B-A2E5-FA9C843E1C12}"
    CreateSwapChainForCompositionSurfaceHandle(pDevice, hSurface?, pDesc, pRestrictToOutput?, ppSwapChain)
      => ComCall(3, this.p, IUnknown, pDevice, HANDLE, hSurface?, DXGI_SWAP_CHAIN_DESC1.Ptr, pDesc, IDXGIOutput, pRestrictToOutput?, IDXGISwapChain1.Ptr, ppSwapChain)
    CreateDecodeSwapChainForCompositionSurfaceHandle(pDevice, hSurface?, pDesc, pYuvDecodeBuffers, pRestrictToOutput?, ppSwapChain)
      => ComCall(4, this.p, IUnknown, pDevice, HANDLE, hSurface?, DXGI_DECODE_SWAP_CHAIN_DESC.Ptr, pDesc, IDXGIResource, pYuvDecodeBuffers, IDXGIOutput, pRestrictToOutput?, IDXGIDecodeSwapChain.Ptr, ppSwapChain)
}
struct DXGI_FRAME_PRESENTATION_MODE extends Int32 {
    static DXGI_FRAME_PRESENTATION_MODE_COMPOSED := 0
    static DXGI_FRAME_PRESENTATION_MODE_OVERLAY := 1
    static DXGI_FRAME_PRESENTATION_MODE_NONE := 2
    static DXGI_FRAME_PRESENTATION_MODE_COMPOSITION_FAILURE := 3
}
struct DXGI_FRAME_STATISTICS_MEDIA {
    PresentCount : UInt32
    PresentRefreshCount : UInt32
    SyncRefreshCount : UInt32
    SyncQPCTime : Int64
    SyncGPUTime : Int64
    CompositionMode : DXGI_FRAME_PRESENTATION_MODE
    ApprovedPresentDuration : UInt32
}
struct IDXGISwapChainMedia extends IUnknown {
    static IID := "{DD95B90B-F05F-4F6A-BD65-25BFB264BD84}"
    GetFrameStatisticsMedia(pStats)
      => ComCall(3, this.p, DXGI_FRAME_STATISTICS_MEDIA.Ptr, pStats)
    SetPresentDuration(Duration)
      => ComCall(4, this.p, UInt32, Duration)
    CheckPresentDurationSupport(DesiredPresentDuration, pClosestSmallerPresentDuration, pClosestLargerPresentDuration)
      => ComCall(5, this.p, UInt32, DesiredPresentDuration, UInt32.Ptr, pClosestSmallerPresentDuration, UInt32.Ptr, pClosestLargerPresentDuration)
}
struct DXGI_OVERLAY_SUPPORT_FLAG extends Int32 {
    static DXGI_OVERLAY_SUPPORT_FLAG_DIRECT := 1
    static DXGI_OVERLAY_SUPPORT_FLAG_SCALING := 2
}
struct IDXGIOutput3 extends IDXGIOutput2 {
    static IID := "{8A6BB301-7E7E-41F4-A8E0-5B32F7F99B18}"
    CheckOverlaySupport(EnumFormat, pConcernedDevice, pFlags)
      => ComCall(24, this.p, DXGI_FORMAT, EnumFormat, IUnknown, pConcernedDevice, UInt32.Ptr, pFlags)
}
struct DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG extends Int32 {
    static DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_PRESENT := 1
    static DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_OVERLAY_PRESENT := 2
}
struct IDXGISwapChain3 extends IDXGISwapChain2 {
    static IID := "{94D99BDB-F1F8-4AB0-B236-7DA0170EDAB1}"
    GetCurrentBackBufferIndex()
      => ComCall(36, this.p, UInt32)
    CheckColorSpaceSupport(ColorSpace, pColorSpaceSupport)
      => ComCall(37, this.p, DXGI_COLOR_SPACE_TYPE, ColorSpace, UInt32.Ptr, pColorSpaceSupport)
    SetColorSpace1(ColorSpace)
      => ComCall(38, this.p, DXGI_COLOR_SPACE_TYPE, ColorSpace)
    ResizeBuffers1(Width, Height, Format, SwapChainFlags, pCreationNodeMask, ppPresentQueue)
      => ComCall(39, this.p, UInt32, ppPresentQueue.Length, UInt32, Width, UInt32, Height, DXGI_FORMAT, Format, UInt32, SwapChainFlags, UInt32.Ptr, pCreationNodeMask, IUnknown.Ptr, ppPresentQueue)
}
struct DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG extends Int32 {
    static DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG_PRESENT := 1
}
struct IDXGIOutput4 extends IDXGIOutput3 {
    static IID := "{DC7DCA35-2196-414D-9F53-617884032A60}"
    CheckOverlayColorSpaceSupport(Format, ColorSpace, pConcernedDevice, pFlags)
      => ComCall(25, this.p, DXGI_FORMAT, Format, DXGI_COLOR_SPACE_TYPE, ColorSpace, IUnknown, pConcernedDevice, UInt32.Ptr, pFlags)
}
struct IDXGIFactory4 extends IDXGIFactory3 {
    static IID := "{1BC6EA02-EF36-464F-BF0C-21CA39E5168A}"
    EnumAdapterByLuid(AdapterLuid, riid, ppvAdapter)
      => ComCall(26, this.p, LUID, AdapterLuid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvAdapter)
    EnumWarpAdapter(riid, ppvAdapter)
      => ComCall(27, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvAdapter)
}
struct DXGI_MEMORY_SEGMENT_GROUP extends Int32 {
    static DXGI_MEMORY_SEGMENT_GROUP_LOCAL := 0
    static DXGI_MEMORY_SEGMENT_GROUP_NON_LOCAL := 1
}
struct DXGI_QUERY_VIDEO_MEMORY_INFO {
    Budget : Int64
    CurrentUsage : Int64
    AvailableForReservation : Int64
    CurrentReservation : Int64
}
struct IDXGIAdapter3 extends IDXGIAdapter2 {
    static IID := "{645967A4-1392-4310-A798-8053CE3E93FD}"
    RegisterHardwareContentProtectionTeardownStatusEvent(hEvent, pdwCookie)
      => ComCall(12, this.p, HANDLE, hEvent, UInt32.Ptr, pdwCookie)
    UnregisterHardwareContentProtectionTeardownStatus(dwCookie)
      => ComCall(13, this.p, UInt32, dwCookie, "void")
    QueryVideoMemoryInfo(NodeIndex, MemorySegmentGroup, pVideoMemoryInfo)
      => ComCall(14, this.p, UInt32, NodeIndex, DXGI_MEMORY_SEGMENT_GROUP, MemorySegmentGroup, DXGI_QUERY_VIDEO_MEMORY_INFO.Ptr, pVideoMemoryInfo)
    SetVideoMemoryReservation(NodeIndex, MemorySegmentGroup, Reservation)
      => ComCall(15, this.p, UInt32, NodeIndex, DXGI_MEMORY_SEGMENT_GROUP, MemorySegmentGroup, Int64, Reservation)
    RegisterVideoMemoryBudgetChangeNotificationEvent(hEvent, pdwCookie)
      => ComCall(16, this.p, HANDLE, hEvent, UInt32.Ptr, pdwCookie)
    UnregisterVideoMemoryBudgetChangeNotification(dwCookie)
      => ComCall(17, this.p, UInt32, dwCookie, "void")
}
struct DXGI_OUTDUPL_FLAG extends Int32 {
    static DXGI_OUTDUPL_COMPOSITED_UI_CAPTURE_ONLY := 1
}
struct IDXGIOutput5 extends IDXGIOutput4 {
    static IID := "{80A07424-AB52-42EB-833C-0C42FD282D98}"
    DuplicateOutput1(pDevice, Flags, pSupportedFormats, ppOutputDuplication)
      => ComCall(26, this.p, IUnknown, pDevice, UInt32, Flags, UInt32, pSupportedFormats.Length, DXGI_FORMAT.Ptr, pSupportedFormats, IDXGIOutputDuplication.Ptr, ppOutputDuplication)
}
struct DXGI_HDR_METADATA_TYPE extends Int32 {
    static DXGI_HDR_METADATA_TYPE_NONE := 0
    static DXGI_HDR_METADATA_TYPE_HDR10 := 1
    static DXGI_HDR_METADATA_TYPE_HDR10PLUS := 2
}
struct DXGI_HDR_METADATA_HDR10 {
    RedPrimary : UInt16[2]
    GreenPrimary : UInt16[2]
    BluePrimary : UInt16[2]
    WhitePoint : UInt16[2]
    MaxMasteringLuminance : UInt32
    MinMasteringLuminance : UInt32
    MaxContentLightLevel : UInt16
    MaxFrameAverageLightLevel : UInt16
}
struct DXGI_HDR_METADATA_HDR10PLUS {
    Data : UInt8[72]
}
struct IDXGISwapChain4 extends IDXGISwapChain3 {
    static IID := "{3D585D5A-BD4A-489E-B1F4-3DBCB6452FFB}"
    SetHDRMetaData(Type, pMetaData?)
      => ComCall(40, this.p, DXGI_HDR_METADATA_TYPE, Type, UInt32, pMetaData?.Length ?? 0, Struct.Ptr, pMetaData?)
}
struct DXGI_OFFER_RESOURCE_FLAGS extends Int32 {
    static DXGI_OFFER_RESOURCE_FLAG_ALLOW_DECOMMIT := 1
}
struct DXGI_RECLAIM_RESOURCE_RESULTS extends Int32 {
    static DXGI_RECLAIM_RESOURCE_RESULT_OK := 0
    static DXGI_RECLAIM_RESOURCE_RESULT_DISCARDED := 1
    static DXGI_RECLAIM_RESOURCE_RESULT_NOT_COMMITTED := 2
}
struct IDXGIDevice4 extends IDXGIDevice3 {
    static IID := "{95B4F95F-D8DA-4CA4-9EE6-3B76D5968A10}"
    OfferResources1(ppResources, Priority, Flags)
      => ComCall(18, this.p, UInt32, ppResources.Length, IDXGIResource.Ptr, ppResources, DXGI_OFFER_RESOURCE_PRIORITY, Priority, UInt32, Flags)
    ReclaimResources1(ppResources, pResults)
      => ComCall(19, this.p, UInt32, pResults.Length, IDXGIResource.Ptr, ppResources, DXGI_RECLAIM_RESOURCE_RESULTS.Ptr, pResults)
}
struct DXGI_FEATURE extends Int32 {
    static DXGI_FEATURE_PRESENT_ALLOW_TEARING := 0
}
struct IDXGIFactory5 extends IDXGIFactory4 {
    static IID := "{7632E1F5-EE65-4DCA-87FD-84CD75F8838D}"
    CheckFeatureSupport(Feature, pFeatureSupportData)
      => ComCall(28, this.p, DXGI_FEATURE, Feature, Struct.Ptr, pFeatureSupportData, UInt32, pFeatureSupportData.Size)
}
struct DXGI_ADAPTER_FLAG3 extends Int32 {
    static DXGI_ADAPTER_FLAG3_NONE := 0
    static DXGI_ADAPTER_FLAG3_REMOTE := 1
    static DXGI_ADAPTER_FLAG3_SOFTWARE := 2
    static DXGI_ADAPTER_FLAG3_ACG_COMPATIBLE := 4
    static DXGI_ADAPTER_FLAG3_SUPPORT_MONITORED_FENCES := 8
    static DXGI_ADAPTER_FLAG3_SUPPORT_NON_MONITORED_FENCES := 16
    static DXGI_ADAPTER_FLAG3_KEYED_MUTEX_CONFORMANCE := 32
}
struct DXGI_ADAPTER_DESC3 {
    Description : UInt16[128]
    VendorId : UInt32
    DeviceId : UInt32
    SubSysId : UInt32
    Revision : UInt32
    DedicatedVideoMemory : IntPtr
    DedicatedSystemMemory : IntPtr
    SharedSystemMemory : IntPtr
    AdapterLuid : LUID
    Flags : DXGI_ADAPTER_FLAG3
    GraphicsPreemptionGranularity : DXGI_GRAPHICS_PREEMPTION_GRANULARITY
    ComputePreemptionGranularity : DXGI_COMPUTE_PREEMPTION_GRANULARITY
}
struct IDXGIAdapter4 extends IDXGIAdapter3 {
    static IID := "{3C8D99D1-4FBF-4181-A82C-AF66BF7BD24E}"
    GetDesc3(pDesc)
      => ComCall(18, this.p, DXGI_ADAPTER_DESC3.Ptr, pDesc)
}
struct DXGI_OUTPUT_DESC1 {
    DeviceName : UInt16[32]
    DesktopCoordinates : RECT
    AttachedToDesktop : BOOL
    Rotation : DXGI_MODE_ROTATION
    Monitor : HMONITOR
    BitsPerColor : UInt32
    ColorSpace : DXGI_COLOR_SPACE_TYPE
    RedPrimary : Float32[2]
    GreenPrimary : Float32[2]
    BluePrimary : Float32[2]
    WhitePoint : Float32[2]
    MinLuminance : Float32
    MaxLuminance : Float32
    MaxFullFrameLuminance : Float32
}
struct DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS extends Int32 {
    static DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_FULLSCREEN := 1
    static DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_WINDOWED := 2
    static DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_CURSOR_STRETCHED := 4
}
struct IDXGIOutput6 extends IDXGIOutput5 {
    static IID := "{068346E8-AAEC-4B84-ADD7-137F513F77A1}"
    GetDesc1(pDesc)
      => ComCall(27, this.p, DXGI_OUTPUT_DESC1.Ptr, pDesc)
    CheckHardwareCompositionSupport(pFlags)
      => ComCall(28, this.p, UInt32.Ptr, pFlags)
}
struct DXGI_GPU_PREFERENCE extends Int32 {
    static DXGI_GPU_PREFERENCE_UNSPECIFIED := 0
    static DXGI_GPU_PREFERENCE_MINIMUM_POWER := 1
    static DXGI_GPU_PREFERENCE_HIGH_PERFORMANCE := 2
}
struct IDXGIFactory6 extends IDXGIFactory5 {
    static IID := "{C1B6694F-FF09-44A9-B03C-77900A0A1D17}"
    EnumAdapterByGpuPreference(Adapter, GpuPreference, riid, ppvAdapter)
      => ComCall(29, this.p, UInt32, Adapter, DXGI_GPU_PREFERENCE, GpuPreference, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvAdapter)
}
struct IDXGIFactory7 extends IDXGIFactory6 {
    static IID := "{A4966EED-76DB-44DA-84C1-EE9A7AFB20A8}"
    RegisterAdaptersChangedEvent(hEvent, pdwCookie)
      => ComCall(30, this.p, HANDLE, hEvent, UInt32.Ptr, pdwCookie)
    UnregisterAdaptersChangedEvent(dwCookie)
      => ComCall(31, this.p, UInt32, dwCookie)
}
struct DXGI_SINGLE_ADAPTER_HYBRID_MODE extends Int32 {
    static DXGI_SINGLE_ADAPTER_HYBRID_MODE_UNSPECIFIED := 0
    static DXGI_SINGLE_ADAPTER_HYBRID_MODE_MINIMUM_POWER := 1
    static DXGI_SINGLE_ADAPTER_HYBRID_MODE_HIGH_PERFORMANCE := 2
}
struct DXGI_ADAPTER_FLAG4 extends Int32 {
    static DXGI_ADAPTER_FLAG4_NONE := 0
    static DXGI_ADAPTER_FLAG4_REMOTE := 1
    static DXGI_ADAPTER_FLAG4_SOFTWARE := 2
    static DXGI_ADAPTER_FLAG4_ACG_COMPATIBLE := 4
    static DXGI_ADAPTER_FLAG4_SUPPORT_MONITORED_FENCES := 8
    static DXGI_ADAPTER_FLAG4_SUPPORT_NON_MONITORED_FENCES := 16
    static DXGI_ADAPTER_FLAG4_KEYED_MUTEX_CONFORMANCE := 32
    static DXGI_ADAPTER_FLAG4_SUPPORT_SINGLE_ADAPTER_HYBRID_MODE := 64
}
struct DXGI_ADAPTER_DESC4 {
    Description : UInt16[128]
    VendorId : UInt32
    DeviceId : UInt32
    SubSysId : UInt32
    Revision : UInt32
    DedicatedVideoMemory : IntPtr
    DedicatedSystemMemory : IntPtr
    SharedSystemMemory : IntPtr
    AdapterLuid : LUID
    Flags : DXGI_ADAPTER_FLAG4
    GraphicsPreemptionGranularity : DXGI_GRAPHICS_PREEMPTION_GRANULARITY
    ComputePreemptionGranularity : DXGI_COMPUTE_PREEMPTION_GRANULARITY
}
struct IDXGIAdapter5 extends IDXGIAdapter4 {
    static IID := "{9464643C-C95B-4674-8A7D-EE0548E8C022}"
    GetDesc4(pDesc)
      => ComCall(19, this.p, DXGI_ADAPTER_DESC4.Ptr, pDesc)
    GetSingleAdapterHybridMode(pSingleAdapterHybridMode)
      => ComCall(20, this.p, DXGI_SINGLE_ADAPTER_HYBRID_MODE.Ptr, pSingleAdapterHybridMode)
    SetSingleAdapterHybridMode(SingleAdapterHybridMode)
      => ComCall(21, this.p, DXGI_SINGLE_ADAPTER_HYBRID_MODE, SingleAdapterHybridMode)
}
struct DXGI_SWAP_CHAIN_DESC2 {
    Width : UInt32
    Height : UInt32
    Format : DXGI_FORMAT
    Stereo : BOOL
    SampleDesc : DXGI_SAMPLE_DESC
    BufferUsage : DXGI_USAGE
    BufferCount : UInt32
    Scaling : DXGI_SCALING
    SwapEffect : DXGI_SWAP_EFFECT
    AlphaMode : DXGI_ALPHA_MODE
    Flags : UInt32
    ColorSpace : DXGI_COLOR_SPACE_TYPE
}
struct IDXGISwapChain5 extends IDXGISwapChain4 {
    static IID := "{9086BF22-9338-43BB-87CE-7790B6438A7F}"
    GetDesc2(pDesc)
      => ComCall(41, this.p, DXGI_SWAP_CHAIN_DESC2.Ptr, pDesc)
    GetColorSpace1()
      => ComCall(42, this.p, DXGI_COLOR_SPACE_TYPE)
    ResizeBuffers2(Width, Height, Format, SwapChainFlags, pCreationNodeMask?, ppPresentQueue?, ColorSpace)
      => ComCall(43, this.p, UInt32, ppPresentQueue?.Length ?? 0, UInt32, Width, UInt32, Height, DXGI_FORMAT, Format, UInt32, SwapChainFlags, UInt32.Ptr, pCreationNodeMask?, IUnknown.Ptr, ppPresentQueue?, DXGI_COLOR_SPACE_TYPE, ColorSpace)
}
struct IDXGIFactory8 extends IDXGIFactory7 {
    static IID := "{693C45C1-39A7-4C1F-BDD3-D9A3229B8321}"
    CreateSwapChainForHwnd1(pDevice, hWnd1, pDesc, pFullscreenDesc?, pRestrictToOutput?, ppSwapChain)
      => ComCall(32, this.p, IUnknown, pDevice, HWND, hWnd1, DXGI_SWAP_CHAIN_DESC2.Ptr, pDesc, DXGI_SWAP_CHAIN_FULLSCREEN_DESC.Ptr, pFullscreenDesc?, IDXGIOutput, pRestrictToOutput?, IDXGISwapChain5.Ptr, ppSwapChain)
    CreateSwapChainForCoreWindow1(pDevice, pWindow, pDesc, pRestrictToOutput?, ppSwapChain)
      => ComCall(33, this.p, IUnknown, pDevice, IUnknown, pWindow, DXGI_SWAP_CHAIN_DESC2.Ptr, pDesc, IDXGIOutput, pRestrictToOutput?, IDXGISwapChain5.Ptr, ppSwapChain)
    CreateSwapChainForComposition1(pDevice, pDesc, pRestrictToOutput?, ppSwapChain)
      => ComCall(34, this.p, IUnknown, pDevice, DXGI_SWAP_CHAIN_DESC2.Ptr, pDesc, IDXGIOutput, pRestrictToOutput?, IDXGISwapChain5.Ptr, ppSwapChain)
}
struct IDXGIFactoryMedia2 extends IDXGIFactoryMedia {
    static IID := "{98EC0B90-2B18-42A6-9FCF-43B46F654022}"
    CreateSwapChainForCompositionSurfaceHandle1(pDevice, hSurface?, pDesc, pRestrictToOutput?, ppSwapChain)
      => ComCall(5, this.p, IUnknown, pDevice, HANDLE, hSurface?, DXGI_SWAP_CHAIN_DESC2.Ptr, pDesc, IDXGIOutput, pRestrictToOutput?, IDXGISwapChain5.Ptr, ppSwapChain)
}
struct DXGI_DEBUG_RLO_FLAGS extends Int32 {
    static DXGI_DEBUG_RLO_SUMMARY := 1
    static DXGI_DEBUG_RLO_DETAIL := 2
    static DXGI_DEBUG_RLO_IGNORE_INTERNAL := 4
    static DXGI_DEBUG_RLO_ALL := 7
}
struct DXGI_INFO_QUEUE_MESSAGE_CATEGORY extends Int32 {
    static DXGI_INFO_QUEUE_MESSAGE_CATEGORY_UNKNOWN := 0
    static DXGI_INFO_QUEUE_MESSAGE_CATEGORY_MISCELLANEOUS := 1
    static DXGI_INFO_QUEUE_MESSAGE_CATEGORY_INITIALIZATION := 2
    static DXGI_INFO_QUEUE_MESSAGE_CATEGORY_CLEANUP := 3
    static DXGI_INFO_QUEUE_MESSAGE_CATEGORY_COMPILATION := 4
    static DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_CREATION := 5
    static DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_SETTING := 6
    static DXGI_INFO_QUEUE_MESSAGE_CATEGORY_STATE_GETTING := 7
    static DXGI_INFO_QUEUE_MESSAGE_CATEGORY_RESOURCE_MANIPULATION := 8
    static DXGI_INFO_QUEUE_MESSAGE_CATEGORY_EXECUTION := 9
    static DXGI_INFO_QUEUE_MESSAGE_CATEGORY_SHADER := 10
}
struct DXGI_INFO_QUEUE_MESSAGE_SEVERITY extends Int32 {
    static DXGI_INFO_QUEUE_MESSAGE_SEVERITY_CORRUPTION := 0
    static DXGI_INFO_QUEUE_MESSAGE_SEVERITY_ERROR := 1
    static DXGI_INFO_QUEUE_MESSAGE_SEVERITY_WARNING := 2
    static DXGI_INFO_QUEUE_MESSAGE_SEVERITY_INFO := 3
    static DXGI_INFO_QUEUE_MESSAGE_SEVERITY_MESSAGE := 4
}
struct DXGI_INFO_QUEUE_MESSAGE {
    Producer : GUID
    Category : DXGI_INFO_QUEUE_MESSAGE_CATEGORY
    Severity : DXGI_INFO_QUEUE_MESSAGE_SEVERITY
    ID : Int32
    pDescription : UInt8.Ptr
    DescriptionByteLength : IntPtr
}
struct DXGI_INFO_QUEUE_FILTER_DESC {
    NumCategories : UInt32
    pCategoryList : DXGI_INFO_QUEUE_MESSAGE_CATEGORY.Ptr
    NumSeverities : UInt32
    pSeverityList : DXGI_INFO_QUEUE_MESSAGE_SEVERITY.Ptr
    NumIDs : UInt32
    pIDList : Int32.Ptr
}
struct DXGI_INFO_QUEUE_FILTER {
    AllowList : DXGI_INFO_QUEUE_FILTER_DESC
    DenyList : DXGI_INFO_QUEUE_FILTER_DESC
}
struct IDXGIInfoQueue extends IUnknown {
    static IID := "{D67441C7-672A-476F-9E82-CD55B44949CE}"
    SetMessageCountLimit(Producer, MessageCountLimit)
      => ComCall(3, this.p, GUID, Producer, Int64, MessageCountLimit)
    ClearStoredMessages(Producer)
      => ComCall(4, this.p, GUID, Producer, "void")
    GetMessage(Producer, MessageIndex, pMessage?, pMessageByteLength)
      => ComCall(5, this.p, GUID, Producer, Int64, MessageIndex, DXGI_INFO_QUEUE_MESSAGE.Ptr, pMessage?, IntPtr.Ptr, pMessageByteLength)
    GetNumStoredMessagesAllowedByRetrievalFilters(Producer)
      => ComCall(6, this.p, GUID, Producer, Int64)
    GetNumStoredMessages(Producer)
      => ComCall(7, this.p, GUID, Producer, Int64)
    GetNumMessagesDiscardedByMessageCountLimit(Producer)
      => ComCall(8, this.p, GUID, Producer, Int64)
    GetMessageCountLimit(Producer)
      => ComCall(9, this.p, GUID, Producer, Int64)
    GetNumMessagesAllowedByStorageFilter(Producer)
      => ComCall(10, this.p, GUID, Producer, Int64)
    GetNumMessagesDeniedByStorageFilter(Producer)
      => ComCall(11, this.p, GUID, Producer, Int64)
    AddStorageFilterEntries(Producer, pFilter)
      => ComCall(12, this.p, GUID, Producer, DXGI_INFO_QUEUE_FILTER.Ptr, pFilter)
    GetStorageFilter(Producer, pFilter?, pFilterByteLength)
      => ComCall(13, this.p, GUID, Producer, DXGI_INFO_QUEUE_FILTER.Ptr, pFilter?, IntPtr.Ptr, pFilterByteLength)
    ClearStorageFilter(Producer)
      => ComCall(14, this.p, GUID, Producer, "void")
    PushEmptyStorageFilter(Producer)
      => ComCall(15, this.p, GUID, Producer)
    PushDenyAllStorageFilter(Producer)
      => ComCall(16, this.p, GUID, Producer)
    PushCopyOfStorageFilter(Producer)
      => ComCall(17, this.p, GUID, Producer)
    PushStorageFilter(Producer, pFilter)
      => ComCall(18, this.p, GUID, Producer, DXGI_INFO_QUEUE_FILTER.Ptr, pFilter)
    PopStorageFilter(Producer)
      => ComCall(19, this.p, GUID, Producer, "void")
    GetStorageFilterStackSize(Producer)
      => ComCall(20, this.p, GUID, Producer, UInt32)
    AddRetrievalFilterEntries(Producer, pFilter)
      => ComCall(21, this.p, GUID, Producer, DXGI_INFO_QUEUE_FILTER.Ptr, pFilter)
    GetRetrievalFilter(Producer, pFilter?, pFilterByteLength)
      => ComCall(22, this.p, GUID, Producer, DXGI_INFO_QUEUE_FILTER.Ptr, pFilter?, IntPtr.Ptr, pFilterByteLength)
    ClearRetrievalFilter(Producer)
      => ComCall(23, this.p, GUID, Producer, "void")
    PushEmptyRetrievalFilter(Producer)
      => ComCall(24, this.p, GUID, Producer)
    PushDenyAllRetrievalFilter(Producer)
      => ComCall(25, this.p, GUID, Producer)
    PushCopyOfRetrievalFilter(Producer)
      => ComCall(26, this.p, GUID, Producer)
    PushRetrievalFilter(Producer, pFilter)
      => ComCall(27, this.p, GUID, Producer, DXGI_INFO_QUEUE_FILTER.Ptr, pFilter)
    PopRetrievalFilter(Producer)
      => ComCall(28, this.p, GUID, Producer, "void")
    GetRetrievalFilterStackSize(Producer)
      => ComCall(29, this.p, GUID, Producer, UInt32)
    AddMessage(Producer, Category, Severity, ID, pDescription)
      => ComCall(30, this.p, GUID, Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY, Category, DXGI_INFO_QUEUE_MESSAGE_SEVERITY, Severity, Int32, ID, PSTR, pDescription)
    AddApplicationMessage(Severity, pDescription)
      => ComCall(31, this.p, DXGI_INFO_QUEUE_MESSAGE_SEVERITY, Severity, PSTR, pDescription)
    SetBreakOnCategory(Producer, Category, bEnable)
      => ComCall(32, this.p, GUID, Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY, Category, BOOL, bEnable)
    SetBreakOnSeverity(Producer, Severity, bEnable)
      => ComCall(33, this.p, GUID, Producer, DXGI_INFO_QUEUE_MESSAGE_SEVERITY, Severity, BOOL, bEnable)
    SetBreakOnID(Producer, ID, bEnable)
      => ComCall(34, this.p, GUID, Producer, Int32, ID, BOOL, bEnable)
    GetBreakOnCategory(Producer, Category)
      => ComCall(35, this.p, GUID, Producer, DXGI_INFO_QUEUE_MESSAGE_CATEGORY, Category, BOOL)
    GetBreakOnSeverity(Producer, Severity)
      => ComCall(36, this.p, GUID, Producer, DXGI_INFO_QUEUE_MESSAGE_SEVERITY, Severity, BOOL)
    GetBreakOnID(Producer, ID)
      => ComCall(37, this.p, GUID, Producer, Int32, ID, BOOL)
    SetMuteDebugOutput(Producer, bMute)
      => ComCall(38, this.p, GUID, Producer, BOOL, bMute, "void")
    GetMuteDebugOutput(Producer)
      => ComCall(39, this.p, GUID, Producer, BOOL)
}
struct IDXGIDebug extends IUnknown {
    static IID := "{119E7452-DE9E-40FE-8806-88F90C12B441}"
    ReportLiveObjects(apiid, flags)
      => ComCall(3, this.p, GUID, apiid, DXGI_DEBUG_RLO_FLAGS, flags)
}
struct IDXGIDebug1 extends IDXGIDebug {
    static IID := "{C5A05F0C-16F2-4ADF-9F4D-A8C4D58AC550}"
    EnableLeakTrackingForThread()
      => ComCall(4, this.p, "void")
    DisableLeakTrackingForThread()
      => ComCall(5, this.p, "void")
    IsLeakTrackingEnabledForThread()
      => ComCall(6, this.p, BOOL)
}
struct DXGI_Message_Id extends Int32 {
    static DXGI_MSG_IDXGISwapChain_CreationOrResizeBuffers_InvalidOutputWindow := 0
    static DXGI_MSG_IDXGISwapChain_CreationOrResizeBuffers_BufferWidthInferred := 1
    static DXGI_MSG_IDXGISwapChain_CreationOrResizeBuffers_BufferHeightInferred := 2
    static DXGI_MSG_IDXGISwapChain_CreationOrResizeBuffers_NoScanoutFlagChanged := 3
    static DXGI_MSG_IDXGISwapChain_Creation_MaxBufferCountExceeded := 4
    static DXGI_MSG_IDXGISwapChain_Creation_TooFewBuffers := 5
    static DXGI_MSG_IDXGISwapChain_Creation_NoOutputWindow := 6
    static DXGI_MSG_IDXGISwapChain_Destruction_OtherMethodsCalled := 7
    static DXGI_MSG_IDXGISwapChain_GetDesc_pDescIsNULL := 8
    static DXGI_MSG_IDXGISwapChain_GetBuffer_ppSurfaceIsNULL := 9
    static DXGI_MSG_IDXGISwapChain_GetBuffer_NoAllocatedBuffers := 10
    static DXGI_MSG_IDXGISwapChain_GetBuffer_iBufferMustBeZero := 11
    static DXGI_MSG_IDXGISwapChain_GetBuffer_iBufferOOB := 12
    static DXGI_MSG_IDXGISwapChain_GetContainingOutput_ppOutputIsNULL := 13
    static DXGI_MSG_IDXGISwapChain_Present_SyncIntervalOOB := 14
    static DXGI_MSG_IDXGISwapChain_Present_InvalidNonPreRotatedFlag := 15
    static DXGI_MSG_IDXGISwapChain_Present_NoAllocatedBuffers := 16
    static DXGI_MSG_IDXGISwapChain_Present_GetDXGIAdapterFailed := 17
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_BufferCountOOB := 18
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_UnreleasedReferences := 19
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_InvalidSwapChainFlag := 20
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_InvalidNonPreRotatedFlag := 21
    static DXGI_MSG_IDXGISwapChain_ResizeTarget_RefreshRateDivideByZero := 22
    static DXGI_MSG_IDXGISwapChain_SetFullscreenState_InvalidTarget := 23
    static DXGI_MSG_IDXGISwapChain_GetFrameStatistics_pStatsIsNULL := 24
    static DXGI_MSG_IDXGISwapChain_GetLastPresentCount_pLastPresentCountIsNULL := 25
    static DXGI_MSG_IDXGISwapChain_SetFullscreenState_RemoteNotSupported := 26
    static DXGI_MSG_IDXGIOutput_TakeOwnership_FailedToAcquireFullscreenMutex := 27
    static DXGI_MSG_IDXGIFactory_CreateSoftwareAdapter_ppAdapterInterfaceIsNULL := 28
    static DXGI_MSG_IDXGIFactory_EnumAdapters_ppAdapterInterfaceIsNULL := 29
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_ppSwapChainIsNULL := 30
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_pDescIsNULL := 31
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_UnknownSwapEffect := 32
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_InvalidFlags := 33
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_NonPreRotatedFlagAndWindowed := 34
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_NullDeviceInterface := 35
    static DXGI_MSG_IDXGIFactory_GetWindowAssociation_phWndIsNULL := 36
    static DXGI_MSG_IDXGIFactory_MakeWindowAssociation_InvalidFlags := 37
    static DXGI_MSG_IDXGISurface_Map_InvalidSurface := 38
    static DXGI_MSG_IDXGISurface_Map_FlagsSetToZero := 39
    static DXGI_MSG_IDXGISurface_Map_DiscardAndReadFlagSet := 40
    static DXGI_MSG_IDXGISurface_Map_DiscardButNotWriteFlagSet := 41
    static DXGI_MSG_IDXGISurface_Map_NoCPUAccess := 42
    static DXGI_MSG_IDXGISurface_Map_ReadFlagSetButCPUAccessIsDynamic := 43
    static DXGI_MSG_IDXGISurface_Map_DiscardFlagSetButCPUAccessIsNotDynamic := 44
    static DXGI_MSG_IDXGIOutput_GetDisplayModeList_pNumModesIsNULL := 45
    static DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_ModeHasInvalidWidthOrHeight := 46
    static DXGI_MSG_IDXGIOutput_GetCammaControlCapabilities_NoOwnerDevice := 47
    static DXGI_MSG_IDXGIOutput_TakeOwnership_pDeviceIsNULL := 48
    static DXGI_MSG_IDXGIOutput_GetDisplaySurfaceData_NoOwnerDevice := 49
    static DXGI_MSG_IDXGIOutput_GetDisplaySurfaceData_pDestinationIsNULL := 50
    static DXGI_MSG_IDXGIOutput_GetDisplaySurfaceData_MapOfDestinationFailed := 51
    static DXGI_MSG_IDXGIOutput_GetFrameStatistics_NoOwnerDevice := 52
    static DXGI_MSG_IDXGIOutput_GetFrameStatistics_pStatsIsNULL := 53
    static DXGI_MSG_IDXGIOutput_SetGammaControl_NoOwnerDevice := 54
    static DXGI_MSG_IDXGIOutput_GetGammaControl_NoOwnerDevice := 55
    static DXGI_MSG_IDXGIOutput_GetGammaControl_NoGammaControls := 56
    static DXGI_MSG_IDXGIOutput_SetDisplaySurface_IDXGIResourceNotSupportedBypPrimary := 57
    static DXGI_MSG_IDXGIOutput_SetDisplaySurface_pPrimaryIsInvalid := 58
    static DXGI_MSG_IDXGIOutput_SetDisplaySurface_NoOwnerDevice := 59
    static DXGI_MSG_IDXGIOutput_TakeOwnership_RemoteDeviceNotSupported := 60
    static DXGI_MSG_IDXGIOutput_GetDisplayModeList_RemoteDeviceNotSupported := 61
    static DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_RemoteDeviceNotSupported := 62
    static DXGI_MSG_IDXGIDevice_CreateSurface_InvalidParametersWithpSharedResource := 63
    static DXGI_MSG_IDXGIObject_GetPrivateData_puiDataSizeIsNULL := 64
    static DXGI_MSG_IDXGISwapChain_Creation_InvalidOutputWindow := 65
    static DXGI_MSG_IDXGISwapChain_Release_SwapChainIsFullscreen := 66
    static DXGI_MSG_IDXGIOutput_GetDisplaySurfaceData_InvalidTargetSurfaceFormat := 67
    static DXGI_MSG_IDXGIFactory_CreateSoftwareAdapter_ModuleIsNULL := 68
    static DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_IDXGIDeviceNotSupportedBypConcernedDevice := 69
    static DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_pModeToMatchOrpClosestMatchIsNULL := 70
    static DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_ModeHasRefreshRateDenominatorZero := 71
    static DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_UnknownFormatIsInvalidForConfiguration := 72
    static DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_InvalidDisplayModeScanlineOrdering := 73
    static DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_InvalidDisplayModeScaling := 74
    static DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_InvalidDisplayModeFormatAndDeviceCombination := 75
    static DXGI_MSG_IDXGIFactory_Creation_CalledFromDllMain := 76
    static DXGI_MSG_IDXGISwapChain_SetFullscreenState_OutputNotOwnedBySwapChainDevice := 77
    static DXGI_MSG_IDXGISwapChain_Creation_InvalidWindowStyle := 78
    static DXGI_MSG_IDXGISwapChain_GetFrameStatistics_UnsupportedStatistics := 79
    static DXGI_MSG_IDXGISwapChain_GetContainingOutput_SwapchainAdapterDoesNotControlOutput := 80
    static DXGI_MSG_IDXGIOutput_SetOrGetGammaControl_pArrayIsNULL := 81
    static DXGI_MSG_IDXGISwapChain_SetFullscreenState_FullscreenInvalidForChildWindows := 82
    static DXGI_MSG_IDXGIFactory_Release_CalledFromDllMain := 83
    static DXGI_MSG_IDXGISwapChain_Present_UnreleasedHDC := 84
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_NonPreRotatedAndGDICompatibleFlags := 85
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_NonPreRotatedAndGDICompatibleFlags := 86
    static DXGI_MSG_IDXGISurface1_GetDC_pHdcIsNULL := 87
    static DXGI_MSG_IDXGISurface1_GetDC_SurfaceNotTexture2D := 88
    static DXGI_MSG_IDXGISurface1_GetDC_GDICompatibleFlagNotSet := 89
    static DXGI_MSG_IDXGISurface1_GetDC_UnreleasedHDC := 90
    static DXGI_MSG_IDXGISurface_Map_NoCPUAccess2 := 91
    static DXGI_MSG_IDXGISurface1_ReleaseDC_GetDCNotCalled := 92
    static DXGI_MSG_IDXGISurface1_ReleaseDC_InvalidRectangleDimensions := 93
    static DXGI_MSG_IDXGIOutput_TakeOwnership_RemoteOutputNotSupported := 94
    static DXGI_MSG_IDXGIOutput_FindClosestMatchingMode_RemoteOutputNotSupported := 95
    static DXGI_MSG_IDXGIOutput_GetDisplayModeList_RemoteOutputNotSupported := 96
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_pDeviceHasMismatchedDXGIFactory := 97
    static DXGI_MSG_IDXGISwapChain_Present_NonOptimalFSConfiguration := 98
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_FlipSequentialNotSupportedOnD3D10 := 99
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_BufferCountOOBForFlipSequential := 100
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_InvalidFormatForFlipSequential := 101
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_MultiSamplingNotSupportedForFlipSequential := 102
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_BufferCountOOBForFlipSequential := 103
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_InvalidFormatForFlipSequential := 104
    static DXGI_MSG_IDXGISwapChain_Present_PartialPresentationBeforeStandardPresentation := 105
    static DXGI_MSG_IDXGISwapChain_Present_FullscreenPartialPresentIsInvalid := 106
    static DXGI_MSG_IDXGISwapChain_Present_InvalidPresentTestOrDoNotSequenceFlag := 107
    static DXGI_MSG_IDXGISwapChain_Present_ScrollInfoWithNoDirtyRectsSpecified := 108
    static DXGI_MSG_IDXGISwapChain_Present_EmptyScrollRect := 109
    static DXGI_MSG_IDXGISwapChain_Present_ScrollRectOutOfBackbufferBounds := 110
    static DXGI_MSG_IDXGISwapChain_Present_ScrollRectOutOfBackbufferBoundsWithOffset := 111
    static DXGI_MSG_IDXGISwapChain_Present_EmptyDirtyRect := 112
    static DXGI_MSG_IDXGISwapChain_Present_DirtyRectOutOfBackbufferBounds := 113
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_UnsupportedBufferUsageFlags := 114
    static DXGI_MSG_IDXGISwapChain_Present_DoNotSequenceFlagSetButPreviousBufferIsUndefined := 115
    static DXGI_MSG_IDXGISwapChain_Present_UnsupportedFlags := 116
    static DXGI_MSG_IDXGISwapChain_Present_FlipModelChainMustResizeOrCreateOnFSTransition := 117
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_pRestrictToOutputFromOtherIDXGIFactory := 118
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_RestrictOutputNotSupportedOnAdapter := 119
    static DXGI_MSG_IDXGISwapChain_Present_RestrictToOutputFlagSetButInvalidpRestrictToOutput := 120
    static DXGI_MSG_IDXGISwapChain_Present_RestrictToOutputFlagdWithFullscreen := 121
    static DXGI_MSG_IDXGISwapChain_Present_RestrictOutputFlagWithStaleSwapChain := 122
    static DXGI_MSG_IDXGISwapChain_Present_OtherFlagsCausingInvalidPresentTestFlag := 123
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_UnavailableInSession0 := 124
    static DXGI_MSG_IDXGIFactory_MakeWindowAssociation_UnavailableInSession0 := 125
    static DXGI_MSG_IDXGIFactory_GetWindowAssociation_UnavailableInSession0 := 126
    static DXGI_MSG_IDXGIAdapter_EnumOutputs_UnavailableInSession0 := 127
    static DXGI_MSG_IDXGISwapChain_CreationOrSetFullscreenState_StereoDisabled := 128
    static DXGI_MSG_IDXGIFactory2_UnregisterStatus_CookieNotFound := 129
    static DXGI_MSG_IDXGISwapChain_Present_ProtectedContentInWindowedModeWithoutFSOrOverlay := 130
    static DXGI_MSG_IDXGISwapChain_Present_ProtectedContentInWindowedModeWithoutFlipSequential := 131
    static DXGI_MSG_IDXGISwapChain_Present_ProtectedContentWithRDPDriver := 132
    static DXGI_MSG_IDXGISwapChain_Present_ProtectedContentInWindowedModeWithDWMOffOrInvalidDisplayAffinity := 133
    static DXGI_MSG_IDXGIFactory_CreateSwapChainForComposition_WidthOrHeightIsZero := 134
    static DXGI_MSG_IDXGIFactory_CreateSwapChainForComposition_OnlyFlipSequentialSupported := 135
    static DXGI_MSG_IDXGIFactory_CreateSwapChainForComposition_UnsupportedOnAdapter := 136
    static DXGI_MSG_IDXGIFactory_CreateSwapChainForComposition_UnsupportedOnWindows7 := 137
    static DXGI_MSG_IDXGISwapChain_SetFullscreenState_FSTransitionWithCompositionSwapChain := 138
    static DXGI_MSG_IDXGISwapChain_ResizeTarget_InvalidWithCompositionSwapChain := 139
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_WidthOrHeightIsZero := 140
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_ScalingNoneIsFlipModelOnly := 141
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_ScalingUnrecognized := 142
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_DisplayOnlyFullscreenUnsupported := 143
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_DisplayOnlyUnsupported := 144
    static DXGI_MSG_IDXGISwapChain_Present_RestartIsFullscreenOnly := 145
    static DXGI_MSG_IDXGISwapChain_Present_ProtectedWindowlessPresentationRequiresDisplayOnly := 146
    static DXGI_MSG_IDXGISwapChain_SetFullscreenState_DisplayOnlyUnsupported := 147
    static DXGI_MSG_IDXGISwapChain1_SetBackgroundColor_OutOfRange := 148
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_DisplayOnlyFullscreenUnsupported := 149
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_DisplayOnlyUnsupported := 150
    static DXGI_MSG_IDXGISwapchain_Present_ScrollUnsupported := 151
    static DXGI_MSG_IDXGISwapChain1_SetRotation_UnsupportedOS := 152
    static DXGI_MSG_IDXGISwapChain1_GetRotation_UnsupportedOS := 153
    static DXGI_MSG_IDXGISwapchain_Present_FullscreenRotation := 154
    static DXGI_MSG_IDXGISwapChain_Present_PartialPresentationWithMSAABuffers := 155
    static DXGI_MSG_IDXGISwapChain1_SetRotation_FlipSequentialRequired := 156
    static DXGI_MSG_IDXGISwapChain1_SetRotation_InvalidRotation := 157
    static DXGI_MSG_IDXGISwapChain1_GetRotation_FlipSequentialRequired := 158
    static DXGI_MSG_IDXGISwapChain_GetHwnd_WrongType := 159
    static DXGI_MSG_IDXGISwapChain_GetCompositionSurface_WrongType := 160
    static DXGI_MSG_IDXGISwapChain_GetCoreWindow_WrongType := 161
    static DXGI_MSG_IDXGISwapChain_GetFullscreenDesc_NonHwnd := 162
    static DXGI_MSG_IDXGISwapChain_SetFullscreenState_CoreWindow := 163
    static DXGI_MSG_IDXGIFactory2_CreateSwapChainForCoreWindow_UnsupportedOnWindows7 := 164
    static DXGI_MSG_IDXGIFactory2_CreateSwapChainForCoreWindow_pWindowIsNULL := 165
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_FSUnsupportedForModernApps := 166
    static DXGI_MSG_IDXGIFactory_MakeWindowAssociation_ModernApp := 167
    static DXGI_MSG_IDXGISwapChain_ResizeTarget_ModernApp := 168
    static DXGI_MSG_IDXGISwapChain_ResizeTarget_pNewTargetParametersIsNULL := 169
    static DXGI_MSG_IDXGIOutput_SetDisplaySurface_ModernApp := 170
    static DXGI_MSG_IDXGIOutput_TakeOwnership_ModernApp := 171
    static DXGI_MSG_IDXGIFactory2_CreateSwapChainForCoreWindow_pWindowIsInvalid := 172
    static DXGI_MSG_IDXGIFactory2_CreateSwapChainForCompositionSurface_InvalidHandle := 173
    static DXGI_MSG_IDXGISurface1_GetDC_ModernApp := 174
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_ScalingNoneRequiresWindows8OrNewer := 175
    static DXGI_MSG_IDXGISwapChain_Present_TemporaryMonoAndPreferRight := 176
    static DXGI_MSG_IDXGISwapChain_Present_TemporaryMonoOrPreferRightWithDoNotSequence := 177
    static DXGI_MSG_IDXGISwapChain_Present_TemporaryMonoOrPreferRightWithoutStereo := 178
    static DXGI_MSG_IDXGISwapChain_Present_TemporaryMonoUnsupported := 179
    static DXGI_MSG_IDXGIOutput_GetDisplaySurfaceData_ArraySizeMismatch := 180
    static DXGI_MSG_IDXGISwapChain_Present_PartialPresentationWithSwapEffectDiscard := 181
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_AlphaUnrecognized := 182
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_AlphaIsWindowlessOnly := 183
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_AlphaIsFlipModelOnly := 184
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_RestrictToOutputAdapterMismatch := 185
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_DisplayOnlyOnLegacy := 186
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_DisplayOnlyOnLegacy := 187
    static DXGI_MSG_IDXGIResource1_CreateSubresourceSurface_InvalidIndex := 188
    static DXGI_MSG_IDXGIFactory_CreateSwapChainForComposition_InvalidScaling := 189
    static DXGI_MSG_IDXGIFactory_CreateSwapChainForCoreWindow_InvalidSwapEffect := 190
    static DXGI_MSG_IDXGIResource1_CreateSharedHandle_UnsupportedOS := 191
    static DXGI_MSG_IDXGIFactory2_RegisterOcclusionStatusWindow_UnsupportedOS := 192
    static DXGI_MSG_IDXGIFactory2_RegisterOcclusionStatusEvent_UnsupportedOS := 193
    static DXGI_MSG_IDXGIOutput1_DuplicateOutput_UnsupportedOS := 194
    static DXGI_MSG_IDXGIDisplayControl_IsStereoEnabled_UnsupportedOS := 195
    static DXGI_MSG_IDXGIFactory_CreateSwapChainForComposition_InvalidAlphaMode := 196
    static DXGI_MSG_IDXGIFactory_GetSharedResourceAdapterLuid_InvalidResource := 197
    static DXGI_MSG_IDXGIFactory_GetSharedResourceAdapterLuid_InvalidLUID := 198
    static DXGI_MSG_IDXGIFactory_GetSharedResourceAdapterLuid_UnsupportedOS := 199
    static DXGI_MSG_IDXGIOutput1_GetDisplaySurfaceData1_2DOnly := 200
    static DXGI_MSG_IDXGIOutput1_GetDisplaySurfaceData1_StagingOnly := 201
    static DXGI_MSG_IDXGIOutput1_GetDisplaySurfaceData1_NeedCPUAccessWrite := 202
    static DXGI_MSG_IDXGIOutput1_GetDisplaySurfaceData1_NoShared := 203
    static DXGI_MSG_IDXGIOutput1_GetDisplaySurfaceData1_OnlyMipLevels1 := 204
    static DXGI_MSG_IDXGIOutput1_GetDisplaySurfaceData1_MappedOrOfferedResource := 205
    static DXGI_MSG_IDXGISwapChain_SetFullscreenState_FSUnsupportedForModernApps := 206
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_FailedToGoFSButNonPreRotated := 207
    static DXGI_MSG_IDXGIFactory_CreateSwapChainOrRegisterOcclusionStatus_BlitModelUsedWhileRegisteredForOcclusionStatusEvents := 208
    static DXGI_MSG_IDXGISwapChain_Present_BlitModelUsedWhileRegisteredForOcclusionStatusEvents := 209
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_WaitableSwapChainsAreFlipModelOnly := 210
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_WaitableSwapChainsAreNotFullscreen := 211
    static DXGI_MSG_IDXGISwapChain_SetFullscreenState_Waitable := 212
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_CannotAddOrRemoveWaitableFlag := 213
    static DXGI_MSG_IDXGISwapChain_GetFrameLatencyWaitableObject_OnlyWaitable := 214
    static DXGI_MSG_IDXGISwapChain_GetMaximumFrameLatency_OnlyWaitable := 215
    static DXGI_MSG_IDXGISwapChain_GetMaximumFrameLatency_pMaxLatencyIsNULL := 216
    static DXGI_MSG_IDXGISwapChain_SetMaximumFrameLatency_OnlyWaitable := 217
    static DXGI_MSG_IDXGISwapChain_SetMaximumFrameLatency_MaxLatencyIsOutOfBounds := 218
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_ForegroundIsCoreWindowOnly := 219
    static DXGI_MSG_IDXGIFactory2_CreateSwapChainForCoreWindow_ForegroundUnsupportedOnAdapter := 220
    static DXGI_MSG_IDXGIFactory2_CreateSwapChainForCoreWindow_InvalidScaling := 221
    static DXGI_MSG_IDXGIFactory2_CreateSwapChainForCoreWindow_InvalidAlphaMode := 222
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_CannotAddOrRemoveForegroundFlag := 223
    static DXGI_MSG_IDXGISwapChain_SetMatrixTransform_MatrixPointerCannotBeNull := 224
    static DXGI_MSG_IDXGISwapChain_SetMatrixTransform_RequiresCompositionSwapChain := 225
    static DXGI_MSG_IDXGISwapChain_SetMatrixTransform_MatrixMustBeFinite := 226
    static DXGI_MSG_IDXGISwapChain_SetMatrixTransform_MatrixMustBeTranslateAndOrScale := 227
    static DXGI_MSG_IDXGISwapChain_GetMatrixTransform_MatrixPointerCannotBeNull := 228
    static DXGI_MSG_IDXGISwapChain_GetMatrixTransform_RequiresCompositionSwapChain := 229
    static DXGI_MSG_DXGIGetDebugInterface1_NULL_ppDebug := 230
    static DXGI_MSG_DXGIGetDebugInterface1_InvalidFlags := 231
    static DXGI_MSG_IDXGISwapChain_Present_Decode := 232
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_Decode := 233
    static DXGI_MSG_IDXGISwapChain_SetSourceSize_FlipModel := 234
    static DXGI_MSG_IDXGISwapChain_SetSourceSize_Decode := 235
    static DXGI_MSG_IDXGISwapChain_SetSourceSize_WidthHeight := 236
    static DXGI_MSG_IDXGISwapChain_GetSourceSize_NullPointers := 237
    static DXGI_MSG_IDXGISwapChain_GetSourceSize_Decode := 238
    static DXGI_MSG_IDXGIDecodeSwapChain_SetColorSpace_InvalidFlags := 239
    static DXGI_MSG_IDXGIDecodeSwapChain_SetSourceRect_InvalidRect := 240
    static DXGI_MSG_IDXGIDecodeSwapChain_SetTargetRect_InvalidRect := 241
    static DXGI_MSG_IDXGIDecodeSwapChain_SetDestSize_InvalidSize := 242
    static DXGI_MSG_IDXGIDecodeSwapChain_GetSourceRect_InvalidPointer := 243
    static DXGI_MSG_IDXGIDecodeSwapChain_GetTargetRect_InvalidPointer := 244
    static DXGI_MSG_IDXGIDecodeSwapChain_GetDestSize_InvalidPointer := 245
    static DXGI_MSG_IDXGISwapChain_PresentBuffer_YUV := 246
    static DXGI_MSG_IDXGISwapChain_SetSourceSize_YUV := 247
    static DXGI_MSG_IDXGISwapChain_GetSourceSize_YUV := 248
    static DXGI_MSG_IDXGISwapChain_SetMatrixTransform_YUV := 249
    static DXGI_MSG_IDXGISwapChain_GetMatrixTransform_YUV := 250
    static DXGI_MSG_IDXGISwapChain_Present_PartialPresentation_YUV := 251
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_CannotAddOrRemoveFlag_YUV := 252
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_Alignment_YUV := 253
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_ShaderInputUnsupported_YUV := 254
    static DXGI_MSG_IDXGIOutput3_CheckOverlaySupport_NullPointers := 255
    static DXGI_MSG_IDXGIOutput3_CheckOverlaySupport_IDXGIDeviceNotSupportedBypConcernedDevice := 256
    static DXGI_MSG_IDXGIAdapter_EnumOutputs2_InvalidEnumOutputs2Flag := 257
    static DXGI_MSG_IDXGISwapChain_CreationOrSetFullscreenState_FSUnsupportedForFlipDiscard := 258
    static DXGI_MSG_IDXGIOutput4_CheckOverlayColorSpaceSupport_NullPointers := 259
    static DXGI_MSG_IDXGIOutput4_CheckOverlayColorSpaceSupport_IDXGIDeviceNotSupportedBypConcernedDevice := 260
    static DXGI_MSG_IDXGISwapChain3_CheckColorSpaceSupport_NullPointers := 261
    static DXGI_MSG_IDXGISwapChain3_SetColorSpace1_InvalidColorSpace := 262
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_InvalidHwProtect := 263
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_HwProtectUnsupported := 264
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_InvalidHwProtect := 265
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_HwProtectUnsupported := 266
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers1_D3D12Only := 267
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers1_FlipModel := 268
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers1_NodeMaskAndQueueRequired := 269
    static DXGI_MSG_IDXGISwapChain_CreateSwapChain_InvalidHwProtectGdiFlag := 270
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_InvalidHwProtectGdiFlag := 271
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_10BitFormatNotSupported := 272
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_FlipSwapEffectRequired := 273
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_InvalidDevice := 274
    static DXGI_MSG_IDXGIOutput_TakeOwnership_Unsupported := 275
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_InvalidQueue := 276
    static DXGI_MSG_IDXGISwapChain3_ResizeBuffers1_InvalidQueue := 277
    static DXGI_MSG_IDXGIFactory_CreateSwapChainForHwnd_InvalidScaling := 278
    static DXGI_MSG_IDXGISwapChain3_SetHDRMetaData_InvalidSize := 279
    static DXGI_MSG_IDXGISwapChain3_SetHDRMetaData_InvalidPointer := 280
    static DXGI_MSG_IDXGISwapChain3_SetHDRMetaData_InvalidType := 281
    static DXGI_MSG_IDXGISwapChain_Present_FullscreenAllowTearingIsInvalid := 282
    static DXGI_MSG_IDXGISwapChain_Present_AllowTearingRequiresPresentIntervalZero := 283
    static DXGI_MSG_IDXGISwapChain_Present_AllowTearingRequiresCreationFlag := 284
    static DXGI_MSG_IDXGISwapChain_ResizeBuffers_CannotAddOrRemoveAllowTearingFlag := 285
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_AllowTearingFlagIsFlipModelOnly := 286
    static DXGI_MSG_IDXGIFactory_CheckFeatureSupport_InvalidFeature := 287
    static DXGI_MSG_IDXGIFactory_CheckFeatureSupport_InvalidSize := 288
    static DXGI_MSG_IDXGIOutput6_CheckHardwareCompositionSupport_NullPointer := 289
    static DXGI_MSG_IDXGISwapChain_SetFullscreenState_PerMonitorDpiShimApplied := 290
    static DXGI_MSG_IDXGIOutput_DuplicateOutput_PerMonitorDpiShimApplied := 291
    static DXGI_MSG_IDXGIOutput_DuplicateOutput1_PerMonitorDpiRequired := 292
    static DXGI_MSG_IDXGIFactory7_UnregisterAdaptersChangedEvent_CookieNotFound := 293
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_LegacyBltModelSwapEffect := 294
    static DXGI_MSG_IDXGISwapChain4_SetHDRMetaData_MetadataUnchanged := 295
    static DXGI_MSG_IDXGISwapChain_Present_11On12_Released_Resource := 296
    static DXGI_MSG_IDXGIFactory_CreateSwapChain_MultipleSwapchainRefToSurface_DeferredDtr := 297
    static DXGI_MSG_IDXGIFactory_MakeWindowAssociation_NoOpBehavior := 298
    static DXGI_MSG_IDXGIFactory8_CreateSwapChain_InvalidColorSpaceFlag := 299
    static DXGI_MSG_IDXGIFactory8_CreateSwapChain_InvalidColorSpace := 300
    static DXGI_MSG_IDXGISwapChain5_ResizeBuffers2_InvalidColorSpace := 301
    static DXGI_MSG_IDXGISwapChain5_SetColorSpace1_Unsupported := 302
    static DXGI_MSG_IDXGIAdapter5_GetSingleAdapterHybridMode_Unsupported := 303
    static DXGI_MSG_IDXGIAdapter5_SetSingleAdapterHybridMode_Unsupported := 304
    static DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_NotForegroundWindow := 1000
    static DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_DISCARD_BufferCount := 1001
    static DXGI_MSG_Phone_IDXGISwapChain_SetFullscreenState_NotAvailable := 1002
    static DXGI_MSG_Phone_IDXGISwapChain_ResizeBuffers_NotAvailable := 1003
    static DXGI_MSG_Phone_IDXGISwapChain_ResizeTarget_NotAvailable := 1004
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidLayerIndex := 1005
    static DXGI_MSG_Phone_IDXGISwapChain_Present_MultipleLayerIndex := 1006
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidLayerFlag := 1007
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidRotation := 1008
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidBlend := 1009
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidResource := 1010
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidMultiPlaneOverlayResource := 1011
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidIndexForPrimary := 1012
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidIndexForOverlay := 1013
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidSubResourceIndex := 1014
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidSourceRect := 1015
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidDestinationRect := 1016
    static DXGI_MSG_Phone_IDXGISwapChain_Present_MultipleResource := 1017
    static DXGI_MSG_Phone_IDXGISwapChain_Present_NotSharedResource := 1018
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidFlag := 1019
    static DXGI_MSG_Phone_IDXGISwapChain_Present_InvalidInterval := 1020
    static DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_MSAA_NotSupported := 1021
    static DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_ScalingAspectRatioStretch_Supported_ModernApp := 1022
    static DXGI_MSG_Phone_IDXGISwapChain_GetFrameStatistics_NotAvailable_ModernApp := 1023
    static DXGI_MSG_Phone_IDXGISwapChain_Present_ReplaceInterval0With1 := 1024
    static DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_FailedRegisterWithCompositor := 1025
    static DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_NotForegroundWindow_AtRendering := 1026
    static DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_FLIP_SEQUENTIAL_BufferCount := 1027
    static DXGI_MSG_Phone_IDXGIFactory_CreateSwapChain_FLIP_Modern_CoreWindow_Only := 1028
    static DXGI_MSG_Phone_IDXGISwapChain_Present1_RequiresOverlays := 1029
    static DXGI_MSG_Phone_IDXGISwapChain_SetBackgroundColor_FlipSequentialRequired := 1030
    static DXGI_MSG_Phone_IDXGISwapChain_GetBackgroundColor_FlipSequentialRequired := 1031
}
struct IDXGraphicsAnalysis extends IUnknown {
    static IID := "{9F251514-9D4D-4902-9D60-18988AB7D4B5}"
    BeginCapture()
      => ComCall(3, this.p, "void")
    EndCapture()
      => ComCall(4, this.p, "void")
}
