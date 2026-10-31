#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, HWND}

CredWrite(Credential, Flags)
  => DllCall("ADVAPI32.dll\CredWriteW", CREDENTIALW.Ptr, Credential, UInt32, Flags, BOOL)
KeyCredentialManagerFreeInformation(keyCredentialManagerInfo)
  => DllCall("KeyCredMgr.dll\KeyCredentialManagerFreeInformation", KeyCredentialManagerInfo.Ptr, keyCredentialManagerInfo, "void")
KeyCredentialManagerGetInformation(keyCredentialManagerInfo)
  => DllCall("KeyCredMgr.dll\KeyCredentialManagerGetInformation", KeyCredentialManagerInfo.Ptr.Ptr, keyCredentialManagerInfo, "HRESULT")
KeyCredentialManagerGetOperationErrorStates(keyCredentialManagerOperationType1, isReady, keyCredentialManagerOperationErrorStates)
  => DllCall("KeyCredMgr.dll\KeyCredentialManagerGetOperationErrorStates", KeyCredentialManagerOperationType, keyCredentialManagerOperationType1, BOOL.Ptr, isReady, KeyCredentialManagerOperationErrorStates.Ptr, keyCredentialManagerOperationErrorStates, "HRESULT")
KeyCredentialManagerShowUIOperation(hWndOwner, keyCredentialManagerOperationType1)
  => DllCall("KeyCredMgr.dll\KeyCredentialManagerShowUIOperation", HWND, hWndOwner, KeyCredentialManagerOperationType, keyCredentialManagerOperationType1, "HRESULT")
