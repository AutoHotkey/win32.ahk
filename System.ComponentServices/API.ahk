#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\System.Com\Types.ahk" {APTTYPE, IUnknown}

CoCreateActivity(pIUnknown, riid, ppObj)
  => DllCall("comsvcs.dll\CoCreateActivity", IUnknown, pIUnknown, GUID.Ptr, riid, Struct.Ptr.Ptr, ppObj, "HRESULT")
CoEnterServiceDomain(pConfigObject)
  => DllCall("comsvcs.dll\CoEnterServiceDomain", IUnknown, pConfigObject, "HRESULT")
CoGetDefaultContext(aptType1, riid, ppv)
  => DllCall("OLE32.dll\CoGetDefaultContext", APTTYPE, aptType1, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv, "HRESULT")
CoLeaveServiceDomain(pUnkStatus)
  => DllCall("comsvcs.dll\CoLeaveServiceDomain", IUnknown, pUnkStatus, "void")
GetDispenserManager(param0)
  => DllCall("MTxDM.dll\GetDispenserManager", IDispenserManager.Ptr, param0, "HRESULT")
GetManagedExtensions(dwExts)
  => DllCall("comsvcs.dll\GetManagedExtensions", UInt32.Ptr, dwExts, "HRESULT")
MTSCreateActivity(riid, ppobj)
  => DllCall("comsvcs.dll\MTSCreateActivity", GUID.Ptr, riid, Struct.Ptr.Ptr, ppobj, "HRESULT")
RecycleSurrogate(lReasonCode)
  => DllCall("comsvcs.dll\RecycleSurrogate", Int32, lReasonCode, "HRESULT")
SafeRef(rid, pUnk)
  => DllCall("comsvcs.dll\SafeRef", GUID.Ptr, rid, IUnknown, pUnk, Struct.Ptr)
