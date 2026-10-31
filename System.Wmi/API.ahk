#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}

MI_Application_InitializeV1(flags, applicationID?, extendedError?, application)
  => DllCall("mi.dll\MI_Application_InitializeV1", UInt32, flags, UInt16.Ptr, applicationID?, MI_Instance.Ptr.Ptr, extendedError?, MI_Application.Ptr, application, MI_Result)
