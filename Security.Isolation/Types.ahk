#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct IsolatedAppLauncherTelemetryParameters {
    EnableForLaunch : BOOL
    CorrelationGUID : GUID
}
struct IIsolatedAppLauncher extends IUnknown {
    static IID := "{F686878F-7B42-4CC4-96FB-F4F3B6E3D24D}"
    Launch(appUserModelId, arguments, telemetryParameters)
      => ComCall(3, this.p, "Str", appUserModelId, "Str", arguments, IsolatedAppLauncherTelemetryParameters.Ptr, telemetryParameters)
}
struct IIsolatedProcessLauncher extends IUnknown {
    static IID := "{1AA24232-9A91-4201-88CB-122F9D6522E0}"
    LaunchProcess(process, arguments, workingDirectory)
      => ComCall(3, this.p, "Str", process, "Str", arguments, "Str", workingDirectory)
    ShareDirectory(hostPath, containerPath, readOnly)
      => ComCall(4, this.p, "Str", hostPath, "Str", containerPath, BOOL, readOnly)
    GetContainerGuid(guid)
      => ComCall(5, this.p, GUID.Ptr, guid)
    AllowSetForegroundAccess(pid)
      => ComCall(6, this.p, UInt32, pid)
    IsContainerRunning(running)
      => ComCall(7, this.p, BOOL.Ptr, running)
}
struct IIsolatedProcessLauncher2 extends IIsolatedProcessLauncher {
    static IID := "{780E4416-5E72-4123-808E-66DC6479FEEF}"
    LaunchProcess2(process, arguments, workingDirectory, correlationGuid)
      => ComCall(8, this.p, "Str", process, "Str", arguments, "Str", workingDirectory, GUID.Ptr, correlationGuid)
}
