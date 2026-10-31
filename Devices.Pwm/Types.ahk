#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN}

struct PWM_CONTROLLER_INFO {
    Size : IntPtr
    PinCount : UInt32
    MinimumPeriod : Int64
    MaximumPeriod : Int64
}
struct PWM_CONTROLLER_GET_ACTUAL_PERIOD_OUTPUT {
    ActualPeriod : Int64
}
struct PWM_CONTROLLER_SET_DESIRED_PERIOD_INPUT {
    DesiredPeriod : Int64
}
struct PWM_CONTROLLER_SET_DESIRED_PERIOD_OUTPUT {
    ActualPeriod : Int64
}
struct PWM_PIN_GET_ACTIVE_DUTY_CYCLE_PERCENTAGE_OUTPUT {
    Percentage : Int64
}
struct PWM_PIN_SET_ACTIVE_DUTY_CYCLE_PERCENTAGE_INPUT {
    Percentage : Int64
}
struct PWM_POLARITY extends Int32 {
    static PWM_ACTIVE_HIGH := 0
    static PWM_ACTIVE_LOW := 1
}
struct PWM_PIN_GET_POLARITY_OUTPUT {
    Polarity : PWM_POLARITY
}
struct PWM_PIN_SET_POLARITY_INPUT {
    Polarity : PWM_POLARITY
}
struct PWM_PIN_IS_STARTED_OUTPUT {
    IsStarted : BOOLEAN
}
