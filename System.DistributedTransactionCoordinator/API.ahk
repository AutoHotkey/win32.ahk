#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT, PSTR, PWSTR}

DtcGetTransactionManager(i_pszHost?, i_pszTmName?, i_riid, i_dwReserved1, i_pvReserved2?, o_ppvObject)
  => DllCall("XOLEHLP.dll\DtcGetTransactionManager", PSTR, i_pszHost?, PSTR, i_pszTmName?, GUID.Ptr, i_riid, UInt32, i_dwReserved1, UInt16, i_pvReserved2?.Size ?? 0, Struct.Ptr, i_pvReserved2?, Struct.Ptr.Ptr, o_ppvObject, "HRESULT")
DtcGetTransactionManagerC(i_pszHost?, i_pszTmName?, i_riid, i_dwReserved1, i_pvReserved2?, o_ppvObject)
  => DllCall("XOLEHLP.dll\DtcGetTransactionManagerC", PSTR, i_pszHost?, PSTR, i_pszTmName?, GUID.Ptr, i_riid, UInt32, i_dwReserved1, UInt16, i_pvReserved2?.Size ?? 0, Struct.Ptr, i_pvReserved2?, Struct.Ptr.Ptr, o_ppvObject, "HRESULT")
DtcGetTransactionManagerEx(i_pwszHost?, i_pwszTmName?, i_riid, i_grfOptions, i_pvConfigParams, o_ppvObject)
  => DllCall("XOLEHLP.dll\DtcGetTransactionManagerExW", "Str", i_pwszHost?, "Str", i_pwszTmName?, GUID.Ptr, i_riid, UInt32, i_grfOptions, Struct.Ptr, i_pvConfigParams, Struct.Ptr.Ptr, o_ppvObject, "HRESULT")
