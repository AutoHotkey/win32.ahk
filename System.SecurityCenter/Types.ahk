#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT}
#Import "..\System.Com\Types.ahk" {IDispatch}

struct WSC_SECURITY_PRODUCT_SUBSTATUS extends Int32 {
    static WSC_SECURITY_PRODUCT_SUBSTATUS_NOT_SET := 0
    static WSC_SECURITY_PRODUCT_SUBSTATUS_NO_ACTION := 1
    static WSC_SECURITY_PRODUCT_SUBSTATUS_ACTION_RECOMMENDED := 2
    static WSC_SECURITY_PRODUCT_SUBSTATUS_ACTION_NEEDED := 3
}
struct WSC_SECURITY_PRODUCT_STATE extends Int32 {
    static WSC_SECURITY_PRODUCT_STATE_ON := 0
    static WSC_SECURITY_PRODUCT_STATE_OFF := 1
    static WSC_SECURITY_PRODUCT_STATE_SNOOZED := 2
    static WSC_SECURITY_PRODUCT_STATE_EXPIRED := 3
}
struct SECURITY_PRODUCT_TYPE extends Int32 {
    static SECURITY_PRODUCT_TYPE_ANTIVIRUS := 0
    static SECURITY_PRODUCT_TYPE_FIREWALL := 1
    static SECURITY_PRODUCT_TYPE_ANTISPYWARE := 2
}
struct WSC_SECURITY_SIGNATURE_STATUS extends Int32 {
    static WSC_SECURITY_PRODUCT_OUT_OF_DATE := 0
    static WSC_SECURITY_PRODUCT_UP_TO_DATE := 1
}
struct IWscProduct extends IDispatch {
    static IID := "{8C38232E-3A45-4A27-92B0-1A16A975F669}"
    get_ProductName(pVal)
      => ComCall(7, this.p, BSTR.Ptr, pVal)
    get_ProductState(pVal)
      => ComCall(8, this.p, WSC_SECURITY_PRODUCT_STATE.Ptr, pVal)
    get_SignatureStatus(pVal)
      => ComCall(9, this.p, WSC_SECURITY_SIGNATURE_STATUS.Ptr, pVal)
    get_RemediationPath(pVal)
      => ComCall(10, this.p, BSTR.Ptr, pVal)
    get_ProductStateTimestamp(pVal)
      => ComCall(11, this.p, BSTR.Ptr, pVal)
    get_ProductGuid(pVal)
      => ComCall(12, this.p, BSTR.Ptr, pVal)
    get_ProductIsDefault(pVal)
      => ComCall(13, this.p, BOOL.Ptr, pVal)
}
struct IWscProduct2 extends IWscProduct {
    static IID := "{F896CA54-FE09-4403-86D4-23CB488D81D8}"
    get_AntivirusScanSubstatus(peStatus)
      => ComCall(14, this.p, WSC_SECURITY_PRODUCT_SUBSTATUS.Ptr, peStatus)
    get_AntivirusSettingsSubstatus(peStatus)
      => ComCall(15, this.p, WSC_SECURITY_PRODUCT_SUBSTATUS.Ptr, peStatus)
    get_AntivirusProtectionUpdateSubstatus(peStatus)
      => ComCall(16, this.p, WSC_SECURITY_PRODUCT_SUBSTATUS.Ptr, peStatus)
    get_FirewallDomainProfileSubstatus(peStatus)
      => ComCall(17, this.p, WSC_SECURITY_PRODUCT_SUBSTATUS.Ptr, peStatus)
    get_FirewallPrivateProfileSubstatus(peStatus)
      => ComCall(18, this.p, WSC_SECURITY_PRODUCT_SUBSTATUS.Ptr, peStatus)
    get_FirewallPublicProfileSubstatus(peStatus)
      => ComCall(19, this.p, WSC_SECURITY_PRODUCT_SUBSTATUS.Ptr, peStatus)
}
struct IWscProduct3 extends IWscProduct2 {
    static IID := "{55536524-D1D1-4726-8C7C-04996A1904E7}"
    get_AntivirusDaysUntilExpired(pdwDays)
      => ComCall(20, this.p, UInt32.Ptr, pdwDays)
}
struct IWSCProductList extends IDispatch {
    static IID := "{722A338C-6E8E-4E72-AC27-1417FB0C81C2}"
    Initialize(provider)
      => ComCall(7, this.p, UInt32, provider)
    get_Count(pVal)
      => ComCall(8, this.p, Int32.Ptr, pVal)
    get_Item(index, pVal)
      => ComCall(9, this.p, UInt32, index, IWscProduct.Ptr, pVal)
}
struct IWSCDefaultProduct extends IDispatch {
    static IID := "{0476D69C-F21A-11E5-9CE9-5E5517507C66}"
    SetDefaultProduct(eType, pGuid)
      => ComCall(7, this.p, SECURITY_PRODUCT_TYPE, eType, BSTR, pGuid)
}
struct WSC_SECURITY_PROVIDER extends Int32 {
    static WSC_SECURITY_PROVIDER_FIREWALL := 1
    static WSC_SECURITY_PROVIDER_AUTOUPDATE_SETTINGS := 2
    static WSC_SECURITY_PROVIDER_ANTIVIRUS := 4
    static WSC_SECURITY_PROVIDER_ANTISPYWARE := 8
    static WSC_SECURITY_PROVIDER_INTERNET_SETTINGS := 16
    static WSC_SECURITY_PROVIDER_USER_ACCOUNT_CONTROL := 32
    static WSC_SECURITY_PROVIDER_SERVICE := 64
    static WSC_SECURITY_PROVIDER_NONE := 0
    static WSC_SECURITY_PROVIDER_ALL := 127
}
struct WSC_SECURITY_PROVIDER_HEALTH extends Int32 {
    static WSC_SECURITY_PROVIDER_HEALTH_GOOD := 0
    static WSC_SECURITY_PROVIDER_HEALTH_NOTMONITORED := 1
    static WSC_SECURITY_PROVIDER_HEALTH_POOR := 2
    static WSC_SECURITY_PROVIDER_HEALTH_SNOOZE := 3
}
