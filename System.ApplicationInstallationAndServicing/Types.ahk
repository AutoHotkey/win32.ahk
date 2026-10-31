#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HANDLE, HMODULE, HRESULT, PSTR, PWSTR, VARIANT_BOOL}
#Import "..\Security.Cryptography\Types.ahk" {ALG_ID}
#Import "..\System.Com\Types.ahk" {IDispatch, IStream, IUnknown, SAFEARRAY}
#Import "..\System.WindowsProgramming\Types.ahk" {ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA}

struct MSIASSEMBLYINFO extends UInt32 {
    static MSIASSEMBLYINFO_NETASSEMBLY := 0
    static MSIASSEMBLYINFO_WIN32ASSEMBLY := 1
}
struct IASSEMBLYCACHE_UNINSTALL_DISPOSITION extends UInt32 {
    static IASSEMBLYCACHE_UNINSTALL_DISPOSITION_UNINSTALLED := 1
    static IASSEMBLYCACHE_UNINSTALL_DISPOSITION_STILL_IN_USE := 2
    static IASSEMBLYCACHE_UNINSTALL_DISPOSITION_ALREADY_UNINSTALLED := 3
    static IASSEMBLYCACHE_UNINSTALL_DISPOSITION_DELETE_PENDING := 4
}
struct QUERYASMINFO_FLAGS extends UInt32 {
    static QUERYASMINFO_FLAG_VALIDATE := 1
}
struct MSIHANDLE {
    Value : UInt32
}
struct RESULTTYPES extends Int32 {
    static ieUnknown := 0
    static ieError := 1
    static ieWarning := 2
    static ieInfo := 3
}
struct STATUSTYPES extends Int32 {
    static ieStatusGetCUB := 0
    static ieStatusICECount := 1
    static ieStatusMerge := 2
    static ieStatusSummaryInfo := 3
    static ieStatusCreateEngine := 4
    static ieStatusStarting := 5
    static ieStatusRunICE := 6
    static ieStatusShutdown := 7
    static ieStatusSuccess := 8
    static ieStatusFail := 9
    static ieStatusCancel := 10
}
struct LPDISPLAYVAL extends FunctionPointer {
    static Types := [Struct.Ptr, RESULTTYPES, PWSTR, PWSTR, PWSTR, BOOL]
}
struct LPEVALCOMCALLBACK extends FunctionPointer {
    static Types := [STATUSTYPES, PWSTR, Struct.Ptr, BOOL]
}
struct IValidate extends IUnknown {
    static IID := "{E482E5C6-E31E-4143-A2E6-DBC3D8E4B8D3}"
    OpenDatabase(szDatabase)
      => ComCall(3, this.p, "Str", szDatabase)
    OpenCUB(szCUBFile)
      => ComCall(4, this.p, "Str", szCUBFile)
    CloseDatabase()
      => ComCall(5, this.p)
    CloseCUB()
      => ComCall(6, this.p)
    SetDisplay(pDisplayFunction, pContext)
      => ComCall(7, this.p, LPDISPLAYVAL, pDisplayFunction, Struct.Ptr, pContext)
    SetStatus(pStatusFunction, pContext)
      => ComCall(8, this.p, LPEVALCOMCALLBACK, pStatusFunction, Struct.Ptr, pContext)
    Validate(wzICEs)
      => ComCall(9, this.p, "Str", wzICEs)
}
struct msmErrorType extends Int32 {
    static msmErrorLanguageUnsupported := 1
    static msmErrorLanguageFailed := 2
    static msmErrorExclusion := 3
    static msmErrorTableMerge := 4
    static msmErrorResequenceMerge := 5
    static msmErrorFileCreate := 6
    static msmErrorDirCreate := 7
    static msmErrorFeatureRequired := 8
}
struct IEnumMsmString extends IUnknown {
    static IID := "{0ADDA826-2C26-11D2-AD65-00A0C9AF11A6}"
    Next(cFetch, rgbstrStrings, pcFetched)
      => ComCall(3, this.p, UInt32, cFetch, BSTR.Ptr, rgbstrStrings, UInt32.Ptr, pcFetched)
    Skip(cSkip)
      => ComCall(4, this.p, UInt32, cSkip)
    Reset()
      => ComCall(5, this.p)
    Clone(pemsmStrings)
      => ComCall(6, this.p, IEnumMsmString.Ptr, pemsmStrings)
}
struct IMsmStrings extends IDispatch {
    static IID := "{0ADDA827-2C26-11D2-AD65-00A0C9AF11A6}"
    get_Item(Item, Return1)
      => ComCall(7, this.p, Int32, Item, BSTR.Ptr, Return1)
    get_Count(Count)
      => ComCall(8, this.p, Int32.Ptr, Count)
    get__NewEnum(NewEnum)
      => ComCall(9, this.p, IUnknown.Ptr, NewEnum)
}
struct IMsmError extends IDispatch {
    static IID := "{0ADDA828-2C26-11D2-AD65-00A0C9AF11A6}"
    get_Type(ErrorType)
      => ComCall(7, this.p, msmErrorType.Ptr, ErrorType)
    get_Path(ErrorPath)
      => ComCall(8, this.p, BSTR.Ptr, ErrorPath)
    get_Language(ErrorLanguage)
      => ComCall(9, this.p, Int16.Ptr, ErrorLanguage)
    get_DatabaseTable(ErrorTable)
      => ComCall(10, this.p, BSTR.Ptr, ErrorTable)
    get_DatabaseKeys(ErrorKeys)
      => ComCall(11, this.p, IMsmStrings.Ptr, ErrorKeys)
    get_ModuleTable(ErrorTable)
      => ComCall(12, this.p, BSTR.Ptr, ErrorTable)
    get_ModuleKeys(ErrorKeys)
      => ComCall(13, this.p, IMsmStrings.Ptr, ErrorKeys)
}
struct IEnumMsmError extends IUnknown {
    static IID := "{0ADDA829-2C26-11D2-AD65-00A0C9AF11A6}"
    Next(cFetch, rgmsmErrors, pcFetched)
      => ComCall(3, this.p, UInt32, cFetch, IMsmError.Ptr, rgmsmErrors, UInt32.Ptr, pcFetched)
    Skip(cSkip)
      => ComCall(4, this.p, UInt32, cSkip)
    Reset()
      => ComCall(5, this.p)
    Clone(pemsmErrors)
      => ComCall(6, this.p, IEnumMsmError.Ptr, pemsmErrors)
}
struct IMsmErrors extends IDispatch {
    static IID := "{0ADDA82A-2C26-11D2-AD65-00A0C9AF11A6}"
    get_Item(Item, Return1)
      => ComCall(7, this.p, Int32, Item, IMsmError.Ptr, Return1)
    get_Count(Count)
      => ComCall(8, this.p, Int32.Ptr, Count)
    get__NewEnum(NewEnum)
      => ComCall(9, this.p, IUnknown.Ptr, NewEnum)
}
struct IMsmDependency extends IDispatch {
    static IID := "{0ADDA82B-2C26-11D2-AD65-00A0C9AF11A6}"
    get_Module(Module)
      => ComCall(7, this.p, BSTR.Ptr, Module)
    get_Language(Language)
      => ComCall(8, this.p, Int16.Ptr, Language)
    get_Version(Version)
      => ComCall(9, this.p, BSTR.Ptr, Version)
}
struct IEnumMsmDependency extends IUnknown {
    static IID := "{0ADDA82C-2C26-11D2-AD65-00A0C9AF11A6}"
    Next(cFetch, rgmsmDependencies, pcFetched)
      => ComCall(3, this.p, UInt32, cFetch, IMsmDependency.Ptr, rgmsmDependencies, UInt32.Ptr, pcFetched)
    Skip(cSkip)
      => ComCall(4, this.p, UInt32, cSkip)
    Reset()
      => ComCall(5, this.p)
    Clone(pemsmDependencies)
      => ComCall(6, this.p, IEnumMsmDependency.Ptr, pemsmDependencies)
}
struct IMsmDependencies extends IDispatch {
    static IID := "{0ADDA82D-2C26-11D2-AD65-00A0C9AF11A6}"
    get_Item(Item, Return1)
      => ComCall(7, this.p, Int32, Item, IMsmDependency.Ptr, Return1)
    get_Count(Count)
      => ComCall(8, this.p, Int32.Ptr, Count)
    get__NewEnum(NewEnum)
      => ComCall(9, this.p, IUnknown.Ptr, NewEnum)
}
struct IMsmMerge extends IDispatch {
    static IID := "{0ADDA82E-2C26-11D2-AD65-00A0C9AF11A6}"
    OpenDatabase(Path)
      => ComCall(7, this.p, BSTR, Path)
    OpenModule(Path, Language)
      => ComCall(8, this.p, BSTR, Path, Int16, Language)
    CloseDatabase(Commit)
      => ComCall(9, this.p, VARIANT_BOOL, Commit)
    CloseModule()
      => ComCall(10, this.p)
    OpenLog(Path)
      => ComCall(11, this.p, BSTR, Path)
    CloseLog()
      => ComCall(12, this.p)
    Log(Message)
      => ComCall(13, this.p, BSTR, Message)
    get_Errors(Errors)
      => ComCall(14, this.p, IMsmErrors.Ptr, Errors)
    get_Dependencies(Dependencies)
      => ComCall(15, this.p, IMsmDependencies.Ptr, Dependencies)
    Merge(Feature, RedirectDir)
      => ComCall(16, this.p, BSTR, Feature, BSTR, RedirectDir)
    Connect(Feature)
      => ComCall(17, this.p, BSTR, Feature)
    ExtractCAB(FileName)
      => ComCall(18, this.p, BSTR, FileName)
    ExtractFiles(Path)
      => ComCall(19, this.p, BSTR, Path)
}
struct IMsmGetFiles extends IDispatch {
    static IID := "{7041AE26-2D78-11D2-888A-00A0C981B015}"
    get_ModuleFiles(Files)
      => ComCall(7, this.p, IMsmStrings.Ptr, Files)
}
struct PMSIHANDLE {
    m_h : MSIHANDLE
}
struct INSTALLMESSAGE extends Int32 {
    static INSTALLMESSAGE_FATALEXIT := 0
    static INSTALLMESSAGE_ERROR := 16777216
    static INSTALLMESSAGE_WARNING := 33554432
    static INSTALLMESSAGE_USER := 50331648
    static INSTALLMESSAGE_INFO := 67108864
    static INSTALLMESSAGE_FILESINUSE := 83886080
    static INSTALLMESSAGE_RESOLVESOURCE := 100663296
    static INSTALLMESSAGE_OUTOFDISKSPACE := 117440512
    static INSTALLMESSAGE_ACTIONSTART := 134217728
    static INSTALLMESSAGE_ACTIONDATA := 150994944
    static INSTALLMESSAGE_PROGRESS := 167772160
    static INSTALLMESSAGE_COMMONDATA := 184549376
    static INSTALLMESSAGE_INITIALIZE := 201326592
    static INSTALLMESSAGE_TERMINATE := 218103808
    static INSTALLMESSAGE_SHOWDIALOG := 234881024
    static INSTALLMESSAGE_PERFORMANCE := 251658240
    static INSTALLMESSAGE_RMFILESINUSE := 419430400
    static INSTALLMESSAGE_INSTALLSTART := 436207616
    static INSTALLMESSAGE_INSTALLEND := 452984832
}
struct INSTALLUI_HANDLERA extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PSTR, Int32]
}
struct INSTALLUI_HANDLERW extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PWSTR, Int32]
}
struct PINSTALLUI_HANDLER_RECORD extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, MSIHANDLE, Int32]
}
struct INSTALLUILEVEL extends Int32 {
    static INSTALLUILEVEL_NOCHANGE := 0
    static INSTALLUILEVEL_DEFAULT := 1
    static INSTALLUILEVEL_NONE := 2
    static INSTALLUILEVEL_BASIC := 3
    static INSTALLUILEVEL_REDUCED := 4
    static INSTALLUILEVEL_FULL := 5
    static INSTALLUILEVEL_ENDDIALOG := 128
    static INSTALLUILEVEL_PROGRESSONLY := 64
    static INSTALLUILEVEL_HIDECANCEL := 32
    static INSTALLUILEVEL_SOURCERESONLY := 256
    static INSTALLUILEVEL_UACONLY := 512
}
struct INSTALLSTATE extends Int32 {
    static INSTALLSTATE_NOTUSED := -7
    static INSTALLSTATE_BADCONFIG := -6
    static INSTALLSTATE_INCOMPLETE := -5
    static INSTALLSTATE_SOURCEABSENT := -4
    static INSTALLSTATE_MOREDATA := -3
    static INSTALLSTATE_INVALIDARG := -2
    static INSTALLSTATE_UNKNOWN := -1
    static INSTALLSTATE_BROKEN := 0
    static INSTALLSTATE_ADVERTISED := 1
    static INSTALLSTATE_REMOVED := 1
    static INSTALLSTATE_ABSENT := 2
    static INSTALLSTATE_LOCAL := 3
    static INSTALLSTATE_SOURCE := 4
    static INSTALLSTATE_DEFAULT := 5
}
struct USERINFOSTATE extends Int32 {
    static USERINFOSTATE_MOREDATA := -3
    static USERINFOSTATE_INVALIDARG := -2
    static USERINFOSTATE_UNKNOWN := -1
    static USERINFOSTATE_ABSENT := 0
    static USERINFOSTATE_PRESENT := 1
}
struct INSTALLLEVEL extends Int32 {
    static INSTALLLEVEL_DEFAULT := 0
    static INSTALLLEVEL_MINIMUM := 1
    static INSTALLLEVEL_MAXIMUM := 65535
}
struct REINSTALLMODE extends Int32 {
    static REINSTALLMODE_REPAIR := 1
    static REINSTALLMODE_FILEMISSING := 2
    static REINSTALLMODE_FILEOLDERVERSION := 4
    static REINSTALLMODE_FILEEQUALVERSION := 8
    static REINSTALLMODE_FILEEXACT := 16
    static REINSTALLMODE_FILEVERIFY := 32
    static REINSTALLMODE_FILEREPLACE := 64
    static REINSTALLMODE_MACHINEDATA := 128
    static REINSTALLMODE_USERDATA := 256
    static REINSTALLMODE_SHORTCUT := 512
    static REINSTALLMODE_PACKAGE := 1024
}
struct INSTALLLOGMODE extends Int32 {
    static INSTALLLOGMODE_FATALEXIT := 1
    static INSTALLLOGMODE_ERROR := 2
    static INSTALLLOGMODE_WARNING := 4
    static INSTALLLOGMODE_USER := 8
    static INSTALLLOGMODE_INFO := 16
    static INSTALLLOGMODE_RESOLVESOURCE := 64
    static INSTALLLOGMODE_OUTOFDISKSPACE := 128
    static INSTALLLOGMODE_ACTIONSTART := 256
    static INSTALLLOGMODE_ACTIONDATA := 512
    static INSTALLLOGMODE_COMMONDATA := 2048
    static INSTALLLOGMODE_PROPERTYDUMP := 1024
    static INSTALLLOGMODE_VERBOSE := 4096
    static INSTALLLOGMODE_EXTRADEBUG := 8192
    static INSTALLLOGMODE_LOGONLYONERROR := 16384
    static INSTALLLOGMODE_LOGPERFORMANCE := 32768
    static INSTALLLOGMODE_PROGRESS := 1024
    static INSTALLLOGMODE_INITIALIZE := 4096
    static INSTALLLOGMODE_TERMINATE := 8192
    static INSTALLLOGMODE_SHOWDIALOG := 16384
    static INSTALLLOGMODE_FILESINUSE := 32
    static INSTALLLOGMODE_RMFILESINUSE := 33554432
    static INSTALLLOGMODE_INSTALLSTART := 67108864
    static INSTALLLOGMODE_INSTALLEND := 134217728
}
struct INSTALLLOGATTRIBUTES extends Int32 {
    static INSTALLLOGATTRIBUTES_APPEND := 1
    static INSTALLLOGATTRIBUTES_FLUSHEACHLINE := 2
}
struct INSTALLFEATUREATTRIBUTE extends Int32 {
    static INSTALLFEATUREATTRIBUTE_FAVORLOCAL := 1
    static INSTALLFEATUREATTRIBUTE_FAVORSOURCE := 2
    static INSTALLFEATUREATTRIBUTE_FOLLOWPARENT := 4
    static INSTALLFEATUREATTRIBUTE_FAVORADVERTISE := 8
    static INSTALLFEATUREATTRIBUTE_DISALLOWADVERTISE := 16
    static INSTALLFEATUREATTRIBUTE_NOUNSUPPORTEDADVERTISE := 32
}
struct INSTALLMODE extends Int32 {
    static INSTALLMODE_NODETECTION_ANY := -4
    static INSTALLMODE_NOSOURCERESOLUTION := -3
    static INSTALLMODE_NODETECTION := -2
    static INSTALLMODE_EXISTING := -1
    static INSTALLMODE_DEFAULT := 0
}
struct MSIPATCHSTATE extends Int32 {
    static MSIPATCHSTATE_INVALID := 0
    static MSIPATCHSTATE_APPLIED := 1
    static MSIPATCHSTATE_SUPERSEDED := 2
    static MSIPATCHSTATE_OBSOLETED := 4
    static MSIPATCHSTATE_REGISTERED := 8
    static MSIPATCHSTATE_ALL := 15
}
struct MSIINSTALLCONTEXT extends Int32 {
    static MSIINSTALLCONTEXT_FIRSTVISIBLE := 0
    static MSIINSTALLCONTEXT_NONE := 0
    static MSIINSTALLCONTEXT_USERMANAGED := 1
    static MSIINSTALLCONTEXT_USERUNMANAGED := 2
    static MSIINSTALLCONTEXT_MACHINE := 4
    static MSIINSTALLCONTEXT_ALL := 7
    static MSIINSTALLCONTEXT_ALLUSERMANAGED := 8
}
struct MSIPATCHDATATYPE extends Int32 {
    static MSIPATCH_DATATYPE_PATCHFILE := 0
    static MSIPATCH_DATATYPE_XMLPATH := 1
    static MSIPATCH_DATATYPE_XMLBLOB := 2
}
struct MSIPATCHSEQUENCEINFOA {
    szPatchData : PSTR
    ePatchDataType : MSIPATCHDATATYPE
    dwOrder : UInt32
    uStatus : UInt32
}
struct MSIPATCHSEQUENCEINFOW {
    szPatchData : PWSTR
    ePatchDataType : MSIPATCHDATATYPE
    dwOrder : UInt32
    uStatus : UInt32
}
struct SCRIPTFLAGS extends Int32 {
    static SCRIPTFLAGS_CACHEINFO := 1
    static SCRIPTFLAGS_SHORTCUTS := 4
    static SCRIPTFLAGS_MACHINEASSIGN := 8
    static SCRIPTFLAGS_REGDATA_CNFGINFO := 32
    static SCRIPTFLAGS_VALIDATE_TRANSFORMS_LIST := 64
    static SCRIPTFLAGS_REGDATA_CLASSINFO := 128
    static SCRIPTFLAGS_REGDATA_EXTENSIONINFO := 256
    static SCRIPTFLAGS_REGDATA_APPINFO := 384
    static SCRIPTFLAGS_REGDATA := 416
}
struct ADVERTISEFLAGS extends Int32 {
    static ADVERTISEFLAGS_MACHINEASSIGN := 0
    static ADVERTISEFLAGS_USERASSIGN := 1
}
struct INSTALLTYPE extends Int32 {
    static INSTALLTYPE_DEFAULT := 0
    static INSTALLTYPE_NETWORK_IMAGE := 1
    static INSTALLTYPE_SINGLE_INSTANCE := 2
}
struct MSIFILEHASHINFO {
    dwFileHashInfoSize : UInt32
    dwData : UInt32[4]
}
struct MSIARCHITECTUREFLAGS extends Int32 {
    static MSIARCHITECTUREFLAGS_X86 := 1
    static MSIARCHITECTUREFLAGS_IA64 := 2
    static MSIARCHITECTUREFLAGS_AMD64 := 4
    static MSIARCHITECTUREFLAGS_ARM := 8
}
struct MSIOPENPACKAGEFLAGS extends Int32 {
    static MSIOPENPACKAGEFLAGS_IGNOREMACHINESTATE := 1
}
struct MSIADVERTISEOPTIONFLAGS extends Int32 {
    static MSIADVERTISEOPTIONFLAGS_INSTANCE := 1
}
struct MSISOURCETYPE extends Int32 {
    static MSISOURCETYPE_UNKNOWN := 0
    static MSISOURCETYPE_NETWORK := 1
    static MSISOURCETYPE_URL := 2
    static MSISOURCETYPE_MEDIA := 4
}
struct MSICODE extends Int32 {
    static MSICODE_PRODUCT := 0
    static MSICODE_PATCH := 1073741824
}
struct MSITRANSACTION extends Int32 {
    static MSITRANSACTION_CHAIN_EMBEDDEDUI := 1
    static MSITRANSACTION_JOIN_EXISTING_EMBEDDEDUI := 2
}
struct MSITRANSACTIONSTATE extends UInt32 {
    static MSITRANSACTIONSTATE_ROLLBACK := 0
    static MSITRANSACTIONSTATE_COMMIT := 1
}
struct MSIDBSTATE extends Int32 {
    static MSIDBSTATE_ERROR := -1
    static MSIDBSTATE_READ := 0
    static MSIDBSTATE_WRITE := 1
}
struct MSIMODIFY extends Int32 {
    static MSIMODIFY_SEEK := -1
    static MSIMODIFY_REFRESH := 0
    static MSIMODIFY_INSERT := 1
    static MSIMODIFY_UPDATE := 2
    static MSIMODIFY_ASSIGN := 3
    static MSIMODIFY_REPLACE := 4
    static MSIMODIFY_MERGE := 5
    static MSIMODIFY_DELETE := 6
    static MSIMODIFY_INSERT_TEMPORARY := 7
    static MSIMODIFY_VALIDATE := 8
    static MSIMODIFY_VALIDATE_NEW := 9
    static MSIMODIFY_VALIDATE_FIELD := 10
    static MSIMODIFY_VALIDATE_DELETE := 11
}
struct MSICOLINFO extends Int32 {
    static MSICOLINFO_NAMES := 0
    static MSICOLINFO_TYPES := 1
}
struct MSICONDITION extends Int32 {
    static MSICONDITION_FALSE := 0
    static MSICONDITION_TRUE := 1
    static MSICONDITION_NONE := 2
    static MSICONDITION_ERROR := 3
}
struct MSICOSTTREE extends Int32 {
    static MSICOSTTREE_SELFONLY := 0
    static MSICOSTTREE_CHILDREN := 1
    static MSICOSTTREE_PARENTS := 2
    static MSICOSTTREE_RESERVED := 3
}
struct MSIDBERROR extends Int32 {
    static MSIDBERROR_INVALIDARG := -3
    static MSIDBERROR_MOREDATA := -2
    static MSIDBERROR_FUNCTIONERROR := -1
    static MSIDBERROR_NOERROR := 0
    static MSIDBERROR_DUPLICATEKEY := 1
    static MSIDBERROR_REQUIRED := 2
    static MSIDBERROR_BADLINK := 3
    static MSIDBERROR_OVERFLOW := 4
    static MSIDBERROR_UNDERFLOW := 5
    static MSIDBERROR_NOTINSET := 6
    static MSIDBERROR_BADVERSION := 7
    static MSIDBERROR_BADCASE := 8
    static MSIDBERROR_BADGUID := 9
    static MSIDBERROR_BADWILDCARD := 10
    static MSIDBERROR_BADIDENTIFIER := 11
    static MSIDBERROR_BADLANGUAGE := 12
    static MSIDBERROR_BADFILENAME := 13
    static MSIDBERROR_BADPATH := 14
    static MSIDBERROR_BADCONDITION := 15
    static MSIDBERROR_BADFORMATTED := 16
    static MSIDBERROR_BADTEMPLATE := 17
    static MSIDBERROR_BADDEFAULTDIR := 18
    static MSIDBERROR_BADREGPATH := 19
    static MSIDBERROR_BADCUSTOMSOURCE := 20
    static MSIDBERROR_BADPROPERTY := 21
    static MSIDBERROR_MISSINGDATA := 22
    static MSIDBERROR_BADCATEGORY := 23
    static MSIDBERROR_BADKEYTABLE := 24
    static MSIDBERROR_BADMAXMINVALUES := 25
    static MSIDBERROR_BADCABINET := 26
    static MSIDBERROR_BADSHORTCUT := 27
    static MSIDBERROR_STRINGOVERFLOW := 28
    static MSIDBERROR_BADLOCALIZEATTRIB := 29
}
struct MSIRUNMODE extends Int32 {
    static MSIRUNMODE_ADMIN := 0
    static MSIRUNMODE_ADVERTISE := 1
    static MSIRUNMODE_MAINTENANCE := 2
    static MSIRUNMODE_ROLLBACKENABLED := 3
    static MSIRUNMODE_LOGENABLED := 4
    static MSIRUNMODE_OPERATIONS := 5
    static MSIRUNMODE_REBOOTATEND := 6
    static MSIRUNMODE_REBOOTNOW := 7
    static MSIRUNMODE_CABINET := 8
    static MSIRUNMODE_SOURCESHORTNAMES := 9
    static MSIRUNMODE_TARGETSHORTNAMES := 10
    static MSIRUNMODE_RESERVED11 := 11
    static MSIRUNMODE_WINDOWS9X := 12
    static MSIRUNMODE_ZAWENABLED := 13
    static MSIRUNMODE_RESERVED14 := 14
    static MSIRUNMODE_RESERVED15 := 15
    static MSIRUNMODE_SCHEDULED := 16
    static MSIRUNMODE_ROLLBACK := 17
    static MSIRUNMODE_COMMIT := 18
}
struct MSITRANSFORM_ERROR extends Int32 {
    static MSITRANSFORM_ERROR_ADDEXISTINGROW := 1
    static MSITRANSFORM_ERROR_DELMISSINGROW := 2
    static MSITRANSFORM_ERROR_ADDEXISTINGTABLE := 4
    static MSITRANSFORM_ERROR_DELMISSINGTABLE := 8
    static MSITRANSFORM_ERROR_UPDATEMISSINGROW := 16
    static MSITRANSFORM_ERROR_CHANGECODEPAGE := 32
    static MSITRANSFORM_ERROR_VIEWTRANSFORM := 256
    static MSITRANSFORM_ERROR_NONE := 0
}
struct MSITRANSFORM_VALIDATE extends Int32 {
    static MSITRANSFORM_VALIDATE_LANGUAGE := 1
    static MSITRANSFORM_VALIDATE_PRODUCT := 2
    static MSITRANSFORM_VALIDATE_PLATFORM := 4
    static MSITRANSFORM_VALIDATE_MAJORVERSION := 8
    static MSITRANSFORM_VALIDATE_MINORVERSION := 16
    static MSITRANSFORM_VALIDATE_UPDATEVERSION := 32
    static MSITRANSFORM_VALIDATE_NEWLESSBASEVERSION := 64
    static MSITRANSFORM_VALIDATE_NEWLESSEQUALBASEVERSION := 128
    static MSITRANSFORM_VALIDATE_NEWEQUALBASEVERSION := 256
    static MSITRANSFORM_VALIDATE_NEWGREATEREQUALBASEVERSION := 512
    static MSITRANSFORM_VALIDATE_NEWGREATERBASEVERSION := 1024
    static MSITRANSFORM_VALIDATE_UPGRADECODE := 2048
}
struct ASSEMBLY_INFO {
    cbAssemblyInfo : UInt32
    dwAssemblyFlags : UInt32
    uliAssemblySizeInKB : Int64
    pszCurrentAssemblyPathBuf : PWSTR
    cchBuf : UInt32
}
struct FUSION_INSTALL_REFERENCE {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    guidScheme : GUID
    szIdentifier : PWSTR
    szNonCannonicalData : PWSTR
}
struct ASM_NAME extends Int32 {
    static ASM_NAME_PUBLIC_KEY := 0
    static ASM_NAME_PUBLIC_KEY_TOKEN := 1
    static ASM_NAME_HASH_VALUE := 2
    static ASM_NAME_NAME := 3
    static ASM_NAME_MAJOR_VERSION := 4
    static ASM_NAME_MINOR_VERSION := 5
    static ASM_NAME_BUILD_NUMBER := 6
    static ASM_NAME_REVISION_NUMBER := 7
    static ASM_NAME_CULTURE := 8
    static ASM_NAME_PROCESSOR_ID_ARRAY := 9
    static ASM_NAME_OSINFO_ARRAY := 10
    static ASM_NAME_HASH_ALGID := 11
    static ASM_NAME_ALIAS := 12
    static ASM_NAME_CODEBASE_URL := 13
    static ASM_NAME_CODEBASE_LASTMOD := 14
    static ASM_NAME_NULL_PUBLIC_KEY := 15
    static ASM_NAME_NULL_PUBLIC_KEY_TOKEN := 16
    static ASM_NAME_CUSTOM := 17
    static ASM_NAME_NULL_CUSTOM := 18
    static ASM_NAME_MVID := 19
    static ASM_NAME_MAX_PARAMS := 20
}
struct ASM_BIND_FLAGS extends Int32 {
    static ASM_BINDF_FORCE_CACHE_INSTALL := 1
    static ASM_BINDF_RFS_INTEGRITY_CHECK := 2
    static ASM_BINDF_RFS_MODULE_CHECK := 4
    static ASM_BINDF_BINPATH_PROBE_ONLY := 8
    static ASM_BINDF_SHARED_BINPATH_HINT := 16
    static ASM_BINDF_PARENT_ASM_HINT := 32
}
struct ASM_DISPLAY_FLAGS extends Int32 {
    static ASM_DISPLAYF_VERSION := 1
    static ASM_DISPLAYF_CULTURE := 2
    static ASM_DISPLAYF_PUBLIC_KEY_TOKEN := 4
    static ASM_DISPLAYF_PUBLIC_KEY := 8
    static ASM_DISPLAYF_CUSTOM := 16
    static ASM_DISPLAYF_PROCESSORARCHITECTURE := 32
    static ASM_DISPLAYF_LANGUAGEID := 64
}
struct ASM_CMP_FLAGS extends Int32 {
    static ASM_CMPF_NAME := 1
    static ASM_CMPF_MAJOR_VERSION := 2
    static ASM_CMPF_MINOR_VERSION := 4
    static ASM_CMPF_BUILD_NUMBER := 8
    static ASM_CMPF_REVISION_NUMBER := 16
    static ASM_CMPF_PUBLIC_KEY_TOKEN := 32
    static ASM_CMPF_CULTURE := 64
    static ASM_CMPF_CUSTOM := 128
    static ASM_CMPF_ALL := 255
    static ASM_CMPF_DEFAULT := 256
}
struct IAssemblyName extends IUnknown {
    static IID := "{CD193BC0-B4BC-11D2-9833-00C04FC31D2E}"
    SetProperty(PropertyId, pvProperty, cbProperty)
      => ComCall(3, this.p, UInt32, PropertyId, Struct.Ptr, pvProperty, UInt32, cbProperty)
    GetProperty(PropertyId, pvProperty, pcbProperty)
      => ComCall(4, this.p, UInt32, PropertyId, Struct.Ptr, pvProperty, UInt32.Ptr, pcbProperty)
    Finalize()
      => ComCall(5, this.p)
    GetDisplayName(szDisplayName?, dwDisplayFlags)
      => ComCall(6, this.p, PWSTR, szDisplayName?, UInt32.Ptr, szDisplayName?.Length ?? 0, UInt32, dwDisplayFlags)
    Reserved(refIID, pUnkReserved1, pUnkReserved2, szReserved, llReserved, pvReserved, cbReserved, ppReserved)
      => ComCall(7, this.p, GUID.Ptr, refIID, IUnknown, pUnkReserved1, IUnknown, pUnkReserved2, "Str", szReserved, Int64, llReserved, Struct.Ptr, pvReserved, UInt32, cbReserved, Struct.Ptr.Ptr, ppReserved)
    GetName(pwzName?)
      => ComCall(8, this.p, UInt32.Ptr, pwzName?.Length ?? 0, PWSTR, pwzName?)
    GetVersion(pdwVersionHi, pdwVersionLow)
      => ComCall(9, this.p, UInt32.Ptr, pdwVersionHi, UInt32.Ptr, pdwVersionLow)
    IsEqual(pName, dwCmpFlags)
      => ComCall(10, this.p, IAssemblyName, pName, UInt32, dwCmpFlags)
    Clone(pName)
      => ComCall(11, this.p, IAssemblyName.Ptr, pName)
}
struct IAssemblyCacheItem extends IUnknown {
    static IID := "{9E3AAEB4-D1CD-11D2-BAB9-00C04F8ECEAE}"
    CreateStream(dwFlags, pszStreamName, dwFormat, dwFormatFlags, ppIStream, puliMaxSize)
      => ComCall(3, this.p, UInt32, dwFlags, "Str", pszStreamName, UInt32, dwFormat, UInt32, dwFormatFlags, IStream.Ptr, ppIStream, Int64.Ptr, puliMaxSize)
    Commit(dwFlags, pulDisposition)
      => ComCall(4, this.p, UInt32, dwFlags, UInt32.Ptr, pulDisposition)
    AbortItem()
      => ComCall(5, this.p)
}
struct IAssemblyCache extends IUnknown {
    static IID := "{E707DCDE-D1CD-11D2-BAB9-00C04F8ECEAE}"
    UninstallAssembly(dwFlags, pszAssemblyName, pRefData, pulDisposition)
      => ComCall(3, this.p, UInt32, dwFlags, "Str", pszAssemblyName, FUSION_INSTALL_REFERENCE.Ptr, pRefData, IASSEMBLYCACHE_UNINSTALL_DISPOSITION.Ptr, pulDisposition)
    QueryAssemblyInfo(dwFlags, pszAssemblyName, pAsmInfo)
      => ComCall(4, this.p, QUERYASMINFO_FLAGS, dwFlags, "Str", pszAssemblyName, ASSEMBLY_INFO.Ptr, pAsmInfo)
    CreateAssemblyCacheItem(dwFlags, pvReserved, ppAsmItem, pszAssemblyName)
      => ComCall(5, this.p, UInt32, dwFlags, Struct.Ptr, pvReserved, IAssemblyCacheItem.Ptr, ppAsmItem, "Str", pszAssemblyName)
    Reserved(ppUnk)
      => ComCall(6, this.p, IUnknown.Ptr, ppUnk)
    InstallAssembly(dwFlags, pszManifestFilePath, pRefData)
      => ComCall(7, this.p, UInt32, dwFlags, "Str", pszManifestFilePath, FUSION_INSTALL_REFERENCE.Ptr, pRefData)
}
struct CREATE_ASM_NAME_OBJ_FLAGS extends Int32 {
    static CANOF_PARSE_DISPLAY_NAME := 1
    static CANOF_SET_DEFAULT_VALUES := 2
}
struct PROTECTED_FILE_DATA {
    FileName : UInt16[260]
    FileNumber : UInt32
}
struct msidbControlAttributes extends Int32 {
    static msidbControlAttributesVisible := 1
    static msidbControlAttributesEnabled := 2
    static msidbControlAttributesSunken := 4
    static msidbControlAttributesIndirect := 8
    static msidbControlAttributesInteger := 16
    static msidbControlAttributesRTLRO := 32
    static msidbControlAttributesRightAligned := 64
    static msidbControlAttributesLeftScroll := 128
    static msidbControlAttributesBiDi := 224
    static msidbControlAttributesTransparent := 65536
    static msidbControlAttributesNoPrefix := 131072
    static msidbControlAttributesNoWrap := 262144
    static msidbControlAttributesFormatSize := 524288
    static msidbControlAttributesUsersLanguage := 1048576
    static msidbControlAttributesMultiline := 65536
    static msidbControlAttributesPasswordInput := 2097152
    static msidbControlAttributesProgress95 := 65536
    static msidbControlAttributesRemovableVolume := 65536
    static msidbControlAttributesFixedVolume := 131072
    static msidbControlAttributesRemoteVolume := 262144
    static msidbControlAttributesCDROMVolume := 524288
    static msidbControlAttributesRAMDiskVolume := 1048576
    static msidbControlAttributesFloppyVolume := 2097152
    static msidbControlShowRollbackCost := 4194304
    static msidbControlAttributesSorted := 65536
    static msidbControlAttributesComboList := 131072
    static msidbControlAttributesImageHandle := 65536
    static msidbControlAttributesPushLike := 131072
    static msidbControlAttributesBitmap := 262144
    static msidbControlAttributesIcon := 524288
    static msidbControlAttributesFixedSize := 1048576
    static msidbControlAttributesIconSize16 := 2097152
    static msidbControlAttributesIconSize32 := 4194304
    static msidbControlAttributesIconSize48 := 6291456
    static msidbControlAttributesElevationShield := 8388608
    static msidbControlAttributesHasBorder := 16777216
}
struct msidbLocatorType extends Int32 {
    static msidbLocatorTypeDirectory := 0
    static msidbLocatorTypeFileName := 1
    static msidbLocatorTypeRawValue := 2
    static msidbLocatorType64bit := 16
}
struct msidbComponentAttributes extends Int32 {
    static msidbComponentAttributesLocalOnly := 0
    static msidbComponentAttributesSourceOnly := 1
    static msidbComponentAttributesOptional := 2
    static msidbComponentAttributesRegistryKeyPath := 4
    static msidbComponentAttributesSharedDllRefCount := 8
    static msidbComponentAttributesPermanent := 16
    static msidbComponentAttributesODBCDataSource := 32
    static msidbComponentAttributesTransitive := 64
    static msidbComponentAttributesNeverOverwrite := 128
    static msidbComponentAttributes64bit := 256
    static msidbComponentAttributesDisableRegistryReflection := 512
    static msidbComponentAttributesUninstallOnSupersedence := 1024
    static msidbComponentAttributesShared := 2048
}
struct msidbAssemblyAttributes extends Int32 {
    static msidbAssemblyAttributesURT := 0
    static msidbAssemblyAttributesWin32 := 1
}
struct msidbCustomActionType extends Int32 {
    static msidbCustomActionTypeDll := 1
    static msidbCustomActionTypeExe := 2
    static msidbCustomActionTypeTextData := 3
    static msidbCustomActionTypeJScript := 5
    static msidbCustomActionTypeVBScript := 6
    static msidbCustomActionTypeInstall := 7
    static msidbCustomActionTypeBinaryData := 0
    static msidbCustomActionTypeSourceFile := 16
    static msidbCustomActionTypeDirectory := 32
    static msidbCustomActionTypeProperty := 48
    static msidbCustomActionTypeContinue := 64
    static msidbCustomActionTypeAsync := 128
    static msidbCustomActionTypeFirstSequence := 256
    static msidbCustomActionTypeOncePerProcess := 512
    static msidbCustomActionTypeClientRepeat := 768
    static msidbCustomActionTypeInScript := 1024
    static msidbCustomActionTypeRollback := 256
    static msidbCustomActionTypeCommit := 512
    static msidbCustomActionTypeNoImpersonate := 2048
    static msidbCustomActionTypeTSAware := 16384
    static msidbCustomActionType64BitScript := 4096
    static msidbCustomActionTypeHideTarget := 8192
    static msidbCustomActionTypePatchUninstall := 32768
}
struct msidbDialogAttributes extends Int32 {
    static msidbDialogAttributesVisible := 1
    static msidbDialogAttributesModal := 2
    static msidbDialogAttributesMinimize := 4
    static msidbDialogAttributesSysModal := 8
    static msidbDialogAttributesKeepModeless := 16
    static msidbDialogAttributesTrackDiskSpace := 32
    static msidbDialogAttributesUseCustomPalette := 64
    static msidbDialogAttributesRTLRO := 128
    static msidbDialogAttributesRightAligned := 256
    static msidbDialogAttributesLeftScroll := 512
    static msidbDialogAttributesBiDi := 896
    static msidbDialogAttributesError := 65536
}
struct msidbFeatureAttributes extends Int32 {
    static msidbFeatureAttributesFavorLocal := 0
    static msidbFeatureAttributesFavorSource := 1
    static msidbFeatureAttributesFollowParent := 2
    static msidbFeatureAttributesFavorAdvertise := 4
    static msidbFeatureAttributesDisallowAdvertise := 8
    static msidbFeatureAttributesUIDisallowAbsent := 16
    static msidbFeatureAttributesNoUnsupportedAdvertise := 32
}
struct msidbFileAttributes extends Int32 {
    static msidbFileAttributesReadOnly := 1
    static msidbFileAttributesHidden := 2
    static msidbFileAttributesSystem := 4
    static msidbFileAttributesReserved0 := 8
    static msidbFileAttributesIsolatedComp := 16
    static msidbFileAttributesReserved1 := 64
    static msidbFileAttributesReserved2 := 128
    static msidbFileAttributesReserved3 := 256
    static msidbFileAttributesVital := 512
    static msidbFileAttributesChecksum := 1024
    static msidbFileAttributesPatchAdded := 4096
    static msidbFileAttributesNoncompressed := 8192
    static msidbFileAttributesCompressed := 16384
    static msidbFileAttributesReserved4 := 32768
}
struct msidbIniFileAction extends Int32 {
    static msidbIniFileActionAddLine := 0
    static msidbIniFileActionCreateLine := 1
    static msidbIniFileActionRemoveLine := 2
    static msidbIniFileActionAddTag := 3
    static msidbIniFileActionRemoveTag := 4
}
struct msidbMoveFileOptions extends Int32 {
    static msidbMoveFileOptionsMove := 1
}
struct msidbODBCDataSourceRegistration extends Int32 {
    static msidbODBCDataSourceRegistrationPerMachine := 0
    static msidbODBCDataSourceRegistrationPerUser := 1
}
struct msidbClassAttributes extends Int32 {
    static msidbClassAttributesRelativePath := 1
}
struct msidbPatchAttributes extends Int32 {
    static msidbPatchAttributesNonVital := 1
}
struct msidbRegistryRoot extends Int32 {
    static msidbRegistryRootClassesRoot := 0
    static msidbRegistryRootCurrentUser := 1
    static msidbRegistryRootLocalMachine := 2
    static msidbRegistryRootUsers := 3
}
struct msidbRemoveFileInstallMode extends Int32 {
    static msidbRemoveFileInstallModeOnInstall := 1
    static msidbRemoveFileInstallModeOnRemove := 2
    static msidbRemoveFileInstallModeOnBoth := 3
}
struct msidbServiceControlEvent extends Int32 {
    static msidbServiceControlEventStart := 1
    static msidbServiceControlEventStop := 2
    static msidbServiceControlEventDelete := 8
    static msidbServiceControlEventUninstallStart := 16
    static msidbServiceControlEventUninstallStop := 32
    static msidbServiceControlEventUninstallDelete := 128
}
struct msidbServiceConfigEvent extends Int32 {
    static msidbServiceConfigEventInstall := 1
    static msidbServiceConfigEventUninstall := 2
    static msidbServiceConfigEventReinstall := 4
}
struct msidbServiceInstallErrorControl extends Int32 {
    static msidbServiceInstallErrorControlVital := 32768
}
struct msidbTextStyleStyleBits extends Int32 {
    static msidbTextStyleStyleBitsBold := 1
    static msidbTextStyleStyleBitsItalic := 2
    static msidbTextStyleStyleBitsUnderline := 4
    static msidbTextStyleStyleBitsStrike := 8
}
struct msidbUpgradeAttributes extends Int32 {
    static msidbUpgradeAttributesMigrateFeatures := 1
    static msidbUpgradeAttributesOnlyDetect := 2
    static msidbUpgradeAttributesIgnoreRemoveFailure := 4
    static msidbUpgradeAttributesVersionMinInclusive := 256
    static msidbUpgradeAttributesVersionMaxInclusive := 512
    static msidbUpgradeAttributesLanguagesExclusive := 1024
}
struct msidbEmbeddedUIAttributes extends Int32 {
    static msidbEmbeddedUI := 1
    static msidbEmbeddedHandlesBasic := 2
}
struct msidbSumInfoSourceType extends Int32 {
    static msidbSumInfoSourceTypeSFN := 1
    static msidbSumInfoSourceTypeCompressed := 2
    static msidbSumInfoSourceTypeAdminImage := 4
    static msidbSumInfoSourceTypeLUAPackage := 8
}
struct msirbRebootType extends Int32 {
    static msirbRebootImmediate := 1
    static msirbRebootDeferred := 2
}
struct msirbRebootReason extends Int32 {
    static msirbRebootUndeterminedReason := 0
    static msirbRebootInUseFilesReason := 1
    static msirbRebootScheduleRebootReason := 2
    static msirbRebootForceRebootReason := 3
    static msirbRebootCustomActionReason := 4
}
struct msifiFastInstallBits extends Int32 {
    static msifiFastInstallNoSR := 1
    static msifiFastInstallQuickCosting := 2
    static msifiFastInstallLessPrgMsg := 4
}
struct TILE_TEMPLATE_TYPE extends Int32 {
    static TILE_TEMPLATE_INVALID := 0
    static TILE_TEMPLATE_FLIP := 5
    static TILE_TEMPLATE_DEEPLINK := 13
    static TILE_TEMPLATE_CYCLE := 14
    static TILE_TEMPLATE_METROCOUNT := 1
    static TILE_TEMPLATE_AGILESTORE := 2
    static TILE_TEMPLATE_GAMES := 3
    static TILE_TEMPLATE_CALENDAR := 4
    static TILE_TEMPLATE_MUSICVIDEO := 7
    static TILE_TEMPLATE_PEOPLE := 10
    static TILE_TEMPLATE_CONTACT := 11
    static TILE_TEMPLATE_GROUP := 12
    static TILE_TEMPLATE_DEFAULT := 15
    static TILE_TEMPLATE_BADGE := 16
    static TILE_TEMPLATE_BLOCK := 17
    static TILE_TEMPLATE_TEXT01 := 18
    static TILE_TEMPLATE_TEXT02 := 19
    static TILE_TEMPLATE_TEXT03 := 20
    static TILE_TEMPLATE_TEXT04 := 21
    static TILE_TEMPLATE_TEXT05 := 22
    static TILE_TEMPLATE_TEXT06 := 23
    static TILE_TEMPLATE_TEXT07 := 24
    static TILE_TEMPLATE_TEXT08 := 25
    static TILE_TEMPLATE_TEXT09 := 26
    static TILE_TEMPLATE_TEXT10 := 27
    static TILE_TEMPLATE_TEXT11 := 28
    static TILE_TEMPLATE_IMAGE := 29
    static TILE_TEMPLATE_IMAGECOLLECTION := 30
    static TILE_TEMPLATE_IMAGEANDTEXT01 := 31
    static TILE_TEMPLATE_IMAGEANDTEXT02 := 32
    static TILE_TEMPLATE_BLOCKANDTEXT01 := 33
    static TILE_TEMPLATE_BLOCKANDTEXT02 := 34
    static TILE_TEMPLATE_PEEKIMAGEANDTEXT01 := 35
    static TILE_TEMPLATE_PEEKIMAGEANDTEXT02 := 36
    static TILE_TEMPLATE_PEEKIMAGEANDTEXT03 := 37
    static TILE_TEMPLATE_PEEKIMAGEANDTEXT04 := 38
    static TILE_TEMPLATE_PEEKIMAGE01 := 39
    static TILE_TEMPLATE_PEEKIMAGE02 := 40
    static TILE_TEMPLATE_PEEKIMAGE03 := 41
    static TILE_TEMPLATE_PEEKIMAGE04 := 42
    static TILE_TEMPLATE_PEEKIMAGE05 := 43
    static TILE_TEMPLATE_PEEKIMAGE06 := 44
    static TILE_TEMPLATE_PEEKIMAGECOLLECTION01 := 45
    static TILE_TEMPLATE_PEEKIMAGECOLLECTION02 := 46
    static TILE_TEMPLATE_PEEKIMAGECOLLECTION03 := 47
    static TILE_TEMPLATE_PEEKIMAGECOLLECTION04 := 48
    static TILE_TEMPLATE_PEEKIMAGECOLLECTION05 := 49
    static TILE_TEMPLATE_PEEKIMAGECOLLECTION06 := 50
    static TILE_TEMPLATE_SMALLIMAGEANDTEXT01 := 51
    static TILE_TEMPLATE_SMALLIMAGEANDTEXT02 := 52
    static TILE_TEMPLATE_SMALLIMAGEANDTEXT03 := 53
    static TILE_TEMPLATE_SMALLIMAGEANDTEXT04 := 54
    static TILE_TEMPLATE_SMALLIMAGEANDTEXT05 := 55
    static TILE_TEMPLATE_METROCOUNTQUEUE := 56
    static TILE_TEMPLATE_SEARCH := 57
    static TILE_TEMPLATE_TILEFLYOUT01 := 58
    static TILE_TEMPLATE_FOLDER := 59
    static TILE_TEMPLATE_ALL := 100
}
struct PM_APP_GENRE extends Int32 {
    static PM_APP_GENRE_GAMES := 0
    static PM_APP_GENRE_OTHER := 1
    static PM_APP_GENRE_INVALID := 2
}
struct PM_APPLICATION_INSTALL_TYPE extends Int32 {
    static PM_APPLICATION_INSTALL_NORMAL := 0
    static PM_APPLICATION_INSTALL_IN_ROM := 1
    static PM_APPLICATION_INSTALL_PA := 2
    static PM_APPLICATION_INSTALL_DEBUG := 3
    static PM_APPLICATION_INSTALL_ENTERPRISE := 4
    static PM_APPLICATION_INSTALL_INVALID := 5
}
struct PM_APPLICATION_STATE extends Int32 {
    static PM_APPLICATION_STATE_MIN := 0
    static PM_APPLICATION_STATE_INSTALLED := 1
    static PM_APPLICATION_STATE_INSTALLING := 2
    static PM_APPLICATION_STATE_UPDATING := 3
    static PM_APPLICATION_STATE_UNINSTALLING := 4
    static PM_APPLICATION_STATE_LICENSE_UPDATING := 5
    static PM_APPLICATION_STATE_MOVING := 6
    static PM_APPLICATION_STATE_DISABLED_SD_CARD := 7
    static PM_APPLICATION_STATE_DISABLED_ENTERPRISE := 8
    static PM_APPLICATION_STATE_DISABLED_BACKING_UP := 9
    static PM_APPLICATION_STATE_DISABLED_MDIL_BINDING := 10
    static PM_APPLICATION_STATE_MAX := 10
    static PM_APPLICATION_STATE_INVALID := 11
}
struct PM_APPLICATION_HUBTYPE extends Int32 {
    static PM_APPLICATION_HUBTYPE_NONMUSIC := 0
    static PM_APPLICATION_HUBTYPE_MUSIC := 1
    static PM_APPLICATION_HUBTYPE_INVALID := 2
}
struct PM_TILE_HUBTYPE extends Int32 {
    static PM_TILE_HUBTYPE_MUSIC := 1
    static PM_TILE_HUBTYPE_MOSETTINGS := 268435456
    static PM_TILE_HUBTYPE_GAMES := 536870912
    static PM_TILE_HUBTYPE_APPLIST := 1073741824
    static PM_TILE_HUBTYPE_STARTMENU := -2147483648
    static PM_TILE_HUBTYPE_LOCKSCREEN := 16777216
    static PM_TILE_HUBTYPE_KIDZONE := 33554432
    static PM_TILE_HUBTYPE_CACHED := 67108864
    static PM_TILE_HUBTYPE_INVALID := 67108865
}
struct PM_STARTTILE_TYPE extends Int32 {
    static PM_STARTTILE_TYPE_PRIMARY := 1
    static PM_STARTTILE_TYPE_SECONDARY := 2
    static PM_STARTTILE_TYPE_APPLIST := 3
    static PM_STARTTILE_TYPE_APPLISTPRIMARY := 4
    static PM_STARTTILE_TYPE_INVALID := 5
}
struct PM_TASK_TYPE extends Int32 {
    static PM_TASK_TYPE_NORMAL := 0
    static PM_TASK_TYPE_DEFAULT := 1
    static PM_TASK_TYPE_SETTINGS := 2
    static PM_TASK_TYPE_BACKGROUNDSERVICEAGENT := 3
    static PM_TASK_TYPE_BACKGROUNDWORKER := 4
    static PM_TASK_TYPE_INVALID := 5
}
struct PACKMAN_RUNTIME extends Int32 {
    static PACKMAN_RUNTIME_NATIVE := 1
    static PACKMAN_RUNTIME_SILVERLIGHTMOBILE := 2
    static PACKMAN_RUNTIME_XNA := 3
    static PACKMAN_RUNTIME_MODERN_NATIVE := 4
    static PACKMAN_RUNTIME_JUPITER := 5
    static PACKMAN_RUNTIME_INVALID := 6
}
struct PM_ACTIVATION_POLICY extends Int32 {
    static PM_ACTIVATION_POLICY_RESUME := 0
    static PM_ACTIVATION_POLICY_RESUMESAMEPARAMS := 1
    static PM_ACTIVATION_POLICY_REPLACE := 2
    static PM_ACTIVATION_POLICY_REPLACESAMEPARAMS := 3
    static PM_ACTIVATION_POLICY_MULTISESSION := 4
    static PM_ACTIVATION_POLICY_REPLACE_IGNOREFOREGROUND := 5
    static PM_ACTIVATION_POLICY_UNKNOWN := 6
    static PM_ACTIVATION_POLICY_INVALID := 7
}
struct PM_TASK_TRANSITION extends Int32 {
    static PM_TASK_TRANSITION_DEFAULT := 0
    static PM_TASK_TRANSITION_NONE := 1
    static PM_TASK_TRANSITION_TURNSTILE := 2
    static PM_TASK_TRANSITION_SLIDE := 3
    static PM_TASK_TRANSITION_SWIVEL := 4
    static PM_TASK_TRANSITION_READERBOARD := 5
    static PM_TASK_TRANSITION_CUSTOM := 6
    static PM_TASK_TRANSITION_INVALID := 7
}
struct PM_ENUM_APP_FILTER extends Int32 {
    static PM_APP_FILTER_ALL := 0
    static PM_APP_FILTER_VISIBLE := 1
    static PM_APP_FILTER_GENRE := 2
    static PM_APP_FILTER_NONGAMES := 3
    static PM_APP_FILTER_HUBTYPE := 4
    static PM_APP_FILTER_PINABLEONKIDZONE := 5
    static PM_APP_FILTER_ALL_INCLUDE_MODERN := 6
    static PM_APP_FILTER_FRAMEWORK := 7
    static PM_APP_FILTER_MAX := 8
}
struct PM_ENUM_TILE_FILTER extends Int32 {
    static PM_TILE_FILTER_APPLIST := 8
    static PM_TILE_FILTER_PINNED := 9
    static PM_TILE_FILTER_HUBTYPE := 10
    static PM_TILE_FILTER_APP_ALL := 11
    static PM_TILE_FILTER_MAX := 12
}
struct PM_ENUM_TASK_FILTER extends Int32 {
    static PM_TASK_FILTER_APP_ALL := 12
    static PM_TASK_FILTER_TASK_TYPE := 13
    static PM_TASK_FILTER_DEHYD_SUPRESSING := 14
    static PM_TASK_FILTER_APP_TASK_TYPE := 15
    static PM_TASK_FILTER_BGEXECUTION := 16
    static PM_TASK_FILTER_MAX := 17
}
struct PM_ENUM_EXTENSION_FILTER extends Int32 {
    static PM_ENUM_EXTENSION_FILTER_BY_CONSUMER := 17
    static PM_ENUM_EXTENSION_FILTER_APPCONNECT := 17
    static PM_ENUM_EXTENSION_FILTER_PROTOCOL_ALL := 18
    static PM_ENUM_EXTENSION_FILTER_FTASSOC_FILETYPE_ALL := 19
    static PM_ENUM_EXTENSION_FILTER_FTASSOC_CONTENTTYPE_ALL := 20
    static PM_ENUM_EXTENSION_FILTER_FTASSOC_APPLICATION_ALL := 21
    static PM_ENUM_EXTENSION_FILTER_SHARETARGET_ALL := 22
    static PM_ENUM_EXTENSION_FILTER_FILEOPENPICKER_ALL := 23
    static PM_ENUM_EXTENSION_FILTER_FILESAVEPICKER_ALL := 24
    static PM_ENUM_EXTENSION_FILTER_CACHEDFILEUPDATER_ALL := 25
    static PM_ENUM_EXTENSION_FILTER_MAX := 26
}
struct PM_ENUM_BSA_FILTER extends Int32 {
    static PM_ENUM_BSA_FILTER_ALL := 26
    static PM_ENUM_BSA_FILTER_BY_TASKID := 27
    static PM_ENUM_BSA_FILTER_BY_PRODUCTID := 28
    static PM_ENUM_BSA_FILTER_BY_PERIODIC := 29
    static PM_ENUM_BSA_FILTER_BY_ALL_LAUNCHONBOOT := 30
    static PM_ENUM_BSA_FILTER_MAX := 31
}
struct PM_ENUM_BW_FILTER extends Int32 {
    static PM_ENUM_BW_FILTER_BOOTWORKER_ALL := 31
    static PM_ENUM_BW_FILTER_BY_TASKID := 32
    static PM_ENUM_BW_FILTER_MAX := 33
}
struct PM_APPTASKTYPE {
    ProductID : GUID
    TaskType : PM_TASK_TYPE
}
struct PM_EXTENSIONCONSUMER {
    ConsumerPID : GUID
    ExtensionID : BSTR
}
struct PM_BSATASKID {
    ProductID : GUID
    TaskID : BSTR
}
struct PM_BWTASKID {
    ProductID : GUID
    TaskID : BSTR
}
struct PM_ENUM_FILTER {
    FilterType : Int32
    FilterParameter : this._FilterParameter_e__Union
    struct _FilterParameter_e__Union {
        union {
            Dummy : Int32
            Genre : PM_APP_GENRE
            AppHubType : PM_APPLICATION_HUBTYPE
            HubType : PM_TILE_HUBTYPE
            Tasktype : PM_TASK_TYPE
            TaskProductID : GUID
            TileProductID : GUID
            AppTaskType : PM_APPTASKTYPE
            Consumer : PM_EXTENSIONCONSUMER
            BSATask : PM_BSATASKID
            BSAProductID : GUID
            BWTask : PM_BWTASKID
            ProtocolName : BSTR
            FileType : BSTR
            ContentType : BSTR
            AppSupportedFileExtPID : GUID
            ShareTargetFileType : BSTR
        }
    }
}
struct PM_LIVETILE_RECURRENCE_TYPE extends Int32 {
    static PM_LIVETILE_RECURRENCE_TYPE_INSTANT := 0
    static PM_LIVETILE_RECURRENCE_TYPE_ONETIME := 1
    static PM_LIVETILE_RECURRENCE_TYPE_INTERVAL := 2
    static PM_LIVETILE_RECURRENCE_TYPE_MAX := 2
}
struct PM_TILE_SIZE extends Int32 {
    static PM_TILE_SIZE_SMALL := 0
    static PM_TILE_SIZE_MEDIUM := 1
    static PM_TILE_SIZE_LARGE := 2
    static PM_TILE_SIZE_SQUARE310X310 := 3
    static PM_TILE_SIZE_TALL150X310 := 4
    static PM_TILE_SIZE_INVALID := 5
}
struct PM_LOGO_SIZE extends Int32 {
    static PM_LOGO_SIZE_SMALL := 0
    static PM_LOGO_SIZE_MEDIUM := 1
    static PM_LOGO_SIZE_LARGE := 2
    static PM_LOGO_SIZE_INVALID := 3
}
struct PM_STARTAPPBLOB {
    cbSize : UInt32 := this.Size
    ProductID : GUID
    AppTitle : BSTR
    IconPath : BSTR
    IsUninstallable : BOOL
    AppInstallType : PM_APPLICATION_INSTALL_TYPE
    InstanceID : GUID
    State : PM_APPLICATION_STATE
    IsModern : BOOL
    IsModernLightUp : BOOL
    LightUpSupportMask : UInt16
}
struct PM_INVOCATIONINFO {
    URIBaseOrAUMID : BSTR
    URIFragmentOrArgs : BSTR
}
struct PM_STARTTILEBLOB {
    cbSize : UInt32 := this.Size
    ProductID : GUID
    TileID : BSTR
    TemplateType : TILE_TEMPLATE_TYPE
    HubPosition : UInt32[32]
    HubVisibilityBitmask : UInt32
    IsDefault : BOOL
    TileType : PM_STARTTILE_TYPE
    pbPropBlob : UInt8.Ptr
    cbPropBlob : UInt32
    IsRestoring : BOOL
    IsModern : BOOL
    InvocationInfo : PM_INVOCATIONINFO
}
struct PM_INSTALLINFO {
    ProductID : GUID
    PackagePath : BSTR
    InstanceID : GUID
    pbLicense : UInt8.Ptr
    cbLicense : UInt32
    IsUninstallDisabled : BOOL
    DeploymentOptions : UInt32
    OfferID : GUID
    MarketplaceAppVersion : BSTR
}
struct PM_UPDATEINFO_LEGACY {
    ProductID : GUID
    PackagePath : BSTR
    InstanceID : GUID
    pbLicense : UInt8.Ptr
    cbLicense : UInt32
    MarketplaceAppVersion : BSTR
}
struct PM_UPDATEINFO {
    ProductID : GUID
    PackagePath : BSTR
    InstanceID : GUID
    pbLicense : UInt8.Ptr
    cbLicense : UInt32
    MarketplaceAppVersion : BSTR
    DeploymentOptions : UInt32
}
struct IPMApplicationInfo extends IUnknown {
    static IID := "{50AFB58A-438C-4088-9789-F8C4899829C7}"
    get_ProductID(pProductID)
      => ComCall(3, this.p, GUID.Ptr, pProductID)
    get_InstanceID(pInstanceID)
      => ComCall(4, this.p, GUID.Ptr, pInstanceID)
    get_OfferID(pOfferID)
      => ComCall(5, this.p, GUID.Ptr, pOfferID)
    get_DefaultTask(pDefaultTask)
      => ComCall(6, this.p, BSTR.Ptr, pDefaultTask)
    get_AppTitle(pAppTitle)
      => ComCall(7, this.p, BSTR.Ptr, pAppTitle)
    get_IconPath(pAppIconPath)
      => ComCall(8, this.p, BSTR.Ptr, pAppIconPath)
    get_NotificationState(pIsNotified)
      => ComCall(9, this.p, BOOL.Ptr, pIsNotified)
    get_AppInstallType(pAppInstallType)
      => ComCall(10, this.p, PM_APPLICATION_INSTALL_TYPE.Ptr, pAppInstallType)
    get_State(pState)
      => ComCall(11, this.p, PM_APPLICATION_STATE.Ptr, pState)
    get_IsRevoked(pIsRevoked)
      => ComCall(12, this.p, BOOL.Ptr, pIsRevoked)
    get_UpdateAvailable(pIsUpdateAvailable)
      => ComCall(13, this.p, BOOL.Ptr, pIsUpdateAvailable)
    get_InstallDate(pInstallDate)
      => ComCall(14, this.p, FILETIME.Ptr, pInstallDate)
    get_IsUninstallable(pIsUninstallable)
      => ComCall(15, this.p, BOOL.Ptr, pIsUninstallable)
    get_IsThemable(pIsThemable)
      => ComCall(16, this.p, BOOL.Ptr, pIsThemable)
    get_IsTrial(pIsTrial)
      => ComCall(17, this.p, BOOL.Ptr, pIsTrial)
    get_InstallPath(pInstallPath)
      => ComCall(18, this.p, BSTR.Ptr, pInstallPath)
    get_DataRoot(pDataRoot)
      => ComCall(19, this.p, BSTR.Ptr, pDataRoot)
    get_Genre(pGenre)
      => ComCall(20, this.p, PM_APP_GENRE.Ptr, pGenre)
    get_Publisher(pPublisher)
      => ComCall(21, this.p, BSTR.Ptr, pPublisher)
    get_Author(pAuthor)
      => ComCall(22, this.p, BSTR.Ptr, pAuthor)
    get_Description(pDescription)
      => ComCall(23, this.p, BSTR.Ptr, pDescription)
    get_Version(pVersion)
      => ComCall(24, this.p, BSTR.Ptr, pVersion)
    get_InvocationInfo(pImageUrn, pParameters)
      => ComCall(25, this.p, BSTR.Ptr, pImageUrn, BSTR.Ptr, pParameters)
    get_AppPlatMajorVersion(pMajorVer)
      => ComCall(26, this.p, UInt8.Ptr, pMajorVer)
    get_AppPlatMinorVersion(pMinorVer)
      => ComCall(27, this.p, UInt8.Ptr, pMinorVer)
    get_PublisherID(pPublisherID)
      => ComCall(28, this.p, GUID.Ptr, pPublisherID)
    get_IsMultiCore(pIsMultiCore)
      => ComCall(29, this.p, BOOL.Ptr, pIsMultiCore)
    get_SID(pSID)
      => ComCall(30, this.p, BSTR.Ptr, pSID)
    get_AppPlatMajorVersionLightUp(pMajorVer)
      => ComCall(31, this.p, UInt8.Ptr, pMajorVer)
    get_AppPlatMinorVersionLightUp(pMinorVer)
      => ComCall(32, this.p, UInt8.Ptr, pMinorVer)
    set_UpdateAvailable(IsUpdateAvailable)
      => ComCall(33, this.p, BOOL, IsUpdateAvailable)
    set_NotificationState(IsNotified)
      => ComCall(34, this.p, BOOL, IsNotified)
    set_IconPath(AppIconPath)
      => ComCall(35, this.p, BSTR, AppIconPath)
    set_UninstallableState(IsUninstallable)
      => ComCall(36, this.p, BOOL, IsUninstallable)
    get_IsPinableOnKidZone(pIsPinable)
      => ComCall(37, this.p, BOOL.Ptr, pIsPinable)
    get_IsOriginallyPreInstalled(pIsPreinstalled)
      => ComCall(38, this.p, BOOL.Ptr, pIsPreinstalled)
    get_IsInstallOnSD(pIsInstallOnSD)
      => ComCall(39, this.p, BOOL.Ptr, pIsInstallOnSD)
    get_IsOptoutOnSD(pIsOptoutOnSD)
      => ComCall(40, this.p, BOOL.Ptr, pIsOptoutOnSD)
    get_IsOptoutBackupRestore(pIsOptoutBackupRestore)
      => ComCall(41, this.p, BOOL.Ptr, pIsOptoutBackupRestore)
    set_EnterpriseDisabled(IsDisabled)
      => ComCall(42, this.p, BOOL, IsDisabled)
    set_EnterpriseUninstallable(IsUninstallable)
      => ComCall(43, this.p, BOOL, IsUninstallable)
    get_EnterpriseDisabled(IsDisabled)
      => ComCall(44, this.p, BOOL.Ptr, IsDisabled)
    get_EnterpriseUninstallable(IsUninstallable)
      => ComCall(45, this.p, BOOL.Ptr, IsUninstallable)
    get_IsVisibleOnAppList(pIsVisible)
      => ComCall(46, this.p, BOOL.Ptr, pIsVisible)
    get_IsInboxApp(pIsInboxApp)
      => ComCall(47, this.p, BOOL.Ptr, pIsInboxApp)
    get_StorageID(pStorageID)
      => ComCall(48, this.p, GUID.Ptr, pStorageID)
    get_StartAppBlob(pBlob)
      => ComCall(49, this.p, PM_STARTAPPBLOB.Ptr, pBlob)
    get_IsMovable(pIsMovable)
      => ComCall(50, this.p, BOOL.Ptr, pIsMovable)
    get_DeploymentAppEnumerationHubFilter(HubType)
      => ComCall(51, this.p, PM_TILE_HUBTYPE.Ptr, HubType)
    get_ModifiedDate(pModifiedDate)
      => ComCall(52, this.p, FILETIME.Ptr, pModifiedDate)
    get_IsOriginallyRestored(pIsRestored)
      => ComCall(53, this.p, BOOL.Ptr, pIsRestored)
    get_ShouldDeferMdilBind(pfDeferMdilBind)
      => ComCall(54, this.p, BOOL.Ptr, pfDeferMdilBind)
    get_IsFullyPreInstall(pfIsFullyPreInstall)
      => ComCall(55, this.p, BOOL.Ptr, pfIsFullyPreInstall)
    set_IsMdilMaintenanceNeeded(fIsMdilMaintenanceNeeded)
      => ComCall(56, this.p, BOOL, fIsMdilMaintenanceNeeded)
    set_Title(AppTitle)
      => ComCall(57, this.p, BSTR, AppTitle)
}
struct IPMTilePropertyInfo extends IUnknown {
    static IID := "{6C2B8017-1EFA-42A7-86C0-6D4B640BF528}"
    get_PropertyID(pPropID)
      => ComCall(3, this.p, UInt32.Ptr, pPropID)
    get_PropertyValue(pPropValue)
      => ComCall(4, this.p, BSTR.Ptr, pPropValue)
    set_Property(PropValue)
      => ComCall(5, this.p, BSTR, PropValue)
}
struct IPMTilePropertyEnumerator extends IUnknown {
    static IID := "{CC4CD629-9047-4250-AAC8-930E47812421}"
    get_Next(ppPropInfo)
      => ComCall(3, this.p, IPMTilePropertyInfo.Ptr, ppPropInfo)
}
struct IPMTileInfo extends IUnknown {
    static IID := "{D1604833-2B08-4001-82CD-183AD734F752}"
    get_ProductID(pProductID)
      => ComCall(3, this.p, GUID.Ptr, pProductID)
    get_TileID(pTileID)
      => ComCall(4, this.p, BSTR.Ptr, pTileID)
    get_TemplateType(pTemplateType)
      => ComCall(5, this.p, TILE_TEMPLATE_TYPE.Ptr, pTemplateType)
    get_HubPinnedState(HubType, pPinned)
      => ComCall(6, this.p, PM_TILE_HUBTYPE, HubType, BOOL.Ptr, pPinned)
    get_HubPosition(HubType, pPosition)
      => ComCall(7, this.p, PM_TILE_HUBTYPE, HubType, UInt32.Ptr, pPosition)
    get_IsNotified(pIsNotified)
      => ComCall(8, this.p, BOOL.Ptr, pIsNotified)
    get_IsDefault(pIsDefault)
      => ComCall(9, this.p, BOOL.Ptr, pIsDefault)
    get_TaskID(pTaskID)
      => ComCall(10, this.p, BSTR.Ptr, pTaskID)
    get_TileType(pStartTileType)
      => ComCall(11, this.p, PM_STARTTILE_TYPE.Ptr, pStartTileType)
    get_IsThemable(pIsThemable)
      => ComCall(12, this.p, BOOL.Ptr, pIsThemable)
    get_PropertyById(PropID, ppPropInfo)
      => ComCall(13, this.p, UInt32, PropID, IPMTilePropertyInfo.Ptr, ppPropInfo)
    get_InvocationInfo(pImageUrn, pParameters)
      => ComCall(14, this.p, BSTR.Ptr, pImageUrn, BSTR.Ptr, pParameters)
    get_PropertyEnum(ppTilePropEnum)
      => ComCall(15, this.p, IPMTilePropertyEnumerator.Ptr, ppTilePropEnum)
    get_HubTileSize(HubType, pSize)
      => ComCall(16, this.p, PM_TILE_HUBTYPE, HubType, PM_TILE_SIZE.Ptr, pSize)
    set_HubPosition(HubType, Position)
      => ComCall(17, this.p, PM_TILE_HUBTYPE, HubType, UInt32, Position)
    set_NotifiedState(Notified)
      => ComCall(18, this.p, BOOL, Notified)
    set_HubPinnedState(HubType, Pinned)
      => ComCall(19, this.p, PM_TILE_HUBTYPE, HubType, BOOL, Pinned)
    set_HubTileSize(HubType, Size)
      => ComCall(20, this.p, PM_TILE_HUBTYPE, HubType, PM_TILE_SIZE, Size)
    set_InvocationInfo(TaskName, TaskParameters)
      => ComCall(21, this.p, BSTR, TaskName, BSTR, TaskParameters)
    get_StartTileBlob(pBlob)
      => ComCall(22, this.p, PM_STARTTILEBLOB.Ptr, pBlob)
    get_IsRestoring(pIsRestoring)
      => ComCall(23, this.p, BOOL.Ptr, pIsRestoring)
    get_IsAutoRestoreDisabled(pIsAutoRestoreDisabled)
      => ComCall(24, this.p, BOOL.Ptr, pIsAutoRestoreDisabled)
    set_IsRestoring(Restoring)
      => ComCall(25, this.p, BOOL, Restoring)
    set_IsAutoRestoreDisabled(AutoRestoreDisabled)
      => ComCall(26, this.p, BOOL, AutoRestoreDisabled)
}
struct IPMTileInfoEnumerator extends IUnknown {
    static IID := "{DED83065-E462-4B2C-ACB5-E39CEA61C874}"
    get_Next(ppTileInfo)
      => ComCall(3, this.p, IPMTileInfo.Ptr, ppTileInfo)
}
struct IPMApplicationInfoEnumerator extends IUnknown {
    static IID := "{0EC42A96-4D46-4DC6-A3D9-A7ACAAC0F5FA}"
    get_Next(ppAppInfo)
      => ComCall(3, this.p, IPMApplicationInfo.Ptr, ppAppInfo)
}
struct IPMLiveTileJobInfo extends IUnknown {
    static IID := "{6009A81F-4710-4697-B5F6-2208F6057B8E}"
    get_ProductID(pProductID)
      => ComCall(3, this.p, GUID.Ptr, pProductID)
    get_TileID(pTileID)
      => ComCall(4, this.p, BSTR.Ptr, pTileID)
    get_NextSchedule(pNextSchedule)
      => ComCall(5, this.p, FILETIME.Ptr, pNextSchedule)
    set_NextSchedule(ftNextSchedule)
      => ComCall(6, this.p, FILETIME, ftNextSchedule)
    get_StartSchedule(pStartSchedule)
      => ComCall(7, this.p, FILETIME.Ptr, pStartSchedule)
    set_StartSchedule(ftStartSchedule)
      => ComCall(8, this.p, FILETIME, ftStartSchedule)
    get_IntervalDuration(pIntervalDuration)
      => ComCall(9, this.p, UInt32.Ptr, pIntervalDuration)
    set_IntervalDuration(ulIntervalDuration)
      => ComCall(10, this.p, UInt32, ulIntervalDuration)
    get_RunForever(IsRunForever)
      => ComCall(11, this.p, BOOL.Ptr, IsRunForever)
    set_RunForever(fRunForever)
      => ComCall(12, this.p, BOOL, fRunForever)
    get_MaxRunCount(pMaxRunCount)
      => ComCall(13, this.p, UInt32.Ptr, pMaxRunCount)
    set_MaxRunCount(ulMaxRunCount)
      => ComCall(14, this.p, UInt32, ulMaxRunCount)
    get_RunCount(pRunCount)
      => ComCall(15, this.p, UInt32.Ptr, pRunCount)
    set_RunCount(ulRunCount)
      => ComCall(16, this.p, UInt32, ulRunCount)
    get_RecurrenceType(pRecurrenceType)
      => ComCall(17, this.p, UInt32.Ptr, pRecurrenceType)
    set_RecurrenceType(ulRecurrenceType)
      => ComCall(18, this.p, UInt32, ulRecurrenceType)
    get_TileXML(pTileXml, pcbTileXml)
      => ComCall(19, this.p, UInt8.Ptr.Ptr, pTileXml, UInt32.Ptr, pcbTileXml)
    set_TileXML(pTileXml)
      => ComCall(20, this.p, UInt8.Ptr, pTileXml, UInt32, pTileXml.Length)
    get_UrlXML(pUrlXML, pcbUrlXML)
      => ComCall(21, this.p, UInt8.Ptr.Ptr, pUrlXML, UInt32.Ptr, pcbUrlXML)
    set_UrlXML(pUrlXML)
      => ComCall(22, this.p, UInt8.Ptr, pUrlXML, UInt32, pUrlXML.Length)
    get_AttemptCount(pAttemptCount)
      => ComCall(23, this.p, UInt32.Ptr, pAttemptCount)
    set_AttemptCount(ulAttemptCount)
      => ComCall(24, this.p, UInt32, ulAttemptCount)
    get_DownloadState(pDownloadState)
      => ComCall(25, this.p, UInt32.Ptr, pDownloadState)
    set_DownloadState(ulDownloadState)
      => ComCall(26, this.p, UInt32, ulDownloadState)
}
struct IPMLiveTileJobInfoEnumerator extends IUnknown {
    static IID := "{BC042582-9415-4F36-9F99-06F104C07C03}"
    get_Next(ppLiveTileJobInfo)
      => ComCall(3, this.p, IPMLiveTileJobInfo.Ptr, ppLiveTileJobInfo)
}
struct IPMDeploymentManager extends IUnknown {
    static IID := "{35F785FA-1979-4A8B-BC8F-FD70EB0D1544}"
    ReportDownloadBegin(productID)
      => ComCall(3, this.p, GUID, productID)
    ReportDownloadProgress(productID, usProgress)
      => ComCall(4, this.p, GUID, productID, UInt16, usProgress)
    ReportDownloadComplete(productID, hrResult)
      => ComCall(5, this.p, GUID, productID, HRESULT, hrResult)
    BeginInstall(pInstallInfo)
      => ComCall(6, this.p, PM_INSTALLINFO.Ptr, pInstallInfo)
    BeginUpdate(pUpdateInfo)
      => ComCall(7, this.p, PM_UPDATEINFO.Ptr, pUpdateInfo)
    BeginDeployPackage(pInstallInfo)
      => ComCall(8, this.p, PM_INSTALLINFO.Ptr, pInstallInfo)
    BeginUpdateDeployedPackageLegacy(pUpdateInfo)
      => ComCall(9, this.p, PM_UPDATEINFO_LEGACY.Ptr, pUpdateInfo)
    BeginUninstall(productID)
      => ComCall(10, this.p, GUID, productID)
    BeginEnterpriseAppInstall(pInstallInfo)
      => ComCall(11, this.p, PM_INSTALLINFO.Ptr, pInstallInfo)
    BeginEnterpriseAppUpdate(pUpdateInfo)
      => ComCall(12, this.p, PM_UPDATEINFO.Ptr, pUpdateInfo)
    BeginUpdateLicense(productID, offerID, pbLicense)
      => ComCall(13, this.p, GUID, productID, GUID, offerID, UInt8.Ptr, pbLicense, UInt32, pbLicense.Length)
    GetLicenseChallenge(PackagePath, ppbChallenge, pcbChallenge, ppbKID?, ppbDeviceID?, ppbSaltValue?, ppbKGVValue?)
      => ComCall(14, this.p, BSTR, PackagePath, UInt8.Ptr.Ptr, ppbChallenge, UInt32.Ptr, pcbChallenge, UInt8.Ptr.Ptr, ppbKID?, UInt32.Ptr, ppbKID?.Length ?? 0, UInt8.Ptr.Ptr, ppbDeviceID?, UInt32.Ptr, ppbDeviceID?.Length ?? 0, UInt8.Ptr.Ptr, ppbSaltValue?, UInt32.Ptr, ppbSaltValue?.Length ?? 0, UInt8.Ptr.Ptr, ppbKGVValue?, UInt32.Ptr, ppbKGVValue?.Length ?? 0)
    GetLicenseChallengeByProductID(ProductID, ppbChallenge, pcbLicense)
      => ComCall(15, this.p, GUID, ProductID, UInt8.Ptr.Ptr, ppbChallenge, UInt32.Ptr, pcbLicense)
    GetLicenseChallengeByProductID2(ProductID, ppbChallenge, pcbLicense, ppbKID?, ppbDeviceID?, ppbSaltValue?, ppbKGVValue?)
      => ComCall(16, this.p, GUID, ProductID, UInt8.Ptr.Ptr, ppbChallenge, UInt32.Ptr, pcbLicense, UInt8.Ptr.Ptr, ppbKID?, UInt32.Ptr, ppbKID?.Length ?? 0, UInt8.Ptr.Ptr, ppbDeviceID?, UInt32.Ptr, ppbDeviceID?.Length ?? 0, UInt8.Ptr.Ptr, ppbSaltValue?, UInt32.Ptr, ppbSaltValue?.Length ?? 0, UInt8.Ptr.Ptr, ppbKGVValue?, UInt32.Ptr, ppbKGVValue?.Length ?? 0)
    RevokeLicense(productID)
      => ComCall(17, this.p, GUID, productID)
    RebindMdilBinaries(ProductID, FileNames)
      => ComCall(18, this.p, GUID, ProductID, SAFEARRAY.Ptr, FileNames)
    RebindAllMdilBinaries(ProductID, InstanceID)
      => ComCall(19, this.p, GUID, ProductID, GUID, InstanceID)
    RegenerateXbf(ProductID, AssemblyPaths)
      => ComCall(20, this.p, GUID, ProductID, SAFEARRAY.Ptr, AssemblyPaths)
    GenerateXbfForCurrentLocale(ProductID)
      => ComCall(21, this.p, GUID, ProductID)
    BeginProvision(ProductID, XMLpath)
      => ComCall(22, this.p, GUID, ProductID, BSTR, XMLpath)
    BeginDeprovision(ProductID)
      => ComCall(23, this.p, GUID, ProductID)
    ReindexSQLCEDatabases(ProductID)
      => ComCall(24, this.p, GUID, ProductID)
    SetApplicationsNeedMaintenance(RequiredMaintenanceOperations, pcApplications)
      => ComCall(25, this.p, UInt32, RequiredMaintenanceOperations, UInt32.Ptr, pcApplications)
    UpdateChamberProfile(ProductID)
      => ComCall(26, this.p, GUID, ProductID)
    EnterprisePolicyIsApplicationAllowed(productId, publisherName, pIsAllowed)
      => ComCall(27, this.p, GUID, productId, "Str", publisherName, BOOL.Ptr, pIsAllowed)
    BeginUpdateDeployedPackage(pUpdateInfo)
      => ComCall(28, this.p, PM_UPDATEINFO.Ptr, pUpdateInfo)
    ReportRestoreCancelled(productID)
      => ComCall(29, this.p, GUID, productID)
    ResolveResourceString(resourceString, pResolvedResourceString)
      => ComCall(30, this.p, "Str", resourceString, BSTR.Ptr, pResolvedResourceString)
    UpdateCapabilitiesForModernApps()
      => ComCall(31, this.p)
    ReportDownloadStatusUpdate(productId)
      => ComCall(32, this.p, GUID, productId)
    BeginUninstallWithOptions(productID, removalOptions)
      => ComCall(33, this.p, GUID, productID, UInt32, removalOptions)
    BindDeferredMdilBinaries()
      => ComCall(34, this.p)
    GenerateXamlLightupXbfForCurrentLocale(PackageFamilyName)
      => ComCall(35, this.p, BSTR, PackageFamilyName)
    AddLicenseForAppx(productID, pbLicense, pbPlayReadyHeader?)
      => ComCall(36, this.p, GUID, productID, UInt8.Ptr, pbLicense, UInt32, pbLicense.Length, UInt8.Ptr, pbPlayReadyHeader?, UInt32, pbPlayReadyHeader?.Length ?? 0)
    FixJunctionsForAppsOnSDCard()
      => ComCall(37, this.p)
}
struct IPMEnumerationManager extends IUnknown {
    static IID := "{698D57C2-292D-4CF3-B73C-D95A6922ED9A}"
    get_AllApplications(ppAppEnum, Filter)
      => ComCall(3, this.p, IPMApplicationInfoEnumerator.Ptr, ppAppEnum, PM_ENUM_FILTER, Filter)
    get_AllTiles(ppTileEnum, Filter)
      => ComCall(4, this.p, IPMTileInfoEnumerator.Ptr, ppTileEnum, PM_ENUM_FILTER, Filter)
    get_AllTasks(ppTaskEnum, Filter)
      => ComCall(5, this.p, IPMTaskInfoEnumerator.Ptr, ppTaskEnum, PM_ENUM_FILTER, Filter)
    get_AllExtensions(ppExtensionEnum, Filter)
      => ComCall(6, this.p, IPMExtensionInfoEnumerator.Ptr, ppExtensionEnum, PM_ENUM_FILTER, Filter)
    get_AllBackgroundServiceAgents(ppBSAEnum, Filter)
      => ComCall(7, this.p, IPMBackgroundServiceAgentInfoEnumerator.Ptr, ppBSAEnum, PM_ENUM_FILTER, Filter)
    get_AllBackgroundWorkers(ppBSWEnum, Filter)
      => ComCall(8, this.p, IPMBackgroundWorkerInfoEnumerator.Ptr, ppBSWEnum, PM_ENUM_FILTER, Filter)
    get_ApplicationInfo(ProductID, ppAppInfo)
      => ComCall(9, this.p, GUID, ProductID, IPMApplicationInfo.Ptr, ppAppInfo)
    get_TileInfo(ProductID, TileID, ppTileInfo)
      => ComCall(10, this.p, GUID, ProductID, BSTR, TileID, IPMTileInfo.Ptr, ppTileInfo)
    get_TaskInfo(ProductID, TaskID, ppTaskInfo)
      => ComCall(11, this.p, GUID, ProductID, BSTR, TaskID, IPMTaskInfo.Ptr, ppTaskInfo)
    get_TaskInfoEx(ProductID, TaskID, ppTaskInfo)
      => ComCall(12, this.p, GUID, ProductID, "Str", TaskID, IPMTaskInfo.Ptr, ppTaskInfo)
    get_BackgroundServiceAgentInfo(BSAID, ppTaskInfo)
      => ComCall(13, this.p, UInt32, BSAID, IPMBackgroundServiceAgentInfo.Ptr, ppTaskInfo)
    get_AllLiveTileJobs(ppLiveTileJobEnum)
      => ComCall(14, this.p, IPMLiveTileJobInfoEnumerator.Ptr, ppLiveTileJobEnum)
    get_LiveTileJob(ProductID, TileID, RecurrenceType, ppLiveTileJobInfo)
      => ComCall(15, this.p, GUID, ProductID, BSTR, TileID, PM_LIVETILE_RECURRENCE_TYPE, RecurrenceType, IPMLiveTileJobInfo.Ptr, ppLiveTileJobInfo)
    get_ApplicationInfoExternal(ProductID, ppAppInfo)
      => ComCall(16, this.p, GUID, ProductID, IPMApplicationInfo.Ptr, ppAppInfo)
    get_FileHandlerGenericLogo(FileType, LogoSize, pLogo)
      => ComCall(17, this.p, BSTR, FileType, PM_LOGO_SIZE, LogoSize, BSTR.Ptr, pLogo)
    get_ApplicationInfoFromAccessClaims(SysAppID0, SysAppID1, ppAppInfo)
      => ComCall(18, this.p, BSTR, SysAppID0, BSTR, SysAppID1, IPMApplicationInfo.Ptr, ppAppInfo)
    get_StartTileEnumeratorBlob(Filter, pcTiles, ppTileBlobs)
      => ComCall(19, this.p, PM_ENUM_FILTER, Filter, UInt32.Ptr, pcTiles, PM_STARTTILEBLOB.Ptr.Ptr, ppTileBlobs)
    get_StartAppEnumeratorBlob(Filter, pcApps, ppAppBlobs)
      => ComCall(20, this.p, PM_ENUM_FILTER, Filter, UInt32.Ptr, pcApps, PM_STARTAPPBLOB.Ptr.Ptr, ppAppBlobs)
}
struct IPMTaskInfo extends IUnknown {
    static IID := "{BF1D8C33-1BF5-4EE0-B549-6B9DD3834942}"
    get_ProductID(pProductID)
      => ComCall(3, this.p, GUID.Ptr, pProductID)
    get_TaskID(pTaskID)
      => ComCall(4, this.p, BSTR.Ptr, pTaskID)
    get_NavigationPage(pNavigationPage)
      => ComCall(5, this.p, BSTR.Ptr, pNavigationPage)
    get_TaskTransition(pTaskTransition)
      => ComCall(6, this.p, PM_TASK_TRANSITION.Ptr, pTaskTransition)
    get_RuntimeType(pRuntimetype)
      => ComCall(7, this.p, PACKMAN_RUNTIME.Ptr, pRuntimetype)
    get_ActivationPolicy(pActivationPolicy)
      => ComCall(8, this.p, PM_ACTIVATION_POLICY.Ptr, pActivationPolicy)
    get_TaskType(pTaskType)
      => ComCall(9, this.p, PM_TASK_TYPE.Ptr, pTaskType)
    get_InvocationInfo(pImageUrn, pParameters)
      => ComCall(10, this.p, BSTR.Ptr, pImageUrn, BSTR.Ptr, pParameters)
    get_ImagePath(pImagePath)
      => ComCall(11, this.p, BSTR.Ptr, pImagePath)
    get_ImageParams(pImageParams)
      => ComCall(12, this.p, BSTR.Ptr, pImageParams)
    get_InstallRootFolder(pInstallRootFolder)
      => ComCall(13, this.p, BSTR.Ptr, pInstallRootFolder)
    get_DataRootFolder(pDataRootFolder)
      => ComCall(14, this.p, BSTR.Ptr, pDataRootFolder)
    get_IsSingleInstanceHost(pIsSingleInstanceHost)
      => ComCall(15, this.p, BOOL.Ptr, pIsSingleInstanceHost)
    get_IsInteropEnabled(pIsInteropEnabled)
      => ComCall(16, this.p, BOOL.Ptr, pIsInteropEnabled)
    get_ApplicationState(pApplicationState)
      => ComCall(17, this.p, PM_APPLICATION_STATE.Ptr, pApplicationState)
    get_InstallType(pInstallType)
      => ComCall(18, this.p, PM_APPLICATION_INSTALL_TYPE.Ptr, pInstallType)
    get_Version(pTargetMajorVersion, pTargetMinorVersion)
      => ComCall(19, this.p, UInt8.Ptr, pTargetMajorVersion, UInt8.Ptr, pTargetMinorVersion)
    get_BitsPerPixel(pBitsPerPixel)
      => ComCall(20, this.p, UInt16.Ptr, pBitsPerPixel)
    get_SuppressesDehydration(pSuppressesDehydration)
      => ComCall(21, this.p, BOOL.Ptr, pSuppressesDehydration)
    get_BackgroundExecutionAbilities(pBackgroundExecutionAbilities)
      => ComCall(22, this.p, BSTR.Ptr, pBackgroundExecutionAbilities)
    get_IsOptedForExtendedMem(pIsOptedIn)
      => ComCall(23, this.p, BOOL.Ptr, pIsOptedIn)
}
struct IPMTaskInfoEnumerator extends IUnknown {
    static IID := "{0630B0F8-0BBC-4821-BE74-C7995166ED2A}"
    get_Next(ppTaskInfo)
      => ComCall(3, this.p, IPMTaskInfo.Ptr, ppTaskInfo)
}
struct IPMExtensionInfo extends IUnknown {
    static IID := "{49ACDE79-9788-4D0A-8AA0-1746AFDB9E9D}"
    get_SupplierPID(pSupplierPID)
      => ComCall(3, this.p, GUID.Ptr, pSupplierPID)
    get_SupplierTaskID(pSupplierTID)
      => ComCall(4, this.p, BSTR.Ptr, pSupplierTID)
    get_Title(pTitle)
      => ComCall(5, this.p, BSTR.Ptr, pTitle)
    get_IconPath(pIconPath)
      => ComCall(6, this.p, BSTR.Ptr, pIconPath)
    get_ExtraFile(pFilePath)
      => ComCall(7, this.p, BSTR.Ptr, pFilePath)
    get_InvocationInfo(pImageUrn, pParameters)
      => ComCall(8, this.p, BSTR.Ptr, pImageUrn, BSTR.Ptr, pParameters)
}
struct IPMExtensionFileExtensionInfo extends IUnknown {
    static IID := "{6B87CB6C-0B88-4989-A4EC-033714F710D4}"
    get_Name(pName)
      => ComCall(3, this.p, BSTR.Ptr, pName)
    get_DisplayName(pDisplayName)
      => ComCall(4, this.p, BSTR.Ptr, pDisplayName)
    get_Logo(LogoSize, pLogo)
      => ComCall(5, this.p, PM_LOGO_SIZE, LogoSize, BSTR.Ptr, pLogo)
    get_ContentType(FileType, pContentType)
      => ComCall(6, this.p, BSTR, FileType, BSTR.Ptr, pContentType)
    get_FileType(ContentType, pFileType)
      => ComCall(7, this.p, BSTR, ContentType, BSTR.Ptr, pFileType)
    get_InvocationInfo(pImageUrn, pParameters)
      => ComCall(8, this.p, BSTR.Ptr, pImageUrn, BSTR.Ptr, pParameters)
    get_AllFileTypes(pcbTypes, ppTypes)
      => ComCall(9, this.p, UInt32.Ptr, pcbTypes, BSTR.Ptr.Ptr, ppTypes)
}
struct IPMExtensionProtocolInfo extends IUnknown {
    static IID := "{1E3FA036-51EB-4453-BAFF-B8D8E4B46C8E}"
    get_Protocol(pProtocol)
      => ComCall(3, this.p, BSTR.Ptr, pProtocol)
    get_InvocationInfo(pImageUrn, pParameters)
      => ComCall(4, this.p, BSTR.Ptr, pImageUrn, BSTR.Ptr, pParameters)
}
struct IPMExtensionShareTargetInfo extends IUnknown {
    static IID := "{5471F48B-C65C-4656-8C70-242E31195FEA}"
    get_AllFileTypes(pcTypes, ppTypes)
      => ComCall(3, this.p, UInt32.Ptr, pcTypes, BSTR.Ptr.Ptr, ppTypes)
    get_AllDataFormats(pcDataFormats, ppDataFormats)
      => ComCall(4, this.p, UInt32.Ptr, pcDataFormats, BSTR.Ptr.Ptr, ppDataFormats)
    get_SupportsAllFileTypes(pSupportsAllTypes)
      => ComCall(5, this.p, BOOL.Ptr, pSupportsAllTypes)
}
struct IPMExtensionContractInfo extends IUnknown {
    static IID := "{E5666373-7BA1-467C-B819-B175DB1C295B}"
    get_InvocationInfo(pAUMID, pArgs)
      => ComCall(3, this.p, BSTR.Ptr, pAUMID, BSTR.Ptr, pArgs)
}
struct IPMExtensionFileOpenPickerInfo extends IUnknown {
    static IID := "{6DC91D25-9606-420C-9A78-E034A3418345}"
    get_AllFileTypes(pcTypes, ppTypes)
      => ComCall(3, this.p, UInt32.Ptr, pcTypes, BSTR.Ptr.Ptr, ppTypes)
    get_SupportsAllFileTypes(pSupportsAllTypes)
      => ComCall(4, this.p, BOOL.Ptr, pSupportsAllTypes)
}
struct IPMExtensionFileSavePickerInfo extends IUnknown {
    static IID := "{38005CBA-F81A-493E-A0F8-922C8680DA43}"
    get_AllFileTypes(pcTypes, ppTypes)
      => ComCall(3, this.p, UInt32.Ptr, pcTypes, BSTR.Ptr.Ptr, ppTypes)
    get_SupportsAllFileTypes(pSupportsAllTypes)
      => ComCall(4, this.p, BOOL.Ptr, pSupportsAllTypes)
}
struct IPMExtensionCachedFileUpdaterInfo extends IUnknown {
    static IID := "{E2D77509-4E58-4BA9-AF7E-B642E370E1B0}"
    get_SupportsUpdates(pSupportsUpdates)
      => ComCall(3, this.p, BOOL.Ptr, pSupportsUpdates)
}
struct IPMExtensionInfoEnumerator extends IUnknown {
    static IID := "{403B9E82-1171-4573-8E6F-6F33F39B83DD}"
    get_Next(ppExtensionInfo)
      => ComCall(3, this.p, IPMExtensionInfo.Ptr, ppExtensionInfo)
}
struct IPMBackgroundServiceAgentInfo extends IUnknown {
    static IID := "{3A8B46DA-928C-4879-998C-09DC96F3D490}"
    get_ProductID(pProductID)
      => ComCall(3, this.p, GUID.Ptr, pProductID)
    get_TaskID(pTaskID)
      => ComCall(4, this.p, BSTR.Ptr, pTaskID)
    get_BSAID(pBSAID)
      => ComCall(5, this.p, UInt32.Ptr, pBSAID)
    get_BGSpecifier(pBGSpecifier)
      => ComCall(6, this.p, BSTR.Ptr, pBGSpecifier)
    get_BGName(pBGName)
      => ComCall(7, this.p, BSTR.Ptr, pBGName)
    get_BGSource(pBGSource)
      => ComCall(8, this.p, BSTR.Ptr, pBGSource)
    get_BGType(pBGType)
      => ComCall(9, this.p, BSTR.Ptr, pBGType)
    get_IsPeriodic(pIsPeriodic)
      => ComCall(10, this.p, BOOL.Ptr, pIsPeriodic)
    get_IsScheduled(pIsScheduled)
      => ComCall(11, this.p, BOOL.Ptr, pIsScheduled)
    get_IsScheduleAllowed(pIsScheduleAllowed)
      => ComCall(12, this.p, BOOL.Ptr, pIsScheduleAllowed)
    get_Description(pDescription)
      => ComCall(13, this.p, BSTR.Ptr, pDescription)
    get_IsLaunchOnBoot(pLaunchOnBoot)
      => ComCall(14, this.p, BOOL.Ptr, pLaunchOnBoot)
    set_IsScheduled(IsScheduled)
      => ComCall(15, this.p, BOOL, IsScheduled)
    set_IsScheduleAllowed(IsScheduleAllowed)
      => ComCall(16, this.p, BOOL, IsScheduleAllowed)
}
struct IPMBackgroundWorkerInfo extends IUnknown {
    static IID := "{7DD4531B-D3BF-4B6B-94F3-69C098B1497D}"
    get_ProductID(pProductID)
      => ComCall(3, this.p, GUID.Ptr, pProductID)
    get_TaskID(pTaskID)
      => ComCall(4, this.p, BSTR.Ptr, pTaskID)
    get_BGName(pBGName)
      => ComCall(5, this.p, BSTR.Ptr, pBGName)
    get_MaxStartupLatency(pMaxStartupLatency)
      => ComCall(6, this.p, UInt32.Ptr, pMaxStartupLatency)
    get_ExpectedRuntime(pExpectedRuntime)
      => ComCall(7, this.p, UInt32.Ptr, pExpectedRuntime)
    get_IsBootWorker(pIsBootWorker)
      => ComCall(8, this.p, BOOL.Ptr, pIsBootWorker)
}
struct IPMBackgroundServiceAgentInfoEnumerator extends IUnknown {
    static IID := "{18EB2072-AB56-43B3-872C-BEAFB7A6B391}"
    get_Next(ppBSAInfo)
      => ComCall(3, this.p, IPMBackgroundServiceAgentInfo.Ptr, ppBSAInfo)
}
struct IPMBackgroundWorkerInfoEnumerator extends IUnknown {
    static IID := "{87F479F8-90D8-4EC7-92B9-72787E2F636B}"
    get_Next(ppBWInfo)
      => ComCall(3, this.p, IPMBackgroundWorkerInfo.Ptr, ppBWInfo)
}
struct PPATCH_PROGRESS_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, UInt32, BOOL]
}
struct PPATCH_SYMLOAD_CALLBACK extends FunctionPointer {
    static Types := [UInt32, PSTR, UInt32, UInt32, UInt32, UInt32, UInt32, Struct.Ptr, BOOL]
}
struct PATCH_IGNORE_RANGE {
    OffsetInOldFile : UInt32
    LengthInBytes : UInt32
}
struct PATCH_RETAIN_RANGE {
    OffsetInOldFile : UInt32
    LengthInBytes : UInt32
    OffsetInNewFile : UInt32
}
struct PATCH_OLD_FILE_INFO_A {
    SizeOfThisStruct : UInt32
    OldFileName : PSTR
    IgnoreRangeCount : UInt32
    IgnoreRangeArray : PATCH_IGNORE_RANGE.Ptr
    RetainRangeCount : UInt32
    RetainRangeArray : PATCH_RETAIN_RANGE.Ptr
}
struct PATCH_OLD_FILE_INFO_W {
    SizeOfThisStruct : UInt32
    OldFileName : PWSTR
    IgnoreRangeCount : UInt32
    IgnoreRangeArray : PATCH_IGNORE_RANGE.Ptr
    RetainRangeCount : UInt32
    RetainRangeArray : PATCH_RETAIN_RANGE.Ptr
}
struct PATCH_OLD_FILE_INFO_H {
    SizeOfThisStruct : UInt32
    OldFileHandle : HANDLE
    IgnoreRangeCount : UInt32
    IgnoreRangeArray : PATCH_IGNORE_RANGE.Ptr
    RetainRangeCount : UInt32
    RetainRangeArray : PATCH_RETAIN_RANGE.Ptr
}
struct PATCH_OLD_FILE_INFO {
    SizeOfThisStruct : UInt32
    Anonymous : this._Anonymous_e__Union
    IgnoreRangeCount : UInt32
    IgnoreRangeArray : PATCH_IGNORE_RANGE.Ptr
    RetainRangeCount : UInt32
    RetainRangeArray : PATCH_RETAIN_RANGE.Ptr
    struct _Anonymous_e__Union {
        union {
            OldFileNameA : PSTR
            OldFileNameW : PWSTR
            OldFileHandle : HANDLE
        }
    }
}
struct PATCH_INTERLEAVE_MAP {
    CountRanges : UInt32
    Range : this._Anonymous_e__Struct[1]
    struct _Anonymous_e__Struct {
        OldOffset : UInt32
        OldLength : UInt32
        NewLength : UInt32
    }
}
struct PATCH_OPTION_DATA {
    SizeOfThisStruct : UInt32
    SymbolOptionFlags : UInt32
    NewFileSymbolPath : PSTR
    OldFileSymbolPathArray : PSTR.Ptr
    ExtendedOptionFlags : UInt32
    SymLoadCallback : PPATCH_SYMLOAD_CALLBACK
    SymLoadContext : Struct.Ptr
    InterleaveMapArray : PATCH_INTERLEAVE_MAP.Ptr.Ptr
    MaxLzxWindowSize : UInt32
}
struct DELTA_INPUT {
    Anonymous : this._Anonymous_e__Union
    uSize : IntPtr
    Editable : BOOL
    struct _Anonymous_e__Union {
        union {
            lpcStart : Struct.Ptr
            lpStart : Struct.Ptr
        }
    }
}
struct DELTA_OUTPUT {
    lpStart : Struct.Ptr
    uSize : IntPtr
}
struct DELTA_HASH {
    HashSize : UInt32
    HashValue : UInt8[32]
}
struct DELTA_HEADER_INFO {
    FileTypeSet : Int64
    FileType : Int64
    Flags : Int64
    TargetSize : IntPtr
    TargetFileTime : FILETIME
    TargetHashAlgId : ALG_ID
    TargetHash : DELTA_HASH
}
struct ACTIVATION_CONTEXT_QUERY_INDEX {
    ulAssemblyIndex : UInt32
    ulFileIndexInAssembly : UInt32
}
struct ASSEMBLY_FILE_DETAILED_INFORMATION {
    ulFlags : UInt32
    ulFilenameLength : UInt32
    ulPathLength : UInt32
    lpFileName : PWSTR
    lpFilePath : PWSTR
}
struct ACTIVATION_CONTEXT_ASSEMBLY_DETAILED_INFORMATION {
    ulFlags : UInt32
    ulEncodedAssemblyIdentityLength : UInt32
    ulManifestPathType : UInt32
    ulManifestPathLength : UInt32
    liManifestLastWriteTime : Int64
    ulPolicyPathType : UInt32
    ulPolicyPathLength : UInt32
    liPolicyLastWriteTime : Int64
    ulMetadataSatelliteRosterIndex : UInt32
    ulManifestVersionMajor : UInt32
    ulManifestVersionMinor : UInt32
    ulPolicyVersionMajor : UInt32
    ulPolicyVersionMinor : UInt32
    ulAssemblyDirectoryNameLength : UInt32
    lpAssemblyEncodedAssemblyIdentity : PWSTR
    lpAssemblyManifestPath : PWSTR
    lpAssemblyPolicyPath : PWSTR
    lpAssemblyDirectoryName : PWSTR
    ulFileCount : UInt32
}
struct ACTCTX_REQUESTED_RUN_LEVEL extends Int32 {
    static ACTCTX_RUN_LEVEL_UNSPECIFIED := 0
    static ACTCTX_RUN_LEVEL_AS_INVOKER := 1
    static ACTCTX_RUN_LEVEL_HIGHEST_AVAILABLE := 2
    static ACTCTX_RUN_LEVEL_REQUIRE_ADMIN := 3
    static ACTCTX_RUN_LEVEL_NUMBERS := 4
}
struct ACTIVATION_CONTEXT_RUN_LEVEL_INFORMATION {
    ulFlags : UInt32
    RunLevel : ACTCTX_REQUESTED_RUN_LEVEL
    UiAccess : UInt32
}
struct ACTCTX_COMPATIBILITY_ELEMENT_TYPE extends Int32 {
    static ACTCTX_COMPATIBILITY_ELEMENT_TYPE_UNKNOWN := 0
    static ACTCTX_COMPATIBILITY_ELEMENT_TYPE_OS := 1
    static ACTCTX_COMPATIBILITY_ELEMENT_TYPE_MITIGATION := 2
    static ACTCTX_COMPATIBILITY_ELEMENT_TYPE_MAXVERSIONTESTED := 3
}
struct COMPATIBILITY_CONTEXT_ELEMENT {
    Id : GUID
    Type : ACTCTX_COMPATIBILITY_ELEMENT_TYPE
    MaxVersionTested : Int64
}
struct ACTIVATION_CONTEXT_COMPATIBILITY_INFORMATION {
    ElementCount : UInt32
    Elements : COMPATIBILITY_CONTEXT_ELEMENT[1]
}
struct ACTIVATION_CONTEXT_DETAILED_INFORMATION {
    dwFlags : UInt32
    ulFormatVersion : UInt32
    ulAssemblyCount : UInt32
    ulRootManifestPathType : UInt32
    ulRootManifestPathChars : UInt32
    ulRootConfigurationPathType : UInt32
    ulRootConfigurationPathChars : UInt32
    ulAppDirPathType : UInt32
    ulAppDirPathChars : UInt32
    lpRootManifestPath : PWSTR
    lpRootConfigurationPath : PWSTR
    lpAppDirPath : PWSTR
}
struct ACTCTXA {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    lpSource : PSTR
    wProcessorArchitecture : UInt16
    wLangId : UInt16
    lpAssemblyDirectory : PSTR
    lpResourceName : PSTR
    lpApplicationName : PSTR
    hModule : HMODULE
}
struct ACTCTXW {
    cbSize : UInt32 := this.Size
    dwFlags : UInt32
    lpSource : PWSTR
    wProcessorArchitecture : UInt16
    wLangId : UInt16
    lpAssemblyDirectory : PWSTR
    lpResourceName : PWSTR
    lpApplicationName : PWSTR
    hModule : HMODULE
}
struct ACTCTX_SECTION_KEYED_DATA {
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
    ulFlags : UInt32
    AssemblyMetadata : ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA
}
