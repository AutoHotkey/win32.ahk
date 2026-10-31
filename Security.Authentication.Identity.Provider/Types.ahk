#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, HWND, PROPERTYKEY, PWSTR}
#Import "..\System.Com\Types.ahk" {IBindCtx, IEnumUnknown, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.Shell.PropertiesSystem\Types.ahk" {IPropertyStore}

struct IDENTITY_TYPE extends Int32 {
    static IDENTITIES_ALL := 0
    static IDENTITIES_ME_ONLY := 1
}
struct IdentityUpdateEvent extends Int32 {
    static IDENTITY_ASSOCIATED := 1
    static IDENTITY_DISASSOCIATED := 2
    static IDENTITY_CREATED := 4
    static IDENTITY_IMPORTED := 8
    static IDENTITY_DELETED := 16
    static IDENTITY_PROPCHANGED := 32
    static IDENTITY_CONNECTED := 64
    static IDENTITY_DISCONNECTED := 128
}
struct IIdentityAdvise extends IUnknown {
    static IID := "{4E982FED-D14B-440C-B8D6-BB386453D386}"
    IdentityUpdated(dwIdentityUpdateEvents, lpszUniqueID)
      => ComCall(3, this.p, UInt32, dwIdentityUpdateEvents, "Str", lpszUniqueID)
}
struct AsyncIIdentityAdvise extends IUnknown {
    static IID := "{3AB4C8DA-D038-4830-8DD9-3253C55A127F}"
    Begin_IdentityUpdated(dwIdentityUpdateEvents, lpszUniqueID)
      => ComCall(3, this.p, UInt32, dwIdentityUpdateEvents, "Str", lpszUniqueID)
    Finish_IdentityUpdated()
      => ComCall(4, this.p)
}
struct IIdentityProvider extends IUnknown {
    static IID := "{0D1B9E0C-E8BA-4F55-A81B-BCE934B948F5}"
    GetIdentityEnum(eIdentityType, pFilterkey?, pFilterPropVarValue?, ppIdentityEnum)
      => ComCall(3, this.p, IDENTITY_TYPE, eIdentityType, PROPERTYKEY.Ptr, pFilterkey?, PROPVARIANT.Ptr, pFilterPropVarValue?, IEnumUnknown.Ptr, ppIdentityEnum)
    Create(lpszUserName, ppPropertyStore, pKeywordsToAdd)
      => ComCall(4, this.p, "Str", lpszUserName, IPropertyStore.Ptr, ppPropertyStore, PROPVARIANT.Ptr, pKeywordsToAdd)
    Import(pPropertyStore?)
      => ComCall(5, this.p, IPropertyStore, pPropertyStore?)
    Delete(lpszUniqueID, pKeywordsToDelete)
      => ComCall(6, this.p, "Str", lpszUniqueID, PROPVARIANT.Ptr, pKeywordsToDelete)
    FindByUniqueID(lpszUniqueID, ppPropertyStore)
      => ComCall(7, this.p, "Str", lpszUniqueID, IPropertyStore.Ptr, ppPropertyStore)
    GetProviderPropertyStore(ppPropertyStore)
      => ComCall(8, this.p, IPropertyStore.Ptr, ppPropertyStore)
    Advise(pIdentityAdvise?, dwIdentityUpdateEvents, pdwCookie)
      => ComCall(9, this.p, IIdentityAdvise, pIdentityAdvise?, UInt32, dwIdentityUpdateEvents, UInt32.Ptr, pdwCookie)
    UnAdvise(dwCookie)
      => ComCall(10, this.p, UInt32, dwCookie)
}
struct AsyncIIdentityProvider extends IUnknown {
    static IID := "{C6FC9901-C433-4646-8F48-4E4687AAE2A0}"
    Begin_GetIdentityEnum(eIdentityType, pFilterkey?, pFilterPropVarValue?)
      => ComCall(3, this.p, IDENTITY_TYPE, eIdentityType, PROPERTYKEY.Ptr, pFilterkey?, PROPVARIANT.Ptr, pFilterPropVarValue?)
    Finish_GetIdentityEnum(ppIdentityEnum)
      => ComCall(4, this.p, IEnumUnknown.Ptr, ppIdentityEnum)
    Begin_Create(lpszUserName, pKeywordsToAdd)
      => ComCall(5, this.p, "Str", lpszUserName, PROPVARIANT.Ptr, pKeywordsToAdd)
    Finish_Create(ppPropertyStore)
      => ComCall(6, this.p, IPropertyStore.Ptr, ppPropertyStore)
    Begin_Import(pPropertyStore?)
      => ComCall(7, this.p, IPropertyStore, pPropertyStore?)
    Finish_Import()
      => ComCall(8, this.p)
    Begin_Delete(lpszUniqueID, pKeywordsToDelete)
      => ComCall(9, this.p, "Str", lpszUniqueID, PROPVARIANT.Ptr, pKeywordsToDelete)
    Finish_Delete()
      => ComCall(10, this.p)
    Begin_FindByUniqueID(lpszUniqueID)
      => ComCall(11, this.p, "Str", lpszUniqueID)
    Finish_FindByUniqueID(ppPropertyStore)
      => ComCall(12, this.p, IPropertyStore.Ptr, ppPropertyStore)
    Begin_GetProviderPropertyStore()
      => ComCall(13, this.p)
    Finish_GetProviderPropertyStore(ppPropertyStore)
      => ComCall(14, this.p, IPropertyStore.Ptr, ppPropertyStore)
    Begin_Advise(pIdentityAdvise?, dwIdentityUpdateEvents)
      => ComCall(15, this.p, IIdentityAdvise, pIdentityAdvise?, UInt32, dwIdentityUpdateEvents)
    Finish_Advise(pdwCookie)
      => ComCall(16, this.p, UInt32.Ptr, pdwCookie)
    Begin_UnAdvise(dwCookie)
      => ComCall(17, this.p, UInt32, dwCookie)
    Finish_UnAdvise()
      => ComCall(18, this.p)
}
struct IAssociatedIdentityProvider extends IUnknown {
    static IID := "{2AF066B3-4CBB-4CBA-A798-204B6AF68CC0}"
    AssociateIdentity(hwndParent, ppPropertyStore)
      => ComCall(3, this.p, HWND, hwndParent, IPropertyStore.Ptr, ppPropertyStore)
    DisassociateIdentity(hwndParent, lpszUniqueID)
      => ComCall(4, this.p, HWND, hwndParent, "Str", lpszUniqueID)
    ChangeCredential(hwndParent, lpszUniqueID)
      => ComCall(5, this.p, HWND, hwndParent, "Str", lpszUniqueID)
}
struct AsyncIAssociatedIdentityProvider extends IUnknown {
    static IID := "{2834D6ED-297E-4E72-8A51-961E86F05152}"
    Begin_AssociateIdentity(hwndParent)
      => ComCall(3, this.p, HWND, hwndParent)
    Finish_AssociateIdentity(ppPropertyStore)
      => ComCall(4, this.p, IPropertyStore.Ptr, ppPropertyStore)
    Begin_DisassociateIdentity(hwndParent, lpszUniqueID)
      => ComCall(5, this.p, HWND, hwndParent, "Str", lpszUniqueID)
    Finish_DisassociateIdentity()
      => ComCall(6, this.p)
    Begin_ChangeCredential(hwndParent, lpszUniqueID)
      => ComCall(7, this.p, HWND, hwndParent, "Str", lpszUniqueID)
    Finish_ChangeCredential()
      => ComCall(8, this.p)
}
struct IDENTITY_URL extends Int32 {
    static IDENTITY_URL_CREATE_ACCOUNT_WIZARD := 0
    static IDENTITY_URL_SIGN_IN_WIZARD := 1
    static IDENTITY_URL_CHANGE_PASSWORD_WIZARD := 2
    static IDENTITY_URL_IFEXISTS_WIZARD := 3
    static IDENTITY_URL_ACCOUNT_SETTINGS := 4
    static IDENTITY_URL_RESTORE_WIZARD := 5
    static IDENTITY_URL_CONNECT_WIZARD := 6
}
struct ACCOUNT_STATE extends Int32 {
    static NOT_CONNECTED := 0
    static CONNECTING := 1
    static CONNECT_COMPLETED := 2
}
struct IConnectedIdentityProvider extends IUnknown {
    static IID := "{B7417B54-E08C-429B-96C8-678D1369ECB1}"
    ConnectIdentity(AuthBuffer)
      => ComCall(3, this.p, UInt8.Ptr, AuthBuffer, UInt32, AuthBuffer.Length)
    DisconnectIdentity()
      => ComCall(4, this.p)
    IsConnected(Connected)
      => ComCall(5, this.p, BOOL.Ptr, Connected)
    GetUrl(Identifier, Context?, PostData, Url)
      => ComCall(6, this.p, IDENTITY_URL, Identifier, IBindCtx, Context?, VARIANT.Ptr, PostData, PWSTR.Ptr, Url)
    GetAccountState(pState)
      => ComCall(7, this.p, ACCOUNT_STATE.Ptr, pState)
}
struct AsyncIConnectedIdentityProvider extends IUnknown {
    static IID := "{9CE55141-BCE9-4E15-824D-43D79F512F93}"
    Begin_ConnectIdentity(AuthBuffer)
      => ComCall(3, this.p, UInt8.Ptr, AuthBuffer, UInt32, AuthBuffer.Length)
    Finish_ConnectIdentity()
      => ComCall(4, this.p)
    Begin_DisconnectIdentity()
      => ComCall(5, this.p)
    Finish_DisconnectIdentity()
      => ComCall(6, this.p)
    Begin_IsConnected()
      => ComCall(7, this.p)
    Finish_IsConnected(Connected)
      => ComCall(8, this.p, BOOL.Ptr, Connected)
    Begin_GetUrl(Identifier, Context?)
      => ComCall(9, this.p, IDENTITY_URL, Identifier, IBindCtx, Context?)
    Finish_GetUrl(PostData, Url)
      => ComCall(10, this.p, VARIANT.Ptr, PostData, PWSTR.Ptr, Url)
    Begin_GetAccountState()
      => ComCall(11, this.p)
    Finish_GetAccountState(pState)
      => ComCall(12, this.p, ACCOUNT_STATE.Ptr, pState)
}
struct IIdentityAuthentication extends IUnknown {
    static IID := "{5E7EF254-979F-43B5-B74E-06E4EB7DF0F9}"
    SetIdentityCredential(CredBuffer?)
      => ComCall(3, this.p, UInt8.Ptr, CredBuffer?, UInt32, CredBuffer?.Length ?? 0)
    ValidateIdentityCredential(CredBuffer, ppIdentityProperties?)
      => ComCall(4, this.p, UInt8.Ptr, CredBuffer, UInt32, CredBuffer.Length, IPropertyStore.Ptr, ppIdentityProperties?)
}
struct AsyncIIdentityAuthentication extends IUnknown {
    static IID := "{F9A2F918-FECA-4E9C-9633-61CBF13ED34D}"
    Begin_SetIdentityCredential(CredBuffer?)
      => ComCall(3, this.p, UInt8.Ptr, CredBuffer?, UInt32, CredBuffer?.Length ?? 0)
    Finish_SetIdentityCredential()
      => ComCall(4, this.p)
    Begin_ValidateIdentityCredential(CredBuffer, ppIdentityProperties?)
      => ComCall(5, this.p, UInt8.Ptr, CredBuffer, UInt32, CredBuffer.Length, IPropertyStore.Ptr, ppIdentityProperties?)
    Finish_ValidateIdentityCredential(ppIdentityProperties?)
      => ComCall(6, this.p, IPropertyStore.Ptr, ppIdentityProperties?)
}
struct IIdentityStore extends IUnknown {
    static IID := "{DF586FA5-6F35-44F1-B209-B38E169772EB}"
    GetCount(pdwProviders)
      => ComCall(3, this.p, UInt32.Ptr, pdwProviders)
    GetAt(dwProvider, pProvGuid?, ppIdentityProvider)
      => ComCall(4, this.p, UInt32, dwProvider, GUID.Ptr, pProvGuid?, IUnknown.Ptr, ppIdentityProvider)
    AddToCache(lpszUniqueID, ProviderGUID)
      => ComCall(5, this.p, "Str", lpszUniqueID, GUID.Ptr, ProviderGUID)
    ConvertToSid(lpszUniqueID, ProviderGUID, pSid?, pcbRequiredSid)
      => ComCall(6, this.p, "Str", lpszUniqueID, GUID.Ptr, ProviderGUID, UInt16, pSid?.Length ?? 0, UInt8.Ptr, pSid?, UInt16.Ptr, pcbRequiredSid)
    EnumerateIdentities(eIdentityType, pFilterkey?, pFilterPropVarValue?, ppIdentityEnum)
      => ComCall(7, this.p, IDENTITY_TYPE, eIdentityType, PROPERTYKEY.Ptr, pFilterkey?, PROPVARIANT.Ptr, pFilterPropVarValue?, IEnumUnknown.Ptr, ppIdentityEnum)
    Reset()
      => ComCall(8, this.p)
}
struct AsyncIIdentityStore extends IUnknown {
    static IID := "{EEFA1616-48DE-4872-AA64-6E6206535A51}"
    Begin_GetCount()
      => ComCall(3, this.p)
    Finish_GetCount(pdwProviders)
      => ComCall(4, this.p, UInt32.Ptr, pdwProviders)
    Begin_GetAt(dwProvider, pProvGuid?)
      => ComCall(5, this.p, UInt32, dwProvider, GUID.Ptr, pProvGuid?)
    Finish_GetAt(pProvGuid?, ppIdentityProvider)
      => ComCall(6, this.p, GUID.Ptr, pProvGuid?, IUnknown.Ptr, ppIdentityProvider)
    Begin_AddToCache(lpszUniqueID, ProviderGUID)
      => ComCall(7, this.p, "Str", lpszUniqueID, GUID.Ptr, ProviderGUID)
    Finish_AddToCache()
      => ComCall(8, this.p)
    Begin_ConvertToSid(lpszUniqueID, ProviderGUID, cbSid, pSid?)
      => ComCall(9, this.p, "Str", lpszUniqueID, GUID.Ptr, ProviderGUID, UInt16, cbSid, UInt8.Ptr, pSid?)
    Finish_ConvertToSid(pSid?, pcbRequiredSid)
      => ComCall(10, this.p, UInt8.Ptr, pSid?, UInt16.Ptr, pcbRequiredSid)
    Begin_EnumerateIdentities(eIdentityType, pFilterkey?, pFilterPropVarValue?)
      => ComCall(11, this.p, IDENTITY_TYPE, eIdentityType, PROPERTYKEY.Ptr, pFilterkey?, PROPVARIANT.Ptr, pFilterPropVarValue?)
    Finish_EnumerateIdentities(ppIdentityEnum)
      => ComCall(12, this.p, IEnumUnknown.Ptr, ppIdentityEnum)
    Begin_Reset()
      => ComCall(13, this.p)
    Finish_Reset()
      => ComCall(14, this.p)
}
struct IIdentityStoreEx extends IUnknown {
    static IID := "{F9F9EB98-8F7F-4E38-9577-6980114CE32B}"
    CreateConnectedIdentity(LocalName?, ConnectedName, ProviderGUID)
      => ComCall(3, this.p, "Str", LocalName?, "Str", ConnectedName, GUID.Ptr, ProviderGUID)
    DeleteConnectedIdentity(ConnectedName, ProviderGUID)
      => ComCall(4, this.p, "Str", ConnectedName, GUID.Ptr, ProviderGUID)
}
struct AsyncIIdentityStoreEx extends IUnknown {
    static IID := "{FCA3AF9A-8A07-4EAE-8632-EC3DE658A36A}"
    Begin_CreateConnectedIdentity(LocalName?, ConnectedName, ProviderGUID)
      => ComCall(3, this.p, "Str", LocalName?, "Str", ConnectedName, GUID.Ptr, ProviderGUID)
    Finish_CreateConnectedIdentity()
      => ComCall(4, this.p)
    Begin_DeleteConnectedIdentity(ConnectedName, ProviderGUID)
      => ComCall(5, this.p, "Str", ConnectedName, GUID.Ptr, ProviderGUID)
    Finish_DeleteConnectedIdentity()
      => ComCall(6, this.p)
}
