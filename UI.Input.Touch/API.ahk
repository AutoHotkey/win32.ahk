#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HWND}

CloseGestureInfoHandle(hGestureInfo1)
  => DllCall("USER32.dll\CloseGestureInfoHandle", HGESTUREINFO, hGestureInfo1, BOOL)
CloseTouchInputHandle(hTouchInput1)
  => DllCall("USER32.dll\CloseTouchInputHandle", HTOUCHINPUT, hTouchInput1, BOOL)
GetGestureConfig(hwnd1, dwReserved, dwFlags, pGestureConfig, cbSize)
  => DllCall("USER32.dll\GetGestureConfig", HWND, hwnd1, UInt32, dwReserved, UInt32, dwFlags, UInt32.Ptr, pGestureConfig.Length, GESTURECONFIG.Ptr, pGestureConfig, UInt32, cbSize, BOOL)
GetGestureExtraArgs(hGestureInfo1, pExtraArgs)
  => DllCall("USER32.dll\GetGestureExtraArgs", HGESTUREINFO, hGestureInfo1, UInt32, pExtraArgs.Size, UInt8.Ptr, pExtraArgs, BOOL)
GetGestureInfo(hGestureInfo1, pGestureInfo)
  => DllCall("USER32.dll\GetGestureInfo", HGESTUREINFO, hGestureInfo1, GESTUREINFO.Ptr, pGestureInfo, BOOL)
GetTouchInputInfo(hTouchInput1, pInputs, cbSize)
  => DllCall("USER32.dll\GetTouchInputInfo", HTOUCHINPUT, hTouchInput1, UInt32, pInputs.Length, TOUCHINPUT.Ptr, pInputs, Int32, cbSize, BOOL)
IsTouchWindow(hwnd1, pulFlags?)
  => DllCall("USER32.dll\IsTouchWindow", HWND, hwnd1, UInt32.Ptr, pulFlags?, BOOL)
RegisterTouchWindow(hwnd1, ulFlags)
  => DllCall("USER32.dll\RegisterTouchWindow", HWND, hwnd1, REGISTER_TOUCH_WINDOW_FLAGS, ulFlags, BOOL)
SetGestureConfig(hwnd1, dwReserved, pGestureConfig, cbSize)
  => DllCall("USER32.dll\SetGestureConfig", HWND, hwnd1, UInt32, dwReserved, UInt32, pGestureConfig.Length, GESTURECONFIG.Ptr, pGestureConfig, UInt32, cbSize, BOOL)
UnregisterTouchWindow(hwnd1)
  => DllCall("USER32.dll\UnregisterTouchWindow", HWND, hwnd1, BOOL)
