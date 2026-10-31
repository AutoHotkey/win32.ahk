#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\System.AddressBook\Types.ahk" {IMessage, LPALLOCATEBUFFER, LPALLOCATEMORE, LPFREEBUFFER, SPropProblemArray, SPropTagArray}
#Import "..\System.Com\Types.ahk" {IMalloc}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IStorage}

CloseIMsgSession(lpMsgSess1)
  => DllCall("MAPI32.dll\CloseIMsgSession", LPMSGSESS, lpMsgSess1, "void")
GetAttribIMsgOnIStg(lpObject, lpPropTagArray, lppPropAttrArray)
  => DllCall("MAPI32.dll\GetAttribIMsgOnIStg", Struct.Ptr, lpObject, SPropTagArray.Ptr, lpPropTagArray, SPropAttrArray.Ptr.Ptr, lppPropAttrArray, "HRESULT")
MapStorageSCode(StgSCode)
  => DllCall("MAPI32.dll\MapStorageSCode", Int32, StgSCode, Int32)
OpenIMsgOnIStg(lpMsgSess1, lpAllocateBuffer1, lpAllocateMore1, lpFreeBuffer1, lpMalloc, lpMapiSup, lpStg, lpfMsgCallRelease, ulCallerData, ulFlags, lppMsg)
  => DllCall("MAPI32.dll\OpenIMsgOnIStg", LPMSGSESS, lpMsgSess1, LPALLOCATEBUFFER, lpAllocateBuffer1, LPALLOCATEMORE, lpAllocateMore1, LPFREEBUFFER, lpFreeBuffer1, IMalloc, lpMalloc, Struct.Ptr, lpMapiSup, IStorage, lpStg, MSGCALLRELEASE.Ptr, lpfMsgCallRelease, UInt32, ulCallerData, UInt32, ulFlags, IMessage.Ptr, lppMsg, Int32)
OpenIMsgSession(lpMalloc, ulFlags, lppMsgSess)
  => DllCall("MAPI32.dll\OpenIMsgSession", IMalloc, lpMalloc, UInt32, ulFlags, LPMSGSESS.Ptr, lppMsgSess, Int32)
SetAttribIMsgOnIStg(lpObject, lpPropTags, lpPropAttrs, lppPropProblems)
  => DllCall("MAPI32.dll\SetAttribIMsgOnIStg", Struct.Ptr, lpObject, SPropTagArray.Ptr, lpPropTags, SPropAttrArray.Ptr, lpPropAttrs, SPropProblemArray.Ptr.Ptr, lppPropProblems, "HRESULT")
