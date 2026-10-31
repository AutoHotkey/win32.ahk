#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT}
#Import "..\Graphics.DirectComposition\Types.ahk" {IDCompositionAnimation}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct UI_ANIMATION_KEYFRAME {
    Value : IntPtr
}
struct UI_ANIMATION_UPDATE_RESULT extends Int32 {
    static UI_ANIMATION_UPDATE_NO_CHANGE := 0
    static UI_ANIMATION_UPDATE_VARIABLES_CHANGED := 1
}
struct UI_ANIMATION_MANAGER_STATUS extends Int32 {
    static UI_ANIMATION_MANAGER_IDLE := 0
    static UI_ANIMATION_MANAGER_BUSY := 1
}
struct UI_ANIMATION_MODE extends Int32 {
    static UI_ANIMATION_MODE_DISABLED := 0
    static UI_ANIMATION_MODE_SYSTEM_DEFAULT := 1
    static UI_ANIMATION_MODE_ENABLED := 2
}
struct UI_ANIMATION_REPEAT_MODE extends Int32 {
    static UI_ANIMATION_REPEAT_MODE_NORMAL := 0
    static UI_ANIMATION_REPEAT_MODE_ALTERNATE := 1
}
struct IUIAnimationManager extends IUnknown {
    static IID := "{9169896C-AC8D-4E7D-94E5-67FA4DC2F2E8}"
    CreateAnimationVariable(initialValue, variable)
      => ComCall(3, this.p, Float64, initialValue, IUIAnimationVariable.Ptr, variable)
    ScheduleTransition(variable, transition, timeNow)
      => ComCall(4, this.p, IUIAnimationVariable, variable, IUIAnimationTransition, transition, Float64, timeNow)
    CreateStoryboard(storyboard)
      => ComCall(5, this.p, IUIAnimationStoryboard.Ptr, storyboard)
    FinishAllStoryboards(completionDeadline)
      => ComCall(6, this.p, Float64, completionDeadline)
    AbandonAllStoryboards()
      => ComCall(7, this.p)
    Update(timeNow, updateResult?)
      => ComCall(8, this.p, Float64, timeNow, UI_ANIMATION_UPDATE_RESULT.Ptr, updateResult?)
    GetVariableFromTag(object?, id, variable)
      => ComCall(9, this.p, IUnknown, object?, UInt32, id, IUIAnimationVariable.Ptr, variable)
    GetStoryboardFromTag(object?, id, storyboard)
      => ComCall(10, this.p, IUnknown, object?, UInt32, id, IUIAnimationStoryboard.Ptr, storyboard)
    GetStatus(status)
      => ComCall(11, this.p, UI_ANIMATION_MANAGER_STATUS.Ptr, status)
    SetAnimationMode(mode)
      => ComCall(12, this.p, UI_ANIMATION_MODE, mode)
    Pause()
      => ComCall(13, this.p)
    Resume()
      => ComCall(14, this.p)
    SetManagerEventHandler(handler?)
      => ComCall(15, this.p, IUIAnimationManagerEventHandler, handler?)
    SetCancelPriorityComparison(comparison?)
      => ComCall(16, this.p, IUIAnimationPriorityComparison, comparison?)
    SetTrimPriorityComparison(comparison?)
      => ComCall(17, this.p, IUIAnimationPriorityComparison, comparison?)
    SetCompressPriorityComparison(comparison?)
      => ComCall(18, this.p, IUIAnimationPriorityComparison, comparison?)
    SetConcludePriorityComparison(comparison?)
      => ComCall(19, this.p, IUIAnimationPriorityComparison, comparison?)
    SetDefaultLongestAcceptableDelay(delay)
      => ComCall(20, this.p, Float64, delay)
    Shutdown()
      => ComCall(21, this.p)
}
struct UI_ANIMATION_ROUNDING_MODE extends Int32 {
    static UI_ANIMATION_ROUNDING_NEAREST := 0
    static UI_ANIMATION_ROUNDING_FLOOR := 1
    static UI_ANIMATION_ROUNDING_CEILING := 2
}
struct IUIAnimationVariable extends IUnknown {
    static IID := "{8CEEB155-2849-4CE5-9448-91FF70E1E4D9}"
    GetValue(value)
      => ComCall(3, this.p, Float64.Ptr, value)
    GetFinalValue(finalValue)
      => ComCall(4, this.p, Float64.Ptr, finalValue)
    GetPreviousValue(previousValue)
      => ComCall(5, this.p, Float64.Ptr, previousValue)
    GetIntegerValue(value)
      => ComCall(6, this.p, Int32.Ptr, value)
    GetFinalIntegerValue(finalValue)
      => ComCall(7, this.p, Int32.Ptr, finalValue)
    GetPreviousIntegerValue(previousValue)
      => ComCall(8, this.p, Int32.Ptr, previousValue)
    GetCurrentStoryboard(storyboard)
      => ComCall(9, this.p, IUIAnimationStoryboard.Ptr, storyboard)
    SetLowerBound(bound)
      => ComCall(10, this.p, Float64, bound)
    SetUpperBound(bound)
      => ComCall(11, this.p, Float64, bound)
    SetRoundingMode(mode)
      => ComCall(12, this.p, UI_ANIMATION_ROUNDING_MODE, mode)
    SetTag(object?, id)
      => ComCall(13, this.p, IUnknown, object?, UInt32, id)
    GetTag(object?, id?)
      => ComCall(14, this.p, IUnknown.Ptr, object?, UInt32.Ptr, id?)
    SetVariableChangeHandler(handler?)
      => ComCall(15, this.p, IUIAnimationVariableChangeHandler, handler?)
    SetVariableIntegerChangeHandler(handler?)
      => ComCall(16, this.p, IUIAnimationVariableIntegerChangeHandler, handler?)
}
struct UI_ANIMATION_STORYBOARD_STATUS extends Int32 {
    static UI_ANIMATION_STORYBOARD_BUILDING := 0
    static UI_ANIMATION_STORYBOARD_SCHEDULED := 1
    static UI_ANIMATION_STORYBOARD_CANCELLED := 2
    static UI_ANIMATION_STORYBOARD_PLAYING := 3
    static UI_ANIMATION_STORYBOARD_TRUNCATED := 4
    static UI_ANIMATION_STORYBOARD_FINISHED := 5
    static UI_ANIMATION_STORYBOARD_READY := 6
    static UI_ANIMATION_STORYBOARD_INSUFFICIENT_PRIORITY := 7
}
struct UI_ANIMATION_SCHEDULING_RESULT extends Int32 {
    static UI_ANIMATION_SCHEDULING_UNEXPECTED_FAILURE := 0
    static UI_ANIMATION_SCHEDULING_INSUFFICIENT_PRIORITY := 1
    static UI_ANIMATION_SCHEDULING_ALREADY_SCHEDULED := 2
    static UI_ANIMATION_SCHEDULING_SUCCEEDED := 3
    static UI_ANIMATION_SCHEDULING_DEFERRED := 4
}
struct IUIAnimationStoryboard extends IUnknown {
    static IID := "{A8FF128F-9BF9-4AF1-9E67-E5E410DEFB84}"
    AddTransition(variable, transition)
      => ComCall(3, this.p, IUIAnimationVariable, variable, IUIAnimationTransition, transition)
    AddKeyframeAtOffset(existingKeyframe, offset, keyframe)
      => ComCall(4, this.p, UI_ANIMATION_KEYFRAME, existingKeyframe, Float64, offset, UI_ANIMATION_KEYFRAME.Ptr, keyframe)
    AddKeyframeAfterTransition(transition, keyframe)
      => ComCall(5, this.p, IUIAnimationTransition, transition, UI_ANIMATION_KEYFRAME.Ptr, keyframe)
    AddTransitionAtKeyframe(variable, transition, startKeyframe)
      => ComCall(6, this.p, IUIAnimationVariable, variable, IUIAnimationTransition, transition, UI_ANIMATION_KEYFRAME, startKeyframe)
    AddTransitionBetweenKeyframes(variable, transition, startKeyframe, endKeyframe)
      => ComCall(7, this.p, IUIAnimationVariable, variable, IUIAnimationTransition, transition, UI_ANIMATION_KEYFRAME, startKeyframe, UI_ANIMATION_KEYFRAME, endKeyframe)
    RepeatBetweenKeyframes(startKeyframe, endKeyframe, repetitionCount)
      => ComCall(8, this.p, UI_ANIMATION_KEYFRAME, startKeyframe, UI_ANIMATION_KEYFRAME, endKeyframe, Int32, repetitionCount)
    HoldVariable(variable)
      => ComCall(9, this.p, IUIAnimationVariable, variable)
    SetLongestAcceptableDelay(delay)
      => ComCall(10, this.p, Float64, delay)
    Schedule(timeNow, schedulingResult?)
      => ComCall(11, this.p, Float64, timeNow, UI_ANIMATION_SCHEDULING_RESULT.Ptr, schedulingResult?)
    Conclude()
      => ComCall(12, this.p)
    Finish(completionDeadline)
      => ComCall(13, this.p, Float64, completionDeadline)
    Abandon()
      => ComCall(14, this.p)
    SetTag(object?, id)
      => ComCall(15, this.p, IUnknown, object?, UInt32, id)
    GetTag(object?, id?)
      => ComCall(16, this.p, IUnknown.Ptr, object?, UInt32.Ptr, id?)
    GetStatus(status)
      => ComCall(17, this.p, UI_ANIMATION_STORYBOARD_STATUS.Ptr, status)
    GetElapsedTime(elapsedTime)
      => ComCall(18, this.p, Float64.Ptr, elapsedTime)
    SetStoryboardEventHandler(handler?)
      => ComCall(19, this.p, IUIAnimationStoryboardEventHandler, handler?)
}
struct IUIAnimationTransition extends IUnknown {
    static IID := "{DC6CE252-F731-41CF-B610-614B6CA049AD}"
    SetInitialValue(value)
      => ComCall(3, this.p, Float64, value)
    SetInitialVelocity(velocity)
      => ComCall(4, this.p, Float64, velocity)
    IsDurationKnown()
      => ComCall(5, this.p)
    GetDuration(duration)
      => ComCall(6, this.p, Float64.Ptr, duration)
}
struct IUIAnimationManagerEventHandler extends IUnknown {
    static IID := "{783321ED-78A3-4366-B574-6AF607A64788}"
    OnManagerStatusChanged(newStatus, previousStatus)
      => ComCall(3, this.p, UI_ANIMATION_MANAGER_STATUS, newStatus, UI_ANIMATION_MANAGER_STATUS, previousStatus)
}
struct IUIAnimationVariableChangeHandler extends IUnknown {
    static IID := "{6358B7BA-87D2-42D5-BF71-82E919DD5862}"
    OnValueChanged(storyboard, variable, newValue, previousValue)
      => ComCall(3, this.p, IUIAnimationStoryboard, storyboard, IUIAnimationVariable, variable, Float64, newValue, Float64, previousValue)
}
struct IUIAnimationVariableIntegerChangeHandler extends IUnknown {
    static IID := "{BB3E1550-356E-44B0-99DA-85AC6017865E}"
    OnIntegerValueChanged(storyboard, variable, newValue, previousValue)
      => ComCall(3, this.p, IUIAnimationStoryboard, storyboard, IUIAnimationVariable, variable, Int32, newValue, Int32, previousValue)
}
struct IUIAnimationStoryboardEventHandler extends IUnknown {
    static IID := "{3D5C9008-EC7C-4364-9F8A-9AF3C58CBAE6}"
    OnStoryboardStatusChanged(storyboard, newStatus, previousStatus)
      => ComCall(3, this.p, IUIAnimationStoryboard, storyboard, UI_ANIMATION_STORYBOARD_STATUS, newStatus, UI_ANIMATION_STORYBOARD_STATUS, previousStatus)
    OnStoryboardUpdated(storyboard)
      => ComCall(4, this.p, IUIAnimationStoryboard, storyboard)
}
struct UI_ANIMATION_PRIORITY_EFFECT extends Int32 {
    static UI_ANIMATION_PRIORITY_EFFECT_FAILURE := 0
    static UI_ANIMATION_PRIORITY_EFFECT_DELAY := 1
}
struct IUIAnimationPriorityComparison extends IUnknown {
    static IID := "{83FA9B74-5F86-4618-BC6A-A2FAC19B3F44}"
    HasPriority(scheduledStoryboard, newStoryboard, priorityEffect)
      => ComCall(3, this.p, IUIAnimationStoryboard, scheduledStoryboard, IUIAnimationStoryboard, newStoryboard, UI_ANIMATION_PRIORITY_EFFECT, priorityEffect)
}
struct UI_ANIMATION_SLOPE extends Int32 {
    static UI_ANIMATION_SLOPE_INCREASING := 0
    static UI_ANIMATION_SLOPE_DECREASING := 1
}
struct IUIAnimationTransitionLibrary extends IUnknown {
    static IID := "{CA5A14B1-D24F-48B8-8FE4-C78169BA954E}"
    CreateInstantaneousTransition(finalValue, transition)
      => ComCall(3, this.p, Float64, finalValue, IUIAnimationTransition.Ptr, transition)
    CreateConstantTransition(duration, transition)
      => ComCall(4, this.p, Float64, duration, IUIAnimationTransition.Ptr, transition)
    CreateDiscreteTransition(delay, finalValue, hold, transition)
      => ComCall(5, this.p, Float64, delay, Float64, finalValue, Float64, hold, IUIAnimationTransition.Ptr, transition)
    CreateLinearTransition(duration, finalValue, transition)
      => ComCall(6, this.p, Float64, duration, Float64, finalValue, IUIAnimationTransition.Ptr, transition)
    CreateLinearTransitionFromSpeed(speed, finalValue, transition)
      => ComCall(7, this.p, Float64, speed, Float64, finalValue, IUIAnimationTransition.Ptr, transition)
    CreateSinusoidalTransitionFromVelocity(duration, period, transition)
      => ComCall(8, this.p, Float64, duration, Float64, period, IUIAnimationTransition.Ptr, transition)
    CreateSinusoidalTransitionFromRange(duration, minimumValue, maximumValue, period, slope, transition)
      => ComCall(9, this.p, Float64, duration, Float64, minimumValue, Float64, maximumValue, Float64, period, UI_ANIMATION_SLOPE, slope, IUIAnimationTransition.Ptr, transition)
    CreateAccelerateDecelerateTransition(duration, finalValue, accelerationRatio, decelerationRatio, transition)
      => ComCall(10, this.p, Float64, duration, Float64, finalValue, Float64, accelerationRatio, Float64, decelerationRatio, IUIAnimationTransition.Ptr, transition)
    CreateReversalTransition(duration, transition)
      => ComCall(11, this.p, Float64, duration, IUIAnimationTransition.Ptr, transition)
    CreateCubicTransition(duration, finalValue, finalVelocity, transition)
      => ComCall(12, this.p, Float64, duration, Float64, finalValue, Float64, finalVelocity, IUIAnimationTransition.Ptr, transition)
    CreateSmoothStopTransition(maximumDuration, finalValue, transition)
      => ComCall(13, this.p, Float64, maximumDuration, Float64, finalValue, IUIAnimationTransition.Ptr, transition)
    CreateParabolicTransitionFromAcceleration(finalValue, finalVelocity, acceleration, transition)
      => ComCall(14, this.p, Float64, finalValue, Float64, finalVelocity, Float64, acceleration, IUIAnimationTransition.Ptr, transition)
}
struct UI_ANIMATION_DEPENDENCIES extends Int32 {
    static UI_ANIMATION_DEPENDENCY_NONE := 0
    static UI_ANIMATION_DEPENDENCY_INTERMEDIATE_VALUES := 1
    static UI_ANIMATION_DEPENDENCY_FINAL_VALUE := 2
    static UI_ANIMATION_DEPENDENCY_FINAL_VELOCITY := 4
    static UI_ANIMATION_DEPENDENCY_DURATION := 8
}
struct IUIAnimationInterpolator extends IUnknown {
    static IID := "{7815CBBA-DDF7-478C-A46C-7B6C738B7978}"
    SetInitialValueAndVelocity(initialValue, initialVelocity)
      => ComCall(3, this.p, Float64, initialValue, Float64, initialVelocity)
    SetDuration(duration)
      => ComCall(4, this.p, Float64, duration)
    GetDuration(duration)
      => ComCall(5, this.p, Float64.Ptr, duration)
    GetFinalValue(value)
      => ComCall(6, this.p, Float64.Ptr, value)
    InterpolateValue(offset, value)
      => ComCall(7, this.p, Float64, offset, Float64.Ptr, value)
    InterpolateVelocity(offset, velocity)
      => ComCall(8, this.p, Float64, offset, Float64.Ptr, velocity)
    GetDependencies(initialValueDependencies, initialVelocityDependencies, durationDependencies)
      => ComCall(9, this.p, UI_ANIMATION_DEPENDENCIES.Ptr, initialValueDependencies, UI_ANIMATION_DEPENDENCIES.Ptr, initialVelocityDependencies, UI_ANIMATION_DEPENDENCIES.Ptr, durationDependencies)
}
struct IUIAnimationTransitionFactory extends IUnknown {
    static IID := "{FCD91E03-3E3B-45AD-BBB1-6DFC8153743D}"
    CreateTransition(interpolator, transition)
      => ComCall(3, this.p, IUIAnimationInterpolator, interpolator, IUIAnimationTransition.Ptr, transition)
}
struct UI_ANIMATION_IDLE_BEHAVIOR extends Int32 {
    static UI_ANIMATION_IDLE_BEHAVIOR_CONTINUE := 0
    static UI_ANIMATION_IDLE_BEHAVIOR_DISABLE := 1
}
struct IUIAnimationTimer extends IUnknown {
    static IID := "{6B0EFAD1-A053-41D6-9085-33A689144665}"
    SetTimerUpdateHandler(updateHandler?, idleBehavior)
      => ComCall(3, this.p, IUIAnimationTimerUpdateHandler, updateHandler?, UI_ANIMATION_IDLE_BEHAVIOR, idleBehavior)
    SetTimerEventHandler(handler?)
      => ComCall(4, this.p, IUIAnimationTimerEventHandler, handler?)
    Enable()
      => ComCall(5, this.p)
    Disable()
      => ComCall(6, this.p)
    IsEnabled()
      => ComCall(7, this.p)
    GetTime(seconds)
      => ComCall(8, this.p, Float64.Ptr, seconds)
    SetFrameRateThreshold(framesPerSecond)
      => ComCall(9, this.p, UInt32, framesPerSecond)
}
struct IUIAnimationTimerUpdateHandler extends IUnknown {
    static IID := "{195509B7-5D5E-4E3E-B278-EE3759B367AD}"
    OnUpdate(timeNow, result)
      => ComCall(3, this.p, Float64, timeNow, UI_ANIMATION_UPDATE_RESULT.Ptr, result)
    SetTimerClientEventHandler(handler)
      => ComCall(4, this.p, IUIAnimationTimerClientEventHandler, handler)
    ClearTimerClientEventHandler()
      => ComCall(5, this.p)
}
struct UI_ANIMATION_TIMER_CLIENT_STATUS extends Int32 {
    static UI_ANIMATION_TIMER_CLIENT_IDLE := 0
    static UI_ANIMATION_TIMER_CLIENT_BUSY := 1
}
struct IUIAnimationTimerClientEventHandler extends IUnknown {
    static IID := "{BEDB4DB6-94FA-4BFB-A47F-EF2D9E408C25}"
    OnTimerClientStatusChanged(newStatus, previousStatus)
      => ComCall(3, this.p, UI_ANIMATION_TIMER_CLIENT_STATUS, newStatus, UI_ANIMATION_TIMER_CLIENT_STATUS, previousStatus)
}
struct IUIAnimationTimerEventHandler extends IUnknown {
    static IID := "{274A7DEA-D771-4095-ABBD-8DF7ABD23CE3}"
    OnPreUpdate()
      => ComCall(3, this.p)
    OnPostUpdate()
      => ComCall(4, this.p)
    OnRenderingTooSlow(framesPerSecond)
      => ComCall(5, this.p, UInt32, framesPerSecond)
}
struct IUIAnimationManager2 extends IUnknown {
    static IID := "{D8B6F7D4-4109-4D3F-ACEE-879926968CB1}"
    CreateAnimationVectorVariable(initialValue, variable)
      => ComCall(3, this.p, Float64.Ptr, initialValue, UInt32, initialValue.Length, IUIAnimationVariable2.Ptr, variable)
    CreateAnimationVariable(initialValue, variable)
      => ComCall(4, this.p, Float64, initialValue, IUIAnimationVariable2.Ptr, variable)
    ScheduleTransition(variable, transition, timeNow)
      => ComCall(5, this.p, IUIAnimationVariable2, variable, IUIAnimationTransition2, transition, Float64, timeNow)
    CreateStoryboard(storyboard)
      => ComCall(6, this.p, IUIAnimationStoryboard2.Ptr, storyboard)
    FinishAllStoryboards(completionDeadline)
      => ComCall(7, this.p, Float64, completionDeadline)
    AbandonAllStoryboards()
      => ComCall(8, this.p)
    Update(timeNow, updateResult?)
      => ComCall(9, this.p, Float64, timeNow, UI_ANIMATION_UPDATE_RESULT.Ptr, updateResult?)
    GetVariableFromTag(object?, id, variable)
      => ComCall(10, this.p, IUnknown, object?, UInt32, id, IUIAnimationVariable2.Ptr, variable)
    GetStoryboardFromTag(object?, id, storyboard)
      => ComCall(11, this.p, IUnknown, object?, UInt32, id, IUIAnimationStoryboard2.Ptr, storyboard)
    EstimateNextEventTime(seconds)
      => ComCall(12, this.p, Float64.Ptr, seconds)
    GetStatus(status)
      => ComCall(13, this.p, UI_ANIMATION_MANAGER_STATUS.Ptr, status)
    SetAnimationMode(mode)
      => ComCall(14, this.p, UI_ANIMATION_MODE, mode)
    Pause()
      => ComCall(15, this.p)
    Resume()
      => ComCall(16, this.p)
    SetManagerEventHandler(handler?, fRegisterForNextAnimationEvent)
      => ComCall(17, this.p, IUIAnimationManagerEventHandler2, handler?, BOOL, fRegisterForNextAnimationEvent)
    SetCancelPriorityComparison(comparison?)
      => ComCall(18, this.p, IUIAnimationPriorityComparison2, comparison?)
    SetTrimPriorityComparison(comparison?)
      => ComCall(19, this.p, IUIAnimationPriorityComparison2, comparison?)
    SetCompressPriorityComparison(comparison?)
      => ComCall(20, this.p, IUIAnimationPriorityComparison2, comparison?)
    SetConcludePriorityComparison(comparison?)
      => ComCall(21, this.p, IUIAnimationPriorityComparison2, comparison?)
    SetDefaultLongestAcceptableDelay(delay)
      => ComCall(22, this.p, Float64, delay)
    Shutdown()
      => ComCall(23, this.p)
}
struct IUIAnimationVariable2 extends IUnknown {
    static IID := "{4914B304-96AB-44D9-9E77-D5109B7E7466}"
    GetDimension(dimension)
      => ComCall(3, this.p, UInt32.Ptr, dimension)
    GetValue(value)
      => ComCall(4, this.p, Float64.Ptr, value)
    GetVectorValue(value)
      => ComCall(5, this.p, Float64.Ptr, value, UInt32, value.Length)
    GetCurve(animation)
      => ComCall(6, this.p, IDCompositionAnimation, animation)
    GetVectorCurve(animation)
      => ComCall(7, this.p, IDCompositionAnimation.Ptr, animation, UInt32, animation.Length)
    GetFinalValue(finalValue)
      => ComCall(8, this.p, Float64.Ptr, finalValue)
    GetFinalVectorValue(finalValue)
      => ComCall(9, this.p, Float64.Ptr, finalValue, UInt32, finalValue.Length)
    GetPreviousValue(previousValue)
      => ComCall(10, this.p, Float64.Ptr, previousValue)
    GetPreviousVectorValue(previousValue)
      => ComCall(11, this.p, Float64.Ptr, previousValue, UInt32, previousValue.Length)
    GetIntegerValue(value)
      => ComCall(12, this.p, Int32.Ptr, value)
    GetIntegerVectorValue(value)
      => ComCall(13, this.p, Int32.Ptr, value, UInt32, value.Length)
    GetFinalIntegerValue(finalValue)
      => ComCall(14, this.p, Int32.Ptr, finalValue)
    GetFinalIntegerVectorValue(finalValue)
      => ComCall(15, this.p, Int32.Ptr, finalValue, UInt32, finalValue.Length)
    GetPreviousIntegerValue(previousValue)
      => ComCall(16, this.p, Int32.Ptr, previousValue)
    GetPreviousIntegerVectorValue(previousValue)
      => ComCall(17, this.p, Int32.Ptr, previousValue, UInt32, previousValue.Length)
    GetCurrentStoryboard(storyboard)
      => ComCall(18, this.p, IUIAnimationStoryboard2.Ptr, storyboard)
    SetLowerBound(bound)
      => ComCall(19, this.p, Float64, bound)
    SetLowerBoundVector(bound)
      => ComCall(20, this.p, Float64.Ptr, bound, UInt32, bound.Length)
    SetUpperBound(bound)
      => ComCall(21, this.p, Float64, bound)
    SetUpperBoundVector(bound)
      => ComCall(22, this.p, Float64.Ptr, bound, UInt32, bound.Length)
    SetRoundingMode(mode)
      => ComCall(23, this.p, UI_ANIMATION_ROUNDING_MODE, mode)
    SetTag(object?, id)
      => ComCall(24, this.p, IUnknown, object?, UInt32, id)
    GetTag(object?, id?)
      => ComCall(25, this.p, IUnknown.Ptr, object?, UInt32.Ptr, id?)
    SetVariableChangeHandler(handler?, fRegisterForNextAnimationEvent)
      => ComCall(26, this.p, IUIAnimationVariableChangeHandler2, handler?, BOOL, fRegisterForNextAnimationEvent)
    SetVariableIntegerChangeHandler(handler?, fRegisterForNextAnimationEvent)
      => ComCall(27, this.p, IUIAnimationVariableIntegerChangeHandler2, handler?, BOOL, fRegisterForNextAnimationEvent)
    SetVariableCurveChangeHandler(handler?)
      => ComCall(28, this.p, IUIAnimationVariableCurveChangeHandler2, handler?)
}
struct IUIAnimationTransition2 extends IUnknown {
    static IID := "{62FF9123-A85A-4E9B-A218-435A93E268FD}"
    GetDimension(dimension)
      => ComCall(3, this.p, UInt32.Ptr, dimension)
    SetInitialValue(value)
      => ComCall(4, this.p, Float64, value)
    SetInitialVectorValue(value)
      => ComCall(5, this.p, Float64.Ptr, value, UInt32, value.Length)
    SetInitialVelocity(velocity)
      => ComCall(6, this.p, Float64, velocity)
    SetInitialVectorVelocity(velocity)
      => ComCall(7, this.p, Float64.Ptr, velocity, UInt32, velocity.Length)
    IsDurationKnown()
      => ComCall(8, this.p)
    GetDuration(duration)
      => ComCall(9, this.p, Float64.Ptr, duration)
}
struct IUIAnimationManagerEventHandler2 extends IUnknown {
    static IID := "{F6E022BA-BFF3-42EC-9033-E073F33E83C3}"
    OnManagerStatusChanged(newStatus, previousStatus)
      => ComCall(3, this.p, UI_ANIMATION_MANAGER_STATUS, newStatus, UI_ANIMATION_MANAGER_STATUS, previousStatus)
}
struct IUIAnimationVariableChangeHandler2 extends IUnknown {
    static IID := "{63ACC8D2-6EAE-4BB0-B879-586DD8CFBE42}"
    OnValueChanged(storyboard, variable, newValue, previousValue)
      => ComCall(3, this.p, IUIAnimationStoryboard2, storyboard, IUIAnimationVariable2, variable, Float64.Ptr, newValue, Float64.Ptr, previousValue, UInt32, previousValue.Length)
}
struct IUIAnimationVariableIntegerChangeHandler2 extends IUnknown {
    static IID := "{829B6CF1-4F3A-4412-AE09-B243EB4C6B58}"
    OnIntegerValueChanged(storyboard, variable, newValue, previousValue)
      => ComCall(3, this.p, IUIAnimationStoryboard2, storyboard, IUIAnimationVariable2, variable, Int32.Ptr, newValue, Int32.Ptr, previousValue, UInt32, previousValue.Length)
}
struct IUIAnimationVariableCurveChangeHandler2 extends IUnknown {
    static IID := "{72895E91-0145-4C21-9192-5AAB40EDDF80}"
    OnCurveChanged(variable)
      => ComCall(3, this.p, IUIAnimationVariable2, variable)
}
struct IUIAnimationStoryboardEventHandler2 extends IUnknown {
    static IID := "{BAC5F55A-BA7C-414C-B599-FBF850F553C6}"
    OnStoryboardStatusChanged(storyboard, newStatus, previousStatus)
      => ComCall(3, this.p, IUIAnimationStoryboard2, storyboard, UI_ANIMATION_STORYBOARD_STATUS, newStatus, UI_ANIMATION_STORYBOARD_STATUS, previousStatus)
    OnStoryboardUpdated(storyboard)
      => ComCall(4, this.p, IUIAnimationStoryboard2, storyboard)
}
struct IUIAnimationLoopIterationChangeHandler2 extends IUnknown {
    static IID := "{2D3B15A4-4762-47AB-A030-B23221DF3AE0}"
    OnLoopIterationChanged(storyboard, id, newIterationCount, oldIterationCount)
      => ComCall(3, this.p, IUIAnimationStoryboard2, storyboard, IntPtr, id, UInt32, newIterationCount, UInt32, oldIterationCount)
}
struct IUIAnimationPriorityComparison2 extends IUnknown {
    static IID := "{5B6D7A37-4621-467C-8B05-70131DE62DDB}"
    HasPriority(scheduledStoryboard, newStoryboard, priorityEffect)
      => ComCall(3, this.p, IUIAnimationStoryboard2, scheduledStoryboard, IUIAnimationStoryboard2, newStoryboard, UI_ANIMATION_PRIORITY_EFFECT, priorityEffect)
}
struct IUIAnimationTransitionLibrary2 extends IUnknown {
    static IID := "{03CFAE53-9580-4EE3-B363-2ECE51B4AF6A}"
    CreateInstantaneousTransition(finalValue, transition)
      => ComCall(3, this.p, Float64, finalValue, IUIAnimationTransition2.Ptr, transition)
    CreateInstantaneousVectorTransition(finalValue, transition)
      => ComCall(4, this.p, Float64.Ptr, finalValue, UInt32, finalValue.Length, IUIAnimationTransition2.Ptr, transition)
    CreateConstantTransition(duration, transition)
      => ComCall(5, this.p, Float64, duration, IUIAnimationTransition2.Ptr, transition)
    CreateDiscreteTransition(delay, finalValue, hold, transition)
      => ComCall(6, this.p, Float64, delay, Float64, finalValue, Float64, hold, IUIAnimationTransition2.Ptr, transition)
    CreateDiscreteVectorTransition(delay, finalValue, hold, transition)
      => ComCall(7, this.p, Float64, delay, Float64.Ptr, finalValue, UInt32, finalValue.Length, Float64, hold, IUIAnimationTransition2.Ptr, transition)
    CreateLinearTransition(duration, finalValue, transition)
      => ComCall(8, this.p, Float64, duration, Float64, finalValue, IUIAnimationTransition2.Ptr, transition)
    CreateLinearVectorTransition(duration, finalValue, transition)
      => ComCall(9, this.p, Float64, duration, Float64.Ptr, finalValue, UInt32, finalValue.Length, IUIAnimationTransition2.Ptr, transition)
    CreateLinearTransitionFromSpeed(speed, finalValue, transition)
      => ComCall(10, this.p, Float64, speed, Float64, finalValue, IUIAnimationTransition2.Ptr, transition)
    CreateLinearVectorTransitionFromSpeed(speed, finalValue, transition)
      => ComCall(11, this.p, Float64, speed, Float64.Ptr, finalValue, UInt32, finalValue.Length, IUIAnimationTransition2.Ptr, transition)
    CreateSinusoidalTransitionFromVelocity(duration, period, transition)
      => ComCall(12, this.p, Float64, duration, Float64, period, IUIAnimationTransition2.Ptr, transition)
    CreateSinusoidalTransitionFromRange(duration, minimumValue, maximumValue, period, slope, transition)
      => ComCall(13, this.p, Float64, duration, Float64, minimumValue, Float64, maximumValue, Float64, period, UI_ANIMATION_SLOPE, slope, IUIAnimationTransition2.Ptr, transition)
    CreateAccelerateDecelerateTransition(duration, finalValue, accelerationRatio, decelerationRatio, transition)
      => ComCall(14, this.p, Float64, duration, Float64, finalValue, Float64, accelerationRatio, Float64, decelerationRatio, IUIAnimationTransition2.Ptr, transition)
    CreateReversalTransition(duration, transition)
      => ComCall(15, this.p, Float64, duration, IUIAnimationTransition2.Ptr, transition)
    CreateCubicTransition(duration, finalValue, finalVelocity, transition)
      => ComCall(16, this.p, Float64, duration, Float64, finalValue, Float64, finalVelocity, IUIAnimationTransition2.Ptr, transition)
    CreateCubicVectorTransition(duration, finalValue, finalVelocity, transition)
      => ComCall(17, this.p, Float64, duration, Float64.Ptr, finalValue, Float64.Ptr, finalVelocity, UInt32, finalVelocity.Length, IUIAnimationTransition2.Ptr, transition)
    CreateSmoothStopTransition(maximumDuration, finalValue, transition)
      => ComCall(18, this.p, Float64, maximumDuration, Float64, finalValue, IUIAnimationTransition2.Ptr, transition)
    CreateParabolicTransitionFromAcceleration(finalValue, finalVelocity, acceleration, transition)
      => ComCall(19, this.p, Float64, finalValue, Float64, finalVelocity, Float64, acceleration, IUIAnimationTransition2.Ptr, transition)
    CreateCubicBezierLinearTransition(duration, finalValue, x1, y1, x2, y2, ppTransition)
      => ComCall(20, this.p, Float64, duration, Float64, finalValue, Float64, x1, Float64, y1, Float64, x2, Float64, y2, IUIAnimationTransition2.Ptr, ppTransition)
    CreateCubicBezierLinearVectorTransition(duration, finalValue, x1, y1, x2, y2, ppTransition)
      => ComCall(21, this.p, Float64, duration, Float64.Ptr, finalValue, UInt32, finalValue.Length, Float64, x1, Float64, y1, Float64, x2, Float64, y2, IUIAnimationTransition2.Ptr, ppTransition)
}
struct IUIAnimationPrimitiveInterpolation extends IUnknown {
    static IID := "{BAB20D63-4361-45DA-A24F-AB8508846B5B}"
    AddCubic(dimension, beginOffset, constantCoefficient, linearCoefficient, quadraticCoefficient, cubicCoefficient)
      => ComCall(3, this.p, UInt32, dimension, Float64, beginOffset, Float32, constantCoefficient, Float32, linearCoefficient, Float32, quadraticCoefficient, Float32, cubicCoefficient)
    AddSinusoidal(dimension, beginOffset, bias, amplitude, frequency, phase)
      => ComCall(4, this.p, UInt32, dimension, Float64, beginOffset, Float32, bias, Float32, amplitude, Float32, frequency, Float32, phase)
}
struct IUIAnimationInterpolator2 extends IUnknown {
    static IID := "{EA76AFF8-EA22-4A23-A0EF-A6A966703518}"
    GetDimension(dimension)
      => ComCall(3, this.p, UInt32.Ptr, dimension)
    SetInitialValueAndVelocity(initialValue, initialVelocity)
      => ComCall(4, this.p, Float64.Ptr, initialValue, Float64.Ptr, initialVelocity, UInt32, initialVelocity.Length)
    SetDuration(duration)
      => ComCall(5, this.p, Float64, duration)
    GetDuration(duration)
      => ComCall(6, this.p, Float64.Ptr, duration)
    GetFinalValue(value)
      => ComCall(7, this.p, Float64.Ptr, value, UInt32, value.Length)
    InterpolateValue(offset, value)
      => ComCall(8, this.p, Float64, offset, Float64.Ptr, value, UInt32, value.Length)
    InterpolateVelocity(offset, velocity)
      => ComCall(9, this.p, Float64, offset, Float64.Ptr, velocity, UInt32, velocity.Length)
    GetPrimitiveInterpolation(interpolation, cDimension)
      => ComCall(10, this.p, IUIAnimationPrimitiveInterpolation, interpolation, UInt32, cDimension)
    GetDependencies(initialValueDependencies, initialVelocityDependencies, durationDependencies)
      => ComCall(11, this.p, UI_ANIMATION_DEPENDENCIES.Ptr, initialValueDependencies, UI_ANIMATION_DEPENDENCIES.Ptr, initialVelocityDependencies, UI_ANIMATION_DEPENDENCIES.Ptr, durationDependencies)
}
struct IUIAnimationTransitionFactory2 extends IUnknown {
    static IID := "{937D4916-C1A6-42D5-88D8-30344D6EFE31}"
    CreateTransition(interpolator, transition)
      => ComCall(3, this.p, IUIAnimationInterpolator2, interpolator, IUIAnimationTransition2.Ptr, transition)
}
struct IUIAnimationStoryboard2 extends IUnknown {
    static IID := "{AE289CD2-12D4-4945-9419-9E41BE034DF2}"
    AddTransition(variable, transition)
      => ComCall(3, this.p, IUIAnimationVariable2, variable, IUIAnimationTransition2, transition)
    AddKeyframeAtOffset(existingKeyframe, offset, keyframe)
      => ComCall(4, this.p, UI_ANIMATION_KEYFRAME, existingKeyframe, Float64, offset, UI_ANIMATION_KEYFRAME.Ptr, keyframe)
    AddKeyframeAfterTransition(transition, keyframe)
      => ComCall(5, this.p, IUIAnimationTransition2, transition, UI_ANIMATION_KEYFRAME.Ptr, keyframe)
    AddTransitionAtKeyframe(variable, transition, startKeyframe)
      => ComCall(6, this.p, IUIAnimationVariable2, variable, IUIAnimationTransition2, transition, UI_ANIMATION_KEYFRAME, startKeyframe)
    AddTransitionBetweenKeyframes(variable, transition, startKeyframe, endKeyframe)
      => ComCall(7, this.p, IUIAnimationVariable2, variable, IUIAnimationTransition2, transition, UI_ANIMATION_KEYFRAME, startKeyframe, UI_ANIMATION_KEYFRAME, endKeyframe)
    RepeatBetweenKeyframes(startKeyframe, endKeyframe, cRepetition, repeatMode, pIterationChangeHandler?, id, fRegisterForNextAnimationEvent)
      => ComCall(8, this.p, UI_ANIMATION_KEYFRAME, startKeyframe, UI_ANIMATION_KEYFRAME, endKeyframe, Float64, cRepetition, UI_ANIMATION_REPEAT_MODE, repeatMode, IUIAnimationLoopIterationChangeHandler2, pIterationChangeHandler?, IntPtr, id, BOOL, fRegisterForNextAnimationEvent)
    HoldVariable(variable)
      => ComCall(9, this.p, IUIAnimationVariable2, variable)
    SetLongestAcceptableDelay(delay)
      => ComCall(10, this.p, Float64, delay)
    SetSkipDuration(secondsDuration)
      => ComCall(11, this.p, Float64, secondsDuration)
    Schedule(timeNow, schedulingResult?)
      => ComCall(12, this.p, Float64, timeNow, UI_ANIMATION_SCHEDULING_RESULT.Ptr, schedulingResult?)
    Conclude()
      => ComCall(13, this.p)
    Finish(completionDeadline)
      => ComCall(14, this.p, Float64, completionDeadline)
    Abandon()
      => ComCall(15, this.p)
    SetTag(object?, id)
      => ComCall(16, this.p, IUnknown, object?, UInt32, id)
    GetTag(object?, id?)
      => ComCall(17, this.p, IUnknown.Ptr, object?, UInt32.Ptr, id?)
    GetStatus(status)
      => ComCall(18, this.p, UI_ANIMATION_STORYBOARD_STATUS.Ptr, status)
    GetElapsedTime(elapsedTime)
      => ComCall(19, this.p, Float64.Ptr, elapsedTime)
    SetStoryboardEventHandler(handler?, fRegisterStatusChangeForNextAnimationEvent, fRegisterUpdateForNextAnimationEvent)
      => ComCall(20, this.p, IUIAnimationStoryboardEventHandler2, handler?, BOOL, fRegisterStatusChangeForNextAnimationEvent, BOOL, fRegisterUpdateForNextAnimationEvent)
}
