#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}

struct RENDEZVOUS_SESSION_STATE extends Int32 {
    static RSS_UNKNOWN := 0
    static RSS_READY := 1
    static RSS_INVITATION := 2
    static RSS_ACCEPTED := 3
    static RSS_CONNECTED := 4
    static RSS_CANCELLED := 5
    static RSS_DECLINED := 6
    static RSS_TERMINATED := 7
}
struct RENDEZVOUS_SESSION_FLAGS extends Int32 {
    static RSF_NONE := 0
    static RSF_INVITER := 1
    static RSF_INVITEE := 2
    static RSF_ORIGINAL_INVITER := 4
    static RSF_REMOTE_LEGACYSESSION := 8
    static RSF_REMOTE_WIN7SESSION := 16
}
struct IRendezvousSession extends IUnknown {
    static IID := "{9BA4B1DD-8B0C-48B7-9E7C-2F25857C8DF5}"
    get_State(pSessionState)
      => ComCall(3, this.p, RENDEZVOUS_SESSION_STATE.Ptr, pSessionState)
    get_RemoteUser(bstrUserName)
      => ComCall(4, this.p, BSTR.Ptr, bstrUserName)
    get_Flags(pFlags)
      => ComCall(5, this.p, Int32.Ptr, pFlags)
    SendContextData(bstrData)
      => ComCall(6, this.p, BSTR, bstrData)
    Terminate(hr, bstrAppData)
      => ComCall(7, this.p, HRESULT, hr, BSTR, bstrAppData)
}
struct DRendezvousSessionEvents extends IDispatch {
    static IID := "{3FA19CF8-64C4-4F53-AE60-635B3806ECA6}"
}
struct IRendezvousApplication extends IUnknown {
    static IID := "{4F4D070B-A275-49FB-B10D-8EC26387B50D}"
    SetRendezvousSession(pRendezvousSession?)
      => ComCall(3, this.p, IUnknown, pRendezvousSession?)
}
