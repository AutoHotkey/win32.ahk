#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\System.Com\Types.ahk" {IUnknown}

CreateAudioReverb(ppApo)
  => DllCall("XAudio2_8.dll\CreateAudioReverb", IUnknown.Ptr, ppApo, "HRESULT")
CreateAudioVolumeMeter(ppApo)
  => DllCall("XAudio2_8.dll\CreateAudioVolumeMeter", IUnknown.Ptr, ppApo, "HRESULT")
CreateFX(clsid, pEffect, pInitDat?)
  => DllCall("XAudio2_8.dll\CreateFX", GUID.Ptr, clsid, IUnknown.Ptr, pEffect, Struct.Ptr, pInitDat?, UInt32, pInitDat?.Size ?? 0, "HRESULT")
CreateHrtfApo(init, xApo)
  => DllCall("HrtfApo.dll\CreateHrtfApo", HrtfApoInit.Ptr, init, IXAPO.Ptr, xApo, "HRESULT")
XAudio2CreateWithVersionInfo(ppXAudio2, Flags, XAudio2Processor, ntddiVersion)
  => DllCall("XAudio2_8.dll\XAudio2CreateWithVersionInfo", IXAudio2.Ptr, ppXAudio2, UInt32, Flags, UInt32, XAudio2Processor, UInt32, ntddiVersion, "HRESULT")
