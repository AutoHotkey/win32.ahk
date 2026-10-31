#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, PWSTR}
#Import "..\Security\Types.ahk" {SECURITY_ATTRIBUTES}

AssignProcessToJobObject(hJob, hProcess)
  => DllCall("KERNEL32.dll\AssignProcessToJobObject", HANDLE, hJob, HANDLE, hProcess, BOOL)
CreateJobObject(lpJobAttributes?, lpName?)
  => DllCall("KERNEL32.dll\CreateJobObjectW", SECURITY_ATTRIBUTES.Ptr, lpJobAttributes?, "Str", lpName?, HANDLE)
FreeMemoryJobObject(Buffer)
  => DllCall("KERNEL32.dll\FreeMemoryJobObject", Struct.Ptr, Buffer, "void")
IsProcessInJob(ProcessHandle, JobHandle?, Result)
  => DllCall("KERNEL32.dll\IsProcessInJob", HANDLE, ProcessHandle, HANDLE, JobHandle?, BOOL.Ptr, Result, BOOL)
OpenJobObjectW(dwDesiredAccess, bInheritHandle, lpName)
  => DllCall("KERNEL32.dll\OpenJobObjectW", UInt32, dwDesiredAccess, BOOL, bInheritHandle, "Str", lpName, HANDLE)
QueryInformationJobObject(hJob?, JobObjectInformationClass, lpJobObjectInformation, lpReturnLength?)
  => DllCall("KERNEL32.dll\QueryInformationJobObject", HANDLE, hJob?, JOBOBJECTINFOCLASS, JobObjectInformationClass, Struct.Ptr, lpJobObjectInformation, UInt32, lpJobObjectInformation.Size, UInt32.Ptr, lpReturnLength?, BOOL)
QueryIoRateControlInformationJobObject(hJob?, VolumeName?, InfoBlocks, InfoBlockCount)
  => DllCall("KERNEL32.dll\QueryIoRateControlInformationJobObject", HANDLE, hJob?, "Str", VolumeName?, JOBOBJECT_IO_RATE_CONTROL_INFORMATION.Ptr.Ptr, InfoBlocks, UInt32.Ptr, InfoBlockCount, UInt32)
SetInformationJobObject(hJob, JobObjectInformationClass, lpJobObjectInformation)
  => DllCall("KERNEL32.dll\SetInformationJobObject", HANDLE, hJob, JOBOBJECTINFOCLASS, JobObjectInformationClass, Struct.Ptr, lpJobObjectInformation, UInt32, lpJobObjectInformation.Size, BOOL)
SetIoRateControlInformationJobObject(hJob, IoRateControlInfo)
  => DllCall("KERNEL32.dll\SetIoRateControlInformationJobObject", HANDLE, hJob, JOBOBJECT_IO_RATE_CONTROL_INFORMATION.Ptr, IoRateControlInfo, UInt32)
TerminateJobObject(hJob, uExitCode)
  => DllCall("KERNEL32.dll\TerminateJobObject", HANDLE, hJob, UInt32, uExitCode, BOOL)
UserHandleGrantAccess(hUserHandle, hJob, bGrant)
  => DllCall("USER32.dll\UserHandleGrantAccess", HANDLE, hUserHandle, HANDLE, hJob, BOOL, bGrant, BOOL)
