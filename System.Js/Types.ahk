#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct JsRuntimeVersion extends Int32 {
    static JsRuntimeVersion10 := 0
    static JsRuntimeVersion11 := 1
    static JsRuntimeVersionEdge := -1
}
struct JsErrorCode extends UInt32 {
    static JsNoError := 0
    static JsErrorCategoryUsage := 65536
    static JsErrorInvalidArgument := 65537
    static JsErrorNullArgument := 65538
    static JsErrorNoCurrentContext := 65539
    static JsErrorInExceptionState := 65540
    static JsErrorNotImplemented := 65541
    static JsErrorWrongThread := 65542
    static JsErrorRuntimeInUse := 65543
    static JsErrorBadSerializedScript := 65544
    static JsErrorInDisabledState := 65545
    static JsErrorCannotDisableExecution := 65546
    static JsErrorHeapEnumInProgress := 65547
    static JsErrorArgumentNotObject := 65548
    static JsErrorInProfileCallback := 65549
    static JsErrorInThreadServiceCallback := 65550
    static JsErrorCannotSerializeDebugScript := 65551
    static JsErrorAlreadyDebuggingContext := 65552
    static JsErrorAlreadyProfilingContext := 65553
    static JsErrorIdleNotEnabled := 65554
    static JsErrorCategoryEngine := 131072
    static JsErrorOutOfMemory := 131073
    static JsErrorCategoryScript := 196608
    static JsErrorScriptException := 196609
    static JsErrorScriptCompile := 196610
    static JsErrorScriptTerminated := 196611
    static JsErrorScriptEvalDisabled := 196612
    static JsErrorCategoryFatal := 262144
    static JsErrorFatal := 262145
}
struct JsRuntimeAttributes extends Int32 {
    static JsRuntimeAttributeNone := 0
    static JsRuntimeAttributeDisableBackgroundWork := 1
    static JsRuntimeAttributeAllowScriptInterrupt := 2
    static JsRuntimeAttributeEnableIdleProcessing := 4
    static JsRuntimeAttributeDisableNativeCodeGeneration := 8
    static JsRuntimeAttributeDisableEval := 16
}
struct JsMemoryEventType extends Int32 {
    static JsMemoryAllocate := 0
    static JsMemoryFree := 1
    static JsMemoryFailure := 2
}
struct JsMemoryAllocationCallback extends FunctionPointer {
    static Types := [Struct.Ptr, JsMemoryEventType, IntPtr, Boolean8]
}
struct JsBeforeCollectCallback extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct JsBackgroundWorkItemCallback extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct JsThreadServiceCallback extends FunctionPointer {
    static Types := [JsBackgroundWorkItemCallback, Struct.Ptr, Boolean8]
}
struct JsValueType extends Int32 {
    static JsUndefined := 0
    static JsNull := 1
    static JsNumber := 2
    static JsString := 3
    static JsBoolean := 4
    static JsObject := 5
    static JsFunction := 6
    static JsError := 7
    static JsArray := 8
}
struct JsFinalizeCallback extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct JsNativeFunction extends FunctionPointer {
    static Types := [Struct.Ptr, Boolean8, Struct.Ptr.Ptr, UInt16, Struct.Ptr, Struct.Ptr]
}
