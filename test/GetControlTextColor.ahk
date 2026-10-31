; Get the text color of a control.
#Requires AutoHotkey v2.1-alpha.37

myGui := Gui()
myGui.OnMessage(0x200, ShowTheColor)
myGui.AddText('cRed', "This is red text.")
myGui.AddText('cGreen', "This is green text.")
myGui.AddText('cBlue', "This is blue text.")
myGui.AddText(, "This is some kind of text.")
myGui.Show()

ShowTheColor(myGui, wParam, lParam, msg) {
    #import "Win32\Foundation\Types.ahk" {HWND}
    #import "Win32\Graphics.Gdi\API.ahk" {GetDC, ReleaseDC, GetTextColor}
    #import "Win32\UI.WindowsAndMessaging\Constants.ahk" {*}
    
    MouseGetPos ,,, &mouseCtrl, 2
    if mouseCtrl == "" {
        ToolTip
        return
    }
    
    hText := HWND(mouseCtrl)
    hdc := GetDC(hText)
    back_color := SendMessage(WM_CTLCOLORSTATIC, hdc.value, hText.value, myGui.hwnd)
    text_color := GetTextColor(hdc)
    ReleaseDC(hText, hdc)

    ToolTip Format("{:06x}", text_color.value)
}
