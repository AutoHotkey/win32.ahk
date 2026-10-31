#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.WinRT\Types.ahk" {HSTRING}

struct GAMING_FULL_SCREEN_EXPERIENCE_REGISTRATION {
    Value : Struct.Ptr
}
struct PGAMING_FULL_SCREEN_EXPERIENCE_CHANGE_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct GAME_INSTALL_SCOPE extends Int32 {
    static GIS_NOT_INSTALLED := 1
    static GIS_CURRENT_USER := 2
    static GIS_ALL_USERS := 3
}
struct IGameExplorer extends IUnknown {
    static IID := "{E7B2FB72-D728-49B3-A5F2-18EBF5F1349E}"
    AddGame(bstrGDFBinaryPath, bstrGameInstallDirectory, installScope, pguidInstanceID)
      => ComCall(3, this.p, BSTR, bstrGDFBinaryPath, BSTR, bstrGameInstallDirectory, GAME_INSTALL_SCOPE, installScope, GUID.Ptr, pguidInstanceID)
    RemoveGame(guidInstanceID)
      => ComCall(4, this.p, GUID, guidInstanceID)
    UpdateGame(guidInstanceID)
      => ComCall(5, this.p, GUID, guidInstanceID)
    VerifyAccess(bstrGDFBinaryPath, pfHasAccess)
      => ComCall(6, this.p, BSTR, bstrGDFBinaryPath, BOOL.Ptr, pfHasAccess)
}
struct GAMESTATS_OPEN_TYPE extends Int32 {
    static GAMESTATS_OPEN_OPENORCREATE := 0
    static GAMESTATS_OPEN_OPENONLY := 1
}
struct GAMESTATS_OPEN_RESULT extends Int32 {
    static GAMESTATS_OPEN_CREATED := 0
    static GAMESTATS_OPEN_OPENED := 1
}
struct IGameStatistics extends IUnknown {
    static IID := "{3887C9CA-04A0-42AE-BC4C-5FA6C7721145}"
    GetMaxCategoryLength(cch)
      => ComCall(3, this.p, UInt32.Ptr, cch)
    GetMaxNameLength(cch)
      => ComCall(4, this.p, UInt32.Ptr, cch)
    GetMaxValueLength(cch)
      => ComCall(5, this.p, UInt32.Ptr, cch)
    GetMaxCategories(pMax)
      => ComCall(6, this.p, UInt16.Ptr, pMax)
    GetMaxStatsPerCategory(pMax)
      => ComCall(7, this.p, UInt16.Ptr, pMax)
    SetCategoryTitle(categoryIndex, title)
      => ComCall(8, this.p, UInt16, categoryIndex, "Str", title)
    GetCategoryTitle(categoryIndex, pTitle)
      => ComCall(9, this.p, UInt16, categoryIndex, PWSTR.Ptr, pTitle)
    GetStatistic(categoryIndex, statIndex, pName?, pValue?)
      => ComCall(10, this.p, UInt16, categoryIndex, UInt16, statIndex, PWSTR.Ptr, pName?, PWSTR.Ptr, pValue?)
    SetStatistic(categoryIndex, statIndex, name, value)
      => ComCall(11, this.p, UInt16, categoryIndex, UInt16, statIndex, "Str", name, "Str", value)
    Save(trackChanges)
      => ComCall(12, this.p, BOOL, trackChanges)
    SetLastPlayedCategory(categoryIndex)
      => ComCall(13, this.p, UInt32, categoryIndex)
    GetLastPlayedCategory(pCategoryIndex)
      => ComCall(14, this.p, UInt32.Ptr, pCategoryIndex)
}
struct IGameStatisticsMgr extends IUnknown {
    static IID := "{AFF3EA11-E70E-407D-95DD-35E612C41CE2}"
    GetGameStatistics(GDFBinaryPath, openType, pOpenResult, ppiStats)
      => ComCall(3, this.p, "Str", GDFBinaryPath, GAMESTATS_OPEN_TYPE, openType, GAMESTATS_OPEN_RESULT.Ptr, pOpenResult, IGameStatistics.Ptr, ppiStats)
    RemoveGameStatistics(GDFBinaryPath)
      => ComCall(4, this.p, "Str", GDFBinaryPath)
}
struct IGameExplorer2 extends IUnknown {
    static IID := "{86874AA7-A1ED-450D-A7EB-B89E20B2FFF3}"
    InstallGame(binaryGDFPath, installDirectory?, installScope)
      => ComCall(3, this.p, "Str", binaryGDFPath, "Str", installDirectory?, GAME_INSTALL_SCOPE, installScope)
    UninstallGame(binaryGDFPath)
      => ComCall(4, this.p, "Str", binaryGDFPath)
    CheckAccess(binaryGDFPath, pHasAccess)
      => ComCall(5, this.p, "Str", binaryGDFPath, BOOL.Ptr, pHasAccess)
}
struct GAMING_DEVICE_VENDOR_ID extends Int32 {
    static GAMING_DEVICE_VENDOR_ID_NONE := 0
    static GAMING_DEVICE_VENDOR_ID_MICROSOFT := -1024700366
}
struct GAMING_DEVICE_DEVICE_ID extends Int32 {
    static GAMING_DEVICE_DEVICE_ID_NONE := 0
    static GAMING_DEVICE_DEVICE_ID_XBOX_ONE := 1988865574
    static GAMING_DEVICE_DEVICE_ID_XBOX_ONE_S := 712204761
    static GAMING_DEVICE_DEVICE_ID_XBOX_ONE_X := 1523980231
    static GAMING_DEVICE_DEVICE_ID_XBOX_ONE_X_DEVKIT := 284675555
    static GAMING_DEVICE_DEVICE_ID_XBOX_SERIES_S := 489159355
    static GAMING_DEVICE_DEVICE_ID_XBOX_SERIES_X := 796540415
    static GAMING_DEVICE_DEVICE_ID_XBOX_SERIES_X_DEVKIT := -561359263
}
struct GAMING_DEVICE_MODEL_INFORMATION {
    vendorId : GAMING_DEVICE_VENDOR_ID
    deviceId : GAMING_DEVICE_DEVICE_ID
}
struct GameUICompletionRoutine extends FunctionPointer {
    static Types := [HRESULT, Struct.Ptr, "Void"]
}
struct PlayerPickerUICompletionRoutine extends FunctionPointer {
    static Types := [HRESULT, Struct.Ptr, HSTRING.Ptr, IntPtr, "Void"]
}
struct KnownGamingPrivileges extends Int32 {
    static XPRIVILEGE_BROADCAST := 190
    static XPRIVILEGE_VIEW_FRIENDS_LIST := 197
    static XPRIVILEGE_GAME_DVR := 198
    static XPRIVILEGE_SHARE_KINECT_CONTENT := 199
    static XPRIVILEGE_MULTIPLAYER_PARTIES := 203
    static XPRIVILEGE_COMMUNICATION_VOICE_INGAME := 205
    static XPRIVILEGE_COMMUNICATION_VOICE_SKYPE := 206
    static XPRIVILEGE_CLOUD_GAMING_MANAGE_SESSION := 207
    static XPRIVILEGE_CLOUD_GAMING_JOIN_SESSION := 208
    static XPRIVILEGE_CLOUD_SAVED_GAMES := 209
    static XPRIVILEGE_SHARE_CONTENT := 211
    static XPRIVILEGE_PREMIUM_CONTENT := 214
    static XPRIVILEGE_SUBSCRIPTION_CONTENT := 219
    static XPRIVILEGE_SOCIAL_NETWORK_SHARING := 220
    static XPRIVILEGE_PREMIUM_VIDEO := 224
    static XPRIVILEGE_VIDEO_COMMUNICATIONS := 235
    static XPRIVILEGE_PURCHASE_CONTENT := 245
    static XPRIVILEGE_USER_CREATED_CONTENT := 247
    static XPRIVILEGE_PROFILE_VIEWING := 249
    static XPRIVILEGE_COMMUNICATIONS := 252
    static XPRIVILEGE_MULTIPLAYER_SESSIONS := 254
    static XPRIVILEGE_ADD_FRIEND := 255
}
struct XBL_IDP_AUTH_TOKEN_STATUS extends Int32 {
    static XBL_IDP_AUTH_TOKEN_STATUS_SUCCESS := 0
    static XBL_IDP_AUTH_TOKEN_STATUS_OFFLINE_SUCCESS := 1
    static XBL_IDP_AUTH_TOKEN_STATUS_NO_ACCOUNT_SET := 2
    static XBL_IDP_AUTH_TOKEN_STATUS_LOAD_MSA_ACCOUNT_FAILED := 3
    static XBL_IDP_AUTH_TOKEN_STATUS_XBOX_VETO := 4
    static XBL_IDP_AUTH_TOKEN_STATUS_MSA_INTERRUPT := 5
    static XBL_IDP_AUTH_TOKEN_STATUS_OFFLINE_NO_CONSENT := 6
    static XBL_IDP_AUTH_TOKEN_STATUS_VIEW_NOT_SET := 7
    static XBL_IDP_AUTH_TOKEN_STATUS_UNKNOWN := -1
}
struct IXblIdpAuthManager extends IUnknown {
    static IID := "{EB5DDB08-8BBF-449B-AC21-B02DDEB3B136}"
    SetGamerAccount(msaAccountId, xuid)
      => ComCall(3, this.p, "Str", msaAccountId, "Str", xuid)
    GetGamerAccount(msaAccountId, xuid)
      => ComCall(4, this.p, PWSTR.Ptr, msaAccountId, PWSTR.Ptr, xuid)
    SetAppViewInitialized(appSid, msaAccountId)
      => ComCall(5, this.p, "Str", appSid, "Str", msaAccountId)
    GetEnvironment(environment)
      => ComCall(6, this.p, PWSTR.Ptr, environment)
    GetSandbox(sandbox)
      => ComCall(7, this.p, PWSTR.Ptr, sandbox)
    GetTokenAndSignatureWithTokenResult(msaAccountId, appSid, msaTarget, msaPolicy, httpMethod, uri, headers, body, forceRefresh, result)
      => ComCall(8, this.p, "Str", msaAccountId, "Str", appSid, "Str", msaTarget, "Str", msaPolicy, "Str", httpMethod, "Str", uri, "Str", headers, UInt8.Ptr, body, UInt32, body.Length, BOOL, forceRefresh, IXblIdpAuthTokenResult.Ptr, result)
}
struct IXblIdpAuthManager2 extends IUnknown {
    static IID := "{BF8C0950-8389-43DD-9A76-A19728EC5DC5}"
    GetUserlessTokenAndSignatureWithTokenResult(appSid, msaTarget, msaPolicy, httpMethod, uri, headers, body, forceRefresh, result)
      => ComCall(3, this.p, "Str", appSid, "Str", msaTarget, "Str", msaPolicy, "Str", httpMethod, "Str", uri, "Str", headers, UInt8.Ptr, body, UInt32, body.Length, BOOL, forceRefresh, IXblIdpAuthTokenResult.Ptr, result)
}
struct IXblIdpAuthTokenResult extends IUnknown {
    static IID := "{46CE0225-F267-4D68-B299-B2762552DEC1}"
    GetStatus(status)
      => ComCall(3, this.p, XBL_IDP_AUTH_TOKEN_STATUS.Ptr, status)
    GetErrorCode(errorCode)
      => ComCall(4, this.p, HRESULT.Ptr, errorCode)
    GetToken(token)
      => ComCall(5, this.p, PWSTR.Ptr, token)
    GetSignature(signature)
      => ComCall(6, this.p, PWSTR.Ptr, signature)
    GetSandbox(sandbox)
      => ComCall(7, this.p, PWSTR.Ptr, sandbox)
    GetEnvironment(environment)
      => ComCall(8, this.p, PWSTR.Ptr, environment)
    GetMsaAccountId(msaAccountId)
      => ComCall(9, this.p, PWSTR.Ptr, msaAccountId)
    GetXuid(xuid)
      => ComCall(10, this.p, PWSTR.Ptr, xuid)
    GetGamertag(gamertag)
      => ComCall(11, this.p, PWSTR.Ptr, gamertag)
    GetAgeGroup(ageGroup)
      => ComCall(12, this.p, PWSTR.Ptr, ageGroup)
    GetPrivileges(privileges)
      => ComCall(13, this.p, PWSTR.Ptr, privileges)
    GetMsaTarget(msaTarget)
      => ComCall(14, this.p, PWSTR.Ptr, msaTarget)
    GetMsaPolicy(msaPolicy)
      => ComCall(15, this.p, PWSTR.Ptr, msaPolicy)
    GetMsaAppId(msaAppId)
      => ComCall(16, this.p, PWSTR.Ptr, msaAppId)
    GetRedirect(redirect)
      => ComCall(17, this.p, PWSTR.Ptr, redirect)
    GetMessage(message)
      => ComCall(18, this.p, PWSTR.Ptr, message)
    GetHelpId(helpId)
      => ComCall(19, this.p, PWSTR.Ptr, helpId)
    GetEnforcementBans(enforcementBans)
      => ComCall(20, this.p, PWSTR.Ptr, enforcementBans)
    GetRestrictions(restrictions)
      => ComCall(21, this.p, PWSTR.Ptr, restrictions)
    GetTitleRestrictions(titleRestrictions)
      => ComCall(22, this.p, PWSTR.Ptr, titleRestrictions)
}
struct IXblIdpAuthTokenResult2 extends IUnknown {
    static IID := "{75D760B0-60B9-412D-994F-26B2CD5F7812}"
    GetModernGamertag(value)
      => ComCall(3, this.p, PWSTR.Ptr, value)
    GetModernGamertagSuffix(value)
      => ComCall(4, this.p, PWSTR.Ptr, value)
    GetUniqueModernGamertag(value)
      => ComCall(5, this.p, PWSTR.Ptr, value)
}
