#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}

timeBeginPeriod(uPeriod)
  => DllCall("WINMM.dll\timeBeginPeriod", UInt32, uPeriod, UInt32)
timeEndPeriod(uPeriod)
  => DllCall("WINMM.dll\timeEndPeriod", UInt32, uPeriod, UInt32)
timeGetDevCaps(ptc)
  => DllCall("WINMM.dll\timeGetDevCaps", TIMECAPS.Ptr, ptc, UInt32, ptc.Size, UInt32)
timeGetSystemTime(pmmt)
  => DllCall("WINMM.dll\timeGetSystemTime", MMTIME.Ptr, pmmt, UInt32, pmmt.Size, UInt32)
timeGetTime()
  => DllCall("WINMM.dll\timeGetTime", UInt32)
timeKillEvent(uTimerID)
  => DllCall("WINMM.dll\timeKillEvent", UInt32, uTimerID, UInt32)
timeSetEvent(uDelay, uResolution, fptc, dwUser, fuEvent)
  => DllCall("WINMM.dll\timeSetEvent", UInt32, uDelay, UInt32, uResolution, LPTIMECALLBACK, fptc, IntPtr, dwUser, UInt32, fuEvent, UInt32)
