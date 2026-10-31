#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOLEAN, PWSTR}

MSChapSrvChangePassword(ServerName, UserName, LmOldPresent, LmOldOwfPassword, LmNewOwfPassword, NtOldOwfPassword, NtNewOwfPassword)
  => DllCall("ADVAPI32.dll\MSChapSrvChangePassword", "Str", ServerName, "Str", UserName, BOOLEAN, LmOldPresent, LM_OWF_PASSWORD.Ptr, LmOldOwfPassword, LM_OWF_PASSWORD.Ptr, LmNewOwfPassword, LM_OWF_PASSWORD.Ptr, NtOldOwfPassword, LM_OWF_PASSWORD.Ptr, NtNewOwfPassword, UInt32)
MSChapSrvChangePassword2(ServerName, UserName, NewPasswordEncryptedWithOldNt, OldNtOwfPasswordEncryptedWithNewNt, LmPresent, NewPasswordEncryptedWithOldLm, OldLmOwfPasswordEncryptedWithNewLmOrNt)
  => DllCall("ADVAPI32.dll\MSChapSrvChangePassword2", "Str", ServerName, "Str", UserName, SAMPR_ENCRYPTED_USER_PASSWORD.Ptr, NewPasswordEncryptedWithOldNt, ENCRYPTED_LM_OWF_PASSWORD.Ptr, OldNtOwfPasswordEncryptedWithNewNt, BOOLEAN, LmPresent, SAMPR_ENCRYPTED_USER_PASSWORD.Ptr, NewPasswordEncryptedWithOldLm, ENCRYPTED_LM_OWF_PASSWORD.Ptr, OldLmOwfPasswordEncryptedWithNewLmOrNt, UInt32)
