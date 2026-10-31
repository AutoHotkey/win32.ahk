#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HMODULE, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct WcmTargetMode extends Int32 {
    static OfflineMode := 1
    static OnlineMode := 2
}
struct WcmNamespaceEnumerationFlags extends Int32 {
    static SharedEnumeration := 1
    static UserEnumeration := 2
    static AllEnumeration := 3
}
struct WcmDataType extends Int32 {
    static dataTypeByte := 1
    static dataTypeSByte := 2
    static dataTypeUInt16 := 3
    static dataTypeInt16 := 4
    static dataTypeUInt32 := 5
    static dataTypeInt32 := 6
    static dataTypeUInt64 := 7
    static dataTypeInt64 := 8
    static dataTypeBoolean := 11
    static dataTypeString := 12
    static dataTypeFlagArray := 32768
}
struct WcmSettingType extends Int32 {
    static settingTypeScalar := 1
    static settingTypeComplex := 2
    static settingTypeList := 3
}
struct WcmRestrictionFacets extends Int32 {
    static restrictionFacetMaxLength := 1
    static restrictionFacetEnumeration := 2
    static restrictionFacetMaxInclusive := 4
    static restrictionFacetMinInclusive := 8
}
struct WcmUserStatus extends Int32 {
    static UnknownStatus := 0
    static UserRegistered := 1
    static UserUnregistered := 2
    static UserLoaded := 3
    static UserUnloaded := 4
}
struct WcmNamespaceAccess extends Int32 {
    static ReadOnlyAccess := 1
    static ReadWriteAccess := 2
}
struct IItemEnumerator extends IUnknown {
    static IID := "{9F7D7BB7-20B3-11DA-81A5-0030F1642E3C}"
    Current(Item)
      => ComCall(3, this.p, VARIANT.Ptr, Item)
    MoveNext(ItemValid)
      => ComCall(4, this.p, BOOL.Ptr, ItemValid)
    Reset()
      => ComCall(5, this.p)
}
struct ISettingsIdentity extends IUnknown {
    static IID := "{9F7D7BB6-20B3-11DA-81A5-0030F1642E3C}"
    GetAttribute(Reserved, Name, Value)
      => ComCall(3, this.p, Struct.Ptr, Reserved, "Str", Name, BSTR.Ptr, Value)
    SetAttribute(Reserved, Name, Value)
      => ComCall(4, this.p, Struct.Ptr, Reserved, "Str", Name, "Str", Value)
    GetFlags(Flags)
      => ComCall(5, this.p, UInt32.Ptr, Flags)
    SetFlags(Flags)
      => ComCall(6, this.p, UInt32, Flags)
}
struct ITargetInfo extends IUnknown {
    static IID := "{9F7D7BB8-20B3-11DA-81A5-0030F1642E3C}"
    GetTargetMode(TargetMode)
      => ComCall(3, this.p, WcmTargetMode.Ptr, TargetMode)
    SetTargetMode(TargetMode)
      => ComCall(4, this.p, WcmTargetMode, TargetMode)
    GetTemporaryStoreLocation(TemporaryStoreLocation)
      => ComCall(5, this.p, BSTR.Ptr, TemporaryStoreLocation)
    SetTemporaryStoreLocation(TemporaryStoreLocation)
      => ComCall(6, this.p, "Str", TemporaryStoreLocation)
    GetTargetID(TargetID)
      => ComCall(7, this.p, BSTR.Ptr, TargetID)
    SetTargetID(TargetID)
      => ComCall(8, this.p, GUID, TargetID)
    GetTargetProcessorArchitecture(ProcessorArchitecture)
      => ComCall(9, this.p, BSTR.Ptr, ProcessorArchitecture)
    SetTargetProcessorArchitecture(ProcessorArchitecture)
      => ComCall(10, this.p, "Str", ProcessorArchitecture)
    GetProperty(Offline, Property, Value)
      => ComCall(11, this.p, BOOL, Offline, "Str", Property, BSTR.Ptr, Value)
    SetProperty(Offline, Property, Value)
      => ComCall(12, this.p, BOOL, Offline, "Str", Property, "Str", Value)
    GetEnumerator(Enumerator)
      => ComCall(13, this.p, IItemEnumerator.Ptr, Enumerator)
    ExpandTarget(Offline, Location, ExpandedLocation)
      => ComCall(14, this.p, BOOL, Offline, "Str", Location, BSTR.Ptr, ExpandedLocation)
    ExpandTargetPath(Offline, Location, ExpandedLocation)
      => ComCall(15, this.p, BOOL, Offline, "Str", Location, BSTR.Ptr, ExpandedLocation)
    SetModulePath(Module, Path)
      => ComCall(16, this.p, "Str", Module, "Str", Path)
    LoadModule(Module, ModuleHandle)
      => ComCall(17, this.p, "Str", Module, HMODULE.Ptr, ModuleHandle)
    SetWow64Context(InstallerModule, Wow64Context)
      => ComCall(18, this.p, "Str", InstallerModule, UInt8.Ptr, Wow64Context)
    TranslateWow64(ClientArchitecture, Value, TranslatedValue)
      => ComCall(19, this.p, "Str", ClientArchitecture, "Str", Value, BSTR.Ptr, TranslatedValue)
    SetSchemaHiveLocation(pwzHiveDir)
      => ComCall(20, this.p, "Str", pwzHiveDir)
    GetSchemaHiveLocation(pHiveLocation)
      => ComCall(21, this.p, BSTR.Ptr, pHiveLocation)
    SetSchemaHiveMountName(pwzMountName)
      => ComCall(22, this.p, "Str", pwzMountName)
    GetSchemaHiveMountName(pMountName)
      => ComCall(23, this.p, BSTR.Ptr, pMountName)
}
struct ISettingsEngine extends IUnknown {
    static IID := "{9F7D7BB9-20B3-11DA-81A5-0030F1642E3C}"
    GetNamespaces(Flags, Reserved, Namespaces)
      => ComCall(3, this.p, WcmNamespaceEnumerationFlags, Flags, Struct.Ptr, Reserved, IItemEnumerator.Ptr, Namespaces)
    GetNamespace(SettingsID, Access, Reserved, NamespaceItem)
      => ComCall(4, this.p, ISettingsIdentity, SettingsID, WcmNamespaceAccess, Access, Struct.Ptr, Reserved, ISettingsNamespace.Ptr, NamespaceItem)
    GetErrorDescription(HResult, Message)
      => ComCall(5, this.p, Int32, HResult, BSTR.Ptr, Message)
    CreateSettingsIdentity(SettingsID)
      => ComCall(6, this.p, ISettingsIdentity.Ptr, SettingsID)
    GetStoreStatus(Reserved, Status)
      => ComCall(7, this.p, Struct.Ptr, Reserved, WcmUserStatus.Ptr, Status)
    LoadStore(Flags)
      => ComCall(8, this.p, UInt32, Flags)
    UnloadStore(Reserved)
      => ComCall(9, this.p, Struct.Ptr, Reserved)
    RegisterNamespace(SettingsID, Stream, PushSettings, Results)
      => ComCall(10, this.p, ISettingsIdentity, SettingsID, IStream, Stream, BOOL, PushSettings, VARIANT.Ptr, Results)
    UnregisterNamespace(SettingsID, RemoveSettings)
      => ComCall(11, this.p, ISettingsIdentity, SettingsID, BOOL, RemoveSettings)
    CreateTargetInfo(Target)
      => ComCall(12, this.p, ITargetInfo.Ptr, Target)
    GetTargetInfo(Target)
      => ComCall(13, this.p, ITargetInfo.Ptr, Target)
    SetTargetInfo(Target)
      => ComCall(14, this.p, ITargetInfo, Target)
    CreateSettingsContext(Flags, Reserved, SettingsContext)
      => ComCall(15, this.p, UInt32, Flags, Struct.Ptr, Reserved, ISettingsContext.Ptr, SettingsContext)
    SetSettingsContext(SettingsContext)
      => ComCall(16, this.p, ISettingsContext, SettingsContext)
    ApplySettingsContext(SettingsContext, pppwzIdentities, pcIdentities)
      => ComCall(17, this.p, ISettingsContext, SettingsContext, PWSTR.Ptr.Ptr, pppwzIdentities, IntPtr.Ptr, pcIdentities)
    GetSettingsContext(SettingsContext)
      => ComCall(18, this.p, ISettingsContext.Ptr, SettingsContext)
}
struct ISettingsItem extends IUnknown {
    static IID := "{9F7D7BBB-20B3-11DA-81A5-0030F1642E3C}"
    GetName(Name)
      => ComCall(3, this.p, BSTR.Ptr, Name)
    GetValue(Value)
      => ComCall(4, this.p, VARIANT.Ptr, Value)
    SetValue(Value)
      => ComCall(5, this.p, VARIANT.Ptr, Value)
    GetSettingType(Type)
      => ComCall(6, this.p, WcmSettingType.Ptr, Type)
    GetDataType(Type)
      => ComCall(7, this.p, WcmDataType.Ptr, Type)
    GetValueRaw(Data)
      => ComCall(8, this.p, UInt8.Ptr.Ptr, Data, UInt32.Ptr, Data.Length)
    SetValueRaw(DataType, Data)
      => ComCall(9, this.p, Int32, DataType, UInt8.Ptr, Data, UInt32, Data.Length)
    HasChild(ItemHasChild)
      => ComCall(10, this.p, BOOL.Ptr, ItemHasChild)
    Children(Children)
      => ComCall(11, this.p, IItemEnumerator.Ptr, Children)
    GetChild(Name, Child)
      => ComCall(12, this.p, "Str", Name, ISettingsItem.Ptr, Child)
    GetSettingByPath(Path, Setting)
      => ComCall(13, this.p, "Str", Path, ISettingsItem.Ptr, Setting)
    CreateSettingByPath(Path, Setting)
      => ComCall(14, this.p, "Str", Path, ISettingsItem.Ptr, Setting)
    RemoveSettingByPath(Path)
      => ComCall(15, this.p, "Str", Path)
    GetListKeyInformation(KeyName, DataType)
      => ComCall(16, this.p, BSTR.Ptr, KeyName, WcmDataType.Ptr, DataType)
    CreateListElement(KeyData, Child)
      => ComCall(17, this.p, VARIANT.Ptr, KeyData, ISettingsItem.Ptr, Child)
    RemoveListElement(ElementName)
      => ComCall(18, this.p, "Str", ElementName)
    Attributes(Attributes)
      => ComCall(19, this.p, IItemEnumerator.Ptr, Attributes)
    GetAttribute(Name, Value)
      => ComCall(20, this.p, "Str", Name, VARIANT.Ptr, Value)
    GetPath(Path)
      => ComCall(21, this.p, BSTR.Ptr, Path)
    GetRestrictionFacets(RestrictionFacets)
      => ComCall(22, this.p, WcmRestrictionFacets.Ptr, RestrictionFacets)
    GetRestriction(RestrictionFacet, FacetData)
      => ComCall(23, this.p, WcmRestrictionFacets, RestrictionFacet, VARIANT.Ptr, FacetData)
    GetKeyValue(Value)
      => ComCall(24, this.p, VARIANT.Ptr, Value)
}
struct ISettingsNamespace extends IUnknown {
    static IID := "{9F7D7BBA-20B3-11DA-81A5-0030F1642E3C}"
    GetIdentity(SettingsID)
      => ComCall(3, this.p, ISettingsIdentity.Ptr, SettingsID)
    Settings(Settings)
      => ComCall(4, this.p, IItemEnumerator.Ptr, Settings)
    Save(PushSettings, Result)
      => ComCall(5, this.p, BOOL, PushSettings, ISettingsResult.Ptr, Result)
    GetSettingByPath(Path, Setting)
      => ComCall(6, this.p, "Str", Path, ISettingsItem.Ptr, Setting)
    CreateSettingByPath(Path, Setting)
      => ComCall(7, this.p, "Str", Path, ISettingsItem.Ptr, Setting)
    RemoveSettingByPath(Path)
      => ComCall(8, this.p, "Str", Path)
    GetAttribute(Name, Value)
      => ComCall(9, this.p, "Str", Name, VARIANT.Ptr, Value)
}
struct ISettingsResult extends IUnknown {
    static IID := "{9F7D7BBC-20B3-11DA-81A5-0030F1642E3C}"
    GetDescription(description)
      => ComCall(3, this.p, BSTR.Ptr, description)
    GetErrorCode(hrOut)
      => ComCall(4, this.p, HRESULT.Ptr, hrOut)
    GetContextDescription(description)
      => ComCall(5, this.p, BSTR.Ptr, description)
    GetLine(dwLine)
      => ComCall(6, this.p, UInt32.Ptr, dwLine)
    GetColumn(dwColumn)
      => ComCall(7, this.p, UInt32.Ptr, dwColumn)
    GetSource(file)
      => ComCall(8, this.p, BSTR.Ptr, file)
}
struct ISettingsContext extends IUnknown {
    static IID := "{9F7D7BBD-20B3-11DA-81A5-0030F1642E3C}"
    Serialize(pStream, pTarget)
      => ComCall(3, this.p, IStream, pStream, ITargetInfo, pTarget)
    Deserialize(pStream, pTarget, pppResults)
      => ComCall(4, this.p, IStream, pStream, ITargetInfo, pTarget, ISettingsResult.Ptr.Ptr, pppResults, IntPtr.Ptr, pppResults.Length)
    SetUserData(pUserData)
      => ComCall(5, this.p, Struct.Ptr, pUserData)
    GetUserData(pUserData)
      => ComCall(6, this.p, Struct.Ptr.Ptr, pUserData)
    GetNamespaces(ppNamespaceIds)
      => ComCall(7, this.p, IItemEnumerator.Ptr, ppNamespaceIds)
    GetStoredSettings(pIdentity, ppAddedSettings, ppModifiedSettings, ppDeletedSettings)
      => ComCall(8, this.p, ISettingsIdentity, pIdentity, IItemEnumerator.Ptr, ppAddedSettings, IItemEnumerator.Ptr, ppModifiedSettings, IItemEnumerator.Ptr, ppDeletedSettings)
    RevertSetting(pIdentity, pwzSetting)
      => ComCall(9, this.p, ISettingsIdentity, pIdentity, "Str", pwzSetting)
}
