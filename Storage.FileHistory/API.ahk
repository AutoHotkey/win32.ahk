#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT}

FhServiceBlockBackup(Pipe)
  => DllCall("fhsvcctl.dll\FhServiceBlockBackup", FH_SERVICE_PIPE_HANDLE, Pipe, "HRESULT")
FhServiceClosePipe(Pipe)
  => DllCall("fhsvcctl.dll\FhServiceClosePipe", FH_SERVICE_PIPE_HANDLE, Pipe, "HRESULT")
FhServiceOpenPipe(StartServiceIfStopped, Pipe)
  => DllCall("fhsvcctl.dll\FhServiceOpenPipe", BOOL, StartServiceIfStopped, FH_SERVICE_PIPE_HANDLE.Ptr, Pipe, "HRESULT")
FhServiceReloadConfiguration(Pipe)
  => DllCall("fhsvcctl.dll\FhServiceReloadConfiguration", FH_SERVICE_PIPE_HANDLE, Pipe, "HRESULT")
FhServiceStartBackup(Pipe, LowPriorityIo)
  => DllCall("fhsvcctl.dll\FhServiceStartBackup", FH_SERVICE_PIPE_HANDLE, Pipe, BOOL, LowPriorityIo, "HRESULT")
FhServiceStopBackup(Pipe, StopTracking)
  => DllCall("fhsvcctl.dll\FhServiceStopBackup", FH_SERVICE_PIPE_HANDLE, Pipe, BOOL, StopTracking, "HRESULT")
FhServiceUnblockBackup(Pipe)
  => DllCall("fhsvcctl.dll\FhServiceUnblockBackup", FH_SERVICE_PIPE_HANDLE, Pipe, "HRESULT")
