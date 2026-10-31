#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, HWND, PWSTR}

ChooseColor(param0)
  => DllCall("COMDLG32.dll\ChooseColorW", CHOOSECOLORW.Ptr, param0, BOOL)
ChooseFont(param0)
  => DllCall("COMDLG32.dll\ChooseFontW", CHOOSEFONTW.Ptr, param0, BOOL)
CommDlgExtendedError()
  => DllCall("COMDLG32.dll\CommDlgExtendedError", COMMON_DLG_ERRORS)
FindText(param0)
  => DllCall("COMDLG32.dll\FindTextW", FINDREPLACEW.Ptr, param0, HWND)
GetFileTitle(param0, Buf)
  => DllCall("COMDLG32.dll\GetFileTitleW", "Str", param0, PWSTR, Buf, UInt16, Buf.Length, Int16)
GetOpenFileName(param0)
  => DllCall("COMDLG32.dll\GetOpenFileNameW", OPENFILENAMEW.Ptr, param0, BOOL)
GetSaveFileName(param0)
  => DllCall("COMDLG32.dll\GetSaveFileNameW", OPENFILENAMEW.Ptr, param0, BOOL)
PageSetupDlg(param0)
  => DllCall("COMDLG32.dll\PageSetupDlgW", PAGESETUPDLGW.Ptr, param0, BOOL)
PrintDlg(pPD)
  => DllCall("COMDLG32.dll\PrintDlgW", PRINTDLGW.Ptr, pPD, BOOL)
PrintDlgEx(pPD)
  => DllCall("COMDLG32.dll\PrintDlgExW", PRINTDLGEXW.Ptr, pPD, "HRESULT")
ReplaceText(param0)
  => DllCall("COMDLG32.dll\ReplaceTextW", FINDREPLACEW.Ptr, param0, HWND)
