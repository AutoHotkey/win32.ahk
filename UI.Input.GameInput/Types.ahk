#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {APP_LOCAL_DEVICE_ID, HANDLE, HRESULT, PSTR, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct GameInputKind extends Int32 {
    static GameInputKindUnknown := 0
    static GameInputKindRawDeviceReport := 1
    static GameInputKindControllerAxis := 2
    static GameInputKindControllerButton := 4
    static GameInputKindControllerSwitch := 8
    static GameInputKindController := 14
    static GameInputKindKeyboard := 16
    static GameInputKindMouse := 32
    static GameInputKindTouch := 256
    static GameInputKindMotion := 4096
    static GameInputKindArcadeStick := 65536
    static GameInputKindFlightStick := 131072
    static GameInputKindGamepad := 262144
    static GameInputKindRacingWheel := 524288
    static GameInputKindUiNavigation := 16777216
}
struct GameInputEnumerationKind extends Int32 {
    static GameInputNoEnumeration := 0
    static GameInputAsyncEnumeration := 1
    static GameInputBlockingEnumeration := 2
}
struct GameInputFocusPolicy extends Int32 {
    static GameInputDefaultFocusPolicy := 0
    static GameInputDisableBackgroundInput := 1
    static GameInputExclusiveForegroundInput := 2
    static GameInputDisableBackgroundGuideButton := 4
    static GameInputExclusiveForegroundGuideButton := 8
    static GameInputDisableBackgroundShareButton := 16
    static GameInputExclusiveForegroundShareButton := 32
}
struct GameInputSwitchKind extends Int32 {
    static GameInputUnknownSwitchKind := -1
    static GameInput2WaySwitch := 0
    static GameInput4WaySwitch := 1
    static GameInput8WaySwitch := 2
}
struct GameInputSwitchPosition extends Int32 {
    static GameInputSwitchCenter := 0
    static GameInputSwitchUp := 1
    static GameInputSwitchUpRight := 2
    static GameInputSwitchRight := 3
    static GameInputSwitchDownRight := 4
    static GameInputSwitchDown := 5
    static GameInputSwitchDownLeft := 6
    static GameInputSwitchLeft := 7
    static GameInputSwitchUpLeft := 8
}
struct GameInputKeyboardKind extends Int32 {
    static GameInputUnknownKeyboard := -1
    static GameInputAnsiKeyboard := 0
    static GameInputIsoKeyboard := 1
    static GameInputKsKeyboard := 2
    static GameInputAbntKeyboard := 3
    static GameInputJisKeyboard := 4
}
struct GameInputMouseButtons extends Int32 {
    static GameInputMouseNone := 0
    static GameInputMouseLeftButton := 1
    static GameInputMouseRightButton := 2
    static GameInputMouseMiddleButton := 4
    static GameInputMouseButton4 := 8
    static GameInputMouseButton5 := 16
    static GameInputMouseWheelTiltLeft := 32
    static GameInputMouseWheelTiltRight := 64
}
struct GameInputTouchShape extends Int32 {
    static GameInputTouchShapeUnknown := -1
    static GameInputTouchShapePoint := 0
    static GameInputTouchShape1DLinear := 1
    static GameInputTouchShape1DRadial := 2
    static GameInputTouchShape1DIrregular := 3
    static GameInputTouchShape2DRectangular := 4
    static GameInputTouchShape2DElliptical := 5
    static GameInputTouchShape2DIrregular := 6
}
struct GameInputMotionAccuracy extends Int32 {
    static GameInputMotionAccuracyUnknown := -1
    static GameInputMotionUnavailable := 0
    static GameInputMotionUnreliable := 1
    static GameInputMotionApproximate := 2
    static GameInputMotionAccurate := 3
}
struct GameInputArcadeStickButtons extends Int32 {
    static GameInputArcadeStickNone := 0
    static GameInputArcadeStickMenu := 1
    static GameInputArcadeStickView := 2
    static GameInputArcadeStickUp := 4
    static GameInputArcadeStickDown := 8
    static GameInputArcadeStickLeft := 16
    static GameInputArcadeStickRight := 32
    static GameInputArcadeStickAction1 := 64
    static GameInputArcadeStickAction2 := 128
    static GameInputArcadeStickAction3 := 256
    static GameInputArcadeStickAction4 := 512
    static GameInputArcadeStickAction5 := 1024
    static GameInputArcadeStickAction6 := 2048
    static GameInputArcadeStickSpecial1 := 4096
    static GameInputArcadeStickSpecial2 := 8192
}
struct GameInputFlightStickButtons extends Int32 {
    static GameInputFlightStickNone := 0
    static GameInputFlightStickMenu := 1
    static GameInputFlightStickView := 2
    static GameInputFlightStickFirePrimary := 4
    static GameInputFlightStickFireSecondary := 8
}
struct GameInputGamepadButtons extends Int32 {
    static GameInputGamepadNone := 0
    static GameInputGamepadMenu := 1
    static GameInputGamepadView := 2
    static GameInputGamepadA := 4
    static GameInputGamepadB := 8
    static GameInputGamepadX := 16
    static GameInputGamepadY := 32
    static GameInputGamepadDPadUp := 64
    static GameInputGamepadDPadDown := 128
    static GameInputGamepadDPadLeft := 256
    static GameInputGamepadDPadRight := 512
    static GameInputGamepadLeftShoulder := 1024
    static GameInputGamepadRightShoulder := 2048
    static GameInputGamepadLeftThumbstick := 4096
    static GameInputGamepadRightThumbstick := 8192
}
struct GameInputRacingWheelButtons extends Int32 {
    static GameInputRacingWheelNone := 0
    static GameInputRacingWheelMenu := 1
    static GameInputRacingWheelView := 2
    static GameInputRacingWheelPreviousGear := 4
    static GameInputRacingWheelNextGear := 8
    static GameInputRacingWheelDpadUp := 16
    static GameInputRacingWheelDpadDown := 32
    static GameInputRacingWheelDpadLeft := 64
    static GameInputRacingWheelDpadRight := 128
}
struct GameInputUiNavigationButtons extends Int32 {
    static GameInputUiNavigationNone := 0
    static GameInputUiNavigationMenu := 1
    static GameInputUiNavigationView := 2
    static GameInputUiNavigationAccept := 4
    static GameInputUiNavigationCancel := 8
    static GameInputUiNavigationUp := 16
    static GameInputUiNavigationDown := 32
    static GameInputUiNavigationLeft := 64
    static GameInputUiNavigationRight := 128
    static GameInputUiNavigationContext1 := 256
    static GameInputUiNavigationContext2 := 512
    static GameInputUiNavigationContext3 := 1024
    static GameInputUiNavigationContext4 := 2048
    static GameInputUiNavigationPageUp := 4096
    static GameInputUiNavigationPageDown := 8192
    static GameInputUiNavigationPageLeft := 16384
    static GameInputUiNavigationPageRight := 32768
    static GameInputUiNavigationScrollUp := 65536
    static GameInputUiNavigationScrollDown := 131072
    static GameInputUiNavigationScrollLeft := 262144
    static GameInputUiNavigationScrollRight := 524288
}
struct GameInputSystemButtons extends Int32 {
    static GameInputSystemButtonNone := 0
    static GameInputSystemButtonGuide := 1
    static GameInputSystemButtonShare := 2
}
struct GameInputDeviceStatus extends Int32 {
    static GameInputDeviceNoStatus := 0
    static GameInputDeviceConnected := 1
    static GameInputDeviceInputEnabled := 2
    static GameInputDeviceOutputEnabled := 4
    static GameInputDeviceRawIoEnabled := 8
    static GameInputDeviceAudioCapture := 16
    static GameInputDeviceAudioRender := 32
    static GameInputDeviceSynchronized := 64
    static GameInputDeviceWireless := 128
    static GameInputDeviceUserIdle := 1048576
    static GameInputDeviceAnyStatus := 16777215
}
struct GameInputBatteryStatus extends Int32 {
    static GameInputBatteryUnknown := -1
    static GameInputBatteryNotPresent := 0
    static GameInputBatteryDischarging := 1
    static GameInputBatteryIdle := 2
    static GameInputBatteryCharging := 3
}
struct GameInputDeviceFamily extends Int32 {
    static GameInputFamilyVirtual := -1
    static GameInputFamilyAggregate := 0
    static GameInputFamilyXboxOne := 1
    static GameInputFamilyXbox360 := 2
    static GameInputFamilyHid := 3
    static GameInputFamilyI8042 := 4
}
struct GameInputDeviceCapabilities extends Int32 {
    static GameInputDeviceCapabilityNone := 0
    static GameInputDeviceCapabilityAudio := 1
    static GameInputDeviceCapabilityPluginModule := 2
    static GameInputDeviceCapabilityPowerOff := 4
    static GameInputDeviceCapabilitySynchronization := 8
    static GameInputDeviceCapabilityWireless := 16
}
struct GameInputRawDeviceReportKind extends Int32 {
    static GameInputRawInputReport := 0
    static GameInputRawOutputReport := 1
    static GameInputRawFeatureReport := 2
}
struct GameInputRawDeviceReportItemFlags extends Int32 {
    static GameInputDefaultItem := 0
    static GameInputConstantItem := 1
    static GameInputArrayItem := 2
    static GameInputRelativeItem := 4
    static GameInputWraparoundItem := 8
    static GameInputNonlinearItem := 16
    static GameInputStableItem := 32
    static GameInputNullableItem := 64
    static GameInputVolatileItem := 128
    static GameInputBufferedItem := 256
}
struct GameInputRawDeviceItemCollectionKind extends Int32 {
    static GameInputUnknownItemCollection := -1
    static GameInputPhysicalItemCollection := 0
    static GameInputApplicationItemCollection := 1
    static GameInputLogicalItemCollection := 2
    static GameInputReportItemCollection := 3
    static GameInputNamedArrayItemCollection := 4
    static GameInputUsageSwitchItemCollection := 5
    static GameInputUsageModifierItemCollection := 6
}
struct GameInputRawDevicePhysicalUnitKind extends Int32 {
    static GameInputPhysicalUnitUnknown := -1
    static GameInputPhysicalUnitNone := 0
    static GameInputPhysicalUnitTime := 1
    static GameInputPhysicalUnitFrequency := 2
    static GameInputPhysicalUnitLength := 3
    static GameInputPhysicalUnitVelocity := 4
    static GameInputPhysicalUnitAcceleration := 5
    static GameInputPhysicalUnitMass := 6
    static GameInputPhysicalUnitMomentum := 7
    static GameInputPhysicalUnitForce := 8
    static GameInputPhysicalUnitPressure := 9
    static GameInputPhysicalUnitAngle := 10
    static GameInputPhysicalUnitAngularVelocity := 11
    static GameInputPhysicalUnitAngularAcceleration := 12
    static GameInputPhysicalUnitAngularMass := 13
    static GameInputPhysicalUnitAngularMomentum := 14
    static GameInputPhysicalUnitAngularTorque := 15
    static GameInputPhysicalUnitElectricCurrent := 16
    static GameInputPhysicalUnitElectricCharge := 17
    static GameInputPhysicalUnitElectricPotential := 18
    static GameInputPhysicalUnitEnergy := 19
    static GameInputPhysicalUnitPower := 20
    static GameInputPhysicalUnitTemperature := 21
    static GameInputPhysicalUnitLuminousIntensity := 22
    static GameInputPhysicalUnitLuminousFlux := 23
    static GameInputPhysicalUnitIlluminance := 24
}
struct GameInputLabel extends Int32 {
    static GameInputLabelUnknown := -1
    static GameInputLabelNone := 0
    static GameInputLabelXboxGuide := 1
    static GameInputLabelXboxBack := 2
    static GameInputLabelXboxStart := 3
    static GameInputLabelXboxMenu := 4
    static GameInputLabelXboxView := 5
    static GameInputLabelXboxA := 7
    static GameInputLabelXboxB := 8
    static GameInputLabelXboxX := 9
    static GameInputLabelXboxY := 10
    static GameInputLabelXboxDPadUp := 11
    static GameInputLabelXboxDPadDown := 12
    static GameInputLabelXboxDPadLeft := 13
    static GameInputLabelXboxDPadRight := 14
    static GameInputLabelXboxLeftShoulder := 15
    static GameInputLabelXboxLeftTrigger := 16
    static GameInputLabelXboxLeftStickButton := 17
    static GameInputLabelXboxRightShoulder := 18
    static GameInputLabelXboxRightTrigger := 19
    static GameInputLabelXboxRightStickButton := 20
    static GameInputLabelXboxPaddle1 := 21
    static GameInputLabelXboxPaddle2 := 22
    static GameInputLabelXboxPaddle3 := 23
    static GameInputLabelXboxPaddle4 := 24
    static GameInputLabelLetterA := 25
    static GameInputLabelLetterB := 26
    static GameInputLabelLetterC := 27
    static GameInputLabelLetterD := 28
    static GameInputLabelLetterE := 29
    static GameInputLabelLetterF := 30
    static GameInputLabelLetterG := 31
    static GameInputLabelLetterH := 32
    static GameInputLabelLetterI := 33
    static GameInputLabelLetterJ := 34
    static GameInputLabelLetterK := 35
    static GameInputLabelLetterL := 36
    static GameInputLabelLetterM := 37
    static GameInputLabelLetterN := 38
    static GameInputLabelLetterO := 39
    static GameInputLabelLetterP := 40
    static GameInputLabelLetterQ := 41
    static GameInputLabelLetterR := 42
    static GameInputLabelLetterS := 43
    static GameInputLabelLetterT := 44
    static GameInputLabelLetterU := 45
    static GameInputLabelLetterV := 46
    static GameInputLabelLetterW := 47
    static GameInputLabelLetterX := 48
    static GameInputLabelLetterY := 49
    static GameInputLabelLetterZ := 50
    static GameInputLabelNumber0 := 51
    static GameInputLabelNumber1 := 52
    static GameInputLabelNumber2 := 53
    static GameInputLabelNumber3 := 54
    static GameInputLabelNumber4 := 55
    static GameInputLabelNumber5 := 56
    static GameInputLabelNumber6 := 57
    static GameInputLabelNumber7 := 58
    static GameInputLabelNumber8 := 59
    static GameInputLabelNumber9 := 60
    static GameInputLabelArrowUp := 61
    static GameInputLabelArrowUpRight := 62
    static GameInputLabelArrowRight := 63
    static GameInputLabelArrowDownRight := 64
    static GameInputLabelArrowDown := 65
    static GameInputLabelArrowDownLLeft := 66
    static GameInputLabelArrowLeft := 67
    static GameInputLabelArrowUpLeft := 68
    static GameInputLabelArrowUpDown := 69
    static GameInputLabelArrowLeftRight := 70
    static GameInputLabelArrowUpDownLeftRight := 71
    static GameInputLabelArrowClockwise := 72
    static GameInputLabelArrowCounterClockwise := 73
    static GameInputLabelArrowReturn := 74
    static GameInputLabelIconBranding := 75
    static GameInputLabelIconHome := 76
    static GameInputLabelIconMenu := 77
    static GameInputLabelIconCross := 78
    static GameInputLabelIconCircle := 79
    static GameInputLabelIconSquare := 80
    static GameInputLabelIconTriangle := 81
    static GameInputLabelIconStar := 82
    static GameInputLabelIconDPadUp := 83
    static GameInputLabelIconDPadDown := 84
    static GameInputLabelIconDPadLeft := 85
    static GameInputLabelIconDPadRight := 86
    static GameInputLabelIconDialClockwise := 87
    static GameInputLabelIconDialCounterClockwise := 88
    static GameInputLabelIconSliderLeftRight := 89
    static GameInputLabelIconSliderUpDown := 90
    static GameInputLabelIconWheelUpDown := 91
    static GameInputLabelIconPlus := 92
    static GameInputLabelIconMinus := 93
    static GameInputLabelIconSuspension := 94
    static GameInputLabelHome := 95
    static GameInputLabelGuide := 96
    static GameInputLabelMode := 97
    static GameInputLabelSelect := 98
    static GameInputLabelMenu := 99
    static GameInputLabelView := 100
    static GameInputLabelBack := 101
    static GameInputLabelStart := 102
    static GameInputLabelOptions := 103
    static GameInputLabelShare := 104
    static GameInputLabelUp := 105
    static GameInputLabelDown := 106
    static GameInputLabelLeft := 107
    static GameInputLabelRight := 108
    static GameInputLabelLB := 109
    static GameInputLabelLT := 110
    static GameInputLabelLSB := 111
    static GameInputLabelL1 := 112
    static GameInputLabelL2 := 113
    static GameInputLabelL3 := 114
    static GameInputLabelRB := 115
    static GameInputLabelRT := 116
    static GameInputLabelRSB := 117
    static GameInputLabelR1 := 118
    static GameInputLabelR2 := 119
    static GameInputLabelR3 := 120
    static GameInputLabelP1 := 121
    static GameInputLabelP2 := 122
    static GameInputLabelP3 := 123
    static GameInputLabelP4 := 124
}
struct GameInputLocation extends Int32 {
    static GameInputLocationUnknown := -1
    static GameInputLocationChassis := 0
    static GameInputLocationDisplay := 1
    static GameInputLocationAxis := 2
    static GameInputLocationButton := 3
    static GameInputLocationSwitch := 4
    static GameInputLocationKey := 5
    static GameInputLocationTouchPad := 6
}
struct GameInputFeedbackAxes extends Int32 {
    static GameInputFeedbackAxisNone := 0
    static GameInputFeedbackAxisLinearX := 1
    static GameInputFeedbackAxisLinearY := 2
    static GameInputFeedbackAxisLinearZ := 4
    static GameInputFeedbackAxisAngularX := 8
    static GameInputFeedbackAxisAngularY := 16
    static GameInputFeedbackAxisAngularZ := 32
    static GameInputFeedbackAxisNormal := 64
}
struct GameInputFeedbackEffectState extends Int32 {
    static GameInputFeedbackStopped := 0
    static GameInputFeedbackRunning := 1
    static GameInputFeedbackPaused := 2
}
struct GameInputForceFeedbackEffectKind extends Int32 {
    static GameInputForceFeedbackConstant := 0
    static GameInputForceFeedbackRamp := 1
    static GameInputForceFeedbackSineWave := 2
    static GameInputForceFeedbackSquareWave := 3
    static GameInputForceFeedbackTriangleWave := 4
    static GameInputForceFeedbackSawtoothUpWave := 5
    static GameInputForceFeedbackSawtoothDownWave := 6
    static GameInputForceFeedbackSpring := 7
    static GameInputForceFeedbackFriction := 8
    static GameInputForceFeedbackDamper := 9
    static GameInputForceFeedbackInertia := 10
}
struct GameInputRumbleMotors extends Int32 {
    static GameInputRumbleNone := 0
    static GameInputRumbleLowFrequency := 1
    static GameInputRumbleHighFrequency := 2
    static GameInputRumbleLeftTrigger := 4
    static GameInputRumbleRightTrigger := 8
}
struct GameInputReadingCallback extends FunctionPointer {
    static Types := [Int64, Struct.Ptr, IGameInputReading, Boolean8, "Void"]
}
struct GameInputDeviceCallback extends FunctionPointer {
    static Types := [Int64, Struct.Ptr, IGameInputDevice, Int64, GameInputDeviceStatus, GameInputDeviceStatus, "Void"]
}
struct GameInputSystemButtonCallback extends FunctionPointer {
    static Types := [Int64, Struct.Ptr, IGameInputDevice, Int64, GameInputSystemButtons, GameInputSystemButtons, "Void"]
}
struct GameInputKeyboardLayoutCallback extends FunctionPointer {
    static Types := [Int64, Struct.Ptr, IGameInputDevice, Int64, UInt32, UInt32, "Void"]
}
struct GameInputKeyState {
    scanCode : UInt32
    codePoint : UInt32
    virtualKey : UInt8
    isDeadKey : UInt8
}
struct GameInputMouseState {
    buttons : GameInputMouseButtons
    positionX : Int64
    positionY : Int64
    wheelX : Int64
    wheelY : Int64
}
struct GameInputTouchState {
    touchId : Int64
    sensorIndex : UInt32
    positionX : Float32
    positionY : Float32
    pressure : Float32
    proximity : Float32
    contactRectTop : Float32
    contactRectLeft : Float32
    contactRectRight : Float32
    contactRectBottom : Float32
}
struct GameInputMotionState {
    accelerationX : Float32
    accelerationY : Float32
    accelerationZ : Float32
    angularVelocityX : Float32
    angularVelocityY : Float32
    angularVelocityZ : Float32
    magneticFieldX : Float32
    magneticFieldY : Float32
    magneticFieldZ : Float32
    orientationW : Float32
    orientationX : Float32
    orientationY : Float32
    orientationZ : Float32
    accelerometerAccuracy : GameInputMotionAccuracy
    gyroscopeAccuracy : GameInputMotionAccuracy
    magnetometerAccuracy : GameInputMotionAccuracy
    orientationAccuracy : GameInputMotionAccuracy
}
struct GameInputArcadeStickState {
    buttons : GameInputArcadeStickButtons
}
struct GameInputFlightStickState {
    buttons : GameInputFlightStickButtons
    hatSwitch : GameInputSwitchPosition
    roll : Float32
    pitch : Float32
    yaw : Float32
    throttle : Float32
}
struct GameInputGamepadState {
    buttons : GameInputGamepadButtons
    leftTrigger : Float32
    rightTrigger : Float32
    leftThumbstickX : Float32
    leftThumbstickY : Float32
    rightThumbstickX : Float32
    rightThumbstickY : Float32
}
struct GameInputRacingWheelState {
    buttons : GameInputRacingWheelButtons
    patternShifterGear : Int32
    wheel : Float32
    throttle : Float32
    brake : Float32
    clutch : Float32
    handbrake : Float32
}
struct GameInputUiNavigationState {
    buttons : GameInputUiNavigationButtons
}
struct GameInputBatteryState {
    chargeRate : Float32
    maxChargeRate : Float32
    remainingCapacity : Float32
    fullChargeCapacity : Float32
    status : GameInputBatteryStatus
}
struct GameInputString {
    sizeInBytes : UInt32
    codePointCount : UInt32
    data : PSTR
}
struct GameInputUsage {
    page : UInt16
    id : UInt16
}
struct GameInputVersion {
    major : UInt16
    minor : UInt16
    build : UInt16
    revision : UInt16
}
struct GameInputRawDeviceItemCollectionInfo {
    kind : GameInputRawDeviceItemCollectionKind
    childCount : UInt32
    siblingCount : UInt32
    usageCount : UInt32
    usages : GameInputUsage.Ptr
    parent : GameInputRawDeviceItemCollectionInfo.Ptr
    firstSibling : GameInputRawDeviceItemCollectionInfo.Ptr
    previousSibling : GameInputRawDeviceItemCollectionInfo.Ptr
    nextSibling : GameInputRawDeviceItemCollectionInfo.Ptr
    lastSibling : GameInputRawDeviceItemCollectionInfo.Ptr
    firstChild : GameInputRawDeviceItemCollectionInfo.Ptr
    lastChild : GameInputRawDeviceItemCollectionInfo.Ptr
}
struct GameInputRawDeviceReportItemInfo {
    bitOffset : UInt32
    bitSize : UInt32
    logicalMin : Int64
    logicalMax : Int64
    physicalMin : Float64
    physicalMax : Float64
    physicalUnits : GameInputRawDevicePhysicalUnitKind
    rawPhysicalUnits : UInt32
    rawPhysicalUnitsExponent : Int32
    flags : GameInputRawDeviceReportItemFlags
    usageCount : UInt32
    usages : GameInputUsage.Ptr
    collection : GameInputRawDeviceItemCollectionInfo.Ptr
    itemString : GameInputString.Ptr
}
struct GameInputRawDeviceReportInfo {
    kind : GameInputRawDeviceReportKind
    id : UInt32
    size : UInt32
    itemCount : UInt32
    items : GameInputRawDeviceReportItemInfo.Ptr
}
struct GameInputControllerAxisInfo {
    mappedInputKinds : GameInputKind
    label : GameInputLabel
    isContinuous : UInt8
    isNonlinear : UInt8
    isQuantized : UInt8
    hasRestValue : UInt8
    restValue : Float32
    resolution : Int64
    legacyDInputIndex : UInt16
    legacyHidIndex : UInt16
    rawReportIndex : UInt32
    inputReport : GameInputRawDeviceReportInfo.Ptr
    inputReportItem : GameInputRawDeviceReportItemInfo.Ptr
}
struct GameInputControllerButtonInfo {
    mappedInputKinds : GameInputKind
    label : GameInputLabel
    legacyDInputIndex : UInt16
    legacyHidIndex : UInt16
    rawReportIndex : UInt32
    inputReport : GameInputRawDeviceReportInfo.Ptr
    inputReportItem : GameInputRawDeviceReportItemInfo.Ptr
}
struct GameInputControllerSwitchInfo {
    mappedInputKinds : GameInputKind
    label : GameInputLabel
    positionLabels : GameInputLabel[9]
    kind : GameInputSwitchKind
    legacyDInputIndex : UInt16
    legacyHidIndex : UInt16
    rawReportIndex : UInt32
    inputReport : GameInputRawDeviceReportInfo.Ptr
    inputReportItem : GameInputRawDeviceReportItemInfo.Ptr
}
struct GameInputKeyboardInfo {
    kind : GameInputKeyboardKind
    layout : UInt32
    keyCount : UInt32
    functionKeyCount : UInt32
    maxSimultaneousKeys : UInt32
    platformType : UInt32
    platformSubtype : UInt32
    nativeLanguage : GameInputString.Ptr
}
struct GameInputMouseInfo {
    supportedButtons : GameInputMouseButtons
    sampleRate : UInt32
    sensorDpi : UInt32
    hasWheelX : UInt8
    hasWheelY : UInt8
}
struct GameInputTouchSensorInfo {
    mappedInputKinds : GameInputKind
    label : GameInputLabel
    location : GameInputLocation
    locationId : UInt32
    resolutionX : Int64
    resolutionY : Int64
    shape : GameInputTouchShape
    aspectRatio : Float32
    orientation : Float32
    physicalWidth : Float32
    physicalHeight : Float32
    maxPressure : Float32
    maxProximity : Float32
    maxTouchPoints : UInt32
}
struct GameInputMotionInfo {
    maxAcceleration : Float32
    maxAngularVelocity : Float32
    maxMagneticFieldStrength : Float32
}
struct GameInputArcadeStickInfo {
    menuButtonLabel : GameInputLabel
    viewButtonLabel : GameInputLabel
    stickUpLabel : GameInputLabel
    stickDownLabel : GameInputLabel
    stickLeftLabel : GameInputLabel
    stickRightLabel : GameInputLabel
    actionButton1Label : GameInputLabel
    actionButton2Label : GameInputLabel
    actionButton3Label : GameInputLabel
    actionButton4Label : GameInputLabel
    actionButton5Label : GameInputLabel
    actionButton6Label : GameInputLabel
    specialButton1Label : GameInputLabel
    specialButton2Label : GameInputLabel
}
struct GameInputFlightStickInfo {
    menuButtonLabel : GameInputLabel
    viewButtonLabel : GameInputLabel
    firePrimaryButtonLabel : GameInputLabel
    fireSecondaryButtonLabel : GameInputLabel
    hatSwitchKind : GameInputSwitchKind
}
struct GameInputGamepadInfo {
    menuButtonLabel : GameInputLabel
    viewButtonLabel : GameInputLabel
    aButtonLabel : GameInputLabel
    bButtonLabel : GameInputLabel
    xButtonLabel : GameInputLabel
    yButtonLabel : GameInputLabel
    dpadUpLabel : GameInputLabel
    dpadDownLabel : GameInputLabel
    dpadLeftLabel : GameInputLabel
    dpadRightLabel : GameInputLabel
    leftShoulderButtonLabel : GameInputLabel
    rightShoulderButtonLabel : GameInputLabel
    leftThumbstickButtonLabel : GameInputLabel
    rightThumbstickButtonLabel : GameInputLabel
}
struct GameInputRacingWheelInfo {
    menuButtonLabel : GameInputLabel
    viewButtonLabel : GameInputLabel
    previousGearButtonLabel : GameInputLabel
    nextGearButtonLabel : GameInputLabel
    dpadUpLabel : GameInputLabel
    dpadDownLabel : GameInputLabel
    dpadLeftLabel : GameInputLabel
    dpadRightLabel : GameInputLabel
    hasClutch : UInt8
    hasHandbrake : UInt8
    hasPatternShifter : UInt8
    minPatternShifterGear : Int32
    maxPatternShifterGear : Int32
    maxWheelAngle : Float32
}
struct GameInputUiNavigationInfo {
    menuButtonLabel : GameInputLabel
    viewButtonLabel : GameInputLabel
    acceptButtonLabel : GameInputLabel
    cancelButtonLabel : GameInputLabel
    upButtonLabel : GameInputLabel
    downButtonLabel : GameInputLabel
    leftButtonLabel : GameInputLabel
    rightButtonLabel : GameInputLabel
    contextButton1Label : GameInputLabel
    contextButton2Label : GameInputLabel
    contextButton3Label : GameInputLabel
    contextButton4Label : GameInputLabel
    pageUpButtonLabel : GameInputLabel
    pageDownButtonLabel : GameInputLabel
    pageLeftButtonLabel : GameInputLabel
    pageRightButtonLabel : GameInputLabel
    scrollUpButtonLabel : GameInputLabel
    scrollDownButtonLabel : GameInputLabel
    scrollLeftButtonLabel : GameInputLabel
    scrollRightButtonLabel : GameInputLabel
    guideButtonLabel : GameInputLabel
}
struct GameInputForceFeedbackMotorInfo {
    supportedAxes : GameInputFeedbackAxes
    location : GameInputLocation
    locationId : UInt32
    maxSimultaneousEffects : UInt32
    isConstantEffectSupported : UInt8
    isRampEffectSupported : UInt8
    isSineWaveEffectSupported : UInt8
    isSquareWaveEffectSupported : UInt8
    isTriangleWaveEffectSupported : UInt8
    isSawtoothUpWaveEffectSupported : UInt8
    isSawtoothDownWaveEffectSupported : UInt8
    isSpringEffectSupported : UInt8
    isFrictionEffectSupported : UInt8
    isDamperEffectSupported : UInt8
    isInertiaEffectSupported : UInt8
}
struct GameInputHapticWaveformInfo {
    usage : GameInputUsage
    isDurationSupported : UInt8
    isIntensitySupported : UInt8
    isRepeatSupported : UInt8
    isRepeatDelaySupported : UInt8
    defaultDuration : Int64
}
struct GameInputHapticFeedbackMotorInfo {
    mappedRumbleMotors : GameInputRumbleMotors
    location : GameInputLocation
    locationId : UInt32
    waveformCount : UInt32
    waveformInfo : GameInputHapticWaveformInfo.Ptr
}
struct GameInputDeviceInfo {
    infoSize : UInt32
    vendorId : UInt16
    productId : UInt16
    revisionNumber : UInt16
    interfaceNumber : UInt8
    collectionNumber : UInt8
    usage : GameInputUsage
    hardwareVersion : GameInputVersion
    firmwareVersion : GameInputVersion
    deviceId : APP_LOCAL_DEVICE_ID
    deviceRootId : APP_LOCAL_DEVICE_ID
    deviceFamily : GameInputDeviceFamily
    capabilities : GameInputDeviceCapabilities
    supportedInput : GameInputKind
    supportedRumbleMotors : GameInputRumbleMotors
    inputReportCount : UInt32
    outputReportCount : UInt32
    featureReportCount : UInt32
    controllerAxisCount : UInt32
    controllerButtonCount : UInt32
    controllerSwitchCount : UInt32
    touchPointCount : UInt32
    touchSensorCount : UInt32
    forceFeedbackMotorCount : UInt32
    hapticFeedbackMotorCount : UInt32
    deviceStringCount : UInt32
    deviceDescriptorSize : UInt32
    inputReportInfo : GameInputRawDeviceReportInfo.Ptr
    outputReportInfo : GameInputRawDeviceReportInfo.Ptr
    featureReportInfo : GameInputRawDeviceReportInfo.Ptr
    controllerAxisInfo : GameInputControllerAxisInfo.Ptr
    controllerButtonInfo : GameInputControllerButtonInfo.Ptr
    controllerSwitchInfo : GameInputControllerSwitchInfo.Ptr
    keyboardInfo : GameInputKeyboardInfo.Ptr
    mouseInfo : GameInputMouseInfo.Ptr
    touchSensorInfo : GameInputTouchSensorInfo.Ptr
    motionInfo : GameInputMotionInfo.Ptr
    arcadeStickInfo : GameInputArcadeStickInfo.Ptr
    flightStickInfo : GameInputFlightStickInfo.Ptr
    gamepadInfo : GameInputGamepadInfo.Ptr
    racingWheelInfo : GameInputRacingWheelInfo.Ptr
    uiNavigationInfo : GameInputUiNavigationInfo.Ptr
    forceFeedbackMotorInfo : GameInputForceFeedbackMotorInfo.Ptr
    hapticFeedbackMotorInfo : GameInputHapticFeedbackMotorInfo.Ptr
    displayName : GameInputString.Ptr
    deviceStrings : GameInputString.Ptr
    deviceDescriptorData : Struct.Ptr
    supportedSystemButtons : GameInputSystemButtons
}
struct GameInputForceFeedbackEnvelope {
    attackDuration : Int64
    sustainDuration : Int64
    releaseDuration : Int64
    attackGain : Float32
    sustainGain : Float32
    releaseGain : Float32
    playCount : UInt32
    repeatDelay : Int64
}
struct GameInputForceFeedbackMagnitude {
    linearX : Float32
    linearY : Float32
    linearZ : Float32
    angularX : Float32
    angularY : Float32
    angularZ : Float32
    normal : Float32
}
struct GameInputForceFeedbackConditionParams {
    magnitude : GameInputForceFeedbackMagnitude
    positiveCoefficient : Float32
    negativeCoefficient : Float32
    maxPositiveMagnitude : Float32
    maxNegativeMagnitude : Float32
    deadZone : Float32
    bias : Float32
}
struct GameInputForceFeedbackConstantParams {
    envelope : GameInputForceFeedbackEnvelope
    magnitude : GameInputForceFeedbackMagnitude
}
struct GameInputForceFeedbackPeriodicParams {
    envelope : GameInputForceFeedbackEnvelope
    magnitude : GameInputForceFeedbackMagnitude
    frequency : Float32
    phase : Float32
    bias : Float32
}
struct GameInputForceFeedbackRampParams {
    envelope : GameInputForceFeedbackEnvelope
    startMagnitude : GameInputForceFeedbackMagnitude
    endMagnitude : GameInputForceFeedbackMagnitude
}
struct GameInputForceFeedbackParams {
    kind : GameInputForceFeedbackEffectKind
    data : this._data_e__Union
    struct _data_e__Union {
        union {
            constant : GameInputForceFeedbackConstantParams
            ramp : GameInputForceFeedbackRampParams
            sineWave : GameInputForceFeedbackPeriodicParams
            squareWave : GameInputForceFeedbackPeriodicParams
            triangleWave : GameInputForceFeedbackPeriodicParams
            sawtoothUpWave : GameInputForceFeedbackPeriodicParams
            sawtoothDownWave : GameInputForceFeedbackPeriodicParams
            spring : GameInputForceFeedbackConditionParams
            friction : GameInputForceFeedbackConditionParams
            damper : GameInputForceFeedbackConditionParams
            inertia : GameInputForceFeedbackConditionParams
        }
    }
}
struct GameInputHapticFeedbackParams {
    waveformIndex : UInt32
    duration : Int64
    intensity : Float32
    playCount : UInt32
    repeatDelay : Int64
}
struct GameInputRumbleParams {
    lowFrequency : Float32
    highFrequency : Float32
    leftTrigger : Float32
    rightTrigger : Float32
}
struct IGameInput extends IUnknown {
    static IID := "{11BE2A7E-4254-445A-9C09-FFC40F006918}"
    GetCurrentTimestamp()
      => ComCall(3, this.p, Int64)
    GetCurrentReading(inputKind, device?, reading)
      => ComCall(4, this.p, GameInputKind, inputKind, IGameInputDevice, device?, IGameInputReading.Ptr, reading)
    GetNextReading(referenceReading, inputKind, device?, reading)
      => ComCall(5, this.p, IGameInputReading, referenceReading, GameInputKind, inputKind, IGameInputDevice, device?, IGameInputReading.Ptr, reading)
    GetPreviousReading(referenceReading, inputKind, device?, reading)
      => ComCall(6, this.p, IGameInputReading, referenceReading, GameInputKind, inputKind, IGameInputDevice, device?, IGameInputReading.Ptr, reading)
    GetTemporalReading(timestamp, device, reading)
      => ComCall(7, this.p, Int64, timestamp, IGameInputDevice, device, IGameInputReading.Ptr, reading)
    RegisterReadingCallback(device?, inputKind, analogThreshold, context?, callbackFunc, callbackToken?)
      => ComCall(8, this.p, IGameInputDevice, device?, GameInputKind, inputKind, Float32, analogThreshold, Struct.Ptr, context?, GameInputReadingCallback, callbackFunc, Int64.Ptr, callbackToken?)
    RegisterDeviceCallback(device?, inputKind, statusFilter, enumerationKind, context?, callbackFunc, callbackToken?)
      => ComCall(9, this.p, IGameInputDevice, device?, GameInputKind, inputKind, GameInputDeviceStatus, statusFilter, GameInputEnumerationKind, enumerationKind, Struct.Ptr, context?, GameInputDeviceCallback, callbackFunc, Int64.Ptr, callbackToken?)
    RegisterSystemButtonCallback(device?, buttonFilter, context?, callbackFunc, callbackToken?)
      => ComCall(10, this.p, IGameInputDevice, device?, GameInputSystemButtons, buttonFilter, Struct.Ptr, context?, GameInputSystemButtonCallback, callbackFunc, Int64.Ptr, callbackToken?)
    RegisterKeyboardLayoutCallback(device?, context?, callbackFunc, callbackToken?)
      => ComCall(11, this.p, IGameInputDevice, device?, Struct.Ptr, context?, GameInputKeyboardLayoutCallback, callbackFunc, Int64.Ptr, callbackToken?)
    StopCallback(callbackToken)
      => ComCall(12, this.p, Int64, callbackToken, "void")
    UnregisterCallback(callbackToken, timeoutInMicroseconds)
      => ComCall(13, this.p, Int64, callbackToken, Int64, timeoutInMicroseconds, Boolean8)
    CreateDispatcher(dispatcher)
      => ComCall(14, this.p, IGameInputDispatcher.Ptr, dispatcher)
    CreateAggregateDevice(inputKind, device)
      => ComCall(15, this.p, GameInputKind, inputKind, IGameInputDevice.Ptr, device)
    FindDeviceFromId(value, device)
      => ComCall(16, this.p, APP_LOCAL_DEVICE_ID.Ptr, value, IGameInputDevice.Ptr, device)
    FindDeviceFromObject(value, device)
      => ComCall(17, this.p, IUnknown, value, IGameInputDevice.Ptr, device)
    FindDeviceFromPlatformHandle(value, device)
      => ComCall(18, this.p, HANDLE, value, IGameInputDevice.Ptr, device)
    FindDeviceFromPlatformString(value, device)
      => ComCall(19, this.p, "Str", value, IGameInputDevice.Ptr, device)
    EnableOemDeviceSupport(vendorId, productId, interfaceNumber, collectionNumber)
      => ComCall(20, this.p, UInt16, vendorId, UInt16, productId, UInt8, interfaceNumber, UInt8, collectionNumber)
    SetFocusPolicy(policy)
      => ComCall(21, this.p, GameInputFocusPolicy, policy, "void")
}
struct IGameInputReading extends IUnknown {
    static IID := "{2156947A-E1FA-4DE0-A30B-D812931DBD8D}"
    GetInputKind()
      => ComCall(3, this.p, GameInputKind)
    GetSequenceNumber(inputKind)
      => ComCall(4, this.p, GameInputKind, inputKind, Int64)
    GetTimestamp()
      => ComCall(5, this.p, Int64)
    GetDevice(device)
      => ComCall(6, this.p, IGameInputDevice.Ptr, device, "void")
    GetRawReport(report)
      => ComCall(7, this.p, IGameInputRawDeviceReport.Ptr, report, Boolean8)
    GetControllerAxisCount()
      => ComCall(8, this.p, UInt32)
    GetControllerAxisState(stateArray)
      => ComCall(9, this.p, UInt32, stateArray.Length, Float32.Ptr, stateArray, UInt32)
    GetControllerButtonCount()
      => ComCall(10, this.p, UInt32)
    GetControllerButtonState(stateArray)
      => ComCall(11, this.p, UInt32, stateArray.Length, Boolean8.Ptr, stateArray, UInt32)
    GetControllerSwitchCount()
      => ComCall(12, this.p, UInt32)
    GetControllerSwitchState(stateArray)
      => ComCall(13, this.p, UInt32, stateArray.Length, GameInputSwitchPosition.Ptr, stateArray, UInt32)
    GetKeyCount()
      => ComCall(14, this.p, UInt32)
    GetKeyState(stateArray)
      => ComCall(15, this.p, UInt32, stateArray.Length, GameInputKeyState.Ptr, stateArray, UInt32)
    GetMouseState(state)
      => ComCall(16, this.p, GameInputMouseState.Ptr, state, Boolean8)
    GetTouchCount()
      => ComCall(17, this.p, UInt32)
    GetTouchState(stateArray)
      => ComCall(18, this.p, UInt32, stateArray.Length, GameInputTouchState.Ptr, stateArray, UInt32)
    GetMotionState(state)
      => ComCall(19, this.p, GameInputMotionState.Ptr, state, Boolean8)
    GetArcadeStickState(state)
      => ComCall(20, this.p, GameInputArcadeStickState.Ptr, state, Boolean8)
    GetFlightStickState(state)
      => ComCall(21, this.p, GameInputFlightStickState.Ptr, state, Boolean8)
    GetGamepadState(state)
      => ComCall(22, this.p, GameInputGamepadState.Ptr, state, Boolean8)
    GetRacingWheelState(state)
      => ComCall(23, this.p, GameInputRacingWheelState.Ptr, state, Boolean8)
    GetUiNavigationState(state)
      => ComCall(24, this.p, GameInputUiNavigationState.Ptr, state, Boolean8)
}
struct IGameInputDevice extends IUnknown {
    static IID := "{31DD86FB-4C1B-408A-868F-439B3CD47125}"
    GetDeviceInfo()
      => ComCall(3, this.p, GameInputDeviceInfo.Ptr)
    GetDeviceStatus()
      => ComCall(4, this.p, GameInputDeviceStatus)
    GetBatteryState(state)
      => ComCall(5, this.p, GameInputBatteryState.Ptr, state, "void")
    CreateForceFeedbackEffect(motorIndex, params, effect)
      => ComCall(6, this.p, UInt32, motorIndex, GameInputForceFeedbackParams.Ptr, params, IGameInputForceFeedbackEffect.Ptr, effect)
    IsForceFeedbackMotorPoweredOn(motorIndex)
      => ComCall(7, this.p, UInt32, motorIndex, Boolean8)
    SetForceFeedbackMotorGain(motorIndex, masterGain)
      => ComCall(8, this.p, UInt32, motorIndex, Float32, masterGain, "void")
    SetHapticMotorState(motorIndex, params?)
      => ComCall(9, this.p, UInt32, motorIndex, GameInputHapticFeedbackParams.Ptr, params?)
    SetRumbleState(params?)
      => ComCall(10, this.p, GameInputRumbleParams.Ptr, params?, "void")
    SetInputSynchronizationState(enabled)
      => ComCall(11, this.p, UInt8, enabled, "void")
    SendInputSynchronizationHint()
      => ComCall(12, this.p, "void")
    PowerOff()
      => ComCall(13, this.p, "void")
    CreateRawDeviceReport(reportId, reportKind, report)
      => ComCall(14, this.p, UInt32, reportId, GameInputRawDeviceReportKind, reportKind, IGameInputRawDeviceReport.Ptr, report)
    GetRawDeviceFeature(reportId, report)
      => ComCall(15, this.p, UInt32, reportId, IGameInputRawDeviceReport.Ptr, report)
    SetRawDeviceFeature(report)
      => ComCall(16, this.p, IGameInputRawDeviceReport, report)
    SendRawDeviceOutput(report)
      => ComCall(17, this.p, IGameInputRawDeviceReport, report)
    SendRawDeviceOutputWithResponse(requestReport, responseReport)
      => ComCall(18, this.p, IGameInputRawDeviceReport, requestReport, IGameInputRawDeviceReport.Ptr, responseReport)
    ExecuteRawDeviceIoControl(controlCode, inputBuffer?, outputBuffer?, outputSize?)
      => ComCall(19, this.p, UInt32, controlCode, IntPtr, inputBuffer?.Size ?? 0, Struct.Ptr, inputBuffer?, IntPtr, outputBuffer?.Size ?? 0, Struct.Ptr, outputBuffer?, IntPtr.Ptr, outputSize?)
    AcquireExclusiveRawDeviceAccess(timeoutInMicroseconds)
      => ComCall(20, this.p, Int64, timeoutInMicroseconds, Boolean8)
    ReleaseExclusiveRawDeviceAccess()
      => ComCall(21, this.p, "void")
}
struct IGameInputDispatcher extends IUnknown {
    static IID := "{415EED2E-98CB-42C2-8F28-B94601074E31}"
    Dispatch(quotaInMicroseconds)
      => ComCall(3, this.p, Int64, quotaInMicroseconds, Boolean8)
    OpenWaitHandle(waitHandle)
      => ComCall(4, this.p, HANDLE.Ptr, waitHandle)
}
struct IGameInputForceFeedbackEffect extends IUnknown {
    static IID := "{51BDA05E-F742-45D9-B085-9444AE48381D}"
    GetDevice(device)
      => ComCall(3, this.p, IGameInputDevice.Ptr, device, "void")
    GetMotorIndex()
      => ComCall(4, this.p, UInt32)
    GetGain()
      => ComCall(5, this.p, Float32)
    SetGain(gain)
      => ComCall(6, this.p, Float32, gain, "void")
    GetParams(params)
      => ComCall(7, this.p, GameInputForceFeedbackParams.Ptr, params, "void")
    SetParams(params)
      => ComCall(8, this.p, GameInputForceFeedbackParams.Ptr, params, Boolean8)
    GetState()
      => ComCall(9, this.p, GameInputFeedbackEffectState)
    SetState(state)
      => ComCall(10, this.p, GameInputFeedbackEffectState, state, "void")
}
struct IGameInputRawDeviceReport extends IUnknown {
    static IID := "{61F08CF1-1FFC-40CA-A2B8-E1AB8BC5B6DC}"
    GetDevice(device)
      => ComCall(3, this.p, IGameInputDevice.Ptr, device, "void")
    GetReportInfo()
      => ComCall(4, this.p, GameInputRawDeviceReportInfo.Ptr)
    GetRawDataSize()
      => ComCall(5, this.p, IntPtr)
    GetRawData(buffer)
      => ComCall(6, this.p, IntPtr, buffer.Length, Struct.Ptr, buffer, IntPtr)
    SetRawData(buffer)
      => ComCall(7, this.p, IntPtr, buffer.Length, Struct.Ptr, buffer, Boolean8)
    GetItemValue(itemIndex, value)
      => ComCall(8, this.p, UInt32, itemIndex, Int64.Ptr, value, Boolean8)
    SetItemValue(itemIndex, value)
      => ComCall(9, this.p, UInt32, itemIndex, Int64, value, Boolean8)
    ResetItemValue(itemIndex)
      => ComCall(10, this.p, UInt32, itemIndex, Boolean8)
    ResetAllItems()
      => ComCall(11, this.p, Boolean8)
}
