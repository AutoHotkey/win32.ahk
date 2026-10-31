#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, FILETIME, HANDLE, HINSTANCE, HRESULT, HWND, PSTR, PWSTR, SYSTEMTIME, VARIANT_BOOL}
#Import "..\Graphics.Gdi\Types.ahk" {HDC}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.IO\Types.ahk" {OVERLAPPED}
#Import "..\System.Registry\Types.ahk" {HKEY}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.Controls\Types.ahk" {HPROPSHEETPAGE}

struct FAX_ENUM_LOG_LEVELS extends Int32 {
    static FAXLOG_LEVEL_NONE := 0
    static FAXLOG_LEVEL_MIN := 1
    static FAXLOG_LEVEL_MED := 2
    static FAXLOG_LEVEL_MAX := 3
}
struct FAX_ENUM_LOG_CATEGORIES extends Int32 {
    static FAXLOG_CATEGORY_INIT := 1
    static FAXLOG_CATEGORY_OUTBOUND := 2
    static FAXLOG_CATEGORY_INBOUND := 3
    static FAXLOG_CATEGORY_UNKNOWN := 4
}
struct FAX_LOG_CATEGORYA {
    Name : PSTR
    Category : UInt32
    Level : UInt32
}
struct FAX_LOG_CATEGORYW {
    Name : PWSTR
    Category : UInt32
    Level : UInt32
}
struct FAX_TIME {
    Hour : UInt16
    Minute : UInt16
}
struct FAX_CONFIGURATIONA {
    SizeOfStruct : UInt32
    Retries : UInt32
    RetryDelay : UInt32
    DirtyDays : UInt32
    Branding : BOOL
    UseDeviceTsid : BOOL
    ServerCp : BOOL
    PauseServerQueue : BOOL
    StartCheapTime : FAX_TIME
    StopCheapTime : FAX_TIME
    ArchiveOutgoingFaxes : BOOL
    ArchiveDirectory : PSTR
    Reserved : PSTR
}
struct FAX_CONFIGURATIONW {
    SizeOfStruct : UInt32
    Retries : UInt32
    RetryDelay : UInt32
    DirtyDays : UInt32
    Branding : BOOL
    UseDeviceTsid : BOOL
    ServerCp : BOOL
    PauseServerQueue : BOOL
    StartCheapTime : FAX_TIME
    StopCheapTime : FAX_TIME
    ArchiveOutgoingFaxes : BOOL
    ArchiveDirectory : PWSTR
    Reserved : PWSTR
}
struct FAX_ENUM_JOB_COMMANDS extends Int32 {
    static JC_UNKNOWN := 0
    static JC_DELETE := 1
    static JC_PAUSE := 2
    static JC_RESUME := 3
}
struct FAX_DEVICE_STATUSA {
    SizeOfStruct : UInt32
    CallerId : PSTR
    Csid : PSTR
    CurrentPage : UInt32
    DeviceId : UInt32
    DeviceName : PSTR
    DocumentName : PSTR
    JobType : UInt32
    PhoneNumber : PSTR
    RoutingString : PSTR
    SenderName : PSTR
    RecipientName : PSTR
    Size : UInt32
    StartTime : FILETIME
    Status : UInt32
    StatusString : PSTR
    SubmittedTime : FILETIME
    TotalPages : UInt32
    Tsid : PSTR
    UserName : PSTR
}
struct FAX_DEVICE_STATUSW {
    SizeOfStruct : UInt32
    CallerId : PWSTR
    Csid : PWSTR
    CurrentPage : UInt32
    DeviceId : UInt32
    DeviceName : PWSTR
    DocumentName : PWSTR
    JobType : UInt32
    PhoneNumber : PWSTR
    RoutingString : PWSTR
    SenderName : PWSTR
    RecipientName : PWSTR
    Size : UInt32
    StartTime : FILETIME
    Status : UInt32
    StatusString : PWSTR
    SubmittedTime : FILETIME
    TotalPages : UInt32
    Tsid : PWSTR
    UserName : PWSTR
}
struct FAX_JOB_ENTRYA {
    SizeOfStruct : UInt32
    JobId : UInt32
    UserName : PSTR
    JobType : UInt32
    QueueStatus : UInt32
    Status : UInt32
    Size : UInt32
    PageCount : UInt32
    RecipientNumber : PSTR
    RecipientName : PSTR
    Tsid : PSTR
    SenderName : PSTR
    SenderCompany : PSTR
    SenderDept : PSTR
    BillingCode : PSTR
    ScheduleAction : UInt32
    ScheduleTime : SYSTEMTIME
    DeliveryReportType : UInt32
    DeliveryReportAddress : PSTR
    DocumentName : PSTR
}
struct FAX_JOB_ENTRYW {
    SizeOfStruct : UInt32
    JobId : UInt32
    UserName : PWSTR
    JobType : UInt32
    QueueStatus : UInt32
    Status : UInt32
    Size : UInt32
    PageCount : UInt32
    RecipientNumber : PWSTR
    RecipientName : PWSTR
    Tsid : PWSTR
    SenderName : PWSTR
    SenderCompany : PWSTR
    SenderDept : PWSTR
    BillingCode : PWSTR
    ScheduleAction : UInt32
    ScheduleTime : SYSTEMTIME
    DeliveryReportType : UInt32
    DeliveryReportAddress : PWSTR
    DocumentName : PWSTR
}
struct FAX_PORT_INFOA {
    SizeOfStruct : UInt32
    DeviceId : UInt32
    State : UInt32
    Flags : UInt32
    Rings : UInt32
    Priority : UInt32
    DeviceName : PSTR
    Tsid : PSTR
    Csid : PSTR
}
struct FAX_PORT_INFOW {
    SizeOfStruct : UInt32
    DeviceId : UInt32
    State : UInt32
    Flags : UInt32
    Rings : UInt32
    Priority : UInt32
    DeviceName : PWSTR
    Tsid : PWSTR
    Csid : PWSTR
}
struct FAX_ROUTING_METHODA {
    SizeOfStruct : UInt32
    DeviceId : UInt32
    Enabled : BOOL
    DeviceName : PSTR
    Guid : PSTR
    FriendlyName : PSTR
    FunctionName : PSTR
    ExtensionImageName : PSTR
    ExtensionFriendlyName : PSTR
}
struct FAX_ROUTING_METHODW {
    SizeOfStruct : UInt32
    DeviceId : UInt32
    Enabled : BOOL
    DeviceName : PWSTR
    Guid : PWSTR
    FriendlyName : PWSTR
    FunctionName : PWSTR
    ExtensionImageName : PWSTR
    ExtensionFriendlyName : PWSTR
}
struct FAX_GLOBAL_ROUTING_INFOA {
    SizeOfStruct : UInt32
    Priority : UInt32
    Guid : PSTR
    FriendlyName : PSTR
    FunctionName : PSTR
    ExtensionImageName : PSTR
    ExtensionFriendlyName : PSTR
}
struct FAX_GLOBAL_ROUTING_INFOW {
    SizeOfStruct : UInt32
    Priority : UInt32
    Guid : PWSTR
    FriendlyName : PWSTR
    FunctionName : PWSTR
    ExtensionImageName : PWSTR
    ExtensionFriendlyName : PWSTR
}
struct FAX_COVERPAGE_INFOA {
    SizeOfStruct : UInt32
    CoverPageName : PSTR
    UseServerCoverPage : BOOL
    RecName : PSTR
    RecFaxNumber : PSTR
    RecCompany : PSTR
    RecStreetAddress : PSTR
    RecCity : PSTR
    RecState : PSTR
    RecZip : PSTR
    RecCountry : PSTR
    RecTitle : PSTR
    RecDepartment : PSTR
    RecOfficeLocation : PSTR
    RecHomePhone : PSTR
    RecOfficePhone : PSTR
    SdrName : PSTR
    SdrFaxNumber : PSTR
    SdrCompany : PSTR
    SdrAddress : PSTR
    SdrTitle : PSTR
    SdrDepartment : PSTR
    SdrOfficeLocation : PSTR
    SdrHomePhone : PSTR
    SdrOfficePhone : PSTR
    Note : PSTR
    Subject : PSTR
    TimeSent : SYSTEMTIME
    PageCount : UInt32
}
struct FAX_COVERPAGE_INFOW {
    SizeOfStruct : UInt32
    CoverPageName : PWSTR
    UseServerCoverPage : BOOL
    RecName : PWSTR
    RecFaxNumber : PWSTR
    RecCompany : PWSTR
    RecStreetAddress : PWSTR
    RecCity : PWSTR
    RecState : PWSTR
    RecZip : PWSTR
    RecCountry : PWSTR
    RecTitle : PWSTR
    RecDepartment : PWSTR
    RecOfficeLocation : PWSTR
    RecHomePhone : PWSTR
    RecOfficePhone : PWSTR
    SdrName : PWSTR
    SdrFaxNumber : PWSTR
    SdrCompany : PWSTR
    SdrAddress : PWSTR
    SdrTitle : PWSTR
    SdrDepartment : PWSTR
    SdrOfficeLocation : PWSTR
    SdrHomePhone : PWSTR
    SdrOfficePhone : PWSTR
    Note : PWSTR
    Subject : PWSTR
    TimeSent : SYSTEMTIME
    PageCount : UInt32
}
struct FAX_ENUM_JOB_SEND_ATTRIBUTES extends Int32 {
    static JSA_NOW := 0
    static JSA_SPECIFIC_TIME := 1
    static JSA_DISCOUNT_PERIOD := 2
}
struct FAX_ENUM_DELIVERY_REPORT_TYPES extends Int32 {
    static DRT_NONE := 0
    static DRT_EMAIL := 1
    static DRT_INBOX := 2
}
struct FAX_JOB_PARAMA {
    SizeOfStruct : UInt32
    RecipientNumber : PSTR
    RecipientName : PSTR
    Tsid : PSTR
    SenderName : PSTR
    SenderCompany : PSTR
    SenderDept : PSTR
    BillingCode : PSTR
    ScheduleAction : UInt32
    ScheduleTime : SYSTEMTIME
    DeliveryReportType : UInt32
    DeliveryReportAddress : PSTR
    DocumentName : PSTR
    CallHandle : UInt32
    Reserved : IntPtr[3]
}
struct FAX_JOB_PARAMW {
    SizeOfStruct : UInt32
    RecipientNumber : PWSTR
    RecipientName : PWSTR
    Tsid : PWSTR
    SenderName : PWSTR
    SenderCompany : PWSTR
    SenderDept : PWSTR
    BillingCode : PWSTR
    ScheduleAction : UInt32
    ScheduleTime : SYSTEMTIME
    DeliveryReportType : UInt32
    DeliveryReportAddress : PWSTR
    DocumentName : PWSTR
    CallHandle : UInt32
    Reserved : IntPtr[3]
}
struct FAX_EVENTA {
    SizeOfStruct : UInt32
    TimeStamp : FILETIME
    DeviceId : UInt32
    EventId : UInt32
    JobId : UInt32
}
struct FAX_EVENTW {
    SizeOfStruct : UInt32
    TimeStamp : FILETIME
    DeviceId : UInt32
    EventId : UInt32
    JobId : UInt32
}
struct FAX_PRINT_INFOA {
    SizeOfStruct : UInt32
    DocName : PSTR
    RecipientName : PSTR
    RecipientNumber : PSTR
    SenderName : PSTR
    SenderCompany : PSTR
    SenderDept : PSTR
    SenderBillingCode : PSTR
    Reserved : PSTR
    DrEmailAddress : PSTR
    OutputFileName : PSTR
}
struct FAX_PRINT_INFOW {
    SizeOfStruct : UInt32
    DocName : PWSTR
    RecipientName : PWSTR
    RecipientNumber : PWSTR
    SenderName : PWSTR
    SenderCompany : PWSTR
    SenderDept : PWSTR
    SenderBillingCode : PWSTR
    Reserved : PWSTR
    DrEmailAddress : PWSTR
    OutputFileName : PWSTR
}
struct FAX_CONTEXT_INFOA {
    SizeOfStruct : UInt32
    hDC : HDC
    ServerName : CHAR[16]
}
struct FAX_CONTEXT_INFOW {
    SizeOfStruct : UInt32
    hDC : HDC
    ServerName : UInt16[16]
}
struct PFAXCONNECTFAXSERVERA extends FunctionPointer {
    static Types := [PSTR, HANDLE.Ptr, BOOL]
}
struct PFAXCONNECTFAXSERVERW extends FunctionPointer {
    static Types := [PWSTR, HANDLE.Ptr, BOOL]
}
struct PFAXCLOSE extends FunctionPointer {
    static Types := [HANDLE, BOOL]
}
struct FAX_ENUM_PORT_OPEN_TYPE extends Int32 {
    static PORT_OPEN_QUERY := 1
    static PORT_OPEN_MODIFY := 2
}
struct PFAXOPENPORT extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt32, HANDLE.Ptr, BOOL]
}
struct PFAXCOMPLETEJOBPARAMSA extends FunctionPointer {
    static Types := [FAX_JOB_PARAMA.Ptr.Ptr, FAX_COVERPAGE_INFOA.Ptr.Ptr, BOOL]
}
struct PFAXCOMPLETEJOBPARAMSW extends FunctionPointer {
    static Types := [FAX_JOB_PARAMW.Ptr.Ptr, FAX_COVERPAGE_INFOW.Ptr.Ptr, BOOL]
}
struct PFAXSENDDOCUMENTA extends FunctionPointer {
    static Types := [HANDLE, PSTR, FAX_JOB_PARAMA.Ptr, FAX_COVERPAGE_INFOA.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXSENDDOCUMENTW extends FunctionPointer {
    static Types := [HANDLE, PWSTR, FAX_JOB_PARAMW.Ptr, FAX_COVERPAGE_INFOW.Ptr, UInt32.Ptr, BOOL]
}
struct PFAX_RECIPIENT_CALLBACKA extends FunctionPointer {
    static Types := [HANDLE, UInt32, Struct.Ptr, FAX_JOB_PARAMA.Ptr, FAX_COVERPAGE_INFOA.Ptr, BOOL]
}
struct PFAX_RECIPIENT_CALLBACKW extends FunctionPointer {
    static Types := [HANDLE, UInt32, Struct.Ptr, FAX_JOB_PARAMW.Ptr, FAX_COVERPAGE_INFOW.Ptr, BOOL]
}
struct PFAXSENDDOCUMENTFORBROADCASTA extends FunctionPointer {
    static Types := [HANDLE, PSTR, UInt32.Ptr, PFAX_RECIPIENT_CALLBACKA, Struct.Ptr, BOOL]
}
struct PFAXSENDDOCUMENTFORBROADCASTW extends FunctionPointer {
    static Types := [HANDLE, PWSTR, UInt32.Ptr, PFAX_RECIPIENT_CALLBACKW, Struct.Ptr, BOOL]
}
struct PFAXENUMJOBSA extends FunctionPointer {
    static Types := [HANDLE, FAX_JOB_ENTRYA.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXENUMJOBSW extends FunctionPointer {
    static Types := [HANDLE, FAX_JOB_ENTRYW.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXGETJOBA extends FunctionPointer {
    static Types := [HANDLE, UInt32, FAX_JOB_ENTRYA.Ptr.Ptr, BOOL]
}
struct PFAXGETJOBW extends FunctionPointer {
    static Types := [HANDLE, UInt32, FAX_JOB_ENTRYW.Ptr.Ptr, BOOL]
}
struct PFAXSETJOBA extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt32, FAX_JOB_ENTRYA.Ptr, BOOL]
}
struct PFAXSETJOBW extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt32, FAX_JOB_ENTRYW.Ptr, BOOL]
}
struct PFAXGETPAGEDATA extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXGETDEVICESTATUSA extends FunctionPointer {
    static Types := [HANDLE, FAX_DEVICE_STATUSA.Ptr.Ptr, BOOL]
}
struct PFAXGETDEVICESTATUSW extends FunctionPointer {
    static Types := [HANDLE, FAX_DEVICE_STATUSW.Ptr.Ptr, BOOL]
}
struct PFAXABORT extends FunctionPointer {
    static Types := [HANDLE, UInt32, BOOL]
}
struct PFAXGETCONFIGURATIONA extends FunctionPointer {
    static Types := [HANDLE, FAX_CONFIGURATIONA.Ptr.Ptr, BOOL]
}
struct PFAXGETCONFIGURATIONW extends FunctionPointer {
    static Types := [HANDLE, FAX_CONFIGURATIONW.Ptr.Ptr, BOOL]
}
struct PFAXSETCONFIGURATIONA extends FunctionPointer {
    static Types := [HANDLE, FAX_CONFIGURATIONA.Ptr, BOOL]
}
struct PFAXSETCONFIGURATIONW extends FunctionPointer {
    static Types := [HANDLE, FAX_CONFIGURATIONW.Ptr, BOOL]
}
struct PFAXGETLOGGINGCATEGORIESA extends FunctionPointer {
    static Types := [HANDLE, FAX_LOG_CATEGORYA.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXGETLOGGINGCATEGORIESW extends FunctionPointer {
    static Types := [HANDLE, FAX_LOG_CATEGORYW.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXSETLOGGINGCATEGORIESA extends FunctionPointer {
    static Types := [HANDLE, FAX_LOG_CATEGORYA.Ptr, UInt32, BOOL]
}
struct PFAXSETLOGGINGCATEGORIESW extends FunctionPointer {
    static Types := [HANDLE, FAX_LOG_CATEGORYW.Ptr, UInt32, BOOL]
}
struct PFAXENUMPORTSA extends FunctionPointer {
    static Types := [HANDLE, FAX_PORT_INFOA.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXENUMPORTSW extends FunctionPointer {
    static Types := [HANDLE, FAX_PORT_INFOW.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXGETPORTA extends FunctionPointer {
    static Types := [HANDLE, FAX_PORT_INFOA.Ptr.Ptr, BOOL]
}
struct PFAXGETPORTW extends FunctionPointer {
    static Types := [HANDLE, FAX_PORT_INFOW.Ptr.Ptr, BOOL]
}
struct PFAXSETPORTA extends FunctionPointer {
    static Types := [HANDLE, FAX_PORT_INFOA.Ptr, BOOL]
}
struct PFAXSETPORTW extends FunctionPointer {
    static Types := [HANDLE, FAX_PORT_INFOW.Ptr, BOOL]
}
struct PFAXENUMROUTINGMETHODSA extends FunctionPointer {
    static Types := [HANDLE, FAX_ROUTING_METHODA.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXENUMROUTINGMETHODSW extends FunctionPointer {
    static Types := [HANDLE, FAX_ROUTING_METHODW.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXENABLEROUTINGMETHODA extends FunctionPointer {
    static Types := [HANDLE, PSTR, BOOL, BOOL]
}
struct PFAXENABLEROUTINGMETHODW extends FunctionPointer {
    static Types := [HANDLE, PWSTR, BOOL, BOOL]
}
struct PFAXENUMGLOBALROUTINGINFOA extends FunctionPointer {
    static Types := [HANDLE, FAX_GLOBAL_ROUTING_INFOA.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXENUMGLOBALROUTINGINFOW extends FunctionPointer {
    static Types := [HANDLE, FAX_GLOBAL_ROUTING_INFOW.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXSETGLOBALROUTINGINFOA extends FunctionPointer {
    static Types := [HANDLE, FAX_GLOBAL_ROUTING_INFOA.Ptr, BOOL]
}
struct PFAXSETGLOBALROUTINGINFOW extends FunctionPointer {
    static Types := [HANDLE, FAX_GLOBAL_ROUTING_INFOW.Ptr, BOOL]
}
struct PFAXGETROUTINGINFOA extends FunctionPointer {
    static Types := [HANDLE, PSTR, UInt8.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXGETROUTINGINFOW extends FunctionPointer {
    static Types := [HANDLE, PWSTR, UInt8.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXSETROUTINGINFOA extends FunctionPointer {
    static Types := [HANDLE, PSTR, UInt8.Ptr, UInt32, BOOL]
}
struct PFAXSETROUTINGINFOW extends FunctionPointer {
    static Types := [HANDLE, PWSTR, UInt8.Ptr, UInt32, BOOL]
}
struct PFAXINITIALIZEEVENTQUEUE extends FunctionPointer {
    static Types := [HANDLE, HANDLE, IntPtr, HWND, UInt32, BOOL]
}
struct PFAXFREEBUFFER extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct PFAXSTARTPRINTJOBA extends FunctionPointer {
    static Types := [PSTR, FAX_PRINT_INFOA.Ptr, UInt32.Ptr, FAX_CONTEXT_INFOA.Ptr, BOOL]
}
struct PFAXSTARTPRINTJOBW extends FunctionPointer {
    static Types := [PWSTR, FAX_PRINT_INFOW.Ptr, UInt32.Ptr, FAX_CONTEXT_INFOW.Ptr, BOOL]
}
struct PFAXPRINTCOVERPAGEA extends FunctionPointer {
    static Types := [FAX_CONTEXT_INFOA.Ptr, FAX_COVERPAGE_INFOA.Ptr, BOOL]
}
struct PFAXPRINTCOVERPAGEW extends FunctionPointer {
    static Types := [FAX_CONTEXT_INFOW.Ptr, FAX_COVERPAGE_INFOW.Ptr, BOOL]
}
struct PFAXREGISTERSERVICEPROVIDERW extends FunctionPointer {
    static Types := [PWSTR, PWSTR, PWSTR, PWSTR, BOOL]
}
struct PFAXUNREGISTERSERVICEPROVIDERW extends FunctionPointer {
    static Types := [PWSTR, BOOL]
}
struct PFAX_ROUTING_INSTALLATION_CALLBACKW extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, PWSTR, PWSTR, PWSTR, PWSTR, BOOL]
}
struct PFAXREGISTERROUTINGEXTENSIONW extends FunctionPointer {
    static Types := [HANDLE, PWSTR, PWSTR, PWSTR, PFAX_ROUTING_INSTALLATION_CALLBACKW, Struct.Ptr, BOOL]
}
struct PFAXACCESSCHECK extends FunctionPointer {
    static Types := [HANDLE, UInt32, BOOL]
}
struct FAX_SEND {
    SizeOfStruct : UInt32
    FileName : PWSTR
    CallerName : PWSTR
    CallerNumber : PWSTR
    ReceiverName : PWSTR
    ReceiverNumber : PWSTR
    Branding : BOOL
    CallHandle : UInt32
    Reserved : UInt32[3]
}
struct FAX_RECEIVE {
    SizeOfStruct : UInt32
    FileName : PWSTR
    ReceiverName : PWSTR
    ReceiverNumber : PWSTR
    Reserved : UInt32[4]
}
struct FAX_DEV_STATUS {
    SizeOfStruct : UInt32
    StatusId : UInt32
    StringId : UInt32
    PageCount : UInt32
    CSI : PWSTR
    CallerId : PWSTR
    RoutingInfo : PWSTR
    ErrorCode : UInt32
    Reserved : UInt32[3]
}
struct PFAX_SERVICE_CALLBACK extends FunctionPointer {
    static Types := [HANDLE, UInt32, IntPtr, IntPtr, IntPtr, BOOL]
}
struct PFAX_LINECALLBACK extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt32, IntPtr, IntPtr, IntPtr, IntPtr, "Void"]
}
struct PFAX_SEND_CALLBACK extends FunctionPointer {
    static Types := [HANDLE, UInt32, UInt32, UInt32, BOOL]
}
struct PFAXDEVINITIALIZE extends FunctionPointer {
    static Types := [UInt32, HANDLE, PFAX_LINECALLBACK.Ptr, PFAX_SERVICE_CALLBACK, BOOL]
}
struct PFAXDEVVIRTUALDEVICECREATION extends FunctionPointer {
    static Types := [UInt32.Ptr, PWSTR, UInt32.Ptr, HANDLE, IntPtr, BOOL]
}
struct PFAXDEVSTARTJOB extends FunctionPointer {
    static Types := [UInt32, UInt32, HANDLE.Ptr, HANDLE, IntPtr, BOOL]
}
struct PFAXDEVENDJOB extends FunctionPointer {
    static Types := [HANDLE, BOOL]
}
struct PFAXDEVSEND extends FunctionPointer {
    static Types := [HANDLE, FAX_SEND.Ptr, PFAX_SEND_CALLBACK, BOOL]
}
struct PFAXDEVRECEIVE extends FunctionPointer {
    static Types := [HANDLE, UInt32, FAX_RECEIVE.Ptr, BOOL]
}
struct PFAXDEVREPORTSTATUS extends FunctionPointer {
    static Types := [HANDLE, FAX_DEV_STATUS.Ptr, UInt32, UInt32.Ptr, BOOL]
}
struct PFAXDEVABORTOPERATION extends FunctionPointer {
    static Types := [HANDLE, BOOL]
}
struct PFAXDEVCONFIGURE extends FunctionPointer {
    static Types := [HPROPSHEETPAGE.Ptr, BOOL]
}
struct PFAXDEVSHUTDOWN extends FunctionPointer {
    static Types := [HRESULT]
}
struct FAX_JOB_STATUS_ENUM extends Int32 {
    static fjsPENDING := 1
    static fjsINPROGRESS := 2
    static fjsFAILED := 8
    static fjsPAUSED := 16
    static fjsNOLINE := 32
    static fjsRETRYING := 64
    static fjsRETRIES_EXCEEDED := 128
    static fjsCOMPLETED := 256
    static fjsCANCELED := 512
    static fjsCANCELING := 1024
    static fjsROUTING := 2048
}
struct FAX_JOB_EXTENDED_STATUS_ENUM extends Int32 {
    static fjesNONE := 0
    static fjesDISCONNECTED := 1
    static fjesINITIALIZING := 2
    static fjesDIALING := 3
    static fjesTRANSMITTING := 4
    static fjesANSWERED := 5
    static fjesRECEIVING := 6
    static fjesLINE_UNAVAILABLE := 7
    static fjesBUSY := 8
    static fjesNO_ANSWER := 9
    static fjesBAD_ADDRESS := 10
    static fjesNO_DIAL_TONE := 11
    static fjesFATAL_ERROR := 12
    static fjesCALL_DELAYED := 13
    static fjesCALL_BLACKLISTED := 14
    static fjesNOT_FAX_CALL := 15
    static fjesPARTIALLY_RECEIVED := 16
    static fjesHANDLED := 17
    static fjesCALL_COMPLETED := 18
    static fjesCALL_ABORTED := 19
    static fjesPROPRIETARY := 16777216
}
struct FAX_JOB_OPERATIONS_ENUM extends Int32 {
    static fjoVIEW := 1
    static fjoPAUSE := 2
    static fjoRESUME := 4
    static fjoRESTART := 8
    static fjoDELETE := 16
    static fjoRECIPIENT_INFO := 32
    static fjoSENDER_INFO := 64
}
struct FAX_JOB_TYPE_ENUM extends Int32 {
    static fjtSEND := 0
    static fjtRECEIVE := 1
    static fjtROUTING := 2
}
struct IFaxJobStatus extends IDispatch {
    static IID := "{8B86F485-FD7F-4824-886B-40C5CAA617CC}"
    get_Status(pStatus)
      => ComCall(7, this.p, FAX_JOB_STATUS_ENUM.Ptr, pStatus)
    get_Pages(plPages)
      => ComCall(8, this.p, Int32.Ptr, plPages)
    get_Size(plSize)
      => ComCall(9, this.p, Int32.Ptr, plSize)
    get_CurrentPage(plCurrentPage)
      => ComCall(10, this.p, Int32.Ptr, plCurrentPage)
    get_DeviceId(plDeviceId)
      => ComCall(11, this.p, Int32.Ptr, plDeviceId)
    get_CSID(pbstrCSID)
      => ComCall(12, this.p, BSTR.Ptr, pbstrCSID)
    get_TSID(pbstrTSID)
      => ComCall(13, this.p, BSTR.Ptr, pbstrTSID)
    get_ExtendedStatusCode(pExtendedStatusCode)
      => ComCall(14, this.p, FAX_JOB_EXTENDED_STATUS_ENUM.Ptr, pExtendedStatusCode)
    get_ExtendedStatus(pbstrExtendedStatus)
      => ComCall(15, this.p, BSTR.Ptr, pbstrExtendedStatus)
    get_AvailableOperations(pAvailableOperations)
      => ComCall(16, this.p, FAX_JOB_OPERATIONS_ENUM.Ptr, pAvailableOperations)
    get_Retries(plRetries)
      => ComCall(17, this.p, Int32.Ptr, plRetries)
    get_JobType(pJobType)
      => ComCall(18, this.p, FAX_JOB_TYPE_ENUM.Ptr, pJobType)
    get_ScheduledTime(pdateScheduledTime)
      => ComCall(19, this.p, Float64.Ptr, pdateScheduledTime)
    get_TransmissionStart(pdateTransmissionStart)
      => ComCall(20, this.p, Float64.Ptr, pdateTransmissionStart)
    get_TransmissionEnd(pdateTransmissionEnd)
      => ComCall(21, this.p, Float64.Ptr, pdateTransmissionEnd)
    get_CallerId(pbstrCallerId)
      => ComCall(22, this.p, BSTR.Ptr, pbstrCallerId)
    get_RoutingInformation(pbstrRoutingInformation)
      => ComCall(23, this.p, BSTR.Ptr, pbstrRoutingInformation)
}
struct FAX_SERVER_EVENTS_TYPE_ENUM extends Int32 {
    static fsetNONE := 0
    static fsetIN_QUEUE := 1
    static fsetOUT_QUEUE := 2
    static fsetCONFIG := 4
    static fsetACTIVITY := 8
    static fsetQUEUE_STATE := 16
    static fsetIN_ARCHIVE := 32
    static fsetOUT_ARCHIVE := 64
    static fsetFXSSVC_ENDED := 128
    static fsetDEVICE_STATUS := 256
    static fsetINCOMING_CALL := 512
}
struct FAX_SERVER_APIVERSION_ENUM extends Int32 {
    static fsAPI_VERSION_0 := 0
    static fsAPI_VERSION_1 := 65536
    static fsAPI_VERSION_2 := 131072
    static fsAPI_VERSION_3 := 196608
}
struct IFaxServer extends IDispatch {
    static IID := "{475B6469-90A5-4878-A577-17A86E8E3462}"
    Connect(bstrServerName)
      => ComCall(7, this.p, BSTR, bstrServerName)
    get_ServerName(pbstrServerName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrServerName)
    GetDeviceProviders(ppFaxDeviceProviders)
      => ComCall(9, this.p, IFaxDeviceProviders.Ptr, ppFaxDeviceProviders)
    GetDevices(ppFaxDevices)
      => ComCall(10, this.p, IFaxDevices.Ptr, ppFaxDevices)
    get_InboundRouting(ppFaxInboundRouting)
      => ComCall(11, this.p, IFaxInboundRouting.Ptr, ppFaxInboundRouting)
    get_Folders(pFaxFolders)
      => ComCall(12, this.p, IFaxFolders.Ptr, pFaxFolders)
    get_LoggingOptions(ppFaxLoggingOptions)
      => ComCall(13, this.p, IFaxLoggingOptions.Ptr, ppFaxLoggingOptions)
    get_MajorVersion(plMajorVersion)
      => ComCall(14, this.p, Int32.Ptr, plMajorVersion)
    get_MinorVersion(plMinorVersion)
      => ComCall(15, this.p, Int32.Ptr, plMinorVersion)
    get_MajorBuild(plMajorBuild)
      => ComCall(16, this.p, Int32.Ptr, plMajorBuild)
    get_MinorBuild(plMinorBuild)
      => ComCall(17, this.p, Int32.Ptr, plMinorBuild)
    get_Debug(pbDebug)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, pbDebug)
    get_Activity(ppFaxActivity)
      => ComCall(19, this.p, IFaxActivity.Ptr, ppFaxActivity)
    get_OutboundRouting(ppFaxOutboundRouting)
      => ComCall(20, this.p, IFaxOutboundRouting.Ptr, ppFaxOutboundRouting)
    get_ReceiptOptions(ppFaxReceiptOptions)
      => ComCall(21, this.p, IFaxReceiptOptions.Ptr, ppFaxReceiptOptions)
    get_Security(ppFaxSecurity)
      => ComCall(22, this.p, IFaxSecurity.Ptr, ppFaxSecurity)
    Disconnect()
      => ComCall(23, this.p)
    GetExtensionProperty(bstrGUID, pvProperty)
      => ComCall(24, this.p, BSTR, bstrGUID, VARIANT.Ptr, pvProperty)
    SetExtensionProperty(bstrGUID, vProperty)
      => ComCall(25, this.p, BSTR, bstrGUID, VARIANT, vProperty)
    ListenToServerEvents(EventTypes)
      => ComCall(26, this.p, FAX_SERVER_EVENTS_TYPE_ENUM, EventTypes)
    RegisterDeviceProvider(bstrGUID, bstrFriendlyName, bstrImageName, TspName, lFSPIVersion)
      => ComCall(27, this.p, BSTR, bstrGUID, BSTR, bstrFriendlyName, BSTR, bstrImageName, BSTR, TspName, Int32, lFSPIVersion)
    UnregisterDeviceProvider(bstrUniqueName)
      => ComCall(28, this.p, BSTR, bstrUniqueName)
    RegisterInboundRoutingExtension(bstrExtensionName, bstrFriendlyName, bstrImageName, vMethods)
      => ComCall(29, this.p, BSTR, bstrExtensionName, BSTR, bstrFriendlyName, BSTR, bstrImageName, VARIANT, vMethods)
    UnregisterInboundRoutingExtension(bstrExtensionUniqueName)
      => ComCall(30, this.p, BSTR, bstrExtensionUniqueName)
    get_RegisteredEvents(pEventTypes)
      => ComCall(31, this.p, FAX_SERVER_EVENTS_TYPE_ENUM.Ptr, pEventTypes)
    get_APIVersion(pAPIVersion)
      => ComCall(32, this.p, FAX_SERVER_APIVERSION_ENUM.Ptr, pAPIVersion)
}
struct IFaxDeviceProviders extends IDispatch {
    static IID := "{9FB76F62-4C7E-43A5-B6FD-502893F7E13E}"
    get__NewEnum(ppUnk)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnk)
    get_Item(vIndex, pFaxDeviceProvider)
      => ComCall(8, this.p, VARIANT, vIndex, IFaxDeviceProvider.Ptr, pFaxDeviceProvider)
    get_Count(plCount)
      => ComCall(9, this.p, Int32.Ptr, plCount)
}
struct IFaxDevices extends IDispatch {
    static IID := "{9E46783E-F34F-482E-A360-0416BECBBD96}"
    get__NewEnum(ppUnk)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnk)
    get_Item(vIndex, pFaxDevice)
      => ComCall(8, this.p, VARIANT, vIndex, IFaxDevice.Ptr, pFaxDevice)
    get_Count(plCount)
      => ComCall(9, this.p, Int32.Ptr, plCount)
    get_ItemById(lId, ppFaxDevice)
      => ComCall(10, this.p, Int32, lId, IFaxDevice.Ptr, ppFaxDevice)
}
struct IFaxInboundRouting extends IDispatch {
    static IID := "{8148C20F-9D52-45B1-BF96-38FC12713527}"
    GetExtensions(pFaxInboundRoutingExtensions)
      => ComCall(7, this.p, IFaxInboundRoutingExtensions.Ptr, pFaxInboundRoutingExtensions)
    GetMethods(pFaxInboundRoutingMethods)
      => ComCall(8, this.p, IFaxInboundRoutingMethods.Ptr, pFaxInboundRoutingMethods)
}
struct IFaxFolders extends IDispatch {
    static IID := "{DCE3B2A8-A7AB-42BC-9D0A-3149457261A0}"
    get_OutgoingQueue(pFaxOutgoingQueue)
      => ComCall(7, this.p, IFaxOutgoingQueue.Ptr, pFaxOutgoingQueue)
    get_IncomingQueue(pFaxIncomingQueue)
      => ComCall(8, this.p, IFaxIncomingQueue.Ptr, pFaxIncomingQueue)
    get_IncomingArchive(pFaxIncomingArchive)
      => ComCall(9, this.p, IFaxIncomingArchive.Ptr, pFaxIncomingArchive)
    get_OutgoingArchive(pFaxOutgoingArchive)
      => ComCall(10, this.p, IFaxOutgoingArchive.Ptr, pFaxOutgoingArchive)
}
struct IFaxLoggingOptions extends IDispatch {
    static IID := "{34E64FB9-6B31-4D32-8B27-D286C0C33606}"
    get_EventLogging(pFaxEventLogging)
      => ComCall(7, this.p, IFaxEventLogging.Ptr, pFaxEventLogging)
    get_ActivityLogging(pFaxActivityLogging)
      => ComCall(8, this.p, IFaxActivityLogging.Ptr, pFaxActivityLogging)
}
struct IFaxActivity extends IDispatch {
    static IID := "{4B106F97-3DF5-40F2-BC3C-44CB8115EBDF}"
    get_IncomingMessages(plIncomingMessages)
      => ComCall(7, this.p, Int32.Ptr, plIncomingMessages)
    get_RoutingMessages(plRoutingMessages)
      => ComCall(8, this.p, Int32.Ptr, plRoutingMessages)
    get_OutgoingMessages(plOutgoingMessages)
      => ComCall(9, this.p, Int32.Ptr, plOutgoingMessages)
    get_QueuedMessages(plQueuedMessages)
      => ComCall(10, this.p, Int32.Ptr, plQueuedMessages)
    Refresh()
      => ComCall(11, this.p)
}
struct IFaxOutboundRouting extends IDispatch {
    static IID := "{25DC05A4-9909-41BD-A95B-7E5D1DEC1D43}"
    GetGroups(pFaxOutboundRoutingGroups)
      => ComCall(7, this.p, IFaxOutboundRoutingGroups.Ptr, pFaxOutboundRoutingGroups)
    GetRules(pFaxOutboundRoutingRules)
      => ComCall(8, this.p, IFaxOutboundRoutingRules.Ptr, pFaxOutboundRoutingRules)
}
struct FAX_SMTP_AUTHENTICATION_TYPE_ENUM extends Int32 {
    static fsatANONYMOUS := 0
    static fsatBASIC := 1
    static fsatNTLM := 2
}
struct FAX_RECEIPT_TYPE_ENUM extends Int32 {
    static frtNONE := 0
    static frtMAIL := 1
    static frtMSGBOX := 4
}
struct IFaxReceiptOptions extends IDispatch {
    static IID := "{378EFAEB-5FCB-4AFB-B2EE-E16E80614487}"
    get_AuthenticationType(pType)
      => ComCall(7, this.p, FAX_SMTP_AUTHENTICATION_TYPE_ENUM.Ptr, pType)
    put_AuthenticationType(Type)
      => ComCall(8, this.p, FAX_SMTP_AUTHENTICATION_TYPE_ENUM, Type)
    get_SMTPServer(pbstrSMTPServer)
      => ComCall(9, this.p, BSTR.Ptr, pbstrSMTPServer)
    put_SMTPServer(bstrSMTPServer)
      => ComCall(10, this.p, BSTR, bstrSMTPServer)
    get_SMTPPort(plSMTPPort)
      => ComCall(11, this.p, Int32.Ptr, plSMTPPort)
    put_SMTPPort(lSMTPPort)
      => ComCall(12, this.p, Int32, lSMTPPort)
    get_SMTPSender(pbstrSMTPSender)
      => ComCall(13, this.p, BSTR.Ptr, pbstrSMTPSender)
    put_SMTPSender(bstrSMTPSender)
      => ComCall(14, this.p, BSTR, bstrSMTPSender)
    get_SMTPUser(pbstrSMTPUser)
      => ComCall(15, this.p, BSTR.Ptr, pbstrSMTPUser)
    put_SMTPUser(bstrSMTPUser)
      => ComCall(16, this.p, BSTR, bstrSMTPUser)
    get_AllowedReceipts(pAllowedReceipts)
      => ComCall(17, this.p, FAX_RECEIPT_TYPE_ENUM.Ptr, pAllowedReceipts)
    put_AllowedReceipts(AllowedReceipts)
      => ComCall(18, this.p, FAX_RECEIPT_TYPE_ENUM, AllowedReceipts)
    get_SMTPPassword(pbstrSMTPPassword)
      => ComCall(19, this.p, BSTR.Ptr, pbstrSMTPPassword)
    put_SMTPPassword(bstrSMTPPassword)
      => ComCall(20, this.p, BSTR, bstrSMTPPassword)
    Refresh()
      => ComCall(21, this.p)
    Save()
      => ComCall(22, this.p)
    get_UseForInboundRouting(pbUseForInboundRouting)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, pbUseForInboundRouting)
    put_UseForInboundRouting(bUseForInboundRouting)
      => ComCall(24, this.p, VARIANT_BOOL, bUseForInboundRouting)
}
struct FAX_ACCESS_RIGHTS_ENUM extends Int32 {
    static farSUBMIT_LOW := 1
    static farSUBMIT_NORMAL := 2
    static farSUBMIT_HIGH := 4
    static farQUERY_JOBS := 8
    static farMANAGE_JOBS := 16
    static farQUERY_CONFIG := 32
    static farMANAGE_CONFIG := 64
    static farQUERY_IN_ARCHIVE := 128
    static farMANAGE_IN_ARCHIVE := 256
    static farQUERY_OUT_ARCHIVE := 512
    static farMANAGE_OUT_ARCHIVE := 1024
}
struct IFaxSecurity extends IDispatch {
    static IID := "{77B508C1-09C0-47A2-91EB-FCE7FDF2690E}"
    get_Descriptor(pvDescriptor)
      => ComCall(7, this.p, VARIANT.Ptr, pvDescriptor)
    put_Descriptor(vDescriptor)
      => ComCall(8, this.p, VARIANT, vDescriptor)
    get_GrantedRights(pGrantedRights)
      => ComCall(9, this.p, FAX_ACCESS_RIGHTS_ENUM.Ptr, pGrantedRights)
    Refresh()
      => ComCall(10, this.p)
    Save()
      => ComCall(11, this.p)
    get_InformationType(plInformationType)
      => ComCall(12, this.p, Int32.Ptr, plInformationType)
    put_InformationType(lInformationType)
      => ComCall(13, this.p, Int32, lInformationType)
}
struct FAX_PRIORITY_TYPE_ENUM extends Int32 {
    static fptLOW := 0
    static fptNORMAL := 1
    static fptHIGH := 2
}
struct FAX_COVERPAGE_TYPE_ENUM extends Int32 {
    static fcptNONE := 0
    static fcptLOCAL := 1
    static fcptSERVER := 2
}
struct FAX_SCHEDULE_TYPE_ENUM extends Int32 {
    static fstNOW := 0
    static fstSPECIFIC_TIME := 1
    static fstDISCOUNT_PERIOD := 2
}
struct IFaxDocument extends IDispatch {
    static IID := "{B207A246-09E3-4A4E-A7DC-FEA31D29458F}"
    get_Body(pbstrBody)
      => ComCall(7, this.p, BSTR.Ptr, pbstrBody)
    put_Body(bstrBody)
      => ComCall(8, this.p, BSTR, bstrBody)
    get_Sender(ppFaxSender)
      => ComCall(9, this.p, IFaxSender.Ptr, ppFaxSender)
    get_Recipients(ppFaxRecipients)
      => ComCall(10, this.p, IFaxRecipients.Ptr, ppFaxRecipients)
    get_CoverPage(pbstrCoverPage)
      => ComCall(11, this.p, BSTR.Ptr, pbstrCoverPage)
    put_CoverPage(bstrCoverPage)
      => ComCall(12, this.p, BSTR, bstrCoverPage)
    get_Subject(pbstrSubject)
      => ComCall(13, this.p, BSTR.Ptr, pbstrSubject)
    put_Subject(bstrSubject)
      => ComCall(14, this.p, BSTR, bstrSubject)
    get_Note(pbstrNote)
      => ComCall(15, this.p, BSTR.Ptr, pbstrNote)
    put_Note(bstrNote)
      => ComCall(16, this.p, BSTR, bstrNote)
    get_ScheduleTime(pdateScheduleTime)
      => ComCall(17, this.p, Float64.Ptr, pdateScheduleTime)
    put_ScheduleTime(dateScheduleTime)
      => ComCall(18, this.p, Float64, dateScheduleTime)
    get_ReceiptAddress(pbstrReceiptAddress)
      => ComCall(19, this.p, BSTR.Ptr, pbstrReceiptAddress)
    put_ReceiptAddress(bstrReceiptAddress)
      => ComCall(20, this.p, BSTR, bstrReceiptAddress)
    get_DocumentName(pbstrDocumentName)
      => ComCall(21, this.p, BSTR.Ptr, pbstrDocumentName)
    put_DocumentName(bstrDocumentName)
      => ComCall(22, this.p, BSTR, bstrDocumentName)
    get_CallHandle(plCallHandle)
      => ComCall(23, this.p, Int32.Ptr, plCallHandle)
    put_CallHandle(lCallHandle)
      => ComCall(24, this.p, Int32, lCallHandle)
    get_CoverPageType(pCoverPageType)
      => ComCall(25, this.p, FAX_COVERPAGE_TYPE_ENUM.Ptr, pCoverPageType)
    put_CoverPageType(CoverPageType)
      => ComCall(26, this.p, FAX_COVERPAGE_TYPE_ENUM, CoverPageType)
    get_ScheduleType(pScheduleType)
      => ComCall(27, this.p, FAX_SCHEDULE_TYPE_ENUM.Ptr, pScheduleType)
    put_ScheduleType(ScheduleType)
      => ComCall(28, this.p, FAX_SCHEDULE_TYPE_ENUM, ScheduleType)
    get_ReceiptType(pReceiptType)
      => ComCall(29, this.p, FAX_RECEIPT_TYPE_ENUM.Ptr, pReceiptType)
    put_ReceiptType(ReceiptType)
      => ComCall(30, this.p, FAX_RECEIPT_TYPE_ENUM, ReceiptType)
    get_GroupBroadcastReceipts(pbUseGrouping)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, pbUseGrouping)
    put_GroupBroadcastReceipts(bUseGrouping)
      => ComCall(32, this.p, VARIANT_BOOL, bUseGrouping)
    get_Priority(pPriority)
      => ComCall(33, this.p, FAX_PRIORITY_TYPE_ENUM.Ptr, pPriority)
    put_Priority(Priority)
      => ComCall(34, this.p, FAX_PRIORITY_TYPE_ENUM, Priority)
    get_TapiConnection(ppTapiConnection)
      => ComCall(35, this.p, IDispatch.Ptr, ppTapiConnection)
    putref_TapiConnection(pTapiConnection?)
      => ComCall(36, this.p, IDispatch, pTapiConnection?)
    Submit(bstrFaxServerName, pvFaxOutgoingJobIDs)
      => ComCall(37, this.p, BSTR, bstrFaxServerName, VARIANT.Ptr, pvFaxOutgoingJobIDs)
    ConnectedSubmit(pFaxServer?, pvFaxOutgoingJobIDs)
      => ComCall(38, this.p, IFaxServer, pFaxServer?, VARIANT.Ptr, pvFaxOutgoingJobIDs)
    get_AttachFaxToReceipt(pbAttachFax)
      => ComCall(39, this.p, VARIANT_BOOL.Ptr, pbAttachFax)
    put_AttachFaxToReceipt(bAttachFax)
      => ComCall(40, this.p, VARIANT_BOOL, bAttachFax)
}
struct IFaxSender extends IDispatch {
    static IID := "{0D879D7D-F57A-4CC6-A6F9-3EE5D527B46A}"
    get_BillingCode(pbstrBillingCode)
      => ComCall(7, this.p, BSTR.Ptr, pbstrBillingCode)
    put_BillingCode(bstrBillingCode)
      => ComCall(8, this.p, BSTR, bstrBillingCode)
    get_City(pbstrCity)
      => ComCall(9, this.p, BSTR.Ptr, pbstrCity)
    put_City(bstrCity)
      => ComCall(10, this.p, BSTR, bstrCity)
    get_Company(pbstrCompany)
      => ComCall(11, this.p, BSTR.Ptr, pbstrCompany)
    put_Company(bstrCompany)
      => ComCall(12, this.p, BSTR, bstrCompany)
    get_Country(pbstrCountry)
      => ComCall(13, this.p, BSTR.Ptr, pbstrCountry)
    put_Country(bstrCountry)
      => ComCall(14, this.p, BSTR, bstrCountry)
    get_Department(pbstrDepartment)
      => ComCall(15, this.p, BSTR.Ptr, pbstrDepartment)
    put_Department(bstrDepartment)
      => ComCall(16, this.p, BSTR, bstrDepartment)
    get_Email(pbstrEmail)
      => ComCall(17, this.p, BSTR.Ptr, pbstrEmail)
    put_Email(bstrEmail)
      => ComCall(18, this.p, BSTR, bstrEmail)
    get_FaxNumber(pbstrFaxNumber)
      => ComCall(19, this.p, BSTR.Ptr, pbstrFaxNumber)
    put_FaxNumber(bstrFaxNumber)
      => ComCall(20, this.p, BSTR, bstrFaxNumber)
    get_HomePhone(pbstrHomePhone)
      => ComCall(21, this.p, BSTR.Ptr, pbstrHomePhone)
    put_HomePhone(bstrHomePhone)
      => ComCall(22, this.p, BSTR, bstrHomePhone)
    get_Name(pbstrName)
      => ComCall(23, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrName)
      => ComCall(24, this.p, BSTR, bstrName)
    get_TSID(pbstrTSID)
      => ComCall(25, this.p, BSTR.Ptr, pbstrTSID)
    put_TSID(bstrTSID)
      => ComCall(26, this.p, BSTR, bstrTSID)
    get_OfficePhone(pbstrOfficePhone)
      => ComCall(27, this.p, BSTR.Ptr, pbstrOfficePhone)
    put_OfficePhone(bstrOfficePhone)
      => ComCall(28, this.p, BSTR, bstrOfficePhone)
    get_OfficeLocation(pbstrOfficeLocation)
      => ComCall(29, this.p, BSTR.Ptr, pbstrOfficeLocation)
    put_OfficeLocation(bstrOfficeLocation)
      => ComCall(30, this.p, BSTR, bstrOfficeLocation)
    get_State(pbstrState)
      => ComCall(31, this.p, BSTR.Ptr, pbstrState)
    put_State(bstrState)
      => ComCall(32, this.p, BSTR, bstrState)
    get_StreetAddress(pbstrStreetAddress)
      => ComCall(33, this.p, BSTR.Ptr, pbstrStreetAddress)
    put_StreetAddress(bstrStreetAddress)
      => ComCall(34, this.p, BSTR, bstrStreetAddress)
    get_Title(pbstrTitle)
      => ComCall(35, this.p, BSTR.Ptr, pbstrTitle)
    put_Title(bstrTitle)
      => ComCall(36, this.p, BSTR, bstrTitle)
    get_ZipCode(pbstrZipCode)
      => ComCall(37, this.p, BSTR.Ptr, pbstrZipCode)
    put_ZipCode(bstrZipCode)
      => ComCall(38, this.p, BSTR, bstrZipCode)
    LoadDefaultSender()
      => ComCall(39, this.p)
    SaveDefaultSender()
      => ComCall(40, this.p)
}
struct IFaxRecipient extends IDispatch {
    static IID := "{9A3DA3A0-538D-42B6-9444-AAA57D0CE2BC}"
    get_FaxNumber(pbstrFaxNumber)
      => ComCall(7, this.p, BSTR.Ptr, pbstrFaxNumber)
    put_FaxNumber(bstrFaxNumber)
      => ComCall(8, this.p, BSTR, bstrFaxNumber)
    get_Name(pbstrName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrName)
    put_Name(bstrName)
      => ComCall(10, this.p, BSTR, bstrName)
}
struct IFaxRecipients extends IDispatch {
    static IID := "{B9C9DE5A-894E-4492-9FA3-08C627C11D5D}"
    get__NewEnum(ppUnk)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnk)
    get_Item(lIndex, ppFaxRecipient)
      => ComCall(8, this.p, Int32, lIndex, IFaxRecipient.Ptr, ppFaxRecipient)
    get_Count(plCount)
      => ComCall(9, this.p, Int32.Ptr, plCount)
    Add(bstrFaxNumber, bstrRecipientName, ppFaxRecipient)
      => ComCall(10, this.p, BSTR, bstrFaxNumber, BSTR, bstrRecipientName, IFaxRecipient.Ptr, ppFaxRecipient)
    Remove(lIndex)
      => ComCall(11, this.p, Int32, lIndex)
}
struct IFaxIncomingArchive extends IDispatch {
    static IID := "{76062CC7-F714-4FBD-AA06-ED6E4A4B70F3}"
    get_UseArchive(pbUseArchive)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pbUseArchive)
    put_UseArchive(bUseArchive)
      => ComCall(8, this.p, VARIANT_BOOL, bUseArchive)
    get_ArchiveFolder(pbstrArchiveFolder)
      => ComCall(9, this.p, BSTR.Ptr, pbstrArchiveFolder)
    put_ArchiveFolder(bstrArchiveFolder)
      => ComCall(10, this.p, BSTR, bstrArchiveFolder)
    get_SizeQuotaWarning(pbSizeQuotaWarning)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pbSizeQuotaWarning)
    put_SizeQuotaWarning(bSizeQuotaWarning)
      => ComCall(12, this.p, VARIANT_BOOL, bSizeQuotaWarning)
    get_HighQuotaWaterMark(plHighQuotaWaterMark)
      => ComCall(13, this.p, Int32.Ptr, plHighQuotaWaterMark)
    put_HighQuotaWaterMark(lHighQuotaWaterMark)
      => ComCall(14, this.p, Int32, lHighQuotaWaterMark)
    get_LowQuotaWaterMark(plLowQuotaWaterMark)
      => ComCall(15, this.p, Int32.Ptr, plLowQuotaWaterMark)
    put_LowQuotaWaterMark(lLowQuotaWaterMark)
      => ComCall(16, this.p, Int32, lLowQuotaWaterMark)
    get_AgeLimit(plAgeLimit)
      => ComCall(17, this.p, Int32.Ptr, plAgeLimit)
    put_AgeLimit(lAgeLimit)
      => ComCall(18, this.p, Int32, lAgeLimit)
    get_SizeLow(plSizeLow)
      => ComCall(19, this.p, Int32.Ptr, plSizeLow)
    get_SizeHigh(plSizeHigh)
      => ComCall(20, this.p, Int32.Ptr, plSizeHigh)
    Refresh()
      => ComCall(21, this.p)
    Save()
      => ComCall(22, this.p)
    GetMessages(lPrefetchSize, pFaxIncomingMessageIterator)
      => ComCall(23, this.p, Int32, lPrefetchSize, IFaxIncomingMessageIterator.Ptr, pFaxIncomingMessageIterator)
    GetMessage(bstrMessageId, pFaxIncomingMessage)
      => ComCall(24, this.p, BSTR, bstrMessageId, IFaxIncomingMessage.Ptr, pFaxIncomingMessage)
}
struct IFaxIncomingQueue extends IDispatch {
    static IID := "{902E64EF-8FD8-4B75-9725-6014DF161545}"
    get_Blocked(pbBlocked)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pbBlocked)
    put_Blocked(bBlocked)
      => ComCall(8, this.p, VARIANT_BOOL, bBlocked)
    Refresh()
      => ComCall(9, this.p)
    Save()
      => ComCall(10, this.p)
    GetJobs(pFaxIncomingJobs)
      => ComCall(11, this.p, IFaxIncomingJobs.Ptr, pFaxIncomingJobs)
    GetJob(bstrJobId, pFaxIncomingJob)
      => ComCall(12, this.p, BSTR, bstrJobId, IFaxIncomingJob.Ptr, pFaxIncomingJob)
}
struct IFaxOutgoingArchive extends IDispatch {
    static IID := "{C9C28F40-8D80-4E53-810F-9A79919B49FD}"
    get_UseArchive(pbUseArchive)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pbUseArchive)
    put_UseArchive(bUseArchive)
      => ComCall(8, this.p, VARIANT_BOOL, bUseArchive)
    get_ArchiveFolder(pbstrArchiveFolder)
      => ComCall(9, this.p, BSTR.Ptr, pbstrArchiveFolder)
    put_ArchiveFolder(bstrArchiveFolder)
      => ComCall(10, this.p, BSTR, bstrArchiveFolder)
    get_SizeQuotaWarning(pbSizeQuotaWarning)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pbSizeQuotaWarning)
    put_SizeQuotaWarning(bSizeQuotaWarning)
      => ComCall(12, this.p, VARIANT_BOOL, bSizeQuotaWarning)
    get_HighQuotaWaterMark(plHighQuotaWaterMark)
      => ComCall(13, this.p, Int32.Ptr, plHighQuotaWaterMark)
    put_HighQuotaWaterMark(lHighQuotaWaterMark)
      => ComCall(14, this.p, Int32, lHighQuotaWaterMark)
    get_LowQuotaWaterMark(plLowQuotaWaterMark)
      => ComCall(15, this.p, Int32.Ptr, plLowQuotaWaterMark)
    put_LowQuotaWaterMark(lLowQuotaWaterMark)
      => ComCall(16, this.p, Int32, lLowQuotaWaterMark)
    get_AgeLimit(plAgeLimit)
      => ComCall(17, this.p, Int32.Ptr, plAgeLimit)
    put_AgeLimit(lAgeLimit)
      => ComCall(18, this.p, Int32, lAgeLimit)
    get_SizeLow(plSizeLow)
      => ComCall(19, this.p, Int32.Ptr, plSizeLow)
    get_SizeHigh(plSizeHigh)
      => ComCall(20, this.p, Int32.Ptr, plSizeHigh)
    Refresh()
      => ComCall(21, this.p)
    Save()
      => ComCall(22, this.p)
    GetMessages(lPrefetchSize, pFaxOutgoingMessageIterator)
      => ComCall(23, this.p, Int32, lPrefetchSize, IFaxOutgoingMessageIterator.Ptr, pFaxOutgoingMessageIterator)
    GetMessage(bstrMessageId, pFaxOutgoingMessage)
      => ComCall(24, this.p, BSTR, bstrMessageId, IFaxOutgoingMessage.Ptr, pFaxOutgoingMessage)
}
struct IFaxOutgoingQueue extends IDispatch {
    static IID := "{80B1DF24-D9AC-4333-B373-487CEDC80CE5}"
    get_Blocked(pbBlocked)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pbBlocked)
    put_Blocked(bBlocked)
      => ComCall(8, this.p, VARIANT_BOOL, bBlocked)
    get_Paused(pbPaused)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pbPaused)
    put_Paused(bPaused)
      => ComCall(10, this.p, VARIANT_BOOL, bPaused)
    get_AllowPersonalCoverPages(pbAllowPersonalCoverPages)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pbAllowPersonalCoverPages)
    put_AllowPersonalCoverPages(bAllowPersonalCoverPages)
      => ComCall(12, this.p, VARIANT_BOOL, bAllowPersonalCoverPages)
    get_UseDeviceTSID(pbUseDeviceTSID)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pbUseDeviceTSID)
    put_UseDeviceTSID(bUseDeviceTSID)
      => ComCall(14, this.p, VARIANT_BOOL, bUseDeviceTSID)
    get_Retries(plRetries)
      => ComCall(15, this.p, Int32.Ptr, plRetries)
    put_Retries(lRetries)
      => ComCall(16, this.p, Int32, lRetries)
    get_RetryDelay(plRetryDelay)
      => ComCall(17, this.p, Int32.Ptr, plRetryDelay)
    put_RetryDelay(lRetryDelay)
      => ComCall(18, this.p, Int32, lRetryDelay)
    get_DiscountRateStart(pdateDiscountRateStart)
      => ComCall(19, this.p, Float64.Ptr, pdateDiscountRateStart)
    put_DiscountRateStart(dateDiscountRateStart)
      => ComCall(20, this.p, Float64, dateDiscountRateStart)
    get_DiscountRateEnd(pdateDiscountRateEnd)
      => ComCall(21, this.p, Float64.Ptr, pdateDiscountRateEnd)
    put_DiscountRateEnd(dateDiscountRateEnd)
      => ComCall(22, this.p, Float64, dateDiscountRateEnd)
    get_AgeLimit(plAgeLimit)
      => ComCall(23, this.p, Int32.Ptr, plAgeLimit)
    put_AgeLimit(lAgeLimit)
      => ComCall(24, this.p, Int32, lAgeLimit)
    get_Branding(pbBranding)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, pbBranding)
    put_Branding(bBranding)
      => ComCall(26, this.p, VARIANT_BOOL, bBranding)
    Refresh()
      => ComCall(27, this.p)
    Save()
      => ComCall(28, this.p)
    GetJobs(pFaxOutgoingJobs)
      => ComCall(29, this.p, IFaxOutgoingJobs.Ptr, pFaxOutgoingJobs)
    GetJob(bstrJobId, pFaxOutgoingJob)
      => ComCall(30, this.p, BSTR, bstrJobId, IFaxOutgoingJob.Ptr, pFaxOutgoingJob)
}
struct IFaxIncomingMessageIterator extends IDispatch {
    static IID := "{FD73ECC4-6F06-4F52-82A8-F7BA06AE3108}"
    get_Message(pFaxIncomingMessage)
      => ComCall(7, this.p, IFaxIncomingMessage.Ptr, pFaxIncomingMessage)
    get_PrefetchSize(plPrefetchSize)
      => ComCall(8, this.p, Int32.Ptr, plPrefetchSize)
    put_PrefetchSize(lPrefetchSize)
      => ComCall(9, this.p, Int32, lPrefetchSize)
    get_AtEOF(pbEOF)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pbEOF)
    MoveFirst()
      => ComCall(11, this.p)
    MoveNext()
      => ComCall(12, this.p)
}
struct IFaxIncomingMessage extends IDispatch {
    static IID := "{7CAB88FA-2EF9-4851-B2F3-1D148FED8447}"
    get_Id(pbstrId)
      => ComCall(7, this.p, BSTR.Ptr, pbstrId)
    get_Pages(plPages)
      => ComCall(8, this.p, Int32.Ptr, plPages)
    get_Size(plSize)
      => ComCall(9, this.p, Int32.Ptr, plSize)
    get_DeviceName(pbstrDeviceName)
      => ComCall(10, this.p, BSTR.Ptr, pbstrDeviceName)
    get_Retries(plRetries)
      => ComCall(11, this.p, Int32.Ptr, plRetries)
    get_TransmissionStart(pdateTransmissionStart)
      => ComCall(12, this.p, Float64.Ptr, pdateTransmissionStart)
    get_TransmissionEnd(pdateTransmissionEnd)
      => ComCall(13, this.p, Float64.Ptr, pdateTransmissionEnd)
    get_CSID(pbstrCSID)
      => ComCall(14, this.p, BSTR.Ptr, pbstrCSID)
    get_TSID(pbstrTSID)
      => ComCall(15, this.p, BSTR.Ptr, pbstrTSID)
    get_CallerId(pbstrCallerId)
      => ComCall(16, this.p, BSTR.Ptr, pbstrCallerId)
    get_RoutingInformation(pbstrRoutingInformation)
      => ComCall(17, this.p, BSTR.Ptr, pbstrRoutingInformation)
    CopyTiff(bstrTiffPath)
      => ComCall(18, this.p, BSTR, bstrTiffPath)
    Delete()
      => ComCall(19, this.p)
}
struct IFaxOutgoingJobs extends IDispatch {
    static IID := "{2C56D8E6-8C2F-4573-944C-E505F8F5AEED}"
    get__NewEnum(ppUnk)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnk)
    get_Item(vIndex, pFaxOutgoingJob)
      => ComCall(8, this.p, VARIANT, vIndex, IFaxOutgoingJob.Ptr, pFaxOutgoingJob)
    get_Count(plCount)
      => ComCall(9, this.p, Int32.Ptr, plCount)
}
struct IFaxOutgoingJob extends IDispatch {
    static IID := "{6356DAAD-6614-4583-BF7A-3AD67BBFC71C}"
    get_Subject(pbstrSubject)
      => ComCall(7, this.p, BSTR.Ptr, pbstrSubject)
    get_DocumentName(pbstrDocumentName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrDocumentName)
    get_Pages(plPages)
      => ComCall(9, this.p, Int32.Ptr, plPages)
    get_Size(plSize)
      => ComCall(10, this.p, Int32.Ptr, plSize)
    get_SubmissionId(pbstrSubmissionId)
      => ComCall(11, this.p, BSTR.Ptr, pbstrSubmissionId)
    get_Id(pbstrId)
      => ComCall(12, this.p, BSTR.Ptr, pbstrId)
    get_OriginalScheduledTime(pdateOriginalScheduledTime)
      => ComCall(13, this.p, Float64.Ptr, pdateOriginalScheduledTime)
    get_SubmissionTime(pdateSubmissionTime)
      => ComCall(14, this.p, Float64.Ptr, pdateSubmissionTime)
    get_ReceiptType(pReceiptType)
      => ComCall(15, this.p, FAX_RECEIPT_TYPE_ENUM.Ptr, pReceiptType)
    get_Priority(pPriority)
      => ComCall(16, this.p, FAX_PRIORITY_TYPE_ENUM.Ptr, pPriority)
    get_Sender(ppFaxSender)
      => ComCall(17, this.p, IFaxSender.Ptr, ppFaxSender)
    get_Recipient(ppFaxRecipient)
      => ComCall(18, this.p, IFaxRecipient.Ptr, ppFaxRecipient)
    get_CurrentPage(plCurrentPage)
      => ComCall(19, this.p, Int32.Ptr, plCurrentPage)
    get_DeviceId(plDeviceId)
      => ComCall(20, this.p, Int32.Ptr, plDeviceId)
    get_Status(pStatus)
      => ComCall(21, this.p, FAX_JOB_STATUS_ENUM.Ptr, pStatus)
    get_ExtendedStatusCode(pExtendedStatusCode)
      => ComCall(22, this.p, FAX_JOB_EXTENDED_STATUS_ENUM.Ptr, pExtendedStatusCode)
    get_ExtendedStatus(pbstrExtendedStatus)
      => ComCall(23, this.p, BSTR.Ptr, pbstrExtendedStatus)
    get_AvailableOperations(pAvailableOperations)
      => ComCall(24, this.p, FAX_JOB_OPERATIONS_ENUM.Ptr, pAvailableOperations)
    get_Retries(plRetries)
      => ComCall(25, this.p, Int32.Ptr, plRetries)
    get_ScheduledTime(pdateScheduledTime)
      => ComCall(26, this.p, Float64.Ptr, pdateScheduledTime)
    get_TransmissionStart(pdateTransmissionStart)
      => ComCall(27, this.p, Float64.Ptr, pdateTransmissionStart)
    get_TransmissionEnd(pdateTransmissionEnd)
      => ComCall(28, this.p, Float64.Ptr, pdateTransmissionEnd)
    get_CSID(pbstrCSID)
      => ComCall(29, this.p, BSTR.Ptr, pbstrCSID)
    get_TSID(pbstrTSID)
      => ComCall(30, this.p, BSTR.Ptr, pbstrTSID)
    get_GroupBroadcastReceipts(pbGroupBroadcastReceipts)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, pbGroupBroadcastReceipts)
    Pause()
      => ComCall(32, this.p)
    Resume()
      => ComCall(33, this.p)
    Restart()
      => ComCall(34, this.p)
    CopyTiff(bstrTiffPath)
      => ComCall(35, this.p, BSTR, bstrTiffPath)
    Refresh()
      => ComCall(36, this.p)
    Cancel()
      => ComCall(37, this.p)
}
struct IFaxOutgoingMessageIterator extends IDispatch {
    static IID := "{F5EC5D4F-B840-432F-9980-112FE42A9B7A}"
    get_Message(pFaxOutgoingMessage)
      => ComCall(7, this.p, IFaxOutgoingMessage.Ptr, pFaxOutgoingMessage)
    get_AtEOF(pbEOF)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, pbEOF)
    get_PrefetchSize(plPrefetchSize)
      => ComCall(9, this.p, Int32.Ptr, plPrefetchSize)
    put_PrefetchSize(lPrefetchSize)
      => ComCall(10, this.p, Int32, lPrefetchSize)
    MoveFirst()
      => ComCall(11, this.p)
    MoveNext()
      => ComCall(12, this.p)
}
struct IFaxOutgoingMessage extends IDispatch {
    static IID := "{F0EA35DE-CAA5-4A7C-82C7-2B60BA5F2BE2}"
    get_SubmissionId(pbstrSubmissionId)
      => ComCall(7, this.p, BSTR.Ptr, pbstrSubmissionId)
    get_Id(pbstrId)
      => ComCall(8, this.p, BSTR.Ptr, pbstrId)
    get_Subject(pbstrSubject)
      => ComCall(9, this.p, BSTR.Ptr, pbstrSubject)
    get_DocumentName(pbstrDocumentName)
      => ComCall(10, this.p, BSTR.Ptr, pbstrDocumentName)
    get_Retries(plRetries)
      => ComCall(11, this.p, Int32.Ptr, plRetries)
    get_Pages(plPages)
      => ComCall(12, this.p, Int32.Ptr, plPages)
    get_Size(plSize)
      => ComCall(13, this.p, Int32.Ptr, plSize)
    get_OriginalScheduledTime(pdateOriginalScheduledTime)
      => ComCall(14, this.p, Float64.Ptr, pdateOriginalScheduledTime)
    get_SubmissionTime(pdateSubmissionTime)
      => ComCall(15, this.p, Float64.Ptr, pdateSubmissionTime)
    get_Priority(pPriority)
      => ComCall(16, this.p, FAX_PRIORITY_TYPE_ENUM.Ptr, pPriority)
    get_Sender(ppFaxSender)
      => ComCall(17, this.p, IFaxSender.Ptr, ppFaxSender)
    get_Recipient(ppFaxRecipient)
      => ComCall(18, this.p, IFaxRecipient.Ptr, ppFaxRecipient)
    get_DeviceName(pbstrDeviceName)
      => ComCall(19, this.p, BSTR.Ptr, pbstrDeviceName)
    get_TransmissionStart(pdateTransmissionStart)
      => ComCall(20, this.p, Float64.Ptr, pdateTransmissionStart)
    get_TransmissionEnd(pdateTransmissionEnd)
      => ComCall(21, this.p, Float64.Ptr, pdateTransmissionEnd)
    get_CSID(pbstrCSID)
      => ComCall(22, this.p, BSTR.Ptr, pbstrCSID)
    get_TSID(pbstrTSID)
      => ComCall(23, this.p, BSTR.Ptr, pbstrTSID)
    CopyTiff(bstrTiffPath)
      => ComCall(24, this.p, BSTR, bstrTiffPath)
    Delete()
      => ComCall(25, this.p)
}
struct IFaxIncomingJobs extends IDispatch {
    static IID := "{011F04E9-4FD6-4C23-9513-B6B66BB26BE9}"
    get__NewEnum(ppUnk)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnk)
    get_Item(vIndex, pFaxIncomingJob)
      => ComCall(8, this.p, VARIANT, vIndex, IFaxIncomingJob.Ptr, pFaxIncomingJob)
    get_Count(plCount)
      => ComCall(9, this.p, Int32.Ptr, plCount)
}
struct IFaxIncomingJob extends IDispatch {
    static IID := "{207529E6-654A-4916-9F88-4D232EE8A107}"
    get_Size(plSize)
      => ComCall(7, this.p, Int32.Ptr, plSize)
    get_Id(pbstrId)
      => ComCall(8, this.p, BSTR.Ptr, pbstrId)
    get_CurrentPage(plCurrentPage)
      => ComCall(9, this.p, Int32.Ptr, plCurrentPage)
    get_DeviceId(plDeviceId)
      => ComCall(10, this.p, Int32.Ptr, plDeviceId)
    get_Status(pStatus)
      => ComCall(11, this.p, FAX_JOB_STATUS_ENUM.Ptr, pStatus)
    get_ExtendedStatusCode(pExtendedStatusCode)
      => ComCall(12, this.p, FAX_JOB_EXTENDED_STATUS_ENUM.Ptr, pExtendedStatusCode)
    get_ExtendedStatus(pbstrExtendedStatus)
      => ComCall(13, this.p, BSTR.Ptr, pbstrExtendedStatus)
    get_AvailableOperations(pAvailableOperations)
      => ComCall(14, this.p, FAX_JOB_OPERATIONS_ENUM.Ptr, pAvailableOperations)
    get_Retries(plRetries)
      => ComCall(15, this.p, Int32.Ptr, plRetries)
    get_TransmissionStart(pdateTransmissionStart)
      => ComCall(16, this.p, Float64.Ptr, pdateTransmissionStart)
    get_TransmissionEnd(pdateTransmissionEnd)
      => ComCall(17, this.p, Float64.Ptr, pdateTransmissionEnd)
    get_CSID(pbstrCSID)
      => ComCall(18, this.p, BSTR.Ptr, pbstrCSID)
    get_TSID(pbstrTSID)
      => ComCall(19, this.p, BSTR.Ptr, pbstrTSID)
    get_CallerId(pbstrCallerId)
      => ComCall(20, this.p, BSTR.Ptr, pbstrCallerId)
    get_RoutingInformation(pbstrRoutingInformation)
      => ComCall(21, this.p, BSTR.Ptr, pbstrRoutingInformation)
    get_JobType(pJobType)
      => ComCall(22, this.p, FAX_JOB_TYPE_ENUM.Ptr, pJobType)
    Cancel()
      => ComCall(23, this.p)
    Refresh()
      => ComCall(24, this.p)
    CopyTiff(bstrTiffPath)
      => ComCall(25, this.p, BSTR, bstrTiffPath)
}
struct FAX_PROVIDER_STATUS_ENUM extends Int32 {
    static fpsSUCCESS := 0
    static fpsSERVER_ERROR := 1
    static fpsBAD_GUID := 2
    static fpsBAD_VERSION := 3
    static fpsCANT_LOAD := 4
    static fpsCANT_LINK := 5
    static fpsCANT_INIT := 6
}
struct IFaxDeviceProvider extends IDispatch {
    static IID := "{290EAC63-83EC-449C-8417-F148DF8C682A}"
    get_FriendlyName(pbstrFriendlyName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrFriendlyName)
    get_ImageName(pbstrImageName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrImageName)
    get_UniqueName(pbstrUniqueName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrUniqueName)
    get_TapiProviderName(pbstrTapiProviderName)
      => ComCall(10, this.p, BSTR.Ptr, pbstrTapiProviderName)
    get_MajorVersion(plMajorVersion)
      => ComCall(11, this.p, Int32.Ptr, plMajorVersion)
    get_MinorVersion(plMinorVersion)
      => ComCall(12, this.p, Int32.Ptr, plMinorVersion)
    get_MajorBuild(plMajorBuild)
      => ComCall(13, this.p, Int32.Ptr, plMajorBuild)
    get_MinorBuild(plMinorBuild)
      => ComCall(14, this.p, Int32.Ptr, plMinorBuild)
    get_Debug(pbDebug)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, pbDebug)
    get_Status(pStatus)
      => ComCall(16, this.p, FAX_PROVIDER_STATUS_ENUM.Ptr, pStatus)
    get_InitErrorCode(plInitErrorCode)
      => ComCall(17, this.p, Int32.Ptr, plInitErrorCode)
    get_DeviceIds(pvDeviceIds)
      => ComCall(18, this.p, VARIANT.Ptr, pvDeviceIds)
}
struct FAX_DEVICE_RECEIVE_MODE_ENUM extends Int32 {
    static fdrmNO_ANSWER := 0
    static fdrmAUTO_ANSWER := 1
    static fdrmMANUAL_ANSWER := 2
}
struct IFaxDevice extends IDispatch {
    static IID := "{49306C59-B52E-4867-9DF4-CA5841C956D0}"
    get_Id(plId)
      => ComCall(7, this.p, Int32.Ptr, plId)
    get_DeviceName(pbstrDeviceName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrDeviceName)
    get_ProviderUniqueName(pbstrProviderUniqueName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrProviderUniqueName)
    get_PoweredOff(pbPoweredOff)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pbPoweredOff)
    get_ReceivingNow(pbReceivingNow)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pbReceivingNow)
    get_SendingNow(pbSendingNow)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, pbSendingNow)
    get_UsedRoutingMethods(pvUsedRoutingMethods)
      => ComCall(13, this.p, VARIANT.Ptr, pvUsedRoutingMethods)
    get_Description(pbstrDescription)
      => ComCall(14, this.p, BSTR.Ptr, pbstrDescription)
    put_Description(bstrDescription)
      => ComCall(15, this.p, BSTR, bstrDescription)
    get_SendEnabled(pbSendEnabled)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pbSendEnabled)
    put_SendEnabled(bSendEnabled)
      => ComCall(17, this.p, VARIANT_BOOL, bSendEnabled)
    get_ReceiveMode(pReceiveMode)
      => ComCall(18, this.p, FAX_DEVICE_RECEIVE_MODE_ENUM.Ptr, pReceiveMode)
    put_ReceiveMode(ReceiveMode)
      => ComCall(19, this.p, FAX_DEVICE_RECEIVE_MODE_ENUM, ReceiveMode)
    get_RingsBeforeAnswer(plRingsBeforeAnswer)
      => ComCall(20, this.p, Int32.Ptr, plRingsBeforeAnswer)
    put_RingsBeforeAnswer(lRingsBeforeAnswer)
      => ComCall(21, this.p, Int32, lRingsBeforeAnswer)
    get_CSID(pbstrCSID)
      => ComCall(22, this.p, BSTR.Ptr, pbstrCSID)
    put_CSID(bstrCSID)
      => ComCall(23, this.p, BSTR, bstrCSID)
    get_TSID(pbstrTSID)
      => ComCall(24, this.p, BSTR.Ptr, pbstrTSID)
    put_TSID(bstrTSID)
      => ComCall(25, this.p, BSTR, bstrTSID)
    Refresh()
      => ComCall(26, this.p)
    Save()
      => ComCall(27, this.p)
    GetExtensionProperty(bstrGUID, pvProperty)
      => ComCall(28, this.p, BSTR, bstrGUID, VARIANT.Ptr, pvProperty)
    SetExtensionProperty(bstrGUID, vProperty)
      => ComCall(29, this.p, BSTR, bstrGUID, VARIANT, vProperty)
    UseRoutingMethod(bstrMethodGUID, bUse)
      => ComCall(30, this.p, BSTR, bstrMethodGUID, VARIANT_BOOL, bUse)
    get_RingingNow(pbRingingNow)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, pbRingingNow)
    AnswerCall()
      => ComCall(32, this.p)
}
struct IFaxActivityLogging extends IDispatch {
    static IID := "{1E29078B-5A69-497B-9592-49B7E7FADDB5}"
    get_LogIncoming(pbLogIncoming)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pbLogIncoming)
    put_LogIncoming(bLogIncoming)
      => ComCall(8, this.p, VARIANT_BOOL, bLogIncoming)
    get_LogOutgoing(pbLogOutgoing)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pbLogOutgoing)
    put_LogOutgoing(bLogOutgoing)
      => ComCall(10, this.p, VARIANT_BOOL, bLogOutgoing)
    get_DatabasePath(pbstrDatabasePath)
      => ComCall(11, this.p, BSTR.Ptr, pbstrDatabasePath)
    put_DatabasePath(bstrDatabasePath)
      => ComCall(12, this.p, BSTR, bstrDatabasePath)
    Refresh()
      => ComCall(13, this.p)
    Save()
      => ComCall(14, this.p)
}
struct FAX_LOG_LEVEL_ENUM extends Int32 {
    static fllNONE := 0
    static fllMIN := 1
    static fllMED := 2
    static fllMAX := 3
}
struct IFaxEventLogging extends IDispatch {
    static IID := "{0880D965-20E8-42E4-8E17-944F192CAAD4}"
    get_InitEventsLevel(pInitEventLevel)
      => ComCall(7, this.p, FAX_LOG_LEVEL_ENUM.Ptr, pInitEventLevel)
    put_InitEventsLevel(InitEventLevel)
      => ComCall(8, this.p, FAX_LOG_LEVEL_ENUM, InitEventLevel)
    get_InboundEventsLevel(pInboundEventLevel)
      => ComCall(9, this.p, FAX_LOG_LEVEL_ENUM.Ptr, pInboundEventLevel)
    put_InboundEventsLevel(InboundEventLevel)
      => ComCall(10, this.p, FAX_LOG_LEVEL_ENUM, InboundEventLevel)
    get_OutboundEventsLevel(pOutboundEventLevel)
      => ComCall(11, this.p, FAX_LOG_LEVEL_ENUM.Ptr, pOutboundEventLevel)
    put_OutboundEventsLevel(OutboundEventLevel)
      => ComCall(12, this.p, FAX_LOG_LEVEL_ENUM, OutboundEventLevel)
    get_GeneralEventsLevel(pGeneralEventLevel)
      => ComCall(13, this.p, FAX_LOG_LEVEL_ENUM.Ptr, pGeneralEventLevel)
    put_GeneralEventsLevel(GeneralEventLevel)
      => ComCall(14, this.p, FAX_LOG_LEVEL_ENUM, GeneralEventLevel)
    Refresh()
      => ComCall(15, this.p)
    Save()
      => ComCall(16, this.p)
}
struct IFaxOutboundRoutingGroups extends IDispatch {
    static IID := "{235CBEF7-C2DE-4BFD-B8DA-75097C82C87F}"
    get__NewEnum(ppUnk)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnk)
    get_Item(vIndex, pFaxOutboundRoutingGroup)
      => ComCall(8, this.p, VARIANT, vIndex, IFaxOutboundRoutingGroup.Ptr, pFaxOutboundRoutingGroup)
    get_Count(plCount)
      => ComCall(9, this.p, Int32.Ptr, plCount)
    Add(bstrName, pFaxOutboundRoutingGroup)
      => ComCall(10, this.p, BSTR, bstrName, IFaxOutboundRoutingGroup.Ptr, pFaxOutboundRoutingGroup)
    Remove(vIndex)
      => ComCall(11, this.p, VARIANT, vIndex)
}
struct FAX_GROUP_STATUS_ENUM extends Int32 {
    static fgsALL_DEV_VALID := 0
    static fgsEMPTY := 1
    static fgsALL_DEV_NOT_VALID := 2
    static fgsSOME_DEV_NOT_VALID := 3
}
struct IFaxOutboundRoutingGroup extends IDispatch {
    static IID := "{CA6289A1-7E25-4F87-9A0B-93365734962C}"
    get_Name(pbstrName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrName)
    get_Status(pStatus)
      => ComCall(8, this.p, FAX_GROUP_STATUS_ENUM.Ptr, pStatus)
    get_DeviceIds(pFaxDeviceIds)
      => ComCall(9, this.p, IFaxDeviceIds.Ptr, pFaxDeviceIds)
}
struct IFaxDeviceIds extends IDispatch {
    static IID := "{2F0F813F-4CE9-443E-8CA1-738CFAEEE149}"
    get__NewEnum(ppUnk)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnk)
    get_Item(lIndex, plDeviceId)
      => ComCall(8, this.p, Int32, lIndex, Int32.Ptr, plDeviceId)
    get_Count(plCount)
      => ComCall(9, this.p, Int32.Ptr, plCount)
    Add(lDeviceId)
      => ComCall(10, this.p, Int32, lDeviceId)
    Remove(lIndex)
      => ComCall(11, this.p, Int32, lIndex)
    SetOrder(lDeviceId, lNewOrder)
      => ComCall(12, this.p, Int32, lDeviceId, Int32, lNewOrder)
}
struct IFaxOutboundRoutingRules extends IDispatch {
    static IID := "{DCEFA1E7-AE7D-4ED6-8521-369EDCCA5120}"
    get__NewEnum(ppUnk)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnk)
    get_Item(lIndex, pFaxOutboundRoutingRule)
      => ComCall(8, this.p, Int32, lIndex, IFaxOutboundRoutingRule.Ptr, pFaxOutboundRoutingRule)
    get_Count(plCount)
      => ComCall(9, this.p, Int32.Ptr, plCount)
    ItemByCountryAndArea(lCountryCode, lAreaCode, pFaxOutboundRoutingRule)
      => ComCall(10, this.p, Int32, lCountryCode, Int32, lAreaCode, IFaxOutboundRoutingRule.Ptr, pFaxOutboundRoutingRule)
    RemoveByCountryAndArea(lCountryCode, lAreaCode)
      => ComCall(11, this.p, Int32, lCountryCode, Int32, lAreaCode)
    Remove(lIndex)
      => ComCall(12, this.p, Int32, lIndex)
    Add(lCountryCode, lAreaCode, bUseDevice, bstrGroupName, lDeviceId, pFaxOutboundRoutingRule)
      => ComCall(13, this.p, Int32, lCountryCode, Int32, lAreaCode, VARIANT_BOOL, bUseDevice, BSTR, bstrGroupName, Int32, lDeviceId, IFaxOutboundRoutingRule.Ptr, pFaxOutboundRoutingRule)
}
struct FAX_RULE_STATUS_ENUM extends Int32 {
    static frsVALID := 0
    static frsEMPTY_GROUP := 1
    static frsALL_GROUP_DEV_NOT_VALID := 2
    static frsSOME_GROUP_DEV_NOT_VALID := 3
    static frsBAD_DEVICE := 4
}
struct IFaxOutboundRoutingRule extends IDispatch {
    static IID := "{E1F795D5-07C2-469F-B027-ACACC23219DA}"
    get_CountryCode(plCountryCode)
      => ComCall(7, this.p, Int32.Ptr, plCountryCode)
    get_AreaCode(plAreaCode)
      => ComCall(8, this.p, Int32.Ptr, plAreaCode)
    get_Status(pStatus)
      => ComCall(9, this.p, FAX_RULE_STATUS_ENUM.Ptr, pStatus)
    get_UseDevice(pbUseDevice)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pbUseDevice)
    put_UseDevice(bUseDevice)
      => ComCall(11, this.p, VARIANT_BOOL, bUseDevice)
    get_DeviceId(plDeviceId)
      => ComCall(12, this.p, Int32.Ptr, plDeviceId)
    put_DeviceId(DeviceId)
      => ComCall(13, this.p, Int32, DeviceId)
    get_GroupName(pbstrGroupName)
      => ComCall(14, this.p, BSTR.Ptr, pbstrGroupName)
    put_GroupName(bstrGroupName)
      => ComCall(15, this.p, BSTR, bstrGroupName)
    Refresh()
      => ComCall(16, this.p)
    Save()
      => ComCall(17, this.p)
}
struct IFaxInboundRoutingExtensions extends IDispatch {
    static IID := "{2F6C9673-7B26-42DE-8EB0-915DCD2A4F4C}"
    get__NewEnum(ppUnk)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnk)
    get_Item(vIndex, pFaxInboundRoutingExtension)
      => ComCall(8, this.p, VARIANT, vIndex, IFaxInboundRoutingExtension.Ptr, pFaxInboundRoutingExtension)
    get_Count(plCount)
      => ComCall(9, this.p, Int32.Ptr, plCount)
}
struct IFaxInboundRoutingExtension extends IDispatch {
    static IID := "{885B5E08-C26C-4EF9-AF83-51580A750BE1}"
    get_FriendlyName(pbstrFriendlyName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrFriendlyName)
    get_ImageName(pbstrImageName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrImageName)
    get_UniqueName(pbstrUniqueName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrUniqueName)
    get_MajorVersion(plMajorVersion)
      => ComCall(10, this.p, Int32.Ptr, plMajorVersion)
    get_MinorVersion(plMinorVersion)
      => ComCall(11, this.p, Int32.Ptr, plMinorVersion)
    get_MajorBuild(plMajorBuild)
      => ComCall(12, this.p, Int32.Ptr, plMajorBuild)
    get_MinorBuild(plMinorBuild)
      => ComCall(13, this.p, Int32.Ptr, plMinorBuild)
    get_Debug(pbDebug)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, pbDebug)
    get_Status(pStatus)
      => ComCall(15, this.p, FAX_PROVIDER_STATUS_ENUM.Ptr, pStatus)
    get_InitErrorCode(plInitErrorCode)
      => ComCall(16, this.p, Int32.Ptr, plInitErrorCode)
    get_Methods(pvMethods)
      => ComCall(17, this.p, VARIANT.Ptr, pvMethods)
}
struct IFaxInboundRoutingMethods extends IDispatch {
    static IID := "{783FCA10-8908-4473-9D69-F67FBEA0C6B9}"
    get__NewEnum(ppUnk)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnk)
    get_Item(vIndex, pFaxInboundRoutingMethod)
      => ComCall(8, this.p, VARIANT, vIndex, IFaxInboundRoutingMethod.Ptr, pFaxInboundRoutingMethod)
    get_Count(plCount)
      => ComCall(9, this.p, Int32.Ptr, plCount)
}
struct IFaxInboundRoutingMethod extends IDispatch {
    static IID := "{45700061-AD9D-4776-A8C4-64065492CF4B}"
    get_Name(pbstrName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrName)
    get_GUID(pbstrGUID)
      => ComCall(8, this.p, BSTR.Ptr, pbstrGUID)
    get_FunctionName(pbstrFunctionName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrFunctionName)
    get_ExtensionFriendlyName(pbstrExtensionFriendlyName)
      => ComCall(10, this.p, BSTR.Ptr, pbstrExtensionFriendlyName)
    get_ExtensionImageName(pbstrExtensionImageName)
      => ComCall(11, this.p, BSTR.Ptr, pbstrExtensionImageName)
    get_Priority(plPriority)
      => ComCall(12, this.p, Int32.Ptr, plPriority)
    put_Priority(lPriority)
      => ComCall(13, this.p, Int32, lPriority)
    Refresh()
      => ComCall(14, this.p)
    Save()
      => ComCall(15, this.p)
}
struct IFaxDocument2 extends IFaxDocument {
    static IID := "{E1347661-F9EF-4D6D-B4A5-C0A068B65CFF}"
    get_SubmissionId(pbstrSubmissionId)
      => ComCall(41, this.p, BSTR.Ptr, pbstrSubmissionId)
    get_Bodies(pvBodies)
      => ComCall(42, this.p, VARIANT.Ptr, pvBodies)
    put_Bodies(vBodies)
      => ComCall(43, this.p, VARIANT, vBodies)
    Submit2(bstrFaxServerName, pvFaxOutgoingJobIDs, plErrorBodyFile)
      => ComCall(44, this.p, BSTR, bstrFaxServerName, VARIANT.Ptr, pvFaxOutgoingJobIDs, Int32.Ptr, plErrorBodyFile)
    ConnectedSubmit2(pFaxServer?, pvFaxOutgoingJobIDs, plErrorBodyFile)
      => ComCall(45, this.p, IFaxServer, pFaxServer?, VARIANT.Ptr, pvFaxOutgoingJobIDs, Int32.Ptr, plErrorBodyFile)
}
struct IFaxConfiguration extends IDispatch {
    static IID := "{10F4D0F7-0994-4543-AB6E-506949128C40}"
    get_UseArchive(pbUseArchive)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pbUseArchive)
    put_UseArchive(bUseArchive)
      => ComCall(8, this.p, VARIANT_BOOL, bUseArchive)
    get_ArchiveLocation(pbstrArchiveLocation)
      => ComCall(9, this.p, BSTR.Ptr, pbstrArchiveLocation)
    put_ArchiveLocation(bstrArchiveLocation)
      => ComCall(10, this.p, BSTR, bstrArchiveLocation)
    get_SizeQuotaWarning(pbSizeQuotaWarning)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pbSizeQuotaWarning)
    put_SizeQuotaWarning(bSizeQuotaWarning)
      => ComCall(12, this.p, VARIANT_BOOL, bSizeQuotaWarning)
    get_HighQuotaWaterMark(plHighQuotaWaterMark)
      => ComCall(13, this.p, Int32.Ptr, plHighQuotaWaterMark)
    put_HighQuotaWaterMark(lHighQuotaWaterMark)
      => ComCall(14, this.p, Int32, lHighQuotaWaterMark)
    get_LowQuotaWaterMark(plLowQuotaWaterMark)
      => ComCall(15, this.p, Int32.Ptr, plLowQuotaWaterMark)
    put_LowQuotaWaterMark(lLowQuotaWaterMark)
      => ComCall(16, this.p, Int32, lLowQuotaWaterMark)
    get_ArchiveAgeLimit(plArchiveAgeLimit)
      => ComCall(17, this.p, Int32.Ptr, plArchiveAgeLimit)
    put_ArchiveAgeLimit(lArchiveAgeLimit)
      => ComCall(18, this.p, Int32, lArchiveAgeLimit)
    get_ArchiveSizeLow(plSizeLow)
      => ComCall(19, this.p, Int32.Ptr, plSizeLow)
    get_ArchiveSizeHigh(plSizeHigh)
      => ComCall(20, this.p, Int32.Ptr, plSizeHigh)
    get_OutgoingQueueBlocked(pbOutgoingBlocked)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, pbOutgoingBlocked)
    put_OutgoingQueueBlocked(bOutgoingBlocked)
      => ComCall(22, this.p, VARIANT_BOOL, bOutgoingBlocked)
    get_OutgoingQueuePaused(pbOutgoingPaused)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, pbOutgoingPaused)
    put_OutgoingQueuePaused(bOutgoingPaused)
      => ComCall(24, this.p, VARIANT_BOOL, bOutgoingPaused)
    get_AllowPersonalCoverPages(pbAllowPersonalCoverPages)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, pbAllowPersonalCoverPages)
    put_AllowPersonalCoverPages(bAllowPersonalCoverPages)
      => ComCall(26, this.p, VARIANT_BOOL, bAllowPersonalCoverPages)
    get_UseDeviceTSID(pbUseDeviceTSID)
      => ComCall(27, this.p, VARIANT_BOOL.Ptr, pbUseDeviceTSID)
    put_UseDeviceTSID(bUseDeviceTSID)
      => ComCall(28, this.p, VARIANT_BOOL, bUseDeviceTSID)
    get_Retries(plRetries)
      => ComCall(29, this.p, Int32.Ptr, plRetries)
    put_Retries(lRetries)
      => ComCall(30, this.p, Int32, lRetries)
    get_RetryDelay(plRetryDelay)
      => ComCall(31, this.p, Int32.Ptr, plRetryDelay)
    put_RetryDelay(lRetryDelay)
      => ComCall(32, this.p, Int32, lRetryDelay)
    get_DiscountRateStart(pdateDiscountRateStart)
      => ComCall(33, this.p, Float64.Ptr, pdateDiscountRateStart)
    put_DiscountRateStart(dateDiscountRateStart)
      => ComCall(34, this.p, Float64, dateDiscountRateStart)
    get_DiscountRateEnd(pdateDiscountRateEnd)
      => ComCall(35, this.p, Float64.Ptr, pdateDiscountRateEnd)
    put_DiscountRateEnd(dateDiscountRateEnd)
      => ComCall(36, this.p, Float64, dateDiscountRateEnd)
    get_OutgoingQueueAgeLimit(plOutgoingQueueAgeLimit)
      => ComCall(37, this.p, Int32.Ptr, plOutgoingQueueAgeLimit)
    put_OutgoingQueueAgeLimit(lOutgoingQueueAgeLimit)
      => ComCall(38, this.p, Int32, lOutgoingQueueAgeLimit)
    get_Branding(pbBranding)
      => ComCall(39, this.p, VARIANT_BOOL.Ptr, pbBranding)
    put_Branding(bBranding)
      => ComCall(40, this.p, VARIANT_BOOL, bBranding)
    get_IncomingQueueBlocked(pbIncomingBlocked)
      => ComCall(41, this.p, VARIANT_BOOL.Ptr, pbIncomingBlocked)
    put_IncomingQueueBlocked(bIncomingBlocked)
      => ComCall(42, this.p, VARIANT_BOOL, bIncomingBlocked)
    get_AutoCreateAccountOnConnect(pbAutoCreateAccountOnConnect)
      => ComCall(43, this.p, VARIANT_BOOL.Ptr, pbAutoCreateAccountOnConnect)
    put_AutoCreateAccountOnConnect(bAutoCreateAccountOnConnect)
      => ComCall(44, this.p, VARIANT_BOOL, bAutoCreateAccountOnConnect)
    get_IncomingFaxesArePublic(pbIncomingFaxesArePublic)
      => ComCall(45, this.p, VARIANT_BOOL.Ptr, pbIncomingFaxesArePublic)
    put_IncomingFaxesArePublic(bIncomingFaxesArePublic)
      => ComCall(46, this.p, VARIANT_BOOL, bIncomingFaxesArePublic)
    Refresh()
      => ComCall(47, this.p)
    Save()
      => ComCall(48, this.p)
}
struct IFaxServer2 extends IFaxServer {
    static IID := "{571CED0F-5609-4F40-9176-547E3A72CA7C}"
    get_Configuration(ppFaxConfiguration)
      => ComCall(33, this.p, IFaxConfiguration.Ptr, ppFaxConfiguration)
    get_CurrentAccount(ppCurrentAccount)
      => ComCall(34, this.p, IFaxAccount.Ptr, ppCurrentAccount)
    get_FaxAccountSet(ppFaxAccountSet)
      => ComCall(35, this.p, IFaxAccountSet.Ptr, ppFaxAccountSet)
    get_Security2(ppFaxSecurity2)
      => ComCall(36, this.p, IFaxSecurity2.Ptr, ppFaxSecurity2)
}
struct IFaxAccountSet extends IDispatch {
    static IID := "{7428FBAE-841E-47B8-86F4-2288946DCA1B}"
    GetAccounts(ppFaxAccounts)
      => ComCall(7, this.p, IFaxAccounts.Ptr, ppFaxAccounts)
    GetAccount(bstrAccountName, pFaxAccount)
      => ComCall(8, this.p, BSTR, bstrAccountName, IFaxAccount.Ptr, pFaxAccount)
    AddAccount(bstrAccountName, pFaxAccount)
      => ComCall(9, this.p, BSTR, bstrAccountName, IFaxAccount.Ptr, pFaxAccount)
    RemoveAccount(bstrAccountName)
      => ComCall(10, this.p, BSTR, bstrAccountName)
}
struct IFaxAccounts extends IDispatch {
    static IID := "{93EA8162-8BE7-42D1-AE7B-EC74E2D989DA}"
    get__NewEnum(ppUnk)
      => ComCall(7, this.p, IUnknown.Ptr, ppUnk)
    get_Item(vIndex, pFaxAccount)
      => ComCall(8, this.p, VARIANT, vIndex, IFaxAccount.Ptr, pFaxAccount)
    get_Count(plCount)
      => ComCall(9, this.p, Int32.Ptr, plCount)
}
struct FAX_ACCOUNT_EVENTS_TYPE_ENUM extends Int32 {
    static faetNONE := 0
    static faetIN_QUEUE := 1
    static faetOUT_QUEUE := 2
    static faetIN_ARCHIVE := 4
    static faetOUT_ARCHIVE := 8
    static faetFXSSVC_ENDED := 16
}
struct IFaxAccount extends IDispatch {
    static IID := "{68535B33-5DC4-4086-BE26-B76F9B711006}"
    get_AccountName(pbstrAccountName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrAccountName)
    get_Folders(ppFolders)
      => ComCall(8, this.p, IFaxAccountFolders.Ptr, ppFolders)
    ListenToAccountEvents(EventTypes)
      => ComCall(9, this.p, FAX_ACCOUNT_EVENTS_TYPE_ENUM, EventTypes)
    get_RegisteredEvents(pRegisteredEvents)
      => ComCall(10, this.p, FAX_ACCOUNT_EVENTS_TYPE_ENUM.Ptr, pRegisteredEvents)
}
struct IFaxOutgoingJob2 extends IFaxOutgoingJob {
    static IID := "{418A8D96-59A0-4789-B176-EDF3DC8FA8F7}"
    get_HasCoverPage(pbHasCoverPage)
      => ComCall(38, this.p, VARIANT_BOOL.Ptr, pbHasCoverPage)
    get_ReceiptAddress(pbstrReceiptAddress)
      => ComCall(39, this.p, BSTR.Ptr, pbstrReceiptAddress)
    get_ScheduleType(pScheduleType)
      => ComCall(40, this.p, FAX_SCHEDULE_TYPE_ENUM.Ptr, pScheduleType)
}
struct IFaxAccountFolders extends IDispatch {
    static IID := "{6463F89D-23D8-46A9-8F86-C47B77CA7926}"
    get_OutgoingQueue(pFaxOutgoingQueue)
      => ComCall(7, this.p, IFaxAccountOutgoingQueue.Ptr, pFaxOutgoingQueue)
    get_IncomingQueue(pFaxIncomingQueue)
      => ComCall(8, this.p, IFaxAccountIncomingQueue.Ptr, pFaxIncomingQueue)
    get_IncomingArchive(pFaxIncomingArchive)
      => ComCall(9, this.p, IFaxAccountIncomingArchive.Ptr, pFaxIncomingArchive)
    get_OutgoingArchive(pFaxOutgoingArchive)
      => ComCall(10, this.p, IFaxAccountOutgoingArchive.Ptr, pFaxOutgoingArchive)
}
struct IFaxAccountIncomingQueue extends IDispatch {
    static IID := "{DD142D92-0186-4A95-A090-CBC3EADBA6B4}"
    GetJobs(pFaxIncomingJobs)
      => ComCall(7, this.p, IFaxIncomingJobs.Ptr, pFaxIncomingJobs)
    GetJob(bstrJobId, pFaxIncomingJob)
      => ComCall(8, this.p, BSTR, bstrJobId, IFaxIncomingJob.Ptr, pFaxIncomingJob)
}
struct IFaxAccountOutgoingQueue extends IDispatch {
    static IID := "{0F1424E9-F22D-4553-B7A5-0D24BD0D7E46}"
    GetJobs(pFaxOutgoingJobs)
      => ComCall(7, this.p, IFaxOutgoingJobs.Ptr, pFaxOutgoingJobs)
    GetJob(bstrJobId, pFaxOutgoingJob)
      => ComCall(8, this.p, BSTR, bstrJobId, IFaxOutgoingJob.Ptr, pFaxOutgoingJob)
}
struct IFaxOutgoingMessage2 extends IFaxOutgoingMessage {
    static IID := "{B37DF687-BC88-4B46-B3BE-B458B3EA9E7F}"
    get_HasCoverPage(pbHasCoverPage)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, pbHasCoverPage)
    get_ReceiptType(pReceiptType)
      => ComCall(27, this.p, FAX_RECEIPT_TYPE_ENUM.Ptr, pReceiptType)
    get_ReceiptAddress(pbstrReceiptAddress)
      => ComCall(28, this.p, BSTR.Ptr, pbstrReceiptAddress)
    get_Read(pbRead)
      => ComCall(29, this.p, VARIANT_BOOL.Ptr, pbRead)
    put_Read(bRead)
      => ComCall(30, this.p, VARIANT_BOOL, bRead)
    Save()
      => ComCall(31, this.p)
    Refresh()
      => ComCall(32, this.p)
}
struct IFaxAccountIncomingArchive extends IDispatch {
    static IID := "{A8A5B6EF-E0D6-4AEE-955C-91625BEC9DB4}"
    get_SizeLow(plSizeLow)
      => ComCall(7, this.p, Int32.Ptr, plSizeLow)
    get_SizeHigh(plSizeHigh)
      => ComCall(8, this.p, Int32.Ptr, plSizeHigh)
    Refresh()
      => ComCall(9, this.p)
    GetMessages(lPrefetchSize, pFaxIncomingMessageIterator)
      => ComCall(10, this.p, Int32, lPrefetchSize, IFaxIncomingMessageIterator.Ptr, pFaxIncomingMessageIterator)
    GetMessage(bstrMessageId, pFaxIncomingMessage)
      => ComCall(11, this.p, BSTR, bstrMessageId, IFaxIncomingMessage.Ptr, pFaxIncomingMessage)
}
struct IFaxAccountOutgoingArchive extends IDispatch {
    static IID := "{5463076D-EC14-491F-926E-B3CEDA5E5662}"
    get_SizeLow(plSizeLow)
      => ComCall(7, this.p, Int32.Ptr, plSizeLow)
    get_SizeHigh(plSizeHigh)
      => ComCall(8, this.p, Int32.Ptr, plSizeHigh)
    Refresh()
      => ComCall(9, this.p)
    GetMessages(lPrefetchSize, pFaxOutgoingMessageIterator)
      => ComCall(10, this.p, Int32, lPrefetchSize, IFaxOutgoingMessageIterator.Ptr, pFaxOutgoingMessageIterator)
    GetMessage(bstrMessageId, pFaxOutgoingMessage)
      => ComCall(11, this.p, BSTR, bstrMessageId, IFaxOutgoingMessage.Ptr, pFaxOutgoingMessage)
}
struct FAX_ACCESS_RIGHTS_ENUM_2 extends Int32 {
    static far2SUBMIT_LOW := 1
    static far2SUBMIT_NORMAL := 2
    static far2SUBMIT_HIGH := 4
    static far2QUERY_OUT_JOBS := 8
    static far2MANAGE_OUT_JOBS := 16
    static far2QUERY_CONFIG := 32
    static far2MANAGE_CONFIG := 64
    static far2QUERY_ARCHIVES := 128
    static far2MANAGE_ARCHIVES := 256
    static far2MANAGE_RECEIVE_FOLDER := 512
}
struct IFaxSecurity2 extends IDispatch {
    static IID := "{17D851F4-D09B-48FC-99C9-8F24C4DB9AB1}"
    get_Descriptor(pvDescriptor)
      => ComCall(7, this.p, VARIANT.Ptr, pvDescriptor)
    put_Descriptor(vDescriptor)
      => ComCall(8, this.p, VARIANT, vDescriptor)
    get_GrantedRights(pGrantedRights)
      => ComCall(9, this.p, FAX_ACCESS_RIGHTS_ENUM_2.Ptr, pGrantedRights)
    Refresh()
      => ComCall(10, this.p)
    Save()
      => ComCall(11, this.p)
    get_InformationType(plInformationType)
      => ComCall(12, this.p, Int32.Ptr, plInformationType)
    put_InformationType(lInformationType)
      => ComCall(13, this.p, Int32, lInformationType)
}
struct IFaxIncomingMessage2 extends IFaxIncomingMessage {
    static IID := "{F9208503-E2BC-48F3-9EC0-E6236F9B509A}"
    get_Subject(pbstrSubject)
      => ComCall(20, this.p, BSTR.Ptr, pbstrSubject)
    put_Subject(bstrSubject)
      => ComCall(21, this.p, BSTR, bstrSubject)
    get_SenderName(pbstrSenderName)
      => ComCall(22, this.p, BSTR.Ptr, pbstrSenderName)
    put_SenderName(bstrSenderName)
      => ComCall(23, this.p, BSTR, bstrSenderName)
    get_SenderFaxNumber(pbstrSenderFaxNumber)
      => ComCall(24, this.p, BSTR.Ptr, pbstrSenderFaxNumber)
    put_SenderFaxNumber(bstrSenderFaxNumber)
      => ComCall(25, this.p, BSTR, bstrSenderFaxNumber)
    get_HasCoverPage(pbHasCoverPage)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, pbHasCoverPage)
    put_HasCoverPage(bHasCoverPage)
      => ComCall(27, this.p, VARIANT_BOOL, bHasCoverPage)
    get_Recipients(pbstrRecipients)
      => ComCall(28, this.p, BSTR.Ptr, pbstrRecipients)
    put_Recipients(bstrRecipients)
      => ComCall(29, this.p, BSTR, bstrRecipients)
    get_WasReAssigned(pbWasReAssigned)
      => ComCall(30, this.p, VARIANT_BOOL.Ptr, pbWasReAssigned)
    get_Read(pbRead)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, pbRead)
    put_Read(bRead)
      => ComCall(32, this.p, VARIANT_BOOL, bRead)
    ReAssign()
      => ComCall(33, this.p)
    Save()
      => ComCall(34, this.p)
    Refresh()
      => ComCall(35, this.p)
}
struct FAX_ROUTING_RULE_CODE_ENUM extends Int32 {
    static frrcANY_CODE := 0
}
struct IFaxServerNotify extends IDispatch {
    static IID := "{2E037B27-CF8A-4ABD-B1E0-5704943BEA6F}"
}
struct IFaxServerNotify2 extends IDispatch {
    static IID := "{EC9C69B9-5FE7-4805-9467-82FCD96AF903}"
    OnIncomingJobAdded(pFaxServer?, bstrJobId)
      => ComCall(7, this.p, IFaxServer2, pFaxServer?, BSTR, bstrJobId)
    OnIncomingJobRemoved(pFaxServer?, bstrJobId)
      => ComCall(8, this.p, IFaxServer2, pFaxServer?, BSTR, bstrJobId)
    OnIncomingJobChanged(pFaxServer?, bstrJobId, pJobStatus?)
      => ComCall(9, this.p, IFaxServer2, pFaxServer?, BSTR, bstrJobId, IFaxJobStatus, pJobStatus?)
    OnOutgoingJobAdded(pFaxServer?, bstrJobId)
      => ComCall(10, this.p, IFaxServer2, pFaxServer?, BSTR, bstrJobId)
    OnOutgoingJobRemoved(pFaxServer?, bstrJobId)
      => ComCall(11, this.p, IFaxServer2, pFaxServer?, BSTR, bstrJobId)
    OnOutgoingJobChanged(pFaxServer?, bstrJobId, pJobStatus?)
      => ComCall(12, this.p, IFaxServer2, pFaxServer?, BSTR, bstrJobId, IFaxJobStatus, pJobStatus?)
    OnIncomingMessageAdded(pFaxServer?, bstrMessageId)
      => ComCall(13, this.p, IFaxServer2, pFaxServer?, BSTR, bstrMessageId)
    OnIncomingMessageRemoved(pFaxServer?, bstrMessageId)
      => ComCall(14, this.p, IFaxServer2, pFaxServer?, BSTR, bstrMessageId)
    OnOutgoingMessageAdded(pFaxServer?, bstrMessageId)
      => ComCall(15, this.p, IFaxServer2, pFaxServer?, BSTR, bstrMessageId)
    OnOutgoingMessageRemoved(pFaxServer?, bstrMessageId)
      => ComCall(16, this.p, IFaxServer2, pFaxServer?, BSTR, bstrMessageId)
    OnReceiptOptionsChange(pFaxServer?)
      => ComCall(17, this.p, IFaxServer2, pFaxServer?)
    OnActivityLoggingConfigChange(pFaxServer?)
      => ComCall(18, this.p, IFaxServer2, pFaxServer?)
    OnSecurityConfigChange(pFaxServer?)
      => ComCall(19, this.p, IFaxServer2, pFaxServer?)
    OnEventLoggingConfigChange(pFaxServer?)
      => ComCall(20, this.p, IFaxServer2, pFaxServer?)
    OnOutgoingQueueConfigChange(pFaxServer?)
      => ComCall(21, this.p, IFaxServer2, pFaxServer?)
    OnOutgoingArchiveConfigChange(pFaxServer?)
      => ComCall(22, this.p, IFaxServer2, pFaxServer?)
    OnIncomingArchiveConfigChange(pFaxServer?)
      => ComCall(23, this.p, IFaxServer2, pFaxServer?)
    OnDevicesConfigChange(pFaxServer?)
      => ComCall(24, this.p, IFaxServer2, pFaxServer?)
    OnOutboundRoutingGroupsConfigChange(pFaxServer?)
      => ComCall(25, this.p, IFaxServer2, pFaxServer?)
    OnOutboundRoutingRulesConfigChange(pFaxServer?)
      => ComCall(26, this.p, IFaxServer2, pFaxServer?)
    OnServerActivityChange(pFaxServer?, lIncomingMessages, lRoutingMessages, lOutgoingMessages, lQueuedMessages)
      => ComCall(27, this.p, IFaxServer2, pFaxServer?, Int32, lIncomingMessages, Int32, lRoutingMessages, Int32, lOutgoingMessages, Int32, lQueuedMessages)
    OnQueuesStatusChange(pFaxServer?, bOutgoingQueueBlocked, bOutgoingQueuePaused, bIncomingQueueBlocked)
      => ComCall(28, this.p, IFaxServer2, pFaxServer?, VARIANT_BOOL, bOutgoingQueueBlocked, VARIANT_BOOL, bOutgoingQueuePaused, VARIANT_BOOL, bIncomingQueueBlocked)
    OnNewCall(pFaxServer?, lCallId, lDeviceId, bstrCallerId)
      => ComCall(29, this.p, IFaxServer2, pFaxServer?, Int32, lCallId, Int32, lDeviceId, BSTR, bstrCallerId)
    OnServerShutDown(pFaxServer?)
      => ComCall(30, this.p, IFaxServer2, pFaxServer?)
    OnDeviceStatusChange(pFaxServer?, lDeviceId, bPoweredOff, bSending, bReceiving, bRinging)
      => ComCall(31, this.p, IFaxServer2, pFaxServer?, Int32, lDeviceId, VARIANT_BOOL, bPoweredOff, VARIANT_BOOL, bSending, VARIANT_BOOL, bReceiving, VARIANT_BOOL, bRinging)
    OnGeneralServerConfigChanged(pFaxServer?)
      => ComCall(32, this.p, IFaxServer2, pFaxServer?)
}
struct IFaxAccountNotify extends IDispatch {
    static IID := "{B9B3BC81-AC1B-46F3-B39D-0ADC30E1B788}"
    OnIncomingJobAdded(pFaxAccount?, bstrJobId)
      => ComCall(7, this.p, IFaxAccount, pFaxAccount?, BSTR, bstrJobId)
    OnIncomingJobRemoved(pFaxAccount?, bstrJobId)
      => ComCall(8, this.p, IFaxAccount, pFaxAccount?, BSTR, bstrJobId)
    OnIncomingJobChanged(pFaxAccount?, bstrJobId, pJobStatus?)
      => ComCall(9, this.p, IFaxAccount, pFaxAccount?, BSTR, bstrJobId, IFaxJobStatus, pJobStatus?)
    OnOutgoingJobAdded(pFaxAccount?, bstrJobId)
      => ComCall(10, this.p, IFaxAccount, pFaxAccount?, BSTR, bstrJobId)
    OnOutgoingJobRemoved(pFaxAccount?, bstrJobId)
      => ComCall(11, this.p, IFaxAccount, pFaxAccount?, BSTR, bstrJobId)
    OnOutgoingJobChanged(pFaxAccount?, bstrJobId, pJobStatus?)
      => ComCall(12, this.p, IFaxAccount, pFaxAccount?, BSTR, bstrJobId, IFaxJobStatus, pJobStatus?)
    OnIncomingMessageAdded(pFaxAccount?, bstrMessageId, fAddedToReceiveFolder)
      => ComCall(13, this.p, IFaxAccount, pFaxAccount?, BSTR, bstrMessageId, VARIANT_BOOL, fAddedToReceiveFolder)
    OnIncomingMessageRemoved(pFaxAccount?, bstrMessageId, fRemovedFromReceiveFolder)
      => ComCall(14, this.p, IFaxAccount, pFaxAccount?, BSTR, bstrMessageId, VARIANT_BOOL, fRemovedFromReceiveFolder)
    OnOutgoingMessageAdded(pFaxAccount?, bstrMessageId)
      => ComCall(15, this.p, IFaxAccount, pFaxAccount?, BSTR, bstrMessageId)
    OnOutgoingMessageRemoved(pFaxAccount?, bstrMessageId)
      => ComCall(16, this.p, IFaxAccount, pFaxAccount?, BSTR, bstrMessageId)
    OnServerShutDown(pFaxServer?)
      => ComCall(17, this.p, IFaxServer2, pFaxServer?)
}
struct PFAXROUTEADDFILE extends FunctionPointer {
    static Types := [UInt32, PWSTR, GUID.Ptr, Int32]
}
struct PFAXROUTEDELETEFILE extends FunctionPointer {
    static Types := [UInt32, PWSTR, Int32]
}
struct PFAXROUTEGETFILE extends FunctionPointer {
    static Types := [UInt32, UInt32, PWSTR, UInt32.Ptr, BOOL]
}
struct PFAXROUTEENUMFILE extends FunctionPointer {
    static Types := [UInt32, GUID.Ptr, GUID.Ptr, PWSTR, Struct.Ptr, BOOL]
}
struct PFAXROUTEENUMFILES extends FunctionPointer {
    static Types := [UInt32, GUID.Ptr, PFAXROUTEENUMFILE, Struct.Ptr, BOOL]
}
struct PFAXROUTEMODIFYROUTINGDATA extends FunctionPointer {
    static Types := [UInt32, PWSTR, UInt8.Ptr, UInt32, BOOL]
}
struct FAX_ROUTE_CALLBACKROUTINES {
    SizeOfStruct : UInt32
    FaxRouteAddFile : PFAXROUTEADDFILE
    FaxRouteDeleteFile : PFAXROUTEDELETEFILE
    FaxRouteGetFile : PFAXROUTEGETFILE
    FaxRouteEnumFiles : PFAXROUTEENUMFILES
    FaxRouteModifyRoutingData : PFAXROUTEMODIFYROUTINGDATA
}
struct FAX_ROUTE {
    SizeOfStruct : UInt32
    JobId : UInt32
    ElapsedTime : Int64
    ReceiveTime : Int64
    PageCount : UInt32
    Csid : PWSTR
    Tsid : PWSTR
    CallerId : PWSTR
    RoutingInfo : PWSTR
    ReceiverName : PWSTR
    ReceiverNumber : PWSTR
    DeviceName : PWSTR
    DeviceId : UInt32
    RoutingInfoData : UInt8.Ptr
    RoutingInfoDataSize : UInt32
}
struct FAXROUTE_ENABLE extends Int32 {
    static QUERY_STATUS := -1
    static STATUS_DISABLE := 0
    static STATUS_ENABLE := 1
}
struct PFAXROUTEINITIALIZE extends FunctionPointer {
    static Types := [HANDLE, FAX_ROUTE_CALLBACKROUTINES.Ptr, BOOL]
}
struct PFAXROUTEMETHOD extends FunctionPointer {
    static Types := [FAX_ROUTE.Ptr, Struct.Ptr.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXROUTEDEVICEENABLE extends FunctionPointer {
    static Types := [PWSTR, UInt32, Int32, BOOL]
}
struct PFAXROUTEDEVICECHANGENOTIFICATION extends FunctionPointer {
    static Types := [UInt32, BOOL, BOOL]
}
struct PFAXROUTEGETROUTINGINFO extends FunctionPointer {
    static Types := [PWSTR, UInt32, UInt8.Ptr, UInt32.Ptr, BOOL]
}
struct PFAXROUTESETROUTINGINFO extends FunctionPointer {
    static Types := [PWSTR, UInt32, UInt8.Ptr, UInt32, BOOL]
}
struct FAX_ENUM_DEVICE_ID_SOURCE extends Int32 {
    static DEV_ID_SRC_FAX := 0
    static DEV_ID_SRC_TAPI := 1
}
struct PFAX_EXT_GET_DATA extends FunctionPointer {
    static Types := [UInt32, FAX_ENUM_DEVICE_ID_SOURCE, PWSTR, UInt8.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PFAX_EXT_SET_DATA extends FunctionPointer {
    static Types := [HINSTANCE, UInt32, FAX_ENUM_DEVICE_ID_SOURCE, PWSTR, UInt8.Ptr, UInt32, UInt32]
}
struct PFAX_EXT_CONFIG_CHANGE extends FunctionPointer {
    static Types := [UInt32, PWSTR, UInt8.Ptr, UInt32, HRESULT]
}
struct PFAX_EXT_REGISTER_FOR_EVENTS extends FunctionPointer {
    static Types := [HINSTANCE, UInt32, FAX_ENUM_DEVICE_ID_SOURCE, PWSTR, PFAX_EXT_CONFIG_CHANGE, HANDLE]
}
struct PFAX_EXT_UNREGISTER_FOR_EVENTS extends FunctionPointer {
    static Types := [HANDLE, UInt32]
}
struct PFAX_EXT_FREE_BUFFER extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct PFAX_EXT_INITIALIZE_CONFIG extends FunctionPointer {
    static Types := [PFAX_EXT_GET_DATA, PFAX_EXT_SET_DATA, PFAX_EXT_REGISTER_FOR_EVENTS, PFAX_EXT_UNREGISTER_FOR_EVENTS, PFAX_EXT_FREE_BUFFER, HRESULT]
}
struct SendToMode extends Int32 {
    static SEND_TO_FAX_RECIPIENT_ATTACHMENT := 0
}
struct STI_DEVICE_MJ_TYPE extends Int32 {
    static StiDeviceTypeDefault := 0
    static StiDeviceTypeScanner := 1
    static StiDeviceTypeDigitalCamera := 2
    static StiDeviceTypeStreamingVideo := 3
}
struct STI_DEV_CAPS {
    dwGeneric : UInt32
}
struct STI_DEVICE_INFORMATIONW {
    dwSize : UInt32
    DeviceType : UInt32
    szDeviceInternalName : UInt16[128]
    DeviceCapabilitiesA : STI_DEV_CAPS
    dwHardwareConfiguration : UInt32
    pszVendorDescription : PWSTR
    pszDeviceDescription : PWSTR
    pszPortName : PWSTR
    pszPropProvider : PWSTR
    pszLocalName : PWSTR
}
struct STI_WIA_DEVICE_INFORMATIONW {
    dwSize : UInt32
    DeviceType : UInt32
    szDeviceInternalName : UInt16[128]
    DeviceCapabilitiesA : STI_DEV_CAPS
    dwHardwareConfiguration : UInt32
    pszVendorDescription : PWSTR
    pszDeviceDescription : PWSTR
    pszPortName : PWSTR
    pszPropProvider : PWSTR
    pszLocalName : PWSTR
    pszUiDll : PWSTR
    pszServer : PWSTR
}
struct STI_DEVICE_STATUS {
    dwSize : UInt32
    StatusMask : UInt32
    dwOnlineState : UInt32
    dwHardwareStatusCode : UInt32
    dwEventHandlingState : UInt32
    dwPollingInterval : UInt32
}
struct ERROR_INFOW {
    dwSize : UInt32
    dwGenericError : UInt32
    dwVendorError : UInt32
    szExtendedErrorText : UInt16[255]
}
struct STI_DIAG {
    dwSize : UInt32
    dwBasicDiagCode : UInt32
    dwVendorDiagCode : UInt32
    dwStatusMask : UInt32
    sErrorInfo : ERROR_INFOW
}
struct STISUBSCRIBE {
    dwSize : UInt32
    dwFlags : UInt32
    dwFilter : UInt32
    hWndNotify : HWND
    hEvent : HANDLE
    uiNotificationMessage : UInt32
}
struct STINOTIFY {
    dwSize : UInt32
    guidNotificationCode : GUID
    abNotificationData : UInt8[64]
}
struct IStillImageW extends IUnknown {
    static IID := "{641BD880-2DC8-11D0-90EA-00AA0060F86C}"
    Initialize(hinst, dwVersion)
      => ComCall(3, this.p, HINSTANCE, hinst, UInt32, dwVersion)
    GetDeviceList(dwType, dwFlags, pdwItemsReturned, ppBuffer)
      => ComCall(4, this.p, UInt32, dwType, UInt32, dwFlags, UInt32.Ptr, pdwItemsReturned, Struct.Ptr.Ptr, ppBuffer)
    GetDeviceInfo(pwszDeviceName, ppBuffer)
      => ComCall(5, this.p, "Str", pwszDeviceName, Struct.Ptr.Ptr, ppBuffer)
    CreateDevice(pwszDeviceName, dwMode, pDevice, punkOuter?)
      => ComCall(6, this.p, "Str", pwszDeviceName, UInt32, dwMode, IStiDevice.Ptr, pDevice, IUnknown, punkOuter?)
    GetDeviceValue(pwszDeviceName, pValueName, pType, pData, cbData)
      => ComCall(7, this.p, "Str", pwszDeviceName, "Str", pValueName, UInt32.Ptr, pType, UInt8.Ptr, pData, UInt32.Ptr, cbData)
    SetDeviceValue(pwszDeviceName, pValueName, Type, pData)
      => ComCall(8, this.p, "Str", pwszDeviceName, "Str", pValueName, UInt32, Type, UInt8.Ptr, pData, UInt32, pData.Size)
    GetSTILaunchInformation(pwszDeviceName, pdwEventCode?, pwszEventName)
      => ComCall(9, this.p, PWSTR, pwszDeviceName, UInt32.Ptr, pdwEventCode?, PWSTR, pwszEventName)
    RegisterLaunchApplication(pwszAppName, pwszCommandLine)
      => ComCall(10, this.p, "Str", pwszAppName, "Str", pwszCommandLine)
    UnregisterLaunchApplication(pwszAppName)
      => ComCall(11, this.p, "Str", pwszAppName)
    EnableHwNotifications(pwszDeviceName, bNewState)
      => ComCall(12, this.p, "Str", pwszDeviceName, BOOL, bNewState)
    GetHwNotificationState(pwszDeviceName, pbCurrentState)
      => ComCall(13, this.p, "Str", pwszDeviceName, BOOL.Ptr, pbCurrentState)
    RefreshDeviceBus(pwszDeviceName)
      => ComCall(14, this.p, "Str", pwszDeviceName)
    LaunchApplicationForDevice(pwszDeviceName, pwszAppName, pStiNotify)
      => ComCall(15, this.p, "Str", pwszDeviceName, "Str", pwszAppName, STINOTIFY.Ptr, pStiNotify)
    SetupDeviceParameters(param0)
      => ComCall(16, this.p, STI_DEVICE_INFORMATIONW.Ptr, param0)
    WriteToErrorLog(dwMessageType, pszMessage)
      => ComCall(17, this.p, UInt32, dwMessageType, "Str", pszMessage)
}
struct IStiDevice extends IUnknown {
    static IID := "{6CFA5A80-2DC8-11D0-90EA-00AA0060F86C}"
    Initialize(hinst, pwszDeviceName, dwVersion, dwMode)
      => ComCall(3, this.p, HINSTANCE, hinst, "Str", pwszDeviceName, UInt32, dwVersion, UInt32, dwMode)
    GetCapabilities(pDevCaps)
      => ComCall(4, this.p, STI_DEV_CAPS.Ptr, pDevCaps)
    GetStatus(pDevStatus)
      => ComCall(5, this.p, STI_DEVICE_STATUS.Ptr, pDevStatus)
    DeviceReset()
      => ComCall(6, this.p)
    Diagnostic(pBuffer)
      => ComCall(7, this.p, STI_DIAG.Ptr, pBuffer)
    Escape(EscapeFunction, lpInData, pOutData, pdwActualData)
      => ComCall(8, this.p, UInt32, EscapeFunction, Struct.Ptr, lpInData, UInt32, lpInData.Size, Struct.Ptr, pOutData, UInt32, pOutData.Size, UInt32.Ptr, pdwActualData)
    GetLastError(pdwLastDeviceError)
      => ComCall(9, this.p, UInt32.Ptr, pdwLastDeviceError)
    LockDevice(dwTimeOut)
      => ComCall(10, this.p, UInt32, dwTimeOut)
    UnLockDevice()
      => ComCall(11, this.p)
    RawReadData(lpBuffer, lpdwNumberOfBytes, lpOverlapped?)
      => ComCall(12, this.p, Struct.Ptr, lpBuffer, UInt32.Ptr, lpdwNumberOfBytes, OVERLAPPED.Ptr, lpOverlapped?)
    RawWriteData(lpBuffer, lpOverlapped?)
      => ComCall(13, this.p, Struct.Ptr, lpBuffer, UInt32, lpBuffer.Size, OVERLAPPED.Ptr, lpOverlapped?)
    RawReadCommand(lpBuffer, lpdwNumberOfBytes, lpOverlapped?)
      => ComCall(14, this.p, Struct.Ptr, lpBuffer, UInt32.Ptr, lpdwNumberOfBytes, OVERLAPPED.Ptr, lpOverlapped?)
    RawWriteCommand(lpBuffer, lpOverlapped?)
      => ComCall(15, this.p, Struct.Ptr, lpBuffer, UInt32, lpBuffer.Size, OVERLAPPED.Ptr, lpOverlapped?)
    Subscribe(lpSubsribe)
      => ComCall(16, this.p, STISUBSCRIBE.Ptr, lpSubsribe)
    GetLastNotificationData(lpNotify)
      => ComCall(17, this.p, STINOTIFY.Ptr, lpNotify)
    UnSubscribe()
      => ComCall(18, this.p)
    GetLastErrorInfo(pLastErrorInfo)
      => ComCall(19, this.p, ERROR_INFOW.Ptr, pLastErrorInfo)
}
struct STI_USD_CAPS {
    dwVersion : UInt32
    dwGenericCaps : UInt32
}
struct IStiDeviceControl extends IUnknown {
    static IID := "{128A9860-52DC-11D0-9EDF-444553540000}"
    Initialize(dwDeviceType, dwMode, pwszPortName, dwFlags)
      => ComCall(3, this.p, UInt32, dwDeviceType, UInt32, dwMode, "Str", pwszPortName, UInt32, dwFlags)
    RawReadData(lpBuffer, lpdwNumberOfBytes, lpOverlapped)
      => ComCall(4, this.p, Struct.Ptr, lpBuffer, UInt32.Ptr, lpdwNumberOfBytes, OVERLAPPED.Ptr, lpOverlapped)
    RawWriteData(lpBuffer, nNumberOfBytes, lpOverlapped)
      => ComCall(5, this.p, Struct.Ptr, lpBuffer, UInt32, nNumberOfBytes, OVERLAPPED.Ptr, lpOverlapped)
    RawReadCommand(lpBuffer, lpdwNumberOfBytes, lpOverlapped)
      => ComCall(6, this.p, Struct.Ptr, lpBuffer, UInt32.Ptr, lpdwNumberOfBytes, OVERLAPPED.Ptr, lpOverlapped)
    RawWriteCommand(lpBuffer, nNumberOfBytes, lpOverlapped)
      => ComCall(7, this.p, Struct.Ptr, lpBuffer, UInt32, nNumberOfBytes, OVERLAPPED.Ptr, lpOverlapped)
    RawDeviceControl(EscapeFunction, lpInData, cbInDataSize, pOutData, dwOutDataSize, pdwActualData)
      => ComCall(8, this.p, UInt32, EscapeFunction, Struct.Ptr, lpInData, UInt32, cbInDataSize, Struct.Ptr, pOutData, UInt32, dwOutDataSize, UInt32.Ptr, pdwActualData)
    GetLastError(lpdwLastError)
      => ComCall(9, this.p, UInt32.Ptr, lpdwLastError)
    GetMyDevicePortName(lpszDevicePath)
      => ComCall(10, this.p, PWSTR, lpszDevicePath, UInt32, lpszDevicePath.Length)
    GetMyDeviceHandle(lph)
      => ComCall(11, this.p, HANDLE.Ptr, lph)
    GetMyDeviceOpenMode(pdwOpenMode)
      => ComCall(12, this.p, UInt32.Ptr, pdwOpenMode)
    WriteToErrorLog(dwMessageType, pszMessage, dwErrorCode)
      => ComCall(13, this.p, UInt32, dwMessageType, "Str", pszMessage, UInt32, dwErrorCode)
}
struct IStiUSD extends IUnknown {
    static IID := "{0C9BB460-51AC-11D0-90EA-00AA0060F86C}"
    Initialize(pHelDcb, dwStiVersion, hParametersKey)
      => ComCall(3, this.p, IStiDeviceControl, pHelDcb, UInt32, dwStiVersion, HKEY, hParametersKey)
    GetCapabilities(pDevCaps)
      => ComCall(4, this.p, STI_USD_CAPS.Ptr, pDevCaps)
    GetStatus(pDevStatus)
      => ComCall(5, this.p, STI_DEVICE_STATUS.Ptr, pDevStatus)
    DeviceReset()
      => ComCall(6, this.p)
    Diagnostic(pBuffer)
      => ComCall(7, this.p, STI_DIAG.Ptr, pBuffer)
    Escape(EscapeFunction, lpInData, pOutData, pdwActualData)
      => ComCall(8, this.p, UInt32, EscapeFunction, Struct.Ptr, lpInData, UInt32, lpInData.Size, Struct.Ptr, pOutData, UInt32, pOutData.Size, UInt32.Ptr, pdwActualData)
    GetLastError(pdwLastDeviceError)
      => ComCall(9, this.p, UInt32.Ptr, pdwLastDeviceError)
    LockDevice()
      => ComCall(10, this.p)
    UnLockDevice()
      => ComCall(11, this.p)
    RawReadData(lpBuffer, lpdwNumberOfBytes, lpOverlapped?)
      => ComCall(12, this.p, Struct.Ptr, lpBuffer, UInt32.Ptr, lpdwNumberOfBytes, OVERLAPPED.Ptr, lpOverlapped?)
    RawWriteData(lpBuffer, lpOverlapped?)
      => ComCall(13, this.p, Struct.Ptr, lpBuffer, UInt32, lpBuffer.Size, OVERLAPPED.Ptr, lpOverlapped?)
    RawReadCommand(lpBuffer, lpdwNumberOfBytes, lpOverlapped?)
      => ComCall(14, this.p, Struct.Ptr, lpBuffer, UInt32.Ptr, lpdwNumberOfBytes, OVERLAPPED.Ptr, lpOverlapped?)
    RawWriteCommand(lpBuffer, lpOverlapped?)
      => ComCall(15, this.p, Struct.Ptr, lpBuffer, UInt32, lpBuffer.Size, OVERLAPPED.Ptr, lpOverlapped?)
    SetNotificationHandle(hEvent?)
      => ComCall(16, this.p, HANDLE, hEvent?)
    GetNotificationData(lpNotify)
      => ComCall(17, this.p, STINOTIFY.Ptr, lpNotify)
    GetLastErrorInfo(pLastErrorInfo)
      => ComCall(18, this.p, ERROR_INFOW.Ptr, pLastErrorInfo)
}
