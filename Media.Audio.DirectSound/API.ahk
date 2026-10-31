#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT, HWND}
#Import "..\System.Com\Types.ahk" {IUnknown}

DirectSoundCaptureCreate(pcGuidDevice?, ppDSC, pUnkOuter?)
  => DllCall("DSOUND.dll\DirectSoundCaptureCreate", GUID.Ptr, pcGuidDevice?, IDirectSoundCapture.Ptr, ppDSC, IUnknown, pUnkOuter?, "HRESULT")
DirectSoundCaptureCreate8(pcGuidDevice?, ppDSC8, pUnkOuter?)
  => DllCall("DSOUND.dll\DirectSoundCaptureCreate8", GUID.Ptr, pcGuidDevice?, IDirectSoundCapture.Ptr, ppDSC8, IUnknown, pUnkOuter?, "HRESULT")
DirectSoundCaptureEnumerate(pDSEnumCallback, pContext?)
  => DllCall("DSOUND.dll\DirectSoundCaptureEnumerateW", LPDSENUMCALLBACKW, pDSEnumCallback, Struct.Ptr, pContext?, "HRESULT")
DirectSoundCreate(pcGuidDevice?, ppDS, pUnkOuter?)
  => DllCall("DSOUND.dll\DirectSoundCreate", GUID.Ptr, pcGuidDevice?, IDirectSound.Ptr, ppDS, IUnknown, pUnkOuter?, "HRESULT")
DirectSoundCreate8(pcGuidDevice?, ppDS8, pUnkOuter?)
  => DllCall("DSOUND.dll\DirectSoundCreate8", GUID.Ptr, pcGuidDevice?, IDirectSound8.Ptr, ppDS8, IUnknown, pUnkOuter?, "HRESULT")
DirectSoundEnumerate(pDSEnumCallback, pContext?)
  => DllCall("DSOUND.dll\DirectSoundEnumerateW", LPDSENUMCALLBACKW, pDSEnumCallback, Struct.Ptr, pContext?, "HRESULT")
DirectSoundFullDuplexCreate(pcGuidCaptureDevice?, pcGuidRenderDevice?, pcDSCBufferDesc, pcDSBufferDesc, hWnd1, dwLevel, ppDSFD, ppDSCBuffer8, ppDSBuffer8, pUnkOuter?)
  => DllCall("DSOUND.dll\DirectSoundFullDuplexCreate", GUID.Ptr, pcGuidCaptureDevice?, GUID.Ptr, pcGuidRenderDevice?, DSCBUFFERDESC.Ptr, pcDSCBufferDesc, DSBUFFERDESC.Ptr, pcDSBufferDesc, HWND, hWnd1, UInt32, dwLevel, IDirectSoundFullDuplex.Ptr, ppDSFD, IDirectSoundCaptureBuffer8.Ptr, ppDSCBuffer8, IDirectSoundBuffer8.Ptr, ppDSBuffer8, IUnknown, pUnkOuter?, "HRESULT")
GetDeviceID(pGuidSrc?, pGuidDest)
  => DllCall("DSOUND.dll\GetDeviceID", GUID.Ptr, pGuidSrc?, GUID.Ptr, pGuidDest, "HRESULT")
