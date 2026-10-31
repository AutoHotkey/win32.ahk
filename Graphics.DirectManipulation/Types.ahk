#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, HWND, RECT}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {MSG}

struct DIRECTMANIPULATION_STATUS extends Int32 {
    static DIRECTMANIPULATION_BUILDING := 0
    static DIRECTMANIPULATION_ENABLED := 1
    static DIRECTMANIPULATION_DISABLED := 2
    static DIRECTMANIPULATION_RUNNING := 3
    static DIRECTMANIPULATION_INERTIA := 4
    static DIRECTMANIPULATION_READY := 5
    static DIRECTMANIPULATION_SUSPENDED := 6
}
struct DIRECTMANIPULATION_HITTEST_TYPE extends Int32 {
    static DIRECTMANIPULATION_HITTEST_TYPE_ASYNCHRONOUS := 0
    static DIRECTMANIPULATION_HITTEST_TYPE_SYNCHRONOUS := 1
    static DIRECTMANIPULATION_HITTEST_TYPE_AUTO_SYNCHRONOUS := 2
}
struct DIRECTMANIPULATION_CONFIGURATION extends Int32 {
    static DIRECTMANIPULATION_CONFIGURATION_NONE := 0
    static DIRECTMANIPULATION_CONFIGURATION_INTERACTION := 1
    static DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_X := 2
    static DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_Y := 4
    static DIRECTMANIPULATION_CONFIGURATION_SCALING := 16
    static DIRECTMANIPULATION_CONFIGURATION_TRANSLATION_INERTIA := 32
    static DIRECTMANIPULATION_CONFIGURATION_SCALING_INERTIA := 128
    static DIRECTMANIPULATION_CONFIGURATION_RAILS_X := 256
    static DIRECTMANIPULATION_CONFIGURATION_RAILS_Y := 512
}
struct DIRECTMANIPULATION_GESTURE_CONFIGURATION extends Int32 {
    static DIRECTMANIPULATION_GESTURE_NONE := 0
    static DIRECTMANIPULATION_GESTURE_DEFAULT := 0
    static DIRECTMANIPULATION_GESTURE_CROSS_SLIDE_VERTICAL := 8
    static DIRECTMANIPULATION_GESTURE_CROSS_SLIDE_HORIZONTAL := 16
    static DIRECTMANIPULATION_GESTURE_PINCH_ZOOM := 32
}
struct DIRECTMANIPULATION_MOTION_TYPES extends Int32 {
    static DIRECTMANIPULATION_MOTION_NONE := 0
    static DIRECTMANIPULATION_MOTION_TRANSLATEX := 1
    static DIRECTMANIPULATION_MOTION_TRANSLATEY := 2
    static DIRECTMANIPULATION_MOTION_ZOOM := 4
    static DIRECTMANIPULATION_MOTION_CENTERX := 16
    static DIRECTMANIPULATION_MOTION_CENTERY := 32
    static DIRECTMANIPULATION_MOTION_ALL := 55
}
struct DIRECTMANIPULATION_VIEWPORT_OPTIONS extends Int32 {
    static DIRECTMANIPULATION_VIEWPORT_OPTIONS_DEFAULT := 0
    static DIRECTMANIPULATION_VIEWPORT_OPTIONS_AUTODISABLE := 1
    static DIRECTMANIPULATION_VIEWPORT_OPTIONS_MANUALUPDATE := 2
    static DIRECTMANIPULATION_VIEWPORT_OPTIONS_INPUT := 4
    static DIRECTMANIPULATION_VIEWPORT_OPTIONS_EXPLICITHITTEST := 8
    static DIRECTMANIPULATION_VIEWPORT_OPTIONS_DISABLEPIXELSNAPPING := 16
}
struct DIRECTMANIPULATION_SNAPPOINT_TYPE extends Int32 {
    static DIRECTMANIPULATION_SNAPPOINT_MANDATORY := 0
    static DIRECTMANIPULATION_SNAPPOINT_OPTIONAL := 1
    static DIRECTMANIPULATION_SNAPPOINT_MANDATORY_SINGLE := 2
    static DIRECTMANIPULATION_SNAPPOINT_OPTIONAL_SINGLE := 3
}
struct DIRECTMANIPULATION_SNAPPOINT_COORDINATE extends Int32 {
    static DIRECTMANIPULATION_COORDINATE_BOUNDARY := 0
    static DIRECTMANIPULATION_COORDINATE_ORIGIN := 1
    static DIRECTMANIPULATION_COORDINATE_MIRRORED := 16
}
struct DIRECTMANIPULATION_HORIZONTALALIGNMENT extends Int32 {
    static DIRECTMANIPULATION_HORIZONTALALIGNMENT_NONE := 0
    static DIRECTMANIPULATION_HORIZONTALALIGNMENT_LEFT := 1
    static DIRECTMANIPULATION_HORIZONTALALIGNMENT_CENTER := 2
    static DIRECTMANIPULATION_HORIZONTALALIGNMENT_RIGHT := 4
    static DIRECTMANIPULATION_HORIZONTALALIGNMENT_UNLOCKCENTER := 8
}
struct DIRECTMANIPULATION_VERTICALALIGNMENT extends Int32 {
    static DIRECTMANIPULATION_VERTICALALIGNMENT_NONE := 0
    static DIRECTMANIPULATION_VERTICALALIGNMENT_TOP := 1
    static DIRECTMANIPULATION_VERTICALALIGNMENT_CENTER := 2
    static DIRECTMANIPULATION_VERTICALALIGNMENT_BOTTOM := 4
    static DIRECTMANIPULATION_VERTICALALIGNMENT_UNLOCKCENTER := 8
}
struct DIRECTMANIPULATION_INPUT_MODE extends Int32 {
    static DIRECTMANIPULATION_INPUT_MODE_AUTOMATIC := 0
    static DIRECTMANIPULATION_INPUT_MODE_MANUAL := 1
}
struct IDirectManipulationManager extends IUnknown {
    static IID := "{FBF5D3B4-70C7-4163-9322-5A6F660D6FBC}"
    Activate(window)
      => ComCall(3, this.p, HWND, window)
    Deactivate(window)
      => ComCall(4, this.p, HWND, window)
    RegisterHitTestTarget(window, hitTestWindow?, type)
      => ComCall(5, this.p, HWND, window, HWND, hitTestWindow?, DIRECTMANIPULATION_HITTEST_TYPE, type)
    ProcessInput(message, handled)
      => ComCall(6, this.p, MSG.Ptr, message, BOOL.Ptr, handled)
    GetUpdateManager(riid, object)
      => ComCall(7, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, object)
    CreateViewport(frameInfo?, window, riid, object)
      => ComCall(8, this.p, IDirectManipulationFrameInfoProvider, frameInfo?, HWND, window, GUID.Ptr, riid, Struct.Ptr.Ptr, object)
    CreateContent(frameInfo?, clsid, riid, object)
      => ComCall(9, this.p, IDirectManipulationFrameInfoProvider, frameInfo?, GUID.Ptr, clsid, GUID.Ptr, riid, Struct.Ptr.Ptr, object)
}
struct IDirectManipulationManager2 extends IDirectManipulationManager {
    static IID := "{FA1005E9-3D16-484C-BFC9-62B61E56EC4E}"
    CreateBehavior(clsid, riid, object)
      => ComCall(10, this.p, GUID.Ptr, clsid, GUID.Ptr, riid, Struct.Ptr.Ptr, object)
}
struct IDirectManipulationManager3 extends IDirectManipulationManager2 {
    static IID := "{2CB6B33D-FFE8-488C-B750-FBDFE88DCA8C}"
    GetService(clsid, riid, object)
      => ComCall(11, this.p, GUID.Ptr, clsid, GUID.Ptr, riid, Struct.Ptr.Ptr, object)
}
struct IDirectManipulationViewport extends IUnknown {
    static IID := "{28B85A3D-60A0-48BD-9BA1-5CE8D9EA3A6D}"
    Enable()
      => ComCall(3, this.p)
    Disable()
      => ComCall(4, this.p)
    SetContact(pointerId)
      => ComCall(5, this.p, UInt32, pointerId)
    ReleaseContact(pointerId)
      => ComCall(6, this.p, UInt32, pointerId)
    ReleaseAllContacts()
      => ComCall(7, this.p)
    GetStatus(status)
      => ComCall(8, this.p, DIRECTMANIPULATION_STATUS.Ptr, status)
    GetTag(riid, object?, id?)
      => ComCall(9, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, object?, UInt32.Ptr, id?)
    SetTag(object?, id)
      => ComCall(10, this.p, IUnknown, object?, UInt32, id)
    GetViewportRect(viewport)
      => ComCall(11, this.p, RECT.Ptr, viewport)
    SetViewportRect(viewport)
      => ComCall(12, this.p, RECT.Ptr, viewport)
    ZoomToRect(left, top, right, bottom, animate)
      => ComCall(13, this.p, Float32, left, Float32, top, Float32, right, Float32, bottom, BOOL, animate)
    SetViewportTransform(matrix)
      => ComCall(14, this.p, Float32.Ptr, matrix, UInt32, matrix.Length)
    SyncDisplayTransform(matrix)
      => ComCall(15, this.p, Float32.Ptr, matrix, UInt32, matrix.Length)
    GetPrimaryContent(riid, object)
      => ComCall(16, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, object)
    AddContent(content)
      => ComCall(17, this.p, IDirectManipulationContent, content)
    RemoveContent(content)
      => ComCall(18, this.p, IDirectManipulationContent, content)
    SetViewportOptions(options)
      => ComCall(19, this.p, DIRECTMANIPULATION_VIEWPORT_OPTIONS, options)
    AddConfiguration(configuration)
      => ComCall(20, this.p, DIRECTMANIPULATION_CONFIGURATION, configuration)
    RemoveConfiguration(configuration)
      => ComCall(21, this.p, DIRECTMANIPULATION_CONFIGURATION, configuration)
    ActivateConfiguration(configuration)
      => ComCall(22, this.p, DIRECTMANIPULATION_CONFIGURATION, configuration)
    SetManualGesture(configuration)
      => ComCall(23, this.p, DIRECTMANIPULATION_GESTURE_CONFIGURATION, configuration)
    SetChaining(enabledTypes)
      => ComCall(24, this.p, DIRECTMANIPULATION_MOTION_TYPES, enabledTypes)
    AddEventHandler(window?, eventHandler, cookie)
      => ComCall(25, this.p, HWND, window?, IDirectManipulationViewportEventHandler, eventHandler, UInt32.Ptr, cookie)
    RemoveEventHandler(cookie)
      => ComCall(26, this.p, UInt32, cookie)
    SetInputMode(mode)
      => ComCall(27, this.p, DIRECTMANIPULATION_INPUT_MODE, mode)
    SetUpdateMode(mode)
      => ComCall(28, this.p, DIRECTMANIPULATION_INPUT_MODE, mode)
    Stop()
      => ComCall(29, this.p)
    Abandon()
      => ComCall(30, this.p)
}
struct IDirectManipulationViewport2 extends IDirectManipulationViewport {
    static IID := "{923CCAAC-61E1-4385-B726-017AF189882A}"
    AddBehavior(behavior, cookie)
      => ComCall(31, this.p, IUnknown, behavior, UInt32.Ptr, cookie)
    RemoveBehavior(cookie)
      => ComCall(32, this.p, UInt32, cookie)
    RemoveAllBehaviors()
      => ComCall(33, this.p)
}
struct IDirectManipulationViewportEventHandler extends IUnknown {
    static IID := "{952121DA-D69F-45F9-B0F9-F23944321A6D}"
    OnViewportStatusChanged(viewport, current, previous)
      => ComCall(3, this.p, IDirectManipulationViewport, viewport, DIRECTMANIPULATION_STATUS, current, DIRECTMANIPULATION_STATUS, previous)
    OnViewportUpdated(viewport)
      => ComCall(4, this.p, IDirectManipulationViewport, viewport)
    OnContentUpdated(viewport, content)
      => ComCall(5, this.p, IDirectManipulationViewport, viewport, IDirectManipulationContent, content)
}
struct IDirectManipulationContent extends IUnknown {
    static IID := "{B89962CB-3D89-442B-BB58-5098FA0F9F16}"
    GetContentRect(contentSize)
      => ComCall(3, this.p, RECT.Ptr, contentSize)
    SetContentRect(contentSize)
      => ComCall(4, this.p, RECT.Ptr, contentSize)
    GetViewport(riid, object)
      => ComCall(5, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, object)
    GetTag(riid, object?, id?)
      => ComCall(6, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, object?, UInt32.Ptr, id?)
    SetTag(object?, id)
      => ComCall(7, this.p, IUnknown, object?, UInt32, id)
    GetOutputTransform(matrix)
      => ComCall(8, this.p, Float32.Ptr, matrix, UInt32, matrix.Length)
    GetContentTransform(matrix)
      => ComCall(9, this.p, Float32.Ptr, matrix, UInt32, matrix.Length)
    SyncContentTransform(matrix)
      => ComCall(10, this.p, Float32.Ptr, matrix, UInt32, matrix.Length)
}
struct IDirectManipulationPrimaryContent extends IUnknown {
    static IID := "{C12851E4-1698-4625-B9B1-7CA3EC18630B}"
    SetSnapInterval(motion, interval, offset)
      => ComCall(3, this.p, DIRECTMANIPULATION_MOTION_TYPES, motion, Float32, interval, Float32, offset)
    SetSnapPoints(motion, points?)
      => ComCall(4, this.p, DIRECTMANIPULATION_MOTION_TYPES, motion, Float32.Ptr, points?, UInt32, points?.Length ?? 0)
    SetSnapType(motion, type)
      => ComCall(5, this.p, DIRECTMANIPULATION_MOTION_TYPES, motion, DIRECTMANIPULATION_SNAPPOINT_TYPE, type)
    SetSnapCoordinate(motion, coordinate, origin)
      => ComCall(6, this.p, DIRECTMANIPULATION_MOTION_TYPES, motion, DIRECTMANIPULATION_SNAPPOINT_COORDINATE, coordinate, Float32, origin)
    SetZoomBoundaries(zoomMinimum, zoomMaximum)
      => ComCall(7, this.p, Float32, zoomMinimum, Float32, zoomMaximum)
    SetHorizontalAlignment(alignment)
      => ComCall(8, this.p, DIRECTMANIPULATION_HORIZONTALALIGNMENT, alignment)
    SetVerticalAlignment(alignment)
      => ComCall(9, this.p, DIRECTMANIPULATION_VERTICALALIGNMENT, alignment)
    GetInertiaEndTransform(matrix)
      => ComCall(10, this.p, Float32.Ptr, matrix, UInt32, matrix.Length)
    GetCenterPoint(centerX, centerY)
      => ComCall(11, this.p, Float32.Ptr, centerX, Float32.Ptr, centerY)
}
struct DIRECTMANIPULATION_DRAG_DROP_STATUS extends Int32 {
    static DIRECTMANIPULATION_DRAG_DROP_READY := 0
    static DIRECTMANIPULATION_DRAG_DROP_PRESELECT := 1
    static DIRECTMANIPULATION_DRAG_DROP_SELECTING := 2
    static DIRECTMANIPULATION_DRAG_DROP_DRAGGING := 3
    static DIRECTMANIPULATION_DRAG_DROP_CANCELLED := 4
    static DIRECTMANIPULATION_DRAG_DROP_COMMITTED := 5
}
struct IDirectManipulationDragDropEventHandler extends IUnknown {
    static IID := "{1FA11B10-701B-41AE-B5F2-49E36BD595AA}"
    OnDragDropStatusChange(viewport, current, previous)
      => ComCall(3, this.p, IDirectManipulationViewport2, viewport, DIRECTMANIPULATION_DRAG_DROP_STATUS, current, DIRECTMANIPULATION_DRAG_DROP_STATUS, previous)
}
struct DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION extends Int32 {
    static DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_VERTICAL := 1
    static DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HORIZONTAL := 2
    static DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_ONLY := 16
    static DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_SELECT_DRAG := 32
    static DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION_HOLD_DRAG := 64
}
struct IDirectManipulationDragDropBehavior extends IUnknown {
    static IID := "{814B5AF5-C2C8-4270-A9B7-A198CE8D02FA}"
    SetConfiguration(configuration)
      => ComCall(3, this.p, DIRECTMANIPULATION_DRAG_DROP_CONFIGURATION, configuration)
    GetStatus(status)
      => ComCall(4, this.p, DIRECTMANIPULATION_DRAG_DROP_STATUS.Ptr, status)
}
struct DIRECTMANIPULATION_INTERACTION_TYPE extends Int32 {
    static DIRECTMANIPULATION_INTERACTION_BEGIN := 0
    static DIRECTMANIPULATION_INTERACTION_TYPE_MANIPULATION := 1
    static DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_TAP := 2
    static DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_HOLD := 3
    static DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_CROSS_SLIDE := 4
    static DIRECTMANIPULATION_INTERACTION_TYPE_GESTURE_PINCH_ZOOM := 5
    static DIRECTMANIPULATION_INTERACTION_END := 100
}
struct IDirectManipulationInteractionEventHandler extends IUnknown {
    static IID := "{E43F45B8-42B4-403E-B1F2-273B8F510830}"
    OnInteraction(viewport, interaction)
      => ComCall(3, this.p, IDirectManipulationViewport2, viewport, DIRECTMANIPULATION_INTERACTION_TYPE, interaction)
}
struct IDirectManipulationFrameInfoProvider extends IUnknown {
    static IID := "{FB759DBA-6F4C-4C01-874E-19C8A05907F9}"
    GetNextFrameInfo(time, processTime, compositionTime)
      => ComCall(3, this.p, Int64.Ptr, time, Int64.Ptr, processTime, Int64.Ptr, compositionTime)
}
struct IDirectManipulationCompositor extends IUnknown {
    static IID := "{537A0825-0387-4EFA-B62F-71EB1F085A7E}"
    AddContent(content, device?, parentVisual?, childVisual?)
      => ComCall(3, this.p, IDirectManipulationContent, content, IUnknown, device?, IUnknown, parentVisual?, IUnknown, childVisual?)
    RemoveContent(content)
      => ComCall(4, this.p, IDirectManipulationContent, content)
    SetUpdateManager(updateManager)
      => ComCall(5, this.p, IDirectManipulationUpdateManager, updateManager)
    Flush()
      => ComCall(6, this.p)
}
struct IDirectManipulationCompositor2 extends IDirectManipulationCompositor {
    static IID := "{D38C7822-F1CB-43CB-B4B9-AC0C767A412E}"
    AddContentWithCrossProcessChaining(content, device?, parentVisual?, childVisual?)
      => ComCall(7, this.p, IDirectManipulationPrimaryContent, content, IUnknown, device?, IUnknown, parentVisual?, IUnknown, childVisual?)
}
struct IDirectManipulationUpdateHandler extends IUnknown {
    static IID := "{790B6337-64F8-4FF5-A269-B32BC2AF27A7}"
    Update()
      => ComCall(3, this.p)
}
struct IDirectManipulationUpdateManager extends IUnknown {
    static IID := "{B0AE62FD-BE34-46E7-9CAA-D361FACBB9CC}"
    RegisterWaitHandleCallback(handle1, eventHandler, cookie)
      => ComCall(3, this.p, HANDLE, handle1, IDirectManipulationUpdateHandler, eventHandler, UInt32.Ptr, cookie)
    UnregisterWaitHandleCallback(cookie)
      => ComCall(4, this.p, UInt32, cookie)
    Update(frameInfo?)
      => ComCall(5, this.p, IDirectManipulationFrameInfoProvider, frameInfo?)
}
struct DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION extends Int32 {
    static DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_STOP := 0
    static DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_FORWARD := 1
    static DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION_REVERSE := 2
}
struct IDirectManipulationAutoScrollBehavior extends IUnknown {
    static IID := "{6D5954D4-2003-4356-9B31-D051C9FF0AF7}"
    SetConfiguration(motionTypes, scrollMotion)
      => ComCall(3, this.p, DIRECTMANIPULATION_MOTION_TYPES, motionTypes, DIRECTMANIPULATION_AUTOSCROLL_CONFIGURATION, scrollMotion)
}
struct IDirectManipulationDeferContactService extends IUnknown {
    static IID := "{652D5C71-FE60-4A98-BE70-E5F21291E7F1}"
    DeferContact(pointerId, timeout)
      => ComCall(3, this.p, UInt32, pointerId, UInt32, timeout)
    CancelContact(pointerId)
      => ComCall(4, this.p, UInt32, pointerId)
    CancelDeferral(pointerId)
      => ComCall(5, this.p, UInt32, pointerId)
}
