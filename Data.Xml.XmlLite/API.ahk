#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IMalloc, IUnknown}

CreateXmlReader(riid, ppvObject, pMalloc?)
  => DllCall("XmlLite.dll\CreateXmlReader", GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject, IMalloc, pMalloc?, "HRESULT")
CreateXmlReaderInputWithEncodingCodePage(pInputStream, pMalloc?, nEncodingCodePage, fEncodingHint, pwszBaseUri?, ppInput)
  => DllCall("XmlLite.dll\CreateXmlReaderInputWithEncodingCodePage", IUnknown, pInputStream, IMalloc, pMalloc?, UInt32, nEncodingCodePage, BOOL, fEncodingHint, "Str", pwszBaseUri?, IUnknown.Ptr, ppInput, "HRESULT")
CreateXmlReaderInputWithEncodingName(pInputStream, pMalloc?, pwszEncodingName, fEncodingHint, pwszBaseUri?, ppInput)
  => DllCall("XmlLite.dll\CreateXmlReaderInputWithEncodingName", IUnknown, pInputStream, IMalloc, pMalloc?, "Str", pwszEncodingName, BOOL, fEncodingHint, "Str", pwszBaseUri?, IUnknown.Ptr, ppInput, "HRESULT")
CreateXmlWriter(riid, ppvObject, pMalloc?)
  => DllCall("XmlLite.dll\CreateXmlWriter", GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject, IMalloc, pMalloc?, "HRESULT")
CreateXmlWriterOutputWithEncodingCodePage(pOutputStream, pMalloc?, nEncodingCodePage, ppOutput)
  => DllCall("XmlLite.dll\CreateXmlWriterOutputWithEncodingCodePage", IUnknown, pOutputStream, IMalloc, pMalloc?, UInt32, nEncodingCodePage, IUnknown.Ptr, ppOutput, "HRESULT")
CreateXmlWriterOutputWithEncodingName(pOutputStream, pMalloc?, pwszEncodingName, ppOutput)
  => DllCall("XmlLite.dll\CreateXmlWriterOutputWithEncodingName", IUnknown, pOutputStream, IMalloc, pMalloc?, "Str", pwszEncodingName, IUnknown.Ptr, ppOutput, "HRESULT")
