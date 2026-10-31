#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HANDLE, HRESULT, PWSTR, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct WSMAN_API_HANDLE {
    Value : IntPtr
}
struct WSMAN_COMMAND_HANDLE {
    Value : IntPtr
}
struct WSMAN_OPERATION_HANDLE {
    Value : IntPtr
}
struct WSMAN_SESSION_HANDLE {
    Value : IntPtr
}
struct WSMAN_SHELL_HANDLE {
    Value : IntPtr
}
struct WSMAN_DATA_TEXT {
    bufferLength : UInt32
    buffer : PWSTR
}
struct WSMAN_DATA_BINARY {
    dataLength : UInt32
    data : UInt8.Ptr
}
struct WSManDataType extends Int32 {
    static WSMAN_DATA_NONE := 0
    static WSMAN_DATA_TYPE_TEXT := 1
    static WSMAN_DATA_TYPE_BINARY := 2
    static WSMAN_DATA_TYPE_DWORD := 4
}
struct WSMAN_DATA {
    type : WSManDataType
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            text : WSMAN_DATA_TEXT
            binaryData : WSMAN_DATA_BINARY
            number : UInt32
        }
    }
}
struct WSMAN_ERROR {
    code : UInt32
    errorDetail : PWSTR
    language : PWSTR
    machineName : PWSTR
    pluginName : PWSTR
}
struct WSMAN_USERNAME_PASSWORD_CREDS {
    username : PWSTR
    password : PWSTR
}
struct WSManAuthenticationFlags extends Int32 {
    static WSMAN_FLAG_DEFAULT_AUTHENTICATION := 0
    static WSMAN_FLAG_NO_AUTHENTICATION := 1
    static WSMAN_FLAG_AUTH_DIGEST := 2
    static WSMAN_FLAG_AUTH_NEGOTIATE := 4
    static WSMAN_FLAG_AUTH_BASIC := 8
    static WSMAN_FLAG_AUTH_KERBEROS := 16
    static WSMAN_FLAG_AUTH_CREDSSP := 128
    static WSMAN_FLAG_AUTH_CLIENT_CERTIFICATE := 32
}
struct WSMAN_AUTHENTICATION_CREDENTIALS {
    authenticationMechanism : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            userAccount : WSMAN_USERNAME_PASSWORD_CREDS
            certificateThumbprint : PWSTR
        }
    }
}
struct WSMAN_OPTION {
    name : PWSTR
    value : PWSTR
    mustComply : BOOL
}
struct WSMAN_OPTION_SET {
    optionsCount : UInt32
    options : WSMAN_OPTION.Ptr
    optionsMustUnderstand : BOOL
}
struct WSMAN_OPTION_SETEX {
    optionsCount : UInt32
    options : WSMAN_OPTION.Ptr
    optionsMustUnderstand : BOOL
    optionTypes : PWSTR.Ptr
}
struct WSMAN_KEY {
    key : PWSTR
    value : PWSTR
}
struct WSMAN_SELECTOR_SET {
    numberKeys : UInt32
    keys : WSMAN_KEY.Ptr
}
struct WSMAN_FRAGMENT {
    path : PWSTR
    dialect : PWSTR
}
struct WSMAN_FILTER {
    filter : PWSTR
    dialect : PWSTR
}
struct WSMAN_OPERATION_INFO {
    fragment : WSMAN_FRAGMENT
    filter : WSMAN_FILTER
    selectorSet : WSMAN_SELECTOR_SET
    optionSet : WSMAN_OPTION_SET
    reserved : Struct.Ptr
    version : UInt32
}
struct WSMAN_OPERATION_INFOEX {
    fragment : WSMAN_FRAGMENT
    filter : WSMAN_FILTER
    selectorSet : WSMAN_SELECTOR_SET
    optionSet : WSMAN_OPTION_SETEX
    version : UInt32
    uiLocale : PWSTR
    dataLocale : PWSTR
}
struct WSManProxyAccessType extends Int32 {
    static WSMAN_OPTION_PROXY_IE_PROXY_CONFIG := 1
    static WSMAN_OPTION_PROXY_WINHTTP_PROXY_CONFIG := 2
    static WSMAN_OPTION_PROXY_AUTO_DETECT := 4
    static WSMAN_OPTION_PROXY_NO_PROXY_SERVER := 8
}
struct WSMAN_PROXY_INFO {
    accessType : UInt32
    authenticationCredentials : WSMAN_AUTHENTICATION_CREDENTIALS
}
struct WSManSessionOption extends Int32 {
    static WSMAN_OPTION_DEFAULT_OPERATION_TIMEOUTMS := 1
    static WSMAN_OPTION_MAX_RETRY_TIME := 11
    static WSMAN_OPTION_TIMEOUTMS_CREATE_SHELL := 12
    static WSMAN_OPTION_TIMEOUTMS_RUN_SHELL_COMMAND := 13
    static WSMAN_OPTION_TIMEOUTMS_RECEIVE_SHELL_OUTPUT := 14
    static WSMAN_OPTION_TIMEOUTMS_SEND_SHELL_INPUT := 15
    static WSMAN_OPTION_TIMEOUTMS_SIGNAL_SHELL := 16
    static WSMAN_OPTION_TIMEOUTMS_CLOSE_SHELL := 17
    static WSMAN_OPTION_SKIP_CA_CHECK := 18
    static WSMAN_OPTION_SKIP_CN_CHECK := 19
    static WSMAN_OPTION_UNENCRYPTED_MESSAGES := 20
    static WSMAN_OPTION_UTF16 := 21
    static WSMAN_OPTION_ENABLE_SPN_SERVER_PORT := 22
    static WSMAN_OPTION_MACHINE_ID := 23
    static WSMAN_OPTION_LOCALE := 25
    static WSMAN_OPTION_UI_LANGUAGE := 26
    static WSMAN_OPTION_MAX_ENVELOPE_SIZE_KB := 28
    static WSMAN_OPTION_SHELL_MAX_DATA_SIZE_PER_MESSAGE_KB := 29
    static WSMAN_OPTION_REDIRECT_LOCATION := 30
    static WSMAN_OPTION_SKIP_REVOCATION_CHECK := 31
    static WSMAN_OPTION_ALLOW_NEGOTIATE_IMPLICIT_CREDENTIALS := 32
    static WSMAN_OPTION_USE_SSL := 33
    static WSMAN_OPTION_USE_INTEARACTIVE_TOKEN := 34
}
struct WSManCallbackFlags extends Int32 {
    static WSMAN_FLAG_CALLBACK_END_OF_OPERATION := 1
    static WSMAN_FLAG_CALLBACK_END_OF_STREAM := 8
    static WSMAN_FLAG_CALLBACK_SHELL_SUPPORTS_DISCONNECT := 32
    static WSMAN_FLAG_CALLBACK_SHELL_AUTODISCONNECTED := 64
    static WSMAN_FLAG_CALLBACK_NETWORK_FAILURE_DETECTED := 256
    static WSMAN_FLAG_CALLBACK_RETRYING_AFTER_NETWORK_FAILURE := 512
    static WSMAN_FLAG_CALLBACK_RECONNECTED_AFTER_NETWORK_FAILURE := 1024
    static WSMAN_FLAG_CALLBACK_SHELL_AUTODISCONNECTING := 2048
    static WSMAN_FLAG_CALLBACK_RETRY_ABORTED_DUE_TO_INTERNAL_ERROR := 4096
    static WSMAN_FLAG_CALLBACK_RECEIVE_DELAY_STREAM_REQUEST_PROCESSED := 8192
}
struct WSMAN_STREAM_ID_SET {
    streamIDsCount : UInt32
    streamIDs : PWSTR.Ptr
}
struct WSMAN_ENVIRONMENT_VARIABLE {
    name : PWSTR
    value : PWSTR
}
struct WSMAN_ENVIRONMENT_VARIABLE_SET {
    varsCount : UInt32
    vars : WSMAN_ENVIRONMENT_VARIABLE.Ptr
}
struct WSMAN_SHELL_STARTUP_INFO_V10 {
    inputStreamSet : WSMAN_STREAM_ID_SET.Ptr
    outputStreamSet : WSMAN_STREAM_ID_SET.Ptr
    idleTimeoutMs : UInt32
    workingDirectory : PWSTR
    variableSet : WSMAN_ENVIRONMENT_VARIABLE_SET.Ptr
}
struct WSMAN_SHELL_STARTUP_INFO_V11 {
    Base : WSMAN_SHELL_STARTUP_INFO_V10
    name : PWSTR
}
struct WSMAN_SHELL_DISCONNECT_INFO {
    idleTimeoutMs : UInt32
}
struct WSManShellFlag extends Int32 {
    static WSMAN_FLAG_NO_COMPRESSION := 1
    static WSMAN_FLAG_DELETE_SERVER_SESSION := 2
    static WSMAN_FLAG_SERVER_BUFFERING_MODE_DROP := 4
    static WSMAN_FLAG_SERVER_BUFFERING_MODE_BLOCK := 8
    static WSMAN_FLAG_RECEIVE_DELAY_OUTPUT_STREAM := 16
}
struct WSMAN_RECEIVE_DATA_RESULT {
    streamId : PWSTR
    streamData : WSMAN_DATA
    commandState : PWSTR
    exitCode : UInt32
}
struct WSMAN_CONNECT_DATA {
    data : WSMAN_DATA
}
struct WSMAN_CREATE_SHELL_DATA {
    data : WSMAN_DATA
}
struct WSMAN_RESPONSE_DATA {
    union {
        receiveData : WSMAN_RECEIVE_DATA_RESULT
        connectData : WSMAN_CONNECT_DATA
        createData : WSMAN_CREATE_SHELL_DATA
    }
}
struct WSMAN_SHELL_COMPLETION_FUNCTION extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, WSMAN_ERROR.Ptr, WSMAN_SHELL_HANDLE, WSMAN_COMMAND_HANDLE, WSMAN_OPERATION_HANDLE, WSMAN_RESPONSE_DATA.Ptr, "Void"]
}
struct WSMAN_SHELL_ASYNC {
    operationContext : Struct.Ptr
    completionFunction : WSMAN_SHELL_COMPLETION_FUNCTION
}
struct WSMAN_COMMAND_ARG_SET {
    argsCount : UInt32
    args : PWSTR.Ptr
}
struct WSMAN_CERTIFICATE_DETAILS {
    subject : PWSTR
    issuerName : PWSTR
    issuerThumbprint : PWSTR
    subjectName : PWSTR
}
struct WSMAN_SENDER_DETAILS {
    senderName : PWSTR
    authenticationMechanism : PWSTR
    certificateDetails : WSMAN_CERTIFICATE_DETAILS.Ptr
    clientToken : HANDLE
    httpURL : PWSTR
}
struct WSMAN_PLUGIN_REQUEST {
    senderDetails : WSMAN_SENDER_DETAILS.Ptr
    locale : PWSTR
    resourceUri : PWSTR
    operationInfo : WSMAN_OPERATION_INFO.Ptr
    shutdownNotification : BOOL
    shutdownNotificationHandle : HANDLE
    dataLocale : PWSTR
}
struct WSMAN_PLUGIN_RELEASE_SHELL_CONTEXT extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct WSMAN_PLUGIN_RELEASE_COMMAND_CONTEXT extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, "Void"]
}
struct WSMAN_PLUGIN_STARTUP extends FunctionPointer {
    static Types := [UInt32, PWSTR, PWSTR, Struct.Ptr.Ptr, UInt32]
}
struct WSMAN_PLUGIN_SHUTDOWN extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, UInt32, UInt32]
}
struct WSMAN_PLUGIN_SHELL extends FunctionPointer {
    static Types := [Struct.Ptr, WSMAN_PLUGIN_REQUEST.Ptr, UInt32, WSMAN_SHELL_STARTUP_INFO_V11.Ptr, WSMAN_DATA.Ptr, "Void"]
}
struct WSMAN_PLUGIN_COMMAND extends FunctionPointer {
    static Types := [WSMAN_PLUGIN_REQUEST.Ptr, UInt32, Struct.Ptr, PWSTR, WSMAN_COMMAND_ARG_SET.Ptr, "Void"]
}
struct WSMAN_PLUGIN_SEND extends FunctionPointer {
    static Types := [WSMAN_PLUGIN_REQUEST.Ptr, UInt32, Struct.Ptr, Struct.Ptr, PWSTR, WSMAN_DATA.Ptr, "Void"]
}
struct WSMAN_PLUGIN_RECEIVE extends FunctionPointer {
    static Types := [WSMAN_PLUGIN_REQUEST.Ptr, UInt32, Struct.Ptr, Struct.Ptr, WSMAN_STREAM_ID_SET.Ptr, "Void"]
}
struct WSMAN_PLUGIN_SIGNAL extends FunctionPointer {
    static Types := [WSMAN_PLUGIN_REQUEST.Ptr, UInt32, Struct.Ptr, Struct.Ptr, PWSTR, "Void"]
}
struct WSMAN_PLUGIN_CONNECT extends FunctionPointer {
    static Types := [WSMAN_PLUGIN_REQUEST.Ptr, UInt32, Struct.Ptr, Struct.Ptr, WSMAN_DATA.Ptr, "Void"]
}
struct WSMAN_AUTHZ_QUOTA {
    maxAllowedConcurrentShells : UInt32
    maxAllowedConcurrentOperations : UInt32
    timeslotSize : UInt32
    maxAllowedOperationsPerTimeslot : UInt32
}
struct WSMAN_PLUGIN_AUTHORIZE_USER extends FunctionPointer {
    static Types := [Struct.Ptr, WSMAN_SENDER_DETAILS.Ptr, UInt32, "Void"]
}
struct WSMAN_PLUGIN_AUTHORIZE_OPERATION extends FunctionPointer {
    static Types := [Struct.Ptr, WSMAN_SENDER_DETAILS.Ptr, UInt32, UInt32, PWSTR, PWSTR, "Void"]
}
struct WSMAN_PLUGIN_AUTHORIZE_QUERY_QUOTA extends FunctionPointer {
    static Types := [Struct.Ptr, WSMAN_SENDER_DETAILS.Ptr, UInt32, "Void"]
}
struct WSMAN_PLUGIN_AUTHORIZE_RELEASE_CONTEXT extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct WSManSessionFlags extends Int32 {
    static WSManFlagUTF8 := 1
    static WSManFlagCredUsernamePassword := 4096
    static WSManFlagSkipCACheck := 8192
    static WSManFlagSkipCNCheck := 16384
    static WSManFlagUseNoAuthentication := 32768
    static WSManFlagUseDigest := 65536
    static WSManFlagUseNegotiate := 131072
    static WSManFlagUseBasic := 262144
    static WSManFlagUseKerberos := 524288
    static WSManFlagNoEncryption := 1048576
    static WSManFlagUseClientCertificate := 2097152
    static WSManFlagEnableSPNServerPort := 4194304
    static WSManFlagUTF16 := 8388608
    static WSManFlagUseCredSsp := 16777216
    static WSManFlagSkipRevocationCheck := 33554432
    static WSManFlagAllowNegotiateImplicitCredentials := 67108864
    static WSManFlagUseSsl := 134217728
}
struct WSManEnumFlags extends Int32 {
    static WSManFlagNonXmlText := 1
    static WSManFlagReturnObject := 0
    static WSManFlagReturnEPR := 2
    static WSManFlagReturnObjectAndEPR := 4
    static WSManFlagHierarchyDeep := 0
    static WSManFlagHierarchyShallow := 32
    static WSManFlagHierarchyDeepBasePropsOnly := 64
    static WSManFlagAssociatedInstance := 0
    static WSManFlagAssociationInstance := 128
}
struct WSManProxyAccessTypeFlags extends Int32 {
    static WSManProxyIEConfig := 1
    static WSManProxyWinHttpConfig := 2
    static WSManProxyAutoDetect := 4
    static WSManProxyNoProxyServer := 8
}
struct WSManProxyAuthenticationFlags extends Int32 {
    static WSManFlagProxyAuthenticationUseNegotiate := 1
    static WSManFlagProxyAuthenticationUseBasic := 2
    static WSManFlagProxyAuthenticationUseDigest := 4
}
struct IWSMan extends IDispatch {
    static IID := "{190D8637-5CD3-496D-AD24-69636BB5A3B5}"
    CreateSession(connection, flags, connectionOptions, session)
      => ComCall(7, this.p, BSTR, connection, Int32, flags, IDispatch, connectionOptions, IDispatch.Ptr, session)
    CreateConnectionOptions(connectionOptions)
      => ComCall(8, this.p, IDispatch.Ptr, connectionOptions)
    get_CommandLine(value)
      => ComCall(9, this.p, BSTR.Ptr, value)
    get_Error(value)
      => ComCall(10, this.p, BSTR.Ptr, value)
}
struct IWSManEx extends IWSMan {
    static IID := "{2D53BDAA-798E-49E6-A1AA-74D01256F411}"
    CreateResourceLocator(strResourceLocator, newResourceLocator)
      => ComCall(11, this.p, BSTR, strResourceLocator, IDispatch.Ptr, newResourceLocator)
    SessionFlagUTF8(flags)
      => ComCall(12, this.p, Int32.Ptr, flags)
    SessionFlagCredUsernamePassword(flags)
      => ComCall(13, this.p, Int32.Ptr, flags)
    SessionFlagSkipCACheck(flags)
      => ComCall(14, this.p, Int32.Ptr, flags)
    SessionFlagSkipCNCheck(flags)
      => ComCall(15, this.p, Int32.Ptr, flags)
    SessionFlagUseDigest(flags)
      => ComCall(16, this.p, Int32.Ptr, flags)
    SessionFlagUseNegotiate(flags)
      => ComCall(17, this.p, Int32.Ptr, flags)
    SessionFlagUseBasic(flags)
      => ComCall(18, this.p, Int32.Ptr, flags)
    SessionFlagUseKerberos(flags)
      => ComCall(19, this.p, Int32.Ptr, flags)
    SessionFlagNoEncryption(flags)
      => ComCall(20, this.p, Int32.Ptr, flags)
    SessionFlagEnableSPNServerPort(flags)
      => ComCall(21, this.p, Int32.Ptr, flags)
    SessionFlagUseNoAuthentication(flags)
      => ComCall(22, this.p, Int32.Ptr, flags)
    EnumerationFlagNonXmlText(flags)
      => ComCall(23, this.p, Int32.Ptr, flags)
    EnumerationFlagReturnEPR(flags)
      => ComCall(24, this.p, Int32.Ptr, flags)
    EnumerationFlagReturnObjectAndEPR(flags)
      => ComCall(25, this.p, Int32.Ptr, flags)
    GetErrorMessage(errorNumber, errorMessage)
      => ComCall(26, this.p, UInt32, errorNumber, BSTR.Ptr, errorMessage)
    EnumerationFlagHierarchyDeep(flags)
      => ComCall(27, this.p, Int32.Ptr, flags)
    EnumerationFlagHierarchyShallow(flags)
      => ComCall(28, this.p, Int32.Ptr, flags)
    EnumerationFlagHierarchyDeepBasePropsOnly(flags)
      => ComCall(29, this.p, Int32.Ptr, flags)
    EnumerationFlagReturnObject(flags)
      => ComCall(30, this.p, Int32.Ptr, flags)
}
struct IWSManEx2 extends IWSManEx {
    static IID := "{1D1B5AE0-42D9-4021-8261-3987619512E9}"
    SessionFlagUseClientCertificate(flags)
      => ComCall(31, this.p, Int32.Ptr, flags)
}
struct IWSManEx3 extends IWSManEx2 {
    static IID := "{6400E966-011D-4EAC-8474-049E0848AFAD}"
    SessionFlagUTF16(flags)
      => ComCall(32, this.p, Int32.Ptr, flags)
    SessionFlagUseCredSsp(flags)
      => ComCall(33, this.p, Int32.Ptr, flags)
    EnumerationFlagAssociationInstance(flags)
      => ComCall(34, this.p, Int32.Ptr, flags)
    EnumerationFlagAssociatedInstance(flags)
      => ComCall(35, this.p, Int32.Ptr, flags)
    SessionFlagSkipRevocationCheck(flags)
      => ComCall(36, this.p, Int32.Ptr, flags)
    SessionFlagAllowNegotiateImplicitCredentials(flags)
      => ComCall(37, this.p, Int32.Ptr, flags)
    SessionFlagUseSsl(flags)
      => ComCall(38, this.p, Int32.Ptr, flags)
}
struct IWSManConnectionOptions extends IDispatch {
    static IID := "{F704E861-9E52-464F-B786-DA5EB2320FDD}"
    get_UserName(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    put_UserName(name)
      => ComCall(8, this.p, BSTR, name)
    put_Password(password)
      => ComCall(9, this.p, BSTR, password)
}
struct IWSManConnectionOptionsEx extends IWSManConnectionOptions {
    static IID := "{EF43EDF7-2A48-4D93-9526-8BD6AB6D4A6B}"
    get_CertificateThumbprint(thumbprint)
      => ComCall(10, this.p, BSTR.Ptr, thumbprint)
    put_CertificateThumbprint(thumbprint)
      => ComCall(11, this.p, BSTR, thumbprint)
}
struct IWSManConnectionOptionsEx2 extends IWSManConnectionOptionsEx {
    static IID := "{F500C9EC-24EE-48AB-B38D-FC9A164C658E}"
    SetProxy(accessType, authenticationMechanism, userName, password)
      => ComCall(12, this.p, Int32, accessType, Int32, authenticationMechanism, BSTR, userName, BSTR, password)
    ProxyIEConfig(value)
      => ComCall(13, this.p, Int32.Ptr, value)
    ProxyWinHttpConfig(value)
      => ComCall(14, this.p, Int32.Ptr, value)
    ProxyAutoDetect(value)
      => ComCall(15, this.p, Int32.Ptr, value)
    ProxyNoProxyServer(value)
      => ComCall(16, this.p, Int32.Ptr, value)
    ProxyAuthenticationUseNegotiate(value)
      => ComCall(17, this.p, Int32.Ptr, value)
    ProxyAuthenticationUseBasic(value)
      => ComCall(18, this.p, Int32.Ptr, value)
    ProxyAuthenticationUseDigest(value)
      => ComCall(19, this.p, Int32.Ptr, value)
}
struct IWSManSession extends IDispatch {
    static IID := "{FC84FC58-1286-40C4-9DA0-C8EF6EC241E0}"
    Get(resourceUri, flags, resource)
      => ComCall(7, this.p, VARIANT, resourceUri, Int32, flags, BSTR.Ptr, resource)
    Put(resourceUri, resource, flags, resultResource)
      => ComCall(8, this.p, VARIANT, resourceUri, BSTR, resource, Int32, flags, BSTR.Ptr, resultResource)
    Create(resourceUri, resource, flags, newUri)
      => ComCall(9, this.p, VARIANT, resourceUri, BSTR, resource, Int32, flags, BSTR.Ptr, newUri)
    Delete(resourceUri, flags)
      => ComCall(10, this.p, VARIANT, resourceUri, Int32, flags)
    Invoke(actionUri, resourceUri, parameters, flags, result)
      => ComCall(11, this.p, BSTR, actionUri, VARIANT, resourceUri, BSTR, parameters, Int32, flags, BSTR.Ptr, result)
    Enumerate(resourceUri, filter, dialect, flags, resultSet)
      => ComCall(12, this.p, VARIANT, resourceUri, BSTR, filter, BSTR, dialect, Int32, flags, IDispatch.Ptr, resultSet)
    Identify(flags, result)
      => ComCall(13, this.p, Int32, flags, BSTR.Ptr, result)
    get_Error(value)
      => ComCall(14, this.p, BSTR.Ptr, value)
    get_BatchItems(value)
      => ComCall(15, this.p, Int32.Ptr, value)
    put_BatchItems(value)
      => ComCall(16, this.p, Int32, value)
    get_Timeout(value)
      => ComCall(17, this.p, Int32.Ptr, value)
    put_Timeout(value)
      => ComCall(18, this.p, Int32, value)
}
struct IWSManEnumerator extends IDispatch {
    static IID := "{F3457CA9-ABB9-4FA5-B850-90E8CA300E7F}"
    ReadItem(resource)
      => ComCall(7, this.p, BSTR.Ptr, resource)
    get_AtEndOfStream(eos)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, eos)
    get_Error(value)
      => ComCall(9, this.p, BSTR.Ptr, value)
}
struct IWSManResourceLocator extends IDispatch {
    static IID := "{A7A1BA28-DE41-466A-AD0A-C4059EAD7428}"
    put_ResourceURI(uri)
      => ComCall(7, this.p, BSTR, uri)
    get_ResourceURI(uri)
      => ComCall(8, this.p, BSTR.Ptr, uri)
    AddSelector(resourceSelName, selValue)
      => ComCall(9, this.p, BSTR, resourceSelName, VARIANT, selValue)
    ClearSelectors()
      => ComCall(10, this.p)
    get_FragmentPath(text)
      => ComCall(11, this.p, BSTR.Ptr, text)
    put_FragmentPath(text)
      => ComCall(12, this.p, BSTR, text)
    get_FragmentDialect(text)
      => ComCall(13, this.p, BSTR.Ptr, text)
    put_FragmentDialect(text)
      => ComCall(14, this.p, BSTR, text)
    AddOption(OptionName, OptionValue, mustComply)
      => ComCall(15, this.p, BSTR, OptionName, VARIANT, OptionValue, BOOL, mustComply)
    put_MustUnderstandOptions(mustUnderstand)
      => ComCall(16, this.p, BOOL, mustUnderstand)
    get_MustUnderstandOptions(mustUnderstand)
      => ComCall(17, this.p, BOOL.Ptr, mustUnderstand)
    ClearOptions()
      => ComCall(18, this.p)
    get_Error(value)
      => ComCall(19, this.p, BSTR.Ptr, value)
}
struct IWSManResourceLocatorInternal extends IUnknown {
    static IID := "{EFFAEAD7-7EC8-4716-B9BE-F2E7E9FB4ADB}"
}
struct IWSManInternal extends IDispatch {
    static IID := "{04AE2B1D-9954-4D99-94A9-A961E72C3A13}"
    ConfigSDDL(session, resourceUri, flags, resource)
      => ComCall(7, this.p, IDispatch, session, VARIANT, resourceUri, Int32, flags, BSTR.Ptr, resource)
}
