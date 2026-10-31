#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, PWSTR}

XInputEnable(enable)
  => DllCall("xinput1_4.dll\XInputEnable", BOOL, enable, "void")
XInputGetAudioDeviceIds(dwUserIndex, pRenderDeviceId?, pCaptureDeviceId?)
  => DllCall("xinput1_4.dll\XInputGetAudioDeviceIds", UInt32, dwUserIndex, PWSTR, pRenderDeviceId?, UInt32.Ptr, pRenderDeviceId?.Length ?? 0, PWSTR, pCaptureDeviceId?, UInt32.Ptr, pCaptureDeviceId?.Length ?? 0, UInt32)
XInputGetBatteryInformation(dwUserIndex, devType, pBatteryInformation)
  => DllCall("xinput1_4.dll\XInputGetBatteryInformation", UInt32, dwUserIndex, BATTERY_DEVTYPE, devType, XINPUT_BATTERY_INFORMATION.Ptr, pBatteryInformation, UInt32)
XInputGetCapabilities(dwUserIndex, dwFlags, pCapabilities)
  => DllCall("xinput1_4.dll\XInputGetCapabilities", UInt32, dwUserIndex, XINPUT_FLAG, dwFlags, XINPUT_CAPABILITIES.Ptr, pCapabilities, UInt32)
XInputGetKeystroke(dwUserIndex, pKeystroke)
  => DllCall("xinput1_4.dll\XInputGetKeystroke", UInt32, dwUserIndex, "Ptr", 0, XINPUT_KEYSTROKE.Ptr, pKeystroke, UInt32)
XInputGetState(dwUserIndex, pState)
  => DllCall("xinput1_4.dll\XInputGetState", UInt32, dwUserIndex, XINPUT_STATE.Ptr, pState, UInt32)
XInputSetState(dwUserIndex, pVibration)
  => DllCall("xinput1_4.dll\XInputSetState", UInt32, dwUserIndex, XINPUT_VIBRATION.Ptr, pVibration, UInt32)
