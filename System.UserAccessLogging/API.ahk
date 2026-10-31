#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}

UalInstrument(Data)
  => DllCall("ualapi.dll\UalInstrument", UAL_DATA_BLOB.Ptr, Data, "HRESULT")
UalRegisterProduct(wszProductName, wszRoleName, wszGuid)
  => DllCall("ualapi.dll\UalRegisterProduct", "Str", wszProductName, "Str", wszRoleName, "Str", wszGuid, "HRESULT")
UalStart(Data)
  => DllCall("ualapi.dll\UalStart", UAL_DATA_BLOB.Ptr, Data, "HRESULT")
UalStop(Data)
  => DllCall("ualapi.dll\UalStop", UAL_DATA_BLOB.Ptr, Data, "HRESULT")
