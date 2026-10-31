#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HANDLE, HRESULT, LUID, RECT}
#Import "..\Graphics.Dxgi.Common\Types.ahk" {DXGI_ALPHA_MODE, DXGI_COLOR_SPACE_TYPE}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct SystemInterruptTime {
    value : Int64
}
struct PresentationTransform {
    M11 : Float32
    M12 : Float32
    M21 : Float32
    M22 : Float32
    M31 : Float32
    M32 : Float32
}
struct PresentStatisticsKind extends Int32 {
    static PresentStatisticsKind_PresentStatus := 1
    static PresentStatisticsKind_CompositionFrame := 2
    static PresentStatisticsKind_IndependentFlipFrame := 3
}
struct IPresentationBuffer extends IUnknown {
    static IID := "{2E217D3A-5ABB-4138-9A13-A775593C89CA}"
    GetAvailableEvent(availableEventHandle)
      => ComCall(3, this.p, HANDLE.Ptr, availableEventHandle)
    IsAvailable(isAvailable)
      => ComCall(4, this.p, UInt8.Ptr, isAvailable)
}
struct IPresentationContent extends IUnknown {
    static IID := "{5668BB79-3D8E-415C-B215-F38020F2D252}"
    SetTag(tag)
      => ComCall(3, this.p, IntPtr, tag, "void")
}
struct IPresentationSurface extends IPresentationContent {
    static IID := "{956710FB-EA40-4EBA-A3EB-4375A0EB4EDC}"
    SetBuffer(presentationBuffer)
      => ComCall(4, this.p, IPresentationBuffer, presentationBuffer)
    SetColorSpace(colorSpace)
      => ComCall(5, this.p, DXGI_COLOR_SPACE_TYPE, colorSpace)
    SetAlphaMode(alphaMode)
      => ComCall(6, this.p, DXGI_ALPHA_MODE, alphaMode)
    SetSourceRect(sourceRect)
      => ComCall(7, this.p, RECT.Ptr, sourceRect)
    SetTransform(transform)
      => ComCall(8, this.p, PresentationTransform.Ptr, transform)
    RestrictToOutput(output)
      => ComCall(9, this.p, IUnknown, output)
    SetDisableReadback(value)
      => ComCall(10, this.p, UInt8, value)
    SetLetterboxingMargins(leftLetterboxSize, topLetterboxSize, rightLetterboxSize, bottomLetterboxSize)
      => ComCall(11, this.p, Float32, leftLetterboxSize, Float32, topLetterboxSize, Float32, rightLetterboxSize, Float32, bottomLetterboxSize)
}
struct IPresentationSurface2 extends IPresentationSurface {
    static IID := "{95609569-C5F0-47F9-8804-5345F2E2767E}"
    SetIsHdrContent(isHdrContent)
      => ComCall(12, this.p, UInt8, isHdrContent, "void")
}
struct IPresentStatistics extends IUnknown {
    static IID := "{B44B8BDA-7282-495D-9DD7-CEADD8B4BB86}"
    GetPresentId()
      => ComCall(3, this.p, Int64)
    GetKind()
      => ComCall(4, this.p, PresentStatisticsKind)
}
struct IPresentationManager extends IUnknown {
    static IID := "{FB562F82-6292-470A-88B1-843661E7F20C}"
    AddBufferFromResource(resource, presentationBuffer)
      => ComCall(3, this.p, IUnknown, resource, IPresentationBuffer.Ptr, presentationBuffer)
    CreatePresentationSurface(compositionSurfaceHandle, presentationSurface)
      => ComCall(4, this.p, HANDLE, compositionSurfaceHandle, IPresentationSurface.Ptr, presentationSurface)
    GetNextPresentId()
      => ComCall(5, this.p, Int64)
    SetTargetTime(targetTime)
      => ComCall(6, this.p, SystemInterruptTime, targetTime)
    SetPreferredPresentDuration(preferredDuration, deviationTolerance)
      => ComCall(7, this.p, SystemInterruptTime, preferredDuration, SystemInterruptTime, deviationTolerance)
    ForceVSyncInterrupt(forceVsyncInterrupt)
      => ComCall(8, this.p, UInt8, forceVsyncInterrupt)
    Present()
      => ComCall(9, this.p)
    GetPresentRetiringFence(riid, fence)
      => ComCall(10, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, fence)
    CancelPresentsFrom(presentIdToCancelFrom)
      => ComCall(11, this.p, Int64, presentIdToCancelFrom)
    GetLostEvent(lostEventHandle)
      => ComCall(12, this.p, HANDLE.Ptr, lostEventHandle)
    GetPresentStatisticsAvailableEvent(presentStatisticsAvailableEventHandle)
      => ComCall(13, this.p, HANDLE.Ptr, presentStatisticsAvailableEventHandle)
    EnablePresentStatisticsKind(presentStatisticsKind1, enabled)
      => ComCall(14, this.p, PresentStatisticsKind, presentStatisticsKind1, UInt8, enabled)
    GetNextPresentStatistics(nextPresentStatistics)
      => ComCall(15, this.p, IPresentStatistics.Ptr, nextPresentStatistics)
}
struct IPresentationFactory extends IUnknown {
    static IID := "{8FB37B58-1D74-4F64-A49C-1F97A80A2EC0}"
    IsPresentationSupported()
      => ComCall(3, this.p, UInt8)
    IsPresentationSupportedWithIndependentFlip()
      => ComCall(4, this.p, UInt8)
    CreatePresentationManager(ppPresentationManager)
      => ComCall(5, this.p, IPresentationManager.Ptr, ppPresentationManager)
}
struct IPresentationFactory_SupportHdrAware extends IUnknown {
    static IID := "{2BD0B885-A16F-4BD9-A59A-D073E069D416}"
}
struct PresentStatus extends Int32 {
    static PresentStatus_Queued := 0
    static PresentStatus_Skipped := 1
    static PresentStatus_Canceled := 2
}
struct IPresentStatusPresentStatistics extends IPresentStatistics {
    static IID := "{C9ED2A41-79CB-435E-964E-C8553055420C}"
    GetCompositionFrameId()
      => ComCall(5, this.p, Int64)
    GetPresentStatus()
      => ComCall(6, this.p, PresentStatus)
}
struct CompositionFrameInstanceKind extends Int32 {
    static CompositionFrameInstanceKind_ComposedOnScreen := 0
    static CompositionFrameInstanceKind_ScanoutOnScreen := 1
    static CompositionFrameInstanceKind_ComposedToIntermediate := 2
}
struct CompositionFrameDisplayInstance {
    displayAdapterLUID : LUID
    displayVidPnSourceId : UInt32
    displayUniqueId : UInt32
    renderAdapterLUID : LUID
    instanceKind : CompositionFrameInstanceKind
    finalTransform : PresentationTransform
    requiredCrossAdapterCopy : UInt8
    colorSpace : DXGI_COLOR_SPACE_TYPE
}
struct ICompositionFramePresentStatistics extends IPresentStatistics {
    static IID := "{AB41D127-C101-4C0A-911D-F9F2E9D08E64}"
    GetContentTag()
      => ComCall(5, this.p, IntPtr)
    GetCompositionFrameId()
      => ComCall(6, this.p, Int64)
    GetDisplayInstanceArray(displayInstanceArrayCount, displayInstanceArray)
      => ComCall(7, this.p, UInt32.Ptr, displayInstanceArrayCount, CompositionFrameDisplayInstance.Ptr.Ptr, displayInstanceArray, "void")
}
struct IIndependentFlipFramePresentStatistics extends IPresentStatistics {
    static IID := "{8C93BE27-AD94-4DA0-8FD4-2413132D124E}"
    GetOutputAdapterLUID()
      => ComCall(5, this.p, LUID)
    GetOutputVidPnSourceId()
      => ComCall(6, this.p, UInt32)
    GetContentTag()
      => ComCall(7, this.p, IntPtr)
    GetDisplayedTime()
      => ComCall(8, this.p, SystemInterruptTime)
    GetPresentDuration()
      => ComCall(9, this.p, SystemInterruptTime)
}
