#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, FILETIME, HANDLE, HRESULT, PSTR, PWSTR}
#Import "..\Security.Cryptography\Types.ahk" {CERT_CONTEXT}
#Import "..\System.Com\Types.ahk" {IUnknown, SAFEARRAY}

struct PFN_IIS_GETSERVERVARIABLE extends FunctionPointer {
    static Types := [HCONN, PSTR, Struct.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_IIS_WRITECLIENT extends FunctionPointer {
    static Types := [HCONN, Struct.Ptr, UInt32.Ptr, UInt32, BOOL]
}
struct PFN_IIS_READCLIENT extends FunctionPointer {
    static Types := [HCONN, Struct.Ptr, UInt32.Ptr, BOOL]
}
struct PFN_IIS_SERVERSUPPORTFUNCTION extends FunctionPointer {
    static Types := [HCONN, UInt32, Struct.Ptr, UInt32.Ptr, UInt32.Ptr, BOOL]
}
struct HCONN {
    Value : IntPtr
}
struct CONFIGURATION_ENTRY {
    bstrKey : BSTR
    bstrValue : BSTR
}
struct IFtpProviderConstruct extends IUnknown {
    static IID := "{4D1A3F7B-412D-447C-B199-64F967E9A2DA}"
    Construct(configurationEntries)
      => ComCall(3, this.p, SAFEARRAY.Ptr, configurationEntries)
}
struct IFtpAuthenticationProvider extends IUnknown {
    static IID := "{4659F95C-D5A8-4707-B2FC-6FD5794246CF}"
    AuthenticateUser(pszSessionId, pszSiteName, pszUserName, pszPassword, ppszCanonicalUserName, pfAuthenticated)
      => ComCall(3, this.p, "Str", pszSessionId, "Str", pszSiteName, "Str", pszUserName, "Str", pszPassword, PWSTR.Ptr, ppszCanonicalUserName, BOOL.Ptr, pfAuthenticated)
}
struct AsyncIFtpAuthenticationProvider extends IUnknown {
    static IID := "{C24EFB65-9F3E-4996-8FB1-CE166916BAB5}"
    Begin_AuthenticateUser(pszSessionId, pszSiteName, pszUserName, pszPassword)
      => ComCall(3, this.p, "Str", pszSessionId, "Str", pszSiteName, "Str", pszUserName, "Str", pszPassword)
    Finish_AuthenticateUser(ppszCanonicalUserName, pfAuthenticated)
      => ComCall(4, this.p, PWSTR.Ptr, ppszCanonicalUserName, BOOL.Ptr, pfAuthenticated)
}
struct IFtpRoleProvider extends IUnknown {
    static IID := "{909C850D-8CA0-4674-96B8-CC2941535725}"
    IsUserInRole(pszSessionId, pszSiteName, pszUserName, pszRole, pfIsInRole)
      => ComCall(3, this.p, "Str", pszSessionId, "Str", pszSiteName, "Str", pszUserName, "Str", pszRole, BOOL.Ptr, pfIsInRole)
}
struct AsyncIFtpRoleProvider extends IUnknown {
    static IID := "{3E83BF99-70EC-41CA-84B6-ACA7C7A62CAF}"
    Begin_IsUserInRole(pszSessionId, pszSiteName, pszUserName, pszRole)
      => ComCall(3, this.p, "Str", pszSessionId, "Str", pszSiteName, "Str", pszUserName, "Str", pszRole)
    Finish_IsUserInRole(pfIsInRole)
      => ComCall(4, this.p, BOOL.Ptr, pfIsInRole)
}
struct IFtpHomeDirectoryProvider extends IUnknown {
    static IID := "{0933B392-18DD-4097-8B9C-83325C35D9A6}"
    GetUserHomeDirectoryData(pszSessionId, pszSiteName, pszUserName, ppszHomeDirectoryData)
      => ComCall(3, this.p, "Str", pszSessionId, "Str", pszSiteName, "Str", pszUserName, PWSTR.Ptr, ppszHomeDirectoryData)
}
struct AsyncIFtpHomeDirectoryProvider extends IUnknown {
    static IID := "{73F81638-6295-42BD-A2BE-4A657F7C479C}"
    Begin_GetUserHomeDirectoryData(pszSessionId, pszSiteName, pszUserName)
      => ComCall(3, this.p, "Str", pszSessionId, "Str", pszSiteName, "Str", pszUserName)
    Finish_GetUserHomeDirectoryData(ppszHomeDirectoryData)
      => ComCall(4, this.p, PWSTR.Ptr, ppszHomeDirectoryData)
}
struct LOGGING_PARAMETERS {
    pszSessionId : PWSTR
    pszSiteName : PWSTR
    pszUserName : PWSTR
    pszHostName : PWSTR
    pszRemoteIpAddress : PWSTR
    dwRemoteIpPort : UInt32
    pszLocalIpAddress : PWSTR
    dwLocalIpPort : UInt32
    BytesSent : Int64
    BytesReceived : Int64
    pszCommand : PWSTR
    pszCommandParameters : PWSTR
    pszFullPath : PWSTR
    dwElapsedMilliseconds : UInt32
    FtpStatus : UInt32
    FtpSubStatus : UInt32
    hrStatus : HRESULT
    pszInformation : PWSTR
}
struct IFtpLogProvider extends IUnknown {
    static IID := "{A18A94CC-8299-4408-816C-7C3BACA1A40E}"
    Log(pLoggingParameters)
      => ComCall(3, this.p, LOGGING_PARAMETERS.Ptr, pLoggingParameters)
}
struct AsyncIFtpLogProvider extends IUnknown {
    static IID := "{00A0AE46-2498-48B2-95E6-DF678ED7D49F}"
    Begin_Log(pLoggingParameters)
      => ComCall(3, this.p, LOGGING_PARAMETERS.Ptr, pLoggingParameters)
    Finish_Log()
      => ComCall(4, this.p)
}
struct FTP_ACCESS extends Int32 {
    static FTP_ACCESS_NONE := 0
    static FTP_ACCESS_READ := 1
    static FTP_ACCESS_WRITE := 2
    static FTP_ACCESS_READ_WRITE := 3
}
struct IFtpAuthorizationProvider extends IUnknown {
    static IID := "{A50AE7A1-A35A-42B4-A4F3-F4F7057A05D1}"
    GetUserAccessPermission(pszSessionId, pszSiteName, pszVirtualPath, pszUserName, pFtpAccess)
      => ComCall(3, this.p, "Str", pszSessionId, "Str", pszSiteName, "Str", pszVirtualPath, "Str", pszUserName, FTP_ACCESS.Ptr, pFtpAccess)
}
struct AsyncIFtpAuthorizationProvider extends IUnknown {
    static IID := "{860DC339-07E5-4A5C-9C61-8820CEA012BC}"
    Begin_GetUserAccessPermission(pszSessionId, pszSiteName, pszVirtualPath, pszUserName)
      => ComCall(3, this.p, "Str", pszSessionId, "Str", pszSiteName, "Str", pszVirtualPath, "Str", pszUserName)
    Finish_GetUserAccessPermission(pFtpAccess)
      => ComCall(4, this.p, FTP_ACCESS.Ptr, pFtpAccess)
}
struct FTP_PROCESS_STATUS extends Int32 {
    static FTP_PROCESS_CONTINUE := 0
    static FTP_PROCESS_CLOSE_SESSION := 1
    static FTP_PROCESS_TERMINATE_SESSION := 2
    static FTP_PROCESS_REJECT_COMMAND := 3
}
struct PRE_PROCESS_PARAMETERS {
    pszSessionId : PWSTR
    pszSiteName : PWSTR
    pszUserName : PWSTR
    pszHostName : PWSTR
    pszRemoteIpAddress : PWSTR
    dwRemoteIpPort : UInt32
    pszLocalIpAddress : PWSTR
    dwLocalIpPort : UInt32
    pszCommand : PWSTR
    pszCommandParameters : PWSTR
    SessionStartTime : FILETIME
    BytesSentPerSession : Int64
    BytesReceivedPerSession : Int64
}
struct IFtpPreprocessProvider extends IUnknown {
    static IID := "{A3C19B60-5A28-471A-8F93-AB30411CEE82}"
    HandlePreprocess(pPreProcessParameters, pFtpProcessStatus)
      => ComCall(3, this.p, PRE_PROCESS_PARAMETERS.Ptr, pPreProcessParameters, FTP_PROCESS_STATUS.Ptr, pFtpProcessStatus)
}
struct AsyncIFtpPreprocessProvider extends IUnknown {
    static IID := "{6FF5FD8F-FD8E-48B1-A3E0-BF7073DB4DB5}"
    Begin_HandlePreprocess(pPreProcessParameters)
      => ComCall(3, this.p, PRE_PROCESS_PARAMETERS.Ptr, pPreProcessParameters)
    Finish_HandlePreprocess(pFtpProcessStatus)
      => ComCall(4, this.p, FTP_PROCESS_STATUS.Ptr, pFtpProcessStatus)
}
struct POST_PROCESS_PARAMETERS {
    pszSessionId : PWSTR
    pszSiteName : PWSTR
    pszUserName : PWSTR
    pszHostName : PWSTR
    pszRemoteIpAddress : PWSTR
    dwRemoteIpPort : UInt32
    pszLocalIpAddress : PWSTR
    dwLocalIpPort : UInt32
    BytesSent : Int64
    BytesReceived : Int64
    pszCommand : PWSTR
    pszCommandParameters : PWSTR
    pszFullPath : PWSTR
    pszPhysicalPath : PWSTR
    FtpStatus : UInt32
    FtpSubStatus : UInt32
    hrStatus : HRESULT
    SessionStartTime : FILETIME
    BytesSentPerSession : Int64
    BytesReceivedPerSession : Int64
}
struct IFtpPostprocessProvider extends IUnknown {
    static IID := "{4522CBC6-16CD-49AD-8653-9A2C579E4280}"
    HandlePostprocess(pPostProcessParameters, pFtpProcessStatus)
      => ComCall(3, this.p, POST_PROCESS_PARAMETERS.Ptr, pPostProcessParameters, FTP_PROCESS_STATUS.Ptr, pFtpProcessStatus)
}
struct AsyncIFtpPostprocessProvider extends IUnknown {
    static IID := "{A16B2542-9694-4EB1-A564-6C2E91FDC133}"
    Begin_HandlePostprocess(pPostProcessParameters)
      => ComCall(3, this.p, POST_PROCESS_PARAMETERS.Ptr, pPostProcessParameters)
    Finish_HandlePostprocess(pFtpProcessStatus)
      => ComCall(4, this.p, FTP_PROCESS_STATUS.Ptr, pFtpProcessStatus)
}
struct IADMEXT extends IUnknown {
    static IID := "{51DFE970-F6F2-11D0-B9BD-00A0C922E750}"
    Initialize()
      => ComCall(3, this.p)
    EnumDcomCLSIDs(pclsidDcom, dwEnumIndex)
      => ComCall(4, this.p, GUID.Ptr, pclsidDcom, UInt32, dwEnumIndex)
    Terminate()
      => ComCall(5, this.p)
}
struct METADATATYPES extends Int32 {
    static ALL_METADATA := 0
    static DWORD_METADATA := 1
    static STRING_METADATA := 2
    static BINARY_METADATA := 3
    static EXPANDSZ_METADATA := 4
    static MULTISZ_METADATA := 5
    static INVALID_END_METADATA := 6
}
struct METADATA_RECORD {
    dwMDIdentifier : UInt32
    dwMDAttributes : UInt32
    dwMDUserType : UInt32
    dwMDDataType : UInt32
    dwMDDataLen : UInt32
    pbMDData : UInt8.Ptr
    dwMDDataTag : UInt32
}
struct METADATA_GETALL_RECORD {
    dwMDIdentifier : UInt32
    dwMDAttributes : UInt32
    dwMDUserType : UInt32
    dwMDDataType : UInt32
    dwMDDataLen : UInt32
    dwMDDataOffset : UInt32
    dwMDDataTag : UInt32
}
struct METADATA_GETALL_INTERNAL_RECORD {
    dwMDIdentifier : UInt32
    dwMDAttributes : UInt32
    dwMDUserType : UInt32
    dwMDDataType : UInt32
    dwMDDataLen : UInt32
    Anonymous : this._Anonymous_e__Union
    dwMDDataTag : UInt32
    struct _Anonymous_e__Union {
        union {
            dwMDDataOffset : IntPtr
            pbMDData : UInt8.Ptr
        }
    }
}
struct METADATA_HANDLE_INFO {
    dwMDPermissions : UInt32
    dwMDSystemChangeNumber : UInt32
}
struct MD_CHANGE_OBJECT_W {
    pszMDPath : PWSTR
    dwMDChangeType : UInt32
    dwMDNumDataIDs : UInt32
    pdwMDDataIDs : UInt32.Ptr
}
struct IMSAdminBaseW extends IUnknown {
    static IID := "{70B51430-B6CA-11D0-B9B9-00A0C922E750}"
    AddKey(hMDHandle, pszMDPath?)
      => ComCall(3, this.p, UInt32, hMDHandle, "Str", pszMDPath?)
    DeleteKey(hMDHandle, pszMDPath?)
      => ComCall(4, this.p, UInt32, hMDHandle, "Str", pszMDPath?)
    DeleteChildKeys(hMDHandle, pszMDPath?)
      => ComCall(5, this.p, UInt32, hMDHandle, "Str", pszMDPath?)
    EnumKeys(hMDHandle, pszMDPath?, pszMDName, dwMDEnumObjectIndex)
      => ComCall(6, this.p, UInt32, hMDHandle, "Str", pszMDPath?, PWSTR, pszMDName, UInt32, dwMDEnumObjectIndex)
    CopyKey(hMDSourceHandle, pszMDSourcePath?, hMDDestHandle, pszMDDestPath?, bMDOverwriteFlag, bMDCopyFlag)
      => ComCall(7, this.p, UInt32, hMDSourceHandle, "Str", pszMDSourcePath?, UInt32, hMDDestHandle, "Str", pszMDDestPath?, BOOL, bMDOverwriteFlag, BOOL, bMDCopyFlag)
    RenameKey(hMDHandle, pszMDPath?, pszMDNewName?)
      => ComCall(8, this.p, UInt32, hMDHandle, "Str", pszMDPath?, "Str", pszMDNewName?)
    SetData(hMDHandle, pszMDPath, pmdrMDData)
      => ComCall(9, this.p, UInt32, hMDHandle, "Str", pszMDPath, METADATA_RECORD.Ptr, pmdrMDData)
    GetData(hMDHandle, pszMDPath, pmdrMDData, pdwMDRequiredDataLen)
      => ComCall(10, this.p, UInt32, hMDHandle, "Str", pszMDPath, METADATA_RECORD.Ptr, pmdrMDData, UInt32.Ptr, pdwMDRequiredDataLen)
    DeleteData(hMDHandle, pszMDPath?, dwMDIdentifier, dwMDDataType)
      => ComCall(11, this.p, UInt32, hMDHandle, "Str", pszMDPath?, UInt32, dwMDIdentifier, UInt32, dwMDDataType)
    EnumData(hMDHandle, pszMDPath, pmdrMDData, dwMDEnumDataIndex, pdwMDRequiredDataLen)
      => ComCall(12, this.p, UInt32, hMDHandle, "Str", pszMDPath, METADATA_RECORD.Ptr, pmdrMDData, UInt32, dwMDEnumDataIndex, UInt32.Ptr, pdwMDRequiredDataLen)
    GetAllData(hMDHandle, pszMDPath, dwMDAttributes, dwMDUserType, dwMDDataType, pdwMDNumDataEntries, pdwMDDataSetNumber, dwMDBufferSize, pbMDBuffer, pdwMDRequiredBufferSize)
      => ComCall(13, this.p, UInt32, hMDHandle, "Str", pszMDPath, UInt32, dwMDAttributes, UInt32, dwMDUserType, UInt32, dwMDDataType, UInt32.Ptr, pdwMDNumDataEntries, UInt32.Ptr, pdwMDDataSetNumber, UInt32, dwMDBufferSize, UInt8.Ptr, pbMDBuffer, UInt32.Ptr, pdwMDRequiredBufferSize)
    DeleteAllData(hMDHandle, pszMDPath?, dwMDUserType, dwMDDataType)
      => ComCall(14, this.p, UInt32, hMDHandle, "Str", pszMDPath?, UInt32, dwMDUserType, UInt32, dwMDDataType)
    CopyData(hMDSourceHandle, pszMDSourcePath?, hMDDestHandle, pszMDDestPath?, dwMDAttributes, dwMDUserType, dwMDDataType, bMDCopyFlag)
      => ComCall(15, this.p, UInt32, hMDSourceHandle, "Str", pszMDSourcePath?, UInt32, hMDDestHandle, "Str", pszMDDestPath?, UInt32, dwMDAttributes, UInt32, dwMDUserType, UInt32, dwMDDataType, BOOL, bMDCopyFlag)
    GetDataPaths(hMDHandle, pszMDPath?, dwMDIdentifier, dwMDDataType, pszBuffer, pdwMDRequiredBufferSize)
      => ComCall(16, this.p, UInt32, hMDHandle, "Str", pszMDPath?, UInt32, dwMDIdentifier, UInt32, dwMDDataType, UInt32, pszBuffer.Length, PWSTR, pszBuffer, UInt32.Ptr, pdwMDRequiredBufferSize)
    OpenKey(hMDHandle, pszMDPath?, dwMDAccessRequested, dwMDTimeOut, phMDNewHandle)
      => ComCall(17, this.p, UInt32, hMDHandle, "Str", pszMDPath?, UInt32, dwMDAccessRequested, UInt32, dwMDTimeOut, UInt32.Ptr, phMDNewHandle)
    CloseKey(hMDHandle)
      => ComCall(18, this.p, UInt32, hMDHandle)
    ChangePermissions(hMDHandle, dwMDTimeOut, dwMDAccessRequested)
      => ComCall(19, this.p, UInt32, hMDHandle, UInt32, dwMDTimeOut, UInt32, dwMDAccessRequested)
    SaveData()
      => ComCall(20, this.p)
    GetHandleInfo(hMDHandle, pmdhiInfo)
      => ComCall(21, this.p, UInt32, hMDHandle, METADATA_HANDLE_INFO.Ptr, pmdhiInfo)
    GetSystemChangeNumber(pdwSystemChangeNumber)
      => ComCall(22, this.p, UInt32.Ptr, pdwSystemChangeNumber)
    GetDataSetNumber(hMDHandle, pszMDPath?, pdwMDDataSetNumber)
      => ComCall(23, this.p, UInt32, hMDHandle, "Str", pszMDPath?, UInt32.Ptr, pdwMDDataSetNumber)
    SetLastChangeTime(hMDHandle, pszMDPath?, pftMDLastChangeTime, bLocalTime)
      => ComCall(24, this.p, UInt32, hMDHandle, "Str", pszMDPath?, FILETIME.Ptr, pftMDLastChangeTime, BOOL, bLocalTime)
    GetLastChangeTime(hMDHandle, pszMDPath?, pftMDLastChangeTime, bLocalTime)
      => ComCall(25, this.p, UInt32, hMDHandle, "Str", pszMDPath?, FILETIME.Ptr, pftMDLastChangeTime, BOOL, bLocalTime)
    KeyExchangePhase1()
      => ComCall(26, this.p)
    KeyExchangePhase2()
      => ComCall(27, this.p)
    Backup(pszMDBackupLocation?, dwMDVersion, dwMDFlags)
      => ComCall(28, this.p, "Str", pszMDBackupLocation?, UInt32, dwMDVersion, UInt32, dwMDFlags)
    Restore(pszMDBackupLocation?, dwMDVersion, dwMDFlags)
      => ComCall(29, this.p, "Str", pszMDBackupLocation?, UInt32, dwMDVersion, UInt32, dwMDFlags)
    EnumBackups(pszMDBackupLocation, pdwMDVersion, pftMDBackupTime, dwMDEnumIndex)
      => ComCall(30, this.p, PWSTR, pszMDBackupLocation, UInt32.Ptr, pdwMDVersion, FILETIME.Ptr, pftMDBackupTime, UInt32, dwMDEnumIndex)
    DeleteBackup(pszMDBackupLocation?, dwMDVersion)
      => ComCall(31, this.p, "Str", pszMDBackupLocation?, UInt32, dwMDVersion)
    UnmarshalInterface(piadmbwInterface)
      => ComCall(32, this.p, IMSAdminBaseW.Ptr, piadmbwInterface)
    GetServerGuid()
      => ComCall(33, this.p)
}
struct IMSAdminBase2W extends IMSAdminBaseW {
    static IID := "{8298D101-F992-43B7-8ECA-5052D885B995}"
    BackupWithPasswd(pszMDBackupLocation?, dwMDVersion, dwMDFlags, pszPasswd?)
      => ComCall(34, this.p, "Str", pszMDBackupLocation?, UInt32, dwMDVersion, UInt32, dwMDFlags, "Str", pszPasswd?)
    RestoreWithPasswd(pszMDBackupLocation?, dwMDVersion, dwMDFlags, pszPasswd?)
      => ComCall(35, this.p, "Str", pszMDBackupLocation?, UInt32, dwMDVersion, UInt32, dwMDFlags, "Str", pszPasswd?)
    Export(pszPasswd?, pszFileName?, pszSourcePath?, dwMDFlags)
      => ComCall(36, this.p, "Str", pszPasswd?, "Str", pszFileName?, "Str", pszSourcePath?, UInt32, dwMDFlags)
    Import(pszPasswd?, pszFileName?, pszSourcePath?, pszDestPath?, dwMDFlags)
      => ComCall(37, this.p, "Str", pszPasswd?, "Str", pszFileName?, "Str", pszSourcePath?, "Str", pszDestPath?, UInt32, dwMDFlags)
    RestoreHistory(pszMDHistoryLocation?, dwMDMajorVersion, dwMDMinorVersion, dwMDFlags)
      => ComCall(38, this.p, "Str", pszMDHistoryLocation?, UInt32, dwMDMajorVersion, UInt32, dwMDMinorVersion, UInt32, dwMDFlags)
    EnumHistory(pszMDHistoryLocation, pdwMDMajorVersion, pdwMDMinorVersion, pftMDHistoryTime, dwMDEnumIndex)
      => ComCall(39, this.p, PWSTR, pszMDHistoryLocation, UInt32.Ptr, pdwMDMajorVersion, UInt32.Ptr, pdwMDMinorVersion, FILETIME.Ptr, pftMDHistoryTime, UInt32, dwMDEnumIndex)
}
struct IMSAdminBase3W extends IMSAdminBase2W {
    static IID := "{F612954D-3B0B-4C56-9563-227B7BE624B4}"
    GetChildPaths(hMDHandle, pszMDPath?, pszBuffer?, pcchMDRequiredBufferSize?)
      => ComCall(40, this.p, UInt32, hMDHandle, "Str", pszMDPath?, UInt32, pszBuffer?.Length ?? 0, PWSTR, pszBuffer?, UInt32.Ptr, pcchMDRequiredBufferSize?)
}
struct IMSImpExpHelpW extends IUnknown {
    static IID := "{29FF67FF-8050-480F-9F30-CC41635F2F9D}"
    EnumeratePathsInFile(pszFileName?, pszKeyType?, pszBuffer?, pdwMDRequiredBufferSize)
      => ComCall(3, this.p, "Str", pszFileName?, "Str", pszKeyType?, UInt32, pszBuffer?.Length ?? 0, PWSTR, pszBuffer?, UInt32.Ptr, pdwMDRequiredBufferSize)
}
struct IMSAdminBaseSinkW extends IUnknown {
    static IID := "{A9E69612-B80D-11D0-B9B9-00A0C922E750}"
    SinkNotify(pcoChangeList)
      => ComCall(3, this.p, UInt32, pcoChangeList.Length, MD_CHANGE_OBJECT_W.Ptr, pcoChangeList)
    ShutdownNotify()
      => ComCall(4, this.p)
}
struct AsyncIMSAdminBaseSinkW extends IUnknown {
    static IID := "{A9E69613-B80D-11D0-B9B9-00A0C922E750}"
    Begin_SinkNotify(pcoChangeList)
      => ComCall(3, this.p, UInt32, pcoChangeList.Length, MD_CHANGE_OBJECT_W.Ptr, pcoChangeList)
    Finish_SinkNotify()
      => ComCall(4, this.p)
    Begin_ShutdownNotify()
      => ComCall(5, this.p)
    Finish_ShutdownNotify()
      => ComCall(6, this.p)
}
struct HSE_VERSION_INFO {
    dwExtensionVersion : UInt32
    lpszExtensionDesc : CHAR[256]
}
struct EXTENSION_CONTROL_BLOCK {
    cbSize : UInt32 := this.Size
    dwVersion : UInt32
    ConnID : HCONN
    dwHttpStatusCode : UInt32
    lpszLogData : CHAR[80]
    lpszMethod : PSTR
    lpszQueryString : PSTR
    lpszPathInfo : PSTR
    lpszPathTranslated : PSTR
    cbTotalBytes : UInt32
    cbAvailable : UInt32
    lpbData : UInt8.Ptr
    lpszContentType : PSTR
    GetServerVariable : PFN_IIS_GETSERVERVARIABLE
    WriteClient : PFN_IIS_WRITECLIENT
    ReadClient : PFN_IIS_READCLIENT
    ServerSupportFunction : PFN_IIS_SERVERSUPPORTFUNCTION
}
struct HSE_URL_MAPEX_INFO {
    lpszPath : CHAR[260]
    dwFlags : UInt32
    cchMatchingPath : UInt32
    cchMatchingURL : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
}
struct HSE_UNICODE_URL_MAPEX_INFO {
    lpszPath : UInt16[260]
    dwFlags : UInt32
    cchMatchingPath : UInt32
    cchMatchingURL : UInt32
}
struct PFN_HSE_IO_COMPLETION extends FunctionPointer {
    static Types := [EXTENSION_CONTROL_BLOCK.Ptr, Struct.Ptr, UInt32, UInt32, "Void"]
}
struct HSE_TF_INFO {
    pfnHseIO : PFN_HSE_IO_COMPLETION
    pContext : Struct.Ptr
    hFile : HANDLE
    pszStatusCode : PSTR
    BytesToWrite : UInt32
    Offset : UInt32
    pHead : Struct.Ptr
    HeadLength : UInt32
    pTail : Struct.Ptr
    TailLength : UInt32
    dwFlags : UInt32
}
struct HSE_SEND_HEADER_EX_INFO {
    pszStatus : PSTR
    pszHeader : PSTR
    cchStatus : UInt32
    cchHeader : UInt32
    fKeepConn : BOOL
}
struct HSE_EXEC_URL_USER_INFO {
    hImpersonationToken : HANDLE
    pszCustomUserName : PSTR
    pszCustomAuthType : PSTR
}
struct HSE_EXEC_URL_ENTITY_INFO {
    cbAvailable : UInt32
    lpbData : Struct.Ptr
}
struct HSE_EXEC_URL_STATUS {
    uHttpStatusCode : UInt16
    uHttpSubStatus : UInt16
    dwWin32Error : UInt32
}
struct HSE_EXEC_URL_INFO {
    pszUrl : PSTR
    pszMethod : PSTR
    pszChildHeaders : PSTR
    pUserInfo : HSE_EXEC_URL_USER_INFO.Ptr
    pEntity : HSE_EXEC_URL_ENTITY_INFO.Ptr
    dwExecUrlFlags : UInt32
}
struct HSE_EXEC_UNICODE_URL_USER_INFO {
    hImpersonationToken : HANDLE
    pszCustomUserName : PWSTR
    pszCustomAuthType : PSTR
}
struct HSE_EXEC_UNICODE_URL_INFO {
    pszUrl : PWSTR
    pszMethod : PSTR
    pszChildHeaders : PSTR
    pUserInfo : HSE_EXEC_UNICODE_URL_USER_INFO.Ptr
    pEntity : HSE_EXEC_URL_ENTITY_INFO.Ptr
    dwExecUrlFlags : UInt32
}
struct HSE_CUSTOM_ERROR_INFO {
    pszStatus : PSTR
    uHttpSubError : UInt16
    fAsync : BOOL
}
struct HSE_VECTOR_ELEMENT {
    ElementType : UInt32
    pvContext : Struct.Ptr
    cbOffset : Int64
    cbSize : Int64 := this.Size
}
struct HSE_RESPONSE_VECTOR {
    dwFlags : UInt32
    pszStatus : PSTR
    pszHeaders : PSTR
    nElementCount : UInt32
    lpElementArray : HSE_VECTOR_ELEMENT.Ptr
}
struct PFN_HSE_CACHE_INVALIDATION_CALLBACK extends FunctionPointer {
    static Types := [PWSTR, HRESULT]
}
struct CERT_CONTEXT_EX {
    CertContext : CERT_CONTEXT
    cbAllocated : UInt32
    dwCertificateFlags : UInt32
}
struct HSE_TRACE_INFO {
    fTraceRequest : BOOL
    TraceContextId : UInt8[16]
    dwReserved1 : UInt32
    dwReserved2 : UInt32
}
struct PFN_HSE_GET_PROTOCOL_MANAGER_CUSTOM_INTERFACE_CALLBACK extends FunctionPointer {
    static Types := [PWSTR, PWSTR, UInt32, Struct.Ptr.Ptr, HRESULT]
}
struct PFN_GETEXTENSIONVERSION extends FunctionPointer {
    static Types := [HSE_VERSION_INFO.Ptr, BOOL]
}
struct PFN_HTTPEXTENSIONPROC extends FunctionPointer {
    static Types := [EXTENSION_CONTROL_BLOCK.Ptr, UInt32]
}
struct PFN_TERMINATEEXTENSION extends FunctionPointer {
    static Types := [UInt32, BOOL]
}
struct SF_REQ_TYPE extends Int32 {
    static SF_REQ_SEND_RESPONSE_HEADER := 0
    static SF_REQ_ADD_HEADERS_ON_DENIAL := 1
    static SF_REQ_SET_NEXT_READ_SIZE := 2
    static SF_REQ_SET_PROXY_INFO := 3
    static SF_REQ_GET_CONNID := 4
    static SF_REQ_SET_CERTIFICATE_INFO := 5
    static SF_REQ_GET_PROPERTY := 6
    static SF_REQ_NORMALIZE_URL := 7
    static SF_REQ_DISABLE_NOTIFICATIONS := 8
}
struct SF_PROPERTY_IIS extends Int32 {
    static SF_PROPERTY_SSL_CTXT := 0
    static SF_PROPERTY_INSTANCE_NUM_ID := 1
}
struct SF_STATUS_TYPE extends Int32 {
    static SF_STATUS_REQ_FINISHED := 134217728
    static SF_STATUS_REQ_FINISHED_KEEP_CONN := 134217729
    static SF_STATUS_REQ_NEXT_NOTIFICATION := 134217730
    static SF_STATUS_REQ_HANDLED_NOTIFICATION := 134217731
    static SF_STATUS_REQ_ERROR := 134217732
    static SF_STATUS_REQ_READ_NEXT := 134217733
}
struct HTTP_FILTER_CONTEXT {
    cbSize : UInt32 := this.Size
    Revision : UInt32
    ServerContext : Struct.Ptr
    ulReserved : UInt32
    fIsSecurePort : BOOL
    pFilterContext : Struct.Ptr
    GetServerVariable : IntPtr
    AddResponseHeaders : IntPtr
    WriteClient : IntPtr
    AllocMem : IntPtr
    ServerSupportFunction : IntPtr
}
struct HTTP_FILTER_RAW_DATA {
    pvInData : Struct.Ptr
    cbInData : UInt32
    cbInBuffer : UInt32
    dwReserved : UInt32
}
struct HTTP_FILTER_PREPROC_HEADERS {
    GetHeader : IntPtr
    SetHeader : IntPtr
    AddHeader : IntPtr
    HttpStatus : UInt32
    dwReserved : UInt32
}
struct HTTP_FILTER_AUTHENT {
    pszUser : PSTR
    cbUserBuff : UInt32
    pszPassword : PSTR
    cbPasswordBuff : UInt32
}
struct HTTP_FILTER_URL_MAP {
    pszURL : PSTR
    pszPhysicalPath : PSTR
    cbPathBuff : UInt32
}
struct HTTP_FILTER_URL_MAP_EX {
    pszURL : PSTR
    pszPhysicalPath : PSTR
    cbPathBuff : UInt32
    dwFlags : UInt32
    cchMatchingPath : UInt32
    cchMatchingURL : UInt32
    pszScriptMapEntry : PSTR
}
struct HTTP_FILTER_ACCESS_DENIED {
    pszURL : PSTR
    pszPhysicalPath : PSTR
    dwReason : UInt32
}
struct HTTP_FILTER_LOG {
    pszClientHostName : PSTR
    pszClientUserName : PSTR
    pszServerName : PSTR
    pszOperation : PSTR
    pszTarget : PSTR
    pszParameters : PSTR
    dwHttpStatus : UInt32
    dwWin32Status : UInt32
    dwBytesSent : UInt32
    dwBytesRecvd : UInt32
    msTimeForProcessing : UInt32
}
struct HTTP_FILTER_AUTH_COMPLETE_INFO {
    GetHeader : IntPtr
    SetHeader : IntPtr
    AddHeader : IntPtr
    GetUserToken : IntPtr
    HttpStatus : UInt32
    fResetAuth : BOOL
    dwReserved : UInt32
}
struct HTTP_FILTER_VERSION {
    dwServerFilterVersion : UInt32
    dwFilterVersion : UInt32
    lpszFilterDesc : CHAR[257]
    dwFlags : UInt32
}
struct HTTP_TRACE_TYPE extends Int32 {
    static HTTP_TRACE_TYPE_BYTE := 17
    static HTTP_TRACE_TYPE_USHORT := 18
    static HTTP_TRACE_TYPE_ULONG := 19
    static HTTP_TRACE_TYPE_ULONGLONG := 21
    static HTTP_TRACE_TYPE_CHAR := 16
    static HTTP_TRACE_TYPE_SHORT := 2
    static HTTP_TRACE_TYPE_LONG := 3
    static HTTP_TRACE_TYPE_LONGLONG := 20
    static HTTP_TRACE_TYPE_LPCWSTR := 31
    static HTTP_TRACE_TYPE_LPCSTR := 30
    static HTTP_TRACE_TYPE_LPCGUID := 72
    static HTTP_TRACE_TYPE_BOOL := 11
}
struct HTTP_TRACE_EVENT {
    pProviderGuid : GUID.Ptr
    dwArea : UInt32
    pAreaGuid : GUID.Ptr
    dwEvent : UInt32
    pszEventName : PWSTR
    dwEventVersion : UInt32
    dwVerbosity : UInt32
    pActivityGuid : GUID.Ptr
    pRelatedActivityGuid : GUID.Ptr
    dwTimeStamp : UInt32
    dwFlags : UInt32
    cEventItems : UInt32
    pEventItems : HTTP_TRACE_EVENT_ITEM.Ptr
}
struct HTTP_TRACE_EVENT_ITEM {
    pszName : PWSTR
    dwDataType : HTTP_TRACE_TYPE
    pbData : UInt8.Ptr
    cbData : UInt32
    pszDataDescription : PWSTR
}
struct HTTP_TRACE_CONFIGURATION {
    pProviderGuid : GUID.Ptr
    dwAreas : UInt32
    dwVerbosity : UInt32
    fProviderEnabled : BOOL
}
struct PFN_WEB_CORE_SET_METADATA_DLL_ENTRY extends FunctionPointer {
    static Types := [PWSTR, PWSTR, HRESULT]
}
struct PFN_WEB_CORE_ACTIVATE extends FunctionPointer {
    static Types := [PWSTR, PWSTR, PWSTR, HRESULT]
}
struct PFN_WEB_CORE_SHUTDOWN extends FunctionPointer {
    static Types := [UInt32, HRESULT]
}
