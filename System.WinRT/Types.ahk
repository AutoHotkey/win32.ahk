#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT, HWND, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\UI.Shell.PropertiesSystem\Types.ahk" {INamedPropertyStore}

struct EventRegistrationToken {
    value : Int64
}
struct HSTRING_HEADER {
    flags : UInt32
    length : UInt32
    padding1 : UInt32
    padding2 : UInt32
    data : IntPtr
}
struct HSTRING {
    Value : IntPtr
}
struct HSTRING_BUFFER {
    Value : IntPtr
}
struct APARTMENT_SHUTDOWN_REGISTRATION_COOKIE {
    Value : Struct.Ptr
}
struct RO_REGISTRATION_COOKIE {
    Value : IntPtr
}
struct ACTIVATIONTYPE extends Int32 {
    static ACTIVATIONTYPE_UNCATEGORIZED := 0
    static ACTIVATIONTYPE_FROM_MONIKER := 1
    static ACTIVATIONTYPE_FROM_DATA := 2
    static ACTIVATIONTYPE_FROM_STORAGE := 4
    static ACTIVATIONTYPE_FROM_STREAM := 8
    static ACTIVATIONTYPE_FROM_FILE := 16
}
struct IAgileReference extends IUnknown {
    static IID := "{C03F6A43-65A4-9818-987E-E0B810D2A6F2}"
    Resolve(riid, ppvObjectReference)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObjectReference)
}
struct IApartmentShutdown extends IUnknown {
    static IID := "{A2F05A09-27A2-42B5-BC0E-AC163EF49D9B}"
    OnUninitialize(ui64ApartmentIdentifier)
      => ComCall(3, this.p, Int64, ui64ApartmentIdentifier, "void")
}
struct ServerInformation {
    dwServerPid : UInt32
    dwServerTid : UInt32
    ui64ServerAddress : Int64
}
struct AgileReferenceOptions extends Int32 {
    static AGILEREFERENCE_DEFAULT := 0
    static AGILEREFERENCE_DELAYEDMARSHAL := 1
}
struct ISpatialInteractionManagerInterop extends IInspectable {
    static IID := "{5C4EE536-6A98-4B86-A170-587013D6FD4B}"
    GetForWindow(window, riid, spatialInteractionManager)
      => ComCall(6, this.p, HWND, window, GUID.Ptr, riid, Struct.Ptr.Ptr, spatialInteractionManager)
}
struct IHolographicSpaceInterop extends IInspectable {
    static IID := "{5C4EE536-6A98-4B86-A170-587013D6FD4B}"
    CreateForWindow(window, riid, holographicSpace)
      => ComCall(6, this.p, HWND, window, GUID.Ptr, riid, Struct.Ptr.Ptr, holographicSpace)
}
struct TrustLevel extends Int32 {
    static BaseTrust := 0
    static PartialTrust := 1
    static FullTrust := 2
}
struct IInspectable extends IUnknown {
    static IID := "{AF86E2E0-B12D-4C6A-9C5A-D7AA65101E90}"
    GetIids(iidCount, iids)
      => ComCall(3, this.p, UInt32.Ptr, iidCount, GUID.Ptr.Ptr, iids)
    GetRuntimeClassName(className)
      => ComCall(4, this.p, HSTRING.Ptr, className)
    GetTrustLevel(trustLevel)
      => ComCall(5, this.p, TrustLevel.Ptr, trustLevel)
}
struct PINSPECT_HSTRING_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, UInt32, UInt8.Ptr, HRESULT]
}
struct PINSPECT_HSTRING_CALLBACK2 extends FunctionPointer {
    static Types := [Struct.Ptr, Int64, UInt32, UInt8.Ptr, HRESULT]
}
struct DISPATCHERQUEUE_THREAD_APARTMENTTYPE extends Int32 {
    static DQTAT_COM_NONE := 0
    static DQTAT_COM_ASTA := 1
    static DQTAT_COM_STA := 2
}
struct DISPATCHERQUEUE_THREAD_TYPE extends Int32 {
    static DQTYPE_THREAD_DEDICATED := 1
    static DQTYPE_THREAD_CURRENT := 2
}
struct DispatcherQueueOptions {
    dwSize : UInt32
    threadType : DISPATCHERQUEUE_THREAD_TYPE
    apartmentType : DISPATCHERQUEUE_THREAD_APARTMENTTYPE
}
struct IAccountsSettingsPaneInterop extends IInspectable {
    static IID := "{D3EE12AD-3865-4362-9746-B75A682DF0E6}"
    GetForWindow(appWindow, riid, accountsSettingsPane)
      => ComCall(6, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, accountsSettingsPane)
    ShowManageAccountsForWindowAsync(appWindow, riid, asyncAction)
      => ComCall(7, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncAction)
    ShowAddAccountForWindowAsync(appWindow, riid, asyncAction)
      => ComCall(8, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncAction)
}
struct IAppServiceConnectionExtendedExecution extends IUnknown {
    static IID := "{65219584-F9CB-4AE3-81F9-A28A6CA450D9}"
    OpenForExtendedExecutionAsync(riid, operation)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, operation)
}
struct ICorrelationVectorSource extends IUnknown {
    static IID := "{152B8A3B-B9B9-4685-B56E-974847BC7545}"
    get_CorrelationVector(cv)
      => ComCall(3, this.p, HSTRING.Ptr, cv)
}
struct CASTING_CONNECTION_ERROR_STATUS extends Int32 {
    static CASTING_CONNECTION_ERROR_STATUS_SUCCEEDED := 0
    static CASTING_CONNECTION_ERROR_STATUS_DEVICE_DID_NOT_RESPOND := 1
    static CASTING_CONNECTION_ERROR_STATUS_DEVICE_ERROR := 2
    static CASTING_CONNECTION_ERROR_STATUS_DEVICE_LOCKED := 3
    static CASTING_CONNECTION_ERROR_STATUS_PROTECTED_PLAYBACK_FAILED := 4
    static CASTING_CONNECTION_ERROR_STATUS_INVALID_CASTING_SOURCE := 5
    static CASTING_CONNECTION_ERROR_STATUS_UNKNOWN := 6
}
struct CASTING_CONNECTION_STATE extends Int32 {
    static CASTING_CONNECTION_STATE_DISCONNECTED := 0
    static CASTING_CONNECTION_STATE_CONNECTED := 1
    static CASTING_CONNECTION_STATE_RENDERING := 2
    static CASTING_CONNECTION_STATE_DISCONNECTING := 3
    static CASTING_CONNECTION_STATE_CONNECTING := 4
}
struct ICastingEventHandler extends IUnknown {
    static IID := "{C79A6CB7-BEBD-47A6-A2AD-4D45AD79C7BC}"
    OnStateChanged(newState)
      => ComCall(3, this.p, CASTING_CONNECTION_STATE, newState)
    OnError(errorStatus, errorMessage)
      => ComCall(4, this.p, CASTING_CONNECTION_ERROR_STATUS, errorStatus, "Str", errorMessage)
}
struct ICastingController extends IUnknown {
    static IID := "{F0A56423-A664-4FBD-8B43-409A45E8D9A1}"
    Initialize(castingEngine, castingSource)
      => ComCall(3, this.p, IUnknown, castingEngine, IUnknown, castingSource)
    Connect()
      => ComCall(4, this.p)
    Disconnect()
      => ComCall(5, this.p)
    Advise(eventHandler, cookie)
      => ComCall(6, this.p, ICastingEventHandler, eventHandler, UInt32.Ptr, cookie)
    UnAdvise(cookie)
      => ComCall(7, this.p, UInt32, cookie)
}
struct ICastingSourceInfo extends IUnknown {
    static IID := "{45101AB7-7C3A-4BCE-9500-12C09024B298}"
    GetController(controller)
      => ComCall(3, this.p, ICastingController.Ptr, controller)
    GetProperties(props)
      => ComCall(4, this.p, INamedPropertyStore.Ptr, props)
}
struct IDragDropManagerInterop extends IInspectable {
    static IID := "{5AD8CBA7-4C01-4DAC-9074-827894292D63}"
    GetForWindow(hwnd1, riid, ppv)
      => ComCall(6, this.p, HWND, hwnd1, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IInputPaneInterop extends IInspectable {
    static IID := "{75CF2C57-9195-4931-8332-F0B409E916AF}"
    GetForWindow(appWindow, riid, inputPane)
      => ComCall(6, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, inputPane)
}
struct IPlayToManagerInterop extends IInspectable {
    static IID := "{24394699-1F2C-4EB3-8CD7-0EC1DA42A540}"
    GetForWindow(appWindow, riid, playToManager)
      => ComCall(6, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, playToManager)
    ShowPlayToUIForWindow(appWindow)
      => ComCall(7, this.p, HWND, appWindow)
}
struct ICorrelationVectorInformation extends IInspectable {
    static IID := "{83C78B3C-D88B-4950-AA6E-22B8D22AABD3}"
    get_LastCorrelationVectorForThread(cv)
      => ComCall(6, this.p, HSTRING.Ptr, cv)
    get_NextCorrelationVectorForThread(cv)
      => ComCall(7, this.p, HSTRING.Ptr, cv)
    put_NextCorrelationVectorForThread(cv)
      => ComCall(8, this.p, HSTRING, cv)
}
struct IUIViewSettingsInterop extends IInspectable {
    static IID := "{3694DBF9-8F68-44BE-8FF5-195C98EDE8A6}"
    GetForWindow(hwnd1, riid, ppv)
      => ComCall(6, this.p, HWND, hwnd1, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IUserActivityInterop extends IInspectable {
    static IID := "{1ADE314D-0E0A-40D9-824C-9A088A50059F}"
    CreateSessionForWindow(window, iid, value)
      => ComCall(6, this.p, HWND, window, GUID.Ptr, iid, Struct.Ptr.Ptr, value)
}
struct IUserActivitySourceHostInterop extends IInspectable {
    static IID := "{C15DF8BC-8844-487A-B85B-7578E0F61419}"
    SetActivitySourceHost(activitySourceHost)
      => ComCall(6, this.p, HSTRING, activitySourceHost)
}
struct IUserActivityRequestManagerInterop extends IInspectable {
    static IID := "{DD69F876-9699-4715-9095-E37EA30DFA1B}"
    GetForWindow(window, iid, value)
      => ComCall(6, this.p, HWND, window, GUID.Ptr, iid, Struct.Ptr.Ptr, value)
}
struct IUserConsentVerifierInterop extends IInspectable {
    static IID := "{39E050C3-4E74-441A-8DC0-B81104DF949C}"
    RequestVerificationForWindowAsync(appWindow, message, riid, asyncOperation)
      => ComCall(6, this.p, HWND, appWindow, HSTRING, message, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncOperation)
}
struct IWebAuthenticationCoreManagerInterop extends IInspectable {
    static IID := "{F4B8E804-811E-4436-B69C-44CB67B72084}"
    RequestTokenForWindowAsync(appWindow, request, riid, asyncInfo)
      => ComCall(6, this.p, HWND, appWindow, IInspectable, request, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncInfo)
    RequestTokenWithWebAccountForWindowAsync(appWindow, request, webAccount, riid, asyncInfo)
      => ComCall(7, this.p, HWND, appWindow, IInspectable, request, IInspectable, webAccount, GUID.Ptr, riid, Struct.Ptr.Ptr, asyncInfo)
}
struct IRestrictedErrorInfo extends IUnknown {
    static IID := "{82BA7092-4C88-427D-A7BC-16DD93FEB67E}"
    GetErrorDetails(description, error, restrictedDescription, capabilitySid)
      => ComCall(3, this.p, BSTR.Ptr, description, HRESULT.Ptr, error, BSTR.Ptr, restrictedDescription, BSTR.Ptr, capabilitySid)
    GetReference(reference)
      => ComCall(4, this.p, BSTR.Ptr, reference)
}
struct ILanguageExceptionErrorInfo extends IUnknown {
    static IID := "{04A2DBF3-DF83-116C-0946-0812ABF6E07D}"
    GetLanguageException(languageException)
      => ComCall(3, this.p, IUnknown.Ptr, languageException)
}
struct ILanguageExceptionTransform extends IUnknown {
    static IID := "{FEB5A271-A6CD-45CE-880A-696706BADC65}"
    GetTransformedRestrictedErrorInfo(restrictedErrorInfo)
      => ComCall(3, this.p, IRestrictedErrorInfo.Ptr, restrictedErrorInfo)
}
struct ILanguageExceptionStackBackTrace extends IUnknown {
    static IID := "{CBE53FB5-F967-4258-8D34-42F5E25833DE}"
    GetStackBackTrace(maxFramesToCapture, stackBackTrace, framesCaptured)
      => ComCall(3, this.p, UInt32, maxFramesToCapture, IntPtr.Ptr, stackBackTrace, UInt32.Ptr, framesCaptured)
}
struct ILanguageExceptionErrorInfo2 extends ILanguageExceptionErrorInfo {
    static IID := "{5746E5C4-5B97-424C-B620-2822915734DD}"
    GetPreviousLanguageExceptionErrorInfo(previousLanguageExceptionErrorInfo)
      => ComCall(4, this.p, ILanguageExceptionErrorInfo2.Ptr, previousLanguageExceptionErrorInfo)
    CapturePropagationContext(languageException)
      => ComCall(5, this.p, IUnknown, languageException)
    GetPropagationContextHead(propagatedLanguageExceptionErrorInfoHead)
      => ComCall(6, this.p, ILanguageExceptionErrorInfo2.Ptr, propagatedLanguageExceptionErrorInfoHead)
}
struct IActivationFactory extends IInspectable {
    static IID := "{00000035-0000-0000-C000-000000000046}"
    ActivateInstance(instance)
      => ComCall(6, this.p, IInspectable.Ptr, instance)
}
struct RO_INIT_TYPE extends Int32 {
    static RO_INIT_SINGLETHREADED := 0
    static RO_INIT_MULTITHREADED := 1
}
struct PFNGETACTIVATIONFACTORY extends FunctionPointer {
    static Types := [HSTRING, IActivationFactory.Ptr, HRESULT]
}
struct IBufferByteAccess extends IUnknown {
    static IID := "{905A0FEF-BC53-11DF-8C49-001E4FC686DA}"
    Buffer(value)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, value)
}
struct RO_ERROR_REPORTING_FLAGS extends Int32 {
    static RO_ERROR_REPORTING_NONE := 0
    static RO_ERROR_REPORTING_SUPPRESSEXCEPTIONS := 1
    static RO_ERROR_REPORTING_FORCEEXCEPTIONS := 2
    static RO_ERROR_REPORTING_USESETERRORINFO := 4
    static RO_ERROR_REPORTING_SUPPRESSSETERRORINFO := 8
}
struct PINSPECT_MEMORY_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, UInt32, UInt8.Ptr, HRESULT]
}
struct BSOS_OPTIONS extends Int32 {
    static BSOS_DEFAULT := 0
    static BSOS_PREFERDESTINATIONSTREAM := 1
}
struct IMemoryBufferByteAccess extends IUnknown {
    static IID := "{5B0D3235-4DBA-4D44-865E-8F1D0E4FD04D}"
    GetBuffer(value, capacity)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, value, UInt32.Ptr, capacity)
}
struct IWeakReference extends IUnknown {
    static IID := "{00000037-0000-0000-C000-000000000046}"
    Resolve(riid, objectReference)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, objectReference)
}
struct IWeakReferenceSource extends IUnknown {
    static IID := "{00000038-0000-0000-C000-000000000046}"
    GetWeakReference(weakReference)
      => ComCall(3, this.p, IWeakReference.Ptr, weakReference)
}
struct ISystemMediaTransportControlsInterop extends IInspectable {
    static IID := "{DDB0472D-C911-4A1F-86D9-DC3D71A95F5A}"
    GetForWindow(appWindow, riid, mediaTransportControl)
      => ComCall(6, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, mediaTransportControl)
}
struct IShareWindowCommandEventArgsInterop extends IUnknown {
    static IID := "{6571A721-643D-43D4-ACA4-6B6F5F30F1AD}"
    GetWindow(value)
      => ComCall(3, this.p, HWND.Ptr, value)
}
struct IShareWindowCommandSourceInterop extends IUnknown {
    static IID := "{461A191F-8424-43A6-A0FA-3451A22F56AB}"
    GetForWindow(appWindow, riid, shareWindowCommandSource)
      => ComCall(3, this.p, HWND, appWindow, GUID.Ptr, riid, Struct.Ptr.Ptr, shareWindowCommandSource)
}
struct IMessageDispatcher extends IInspectable {
    static IID := "{F5F84C8F-CFD0-4CD6-B66B-C5D26FF1689D}"
    PumpMessages()
      => ComCall(6, this.p)
}
struct ICoreWindowInterop extends IUnknown {
    static IID := "{45D64A29-A63E-4CB6-B498-5781D298CB4F}"
    get_WindowHandle(hwnd)
      => ComCall(3, this.p, HWND.Ptr, hwnd)
    put_MessageHandled(value)
      => ComCall(4, this.p, UInt8, value)
}
struct ICoreInputInterop extends IUnknown {
    static IID := "{40BFE3E3-B75A-4479-AC96-475365749BB8}"
    SetInputSource(value?)
      => ComCall(3, this.p, IUnknown, value?)
    put_MessageHandled(value)
      => ComCall(4, this.p, UInt8, value)
}
struct ICoreWindowComponentInterop extends IUnknown {
    static IID := "{0576AB31-A310-4C40-BA31-FD37E0298DFA}"
    ConfigureComponentInput(hostViewInstanceId, hwndHost, inputSourceVisual?)
      => ComCall(3, this.p, UInt32, hostViewInstanceId, HWND, hwndHost, IUnknown, inputSourceVisual?)
    GetViewInstanceId(componentViewInstanceId)
      => ComCall(4, this.p, UInt32.Ptr, componentViewInstanceId)
}
struct ICoreWindowAdapterInterop extends IInspectable {
    static IID := "{7A5B6FD1-CD73-4B6C-9CF4-2E869EAF470A}"
    get_AppActivationClientAdapter(value)
      => ComCall(6, this.p, IUnknown.Ptr, value)
    get_ApplicationViewClientAdapter(value)
      => ComCall(7, this.p, IUnknown.Ptr, value)
    get_CoreApplicationViewClientAdapter(value)
      => ComCall(8, this.p, IUnknown.Ptr, value)
    get_HoloViewClientAdapter(value)
      => ComCall(9, this.p, IUnknown.Ptr, value)
    get_PositionerClientAdapter(value)
      => ComCall(10, this.p, IUnknown.Ptr, value)
    get_SystemNavigationClientAdapter(value)
      => ComCall(11, this.p, IUnknown.Ptr, value)
    get_TitleBarClientAdapter(value)
      => ComCall(12, this.p, IUnknown.Ptr, value)
    SetWindowClientAdapter(value?)
      => ComCall(13, this.p, IUnknown, value?)
}
struct ICoreInputInterop2 extends IInspectable {
    static IID := "{B8A2ACD7-A0F0-40EE-8EE7-C82F59CC5CD4}"
    get_WindowHandle(window)
      => ComCall(6, this.p, HWND.Ptr, window)
    ChangeHostingContext(newParentWindow, newViewInstanceId)
      => ComCall(7, this.p, HWND, newParentWindow, UInt32, newViewInstanceId)
}
