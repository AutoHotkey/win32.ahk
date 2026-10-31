#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, HINSTANCE, HRESULT, HWND, PWSTR}
#Import "..\Security\Types.ahk" {ACE_FLAGS, ACL, OBJECT_SECURITY_INFORMATION, OBJECT_TYPE_LIST, PSECURITY_DESCRIPTOR, PSID, TOKEN_GROUPS}
#Import "..\Security.Authorization\Types.ahk" {AUTHZ_SECURITY_ATTRIBUTES_INFORMATION, AUTHZ_SECURITY_ATTRIBUTE_OPERATION, AUTHZ_SID_OPERATION, INHERITED_FROMA}
#Import "..\System.Com\Types.ahk" {IDataObject, IUnknown}
#Import "..\UI.Controls\Types.ahk" {PSPCB_MESSAGE}

struct SECURITY_INFO_PAGE_FLAGS extends UInt32 {
    static SI_ADVANCED := 16
    static SI_EDIT_AUDITS := 2
    static SI_EDIT_PROPERTIES := 128
}
struct SI_OBJECT_INFO_FLAGS extends UInt32 {
    static SI_AUDITS_ELEVATION_REQUIRED := 33554432
    static SI_DISABLE_DENY_ACE := 2147483648
    static SI_EDIT_EFFECTIVE := 131072
    static SI_ENABLE_CENTRAL_POLICY := 1073741824
    static SI_ENABLE_EDIT_ATTRIBUTE_CONDITION := 536870912
    static SI_MAY_WRITE := 268435456
    static SI_NO_ADDITIONAL_PERMISSION := 2097152
    static SI_OWNER_ELEVATION_REQUIRED := 67108864
    static SI_PERMS_ELEVATION_REQUIRED := 16777216
    static SI_RESET_DACL := 262144
    static SI_RESET_OWNER := 1048576
    static SI_RESET_SACL := 524288
    static SI_SCOPE_ELEVATION_REQUIRED := 134217728
    static SI_VIEW_ONLY := 4194304
}
struct SI_OBJECT_INFO {
    dwFlags : SI_OBJECT_INFO_FLAGS
    hInstance : HINSTANCE
    pszServerName : PWSTR
    pszObjectName : PWSTR
    pszPageTitle : PWSTR
    guidObjectType : GUID
}
struct SI_ACCESS {
    pguid : GUID.Ptr
    mask : UInt32
    pszName : PWSTR
    dwFlags : UInt32
}
struct SI_INHERIT_TYPE {
    pguid : GUID.Ptr
    dwFlags : ACE_FLAGS
    pszName : PWSTR
}
struct SI_PAGE_TYPE extends Int32 {
    static SI_PAGE_PERM := 0
    static SI_PAGE_ADVPERM := 1
    static SI_PAGE_AUDIT := 2
    static SI_PAGE_OWNER := 3
    static SI_PAGE_EFFECTIVE := 4
    static SI_PAGE_TAKEOWNERSHIP := 5
    static SI_PAGE_SHARE := 6
}
struct SI_PAGE_ACTIVATED extends Int32 {
    static SI_SHOW_DEFAULT := 0
    static SI_SHOW_PERM_ACTIVATED := 1
    static SI_SHOW_AUDIT_ACTIVATED := 2
    static SI_SHOW_OWNER_ACTIVATED := 3
    static SI_SHOW_EFFECTIVE_ACTIVATED := 4
    static SI_SHOW_SHARE_ACTIVATED := 5
    static SI_SHOW_CENTRAL_POLICY_ACTIVATED := 6
}
struct ISecurityInformation extends IUnknown {
    static IID := "{965FC360-16FF-11D0-91CB-00AA00BBB723}"
    GetObjectInformation(pObjectInfo)
      => ComCall(3, this.p, SI_OBJECT_INFO.Ptr, pObjectInfo)
    GetSecurity(RequestedInformation, ppSecurityDescriptor, fDefault)
      => ComCall(4, this.p, OBJECT_SECURITY_INFORMATION, RequestedInformation, PSECURITY_DESCRIPTOR.Ptr, ppSecurityDescriptor, BOOL, fDefault)
    SetSecurity(SecurityInformation, pSecurityDescriptor)
      => ComCall(5, this.p, OBJECT_SECURITY_INFORMATION, SecurityInformation, PSECURITY_DESCRIPTOR, pSecurityDescriptor)
    GetAccessRights(pguidObjectType, dwFlags, ppAccess, pcAccesses, piDefaultAccess)
      => ComCall(6, this.p, GUID.Ptr, pguidObjectType, SECURITY_INFO_PAGE_FLAGS, dwFlags, SI_ACCESS.Ptr.Ptr, ppAccess, UInt32.Ptr, pcAccesses, UInt32.Ptr, piDefaultAccess)
    MapGeneric(pguidObjectType, pAceFlags, pMask)
      => ComCall(7, this.p, GUID.Ptr, pguidObjectType, UInt8.Ptr, pAceFlags, UInt32.Ptr, pMask)
    GetInheritTypes(ppInheritTypes, pcInheritTypes)
      => ComCall(8, this.p, SI_INHERIT_TYPE.Ptr.Ptr, ppInheritTypes, UInt32.Ptr, pcInheritTypes)
    PropertySheetPageCallback(hwnd1, uMsg, uPage)
      => ComCall(9, this.p, HWND, hwnd1, PSPCB_MESSAGE, uMsg, SI_PAGE_TYPE, uPage)
}
struct ISecurityInformation2 extends IUnknown {
    static IID := "{C3CCFDB4-6F88-11D2-A3CE-00C04FB1782A}"
    IsDaclCanonical(pDacl)
      => ComCall(3, this.p, ACL.Ptr, pDacl, BOOL)
    LookupSids(cSids, rgpSids, ppdo)
      => ComCall(4, this.p, UInt32, cSids, PSID.Ptr, rgpSids, IDataObject.Ptr, ppdo)
}
struct SID_INFO {
    pSid : PSID
    pwzCommonName : PWSTR
    pwzClass : PWSTR
    pwzUPN : PWSTR
}
struct SID_INFO_LIST {
    cItems : UInt32
    aSidInfo : SID_INFO[1]
}
struct IEffectivePermission extends IUnknown {
    static IID := "{3853DC76-9F35-407C-88A1-D19344365FBC}"
    GetEffectivePermission(pguidObjectType, pUserSid, pszServerName, pSD, ppObjectTypeList, pcObjectTypeListLength, ppGrantedAccessList, pcGrantedAccessListLength)
      => ComCall(3, this.p, GUID.Ptr, pguidObjectType, PSID, pUserSid, "Str", pszServerName, PSECURITY_DESCRIPTOR, pSD, OBJECT_TYPE_LIST.Ptr.Ptr, ppObjectTypeList, UInt32.Ptr, pcObjectTypeListLength, UInt32.Ptr.Ptr, ppGrantedAccessList, UInt32.Ptr, pcGrantedAccessListLength)
}
struct ISecurityObjectTypeInfo extends IUnknown {
    static IID := "{FC3066EB-79EF-444B-9111-D18A75EBF2FA}"
    GetInheritSource(si, pACL, ppInheritArray)
      => ComCall(3, this.p, UInt32, si, ACL.Ptr, pACL, INHERITED_FROMA.Ptr.Ptr, ppInheritArray)
}
struct ISecurityInformation3 extends IUnknown {
    static IID := "{E2CDC9CC-31BD-4F8F-8C8B-B641AF516A1A}"
    GetFullResourceName(ppszResourceName)
      => ComCall(3, this.p, PWSTR.Ptr, ppszResourceName)
    OpenElevatedEditor(hWnd1, uPage)
      => ComCall(4, this.p, HWND, hWnd1, SI_PAGE_TYPE, uPage)
}
struct SECURITY_OBJECT {
    pwszName : PWSTR
    pData : Struct.Ptr
    cbData : UInt32
    pData2 : Struct.Ptr
    cbData2 : UInt32
    Id : UInt32
    fWellKnown : BOOLEAN
}
struct EFFPERM_RESULT_LIST {
    fEvaluated : BOOLEAN
    cObjectTypeListLength : UInt32
    pObjectTypeList : OBJECT_TYPE_LIST.Ptr
    pGrantedAccessList : UInt32.Ptr
}
struct ISecurityInformation4 extends IUnknown {
    static IID := "{EA961070-CD14-4621-ACE4-F63C03E583E4}"
    GetSecondarySecurity(pSecurityObjects, pSecurityObjectCount)
      => ComCall(3, this.p, SECURITY_OBJECT.Ptr.Ptr, pSecurityObjects, UInt32.Ptr, pSecurityObjectCount)
}
struct IEffectivePermission2 extends IUnknown {
    static IID := "{941FABCA-DD47-4FCA-90BB-B0E10255F20D}"
    ComputeEffectivePermissionWithSecondarySecurity(pSid1, pDeviceSid?, pszServerName, pSecurityObjects, pUserGroups?, pAuthzUserGroupsOperations?, pDeviceGroups?, pAuthzDeviceGroupsOperations?, pAuthzUserClaims?, pAuthzUserClaimsOperations?, pAuthzDeviceClaims?, pAuthzDeviceClaimsOperations?, pEffpermResultLists)
      => ComCall(3, this.p, PSID, pSid1, PSID, pDeviceSid?, "Str", pszServerName, SECURITY_OBJECT.Ptr, pSecurityObjects, UInt32, pEffpermResultLists.Length, TOKEN_GROUPS.Ptr, pUserGroups?, AUTHZ_SID_OPERATION.Ptr, pAuthzUserGroupsOperations?, TOKEN_GROUPS.Ptr, pDeviceGroups?, AUTHZ_SID_OPERATION.Ptr, pAuthzDeviceGroupsOperations?, AUTHZ_SECURITY_ATTRIBUTES_INFORMATION.Ptr, pAuthzUserClaims?, AUTHZ_SECURITY_ATTRIBUTE_OPERATION.Ptr, pAuthzUserClaimsOperations?, AUTHZ_SECURITY_ATTRIBUTES_INFORMATION.Ptr, pAuthzDeviceClaims?, AUTHZ_SECURITY_ATTRIBUTE_OPERATION.Ptr, pAuthzDeviceClaimsOperations?, EFFPERM_RESULT_LIST.Ptr, pEffpermResultLists)
}
