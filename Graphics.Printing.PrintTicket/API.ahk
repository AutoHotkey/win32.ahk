#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT, PWSTR}
#Import "..\Graphics.Gdi\Types.ahk" {DEVMODEA}
#Import "..\System.Com\Types.ahk" {IStream}

PTCloseProvider(hProvider)
  => DllCall("prntvpt.dll\PTCloseProvider", HPTPROVIDER, hProvider, "HRESULT")
PTConvertDevModeToPrintTicket(hProvider, cbDevmode, pDevmode, scope, pPrintTicket)
  => DllCall("prntvpt.dll\PTConvertDevModeToPrintTicket", HPTPROVIDER, hProvider, UInt32, cbDevmode, DEVMODEA.Ptr, pDevmode, EPrintTicketScope, scope, IStream, pPrintTicket, "HRESULT")
PTConvertPrintTicketToDevMode(hProvider, pPrintTicket, baseDevmodeType, scope, pcbDevmode, ppDevmode, pbstrErrorMessage?)
  => DllCall("prntvpt.dll\PTConvertPrintTicketToDevMode", HPTPROVIDER, hProvider, IStream, pPrintTicket, EDefaultDevmodeType, baseDevmodeType, EPrintTicketScope, scope, UInt32.Ptr, pcbDevmode, DEVMODEA.Ptr.Ptr, ppDevmode, BSTR.Ptr, pbstrErrorMessage?, "HRESULT")
PTGetPrintCapabilities(hProvider, pPrintTicket?, pCapabilities, pbstrErrorMessage?)
  => DllCall("prntvpt.dll\PTGetPrintCapabilities", HPTPROVIDER, hProvider, IStream, pPrintTicket?, IStream, pCapabilities, BSTR.Ptr, pbstrErrorMessage?, "HRESULT")
PTGetPrintDeviceCapabilities(hProvider, pPrintTicket?, pDeviceCapabilities, pbstrErrorMessage?)
  => DllCall("prntvpt.dll\PTGetPrintDeviceCapabilities", HPTPROVIDER, hProvider, IStream, pPrintTicket?, IStream, pDeviceCapabilities, BSTR.Ptr, pbstrErrorMessage?, "HRESULT")
PTGetPrintDeviceResources(hProvider, pszLocaleName, pPrintTicket?, pDeviceResources, pbstrErrorMessage?)
  => DllCall("prntvpt.dll\PTGetPrintDeviceResources", HPTPROVIDER, hProvider, "Str", pszLocaleName, IStream, pPrintTicket?, IStream, pDeviceResources, BSTR.Ptr, pbstrErrorMessage?, "HRESULT")
PTMergeAndValidatePrintTicket(hProvider, pBaseTicket, pDeltaTicket?, scope, pResultTicket, pbstrErrorMessage?)
  => DllCall("prntvpt.dll\PTMergeAndValidatePrintTicket", HPTPROVIDER, hProvider, IStream, pBaseTicket, IStream, pDeltaTicket?, EPrintTicketScope, scope, IStream, pResultTicket, BSTR.Ptr, pbstrErrorMessage?, "HRESULT")
PTOpenProvider(pszPrinterName, dwVersion, phProvider)
  => DllCall("prntvpt.dll\PTOpenProvider", "Str", pszPrinterName, UInt32, dwVersion, HPTPROVIDER.Ptr, phProvider, "HRESULT")
PTOpenProviderEx(pszPrinterName, dwMaxVersion, dwPrefVersion, phProvider, pUsedVersion)
  => DllCall("prntvpt.dll\PTOpenProviderEx", "Str", pszPrinterName, UInt32, dwMaxVersion, UInt32, dwPrefVersion, HPTPROVIDER.Ptr, phProvider, UInt32.Ptr, pUsedVersion, "HRESULT")
PTQuerySchemaVersionSupport(pszPrinterName, pMaxVersion)
  => DllCall("prntvpt.dll\PTQuerySchemaVersionSupport", "Str", pszPrinterName, UInt32.Ptr, pMaxVersion, "HRESULT")
PTReleaseMemory(pBuffer)
  => DllCall("prntvpt.dll\PTReleaseMemory", Struct.Ptr, pBuffer, "HRESULT")
