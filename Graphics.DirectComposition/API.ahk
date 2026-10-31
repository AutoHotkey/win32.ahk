#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, HWND}
#Import "..\Graphics.Dxgi\Types.ahk" {IDXGIDevice}
#Import "..\Security\Types.ahk" {SECURITY_ATTRIBUTES}
#Import "..\System.Com\Types.ahk" {IUnknown}

DCompositionAttachMouseDragToHwnd(visual, hwnd1, enable)
  => DllCall("dcomp.dll\DCompositionAttachMouseDragToHwnd", IDCompositionVisual, visual, HWND, hwnd1, BOOL, enable, "HRESULT")
DCompositionAttachMouseWheelToHwnd(visual, hwnd1, enable)
  => DllCall("dcomp.dll\DCompositionAttachMouseWheelToHwnd", IDCompositionVisual, visual, HWND, hwnd1, BOOL, enable, "HRESULT")
DCompositionBoostCompositorClock(enable)
  => DllCall("dcomp.dll\DCompositionBoostCompositorClock", BOOL, enable, "HRESULT")
DCompositionCreateDevice(dxgiDevice?, iid, dcompositionDevice)
  => DllCall("dcomp.dll\DCompositionCreateDevice", IDXGIDevice, dxgiDevice?, GUID.Ptr, iid, Struct.Ptr.Ptr, dcompositionDevice, "HRESULT")
DCompositionCreateDevice2(renderingDevice?, iid, dcompositionDevice)
  => DllCall("dcomp.dll\DCompositionCreateDevice2", IUnknown, renderingDevice?, GUID.Ptr, iid, Struct.Ptr.Ptr, dcompositionDevice, "HRESULT")
DCompositionCreateDevice3(renderingDevice?, iid, dcompositionDevice)
  => DllCall("dcomp.dll\DCompositionCreateDevice3", IUnknown, renderingDevice?, GUID.Ptr, iid, Struct.Ptr.Ptr, dcompositionDevice, "HRESULT")
DCompositionCreateSurfaceHandle(desiredAccess, securityAttributes?, surfaceHandle)
  => DllCall("dcomp.dll\DCompositionCreateSurfaceHandle", UInt32, desiredAccess, SECURITY_ATTRIBUTES.Ptr, securityAttributes?, HANDLE.Ptr, surfaceHandle, "HRESULT")
DCompositionGetFrameId(frameIdType, frameId)
  => DllCall("dcomp.dll\DCompositionGetFrameId", COMPOSITION_FRAME_ID_TYPE, frameIdType, Int64.Ptr, frameId, "HRESULT")
DCompositionGetStatistics(frameId, frameStats, targetIdCount, targetIds?, actualTargetIdCount?)
  => DllCall("dcomp.dll\DCompositionGetStatistics", Int64, frameId, COMPOSITION_FRAME_STATS.Ptr, frameStats, UInt32, targetIdCount, COMPOSITION_TARGET_ID.Ptr, targetIds?, UInt32.Ptr, actualTargetIdCount?, "HRESULT")
DCompositionGetTargetStatistics(frameId, targetId, targetStats)
  => DllCall("dcomp.dll\DCompositionGetTargetStatistics", Int64, frameId, COMPOSITION_TARGET_ID.Ptr, targetId, COMPOSITION_TARGET_STATS.Ptr, targetStats, "HRESULT")
DCompositionWaitForCompositorClock(handles?, timeoutInMs)
  => DllCall("dcomp.dll\DCompositionWaitForCompositorClock", UInt32, handles?.Length ?? 0, HANDLE.Ptr, handles?, UInt32, timeoutInMs, UInt32)
