#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOLEAN, HANDLE}

DisableThreadProfiling(PerformanceDataHandle)
  => DllCall("KERNEL32.dll\DisableThreadProfiling", HANDLE, PerformanceDataHandle, UInt32)
EnableThreadProfiling(ThreadHandle, Flags, HardwareCounters, PerformanceDataHandle)
  => DllCall("KERNEL32.dll\EnableThreadProfiling", HANDLE, ThreadHandle, UInt32, Flags, Int64, HardwareCounters, HANDLE.Ptr, PerformanceDataHandle, UInt32)
QueryThreadProfiling(ThreadHandle, Enabled)
  => DllCall("KERNEL32.dll\QueryThreadProfiling", HANDLE, ThreadHandle, BOOLEAN.Ptr, Enabled, UInt32)
ReadThreadProfilingData(PerformanceDataHandle, Flags, PerformanceData)
  => DllCall("KERNEL32.dll\ReadThreadProfilingData", HANDLE, PerformanceDataHandle, UInt32, Flags, PERFORMANCE_DATA.Ptr, PerformanceData, UInt32)
