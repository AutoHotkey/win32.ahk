#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct SCE_LOG_ERR_LEVEL extends Int32 {
    static SCE_LOG_LEVEL_ALWAYS := 0
    static SCE_LOG_LEVEL_ERROR := 1
    static SCE_LOG_LEVEL_DETAIL := 2
    static SCE_LOG_LEVEL_DEBUG := 3
}
struct SCESVC_CONFIGURATION_LINE {
    Key : Int8.Ptr
    Value : Int8.Ptr
    ValueLen : UInt32
}
struct SCESVC_CONFIGURATION_INFO {
    Count : UInt32
    Lines : SCESVC_CONFIGURATION_LINE.Ptr
}
struct SCESVC_INFO_TYPE extends Int32 {
    static SceSvcConfigurationInfo := 0
    static SceSvcMergedPolicyInfo := 1
    static SceSvcAnalysisInfo := 2
    static SceSvcInternalUse := 3
}
struct SCESVC_ANALYSIS_LINE {
    Key : Int8.Ptr
    Value : UInt8.Ptr
    ValueLen : UInt32
}
struct SCESVC_ANALYSIS_INFO {
    Count : UInt32
    Lines : SCESVC_ANALYSIS_LINE.Ptr
}
struct PFSCE_QUERY_INFO extends FunctionPointer {
    static Types := [Struct.Ptr, SCESVC_INFO_TYPE, Int8.Ptr, BOOL, Struct.Ptr.Ptr, UInt32.Ptr, UInt32]
}
struct PFSCE_SET_INFO extends FunctionPointer {
    static Types := [Struct.Ptr, SCESVC_INFO_TYPE, Int8.Ptr, BOOL, Struct.Ptr, UInt32]
}
struct PFSCE_FREE_INFO extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32]
}
struct PFSCE_LOG_INFO extends FunctionPointer {
    static Types := [SCE_LOG_ERR_LEVEL, UInt32, Int8.Ptr, UInt32]
    static Options := "C"
}
struct SCESVC_CALLBACK_INFO {
    sceHandle : Struct.Ptr
    pfQueryInfo : PFSCE_QUERY_INFO
    pfSetInfo : PFSCE_SET_INFO
    pfFreeInfo : PFSCE_FREE_INFO
    pfLogInfo : PFSCE_LOG_INFO
}
struct PF_ConfigAnalyzeService extends FunctionPointer {
    static Types := [SCESVC_CALLBACK_INFO.Ptr, UInt32]
}
struct PF_UpdateService extends FunctionPointer {
    static Types := [SCESVC_CALLBACK_INFO.Ptr, SCESVC_CONFIGURATION_INFO.Ptr, UInt32]
}
struct ISceSvcAttachmentPersistInfo extends IUnknown {
    static IID := "{6D90E0D0-200D-11D1-AFFB-00C04FB984F9}"
    Save(lpTemplateName, scesvcHandle, ppvData, pbOverwriteAll)
      => ComCall(3, this.p, Int8.Ptr, lpTemplateName, Struct.Ptr.Ptr, scesvcHandle, Struct.Ptr.Ptr, ppvData, BOOL.Ptr, pbOverwriteAll)
    IsDirty(lpTemplateName)
      => ComCall(4, this.p, Int8.Ptr, lpTemplateName)
    FreeBuffer(pvData)
      => ComCall(5, this.p, Struct.Ptr, pvData)
}
struct ISceSvcAttachmentData extends IUnknown {
    static IID := "{17C35FDE-200D-11D1-AFFB-00C04FB984F9}"
    GetData(scesvcHandle, sceType, ppvData, psceEnumHandle)
      => ComCall(3, this.p, Struct.Ptr, scesvcHandle, SCESVC_INFO_TYPE, sceType, Struct.Ptr.Ptr, ppvData, UInt32.Ptr, psceEnumHandle)
    Initialize(lpServiceName, lpTemplateName, lpSceSvcPersistInfo, pscesvcHandle)
      => ComCall(4, this.p, Int8.Ptr, lpServiceName, Int8.Ptr, lpTemplateName, ISceSvcAttachmentPersistInfo, lpSceSvcPersistInfo, Struct.Ptr.Ptr, pscesvcHandle)
    FreeBuffer(pvData)
      => ComCall(5, this.p, Struct.Ptr, pvData)
    CloseHandle(scesvcHandle)
      => ComCall(6, this.p, Struct.Ptr, scesvcHandle)
}
