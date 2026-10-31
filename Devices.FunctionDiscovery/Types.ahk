#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PROPERTYKEY, PWSTR}
#Import "..\System.Com\Types.ahk" {IServiceProvider, IUnknown, STGM}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}
#Import "..\UI.Shell.PropertiesSystem\Types.ahk" {IPropertyStore}

struct PropertyConstraint extends Int32 {
    static QC_EQUALS := 0
    static QC_NOTEQUAL := 1
    static QC_LESSTHAN := 2
    static QC_LESSTHANOREQUAL := 3
    static QC_GREATERTHAN := 4
    static QC_GREATERTHANOREQUAL := 5
    static QC_STARTSWITH := 6
    static QC_EXISTS := 7
    static QC_DOESNOTEXIST := 8
    static QC_CONTAINS := 9
}
struct SystemVisibilityFlags extends Int32 {
    static SVF_SYSTEM := 0
    static SVF_USER := 1
}
struct QueryUpdateAction extends Int32 {
    static QUA_ADD := 0
    static QUA_REMOVE := 1
    static QUA_CHANGE := 2
}
struct QueryCategoryType extends Int32 {
    static QCT_PROVIDER := 0
    static QCT_LAYERED := 1
}
struct IFunctionDiscoveryNotification extends IUnknown {
    static IID := "{5F6C1BA8-5330-422E-A368-572B244D3F87}"
    OnUpdate(enumQueryUpdateAction, fdqcQueryContext, pIFunctionInstance)
      => ComCall(3, this.p, QueryUpdateAction, enumQueryUpdateAction, Int64, fdqcQueryContext, IFunctionInstance, pIFunctionInstance)
    OnError(hr, fdqcQueryContext, pszProvider)
      => ComCall(4, this.p, HRESULT, hr, Int64, fdqcQueryContext, "Str", pszProvider)
    OnEvent(dwEventID, fdqcQueryContext, pszProvider)
      => ComCall(5, this.p, UInt32, dwEventID, Int64, fdqcQueryContext, "Str", pszProvider)
}
struct IFunctionDiscovery extends IUnknown {
    static IID := "{4DF99B70-E148-4432-B004-4C9EEB535A5E}"
    GetInstanceCollection(pszCategory, pszSubCategory, fIncludeAllSubCategories, ppIFunctionInstanceCollection)
      => ComCall(3, this.p, "Str", pszCategory, "Str", pszSubCategory, BOOL, fIncludeAllSubCategories, IFunctionInstanceCollection.Ptr, ppIFunctionInstanceCollection)
    GetInstance(pszFunctionInstanceIdentity, ppIFunctionInstance)
      => ComCall(4, this.p, "Str", pszFunctionInstanceIdentity, IFunctionInstance.Ptr, ppIFunctionInstance)
    CreateInstanceCollectionQuery(pszCategory, pszSubCategory, fIncludeAllSubCategories, pIFunctionDiscoveryNotification, pfdqcQueryContext, ppIFunctionInstanceCollectionQuery)
      => ComCall(5, this.p, "Str", pszCategory, "Str", pszSubCategory, BOOL, fIncludeAllSubCategories, IFunctionDiscoveryNotification, pIFunctionDiscoveryNotification, Int64.Ptr, pfdqcQueryContext, IFunctionInstanceCollectionQuery.Ptr, ppIFunctionInstanceCollectionQuery)
    CreateInstanceQuery(pszFunctionInstanceIdentity, pIFunctionDiscoveryNotification, pfdqcQueryContext, ppIFunctionInstanceQuery)
      => ComCall(6, this.p, "Str", pszFunctionInstanceIdentity, IFunctionDiscoveryNotification, pIFunctionDiscoveryNotification, Int64.Ptr, pfdqcQueryContext, IFunctionInstanceQuery.Ptr, ppIFunctionInstanceQuery)
    AddInstance(enumSystemVisibility, pszCategory, pszSubCategory, pszCategoryIdentity, ppIFunctionInstance)
      => ComCall(7, this.p, SystemVisibilityFlags, enumSystemVisibility, "Str", pszCategory, "Str", pszSubCategory, "Str", pszCategoryIdentity, IFunctionInstance.Ptr, ppIFunctionInstance)
    RemoveInstance(enumSystemVisibility, pszCategory, pszSubCategory, pszCategoryIdentity)
      => ComCall(8, this.p, SystemVisibilityFlags, enumSystemVisibility, "Str", pszCategory, "Str", pszSubCategory, "Str", pszCategoryIdentity)
}
struct IFunctionInstance extends IServiceProvider {
    static IID := "{33591C10-0BED-4F02-B0AB-1530D5533EE9}"
    GetID(ppszCoMemIdentity)
      => ComCall(4, this.p, UInt16.Ptr.Ptr, ppszCoMemIdentity)
    GetProviderInstanceID(ppszCoMemProviderInstanceIdentity)
      => ComCall(5, this.p, UInt16.Ptr.Ptr, ppszCoMemProviderInstanceIdentity)
    OpenPropertyStore(dwStgAccess, ppIPropertyStore)
      => ComCall(6, this.p, STGM, dwStgAccess, IPropertyStore.Ptr, ppIPropertyStore)
    GetCategory(ppszCoMemCategory, ppszCoMemSubCategory)
      => ComCall(7, this.p, UInt16.Ptr.Ptr, ppszCoMemCategory, UInt16.Ptr.Ptr, ppszCoMemSubCategory)
}
struct IFunctionInstanceCollection extends IUnknown {
    static IID := "{F0A3D895-855C-42A2-948D-2F97D450ECB1}"
    GetCount(pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwCount)
    Get(pszInstanceIdentity, pdwIndex, ppIFunctionInstance)
      => ComCall(4, this.p, "Str", pszInstanceIdentity, UInt32.Ptr, pdwIndex, IFunctionInstance.Ptr, ppIFunctionInstance)
    Item(dwIndex, ppIFunctionInstance)
      => ComCall(5, this.p, UInt32, dwIndex, IFunctionInstance.Ptr, ppIFunctionInstance)
    Add(pIFunctionInstance)
      => ComCall(6, this.p, IFunctionInstance, pIFunctionInstance)
    Remove(dwIndex, ppIFunctionInstance)
      => ComCall(7, this.p, UInt32, dwIndex, IFunctionInstance.Ptr, ppIFunctionInstance)
    Delete(dwIndex)
      => ComCall(8, this.p, UInt32, dwIndex)
    DeleteAll()
      => ComCall(9, this.p)
}
struct IPropertyStoreCollection extends IUnknown {
    static IID := "{D14D9C30-12D2-42D8-BCE4-C60C2BB226FA}"
    GetCount(pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwCount)
    Get(pszInstanceIdentity, pdwIndex, ppIPropertyStore)
      => ComCall(4, this.p, "Str", pszInstanceIdentity, UInt32.Ptr, pdwIndex, IPropertyStore.Ptr, ppIPropertyStore)
    Item(dwIndex, ppIPropertyStore)
      => ComCall(5, this.p, UInt32, dwIndex, IPropertyStore.Ptr, ppIPropertyStore)
    Add(pIPropertyStore)
      => ComCall(6, this.p, IPropertyStore, pIPropertyStore)
    Remove(dwIndex, pIPropertyStore)
      => ComCall(7, this.p, UInt32, dwIndex, IPropertyStore.Ptr, pIPropertyStore)
    Delete(dwIndex)
      => ComCall(8, this.p, UInt32, dwIndex)
    DeleteAll()
      => ComCall(9, this.p)
}
struct IFunctionInstanceQuery extends IUnknown {
    static IID := "{6242BC6B-90EC-4B37-BB46-E229FD84ED95}"
    Execute(ppIFunctionInstance)
      => ComCall(3, this.p, IFunctionInstance.Ptr, ppIFunctionInstance)
}
struct IFunctionInstanceCollectionQuery extends IUnknown {
    static IID := "{57CC6FD2-C09A-4289-BB72-25F04142058E}"
    AddQueryConstraint(pszConstraintName, pszConstraintValue)
      => ComCall(3, this.p, "Str", pszConstraintName, "Str", pszConstraintValue)
    AddPropertyConstraint(Key, pv, enumPropertyConstraint)
      => ComCall(4, this.p, PROPERTYKEY.Ptr, Key, PROPVARIANT.Ptr, pv, PropertyConstraint, enumPropertyConstraint)
    Execute(ppIFunctionInstanceCollection)
      => ComCall(5, this.p, IFunctionInstanceCollection.Ptr, ppIFunctionInstanceCollection)
}
struct IFunctionDiscoveryProvider extends IUnknown {
    static IID := "{DCDE394F-1478-4813-A402-F6FB10657222}"
    Initialize(pIFunctionDiscoveryProviderFactory, pIFunctionDiscoveryNotification, lcidUserDefault, pdwStgAccessCapabilities)
      => ComCall(3, this.p, IFunctionDiscoveryProviderFactory, pIFunctionDiscoveryProviderFactory, IFunctionDiscoveryNotification, pIFunctionDiscoveryNotification, UInt32, lcidUserDefault, UInt32.Ptr, pdwStgAccessCapabilities)
    Query(pIFunctionDiscoveryProviderQuery, ppIFunctionInstanceCollection)
      => ComCall(4, this.p, IFunctionDiscoveryProviderQuery, pIFunctionDiscoveryProviderQuery, IFunctionInstanceCollection.Ptr, ppIFunctionInstanceCollection)
    EndQuery()
      => ComCall(5, this.p)
    InstancePropertyStoreValidateAccess(pIFunctionInstance, iProviderInstanceContext, dwStgAccess)
      => ComCall(6, this.p, IFunctionInstance, pIFunctionInstance, IntPtr, iProviderInstanceContext, UInt32, dwStgAccess)
    InstancePropertyStoreOpen(pIFunctionInstance, iProviderInstanceContext, dwStgAccess, ppIPropertyStore)
      => ComCall(7, this.p, IFunctionInstance, pIFunctionInstance, IntPtr, iProviderInstanceContext, UInt32, dwStgAccess, IPropertyStore.Ptr, ppIPropertyStore)
    InstancePropertyStoreFlush(pIFunctionInstance, iProviderInstanceContext)
      => ComCall(8, this.p, IFunctionInstance, pIFunctionInstance, IntPtr, iProviderInstanceContext)
    InstanceQueryService(pIFunctionInstance, iProviderInstanceContext, guidService, riid, ppIUnknown)
      => ComCall(9, this.p, IFunctionInstance, pIFunctionInstance, IntPtr, iProviderInstanceContext, GUID.Ptr, guidService, GUID.Ptr, riid, IUnknown.Ptr, ppIUnknown)
    InstanceReleased(pIFunctionInstance, iProviderInstanceContext)
      => ComCall(10, this.p, IFunctionInstance, pIFunctionInstance, IntPtr, iProviderInstanceContext)
}
struct IProviderProperties extends IUnknown {
    static IID := "{CF986EA6-3B5F-4C5F-B88A-2F8B20CEEF17}"
    GetCount(pIFunctionInstance, iProviderInstanceContext, pdwCount)
      => ComCall(3, this.p, IFunctionInstance, pIFunctionInstance, IntPtr, iProviderInstanceContext, UInt32.Ptr, pdwCount)
    GetAt(pIFunctionInstance, iProviderInstanceContext, dwIndex, pKey)
      => ComCall(4, this.p, IFunctionInstance, pIFunctionInstance, IntPtr, iProviderInstanceContext, UInt32, dwIndex, PROPERTYKEY.Ptr, pKey)
    GetValue(pIFunctionInstance, iProviderInstanceContext, Key, ppropVar)
      => ComCall(5, this.p, IFunctionInstance, pIFunctionInstance, IntPtr, iProviderInstanceContext, PROPERTYKEY.Ptr, Key, PROPVARIANT.Ptr, ppropVar)
    SetValue(pIFunctionInstance, iProviderInstanceContext, Key, ppropVar)
      => ComCall(6, this.p, IFunctionInstance, pIFunctionInstance, IntPtr, iProviderInstanceContext, PROPERTYKEY.Ptr, Key, PROPVARIANT.Ptr, ppropVar)
}
struct IProviderPublishing extends IUnknown {
    static IID := "{CD1B9A04-206C-4A05-A0C8-1635A21A2B7C}"
    CreateInstance(enumVisibilityFlags, pszSubCategory, pszProviderInstanceIdentity, ppIFunctionInstance)
      => ComCall(3, this.p, SystemVisibilityFlags, enumVisibilityFlags, "Str", pszSubCategory, "Str", pszProviderInstanceIdentity, IFunctionInstance.Ptr, ppIFunctionInstance)
    RemoveInstance(enumVisibilityFlags, pszSubCategory, pszProviderInstanceIdentity)
      => ComCall(4, this.p, SystemVisibilityFlags, enumVisibilityFlags, "Str", pszSubCategory, "Str", pszProviderInstanceIdentity)
}
struct IFunctionDiscoveryProviderFactory extends IUnknown {
    static IID := "{86443FF0-1AD5-4E68-A45A-40C2C329DE3B}"
    CreatePropertyStore(ppIPropertyStore)
      => ComCall(3, this.p, IPropertyStore.Ptr, ppIPropertyStore)
    CreateInstance(pszSubCategory, pszProviderInstanceIdentity, iProviderInstanceContext, pIPropertyStore, pIFunctionDiscoveryProvider, ppIFunctionInstance)
      => ComCall(4, this.p, "Str", pszSubCategory, "Str", pszProviderInstanceIdentity, IntPtr, iProviderInstanceContext, IPropertyStore, pIPropertyStore, IFunctionDiscoveryProvider, pIFunctionDiscoveryProvider, IFunctionInstance.Ptr, ppIFunctionInstance)
    CreateFunctionInstanceCollection(ppIFunctionInstanceCollection)
      => ComCall(5, this.p, IFunctionInstanceCollection.Ptr, ppIFunctionInstanceCollection)
}
struct IFunctionDiscoveryProviderQuery extends IUnknown {
    static IID := "{6876EA98-BAEC-46DB-BC20-75A76E267A3A}"
    IsInstanceQuery(pisInstanceQuery, ppszConstraintValue)
      => ComCall(3, this.p, BOOL.Ptr, pisInstanceQuery, UInt16.Ptr.Ptr, ppszConstraintValue)
    IsSubcategoryQuery(pisSubcategoryQuery, ppszConstraintValue)
      => ComCall(4, this.p, BOOL.Ptr, pisSubcategoryQuery, UInt16.Ptr.Ptr, ppszConstraintValue)
    GetQueryConstraints(ppIProviderQueryConstraints)
      => ComCall(5, this.p, IProviderQueryConstraintCollection.Ptr, ppIProviderQueryConstraints)
    GetPropertyConstraints(ppIProviderPropertyConstraints)
      => ComCall(6, this.p, IProviderPropertyConstraintCollection.Ptr, ppIProviderPropertyConstraints)
}
struct IProviderQueryConstraintCollection extends IUnknown {
    static IID := "{9C243E11-3261-4BCD-B922-84A873D460AE}"
    GetCount(pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwCount)
    Get(pszConstraintName, ppszConstraintValue)
      => ComCall(4, this.p, "Str", pszConstraintName, UInt16.Ptr.Ptr, ppszConstraintValue)
    Item(dwIndex, ppszConstraintName, ppszConstraintValue)
      => ComCall(5, this.p, UInt32, dwIndex, UInt16.Ptr.Ptr, ppszConstraintName, UInt16.Ptr.Ptr, ppszConstraintValue)
    Next(ppszConstraintName, ppszConstraintValue)
      => ComCall(6, this.p, UInt16.Ptr.Ptr, ppszConstraintName, UInt16.Ptr.Ptr, ppszConstraintValue)
    Skip()
      => ComCall(7, this.p)
    Reset()
      => ComCall(8, this.p)
}
struct IProviderPropertyConstraintCollection extends IUnknown {
    static IID := "{F4FAE42F-5778-4A13-8540-B5FD8C1398DD}"
    GetCount(pdwCount)
      => ComCall(3, this.p, UInt32.Ptr, pdwCount)
    Get(Key, pPropVar, pdwPropertyConstraint)
      => ComCall(4, this.p, PROPERTYKEY.Ptr, Key, PROPVARIANT.Ptr, pPropVar, UInt32.Ptr, pdwPropertyConstraint)
    Item(dwIndex, pKey, pPropVar, pdwPropertyConstraint)
      => ComCall(5, this.p, UInt32, dwIndex, PROPERTYKEY.Ptr, pKey, PROPVARIANT.Ptr, pPropVar, UInt32.Ptr, pdwPropertyConstraint)
    Next(pKey, pPropVar, pdwPropertyConstraint)
      => ComCall(6, this.p, PROPERTYKEY.Ptr, pKey, PROPVARIANT.Ptr, pPropVar, UInt32.Ptr, pdwPropertyConstraint)
    Skip()
      => ComCall(7, this.p)
    Reset()
      => ComCall(8, this.p)
}
struct IFunctionDiscoveryServiceProvider extends IUnknown {
    static IID := "{4C81ED02-1B04-43F2-A451-69966CBCD1C2}"
    Initialize(pIFunctionInstance, riid, ppv)
      => ComCall(3, this.p, IFunctionInstance, pIFunctionInstance, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IPNPXAssociation extends IUnknown {
    static IID := "{0BD7E521-4DA6-42D5-81BA-1981B6B94075}"
    Associate(pszSubcategory?)
      => ComCall(3, this.p, "Str", pszSubcategory?)
    Unassociate(pszSubcategory?)
      => ComCall(4, this.p, "Str", pszSubcategory?)
    Delete(pszSubcategory?)
      => ComCall(5, this.p, "Str", pszSubcategory?)
}
struct IPNPXDeviceAssociation extends IUnknown {
    static IID := "{EED366D0-35B8-4FC5-8D20-7E5BD31F6DED}"
    Associate(pszSubCategory?, pIFunctionDiscoveryNotification?)
      => ComCall(3, this.p, "Str", pszSubCategory?, IFunctionDiscoveryNotification, pIFunctionDiscoveryNotification?)
    Unassociate(pszSubCategory?, pIFunctionDiscoveryNotification?)
      => ComCall(4, this.p, "Str", pszSubCategory?, IFunctionDiscoveryNotification, pIFunctionDiscoveryNotification?)
    Delete(pszSubcategory?, pIFunctionDiscoveryNotification?)
      => ComCall(5, this.p, "Str", pszSubcategory?, IFunctionDiscoveryNotification, pIFunctionDiscoveryNotification?)
}
