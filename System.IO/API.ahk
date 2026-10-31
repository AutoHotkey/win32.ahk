#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE}

BindIoCompletionCallback(FileHandle, Function, Flags)
  => DllCall("KERNEL32.dll\BindIoCompletionCallback", HANDLE, FileHandle, LPOVERLAPPED_COMPLETION_ROUTINE, Function, UInt32, Flags, BOOL)
CancelIo(hFile)
  => DllCall("KERNEL32.dll\CancelIo", HANDLE, hFile, BOOL)
CancelIoEx(hFile, lpOverlapped?)
  => DllCall("KERNEL32.dll\CancelIoEx", HANDLE, hFile, OVERLAPPED.Ptr, lpOverlapped?, BOOL)
CancelSynchronousIo(hThread)
  => DllCall("KERNEL32.dll\CancelSynchronousIo", HANDLE, hThread, BOOL)
CreateIoCompletionPort(FileHandle, ExistingCompletionPort?, CompletionKey, NumberOfConcurrentThreads)
  => DllCall("KERNEL32.dll\CreateIoCompletionPort", HANDLE, FileHandle, HANDLE, ExistingCompletionPort?, IntPtr, CompletionKey, UInt32, NumberOfConcurrentThreads, HANDLE)
DeviceIoControl(hDevice, dwIoControlCode, lpInBuffer?, lpOutBuffer?, lpBytesReturned?, lpOverlapped?)
  => DllCall("KERNEL32.dll\DeviceIoControl", HANDLE, hDevice, UInt32, dwIoControlCode, Struct.Ptr, lpInBuffer?, UInt32, lpInBuffer?.Size ?? 0, Struct.Ptr, lpOutBuffer?, UInt32, lpOutBuffer?.Size ?? 0, UInt32.Ptr, lpBytesReturned?, OVERLAPPED.Ptr, lpOverlapped?, BOOL)
GetOverlappedResult(hFile, lpOverlapped, lpNumberOfBytesTransferred, bWait)
  => DllCall("KERNEL32.dll\GetOverlappedResult", HANDLE, hFile, OVERLAPPED.Ptr, lpOverlapped, UInt32.Ptr, lpNumberOfBytesTransferred, BOOL, bWait, BOOL)
GetOverlappedResultEx(hFile, lpOverlapped, lpNumberOfBytesTransferred, dwMilliseconds, bAlertable)
  => DllCall("KERNEL32.dll\GetOverlappedResultEx", HANDLE, hFile, OVERLAPPED.Ptr, lpOverlapped, UInt32.Ptr, lpNumberOfBytesTransferred, UInt32, dwMilliseconds, BOOL, bAlertable, BOOL)
GetQueuedCompletionStatus(CompletionPort, lpNumberOfBytesTransferred, lpCompletionKey, lpOverlapped, dwMilliseconds)
  => DllCall("KERNEL32.dll\GetQueuedCompletionStatus", HANDLE, CompletionPort, UInt32.Ptr, lpNumberOfBytesTransferred, IntPtr.Ptr, lpCompletionKey, OVERLAPPED.Ptr.Ptr, lpOverlapped, UInt32, dwMilliseconds, BOOL)
GetQueuedCompletionStatusEx(CompletionPort, lpCompletionPortEntries, ulNumEntriesRemoved, dwMilliseconds, fAlertable)
  => DllCall("KERNEL32.dll\GetQueuedCompletionStatusEx", HANDLE, CompletionPort, OVERLAPPED_ENTRY.Ptr, lpCompletionPortEntries, UInt32, lpCompletionPortEntries.Length, UInt32.Ptr, ulNumEntriesRemoved, UInt32, dwMilliseconds, BOOL, fAlertable, BOOL)
PostQueuedCompletionStatus(CompletionPort, dwNumberOfBytesTransferred, dwCompletionKey, lpOverlapped?)
  => DllCall("KERNEL32.dll\PostQueuedCompletionStatus", HANDLE, CompletionPort, UInt32, dwNumberOfBytesTransferred, IntPtr, dwCompletionKey, OVERLAPPED.Ptr, lpOverlapped?, BOOL)
