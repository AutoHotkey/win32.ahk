#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {PWSTR}

SearchPath(lpPath?, lpFileName, lpExtension?, lpBuffer?, lpFilePart?)
  => DllCall("KERNEL32.dll\SearchPathW", "Str", lpPath?, "Str", lpFileName, "Str", lpExtension?, UInt32, lpBuffer?.Length ?? 0, PWSTR, lpBuffer?, PWSTR.Ptr, lpFilePart?, UInt32)
