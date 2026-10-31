#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, PWSTR}
#Import "..\Security\Types.ahk" {SECURITY_ATTRIBUTES}
#Import "..\Storage.FileSystem\Types.ahk" {FILE_FLAGS_AND_ATTRIBUTES}
#Import "..\System.IO\Types.ahk" {OVERLAPPED}

CallNamedPipeW(lpNamedPipeName, lpInBuffer?, lpOutBuffer?, lpBytesRead, nTimeOut)
  => DllCall("KERNEL32.dll\CallNamedPipeW", "Str", lpNamedPipeName, Struct.Ptr, lpInBuffer?, UInt32, lpInBuffer?.Size ?? 0, Struct.Ptr, lpOutBuffer?, UInt32, lpOutBuffer?.Size ?? 0, UInt32.Ptr, lpBytesRead, UInt32, nTimeOut, BOOL)
ConnectNamedPipe(hNamedPipe, lpOverlapped?)
  => DllCall("KERNEL32.dll\ConnectNamedPipe", HANDLE, hNamedPipe, OVERLAPPED.Ptr, lpOverlapped?, BOOL)
CreateNamedPipe(lpName, dwOpenMode, dwPipeMode, nMaxInstances, nOutBufferSize, nInBufferSize, nDefaultTimeOut, lpSecurityAttributes?)
  => DllCall("KERNEL32.dll\CreateNamedPipeW", "Str", lpName, FILE_FLAGS_AND_ATTRIBUTES, dwOpenMode, NAMED_PIPE_MODE, dwPipeMode, UInt32, nMaxInstances, UInt32, nOutBufferSize, UInt32, nInBufferSize, UInt32, nDefaultTimeOut, SECURITY_ATTRIBUTES.Ptr, lpSecurityAttributes?, HANDLE)
CreatePipe(hReadPipe, hWritePipe, lpPipeAttributes?, nSize)
  => DllCall("KERNEL32.dll\CreatePipe", HANDLE.Ptr, hReadPipe, HANDLE.Ptr, hWritePipe, SECURITY_ATTRIBUTES.Ptr, lpPipeAttributes?, UInt32, nSize, BOOL)
DisconnectNamedPipe(hNamedPipe)
  => DllCall("KERNEL32.dll\DisconnectNamedPipe", HANDLE, hNamedPipe, BOOL)
GetNamedPipeClientComputerNameW(Pipe, ClientComputerName)
  => DllCall("KERNEL32.dll\GetNamedPipeClientComputerNameW", HANDLE, Pipe, PWSTR, ClientComputerName, UInt32, ClientComputerName.Size, BOOL)
GetNamedPipeHandleStateW(hNamedPipe, lpState?, lpCurInstances?, lpMaxCollectionCount?, lpCollectDataTimeout?, lpUserName?)
  => DllCall("KERNEL32.dll\GetNamedPipeHandleStateW", HANDLE, hNamedPipe, NAMED_PIPE_MODE.Ptr, lpState?, UInt32.Ptr, lpCurInstances?, UInt32.Ptr, lpMaxCollectionCount?, UInt32.Ptr, lpCollectDataTimeout?, PWSTR, lpUserName?, UInt32, lpUserName?.Length ?? 0, BOOL)
GetNamedPipeInfo(hNamedPipe, lpFlags?, lpOutBufferSize?, lpInBufferSize?, lpMaxInstances?)
  => DllCall("KERNEL32.dll\GetNamedPipeInfo", HANDLE, hNamedPipe, NAMED_PIPE_MODE.Ptr, lpFlags?, UInt32.Ptr, lpOutBufferSize?, UInt32.Ptr, lpInBufferSize?, UInt32.Ptr, lpMaxInstances?, BOOL)
ImpersonateNamedPipeClient(hNamedPipe)
  => DllCall("ADVAPI32.dll\ImpersonateNamedPipeClient", HANDLE, hNamedPipe, BOOL)
PeekNamedPipe(hNamedPipe, lpBuffer?, lpBytesRead?, lpTotalBytesAvail?, lpBytesLeftThisMessage?)
  => DllCall("KERNEL32.dll\PeekNamedPipe", HANDLE, hNamedPipe, Struct.Ptr, lpBuffer?, UInt32, lpBuffer?.Size ?? 0, UInt32.Ptr, lpBytesRead?, UInt32.Ptr, lpTotalBytesAvail?, UInt32.Ptr, lpBytesLeftThisMessage?, BOOL)
SetNamedPipeHandleState(hNamedPipe, lpMode?, lpMaxCollectionCount?, lpCollectDataTimeout?)
  => DllCall("KERNEL32.dll\SetNamedPipeHandleState", HANDLE, hNamedPipe, NAMED_PIPE_MODE.Ptr, lpMode?, UInt32.Ptr, lpMaxCollectionCount?, UInt32.Ptr, lpCollectDataTimeout?, BOOL)
TransactNamedPipe(hNamedPipe, lpInBuffer?, lpOutBuffer?, lpBytesRead, lpOverlapped?)
  => DllCall("KERNEL32.dll\TransactNamedPipe", HANDLE, hNamedPipe, Struct.Ptr, lpInBuffer?, UInt32, lpInBuffer?.Size ?? 0, Struct.Ptr, lpOutBuffer?, UInt32, lpOutBuffer?.Size ?? 0, UInt32.Ptr, lpBytesRead, OVERLAPPED.Ptr, lpOverlapped?, BOOL)
WaitNamedPipeW(lpNamedPipeName, nTimeOut)
  => DllCall("KERNEL32.dll\WaitNamedPipeW", "Str", lpNamedPipeName, UInt32, nTimeOut, BOOL)
