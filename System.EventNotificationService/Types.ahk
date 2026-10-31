#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT}
#Import "..\System.Com\Types.ahk" {IDispatch}

struct SENS_CONNECTION_TYPE extends UInt32 {
    static CONNECTION_LAN := 0
    static CONNECTION_WAN := 1
}
struct QOCINFO {
    dwSize : UInt32
    dwFlags : UInt32
    dwInSpeed : UInt32
    dwOutSpeed : UInt32
}
struct SENS_QOCINFO {
    dwSize : UInt32
    dwFlags : UInt32
    dwOutSpeed : UInt32
    dwInSpeed : UInt32
}
struct ISensNetwork extends IDispatch {
    static IID := "{D597BAB1-5B9F-11D1-8DD2-00AA004ABD5E}"
    ConnectionMade(bstrConnection, ulType, lpQOCInfo)
      => ComCall(7, this.p, BSTR, bstrConnection, UInt32, ulType, SENS_QOCINFO.Ptr, lpQOCInfo)
    ConnectionMadeNoQOCInfo(bstrConnection, ulType)
      => ComCall(8, this.p, BSTR, bstrConnection, UInt32, ulType)
    ConnectionLost(bstrConnection, ulType)
      => ComCall(9, this.p, BSTR, bstrConnection, SENS_CONNECTION_TYPE, ulType)
    DestinationReachable(bstrDestination, bstrConnection, ulType, lpQOCInfo)
      => ComCall(10, this.p, BSTR, bstrDestination, BSTR, bstrConnection, UInt32, ulType, SENS_QOCINFO.Ptr, lpQOCInfo)
    DestinationReachableNoQOCInfo(bstrDestination, bstrConnection, ulType)
      => ComCall(11, this.p, BSTR, bstrDestination, BSTR, bstrConnection, UInt32, ulType)
}
struct ISensOnNow extends IDispatch {
    static IID := "{D597BAB2-5B9F-11D1-8DD2-00AA004ABD5E}"
    OnACPower()
      => ComCall(7, this.p)
    OnBatteryPower(dwBatteryLifePercent)
      => ComCall(8, this.p, UInt32, dwBatteryLifePercent)
    BatteryLow(dwBatteryLifePercent)
      => ComCall(9, this.p, UInt32, dwBatteryLifePercent)
}
struct ISensLogon extends IDispatch {
    static IID := "{D597BAB3-5B9F-11D1-8DD2-00AA004ABD5E}"
    Logon(bstrUserName)
      => ComCall(7, this.p, BSTR, bstrUserName)
    Logoff(bstrUserName)
      => ComCall(8, this.p, BSTR, bstrUserName)
    StartShell(bstrUserName)
      => ComCall(9, this.p, BSTR, bstrUserName)
    DisplayLock(bstrUserName)
      => ComCall(10, this.p, BSTR, bstrUserName)
    DisplayUnlock(bstrUserName)
      => ComCall(11, this.p, BSTR, bstrUserName)
    StartScreenSaver(bstrUserName)
      => ComCall(12, this.p, BSTR, bstrUserName)
    StopScreenSaver(bstrUserName)
      => ComCall(13, this.p, BSTR, bstrUserName)
}
struct ISensLogon2 extends IDispatch {
    static IID := "{D597BAB4-5B9F-11D1-8DD2-00AA004ABD5E}"
    Logon(bstrUserName, dwSessionId)
      => ComCall(7, this.p, BSTR, bstrUserName, UInt32, dwSessionId)
    Logoff(bstrUserName, dwSessionId)
      => ComCall(8, this.p, BSTR, bstrUserName, UInt32, dwSessionId)
    SessionDisconnect(bstrUserName, dwSessionId)
      => ComCall(9, this.p, BSTR, bstrUserName, UInt32, dwSessionId)
    SessionReconnect(bstrUserName, dwSessionId)
      => ComCall(10, this.p, BSTR, bstrUserName, UInt32, dwSessionId)
    PostShell(bstrUserName, dwSessionId)
      => ComCall(11, this.p, BSTR, bstrUserName, UInt32, dwSessionId)
}
