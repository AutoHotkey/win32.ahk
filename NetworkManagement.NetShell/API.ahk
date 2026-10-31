#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, PWSTR}

MatchEnumTag(hModule, pwcArg, dwNumArg, pEnumTable, pdwValue)
  => DllCall("NETSH.dll\MatchEnumTag", HANDLE, hModule, "Str", pwcArg, UInt32, dwNumArg, TOKEN_VALUE.Ptr, pEnumTable, UInt32.Ptr, pdwValue, UInt32)
MatchToken(pwszUserToken, pwszCmdToken)
  => DllCall("NETSH.dll\MatchToken", "Str", pwszUserToken, "Str", pwszCmdToken, BOOL)
PreprocessCommand(hModule?, ppwcArguments, dwCurrentIndex, pttTags?, dwMinArgs, dwMaxArgs, pdwTagType?)
  => DllCall("NETSH.dll\PreprocessCommand", HANDLE, hModule?, PWSTR.Ptr, ppwcArguments, UInt32, dwCurrentIndex, UInt32, ppwcArguments.Length, TAG_TYPE.Ptr, pttTags?, UInt32, pttTags?.Length ?? 0, UInt32, dwMinArgs, UInt32, dwMaxArgs, UInt32.Ptr, pdwTagType?, UInt32)
PrintError(hModule, dwErrId)
  => DllCall("NETSH.dll\PrintError", HANDLE, hModule, UInt32, dwErrId, UInt32)
PrintMessage(pwszFormat)
  => DllCall("NETSH.dll\PrintMessage", "Str", pwszFormat, UInt32)
PrintMessageFromModule(hModule, dwMsgId)
  => DllCall("NETSH.dll\PrintMessageFromModule", HANDLE, hModule, UInt32, dwMsgId, UInt32)
RegisterContext(pChildContext)
  => DllCall("NETSH.dll\RegisterContext", NS_CONTEXT_ATTRIBUTES.Ptr, pChildContext, UInt32)
RegisterHelper(pguidParentContext, pfnRegisterSubContext)
  => DllCall("NETSH.dll\RegisterHelper", GUID.Ptr, pguidParentContext, NS_HELPER_ATTRIBUTES.Ptr, pfnRegisterSubContext, UInt32)
