#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, PWSTR, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, IUnknown, SAFEARRAY}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct MI_Module_Self {
    Value : IntPtr
}
struct MI_Result extends Int32 {
    static MI_RESULT_OK := 0
    static MI_RESULT_FAILED := 1
    static MI_RESULT_ACCESS_DENIED := 2
    static MI_RESULT_INVALID_NAMESPACE := 3
    static MI_RESULT_INVALID_PARAMETER := 4
    static MI_RESULT_INVALID_CLASS := 5
    static MI_RESULT_NOT_FOUND := 6
    static MI_RESULT_NOT_SUPPORTED := 7
    static MI_RESULT_CLASS_HAS_CHILDREN := 8
    static MI_RESULT_CLASS_HAS_INSTANCES := 9
    static MI_RESULT_INVALID_SUPERCLASS := 10
    static MI_RESULT_ALREADY_EXISTS := 11
    static MI_RESULT_NO_SUCH_PROPERTY := 12
    static MI_RESULT_TYPE_MISMATCH := 13
    static MI_RESULT_QUERY_LANGUAGE_NOT_SUPPORTED := 14
    static MI_RESULT_INVALID_QUERY := 15
    static MI_RESULT_METHOD_NOT_AVAILABLE := 16
    static MI_RESULT_METHOD_NOT_FOUND := 17
    static MI_RESULT_NAMESPACE_NOT_EMPTY := 20
    static MI_RESULT_INVALID_ENUMERATION_CONTEXT := 21
    static MI_RESULT_INVALID_OPERATION_TIMEOUT := 22
    static MI_RESULT_PULL_HAS_BEEN_ABANDONED := 23
    static MI_RESULT_PULL_CANNOT_BE_ABANDONED := 24
    static MI_RESULT_FILTERED_ENUMERATION_NOT_SUPPORTED := 25
    static MI_RESULT_CONTINUATION_ON_ERROR_NOT_SUPPORTED := 26
    static MI_RESULT_SERVER_LIMITS_EXCEEDED := 27
    static MI_RESULT_SERVER_IS_SHUTTING_DOWN := 28
}
struct MI_ErrorCategory extends Int32 {
    static MI_ERRORCATEGORY_NOT_SPECIFIED := 0
    static MI_ERRORCATEGORY_OPEN_ERROR := 1
    static MI_ERRORCATEGORY_CLOS_EERROR := 2
    static MI_ERRORCATEGORY_DEVICE_ERROR := 3
    static MI_ERRORCATEGORY_DEADLOCK_DETECTED := 4
    static MI_ERRORCATEGORY_INVALID_ARGUMENT := 5
    static MI_ERRORCATEGORY_INVALID_DATA := 6
    static MI_ERRORCATEGORY_INVALID_OPERATION := 7
    static MI_ERRORCATEGORY_INVALID_RESULT := 8
    static MI_ERRORCATEGORY_INVALID_TYPE := 9
    static MI_ERRORCATEGORY_METADATA_ERROR := 10
    static MI_ERRORCATEGORY_NOT_IMPLEMENTED := 11
    static MI_ERRORCATEGORY_NOT_INSTALLED := 12
    static MI_ERRORCATEGORY_OBJECT_NOT_FOUND := 13
    static MI_ERRORCATEGORY_OPERATION_STOPPED := 14
    static MI_ERRORCATEGORY_OPERATION_TIMEOUT := 15
    static MI_ERRORCATEGORY_SYNTAX_ERROR := 16
    static MI_ERRORCATEGORY_PARSER_ERROR := 17
    static MI_ERRORCATEGORY_ACCESS_DENIED := 18
    static MI_ERRORCATEGORY_RESOURCE_BUSY := 19
    static MI_ERRORCATEGORY_RESOURCE_EXISTS := 20
    static MI_ERRORCATEGORY_RESOURCE_UNAVAILABLE := 21
    static MI_ERRORCATEGORY_READ_ERROR := 22
    static MI_ERRORCATEGORY_WRITE_ERROR := 23
    static MI_ERRORCATEGORY_FROM_STDERR := 24
    static MI_ERRORCATEGORY_SECURITY_ERROR := 25
    static MI_ERRORCATEGORY_PROTOCOL_ERROR := 26
    static MI_ERRORCATEGORY_CONNECTION_ERROR := 27
    static MI_ERRORCATEGORY_AUTHENTICATION_ERROR := 28
    static MI_ERRORCATEGORY_LIMITS_EXCEEDED := 29
    static MI_ERRORCATEGORY_QUOTA_EXCEEDED := 30
    static MI_ERRORCATEGORY_NOT_ENABLED := 31
}
struct MI_PromptType extends Int32 {
    static MI_PROMPTTYPE_NORMAL := 0
    static MI_PROMPTTYPE_CRITICAL := 1
}
struct MI_CallbackMode extends Int32 {
    static MI_CALLBACKMODE_REPORT := 0
    static MI_CALLBACKMODE_INQUIRE := 1
    static MI_CALLBACKMODE_IGNORE := 2
}
struct MI_ProviderArchitecture extends Int32 {
    static MI_PROVIDER_ARCHITECTURE_32BIT := 0
    static MI_PROVIDER_ARCHITECTURE_64BIT := 1
}
struct MI_Type extends Int32 {
    static MI_BOOLEAN := 0
    static MI_UINT8 := 1
    static MI_SINT8 := 2
    static MI_UINT16 := 3
    static MI_SINT16 := 4
    static MI_UINT32 := 5
    static MI_SINT32 := 6
    static MI_UINT64 := 7
    static MI_SINT64 := 8
    static MI_REAL32 := 9
    static MI_REAL64 := 10
    static MI_CHAR16 := 11
    static MI_DATETIME := 12
    static MI_STRING := 13
    static MI_REFERENCE := 14
    static MI_INSTANCE := 15
    static MI_BOOLEANA := 16
    static MI_UINT8A := 17
    static MI_SINT8A := 18
    static MI_UINT16A := 19
    static MI_SINT16A := 20
    static MI_UINT32A := 21
    static MI_SINT32A := 22
    static MI_UINT64A := 23
    static MI_SINT64A := 24
    static MI_REAL32A := 25
    static MI_REAL64A := 26
    static MI_CHAR16A := 27
    static MI_DATETIMEA := 28
    static MI_STRINGA := 29
    static MI_REFERENCEA := 30
    static MI_INSTANCEA := 31
    static MI_ARRAY := 16
}
struct MI_Timestamp {
    year : UInt32
    month : UInt32
    day : UInt32
    hour : UInt32
    minute : UInt32
    second : UInt32
    microseconds : UInt32
    utc : Int32
}
struct MI_Interval {
    days : UInt32
    hours : UInt32
    minutes : UInt32
    seconds : UInt32
    microseconds : UInt32
    __padding1 : UInt32
    __padding2 : UInt32
    __padding3 : UInt32
}
struct MI_Datetime {
    isTimestamp : UInt32
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            timestamp : MI_Timestamp
            interval : MI_Interval
        }
    }
}
struct MI_BooleanA {
    data : UInt8.Ptr
    size : UInt32
}
struct MI_Uint8A {
    data : UInt8.Ptr
    size : UInt32
}
struct MI_Sint8A {
    data : Int8.Ptr
    size : UInt32
}
struct MI_Uint16A {
    data : UInt16.Ptr
    size : UInt32
}
struct MI_Sint16A {
    data : Int16.Ptr
    size : UInt32
}
struct MI_Uint32A {
    data : UInt32.Ptr
    size : UInt32
}
struct MI_Sint32A {
    data : Int32.Ptr
    size : UInt32
}
struct MI_Uint64A {
    data : Int64.Ptr
    size : UInt32
}
struct MI_Sint64A {
    data : Int64.Ptr
    size : UInt32
}
struct MI_Real32A {
    data : Float32.Ptr
    size : UInt32
}
struct MI_Real64A {
    data : Float64.Ptr
    size : UInt32
}
struct MI_Char16A {
    data : UInt16.Ptr
    size : UInt32
}
struct MI_DatetimeA {
    data : MI_Datetime.Ptr
    size : UInt32
}
struct MI_StringA {
    data : UInt16.Ptr.Ptr
    size : UInt32
}
struct MI_ReferenceA {
    data : MI_Instance.Ptr.Ptr
    size : UInt32
}
struct MI_InstanceA {
    data : MI_Instance.Ptr.Ptr
    size : UInt32
}
struct MI_Array {
    data : Struct.Ptr
    size : UInt32
}
struct MI_ConstBooleanA {
    data : UInt8.Ptr
    size : UInt32
}
struct MI_ConstUint8A {
    data : UInt8.Ptr
    size : UInt32
}
struct MI_ConstSint8A {
    data : Int8.Ptr
    size : UInt32
}
struct MI_ConstUint16A {
    data : UInt16.Ptr
    size : UInt32
}
struct MI_ConstSint16A {
    data : Int16.Ptr
    size : UInt32
}
struct MI_ConstUint32A {
    data : UInt32.Ptr
    size : UInt32
}
struct MI_ConstSint32A {
    data : Int32.Ptr
    size : UInt32
}
struct MI_ConstUint64A {
    data : Int64.Ptr
    size : UInt32
}
struct MI_ConstSint64A {
    data : Int64.Ptr
    size : UInt32
}
struct MI_ConstReal32A {
    data : Float32.Ptr
    size : UInt32
}
struct MI_ConstReal64A {
    data : Float64.Ptr
    size : UInt32
}
struct MI_ConstChar16A {
    data : UInt16.Ptr
    size : UInt32
}
struct MI_ConstDatetimeA {
    data : MI_Datetime.Ptr
    size : UInt32
}
struct MI_ConstStringA {
    data : UInt16.Ptr.Ptr
    size : UInt32
}
struct MI_ConstReferenceA {
    data : MI_Instance.Ptr.Ptr
    size : UInt32
}
struct MI_ConstInstanceA {
    data : MI_Instance.Ptr.Ptr
    size : UInt32
}
struct MI_Value {
    union {
        boolean : UInt8
        uint8 : UInt8
        sint8 : Int8
        uint16 : UInt16
        sint16 : Int16
        uint32 : UInt32
        sint32 : Int32
        uint64 : Int64
        sint64 : Int64
        real32 : Float32
        real64 : Float64
        char16 : UInt16
        datetime : MI_Datetime
        string : UInt16.Ptr
        instance : MI_Instance.Ptr
        reference : MI_Instance.Ptr
        booleana : MI_BooleanA
        uint8a : MI_Uint8A
        sint8a : MI_Sint8A
        uint16a : MI_Uint16A
        sint16a : MI_Sint16A
        uint32a : MI_Uint32A
        sint32a : MI_Sint32A
        uint64a : MI_Uint64A
        sint64a : MI_Sint64A
        real32a : MI_Real32A
        real64a : MI_Real64A
        char16a : MI_Char16A
        datetimea : MI_DatetimeA
        stringa : MI_StringA
        referencea : MI_ReferenceA
        instancea : MI_InstanceA
        array : MI_Array
    }
}
struct MI_BooleanField {
    value : UInt8
    exists : UInt8
    flags : UInt8
}
struct MI_Sint8Field {
    value : Int8
    exists : UInt8
    flags : UInt8
}
struct MI_Uint8Field {
    value : UInt8
    exists : UInt8
    flags : UInt8
}
struct MI_Sint16Field {
    value : Int16
    exists : UInt8
    flags : UInt8
}
struct MI_Uint16Field {
    value : UInt16
    exists : UInt8
    flags : UInt8
}
struct MI_Sint32Field {
    value : Int32
    exists : UInt8
    flags : UInt8
}
struct MI_Uint32Field {
    value : UInt32
    exists : UInt8
    flags : UInt8
}
struct MI_Sint64Field {
    value : Int64
    exists : UInt8
    flags : UInt8
}
struct MI_Uint64Field {
    value : Int64
    exists : UInt8
    flags : UInt8
}
struct MI_Real32Field {
    value : Float32
    exists : UInt8
    flags : UInt8
}
struct MI_Real64Field {
    value : Float64
    exists : UInt8
    flags : UInt8
}
struct MI_Char16Field {
    value : UInt16
    exists : UInt8
    flags : UInt8
}
struct MI_DatetimeField {
    value : MI_Datetime
    exists : UInt8
    flags : UInt8
}
struct MI_StringField {
    value : UInt16.Ptr
    exists : UInt8
    flags : UInt8
}
struct MI_ReferenceField {
    value : MI_Instance.Ptr
    exists : UInt8
    flags : UInt8
}
struct MI_InstanceField {
    value : MI_Instance.Ptr
    exists : UInt8
    flags : UInt8
}
struct MI_BooleanAField {
    value : MI_BooleanA
    exists : UInt8
    flags : UInt8
}
struct MI_Uint8AField {
    value : MI_Uint8A
    exists : UInt8
    flags : UInt8
}
struct MI_Sint8AField {
    value : MI_Sint8A
    exists : UInt8
    flags : UInt8
}
struct MI_Uint16AField {
    value : MI_Uint16A
    exists : UInt8
    flags : UInt8
}
struct MI_Sint16AField {
    value : MI_Sint16A
    exists : UInt8
    flags : UInt8
}
struct MI_Uint32AField {
    value : MI_Uint32A
    exists : UInt8
    flags : UInt8
}
struct MI_Sint32AField {
    value : MI_Sint32A
    exists : UInt8
    flags : UInt8
}
struct MI_Uint64AField {
    value : MI_Uint64A
    exists : UInt8
    flags : UInt8
}
struct MI_Sint64AField {
    value : MI_Sint64A
    exists : UInt8
    flags : UInt8
}
struct MI_Real32AField {
    value : MI_Real32A
    exists : UInt8
    flags : UInt8
}
struct MI_Real64AField {
    value : MI_Real64A
    exists : UInt8
    flags : UInt8
}
struct MI_Char16AField {
    value : MI_Char16A
    exists : UInt8
    flags : UInt8
}
struct MI_DatetimeAField {
    value : MI_DatetimeA
    exists : UInt8
    flags : UInt8
}
struct MI_StringAField {
    value : MI_StringA
    exists : UInt8
    flags : UInt8
}
struct MI_ReferenceAField {
    value : MI_ReferenceA
    exists : UInt8
    flags : UInt8
}
struct MI_InstanceAField {
    value : MI_InstanceA
    exists : UInt8
    flags : UInt8
}
struct MI_ArrayField {
    value : MI_Array
    exists : UInt8
    flags : UInt8
}
struct MI_ConstBooleanField {
    value : UInt8
    exists : UInt8
    flags : UInt8
}
struct MI_ConstSint8Field {
    value : Int8
    exists : UInt8
    flags : UInt8
}
struct MI_ConstUint8Field {
    value : UInt8
    exists : UInt8
    flags : UInt8
}
struct MI_ConstSint16Field {
    value : Int16
    exists : UInt8
    flags : UInt8
}
struct MI_ConstUint16Field {
    value : UInt16
    exists : UInt8
    flags : UInt8
}
struct MI_ConstSint32Field {
    value : Int32
    exists : UInt8
    flags : UInt8
}
struct MI_ConstUint32Field {
    value : UInt32
    exists : UInt8
    flags : UInt8
}
struct MI_ConstSint64Field {
    value : Int64
    exists : UInt8
    flags : UInt8
}
struct MI_ConstUint64Field {
    value : Int64
    exists : UInt8
    flags : UInt8
}
struct MI_ConstReal32Field {
    value : Float32
    exists : UInt8
    flags : UInt8
}
struct MI_ConstReal64Field {
    value : Float64
    exists : UInt8
    flags : UInt8
}
struct MI_ConstChar16Field {
    value : UInt16
    exists : UInt8
    flags : UInt8
}
struct MI_ConstDatetimeField {
    value : MI_Datetime
    exists : UInt8
    flags : UInt8
}
struct MI_ConstStringField {
    value : UInt16.Ptr
    exists : UInt8
    flags : UInt8
}
struct MI_ConstReferenceField {
    value : MI_Instance.Ptr
    exists : UInt8
    flags : UInt8
}
struct MI_ConstInstanceField {
    value : MI_Instance.Ptr
    exists : UInt8
    flags : UInt8
}
struct MI_ConstBooleanAField {
    value : MI_ConstBooleanA
    exists : UInt8
    flags : UInt8
}
struct MI_ConstUint8AField {
    value : MI_ConstUint8A
    exists : UInt8
    flags : UInt8
}
struct MI_ConstSint8AField {
    value : MI_ConstSint8A
    exists : UInt8
    flags : UInt8
}
struct MI_ConstUint16AField {
    value : MI_ConstUint16A
    exists : UInt8
    flags : UInt8
}
struct MI_ConstSint16AField {
    value : MI_ConstSint16A
    exists : UInt8
    flags : UInt8
}
struct MI_ConstUint32AField {
    value : MI_ConstUint32A
    exists : UInt8
    flags : UInt8
}
struct MI_ConstSint32AField {
    value : MI_ConstSint32A
    exists : UInt8
    flags : UInt8
}
struct MI_ConstUint64AField {
    value : MI_ConstUint64A
    exists : UInt8
    flags : UInt8
}
struct MI_ConstSint64AField {
    value : MI_ConstSint64A
    exists : UInt8
    flags : UInt8
}
struct MI_ConstReal32AField {
    value : MI_ConstReal32A
    exists : UInt8
    flags : UInt8
}
struct MI_ConstReal64AField {
    value : MI_ConstReal64A
    exists : UInt8
    flags : UInt8
}
struct MI_ConstChar16AField {
    value : MI_ConstChar16A
    exists : UInt8
    flags : UInt8
}
struct MI_ConstDatetimeAField {
    value : MI_ConstDatetimeA
    exists : UInt8
    flags : UInt8
}
struct MI_ConstStringAField {
    value : MI_ConstStringA
    exists : UInt8
    flags : UInt8
}
struct MI_ConstReferenceAField {
    value : MI_ConstReferenceA
    exists : UInt8
    flags : UInt8
}
struct MI_ConstInstanceAField {
    value : MI_ConstInstanceA
    exists : UInt8
    flags : UInt8
}
struct MI_ServerFT {
    GetVersion : IntPtr
    GetSystemName : IntPtr
}
struct MI_Server {
    serverFT : MI_ServerFT.Ptr
    contextFT : MI_ContextFT.Ptr
    instanceFT : MI_InstanceFT.Ptr
    propertySetFT : MI_PropertySetFT.Ptr
    filterFT : MI_FilterFT.Ptr
}
struct MI_FilterFT {
    Evaluate : IntPtr
    GetExpression : IntPtr
}
struct MI_Filter {
    ft : MI_FilterFT.Ptr
    reserved : IntPtr[3]
}
struct MI_PropertySetFT {
    GetElementCount : IntPtr
    ContainsElement : IntPtr
    AddElement : IntPtr
    GetElementAt : IntPtr
    Clear : IntPtr
    Destruct : IntPtr
    Delete : IntPtr
    Clone : IntPtr
}
struct MI_PropertySet {
    ft : MI_PropertySetFT.Ptr
    reserved : IntPtr[3]
}
struct MI_ObjectDecl {
    flags : UInt32
    code : UInt32
    name : UInt16.Ptr
    qualifiers : MI_Qualifier.Ptr.Ptr
    numQualifiers : UInt32
    properties : MI_PropertyDecl.Ptr.Ptr
    numProperties : UInt32
    size : UInt32
}
struct MI_ClassDecl {
    flags : UInt32
    code : UInt32
    name : UInt16.Ptr
    qualifiers : MI_Qualifier.Ptr.Ptr
    numQualifiers : UInt32
    properties : MI_PropertyDecl.Ptr.Ptr
    numProperties : UInt32
    size : UInt32
    superClass : UInt16.Ptr
    superClassDecl : MI_ClassDecl.Ptr
    methods : MI_MethodDecl.Ptr.Ptr
    numMethods : UInt32
    schema : MI_SchemaDecl.Ptr
    providerFT : MI_ProviderFT.Ptr
    owningClass : MI_Class.Ptr
}
struct MI_FeatureDecl {
    flags : UInt32
    code : UInt32
    name : UInt16.Ptr
    qualifiers : MI_Qualifier.Ptr.Ptr
    numQualifiers : UInt32
}
struct MI_ParameterDecl {
    flags : UInt32
    code : UInt32
    name : UInt16.Ptr
    qualifiers : MI_Qualifier.Ptr.Ptr
    numQualifiers : UInt32
    type : UInt32
    className : UInt16.Ptr
    subscript : UInt32
    offset : UInt32
}
struct MI_PropertyDecl {
    flags : UInt32
    code : UInt32
    name : UInt16.Ptr
    qualifiers : MI_Qualifier.Ptr.Ptr
    numQualifiers : UInt32
    type : UInt32
    className : UInt16.Ptr
    subscript : UInt32
    offset : UInt32
    origin : UInt16.Ptr
    propagator : UInt16.Ptr
    value : Struct.Ptr
}
struct MI_MethodDecl_Invoke extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, UInt16.Ptr, MI_Instance.Ptr, MI_Instance.Ptr, "Void"]
}
struct MI_MethodDecl {
    flags : UInt32
    code : UInt32
    name : UInt16.Ptr
    qualifiers : MI_Qualifier.Ptr.Ptr
    numQualifiers : UInt32
    parameters : MI_ParameterDecl.Ptr.Ptr
    numParameters : UInt32
    size : UInt32
    returnType : UInt32
    origin : UInt16.Ptr
    propagator : UInt16.Ptr
    schema : MI_SchemaDecl.Ptr
    function : MI_MethodDecl_Invoke
}
struct MI_QualifierDecl {
    name : UInt16.Ptr
    type : UInt32
    scope : UInt32
    flavor : UInt32
    subscript : UInt32
    value : Struct.Ptr
}
struct MI_Qualifier {
    name : UInt16.Ptr
    type : UInt32
    flavor : UInt32
    value : Struct.Ptr
}
struct MI_SchemaDecl {
    qualifierDecls : MI_QualifierDecl.Ptr.Ptr
    numQualifierDecls : UInt32
    classDecls : MI_ClassDecl.Ptr.Ptr
    numClassDecls : UInt32
}
struct MI_ProviderFT_Load extends FunctionPointer {
    static Types := [Struct.Ptr.Ptr, MI_Module_Self.Ptr, MI_Context.Ptr, "Void"]
}
struct MI_ProviderFT_Unload extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, "Void"]
}
struct MI_ProviderFT_GetInstance extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, MI_Instance.Ptr, MI_PropertySet.Ptr, "Void"]
}
struct MI_ProviderFT_EnumerateInstances extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, MI_PropertySet.Ptr, UInt8, MI_Filter.Ptr, "Void"]
}
struct MI_ProviderFT_CreateInstance extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, MI_Instance.Ptr, "Void"]
}
struct MI_ProviderFT_ModifyInstance extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, MI_Instance.Ptr, MI_PropertySet.Ptr, "Void"]
}
struct MI_ProviderFT_DeleteInstance extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, MI_Instance.Ptr, "Void"]
}
struct MI_ProviderFT_AssociatorInstances extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, MI_Instance.Ptr, UInt16.Ptr, UInt16.Ptr, UInt16.Ptr, MI_PropertySet.Ptr, UInt8, MI_Filter.Ptr, "Void"]
}
struct MI_ProviderFT_ReferenceInstances extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, MI_Instance.Ptr, UInt16.Ptr, MI_PropertySet.Ptr, UInt8, MI_Filter.Ptr, "Void"]
}
struct MI_ProviderFT_EnableIndications extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, "Void"]
}
struct MI_ProviderFT_DisableIndications extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, "Void"]
}
struct MI_ProviderFT_Subscribe extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, MI_Filter.Ptr, UInt16.Ptr, Int64, Struct.Ptr.Ptr, "Void"]
}
struct MI_ProviderFT_Unsubscribe extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, Int64, Struct.Ptr, "Void"]
}
struct MI_ProviderFT_Invoke extends FunctionPointer {
    static Types := [Struct.Ptr, MI_Context.Ptr, UInt16.Ptr, UInt16.Ptr, UInt16.Ptr, MI_Instance.Ptr, MI_Instance.Ptr, "Void"]
}
struct MI_ProviderFT {
    Load : MI_ProviderFT_Load
    Unload : MI_ProviderFT_Unload
    GetInstance : MI_ProviderFT_GetInstance
    EnumerateInstances : MI_ProviderFT_EnumerateInstances
    CreateInstance : MI_ProviderFT_CreateInstance
    ModifyInstance : MI_ProviderFT_ModifyInstance
    DeleteInstance : MI_ProviderFT_DeleteInstance
    AssociatorInstances : MI_ProviderFT_AssociatorInstances
    ReferenceInstances : MI_ProviderFT_ReferenceInstances
    EnableIndications : MI_ProviderFT_EnableIndications
    DisableIndications : MI_ProviderFT_DisableIndications
    Subscribe : MI_ProviderFT_Subscribe
    Unsubscribe : MI_ProviderFT_Unsubscribe
    Invoke : MI_ProviderFT_Invoke
}
struct MI_Module_Load extends FunctionPointer {
    static Types := [MI_Module_Self.Ptr.Ptr, MI_Context.Ptr, "Void"]
}
struct MI_Module_Unload extends FunctionPointer {
    static Types := [MI_Module_Self.Ptr, MI_Context.Ptr, "Void"]
}
struct MI_Module {
    version : UInt32
    generatorVersion : UInt32
    flags : UInt32
    charSize : UInt32
    schemaDecl : MI_SchemaDecl.Ptr
    Load : MI_Module_Load
    Unload : MI_Module_Unload
    dynamicProviderFT : MI_ProviderFT.Ptr
}
struct MI_InstanceFT {
    Clone : IntPtr
    Destruct : IntPtr
    Delete : IntPtr
    IsA : IntPtr
    GetClassNameA : IntPtr
    SetNameSpace : IntPtr
    GetNameSpace : IntPtr
    GetElementCount : IntPtr
    AddElement : IntPtr
    SetElement : IntPtr
    SetElementAt : IntPtr
    GetElement : IntPtr
    GetElementAt : IntPtr
    ClearElement : IntPtr
    ClearElementAt : IntPtr
    GetServerName : IntPtr
    SetServerName : IntPtr
    GetClass : IntPtr
}
struct MI_InstanceExFT {
    parent : MI_InstanceFT
    Normalize : IntPtr
}
struct MI_Instance {
    ft : MI_InstanceFT.Ptr
    classDecl : MI_ClassDecl.Ptr
    serverName : UInt16.Ptr
    nameSpace : UInt16.Ptr
    reserved : IntPtr[4]
}
struct MI_LocaleType extends Int32 {
    static MI_LOCALE_TYPE_REQUESTED_UI := 0
    static MI_LOCALE_TYPE_REQUESTED_DATA := 1
    static MI_LOCALE_TYPE_CLOSEST_UI := 2
    static MI_LOCALE_TYPE_CLOSEST_DATA := 3
}
struct MI_CancellationReason extends Int32 {
    static MI_REASON_NONE := 0
    static MI_REASON_TIMEOUT := 1
    static MI_REASON_SHUTDOWN := 2
    static MI_REASON_SERVICESTOP := 3
}
struct MI_CancelCallback extends FunctionPointer {
    static Types := [MI_CancellationReason, Struct.Ptr, "Void"]
}
struct MI_ContextFT {
    PostResult : IntPtr
    PostInstance : IntPtr
    PostIndication : IntPtr
    ConstructInstance : IntPtr
    ConstructParameters : IntPtr
    NewInstance : IntPtr
    NewDynamicInstance : IntPtr
    NewParameters : IntPtr
    Canceled : IntPtr
    GetLocale : IntPtr
    RegisterCancel : IntPtr
    RequestUnload : IntPtr
    RefuseUnload : IntPtr
    GetLocalSession : IntPtr
    SetStringOption : IntPtr
    GetStringOption : IntPtr
    GetNumberOption : IntPtr
    GetCustomOption : IntPtr
    GetCustomOptionCount : IntPtr
    GetCustomOptionAt : IntPtr
    WriteMessage : IntPtr
    WriteProgress : IntPtr
    WriteStreamParameter : IntPtr
    WriteCimError : IntPtr
    PromptUser : IntPtr
    ShouldProcess : IntPtr
    ShouldContinue : IntPtr
    PostError : IntPtr
    PostCimError : IntPtr
    WriteError : IntPtr
}
struct MI_Context {
    ft : MI_ContextFT.Ptr
    reserved : IntPtr[3]
}
struct MI_MainFunction extends FunctionPointer {
    static Types := [MI_Server.Ptr, MI_Module.Ptr]
    static Options := "C"
}
struct MI_QualifierSetFT {
    GetQualifierCount : IntPtr
    GetQualifierAt : IntPtr
    GetQualifier : IntPtr
}
struct MI_QualifierSet {
    reserved1 : Int64
    reserved2 : IntPtr
    ft : MI_QualifierSetFT.Ptr
}
struct MI_ParameterSetFT {
    GetMethodReturnType : IntPtr
    GetParameterCount : IntPtr
    GetParameterAt : IntPtr
    GetParameter : IntPtr
}
struct MI_ParameterSet {
    reserved1 : Int64
    reserved2 : IntPtr
    ft : MI_ParameterSetFT.Ptr
}
struct MI_ClassFT {
    GetClassNameA : IntPtr
    GetNameSpace : IntPtr
    GetServerName : IntPtr
    GetElementCount : IntPtr
    GetElement : IntPtr
    GetElementAt : IntPtr
    GetClassQualifierSet : IntPtr
    GetMethodCount : IntPtr
    GetMethodAt : IntPtr
    GetMethod : IntPtr
    GetParentClassName : IntPtr
    GetParentClass : IntPtr
    Delete : IntPtr
    Clone : IntPtr
}
struct MI_Class {
    ft : MI_ClassFT.Ptr
    classDecl : MI_ClassDecl.Ptr
    namespaceName : UInt16.Ptr
    serverName : UInt16.Ptr
    reserved : IntPtr[4]
}
struct MI_OperationCallback_ResponseType extends Int32 {
    static MI_OperationCallback_ResponseType_No := 0
    static MI_OperationCallback_ResponseType_Yes := 1
    static MI_OperationCallback_ResponseType_NoToAll := 2
    static MI_OperationCallback_ResponseType_YesToAll := 3
}
struct MI_OperationCallback_PromptUser extends FunctionPointer {
    static Types := [MI_Operation.Ptr, Struct.Ptr, UInt16.Ptr, MI_PromptType, IntPtr, "Void"]
}
struct MI_OperationCallback_WriteError extends FunctionPointer {
    static Types := [MI_Operation.Ptr, Struct.Ptr, MI_Instance.Ptr, IntPtr, "Void"]
}
struct MI_OperationCallback_WriteMessage extends FunctionPointer {
    static Types := [MI_Operation.Ptr, Struct.Ptr, UInt32, UInt16.Ptr, "Void"]
}
struct MI_OperationCallback_WriteProgress extends FunctionPointer {
    static Types := [MI_Operation.Ptr, Struct.Ptr, UInt16.Ptr, UInt16.Ptr, UInt16.Ptr, UInt32, UInt32, "Void"]
}
struct MI_OperationCallback_Instance extends FunctionPointer {
    static Types := [MI_Operation.Ptr, Struct.Ptr, MI_Instance.Ptr, UInt8, MI_Result, UInt16.Ptr, MI_Instance.Ptr, IntPtr, "Void"]
}
struct MI_OperationCallback_StreamedParameter extends FunctionPointer {
    static Types := [MI_Operation.Ptr, Struct.Ptr, UInt16.Ptr, MI_Type, MI_Value.Ptr, IntPtr, "Void"]
}
struct MI_OperationCallback_Indication extends FunctionPointer {
    static Types := [MI_Operation.Ptr, Struct.Ptr, MI_Instance.Ptr, UInt16.Ptr, UInt16.Ptr, UInt8, MI_Result, UInt16.Ptr, MI_Instance.Ptr, IntPtr, "Void"]
}
struct MI_OperationCallback_Class extends FunctionPointer {
    static Types := [MI_Operation.Ptr, Struct.Ptr, MI_Class.Ptr, UInt8, MI_Result, UInt16.Ptr, MI_Instance.Ptr, IntPtr, "Void"]
}
struct MI_OperationCallbacks {
    callbackContext : Struct.Ptr
    promptUser : MI_OperationCallback_PromptUser
    writeError : MI_OperationCallback_WriteError
    writeMessage : MI_OperationCallback_WriteMessage
    writeProgress : MI_OperationCallback_WriteProgress
    instanceResult : MI_OperationCallback_Instance
    indicationResult : MI_OperationCallback_Indication
    classResult : MI_OperationCallback_Class
    streamedParameterResult : MI_OperationCallback_StreamedParameter
}
struct MI_SessionCallbacks {
    callbackContext : Struct.Ptr
    writeMessage : IntPtr
    writeError : IntPtr
}
struct MI_UsernamePasswordCreds {
    domain : UInt16.Ptr
    username : UInt16.Ptr
    password : UInt16.Ptr
}
struct MI_UserCredentials {
    authenticationType : UInt16.Ptr
    credentials : this._credentials_e__Union
    struct _credentials_e__Union {
        union {
            usernamePassword : MI_UsernamePasswordCreds
            certificateThumbprint : UInt16.Ptr
        }
    }
}
struct MI_SubscriptionDeliveryType extends Int32 {
    static MI_SubscriptionDeliveryType_Pull := 1
    static MI_SubscriptionDeliveryType_Push := 2
}
struct MI_SubscriptionDeliveryOptionsFT {
    SetString : IntPtr
    SetNumber : IntPtr
    SetDateTime : IntPtr
    SetInterval : IntPtr
    AddCredentials : IntPtr
    Delete : IntPtr
    GetString : IntPtr
    GetNumber : IntPtr
    GetDateTime : IntPtr
    GetInterval : IntPtr
    GetOptionCount : IntPtr
    GetOptionAt : IntPtr
    GetOption : IntPtr
    GetCredentialsCount : IntPtr
    GetCredentialsAt : IntPtr
    GetCredentialsPasswordAt : IntPtr
    Clone : IntPtr
}
struct MI_SubscriptionDeliveryOptions {
    reserved1 : Int64
    reserved2 : IntPtr
    ft : MI_SubscriptionDeliveryOptionsFT.Ptr
}
struct MI_Serializer {
    reserved1 : Int64
    reserved2 : IntPtr
}
struct MI_Deserializer {
    reserved1 : Int64
    reserved2 : IntPtr
}
struct MI_SerializerFT {
    Close : IntPtr
    SerializeClass : IntPtr
    SerializeInstance : IntPtr
}
struct MI_Deserializer_ClassObjectNeeded extends FunctionPointer {
    static Types := [Struct.Ptr, UInt16.Ptr, UInt16.Ptr, UInt16.Ptr, MI_Class.Ptr.Ptr, MI_Result]
}
struct MI_DeserializerFT {
    Close : IntPtr
    DeserializeClass : IntPtr
    Class_GetClassName : IntPtr
    Class_GetParentClassName : IntPtr
    DeserializeInstance : IntPtr
    Instance_GetClassName : IntPtr
}
struct MI_ApplicationFT {
    Close : IntPtr
    NewSession : IntPtr
    NewHostedProvider : IntPtr
    NewInstance : IntPtr
    NewDestinationOptions : IntPtr
    NewOperationOptions : IntPtr
    NewSubscriptionDeliveryOptions : IntPtr
    NewSerializer : IntPtr
    NewDeserializer : IntPtr
    NewInstanceFromClass : IntPtr
    NewClass : IntPtr
}
struct MI_HostedProviderFT {
    Close : IntPtr
    GetApplication : IntPtr
}
struct MI_SessionFT {
    Close : IntPtr
    GetApplication : IntPtr
    GetInstance : IntPtr
    ModifyInstance : IntPtr
    CreateInstance : IntPtr
    DeleteInstance : IntPtr
    Invoke : IntPtr
    EnumerateInstances : IntPtr
    QueryInstances : IntPtr
    AssociatorInstances : IntPtr
    ReferenceInstances : IntPtr
    Subscribe : IntPtr
    GetClass : IntPtr
    EnumerateClasses : IntPtr
    TestConnection : IntPtr
}
struct MI_OperationFT {
    Close : IntPtr
    Cancel : IntPtr
    GetSession : IntPtr
    GetInstance : IntPtr
    GetIndication : IntPtr
    GetClass : IntPtr
}
struct MI_DestinationOptionsFT {
    Delete : IntPtr
    SetString : IntPtr
    SetNumber : IntPtr
    AddCredentials : IntPtr
    GetString : IntPtr
    GetNumber : IntPtr
    GetOptionCount : IntPtr
    GetOptionAt : IntPtr
    GetOption : IntPtr
    GetCredentialsCount : IntPtr
    GetCredentialsAt : IntPtr
    GetCredentialsPasswordAt : IntPtr
    Clone : IntPtr
    SetInterval : IntPtr
    GetInterval : IntPtr
}
struct MI_OperationOptionsFT {
    Delete : IntPtr
    SetString : IntPtr
    SetNumber : IntPtr
    SetCustomOption : IntPtr
    GetString : IntPtr
    GetNumber : IntPtr
    GetOptionCount : IntPtr
    GetOptionAt : IntPtr
    GetOption : IntPtr
    GetEnabledChannels : IntPtr
    Clone : IntPtr
    SetInterval : IntPtr
    GetInterval : IntPtr
}
struct MI_Application {
    reserved1 : Int64
    reserved2 : IntPtr
    ft : MI_ApplicationFT.Ptr
}
struct MI_Session {
    reserved1 : Int64
    reserved2 : IntPtr
    ft : MI_SessionFT.Ptr
}
struct MI_Operation {
    reserved1 : Int64
    reserved2 : IntPtr
    ft : MI_OperationFT.Ptr
}
struct MI_HostedProvider {
    reserved1 : Int64
    reserved2 : IntPtr
    ft : MI_HostedProviderFT.Ptr
}
struct MI_DestinationOptions {
    reserved1 : Int64
    reserved2 : IntPtr
    ft : MI_DestinationOptionsFT.Ptr
}
struct MI_OperationOptions {
    reserved1 : Int64
    reserved2 : IntPtr
    ft : MI_OperationOptionsFT.Ptr
}
struct MI_UtilitiesFT {
    MapErrorToMiErrorCategory : IntPtr
    CimErrorFromErrorCode : IntPtr
}
struct MI_ClientFT_V1 {
    applicationFT : MI_ApplicationFT.Ptr
    sessionFT : MI_SessionFT.Ptr
    operationFT : MI_OperationFT.Ptr
    hostedProviderFT : MI_HostedProviderFT.Ptr
    serializerFT : MI_SerializerFT.Ptr
    deserializerFT : MI_DeserializerFT.Ptr
    subscribeDeliveryOptionsFT : MI_SubscriptionDeliveryOptionsFT.Ptr
    destinationOptionsFT : MI_DestinationOptionsFT.Ptr
    operationOptionsFT : MI_OperationOptionsFT.Ptr
    utilitiesFT : MI_UtilitiesFT.Ptr
}
struct MI_DestinationOptions_ImpersonationType extends Int32 {
    static MI_DestinationOptions_ImpersonationType_Default := 0
    static MI_DestinationOptions_ImpersonationType_None := 1
    static MI_DestinationOptions_ImpersonationType_Identify := 2
    static MI_DestinationOptions_ImpersonationType_Impersonate := 3
    static MI_DestinationOptions_ImpersonationType_Delegate := 4
}
struct WBEM_PATH_STATUS_FLAG extends Int32 {
    static WBEMPATH_INFO_ANON_LOCAL_MACHINE := 1
    static WBEMPATH_INFO_HAS_MACHINE_NAME := 2
    static WBEMPATH_INFO_IS_CLASS_REF := 4
    static WBEMPATH_INFO_IS_INST_REF := 8
    static WBEMPATH_INFO_HAS_SUBSCOPES := 16
    static WBEMPATH_INFO_IS_COMPOUND := 32
    static WBEMPATH_INFO_HAS_V2_REF_PATHS := 64
    static WBEMPATH_INFO_HAS_IMPLIED_KEY := 128
    static WBEMPATH_INFO_CONTAINS_SINGLETON := 256
    static WBEMPATH_INFO_V1_COMPLIANT := 512
    static WBEMPATH_INFO_V2_COMPLIANT := 1024
    static WBEMPATH_INFO_CIM_COMPLIANT := 2048
    static WBEMPATH_INFO_IS_SINGLETON := 4096
    static WBEMPATH_INFO_IS_PARENT := 8192
    static WBEMPATH_INFO_SERVER_NAMESPACE_ONLY := 16384
    static WBEMPATH_INFO_NATIVE_PATH := 32768
    static WBEMPATH_INFO_WMI_PATH := 65536
    static WBEMPATH_INFO_PATH_HAD_SERVER := 131072
}
struct WBEM_PATH_CREATE_FLAG extends Int32 {
    static WBEMPATH_CREATE_ACCEPT_RELATIVE := 1
    static WBEMPATH_CREATE_ACCEPT_ABSOLUTE := 2
    static WBEMPATH_CREATE_ACCEPT_ALL := 4
    static WBEMPATH_TREAT_SINGLE_IDENT_AS_NS := 8
}
struct WBEM_GET_TEXT_FLAGS extends Int32 {
    static WBEMPATH_COMPRESSED := 1
    static WBEMPATH_GET_RELATIVE_ONLY := 2
    static WBEMPATH_GET_SERVER_TOO := 4
    static WBEMPATH_GET_SERVER_AND_NAMESPACE_ONLY := 8
    static WBEMPATH_GET_NAMESPACE_ONLY := 16
    static WBEMPATH_GET_ORIGINAL := 32
}
struct WBEM_GET_KEY_FLAGS extends Int32 {
    static WBEMPATH_TEXT := 1
    static WBEMPATH_QUOTEDTEXT := 2
}
struct IWbemPathKeyList extends IUnknown {
    static IID := "{9AE62877-7544-4BB0-AA26-A13824659ED6}"
    GetCount(puKeyCount)
      => ComCall(3, this.p, UInt32.Ptr, puKeyCount)
    SetKey(wszName, uFlags, uCimType, pKeyVal)
      => ComCall(4, this.p, "Str", wszName, UInt32, uFlags, UInt32, uCimType, Struct.Ptr, pKeyVal)
    SetKey2(wszName, uFlags, uCimType, pKeyVal)
      => ComCall(5, this.p, "Str", wszName, UInt32, uFlags, UInt32, uCimType, VARIANT.Ptr, pKeyVal)
    GetKey(uKeyIx, uFlags, pszKeyName?, puKeyValBufSize, pKeyVal, puApparentCimType)
      => ComCall(6, this.p, UInt32, uKeyIx, UInt32, uFlags, UInt32.Ptr, pszKeyName?.Length ?? 0, PWSTR, pszKeyName?, UInt32.Ptr, puKeyValBufSize, Struct.Ptr, pKeyVal, UInt32.Ptr, puApparentCimType)
    GetKey2(uKeyIx, uFlags, pszKeyName?, pKeyValue, puApparentCimType)
      => ComCall(7, this.p, UInt32, uKeyIx, UInt32, uFlags, UInt32.Ptr, pszKeyName?.Length ?? 0, PWSTR, pszKeyName?, VARIANT.Ptr, pKeyValue, UInt32.Ptr, puApparentCimType)
    RemoveKey(wszName, uFlags)
      => ComCall(8, this.p, "Str", wszName, UInt32, uFlags)
    RemoveAllKeys(uFlags)
      => ComCall(9, this.p, UInt32, uFlags)
    MakeSingleton(bSet)
      => ComCall(10, this.p, UInt8, bSet)
    GetInfo(uRequestedInfo, puResponse)
      => ComCall(11, this.p, UInt32, uRequestedInfo, Int64.Ptr, puResponse)
    GetText(lFlags, pszText)
      => ComCall(12, this.p, Int32, lFlags, UInt32.Ptr, pszText.Length, PWSTR, pszText)
}
struct IWbemPath extends IUnknown {
    static IID := "{3BC15AF2-736C-477E-9E51-238AF8667DCC}"
    SetText(uMode, pszPath)
      => ComCall(3, this.p, UInt32, uMode, "Str", pszPath)
    GetText(lFlags, pszText)
      => ComCall(4, this.p, Int32, lFlags, UInt32.Ptr, pszText.Length, PWSTR, pszText)
    GetInfo(uRequestedInfo, puResponse)
      => ComCall(5, this.p, UInt32, uRequestedInfo, Int64.Ptr, puResponse)
    SetServer(Name)
      => ComCall(6, this.p, "Str", Name)
    GetServer(pName)
      => ComCall(7, this.p, UInt32.Ptr, pName.Length, PWSTR, pName)
    GetNamespaceCount(puCount)
      => ComCall(8, this.p, UInt32.Ptr, puCount)
    SetNamespaceAt(uIndex, pszName)
      => ComCall(9, this.p, UInt32, uIndex, "Str", pszName)
    GetNamespaceAt(uIndex, pName)
      => ComCall(10, this.p, UInt32, uIndex, UInt32.Ptr, pName.Length, PWSTR, pName)
    RemoveNamespaceAt(uIndex)
      => ComCall(11, this.p, UInt32, uIndex)
    RemoveAllNamespaces()
      => ComCall(12, this.p)
    GetScopeCount(puCount)
      => ComCall(13, this.p, UInt32.Ptr, puCount)
    SetScope(uIndex, pszClass)
      => ComCall(14, this.p, UInt32, uIndex, "Str", pszClass)
    SetScopeFromText(uIndex, pszText)
      => ComCall(15, this.p, UInt32, uIndex, "Str", pszText)
    GetScope(uIndex, pszClass, pKeyList)
      => ComCall(16, this.p, UInt32, uIndex, UInt32.Ptr, pszClass.Length, PWSTR, pszClass, IWbemPathKeyList.Ptr, pKeyList)
    GetScopeAsText(uIndex, pszText)
      => ComCall(17, this.p, UInt32, uIndex, UInt32.Ptr, pszText.Length, PWSTR, pszText)
    RemoveScope(uIndex)
      => ComCall(18, this.p, UInt32, uIndex)
    RemoveAllScopes()
      => ComCall(19, this.p)
    SetClassName(Name)
      => ComCall(20, this.p, "Str", Name)
    GetClassName(pszName?)
      => ComCall(21, this.p, UInt32.Ptr, pszName?.Length ?? 0, PWSTR, pszName?)
    GetKeyList(pOut)
      => ComCall(22, this.p, IWbemPathKeyList.Ptr, pOut)
    CreateClassPart(lFlags, Name)
      => ComCall(23, this.p, Int32, lFlags, "Str", Name)
    DeleteClassPart(lFlags)
      => ComCall(24, this.p, Int32, lFlags)
    IsRelative(wszMachine, wszNamespace)
      => ComCall(25, this.p, "Str", wszMachine, "Str", wszNamespace, BOOL)
    IsRelativeOrChild(wszMachine, wszNamespace, lFlags)
      => ComCall(26, this.p, "Str", wszMachine, "Str", wszNamespace, Int32, lFlags, BOOL)
    IsLocal(wszMachine)
      => ComCall(27, this.p, "Str", wszMachine, BOOL)
    IsSameClassName(wszClass)
      => ComCall(28, this.p, "Str", wszClass, BOOL)
}
struct IWbemQuery extends IUnknown {
    static IID := "{81166F58-DD98-11D3-A120-00105A1F515A}"
    Empty()
      => ComCall(3, this.p)
    SetLanguageFeatures(uFlags, uArraySize, puFeatures)
      => ComCall(4, this.p, UInt32, uFlags, UInt32, uArraySize, UInt32.Ptr, puFeatures)
    TestLanguageFeatures(uFlags, uArraySize, puFeatures)
      => ComCall(5, this.p, UInt32, uFlags, UInt32.Ptr, uArraySize, UInt32.Ptr, puFeatures)
    Parse(pszLang, pszQuery, uFlags)
      => ComCall(6, this.p, "Str", pszLang, "Str", pszQuery, UInt32, uFlags)
    GetAnalysis(uAnalysisType, uFlags, pAnalysis)
      => ComCall(7, this.p, UInt32, uAnalysisType, UInt32, uFlags, Struct.Ptr.Ptr, pAnalysis)
    FreeMemory(pMem)
      => ComCall(8, this.p, Struct.Ptr, pMem)
    GetQueryInfo(uAnalysisType, uInfoId, uBufSize, pDestBuf)
      => ComCall(9, this.p, UInt32, uAnalysisType, UInt32, uInfoId, UInt32, uBufSize, Struct.Ptr, pDestBuf)
}
struct WMIQ_ANALYSIS_TYPE extends Int32 {
    static WMIQ_ANALYSIS_RPN_SEQUENCE := 1
    static WMIQ_ANALYSIS_ASSOC_QUERY := 2
    static WMIQ_ANALYSIS_PROP_ANALYSIS_MATRIX := 3
    static WMIQ_ANALYSIS_QUERY_TEXT := 4
    static WMIQ_ANALYSIS_RESERVED := 134217728
}
struct WMIQ_RPN_TOKEN_FLAGS extends Int32 {
    static WMIQ_RPN_TOKEN_EXPRESSION := 1
    static WMIQ_RPN_TOKEN_AND := 2
    static WMIQ_RPN_TOKEN_OR := 3
    static WMIQ_RPN_TOKEN_NOT := 4
    static WMIQ_RPN_OP_UNDEFINED := 0
    static WMIQ_RPN_OP_EQ := 1
    static WMIQ_RPN_OP_NE := 2
    static WMIQ_RPN_OP_GE := 3
    static WMIQ_RPN_OP_LE := 4
    static WMIQ_RPN_OP_LT := 5
    static WMIQ_RPN_OP_GT := 6
    static WMIQ_RPN_OP_LIKE := 7
    static WMIQ_RPN_OP_ISA := 8
    static WMIQ_RPN_OP_ISNOTA := 9
    static WMIQ_RPN_OP_ISNULL := 10
    static WMIQ_RPN_OP_ISNOTNULL := 11
    static WMIQ_RPN_LEFT_PROPERTY_NAME := 1
    static WMIQ_RPN_RIGHT_PROPERTY_NAME := 2
    static WMIQ_RPN_CONST2 := 4
    static WMIQ_RPN_CONST := 8
    static WMIQ_RPN_RELOP := 16
    static WMIQ_RPN_LEFT_FUNCTION := 32
    static WMIQ_RPN_RIGHT_FUNCTION := 64
    static WMIQ_RPN_GET_TOKEN_TYPE := 1
    static WMIQ_RPN_GET_EXPR_SHAPE := 2
    static WMIQ_RPN_GET_LEFT_FUNCTION := 3
    static WMIQ_RPN_GET_RIGHT_FUNCTION := 4
    static WMIQ_RPN_GET_RELOP := 5
    static WMIQ_RPN_NEXT_TOKEN := 1
    static WMIQ_RPN_FROM_UNARY := 1
    static WMIQ_RPN_FROM_PATH := 2
    static WMIQ_RPN_FROM_CLASS_LIST := 4
    static WMIQ_RPN_FROM_MULTIPLE := 8
}
struct WMIQ_ASSOCQ_FLAGS extends Int32 {
    static WMIQ_ASSOCQ_ASSOCIATORS := 1
    static WMIQ_ASSOCQ_REFERENCES := 2
    static WMIQ_ASSOCQ_RESULTCLASS := 4
    static WMIQ_ASSOCQ_ASSOCCLASS := 8
    static WMIQ_ASSOCQ_ROLE := 16
    static WMIQ_ASSOCQ_RESULTROLE := 32
    static WMIQ_ASSOCQ_REQUIREDQUALIFIER := 64
    static WMIQ_ASSOCQ_REQUIREDASSOCQUALIFIER := 128
    static WMIQ_ASSOCQ_CLASSDEFSONLY := 256
    static WMIQ_ASSOCQ_KEYSONLY := 512
    static WMIQ_ASSOCQ_SCHEMAONLY := 1024
    static WMIQ_ASSOCQ_CLASSREFSONLY := 2048
}
struct SWbemQueryQualifiedName {
    m_uVersion : UInt32
    m_uTokenType : UInt32
    m_uNameListSize : UInt32
    m_ppszNameList : PWSTR.Ptr
    m_bArraysUsed : BOOL
    m_pbArrayElUsed : BOOL.Ptr
    m_puArrayIndex : UInt32.Ptr
}
struct SWbemRpnConst {
    union {
        m_pszStrVal : PWSTR
        m_bBoolVal : BOOL
        m_lLongVal : Int32
        m_uLongVal : UInt32
        m_dblVal : Float64
        m_lVal64 : Int64
        m_uVal64 : Int64
    }
}
struct SWbemRpnQueryToken {
    m_uVersion : UInt32
    m_uTokenType : UInt32
    m_uSubexpressionShape : UInt32
    m_uOperator : UInt32
    m_pRightIdent : SWbemQueryQualifiedName.Ptr
    m_pLeftIdent : SWbemQueryQualifiedName.Ptr
    m_uConstApparentType : UInt32
    m_Const : SWbemRpnConst
    m_uConst2ApparentType : UInt32
    m_Const2 : SWbemRpnConst
    m_pszRightFunc : PWSTR
    m_pszLeftFunc : PWSTR
}
struct SWbemRpnTokenList {
    m_uVersion : UInt32
    m_uTokenType : UInt32
    m_uNumTokens : UInt32
}
struct WMIQ_LANGUAGE_FEATURES extends Int32 {
    static WMIQ_LF1_BASIC_SELECT := 1
    static WMIQ_LF2_CLASS_NAME_IN_QUERY := 2
    static WMIQ_LF3_STRING_CASE_FUNCTIONS := 3
    static WMIQ_LF4_PROP_TO_PROP_TESTS := 4
    static WMIQ_LF5_COUNT_STAR := 5
    static WMIQ_LF6_ORDER_BY := 6
    static WMIQ_LF7_DISTINCT := 7
    static WMIQ_LF8_ISA := 8
    static WMIQ_LF9_THIS := 9
    static WMIQ_LF10_COMPEX_SUBEXPRESSIONS := 10
    static WMIQ_LF11_ALIASING := 11
    static WMIQ_LF12_GROUP_BY_HAVING := 12
    static WMIQ_LF13_WMI_WITHIN := 13
    static WMIQ_LF14_SQL_WRITE_OPERATIONS := 14
    static WMIQ_LF15_GO := 15
    static WMIQ_LF16_SINGLE_LEVEL_TRANSACTIONS := 16
    static WMIQ_LF17_QUALIFIED_NAMES := 17
    static WMIQ_LF18_ASSOCIATONS := 18
    static WMIQ_LF19_SYSTEM_PROPERTIES := 19
    static WMIQ_LF20_EXTENDED_SYSTEM_PROPERTIES := 20
    static WMIQ_LF21_SQL89_JOINS := 21
    static WMIQ_LF22_SQL92_JOINS := 22
    static WMIQ_LF23_SUBSELECTS := 23
    static WMIQ_LF24_UMI_EXTENSIONS := 24
    static WMIQ_LF25_DATEPART := 25
    static WMIQ_LF26_LIKE := 26
    static WMIQ_LF27_CIM_TEMPORAL_CONSTRUCTS := 27
    static WMIQ_LF28_STANDARD_AGGREGATES := 28
    static WMIQ_LF29_MULTI_LEVEL_ORDER_BY := 29
    static WMIQ_LF30_WMI_PRAGMAS := 30
    static WMIQ_LF31_QUALIFIER_TESTS := 31
    static WMIQ_LF32_SP_EXECUTE := 32
    static WMIQ_LF33_ARRAY_ACCESS := 33
    static WMIQ_LF34_UNION := 34
    static WMIQ_LF35_COMPLEX_SELECT_TARGET := 35
    static WMIQ_LF36_REFERENCE_TESTS := 36
    static WMIQ_LF37_SELECT_INTO := 37
    static WMIQ_LF38_BASIC_DATETIME_TESTS := 38
    static WMIQ_LF39_COUNT_COLUMN := 39
    static WMIQ_LF40_BETWEEN := 40
    static WMIQ_LF_LAST := 40
}
struct WMIQ_RPNF_FEATURE extends Int32 {
    static WMIQ_RPNF_WHERE_CLAUSE_PRESENT := 1
    static WMIQ_RPNF_QUERY_IS_CONJUNCTIVE := 2
    static WMIQ_RPNF_QUERY_IS_DISJUNCTIVE := 4
    static WMIQ_RPNF_PROJECTION := 8
    static WMIQ_RPNF_FEATURE_SELECT_STAR := 16
    static WMIQ_RPNF_EQUALITY_TESTS_ONLY := 32
    static WMIQ_RPNF_COUNT_STAR := 64
    static WMIQ_RPNF_QUALIFIED_NAMES_USED := 128
    static WMIQ_RPNF_SYSPROP_CLASS_USED := 256
    static WMIQ_RPNF_PROP_TO_PROP_TESTS := 512
    static WMIQ_RPNF_ORDER_BY := 1024
    static WMIQ_RPNF_ISA_USED := 2048
    static WMIQ_RPNF_GROUP_BY_HAVING := 4096
    static WMIQ_RPNF_ARRAY_ACCESS_USED := 8192
}
struct SWbemRpnEncodedQuery {
    m_uVersion : UInt32
    m_uTokenType : UInt32
    m_uParsedFeatureMask : Int64
    m_uDetectedArraySize : UInt32
    m_puDetectedFeatures : UInt32.Ptr
    m_uSelectListSize : UInt32
    m_ppSelectList : SWbemQueryQualifiedName.Ptr.Ptr
    m_uFromTargetType : UInt32
    m_pszOptionalFromPath : PWSTR
    m_uFromListSize : UInt32
    m_ppszFromList : PWSTR.Ptr
    m_uWhereClauseSize : UInt32
    m_ppRpnWhereClause : SWbemRpnQueryToken.Ptr.Ptr
    m_dblWithinPolling : Float64
    m_dblWithinWindow : Float64
    m_uOrderByListSize : UInt32
    m_ppszOrderByList : PWSTR.Ptr
    m_uOrderDirectionEl : UInt32.Ptr
}
struct SWbemAnalysisMatrix {
    m_uVersion : UInt32
    m_uMatrixType : UInt32
    m_pszProperty : PWSTR
    m_uPropertyType : UInt32
    m_uEntries : UInt32
    m_pValues : Struct.Ptr.Ptr
    m_pbTruthTable : BOOL.Ptr
}
struct SWbemAnalysisMatrixList {
    m_uVersion : UInt32
    m_uMatrixType : UInt32
    m_uNumMatrices : UInt32
    m_pMatrices : SWbemAnalysisMatrix.Ptr
}
struct SWbemAssocQueryInf {
    m_uVersion : UInt32
    m_uAnalysisType : UInt32
    m_uFeatureMask : UInt32
    m_pPath : IWbemPath
    m_pszPath : PWSTR
    m_pszQueryText : PWSTR
    m_pszResultClass : PWSTR
    m_pszAssocClass : PWSTR
    m_pszRole : PWSTR
    m_pszResultRole : PWSTR
    m_pszRequiredQualifier : PWSTR
    m_pszRequiredAssocQualifier : PWSTR
}
struct WBEM_GENUS_TYPE extends Int32 {
    static WBEM_GENUS_CLASS := 1
    static WBEM_GENUS_INSTANCE := 2
}
struct WBEM_CHANGE_FLAG_TYPE extends Int32 {
    static WBEM_FLAG_CREATE_OR_UPDATE := 0
    static WBEM_FLAG_UPDATE_ONLY := 1
    static WBEM_FLAG_CREATE_ONLY := 2
    static WBEM_FLAG_UPDATE_COMPATIBLE := 0
    static WBEM_FLAG_UPDATE_SAFE_MODE := 32
    static WBEM_FLAG_UPDATE_FORCE_MODE := 64
    static WBEM_MASK_UPDATE_MODE := 96
    static WBEM_FLAG_ADVISORY := 65536
}
struct WBEM_GENERIC_FLAG_TYPE extends Int32 {
    static WBEM_FLAG_RETURN_IMMEDIATELY := 16
    static WBEM_FLAG_RETURN_WBEM_COMPLETE := 0
    static WBEM_FLAG_BIDIRECTIONAL := 0
    static WBEM_FLAG_FORWARD_ONLY := 32
    static WBEM_FLAG_NO_ERROR_OBJECT := 64
    static WBEM_FLAG_RETURN_ERROR_OBJECT := 0
    static WBEM_FLAG_SEND_STATUS := 128
    static WBEM_FLAG_DONT_SEND_STATUS := 0
    static WBEM_FLAG_ENSURE_LOCATABLE := 256
    static WBEM_FLAG_DIRECT_READ := 512
    static WBEM_FLAG_SEND_ONLY_SELECTED := 0
    static WBEM_RETURN_WHEN_COMPLETE := 0
    static WBEM_RETURN_IMMEDIATELY := 16
    static WBEM_MASK_RESERVED_FLAGS := 126976
    static WBEM_FLAG_USE_AMENDED_QUALIFIERS := 131072
    static WBEM_FLAG_STRONG_VALIDATION := 1048576
}
struct WBEM_STATUS_TYPE extends Int32 {
    static WBEM_STATUS_COMPLETE := 0
    static WBEM_STATUS_REQUIREMENTS := 1
    static WBEM_STATUS_PROGRESS := 2
    static WBEM_STATUS_LOGGING_INFORMATION := 256
    static WBEM_STATUS_LOGGING_INFORMATION_PROVIDER := 512
    static WBEM_STATUS_LOGGING_INFORMATION_HOST := 1024
    static WBEM_STATUS_LOGGING_INFORMATION_REPOSITORY := 2048
    static WBEM_STATUS_LOGGING_INFORMATION_ESS := 4096
}
struct WBEM_CONDITION_FLAG_TYPE extends Int32 {
    static WBEM_FLAG_ALWAYS := 0
    static WBEM_FLAG_ONLY_IF_TRUE := 1
    static WBEM_FLAG_ONLY_IF_FALSE := 2
    static WBEM_FLAG_ONLY_IF_IDENTICAL := 3
    static WBEM_MASK_PRIMARY_CONDITION := 3
    static WBEM_FLAG_KEYS_ONLY := 4
    static WBEM_FLAG_REFS_ONLY := 8
    static WBEM_FLAG_LOCAL_ONLY := 16
    static WBEM_FLAG_PROPAGATED_ONLY := 32
    static WBEM_FLAG_SYSTEM_ONLY := 48
    static WBEM_FLAG_NONSYSTEM_ONLY := 64
    static WBEM_MASK_CONDITION_ORIGIN := 112
    static WBEM_FLAG_CLASS_OVERRIDES_ONLY := 256
    static WBEM_FLAG_CLASS_LOCAL_AND_OVERRIDES := 512
    static WBEM_MASK_CLASS_CONDITION := 768
}
struct WBEM_FLAVOR_TYPE extends Int32 {
    static WBEM_FLAVOR_DONT_PROPAGATE := 0
    static WBEM_FLAVOR_FLAG_PROPAGATE_TO_INSTANCE := 1
    static WBEM_FLAVOR_FLAG_PROPAGATE_TO_DERIVED_CLASS := 2
    static WBEM_FLAVOR_MASK_PROPAGATION := 15
    static WBEM_FLAVOR_OVERRIDABLE := 0
    static WBEM_FLAVOR_NOT_OVERRIDABLE := 16
    static WBEM_FLAVOR_MASK_PERMISSIONS := 16
    static WBEM_FLAVOR_ORIGIN_LOCAL := 0
    static WBEM_FLAVOR_ORIGIN_PROPAGATED := 32
    static WBEM_FLAVOR_ORIGIN_SYSTEM := 64
    static WBEM_FLAVOR_MASK_ORIGIN := 96
    static WBEM_FLAVOR_NOT_AMENDED := 0
    static WBEM_FLAVOR_AMENDED := 128
    static WBEM_FLAVOR_MASK_AMENDED := 128
}
struct WBEM_QUERY_FLAG_TYPE extends Int32 {
    static WBEM_FLAG_DEEP := 0
    static WBEM_FLAG_SHALLOW := 1
    static WBEM_FLAG_PROTOTYPE := 2
}
struct WBEM_SECURITY_FLAGS extends Int32 {
    static WBEM_ENABLE := 1
    static WBEM_METHOD_EXECUTE := 2
    static WBEM_FULL_WRITE_REP := 4
    static WBEM_PARTIAL_WRITE_REP := 8
    static WBEM_WRITE_PROVIDER := 16
    static WBEM_REMOTE_ACCESS := 32
    static WBEM_RIGHT_SUBSCRIBE := 64
    static WBEM_RIGHT_PUBLISH := 128
}
struct WBEM_LIMITATION_FLAG_TYPE extends Int32 {
    static WBEM_FLAG_EXCLUDE_OBJECT_QUALIFIERS := 16
    static WBEM_FLAG_EXCLUDE_PROPERTY_QUALIFIERS := 32
}
struct WBEM_TEXT_FLAG_TYPE extends Int32 {
    static WBEM_FLAG_NO_FLAVORS := 1
}
struct WBEM_COMPARISON_FLAG extends Int32 {
    static WBEM_COMPARISON_INCLUDE_ALL := 0
    static WBEM_FLAG_IGNORE_QUALIFIERS := 1
    static WBEM_FLAG_IGNORE_OBJECT_SOURCE := 2
    static WBEM_FLAG_IGNORE_DEFAULT_VALUES := 4
    static WBEM_FLAG_IGNORE_CLASS := 8
    static WBEM_FLAG_IGNORE_CASE := 16
    static WBEM_FLAG_IGNORE_FLAVOR := 32
}
struct WBEM_LOCKING_FLAG_TYPE extends Int32 {
    static WBEM_FLAG_ALLOW_READ := 1
}
struct CIMTYPE_ENUMERATION extends Int32 {
    static CIM_ILLEGAL := 4095
    static CIM_EMPTY := 0
    static CIM_SINT8 := 16
    static CIM_UINT8 := 17
    static CIM_SINT16 := 2
    static CIM_UINT16 := 18
    static CIM_SINT32 := 3
    static CIM_UINT32 := 19
    static CIM_SINT64 := 20
    static CIM_UINT64 := 21
    static CIM_REAL32 := 4
    static CIM_REAL64 := 5
    static CIM_BOOLEAN := 11
    static CIM_STRING := 8
    static CIM_DATETIME := 101
    static CIM_REFERENCE := 102
    static CIM_CHAR16 := 103
    static CIM_OBJECT := 13
    static CIM_FLAG_ARRAY := 8192
}
struct WBEM_BACKUP_RESTORE_FLAGS extends Int32 {
    static WBEM_FLAG_BACKUP_RESTORE_DEFAULT := 0
    static WBEM_FLAG_BACKUP_RESTORE_FORCE_SHUTDOWN := 1
}
struct WBEM_REFRESHER_FLAGS extends Int32 {
    static WBEM_FLAG_REFRESH_AUTO_RECONNECT := 0
    static WBEM_FLAG_REFRESH_NO_AUTO_RECONNECT := 1
}
struct WBEM_SHUTDOWN_FLAGS extends Int32 {
    static WBEM_SHUTDOWN_UNLOAD_COMPONENT := 1
    static WBEM_SHUTDOWN_WMI := 2
    static WBEM_SHUTDOWN_OS := 3
}
struct WBEMSTATUS_FORMAT extends Int32 {
    static WBEMSTATUS_FORMAT_NEWLINE := 0
    static WBEMSTATUS_FORMAT_NO_NEWLINE := 1
}
struct WBEM_LIMITS extends Int32 {
    static WBEM_MAX_IDENTIFIER := 4096
    static WBEM_MAX_QUERY := 16384
    static WBEM_MAX_PATH := 8192
    static WBEM_MAX_OBJECT_NESTING := 64
    static WBEM_MAX_USER_PROPERTIES := 1024
}
struct WBEMSTATUS extends Int32 {
    static WBEM_NO_ERROR := 0
    static WBEM_S_NO_ERROR := 0
    static WBEM_S_SAME := 0
    static WBEM_S_FALSE := 1
    static WBEM_S_ALREADY_EXISTS := 262145
    static WBEM_S_RESET_TO_DEFAULT := 262146
    static WBEM_S_DIFFERENT := 262147
    static WBEM_S_TIMEDOUT := 262148
    static WBEM_S_NO_MORE_DATA := 262149
    static WBEM_S_OPERATION_CANCELLED := 262150
    static WBEM_S_PENDING := 262151
    static WBEM_S_DUPLICATE_OBJECTS := 262152
    static WBEM_S_ACCESS_DENIED := 262153
    static WBEM_S_PARTIAL_RESULTS := 262160
    static WBEM_S_SOURCE_NOT_AVAILABLE := 262167
    static WBEM_E_FAILED := -2147217407
    static WBEM_E_NOT_FOUND := -2147217406
    static WBEM_E_ACCESS_DENIED := -2147217405
    static WBEM_E_PROVIDER_FAILURE := -2147217404
    static WBEM_E_TYPE_MISMATCH := -2147217403
    static WBEM_E_OUT_OF_MEMORY := -2147217402
    static WBEM_E_INVALID_CONTEXT := -2147217401
    static WBEM_E_INVALID_PARAMETER := -2147217400
    static WBEM_E_NOT_AVAILABLE := -2147217399
    static WBEM_E_CRITICAL_ERROR := -2147217398
    static WBEM_E_INVALID_STREAM := -2147217397
    static WBEM_E_NOT_SUPPORTED := -2147217396
    static WBEM_E_INVALID_SUPERCLASS := -2147217395
    static WBEM_E_INVALID_NAMESPACE := -2147217394
    static WBEM_E_INVALID_OBJECT := -2147217393
    static WBEM_E_INVALID_CLASS := -2147217392
    static WBEM_E_PROVIDER_NOT_FOUND := -2147217391
    static WBEM_E_INVALID_PROVIDER_REGISTRATION := -2147217390
    static WBEM_E_PROVIDER_LOAD_FAILURE := -2147217389
    static WBEM_E_INITIALIZATION_FAILURE := -2147217388
    static WBEM_E_TRANSPORT_FAILURE := -2147217387
    static WBEM_E_INVALID_OPERATION := -2147217386
    static WBEM_E_INVALID_QUERY := -2147217385
    static WBEM_E_INVALID_QUERY_TYPE := -2147217384
    static WBEM_E_ALREADY_EXISTS := -2147217383
    static WBEM_E_OVERRIDE_NOT_ALLOWED := -2147217382
    static WBEM_E_PROPAGATED_QUALIFIER := -2147217381
    static WBEM_E_PROPAGATED_PROPERTY := -2147217380
    static WBEM_E_UNEXPECTED := -2147217379
    static WBEM_E_ILLEGAL_OPERATION := -2147217378
    static WBEM_E_CANNOT_BE_KEY := -2147217377
    static WBEM_E_INCOMPLETE_CLASS := -2147217376
    static WBEM_E_INVALID_SYNTAX := -2147217375
    static WBEM_E_NONDECORATED_OBJECT := -2147217374
    static WBEM_E_READ_ONLY := -2147217373
    static WBEM_E_PROVIDER_NOT_CAPABLE := -2147217372
    static WBEM_E_CLASS_HAS_CHILDREN := -2147217371
    static WBEM_E_CLASS_HAS_INSTANCES := -2147217370
    static WBEM_E_QUERY_NOT_IMPLEMENTED := -2147217369
    static WBEM_E_ILLEGAL_NULL := -2147217368
    static WBEM_E_INVALID_QUALIFIER_TYPE := -2147217367
    static WBEM_E_INVALID_PROPERTY_TYPE := -2147217366
    static WBEM_E_VALUE_OUT_OF_RANGE := -2147217365
    static WBEM_E_CANNOT_BE_SINGLETON := -2147217364
    static WBEM_E_INVALID_CIM_TYPE := -2147217363
    static WBEM_E_INVALID_METHOD := -2147217362
    static WBEM_E_INVALID_METHOD_PARAMETERS := -2147217361
    static WBEM_E_SYSTEM_PROPERTY := -2147217360
    static WBEM_E_INVALID_PROPERTY := -2147217359
    static WBEM_E_CALL_CANCELLED := -2147217358
    static WBEM_E_SHUTTING_DOWN := -2147217357
    static WBEM_E_PROPAGATED_METHOD := -2147217356
    static WBEM_E_UNSUPPORTED_PARAMETER := -2147217355
    static WBEM_E_MISSING_PARAMETER_ID := -2147217354
    static WBEM_E_INVALID_PARAMETER_ID := -2147217353
    static WBEM_E_NONCONSECUTIVE_PARAMETER_IDS := -2147217352
    static WBEM_E_PARAMETER_ID_ON_RETVAL := -2147217351
    static WBEM_E_INVALID_OBJECT_PATH := -2147217350
    static WBEM_E_OUT_OF_DISK_SPACE := -2147217349
    static WBEM_E_BUFFER_TOO_SMALL := -2147217348
    static WBEM_E_UNSUPPORTED_PUT_EXTENSION := -2147217347
    static WBEM_E_UNKNOWN_OBJECT_TYPE := -2147217346
    static WBEM_E_UNKNOWN_PACKET_TYPE := -2147217345
    static WBEM_E_MARSHAL_VERSION_MISMATCH := -2147217344
    static WBEM_E_MARSHAL_INVALID_SIGNATURE := -2147217343
    static WBEM_E_INVALID_QUALIFIER := -2147217342
    static WBEM_E_INVALID_DUPLICATE_PARAMETER := -2147217341
    static WBEM_E_TOO_MUCH_DATA := -2147217340
    static WBEM_E_SERVER_TOO_BUSY := -2147217339
    static WBEM_E_INVALID_FLAVOR := -2147217338
    static WBEM_E_CIRCULAR_REFERENCE := -2147217337
    static WBEM_E_UNSUPPORTED_CLASS_UPDATE := -2147217336
    static WBEM_E_CANNOT_CHANGE_KEY_INHERITANCE := -2147217335
    static WBEM_E_CANNOT_CHANGE_INDEX_INHERITANCE := -2147217328
    static WBEM_E_TOO_MANY_PROPERTIES := -2147217327
    static WBEM_E_UPDATE_TYPE_MISMATCH := -2147217326
    static WBEM_E_UPDATE_OVERRIDE_NOT_ALLOWED := -2147217325
    static WBEM_E_UPDATE_PROPAGATED_METHOD := -2147217324
    static WBEM_E_METHOD_NOT_IMPLEMENTED := -2147217323
    static WBEM_E_METHOD_DISABLED := -2147217322
    static WBEM_E_REFRESHER_BUSY := -2147217321
    static WBEM_E_UNPARSABLE_QUERY := -2147217320
    static WBEM_E_NOT_EVENT_CLASS := -2147217319
    static WBEM_E_MISSING_GROUP_WITHIN := -2147217318
    static WBEM_E_MISSING_AGGREGATION_LIST := -2147217317
    static WBEM_E_PROPERTY_NOT_AN_OBJECT := -2147217316
    static WBEM_E_AGGREGATING_BY_OBJECT := -2147217315
    static WBEM_E_UNINTERPRETABLE_PROVIDER_QUERY := -2147217313
    static WBEM_E_BACKUP_RESTORE_WINMGMT_RUNNING := -2147217312
    static WBEM_E_QUEUE_OVERFLOW := -2147217311
    static WBEM_E_PRIVILEGE_NOT_HELD := -2147217310
    static WBEM_E_INVALID_OPERATOR := -2147217309
    static WBEM_E_LOCAL_CREDENTIALS := -2147217308
    static WBEM_E_CANNOT_BE_ABSTRACT := -2147217307
    static WBEM_E_AMENDED_OBJECT := -2147217306
    static WBEM_E_CLIENT_TOO_SLOW := -2147217305
    static WBEM_E_NULL_SECURITY_DESCRIPTOR := -2147217304
    static WBEM_E_TIMED_OUT := -2147217303
    static WBEM_E_INVALID_ASSOCIATION := -2147217302
    static WBEM_E_AMBIGUOUS_OPERATION := -2147217301
    static WBEM_E_QUOTA_VIOLATION := -2147217300
    static WBEM_E_RESERVED_001 := -2147217299
    static WBEM_E_RESERVED_002 := -2147217298
    static WBEM_E_UNSUPPORTED_LOCALE := -2147217297
    static WBEM_E_HANDLE_OUT_OF_DATE := -2147217296
    static WBEM_E_CONNECTION_FAILED := -2147217295
    static WBEM_E_INVALID_HANDLE_REQUEST := -2147217294
    static WBEM_E_PROPERTY_NAME_TOO_WIDE := -2147217293
    static WBEM_E_CLASS_NAME_TOO_WIDE := -2147217292
    static WBEM_E_METHOD_NAME_TOO_WIDE := -2147217291
    static WBEM_E_QUALIFIER_NAME_TOO_WIDE := -2147217290
    static WBEM_E_RERUN_COMMAND := -2147217289
    static WBEM_E_DATABASE_VER_MISMATCH := -2147217288
    static WBEM_E_VETO_DELETE := -2147217287
    static WBEM_E_VETO_PUT := -2147217286
    static WBEM_E_INVALID_LOCALE := -2147217280
    static WBEM_E_PROVIDER_SUSPENDED := -2147217279
    static WBEM_E_SYNCHRONIZATION_REQUIRED := -2147217278
    static WBEM_E_NO_SCHEMA := -2147217277
    static WBEM_E_PROVIDER_ALREADY_REGISTERED := -2147217276
    static WBEM_E_PROVIDER_NOT_REGISTERED := -2147217275
    static WBEM_E_FATAL_TRANSPORT_ERROR := -2147217274
    static WBEM_E_ENCRYPTED_CONNECTION_REQUIRED := -2147217273
    static WBEM_E_PROVIDER_TIMED_OUT := -2147217272
    static WBEM_E_NO_KEY := -2147217271
    static WBEM_E_PROVIDER_DISABLED := -2147217270
    static WBEMESS_E_REGISTRATION_TOO_BROAD := -2147213311
    static WBEMESS_E_REGISTRATION_TOO_PRECISE := -2147213310
    static WBEMESS_E_AUTHZ_NOT_PRIVILEGED := -2147213309
    static WBEMMOF_E_EXPECTED_QUALIFIER_NAME := -2147205119
    static WBEMMOF_E_EXPECTED_SEMI := -2147205118
    static WBEMMOF_E_EXPECTED_OPEN_BRACE := -2147205117
    static WBEMMOF_E_EXPECTED_CLOSE_BRACE := -2147205116
    static WBEMMOF_E_EXPECTED_CLOSE_BRACKET := -2147205115
    static WBEMMOF_E_EXPECTED_CLOSE_PAREN := -2147205114
    static WBEMMOF_E_ILLEGAL_CONSTANT_VALUE := -2147205113
    static WBEMMOF_E_EXPECTED_TYPE_IDENTIFIER := -2147205112
    static WBEMMOF_E_EXPECTED_OPEN_PAREN := -2147205111
    static WBEMMOF_E_UNRECOGNIZED_TOKEN := -2147205110
    static WBEMMOF_E_UNRECOGNIZED_TYPE := -2147205109
    static WBEMMOF_E_EXPECTED_PROPERTY_NAME := -2147205108
    static WBEMMOF_E_TYPEDEF_NOT_SUPPORTED := -2147205107
    static WBEMMOF_E_UNEXPECTED_ALIAS := -2147205106
    static WBEMMOF_E_UNEXPECTED_ARRAY_INIT := -2147205105
    static WBEMMOF_E_INVALID_AMENDMENT_SYNTAX := -2147205104
    static WBEMMOF_E_INVALID_DUPLICATE_AMENDMENT := -2147205103
    static WBEMMOF_E_INVALID_PRAGMA := -2147205102
    static WBEMMOF_E_INVALID_NAMESPACE_SYNTAX := -2147205101
    static WBEMMOF_E_EXPECTED_CLASS_NAME := -2147205100
    static WBEMMOF_E_TYPE_MISMATCH := -2147205099
    static WBEMMOF_E_EXPECTED_ALIAS_NAME := -2147205098
    static WBEMMOF_E_INVALID_CLASS_DECLARATION := -2147205097
    static WBEMMOF_E_INVALID_INSTANCE_DECLARATION := -2147205096
    static WBEMMOF_E_EXPECTED_DOLLAR := -2147205095
    static WBEMMOF_E_CIMTYPE_QUALIFIER := -2147205094
    static WBEMMOF_E_DUPLICATE_PROPERTY := -2147205093
    static WBEMMOF_E_INVALID_NAMESPACE_SPECIFICATION := -2147205092
    static WBEMMOF_E_OUT_OF_RANGE := -2147205091
    static WBEMMOF_E_INVALID_FILE := -2147205090
    static WBEMMOF_E_ALIASES_IN_EMBEDDED := -2147205089
    static WBEMMOF_E_NULL_ARRAY_ELEM := -2147205088
    static WBEMMOF_E_DUPLICATE_QUALIFIER := -2147205087
    static WBEMMOF_E_EXPECTED_FLAVOR_TYPE := -2147205086
    static WBEMMOF_E_INCOMPATIBLE_FLAVOR_TYPES := -2147205085
    static WBEMMOF_E_MULTIPLE_ALIASES := -2147205084
    static WBEMMOF_E_INCOMPATIBLE_FLAVOR_TYPES2 := -2147205083
    static WBEMMOF_E_NO_ARRAYS_RETURNED := -2147205082
    static WBEMMOF_E_MUST_BE_IN_OR_OUT := -2147205081
    static WBEMMOF_E_INVALID_FLAGS_SYNTAX := -2147205080
    static WBEMMOF_E_EXPECTED_BRACE_OR_BAD_TYPE := -2147205079
    static WBEMMOF_E_UNSUPPORTED_CIMV22_QUAL_VALUE := -2147205078
    static WBEMMOF_E_UNSUPPORTED_CIMV22_DATA_TYPE := -2147205077
    static WBEMMOF_E_INVALID_DELETEINSTANCE_SYNTAX := -2147205076
    static WBEMMOF_E_INVALID_QUALIFIER_SYNTAX := -2147205075
    static WBEMMOF_E_QUALIFIER_USED_OUTSIDE_SCOPE := -2147205074
    static WBEMMOF_E_ERROR_CREATING_TEMP_FILE := -2147205073
    static WBEMMOF_E_ERROR_INVALID_INCLUDE_FILE := -2147205072
    static WBEMMOF_E_INVALID_DELETECLASS_SYNTAX := -2147205071
}
struct IWbemClassObject extends IUnknown {
    static IID := "{DC12A681-737F-11CF-884D-00AA004B2E24}"
    GetQualifierSet(ppQualSet)
      => ComCall(3, this.p, IWbemQualifierSet.Ptr, ppQualSet)
    Get(wszName, lFlags, pVal, pType?, plFlavor?)
      => ComCall(4, this.p, "Str", wszName, Int32, lFlags, VARIANT.Ptr, pVal, Int32.Ptr, pType?, Int32.Ptr, plFlavor?)
    Put(wszName, lFlags, pVal, Type)
      => ComCall(5, this.p, "Str", wszName, Int32, lFlags, VARIANT.Ptr, pVal, Int32, Type)
    Delete(wszName)
      => ComCall(6, this.p, "Str", wszName)
    GetNames(wszQualifierName, lFlags, pQualifierVal, pNames)
      => ComCall(7, this.p, "Str", wszQualifierName, WBEM_CONDITION_FLAG_TYPE, lFlags, VARIANT.Ptr, pQualifierVal, SAFEARRAY.Ptr.Ptr, pNames)
    BeginEnumeration(lEnumFlags)
      => ComCall(8, this.p, Int32, lEnumFlags)
    Next(lFlags, strName, pVal, pType, plFlavor)
      => ComCall(9, this.p, Int32, lFlags, BSTR.Ptr, strName, VARIANT.Ptr, pVal, Int32.Ptr, pType, Int32.Ptr, plFlavor)
    EndEnumeration()
      => ComCall(10, this.p)
    GetPropertyQualifierSet(wszProperty, ppQualSet)
      => ComCall(11, this.p, "Str", wszProperty, IWbemQualifierSet.Ptr, ppQualSet)
    Clone(ppCopy)
      => ComCall(12, this.p, IWbemClassObject.Ptr, ppCopy)
    GetObjectText(lFlags, pstrObjectText)
      => ComCall(13, this.p, Int32, lFlags, BSTR.Ptr, pstrObjectText)
    SpawnDerivedClass(lFlags, ppNewClass)
      => ComCall(14, this.p, Int32, lFlags, IWbemClassObject.Ptr, ppNewClass)
    SpawnInstance(lFlags, ppNewInstance)
      => ComCall(15, this.p, Int32, lFlags, IWbemClassObject.Ptr, ppNewInstance)
    CompareTo(lFlags, pCompareTo)
      => ComCall(16, this.p, WBEM_COMPARISON_FLAG, lFlags, IWbemClassObject, pCompareTo)
    GetPropertyOrigin(wszName, pstrClassName)
      => ComCall(17, this.p, "Str", wszName, BSTR.Ptr, pstrClassName)
    InheritsFrom(strAncestor)
      => ComCall(18, this.p, "Str", strAncestor)
    GetMethod(wszName, lFlags, ppInSignature, ppOutSignature)
      => ComCall(19, this.p, "Str", wszName, Int32, lFlags, IWbemClassObject.Ptr, ppInSignature, IWbemClassObject.Ptr, ppOutSignature)
    PutMethod(wszName, lFlags, pInSignature, pOutSignature)
      => ComCall(20, this.p, "Str", wszName, Int32, lFlags, IWbemClassObject, pInSignature, IWbemClassObject, pOutSignature)
    DeleteMethod(wszName)
      => ComCall(21, this.p, "Str", wszName)
    BeginMethodEnumeration(lEnumFlags)
      => ComCall(22, this.p, Int32, lEnumFlags)
    NextMethod(lFlags, pstrName, ppInSignature, ppOutSignature)
      => ComCall(23, this.p, Int32, lFlags, BSTR.Ptr, pstrName, IWbemClassObject.Ptr, ppInSignature, IWbemClassObject.Ptr, ppOutSignature)
    EndMethodEnumeration()
      => ComCall(24, this.p)
    GetMethodQualifierSet(wszMethod, ppQualSet)
      => ComCall(25, this.p, "Str", wszMethod, IWbemQualifierSet.Ptr, ppQualSet)
    GetMethodOrigin(wszMethodName, pstrClassName)
      => ComCall(26, this.p, "Str", wszMethodName, BSTR.Ptr, pstrClassName)
}
struct IWbemObjectAccess extends IWbemClassObject {
    static IID := "{49353C9A-516B-11D1-AEA6-00C04FB68820}"
    GetPropertyHandle(wszPropertyName, pType, plHandle)
      => ComCall(27, this.p, "Str", wszPropertyName, Int32.Ptr, pType, Int32.Ptr, plHandle)
    WritePropertyValue(lHandle, aData)
      => ComCall(28, this.p, Int32, lHandle, Int32, aData.Length, UInt8.Ptr, aData)
    ReadPropertyValue(lHandle, plNumBytes, aData)
      => ComCall(29, this.p, Int32, lHandle, Int32, aData.Length, Int32.Ptr, plNumBytes, UInt8.Ptr, aData)
    ReadDWORD(lHandle, pdw)
      => ComCall(30, this.p, Int32, lHandle, UInt32.Ptr, pdw)
    WriteDWORD(lHandle, dw)
      => ComCall(31, this.p, Int32, lHandle, UInt32, dw)
    ReadQWORD(lHandle, pqw)
      => ComCall(32, this.p, Int32, lHandle, Int64.Ptr, pqw)
    WriteQWORD(lHandle, pw)
      => ComCall(33, this.p, Int32, lHandle, Int64, pw)
    GetPropertyInfoByHandle(lHandle, pstrName, pType)
      => ComCall(34, this.p, Int32, lHandle, BSTR.Ptr, pstrName, Int32.Ptr, pType)
    Lock(lFlags)
      => ComCall(35, this.p, Int32, lFlags)
    Unlock(lFlags)
      => ComCall(36, this.p, Int32, lFlags)
}
struct IWbemQualifierSet extends IUnknown {
    static IID := "{DC12A680-737F-11CF-884D-00AA004B2E24}"
    Get(wszName, lFlags, pVal, plFlavor)
      => ComCall(3, this.p, "Str", wszName, Int32, lFlags, VARIANT.Ptr, pVal, Int32.Ptr, plFlavor)
    Put(wszName, pVal, lFlavor)
      => ComCall(4, this.p, "Str", wszName, VARIANT.Ptr, pVal, Int32, lFlavor)
    Delete(wszName)
      => ComCall(5, this.p, "Str", wszName)
    GetNames(lFlags, pNames)
      => ComCall(6, this.p, Int32, lFlags, SAFEARRAY.Ptr.Ptr, pNames)
    BeginEnumeration(lFlags)
      => ComCall(7, this.p, Int32, lFlags)
    Next(lFlags, pstrName, pVal, plFlavor)
      => ComCall(8, this.p, Int32, lFlags, BSTR.Ptr, pstrName, VARIANT.Ptr, pVal, Int32.Ptr, plFlavor)
    EndEnumeration()
      => ComCall(9, this.p)
}
struct IWbemServices extends IUnknown {
    static IID := "{9556DC99-828C-11CF-A37E-00AA003240C7}"
    OpenNamespace(strNamespace, lFlags, pCtx, ppWorkingNamespace?, ppResult?)
      => ComCall(3, this.p, BSTR, strNamespace, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemServices.Ptr, ppWorkingNamespace?, IWbemCallResult.Ptr, ppResult?)
    CancelAsyncCall(pSink)
      => ComCall(4, this.p, IWbemObjectSink, pSink)
    QueryObjectSink(lFlags, ppResponseHandler)
      => ComCall(5, this.p, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemObjectSink.Ptr, ppResponseHandler)
    GetObject(strObjectPath, lFlags, pCtx, ppObject?, ppCallResult?)
      => ComCall(6, this.p, BSTR, strObjectPath, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemClassObject.Ptr, ppObject?, IWbemCallResult.Ptr, ppCallResult?)
    GetObjectAsync(strObjectPath, lFlags, pCtx, pResponseHandler)
      => ComCall(7, this.p, BSTR, strObjectPath, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemObjectSink, pResponseHandler)
    PutClass(pObject, lFlags, pCtx, ppCallResult?)
      => ComCall(8, this.p, IWbemClassObject, pObject, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemCallResult.Ptr, ppCallResult?)
    PutClassAsync(pObject, lFlags, pCtx, pResponseHandler)
      => ComCall(9, this.p, IWbemClassObject, pObject, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemObjectSink, pResponseHandler)
    DeleteClass(strClass, lFlags, pCtx, ppCallResult?)
      => ComCall(10, this.p, BSTR, strClass, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemCallResult.Ptr, ppCallResult?)
    DeleteClassAsync(strClass, lFlags, pCtx, pResponseHandler)
      => ComCall(11, this.p, BSTR, strClass, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemObjectSink, pResponseHandler)
    CreateClassEnum(strSuperclass, lFlags, pCtx, ppEnum)
      => ComCall(12, this.p, BSTR, strSuperclass, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IEnumWbemClassObject.Ptr, ppEnum)
    CreateClassEnumAsync(strSuperclass, lFlags, pCtx, pResponseHandler)
      => ComCall(13, this.p, BSTR, strSuperclass, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemObjectSink, pResponseHandler)
    PutInstance(pInst, lFlags, pCtx, ppCallResult?)
      => ComCall(14, this.p, IWbemClassObject, pInst, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemCallResult.Ptr, ppCallResult?)
    PutInstanceAsync(pInst, lFlags, pCtx, pResponseHandler)
      => ComCall(15, this.p, IWbemClassObject, pInst, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemObjectSink, pResponseHandler)
    DeleteInstance(strObjectPath, lFlags, pCtx, ppCallResult?)
      => ComCall(16, this.p, BSTR, strObjectPath, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemCallResult.Ptr, ppCallResult?)
    DeleteInstanceAsync(strObjectPath, lFlags, pCtx, pResponseHandler)
      => ComCall(17, this.p, BSTR, strObjectPath, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemObjectSink, pResponseHandler)
    CreateInstanceEnum(strFilter, lFlags, pCtx, ppEnum)
      => ComCall(18, this.p, BSTR, strFilter, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IEnumWbemClassObject.Ptr, ppEnum)
    CreateInstanceEnumAsync(strFilter, lFlags, pCtx, pResponseHandler)
      => ComCall(19, this.p, BSTR, strFilter, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemObjectSink, pResponseHandler)
    ExecQuery(strQueryLanguage, strQuery, lFlags, pCtx, ppEnum)
      => ComCall(20, this.p, BSTR, strQueryLanguage, BSTR, strQuery, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IEnumWbemClassObject.Ptr, ppEnum)
    ExecQueryAsync(strQueryLanguage, strQuery, lFlags, pCtx, pResponseHandler)
      => ComCall(21, this.p, BSTR, strQueryLanguage, BSTR, strQuery, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemObjectSink, pResponseHandler)
    ExecNotificationQuery(strQueryLanguage, strQuery, lFlags, pCtx, ppEnum)
      => ComCall(22, this.p, BSTR, strQueryLanguage, BSTR, strQuery, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IEnumWbemClassObject.Ptr, ppEnum)
    ExecNotificationQueryAsync(strQueryLanguage, strQuery, lFlags, pCtx, pResponseHandler)
      => ComCall(23, this.p, BSTR, strQueryLanguage, BSTR, strQuery, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemObjectSink, pResponseHandler)
    ExecMethod(strObjectPath, strMethodName, lFlags, pCtx, pInParams, ppOutParams?, ppCallResult?)
      => ComCall(24, this.p, BSTR, strObjectPath, BSTR, strMethodName, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemClassObject, pInParams, IWbemClassObject.Ptr, ppOutParams?, IWbemCallResult.Ptr, ppCallResult?)
    ExecMethodAsync(strObjectPath, strMethodName, lFlags, pCtx, pInParams, pResponseHandler)
      => ComCall(25, this.p, BSTR, strObjectPath, BSTR, strMethodName, WBEM_GENERIC_FLAG_TYPE, lFlags, IWbemContext, pCtx, IWbemClassObject, pInParams, IWbemObjectSink, pResponseHandler)
}
struct IWbemLocator extends IUnknown {
    static IID := "{DC12A687-737F-11CF-884D-00AA004B2E24}"
    ConnectServer(strNetworkResource, strUser, strPassword, strLocale, lSecurityFlags, strAuthority, pCtx, ppNamespace)
      => ComCall(3, this.p, BSTR, strNetworkResource, BSTR, strUser, BSTR, strPassword, BSTR, strLocale, Int32, lSecurityFlags, BSTR, strAuthority, IWbemContext, pCtx, IWbemServices.Ptr, ppNamespace)
}
struct IWbemObjectSink extends IUnknown {
    static IID := "{7C857801-7381-11CF-884D-00AA004B2E24}"
    Indicate(apObjArray)
      => ComCall(3, this.p, Int32, apObjArray.Length, IWbemClassObject.Ptr, apObjArray)
    SetStatus(lFlags, hResult1, strParam, pObjParam)
      => ComCall(4, this.p, Int32, lFlags, HRESULT, hResult1, BSTR, strParam, IWbemClassObject, pObjParam)
}
struct IEnumWbemClassObject extends IUnknown {
    static IID := "{027947E1-D731-11CE-A357-000000000001}"
    Reset()
      => ComCall(3, this.p)
    Next(lTimeout, apObjects, puReturned)
      => ComCall(4, this.p, Int32, lTimeout, UInt32, apObjects.Length, IWbemClassObject.Ptr, apObjects, UInt32.Ptr, puReturned)
    NextAsync(uCount, pSink)
      => ComCall(5, this.p, UInt32, uCount, IWbemObjectSink, pSink)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumWbemClassObject.Ptr, ppEnum)
    Skip(lTimeout, nCount)
      => ComCall(7, this.p, Int32, lTimeout, UInt32, nCount)
}
struct IWbemCallResult extends IUnknown {
    static IID := "{44ACA675-E8FC-11D0-A07C-00C04FB68820}"
    GetResultObject(lTimeout, ppResultObject)
      => ComCall(3, this.p, Int32, lTimeout, IWbemClassObject.Ptr, ppResultObject)
    GetResultString(lTimeout, pstrResultString)
      => ComCall(4, this.p, Int32, lTimeout, BSTR.Ptr, pstrResultString)
    GetResultServices(lTimeout, ppServices)
      => ComCall(5, this.p, Int32, lTimeout, IWbemServices.Ptr, ppServices)
    GetCallStatus(lTimeout, plStatus)
      => ComCall(6, this.p, Int32, lTimeout, Int32.Ptr, plStatus)
}
struct IWbemContext extends IUnknown {
    static IID := "{44ACA674-E8FC-11D0-A07C-00C04FB68820}"
    Clone(ppNewCopy)
      => ComCall(3, this.p, IWbemContext.Ptr, ppNewCopy)
    GetNames(lFlags, pNames)
      => ComCall(4, this.p, Int32, lFlags, SAFEARRAY.Ptr.Ptr, pNames)
    BeginEnumeration(lFlags)
      => ComCall(5, this.p, Int32, lFlags)
    Next(lFlags, pstrName, pValue)
      => ComCall(6, this.p, Int32, lFlags, BSTR.Ptr, pstrName, VARIANT.Ptr, pValue)
    EndEnumeration()
      => ComCall(7, this.p)
    SetValue(wszName, lFlags, pValue)
      => ComCall(8, this.p, "Str", wszName, Int32, lFlags, VARIANT.Ptr, pValue)
    GetValue(wszName, lFlags, pValue)
      => ComCall(9, this.p, "Str", wszName, Int32, lFlags, VARIANT.Ptr, pValue)
    DeleteValue(wszName, lFlags)
      => ComCall(10, this.p, "Str", wszName, Int32, lFlags)
    DeleteAll()
      => ComCall(11, this.p)
}
struct IUnsecuredApartment extends IUnknown {
    static IID := "{1CFABA8C-1523-11D1-AD79-00C04FD8FDFF}"
    CreateObjectStub(pObject, ppStub)
      => ComCall(3, this.p, IUnknown, pObject, IUnknown.Ptr, ppStub)
}
struct IWbemUnsecuredApartment extends IUnsecuredApartment {
    static IID := "{31739D04-3471-4CF4-9A7C-57A44AE71956}"
    CreateSinkStub(pSink, dwFlags, wszReserved, ppStub)
      => ComCall(4, this.p, IWbemObjectSink, pSink, UInt32, dwFlags, "Str", wszReserved, IWbemObjectSink.Ptr, ppStub)
}
struct IWbemStatusCodeText extends IUnknown {
    static IID := "{EB87E1BC-3233-11D2-AEC9-00C04FB68820}"
    GetErrorCodeText(hRes, LocaleId, lFlags, MessageText)
      => ComCall(3, this.p, HRESULT, hRes, UInt32, LocaleId, Int32, lFlags, BSTR.Ptr, MessageText)
    GetFacilityCodeText(hRes, LocaleId, lFlags, MessageText)
      => ComCall(4, this.p, HRESULT, hRes, UInt32, LocaleId, Int32, lFlags, BSTR.Ptr, MessageText)
}
struct IWbemBackupRestore extends IUnknown {
    static IID := "{C49E32C7-BC8B-11D2-85D4-00105A1F8304}"
    Backup(strBackupToFile, lFlags)
      => ComCall(3, this.p, "Str", strBackupToFile, Int32, lFlags)
    Restore(strRestoreFromFile, lFlags)
      => ComCall(4, this.p, "Str", strRestoreFromFile, Int32, lFlags)
}
struct IWbemBackupRestoreEx extends IWbemBackupRestore {
    static IID := "{A359DEC5-E813-4834-8A2A-BA7F1D777D76}"
    Pause()
      => ComCall(5, this.p)
    Resume()
      => ComCall(6, this.p)
}
struct IWbemRefresher extends IUnknown {
    static IID := "{49353C99-516B-11D1-AEA6-00C04FB68820}"
    Refresh(lFlags)
      => ComCall(3, this.p, Int32, lFlags)
}
struct IWbemHiPerfEnum extends IUnknown {
    static IID := "{2705C288-79AE-11D2-B348-00105A1F8177}"
    AddObjects(lFlags, apIds, apObj)
      => ComCall(3, this.p, Int32, lFlags, UInt32, apObj.Length, Int32.Ptr, apIds, IWbemObjectAccess.Ptr, apObj)
    RemoveObjects(lFlags, apIds)
      => ComCall(4, this.p, Int32, lFlags, UInt32, apIds.Length, Int32.Ptr, apIds)
    GetObjects(lFlags, apObj, puReturned)
      => ComCall(5, this.p, Int32, lFlags, UInt32, apObj.Length, IWbemObjectAccess.Ptr, apObj, UInt32.Ptr, puReturned)
    RemoveAll(lFlags)
      => ComCall(6, this.p, Int32, lFlags)
}
struct IWbemConfigureRefresher extends IUnknown {
    static IID := "{49353C92-516B-11D1-AEA6-00C04FB68820}"
    AddObjectByPath(pNamespace, wszPath, lFlags, pContext, ppRefreshable, plId)
      => ComCall(3, this.p, IWbemServices, pNamespace, "Str", wszPath, Int32, lFlags, IWbemContext, pContext, IWbemClassObject.Ptr, ppRefreshable, Int32.Ptr, plId)
    AddObjectByTemplate(pNamespace, pTemplate, lFlags, pContext, ppRefreshable, plId)
      => ComCall(4, this.p, IWbemServices, pNamespace, IWbemClassObject, pTemplate, Int32, lFlags, IWbemContext, pContext, IWbemClassObject.Ptr, ppRefreshable, Int32.Ptr, plId)
    AddRefresher(pRefresher, lFlags, plId)
      => ComCall(5, this.p, IWbemRefresher, pRefresher, Int32, lFlags, Int32.Ptr, plId)
    Remove(lId, lFlags)
      => ComCall(6, this.p, Int32, lId, Int32, lFlags)
    AddEnum(pNamespace, wszClassName, lFlags, pContext, ppEnum, plId)
      => ComCall(7, this.p, IWbemServices, pNamespace, "Str", wszClassName, Int32, lFlags, IWbemContext, pContext, IWbemHiPerfEnum.Ptr, ppEnum, Int32.Ptr, plId)
}
struct IWbemObjectSinkEx extends IWbemObjectSink {
    static IID := "{E7D35CFA-348B-485E-B524-252725D697CA}"
    WriteMessage(uChannel, strMessage)
      => ComCall(5, this.p, UInt32, uChannel, BSTR, strMessage)
    WriteError(pObjError, puReturned)
      => ComCall(6, this.p, IWbemClassObject, pObjError, UInt8.Ptr, puReturned)
    PromptUser(strMessage, uPromptType, puReturned)
      => ComCall(7, this.p, BSTR, strMessage, UInt8, uPromptType, UInt8.Ptr, puReturned)
    WriteProgress(strActivity, strCurrentOperation, strStatusDescription, uPercentComplete, uSecondsRemaining)
      => ComCall(8, this.p, BSTR, strActivity, BSTR, strCurrentOperation, BSTR, strStatusDescription, UInt32, uPercentComplete, UInt32, uSecondsRemaining)
    WriteStreamParameter(strName, vtValue, ulType, ulFlags)
      => ComCall(9, this.p, BSTR, strName, VARIANT.Ptr, vtValue, UInt32, ulType, UInt32, ulFlags)
}
struct IWbemShutdown extends IUnknown {
    static IID := "{B7B31DF9-D515-11D3-A11C-00105A1F515A}"
    Shutdown(uReason, uMaxMilliseconds, pCtx)
      => ComCall(3, this.p, Int32, uReason, UInt32, uMaxMilliseconds, IWbemContext, pCtx)
}
struct WMI_OBJ_TEXT extends Int32 {
    static WMI_OBJ_TEXT_CIM_DTD_2_0 := 1
    static WMI_OBJ_TEXT_WMI_DTD_2_0 := 2
    static WMI_OBJ_TEXT_WMI_EXT1 := 3
    static WMI_OBJ_TEXT_WMI_EXT2 := 4
    static WMI_OBJ_TEXT_WMI_EXT3 := 5
    static WMI_OBJ_TEXT_WMI_EXT4 := 6
    static WMI_OBJ_TEXT_WMI_EXT5 := 7
    static WMI_OBJ_TEXT_WMI_EXT6 := 8
    static WMI_OBJ_TEXT_WMI_EXT7 := 9
    static WMI_OBJ_TEXT_WMI_EXT8 := 10
    static WMI_OBJ_TEXT_WMI_EXT9 := 11
    static WMI_OBJ_TEXT_WMI_EXT10 := 12
    static WMI_OBJ_TEXT_LAST := 13
}
struct IWbemObjectTextSrc extends IUnknown {
    static IID := "{BFBF883A-CAD7-11D3-A11B-00105A1F515A}"
    GetText(lFlags, pObj, uObjTextFormat, pCtx, strText)
      => ComCall(3, this.p, Int32, lFlags, IWbemClassObject, pObj, UInt32, uObjTextFormat, IWbemContext, pCtx, BSTR.Ptr, strText)
    CreateFromText(lFlags, strText, uObjTextFormat, pCtx, pNewObj)
      => ComCall(4, this.p, Int32, lFlags, BSTR, strText, UInt32, uObjTextFormat, IWbemContext, pCtx, IWbemClassObject.Ptr, pNewObj)
}
struct WBEM_COMPILE_STATUS_INFO {
    lPhaseError : Int32
    hRes : HRESULT
    ObjectNum : Int32
    FirstLine : Int32
    LastLine : Int32
    dwOutFlags : UInt32
}
struct WBEM_COMPILER_OPTIONS extends Int32 {
    static WBEM_FLAG_CHECK_ONLY := 1
    static WBEM_FLAG_AUTORECOVER := 2
    static WBEM_FLAG_WMI_CHECK := 4
    static WBEM_FLAG_CONSOLE_PRINT := 8
    static WBEM_FLAG_DONT_ADD_TO_LIST := 16
    static WBEM_FLAG_SPLIT_FILES := 32
    static WBEM_FLAG_STORE_FILE := 256
}
struct WBEM_CONNECT_OPTIONS extends Int32 {
    static WBEM_FLAG_CONNECT_REPOSITORY_ONLY := 64
    static WBEM_FLAG_CONNECT_USE_MAX_WAIT := 128
    static WBEM_FLAG_CONNECT_PROVIDERS := 256
}
struct IMofCompiler extends IUnknown {
    static IID := "{6DAF974E-2E37-11D2-AEC9-00C04FB68820}"
    CompileFile(FileName, ServerAndNamespace, User, Authority, Password, lOptionFlags, lClassFlags, lInstanceFlags, pInfo)
      => ComCall(3, this.p, "Str", FileName, "Str", ServerAndNamespace, "Str", User, "Str", Authority, "Str", Password, Int32, lOptionFlags, Int32, lClassFlags, Int32, lInstanceFlags, WBEM_COMPILE_STATUS_INFO.Ptr, pInfo)
    CompileBuffer(pBuffer, ServerAndNamespace, User, Authority, Password, lOptionFlags, lClassFlags, lInstanceFlags, pInfo)
      => ComCall(4, this.p, Int32, pBuffer.Size, UInt8.Ptr, pBuffer, "Str", ServerAndNamespace, "Str", User, "Str", Authority, "Str", Password, Int32, lOptionFlags, Int32, lClassFlags, Int32, lInstanceFlags, WBEM_COMPILE_STATUS_INFO.Ptr, pInfo)
    CreateBMOF(TextFileName, BMOFFileName, ServerAndNamespace, lOptionFlags, lClassFlags, lInstanceFlags, pInfo)
      => ComCall(5, this.p, "Str", TextFileName, "Str", BMOFFileName, "Str", ServerAndNamespace, Int32, lOptionFlags, Int32, lClassFlags, Int32, lInstanceFlags, WBEM_COMPILE_STATUS_INFO.Ptr, pInfo)
}
struct WBEM_UNSECAPP_FLAG_TYPE extends Int32 {
    static WBEM_FLAG_UNSECAPP_DEFAULT_CHECK_ACCESS := 0
    static WBEM_FLAG_UNSECAPP_CHECK_ACCESS := 1
    static WBEM_FLAG_UNSECAPP_DONT_CHECK_ACCESS := 2
}
struct WBEM_INFORMATION_FLAG_TYPE extends Int32 {
    static WBEM_FLAG_SHORT_NAME := 1
    static WBEM_FLAG_LONG_NAME := 2
}
struct WBEM_PROVIDER_REQUIREMENTS_TYPE extends Int32 {
    static WBEM_REQUIREMENTS_START_POSTFILTER := 0
    static WBEM_REQUIREMENTS_STOP_POSTFILTER := 1
    static WBEM_REQUIREMENTS_RECHECK_SUBSCRIPTIONS := 2
}
struct IWbemPropertyProvider extends IUnknown {
    static IID := "{CE61E841-65BC-11D0-B6BD-00AA003240C7}"
    GetProperty(lFlags, strLocale, strClassMapping, strInstMapping, strPropMapping, pvValue)
      => ComCall(3, this.p, Int32, lFlags, BSTR, strLocale, BSTR, strClassMapping, BSTR, strInstMapping, BSTR, strPropMapping, VARIANT.Ptr, pvValue)
    PutProperty(lFlags, strLocale, strClassMapping, strInstMapping, strPropMapping, pvValue)
      => ComCall(4, this.p, Int32, lFlags, BSTR, strLocale, BSTR, strClassMapping, BSTR, strInstMapping, BSTR, strPropMapping, VARIANT.Ptr, pvValue)
}
struct IWbemUnboundObjectSink extends IUnknown {
    static IID := "{E246107B-B06E-11D0-AD61-00C04FD8FDFF}"
    IndicateToConsumer(pLogicalConsumer, apObjects)
      => ComCall(3, this.p, IWbemClassObject, pLogicalConsumer, Int32, apObjects.Length, IWbemClassObject.Ptr, apObjects)
}
struct IWbemEventProvider extends IUnknown {
    static IID := "{E245105B-B06E-11D0-AD61-00C04FD8FDFF}"
    ProvideEvents(pSink, lFlags)
      => ComCall(3, this.p, IWbemObjectSink, pSink, Int32, lFlags)
}
struct IWbemEventProviderQuerySink extends IUnknown {
    static IID := "{580ACAF8-FA1C-11D0-AD72-00C04FD8FDFF}"
    NewQuery(dwId, wszQueryLanguage, wszQuery)
      => ComCall(3, this.p, UInt32, dwId, UInt16.Ptr, wszQueryLanguage, UInt16.Ptr, wszQuery)
    CancelQuery(dwId)
      => ComCall(4, this.p, UInt32, dwId)
}
struct IWbemEventProviderSecurity extends IUnknown {
    static IID := "{631F7D96-D993-11D2-B339-00105A1F4AAF}"
    AccessCheck(wszQueryLanguage, wszQuery, pSid)
      => ComCall(3, this.p, UInt16.Ptr, wszQueryLanguage, UInt16.Ptr, wszQuery, Int32, pSid.Length, UInt8.Ptr, pSid)
}
struct IWbemEventConsumerProvider extends IUnknown {
    static IID := "{E246107A-B06E-11D0-AD61-00C04FD8FDFF}"
    FindConsumer(pLogicalConsumer, ppConsumer)
      => ComCall(3, this.p, IWbemClassObject, pLogicalConsumer, IWbemUnboundObjectSink.Ptr, ppConsumer)
}
struct IWbemProviderInitSink extends IUnknown {
    static IID := "{1BE41571-91DD-11D1-AEB2-00C04FB68820}"
    SetStatus(lStatus, lFlags)
      => ComCall(3, this.p, Int32, lStatus, Int32, lFlags)
}
struct IWbemProviderInit extends IUnknown {
    static IID := "{1BE41572-91DD-11D1-AEB2-00C04FB68820}"
    Initialize(wszUser, lFlags, wszNamespace, wszLocale, pNamespace, pCtx, pInitSink)
      => ComCall(3, this.p, "Str", wszUser, Int32, lFlags, "Str", wszNamespace, "Str", wszLocale, IWbemServices, pNamespace, IWbemContext, pCtx, IWbemProviderInitSink, pInitSink)
}
struct IWbemHiPerfProvider extends IUnknown {
    static IID := "{49353C93-516B-11D1-AEA6-00C04FB68820}"
    QueryInstances(pNamespace, wszClass, lFlags, pCtx, pSink)
      => ComCall(3, this.p, IWbemServices, pNamespace, "Str", wszClass, Int32, lFlags, IWbemContext, pCtx, IWbemObjectSink, pSink)
    CreateRefresher(pNamespace, lFlags, ppRefresher)
      => ComCall(4, this.p, IWbemServices, pNamespace, Int32, lFlags, IWbemRefresher.Ptr, ppRefresher)
    CreateRefreshableObject(pNamespace, pTemplate, pRefresher, lFlags, pContext, ppRefreshable, plId)
      => ComCall(5, this.p, IWbemServices, pNamespace, IWbemObjectAccess, pTemplate, IWbemRefresher, pRefresher, Int32, lFlags, IWbemContext, pContext, IWbemObjectAccess.Ptr, ppRefreshable, Int32.Ptr, plId)
    StopRefreshing(pRefresher, lId, lFlags)
      => ComCall(6, this.p, IWbemRefresher, pRefresher, Int32, lId, Int32, lFlags)
    CreateRefreshableEnum(pNamespace, wszClass, pRefresher, lFlags, pContext, pHiPerfEnum, plId)
      => ComCall(7, this.p, IWbemServices, pNamespace, "Str", wszClass, IWbemRefresher, pRefresher, Int32, lFlags, IWbemContext, pContext, IWbemHiPerfEnum, pHiPerfEnum, Int32.Ptr, plId)
    GetObjects(pNamespace, apObj, lFlags, pContext)
      => ComCall(8, this.p, IWbemServices, pNamespace, Int32, apObj.Length, IWbemObjectAccess.Ptr, apObj, Int32, lFlags, IWbemContext, pContext)
}
struct IWbemDecoupledRegistrar extends IUnknown {
    static IID := "{1005CBCF-E64F-4646-BCD3-3A089D8A84B4}"
    Register(a_Flags, a_Context, a_User, a_Locale, a_Scope, a_Registration, pIUnknown)
      => ComCall(3, this.p, Int32, a_Flags, IWbemContext, a_Context, "Str", a_User, "Str", a_Locale, "Str", a_Scope, "Str", a_Registration, IUnknown, pIUnknown)
    UnRegister()
      => ComCall(4, this.p)
}
struct IWbemProviderIdentity extends IUnknown {
    static IID := "{631F7D97-D993-11D2-B339-00105A1F4AAF}"
    SetRegistrationObject(lFlags, pProvReg)
      => ComCall(3, this.p, Int32, lFlags, IWbemClassObject, pProvReg)
}
struct WBEM_EXTRA_RETURN_CODES extends Int32 {
    static WBEM_S_INITIALIZED := 0
    static WBEM_S_LIMITED_SERVICE := 274433
    static WBEM_S_INDIRECTLY_UPDATED := 274434
    static WBEM_S_SUBJECT_TO_SDS := 274435
    static WBEM_E_RETRY_LATER := -2147209215
    static WBEM_E_RESOURCE_CONTENTION := -2147209214
}
struct WBEM_PROVIDER_FLAGS extends Int32 {
    static WBEM_FLAG_OWNER_UPDATE := 65536
}
struct IWbemDecoupledBasicEventProvider extends IWbemDecoupledRegistrar {
    static IID := "{86336D20-CA11-4786-9EF1-BC8A946B42FC}"
    GetSink(a_Flags, a_Context, a_Sink)
      => ComCall(5, this.p, Int32, a_Flags, IWbemContext, a_Context, IWbemObjectSink.Ptr, a_Sink)
    GetService(a_Flags, a_Context, a_Service)
      => ComCall(6, this.p, Int32, a_Flags, IWbemContext, a_Context, IWbemServices.Ptr, a_Service)
}
struct WBEM_BATCH_TYPE extends Int32 {
    static WBEM_FLAG_BATCH_IF_NEEDED := 0
    static WBEM_FLAG_MUST_BATCH := 1
    static WBEM_FLAG_MUST_NOT_BATCH := 2
}
struct IWbemEventSink extends IWbemObjectSink {
    static IID := "{3AE0080A-7E3A-4366-BF89-0FEEDC931659}"
    SetSinkSecurity(pSD)
      => ComCall(5, this.p, Int32, pSD.Length, UInt8.Ptr, pSD)
    IsActive()
      => ComCall(6, this.p)
    GetRestrictedSink(awszQueries, pCallback, ppSink)
      => ComCall(7, this.p, Int32, awszQueries.Length, PWSTR.Ptr, awszQueries, IUnknown, pCallback, IWbemEventSink.Ptr, ppSink)
    SetBatchingParameters(lFlags, dwMaxBufferSize, dwMaxSendLatency)
      => ComCall(8, this.p, Int32, lFlags, UInt32, dwMaxBufferSize, UInt32, dwMaxSendLatency)
}
struct WbemChangeFlagEnum extends Int32 {
    static wbemChangeFlagCreateOrUpdate := 0
    static wbemChangeFlagUpdateOnly := 1
    static wbemChangeFlagCreateOnly := 2
    static wbemChangeFlagUpdateCompatible := 0
    static wbemChangeFlagUpdateSafeMode := 32
    static wbemChangeFlagUpdateForceMode := 64
    static wbemChangeFlagStrongValidation := 128
    static wbemChangeFlagAdvisory := 65536
}
struct WbemFlagEnum extends Int32 {
    static wbemFlagReturnImmediately := 16
    static wbemFlagReturnWhenComplete := 0
    static wbemFlagBidirectional := 0
    static wbemFlagForwardOnly := 32
    static wbemFlagNoErrorObject := 64
    static wbemFlagReturnErrorObject := 0
    static wbemFlagSendStatus := 128
    static wbemFlagDontSendStatus := 0
    static wbemFlagEnsureLocatable := 256
    static wbemFlagDirectRead := 512
    static wbemFlagSendOnlySelected := 0
    static wbemFlagUseAmendedQualifiers := 131072
    static wbemFlagGetDefault := 0
    static wbemFlagSpawnInstance := 1
    static wbemFlagUseCurrentTime := 1
}
struct WbemQueryFlagEnum extends Int32 {
    static wbemQueryFlagDeep := 0
    static wbemQueryFlagShallow := 1
    static wbemQueryFlagPrototype := 2
}
struct WbemTextFlagEnum extends Int32 {
    static wbemTextFlagNoFlavors := 1
}
struct WbemTimeout extends Int32 {
    static wbemTimeoutInfinite := -1
}
struct WbemComparisonFlagEnum extends Int32 {
    static wbemComparisonFlagIncludeAll := 0
    static wbemComparisonFlagIgnoreQualifiers := 1
    static wbemComparisonFlagIgnoreObjectSource := 2
    static wbemComparisonFlagIgnoreDefaultValues := 4
    static wbemComparisonFlagIgnoreClass := 8
    static wbemComparisonFlagIgnoreCase := 16
    static wbemComparisonFlagIgnoreFlavor := 32
}
struct WbemCimtypeEnum extends Int32 {
    static wbemCimtypeSint8 := 16
    static wbemCimtypeUint8 := 17
    static wbemCimtypeSint16 := 2
    static wbemCimtypeUint16 := 18
    static wbemCimtypeSint32 := 3
    static wbemCimtypeUint32 := 19
    static wbemCimtypeSint64 := 20
    static wbemCimtypeUint64 := 21
    static wbemCimtypeReal32 := 4
    static wbemCimtypeReal64 := 5
    static wbemCimtypeBoolean := 11
    static wbemCimtypeString := 8
    static wbemCimtypeDatetime := 101
    static wbemCimtypeReference := 102
    static wbemCimtypeChar16 := 103
    static wbemCimtypeObject := 13
}
struct WbemErrorEnum extends Int32 {
    static wbemNoErr := 0
    static wbemErrFailed := -2147217407
    static wbemErrNotFound := -2147217406
    static wbemErrAccessDenied := -2147217405
    static wbemErrProviderFailure := -2147217404
    static wbemErrTypeMismatch := -2147217403
    static wbemErrOutOfMemory := -2147217402
    static wbemErrInvalidContext := -2147217401
    static wbemErrInvalidParameter := -2147217400
    static wbemErrNotAvailable := -2147217399
    static wbemErrCriticalError := -2147217398
    static wbemErrInvalidStream := -2147217397
    static wbemErrNotSupported := -2147217396
    static wbemErrInvalidSuperclass := -2147217395
    static wbemErrInvalidNamespace := -2147217394
    static wbemErrInvalidObject := -2147217393
    static wbemErrInvalidClass := -2147217392
    static wbemErrProviderNotFound := -2147217391
    static wbemErrInvalidProviderRegistration := -2147217390
    static wbemErrProviderLoadFailure := -2147217389
    static wbemErrInitializationFailure := -2147217388
    static wbemErrTransportFailure := -2147217387
    static wbemErrInvalidOperation := -2147217386
    static wbemErrInvalidQuery := -2147217385
    static wbemErrInvalidQueryType := -2147217384
    static wbemErrAlreadyExists := -2147217383
    static wbemErrOverrideNotAllowed := -2147217382
    static wbemErrPropagatedQualifier := -2147217381
    static wbemErrPropagatedProperty := -2147217380
    static wbemErrUnexpected := -2147217379
    static wbemErrIllegalOperation := -2147217378
    static wbemErrCannotBeKey := -2147217377
    static wbemErrIncompleteClass := -2147217376
    static wbemErrInvalidSyntax := -2147217375
    static wbemErrNondecoratedObject := -2147217374
    static wbemErrReadOnly := -2147217373
    static wbemErrProviderNotCapable := -2147217372
    static wbemErrClassHasChildren := -2147217371
    static wbemErrClassHasInstances := -2147217370
    static wbemErrQueryNotImplemented := -2147217369
    static wbemErrIllegalNull := -2147217368
    static wbemErrInvalidQualifierType := -2147217367
    static wbemErrInvalidPropertyType := -2147217366
    static wbemErrValueOutOfRange := -2147217365
    static wbemErrCannotBeSingleton := -2147217364
    static wbemErrInvalidCimType := -2147217363
    static wbemErrInvalidMethod := -2147217362
    static wbemErrInvalidMethodParameters := -2147217361
    static wbemErrSystemProperty := -2147217360
    static wbemErrInvalidProperty := -2147217359
    static wbemErrCallCancelled := -2147217358
    static wbemErrShuttingDown := -2147217357
    static wbemErrPropagatedMethod := -2147217356
    static wbemErrUnsupportedParameter := -2147217355
    static wbemErrMissingParameter := -2147217354
    static wbemErrInvalidParameterId := -2147217353
    static wbemErrNonConsecutiveParameterIds := -2147217352
    static wbemErrParameterIdOnRetval := -2147217351
    static wbemErrInvalidObjectPath := -2147217350
    static wbemErrOutOfDiskSpace := -2147217349
    static wbemErrBufferTooSmall := -2147217348
    static wbemErrUnsupportedPutExtension := -2147217347
    static wbemErrUnknownObjectType := -2147217346
    static wbemErrUnknownPacketType := -2147217345
    static wbemErrMarshalVersionMismatch := -2147217344
    static wbemErrMarshalInvalidSignature := -2147217343
    static wbemErrInvalidQualifier := -2147217342
    static wbemErrInvalidDuplicateParameter := -2147217341
    static wbemErrTooMuchData := -2147217340
    static wbemErrServerTooBusy := -2147217339
    static wbemErrInvalidFlavor := -2147217338
    static wbemErrCircularReference := -2147217337
    static wbemErrUnsupportedClassUpdate := -2147217336
    static wbemErrCannotChangeKeyInheritance := -2147217335
    static wbemErrCannotChangeIndexInheritance := -2147217328
    static wbemErrTooManyProperties := -2147217327
    static wbemErrUpdateTypeMismatch := -2147217326
    static wbemErrUpdateOverrideNotAllowed := -2147217325
    static wbemErrUpdatePropagatedMethod := -2147217324
    static wbemErrMethodNotImplemented := -2147217323
    static wbemErrMethodDisabled := -2147217322
    static wbemErrRefresherBusy := -2147217321
    static wbemErrUnparsableQuery := -2147217320
    static wbemErrNotEventClass := -2147217319
    static wbemErrMissingGroupWithin := -2147217318
    static wbemErrMissingAggregationList := -2147217317
    static wbemErrPropertyNotAnObject := -2147217316
    static wbemErrAggregatingByObject := -2147217315
    static wbemErrUninterpretableProviderQuery := -2147217313
    static wbemErrBackupRestoreWinmgmtRunning := -2147217312
    static wbemErrQueueOverflow := -2147217311
    static wbemErrPrivilegeNotHeld := -2147217310
    static wbemErrInvalidOperator := -2147217309
    static wbemErrLocalCredentials := -2147217308
    static wbemErrCannotBeAbstract := -2147217307
    static wbemErrAmendedObject := -2147217306
    static wbemErrClientTooSlow := -2147217305
    static wbemErrNullSecurityDescriptor := -2147217304
    static wbemErrTimeout := -2147217303
    static wbemErrInvalidAssociation := -2147217302
    static wbemErrAmbiguousOperation := -2147217301
    static wbemErrQuotaViolation := -2147217300
    static wbemErrTransactionConflict := -2147217299
    static wbemErrForcedRollback := -2147217298
    static wbemErrUnsupportedLocale := -2147217297
    static wbemErrHandleOutOfDate := -2147217296
    static wbemErrConnectionFailed := -2147217295
    static wbemErrInvalidHandleRequest := -2147217294
    static wbemErrPropertyNameTooWide := -2147217293
    static wbemErrClassNameTooWide := -2147217292
    static wbemErrMethodNameTooWide := -2147217291
    static wbemErrQualifierNameTooWide := -2147217290
    static wbemErrRerunCommand := -2147217289
    static wbemErrDatabaseVerMismatch := -2147217288
    static wbemErrVetoPut := -2147217287
    static wbemErrVetoDelete := -2147217286
    static wbemErrInvalidLocale := -2147217280
    static wbemErrProviderSuspended := -2147217279
    static wbemErrSynchronizationRequired := -2147217278
    static wbemErrNoSchema := -2147217277
    static wbemErrProviderAlreadyRegistered := -2147217276
    static wbemErrProviderNotRegistered := -2147217275
    static wbemErrFatalTransportError := -2147217274
    static wbemErrEncryptedConnectionRequired := -2147217273
    static wbemErrRegistrationTooBroad := -2147213311
    static wbemErrRegistrationTooPrecise := -2147213310
    static wbemErrTimedout := -2147209215
    static wbemErrResetToDefault := -2147209214
}
struct WbemAuthenticationLevelEnum extends Int32 {
    static wbemAuthenticationLevelDefault := 0
    static wbemAuthenticationLevelNone := 1
    static wbemAuthenticationLevelConnect := 2
    static wbemAuthenticationLevelCall := 3
    static wbemAuthenticationLevelPkt := 4
    static wbemAuthenticationLevelPktIntegrity := 5
    static wbemAuthenticationLevelPktPrivacy := 6
}
struct WbemImpersonationLevelEnum extends Int32 {
    static wbemImpersonationLevelAnonymous := 1
    static wbemImpersonationLevelIdentify := 2
    static wbemImpersonationLevelImpersonate := 3
    static wbemImpersonationLevelDelegate := 4
}
struct WbemPrivilegeEnum extends Int32 {
    static wbemPrivilegeCreateToken := 1
    static wbemPrivilegePrimaryToken := 2
    static wbemPrivilegeLockMemory := 3
    static wbemPrivilegeIncreaseQuota := 4
    static wbemPrivilegeMachineAccount := 5
    static wbemPrivilegeTcb := 6
    static wbemPrivilegeSecurity := 7
    static wbemPrivilegeTakeOwnership := 8
    static wbemPrivilegeLoadDriver := 9
    static wbemPrivilegeSystemProfile := 10
    static wbemPrivilegeSystemtime := 11
    static wbemPrivilegeProfileSingleProcess := 12
    static wbemPrivilegeIncreaseBasePriority := 13
    static wbemPrivilegeCreatePagefile := 14
    static wbemPrivilegeCreatePermanent := 15
    static wbemPrivilegeBackup := 16
    static wbemPrivilegeRestore := 17
    static wbemPrivilegeShutdown := 18
    static wbemPrivilegeDebug := 19
    static wbemPrivilegeAudit := 20
    static wbemPrivilegeSystemEnvironment := 21
    static wbemPrivilegeChangeNotify := 22
    static wbemPrivilegeRemoteShutdown := 23
    static wbemPrivilegeUndock := 24
    static wbemPrivilegeSyncAgent := 25
    static wbemPrivilegeEnableDelegation := 26
    static wbemPrivilegeManageVolume := 27
}
struct WbemObjectTextFormatEnum extends Int32 {
    static wbemObjectTextFormatCIMDTD20 := 1
    static wbemObjectTextFormatWMIDTD20 := 2
}
struct WbemConnectOptionsEnum extends Int32 {
    static wbemConnectFlagUseMaxWait := 128
}
struct ISWbemServices extends IDispatch {
    static IID := "{76A6415C-CB41-11D1-8B02-00600806D9B6}"
    Get(strObjectPath, iFlags, objWbemNamedValueSet, objWbemObject)
      => ComCall(7, this.p, BSTR, strObjectPath, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObject.Ptr, objWbemObject)
    GetAsync(objWbemSink, strObjectPath, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(8, this.p, IDispatch, objWbemSink, BSTR, strObjectPath, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    Delete(strObjectPath, iFlags, objWbemNamedValueSet)
      => ComCall(9, this.p, BSTR, strObjectPath, Int32, iFlags, IDispatch, objWbemNamedValueSet)
    DeleteAsync(objWbemSink, strObjectPath, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(10, this.p, IDispatch, objWbemSink, BSTR, strObjectPath, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    InstancesOf(strClass, iFlags, objWbemNamedValueSet, objWbemObjectSet)
      => ComCall(11, this.p, BSTR, strClass, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObjectSet.Ptr, objWbemObjectSet)
    InstancesOfAsync(objWbemSink, strClass, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(12, this.p, IDispatch, objWbemSink, BSTR, strClass, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    SubclassesOf(strSuperclass, iFlags, objWbemNamedValueSet, objWbemObjectSet)
      => ComCall(13, this.p, BSTR, strSuperclass, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObjectSet.Ptr, objWbemObjectSet)
    SubclassesOfAsync(objWbemSink, strSuperclass, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(14, this.p, IDispatch, objWbemSink, BSTR, strSuperclass, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    ExecQuery(strQuery, strQueryLanguage, iFlags, objWbemNamedValueSet, objWbemObjectSet)
      => ComCall(15, this.p, BSTR, strQuery, BSTR, strQueryLanguage, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObjectSet.Ptr, objWbemObjectSet)
    ExecQueryAsync(objWbemSink, strQuery, strQueryLanguage, lFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(16, this.p, IDispatch, objWbemSink, BSTR, strQuery, BSTR, strQueryLanguage, Int32, lFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    AssociatorsOf(strObjectPath, strAssocClass, strResultClass, strResultRole, strRole, bClassesOnly, bSchemaOnly, strRequiredAssocQualifier, strRequiredQualifier, iFlags, objWbemNamedValueSet, objWbemObjectSet)
      => ComCall(17, this.p, BSTR, strObjectPath, BSTR, strAssocClass, BSTR, strResultClass, BSTR, strResultRole, BSTR, strRole, VARIANT_BOOL, bClassesOnly, VARIANT_BOOL, bSchemaOnly, BSTR, strRequiredAssocQualifier, BSTR, strRequiredQualifier, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObjectSet.Ptr, objWbemObjectSet)
    AssociatorsOfAsync(objWbemSink, strObjectPath, strAssocClass, strResultClass, strResultRole, strRole, bClassesOnly, bSchemaOnly, strRequiredAssocQualifier, strRequiredQualifier, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(18, this.p, IDispatch, objWbemSink, BSTR, strObjectPath, BSTR, strAssocClass, BSTR, strResultClass, BSTR, strResultRole, BSTR, strRole, VARIANT_BOOL, bClassesOnly, VARIANT_BOOL, bSchemaOnly, BSTR, strRequiredAssocQualifier, BSTR, strRequiredQualifier, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    ReferencesTo(strObjectPath, strResultClass, strRole, bClassesOnly, bSchemaOnly, strRequiredQualifier, iFlags, objWbemNamedValueSet, objWbemObjectSet)
      => ComCall(19, this.p, BSTR, strObjectPath, BSTR, strResultClass, BSTR, strRole, VARIANT_BOOL, bClassesOnly, VARIANT_BOOL, bSchemaOnly, BSTR, strRequiredQualifier, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObjectSet.Ptr, objWbemObjectSet)
    ReferencesToAsync(objWbemSink, strObjectPath, strResultClass, strRole, bClassesOnly, bSchemaOnly, strRequiredQualifier, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(20, this.p, IDispatch, objWbemSink, BSTR, strObjectPath, BSTR, strResultClass, BSTR, strRole, VARIANT_BOOL, bClassesOnly, VARIANT_BOOL, bSchemaOnly, BSTR, strRequiredQualifier, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    ExecNotificationQuery(strQuery, strQueryLanguage, iFlags, objWbemNamedValueSet, objWbemEventSource)
      => ComCall(21, this.p, BSTR, strQuery, BSTR, strQueryLanguage, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemEventSource.Ptr, objWbemEventSource)
    ExecNotificationQueryAsync(objWbemSink, strQuery, strQueryLanguage, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(22, this.p, IDispatch, objWbemSink, BSTR, strQuery, BSTR, strQueryLanguage, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    ExecMethod(strObjectPath, strMethodName, objWbemInParameters, iFlags, objWbemNamedValueSet, objWbemOutParameters)
      => ComCall(23, this.p, BSTR, strObjectPath, BSTR, strMethodName, IDispatch, objWbemInParameters, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObject.Ptr, objWbemOutParameters)
    ExecMethodAsync(objWbemSink, strObjectPath, strMethodName, objWbemInParameters, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(24, this.p, IDispatch, objWbemSink, BSTR, strObjectPath, BSTR, strMethodName, IDispatch, objWbemInParameters, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    get_Security_(objWbemSecurity)
      => ComCall(25, this.p, ISWbemSecurity.Ptr, objWbemSecurity)
}
struct ISWbemLocator extends IDispatch {
    static IID := "{76A6415B-CB41-11D1-8B02-00600806D9B6}"
    ConnectServer(strServer, strNamespace, strUser, strPassword, strLocale, strAuthority, iSecurityFlags, objWbemNamedValueSet, objWbemServices)
      => ComCall(7, this.p, BSTR, strServer, BSTR, strNamespace, BSTR, strUser, BSTR, strPassword, BSTR, strLocale, BSTR, strAuthority, Int32, iSecurityFlags, IDispatch, objWbemNamedValueSet, ISWbemServices.Ptr, objWbemServices)
    get_Security_(objWbemSecurity)
      => ComCall(8, this.p, ISWbemSecurity.Ptr, objWbemSecurity)
}
struct ISWbemObject extends IDispatch {
    static IID := "{76A6415A-CB41-11D1-8B02-00600806D9B6}"
    Put_(iFlags, objWbemNamedValueSet, objWbemObjectPath)
      => ComCall(7, this.p, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObjectPath.Ptr, objWbemObjectPath)
    PutAsync_(objWbemSink, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(8, this.p, IDispatch, objWbemSink, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    Delete_(iFlags, objWbemNamedValueSet)
      => ComCall(9, this.p, Int32, iFlags, IDispatch, objWbemNamedValueSet)
    DeleteAsync_(objWbemSink, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(10, this.p, IDispatch, objWbemSink, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    Instances_(iFlags, objWbemNamedValueSet, objWbemObjectSet)
      => ComCall(11, this.p, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObjectSet.Ptr, objWbemObjectSet)
    InstancesAsync_(objWbemSink, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(12, this.p, IDispatch, objWbemSink, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    Subclasses_(iFlags, objWbemNamedValueSet, objWbemObjectSet)
      => ComCall(13, this.p, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObjectSet.Ptr, objWbemObjectSet)
    SubclassesAsync_(objWbemSink, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(14, this.p, IDispatch, objWbemSink, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    Associators_(strAssocClass, strResultClass, strResultRole, strRole, bClassesOnly, bSchemaOnly, strRequiredAssocQualifier, strRequiredQualifier, iFlags, objWbemNamedValueSet, objWbemObjectSet)
      => ComCall(15, this.p, BSTR, strAssocClass, BSTR, strResultClass, BSTR, strResultRole, BSTR, strRole, VARIANT_BOOL, bClassesOnly, VARIANT_BOOL, bSchemaOnly, BSTR, strRequiredAssocQualifier, BSTR, strRequiredQualifier, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObjectSet.Ptr, objWbemObjectSet)
    AssociatorsAsync_(objWbemSink, strAssocClass, strResultClass, strResultRole, strRole, bClassesOnly, bSchemaOnly, strRequiredAssocQualifier, strRequiredQualifier, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(16, this.p, IDispatch, objWbemSink, BSTR, strAssocClass, BSTR, strResultClass, BSTR, strResultRole, BSTR, strRole, VARIANT_BOOL, bClassesOnly, VARIANT_BOOL, bSchemaOnly, BSTR, strRequiredAssocQualifier, BSTR, strRequiredQualifier, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    References_(strResultClass, strRole, bClassesOnly, bSchemaOnly, strRequiredQualifier, iFlags, objWbemNamedValueSet, objWbemObjectSet)
      => ComCall(17, this.p, BSTR, strResultClass, BSTR, strRole, VARIANT_BOOL, bClassesOnly, VARIANT_BOOL, bSchemaOnly, BSTR, strRequiredQualifier, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObjectSet.Ptr, objWbemObjectSet)
    ReferencesAsync_(objWbemSink, strResultClass, strRole, bClassesOnly, bSchemaOnly, strRequiredQualifier, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(18, this.p, IDispatch, objWbemSink, BSTR, strResultClass, BSTR, strRole, VARIANT_BOOL, bClassesOnly, VARIANT_BOOL, bSchemaOnly, BSTR, strRequiredQualifier, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    ExecMethod_(strMethodName, objWbemInParameters, iFlags, objWbemNamedValueSet, objWbemOutParameters)
      => ComCall(19, this.p, BSTR, strMethodName, IDispatch, objWbemInParameters, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObject.Ptr, objWbemOutParameters)
    ExecMethodAsync_(objWbemSink, strMethodName, objWbemInParameters, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(20, this.p, IDispatch, objWbemSink, BSTR, strMethodName, IDispatch, objWbemInParameters, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
    Clone_(objWbemObject)
      => ComCall(21, this.p, ISWbemObject.Ptr, objWbemObject)
    GetObjectText_(iFlags, strObjectText)
      => ComCall(22, this.p, Int32, iFlags, BSTR.Ptr, strObjectText)
    SpawnDerivedClass_(iFlags, objWbemObject)
      => ComCall(23, this.p, Int32, iFlags, ISWbemObject.Ptr, objWbemObject)
    SpawnInstance_(iFlags, objWbemObject)
      => ComCall(24, this.p, Int32, iFlags, ISWbemObject.Ptr, objWbemObject)
    CompareTo_(objWbemObject, iFlags, bResult)
      => ComCall(25, this.p, IDispatch, objWbemObject, Int32, iFlags, VARIANT_BOOL.Ptr, bResult)
    get_Qualifiers_(objWbemQualifierSet)
      => ComCall(26, this.p, ISWbemQualifierSet.Ptr, objWbemQualifierSet)
    get_Properties_(objWbemPropertySet)
      => ComCall(27, this.p, ISWbemPropertySet.Ptr, objWbemPropertySet)
    get_Methods_(objWbemMethodSet)
      => ComCall(28, this.p, ISWbemMethodSet.Ptr, objWbemMethodSet)
    get_Derivation_(strClassNameArray)
      => ComCall(29, this.p, VARIANT.Ptr, strClassNameArray)
    get_Path_(objWbemObjectPath)
      => ComCall(30, this.p, ISWbemObjectPath.Ptr, objWbemObjectPath)
    get_Security_(objWbemSecurity)
      => ComCall(31, this.p, ISWbemSecurity.Ptr, objWbemSecurity)
}
struct ISWbemObjectSet extends IDispatch {
    static IID := "{76A6415F-CB41-11D1-8B02-00600806D9B6}"
    get__NewEnum(pUnk)
      => ComCall(7, this.p, IUnknown.Ptr, pUnk)
    Item(strObjectPath, iFlags, objWbemObject)
      => ComCall(8, this.p, BSTR, strObjectPath, Int32, iFlags, ISWbemObject.Ptr, objWbemObject)
    get_Count(iCount)
      => ComCall(9, this.p, Int32.Ptr, iCount)
    get_Security_(objWbemSecurity)
      => ComCall(10, this.p, ISWbemSecurity.Ptr, objWbemSecurity)
    ItemIndex(lIndex, objWbemObject)
      => ComCall(11, this.p, Int32, lIndex, ISWbemObject.Ptr, objWbemObject)
}
struct ISWbemNamedValue extends IDispatch {
    static IID := "{76A64164-CB41-11D1-8B02-00600806D9B6}"
    get_Value(varValue)
      => ComCall(7, this.p, VARIANT.Ptr, varValue)
    put_Value(varValue)
      => ComCall(8, this.p, VARIANT.Ptr, varValue)
    get_Name(strName)
      => ComCall(9, this.p, BSTR.Ptr, strName)
}
struct ISWbemNamedValueSet extends IDispatch {
    static IID := "{CF2376EA-CE8C-11D1-8B05-00600806D9B6}"
    get__NewEnum(pUnk)
      => ComCall(7, this.p, IUnknown.Ptr, pUnk)
    Item(strName, iFlags, objWbemNamedValue)
      => ComCall(8, this.p, BSTR, strName, Int32, iFlags, ISWbemNamedValue.Ptr, objWbemNamedValue)
    get_Count(iCount)
      => ComCall(9, this.p, Int32.Ptr, iCount)
    Add(strName, varValue, iFlags, objWbemNamedValue)
      => ComCall(10, this.p, BSTR, strName, VARIANT.Ptr, varValue, Int32, iFlags, ISWbemNamedValue.Ptr, objWbemNamedValue)
    Remove(strName, iFlags)
      => ComCall(11, this.p, BSTR, strName, Int32, iFlags)
    Clone(objWbemNamedValueSet)
      => ComCall(12, this.p, ISWbemNamedValueSet.Ptr, objWbemNamedValueSet)
    DeleteAll()
      => ComCall(13, this.p)
}
struct ISWbemQualifier extends IDispatch {
    static IID := "{79B05932-D3B7-11D1-8B06-00600806D9B6}"
    get_Value(varValue)
      => ComCall(7, this.p, VARIANT.Ptr, varValue)
    put_Value(varValue)
      => ComCall(8, this.p, VARIANT.Ptr, varValue)
    get_Name(strName)
      => ComCall(9, this.p, BSTR.Ptr, strName)
    get_IsLocal(bIsLocal)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, bIsLocal)
    get_PropagatesToSubclass(bPropagatesToSubclass)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, bPropagatesToSubclass)
    put_PropagatesToSubclass(bPropagatesToSubclass)
      => ComCall(12, this.p, VARIANT_BOOL, bPropagatesToSubclass)
    get_PropagatesToInstance(bPropagatesToInstance)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, bPropagatesToInstance)
    put_PropagatesToInstance(bPropagatesToInstance)
      => ComCall(14, this.p, VARIANT_BOOL, bPropagatesToInstance)
    get_IsOverridable(bIsOverridable)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, bIsOverridable)
    put_IsOverridable(bIsOverridable)
      => ComCall(16, this.p, VARIANT_BOOL, bIsOverridable)
    get_IsAmended(bIsAmended)
      => ComCall(17, this.p, VARIANT_BOOL.Ptr, bIsAmended)
}
struct ISWbemQualifierSet extends IDispatch {
    static IID := "{9B16ED16-D3DF-11D1-8B08-00600806D9B6}"
    get__NewEnum(pUnk)
      => ComCall(7, this.p, IUnknown.Ptr, pUnk)
    Item(name, iFlags, objWbemQualifier)
      => ComCall(8, this.p, BSTR, name, Int32, iFlags, ISWbemQualifier.Ptr, objWbemQualifier)
    get_Count(iCount)
      => ComCall(9, this.p, Int32.Ptr, iCount)
    Add(strName, varVal, bPropagatesToSubclass, bPropagatesToInstance, bIsOverridable, iFlags, objWbemQualifier)
      => ComCall(10, this.p, BSTR, strName, VARIANT.Ptr, varVal, VARIANT_BOOL, bPropagatesToSubclass, VARIANT_BOOL, bPropagatesToInstance, VARIANT_BOOL, bIsOverridable, Int32, iFlags, ISWbemQualifier.Ptr, objWbemQualifier)
    Remove(strName, iFlags)
      => ComCall(11, this.p, BSTR, strName, Int32, iFlags)
}
struct ISWbemProperty extends IDispatch {
    static IID := "{1A388F98-D4BA-11D1-8B09-00600806D9B6}"
    get_Value(varValue)
      => ComCall(7, this.p, VARIANT.Ptr, varValue)
    put_Value(varValue)
      => ComCall(8, this.p, VARIANT.Ptr, varValue)
    get_Name(strName)
      => ComCall(9, this.p, BSTR.Ptr, strName)
    get_IsLocal(bIsLocal)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, bIsLocal)
    get_Origin(strOrigin)
      => ComCall(11, this.p, BSTR.Ptr, strOrigin)
    get_CIMType(iCimType)
      => ComCall(12, this.p, WbemCimtypeEnum.Ptr, iCimType)
    get_Qualifiers_(objWbemQualifierSet)
      => ComCall(13, this.p, ISWbemQualifierSet.Ptr, objWbemQualifierSet)
    get_IsArray(bIsArray)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, bIsArray)
}
struct ISWbemPropertySet extends IDispatch {
    static IID := "{DEA0A7B2-D4BA-11D1-8B09-00600806D9B6}"
    get__NewEnum(pUnk)
      => ComCall(7, this.p, IUnknown.Ptr, pUnk)
    Item(strName, iFlags, objWbemProperty)
      => ComCall(8, this.p, BSTR, strName, Int32, iFlags, ISWbemProperty.Ptr, objWbemProperty)
    get_Count(iCount)
      => ComCall(9, this.p, Int32.Ptr, iCount)
    Add(strName, iCIMType, bIsArray, iFlags, objWbemProperty)
      => ComCall(10, this.p, BSTR, strName, WbemCimtypeEnum, iCIMType, VARIANT_BOOL, bIsArray, Int32, iFlags, ISWbemProperty.Ptr, objWbemProperty)
    Remove(strName, iFlags)
      => ComCall(11, this.p, BSTR, strName, Int32, iFlags)
}
struct ISWbemMethod extends IDispatch {
    static IID := "{422E8E90-D955-11D1-8B09-00600806D9B6}"
    get_Name(strName)
      => ComCall(7, this.p, BSTR.Ptr, strName)
    get_Origin(strOrigin)
      => ComCall(8, this.p, BSTR.Ptr, strOrigin)
    get_InParameters(objWbemInParameters)
      => ComCall(9, this.p, ISWbemObject.Ptr, objWbemInParameters)
    get_OutParameters(objWbemOutParameters)
      => ComCall(10, this.p, ISWbemObject.Ptr, objWbemOutParameters)
    get_Qualifiers_(objWbemQualifierSet)
      => ComCall(11, this.p, ISWbemQualifierSet.Ptr, objWbemQualifierSet)
}
struct ISWbemMethodSet extends IDispatch {
    static IID := "{C93BA292-D955-11D1-8B09-00600806D9B6}"
    get__NewEnum(pUnk)
      => ComCall(7, this.p, IUnknown.Ptr, pUnk)
    Item(strName, iFlags, objWbemMethod)
      => ComCall(8, this.p, BSTR, strName, Int32, iFlags, ISWbemMethod.Ptr, objWbemMethod)
    get_Count(iCount)
      => ComCall(9, this.p, Int32.Ptr, iCount)
}
struct ISWbemEventSource extends IDispatch {
    static IID := "{27D54D92-0EBE-11D2-8B22-00600806D9B6}"
    NextEvent(iTimeoutMs, objWbemObject)
      => ComCall(7, this.p, Int32, iTimeoutMs, ISWbemObject.Ptr, objWbemObject)
    get_Security_(objWbemSecurity)
      => ComCall(8, this.p, ISWbemSecurity.Ptr, objWbemSecurity)
}
struct ISWbemObjectPath extends IDispatch {
    static IID := "{5791BC27-CE9C-11D1-97BF-0000F81E849C}"
    get_Path(strPath)
      => ComCall(7, this.p, BSTR.Ptr, strPath)
    put_Path(strPath)
      => ComCall(8, this.p, BSTR, strPath)
    get_RelPath(strRelPath)
      => ComCall(9, this.p, BSTR.Ptr, strRelPath)
    put_RelPath(strRelPath)
      => ComCall(10, this.p, BSTR, strRelPath)
    get_Server(strServer)
      => ComCall(11, this.p, BSTR.Ptr, strServer)
    put_Server(strServer)
      => ComCall(12, this.p, BSTR, strServer)
    get_Namespace(strNamespace)
      => ComCall(13, this.p, BSTR.Ptr, strNamespace)
    put_Namespace(strNamespace)
      => ComCall(14, this.p, BSTR, strNamespace)
    get_ParentNamespace(strParentNamespace)
      => ComCall(15, this.p, BSTR.Ptr, strParentNamespace)
    get_DisplayName(strDisplayName)
      => ComCall(16, this.p, BSTR.Ptr, strDisplayName)
    put_DisplayName(strDisplayName)
      => ComCall(17, this.p, BSTR, strDisplayName)
    get_Class(strClass)
      => ComCall(18, this.p, BSTR.Ptr, strClass)
    put_Class(strClass)
      => ComCall(19, this.p, BSTR, strClass)
    get_IsClass(bIsClass)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, bIsClass)
    SetAsClass()
      => ComCall(21, this.p)
    get_IsSingleton(bIsSingleton)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, bIsSingleton)
    SetAsSingleton()
      => ComCall(23, this.p)
    get_Keys(objWbemNamedValueSet)
      => ComCall(24, this.p, ISWbemNamedValueSet.Ptr, objWbemNamedValueSet)
    get_Security_(objWbemSecurity)
      => ComCall(25, this.p, ISWbemSecurity.Ptr, objWbemSecurity)
    get_Locale(strLocale)
      => ComCall(26, this.p, BSTR.Ptr, strLocale)
    put_Locale(strLocale)
      => ComCall(27, this.p, BSTR, strLocale)
    get_Authority(strAuthority)
      => ComCall(28, this.p, BSTR.Ptr, strAuthority)
    put_Authority(strAuthority)
      => ComCall(29, this.p, BSTR, strAuthority)
}
struct ISWbemLastError extends ISWbemObject {
    static IID := "{D962DB84-D4BB-11D1-8B09-00600806D9B6}"
}
struct ISWbemSinkEvents extends IDispatch {
    static IID := "{75718CA0-F029-11D1-A1AC-00C04FB6C223}"
}
struct ISWbemSink extends IDispatch {
    static IID := "{75718C9F-F029-11D1-A1AC-00C04FB6C223}"
    Cancel()
      => ComCall(7, this.p)
}
struct ISWbemSecurity extends IDispatch {
    static IID := "{B54D66E6-2287-11D2-8B33-00600806D9B6}"
    get_ImpersonationLevel(iImpersonationLevel)
      => ComCall(7, this.p, WbemImpersonationLevelEnum.Ptr, iImpersonationLevel)
    put_ImpersonationLevel(iImpersonationLevel)
      => ComCall(8, this.p, WbemImpersonationLevelEnum, iImpersonationLevel)
    get_AuthenticationLevel(iAuthenticationLevel)
      => ComCall(9, this.p, WbemAuthenticationLevelEnum.Ptr, iAuthenticationLevel)
    put_AuthenticationLevel(iAuthenticationLevel)
      => ComCall(10, this.p, WbemAuthenticationLevelEnum, iAuthenticationLevel)
    get_Privileges(objWbemPrivilegeSet)
      => ComCall(11, this.p, ISWbemPrivilegeSet.Ptr, objWbemPrivilegeSet)
}
struct ISWbemPrivilege extends IDispatch {
    static IID := "{26EE67BD-5804-11D2-8B4A-00600806D9B6}"
    get_IsEnabled(bIsEnabled)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, bIsEnabled)
    put_IsEnabled(bIsEnabled)
      => ComCall(8, this.p, VARIANT_BOOL, bIsEnabled)
    get_Name(strDisplayName)
      => ComCall(9, this.p, BSTR.Ptr, strDisplayName)
    get_DisplayName(strDisplayName)
      => ComCall(10, this.p, BSTR.Ptr, strDisplayName)
    get_Identifier(iPrivilege)
      => ComCall(11, this.p, WbemPrivilegeEnum.Ptr, iPrivilege)
}
struct ISWbemPrivilegeSet extends IDispatch {
    static IID := "{26EE67BF-5804-11D2-8B4A-00600806D9B6}"
    get__NewEnum(pUnk)
      => ComCall(7, this.p, IUnknown.Ptr, pUnk)
    Item(iPrivilege, objWbemPrivilege)
      => ComCall(8, this.p, WbemPrivilegeEnum, iPrivilege, ISWbemPrivilege.Ptr, objWbemPrivilege)
    get_Count(iCount)
      => ComCall(9, this.p, Int32.Ptr, iCount)
    Add(iPrivilege, bIsEnabled, objWbemPrivilege)
      => ComCall(10, this.p, WbemPrivilegeEnum, iPrivilege, VARIANT_BOOL, bIsEnabled, ISWbemPrivilege.Ptr, objWbemPrivilege)
    Remove(iPrivilege)
      => ComCall(11, this.p, WbemPrivilegeEnum, iPrivilege)
    DeleteAll()
      => ComCall(12, this.p)
    AddAsString(strPrivilege, bIsEnabled, objWbemPrivilege)
      => ComCall(13, this.p, BSTR, strPrivilege, VARIANT_BOOL, bIsEnabled, ISWbemPrivilege.Ptr, objWbemPrivilege)
}
struct ISWbemServicesEx extends ISWbemServices {
    static IID := "{D2F68443-85DC-427E-91D8-366554CC754C}"
    Put(objWbemObject, iFlags, objWbemNamedValueSet, objWbemObjectPath)
      => ComCall(26, this.p, ISWbemObjectEx, objWbemObject, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemObjectPath.Ptr, objWbemObjectPath)
    PutAsync(objWbemSink, objWbemObject, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
      => ComCall(27, this.p, ISWbemSink, objWbemSink, ISWbemObjectEx, objWbemObject, Int32, iFlags, IDispatch, objWbemNamedValueSet, IDispatch, objWbemAsyncContext)
}
struct ISWbemObjectEx extends ISWbemObject {
    static IID := "{269AD56A-8A67-4129-BC8C-0506DCFE9880}"
    Refresh_(iFlags, objWbemNamedValueSet)
      => ComCall(32, this.p, Int32, iFlags, IDispatch, objWbemNamedValueSet)
    get_SystemProperties_(objWbemPropertySet)
      => ComCall(33, this.p, ISWbemPropertySet.Ptr, objWbemPropertySet)
    GetText_(iObjectTextFormat, iFlags, objWbemNamedValueSet, bsText)
      => ComCall(34, this.p, WbemObjectTextFormatEnum, iObjectTextFormat, Int32, iFlags, IDispatch, objWbemNamedValueSet, BSTR.Ptr, bsText)
    SetFromText_(bsText, iObjectTextFormat, iFlags, objWbemNamedValueSet)
      => ComCall(35, this.p, BSTR, bsText, WbemObjectTextFormatEnum, iObjectTextFormat, Int32, iFlags, IDispatch, objWbemNamedValueSet)
}
struct ISWbemDateTime extends IDispatch {
    static IID := "{5E97458A-CF77-11D3-B38F-00105A1F473A}"
    get_Value(strValue)
      => ComCall(7, this.p, BSTR.Ptr, strValue)
    put_Value(strValue)
      => ComCall(8, this.p, BSTR, strValue)
    get_Year(iYear)
      => ComCall(9, this.p, Int32.Ptr, iYear)
    put_Year(iYear)
      => ComCall(10, this.p, Int32, iYear)
    get_YearSpecified(bYearSpecified)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, bYearSpecified)
    put_YearSpecified(bYearSpecified)
      => ComCall(12, this.p, VARIANT_BOOL, bYearSpecified)
    get_Month(iMonth)
      => ComCall(13, this.p, Int32.Ptr, iMonth)
    put_Month(iMonth)
      => ComCall(14, this.p, Int32, iMonth)
    get_MonthSpecified(bMonthSpecified)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, bMonthSpecified)
    put_MonthSpecified(bMonthSpecified)
      => ComCall(16, this.p, VARIANT_BOOL, bMonthSpecified)
    get_Day(iDay)
      => ComCall(17, this.p, Int32.Ptr, iDay)
    put_Day(iDay)
      => ComCall(18, this.p, Int32, iDay)
    get_DaySpecified(bDaySpecified)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, bDaySpecified)
    put_DaySpecified(bDaySpecified)
      => ComCall(20, this.p, VARIANT_BOOL, bDaySpecified)
    get_Hours(iHours)
      => ComCall(21, this.p, Int32.Ptr, iHours)
    put_Hours(iHours)
      => ComCall(22, this.p, Int32, iHours)
    get_HoursSpecified(bHoursSpecified)
      => ComCall(23, this.p, VARIANT_BOOL.Ptr, bHoursSpecified)
    put_HoursSpecified(bHoursSpecified)
      => ComCall(24, this.p, VARIANT_BOOL, bHoursSpecified)
    get_Minutes(iMinutes)
      => ComCall(25, this.p, Int32.Ptr, iMinutes)
    put_Minutes(iMinutes)
      => ComCall(26, this.p, Int32, iMinutes)
    get_MinutesSpecified(bMinutesSpecified)
      => ComCall(27, this.p, VARIANT_BOOL.Ptr, bMinutesSpecified)
    put_MinutesSpecified(bMinutesSpecified)
      => ComCall(28, this.p, VARIANT_BOOL, bMinutesSpecified)
    get_Seconds(iSeconds)
      => ComCall(29, this.p, Int32.Ptr, iSeconds)
    put_Seconds(iSeconds)
      => ComCall(30, this.p, Int32, iSeconds)
    get_SecondsSpecified(bSecondsSpecified)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, bSecondsSpecified)
    put_SecondsSpecified(bSecondsSpecified)
      => ComCall(32, this.p, VARIANT_BOOL, bSecondsSpecified)
    get_Microseconds(iMicroseconds)
      => ComCall(33, this.p, Int32.Ptr, iMicroseconds)
    put_Microseconds(iMicroseconds)
      => ComCall(34, this.p, Int32, iMicroseconds)
    get_MicrosecondsSpecified(bMicrosecondsSpecified)
      => ComCall(35, this.p, VARIANT_BOOL.Ptr, bMicrosecondsSpecified)
    put_MicrosecondsSpecified(bMicrosecondsSpecified)
      => ComCall(36, this.p, VARIANT_BOOL, bMicrosecondsSpecified)
    get_UTC(iUTC)
      => ComCall(37, this.p, Int32.Ptr, iUTC)
    put_UTC(iUTC)
      => ComCall(38, this.p, Int32, iUTC)
    get_UTCSpecified(bUTCSpecified)
      => ComCall(39, this.p, VARIANT_BOOL.Ptr, bUTCSpecified)
    put_UTCSpecified(bUTCSpecified)
      => ComCall(40, this.p, VARIANT_BOOL, bUTCSpecified)
    get_IsInterval(bIsInterval)
      => ComCall(41, this.p, VARIANT_BOOL.Ptr, bIsInterval)
    put_IsInterval(bIsInterval)
      => ComCall(42, this.p, VARIANT_BOOL, bIsInterval)
    GetVarDate(bIsLocal, dVarDate)
      => ComCall(43, this.p, VARIANT_BOOL, bIsLocal, Float64.Ptr, dVarDate)
    SetVarDate(dVarDate, bIsLocal)
      => ComCall(44, this.p, Float64, dVarDate, VARIANT_BOOL, bIsLocal)
    GetFileTime(bIsLocal, strFileTime)
      => ComCall(45, this.p, VARIANT_BOOL, bIsLocal, BSTR.Ptr, strFileTime)
    SetFileTime(strFileTime, bIsLocal)
      => ComCall(46, this.p, BSTR, strFileTime, VARIANT_BOOL, bIsLocal)
}
struct ISWbemRefresher extends IDispatch {
    static IID := "{14D8250E-D9C2-11D3-B38F-00105A1F473A}"
    get__NewEnum(pUnk)
      => ComCall(7, this.p, IUnknown.Ptr, pUnk)
    Item(iIndex, objWbemRefreshableItem)
      => ComCall(8, this.p, Int32, iIndex, ISWbemRefreshableItem.Ptr, objWbemRefreshableItem)
    get_Count(iCount)
      => ComCall(9, this.p, Int32.Ptr, iCount)
    Add(objWbemServices, bsInstancePath, iFlags, objWbemNamedValueSet, objWbemRefreshableItem)
      => ComCall(10, this.p, ISWbemServicesEx, objWbemServices, BSTR, bsInstancePath, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemRefreshableItem.Ptr, objWbemRefreshableItem)
    AddEnum(objWbemServices, bsClassName, iFlags, objWbemNamedValueSet, objWbemRefreshableItem)
      => ComCall(11, this.p, ISWbemServicesEx, objWbemServices, BSTR, bsClassName, Int32, iFlags, IDispatch, objWbemNamedValueSet, ISWbemRefreshableItem.Ptr, objWbemRefreshableItem)
    Remove(iIndex, iFlags)
      => ComCall(12, this.p, Int32, iIndex, Int32, iFlags)
    Refresh(iFlags)
      => ComCall(13, this.p, Int32, iFlags)
    get_AutoReconnect(bCount)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, bCount)
    put_AutoReconnect(bCount)
      => ComCall(15, this.p, VARIANT_BOOL, bCount)
    DeleteAll()
      => ComCall(16, this.p)
}
struct ISWbemRefreshableItem extends IDispatch {
    static IID := "{5AD4BF92-DAAB-11D3-B38F-00105A1F473A}"
    get_Index(iIndex)
      => ComCall(7, this.p, Int32.Ptr, iIndex)
    get_Refresher(objWbemRefresher)
      => ComCall(8, this.p, ISWbemRefresher.Ptr, objWbemRefresher)
    get_IsSet(bIsSet)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, bIsSet)
    get_Object(objWbemObject)
      => ComCall(10, this.p, ISWbemObjectEx.Ptr, objWbemObject)
    get_ObjectSet(objWbemObjectSet)
      => ComCall(11, this.p, ISWbemObjectSet.Ptr, objWbemObjectSet)
    Remove(iFlags)
      => ComCall(12, this.p, Int32, iFlags)
}
struct IWMIExtension extends IDispatch {
    static IID := "{ADC1F06E-5C7E-11D2-8B74-00104B2AFB41}"
    get_WMIObjectPath(strWMIObjectPath)
      => ComCall(7, this.p, BSTR.Ptr, strWMIObjectPath)
    GetWMIObject(objWMIObject)
      => ComCall(8, this.p, ISWbemObject.Ptr, objWMIObject)
    GetWMIServices(objWMIServices)
      => ComCall(9, this.p, ISWbemServices.Ptr, objWMIServices)
}
struct WBEM_LOGIN_TYPE extends Int32 {
    static WBEM_FLAG_INPROC_LOGIN := 0
    static WBEM_FLAG_LOCAL_LOGIN := 1
    static WBEM_FLAG_REMOTE_LOGIN := 2
    static WBEM_AUTHENTICATION_METHOD_MASK := 15
    static WBEM_FLAG_USE_MULTIPLE_CHALLENGES := 16
}
struct IWbemTransport extends IUnknown {
    static IID := "{553FE584-2156-11D0-B6AE-00AA003240C7}"
    Initialize()
      => ComCall(3, this.p)
}
struct IWbemLevel1Login extends IUnknown {
    static IID := "{F309AD18-D86A-11D0-A075-00C04FB68820}"
    EstablishPosition(wszLocaleList, dwNumLocales, reserved)
      => ComCall(3, this.p, "Str", wszLocaleList, UInt32, dwNumLocales, UInt32.Ptr, reserved)
    RequestChallenge(wszNetworkResource, wszUser, Nonce)
      => ComCall(4, this.p, "Str", wszNetworkResource, "Str", wszUser, UInt8.Ptr, Nonce)
    WBEMLogin(wszPreferredLocale, AccessToken, lFlags, pCtx, ppNamespace)
      => ComCall(5, this.p, "Str", wszPreferredLocale, UInt8.Ptr, AccessToken, Int32, lFlags, IWbemContext, pCtx, IWbemServices.Ptr, ppNamespace)
    NTLMLogin(wszNetworkResource, wszPreferredLocale, lFlags, pCtx, ppNamespace)
      => ComCall(6, this.p, "Str", wszNetworkResource, "Str", wszPreferredLocale, Int32, lFlags, IWbemContext, pCtx, IWbemServices.Ptr, ppNamespace)
}
struct IWbemConnectorLogin extends IUnknown {
    static IID := "{D8EC9CB1-B135-4F10-8B1B-C7188BB0D186}"
    ConnectorLogin(wszNetworkResource, wszPreferredLocale, lFlags, pCtx, riid, pInterface)
      => ComCall(3, this.p, "Str", wszNetworkResource, "Str", wszPreferredLocale, Int32, lFlags, IWbemContext, pCtx, GUID.Ptr, riid, Struct.Ptr.Ptr, pInterface)
}
struct IWbemAddressResolution extends IUnknown {
    static IID := "{F7CE2E12-8C90-11D1-9E7B-00C04FC324A8}"
    Resolve(wszNamespacePath, wszAddressType, pdwAddressLength, pabBinaryAddress)
      => ComCall(3, this.p, "Str", wszNamespacePath, PWSTR, wszAddressType, UInt32.Ptr, pdwAddressLength, UInt8.Ptr.Ptr, pabBinaryAddress)
}
struct IWbemClientTransport extends IUnknown {
    static IID := "{F7CE2E11-8C90-11D1-9E7B-00C04FC324A8}"
    ConnectServer(strAddressType, abBinaryAddress, strNetworkResource, strUser, strPassword, strLocale, lSecurityFlags, strAuthority, pCtx, ppNamespace)
      => ComCall(3, this.p, BSTR, strAddressType, UInt32, abBinaryAddress.Length, UInt8.Ptr, abBinaryAddress, BSTR, strNetworkResource, BSTR, strUser, BSTR, strPassword, BSTR, strLocale, Int32, lSecurityFlags, BSTR, strAuthority, IWbemContext, pCtx, IWbemServices.Ptr, ppNamespace)
}
struct IWbemClientConnectionTransport extends IUnknown {
    static IID := "{A889C72A-FCC1-4A9E-AF61-ED071333FB5B}"
    Open(strAddressType, abBinaryAddress, strObject, strUser, strPassword, strLocale, lFlags, pCtx, riid, pInterface, pCallRes)
      => ComCall(3, this.p, BSTR, strAddressType, UInt32, abBinaryAddress.Length, UInt8.Ptr, abBinaryAddress, BSTR, strObject, BSTR, strUser, BSTR, strPassword, BSTR, strLocale, Int32, lFlags, IWbemContext, pCtx, GUID.Ptr, riid, Struct.Ptr.Ptr, pInterface, IWbemCallResult.Ptr, pCallRes)
    OpenAsync(strAddressType, abBinaryAddress, strObject, strUser, strPassword, strLocale, lFlags, pCtx, riid, pResponseHandler)
      => ComCall(4, this.p, BSTR, strAddressType, UInt32, abBinaryAddress.Length, UInt8.Ptr, abBinaryAddress, BSTR, strObject, BSTR, strUser, BSTR, strPassword, BSTR, strLocale, Int32, lFlags, IWbemContext, pCtx, GUID.Ptr, riid, IWbemObjectSink, pResponseHandler)
    Cancel(lFlags, pHandler)
      => ComCall(5, this.p, Int32, lFlags, IWbemObjectSink, pHandler)
}
struct IWbemConstructClassObject extends IUnknown {
    static IID := "{9EF76194-70D5-11D1-AD90-00C04FD8FDFF}"
    SetInheritanceChain(awszAntecedents)
      => ComCall(3, this.p, Int32, awszAntecedents.Size, PWSTR.Ptr, awszAntecedents)
    SetPropertyOrigin(wszPropertyName, lOriginIndex)
      => ComCall(4, this.p, "Str", wszPropertyName, Int32, lOriginIndex)
    SetMethodOrigin(wszMethodName, lOriginIndex)
      => ComCall(5, this.p, "Str", wszMethodName, Int32, lOriginIndex)
    SetServerNamespace(wszServer, wszNamespace)
      => ComCall(6, this.p, "Str", wszServer, "Str", wszNamespace)
}
