#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}

RtlDrainNonVolatileFlush(NvToken)
  => DllCall("ntdll.dll\RtlDrainNonVolatileFlush", Struct.Ptr, NvToken, UInt32)
RtlFillNonVolatileMemory(NvToken, NvDestination, Value, Flags)
  => DllCall("ntdll.dll\RtlFillNonVolatileMemory", Struct.Ptr, NvToken, Struct.Ptr, NvDestination, IntPtr, NvDestination.Size, UInt8, Value, UInt32, Flags, UInt32)
RtlFlushNonVolatileMemory(NvToken, NvBuffer, Flags)
  => DllCall("ntdll.dll\RtlFlushNonVolatileMemory", Struct.Ptr, NvToken, Struct.Ptr, NvBuffer, IntPtr, NvBuffer.Size, UInt32, Flags, UInt32)
RtlFlushNonVolatileMemoryRanges(NvToken, NvRanges, Flags)
  => DllCall("ntdll.dll\RtlFlushNonVolatileMemoryRanges", Struct.Ptr, NvToken, NV_MEMORY_RANGE.Ptr, NvRanges, IntPtr, NvRanges.Length, UInt32, Flags, UInt32)
RtlFreeNonVolatileToken(NvToken)
  => DllCall("ntdll.dll\RtlFreeNonVolatileToken", Struct.Ptr, NvToken, UInt32)
RtlGetNonVolatileToken(NvBuffer, NvToken)
  => DllCall("ntdll.dll\RtlGetNonVolatileToken", Struct.Ptr, NvBuffer, IntPtr, NvBuffer.Size, Struct.Ptr.Ptr, NvToken, UInt32)
RtlWriteNonVolatileMemory(NvToken, NvDestination, Source, Flags)
  => DllCall("ntdll.dll\RtlWriteNonVolatileMemory", Struct.Ptr, NvToken, Struct.Ptr, NvDestination, Struct.Ptr, Source, IntPtr, Source.Size, UInt32, Flags, UInt32)
