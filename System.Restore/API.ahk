#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL}

SRRemoveRestorePoint(dwRPNum)
  => DllCall("SrClient.dll\SRRemoveRestorePoint", UInt32, dwRPNum, UInt32)
SRSetRestorePoint(pRestorePtSpec, pSMgrStatus)
  => DllCall("sfc.dll\SRSetRestorePointW", RESTOREPOINTINFOW.Ptr, pRestorePtSpec, STATEMGRSTATUS.Ptr, pSMgrStatus, BOOL)
