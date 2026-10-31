#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct IEventSystem extends IDispatch {
    static IID := "{4E14FB9F-2E22-11D1-9964-00C04FBBB345}"
    Query(progID, queryCriteria, errorIndex, ppInterface)
      => ComCall(7, this.p, BSTR, progID, BSTR, queryCriteria, Int32.Ptr, errorIndex, IUnknown.Ptr, ppInterface)
    Store(ProgID, pInterface)
      => ComCall(8, this.p, BSTR, ProgID, IUnknown, pInterface)
    Remove(progID, queryCriteria, errorIndex)
      => ComCall(9, this.p, BSTR, progID, BSTR, queryCriteria, Int32.Ptr, errorIndex)
    get_EventObjectChangeEventClassID(pbstrEventClassID)
      => ComCall(10, this.p, BSTR.Ptr, pbstrEventClassID)
    QueryS(progID, queryCriteria, ppInterface)
      => ComCall(11, this.p, BSTR, progID, BSTR, queryCriteria, IUnknown.Ptr, ppInterface)
    RemoveS(progID, queryCriteria)
      => ComCall(12, this.p, BSTR, progID, BSTR, queryCriteria)
}
struct IEventPublisher extends IDispatch {
    static IID := "{E341516B-2E32-11D1-9964-00C04FBBB345}"
    get_PublisherID(pbstrPublisherID)
      => ComCall(7, this.p, BSTR.Ptr, pbstrPublisherID)
    put_PublisherID(bstrPublisherID)
      => ComCall(8, this.p, BSTR, bstrPublisherID)
    get_PublisherName(pbstrPublisherName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrPublisherName)
    put_PublisherName(bstrPublisherName)
      => ComCall(10, this.p, BSTR, bstrPublisherName)
    get_PublisherType(pbstrPublisherType)
      => ComCall(11, this.p, BSTR.Ptr, pbstrPublisherType)
    put_PublisherType(bstrPublisherType)
      => ComCall(12, this.p, BSTR, bstrPublisherType)
    get_OwnerSID(pbstrOwnerSID)
      => ComCall(13, this.p, BSTR.Ptr, pbstrOwnerSID)
    put_OwnerSID(bstrOwnerSID)
      => ComCall(14, this.p, BSTR, bstrOwnerSID)
    get_Description(pbstrDescription)
      => ComCall(15, this.p, BSTR.Ptr, pbstrDescription)
    put_Description(bstrDescription)
      => ComCall(16, this.p, BSTR, bstrDescription)
    GetDefaultProperty(bstrPropertyName, propertyValue)
      => ComCall(17, this.p, BSTR, bstrPropertyName, VARIANT.Ptr, propertyValue)
    PutDefaultProperty(bstrPropertyName, propertyValue)
      => ComCall(18, this.p, BSTR, bstrPropertyName, VARIANT.Ptr, propertyValue)
    RemoveDefaultProperty(bstrPropertyName)
      => ComCall(19, this.p, BSTR, bstrPropertyName)
    GetDefaultPropertyCollection(collection)
      => ComCall(20, this.p, IEventObjectCollection.Ptr, collection)
}
struct IEventClass extends IDispatch {
    static IID := "{FB2B72A0-7A68-11D1-88F9-0080C7D771BF}"
    get_EventClassID(pbstrEventClassID)
      => ComCall(7, this.p, BSTR.Ptr, pbstrEventClassID)
    put_EventClassID(bstrEventClassID)
      => ComCall(8, this.p, BSTR, bstrEventClassID)
    get_EventClassName(pbstrEventClassName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrEventClassName)
    put_EventClassName(bstrEventClassName)
      => ComCall(10, this.p, BSTR, bstrEventClassName)
    get_OwnerSID(pbstrOwnerSID)
      => ComCall(11, this.p, BSTR.Ptr, pbstrOwnerSID)
    put_OwnerSID(bstrOwnerSID)
      => ComCall(12, this.p, BSTR, bstrOwnerSID)
    get_FiringInterfaceID(pbstrFiringInterfaceID)
      => ComCall(13, this.p, BSTR.Ptr, pbstrFiringInterfaceID)
    put_FiringInterfaceID(bstrFiringInterfaceID)
      => ComCall(14, this.p, BSTR, bstrFiringInterfaceID)
    get_Description(pbstrDescription)
      => ComCall(15, this.p, BSTR.Ptr, pbstrDescription)
    put_Description(bstrDescription)
      => ComCall(16, this.p, BSTR, bstrDescription)
    get_CustomConfigCLSID(pbstrCustomConfigCLSID)
      => ComCall(17, this.p, BSTR.Ptr, pbstrCustomConfigCLSID)
    put_CustomConfigCLSID(bstrCustomConfigCLSID)
      => ComCall(18, this.p, BSTR, bstrCustomConfigCLSID)
    get_TypeLib(pbstrTypeLib)
      => ComCall(19, this.p, BSTR.Ptr, pbstrTypeLib)
    put_TypeLib(bstrTypeLib)
      => ComCall(20, this.p, BSTR, bstrTypeLib)
}
struct IEventClass2 extends IEventClass {
    static IID := "{FB2B72A1-7A68-11D1-88F9-0080C7D771BF}"
    get_PublisherID(pbstrPublisherID)
      => ComCall(21, this.p, BSTR.Ptr, pbstrPublisherID)
    put_PublisherID(bstrPublisherID)
      => ComCall(22, this.p, BSTR, bstrPublisherID)
    get_MultiInterfacePublisherFilterCLSID(pbstrPubFilCLSID)
      => ComCall(23, this.p, BSTR.Ptr, pbstrPubFilCLSID)
    put_MultiInterfacePublisherFilterCLSID(bstrPubFilCLSID)
      => ComCall(24, this.p, BSTR, bstrPubFilCLSID)
    get_AllowInprocActivation(pfAllowInprocActivation)
      => ComCall(25, this.p, BOOL.Ptr, pfAllowInprocActivation)
    put_AllowInprocActivation(fAllowInprocActivation)
      => ComCall(26, this.p, BOOL, fAllowInprocActivation)
    get_FireInParallel(pfFireInParallel)
      => ComCall(27, this.p, BOOL.Ptr, pfFireInParallel)
    put_FireInParallel(fFireInParallel)
      => ComCall(28, this.p, BOOL, fFireInParallel)
}
struct IEventSubscription extends IDispatch {
    static IID := "{4A6B0E15-2E38-11D1-9965-00C04FBBB345}"
    get_SubscriptionID(pbstrSubscriptionID)
      => ComCall(7, this.p, BSTR.Ptr, pbstrSubscriptionID)
    put_SubscriptionID(bstrSubscriptionID)
      => ComCall(8, this.p, BSTR, bstrSubscriptionID)
    get_SubscriptionName(pbstrSubscriptionName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrSubscriptionName)
    put_SubscriptionName(bstrSubscriptionName)
      => ComCall(10, this.p, BSTR, bstrSubscriptionName)
    get_PublisherID(pbstrPublisherID)
      => ComCall(11, this.p, BSTR.Ptr, pbstrPublisherID)
    put_PublisherID(bstrPublisherID)
      => ComCall(12, this.p, BSTR, bstrPublisherID)
    get_EventClassID(pbstrEventClassID)
      => ComCall(13, this.p, BSTR.Ptr, pbstrEventClassID)
    put_EventClassID(bstrEventClassID)
      => ComCall(14, this.p, BSTR, bstrEventClassID)
    get_MethodName(pbstrMethodName)
      => ComCall(15, this.p, BSTR.Ptr, pbstrMethodName)
    put_MethodName(bstrMethodName)
      => ComCall(16, this.p, BSTR, bstrMethodName)
    get_SubscriberCLSID(pbstrSubscriberCLSID)
      => ComCall(17, this.p, BSTR.Ptr, pbstrSubscriberCLSID)
    put_SubscriberCLSID(bstrSubscriberCLSID)
      => ComCall(18, this.p, BSTR, bstrSubscriberCLSID)
    get_SubscriberInterface(ppSubscriberInterface)
      => ComCall(19, this.p, IUnknown.Ptr, ppSubscriberInterface)
    put_SubscriberInterface(pSubscriberInterface)
      => ComCall(20, this.p, IUnknown, pSubscriberInterface)
    get_PerUser(pfPerUser)
      => ComCall(21, this.p, BOOL.Ptr, pfPerUser)
    put_PerUser(fPerUser)
      => ComCall(22, this.p, BOOL, fPerUser)
    get_OwnerSID(pbstrOwnerSID)
      => ComCall(23, this.p, BSTR.Ptr, pbstrOwnerSID)
    put_OwnerSID(bstrOwnerSID)
      => ComCall(24, this.p, BSTR, bstrOwnerSID)
    get_Enabled(pfEnabled)
      => ComCall(25, this.p, BOOL.Ptr, pfEnabled)
    put_Enabled(fEnabled)
      => ComCall(26, this.p, BOOL, fEnabled)
    get_Description(pbstrDescription)
      => ComCall(27, this.p, BSTR.Ptr, pbstrDescription)
    put_Description(bstrDescription)
      => ComCall(28, this.p, BSTR, bstrDescription)
    get_MachineName(pbstrMachineName)
      => ComCall(29, this.p, BSTR.Ptr, pbstrMachineName)
    put_MachineName(bstrMachineName)
      => ComCall(30, this.p, BSTR, bstrMachineName)
    GetPublisherProperty(bstrPropertyName, propertyValue)
      => ComCall(31, this.p, BSTR, bstrPropertyName, VARIANT.Ptr, propertyValue)
    PutPublisherProperty(bstrPropertyName, propertyValue)
      => ComCall(32, this.p, BSTR, bstrPropertyName, VARIANT.Ptr, propertyValue)
    RemovePublisherProperty(bstrPropertyName)
      => ComCall(33, this.p, BSTR, bstrPropertyName)
    GetPublisherPropertyCollection(collection)
      => ComCall(34, this.p, IEventObjectCollection.Ptr, collection)
    GetSubscriberProperty(bstrPropertyName, propertyValue)
      => ComCall(35, this.p, BSTR, bstrPropertyName, VARIANT.Ptr, propertyValue)
    PutSubscriberProperty(bstrPropertyName, propertyValue)
      => ComCall(36, this.p, BSTR, bstrPropertyName, VARIANT.Ptr, propertyValue)
    RemoveSubscriberProperty(bstrPropertyName)
      => ComCall(37, this.p, BSTR, bstrPropertyName)
    GetSubscriberPropertyCollection(collection)
      => ComCall(38, this.p, IEventObjectCollection.Ptr, collection)
    get_InterfaceID(pbstrInterfaceID)
      => ComCall(39, this.p, BSTR.Ptr, pbstrInterfaceID)
    put_InterfaceID(bstrInterfaceID)
      => ComCall(40, this.p, BSTR, bstrInterfaceID)
}
struct IFiringControl extends IDispatch {
    static IID := "{E0498C93-4EFE-11D1-9971-00C04FBBB345}"
    FireSubscription(subscription)
      => ComCall(7, this.p, IEventSubscription, subscription)
}
struct IPublisherFilter extends IUnknown {
    static IID := "{465E5CC0-7B26-11D1-88FB-0080C7D771BF}"
    Initialize(methodName, dispUserDefined)
      => ComCall(3, this.p, BSTR, methodName, IDispatch, dispUserDefined)
    PrepareToFire(methodName, firingControl)
      => ComCall(4, this.p, BSTR, methodName, IFiringControl, firingControl)
}
struct IMultiInterfacePublisherFilter extends IUnknown {
    static IID := "{465E5CC1-7B26-11D1-88FB-0080C7D771BF}"
    Initialize(pEIC)
      => ComCall(3, this.p, IMultiInterfaceEventControl, pEIC)
    PrepareToFire(iid, methodName, firingControl)
      => ComCall(4, this.p, GUID.Ptr, iid, BSTR, methodName, IFiringControl, firingControl)
}
struct EOC_ChangeType extends Int32 {
    static EOC_NewObject := 0
    static EOC_ModifiedObject := 1
    static EOC_DeletedObject := 2
}
struct IEventObjectChange extends IUnknown {
    static IID := "{F4A07D70-2E25-11D1-9964-00C04FBBB345}"
    ChangedSubscription(changeType, bstrSubscriptionID)
      => ComCall(3, this.p, EOC_ChangeType, changeType, BSTR, bstrSubscriptionID)
    ChangedEventClass(changeType, bstrEventClassID)
      => ComCall(4, this.p, EOC_ChangeType, changeType, BSTR, bstrEventClassID)
    ChangedPublisher(changeType, bstrPublisherID)
      => ComCall(5, this.p, EOC_ChangeType, changeType, BSTR, bstrPublisherID)
}
struct COMEVENTSYSCHANGEINFO {
    cbSize : UInt32 := this.Size
    changeType : EOC_ChangeType
    objectId : BSTR
    partitionId : BSTR
    applicationId : BSTR
    reserved : GUID[10]
}
struct IEventObjectChange2 extends IUnknown {
    static IID := "{7701A9C3-BD68-438F-83E0-67BF4F53A422}"
    ChangedSubscription(pInfo)
      => ComCall(3, this.p, COMEVENTSYSCHANGEINFO.Ptr, pInfo)
    ChangedEventClass(pInfo)
      => ComCall(4, this.p, COMEVENTSYSCHANGEINFO.Ptr, pInfo)
}
struct IEnumEventObject extends IUnknown {
    static IID := "{F4A07D63-2E25-11D1-9964-00C04FBBB345}"
    Clone(ppInterface)
      => ComCall(3, this.p, IEnumEventObject.Ptr, ppInterface)
    Next(ppInterface, cRetElem)
      => ComCall(4, this.p, UInt32, ppInterface.Length, IUnknown.Ptr, ppInterface, UInt32.Ptr, cRetElem)
    Reset()
      => ComCall(5, this.p)
    Skip(cSkipElem)
      => ComCall(6, this.p, UInt32, cSkipElem)
}
struct IEventObjectCollection extends IDispatch {
    static IID := "{F89AC270-D4EB-11D1-B682-00805FC79216}"
    get__NewEnum(ppUnkEnum)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnkEnum)
    get_Item(objectID, pItem)
      => ComCall(8, this.p, BSTR, objectID, VARIANT.Ptr, pItem)
    get_NewEnum(ppEnum)
      => ComCall(9, this.p, IEnumEventObject.Ptr, ppEnum)
    get_Count(pCount)
      => ComCall(10, this.p, Int32.Ptr, pCount)
    Add(item, objectID)
      => ComCall(11, this.p, VARIANT.Ptr, item, BSTR, objectID)
    Remove(objectID)
      => ComCall(12, this.p, BSTR, objectID)
}
struct IEventProperty extends IDispatch {
    static IID := "{DA538EE2-F4DE-11D1-B6BB-00805FC79216}"
    get_Name(propertyName)
      => ComCall(7, this.p, BSTR.Ptr, propertyName)
    put_Name(propertyName)
      => ComCall(8, this.p, BSTR, propertyName)
    get_Value(propertyValue)
      => ComCall(9, this.p, VARIANT.Ptr, propertyValue)
    put_Value(propertyValue)
      => ComCall(10, this.p, VARIANT.Ptr, propertyValue)
}
struct IEventControl extends IDispatch {
    static IID := "{0343E2F4-86F6-11D1-B760-00C04FB926AF}"
    SetPublisherFilter(methodName, pPublisherFilter)
      => ComCall(7, this.p, BSTR, methodName, IPublisherFilter, pPublisherFilter)
    get_AllowInprocActivation(pfAllowInprocActivation)
      => ComCall(8, this.p, BOOL.Ptr, pfAllowInprocActivation)
    put_AllowInprocActivation(fAllowInprocActivation)
      => ComCall(9, this.p, BOOL, fAllowInprocActivation)
    GetSubscriptions(methodName, optionalCriteria, optionalErrorIndex, ppCollection)
      => ComCall(10, this.p, BSTR, methodName, BSTR, optionalCriteria, Int32.Ptr, optionalErrorIndex, IEventObjectCollection.Ptr, ppCollection)
    SetDefaultQuery(methodName, criteria, errorIndex)
      => ComCall(11, this.p, BSTR, methodName, BSTR, criteria, Int32.Ptr, errorIndex)
}
struct IMultiInterfaceEventControl extends IUnknown {
    static IID := "{0343E2F5-86F6-11D1-B760-00C04FB926AF}"
    SetMultiInterfacePublisherFilter(classFilter)
      => ComCall(3, this.p, IMultiInterfacePublisherFilter, classFilter)
    GetSubscriptions(eventIID, bstrMethodName, optionalCriteria, optionalErrorIndex, ppCollection)
      => ComCall(4, this.p, GUID.Ptr, eventIID, BSTR, bstrMethodName, BSTR, optionalCriteria, Int32.Ptr, optionalErrorIndex, IEventObjectCollection.Ptr, ppCollection)
    SetDefaultQuery(eventIID, bstrMethodName, bstrCriteria, errorIndex)
      => ComCall(5, this.p, GUID.Ptr, eventIID, BSTR, bstrMethodName, BSTR, bstrCriteria, Int32.Ptr, errorIndex)
    get_AllowInprocActivation(pfAllowInprocActivation)
      => ComCall(6, this.p, BOOL.Ptr, pfAllowInprocActivation)
    put_AllowInprocActivation(fAllowInprocActivation)
      => ComCall(7, this.p, BOOL, fAllowInprocActivation)
    get_FireInParallel(pfFireInParallel)
      => ComCall(8, this.p, BOOL.Ptr, pfFireInParallel)
    put_FireInParallel(fFireInParallel)
      => ComCall(9, this.p, BOOL, fFireInParallel)
}
struct IDontSupportEventSubscription extends IUnknown {
    static IID := "{784121F1-62A6-4B89-855F-D65F296DE83A}"
}
