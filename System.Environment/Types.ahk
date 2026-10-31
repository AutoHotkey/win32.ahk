#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_EXCEPTION extends FunctionPointer {
    static Types := [VBS_BASIC_ENCLAVE_EXCEPTION_AMD64.Ptr, Int32]
}
struct VBS_BASIC_ENCLAVE_BASIC_CALL_TERMINATE_THREAD extends FunctionPointer {
    static Types := [VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64.Ptr, Int32]
}
struct VBS_BASIC_ENCLAVE_BASIC_CALL_INTERRUPT_THREAD extends FunctionPointer {
    static Types := [VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64.Ptr, Int32]
}
struct VBS_BASIC_ENCLAVE_BASIC_CALL_CREATE_THREAD extends FunctionPointer {
    static Types := [VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64.Ptr, Int32]
}
struct ENCLAVE_SEALING_IDENTITY_POLICY extends Int32 {
    static ENCLAVE_IDENTITY_POLICY_SEAL_INVALID := 0
    static ENCLAVE_IDENTITY_POLICY_SEAL_EXACT_CODE := 1
    static ENCLAVE_IDENTITY_POLICY_SEAL_SAME_PRIMARY_CODE := 2
    static ENCLAVE_IDENTITY_POLICY_SEAL_SAME_IMAGE := 3
    static ENCLAVE_IDENTITY_POLICY_SEAL_SAME_FAMILY := 4
    static ENCLAVE_IDENTITY_POLICY_SEAL_SAME_AUTHOR := 5
}
struct ENCLAVE_IDENTITY {
    OwnerId : UInt8[32]
    UniqueId : UInt8[32]
    AuthorId : UInt8[32]
    FamilyId : UInt8[16]
    ImageId : UInt8[16]
    EnclaveSvn : UInt32
    SecureKernelSvn : UInt32
    PlatformSvn : UInt32
    Flags : UInt32
    SigningLevel : UInt32
    EnclaveType : UInt32
}
struct ENCLAVE_PACKAGE_IDENTITY {
    PackageId : UInt8[32]
    PackageSvn : Int64
}
struct VBS_ENCLAVE_REPORT_PKG_HEADER {
    PackageSize : UInt32
    Version : UInt32
    SignatureScheme : UInt32
    SignedStatementSize : UInt32
    SignatureSize : UInt32
    Reserved : UInt32
}
struct VBS_ENCLAVE_REPORT {
    ReportSize : UInt32
    ReportVersion : UInt32
    EnclaveData : UInt8[64]
    EnclaveIdentity : ENCLAVE_IDENTITY
}
struct VBS_ENCLAVE_REPORT_VARDATA_HEADER {
    DataType : UInt32
    Size : UInt32
}
struct VBS_ENCLAVE_REPORT_MODULE {
    Header : VBS_ENCLAVE_REPORT_VARDATA_HEADER
    UniqueId : UInt8[32]
    AuthorId : UInt8[32]
    FamilyId : UInt8[16]
    ImageId : UInt8[16]
    Svn : UInt32
    ModuleName : UInt16[1]
}
struct VBS_ENCLAVE_REPORT_PACKAGE_ID {
    Header : VBS_ENCLAVE_REPORT_VARDATA_HEADER
    PackageIdentity : ENCLAVE_PACKAGE_IDENTITY
}
struct ENCLAVE_INFORMATION {
    EnclaveType : UInt32
    Reserved : UInt32
    BaseAddress : Struct.Ptr
    Size : IntPtr
    Identity : ENCLAVE_IDENTITY
}
struct VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32 {
    ThreadContext : UInt32[4]
    EntryPoint : UInt32
    StackPointer : UInt32
    ExceptionEntryPoint : UInt32
    ExceptionStack : UInt32
    ExceptionActive : UInt32
}
struct VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64 {
    ThreadContext : Int64[4]
    EntryPoint : Int64
    StackPointer : Int64
    ExceptionEntryPoint : Int64
    ExceptionStack : Int64
    ExceptionActive : UInt32
}
struct VBS_BASIC_ENCLAVE_EXCEPTION_AMD64 {
    ExceptionCode : UInt32
    NumberParameters : UInt32
    ExceptionInformation : IntPtr[3]
    ExceptionRAX : IntPtr
    ExceptionRCX : IntPtr
    ExceptionRIP : IntPtr
    ExceptionRFLAGS : IntPtr
    ExceptionRSP : IntPtr
}
struct VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_ENCLAVE extends FunctionPointer {
    static Types := [IntPtr, "Void"]
}
struct VBS_BASIC_ENCLAVE_BASIC_CALL_COMMIT_PAGES extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, Struct.Ptr, UInt32, Int32]
}
struct VBS_BASIC_ENCLAVE_BASIC_CALL_DECOMMIT_PAGES extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, Int32]
}
struct VBS_BASIC_ENCLAVE_BASIC_CALL_PROTECT_PAGES extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, UInt32, Int32]
}
struct VBS_BASIC_ENCLAVE_BASIC_CALL_GET_ENCLAVE_INFORMATION extends FunctionPointer {
    static Types := [ENCLAVE_INFORMATION.Ptr, Int32]
}
struct ENCLAVE_VBS_BASIC_KEY_REQUEST {
    RequestSize : UInt32
    Flags : UInt32
    EnclaveSVN : UInt32
    SystemKeyID : UInt32
    CurrentSystemKeyID : UInt32
}
struct VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_KEY extends FunctionPointer {
    static Types := [ENCLAVE_VBS_BASIC_KEY_REQUEST.Ptr, UInt32, UInt8.Ptr, Int32]
}
struct VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_REPORT extends FunctionPointer {
    static Types := [UInt8.Ptr, Struct.Ptr, UInt32, UInt32.Ptr, Int32]
}
struct VBS_BASIC_ENCLAVE_BASIC_CALL_VERIFY_REPORT extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, Int32]
}
struct VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_RANDOM_DATA extends FunctionPointer {
    static Types := [UInt8.Ptr, UInt32, Int64.Ptr, Int32]
}
struct VBS_BASIC_ENCLAVE_SYSCALL_PAGE {
    ReturnFromEnclave : VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_ENCLAVE
    ReturnFromException : VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_EXCEPTION
    TerminateThread : VBS_BASIC_ENCLAVE_BASIC_CALL_TERMINATE_THREAD
    InterruptThread : VBS_BASIC_ENCLAVE_BASIC_CALL_INTERRUPT_THREAD
    CommitPages : VBS_BASIC_ENCLAVE_BASIC_CALL_COMMIT_PAGES
    DecommitPages : VBS_BASIC_ENCLAVE_BASIC_CALL_DECOMMIT_PAGES
    ProtectPages : VBS_BASIC_ENCLAVE_BASIC_CALL_PROTECT_PAGES
    CreateThread : VBS_BASIC_ENCLAVE_BASIC_CALL_CREATE_THREAD
    GetEnclaveInformation : VBS_BASIC_ENCLAVE_BASIC_CALL_GET_ENCLAVE_INFORMATION
    GenerateKey : VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_KEY
    GenerateReport : VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_REPORT
    VerifyReport : VBS_BASIC_ENCLAVE_BASIC_CALL_VERIFY_REPORT
    GenerateRandomData : VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_RANDOM_DATA
}
struct PS_TRUSTLET_TKSESSION_ID {
    SessionId : Int64[4]
}
struct TRUSTLET_BINDING_DATA {
    TrustletIdentity : Int64
    TrustletSessionId : PS_TRUSTLET_TKSESSION_ID
    TrustletSvn : UInt32
    Reserved1 : UInt32
    Reserved2 : Int64
}
