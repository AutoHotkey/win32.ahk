#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\UI.Shell\Types.ahk" {IShellItem}

struct CreateProcessMethod extends Int32 {
    static CpCreateProcess := 0
    static CpCreateProcessAsUser := 1
    static CpAicLaunchAdminProcess := 2
}
struct IDDEInitializer extends IUnknown {
    static IID := "{30DC931F-33FC-4FFD-A168-942258CF3CA4}"
    Initialize(fileExtensionOrProtocol, method, currentDirectory, execTarget, site, application, targetFile, arguments, verb)
      => ComCall(3, this.p, "Str", fileExtensionOrProtocol, CreateProcessMethod, method, "Str", currentDirectory, IShellItem, execTarget, IUnknown, site, "Str", application, "Str", targetFile, "Str", arguments, "Str", verb)
}
