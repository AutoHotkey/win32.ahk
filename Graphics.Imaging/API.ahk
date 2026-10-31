#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HANDLE, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IStream}

WICConvertBitmapSource(dstFormat, pISrc, ppIDst)
  => DllCall("WindowsCodecs.dll\WICConvertBitmapSource", GUID.Ptr, dstFormat, IWICBitmapSource, pISrc, IWICBitmapSource.Ptr, ppIDst, "HRESULT")
WICCreateBitmapFromSection(width, height, pixelFormat, hSection, stride, offset, ppIBitmap)
  => DllCall("WindowsCodecs.dll\WICCreateBitmapFromSection", UInt32, width, UInt32, height, GUID.Ptr, pixelFormat, HANDLE, hSection, UInt32, stride, UInt32, offset, IWICBitmap.Ptr, ppIBitmap, "HRESULT")
WICCreateBitmapFromSectionEx(width, height, pixelFormat, hSection, stride, offset, desiredAccessLevel, ppIBitmap)
  => DllCall("WindowsCodecs.dll\WICCreateBitmapFromSectionEx", UInt32, width, UInt32, height, GUID.Ptr, pixelFormat, HANDLE, hSection, UInt32, stride, UInt32, offset, WICSectionAccessLevel, desiredAccessLevel, IWICBitmap.Ptr, ppIBitmap, "HRESULT")
WICGetMetadataContentSize(guidContainerFormat, pIWriter, pcbSize)
  => DllCall("WindowsCodecs.dll\WICGetMetadataContentSize", GUID.Ptr, guidContainerFormat, IWICMetadataWriter, pIWriter, Int64.Ptr, pcbSize, "HRESULT")
WICMapGuidToShortName(guid, wzName?, pcchActual)
  => DllCall("WindowsCodecs.dll\WICMapGuidToShortName", GUID.Ptr, guid, UInt32, wzName?.Length ?? 0, PWSTR, wzName?, UInt32.Ptr, pcchActual, "HRESULT")
WICMapSchemaToName(guidMetadataFormat, pwzSchema, wzName?, pcchActual)
  => DllCall("WindowsCodecs.dll\WICMapSchemaToName", GUID.Ptr, guidMetadataFormat, "Str", pwzSchema, UInt32, wzName?.Length ?? 0, PWSTR, wzName?, UInt32.Ptr, pcchActual, "HRESULT")
WICMapShortNameToGuid(wzName, pguid)
  => DllCall("WindowsCodecs.dll\WICMapShortNameToGuid", "Str", wzName, GUID.Ptr, pguid, "HRESULT")
WICMatchMetadataContent(guidContainerFormat, pguidVendor?, pIStream, pguidMetadataFormat)
  => DllCall("WindowsCodecs.dll\WICMatchMetadataContent", GUID.Ptr, guidContainerFormat, GUID.Ptr, pguidVendor?, IStream, pIStream, GUID.Ptr, pguidMetadataFormat, "HRESULT")
WICSerializeMetadataContent(guidContainerFormat, pIWriter, dwPersistOptions, pIStream)
  => DllCall("WindowsCodecs.dll\WICSerializeMetadataContent", GUID.Ptr, guidContainerFormat, IWICMetadataWriter, pIWriter, UInt32, dwPersistOptions, IStream, pIStream, "HRESULT")
