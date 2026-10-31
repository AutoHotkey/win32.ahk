#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, HWND, PWSTR}
#Import "..\Security.Cryptography\Types.ahk" {CERT_CONTEXT, HCERTSTORE}

CertSelectionGetSerializedBlob(pcsi, ppOutBuffer, pulOutBufferSize)
  => DllCall("CRYPTUI.dll\CertSelectionGetSerializedBlob", CERT_SELECTUI_INPUT.Ptr, pcsi, Struct.Ptr.Ptr, ppOutBuffer, UInt32.Ptr, pulOutBufferSize, "HRESULT")
CryptUIDlgCertMgr(pCryptUICertMgr)
  => DllCall("CRYPTUI.dll\CryptUIDlgCertMgr", CRYPTUI_CERT_MGR_STRUCT.Ptr, pCryptUICertMgr, BOOL)
CryptUIDlgSelectCertificateFromStore(hCertStore1, hwnd1?, pwszTitle?, pwszDisplayString?, dwDontUseColumn, dwFlags, pvReserved)
  => DllCall("CRYPTUI.dll\CryptUIDlgSelectCertificateFromStore", HCERTSTORE, hCertStore1, HWND, hwnd1?, "Str", pwszTitle?, "Str", pwszDisplayString?, UInt32, dwDontUseColumn, UInt32, dwFlags, Struct.Ptr, pvReserved, CERT_CONTEXT.Ptr)
CryptUIDlgViewCertificate(pCertViewInfo, pfPropertiesChanged)
  => DllCall("CRYPTUI.dll\CryptUIDlgViewCertificateW", CRYPTUI_VIEWCERTIFICATE_STRUCTW.Ptr, pCertViewInfo, BOOL.Ptr, pfPropertiesChanged, BOOL)
CryptUIDlgViewContext(dwContextType, pvContext, hwnd1?, pwszTitle?, dwFlags, pvReserved)
  => DllCall("CRYPTUI.dll\CryptUIDlgViewContext", UInt32, dwContextType, Struct.Ptr, pvContext, HWND, hwnd1?, "Str", pwszTitle?, UInt32, dwFlags, Struct.Ptr, pvReserved, BOOL)
CryptUIWizDigitalSign(dwFlags, hwndParent?, pwszWizardTitle?, pDigitalSignInfo, ppSignContext?)
  => DllCall("CRYPTUI.dll\CryptUIWizDigitalSign", UInt32, dwFlags, HWND, hwndParent?, "Str", pwszWizardTitle?, CRYPTUI_WIZ_DIGITAL_SIGN_INFO.Ptr, pDigitalSignInfo, CRYPTUI_WIZ_DIGITAL_SIGN_CONTEXT.Ptr.Ptr, ppSignContext?, BOOL)
CryptUIWizFreeDigitalSignContext(pSignContext)
  => DllCall("CRYPTUI.dll\CryptUIWizFreeDigitalSignContext", CRYPTUI_WIZ_DIGITAL_SIGN_CONTEXT.Ptr, pSignContext, BOOL)
