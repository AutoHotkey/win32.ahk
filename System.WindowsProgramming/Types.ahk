#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, BSTR, CHAR, HANDLE, HMODULE, HRESULT, HWND, LPARAM, PSTR, PWSTR, RECT, UNICODE_STRING, VARIANT_BOOL, WPARAM}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown, SAFEARRAY}
#Import "..\System.Kernel\Types.ahk" {LIST_ENTRY}
#Import "..\System.Ole\Types.ahk" {OLE_HANDLE}

struct TDIENTITY_ENTITY_TYPE extends UInt32 {
    static GENERIC_ENTITY := 0
    static AT_ENTITY := 640
    static CL_NL_ENTITY := 769
    static CO_NL_ENTITY := 768
    static CL_TL_ENTITY := 1025
    static CO_TL_ENTITY := 1024
    static ER_ENTITY := 896
    static IF_ENTITY := 512
}
struct HWINWATCH {
    Value : IntPtr
}
struct FEATURE_STATE_CHANGE_SUBSCRIPTION {
    Value : Struct.Ptr
}
struct TCP_REQUEST_QUERY_INFORMATION_EX32_XP {
    ID : TDIObjectID
    Context : UInt32[4]
}
struct DELAYLOAD_INFO {
    Size : UInt32
    DelayloadDescriptor : IMAGE_DELAYLOAD_DESCRIPTOR.Ptr
    ThunkAddress : IMAGE_THUNK_DATA64.Ptr
    TargetDllName : PSTR
    TargetApiDescriptor : DELAYLOAD_PROC_DESCRIPTOR
    TargetModuleBase : Struct.Ptr
    Unused : Struct.Ptr
    LastError : UInt32
}
struct IMAGE_THUNK_DATA64 {
    u1 : this._u1_e__Union
    struct _u1_e__Union {
        union {
            ForwarderString : Int64
            Function : Int64
            Ordinal : Int64
            AddressOfData : Int64
        }
    }
}
struct IMAGE_THUNK_DATA32 {
    u1 : this._u1_e__Union
    struct _u1_e__Union {
        union {
            ForwarderString : UInt32
            Function : UInt32
            Ordinal : UInt32
            AddressOfData : UInt32
        }
    }
}
struct IMAGE_DELAYLOAD_DESCRIPTOR {
    Attributes : this._Attributes_e__Union
    DllNameRVA : UInt32
    ModuleHandleRVA : UInt32
    ImportAddressTableRVA : UInt32
    ImportNameTableRVA : UInt32
    BoundImportAddressTableRVA : UInt32
    UnloadInformationTableRVA : UInt32
    TimeDateStamp : UInt32
    struct _Attributes_e__Union {
        union {
            AllAttributes : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG {
    Size : UInt32
    TriggerId : PWSTR
}
struct PFIBER_CALLOUT_ROUTINE extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr]
}
struct JIT_DEBUG_INFO {
    dwSize : UInt32
    dwProcessorArchitecture : UInt32
    dwThreadID : UInt32
    dwReserved0 : UInt32
    lpExceptionAddress : Int64
    lpExceptionRecord : Int64
    lpContextRecord : Int64
}
struct PROCESS_CREATION_SVE_VECTOR_LENGTH {
    union {
        Data : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct PROCESS_CREATION_SME_VECTOR_LENGTH {
    Anonymous : this._Anonymous_e__Union
    Reserved : UInt32
    struct _Anonymous_e__Union {
        union {
            Data : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct HW_PROFILE_INFOA {
    dwDockInfo : UInt32
    szHwProfileGuid : CHAR[39]
    szHwProfileName : CHAR[80]
}
struct HW_PROFILE_INFOW {
    dwDockInfo : UInt32
    szHwProfileGuid : UInt16[39]
    szHwProfileName : UInt16[80]
}
struct ACTCTX_SECTION_KEYED_DATA_2600 {
    cbSize : UInt32 := this.Size
    ulDataFormatVersion : UInt32
    lpData : Struct.Ptr
    ulLength : UInt32
    lpSectionGlobalData : Struct.Ptr
    ulSectionGlobalDataLength : UInt32
    lpSectionBase : Struct.Ptr
    ulSectionTotalLength : UInt32
    hActCtx : HANDLE
    ulAssemblyRosterIndex : UInt32
}
struct ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA {
    lpInformation : Struct.Ptr
    lpSectionBase : Struct.Ptr
    ulSectionLength : UInt32
    lpSectionGlobalDataBase : Struct.Ptr
    ulSectionGlobalDataLength : UInt32
}
struct ACTIVATION_CONTEXT_BASIC_INFORMATION {
    hActCtx : HANDLE
    dwFlags : UInt32
}
struct PQUERYACTCTXW_FUNC extends FunctionPointer {
    static Types := [UInt32, HANDLE, Struct.Ptr, UInt32, Struct.Ptr, IntPtr, IntPtr.Ptr, BOOL]
}
struct APPLICATION_RECOVERY_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32]
}
struct CLIENT_ID {
    UniqueProcess : HANDLE
    UniqueThread : HANDLE
}
struct LDR_DATA_TABLE_ENTRY {
    Reserved1 : Struct.Ptr[2]
    InMemoryOrderLinks : LIST_ENTRY
    Reserved2 : Struct.Ptr[2]
    DllBase : Struct.Ptr
    Reserved3 : Struct.Ptr[2]
    FullDllName : UNICODE_STRING
    Reserved4 : UInt8[8]
    Reserved5 : Struct.Ptr[3]
    Anonymous : this._Anonymous_e__Union
    TimeDateStamp : UInt32
    struct _Anonymous_e__Union {
        union {
            CheckSum : UInt32
            Reserved6 : Struct.Ptr
        }
    }
}
struct SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION {
    IdleTime : Int64
    KernelTime : Int64
    UserTime : Int64
    Reserved1 : Int64[2]
    Reserved2 : UInt32
}
struct SYSTEM_PROCESS_INFORMATION {
    NextEntryOffset : UInt32
    NumberOfThreads : UInt32
    Reserved1 : UInt8[48]
    ImageName : UNICODE_STRING
    BasePriority : Int32
    UniqueProcessId : HANDLE
    InheritedFromUniqueProcessId : HANDLE
    HandleCount : UInt32
    SessionId : UInt32
    Reserved3 : Struct.Ptr
    PeakVirtualSize : IntPtr
    VirtualSize : IntPtr
    Reserved4 : UInt32
    PeakWorkingSetSize : IntPtr
    WorkingSetSize : IntPtr
    Reserved5 : Struct.Ptr
    QuotaPagedPoolUsage : IntPtr
    Reserved6 : Struct.Ptr
    QuotaNonPagedPoolUsage : IntPtr
    PagefileUsage : IntPtr
    PeakPagefileUsage : IntPtr
    PrivatePageCount : IntPtr
    Reserved7 : Int64[6]
}
struct SYSTEM_BASICPROCESS_INFORMATION {
    NextEntryOffset : UInt32
    UniqueProcessId : HANDLE
    InheritedFromUniqueProcessId : HANDLE
    SequenceNumber : Int64
    ImageName : UNICODE_STRING
}
struct SYSTEM_HANDLECOUNT_INFORMATION {
    ProcessCount : UInt32
    ThreadCount : UInt32
    HandleCount : UInt32
}
struct SYSTEM_THREAD_INFORMATION {
    Reserved1 : Int64[3]
    Reserved2 : UInt32
    StartAddress : Struct.Ptr
    ClientId : CLIENT_ID
    Priority : Int32
    BasePriority : Int32
    Reserved3 : UInt32
    ThreadState : UInt32
    WaitReason : UInt32
}
struct SYSTEM_REGISTRY_QUOTA_INFORMATION {
    RegistryQuotaAllowed : UInt32
    RegistryQuotaUsed : UInt32
    Reserved1 : Struct.Ptr
}
struct SYSTEM_BASIC_INFORMATION {
    Reserved1 : UInt8[24]
    Reserved2 : Struct.Ptr[4]
    NumberOfProcessors : Int8
}
struct SYSTEM_TIMEOFDAY_INFORMATION {
    Reserved1 : UInt8[48]
}
struct SYSTEM_PERFORMANCE_INFORMATION {
    Reserved1 : UInt8[312]
}
struct SYSTEM_EXCEPTION_INFORMATION {
    Reserved1 : UInt8[16]
}
struct SYSTEM_LOOKASIDE_INFORMATION {
    Reserved1 : UInt8[32]
}
struct SYSTEM_INTERRUPT_INFORMATION {
    Reserved1 : UInt8[24]
}
struct SYSTEM_POLICY_INFORMATION {
    Reserved1 : Struct.Ptr[2]
    Reserved2 : UInt32[3]
}
struct THREAD_NAME_INFORMATION {
    ThreadName : UNICODE_STRING
}
struct SYSTEM_CODEINTEGRITY_INFORMATION {
    Length : UInt32
    CodeIntegrityOptions : UInt32
}
struct PUBLIC_OBJECT_BASIC_INFORMATION {
    Attributes : UInt32
    GrantedAccess : UInt32
    HandleCount : UInt32
    PointerCount : UInt32
    Reserved : UInt32[10]
}
struct PUBLIC_OBJECT_TYPE_INFORMATION {
    TypeName : UNICODE_STRING
    Reserved : UInt32[22]
}
struct WINSTATIONINFOCLASS extends Int32 {
    static WinStationInformation := 8
}
struct WINSTATIONINFORMATIONW {
    Reserved2 : UInt8[70]
    LogonId : UInt32
    Reserved3 : UInt8[1140]
}
struct PWINSTATIONQUERYINFORMATIONW extends FunctionPointer {
    static Types := [HANDLE, UInt32, WINSTATIONINFOCLASS, Struct.Ptr, UInt32, UInt32.Ptr, BOOLEAN]
}
struct CameraUIControlMode extends Int32 {
    static Browse := 0
    static Linear := 1
}
struct CameraUIControlLinearSelectionMode extends Int32 {
    static Single := 0
    static Multiple := 1
}
struct CameraUIControlCaptureMode extends Int32 {
    static PhotoOrVideo := 0
    static Photo := 1
    static Video := 2
}
struct CameraUIControlPhotoFormat extends Int32 {
    static Jpeg := 0
    static Png := 1
    static JpegXR := 2
}
struct CameraUIControlVideoFormat extends Int32 {
    static Mp4 := 0
    static Wmv := 1
}
struct CameraUIControlViewType extends Int32 {
    static SingleItem := 0
    static ItemList := 1
}
struct ICameraUIControlEventCallback extends IUnknown {
    static IID := "{1BFA0C2C-FBCD-4776-BDA4-88BF974E74F4}"
    OnStartupComplete()
      => ComCall(3, this.p, "void")
    OnSuspendComplete()
      => ComCall(4, this.p, "void")
    OnItemCaptured(pszPath)
      => ComCall(5, this.p, "Str", pszPath, "void")
    OnItemDeleted(pszPath)
      => ComCall(6, this.p, "Str", pszPath, "void")
    OnClosed()
      => ComCall(7, this.p, "void")
}
struct ICameraUIControl extends IUnknown {
    static IID := "{B8733ADF-3D68-4B8F-BB08-E28A0BED0376}"
    Show(pWindow, mode, selectionMode, captureMode, photoFormat, videoFormat, bHasCloseButton, pEventCallback?)
      => ComCall(3, this.p, IUnknown, pWindow, CameraUIControlMode, mode, CameraUIControlLinearSelectionMode, selectionMode, CameraUIControlCaptureMode, captureMode, CameraUIControlPhotoFormat, photoFormat, CameraUIControlVideoFormat, videoFormat, BOOL, bHasCloseButton, ICameraUIControlEventCallback, pEventCallback?)
    Close()
      => ComCall(4, this.p)
    Suspend(pbDeferralRequired)
      => ComCall(5, this.p, BOOL.Ptr, pbDeferralRequired)
    Resume()
      => ComCall(6, this.p)
    GetCurrentViewType(pViewType)
      => ComCall(7, this.p, CameraUIControlViewType.Ptr, pViewType)
    GetActiveItem(pbstrActiveItemPath?)
      => ComCall(8, this.p, BSTR.Ptr, pbstrActiveItemPath?)
    GetSelectedItems(ppSelectedItemPaths)
      => ComCall(9, this.p, SAFEARRAY.Ptr.Ptr, ppSelectedItemPaths)
    RemoveCapturedItem(pszPath)
      => ComCall(10, this.p, "Str", pszPath)
}
struct IEditionUpgradeHelper extends IUnknown {
    static IID := "{D3E9E342-5DEB-43B6-849E-6913B85D503A}"
    CanUpgrade(isAllowed)
      => ComCall(3, this.p, BOOL.Ptr, isAllowed)
    UpdateOperatingSystem(contentId)
      => ComCall(4, this.p, "Str", contentId)
    ShowProductKeyUI()
      => ComCall(5, this.p)
    GetOsProductContentId(contentId)
      => ComCall(6, this.p, PWSTR.Ptr, contentId)
    GetGenuineLocalStatus(isGenuine)
      => ComCall(7, this.p, BOOL.Ptr, isGenuine)
}
struct IWindowsLockModeHelper extends IUnknown {
    static IID := "{F342D19E-CC22-4648-BB5D-03CCF75B47C5}"
    GetSMode(isSmode)
      => ComCall(3, this.p, BOOL.Ptr, isSmode)
}
struct IEditionUpgradeBroker extends IUnknown {
    static IID := "{FF19CBCF-9455-4937-B872-6B7929A460AF}"
    InitializeParentWindow(parentHandle)
      => ComCall(3, this.p, OLE_HANDLE, parentHandle)
    UpdateOperatingSystem(parameter)
      => ComCall(4, this.p, BSTR, parameter)
    ShowProductKeyUI()
      => ComCall(5, this.p)
    CanUpgrade()
      => ComCall(6, this.p)
}
struct IContainerActivationHelper extends IUnknown {
    static IID := "{B524F93F-80D5-4EC7-AE9E-D66E93ADE1FA}"
    CanActivateClientVM(isAllowed)
      => ComCall(3, this.p, VARIANT_BOOL.Ptr, isAllowed)
}
struct IClipServiceNotificationHelper extends IUnknown {
    static IID := "{C39948F0-6142-44FD-98CA-E1681A8D68B5}"
    ShowToast()
      => ComCall(3, this.p)
}
struct IFClipNotificationHelper extends IUnknown {
    static IID := "{3D5E3D21-BD41-4C2A-A669-B17CE87FB50B}"
    ShowSystemDialog(titleText, bodyText)
      => ComCall(3, this.p, BSTR, titleText, BSTR, bodyText)
}
struct FEATURE_CHANGE_TIME extends Int32 {
    static FEATURE_CHANGE_TIME_READ := 0
    static FEATURE_CHANGE_TIME_MODULE_RELOAD := 1
    static FEATURE_CHANGE_TIME_SESSION := 2
    static FEATURE_CHANGE_TIME_REBOOT := 3
}
struct FEATURE_ENABLED_STATE extends Int32 {
    static FEATURE_ENABLED_STATE_DEFAULT := 0
    static FEATURE_ENABLED_STATE_DISABLED := 1
    static FEATURE_ENABLED_STATE_ENABLED := 2
}
struct FEATURE_ERROR {
    hr : HRESULT
    lineNumber : UInt16
    file : PSTR
    process : PSTR
    module : PSTR
    callerReturnAddressOffset : UInt32
    callerModule : PSTR
    message : PSTR
    originLineNumber : UInt16
    originFile : PSTR
    originModule : PSTR
    originCallerReturnAddressOffset : UInt32
    originCallerModule : PSTR
    originName : PSTR
}
struct PFEATURE_STATE_CHANGE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct DCICMD {
    dwCommand : UInt32
    dwParam1 : UInt32
    dwParam2 : UInt32
    dwVersion : UInt32
    dwReserved : UInt32
}
struct DCICREATEINPUT {
    cmd : DCICMD
    dwCompression : UInt32
    dwMask : UInt32[3]
    dwWidth : UInt32
    dwHeight : UInt32
    dwDCICaps : UInt32
    dwBitCount : UInt32
    lpSurface : Struct.Ptr
}
struct DCISURFACEINFO {
    dwSize : UInt32
    dwDCICaps : UInt32
    dwCompression : UInt32
    dwMask : UInt32[3]
    dwWidth : UInt32
    dwHeight : UInt32
    lStride : Int32
    dwBitCount : UInt32
    dwOffSurface : IntPtr
    wSelSurface : UInt16
    wReserved : UInt16
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwReserved3 : UInt32
    BeginAccess : IntPtr
    EndAccess : IntPtr
    DestroySurface : IntPtr
}
struct ENUM_CALLBACK extends FunctionPointer {
    static Types := [DCISURFACEINFO.Ptr, Struct.Ptr, "Void"]
}
struct DCIENUMINPUT {
    cmd : DCICMD
    rSrc : RECT
    rDst : RECT
    EnumCallback : IntPtr
    lpContext : Struct.Ptr
}
struct DCIOFFSCREEN {
    dciInfo : DCISURFACEINFO
    Draw : IntPtr
    SetClipList : IntPtr
    SetDestination : IntPtr
}
struct DCIOVERLAY {
    dciInfo : DCISURFACEINFO
    dwChromakeyValue : UInt32
    dwChromakeyMask : UInt32
}
struct WINWATCHNOTIFYPROC extends FunctionPointer {
    static Types := [HWINWATCH, HWND, UInt32, LPARAM, "Void"]
}
struct STRENTRYA {
    pszName : PSTR
    pszValue : PSTR
}
struct STRENTRYW {
    pszName : PWSTR
    pszValue : PWSTR
}
struct STRTABLEA {
    cEntries : UInt32
    pse : STRENTRYA.Ptr
}
struct STRTABLEW {
    cEntries : UInt32
    pse : STRENTRYW.Ptr
}
struct REGINSTALLA extends FunctionPointer {
    static Types := [HMODULE, PSTR, STRTABLEA.Ptr, HRESULT]
}
struct CABINFOA {
    pszCab : PSTR
    pszInf : PSTR
    pszSection : PSTR
    szSrcPath : CHAR[260]
    dwFlags : UInt32
}
struct CABINFOW {
    pszCab : PWSTR
    pszInf : PWSTR
    pszSection : PWSTR
    szSrcPath : UInt16[260]
    dwFlags : UInt32
}
struct PERUSERSECTIONA {
    szGUID : CHAR[59]
    szDispName : CHAR[128]
    szLocale : CHAR[10]
    szStub : CHAR[1040]
    szVersion : CHAR[32]
    szCompID : CHAR[128]
    dwIsInstalled : UInt32
    bRollback : BOOL
}
struct PERUSERSECTIONW {
    szGUID : UInt16[59]
    szDispName : UInt16[128]
    szLocale : UInt16[10]
    szStub : UInt16[1040]
    szVersion : UInt16[32]
    szCompID : UInt16[128]
    dwIsInstalled : UInt32
    bRollback : BOOL
}
struct IMESTRUCT {
    fnc : UInt32
    wParam : WPARAM
    wCount : UInt32
    dchSource : UInt32
    dchDest : UInt32
    lParam1 : LPARAM
    lParam2 : LPARAM
    lParam3 : LPARAM
}
struct UNDETERMINESTRUCT {
    dwSize : UInt32
    uDefIMESize : UInt32
    uDefIMEPos : UInt32
    uUndetTextLen : UInt32
    uUndetTextPos : UInt32
    uUndetAttrPos : UInt32
    uCursorPos : UInt32
    uDeltaStart : UInt32
    uDetermineTextLen : UInt32
    uDetermineTextPos : UInt32
    uDetermineDelimPos : UInt32
    uYomiTextLen : UInt32
    uYomiTextPos : UInt32
    uYomiDelimPos : UInt32
}
struct STRINGEXSTRUCT {
    dwSize : UInt32
    uDeterminePos : UInt32
    uDetermineDelimPos : UInt32
    uYomiPos : UInt32
    uYomiDelimPos : UInt32
}
struct DATETIME {
    year : UInt16
    month : UInt16
    day : UInt16
    hour : UInt16
    min : UInt16
    sec : UInt16
}
struct IMEPROA {
    hWnd : HWND
    InstDate : DATETIME
    wVersion : UInt32
    szDescription : UInt8[50]
    szName : UInt8[80]
    szOptions : UInt8[30]
}
struct IMEPROW {
    hWnd : HWND
    InstDate : DATETIME
    wVersion : UInt32
    szDescription : UInt16[50]
    szName : UInt16[80]
    szOptions : UInt16[30]
}
struct JAVA_TRUST {
    cbSize : UInt32 := this.Size
    flag : UInt32
    fAllActiveXPermissions : BOOL
    fAllPermissions : BOOL
    dwEncodingType : UInt32
    pbJavaPermissions : UInt8.Ptr
    cbJavaPermissions : UInt32
    pbSigner : UInt8.Ptr
    cbSigner : UInt32
    pwszZone : PWSTR
    guidZone : GUID
    hVerify : HRESULT
}
struct TDIEntityID {
    tei_entity : TDIENTITY_ENTITY_TYPE
    tei_instance : UInt32
}
struct TDIObjectID {
    toi_entity : TDIEntityID
    toi_class : UInt32
    toi_type : UInt32
    toi_id : UInt32
}
struct TCP_REQUEST_QUERY_INFORMATION_EX_XP {
    ID : TDIObjectID
    Context : IntPtr[4]
}
struct TCP_REQUEST_QUERY_INFORMATION_EX_W2K {
    ID : TDIObjectID
    Context : UInt8[16]
}
struct TCP_REQUEST_SET_INFORMATION_EX {
    ID : TDIObjectID
    BufferSize : UInt32
    Buffer : UInt8[1]
}
struct TDI_TL_IO_CONTROL_TYPE extends Int32 {
    static EndpointIoControlType := 0
    static SetSockOptIoControlType := 1
    static GetSockOptIoControlType := 2
    static SocketIoControlType := 3
}
struct TDI_TL_IO_CONTROL_ENDPOINT {
    Type : TDI_TL_IO_CONTROL_TYPE
    Level : UInt32
    Anonymous : this._Anonymous_e__Union
    InputBuffer : Struct.Ptr
    InputBufferLength : UInt32
    OutputBuffer : Struct.Ptr
    OutputBufferLength : UInt32
    struct _Anonymous_e__Union {
        union {
            IoControlCode : UInt32
            OptionName : UInt32
        }
    }
}
struct WLDP_HOST extends Int32 {
    static WLDP_HOST_RUNDLL32 := 0
    static WLDP_HOST_SVCHOST := 1
    static WLDP_HOST_MAX := 2
}
struct WLDP_HOST_ID extends Int32 {
    static WLDP_HOST_ID_UNKNOWN := 0
    static WLDP_HOST_ID_GLOBAL := 1
    static WLDP_HOST_ID_VBA := 2
    static WLDP_HOST_ID_WSH := 3
    static WLDP_HOST_ID_POWERSHELL := 4
    static WLDP_HOST_ID_IE := 5
    static WLDP_HOST_ID_MSI := 6
    static WLDP_HOST_ID_ALL := 7
    static WLDP_HOST_ID_MAX := 8
}
struct DECISION_LOCATION extends Int32 {
    static DECISION_LOCATION_REFRESH_GLOBAL_DATA := 0
    static DECISION_LOCATION_PARAMETER_VALIDATION := 1
    static DECISION_LOCATION_AUDIT := 2
    static DECISION_LOCATION_FAILED_CONVERT_GUID := 3
    static DECISION_LOCATION_ENTERPRISE_DEFINED_CLASS_ID := 4
    static DECISION_LOCATION_GLOBAL_BUILT_IN_LIST := 5
    static DECISION_LOCATION_PROVIDER_BUILT_IN_LIST := 6
    static DECISION_LOCATION_ENFORCE_STATE_LIST := 7
    static DECISION_LOCATION_NOT_FOUND := 8
    static DECISION_LOCATION_UNKNOWN := 9
}
struct WLDP_KEY extends Int32 {
    static KEY_UNKNOWN := 0
    static KEY_OVERRIDE := 1
    static KEY_ALL_KEYS := 2
}
struct VALUENAME extends Int32 {
    static VALUENAME_UNKNOWN := 0
    static VALUENAME_ENTERPRISE_DEFINED_CLASS_ID := 1
    static VALUENAME_BUILT_IN_LIST := 2
}
struct WLDP_WINDOWS_LOCKDOWN_MODE extends Int32 {
    static WLDP_WINDOWS_LOCKDOWN_MODE_UNLOCKED := 0
    static WLDP_WINDOWS_LOCKDOWN_MODE_TRIAL := 1
    static WLDP_WINDOWS_LOCKDOWN_MODE_LOCKED := 2
    static WLDP_WINDOWS_LOCKDOWN_MODE_MAX := 3
}
struct WLDP_WINDOWS_LOCKDOWN_RESTRICTION extends Int32 {
    static WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NONE := 0
    static WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NOUNLOCK := 1
    static WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NOUNLOCK_PERMANENT := 2
    static WLDP_WINDOWS_LOCKDOWN_RESTRICTION_MAX := 3
}
struct WLDP_POLICY_SETTING extends Int32 {
    static WLDP_POLICY_SETTING_AV_PERF_MODE := 1000
}
struct WLDP_HOST_INFORMATION {
    dwRevision : UInt32
    dwHostId : WLDP_HOST_ID
    szSource : PWSTR
    hSource : HANDLE
}
struct WLDP_DEVICE_SECURITY_INFORMATION {
    UnlockIdSize : UInt32
    UnlockId : UInt8.Ptr
    ManufacturerIDLength : UInt32
    ManufacturerID : PWSTR
}
struct WLDP_EXECUTION_POLICY extends Int32 {
    static WLDP_EXECUTION_POLICY_BLOCKED := 0
    static WLDP_EXECUTION_POLICY_ALLOWED := 1
    static WLDP_EXECUTION_POLICY_REQUIRE_SANDBOX := 2
}
struct WLDP_EXECUTION_EVALUATION_OPTIONS extends Int32 {
    static WLDP_EXECUTION_EVALUATION_OPTION_NONE := 0
    static WLDP_EXECUTION_EVALUATION_OPTION_EXECUTE_IN_INTERACTIVE_SESSION := 1
}
struct WLDP_SECURE_SETTING_VALUE_TYPE extends Int32 {
    static WLDP_SECURE_SETTING_VALUE_TYPE_BOOLEAN := 0
    static WLDP_SECURE_SETTING_VALUE_TYPE_ULONG := 1
    static WLDP_SECURE_SETTING_VALUE_TYPE_BINARY := 2
    static WLDP_SECURE_SETTING_VALUE_TYPE_STRING := 3
}
struct PWLDP_QUERYSECURITYPOLICY_API extends FunctionPointer {
    static Types := [UNICODE_STRING.Ptr, UNICODE_STRING.Ptr, UNICODE_STRING.Ptr, WLDP_SECURE_SETTING_VALUE_TYPE.Ptr, Struct.Ptr, UInt32.Ptr, HRESULT]
}
struct PWLDP_SETDYNAMICCODETRUST_API extends FunctionPointer {
    static Types := [HANDLE, HRESULT]
}
struct PWLDP_ISDYNAMICCODEPOLICYENABLED_API extends FunctionPointer {
    static Types := [BOOL.Ptr, HRESULT]
}
struct PWLDP_QUERYDYNAMICODETRUST_API extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, UInt32, HRESULT]
}
struct PWLDP_QUERYWINDOWSLOCKDOWNMODE_API extends FunctionPointer {
    static Types := [WLDP_WINDOWS_LOCKDOWN_MODE.Ptr, HRESULT]
}
struct PWLDP_QUERYDEVICESECURITYINFORMATION_API extends FunctionPointer {
    static Types := [WLDP_DEVICE_SECURITY_INFORMATION.Ptr, UInt32, UInt32.Ptr, HRESULT]
}
struct PWLDP_QUERYWINDOWSLOCKDOWNRESTRICTION_API extends FunctionPointer {
    static Types := [WLDP_WINDOWS_LOCKDOWN_RESTRICTION.Ptr, HRESULT]
}
struct PWLDP_SETWINDOWSLOCKDOWNRESTRICTION_API extends FunctionPointer {
    static Types := [WLDP_WINDOWS_LOCKDOWN_RESTRICTION, HRESULT]
}
struct PWLDP_ISAPPAPPROVEDBYPOLICY_API extends FunctionPointer {
    static Types := [PWSTR, Int64, HRESULT]
}
struct PWLDP_QUERYPOLICYSETTINGENABLED_API extends FunctionPointer {
    static Types := [WLDP_POLICY_SETTING, BOOL.Ptr, HRESULT]
}
struct PWLDP_QUERYPOLICYSETTINGENABLED2_API extends FunctionPointer {
    static Types := [PWSTR, BOOL.Ptr, HRESULT]
}
struct PWLDP_ISWCOSPRODUCTIONCONFIGURATION_API extends FunctionPointer {
    static Types := [BOOL.Ptr, HRESULT]
}
struct PWLDP_RESETWCOSPRODUCTIONCONFIGURATION_API extends FunctionPointer {
    static Types := [HRESULT]
}
struct PWLDP_ISPRODUCTIONCONFIGURATION_API extends FunctionPointer {
    static Types := [BOOL.Ptr, HRESULT]
}
struct PWLDP_RESETPRODUCTIONCONFIGURATION_API extends FunctionPointer {
    static Types := [HRESULT]
}
struct PWLDP_CANEXECUTEFILE_API extends FunctionPointer {
    static Types := [GUID.Ptr, WLDP_EXECUTION_EVALUATION_OPTIONS, HANDLE, PWSTR, WLDP_EXECUTION_POLICY.Ptr, HRESULT]
}
struct PWLDP_CANEXECUTEBUFFER_API extends FunctionPointer {
    static Types := [GUID.Ptr, WLDP_EXECUTION_EVALUATION_OPTIONS, UInt8.Ptr, UInt32, PWSTR, WLDP_EXECUTION_POLICY.Ptr, HRESULT]
}
struct PWLDP_CANEXECUTESTREAM_API extends FunctionPointer {
    static Types := [GUID.Ptr, WLDP_EXECUTION_EVALUATION_OPTIONS, IStream, PWSTR, WLDP_EXECUTION_POLICY.Ptr, HRESULT]
}
struct PWLDP_CANEXECUTEFILEFROMDETACHEDSIGNATURE_API extends FunctionPointer {
    static Types := [GUID.Ptr, WLDP_EXECUTION_EVALUATION_OPTIONS, HANDLE, HANDLE, PWSTR, WLDP_EXECUTION_POLICY.Ptr, HRESULT]
}
struct PWLDP_GETAPPLICATIONSETTINGBOOLEAN_API extends FunctionPointer {
    static Types := [PWSTR, PWSTR, BOOL.Ptr, HRESULT]
}
struct PWLDP_GETAPPLICATIONSETTINGSTRINGLIST_API extends FunctionPointer {
    static Types := [PWSTR, PWSTR, IntPtr, IntPtr.Ptr, PWSTR, HRESULT]
}
struct PWLDP_GETAPPLICATIONSETTINGSTRINGSET_API extends FunctionPointer {
    static Types := [PWSTR, PWSTR, IntPtr, IntPtr.Ptr, PWSTR, HRESULT]
}
struct IDefaultBrowserSyncSettings extends IUnknown {
    static IID := "{7A27FAAD-5AE6-4255-9030-C530936292E3}"
    IsEnabled()
      => ComCall(3, this.p, BOOL)
}
struct DELAYLOAD_PROC_DESCRIPTOR {
    ImportDescribedByName : UInt32
    Description : this._Description_e__Union
    struct _Description_e__Union {
        union {
            Name : PSTR
            Ordinal : UInt32
        }
    }
}
struct PDELAYLOAD_FAILURE_DLL_CALLBACK extends FunctionPointer {
    static Types := [UInt32, DELAYLOAD_INFO.Ptr, Struct.Ptr]
}
struct IDeleteBrowsingHistory extends IUnknown {
    static IID := "{CF38ED4B-2BE7-4461-8B5E-9A466DC82AE3}"
    DeleteBrowsingHistory(dwFlags)
      => ComCall(3, this.p, UInt32, dwFlags)
}
