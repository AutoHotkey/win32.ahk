#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, HWND, POINTS}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct GESTURECONFIG_ID extends UInt32 {
    static GID_BEGIN := 1
    static GID_END := 2
    static GID_ZOOM := 3
    static GID_PAN := 4
    static GID_ROTATE := 5
    static GID_TWOFINGERTAP := 6
    static GID_PRESSANDTAP := 7
    static GID_ROLLOVER := 7
}
struct TOUCHEVENTF_FLAGS extends UInt32 {
    static TOUCHEVENTF_MOVE := 1
    static TOUCHEVENTF_DOWN := 2
    static TOUCHEVENTF_UP := 4
    static TOUCHEVENTF_INRANGE := 8
    static TOUCHEVENTF_PRIMARY := 16
    static TOUCHEVENTF_NOCOALESCE := 32
    static TOUCHEVENTF_PEN := 64
    static TOUCHEVENTF_PALM := 128
}
struct TOUCHINPUTMASKF_MASK extends UInt32 {
    static TOUCHINPUTMASKF_TIMEFROMSYSTEM := 1
    static TOUCHINPUTMASKF_EXTRAINFO := 2
    static TOUCHINPUTMASKF_CONTACTAREA := 4
}
struct REGISTER_TOUCH_WINDOW_FLAGS extends UInt32 {
    static TWF_FINETOUCH := 1
    static TWF_WANTPALM := 2
}
struct HGESTUREINFO {
    Value : IntPtr
}
struct HTOUCHINPUT {
    Value : IntPtr
}
struct MANIPULATION_PROCESSOR_MANIPULATIONS extends Int32 {
    static MANIPULATION_NONE := 0
    static MANIPULATION_TRANSLATE_X := 1
    static MANIPULATION_TRANSLATE_Y := 2
    static MANIPULATION_SCALE := 4
    static MANIPULATION_ROTATE := 8
    static MANIPULATION_ALL := 15
}
struct IManipulationEvents extends IUnknown {
    static IID := "{4F62C8DA-9C53-4B22-93DF-927A862BBB03}"
    ManipulationStarted(x, y)
      => ComCall(3, this.p, Float32, x, Float32, y)
    ManipulationDelta(x, y, translationDeltaX, translationDeltaY, scaleDelta, expansionDelta, rotationDelta, cumulativeTranslationX, cumulativeTranslationY, cumulativeScale, cumulativeExpansion, cumulativeRotation)
      => ComCall(4, this.p, Float32, x, Float32, y, Float32, translationDeltaX, Float32, translationDeltaY, Float32, scaleDelta, Float32, expansionDelta, Float32, rotationDelta, Float32, cumulativeTranslationX, Float32, cumulativeTranslationY, Float32, cumulativeScale, Float32, cumulativeExpansion, Float32, cumulativeRotation)
    ManipulationCompleted(x, y, cumulativeTranslationX, cumulativeTranslationY, cumulativeScale, cumulativeExpansion, cumulativeRotation)
      => ComCall(5, this.p, Float32, x, Float32, y, Float32, cumulativeTranslationX, Float32, cumulativeTranslationY, Float32, cumulativeScale, Float32, cumulativeExpansion, Float32, cumulativeRotation)
}
struct IInertiaProcessor extends IUnknown {
    static IID := "{18B00C6D-C5EE-41B1-90A9-9D4A929095AD}"
    get_InitialOriginX(x)
      => ComCall(3, this.p, Float32.Ptr, x)
    put_InitialOriginX(x)
      => ComCall(4, this.p, Float32, x)
    get_InitialOriginY(y)
      => ComCall(5, this.p, Float32.Ptr, y)
    put_InitialOriginY(y)
      => ComCall(6, this.p, Float32, y)
    get_InitialVelocityX(x)
      => ComCall(7, this.p, Float32.Ptr, x)
    put_InitialVelocityX(x)
      => ComCall(8, this.p, Float32, x)
    get_InitialVelocityY(y)
      => ComCall(9, this.p, Float32.Ptr, y)
    put_InitialVelocityY(y)
      => ComCall(10, this.p, Float32, y)
    get_InitialAngularVelocity(velocity)
      => ComCall(11, this.p, Float32.Ptr, velocity)
    put_InitialAngularVelocity(velocity)
      => ComCall(12, this.p, Float32, velocity)
    get_InitialExpansionVelocity(velocity)
      => ComCall(13, this.p, Float32.Ptr, velocity)
    put_InitialExpansionVelocity(velocity)
      => ComCall(14, this.p, Float32, velocity)
    get_InitialRadius(radius)
      => ComCall(15, this.p, Float32.Ptr, radius)
    put_InitialRadius(radius)
      => ComCall(16, this.p, Float32, radius)
    get_BoundaryLeft(left)
      => ComCall(17, this.p, Float32.Ptr, left)
    put_BoundaryLeft(left)
      => ComCall(18, this.p, Float32, left)
    get_BoundaryTop(top)
      => ComCall(19, this.p, Float32.Ptr, top)
    put_BoundaryTop(top)
      => ComCall(20, this.p, Float32, top)
    get_BoundaryRight(right)
      => ComCall(21, this.p, Float32.Ptr, right)
    put_BoundaryRight(right)
      => ComCall(22, this.p, Float32, right)
    get_BoundaryBottom(bottom)
      => ComCall(23, this.p, Float32.Ptr, bottom)
    put_BoundaryBottom(bottom)
      => ComCall(24, this.p, Float32, bottom)
    get_ElasticMarginLeft(left)
      => ComCall(25, this.p, Float32.Ptr, left)
    put_ElasticMarginLeft(left)
      => ComCall(26, this.p, Float32, left)
    get_ElasticMarginTop(top)
      => ComCall(27, this.p, Float32.Ptr, top)
    put_ElasticMarginTop(top)
      => ComCall(28, this.p, Float32, top)
    get_ElasticMarginRight(right)
      => ComCall(29, this.p, Float32.Ptr, right)
    put_ElasticMarginRight(right)
      => ComCall(30, this.p, Float32, right)
    get_ElasticMarginBottom(bottom)
      => ComCall(31, this.p, Float32.Ptr, bottom)
    put_ElasticMarginBottom(bottom)
      => ComCall(32, this.p, Float32, bottom)
    get_DesiredDisplacement(displacement)
      => ComCall(33, this.p, Float32.Ptr, displacement)
    put_DesiredDisplacement(displacement)
      => ComCall(34, this.p, Float32, displacement)
    get_DesiredRotation(rotation)
      => ComCall(35, this.p, Float32.Ptr, rotation)
    put_DesiredRotation(rotation)
      => ComCall(36, this.p, Float32, rotation)
    get_DesiredExpansion(expansion)
      => ComCall(37, this.p, Float32.Ptr, expansion)
    put_DesiredExpansion(expansion)
      => ComCall(38, this.p, Float32, expansion)
    get_DesiredDeceleration(deceleration)
      => ComCall(39, this.p, Float32.Ptr, deceleration)
    put_DesiredDeceleration(deceleration)
      => ComCall(40, this.p, Float32, deceleration)
    get_DesiredAngularDeceleration(deceleration)
      => ComCall(41, this.p, Float32.Ptr, deceleration)
    put_DesiredAngularDeceleration(deceleration)
      => ComCall(42, this.p, Float32, deceleration)
    get_DesiredExpansionDeceleration(deceleration)
      => ComCall(43, this.p, Float32.Ptr, deceleration)
    put_DesiredExpansionDeceleration(deceleration)
      => ComCall(44, this.p, Float32, deceleration)
    get_InitialTimestamp(timestamp)
      => ComCall(45, this.p, UInt32.Ptr, timestamp)
    put_InitialTimestamp(timestamp)
      => ComCall(46, this.p, UInt32, timestamp)
    Reset()
      => ComCall(47, this.p)
    Process(completed)
      => ComCall(48, this.p, BOOL.Ptr, completed)
    ProcessTime(timestamp, completed)
      => ComCall(49, this.p, UInt32, timestamp, BOOL.Ptr, completed)
    Complete()
      => ComCall(50, this.p)
    CompleteTime(timestamp)
      => ComCall(51, this.p, UInt32, timestamp)
}
struct IManipulationProcessor extends IUnknown {
    static IID := "{A22AC519-8300-48A0-BEF4-F1BE8737DBA4}"
    get_SupportedManipulations(manipulations)
      => ComCall(3, this.p, MANIPULATION_PROCESSOR_MANIPULATIONS.Ptr, manipulations)
    put_SupportedManipulations(manipulations)
      => ComCall(4, this.p, MANIPULATION_PROCESSOR_MANIPULATIONS, manipulations)
    get_PivotPointX(pivotPointX)
      => ComCall(5, this.p, Float32.Ptr, pivotPointX)
    put_PivotPointX(pivotPointX)
      => ComCall(6, this.p, Float32, pivotPointX)
    get_PivotPointY(pivotPointY)
      => ComCall(7, this.p, Float32.Ptr, pivotPointY)
    put_PivotPointY(pivotPointY)
      => ComCall(8, this.p, Float32, pivotPointY)
    get_PivotRadius(pivotRadius)
      => ComCall(9, this.p, Float32.Ptr, pivotRadius)
    put_PivotRadius(pivotRadius)
      => ComCall(10, this.p, Float32, pivotRadius)
    CompleteManipulation()
      => ComCall(11, this.p)
    ProcessDown(manipulatorId, x, y)
      => ComCall(12, this.p, UInt32, manipulatorId, Float32, x, Float32, y)
    ProcessMove(manipulatorId, x, y)
      => ComCall(13, this.p, UInt32, manipulatorId, Float32, x, Float32, y)
    ProcessUp(manipulatorId, x, y)
      => ComCall(14, this.p, UInt32, manipulatorId, Float32, x, Float32, y)
    ProcessDownWithTime(manipulatorId, x, y, timestamp)
      => ComCall(15, this.p, UInt32, manipulatorId, Float32, x, Float32, y, UInt32, timestamp)
    ProcessMoveWithTime(manipulatorId, x, y, timestamp)
      => ComCall(16, this.p, UInt32, manipulatorId, Float32, x, Float32, y, UInt32, timestamp)
    ProcessUpWithTime(manipulatorId, x, y, timestamp)
      => ComCall(17, this.p, UInt32, manipulatorId, Float32, x, Float32, y, UInt32, timestamp)
    GetVelocityX(velocityX)
      => ComCall(18, this.p, Float32.Ptr, velocityX)
    GetVelocityY(velocityY)
      => ComCall(19, this.p, Float32.Ptr, velocityY)
    GetExpansionVelocity(expansionVelocity)
      => ComCall(20, this.p, Float32.Ptr, expansionVelocity)
    GetAngularVelocity(angularVelocity)
      => ComCall(21, this.p, Float32.Ptr, angularVelocity)
    get_MinimumScaleRotateRadius(minRadius)
      => ComCall(22, this.p, Float32.Ptr, minRadius)
    put_MinimumScaleRotateRadius(minRadius)
      => ComCall(23, this.p, Float32, minRadius)
}
struct TOUCHINPUT {
    x : Int32
    y : Int32
    hSource : HANDLE
    dwID : UInt32
    dwFlags : TOUCHEVENTF_FLAGS
    dwMask : TOUCHINPUTMASKF_MASK
    dwTime : UInt32
    dwExtraInfo : IntPtr
    cxContact : UInt32
    cyContact : UInt32
}
struct GESTUREINFO {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    dwID : UInt32
    hwndTarget : HWND
    ptsLocation : POINTS
    dwInstanceID : UInt32
    dwSequenceID : UInt32
    ullArguments : Int64
    cbExtraArgs : UInt32
}
struct GESTURENOTIFYSTRUCT {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    hwndTarget : HWND
    ptsLocation : POINTS
    dwInstanceID : UInt32
}
struct GESTURECONFIG {
    dwID : GESTURECONFIG_ID
    dwWant : UInt32
    dwBlock : UInt32
}
