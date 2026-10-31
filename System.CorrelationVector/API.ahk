#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}

RtlExtendCorrelationVector(CorrelationVector)
  => DllCall("ntdll.dll\RtlExtendCorrelationVector", CORRELATION_VECTOR.Ptr, CorrelationVector, UInt32)
RtlIncrementCorrelationVector(CorrelationVector)
  => DllCall("ntdll.dll\RtlIncrementCorrelationVector", CORRELATION_VECTOR.Ptr, CorrelationVector, UInt32)
RtlInitializeCorrelationVector(CorrelationVector, Version, Guid?)
  => DllCall("ntdll.dll\RtlInitializeCorrelationVector", CORRELATION_VECTOR.Ptr, CorrelationVector, Int32, Version, GUID.Ptr, Guid?, UInt32)
RtlValidateCorrelationVector(Vector)
  => DllCall("ntdll.dll\RtlValidateCorrelationVector", CORRELATION_VECTOR.Ptr, Vector, UInt32)
