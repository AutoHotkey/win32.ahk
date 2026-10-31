#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PSTR, PWSTR}
#Import "..\System.WinRT\Types.ahk" {HSTRING}

MetaDataGetDispenser(rclsid, riid, ppv)
  => DllCall("RoMetadata.dll\MetaDataGetDispenser", GUID.Ptr, rclsid, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv, "HRESULT")
RoCreateNonAgilePropertySet(ppPropertySet)
  => DllCall("api-ms-win-ro-typeresolution-l1-1-1.dll\RoCreateNonAgilePropertySet", UnsupportedType("Windows.Foundation.Collections.IPropertySet").Ptr, ppPropertySet, "HRESULT")
RoCreatePropertySetSerializer(ppPropertySetSerializer)
  => DllCall("api-ms-win-ro-typeresolution-l1-1-1.dll\RoCreatePropertySetSerializer", UnsupportedType("Windows.Storage.Streams.IPropertySetSerializer").Ptr, ppPropertySetSerializer, "HRESULT")
RoFreeParameterizedTypeExtra(extra)
  => DllCall("api-ms-win-core-winrt-roparameterizediid-l1-1-0.dll\RoFreeParameterizedTypeExtra", ROPARAMIIDHANDLE, extra, "void")
RoGetMetaDataFile(name, metaDataDispenser?, metaDataFilePath?, metaDataImport?, typeDefToken?)
  => DllCall("api-ms-win-ro-typeresolution-l1-1-0.dll\RoGetMetaDataFile", HSTRING, name, IMetaDataDispenserEx, metaDataDispenser?, HSTRING.Ptr, metaDataFilePath?, IMetaDataImport2.Ptr, metaDataImport?, UInt32.Ptr, typeDefToken?, "HRESULT")
RoGetParameterizedTypeInstanceIID(nameElements, metaDataLocator, iid, pExtra?)
  => DllCall("api-ms-win-core-winrt-roparameterizediid-l1-1-0.dll\RoGetParameterizedTypeInstanceIID", UInt32, nameElements.Length, PWSTR.Ptr, nameElements, IRoMetaDataLocator, metaDataLocator, GUID.Ptr, iid, ROPARAMIIDHANDLE.Ptr, pExtra?, "HRESULT")
RoIsApiContractMajorVersionPresent(name, majorVersion, present)
  => DllCall("api-ms-win-ro-typeresolution-l1-1-1.dll\RoIsApiContractMajorVersionPresent", "Str", name, UInt16, majorVersion, BOOL.Ptr, present, "HRESULT")
RoIsApiContractPresent(name, majorVersion, minorVersion, present)
  => DllCall("api-ms-win-ro-typeresolution-l1-1-1.dll\RoIsApiContractPresent", "Str", name, UInt16, majorVersion, UInt16, minorVersion, BOOL.Ptr, present, "HRESULT")
RoParameterizedTypeExtraGetTypeSignature(extra)
  => DllCall("api-ms-win-core-winrt-roparameterizediid-l1-1-0.dll\RoParameterizedTypeExtraGetTypeSignature", ROPARAMIIDHANDLE, extra, PSTR)
RoParseTypeName(typeName, typeNameParts)
  => DllCall("api-ms-win-ro-typeresolution-l1-1-0.dll\RoParseTypeName", HSTRING, typeName, UInt32.Ptr, typeNameParts.Length, HSTRING.Ptr.Ptr, typeNameParts, "HRESULT")
RoResolveNamespace(name?, windowsMetaDataDir?, packageGraphDirs?, metaDataFilePathsCount?, metaDataFilePaths?, subNamespacesCount?, subNamespaces?)
  => DllCall("api-ms-win-ro-typeresolution-l1-1-0.dll\RoResolveNamespace", HSTRING, name?, HSTRING, windowsMetaDataDir?, UInt32, packageGraphDirs?.Length ?? 0, HSTRING.Ptr, packageGraphDirs?, UInt32.Ptr, metaDataFilePathsCount?, HSTRING.Ptr.Ptr, metaDataFilePaths?, UInt32.Ptr, subNamespacesCount?, HSTRING.Ptr.Ptr, subNamespaces?, "HRESULT")
