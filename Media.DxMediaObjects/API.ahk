#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}

DMOEnum(guidCategory, dwFlags, cInTypes, pInTypes, cOutTypes, pOutTypes, ppEnum)
  => DllCall("msdmo.dll\DMOEnum", GUID.Ptr, guidCategory, UInt32, dwFlags, UInt32, cInTypes, DMO_PARTIAL_MEDIATYPE.Ptr, pInTypes, UInt32, cOutTypes, DMO_PARTIAL_MEDIATYPE.Ptr, pOutTypes, IEnumDMO.Ptr, ppEnum, "HRESULT")
DMOGetName(clsidDMO, szName)
  => DllCall("msdmo.dll\DMOGetName", GUID.Ptr, clsidDMO, PWSTR, szName, "HRESULT")
DMOGetTypes(clsidDMO, ulInputTypesRequested, pulInputTypesSupplied, pInputTypes, ulOutputTypesRequested, pulOutputTypesSupplied, pOutputTypes)
  => DllCall("msdmo.dll\DMOGetTypes", GUID.Ptr, clsidDMO, UInt32, ulInputTypesRequested, UInt32.Ptr, pulInputTypesSupplied, DMO_PARTIAL_MEDIATYPE.Ptr, pInputTypes, UInt32, ulOutputTypesRequested, UInt32.Ptr, pulOutputTypesSupplied, DMO_PARTIAL_MEDIATYPE.Ptr, pOutputTypes, "HRESULT")
DMORegister(szName, clsidDMO, guidCategory, dwFlags, cInTypes, pInTypes, cOutTypes, pOutTypes)
  => DllCall("msdmo.dll\DMORegister", "Str", szName, GUID.Ptr, clsidDMO, GUID.Ptr, guidCategory, UInt32, dwFlags, UInt32, cInTypes, DMO_PARTIAL_MEDIATYPE.Ptr, pInTypes, UInt32, cOutTypes, DMO_PARTIAL_MEDIATYPE.Ptr, pOutTypes, "HRESULT")
DMOUnregister(clsidDMO, guidCategory)
  => DllCall("msdmo.dll\DMOUnregister", GUID.Ptr, clsidDMO, GUID.Ptr, guidCategory, "HRESULT")
MoCopyMediaType(pmtDest, pmtSrc)
  => DllCall("msdmo.dll\MoCopyMediaType", DMO_MEDIA_TYPE.Ptr, pmtDest, DMO_MEDIA_TYPE.Ptr, pmtSrc, "HRESULT")
MoCreateMediaType(ppmt, cbFormat)
  => DllCall("msdmo.dll\MoCreateMediaType", DMO_MEDIA_TYPE.Ptr.Ptr, ppmt, UInt32, cbFormat, "HRESULT")
MoDeleteMediaType(pmt)
  => DllCall("msdmo.dll\MoDeleteMediaType", DMO_MEDIA_TYPE.Ptr, pmt, "HRESULT")
MoDuplicateMediaType(ppmtDest, pmtSrc)
  => DllCall("msdmo.dll\MoDuplicateMediaType", DMO_MEDIA_TYPE.Ptr.Ptr, ppmtDest, DMO_MEDIA_TYPE.Ptr, pmtSrc, "HRESULT")
MoFreeMediaType(pmt)
  => DllCall("msdmo.dll\MoFreeMediaType", DMO_MEDIA_TYPE.Ptr, pmt, "HRESULT")
MoInitMediaType(pmt, cbFormat)
  => DllCall("msdmo.dll\MoInitMediaType", DMO_MEDIA_TYPE.Ptr, pmt, UInt32, cbFormat, "HRESULT")
