#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HANDLE, HANDLE_PTR, HRESULT, HWND, PSTR, PWSTR, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {DISPPARAMS, EXCEPINFO, IDispatch, ITypeInfo, IUnknown, TYPEDESC}
#Import "..\System.Diagnostics.Debug\Types.ahk" {IDebugProperty}
#Import "..\System.Variant\Types.ahk" {VARENUM, VARIANT}

struct SCRIPTLANGUAGEVERSION extends Int32 {
    static SCRIPTLANGUAGEVERSION_DEFAULT := 0
    static SCRIPTLANGUAGEVERSION_5_7 := 1
    static SCRIPTLANGUAGEVERSION_5_8 := 2
    static SCRIPTLANGUAGEVERSION_MAX := 255
}
struct SCRIPTSTATE extends Int32 {
    static SCRIPTSTATE_UNINITIALIZED := 0
    static SCRIPTSTATE_INITIALIZED := 5
    static SCRIPTSTATE_STARTED := 1
    static SCRIPTSTATE_CONNECTED := 2
    static SCRIPTSTATE_DISCONNECTED := 3
    static SCRIPTSTATE_CLOSED := 4
}
struct SCRIPTTRACEINFO extends Int32 {
    static SCRIPTTRACEINFO_SCRIPTSTART := 0
    static SCRIPTTRACEINFO_SCRIPTEND := 1
    static SCRIPTTRACEINFO_COMCALLSTART := 2
    static SCRIPTTRACEINFO_COMCALLEND := 3
    static SCRIPTTRACEINFO_CREATEOBJSTART := 4
    static SCRIPTTRACEINFO_CREATEOBJEND := 5
    static SCRIPTTRACEINFO_GETOBJSTART := 6
    static SCRIPTTRACEINFO_GETOBJEND := 7
}
struct SCRIPTTHREADSTATE extends Int32 {
    static SCRIPTTHREADSTATE_NOTINSCRIPT := 0
    static SCRIPTTHREADSTATE_RUNNING := 1
}
struct SCRIPTGCTYPE extends Int32 {
    static SCRIPTGCTYPE_NORMAL := 0
    static SCRIPTGCTYPE_EXHAUSTIVE := 1
}
struct SCRIPTUICITEM extends Int32 {
    static SCRIPTUICITEM_INPUTBOX := 1
    static SCRIPTUICITEM_MSGBOX := 2
}
struct SCRIPTUICHANDLING extends Int32 {
    static SCRIPTUICHANDLING_ALLOW := 0
    static SCRIPTUICHANDLING_NOUIERROR := 1
    static SCRIPTUICHANDLING_NOUIDEFAULT := 2
}
struct IActiveScriptSite extends IUnknown {
    static IID := "{DB01A1E3-A42B-11CF-8F20-00805F2CD064}"
    GetLCID(plcid)
      => ComCall(3, this.p, UInt32.Ptr, plcid)
    GetItemInfo(pstrName, dwReturnMask, ppiunkItem, ppti)
      => ComCall(4, this.p, "Str", pstrName, UInt32, dwReturnMask, IUnknown.Ptr, ppiunkItem, ITypeInfo.Ptr, ppti)
    GetDocVersionString(pbstrVersion)
      => ComCall(5, this.p, BSTR.Ptr, pbstrVersion)
    OnScriptTerminate(pvarResult, pexcepinfo)
      => ComCall(6, this.p, VARIANT.Ptr, pvarResult, EXCEPINFO.Ptr, pexcepinfo)
    OnStateChange(ssScriptState)
      => ComCall(7, this.p, SCRIPTSTATE, ssScriptState)
    OnScriptError(pscripterror)
      => ComCall(8, this.p, IActiveScriptError, pscripterror)
    OnEnterScript()
      => ComCall(9, this.p)
    OnLeaveScript()
      => ComCall(10, this.p)
}
struct IActiveScriptError extends IUnknown {
    static IID := "{EAE1BA61-A4ED-11CF-8F20-00805F2CD064}"
    GetExceptionInfo(pexcepinfo)
      => ComCall(3, this.p, EXCEPINFO.Ptr, pexcepinfo)
    GetSourcePosition(pdwSourceContext, pulLineNumber, plCharacterPosition)
      => ComCall(4, this.p, UInt32.Ptr, pdwSourceContext, UInt32.Ptr, pulLineNumber, Int32.Ptr, plCharacterPosition)
    GetSourceLineText(pbstrSourceLine)
      => ComCall(5, this.p, BSTR.Ptr, pbstrSourceLine)
}
struct IActiveScriptError64 extends IActiveScriptError {
    static IID := "{B21FB2A1-5B8F-4963-8C21-21450F84ED7F}"
    GetSourcePosition64(pdwSourceContext, pulLineNumber, plCharacterPosition)
      => ComCall(6, this.p, Int64.Ptr, pdwSourceContext, UInt32.Ptr, pulLineNumber, Int32.Ptr, plCharacterPosition)
}
struct IActiveScriptSiteWindow extends IUnknown {
    static IID := "{D10F6761-83E9-11CF-8F20-00805F2CD064}"
    GetWindow(phwnd)
      => ComCall(3, this.p, HWND.Ptr, phwnd)
    EnableModeless(fEnable)
      => ComCall(4, this.p, BOOL, fEnable)
}
struct IActiveScriptSiteUIControl extends IUnknown {
    static IID := "{AEDAE97E-D7EE-4796-B960-7F092AE844AB}"
    GetUIBehavior(UicItem, pUicHandling)
      => ComCall(3, this.p, SCRIPTUICITEM, UicItem, SCRIPTUICHANDLING.Ptr, pUicHandling)
}
struct IActiveScriptSiteInterruptPoll extends IUnknown {
    static IID := "{539698A0-CDCA-11CF-A5EB-00AA0047A063}"
    QueryContinue()
      => ComCall(3, this.p)
}
struct IActiveScript extends IUnknown {
    static IID := "{BB1A2AE1-A4F9-11CF-8F20-00805F2CD064}"
    SetScriptSite(pass)
      => ComCall(3, this.p, IActiveScriptSite, pass)
    GetScriptSite(riid, ppvObject)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvObject)
    SetScriptState(ss)
      => ComCall(5, this.p, SCRIPTSTATE, ss)
    GetScriptState(pssState)
      => ComCall(6, this.p, SCRIPTSTATE.Ptr, pssState)
    Close()
      => ComCall(7, this.p)
    AddNamedItem(pstrName, dwFlags)
      => ComCall(8, this.p, "Str", pstrName, UInt32, dwFlags)
    AddTypeLib(rguidTypeLib, dwMajor, dwMinor, dwFlags)
      => ComCall(9, this.p, GUID.Ptr, rguidTypeLib, UInt32, dwMajor, UInt32, dwMinor, UInt32, dwFlags)
    GetScriptDispatch(pstrItemName, ppdisp)
      => ComCall(10, this.p, "Str", pstrItemName, IDispatch.Ptr, ppdisp)
    GetCurrentScriptThreadID(pstidThread)
      => ComCall(11, this.p, UInt32.Ptr, pstidThread)
    GetScriptThreadID(dwWin32ThreadId, pstidThread)
      => ComCall(12, this.p, UInt32, dwWin32ThreadId, UInt32.Ptr, pstidThread)
    GetScriptThreadState(stidThread, pstsState)
      => ComCall(13, this.p, UInt32, stidThread, SCRIPTTHREADSTATE.Ptr, pstsState)
    InterruptScriptThread(stidThread, pexcepinfo, dwFlags)
      => ComCall(14, this.p, UInt32, stidThread, EXCEPINFO.Ptr, pexcepinfo, UInt32, dwFlags)
    Clone(ppscript)
      => ComCall(15, this.p, IActiveScript.Ptr, ppscript)
}
struct IActiveScriptParse32 extends IUnknown {
    static IID := "{BB1A2AE2-A4F9-11CF-8F20-00805F2CD064}"
    InitNew()
      => ComCall(3, this.p)
    AddScriptlet(pstrDefaultName, pstrCode, pstrItemName, pstrSubItemName, pstrEventName, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, pbstrName, pexcepinfo)
      => ComCall(4, this.p, "Str", pstrDefaultName, "Str", pstrCode, "Str", pstrItemName, "Str", pstrSubItemName, "Str", pstrEventName, "Str", pstrDelimiter, UInt32, dwSourceContextCookie, UInt32, ulStartingLineNumber, UInt32, dwFlags, BSTR.Ptr, pbstrName, EXCEPINFO.Ptr, pexcepinfo)
    ParseScriptText(pstrCode, pstrItemName, punkContext, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, pvarResult, pexcepinfo)
      => ComCall(5, this.p, "Str", pstrCode, "Str", pstrItemName, IUnknown, punkContext, "Str", pstrDelimiter, UInt32, dwSourceContextCookie, UInt32, ulStartingLineNumber, UInt32, dwFlags, VARIANT.Ptr, pvarResult, EXCEPINFO.Ptr, pexcepinfo)
}
struct IActiveScriptParse64 extends IUnknown {
    static IID := "{C7EF7658-E1EE-480E-97EA-D52CB4D76D17}"
    InitNew()
      => ComCall(3, this.p)
    AddScriptlet(pstrDefaultName, pstrCode, pstrItemName, pstrSubItemName, pstrEventName, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, pbstrName, pexcepinfo)
      => ComCall(4, this.p, "Str", pstrDefaultName, "Str", pstrCode, "Str", pstrItemName, "Str", pstrSubItemName, "Str", pstrEventName, "Str", pstrDelimiter, Int64, dwSourceContextCookie, UInt32, ulStartingLineNumber, UInt32, dwFlags, BSTR.Ptr, pbstrName, EXCEPINFO.Ptr, pexcepinfo)
    ParseScriptText(pstrCode, pstrItemName, punkContext, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, pvarResult, pexcepinfo)
      => ComCall(5, this.p, "Str", pstrCode, "Str", pstrItemName, IUnknown, punkContext, "Str", pstrDelimiter, Int64, dwSourceContextCookie, UInt32, ulStartingLineNumber, UInt32, dwFlags, VARIANT.Ptr, pvarResult, EXCEPINFO.Ptr, pexcepinfo)
}
struct IActiveScriptParseProcedureOld32 extends IUnknown {
    static IID := "{1CFF0050-6FDD-11D0-9328-00A0C90DCAA9}"
    ParseProcedureText(pstrCode, pstrFormalParams, pstrItemName, punkContext, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, ppdisp)
      => ComCall(3, this.p, "Str", pstrCode, "Str", pstrFormalParams, "Str", pstrItemName, IUnknown, punkContext, "Str", pstrDelimiter, UInt32, dwSourceContextCookie, UInt32, ulStartingLineNumber, UInt32, dwFlags, IDispatch.Ptr, ppdisp)
}
struct IActiveScriptParseProcedureOld64 extends IUnknown {
    static IID := "{21F57128-08C9-4638-BA12-22D15D88DC5C}"
    ParseProcedureText(pstrCode, pstrFormalParams, pstrItemName, punkContext, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, ppdisp)
      => ComCall(3, this.p, "Str", pstrCode, "Str", pstrFormalParams, "Str", pstrItemName, IUnknown, punkContext, "Str", pstrDelimiter, Int64, dwSourceContextCookie, UInt32, ulStartingLineNumber, UInt32, dwFlags, IDispatch.Ptr, ppdisp)
}
struct IActiveScriptParseProcedure32 extends IUnknown {
    static IID := "{AA5B6A80-B834-11D0-932F-00A0C90DCAA9}"
    ParseProcedureText(pstrCode, pstrFormalParams, pstrProcedureName, pstrItemName, punkContext, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, ppdisp)
      => ComCall(3, this.p, "Str", pstrCode, "Str", pstrFormalParams, "Str", pstrProcedureName, "Str", pstrItemName, IUnknown, punkContext, "Str", pstrDelimiter, UInt32, dwSourceContextCookie, UInt32, ulStartingLineNumber, UInt32, dwFlags, IDispatch.Ptr, ppdisp)
}
struct IActiveScriptParseProcedure64 extends IUnknown {
    static IID := "{C64713B6-E029-4CC5-9200-438B72890B6A}"
    ParseProcedureText(pstrCode, pstrFormalParams, pstrProcedureName, pstrItemName, punkContext, pstrDelimiter, dwSourceContextCookie, ulStartingLineNumber, dwFlags, ppdisp)
      => ComCall(3, this.p, "Str", pstrCode, "Str", pstrFormalParams, "Str", pstrProcedureName, "Str", pstrItemName, IUnknown, punkContext, "Str", pstrDelimiter, Int64, dwSourceContextCookie, UInt32, ulStartingLineNumber, UInt32, dwFlags, IDispatch.Ptr, ppdisp)
}
struct IActiveScriptParseProcedure2_32 extends IActiveScriptParseProcedure32 {
    static IID := "{71EE5B20-FB04-11D1-B3A8-00A0C911E8B2}"
}
struct IActiveScriptParseProcedure2_64 extends IActiveScriptParseProcedure64 {
    static IID := "{FE7C4271-210C-448D-9F54-76DAB7047B28}"
}
struct IActiveScriptEncode extends IUnknown {
    static IID := "{BB1A2AE3-A4F9-11CF-8F20-00805F2CD064}"
    EncodeSection(pchIn, cchIn, pchOut, cchOut, pcchRet)
      => ComCall(3, this.p, "Str", pchIn, UInt32, cchIn, PWSTR, pchOut, UInt32, cchOut, UInt32.Ptr, pcchRet)
    DecodeScript(pchIn, cchIn, pchOut, cchOut, pcchRet)
      => ComCall(4, this.p, "Str", pchIn, UInt32, cchIn, PWSTR, pchOut, UInt32, cchOut, UInt32.Ptr, pcchRet)
    GetEncodeProgId(pbstrOut)
      => ComCall(5, this.p, BSTR.Ptr, pbstrOut)
}
struct IActiveScriptHostEncode extends IUnknown {
    static IID := "{BEE9B76E-CFE3-11D1-B747-00C04FC2B085}"
    EncodeScriptHostFile(bstrInFile, pbstrOutFile, cFlags, bstrDefaultLang)
      => ComCall(3, this.p, BSTR, bstrInFile, BSTR.Ptr, pbstrOutFile, UInt32, cFlags, BSTR, bstrDefaultLang)
}
struct IBindEventHandler extends IUnknown {
    static IID := "{63CDBCB0-C1B1-11D0-9336-00A0C90DCAA9}"
    BindHandler(pstrEvent, pdisp)
      => ComCall(3, this.p, "Str", pstrEvent, IDispatch, pdisp)
}
struct IActiveScriptStats extends IUnknown {
    static IID := "{B8DA6310-E19B-11D0-933C-00A0C90DCAA9}"
    GetStat(stid, pluHi, pluLo)
      => ComCall(3, this.p, UInt32, stid, UInt32.Ptr, pluHi, UInt32.Ptr, pluLo)
    GetStatEx(guid, pluHi, pluLo)
      => ComCall(4, this.p, GUID.Ptr, guid, UInt32.Ptr, pluHi, UInt32.Ptr, pluLo)
    ResetStats()
      => ComCall(5, this.p)
}
struct IActiveScriptProperty extends IUnknown {
    static IID := "{4954E0D0-FBC7-11D1-8410-006008C3FBFC}"
    GetProperty(dwProperty, pvarIndex, pvarValue)
      => ComCall(3, this.p, UInt32, dwProperty, VARIANT.Ptr, pvarIndex, VARIANT.Ptr, pvarValue)
    SetProperty(dwProperty, pvarIndex, pvarValue)
      => ComCall(4, this.p, UInt32, dwProperty, VARIANT.Ptr, pvarIndex, VARIANT.Ptr, pvarValue)
}
struct ITridentEventSink extends IUnknown {
    static IID := "{1DC9CA50-06EF-11D2-8415-006008C3FBFC}"
    FireEvent(pstrEvent, pdp, pvarRes, pei)
      => ComCall(3, this.p, "Str", pstrEvent, DISPPARAMS.Ptr, pdp, VARIANT.Ptr, pvarRes, EXCEPINFO.Ptr, pei)
}
struct IActiveScriptGarbageCollector extends IUnknown {
    static IID := "{6AA2C4A0-2B53-11D4-A2A0-00104BD35090}"
    CollectGarbage(scriptgctype1)
      => ComCall(3, this.p, SCRIPTGCTYPE, scriptgctype1)
}
struct IActiveScriptSIPInfo extends IUnknown {
    static IID := "{764651D0-38DE-11D4-A2A3-00104BD35090}"
    GetSIPOID(poid_sip)
      => ComCall(3, this.p, GUID.Ptr, poid_sip)
}
struct IActiveScriptSiteTraceInfo extends IUnknown {
    static IID := "{4B7272AE-1955-4BFE-98B0-780621888569}"
    SendScriptTraceInfo(stiEventType, guidContextID, dwScriptContextCookie, lScriptStatementStart, lScriptStatementEnd, dwReserved)
      => ComCall(3, this.p, SCRIPTTRACEINFO, stiEventType, GUID, guidContextID, UInt32, dwScriptContextCookie, Int32, lScriptStatementStart, Int32, lScriptStatementEnd, Int64, dwReserved)
}
struct IActiveScriptTraceInfo extends IUnknown {
    static IID := "{C35456E7-BEBF-4A1B-86A9-24D56BE8B369}"
    StartScriptTracing(pSiteTraceInfo, guidContextID)
      => ComCall(3, this.p, IActiveScriptSiteTraceInfo, pSiteTraceInfo, GUID, guidContextID)
    StopScriptTracing()
      => ComCall(4, this.p)
}
struct IActiveScriptStringCompare extends IUnknown {
    static IID := "{58562769-ED52-42F7-8403-4963514E1F11}"
    StrComp(bszStr1, bszStr2, iRet)
      => ComCall(3, this.p, BSTR, bszStr1, BSTR, bszStr2, Int32.Ptr, iRet)
}
struct BREAKPOINT_STATE extends Int32 {
    static BREAKPOINT_DELETED := 0
    static BREAKPOINT_DISABLED := 1
    static BREAKPOINT_ENABLED := 2
}
struct BREAKREASON extends Int32 {
    static BREAKREASON_STEP := 0
    static BREAKREASON_BREAKPOINT := 1
    static BREAKREASON_DEBUGGER_BLOCK := 2
    static BREAKREASON_HOST_INITIATED := 3
    static BREAKREASON_LANGUAGE_INITIATED := 4
    static BREAKREASON_DEBUGGER_HALT := 5
    static BREAKREASON_ERROR := 6
    static BREAKREASON_JIT := 7
    static BREAKREASON_MUTATION_BREAKPOINT := 8
}
struct BREAKRESUMEACTION extends Int32 {
    static BREAKRESUMEACTION_ABORT := 0
    static BREAKRESUMEACTION_CONTINUE := 1
    static BREAKRESUMEACTION_STEP_INTO := 2
    static BREAKRESUMEACTION_STEP_OVER := 3
    static BREAKRESUMEACTION_STEP_OUT := 4
    static BREAKRESUMEACTION_IGNORE := 5
    static BREAKRESUMEACTION_STEP_DOCUMENT := 6
}
struct ERRORRESUMEACTION extends Int32 {
    static ERRORRESUMEACTION_ReexecuteErrorStatement := 0
    static ERRORRESUMEACTION_AbortCallAndReturnErrorToCaller := 1
    static ERRORRESUMEACTION_SkipErrorStatement := 2
}
struct DOCUMENTNAMETYPE extends Int32 {
    static DOCUMENTNAMETYPE_APPNODE := 0
    static DOCUMENTNAMETYPE_TITLE := 1
    static DOCUMENTNAMETYPE_FILE_TAIL := 2
    static DOCUMENTNAMETYPE_URL := 3
    static DOCUMENTNAMETYPE_UNIQUE_TITLE := 4
    static DOCUMENTNAMETYPE_SOURCE_MAP_URL := 5
}
struct IActiveScriptDebug32 extends IUnknown {
    static IID := "{51973C10-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetScriptTextAttributes(pstrCode, pstrDelimiter, dwFlags, pattr)
      => ComCall(3, this.p, "Str", pstrCode, UInt32, pattr.Length, "Str", pstrDelimiter, UInt32, dwFlags, UInt16.Ptr, pattr)
    GetScriptletTextAttributes(pstrCode, pstrDelimiter, dwFlags, pattr)
      => ComCall(4, this.p, "Str", pstrCode, UInt32, pattr.Length, "Str", pstrDelimiter, UInt32, dwFlags, UInt16.Ptr, pattr)
    EnumCodeContextsOfPosition(dwSourceContext, uCharacterOffset, uNumChars, ppescc)
      => ComCall(5, this.p, UInt32, dwSourceContext, UInt32, uCharacterOffset, UInt32, uNumChars, IEnumDebugCodeContexts.Ptr, ppescc)
}
struct IActiveScriptDebug64 extends IUnknown {
    static IID := "{BC437E23-F5B8-47F4-BB79-7D1CE5483B86}"
    GetScriptTextAttributes(pstrCode, pstrDelimiter, dwFlags, pattr)
      => ComCall(3, this.p, "Str", pstrCode, UInt32, pattr.Length, "Str", pstrDelimiter, UInt32, dwFlags, UInt16.Ptr, pattr)
    GetScriptletTextAttributes(pstrCode, pstrDelimiter, dwFlags, pattr)
      => ComCall(4, this.p, "Str", pstrCode, UInt32, pattr.Length, "Str", pstrDelimiter, UInt32, dwFlags, UInt16.Ptr, pattr)
    EnumCodeContextsOfPosition(dwSourceContext, uCharacterOffset, uNumChars, ppescc)
      => ComCall(5, this.p, Int64, dwSourceContext, UInt32, uCharacterOffset, UInt32, uNumChars, IEnumDebugCodeContexts.Ptr, ppescc)
}
struct IActiveScriptSiteDebug32 extends IUnknown {
    static IID := "{51973C11-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetDocumentContextFromPosition(dwSourceContext, uCharacterOffset, uNumChars, ppsc)
      => ComCall(3, this.p, UInt32, dwSourceContext, UInt32, uCharacterOffset, UInt32, uNumChars, IDebugDocumentContext.Ptr, ppsc)
    GetApplication(ppda)
      => ComCall(4, this.p, IDebugApplication32.Ptr, ppda)
    GetRootApplicationNode(ppdanRoot)
      => ComCall(5, this.p, IDebugApplicationNode.Ptr, ppdanRoot)
    OnScriptErrorDebug(pErrorDebug, pfEnterDebugger, pfCallOnScriptErrorWhenContinuing)
      => ComCall(6, this.p, IActiveScriptErrorDebug, pErrorDebug, BOOL.Ptr, pfEnterDebugger, BOOL.Ptr, pfCallOnScriptErrorWhenContinuing)
}
struct IActiveScriptSiteDebug64 extends IUnknown {
    static IID := "{D6B96B0A-7463-402C-92AC-89984226942F}"
    GetDocumentContextFromPosition(dwSourceContext, uCharacterOffset, uNumChars, ppsc)
      => ComCall(3, this.p, Int64, dwSourceContext, UInt32, uCharacterOffset, UInt32, uNumChars, IDebugDocumentContext.Ptr, ppsc)
    GetApplication(ppda)
      => ComCall(4, this.p, IDebugApplication64.Ptr, ppda)
    GetRootApplicationNode(ppdanRoot)
      => ComCall(5, this.p, IDebugApplicationNode.Ptr, ppdanRoot)
    OnScriptErrorDebug(pErrorDebug, pfEnterDebugger, pfCallOnScriptErrorWhenContinuing)
      => ComCall(6, this.p, IActiveScriptErrorDebug, pErrorDebug, BOOL.Ptr, pfEnterDebugger, BOOL.Ptr, pfCallOnScriptErrorWhenContinuing)
}
struct IActiveScriptSiteDebugEx extends IUnknown {
    static IID := "{BB722CCB-6AD2-41C6-B780-AF9C03EE69F5}"
    OnCanNotJITScriptErrorDebug(pErrorDebug, pfCallOnScriptErrorWhenContinuing)
      => ComCall(3, this.p, IActiveScriptErrorDebug, pErrorDebug, BOOL.Ptr, pfCallOnScriptErrorWhenContinuing)
}
struct IActiveScriptErrorDebug extends IActiveScriptError {
    static IID := "{51973C12-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetDocumentContext(ppssc)
      => ComCall(6, this.p, IDebugDocumentContext.Ptr, ppssc)
    GetStackFrame(ppdsf)
      => ComCall(7, this.p, IDebugStackFrame.Ptr, ppdsf)
}
struct IDebugCodeContext extends IUnknown {
    static IID := "{51973C13-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetDocumentContext(ppsc)
      => ComCall(3, this.p, IDebugDocumentContext.Ptr, ppsc)
    SetBreakPoint(bps)
      => ComCall(4, this.p, BREAKPOINT_STATE, bps)
}
struct IDebugExpression extends IUnknown {
    static IID := "{51973C14-CB0C-11D0-B5C9-00A0244A0E7A}"
    Start(pdecb)
      => ComCall(3, this.p, IDebugExpressionCallBack, pdecb)
    Abort()
      => ComCall(4, this.p)
    QueryIsComplete()
      => ComCall(5, this.p)
    GetResultAsString(phrResult, pbstrResult)
      => ComCall(6, this.p, HRESULT.Ptr, phrResult, BSTR.Ptr, pbstrResult)
    GetResultAsDebugProperty(phrResult, ppdp)
      => ComCall(7, this.p, HRESULT.Ptr, phrResult, IDebugProperty.Ptr, ppdp)
}
struct IDebugExpressionContext extends IUnknown {
    static IID := "{51973C15-CB0C-11D0-B5C9-00A0244A0E7A}"
    ParseLanguageText(pstrCode, nRadix, pstrDelimiter, dwFlags, ppe)
      => ComCall(3, this.p, "Str", pstrCode, UInt32, nRadix, "Str", pstrDelimiter, UInt32, dwFlags, IDebugExpression.Ptr, ppe)
    GetLanguageInfo(pbstrLanguageName, pLanguageID)
      => ComCall(4, this.p, BSTR.Ptr, pbstrLanguageName, GUID.Ptr, pLanguageID)
}
struct IDebugExpressionCallBack extends IUnknown {
    static IID := "{51973C16-CB0C-11D0-B5C9-00A0244A0E7A}"
    onComplete()
      => ComCall(3, this.p)
}
struct IDebugStackFrame extends IUnknown {
    static IID := "{51973C17-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetCodeContext(ppcc)
      => ComCall(3, this.p, IDebugCodeContext.Ptr, ppcc)
    GetDescriptionString(fLong, pbstrDescription)
      => ComCall(4, this.p, BOOL, fLong, BSTR.Ptr, pbstrDescription)
    GetLanguageString(fLong, pbstrLanguage)
      => ComCall(5, this.p, BOOL, fLong, BSTR.Ptr, pbstrLanguage)
    GetThread(ppat)
      => ComCall(6, this.p, IDebugApplicationThread.Ptr, ppat)
    GetDebugProperty(ppDebugProp)
      => ComCall(7, this.p, IDebugProperty.Ptr, ppDebugProp)
}
struct IDebugStackFrameSniffer extends IUnknown {
    static IID := "{51973C18-CB0C-11D0-B5C9-00A0244A0E7A}"
    EnumStackFrames(ppedsf)
      => ComCall(3, this.p, IEnumDebugStackFrames.Ptr, ppedsf)
}
struct IDebugStackFrameSnifferEx32 extends IDebugStackFrameSniffer {
    static IID := "{51973C19-CB0C-11D0-B5C9-00A0244A0E7A}"
    EnumStackFramesEx32(dwSpMin, ppedsf)
      => ComCall(4, this.p, UInt32, dwSpMin, IEnumDebugStackFrames.Ptr, ppedsf)
}
struct IDebugStackFrameSnifferEx64 extends IDebugStackFrameSniffer {
    static IID := "{8CD12AF4-49C1-4D52-8D8A-C146F47581AA}"
    EnumStackFramesEx64(dwSpMin, ppedsf)
      => ComCall(4, this.p, Int64, dwSpMin, IEnumDebugStackFrames64.Ptr, ppedsf)
}
struct IDebugSyncOperation extends IUnknown {
    static IID := "{51973C1A-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetTargetThread(ppatTarget)
      => ComCall(3, this.p, IDebugApplicationThread.Ptr, ppatTarget)
    Execute(ppunkResult)
      => ComCall(4, this.p, IUnknown.Ptr, ppunkResult)
    InProgressAbort()
      => ComCall(5, this.p)
}
struct IDebugAsyncOperation extends IUnknown {
    static IID := "{51973C1B-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetSyncDebugOperation(ppsdo)
      => ComCall(3, this.p, IDebugSyncOperation.Ptr, ppsdo)
    Start(padocb)
      => ComCall(4, this.p, IDebugAsyncOperationCallBack, padocb)
    Abort()
      => ComCall(5, this.p)
    QueryIsComplete()
      => ComCall(6, this.p)
    GetResult(phrResult, ppunkResult)
      => ComCall(7, this.p, HRESULT.Ptr, phrResult, IUnknown.Ptr, ppunkResult)
}
struct IDebugAsyncOperationCallBack extends IUnknown {
    static IID := "{51973C1C-CB0C-11D0-B5C9-00A0244A0E7A}"
    onComplete()
      => ComCall(3, this.p)
}
struct IEnumDebugCodeContexts extends IUnknown {
    static IID := "{51973C1D-CB0C-11D0-B5C9-00A0244A0E7A}"
    Next(celt, pscc, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, IDebugCodeContext.Ptr, pscc, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppescc)
      => ComCall(6, this.p, IEnumDebugCodeContexts.Ptr, ppescc)
}
struct DebugStackFrameDescriptor {
    pdsf : IDebugStackFrame
    dwMin : UInt32
    dwLim : UInt32
    fFinal : BOOL
    punkFinal : IUnknown
}
struct DebugStackFrameDescriptor64 {
    pdsf : IDebugStackFrame
    dwMin : Int64
    dwLim : Int64
    fFinal : BOOL
    punkFinal : IUnknown
}
struct IEnumDebugStackFrames extends IUnknown {
    static IID := "{51973C1E-CB0C-11D0-B5C9-00A0244A0E7A}"
    Next(celt, prgdsfd, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, DebugStackFrameDescriptor.Ptr, prgdsfd, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppedsf)
      => ComCall(6, this.p, IEnumDebugStackFrames.Ptr, ppedsf)
}
struct IEnumDebugStackFrames64 extends IEnumDebugStackFrames {
    static IID := "{0DC38853-C1B0-4176-A984-B298361027AF}"
    Next64(celt, prgdsfd, pceltFetched)
      => ComCall(7, this.p, UInt32, celt, DebugStackFrameDescriptor64.Ptr, prgdsfd, UInt32.Ptr, pceltFetched)
}
struct IDebugDocumentInfo extends IUnknown {
    static IID := "{51973C1F-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetName(dnt, pbstrName)
      => ComCall(3, this.p, DOCUMENTNAMETYPE, dnt, BSTR.Ptr, pbstrName)
    GetDocumentClassId(pclsidDocument)
      => ComCall(4, this.p, GUID.Ptr, pclsidDocument)
}
struct IDebugDocumentProvider extends IDebugDocumentInfo {
    static IID := "{51973C20-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetDocument(ppssd)
      => ComCall(5, this.p, IDebugDocument.Ptr, ppssd)
}
struct IDebugDocument extends IDebugDocumentInfo {
    static IID := "{51973C21-CB0C-11D0-B5C9-00A0244A0E7A}"
}
struct IDebugDocumentText extends IDebugDocument {
    static IID := "{51973C22-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetDocumentAttributes(ptextdocattr)
      => ComCall(5, this.p, UInt32.Ptr, ptextdocattr)
    GetSize(pcNumLines, pcNumChars)
      => ComCall(6, this.p, UInt32.Ptr, pcNumLines, UInt32.Ptr, pcNumChars)
    GetPositionOfLine(cLineNumber, pcCharacterPosition)
      => ComCall(7, this.p, UInt32, cLineNumber, UInt32.Ptr, pcCharacterPosition)
    GetLineOfPosition(cCharacterPosition, pcLineNumber, pcCharacterOffsetInLine)
      => ComCall(8, this.p, UInt32, cCharacterPosition, UInt32.Ptr, pcLineNumber, UInt32.Ptr, pcCharacterOffsetInLine)
    GetText(cCharacterPosition, pcharText, pstaTextAttr?, pcNumChars)
      => ComCall(9, this.p, UInt32, cCharacterPosition, PWSTR, pcharText, UInt16.Ptr, pstaTextAttr?, UInt32.Ptr, pcNumChars, UInt32, pstaTextAttr?.Length ?? 0)
    GetPositionOfContext(psc, pcCharacterPosition, cNumChars)
      => ComCall(10, this.p, IDebugDocumentContext, psc, UInt32.Ptr, pcCharacterPosition, UInt32.Ptr, cNumChars)
    GetContextOfPosition(cCharacterPosition, cNumChars, ppsc)
      => ComCall(11, this.p, UInt32, cCharacterPosition, UInt32, cNumChars, IDebugDocumentContext.Ptr, ppsc)
}
struct IDebugDocumentTextEvents extends IUnknown {
    static IID := "{51973C23-CB0C-11D0-B5C9-00A0244A0E7A}"
    onDestroy()
      => ComCall(3, this.p)
    onInsertText(cCharacterPosition, cNumToInsert)
      => ComCall(4, this.p, UInt32, cCharacterPosition, UInt32, cNumToInsert)
    onRemoveText(cCharacterPosition, cNumToRemove)
      => ComCall(5, this.p, UInt32, cCharacterPosition, UInt32, cNumToRemove)
    onReplaceText(cCharacterPosition, cNumToReplace)
      => ComCall(6, this.p, UInt32, cCharacterPosition, UInt32, cNumToReplace)
    onUpdateTextAttributes(cCharacterPosition, cNumToUpdate)
      => ComCall(7, this.p, UInt32, cCharacterPosition, UInt32, cNumToUpdate)
    onUpdateDocumentAttributes(textdocattr)
      => ComCall(8, this.p, UInt32, textdocattr)
}
struct IDebugDocumentTextAuthor extends IDebugDocumentText {
    static IID := "{51973C24-CB0C-11D0-B5C9-00A0244A0E7A}"
    InsertText(cCharacterPosition, pcharText)
      => ComCall(12, this.p, UInt32, cCharacterPosition, UInt32, pcharText.Length, "Str", pcharText)
    RemoveText(cCharacterPosition, cNumToRemove)
      => ComCall(13, this.p, UInt32, cCharacterPosition, UInt32, cNumToRemove)
    ReplaceText(cCharacterPosition, pcharText)
      => ComCall(14, this.p, UInt32, cCharacterPosition, UInt32, pcharText.Length, "Str", pcharText)
}
struct IDebugDocumentTextExternalAuthor extends IUnknown {
    static IID := "{51973C25-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetPathName(pbstrLongName, pfIsOriginalFile)
      => ComCall(3, this.p, BSTR.Ptr, pbstrLongName, BOOL.Ptr, pfIsOriginalFile)
    GetFileName(pbstrShortName)
      => ComCall(4, this.p, BSTR.Ptr, pbstrShortName)
    NotifyChanged()
      => ComCall(5, this.p)
}
struct IDebugDocumentHelper32 extends IUnknown {
    static IID := "{51973C26-CB0C-11D0-B5C9-00A0244A0E7A}"
    Init(pda, pszShortName, pszLongName, docAttr)
      => ComCall(3, this.p, IDebugApplication32, pda, "Str", pszShortName, "Str", pszLongName, UInt32, docAttr)
    Attach(pddhParent)
      => ComCall(4, this.p, IDebugDocumentHelper32, pddhParent)
    Detach()
      => ComCall(5, this.p)
    AddUnicodeText(pszText)
      => ComCall(6, this.p, "Str", pszText)
    AddDBCSText(pszText)
      => ComCall(7, this.p, PSTR, pszText)
    SetDebugDocumentHost(pddh)
      => ComCall(8, this.p, IDebugDocumentHost, pddh)
    AddDeferredText(cChars, dwTextStartCookie)
      => ComCall(9, this.p, UInt32, cChars, UInt32, dwTextStartCookie)
    DefineScriptBlock(ulCharOffset, cChars, pas, fScriptlet, pdwSourceContext)
      => ComCall(10, this.p, UInt32, ulCharOffset, UInt32, cChars, IActiveScript, pas, BOOL, fScriptlet, UInt32.Ptr, pdwSourceContext)
    SetDefaultTextAttr(staTextAttr)
      => ComCall(11, this.p, UInt16, staTextAttr)
    SetTextAttributes(ulCharOffset, pstaTextAttr)
      => ComCall(12, this.p, UInt32, ulCharOffset, UInt32, pstaTextAttr.Length, UInt16.Ptr, pstaTextAttr)
    SetLongName(pszLongName)
      => ComCall(13, this.p, "Str", pszLongName)
    SetShortName(pszShortName)
      => ComCall(14, this.p, "Str", pszShortName)
    SetDocumentAttr(pszAttributes)
      => ComCall(15, this.p, UInt32, pszAttributes)
    GetDebugApplicationNode(ppdan)
      => ComCall(16, this.p, IDebugApplicationNode.Ptr, ppdan)
    GetScriptBlockInfo(dwSourceContext, ppasd, piCharPos, pcChars)
      => ComCall(17, this.p, UInt32, dwSourceContext, IActiveScript.Ptr, ppasd, UInt32.Ptr, piCharPos, UInt32.Ptr, pcChars)
    CreateDebugDocumentContext(iCharPos, cChars, ppddc)
      => ComCall(18, this.p, UInt32, iCharPos, UInt32, cChars, IDebugDocumentContext.Ptr, ppddc)
    BringDocumentToTop()
      => ComCall(19, this.p)
    BringDocumentContextToTop(pddc?)
      => ComCall(20, this.p, IDebugDocumentContext, pddc?)
}
struct IDebugDocumentHelper64 extends IUnknown {
    static IID := "{C4C7363C-20FD-47F9-BD82-4855E0150871}"
    Init(pda, pszShortName, pszLongName, docAttr)
      => ComCall(3, this.p, IDebugApplication64, pda, "Str", pszShortName, "Str", pszLongName, UInt32, docAttr)
    Attach(pddhParent)
      => ComCall(4, this.p, IDebugDocumentHelper64, pddhParent)
    Detach()
      => ComCall(5, this.p)
    AddUnicodeText(pszText)
      => ComCall(6, this.p, "Str", pszText)
    AddDBCSText(pszText)
      => ComCall(7, this.p, PSTR, pszText)
    SetDebugDocumentHost(pddh)
      => ComCall(8, this.p, IDebugDocumentHost, pddh)
    AddDeferredText(cChars, dwTextStartCookie)
      => ComCall(9, this.p, UInt32, cChars, UInt32, dwTextStartCookie)
    DefineScriptBlock(ulCharOffset, cChars, pas, fScriptlet, pdwSourceContext)
      => ComCall(10, this.p, UInt32, ulCharOffset, UInt32, cChars, IActiveScript, pas, BOOL, fScriptlet, Int64.Ptr, pdwSourceContext)
    SetDefaultTextAttr(staTextAttr)
      => ComCall(11, this.p, UInt16, staTextAttr)
    SetTextAttributes(ulCharOffset, pstaTextAttr)
      => ComCall(12, this.p, UInt32, ulCharOffset, UInt32, pstaTextAttr.Length, UInt16.Ptr, pstaTextAttr)
    SetLongName(pszLongName)
      => ComCall(13, this.p, "Str", pszLongName)
    SetShortName(pszShortName)
      => ComCall(14, this.p, "Str", pszShortName)
    SetDocumentAttr(pszAttributes)
      => ComCall(15, this.p, UInt32, pszAttributes)
    GetDebugApplicationNode(ppdan)
      => ComCall(16, this.p, IDebugApplicationNode.Ptr, ppdan)
    GetScriptBlockInfo(dwSourceContext, ppasd, piCharPos, pcChars)
      => ComCall(17, this.p, Int64, dwSourceContext, IActiveScript.Ptr, ppasd, UInt32.Ptr, piCharPos, UInt32.Ptr, pcChars)
    CreateDebugDocumentContext(iCharPos, cChars, ppddc)
      => ComCall(18, this.p, UInt32, iCharPos, UInt32, cChars, IDebugDocumentContext.Ptr, ppddc)
    BringDocumentToTop()
      => ComCall(19, this.p)
    BringDocumentContextToTop(pddc?)
      => ComCall(20, this.p, IDebugDocumentContext, pddc?)
}
struct IDebugDocumentHost extends IUnknown {
    static IID := "{51973C27-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetDeferredText(dwTextStartCookie, pcharText, pstaTextAttr, pcNumChars)
      => ComCall(3, this.p, UInt32, dwTextStartCookie, PWSTR, pcharText, UInt16.Ptr, pstaTextAttr, UInt32.Ptr, pcNumChars, UInt32, pstaTextAttr.Length)
    GetScriptTextAttributes(pstrCode, pstrDelimiter, dwFlags, pattr)
      => ComCall(4, this.p, "Str", pstrCode, UInt32, pattr.Length, "Str", pstrDelimiter, UInt32, dwFlags, UInt16.Ptr, pattr)
    OnCreateDocumentContext(ppunkOuter)
      => ComCall(5, this.p, IUnknown.Ptr, ppunkOuter)
    GetPathName(pbstrLongName, pfIsOriginalFile)
      => ComCall(6, this.p, BSTR.Ptr, pbstrLongName, BOOL.Ptr, pfIsOriginalFile)
    GetFileName(pbstrShortName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrShortName)
    NotifyChanged()
      => ComCall(8, this.p)
}
struct IDebugDocumentContext extends IUnknown {
    static IID := "{51973C28-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetDocument(ppsd)
      => ComCall(3, this.p, IDebugDocument.Ptr, ppsd)
    EnumCodeContexts(ppescc)
      => ComCall(4, this.p, IEnumDebugCodeContexts.Ptr, ppescc)
}
struct IDebugSessionProvider extends IUnknown {
    static IID := "{51973C29-CB0C-11D0-B5C9-00A0244A0E7A}"
    StartDebugSession(pda)
      => ComCall(3, this.p, IRemoteDebugApplication, pda)
}
struct IApplicationDebugger extends IUnknown {
    static IID := "{51973C2A-CB0C-11D0-B5C9-00A0244A0E7A}"
    QueryAlive()
      => ComCall(3, this.p)
    CreateInstanceAtDebugger(rclsid, pUnkOuter, dwClsContext, riid, ppvObject)
      => ComCall(4, this.p, GUID.Ptr, rclsid, IUnknown, pUnkOuter, UInt32, dwClsContext, GUID.Ptr, riid, IUnknown.Ptr, ppvObject)
    onDebugOutput(pstr)
      => ComCall(5, this.p, "Str", pstr)
    onHandleBreakPoint(prpt, br, pError)
      => ComCall(6, this.p, IRemoteDebugApplicationThread, prpt, BREAKREASON, br, IActiveScriptErrorDebug, pError)
    onClose()
      => ComCall(7, this.p)
    onDebuggerEvent(riid, punk)
      => ComCall(8, this.p, GUID.Ptr, riid, IUnknown, punk)
}
struct IApplicationDebuggerUI extends IUnknown {
    static IID := "{51973C2B-CB0C-11D0-B5C9-00A0244A0E7A}"
    BringDocumentToTop(pddt)
      => ComCall(3, this.p, IDebugDocumentText, pddt)
    BringDocumentContextToTop(pddc)
      => ComCall(4, this.p, IDebugDocumentContext, pddc)
}
struct IMachineDebugManager extends IUnknown {
    static IID := "{51973C2C-CB0C-11D0-B5C9-00A0244A0E7A}"
    AddApplication(pda, pdwAppCookie)
      => ComCall(3, this.p, IRemoteDebugApplication, pda, UInt32.Ptr, pdwAppCookie)
    RemoveApplication(dwAppCookie)
      => ComCall(4, this.p, UInt32, dwAppCookie)
    EnumApplications(ppeda)
      => ComCall(5, this.p, IEnumRemoteDebugApplications.Ptr, ppeda)
}
struct IMachineDebugManagerCookie extends IUnknown {
    static IID := "{51973C2D-CB0C-11D0-B5C9-00A0244A0E7A}"
    AddApplication(pda, dwDebugAppCookie, pdwAppCookie)
      => ComCall(3, this.p, IRemoteDebugApplication, pda, UInt32, dwDebugAppCookie, UInt32.Ptr, pdwAppCookie)
    RemoveApplication(dwDebugAppCookie, dwAppCookie)
      => ComCall(4, this.p, UInt32, dwDebugAppCookie, UInt32, dwAppCookie)
    EnumApplications(ppeda)
      => ComCall(5, this.p, IEnumRemoteDebugApplications.Ptr, ppeda)
}
struct IMachineDebugManagerEvents extends IUnknown {
    static IID := "{51973C2E-CB0C-11D0-B5C9-00A0244A0E7A}"
    onAddApplication(pda, dwAppCookie)
      => ComCall(3, this.p, IRemoteDebugApplication, pda, UInt32, dwAppCookie)
    onRemoveApplication(pda, dwAppCookie)
      => ComCall(4, this.p, IRemoteDebugApplication, pda, UInt32, dwAppCookie)
}
struct IProcessDebugManager32 extends IUnknown {
    static IID := "{51973C2F-CB0C-11D0-B5C9-00A0244A0E7A}"
    CreateApplication(ppda)
      => ComCall(3, this.p, IDebugApplication32.Ptr, ppda)
    GetDefaultApplication(ppda)
      => ComCall(4, this.p, IDebugApplication32.Ptr, ppda)
    AddApplication(pda, pdwAppCookie)
      => ComCall(5, this.p, IDebugApplication32, pda, UInt32.Ptr, pdwAppCookie)
    RemoveApplication(dwAppCookie)
      => ComCall(6, this.p, UInt32, dwAppCookie)
    CreateDebugDocumentHelper(punkOuter, pddh)
      => ComCall(7, this.p, IUnknown, punkOuter, IDebugDocumentHelper32.Ptr, pddh)
}
struct IProcessDebugManager64 extends IUnknown {
    static IID := "{56B9FC1C-63A9-4CC1-AC21-087D69A17FAB}"
    CreateApplication(ppda)
      => ComCall(3, this.p, IDebugApplication64.Ptr, ppda)
    GetDefaultApplication(ppda)
      => ComCall(4, this.p, IDebugApplication64.Ptr, ppda)
    AddApplication(pda, pdwAppCookie)
      => ComCall(5, this.p, IDebugApplication64, pda, UInt32.Ptr, pdwAppCookie)
    RemoveApplication(dwAppCookie)
      => ComCall(6, this.p, UInt32, dwAppCookie)
    CreateDebugDocumentHelper(punkOuter, pddh)
      => ComCall(7, this.p, IUnknown, punkOuter, IDebugDocumentHelper64.Ptr, pddh)
}
struct IRemoteDebugApplication extends IUnknown {
    static IID := "{51973C30-CB0C-11D0-B5C9-00A0244A0E7A}"
    ResumeFromBreakPoint(prptFocus, bra, era)
      => ComCall(3, this.p, IRemoteDebugApplicationThread, prptFocus, BREAKRESUMEACTION, bra, ERRORRESUMEACTION, era)
    CauseBreak()
      => ComCall(4, this.p)
    ConnectDebugger(pad)
      => ComCall(5, this.p, IApplicationDebugger, pad)
    DisconnectDebugger()
      => ComCall(6, this.p)
    GetDebugger(pad)
      => ComCall(7, this.p, IApplicationDebugger.Ptr, pad)
    CreateInstanceAtApplication(rclsid, pUnkOuter, dwClsContext, riid, ppvObject)
      => ComCall(8, this.p, GUID.Ptr, rclsid, IUnknown, pUnkOuter, UInt32, dwClsContext, GUID.Ptr, riid, IUnknown.Ptr, ppvObject)
    QueryAlive()
      => ComCall(9, this.p)
    EnumThreads(pperdat)
      => ComCall(10, this.p, IEnumRemoteDebugApplicationThreads.Ptr, pperdat)
    GetName(pbstrName)
      => ComCall(11, this.p, BSTR.Ptr, pbstrName)
    GetRootNode(ppdanRoot)
      => ComCall(12, this.p, IDebugApplicationNode.Ptr, ppdanRoot)
    EnumGlobalExpressionContexts(ppedec)
      => ComCall(13, this.p, IEnumDebugExpressionContexts.Ptr, ppedec)
}
struct IDebugApplication32 extends IRemoteDebugApplication {
    static IID := "{51973C32-CB0C-11D0-B5C9-00A0244A0E7A}"
    SetName(pstrName)
      => ComCall(14, this.p, "Str", pstrName)
    StepOutComplete()
      => ComCall(15, this.p)
    DebugOutput(pstr)
      => ComCall(16, this.p, "Str", pstr)
    StartDebugSession()
      => ComCall(17, this.p)
    HandleBreakPoint(br, pbra)
      => ComCall(18, this.p, BREAKREASON, br, BREAKRESUMEACTION.Ptr, pbra)
    Close()
      => ComCall(19, this.p)
    GetBreakFlags(pabf, pprdatSteppingThread)
      => ComCall(20, this.p, UInt32.Ptr, pabf, IRemoteDebugApplicationThread.Ptr, pprdatSteppingThread)
    GetCurrentThread(pat)
      => ComCall(21, this.p, IDebugApplicationThread.Ptr, pat)
    CreateAsyncDebugOperation(psdo, ppado)
      => ComCall(22, this.p, IDebugSyncOperation, psdo, IDebugAsyncOperation.Ptr, ppado)
    AddStackFrameSniffer(pdsfs, pdwCookie)
      => ComCall(23, this.p, IDebugStackFrameSniffer, pdsfs, UInt32.Ptr, pdwCookie)
    RemoveStackFrameSniffer(dwCookie)
      => ComCall(24, this.p, UInt32, dwCookie)
    QueryCurrentThreadIsDebuggerThread()
      => ComCall(25, this.p)
    SynchronousCallInDebuggerThread(pptc, dwParam1, dwParam2, dwParam3)
      => ComCall(26, this.p, IDebugThreadCall32, pptc, UInt32, dwParam1, UInt32, dwParam2, UInt32, dwParam3)
    CreateApplicationNode(ppdanNew)
      => ComCall(27, this.p, IDebugApplicationNode.Ptr, ppdanNew)
    FireDebuggerEvent(riid, punk)
      => ComCall(28, this.p, GUID.Ptr, riid, IUnknown, punk)
    HandleRuntimeError(pErrorDebug, pScriptSite, pbra, perra, pfCallOnScriptError)
      => ComCall(29, this.p, IActiveScriptErrorDebug, pErrorDebug, IActiveScriptSite, pScriptSite, BREAKRESUMEACTION.Ptr, pbra, ERRORRESUMEACTION.Ptr, perra, BOOL.Ptr, pfCallOnScriptError)
    FCanJitDebug()
      => ComCall(30, this.p, BOOL)
    FIsAutoJitDebugEnabled()
      => ComCall(31, this.p, BOOL)
    AddGlobalExpressionContextProvider(pdsfs, pdwCookie)
      => ComCall(32, this.p, IProvideExpressionContexts, pdsfs, UInt32.Ptr, pdwCookie)
    RemoveGlobalExpressionContextProvider(dwCookie)
      => ComCall(33, this.p, UInt32, dwCookie)
}
struct IDebugApplication64 extends IRemoteDebugApplication {
    static IID := "{4DEDC754-04C7-4F10-9E60-16A390FE6E62}"
    SetName(pstrName)
      => ComCall(14, this.p, "Str", pstrName)
    StepOutComplete()
      => ComCall(15, this.p)
    DebugOutput(pstr)
      => ComCall(16, this.p, "Str", pstr)
    StartDebugSession()
      => ComCall(17, this.p)
    HandleBreakPoint(br, pbra)
      => ComCall(18, this.p, BREAKREASON, br, BREAKRESUMEACTION.Ptr, pbra)
    Close()
      => ComCall(19, this.p)
    GetBreakFlags(pabf, pprdatSteppingThread)
      => ComCall(20, this.p, UInt32.Ptr, pabf, IRemoteDebugApplicationThread.Ptr, pprdatSteppingThread)
    GetCurrentThread(pat)
      => ComCall(21, this.p, IDebugApplicationThread.Ptr, pat)
    CreateAsyncDebugOperation(psdo, ppado)
      => ComCall(22, this.p, IDebugSyncOperation, psdo, IDebugAsyncOperation.Ptr, ppado)
    AddStackFrameSniffer(pdsfs, pdwCookie)
      => ComCall(23, this.p, IDebugStackFrameSniffer, pdsfs, UInt32.Ptr, pdwCookie)
    RemoveStackFrameSniffer(dwCookie)
      => ComCall(24, this.p, UInt32, dwCookie)
    QueryCurrentThreadIsDebuggerThread()
      => ComCall(25, this.p)
    SynchronousCallInDebuggerThread(pptc, dwParam1, dwParam2, dwParam3)
      => ComCall(26, this.p, IDebugThreadCall64, pptc, Int64, dwParam1, Int64, dwParam2, Int64, dwParam3)
    CreateApplicationNode(ppdanNew)
      => ComCall(27, this.p, IDebugApplicationNode.Ptr, ppdanNew)
    FireDebuggerEvent(riid, punk)
      => ComCall(28, this.p, GUID.Ptr, riid, IUnknown, punk)
    HandleRuntimeError(pErrorDebug, pScriptSite, pbra, perra, pfCallOnScriptError)
      => ComCall(29, this.p, IActiveScriptErrorDebug, pErrorDebug, IActiveScriptSite, pScriptSite, BREAKRESUMEACTION.Ptr, pbra, ERRORRESUMEACTION.Ptr, perra, BOOL.Ptr, pfCallOnScriptError)
    FCanJitDebug()
      => ComCall(30, this.p, BOOL)
    FIsAutoJitDebugEnabled()
      => ComCall(31, this.p, BOOL)
    AddGlobalExpressionContextProvider(pdsfs, pdwCookie)
      => ComCall(32, this.p, IProvideExpressionContexts, pdsfs, Int64.Ptr, pdwCookie)
    RemoveGlobalExpressionContextProvider(dwCookie)
      => ComCall(33, this.p, Int64, dwCookie)
}
struct IRemoteDebugApplicationEvents extends IUnknown {
    static IID := "{51973C33-CB0C-11D0-B5C9-00A0244A0E7A}"
    OnConnectDebugger(pad)
      => ComCall(3, this.p, IApplicationDebugger, pad)
    OnDisconnectDebugger()
      => ComCall(4, this.p)
    OnSetName(pstrName)
      => ComCall(5, this.p, "Str", pstrName)
    OnDebugOutput(pstr)
      => ComCall(6, this.p, "Str", pstr)
    OnClose()
      => ComCall(7, this.p)
    OnEnterBreakPoint(prdat)
      => ComCall(8, this.p, IRemoteDebugApplicationThread, prdat)
    OnLeaveBreakPoint(prdat)
      => ComCall(9, this.p, IRemoteDebugApplicationThread, prdat)
    OnCreateThread(prdat)
      => ComCall(10, this.p, IRemoteDebugApplicationThread, prdat)
    OnDestroyThread(prdat)
      => ComCall(11, this.p, IRemoteDebugApplicationThread, prdat)
    OnBreakFlagChange(abf, prdatSteppingThread)
      => ComCall(12, this.p, UInt32, abf, IRemoteDebugApplicationThread, prdatSteppingThread)
}
struct IDebugApplicationNode extends IDebugDocumentProvider {
    static IID := "{51973C34-CB0C-11D0-B5C9-00A0244A0E7A}"
    EnumChildren(pperddp)
      => ComCall(6, this.p, IEnumDebugApplicationNodes.Ptr, pperddp)
    GetParent(pprddp)
      => ComCall(7, this.p, IDebugApplicationNode.Ptr, pprddp)
    SetDocumentProvider(pddp)
      => ComCall(8, this.p, IDebugDocumentProvider, pddp)
    Close()
      => ComCall(9, this.p)
    Attach(pdanParent)
      => ComCall(10, this.p, IDebugApplicationNode, pdanParent)
    Detach()
      => ComCall(11, this.p)
}
struct IDebugApplicationNodeEvents extends IUnknown {
    static IID := "{51973C35-CB0C-11D0-B5C9-00A0244A0E7A}"
    onAddChild(prddpChild)
      => ComCall(3, this.p, IDebugApplicationNode, prddpChild)
    onRemoveChild(prddpChild)
      => ComCall(4, this.p, IDebugApplicationNode, prddpChild)
    onDetach()
      => ComCall(5, this.p)
    onAttach(prddpParent)
      => ComCall(6, this.p, IDebugApplicationNode, prddpParent)
}
struct AsyncIDebugApplicationNodeEvents extends IUnknown {
    static IID := "{A2E3AA3B-AA8D-4EBF-84CD-648B737B8C13}"
    Begin_onAddChild(prddpChild)
      => ComCall(3, this.p, IDebugApplicationNode, prddpChild)
    Finish_onAddChild()
      => ComCall(4, this.p)
    Begin_onRemoveChild(prddpChild)
      => ComCall(5, this.p, IDebugApplicationNode, prddpChild)
    Finish_onRemoveChild()
      => ComCall(6, this.p)
    Begin_onDetach()
      => ComCall(7, this.p)
    Finish_onDetach()
      => ComCall(8, this.p)
    Begin_onAttach(prddpParent)
      => ComCall(9, this.p, IDebugApplicationNode, prddpParent)
    Finish_onAttach()
      => ComCall(10, this.p)
}
struct IDebugThreadCall32 extends IUnknown {
    static IID := "{51973C36-CB0C-11D0-B5C9-00A0244A0E7A}"
    ThreadCallHandler(dwParam1, dwParam2, dwParam3)
      => ComCall(3, this.p, UInt32, dwParam1, UInt32, dwParam2, UInt32, dwParam3)
}
struct IDebugThreadCall64 extends IUnknown {
    static IID := "{CB3FA335-E979-42FD-9FCF-A7546A0F3905}"
    ThreadCallHandler(dwParam1, dwParam2, dwParam3)
      => ComCall(3, this.p, Int64, dwParam1, Int64, dwParam2, Int64, dwParam3)
}
struct IRemoteDebugApplicationThread extends IUnknown {
    static IID := "{51973C37-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetSystemThreadId(dwThreadId)
      => ComCall(3, this.p, UInt32.Ptr, dwThreadId)
    GetApplication(pprda)
      => ComCall(4, this.p, IRemoteDebugApplication.Ptr, pprda)
    EnumStackFrames(ppedsf)
      => ComCall(5, this.p, IEnumDebugStackFrames.Ptr, ppedsf)
    GetDescription(pbstrDescription, pbstrState)
      => ComCall(6, this.p, BSTR.Ptr, pbstrDescription, BSTR.Ptr, pbstrState)
    SetNextStatement(pStackFrame, pCodeContext)
      => ComCall(7, this.p, IDebugStackFrame, pStackFrame, IDebugCodeContext, pCodeContext)
    GetState(pState)
      => ComCall(8, this.p, UInt32.Ptr, pState)
    Suspend(pdwCount)
      => ComCall(9, this.p, UInt32.Ptr, pdwCount)
    Resume(pdwCount)
      => ComCall(10, this.p, UInt32.Ptr, pdwCount)
    GetSuspendCount(pdwCount)
      => ComCall(11, this.p, UInt32.Ptr, pdwCount)
}
struct IDebugApplicationThread extends IRemoteDebugApplicationThread {
    static IID := "{51973C38-CB0C-11D0-B5C9-00A0244A0E7A}"
    SynchronousCallIntoThread32(pstcb, dwParam1, dwParam2, dwParam3)
      => ComCall(12, this.p, IDebugThreadCall32, pstcb, UInt32, dwParam1, UInt32, dwParam2, UInt32, dwParam3)
    QueryIsCurrentThread()
      => ComCall(13, this.p)
    QueryIsDebuggerThread()
      => ComCall(14, this.p)
    SetDescription(pstrDescription)
      => ComCall(15, this.p, "Str", pstrDescription)
    SetStateString(pstrState)
      => ComCall(16, this.p, "Str", pstrState)
}
struct IDebugApplicationThread64 extends IDebugApplicationThread {
    static IID := "{9DAC5886-DBAD-456D-9DEE-5DEC39AB3DDA}"
    SynchronousCallIntoThread64(pstcb, dwParam1, dwParam2, dwParam3)
      => ComCall(17, this.p, IDebugThreadCall64, pstcb, Int64, dwParam1, Int64, dwParam2, Int64, dwParam3)
}
struct IDebugCookie extends IUnknown {
    static IID := "{51973C39-CB0C-11D0-B5C9-00A0244A0E7A}"
    SetDebugCookie(dwDebugAppCookie)
      => ComCall(3, this.p, UInt32, dwDebugAppCookie)
}
struct IEnumDebugApplicationNodes extends IUnknown {
    static IID := "{51973C3A-CB0C-11D0-B5C9-00A0244A0E7A}"
    Next(celt, pprddp, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, IDebugApplicationNode.Ptr, pprddp, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(pperddp)
      => ComCall(6, this.p, IEnumDebugApplicationNodes.Ptr, pperddp)
}
struct IEnumRemoteDebugApplications extends IUnknown {
    static IID := "{51973C3B-CB0C-11D0-B5C9-00A0244A0E7A}"
    Next(celt, ppda, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, IRemoteDebugApplication.Ptr, ppda, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppessd)
      => ComCall(6, this.p, IEnumRemoteDebugApplications.Ptr, ppessd)
}
struct IEnumRemoteDebugApplicationThreads extends IUnknown {
    static IID := "{51973C3C-CB0C-11D0-B5C9-00A0244A0E7A}"
    Next(celt, pprdat, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, IRemoteDebugApplicationThread.Ptr, pprdat, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(pperdat)
      => ComCall(6, this.p, IEnumRemoteDebugApplicationThreads.Ptr, pperdat)
}
struct IDebugFormatter extends IUnknown {
    static IID := "{51973C05-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetStringForVariant(pvar, nRadix, pbstrValue)
      => ComCall(3, this.p, VARIANT.Ptr, pvar, UInt32, nRadix, BSTR.Ptr, pbstrValue)
    GetVariantForString(pwstrValue, pvar)
      => ComCall(4, this.p, "Str", pwstrValue, VARIANT.Ptr, pvar)
    GetStringForVarType(vt, ptdescArrayType, pbstr)
      => ComCall(5, this.p, VARENUM, vt, TYPEDESC.Ptr, ptdescArrayType, BSTR.Ptr, pbstr)
}
struct ISimpleConnectionPoint extends IUnknown {
    static IID := "{51973C3E-CB0C-11D0-B5C9-00A0244A0E7A}"
    GetEventCount(pulCount)
      => ComCall(3, this.p, UInt32.Ptr, pulCount)
    DescribeEvents(iEvent, prgid, prgbstr, pcEventsFetched)
      => ComCall(4, this.p, UInt32, iEvent, UInt32, prgbstr.Length, Int32.Ptr, prgid, BSTR.Ptr, prgbstr, UInt32.Ptr, pcEventsFetched)
    Advise(pdisp, pdwCookie)
      => ComCall(5, this.p, IDispatch, pdisp, UInt32.Ptr, pdwCookie)
    Unadvise(dwCookie)
      => ComCall(6, this.p, UInt32, dwCookie)
}
struct IDebugHelper extends IUnknown {
    static IID := "{51973C3F-CB0C-11D0-B5C9-00A0244A0E7A}"
    CreatePropertyBrowser(pvar, bstrName, pdat, ppdob)
      => ComCall(3, this.p, VARIANT.Ptr, pvar, "Str", bstrName, IDebugApplicationThread, pdat, IDebugProperty.Ptr, ppdob)
    CreatePropertyBrowserEx(pvar, bstrName, pdat, pdf, ppdob)
      => ComCall(4, this.p, VARIANT.Ptr, pvar, "Str", bstrName, IDebugApplicationThread, pdat, IDebugFormatter, pdf, IDebugProperty.Ptr, ppdob)
    CreateSimpleConnectionPoint(pdisp, ppscp)
      => ComCall(5, this.p, IDispatch, pdisp, ISimpleConnectionPoint.Ptr, ppscp)
}
struct IEnumDebugExpressionContexts extends IUnknown {
    static IID := "{51973C40-CB0C-11D0-B5C9-00A0244A0E7A}"
    Next(celt, ppdec, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, IDebugExpressionContext.Ptr, ppdec, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppedec)
      => ComCall(6, this.p, IEnumDebugExpressionContexts.Ptr, ppedec)
}
struct IProvideExpressionContexts extends IUnknown {
    static IID := "{51973C41-CB0C-11D0-B5C9-00A0244A0E7A}"
    EnumExpressionContexts(ppedec)
      => ComCall(3, this.p, IEnumDebugExpressionContexts.Ptr, ppedec)
}
struct PROFILER_SCRIPT_TYPE extends Int32 {
    static PROFILER_SCRIPT_TYPE_USER := 0
    static PROFILER_SCRIPT_TYPE_DYNAMIC := 1
    static PROFILER_SCRIPT_TYPE_NATIVE := 2
    static PROFILER_SCRIPT_TYPE_DOM := 3
}
struct PROFILER_EVENT_MASK extends Int32 {
    static PROFILER_EVENT_MASK_TRACE_SCRIPT_FUNCTION_CALL := 1
    static PROFILER_EVENT_MASK_TRACE_NATIVE_FUNCTION_CALL := 2
    static PROFILER_EVENT_MASK_TRACE_DOM_FUNCTION_CALL := 4
    static PROFILER_EVENT_MASK_TRACE_ALL := 3
    static PROFILER_EVENT_MASK_TRACE_ALL_WITH_DOM := 7
}
struct IActiveScriptProfilerControl extends IUnknown {
    static IID := "{784B5FF0-69B0-47D1-A7DC-2518F4230E90}"
    StartProfiling(clsidProfilerObject, dwEventMask, dwContext)
      => ComCall(3, this.p, GUID.Ptr, clsidProfilerObject, UInt32, dwEventMask, UInt32, dwContext)
    SetProfilerEventMask(dwEventMask)
      => ComCall(4, this.p, UInt32, dwEventMask)
    StopProfiling(hrShutdownReason)
      => ComCall(5, this.p, HRESULT, hrShutdownReason)
}
struct IActiveScriptProfilerControl2 extends IActiveScriptProfilerControl {
    static IID := "{47810165-498F-40BE-94F1-653557E9E7DA}"
    CompleteProfilerStart()
      => ComCall(6, this.p)
    PrepareProfilerStop()
      => ComCall(7, this.p)
}
struct PROFILER_HEAP_OBJECT_FLAGS extends Int32 {
    static PROFILER_HEAP_OBJECT_FLAGS_NEW_OBJECT := 1
    static PROFILER_HEAP_OBJECT_FLAGS_IS_ROOT := 2
    static PROFILER_HEAP_OBJECT_FLAGS_SITE_CLOSED := 4
    static PROFILER_HEAP_OBJECT_FLAGS_EXTERNAL := 8
    static PROFILER_HEAP_OBJECT_FLAGS_EXTERNAL_UNKNOWN := 16
    static PROFILER_HEAP_OBJECT_FLAGS_EXTERNAL_DISPATCH := 32
    static PROFILER_HEAP_OBJECT_FLAGS_SIZE_APPROXIMATE := 64
    static PROFILER_HEAP_OBJECT_FLAGS_SIZE_UNAVAILABLE := 128
    static PROFILER_HEAP_OBJECT_FLAGS_NEW_STATE_UNAVAILABLE := 256
    static PROFILER_HEAP_OBJECT_FLAGS_WINRT_INSTANCE := 512
    static PROFILER_HEAP_OBJECT_FLAGS_WINRT_RUNTIMECLASS := 1024
    static PROFILER_HEAP_OBJECT_FLAGS_WINRT_DELEGATE := 2048
    static PROFILER_HEAP_OBJECT_FLAGS_WINRT_NAMESPACE := 4096
}
struct PROFILER_HEAP_OBJECT_OPTIONAL_INFO_TYPE extends Int32 {
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_PROTOTYPE := 1
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_FUNCTION_NAME := 2
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_SCOPE_LIST := 3
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_INTERNAL_PROPERTY := 4
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_NAME_PROPERTIES := 5
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_INDEX_PROPERTIES := 6
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_ELEMENT_ATTRIBUTES_SIZE := 7
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_ELEMENT_TEXT_CHILDREN_SIZE := 8
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_RELATIONSHIPS := 9
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_WINRTEVENTS := 10
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_WEAKMAP_COLLECTION_LIST := 11
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_MAP_COLLECTION_LIST := 12
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_SET_COLLECTION_LIST := 13
    static PROFILER_HEAP_OBJECT_OPTIONAL_INFO_MAX_VALUE := 13
}
struct PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS extends Int32 {
    static PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_NONE := 0
    static PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_IS_GET_ACCESSOR := 65536
    static PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_IS_SET_ACCESSOR := 131072
    static PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_LET_VARIABLE := 262144
    static PROFILER_HEAP_OBJECT_RELATIONSHIP_FLAGS_CONST_VARIABLE := 524288
}
struct PROFILER_HEAP_ENUM_FLAGS extends Int32 {
    static PROFILER_HEAP_ENUM_FLAGS_NONE := 0
    static PROFILER_HEAP_ENUM_FLAGS_STORE_RELATIONSHIP_FLAGS := 1
    static PROFILER_HEAP_ENUM_FLAGS_SUBSTRINGS := 2
    static PROFILER_HEAP_ENUM_FLAGS_RELATIONSHIP_SUBSTRINGS := 3
}
struct PROFILER_HEAP_OBJECT_SCOPE_LIST {
    count : UInt32
    scopes : IntPtr[1]
}
struct PROFILER_RELATIONSHIP_INFO extends Int32 {
    static PROFILER_PROPERTY_TYPE_NUMBER := 1
    static PROFILER_PROPERTY_TYPE_STRING := 2
    static PROFILER_PROPERTY_TYPE_HEAP_OBJECT := 3
    static PROFILER_PROPERTY_TYPE_EXTERNAL_OBJECT := 4
    static PROFILER_PROPERTY_TYPE_BSTR := 5
    static PROFILER_PROPERTY_TYPE_SUBSTRING := 6
}
struct PROFILER_PROPERTY_TYPE_SUBSTRING_INFO {
    length : UInt32
    value : PWSTR
}
struct PROFILER_HEAP_OBJECT_RELATIONSHIP {
    relationshipId : UInt32
    relationshipInfo : PROFILER_RELATIONSHIP_INFO
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            numberValue : Float64
            stringValue : PWSTR
            bstrValue : BSTR
            objectId : IntPtr
            externalObjectAddress : Struct.Ptr
            subString : PROFILER_PROPERTY_TYPE_SUBSTRING_INFO.Ptr
        }
    }
}
struct PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST {
    count : UInt32
    elements : PROFILER_HEAP_OBJECT_RELATIONSHIP[1]
}
struct PROFILER_HEAP_OBJECT_OPTIONAL_INFO {
    infoType : PROFILER_HEAP_OBJECT_OPTIONAL_INFO_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            prototype : IntPtr
            functionName : PWSTR
            elementAttributesSize : UInt32
            elementTextChildrenSize : UInt32
            scopeList : PROFILER_HEAP_OBJECT_SCOPE_LIST.Ptr
            internalProperty : PROFILER_HEAP_OBJECT_RELATIONSHIP.Ptr
            namePropertyList : PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST.Ptr
            indexPropertyList : PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST.Ptr
            relationshipList : PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST.Ptr
            eventList : PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST.Ptr
            weakMapCollectionList : PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST.Ptr
            mapCollectionList : PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST.Ptr
            setCollectionList : PROFILER_HEAP_OBJECT_RELATIONSHIP_LIST.Ptr
        }
    }
}
struct PROFILER_HEAP_OBJECT {
    size : UInt32
    Anonymous : this._Anonymous_e__Union
    typeNameId : UInt32
    flags : UInt32
    unused : UInt16
    optionalInfoCount : UInt16
    struct _Anonymous_e__Union {
        union {
            objectId : IntPtr
            externalObjectAddress : Struct.Ptr
        }
    }
}
struct IActiveScriptProfilerHeapEnum extends IUnknown {
    static IID := "{32E4694E-0D37-419B-B93D-FA20DED6E8EA}"
    Next(heapObjects, pceltFetched)
      => ComCall(3, this.p, UInt32, heapObjects.Length, PROFILER_HEAP_OBJECT.Ptr.Ptr, heapObjects, UInt32.Ptr, pceltFetched)
    GetOptionalInfo(heapObject, optionalInfo)
      => ComCall(4, this.p, PROFILER_HEAP_OBJECT.Ptr, heapObject, UInt32, optionalInfo.Length, PROFILER_HEAP_OBJECT_OPTIONAL_INFO.Ptr, optionalInfo)
    FreeObjectAndOptionalInfo(heapObjects)
      => ComCall(5, this.p, UInt32, heapObjects.Length, PROFILER_HEAP_OBJECT.Ptr.Ptr, heapObjects)
    GetNameIdMap(pNameList)
      => ComCall(6, this.p, PWSTR.Ptr.Ptr.Ptr, pNameList, UInt32.Ptr, pNameList.Length)
}
struct IActiveScriptProfilerControl3 extends IActiveScriptProfilerControl2 {
    static IID := "{0B403015-F381-4023-A5D0-6FED076DE716}"
    EnumHeap(ppEnum)
      => ComCall(8, this.p, IActiveScriptProfilerHeapEnum.Ptr, ppEnum)
}
struct PROFILER_HEAP_SUMMARY_VERSION extends Int32 {
    static PROFILER_HEAP_SUMMARY_VERSION_1 := 1
}
struct PROFILER_HEAP_SUMMARY {
    version : PROFILER_HEAP_SUMMARY_VERSION
    totalHeapSize : UInt32
}
struct IActiveScriptProfilerControl4 extends IActiveScriptProfilerControl3 {
    static IID := "{160F94FD-9DBC-40D4-9EAC-2B71DB3132F4}"
    SummarizeHeap(heapSummary)
      => ComCall(9, this.p, PROFILER_HEAP_SUMMARY.Ptr, heapSummary)
}
struct IActiveScriptProfilerControl5 extends IActiveScriptProfilerControl4 {
    static IID := "{1C01A2D1-8F0F-46A5-9720-0D7ED2C62F0A}"
    EnumHeap2(enumFlags, ppEnum)
      => ComCall(10, this.p, PROFILER_HEAP_ENUM_FLAGS, enumFlags, IActiveScriptProfilerHeapEnum.Ptr, ppEnum)
}
struct IActiveScriptProfilerCallback extends IUnknown {
    static IID := "{740ECA23-7D9D-42E5-BA9D-F8B24B1C7A9B}"
    Initialize(dwContext)
      => ComCall(3, this.p, UInt32, dwContext)
    Shutdown(hrReason)
      => ComCall(4, this.p, HRESULT, hrReason)
    ScriptCompiled(scriptId, type, pIDebugDocumentContext)
      => ComCall(5, this.p, Int32, scriptId, PROFILER_SCRIPT_TYPE, type, IUnknown, pIDebugDocumentContext)
    FunctionCompiled(functionId, scriptId, pwszFunctionName, pwszFunctionNameHint, pIDebugDocumentContext)
      => ComCall(6, this.p, Int32, functionId, Int32, scriptId, "Str", pwszFunctionName, "Str", pwszFunctionNameHint, IUnknown, pIDebugDocumentContext)
    OnFunctionEnter(scriptId, functionId)
      => ComCall(7, this.p, Int32, scriptId, Int32, functionId)
    OnFunctionExit(scriptId, functionId)
      => ComCall(8, this.p, Int32, scriptId, Int32, functionId)
}
struct IActiveScriptProfilerCallback2 extends IActiveScriptProfilerCallback {
    static IID := "{31B7F8AD-A637-409C-B22F-040995B6103D}"
    OnFunctionEnterByName(pwszFunctionName, type)
      => ComCall(9, this.p, "Str", pwszFunctionName, PROFILER_SCRIPT_TYPE, type)
    OnFunctionExitByName(pwszFunctionName, type)
      => ComCall(10, this.p, "Str", pwszFunctionName, PROFILER_SCRIPT_TYPE, type)
}
struct IActiveScriptProfilerCallback3 extends IActiveScriptProfilerCallback2 {
    static IID := "{6AC5AD25-2037-4687-91DF-B59979D93D73}"
    SetWebWorkerId(webWorkerId)
      => ComCall(11, this.p, UInt32, webWorkerId)
}
struct IScriptNode extends IUnknown {
    static IID := "{0AEE2A94-BCBB-11D0-8C72-00C04FC2B085}"
    Alive()
      => ComCall(3, this.p)
    Delete()
      => ComCall(4, this.p)
    GetParent(ppsnParent)
      => ComCall(5, this.p, IScriptNode.Ptr, ppsnParent)
    GetIndexInParent(pisn)
      => ComCall(6, this.p, UInt32.Ptr, pisn)
    GetCookie(pdwCookie)
      => ComCall(7, this.p, UInt32.Ptr, pdwCookie)
    GetNumberOfChildren(pcsn)
      => ComCall(8, this.p, UInt32.Ptr, pcsn)
    GetChild(isn, ppsn)
      => ComCall(9, this.p, UInt32, isn, IScriptNode.Ptr, ppsn)
    GetLanguage(pbstr)
      => ComCall(10, this.p, BSTR.Ptr, pbstr)
    CreateChildEntry(isn, dwCookie, pszDelimiter, ppse)
      => ComCall(11, this.p, UInt32, isn, UInt32, dwCookie, "Str", pszDelimiter, IScriptEntry.Ptr, ppse)
    CreateChildHandler(pszDefaultName, prgpszNames, pszEvent, pszDelimiter, ptiSignature, iMethodSignature, isn, dwCookie, ppse)
      => ComCall(12, this.p, "Str", pszDefaultName, PWSTR.Ptr, prgpszNames, UInt32, prgpszNames.Length, "Str", pszEvent, "Str", pszDelimiter, ITypeInfo, ptiSignature, UInt32, iMethodSignature, UInt32, isn, UInt32, dwCookie, IScriptEntry.Ptr, ppse)
}
struct IScriptEntry extends IScriptNode {
    static IID := "{0AEE2A95-BCBB-11D0-8C72-00C04FC2B085}"
    GetText(pbstr)
      => ComCall(13, this.p, BSTR.Ptr, pbstr)
    SetText(psz)
      => ComCall(14, this.p, "Str", psz)
    GetBody(pbstr)
      => ComCall(15, this.p, BSTR.Ptr, pbstr)
    SetBody(psz)
      => ComCall(16, this.p, "Str", psz)
    GetName(pbstr)
      => ComCall(17, this.p, BSTR.Ptr, pbstr)
    SetName(psz)
      => ComCall(18, this.p, "Str", psz)
    GetItemName(pbstr)
      => ComCall(19, this.p, BSTR.Ptr, pbstr)
    SetItemName(psz)
      => ComCall(20, this.p, "Str", psz)
    GetSignature(ppti, piMethod)
      => ComCall(21, this.p, ITypeInfo.Ptr, ppti, UInt32.Ptr, piMethod)
    SetSignature(pti, iMethod)
      => ComCall(22, this.p, ITypeInfo, pti, UInt32, iMethod)
    GetRange(pichMin, pcch)
      => ComCall(23, this.p, UInt32.Ptr, pichMin, UInt32.Ptr, pcch)
}
struct IScriptScriptlet extends IScriptEntry {
    static IID := "{0AEE2A96-BCBB-11D0-8C72-00C04FC2B085}"
    GetSubItemName(pbstr)
      => ComCall(24, this.p, BSTR.Ptr, pbstr)
    SetSubItemName(psz)
      => ComCall(25, this.p, "Str", psz)
    GetEventName(pbstr)
      => ComCall(26, this.p, BSTR.Ptr, pbstr)
    SetEventName(psz)
      => ComCall(27, this.p, "Str", psz)
    GetSimpleEventName(pbstr)
      => ComCall(28, this.p, BSTR.Ptr, pbstr)
    SetSimpleEventName(psz)
      => ComCall(29, this.p, "Str", psz)
}
struct IActiveScriptAuthor extends IUnknown {
    static IID := "{9C109DA0-7006-11D1-B36C-00A0C911E8B2}"
    AddNamedItem(pszName, dwFlags, pdisp)
      => ComCall(3, this.p, "Str", pszName, UInt32, dwFlags, IDispatch, pdisp)
    AddScriptlet(pszDefaultName, pszCode, pszItemName, pszSubItemName, pszEventName, pszDelimiter, dwCookie, dwFlags)
      => ComCall(4, this.p, "Str", pszDefaultName, "Str", pszCode, "Str", pszItemName, "Str", pszSubItemName, "Str", pszEventName, "Str", pszDelimiter, UInt32, dwCookie, UInt32, dwFlags)
    ParseScriptText(pszCode, pszItemName, pszDelimiter, dwCookie, dwFlags)
      => ComCall(5, this.p, "Str", pszCode, "Str", pszItemName, "Str", pszDelimiter, UInt32, dwCookie, UInt32, dwFlags)
    GetScriptTextAttributes(pszCode, pszDelimiter, dwFlags, pattr)
      => ComCall(6, this.p, "Str", pszCode, UInt32, pattr.Length, "Str", pszDelimiter, UInt32, dwFlags, UInt16.Ptr, pattr)
    GetScriptletTextAttributes(pszCode, pszDelimiter, dwFlags, pattr)
      => ComCall(7, this.p, "Str", pszCode, UInt32, pattr.Length, "Str", pszDelimiter, UInt32, dwFlags, UInt16.Ptr, pattr)
    GetRoot(ppsp)
      => ComCall(8, this.p, IScriptNode.Ptr, ppsp)
    GetLanguageFlags(pgrfasa)
      => ComCall(9, this.p, UInt32.Ptr, pgrfasa)
    GetEventHandler(pdisp, pszItem, pszSubItem, pszEvent, ppse)
      => ComCall(10, this.p, IDispatch, pdisp, "Str", pszItem, "Str", pszSubItem, "Str", pszEvent, IScriptEntry.Ptr, ppse)
    RemoveNamedItem(pszName)
      => ComCall(11, this.p, "Str", pszName)
    AddTypeLib(rguidTypeLib, dwMajor, dwMinor, dwFlags)
      => ComCall(12, this.p, GUID.Ptr, rguidTypeLib, UInt32, dwMajor, UInt32, dwMinor, UInt32, dwFlags)
    RemoveTypeLib(rguidTypeLib, dwMajor, dwMinor)
      => ComCall(13, this.p, GUID.Ptr, rguidTypeLib, UInt32, dwMajor, UInt32, dwMinor)
    GetChars(fRequestedList, pbstrChars)
      => ComCall(14, this.p, UInt32, fRequestedList, BSTR.Ptr, pbstrChars)
    GetInfoFromContext(pszCode, cchCode, ichCurrentPosition, dwListTypesRequested, pdwListTypesProvided, pichListAnchorPosition, pichFuncAnchorPosition, pmemid, piCurrentParameter, ppunk)
      => ComCall(15, this.p, "Str", pszCode, UInt32, cchCode, UInt32, ichCurrentPosition, UInt32, dwListTypesRequested, UInt32.Ptr, pdwListTypesProvided, UInt32.Ptr, pichListAnchorPosition, UInt32.Ptr, pichFuncAnchorPosition, Int32.Ptr, pmemid, Int32.Ptr, piCurrentParameter, IUnknown.Ptr, ppunk)
    IsCommitChar(ch, pfcommit)
      => ComCall(16, this.p, UInt16, ch, BOOL.Ptr, pfcommit)
}
struct IActiveScriptAuthorProcedure extends IUnknown {
    static IID := "{7E2D4B70-BD9A-11D0-9336-00A0C90DCAA9}"
    ParseProcedureText(pszCode, pszFormalParams, pszProcedureName, pszItemName, pszDelimiter, dwCookie, dwFlags, pdispFor)
      => ComCall(3, this.p, "Str", pszCode, "Str", pszFormalParams, "Str", pszProcedureName, "Str", pszItemName, "Str", pszDelimiter, UInt32, dwCookie, UInt32, dwFlags, IDispatch, pdispFor)
}
struct APPLICATION_NODE_EVENT_FILTER extends Int32 {
    static FILTER_EXCLUDE_NOTHING := 0
    static FILTER_EXCLUDE_ANONYMOUS_CODE := 1
    static FILTER_EXCLUDE_EVAL_CODE := 2
}
struct TEXT_DOCUMENT_ARRAY {
    dwCount : UInt32
    Members : IDebugDocumentText.Ptr
}
struct IDebugApplicationNode100 extends IUnknown {
    static IID := "{90A7734E-841B-4F77-9384-A2891E76E7E2}"
    SetFilterForEventSink(dwCookie, filter)
      => ComCall(3, this.p, UInt32, dwCookie, APPLICATION_NODE_EVENT_FILTER, filter)
    GetExcludedDocuments(filter, pDocuments)
      => ComCall(4, this.p, APPLICATION_NODE_EVENT_FILTER, filter, TEXT_DOCUMENT_ARRAY.Ptr, pDocuments)
    QueryIsChildNode(pSearchKey)
      => ComCall(5, this.p, IDebugDocument, pSearchKey)
}
struct IWebAppDiagnosticsSetup extends IUnknown {
    static IID := "{379BFBE1-C6C9-432A-93E1-6D17656C538C}"
    DiagnosticsSupported(pRetVal)
      => ComCall(3, this.p, VARIANT_BOOL.Ptr, pRetVal)
    CreateObjectWithSiteAtWebApp(rclsid, dwClsContext, riid, hPassToObject)
      => ComCall(4, this.p, GUID.Ptr, rclsid, UInt32, dwClsContext, GUID.Ptr, riid, IntPtr, hPassToObject)
}
struct SCRIPT_DEBUGGER_OPTIONS extends Int32 {
    static SDO_NONE := 0
    static SDO_ENABLE_FIRST_CHANCE_EXCEPTIONS := 1
    static SDO_ENABLE_WEB_WORKER_SUPPORT := 2
    static SDO_ENABLE_NONUSER_CODE_SUPPORT := 4
    static SDO_ENABLE_LIBRARY_STACK_FRAME := 8
}
struct IRemoteDebugApplication110 extends IUnknown {
    static IID := "{D5FE005B-2836-485E-B1F9-89D91AA24FD4}"
    SetDebuggerOptions(mask, value)
      => ComCall(3, this.p, SCRIPT_DEBUGGER_OPTIONS, mask, SCRIPT_DEBUGGER_OPTIONS, value)
    GetCurrentDebuggerOptions(pCurrentOptions)
      => ComCall(4, this.p, SCRIPT_DEBUGGER_OPTIONS.Ptr, pCurrentOptions)
    GetMainThread(ppThread)
      => ComCall(5, this.p, IRemoteDebugApplicationThread.Ptr, ppThread)
}
struct IDebugApplication11032 extends IRemoteDebugApplication110 {
    static IID := "{BDB3B5DE-89F2-4E11-84A5-97445F941C7D}"
    SynchronousCallInMainThread(pptc, dwParam1, dwParam2, dwParam3)
      => ComCall(6, this.p, IDebugThreadCall32, pptc, IntPtr, dwParam1, IntPtr, dwParam2, IntPtr, dwParam3)
    AsynchronousCallInMainThread(pptc, dwParam1, dwParam2, dwParam3)
      => ComCall(7, this.p, IDebugThreadCall32, pptc, IntPtr, dwParam1, IntPtr, dwParam2, IntPtr, dwParam3)
    CallableWaitForHandles(pHandles, pIndex)
      => ComCall(8, this.p, UInt32, pHandles.Length, HANDLE.Ptr, pHandles, UInt32.Ptr, pIndex)
}
struct IDebugApplication11064 extends IRemoteDebugApplication110 {
    static IID := "{2039D958-4EEB-496A-87BB-2E5201EADEEF}"
    SynchronousCallInMainThread(pptc, dwParam1, dwParam2, dwParam3)
      => ComCall(6, this.p, IDebugThreadCall64, pptc, IntPtr, dwParam1, IntPtr, dwParam2, IntPtr, dwParam3)
    AsynchronousCallInMainThread(pptc, dwParam1, dwParam2, dwParam3)
      => ComCall(7, this.p, IDebugThreadCall64, pptc, IntPtr, dwParam1, IntPtr, dwParam2, IntPtr, dwParam3)
    CallableWaitForHandles(pHandles, pIndex)
      => ComCall(8, this.p, UInt32, pHandles.Length, HANDLE.Ptr, pHandles, UInt32.Ptr, pIndex)
}
struct IWebAppDiagnosticsObjectInitialization extends IUnknown {
    static IID := "{16FF3A42-A5F5-432B-B625-8E8E16F57E15}"
    Initialize(hPassedHandle, pDebugApplication)
      => ComCall(3, this.p, HANDLE_PTR, hPassedHandle, IUnknown, pDebugApplication)
}
struct IActiveScriptWinRTErrorDebug extends IActiveScriptError {
    static IID := "{73A3F82A-0FE9-4B33-BA3B-FE095F697E0A}"
    GetRestrictedErrorString(errorString)
      => ComCall(6, this.p, BSTR.Ptr, errorString)
    GetRestrictedErrorReference(referenceString)
      => ComCall(7, this.p, BSTR.Ptr, referenceString)
    GetCapabilitySid(capabilitySid)
      => ComCall(8, this.p, BSTR.Ptr, capabilitySid)
}
struct SCRIPT_ERROR_DEBUG_EXCEPTION_THROWN_KIND extends Int32 {
    static ETK_FIRST_CHANCE := 0
    static ETK_USER_UNHANDLED := 1
    static ETK_UNHANDLED := 2
}
struct IActiveScriptErrorDebug110 extends IUnknown {
    static IID := "{516E42B6-89A8-4530-937B-5F0708431442}"
    GetExceptionThrownKind(pExceptionKind)
      => ComCall(3, this.p, SCRIPT_ERROR_DEBUG_EXCEPTION_THROWN_KIND.Ptr, pExceptionKind)
}
struct IDebugApplicationThreadEvents110 extends IUnknown {
    static IID := "{84E5E468-D5DA-48A8-83F4-40366429007B}"
    OnSuspendForBreakPoint()
      => ComCall(3, this.p)
    OnResumeFromBreakPoint()
      => ComCall(4, this.p)
    OnThreadRequestComplete()
      => ComCall(5, this.p)
    OnBeginThreadRequest()
      => ComCall(6, this.p)
}
struct IDebugApplicationThread11032 extends IUnknown {
    static IID := "{2194AC5C-6561-404A-A2E9-F57D72DE3702}"
    GetActiveThreadRequestCount(puiThreadRequests)
      => ComCall(3, this.p, UInt32.Ptr, puiThreadRequests)
    IsSuspendedForBreakPoint(pfIsSuspended)
      => ComCall(4, this.p, BOOL.Ptr, pfIsSuspended)
    IsThreadCallable(pfIsCallable)
      => ComCall(5, this.p, BOOL.Ptr, pfIsCallable)
    AsynchronousCallIntoThread(pptc, dwParam1, dwParam2, dwParam3)
      => ComCall(6, this.p, IDebugThreadCall32, pptc, IntPtr, dwParam1, IntPtr, dwParam2, IntPtr, dwParam3)
}
struct IDebugApplicationThread11064 extends IUnknown {
    static IID := "{420AA4CC-EFD8-4DAC-983B-47127826917D}"
    GetActiveThreadRequestCount(puiThreadRequests)
      => ComCall(3, this.p, UInt32.Ptr, puiThreadRequests)
    IsSuspendedForBreakPoint(pfIsSuspended)
      => ComCall(4, this.p, BOOL.Ptr, pfIsSuspended)
    IsThreadCallable(pfIsCallable)
      => ComCall(5, this.p, BOOL.Ptr, pfIsCallable)
    AsynchronousCallIntoThread(pptc, dwParam1, dwParam2, dwParam3)
      => ComCall(6, this.p, IDebugThreadCall64, pptc, IntPtr, dwParam1, IntPtr, dwParam2, IntPtr, dwParam3)
}
struct IRemoteDebugCriticalErrorEvent110 extends IUnknown {
    static IID := "{2F69C611-6B14-47E8-9260-4BB7C52F504B}"
    GetErrorInfo(pbstrSource, pMessageId, pbstrMessage, ppLocation)
      => ComCall(3, this.p, BSTR.Ptr, pbstrSource, Int32.Ptr, pMessageId, BSTR.Ptr, pbstrMessage, IDebugDocumentContext.Ptr, ppLocation)
}
struct SCRIPT_INVOCATION_CONTEXT_TYPE extends Int32 {
    static SICT_Event := 0
    static SICT_SetTimeout := 1
    static SICT_SetInterval := 2
    static SICT_SetImmediate := 3
    static SICT_RequestAnimationFrame := 4
    static SICT_ToString := 5
    static SICT_MutationObserverCheckpoint := 6
    static SICT_WWAExecUnsafeLocalFunction := 7
    static SICT_WWAExecAtPriority := 8
}
struct IScriptInvocationContext extends IUnknown {
    static IID := "{5D7741B7-AF7E-4A2A-85E5-C77F4D0659FB}"
    GetContextType(pInvocationContextType)
      => ComCall(3, this.p, SCRIPT_INVOCATION_CONTEXT_TYPE.Ptr, pInvocationContextType)
    GetContextDescription(pDescription)
      => ComCall(4, this.p, BSTR.Ptr, pDescription)
    GetContextObject(ppContextObject)
      => ComCall(5, this.p, IUnknown.Ptr, ppContextObject)
}
struct DEBUG_STACKFRAME_TYPE extends Int32 {
    static DST_SCRIPT_FRAME := 0
    static DST_INTERNAL_FRAME := 1
    static DST_INVOCATION_FRAME := 2
}
struct IDebugStackFrame110 extends IDebugStackFrame {
    static IID := "{4B509611-B6EA-4B24-ADCB-D0CCFD1A7E33}"
    GetStackFrameType(pStackFrameKind)
      => ComCall(8, this.p, DEBUG_STACKFRAME_TYPE.Ptr, pStackFrameKind)
    GetScriptInvocationContext(ppInvocationContext)
      => ComCall(9, this.p, IScriptInvocationContext.Ptr, ppInvocationContext)
}
struct DEBUG_EVENT_INFO_TYPE extends Int32 {
    static DEIT_GENERAL := 0
    static DEIT_ASMJS_IN_DEBUGGING := 1
    static DEIT_ASMJS_SUCCEEDED := 2
    static DEIT_ASMJS_FAILED := 3
}
struct IRemoteDebugInfoEvent110 extends IUnknown {
    static IID := "{9FF56BB6-EB89-4C0F-8823-CC2A4C0B7F26}"
    GetEventInfo(pMessageType, pbstrMessage, pbstrUrl, ppLocation)
      => ComCall(3, this.p, DEBUG_EVENT_INFO_TYPE.Ptr, pMessageType, BSTR.Ptr, pbstrMessage, BSTR.Ptr, pbstrUrl, IDebugDocumentContext.Ptr, ppLocation)
}
struct IJsDebug extends IUnknown {
    static IID := "{BE0E89DA-2AC5-4C04-AC5E-59956AAE3613}"
    OpenVirtualProcess(processId, runtimeJsBaseAddress, pDataTarget, ppProcess)
      => ComCall(3, this.p, UInt32, processId, Int64, runtimeJsBaseAddress, IJsDebugDataTarget, pDataTarget, IJsDebugProcess.Ptr, ppProcess)
}
struct IJsDebugProcess extends IUnknown {
    static IID := "{3D587168-6A2D-4041-BD3B-0DE674502862}"
    CreateStackWalker(threadId, ppStackWalker)
      => ComCall(3, this.p, UInt32, threadId, IJsDebugStackWalker.Ptr, ppStackWalker)
    CreateBreakPoint(documentId, characterOffset, characterCount, isEnabled, ppDebugBreakPoint)
      => ComCall(4, this.p, Int64, documentId, UInt32, characterOffset, UInt32, characterCount, BOOL, isEnabled, IJsDebugBreakPoint.Ptr, ppDebugBreakPoint)
    PerformAsyncBreak(threadId)
      => ComCall(5, this.p, UInt32, threadId)
    GetExternalStepAddress(pCodeAddress)
      => ComCall(6, this.p, Int64.Ptr, pCodeAddress)
}
struct IJsDebugStackWalker extends IUnknown {
    static IID := "{DB24B094-73C4-456C-A4EC-E90EA00BDFE3}"
    GetNext(ppFrame)
      => ComCall(3, this.p, IJsDebugFrame.Ptr, ppFrame)
}
struct IJsDebugFrame extends IUnknown {
    static IID := "{C9196637-AB9D-44B2-BAD2-13B95B3F390E}"
    GetStackRange(pStart, pEnd)
      => ComCall(3, this.p, Int64.Ptr, pStart, Int64.Ptr, pEnd)
    GetName(pName)
      => ComCall(4, this.p, BSTR.Ptr, pName)
    GetDocumentPositionWithId(pDocumentId, pCharacterOffset, pStatementCharCount)
      => ComCall(5, this.p, Int64.Ptr, pDocumentId, UInt32.Ptr, pCharacterOffset, UInt32.Ptr, pStatementCharCount)
    GetDocumentPositionWithName(pDocumentName, pLine, pColumn)
      => ComCall(6, this.p, BSTR.Ptr, pDocumentName, UInt32.Ptr, pLine, UInt32.Ptr, pColumn)
    GetDebugProperty(ppDebugProperty)
      => ComCall(7, this.p, IJsDebugProperty.Ptr, ppDebugProperty)
    GetReturnAddress(pReturnAddress)
      => ComCall(8, this.p, Int64.Ptr, pReturnAddress)
    Evaluate(pExpressionText, ppDebugProperty, pError)
      => ComCall(9, this.p, "Str", pExpressionText, IJsDebugProperty.Ptr, ppDebugProperty, BSTR.Ptr, pError)
}
struct JS_PROPERTY_MEMBERS extends Int32 {
    static JS_PROPERTY_MEMBERS_ALL := 0
    static JS_PROPERTY_MEMBERS_ARGUMENTS := 1
}
struct JS_PROPERTY_ATTRIBUTES extends Int32 {
    static JS_PROPERTY_ATTRIBUTE_NONE := 0
    static JS_PROPERTY_HAS_CHILDREN := 1
    static JS_PROPERTY_FAKE := 2
    static JS_PROPERTY_METHOD := 4
    static JS_PROPERTY_READONLY := 8
    static JS_PROPERTY_NATIVE_WINRT_POINTER := 16
    static JS_PROPERTY_FRAME_INTRYBLOCK := 32
    static JS_PROPERTY_FRAME_INCATCHBLOCK := 64
    static JS_PROPERTY_FRAME_INFINALLYBLOCK := 128
}
struct JsDebugPropertyInfo {
    name : BSTR
    type : BSTR
    value : BSTR
    fullName : BSTR
    attr : JS_PROPERTY_ATTRIBUTES
}
struct IJsDebugProperty extends IUnknown {
    static IID := "{F8FFCF2B-3AA4-4320-85C3-52A312BA9633}"
    GetPropertyInfo(nRadix, pPropertyInfo)
      => ComCall(3, this.p, UInt32, nRadix, JsDebugPropertyInfo.Ptr, pPropertyInfo)
    GetMembers(members, ppEnum)
      => ComCall(4, this.p, JS_PROPERTY_MEMBERS, members, IJsEnumDebugProperty.Ptr, ppEnum)
}
struct IJsEnumDebugProperty extends IUnknown {
    static IID := "{4092432F-2F0F-4FE1-B638-5B74A52CDCBE}"
    Next(ppDebugProperty, pActualCount)
      => ComCall(3, this.p, UInt32, ppDebugProperty.Length, IJsDebugProperty.Ptr, ppDebugProperty, UInt32.Ptr, pActualCount)
    GetCount(pCount)
      => ComCall(4, this.p, UInt32.Ptr, pCount)
}
struct IJsDebugBreakPoint extends IUnknown {
    static IID := "{DF6773E3-ED8D-488B-8A3E-5812577D1542}"
    IsEnabled(pIsEnabled)
      => ComCall(3, this.p, BOOL.Ptr, pIsEnabled)
    Enable()
      => ComCall(4, this.p)
    Disable()
      => ComCall(5, this.p)
    Delete()
      => ComCall(6, this.p)
    GetDocumentPosition(pDocumentId, pCharacterOffset, pStatementCharCount)
      => ComCall(7, this.p, Int64.Ptr, pDocumentId, UInt32.Ptr, pCharacterOffset, UInt32.Ptr, pStatementCharCount)
}
struct JS_NATIVE_FRAME {
    InstructionOffset : Int64
    ReturnOffset : Int64
    FrameOffset : Int64
    StackOffset : Int64
}
struct IEnumJsStackFrames extends IUnknown {
    static IID := "{5E7DA34B-FB51-4791-ABE7-CB5BDF419755}"
    Next(pFrames, pcFetched)
      => ComCall(3, this.p, UInt32, pFrames.Length, JS_NATIVE_FRAME.Ptr, pFrames, UInt32.Ptr, pcFetched)
    Reset()
      => ComCall(4, this.p)
}
struct JsDebugReadMemoryFlags extends Int32 {
    static None := 0
    static JsDebugAllowPartialRead := 1
}
struct IJsDebugDataTarget extends IUnknown {
    static IID := "{53B28977-53A1-48E5-9000-5D0DFA893931}"
    ReadMemory(address, flags, pBuffer, pBytesRead)
      => ComCall(3, this.p, Int64, address, JsDebugReadMemoryFlags, flags, UInt8.Ptr, pBuffer, UInt32, pBuffer.Length, UInt32.Ptr, pBytesRead)
    WriteMemory(address, pMemory)
      => ComCall(4, this.p, Int64, address, UInt8.Ptr, pMemory, UInt32, pMemory.Length)
    AllocateVirtualMemory(address, size, allocationType, pageProtection, pAllocatedAddress)
      => ComCall(5, this.p, Int64, address, UInt32, size, UInt32, allocationType, UInt32, pageProtection, Int64.Ptr, pAllocatedAddress)
    FreeVirtualMemory(address, size, freeType)
      => ComCall(6, this.p, Int64, address, UInt32, size, UInt32, freeType)
    GetTlsValue(threadId, tlsIndex, pValue)
      => ComCall(7, this.p, UInt32, threadId, UInt32, tlsIndex, Int64.Ptr, pValue)
    ReadBSTR(address, pString)
      => ComCall(8, this.p, Int64, address, BSTR.Ptr, pString)
    ReadNullTerminatedString(address, characterSize, maxCharacters, pString)
      => ComCall(9, this.p, Int64, address, UInt16, characterSize, UInt32, maxCharacters, BSTR.Ptr, pString)
    CreateStackFrameEnumerator(threadId, ppEnumerator)
      => ComCall(10, this.p, UInt32, threadId, IEnumJsStackFrames.Ptr, ppEnumerator)
    GetThreadContext(threadId, contextFlags, pContext)
      => ComCall(11, this.p, UInt32, threadId, UInt32, contextFlags, UInt32, pContext.Length, Struct.Ptr, pContext)
}
