#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Data.Xml.MsXml\Types.ahk" {IXMLDOMElement}
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, BSTR, CHAR, FARPROC, HANDLE, HRESULT, PSTR, PWSTR, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown}
#Import "..\System.Diagnostics.Debug\Types.ahk" {CONTEXT, EXCEPTION_RECORD64, IMAGE_NT_HEADERS64}
#Import "..\System.Kernel\Types.ahk" {LIST_ENTRY32, LIST_ENTRY64}
#Import "..\System.Memory\Types.ahk" {MEMORY_BASIC_INFORMATION64}
#Import "..\System.Variant\Types.ahk" {VARENUM, VARIANT}

struct ISvcProcess {
    Value : IntPtr
}
struct ISvcThread {
    Value : IntPtr
}
struct ISvcExecutionUnit {
    Value : IntPtr
}
struct IDebugServiceManager {
    Value : IntPtr
}
struct ISvcModule {
    Value : IntPtr
}
struct ISvcSymbolType {
    Value : IntPtr
}
struct DEBUG_OFFSET_REGION {
    Base : Int64
    Size : Int64
}
struct IDebugAdvanced extends IUnknown {
    static IID := "{F2DF5F53-071F-47BD-9DE6-5734C3FED689}"
    GetThreadContext(Context)
      => ComCall(3, this.p, Struct.Ptr, Context, UInt32, Context.Size)
    SetThreadContext(Context)
      => ComCall(4, this.p, Struct.Ptr, Context, UInt32, Context.Size)
}
struct DEBUG_READ_USER_MINIDUMP_STREAM {
    StreamType : UInt32
    Flags : UInt32
    Offset : Int64
    Buffer : Struct.Ptr
    BufferSize : UInt32
    BufferUsed : UInt32
}
struct DEBUG_GET_TEXT_COMPLETIONS_IN {
    Flags : UInt32
    MatchCountLimit : UInt32
    Reserved : Int64[3]
}
struct DEBUG_GET_TEXT_COMPLETIONS_OUT {
    Flags : UInt32
    ReplaceIndex : UInt32
    MatchCount : UInt32
    Reserved1 : UInt32
    Reserved2 : Int64[2]
}
struct DEBUG_CACHED_SYMBOL_INFO {
    ModBase : Int64
    Arg1 : Int64
    Arg2 : Int64
    Id : UInt32
    Arg3 : UInt32
}
struct PROCESS_NAME_ENTRY {
    ProcessId : UInt32
    NameOffset : UInt32
    NameSize : UInt32
    NextEntry : UInt32
}
struct DEBUG_THREAD_BASIC_INFORMATION {
    Valid : UInt32
    ExitStatus : UInt32
    PriorityClass : UInt32
    Priority : UInt32
    CreateTime : Int64
    ExitTime : Int64
    KernelTime : Int64
    UserTime : Int64
    StartOffset : Int64
    Affinity : Int64
}
struct IDebugAdvanced2 extends IUnknown {
    static IID := "{716D14C9-119B-4BA5-AF1F-0890E672416A}"
    GetThreadContext(Context)
      => ComCall(3, this.p, Struct.Ptr, Context, UInt32, Context.Size)
    SetThreadContext(Context)
      => ComCall(4, this.p, Struct.Ptr, Context, UInt32, Context.Size)
    Request(Request, InBuffer?, OutBuffer?, OutSize?)
      => ComCall(5, this.p, UInt32, Request, Struct.Ptr, InBuffer?, UInt32, InBuffer?.Size ?? 0, Struct.Ptr, OutBuffer?, UInt32, OutBuffer?.Size ?? 0, UInt32.Ptr, OutSize?)
    GetSourceFileInformation(Which, SourceFile, Arg64, Arg32, Buffer?, InfoSize?)
      => ComCall(6, this.p, UInt32, Which, PSTR, SourceFile, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?)
    FindSourceFileAndToken(StartElement, ModAddr, File, Flags, FileToken?, FoundElement?, Buffer?, FoundSize?)
      => ComCall(7, this.p, UInt32, StartElement, Int64, ModAddr, PSTR, File, UInt32, Flags, Struct.Ptr, FileToken?, UInt32, FileToken?.Size ?? 0, UInt32.Ptr, FoundElement?, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSymbolInformation(Which, Arg64, Arg32, Buffer?, InfoSize?, StringBuffer?, StringSize?)
      => ComCall(8, this.p, UInt32, Which, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?, PSTR, StringBuffer?, UInt32, StringBuffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSystemObjectInformation(Which, Arg64, Arg32, Buffer?, InfoSize?)
      => ComCall(9, this.p, UInt32, Which, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?)
}
struct IDebugAdvanced3 extends IUnknown {
    static IID := "{CBA4ABB4-84C4-444D-87CA-A04E13286739}"
    GetThreadContext(Context)
      => ComCall(3, this.p, Struct.Ptr, Context, UInt32, Context.Size)
    SetThreadContext(Context)
      => ComCall(4, this.p, Struct.Ptr, Context, UInt32, Context.Size)
    Request(Request, InBuffer?, OutBuffer?, OutSize?)
      => ComCall(5, this.p, UInt32, Request, Struct.Ptr, InBuffer?, UInt32, InBuffer?.Size ?? 0, Struct.Ptr, OutBuffer?, UInt32, OutBuffer?.Size ?? 0, UInt32.Ptr, OutSize?)
    GetSourceFileInformation(Which, SourceFile, Arg64, Arg32, Buffer?, InfoSize?)
      => ComCall(6, this.p, UInt32, Which, PSTR, SourceFile, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?)
    FindSourceFileAndToken(StartElement, ModAddr, File, Flags, FileToken?, FoundElement?, Buffer?, FoundSize?)
      => ComCall(7, this.p, UInt32, StartElement, Int64, ModAddr, PSTR, File, UInt32, Flags, Struct.Ptr, FileToken?, UInt32, FileToken?.Size ?? 0, UInt32.Ptr, FoundElement?, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSymbolInformation(Which, Arg64, Arg32, Buffer?, InfoSize?, StringBuffer?, StringSize?)
      => ComCall(8, this.p, UInt32, Which, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?, PSTR, StringBuffer?, UInt32, StringBuffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSystemObjectInformation(Which, Arg64, Arg32, Buffer?, InfoSize?)
      => ComCall(9, this.p, UInt32, Which, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?)
    GetSourceFileInformationWide(Which, SourceFile, Arg64, Arg32, Buffer?, InfoSize?)
      => ComCall(10, this.p, UInt32, Which, "Str", SourceFile, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?)
    FindSourceFileAndTokenWide(StartElement, ModAddr, File, Flags, FileToken?, FoundElement?, Buffer?, FoundSize?)
      => ComCall(11, this.p, UInt32, StartElement, Int64, ModAddr, "Str", File, UInt32, Flags, Struct.Ptr, FileToken?, UInt32, FileToken?.Size ?? 0, UInt32.Ptr, FoundElement?, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSymbolInformationWide(Which, Arg64, Arg32, Buffer?, InfoSize?, StringBuffer?, StringSize?)
      => ComCall(12, this.p, UInt32, Which, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?, PWSTR, StringBuffer?, UInt32, StringBuffer?.Length ?? 0, UInt32.Ptr, StringSize?)
}
struct SYMBOL_INFO_EX {
    SizeOfStruct : UInt32
    TypeOfInfo : UInt32
    Offset : Int64
    Line : UInt32
    Displacement : UInt32
    Reserved : UInt32[4]
}
struct IDebugAdvanced4 extends IUnknown {
    static IID := "{D1069067-2A65-4BF0-AE97-76184B67856B}"
    GetThreadContext(Context)
      => ComCall(3, this.p, Struct.Ptr, Context, UInt32, Context.Size)
    SetThreadContext(Context)
      => ComCall(4, this.p, Struct.Ptr, Context, UInt32, Context.Size)
    Request(Request, InBuffer?, OutBuffer?, OutSize?)
      => ComCall(5, this.p, UInt32, Request, Struct.Ptr, InBuffer?, UInt32, InBuffer?.Size ?? 0, Struct.Ptr, OutBuffer?, UInt32, OutBuffer?.Size ?? 0, UInt32.Ptr, OutSize?)
    GetSourceFileInformation(Which, SourceFile, Arg64, Arg32, Buffer?, InfoSize?)
      => ComCall(6, this.p, UInt32, Which, PSTR, SourceFile, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?)
    FindSourceFileAndToken(StartElement, ModAddr, File, Flags, FileToken?, FoundElement?, Buffer?, FoundSize?)
      => ComCall(7, this.p, UInt32, StartElement, Int64, ModAddr, PSTR, File, UInt32, Flags, Struct.Ptr, FileToken?, UInt32, FileToken?.Size ?? 0, UInt32.Ptr, FoundElement?, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSymbolInformation(Which, Arg64, Arg32, Buffer?, InfoSize?, StringBuffer?, StringSize?)
      => ComCall(8, this.p, UInt32, Which, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?, PSTR, StringBuffer?, UInt32, StringBuffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSystemObjectInformation(Which, Arg64, Arg32, Buffer?, InfoSize?)
      => ComCall(9, this.p, UInt32, Which, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?)
    GetSourceFileInformationWide(Which, SourceFile, Arg64, Arg32, Buffer?, InfoSize?)
      => ComCall(10, this.p, UInt32, Which, "Str", SourceFile, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?)
    FindSourceFileAndTokenWide(StartElement, ModAddr, File, Flags, FileToken?, FoundElement?, Buffer?, FoundSize?)
      => ComCall(11, this.p, UInt32, StartElement, Int64, ModAddr, "Str", File, UInt32, Flags, Struct.Ptr, FileToken?, UInt32, FileToken?.Size ?? 0, UInt32.Ptr, FoundElement?, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSymbolInformationWide(Which, Arg64, Arg32, Buffer?, InfoSize?, StringBuffer?, StringSize?)
      => ComCall(12, this.p, UInt32, Which, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?, PWSTR, StringBuffer?, UInt32, StringBuffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSymbolInformationWideEx(Which, Arg64, Arg32, Buffer?, InfoSize?, StringBuffer?, StringSize?, pInfoEx?)
      => ComCall(13, this.p, UInt32, Which, Int64, Arg64, UInt32, Arg32, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?, PWSTR, StringBuffer?, UInt32, StringBuffer?.Length ?? 0, UInt32.Ptr, StringSize?, SYMBOL_INFO_EX.Ptr, pInfoEx?)
}
struct DEBUG_BREAKPOINT_PARAMETERS {
    Offset : Int64
    Id : UInt32
    BreakType : UInt32
    ProcType : UInt32
    Flags : UInt32
    DataSize : UInt32
    DataAccessType : UInt32
    PassCount : UInt32
    CurrentPassCount : UInt32
    MatchThread : UInt32
    CommandSize : UInt32
    OffsetExpressionSize : UInt32
}
struct IDebugBreakpoint extends IUnknown {
    static IID := "{5BD9D474-5975-423A-B88B-65A8E7110E65}"
    GetId(Id)
      => ComCall(3, this.p, UInt32.Ptr, Id)
    GetType(BreakType, ProcType)
      => ComCall(4, this.p, UInt32.Ptr, BreakType, UInt32.Ptr, ProcType)
    GetAdder(Adder)
      => ComCall(5, this.p, IDebugClient.Ptr, Adder)
    GetFlags(Flags)
      => ComCall(6, this.p, UInt32.Ptr, Flags)
    AddFlags(Flags)
      => ComCall(7, this.p, UInt32, Flags)
    RemoveFlags(Flags)
      => ComCall(8, this.p, UInt32, Flags)
    SetFlags(Flags)
      => ComCall(9, this.p, UInt32, Flags)
    GetOffset(Offset)
      => ComCall(10, this.p, Int64.Ptr, Offset)
    SetOffset(Offset)
      => ComCall(11, this.p, Int64, Offset)
    GetDataParameters(Size, AccessType)
      => ComCall(12, this.p, UInt32.Ptr, Size, UInt32.Ptr, AccessType)
    SetDataParameters(Size, AccessType)
      => ComCall(13, this.p, UInt32, Size, UInt32, AccessType)
    GetPassCount(Count)
      => ComCall(14, this.p, UInt32.Ptr, Count)
    SetPassCount(Count)
      => ComCall(15, this.p, UInt32, Count)
    GetCurrentPassCount(Count)
      => ComCall(16, this.p, UInt32.Ptr, Count)
    GetMatchThreadId(Id)
      => ComCall(17, this.p, UInt32.Ptr, Id)
    SetMatchThreadId(Thread)
      => ComCall(18, this.p, UInt32, Thread)
    GetCommand(Buffer?, CommandSize?)
      => ComCall(19, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetCommand(Command)
      => ComCall(20, this.p, PSTR, Command)
    GetOffsetExpression(Buffer?, ExpressionSize?)
      => ComCall(21, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ExpressionSize?)
    SetOffsetExpression(Expression)
      => ComCall(22, this.p, PSTR, Expression)
    GetParameters(Params)
      => ComCall(23, this.p, DEBUG_BREAKPOINT_PARAMETERS.Ptr, Params)
}
struct IDebugBreakpoint2 extends IUnknown {
    static IID := "{1B278D20-79F2-426E-A3F9-C1DDF375D48E}"
    GetId(Id)
      => ComCall(3, this.p, UInt32.Ptr, Id)
    GetType(BreakType, ProcType)
      => ComCall(4, this.p, UInt32.Ptr, BreakType, UInt32.Ptr, ProcType)
    GetAdder(Adder)
      => ComCall(5, this.p, IDebugClient.Ptr, Adder)
    GetFlags(Flags)
      => ComCall(6, this.p, UInt32.Ptr, Flags)
    AddFlags(Flags)
      => ComCall(7, this.p, UInt32, Flags)
    RemoveFlags(Flags)
      => ComCall(8, this.p, UInt32, Flags)
    SetFlags(Flags)
      => ComCall(9, this.p, UInt32, Flags)
    GetOffset(Offset)
      => ComCall(10, this.p, Int64.Ptr, Offset)
    SetOffset(Offset)
      => ComCall(11, this.p, Int64, Offset)
    GetDataParameters(Size, AccessType)
      => ComCall(12, this.p, UInt32.Ptr, Size, UInt32.Ptr, AccessType)
    SetDataParameters(Size, AccessType)
      => ComCall(13, this.p, UInt32, Size, UInt32, AccessType)
    GetPassCount(Count)
      => ComCall(14, this.p, UInt32.Ptr, Count)
    SetPassCount(Count)
      => ComCall(15, this.p, UInt32, Count)
    GetCurrentPassCount(Count)
      => ComCall(16, this.p, UInt32.Ptr, Count)
    GetMatchThreadId(Id)
      => ComCall(17, this.p, UInt32.Ptr, Id)
    SetMatchThreadId(Thread)
      => ComCall(18, this.p, UInt32, Thread)
    GetCommand(Buffer?, CommandSize?)
      => ComCall(19, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetCommand(Command)
      => ComCall(20, this.p, PSTR, Command)
    GetOffsetExpression(Buffer?, ExpressionSize?)
      => ComCall(21, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ExpressionSize?)
    SetOffsetExpression(Expression)
      => ComCall(22, this.p, PSTR, Expression)
    GetParameters(Params)
      => ComCall(23, this.p, DEBUG_BREAKPOINT_PARAMETERS.Ptr, Params)
    GetCommandWide(Buffer?, CommandSize?)
      => ComCall(24, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetCommandWide(Command)
      => ComCall(25, this.p, "Str", Command)
    GetOffsetExpressionWide(Buffer?, ExpressionSize?)
      => ComCall(26, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ExpressionSize?)
    SetOffsetExpressionWide(Expression)
      => ComCall(27, this.p, "Str", Expression)
}
struct IDebugBreakpoint3 extends IUnknown {
    static IID := "{38F5C249-B448-43BB-9835-579D4EC02249}"
    GetId(Id)
      => ComCall(3, this.p, UInt32.Ptr, Id)
    GetType(BreakType, ProcType)
      => ComCall(4, this.p, UInt32.Ptr, BreakType, UInt32.Ptr, ProcType)
    GetAdder(Adder)
      => ComCall(5, this.p, IDebugClient.Ptr, Adder)
    GetFlags(Flags)
      => ComCall(6, this.p, UInt32.Ptr, Flags)
    AddFlags(Flags)
      => ComCall(7, this.p, UInt32, Flags)
    RemoveFlags(Flags)
      => ComCall(8, this.p, UInt32, Flags)
    SetFlags(Flags)
      => ComCall(9, this.p, UInt32, Flags)
    GetOffset(Offset)
      => ComCall(10, this.p, Int64.Ptr, Offset)
    SetOffset(Offset)
      => ComCall(11, this.p, Int64, Offset)
    GetDataParameters(Size, AccessType)
      => ComCall(12, this.p, UInt32.Ptr, Size, UInt32.Ptr, AccessType)
    SetDataParameters(Size, AccessType)
      => ComCall(13, this.p, UInt32, Size, UInt32, AccessType)
    GetPassCount(Count)
      => ComCall(14, this.p, UInt32.Ptr, Count)
    SetPassCount(Count)
      => ComCall(15, this.p, UInt32, Count)
    GetCurrentPassCount(Count)
      => ComCall(16, this.p, UInt32.Ptr, Count)
    GetMatchThreadId(Id)
      => ComCall(17, this.p, UInt32.Ptr, Id)
    SetMatchThreadId(Thread)
      => ComCall(18, this.p, UInt32, Thread)
    GetCommand(Buffer?, CommandSize?)
      => ComCall(19, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetCommand(Command)
      => ComCall(20, this.p, PSTR, Command)
    GetOffsetExpression(Buffer?, ExpressionSize?)
      => ComCall(21, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ExpressionSize?)
    SetOffsetExpression(Expression)
      => ComCall(22, this.p, PSTR, Expression)
    GetParameters(Params)
      => ComCall(23, this.p, DEBUG_BREAKPOINT_PARAMETERS.Ptr, Params)
    GetCommandWide(Buffer?, CommandSize?)
      => ComCall(24, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetCommandWide(Command)
      => ComCall(25, this.p, "Str", Command)
    GetOffsetExpressionWide(Buffer?, ExpressionSize?)
      => ComCall(26, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ExpressionSize?)
    SetOffsetExpressionWide(Expression)
      => ComCall(27, this.p, "Str", Expression)
    GetGuid(Guid)
      => ComCall(28, this.p, GUID.Ptr, Guid)
}
struct DEBUG_CREATE_PROCESS_OPTIONS {
    CreateFlags : UInt32
    EngCreateFlags : UInt32
    VerifierFlags : UInt32
    Reserved : UInt32
}
struct DEBUG_CLIENT_CONTEXT {
    cbSize : UInt32 := this.Size
    eClient : UInt32
}
struct IDebugClient extends IUnknown {
    static IID := "{27FE5639-8407-4F47-8364-EE118FB08AC8}"
    AttachKernel(Flags, ConnectOptions?)
      => ComCall(3, this.p, UInt32, Flags, PSTR, ConnectOptions?)
    GetKernelConnectionOptions(Buffer?, OptionsSize?)
      => ComCall(4, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptions(Options)
      => ComCall(5, this.p, PSTR, Options)
    StartProcessServer(Flags, Options)
      => ComCall(6, this.p, UInt32, Flags, PSTR, Options, "Ptr", 0)
    ConnectProcessServer(RemoteOptions, Server)
      => ComCall(7, this.p, PSTR, RemoteOptions, Int64.Ptr, Server)
    DisconnectProcessServer(Server)
      => ComCall(8, this.p, Int64, Server)
    GetRunningProcessSystemIds(Server, Ids?, ActualCount?)
      => ComCall(9, this.p, Int64, Server, UInt32.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, ActualCount?)
    GetRunningProcessSystemIdByExecutableName(Server, ExeName, Flags, Id)
      => ComCall(10, this.p, Int64, Server, PSTR, ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescription(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(11, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    AttachProcess(Server, ProcessId, AttachFlags)
      => ComCall(12, this.p, Int64, Server, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessA(Server, CommandLine, CreateFlags)
      => ComCall(13, this.p, Int64, Server, PSTR, CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttach(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(14, this.p, Int64, Server, PSTR, CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    GetProcessOptions(Options)
      => ComCall(15, this.p, UInt32.Ptr, Options)
    AddProcessOptions(Options)
      => ComCall(16, this.p, UInt32, Options)
    RemoveProcessOptions(Options)
      => ComCall(17, this.p, UInt32, Options)
    SetProcessOptions(Options)
      => ComCall(18, this.p, UInt32, Options)
    OpenDumpFile(DumpFile)
      => ComCall(19, this.p, PSTR, DumpFile)
    WriteDumpFile(DumpFile, Qualifier)
      => ComCall(20, this.p, PSTR, DumpFile, UInt32, Qualifier)
    ConnectSession(Flags, HistoryLimit)
      => ComCall(21, this.p, UInt32, Flags, UInt32, HistoryLimit)
    StartServer(Options)
      => ComCall(22, this.p, PSTR, Options)
    OutputServers(OutputControl, Machine, Flags)
      => ComCall(23, this.p, UInt32, OutputControl, PSTR, Machine, UInt32, Flags)
    TerminateProcesses()
      => ComCall(24, this.p)
    DetachProcesses()
      => ComCall(25, this.p)
    EndSession(Flags)
      => ComCall(26, this.p, UInt32, Flags)
    GetExitCode(Code)
      => ComCall(27, this.p, UInt32.Ptr, Code)
    DispatchCallbacks(Timeout)
      => ComCall(28, this.p, UInt32, Timeout)
    ExitDispatch(Client)
      => ComCall(29, this.p, IDebugClient, Client)
    CreateClient(Client)
      => ComCall(30, this.p, IDebugClient.Ptr, Client)
    GetInputCallbacks(Callbacks)
      => ComCall(31, this.p, IDebugInputCallbacks.Ptr, Callbacks)
    SetInputCallbacks(Callbacks?)
      => ComCall(32, this.p, IDebugInputCallbacks, Callbacks?)
    GetOutputCallbacks(Callbacks)
      => ComCall(33, this.p, IDebugOutputCallbacks.Ptr, Callbacks)
    SetOutputCallbacks(Callbacks?)
      => ComCall(34, this.p, IDebugOutputCallbacks, Callbacks?)
    GetOutputMask(Mask)
      => ComCall(35, this.p, UInt32.Ptr, Mask)
    SetOutputMask(Mask)
      => ComCall(36, this.p, UInt32, Mask)
    GetOtherOutputMask(Client, Mask)
      => ComCall(37, this.p, IDebugClient, Client, UInt32.Ptr, Mask)
    SetOtherOutputMask(Client, Mask)
      => ComCall(38, this.p, IDebugClient, Client, UInt32, Mask)
    GetOutputWidth(Columns)
      => ComCall(39, this.p, UInt32.Ptr, Columns)
    SetOutputWidth(Columns)
      => ComCall(40, this.p, UInt32, Columns)
    GetOutputLinePrefix(Buffer?, PrefixSize?)
      => ComCall(41, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefix(Prefix?)
      => ComCall(42, this.p, PSTR, Prefix?)
    GetIdentity(Buffer?, IdentitySize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentity(OutputControl, Flags, Format)
      => ComCall(44, this.p, UInt32, OutputControl, UInt32, Flags, PSTR, Format)
    GetEventCallbacks(Callbacks)
      => ComCall(45, this.p, IDebugEventCallbacks.Ptr, Callbacks)
    SetEventCallbacks(Callbacks?)
      => ComCall(46, this.p, IDebugEventCallbacks, Callbacks?)
    FlushCallbacks()
      => ComCall(47, this.p)
}
struct IDebugClient2 extends IUnknown {
    static IID := "{EDBED635-372E-4DAB-BBFE-ED0D2F63BE81}"
    AttachKernel(Flags, ConnectOptions?)
      => ComCall(3, this.p, UInt32, Flags, PSTR, ConnectOptions?)
    GetKernelConnectionOptions(Buffer?, OptionsSize?)
      => ComCall(4, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptions(Options)
      => ComCall(5, this.p, PSTR, Options)
    StartProcessServer(Flags, Options)
      => ComCall(6, this.p, UInt32, Flags, PSTR, Options, "Ptr", 0)
    ConnectProcessServer(RemoteOptions, Server)
      => ComCall(7, this.p, PSTR, RemoteOptions, Int64.Ptr, Server)
    DisconnectProcessServer(Server)
      => ComCall(8, this.p, Int64, Server)
    GetRunningProcessSystemIds(Server, Ids?, ActualCount?)
      => ComCall(9, this.p, Int64, Server, UInt32.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, ActualCount?)
    GetRunningProcessSystemIdByExecutableName(Server, ExeName, Flags, Id)
      => ComCall(10, this.p, Int64, Server, PSTR, ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescription(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(11, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    AttachProcess(Server, ProcessId, AttachFlags)
      => ComCall(12, this.p, Int64, Server, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessA(Server, CommandLine, CreateFlags)
      => ComCall(13, this.p, Int64, Server, PSTR, CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttach(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(14, this.p, Int64, Server, PSTR, CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    GetProcessOptions(Options)
      => ComCall(15, this.p, UInt32.Ptr, Options)
    AddProcessOptions(Options)
      => ComCall(16, this.p, UInt32, Options)
    RemoveProcessOptions(Options)
      => ComCall(17, this.p, UInt32, Options)
    SetProcessOptions(Options)
      => ComCall(18, this.p, UInt32, Options)
    OpenDumpFile(DumpFile)
      => ComCall(19, this.p, PSTR, DumpFile)
    WriteDumpFile(DumpFile, Qualifier)
      => ComCall(20, this.p, PSTR, DumpFile, UInt32, Qualifier)
    ConnectSession(Flags, HistoryLimit)
      => ComCall(21, this.p, UInt32, Flags, UInt32, HistoryLimit)
    StartServer(Options)
      => ComCall(22, this.p, PSTR, Options)
    OutputServers(OutputControl, Machine, Flags)
      => ComCall(23, this.p, UInt32, OutputControl, PSTR, Machine, UInt32, Flags)
    TerminateProcesses()
      => ComCall(24, this.p)
    DetachProcesses()
      => ComCall(25, this.p)
    EndSession(Flags)
      => ComCall(26, this.p, UInt32, Flags)
    GetExitCode(Code)
      => ComCall(27, this.p, UInt32.Ptr, Code)
    DispatchCallbacks(Timeout)
      => ComCall(28, this.p, UInt32, Timeout)
    ExitDispatch(Client)
      => ComCall(29, this.p, IDebugClient, Client)
    CreateClient(Client)
      => ComCall(30, this.p, IDebugClient.Ptr, Client)
    GetInputCallbacks(Callbacks)
      => ComCall(31, this.p, IDebugInputCallbacks.Ptr, Callbacks)
    SetInputCallbacks(Callbacks?)
      => ComCall(32, this.p, IDebugInputCallbacks, Callbacks?)
    GetOutputCallbacks(Callbacks)
      => ComCall(33, this.p, IDebugOutputCallbacks.Ptr, Callbacks)
    SetOutputCallbacks(Callbacks?)
      => ComCall(34, this.p, IDebugOutputCallbacks, Callbacks?)
    GetOutputMask(Mask)
      => ComCall(35, this.p, UInt32.Ptr, Mask)
    SetOutputMask(Mask)
      => ComCall(36, this.p, UInt32, Mask)
    GetOtherOutputMask(Client, Mask)
      => ComCall(37, this.p, IDebugClient, Client, UInt32.Ptr, Mask)
    SetOtherOutputMask(Client, Mask)
      => ComCall(38, this.p, IDebugClient, Client, UInt32, Mask)
    GetOutputWidth(Columns)
      => ComCall(39, this.p, UInt32.Ptr, Columns)
    SetOutputWidth(Columns)
      => ComCall(40, this.p, UInt32, Columns)
    GetOutputLinePrefix(Buffer?, PrefixSize?)
      => ComCall(41, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefix(Prefix?)
      => ComCall(42, this.p, PSTR, Prefix?)
    GetIdentity(Buffer?, IdentitySize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentity(OutputControl, Flags, Format)
      => ComCall(44, this.p, UInt32, OutputControl, UInt32, Flags, PSTR, Format)
    GetEventCallbacks(Callbacks)
      => ComCall(45, this.p, IDebugEventCallbacks.Ptr, Callbacks)
    SetEventCallbacks(Callbacks?)
      => ComCall(46, this.p, IDebugEventCallbacks, Callbacks?)
    FlushCallbacks()
      => ComCall(47, this.p)
    WriteDumpFile2(DumpFile, Qualifier, FormatFlags, Comment?)
      => ComCall(48, this.p, PSTR, DumpFile, UInt32, Qualifier, UInt32, FormatFlags, PSTR, Comment?)
    AddDumpInformationFile(InfoFile, Type)
      => ComCall(49, this.p, PSTR, InfoFile, UInt32, Type)
    EndProcessServer(Server)
      => ComCall(50, this.p, Int64, Server)
    WaitForProcessServerEnd(Timeout)
      => ComCall(51, this.p, UInt32, Timeout)
    IsKernelDebuggerEnabled()
      => ComCall(52, this.p)
    TerminateCurrentProcess()
      => ComCall(53, this.p)
    DetachCurrentProcess()
      => ComCall(54, this.p)
    AbandonCurrentProcess()
      => ComCall(55, this.p)
}
struct IDebugClient3 extends IUnknown {
    static IID := "{DD492D7F-71B8-4AD6-A8DC-1C887479FF91}"
    AttachKernel(Flags, ConnectOptions?)
      => ComCall(3, this.p, UInt32, Flags, PSTR, ConnectOptions?)
    GetKernelConnectionOptions(Buffer?, OptionsSize?)
      => ComCall(4, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptions(Options)
      => ComCall(5, this.p, PSTR, Options)
    StartProcessServer(Flags, Options)
      => ComCall(6, this.p, UInt32, Flags, PSTR, Options, "Ptr", 0)
    ConnectProcessServer(RemoteOptions, Server)
      => ComCall(7, this.p, PSTR, RemoteOptions, Int64.Ptr, Server)
    DisconnectProcessServer(Server)
      => ComCall(8, this.p, Int64, Server)
    GetRunningProcessSystemIds(Server, Ids?, ActualCount?)
      => ComCall(9, this.p, Int64, Server, UInt32.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, ActualCount?)
    GetRunningProcessSystemIdByExecutableName(Server, ExeName, Flags, Id)
      => ComCall(10, this.p, Int64, Server, PSTR, ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescription(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(11, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    AttachProcess(Server, ProcessId, AttachFlags)
      => ComCall(12, this.p, Int64, Server, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessA(Server, CommandLine, CreateFlags)
      => ComCall(13, this.p, Int64, Server, PSTR, CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttach(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(14, this.p, Int64, Server, PSTR, CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    GetProcessOptions(Options)
      => ComCall(15, this.p, UInt32.Ptr, Options)
    AddProcessOptions(Options)
      => ComCall(16, this.p, UInt32, Options)
    RemoveProcessOptions(Options)
      => ComCall(17, this.p, UInt32, Options)
    SetProcessOptions(Options)
      => ComCall(18, this.p, UInt32, Options)
    OpenDumpFile(DumpFile)
      => ComCall(19, this.p, PSTR, DumpFile)
    WriteDumpFile(DumpFile, Qualifier)
      => ComCall(20, this.p, PSTR, DumpFile, UInt32, Qualifier)
    ConnectSession(Flags, HistoryLimit)
      => ComCall(21, this.p, UInt32, Flags, UInt32, HistoryLimit)
    StartServer(Options)
      => ComCall(22, this.p, PSTR, Options)
    OutputServers(OutputControl, Machine, Flags)
      => ComCall(23, this.p, UInt32, OutputControl, PSTR, Machine, UInt32, Flags)
    TerminateProcesses()
      => ComCall(24, this.p)
    DetachProcesses()
      => ComCall(25, this.p)
    EndSession(Flags)
      => ComCall(26, this.p, UInt32, Flags)
    GetExitCode(Code)
      => ComCall(27, this.p, UInt32.Ptr, Code)
    DispatchCallbacks(Timeout)
      => ComCall(28, this.p, UInt32, Timeout)
    ExitDispatch(Client)
      => ComCall(29, this.p, IDebugClient, Client)
    CreateClient(Client)
      => ComCall(30, this.p, IDebugClient.Ptr, Client)
    GetInputCallbacks(Callbacks)
      => ComCall(31, this.p, IDebugInputCallbacks.Ptr, Callbacks)
    SetInputCallbacks(Callbacks?)
      => ComCall(32, this.p, IDebugInputCallbacks, Callbacks?)
    GetOutputCallbacks(Callbacks)
      => ComCall(33, this.p, IDebugOutputCallbacks.Ptr, Callbacks)
    SetOutputCallbacks(Callbacks?)
      => ComCall(34, this.p, IDebugOutputCallbacks, Callbacks?)
    GetOutputMask(Mask)
      => ComCall(35, this.p, UInt32.Ptr, Mask)
    SetOutputMask(Mask)
      => ComCall(36, this.p, UInt32, Mask)
    GetOtherOutputMask(Client, Mask)
      => ComCall(37, this.p, IDebugClient, Client, UInt32.Ptr, Mask)
    SetOtherOutputMask(Client, Mask)
      => ComCall(38, this.p, IDebugClient, Client, UInt32, Mask)
    GetOutputWidth(Columns)
      => ComCall(39, this.p, UInt32.Ptr, Columns)
    SetOutputWidth(Columns)
      => ComCall(40, this.p, UInt32, Columns)
    GetOutputLinePrefix(Buffer?, PrefixSize?)
      => ComCall(41, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefix(Prefix?)
      => ComCall(42, this.p, PSTR, Prefix?)
    GetIdentity(Buffer?, IdentitySize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentity(OutputControl, Flags, Format)
      => ComCall(44, this.p, UInt32, OutputControl, UInt32, Flags, PSTR, Format)
    GetEventCallbacks(Callbacks)
      => ComCall(45, this.p, IDebugEventCallbacks.Ptr, Callbacks)
    SetEventCallbacks(Callbacks?)
      => ComCall(46, this.p, IDebugEventCallbacks, Callbacks?)
    FlushCallbacks()
      => ComCall(47, this.p)
    WriteDumpFile2(DumpFile, Qualifier, FormatFlags, Comment?)
      => ComCall(48, this.p, PSTR, DumpFile, UInt32, Qualifier, UInt32, FormatFlags, PSTR, Comment?)
    AddDumpInformationFile(InfoFile, Type)
      => ComCall(49, this.p, PSTR, InfoFile, UInt32, Type)
    EndProcessServer(Server)
      => ComCall(50, this.p, Int64, Server)
    WaitForProcessServerEnd(Timeout)
      => ComCall(51, this.p, UInt32, Timeout)
    IsKernelDebuggerEnabled()
      => ComCall(52, this.p)
    TerminateCurrentProcess()
      => ComCall(53, this.p)
    DetachCurrentProcess()
      => ComCall(54, this.p)
    AbandonCurrentProcess()
      => ComCall(55, this.p)
    GetRunningProcessSystemIdByExecutableNameWide(Server, ExeName, Flags, Id)
      => ComCall(56, this.p, Int64, Server, "Str", ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescriptionWide(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(57, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PWSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PWSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    CreateProcessWide(Server, CommandLine, CreateFlags)
      => ComCall(58, this.p, Int64, Server, "Str", CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttachWide(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(59, this.p, Int64, Server, "Str", CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
}
struct IDebugClient4 extends IUnknown {
    static IID := "{CA83C3DE-5089-4CF8-93C8-D892387F2A5E}"
    AttachKernel(Flags, ConnectOptions?)
      => ComCall(3, this.p, UInt32, Flags, PSTR, ConnectOptions?)
    GetKernelConnectionOptions(Buffer?, OptionsSize?)
      => ComCall(4, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptions(Options)
      => ComCall(5, this.p, PSTR, Options)
    StartProcessServer(Flags, Options)
      => ComCall(6, this.p, UInt32, Flags, PSTR, Options, "Ptr", 0)
    ConnectProcessServer(RemoteOptions, Server)
      => ComCall(7, this.p, PSTR, RemoteOptions, Int64.Ptr, Server)
    DisconnectProcessServer(Server)
      => ComCall(8, this.p, Int64, Server)
    GetRunningProcessSystemIds(Server, Ids?, ActualCount?)
      => ComCall(9, this.p, Int64, Server, UInt32.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, ActualCount?)
    GetRunningProcessSystemIdByExecutableName(Server, ExeName, Flags, Id)
      => ComCall(10, this.p, Int64, Server, PSTR, ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescription(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(11, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    AttachProcess(Server, ProcessId, AttachFlags)
      => ComCall(12, this.p, Int64, Server, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessA(Server, CommandLine, CreateFlags)
      => ComCall(13, this.p, Int64, Server, PSTR, CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttach(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(14, this.p, Int64, Server, PSTR, CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    GetProcessOptions(Options)
      => ComCall(15, this.p, UInt32.Ptr, Options)
    AddProcessOptions(Options)
      => ComCall(16, this.p, UInt32, Options)
    RemoveProcessOptions(Options)
      => ComCall(17, this.p, UInt32, Options)
    SetProcessOptions(Options)
      => ComCall(18, this.p, UInt32, Options)
    OpenDumpFile(DumpFile)
      => ComCall(19, this.p, PSTR, DumpFile)
    WriteDumpFile(DumpFile, Qualifier)
      => ComCall(20, this.p, PSTR, DumpFile, UInt32, Qualifier)
    ConnectSession(Flags, HistoryLimit)
      => ComCall(21, this.p, UInt32, Flags, UInt32, HistoryLimit)
    StartServer(Options)
      => ComCall(22, this.p, PSTR, Options)
    OutputServers(OutputControl, Machine, Flags)
      => ComCall(23, this.p, UInt32, OutputControl, PSTR, Machine, UInt32, Flags)
    TerminateProcesses()
      => ComCall(24, this.p)
    DetachProcesses()
      => ComCall(25, this.p)
    EndSession(Flags)
      => ComCall(26, this.p, UInt32, Flags)
    GetExitCode(Code)
      => ComCall(27, this.p, UInt32.Ptr, Code)
    DispatchCallbacks(Timeout)
      => ComCall(28, this.p, UInt32, Timeout)
    ExitDispatch(Client)
      => ComCall(29, this.p, IDebugClient, Client)
    CreateClient(Client)
      => ComCall(30, this.p, IDebugClient.Ptr, Client)
    GetInputCallbacks(Callbacks)
      => ComCall(31, this.p, IDebugInputCallbacks.Ptr, Callbacks)
    SetInputCallbacks(Callbacks?)
      => ComCall(32, this.p, IDebugInputCallbacks, Callbacks?)
    GetOutputCallbacks(Callbacks)
      => ComCall(33, this.p, IDebugOutputCallbacks.Ptr, Callbacks)
    SetOutputCallbacks(Callbacks?)
      => ComCall(34, this.p, IDebugOutputCallbacks, Callbacks?)
    GetOutputMask(Mask)
      => ComCall(35, this.p, UInt32.Ptr, Mask)
    SetOutputMask(Mask)
      => ComCall(36, this.p, UInt32, Mask)
    GetOtherOutputMask(Client, Mask)
      => ComCall(37, this.p, IDebugClient, Client, UInt32.Ptr, Mask)
    SetOtherOutputMask(Client, Mask)
      => ComCall(38, this.p, IDebugClient, Client, UInt32, Mask)
    GetOutputWidth(Columns)
      => ComCall(39, this.p, UInt32.Ptr, Columns)
    SetOutputWidth(Columns)
      => ComCall(40, this.p, UInt32, Columns)
    GetOutputLinePrefix(Buffer?, PrefixSize?)
      => ComCall(41, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefix(Prefix?)
      => ComCall(42, this.p, PSTR, Prefix?)
    GetIdentity(Buffer?, IdentitySize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentity(OutputControl, Flags, Format)
      => ComCall(44, this.p, UInt32, OutputControl, UInt32, Flags, PSTR, Format)
    GetEventCallbacks(Callbacks)
      => ComCall(45, this.p, IDebugEventCallbacks.Ptr, Callbacks)
    SetEventCallbacks(Callbacks?)
      => ComCall(46, this.p, IDebugEventCallbacks, Callbacks?)
    FlushCallbacks()
      => ComCall(47, this.p)
    WriteDumpFile2(DumpFile, Qualifier, FormatFlags, Comment?)
      => ComCall(48, this.p, PSTR, DumpFile, UInt32, Qualifier, UInt32, FormatFlags, PSTR, Comment?)
    AddDumpInformationFile(InfoFile, Type)
      => ComCall(49, this.p, PSTR, InfoFile, UInt32, Type)
    EndProcessServer(Server)
      => ComCall(50, this.p, Int64, Server)
    WaitForProcessServerEnd(Timeout)
      => ComCall(51, this.p, UInt32, Timeout)
    IsKernelDebuggerEnabled()
      => ComCall(52, this.p)
    TerminateCurrentProcess()
      => ComCall(53, this.p)
    DetachCurrentProcess()
      => ComCall(54, this.p)
    AbandonCurrentProcess()
      => ComCall(55, this.p)
    GetRunningProcessSystemIdByExecutableNameWide(Server, ExeName, Flags, Id)
      => ComCall(56, this.p, Int64, Server, "Str", ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescriptionWide(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(57, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PWSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PWSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    CreateProcessWide(Server, CommandLine, CreateFlags)
      => ComCall(58, this.p, Int64, Server, "Str", CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttachWide(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(59, this.p, Int64, Server, "Str", CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    OpenDumpFileWide(FileName?, FileHandle)
      => ComCall(60, this.p, "Str", FileName?, Int64, FileHandle)
    WriteDumpFileWide(FileName?, FileHandle, Qualifier, FormatFlags, Comment?)
      => ComCall(61, this.p, "Str", FileName?, Int64, FileHandle, UInt32, Qualifier, UInt32, FormatFlags, "Str", Comment?)
    AddDumpInformationFileWide(FileName?, FileHandle, Type)
      => ComCall(62, this.p, "Str", FileName?, Int64, FileHandle, UInt32, Type)
    GetNumberDumpFiles(Number)
      => ComCall(63, this.p, UInt32.Ptr, Number)
    GetDumpFile(Index, Buffer?, NameSize?, Handle?, Type)
      => ComCall(64, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Handle?, UInt32.Ptr, Type)
    GetDumpFileWide(Index, Buffer?, NameSize?, Handle?, Type)
      => ComCall(65, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Handle?, UInt32.Ptr, Type)
}
struct IDebugClient5 extends IUnknown {
    static IID := "{E3ACB9D7-7EC2-4F0C-A0DA-E81E0CBBE628}"
    AttachKernel(Flags, ConnectOptions?)
      => ComCall(3, this.p, UInt32, Flags, PSTR, ConnectOptions?)
    GetKernelConnectionOptions(Buffer?, OptionsSize?)
      => ComCall(4, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptions(Options)
      => ComCall(5, this.p, PSTR, Options)
    StartProcessServer(Flags, Options)
      => ComCall(6, this.p, UInt32, Flags, PSTR, Options, "Ptr", 0)
    ConnectProcessServer(RemoteOptions, Server)
      => ComCall(7, this.p, PSTR, RemoteOptions, Int64.Ptr, Server)
    DisconnectProcessServer(Server)
      => ComCall(8, this.p, Int64, Server)
    GetRunningProcessSystemIds(Server, Ids?, ActualCount?)
      => ComCall(9, this.p, Int64, Server, UInt32.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, ActualCount?)
    GetRunningProcessSystemIdByExecutableName(Server, ExeName, Flags, Id)
      => ComCall(10, this.p, Int64, Server, PSTR, ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescription(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(11, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    AttachProcess(Server, ProcessId, AttachFlags)
      => ComCall(12, this.p, Int64, Server, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessA(Server, CommandLine, CreateFlags)
      => ComCall(13, this.p, Int64, Server, PSTR, CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttach(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(14, this.p, Int64, Server, PSTR, CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    GetProcessOptions(Options)
      => ComCall(15, this.p, UInt32.Ptr, Options)
    AddProcessOptions(Options)
      => ComCall(16, this.p, UInt32, Options)
    RemoveProcessOptions(Options)
      => ComCall(17, this.p, UInt32, Options)
    SetProcessOptions(Options)
      => ComCall(18, this.p, UInt32, Options)
    OpenDumpFile(DumpFile)
      => ComCall(19, this.p, PSTR, DumpFile)
    WriteDumpFile(DumpFile, Qualifier)
      => ComCall(20, this.p, PSTR, DumpFile, UInt32, Qualifier)
    ConnectSession(Flags, HistoryLimit)
      => ComCall(21, this.p, UInt32, Flags, UInt32, HistoryLimit)
    StartServer(Options)
      => ComCall(22, this.p, PSTR, Options)
    OutputServers(OutputControl, Machine, Flags)
      => ComCall(23, this.p, UInt32, OutputControl, PSTR, Machine, UInt32, Flags)
    TerminateProcesses()
      => ComCall(24, this.p)
    DetachProcesses()
      => ComCall(25, this.p)
    EndSession(Flags)
      => ComCall(26, this.p, UInt32, Flags)
    GetExitCode(Code)
      => ComCall(27, this.p, UInt32.Ptr, Code)
    DispatchCallbacks(Timeout)
      => ComCall(28, this.p, UInt32, Timeout)
    ExitDispatch(Client)
      => ComCall(29, this.p, IDebugClient, Client)
    CreateClient(Client)
      => ComCall(30, this.p, IDebugClient.Ptr, Client)
    GetInputCallbacks(Callbacks)
      => ComCall(31, this.p, IDebugInputCallbacks.Ptr, Callbacks)
    SetInputCallbacks(Callbacks?)
      => ComCall(32, this.p, IDebugInputCallbacks, Callbacks?)
    GetOutputCallbacks(Callbacks)
      => ComCall(33, this.p, IDebugOutputCallbacks.Ptr, Callbacks)
    SetOutputCallbacks(Callbacks?)
      => ComCall(34, this.p, IDebugOutputCallbacks, Callbacks?)
    GetOutputMask(Mask)
      => ComCall(35, this.p, UInt32.Ptr, Mask)
    SetOutputMask(Mask)
      => ComCall(36, this.p, UInt32, Mask)
    GetOtherOutputMask(Client, Mask)
      => ComCall(37, this.p, IDebugClient, Client, UInt32.Ptr, Mask)
    SetOtherOutputMask(Client, Mask)
      => ComCall(38, this.p, IDebugClient, Client, UInt32, Mask)
    GetOutputWidth(Columns)
      => ComCall(39, this.p, UInt32.Ptr, Columns)
    SetOutputWidth(Columns)
      => ComCall(40, this.p, UInt32, Columns)
    GetOutputLinePrefix(Buffer?, PrefixSize?)
      => ComCall(41, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefix(Prefix?)
      => ComCall(42, this.p, PSTR, Prefix?)
    GetIdentity(Buffer?, IdentitySize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentity(OutputControl, Flags, Format)
      => ComCall(44, this.p, UInt32, OutputControl, UInt32, Flags, PSTR, Format)
    GetEventCallbacks(Callbacks)
      => ComCall(45, this.p, IDebugEventCallbacks.Ptr, Callbacks)
    SetEventCallbacks(Callbacks?)
      => ComCall(46, this.p, IDebugEventCallbacks, Callbacks?)
    FlushCallbacks()
      => ComCall(47, this.p)
    WriteDumpFile2(DumpFile, Qualifier, FormatFlags, Comment?)
      => ComCall(48, this.p, PSTR, DumpFile, UInt32, Qualifier, UInt32, FormatFlags, PSTR, Comment?)
    AddDumpInformationFile(InfoFile, Type)
      => ComCall(49, this.p, PSTR, InfoFile, UInt32, Type)
    EndProcessServer(Server)
      => ComCall(50, this.p, Int64, Server)
    WaitForProcessServerEnd(Timeout)
      => ComCall(51, this.p, UInt32, Timeout)
    IsKernelDebuggerEnabled()
      => ComCall(52, this.p)
    TerminateCurrentProcess()
      => ComCall(53, this.p)
    DetachCurrentProcess()
      => ComCall(54, this.p)
    AbandonCurrentProcess()
      => ComCall(55, this.p)
    GetRunningProcessSystemIdByExecutableNameWide(Server, ExeName, Flags, Id)
      => ComCall(56, this.p, Int64, Server, "Str", ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescriptionWide(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(57, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PWSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PWSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    CreateProcessWide(Server, CommandLine, CreateFlags)
      => ComCall(58, this.p, Int64, Server, "Str", CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttachWide(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(59, this.p, Int64, Server, "Str", CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    OpenDumpFileWide(FileName?, FileHandle)
      => ComCall(60, this.p, "Str", FileName?, Int64, FileHandle)
    WriteDumpFileWide(FileName?, FileHandle, Qualifier, FormatFlags, Comment?)
      => ComCall(61, this.p, "Str", FileName?, Int64, FileHandle, UInt32, Qualifier, UInt32, FormatFlags, "Str", Comment?)
    AddDumpInformationFileWide(FileName?, FileHandle, Type)
      => ComCall(62, this.p, "Str", FileName?, Int64, FileHandle, UInt32, Type)
    GetNumberDumpFiles(Number)
      => ComCall(63, this.p, UInt32.Ptr, Number)
    GetDumpFile(Index, Buffer?, NameSize?, Handle?, Type)
      => ComCall(64, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Handle?, UInt32.Ptr, Type)
    GetDumpFileWide(Index, Buffer?, NameSize?, Handle?, Type)
      => ComCall(65, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Handle?, UInt32.Ptr, Type)
    AttachKernelWide(Flags, ConnectOptions?)
      => ComCall(66, this.p, UInt32, Flags, "Str", ConnectOptions?)
    GetKernelConnectionOptionsWide(Buffer?, OptionsSize?)
      => ComCall(67, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptionsWide(Options)
      => ComCall(68, this.p, "Str", Options)
    StartProcessServerWide(Flags, Options)
      => ComCall(69, this.p, UInt32, Flags, "Str", Options, "Ptr", 0)
    ConnectProcessServerWide(RemoteOptions, Server)
      => ComCall(70, this.p, "Str", RemoteOptions, Int64.Ptr, Server)
    StartServerWide(Options)
      => ComCall(71, this.p, "Str", Options)
    OutputServersWide(OutputControl, Machine, Flags)
      => ComCall(72, this.p, UInt32, OutputControl, "Str", Machine, UInt32, Flags)
    GetOutputCallbacksWide(Callbacks)
      => ComCall(73, this.p, IDebugOutputCallbacksWide.Ptr, Callbacks)
    SetOutputCallbacksWide(Callbacks)
      => ComCall(74, this.p, IDebugOutputCallbacksWide, Callbacks)
    GetOutputLinePrefixWide(Buffer?, PrefixSize?)
      => ComCall(75, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefixWide(Prefix?)
      => ComCall(76, this.p, "Str", Prefix?)
    GetIdentityWide(Buffer?, IdentitySize?)
      => ComCall(77, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentityWide(OutputControl, Flags, Format)
      => ComCall(78, this.p, UInt32, OutputControl, UInt32, Flags, "Str", Format)
    GetEventCallbacksWide(Callbacks)
      => ComCall(79, this.p, IDebugEventCallbacksWide.Ptr, Callbacks)
    SetEventCallbacksWide(Callbacks)
      => ComCall(80, this.p, IDebugEventCallbacksWide, Callbacks)
    CreateProcess2(Server, CommandLine, OptionsBuffer, InitialDirectory?, Environment?)
      => ComCall(81, this.p, Int64, Server, PSTR, CommandLine, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, PSTR, InitialDirectory?, PSTR, Environment?)
    CreateProcess2Wide(Server, CommandLine, OptionsBuffer, InitialDirectory?, Environment?)
      => ComCall(82, this.p, Int64, Server, "Str", CommandLine, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, "Str", InitialDirectory?, "Str", Environment?)
    CreateProcessAndAttach2(Server, CommandLine?, OptionsBuffer, InitialDirectory?, Environment?, ProcessId, AttachFlags)
      => ComCall(83, this.p, Int64, Server, PSTR, CommandLine?, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, PSTR, InitialDirectory?, PSTR, Environment?, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessAndAttach2Wide(Server, CommandLine?, OptionsBuffer, InitialDirectory?, Environment?, ProcessId, AttachFlags)
      => ComCall(84, this.p, Int64, Server, "Str", CommandLine?, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, "Str", InitialDirectory?, "Str", Environment?, UInt32, ProcessId, UInt32, AttachFlags)
    PushOutputLinePrefix(NewPrefix?, Handle)
      => ComCall(85, this.p, PSTR, NewPrefix?, Int64.Ptr, Handle)
    PushOutputLinePrefixWide(NewPrefix?, Handle)
      => ComCall(86, this.p, "Str", NewPrefix?, Int64.Ptr, Handle)
    PopOutputLinePrefix(Handle)
      => ComCall(87, this.p, Int64, Handle)
    GetNumberInputCallbacks(Count)
      => ComCall(88, this.p, UInt32.Ptr, Count)
    GetNumberOutputCallbacks(Count)
      => ComCall(89, this.p, UInt32.Ptr, Count)
    GetNumberEventCallbacks(EventFlags, Count)
      => ComCall(90, this.p, UInt32, EventFlags, UInt32.Ptr, Count)
    GetQuitLockString(Buffer?, StringSize?)
      => ComCall(91, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    SetQuitLockString(String)
      => ComCall(92, this.p, PSTR, String)
    GetQuitLockStringWide(Buffer?, StringSize?)
      => ComCall(93, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    SetQuitLockStringWide(String)
      => ComCall(94, this.p, "Str", String)
}
struct IDebugClient6 extends IUnknown {
    static IID := "{FD28B4C5-C498-4686-A28E-62CAD2154EB3}"
    AttachKernel(Flags, ConnectOptions?)
      => ComCall(3, this.p, UInt32, Flags, PSTR, ConnectOptions?)
    GetKernelConnectionOptions(Buffer?, OptionsSize?)
      => ComCall(4, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptions(Options)
      => ComCall(5, this.p, PSTR, Options)
    StartProcessServer(Flags, Options)
      => ComCall(6, this.p, UInt32, Flags, PSTR, Options, "Ptr", 0)
    ConnectProcessServer(RemoteOptions, Server)
      => ComCall(7, this.p, PSTR, RemoteOptions, Int64.Ptr, Server)
    DisconnectProcessServer(Server)
      => ComCall(8, this.p, Int64, Server)
    GetRunningProcessSystemIds(Server, Ids?, ActualCount?)
      => ComCall(9, this.p, Int64, Server, UInt32.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, ActualCount?)
    GetRunningProcessSystemIdByExecutableName(Server, ExeName, Flags, Id)
      => ComCall(10, this.p, Int64, Server, PSTR, ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescription(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(11, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    AttachProcess(Server, ProcessId, AttachFlags)
      => ComCall(12, this.p, Int64, Server, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessA(Server, CommandLine, CreateFlags)
      => ComCall(13, this.p, Int64, Server, PSTR, CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttach(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(14, this.p, Int64, Server, PSTR, CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    GetProcessOptions(Options)
      => ComCall(15, this.p, UInt32.Ptr, Options)
    AddProcessOptions(Options)
      => ComCall(16, this.p, UInt32, Options)
    RemoveProcessOptions(Options)
      => ComCall(17, this.p, UInt32, Options)
    SetProcessOptions(Options)
      => ComCall(18, this.p, UInt32, Options)
    OpenDumpFile(DumpFile)
      => ComCall(19, this.p, PSTR, DumpFile)
    WriteDumpFile(DumpFile, Qualifier)
      => ComCall(20, this.p, PSTR, DumpFile, UInt32, Qualifier)
    ConnectSession(Flags, HistoryLimit)
      => ComCall(21, this.p, UInt32, Flags, UInt32, HistoryLimit)
    StartServer(Options)
      => ComCall(22, this.p, PSTR, Options)
    OutputServers(OutputControl, Machine, Flags)
      => ComCall(23, this.p, UInt32, OutputControl, PSTR, Machine, UInt32, Flags)
    TerminateProcesses()
      => ComCall(24, this.p)
    DetachProcesses()
      => ComCall(25, this.p)
    EndSession(Flags)
      => ComCall(26, this.p, UInt32, Flags)
    GetExitCode(Code)
      => ComCall(27, this.p, UInt32.Ptr, Code)
    DispatchCallbacks(Timeout)
      => ComCall(28, this.p, UInt32, Timeout)
    ExitDispatch(Client)
      => ComCall(29, this.p, IDebugClient, Client)
    CreateClient(Client)
      => ComCall(30, this.p, IDebugClient.Ptr, Client)
    GetInputCallbacks(Callbacks)
      => ComCall(31, this.p, IDebugInputCallbacks.Ptr, Callbacks)
    SetInputCallbacks(Callbacks?)
      => ComCall(32, this.p, IDebugInputCallbacks, Callbacks?)
    GetOutputCallbacks(Callbacks)
      => ComCall(33, this.p, IDebugOutputCallbacks.Ptr, Callbacks)
    SetOutputCallbacks(Callbacks?)
      => ComCall(34, this.p, IDebugOutputCallbacks, Callbacks?)
    GetOutputMask(Mask)
      => ComCall(35, this.p, UInt32.Ptr, Mask)
    SetOutputMask(Mask)
      => ComCall(36, this.p, UInt32, Mask)
    GetOtherOutputMask(Client, Mask)
      => ComCall(37, this.p, IDebugClient, Client, UInt32.Ptr, Mask)
    SetOtherOutputMask(Client, Mask)
      => ComCall(38, this.p, IDebugClient, Client, UInt32, Mask)
    GetOutputWidth(Columns)
      => ComCall(39, this.p, UInt32.Ptr, Columns)
    SetOutputWidth(Columns)
      => ComCall(40, this.p, UInt32, Columns)
    GetOutputLinePrefix(Buffer?, PrefixSize?)
      => ComCall(41, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefix(Prefix?)
      => ComCall(42, this.p, PSTR, Prefix?)
    GetIdentity(Buffer?, IdentitySize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentity(OutputControl, Flags, Format)
      => ComCall(44, this.p, UInt32, OutputControl, UInt32, Flags, PSTR, Format)
    GetEventCallbacks(Callbacks)
      => ComCall(45, this.p, IDebugEventCallbacks.Ptr, Callbacks)
    SetEventCallbacks(Callbacks?)
      => ComCall(46, this.p, IDebugEventCallbacks, Callbacks?)
    FlushCallbacks()
      => ComCall(47, this.p)
    WriteDumpFile2(DumpFile, Qualifier, FormatFlags, Comment?)
      => ComCall(48, this.p, PSTR, DumpFile, UInt32, Qualifier, UInt32, FormatFlags, PSTR, Comment?)
    AddDumpInformationFile(InfoFile, Type)
      => ComCall(49, this.p, PSTR, InfoFile, UInt32, Type)
    EndProcessServer(Server)
      => ComCall(50, this.p, Int64, Server)
    WaitForProcessServerEnd(Timeout)
      => ComCall(51, this.p, UInt32, Timeout)
    IsKernelDebuggerEnabled()
      => ComCall(52, this.p)
    TerminateCurrentProcess()
      => ComCall(53, this.p)
    DetachCurrentProcess()
      => ComCall(54, this.p)
    AbandonCurrentProcess()
      => ComCall(55, this.p)
    GetRunningProcessSystemIdByExecutableNameWide(Server, ExeName, Flags, Id)
      => ComCall(56, this.p, Int64, Server, "Str", ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescriptionWide(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(57, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PWSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PWSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    CreateProcessWide(Server, CommandLine, CreateFlags)
      => ComCall(58, this.p, Int64, Server, "Str", CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttachWide(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(59, this.p, Int64, Server, "Str", CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    OpenDumpFileWide(FileName?, FileHandle)
      => ComCall(60, this.p, "Str", FileName?, Int64, FileHandle)
    WriteDumpFileWide(FileName?, FileHandle, Qualifier, FormatFlags, Comment?)
      => ComCall(61, this.p, "Str", FileName?, Int64, FileHandle, UInt32, Qualifier, UInt32, FormatFlags, "Str", Comment?)
    AddDumpInformationFileWide(FileName?, FileHandle, Type)
      => ComCall(62, this.p, "Str", FileName?, Int64, FileHandle, UInt32, Type)
    GetNumberDumpFiles(Number)
      => ComCall(63, this.p, UInt32.Ptr, Number)
    GetDumpFile(Index, Buffer?, NameSize?, Handle?, Type)
      => ComCall(64, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Handle?, UInt32.Ptr, Type)
    GetDumpFileWide(Index, Buffer?, NameSize?, Handle?, Type)
      => ComCall(65, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Handle?, UInt32.Ptr, Type)
    AttachKernelWide(Flags, ConnectOptions?)
      => ComCall(66, this.p, UInt32, Flags, "Str", ConnectOptions?)
    GetKernelConnectionOptionsWide(Buffer?, OptionsSize?)
      => ComCall(67, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptionsWide(Options)
      => ComCall(68, this.p, "Str", Options)
    StartProcessServerWide(Flags, Options)
      => ComCall(69, this.p, UInt32, Flags, "Str", Options, "Ptr", 0)
    ConnectProcessServerWide(RemoteOptions, Server)
      => ComCall(70, this.p, "Str", RemoteOptions, Int64.Ptr, Server)
    StartServerWide(Options)
      => ComCall(71, this.p, "Str", Options)
    OutputServersWide(OutputControl, Machine, Flags)
      => ComCall(72, this.p, UInt32, OutputControl, "Str", Machine, UInt32, Flags)
    GetOutputCallbacksWide(Callbacks)
      => ComCall(73, this.p, IDebugOutputCallbacksWide.Ptr, Callbacks)
    SetOutputCallbacksWide(Callbacks)
      => ComCall(74, this.p, IDebugOutputCallbacksWide, Callbacks)
    GetOutputLinePrefixWide(Buffer?, PrefixSize?)
      => ComCall(75, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefixWide(Prefix?)
      => ComCall(76, this.p, "Str", Prefix?)
    GetIdentityWide(Buffer?, IdentitySize?)
      => ComCall(77, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentityWide(OutputControl, Flags, Format)
      => ComCall(78, this.p, UInt32, OutputControl, UInt32, Flags, "Str", Format)
    GetEventCallbacksWide(Callbacks)
      => ComCall(79, this.p, IDebugEventCallbacksWide.Ptr, Callbacks)
    SetEventCallbacksWide(Callbacks)
      => ComCall(80, this.p, IDebugEventCallbacksWide, Callbacks)
    CreateProcess2(Server, CommandLine, OptionsBuffer, InitialDirectory?, Environment?)
      => ComCall(81, this.p, Int64, Server, PSTR, CommandLine, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, PSTR, InitialDirectory?, PSTR, Environment?)
    CreateProcess2Wide(Server, CommandLine, OptionsBuffer, InitialDirectory?, Environment?)
      => ComCall(82, this.p, Int64, Server, "Str", CommandLine, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, "Str", InitialDirectory?, "Str", Environment?)
    CreateProcessAndAttach2(Server, CommandLine?, OptionsBuffer, InitialDirectory?, Environment?, ProcessId, AttachFlags)
      => ComCall(83, this.p, Int64, Server, PSTR, CommandLine?, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, PSTR, InitialDirectory?, PSTR, Environment?, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessAndAttach2Wide(Server, CommandLine?, OptionsBuffer, InitialDirectory?, Environment?, ProcessId, AttachFlags)
      => ComCall(84, this.p, Int64, Server, "Str", CommandLine?, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, "Str", InitialDirectory?, "Str", Environment?, UInt32, ProcessId, UInt32, AttachFlags)
    PushOutputLinePrefix(NewPrefix?, Handle)
      => ComCall(85, this.p, PSTR, NewPrefix?, Int64.Ptr, Handle)
    PushOutputLinePrefixWide(NewPrefix?, Handle)
      => ComCall(86, this.p, "Str", NewPrefix?, Int64.Ptr, Handle)
    PopOutputLinePrefix(Handle)
      => ComCall(87, this.p, Int64, Handle)
    GetNumberInputCallbacks(Count)
      => ComCall(88, this.p, UInt32.Ptr, Count)
    GetNumberOutputCallbacks(Count)
      => ComCall(89, this.p, UInt32.Ptr, Count)
    GetNumberEventCallbacks(EventFlags, Count)
      => ComCall(90, this.p, UInt32, EventFlags, UInt32.Ptr, Count)
    GetQuitLockString(Buffer?, StringSize?)
      => ComCall(91, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    SetQuitLockString(String)
      => ComCall(92, this.p, PSTR, String)
    GetQuitLockStringWide(Buffer?, StringSize?)
      => ComCall(93, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    SetQuitLockStringWide(String)
      => ComCall(94, this.p, "Str", String)
    SetEventContextCallbacks(Callbacks?)
      => ComCall(95, this.p, IDebugEventContextCallbacks, Callbacks?)
}
struct IDebugClient7 extends IUnknown {
    static IID := "{13586BE3-542E-481E-B1F2-8497BA74F9A9}"
    AttachKernel(Flags, ConnectOptions?)
      => ComCall(3, this.p, UInt32, Flags, PSTR, ConnectOptions?)
    GetKernelConnectionOptions(Buffer?, OptionsSize?)
      => ComCall(4, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptions(Options)
      => ComCall(5, this.p, PSTR, Options)
    StartProcessServer(Flags, Options)
      => ComCall(6, this.p, UInt32, Flags, PSTR, Options, "Ptr", 0)
    ConnectProcessServer(RemoteOptions, Server)
      => ComCall(7, this.p, PSTR, RemoteOptions, Int64.Ptr, Server)
    DisconnectProcessServer(Server)
      => ComCall(8, this.p, Int64, Server)
    GetRunningProcessSystemIds(Server, Ids?, ActualCount?)
      => ComCall(9, this.p, Int64, Server, UInt32.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, ActualCount?)
    GetRunningProcessSystemIdByExecutableName(Server, ExeName, Flags, Id)
      => ComCall(10, this.p, Int64, Server, PSTR, ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescription(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(11, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    AttachProcess(Server, ProcessId, AttachFlags)
      => ComCall(12, this.p, Int64, Server, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessA(Server, CommandLine, CreateFlags)
      => ComCall(13, this.p, Int64, Server, PSTR, CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttach(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(14, this.p, Int64, Server, PSTR, CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    GetProcessOptions(Options)
      => ComCall(15, this.p, UInt32.Ptr, Options)
    AddProcessOptions(Options)
      => ComCall(16, this.p, UInt32, Options)
    RemoveProcessOptions(Options)
      => ComCall(17, this.p, UInt32, Options)
    SetProcessOptions(Options)
      => ComCall(18, this.p, UInt32, Options)
    OpenDumpFile(DumpFile)
      => ComCall(19, this.p, PSTR, DumpFile)
    WriteDumpFile(DumpFile, Qualifier)
      => ComCall(20, this.p, PSTR, DumpFile, UInt32, Qualifier)
    ConnectSession(Flags, HistoryLimit)
      => ComCall(21, this.p, UInt32, Flags, UInt32, HistoryLimit)
    StartServer(Options)
      => ComCall(22, this.p, PSTR, Options)
    OutputServers(OutputControl, Machine, Flags)
      => ComCall(23, this.p, UInt32, OutputControl, PSTR, Machine, UInt32, Flags)
    TerminateProcesses()
      => ComCall(24, this.p)
    DetachProcesses()
      => ComCall(25, this.p)
    EndSession(Flags)
      => ComCall(26, this.p, UInt32, Flags)
    GetExitCode(Code)
      => ComCall(27, this.p, UInt32.Ptr, Code)
    DispatchCallbacks(Timeout)
      => ComCall(28, this.p, UInt32, Timeout)
    ExitDispatch(Client)
      => ComCall(29, this.p, IDebugClient, Client)
    CreateClient(Client)
      => ComCall(30, this.p, IDebugClient.Ptr, Client)
    GetInputCallbacks(Callbacks)
      => ComCall(31, this.p, IDebugInputCallbacks.Ptr, Callbacks)
    SetInputCallbacks(Callbacks?)
      => ComCall(32, this.p, IDebugInputCallbacks, Callbacks?)
    GetOutputCallbacks(Callbacks)
      => ComCall(33, this.p, IDebugOutputCallbacks.Ptr, Callbacks)
    SetOutputCallbacks(Callbacks?)
      => ComCall(34, this.p, IDebugOutputCallbacks, Callbacks?)
    GetOutputMask(Mask)
      => ComCall(35, this.p, UInt32.Ptr, Mask)
    SetOutputMask(Mask)
      => ComCall(36, this.p, UInt32, Mask)
    GetOtherOutputMask(Client, Mask)
      => ComCall(37, this.p, IDebugClient, Client, UInt32.Ptr, Mask)
    SetOtherOutputMask(Client, Mask)
      => ComCall(38, this.p, IDebugClient, Client, UInt32, Mask)
    GetOutputWidth(Columns)
      => ComCall(39, this.p, UInt32.Ptr, Columns)
    SetOutputWidth(Columns)
      => ComCall(40, this.p, UInt32, Columns)
    GetOutputLinePrefix(Buffer?, PrefixSize?)
      => ComCall(41, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefix(Prefix?)
      => ComCall(42, this.p, PSTR, Prefix?)
    GetIdentity(Buffer?, IdentitySize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentity(OutputControl, Flags, Format)
      => ComCall(44, this.p, UInt32, OutputControl, UInt32, Flags, PSTR, Format)
    GetEventCallbacks(Callbacks)
      => ComCall(45, this.p, IDebugEventCallbacks.Ptr, Callbacks)
    SetEventCallbacks(Callbacks?)
      => ComCall(46, this.p, IDebugEventCallbacks, Callbacks?)
    FlushCallbacks()
      => ComCall(47, this.p)
    WriteDumpFile2(DumpFile, Qualifier, FormatFlags, Comment?)
      => ComCall(48, this.p, PSTR, DumpFile, UInt32, Qualifier, UInt32, FormatFlags, PSTR, Comment?)
    AddDumpInformationFile(InfoFile, Type)
      => ComCall(49, this.p, PSTR, InfoFile, UInt32, Type)
    EndProcessServer(Server)
      => ComCall(50, this.p, Int64, Server)
    WaitForProcessServerEnd(Timeout)
      => ComCall(51, this.p, UInt32, Timeout)
    IsKernelDebuggerEnabled()
      => ComCall(52, this.p)
    TerminateCurrentProcess()
      => ComCall(53, this.p)
    DetachCurrentProcess()
      => ComCall(54, this.p)
    AbandonCurrentProcess()
      => ComCall(55, this.p)
    GetRunningProcessSystemIdByExecutableNameWide(Server, ExeName, Flags, Id)
      => ComCall(56, this.p, Int64, Server, "Str", ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescriptionWide(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(57, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PWSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PWSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    CreateProcessWide(Server, CommandLine, CreateFlags)
      => ComCall(58, this.p, Int64, Server, "Str", CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttachWide(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(59, this.p, Int64, Server, "Str", CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    OpenDumpFileWide(FileName?, FileHandle)
      => ComCall(60, this.p, "Str", FileName?, Int64, FileHandle)
    WriteDumpFileWide(FileName?, FileHandle, Qualifier, FormatFlags, Comment?)
      => ComCall(61, this.p, "Str", FileName?, Int64, FileHandle, UInt32, Qualifier, UInt32, FormatFlags, "Str", Comment?)
    AddDumpInformationFileWide(FileName?, FileHandle, Type)
      => ComCall(62, this.p, "Str", FileName?, Int64, FileHandle, UInt32, Type)
    GetNumberDumpFiles(Number)
      => ComCall(63, this.p, UInt32.Ptr, Number)
    GetDumpFile(Index, Buffer?, NameSize?, Handle?, Type)
      => ComCall(64, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Handle?, UInt32.Ptr, Type)
    GetDumpFileWide(Index, Buffer?, NameSize?, Handle?, Type)
      => ComCall(65, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Handle?, UInt32.Ptr, Type)
    AttachKernelWide(Flags, ConnectOptions?)
      => ComCall(66, this.p, UInt32, Flags, "Str", ConnectOptions?)
    GetKernelConnectionOptionsWide(Buffer?, OptionsSize?)
      => ComCall(67, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptionsWide(Options)
      => ComCall(68, this.p, "Str", Options)
    StartProcessServerWide(Flags, Options)
      => ComCall(69, this.p, UInt32, Flags, "Str", Options, "Ptr", 0)
    ConnectProcessServerWide(RemoteOptions, Server)
      => ComCall(70, this.p, "Str", RemoteOptions, Int64.Ptr, Server)
    StartServerWide(Options)
      => ComCall(71, this.p, "Str", Options)
    OutputServersWide(OutputControl, Machine, Flags)
      => ComCall(72, this.p, UInt32, OutputControl, "Str", Machine, UInt32, Flags)
    GetOutputCallbacksWide(Callbacks)
      => ComCall(73, this.p, IDebugOutputCallbacksWide.Ptr, Callbacks)
    SetOutputCallbacksWide(Callbacks)
      => ComCall(74, this.p, IDebugOutputCallbacksWide, Callbacks)
    GetOutputLinePrefixWide(Buffer?, PrefixSize?)
      => ComCall(75, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefixWide(Prefix?)
      => ComCall(76, this.p, "Str", Prefix?)
    GetIdentityWide(Buffer?, IdentitySize?)
      => ComCall(77, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentityWide(OutputControl, Flags, Format)
      => ComCall(78, this.p, UInt32, OutputControl, UInt32, Flags, "Str", Format)
    GetEventCallbacksWide(Callbacks)
      => ComCall(79, this.p, IDebugEventCallbacksWide.Ptr, Callbacks)
    SetEventCallbacksWide(Callbacks)
      => ComCall(80, this.p, IDebugEventCallbacksWide, Callbacks)
    CreateProcess2(Server, CommandLine, OptionsBuffer, InitialDirectory?, Environment?)
      => ComCall(81, this.p, Int64, Server, PSTR, CommandLine, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, PSTR, InitialDirectory?, PSTR, Environment?)
    CreateProcess2Wide(Server, CommandLine, OptionsBuffer, InitialDirectory?, Environment?)
      => ComCall(82, this.p, Int64, Server, "Str", CommandLine, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, "Str", InitialDirectory?, "Str", Environment?)
    CreateProcessAndAttach2(Server, CommandLine?, OptionsBuffer, InitialDirectory?, Environment?, ProcessId, AttachFlags)
      => ComCall(83, this.p, Int64, Server, PSTR, CommandLine?, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, PSTR, InitialDirectory?, PSTR, Environment?, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessAndAttach2Wide(Server, CommandLine?, OptionsBuffer, InitialDirectory?, Environment?, ProcessId, AttachFlags)
      => ComCall(84, this.p, Int64, Server, "Str", CommandLine?, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, "Str", InitialDirectory?, "Str", Environment?, UInt32, ProcessId, UInt32, AttachFlags)
    PushOutputLinePrefix(NewPrefix?, Handle)
      => ComCall(85, this.p, PSTR, NewPrefix?, Int64.Ptr, Handle)
    PushOutputLinePrefixWide(NewPrefix?, Handle)
      => ComCall(86, this.p, "Str", NewPrefix?, Int64.Ptr, Handle)
    PopOutputLinePrefix(Handle)
      => ComCall(87, this.p, Int64, Handle)
    GetNumberInputCallbacks(Count)
      => ComCall(88, this.p, UInt32.Ptr, Count)
    GetNumberOutputCallbacks(Count)
      => ComCall(89, this.p, UInt32.Ptr, Count)
    GetNumberEventCallbacks(EventFlags, Count)
      => ComCall(90, this.p, UInt32, EventFlags, UInt32.Ptr, Count)
    GetQuitLockString(Buffer?, StringSize?)
      => ComCall(91, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    SetQuitLockString(String)
      => ComCall(92, this.p, PSTR, String)
    GetQuitLockStringWide(Buffer?, StringSize?)
      => ComCall(93, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    SetQuitLockStringWide(String)
      => ComCall(94, this.p, "Str", String)
    SetEventContextCallbacks(Callbacks?)
      => ComCall(95, this.p, IDebugEventContextCallbacks, Callbacks?)
    SetClientContext(Context)
      => ComCall(96, this.p, Struct.Ptr, Context, UInt32, Context.Size)
}
struct IDebugClient8 extends IUnknown {
    static IID := "{CEC43ADD-6375-469E-83D5-414E4033C19A}"
    AttachKernel(Flags, ConnectOptions?)
      => ComCall(3, this.p, UInt32, Flags, PSTR, ConnectOptions?)
    GetKernelConnectionOptions(Buffer?, OptionsSize?)
      => ComCall(4, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptions(Options)
      => ComCall(5, this.p, PSTR, Options)
    StartProcessServer(Flags, Options)
      => ComCall(6, this.p, UInt32, Flags, PSTR, Options, "Ptr", 0)
    ConnectProcessServer(RemoteOptions, Server)
      => ComCall(7, this.p, PSTR, RemoteOptions, Int64.Ptr, Server)
    DisconnectProcessServer(Server)
      => ComCall(8, this.p, Int64, Server)
    GetRunningProcessSystemIds(Server, Ids?, ActualCount?)
      => ComCall(9, this.p, Int64, Server, UInt32.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, ActualCount?)
    GetRunningProcessSystemIdByExecutableName(Server, ExeName, Flags, Id)
      => ComCall(10, this.p, Int64, Server, PSTR, ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescription(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(11, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    AttachProcess(Server, ProcessId, AttachFlags)
      => ComCall(12, this.p, Int64, Server, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessA(Server, CommandLine, CreateFlags)
      => ComCall(13, this.p, Int64, Server, PSTR, CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttach(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(14, this.p, Int64, Server, PSTR, CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    GetProcessOptions(Options)
      => ComCall(15, this.p, UInt32.Ptr, Options)
    AddProcessOptions(Options)
      => ComCall(16, this.p, UInt32, Options)
    RemoveProcessOptions(Options)
      => ComCall(17, this.p, UInt32, Options)
    SetProcessOptions(Options)
      => ComCall(18, this.p, UInt32, Options)
    OpenDumpFile(DumpFile)
      => ComCall(19, this.p, PSTR, DumpFile)
    WriteDumpFile(DumpFile, Qualifier)
      => ComCall(20, this.p, PSTR, DumpFile, UInt32, Qualifier)
    ConnectSession(Flags, HistoryLimit)
      => ComCall(21, this.p, UInt32, Flags, UInt32, HistoryLimit)
    StartServer(Options)
      => ComCall(22, this.p, PSTR, Options)
    OutputServers(OutputControl, Machine, Flags)
      => ComCall(23, this.p, UInt32, OutputControl, PSTR, Machine, UInt32, Flags)
    TerminateProcesses()
      => ComCall(24, this.p)
    DetachProcesses()
      => ComCall(25, this.p)
    EndSession(Flags)
      => ComCall(26, this.p, UInt32, Flags)
    GetExitCode(Code)
      => ComCall(27, this.p, UInt32.Ptr, Code)
    DispatchCallbacks(Timeout)
      => ComCall(28, this.p, UInt32, Timeout)
    ExitDispatch(Client)
      => ComCall(29, this.p, IDebugClient, Client)
    CreateClient(Client)
      => ComCall(30, this.p, IDebugClient.Ptr, Client)
    GetInputCallbacks(Callbacks)
      => ComCall(31, this.p, IDebugInputCallbacks.Ptr, Callbacks)
    SetInputCallbacks(Callbacks?)
      => ComCall(32, this.p, IDebugInputCallbacks, Callbacks?)
    GetOutputCallbacks(Callbacks)
      => ComCall(33, this.p, IDebugOutputCallbacks.Ptr, Callbacks)
    SetOutputCallbacks(Callbacks?)
      => ComCall(34, this.p, IDebugOutputCallbacks, Callbacks?)
    GetOutputMask(Mask)
      => ComCall(35, this.p, UInt32.Ptr, Mask)
    SetOutputMask(Mask)
      => ComCall(36, this.p, UInt32, Mask)
    GetOtherOutputMask(Client, Mask)
      => ComCall(37, this.p, IDebugClient, Client, UInt32.Ptr, Mask)
    SetOtherOutputMask(Client, Mask)
      => ComCall(38, this.p, IDebugClient, Client, UInt32, Mask)
    GetOutputWidth(Columns)
      => ComCall(39, this.p, UInt32.Ptr, Columns)
    SetOutputWidth(Columns)
      => ComCall(40, this.p, UInt32, Columns)
    GetOutputLinePrefix(Buffer?, PrefixSize?)
      => ComCall(41, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefix(Prefix?)
      => ComCall(42, this.p, PSTR, Prefix?)
    GetIdentity(Buffer?, IdentitySize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentity(OutputControl, Flags, Format)
      => ComCall(44, this.p, UInt32, OutputControl, UInt32, Flags, PSTR, Format)
    GetEventCallbacks(Callbacks)
      => ComCall(45, this.p, IDebugEventCallbacks.Ptr, Callbacks)
    SetEventCallbacks(Callbacks?)
      => ComCall(46, this.p, IDebugEventCallbacks, Callbacks?)
    FlushCallbacks()
      => ComCall(47, this.p)
    WriteDumpFile2(DumpFile, Qualifier, FormatFlags, Comment?)
      => ComCall(48, this.p, PSTR, DumpFile, UInt32, Qualifier, UInt32, FormatFlags, PSTR, Comment?)
    AddDumpInformationFile(InfoFile, Type)
      => ComCall(49, this.p, PSTR, InfoFile, UInt32, Type)
    EndProcessServer(Server)
      => ComCall(50, this.p, Int64, Server)
    WaitForProcessServerEnd(Timeout)
      => ComCall(51, this.p, UInt32, Timeout)
    IsKernelDebuggerEnabled()
      => ComCall(52, this.p)
    TerminateCurrentProcess()
      => ComCall(53, this.p)
    DetachCurrentProcess()
      => ComCall(54, this.p)
    AbandonCurrentProcess()
      => ComCall(55, this.p)
    GetRunningProcessSystemIdByExecutableNameWide(Server, ExeName, Flags, Id)
      => ComCall(56, this.p, Int64, Server, "Str", ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescriptionWide(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(57, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PWSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PWSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    CreateProcessWide(Server, CommandLine, CreateFlags)
      => ComCall(58, this.p, Int64, Server, "Str", CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttachWide(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(59, this.p, Int64, Server, "Str", CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    OpenDumpFileWide(FileName?, FileHandle)
      => ComCall(60, this.p, "Str", FileName?, Int64, FileHandle)
    WriteDumpFileWide(FileName?, FileHandle, Qualifier, FormatFlags, Comment?)
      => ComCall(61, this.p, "Str", FileName?, Int64, FileHandle, UInt32, Qualifier, UInt32, FormatFlags, "Str", Comment?)
    AddDumpInformationFileWide(FileName?, FileHandle, Type)
      => ComCall(62, this.p, "Str", FileName?, Int64, FileHandle, UInt32, Type)
    GetNumberDumpFiles(Number)
      => ComCall(63, this.p, UInt32.Ptr, Number)
    GetDumpFile(Index, Buffer?, NameSize?, Handle?, Type)
      => ComCall(64, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Handle?, UInt32.Ptr, Type)
    GetDumpFileWide(Index, Buffer?, NameSize?, Handle?, Type)
      => ComCall(65, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Handle?, UInt32.Ptr, Type)
    AttachKernelWide(Flags, ConnectOptions?)
      => ComCall(66, this.p, UInt32, Flags, "Str", ConnectOptions?)
    GetKernelConnectionOptionsWide(Buffer?, OptionsSize?)
      => ComCall(67, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptionsWide(Options)
      => ComCall(68, this.p, "Str", Options)
    StartProcessServerWide(Flags, Options)
      => ComCall(69, this.p, UInt32, Flags, "Str", Options, "Ptr", 0)
    ConnectProcessServerWide(RemoteOptions, Server)
      => ComCall(70, this.p, "Str", RemoteOptions, Int64.Ptr, Server)
    StartServerWide(Options)
      => ComCall(71, this.p, "Str", Options)
    OutputServersWide(OutputControl, Machine, Flags)
      => ComCall(72, this.p, UInt32, OutputControl, "Str", Machine, UInt32, Flags)
    GetOutputCallbacksWide(Callbacks)
      => ComCall(73, this.p, IDebugOutputCallbacksWide.Ptr, Callbacks)
    SetOutputCallbacksWide(Callbacks)
      => ComCall(74, this.p, IDebugOutputCallbacksWide, Callbacks)
    GetOutputLinePrefixWide(Buffer?, PrefixSize?)
      => ComCall(75, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefixWide(Prefix?)
      => ComCall(76, this.p, "Str", Prefix?)
    GetIdentityWide(Buffer?, IdentitySize?)
      => ComCall(77, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentityWide(OutputControl, Flags, Format)
      => ComCall(78, this.p, UInt32, OutputControl, UInt32, Flags, "Str", Format)
    GetEventCallbacksWide(Callbacks)
      => ComCall(79, this.p, IDebugEventCallbacksWide.Ptr, Callbacks)
    SetEventCallbacksWide(Callbacks)
      => ComCall(80, this.p, IDebugEventCallbacksWide, Callbacks)
    CreateProcess2(Server, CommandLine, OptionsBuffer, InitialDirectory?, Environment?)
      => ComCall(81, this.p, Int64, Server, PSTR, CommandLine, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, PSTR, InitialDirectory?, PSTR, Environment?)
    CreateProcess2Wide(Server, CommandLine, OptionsBuffer, InitialDirectory?, Environment?)
      => ComCall(82, this.p, Int64, Server, "Str", CommandLine, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, "Str", InitialDirectory?, "Str", Environment?)
    CreateProcessAndAttach2(Server, CommandLine?, OptionsBuffer, InitialDirectory?, Environment?, ProcessId, AttachFlags)
      => ComCall(83, this.p, Int64, Server, PSTR, CommandLine?, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, PSTR, InitialDirectory?, PSTR, Environment?, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessAndAttach2Wide(Server, CommandLine?, OptionsBuffer, InitialDirectory?, Environment?, ProcessId, AttachFlags)
      => ComCall(84, this.p, Int64, Server, "Str", CommandLine?, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, "Str", InitialDirectory?, "Str", Environment?, UInt32, ProcessId, UInt32, AttachFlags)
    PushOutputLinePrefix(NewPrefix?, Handle)
      => ComCall(85, this.p, PSTR, NewPrefix?, Int64.Ptr, Handle)
    PushOutputLinePrefixWide(NewPrefix?, Handle)
      => ComCall(86, this.p, "Str", NewPrefix?, Int64.Ptr, Handle)
    PopOutputLinePrefix(Handle)
      => ComCall(87, this.p, Int64, Handle)
    GetNumberInputCallbacks(Count)
      => ComCall(88, this.p, UInt32.Ptr, Count)
    GetNumberOutputCallbacks(Count)
      => ComCall(89, this.p, UInt32.Ptr, Count)
    GetNumberEventCallbacks(EventFlags, Count)
      => ComCall(90, this.p, UInt32, EventFlags, UInt32.Ptr, Count)
    GetQuitLockString(Buffer?, StringSize?)
      => ComCall(91, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    SetQuitLockString(String)
      => ComCall(92, this.p, PSTR, String)
    GetQuitLockStringWide(Buffer?, StringSize?)
      => ComCall(93, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    SetQuitLockStringWide(String)
      => ComCall(94, this.p, "Str", String)
    SetEventContextCallbacks(Callbacks?)
      => ComCall(95, this.p, IDebugEventContextCallbacks, Callbacks?)
    SetClientContext(Context)
      => ComCall(96, this.p, Struct.Ptr, Context, UInt32, Context.Size)
    OpenDumpFileWide2(FileName?, FileHandle, AlternateArch)
      => ComCall(97, this.p, "Str", FileName?, Int64, FileHandle, UInt32, AlternateArch)
}
struct IDebugClient9 extends IUnknown {
    static IID := "{2C24CD5B-4D9E-4DF4-8A70-3D37440D119F}"
    AttachKernel(Flags, ConnectOptions?)
      => ComCall(3, this.p, UInt32, Flags, PSTR, ConnectOptions?)
    GetKernelConnectionOptions(Buffer?, OptionsSize?)
      => ComCall(4, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptions(Options)
      => ComCall(5, this.p, PSTR, Options)
    StartProcessServer(Flags, Options)
      => ComCall(6, this.p, UInt32, Flags, PSTR, Options, "Ptr", 0)
    ConnectProcessServer(RemoteOptions, Server)
      => ComCall(7, this.p, PSTR, RemoteOptions, Int64.Ptr, Server)
    DisconnectProcessServer(Server)
      => ComCall(8, this.p, Int64, Server)
    GetRunningProcessSystemIds(Server, Ids?, ActualCount?)
      => ComCall(9, this.p, Int64, Server, UInt32.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, ActualCount?)
    GetRunningProcessSystemIdByExecutableName(Server, ExeName, Flags, Id)
      => ComCall(10, this.p, Int64, Server, PSTR, ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescription(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(11, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    AttachProcess(Server, ProcessId, AttachFlags)
      => ComCall(12, this.p, Int64, Server, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessA(Server, CommandLine, CreateFlags)
      => ComCall(13, this.p, Int64, Server, PSTR, CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttach(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(14, this.p, Int64, Server, PSTR, CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    GetProcessOptions(Options)
      => ComCall(15, this.p, UInt32.Ptr, Options)
    AddProcessOptions(Options)
      => ComCall(16, this.p, UInt32, Options)
    RemoveProcessOptions(Options)
      => ComCall(17, this.p, UInt32, Options)
    SetProcessOptions(Options)
      => ComCall(18, this.p, UInt32, Options)
    OpenDumpFile(DumpFile)
      => ComCall(19, this.p, PSTR, DumpFile)
    WriteDumpFile(DumpFile, Qualifier)
      => ComCall(20, this.p, PSTR, DumpFile, UInt32, Qualifier)
    ConnectSession(Flags, HistoryLimit)
      => ComCall(21, this.p, UInt32, Flags, UInt32, HistoryLimit)
    StartServer(Options)
      => ComCall(22, this.p, PSTR, Options)
    OutputServers(OutputControl, Machine, Flags)
      => ComCall(23, this.p, UInt32, OutputControl, PSTR, Machine, UInt32, Flags)
    TerminateProcesses()
      => ComCall(24, this.p)
    DetachProcesses()
      => ComCall(25, this.p)
    EndSession(Flags)
      => ComCall(26, this.p, UInt32, Flags)
    GetExitCode(Code)
      => ComCall(27, this.p, UInt32.Ptr, Code)
    DispatchCallbacks(Timeout)
      => ComCall(28, this.p, UInt32, Timeout)
    ExitDispatch(Client)
      => ComCall(29, this.p, IDebugClient, Client)
    CreateClient(Client)
      => ComCall(30, this.p, IDebugClient.Ptr, Client)
    GetInputCallbacks(Callbacks)
      => ComCall(31, this.p, IDebugInputCallbacks.Ptr, Callbacks)
    SetInputCallbacks(Callbacks?)
      => ComCall(32, this.p, IDebugInputCallbacks, Callbacks?)
    GetOutputCallbacks(Callbacks)
      => ComCall(33, this.p, IDebugOutputCallbacks.Ptr, Callbacks)
    SetOutputCallbacks(Callbacks?)
      => ComCall(34, this.p, IDebugOutputCallbacks, Callbacks?)
    GetOutputMask(Mask)
      => ComCall(35, this.p, UInt32.Ptr, Mask)
    SetOutputMask(Mask)
      => ComCall(36, this.p, UInt32, Mask)
    GetOtherOutputMask(Client, Mask)
      => ComCall(37, this.p, IDebugClient, Client, UInt32.Ptr, Mask)
    SetOtherOutputMask(Client, Mask)
      => ComCall(38, this.p, IDebugClient, Client, UInt32, Mask)
    GetOutputWidth(Columns)
      => ComCall(39, this.p, UInt32.Ptr, Columns)
    SetOutputWidth(Columns)
      => ComCall(40, this.p, UInt32, Columns)
    GetOutputLinePrefix(Buffer?, PrefixSize?)
      => ComCall(41, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefix(Prefix?)
      => ComCall(42, this.p, PSTR, Prefix?)
    GetIdentity(Buffer?, IdentitySize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentity(OutputControl, Flags, Format)
      => ComCall(44, this.p, UInt32, OutputControl, UInt32, Flags, PSTR, Format)
    GetEventCallbacks(Callbacks)
      => ComCall(45, this.p, IDebugEventCallbacks.Ptr, Callbacks)
    SetEventCallbacks(Callbacks?)
      => ComCall(46, this.p, IDebugEventCallbacks, Callbacks?)
    FlushCallbacks()
      => ComCall(47, this.p)
    WriteDumpFile2(DumpFile, Qualifier, FormatFlags, Comment?)
      => ComCall(48, this.p, PSTR, DumpFile, UInt32, Qualifier, UInt32, FormatFlags, PSTR, Comment?)
    AddDumpInformationFile(InfoFile, Type)
      => ComCall(49, this.p, PSTR, InfoFile, UInt32, Type)
    EndProcessServer(Server)
      => ComCall(50, this.p, Int64, Server)
    WaitForProcessServerEnd(Timeout)
      => ComCall(51, this.p, UInt32, Timeout)
    IsKernelDebuggerEnabled()
      => ComCall(52, this.p)
    TerminateCurrentProcess()
      => ComCall(53, this.p)
    DetachCurrentProcess()
      => ComCall(54, this.p)
    AbandonCurrentProcess()
      => ComCall(55, this.p)
    GetRunningProcessSystemIdByExecutableNameWide(Server, ExeName, Flags, Id)
      => ComCall(56, this.p, Int64, Server, "Str", ExeName, UInt32, Flags, UInt32.Ptr, Id)
    GetRunningProcessDescriptionWide(Server, SystemId, Flags, ExeName?, ActualExeNameSize?, Description?, ActualDescriptionSize?)
      => ComCall(57, this.p, Int64, Server, UInt32, SystemId, UInt32, Flags, PWSTR, ExeName?, UInt32, ExeName?.Length ?? 0, UInt32.Ptr, ActualExeNameSize?, PWSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, ActualDescriptionSize?)
    CreateProcessWide(Server, CommandLine, CreateFlags)
      => ComCall(58, this.p, Int64, Server, "Str", CommandLine, UInt32, CreateFlags)
    CreateProcessAndAttachWide(Server, CommandLine?, CreateFlags, ProcessId, AttachFlags)
      => ComCall(59, this.p, Int64, Server, "Str", CommandLine?, UInt32, CreateFlags, UInt32, ProcessId, UInt32, AttachFlags)
    OpenDumpFileWide(FileName?, FileHandle)
      => ComCall(60, this.p, "Str", FileName?, Int64, FileHandle)
    WriteDumpFileWide(FileName?, FileHandle, Qualifier, FormatFlags, Comment?)
      => ComCall(61, this.p, "Str", FileName?, Int64, FileHandle, UInt32, Qualifier, UInt32, FormatFlags, "Str", Comment?)
    AddDumpInformationFileWide(FileName?, FileHandle, Type)
      => ComCall(62, this.p, "Str", FileName?, Int64, FileHandle, UInt32, Type)
    GetNumberDumpFiles(Number)
      => ComCall(63, this.p, UInt32.Ptr, Number)
    GetDumpFile(Index, Buffer?, NameSize?, Handle?, Type)
      => ComCall(64, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Handle?, UInt32.Ptr, Type)
    GetDumpFileWide(Index, Buffer?, NameSize?, Handle?, Type)
      => ComCall(65, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Handle?, UInt32.Ptr, Type)
    AttachKernelWide(Flags, ConnectOptions?)
      => ComCall(66, this.p, UInt32, Flags, "Str", ConnectOptions?)
    GetKernelConnectionOptionsWide(Buffer?, OptionsSize?)
      => ComCall(67, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, OptionsSize?)
    SetKernelConnectionOptionsWide(Options)
      => ComCall(68, this.p, "Str", Options)
    StartProcessServerWide(Flags, Options)
      => ComCall(69, this.p, UInt32, Flags, "Str", Options, "Ptr", 0)
    ConnectProcessServerWide(RemoteOptions, Server)
      => ComCall(70, this.p, "Str", RemoteOptions, Int64.Ptr, Server)
    StartServerWide(Options)
      => ComCall(71, this.p, "Str", Options)
    OutputServersWide(OutputControl, Machine, Flags)
      => ComCall(72, this.p, UInt32, OutputControl, "Str", Machine, UInt32, Flags)
    GetOutputCallbacksWide(Callbacks)
      => ComCall(73, this.p, IDebugOutputCallbacksWide.Ptr, Callbacks)
    SetOutputCallbacksWide(Callbacks)
      => ComCall(74, this.p, IDebugOutputCallbacksWide, Callbacks)
    GetOutputLinePrefixWide(Buffer?, PrefixSize?)
      => ComCall(75, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PrefixSize?)
    SetOutputLinePrefixWide(Prefix?)
      => ComCall(76, this.p, "Str", Prefix?)
    GetIdentityWide(Buffer?, IdentitySize?)
      => ComCall(77, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, IdentitySize?)
    OutputIdentityWide(OutputControl, Flags, Format)
      => ComCall(78, this.p, UInt32, OutputControl, UInt32, Flags, "Str", Format)
    GetEventCallbacksWide(Callbacks)
      => ComCall(79, this.p, IDebugEventCallbacksWide.Ptr, Callbacks)
    SetEventCallbacksWide(Callbacks)
      => ComCall(80, this.p, IDebugEventCallbacksWide, Callbacks)
    CreateProcess2(Server, CommandLine, OptionsBuffer, InitialDirectory?, Environment?)
      => ComCall(81, this.p, Int64, Server, PSTR, CommandLine, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, PSTR, InitialDirectory?, PSTR, Environment?)
    CreateProcess2Wide(Server, CommandLine, OptionsBuffer, InitialDirectory?, Environment?)
      => ComCall(82, this.p, Int64, Server, "Str", CommandLine, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, "Str", InitialDirectory?, "Str", Environment?)
    CreateProcessAndAttach2(Server, CommandLine?, OptionsBuffer, InitialDirectory?, Environment?, ProcessId, AttachFlags)
      => ComCall(83, this.p, Int64, Server, PSTR, CommandLine?, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, PSTR, InitialDirectory?, PSTR, Environment?, UInt32, ProcessId, UInt32, AttachFlags)
    CreateProcessAndAttach2Wide(Server, CommandLine?, OptionsBuffer, InitialDirectory?, Environment?, ProcessId, AttachFlags)
      => ComCall(84, this.p, Int64, Server, "Str", CommandLine?, Struct.Ptr, OptionsBuffer, UInt32, OptionsBuffer.Size, "Str", InitialDirectory?, "Str", Environment?, UInt32, ProcessId, UInt32, AttachFlags)
    PushOutputLinePrefix(NewPrefix?, Handle)
      => ComCall(85, this.p, PSTR, NewPrefix?, Int64.Ptr, Handle)
    PushOutputLinePrefixWide(NewPrefix?, Handle)
      => ComCall(86, this.p, "Str", NewPrefix?, Int64.Ptr, Handle)
    PopOutputLinePrefix(Handle)
      => ComCall(87, this.p, Int64, Handle)
    GetNumberInputCallbacks(Count)
      => ComCall(88, this.p, UInt32.Ptr, Count)
    GetNumberOutputCallbacks(Count)
      => ComCall(89, this.p, UInt32.Ptr, Count)
    GetNumberEventCallbacks(EventFlags, Count)
      => ComCall(90, this.p, UInt32, EventFlags, UInt32.Ptr, Count)
    GetQuitLockString(Buffer?, StringSize?)
      => ComCall(91, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    SetQuitLockString(String)
      => ComCall(92, this.p, PSTR, String)
    GetQuitLockStringWide(Buffer?, StringSize?)
      => ComCall(93, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    SetQuitLockStringWide(String)
      => ComCall(94, this.p, "Str", String)
    SetEventContextCallbacks(Callbacks?)
      => ComCall(95, this.p, IDebugEventContextCallbacks, Callbacks?)
    SetClientContext(Context)
      => ComCall(96, this.p, Struct.Ptr, Context, UInt32, Context.Size)
    OpenDumpFileWide2(FileName?, FileHandle, AlternateArch)
      => ComCall(97, this.p, "Str", FileName?, Int64, FileHandle, UInt32, AlternateArch)
    OpenDumpDirectoryWide(DirName?, AlternateArch)
      => ComCall(98, this.p, "Str", DirName?, UInt32, AlternateArch)
    OpenDumpDirectory(DumpDir, AlternativeArch)
      => ComCall(99, this.p, PSTR, DumpDir, UInt32, AlternativeArch)
}
struct IDebugPlmClient extends IUnknown {
    static IID := "{A02B66C4-AEA3-4234-A9F7-FE4C383D4E29}"
    LaunchPlmPackageForDebugWide(Server, Timeout, PackageFullName, AppName, Arguments?, ProcessId, ThreadId)
      => ComCall(3, this.p, Int64, Server, UInt32, Timeout, "Str", PackageFullName, "Str", AppName, "Str", Arguments?, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId)
}
struct IDebugPlmClient2 extends IUnknown {
    static IID := "{597C980D-E7BD-4309-962C-9D9B69A7372C}"
    LaunchPlmPackageForDebugWide(Server, Timeout, PackageFullName, AppName, Arguments?, ProcessId, ThreadId)
      => ComCall(3, this.p, Int64, Server, UInt32, Timeout, "Str", PackageFullName, "Str", AppName, "Str", Arguments?, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId)
    LaunchPlmBgTaskForDebugWide(Server, Timeout, PackageFullName, BackgroundTaskId, ProcessId, ThreadId)
      => ComCall(4, this.p, Int64, Server, UInt32, Timeout, "Str", PackageFullName, "Str", BackgroundTaskId, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId)
}
struct IDebugPlmClient3 extends IUnknown {
    static IID := "{D4A5DBD1-CA02-4D90-856A-2A92BFD0F20F}"
    LaunchPlmPackageForDebugWide(Server, Timeout, PackageFullName, AppName, Arguments?, ProcessId, ThreadId)
      => ComCall(3, this.p, Int64, Server, UInt32, Timeout, "Str", PackageFullName, "Str", AppName, "Str", Arguments?, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId)
    LaunchPlmBgTaskForDebugWide(Server, Timeout, PackageFullName, BackgroundTaskId, ProcessId, ThreadId)
      => ComCall(4, this.p, Int64, Server, UInt32, Timeout, "Str", PackageFullName, "Str", BackgroundTaskId, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId)
    QueryPlmPackageWide(Server, PackageFullName, Stream)
      => ComCall(5, this.p, Int64, Server, "Str", PackageFullName, IDebugOutputStream, Stream)
    QueryPlmPackageList(Server, Stream)
      => ComCall(6, this.p, Int64, Server, IDebugOutputStream, Stream)
    EnablePlmPackageDebugWide(Server, PackageFullName)
      => ComCall(7, this.p, Int64, Server, "Str", PackageFullName)
    DisablePlmPackageDebugWide(Server, PackageFullName)
      => ComCall(8, this.p, Int64, Server, "Str", PackageFullName)
    SuspendPlmPackageWide(Server, PackageFullName)
      => ComCall(9, this.p, Int64, Server, "Str", PackageFullName)
    ResumePlmPackageWide(Server, PackageFullName)
      => ComCall(10, this.p, Int64, Server, "Str", PackageFullName)
    TerminatePlmPackageWide(Server, PackageFullName)
      => ComCall(11, this.p, Int64, Server, "Str", PackageFullName)
    LaunchAndDebugPlmAppWide(Server, PackageFullName, AppName, Arguments)
      => ComCall(12, this.p, Int64, Server, "Str", PackageFullName, "Str", AppName, "Str", Arguments)
    ActivateAndDebugPlmBgTaskWide(Server, PackageFullName, BackgroundTaskId)
      => ComCall(13, this.p, Int64, Server, "Str", PackageFullName, "Str", BackgroundTaskId)
}
struct IDebugOutputStream extends IUnknown {
    static IID := "{7782D8F2-2B85-4059-AB88-28CEDDCA1C80}"
    Write(psz)
      => ComCall(3, this.p, "Str", psz)
}
struct DEBUG_STACK_FRAME {
    InstructionOffset : Int64
    ReturnOffset : Int64
    FrameOffset : Int64
    StackOffset : Int64
    FuncTableEntry : Int64
    Params : Int64[4]
    Reserved : Int64[6]
    Virtual : BOOL
    FrameNumber : UInt32
}
struct DEBUG_STACK_FRAME_EX {
    InstructionOffset : Int64
    ReturnOffset : Int64
    FrameOffset : Int64
    StackOffset : Int64
    FuncTableEntry : Int64
    Params : Int64[4]
    Reserved : Int64[6]
    Virtual : BOOL
    FrameNumber : UInt32
    InlineFrameContext : UInt32
    FrameMachine : UInt32
}
struct INLINE_FRAME_CONTEXT {
    union {
        ContextValue : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        FrameId : UInt8
        FrameType : UInt8
        FrameSignature : UInt16
    }
}
struct STACK_SRC_INFO {
    ImagePath : PWSTR
    ModuleName : PWSTR
    Function : PWSTR
    Displacement : UInt32
    Row : UInt32
    Column : UInt32
}
struct STACK_SYM_FRAME_INFO {
    StackFrameEx : DEBUG_STACK_FRAME_EX
    SrcInfo : STACK_SRC_INFO
}
struct DEBUG_SPECIFIC_FILTER_PARAMETERS {
    ExecutionOption : UInt32
    ContinueOption : UInt32
    TextSize : UInt32
    CommandSize : UInt32
    ArgumentSize : UInt32
}
struct DEBUG_EXCEPTION_FILTER_PARAMETERS {
    ExecutionOption : UInt32
    ContinueOption : UInt32
    TextSize : UInt32
    CommandSize : UInt32
    SecondCommandSize : UInt32
    ExceptionCode : UInt32
}
struct DEBUG_LAST_EVENT_INFO_BREAKPOINT {
    Id : UInt32
}
struct DEBUG_LAST_EVENT_INFO_EXCEPTION {
    ExceptionRecord : EXCEPTION_RECORD64
    FirstChance : UInt32
}
struct DEBUG_LAST_EVENT_INFO_EXIT_THREAD {
    ExitCode : UInt32
}
struct DEBUG_LAST_EVENT_INFO_EXIT_PROCESS {
    ExitCode : UInt32
}
struct DEBUG_LAST_EVENT_INFO_LOAD_MODULE {
    Base : Int64
}
struct DEBUG_LAST_EVENT_INFO_UNLOAD_MODULE {
    Base : Int64
}
struct DEBUG_LAST_EVENT_INFO_SYSTEM_ERROR {
    Error : UInt32
    Level : UInt32
}
struct DEBUG_LAST_EVENT_INFO_SERVICE_EXCEPTION {
    Kind : UInt32
    DataSize : UInt32
    Address : Int64
}
struct DEBUG_VALUE {
    Anonymous : this._Anonymous_e__Union
    TailOfRawBytes : UInt32
    Type : UInt32
    struct _Anonymous_e__Union {
        union {
            I8 : UInt8
            I16 : UInt16
            I32 : UInt32
            Anonymous : this._Anonymous_e__Struct
            F32 : Float32
            F64 : Float64
            F80Bytes : UInt8[10]
            F82Bytes : UInt8[11]
            F128Bytes : UInt8[16]
            VI8 : UInt8[16]
            VI16 : UInt16[8]
            VI32 : UInt32[4]
            VI64 : Int64[2]
            VF32 : Float32[4]
            VF64 : Float64[2]
            I64Parts32 : this._I64Parts32_e__Struct
            F128Parts64 : this._F128Parts64_e__Struct
            RawBytes : UInt8[24]
        }
        struct _Anonymous_e__Struct {
            I64 : Int64
            Nat : BOOL
        }
        struct _I64Parts32_e__Struct {
            LowPart : UInt32
            HighPart : UInt32
        }
        struct _F128Parts64_e__Struct {
            LowPart : Int64
            HighPart : Int64
        }
    }
}
struct IDebugControl extends IUnknown {
    static IID := "{5182E668-105E-416E-AD92-24EF800424BA}"
    GetInterrupt()
      => ComCall(3, this.p)
    SetInterrupt(Flags)
      => ComCall(4, this.p, UInt32, Flags)
    GetInterruptTimeout(Seconds)
      => ComCall(5, this.p, UInt32.Ptr, Seconds)
    SetInterruptTimeout(Seconds)
      => ComCall(6, this.p, UInt32, Seconds)
    GetLogFile(Buffer?, FileSize?, Append)
      => ComCall(7, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, BOOL.Ptr, Append)
    OpenLogFile(File, Append)
      => ComCall(8, this.p, PSTR, File, BOOL, Append)
    CloseLogFile()
      => ComCall(9, this.p)
    GetLogMask(Mask)
      => ComCall(10, this.p, UInt32.Ptr, Mask)
    SetLogMask(Mask)
      => ComCall(11, this.p, UInt32, Mask)
    Input(Buffer, InputSize?)
      => ComCall(12, this.p, PSTR, Buffer, UInt32, Buffer.Length, UInt32.Ptr, InputSize?)
    ReturnInput(Buffer)
      => ComCall(13, this.p, PSTR, Buffer)
    Output(Mask, Format)
      => ComCall(14, this.p, UInt32, Mask, PSTR, Format)
    OutputVaList(Mask, Format, Args)
      => ComCall(15, this.p, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    ControlledOutput(OutputControl, Mask, Format)
      => ComCall(16, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format)
    ControlledOutputVaList(OutputControl, Mask, Format, Args)
      => ComCall(17, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    OutputPrompt(OutputControl, Format?)
      => ComCall(18, this.p, UInt32, OutputControl, PSTR, Format?)
    OutputPromptVaList(OutputControl, Format?, Args)
      => ComCall(19, this.p, UInt32, OutputControl, PSTR, Format?, Int8.Ptr, Args)
    GetPromptText(Buffer?, TextSize?)
      => ComCall(20, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    OutputCurrentState(OutputControl, Flags)
      => ComCall(21, this.p, UInt32, OutputControl, UInt32, Flags)
    OutputVersionInformation(OutputControl)
      => ComCall(22, this.p, UInt32, OutputControl)
    GetNotifyEventHandle(Handle)
      => ComCall(23, this.p, Int64.Ptr, Handle)
    SetNotifyEventHandle(Handle)
      => ComCall(24, this.p, Int64, Handle)
    Assemble(Offset, Instr, EndOffset)
      => ComCall(25, this.p, Int64, Offset, PSTR, Instr, Int64.Ptr, EndOffset)
    Disassemble(Offset, Flags, Buffer?, DisassemblySize?, EndOffset)
      => ComCall(26, this.p, Int64, Offset, UInt32, Flags, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, DisassemblySize?, Int64.Ptr, EndOffset)
    GetDisassembleEffectiveOffset(Offset)
      => ComCall(27, this.p, Int64.Ptr, Offset)
    OutputDisassembly(OutputControl, Offset, Flags, EndOffset)
      => ComCall(28, this.p, UInt32, OutputControl, Int64, Offset, UInt32, Flags, Int64.Ptr, EndOffset)
    OutputDisassemblyLines(OutputControl, PreviousLines, Offset, Flags, OffsetLine?, StartOffset?, EndOffset?, LineOffsets?)
      => ComCall(29, this.p, UInt32, OutputControl, UInt32, PreviousLines, UInt32, LineOffsets?.Length ?? 0, Int64, Offset, UInt32, Flags, UInt32.Ptr, OffsetLine?, Int64.Ptr, StartOffset?, Int64.Ptr, EndOffset?, Int64.Ptr, LineOffsets?)
    GetNearInstruction(Offset, Delta, NearOffset)
      => ComCall(30, this.p, Int64, Offset, Int32, Delta, Int64.Ptr, NearOffset)
    GetStackTrace(FrameOffset, StackOffset, InstructionOffset, Frames, FramesFilled?)
      => ComCall(31, this.p, Int64, FrameOffset, Int64, StackOffset, Int64, InstructionOffset, DEBUG_STACK_FRAME.Ptr, Frames, UInt32, Frames.Length, UInt32.Ptr, FramesFilled?)
    GetReturnOffset(Offset)
      => ComCall(32, this.p, Int64.Ptr, Offset)
    OutputStackTrace(OutputControl, Frames?, Flags)
      => ComCall(33, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME.Ptr, Frames?, UInt32, Frames?.Length ?? 0, UInt32, Flags)
    GetDebuggeeType(Class, Qualifier)
      => ComCall(34, this.p, UInt32.Ptr, Class, UInt32.Ptr, Qualifier)
    GetActualProcessorType(Type)
      => ComCall(35, this.p, UInt32.Ptr, Type)
    GetExecutingProcessorType(Type)
      => ComCall(36, this.p, UInt32.Ptr, Type)
    GetNumberPossibleExecutingProcessorTypes(Number)
      => ComCall(37, this.p, UInt32.Ptr, Number)
    GetPossibleExecutingProcessorTypes(Start, Types)
      => ComCall(38, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetNumberProcessors(Number)
      => ComCall(39, this.p, UInt32.Ptr, Number)
    GetSystemVersion(PlatformId, Major, Minor, ServicePackString?, ServicePackStringUsed?, ServicePackNumber, BuildString?, BuildStringUsed?)
      => ComCall(40, this.p, UInt32.Ptr, PlatformId, UInt32.Ptr, Major, UInt32.Ptr, Minor, PSTR, ServicePackString?, UInt32, ServicePackString?.Length ?? 0, UInt32.Ptr, ServicePackStringUsed?, UInt32.Ptr, ServicePackNumber, PSTR, BuildString?, UInt32, BuildString?.Length ?? 0, UInt32.Ptr, BuildStringUsed?)
    GetPageSize(Size)
      => ComCall(41, this.p, UInt32.Ptr, Size)
    IsPointer64Bit()
      => ComCall(42, this.p)
    ReadBugCheckData(Code, Arg1, Arg2, Arg3, Arg4)
      => ComCall(43, this.p, UInt32.Ptr, Code, Int64.Ptr, Arg1, Int64.Ptr, Arg2, Int64.Ptr, Arg3, Int64.Ptr, Arg4)
    GetNumberSupportedProcessorTypes(Number)
      => ComCall(44, this.p, UInt32.Ptr, Number)
    GetSupportedProcessorTypes(Start, Types)
      => ComCall(45, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetProcessorTypeNames(Type, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(46, this.p, UInt32, Type, PSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetEffectiveProcessorType(Type)
      => ComCall(47, this.p, UInt32.Ptr, Type)
    SetEffectiveProcessorType(Type)
      => ComCall(48, this.p, UInt32, Type)
    GetExecutionStatus(Status)
      => ComCall(49, this.p, UInt32.Ptr, Status)
    SetExecutionStatus(Status)
      => ComCall(50, this.p, UInt32, Status)
    GetCodeLevel(Level)
      => ComCall(51, this.p, UInt32.Ptr, Level)
    SetCodeLevel(Level)
      => ComCall(52, this.p, UInt32, Level)
    GetEngineOptions(Options)
      => ComCall(53, this.p, UInt32.Ptr, Options)
    AddEngineOptions(Options)
      => ComCall(54, this.p, UInt32, Options)
    RemoveEngineOptions(Options)
      => ComCall(55, this.p, UInt32, Options)
    SetEngineOptions(Options)
      => ComCall(56, this.p, UInt32, Options)
    GetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(57, this.p, UInt32.Ptr, OutputLevel, UInt32.Ptr, BreakLevel)
    SetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(58, this.p, UInt32, OutputLevel, UInt32, BreakLevel)
    GetTextMacro(Slot, Buffer?, MacroSize?)
      => ComCall(59, this.p, UInt32, Slot, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MacroSize?)
    SetTextMacro(Slot, Macro)
      => ComCall(60, this.p, UInt32, Slot, PSTR, Macro)
    GetRadix(Radix)
      => ComCall(61, this.p, UInt32.Ptr, Radix)
    SetRadix(Radix)
      => ComCall(62, this.p, UInt32, Radix)
    Evaluate(Expression, DesiredType, Value, RemainderIndex?)
      => ComCall(63, this.p, PSTR, Expression, UInt32, DesiredType, DEBUG_VALUE.Ptr, Value, UInt32.Ptr, RemainderIndex?)
    CoerceValue(In1, OutType, Out)
      => ComCall(64, this.p, DEBUG_VALUE.Ptr, In1, UInt32, OutType, DEBUG_VALUE.Ptr, Out)
    CoerceValues(In1, OutTypes, Out)
      => ComCall(65, this.p, UInt32, Out.Length, DEBUG_VALUE.Ptr, In1, UInt32.Ptr, OutTypes, DEBUG_VALUE.Ptr, Out)
    Execute(OutputControl, Command, Flags)
      => ComCall(66, this.p, UInt32, OutputControl, PSTR, Command, UInt32, Flags)
    ExecuteCommandFile(OutputControl, CommandFile, Flags)
      => ComCall(67, this.p, UInt32, OutputControl, PSTR, CommandFile, UInt32, Flags)
    GetNumberBreakpoints(Number)
      => ComCall(68, this.p, UInt32.Ptr, Number)
    GetBreakpointByIndex(Index, Bp)
      => ComCall(69, this.p, UInt32, Index, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointById(Id, Bp)
      => ComCall(70, this.p, UInt32, Id, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointParameters(Ids?, Start, Params)
      => ComCall(71, this.p, UInt32, Params.Length, UInt32.Ptr, Ids?, UInt32, Start, DEBUG_BREAKPOINT_PARAMETERS.Ptr, Params)
    AddBreakpoint(Type, DesiredId, Bp)
      => ComCall(72, this.p, UInt32, Type, UInt32, DesiredId, IDebugBreakpoint.Ptr, Bp)
    RemoveBreakpoint(Bp)
      => ComCall(73, this.p, IDebugBreakpoint, Bp)
    AddExtension(Path, Flags, Handle)
      => ComCall(74, this.p, PSTR, Path, UInt32, Flags, Int64.Ptr, Handle)
    RemoveExtension(Handle)
      => ComCall(75, this.p, Int64, Handle)
    GetExtensionByPath(Path, Handle)
      => ComCall(76, this.p, PSTR, Path, Int64.Ptr, Handle)
    CallExtension(Handle, Function, Arguments?)
      => ComCall(77, this.p, Int64, Handle, PSTR, Function, PSTR, Arguments?)
    GetExtensionFunction(Handle, FuncName, Function)
      => ComCall(78, this.p, Int64, Handle, PSTR, FuncName, FARPROC.Ptr, Function)
    GetWindbgExtensionApis32(Api)
      => ComCall(79, this.p, WINDBG_EXTENSION_APIS32.Ptr, Api)
    GetWindbgExtensionApis64(Api)
      => ComCall(80, this.p, WINDBG_EXTENSION_APIS64.Ptr, Api)
    GetNumberEventFilters(SpecificEvents, SpecificExceptions, ArbitraryExceptions)
      => ComCall(81, this.p, UInt32.Ptr, SpecificEvents, UInt32.Ptr, SpecificExceptions, UInt32.Ptr, ArbitraryExceptions)
    GetEventFilterText(Index, Buffer?, TextSize?)
      => ComCall(82, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    GetEventFilterCommand(Index, Buffer?, CommandSize?)
      => ComCall(83, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetEventFilterCommand(Index, Command)
      => ComCall(84, this.p, UInt32, Index, PSTR, Command)
    GetSpecificFilterParameters(Start, Params)
      => ComCall(85, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    SetSpecificFilterParameters(Start, Params)
      => ComCall(86, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    GetSpecificFilterArgument(Index, Buffer?, ArgumentSize?)
      => ComCall(87, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ArgumentSize?)
    SetSpecificFilterArgument(Index, Argument)
      => ComCall(88, this.p, UInt32, Index, PSTR, Argument)
    GetExceptionFilterParameters(Codes?, Start, Params)
      => ComCall(89, this.p, UInt32, Params.Length, UInt32.Ptr, Codes?, UInt32, Start, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    SetExceptionFilterParameters(Params)
      => ComCall(90, this.p, UInt32, Params.Length, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    GetExceptionFilterSecondCommand(Index, Buffer?, CommandSize?)
      => ComCall(91, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetExceptionFilterSecondCommand(Index, Command)
      => ComCall(92, this.p, UInt32, Index, PSTR, Command)
    WaitForEvent(Flags, Timeout)
      => ComCall(93, this.p, UInt32, Flags, UInt32, Timeout)
    GetLastEventInformation(Type, ProcessId, ThreadId, ExtraInformation?, ExtraInformationUsed?, Description?, DescriptionUsed?)
      => ComCall(94, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, DescriptionUsed?)
}
struct IDebugControl2 extends IUnknown {
    static IID := "{D4366723-44DF-4BED-8C7E-4C05424F4588}"
    GetInterrupt()
      => ComCall(3, this.p)
    SetInterrupt(Flags)
      => ComCall(4, this.p, UInt32, Flags)
    GetInterruptTimeout(Seconds)
      => ComCall(5, this.p, UInt32.Ptr, Seconds)
    SetInterruptTimeout(Seconds)
      => ComCall(6, this.p, UInt32, Seconds)
    GetLogFile(Buffer?, FileSize?, Append)
      => ComCall(7, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, BOOL.Ptr, Append)
    OpenLogFile(File, Append)
      => ComCall(8, this.p, PSTR, File, BOOL, Append)
    CloseLogFile()
      => ComCall(9, this.p)
    GetLogMask(Mask)
      => ComCall(10, this.p, UInt32.Ptr, Mask)
    SetLogMask(Mask)
      => ComCall(11, this.p, UInt32, Mask)
    Input(Buffer, InputSize?)
      => ComCall(12, this.p, PSTR, Buffer, UInt32, Buffer.Length, UInt32.Ptr, InputSize?)
    ReturnInput(Buffer)
      => ComCall(13, this.p, PSTR, Buffer)
    Output(Mask, Format)
      => ComCall(14, this.p, UInt32, Mask, PSTR, Format)
    OutputVaList(Mask, Format, Args)
      => ComCall(15, this.p, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    ControlledOutput(OutputControl, Mask, Format)
      => ComCall(16, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format)
    ControlledOutputVaList(OutputControl, Mask, Format, Args)
      => ComCall(17, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    OutputPrompt(OutputControl, Format?)
      => ComCall(18, this.p, UInt32, OutputControl, PSTR, Format?)
    OutputPromptVaList(OutputControl, Format?, Args)
      => ComCall(19, this.p, UInt32, OutputControl, PSTR, Format?, Int8.Ptr, Args)
    GetPromptText(Buffer?, TextSize?)
      => ComCall(20, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    OutputCurrentState(OutputControl, Flags)
      => ComCall(21, this.p, UInt32, OutputControl, UInt32, Flags)
    OutputVersionInformation(OutputControl)
      => ComCall(22, this.p, UInt32, OutputControl)
    GetNotifyEventHandle(Handle)
      => ComCall(23, this.p, Int64.Ptr, Handle)
    SetNotifyEventHandle(Handle)
      => ComCall(24, this.p, Int64, Handle)
    Assemble(Offset, Instr, EndOffset)
      => ComCall(25, this.p, Int64, Offset, PSTR, Instr, Int64.Ptr, EndOffset)
    Disassemble(Offset, Flags, Buffer?, DisassemblySize?, EndOffset)
      => ComCall(26, this.p, Int64, Offset, UInt32, Flags, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, DisassemblySize?, Int64.Ptr, EndOffset)
    GetDisassembleEffectiveOffset(Offset)
      => ComCall(27, this.p, Int64.Ptr, Offset)
    OutputDisassembly(OutputControl, Offset, Flags, EndOffset)
      => ComCall(28, this.p, UInt32, OutputControl, Int64, Offset, UInt32, Flags, Int64.Ptr, EndOffset)
    OutputDisassemblyLines(OutputControl, PreviousLines, Offset, Flags, OffsetLine?, StartOffset?, EndOffset?, LineOffsets?)
      => ComCall(29, this.p, UInt32, OutputControl, UInt32, PreviousLines, UInt32, LineOffsets?.Length ?? 0, Int64, Offset, UInt32, Flags, UInt32.Ptr, OffsetLine?, Int64.Ptr, StartOffset?, Int64.Ptr, EndOffset?, Int64.Ptr, LineOffsets?)
    GetNearInstruction(Offset, Delta, NearOffset)
      => ComCall(30, this.p, Int64, Offset, Int32, Delta, Int64.Ptr, NearOffset)
    GetStackTrace(FrameOffset, StackOffset, InstructionOffset, Frames, FramesFilled?)
      => ComCall(31, this.p, Int64, FrameOffset, Int64, StackOffset, Int64, InstructionOffset, DEBUG_STACK_FRAME.Ptr, Frames, UInt32, Frames.Length, UInt32.Ptr, FramesFilled?)
    GetReturnOffset(Offset)
      => ComCall(32, this.p, Int64.Ptr, Offset)
    OutputStackTrace(OutputControl, Frames?, Flags)
      => ComCall(33, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME.Ptr, Frames?, UInt32, Frames?.Length ?? 0, UInt32, Flags)
    GetDebuggeeType(Class, Qualifier)
      => ComCall(34, this.p, UInt32.Ptr, Class, UInt32.Ptr, Qualifier)
    GetActualProcessorType(Type)
      => ComCall(35, this.p, UInt32.Ptr, Type)
    GetExecutingProcessorType(Type)
      => ComCall(36, this.p, UInt32.Ptr, Type)
    GetNumberPossibleExecutingProcessorTypes(Number)
      => ComCall(37, this.p, UInt32.Ptr, Number)
    GetPossibleExecutingProcessorTypes(Start, Types)
      => ComCall(38, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetNumberProcessors(Number)
      => ComCall(39, this.p, UInt32.Ptr, Number)
    GetSystemVersion(PlatformId, Major, Minor, ServicePackString?, ServicePackStringUsed?, ServicePackNumber, BuildString?, BuildStringUsed?)
      => ComCall(40, this.p, UInt32.Ptr, PlatformId, UInt32.Ptr, Major, UInt32.Ptr, Minor, PSTR, ServicePackString?, UInt32, ServicePackString?.Length ?? 0, UInt32.Ptr, ServicePackStringUsed?, UInt32.Ptr, ServicePackNumber, PSTR, BuildString?, UInt32, BuildString?.Length ?? 0, UInt32.Ptr, BuildStringUsed?)
    GetPageSize(Size)
      => ComCall(41, this.p, UInt32.Ptr, Size)
    IsPointer64Bit()
      => ComCall(42, this.p)
    ReadBugCheckData(Code, Arg1, Arg2, Arg3, Arg4)
      => ComCall(43, this.p, UInt32.Ptr, Code, Int64.Ptr, Arg1, Int64.Ptr, Arg2, Int64.Ptr, Arg3, Int64.Ptr, Arg4)
    GetNumberSupportedProcessorTypes(Number)
      => ComCall(44, this.p, UInt32.Ptr, Number)
    GetSupportedProcessorTypes(Start, Types)
      => ComCall(45, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetProcessorTypeNames(Type, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(46, this.p, UInt32, Type, PSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetEffectiveProcessorType(Type)
      => ComCall(47, this.p, UInt32.Ptr, Type)
    SetEffectiveProcessorType(Type)
      => ComCall(48, this.p, UInt32, Type)
    GetExecutionStatus(Status)
      => ComCall(49, this.p, UInt32.Ptr, Status)
    SetExecutionStatus(Status)
      => ComCall(50, this.p, UInt32, Status)
    GetCodeLevel(Level)
      => ComCall(51, this.p, UInt32.Ptr, Level)
    SetCodeLevel(Level)
      => ComCall(52, this.p, UInt32, Level)
    GetEngineOptions(Options)
      => ComCall(53, this.p, UInt32.Ptr, Options)
    AddEngineOptions(Options)
      => ComCall(54, this.p, UInt32, Options)
    RemoveEngineOptions(Options)
      => ComCall(55, this.p, UInt32, Options)
    SetEngineOptions(Options)
      => ComCall(56, this.p, UInt32, Options)
    GetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(57, this.p, UInt32.Ptr, OutputLevel, UInt32.Ptr, BreakLevel)
    SetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(58, this.p, UInt32, OutputLevel, UInt32, BreakLevel)
    GetTextMacro(Slot, Buffer?, MacroSize?)
      => ComCall(59, this.p, UInt32, Slot, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MacroSize?)
    SetTextMacro(Slot, Macro)
      => ComCall(60, this.p, UInt32, Slot, PSTR, Macro)
    GetRadix(Radix)
      => ComCall(61, this.p, UInt32.Ptr, Radix)
    SetRadix(Radix)
      => ComCall(62, this.p, UInt32, Radix)
    Evaluate(Expression, DesiredType, Value, RemainderIndex?)
      => ComCall(63, this.p, PSTR, Expression, UInt32, DesiredType, DEBUG_VALUE.Ptr, Value, UInt32.Ptr, RemainderIndex?)
    CoerceValue(In1, OutType, Out)
      => ComCall(64, this.p, DEBUG_VALUE.Ptr, In1, UInt32, OutType, DEBUG_VALUE.Ptr, Out)
    CoerceValues(In1, OutTypes, Out)
      => ComCall(65, this.p, UInt32, Out.Length, DEBUG_VALUE.Ptr, In1, UInt32.Ptr, OutTypes, DEBUG_VALUE.Ptr, Out)
    Execute(OutputControl, Command, Flags)
      => ComCall(66, this.p, UInt32, OutputControl, PSTR, Command, UInt32, Flags)
    ExecuteCommandFile(OutputControl, CommandFile, Flags)
      => ComCall(67, this.p, UInt32, OutputControl, PSTR, CommandFile, UInt32, Flags)
    GetNumberBreakpoints(Number)
      => ComCall(68, this.p, UInt32.Ptr, Number)
    GetBreakpointByIndex(Index, Bp)
      => ComCall(69, this.p, UInt32, Index, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointById(Id, Bp)
      => ComCall(70, this.p, UInt32, Id, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointParameters(Ids?, Start, Params)
      => ComCall(71, this.p, UInt32, Params.Length, UInt32.Ptr, Ids?, UInt32, Start, DEBUG_BREAKPOINT_PARAMETERS.Ptr, Params)
    AddBreakpoint(Type, DesiredId, Bp)
      => ComCall(72, this.p, UInt32, Type, UInt32, DesiredId, IDebugBreakpoint.Ptr, Bp)
    RemoveBreakpoint(Bp)
      => ComCall(73, this.p, IDebugBreakpoint, Bp)
    AddExtension(Path, Flags, Handle)
      => ComCall(74, this.p, PSTR, Path, UInt32, Flags, Int64.Ptr, Handle)
    RemoveExtension(Handle)
      => ComCall(75, this.p, Int64, Handle)
    GetExtensionByPath(Path, Handle)
      => ComCall(76, this.p, PSTR, Path, Int64.Ptr, Handle)
    CallExtension(Handle, Function, Arguments?)
      => ComCall(77, this.p, Int64, Handle, PSTR, Function, PSTR, Arguments?)
    GetExtensionFunction(Handle, FuncName, Function)
      => ComCall(78, this.p, Int64, Handle, PSTR, FuncName, FARPROC.Ptr, Function)
    GetWindbgExtensionApis32(Api)
      => ComCall(79, this.p, WINDBG_EXTENSION_APIS32.Ptr, Api)
    GetWindbgExtensionApis64(Api)
      => ComCall(80, this.p, WINDBG_EXTENSION_APIS64.Ptr, Api)
    GetNumberEventFilters(SpecificEvents, SpecificExceptions, ArbitraryExceptions)
      => ComCall(81, this.p, UInt32.Ptr, SpecificEvents, UInt32.Ptr, SpecificExceptions, UInt32.Ptr, ArbitraryExceptions)
    GetEventFilterText(Index, Buffer?, TextSize?)
      => ComCall(82, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    GetEventFilterCommand(Index, Buffer?, CommandSize?)
      => ComCall(83, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetEventFilterCommand(Index, Command)
      => ComCall(84, this.p, UInt32, Index, PSTR, Command)
    GetSpecificFilterParameters(Start, Params)
      => ComCall(85, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    SetSpecificFilterParameters(Start, Params)
      => ComCall(86, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    GetSpecificFilterArgument(Index, Buffer?, ArgumentSize?)
      => ComCall(87, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ArgumentSize?)
    SetSpecificFilterArgument(Index, Argument)
      => ComCall(88, this.p, UInt32, Index, PSTR, Argument)
    GetExceptionFilterParameters(Codes?, Start, Params)
      => ComCall(89, this.p, UInt32, Params.Length, UInt32.Ptr, Codes?, UInt32, Start, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    SetExceptionFilterParameters(Params)
      => ComCall(90, this.p, UInt32, Params.Length, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    GetExceptionFilterSecondCommand(Index, Buffer?, CommandSize?)
      => ComCall(91, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetExceptionFilterSecondCommand(Index, Command)
      => ComCall(92, this.p, UInt32, Index, PSTR, Command)
    WaitForEvent(Flags, Timeout)
      => ComCall(93, this.p, UInt32, Flags, UInt32, Timeout)
    GetLastEventInformation(Type, ProcessId, ThreadId, ExtraInformation?, ExtraInformationUsed?, Description?, DescriptionUsed?)
      => ComCall(94, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, DescriptionUsed?)
    GetCurrentTimeDate(TimeDate)
      => ComCall(95, this.p, UInt32.Ptr, TimeDate)
    GetCurrentSystemUpTime(UpTime)
      => ComCall(96, this.p, UInt32.Ptr, UpTime)
    GetDumpFormatFlags(FormatFlags)
      => ComCall(97, this.p, UInt32.Ptr, FormatFlags)
    GetNumberTextReplacements(NumRepl)
      => ComCall(98, this.p, UInt32.Ptr, NumRepl)
    GetTextReplacement(SrcText?, Index, SrcBuffer?, SrcSize?, DstBuffer?, DstSize?)
      => ComCall(99, this.p, PSTR, SrcText?, UInt32, Index, PSTR, SrcBuffer?, UInt32, SrcBuffer?.Length ?? 0, UInt32.Ptr, SrcSize?, PSTR, DstBuffer?, UInt32, DstBuffer?.Length ?? 0, UInt32.Ptr, DstSize?)
    SetTextReplacement(SrcText, DstText?)
      => ComCall(100, this.p, PSTR, SrcText, PSTR, DstText?)
    RemoveTextReplacements()
      => ComCall(101, this.p)
    OutputTextReplacements(OutputControl, Flags)
      => ComCall(102, this.p, UInt32, OutputControl, UInt32, Flags)
}
struct IDebugControl3 extends IUnknown {
    static IID := "{7DF74A86-B03F-407F-90AB-A20DADCEAD08}"
    GetInterrupt()
      => ComCall(3, this.p)
    SetInterrupt(Flags)
      => ComCall(4, this.p, UInt32, Flags)
    GetInterruptTimeout(Seconds)
      => ComCall(5, this.p, UInt32.Ptr, Seconds)
    SetInterruptTimeout(Seconds)
      => ComCall(6, this.p, UInt32, Seconds)
    GetLogFile(Buffer?, FileSize?, Append)
      => ComCall(7, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, BOOL.Ptr, Append)
    OpenLogFile(File, Append)
      => ComCall(8, this.p, PSTR, File, BOOL, Append)
    CloseLogFile()
      => ComCall(9, this.p)
    GetLogMask(Mask)
      => ComCall(10, this.p, UInt32.Ptr, Mask)
    SetLogMask(Mask)
      => ComCall(11, this.p, UInt32, Mask)
    Input(Buffer, InputSize?)
      => ComCall(12, this.p, PSTR, Buffer, UInt32, Buffer.Length, UInt32.Ptr, InputSize?)
    ReturnInput(Buffer)
      => ComCall(13, this.p, PSTR, Buffer)
    Output(Mask, Format)
      => ComCall(14, this.p, UInt32, Mask, PSTR, Format)
    OutputVaList(Mask, Format, Args)
      => ComCall(15, this.p, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    ControlledOutput(OutputControl, Mask, Format)
      => ComCall(16, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format)
    ControlledOutputVaList(OutputControl, Mask, Format, Args)
      => ComCall(17, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    OutputPrompt(OutputControl, Format?)
      => ComCall(18, this.p, UInt32, OutputControl, PSTR, Format?)
    OutputPromptVaList(OutputControl, Format?, Args)
      => ComCall(19, this.p, UInt32, OutputControl, PSTR, Format?, Int8.Ptr, Args)
    GetPromptText(Buffer?, TextSize?)
      => ComCall(20, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    OutputCurrentState(OutputControl, Flags)
      => ComCall(21, this.p, UInt32, OutputControl, UInt32, Flags)
    OutputVersionInformation(OutputControl)
      => ComCall(22, this.p, UInt32, OutputControl)
    GetNotifyEventHandle(Handle)
      => ComCall(23, this.p, Int64.Ptr, Handle)
    SetNotifyEventHandle(Handle)
      => ComCall(24, this.p, Int64, Handle)
    Assemble(Offset, Instr, EndOffset)
      => ComCall(25, this.p, Int64, Offset, PSTR, Instr, Int64.Ptr, EndOffset)
    Disassemble(Offset, Flags, Buffer?, DisassemblySize?, EndOffset)
      => ComCall(26, this.p, Int64, Offset, UInt32, Flags, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, DisassemblySize?, Int64.Ptr, EndOffset)
    GetDisassembleEffectiveOffset(Offset)
      => ComCall(27, this.p, Int64.Ptr, Offset)
    OutputDisassembly(OutputControl, Offset, Flags, EndOffset)
      => ComCall(28, this.p, UInt32, OutputControl, Int64, Offset, UInt32, Flags, Int64.Ptr, EndOffset)
    OutputDisassemblyLines(OutputControl, PreviousLines, Offset, Flags, OffsetLine?, StartOffset?, EndOffset?, LineOffsets?)
      => ComCall(29, this.p, UInt32, OutputControl, UInt32, PreviousLines, UInt32, LineOffsets?.Length ?? 0, Int64, Offset, UInt32, Flags, UInt32.Ptr, OffsetLine?, Int64.Ptr, StartOffset?, Int64.Ptr, EndOffset?, Int64.Ptr, LineOffsets?)
    GetNearInstruction(Offset, Delta, NearOffset)
      => ComCall(30, this.p, Int64, Offset, Int32, Delta, Int64.Ptr, NearOffset)
    GetStackTrace(FrameOffset, StackOffset, InstructionOffset, Frames, FramesFilled?)
      => ComCall(31, this.p, Int64, FrameOffset, Int64, StackOffset, Int64, InstructionOffset, DEBUG_STACK_FRAME.Ptr, Frames, UInt32, Frames.Length, UInt32.Ptr, FramesFilled?)
    GetReturnOffset(Offset)
      => ComCall(32, this.p, Int64.Ptr, Offset)
    OutputStackTrace(OutputControl, Frames?, Flags)
      => ComCall(33, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME.Ptr, Frames?, UInt32, Frames?.Length ?? 0, UInt32, Flags)
    GetDebuggeeType(Class, Qualifier)
      => ComCall(34, this.p, UInt32.Ptr, Class, UInt32.Ptr, Qualifier)
    GetActualProcessorType(Type)
      => ComCall(35, this.p, UInt32.Ptr, Type)
    GetExecutingProcessorType(Type)
      => ComCall(36, this.p, UInt32.Ptr, Type)
    GetNumberPossibleExecutingProcessorTypes(Number)
      => ComCall(37, this.p, UInt32.Ptr, Number)
    GetPossibleExecutingProcessorTypes(Start, Types)
      => ComCall(38, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetNumberProcessors(Number)
      => ComCall(39, this.p, UInt32.Ptr, Number)
    GetSystemVersion(PlatformId, Major, Minor, ServicePackString?, ServicePackStringUsed?, ServicePackNumber, BuildString?, BuildStringUsed?)
      => ComCall(40, this.p, UInt32.Ptr, PlatformId, UInt32.Ptr, Major, UInt32.Ptr, Minor, PSTR, ServicePackString?, UInt32, ServicePackString?.Length ?? 0, UInt32.Ptr, ServicePackStringUsed?, UInt32.Ptr, ServicePackNumber, PSTR, BuildString?, UInt32, BuildString?.Length ?? 0, UInt32.Ptr, BuildStringUsed?)
    GetPageSize(Size)
      => ComCall(41, this.p, UInt32.Ptr, Size)
    IsPointer64Bit()
      => ComCall(42, this.p)
    ReadBugCheckData(Code, Arg1, Arg2, Arg3, Arg4)
      => ComCall(43, this.p, UInt32.Ptr, Code, Int64.Ptr, Arg1, Int64.Ptr, Arg2, Int64.Ptr, Arg3, Int64.Ptr, Arg4)
    GetNumberSupportedProcessorTypes(Number)
      => ComCall(44, this.p, UInt32.Ptr, Number)
    GetSupportedProcessorTypes(Start, Types)
      => ComCall(45, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetProcessorTypeNames(Type, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(46, this.p, UInt32, Type, PSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetEffectiveProcessorType(Type)
      => ComCall(47, this.p, UInt32.Ptr, Type)
    SetEffectiveProcessorType(Type)
      => ComCall(48, this.p, UInt32, Type)
    GetExecutionStatus(Status)
      => ComCall(49, this.p, UInt32.Ptr, Status)
    SetExecutionStatus(Status)
      => ComCall(50, this.p, UInt32, Status)
    GetCodeLevel(Level)
      => ComCall(51, this.p, UInt32.Ptr, Level)
    SetCodeLevel(Level)
      => ComCall(52, this.p, UInt32, Level)
    GetEngineOptions(Options)
      => ComCall(53, this.p, UInt32.Ptr, Options)
    AddEngineOptions(Options)
      => ComCall(54, this.p, UInt32, Options)
    RemoveEngineOptions(Options)
      => ComCall(55, this.p, UInt32, Options)
    SetEngineOptions(Options)
      => ComCall(56, this.p, UInt32, Options)
    GetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(57, this.p, UInt32.Ptr, OutputLevel, UInt32.Ptr, BreakLevel)
    SetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(58, this.p, UInt32, OutputLevel, UInt32, BreakLevel)
    GetTextMacro(Slot, Buffer?, MacroSize?)
      => ComCall(59, this.p, UInt32, Slot, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MacroSize?)
    SetTextMacro(Slot, Macro)
      => ComCall(60, this.p, UInt32, Slot, PSTR, Macro)
    GetRadix(Radix)
      => ComCall(61, this.p, UInt32.Ptr, Radix)
    SetRadix(Radix)
      => ComCall(62, this.p, UInt32, Radix)
    Evaluate(Expression, DesiredType, Value, RemainderIndex?)
      => ComCall(63, this.p, PSTR, Expression, UInt32, DesiredType, DEBUG_VALUE.Ptr, Value, UInt32.Ptr, RemainderIndex?)
    CoerceValue(In1, OutType, Out)
      => ComCall(64, this.p, DEBUG_VALUE.Ptr, In1, UInt32, OutType, DEBUG_VALUE.Ptr, Out)
    CoerceValues(In1, OutTypes, Out)
      => ComCall(65, this.p, UInt32, Out.Length, DEBUG_VALUE.Ptr, In1, UInt32.Ptr, OutTypes, DEBUG_VALUE.Ptr, Out)
    Execute(OutputControl, Command, Flags)
      => ComCall(66, this.p, UInt32, OutputControl, PSTR, Command, UInt32, Flags)
    ExecuteCommandFile(OutputControl, CommandFile, Flags)
      => ComCall(67, this.p, UInt32, OutputControl, PSTR, CommandFile, UInt32, Flags)
    GetNumberBreakpoints(Number)
      => ComCall(68, this.p, UInt32.Ptr, Number)
    GetBreakpointByIndex(Index, Bp)
      => ComCall(69, this.p, UInt32, Index, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointById(Id, Bp)
      => ComCall(70, this.p, UInt32, Id, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointParameters(Ids?, Start, Params)
      => ComCall(71, this.p, UInt32, Params.Length, UInt32.Ptr, Ids?, UInt32, Start, DEBUG_BREAKPOINT_PARAMETERS.Ptr, Params)
    AddBreakpoint(Type, DesiredId, Bp)
      => ComCall(72, this.p, UInt32, Type, UInt32, DesiredId, IDebugBreakpoint.Ptr, Bp)
    RemoveBreakpoint(Bp)
      => ComCall(73, this.p, IDebugBreakpoint, Bp)
    AddExtension(Path, Flags, Handle)
      => ComCall(74, this.p, PSTR, Path, UInt32, Flags, Int64.Ptr, Handle)
    RemoveExtension(Handle)
      => ComCall(75, this.p, Int64, Handle)
    GetExtensionByPath(Path, Handle)
      => ComCall(76, this.p, PSTR, Path, Int64.Ptr, Handle)
    CallExtension(Handle, Function, Arguments?)
      => ComCall(77, this.p, Int64, Handle, PSTR, Function, PSTR, Arguments?)
    GetExtensionFunction(Handle, FuncName, Function)
      => ComCall(78, this.p, Int64, Handle, PSTR, FuncName, FARPROC.Ptr, Function)
    GetWindbgExtensionApis32(Api)
      => ComCall(79, this.p, WINDBG_EXTENSION_APIS32.Ptr, Api)
    GetWindbgExtensionApis64(Api)
      => ComCall(80, this.p, WINDBG_EXTENSION_APIS64.Ptr, Api)
    GetNumberEventFilters(SpecificEvents, SpecificExceptions, ArbitraryExceptions)
      => ComCall(81, this.p, UInt32.Ptr, SpecificEvents, UInt32.Ptr, SpecificExceptions, UInt32.Ptr, ArbitraryExceptions)
    GetEventFilterText(Index, Buffer?, TextSize?)
      => ComCall(82, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    GetEventFilterCommand(Index, Buffer?, CommandSize?)
      => ComCall(83, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetEventFilterCommand(Index, Command)
      => ComCall(84, this.p, UInt32, Index, PSTR, Command)
    GetSpecificFilterParameters(Start, Params)
      => ComCall(85, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    SetSpecificFilterParameters(Start, Params)
      => ComCall(86, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    GetSpecificFilterArgument(Index, Buffer?, ArgumentSize?)
      => ComCall(87, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ArgumentSize?)
    SetSpecificFilterArgument(Index, Argument)
      => ComCall(88, this.p, UInt32, Index, PSTR, Argument)
    GetExceptionFilterParameters(Codes?, Start, Params)
      => ComCall(89, this.p, UInt32, Params.Length, UInt32.Ptr, Codes?, UInt32, Start, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    SetExceptionFilterParameters(Params)
      => ComCall(90, this.p, UInt32, Params.Length, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    GetExceptionFilterSecondCommand(Index, Buffer?, CommandSize?)
      => ComCall(91, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetExceptionFilterSecondCommand(Index, Command)
      => ComCall(92, this.p, UInt32, Index, PSTR, Command)
    WaitForEvent(Flags, Timeout)
      => ComCall(93, this.p, UInt32, Flags, UInt32, Timeout)
    GetLastEventInformation(Type, ProcessId, ThreadId, ExtraInformation?, ExtraInformationUsed?, Description?, DescriptionUsed?)
      => ComCall(94, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, DescriptionUsed?)
    GetCurrentTimeDate(TimeDate)
      => ComCall(95, this.p, UInt32.Ptr, TimeDate)
    GetCurrentSystemUpTime(UpTime)
      => ComCall(96, this.p, UInt32.Ptr, UpTime)
    GetDumpFormatFlags(FormatFlags)
      => ComCall(97, this.p, UInt32.Ptr, FormatFlags)
    GetNumberTextReplacements(NumRepl)
      => ComCall(98, this.p, UInt32.Ptr, NumRepl)
    GetTextReplacement(SrcText?, Index, SrcBuffer?, SrcSize?, DstBuffer?, DstSize?)
      => ComCall(99, this.p, PSTR, SrcText?, UInt32, Index, PSTR, SrcBuffer?, UInt32, SrcBuffer?.Length ?? 0, UInt32.Ptr, SrcSize?, PSTR, DstBuffer?, UInt32, DstBuffer?.Length ?? 0, UInt32.Ptr, DstSize?)
    SetTextReplacement(SrcText, DstText?)
      => ComCall(100, this.p, PSTR, SrcText, PSTR, DstText?)
    RemoveTextReplacements()
      => ComCall(101, this.p)
    OutputTextReplacements(OutputControl, Flags)
      => ComCall(102, this.p, UInt32, OutputControl, UInt32, Flags)
    GetAssemblyOptions(Options)
      => ComCall(103, this.p, UInt32.Ptr, Options)
    AddAssemblyOptions(Options)
      => ComCall(104, this.p, UInt32, Options)
    RemoveAssemblyOptions(Options)
      => ComCall(105, this.p, UInt32, Options)
    SetAssemblyOptions(Options)
      => ComCall(106, this.p, UInt32, Options)
    GetExpressionSyntax(Flags)
      => ComCall(107, this.p, UInt32.Ptr, Flags)
    SetExpressionSyntax(Flags)
      => ComCall(108, this.p, UInt32, Flags)
    SetExpressionSyntaxByName(AbbrevName)
      => ComCall(109, this.p, PSTR, AbbrevName)
    GetNumberExpressionSyntaxes(Number)
      => ComCall(110, this.p, UInt32.Ptr, Number)
    GetExpressionSyntaxNames(Index, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(111, this.p, UInt32, Index, PSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetNumberEvents(Events)
      => ComCall(112, this.p, UInt32.Ptr, Events)
    GetEventIndexDescription(Index, Which, Buffer?, BufferSize, DescSize?)
      => ComCall(113, this.p, UInt32, Index, UInt32, Which, PSTR, Buffer?, UInt32, BufferSize, UInt32.Ptr, DescSize?)
    GetCurrentEventIndex(Index)
      => ComCall(114, this.p, UInt32.Ptr, Index)
    SetNextEventIndex(Relation, Value, NextIndex)
      => ComCall(115, this.p, UInt32, Relation, UInt32, Value, UInt32.Ptr, NextIndex)
}
struct IDebugControl4 extends IUnknown {
    static IID := "{94E60CE9-9B41-4B19-9FC0-6D9EB35272B3}"
    GetInterrupt()
      => ComCall(3, this.p)
    SetInterrupt(Flags)
      => ComCall(4, this.p, UInt32, Flags)
    GetInterruptTimeout(Seconds)
      => ComCall(5, this.p, UInt32.Ptr, Seconds)
    SetInterruptTimeout(Seconds)
      => ComCall(6, this.p, UInt32, Seconds)
    GetLogFile(Buffer?, FileSize?, Append)
      => ComCall(7, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, BOOL.Ptr, Append)
    OpenLogFile(File, Append)
      => ComCall(8, this.p, PSTR, File, BOOL, Append)
    CloseLogFile()
      => ComCall(9, this.p)
    GetLogMask(Mask)
      => ComCall(10, this.p, UInt32.Ptr, Mask)
    SetLogMask(Mask)
      => ComCall(11, this.p, UInt32, Mask)
    Input(Buffer, InputSize?)
      => ComCall(12, this.p, PSTR, Buffer, UInt32, Buffer.Length, UInt32.Ptr, InputSize?)
    ReturnInput(Buffer)
      => ComCall(13, this.p, PSTR, Buffer)
    Output(Mask, Format)
      => ComCall(14, this.p, UInt32, Mask, PSTR, Format)
    OutputVaList(Mask, Format, Args)
      => ComCall(15, this.p, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    ControlledOutput(OutputControl, Mask, Format)
      => ComCall(16, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format)
    ControlledOutputVaList(OutputControl, Mask, Format, Args)
      => ComCall(17, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    OutputPrompt(OutputControl, Format?)
      => ComCall(18, this.p, UInt32, OutputControl, PSTR, Format?)
    OutputPromptVaList(OutputControl, Format?, Args)
      => ComCall(19, this.p, UInt32, OutputControl, PSTR, Format?, Int8.Ptr, Args)
    GetPromptText(Buffer?, TextSize?)
      => ComCall(20, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    OutputCurrentState(OutputControl, Flags)
      => ComCall(21, this.p, UInt32, OutputControl, UInt32, Flags)
    OutputVersionInformation(OutputControl)
      => ComCall(22, this.p, UInt32, OutputControl)
    GetNotifyEventHandle(Handle)
      => ComCall(23, this.p, Int64.Ptr, Handle)
    SetNotifyEventHandle(Handle)
      => ComCall(24, this.p, Int64, Handle)
    Assemble(Offset, Instr, EndOffset)
      => ComCall(25, this.p, Int64, Offset, PSTR, Instr, Int64.Ptr, EndOffset)
    Disassemble(Offset, Flags, Buffer?, DisassemblySize?, EndOffset)
      => ComCall(26, this.p, Int64, Offset, UInt32, Flags, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, DisassemblySize?, Int64.Ptr, EndOffset)
    GetDisassembleEffectiveOffset(Offset)
      => ComCall(27, this.p, Int64.Ptr, Offset)
    OutputDisassembly(OutputControl, Offset, Flags, EndOffset)
      => ComCall(28, this.p, UInt32, OutputControl, Int64, Offset, UInt32, Flags, Int64.Ptr, EndOffset)
    OutputDisassemblyLines(OutputControl, PreviousLines, Offset, Flags, OffsetLine?, StartOffset?, EndOffset?, LineOffsets?)
      => ComCall(29, this.p, UInt32, OutputControl, UInt32, PreviousLines, UInt32, LineOffsets?.Length ?? 0, Int64, Offset, UInt32, Flags, UInt32.Ptr, OffsetLine?, Int64.Ptr, StartOffset?, Int64.Ptr, EndOffset?, Int64.Ptr, LineOffsets?)
    GetNearInstruction(Offset, Delta, NearOffset)
      => ComCall(30, this.p, Int64, Offset, Int32, Delta, Int64.Ptr, NearOffset)
    GetStackTrace(FrameOffset, StackOffset, InstructionOffset, Frames, FramesFilled?)
      => ComCall(31, this.p, Int64, FrameOffset, Int64, StackOffset, Int64, InstructionOffset, DEBUG_STACK_FRAME.Ptr, Frames, UInt32, Frames.Length, UInt32.Ptr, FramesFilled?)
    GetReturnOffset(Offset)
      => ComCall(32, this.p, Int64.Ptr, Offset)
    OutputStackTrace(OutputControl, Frames?, Flags)
      => ComCall(33, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME.Ptr, Frames?, UInt32, Frames?.Length ?? 0, UInt32, Flags)
    GetDebuggeeType(Class, Qualifier)
      => ComCall(34, this.p, UInt32.Ptr, Class, UInt32.Ptr, Qualifier)
    GetActualProcessorType(Type)
      => ComCall(35, this.p, UInt32.Ptr, Type)
    GetExecutingProcessorType(Type)
      => ComCall(36, this.p, UInt32.Ptr, Type)
    GetNumberPossibleExecutingProcessorTypes(Number)
      => ComCall(37, this.p, UInt32.Ptr, Number)
    GetPossibleExecutingProcessorTypes(Start, Types)
      => ComCall(38, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetNumberProcessors(Number)
      => ComCall(39, this.p, UInt32.Ptr, Number)
    GetSystemVersion(PlatformId, Major, Minor, ServicePackString?, ServicePackStringUsed?, ServicePackNumber, BuildString?, BuildStringUsed?)
      => ComCall(40, this.p, UInt32.Ptr, PlatformId, UInt32.Ptr, Major, UInt32.Ptr, Minor, PSTR, ServicePackString?, UInt32, ServicePackString?.Length ?? 0, UInt32.Ptr, ServicePackStringUsed?, UInt32.Ptr, ServicePackNumber, PSTR, BuildString?, UInt32, BuildString?.Length ?? 0, UInt32.Ptr, BuildStringUsed?)
    GetPageSize(Size)
      => ComCall(41, this.p, UInt32.Ptr, Size)
    IsPointer64Bit()
      => ComCall(42, this.p)
    ReadBugCheckData(Code, Arg1, Arg2, Arg3, Arg4)
      => ComCall(43, this.p, UInt32.Ptr, Code, Int64.Ptr, Arg1, Int64.Ptr, Arg2, Int64.Ptr, Arg3, Int64.Ptr, Arg4)
    GetNumberSupportedProcessorTypes(Number)
      => ComCall(44, this.p, UInt32.Ptr, Number)
    GetSupportedProcessorTypes(Start, Types)
      => ComCall(45, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetProcessorTypeNames(Type, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(46, this.p, UInt32, Type, PSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetEffectiveProcessorType(Type)
      => ComCall(47, this.p, UInt32.Ptr, Type)
    SetEffectiveProcessorType(Type)
      => ComCall(48, this.p, UInt32, Type)
    GetExecutionStatus(Status)
      => ComCall(49, this.p, UInt32.Ptr, Status)
    SetExecutionStatus(Status)
      => ComCall(50, this.p, UInt32, Status)
    GetCodeLevel(Level)
      => ComCall(51, this.p, UInt32.Ptr, Level)
    SetCodeLevel(Level)
      => ComCall(52, this.p, UInt32, Level)
    GetEngineOptions(Options)
      => ComCall(53, this.p, UInt32.Ptr, Options)
    AddEngineOptions(Options)
      => ComCall(54, this.p, UInt32, Options)
    RemoveEngineOptions(Options)
      => ComCall(55, this.p, UInt32, Options)
    SetEngineOptions(Options)
      => ComCall(56, this.p, UInt32, Options)
    GetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(57, this.p, UInt32.Ptr, OutputLevel, UInt32.Ptr, BreakLevel)
    SetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(58, this.p, UInt32, OutputLevel, UInt32, BreakLevel)
    GetTextMacro(Slot, Buffer?, MacroSize?)
      => ComCall(59, this.p, UInt32, Slot, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MacroSize?)
    SetTextMacro(Slot, Macro)
      => ComCall(60, this.p, UInt32, Slot, PSTR, Macro)
    GetRadix(Radix)
      => ComCall(61, this.p, UInt32.Ptr, Radix)
    SetRadix(Radix)
      => ComCall(62, this.p, UInt32, Radix)
    Evaluate(Expression, DesiredType, Value, RemainderIndex?)
      => ComCall(63, this.p, PSTR, Expression, UInt32, DesiredType, DEBUG_VALUE.Ptr, Value, UInt32.Ptr, RemainderIndex?)
    CoerceValue(In1, OutType, Out)
      => ComCall(64, this.p, DEBUG_VALUE.Ptr, In1, UInt32, OutType, DEBUG_VALUE.Ptr, Out)
    CoerceValues(In1, OutTypes, Out)
      => ComCall(65, this.p, UInt32, Out.Length, DEBUG_VALUE.Ptr, In1, UInt32.Ptr, OutTypes, DEBUG_VALUE.Ptr, Out)
    Execute(OutputControl, Command, Flags)
      => ComCall(66, this.p, UInt32, OutputControl, PSTR, Command, UInt32, Flags)
    ExecuteCommandFile(OutputControl, CommandFile, Flags)
      => ComCall(67, this.p, UInt32, OutputControl, PSTR, CommandFile, UInt32, Flags)
    GetNumberBreakpoints(Number)
      => ComCall(68, this.p, UInt32.Ptr, Number)
    GetBreakpointByIndex(Index, Bp)
      => ComCall(69, this.p, UInt32, Index, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointById(Id, Bp)
      => ComCall(70, this.p, UInt32, Id, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointParameters(Ids?, Start, Params)
      => ComCall(71, this.p, UInt32, Params.Length, UInt32.Ptr, Ids?, UInt32, Start, DEBUG_BREAKPOINT_PARAMETERS.Ptr, Params)
    AddBreakpoint(Type, DesiredId, Bp)
      => ComCall(72, this.p, UInt32, Type, UInt32, DesiredId, IDebugBreakpoint.Ptr, Bp)
    RemoveBreakpoint(Bp)
      => ComCall(73, this.p, IDebugBreakpoint, Bp)
    AddExtension(Path, Flags, Handle)
      => ComCall(74, this.p, PSTR, Path, UInt32, Flags, Int64.Ptr, Handle)
    RemoveExtension(Handle)
      => ComCall(75, this.p, Int64, Handle)
    GetExtensionByPath(Path, Handle)
      => ComCall(76, this.p, PSTR, Path, Int64.Ptr, Handle)
    CallExtension(Handle, Function, Arguments?)
      => ComCall(77, this.p, Int64, Handle, PSTR, Function, PSTR, Arguments?)
    GetExtensionFunction(Handle, FuncName, Function)
      => ComCall(78, this.p, Int64, Handle, PSTR, FuncName, FARPROC.Ptr, Function)
    GetWindbgExtensionApis32(Api)
      => ComCall(79, this.p, WINDBG_EXTENSION_APIS32.Ptr, Api)
    GetWindbgExtensionApis64(Api)
      => ComCall(80, this.p, WINDBG_EXTENSION_APIS64.Ptr, Api)
    GetNumberEventFilters(SpecificEvents, SpecificExceptions, ArbitraryExceptions)
      => ComCall(81, this.p, UInt32.Ptr, SpecificEvents, UInt32.Ptr, SpecificExceptions, UInt32.Ptr, ArbitraryExceptions)
    GetEventFilterText(Index, Buffer?, TextSize?)
      => ComCall(82, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    GetEventFilterCommand(Index, Buffer?, CommandSize?)
      => ComCall(83, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetEventFilterCommand(Index, Command)
      => ComCall(84, this.p, UInt32, Index, PSTR, Command)
    GetSpecificFilterParameters(Start, Params)
      => ComCall(85, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    SetSpecificFilterParameters(Start, Params)
      => ComCall(86, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    GetSpecificFilterArgument(Index, Buffer?, ArgumentSize?)
      => ComCall(87, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ArgumentSize?)
    SetSpecificFilterArgument(Index, Argument)
      => ComCall(88, this.p, UInt32, Index, PSTR, Argument)
    GetExceptionFilterParameters(Codes?, Start, Params)
      => ComCall(89, this.p, UInt32, Params.Length, UInt32.Ptr, Codes?, UInt32, Start, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    SetExceptionFilterParameters(Params)
      => ComCall(90, this.p, UInt32, Params.Length, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    GetExceptionFilterSecondCommand(Index, Buffer?, CommandSize?)
      => ComCall(91, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetExceptionFilterSecondCommand(Index, Command)
      => ComCall(92, this.p, UInt32, Index, PSTR, Command)
    WaitForEvent(Flags, Timeout)
      => ComCall(93, this.p, UInt32, Flags, UInt32, Timeout)
    GetLastEventInformation(Type, ProcessId, ThreadId, ExtraInformation?, ExtraInformationUsed?, Description?, DescriptionUsed?)
      => ComCall(94, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, DescriptionUsed?)
    GetCurrentTimeDate(TimeDate)
      => ComCall(95, this.p, UInt32.Ptr, TimeDate)
    GetCurrentSystemUpTime(UpTime)
      => ComCall(96, this.p, UInt32.Ptr, UpTime)
    GetDumpFormatFlags(FormatFlags)
      => ComCall(97, this.p, UInt32.Ptr, FormatFlags)
    GetNumberTextReplacements(NumRepl)
      => ComCall(98, this.p, UInt32.Ptr, NumRepl)
    GetTextReplacement(SrcText?, Index, SrcBuffer?, SrcSize?, DstBuffer?, DstSize?)
      => ComCall(99, this.p, PSTR, SrcText?, UInt32, Index, PSTR, SrcBuffer?, UInt32, SrcBuffer?.Length ?? 0, UInt32.Ptr, SrcSize?, PSTR, DstBuffer?, UInt32, DstBuffer?.Length ?? 0, UInt32.Ptr, DstSize?)
    SetTextReplacement(SrcText, DstText?)
      => ComCall(100, this.p, PSTR, SrcText, PSTR, DstText?)
    RemoveTextReplacements()
      => ComCall(101, this.p)
    OutputTextReplacements(OutputControl, Flags)
      => ComCall(102, this.p, UInt32, OutputControl, UInt32, Flags)
    GetAssemblyOptions(Options)
      => ComCall(103, this.p, UInt32.Ptr, Options)
    AddAssemblyOptions(Options)
      => ComCall(104, this.p, UInt32, Options)
    RemoveAssemblyOptions(Options)
      => ComCall(105, this.p, UInt32, Options)
    SetAssemblyOptions(Options)
      => ComCall(106, this.p, UInt32, Options)
    GetExpressionSyntax(Flags)
      => ComCall(107, this.p, UInt32.Ptr, Flags)
    SetExpressionSyntax(Flags)
      => ComCall(108, this.p, UInt32, Flags)
    SetExpressionSyntaxByName(AbbrevName)
      => ComCall(109, this.p, PSTR, AbbrevName)
    GetNumberExpressionSyntaxes(Number)
      => ComCall(110, this.p, UInt32.Ptr, Number)
    GetExpressionSyntaxNames(Index, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(111, this.p, UInt32, Index, PSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetNumberEvents(Events)
      => ComCall(112, this.p, UInt32.Ptr, Events)
    GetEventIndexDescription(Index, Which, Buffer?, BufferSize, DescSize?)
      => ComCall(113, this.p, UInt32, Index, UInt32, Which, PSTR, Buffer?, UInt32, BufferSize, UInt32.Ptr, DescSize?)
    GetCurrentEventIndex(Index)
      => ComCall(114, this.p, UInt32.Ptr, Index)
    SetNextEventIndex(Relation, Value, NextIndex)
      => ComCall(115, this.p, UInt32, Relation, UInt32, Value, UInt32.Ptr, NextIndex)
    GetLogFileWide(Buffer?, FileSize?, Append)
      => ComCall(116, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, BOOL.Ptr, Append)
    OpenLogFileWide(File, Append)
      => ComCall(117, this.p, "Str", File, BOOL, Append)
    InputWide(Buffer, InputSize?)
      => ComCall(118, this.p, PWSTR, Buffer, UInt32, Buffer.Length, UInt32.Ptr, InputSize?)
    ReturnInputWide(Buffer)
      => ComCall(119, this.p, "Str", Buffer)
    OutputWide(Mask, Format)
      => ComCall(120, this.p, UInt32, Mask, "Str", Format)
    OutputVaListWide(Mask, Format, Args)
      => ComCall(121, this.p, UInt32, Mask, "Str", Format, Int8.Ptr, Args)
    ControlledOutputWide(OutputControl, Mask, Format)
      => ComCall(122, this.p, UInt32, OutputControl, UInt32, Mask, "Str", Format)
    ControlledOutputVaListWide(OutputControl, Mask, Format, Args)
      => ComCall(123, this.p, UInt32, OutputControl, UInt32, Mask, "Str", Format, Int8.Ptr, Args)
    OutputPromptWide(OutputControl, Format?)
      => ComCall(124, this.p, UInt32, OutputControl, "Str", Format?)
    OutputPromptVaListWide(OutputControl, Format?, Args)
      => ComCall(125, this.p, UInt32, OutputControl, "Str", Format?, Int8.Ptr, Args)
    GetPromptTextWide(Buffer?, TextSize?)
      => ComCall(126, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    AssembleWide(Offset, Instr, EndOffset)
      => ComCall(127, this.p, Int64, Offset, "Str", Instr, Int64.Ptr, EndOffset)
    DisassembleWide(Offset, Flags, Buffer?, DisassemblySize?, EndOffset)
      => ComCall(128, this.p, Int64, Offset, UInt32, Flags, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, DisassemblySize?, Int64.Ptr, EndOffset)
    GetProcessorTypeNamesWide(Type, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(129, this.p, UInt32, Type, PWSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PWSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetTextMacroWide(Slot, Buffer?, MacroSize?)
      => ComCall(130, this.p, UInt32, Slot, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MacroSize?)
    SetTextMacroWide(Slot, Macro)
      => ComCall(131, this.p, UInt32, Slot, "Str", Macro)
    EvaluateWide(Expression, DesiredType, Value, RemainderIndex?)
      => ComCall(132, this.p, "Str", Expression, UInt32, DesiredType, DEBUG_VALUE.Ptr, Value, UInt32.Ptr, RemainderIndex?)
    ExecuteWide(OutputControl, Command, Flags)
      => ComCall(133, this.p, UInt32, OutputControl, "Str", Command, UInt32, Flags)
    ExecuteCommandFileWide(OutputControl, CommandFile, Flags)
      => ComCall(134, this.p, UInt32, OutputControl, "Str", CommandFile, UInt32, Flags)
    GetBreakpointByIndex2(Index, Bp)
      => ComCall(135, this.p, UInt32, Index, IDebugBreakpoint2.Ptr, Bp)
    GetBreakpointById2(Id, Bp)
      => ComCall(136, this.p, UInt32, Id, IDebugBreakpoint2.Ptr, Bp)
    AddBreakpoint2(Type, DesiredId, Bp)
      => ComCall(137, this.p, UInt32, Type, UInt32, DesiredId, IDebugBreakpoint2.Ptr, Bp)
    RemoveBreakpoint2(Bp)
      => ComCall(138, this.p, IDebugBreakpoint2, Bp)
    AddExtensionWide(Path, Flags, Handle)
      => ComCall(139, this.p, "Str", Path, UInt32, Flags, Int64.Ptr, Handle)
    GetExtensionByPathWide(Path, Handle)
      => ComCall(140, this.p, "Str", Path, Int64.Ptr, Handle)
    CallExtensionWide(Handle, Function, Arguments?)
      => ComCall(141, this.p, Int64, Handle, "Str", Function, "Str", Arguments?)
    GetExtensionFunctionWide(Handle, FuncName, Function)
      => ComCall(142, this.p, Int64, Handle, "Str", FuncName, FARPROC.Ptr, Function)
    GetEventFilterTextWide(Index, Buffer?, TextSize?)
      => ComCall(143, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    GetEventFilterCommandWide(Index, Buffer?, CommandSize?)
      => ComCall(144, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetEventFilterCommandWide(Index, Command)
      => ComCall(145, this.p, UInt32, Index, "Str", Command)
    GetSpecificFilterArgumentWide(Index, Buffer?, ArgumentSize?)
      => ComCall(146, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ArgumentSize?)
    SetSpecificFilterArgumentWide(Index, Argument)
      => ComCall(147, this.p, UInt32, Index, "Str", Argument)
    GetExceptionFilterSecondCommandWide(Index, Buffer?, CommandSize?)
      => ComCall(148, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetExceptionFilterSecondCommandWide(Index, Command)
      => ComCall(149, this.p, UInt32, Index, "Str", Command)
    GetLastEventInformationWide(Type, ProcessId, ThreadId, ExtraInformation?, ExtraInformationUsed?, Description?, DescriptionUsed?)
      => ComCall(150, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?, PWSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, DescriptionUsed?)
    GetTextReplacementWide(SrcText?, Index, SrcBuffer?, SrcSize?, DstBuffer?, DstSize?)
      => ComCall(151, this.p, "Str", SrcText?, UInt32, Index, PWSTR, SrcBuffer?, UInt32, SrcBuffer?.Length ?? 0, UInt32.Ptr, SrcSize?, PWSTR, DstBuffer?, UInt32, DstBuffer?.Length ?? 0, UInt32.Ptr, DstSize?)
    SetTextReplacementWide(SrcText, DstText?)
      => ComCall(152, this.p, "Str", SrcText, "Str", DstText?)
    SetExpressionSyntaxByNameWide(AbbrevName)
      => ComCall(153, this.p, "Str", AbbrevName)
    GetExpressionSyntaxNamesWide(Index, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(154, this.p, UInt32, Index, PWSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PWSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetEventIndexDescriptionWide(Index, Which, Buffer?, BufferSize, DescSize?)
      => ComCall(155, this.p, UInt32, Index, UInt32, Which, "Str", Buffer?, UInt32, BufferSize, UInt32.Ptr, DescSize?)
    GetLogFile2(Buffer?, FileSize?, Flags)
      => ComCall(156, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, UInt32.Ptr, Flags)
    OpenLogFile2(File, Flags)
      => ComCall(157, this.p, PSTR, File, UInt32, Flags)
    GetLogFile2Wide(Buffer?, FileSize?, Flags)
      => ComCall(158, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, UInt32.Ptr, Flags)
    OpenLogFile2Wide(File, Flags)
      => ComCall(159, this.p, "Str", File, UInt32, Flags)
    GetSystemVersionValues(PlatformId, Win32Major, Win32Minor, KdMajor?, KdMinor?)
      => ComCall(160, this.p, UInt32.Ptr, PlatformId, UInt32.Ptr, Win32Major, UInt32.Ptr, Win32Minor, UInt32.Ptr, KdMajor?, UInt32.Ptr, KdMinor?)
    GetSystemVersionString(Which, Buffer?, StringSize?)
      => ComCall(161, this.p, UInt32, Which, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSystemVersionStringWide(Which, Buffer?, StringSize?)
      => ComCall(162, this.p, UInt32, Which, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetContextStackTrace(StartContext?, Frames?, FrameContexts?, FrameContextsEntrySize, FramesFilled?)
      => ComCall(163, this.p, Struct.Ptr, StartContext?, UInt32, StartContext?.Size ?? 0, DEBUG_STACK_FRAME.Ptr, Frames?, UInt32, Frames?.Length ?? 0, Struct.Ptr, FrameContexts?, UInt32, FrameContexts?.Size ?? 0, UInt32, FrameContextsEntrySize, UInt32.Ptr, FramesFilled?)
    OutputContextStackTrace(OutputControl, Frames, FrameContexts, FrameContextsEntrySize, Flags)
      => ComCall(164, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME.Ptr, Frames, UInt32, Frames.Length, Struct.Ptr, FrameContexts, UInt32, FrameContexts.Size, UInt32, FrameContextsEntrySize, UInt32, Flags)
    GetStoredEventInformation(Type, ProcessId, ThreadId, Context?, ContextUsed?, ExtraInformation?, ExtraInformationUsed?)
      => ComCall(165, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, Context?, UInt32, Context?.Size ?? 0, UInt32.Ptr, ContextUsed?, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?)
    GetManagedStatus(Flags?, WhichString, String?, StringNeeded?)
      => ComCall(166, this.p, UInt32.Ptr, Flags?, UInt32, WhichString, PSTR, String?, UInt32, String?.Length ?? 0, UInt32.Ptr, StringNeeded?)
    GetManagedStatusWide(Flags?, WhichString, String?, StringNeeded?)
      => ComCall(167, this.p, UInt32.Ptr, Flags?, UInt32, WhichString, PWSTR, String?, UInt32, String?.Length ?? 0, UInt32.Ptr, StringNeeded?)
    ResetManagedStatus(Flags)
      => ComCall(168, this.p, UInt32, Flags)
}
struct IDebugControl5 extends IUnknown {
    static IID := "{B2FFE162-2412-429F-8D1D-5BF6DD824696}"
    GetInterrupt()
      => ComCall(3, this.p)
    SetInterrupt(Flags)
      => ComCall(4, this.p, UInt32, Flags)
    GetInterruptTimeout(Seconds)
      => ComCall(5, this.p, UInt32.Ptr, Seconds)
    SetInterruptTimeout(Seconds)
      => ComCall(6, this.p, UInt32, Seconds)
    GetLogFile(Buffer?, FileSize?, Append)
      => ComCall(7, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, BOOL.Ptr, Append)
    OpenLogFile(File, Append)
      => ComCall(8, this.p, PSTR, File, BOOL, Append)
    CloseLogFile()
      => ComCall(9, this.p)
    GetLogMask(Mask)
      => ComCall(10, this.p, UInt32.Ptr, Mask)
    SetLogMask(Mask)
      => ComCall(11, this.p, UInt32, Mask)
    Input(Buffer, InputSize?)
      => ComCall(12, this.p, PSTR, Buffer, UInt32, Buffer.Length, UInt32.Ptr, InputSize?)
    ReturnInput(Buffer)
      => ComCall(13, this.p, PSTR, Buffer)
    Output(Mask, Format)
      => ComCall(14, this.p, UInt32, Mask, PSTR, Format)
    OutputVaList(Mask, Format, Args)
      => ComCall(15, this.p, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    ControlledOutput(OutputControl, Mask, Format)
      => ComCall(16, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format)
    ControlledOutputVaList(OutputControl, Mask, Format, Args)
      => ComCall(17, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    OutputPrompt(OutputControl, Format?)
      => ComCall(18, this.p, UInt32, OutputControl, PSTR, Format?)
    OutputPromptVaList(OutputControl, Format?, Args)
      => ComCall(19, this.p, UInt32, OutputControl, PSTR, Format?, Int8.Ptr, Args)
    GetPromptText(Buffer?, TextSize?)
      => ComCall(20, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    OutputCurrentState(OutputControl, Flags)
      => ComCall(21, this.p, UInt32, OutputControl, UInt32, Flags)
    OutputVersionInformation(OutputControl)
      => ComCall(22, this.p, UInt32, OutputControl)
    GetNotifyEventHandle(Handle)
      => ComCall(23, this.p, Int64.Ptr, Handle)
    SetNotifyEventHandle(Handle)
      => ComCall(24, this.p, Int64, Handle)
    Assemble(Offset, Instr, EndOffset)
      => ComCall(25, this.p, Int64, Offset, PSTR, Instr, Int64.Ptr, EndOffset)
    Disassemble(Offset, Flags, Buffer?, DisassemblySize?, EndOffset)
      => ComCall(26, this.p, Int64, Offset, UInt32, Flags, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, DisassemblySize?, Int64.Ptr, EndOffset)
    GetDisassembleEffectiveOffset(Offset)
      => ComCall(27, this.p, Int64.Ptr, Offset)
    OutputDisassembly(OutputControl, Offset, Flags, EndOffset)
      => ComCall(28, this.p, UInt32, OutputControl, Int64, Offset, UInt32, Flags, Int64.Ptr, EndOffset)
    OutputDisassemblyLines(OutputControl, PreviousLines, Offset, Flags, OffsetLine?, StartOffset?, EndOffset?, LineOffsets?)
      => ComCall(29, this.p, UInt32, OutputControl, UInt32, PreviousLines, UInt32, LineOffsets?.Length ?? 0, Int64, Offset, UInt32, Flags, UInt32.Ptr, OffsetLine?, Int64.Ptr, StartOffset?, Int64.Ptr, EndOffset?, Int64.Ptr, LineOffsets?)
    GetNearInstruction(Offset, Delta, NearOffset)
      => ComCall(30, this.p, Int64, Offset, Int32, Delta, Int64.Ptr, NearOffset)
    GetStackTrace(FrameOffset, StackOffset, InstructionOffset, Frames, FramesFilled?)
      => ComCall(31, this.p, Int64, FrameOffset, Int64, StackOffset, Int64, InstructionOffset, DEBUG_STACK_FRAME.Ptr, Frames, UInt32, Frames.Length, UInt32.Ptr, FramesFilled?)
    GetReturnOffset(Offset)
      => ComCall(32, this.p, Int64.Ptr, Offset)
    OutputStackTrace(OutputControl, Frames?, Flags)
      => ComCall(33, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME.Ptr, Frames?, UInt32, Frames?.Length ?? 0, UInt32, Flags)
    GetDebuggeeType(Class, Qualifier)
      => ComCall(34, this.p, UInt32.Ptr, Class, UInt32.Ptr, Qualifier)
    GetActualProcessorType(Type)
      => ComCall(35, this.p, UInt32.Ptr, Type)
    GetExecutingProcessorType(Type)
      => ComCall(36, this.p, UInt32.Ptr, Type)
    GetNumberPossibleExecutingProcessorTypes(Number)
      => ComCall(37, this.p, UInt32.Ptr, Number)
    GetPossibleExecutingProcessorTypes(Start, Types)
      => ComCall(38, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetNumberProcessors(Number)
      => ComCall(39, this.p, UInt32.Ptr, Number)
    GetSystemVersion(PlatformId, Major, Minor, ServicePackString?, ServicePackStringUsed?, ServicePackNumber, BuildString?, BuildStringUsed?)
      => ComCall(40, this.p, UInt32.Ptr, PlatformId, UInt32.Ptr, Major, UInt32.Ptr, Minor, PSTR, ServicePackString?, UInt32, ServicePackString?.Length ?? 0, UInt32.Ptr, ServicePackStringUsed?, UInt32.Ptr, ServicePackNumber, PSTR, BuildString?, UInt32, BuildString?.Length ?? 0, UInt32.Ptr, BuildStringUsed?)
    GetPageSize(Size)
      => ComCall(41, this.p, UInt32.Ptr, Size)
    IsPointer64Bit()
      => ComCall(42, this.p)
    ReadBugCheckData(Code, Arg1, Arg2, Arg3, Arg4)
      => ComCall(43, this.p, UInt32.Ptr, Code, Int64.Ptr, Arg1, Int64.Ptr, Arg2, Int64.Ptr, Arg3, Int64.Ptr, Arg4)
    GetNumberSupportedProcessorTypes(Number)
      => ComCall(44, this.p, UInt32.Ptr, Number)
    GetSupportedProcessorTypes(Start, Types)
      => ComCall(45, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetProcessorTypeNames(Type, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(46, this.p, UInt32, Type, PSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetEffectiveProcessorType(Type)
      => ComCall(47, this.p, UInt32.Ptr, Type)
    SetEffectiveProcessorType(Type)
      => ComCall(48, this.p, UInt32, Type)
    GetExecutionStatus(Status)
      => ComCall(49, this.p, UInt32.Ptr, Status)
    SetExecutionStatus(Status)
      => ComCall(50, this.p, UInt32, Status)
    GetCodeLevel(Level)
      => ComCall(51, this.p, UInt32.Ptr, Level)
    SetCodeLevel(Level)
      => ComCall(52, this.p, UInt32, Level)
    GetEngineOptions(Options)
      => ComCall(53, this.p, UInt32.Ptr, Options)
    AddEngineOptions(Options)
      => ComCall(54, this.p, UInt32, Options)
    RemoveEngineOptions(Options)
      => ComCall(55, this.p, UInt32, Options)
    SetEngineOptions(Options)
      => ComCall(56, this.p, UInt32, Options)
    GetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(57, this.p, UInt32.Ptr, OutputLevel, UInt32.Ptr, BreakLevel)
    SetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(58, this.p, UInt32, OutputLevel, UInt32, BreakLevel)
    GetTextMacro(Slot, Buffer?, MacroSize?)
      => ComCall(59, this.p, UInt32, Slot, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MacroSize?)
    SetTextMacro(Slot, Macro)
      => ComCall(60, this.p, UInt32, Slot, PSTR, Macro)
    GetRadix(Radix)
      => ComCall(61, this.p, UInt32.Ptr, Radix)
    SetRadix(Radix)
      => ComCall(62, this.p, UInt32, Radix)
    Evaluate(Expression, DesiredType, Value, RemainderIndex?)
      => ComCall(63, this.p, PSTR, Expression, UInt32, DesiredType, DEBUG_VALUE.Ptr, Value, UInt32.Ptr, RemainderIndex?)
    CoerceValue(In1, OutType, Out)
      => ComCall(64, this.p, DEBUG_VALUE.Ptr, In1, UInt32, OutType, DEBUG_VALUE.Ptr, Out)
    CoerceValues(In1, OutTypes, Out)
      => ComCall(65, this.p, UInt32, Out.Length, DEBUG_VALUE.Ptr, In1, UInt32.Ptr, OutTypes, DEBUG_VALUE.Ptr, Out)
    Execute(OutputControl, Command, Flags)
      => ComCall(66, this.p, UInt32, OutputControl, PSTR, Command, UInt32, Flags)
    ExecuteCommandFile(OutputControl, CommandFile, Flags)
      => ComCall(67, this.p, UInt32, OutputControl, PSTR, CommandFile, UInt32, Flags)
    GetNumberBreakpoints(Number)
      => ComCall(68, this.p, UInt32.Ptr, Number)
    GetBreakpointByIndex(Index, Bp)
      => ComCall(69, this.p, UInt32, Index, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointById(Id, Bp)
      => ComCall(70, this.p, UInt32, Id, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointParameters(Ids?, Start, Params)
      => ComCall(71, this.p, UInt32, Params.Length, UInt32.Ptr, Ids?, UInt32, Start, DEBUG_BREAKPOINT_PARAMETERS.Ptr, Params)
    AddBreakpoint(Type, DesiredId, Bp)
      => ComCall(72, this.p, UInt32, Type, UInt32, DesiredId, IDebugBreakpoint.Ptr, Bp)
    RemoveBreakpoint(Bp)
      => ComCall(73, this.p, IDebugBreakpoint, Bp)
    AddExtension(Path, Flags, Handle)
      => ComCall(74, this.p, PSTR, Path, UInt32, Flags, Int64.Ptr, Handle)
    RemoveExtension(Handle)
      => ComCall(75, this.p, Int64, Handle)
    GetExtensionByPath(Path, Handle)
      => ComCall(76, this.p, PSTR, Path, Int64.Ptr, Handle)
    CallExtension(Handle, Function, Arguments?)
      => ComCall(77, this.p, Int64, Handle, PSTR, Function, PSTR, Arguments?)
    GetExtensionFunction(Handle, FuncName, Function)
      => ComCall(78, this.p, Int64, Handle, PSTR, FuncName, FARPROC.Ptr, Function)
    GetWindbgExtensionApis32(Api)
      => ComCall(79, this.p, WINDBG_EXTENSION_APIS32.Ptr, Api)
    GetWindbgExtensionApis64(Api)
      => ComCall(80, this.p, WINDBG_EXTENSION_APIS64.Ptr, Api)
    GetNumberEventFilters(SpecificEvents, SpecificExceptions, ArbitraryExceptions)
      => ComCall(81, this.p, UInt32.Ptr, SpecificEvents, UInt32.Ptr, SpecificExceptions, UInt32.Ptr, ArbitraryExceptions)
    GetEventFilterText(Index, Buffer?, TextSize?)
      => ComCall(82, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    GetEventFilterCommand(Index, Buffer?, CommandSize?)
      => ComCall(83, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetEventFilterCommand(Index, Command)
      => ComCall(84, this.p, UInt32, Index, PSTR, Command)
    GetSpecificFilterParameters(Start, Params)
      => ComCall(85, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    SetSpecificFilterParameters(Start, Params)
      => ComCall(86, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    GetSpecificFilterArgument(Index, Buffer?, ArgumentSize?)
      => ComCall(87, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ArgumentSize?)
    SetSpecificFilterArgument(Index, Argument)
      => ComCall(88, this.p, UInt32, Index, PSTR, Argument)
    GetExceptionFilterParameters(Codes?, Start, Params)
      => ComCall(89, this.p, UInt32, Params.Length, UInt32.Ptr, Codes?, UInt32, Start, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    SetExceptionFilterParameters(Params)
      => ComCall(90, this.p, UInt32, Params.Length, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    GetExceptionFilterSecondCommand(Index, Buffer?, CommandSize?)
      => ComCall(91, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetExceptionFilterSecondCommand(Index, Command)
      => ComCall(92, this.p, UInt32, Index, PSTR, Command)
    WaitForEvent(Flags, Timeout)
      => ComCall(93, this.p, UInt32, Flags, UInt32, Timeout)
    GetLastEventInformation(Type, ProcessId, ThreadId, ExtraInformation?, ExtraInformationUsed?, Description?, DescriptionUsed?)
      => ComCall(94, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, DescriptionUsed?)
    GetCurrentTimeDate(TimeDate)
      => ComCall(95, this.p, UInt32.Ptr, TimeDate)
    GetCurrentSystemUpTime(UpTime)
      => ComCall(96, this.p, UInt32.Ptr, UpTime)
    GetDumpFormatFlags(FormatFlags)
      => ComCall(97, this.p, UInt32.Ptr, FormatFlags)
    GetNumberTextReplacements(NumRepl)
      => ComCall(98, this.p, UInt32.Ptr, NumRepl)
    GetTextReplacement(SrcText?, Index, SrcBuffer?, SrcSize?, DstBuffer?, DstSize?)
      => ComCall(99, this.p, PSTR, SrcText?, UInt32, Index, PSTR, SrcBuffer?, UInt32, SrcBuffer?.Length ?? 0, UInt32.Ptr, SrcSize?, PSTR, DstBuffer?, UInt32, DstBuffer?.Length ?? 0, UInt32.Ptr, DstSize?)
    SetTextReplacement(SrcText, DstText?)
      => ComCall(100, this.p, PSTR, SrcText, PSTR, DstText?)
    RemoveTextReplacements()
      => ComCall(101, this.p)
    OutputTextReplacements(OutputControl, Flags)
      => ComCall(102, this.p, UInt32, OutputControl, UInt32, Flags)
    GetAssemblyOptions(Options)
      => ComCall(103, this.p, UInt32.Ptr, Options)
    AddAssemblyOptions(Options)
      => ComCall(104, this.p, UInt32, Options)
    RemoveAssemblyOptions(Options)
      => ComCall(105, this.p, UInt32, Options)
    SetAssemblyOptions(Options)
      => ComCall(106, this.p, UInt32, Options)
    GetExpressionSyntax(Flags)
      => ComCall(107, this.p, UInt32.Ptr, Flags)
    SetExpressionSyntax(Flags)
      => ComCall(108, this.p, UInt32, Flags)
    SetExpressionSyntaxByName(AbbrevName)
      => ComCall(109, this.p, PSTR, AbbrevName)
    GetNumberExpressionSyntaxes(Number)
      => ComCall(110, this.p, UInt32.Ptr, Number)
    GetExpressionSyntaxNames(Index, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(111, this.p, UInt32, Index, PSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetNumberEvents(Events)
      => ComCall(112, this.p, UInt32.Ptr, Events)
    GetEventIndexDescription(Index, Which, Buffer?, BufferSize, DescSize?)
      => ComCall(113, this.p, UInt32, Index, UInt32, Which, PSTR, Buffer?, UInt32, BufferSize, UInt32.Ptr, DescSize?)
    GetCurrentEventIndex(Index)
      => ComCall(114, this.p, UInt32.Ptr, Index)
    SetNextEventIndex(Relation, Value, NextIndex)
      => ComCall(115, this.p, UInt32, Relation, UInt32, Value, UInt32.Ptr, NextIndex)
    GetLogFileWide(Buffer?, FileSize?, Append)
      => ComCall(116, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, BOOL.Ptr, Append)
    OpenLogFileWide(File, Append)
      => ComCall(117, this.p, "Str", File, BOOL, Append)
    InputWide(Buffer, InputSize?)
      => ComCall(118, this.p, PWSTR, Buffer, UInt32, Buffer.Length, UInt32.Ptr, InputSize?)
    ReturnInputWide(Buffer)
      => ComCall(119, this.p, "Str", Buffer)
    OutputWide(Mask, Format)
      => ComCall(120, this.p, UInt32, Mask, "Str", Format)
    OutputVaListWide(Mask, Format, Args)
      => ComCall(121, this.p, UInt32, Mask, "Str", Format, Int8.Ptr, Args)
    ControlledOutputWide(OutputControl, Mask, Format)
      => ComCall(122, this.p, UInt32, OutputControl, UInt32, Mask, "Str", Format)
    ControlledOutputVaListWide(OutputControl, Mask, Format, Args)
      => ComCall(123, this.p, UInt32, OutputControl, UInt32, Mask, "Str", Format, Int8.Ptr, Args)
    OutputPromptWide(OutputControl, Format?)
      => ComCall(124, this.p, UInt32, OutputControl, "Str", Format?)
    OutputPromptVaListWide(OutputControl, Format?, Args)
      => ComCall(125, this.p, UInt32, OutputControl, "Str", Format?, Int8.Ptr, Args)
    GetPromptTextWide(Buffer?, TextSize?)
      => ComCall(126, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    AssembleWide(Offset, Instr, EndOffset)
      => ComCall(127, this.p, Int64, Offset, "Str", Instr, Int64.Ptr, EndOffset)
    DisassembleWide(Offset, Flags, Buffer?, DisassemblySize?, EndOffset)
      => ComCall(128, this.p, Int64, Offset, UInt32, Flags, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, DisassemblySize?, Int64.Ptr, EndOffset)
    GetProcessorTypeNamesWide(Type, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(129, this.p, UInt32, Type, PWSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PWSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetTextMacroWide(Slot, Buffer?, MacroSize?)
      => ComCall(130, this.p, UInt32, Slot, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MacroSize?)
    SetTextMacroWide(Slot, Macro)
      => ComCall(131, this.p, UInt32, Slot, "Str", Macro)
    EvaluateWide(Expression, DesiredType, Value, RemainderIndex?)
      => ComCall(132, this.p, "Str", Expression, UInt32, DesiredType, DEBUG_VALUE.Ptr, Value, UInt32.Ptr, RemainderIndex?)
    ExecuteWide(OutputControl, Command, Flags)
      => ComCall(133, this.p, UInt32, OutputControl, "Str", Command, UInt32, Flags)
    ExecuteCommandFileWide(OutputControl, CommandFile, Flags)
      => ComCall(134, this.p, UInt32, OutputControl, "Str", CommandFile, UInt32, Flags)
    GetBreakpointByIndex2(Index, Bp)
      => ComCall(135, this.p, UInt32, Index, IDebugBreakpoint2.Ptr, Bp)
    GetBreakpointById2(Id, Bp)
      => ComCall(136, this.p, UInt32, Id, IDebugBreakpoint2.Ptr, Bp)
    AddBreakpoint2(Type, DesiredId, Bp)
      => ComCall(137, this.p, UInt32, Type, UInt32, DesiredId, IDebugBreakpoint2.Ptr, Bp)
    RemoveBreakpoint2(Bp)
      => ComCall(138, this.p, IDebugBreakpoint2, Bp)
    AddExtensionWide(Path, Flags, Handle)
      => ComCall(139, this.p, "Str", Path, UInt32, Flags, Int64.Ptr, Handle)
    GetExtensionByPathWide(Path, Handle)
      => ComCall(140, this.p, "Str", Path, Int64.Ptr, Handle)
    CallExtensionWide(Handle, Function, Arguments?)
      => ComCall(141, this.p, Int64, Handle, "Str", Function, "Str", Arguments?)
    GetExtensionFunctionWide(Handle, FuncName, Function)
      => ComCall(142, this.p, Int64, Handle, "Str", FuncName, FARPROC.Ptr, Function)
    GetEventFilterTextWide(Index, Buffer?, TextSize?)
      => ComCall(143, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    GetEventFilterCommandWide(Index, Buffer?, CommandSize?)
      => ComCall(144, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetEventFilterCommandWide(Index, Command)
      => ComCall(145, this.p, UInt32, Index, "Str", Command)
    GetSpecificFilterArgumentWide(Index, Buffer?, ArgumentSize?)
      => ComCall(146, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ArgumentSize?)
    SetSpecificFilterArgumentWide(Index, Argument)
      => ComCall(147, this.p, UInt32, Index, "Str", Argument)
    GetExceptionFilterSecondCommandWide(Index, Buffer?, CommandSize?)
      => ComCall(148, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetExceptionFilterSecondCommandWide(Index, Command)
      => ComCall(149, this.p, UInt32, Index, "Str", Command)
    GetLastEventInformationWide(Type, ProcessId, ThreadId, ExtraInformation?, ExtraInformationUsed?, Description?, DescriptionUsed?)
      => ComCall(150, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?, PWSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, DescriptionUsed?)
    GetTextReplacementWide(SrcText?, Index, SrcBuffer?, SrcSize?, DstBuffer?, DstSize?)
      => ComCall(151, this.p, "Str", SrcText?, UInt32, Index, PWSTR, SrcBuffer?, UInt32, SrcBuffer?.Length ?? 0, UInt32.Ptr, SrcSize?, PWSTR, DstBuffer?, UInt32, DstBuffer?.Length ?? 0, UInt32.Ptr, DstSize?)
    SetTextReplacementWide(SrcText, DstText?)
      => ComCall(152, this.p, "Str", SrcText, "Str", DstText?)
    SetExpressionSyntaxByNameWide(AbbrevName)
      => ComCall(153, this.p, "Str", AbbrevName)
    GetExpressionSyntaxNamesWide(Index, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(154, this.p, UInt32, Index, PWSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PWSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetEventIndexDescriptionWide(Index, Which, Buffer?, BufferSize, DescSize?)
      => ComCall(155, this.p, UInt32, Index, UInt32, Which, "Str", Buffer?, UInt32, BufferSize, UInt32.Ptr, DescSize?)
    GetLogFile2(Buffer?, FileSize?, Flags)
      => ComCall(156, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, UInt32.Ptr, Flags)
    OpenLogFile2(File, Flags)
      => ComCall(157, this.p, PSTR, File, UInt32, Flags)
    GetLogFile2Wide(Buffer?, FileSize?, Flags)
      => ComCall(158, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, UInt32.Ptr, Flags)
    OpenLogFile2Wide(File, Flags)
      => ComCall(159, this.p, "Str", File, UInt32, Flags)
    GetSystemVersionValues(PlatformId, Win32Major, Win32Minor, KdMajor?, KdMinor?)
      => ComCall(160, this.p, UInt32.Ptr, PlatformId, UInt32.Ptr, Win32Major, UInt32.Ptr, Win32Minor, UInt32.Ptr, KdMajor?, UInt32.Ptr, KdMinor?)
    GetSystemVersionString(Which, Buffer?, StringSize?)
      => ComCall(161, this.p, UInt32, Which, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSystemVersionStringWide(Which, Buffer?, StringSize?)
      => ComCall(162, this.p, UInt32, Which, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetContextStackTrace(StartContext?, Frames?, FrameContexts?, FrameContextsEntrySize, FramesFilled?)
      => ComCall(163, this.p, Struct.Ptr, StartContext?, UInt32, StartContext?.Size ?? 0, DEBUG_STACK_FRAME.Ptr, Frames?, UInt32, Frames?.Length ?? 0, Struct.Ptr, FrameContexts?, UInt32, FrameContexts?.Size ?? 0, UInt32, FrameContextsEntrySize, UInt32.Ptr, FramesFilled?)
    OutputContextStackTrace(OutputControl, Frames, FrameContexts, FrameContextsEntrySize, Flags)
      => ComCall(164, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME.Ptr, Frames, UInt32, Frames.Length, Struct.Ptr, FrameContexts, UInt32, FrameContexts.Size, UInt32, FrameContextsEntrySize, UInt32, Flags)
    GetStoredEventInformation(Type, ProcessId, ThreadId, Context?, ContextUsed?, ExtraInformation?, ExtraInformationUsed?)
      => ComCall(165, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, Context?, UInt32, Context?.Size ?? 0, UInt32.Ptr, ContextUsed?, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?)
    GetManagedStatus(Flags?, WhichString, String?, StringNeeded?)
      => ComCall(166, this.p, UInt32.Ptr, Flags?, UInt32, WhichString, PSTR, String?, UInt32, String?.Length ?? 0, UInt32.Ptr, StringNeeded?)
    GetManagedStatusWide(Flags?, WhichString, String?, StringNeeded?)
      => ComCall(167, this.p, UInt32.Ptr, Flags?, UInt32, WhichString, PWSTR, String?, UInt32, String?.Length ?? 0, UInt32.Ptr, StringNeeded?)
    ResetManagedStatus(Flags)
      => ComCall(168, this.p, UInt32, Flags)
    GetStackTraceEx(FrameOffset, StackOffset, InstructionOffset, Frames, FramesFilled?)
      => ComCall(169, this.p, Int64, FrameOffset, Int64, StackOffset, Int64, InstructionOffset, DEBUG_STACK_FRAME_EX.Ptr, Frames, UInt32, Frames.Length, UInt32.Ptr, FramesFilled?)
    OutputStackTraceEx(OutputControl, Frames?, Flags)
      => ComCall(170, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME_EX.Ptr, Frames?, UInt32, Frames?.Length ?? 0, UInt32, Flags)
    GetContextStackTraceEx(StartContext?, Frames?, FrameContexts?, FrameContextsEntrySize, FramesFilled?)
      => ComCall(171, this.p, Struct.Ptr, StartContext?, UInt32, StartContext?.Size ?? 0, DEBUG_STACK_FRAME_EX.Ptr, Frames?, UInt32, Frames?.Length ?? 0, Struct.Ptr, FrameContexts?, UInt32, FrameContexts?.Size ?? 0, UInt32, FrameContextsEntrySize, UInt32.Ptr, FramesFilled?)
    OutputContextStackTraceEx(OutputControl, Frames, FrameContexts, FrameContextsEntrySize, Flags)
      => ComCall(172, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME_EX.Ptr, Frames, UInt32, Frames.Length, Struct.Ptr, FrameContexts, UInt32, FrameContexts.Size, UInt32, FrameContextsEntrySize, UInt32, Flags)
    GetBreakpointByGuid(Guid, Bp)
      => ComCall(173, this.p, GUID.Ptr, Guid, IDebugBreakpoint3.Ptr, Bp)
}
struct IDebugControl6 extends IUnknown {
    static IID := "{BC0D583F-126D-43A1-9CC4-A860AB1D537B}"
    GetInterrupt()
      => ComCall(3, this.p)
    SetInterrupt(Flags)
      => ComCall(4, this.p, UInt32, Flags)
    GetInterruptTimeout(Seconds)
      => ComCall(5, this.p, UInt32.Ptr, Seconds)
    SetInterruptTimeout(Seconds)
      => ComCall(6, this.p, UInt32, Seconds)
    GetLogFile(Buffer?, FileSize?, Append)
      => ComCall(7, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, BOOL.Ptr, Append)
    OpenLogFile(File, Append)
      => ComCall(8, this.p, PSTR, File, BOOL, Append)
    CloseLogFile()
      => ComCall(9, this.p)
    GetLogMask(Mask)
      => ComCall(10, this.p, UInt32.Ptr, Mask)
    SetLogMask(Mask)
      => ComCall(11, this.p, UInt32, Mask)
    Input(Buffer, InputSize?)
      => ComCall(12, this.p, PSTR, Buffer, UInt32, Buffer.Length, UInt32.Ptr, InputSize?)
    ReturnInput(Buffer)
      => ComCall(13, this.p, PSTR, Buffer)
    Output(Mask, Format)
      => ComCall(14, this.p, UInt32, Mask, PSTR, Format)
    OutputVaList(Mask, Format, Args)
      => ComCall(15, this.p, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    ControlledOutput(OutputControl, Mask, Format)
      => ComCall(16, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format)
    ControlledOutputVaList(OutputControl, Mask, Format, Args)
      => ComCall(17, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    OutputPrompt(OutputControl, Format?)
      => ComCall(18, this.p, UInt32, OutputControl, PSTR, Format?)
    OutputPromptVaList(OutputControl, Format?, Args)
      => ComCall(19, this.p, UInt32, OutputControl, PSTR, Format?, Int8.Ptr, Args)
    GetPromptText(Buffer?, TextSize?)
      => ComCall(20, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    OutputCurrentState(OutputControl, Flags)
      => ComCall(21, this.p, UInt32, OutputControl, UInt32, Flags)
    OutputVersionInformation(OutputControl)
      => ComCall(22, this.p, UInt32, OutputControl)
    GetNotifyEventHandle(Handle)
      => ComCall(23, this.p, Int64.Ptr, Handle)
    SetNotifyEventHandle(Handle)
      => ComCall(24, this.p, Int64, Handle)
    Assemble(Offset, Instr, EndOffset)
      => ComCall(25, this.p, Int64, Offset, PSTR, Instr, Int64.Ptr, EndOffset)
    Disassemble(Offset, Flags, Buffer?, DisassemblySize?, EndOffset)
      => ComCall(26, this.p, Int64, Offset, UInt32, Flags, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, DisassemblySize?, Int64.Ptr, EndOffset)
    GetDisassembleEffectiveOffset(Offset)
      => ComCall(27, this.p, Int64.Ptr, Offset)
    OutputDisassembly(OutputControl, Offset, Flags, EndOffset)
      => ComCall(28, this.p, UInt32, OutputControl, Int64, Offset, UInt32, Flags, Int64.Ptr, EndOffset)
    OutputDisassemblyLines(OutputControl, PreviousLines, Offset, Flags, OffsetLine?, StartOffset?, EndOffset?, LineOffsets?)
      => ComCall(29, this.p, UInt32, OutputControl, UInt32, PreviousLines, UInt32, LineOffsets?.Length ?? 0, Int64, Offset, UInt32, Flags, UInt32.Ptr, OffsetLine?, Int64.Ptr, StartOffset?, Int64.Ptr, EndOffset?, Int64.Ptr, LineOffsets?)
    GetNearInstruction(Offset, Delta, NearOffset)
      => ComCall(30, this.p, Int64, Offset, Int32, Delta, Int64.Ptr, NearOffset)
    GetStackTrace(FrameOffset, StackOffset, InstructionOffset, Frames, FramesFilled?)
      => ComCall(31, this.p, Int64, FrameOffset, Int64, StackOffset, Int64, InstructionOffset, DEBUG_STACK_FRAME.Ptr, Frames, UInt32, Frames.Length, UInt32.Ptr, FramesFilled?)
    GetReturnOffset(Offset)
      => ComCall(32, this.p, Int64.Ptr, Offset)
    OutputStackTrace(OutputControl, Frames?, Flags)
      => ComCall(33, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME.Ptr, Frames?, UInt32, Frames?.Length ?? 0, UInt32, Flags)
    GetDebuggeeType(Class, Qualifier)
      => ComCall(34, this.p, UInt32.Ptr, Class, UInt32.Ptr, Qualifier)
    GetActualProcessorType(Type)
      => ComCall(35, this.p, UInt32.Ptr, Type)
    GetExecutingProcessorType(Type)
      => ComCall(36, this.p, UInt32.Ptr, Type)
    GetNumberPossibleExecutingProcessorTypes(Number)
      => ComCall(37, this.p, UInt32.Ptr, Number)
    GetPossibleExecutingProcessorTypes(Start, Types)
      => ComCall(38, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetNumberProcessors(Number)
      => ComCall(39, this.p, UInt32.Ptr, Number)
    GetSystemVersion(PlatformId, Major, Minor, ServicePackString?, ServicePackStringUsed?, ServicePackNumber, BuildString?, BuildStringUsed?)
      => ComCall(40, this.p, UInt32.Ptr, PlatformId, UInt32.Ptr, Major, UInt32.Ptr, Minor, PSTR, ServicePackString?, UInt32, ServicePackString?.Length ?? 0, UInt32.Ptr, ServicePackStringUsed?, UInt32.Ptr, ServicePackNumber, PSTR, BuildString?, UInt32, BuildString?.Length ?? 0, UInt32.Ptr, BuildStringUsed?)
    GetPageSize(Size)
      => ComCall(41, this.p, UInt32.Ptr, Size)
    IsPointer64Bit()
      => ComCall(42, this.p)
    ReadBugCheckData(Code, Arg1, Arg2, Arg3, Arg4)
      => ComCall(43, this.p, UInt32.Ptr, Code, Int64.Ptr, Arg1, Int64.Ptr, Arg2, Int64.Ptr, Arg3, Int64.Ptr, Arg4)
    GetNumberSupportedProcessorTypes(Number)
      => ComCall(44, this.p, UInt32.Ptr, Number)
    GetSupportedProcessorTypes(Start, Types)
      => ComCall(45, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetProcessorTypeNames(Type, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(46, this.p, UInt32, Type, PSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetEffectiveProcessorType(Type)
      => ComCall(47, this.p, UInt32.Ptr, Type)
    SetEffectiveProcessorType(Type)
      => ComCall(48, this.p, UInt32, Type)
    GetExecutionStatus(Status)
      => ComCall(49, this.p, UInt32.Ptr, Status)
    SetExecutionStatus(Status)
      => ComCall(50, this.p, UInt32, Status)
    GetCodeLevel(Level)
      => ComCall(51, this.p, UInt32.Ptr, Level)
    SetCodeLevel(Level)
      => ComCall(52, this.p, UInt32, Level)
    GetEngineOptions(Options)
      => ComCall(53, this.p, UInt32.Ptr, Options)
    AddEngineOptions(Options)
      => ComCall(54, this.p, UInt32, Options)
    RemoveEngineOptions(Options)
      => ComCall(55, this.p, UInt32, Options)
    SetEngineOptions(Options)
      => ComCall(56, this.p, UInt32, Options)
    GetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(57, this.p, UInt32.Ptr, OutputLevel, UInt32.Ptr, BreakLevel)
    SetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(58, this.p, UInt32, OutputLevel, UInt32, BreakLevel)
    GetTextMacro(Slot, Buffer?, MacroSize?)
      => ComCall(59, this.p, UInt32, Slot, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MacroSize?)
    SetTextMacro(Slot, Macro)
      => ComCall(60, this.p, UInt32, Slot, PSTR, Macro)
    GetRadix(Radix)
      => ComCall(61, this.p, UInt32.Ptr, Radix)
    SetRadix(Radix)
      => ComCall(62, this.p, UInt32, Radix)
    Evaluate(Expression, DesiredType, Value, RemainderIndex?)
      => ComCall(63, this.p, PSTR, Expression, UInt32, DesiredType, DEBUG_VALUE.Ptr, Value, UInt32.Ptr, RemainderIndex?)
    CoerceValue(In1, OutType, Out)
      => ComCall(64, this.p, DEBUG_VALUE.Ptr, In1, UInt32, OutType, DEBUG_VALUE.Ptr, Out)
    CoerceValues(In1, OutTypes, Out)
      => ComCall(65, this.p, UInt32, Out.Length, DEBUG_VALUE.Ptr, In1, UInt32.Ptr, OutTypes, DEBUG_VALUE.Ptr, Out)
    Execute(OutputControl, Command, Flags)
      => ComCall(66, this.p, UInt32, OutputControl, PSTR, Command, UInt32, Flags)
    ExecuteCommandFile(OutputControl, CommandFile, Flags)
      => ComCall(67, this.p, UInt32, OutputControl, PSTR, CommandFile, UInt32, Flags)
    GetNumberBreakpoints(Number)
      => ComCall(68, this.p, UInt32.Ptr, Number)
    GetBreakpointByIndex(Index, Bp)
      => ComCall(69, this.p, UInt32, Index, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointById(Id, Bp)
      => ComCall(70, this.p, UInt32, Id, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointParameters(Ids?, Start, Params)
      => ComCall(71, this.p, UInt32, Params.Length, UInt32.Ptr, Ids?, UInt32, Start, DEBUG_BREAKPOINT_PARAMETERS.Ptr, Params)
    AddBreakpoint(Type, DesiredId, Bp)
      => ComCall(72, this.p, UInt32, Type, UInt32, DesiredId, IDebugBreakpoint.Ptr, Bp)
    RemoveBreakpoint(Bp)
      => ComCall(73, this.p, IDebugBreakpoint, Bp)
    AddExtension(Path, Flags, Handle)
      => ComCall(74, this.p, PSTR, Path, UInt32, Flags, Int64.Ptr, Handle)
    RemoveExtension(Handle)
      => ComCall(75, this.p, Int64, Handle)
    GetExtensionByPath(Path, Handle)
      => ComCall(76, this.p, PSTR, Path, Int64.Ptr, Handle)
    CallExtension(Handle, Function, Arguments?)
      => ComCall(77, this.p, Int64, Handle, PSTR, Function, PSTR, Arguments?)
    GetExtensionFunction(Handle, FuncName, Function)
      => ComCall(78, this.p, Int64, Handle, PSTR, FuncName, FARPROC.Ptr, Function)
    GetWindbgExtensionApis32(Api)
      => ComCall(79, this.p, WINDBG_EXTENSION_APIS32.Ptr, Api)
    GetWindbgExtensionApis64(Api)
      => ComCall(80, this.p, WINDBG_EXTENSION_APIS64.Ptr, Api)
    GetNumberEventFilters(SpecificEvents, SpecificExceptions, ArbitraryExceptions)
      => ComCall(81, this.p, UInt32.Ptr, SpecificEvents, UInt32.Ptr, SpecificExceptions, UInt32.Ptr, ArbitraryExceptions)
    GetEventFilterText(Index, Buffer?, TextSize?)
      => ComCall(82, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    GetEventFilterCommand(Index, Buffer?, CommandSize?)
      => ComCall(83, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetEventFilterCommand(Index, Command)
      => ComCall(84, this.p, UInt32, Index, PSTR, Command)
    GetSpecificFilterParameters(Start, Params)
      => ComCall(85, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    SetSpecificFilterParameters(Start, Params)
      => ComCall(86, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    GetSpecificFilterArgument(Index, Buffer?, ArgumentSize?)
      => ComCall(87, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ArgumentSize?)
    SetSpecificFilterArgument(Index, Argument)
      => ComCall(88, this.p, UInt32, Index, PSTR, Argument)
    GetExceptionFilterParameters(Codes?, Start, Params)
      => ComCall(89, this.p, UInt32, Params.Length, UInt32.Ptr, Codes?, UInt32, Start, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    SetExceptionFilterParameters(Params)
      => ComCall(90, this.p, UInt32, Params.Length, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    GetExceptionFilterSecondCommand(Index, Buffer?, CommandSize?)
      => ComCall(91, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetExceptionFilterSecondCommand(Index, Command)
      => ComCall(92, this.p, UInt32, Index, PSTR, Command)
    WaitForEvent(Flags, Timeout)
      => ComCall(93, this.p, UInt32, Flags, UInt32, Timeout)
    GetLastEventInformation(Type, ProcessId, ThreadId, ExtraInformation?, ExtraInformationUsed?, Description?, DescriptionUsed?)
      => ComCall(94, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, DescriptionUsed?)
    GetCurrentTimeDate(TimeDate)
      => ComCall(95, this.p, UInt32.Ptr, TimeDate)
    GetCurrentSystemUpTime(UpTime)
      => ComCall(96, this.p, UInt32.Ptr, UpTime)
    GetDumpFormatFlags(FormatFlags)
      => ComCall(97, this.p, UInt32.Ptr, FormatFlags)
    GetNumberTextReplacements(NumRepl)
      => ComCall(98, this.p, UInt32.Ptr, NumRepl)
    GetTextReplacement(SrcText?, Index, SrcBuffer?, SrcSize?, DstBuffer?, DstSize?)
      => ComCall(99, this.p, PSTR, SrcText?, UInt32, Index, PSTR, SrcBuffer?, UInt32, SrcBuffer?.Length ?? 0, UInt32.Ptr, SrcSize?, PSTR, DstBuffer?, UInt32, DstBuffer?.Length ?? 0, UInt32.Ptr, DstSize?)
    SetTextReplacement(SrcText, DstText?)
      => ComCall(100, this.p, PSTR, SrcText, PSTR, DstText?)
    RemoveTextReplacements()
      => ComCall(101, this.p)
    OutputTextReplacements(OutputControl, Flags)
      => ComCall(102, this.p, UInt32, OutputControl, UInt32, Flags)
    GetAssemblyOptions(Options)
      => ComCall(103, this.p, UInt32.Ptr, Options)
    AddAssemblyOptions(Options)
      => ComCall(104, this.p, UInt32, Options)
    RemoveAssemblyOptions(Options)
      => ComCall(105, this.p, UInt32, Options)
    SetAssemblyOptions(Options)
      => ComCall(106, this.p, UInt32, Options)
    GetExpressionSyntax(Flags)
      => ComCall(107, this.p, UInt32.Ptr, Flags)
    SetExpressionSyntax(Flags)
      => ComCall(108, this.p, UInt32, Flags)
    SetExpressionSyntaxByName(AbbrevName)
      => ComCall(109, this.p, PSTR, AbbrevName)
    GetNumberExpressionSyntaxes(Number)
      => ComCall(110, this.p, UInt32.Ptr, Number)
    GetExpressionSyntaxNames(Index, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(111, this.p, UInt32, Index, PSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetNumberEvents(Events)
      => ComCall(112, this.p, UInt32.Ptr, Events)
    GetEventIndexDescription(Index, Which, Buffer?, BufferSize, DescSize?)
      => ComCall(113, this.p, UInt32, Index, UInt32, Which, PSTR, Buffer?, UInt32, BufferSize, UInt32.Ptr, DescSize?)
    GetCurrentEventIndex(Index)
      => ComCall(114, this.p, UInt32.Ptr, Index)
    SetNextEventIndex(Relation, Value, NextIndex)
      => ComCall(115, this.p, UInt32, Relation, UInt32, Value, UInt32.Ptr, NextIndex)
    GetLogFileWide(Buffer?, FileSize?, Append)
      => ComCall(116, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, BOOL.Ptr, Append)
    OpenLogFileWide(File, Append)
      => ComCall(117, this.p, "Str", File, BOOL, Append)
    InputWide(Buffer, InputSize?)
      => ComCall(118, this.p, PWSTR, Buffer, UInt32, Buffer.Length, UInt32.Ptr, InputSize?)
    ReturnInputWide(Buffer)
      => ComCall(119, this.p, "Str", Buffer)
    OutputWide(Mask, Format)
      => ComCall(120, this.p, UInt32, Mask, "Str", Format)
    OutputVaListWide(Mask, Format, Args)
      => ComCall(121, this.p, UInt32, Mask, "Str", Format, Int8.Ptr, Args)
    ControlledOutputWide(OutputControl, Mask, Format)
      => ComCall(122, this.p, UInt32, OutputControl, UInt32, Mask, "Str", Format)
    ControlledOutputVaListWide(OutputControl, Mask, Format, Args)
      => ComCall(123, this.p, UInt32, OutputControl, UInt32, Mask, "Str", Format, Int8.Ptr, Args)
    OutputPromptWide(OutputControl, Format?)
      => ComCall(124, this.p, UInt32, OutputControl, "Str", Format?)
    OutputPromptVaListWide(OutputControl, Format?, Args)
      => ComCall(125, this.p, UInt32, OutputControl, "Str", Format?, Int8.Ptr, Args)
    GetPromptTextWide(Buffer?, TextSize?)
      => ComCall(126, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    AssembleWide(Offset, Instr, EndOffset)
      => ComCall(127, this.p, Int64, Offset, "Str", Instr, Int64.Ptr, EndOffset)
    DisassembleWide(Offset, Flags, Buffer?, DisassemblySize?, EndOffset)
      => ComCall(128, this.p, Int64, Offset, UInt32, Flags, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, DisassemblySize?, Int64.Ptr, EndOffset)
    GetProcessorTypeNamesWide(Type, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(129, this.p, UInt32, Type, PWSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PWSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetTextMacroWide(Slot, Buffer?, MacroSize?)
      => ComCall(130, this.p, UInt32, Slot, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MacroSize?)
    SetTextMacroWide(Slot, Macro)
      => ComCall(131, this.p, UInt32, Slot, "Str", Macro)
    EvaluateWide(Expression, DesiredType, Value, RemainderIndex?)
      => ComCall(132, this.p, "Str", Expression, UInt32, DesiredType, DEBUG_VALUE.Ptr, Value, UInt32.Ptr, RemainderIndex?)
    ExecuteWide(OutputControl, Command, Flags)
      => ComCall(133, this.p, UInt32, OutputControl, "Str", Command, UInt32, Flags)
    ExecuteCommandFileWide(OutputControl, CommandFile, Flags)
      => ComCall(134, this.p, UInt32, OutputControl, "Str", CommandFile, UInt32, Flags)
    GetBreakpointByIndex2(Index, Bp)
      => ComCall(135, this.p, UInt32, Index, IDebugBreakpoint2.Ptr, Bp)
    GetBreakpointById2(Id, Bp)
      => ComCall(136, this.p, UInt32, Id, IDebugBreakpoint2.Ptr, Bp)
    AddBreakpoint2(Type, DesiredId, Bp)
      => ComCall(137, this.p, UInt32, Type, UInt32, DesiredId, IDebugBreakpoint2.Ptr, Bp)
    RemoveBreakpoint2(Bp)
      => ComCall(138, this.p, IDebugBreakpoint2, Bp)
    AddExtensionWide(Path, Flags, Handle)
      => ComCall(139, this.p, "Str", Path, UInt32, Flags, Int64.Ptr, Handle)
    GetExtensionByPathWide(Path, Handle)
      => ComCall(140, this.p, "Str", Path, Int64.Ptr, Handle)
    CallExtensionWide(Handle, Function, Arguments?)
      => ComCall(141, this.p, Int64, Handle, "Str", Function, "Str", Arguments?)
    GetExtensionFunctionWide(Handle, FuncName, Function)
      => ComCall(142, this.p, Int64, Handle, "Str", FuncName, FARPROC.Ptr, Function)
    GetEventFilterTextWide(Index, Buffer?, TextSize?)
      => ComCall(143, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    GetEventFilterCommandWide(Index, Buffer?, CommandSize?)
      => ComCall(144, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetEventFilterCommandWide(Index, Command)
      => ComCall(145, this.p, UInt32, Index, "Str", Command)
    GetSpecificFilterArgumentWide(Index, Buffer?, ArgumentSize?)
      => ComCall(146, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ArgumentSize?)
    SetSpecificFilterArgumentWide(Index, Argument)
      => ComCall(147, this.p, UInt32, Index, "Str", Argument)
    GetExceptionFilterSecondCommandWide(Index, Buffer?, CommandSize?)
      => ComCall(148, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetExceptionFilterSecondCommandWide(Index, Command)
      => ComCall(149, this.p, UInt32, Index, "Str", Command)
    GetLastEventInformationWide(Type, ProcessId, ThreadId, ExtraInformation?, ExtraInformationUsed?, Description?, DescriptionUsed?)
      => ComCall(150, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?, PWSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, DescriptionUsed?)
    GetTextReplacementWide(SrcText?, Index, SrcBuffer?, SrcSize?, DstBuffer?, DstSize?)
      => ComCall(151, this.p, "Str", SrcText?, UInt32, Index, PWSTR, SrcBuffer?, UInt32, SrcBuffer?.Length ?? 0, UInt32.Ptr, SrcSize?, PWSTR, DstBuffer?, UInt32, DstBuffer?.Length ?? 0, UInt32.Ptr, DstSize?)
    SetTextReplacementWide(SrcText, DstText?)
      => ComCall(152, this.p, "Str", SrcText, "Str", DstText?)
    SetExpressionSyntaxByNameWide(AbbrevName)
      => ComCall(153, this.p, "Str", AbbrevName)
    GetExpressionSyntaxNamesWide(Index, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(154, this.p, UInt32, Index, PWSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PWSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetEventIndexDescriptionWide(Index, Which, Buffer?, BufferSize, DescSize?)
      => ComCall(155, this.p, UInt32, Index, UInt32, Which, "Str", Buffer?, UInt32, BufferSize, UInt32.Ptr, DescSize?)
    GetLogFile2(Buffer?, FileSize?, Flags)
      => ComCall(156, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, UInt32.Ptr, Flags)
    OpenLogFile2(File, Flags)
      => ComCall(157, this.p, PSTR, File, UInt32, Flags)
    GetLogFile2Wide(Buffer?, FileSize?, Flags)
      => ComCall(158, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, UInt32.Ptr, Flags)
    OpenLogFile2Wide(File, Flags)
      => ComCall(159, this.p, "Str", File, UInt32, Flags)
    GetSystemVersionValues(PlatformId, Win32Major, Win32Minor, KdMajor?, KdMinor?)
      => ComCall(160, this.p, UInt32.Ptr, PlatformId, UInt32.Ptr, Win32Major, UInt32.Ptr, Win32Minor, UInt32.Ptr, KdMajor?, UInt32.Ptr, KdMinor?)
    GetSystemVersionString(Which, Buffer?, StringSize?)
      => ComCall(161, this.p, UInt32, Which, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSystemVersionStringWide(Which, Buffer?, StringSize?)
      => ComCall(162, this.p, UInt32, Which, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetContextStackTrace(StartContext?, Frames?, FrameContexts?, FrameContextsEntrySize, FramesFilled?)
      => ComCall(163, this.p, Struct.Ptr, StartContext?, UInt32, StartContext?.Size ?? 0, DEBUG_STACK_FRAME.Ptr, Frames?, UInt32, Frames?.Length ?? 0, Struct.Ptr, FrameContexts?, UInt32, FrameContexts?.Size ?? 0, UInt32, FrameContextsEntrySize, UInt32.Ptr, FramesFilled?)
    OutputContextStackTrace(OutputControl, Frames, FrameContexts, FrameContextsEntrySize, Flags)
      => ComCall(164, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME.Ptr, Frames, UInt32, Frames.Length, Struct.Ptr, FrameContexts, UInt32, FrameContexts.Size, UInt32, FrameContextsEntrySize, UInt32, Flags)
    GetStoredEventInformation(Type, ProcessId, ThreadId, Context?, ContextUsed?, ExtraInformation?, ExtraInformationUsed?)
      => ComCall(165, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, Context?, UInt32, Context?.Size ?? 0, UInt32.Ptr, ContextUsed?, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?)
    GetManagedStatus(Flags?, WhichString, String?, StringNeeded?)
      => ComCall(166, this.p, UInt32.Ptr, Flags?, UInt32, WhichString, PSTR, String?, UInt32, String?.Length ?? 0, UInt32.Ptr, StringNeeded?)
    GetManagedStatusWide(Flags?, WhichString, String?, StringNeeded?)
      => ComCall(167, this.p, UInt32.Ptr, Flags?, UInt32, WhichString, PWSTR, String?, UInt32, String?.Length ?? 0, UInt32.Ptr, StringNeeded?)
    ResetManagedStatus(Flags)
      => ComCall(168, this.p, UInt32, Flags)
    GetStackTraceEx(FrameOffset, StackOffset, InstructionOffset, Frames, FramesFilled?)
      => ComCall(169, this.p, Int64, FrameOffset, Int64, StackOffset, Int64, InstructionOffset, DEBUG_STACK_FRAME_EX.Ptr, Frames, UInt32, Frames.Length, UInt32.Ptr, FramesFilled?)
    OutputStackTraceEx(OutputControl, Frames?, Flags)
      => ComCall(170, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME_EX.Ptr, Frames?, UInt32, Frames?.Length ?? 0, UInt32, Flags)
    GetContextStackTraceEx(StartContext?, Frames?, FrameContexts?, FrameContextsEntrySize, FramesFilled?)
      => ComCall(171, this.p, Struct.Ptr, StartContext?, UInt32, StartContext?.Size ?? 0, DEBUG_STACK_FRAME_EX.Ptr, Frames?, UInt32, Frames?.Length ?? 0, Struct.Ptr, FrameContexts?, UInt32, FrameContexts?.Size ?? 0, UInt32, FrameContextsEntrySize, UInt32.Ptr, FramesFilled?)
    OutputContextStackTraceEx(OutputControl, Frames, FrameContexts, FrameContextsEntrySize, Flags)
      => ComCall(172, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME_EX.Ptr, Frames, UInt32, Frames.Length, Struct.Ptr, FrameContexts, UInt32, FrameContexts.Size, UInt32, FrameContextsEntrySize, UInt32, Flags)
    GetBreakpointByGuid(Guid, Bp)
      => ComCall(173, this.p, GUID.Ptr, Guid, IDebugBreakpoint3.Ptr, Bp)
    GetExecutionStatusEx(Status)
      => ComCall(174, this.p, UInt32.Ptr, Status)
    GetSynchronizationStatus(SendsAttempted, SecondsSinceLastResponse)
      => ComCall(175, this.p, UInt32.Ptr, SendsAttempted, UInt32.Ptr, SecondsSinceLastResponse)
}
struct IDebugControl7 extends IUnknown {
    static IID := "{B86FB3B1-80D4-475B-AEA3-CF06539CF63A}"
    GetInterrupt()
      => ComCall(3, this.p)
    SetInterrupt(Flags)
      => ComCall(4, this.p, UInt32, Flags)
    GetInterruptTimeout(Seconds)
      => ComCall(5, this.p, UInt32.Ptr, Seconds)
    SetInterruptTimeout(Seconds)
      => ComCall(6, this.p, UInt32, Seconds)
    GetLogFile(Buffer?, FileSize?, Append)
      => ComCall(7, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, BOOL.Ptr, Append)
    OpenLogFile(File, Append)
      => ComCall(8, this.p, PSTR, File, BOOL, Append)
    CloseLogFile()
      => ComCall(9, this.p)
    GetLogMask(Mask)
      => ComCall(10, this.p, UInt32.Ptr, Mask)
    SetLogMask(Mask)
      => ComCall(11, this.p, UInt32, Mask)
    Input(Buffer, InputSize?)
      => ComCall(12, this.p, PSTR, Buffer, UInt32, Buffer.Length, UInt32.Ptr, InputSize?)
    ReturnInput(Buffer)
      => ComCall(13, this.p, PSTR, Buffer)
    Output(Mask, Format)
      => ComCall(14, this.p, UInt32, Mask, PSTR, Format)
    OutputVaList(Mask, Format, Args)
      => ComCall(15, this.p, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    ControlledOutput(OutputControl, Mask, Format)
      => ComCall(16, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format)
    ControlledOutputVaList(OutputControl, Mask, Format, Args)
      => ComCall(17, this.p, UInt32, OutputControl, UInt32, Mask, PSTR, Format, Int8.Ptr, Args)
    OutputPrompt(OutputControl, Format?)
      => ComCall(18, this.p, UInt32, OutputControl, PSTR, Format?)
    OutputPromptVaList(OutputControl, Format?, Args)
      => ComCall(19, this.p, UInt32, OutputControl, PSTR, Format?, Int8.Ptr, Args)
    GetPromptText(Buffer?, TextSize?)
      => ComCall(20, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    OutputCurrentState(OutputControl, Flags)
      => ComCall(21, this.p, UInt32, OutputControl, UInt32, Flags)
    OutputVersionInformation(OutputControl)
      => ComCall(22, this.p, UInt32, OutputControl)
    GetNotifyEventHandle(Handle)
      => ComCall(23, this.p, Int64.Ptr, Handle)
    SetNotifyEventHandle(Handle)
      => ComCall(24, this.p, Int64, Handle)
    Assemble(Offset, Instr, EndOffset)
      => ComCall(25, this.p, Int64, Offset, PSTR, Instr, Int64.Ptr, EndOffset)
    Disassemble(Offset, Flags, Buffer?, DisassemblySize?, EndOffset)
      => ComCall(26, this.p, Int64, Offset, UInt32, Flags, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, DisassemblySize?, Int64.Ptr, EndOffset)
    GetDisassembleEffectiveOffset(Offset)
      => ComCall(27, this.p, Int64.Ptr, Offset)
    OutputDisassembly(OutputControl, Offset, Flags, EndOffset)
      => ComCall(28, this.p, UInt32, OutputControl, Int64, Offset, UInt32, Flags, Int64.Ptr, EndOffset)
    OutputDisassemblyLines(OutputControl, PreviousLines, Offset, Flags, OffsetLine?, StartOffset?, EndOffset?, LineOffsets?)
      => ComCall(29, this.p, UInt32, OutputControl, UInt32, PreviousLines, UInt32, LineOffsets?.Length ?? 0, Int64, Offset, UInt32, Flags, UInt32.Ptr, OffsetLine?, Int64.Ptr, StartOffset?, Int64.Ptr, EndOffset?, Int64.Ptr, LineOffsets?)
    GetNearInstruction(Offset, Delta, NearOffset)
      => ComCall(30, this.p, Int64, Offset, Int32, Delta, Int64.Ptr, NearOffset)
    GetStackTrace(FrameOffset, StackOffset, InstructionOffset, Frames, FramesFilled?)
      => ComCall(31, this.p, Int64, FrameOffset, Int64, StackOffset, Int64, InstructionOffset, DEBUG_STACK_FRAME.Ptr, Frames, UInt32, Frames.Length, UInt32.Ptr, FramesFilled?)
    GetReturnOffset(Offset)
      => ComCall(32, this.p, Int64.Ptr, Offset)
    OutputStackTrace(OutputControl, Frames?, Flags)
      => ComCall(33, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME.Ptr, Frames?, UInt32, Frames?.Length ?? 0, UInt32, Flags)
    GetDebuggeeType(Class, Qualifier)
      => ComCall(34, this.p, UInt32.Ptr, Class, UInt32.Ptr, Qualifier)
    GetActualProcessorType(Type)
      => ComCall(35, this.p, UInt32.Ptr, Type)
    GetExecutingProcessorType(Type)
      => ComCall(36, this.p, UInt32.Ptr, Type)
    GetNumberPossibleExecutingProcessorTypes(Number)
      => ComCall(37, this.p, UInt32.Ptr, Number)
    GetPossibleExecutingProcessorTypes(Start, Types)
      => ComCall(38, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetNumberProcessors(Number)
      => ComCall(39, this.p, UInt32.Ptr, Number)
    GetSystemVersion(PlatformId, Major, Minor, ServicePackString?, ServicePackStringUsed?, ServicePackNumber, BuildString?, BuildStringUsed?)
      => ComCall(40, this.p, UInt32.Ptr, PlatformId, UInt32.Ptr, Major, UInt32.Ptr, Minor, PSTR, ServicePackString?, UInt32, ServicePackString?.Length ?? 0, UInt32.Ptr, ServicePackStringUsed?, UInt32.Ptr, ServicePackNumber, PSTR, BuildString?, UInt32, BuildString?.Length ?? 0, UInt32.Ptr, BuildStringUsed?)
    GetPageSize(Size)
      => ComCall(41, this.p, UInt32.Ptr, Size)
    IsPointer64Bit()
      => ComCall(42, this.p)
    ReadBugCheckData(Code, Arg1, Arg2, Arg3, Arg4)
      => ComCall(43, this.p, UInt32.Ptr, Code, Int64.Ptr, Arg1, Int64.Ptr, Arg2, Int64.Ptr, Arg3, Int64.Ptr, Arg4)
    GetNumberSupportedProcessorTypes(Number)
      => ComCall(44, this.p, UInt32.Ptr, Number)
    GetSupportedProcessorTypes(Start, Types)
      => ComCall(45, this.p, UInt32, Start, UInt32, Types.Length, UInt32.Ptr, Types)
    GetProcessorTypeNames(Type, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(46, this.p, UInt32, Type, PSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetEffectiveProcessorType(Type)
      => ComCall(47, this.p, UInt32.Ptr, Type)
    SetEffectiveProcessorType(Type)
      => ComCall(48, this.p, UInt32, Type)
    GetExecutionStatus(Status)
      => ComCall(49, this.p, UInt32.Ptr, Status)
    SetExecutionStatus(Status)
      => ComCall(50, this.p, UInt32, Status)
    GetCodeLevel(Level)
      => ComCall(51, this.p, UInt32.Ptr, Level)
    SetCodeLevel(Level)
      => ComCall(52, this.p, UInt32, Level)
    GetEngineOptions(Options)
      => ComCall(53, this.p, UInt32.Ptr, Options)
    AddEngineOptions(Options)
      => ComCall(54, this.p, UInt32, Options)
    RemoveEngineOptions(Options)
      => ComCall(55, this.p, UInt32, Options)
    SetEngineOptions(Options)
      => ComCall(56, this.p, UInt32, Options)
    GetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(57, this.p, UInt32.Ptr, OutputLevel, UInt32.Ptr, BreakLevel)
    SetSystemErrorControl(OutputLevel, BreakLevel)
      => ComCall(58, this.p, UInt32, OutputLevel, UInt32, BreakLevel)
    GetTextMacro(Slot, Buffer?, MacroSize?)
      => ComCall(59, this.p, UInt32, Slot, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MacroSize?)
    SetTextMacro(Slot, Macro)
      => ComCall(60, this.p, UInt32, Slot, PSTR, Macro)
    GetRadix(Radix)
      => ComCall(61, this.p, UInt32.Ptr, Radix)
    SetRadix(Radix)
      => ComCall(62, this.p, UInt32, Radix)
    Evaluate(Expression, DesiredType, Value, RemainderIndex?)
      => ComCall(63, this.p, PSTR, Expression, UInt32, DesiredType, DEBUG_VALUE.Ptr, Value, UInt32.Ptr, RemainderIndex?)
    CoerceValue(In1, OutType, Out)
      => ComCall(64, this.p, DEBUG_VALUE.Ptr, In1, UInt32, OutType, DEBUG_VALUE.Ptr, Out)
    CoerceValues(In1, OutTypes, Out)
      => ComCall(65, this.p, UInt32, Out.Length, DEBUG_VALUE.Ptr, In1, UInt32.Ptr, OutTypes, DEBUG_VALUE.Ptr, Out)
    Execute(OutputControl, Command, Flags)
      => ComCall(66, this.p, UInt32, OutputControl, PSTR, Command, UInt32, Flags)
    ExecuteCommandFile(OutputControl, CommandFile, Flags)
      => ComCall(67, this.p, UInt32, OutputControl, PSTR, CommandFile, UInt32, Flags)
    GetNumberBreakpoints(Number)
      => ComCall(68, this.p, UInt32.Ptr, Number)
    GetBreakpointByIndex(Index, Bp)
      => ComCall(69, this.p, UInt32, Index, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointById(Id, Bp)
      => ComCall(70, this.p, UInt32, Id, IDebugBreakpoint.Ptr, Bp)
    GetBreakpointParameters(Ids?, Start, Params)
      => ComCall(71, this.p, UInt32, Params.Length, UInt32.Ptr, Ids?, UInt32, Start, DEBUG_BREAKPOINT_PARAMETERS.Ptr, Params)
    AddBreakpoint(Type, DesiredId, Bp)
      => ComCall(72, this.p, UInt32, Type, UInt32, DesiredId, IDebugBreakpoint.Ptr, Bp)
    RemoveBreakpoint(Bp)
      => ComCall(73, this.p, IDebugBreakpoint, Bp)
    AddExtension(Path, Flags, Handle)
      => ComCall(74, this.p, PSTR, Path, UInt32, Flags, Int64.Ptr, Handle)
    RemoveExtension(Handle)
      => ComCall(75, this.p, Int64, Handle)
    GetExtensionByPath(Path, Handle)
      => ComCall(76, this.p, PSTR, Path, Int64.Ptr, Handle)
    CallExtension(Handle, Function, Arguments?)
      => ComCall(77, this.p, Int64, Handle, PSTR, Function, PSTR, Arguments?)
    GetExtensionFunction(Handle, FuncName, Function)
      => ComCall(78, this.p, Int64, Handle, PSTR, FuncName, FARPROC.Ptr, Function)
    GetWindbgExtensionApis32(Api)
      => ComCall(79, this.p, WINDBG_EXTENSION_APIS32.Ptr, Api)
    GetWindbgExtensionApis64(Api)
      => ComCall(80, this.p, WINDBG_EXTENSION_APIS64.Ptr, Api)
    GetNumberEventFilters(SpecificEvents, SpecificExceptions, ArbitraryExceptions)
      => ComCall(81, this.p, UInt32.Ptr, SpecificEvents, UInt32.Ptr, SpecificExceptions, UInt32.Ptr, ArbitraryExceptions)
    GetEventFilterText(Index, Buffer?, TextSize?)
      => ComCall(82, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    GetEventFilterCommand(Index, Buffer?, CommandSize?)
      => ComCall(83, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetEventFilterCommand(Index, Command)
      => ComCall(84, this.p, UInt32, Index, PSTR, Command)
    GetSpecificFilterParameters(Start, Params)
      => ComCall(85, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    SetSpecificFilterParameters(Start, Params)
      => ComCall(86, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SPECIFIC_FILTER_PARAMETERS.Ptr, Params)
    GetSpecificFilterArgument(Index, Buffer?, ArgumentSize?)
      => ComCall(87, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ArgumentSize?)
    SetSpecificFilterArgument(Index, Argument)
      => ComCall(88, this.p, UInt32, Index, PSTR, Argument)
    GetExceptionFilterParameters(Codes?, Start, Params)
      => ComCall(89, this.p, UInt32, Params.Length, UInt32.Ptr, Codes?, UInt32, Start, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    SetExceptionFilterParameters(Params)
      => ComCall(90, this.p, UInt32, Params.Length, DEBUG_EXCEPTION_FILTER_PARAMETERS.Ptr, Params)
    GetExceptionFilterSecondCommand(Index, Buffer?, CommandSize?)
      => ComCall(91, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetExceptionFilterSecondCommand(Index, Command)
      => ComCall(92, this.p, UInt32, Index, PSTR, Command)
    WaitForEvent(Flags, Timeout)
      => ComCall(93, this.p, UInt32, Flags, UInt32, Timeout)
    GetLastEventInformation(Type, ProcessId, ThreadId, ExtraInformation?, ExtraInformationUsed?, Description?, DescriptionUsed?)
      => ComCall(94, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?, PSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, DescriptionUsed?)
    GetCurrentTimeDate(TimeDate)
      => ComCall(95, this.p, UInt32.Ptr, TimeDate)
    GetCurrentSystemUpTime(UpTime)
      => ComCall(96, this.p, UInt32.Ptr, UpTime)
    GetDumpFormatFlags(FormatFlags)
      => ComCall(97, this.p, UInt32.Ptr, FormatFlags)
    GetNumberTextReplacements(NumRepl)
      => ComCall(98, this.p, UInt32.Ptr, NumRepl)
    GetTextReplacement(SrcText?, Index, SrcBuffer?, SrcSize?, DstBuffer?, DstSize?)
      => ComCall(99, this.p, PSTR, SrcText?, UInt32, Index, PSTR, SrcBuffer?, UInt32, SrcBuffer?.Length ?? 0, UInt32.Ptr, SrcSize?, PSTR, DstBuffer?, UInt32, DstBuffer?.Length ?? 0, UInt32.Ptr, DstSize?)
    SetTextReplacement(SrcText, DstText?)
      => ComCall(100, this.p, PSTR, SrcText, PSTR, DstText?)
    RemoveTextReplacements()
      => ComCall(101, this.p)
    OutputTextReplacements(OutputControl, Flags)
      => ComCall(102, this.p, UInt32, OutputControl, UInt32, Flags)
    GetAssemblyOptions(Options)
      => ComCall(103, this.p, UInt32.Ptr, Options)
    AddAssemblyOptions(Options)
      => ComCall(104, this.p, UInt32, Options)
    RemoveAssemblyOptions(Options)
      => ComCall(105, this.p, UInt32, Options)
    SetAssemblyOptions(Options)
      => ComCall(106, this.p, UInt32, Options)
    GetExpressionSyntax(Flags)
      => ComCall(107, this.p, UInt32.Ptr, Flags)
    SetExpressionSyntax(Flags)
      => ComCall(108, this.p, UInt32, Flags)
    SetExpressionSyntaxByName(AbbrevName)
      => ComCall(109, this.p, PSTR, AbbrevName)
    GetNumberExpressionSyntaxes(Number)
      => ComCall(110, this.p, UInt32.Ptr, Number)
    GetExpressionSyntaxNames(Index, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(111, this.p, UInt32, Index, PSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetNumberEvents(Events)
      => ComCall(112, this.p, UInt32.Ptr, Events)
    GetEventIndexDescription(Index, Which, Buffer?, BufferSize, DescSize?)
      => ComCall(113, this.p, UInt32, Index, UInt32, Which, PSTR, Buffer?, UInt32, BufferSize, UInt32.Ptr, DescSize?)
    GetCurrentEventIndex(Index)
      => ComCall(114, this.p, UInt32.Ptr, Index)
    SetNextEventIndex(Relation, Value, NextIndex)
      => ComCall(115, this.p, UInt32, Relation, UInt32, Value, UInt32.Ptr, NextIndex)
    GetLogFileWide(Buffer?, FileSize?, Append)
      => ComCall(116, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, BOOL.Ptr, Append)
    OpenLogFileWide(File, Append)
      => ComCall(117, this.p, "Str", File, BOOL, Append)
    InputWide(Buffer, InputSize?)
      => ComCall(118, this.p, PWSTR, Buffer, UInt32, Buffer.Length, UInt32.Ptr, InputSize?)
    ReturnInputWide(Buffer)
      => ComCall(119, this.p, "Str", Buffer)
    OutputWide(Mask, Format)
      => ComCall(120, this.p, UInt32, Mask, "Str", Format)
    OutputVaListWide(Mask, Format, Args)
      => ComCall(121, this.p, UInt32, Mask, "Str", Format, Int8.Ptr, Args)
    ControlledOutputWide(OutputControl, Mask, Format)
      => ComCall(122, this.p, UInt32, OutputControl, UInt32, Mask, "Str", Format)
    ControlledOutputVaListWide(OutputControl, Mask, Format, Args)
      => ComCall(123, this.p, UInt32, OutputControl, UInt32, Mask, "Str", Format, Int8.Ptr, Args)
    OutputPromptWide(OutputControl, Format?)
      => ComCall(124, this.p, UInt32, OutputControl, "Str", Format?)
    OutputPromptVaListWide(OutputControl, Format?, Args)
      => ComCall(125, this.p, UInt32, OutputControl, "Str", Format?, Int8.Ptr, Args)
    GetPromptTextWide(Buffer?, TextSize?)
      => ComCall(126, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    AssembleWide(Offset, Instr, EndOffset)
      => ComCall(127, this.p, Int64, Offset, "Str", Instr, Int64.Ptr, EndOffset)
    DisassembleWide(Offset, Flags, Buffer?, DisassemblySize?, EndOffset)
      => ComCall(128, this.p, Int64, Offset, UInt32, Flags, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, DisassemblySize?, Int64.Ptr, EndOffset)
    GetProcessorTypeNamesWide(Type, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(129, this.p, UInt32, Type, PWSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PWSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetTextMacroWide(Slot, Buffer?, MacroSize?)
      => ComCall(130, this.p, UInt32, Slot, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MacroSize?)
    SetTextMacroWide(Slot, Macro)
      => ComCall(131, this.p, UInt32, Slot, "Str", Macro)
    EvaluateWide(Expression, DesiredType, Value, RemainderIndex?)
      => ComCall(132, this.p, "Str", Expression, UInt32, DesiredType, DEBUG_VALUE.Ptr, Value, UInt32.Ptr, RemainderIndex?)
    ExecuteWide(OutputControl, Command, Flags)
      => ComCall(133, this.p, UInt32, OutputControl, "Str", Command, UInt32, Flags)
    ExecuteCommandFileWide(OutputControl, CommandFile, Flags)
      => ComCall(134, this.p, UInt32, OutputControl, "Str", CommandFile, UInt32, Flags)
    GetBreakpointByIndex2(Index, Bp)
      => ComCall(135, this.p, UInt32, Index, IDebugBreakpoint2.Ptr, Bp)
    GetBreakpointById2(Id, Bp)
      => ComCall(136, this.p, UInt32, Id, IDebugBreakpoint2.Ptr, Bp)
    AddBreakpoint2(Type, DesiredId, Bp)
      => ComCall(137, this.p, UInt32, Type, UInt32, DesiredId, IDebugBreakpoint2.Ptr, Bp)
    RemoveBreakpoint2(Bp)
      => ComCall(138, this.p, IDebugBreakpoint2, Bp)
    AddExtensionWide(Path, Flags, Handle)
      => ComCall(139, this.p, "Str", Path, UInt32, Flags, Int64.Ptr, Handle)
    GetExtensionByPathWide(Path, Handle)
      => ComCall(140, this.p, "Str", Path, Int64.Ptr, Handle)
    CallExtensionWide(Handle, Function, Arguments?)
      => ComCall(141, this.p, Int64, Handle, "Str", Function, "Str", Arguments?)
    GetExtensionFunctionWide(Handle, FuncName, Function)
      => ComCall(142, this.p, Int64, Handle, "Str", FuncName, FARPROC.Ptr, Function)
    GetEventFilterTextWide(Index, Buffer?, TextSize?)
      => ComCall(143, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, TextSize?)
    GetEventFilterCommandWide(Index, Buffer?, CommandSize?)
      => ComCall(144, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetEventFilterCommandWide(Index, Command)
      => ComCall(145, this.p, UInt32, Index, "Str", Command)
    GetSpecificFilterArgumentWide(Index, Buffer?, ArgumentSize?)
      => ComCall(146, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ArgumentSize?)
    SetSpecificFilterArgumentWide(Index, Argument)
      => ComCall(147, this.p, UInt32, Index, "Str", Argument)
    GetExceptionFilterSecondCommandWide(Index, Buffer?, CommandSize?)
      => ComCall(148, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, CommandSize?)
    SetExceptionFilterSecondCommandWide(Index, Command)
      => ComCall(149, this.p, UInt32, Index, "Str", Command)
    GetLastEventInformationWide(Type, ProcessId, ThreadId, ExtraInformation?, ExtraInformationUsed?, Description?, DescriptionUsed?)
      => ComCall(150, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?, PWSTR, Description?, UInt32, Description?.Length ?? 0, UInt32.Ptr, DescriptionUsed?)
    GetTextReplacementWide(SrcText?, Index, SrcBuffer?, SrcSize?, DstBuffer?, DstSize?)
      => ComCall(151, this.p, "Str", SrcText?, UInt32, Index, PWSTR, SrcBuffer?, UInt32, SrcBuffer?.Length ?? 0, UInt32.Ptr, SrcSize?, PWSTR, DstBuffer?, UInt32, DstBuffer?.Length ?? 0, UInt32.Ptr, DstSize?)
    SetTextReplacementWide(SrcText, DstText?)
      => ComCall(152, this.p, "Str", SrcText, "Str", DstText?)
    SetExpressionSyntaxByNameWide(AbbrevName)
      => ComCall(153, this.p, "Str", AbbrevName)
    GetExpressionSyntaxNamesWide(Index, FullNameBuffer?, FullNameSize?, AbbrevNameBuffer?, AbbrevNameSize?)
      => ComCall(154, this.p, UInt32, Index, PWSTR, FullNameBuffer?, UInt32, FullNameBuffer?.Length ?? 0, UInt32.Ptr, FullNameSize?, PWSTR, AbbrevNameBuffer?, UInt32, AbbrevNameBuffer?.Length ?? 0, UInt32.Ptr, AbbrevNameSize?)
    GetEventIndexDescriptionWide(Index, Which, Buffer?, BufferSize, DescSize?)
      => ComCall(155, this.p, UInt32, Index, UInt32, Which, "Str", Buffer?, UInt32, BufferSize, UInt32.Ptr, DescSize?)
    GetLogFile2(Buffer?, FileSize?, Flags)
      => ComCall(156, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, UInt32.Ptr, Flags)
    OpenLogFile2(File, Flags)
      => ComCall(157, this.p, PSTR, File, UInt32, Flags)
    GetLogFile2Wide(Buffer?, FileSize?, Flags)
      => ComCall(158, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileSize?, UInt32.Ptr, Flags)
    OpenLogFile2Wide(File, Flags)
      => ComCall(159, this.p, "Str", File, UInt32, Flags)
    GetSystemVersionValues(PlatformId, Win32Major, Win32Minor, KdMajor?, KdMinor?)
      => ComCall(160, this.p, UInt32.Ptr, PlatformId, UInt32.Ptr, Win32Major, UInt32.Ptr, Win32Minor, UInt32.Ptr, KdMajor?, UInt32.Ptr, KdMinor?)
    GetSystemVersionString(Which, Buffer?, StringSize?)
      => ComCall(161, this.p, UInt32, Which, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSystemVersionStringWide(Which, Buffer?, StringSize?)
      => ComCall(162, this.p, UInt32, Which, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetContextStackTrace(StartContext?, Frames?, FrameContexts?, FrameContextsEntrySize, FramesFilled?)
      => ComCall(163, this.p, Struct.Ptr, StartContext?, UInt32, StartContext?.Size ?? 0, DEBUG_STACK_FRAME.Ptr, Frames?, UInt32, Frames?.Length ?? 0, Struct.Ptr, FrameContexts?, UInt32, FrameContexts?.Size ?? 0, UInt32, FrameContextsEntrySize, UInt32.Ptr, FramesFilled?)
    OutputContextStackTrace(OutputControl, Frames, FrameContexts, FrameContextsEntrySize, Flags)
      => ComCall(164, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME.Ptr, Frames, UInt32, Frames.Length, Struct.Ptr, FrameContexts, UInt32, FrameContexts.Size, UInt32, FrameContextsEntrySize, UInt32, Flags)
    GetStoredEventInformation(Type, ProcessId, ThreadId, Context?, ContextUsed?, ExtraInformation?, ExtraInformationUsed?)
      => ComCall(165, this.p, UInt32.Ptr, Type, UInt32.Ptr, ProcessId, UInt32.Ptr, ThreadId, Struct.Ptr, Context?, UInt32, Context?.Size ?? 0, UInt32.Ptr, ContextUsed?, Struct.Ptr, ExtraInformation?, UInt32, ExtraInformation?.Size ?? 0, UInt32.Ptr, ExtraInformationUsed?)
    GetManagedStatus(Flags?, WhichString, String?, StringNeeded?)
      => ComCall(166, this.p, UInt32.Ptr, Flags?, UInt32, WhichString, PSTR, String?, UInt32, String?.Length ?? 0, UInt32.Ptr, StringNeeded?)
    GetManagedStatusWide(Flags?, WhichString, String?, StringNeeded?)
      => ComCall(167, this.p, UInt32.Ptr, Flags?, UInt32, WhichString, PWSTR, String?, UInt32, String?.Length ?? 0, UInt32.Ptr, StringNeeded?)
    ResetManagedStatus(Flags)
      => ComCall(168, this.p, UInt32, Flags)
    GetStackTraceEx(FrameOffset, StackOffset, InstructionOffset, Frames, FramesFilled?)
      => ComCall(169, this.p, Int64, FrameOffset, Int64, StackOffset, Int64, InstructionOffset, DEBUG_STACK_FRAME_EX.Ptr, Frames, UInt32, Frames.Length, UInt32.Ptr, FramesFilled?)
    OutputStackTraceEx(OutputControl, Frames?, Flags)
      => ComCall(170, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME_EX.Ptr, Frames?, UInt32, Frames?.Length ?? 0, UInt32, Flags)
    GetContextStackTraceEx(StartContext?, Frames?, FrameContexts?, FrameContextsEntrySize, FramesFilled?)
      => ComCall(171, this.p, Struct.Ptr, StartContext?, UInt32, StartContext?.Size ?? 0, DEBUG_STACK_FRAME_EX.Ptr, Frames?, UInt32, Frames?.Length ?? 0, Struct.Ptr, FrameContexts?, UInt32, FrameContexts?.Size ?? 0, UInt32, FrameContextsEntrySize, UInt32.Ptr, FramesFilled?)
    OutputContextStackTraceEx(OutputControl, Frames, FrameContexts, FrameContextsEntrySize, Flags)
      => ComCall(172, this.p, UInt32, OutputControl, DEBUG_STACK_FRAME_EX.Ptr, Frames, UInt32, Frames.Length, Struct.Ptr, FrameContexts, UInt32, FrameContexts.Size, UInt32, FrameContextsEntrySize, UInt32, Flags)
    GetBreakpointByGuid(Guid, Bp)
      => ComCall(173, this.p, GUID.Ptr, Guid, IDebugBreakpoint3.Ptr, Bp)
    GetExecutionStatusEx(Status)
      => ComCall(174, this.p, UInt32.Ptr, Status)
    GetSynchronizationStatus(SendsAttempted, SecondsSinceLastResponse)
      => ComCall(175, this.p, UInt32.Ptr, SendsAttempted, UInt32.Ptr, SecondsSinceLastResponse)
    GetDebuggeeType2(Flags, Class, Qualifier)
      => ComCall(176, this.p, UInt32, Flags, UInt32.Ptr, Class, UInt32.Ptr, Qualifier)
}
struct DEBUG_PROCESSOR_IDENTIFICATION_ALPHA {
    Type : UInt32
    Revision : UInt32
}
struct DEBUG_PROCESSOR_IDENTIFICATION_AMD64 {
    Family : UInt32
    Model : UInt32
    Stepping : UInt32
    VendorString : CHAR[16]
}
struct DEBUG_PROCESSOR_IDENTIFICATION_IA64 {
    Model : UInt32
    Revision : UInt32
    Family : UInt32
    ArchRev : UInt32
    VendorString : CHAR[16]
}
struct DEBUG_PROCESSOR_IDENTIFICATION_X86 {
    Family : UInt32
    Model : UInt32
    Stepping : UInt32
    VendorString : CHAR[16]
}
struct DEBUG_PROCESSOR_IDENTIFICATION_ARM {
    Model : UInt32
    Revision : UInt32
    VendorString : CHAR[16]
}
struct DEBUG_PROCESSOR_IDENTIFICATION_ARM64 {
    Model : UInt32
    Revision : UInt32
    VendorString : CHAR[16]
}
struct DEBUG_PROCESSOR_IDENTIFICATION_ALL {
    union {
        Alpha : DEBUG_PROCESSOR_IDENTIFICATION_ALPHA
        Amd64 : DEBUG_PROCESSOR_IDENTIFICATION_AMD64
        Ia64 : DEBUG_PROCESSOR_IDENTIFICATION_IA64
        X86 : DEBUG_PROCESSOR_IDENTIFICATION_X86
        Arm : DEBUG_PROCESSOR_IDENTIFICATION_ARM
        Arm64 : DEBUG_PROCESSOR_IDENTIFICATION_ARM64
    }
}
struct IDebugDataSpaces extends IUnknown {
    static IID := "{88F7DFAB-3EA7-4C3A-AEFB-C4E8106173AA}"
    ReadVirtual(Offset, Buffer, BytesRead?)
      => ComCall(3, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteVirtual(Offset, Buffer, BytesWritten?)
      => ComCall(4, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    SearchVirtual(Offset, Length, Pattern, PatternGranularity, MatchOffset)
      => ComCall(5, this.p, Int64, Offset, Int64, Length, Struct.Ptr, Pattern, UInt32, Pattern.Size, UInt32, PatternGranularity, Int64.Ptr, MatchOffset)
    ReadVirtualUncached(Offset, Buffer, BytesRead?)
      => ComCall(6, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteVirtualUncached(Offset, Buffer, BytesWritten?)
      => ComCall(7, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadPointersVirtual(Offset, Ptrs)
      => ComCall(8, this.p, UInt32, Ptrs.Length, Int64, Offset, Int64.Ptr, Ptrs)
    WritePointersVirtual(Offset, Ptrs)
      => ComCall(9, this.p, UInt32, Ptrs.Length, Int64, Offset, Int64.Ptr, Ptrs)
    ReadPhysical(Offset, Buffer, BytesRead?)
      => ComCall(10, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WritePhysical(Offset, Buffer, BytesWritten?)
      => ComCall(11, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadControl(Processor, Offset, Buffer, BytesRead?)
      => ComCall(12, this.p, UInt32, Processor, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteControl(Processor, Offset, Buffer, BytesWritten?)
      => ComCall(13, this.p, UInt32, Processor, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadIo(InterfaceType, BusNumber, AddressSpace, Offset, Buffer, BytesRead?)
      => ComCall(14, this.p, UInt32, InterfaceType, UInt32, BusNumber, UInt32, AddressSpace, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteIo(InterfaceType, BusNumber, AddressSpace, Offset, Buffer, BytesWritten?)
      => ComCall(15, this.p, UInt32, InterfaceType, UInt32, BusNumber, UInt32, AddressSpace, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadMsr(Msr, Value)
      => ComCall(16, this.p, UInt32, Msr, Int64.Ptr, Value)
    WriteMsr(Msr, Value)
      => ComCall(17, this.p, UInt32, Msr, Int64, Value)
    ReadBusData(BusDataType, BusNumber, SlotNumber, Offset, Buffer, BytesRead?)
      => ComCall(18, this.p, UInt32, BusDataType, UInt32, BusNumber, UInt32, SlotNumber, UInt32, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteBusData(BusDataType, BusNumber, SlotNumber, Offset, Buffer, BytesWritten?)
      => ComCall(19, this.p, UInt32, BusDataType, UInt32, BusNumber, UInt32, SlotNumber, UInt32, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    CheckLowMemory()
      => ComCall(20, this.p)
    ReadDebuggerData(Index, Buffer, DataSize?)
      => ComCall(21, this.p, UInt32, Index, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, DataSize?)
    ReadProcessorSystemData(Processor, Index, Buffer, DataSize?)
      => ComCall(22, this.p, UInt32, Processor, UInt32, Index, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, DataSize?)
}
struct DEBUG_HANDLE_DATA_BASIC {
    TypeNameSize : UInt32
    ObjectNameSize : UInt32
    Attributes : UInt32
    GrantedAccess : UInt32
    HandleCount : UInt32
    PointerCount : UInt32
}
struct IDebugDataSpaces2 extends IUnknown {
    static IID := "{7A5E852F-96E9-468F-AC1B-0B3ADDC4A049}"
    ReadVirtual(Offset, Buffer, BytesRead?)
      => ComCall(3, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteVirtual(Offset, Buffer, BytesWritten?)
      => ComCall(4, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    SearchVirtual(Offset, Length, Pattern, PatternGranularity, MatchOffset)
      => ComCall(5, this.p, Int64, Offset, Int64, Length, Struct.Ptr, Pattern, UInt32, Pattern.Size, UInt32, PatternGranularity, Int64.Ptr, MatchOffset)
    ReadVirtualUncached(Offset, Buffer, BytesRead?)
      => ComCall(6, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteVirtualUncached(Offset, Buffer, BytesWritten?)
      => ComCall(7, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadPointersVirtual(Offset, Ptrs)
      => ComCall(8, this.p, UInt32, Ptrs.Length, Int64, Offset, Int64.Ptr, Ptrs)
    WritePointersVirtual(Offset, Ptrs)
      => ComCall(9, this.p, UInt32, Ptrs.Length, Int64, Offset, Int64.Ptr, Ptrs)
    ReadPhysical(Offset, Buffer, BytesRead?)
      => ComCall(10, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WritePhysical(Offset, Buffer, BytesWritten?)
      => ComCall(11, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadControl(Processor, Offset, Buffer, BytesRead?)
      => ComCall(12, this.p, UInt32, Processor, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteControl(Processor, Offset, Buffer, BytesWritten?)
      => ComCall(13, this.p, UInt32, Processor, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadIo(InterfaceType, BusNumber, AddressSpace, Offset, Buffer, BytesRead?)
      => ComCall(14, this.p, UInt32, InterfaceType, UInt32, BusNumber, UInt32, AddressSpace, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteIo(InterfaceType, BusNumber, AddressSpace, Offset, Buffer, BytesWritten?)
      => ComCall(15, this.p, UInt32, InterfaceType, UInt32, BusNumber, UInt32, AddressSpace, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadMsr(Msr, Value)
      => ComCall(16, this.p, UInt32, Msr, Int64.Ptr, Value)
    WriteMsr(Msr, Value)
      => ComCall(17, this.p, UInt32, Msr, Int64, Value)
    ReadBusData(BusDataType, BusNumber, SlotNumber, Offset, Buffer, BytesRead?)
      => ComCall(18, this.p, UInt32, BusDataType, UInt32, BusNumber, UInt32, SlotNumber, UInt32, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteBusData(BusDataType, BusNumber, SlotNumber, Offset, Buffer, BytesWritten?)
      => ComCall(19, this.p, UInt32, BusDataType, UInt32, BusNumber, UInt32, SlotNumber, UInt32, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    CheckLowMemory()
      => ComCall(20, this.p)
    ReadDebuggerData(Index, Buffer, DataSize?)
      => ComCall(21, this.p, UInt32, Index, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, DataSize?)
    ReadProcessorSystemData(Processor, Index, Buffer, DataSize?)
      => ComCall(22, this.p, UInt32, Processor, UInt32, Index, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, DataSize?)
    VirtualToPhysical(Virtual, Physical)
      => ComCall(23, this.p, Int64, Virtual, Int64.Ptr, Physical)
    GetVirtualTranslationPhysicalOffsets(Virtual, Offsets?, Levels?)
      => ComCall(24, this.p, Int64, Virtual, Int64.Ptr, Offsets?, UInt32, Offsets?.Length ?? 0, UInt32.Ptr, Levels?)
    ReadHandleData(Handle, DataType, Buffer?, DataSize?)
      => ComCall(25, this.p, Int64, Handle, UInt32, DataType, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, DataSize?)
    FillVirtual(Start, Size, Pattern, Filled?)
      => ComCall(26, this.p, Int64, Start, UInt32, Size, Struct.Ptr, Pattern, UInt32, Pattern.Size, UInt32.Ptr, Filled?)
    FillPhysical(Start, Size, Pattern, Filled?)
      => ComCall(27, this.p, Int64, Start, UInt32, Size, Struct.Ptr, Pattern, UInt32, Pattern.Size, UInt32.Ptr, Filled?)
    QueryVirtual(Offset, Info)
      => ComCall(28, this.p, Int64, Offset, MEMORY_BASIC_INFORMATION64.Ptr, Info)
}
struct IDebugDataSpaces3 extends IUnknown {
    static IID := "{23F79D6C-8AAF-4F7C-A607-9995F5407E63}"
    ReadVirtual(Offset, Buffer, BytesRead?)
      => ComCall(3, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteVirtual(Offset, Buffer, BytesWritten?)
      => ComCall(4, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    SearchVirtual(Offset, Length, Pattern, PatternGranularity, MatchOffset)
      => ComCall(5, this.p, Int64, Offset, Int64, Length, Struct.Ptr, Pattern, UInt32, Pattern.Size, UInt32, PatternGranularity, Int64.Ptr, MatchOffset)
    ReadVirtualUncached(Offset, Buffer, BytesRead?)
      => ComCall(6, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteVirtualUncached(Offset, Buffer, BytesWritten?)
      => ComCall(7, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadPointersVirtual(Offset, Ptrs)
      => ComCall(8, this.p, UInt32, Ptrs.Length, Int64, Offset, Int64.Ptr, Ptrs)
    WritePointersVirtual(Offset, Ptrs)
      => ComCall(9, this.p, UInt32, Ptrs.Length, Int64, Offset, Int64.Ptr, Ptrs)
    ReadPhysical(Offset, Buffer, BytesRead?)
      => ComCall(10, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WritePhysical(Offset, Buffer, BytesWritten?)
      => ComCall(11, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadControl(Processor, Offset, Buffer, BytesRead?)
      => ComCall(12, this.p, UInt32, Processor, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteControl(Processor, Offset, Buffer, BytesWritten?)
      => ComCall(13, this.p, UInt32, Processor, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadIo(InterfaceType, BusNumber, AddressSpace, Offset, Buffer, BytesRead?)
      => ComCall(14, this.p, UInt32, InterfaceType, UInt32, BusNumber, UInt32, AddressSpace, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteIo(InterfaceType, BusNumber, AddressSpace, Offset, Buffer, BytesWritten?)
      => ComCall(15, this.p, UInt32, InterfaceType, UInt32, BusNumber, UInt32, AddressSpace, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadMsr(Msr, Value)
      => ComCall(16, this.p, UInt32, Msr, Int64.Ptr, Value)
    WriteMsr(Msr, Value)
      => ComCall(17, this.p, UInt32, Msr, Int64, Value)
    ReadBusData(BusDataType, BusNumber, SlotNumber, Offset, Buffer, BytesRead?)
      => ComCall(18, this.p, UInt32, BusDataType, UInt32, BusNumber, UInt32, SlotNumber, UInt32, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteBusData(BusDataType, BusNumber, SlotNumber, Offset, Buffer, BytesWritten?)
      => ComCall(19, this.p, UInt32, BusDataType, UInt32, BusNumber, UInt32, SlotNumber, UInt32, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    CheckLowMemory()
      => ComCall(20, this.p)
    ReadDebuggerData(Index, Buffer, DataSize?)
      => ComCall(21, this.p, UInt32, Index, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, DataSize?)
    ReadProcessorSystemData(Processor, Index, Buffer, DataSize?)
      => ComCall(22, this.p, UInt32, Processor, UInt32, Index, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, DataSize?)
    VirtualToPhysical(Virtual, Physical)
      => ComCall(23, this.p, Int64, Virtual, Int64.Ptr, Physical)
    GetVirtualTranslationPhysicalOffsets(Virtual, Offsets?, Levels?)
      => ComCall(24, this.p, Int64, Virtual, Int64.Ptr, Offsets?, UInt32, Offsets?.Length ?? 0, UInt32.Ptr, Levels?)
    ReadHandleData(Handle, DataType, Buffer?, DataSize?)
      => ComCall(25, this.p, Int64, Handle, UInt32, DataType, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, DataSize?)
    FillVirtual(Start, Size, Pattern, Filled?)
      => ComCall(26, this.p, Int64, Start, UInt32, Size, Struct.Ptr, Pattern, UInt32, Pattern.Size, UInt32.Ptr, Filled?)
    FillPhysical(Start, Size, Pattern, Filled?)
      => ComCall(27, this.p, Int64, Start, UInt32, Size, Struct.Ptr, Pattern, UInt32, Pattern.Size, UInt32.Ptr, Filled?)
    QueryVirtual(Offset, Info)
      => ComCall(28, this.p, Int64, Offset, MEMORY_BASIC_INFORMATION64.Ptr, Info)
    ReadImageNtHeaders(ImageBase, Headers)
      => ComCall(29, this.p, Int64, ImageBase, IMAGE_NT_HEADERS64.Ptr, Headers)
    ReadTagged(Tag, Offset, Buffer?, TotalSize?)
      => ComCall(30, this.p, GUID.Ptr, Tag, UInt32, Offset, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, TotalSize?)
    StartEnumTagged(Handle)
      => ComCall(31, this.p, Int64.Ptr, Handle)
    GetNextTagged(Handle, Tag, Size)
      => ComCall(32, this.p, Int64, Handle, GUID.Ptr, Tag, UInt32.Ptr, Size)
    EndEnumTagged(Handle)
      => ComCall(33, this.p, Int64, Handle)
}
struct IDebugDataSpaces4 extends IUnknown {
    static IID := "{D98ADA1F-29E9-4EF5-A6C0-E53349883212}"
    ReadVirtual(Offset, Buffer, BytesRead?)
      => ComCall(3, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteVirtual(Offset, Buffer, BytesWritten?)
      => ComCall(4, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    SearchVirtual(Offset, Length, Pattern, PatternGranularity, MatchOffset)
      => ComCall(5, this.p, Int64, Offset, Int64, Length, Struct.Ptr, Pattern, UInt32, Pattern.Size, UInt32, PatternGranularity, Int64.Ptr, MatchOffset)
    ReadVirtualUncached(Offset, Buffer, BytesRead?)
      => ComCall(6, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteVirtualUncached(Offset, Buffer, BytesWritten?)
      => ComCall(7, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadPointersVirtual(Offset, Ptrs)
      => ComCall(8, this.p, UInt32, Ptrs.Length, Int64, Offset, Int64.Ptr, Ptrs)
    WritePointersVirtual(Offset, Ptrs)
      => ComCall(9, this.p, UInt32, Ptrs.Length, Int64, Offset, Int64.Ptr, Ptrs)
    ReadPhysical(Offset, Buffer, BytesRead?)
      => ComCall(10, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WritePhysical(Offset, Buffer, BytesWritten?)
      => ComCall(11, this.p, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadControl(Processor, Offset, Buffer, BytesRead?)
      => ComCall(12, this.p, UInt32, Processor, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteControl(Processor, Offset, Buffer, BytesWritten?)
      => ComCall(13, this.p, UInt32, Processor, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadIo(InterfaceType, BusNumber, AddressSpace, Offset, Buffer, BytesRead?)
      => ComCall(14, this.p, UInt32, InterfaceType, UInt32, BusNumber, UInt32, AddressSpace, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteIo(InterfaceType, BusNumber, AddressSpace, Offset, Buffer, BytesWritten?)
      => ComCall(15, this.p, UInt32, InterfaceType, UInt32, BusNumber, UInt32, AddressSpace, Int64, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    ReadMsr(Msr, Value)
      => ComCall(16, this.p, UInt32, Msr, Int64.Ptr, Value)
    WriteMsr(Msr, Value)
      => ComCall(17, this.p, UInt32, Msr, Int64, Value)
    ReadBusData(BusDataType, BusNumber, SlotNumber, Offset, Buffer, BytesRead?)
      => ComCall(18, this.p, UInt32, BusDataType, UInt32, BusNumber, UInt32, SlotNumber, UInt32, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteBusData(BusDataType, BusNumber, SlotNumber, Offset, Buffer, BytesWritten?)
      => ComCall(19, this.p, UInt32, BusDataType, UInt32, BusNumber, UInt32, SlotNumber, UInt32, Offset, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    CheckLowMemory()
      => ComCall(20, this.p)
    ReadDebuggerData(Index, Buffer, DataSize?)
      => ComCall(21, this.p, UInt32, Index, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, DataSize?)
    ReadProcessorSystemData(Processor, Index, Buffer, DataSize?)
      => ComCall(22, this.p, UInt32, Processor, UInt32, Index, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, DataSize?)
    VirtualToPhysical(Virtual, Physical)
      => ComCall(23, this.p, Int64, Virtual, Int64.Ptr, Physical)
    GetVirtualTranslationPhysicalOffsets(Virtual, Offsets?, Levels?)
      => ComCall(24, this.p, Int64, Virtual, Int64.Ptr, Offsets?, UInt32, Offsets?.Length ?? 0, UInt32.Ptr, Levels?)
    ReadHandleData(Handle, DataType, Buffer?, DataSize?)
      => ComCall(25, this.p, Int64, Handle, UInt32, DataType, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, DataSize?)
    FillVirtual(Start, Size, Pattern, Filled?)
      => ComCall(26, this.p, Int64, Start, UInt32, Size, Struct.Ptr, Pattern, UInt32, Pattern.Size, UInt32.Ptr, Filled?)
    FillPhysical(Start, Size, Pattern, Filled?)
      => ComCall(27, this.p, Int64, Start, UInt32, Size, Struct.Ptr, Pattern, UInt32, Pattern.Size, UInt32.Ptr, Filled?)
    QueryVirtual(Offset, Info)
      => ComCall(28, this.p, Int64, Offset, MEMORY_BASIC_INFORMATION64.Ptr, Info)
    ReadImageNtHeaders(ImageBase, Headers)
      => ComCall(29, this.p, Int64, ImageBase, IMAGE_NT_HEADERS64.Ptr, Headers)
    ReadTagged(Tag, Offset, Buffer?, TotalSize?)
      => ComCall(30, this.p, GUID.Ptr, Tag, UInt32, Offset, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, TotalSize?)
    StartEnumTagged(Handle)
      => ComCall(31, this.p, Int64.Ptr, Handle)
    GetNextTagged(Handle, Tag, Size)
      => ComCall(32, this.p, Int64, Handle, GUID.Ptr, Tag, UInt32.Ptr, Size)
    EndEnumTagged(Handle)
      => ComCall(33, this.p, Int64, Handle)
    GetOffsetInformation(Space, Which, Offset, Buffer?, InfoSize?)
      => ComCall(34, this.p, UInt32, Space, UInt32, Which, Int64, Offset, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, InfoSize?)
    GetNextDifferentlyValidOffsetVirtual(Offset, NextOffset)
      => ComCall(35, this.p, Int64, Offset, Int64.Ptr, NextOffset)
    GetValidRegionVirtual(Base, Size, ValidBase, ValidSize)
      => ComCall(36, this.p, Int64, Base, UInt32, Size, Int64.Ptr, ValidBase, UInt32.Ptr, ValidSize)
    SearchVirtual2(Offset, Length, Flags, Pattern, PatternGranularity, MatchOffset)
      => ComCall(37, this.p, Int64, Offset, Int64, Length, UInt32, Flags, Struct.Ptr, Pattern, UInt32, Pattern.Size, UInt32, PatternGranularity, Int64.Ptr, MatchOffset)
    ReadMultiByteStringVirtual(Offset, MaxBytes, Buffer?, StringBytes?)
      => ComCall(38, this.p, Int64, Offset, UInt32, MaxBytes, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringBytes?)
    ReadMultiByteStringVirtualWide(Offset, MaxBytes, CodePage, Buffer?, StringBytes?)
      => ComCall(39, this.p, Int64, Offset, UInt32, MaxBytes, UInt32, CodePage, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringBytes?)
    ReadUnicodeStringVirtual(Offset, MaxBytes, CodePage, Buffer?, StringBytes?)
      => ComCall(40, this.p, Int64, Offset, UInt32, MaxBytes, UInt32, CodePage, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringBytes?)
    ReadUnicodeStringVirtualWide(Offset, MaxBytes, Buffer?, StringBytes?)
      => ComCall(41, this.p, Int64, Offset, UInt32, MaxBytes, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringBytes?)
    ReadPhysical2(Offset, Flags, Buffer, BytesRead?)
      => ComCall(42, this.p, Int64, Offset, UInt32, Flags, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WritePhysical2(Offset, Flags, Buffer, BytesWritten?)
      => ComCall(43, this.p, Int64, Offset, UInt32, Flags, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
}
struct IDebugEventCallbacks extends IUnknown {
    static IID := "{337BE28B-5036-4D72-B6BF-C45FBB9F2EAA}"
    GetInterestMask(Mask)
      => ComCall(3, this.p, UInt32.Ptr, Mask)
    Breakpoint(Bp)
      => ComCall(4, this.p, IDebugBreakpoint, Bp)
    Exception(Exception, FirstChance)
      => ComCall(5, this.p, EXCEPTION_RECORD64.Ptr, Exception, UInt32, FirstChance)
    CreateThread(Handle, DataOffset, StartOffset)
      => ComCall(6, this.p, Int64, Handle, Int64, DataOffset, Int64, StartOffset)
    ExitThread(ExitCode)
      => ComCall(7, this.p, UInt32, ExitCode)
    CreateProcessA(ImageFileHandle, Handle, BaseOffset, ModuleSize, ModuleName?, ImageName?, CheckSum, TimeDateStamp, InitialThreadHandle, ThreadDataOffset, StartOffset)
      => ComCall(8, this.p, Int64, ImageFileHandle, Int64, Handle, Int64, BaseOffset, UInt32, ModuleSize, PSTR, ModuleName?, PSTR, ImageName?, UInt32, CheckSum, UInt32, TimeDateStamp, Int64, InitialThreadHandle, Int64, ThreadDataOffset, Int64, StartOffset)
    ExitProcess(ExitCode)
      => ComCall(9, this.p, UInt32, ExitCode)
    LoadModule(ImageFileHandle, BaseOffset, ModuleSize, ModuleName?, ImageName?, CheckSum, TimeDateStamp)
      => ComCall(10, this.p, Int64, ImageFileHandle, Int64, BaseOffset, UInt32, ModuleSize, PSTR, ModuleName?, PSTR, ImageName?, UInt32, CheckSum, UInt32, TimeDateStamp)
    UnloadModule(ImageBaseName?, BaseOffset)
      => ComCall(11, this.p, PSTR, ImageBaseName?, Int64, BaseOffset)
    SystemError(Error, Level)
      => ComCall(12, this.p, UInt32, Error, UInt32, Level)
    SessionStatus(Status)
      => ComCall(13, this.p, UInt32, Status)
    ChangeDebuggeeState(Flags, Argument)
      => ComCall(14, this.p, UInt32, Flags, Int64, Argument)
    ChangeEngineState(Flags, Argument)
      => ComCall(15, this.p, UInt32, Flags, Int64, Argument)
    ChangeSymbolState(Flags, Argument)
      => ComCall(16, this.p, UInt32, Flags, Int64, Argument)
}
struct IDebugEventCallbacksWide extends IUnknown {
    static IID := "{0690E046-9C23-45AC-A04F-987AC29AD0D3}"
    GetInterestMask(Mask)
      => ComCall(3, this.p, UInt32.Ptr, Mask)
    Breakpoint(Bp)
      => ComCall(4, this.p, IDebugBreakpoint2, Bp)
    Exception(Exception, FirstChance)
      => ComCall(5, this.p, EXCEPTION_RECORD64.Ptr, Exception, UInt32, FirstChance)
    CreateThread(Handle, DataOffset, StartOffset)
      => ComCall(6, this.p, Int64, Handle, Int64, DataOffset, Int64, StartOffset)
    ExitThread(ExitCode)
      => ComCall(7, this.p, UInt32, ExitCode)
    CreateProcessA(ImageFileHandle, Handle, BaseOffset, ModuleSize, ModuleName?, ImageName?, CheckSum, TimeDateStamp, InitialThreadHandle, ThreadDataOffset, StartOffset)
      => ComCall(8, this.p, Int64, ImageFileHandle, Int64, Handle, Int64, BaseOffset, UInt32, ModuleSize, "Str", ModuleName?, "Str", ImageName?, UInt32, CheckSum, UInt32, TimeDateStamp, Int64, InitialThreadHandle, Int64, ThreadDataOffset, Int64, StartOffset)
    ExitProcess(ExitCode)
      => ComCall(9, this.p, UInt32, ExitCode)
    LoadModule(ImageFileHandle, BaseOffset, ModuleSize, ModuleName?, ImageName?, CheckSum, TimeDateStamp)
      => ComCall(10, this.p, Int64, ImageFileHandle, Int64, BaseOffset, UInt32, ModuleSize, "Str", ModuleName?, "Str", ImageName?, UInt32, CheckSum, UInt32, TimeDateStamp)
    UnloadModule(ImageBaseName?, BaseOffset)
      => ComCall(11, this.p, "Str", ImageBaseName?, Int64, BaseOffset)
    SystemError(Error, Level)
      => ComCall(12, this.p, UInt32, Error, UInt32, Level)
    SessionStatus(Status)
      => ComCall(13, this.p, UInt32, Status)
    ChangeDebuggeeState(Flags, Argument)
      => ComCall(14, this.p, UInt32, Flags, Int64, Argument)
    ChangeEngineState(Flags, Argument)
      => ComCall(15, this.p, UInt32, Flags, Int64, Argument)
    ChangeSymbolState(Flags, Argument)
      => ComCall(16, this.p, UInt32, Flags, Int64, Argument)
}
struct DEBUG_EVENT_CONTEXT {
    Size : UInt32
    ProcessEngineId : UInt32
    ThreadEngineId : UInt32
    FrameEngineId : UInt32
}
struct IDebugEventContextCallbacks extends IUnknown {
    static IID := "{61A4905B-23F9-4247-B3C5-53D087529AB7}"
    GetInterestMask(Mask)
      => ComCall(3, this.p, UInt32.Ptr, Mask)
    Breakpoint(Bp, Context)
      => ComCall(4, this.p, IDebugBreakpoint2, Bp, Struct.Ptr, Context, UInt32, Context.Size)
    Exception(Exception, FirstChance, Context)
      => ComCall(5, this.p, EXCEPTION_RECORD64.Ptr, Exception, UInt32, FirstChance, Struct.Ptr, Context, UInt32, Context.Size)
    CreateThread(Handle, DataOffset, StartOffset, Context)
      => ComCall(6, this.p, Int64, Handle, Int64, DataOffset, Int64, StartOffset, Struct.Ptr, Context, UInt32, Context.Size)
    ExitThread(ExitCode, Context)
      => ComCall(7, this.p, UInt32, ExitCode, Struct.Ptr, Context, UInt32, Context.Size)
    CreateProcessA(ImageFileHandle, Handle, BaseOffset, ModuleSize, ModuleName?, ImageName?, CheckSum, TimeDateStamp, InitialThreadHandle, ThreadDataOffset, StartOffset, Context)
      => ComCall(8, this.p, Int64, ImageFileHandle, Int64, Handle, Int64, BaseOffset, UInt32, ModuleSize, "Str", ModuleName?, "Str", ImageName?, UInt32, CheckSum, UInt32, TimeDateStamp, Int64, InitialThreadHandle, Int64, ThreadDataOffset, Int64, StartOffset, Struct.Ptr, Context, UInt32, Context.Size)
    ExitProcess(ExitCode, Context)
      => ComCall(9, this.p, UInt32, ExitCode, Struct.Ptr, Context, UInt32, Context.Size)
    LoadModule(ImageFileHandle, BaseOffset, ModuleSize, ModuleName?, ImageName?, CheckSum, TimeDateStamp, Context)
      => ComCall(10, this.p, Int64, ImageFileHandle, Int64, BaseOffset, UInt32, ModuleSize, "Str", ModuleName?, "Str", ImageName?, UInt32, CheckSum, UInt32, TimeDateStamp, Struct.Ptr, Context, UInt32, Context.Size)
    UnloadModule(ImageBaseName?, BaseOffset, Context)
      => ComCall(11, this.p, "Str", ImageBaseName?, Int64, BaseOffset, Struct.Ptr, Context, UInt32, Context.Size)
    SystemError(Error, Level, Context)
      => ComCall(12, this.p, UInt32, Error, UInt32, Level, Struct.Ptr, Context, UInt32, Context.Size)
    SessionStatus(Status)
      => ComCall(13, this.p, UInt32, Status)
    ChangeDebuggeeState(Flags, Argument, Context)
      => ComCall(14, this.p, UInt32, Flags, Int64, Argument, Struct.Ptr, Context, UInt32, Context.Size)
    ChangeEngineState(Flags, Argument, Context)
      => ComCall(15, this.p, UInt32, Flags, Int64, Argument, Struct.Ptr, Context, UInt32, Context.Size)
    ChangeSymbolState(Flags, Argument)
      => ComCall(16, this.p, UInt32, Flags, Int64, Argument)
}
struct IDebugInputCallbacks extends IUnknown {
    static IID := "{9F50E42C-F136-499E-9A97-73036C94ED2D}"
    StartInput(BufferSize)
      => ComCall(3, this.p, UInt32, BufferSize)
    EndInput()
      => ComCall(4, this.p)
}
struct IDebugOutputCallbacks extends IUnknown {
    static IID := "{4BF58045-D654-4C40-B0AF-683090F356DC}"
    Output(Mask, Text)
      => ComCall(3, this.p, UInt32, Mask, PSTR, Text)
}
struct IDebugOutputCallbacksWide extends IUnknown {
    static IID := "{4C7FD663-C394-4E26-8EF1-34AD5ED3764C}"
    Output(Mask, Text)
      => ComCall(3, this.p, UInt32, Mask, "Str", Text)
}
struct IDebugOutputCallbacks2 extends IUnknown {
    static IID := "{67721FE9-56D2-4A44-A325-2B65513CE6EB}"
    Output(Mask, Text)
      => ComCall(3, this.p, UInt32, Mask, PSTR, Text)
    GetInterestMask(Mask)
      => ComCall(4, this.p, UInt32.Ptr, Mask)
    Output2(Which, Flags, Arg, Text?)
      => ComCall(5, this.p, UInt32, Which, UInt32, Flags, Int64, Arg, "Str", Text?)
}
struct DEBUG_REGISTER_DESCRIPTION {
    Type : UInt32
    Flags : UInt32
    SubregMaster : UInt32
    SubregLength : UInt32
    SubregMask : Int64
    SubregShift : UInt32
    Reserved0 : UInt32
}
struct IDebugRegisters extends IUnknown {
    static IID := "{CE289126-9E84-45A7-937E-67BB18691493}"
    GetNumberRegisters(Number)
      => ComCall(3, this.p, UInt32.Ptr, Number)
    GetDescription(Register, NameBuffer?, NameSize?, Desc?)
      => ComCall(4, this.p, UInt32, Register, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, DEBUG_REGISTER_DESCRIPTION.Ptr, Desc?)
    GetIndexByName(Name, Index)
      => ComCall(5, this.p, PSTR, Name, UInt32.Ptr, Index)
    GetValue(Register, Value)
      => ComCall(6, this.p, UInt32, Register, DEBUG_VALUE.Ptr, Value)
    SetValue(Register, Value)
      => ComCall(7, this.p, UInt32, Register, DEBUG_VALUE.Ptr, Value)
    GetValues(Indices?, Start, Values)
      => ComCall(8, this.p, UInt32, Values.Length, UInt32.Ptr, Indices?, UInt32, Start, DEBUG_VALUE.Ptr, Values)
    SetValues(Indices?, Start, Values)
      => ComCall(9, this.p, UInt32, Values.Length, UInt32.Ptr, Indices?, UInt32, Start, DEBUG_VALUE.Ptr, Values)
    OutputRegisters(OutputControl, Flags)
      => ComCall(10, this.p, UInt32, OutputControl, UInt32, Flags)
    GetInstructionOffset(Offset)
      => ComCall(11, this.p, Int64.Ptr, Offset)
    GetStackOffset(Offset)
      => ComCall(12, this.p, Int64.Ptr, Offset)
    GetFrameOffset(Offset)
      => ComCall(13, this.p, Int64.Ptr, Offset)
}
struct IDebugRegisters2 extends IUnknown {
    static IID := "{1656AFA9-19C6-4E3A-97E7-5DC9160CF9C4}"
    GetNumberRegisters(Number)
      => ComCall(3, this.p, UInt32.Ptr, Number)
    GetDescription(Register, NameBuffer?, NameSize?, Desc?)
      => ComCall(4, this.p, UInt32, Register, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, DEBUG_REGISTER_DESCRIPTION.Ptr, Desc?)
    GetIndexByName(Name, Index)
      => ComCall(5, this.p, PSTR, Name, UInt32.Ptr, Index)
    GetValue(Register, Value)
      => ComCall(6, this.p, UInt32, Register, DEBUG_VALUE.Ptr, Value)
    SetValue(Register, Value)
      => ComCall(7, this.p, UInt32, Register, DEBUG_VALUE.Ptr, Value)
    GetValues(Indices?, Start, Values)
      => ComCall(8, this.p, UInt32, Values.Length, UInt32.Ptr, Indices?, UInt32, Start, DEBUG_VALUE.Ptr, Values)
    SetValues(Indices?, Start, Values)
      => ComCall(9, this.p, UInt32, Values.Length, UInt32.Ptr, Indices?, UInt32, Start, DEBUG_VALUE.Ptr, Values)
    OutputRegisters(OutputControl, Flags)
      => ComCall(10, this.p, UInt32, OutputControl, UInt32, Flags)
    GetInstructionOffset(Offset)
      => ComCall(11, this.p, Int64.Ptr, Offset)
    GetStackOffset(Offset)
      => ComCall(12, this.p, Int64.Ptr, Offset)
    GetFrameOffset(Offset)
      => ComCall(13, this.p, Int64.Ptr, Offset)
    GetDescriptionWide(Register, NameBuffer?, NameSize?, Desc?)
      => ComCall(14, this.p, UInt32, Register, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, DEBUG_REGISTER_DESCRIPTION.Ptr, Desc?)
    GetIndexByNameWide(Name, Index)
      => ComCall(15, this.p, "Str", Name, UInt32.Ptr, Index)
    GetNumberPseudoRegisters(Number)
      => ComCall(16, this.p, UInt32.Ptr, Number)
    GetPseudoDescription(Register, NameBuffer?, NameSize?, TypeModule?, TypeId?)
      => ComCall(17, this.p, UInt32, Register, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, TypeModule?, UInt32.Ptr, TypeId?)
    GetPseudoDescriptionWide(Register, NameBuffer?, NameSize?, TypeModule?, TypeId?)
      => ComCall(18, this.p, UInt32, Register, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, TypeModule?, UInt32.Ptr, TypeId?)
    GetPseudoIndexByName(Name, Index)
      => ComCall(19, this.p, PSTR, Name, UInt32.Ptr, Index)
    GetPseudoIndexByNameWide(Name, Index)
      => ComCall(20, this.p, "Str", Name, UInt32.Ptr, Index)
    GetPseudoValues(Source, Indices?, Start, Values)
      => ComCall(21, this.p, UInt32, Source, UInt32, Values.Length, UInt32.Ptr, Indices?, UInt32, Start, DEBUG_VALUE.Ptr, Values)
    SetPseudoValues(Source, Indices?, Start, Values)
      => ComCall(22, this.p, UInt32, Source, UInt32, Values.Length, UInt32.Ptr, Indices?, UInt32, Start, DEBUG_VALUE.Ptr, Values)
    GetValues2(Source, Indices?, Start, Values)
      => ComCall(23, this.p, UInt32, Source, UInt32, Values.Length, UInt32.Ptr, Indices?, UInt32, Start, DEBUG_VALUE.Ptr, Values)
    SetValues2(Source, Indices?, Start, Values)
      => ComCall(24, this.p, UInt32, Source, UInt32, Values.Length, UInt32.Ptr, Indices?, UInt32, Start, DEBUG_VALUE.Ptr, Values)
    OutputRegisters2(OutputControl, Source, Flags)
      => ComCall(25, this.p, UInt32, OutputControl, UInt32, Source, UInt32, Flags)
    GetInstructionOffset2(Source, Offset)
      => ComCall(26, this.p, UInt32, Source, Int64.Ptr, Offset)
    GetStackOffset2(Source, Offset)
      => ComCall(27, this.p, UInt32, Source, Int64.Ptr, Offset)
    GetFrameOffset2(Source, Offset)
      => ComCall(28, this.p, UInt32, Source, Int64.Ptr, Offset)
}
struct DEBUG_SYMBOL_PARAMETERS {
    Module : Int64
    TypeId : UInt32
    ParentSymbol : UInt32
    SubElements : UInt32
    Flags : UInt32
    Reserved : Int64
}
struct IDebugSymbolGroup extends IUnknown {
    static IID := "{F2528316-0F1A-4431-AEED-11D096E1E2AB}"
    GetNumberSymbols(Number)
      => ComCall(3, this.p, UInt32.Ptr, Number)
    AddSymbol(Name, Index)
      => ComCall(4, this.p, PSTR, Name, UInt32.Ptr, Index)
    RemoveSymbolByName(Name)
      => ComCall(5, this.p, PSTR, Name)
    RemoveSymbolByIndex(Index)
      => ComCall(6, this.p, UInt32, Index)
    GetSymbolName(Index, Buffer?, NameSize?)
      => ComCall(7, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetSymbolParameters(Start, Params)
      => ComCall(8, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SYMBOL_PARAMETERS.Ptr, Params)
    ExpandSymbol(Index, Expand)
      => ComCall(9, this.p, UInt32, Index, BOOL, Expand)
    OutputSymbols(OutputControl, Flags, Start, Count)
      => ComCall(10, this.p, UInt32, OutputControl, UInt32, Flags, UInt32, Start, UInt32, Count)
    WriteSymbol(Index, Value)
      => ComCall(11, this.p, UInt32, Index, PSTR, Value)
    OutputAsType(Index, Type)
      => ComCall(12, this.p, UInt32, Index, PSTR, Type)
}
struct DEBUG_SYMBOL_ENTRY {
    ModuleBase : Int64
    Offset : Int64
    Id : Int64
    Arg64 : Int64
    Size : UInt32
    Flags : UInt32
    TypeId : UInt32
    NameSize : UInt32
    Token : UInt32
    Tag : UInt32
    Arg32 : UInt32
    Reserved : UInt32
}
struct IDebugSymbolGroup2 extends IUnknown {
    static IID := "{6A7CCC5F-FB5E-4DCC-B41C-6C20307BCCC7}"
    GetNumberSymbols(Number)
      => ComCall(3, this.p, UInt32.Ptr, Number)
    AddSymbol(Name, Index)
      => ComCall(4, this.p, PSTR, Name, UInt32.Ptr, Index)
    RemoveSymbolByName(Name)
      => ComCall(5, this.p, PSTR, Name)
    RemoveSymbolByIndex(Index)
      => ComCall(6, this.p, UInt32, Index)
    GetSymbolName(Index, Buffer?, NameSize?)
      => ComCall(7, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetSymbolParameters(Start, Params)
      => ComCall(8, this.p, UInt32, Start, UInt32, Params.Length, DEBUG_SYMBOL_PARAMETERS.Ptr, Params)
    ExpandSymbol(Index, Expand)
      => ComCall(9, this.p, UInt32, Index, BOOL, Expand)
    OutputSymbols(OutputControl, Flags, Start, Count)
      => ComCall(10, this.p, UInt32, OutputControl, UInt32, Flags, UInt32, Start, UInt32, Count)
    WriteSymbol(Index, Value)
      => ComCall(11, this.p, UInt32, Index, PSTR, Value)
    OutputAsType(Index, Type)
      => ComCall(12, this.p, UInt32, Index, PSTR, Type)
    AddSymbolWide(Name, Index)
      => ComCall(13, this.p, "Str", Name, UInt32.Ptr, Index)
    RemoveSymbolByNameWide(Name)
      => ComCall(14, this.p, "Str", Name)
    GetSymbolNameWide(Index, Buffer?, NameSize?)
      => ComCall(15, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    WriteSymbolWide(Index, Value)
      => ComCall(16, this.p, UInt32, Index, "Str", Value)
    OutputAsTypeWide(Index, Type)
      => ComCall(17, this.p, UInt32, Index, "Str", Type)
    GetSymbolTypeName(Index, Buffer?, NameSize?)
      => ComCall(18, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetSymbolTypeNameWide(Index, Buffer?, NameSize?)
      => ComCall(19, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetSymbolSize(Index, Size)
      => ComCall(20, this.p, UInt32, Index, UInt32.Ptr, Size)
    GetSymbolOffset(Index, Offset)
      => ComCall(21, this.p, UInt32, Index, Int64.Ptr, Offset)
    GetSymbolRegister(Index, Register)
      => ComCall(22, this.p, UInt32, Index, UInt32.Ptr, Register)
    GetSymbolValueText(Index, Buffer?, NameSize?)
      => ComCall(23, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetSymbolValueTextWide(Index, Buffer?, NameSize?)
      => ComCall(24, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetSymbolEntryInformation(Index, Entry)
      => ComCall(25, this.p, UInt32, Index, DEBUG_SYMBOL_ENTRY.Ptr, Entry)
}
struct DEBUG_MODULE_PARAMETERS {
    Base : Int64
    Size : UInt32
    TimeDateStamp : UInt32
    Checksum : UInt32
    Flags : UInt32
    SymbolType : UInt32
    ImageNameSize : UInt32
    ModuleNameSize : UInt32
    LoadedImageNameSize : UInt32
    SymbolFileNameSize : UInt32
    MappedImageNameSize : UInt32
    Reserved : Int64[2]
}
struct IDebugSymbols extends IUnknown {
    static IID := "{8C31E98C-983A-48A5-9016-6FE5D667A950}"
    GetSymbolOptions(Options)
      => ComCall(3, this.p, UInt32.Ptr, Options)
    AddSymbolOptions(Options)
      => ComCall(4, this.p, UInt32, Options)
    RemoveSymbolOptions(Options)
      => ComCall(5, this.p, UInt32, Options)
    SetSymbolOptions(Options)
      => ComCall(6, this.p, UInt32, Options)
    GetNameByOffset(Offset, NameBuffer?, NameSize?, Displacement?)
      => ComCall(7, this.p, Int64, Offset, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetOffsetByName(Symbol, Offset)
      => ComCall(8, this.p, PSTR, Symbol, Int64.Ptr, Offset)
    GetNearNameByOffset(Offset, Delta, NameBuffer?, NameSize?, Displacement?)
      => ComCall(9, this.p, Int64, Offset, Int32, Delta, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetLineByOffset(Offset, Line?, FileBuffer?, FileSize?, Displacement?)
      => ComCall(10, this.p, Int64, Offset, UInt32.Ptr, Line?, PSTR, FileBuffer?, UInt32, FileBuffer?.Length ?? 0, UInt32.Ptr, FileSize?, Int64.Ptr, Displacement?)
    GetOffsetByLine(Line, File, Offset)
      => ComCall(11, this.p, UInt32, Line, PSTR, File, Int64.Ptr, Offset)
    GetNumberModules(Loaded, Unloaded)
      => ComCall(12, this.p, UInt32.Ptr, Loaded, UInt32.Ptr, Unloaded)
    GetModuleByIndex(Index, Base)
      => ComCall(13, this.p, UInt32, Index, Int64.Ptr, Base)
    GetModuleByModuleName(Name, StartIndex, Index?, Base?)
      => ComCall(14, this.p, PSTR, Name, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleByOffset(Offset, StartIndex, Index?, Base?)
      => ComCall(15, this.p, Int64, Offset, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleNames(Index, Base, ImageNameBuffer?, ImageNameSize?, ModuleNameBuffer?, ModuleNameSize?, LoadedImageNameBuffer?, LoadedImageNameSize?)
      => ComCall(16, this.p, UInt32, Index, Int64, Base, PSTR, ImageNameBuffer?, UInt32, ImageNameBuffer?.Length ?? 0, UInt32.Ptr, ImageNameSize?, PSTR, ModuleNameBuffer?, UInt32, ModuleNameBuffer?.Length ?? 0, UInt32.Ptr, ModuleNameSize?, PSTR, LoadedImageNameBuffer?, UInt32, LoadedImageNameBuffer?.Length ?? 0, UInt32.Ptr, LoadedImageNameSize?)
    GetModuleParameters(Bases?, Start, Params)
      => ComCall(17, this.p, UInt32, Params.Length, Int64.Ptr, Bases?, UInt32, Start, DEBUG_MODULE_PARAMETERS.Ptr, Params)
    GetSymbolModule(Symbol, Base)
      => ComCall(18, this.p, PSTR, Symbol, Int64.Ptr, Base)
    GetTypeName(Module, TypeId, NameBuffer?, NameSize?)
      => ComCall(19, this.p, Int64, Module, UInt32, TypeId, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetTypeId(Module, Name, TypeId)
      => ComCall(20, this.p, Int64, Module, PSTR, Name, UInt32.Ptr, TypeId)
    GetTypeSize(Module, TypeId, Size)
      => ComCall(21, this.p, Int64, Module, UInt32, TypeId, UInt32.Ptr, Size)
    GetFieldOffset(Module, TypeId, Field, Offset)
      => ComCall(22, this.p, Int64, Module, UInt32, TypeId, PSTR, Field, UInt32.Ptr, Offset)
    GetSymbolTypeId(Symbol, TypeId, Module?)
      => ComCall(23, this.p, PSTR, Symbol, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    GetOffsetTypeId(Offset, TypeId, Module?)
      => ComCall(24, this.p, Int64, Offset, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    ReadTypedDataVirtual(Offset, Module, TypeId, Buffer, BytesRead?)
      => ComCall(25, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteTypedDataVirtual(Offset, Module, TypeId, Buffer, BytesWritten?)
      => ComCall(26, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    OutputTypedDataVirtual(OutputControl, Offset, Module, TypeId, Flags)
      => ComCall(27, this.p, UInt32, OutputControl, Int64, Offset, Int64, Module, UInt32, TypeId, UInt32, Flags)
    ReadTypedDataPhysical(Offset, Module, TypeId, Buffer, BytesRead?)
      => ComCall(28, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteTypedDataPhysical(Offset, Module, TypeId, Buffer, BytesWritten?)
      => ComCall(29, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    OutputTypedDataPhysical(OutputControl, Offset, Module, TypeId, Flags)
      => ComCall(30, this.p, UInt32, OutputControl, Int64, Offset, Int64, Module, UInt32, TypeId, UInt32, Flags)
    GetScope(InstructionOffset?, ScopeFrame?, ScopeContext?)
      => ComCall(31, this.p, Int64.Ptr, InstructionOffset?, DEBUG_STACK_FRAME.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    SetScope(InstructionOffset, ScopeFrame?, ScopeContext?)
      => ComCall(32, this.p, Int64, InstructionOffset, DEBUG_STACK_FRAME.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    ResetScope()
      => ComCall(33, this.p)
    GetScopeSymbolGroup(Flags, Update?, Symbols)
      => ComCall(34, this.p, UInt32, Flags, IDebugSymbolGroup, Update?, IDebugSymbolGroup.Ptr, Symbols)
    CreateSymbolGroup(Group)
      => ComCall(35, this.p, IDebugSymbolGroup.Ptr, Group)
    StartSymbolMatch(Pattern, Handle)
      => ComCall(36, this.p, PSTR, Pattern, Int64.Ptr, Handle)
    GetNextSymbolMatch(Handle, Buffer?, MatchSize?, Offset?)
      => ComCall(37, this.p, Int64, Handle, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MatchSize?, Int64.Ptr, Offset?)
    EndSymbolMatch(Handle)
      => ComCall(38, this.p, Int64, Handle)
    Reload(Module)
      => ComCall(39, this.p, PSTR, Module)
    GetSymbolPath(Buffer?, PathSize?)
      => ComCall(40, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetSymbolPath(Path)
      => ComCall(41, this.p, PSTR, Path)
    AppendSymbolPath(Addition)
      => ComCall(42, this.p, PSTR, Addition)
    GetImagePath(Buffer?, PathSize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetImagePath(Path)
      => ComCall(44, this.p, PSTR, Path)
    AppendImagePath(Addition)
      => ComCall(45, this.p, PSTR, Addition)
    GetSourcePath(Buffer?, PathSize?)
      => ComCall(46, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    GetSourcePathElement(Index, Buffer?, ElementSize?)
      => ComCall(47, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ElementSize?)
    SetSourcePath(Path)
      => ComCall(48, this.p, PSTR, Path)
    AppendSourcePath(Addition)
      => ComCall(49, this.p, PSTR, Addition)
    FindSourceFile(StartElement, File, Flags, FoundElement?, Buffer?, FoundSize?)
      => ComCall(50, this.p, UInt32, StartElement, PSTR, File, UInt32, Flags, UInt32.Ptr, FoundElement?, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSourceFileLineOffsets(File, Buffer?, FileLines?)
      => ComCall(51, this.p, PSTR, File, Int64.Ptr, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileLines?)
}
struct IDebugSymbols2 extends IUnknown {
    static IID := "{3A707211-AFDD-4495-AD4F-56FECDF8163F}"
    GetSymbolOptions(Options)
      => ComCall(3, this.p, UInt32.Ptr, Options)
    AddSymbolOptions(Options)
      => ComCall(4, this.p, UInt32, Options)
    RemoveSymbolOptions(Options)
      => ComCall(5, this.p, UInt32, Options)
    SetSymbolOptions(Options)
      => ComCall(6, this.p, UInt32, Options)
    GetNameByOffset(Offset, NameBuffer?, NameSize?, Displacement?)
      => ComCall(7, this.p, Int64, Offset, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetOffsetByName(Symbol, Offset)
      => ComCall(8, this.p, PSTR, Symbol, Int64.Ptr, Offset)
    GetNearNameByOffset(Offset, Delta, NameBuffer?, NameSize?, Displacement?)
      => ComCall(9, this.p, Int64, Offset, Int32, Delta, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetLineByOffset(Offset, Line?, FileBuffer?, FileSize?, Displacement?)
      => ComCall(10, this.p, Int64, Offset, UInt32.Ptr, Line?, PSTR, FileBuffer?, UInt32, FileBuffer?.Length ?? 0, UInt32.Ptr, FileSize?, Int64.Ptr, Displacement?)
    GetOffsetByLine(Line, File, Offset)
      => ComCall(11, this.p, UInt32, Line, PSTR, File, Int64.Ptr, Offset)
    GetNumberModules(Loaded, Unloaded)
      => ComCall(12, this.p, UInt32.Ptr, Loaded, UInt32.Ptr, Unloaded)
    GetModuleByIndex(Index, Base)
      => ComCall(13, this.p, UInt32, Index, Int64.Ptr, Base)
    GetModuleByModuleName(Name, StartIndex, Index?, Base?)
      => ComCall(14, this.p, PSTR, Name, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleByOffset(Offset, StartIndex, Index?, Base?)
      => ComCall(15, this.p, Int64, Offset, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleNames(Index, Base, ImageNameBuffer?, ImageNameSize?, ModuleNameBuffer?, ModuleNameSize?, LoadedImageNameBuffer?, LoadedImageNameSize?)
      => ComCall(16, this.p, UInt32, Index, Int64, Base, PSTR, ImageNameBuffer?, UInt32, ImageNameBuffer?.Length ?? 0, UInt32.Ptr, ImageNameSize?, PSTR, ModuleNameBuffer?, UInt32, ModuleNameBuffer?.Length ?? 0, UInt32.Ptr, ModuleNameSize?, PSTR, LoadedImageNameBuffer?, UInt32, LoadedImageNameBuffer?.Length ?? 0, UInt32.Ptr, LoadedImageNameSize?)
    GetModuleParameters(Bases?, Start, Params)
      => ComCall(17, this.p, UInt32, Params.Length, Int64.Ptr, Bases?, UInt32, Start, DEBUG_MODULE_PARAMETERS.Ptr, Params)
    GetSymbolModule(Symbol, Base)
      => ComCall(18, this.p, PSTR, Symbol, Int64.Ptr, Base)
    GetTypeName(Module, TypeId, NameBuffer?, NameSize?)
      => ComCall(19, this.p, Int64, Module, UInt32, TypeId, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetTypeId(Module, Name, TypeId)
      => ComCall(20, this.p, Int64, Module, PSTR, Name, UInt32.Ptr, TypeId)
    GetTypeSize(Module, TypeId, Size)
      => ComCall(21, this.p, Int64, Module, UInt32, TypeId, UInt32.Ptr, Size)
    GetFieldOffset(Module, TypeId, Field, Offset)
      => ComCall(22, this.p, Int64, Module, UInt32, TypeId, PSTR, Field, UInt32.Ptr, Offset)
    GetSymbolTypeId(Symbol, TypeId, Module?)
      => ComCall(23, this.p, PSTR, Symbol, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    GetOffsetTypeId(Offset, TypeId, Module?)
      => ComCall(24, this.p, Int64, Offset, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    ReadTypedDataVirtual(Offset, Module, TypeId, Buffer, BytesRead?)
      => ComCall(25, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteTypedDataVirtual(Offset, Module, TypeId, Buffer, BytesWritten?)
      => ComCall(26, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    OutputTypedDataVirtual(OutputControl, Offset, Module, TypeId, Flags)
      => ComCall(27, this.p, UInt32, OutputControl, Int64, Offset, Int64, Module, UInt32, TypeId, UInt32, Flags)
    ReadTypedDataPhysical(Offset, Module, TypeId, Buffer, BytesRead?)
      => ComCall(28, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteTypedDataPhysical(Offset, Module, TypeId, Buffer, BytesWritten?)
      => ComCall(29, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    OutputTypedDataPhysical(OutputControl, Offset, Module, TypeId, Flags)
      => ComCall(30, this.p, UInt32, OutputControl, Int64, Offset, Int64, Module, UInt32, TypeId, UInt32, Flags)
    GetScope(InstructionOffset?, ScopeFrame?, ScopeContext?)
      => ComCall(31, this.p, Int64.Ptr, InstructionOffset?, DEBUG_STACK_FRAME.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    SetScope(InstructionOffset, ScopeFrame?, ScopeContext?)
      => ComCall(32, this.p, Int64, InstructionOffset, DEBUG_STACK_FRAME.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    ResetScope()
      => ComCall(33, this.p)
    GetScopeSymbolGroup(Flags, Update?, Symbols)
      => ComCall(34, this.p, UInt32, Flags, IDebugSymbolGroup, Update?, IDebugSymbolGroup.Ptr, Symbols)
    CreateSymbolGroup(Group)
      => ComCall(35, this.p, IDebugSymbolGroup.Ptr, Group)
    StartSymbolMatch(Pattern, Handle)
      => ComCall(36, this.p, PSTR, Pattern, Int64.Ptr, Handle)
    GetNextSymbolMatch(Handle, Buffer?, MatchSize?, Offset?)
      => ComCall(37, this.p, Int64, Handle, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MatchSize?, Int64.Ptr, Offset?)
    EndSymbolMatch(Handle)
      => ComCall(38, this.p, Int64, Handle)
    Reload(Module)
      => ComCall(39, this.p, PSTR, Module)
    GetSymbolPath(Buffer?, PathSize?)
      => ComCall(40, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetSymbolPath(Path)
      => ComCall(41, this.p, PSTR, Path)
    AppendSymbolPath(Addition)
      => ComCall(42, this.p, PSTR, Addition)
    GetImagePath(Buffer?, PathSize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetImagePath(Path)
      => ComCall(44, this.p, PSTR, Path)
    AppendImagePath(Addition)
      => ComCall(45, this.p, PSTR, Addition)
    GetSourcePath(Buffer?, PathSize?)
      => ComCall(46, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    GetSourcePathElement(Index, Buffer?, ElementSize?)
      => ComCall(47, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ElementSize?)
    SetSourcePath(Path)
      => ComCall(48, this.p, PSTR, Path)
    AppendSourcePath(Addition)
      => ComCall(49, this.p, PSTR, Addition)
    FindSourceFile(StartElement, File, Flags, FoundElement?, Buffer?, FoundSize?)
      => ComCall(50, this.p, UInt32, StartElement, PSTR, File, UInt32, Flags, UInt32.Ptr, FoundElement?, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSourceFileLineOffsets(File, Buffer?, FileLines?)
      => ComCall(51, this.p, PSTR, File, Int64.Ptr, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileLines?)
    GetModuleVersionInformation(Index, Base, Item, Buffer?, VerInfoSize?)
      => ComCall(52, this.p, UInt32, Index, Int64, Base, PSTR, Item, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, VerInfoSize?)
    GetModuleNameString(Which, Index, Base, Buffer?, NameSize?)
      => ComCall(53, this.p, UInt32, Which, UInt32, Index, Int64, Base, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetConstantName(Module, TypeId, Value, NameBuffer?, NameSize?)
      => ComCall(54, this.p, Int64, Module, UInt32, TypeId, Int64, Value, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetFieldName(Module, TypeId, FieldIndex, NameBuffer?, NameSize?)
      => ComCall(55, this.p, Int64, Module, UInt32, TypeId, UInt32, FieldIndex, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetTypeOptions(Options)
      => ComCall(56, this.p, UInt32.Ptr, Options)
    AddTypeOptions(Options)
      => ComCall(57, this.p, UInt32, Options)
    RemoveTypeOptions(Options)
      => ComCall(58, this.p, UInt32, Options)
    SetTypeOptions(Options)
      => ComCall(59, this.p, UInt32, Options)
}
struct DEBUG_MODULE_AND_ID {
    ModuleBase : Int64
    Id : Int64
}
struct DEBUG_SYMBOL_SOURCE_ENTRY {
    ModuleBase : Int64
    Offset : Int64
    FileNameId : Int64
    EngineInternal : Int64
    Size : UInt32
    Flags : UInt32
    FileNameSize : UInt32
    StartLine : UInt32
    EndLine : UInt32
    StartColumn : UInt32
    EndColumn : UInt32
    Reserved : UInt32
}
struct IDebugSymbols3 extends IUnknown {
    static IID := "{F02FBECC-50AC-4F36-9AD9-C975E8F32FF8}"
    GetSymbolOptions(Options)
      => ComCall(3, this.p, UInt32.Ptr, Options)
    AddSymbolOptions(Options)
      => ComCall(4, this.p, UInt32, Options)
    RemoveSymbolOptions(Options)
      => ComCall(5, this.p, UInt32, Options)
    SetSymbolOptions(Options)
      => ComCall(6, this.p, UInt32, Options)
    GetNameByOffset(Offset, NameBuffer?, NameSize?, Displacement?)
      => ComCall(7, this.p, Int64, Offset, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetOffsetByName(Symbol, Offset)
      => ComCall(8, this.p, PSTR, Symbol, Int64.Ptr, Offset)
    GetNearNameByOffset(Offset, Delta, NameBuffer?, NameSize?, Displacement?)
      => ComCall(9, this.p, Int64, Offset, Int32, Delta, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetLineByOffset(Offset, Line?, FileBuffer?, FileSize?, Displacement?)
      => ComCall(10, this.p, Int64, Offset, UInt32.Ptr, Line?, PSTR, FileBuffer?, UInt32, FileBuffer?.Length ?? 0, UInt32.Ptr, FileSize?, Int64.Ptr, Displacement?)
    GetOffsetByLine(Line, File, Offset)
      => ComCall(11, this.p, UInt32, Line, PSTR, File, Int64.Ptr, Offset)
    GetNumberModules(Loaded, Unloaded)
      => ComCall(12, this.p, UInt32.Ptr, Loaded, UInt32.Ptr, Unloaded)
    GetModuleByIndex(Index, Base)
      => ComCall(13, this.p, UInt32, Index, Int64.Ptr, Base)
    GetModuleByModuleName(Name, StartIndex, Index?, Base?)
      => ComCall(14, this.p, PSTR, Name, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleByOffset(Offset, StartIndex, Index?, Base?)
      => ComCall(15, this.p, Int64, Offset, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleNames(Index, Base, ImageNameBuffer?, ImageNameSize?, ModuleNameBuffer?, ModuleNameSize?, LoadedImageNameBuffer?, LoadedImageNameSize?)
      => ComCall(16, this.p, UInt32, Index, Int64, Base, PSTR, ImageNameBuffer?, UInt32, ImageNameBuffer?.Length ?? 0, UInt32.Ptr, ImageNameSize?, PSTR, ModuleNameBuffer?, UInt32, ModuleNameBuffer?.Length ?? 0, UInt32.Ptr, ModuleNameSize?, PSTR, LoadedImageNameBuffer?, UInt32, LoadedImageNameBuffer?.Length ?? 0, UInt32.Ptr, LoadedImageNameSize?)
    GetModuleParameters(Bases?, Start, Params)
      => ComCall(17, this.p, UInt32, Params.Length, Int64.Ptr, Bases?, UInt32, Start, DEBUG_MODULE_PARAMETERS.Ptr, Params)
    GetSymbolModule(Symbol, Base)
      => ComCall(18, this.p, PSTR, Symbol, Int64.Ptr, Base)
    GetTypeName(Module, TypeId, NameBuffer?, NameSize?)
      => ComCall(19, this.p, Int64, Module, UInt32, TypeId, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetTypeId(Module, Name, TypeId)
      => ComCall(20, this.p, Int64, Module, PSTR, Name, UInt32.Ptr, TypeId)
    GetTypeSize(Module, TypeId, Size)
      => ComCall(21, this.p, Int64, Module, UInt32, TypeId, UInt32.Ptr, Size)
    GetFieldOffset(Module, TypeId, Field, Offset)
      => ComCall(22, this.p, Int64, Module, UInt32, TypeId, PSTR, Field, UInt32.Ptr, Offset)
    GetSymbolTypeId(Symbol, TypeId, Module?)
      => ComCall(23, this.p, PSTR, Symbol, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    GetOffsetTypeId(Offset, TypeId, Module?)
      => ComCall(24, this.p, Int64, Offset, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    ReadTypedDataVirtual(Offset, Module, TypeId, Buffer, BytesRead?)
      => ComCall(25, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteTypedDataVirtual(Offset, Module, TypeId, Buffer, BytesWritten?)
      => ComCall(26, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    OutputTypedDataVirtual(OutputControl, Offset, Module, TypeId, Flags)
      => ComCall(27, this.p, UInt32, OutputControl, Int64, Offset, Int64, Module, UInt32, TypeId, UInt32, Flags)
    ReadTypedDataPhysical(Offset, Module, TypeId, Buffer, BytesRead?)
      => ComCall(28, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteTypedDataPhysical(Offset, Module, TypeId, Buffer, BytesWritten?)
      => ComCall(29, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    OutputTypedDataPhysical(OutputControl, Offset, Module, TypeId, Flags)
      => ComCall(30, this.p, UInt32, OutputControl, Int64, Offset, Int64, Module, UInt32, TypeId, UInt32, Flags)
    GetScope(InstructionOffset?, ScopeFrame?, ScopeContext?)
      => ComCall(31, this.p, Int64.Ptr, InstructionOffset?, DEBUG_STACK_FRAME.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    SetScope(InstructionOffset, ScopeFrame?, ScopeContext?)
      => ComCall(32, this.p, Int64, InstructionOffset, DEBUG_STACK_FRAME.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    ResetScope()
      => ComCall(33, this.p)
    GetScopeSymbolGroup(Flags, Update?, Symbols)
      => ComCall(34, this.p, UInt32, Flags, IDebugSymbolGroup, Update?, IDebugSymbolGroup.Ptr, Symbols)
    CreateSymbolGroup(Group)
      => ComCall(35, this.p, IDebugSymbolGroup.Ptr, Group)
    StartSymbolMatch(Pattern, Handle)
      => ComCall(36, this.p, PSTR, Pattern, Int64.Ptr, Handle)
    GetNextSymbolMatch(Handle, Buffer?, MatchSize?, Offset?)
      => ComCall(37, this.p, Int64, Handle, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MatchSize?, Int64.Ptr, Offset?)
    EndSymbolMatch(Handle)
      => ComCall(38, this.p, Int64, Handle)
    Reload(Module)
      => ComCall(39, this.p, PSTR, Module)
    GetSymbolPath(Buffer?, PathSize?)
      => ComCall(40, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetSymbolPath(Path)
      => ComCall(41, this.p, PSTR, Path)
    AppendSymbolPath(Addition)
      => ComCall(42, this.p, PSTR, Addition)
    GetImagePath(Buffer?, PathSize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetImagePath(Path)
      => ComCall(44, this.p, PSTR, Path)
    AppendImagePath(Addition)
      => ComCall(45, this.p, PSTR, Addition)
    GetSourcePath(Buffer?, PathSize?)
      => ComCall(46, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    GetSourcePathElement(Index, Buffer?, ElementSize?)
      => ComCall(47, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ElementSize?)
    SetSourcePath(Path)
      => ComCall(48, this.p, PSTR, Path)
    AppendSourcePath(Addition)
      => ComCall(49, this.p, PSTR, Addition)
    FindSourceFile(StartElement, File, Flags, FoundElement?, Buffer?, FoundSize?)
      => ComCall(50, this.p, UInt32, StartElement, PSTR, File, UInt32, Flags, UInt32.Ptr, FoundElement?, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSourceFileLineOffsets(File, Buffer?, FileLines?)
      => ComCall(51, this.p, PSTR, File, Int64.Ptr, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileLines?)
    GetModuleVersionInformation(Index, Base, Item, Buffer?, VerInfoSize?)
      => ComCall(52, this.p, UInt32, Index, Int64, Base, PSTR, Item, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, VerInfoSize?)
    GetModuleNameString(Which, Index, Base, Buffer?, NameSize?)
      => ComCall(53, this.p, UInt32, Which, UInt32, Index, Int64, Base, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetConstantName(Module, TypeId, Value, NameBuffer?, NameSize?)
      => ComCall(54, this.p, Int64, Module, UInt32, TypeId, Int64, Value, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetFieldName(Module, TypeId, FieldIndex, NameBuffer?, NameSize?)
      => ComCall(55, this.p, Int64, Module, UInt32, TypeId, UInt32, FieldIndex, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetTypeOptions(Options)
      => ComCall(56, this.p, UInt32.Ptr, Options)
    AddTypeOptions(Options)
      => ComCall(57, this.p, UInt32, Options)
    RemoveTypeOptions(Options)
      => ComCall(58, this.p, UInt32, Options)
    SetTypeOptions(Options)
      => ComCall(59, this.p, UInt32, Options)
    GetNameByOffsetWide(Offset, NameBuffer?, NameSize?, Displacement?)
      => ComCall(60, this.p, Int64, Offset, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetOffsetByNameWide(Symbol, Offset)
      => ComCall(61, this.p, "Str", Symbol, Int64.Ptr, Offset)
    GetNearNameByOffsetWide(Offset, Delta, NameBuffer?, NameSize?, Displacement?)
      => ComCall(62, this.p, Int64, Offset, Int32, Delta, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetLineByOffsetWide(Offset, Line?, FileBuffer?, FileSize?, Displacement?)
      => ComCall(63, this.p, Int64, Offset, UInt32.Ptr, Line?, PWSTR, FileBuffer?, UInt32, FileBuffer?.Length ?? 0, UInt32.Ptr, FileSize?, Int64.Ptr, Displacement?)
    GetOffsetByLineWide(Line, File, Offset)
      => ComCall(64, this.p, UInt32, Line, "Str", File, Int64.Ptr, Offset)
    GetModuleByModuleNameWide(Name, StartIndex, Index?, Base?)
      => ComCall(65, this.p, "Str", Name, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetSymbolModuleWide(Symbol, Base)
      => ComCall(66, this.p, "Str", Symbol, Int64.Ptr, Base)
    GetTypeNameWide(Module, TypeId, NameBuffer?, NameSize?)
      => ComCall(67, this.p, Int64, Module, UInt32, TypeId, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetTypeIdWide(Module, Name, TypeId)
      => ComCall(68, this.p, Int64, Module, "Str", Name, UInt32.Ptr, TypeId)
    GetFieldOffsetWide(Module, TypeId, Field, Offset)
      => ComCall(69, this.p, Int64, Module, UInt32, TypeId, "Str", Field, UInt32.Ptr, Offset)
    GetSymbolTypeIdWide(Symbol, TypeId, Module?)
      => ComCall(70, this.p, "Str", Symbol, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    GetScopeSymbolGroup2(Flags, Update?, Symbols)
      => ComCall(71, this.p, UInt32, Flags, IDebugSymbolGroup2, Update?, IDebugSymbolGroup2.Ptr, Symbols)
    CreateSymbolGroup2(Group)
      => ComCall(72, this.p, IDebugSymbolGroup2.Ptr, Group)
    StartSymbolMatchWide(Pattern, Handle)
      => ComCall(73, this.p, "Str", Pattern, Int64.Ptr, Handle)
    GetNextSymbolMatchWide(Handle, Buffer?, MatchSize?, Offset?)
      => ComCall(74, this.p, Int64, Handle, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MatchSize?, Int64.Ptr, Offset?)
    ReloadWide(Module)
      => ComCall(75, this.p, "Str", Module)
    GetSymbolPathWide(Buffer?, PathSize?)
      => ComCall(76, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetSymbolPathWide(Path)
      => ComCall(77, this.p, "Str", Path)
    AppendSymbolPathWide(Addition)
      => ComCall(78, this.p, "Str", Addition)
    GetImagePathWide(Buffer?, PathSize?)
      => ComCall(79, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetImagePathWide(Path)
      => ComCall(80, this.p, "Str", Path)
    AppendImagePathWide(Addition)
      => ComCall(81, this.p, "Str", Addition)
    GetSourcePathWide(Buffer?, PathSize?)
      => ComCall(82, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    GetSourcePathElementWide(Index, Buffer?, ElementSize?)
      => ComCall(83, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ElementSize?)
    SetSourcePathWide(Path)
      => ComCall(84, this.p, "Str", Path)
    AppendSourcePathWide(Addition)
      => ComCall(85, this.p, "Str", Addition)
    FindSourceFileWide(StartElement, File, Flags, FoundElement?, Buffer?, FoundSize?)
      => ComCall(86, this.p, UInt32, StartElement, "Str", File, UInt32, Flags, UInt32.Ptr, FoundElement?, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSourceFileLineOffsetsWide(File, Buffer?, FileLines?)
      => ComCall(87, this.p, "Str", File, Int64.Ptr, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileLines?)
    GetModuleVersionInformationWide(Index, Base, Item, Buffer?, VerInfoSize?)
      => ComCall(88, this.p, UInt32, Index, Int64, Base, "Str", Item, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, VerInfoSize?)
    GetModuleNameStringWide(Which, Index, Base, Buffer?, NameSize?)
      => ComCall(89, this.p, UInt32, Which, UInt32, Index, Int64, Base, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetConstantNameWide(Module, TypeId, Value, NameBuffer?, NameSize?)
      => ComCall(90, this.p, Int64, Module, UInt32, TypeId, Int64, Value, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetFieldNameWide(Module, TypeId, FieldIndex, NameBuffer?, NameSize?)
      => ComCall(91, this.p, Int64, Module, UInt32, TypeId, UInt32, FieldIndex, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    IsManagedModule(Index, Base)
      => ComCall(92, this.p, UInt32, Index, Int64, Base)
    GetModuleByModuleName2(Name, StartIndex, Flags, Index?, Base?)
      => ComCall(93, this.p, PSTR, Name, UInt32, StartIndex, UInt32, Flags, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleByModuleName2Wide(Name, StartIndex, Flags, Index?, Base?)
      => ComCall(94, this.p, "Str", Name, UInt32, StartIndex, UInt32, Flags, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleByOffset2(Offset, StartIndex, Flags, Index?, Base?)
      => ComCall(95, this.p, Int64, Offset, UInt32, StartIndex, UInt32, Flags, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    AddSyntheticModule(Base, Size, ImagePath, ModuleName, Flags)
      => ComCall(96, this.p, Int64, Base, UInt32, Size, PSTR, ImagePath, PSTR, ModuleName, UInt32, Flags)
    AddSyntheticModuleWide(Base, Size, ImagePath, ModuleName, Flags)
      => ComCall(97, this.p, Int64, Base, UInt32, Size, "Str", ImagePath, "Str", ModuleName, UInt32, Flags)
    RemoveSyntheticModule(Base)
      => ComCall(98, this.p, Int64, Base)
    GetCurrentScopeFrameIndex(Index)
      => ComCall(99, this.p, UInt32.Ptr, Index)
    SetScopeFrameByIndex(Index)
      => ComCall(100, this.p, UInt32, Index)
    SetScopeFromJitDebugInfo(OutputControl, InfoOffset)
      => ComCall(101, this.p, UInt32, OutputControl, Int64, InfoOffset)
    SetScopeFromStoredEvent()
      => ComCall(102, this.p)
    OutputSymbolByOffset(OutputControl, Flags, Offset)
      => ComCall(103, this.p, UInt32, OutputControl, UInt32, Flags, Int64, Offset)
    GetFunctionEntryByOffset(Offset, Flags, Buffer?, BufferNeeded?)
      => ComCall(104, this.p, Int64, Offset, UInt32, Flags, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, BufferNeeded?)
    GetFieldTypeAndOffset(Module, ContainerTypeId, Field, FieldTypeId?, Offset?)
      => ComCall(105, this.p, Int64, Module, UInt32, ContainerTypeId, PSTR, Field, UInt32.Ptr, FieldTypeId?, UInt32.Ptr, Offset?)
    GetFieldTypeAndOffsetWide(Module, ContainerTypeId, Field, FieldTypeId?, Offset?)
      => ComCall(106, this.p, Int64, Module, UInt32, ContainerTypeId, "Str", Field, UInt32.Ptr, FieldTypeId?, UInt32.Ptr, Offset?)
    AddSyntheticSymbol(Offset, Size, Name, Flags, Id?)
      => ComCall(107, this.p, Int64, Offset, UInt32, Size, PSTR, Name, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Id?)
    AddSyntheticSymbolWide(Offset, Size, Name, Flags, Id?)
      => ComCall(108, this.p, Int64, Offset, UInt32, Size, "Str", Name, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Id?)
    RemoveSyntheticSymbol(Id)
      => ComCall(109, this.p, DEBUG_MODULE_AND_ID.Ptr, Id)
    GetSymbolEntriesByOffset(Offset, Flags, Ids?, Displacements?, Entries?)
      => ComCall(110, this.p, Int64, Offset, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Ids?, Int64.Ptr, Displacements?, UInt32, Displacements?.Length ?? 0, UInt32.Ptr, Entries?)
    GetSymbolEntriesByName(Symbol, Flags, Ids?, Entries?)
      => ComCall(111, this.p, PSTR, Symbol, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, Entries?)
    GetSymbolEntriesByNameWide(Symbol, Flags, Ids?, Entries?)
      => ComCall(112, this.p, "Str", Symbol, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, Entries?)
    GetSymbolEntryByToken(ModuleBase, Token, Id)
      => ComCall(113, this.p, Int64, ModuleBase, UInt32, Token, DEBUG_MODULE_AND_ID.Ptr, Id)
    GetSymbolEntryInformation(Id, Info)
      => ComCall(114, this.p, DEBUG_MODULE_AND_ID.Ptr, Id, DEBUG_SYMBOL_ENTRY.Ptr, Info)
    GetSymbolEntryString(Id, Which, Buffer?, StringSize?)
      => ComCall(115, this.p, DEBUG_MODULE_AND_ID.Ptr, Id, UInt32, Which, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSymbolEntryStringWide(Id, Which, Buffer?, StringSize?)
      => ComCall(116, this.p, DEBUG_MODULE_AND_ID.Ptr, Id, UInt32, Which, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSymbolEntryOffsetRegions(Id, Flags, Regions?, RegionsAvail?)
      => ComCall(117, this.p, DEBUG_MODULE_AND_ID.Ptr, Id, UInt32, Flags, DEBUG_OFFSET_REGION.Ptr, Regions?, UInt32, Regions?.Length ?? 0, UInt32.Ptr, RegionsAvail?)
    GetSymbolEntryBySymbolEntry(FromId, Flags, ToId)
      => ComCall(118, this.p, DEBUG_MODULE_AND_ID.Ptr, FromId, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, ToId)
    GetSourceEntriesByOffset(Offset, Flags, Entries?, EntriesAvail?)
      => ComCall(119, this.p, Int64, Offset, UInt32, Flags, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entries?, UInt32, Entries?.Length ?? 0, UInt32.Ptr, EntriesAvail?)
    GetSourceEntriesByLine(Line, File, Flags, Entries?, EntriesAvail?)
      => ComCall(120, this.p, UInt32, Line, PSTR, File, UInt32, Flags, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entries?, UInt32, Entries?.Length ?? 0, UInt32.Ptr, EntriesAvail?)
    GetSourceEntriesByLineWide(Line, File, Flags, Entries?, EntriesAvail?)
      => ComCall(121, this.p, UInt32, Line, "Str", File, UInt32, Flags, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entries?, UInt32, Entries?.Length ?? 0, UInt32.Ptr, EntriesAvail?)
    GetSourceEntryString(Entry, Which, Buffer?, StringSize?)
      => ComCall(122, this.p, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entry, UInt32, Which, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSourceEntryStringWide(Entry, Which, Buffer?, StringSize?)
      => ComCall(123, this.p, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entry, UInt32, Which, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSourceEntryOffsetRegions(Entry, Flags, Regions?, RegionsAvail?)
      => ComCall(124, this.p, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entry, UInt32, Flags, DEBUG_OFFSET_REGION.Ptr, Regions?, UInt32, Regions?.Length ?? 0, UInt32.Ptr, RegionsAvail?)
    GetSourceEntryBySourceEntry(FromEntry, Flags, ToEntry)
      => ComCall(125, this.p, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, FromEntry, UInt32, Flags, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, ToEntry)
}
struct IDebugSymbols4 extends IUnknown {
    static IID := "{E391BBD8-9D8C-4418-840B-C006592A1752}"
    GetSymbolOptions(Options)
      => ComCall(3, this.p, UInt32.Ptr, Options)
    AddSymbolOptions(Options)
      => ComCall(4, this.p, UInt32, Options)
    RemoveSymbolOptions(Options)
      => ComCall(5, this.p, UInt32, Options)
    SetSymbolOptions(Options)
      => ComCall(6, this.p, UInt32, Options)
    GetNameByOffset(Offset, NameBuffer?, NameSize?, Displacement?)
      => ComCall(7, this.p, Int64, Offset, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetOffsetByName(Symbol, Offset)
      => ComCall(8, this.p, PSTR, Symbol, Int64.Ptr, Offset)
    GetNearNameByOffset(Offset, Delta, NameBuffer?, NameSize?, Displacement?)
      => ComCall(9, this.p, Int64, Offset, Int32, Delta, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetLineByOffset(Offset, Line?, FileBuffer?, FileSize?, Displacement?)
      => ComCall(10, this.p, Int64, Offset, UInt32.Ptr, Line?, PSTR, FileBuffer?, UInt32, FileBuffer?.Length ?? 0, UInt32.Ptr, FileSize?, Int64.Ptr, Displacement?)
    GetOffsetByLine(Line, File, Offset)
      => ComCall(11, this.p, UInt32, Line, PSTR, File, Int64.Ptr, Offset)
    GetNumberModules(Loaded, Unloaded)
      => ComCall(12, this.p, UInt32.Ptr, Loaded, UInt32.Ptr, Unloaded)
    GetModuleByIndex(Index, Base)
      => ComCall(13, this.p, UInt32, Index, Int64.Ptr, Base)
    GetModuleByModuleName(Name, StartIndex, Index?, Base?)
      => ComCall(14, this.p, PSTR, Name, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleByOffset(Offset, StartIndex, Index?, Base?)
      => ComCall(15, this.p, Int64, Offset, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleNames(Index, Base, ImageNameBuffer?, ImageNameSize?, ModuleNameBuffer?, ModuleNameSize?, LoadedImageNameBuffer?, LoadedImageNameSize?)
      => ComCall(16, this.p, UInt32, Index, Int64, Base, PSTR, ImageNameBuffer?, UInt32, ImageNameBuffer?.Length ?? 0, UInt32.Ptr, ImageNameSize?, PSTR, ModuleNameBuffer?, UInt32, ModuleNameBuffer?.Length ?? 0, UInt32.Ptr, ModuleNameSize?, PSTR, LoadedImageNameBuffer?, UInt32, LoadedImageNameBuffer?.Length ?? 0, UInt32.Ptr, LoadedImageNameSize?)
    GetModuleParameters(Bases?, Start, Params)
      => ComCall(17, this.p, UInt32, Params.Length, Int64.Ptr, Bases?, UInt32, Start, DEBUG_MODULE_PARAMETERS.Ptr, Params)
    GetSymbolModule(Symbol, Base)
      => ComCall(18, this.p, PSTR, Symbol, Int64.Ptr, Base)
    GetTypeName(Module, TypeId, NameBuffer?, NameSize?)
      => ComCall(19, this.p, Int64, Module, UInt32, TypeId, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetTypeId(Module, Name, TypeId)
      => ComCall(20, this.p, Int64, Module, PSTR, Name, UInt32.Ptr, TypeId)
    GetTypeSize(Module, TypeId, Size)
      => ComCall(21, this.p, Int64, Module, UInt32, TypeId, UInt32.Ptr, Size)
    GetFieldOffset(Module, TypeId, Field, Offset)
      => ComCall(22, this.p, Int64, Module, UInt32, TypeId, PSTR, Field, UInt32.Ptr, Offset)
    GetSymbolTypeId(Symbol, TypeId, Module?)
      => ComCall(23, this.p, PSTR, Symbol, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    GetOffsetTypeId(Offset, TypeId, Module?)
      => ComCall(24, this.p, Int64, Offset, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    ReadTypedDataVirtual(Offset, Module, TypeId, Buffer, BytesRead?)
      => ComCall(25, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteTypedDataVirtual(Offset, Module, TypeId, Buffer, BytesWritten?)
      => ComCall(26, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    OutputTypedDataVirtual(OutputControl, Offset, Module, TypeId, Flags)
      => ComCall(27, this.p, UInt32, OutputControl, Int64, Offset, Int64, Module, UInt32, TypeId, UInt32, Flags)
    ReadTypedDataPhysical(Offset, Module, TypeId, Buffer, BytesRead?)
      => ComCall(28, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteTypedDataPhysical(Offset, Module, TypeId, Buffer, BytesWritten?)
      => ComCall(29, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    OutputTypedDataPhysical(OutputControl, Offset, Module, TypeId, Flags)
      => ComCall(30, this.p, UInt32, OutputControl, Int64, Offset, Int64, Module, UInt32, TypeId, UInt32, Flags)
    GetScope(InstructionOffset?, ScopeFrame?, ScopeContext?)
      => ComCall(31, this.p, Int64.Ptr, InstructionOffset?, DEBUG_STACK_FRAME.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    SetScope(InstructionOffset, ScopeFrame?, ScopeContext?)
      => ComCall(32, this.p, Int64, InstructionOffset, DEBUG_STACK_FRAME.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    ResetScope()
      => ComCall(33, this.p)
    GetScopeSymbolGroup(Flags, Update?, Symbols)
      => ComCall(34, this.p, UInt32, Flags, IDebugSymbolGroup, Update?, IDebugSymbolGroup.Ptr, Symbols)
    CreateSymbolGroup(Group)
      => ComCall(35, this.p, IDebugSymbolGroup.Ptr, Group)
    StartSymbolMatch(Pattern, Handle)
      => ComCall(36, this.p, PSTR, Pattern, Int64.Ptr, Handle)
    GetNextSymbolMatch(Handle, Buffer?, MatchSize?, Offset?)
      => ComCall(37, this.p, Int64, Handle, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MatchSize?, Int64.Ptr, Offset?)
    EndSymbolMatch(Handle)
      => ComCall(38, this.p, Int64, Handle)
    Reload(Module)
      => ComCall(39, this.p, PSTR, Module)
    GetSymbolPath(Buffer?, PathSize?)
      => ComCall(40, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetSymbolPath(Path)
      => ComCall(41, this.p, PSTR, Path)
    AppendSymbolPath(Addition)
      => ComCall(42, this.p, PSTR, Addition)
    GetImagePath(Buffer?, PathSize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetImagePath(Path)
      => ComCall(44, this.p, PSTR, Path)
    AppendImagePath(Addition)
      => ComCall(45, this.p, PSTR, Addition)
    GetSourcePath(Buffer?, PathSize?)
      => ComCall(46, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    GetSourcePathElement(Index, Buffer?, ElementSize?)
      => ComCall(47, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ElementSize?)
    SetSourcePath(Path)
      => ComCall(48, this.p, PSTR, Path)
    AppendSourcePath(Addition)
      => ComCall(49, this.p, PSTR, Addition)
    FindSourceFile(StartElement, File, Flags, FoundElement?, Buffer?, FoundSize?)
      => ComCall(50, this.p, UInt32, StartElement, PSTR, File, UInt32, Flags, UInt32.Ptr, FoundElement?, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSourceFileLineOffsets(File, Buffer?, FileLines?)
      => ComCall(51, this.p, PSTR, File, Int64.Ptr, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileLines?)
    GetModuleVersionInformation(Index, Base, Item, Buffer?, VerInfoSize?)
      => ComCall(52, this.p, UInt32, Index, Int64, Base, PSTR, Item, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, VerInfoSize?)
    GetModuleNameString(Which, Index, Base, Buffer?, NameSize?)
      => ComCall(53, this.p, UInt32, Which, UInt32, Index, Int64, Base, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetConstantName(Module, TypeId, Value, NameBuffer?, NameSize?)
      => ComCall(54, this.p, Int64, Module, UInt32, TypeId, Int64, Value, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetFieldName(Module, TypeId, FieldIndex, NameBuffer?, NameSize?)
      => ComCall(55, this.p, Int64, Module, UInt32, TypeId, UInt32, FieldIndex, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetTypeOptions(Options)
      => ComCall(56, this.p, UInt32.Ptr, Options)
    AddTypeOptions(Options)
      => ComCall(57, this.p, UInt32, Options)
    RemoveTypeOptions(Options)
      => ComCall(58, this.p, UInt32, Options)
    SetTypeOptions(Options)
      => ComCall(59, this.p, UInt32, Options)
    GetNameByOffsetWide(Offset, NameBuffer?, NameSize?, Displacement?)
      => ComCall(60, this.p, Int64, Offset, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetOffsetByNameWide(Symbol, Offset)
      => ComCall(61, this.p, "Str", Symbol, Int64.Ptr, Offset)
    GetNearNameByOffsetWide(Offset, Delta, NameBuffer?, NameSize?, Displacement?)
      => ComCall(62, this.p, Int64, Offset, Int32, Delta, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetLineByOffsetWide(Offset, Line?, FileBuffer?, FileSize?, Displacement?)
      => ComCall(63, this.p, Int64, Offset, UInt32.Ptr, Line?, PWSTR, FileBuffer?, UInt32, FileBuffer?.Length ?? 0, UInt32.Ptr, FileSize?, Int64.Ptr, Displacement?)
    GetOffsetByLineWide(Line, File, Offset)
      => ComCall(64, this.p, UInt32, Line, "Str", File, Int64.Ptr, Offset)
    GetModuleByModuleNameWide(Name, StartIndex, Index?, Base?)
      => ComCall(65, this.p, "Str", Name, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetSymbolModuleWide(Symbol, Base)
      => ComCall(66, this.p, "Str", Symbol, Int64.Ptr, Base)
    GetTypeNameWide(Module, TypeId, NameBuffer?, NameSize?)
      => ComCall(67, this.p, Int64, Module, UInt32, TypeId, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetTypeIdWide(Module, Name, TypeId)
      => ComCall(68, this.p, Int64, Module, "Str", Name, UInt32.Ptr, TypeId)
    GetFieldOffsetWide(Module, TypeId, Field, Offset)
      => ComCall(69, this.p, Int64, Module, UInt32, TypeId, "Str", Field, UInt32.Ptr, Offset)
    GetSymbolTypeIdWide(Symbol, TypeId, Module?)
      => ComCall(70, this.p, "Str", Symbol, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    GetScopeSymbolGroup2(Flags, Update?, Symbols)
      => ComCall(71, this.p, UInt32, Flags, IDebugSymbolGroup2, Update?, IDebugSymbolGroup2.Ptr, Symbols)
    CreateSymbolGroup2(Group)
      => ComCall(72, this.p, IDebugSymbolGroup2.Ptr, Group)
    StartSymbolMatchWide(Pattern, Handle)
      => ComCall(73, this.p, "Str", Pattern, Int64.Ptr, Handle)
    GetNextSymbolMatchWide(Handle, Buffer?, MatchSize?, Offset?)
      => ComCall(74, this.p, Int64, Handle, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MatchSize?, Int64.Ptr, Offset?)
    ReloadWide(Module)
      => ComCall(75, this.p, "Str", Module)
    GetSymbolPathWide(Buffer?, PathSize?)
      => ComCall(76, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetSymbolPathWide(Path)
      => ComCall(77, this.p, "Str", Path)
    AppendSymbolPathWide(Addition)
      => ComCall(78, this.p, "Str", Addition)
    GetImagePathWide(Buffer?, PathSize?)
      => ComCall(79, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetImagePathWide(Path)
      => ComCall(80, this.p, "Str", Path)
    AppendImagePathWide(Addition)
      => ComCall(81, this.p, "Str", Addition)
    GetSourcePathWide(Buffer?, PathSize?)
      => ComCall(82, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    GetSourcePathElementWide(Index, Buffer?, ElementSize?)
      => ComCall(83, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ElementSize?)
    SetSourcePathWide(Path)
      => ComCall(84, this.p, "Str", Path)
    AppendSourcePathWide(Addition)
      => ComCall(85, this.p, "Str", Addition)
    FindSourceFileWide(StartElement, File, Flags, FoundElement?, Buffer?, FoundSize?)
      => ComCall(86, this.p, UInt32, StartElement, "Str", File, UInt32, Flags, UInt32.Ptr, FoundElement?, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSourceFileLineOffsetsWide(File, Buffer?, FileLines?)
      => ComCall(87, this.p, "Str", File, Int64.Ptr, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileLines?)
    GetModuleVersionInformationWide(Index, Base, Item, Buffer?, VerInfoSize?)
      => ComCall(88, this.p, UInt32, Index, Int64, Base, "Str", Item, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, VerInfoSize?)
    GetModuleNameStringWide(Which, Index, Base, Buffer?, NameSize?)
      => ComCall(89, this.p, UInt32, Which, UInt32, Index, Int64, Base, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetConstantNameWide(Module, TypeId, Value, NameBuffer?, NameSize?)
      => ComCall(90, this.p, Int64, Module, UInt32, TypeId, Int64, Value, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetFieldNameWide(Module, TypeId, FieldIndex, NameBuffer?, NameSize?)
      => ComCall(91, this.p, Int64, Module, UInt32, TypeId, UInt32, FieldIndex, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    IsManagedModule(Index, Base)
      => ComCall(92, this.p, UInt32, Index, Int64, Base)
    GetModuleByModuleName2(Name, StartIndex, Flags, Index?, Base?)
      => ComCall(93, this.p, PSTR, Name, UInt32, StartIndex, UInt32, Flags, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleByModuleName2Wide(Name, StartIndex, Flags, Index?, Base?)
      => ComCall(94, this.p, "Str", Name, UInt32, StartIndex, UInt32, Flags, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleByOffset2(Offset, StartIndex, Flags, Index?, Base?)
      => ComCall(95, this.p, Int64, Offset, UInt32, StartIndex, UInt32, Flags, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    AddSyntheticModule(Base, Size, ImagePath, ModuleName, Flags)
      => ComCall(96, this.p, Int64, Base, UInt32, Size, PSTR, ImagePath, PSTR, ModuleName, UInt32, Flags)
    AddSyntheticModuleWide(Base, Size, ImagePath, ModuleName, Flags)
      => ComCall(97, this.p, Int64, Base, UInt32, Size, "Str", ImagePath, "Str", ModuleName, UInt32, Flags)
    RemoveSyntheticModule(Base)
      => ComCall(98, this.p, Int64, Base)
    GetCurrentScopeFrameIndex(Index)
      => ComCall(99, this.p, UInt32.Ptr, Index)
    SetScopeFrameByIndex(Index)
      => ComCall(100, this.p, UInt32, Index)
    SetScopeFromJitDebugInfo(OutputControl, InfoOffset)
      => ComCall(101, this.p, UInt32, OutputControl, Int64, InfoOffset)
    SetScopeFromStoredEvent()
      => ComCall(102, this.p)
    OutputSymbolByOffset(OutputControl, Flags, Offset)
      => ComCall(103, this.p, UInt32, OutputControl, UInt32, Flags, Int64, Offset)
    GetFunctionEntryByOffset(Offset, Flags, Buffer?, BufferNeeded?)
      => ComCall(104, this.p, Int64, Offset, UInt32, Flags, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, BufferNeeded?)
    GetFieldTypeAndOffset(Module, ContainerTypeId, Field, FieldTypeId?, Offset?)
      => ComCall(105, this.p, Int64, Module, UInt32, ContainerTypeId, PSTR, Field, UInt32.Ptr, FieldTypeId?, UInt32.Ptr, Offset?)
    GetFieldTypeAndOffsetWide(Module, ContainerTypeId, Field, FieldTypeId?, Offset?)
      => ComCall(106, this.p, Int64, Module, UInt32, ContainerTypeId, "Str", Field, UInt32.Ptr, FieldTypeId?, UInt32.Ptr, Offset?)
    AddSyntheticSymbol(Offset, Size, Name, Flags, Id?)
      => ComCall(107, this.p, Int64, Offset, UInt32, Size, PSTR, Name, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Id?)
    AddSyntheticSymbolWide(Offset, Size, Name, Flags, Id?)
      => ComCall(108, this.p, Int64, Offset, UInt32, Size, "Str", Name, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Id?)
    RemoveSyntheticSymbol(Id)
      => ComCall(109, this.p, DEBUG_MODULE_AND_ID.Ptr, Id)
    GetSymbolEntriesByOffset(Offset, Flags, Ids?, Displacements?, Entries?)
      => ComCall(110, this.p, Int64, Offset, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Ids?, Int64.Ptr, Displacements?, UInt32, Displacements?.Length ?? 0, UInt32.Ptr, Entries?)
    GetSymbolEntriesByName(Symbol, Flags, Ids?, Entries?)
      => ComCall(111, this.p, PSTR, Symbol, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, Entries?)
    GetSymbolEntriesByNameWide(Symbol, Flags, Ids?, Entries?)
      => ComCall(112, this.p, "Str", Symbol, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, Entries?)
    GetSymbolEntryByToken(ModuleBase, Token, Id)
      => ComCall(113, this.p, Int64, ModuleBase, UInt32, Token, DEBUG_MODULE_AND_ID.Ptr, Id)
    GetSymbolEntryInformation(Id, Info)
      => ComCall(114, this.p, DEBUG_MODULE_AND_ID.Ptr, Id, DEBUG_SYMBOL_ENTRY.Ptr, Info)
    GetSymbolEntryString(Id, Which, Buffer?, StringSize?)
      => ComCall(115, this.p, DEBUG_MODULE_AND_ID.Ptr, Id, UInt32, Which, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSymbolEntryStringWide(Id, Which, Buffer?, StringSize?)
      => ComCall(116, this.p, DEBUG_MODULE_AND_ID.Ptr, Id, UInt32, Which, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSymbolEntryOffsetRegions(Id, Flags, Regions?, RegionsAvail?)
      => ComCall(117, this.p, DEBUG_MODULE_AND_ID.Ptr, Id, UInt32, Flags, DEBUG_OFFSET_REGION.Ptr, Regions?, UInt32, Regions?.Length ?? 0, UInt32.Ptr, RegionsAvail?)
    GetSymbolEntryBySymbolEntry(FromId, Flags, ToId)
      => ComCall(118, this.p, DEBUG_MODULE_AND_ID.Ptr, FromId, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, ToId)
    GetSourceEntriesByOffset(Offset, Flags, Entries?, EntriesAvail?)
      => ComCall(119, this.p, Int64, Offset, UInt32, Flags, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entries?, UInt32, Entries?.Length ?? 0, UInt32.Ptr, EntriesAvail?)
    GetSourceEntriesByLine(Line, File, Flags, Entries?, EntriesAvail?)
      => ComCall(120, this.p, UInt32, Line, PSTR, File, UInt32, Flags, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entries?, UInt32, Entries?.Length ?? 0, UInt32.Ptr, EntriesAvail?)
    GetSourceEntriesByLineWide(Line, File, Flags, Entries?, EntriesAvail?)
      => ComCall(121, this.p, UInt32, Line, "Str", File, UInt32, Flags, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entries?, UInt32, Entries?.Length ?? 0, UInt32.Ptr, EntriesAvail?)
    GetSourceEntryString(Entry, Which, Buffer?, StringSize?)
      => ComCall(122, this.p, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entry, UInt32, Which, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSourceEntryStringWide(Entry, Which, Buffer?, StringSize?)
      => ComCall(123, this.p, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entry, UInt32, Which, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSourceEntryOffsetRegions(Entry, Flags, Regions?, RegionsAvail?)
      => ComCall(124, this.p, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entry, UInt32, Flags, DEBUG_OFFSET_REGION.Ptr, Regions?, UInt32, Regions?.Length ?? 0, UInt32.Ptr, RegionsAvail?)
    GetSourceEntryBySourceEntry(FromEntry, Flags, ToEntry)
      => ComCall(125, this.p, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, FromEntry, UInt32, Flags, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, ToEntry)
    GetScopeEx(InstructionOffset?, ScopeFrame?, ScopeContext?)
      => ComCall(126, this.p, Int64.Ptr, InstructionOffset?, DEBUG_STACK_FRAME_EX.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    SetScopeEx(InstructionOffset, ScopeFrame?, ScopeContext?)
      => ComCall(127, this.p, Int64, InstructionOffset, DEBUG_STACK_FRAME_EX.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    GetNameByInlineContext(Offset, InlineContext, NameBuffer?, NameSize?, Displacement?)
      => ComCall(128, this.p, Int64, Offset, UInt32, InlineContext, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetNameByInlineContextWide(Offset, InlineContext, NameBuffer?, NameSize?, Displacement?)
      => ComCall(129, this.p, Int64, Offset, UInt32, InlineContext, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetLineByInlineContext(Offset, InlineContext, Line?, FileBuffer?, FileSize?, Displacement?)
      => ComCall(130, this.p, Int64, Offset, UInt32, InlineContext, UInt32.Ptr, Line?, PSTR, FileBuffer?, UInt32, FileBuffer?.Length ?? 0, UInt32.Ptr, FileSize?, Int64.Ptr, Displacement?)
    GetLineByInlineContextWide(Offset, InlineContext, Line?, FileBuffer?, FileSize?, Displacement?)
      => ComCall(131, this.p, Int64, Offset, UInt32, InlineContext, UInt32.Ptr, Line?, PWSTR, FileBuffer?, UInt32, FileBuffer?.Length ?? 0, UInt32.Ptr, FileSize?, Int64.Ptr, Displacement?)
    OutputSymbolByInlineContext(OutputControl, Flags, Offset, InlineContext)
      => ComCall(132, this.p, UInt32, OutputControl, UInt32, Flags, Int64, Offset, UInt32, InlineContext)
}
struct IDebugSymbols5 extends IUnknown {
    static IID := "{C65FA83E-1E69-475E-8E0E-B5D79E9CC17E}"
    GetSymbolOptions(Options)
      => ComCall(3, this.p, UInt32.Ptr, Options)
    AddSymbolOptions(Options)
      => ComCall(4, this.p, UInt32, Options)
    RemoveSymbolOptions(Options)
      => ComCall(5, this.p, UInt32, Options)
    SetSymbolOptions(Options)
      => ComCall(6, this.p, UInt32, Options)
    GetNameByOffset(Offset, NameBuffer?, NameSize?, Displacement?)
      => ComCall(7, this.p, Int64, Offset, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetOffsetByName(Symbol, Offset)
      => ComCall(8, this.p, PSTR, Symbol, Int64.Ptr, Offset)
    GetNearNameByOffset(Offset, Delta, NameBuffer?, NameSize?, Displacement?)
      => ComCall(9, this.p, Int64, Offset, Int32, Delta, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetLineByOffset(Offset, Line?, FileBuffer?, FileSize?, Displacement?)
      => ComCall(10, this.p, Int64, Offset, UInt32.Ptr, Line?, PSTR, FileBuffer?, UInt32, FileBuffer?.Length ?? 0, UInt32.Ptr, FileSize?, Int64.Ptr, Displacement?)
    GetOffsetByLine(Line, File, Offset)
      => ComCall(11, this.p, UInt32, Line, PSTR, File, Int64.Ptr, Offset)
    GetNumberModules(Loaded, Unloaded)
      => ComCall(12, this.p, UInt32.Ptr, Loaded, UInt32.Ptr, Unloaded)
    GetModuleByIndex(Index, Base)
      => ComCall(13, this.p, UInt32, Index, Int64.Ptr, Base)
    GetModuleByModuleName(Name, StartIndex, Index?, Base?)
      => ComCall(14, this.p, PSTR, Name, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleByOffset(Offset, StartIndex, Index?, Base?)
      => ComCall(15, this.p, Int64, Offset, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleNames(Index, Base, ImageNameBuffer?, ImageNameSize?, ModuleNameBuffer?, ModuleNameSize?, LoadedImageNameBuffer?, LoadedImageNameSize?)
      => ComCall(16, this.p, UInt32, Index, Int64, Base, PSTR, ImageNameBuffer?, UInt32, ImageNameBuffer?.Length ?? 0, UInt32.Ptr, ImageNameSize?, PSTR, ModuleNameBuffer?, UInt32, ModuleNameBuffer?.Length ?? 0, UInt32.Ptr, ModuleNameSize?, PSTR, LoadedImageNameBuffer?, UInt32, LoadedImageNameBuffer?.Length ?? 0, UInt32.Ptr, LoadedImageNameSize?)
    GetModuleParameters(Bases?, Start, Params)
      => ComCall(17, this.p, UInt32, Params.Length, Int64.Ptr, Bases?, UInt32, Start, DEBUG_MODULE_PARAMETERS.Ptr, Params)
    GetSymbolModule(Symbol, Base)
      => ComCall(18, this.p, PSTR, Symbol, Int64.Ptr, Base)
    GetTypeName(Module, TypeId, NameBuffer?, NameSize?)
      => ComCall(19, this.p, Int64, Module, UInt32, TypeId, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetTypeId(Module, Name, TypeId)
      => ComCall(20, this.p, Int64, Module, PSTR, Name, UInt32.Ptr, TypeId)
    GetTypeSize(Module, TypeId, Size)
      => ComCall(21, this.p, Int64, Module, UInt32, TypeId, UInt32.Ptr, Size)
    GetFieldOffset(Module, TypeId, Field, Offset)
      => ComCall(22, this.p, Int64, Module, UInt32, TypeId, PSTR, Field, UInt32.Ptr, Offset)
    GetSymbolTypeId(Symbol, TypeId, Module?)
      => ComCall(23, this.p, PSTR, Symbol, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    GetOffsetTypeId(Offset, TypeId, Module?)
      => ComCall(24, this.p, Int64, Offset, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    ReadTypedDataVirtual(Offset, Module, TypeId, Buffer, BytesRead?)
      => ComCall(25, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteTypedDataVirtual(Offset, Module, TypeId, Buffer, BytesWritten?)
      => ComCall(26, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    OutputTypedDataVirtual(OutputControl, Offset, Module, TypeId, Flags)
      => ComCall(27, this.p, UInt32, OutputControl, Int64, Offset, Int64, Module, UInt32, TypeId, UInt32, Flags)
    ReadTypedDataPhysical(Offset, Module, TypeId, Buffer, BytesRead?)
      => ComCall(28, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesRead?)
    WriteTypedDataPhysical(Offset, Module, TypeId, Buffer, BytesWritten?)
      => ComCall(29, this.p, Int64, Offset, Int64, Module, UInt32, TypeId, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32.Ptr, BytesWritten?)
    OutputTypedDataPhysical(OutputControl, Offset, Module, TypeId, Flags)
      => ComCall(30, this.p, UInt32, OutputControl, Int64, Offset, Int64, Module, UInt32, TypeId, UInt32, Flags)
    GetScope(InstructionOffset?, ScopeFrame?, ScopeContext?)
      => ComCall(31, this.p, Int64.Ptr, InstructionOffset?, DEBUG_STACK_FRAME.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    SetScope(InstructionOffset, ScopeFrame?, ScopeContext?)
      => ComCall(32, this.p, Int64, InstructionOffset, DEBUG_STACK_FRAME.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    ResetScope()
      => ComCall(33, this.p)
    GetScopeSymbolGroup(Flags, Update?, Symbols)
      => ComCall(34, this.p, UInt32, Flags, IDebugSymbolGroup, Update?, IDebugSymbolGroup.Ptr, Symbols)
    CreateSymbolGroup(Group)
      => ComCall(35, this.p, IDebugSymbolGroup.Ptr, Group)
    StartSymbolMatch(Pattern, Handle)
      => ComCall(36, this.p, PSTR, Pattern, Int64.Ptr, Handle)
    GetNextSymbolMatch(Handle, Buffer?, MatchSize?, Offset?)
      => ComCall(37, this.p, Int64, Handle, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MatchSize?, Int64.Ptr, Offset?)
    EndSymbolMatch(Handle)
      => ComCall(38, this.p, Int64, Handle)
    Reload(Module)
      => ComCall(39, this.p, PSTR, Module)
    GetSymbolPath(Buffer?, PathSize?)
      => ComCall(40, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetSymbolPath(Path)
      => ComCall(41, this.p, PSTR, Path)
    AppendSymbolPath(Addition)
      => ComCall(42, this.p, PSTR, Addition)
    GetImagePath(Buffer?, PathSize?)
      => ComCall(43, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetImagePath(Path)
      => ComCall(44, this.p, PSTR, Path)
    AppendImagePath(Addition)
      => ComCall(45, this.p, PSTR, Addition)
    GetSourcePath(Buffer?, PathSize?)
      => ComCall(46, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    GetSourcePathElement(Index, Buffer?, ElementSize?)
      => ComCall(47, this.p, UInt32, Index, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ElementSize?)
    SetSourcePath(Path)
      => ComCall(48, this.p, PSTR, Path)
    AppendSourcePath(Addition)
      => ComCall(49, this.p, PSTR, Addition)
    FindSourceFile(StartElement, File, Flags, FoundElement?, Buffer?, FoundSize?)
      => ComCall(50, this.p, UInt32, StartElement, PSTR, File, UInt32, Flags, UInt32.Ptr, FoundElement?, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSourceFileLineOffsets(File, Buffer?, FileLines?)
      => ComCall(51, this.p, PSTR, File, Int64.Ptr, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileLines?)
    GetModuleVersionInformation(Index, Base, Item, Buffer?, VerInfoSize?)
      => ComCall(52, this.p, UInt32, Index, Int64, Base, PSTR, Item, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, VerInfoSize?)
    GetModuleNameString(Which, Index, Base, Buffer?, NameSize?)
      => ComCall(53, this.p, UInt32, Which, UInt32, Index, Int64, Base, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetConstantName(Module, TypeId, Value, NameBuffer?, NameSize?)
      => ComCall(54, this.p, Int64, Module, UInt32, TypeId, Int64, Value, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetFieldName(Module, TypeId, FieldIndex, NameBuffer?, NameSize?)
      => ComCall(55, this.p, Int64, Module, UInt32, TypeId, UInt32, FieldIndex, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetTypeOptions(Options)
      => ComCall(56, this.p, UInt32.Ptr, Options)
    AddTypeOptions(Options)
      => ComCall(57, this.p, UInt32, Options)
    RemoveTypeOptions(Options)
      => ComCall(58, this.p, UInt32, Options)
    SetTypeOptions(Options)
      => ComCall(59, this.p, UInt32, Options)
    GetNameByOffsetWide(Offset, NameBuffer?, NameSize?, Displacement?)
      => ComCall(60, this.p, Int64, Offset, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetOffsetByNameWide(Symbol, Offset)
      => ComCall(61, this.p, "Str", Symbol, Int64.Ptr, Offset)
    GetNearNameByOffsetWide(Offset, Delta, NameBuffer?, NameSize?, Displacement?)
      => ComCall(62, this.p, Int64, Offset, Int32, Delta, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetLineByOffsetWide(Offset, Line?, FileBuffer?, FileSize?, Displacement?)
      => ComCall(63, this.p, Int64, Offset, UInt32.Ptr, Line?, PWSTR, FileBuffer?, UInt32, FileBuffer?.Length ?? 0, UInt32.Ptr, FileSize?, Int64.Ptr, Displacement?)
    GetOffsetByLineWide(Line, File, Offset)
      => ComCall(64, this.p, UInt32, Line, "Str", File, Int64.Ptr, Offset)
    GetModuleByModuleNameWide(Name, StartIndex, Index?, Base?)
      => ComCall(65, this.p, "Str", Name, UInt32, StartIndex, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetSymbolModuleWide(Symbol, Base)
      => ComCall(66, this.p, "Str", Symbol, Int64.Ptr, Base)
    GetTypeNameWide(Module, TypeId, NameBuffer?, NameSize?)
      => ComCall(67, this.p, Int64, Module, UInt32, TypeId, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetTypeIdWide(Module, Name, TypeId)
      => ComCall(68, this.p, Int64, Module, "Str", Name, UInt32.Ptr, TypeId)
    GetFieldOffsetWide(Module, TypeId, Field, Offset)
      => ComCall(69, this.p, Int64, Module, UInt32, TypeId, "Str", Field, UInt32.Ptr, Offset)
    GetSymbolTypeIdWide(Symbol, TypeId, Module?)
      => ComCall(70, this.p, "Str", Symbol, UInt32.Ptr, TypeId, Int64.Ptr, Module?)
    GetScopeSymbolGroup2(Flags, Update?, Symbols)
      => ComCall(71, this.p, UInt32, Flags, IDebugSymbolGroup2, Update?, IDebugSymbolGroup2.Ptr, Symbols)
    CreateSymbolGroup2(Group)
      => ComCall(72, this.p, IDebugSymbolGroup2.Ptr, Group)
    StartSymbolMatchWide(Pattern, Handle)
      => ComCall(73, this.p, "Str", Pattern, Int64.Ptr, Handle)
    GetNextSymbolMatchWide(Handle, Buffer?, MatchSize?, Offset?)
      => ComCall(74, this.p, Int64, Handle, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, MatchSize?, Int64.Ptr, Offset?)
    ReloadWide(Module)
      => ComCall(75, this.p, "Str", Module)
    GetSymbolPathWide(Buffer?, PathSize?)
      => ComCall(76, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetSymbolPathWide(Path)
      => ComCall(77, this.p, "Str", Path)
    AppendSymbolPathWide(Addition)
      => ComCall(78, this.p, "Str", Addition)
    GetImagePathWide(Buffer?, PathSize?)
      => ComCall(79, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    SetImagePathWide(Path)
      => ComCall(80, this.p, "Str", Path)
    AppendImagePathWide(Addition)
      => ComCall(81, this.p, "Str", Addition)
    GetSourcePathWide(Buffer?, PathSize?)
      => ComCall(82, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, PathSize?)
    GetSourcePathElementWide(Index, Buffer?, ElementSize?)
      => ComCall(83, this.p, UInt32, Index, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ElementSize?)
    SetSourcePathWide(Path)
      => ComCall(84, this.p, "Str", Path)
    AppendSourcePathWide(Addition)
      => ComCall(85, this.p, "Str", Addition)
    FindSourceFileWide(StartElement, File, Flags, FoundElement?, Buffer?, FoundSize?)
      => ComCall(86, this.p, UInt32, StartElement, "Str", File, UInt32, Flags, UInt32.Ptr, FoundElement?, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FoundSize?)
    GetSourceFileLineOffsetsWide(File, Buffer?, FileLines?)
      => ComCall(87, this.p, "Str", File, Int64.Ptr, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, FileLines?)
    GetModuleVersionInformationWide(Index, Base, Item, Buffer?, VerInfoSize?)
      => ComCall(88, this.p, UInt32, Index, Int64, Base, "Str", Item, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, VerInfoSize?)
    GetModuleNameStringWide(Which, Index, Base, Buffer?, NameSize?)
      => ComCall(89, this.p, UInt32, Which, UInt32, Index, Int64, Base, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetConstantNameWide(Module, TypeId, Value, NameBuffer?, NameSize?)
      => ComCall(90, this.p, Int64, Module, UInt32, TypeId, Int64, Value, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetFieldNameWide(Module, TypeId, FieldIndex, NameBuffer?, NameSize?)
      => ComCall(91, this.p, Int64, Module, UInt32, TypeId, UInt32, FieldIndex, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    IsManagedModule(Index, Base)
      => ComCall(92, this.p, UInt32, Index, Int64, Base)
    GetModuleByModuleName2(Name, StartIndex, Flags, Index?, Base?)
      => ComCall(93, this.p, PSTR, Name, UInt32, StartIndex, UInt32, Flags, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleByModuleName2Wide(Name, StartIndex, Flags, Index?, Base?)
      => ComCall(94, this.p, "Str", Name, UInt32, StartIndex, UInt32, Flags, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    GetModuleByOffset2(Offset, StartIndex, Flags, Index?, Base?)
      => ComCall(95, this.p, Int64, Offset, UInt32, StartIndex, UInt32, Flags, UInt32.Ptr, Index?, Int64.Ptr, Base?)
    AddSyntheticModule(Base, Size, ImagePath, ModuleName, Flags)
      => ComCall(96, this.p, Int64, Base, UInt32, Size, PSTR, ImagePath, PSTR, ModuleName, UInt32, Flags)
    AddSyntheticModuleWide(Base, Size, ImagePath, ModuleName, Flags)
      => ComCall(97, this.p, Int64, Base, UInt32, Size, "Str", ImagePath, "Str", ModuleName, UInt32, Flags)
    RemoveSyntheticModule(Base)
      => ComCall(98, this.p, Int64, Base)
    GetCurrentScopeFrameIndex(Index)
      => ComCall(99, this.p, UInt32.Ptr, Index)
    SetScopeFrameByIndex(Index)
      => ComCall(100, this.p, UInt32, Index)
    SetScopeFromJitDebugInfo(OutputControl, InfoOffset)
      => ComCall(101, this.p, UInt32, OutputControl, Int64, InfoOffset)
    SetScopeFromStoredEvent()
      => ComCall(102, this.p)
    OutputSymbolByOffset(OutputControl, Flags, Offset)
      => ComCall(103, this.p, UInt32, OutputControl, UInt32, Flags, Int64, Offset)
    GetFunctionEntryByOffset(Offset, Flags, Buffer?, BufferNeeded?)
      => ComCall(104, this.p, Int64, Offset, UInt32, Flags, Struct.Ptr, Buffer?, UInt32, Buffer?.Size ?? 0, UInt32.Ptr, BufferNeeded?)
    GetFieldTypeAndOffset(Module, ContainerTypeId, Field, FieldTypeId?, Offset?)
      => ComCall(105, this.p, Int64, Module, UInt32, ContainerTypeId, PSTR, Field, UInt32.Ptr, FieldTypeId?, UInt32.Ptr, Offset?)
    GetFieldTypeAndOffsetWide(Module, ContainerTypeId, Field, FieldTypeId?, Offset?)
      => ComCall(106, this.p, Int64, Module, UInt32, ContainerTypeId, "Str", Field, UInt32.Ptr, FieldTypeId?, UInt32.Ptr, Offset?)
    AddSyntheticSymbol(Offset, Size, Name, Flags, Id?)
      => ComCall(107, this.p, Int64, Offset, UInt32, Size, PSTR, Name, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Id?)
    AddSyntheticSymbolWide(Offset, Size, Name, Flags, Id?)
      => ComCall(108, this.p, Int64, Offset, UInt32, Size, "Str", Name, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Id?)
    RemoveSyntheticSymbol(Id)
      => ComCall(109, this.p, DEBUG_MODULE_AND_ID.Ptr, Id)
    GetSymbolEntriesByOffset(Offset, Flags, Ids?, Displacements?, Entries?)
      => ComCall(110, this.p, Int64, Offset, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Ids?, Int64.Ptr, Displacements?, UInt32, Displacements?.Length ?? 0, UInt32.Ptr, Entries?)
    GetSymbolEntriesByName(Symbol, Flags, Ids?, Entries?)
      => ComCall(111, this.p, PSTR, Symbol, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, Entries?)
    GetSymbolEntriesByNameWide(Symbol, Flags, Ids?, Entries?)
      => ComCall(112, this.p, "Str", Symbol, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, Ids?, UInt32, Ids?.Length ?? 0, UInt32.Ptr, Entries?)
    GetSymbolEntryByToken(ModuleBase, Token, Id)
      => ComCall(113, this.p, Int64, ModuleBase, UInt32, Token, DEBUG_MODULE_AND_ID.Ptr, Id)
    GetSymbolEntryInformation(Id, Info)
      => ComCall(114, this.p, DEBUG_MODULE_AND_ID.Ptr, Id, DEBUG_SYMBOL_ENTRY.Ptr, Info)
    GetSymbolEntryString(Id, Which, Buffer?, StringSize?)
      => ComCall(115, this.p, DEBUG_MODULE_AND_ID.Ptr, Id, UInt32, Which, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSymbolEntryStringWide(Id, Which, Buffer?, StringSize?)
      => ComCall(116, this.p, DEBUG_MODULE_AND_ID.Ptr, Id, UInt32, Which, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSymbolEntryOffsetRegions(Id, Flags, Regions?, RegionsAvail?)
      => ComCall(117, this.p, DEBUG_MODULE_AND_ID.Ptr, Id, UInt32, Flags, DEBUG_OFFSET_REGION.Ptr, Regions?, UInt32, Regions?.Length ?? 0, UInt32.Ptr, RegionsAvail?)
    GetSymbolEntryBySymbolEntry(FromId, Flags, ToId)
      => ComCall(118, this.p, DEBUG_MODULE_AND_ID.Ptr, FromId, UInt32, Flags, DEBUG_MODULE_AND_ID.Ptr, ToId)
    GetSourceEntriesByOffset(Offset, Flags, Entries?, EntriesAvail?)
      => ComCall(119, this.p, Int64, Offset, UInt32, Flags, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entries?, UInt32, Entries?.Length ?? 0, UInt32.Ptr, EntriesAvail?)
    GetSourceEntriesByLine(Line, File, Flags, Entries?, EntriesAvail?)
      => ComCall(120, this.p, UInt32, Line, PSTR, File, UInt32, Flags, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entries?, UInt32, Entries?.Length ?? 0, UInt32.Ptr, EntriesAvail?)
    GetSourceEntriesByLineWide(Line, File, Flags, Entries?, EntriesAvail?)
      => ComCall(121, this.p, UInt32, Line, "Str", File, UInt32, Flags, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entries?, UInt32, Entries?.Length ?? 0, UInt32.Ptr, EntriesAvail?)
    GetSourceEntryString(Entry, Which, Buffer?, StringSize?)
      => ComCall(122, this.p, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entry, UInt32, Which, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSourceEntryStringWide(Entry, Which, Buffer?, StringSize?)
      => ComCall(123, this.p, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entry, UInt32, Which, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, StringSize?)
    GetSourceEntryOffsetRegions(Entry, Flags, Regions?, RegionsAvail?)
      => ComCall(124, this.p, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, Entry, UInt32, Flags, DEBUG_OFFSET_REGION.Ptr, Regions?, UInt32, Regions?.Length ?? 0, UInt32.Ptr, RegionsAvail?)
    GetSourceEntryBySourceEntry(FromEntry, Flags, ToEntry)
      => ComCall(125, this.p, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, FromEntry, UInt32, Flags, DEBUG_SYMBOL_SOURCE_ENTRY.Ptr, ToEntry)
    GetScopeEx(InstructionOffset?, ScopeFrame?, ScopeContext?)
      => ComCall(126, this.p, Int64.Ptr, InstructionOffset?, DEBUG_STACK_FRAME_EX.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    SetScopeEx(InstructionOffset, ScopeFrame?, ScopeContext?)
      => ComCall(127, this.p, Int64, InstructionOffset, DEBUG_STACK_FRAME_EX.Ptr, ScopeFrame?, Struct.Ptr, ScopeContext?, UInt32, ScopeContext?.Size ?? 0)
    GetNameByInlineContext(Offset, InlineContext, NameBuffer?, NameSize?, Displacement?)
      => ComCall(128, this.p, Int64, Offset, UInt32, InlineContext, PSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetNameByInlineContextWide(Offset, InlineContext, NameBuffer?, NameSize?, Displacement?)
      => ComCall(129, this.p, Int64, Offset, UInt32, InlineContext, PWSTR, NameBuffer?, UInt32, NameBuffer?.Length ?? 0, UInt32.Ptr, NameSize?, Int64.Ptr, Displacement?)
    GetLineByInlineContext(Offset, InlineContext, Line?, FileBuffer?, FileSize?, Displacement?)
      => ComCall(130, this.p, Int64, Offset, UInt32, InlineContext, UInt32.Ptr, Line?, PSTR, FileBuffer?, UInt32, FileBuffer?.Length ?? 0, UInt32.Ptr, FileSize?, Int64.Ptr, Displacement?)
    GetLineByInlineContextWide(Offset, InlineContext, Line?, FileBuffer?, FileSize?, Displacement?)
      => ComCall(131, this.p, Int64, Offset, UInt32, InlineContext, UInt32.Ptr, Line?, PWSTR, FileBuffer?, UInt32, FileBuffer?.Length ?? 0, UInt32.Ptr, FileSize?, Int64.Ptr, Displacement?)
    OutputSymbolByInlineContext(OutputControl, Flags, Offset, InlineContext)
      => ComCall(132, this.p, UInt32, OutputControl, UInt32, Flags, Int64, Offset, UInt32, InlineContext)
    GetCurrentScopeFrameIndexEx(Flags, Index)
      => ComCall(133, this.p, UInt32, Flags, UInt32.Ptr, Index)
    SetScopeFrameByIndexEx(Flags, Index)
      => ComCall(134, this.p, UInt32, Flags, UInt32, Index)
}
struct IDebugSystemObjects extends IUnknown {
    static IID := "{6B86FE2C-2C4F-4F0C-9DA2-174311ACC327}"
    GetEventThread(Id)
      => ComCall(3, this.p, UInt32.Ptr, Id)
    GetEventProcess(Id)
      => ComCall(4, this.p, UInt32.Ptr, Id)
    GetCurrentThreadId(Id)
      => ComCall(5, this.p, UInt32.Ptr, Id)
    SetCurrentThreadId(Id)
      => ComCall(6, this.p, UInt32, Id)
    GetCurrentProcessId(Id)
      => ComCall(7, this.p, UInt32.Ptr, Id)
    SetCurrentProcessId(Id)
      => ComCall(8, this.p, UInt32, Id)
    GetNumberThreads(Number)
      => ComCall(9, this.p, UInt32.Ptr, Number)
    GetTotalNumberThreads(Total, LargestProcess)
      => ComCall(10, this.p, UInt32.Ptr, Total, UInt32.Ptr, LargestProcess)
    GetThreadIdsByIndex(Start, Ids?, SysIds?)
      => ComCall(11, this.p, UInt32, Start, UInt32, SysIds?.Length ?? 0, UInt32.Ptr, Ids?, UInt32.Ptr, SysIds?)
    GetThreadIdByProcessor(Processor, Id)
      => ComCall(12, this.p, UInt32, Processor, UInt32.Ptr, Id)
    GetCurrentThreadDataOffset(Offset)
      => ComCall(13, this.p, Int64.Ptr, Offset)
    GetThreadIdByDataOffset(Offset, Id)
      => ComCall(14, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentThreadTeb(Offset)
      => ComCall(15, this.p, Int64.Ptr, Offset)
    GetThreadIdByTeb(Offset, Id)
      => ComCall(16, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentThreadSystemId(SysId)
      => ComCall(17, this.p, UInt32.Ptr, SysId)
    GetThreadIdBySystemId(SysId, Id)
      => ComCall(18, this.p, UInt32, SysId, UInt32.Ptr, Id)
    GetCurrentThreadHandle(Handle)
      => ComCall(19, this.p, Int64.Ptr, Handle)
    GetThreadIdByHandle(Handle, Id)
      => ComCall(20, this.p, Int64, Handle, UInt32.Ptr, Id)
    GetNumberProcesses(Number)
      => ComCall(21, this.p, UInt32.Ptr, Number)
    GetProcessIdsByIndex(Start, Ids?, SysIds?)
      => ComCall(22, this.p, UInt32, Start, UInt32, SysIds?.Length ?? 0, UInt32.Ptr, Ids?, UInt32.Ptr, SysIds?)
    GetCurrentProcessDataOffset(Offset)
      => ComCall(23, this.p, Int64.Ptr, Offset)
    GetProcessIdByDataOffset(Offset, Id)
      => ComCall(24, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentProcessPeb(Offset)
      => ComCall(25, this.p, Int64.Ptr, Offset)
    GetProcessIdByPeb(Offset, Id)
      => ComCall(26, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentProcessSystemId(SysId)
      => ComCall(27, this.p, UInt32.Ptr, SysId)
    GetProcessIdBySystemId(SysId, Id)
      => ComCall(28, this.p, UInt32, SysId, UInt32.Ptr, Id)
    GetCurrentProcessHandle(Handle)
      => ComCall(29, this.p, Int64.Ptr, Handle)
    GetProcessIdByHandle(Handle, Id)
      => ComCall(30, this.p, Int64, Handle, UInt32.Ptr, Id)
    GetCurrentProcessExecutableName(Buffer?, ExeSize?)
      => ComCall(31, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ExeSize?)
}
struct IDebugSystemObjects2 extends IUnknown {
    static IID := "{0AE9F5FF-1852-4679-B055-494BEE6407EE}"
    GetEventThread(Id)
      => ComCall(3, this.p, UInt32.Ptr, Id)
    GetEventProcess(Id)
      => ComCall(4, this.p, UInt32.Ptr, Id)
    GetCurrentThreadId(Id)
      => ComCall(5, this.p, UInt32.Ptr, Id)
    SetCurrentThreadId(Id)
      => ComCall(6, this.p, UInt32, Id)
    GetCurrentProcessId(Id)
      => ComCall(7, this.p, UInt32.Ptr, Id)
    SetCurrentProcessId(Id)
      => ComCall(8, this.p, UInt32, Id)
    GetNumberThreads(Number)
      => ComCall(9, this.p, UInt32.Ptr, Number)
    GetTotalNumberThreads(Total, LargestProcess)
      => ComCall(10, this.p, UInt32.Ptr, Total, UInt32.Ptr, LargestProcess)
    GetThreadIdsByIndex(Start, Ids?, SysIds?)
      => ComCall(11, this.p, UInt32, Start, UInt32, SysIds?.Length ?? 0, UInt32.Ptr, Ids?, UInt32.Ptr, SysIds?)
    GetThreadIdByProcessor(Processor, Id)
      => ComCall(12, this.p, UInt32, Processor, UInt32.Ptr, Id)
    GetCurrentThreadDataOffset(Offset)
      => ComCall(13, this.p, Int64.Ptr, Offset)
    GetThreadIdByDataOffset(Offset, Id)
      => ComCall(14, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentThreadTeb(Offset)
      => ComCall(15, this.p, Int64.Ptr, Offset)
    GetThreadIdByTeb(Offset, Id)
      => ComCall(16, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentThreadSystemId(SysId)
      => ComCall(17, this.p, UInt32.Ptr, SysId)
    GetThreadIdBySystemId(SysId, Id)
      => ComCall(18, this.p, UInt32, SysId, UInt32.Ptr, Id)
    GetCurrentThreadHandle(Handle)
      => ComCall(19, this.p, Int64.Ptr, Handle)
    GetThreadIdByHandle(Handle, Id)
      => ComCall(20, this.p, Int64, Handle, UInt32.Ptr, Id)
    GetNumberProcesses(Number)
      => ComCall(21, this.p, UInt32.Ptr, Number)
    GetProcessIdsByIndex(Start, Ids?, SysIds?)
      => ComCall(22, this.p, UInt32, Start, UInt32, SysIds?.Length ?? 0, UInt32.Ptr, Ids?, UInt32.Ptr, SysIds?)
    GetCurrentProcessDataOffset(Offset)
      => ComCall(23, this.p, Int64.Ptr, Offset)
    GetProcessIdByDataOffset(Offset, Id)
      => ComCall(24, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentProcessPeb(Offset)
      => ComCall(25, this.p, Int64.Ptr, Offset)
    GetProcessIdByPeb(Offset, Id)
      => ComCall(26, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentProcessSystemId(SysId)
      => ComCall(27, this.p, UInt32.Ptr, SysId)
    GetProcessIdBySystemId(SysId, Id)
      => ComCall(28, this.p, UInt32, SysId, UInt32.Ptr, Id)
    GetCurrentProcessHandle(Handle)
      => ComCall(29, this.p, Int64.Ptr, Handle)
    GetProcessIdByHandle(Handle, Id)
      => ComCall(30, this.p, Int64, Handle, UInt32.Ptr, Id)
    GetCurrentProcessExecutableName(Buffer?, ExeSize?)
      => ComCall(31, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ExeSize?)
    GetCurrentProcessUpTime(UpTime)
      => ComCall(32, this.p, UInt32.Ptr, UpTime)
    GetImplicitThreadDataOffset(Offset)
      => ComCall(33, this.p, Int64.Ptr, Offset)
    SetImplicitThreadDataOffset(Offset)
      => ComCall(34, this.p, Int64, Offset)
    GetImplicitProcessDataOffset(Offset)
      => ComCall(35, this.p, Int64.Ptr, Offset)
    SetImplicitProcessDataOffset(Offset)
      => ComCall(36, this.p, Int64, Offset)
}
struct IDebugSystemObjects3 extends IUnknown {
    static IID := "{E9676E2F-E286-4EA3-B0F9-DFE5D9FC330E}"
    GetEventThread(Id)
      => ComCall(3, this.p, UInt32.Ptr, Id)
    GetEventProcess(Id)
      => ComCall(4, this.p, UInt32.Ptr, Id)
    GetCurrentThreadId(Id)
      => ComCall(5, this.p, UInt32.Ptr, Id)
    SetCurrentThreadId(Id)
      => ComCall(6, this.p, UInt32, Id)
    GetCurrentProcessId(Id)
      => ComCall(7, this.p, UInt32.Ptr, Id)
    SetCurrentProcessId(Id)
      => ComCall(8, this.p, UInt32, Id)
    GetNumberThreads(Number)
      => ComCall(9, this.p, UInt32.Ptr, Number)
    GetTotalNumberThreads(Total, LargestProcess)
      => ComCall(10, this.p, UInt32.Ptr, Total, UInt32.Ptr, LargestProcess)
    GetThreadIdsByIndex(Start, Ids?, SysIds?)
      => ComCall(11, this.p, UInt32, Start, UInt32, SysIds?.Length ?? 0, UInt32.Ptr, Ids?, UInt32.Ptr, SysIds?)
    GetThreadIdByProcessor(Processor, Id)
      => ComCall(12, this.p, UInt32, Processor, UInt32.Ptr, Id)
    GetCurrentThreadDataOffset(Offset)
      => ComCall(13, this.p, Int64.Ptr, Offset)
    GetThreadIdByDataOffset(Offset, Id)
      => ComCall(14, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentThreadTeb(Offset)
      => ComCall(15, this.p, Int64.Ptr, Offset)
    GetThreadIdByTeb(Offset, Id)
      => ComCall(16, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentThreadSystemId(SysId)
      => ComCall(17, this.p, UInt32.Ptr, SysId)
    GetThreadIdBySystemId(SysId, Id)
      => ComCall(18, this.p, UInt32, SysId, UInt32.Ptr, Id)
    GetCurrentThreadHandle(Handle)
      => ComCall(19, this.p, Int64.Ptr, Handle)
    GetThreadIdByHandle(Handle, Id)
      => ComCall(20, this.p, Int64, Handle, UInt32.Ptr, Id)
    GetNumberProcesses(Number)
      => ComCall(21, this.p, UInt32.Ptr, Number)
    GetProcessIdsByIndex(Start, Ids?, SysIds?)
      => ComCall(22, this.p, UInt32, Start, UInt32, SysIds?.Length ?? 0, UInt32.Ptr, Ids?, UInt32.Ptr, SysIds?)
    GetCurrentProcessDataOffset(Offset)
      => ComCall(23, this.p, Int64.Ptr, Offset)
    GetProcessIdByDataOffset(Offset, Id)
      => ComCall(24, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentProcessPeb(Offset)
      => ComCall(25, this.p, Int64.Ptr, Offset)
    GetProcessIdByPeb(Offset, Id)
      => ComCall(26, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentProcessSystemId(SysId)
      => ComCall(27, this.p, UInt32.Ptr, SysId)
    GetProcessIdBySystemId(SysId, Id)
      => ComCall(28, this.p, UInt32, SysId, UInt32.Ptr, Id)
    GetCurrentProcessHandle(Handle)
      => ComCall(29, this.p, Int64.Ptr, Handle)
    GetProcessIdByHandle(Handle, Id)
      => ComCall(30, this.p, Int64, Handle, UInt32.Ptr, Id)
    GetCurrentProcessExecutableName(Buffer?, ExeSize?)
      => ComCall(31, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ExeSize?)
    GetCurrentProcessUpTime(UpTime)
      => ComCall(32, this.p, UInt32.Ptr, UpTime)
    GetImplicitThreadDataOffset(Offset)
      => ComCall(33, this.p, Int64.Ptr, Offset)
    SetImplicitThreadDataOffset(Offset)
      => ComCall(34, this.p, Int64, Offset)
    GetImplicitProcessDataOffset(Offset)
      => ComCall(35, this.p, Int64.Ptr, Offset)
    SetImplicitProcessDataOffset(Offset)
      => ComCall(36, this.p, Int64, Offset)
    GetEventSystem(Id)
      => ComCall(37, this.p, UInt32.Ptr, Id)
    GetCurrentSystemId(Id)
      => ComCall(38, this.p, UInt32.Ptr, Id)
    SetCurrentSystemId(Id)
      => ComCall(39, this.p, UInt32, Id)
    GetNumberSystems(Number)
      => ComCall(40, this.p, UInt32.Ptr, Number)
    GetSystemIdsByIndex(Start, Ids)
      => ComCall(41, this.p, UInt32, Start, UInt32, Ids.Length, UInt32.Ptr, Ids)
    GetTotalNumberThreadsAndProcesses(TotalThreads, TotalProcesses, LargestProcessThreads, LargestSystemThreads, LargestSystemProcesses)
      => ComCall(42, this.p, UInt32.Ptr, TotalThreads, UInt32.Ptr, TotalProcesses, UInt32.Ptr, LargestProcessThreads, UInt32.Ptr, LargestSystemThreads, UInt32.Ptr, LargestSystemProcesses)
    GetCurrentSystemServer(Server)
      => ComCall(43, this.p, Int64.Ptr, Server)
    GetSystemByServer(Server, Id)
      => ComCall(44, this.p, Int64, Server, UInt32.Ptr, Id)
    GetCurrentSystemServerName(Buffer?, NameSize?)
      => ComCall(45, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
}
struct IDebugSystemObjects4 extends IUnknown {
    static IID := "{489468E6-7D0F-4AF5-87AB-25207454D553}"
    GetEventThread(Id)
      => ComCall(3, this.p, UInt32.Ptr, Id)
    GetEventProcess(Id)
      => ComCall(4, this.p, UInt32.Ptr, Id)
    GetCurrentThreadId(Id)
      => ComCall(5, this.p, UInt32.Ptr, Id)
    SetCurrentThreadId(Id)
      => ComCall(6, this.p, UInt32, Id)
    GetCurrentProcessId(Id)
      => ComCall(7, this.p, UInt32.Ptr, Id)
    SetCurrentProcessId(Id)
      => ComCall(8, this.p, UInt32, Id)
    GetNumberThreads(Number)
      => ComCall(9, this.p, UInt32.Ptr, Number)
    GetTotalNumberThreads(Total, LargestProcess)
      => ComCall(10, this.p, UInt32.Ptr, Total, UInt32.Ptr, LargestProcess)
    GetThreadIdsByIndex(Start, Ids?, SysIds?)
      => ComCall(11, this.p, UInt32, Start, UInt32, SysIds?.Length ?? 0, UInt32.Ptr, Ids?, UInt32.Ptr, SysIds?)
    GetThreadIdByProcessor(Processor, Id)
      => ComCall(12, this.p, UInt32, Processor, UInt32.Ptr, Id)
    GetCurrentThreadDataOffset(Offset)
      => ComCall(13, this.p, Int64.Ptr, Offset)
    GetThreadIdByDataOffset(Offset, Id)
      => ComCall(14, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentThreadTeb(Offset)
      => ComCall(15, this.p, Int64.Ptr, Offset)
    GetThreadIdByTeb(Offset, Id)
      => ComCall(16, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentThreadSystemId(SysId)
      => ComCall(17, this.p, UInt32.Ptr, SysId)
    GetThreadIdBySystemId(SysId, Id)
      => ComCall(18, this.p, UInt32, SysId, UInt32.Ptr, Id)
    GetCurrentThreadHandle(Handle)
      => ComCall(19, this.p, Int64.Ptr, Handle)
    GetThreadIdByHandle(Handle, Id)
      => ComCall(20, this.p, Int64, Handle, UInt32.Ptr, Id)
    GetNumberProcesses(Number)
      => ComCall(21, this.p, UInt32.Ptr, Number)
    GetProcessIdsByIndex(Start, Ids?, SysIds?)
      => ComCall(22, this.p, UInt32, Start, UInt32, SysIds?.Length ?? 0, UInt32.Ptr, Ids?, UInt32.Ptr, SysIds?)
    GetCurrentProcessDataOffset(Offset)
      => ComCall(23, this.p, Int64.Ptr, Offset)
    GetProcessIdByDataOffset(Offset, Id)
      => ComCall(24, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentProcessPeb(Offset)
      => ComCall(25, this.p, Int64.Ptr, Offset)
    GetProcessIdByPeb(Offset, Id)
      => ComCall(26, this.p, Int64, Offset, UInt32.Ptr, Id)
    GetCurrentProcessSystemId(SysId)
      => ComCall(27, this.p, UInt32.Ptr, SysId)
    GetProcessIdBySystemId(SysId, Id)
      => ComCall(28, this.p, UInt32, SysId, UInt32.Ptr, Id)
    GetCurrentProcessHandle(Handle)
      => ComCall(29, this.p, Int64.Ptr, Handle)
    GetProcessIdByHandle(Handle, Id)
      => ComCall(30, this.p, Int64, Handle, UInt32.Ptr, Id)
    GetCurrentProcessExecutableName(Buffer?, ExeSize?)
      => ComCall(31, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ExeSize?)
    GetCurrentProcessUpTime(UpTime)
      => ComCall(32, this.p, UInt32.Ptr, UpTime)
    GetImplicitThreadDataOffset(Offset)
      => ComCall(33, this.p, Int64.Ptr, Offset)
    SetImplicitThreadDataOffset(Offset)
      => ComCall(34, this.p, Int64, Offset)
    GetImplicitProcessDataOffset(Offset)
      => ComCall(35, this.p, Int64.Ptr, Offset)
    SetImplicitProcessDataOffset(Offset)
      => ComCall(36, this.p, Int64, Offset)
    GetEventSystem(Id)
      => ComCall(37, this.p, UInt32.Ptr, Id)
    GetCurrentSystemId(Id)
      => ComCall(38, this.p, UInt32.Ptr, Id)
    SetCurrentSystemId(Id)
      => ComCall(39, this.p, UInt32, Id)
    GetNumberSystems(Number)
      => ComCall(40, this.p, UInt32.Ptr, Number)
    GetSystemIdsByIndex(Start, Ids)
      => ComCall(41, this.p, UInt32, Start, UInt32, Ids.Length, UInt32.Ptr, Ids)
    GetTotalNumberThreadsAndProcesses(TotalThreads, TotalProcesses, LargestProcessThreads, LargestSystemThreads, LargestSystemProcesses)
      => ComCall(42, this.p, UInt32.Ptr, TotalThreads, UInt32.Ptr, TotalProcesses, UInt32.Ptr, LargestProcessThreads, UInt32.Ptr, LargestSystemThreads, UInt32.Ptr, LargestSystemProcesses)
    GetCurrentSystemServer(Server)
      => ComCall(43, this.p, Int64.Ptr, Server)
    GetSystemByServer(Server, Id)
      => ComCall(44, this.p, Int64, Server, UInt32.Ptr, Id)
    GetCurrentSystemServerName(Buffer?, NameSize?)
      => ComCall(45, this.p, PSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
    GetCurrentProcessExecutableNameWide(Buffer?, ExeSize?)
      => ComCall(46, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, ExeSize?)
    GetCurrentSystemServerNameWide(Buffer?, NameSize?)
      => ComCall(47, this.p, PWSTR, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32.Ptr, NameSize?)
}
struct PDEBUG_EXTENSION_INITIALIZE extends FunctionPointer {
    static Types := [UInt32.Ptr, UInt32.Ptr, HRESULT]
}
struct PDEBUG_EXTENSION_UNINITIALIZE extends FunctionPointer {
    static Types := ["Void"]
}
struct PDEBUG_EXTENSION_CANUNLOAD extends FunctionPointer {
    static Types := [HRESULT]
}
struct PDEBUG_EXTENSION_UNLOAD extends FunctionPointer {
    static Types := ["Void"]
}
struct PDEBUG_EXTENSION_ISEXTENSIONAPI extends FunctionPointer {
    static Types := [PSTR, BOOL]
}
struct PDEBUG_EXTENSION_NOTIFY extends FunctionPointer {
    static Types := [UInt32, Int64, "Void"]
}
struct PDEBUG_EXTENSION_CALL extends FunctionPointer {
    static Types := [IDebugClient, PSTR, HRESULT]
}
struct PDEBUG_EXTENSION_KNOWN_STRUCT extends FunctionPointer {
    static Types := [UInt32, Int64, PSTR, PSTR, UInt32.Ptr, HRESULT]
}
struct PDEBUG_EXTENSION_KNOWN_STRUCT_EX extends FunctionPointer {
    static Types := [IDebugClient, UInt32, Int64, PSTR, PSTR, UInt32.Ptr, HRESULT]
}
struct PDEBUG_EXTENSION_QUERY_VALUE_NAMES extends FunctionPointer {
    static Types := [IDebugClient, UInt32, PWSTR, UInt32, UInt32.Ptr, HRESULT]
}
struct PDEBUG_EXTENSION_PROVIDE_VALUE extends FunctionPointer {
    static Types := [IDebugClient, UInt32, PWSTR, Int64.Ptr, Int64.Ptr, UInt32.Ptr, UInt32.Ptr, HRESULT]
}
struct PDEBUG_STACK_PROVIDER_BEGINTHREADSTACKRECONSTRUCTION extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, UInt32, HRESULT]
}
struct PDEBUG_STACK_PROVIDER_RECONSTRUCTSTACK extends FunctionPointer {
    static Types := [UInt32, DEBUG_STACK_FRAME_EX.Ptr, UInt32, STACK_SYM_FRAME_INFO.Ptr.Ptr, UInt32.Ptr, HRESULT]
}
struct PDEBUG_STACK_PROVIDER_FREESTACKSYMFRAMES extends FunctionPointer {
    static Types := [STACK_SYM_FRAME_INFO.Ptr, HRESULT]
}
struct PDEBUG_STACK_PROVIDER_ENDTHREADSTACKRECONSTRUCTION extends FunctionPointer {
    static Types := [HRESULT]
}
struct DebugBaseEventCallbacks extends IDebugEventCallbacks {
}
struct DebugBaseEventCallbacksWide extends IDebugEventCallbacksWide {
}
struct Location {
    HostDefined : Int64
    Offset : Int64
}
struct ModelObjectKind extends Int32 {
    static ObjectPropertyAccessor := 0
    static ObjectContext := 1
    static ObjectTargetObject := 2
    static ObjectTargetObjectReference := 3
    static ObjectSynthetic := 4
    static ObjectNoValue := 5
    static ObjectError := 6
    static ObjectIntrinsic := 7
    static ObjectMethod := 8
    static ObjectKeyReference := 9
}
struct SymbolKind extends Int32 {
    static Symbol := 0
    static SymbolModule := 1
    static SymbolType := 2
    static SymbolField := 3
    static SymbolConstant := 4
    static SymbolData := 5
    static SymbolBaseClass := 6
    static SymbolPublic := 7
    static SymbolFunction := 8
}
struct TypeKind extends Int32 {
    static TypeUDT := 0
    static TypePointer := 1
    static TypeMemberPointer := 2
    static TypeArray := 3
    static TypeFunction := 4
    static TypeTypedef := 5
    static TypeEnum := 6
    static TypeIntrinsic := 7
    static TypeExtendedArray := 8
}
struct IntrinsicKind extends Int32 {
    static IntrinsicVoid := 0
    static IntrinsicBool := 1
    static IntrinsicChar := 2
    static IntrinsicWChar := 3
    static IntrinsicInt := 4
    static IntrinsicUInt := 5
    static IntrinsicLong := 6
    static IntrinsicULong := 7
    static IntrinsicFloat := 8
    static IntrinsicHRESULT := 9
    static IntrinsicChar16 := 10
    static IntrinsicChar32 := 11
}
struct PointerKind extends Int32 {
    static PointerStandard := 0
    static PointerReference := 1
    static PointerRValueReference := 2
    static PointerCXHat := 3
    static PointerManagedReference := 4
}
struct CallingConventionKind extends Int32 {
    static CallingConventionUnknown := 0
    static CallingConventionCDecl := 1
    static CallingConventionFastCall := 2
    static CallingConventionStdCall := 3
    static CallingConventionSysCall := 4
    static CallingConventionThisCall := 5
}
struct LocationKind extends Int32 {
    static LocationMember := 0
    static LocationStatic := 1
    static LocationConstant := 2
    static LocationNone := 3
}
struct PreferredFormat extends Int32 {
    static FormatNone := 0
    static FormatSingleCharacter := 1
    static FormatQuotedString := 2
    static FormatString := 3
    static FormatQuotedUnicodeString := 4
    static FormatUnicodeString := 5
    static FormatQuotedUTF8String := 6
    static FormatUTF8String := 7
    static FormatBSTRString := 8
    static FormatQuotedHString := 9
    static FormatHString := 10
    static FormatRaw := 11
    static FormatEnumNameOnly := 12
    static FormatEscapedStringWithQuote := 13
    static FormatUTF32String := 14
    static FormatQuotedUTF32String := 15
}
struct PreferredGraphForm extends Int32 {
    static GraphFormUnspecified := 0
    static GraphFormGraph := 1
    static GraphFormTree := 2
    static GraphFormLinearFlow := 3
}
struct IHostDataModelAccess extends IUnknown {
    static IID := "{F2BCE54E-4835-4F8A-836E-7981E29904D1}"
    GetDataModel(manager, host)
      => ComCall(3, this.p, IDataModelManager.Ptr, manager, IDebugHost.Ptr, host)
}
struct IKeyStore extends IUnknown {
    static IID := "{0FC7557D-401D-4FCA-9365-DA1E9850697C}"
    GetKey(key, object?, metadata?)
      => ComCall(3, this.p, "Str", key, IModelObject.Ptr, object?, IKeyStore.Ptr, metadata?)
    SetKey(key, object?, metadata?)
      => ComCall(4, this.p, "Str", key, IModelObject, object?, IKeyStore, metadata?)
    GetKeyValue(key, object?, metadata?)
      => ComCall(5, this.p, "Str", key, IModelObject.Ptr, object?, IKeyStore.Ptr, metadata?)
    SetKeyValue(key, object)
      => ComCall(6, this.p, "Str", key, IModelObject, object)
    ClearKeys()
      => ComCall(7, this.p)
}
struct RawSearchFlags extends Int32 {
    static RawSearchNone := 0
    static RawSearchNoBases := 1
}
struct IModelObject extends IUnknown {
    static IID := "{E28C7893-3F4B-4B96-BACA-293CDC55F45D}"
    GetContext(context)
      => ComCall(3, this.p, IDebugHostContext.Ptr, context)
    GetKind(kind)
      => ComCall(4, this.p, ModelObjectKind.Ptr, kind)
    GetIntrinsicValue(intrinsicData)
      => ComCall(5, this.p, VARIANT.Ptr, intrinsicData)
    GetIntrinsicValueAs(vt, intrinsicData)
      => ComCall(6, this.p, VARENUM, vt, VARIANT.Ptr, intrinsicData)
    GetKeyValue(key, object?, metadata?)
      => ComCall(7, this.p, "Str", key, IModelObject.Ptr, object?, IKeyStore.Ptr, metadata?)
    SetKeyValue(key, object?)
      => ComCall(8, this.p, "Str", key, IModelObject, object?)
    EnumerateKeyValues(enumerator)
      => ComCall(9, this.p, IKeyEnumerator.Ptr, enumerator)
    GetRawValue(kind, name, searchFlags, object)
      => ComCall(10, this.p, SymbolKind, kind, "Str", name, UInt32, searchFlags, IModelObject.Ptr, object)
    EnumerateRawValues(kind, searchFlags, enumerator)
      => ComCall(11, this.p, SymbolKind, kind, UInt32, searchFlags, IRawEnumerator.Ptr, enumerator)
    Dereference(object)
      => ComCall(12, this.p, IModelObject.Ptr, object)
    TryCastToRuntimeType(runtimeTypedObject)
      => ComCall(13, this.p, IModelObject.Ptr, runtimeTypedObject)
    GetConcept(conceptId, conceptInterface, conceptMetadata?)
      => ComCall(14, this.p, GUID.Ptr, conceptId, IUnknown.Ptr, conceptInterface, IKeyStore.Ptr, conceptMetadata?)
    GetLocation(location)
      => ComCall(15, this.p, Location.Ptr, location)
    GetTypeInfo(type)
      => ComCall(16, this.p, IDebugHostType.Ptr, type)
    GetTargetInfo(location, type)
      => ComCall(17, this.p, Location.Ptr, location, IDebugHostType.Ptr, type)
    GetNumberOfParentModels(numModels)
      => ComCall(18, this.p, Int64.Ptr, numModels)
    GetParentModel(i, model, contextObject)
      => ComCall(19, this.p, Int64, i, IModelObject.Ptr, model, IModelObject.Ptr, contextObject)
    AddParentModel(model, contextObject?, override)
      => ComCall(20, this.p, IModelObject, model, IModelObject, contextObject?, UInt8, override)
    RemoveParentModel(model)
      => ComCall(21, this.p, IModelObject, model)
    GetKey(key, object?, metadata?)
      => ComCall(22, this.p, "Str", key, IModelObject.Ptr, object?, IKeyStore.Ptr, metadata?)
    GetKeyReference(key, objectReference?, metadata?)
      => ComCall(23, this.p, "Str", key, IModelObject.Ptr, objectReference?, IKeyStore.Ptr, metadata?)
    SetKey(key, object?, metadata?)
      => ComCall(24, this.p, "Str", key, IModelObject, object?, IKeyStore, metadata?)
    ClearKeys()
      => ComCall(25, this.p)
    EnumerateKeys(enumerator)
      => ComCall(26, this.p, IKeyEnumerator.Ptr, enumerator)
    EnumerateKeyReferences(enumerator)
      => ComCall(27, this.p, IKeyEnumerator.Ptr, enumerator)
    SetConcept(conceptId, conceptInterface, conceptMetadata?)
      => ComCall(28, this.p, GUID.Ptr, conceptId, IUnknown, conceptInterface, IKeyStore, conceptMetadata?)
    ClearConcepts()
      => ComCall(29, this.p)
    GetRawReference(kind, name, searchFlags, object)
      => ComCall(30, this.p, SymbolKind, kind, "Str", name, UInt32, searchFlags, IModelObject.Ptr, object)
    EnumerateRawReferences(kind, searchFlags, enumerator)
      => ComCall(31, this.p, SymbolKind, kind, UInt32, searchFlags, IRawEnumerator.Ptr, enumerator)
    SetContextForDataModel(dataModelObject, context)
      => ComCall(32, this.p, IModelObject, dataModelObject, IUnknown, context)
    GetContextForDataModel(dataModelObject, context)
      => ComCall(33, this.p, IModelObject, dataModelObject, IUnknown.Ptr, context)
    Compare(other, ppResult?)
      => ComCall(34, this.p, IModelObject, other, IModelObject.Ptr, ppResult?)
    IsEqualTo(other, equal)
      => ComCall(35, this.p, IModelObject, other, Boolean8.Ptr, equal)
}
struct IModelObject2 extends IModelObject {
    static IID := "{D61E19F4-AB3D-4344-9F7B-0993F3D58745}"
    EnumerateOwnKeyValues(ppEnumerator)
      => ComCall(36, this.p, IKeyEnumerator.Ptr, ppEnumerator)
    EnumerateOwnKeys(ppEnumerator)
      => ComCall(37, this.p, IKeyEnumerator.Ptr, ppEnumerator)
    EnumerateOwnKeyReferences(ppEnumerator)
      => ComCall(38, this.p, IKeyEnumerator.Ptr, ppEnumerator)
}
struct IDataModelManager extends IUnknown {
    static IID := "{73FE19F4-A110-4500-8ED9-3C28896F508C}"
    Close()
      => ComCall(3, this.p)
    CreateNoValue(object)
      => ComCall(4, this.p, IModelObject.Ptr, object)
    CreateErrorObject(hrError, pwszMessage?, object)
      => ComCall(5, this.p, HRESULT, hrError, "Str", pwszMessage?, IModelObject.Ptr, object)
    CreateTypedObject(context?, objectLocation, objectType, object)
      => ComCall(6, this.p, IDebugHostContext, context?, Location, objectLocation, IDebugHostType, objectType, IModelObject.Ptr, object)
    CreateTypedObjectReference(context?, objectLocation, objectType, object)
      => ComCall(7, this.p, IDebugHostContext, context?, Location, objectLocation, IDebugHostType, objectType, IModelObject.Ptr, object)
    CreateSyntheticObject(context?, object)
      => ComCall(8, this.p, IDebugHostContext, context?, IModelObject.Ptr, object)
    CreateDataModelObject(dataModel, object)
      => ComCall(9, this.p, IDataModelConcept, dataModel, IModelObject.Ptr, object)
    CreateIntrinsicObject(objectKind, intrinsicData, object)
      => ComCall(10, this.p, ModelObjectKind, objectKind, VARIANT.Ptr, intrinsicData, IModelObject.Ptr, object)
    CreateTypedIntrinsicObject(intrinsicData, type, object)
      => ComCall(11, this.p, VARIANT.Ptr, intrinsicData, IDebugHostType, type, IModelObject.Ptr, object)
    GetModelForTypeSignature(typeSignature, dataModel)
      => ComCall(12, this.p, IDebugHostTypeSignature, typeSignature, IModelObject.Ptr, dataModel)
    GetModelForType(type, dataModel, typeSignature?, wildcardMatches?)
      => ComCall(13, this.p, IDebugHostType, type, IModelObject.Ptr, dataModel, IDebugHostTypeSignature.Ptr, typeSignature?, IDebugHostSymbolEnumerator.Ptr, wildcardMatches?)
    RegisterModelForTypeSignature(typeSignature, dataModel)
      => ComCall(14, this.p, IDebugHostTypeSignature, typeSignature, IModelObject, dataModel)
    UnregisterModelForTypeSignature(dataModel, typeSignature?)
      => ComCall(15, this.p, IModelObject, dataModel, IDebugHostTypeSignature, typeSignature?)
    RegisterExtensionForTypeSignature(typeSignature, dataModel)
      => ComCall(16, this.p, IDebugHostTypeSignature, typeSignature, IModelObject, dataModel)
    UnregisterExtensionForTypeSignature(dataModel, typeSignature?)
      => ComCall(17, this.p, IModelObject, dataModel, IDebugHostTypeSignature, typeSignature?)
    CreateMetadataStore(parentStore?, metadataStore)
      => ComCall(18, this.p, IKeyStore, parentStore?, IKeyStore.Ptr, metadataStore)
    GetRootNamespace(rootNamespace)
      => ComCall(19, this.p, IModelObject.Ptr, rootNamespace)
    RegisterNamedModel(modelName, modeObject)
      => ComCall(20, this.p, "Str", modelName, IModelObject, modeObject)
    UnregisterNamedModel(modelName)
      => ComCall(21, this.p, "Str", modelName)
    AcquireNamedModel(modelName, modelObject)
      => ComCall(22, this.p, "Str", modelName, IModelObject.Ptr, modelObject)
}
struct IDataModelManager2 extends IDataModelManager {
    static IID := "{F412C5EA-2284-4622-A660-A697160D3312}"
    AcquireSubNamespace(modelName, subNamespaceModelName, accessName, metadata?, namespaceModelObject)
      => ComCall(23, this.p, "Str", modelName, "Str", subNamespaceModelName, "Str", accessName, IKeyStore, metadata?, IModelObject.Ptr, namespaceModelObject)
    CreateTypedIntrinsicObjectEx(context?, intrinsicData, type, object)
      => ComCall(24, this.p, IDebugHostContext, context?, VARIANT.Ptr, intrinsicData, IDebugHostType, type, IModelObject.Ptr, object)
}
struct IDataModelManager3 extends IDataModelManager2 {
    static IID := "{8642DAF8-6EF5-4753-B53F-D83A5CEE8100}"
    AcquireFilteredSubNamespace(modelName, subNamespaceModelName, accessName, metadata?, filter, namespaceModelObject, token)
      => ComCall(25, this.p, "Str", modelName, "Str", subNamespaceModelName, "Str", accessName, IKeyStore, metadata?, IModelMethod, filter, IModelObject.Ptr, namespaceModelObject, IFilteredNamespacePropertyToken.Ptr, token)
    EnumerateNamedModels(ppEnumerator)
      => ComCall(26, this.p, INamedModelsEnumerator.Ptr, ppEnumerator)
}
struct IDataModelManager4 extends IDataModelManager3 {
    static IID := "{8898AD97-3A2E-421C-953F-035E15426B7C}"
    CreateSyntheticObjectFromKeyStore(context?, parentStore, object)
      => ComCall(27, this.p, IDebugHostContext, context?, IKeyStore, parentStore, IModelObject.Ptr, object)
}
struct IModelKeyReference extends IUnknown {
    static IID := "{5253DCF8-5AFF-4C62-B302-56A289E00998}"
    GetKeyName(keyName)
      => ComCall(3, this.p, BSTR.Ptr, keyName)
    GetOriginalObject(originalObject)
      => ComCall(4, this.p, IModelObject.Ptr, originalObject)
    GetContextObject(containingObject)
      => ComCall(5, this.p, IModelObject.Ptr, containingObject)
    GetKey(object?, metadata?)
      => ComCall(6, this.p, IModelObject.Ptr, object?, IKeyStore.Ptr, metadata?)
    GetKeyValue(object?, metadata?)
      => ComCall(7, this.p, IModelObject.Ptr, object?, IKeyStore.Ptr, metadata?)
    SetKey(object?, metadata?)
      => ComCall(8, this.p, IModelObject, object?, IKeyStore, metadata?)
    SetKeyValue(object)
      => ComCall(9, this.p, IModelObject, object)
}
struct IModelPropertyAccessor extends IUnknown {
    static IID := "{5A0C63D9-0526-42B8-960C-9516A3254C85}"
    GetValue(key, contextObject?, value)
      => ComCall(3, this.p, "Str", key, IModelObject, contextObject?, IModelObject.Ptr, value)
    SetValue(key, contextObject?, value)
      => ComCall(4, this.p, "Str", key, IModelObject, contextObject?, IModelObject, value)
}
struct IModelMethod extends IUnknown {
    static IID := "{80600C1F-B90B-4896-82AD-1C00207909E8}"
    Call(pContextObject?, ppArguments, ppResult, ppMetadata?)
      => ComCall(3, this.p, IModelObject, pContextObject?, Int64, ppArguments.Length, IModelObject.Ptr, ppArguments, IModelObject.Ptr, ppResult, IKeyStore.Ptr, ppMetadata?)
}
struct IKeyEnumerator extends IUnknown {
    static IID := "{345FA92E-5E00-4319-9CAE-971F7601CDCF}"
    Reset()
      => ComCall(3, this.p)
    GetNext(key, value?, metadata?)
      => ComCall(4, this.p, BSTR.Ptr, key, IModelObject.Ptr, value?, IKeyStore.Ptr, metadata?)
}
struct IRawEnumerator extends IUnknown {
    static IID := "{E13613F9-3A3C-40B5-8F48-1E5EBFB9B21B}"
    Reset()
      => ComCall(3, this.p)
    GetNext(name?, kind?, value?)
      => ComCall(4, this.p, BSTR.Ptr, name?, SymbolKind.Ptr, kind?, IModelObject.Ptr, value?)
}
struct INamedModelsEnumerator extends IUnknown {
    static IID := "{47BBFC0B-0B20-4E0C-882B-465D6CCAC97C}"
    Reset()
      => ComCall(3, this.p)
    GetNext(pModelName, ppModel)
      => ComCall(4, this.p, BSTR.Ptr, pModelName, IModelObject.Ptr, ppModel)
}
struct IDataModelConcept extends IUnknown {
    static IID := "{FCB98D1D-1114-4FBF-B24C-EFFCB5DEF0D3}"
    InitializeObject(modelObject, matchingTypeSignature?, wildcardMatches?)
      => ComCall(3, this.p, IModelObject, modelObject, IDebugHostTypeSignature, matchingTypeSignature?, IDebugHostSymbolEnumerator, wildcardMatches?)
    GetName(modelName)
      => ComCall(4, this.p, BSTR.Ptr, modelName)
}
struct IStringDisplayableConcept extends IUnknown {
    static IID := "{D28E8D70-6C00-4205-940D-501016601EA3}"
    ToDisplayString(contextObject, metadata?, displayString)
      => ComCall(3, this.p, IModelObject, contextObject, IKeyStore, metadata?, BSTR.Ptr, displayString)
}
struct ICodeAddressConcept extends IUnknown {
    static IID := "{C7371568-5C78-4A00-A4AB-6EF8823184CB}"
    GetContainingSymbol(pContextObject, ppSymbol)
      => ComCall(3, this.p, IModelObject, pContextObject, IDebugHostSymbol.Ptr, ppSymbol)
}
struct IModelIterator extends IUnknown {
    static IID := "{E4622136-927D-4490-874F-581F3E4E3688}"
    Reset()
      => ComCall(3, this.p)
    GetNext(object, indexers?, metadata?)
      => ComCall(4, this.p, IModelObject.Ptr, object, Int64, indexers?.Length ?? 0, IModelObject.Ptr, indexers?, IKeyStore.Ptr, metadata?)
}
struct WrappedObjectPreference extends Int32 {
    static WrappedObjectNameResolution := 0
    static WrappedObjectGeneralProxy := 1
}
struct IObjectWrapperConcept extends IUnknown {
    static IID := "{A4952C59-7144-4C76-873B-6046C0955FFC}"
    GetWrappedObject(pContextObject, wrappedObject, pUsagePreference)
      => ComCall(3, this.p, IModelObject, pContextObject, IModelObject.Ptr, wrappedObject, WrappedObjectPreference.Ptr, pUsagePreference)
}
struct IIterableConcept extends IUnknown {
    static IID := "{F5D49D0C-0B02-4301-9C9B-B3A6037628F3}"
    GetDefaultIndexDimensionality(contextObject, dimensionality)
      => ComCall(3, this.p, IModelObject, contextObject, Int64.Ptr, dimensionality)
    GetIterator(contextObject, iterator)
      => ComCall(4, this.p, IModelObject, contextObject, IModelIterator.Ptr, iterator)
}
struct IIndexableConcept extends IUnknown {
    static IID := "{D1FAD99F-3F53-4457-850C-8051DF2D3FB5}"
    GetDimensionality(contextObject, dimensionality)
      => ComCall(3, this.p, IModelObject, contextObject, Int64.Ptr, dimensionality)
    GetAt(contextObject, indexers, object, metadata?)
      => ComCall(4, this.p, IModelObject, contextObject, Int64, indexers.Length, IModelObject.Ptr, indexers, IModelObject.Ptr, object, IKeyStore.Ptr, metadata?)
    SetAt(contextObject, indexers, value)
      => ComCall(5, this.p, IModelObject, contextObject, Int64, indexers.Length, IModelObject.Ptr, indexers, IModelObject, value)
}
struct IPreferredRuntimeTypeConcept extends IUnknown {
    static IID := "{9D6C1D7B-A76F-4618-8068-5F76BD9A4E8A}"
    CastToPreferredRuntimeType(contextObject, object)
      => ComCall(3, this.p, IModelObject, contextObject, IModelObject.Ptr, object)
}
struct IDebugHost extends IUnknown {
    static IID := "{B8C74943-6B2C-4EEB-B5C5-35D378A6D99D}"
    GetHostDefinedInterface(hostUnk)
      => ComCall(3, this.p, IUnknown.Ptr, hostUnk)
    GetCurrentContext(context)
      => ComCall(4, this.p, IDebugHostContext.Ptr, context)
    GetDefaultMetadata(defaultMetadataStore)
      => ComCall(5, this.p, IKeyStore.Ptr, defaultMetadataStore)
}
struct IDebugHostContext extends IUnknown {
    static IID := "{A68C70D8-5EC0-46E5-B775-3134A48EA2E3}"
    IsEqualTo(pContext, pIsEqual)
      => ComCall(3, this.p, IDebugHostContext, pContext, Boolean8.Ptr, pIsEqual)
}
struct AddressSpaceRelation extends Int32 {
    static Disjoint := 0
    static Equal := 1
    static Overlapping := 2
    static Subset := 3
    static Superset := 4
}
struct IDebugHostContext2 extends IDebugHostContext {
    static IID := "{E92274A2-47F4-4538-A196-B83DB25FE403}"
    GetAddressSpaceRelation(pContext, pAddressSpaceRelation)
      => ComCall(4, this.p, IDebugHostContext2, pContext, AddressSpaceRelation.Ptr, pAddressSpaceRelation)
}
struct IDebugHostContextExtension extends IUnknown {
    static IID := "{5E67115D-5449-4553-A9E9-CA446578CAB2}"
    AddExtensionData(blobId, data)
      => ComCall(3, this.p, UInt32, blobId, UInt32, data.Length, Struct.Ptr, data)
    FinalizeContext(immutableContext)
      => ComCall(4, this.p, IDebugHostContext.Ptr, immutableContext)
}
struct IDebugHostContextExtensibility extends IUnknown {
    static IID := "{35AE8E40-F234-4EF1-B8EA-0DFBC58A2043}"
    HasExtensionData(blobId)
      => ComCall(3, this.p, UInt32, blobId, Boolean8)
    ReadExtensionData(blobId, buffer)
      => ComCall(4, this.p, UInt32, blobId, UInt32, buffer.Length, Struct.Ptr, buffer)
    CloneContextForModification(extensionHandle)
      => ComCall(5, this.p, IDebugHostContextExtension.Ptr, extensionHandle)
    CloneContextWithModification(blobId, data, clonedContext)
      => ComCall(6, this.p, UInt32, blobId, UInt32, data.Length, Struct.Ptr, data, IDebugHostContext.Ptr, clonedContext)
}
struct IDebugHostContextControl extends IUnknown {
    static IID := "{EEB8FB43-B44E-4B0F-B871-65F0886FCAF2}"
    SwitchTo()
      => ComCall(3, this.p)
    GetContextAlternator(contextAlternator)
      => ComCall(4, this.p, IDebugHostContextAlternator.Ptr, contextAlternator)
}
struct IDebugHostContextAlternator extends IUnknown {
    static IID := "{6301EEE8-85E3-4058-A7C0-D37E0EA65F75}"
    SwitchTo(fullSwitch)
      => ComCall(3, this.p, UInt8, fullSwitch)
    SwitchBack()
      => ComCall(4, this.p)
}
struct ErrorClass extends Int32 {
    static ErrorClassWarning := 0
    static ErrorClassError := 1
}
struct IDebugHostErrorSink extends IUnknown {
    static IID := "{C8FF0F0B-FCE9-467E-8BB3-5D69EF109C00}"
    ReportError(errClass, hrError, message)
      => ComCall(3, this.p, ErrorClass, errClass, HRESULT, hrError, "Str", message)
}
struct IDebugHostSymbol extends IUnknown {
    static IID := "{0F819103-87DE-4E96-8277-E05CD441FB22}"
    GetContext(context)
      => ComCall(3, this.p, IDebugHostContext.Ptr, context)
    EnumerateChildren(kind, name?, ppEnum)
      => ComCall(4, this.p, SymbolKind, kind, "Str", name?, IDebugHostSymbolEnumerator.Ptr, ppEnum)
    GetSymbolKind(kind)
      => ComCall(5, this.p, SymbolKind.Ptr, kind)
    GetName(symbolName)
      => ComCall(6, this.p, BSTR.Ptr, symbolName)
    GetType(type)
      => ComCall(7, this.p, IDebugHostType.Ptr, type)
    GetContainingModule(containingModule)
      => ComCall(8, this.p, IDebugHostModule.Ptr, containingModule)
    CompareAgainst(pComparisonSymbol, comparisonFlags, pMatches)
      => ComCall(9, this.p, IDebugHostSymbol, pComparisonSymbol, UInt32, comparisonFlags, Boolean8.Ptr, pMatches)
}
struct IDebugHostSymbolEnumerator extends IUnknown {
    static IID := "{28D96C86-10A3-4976-B14E-EAEF4790AA1F}"
    Reset()
      => ComCall(3, this.p)
    GetNext(symbol)
      => ComCall(4, this.p, IDebugHostSymbol.Ptr, symbol)
}
struct IDebugHostSymbolSubstitutionEnumerator extends IDebugHostSymbolEnumerator {
    static IID := "{D49EECE8-8D12-4CE1-AB73-E5B63DF4F9D3}"
    GetNextWithSubstitutionText(symbol?, symbolText?)
      => ComCall(5, this.p, IDebugHostSymbol.Ptr, symbol?, BSTR.Ptr, symbolText?)
}
struct IDebugHostModule extends IDebugHostSymbol {
    static IID := "{C9BA3E18-D070-4378-BBD0-34613B346E1E}"
    GetImageName(allowPath, imageName)
      => ComCall(10, this.p, UInt8, allowPath, BSTR.Ptr, imageName)
    GetBaseLocation(moduleBaseLocation)
      => ComCall(11, this.p, Location.Ptr, moduleBaseLocation)
    GetVersion(fileVersion?, productVersion?)
      => ComCall(12, this.p, Int64.Ptr, fileVersion?, Int64.Ptr, productVersion?)
    FindTypeByName(typeName, type)
      => ComCall(13, this.p, "Str", typeName, IDebugHostType.Ptr, type)
    FindSymbolByRVA(rva, symbol)
      => ComCall(14, this.p, Int64, rva, IDebugHostSymbol.Ptr, symbol)
    FindSymbolByName(symbolName, symbol)
      => ComCall(15, this.p, "Str", symbolName, IDebugHostSymbol.Ptr, symbol)
}
struct IDebugHostModule2 extends IDebugHostModule {
    static IID := "{B51887E8-BCD0-4E8F-A8C7-434398B78C37}"
    FindContainingSymbolByRVA(rva, symbol, offset)
      => ComCall(16, this.p, Int64, rva, IDebugHostSymbol.Ptr, symbol, Int64.Ptr, offset)
}
struct IDebugHostModule3 extends IDebugHostModule2 {
    static IID := "{68576417-9FAB-4C69-8977-3A4D87CF08FD}"
    GetRange(moduleStart, moduleEnd)
      => ComCall(17, this.p, Location.Ptr, moduleStart, Location.Ptr, moduleEnd)
}
struct IDebugHostModule4 extends IDebugHostModule3 {
    static IID := "{41415136-38A4-474F-8E98-57E2DC64E565}"
    FindTypeByName2(pEnclosingSymbol?, typeName, type)
      => ComCall(18, this.p, IDebugHostSymbol, pEnclosingSymbol?, "Str", typeName, IDebugHostType.Ptr, type)
}
struct KnownCompiler extends Int32 {
    static CompilerUnknown := 0
    static CompilerMSVC := 1
    static CompilerGCC := 2
    static CompilerClang := 3
    static CompilerRustC := 4
}
struct IDebugHostModule5 extends IDebugHostModule4 {
    static IID := "{ED36A63D-AD2B-467E-A0CA-4CA949357625}"
    GetPrimaryCompilerInformation(pCompilerId, pPrimaryCompilerString?)
      => ComCall(19, this.p, KnownCompiler.Ptr, pCompilerId, BSTR.Ptr, pPrimaryCompilerString?)
}
struct IDebugHostModule6 extends IDebugHostModule5 {
    static IID := "{10EFC47E-68D4-4F87-810F-6729A805940A}"
    GetArchitectureByRVA(rva, pMachineArchitecture, pRangeRvaStart?, pRangeRvaEnd?)
      => ComCall(20, this.p, Int64, rva, UInt32.Ptr, pMachineArchitecture, Int64.Ptr, pRangeRvaStart?, Int64.Ptr, pRangeRvaEnd?)
}
struct ArrayDimension {
    LowerBound : Int64
    Length : Int64
    Stride : Int64
}
struct IDebugHostType extends IDebugHostSymbol {
    static IID := "{3AADC353-2B14-4ABB-9893-5E03458E07EE}"
    GetTypeKind(kind)
      => ComCall(10, this.p, TypeKind.Ptr, kind)
    GetSize(size)
      => ComCall(11, this.p, Int64.Ptr, size)
    GetBaseType(baseType)
      => ComCall(12, this.p, IDebugHostType.Ptr, baseType)
    GetHashCode(hashCode)
      => ComCall(13, this.p, UInt32.Ptr, hashCode)
    GetIntrinsicType(intrinsicKind?, carrierType?)
      => ComCall(14, this.p, IntrinsicKind.Ptr, intrinsicKind?, UInt16.Ptr, carrierType?)
    GetBitField(lsbOfField, lengthOfField)
      => ComCall(15, this.p, UInt32.Ptr, lsbOfField, UInt32.Ptr, lengthOfField)
    GetPointerKind(pointerKind)
      => ComCall(16, this.p, PointerKind.Ptr, pointerKind)
    GetMemberType(memberType)
      => ComCall(17, this.p, IDebugHostType.Ptr, memberType)
    CreatePointerTo(kind, newType)
      => ComCall(18, this.p, PointerKind, kind, IDebugHostType.Ptr, newType)
    GetArrayDimensionality(arrayDimensionality)
      => ComCall(19, this.p, Int64.Ptr, arrayDimensionality)
    GetArrayDimensions(pDimensions)
      => ComCall(20, this.p, Int64, pDimensions.Length, ArrayDimension.Ptr, pDimensions)
    CreateArrayOf(pDimensions, newType)
      => ComCall(21, this.p, Int64, pDimensions.Length, ArrayDimension.Ptr, pDimensions, IDebugHostType.Ptr, newType)
    GetFunctionCallingConvention(conventionKind)
      => ComCall(22, this.p, CallingConventionKind.Ptr, conventionKind)
    GetFunctionReturnType(returnType)
      => ComCall(23, this.p, IDebugHostType.Ptr, returnType)
    GetFunctionParameterTypeCount(count)
      => ComCall(24, this.p, Int64.Ptr, count)
    GetFunctionParameterTypeAt(i, parameterType)
      => ComCall(25, this.p, Int64, i, IDebugHostType.Ptr, parameterType)
    IsGeneric(isGeneric)
      => ComCall(26, this.p, Boolean8.Ptr, isGeneric)
    GetGenericArgumentCount(argCount)
      => ComCall(27, this.p, Int64.Ptr, argCount)
    GetGenericArgumentAt(i, argument)
      => ComCall(28, this.p, Int64, i, IDebugHostSymbol.Ptr, argument)
}
struct VarArgsKind extends Int32 {
    static VarArgsNone := 0
    static VarArgsCStyle := 1
}
struct IDebugHostType2 extends IDebugHostType {
    static IID := "{B28632B9-8506-4676-87CE-8F7E05E59876}"
    IsTypedef(isTypedef)
      => ComCall(29, this.p, Boolean8.Ptr, isTypedef)
    GetTypedefBaseType(baseType)
      => ComCall(30, this.p, IDebugHostType2.Ptr, baseType)
    GetTypedefFinalBaseType(finalBaseType)
      => ComCall(31, this.p, IDebugHostType2.Ptr, finalBaseType)
    GetFunctionVarArgsKind(varArgsKind)
      => ComCall(32, this.p, VarArgsKind.Ptr, varArgsKind)
    GetFunctionInstancePointerType(instancePointerType)
      => ComCall(33, this.p, IDebugHostType2.Ptr, instancePointerType)
}
struct IDebugHostType3 extends IDebugHostType2 {
    static IID := "{8B0409AC-C1BB-433D-887A-ED12C3AF0E7D}"
    GetContainingType(containingParentType)
      => ComCall(34, this.p, IDebugHostType3.Ptr, containingParentType)
}
struct ExtendedArrayDimensionFlags extends Int32 {
    static ExtendedArrayLengthIsOffset32 := 1
    static ExtendedArrayLengthIsOffset64 := 2
    static ExtendedArrayLengthIsOffset := 3
    static ExtendedArrayLowerBoundIsOffset32 := 4
    static ExtendedArrayLowerBoundIsOffset64 := 8
    static ExtendedArrayLowerBoundIsOffset := 12
    static ExtendedArrayStrideIsOffset32 := 16
    static ExtendedArrayStrideIsOffset64 := 32
    static ExtendedArrayStrideIsOffset := 48
    static ExtendedArrayStrideIsComputedByNextRank := 64
    static ExtendedArrayStrideIsComputedByPreviousRank := 128
    static ExtendedArrayStrideIsComputed := 192
}
struct ExtendedArrayDimension {
    DimensionFlags : Int64
    LowerBound : Int64
    Length : Int64
    Stride : Int64
}
struct UDTKind extends Int32 {
    static UDTStruct := 0
    static UDTClass := 1
    static UDTUnion := 2
    static UDTInterface := 3
    static UDTTaggedUnion := 4
}
struct IDebugHostType4 extends IDebugHostType3 {
    static IID := "{77D3CDC6-BD55-42BF-A4FD-D9AA60E3C1E1}"
    GetExtendedArrayHeaderSize(headerSize)
      => ComCall(35, this.p, Int64.Ptr, headerSize)
    GetExtendedArrayDimensions(pDimensions)
      => ComCall(36, this.p, Int64, pDimensions.Length, ExtendedArrayDimension.Ptr, pDimensions)
    GetUDTKind(udtKind)
      => ComCall(37, this.p, UDTKind.Ptr, udtKind)
}
struct IDebugHostType5 extends IDebugHostType4 {
    static IID := "{DB6716CE-8EE8-4C86-89DB-A658915C87F4}"
    IsBaseTypeOf(pOtherType, pIsBase)
      => ComCall(38, this.p, IDebugHostType, pOtherType, Boolean8.Ptr, pIsBase)
}
struct IDebugHostType6 extends IDebugHostType5 {
    static IID := "{08B431ED-F684-4480-8C44-B543AA32CEB0}"
    GetTaggedUnionTag(pTagType, pTagOffset, pTagMask)
      => ComCall(39, this.p, IDebugHostType.Ptr, pTagType, UInt32.Ptr, pTagOffset, VARIANT.Ptr, pTagMask)
    GetTaggedUnionTagRanges(pTagRangeEnumerator)
      => ComCall(40, this.p, IDebugHostTaggedUnionRangeEnumerator.Ptr, pTagRangeEnumerator)
    UpcastToTaggedUnionType(pTaggedUnionType, pUpcastedCaseType)
      => ComCall(41, this.p, IDebugHostType, pTaggedUnionType, IDebugHostType.Ptr, pUpcastedCaseType)
}
struct IDebugHostTaggedUnionRangeEnumerator extends IUnknown {
    static IID := "{F4A035C0-4CA0-4B6D-BFD2-B378A0DBFE4C}"
    Reset()
      => ComCall(3, this.p)
    GetNext(pLow, pHigh)
      => ComCall(4, this.p, VARIANT.Ptr, pLow, VARIANT.Ptr, pHigh)
    GetCount(pCount)
      => ComCall(5, this.p, UInt32.Ptr, pCount)
}
struct IDebugHostConstant extends IDebugHostSymbol {
    static IID := "{62787EDC-FA76-4690-BD71-5E8C3E2937EC}"
    GetValue(value)
      => ComCall(10, this.p, VARIANT.Ptr, value)
}
struct IDebugHostField extends IDebugHostSymbol {
    static IID := "{E06F6495-16BC-4CC9-B11D-2A6B23FA72F3}"
    GetLocationKind(locationKind)
      => ComCall(10, this.p, LocationKind.Ptr, locationKind)
    GetOffset(offset)
      => ComCall(11, this.p, Int64.Ptr, offset)
    GetLocation(location)
      => ComCall(12, this.p, Location.Ptr, location)
    GetValue(value)
      => ComCall(13, this.p, VARIANT.Ptr, value)
}
struct IDebugHostField2 extends IDebugHostField {
    static IID := "{99468A0B-EA92-4BD4-9EFE-A266160578CA}"
    GetContainingType(containingParentType)
      => ComCall(14, this.p, IDebugHostType3.Ptr, containingParentType)
}
struct IDebugHostData extends IDebugHostSymbol {
    static IID := "{A3D64993-826C-44FA-897D-926F2FE7AD0B}"
    GetLocationKind(locationKind)
      => ComCall(10, this.p, LocationKind.Ptr, locationKind)
    GetLocation(location)
      => ComCall(11, this.p, Location.Ptr, location)
    GetValue(value)
      => ComCall(12, this.p, VARIANT.Ptr, value)
}
struct IDebugHostPublic extends IDebugHostSymbol {
    static IID := "{6C597AC9-FB4D-4F6D-9F39-22488539F8F4}"
    GetLocationKind(locationKind)
      => ComCall(10, this.p, LocationKind.Ptr, locationKind)
    GetLocation(location)
      => ComCall(11, this.p, Location.Ptr, location)
}
struct IDebugHostBaseClass extends IDebugHostSymbol {
    static IID := "{B94D57D2-390B-40F7-B5B4-B6DB897D974B}"
    GetOffset(offset)
      => ComCall(10, this.p, Int64.Ptr, offset)
}
struct IDebugHostBaseClass2 extends IDebugHostBaseClass {
    static IID := "{435460E2-FD3B-4275-B36C-88EF50188588}"
    IsVirtual(pIsVirtual)
      => ComCall(11, this.p, Boolean8.Ptr, pIsVirtual)
    GetVirtualBaseOffsetLocation(pTableOffset, pSlotOffset, pSlotSize, pSlotIsSigned)
      => ComCall(12, this.p, Int64.Ptr, pTableOffset, Int64.Ptr, pSlotOffset, Int64.Ptr, pSlotSize, Boolean8.Ptr, pSlotIsSigned)
}
struct IDebugHostSymbols extends IUnknown {
    static IID := "{854FD751-C2E1-4EB2-B525-6619CB97A588}"
    CreateModuleSignature(pwszModuleName, pwszMinVersion?, pwszMaxVersion?, ppModuleSignature)
      => ComCall(3, this.p, "Str", pwszModuleName, "Str", pwszMinVersion?, "Str", pwszMaxVersion?, IDebugHostModuleSignature.Ptr, ppModuleSignature)
    CreateTypeSignature(signatureSpecification, module?, typeSignature)
      => ComCall(4, this.p, "Str", signatureSpecification, IDebugHostModule, module?, IDebugHostTypeSignature.Ptr, typeSignature)
    CreateTypeSignatureForModuleRange(signatureSpecification, moduleName, minVersion?, maxVersion?, typeSignature)
      => ComCall(5, this.p, "Str", signatureSpecification, "Str", moduleName, "Str", minVersion?, "Str", maxVersion?, IDebugHostTypeSignature.Ptr, typeSignature)
    EnumerateModules(context, moduleEnum)
      => ComCall(6, this.p, IDebugHostContext, context, IDebugHostSymbolEnumerator.Ptr, moduleEnum)
    FindModuleByName(context, moduleName, module)
      => ComCall(7, this.p, IDebugHostContext, context, "Str", moduleName, IDebugHostModule.Ptr, module)
    FindModuleByLocation(context, moduleLocation, module)
      => ComCall(8, this.p, IDebugHostContext, context, Location, moduleLocation, IDebugHostModule.Ptr, module)
    GetMostDerivedObject(pContext?, location1, objectType, derivedLocation, derivedType)
      => ComCall(9, this.p, IDebugHostContext, pContext?, Location, location1, IDebugHostType, objectType, Location.Ptr, derivedLocation, IDebugHostType.Ptr, derivedType)
}
struct IDebugHostSymbols2 extends IDebugHostSymbols {
    static IID := "{6BAF1F48-65EE-4FF2-B3AF-10C7F21D38B2}"
    DemangleSymbolName(pSymbol, flags, pDemangledSymbolName)
      => ComCall(10, this.p, IDebugHostSymbol, pSymbol, UInt32, flags, BSTR.Ptr, pDemangledSymbolName)
}
struct IDebugHostSymbols3 extends IDebugHostSymbols2 {
    static IID := "{8535E318-4F4B-4ACE-A21B-AF9E134A4E9B}"
    CreateModuleSignature2(pwszModuleName, allowLooseNameMatch, pwszMinVersion?, pwszMaxVersion?, ppModuleSignature)
      => ComCall(11, this.p, "Str", pwszModuleName, UInt8, allowLooseNameMatch, "Str", pwszMinVersion?, "Str", pwszMaxVersion?, IDebugHostModuleSignature.Ptr, ppModuleSignature)
    CreateTypeSignatureForModuleRange2(signatureSpecification, moduleName, allowLooseNameMatch, minVersion?, maxVersion?, typeSignature)
      => ComCall(12, this.p, "Str", signatureSpecification, "Str", moduleName, UInt8, allowLooseNameMatch, "Str", minVersion?, "Str", maxVersion?, IDebugHostTypeSignature.Ptr, typeSignature)
}
struct IDebugHostMemory extends IUnknown {
    static IID := "{212149C9-9183-4A3E-B00E-4FD1DC95339B}"
    ReadBytes(context, location1, buffer, bytesRead?)
      => ComCall(3, this.p, IDebugHostContext, context, Location, location1, Struct.Ptr, buffer, Int64, buffer.Size, Int64.Ptr, bytesRead?)
    WriteBytes(context, location1, buffer, bytesWritten?)
      => ComCall(4, this.p, IDebugHostContext, context, Location, location1, Struct.Ptr, buffer, Int64, buffer.Size, Int64.Ptr, bytesWritten?)
    ReadPointers(context, location1, pointers)
      => ComCall(5, this.p, IDebugHostContext, context, Location, location1, Int64, pointers.Length, Int64.Ptr, pointers)
    WritePointers(context, location1, pointers)
      => ComCall(6, this.p, IDebugHostContext, context, Location, location1, Int64, pointers.Length, Int64.Ptr, pointers)
    GetDisplayStringForLocation(context, location1, verbose, locationName)
      => ComCall(7, this.p, IDebugHostContext, context, Location, location1, UInt8, verbose, BSTR.Ptr, locationName)
}
struct IDebugHostMemory2 extends IDebugHostMemory {
    static IID := "{EEA033DE-38F6-416B-A251-1D3771001270}"
    LinearizeLocation(context, location1, pLinearizedLocation)
      => ComCall(8, this.p, IDebugHostContext, context, Location, location1, Location.Ptr, pLinearizedLocation)
}
struct IDebugHostMemory3 extends IDebugHostMemory2 {
    static IID := "{A515ED09-2BF3-4499-BB03-553790079F84}"
    CanonicalizeLocation(context, location1, pCanonicalizedLocation)
      => ComCall(9, this.p, IDebugHostContext, context, Location, location1, Location.Ptr, pCanonicalizedLocation)
}
struct IDebugHostMemory4 extends IDebugHostMemory3 {
    static IID := "{FE6B3658-DA4B-44E3-8A58-6201322280E6}"
    GetPhysicalAddressLocation(physAddr, pPhysicalAddressLocation)
      => ComCall(10, this.p, Int64, physAddr, Location.Ptr, pPhysicalAddressLocation)
    IsPhysicalAddressLocation(pLocation)
      => ComCall(11, this.p, Location.Ptr, pLocation, Boolean8)
}
struct IDebugHostMemory5 extends IDebugHostMemory4 {
    static IID := "{DF033400-4912-46E9-BA62-6EF2EB4D87D4}"
    ReadIntrinsics(context, location1, vt, vals, intrinsicsRead)
      => ComCall(12, this.p, IDebugHostContext, context, Location, location1, UInt16, vt, Int64, vals.Length, VARIANT.Ptr, vals, Int64.Ptr, intrinsicsRead)
    ReadOrdinalIntrinsics(context, location1, ordinalSize, ordinalIsSigned, vals, intrinsicsRead)
      => ComCall(13, this.p, IDebugHostContext, context, Location, location1, Int64, ordinalSize, UInt8, ordinalIsSigned, Int64, vals.Length, VARIANT.Ptr, vals, Int64.Ptr, intrinsicsRead)
}
struct IDebugHostEvaluator extends IUnknown {
    static IID := "{0FEF9A21-577E-4997-AC7B-1C4883241D99}"
    EvaluateExpression(context, expression, bindingContext?, result, metadata?)
      => ComCall(3, this.p, IDebugHostContext, context, "Str", expression, IModelObject, bindingContext?, IModelObject.Ptr, result, IKeyStore.Ptr, metadata?)
    EvaluateExtendedExpression(context, expression, bindingContext?, result, metadata?)
      => ComCall(4, this.p, IDebugHostContext, context, "Str", expression, IModelObject, bindingContext?, IModelObject.Ptr, result, IKeyStore.Ptr, metadata?)
}
struct SignatureComparison extends Int32 {
    static Unrelated := 0
    static Ambiguous := 1
    static LessSpecific := 2
    static MoreSpecific := 3
    static Identical := 4
}
struct IDebugHostModuleSignature extends IUnknown {
    static IID := "{31E53A5A-01EE-4BBB-B899-4B46AE7D595C}"
    IsMatch(pModule, isMatch)
      => ComCall(3, this.p, IDebugHostModule, pModule, Boolean8.Ptr, isMatch)
}
struct IDebugHostTypeSignature extends IUnknown {
    static IID := "{3AADC353-2B14-4ABB-9893-5E03458E07EE}"
    GetHashCode(hashCode)
      => ComCall(3, this.p, UInt32.Ptr, hashCode)
    IsMatch(type, isMatch, wildcardMatches?)
      => ComCall(4, this.p, IDebugHostType, type, Boolean8.Ptr, isMatch, IDebugHostSymbolEnumerator.Ptr, wildcardMatches?)
    CompareAgainst(typeSignature, result)
      => ComCall(5, this.p, IDebugHostTypeSignature, typeSignature, SignatureComparison.Ptr, result)
}
struct SymbolSearchOptions extends Int32 {
    static SymbolSearchNone := 0
    static SymbolSearchCompletion := 1
    static SymbolSearchCaseInsensitive := 2
}
struct LanguageKind extends Int32 {
    static LanguageUnknown := 0
    static LanguageC := 1
    static LanguageCPP := 2
    static LanguageAssembly := 3
    static LanguageRust := 4
}
struct IDebugHostSymbol2 extends IDebugHostSymbol {
    static IID := "{21515B67-6720-4257-8A68-077DC944471C}"
    GetLanguage(pKind)
      => ComCall(10, this.p, LanguageKind.Ptr, pKind)
}
struct IDebugHostSymbol3 extends IDebugHostSymbol2 {
    static IID := "{1B3FC1B3-D03D-43E0-8EB0-9AA4BAA21EDB}"
    GetCompilerInformation(pCompilerId, pCompilerString?)
      => ComCall(11, this.p, KnownCompiler.Ptr, pCompilerId, BSTR.Ptr, pCompilerString?)
}
struct IDebugHostStatus extends IUnknown {
    static IID := "{4F3E1CE2-86B2-4C7A-9C65-D0A9D0EECF44}"
    PollUserInterrupt(interruptRequested)
      => ComCall(3, this.p, Boolean8.Ptr, interruptRequested)
}
struct IDebugHostStatus2 extends IDebugHostStatus {
    static IID := "{4A168D3F-04D0-49C4-8F9A-7B5B3108C6C6}"
    SetUserInterrupt()
      => ComCall(4, this.p)
    ClearUserInterrupt()
      => ComCall(5, this.p)
}
struct IDataModelScriptClient extends IUnknown {
    static IID := "{3B362B0E-89F0-46C6-A663-DFDC95194AEF}"
    ReportError(errClass, hrFail, message?, line, position)
      => ComCall(3, this.p, ErrorClass, errClass, HRESULT, hrFail, "Str", message?, UInt32, line, UInt32, position)
}
struct IDataModelScriptTemplate extends IUnknown {
    static IID := "{1303DEC4-FA3B-4F1B-9224-B953D16BABB5}"
    GetName(templateName)
      => ComCall(3, this.p, BSTR.Ptr, templateName)
    GetDescription(templateDescription)
      => ComCall(4, this.p, BSTR.Ptr, templateDescription)
    GetContent(contentStream)
      => ComCall(5, this.p, IStream.Ptr, contentStream)
}
struct IDataModelScript extends IUnknown {
    static IID := "{7B4D30FC-B14A-49F8-8D87-D9A1480C97F7}"
    GetName(scriptName)
      => ComCall(3, this.p, BSTR.Ptr, scriptName)
    Rename(scriptName)
      => ComCall(4, this.p, "Str", scriptName)
    Populate(contentStream)
      => ComCall(5, this.p, IStream, contentStream)
    Execute(client)
      => ComCall(6, this.p, IDataModelScriptClient, client)
    Unlink()
      => ComCall(7, this.p)
    IsInvocable(isInvocable)
      => ComCall(8, this.p, Boolean8.Ptr, isInvocable)
    InvokeMain(client)
      => ComCall(9, this.p, IDataModelScriptClient, client)
}
struct IDataModelScript2 extends IDataModelScript {
    static IID := "{7D90CF81-BEE2-4B91-9D49-8FEC0F7D56D1}"
    GetScriptFullFilePathName(scriptFullPathName)
      => ComCall(10, this.p, BSTR.Ptr, scriptFullPathName)
    SetScriptFullFilePathName(scriptFullPathName)
      => ComCall(11, this.p, "Str", scriptFullPathName)
}
struct IDataModelScriptTemplateEnumerator extends IUnknown {
    static IID := "{69CE6AE2-2268-4E6F-B062-20CE62BFE677}"
    Reset()
      => ComCall(3, this.p)
    GetNext(templateContent)
      => ComCall(4, this.p, IDataModelScriptTemplate.Ptr, templateContent)
}
struct IDataModelScriptProvider extends IUnknown {
    static IID := "{513461E0-4FCA-48CE-8658-32F3E2056F3B}"
    GetName(name)
      => ComCall(3, this.p, BSTR.Ptr, name)
    GetExtension(extension)
      => ComCall(4, this.p, BSTR.Ptr, extension)
    CreateScript(script)
      => ComCall(5, this.p, IDataModelScript.Ptr, script)
    GetDefaultTemplateContent(templateContent)
      => ComCall(6, this.p, IDataModelScriptTemplate.Ptr, templateContent)
    EnumerateTemplates(enumerator)
      => ComCall(7, this.p, IDataModelScriptTemplateEnumerator.Ptr, enumerator)
}
struct IDataModelScriptProviderEnumerator extends IUnknown {
    static IID := "{95BA00E2-704A-4FE2-A8F1-A7E7D8FB0941}"
    Reset()
      => ComCall(3, this.p)
    GetNext(provider)
      => ComCall(4, this.p, IDataModelScriptProvider.Ptr, provider)
}
struct IDataModelScriptManager extends IUnknown {
    static IID := "{6FD11E33-E5AD-410B-8011-68C6BC4BF80D}"
    GetDefaultNameBinder(ppNameBinder)
      => ComCall(3, this.p, IDataModelNameBinder.Ptr, ppNameBinder)
    RegisterScriptProvider(provider)
      => ComCall(4, this.p, IDataModelScriptProvider, provider)
    UnregisterScriptProvider(provider)
      => ComCall(5, this.p, IDataModelScriptProvider, provider)
    FindProviderForScriptType(scriptType, provider)
      => ComCall(6, this.p, "Str", scriptType, IDataModelScriptProvider.Ptr, provider)
    FindProviderForScriptExtension(scriptExtension, provider)
      => ComCall(7, this.p, "Str", scriptExtension, IDataModelScriptProvider.Ptr, provider)
    EnumerateScriptProviders(enumerator)
      => ComCall(8, this.p, IDataModelScriptProviderEnumerator.Ptr, enumerator)
}
struct IDynamicKeyProviderConcept extends IUnknown {
    static IID := "{E7983FA1-80A7-498C-988F-518DDC5D4025}"
    GetKey(contextObject, key, keyValue?, metadata?, hasKey?)
      => ComCall(3, this.p, IModelObject, contextObject, "Str", key, IModelObject.Ptr, keyValue?, IKeyStore.Ptr, metadata?, Boolean8.Ptr, hasKey?)
    SetKey(contextObject, key, keyValue, metadata)
      => ComCall(4, this.p, IModelObject, contextObject, "Str", key, IModelObject, keyValue, IKeyStore, metadata)
    EnumerateKeys(contextObject, ppEnumerator)
      => ComCall(5, this.p, IModelObject, contextObject, IKeyEnumerator.Ptr, ppEnumerator)
}
struct IDynamicConceptProviderConcept extends IUnknown {
    static IID := "{95A7F7DD-602E-483F-9D06-A15C0EE13174}"
    GetConcept(contextObject, conceptId, conceptInterface, conceptMetadata?, hasConcept)
      => ComCall(3, this.p, IModelObject, contextObject, GUID.Ptr, conceptId, IUnknown.Ptr, conceptInterface, IKeyStore.Ptr, conceptMetadata?, Boolean8.Ptr, hasConcept)
    SetConcept(contextObject, conceptId, conceptInterface, conceptMetadata?)
      => ComCall(4, this.p, IModelObject, contextObject, GUID.Ptr, conceptId, IUnknown, conceptInterface, IKeyStore, conceptMetadata?)
    NotifyParent(parentModel)
      => ComCall(5, this.p, IModelObject, parentModel)
    NotifyParentChange(parentModel)
      => ComCall(6, this.p, IModelObject, parentModel)
    NotifyDestruct()
      => ComCall(7, this.p)
}
struct ScriptChangeKind extends Int32 {
    static ScriptRename := 0
}
struct IDataModelScriptHostContext extends IUnknown {
    static IID := "{014D366A-1F23-4981-9219-B2DB8B402054}"
    NotifyScriptChange(script, changeKind)
      => ComCall(3, this.p, IDataModelScript, script, ScriptChangeKind, changeKind)
    GetNamespaceObject(namespaceObject)
      => ComCall(4, this.p, IModelObject.Ptr, namespaceObject)
}
struct IDebugHostScriptHost extends IUnknown {
    static IID := "{B70334A4-B92C-4570-93A1-D3EB686649A0}"
    CreateContext(script, scriptContext)
      => ComCall(3, this.p, IDataModelScript, script, IDataModelScriptHostContext.Ptr, scriptContext)
}
struct IDataModelNameBinder extends IUnknown {
    static IID := "{AF352B7B-8292-4C01-B360-2DC3696C65E7}"
    BindValue(contextObject, name, value, metadata?)
      => ComCall(3, this.p, IModelObject, contextObject, "Str", name, IModelObject.Ptr, value, IKeyStore.Ptr, metadata?)
    BindReference(contextObject, name, reference, metadata?)
      => ComCall(4, this.p, IModelObject, contextObject, "Str", name, IModelObject.Ptr, reference, IKeyStore.Ptr, metadata?)
    EnumerateValues(contextObject, enumerator)
      => ComCall(5, this.p, IModelObject, contextObject, IKeyEnumerator.Ptr, enumerator)
    EnumerateReferences(contextObject, enumerator)
      => ComCall(6, this.p, IModelObject, contextObject, IKeyEnumerator.Ptr, enumerator)
}
struct IModelKeyReference2 extends IModelKeyReference {
    static IID := "{80E2F7C5-7159-4E92-887E-7E0347E88406}"
    OverrideContextObject(newContextObject)
      => ComCall(10, this.p, IModelObject, newContextObject)
}
struct IDebugHostEvaluator2 extends IDebugHostEvaluator {
    static IID := "{A117A435-1FB4-4092-A2AB-A929576C1E87}"
    AssignTo(assignmentReference, assignmentValue, assignmentResult, assignmentMetadata?)
      => ComCall(5, this.p, IModelObject, assignmentReference, IModelObject, assignmentValue, IModelObject.Ptr, assignmentResult, IKeyStore.Ptr, assignmentMetadata?)
}
struct IDebugHostEvaluator3 extends IDebugHostEvaluator2 {
    static IID := "{D2419F4A-7E8D-4C15-A499-73902B015ABB}"
    Compare(pLeft, pRight, ppResult)
      => ComCall(6, this.p, IModelObject, pLeft, IModelObject, pRight, IModelObject.Ptr, ppResult)
}
struct IDebugHostExtensibility extends IUnknown {
    static IID := "{3C2B24E1-11D0-4F86-8AE5-4DF166F73253}"
    CreateFunctionAlias(aliasName, functionObject)
      => ComCall(3, this.p, "Str", aliasName, IModelObject, functionObject)
    DestroyFunctionAlias(aliasName)
      => ComCall(4, this.p, "Str", aliasName)
}
struct IDebugHostExtensibility2 extends IDebugHostExtensibility {
    static IID := "{91CC55E7-2A22-4494-9710-B729DAB48F71}"
    CreateFunctionAliasWithMetadata(aliasName, functionObject, metadata?)
      => ComCall(5, this.p, "Str", aliasName, IModelObject, functionObject, IKeyStore, metadata?)
}
struct IDebugHostExtensibility3 extends IDebugHostExtensibility2 {
    static IID := "{4BE234DE-D397-4378-BBB4-9055A425D7D1}"
    ExtendHostContext(blobSize, identifier, blobId)
      => ComCall(6, this.p, UInt32, blobSize, GUID.Ptr, identifier, UInt32.Ptr, blobId)
    QueryHostContextExtension(identifier, blobId, blobSize)
      => ComCall(7, this.p, GUID.Ptr, identifier, UInt32.Ptr, blobId, UInt32.Ptr, blobSize)
    ReleaseHostContextExtension(blobId)
      => ComCall(8, this.p, UInt32, blobId)
}
struct ScriptDebugState extends Int32 {
    static ScriptDebugNoDebugger := 0
    static ScriptDebugNotExecuting := 1
    static ScriptDebugExecuting := 2
    static ScriptDebugBreak := 3
}
struct ScriptDebugEventFilter extends Int32 {
    static ScriptDebugEventFilterEntry := 0
    static ScriptDebugEventFilterException := 1
    static ScriptDebugEventFilterUnhandledException := 2
    static ScriptDebugEventFilterAbort := 3
}
struct ScriptDebugEvent extends Int32 {
    static ScriptDebugBreakpoint := 0
    static ScriptDebugStep := 1
    static ScriptDebugException := 2
    static ScriptDebugAsyncBreak := 3
}
struct ScriptExecutionKind extends Int32 {
    static ScriptExecutionNormal := 0
    static ScriptExecutionStepIn := 1
    static ScriptExecutionStepOut := 2
    static ScriptExecutionStepOver := 3
}
struct ScriptDebugPosition {
    Line : UInt32
    Column : UInt32
}
struct ScriptDebugEventInformation {
    DebugEvent : ScriptDebugEvent
    EventPosition : ScriptDebugPosition
    EventSpanEnd : ScriptDebugPosition
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            ExceptionInformation : this._ExceptionInformation_e__Struct
            BreakpointInformation : this._BreakpointInformation_e__Struct
        }
        struct _ExceptionInformation_e__Struct {
            IsUncaught : UInt8
        }
        struct _BreakpointInformation_e__Struct {
            BreakpointId : Int64
        }
    }
}
struct IDataModelScriptDebugClient extends IUnknown {
    static IID := "{53159B6D-D4C4-471B-A863-5B110CA800CA}"
    NotifyDebugEvent(pEventInfo, pScript, pEventDataObject?, resumeEventKind)
      => ComCall(3, this.p, ScriptDebugEventInformation.Ptr, pEventInfo, IDataModelScript, pScript, IModelObject, pEventDataObject?, ScriptExecutionKind.Ptr, resumeEventKind)
}
struct IDataModelScriptDebugVariableSetEnumerator extends IUnknown {
    static IID := "{0F9FEED7-D045-4AC3-98A8-A98942CF6A35}"
    Reset()
      => ComCall(3, this.p)
    GetNext(variableName, variableValue?, variableMetadata?)
      => ComCall(4, this.p, BSTR.Ptr, variableName, IModelObject.Ptr, variableValue?, IKeyStore.Ptr, variableMetadata?)
}
struct IDataModelScriptDebugStackFrame extends IUnknown {
    static IID := "{DEC6ED5E-6360-4941-AB4C-A26409DE4F82}"
    GetName(name)
      => ComCall(3, this.p, BSTR.Ptr, name)
    GetPosition(position, positionSpanEnd?, lineText?)
      => ComCall(4, this.p, ScriptDebugPosition.Ptr, position, ScriptDebugPosition.Ptr, positionSpanEnd?, BSTR.Ptr, lineText?)
    IsTransitionPoint(isTransitionPoint)
      => ComCall(5, this.p, Boolean8.Ptr, isTransitionPoint)
    GetTransition(transitionScript, isTransitionContiguous)
      => ComCall(6, this.p, IDataModelScript.Ptr, transitionScript, Boolean8.Ptr, isTransitionContiguous)
    Evaluate(pwszExpression, ppResult)
      => ComCall(7, this.p, "Str", pwszExpression, IModelObject.Ptr, ppResult)
    EnumerateLocals(variablesEnum)
      => ComCall(8, this.p, IDataModelScriptDebugVariableSetEnumerator.Ptr, variablesEnum)
    EnumerateArguments(variablesEnum)
      => ComCall(9, this.p, IDataModelScriptDebugVariableSetEnumerator.Ptr, variablesEnum)
}
struct IDataModelScriptDebugStack extends IUnknown {
    static IID := "{051364DD-E449-443E-9762-FE578F4A5473}"
    GetFrameCount()
      => ComCall(3, this.p, Int64)
    GetStackFrame(frameNumber, stackFrame)
      => ComCall(4, this.p, Int64, frameNumber, IDataModelScriptDebugStackFrame.Ptr, stackFrame)
}
struct IDataModelScriptDebugBreakpoint extends IUnknown {
    static IID := "{6BB27B35-02E6-47CB-90A0-5371244032DE}"
    GetId()
      => ComCall(3, this.p, Int64)
    IsEnabled()
      => ComCall(4, this.p, Boolean8)
    Enable()
      => ComCall(5, this.p, "void")
    Disable()
      => ComCall(6, this.p, "void")
    Remove()
      => ComCall(7, this.p, "void")
    GetPosition(position, positionSpanEnd?, lineText?)
      => ComCall(8, this.p, ScriptDebugPosition.Ptr, position, ScriptDebugPosition.Ptr, positionSpanEnd?, BSTR.Ptr, lineText?)
}
struct IDataModelScriptDebugBreakpointEnumerator extends IUnknown {
    static IID := "{39484A75-B4F3-4799-86DA-691AFA57B299}"
    Reset()
      => ComCall(3, this.p)
    GetNext(breakpoint)
      => ComCall(4, this.p, IDataModelScriptDebugBreakpoint.Ptr, breakpoint)
}
struct IDataModelScriptDebug extends IUnknown {
    static IID := "{DE8E0945-9750-4471-AB76-A8F79D6EC350}"
    GetDebugState()
      => ComCall(3, this.p, ScriptDebugState)
    GetCurrentPosition(currentPosition, positionSpanEnd?, lineText?)
      => ComCall(4, this.p, ScriptDebugPosition.Ptr, currentPosition, ScriptDebugPosition.Ptr, positionSpanEnd?, BSTR.Ptr, lineText?)
    GetStack(stack)
      => ComCall(5, this.p, IDataModelScriptDebugStack.Ptr, stack)
    SetBreakpoint(linePosition, columnPosition, breakpoint)
      => ComCall(6, this.p, UInt32, linePosition, UInt32, columnPosition, IDataModelScriptDebugBreakpoint.Ptr, breakpoint)
    FindBreakpointById(breakpointId, breakpoint)
      => ComCall(7, this.p, Int64, breakpointId, IDataModelScriptDebugBreakpoint.Ptr, breakpoint)
    EnumerateBreakpoints(breakpointEnum)
      => ComCall(8, this.p, IDataModelScriptDebugBreakpointEnumerator.Ptr, breakpointEnum)
    GetEventFilter(eventFilter, isBreakEnabled)
      => ComCall(9, this.p, ScriptDebugEventFilter, eventFilter, Boolean8.Ptr, isBreakEnabled)
    SetEventFilter(eventFilter, isBreakEnabled)
      => ComCall(10, this.p, ScriptDebugEventFilter, eventFilter, UInt8, isBreakEnabled)
    StartDebugging(debugClient)
      => ComCall(11, this.p, IDataModelScriptDebugClient, debugClient)
    StopDebugging(debugClient)
      => ComCall(12, this.p, IDataModelScriptDebugClient, debugClient)
}
struct IDataModelScriptDebug2 extends IDataModelScriptDebug {
    static IID := "{CBB10ED3-839E-426C-9243-E23535C1AE1A}"
    SetBreakpointAtFunction(functionName, breakpoint)
      => ComCall(13, this.p, "Str", functionName, IDataModelScriptDebugBreakpoint.Ptr, breakpoint)
}
struct IComparableConcept extends IUnknown {
    static IID := "{A7830646-9F0C-4A31-BA19-503F33E6C8A3}"
    CompareObjects(contextObject, otherObject, comparisonResult)
      => ComCall(3, this.p, IModelObject, contextObject, IModelObject, otherObject, Int32.Ptr, comparisonResult)
}
struct IEquatableConcept extends IUnknown {
    static IID := "{C52D5D3D-609D-4D5D-8A82-46B0ACDEC4F4}"
    AreObjectsEqual(contextObject, otherObject, isEqual)
      => ComCall(3, this.p, IModelObject, contextObject, IModelObject, otherObject, Boolean8.Ptr, isEqual)
}
struct IActionEnumerator extends IUnknown {
    static IID := "{3DEC5C44-F63A-4CA6-90F0-FD5C269FDA59}"
    Reset()
      => ComCall(3, this.p)
    GetNext(keyName, actionName, actionDescription, actionIsDefault, actionMethod?, metadta?)
      => ComCall(4, this.p, BSTR.Ptr, keyName, BSTR.Ptr, actionName, BSTR.Ptr, actionDescription, Boolean8.Ptr, actionIsDefault, IModelObject.Ptr, actionMethod?, IKeyStore.Ptr, metadta?)
}
struct IActionableConcept extends IUnknown {
    static IID := "{2CD9906F-F1B3-4463-828A-0ADDAFE8BAAE}"
    EnumerateActions(contextObject, actionEnumerator)
      => ComCall(3, this.p, IModelObject, contextObject, IActionEnumerator.Ptr, actionEnumerator)
}
struct IActionQueryConcept extends IUnknown {
    static IID := "{7FC09C9F-632D-48E8-A97B-2F4F2E5C1161}"
    EnumerateActions(contextObject, actionEnumerator)
      => ComCall(3, this.p, IModelObject, contextObject, IActionEnumerator.Ptr, actionEnumerator)
}
struct IConstructableConcept extends IUnknown {
    static IID := "{1A9409F1-F0E0-4B48-9A4E-5783548FB57A}"
    CreateInstance(ppArguments, ppInstance)
      => ComCall(3, this.p, Int64, ppArguments.Length, IModelObject.Ptr, ppArguments, IModelObject.Ptr, ppInstance)
}
struct IDeconstructableConcept extends IUnknown {
    static IID := "{F798139E-1B2C-4077-8D87-9FA5D044F3EB}"
    GetConstructableModelName(contextObject, constructableModelName)
      => ComCall(3, this.p, IModelObject, contextObject, BSTR.Ptr, constructableModelName)
    GetConstructorArgumentCount(contextObject, argCount)
      => ComCall(4, this.p, IModelObject, contextObject, Int64.Ptr, argCount)
    GetConstructorArguments(contextObject, constructorArguments)
      => ComCall(5, this.p, IModelObject, contextObject, Int64, constructorArguments.Length, IModelObject.Ptr, constructorArguments)
}
struct StorageKind extends Int32 {
    static StorageUnknown := 0
    static StorageRegister := 1
    static StorageRegisterRelative := 2
    static StorageRegisterRelativeIndirect := 3
}
struct IDebugHostFunctionLocalStorage extends IUnknown {
    static IID := "{2F2F303B-39BE-4B6D-9BFB-4FAA49DBBD45}"
    GetValidRange(start, end, guaranteed)
      => ComCall(3, this.p, Int64.Ptr, start, Int64.Ptr, end, Boolean8.Ptr, guaranteed)
    GetStorageKind(kind)
      => ComCall(4, this.p, StorageKind.Ptr, kind)
    GetRegister(registerId)
      => ComCall(5, this.p, UInt32.Ptr, registerId)
    GetOffset(offset)
      => ComCall(6, this.p, Int64.Ptr, offset)
}
struct IDebugHostFunctionLocalStorage2 extends IUnknown {
    static IID := "{213B3725-36A2-45A0-9EA4-854D46D85195}"
    GetExtendedRegisterAddressInfo(registerId, offset, isIndirectAccess, indirectOffset)
      => ComCall(3, this.p, UInt32.Ptr, registerId, Int64.Ptr, offset, Boolean8.Ptr, isIndirectAccess, Int32.Ptr, indirectOffset)
}
struct IDebugHostFunctionLocalStorageEnumerator extends IUnknown {
    static IID := "{026C9E81-8B9F-4D32-9606-A394EC62B045}"
    Reset()
      => ComCall(3, this.p)
    GetNext(storage)
      => ComCall(4, this.p, IDebugHostFunctionLocalStorage.Ptr, storage)
}
struct LocalKind extends Int32 {
    static LocalArgument := 0
    static LocalVariable := 1
}
struct IDebugHostFunctionLocalDetails extends IUnknown {
    static IID := "{89280EA8-B3B9-408C-BE16-32AB28F5C0AC}"
    GetName(name)
      => ComCall(3, this.p, BSTR.Ptr, name)
    GetType(localType)
      => ComCall(4, this.p, IDebugHostType.Ptr, localType)
    EnumerateStorage(storageEnum)
      => ComCall(5, this.p, IDebugHostFunctionLocalStorageEnumerator.Ptr, storageEnum)
    GetLocalKind(kind)
      => ComCall(6, this.p, LocalKind.Ptr, kind)
    GetArgumentPosition(argPosition)
      => ComCall(7, this.p, Int64.Ptr, argPosition)
}
struct IDebugHostFunctionLocalDetails2 extends IDebugHostFunctionLocalDetails {
    static IID := "{199A57B0-1967-4363-B25E-90C7E8A07F22}"
    IsInlineScope()
      => ComCall(8, this.p, Boolean8)
    GetInlinedFunction(inlineFunction)
      => ComCall(9, this.p, IDebugHostSymbol.Ptr, inlineFunction)
}
struct IDebugHostFunctionLocalDetailsEnumerator extends IUnknown {
    static IID := "{A61ADC36-1ED5-40FE-A976-6A21CD81E811}"
    Reset()
      => ComCall(3, this.p)
    GetNext(localDetails)
      => ComCall(4, this.p, IDebugHostFunctionLocalDetails.Ptr, localDetails)
}
struct IDebugHostFunctionIntrospection extends IUnknown {
    static IID := "{A754393C-4FBE-4178-8AD5-FE6079AC048D}"
    EnumerateLocalsDetails(localsEnum)
      => ComCall(3, this.p, IDebugHostFunctionLocalDetailsEnumerator.Ptr, localsEnum)
    EnumerateInlineFunctionsByRVA(rva, inlinesEnum)
      => ComCall(4, this.p, Int64, rva, IDebugHostSymbolEnumerator.Ptr, inlinesEnum)
    FindContainingCodeRangeByRVA(rva, rangeStart, rangeEnd)
      => ComCall(5, this.p, Int64, rva, Location.Ptr, rangeStart, Location.Ptr, rangeEnd)
    FindSourceLocationByRVA(rva, sourceFile, sourceLine)
      => ComCall(6, this.p, Int64, rva, BSTR.Ptr, sourceFile, Int64.Ptr, sourceLine)
}
struct IDebugHostFunctionIntrospection2 extends IDebugHostFunctionIntrospection {
    static IID := "{8E1CB118-AA83-409A-AAE9-C7FF78911A5F}"
    EnumerateLocalsDetailsEx(enumerateInlinedLocals, localsEnum)
      => ComCall(7, this.p, UInt8, enumerateInlinedLocals, IDebugHostFunctionLocalDetailsEnumerator.Ptr, localsEnum)
}
struct IDebugHostFunctionIntrospection3 extends IDebugHostFunctionIntrospection2 {
    static IID := "{A24E286B-891A-40FC-8A3A-89B66EDDCE57}"
    IsNoReturnFunction(pIsNoReturnFunction)
      => ComCall(8, this.p, Boolean8.Ptr, pIsNoReturnFunction)
}
struct IDebugHostFunctionIntrospection4 extends IDebugHostFunctionIntrospection3 {
    static IID := "{F93F6699-1F2E-4FB2-8164-363A78F7914E}"
    GetPrologueRange(pPrologueStart, pPrologueEnd)
      => ComCall(9, this.p, Location.Ptr, pPrologueStart, Location.Ptr, pPrologueEnd)
    GetEpilogueRange(pEpilogueStart, pEpilogueEnd)
      => ComCall(10, this.p, Location.Ptr, pEpilogueStart, Location.Ptr, pEpilogueEnd)
}
struct IFilteredNamespacePropertyToken extends IUnknown {
    static IID := "{63832802-2DB3-4DE7-B76C-197AC15B5EC6}"
    RemoveFilter()
      => ComCall(3, this.p)
    GetFilter(ppFilter)
      => ComCall(4, this.p, IModelMethod.Ptr, ppFilter)
    TrySetFilter(pFilter)
      => ComCall(5, this.p, IModelMethod, pFilter)
}
struct IDebugHostContextTargetComposition extends IUnknown {
    static IID := "{3D06878F-97AB-4C5B-955E-FA647D3B137C}"
    GetServiceManager(ppServiceManager)
      => ComCall(3, this.p, IDebugServiceManager.Ptr.Ptr, ppServiceManager)
    GetServiceProcess(ppProcess)
      => ComCall(4, this.p, ISvcProcess.Ptr.Ptr, ppProcess)
    GetServiceThread(ppThread)
      => ComCall(5, this.p, ISvcThread.Ptr.Ptr, ppThread)
}
struct IDebugHostSymbolsTargetComposition extends IUnknown {
    static IID := "{3C4B6ADD-80E1-4C2B-AFE1-9A1132586DD0}"
    GetTypeForServiceType(pServiceManager, pModule, pType, ppHostType)
      => ComCall(3, this.p, IDebugServiceManager.Ptr, pServiceManager, ISvcModule.Ptr, pModule, ISvcSymbolType.Ptr, pType, IDebugHostType.Ptr, ppHostType)
}
struct PWINDBG_OUTPUT_ROUTINE extends FunctionPointer {
    static Types := [PSTR, "Void"]
    static Options := "C"
}
struct PWINDBG_GET_EXPRESSION extends FunctionPointer {
    static Types := [PSTR, IntPtr]
}
struct PWINDBG_GET_EXPRESSION32 extends FunctionPointer {
    static Types := [PSTR, UInt32]
}
struct PWINDBG_GET_EXPRESSION64 extends FunctionPointer {
    static Types := [PSTR, Int64]
}
struct PWINDBG_GET_SYMBOL extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, IntPtr.Ptr, "Void"]
}
struct PWINDBG_GET_SYMBOL32 extends FunctionPointer {
    static Types := [UInt32, PSTR, UInt32.Ptr, "Void"]
}
struct PWINDBG_GET_SYMBOL64 extends FunctionPointer {
    static Types := [Int64, PSTR, Int64.Ptr, "Void"]
}
struct PWINDBG_DISASM extends FunctionPointer {
    static Types := [IntPtr.Ptr, PSTR, UInt32, UInt32]
}
struct PWINDBG_DISASM32 extends FunctionPointer {
    static Types := [UInt32.Ptr, PSTR, UInt32, UInt32]
}
struct PWINDBG_DISASM64 extends FunctionPointer {
    static Types := [Int64.Ptr, PSTR, UInt32, UInt32]
}
struct PWINDBG_CHECK_CONTROL_C extends FunctionPointer {
    static Types := [UInt32]
}
struct PWINDBG_READ_PROCESS_MEMORY_ROUTINE extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PWINDBG_READ_PROCESS_MEMORY_ROUTINE32 extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PWINDBG_READ_PROCESS_MEMORY_ROUTINE64 extends FunctionPointer {
    static Types := [Int64, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE extends FunctionPointer {
    static Types := [IntPtr, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE32 extends FunctionPointer {
    static Types := [UInt32, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE64 extends FunctionPointer {
    static Types := [Int64, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PWINDBG_GET_THREAD_CONTEXT_ROUTINE extends FunctionPointer {
    static Types := [UInt32, CONTEXT.Ptr, UInt32, UInt32]
}
struct PWINDBG_SET_THREAD_CONTEXT_ROUTINE extends FunctionPointer {
    static Types := [UInt32, CONTEXT.Ptr, UInt32, UInt32]
}
struct PWINDBG_IOCTL_ROUTINE extends FunctionPointer {
    static Types := [UInt16, Struct.Ptr, UInt32, UInt32]
}
struct PWINDBG_OLDKD_READ_PHYSICAL_MEMORY extends FunctionPointer {
    static Types := [Int64, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct PWINDBG_OLDKD_WRITE_PHYSICAL_MEMORY extends FunctionPointer {
    static Types := [Int64, Struct.Ptr, UInt32, UInt32.Ptr, UInt32]
}
struct EXTSTACKTRACE {
    FramePointer : UInt32
    ProgramCounter : UInt32
    ReturnAddress : UInt32
    Args : UInt32[4]
}
struct EXTSTACKTRACE32 {
    FramePointer : UInt32
    ProgramCounter : UInt32
    ReturnAddress : UInt32
    Args : UInt32[4]
}
struct EXTSTACKTRACE64 {
    FramePointer : Int64
    ProgramCounter : Int64
    ReturnAddress : Int64
    Args : Int64[4]
}
struct PWINDBG_STACKTRACE_ROUTINE extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, EXTSTACKTRACE.Ptr, UInt32, UInt32]
}
struct PWINDBG_STACKTRACE_ROUTINE32 extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32, EXTSTACKTRACE32.Ptr, UInt32, UInt32]
}
struct PWINDBG_STACKTRACE_ROUTINE64 extends FunctionPointer {
    static Types := [Int64, Int64, Int64, EXTSTACKTRACE64.Ptr, UInt32, UInt32]
}
struct WINDBG_EXTENSION_APIS {
    nSize : UInt32
    lpOutputRoutine : PWINDBG_OUTPUT_ROUTINE
    lpGetExpressionRoutine : PWINDBG_GET_EXPRESSION
    lpGetSymbolRoutine : PWINDBG_GET_SYMBOL
    lpDisasmRoutine : PWINDBG_DISASM
    lpCheckControlCRoutine : PWINDBG_CHECK_CONTROL_C
    lpReadProcessMemoryRoutine : PWINDBG_READ_PROCESS_MEMORY_ROUTINE
    lpWriteProcessMemoryRoutine : PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE
    lpGetThreadContextRoutine : PWINDBG_GET_THREAD_CONTEXT_ROUTINE
    lpSetThreadContextRoutine : PWINDBG_SET_THREAD_CONTEXT_ROUTINE
    lpIoctlRoutine : PWINDBG_IOCTL_ROUTINE
    lpStackTraceRoutine : PWINDBG_STACKTRACE_ROUTINE
}
struct WINDBG_EXTENSION_APIS32 {
    nSize : UInt32
    lpOutputRoutine : PWINDBG_OUTPUT_ROUTINE
    lpGetExpressionRoutine : PWINDBG_GET_EXPRESSION32
    lpGetSymbolRoutine : PWINDBG_GET_SYMBOL32
    lpDisasmRoutine : PWINDBG_DISASM32
    lpCheckControlCRoutine : PWINDBG_CHECK_CONTROL_C
    lpReadProcessMemoryRoutine : PWINDBG_READ_PROCESS_MEMORY_ROUTINE32
    lpWriteProcessMemoryRoutine : PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE32
    lpGetThreadContextRoutine : PWINDBG_GET_THREAD_CONTEXT_ROUTINE
    lpSetThreadContextRoutine : PWINDBG_SET_THREAD_CONTEXT_ROUTINE
    lpIoctlRoutine : PWINDBG_IOCTL_ROUTINE
    lpStackTraceRoutine : PWINDBG_STACKTRACE_ROUTINE32
}
struct WINDBG_EXTENSION_APIS64 {
    nSize : UInt32
    lpOutputRoutine : PWINDBG_OUTPUT_ROUTINE
    lpGetExpressionRoutine : PWINDBG_GET_EXPRESSION64
    lpGetSymbolRoutine : PWINDBG_GET_SYMBOL64
    lpDisasmRoutine : PWINDBG_DISASM64
    lpCheckControlCRoutine : PWINDBG_CHECK_CONTROL_C
    lpReadProcessMemoryRoutine : PWINDBG_READ_PROCESS_MEMORY_ROUTINE64
    lpWriteProcessMemoryRoutine : PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE64
    lpGetThreadContextRoutine : PWINDBG_GET_THREAD_CONTEXT_ROUTINE
    lpSetThreadContextRoutine : PWINDBG_SET_THREAD_CONTEXT_ROUTINE
    lpIoctlRoutine : PWINDBG_IOCTL_ROUTINE
    lpStackTraceRoutine : PWINDBG_STACKTRACE_ROUTINE64
}
struct WINDBG_OLD_EXTENSION_APIS {
    nSize : UInt32
    lpOutputRoutine : PWINDBG_OUTPUT_ROUTINE
    lpGetExpressionRoutine : PWINDBG_GET_EXPRESSION
    lpGetSymbolRoutine : PWINDBG_GET_SYMBOL
    lpDisasmRoutine : PWINDBG_DISASM
    lpCheckControlCRoutine : PWINDBG_CHECK_CONTROL_C
}
struct WINDBG_OLDKD_EXTENSION_APIS {
    nSize : UInt32
    lpOutputRoutine : PWINDBG_OUTPUT_ROUTINE
    lpGetExpressionRoutine : PWINDBG_GET_EXPRESSION32
    lpGetSymbolRoutine : PWINDBG_GET_SYMBOL32
    lpDisasmRoutine : PWINDBG_DISASM32
    lpCheckControlCRoutine : PWINDBG_CHECK_CONTROL_C
    lpReadVirtualMemRoutine : PWINDBG_READ_PROCESS_MEMORY_ROUTINE32
    lpWriteVirtualMemRoutine : PWINDBG_WRITE_PROCESS_MEMORY_ROUTINE32
    lpReadPhysicalMemRoutine : PWINDBG_OLDKD_READ_PHYSICAL_MEMORY
    lpWritePhysicalMemRoutine : PWINDBG_OLDKD_WRITE_PHYSICAL_MEMORY
}
struct PWINDBG_OLD_EXTENSION_ROUTINE extends FunctionPointer {
    static Types := [UInt32, WINDBG_EXTENSION_APIS.Ptr, PSTR, "Void"]
}
struct PWINDBG_EXTENSION_ROUTINE extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt32, UInt32, PSTR, "Void"]
}
struct PWINDBG_EXTENSION_ROUTINE32 extends FunctionPointer {
    static Types := [HANDLE, HANDLE, UInt32, UInt32, PSTR, "Void"]
}
struct PWINDBG_EXTENSION_ROUTINE64 extends FunctionPointer {
    static Types := [HANDLE, HANDLE, Int64, UInt32, PSTR, "Void"]
}
struct PWINDBG_OLDKD_EXTENSION_ROUTINE extends FunctionPointer {
    static Types := [UInt32, WINDBG_OLDKD_EXTENSION_APIS.Ptr, PSTR, "Void"]
}
struct PWINDBG_EXTENSION_DLL_INIT extends FunctionPointer {
    static Types := [WINDBG_EXTENSION_APIS.Ptr, UInt16, UInt16, "Void"]
}
struct PWINDBG_EXTENSION_DLL_INIT32 extends FunctionPointer {
    static Types := [WINDBG_EXTENSION_APIS32.Ptr, UInt16, UInt16, "Void"]
}
struct PWINDBG_EXTENSION_DLL_INIT64 extends FunctionPointer {
    static Types := [WINDBG_EXTENSION_APIS64.Ptr, UInt16, UInt16, "Void"]
}
struct PWINDBG_CHECK_VERSION extends FunctionPointer {
    static Types := [UInt32]
}
struct EXT_API_VERSION {
    MajorVersion : UInt16
    MinorVersion : UInt16
    Revision : UInt16
    Reserved : UInt16
}
struct PWINDBG_EXTENSION_API_VERSION extends FunctionPointer {
    static Types := [EXT_API_VERSION.Ptr]
}
struct PROCESSORINFO {
    Processor : UInt16
    NumberProcessors : UInt16
}
struct READCONTROLSPACE {
    Processor : UInt16
    Address : UInt32
    BufLen : UInt32
    Buf : UInt8[1]
}
struct READCONTROLSPACE32 {
    Processor : UInt16
    Address : UInt32
    BufLen : UInt32
    Buf : UInt8[1]
}
struct READCONTROLSPACE64 {
    Processor : UInt16
    Address : Int64
    BufLen : UInt32
    Buf : UInt8[1]
}
struct IOSPACE {
    Address : UInt32
    Length : UInt32
    Data : UInt32
}
struct IOSPACE32 {
    Address : UInt32
    Length : UInt32
    Data : UInt32
}
struct IOSPACE64 {
    Address : Int64
    Length : UInt32
    Data : UInt32
}
struct IOSPACE_EX {
    Address : UInt32
    Length : UInt32
    Data : UInt32
    InterfaceType : UInt32
    BusNumber : UInt32
    AddressSpace : UInt32
}
struct IOSPACE_EX32 {
    Address : UInt32
    Length : UInt32
    Data : UInt32
    InterfaceType : UInt32
    BusNumber : UInt32
    AddressSpace : UInt32
}
struct IOSPACE_EX64 {
    Address : Int64
    Length : UInt32
    Data : UInt32
    InterfaceType : UInt32
    BusNumber : UInt32
    AddressSpace : UInt32
}
struct BUSDATA {
    BusDataType : UInt32
    BusNumber : UInt32
    SlotNumber : UInt32
    Buffer : Struct.Ptr
    Offset : UInt32
    Length : UInt32
}
struct SEARCHMEMORY {
    SearchAddress : Int64
    SearchLength : Int64
    FoundAddress : Int64
    PatternLength : UInt32
    Pattern : Struct.Ptr
}
struct PHYSICAL {
    Address : Int64
    BufLen : UInt32
    Buf : UInt8[1]
}
struct PHYSICAL_WITH_FLAGS {
    Address : Int64
    BufLen : UInt32
    Flags : UInt32
    Buf : UInt8[1]
}
struct READ_WRITE_MSR {
    Msr : UInt32
    Value : Int64
}
struct GET_SET_SYMPATH {
    Args : PSTR
    Result : PSTR
    Length : Int32
}
struct GET_TEB_ADDRESS {
    Address : Int64
}
struct GET_PEB_ADDRESS {
    CurrentThread : Int64
    Address : Int64
}
struct GET_CURRENT_THREAD_ADDRESS {
    Processor : UInt32
    Address : Int64
}
struct GET_CURRENT_PROCESS_ADDRESS {
    Processor : UInt32
    CurrentThread : Int64
    Address : Int64
}
struct GET_INPUT_LINE {
    Prompt : PSTR
    Buffer : PSTR
    BufferSize : UInt32
    InputSize : UInt32
}
struct GET_EXPRESSION_EX {
    Expression : PSTR
    Remainder : PSTR
    Value : Int64
}
struct TRANSLATE_VIRTUAL_TO_PHYSICAL {
    Virtual : Int64
    Physical : Int64
}
struct VIRTUAL_TO_PHYSICAL {
    Status : UInt32
    Size : UInt32
    PdeAddress : Int64
    Virtual : Int64
    Physical : Int64
}
struct PHYSICAL_TO_VIRTUAL {
    Status : UInt32
    Size : UInt32
    PdeAddress : Int64
}
struct GET_CONTEXT_EX {
    Status : UInt32
    ContextSize : UInt32
    pContext : Struct.Ptr
}
struct POINTER_SEARCH_PHYSICAL {
    Offset : Int64
    Length : Int64
    PointerMin : Int64
    PointerMax : Int64
    Flags : UInt32
    MatchOffsets : Int64.Ptr
    MatchOffsetsSize : UInt32
    MatchOffsetsCount : UInt32
}
struct WDBGEXTS_THREAD_OS_INFO {
    ThreadId : UInt32
    ExitStatus : UInt32
    PriorityClass : UInt32
    Priority : UInt32
    CreateTime : Int64
    ExitTime : Int64
    KernelTime : Int64
    UserTime : Int64
    StartOffset : Int64
    Affinity : Int64
}
struct WDBGEXTS_CLR_DATA_INTERFACE {
    Iid : GUID.Ptr
    Iface : Struct.Ptr
}
struct EXT_MATCH_PATTERN_A {
    Str : PSTR
    Pattern : PSTR
    CaseSensitive : UInt32
}
struct EXT_FIND_FILE {
    FileName : PWSTR
    IndexedSize : Int64
    ImageTimeDateStamp : UInt32
    ImageCheckSum : UInt32
    ExtraInfo : Struct.Ptr
    ExtraInfoSize : UInt32
    Flags : UInt32
    FileMapping : Struct.Ptr
    FileMappingSize : Int64
    FileHandle : HANDLE
    FoundFileName : PWSTR
    FoundFileNameChars : UInt32
}
struct DEBUG_TYPED_DATA {
    ModBase : Int64
    Offset : Int64
    EngineHandle : Int64
    Data : Int64
    Size : UInt32
    Flags : UInt32
    TypeId : UInt32
    BaseTypeId : UInt32
    Tag : UInt32
    Register : UInt32
    Internal : Int64[9]
}
struct EXT_TDOP extends Int32 {
    static EXT_TDOP_COPY := 0
    static EXT_TDOP_RELEASE := 1
    static EXT_TDOP_SET_FROM_EXPR := 2
    static EXT_TDOP_SET_FROM_U64_EXPR := 3
    static EXT_TDOP_GET_FIELD := 4
    static EXT_TDOP_EVALUATE := 5
    static EXT_TDOP_GET_TYPE_NAME := 6
    static EXT_TDOP_OUTPUT_TYPE_NAME := 7
    static EXT_TDOP_OUTPUT_SIMPLE_VALUE := 8
    static EXT_TDOP_OUTPUT_FULL_VALUE := 9
    static EXT_TDOP_HAS_FIELD := 10
    static EXT_TDOP_GET_FIELD_OFFSET := 11
    static EXT_TDOP_GET_ARRAY_ELEMENT := 12
    static EXT_TDOP_GET_DEREFERENCE := 13
    static EXT_TDOP_GET_TYPE_SIZE := 14
    static EXT_TDOP_OUTPUT_TYPE_DEFINITION := 15
    static EXT_TDOP_GET_POINTER_TO := 16
    static EXT_TDOP_SET_FROM_TYPE_ID_AND_U64 := 17
    static EXT_TDOP_SET_PTR_FROM_TYPE_ID_AND_U64 := 18
    static EXT_TDOP_COUNT := 19
}
struct EXT_TYPED_DATA {
    Operation : EXT_TDOP
    Flags : UInt32
    InData : DEBUG_TYPED_DATA
    OutData : DEBUG_TYPED_DATA
    InStrIndex : UInt32
    In32 : UInt32
    Out32 : UInt32
    In64 : Int64
    Out64 : Int64
    StrBufferIndex : UInt32
    StrBufferChars : UInt32
    StrCharsNeeded : UInt32
    DataBufferIndex : UInt32
    DataBufferBytes : UInt32
    DataBytesNeeded : UInt32
    Status : HRESULT
    Reserved : Int64[8]
}
struct WDBGEXTS_QUERY_INTERFACE {
    Iid : GUID.Ptr
    Iface : Struct.Ptr
}
struct WDBGEXTS_DISASSEMBLE_BUFFER {
    InOffset : Int64
    OutOffset : Int64
    AddrFlags : UInt32
    FormatFlags : UInt32
    DataBufferBytes : UInt32
    DisasmBufferChars : UInt32
    DataBuffer : Struct.Ptr
    DisasmBuffer : PWSTR
    Reserved0 : Int64[3]
}
struct WDBGEXTS_MODULE_IN_RANGE {
    Start : Int64
    End : Int64
    FoundModBase : Int64
    FoundModSize : UInt32
}
struct DBGKD_MAJOR_TYPES extends Int32 {
    static DBGKD_MAJOR_NT := 0
    static DBGKD_MAJOR_XBOX := 1
    static DBGKD_MAJOR_BIG := 2
    static DBGKD_MAJOR_EXDI := 3
    static DBGKD_MAJOR_NTBD := 4
    static DBGKD_MAJOR_EFI := 5
    static DBGKD_MAJOR_TNT := 6
    static DBGKD_MAJOR_SINGULARITY := 7
    static DBGKD_MAJOR_HYPERVISOR := 8
    static DBGKD_MAJOR_MIDORI := 9
    static DBGKD_MAJOR_CE := 10
    static DBGKD_MAJOR_COUNT := 11
}
struct DBGKD_GET_VERSION32 {
    MajorVersion : UInt16
    MinorVersion : UInt16
    ProtocolVersion : UInt16
    Flags : UInt16
    KernBase : UInt32
    PsLoadedModuleList : UInt32
    MachineType : UInt16
    ThCallbackStack : UInt16
    NextCallback : UInt16
    FramePointer : UInt16
    KiCallUserMode : UInt32
    KeUserCallbackDispatcher : UInt32
    BreakpointWithStatus : UInt32
    DebuggerDataList : UInt32
}
struct DBGKD_DEBUG_DATA_HEADER32 {
    List : LIST_ENTRY32
    OwnerTag : UInt32
    Size : UInt32
}
struct KDDEBUGGER_DATA32 {
    Header : DBGKD_DEBUG_DATA_HEADER32
    KernBase : UInt32
    BreakpointWithStatus : UInt32
    SavedContext : UInt32
    ThCallbackStack : UInt16
    NextCallback : UInt16
    FramePointer : UInt16
    _bitfield : UInt16
    KiCallUserMode : UInt32
    KeUserCallbackDispatcher : UInt32
    PsLoadedModuleList : UInt32
    PsActiveProcessHead : UInt32
    PspCidTable : UInt32
    ExpSystemResourcesList : UInt32
    ExpPagedPoolDescriptor : UInt32
    ExpNumberOfPagedPools : UInt32
    KeTimeIncrement : UInt32
    KeBugCheckCallbackListHead : UInt32
    KiBugcheckData : UInt32
    IopErrorLogListHead : UInt32
    ObpRootDirectoryObject : UInt32
    ObpTypeObjectType : UInt32
    MmSystemCacheStart : UInt32
    MmSystemCacheEnd : UInt32
    MmSystemCacheWs : UInt32
    MmPfnDatabase : UInt32
    MmSystemPtesStart : UInt32
    MmSystemPtesEnd : UInt32
    MmSubsectionBase : UInt32
    MmNumberOfPagingFiles : UInt32
    MmLowestPhysicalPage : UInt32
    MmHighestPhysicalPage : UInt32
    MmNumberOfPhysicalPages : UInt32
    MmMaximumNonPagedPoolInBytes : UInt32
    MmNonPagedSystemStart : UInt32
    MmNonPagedPoolStart : UInt32
    MmNonPagedPoolEnd : UInt32
    MmPagedPoolStart : UInt32
    MmPagedPoolEnd : UInt32
    MmPagedPoolInformation : UInt32
    MmPageSize : UInt32
    MmSizeOfPagedPoolInBytes : UInt32
    MmTotalCommitLimit : UInt32
    MmTotalCommittedPages : UInt32
    MmSharedCommit : UInt32
    MmDriverCommit : UInt32
    MmProcessCommit : UInt32
    MmPagedPoolCommit : UInt32
    MmExtendedCommit : UInt32
    MmZeroedPageListHead : UInt32
    MmFreePageListHead : UInt32
    MmStandbyPageListHead : UInt32
    MmModifiedPageListHead : UInt32
    MmModifiedNoWritePageListHead : UInt32
    MmAvailablePages : UInt32
    MmResidentAvailablePages : UInt32
    PoolTrackTable : UInt32
    NonPagedPoolDescriptor : UInt32
    MmHighestUserAddress : UInt32
    MmSystemRangeStart : UInt32
    MmUserProbeAddress : UInt32
    KdPrintCircularBuffer : UInt32
    KdPrintCircularBufferEnd : UInt32
    KdPrintWritePointer : UInt32
    KdPrintRolloverCount : UInt32
    MmLoadedUserImageList : UInt32
}
struct DBGKD_GET_VERSION64 {
    MajorVersion : UInt16
    MinorVersion : UInt16
    ProtocolVersion : UInt8
    KdSecondaryVersion : UInt8
    Flags : UInt16
    MachineType : UInt16
    MaxPacketType : UInt8
    MaxStateChange : UInt8
    MaxManipulate : UInt8
    Simulation : UInt8
    Unused : UInt16[1]
    KernBase : Int64
    PsLoadedModuleList : Int64
    DebuggerDataList : Int64
}
struct DBGKD_DEBUG_DATA_HEADER64 {
    List : LIST_ENTRY64
    OwnerTag : UInt32
    Size : UInt32
}
struct KDDEBUGGER_DATA64 {
    Header : DBGKD_DEBUG_DATA_HEADER64
    KernBase : Int64
    BreakpointWithStatus : Int64
    SavedContext : Int64
    ThCallbackStack : UInt16
    NextCallback : UInt16
    FramePointer : UInt16
    _bitfield : UInt16
    KiCallUserMode : Int64
    KeUserCallbackDispatcher : Int64
    PsLoadedModuleList : Int64
    PsActiveProcessHead : Int64
    PspCidTable : Int64
    ExpSystemResourcesList : Int64
    ExpPagedPoolDescriptor : Int64
    ExpNumberOfPagedPools : Int64
    KeTimeIncrement : Int64
    KeBugCheckCallbackListHead : Int64
    KiBugcheckData : Int64
    IopErrorLogListHead : Int64
    ObpRootDirectoryObject : Int64
    ObpTypeObjectType : Int64
    MmSystemCacheStart : Int64
    MmSystemCacheEnd : Int64
    MmSystemCacheWs : Int64
    MmPfnDatabase : Int64
    MmSystemPtesStart : Int64
    MmSystemPtesEnd : Int64
    MmSubsectionBase : Int64
    MmNumberOfPagingFiles : Int64
    MmLowestPhysicalPage : Int64
    MmHighestPhysicalPage : Int64
    MmNumberOfPhysicalPages : Int64
    MmMaximumNonPagedPoolInBytes : Int64
    MmNonPagedSystemStart : Int64
    MmNonPagedPoolStart : Int64
    MmNonPagedPoolEnd : Int64
    MmPagedPoolStart : Int64
    MmPagedPoolEnd : Int64
    MmPagedPoolInformation : Int64
    MmPageSize : Int64
    MmSizeOfPagedPoolInBytes : Int64
    MmTotalCommitLimit : Int64
    MmTotalCommittedPages : Int64
    MmSharedCommit : Int64
    MmDriverCommit : Int64
    MmProcessCommit : Int64
    MmPagedPoolCommit : Int64
    MmExtendedCommit : Int64
    MmZeroedPageListHead : Int64
    MmFreePageListHead : Int64
    MmStandbyPageListHead : Int64
    MmModifiedPageListHead : Int64
    MmModifiedNoWritePageListHead : Int64
    MmAvailablePages : Int64
    MmResidentAvailablePages : Int64
    PoolTrackTable : Int64
    NonPagedPoolDescriptor : Int64
    MmHighestUserAddress : Int64
    MmSystemRangeStart : Int64
    MmUserProbeAddress : Int64
    KdPrintCircularBuffer : Int64
    KdPrintCircularBufferEnd : Int64
    KdPrintWritePointer : Int64
    KdPrintRolloverCount : Int64
    MmLoadedUserImageList : Int64
    NtBuildLab : Int64
    KiNormalSystemCall : Int64
    KiProcessorBlock : Int64
    MmUnloadedDrivers : Int64
    MmLastUnloadedDriver : Int64
    MmTriageActionTaken : Int64
    MmSpecialPoolTag : Int64
    KernelVerifier : Int64
    MmVerifierData : Int64
    MmAllocatedNonPagedPool : Int64
    MmPeakCommitment : Int64
    MmTotalCommitLimitMaximum : Int64
    CmNtCSDVersion : Int64
    MmPhysicalMemoryBlock : Int64
    MmSessionBase : Int64
    MmSessionSize : Int64
    MmSystemParentTablePage : Int64
    MmVirtualTranslationBase : Int64
    OffsetKThreadNextProcessor : UInt16
    OffsetKThreadTeb : UInt16
    OffsetKThreadKernelStack : UInt16
    OffsetKThreadInitialStack : UInt16
    OffsetKThreadApcProcess : UInt16
    OffsetKThreadState : UInt16
    OffsetKThreadBStore : UInt16
    OffsetKThreadBStoreLimit : UInt16
    SizeEProcess : UInt16
    OffsetEprocessPeb : UInt16
    OffsetEprocessParentCID : UInt16
    OffsetEprocessDirectoryTableBase : UInt16
    SizePrcb : UInt16
    OffsetPrcbDpcRoutine : UInt16
    OffsetPrcbCurrentThread : UInt16
    OffsetPrcbMhz : UInt16
    OffsetPrcbCpuType : UInt16
    OffsetPrcbVendorString : UInt16
    OffsetPrcbProcStateContext : UInt16
    OffsetPrcbNumber : UInt16
    SizeEThread : UInt16
    L1tfHighPhysicalBitIndex : UInt8
    L1tfSwizzleBitIndex : UInt8
    Padding0 : UInt32
    KdPrintCircularBufferPtr : Int64
    KdPrintBufferSize : Int64
    KeLoaderBlock : Int64
    SizePcr : UInt16
    OffsetPcrSelfPcr : UInt16
    OffsetPcrCurrentPrcb : UInt16
    OffsetPcrContainedPrcb : UInt16
    OffsetPcrInitialBStore : UInt16
    OffsetPcrBStoreLimit : UInt16
    OffsetPcrInitialStack : UInt16
    OffsetPcrStackLimit : UInt16
    OffsetPrcbPcrPage : UInt16
    OffsetPrcbProcStateSpecialReg : UInt16
    GdtR0Code : UInt16
    GdtR0Data : UInt16
    GdtR0Pcr : UInt16
    GdtR3Code : UInt16
    GdtR3Data : UInt16
    GdtR3Teb : UInt16
    GdtLdt : UInt16
    GdtTss : UInt16
    Gdt64R3CmCode : UInt16
    Gdt64R3CmTeb : UInt16
    IopNumTriageDumpDataBlocks : Int64
    IopTriageDumpDataBlocks : Int64
    VfCrashDataBlock : Int64
    MmBadPagesDetected : Int64
    MmZeroedPageSingleBitErrorsDetected : Int64
    EtwpDebuggerData : Int64
    OffsetPrcbContext : UInt16
    OffsetPrcbMaxBreakpoints : UInt16
    OffsetPrcbMaxWatchpoints : UInt16
    OffsetKThreadStackLimit : UInt32
    OffsetKThreadStackBase : UInt32
    OffsetKThreadQueueListEntry : UInt32
    OffsetEThreadIrpList : UInt32
    OffsetPrcbIdleThread : UInt16
    OffsetPrcbNormalDpcState : UInt16
    OffsetPrcbDpcStack : UInt16
    OffsetPrcbIsrStack : UInt16
    SizeKDPC_STACK_FRAME : UInt16
    OffsetKPriQueueThreadListHead : UInt16
    OffsetKThreadWaitReason : UInt16
    Padding1 : UInt16
    PteBase : Int64
    RetpolineStubFunctionTable : Int64
    RetpolineStubFunctionTableSize : UInt32
    RetpolineStubOffset : UInt32
    RetpolineStubSize : UInt32
    OffsetEProcessMmHotPatchContext : UInt16
    OffsetKThreadShadowStackLimit : UInt32
    OffsetKThreadShadowStackBase : UInt32
    ShadowStackEnabled : Int64
    PointerAuthMask : Int64
    OffsetPrcbExceptionStack : UInt16
    PointerIgnoreBits : Int64
}
struct PSYM_DUMP_FIELD_CALLBACK extends FunctionPointer {
    static Types := [FIELD_INFO.Ptr, Struct.Ptr, UInt32]
}
struct FIELD_INFO {
    fName : UInt8.Ptr
    printName : UInt8.Ptr
    size : UInt32
    fOptions : UInt32
    address : Int64
    Anonymous : this._Anonymous_e__Union
    TypeId : UInt32
    FieldOffset : UInt32
    BufferSize : UInt32
    BitField : this._BitField
    _bitfield : UInt32
    struct _Anonymous_e__Union {
        union {
            fieldCallBack : Struct.Ptr
            pBuffer : Struct.Ptr
        }
    }
    struct _BitField {
        Position : UInt16
        Size : UInt16
    }
}
struct SYM_DUMP_PARAM {
    size : UInt32
    sName : UInt8.Ptr
    Options : UInt32
    addr : Int64
    listLink : FIELD_INFO.Ptr
    Anonymous : this._Anonymous_e__Union
    CallbackRoutine : PSYM_DUMP_FIELD_CALLBACK
    nFields : UInt32
    Fields : FIELD_INFO.Ptr
    ModBase : Int64
    TypeId : UInt32
    TypeSize : UInt32
    BufferSize : UInt32
    _bitfield : UInt32
    struct _Anonymous_e__Union {
        union {
            Context : Struct.Ptr
            pBuffer : Struct.Ptr
        }
    }
}
struct POOL_HEADER_SIZE_64 {
    union {
        Anonymous : this._Anonymous_e__Struct
        Ulong1 : UInt32
    }
    struct _Anonymous_e__Struct {
        UnsafePrevSize : UInt8
        Unused1 : UInt8
        UnsafeSize : UInt8
        UnsafePoolType : UInt8
    }
}
struct POOL_HEADER_FIELD_NAME extends Int32 {
    static DbgkdPreviousSize := 0
    static DbgkdPoolIndex := 1
    static DbgkdBlockSize := 2
    static DbgkdPoolType := 3
    static DbgkdUlong1 := 4
}
struct DEBUG_DEVICE_OBJECT_INFO {
    SizeOfStruct : UInt32
    DevObjAddress : Int64
    ReferenceCount : UInt32
    QBusy : BOOL
    DriverObject : Int64
    CurrentIrp : Int64
    DevExtension : Int64
    DevObjExtension : Int64
}
struct PGET_DEVICE_OBJECT_INFO extends FunctionPointer {
    static Types := [IDebugClient, Int64, DEBUG_DEVICE_OBJECT_INFO.Ptr, HRESULT]
}
struct DEBUG_DRIVER_OBJECT_INFO {
    SizeOfStruct : UInt32
    DriverSize : UInt32
    DriverObjAddress : Int64
    DriverStart : Int64
    DriverExtension : Int64
    DeviceObject : Int64
    DriverName : this._DriverName_e__Struct
    struct _DriverName_e__Struct {
        Length : UInt16
        MaximumLength : UInt16
        Buffer : Int64
    }
}
struct PGET_DRIVER_OBJECT_INFO extends FunctionPointer {
    static Types := [IDebugClient, Int64, DEBUG_DRIVER_OBJECT_INFO.Ptr, HRESULT]
}
struct PROCESS_COMMIT_USAGE {
    ImageFileName : UInt8[16]
    ClientId : Int64
    ProcessAddress : Int64
    CommitCharge : Int64
    SharedCommitCharge : Int64
    ReleasedCommitDebt : Int64
    Reserved : Int64
}
struct PGET_PROCESS_COMMIT extends FunctionPointer {
    static Types := [IDebugClient, Int64.Ptr, UInt32.Ptr, PROCESS_COMMIT_USAGE.Ptr.Ptr, HRESULT]
}
struct PGET_FULL_IMAGE_NAME extends FunctionPointer {
    static Types := [IDebugClient, Int64, PSTR.Ptr, HRESULT]
}
struct DEBUG_CPU_SPEED_INFO {
    SizeOfStruct : UInt32
    CurrentSpeed : UInt32
    RatedSpeed : UInt32
    NameString : UInt16[256]
}
struct PGET_CPU_PSPEED_INFO extends FunctionPointer {
    static Types := [IDebugClient, DEBUG_CPU_SPEED_INFO.Ptr, HRESULT]
}
struct DEBUG_CPU_MICROCODE_VERSION {
    SizeOfStruct : UInt32
    CachedSignature : Int64
    InitialSignature : Int64
    ProcessorModel : UInt32
    ProcessorFamily : UInt32
    ProcessorStepping : UInt32
    ProcessorArchRev : UInt32
}
struct PGET_CPU_MICROCODE_VERSION extends FunctionPointer {
    static Types := [IDebugClient, DEBUG_CPU_MICROCODE_VERSION.Ptr, HRESULT]
}
struct DEBUG_SMBIOS_INFO {
    SizeOfStruct : UInt32
    SmbiosMajorVersion : UInt8
    SmbiosMinorVersion : UInt8
    DMIVersion : UInt8
    TableSize : UInt32
    BiosMajorRelease : UInt8
    BiosMinorRelease : UInt8
    FirmwareMajorRelease : UInt8
    FirmwareMinorRelease : UInt8
    BaseBoardManufacturer : CHAR[64]
    BaseBoardProduct : CHAR[64]
    BaseBoardVersion : CHAR[64]
    BiosReleaseDate : CHAR[64]
    BiosVendor : CHAR[64]
    BiosVersion : CHAR[64]
    SystemFamily : CHAR[64]
    SystemManufacturer : CHAR[64]
    SystemProductName : CHAR[64]
    SystemSKU : CHAR[64]
    SystemVersion : CHAR[64]
}
struct PGET_SMBIOS_INFO extends FunctionPointer {
    static Types := [IDebugClient, DEBUG_SMBIOS_INFO.Ptr, HRESULT]
}
struct DEBUG_IRP_STACK_INFO {
    Major : UInt8
    Minor : UInt8
    DeviceObject : Int64
    FileObject : Int64
    CompletionRoutine : Int64
    StackAddress : Int64
}
struct DEBUG_IRP_INFO {
    SizeOfStruct : UInt32
    IrpAddress : Int64
    IoStatus : UInt32
    StackCount : UInt32
    CurrentLocation : UInt32
    MdlAddress : Int64
    Thread : Int64
    CancelRoutine : Int64
    CurrentStack : DEBUG_IRP_STACK_INFO
    Stack : DEBUG_IRP_STACK_INFO[10]
}
struct PGET_IRP_INFO extends FunctionPointer {
    static Types := [IDebugClient, Int64, DEBUG_IRP_INFO.Ptr, HRESULT]
}
struct DEBUG_PNP_TRIAGE_INFO {
    SizeOfStruct : UInt32
    Lock_Address : Int64
    Lock_ActiveCount : Int32
    Lock_ContentionCount : UInt32
    Lock_NumberOfExclusiveWaiters : UInt32
    Lock_NumberOfSharedWaiters : UInt32
    Lock_Flag : UInt16
    TriagedThread : Int64
    ThreadCount : Int32
    TriagedThread_WaitTime : Int64
}
struct PGET_PNP_TRIAGE_INFO extends FunctionPointer {
    static Types := [IDebugClient, DEBUG_PNP_TRIAGE_INFO.Ptr, HRESULT]
}
struct DEBUG_POOL_DATA {
    SizeofStruct : UInt32
    PoolBlock : Int64
    Pool : Int64
    PreviousSize : UInt32
    Size : UInt32
    PoolTag : UInt32
    ProcessBilled : Int64
    Anonymous : this._Anonymous_e__Union
    Reserved2 : Int64[4]
    PoolTagDescription : CHAR[64]
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUlong : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PGET_POOL_DATA extends FunctionPointer {
    static Types := [IDebugClient, Int64, DEBUG_POOL_DATA.Ptr, HRESULT]
}
struct DEBUG_POOL_REGION extends Int32 {
    static DbgPoolRegionUnknown := 0
    static DbgPoolRegionSpecial := 1
    static DbgPoolRegionPaged := 2
    static DbgPoolRegionNonPaged := 3
    static DbgPoolRegionNonPagedExpansion := 4
    static DbgPoolRegionSessionPaged := 5
    static DbgPoolRegionMax := 6
}
struct PGET_POOL_REGION extends FunctionPointer {
    static Types := [IDebugClient, Int64, DEBUG_POOL_REGION.Ptr, HRESULT]
}
struct KDEXT_THREAD_FIND_PARAMS {
    SizeofStruct : UInt32
    StackPointer : Int64
    Cid : UInt32
    Thread : Int64
}
struct PFIND_MATCHING_THREAD extends FunctionPointer {
    static Types := [IDebugClient, KDEXT_THREAD_FIND_PARAMS.Ptr, HRESULT]
}
struct KDEXT_PROCESS_FIND_PARAMS {
    SizeofStruct : UInt32
    Pid : UInt32
    Session : UInt32
    ImageName : PSTR
}
struct PFIND_MATCHING_PROCESS extends FunctionPointer {
    static Types := [IDebugClient, KDEXT_PROCESS_FIND_PARAMS.Ptr, Int64.Ptr, HRESULT]
}
struct EXTS_JOB_PROCESS_CALLBACK extends FunctionPointer {
    static Types := [Int64, Int64, Struct.Ptr, BOOLEAN]
}
struct PENUMERATE_JOB_PROCESSES extends FunctionPointer {
    static Types := [IDebugClient, Int64, EXTS_JOB_PROCESS_CALLBACK, Struct.Ptr, HRESULT]
}
struct EXTS_TABLE_ENTRY_CALLBACK extends FunctionPointer {
    static Types := [Int64, Struct.Ptr, BOOLEAN]
}
struct PENUMERATE_HASH_TABLE extends FunctionPointer {
    static Types := [IDebugClient, Int64, EXTS_TABLE_ENTRY_CALLBACK, Struct.Ptr, HRESULT]
}
struct KDEXT_HANDLE_INFORMATION {
    HandleTableEntry : Int64
    Handle : Int64
    Object : Int64
    ObjectBody : Int64
    GrantedAccess : Int64
    HandleAttributes : UInt32
    PagedOut : BOOLEAN
}
struct KDEXT_DUMP_HANDLE_CALLBACK extends FunctionPointer {
    static Types := [KDEXT_HANDLE_INFORMATION.Ptr, UInt32, Struct.Ptr, BOOLEAN]
}
struct PENUMERATE_HANDLES extends FunctionPointer {
    static Types := [IDebugClient, Int64, Int64, UInt32, KDEXT_DUMP_HANDLE_CALLBACK, Struct.Ptr, HRESULT]
}
struct KDEXT_FILELOCK_OWNER {
    Sizeofstruct : UInt32
    FileObject : Int64
    OwnerThread : Int64
    WaitIrp : Int64
    DeviceObject : Int64
    BlockingDirver : CHAR[32]
}
struct PFIND_FILELOCK_OWNERINFO extends FunctionPointer {
    static Types := [IDebugClient, KDEXT_FILELOCK_OWNER.Ptr, HRESULT]
}
struct KDEXTS_LOCK_INFO {
    SizeOfStruct : UInt32
    Address : Int64
    OwningThread : Int64
    ExclusiveOwned : BOOL
    NumOwners : UInt32
    ContentionCount : UInt32
    NumExclusiveWaiters : UInt32
    NumSharedWaiters : UInt32
    pOwnerThreads : Int64.Ptr
    pWaiterThreads : Int64.Ptr
}
struct KDEXTS_LOCK_CALLBACKROUTINE extends FunctionPointer {
    static Types := [KDEXTS_LOCK_INFO.Ptr, Struct.Ptr, HRESULT]
}
struct PENUMERATE_SYSTEM_LOCKS extends FunctionPointer {
    static Types := [IDebugClient, UInt32, KDEXTS_LOCK_CALLBACKROUTINE, Struct.Ptr, HRESULT]
}
struct KDEXTS_PTE_INFO {
    SizeOfStruct : UInt32
    VirtualAddress : Int64
    PpeAddress : Int64
    PdeAddress : Int64
    PteAddress : Int64
    Pfn : Int64
    Levels : Int64
    _bitfield1 : UInt32
    _bitfield2 : UInt32
}
struct PKDEXTS_GET_PTE_INFO extends FunctionPointer {
    static Types := [IDebugClient, Int64, KDEXTS_PTE_INFO.Ptr, HRESULT]
}
struct DEBUG_POOLTAG_DESCRIPTION {
    SizeOfStruct : UInt32
    PoolTag : UInt32
    Description : CHAR[260]
    Binary : CHAR[32]
    Owner : CHAR[32]
}
struct PGET_POOL_TAG_DESCRIPTION extends FunctionPointer {
    static Types := [UInt32, DEBUG_POOLTAG_DESCRIPTION.Ptr, HRESULT]
}
struct DEBUG_FAILURE_TYPE extends Int32 {
    static DEBUG_FLR_UNKNOWN := 0
    static DEBUG_FLR_KERNEL := 1
    static DEBUG_FLR_USER := 2
}
struct DEBUG_FLR_PARAM_TYPE extends Int32 {
    static DEBUG_FLR_INVALID := 0
    static DEBUG_FLR_RESERVED := 1
    static DEBUG_FLR_DRIVER_OBJECT := 2
    static DEBUG_FLR_DEVICE_OBJECT := 3
    static DEBUG_FLR_INVALID_PFN := 4
    static DEBUG_FLR_WORKER_ROUTINE := 5
    static DEBUG_FLR_WORK_ITEM := 6
    static DEBUG_FLR_INVALID_DPC_FOUND := 7
    static DEBUG_FLR_PROCESS_OBJECT := 8
    static DEBUG_FLR_FAILED_INSTRUCTION_ADDRESS := 9
    static DEBUG_FLR_LAST_CONTROL_TRANSFER := 10
    static DEBUG_FLR_ACPI_EXTENSION := 11
    static DEBUG_FLR_ACPI_RESCONFLICT := 12
    static DEBUG_FLR_ACPI_OBJECT := 13
    static DEBUG_FLR_READ_ADDRESS := 14
    static DEBUG_FLR_WRITE_ADDRESS := 15
    static DEBUG_FLR_CRITICAL_SECTION := 16
    static DEBUG_FLR_BAD_HANDLE := 17
    static DEBUG_FLR_INVALID_HEAP_ADDRESS := 18
    static DEBUG_FLR_CHKIMG_EXTENSION := 19
    static DEBUG_FLR_USBPORT_OCADATA := 20
    static DEBUG_FLR_WORK_QUEUE_ITEM := 21
    static DEBUG_FLR_ERESOURCE_ADDRESS := 22
    static DEBUG_FLR_PNP_TRIAGE_DATA_DEPRECATED := 23
    static DEBUG_FLR_HANDLE_VALUE := 24
    static DEBUG_FLR_WHEA_ERROR_RECORD := 25
    static DEBUG_FLR_VERIFIER_FOUND_DEADLOCK := 26
    static DEBUG_FLR_PG_MISMATCH := 27
    static DEBUG_FLR_DEVICE_NODE := 28
    static DEBUG_FLR_POWERREQUEST_ADDRESS := 29
    static DEBUG_FLR_EXECUTE_ADDRESS := 30
    static DEBUG_FLR_IRP_ADDRESS := 256
    static DEBUG_FLR_IRP_MAJOR_FN := 257
    static DEBUG_FLR_IRP_MINOR_FN := 258
    static DEBUG_FLR_IRP_CANCEL_ROUTINE := 259
    static DEBUG_FLR_IOSB_ADDRESS := 260
    static DEBUG_FLR_INVALID_USEREVENT := 261
    static DEBUG_FLR_VIDEO_TDR_CONTEXT := 262
    static DEBUG_FLR_VERIFIER_DRIVER_ENTRY := 263
    static DEBUG_FLR_PNP_IRP_ADDRESS_DEPRECATED := 264
    static DEBUG_FLR_PREVIOUS_MODE := 265
    static DEBUG_FLR_CURRENT_IRQL := 512
    static DEBUG_FLR_PREVIOUS_IRQL := 513
    static DEBUG_FLR_REQUESTED_IRQL := 514
    static DEBUG_FLR_ASSERT_DATA := 768
    static DEBUG_FLR_ASSERT_FILE := 769
    static DEBUG_FLR_EXCEPTION_PARAMETER1 := 770
    static DEBUG_FLR_EXCEPTION_PARAMETER2 := 771
    static DEBUG_FLR_EXCEPTION_PARAMETER3 := 772
    static DEBUG_FLR_EXCEPTION_PARAMETER4 := 773
    static DEBUG_FLR_EXCEPTION_RECORD := 774
    static DEBUG_FLR_IO_ERROR_CODE := 775
    static DEBUG_FLR_EXCEPTION_STR := 776
    static DEBUG_FLR_EXCEPTION_DOESNOT_MATCH_CODE := 777
    static DEBUG_FLR_ASSERT_INSTRUCTION := 778
    static DEBUG_FLR_POOL_ADDRESS := 1024
    static DEBUG_FLR_SPECIAL_POOL_CORRUPTION_TYPE := 1025
    static DEBUG_FLR_CORRUPTING_POOL_ADDRESS := 1026
    static DEBUG_FLR_CORRUPTING_POOL_TAG := 1027
    static DEBUG_FLR_FREED_POOL_TAG := 1028
    static DEBUG_FLR_LEAKED_SESSION_POOL_TAG := 1029
    static DEBUG_FLR_INSTR_SESSION_POOL_TAG := 1030
    static DEBUG_FLR_CLIENT_DRIVER := 1031
    static DEBUG_FLR_FILE_ID := 1280
    static DEBUG_FLR_FILE_LINE := 1281
    static DEBUG_FLR_BUGCHECK_STR := 1536
    static DEBUG_FLR_BUGCHECK_SPECIFIER := 1537
    static DEBUG_FLR_BUGCHECK_DESC := 1538
    static DEBUG_FLR_MANAGED_CODE := 1792
    static DEBUG_FLR_MANAGED_OBJECT := 1793
    static DEBUG_FLR_MANAGED_EXCEPTION_OBJECT := 1794
    static DEBUG_FLR_MANAGED_EXCEPTION_MESSAGE_deprecated := 1795
    static DEBUG_FLR_MANAGED_STACK_STRING := 1796
    static DEBUG_FLR_MANAGED_BITNESS_MISMATCH := 1797
    static DEBUG_FLR_MANAGED_OBJECT_NAME := 1798
    static DEBUG_FLR_MANAGED_EXCEPTION_CONTEXT_MESSAGE := 1799
    static DEBUG_FLR_MANAGED_STACK_COMMAND := 1800
    static DEBUG_FLR_MANAGED_KERNEL_DEBUGGER := 1801
    static DEBUG_FLR_MANAGED_HRESULT_STRING := 1802
    static DEBUG_FLR_MANAGED_ENGINE_MODULE := 1803
    static DEBUG_FLR_MANAGED_ANALYSIS_PROVIDER := 1804
    static DEBUG_FLR_MANAGED_EXCEPTION_ADDRESS := 2048
    static DEBUG_FLR_MANAGED_EXCEPTION_HRESULT := 2049
    static DEBUG_FLR_MANAGED_EXCEPTION_TYPE := 2050
    static DEBUG_FLR_MANAGED_EXCEPTION_MESSAGE := 2051
    static DEBUG_FLR_MANAGED_EXCEPTION_CALLSTACK := 2052
    static DEBUG_FLR_MANAGED_EXCEPTION_INNER_ADDRESS := 2064
    static DEBUG_FLR_MANAGED_EXCEPTION_INNER_HRESULT := 2065
    static DEBUG_FLR_MANAGED_EXCEPTION_INNER_TYPE := 2066
    static DEBUG_FLR_MANAGED_EXCEPTION_INNER_MESSAGE := 2067
    static DEBUG_FLR_MANAGED_EXCEPTION_INNER_CALLSTACK := 2068
    static DEBUG_FLR_MANAGED_EXCEPTION_NESTED_ADDRESS := 2080
    static DEBUG_FLR_MANAGED_EXCEPTION_NESTED_HRESULT := 2081
    static DEBUG_FLR_MANAGED_EXCEPTION_NESTED_TYPE := 2082
    static DEBUG_FLR_MANAGED_EXCEPTION_NESTED_MESSAGE := 2083
    static DEBUG_FLR_MANAGED_EXCEPTION_NESTED_CALLSTACK := 2084
    static DEBUG_FLR_MANAGED_EXCEPTION_CMD := 2288
    static DEBUG_FLR_MANAGED_THREAD_ID := 2304
    static DEBUG_FLR_MANAGED_THREAD_CMD_CALLSTACK := 2544
    static DEBUG_FLR_MANAGED_THREAD_CMD_STACKOBJECTS := 2545
    static DEBUG_FLR_DRIVER_VERIFIER_IO_VIOLATION_TYPE := 4096
    static DEBUG_FLR_EXCEPTION_CODE := 4097
    static DEBUG_FLR_EXCEPTION_CODE_STR := 4098
    static DEBUG_FLR_IOCONTROL_CODE := 4099
    static DEBUG_FLR_MM_INTERNAL_CODE := 4100
    static DEBUG_FLR_DRVPOWERSTATE_SUBCODE := 4101
    static DEBUG_FLR_STATUS_CODE := 4102
    static DEBUG_FLR_SYMBOL_STACK_INDEX := 4103
    static DEBUG_FLR_SYMBOL_ON_RAW_STACK := 4104
    static DEBUG_FLR_SECURITY_COOKIES := 4105
    static DEBUG_FLR_THREADPOOL_WAITER := 4106
    static DEBUG_FLR_TARGET_MODE := 4107
    static DEBUG_FLR_BUGCHECK_CODE := 4108
    static DEBUG_FLR_BADPAGES_DETECTED := 4109
    static DEBUG_FLR_DPC_TIMEOUT_TYPE := 4110
    static DEBUG_FLR_DPC_RUNTIME := 4111
    static DEBUG_FLR_DPC_TIMELIMIT := 4112
    static DEBUG_FLR_DUMP_FILE_ATTRIBUTES := 4113
    static DEBUG_FLR_PAGE_HASH_ERRORS := 4114
    static DEBUG_FLR_BUGCHECK_P1 := 4115
    static DEBUG_FLR_BUGCHECK_P2 := 4116
    static DEBUG_FLR_BUGCHECK_P3 := 4117
    static DEBUG_FLR_BUGCHECK_P4 := 4118
    static DEBUG_FLR_CRITICAL_PROCESS := 4119
    static DEBUG_FLR_RESOURCE_CALL_TYPE := 4352
    static DEBUG_FLR_RESOURCE_CALL_TYPE_STR := 4353
    static DEBUG_FLR_CORRUPT_MODULE_LIST := 8192
    static DEBUG_FLR_BAD_STACK := 8193
    static DEBUG_FLR_ZEROED_STACK := 8194
    static DEBUG_FLR_WRONG_SYMBOLS := 8195
    static DEBUG_FLR_FOLLOWUP_DRIVER_ONLY := 8196
    static DEBUG_FLR_UNUSED001 := 8197
    static DEBUG_FLR_CPU_OVERCLOCKED := 8198
    static DEBUG_FLR_POSSIBLE_INVALID_CONTROL_TRANSFER := 8199
    static DEBUG_FLR_POISONED_TB := 8200
    static DEBUG_FLR_UNKNOWN_MODULE := 8201
    static DEBUG_FLR_ANALYZABLE_POOL_CORRUPTION := 8202
    static DEBUG_FLR_SINGLE_BIT_ERROR := 8203
    static DEBUG_FLR_TWO_BIT_ERROR := 8204
    static DEBUG_FLR_INVALID_KERNEL_CONTEXT := 8205
    static DEBUG_FLR_DISK_HARDWARE_ERROR := 8206
    static DEBUG_FLR_SHOW_ERRORLOG := 8207
    static DEBUG_FLR_MANUAL_BREAKIN := 8208
    static DEBUG_FLR_HANG := 8209
    static DEBUG_FLR_BAD_MEMORY_REFERENCE := 8210
    static DEBUG_FLR_BAD_OBJECT_REFERENCE := 8211
    static DEBUG_FLR_APPKILL := 8212
    static DEBUG_FLR_SINGLE_BIT_PFN_PAGE_ERROR := 8213
    static DEBUG_FLR_HARDWARE_ERROR := 8214
    static DEBUG_FLR_NO_IMAGE_IN_BUCKET := 8215
    static DEBUG_FLR_NO_BUGCHECK_IN_BUCKET := 8216
    static DEBUG_FLR_SKIP_STACK_ANALYSIS := 8217
    static DEBUG_FLR_INVALID_OPCODE := 8218
    static DEBUG_FLR_ADD_PROCESS_IN_BUCKET := 8219
    static DEBUG_FLR_RAISED_IRQL_USER_FAULT := 8220
    static DEBUG_FLR_USE_DEFAULT_CONTEXT := 8221
    static DEBUG_FLR_BOOST_FOLLOWUP_TO_SPECIFIC := 8222
    static DEBUG_FLR_SWITCH_PROCESS_CONTEXT := 8223
    static DEBUG_FLR_VERIFIER_STOP := 8224
    static DEBUG_FLR_USERBREAK_PEB_PAGEDOUT := 8225
    static DEBUG_FLR_MOD_SPECIFIC_DATA_ONLY := 8226
    static DEBUG_FLR_OVERLAPPED_MODULE := 8227
    static DEBUG_FLR_CPU_MICROCODE_ZERO_INTEL := 8228
    static DEBUG_FLR_INTEL_CPU_BIOS_UPGRADE_NEEDED := 8229
    static DEBUG_FLR_OVERLAPPED_UNLOADED_MODULE := 8230
    static DEBUG_FLR_INVALID_USER_CONTEXT := 8231
    static DEBUG_FLR_MILCORE_BREAK := 8232
    static DEBUG_FLR_NO_IMAGE_TIMESTAMP_IN_BUCKET := 8233
    static DEBUG_FLR_KERNEL_VERIFIER_ENABLED := 8234
    static DEBUG_FLR_SKIP_CORRUPT_MODULE_DETECTION := 8235
    static DEBUG_FLR_GSFAILURE_FALSE_POSITIVE := 8236
    static DEBUG_FLR_IGNORE_LARGE_MODULE_CORRUPTION := 8237
    static DEBUG_FLR_IGNORE_BUCKET_ID_OFFSET := 8238
    static DEBUG_FLR_NO_ARCH_IN_BUCKET := 8239
    static DEBUG_FLR_IGNORE_MODULE_HARDWARE_ID := 8240
    static DEBUG_FLR_ARM_WRITE_AV_CAVEAT := 8241
    static DEBUG_FLR_ON_DPC_STACK := 8242
    static DEBUG_FLR_LIVE_KERNEL_DUMP := 8243
    static DEBUG_FLR_COVERAGE_BUILD := 8244
    static DEBUG_FLR_POSSIBLE_STACK_OVERFLOW := 8245
    static DEBUG_FLR_WRONG_SYMBOLS_TIMESTAMP := 8246
    static DEBUG_FLR_WRONG_SYMBOLS_SIZE := 8247
    static DEBUG_FLR_MISSING_IMPORTANT_SYMBOL := 8248
    static DEBUG_FLR_MISSING_CLR_SYMBOL := 8249
    static DEBUG_FLR_TARGET_TIME := 8250
    static DEBUG_FLR_LOW_SYSTEM_COMMIT := 8251
    static DEBUG_FLR_LEGACY_PAGE_TABLE_ACCESS := 8252
    static DEBUG_FLR_HIGH_PROCESS_COMMIT := 8253
    static DEBUG_FLR_HIGH_SERVICE_COMMIT := 8254
    static DEBUG_FLR_HIGH_NONPAGED_POOL_USAGE := 8255
    static DEBUG_FLR_HIGH_PAGED_POOL_USAGE := 8256
    static DEBUG_FLR_HIGH_SHARED_COMMIT_USAGE := 8257
    static DEBUG_FLR_APPS_NOT_TERMINATED := 8258
    static DEBUG_FLR_POOL_CORRUPTOR := 12288
    static DEBUG_FLR_MEMORY_CORRUPTOR := 12289
    static DEBUG_FLR_UNALIGNED_STACK_POINTER := 12290
    static DEBUG_FLR_OS_VERSION_deprecated := 12291
    static DEBUG_FLR_BUGCHECKING_DRIVER := 12292
    static DEBUG_FLR_SOLUTION_ID := 12293
    static DEBUG_FLR_DEFAULT_SOLUTION_ID := 12294
    static DEBUG_FLR_SOLUTION_TYPE := 12295
    static DEBUG_FLR_RECURRING_STACK := 12296
    static DEBUG_FLR_FAULTING_INSTR_CODE := 12297
    static DEBUG_FLR_SYSTEM_LOCALE_deprecated := 12298
    static DEBUG_FLR_CUSTOMER_CRASH_COUNT := 12299
    static DEBUG_FLR_TRAP_FRAME_RECURSION := 12300
    static DEBUG_FLR_STACK_OVERFLOW := 12301
    static DEBUG_FLR_STACK_POINTER_ERROR := 12302
    static DEBUG_FLR_STACK_POINTER_ONEBIT_ERROR := 12303
    static DEBUG_FLR_STACK_POINTER_MISALIGNED := 12304
    static DEBUG_FLR_INSTR_POINTER_MISALIGNED := 12305
    static DEBUG_FLR_INSTR_POINTER_CLIFAULT := 12306
    static DEBUG_FLR_REGISTRYTXT_STRESS_ID := 12307
    static DEBUG_FLR_CORRUPT_SERVICE_TABLE := 12308
    static DEBUG_FLR_LOP_STACKHASH := 12309
    static DEBUG_FLR_GSFAILURE_FUNCTION := 12310
    static DEBUG_FLR_GSFAILURE_MODULE_COOKIE := 12311
    static DEBUG_FLR_GSFAILURE_FRAME_COOKIE := 12312
    static DEBUG_FLR_GSFAILURE_FRAME_COOKIE_COMPLEMENT := 12313
    static DEBUG_FLR_GSFAILURE_CORRUPTED_COOKIE := 12314
    static DEBUG_FLR_GSFAILURE_CORRUPTED_EBP := 12315
    static DEBUG_FLR_GSFAILURE_OVERRUN_LOCAL := 12316
    static DEBUG_FLR_GSFAILURE_OVERRUN_LOCAL_NAME := 12317
    static DEBUG_FLR_GSFAILURE_CORRUPTED_EBPESP := 12318
    static DEBUG_FLR_GSFAILURE_POSITIVELY_CORRUPTED_EBPESP := 12319
    static DEBUG_FLR_GSFAILURE_MEMORY_READ_ERROR := 12320
    static DEBUG_FLR_GSFAILURE_PROBABLY_NOT_USING_GS := 12321
    static DEBUG_FLR_GSFAILURE_POSITIVE_BUFFER_OVERFLOW := 12322
    static DEBUG_FLR_GSFAILURE_ANALYSIS_TEXT := 12323
    static DEBUG_FLR_GSFAILURE_OFF_BY_ONE_OVERRUN := 12324
    static DEBUG_FLR_GSFAILURE_RA_SMASHED := 12325
    static DEBUG_FLR_GSFAILURE_NOT_UP2DATE := 12326
    static DEBUG_FLR_GSFAILURE_UP2DATE_UNKNOWN := 12327
    static DEBUG_FLR_TRIAGER_OS_BUILD_NAME := 12328
    static DEBUG_FLR_CPU_MICROCODE_VERSION := 12329
    static DEBUG_FLR_CPU_COUNT := 12330
    static DEBUG_FLR_CPU_SPEED := 12331
    static DEBUG_FLR_CPU_VENDOR := 12332
    static DEBUG_FLR_CPU_FAMILY := 12333
    static DEBUG_FLR_CPU_MODEL := 12334
    static DEBUG_FLR_CPU_STEPPING := 12335
    static DEBUG_FLR_INSTR_POINTER_ON_STACK := 12336
    static DEBUG_FLR_INSTR_POINTER_ON_HEAP := 12337
    static DEBUG_FLR_EVENT_CODE_DATA_MISMATCH := 12338
    static DEBUG_FLR_PROCESSOR_INFO := 12339
    static DEBUG_FLR_INSTR_POINTER_IN_UNLOADED_MODULE := 12340
    static DEBUG_FLR_MEMDIAG_LASTRUN_STATUS := 12341
    static DEBUG_FLR_MEMDIAG_LASTRUN_TIME := 12342
    static DEBUG_FLR_INSTR_POINTER_IN_FREE_BLOCK := 12343
    static DEBUG_FLR_INSTR_POINTER_IN_RESERVED_BLOCK := 12344
    static DEBUG_FLR_INSTR_POINTER_IN_VM_MAPPED_MODULE := 12345
    static DEBUG_FLR_INSTR_POINTER_IN_MODULE_NOT_IN_LIST := 12346
    static DEBUG_FLR_INSTR_POINTER_NOT_IN_STREAM := 12347
    static DEBUG_FLR_MEMORY_CORRUPTION_SIGNATURE := 12348
    static DEBUG_FLR_BUILDNAME_IN_BUCKET := 12349
    static DEBUG_FLR_CANCELLATION_NOT_SUPPORTED := 12350
    static DEBUG_FLR_DETOURED_IMAGE := 12351
    static DEBUG_FLR_EXCEPTION_CONTEXT_RECURSION := 12352
    static DEBUG_FLR_DISKIO_READ_FAILURE := 12353
    static DEBUG_FLR_DISKIO_WRITE_FAILURE := 12354
    static DEBUG_FLR_GSFAILURE_MISSING_ESTABLISHER_FRAME := 12355
    static DEBUG_FLR_GSFAILURE_COOKIES_MATCH_EXH := 12356
    static DEBUG_FLR_GSFAILURE_MANAGED := 12357
    static DEBUG_FLR_MANAGED_FRAME_CHAIN_CORRUPTION := 12358
    static DEBUG_FLR_GSFAILURE_MANAGED_THREADID := 12359
    static DEBUG_FLR_GSFAILURE_MANAGED_FRAMEID := 12360
    static DEBUG_FLR_STACKUSAGE_IMAGE := 12361
    static DEBUG_FLR_STACKUSAGE_IMAGE_SIZE := 12362
    static DEBUG_FLR_STACKUSAGE_FUNCTION := 12363
    static DEBUG_FLR_STACKUSAGE_FUNCTION_SIZE := 12364
    static DEBUG_FLR_STACKUSAGE_RECURSION_COUNT := 12365
    static DEBUG_FLR_XBOX_SYSTEM_UPTIME := 12366
    static DEBUG_FLR_XBOX_SYSTEM_CRASHTIME := 12367
    static DEBUG_FLR_XBOX_LIVE_ENVIRONMENT := 12368
    static DEBUG_FLR_LARGE_TICK_INCREMENT := 12369
    static DEBUG_FLR_INSTR_POINTER_IN_PAGED_CODE := 12370
    static DEBUG_FLR_SERVICETABLE_MODIFIED := 12371
    static DEBUG_FLR_ALUREON := 12372
    static DEBUG_FLR_INTERNAL_RAID_BUG := 16384
    static DEBUG_FLR_INTERNAL_BUCKET_URL := 16385
    static DEBUG_FLR_INTERNAL_SOLUTION_TEXT := 16386
    static DEBUG_FLR_INTERNAL_BUCKET_HITCOUNT := 16387
    static DEBUG_FLR_INTERNAL_RAID_BUG_DATABASE_STRING := 16388
    static DEBUG_FLR_INTERNAL_BUCKET_CONTINUABLE := 16389
    static DEBUG_FLR_INTERNAL_BUCKET_STATUS_TEXT := 16390
    static DEBUG_FLR_WATSON_MODULE := 16640
    static DEBUG_FLR_WATSON_MODULE_VERSION := 16641
    static DEBUG_FLR_WATSON_MODULE_OFFSET := 16642
    static DEBUG_FLR_WATSON_PROCESS_VERSION := 16643
    static DEBUG_FLR_WATSON_IBUCKET := 16644
    static DEBUG_FLR_WATSON_MODULE_TIMESTAMP := 16645
    static DEBUG_FLR_WATSON_PROCESS_TIMESTAMP := 16646
    static DEBUG_FLR_WATSON_GENERIC_EVENT_NAME := 16647
    static DEBUG_FLR_WATSON_GENERIC_BUCKETING_00 := 16648
    static DEBUG_FLR_WATSON_GENERIC_BUCKETING_01 := 16649
    static DEBUG_FLR_WATSON_GENERIC_BUCKETING_02 := 16650
    static DEBUG_FLR_WATSON_GENERIC_BUCKETING_03 := 16651
    static DEBUG_FLR_WATSON_GENERIC_BUCKETING_04 := 16652
    static DEBUG_FLR_WATSON_GENERIC_BUCKETING_05 := 16653
    static DEBUG_FLR_WATSON_GENERIC_BUCKETING_06 := 16654
    static DEBUG_FLR_WATSON_GENERIC_BUCKETING_07 := 16655
    static DEBUG_FLR_WATSON_GENERIC_BUCKETING_08 := 16656
    static DEBUG_FLR_WATSON_GENERIC_BUCKETING_09 := 16657
    static DEBUG_FLR_SYSXML_LOCALEID := 16896
    static DEBUG_FLR_SYSXML_CHECKSUM := 16897
    static DEBUG_FLR_WQL_EVENT_COUNT := 16898
    static DEBUG_FLR_WQL_EVENTLOG_INFO := 16899
    static DEBUG_FLR_SYSINFO_SYSTEM_MANUFACTURER := 17152
    static DEBUG_FLR_SYSINFO_SYSTEM_PRODUCT := 17153
    static DEBUG_FLR_SYSINFO_SYSTEM_SKU := 17154
    static DEBUG_FLR_SYSINFO_SYSTEM_VERSION := 17155
    static DEBUG_FLR_SYSINFO_BASEBOARD_MANUFACTURER := 17156
    static DEBUG_FLR_SYSINFO_BASEBOARD_PRODUCT := 17157
    static DEBUG_FLR_SYSINFO_BASEBOARD_VERSION := 17158
    static DEBUG_FLR_SYSINFO_BIOS_VENDOR := 17159
    static DEBUG_FLR_SYSINFO_BIOS_VERSION := 17160
    static DEBUG_FLR_SYSINFO_BIOS_DATE := 17161
    static DEBUG_FLR_VIRTUAL_MACHINE := 17162
    static DEBUG_FLR_SERVICE := 20480
    static DEBUG_FLR_SERVICE_NAME := 20481
    static DEBUG_FLR_SERVICE_GROUP := 20482
    static DEBUG_FLR_SERVICE_DISPLAYNAME := 20483
    static DEBUG_FLR_SERVICE_DESCRIPTION := 20484
    static DEBUG_FLR_SERVICE_DEPENDONSERVICE := 20485
    static DEBUG_FLR_SERVICE_DEPENDONGROUP := 20486
    static DEBUG_FLR_SVCHOST := 20736
    static DEBUG_FLR_SVCHOST_GROUP := 20737
    static DEBUG_FLR_SVCHOST_IMAGEPATH := 20738
    static DEBUG_FLR_SVCHOST_SERVICEDLL := 20739
    static DEBUG_FLR_SCM := 20992
    static DEBUG_FLR_SCM_BLACKBOX := 21232
    static DEBUG_FLR_SCM_BLACKBOX_ENTRY := 21233
    static DEBUG_FLR_SCM_BLACKBOX_ENTRY_CONTROLCODE := 21234
    static DEBUG_FLR_SCM_BLACKBOX_ENTRY_STARTTIME := 21235
    static DEBUG_FLR_SCM_BLACKBOX_ENTRY_SERVICENAME := 21236
    static DEBUG_FLR_ACPI := 24576
    static DEBUG_FLR_ACPI_BLACKBOX := 24832
    static DEBUG_FLR_PO_BLACKBOX := 24833
    static DEBUG_FLR_BOOTSTAT := 28672
    static DEBUG_FLR_BOOTSTAT_BLACKBOX := 28928
    static DEBUG_FLR_STORAGE := 29696
    static DEBUG_FLR_STORAGE_ORGID := 29697
    static DEBUG_FLR_STORAGE_MODEL := 29698
    static DEBUG_FLR_STORAGE_MFGID := 29699
    static DEBUG_FLR_STORAGE_ISSUEDESCSTRING := 29700
    static DEBUG_FLR_STORAGE_PUBLIC_TOTSIZE := 29701
    static DEBUG_FLR_STORAGE_PUBLIC_OFFSET := 29702
    static DEBUG_FLR_STORAGE_PUBLIC_DATASIZE := 29703
    static DEBUG_FLR_STORAGE_PRIVATE_TOTSIZE := 29704
    static DEBUG_FLR_STORAGE_PRIVATE_OFFSET := 29705
    static DEBUG_FLR_STORAGE_PRIVATE_DATASIZE := 29706
    static DEBUG_FLR_STORAGE_TOTALSIZE := 29707
    static DEBUG_FLR_STORAGE_REASON := 29708
    static DEBUG_FLR_STORAGE_BLACKBOX := 29936
    static DEBUG_FLR_FILESYSTEMS_NTFS := 30208
    static DEBUG_FLR_FILESYSTEMS_NTFS_BLACKBOX := 30448
    static DEBUG_FLR_FILESYSTEMS_REFS := 30720
    static DEBUG_FLR_FILESYSTEMS_REFS_BLACKBOX := 30960
    static DEBUG_FLR_PNP := 32768
    static DEBUG_FLR_PNP_TRIAGE_DATA := 32769
    static DEBUG_FLR_PNP_IRP_ADDRESS := 32770
    static DEBUG_FLR_PNP_BLACKBOX := 33024
    static DEBUG_FLR_BUCKET_ID := 65536
    static DEBUG_FLR_IMAGE_NAME := 65537
    static DEBUG_FLR_SYMBOL_NAME := 65538
    static DEBUG_FLR_FOLLOWUP_NAME := 65539
    static DEBUG_FLR_STACK_COMMAND := 65540
    static DEBUG_FLR_STACK_TEXT := 65541
    static DEBUG_FLR_MODULE_NAME := 65542
    static DEBUG_FLR_FIXED_IN_OSVERSION := 65543
    static DEBUG_FLR_DEFAULT_BUCKET_ID := 65544
    static DEBUG_FLR_MODULE_BUCKET_ID := 65545
    static DEBUG_FLR_ADDITIONAL_DEBUGTEXT := 65546
    static DEBUG_FLR_PROCESS_NAME := 65547
    static DEBUG_FLR_USER_NAME := 65548
    static DEBUG_FLR_MARKER_FILE := 65549
    static DEBUG_FLR_INTERNAL_RESPONSE := 65550
    static DEBUG_FLR_CONTEXT_RESTORE_COMMAND := 65551
    static DEBUG_FLR_DRIVER_HARDWAREID := 65552
    static DEBUG_FLR_DRIVER_HARDWARE_VENDOR_ID := 65553
    static DEBUG_FLR_DRIVER_HARDWARE_DEVICE_ID := 65554
    static DEBUG_FLR_DRIVER_HARDWARE_SUBSYS_ID := 65555
    static DEBUG_FLR_DRIVER_HARDWARE_REV_ID := 65556
    static DEBUG_FLR_DRIVER_HARDWARE_ID_BUS_TYPE := 65557
    static DEBUG_FLR_MARKER_MODULE_FILE := 65558
    static DEBUG_FLR_BUGCHECKING_DRIVER_IDTAG := 65559
    static DEBUG_FLR_MARKER_BUCKET := 65560
    static DEBUG_FLR_FAILURE_BUCKET_ID := 65561
    static DEBUG_FLR_DRIVER_XML_DESCRIPTION := 65562
    static DEBUG_FLR_DRIVER_XML_PRODUCTNAME := 65563
    static DEBUG_FLR_DRIVER_XML_MANUFACTURER := 65564
    static DEBUG_FLR_DRIVER_XML_VERSION := 65565
    static DEBUG_FLR_BUILD_VERSION_STRING := 65566
    static DEBUG_FLR_BUILD_OS_FULL_VERSION_STRING := 65567
    static DEBUG_FLR_ORIGINAL_CAB_NAME := 65568
    static DEBUG_FLR_FAULTING_SOURCE_CODE := 65569
    static DEBUG_FLR_FAULTING_SERVICE_NAME := 65570
    static DEBUG_FLR_FILE_IN_CAB := 65571
    static DEBUG_FLR_UNRESPONSIVE_UI_SYMBOL_NAME := 65572
    static DEBUG_FLR_UNRESPONSIVE_UI_FOLLOWUP_NAME := 65573
    static DEBUG_FLR_UNRESPONSIVE_UI_STACK := 65574
    static DEBUG_FLR_PROCESS_PRODUCTNAME := 65575
    static DEBUG_FLR_MODULE_PRODUCTNAME := 65576
    static DEBUG_FLR_COLLECT_DATA_FOR_BUCKET := 65577
    static DEBUG_FLR_COMPUTER_NAME := 65578
    static DEBUG_FLR_IMAGE_CLASS := 65579
    static DEBUG_FLR_SYMBOL_ROUTINE_NAME := 65580
    static DEBUG_FLR_HARDWARE_BUCKET_TAG := 65581
    static DEBUG_FLR_KERNEL_LOG_PROCESS_NAME := 65582
    static DEBUG_FLR_KERNEL_LOG_STATUS := 65583
    static DEBUG_FLR_REGISTRYTXT_SOURCE := 65584
    static DEBUG_FLR_FAULTING_SOURCE_LINE := 65585
    static DEBUG_FLR_FAULTING_SOURCE_FILE := 65586
    static DEBUG_FLR_FAULTING_SOURCE_LINE_NUMBER := 65587
    static DEBUG_FLR_SKIP_MODULE_SPECIFIC_BUCKET_INFO := 65588
    static DEBUG_FLR_BUCKET_ID_FUNC_OFFSET := 65589
    static DEBUG_FLR_XHCI_FIRMWARE_VERSION := 65590
    static DEBUG_FLR_FAILURE_ANALYSIS_SOURCE := 65591
    static DEBUG_FLR_FAILURE_ID_HASH := 65592
    static DEBUG_FLR_FAILURE_ID_HASH_STRING := 65593
    static DEBUG_FLR_FAILURE_ID_REPORT_LINK := 65594
    static DEBUG_FLR_HOLDINFO := 65595
    static DEBUG_FLR_HOLDINFO_ACTIVE_HOLD_COUNT := 65596
    static DEBUG_FLR_HOLDINFO_TENET_SOCRE := 65597
    static DEBUG_FLR_HOLDINFO_HISTORIC_HOLD_COUNT := 65598
    static DEBUG_FLR_HOLDINFO_ALWAYS_IGNORE := 65599
    static DEBUG_FLR_HOLDINFO_ALWAYS_HOLD := 65600
    static DEBUG_FLR_HOLDINFO_MAX_HOLD_LIMIT := 65601
    static DEBUG_FLR_HOLDINFO_MANUAL_HOLD := 65602
    static DEBUG_FLR_HOLDINFO_NOTIFICATION_ALIASES := 65603
    static DEBUG_FLR_HOLDINFO_LAST_SEEN_HOLD_DATE := 65604
    static DEBUG_FLR_HOLDINFO_RECOMMEND_HOLD := 65605
    static DEBUG_FLR_FAILURE_PROBLEM_CLASS := 65606
    static DEBUG_FLR_FAILURE_EXCEPTION_CODE := 65607
    static DEBUG_FLR_FAILURE_IMAGE_NAME := 65608
    static DEBUG_FLR_FAILURE_FUNCTION_NAME := 65609
    static DEBUG_FLR_FAILURE_SYMBOL_NAME := 65610
    static DEBUG_FLR_FOLLOWUP_BEFORE_RETRACER := 65611
    static DEBUG_FLR_END_MESSAGE := 65612
    static DEBUG_FLR_FEATURE_PATH := 65613
    static DEBUG_FLR_USER_MODE_BUCKET := 65614
    static DEBUG_FLR_USER_MODE_BUCKET_INDEX := 65615
    static DEBUG_FLR_USER_MODE_BUCKET_EVENTTYPE := 65616
    static DEBUG_FLR_USER_MODE_BUCKET_REPORTGUID := 65617
    static DEBUG_FLR_USER_MODE_BUCKET_REPORTCREATIONTIME := 65618
    static DEBUG_FLR_USER_MODE_BUCKET_P0 := 65619
    static DEBUG_FLR_USER_MODE_BUCKET_P1 := 65620
    static DEBUG_FLR_USER_MODE_BUCKET_P2 := 65621
    static DEBUG_FLR_USER_MODE_BUCKET_P3 := 65622
    static DEBUG_FLR_USER_MODE_BUCKET_P4 := 65623
    static DEBUG_FLR_USER_MODE_BUCKET_P5 := 65624
    static DEBUG_FLR_USER_MODE_BUCKET_P6 := 65625
    static DEBUG_FLR_USER_MODE_BUCKET_P7 := 65626
    static DEBUG_FLR_USER_MODE_BUCKET_STRING := 65627
    static DEBUG_FLR_CRITICAL_PROCESS_REPORTGUID := 65628
    static DEBUG_FLR_FAILURE_MODULE_NAME := 65629
    static DEBUG_FLR_PLATFORM_BUCKET_STRING := 65630
    static DEBUG_FLR_DRIVER_HARDWARE_VENDOR_NAME := 65631
    static DEBUG_FLR_DRIVER_HARDWARE_SUBVENDOR_NAME := 65632
    static DEBUG_FLR_DRIVER_HARDWARE_DEVICE_NAME := 65633
    static DEBUG_FLR_FAULTING_SOURCE_COMMIT_ID := 65634
    static DEBUG_FLR_FAULTING_SOURCE_CONTROL_TYPE := 65635
    static DEBUG_FLR_FAULTING_SOURCE_PROJECT := 65636
    static DEBUG_FLR_FAULTING_SOURCE_REPO_ID := 65637
    static DEBUG_FLR_FAULTING_SOURCE_REPO_URL := 65638
    static DEBUG_FLR_FAULTING_SOURCE_SRV_COMMAND := 65639
    static DEBUG_FLR_USERMODE_DATA := 1048576
    static DEBUG_FLR_THREAD_ATTRIBUTES := 1048577
    static DEBUG_FLR_PROBLEM_CLASSES := 1048578
    static DEBUG_FLR_PRIMARY_PROBLEM_CLASS := 1048579
    static DEBUG_FLR_PRIMARY_PROBLEM_CLASS_DATA := 1048580
    static DEBUG_FLR_UNRESPONSIVE_UI_PROBLEM_CLASS := 1048581
    static DEBUG_FLR_UNRESPONSIVE_UI_PROBLEM_CLASS_DATA := 1048582
    static DEBUG_FLR_DERIVED_WAIT_CHAIN := 1048583
    static DEBUG_FLR_HANG_DATA_NEEDED := 1048584
    static DEBUG_FLR_PROBLEM_CODE_PATH_HASH := 1048585
    static DEBUG_FLR_SUSPECT_CODE_PATH_HASH := 1048586
    static DEBUG_FLR_LOADERLOCK_IN_WAIT_CHAIN := 1048587
    static DEBUG_FLR_XPROC_HANG := 1048588
    static DEBUG_FLR_DEADLOCK_INPROC := 1048589
    static DEBUG_FLR_DEADLOCK_XPROC := 1048590
    static DEBUG_FLR_WCT_XML_AVAILABLE := 1048591
    static DEBUG_FLR_XPROC_DUMP_AVAILABLE := 1048592
    static DEBUG_FLR_DESKTOP_HEAP_MISSING := 1048593
    static DEBUG_FLR_HANG_REPORT_THREAD_IS_IDLE := 1048594
    static DEBUG_FLR_FAULT_THREAD_SHA1_HASH_MF := 1048595
    static DEBUG_FLR_FAULT_THREAD_SHA1_HASH_MFO := 1048596
    static DEBUG_FLR_FAULT_THREAD_SHA1_HASH_M := 1048597
    static DEBUG_FLR_WAIT_CHAIN_COMMAND := 1048598
    static DEBUG_FLR_NTGLOBALFLAG := 1048599
    static DEBUG_FLR_APPVERIFERFLAGS := 1048600
    static DEBUG_FLR_MODLIST_SHA1_HASH := 1048601
    static DEBUG_FLR_DUMP_TYPE := 1048602
    static DEBUG_FLR_XCS_PATH := 1048603
    static DEBUG_FLR_LOADERLOCK_OWNER_API := 1048604
    static DEBUG_FLR_LOADERLOCK_BLOCKED_API := 1048605
    static DEBUG_FLR_MODLIST_TSCHKSUM_SHA1_HASH := 1048606
    static DEBUG_FLR_MODLIST_UNLOADED_SHA1_HASH := 1048607
    static DEBUG_FLR_MACHINE_INFO_SHA1_HASH := 1048608
    static DEBUG_FLR_URLS_DISCOVERED := 1048609
    static DEBUG_FLR_URLS := 1048610
    static DEBUG_FLR_URL_ENTRY := 1048611
    static DEBUG_FLR_WATSON_IBUCKET_S1_RESP := 1048612
    static DEBUG_FLR_WATSON_IBUCKETTABLE_S1_RESP := 1048613
    static DEBUG_FLR_SEARCH_HANG := 1048614
    static DEBUG_FLR_WER_DATA_COLLECTION_INFO := 1048615
    static DEBUG_FLR_WER_MACHINE_ID := 1048616
    static DEBUG_FLR_ULS_SCRIPT_EXCEPTION := 1048617
    static DEBUG_FLR_LCIE_ISO_AVAILABLE := 1048618
    static DEBUG_FLR_SHOW_LCIE_ISO_DATA := 1048619
    static DEBUG_FLR_URL_LCIE_ENTRY := 1048620
    static DEBUG_FLR_URL_URLMON_ENTRY := 1048621
    static DEBUG_FLR_URL_XMLHTTPREQ_SYNC_ENTRY := 1048622
    static DEBUG_FLR_FAULTING_LOCAL_VARIABLE_NAME := 1048623
    static DEBUG_FLR_MODULE_LIST := 1048624
    static DEBUG_FLR_DUMP_FLAGS := 1048625
    static DEBUG_FLR_APPLICATION_VERIFIER_LOADED := 1048626
    static DEBUG_FLR_DUMP_CLASS := 1048627
    static DEBUG_FLR_DUMP_QUALIFIER := 1048628
    static DEBUG_FLR_KM_MODULE_LIST := 1048629
    static DEBUG_FLR_EXCEPTION_CODE_STR_deprecated := 1052672
    static DEBUG_FLR_BUCKET_ID_PREFIX_STR := 1052673
    static DEBUG_FLR_BUCKET_ID_MODULE_STR := 1052674
    static DEBUG_FLR_BUCKET_ID_MODVER_STR := 1052675
    static DEBUG_FLR_BUCKET_ID_FUNCTION_STR := 1052676
    static DEBUG_FLR_BUCKET_ID_OFFSET := 1052677
    static DEBUG_FLR_OS_BUILD := 1052678
    static DEBUG_FLR_OS_SERVICEPACK := 1052679
    static DEBUG_FLR_OS_BRANCH := 1052680
    static DEBUG_FLR_OS_BUILD_TIMESTAMP_LAB := 1052681
    static DEBUG_FLR_OS_VERSION := 1052682
    static DEBUG_FLR_BUCKET_ID_TIMEDATESTAMP := 1052683
    static DEBUG_FLR_BUCKET_ID_CHECKSUM := 1052684
    static DEBUG_FLR_OS_FLAVOR := 1052685
    static DEBUG_FLR_BUCKET_ID_FLAVOR_STR := 1052686
    static DEBUG_FLR_OS_SKU := 1052687
    static DEBUG_FLR_OS_PRODUCT_TYPE := 1052688
    static DEBUG_FLR_OS_SUITE_MASK := 1052689
    static DEBUG_FLR_USER_LCID := 1052690
    static DEBUG_FLR_OS_REVISION := 1052691
    static DEBUG_FLR_OS_NAME := 1052692
    static DEBUG_FLR_OS_NAME_EDITION := 1052693
    static DEBUG_FLR_OS_PLATFORM_ARCH := 1052694
    static DEBUG_FLR_OS_SERVICEPACK_deprecated := 1052695
    static DEBUG_FLR_OS_LOCALE := 1052696
    static DEBUG_FLR_OS_BUILD_TIMESTAMP_ISO := 1052697
    static DEBUG_FLR_USER_LCID_STR := 1052698
    static DEBUG_FLR_ANALYSIS_SESSION_TIME := 1052699
    static DEBUG_FLR_ANALYSIS_SESSION_HOST := 1052700
    static DEBUG_FLR_ANALYSIS_SESSION_ELAPSED_TIME := 1052701
    static DEBUG_FLR_ANALYSIS_VERSION := 1052702
    static DEBUG_FLR_BUCKET_ID_IMAGE_STR := 1052703
    static DEBUG_FLR_BUCKET_ID_PRIVATE := 1052704
    static DEBUG_FLR_ANALYSIS_REPROCESS := 1052705
    static DEBUG_FLR_OS_MAJOR := 1052706
    static DEBUG_FLR_OS_MINOR := 1052707
    static DEBUG_FLR_OS_BUILD_STRING := 1052708
    static DEBUG_FLR_OS_LOCALE_LCID := 1052709
    static DEBUG_FLR_OS_PLATFORM_ID := 1052710
    static DEBUG_FLR_OS_BUILD_LAYERS_XML := 1052711
    static DEBUG_FLR_OSBUILD_deprecated := 1052928
    static DEBUG_FLR_BUILDOSVER_STR_deprecated := 1052929
    static DEBUG_FLR_DEBUG_ANALYSIS := 1118208
    static DEBUG_FLR_KEYVALUE_ANALYSIS := 1122304
    static DEBUG_FLR_KEY_VALUES_STRING := 1122560
    static DEBUG_FLR_KEY_VALUES_VARIANT := 1122816
    static DEBUG_FLR_TIMELINE_ANALYSIS := 1126400
    static DEBUG_FLR_TIMELINE_TIMES := 1126401
    static DEBUG_FLR_STREAM_ANALYSIS := 1130496
    static DEBUG_FLR_MEMORY_ANALYSIS := 1134592
    static DEBUG_FLR_STACKHASH_ANALYSIS := 1138688
    static DEBUG_FLR_PROCESSES_ANALYSIS := 1142784
    static DEBUG_FLR_SERVICE_ANALYSIS := 1146880
    static DEBUG_FLR_ADDITIONAL_XML := 1150976
    static DEBUG_FLR_STACK := 2097152
    static DEBUG_FLR_FOLLOWUP_CONTEXT := 2097153
    static DEBUG_FLR_XML_MODULE_LIST := 2097154
    static DEBUG_FLR_STACK_FRAME := 2097155
    static DEBUG_FLR_STACK_FRAME_NUMBER := 2097156
    static DEBUG_FLR_STACK_FRAME_INSTRUCTION := 2097157
    static DEBUG_FLR_STACK_FRAME_SYMBOL := 2097158
    static DEBUG_FLR_STACK_FRAME_SYMBOL_OFFSET := 2097159
    static DEBUG_FLR_STACK_FRAME_MODULE := 2097160
    static DEBUG_FLR_STACK_FRAME_IMAGE := 2097161
    static DEBUG_FLR_STACK_FRAME_FUNCTION := 2097162
    static DEBUG_FLR_STACK_FRAME_FLAGS := 2097163
    static DEBUG_FLR_CONTEXT_COMMAND := 2097164
    static DEBUG_FLR_CONTEXT_FLAGS := 2097165
    static DEBUG_FLR_CONTEXT_ORDER := 2097166
    static DEBUG_FLR_CONTEXT_SYSTEM := 2097167
    static DEBUG_FLR_CONTEXT_ID := 2097168
    static DEBUG_FLR_XML_MODULE_INFO := 2097169
    static DEBUG_FLR_XML_MODULE_INFO_INDEX := 2097170
    static DEBUG_FLR_XML_MODULE_INFO_NAME := 2097171
    static DEBUG_FLR_XML_MODULE_INFO_IMAGE_NAME := 2097172
    static DEBUG_FLR_XML_MODULE_INFO_IMAGE_PATH := 2097173
    static DEBUG_FLR_XML_MODULE_INFO_CHECKSUM := 2097174
    static DEBUG_FLR_XML_MODULE_INFO_TIMESTAMP := 2097175
    static DEBUG_FLR_XML_MODULE_INFO_UNLOADED := 2097176
    static DEBUG_FLR_XML_MODULE_INFO_ON_STACK := 2097177
    static DEBUG_FLR_XML_MODULE_INFO_FIXED_FILE_VER := 2097178
    static DEBUG_FLR_XML_MODULE_INFO_FIXED_PROD_VER := 2097179
    static DEBUG_FLR_XML_MODULE_INFO_STRING_FILE_VER := 2097180
    static DEBUG_FLR_XML_MODULE_INFO_STRING_PROD_VER := 2097181
    static DEBUG_FLR_XML_MODULE_INFO_COMPANY_NAME := 2097182
    static DEBUG_FLR_XML_MODULE_INFO_FILE_DESCRIPTION := 2097183
    static DEBUG_FLR_XML_MODULE_INFO_INTERNAL_NAME := 2097184
    static DEBUG_FLR_XML_MODULE_INFO_ORIG_FILE_NAME := 2097185
    static DEBUG_FLR_XML_MODULE_INFO_BASE := 2097186
    static DEBUG_FLR_XML_MODULE_INFO_SIZE := 2097187
    static DEBUG_FLR_XML_MODULE_INFO_PRODUCT_NAME := 2097188
    static DEBUG_FLR_PROCESS_INFO := 2097189
    static DEBUG_FLR_EXCEPTION_MODULE_INFO := 2097190
    static DEBUG_FLR_CONTEXT_FOLLOWUP_INDEX := 2097191
    static DEBUG_FLR_XML_GLOBALATTRIBUTE_LIST := 2097192
    static DEBUG_FLR_XML_ATTRIBUTE_LIST := 2097193
    static DEBUG_FLR_XML_ATTRIBUTE := 2097194
    static DEBUG_FLR_XML_ATTRIBUTE_NAME := 2097195
    static DEBUG_FLR_XML_ATTRIBUTE_VALUE := 2097196
    static DEBUG_FLR_XML_ATTRIBUTE_D1VALUE := 2097197
    static DEBUG_FLR_XML_ATTRIBUTE_D2VALUE := 2097198
    static DEBUG_FLR_XML_ATTRIBUTE_DOVALUE := 2097199
    static DEBUG_FLR_XML_ATTRIBUTE_VALUE_TYPE := 2097200
    static DEBUG_FLR_XML_ATTRIBUTE_FRAME_NUMBER := 2097201
    static DEBUG_FLR_XML_ATTRIBUTE_THREAD_INDEX := 2097202
    static DEBUG_FLR_XML_PROBLEMCLASS_LIST := 2097203
    static DEBUG_FLR_XML_PROBLEMCLASS := 2097204
    static DEBUG_FLR_XML_PROBLEMCLASS_NAME := 2097205
    static DEBUG_FLR_XML_PROBLEMCLASS_VALUE := 2097206
    static DEBUG_FLR_XML_PROBLEMCLASS_VALUE_TYPE := 2097207
    static DEBUG_FLR_XML_PROBLEMCLASS_FRAME_NUMBER := 2097208
    static DEBUG_FLR_XML_PROBLEMCLASS_THREAD_INDEX := 2097209
    static DEBUG_FLR_XML_STACK_FRAME_TRIAGE_STATUS := 2097210
    static DEBUG_FLR_CONTEXT_METADATA := 2097211
    static DEBUG_FLR_STACK_FRAMES := 2097212
    static DEBUG_FLR_XML_ENCODED_OFFSETS := 2097213
    static DEBUG_FLR_FA_PERF_DATA := 2097214
    static DEBUG_FLR_FA_PERF_ITEM := 2097215
    static DEBUG_FLR_FA_PERF_ITEM_NAME := 2097216
    static DEBUG_FLR_FA_PERF_ITERATIONS := 2097217
    static DEBUG_FLR_FA_PERF_ELAPSED_MS := 2097218
    static DEBUG_FLR_STACK_SHA1_HASH_MF := 2097219
    static DEBUG_FLR_STACK_SHA1_HASH_MFO := 2097220
    static DEBUG_FLR_STACK_SHA1_HASH_M := 2097221
    static DEBUG_FLR_XML_MODULE_INFO_SYMBOL_TYPE := 2097222
    static DEBUG_FLR_XML_MODULE_INFO_FILE_FLAGS := 2097223
    static DEBUG_FLR_STACK_FRAME_MODULE_BASE := 2097224
    static DEBUG_FLR_STACK_FRAME_SRC := 2097225
    static DEBUG_FLR_XML_SYSTEMINFO := 2097226
    static DEBUG_FLR_XML_SYSTEMINFO_SYSTEMMANUFACTURER := 2097227
    static DEBUG_FLR_XML_SYSTEMINFO_SYSTEMMODEL := 2097228
    static DEBUG_FLR_XML_SYSTEMINFO_SYSTEMMARKER := 2097229
    static DEBUG_FLR_FA_ADHOC_ANALYSIS_ITEMS := 2097230
    static DEBUG_FLR_XML_APPLICATION_NAME := 2097231
    static DEBUG_FLR_XML_PACKAGE_MONIKER := 2097232
    static DEBUG_FLR_XML_PACKAGE_RELATIVE_APPLICATION_ID := 2097233
    static DEBUG_FLR_XML_MODERN_ASYNC_REQUEST_OUTSTANDING := 2097234
    static DEBUG_FLR_XML_EVENTTYPE := 2097235
    static DEBUG_FLR_XML_PACKAGE_NAME := 2097236
    static DEBUG_FLR_XML_PACKAGE_VERSION := 2097237
    static DEBUG_FLR_FAILURE_LIST := 2097238
    static DEBUG_FLR_FAILURE_DISPLAY_NAME := 2097239
    static DEBUG_FLR_FRAME_SOURCE_FILE_NAME := 2097240
    static DEBUG_FLR_FRAME_SOURCE_FILE_PATH := 2097241
    static DEBUG_FLR_FRAME_SOURCE_LINE_NUMBER := 2097242
    static DEBUG_FLR_XML_MODULE_INFO_SYMSRV_IMAGE_STATUS := 2097243
    static DEBUG_FLR_XML_MODULE_INFO_SYMSRV_IMAGE_ERROR := 2097244
    static DEBUG_FLR_XML_MODULE_INFO_SYMSRV_IMAGE_DETAIL := 2097245
    static DEBUG_FLR_XML_MODULE_INFO_SYMSRV_IMAGE_SEC := 2097246
    static DEBUG_FLR_XML_MODULE_INFO_SYMSRV_PDB_STATUS := 2097247
    static DEBUG_FLR_XML_MODULE_INFO_SYMSRV_PDB_ERROR := 2097248
    static DEBUG_FLR_XML_MODULE_INFO_SYMSRV_PDB_DETAIL := 2097249
    static DEBUG_FLR_XML_MODULE_INFO_SYMSRV_PDB_SEC := 2097250
    static DEBUG_FLR_XML_MODULE_INFO_DRIVER_GROUP := 2097251
    static DEBUG_FLR_REGISTRY_DATA := 3145728
    static DEBUG_FLR_WMI_QUERY_DATA := 3149824
    static DEBUG_FLR_USER_GLOBAL_ATTRIBUTES := 3153920
    static DEBUG_FLR_USER_THREAD_ATTRIBUTES := 3158016
    static DEBUG_FLR_USER_PROBLEM_CLASSES := 3162112
    static DEBUG_FLR_SM_COMPRESSION_FORMAT := 1342177280
    static DEBUG_FLR_SM_SOURCE_PFN1 := 1342177281
    static DEBUG_FLR_SM_SOURCE_PFN2 := 1342177282
    static DEBUG_FLR_SM_SOURCE_OFFSET := 1342177283
    static DEBUG_FLR_SM_SOURCE_SIZE := 1342177284
    static DEBUG_FLR_SM_TARGET_PFN := 1342177285
    static DEBUG_FLR_SM_BUFFER_HASH := 1342177286
    static DEBUG_FLR_SM_ONEBIT_SOLUTION_COUNT := 1342177287
    static DEBUG_FLR_STORE_PRODUCT_ID := 1610612736
    static DEBUG_FLR_STORE_PRODUCT_DISPLAY_NAME := 1610612737
    static DEBUG_FLR_STORE_PRODUCT_DESCRIPTION := 1610612738
    static DEBUG_FLR_STORE_PRODUCT_EXTENDED_NAME := 1610612739
    static DEBUG_FLR_STORE_PUBLISHER_ID := 1610612740
    static DEBUG_FLR_STORE_PUBLISHER_NAME := 1610612741
    static DEBUG_FLR_STORE_PUBLISHER_CERTIFICATE_NAME := 1610612742
    static DEBUG_FLR_STORE_DEVELOPER_NAME := 1610612743
    static DEBUG_FLR_STORE_PACKAGE_FAMILY_NAME := 1610612744
    static DEBUG_FLR_STORE_PACKAGE_IDENTITY_NAME := 1610612745
    static DEBUG_FLR_STORE_PRIMARY_PARENT_PRODUCT_ID := 1610612746
    static DEBUG_FLR_STORE_LEGACY_PARENT_PRODUCT_ID := 1610612747
    static DEBUG_FLR_STORE_LEGACY_WINDOWS_STORE_PRODUCT_ID := 1610612748
    static DEBUG_FLR_STORE_LEGACY_WINDOWS_PHONE_PRODUCT_ID := 1610612749
    static DEBUG_FLR_STORE_LEGACY_XBOX_ONE_PRODUCT_ID := 1610612750
    static DEBUG_FLR_STORE_LEGACY_XBOX_360_PRODUCT_ID := 1610612751
    static DEBUG_FLR_STORE_XBOX_TITLE_ID := 1610612752
    static DEBUG_FLR_STORE_PREFERRED_SKU_ID := 1610612753
    static DEBUG_FLR_STORE_IS_MICROSOFT_PRODUCT := 1610612754
    static DEBUG_FLR_STORE_URL_APP := 1610612755
    static DEBUG_FLR_STORE_URL_APPHEALTH := 1610612756
    static DEBUG_FLR_PHONE_VERSIONMAJOR := 1879048192
    static DEBUG_FLR_PHONE_VERSIONMINOR := 1879048193
    static DEBUG_FLR_PHONE_BUILDNUMBER := 1879048194
    static DEBUG_FLR_PHONE_BUILDTIMESTAMP := 1879048195
    static DEBUG_FLR_PHONE_BUILDBRANCH := 1879048196
    static DEBUG_FLR_PHONE_BUILDER := 1879048197
    static DEBUG_FLR_PHONE_LCID := 1879048198
    static DEBUG_FLR_PHONE_QFE := 1879048199
    static DEBUG_FLR_PHONE_OPERATOR := 1879048200
    static DEBUG_FLR_PHONE_MCCMNC := 1879048201
    static DEBUG_FLR_PHONE_FIRMWAREREVISION := 1879048202
    static DEBUG_FLR_PHONE_RAM := 1879048203
    static DEBUG_FLR_PHONE_ROMVERSION := 1879048204
    static DEBUG_FLR_PHONE_SOCVERSION := 1879048205
    static DEBUG_FLR_PHONE_HARDWAREREVISION := 1879048206
    static DEBUG_FLR_PHONE_RADIOHARDWAREREVISION := 1879048207
    static DEBUG_FLR_PHONE_RADIOSOFTWAREREVISION := 1879048208
    static DEBUG_FLR_PHONE_BOOTLOADERVERSION := 1879048209
    static DEBUG_FLR_PHONE_REPORTGUID := 1879048210
    static DEBUG_FLR_PHONE_SOURCE := 1879048211
    static DEBUG_FLR_PHONE_SOURCEEXTERNAL := 1879048212
    static DEBUG_FLR_PHONE_USERALIAS := 1879048213
    static DEBUG_FLR_PHONE_REPORTTIMESTAMP := 1879048214
    static DEBUG_FLR_PHONE_APPID := 1879048215
    static DEBUG_FLR_PHONE_SKUID := 1879048216
    static DEBUG_FLR_PHONE_APPVERSION := 1879048217
    static DEBUG_FLR_PHONE_UIF_COMMENT := 1879048218
    static DEBUG_FLR_PHONE_UIF_APPNAME := 1879048219
    static DEBUG_FLR_PHONE_UIF_APPID := 1879048220
    static DEBUG_FLR_PHONE_UIF_CATEGORY := 1879048221
    static DEBUG_FLR_PHONE_UIF_ORIGIN := 1879048222
    static DEBUG_FLR_SIMULTANEOUS_TELSVC_INSTANCES := 1879048223
    static DEBUG_FLR_SIMULTANEOUS_TELWP_INSTANCES := 1879048224
    static DEBUG_FLR_MINUTES_SINCE_LAST_EVENT := 1879048225
    static DEBUG_FLR_MINUTES_SINCE_LAST_EVENT_OF_THIS_TYPE := 1879048226
    static DEBUG_FLR_REPORT_INFO_GUID := 1879048227
    static DEBUG_FLR_REPORT_INFO_SOURCE := 1879048228
    static DEBUG_FLR_REPORT_INFO_CREATION_TIME := 1879048229
    static DEBUG_FLR_FAULTING_IP := -2147483648
    static DEBUG_FLR_FAULTING_MODULE := -2147483647
    static DEBUG_FLR_IMAGE_TIMESTAMP := -2147483646
    static DEBUG_FLR_FOLLOWUP_IP := -2147483645
    static DEBUG_FLR_FRAME_ONE_INVALID := -2147483644
    static DEBUG_FLR_SYMBOL_FROM_RAW_STACK_ADDRESS := -2147483643
    static DEBUG_FLR_IMAGE_VERSION := -2147483642
    static DEBUG_FLR_FOLLOWUP_BUCKET_ID := -2147483641
    static DEBUG_FLR_CUSTOM_ANALYSIS_TAG_MIN := -1610612736
    static DEBUG_FLR_CUSTOM_ANALYSIS_TAG_MAX := -1342177280
    static DEBUG_FLR_FAULTING_THREAD := -1073741824
    static DEBUG_FLR_CONTEXT := -1073741823
    static DEBUG_FLR_TRAP_FRAME := -1073741822
    static DEBUG_FLR_TSS := -1073741821
    static DEBUG_FLR_BLOCKING_THREAD := -1073741820
    static DEBUG_FLR_UNRESPONSIVE_UI_THREAD := -1073741819
    static DEBUG_FLR_BLOCKED_THREAD0 := -1073741818
    static DEBUG_FLR_BLOCKED_THREAD1 := -1073741817
    static DEBUG_FLR_BLOCKED_THREAD2 := -1073741816
    static DEBUG_FLR_BLOCKING_PROCESSID := -1073741815
    static DEBUG_FLR_PROCESSOR_ID := -1073741814
    static DEBUG_FLR_XDV_VIOLATED_CONDITION := -1073741813
    static DEBUG_FLR_XDV_STATE_VARIABLE := -1073741812
    static DEBUG_FLR_XDV_HELP_LINK := -1073741811
    static DEBUG_FLR_XDV_RULE_INFO := -1073741810
    static DEBUG_FLR_DPC_STACK_BASE := -1073741809
    static DEBUG_FLR_TESTRESULTSERVER := -268435456
    static DEBUG_FLR_TESTRESULTGUID := -268435455
    static DEBUG_FLR_CUSTOMREPORTTAG := -268435454
    static DEBUG_FLR_DISKSEC_ORGID_DEPRECATED := -268435453
    static DEBUG_FLR_DISKSEC_MODEL_DEPRECATED := -268435452
    static DEBUG_FLR_DISKSEC_MFGID_DEPRECATED := -268435451
    static DEBUG_FLR_DISKSEC_ISSUEDESCSTRING_DEPRECATED := -268435450
    static DEBUG_FLR_DISKSEC_PUBLIC_TOTSIZE_DEPRECATED := -268435449
    static DEBUG_FLR_DISKSEC_PUBLIC_OFFSET_DEPRECATED := -268435448
    static DEBUG_FLR_DISKSEC_PUBLIC_DATASIZE_DEPRECATED := -268435447
    static DEBUG_FLR_DISKSEC_PRIVATE_TOTSIZE_DEPRECATED := -268435446
    static DEBUG_FLR_DISKSEC_PRIVATE_OFFSET_DEPRECATED := -268435445
    static DEBUG_FLR_DISKSEC_PRIVATE_DATASIZE_DEPRECATED := -268435444
    static DEBUG_FLR_DISKSEC_TOTALSIZE_DEPRECATED := -268435443
    static DEBUG_FLR_DISKSEC_REASON_DEPRECATED := -268435442
    static DEBUG_FLR_WERCOLLECTION_PROCESSTERMINATED := -268435441
    static DEBUG_FLR_WERCOLLECTION_PROCESSHEAPDUMP_REQUEST_FAILURE := -268435440
    static DEBUG_FLR_WERCOLLECTION_MINIDUMP_WRITE_FAILURE := -268435439
    static DEBUG_FLR_WERCOLLECTION_DEFAULTCOLLECTION_FAILURE := -268435438
    static DEBUG_FLR_PROCESS_BAM_CURRENT_THROTTLED := -268435437
    static DEBUG_FLR_PROCESS_BAM_PREVIOUS_THROTTLED := -268435436
    static DEBUG_FLR_DUMPSTREAM_COMMENTA := -268435435
    static DEBUG_FLR_DUMPSTREAM_COMMENTW := -268435434
    static DEBUG_FLR_CHPE_PROCESS := -268435433
    static DEBUG_FLR_WINLOGON_BLACKBOX := -268435432
    static DEBUG_FLR_CUSTOM_COMMAND := -268435431
    static DEBUG_FLR_CUSTOM_COMMAND_OUTPUT := -268435430
    static DEBUG_FLR_MASK_ALL := -1
}
struct DBG_THREAD_ATTRIBUTES {
    ThreadIndex : UInt32
    ProcessID : Int64
    ThreadID : Int64
    AttributeBits : Int64
    BoolBits : UInt32
    BlockedOnPID : Int64
    BlockedOnTID : Int64
    CritSecAddress : Int64
    Timeout_msec : UInt32
    StringData : CHAR[100]
    SymName : CHAR[100]
}
struct FA_ENTRY_TYPE extends Int32 {
    static DEBUG_FA_ENTRY_NO_TYPE := 0
    static DEBUG_FA_ENTRY_ULONG := 1
    static DEBUG_FA_ENTRY_ULONG64 := 2
    static DEBUG_FA_ENTRY_INSTRUCTION_OFFSET := 3
    static DEBUG_FA_ENTRY_POINTER := 4
    static DEBUG_FA_ENTRY_ANSI_STRING := 5
    static DEBUG_FA_ENTRY_ANSI_STRINGs := 6
    static DEBUG_FA_ENTRY_EXTENSION_CMD := 7
    static DEBUG_FA_ENTRY_STRUCTURED_DATA := 8
    static DEBUG_FA_ENTRY_UNICODE_STRING := 9
    static DEBUG_FA_ENTRY_ARRAY := 32768
}
struct IDebugFAEntryTags extends InterfacePointer {
    GetType(Tag)
      => ComCall(0, this.p, DEBUG_FLR_PARAM_TYPE, Tag, FA_ENTRY_TYPE)
    SetType(Tag, EntryType)
      => ComCall(1, this.p, DEBUG_FLR_PARAM_TYPE, Tag, FA_ENTRY_TYPE, EntryType)
    GetProperties(Tag, Name?, NameSize := Name.Size, Description?, DescSize := Description.Size, Flags?)
      => ComCall(2, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Name?, UInt32.Ptr, NameSize?, PSTR, Description?, UInt32.Ptr, DescSize?, UInt32.Ptr, Flags?)
    SetProperties(Tag, Name?, Description?, Flags?)
      => ComCall(3, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Name?, PSTR, Description?, UInt32, Flags?)
    GetTagByName(PluginId?, TagName, Tag)
      => ComCall(4, this.p, PSTR, PluginId?, PSTR, TagName, DEBUG_FLR_PARAM_TYPE.Ptr, Tag)
    IsValidTagToSet(Tag)
      => ComCall(5, this.p, DEBUG_FLR_PARAM_TYPE, Tag, BOOL)
}
struct FA_ENTRY {
    Tag : DEBUG_FLR_PARAM_TYPE
    FullSize : UInt16
    DataSize : UInt16
}
struct IDebugFailureAnalysis extends IUnknown {
    static IID := "{ED0DE363-451F-4943-820C-62DCCDFA7E6D}"
    GetFailureClass()
      => ComCall(3, this.p, UInt32)
    GetFailureType()
      => ComCall(4, this.p, DEBUG_FAILURE_TYPE)
    GetFailureCode()
      => ComCall(5, this.p, UInt32)
    Get(Tag)
      => ComCall(6, this.p, DEBUG_FLR_PARAM_TYPE, Tag, FA_ENTRY.Ptr)
    GetNext(Entry, Tag, TagMask)
      => ComCall(7, this.p, FA_ENTRY.Ptr, Entry, DEBUG_FLR_PARAM_TYPE, Tag, DEBUG_FLR_PARAM_TYPE, TagMask, FA_ENTRY.Ptr)
    GetString(Tag, Str)
      => ComCall(8, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Str, UInt32, Str.Size, FA_ENTRY.Ptr)
    GetBuffer(Tag, Buf)
      => ComCall(9, this.p, DEBUG_FLR_PARAM_TYPE, Tag, Struct.Ptr, Buf, UInt32, Buf.Size, FA_ENTRY.Ptr)
    GetUlong(Tag, Value)
      => ComCall(10, this.p, DEBUG_FLR_PARAM_TYPE, Tag, UInt32.Ptr, Value, FA_ENTRY.Ptr)
    GetUlong64(Tag, Value)
      => ComCall(11, this.p, DEBUG_FLR_PARAM_TYPE, Tag, Int64.Ptr, Value, FA_ENTRY.Ptr)
    NextEntry(Entry?)
      => ComCall(12, this.p, FA_ENTRY.Ptr, Entry?, FA_ENTRY.Ptr)
}
struct IDebugFailureAnalysis2 extends IUnknown {
    static IID := "{EA15C288-8226-4B70-ACF6-0BE6B189E3AD}"
    GetFailureClass()
      => ComCall(3, this.p, UInt32)
    GetFailureType()
      => ComCall(4, this.p, DEBUG_FAILURE_TYPE)
    GetFailureCode()
      => ComCall(5, this.p, UInt32)
    Get(Tag)
      => ComCall(6, this.p, DEBUG_FLR_PARAM_TYPE, Tag, FA_ENTRY.Ptr)
    GetNext(Entry, Tag, TagMask)
      => ComCall(7, this.p, FA_ENTRY.Ptr, Entry, DEBUG_FLR_PARAM_TYPE, Tag, DEBUG_FLR_PARAM_TYPE, TagMask, FA_ENTRY.Ptr)
    GetString(Tag, Str)
      => ComCall(8, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Str, UInt32, Str.Length, FA_ENTRY.Ptr)
    GetBuffer(Tag, Buf)
      => ComCall(9, this.p, DEBUG_FLR_PARAM_TYPE, Tag, Struct.Ptr, Buf, UInt32, Buf.Size, FA_ENTRY.Ptr)
    GetUlong(Tag, Value)
      => ComCall(10, this.p, DEBUG_FLR_PARAM_TYPE, Tag, UInt32.Ptr, Value, FA_ENTRY.Ptr)
    GetUlong64(Tag, Value)
      => ComCall(11, this.p, DEBUG_FLR_PARAM_TYPE, Tag, Int64.Ptr, Value, FA_ENTRY.Ptr)
    NextEntry(Entry?)
      => ComCall(12, this.p, FA_ENTRY.Ptr, Entry?, FA_ENTRY.Ptr)
    SetString(Tag, Str)
      => ComCall(13, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Str, FA_ENTRY.Ptr)
    SetExtensionCommand(Tag, Extension)
      => ComCall(14, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Extension, FA_ENTRY.Ptr)
    SetUlong(Tag, Value)
      => ComCall(15, this.p, DEBUG_FLR_PARAM_TYPE, Tag, UInt32, Value, FA_ENTRY.Ptr)
    SetUlong64(Tag, Value)
      => ComCall(16, this.p, DEBUG_FLR_PARAM_TYPE, Tag, Int64, Value, FA_ENTRY.Ptr)
    SetBuffer(Tag, EntryType, Buf)
      => ComCall(17, this.p, DEBUG_FLR_PARAM_TYPE, Tag, FA_ENTRY_TYPE, EntryType, Struct.Ptr, Buf, UInt32, Buf.Size, FA_ENTRY.Ptr)
    AddString(Tag, Str)
      => ComCall(18, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Str, FA_ENTRY.Ptr)
    AddExtensionCommand(Tag, Extension)
      => ComCall(19, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Extension, FA_ENTRY.Ptr)
    AddUlong(Tag, Value)
      => ComCall(20, this.p, DEBUG_FLR_PARAM_TYPE, Tag, UInt32, Value, FA_ENTRY.Ptr)
    AddUlong64(Tag, Value)
      => ComCall(21, this.p, DEBUG_FLR_PARAM_TYPE, Tag, Int64, Value, FA_ENTRY.Ptr)
    AddBuffer(Tag, EntryType, Buf)
      => ComCall(22, this.p, DEBUG_FLR_PARAM_TYPE, Tag, FA_ENTRY_TYPE, EntryType, Struct.Ptr, Buf, UInt32, Buf.Size, FA_ENTRY.Ptr)
    GetDebugFATagControl(FATagControl)
      => ComCall(23, this.p, IDebugFAEntryTags.Ptr, FATagControl)
    GetAnalysisXml(ppXMLDOMElement)
      => ComCall(24, this.p, IXMLDOMElement.Ptr, ppXMLDOMElement)
    AddStructuredAnalysisData(Tag, Analysis)
      => ComCall(25, this.p, DEBUG_FLR_PARAM_TYPE, Tag, IDebugFailureAnalysis2, Analysis)
}
struct IDebugFailureAnalysis3 extends IUnknown {
    static IID := "{3627DC67-FD45-42FF-9BA4-4A67EE64619F}"
    GetFailureClass()
      => ComCall(3, this.p, UInt32)
    GetFailureType()
      => ComCall(4, this.p, DEBUG_FAILURE_TYPE)
    GetFailureCode()
      => ComCall(5, this.p, UInt32)
    Get(Tag)
      => ComCall(6, this.p, DEBUG_FLR_PARAM_TYPE, Tag, FA_ENTRY.Ptr)
    GetNext(Entry, Tag, TagMask)
      => ComCall(7, this.p, FA_ENTRY.Ptr, Entry, DEBUG_FLR_PARAM_TYPE, Tag, DEBUG_FLR_PARAM_TYPE, TagMask, FA_ENTRY.Ptr)
    GetString(Tag, Str)
      => ComCall(8, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Str, UInt32, Str.Length, FA_ENTRY.Ptr)
    GetBuffer(Tag, Buf)
      => ComCall(9, this.p, DEBUG_FLR_PARAM_TYPE, Tag, Struct.Ptr, Buf, UInt32, Buf.Size, FA_ENTRY.Ptr)
    GetUlong(Tag, Value)
      => ComCall(10, this.p, DEBUG_FLR_PARAM_TYPE, Tag, UInt32.Ptr, Value, FA_ENTRY.Ptr)
    GetUlong64(Tag, Value)
      => ComCall(11, this.p, DEBUG_FLR_PARAM_TYPE, Tag, Int64.Ptr, Value, FA_ENTRY.Ptr)
    NextEntry(Entry?)
      => ComCall(12, this.p, FA_ENTRY.Ptr, Entry?, FA_ENTRY.Ptr)
    SetString(Tag, Str)
      => ComCall(13, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Str, FA_ENTRY.Ptr)
    SetExtensionCommand(Tag, Extension)
      => ComCall(14, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Extension, FA_ENTRY.Ptr)
    SetUlong(Tag, Value)
      => ComCall(15, this.p, DEBUG_FLR_PARAM_TYPE, Tag, UInt32, Value, FA_ENTRY.Ptr)
    SetUlong64(Tag, Value)
      => ComCall(16, this.p, DEBUG_FLR_PARAM_TYPE, Tag, Int64, Value, FA_ENTRY.Ptr)
    SetBuffer(Tag, EntryType, Buf)
      => ComCall(17, this.p, DEBUG_FLR_PARAM_TYPE, Tag, FA_ENTRY_TYPE, EntryType, Struct.Ptr, Buf, UInt32, Buf.Size, FA_ENTRY.Ptr)
    AddString(Tag, Str)
      => ComCall(18, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Str, FA_ENTRY.Ptr)
    AddExtensionCommand(Tag, Extension)
      => ComCall(19, this.p, DEBUG_FLR_PARAM_TYPE, Tag, PSTR, Extension, FA_ENTRY.Ptr)
    AddUlong(Tag, Value)
      => ComCall(20, this.p, DEBUG_FLR_PARAM_TYPE, Tag, UInt32, Value, FA_ENTRY.Ptr)
    AddUlong64(Tag, Value)
      => ComCall(21, this.p, DEBUG_FLR_PARAM_TYPE, Tag, Int64, Value, FA_ENTRY.Ptr)
    AddBuffer(Tag, EntryType, Buf)
      => ComCall(22, this.p, DEBUG_FLR_PARAM_TYPE, Tag, FA_ENTRY_TYPE, EntryType, Struct.Ptr, Buf, UInt32, Buf.Size, FA_ENTRY.Ptr)
    GetDebugFATagControl(FATagControl)
      => ComCall(23, this.p, IDebugFAEntryTags.Ptr, FATagControl)
    GetAnalysisXml(ppXMLDOMElement)
      => ComCall(24, this.p, IXMLDOMElement.Ptr, ppXMLDOMElement)
    AddStructuredAnalysisData(Tag, Analysis)
      => ComCall(25, this.p, DEBUG_FLR_PARAM_TYPE, Tag, IDebugFailureAnalysis2, Analysis)
    AddThreads(pDebugFailureThreadEnum)
      => ComCall(26, this.p, IUnknown, pDebugFailureThreadEnum)
    AttributeGet(nIndex, pValue)
      => ComCall(27, this.p, UInt32, nIndex, VARIANT.Ptr, pValue)
    AttributeGetName(nIndex, pName)
      => ComCall(28, this.p, UInt32, nIndex, BSTR.Ptr, pName)
    AttributeSet(nIndex, Value)
      => ComCall(29, this.p, UInt32, nIndex, VARIANT, Value)
    BlameApplication(Postfix)
      => ComCall(30, this.p, BSTR, Postfix)
    BlameProcess(Postfix)
      => ComCall(31, this.p, BSTR, Postfix)
    BlameThread(pThread)
      => ComCall(32, this.p, IUnknown, pThread)
    BlameStitch(pThread, Stitch)
      => ComCall(33, this.p, IUnknown, pThread, BSTR, Stitch)
    BlameTEB(Address)
      => ComCall(34, this.p, Int64, Address)
    BlameETHREAD(Address)
      => ComCall(35, this.p, Int64, Address)
    ProblemClassIsSet(nIndex, pSet)
      => ComCall(36, this.p, UInt32, nIndex, VARIANT_BOOL.Ptr, pSet)
    ProblemClassDelete(nIndex)
      => ComCall(37, this.p, UInt32, nIndex)
    ProblemClassSet(nIndex)
      => ComCall(38, this.p, UInt32, nIndex)
    ProblemClassSetBSTR(nIndex, Value)
      => ComCall(39, this.p, UInt32, nIndex, BSTR, Value)
    SetAdditionalXML(Key, pXMLDOMElement)
      => ComCall(40, this.p, BSTR, Key, IUnknown, pXMLDOMElement)
    GetAdditionalXML(Key, ppXMLDOMElement)
      => ComCall(41, this.p, BSTR, Key, IUnknown.Ptr, ppXMLDOMElement)
    DeleteAdditionalXML(Key)
      => ComCall(42, this.p, BSTR, Key)
}
struct EXT_GET_FAILURE_ANALYSIS extends FunctionPointer {
    static Types := [IDebugClient4, UInt32, IDebugFailureAnalysis.Ptr, HRESULT]
}
struct EXT_GET_DEBUG_FAILURE_ANALYSIS extends FunctionPointer {
    static Types := [IDebugClient4, UInt32, GUID, IDebugFailureAnalysis2.Ptr, HRESULT]
}
struct fnDebugFailureAnalysisCreateInstance extends FunctionPointer {
    static Types := [IDebugClient, PWSTR, UInt32, GUID.Ptr, GUID.Ptr, Struct.Ptr.Ptr, HRESULT]
}
struct FA_EXTENSION_PLUGIN_PHASE extends Int32 {
    static FA_PLUGIN_INITIALIZATION := 1
    static FA_PLUGIN_STACK_ANALYSIS := 2
    static FA_PLUGIN_PRE_BUCKETING := 4
    static FA_PLUGIN_POST_BUCKETING := 8
}
struct EXT_ANALYSIS_PLUGIN extends FunctionPointer {
    static Types := [IDebugClient4, FA_EXTENSION_PLUGIN_PHASE, IDebugFailureAnalysis2, HRESULT]
}
struct EXT_GET_FA_ENTRIES_DATA extends FunctionPointer {
    static Types := [IDebugClient4, UInt32.Ptr, FA_ENTRY.Ptr.Ptr, HRESULT]
}
struct OS_TYPE extends Int32 {
    static WIN_95 := 0
    static WIN_98 := 1
    static WIN_ME := 2
    static WIN_NT4 := 3
    static WIN_NT5 := 4
    static WIN_NT5_1 := 5
    static WIN_NT5_2 := 6
    static WIN_NT6_0 := 7
    static WIN_NT6_1 := 8
    static WIN_UNDEFINED := 255
}
struct OS_INFO {
    MajorVer : UInt32
    MinorVer : UInt32
    Build : UInt32
    BuildQfe : UInt32
    ProductType : UInt32
    Suite : UInt32
    Revision : UInt32
    s : this._s_e__Struct
    SrvPackNumber : UInt32
    ServicePackBuild : UInt32
    Architecture : UInt32
    Lcid : UInt32
    Name : CHAR[64]
    FullName : CHAR[256]
    Language : CHAR[30]
    BuildVersion : CHAR[64]
    ServicePackString : CHAR[64]
    struct _s_e__Struct {
        _bitfield : UInt32
    }
}
struct CPU_INFO {
    Type : UInt32
    NumCPUs : UInt32
    CurrentProc : UInt32
    ProcInfo : DEBUG_PROCESSOR_IDENTIFICATION_ALL[2048]
    Mhz : UInt32
}
struct TARGET_DEBUG_INFO {
    SizeOfStruct : UInt32
    EntryDate : Int64
    DebugeeClass : UInt32
    SysUpTime : Int64
    AppUpTime : Int64
    CrashTime : Int64
    OsInfo : OS_INFO
    Cpu : CPU_INFO
    DumpFile : CHAR[260]
}
struct CPU_INFO_v2 {
    Type : UInt32
    NumCPUs : UInt32
    CurrentProc : UInt32
    ProcInfo : DEBUG_PROCESSOR_IDENTIFICATION_ALL[1280]
    Mhz : UInt32
}
struct TARGET_DEBUG_INFO_v2 {
    SizeOfStruct : UInt32
    EntryDate : Int64
    DebugeeClass : UInt32
    SysUpTime : Int64
    AppUpTime : Int64
    CrashTime : Int64
    OsInfo : OS_INFO
    Cpu : CPU_INFO_v2
    DumpFile : CHAR[260]
}
struct OS_INFO_v1 {
    Type : OS_TYPE
    Anonymous : this._Anonymous_e__Union
    ProductType : UInt32
    Suite : UInt32
    s : this._s_e__Struct
    SrvPackNumber : UInt32
    Language : CHAR[30]
    OsString : CHAR[64]
    ServicePackString : CHAR[64]
    struct _Anonymous_e__Union {
        union {
            Version : this._Version_e__Struct
            Ver64 : Int64
        }
        struct _Version_e__Struct {
            Major : UInt32
            Minor : UInt32
        }
    }
    struct _s_e__Struct {
        _bitfield : UInt32
    }
}
struct CPU_INFO_v1 {
    Type : UInt32
    NumCPUs : UInt32
    CurrentProc : UInt32
    ProcInfo : DEBUG_PROCESSOR_IDENTIFICATION_ALL[32]
    Mhz : UInt32
}
struct TARGET_DEBUG_INFO_v1 {
    SizeOfStruct : UInt32
    Id : Int64
    Source : Int64
    EntryDate : Int64
    SysUpTime : Int64
    AppUpTime : Int64
    CrashTime : Int64
    Mode : Int64
    OsInfo : OS_INFO_v1
    Cpu : CPU_INFO_v1
    DumpFile : CHAR[260]
    FailureData : Struct.Ptr
    StackTr : CHAR[4096]
}
struct EXT_TARGET_INFO extends FunctionPointer {
    static Types := [IDebugClient4, TARGET_DEBUG_INFO.Ptr, HRESULT]
}
struct DEBUG_DECODE_ERROR {
    SizeOfStruct : UInt32
    Code : UInt32
    TreatAsStatus : BOOL
    Source : CHAR[64]
    Message : CHAR[260]
}
struct EXT_DECODE_ERROR extends FunctionPointer {
    static Types := [DEBUG_DECODE_ERROR.Ptr, "Void"]
}
struct DEBUG_TRIAGE_FOLLOWUP_INFO {
    SizeOfStruct : UInt32
    OwnerNameSize : UInt32
    OwnerName : PSTR
}
struct DEBUG_TRIAGE_FOLLOWUP_INFO_2 {
    SizeOfStruct : UInt32
    OwnerNameSize : UInt32
    OwnerName : PSTR
    FeaturePathSize : UInt32
    FeaturePath : PSTR
}
struct EXT_TRIAGE_FOLLOWUP extends FunctionPointer {
    static Types := [IDebugClient4, PSTR, DEBUG_TRIAGE_FOLLOWUP_INFO.Ptr, UInt32]
}
struct EXT_RELOAD_TRIAGER extends FunctionPointer {
    static Types := [IDebugClient4, HRESULT]
}
struct EXT_CAB_XML_DATA {
    SizeOfStruct : UInt32
    XmlObjectTag : PWSTR
    NumSubTags : UInt32
    SubTags : this._SUBTAGS[1]
    struct _SUBTAGS {
        SubTag : PWSTR
        MatchPattern : PWSTR
        ReturnText : PWSTR
        ReturnTextSize : UInt32
        _bitfield : UInt32
        Reserved2 : UInt32
    }
}
struct EXT_XML_DATA extends FunctionPointer {
    static Types := [IDebugClient4, EXT_CAB_XML_DATA.Ptr, HRESULT]
}
struct XML_DRIVER_NODE_INFO {
    FileName : CHAR[64]
    FileSize : Int64
    CreationDate : Int64
    Version : CHAR[64]
    Manufacturer : CHAR[260]
    ProductName : CHAR[260]
    Group : CHAR[260]
    Altitude : CHAR[260]
}
struct EXT_ANALYZER extends FunctionPointer {
    static Types := [IDebugClient, PSTR, UInt32, PSTR, UInt32, UInt32.Ptr, IDebugFailureAnalysis, HRESULT]
}
struct DEBUG_ANALYSIS_PROCESSOR_INFO {
    SizeOfStruct : UInt32
    Model : UInt32
    Family : UInt32
    Stepping : UInt32
    Architecture : UInt32
    Revision : UInt32
    CurrentClockSpeed : UInt32
    CurrentVoltage : UInt32
    MaxClockSpeed : UInt32
    ProcessorType : UInt32
    DeviceID : CHAR[32]
    Manufacturer : CHAR[64]
    Name : CHAR[64]
    Version : CHAR[64]
    Description : CHAR[64]
}
struct EXTDLL_QUERYDATABYTAG extends FunctionPointer {
    static Types := [IDebugClient4, UInt32, Struct.Ptr, UInt8.Ptr, UInt32, HRESULT]
}
struct EXTDLL_QUERYDATABYTAGEX extends FunctionPointer {
    static Types := [IDebugClient4, UInt32, Struct.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32, HRESULT]
}
struct ENTRY_CALLBACK extends FunctionPointer {
    static Types := [Int64, Struct.Ptr, HRESULT]
}
struct EXTDLL_ITERATERTLBALANCEDNODES extends FunctionPointer {
    static Types := [Int64, UInt32, ENTRY_CALLBACK, Struct.Ptr, "Void"]
}
struct EXT_GET_HANDLE_TRACE extends FunctionPointer {
    static Types := [IDebugClient, UInt32, UInt32, Int64.Ptr, Int64.Ptr, UInt32, HRESULT]
}
struct EXT_GET_ENVIRONMENT_VARIABLE extends FunctionPointer {
    static Types := [Int64, PSTR, PSTR, UInt32, HRESULT]
}
struct TANALYZE_RETURN extends Int32 {
    static NO_TYPE := 0
    static PROCESS_END := 1
    static EXIT_STATUS := 2
    static DISK_READ_0_BYTES := 3
    static DISK_WRITE := 4
    static NT_STATUS_CODE := 5
}
struct CKCL_DATA {
    NextLogEvent : Struct.Ptr
    TAnalyzeString : PSTR
    TAnalyzeReturnType : TANALYZE_RETURN
}
struct CKCL_LISTHEAD {
    LogEventListHead : CKCL_DATA.Ptr
    Heap : HANDLE
}
