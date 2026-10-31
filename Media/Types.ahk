#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HANDLE, HRESULT}
#Import "..\Media.Multimedia\Types.ahk" {HDRVR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct TIMECODE_SAMPLE_FLAGS extends UInt32 {
    static ED_DEVCAP_TIMECODE_READ := 4121
    static ED_DEVCAP_ATN_READ := 5047
    static ED_DEVCAP_RTC_READ := 5050
}
struct MMTIME {
    wType : UInt32
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            ms : UInt32
            sample : UInt32
            cb : UInt32
            ticks : UInt32
            smpte : this._smpte_e__Struct
            midi : this._midi_e__Struct
        }
        struct _smpte_e__Struct {
            hour : UInt8
            min : UInt8
            sec : UInt8
            frame : UInt8
            fps : UInt8
            dummy : UInt8
            pad : UInt8[2]
        }
        struct _midi_e__Struct {
            songptrpos : UInt32
        }
    }
}
struct LPDRVCALLBACK extends FunctionPointer {
    static Types := [HDRVR, UInt32, IntPtr, IntPtr, IntPtr, "Void"]
}
struct TIMECAPS {
    wPeriodMin : UInt32
    wPeriodMax : UInt32
}
struct LPTIMECALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, IntPtr, IntPtr, IntPtr, "Void"]
}
struct IReferenceClock extends IUnknown {
    static IID := "{56A86897-0AD4-11CE-B03A-0020AF0BA770}"
    GetTime(pTime)
      => ComCall(3, this.p, Int64.Ptr, pTime)
    AdviseTime(baseTime, streamTime, hEvent, pdwAdviseCookie)
      => ComCall(4, this.p, Int64, baseTime, Int64, streamTime, HANDLE, hEvent, IntPtr.Ptr, pdwAdviseCookie)
    AdvisePeriodic(startTime, periodTime, hSemaphore, pdwAdviseCookie)
      => ComCall(5, this.p, Int64, startTime, Int64, periodTime, HANDLE, hSemaphore, IntPtr.Ptr, pdwAdviseCookie)
    Unadvise(dwAdviseCookie)
      => ComCall(6, this.p, IntPtr, dwAdviseCookie)
}
struct IReferenceClockTimerControl extends IUnknown {
    static IID := "{EBEC459C-2ECA-4D42-A8AF-30DF557614B8}"
    SetDefaultTimerResolution(timerResolution)
      => ComCall(3, this.p, Int64, timerResolution)
    GetDefaultTimerResolution(pTimerResolution)
      => ComCall(4, this.p, Int64.Ptr, pTimerResolution)
}
struct IReferenceClock2 extends IReferenceClock {
    static IID := "{36B73885-C2C8-11CF-8B46-00805F6CEF60}"
}
struct TIMECODE {
    union {
        Anonymous : this._Anonymous_e__Struct
        qw : Int64
    }
    struct _Anonymous_e__Struct {
        wFrameRate : UInt16
        wFrameFract : UInt16
        dwFrames : UInt32
    }
}
struct TIMECODE_SAMPLE {
    qwTick : Int64
    timecode : TIMECODE
    dwUser : UInt32
    dwFlags : TIMECODE_SAMPLE_FLAGS
}
