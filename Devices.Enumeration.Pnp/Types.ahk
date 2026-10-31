#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, PWSTR, VARIANT_BOOL}
#Import "..\Security\Types.ahk" {SECURITY_DESCRIPTOR}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct HSWDEVICE {
    Value : IntPtr
}
struct SW_DEVICE_CAPABILITIES extends Int32 {
    static SWDeviceCapabilitiesNone := 0
    static SWDeviceCapabilitiesRemovable := 1
    static SWDeviceCapabilitiesSilentInstall := 2
    static SWDeviceCapabilitiesNoDisplayInUI := 4
    static SWDeviceCapabilitiesDriverRequired := 8
}
struct SW_DEVICE_CREATE_INFO {
    cbSize : UInt32 := this.Size
    pszInstanceId : PWSTR
    pszzHardwareIds : PWSTR
    pszzCompatibleIds : PWSTR
    pContainerId : GUID.Ptr
    CapabilityFlags : UInt32
    pszDeviceDescription : PWSTR
    pszDeviceLocation : PWSTR
    pSecurityDescriptor : SECURITY_DESCRIPTOR.Ptr
}
struct SW_DEVICE_LIFETIME extends Int32 {
    static SWDeviceLifetimeHandle := 0
    static SWDeviceLifetimeParentPresent := 1
    static SWDeviceLifetimeMax := 2
}
struct SW_DEVICE_CREATE_CALLBACK extends FunctionPointer {
    static Types := [HSWDEVICE, HRESULT, Struct.Ptr, PWSTR, "Void"]
}
struct IUPnPDeviceFinder extends IDispatch {
    static IID := "{ADDA3D55-6F72-4319-BFF9-18600A539B10}"
    FindByType(bstrTypeURI, dwFlags, pDevices)
      => ComCall(7, this.p, BSTR, bstrTypeURI, UInt32, dwFlags, IUPnPDevices.Ptr, pDevices)
    CreateAsyncFind(bstrTypeURI, dwFlags, punkDeviceFinderCallback, plFindData)
      => ComCall(8, this.p, BSTR, bstrTypeURI, UInt32, dwFlags, IUnknown, punkDeviceFinderCallback, Int32.Ptr, plFindData)
    StartAsyncFind(lFindData)
      => ComCall(9, this.p, Int32, lFindData)
    CancelAsyncFind(lFindData)
      => ComCall(10, this.p, Int32, lFindData)
    FindByUDN(bstrUDN, pDevice)
      => ComCall(11, this.p, BSTR, bstrUDN, IUPnPDevice.Ptr, pDevice)
}
struct IUPnPAddressFamilyControl extends IUnknown {
    static IID := "{E3BF6178-694E-459F-A5A6-191EA0FFA1C7}"
    SetAddressFamily(dwFlags)
      => ComCall(3, this.p, Int32, dwFlags)
    GetAddressFamily(pdwFlags)
      => ComCall(4, this.p, Int32.Ptr, pdwFlags)
}
struct IUPnPHttpHeaderControl extends IUnknown {
    static IID := "{0405AF4F-8B5C-447C-80F2-B75984A31F3C}"
    AddRequestHeaders(bstrHttpHeaders)
      => ComCall(3, this.p, BSTR, bstrHttpHeaders)
}
struct IUPnPDeviceFinderCallback extends IUnknown {
    static IID := "{415A984A-88B3-49F3-92AF-0508BEDF0D6C}"
    DeviceAdded(lFindData, pDevice)
      => ComCall(3, this.p, Int32, lFindData, IUPnPDevice, pDevice)
    DeviceRemoved(lFindData, bstrUDN)
      => ComCall(4, this.p, Int32, lFindData, BSTR, bstrUDN)
    SearchComplete(lFindData)
      => ComCall(5, this.p, Int32, lFindData)
}
struct IUPnPServices extends IDispatch {
    static IID := "{3F8C8E9E-9A7A-4DC8-BC41-FF31FA374956}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(ppunk)
      => ComCall(8, this.p, IUnknown.Ptr, ppunk)
    get_Item(bstrServiceId, ppService)
      => ComCall(9, this.p, BSTR, bstrServiceId, IUPnPService.Ptr, ppService)
}
struct IUPnPService extends IDispatch {
    static IID := "{A295019C-DC65-47DD-90DC-7FE918A1AB44}"
    QueryStateVariable(bstrVariableName, pValue)
      => ComCall(7, this.p, BSTR, bstrVariableName, VARIANT.Ptr, pValue)
    InvokeAction(bstrActionName, vInActionArgs, pvOutActionArgs, pvRetVal)
      => ComCall(8, this.p, BSTR, bstrActionName, VARIANT, vInActionArgs, VARIANT.Ptr, pvOutActionArgs, VARIANT.Ptr, pvRetVal)
    get_ServiceTypeIdentifier(pVal)
      => ComCall(9, this.p, BSTR.Ptr, pVal)
    AddCallback(pUnkCallback)
      => ComCall(10, this.p, IUnknown, pUnkCallback)
    get_Id(pbstrId)
      => ComCall(11, this.p, BSTR.Ptr, pbstrId)
    get_LastTransportStatus(plValue)
      => ComCall(12, this.p, Int32.Ptr, plValue)
}
struct IUPnPAsyncResult extends IUnknown {
    static IID := "{4D65FD08-D13E-4274-9C8B-DD8D028C8644}"
    AsyncOperationComplete(ullRequestID)
      => ComCall(3, this.p, Int64, ullRequestID)
}
struct IUPnPServiceAsync extends IUnknown {
    static IID := "{098BDAF5-5EC1-49E7-A260-B3A11DD8680C}"
    BeginInvokeAction(bstrActionName, vInActionArgs, pAsyncResult, pullRequestID)
      => ComCall(3, this.p, BSTR, bstrActionName, VARIANT, vInActionArgs, IUPnPAsyncResult, pAsyncResult, Int64.Ptr, pullRequestID)
    EndInvokeAction(ullRequestID, pvOutActionArgs, pvRetVal)
      => ComCall(4, this.p, Int64, ullRequestID, VARIANT.Ptr, pvOutActionArgs, VARIANT.Ptr, pvRetVal)
    BeginQueryStateVariable(bstrVariableName, pAsyncResult, pullRequestID)
      => ComCall(5, this.p, BSTR, bstrVariableName, IUPnPAsyncResult, pAsyncResult, Int64.Ptr, pullRequestID)
    EndQueryStateVariable(ullRequestID, pValue)
      => ComCall(6, this.p, Int64, ullRequestID, VARIANT.Ptr, pValue)
    BeginSubscribeToEvents(pUnkCallback, pAsyncResult, pullRequestID)
      => ComCall(7, this.p, IUnknown, pUnkCallback, IUPnPAsyncResult, pAsyncResult, Int64.Ptr, pullRequestID)
    EndSubscribeToEvents(ullRequestID)
      => ComCall(8, this.p, Int64, ullRequestID)
    BeginSCPDDownload(pAsyncResult, pullRequestID)
      => ComCall(9, this.p, IUPnPAsyncResult, pAsyncResult, Int64.Ptr, pullRequestID)
    EndSCPDDownload(ullRequestID, pbstrSCPDDoc)
      => ComCall(10, this.p, Int64, ullRequestID, BSTR.Ptr, pbstrSCPDDoc)
    CancelAsyncOperation(ullRequestID)
      => ComCall(11, this.p, Int64, ullRequestID)
}
struct IUPnPServiceCallback extends IUnknown {
    static IID := "{31FADCA9-AB73-464B-B67D-5C1D0F83C8B8}"
    StateVariableChanged(pus, pcwszStateVarName, vaValue)
      => ComCall(3, this.p, IUPnPService, pus, "Str", pcwszStateVarName, VARIANT, vaValue)
    ServiceInstanceDied(pus)
      => ComCall(4, this.p, IUPnPService, pus)
}
struct IUPnPServiceEnumProperty extends IUnknown {
    static IID := "{38873B37-91BB-49F4-B249-2E8EFBB8A816}"
    SetServiceEnumProperty(dwMask)
      => ComCall(3, this.p, UInt32, dwMask)
}
struct IUPnPServiceDocumentAccess extends IUnknown {
    static IID := "{21905529-0A5E-4589-825D-7E6D87EA6998}"
    GetDocumentURL(pbstrDocUrl)
      => ComCall(3, this.p, BSTR.Ptr, pbstrDocUrl)
    GetDocument(pbstrDoc)
      => ComCall(4, this.p, BSTR.Ptr, pbstrDoc)
}
struct IUPnPDevices extends IDispatch {
    static IID := "{FDBC0C73-BDA3-4C66-AC4F-F2D96FDAD68C}"
    get_Count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get__NewEnum(ppunk)
      => ComCall(8, this.p, IUnknown.Ptr, ppunk)
    get_Item(bstrUDN, ppDevice)
      => ComCall(9, this.p, BSTR, bstrUDN, IUPnPDevice.Ptr, ppDevice)
}
struct IUPnPDevice extends IDispatch {
    static IID := "{3D44D0D1-98C9-4889-ACD1-F9D674BF2221}"
    get_IsRootDevice(pvarb)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pvarb)
    get_RootDevice(ppudRootDevice)
      => ComCall(8, this.p, IUPnPDevice.Ptr, ppudRootDevice)
    get_ParentDevice(ppudDeviceParent)
      => ComCall(9, this.p, IUPnPDevice.Ptr, ppudDeviceParent)
    get_HasChildren(pvarb)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pvarb)
    get_Children(ppudChildren)
      => ComCall(11, this.p, IUPnPDevices.Ptr, ppudChildren)
    get_UniqueDeviceName(pbstr)
      => ComCall(12, this.p, BSTR.Ptr, pbstr)
    get_FriendlyName(pbstr)
      => ComCall(13, this.p, BSTR.Ptr, pbstr)
    get_Type(pbstr)
      => ComCall(14, this.p, BSTR.Ptr, pbstr)
    get_PresentationURL(pbstr)
      => ComCall(15, this.p, BSTR.Ptr, pbstr)
    get_ManufacturerName(pbstr)
      => ComCall(16, this.p, BSTR.Ptr, pbstr)
    get_ManufacturerURL(pbstr)
      => ComCall(17, this.p, BSTR.Ptr, pbstr)
    get_ModelName(pbstr)
      => ComCall(18, this.p, BSTR.Ptr, pbstr)
    get_ModelNumber(pbstr)
      => ComCall(19, this.p, BSTR.Ptr, pbstr)
    get_Description(pbstr)
      => ComCall(20, this.p, BSTR.Ptr, pbstr)
    get_ModelURL(pbstr)
      => ComCall(21, this.p, BSTR.Ptr, pbstr)
    get_UPC(pbstr)
      => ComCall(22, this.p, BSTR.Ptr, pbstr)
    get_SerialNumber(pbstr)
      => ComCall(23, this.p, BSTR.Ptr, pbstr)
    IconURL(bstrEncodingFormat, lSizeX, lSizeY, lBitDepth, pbstrIconURL)
      => ComCall(24, this.p, BSTR, bstrEncodingFormat, Int32, lSizeX, Int32, lSizeY, Int32, lBitDepth, BSTR.Ptr, pbstrIconURL)
    get_Services(ppusServices)
      => ComCall(25, this.p, IUPnPServices.Ptr, ppusServices)
}
struct IUPnPDeviceDocumentAccess extends IUnknown {
    static IID := "{E7772804-3287-418E-9072-CF2B47238981}"
    GetDocumentURL(pbstrDocument)
      => ComCall(3, this.p, BSTR.Ptr, pbstrDocument)
}
struct IUPnPDeviceDocumentAccessEx extends IUnknown {
    static IID := "{C4BC4050-6178-4BD1-A4B8-6398321F3247}"
    GetDocument(pbstrDocument)
      => ComCall(3, this.p, BSTR.Ptr, pbstrDocument)
}
struct IUPnPDescriptionDocument extends IDispatch {
    static IID := "{11D1C1B2-7DAA-4C9E-9595-7F82ED206D1E}"
    get_ReadyState(plReadyState)
      => ComCall(7, this.p, Int32.Ptr, plReadyState)
    Load(bstrUrl)
      => ComCall(8, this.p, BSTR, bstrUrl)
    LoadAsync(bstrUrl, punkCallback)
      => ComCall(9, this.p, BSTR, bstrUrl, IUnknown, punkCallback)
    get_LoadResult(phrError)
      => ComCall(10, this.p, Int32.Ptr, phrError)
    Abort()
      => ComCall(11, this.p)
    RootDevice(ppudRootDevice)
      => ComCall(12, this.p, IUPnPDevice.Ptr, ppudRootDevice)
    DeviceByUDN(bstrUDN, ppudDevice)
      => ComCall(13, this.p, BSTR, bstrUDN, IUPnPDevice.Ptr, ppudDevice)
}
struct IUPnPDeviceFinderAddCallbackWithInterface extends IUnknown {
    static IID := "{983DFC0B-1796-44DF-8975-CA545B620EE5}"
    DeviceAddedWithInterface(lFindData, pDevice, pguidInterface)
      => ComCall(3, this.p, Int32, lFindData, IUPnPDevice, pDevice, GUID.Ptr, pguidInterface)
}
struct IUPnPDescriptionDocumentCallback extends IUnknown {
    static IID := "{77394C69-5486-40D6-9BC3-4991983E02DA}"
    LoadComplete(hrLoadResult)
      => ComCall(3, this.p, HRESULT, hrLoadResult)
}
struct IUPnPEventSink extends IUnknown {
    static IID := "{204810B4-73B2-11D4-BF42-00B0D0118B56}"
    OnStateChanged(rgdispidChanges)
      => ComCall(3, this.p, UInt32, rgdispidChanges.Length, Int32.Ptr, rgdispidChanges)
    OnStateChangedSafe(varsadispidChanges)
      => ComCall(4, this.p, VARIANT, varsadispidChanges)
}
struct IUPnPEventSource extends IUnknown {
    static IID := "{204810B5-73B2-11D4-BF42-00B0D0118B56}"
    Advise(pesSubscriber)
      => ComCall(3, this.p, IUPnPEventSink, pesSubscriber)
    Unadvise(pesSubscriber)
      => ComCall(4, this.p, IUPnPEventSink, pesSubscriber)
}
struct IUPnPRegistrar extends IUnknown {
    static IID := "{204810B6-73B2-11D4-BF42-00B0D0118B56}"
    RegisterDevice(bstrXMLDesc, bstrProgIDDeviceControlClass, bstrInitString, bstrContainerId, bstrResourcePath, nLifeTime, pbstrDeviceIdentifier)
      => ComCall(3, this.p, BSTR, bstrXMLDesc, BSTR, bstrProgIDDeviceControlClass, BSTR, bstrInitString, BSTR, bstrContainerId, BSTR, bstrResourcePath, Int32, nLifeTime, BSTR.Ptr, pbstrDeviceIdentifier)
    RegisterRunningDevice(bstrXMLDesc, punkDeviceControl, bstrInitString, bstrResourcePath, nLifeTime, pbstrDeviceIdentifier)
      => ComCall(4, this.p, BSTR, bstrXMLDesc, IUnknown, punkDeviceControl, BSTR, bstrInitString, BSTR, bstrResourcePath, Int32, nLifeTime, BSTR.Ptr, pbstrDeviceIdentifier)
    RegisterDeviceProvider(bstrProviderName, bstrProgIDProviderClass, bstrInitString, bstrContainerId)
      => ComCall(5, this.p, BSTR, bstrProviderName, BSTR, bstrProgIDProviderClass, BSTR, bstrInitString, BSTR, bstrContainerId)
    GetUniqueDeviceName(bstrDeviceIdentifier, bstrTemplateUDN, pbstrUDN)
      => ComCall(6, this.p, BSTR, bstrDeviceIdentifier, BSTR, bstrTemplateUDN, BSTR.Ptr, pbstrUDN)
    UnregisterDevice(bstrDeviceIdentifier, fPermanent)
      => ComCall(7, this.p, BSTR, bstrDeviceIdentifier, BOOL, fPermanent)
    UnregisterDeviceProvider(bstrProviderName)
      => ComCall(8, this.p, BSTR, bstrProviderName)
}
struct IUPnPReregistrar extends IUnknown {
    static IID := "{204810B7-73B2-11D4-BF42-00B0D0118B56}"
    ReregisterDevice(bstrDeviceIdentifier, bstrXMLDesc, bstrProgIDDeviceControlClass, bstrInitString, bstrContainerId, bstrResourcePath, nLifeTime)
      => ComCall(3, this.p, BSTR, bstrDeviceIdentifier, BSTR, bstrXMLDesc, BSTR, bstrProgIDDeviceControlClass, BSTR, bstrInitString, BSTR, bstrContainerId, BSTR, bstrResourcePath, Int32, nLifeTime)
    ReregisterRunningDevice(bstrDeviceIdentifier, bstrXMLDesc, punkDeviceControl, bstrInitString, bstrResourcePath, nLifeTime)
      => ComCall(4, this.p, BSTR, bstrDeviceIdentifier, BSTR, bstrXMLDesc, IUnknown, punkDeviceControl, BSTR, bstrInitString, BSTR, bstrResourcePath, Int32, nLifeTime)
}
struct IUPnPDeviceControl extends IUnknown {
    static IID := "{204810BA-73B2-11D4-BF42-00B0D0118B56}"
    Initialize(bstrXMLDesc, bstrDeviceIdentifier, bstrInitString)
      => ComCall(3, this.p, BSTR, bstrXMLDesc, BSTR, bstrDeviceIdentifier, BSTR, bstrInitString)
    GetServiceObject(bstrUDN, bstrServiceId, ppdispService)
      => ComCall(4, this.p, BSTR, bstrUDN, BSTR, bstrServiceId, IDispatch.Ptr, ppdispService)
}
struct IUPnPDeviceControlHttpHeaders extends IUnknown {
    static IID := "{204810BB-73B2-11D4-BF42-00B0D0118B56}"
    GetAdditionalResponseHeaders(bstrHttpResponseHeaders)
      => ComCall(3, this.p, BSTR.Ptr, bstrHttpResponseHeaders)
}
struct IUPnPDeviceProvider extends IUnknown {
    static IID := "{204810B8-73B2-11D4-BF42-00B0D0118B56}"
    Start(bstrInitString)
      => ComCall(3, this.p, BSTR, bstrInitString)
    Stop()
      => ComCall(4, this.p)
}
struct IUPnPRemoteEndpointInfo extends IUnknown {
    static IID := "{C92EB863-0269-4AFF-9C72-75321BBA2952}"
    GetDwordValue(bstrValueName, pdwValue)
      => ComCall(3, this.p, BSTR, bstrValueName, UInt32.Ptr, pdwValue)
    GetStringValue(bstrValueName, pbstrValue)
      => ComCall(4, this.p, BSTR, bstrValueName, BSTR.Ptr, pbstrValue)
    GetGuidValue(bstrValueName, pguidValue)
      => ComCall(5, this.p, BSTR, bstrValueName, GUID.Ptr, pguidValue)
}
