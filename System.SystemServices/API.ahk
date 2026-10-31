#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {PWSTR}

RtlGetImageFileMachines(DosFileName, MachineTypeFlags)
  => DllCall("ntdll.dll\RtlGetImageFileMachines", "Str", DosFileName, IMAGE_FILE_MACHINES.Ptr, MachineTypeFlags, UInt32)
