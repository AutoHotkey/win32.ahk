#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, HANDLE, HRESULT, HTASK, HWND, LPARAM, LRESULT, POINT, PSTR, PWSTR, RECT}
#Import "..\Graphics.Gdi\Types.ahk" {BITMAPINFO, BITMAPINFOHEADER, HDC, HPALETTE, PALETTEENTRY}
#Import "..\Media\Types.ahk" {LPTIMECALLBACK}
#Import "..\Media.Audio\Types.ahk" {HMIXER, HWAVE, WAVEFORMAT, WAVEFORMATEX, WAVEHDR}
#Import "..\System.Com\Types.ahk" {IPersistFile, IUnknown}
#Import "..\System.IO\Types.ahk" {OVERLAPPED}
#Import "..\UI.Controls\Types.ahk" {LPFNSVADDPROPSHEETPAGE}

struct HMMIO {
    Value : IntPtr
}
struct HDRVR {
    Value : IntPtr
}
struct HIC {
    Value : IntPtr
}
struct HVIDEO {
    Value : IntPtr
}
struct ADPCMCOEFSET {
    iCoef1 : Int16
    iCoef2 : Int16
}
struct ADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
    wSamplesPerBlock : UInt16
    wNumCoef : UInt16
    aCoef : ADPCMCOEFSET[1]
}
struct DRMWAVEFORMAT {
    wfx : WAVEFORMATEX
    wReserved : UInt16
    ulContentId : UInt32
    wfxSecure : WAVEFORMATEX
}
struct DVIADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
    wSamplesPerBlock : UInt16
}
struct IMAADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
    wSamplesPerBlock : UInt16
}
struct MEDIASPACEADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
    wRevision : UInt16
}
struct SIERRAADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
    wRevision : UInt16
}
struct G723_ADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
    cbExtraSize : UInt16
    nAuxBlockSize : UInt16
}
struct DIGISTDWAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct DIGIFIXWAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct DIALOGICOKIADPCMWAVEFORMAT {
    ewf : WAVEFORMATEX
}
struct YAMAHA_ADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct SONARCWAVEFORMAT {
    wfx : WAVEFORMATEX
    wCompType : UInt16
}
struct TRUESPEECHWAVEFORMAT {
    wfx : WAVEFORMATEX
    wRevision : UInt16
    nSamplesPerBlock : UInt16
    abReserved : UInt8[28]
}
struct ECHOSC1WAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct AUDIOFILE_AF36WAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct APTXWAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct AUDIOFILE_AF10WAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct DOLBYAC2WAVEFORMAT {
    wfx : WAVEFORMATEX
    nAuxBitsCode : UInt16
}
struct GSM610WAVEFORMAT {
    wfx : WAVEFORMATEX
    wSamplesPerBlock : UInt16
}
struct ADPCMEWAVEFORMAT {
    wfx : WAVEFORMATEX
    wSamplesPerBlock : UInt16
}
struct CONTRESVQLPCWAVEFORMAT {
    wfx : WAVEFORMATEX
    wSamplesPerBlock : UInt16
}
struct DIGIREALWAVEFORMAT {
    wfx : WAVEFORMATEX
    wSamplesPerBlock : UInt16
}
struct DIGIADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
    wSamplesPerBlock : UInt16
}
struct CONTRESCR10WAVEFORMAT {
    wfx : WAVEFORMATEX
    wSamplesPerBlock : UInt16
}
struct NMS_VBXADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
    wSamplesPerBlock : UInt16
}
struct G721_ADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
    nAuxBlockSize : UInt16
}
struct MSAUDIO1WAVEFORMAT {
    wfx : WAVEFORMATEX
    wSamplesPerBlock : UInt16
    wEncodeOptions : UInt16
}
struct WMAUDIO2WAVEFORMAT {
    wfx : WAVEFORMATEX
    dwSamplesPerBlock : UInt32
    wEncodeOptions : UInt16
    dwSuperBlockAlign : UInt32
}
struct WMAUDIO3WAVEFORMAT {
    wfx : WAVEFORMATEX
    wValidBitsPerSample : UInt16
    dwChannelMask : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    wEncodeOptions : UInt16
    wReserved3 : UInt16
}
struct CREATIVEADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
    wRevision : UInt16
}
struct CREATIVEFASTSPEECH8WAVEFORMAT {
    wfx : WAVEFORMATEX
    wRevision : UInt16
}
struct CREATIVEFASTSPEECH10WAVEFORMAT {
    wfx : WAVEFORMATEX
    wRevision : UInt16
}
struct FMTOWNS_SND_WAVEFORMAT {
    wfx : WAVEFORMATEX
    wRevision : UInt16
}
struct OLIGSMWAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct OLIADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct OLICELPWAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct OLISBCWAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct OLIOPRWAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct CSIMAADPCMWAVEFORMAT {
    wfx : WAVEFORMATEX
}
struct s_RIFFWAVE_inst {
    bUnshiftedNote : UInt8
    chFineTune : CHAR
    chGain : CHAR
    bLowNote : UInt8
    bHighNote : UInt8
    bLowVelocity : UInt8
    bHighVelocity : UInt8
}
struct EXBMINFOHEADER {
    bmi : BITMAPINFOHEADER
    biExtDataOffset : UInt32
}
struct JPEGINFOHEADER {
    JPEGSize : UInt32
    JPEGProcess : UInt32
    JPEGColorSpaceID : UInt32
    JPEGBitsPerSample : UInt32
    JPEGHSubSampling : UInt32
    JPEGVSubSampling : UInt32
}
struct YIELDPROC extends FunctionPointer {
    static Types := [UInt32, UInt32, UInt32]
}
struct MCI_GENERIC_PARMS {
    dwCallback : IntPtr
}
struct MCI_OPEN_PARMSA {
    dwCallback : IntPtr
    wDeviceID : UInt32
    lpstrDeviceType : PSTR
    lpstrElementName : PSTR
    lpstrAlias : PSTR
}
struct MCI_OPEN_PARMSW {
    dwCallback : IntPtr
    wDeviceID : UInt32
    lpstrDeviceType : PWSTR
    lpstrElementName : PWSTR
    lpstrAlias : PWSTR
}
struct MCI_PLAY_PARMS {
    dwCallback : IntPtr
    dwFrom : UInt32
    dwTo : UInt32
}
struct MCI_SEEK_PARMS {
    dwCallback : IntPtr
    dwTo : UInt32
}
struct MCI_STATUS_PARMS {
    dwCallback : IntPtr
    dwReturn : IntPtr
    dwItem : UInt32
    dwTrack : UInt32
}
struct MCI_INFO_PARMSA {
    dwCallback : IntPtr
    lpstrReturn : PSTR
    dwRetSize : UInt32
}
struct MCI_INFO_PARMSW {
    dwCallback : IntPtr
    lpstrReturn : PWSTR
    dwRetSize : UInt32
}
struct MCI_GETDEVCAPS_PARMS {
    dwCallback : IntPtr
    dwReturn : UInt32
    dwItem : UInt32
}
struct MCI_SYSINFO_PARMSA {
    dwCallback : IntPtr
    lpstrReturn : PSTR
    dwRetSize : UInt32
    dwNumber : UInt32
    wDeviceType : UInt32
}
struct MCI_SYSINFO_PARMSW {
    dwCallback : IntPtr
    lpstrReturn : PWSTR
    dwRetSize : UInt32
    dwNumber : UInt32
    wDeviceType : UInt32
}
struct MCI_SET_PARMS {
    dwCallback : IntPtr
    dwTimeFormat : UInt32
    dwAudio : UInt32
}
struct MCI_BREAK_PARMS {
    dwCallback : IntPtr
    nVirtKey : Int32
    hwndBreak : HWND
}
struct MCI_SAVE_PARMSA {
    dwCallback : IntPtr
    lpfilename : PSTR
}
struct MCI_SAVE_PARMSW {
    dwCallback : IntPtr
    lpfilename : PWSTR
}
struct MCI_LOAD_PARMSA {
    dwCallback : IntPtr
    lpfilename : PSTR
}
struct MCI_LOAD_PARMSW {
    dwCallback : IntPtr
    lpfilename : PWSTR
}
struct MCI_RECORD_PARMS {
    dwCallback : IntPtr
    dwFrom : UInt32
    dwTo : UInt32
}
struct MCI_VD_PLAY_PARMS {
    dwCallback : IntPtr
    dwFrom : UInt32
    dwTo : UInt32
    dwSpeed : UInt32
}
struct MCI_VD_STEP_PARMS {
    dwCallback : IntPtr
    dwFrames : UInt32
}
struct MCI_VD_ESCAPE_PARMSA {
    dwCallback : IntPtr
    lpstrCommand : PSTR
}
struct MCI_VD_ESCAPE_PARMSW {
    dwCallback : IntPtr
    lpstrCommand : PWSTR
}
struct MCI_WAVE_OPEN_PARMSA {
    dwCallback : IntPtr
    wDeviceID : UInt32
    lpstrDeviceType : PSTR
    lpstrElementName : PSTR
    lpstrAlias : PSTR
    dwBufferSeconds : UInt32
}
struct MCI_WAVE_OPEN_PARMSW {
    dwCallback : IntPtr
    wDeviceID : UInt32
    lpstrDeviceType : PWSTR
    lpstrElementName : PWSTR
    lpstrAlias : PWSTR
    dwBufferSeconds : UInt32
}
struct MCI_WAVE_DELETE_PARMS {
    dwCallback : IntPtr
    dwFrom : UInt32
    dwTo : UInt32
}
struct MCI_WAVE_SET_PARMS {
    dwCallback : IntPtr
    dwTimeFormat : UInt32
    dwAudio : UInt32
    wInput : UInt32
    wOutput : UInt32
    wFormatTag : UInt16
    wReserved2 : UInt16
    nChannels : UInt16
    wReserved3 : UInt16
    nSamplesPerSec : UInt32
    nAvgBytesPerSec : UInt32
    nBlockAlign : UInt16
    wReserved4 : UInt16
    wBitsPerSample : UInt16
    wReserved5 : UInt16
}
struct MCI_SEQ_SET_PARMS {
    dwCallback : IntPtr
    dwTimeFormat : UInt32
    dwAudio : UInt32
    dwTempo : UInt32
    dwPort : UInt32
    dwSlave : UInt32
    dwMaster : UInt32
    dwOffset : UInt32
}
struct MCI_ANIM_OPEN_PARMSA {
    dwCallback : IntPtr
    wDeviceID : UInt32
    lpstrDeviceType : PSTR
    lpstrElementName : PSTR
    lpstrAlias : PSTR
    dwStyle : UInt32
    hWndParent : HWND
}
struct MCI_ANIM_OPEN_PARMSW {
    dwCallback : IntPtr
    wDeviceID : UInt32
    lpstrDeviceType : PWSTR
    lpstrElementName : PWSTR
    lpstrAlias : PWSTR
    dwStyle : UInt32
    hWndParent : HWND
}
struct MCI_ANIM_PLAY_PARMS {
    dwCallback : IntPtr
    dwFrom : UInt32
    dwTo : UInt32
    dwSpeed : UInt32
}
struct MCI_ANIM_STEP_PARMS {
    dwCallback : IntPtr
    dwFrames : UInt32
}
struct MCI_ANIM_WINDOW_PARMSA {
    dwCallback : IntPtr
    hWnd : HWND
    nCmdShow : UInt32
    lpstrText : PSTR
}
struct MCI_ANIM_WINDOW_PARMSW {
    dwCallback : IntPtr
    hWnd : HWND
    nCmdShow : UInt32
    lpstrText : PWSTR
}
struct MCI_ANIM_RECT_PARMS {
    dwCallback : IntPtr
    rc : RECT
}
struct MCI_ANIM_UPDATE_PARMS {
    dwCallback : IntPtr
    rc : RECT
    hDC : HDC
}
struct MCI_OVLY_OPEN_PARMSA {
    dwCallback : IntPtr
    wDeviceID : UInt32
    lpstrDeviceType : PSTR
    lpstrElementName : PSTR
    lpstrAlias : PSTR
    dwStyle : UInt32
    hWndParent : HWND
}
struct MCI_OVLY_OPEN_PARMSW {
    dwCallback : IntPtr
    wDeviceID : UInt32
    lpstrDeviceType : PWSTR
    lpstrElementName : PWSTR
    lpstrAlias : PWSTR
    dwStyle : UInt32
    hWndParent : HWND
}
struct MCI_OVLY_WINDOW_PARMSA {
    dwCallback : IntPtr
    hWnd : HWND
    nCmdShow : UInt32
    lpstrText : PSTR
}
struct MCI_OVLY_WINDOW_PARMSW {
    dwCallback : IntPtr
    hWnd : HWND
    nCmdShow : UInt32
    lpstrText : PWSTR
}
struct MCI_OVLY_RECT_PARMS {
    dwCallback : IntPtr
    rc : RECT
}
struct MCI_OVLY_SAVE_PARMSA {
    dwCallback : IntPtr
    lpfilename : PSTR
    rc : RECT
}
struct MCI_OVLY_SAVE_PARMSW {
    dwCallback : IntPtr
    lpfilename : PWSTR
    rc : RECT
}
struct MCI_OVLY_LOAD_PARMSA {
    dwCallback : IntPtr
    lpfilename : PSTR
    rc : RECT
}
struct MCI_OVLY_LOAD_PARMSW {
    dwCallback : IntPtr
    lpfilename : PWSTR
    rc : RECT
}
struct DRVCONFIGINFOEX {
    dwDCISize : UInt32
    lpszDCISectionName : PWSTR
    lpszDCIAliasName : PWSTR
    dnDevNode : UInt32
}
struct DRVCONFIGINFO {
    dwDCISize : UInt32
    lpszDCISectionName : PWSTR
    lpszDCIAliasName : PWSTR
}
struct DRIVERPROC extends FunctionPointer {
    static Types := [IntPtr, HDRVR, UInt32, LPARAM, LPARAM, LRESULT]
}
struct DRIVERMSGPROC extends FunctionPointer {
    static Types := [UInt32, UInt32, IntPtr, IntPtr, IntPtr, UInt32]
}
struct LPMMIOPROC extends FunctionPointer {
    static Types := [PSTR, UInt32, LPARAM, LPARAM, LRESULT]
}
struct MMIOINFO {
    dwFlags : UInt32
    fccIOProc : UInt32
    pIOProc : LPMMIOPROC
    wErrorRet : UInt32
    htask : HTASK
    cchBuffer : Int32
    pchBuffer : Int8.Ptr
    pchNext : Int8.Ptr
    pchEndRead : Int8.Ptr
    pchEndWrite : Int8.Ptr
    lBufOffset : Int32
    lDiskOffset : Int32
    adwInfo : UInt32[3]
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    hmmio : HMMIO
}
struct MMCKINFO {
    ckid : UInt32
    cksize : UInt32
    fccType : UInt32
    dwDataOffset : UInt32
    dwFlags : UInt32
}
struct JOYCAPSA {
    wMid : UInt16
    wPid : UInt16
    szPname : CHAR[32]
    wXmin : UInt32
    wXmax : UInt32
    wYmin : UInt32
    wYmax : UInt32
    wZmin : UInt32
    wZmax : UInt32
    wNumButtons : UInt32
    wPeriodMin : UInt32
    wPeriodMax : UInt32
    wRmin : UInt32
    wRmax : UInt32
    wUmin : UInt32
    wUmax : UInt32
    wVmin : UInt32
    wVmax : UInt32
    wCaps : UInt32
    wMaxAxes : UInt32
    wNumAxes : UInt32
    wMaxButtons : UInt32
    szRegKey : CHAR[32]
    szOEMVxD : CHAR[260]
}
struct JOYCAPSW {
    wMid : UInt16
    wPid : UInt16
    szPname : UInt16[32]
    wXmin : UInt32
    wXmax : UInt32
    wYmin : UInt32
    wYmax : UInt32
    wZmin : UInt32
    wZmax : UInt32
    wNumButtons : UInt32
    wPeriodMin : UInt32
    wPeriodMax : UInt32
    wRmin : UInt32
    wRmax : UInt32
    wUmin : UInt32
    wUmax : UInt32
    wVmin : UInt32
    wVmax : UInt32
    wCaps : UInt32
    wMaxAxes : UInt32
    wNumAxes : UInt32
    wMaxButtons : UInt32
    szRegKey : UInt16[32]
    szOEMVxD : UInt16[260]
}
struct JOYCAPS2A {
    wMid : UInt16
    wPid : UInt16
    szPname : CHAR[32]
    wXmin : UInt32
    wXmax : UInt32
    wYmin : UInt32
    wYmax : UInt32
    wZmin : UInt32
    wZmax : UInt32
    wNumButtons : UInt32
    wPeriodMin : UInt32
    wPeriodMax : UInt32
    wRmin : UInt32
    wRmax : UInt32
    wUmin : UInt32
    wUmax : UInt32
    wVmin : UInt32
    wVmax : UInt32
    wCaps : UInt32
    wMaxAxes : UInt32
    wNumAxes : UInt32
    wMaxButtons : UInt32
    szRegKey : CHAR[32]
    szOEMVxD : CHAR[260]
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct JOYCAPS2W {
    wMid : UInt16
    wPid : UInt16
    szPname : UInt16[32]
    wXmin : UInt32
    wXmax : UInt32
    wYmin : UInt32
    wYmax : UInt32
    wZmin : UInt32
    wZmax : UInt32
    wNumButtons : UInt32
    wPeriodMin : UInt32
    wPeriodMax : UInt32
    wRmin : UInt32
    wRmax : UInt32
    wUmin : UInt32
    wUmax : UInt32
    wVmin : UInt32
    wVmax : UInt32
    wCaps : UInt32
    wMaxAxes : UInt32
    wNumAxes : UInt32
    wMaxButtons : UInt32
    szRegKey : UInt16[32]
    szOEMVxD : UInt16[260]
    ManufacturerGuid : GUID
    ProductGuid : GUID
    NameGuid : GUID
}
struct JOYINFO {
    wXpos : UInt32
    wYpos : UInt32
    wZpos : UInt32
    wButtons : UInt32
}
struct JOYINFOEX {
    dwSize : UInt32
    dwFlags : UInt32
    dwXpos : UInt32
    dwYpos : UInt32
    dwZpos : UInt32
    dwRpos : UInt32
    dwUpos : UInt32
    dwVpos : UInt32
    dwButtons : UInt32
    dwButtonNumber : UInt32
    dwPOV : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
}
struct MCI_DGV_RECT_PARMS {
    dwCallback : IntPtr
    rc : RECT
}
struct MCI_DGV_CAPTURE_PARMSA {
    dwCallback : IntPtr
    lpstrFileName : PSTR
    rc : RECT
}
struct MCI_DGV_CAPTURE_PARMSW {
    dwCallback : IntPtr
    lpstrFileName : PWSTR
    rc : RECT
}
struct MCI_DGV_COPY_PARMS {
    dwCallback : IntPtr
    dwFrom : UInt32
    dwTo : UInt32
    rc : RECT
    dwAudioStream : UInt32
    dwVideoStream : UInt32
}
struct MCI_DGV_CUE_PARMS {
    dwCallback : IntPtr
    dwTo : UInt32
}
struct MCI_DGV_CUT_PARMS {
    dwCallback : IntPtr
    dwFrom : UInt32
    dwTo : UInt32
    rc : RECT
    dwAudioStream : UInt32
    dwVideoStream : UInt32
}
struct MCI_DGV_DELETE_PARMS {
    dwCallback : IntPtr
    dwFrom : UInt32
    dwTo : UInt32
    rc : RECT
    dwAudioStream : UInt32
    dwVideoStream : UInt32
}
struct MCI_DGV_INFO_PARMSA {
    dwCallback : IntPtr
    lpstrReturn : PSTR
    dwRetSize : UInt32
    dwItem : UInt32
}
struct MCI_DGV_INFO_PARMSW {
    dwCallback : IntPtr
    lpstrReturn : PWSTR
    dwRetSize : UInt32
    dwItem : UInt32
}
struct MCI_DGV_LIST_PARMSA {
    dwCallback : IntPtr
    lpstrReturn : PSTR
    dwLength : UInt32
    dwNumber : UInt32
    dwItem : UInt32
    lpstrAlgorithm : PSTR
}
struct MCI_DGV_LIST_PARMSW {
    dwCallback : IntPtr
    lpstrReturn : PWSTR
    dwLength : UInt32
    dwNumber : UInt32
    dwItem : UInt32
    lpstrAlgorithm : PWSTR
}
struct MCI_DGV_MONITOR_PARMS {
    dwCallback : IntPtr
    dwSource : UInt32
    dwMethod : UInt32
}
struct MCI_DGV_OPEN_PARMSA {
    dwCallback : IntPtr
    wDeviceID : UInt32
    lpstrDeviceType : PSTR
    lpstrElementName : PSTR
    lpstrAlias : PSTR
    dwStyle : UInt32
    hWndParent : HWND
}
struct MCI_DGV_OPEN_PARMSW {
    dwCallback : IntPtr
    wDeviceID : UInt32
    lpstrDeviceType : PWSTR
    lpstrElementName : PWSTR
    lpstrAlias : PWSTR
    dwStyle : UInt32
    hWndParent : HWND
}
struct MCI_DGV_PASTE_PARMS {
    dwCallback : IntPtr
    dwTo : UInt32
    rc : RECT
    dwAudioStream : UInt32
    dwVideoStream : UInt32
}
struct MCI_DGV_QUALITY_PARMSA {
    dwCallback : IntPtr
    dwItem : UInt32
    lpstrName : PSTR
    lpstrAlgorithm : UInt32
    dwHandle : UInt32
}
struct MCI_DGV_QUALITY_PARMSW {
    dwCallback : IntPtr
    dwItem : UInt32
    lpstrName : PWSTR
    lpstrAlgorithm : UInt32
    dwHandle : UInt32
}
struct MCI_DGV_RECORD_PARMS {
    dwCallback : IntPtr
    dwFrom : UInt32
    dwTo : UInt32
    rc : RECT
    dwAudioStream : UInt32
    dwVideoStream : UInt32
}
struct MCI_DGV_RESERVE_PARMSA {
    dwCallback : IntPtr
    lpstrPath : PSTR
    dwSize : UInt32
}
struct MCI_DGV_RESERVE_PARMSW {
    dwCallback : IntPtr
    lpstrPath : PWSTR
    dwSize : UInt32
}
struct MCI_DGV_RESTORE_PARMSA {
    dwCallback : IntPtr
    lpstrFileName : PSTR
    rc : RECT
}
struct MCI_DGV_RESTORE_PARMSW {
    dwCallback : IntPtr
    lpstrFileName : PWSTR
    rc : RECT
}
struct MCI_DGV_SAVE_PARMSA {
    dwCallback : IntPtr
    lpstrFileName : PSTR
    rc : RECT
}
struct MCI_DGV_SAVE_PARMSW {
    dwCallback : IntPtr
    lpstrFileName : PWSTR
    rc : RECT
}
struct MCI_DGV_SET_PARMS {
    dwCallback : IntPtr
    dwTimeFormat : UInt32
    dwAudio : UInt32
    dwFileFormat : UInt32
    dwSpeed : UInt32
}
struct MCI_DGV_SETAUDIO_PARMSA {
    dwCallback : IntPtr
    dwItem : UInt32
    dwValue : UInt32
    dwOver : UInt32
    lpstrAlgorithm : PSTR
    lpstrQuality : PSTR
}
struct MCI_DGV_SETAUDIO_PARMSW {
    dwCallback : IntPtr
    dwItem : UInt32
    dwValue : UInt32
    dwOver : UInt32
    lpstrAlgorithm : PWSTR
    lpstrQuality : PWSTR
}
struct MCI_DGV_SIGNAL_PARMS {
    dwCallback : IntPtr
    dwPosition : UInt32
    dwPeriod : UInt32
    dwUserParm : UInt32
}
struct MCI_DGV_SETVIDEO_PARMSA {
    dwCallback : IntPtr
    dwItem : UInt32
    dwValue : UInt32
    dwOver : UInt32
    lpstrAlgorithm : PSTR
    lpstrQuality : PSTR
    dwSourceNumber : UInt32
}
struct MCI_DGV_SETVIDEO_PARMSW {
    dwCallback : IntPtr
    dwItem : UInt32
    dwValue : UInt32
    dwOver : UInt32
    lpstrAlgorithm : PWSTR
    lpstrQuality : PWSTR
    dwSourceNumber : UInt32
}
struct MCI_DGV_STATUS_PARMSA {
    dwCallback : IntPtr
    dwReturn : IntPtr
    dwItem : UInt32
    dwTrack : UInt32
    lpstrDrive : PSTR
    dwReference : UInt32
}
struct MCI_DGV_STATUS_PARMSW {
    dwCallback : IntPtr
    dwReturn : IntPtr
    dwItem : UInt32
    dwTrack : UInt32
    lpstrDrive : PWSTR
    dwReference : UInt32
}
struct MCI_DGV_STEP_PARMS {
    dwCallback : IntPtr
    dwFrames : UInt32
}
struct MCI_DGV_UPDATE_PARMS {
    dwCallback : IntPtr
    rc : RECT
    hDC : HDC
}
struct MCI_DGV_WINDOW_PARMSA {
    dwCallback : IntPtr
    hWnd : HWND
    nCmdShow : UInt32
    lpstrText : PSTR
}
struct MCI_DGV_WINDOW_PARMSW {
    dwCallback : IntPtr
    hWnd : HWND
    nCmdShow : UInt32
    lpstrText : PWSTR
}
struct ICOPEN {
    dwSize : UInt32
    fccType : UInt32
    fccHandler : UInt32
    dwVersion : UInt32
    dwFlags : UInt32
    dwError : LRESULT
    pV1Reserved : Struct.Ptr
    pV2Reserved : Struct.Ptr
    dnDevNode : UInt32
}
struct ICINFO {
    dwSize : UInt32
    fccType : UInt32
    fccHandler : UInt32
    dwFlags : UInt32
    dwVersion : UInt32
    dwVersionICM : UInt32
    szName : UInt16[16]
    szDescription : UInt16[128]
    szDriver : UInt16[128]
}
struct ICCOMPRESS {
    dwFlags : UInt32
    lpbiOutput : BITMAPINFOHEADER.Ptr
    lpOutput : Struct.Ptr
    lpbiInput : BITMAPINFOHEADER.Ptr
    lpInput : Struct.Ptr
    lpckid : UInt32.Ptr
    lpdwFlags : UInt32.Ptr
    lFrameNum : Int32
    dwFrameSize : UInt32
    dwQuality : UInt32
    lpbiPrev : BITMAPINFOHEADER.Ptr
    lpPrev : Struct.Ptr
}
struct ICCOMPRESSFRAMES {
    dwFlags : UInt32
    lpbiOutput : BITMAPINFOHEADER.Ptr
    lOutput : LPARAM
    lpbiInput : BITMAPINFOHEADER.Ptr
    lInput : LPARAM
    lStartFrame : Int32
    lFrameCount : Int32
    lQuality : Int32
    lDataRate : Int32
    lKeyRate : Int32
    dwRate : UInt32
    dwScale : UInt32
    dwOverheadPerFrame : UInt32
    dwReserved2 : UInt32
    GetData : IntPtr
    PutData : IntPtr
}
struct ICSETSTATUSPROC {
    dwFlags : UInt32
    lParam : LPARAM
    Status : IntPtr
}
struct ICDECOMPRESS {
    dwFlags : UInt32
    lpbiInput : BITMAPINFOHEADER.Ptr
    lpInput : Struct.Ptr
    lpbiOutput : BITMAPINFOHEADER.Ptr
    lpOutput : Struct.Ptr
    ckid : UInt32
}
struct ICDECOMPRESSEX {
    dwFlags : UInt32
    lpbiSrc : BITMAPINFOHEADER.Ptr
    lpSrc : Struct.Ptr
    lpbiDst : BITMAPINFOHEADER.Ptr
    lpDst : Struct.Ptr
    xDst : Int32
    yDst : Int32
    dxDst : Int32
    dyDst : Int32
    xSrc : Int32
    ySrc : Int32
    dxSrc : Int32
    dySrc : Int32
}
struct ICDRAWBEGIN {
    dwFlags : UInt32
    hpal : HPALETTE
    hwnd : HWND
    hdc : HDC
    xDst : Int32
    yDst : Int32
    dxDst : Int32
    dyDst : Int32
    lpbi : BITMAPINFOHEADER.Ptr
    xSrc : Int32
    ySrc : Int32
    dxSrc : Int32
    dySrc : Int32
    dwRate : UInt32
    dwScale : UInt32
}
struct ICDRAW {
    dwFlags : UInt32
    lpFormat : Struct.Ptr
    lpData : Struct.Ptr
    cbData : UInt32
    lTime : Int32
}
struct ICDRAWSUGGEST {
    lpbiIn : BITMAPINFOHEADER.Ptr
    lpbiSuggest : BITMAPINFOHEADER.Ptr
    dxSrc : Int32
    dySrc : Int32
    dxDst : Int32
    dyDst : Int32
    hicDecompressor : HIC
}
struct ICPALETTE {
    dwFlags : UInt32
    iStart : Int32
    iLen : Int32
    lppe : PALETTEENTRY.Ptr
}
struct COMPVARS {
    cbSize : Int32 := this.Size
    dwFlags : UInt32
    hic : HIC
    fccType : UInt32
    fccHandler : UInt32
    lpbiIn : BITMAPINFO.Ptr
    lpbiOut : BITMAPINFO.Ptr
    lpBitsOut : Struct.Ptr
    lpBitsPrev : Struct.Ptr
    lFrame : Int32
    lKey : Int32
    lDataRate : Int32
    lQ : Int32
    lKeyCount : Int32
    lpState : Struct.Ptr
    cbState : Int32
}
struct DRAWDIBTIME {
    timeCount : Int32
    timeDraw : Int32
    timeDecompress : Int32
    timeDither : Int32
    timeStretch : Int32
    timeBlt : Int32
    timeSetDIBits : Int32
}
struct AVISTREAMINFOW {
    fccType : UInt32
    fccHandler : UInt32
    dwFlags : UInt32
    dwCaps : UInt32
    wPriority : UInt16
    wLanguage : UInt16
    dwScale : UInt32
    dwRate : UInt32
    dwStart : UInt32
    dwLength : UInt32
    dwInitialFrames : UInt32
    dwSuggestedBufferSize : UInt32
    dwQuality : UInt32
    dwSampleSize : UInt32
    rcFrame : RECT
    dwEditCount : UInt32
    dwFormatChangeCount : UInt32
    szName : UInt16[64]
}
struct AVISTREAMINFOA {
    fccType : UInt32
    fccHandler : UInt32
    dwFlags : UInt32
    dwCaps : UInt32
    wPriority : UInt16
    wLanguage : UInt16
    dwScale : UInt32
    dwRate : UInt32
    dwStart : UInt32
    dwLength : UInt32
    dwInitialFrames : UInt32
    dwSuggestedBufferSize : UInt32
    dwQuality : UInt32
    dwSampleSize : UInt32
    rcFrame : RECT
    dwEditCount : UInt32
    dwFormatChangeCount : UInt32
    szName : CHAR[64]
}
struct AVIFILEINFOW {
    dwMaxBytesPerSec : UInt32
    dwFlags : UInt32
    dwCaps : UInt32
    dwStreams : UInt32
    dwSuggestedBufferSize : UInt32
    dwWidth : UInt32
    dwHeight : UInt32
    dwScale : UInt32
    dwRate : UInt32
    dwLength : UInt32
    dwEditCount : UInt32
    szFileType : UInt16[64]
}
struct AVIFILEINFOA {
    dwMaxBytesPerSec : UInt32
    dwFlags : UInt32
    dwCaps : UInt32
    dwStreams : UInt32
    dwSuggestedBufferSize : UInt32
    dwWidth : UInt32
    dwHeight : UInt32
    dwScale : UInt32
    dwRate : UInt32
    dwLength : UInt32
    dwEditCount : UInt32
    szFileType : CHAR[64]
}
struct AVISAVECALLBACK extends FunctionPointer {
    static Types := [Int32, BOOL]
}
struct AVICOMPRESSOPTIONS {
    fccType : UInt32
    fccHandler : UInt32
    dwKeyFrameEvery : UInt32
    dwQuality : UInt32
    dwBytesPerSecond : UInt32
    dwFlags : UInt32
    lpFormat : Struct.Ptr
    cbFormat : UInt32
    lpParms : Struct.Ptr
    cbParms : UInt32
    dwInterleaveEvery : UInt32
}
struct IAVIStream extends IUnknown {
    static IID := "{00020021-0000-0000-C000-000000000046}"
    Create(lParam1, lParam2)
      => ComCall(3, this.p, LPARAM, lParam1, LPARAM, lParam2)
    Info(psi)
      => ComCall(4, this.p, AVISTREAMINFOW.Ptr, psi, Int32, psi.Size)
    FindSample(lPos, lFlags)
      => ComCall(5, this.p, Int32, lPos, Int32, lFlags, Int32)
    ReadFormat(lPos, lpFormat?, lpcbFormat)
      => ComCall(6, this.p, Int32, lPos, Struct.Ptr, lpFormat?, Int32.Ptr, lpcbFormat)
    SetFormat(lPos, lpFormat)
      => ComCall(7, this.p, Int32, lPos, Struct.Ptr, lpFormat, Int32, lpFormat.Size)
    Read(lStart, lSamples, lpBuffer?, plBytes?, plSamples?)
      => ComCall(8, this.p, Int32, lStart, Int32, lSamples, Struct.Ptr, lpBuffer?, Int32, lpBuffer?.Size ?? 0, Int32.Ptr, plBytes?, Int32.Ptr, plSamples?)
    Write(lStart, lSamples, lpBuffer, dwFlags, plSampWritten?, plBytesWritten?)
      => ComCall(9, this.p, Int32, lStart, Int32, lSamples, Struct.Ptr, lpBuffer, Int32, lpBuffer.Size, UInt32, dwFlags, Int32.Ptr, plSampWritten?, Int32.Ptr, plBytesWritten?)
    Delete(lStart, lSamples)
      => ComCall(10, this.p, Int32, lStart, Int32, lSamples)
    ReadData(fcc, lp?, lpcb)
      => ComCall(11, this.p, UInt32, fcc, Struct.Ptr, lp?, Int32.Ptr, lpcb)
    WriteData(fcc, lp)
      => ComCall(12, this.p, UInt32, fcc, Struct.Ptr, lp, Int32, lp.Size)
    SetInfo(lpInfo)
      => ComCall(13, this.p, AVISTREAMINFOW.Ptr, lpInfo, Int32, lpInfo.Size)
}
struct IAVIStreaming extends IUnknown {
    static IID := "{00020022-0000-0000-C000-000000000046}"
    Begin(lStart, lEnd, lRate)
      => ComCall(3, this.p, Int32, lStart, Int32, lEnd, Int32, lRate)
    End()
      => ComCall(4, this.p)
}
struct IAVIEditStream extends IUnknown {
    static IID := "{00020024-0000-0000-C000-000000000046}"
    Cut(plStart, plLength, ppResult)
      => ComCall(3, this.p, Int32.Ptr, plStart, Int32.Ptr, plLength, IAVIStream.Ptr, ppResult)
    Copy(plStart, plLength, ppResult)
      => ComCall(4, this.p, Int32.Ptr, plStart, Int32.Ptr, plLength, IAVIStream.Ptr, ppResult)
    Paste(plPos, plLength, pstream, lStart, lEnd)
      => ComCall(5, this.p, Int32.Ptr, plPos, Int32.Ptr, plLength, IAVIStream, pstream, Int32, lStart, Int32, lEnd)
    Clone(ppResult)
      => ComCall(6, this.p, IAVIStream.Ptr, ppResult)
    SetInfo(lpInfo)
      => ComCall(7, this.p, AVISTREAMINFOW.Ptr, lpInfo, Int32, lpInfo.Size)
}
struct IAVIPersistFile extends IPersistFile {
    static IID := "{00020025-0000-0000-C000-000000000046}"
    Reserved1()
      => ComCall(9, this.p)
}
struct IAVIFile extends IUnknown {
    static IID := "{00020020-0000-0000-C000-000000000046}"
    Info(pfi)
      => ComCall(3, this.p, AVIFILEINFOW.Ptr, pfi, Int32, pfi.Size)
    GetStream(ppStream, fccType, lParam)
      => ComCall(4, this.p, IAVIStream.Ptr, ppStream, UInt32, fccType, Int32, lParam)
    CreateStream(ppStream, psi)
      => ComCall(5, this.p, IAVIStream.Ptr, ppStream, AVISTREAMINFOW.Ptr, psi)
    WriteData(ckid, lpData)
      => ComCall(6, this.p, UInt32, ckid, Struct.Ptr, lpData, Int32, lpData.Size)
    ReadData(ckid, lpData, lpcbData)
      => ComCall(7, this.p, UInt32, ckid, Struct.Ptr, lpData, Int32.Ptr, lpcbData)
    EndRecord()
      => ComCall(8, this.p)
    DeleteStream(fccType, lParam)
      => ComCall(9, this.p, UInt32, fccType, Int32, lParam)
}
struct IGetFrame extends IUnknown {
    static IID := "{00020023-0000-0000-C000-000000000046}"
    GetFrame(lPos)
      => ComCall(3, this.p, Int32, lPos, Struct.Ptr)
    Begin(lStart, lEnd, lRate)
      => ComCall(4, this.p, Int32, lStart, Int32, lEnd, Int32, lRate)
    End()
      => ComCall(5, this.p)
    SetFormat(lpbi, lpBits?, x, y, dx, dy)
      => ComCall(6, this.p, BITMAPINFOHEADER.Ptr, lpbi, Struct.Ptr, lpBits?, Int32, x, Int32, y, Int32, dx, Int32, dy)
}
struct VIDEOHDR {
    lpData : UInt8.Ptr
    dwBufferLength : UInt32
    dwBytesUsed : UInt32
    dwTimeCaptured : UInt32
    dwUser : IntPtr
    dwFlags : UInt32
    dwReserved : IntPtr[4]
}
struct CHANNEL_CAPS {
    dwFlags : UInt32
    dwSrcRectXMod : UInt32
    dwSrcRectYMod : UInt32
    dwSrcRectWidthMod : UInt32
    dwSrcRectHeightMod : UInt32
    dwDstRectXMod : UInt32
    dwDstRectYMod : UInt32
    dwDstRectWidthMod : UInt32
    dwDstRectHeightMod : UInt32
}
struct CAPDRIVERCAPS {
    wDeviceIndex : UInt32
    fHasOverlay : BOOL
    fHasDlgVideoSource : BOOL
    fHasDlgVideoFormat : BOOL
    fHasDlgVideoDisplay : BOOL
    fCaptureInitialized : BOOL
    fDriverSuppliesPalettes : BOOL
    hVideoIn : HANDLE
    hVideoOut : HANDLE
    hVideoExtIn : HANDLE
    hVideoExtOut : HANDLE
}
struct CAPSTATUS {
    uiImageWidth : UInt32
    uiImageHeight : UInt32
    fLiveWindow : BOOL
    fOverlayWindow : BOOL
    fScale : BOOL
    ptScroll : POINT
    fUsingDefaultPalette : BOOL
    fAudioHardware : BOOL
    fCapFileExists : BOOL
    dwCurrentVideoFrame : UInt32
    dwCurrentVideoFramesDropped : UInt32
    dwCurrentWaveSamples : UInt32
    dwCurrentTimeElapsedMS : UInt32
    hPalCurrent : HPALETTE
    fCapturingNow : BOOL
    dwReturn : UInt32
    wNumVideoAllocated : UInt32
    wNumAudioAllocated : UInt32
}
struct CAPTUREPARMS {
    dwRequestMicroSecPerFrame : UInt32
    fMakeUserHitOKToCapture : BOOL
    wPercentDropForError : UInt32
    fYield : BOOL
    dwIndexSize : UInt32
    wChunkGranularity : UInt32
    fUsingDOSMemory : BOOL
    wNumVideoRequested : UInt32
    fCaptureAudio : BOOL
    wNumAudioRequested : UInt32
    vKeyAbort : UInt32
    fAbortLeftMouse : BOOL
    fAbortRightMouse : BOOL
    fLimitEnabled : BOOL
    wTimeLimit : UInt32
    fMCIControl : BOOL
    fStepMCIDevice : BOOL
    dwMCIStartTime : UInt32
    dwMCIStopTime : UInt32
    fStepCaptureAt2x : BOOL
    wStepCaptureAverageFrames : UInt32
    dwAudioBufferSize : UInt32
    fDisableWriteCache : BOOL
    AVStreamMaster : UInt32
}
struct CAPINFOCHUNK {
    fccInfoID : UInt32
    lpData : Struct.Ptr
    cbData : Int32
}
struct CAPYIELDCALLBACK extends FunctionPointer {
    static Types := [HWND, LRESULT]
}
struct CAPSTATUSCALLBACKW extends FunctionPointer {
    static Types := [HWND, Int32, PWSTR, LRESULT]
}
struct CAPERRORCALLBACKW extends FunctionPointer {
    static Types := [HWND, Int32, PWSTR, LRESULT]
}
struct CAPSTATUSCALLBACKA extends FunctionPointer {
    static Types := [HWND, Int32, PSTR, LRESULT]
}
struct CAPERRORCALLBACKA extends FunctionPointer {
    static Types := [HWND, Int32, PSTR, LRESULT]
}
struct CAPVIDEOCALLBACK extends FunctionPointer {
    static Types := [HWND, VIDEOHDR.Ptr, LRESULT]
}
struct CAPWAVECALLBACK extends FunctionPointer {
    static Types := [HWND, WAVEHDR.Ptr, LRESULT]
}
struct CAPCONTROLCALLBACK extends FunctionPointer {
    static Types := [HWND, Int32, LRESULT]
}
struct DRVM_IOCTL_DATA {
    dwSize : UInt32
    dwCmd : UInt32
}
struct WAVEOPENDESC {
    hWave : HWAVE
    lpFormat : WAVEFORMAT.Ptr
    dwCallback : IntPtr
    dwInstance : IntPtr
    uMappedDeviceID : UInt32
    dnDevNode : IntPtr
}
struct MIDIOPENSTRMID {
    dwStreamID : UInt32
    uDeviceID : UInt32
}
struct MIXEROPENDESC {
    hmx : HMIXER
    pReserved0 : Struct.Ptr
    dwCallback : IntPtr
    dwInstance : IntPtr
    dnDevNode : IntPtr
}
struct TIMEREVENT {
    wDelay : UInt16
    wResolution : UInt16
    lpFunction : LPTIMECALLBACK
    dwUser : UInt32
    wFlags : UInt16
    wReserved1 : UInt16
}
struct MCI_OPEN_DRIVER_PARMS {
    wDeviceID : UInt32
    lpstrParams : PWSTR
    wCustomCommandTable : UInt32
    wType : UInt32
}
struct LPTASKCALLBACK extends FunctionPointer {
    static Types := [IntPtr, "Void"]
}
struct VFWWDMExtensionProc extends FunctionPointer {
    static Types := [Struct.Ptr, LPFNSVADDPROPSHEETPAGE, LPARAM, UInt32]
}
struct LPFNEXTDEVIO extends FunctionPointer {
    static Types := [LPARAM, UInt32, UInt32, Struct.Ptr, UInt32, Struct.Ptr, UInt32, UInt32.Ptr, OVERLAPPED.Ptr, BOOL]
}
