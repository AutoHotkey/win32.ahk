#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL}

ComDBClaimNextFreePort(HComDB1, ComNumber)
  => DllCall("MSPORTS.dll\ComDBClaimNextFreePort", HCOMDB, HComDB1, UInt32.Ptr, ComNumber, Int32)
ComDBClaimPort(HComDB1, ComNumber, ForceClaim, Forced?)
  => DllCall("MSPORTS.dll\ComDBClaimPort", HCOMDB, HComDB1, UInt32, ComNumber, BOOL, ForceClaim, BOOL.Ptr, Forced?, Int32)
ComDBClose(HComDB1)
  => DllCall("MSPORTS.dll\ComDBClose", HCOMDB, HComDB1, Int32)
ComDBGetCurrentPortUsage(HComDB1, Buffer?, ReportType, MaxPortsReported?)
  => DllCall("MSPORTS.dll\ComDBGetCurrentPortUsage", HCOMDB, HComDB1, UInt8.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32, ReportType, UInt32.Ptr, MaxPortsReported?, Int32)
ComDBOpen(PHComDB)
  => DllCall("MSPORTS.dll\ComDBOpen", HCOMDB.Ptr, PHComDB, Int32)
ComDBReleasePort(HComDB1, ComNumber)
  => DllCall("MSPORTS.dll\ComDBReleasePort", HCOMDB, HComDB1, UInt32, ComNumber, Int32)
ComDBResizeDatabase(HComDB1, NewSize)
  => DllCall("MSPORTS.dll\ComDBResizeDatabase", HCOMDB, HComDB1, UInt32, NewSize, Int32)
