#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, LRESULT}

DefRawInputProc(paRawInput, cbSizeHeader)
  => DllCall("USER32.dll\DefRawInputProc", RAWINPUT.Ptr.Ptr, paRawInput, Int32, paRawInput.Length, UInt32, cbSizeHeader, LRESULT)
GetCIMSSM(inputMessageSource)
  => DllCall("USER32.dll\GetCIMSSM", INPUT_MESSAGE_SOURCE.Ptr, inputMessageSource, BOOL)
GetCurrentInputMessageSource(inputMessageSource)
  => DllCall("USER32.dll\GetCurrentInputMessageSource", INPUT_MESSAGE_SOURCE.Ptr, inputMessageSource, BOOL)
GetRawInputBuffer(pData?, pcbSize, cbSizeHeader)
  => DllCall("USER32.dll\GetRawInputBuffer", RAWINPUT.Ptr, pData?, UInt32.Ptr, pcbSize, UInt32, cbSizeHeader, UInt32)
GetRawInputData(hRawInput1, uiCommand, pData?, pcbSize, cbSizeHeader)
  => DllCall("USER32.dll\GetRawInputData", HRAWINPUT, hRawInput1, RAW_INPUT_DATA_COMMAND_FLAGS, uiCommand, Struct.Ptr, pData?, UInt32.Ptr, pcbSize, UInt32, cbSizeHeader, UInt32)
GetRawInputDeviceInfo(hDevice?, uiCommand, pData?, pcbSize)
  => DllCall("USER32.dll\GetRawInputDeviceInfoW", HANDLE, hDevice?, RAW_INPUT_DEVICE_INFO_COMMAND, uiCommand, Struct.Ptr, pData?, UInt32.Ptr, pcbSize, UInt32)
GetRawInputDeviceList(pRawInputDeviceList?, cbSize)
  => DllCall("USER32.dll\GetRawInputDeviceList", RAWINPUTDEVICELIST.Ptr, pRawInputDeviceList?, UInt32.Ptr, pRawInputDeviceList?.Length ?? 0, UInt32, cbSize, UInt32)
GetRegisteredRawInputDevices(pRawInputDevices?, cbSize)
  => DllCall("USER32.dll\GetRegisteredRawInputDevices", RAWINPUTDEVICE.Ptr, pRawInputDevices?, UInt32.Ptr, pRawInputDevices?.Length ?? 0, UInt32, cbSize, UInt32)
RegisterRawInputDevices(pRawInputDevices, cbSize)
  => DllCall("USER32.dll\RegisterRawInputDevices", RAWINPUTDEVICE.Ptr, pRawInputDevices, UInt32, pRawInputDevices.Length, UInt32, cbSize, BOOL)
