#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT, PWSTR}

DMProcessConfigXMLFiltered(pszXmlIn, rgszAllowedCspNodes, pbstrXmlOut)
  => DllCall("DMProcessXMLFiltered.dll\DMProcessConfigXMLFiltered", "Str", pszXmlIn, PWSTR.Ptr, rgszAllowedCspNodes, UInt32, rgszAllowedCspNodes.Length, BSTR.Ptr, pbstrXmlOut, "HRESULT")
