#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE}

CreateToolhelp32Snapshot(dwFlags, th32ProcessID)
  => DllCall("KERNEL32.dll\CreateToolhelp32Snapshot", CREATE_TOOLHELP_SNAPSHOT_FLAGS, dwFlags, UInt32, th32ProcessID, HANDLE)
Heap32First(lphe, th32ProcessID, th32HeapID)
  => DllCall("KERNEL32.dll\Heap32First", HEAPENTRY32.Ptr, lphe, UInt32, th32ProcessID, IntPtr, th32HeapID, BOOL)
Heap32ListFirst(hSnapshot, lphl)
  => DllCall("KERNEL32.dll\Heap32ListFirst", HANDLE, hSnapshot, HEAPLIST32.Ptr, lphl, BOOL)
Heap32ListNext(hSnapshot, lphl)
  => DllCall("KERNEL32.dll\Heap32ListNext", HANDLE, hSnapshot, HEAPLIST32.Ptr, lphl, BOOL)
Heap32Next(lphe)
  => DllCall("KERNEL32.dll\Heap32Next", HEAPENTRY32.Ptr, lphe, BOOL)
Process32First(hSnapshot, lppe)
  => DllCall("KERNEL32.dll\Process32FirstW", HANDLE, hSnapshot, PROCESSENTRY32W.Ptr, lppe, BOOL)
Process32NextW(hSnapshot, lppe)
  => DllCall("KERNEL32.dll\Process32NextW", HANDLE, hSnapshot, PROCESSENTRY32W.Ptr, lppe, BOOL)
Toolhelp32ReadProcessMemory(th32ProcessID, lpBaseAddress, lpBuffer, cbRead, lpNumberOfBytesRead)
  => DllCall("KERNEL32.dll\Toolhelp32ReadProcessMemory", UInt32, th32ProcessID, Struct.Ptr, lpBaseAddress, Struct.Ptr, lpBuffer, IntPtr, cbRead, IntPtr.Ptr, lpNumberOfBytesRead, BOOL)
