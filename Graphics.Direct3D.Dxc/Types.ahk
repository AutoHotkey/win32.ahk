#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, PSTR, PWSTR}
#Import "..\System.Com\Types.ahk" {IMalloc, IStream, IUnknown}

struct DXC_CP extends UInt32 {
    static DXC_CP_ACP := 0
    static DXC_CP_UTF16 := 1200
    static DXC_CP_UTF8 := 65001
    static DXC_CP_UTF32 := 12000
    static DXC_CP_WIDE := 1200
}
struct DxcCreateInstanceProc extends FunctionPointer {
    static Types := [GUID.Ptr, GUID.Ptr, Struct.Ptr.Ptr, HRESULT]
}
struct DxcCreateInstance2Proc extends FunctionPointer {
    static Types := [IMalloc, GUID.Ptr, GUID.Ptr, Struct.Ptr.Ptr, HRESULT]
}
struct DxcShaderHash {
    Flags : UInt32
    HashDigest : UInt8[16]
}
struct IDxcBlob extends IUnknown {
    static IID := "{8BA5FB08-5195-40E2-AC58-0D989C3A0102}"
    GetBufferPointer()
      => ComCall(3, this.p, Struct.Ptr)
    GetBufferSize()
      => ComCall(4, this.p, IntPtr)
}
struct IDxcBlobEncoding extends IDxcBlob {
    static IID := "{7241D424-2646-4191-97C0-98E96E42FC68}"
    GetEncoding(pKnown, pCodePage)
      => ComCall(5, this.p, BOOL.Ptr, pKnown, DXC_CP.Ptr, pCodePage)
}
struct IDxcBlobUtf16 extends IDxcBlobEncoding {
    static IID := "{A3F84EAB-0FAA-497E-A39C-EE6ED60B2D84}"
    GetStringPointer()
      => ComCall(6, this.p, PWSTR)
    GetStringLength()
      => ComCall(7, this.p, IntPtr)
}
struct IDxcBlobUtf8 extends IDxcBlobEncoding {
    static IID := "{3DA636C9-BA71-4024-A301-30CBF125305B}"
    GetStringPointer()
      => ComCall(6, this.p, PSTR)
    GetStringLength()
      => ComCall(7, this.p, IntPtr)
}
struct IDxcIncludeHandler extends IUnknown {
    static IID := "{7F61FC7D-950D-467F-B3E3-3C02FB49187C}"
    LoadSource(pFilename, ppIncludeSource)
      => ComCall(3, this.p, "Str", pFilename, IDxcBlob.Ptr, ppIncludeSource)
}
struct DxcBuffer {
    Ptr : Struct.Ptr
    Size : IntPtr
    Encoding : UInt32
}
struct DxcDefine {
    Name : PWSTR
    Value : PWSTR
}
struct IDxcCompilerArgs extends IUnknown {
    static IID := "{73EFFE2A-70DC-45F8-9690-EFF64C02429D}"
    GetArguments()
      => ComCall(3, this.p, PWSTR.Ptr)
    GetCount()
      => ComCall(4, this.p, UInt32)
    AddArguments(pArguments?)
      => ComCall(5, this.p, PWSTR.Ptr, pArguments?, UInt32, pArguments?.Length ?? 0)
    AddArgumentsUTF8(pArguments?)
      => ComCall(6, this.p, PSTR.Ptr, pArguments?, UInt32, pArguments?.Length ?? 0)
    AddDefines(pDefines)
      => ComCall(7, this.p, DxcDefine.Ptr, pDefines, UInt32, pDefines.Length)
}
struct IDxcLibrary extends IUnknown {
    static IID := "{E5204DC7-D18C-4C3C-BDFB-851673980FE7}"
    SetMalloc(pMalloc?)
      => ComCall(3, this.p, IMalloc, pMalloc?)
    CreateBlobFromBlob(pBlob, offset, length, ppResult)
      => ComCall(4, this.p, IDxcBlob, pBlob, UInt32, offset, UInt32, length, IDxcBlob.Ptr, ppResult)
    CreateBlobFromFile(pFileName, codePage?, pBlobEncoding)
      => ComCall(5, this.p, "Str", pFileName, DXC_CP.Ptr, codePage?, IDxcBlobEncoding.Ptr, pBlobEncoding)
    CreateBlobWithEncodingFromPinned(pText, codePage, pBlobEncoding)
      => ComCall(6, this.p, Struct.Ptr, pText, UInt32, pText.Size, DXC_CP, codePage, IDxcBlobEncoding.Ptr, pBlobEncoding)
    CreateBlobWithEncodingOnHeapCopy(pText, codePage, pBlobEncoding)
      => ComCall(7, this.p, Struct.Ptr, pText, UInt32, pText.Size, DXC_CP, codePage, IDxcBlobEncoding.Ptr, pBlobEncoding)
    CreateBlobWithEncodingOnMalloc(pText, pIMalloc, codePage, pBlobEncoding)
      => ComCall(8, this.p, Struct.Ptr, pText, IMalloc, pIMalloc, UInt32, pText.Size, DXC_CP, codePage, IDxcBlobEncoding.Ptr, pBlobEncoding)
    CreateIncludeHandler(ppResult)
      => ComCall(9, this.p, IDxcIncludeHandler.Ptr, ppResult)
    CreateStreamFromBlobReadOnly(pBlob, ppStream)
      => ComCall(10, this.p, IDxcBlob, pBlob, IStream.Ptr, ppStream)
    GetBlobAsUtf8(pBlob, pBlobEncoding)
      => ComCall(11, this.p, IDxcBlob, pBlob, IDxcBlobEncoding.Ptr, pBlobEncoding)
    GetBlobAsWide(pBlob, pBlobEncoding)
      => ComCall(12, this.p, IDxcBlob, pBlob, IDxcBlobEncoding.Ptr, pBlobEncoding)
}
struct IDxcOperationResult extends IUnknown {
    static IID := "{CEDB484A-D4E9-445A-B991-CA21CA157DC2}"
    GetStatus(pStatus)
      => ComCall(3, this.p, HRESULT.Ptr, pStatus)
    GetResult(ppResult)
      => ComCall(4, this.p, IDxcBlob.Ptr, ppResult)
    GetErrorBuffer(ppErrors)
      => ComCall(5, this.p, IDxcBlobEncoding.Ptr, ppErrors)
}
struct IDxcCompiler extends IUnknown {
    static IID := "{8C210BF3-011F-4422-8D70-6F9ACB8DB617}"
    Compile(pSource, pSourceName?, pEntryPoint?, pTargetProfile, pArguments?, pDefines, pIncludeHandler?, ppResult)
      => ComCall(3, this.p, IDxcBlob, pSource, "Str", pSourceName?, "Str", pEntryPoint?, "Str", pTargetProfile, PWSTR.Ptr, pArguments?, UInt32, pArguments?.Length ?? 0, DxcDefine.Ptr, pDefines, UInt32, pDefines.Length, IDxcIncludeHandler, pIncludeHandler?, IDxcOperationResult.Ptr, ppResult)
    Preprocess(pSource, pSourceName?, pArguments?, pDefines, pIncludeHandler?, ppResult)
      => ComCall(4, this.p, IDxcBlob, pSource, "Str", pSourceName?, PWSTR.Ptr, pArguments?, UInt32, pArguments?.Length ?? 0, DxcDefine.Ptr, pDefines, UInt32, pDefines.Length, IDxcIncludeHandler, pIncludeHandler?, IDxcOperationResult.Ptr, ppResult)
    Disassemble(pSource, ppDisassembly)
      => ComCall(5, this.p, IDxcBlob, pSource, IDxcBlobEncoding.Ptr, ppDisassembly)
}
struct IDxcCompiler2 extends IDxcCompiler {
    static IID := "{A005A9D9-B8BB-4594-B5C9-0E633BEC4D37}"
    CompileWithDebug(pSource, pSourceName?, pEntryPoint?, pTargetProfile, pArguments?, pDefines, pIncludeHandler?, ppResult, ppDebugBlobName?, ppDebugBlob?)
      => ComCall(6, this.p, IDxcBlob, pSource, "Str", pSourceName?, "Str", pEntryPoint?, "Str", pTargetProfile, PWSTR.Ptr, pArguments?, UInt32, pArguments?.Length ?? 0, DxcDefine.Ptr, pDefines, UInt32, pDefines.Length, IDxcIncludeHandler, pIncludeHandler?, IDxcOperationResult.Ptr, ppResult, PWSTR.Ptr, ppDebugBlobName?, IDxcBlob.Ptr, ppDebugBlob?)
}
struct IDxcLinker extends IUnknown {
    static IID := "{F1B5BE2A-62DD-4327-A1C2-42AC1E1E78E6}"
    RegisterLibrary(pLibName?, pLib)
      => ComCall(3, this.p, "Str", pLibName?, IDxcBlob, pLib)
    Link(pEntryName?, pTargetProfile, pLibNames, pArguments?, ppResult)
      => ComCall(4, this.p, "Str", pEntryName?, "Str", pTargetProfile, PWSTR.Ptr, pLibNames, UInt32, pLibNames.Length, PWSTR.Ptr, pArguments?, UInt32, pArguments?.Length ?? 0, IDxcOperationResult.Ptr, ppResult)
}
struct IDxcUtils extends IUnknown {
    static IID := "{4605C4CB-2019-492A-ADA4-65F20BB7D67F}"
    CreateBlobFromBlob(pBlob, offset, length, ppResult)
      => ComCall(3, this.p, IDxcBlob, pBlob, UInt32, offset, UInt32, length, IDxcBlob.Ptr, ppResult)
    CreateBlobFromPinned(pData, codePage, ppBlobEncoding)
      => ComCall(4, this.p, Struct.Ptr, pData, UInt32, pData.Size, DXC_CP, codePage, IDxcBlobEncoding.Ptr, ppBlobEncoding)
    MoveToBlob(pData, pIMalloc, codePage, ppBlobEncoding)
      => ComCall(5, this.p, Struct.Ptr, pData, IMalloc, pIMalloc, UInt32, pData.Size, DXC_CP, codePage, IDxcBlobEncoding.Ptr, ppBlobEncoding)
    CreateBlob(pData, codePage, ppBlobEncoding)
      => ComCall(6, this.p, Struct.Ptr, pData, UInt32, pData.Size, DXC_CP, codePage, IDxcBlobEncoding.Ptr, ppBlobEncoding)
    LoadFile(pFileName, pCodePage?, ppBlobEncoding)
      => ComCall(7, this.p, "Str", pFileName, DXC_CP.Ptr, pCodePage?, IDxcBlobEncoding.Ptr, ppBlobEncoding)
    CreateReadOnlyStreamFromBlob(pBlob, ppStream)
      => ComCall(8, this.p, IDxcBlob, pBlob, IStream.Ptr, ppStream)
    CreateDefaultIncludeHandler(ppResult)
      => ComCall(9, this.p, IDxcIncludeHandler.Ptr, ppResult)
    GetBlobAsUtf8(pBlob, ppBlobEncoding)
      => ComCall(10, this.p, IDxcBlob, pBlob, IDxcBlobUtf8.Ptr, ppBlobEncoding)
    GetBlobAsWide(pBlob, ppBlobEncoding)
      => ComCall(11, this.p, IDxcBlob, pBlob, IDxcBlobUtf16.Ptr, ppBlobEncoding)
    GetDxilContainerPart(pShader, DxcPart, ppPartData, pPartSizeInBytes)
      => ComCall(12, this.p, DxcBuffer.Ptr, pShader, UInt32, DxcPart, Struct.Ptr.Ptr, ppPartData, UInt32.Ptr, pPartSizeInBytes)
    CreateReflection(pData, iid, ppvReflection)
      => ComCall(13, this.p, DxcBuffer.Ptr, pData, GUID.Ptr, iid, Struct.Ptr.Ptr, ppvReflection)
    BuildArguments(pSourceName?, pEntryPoint?, pTargetProfile, pArguments?, pDefines, ppArgs)
      => ComCall(14, this.p, "Str", pSourceName?, "Str", pEntryPoint?, "Str", pTargetProfile, PWSTR.Ptr, pArguments?, UInt32, pArguments?.Length ?? 0, DxcDefine.Ptr, pDefines, UInt32, pDefines.Length, IDxcCompilerArgs.Ptr, ppArgs)
    GetPDBContents(pPDBBlob, ppHash, ppContainer)
      => ComCall(15, this.p, IDxcBlob, pPDBBlob, IDxcBlob.Ptr, ppHash, IDxcBlob.Ptr, ppContainer)
}
struct DXC_OUT_KIND extends Int32 {
    static DXC_OUT_NONE := 0
    static DXC_OUT_OBJECT := 1
    static DXC_OUT_ERRORS := 2
    static DXC_OUT_PDB := 3
    static DXC_OUT_SHADER_HASH := 4
    static DXC_OUT_DISASSEMBLY := 5
    static DXC_OUT_HLSL := 6
    static DXC_OUT_TEXT := 7
    static DXC_OUT_REFLECTION := 8
    static DXC_OUT_ROOT_SIGNATURE := 9
    static DXC_OUT_EXTRA_OUTPUTS := 10
    static DXC_OUT_REMARKS := 11
    static DXC_OUT_TIME_REPORT := 12
    static DXC_OUT_TIME_TRACE := 13
    static DXC_OUT_LAST := 13
    static DXC_OUT_NUM_ENUMS := 14
}
struct IDxcResult extends IDxcOperationResult {
    static IID := "{58346CDA-DDE7-4497-9461-6F87AF5E0659}"
    HasOutput(dxcOutKind)
      => ComCall(6, this.p, DXC_OUT_KIND, dxcOutKind, BOOL)
    GetOutput(dxcOutKind, iid, ppvObject?, ppOutputName?)
      => ComCall(7, this.p, DXC_OUT_KIND, dxcOutKind, GUID.Ptr, iid, Struct.Ptr.Ptr, ppvObject?, IDxcBlobUtf16.Ptr, ppOutputName?)
    GetNumOutputs()
      => ComCall(8, this.p, UInt32)
    GetOutputByIndex(Index)
      => ComCall(9, this.p, UInt32, Index, DXC_OUT_KIND)
    PrimaryOutput()
      => ComCall(10, this.p, DXC_OUT_KIND)
}
struct IDxcExtraOutputs extends IUnknown {
    static IID := "{319B37A2-A5C2-494A-A5DE-4801B2FAF989}"
    GetOutputCount()
      => ComCall(3, this.p, UInt32)
    GetOutput(uIndex, iid, ppvObject?, ppOutputType?, ppOutputName?)
      => ComCall(4, this.p, UInt32, uIndex, GUID.Ptr, iid, Struct.Ptr.Ptr, ppvObject?, IDxcBlobUtf16.Ptr, ppOutputType?, IDxcBlobUtf16.Ptr, ppOutputName?)
}
struct IDxcCompiler3 extends IUnknown {
    static IID := "{228B4687-5A6A-4730-900C-9702B2203F54}"
    Compile(pSource, pArguments?, pIncludeHandler?, riid, ppResult)
      => ComCall(3, this.p, DxcBuffer.Ptr, pSource, PWSTR.Ptr, pArguments?, UInt32, pArguments?.Length ?? 0, IDxcIncludeHandler, pIncludeHandler?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppResult)
    Disassemble(pObject, riid, ppResult)
      => ComCall(4, this.p, DxcBuffer.Ptr, pObject, GUID.Ptr, riid, Struct.Ptr.Ptr, ppResult)
}
struct IDxcValidator extends IUnknown {
    static IID := "{A6E82BD2-1FD7-4826-9811-2857E797F49A}"
    Validate(pShader, Flags, ppResult)
      => ComCall(3, this.p, IDxcBlob, pShader, UInt32, Flags, IDxcOperationResult.Ptr, ppResult)
}
struct IDxcValidator2 extends IDxcValidator {
    static IID := "{458E1FD1-B1B2-4750-A6E1-9C10F03BED92}"
    ValidateWithDebug(pShader, Flags, pOptDebugBitcode?, ppResult)
      => ComCall(4, this.p, IDxcBlob, pShader, UInt32, Flags, DxcBuffer.Ptr, pOptDebugBitcode?, IDxcOperationResult.Ptr, ppResult)
}
struct IDxcContainerBuilder extends IUnknown {
    static IID := "{334B1F50-2292-4B35-99A1-25588D8C17FE}"
    Load(pDxilContainerHeader)
      => ComCall(3, this.p, IDxcBlob, pDxilContainerHeader)
    AddPart(fourCC, pSource)
      => ComCall(4, this.p, UInt32, fourCC, IDxcBlob, pSource)
    RemovePart(fourCC)
      => ComCall(5, this.p, UInt32, fourCC)
    SerializeContainer(ppResult)
      => ComCall(6, this.p, IDxcOperationResult.Ptr, ppResult)
}
struct IDxcAssembler extends IUnknown {
    static IID := "{091F7A26-1C1F-4948-904B-E6E3A8A771D5}"
    AssembleToContainer(pShader, ppResult)
      => ComCall(3, this.p, IDxcBlob, pShader, IDxcOperationResult.Ptr, ppResult)
}
struct IDxcContainerReflection extends IUnknown {
    static IID := "{D2C21B26-8350-4BDC-976A-331CE6F4C54C}"
    Load(pContainer)
      => ComCall(3, this.p, IDxcBlob, pContainer)
    GetPartCount(pResult)
      => ComCall(4, this.p, UInt32.Ptr, pResult)
    GetPartKind(idx, pResult)
      => ComCall(5, this.p, UInt32, idx, UInt32.Ptr, pResult)
    GetPartContent(idx, ppResult)
      => ComCall(6, this.p, UInt32, idx, IDxcBlob.Ptr, ppResult)
    FindFirstPartKind(kind, pResult)
      => ComCall(7, this.p, UInt32, kind, UInt32.Ptr, pResult)
    GetPartReflection(idx, iid, ppvObject)
      => ComCall(8, this.p, UInt32, idx, GUID.Ptr, iid, Struct.Ptr.Ptr, ppvObject)
}
struct IDxcOptimizerPass extends IUnknown {
    static IID := "{AE2CD79F-CC22-453F-9B6B-B124E7A5204C}"
    GetOptionName(ppResult)
      => ComCall(3, this.p, PWSTR.Ptr, ppResult)
    GetDescription(ppResult)
      => ComCall(4, this.p, PWSTR.Ptr, ppResult)
    GetOptionArgCount(pCount)
      => ComCall(5, this.p, UInt32.Ptr, pCount)
    GetOptionArgName(argIndex, ppResult)
      => ComCall(6, this.p, UInt32, argIndex, PWSTR.Ptr, ppResult)
    GetOptionArgDescription(argIndex, ppResult)
      => ComCall(7, this.p, UInt32, argIndex, PWSTR.Ptr, ppResult)
}
struct IDxcOptimizer extends IUnknown {
    static IID := "{25740E2E-9CBA-401B-9119-4FB42F39F270}"
    GetAvailablePassCount(pCount)
      => ComCall(3, this.p, UInt32.Ptr, pCount)
    GetAvailablePass(index, ppResult)
      => ComCall(4, this.p, UInt32, index, IDxcOptimizerPass.Ptr, ppResult)
    RunOptimizer(pBlob, ppOptions, pOutputModule, ppOutputText?)
      => ComCall(5, this.p, IDxcBlob, pBlob, PWSTR.Ptr, ppOptions, UInt32, ppOptions.Length, IDxcBlob.Ptr, pOutputModule, IDxcBlobEncoding.Ptr, ppOutputText?)
}
struct IDxcVersionInfo extends IUnknown {
    static IID := "{B04F5B50-2059-4F12-A8FF-A1E0CDE1CC7E}"
    GetVersion(pMajor, pMinor)
      => ComCall(3, this.p, UInt32.Ptr, pMajor, UInt32.Ptr, pMinor)
    GetFlags(pFlags)
      => ComCall(4, this.p, UInt32.Ptr, pFlags)
}
struct IDxcVersionInfo2 extends IDxcVersionInfo {
    static IID := "{FB6904C4-42F0-4B62-9C46-983AF7DA7C83}"
    GetCommitInfo(pCommitCount, pCommitHash)
      => ComCall(5, this.p, UInt32.Ptr, pCommitCount, Int8.Ptr.Ptr, pCommitHash)
}
struct IDxcVersionInfo3 extends IUnknown {
    static IID := "{5E13E843-9D25-473C-9AD2-03B2D0B44B1E}"
    GetCustomVersionString(pVersionString)
      => ComCall(3, this.p, Int8.Ptr.Ptr, pVersionString)
}
struct DxcArgPair {
    pName : PWSTR
    pValue : PWSTR
}
struct IDxcPdbUtils extends IUnknown {
    static IID := "{E6C9647E-9D6A-4C3B-B94C-524B5A6C343D}"
    Load(pPdbOrDxil)
      => ComCall(3, this.p, IDxcBlob, pPdbOrDxil)
    GetSourceCount(pCount)
      => ComCall(4, this.p, UInt32.Ptr, pCount)
    GetSource(uIndex, ppResult)
      => ComCall(5, this.p, UInt32, uIndex, IDxcBlobEncoding.Ptr, ppResult)
    GetSourceName(uIndex, pResult)
      => ComCall(6, this.p, UInt32, uIndex, BSTR.Ptr, pResult)
    GetFlagCount(pCount)
      => ComCall(7, this.p, UInt32.Ptr, pCount)
    GetFlag(uIndex, pResult)
      => ComCall(8, this.p, UInt32, uIndex, BSTR.Ptr, pResult)
    GetArgCount(pCount)
      => ComCall(9, this.p, UInt32.Ptr, pCount)
    GetArg(uIndex, pResult)
      => ComCall(10, this.p, UInt32, uIndex, BSTR.Ptr, pResult)
    GetArgPairCount(pCount)
      => ComCall(11, this.p, UInt32.Ptr, pCount)
    GetArgPair(uIndex, pName, pValue)
      => ComCall(12, this.p, UInt32, uIndex, BSTR.Ptr, pName, BSTR.Ptr, pValue)
    GetDefineCount(pCount)
      => ComCall(13, this.p, UInt32.Ptr, pCount)
    GetDefine(uIndex, pResult)
      => ComCall(14, this.p, UInt32, uIndex, BSTR.Ptr, pResult)
    GetTargetProfile(pResult)
      => ComCall(15, this.p, BSTR.Ptr, pResult)
    GetEntryPoint(pResult)
      => ComCall(16, this.p, BSTR.Ptr, pResult)
    GetMainFileName(pResult)
      => ComCall(17, this.p, BSTR.Ptr, pResult)
    GetHash(ppResult)
      => ComCall(18, this.p, IDxcBlob.Ptr, ppResult)
    GetName(pResult)
      => ComCall(19, this.p, BSTR.Ptr, pResult)
    IsFullPDB()
      => ComCall(20, this.p, BOOL)
    GetFullPDB(ppFullPDB)
      => ComCall(21, this.p, IDxcBlob.Ptr, ppFullPDB)
    GetVersionInfo(ppVersionInfo)
      => ComCall(22, this.p, IDxcVersionInfo.Ptr, ppVersionInfo)
    SetCompiler(pCompiler)
      => ComCall(23, this.p, IDxcCompiler3, pCompiler)
    CompileForFullPDB(ppResult)
      => ComCall(24, this.p, IDxcResult.Ptr, ppResult)
    OverrideArgs(pArgPairs, uNumArgPairs)
      => ComCall(25, this.p, DxcArgPair.Ptr, pArgPairs, UInt32, uNumArgPairs)
    OverrideRootSignature(pRootSignature)
      => ComCall(26, this.p, "Str", pRootSignature)
}
struct IDxcPdbUtils2 extends IUnknown {
    static IID := "{4315D938-F369-4F93-95A2-252017CC3807}"
    Load(pPdbOrDxil)
      => ComCall(3, this.p, IDxcBlob, pPdbOrDxil)
    GetSourceCount(pCount)
      => ComCall(4, this.p, UInt32.Ptr, pCount)
    GetSource(uIndex, ppResult)
      => ComCall(5, this.p, UInt32, uIndex, IDxcBlobEncoding.Ptr, ppResult)
    GetSourceName(uIndex, ppResult)
      => ComCall(6, this.p, UInt32, uIndex, IDxcBlobUtf16.Ptr, ppResult)
    GetLibraryPDBCount(pCount)
      => ComCall(7, this.p, UInt32.Ptr, pCount)
    GetLibraryPDB(uIndex, ppOutPdbUtils, ppLibraryName?)
      => ComCall(8, this.p, UInt32, uIndex, IDxcPdbUtils2.Ptr, ppOutPdbUtils, IDxcBlobUtf16.Ptr, ppLibraryName?)
    GetFlagCount(pCount)
      => ComCall(9, this.p, UInt32.Ptr, pCount)
    GetFlag(uIndex, ppResult)
      => ComCall(10, this.p, UInt32, uIndex, IDxcBlobUtf16.Ptr, ppResult)
    GetArgCount(pCount)
      => ComCall(11, this.p, UInt32.Ptr, pCount)
    GetArg(uIndex, ppResult)
      => ComCall(12, this.p, UInt32, uIndex, IDxcBlobUtf16.Ptr, ppResult)
    GetArgPairCount(pCount)
      => ComCall(13, this.p, UInt32.Ptr, pCount)
    GetArgPair(uIndex, ppName, ppValue)
      => ComCall(14, this.p, UInt32, uIndex, IDxcBlobUtf16.Ptr, ppName, IDxcBlobUtf16.Ptr, ppValue)
    GetDefineCount(pCount)
      => ComCall(15, this.p, UInt32.Ptr, pCount)
    GetDefine(uIndex, ppResult)
      => ComCall(16, this.p, UInt32, uIndex, IDxcBlobUtf16.Ptr, ppResult)
    GetTargetProfile(ppResult)
      => ComCall(17, this.p, IDxcBlobUtf16.Ptr, ppResult)
    GetEntryPoint(ppResult)
      => ComCall(18, this.p, IDxcBlobUtf16.Ptr, ppResult)
    GetMainFileName(ppResult)
      => ComCall(19, this.p, IDxcBlobUtf16.Ptr, ppResult)
    GetHash(ppResult)
      => ComCall(20, this.p, IDxcBlob.Ptr, ppResult)
    GetName(ppResult)
      => ComCall(21, this.p, IDxcBlobUtf16.Ptr, ppResult)
    GetVersionInfo(ppVersionInfo)
      => ComCall(22, this.p, IDxcVersionInfo.Ptr, ppVersionInfo)
    GetCustomToolchainID(pID)
      => ComCall(23, this.p, UInt32.Ptr, pID)
    GetCustomToolchainData(ppBlob)
      => ComCall(24, this.p, IDxcBlob.Ptr, ppBlob)
    GetWholeDxil(ppResult)
      => ComCall(25, this.p, IDxcBlob.Ptr, ppResult)
    IsFullPDB()
      => ComCall(26, this.p, BOOL)
    IsPDBRef()
      => ComCall(27, this.p, BOOL)
}
