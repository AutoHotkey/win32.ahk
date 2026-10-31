#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL}

OperationEnd(OperationEndParams)
  => DllCall("ADVAPI32.dll\OperationEnd", OPERATION_END_PARAMETERS.Ptr, OperationEndParams, BOOL)
OperationStart(OperationStartParams)
  => DllCall("ADVAPI32.dll\OperationStart", OPERATION_START_PARAMETERS.Ptr, OperationStartParams, BOOL)
