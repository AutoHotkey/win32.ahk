#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {PWSTR, WIN32_ERROR}

StartTrace(TraceId, InstanceName, Properties)
  => DllCall("ADVAPI32.dll\StartTraceW", Int64.Ptr, TraceId, "Str", InstanceName, EVENT_TRACE_PROPERTIES.Ptr, Properties, WIN32_ERROR)
