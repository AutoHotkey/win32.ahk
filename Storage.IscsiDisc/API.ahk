#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {PWSTR}

GetIScsiTargetInformation(TargetName, DiscoveryMechanism?, InfoClass, BufferSize, Buffer)
  => DllCall("ISCSIDSC.dll\GetIScsiTargetInformationW", "Str", TargetName, "Str", DiscoveryMechanism?, TARGET_INFORMATION_CLASS, InfoClass, UInt32.Ptr, BufferSize, Struct.Ptr, Buffer, UInt32)
GetIScsiVersionInformation(VersionInfo)
  => DllCall("ISCSIDSC.dll\GetIScsiVersionInformation", ISCSI_VERSION_INFO.Ptr, VersionInfo, UInt32)
