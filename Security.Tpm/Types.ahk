#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct TPMVSC_ATTESTATION_TYPE extends Int32 {
    static TPMVSC_ATTESTATION_NONE := 0
    static TPMVSC_ATTESTATION_AIK_ONLY := 1
    static TPMVSC_ATTESTATION_AIK_AND_CERTIFICATE := 2
}
struct TPMVSCMGR_STATUS extends Int32 {
    static TPMVSCMGR_STATUS_VTPMSMARTCARD_INITIALIZING := 0
    static TPMVSCMGR_STATUS_VTPMSMARTCARD_CREATING := 1
    static TPMVSCMGR_STATUS_VTPMSMARTCARD_DESTROYING := 2
    static TPMVSCMGR_STATUS_VGIDSSIMULATOR_INITIALIZING := 3
    static TPMVSCMGR_STATUS_VGIDSSIMULATOR_CREATING := 4
    static TPMVSCMGR_STATUS_VGIDSSIMULATOR_DESTROYING := 5
    static TPMVSCMGR_STATUS_VREADER_INITIALIZING := 6
    static TPMVSCMGR_STATUS_VREADER_CREATING := 7
    static TPMVSCMGR_STATUS_VREADER_DESTROYING := 8
    static TPMVSCMGR_STATUS_GENERATE_WAITING := 9
    static TPMVSCMGR_STATUS_GENERATE_AUTHENTICATING := 10
    static TPMVSCMGR_STATUS_GENERATE_RUNNING := 11
    static TPMVSCMGR_STATUS_CARD_CREATED := 12
    static TPMVSCMGR_STATUS_CARD_DESTROYED := 13
}
struct TPMVSCMGR_ERROR extends Int32 {
    static TPMVSCMGR_ERROR_IMPERSONATION := 0
    static TPMVSCMGR_ERROR_PIN_COMPLEXITY := 1
    static TPMVSCMGR_ERROR_READER_COUNT_LIMIT := 2
    static TPMVSCMGR_ERROR_TERMINAL_SERVICES_SESSION := 3
    static TPMVSCMGR_ERROR_VTPMSMARTCARD_INITIALIZE := 4
    static TPMVSCMGR_ERROR_VTPMSMARTCARD_CREATE := 5
    static TPMVSCMGR_ERROR_VTPMSMARTCARD_DESTROY := 6
    static TPMVSCMGR_ERROR_VGIDSSIMULATOR_INITIALIZE := 7
    static TPMVSCMGR_ERROR_VGIDSSIMULATOR_CREATE := 8
    static TPMVSCMGR_ERROR_VGIDSSIMULATOR_DESTROY := 9
    static TPMVSCMGR_ERROR_VGIDSSIMULATOR_WRITE_PROPERTY := 10
    static TPMVSCMGR_ERROR_VGIDSSIMULATOR_READ_PROPERTY := 11
    static TPMVSCMGR_ERROR_VREADER_INITIALIZE := 12
    static TPMVSCMGR_ERROR_VREADER_CREATE := 13
    static TPMVSCMGR_ERROR_VREADER_DESTROY := 14
    static TPMVSCMGR_ERROR_GENERATE_LOCATE_READER := 15
    static TPMVSCMGR_ERROR_GENERATE_FILESYSTEM := 16
    static TPMVSCMGR_ERROR_CARD_CREATE := 17
    static TPMVSCMGR_ERROR_CARD_DESTROY := 18
}
struct ITpmVirtualSmartCardManagerStatusCallback extends IUnknown {
    static IID := "{1A1BB35F-ABB8-451C-A1AE-33D98F1BEF4A}"
    ReportProgress(Status)
      => ComCall(3, this.p, TPMVSCMGR_STATUS, Status)
    ReportError(Error)
      => ComCall(4, this.p, TPMVSCMGR_ERROR, Error)
}
struct ITpmVirtualSmartCardManager extends IUnknown {
    static IID := "{112B1DFF-D9DC-41F7-869F-D67FEE7CB591}"
    CreateVirtualSmartCard(pszFriendlyName, bAdminAlgId, pbAdminKey, pbAdminKcv, pbPuk, pbPin, fGenerate, pStatusCallback, ppszInstanceId, pfNeedReboot)
      => ComCall(3, this.p, "Str", pszFriendlyName, UInt8, bAdminAlgId, UInt8.Ptr, pbAdminKey, UInt32, pbAdminKey.Length, UInt8.Ptr, pbAdminKcv, UInt32, pbAdminKcv.Length, UInt8.Ptr, pbPuk, UInt32, pbPuk.Length, UInt8.Ptr, pbPin, UInt32, pbPin.Length, BOOL, fGenerate, ITpmVirtualSmartCardManagerStatusCallback, pStatusCallback, PWSTR.Ptr, ppszInstanceId, BOOL.Ptr, pfNeedReboot)
    DestroyVirtualSmartCard(pszInstanceId, pStatusCallback, pfNeedReboot)
      => ComCall(4, this.p, "Str", pszInstanceId, ITpmVirtualSmartCardManagerStatusCallback, pStatusCallback, BOOL.Ptr, pfNeedReboot)
}
struct ITpmVirtualSmartCardManager2 extends ITpmVirtualSmartCardManager {
    static IID := "{FDF8A2B9-02DE-47F4-BC26-AA85AB5E5267}"
    CreateVirtualSmartCardWithPinPolicy(pszFriendlyName, bAdminAlgId, pbAdminKey, pbAdminKcv, pbPuk, pbPin, pbPinPolicy, fGenerate, pStatusCallback, ppszInstanceId, pfNeedReboot)
      => ComCall(5, this.p, "Str", pszFriendlyName, UInt8, bAdminAlgId, UInt8.Ptr, pbAdminKey, UInt32, pbAdminKey.Length, UInt8.Ptr, pbAdminKcv, UInt32, pbAdminKcv.Length, UInt8.Ptr, pbPuk, UInt32, pbPuk.Length, UInt8.Ptr, pbPin, UInt32, pbPin.Length, UInt8.Ptr, pbPinPolicy, UInt32, pbPinPolicy.Length, BOOL, fGenerate, ITpmVirtualSmartCardManagerStatusCallback, pStatusCallback, PWSTR.Ptr, ppszInstanceId, BOOL.Ptr, pfNeedReboot)
}
struct ITpmVirtualSmartCardManager3 extends ITpmVirtualSmartCardManager2 {
    static IID := "{3C745A97-F375-4150-BE17-5950F694C699}"
    CreateVirtualSmartCardWithAttestation(pszFriendlyName, bAdminAlgId, pbAdminKey, pbAdminKcv, pbPuk, pbPin, pbPinPolicy, attestationType, fGenerate, pStatusCallback, ppszInstanceId)
      => ComCall(6, this.p, "Str", pszFriendlyName, UInt8, bAdminAlgId, UInt8.Ptr, pbAdminKey, UInt32, pbAdminKey.Length, UInt8.Ptr, pbAdminKcv, UInt32, pbAdminKcv.Length, UInt8.Ptr, pbPuk, UInt32, pbPuk.Length, UInt8.Ptr, pbPin, UInt32, pbPin.Length, UInt8.Ptr, pbPinPolicy, UInt32, pbPinPolicy.Length, TPMVSC_ATTESTATION_TYPE, attestationType, BOOL, fGenerate, ITpmVirtualSmartCardManagerStatusCallback, pStatusCallback, PWSTR.Ptr, ppszInstanceId)
}
