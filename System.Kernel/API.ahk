#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}

RtlFirstEntrySList(ListHead)
  => DllCall("ntdll.dll\RtlFirstEntrySList", SLIST_HEADER.Ptr, ListHead, SLIST_ENTRY.Ptr)
RtlInitializeSListHead(ListHead)
  => DllCall("ntdll.dll\RtlInitializeSListHead", SLIST_HEADER.Ptr, ListHead, "void")
RtlInterlockedFlushSList(ListHead)
  => DllCall("ntdll.dll\RtlInterlockedFlushSList", SLIST_HEADER.Ptr, ListHead, SLIST_ENTRY.Ptr)
RtlInterlockedPopEntrySList(ListHead)
  => DllCall("ntdll.dll\RtlInterlockedPopEntrySList", SLIST_HEADER.Ptr, ListHead, SLIST_ENTRY.Ptr)
RtlInterlockedPushEntrySList(ListHead, ListEntry)
  => DllCall("ntdll.dll\RtlInterlockedPushEntrySList", SLIST_HEADER.Ptr, ListHead, SLIST_ENTRY.Ptr, ListEntry, SLIST_ENTRY.Ptr)
RtlInterlockedPushListSListEx(ListHead, List, ListEnd, Count)
  => DllCall("ntdll.dll\RtlInterlockedPushListSListEx", SLIST_HEADER.Ptr, ListHead, SLIST_ENTRY.Ptr, List, SLIST_ENTRY.Ptr, ListEnd, UInt32, Count, SLIST_ENTRY.Ptr)
RtlQueryDepthSList(ListHead)
  => DllCall("ntdll.dll\RtlQueryDepthSList", SLIST_HEADER.Ptr, ListHead, UInt16)
