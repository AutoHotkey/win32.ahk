#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, PSTR}

FCIAddFile(hfci, pszSourceFile, pszFileName, fExecute, pfnfcignc, pfnfcis, pfnfcigoi, typeCompress)
  => DllCall("Cabinet.dll\FCIAddFile", Struct.Ptr, hfci, PSTR, pszSourceFile, PSTR, pszFileName, BOOL, fExecute, PFNFCIGETNEXTCABINET, pfnfcignc, PFNFCISTATUS, pfnfcis, PFNFCIGETOPENINFO, pfnfcigoi, UInt16, typeCompress, BOOL)
FCICreate(perf, pfnfcifp, pfna, pfnf, pfnopen, pfnread, pfnwrite, pfnclose, pfnseek, pfndelete, pfnfcigtf, pccab, pv?)
  => DllCall("Cabinet.dll\FCICreate", ERF.Ptr, perf, PFNFCIFILEPLACED, pfnfcifp, PFNFCIALLOC, pfna, PFNFCIFREE, pfnf, PFNFCIOPEN, pfnopen, PFNFCIREAD, pfnread, PFNFCIWRITE, pfnwrite, PFNFCICLOSE, pfnclose, PFNFCISEEK, pfnseek, PFNFCIDELETE, pfndelete, PFNFCIGETTEMPFILE, pfnfcigtf, CCAB.Ptr, pccab, Struct.Ptr, pv?, Struct.Ptr)
FCIDestroy(hfci)
  => DllCall("Cabinet.dll\FCIDestroy", Struct.Ptr, hfci, BOOL)
FCIFlushCabinet(hfci, fGetNextCab, pfnfcignc, pfnfcis)
  => DllCall("Cabinet.dll\FCIFlushCabinet", Struct.Ptr, hfci, BOOL, fGetNextCab, PFNFCIGETNEXTCABINET, pfnfcignc, PFNFCISTATUS, pfnfcis, BOOL)
FCIFlushFolder(hfci, pfnfcignc, pfnfcis)
  => DllCall("Cabinet.dll\FCIFlushFolder", Struct.Ptr, hfci, PFNFCIGETNEXTCABINET, pfnfcignc, PFNFCISTATUS, pfnfcis, BOOL)
FDICopy(hfdi, pszCabinet, pszCabPath, flags, pfnfdin, pfnfdid, pvUser?)
  => DllCall("Cabinet.dll\FDICopy", Struct.Ptr, hfdi, PSTR, pszCabinet, PSTR, pszCabPath, Int32, flags, PFNFDINOTIFY, pfnfdin, PFNFDIDECRYPT, pfnfdid, Struct.Ptr, pvUser?, BOOL)
FDICreate(pfnalloc1, pfnfree1, pfnopen1, pfnread1, pfnwrite1, pfnclose1, pfnseek1, cpuType, perf)
  => DllCall("Cabinet.dll\FDICreate", PFNALLOC, pfnalloc1, PFNFREE, pfnfree1, PFNOPEN, pfnopen1, PFNREAD, pfnread1, PFNWRITE, pfnwrite1, PFNCLOSE, pfnclose1, PFNSEEK, pfnseek1, FDICREATE_CPU_TYPE, cpuType, ERF.Ptr, perf, Struct.Ptr)
FDIDestroy(hfdi)
  => DllCall("Cabinet.dll\FDIDestroy", Struct.Ptr, hfdi, BOOL)
FDIIsCabinet(hfdi, hf, pfdici?)
  => DllCall("Cabinet.dll\FDIIsCabinet", Struct.Ptr, hfdi, IntPtr, hf, FDICABINETINFO.Ptr, pfdici?, BOOL)
FDITruncateCabinet(hfdi, pszCabinetName, iFolderToDelete)
  => DllCall("Cabinet.dll\FDITruncateCabinet", Struct.Ptr, hfdi, PSTR, pszCabinetName, UInt16, iFolderToDelete, BOOL)
