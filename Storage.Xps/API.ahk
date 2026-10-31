#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HWND, PSTR, PWSTR}
#Import "..\Graphics.Gdi\Types.ahk" {DEVMODEW, HDC}

AbortDoc(hdc1)
  => DllCall("GDI32.dll\AbortDoc", HDC, hdc1, Int32)
DeviceCapabilities(pDevice, pPort?, fwCapability, pOutput?, pDevMode?)
  => DllCall("winspool.drv\DeviceCapabilitiesW", "Str", pDevice, "Str", pPort?, PRINTER_DEVICE_CAPABILITIES, fwCapability, PWSTR, pOutput?, DEVMODEW.Ptr, pDevMode?, Int32)
EndDoc(hdc1)
  => DllCall("GDI32.dll\EndDoc", HDC, hdc1, Int32)
EndPage(hdc1)
  => DllCall("GDI32.dll\EndPage", HDC, hdc1, Int32)
Escape(hdc1, iEscape, pvIn?, pvOut?)
  => DllCall("GDI32.dll\Escape", HDC, hdc1, Int32, iEscape, Int32, pvIn?.Size ?? 0, PSTR, pvIn?, Struct.Ptr, pvOut?, Int32)
ExtEscape(hdc1, iEscape, lpInData?, lpOutData?)
  => DllCall("GDI32.dll\ExtEscape", HDC, hdc1, Int32, iEscape, Int32, lpInData?.Size ?? 0, PSTR, lpInData?, Int32, lpOutData?.Size ?? 0, PSTR, lpOutData?, Int32)
PrintWindow(hwnd1, hdcBlt, nFlags)
  => DllCall("USER32.dll\PrintWindow", HWND, hwnd1, HDC, hdcBlt, PRINT_WINDOW_FLAGS, nFlags, BOOL)
SetAbortProc(hdc1, proc)
  => DllCall("GDI32.dll\SetAbortProc", HDC, hdc1, ABORTPROC, proc, Int32)
StartDoc(hdc1, lpdi)
  => DllCall("GDI32.dll\StartDocW", HDC, hdc1, DOCINFOW.Ptr, lpdi, Int32)
StartPage(hdc1)
  => DllCall("GDI32.dll\StartPage", HDC, hdc1, Int32)
