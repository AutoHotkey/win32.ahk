#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, HWND, PWSTR}
#Import "..\System.Com\Types.ahk" {IMoniker, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IStorage}
#Import "..\System.Ole\Types.ahk" {IOleObject}
#Import "..\System.Registry\Types.ahk" {HKEY}

struct EMPTY_VOLUME_CACHE_FLAGS extends UInt32 {
    static EVCF_HASSETTINGS := 1
    static EVCF_ENABLEBYDEFAULT := 2
    static EVCF_REMOVEFROMLIST := 4
    static EVCF_ENABLEBYDEFAULT_AUTO := 8
    static EVCF_DONTSHOWIFZERO := 16
    static EVCF_SETTINGSMODE := 32
    static EVCF_OUTOFDISKSPACE := 64
    static EVCF_USERCONSENTOBTAINED := 128
    static EVCF_SYSTEMAUTORUN := 256
}
struct IEmptyVolumeCacheCallBack extends IUnknown {
    static IID := "{6E793361-73C6-11D0-8469-00AA00442901}"
    ScanProgress(dwlSpaceUsed, dwFlags, pcwszStatus)
      => ComCall(3, this.p, Int64, dwlSpaceUsed, UInt32, dwFlags, "Str", pcwszStatus)
    PurgeProgress(dwlSpaceFreed, dwlSpaceToFree, dwFlags, pcwszStatus)
      => ComCall(4, this.p, Int64, dwlSpaceFreed, Int64, dwlSpaceToFree, UInt32, dwFlags, "Str", pcwszStatus)
}
struct IEmptyVolumeCache extends IUnknown {
    static IID := "{8FCE5227-04DA-11D1-A004-00805F8ABE06}"
    Initialize(hkRegKey, pcwszVolume, ppwszDisplayName, ppwszDescription, pdwFlags)
      => ComCall(3, this.p, HKEY, hkRegKey, "Str", pcwszVolume, PWSTR.Ptr, ppwszDisplayName, PWSTR.Ptr, ppwszDescription, EMPTY_VOLUME_CACHE_FLAGS.Ptr, pdwFlags)
    GetSpaceUsed(pdwlSpaceUsed, picb)
      => ComCall(4, this.p, Int64.Ptr, pdwlSpaceUsed, IEmptyVolumeCacheCallBack, picb)
    Purge(dwlSpaceToFree, picb)
      => ComCall(5, this.p, Int64, dwlSpaceToFree, IEmptyVolumeCacheCallBack, picb)
    ShowProperties(hwnd1)
      => ComCall(6, this.p, HWND, hwnd1)
    Deactivate(pdwFlags)
      => ComCall(7, this.p, EMPTY_VOLUME_CACHE_FLAGS.Ptr, pdwFlags)
}
struct IEmptyVolumeCache2 extends IEmptyVolumeCache {
    static IID := "{02B7E3BA-4DB3-11D2-B2D9-00C04F8EEC8C}"
    InitializeEx(hkRegKey, pcwszVolume, pcwszKeyName, ppwszDisplayName, ppwszDescription, ppwszBtnText, pdwFlags)
      => ComCall(8, this.p, HKEY, hkRegKey, "Str", pcwszVolume, "Str", pcwszKeyName, PWSTR.Ptr, ppwszDisplayName, PWSTR.Ptr, ppwszDescription, PWSTR.Ptr, ppwszBtnText, EMPTY_VOLUME_CACHE_FLAGS.Ptr, pdwFlags)
}
struct IReconcileInitiator extends IUnknown {
    static IID := "{99180161-DA16-101A-935C-444553540000}"
    SetAbortCallback(punkForAbort?)
      => ComCall(3, this.p, IUnknown, punkForAbort?)
    SetProgressFeedback(ulProgress, ulProgressMax)
      => ComCall(4, this.p, UInt32, ulProgress, UInt32, ulProgressMax)
}
struct RECONCILEF extends Int32 {
    static RECONCILEF_MAYBOTHERUSER := 1
    static RECONCILEF_FEEDBACKWINDOWVALID := 2
    static RECONCILEF_NORESIDUESOK := 4
    static RECONCILEF_OMITSELFRESIDUE := 8
    static RECONCILEF_RESUMERECONCILIATION := 16
    static RECONCILEF_YOUMAYDOTHEUPDATES := 32
    static RECONCILEF_ONLYYOUWERECHANGED := 64
    static ALL_RECONCILE_FLAGS := 127
}
struct IReconcilableObject extends IUnknown {
    static IID := "{99180162-DA16-101A-935C-444553540000}"
    Reconcile(pInitiator, dwFlags, hwndOwner, hwndProgressFeedback, rgpmkOtherInput, plOutIndex, pstgNewResidues)
      => ComCall(3, this.p, IReconcileInitiator, pInitiator, UInt32, dwFlags, HWND, hwndOwner, HWND, hwndProgressFeedback, UInt32, rgpmkOtherInput.Length, IMoniker.Ptr, rgpmkOtherInput, Int32.Ptr, plOutIndex, IStorage, pstgNewResidues, "Ptr", 0)
    GetProgressFeedbackMaxEstimate(pulProgressMax)
      => ComCall(4, this.p, UInt32.Ptr, pulProgressMax)
}
struct IBriefcaseInitiator extends IUnknown {
    static IID := "{99180164-DA16-101A-935C-444553540000}"
    IsMonikerInBriefcase(pmk)
      => ComCall(3, this.p, IMoniker, pmk)
}
struct IActiveDesktopP extends IUnknown {
    static IID := "{52502EE0-EC80-11D0-89AB-00C04FC2972D}"
    SetSafeMode(dwFlags)
      => ComCall(3, this.p, UInt32, dwFlags)
    EnsureUpdateHTML()
      => ComCall(4, this.p)
    SetScheme(pwszSchemeName, dwFlags)
      => ComCall(5, this.p, "Str", pwszSchemeName, UInt32, dwFlags)
    GetScheme(pwszSchemeName, dwFlags)
      => ComCall(6, this.p, PWSTR, pwszSchemeName, UInt32.Ptr, pwszSchemeName.Length, UInt32, dwFlags)
}
struct IADesktopP2 extends IUnknown {
    static IID := "{B22754E2-4574-11D1-9888-006097DEACF9}"
    ReReadWallpaper()
      => ComCall(3, this.p)
    GetADObjectFlags(pdwFlags, dwMask)
      => ComCall(4, this.p, UInt32.Ptr, pdwFlags, UInt32, dwMask)
    UpdateAllDesktopSubscriptions()
      => ComCall(5, this.p)
    MakeDynamicChanges(pOleObj)
      => ComCall(6, this.p, IOleObject, pOleObj)
}
