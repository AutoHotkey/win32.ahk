#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HRESULT}

GameInputCreate(gameInput)
  => DllCall("GameInput.dll\GameInputCreate", IGameInput.Ptr, gameInput, "HRESULT")
