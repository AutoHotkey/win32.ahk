#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HANDLE, HRESULT, PWSTR}
#Import "..\Storage.Xps\Types.ahk" {IXpsOMPackageTarget}

StartXpsPrintJob(printerName, jobName, outputFileName, progressEvent, completionEvent, printablePagesOn, xpsPrintJob, documentStream, printTicketStream)
  => DllCall("XPSPRINT.dll\StartXpsPrintJob", "Str", printerName, "Str", jobName, "Str", outputFileName, HANDLE, progressEvent, HANDLE, completionEvent, UInt8.Ptr, printablePagesOn, UInt32, printablePagesOn.Length, IXpsPrintJob.Ptr, xpsPrintJob, IXpsPrintJobStream.Ptr, documentStream, IXpsPrintJobStream.Ptr, printTicketStream, "HRESULT")
StartXpsPrintJob1(printerName, jobName, outputFileName, progressEvent, completionEvent, xpsPrintJob, printContentReceiver)
  => DllCall("XPSPRINT.dll\StartXpsPrintJob1", "Str", printerName, "Str", jobName, "Str", outputFileName, HANDLE, progressEvent, HANDLE, completionEvent, IXpsPrintJob.Ptr, xpsPrintJob, IXpsOMPackageTarget.Ptr, printContentReceiver, "HRESULT")
