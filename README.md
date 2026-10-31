# MakeWin32.ahk

This script generates a "projection" of the Win32 API for AutoHotkey v2.1 based on metadata provided by the [win32metadata](https://github.com/microsoft/win32metadata/) project.

This is an early preview version.

`MakeWin32.ahk` parses `Win32metadata.winmd` and generates script files, writing them to the `test\Win32` directory. It also copies some necessary source files from the `input` directory.

Requirements:
  - AutoHotkey v2.1-alpha... (check `#Requires` at the top of the script).
  - `Win32metadata.winmd` from the [win32metadata NuGet package](https://www.nuget.org/packages/Microsoft.Windows.SDK.Win32Metadata/).

**Note:** This script and the metadata file are required only to build the projection, not to use it.

Refer to [Releases](https://github.com/AutoHotkey/win32.ahk/releases), the `output` git branch or `lib/*` tags for usable libraries and usage documentation.
