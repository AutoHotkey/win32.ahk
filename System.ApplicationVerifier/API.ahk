#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HANDLE}

VerifierEnumerateResource(Process, Flags, ResourceType, ResourceCallback, EnumerationContext)
  => DllCall("verifier.dll\VerifierEnumerateResource", HANDLE, Process, VERIFIER_ENUM_RESOURCE_FLAGS, Flags, UInt32, ResourceType, AVRF_RESOURCE_ENUMERATE_CALLBACK, ResourceCallback, Struct.Ptr, EnumerationContext, UInt32)
