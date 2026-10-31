#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, PWSTR}

SetupGetInfDriverStoreLocation(FileName, AlternatePlatformInfo?, LocaleName?, ReturnBuffer, RequiredSize?)
  => DllCall("SETUPAPI.dll\SetupGetInfDriverStoreLocationW", "Str", FileName, SP_ALTPLATFORM_INFO_V2.Ptr, AlternatePlatformInfo?, "Str", LocaleName?, PWSTR, ReturnBuffer, UInt32, ReturnBuffer.Length, UInt32.Ptr, RequiredSize?, BOOL)
SetupGetInfFileList(DirectoryPath?, InfStyle, ReturnBuffer, RequiredSize?)
  => DllCall("SETUPAPI.dll\SetupGetInfFileListW", "Str", DirectoryPath?, INF_STYLE, InfStyle, PWSTR, ReturnBuffer, UInt32, ReturnBuffer.Length, UInt32.Ptr, RequiredSize?, BOOL)
SetupGetInfInformation(InfSpec, SearchControl, ReturnBuffer?, RequiredSize?)
  => DllCall("SETUPAPI.dll\SetupGetInfInformationW", Struct.Ptr, InfSpec, UInt32, SearchControl, SP_INF_INFORMATION.Ptr, ReturnBuffer?, UInt32, ReturnBuffer?.Size ?? 0, UInt32.Ptr, RequiredSize?, BOOL)
SetupGetInfPublishedName(DriverStoreLocation, ReturnBuffer, RequiredSize?)
  => DllCall("SETUPAPI.dll\SetupGetInfPublishedNameW", "Str", DriverStoreLocation, PWSTR, ReturnBuffer, UInt32, ReturnBuffer.Length, UInt32.Ptr, RequiredSize?, BOOL)
SetupOpenInfFile(FileName, InfClass?, InfStyle, ErrorLine?)
  => DllCall("SETUPAPI.dll\SetupOpenInfFileW", "Str", FileName, "Str", InfClass?, INF_STYLE, InfStyle, UInt32.Ptr, ErrorLine?, Struct.Ptr)
SetupQueryInfFileInformation(InfInformation, InfIndex, ReturnBuffer?, RequiredSize?)
  => DllCall("SETUPAPI.dll\SetupQueryInfFileInformationW", SP_INF_INFORMATION.Ptr, InfInformation, UInt32, InfIndex, PWSTR, ReturnBuffer?, UInt32, ReturnBuffer?.Length ?? 0, UInt32.Ptr, RequiredSize?, BOOL)
SetupQueryInfOriginalFileInformation(InfInformation, InfIndex, AlternatePlatformInfo?, OriginalFileInfo)
  => DllCall("SETUPAPI.dll\SetupQueryInfOriginalFileInformationW", SP_INF_INFORMATION.Ptr, InfInformation, UInt32, InfIndex, SP_ALTPLATFORM_INFO_V2.Ptr, AlternatePlatformInfo?, SP_ORIGINAL_FILE_INFO_W.Ptr, OriginalFileInfo, BOOL)
SetupQueryInfVersionInformation(InfInformation, InfIndex, Key?, ReturnBuffer?, RequiredSize?)
  => DllCall("SETUPAPI.dll\SetupQueryInfVersionInformationW", SP_INF_INFORMATION.Ptr, InfInformation, UInt32, InfIndex, "Str", Key?, PWSTR, ReturnBuffer?, UInt32, ReturnBuffer?.Length ?? 0, UInt32.Ptr, RequiredSize?, BOOL)
