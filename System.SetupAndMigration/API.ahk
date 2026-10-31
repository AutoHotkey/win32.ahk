#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL}

OOBEComplete(isOOBEComplete)
  => DllCall("KERNEL32.dll\OOBEComplete", BOOL.Ptr, isOOBEComplete, BOOL)
RegisterWaitUntilOOBECompleted(OOBECompletedCallback, CallbackContext?, WaitHandle)
  => DllCall("KERNEL32.dll\RegisterWaitUntilOOBECompleted", OOBE_COMPLETED_CALLBACK, OOBECompletedCallback, Struct.Ptr, CallbackContext?, Struct.Ptr.Ptr, WaitHandle, BOOL)
UnregisterWaitUntilOOBECompleted(WaitHandle)
  => DllCall("KERNEL32.dll\UnregisterWaitUntilOOBECompleted", Struct.Ptr, WaitHandle, BOOL)
