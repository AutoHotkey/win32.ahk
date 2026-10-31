#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown, MSHLFLAGS}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct CALLFRAMEINFO {
    iMethod : UInt32
    fHasInValues : BOOL
    fHasInOutValues : BOOL
    fHasOutValues : BOOL
    fDerivesFromIDispatch : BOOL
    cInInterfacesMax : Int32
    cInOutInterfacesMax : Int32
    cOutInterfacesMax : Int32
    cTopLevelInInterfaces : Int32
    iid : GUID
    cMethod : UInt32
    cParams : UInt32
}
struct CALLFRAMEPARAMINFO {
    fIn : BOOLEAN
    fOut : BOOLEAN
    stackOffset : UInt32
    cbParam : UInt32
}
struct CALLFRAME_COPY extends Int32 {
    static CALLFRAME_COPY_NESTED := 1
    static CALLFRAME_COPY_INDEPENDENT := 2
}
struct CALLFRAME_FREE extends Int32 {
    static CALLFRAME_FREE_NONE := 0
    static CALLFRAME_FREE_IN := 1
    static CALLFRAME_FREE_INOUT := 2
    static CALLFRAME_FREE_OUT := 4
    static CALLFRAME_FREE_TOP_INOUT := 8
    static CALLFRAME_FREE_TOP_OUT := 16
    static CALLFRAME_FREE_ALL := 31
}
struct CALLFRAME_NULL extends Int32 {
    static CALLFRAME_NULL_NONE := 0
    static CALLFRAME_NULL_INOUT := 2
    static CALLFRAME_NULL_OUT := 4
    static CALLFRAME_NULL_ALL := 6
}
struct CALLFRAME_WALK extends Int32 {
    static CALLFRAME_WALK_IN := 1
    static CALLFRAME_WALK_INOUT := 2
    static CALLFRAME_WALK_OUT := 4
}
struct CALLFRAME_MARSHALCONTEXT {
    fIn : BOOLEAN
    dwDestContext : UInt32
    pvDestContext : Struct.Ptr
    punkReserved : IUnknown
    guidTransferSyntax : GUID
}
struct ICallFrame extends IUnknown {
    static IID := "{D573B4B0-894E-11D2-B8B6-00C04FB9618A}"
    GetInfo(pInfo)
      => ComCall(3, this.p, CALLFRAMEINFO.Ptr, pInfo)
    GetIIDAndMethod(pIID, piMethod)
      => ComCall(4, this.p, GUID.Ptr, pIID, UInt32.Ptr, piMethod)
    GetNames(pwszInterface, pwszMethod)
      => ComCall(5, this.p, PWSTR.Ptr, pwszInterface, PWSTR.Ptr, pwszMethod)
    GetStackLocation()
      => ComCall(6, this.p, Struct.Ptr)
    SetStackLocation(pvStack)
      => ComCall(7, this.p, Struct.Ptr, pvStack, "void")
    SetReturnValue(hr)
      => ComCall(8, this.p, HRESULT, hr, "void")
    GetReturnValue()
      => ComCall(9, this.p)
    GetParamInfo(iparam, pInfo)
      => ComCall(10, this.p, UInt32, iparam, CALLFRAMEPARAMINFO.Ptr, pInfo)
    SetParam(iparam, pvar)
      => ComCall(11, this.p, UInt32, iparam, VARIANT.Ptr, pvar)
    GetParam(iparam, pvar)
      => ComCall(12, this.p, UInt32, iparam, VARIANT.Ptr, pvar)
    Copy(copyControl, pWalker, ppFrame)
      => ComCall(13, this.p, CALLFRAME_COPY, copyControl, ICallFrameWalker, pWalker, ICallFrame.Ptr, ppFrame)
    Free(pframeArgsDest, pWalkerDestFree, pWalkerCopy, freeFlags, pWalkerFree, nullFlags)
      => ComCall(14, this.p, ICallFrame, pframeArgsDest, ICallFrameWalker, pWalkerDestFree, ICallFrameWalker, pWalkerCopy, UInt32, freeFlags, ICallFrameWalker, pWalkerFree, UInt32, nullFlags)
    FreeParam(iparam, freeFlags, pWalkerFree, nullFlags)
      => ComCall(15, this.p, UInt32, iparam, UInt32, freeFlags, ICallFrameWalker, pWalkerFree, UInt32, nullFlags)
    WalkFrame(walkWhat, pWalker)
      => ComCall(16, this.p, UInt32, walkWhat, ICallFrameWalker, pWalker)
    GetMarshalSizeMax(pmshlContext, mshlflags1, pcbBufferNeeded)
      => ComCall(17, this.p, CALLFRAME_MARSHALCONTEXT.Ptr, pmshlContext, MSHLFLAGS, mshlflags1, UInt32.Ptr, pcbBufferNeeded)
    Marshal(pmshlContext, mshlflags1, pBuffer, pcbBufferUsed, pdataRep, prpcFlags)
      => ComCall(18, this.p, CALLFRAME_MARSHALCONTEXT.Ptr, pmshlContext, MSHLFLAGS, mshlflags1, Struct.Ptr, pBuffer, UInt32, pBuffer.Length, UInt32.Ptr, pcbBufferUsed, UInt32.Ptr, pdataRep, UInt32.Ptr, prpcFlags)
    Unmarshal(pBuffer, dataRep, pcontext, pcbUnmarshalled)
      => ComCall(19, this.p, Struct.Ptr, pBuffer, UInt32, pBuffer.Length, UInt32, dataRep, CALLFRAME_MARSHALCONTEXT.Ptr, pcontext, UInt32.Ptr, pcbUnmarshalled)
    ReleaseMarshalData(pBuffer, ibFirstRelease, dataRep, pcontext)
      => ComCall(20, this.p, Struct.Ptr, pBuffer, UInt32, pBuffer.Length, UInt32, ibFirstRelease, UInt32, dataRep, CALLFRAME_MARSHALCONTEXT.Ptr, pcontext)
    Invoke(pvReceiver)
      => ComCall(21, this.p, Struct.Ptr, pvReceiver)
}
struct ICallIndirect extends IUnknown {
    static IID := "{D573B4B1-894E-11D2-B8B6-00C04FB9618A}"
    CallIndirect(phrReturn, iMethod, pvArgs, cbArgs)
      => ComCall(3, this.p, HRESULT.Ptr, phrReturn, UInt32, iMethod, Struct.Ptr, pvArgs, UInt32.Ptr, cbArgs)
    GetMethodInfo(iMethod, pInfo, pwszMethod)
      => ComCall(4, this.p, UInt32, iMethod, CALLFRAMEINFO.Ptr, pInfo, PWSTR.Ptr, pwszMethod)
    GetStackSize(iMethod, cbArgs)
      => ComCall(5, this.p, UInt32, iMethod, UInt32.Ptr, cbArgs)
    GetIID(piid?, pfDerivesFromIDispatch?, pcMethod?, pwszInterface)
      => ComCall(6, this.p, GUID.Ptr, piid?, BOOL.Ptr, pfDerivesFromIDispatch?, UInt32.Ptr, pcMethod?, PWSTR.Ptr, pwszInterface)
}
struct ICallInterceptor extends ICallIndirect {
    static IID := "{60C7CA75-896D-11D2-B8B6-00C04FB9618A}"
    RegisterSink(psink)
      => ComCall(7, this.p, ICallFrameEvents, psink)
    GetRegisteredSink(ppsink)
      => ComCall(8, this.p, ICallFrameEvents.Ptr, ppsink)
}
struct ICallFrameEvents extends IUnknown {
    static IID := "{FD5E0843-FC91-11D0-97D7-00C04FB9618A}"
    OnCall(pFrame)
      => ComCall(3, this.p, ICallFrame, pFrame)
}
struct ICallUnmarshal extends IUnknown {
    static IID := "{5333B003-2E42-11D2-B89D-00C04FB9618A}"
    Unmarshal(iMethod, pBuffer, fForceBufferCopy, dataRep, pcontext, pcbUnmarshalled, ppFrame)
      => ComCall(3, this.p, UInt32, iMethod, Struct.Ptr, pBuffer, UInt32, pBuffer.Length, BOOL, fForceBufferCopy, UInt32, dataRep, CALLFRAME_MARSHALCONTEXT.Ptr, pcontext, UInt32.Ptr, pcbUnmarshalled, ICallFrame.Ptr, ppFrame)
    ReleaseMarshalData(iMethod, pBuffer, ibFirstRelease, dataRep, pcontext)
      => ComCall(4, this.p, UInt32, iMethod, Struct.Ptr, pBuffer, UInt32, pBuffer.Length, UInt32, ibFirstRelease, UInt32, dataRep, CALLFRAME_MARSHALCONTEXT.Ptr, pcontext)
}
struct ICallFrameWalker extends IUnknown {
    static IID := "{08B23919-392D-11D2-B8A4-00C04FB9618A}"
    OnWalkInterface(iid, ppvInterface, fIn, fOut)
      => ComCall(3, this.p, GUID.Ptr, iid, Struct.Ptr.Ptr, ppvInterface, BOOL, fIn, BOOL, fOut)
}
struct IInterfaceRelated extends IUnknown {
    static IID := "{D1FB5A79-7706-11D1-ADBA-00C04FC2ADC0}"
    SetIID(iid)
      => ComCall(3, this.p, GUID.Ptr, iid)
    GetIID(piid)
      => ComCall(4, this.p, GUID.Ptr, piid)
}
