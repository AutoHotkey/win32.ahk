#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BOOLEAN, CHAR, FILETIME, HANDLE, HINSTANCE, HRESULT, HWND, NTSTATUS, POINT, PSTR, PWSTR, RECT}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.Registry\Types.ahk" {HKEY}

struct PHIDP_PREPARSED_DATA {
    Value : IntPtr
}
struct DICONSTANTFORCE {
    lMagnitude : Int32
}
struct DIRAMPFORCE {
    lStart : Int32
    lEnd : Int32
}
struct DIPERIODIC {
    dwMagnitude : UInt32
    lOffset : Int32
    dwPhase : UInt32
    dwPeriod : UInt32
}
struct DICONDITION {
    lOffset : Int32
    lPositiveCoefficient : Int32
    lNegativeCoefficient : Int32
    dwPositiveSaturation : UInt32
    dwNegativeSaturation : UInt32
    lDeadBand : Int32
}
struct DICUSTOMFORCE {
    cChannels : UInt32
    dwSamplePeriod : UInt32
    cSamples : UInt32
    rglForceData : Int32.Ptr
}
struct DIENVELOPE {
    dwSize : UInt32
    dwAttackLevel : UInt32
    dwAttackTime : UInt32
    dwFadeLevel : UInt32
    dwFadeTime : UInt32
}
struct DIEFFECT_DX5 {
    dwSize : UInt32
    dwFlags : UInt32
    dwDuration : UInt32
    dwSamplePeriod : UInt32
    dwGain : UInt32
    dwTriggerButton : UInt32
    dwTriggerRepeatInterval : UInt32
    cAxes : UInt32
    rgdwAxes : UInt32.Ptr
    rglDirection : Int32.Ptr
    lpEnvelope : DIENVELOPE.Ptr
    cbTypeSpecificParams : UInt32
    lpvTypeSpecificParams : Struct.Ptr
}
struct DIEFFECT {
    dwSize : UInt32
    dwFlags : UInt32
    dwDuration : UInt32
    dwSamplePeriod : UInt32
    dwGain : UInt32
    dwTriggerButton : UInt32
    dwTriggerRepeatInterval : UInt32
    cAxes : UInt32
    rgdwAxes : UInt32.Ptr
    rglDirection : Int32.Ptr
    lpEnvelope : DIENVELOPE.Ptr
    cbTypeSpecificParams : UInt32
    lpvTypeSpecificParams : Struct.Ptr
    dwStartDelay : UInt32
}
struct DIFILEEFFECT {
    dwSize : UInt32
    GuidEffect : GUID
    lpDiEffect : DIEFFECT.Ptr
    szFriendlyName : CHAR[260]
}
struct LPDIENUMEFFECTSINFILECALLBACK extends FunctionPointer {
    static Types := [DIFILEEFFECT.Ptr, Struct.Ptr, BOOL]
}
struct DIEFFESCAPE {
    dwSize : UInt32
    dwCommand : UInt32
    lpvInBuffer : Struct.Ptr
    cbInBuffer : UInt32
    lpvOutBuffer : Struct.Ptr
    cbOutBuffer : UInt32
}
struct IDirectInputEffect extends IUnknown {
    static IID := "{E7E1F7C0-88D2-11D0-9AD0-00A0C9A06E35}"
    Initialize(param0, param1, param2)
      => ComCall(3, this.p, HINSTANCE, param0, UInt32, param1, GUID.Ptr, param2)
    GetEffectGuid(param0)
      => ComCall(4, this.p, GUID.Ptr, param0)
    GetParameters(param0, param1)
      => ComCall(5, this.p, DIEFFECT.Ptr, param0, UInt32, param1)
    SetParameters(param0, param1)
      => ComCall(6, this.p, DIEFFECT.Ptr, param0, UInt32, param1)
    Start(param0, param1)
      => ComCall(7, this.p, UInt32, param0, UInt32, param1)
    Stop()
      => ComCall(8, this.p)
    GetEffectStatus(param0)
      => ComCall(9, this.p, UInt32.Ptr, param0)
    Download()
      => ComCall(10, this.p)
    Unload()
      => ComCall(11, this.p)
    Escape(param0)
      => ComCall(12, this.p, DIEFFESCAPE.Ptr, param0)
}
struct DIDEVCAPS_DX3 {
    dwSize : UInt32
    dwFlags : UInt32
    dwDevType : UInt32
    dwAxes : UInt32
    dwButtons : UInt32
    dwPOVs : UInt32
}
struct DIDEVCAPS {
    dwSize : UInt32
    dwFlags : UInt32
    dwDevType : UInt32
    dwAxes : UInt32
    dwButtons : UInt32
    dwPOVs : UInt32
    dwFFSamplePeriod : UInt32
    dwFFMinTimeResolution : UInt32
    dwFirmwareRevision : UInt32
    dwHardwareRevision : UInt32
    dwFFDriverVersion : UInt32
}
struct DIOBJECTDATAFORMAT {
    pguid : GUID.Ptr
    dwOfs : UInt32
    dwType : UInt32
    dwFlags : UInt32
}
struct DIDATAFORMAT {
    dwSize : UInt32
    dwObjSize : UInt32
    dwFlags : UInt32
    dwDataSize : UInt32
    dwNumObjs : UInt32
    rgodf : DIOBJECTDATAFORMAT.Ptr
}
struct DIACTIONA {
    uAppData : IntPtr
    dwSemantic : UInt32
    dwFlags : UInt32
    Anonymous : this._Anonymous_e__Union
    guidInstance : GUID
    dwObjID : UInt32
    dwHow : UInt32
    struct _Anonymous_e__Union {
        union {
            lptszActionName : PSTR
            uResIdString : UInt32
        }
    }
}
struct DIACTIONW {
    uAppData : IntPtr
    dwSemantic : UInt32
    dwFlags : UInt32
    Anonymous : this._Anonymous_e__Union
    guidInstance : GUID
    dwObjID : UInt32
    dwHow : UInt32
    struct _Anonymous_e__Union {
        union {
            lptszActionName : PWSTR
            uResIdString : UInt32
        }
    }
}
struct DIACTIONFORMATA {
    dwSize : UInt32
    dwActionSize : UInt32
    dwDataSize : UInt32
    dwNumActions : UInt32
    rgoAction : DIACTIONA.Ptr
    guidActionMap : GUID
    dwGenre : UInt32
    dwBufferSize : UInt32
    lAxisMin : Int32
    lAxisMax : Int32
    hInstString : HINSTANCE
    ftTimeStamp : FILETIME
    dwCRC : UInt32
    tszActionMap : CHAR[260]
}
struct DIACTIONFORMATW {
    dwSize : UInt32
    dwActionSize : UInt32
    dwDataSize : UInt32
    dwNumActions : UInt32
    rgoAction : DIACTIONW.Ptr
    guidActionMap : GUID
    dwGenre : UInt32
    dwBufferSize : UInt32
    lAxisMin : Int32
    lAxisMax : Int32
    hInstString : HINSTANCE
    ftTimeStamp : FILETIME
    dwCRC : UInt32
    tszActionMap : UInt16[260]
}
struct DICOLORSET {
    dwSize : UInt32
    cTextFore : UInt32
    cTextHighlight : UInt32
    cCalloutLine : UInt32
    cCalloutHighlight : UInt32
    cBorder : UInt32
    cControlFill : UInt32
    cHighlightFill : UInt32
    cAreaFill : UInt32
}
struct DICONFIGUREDEVICESPARAMSA {
    dwSize : UInt32
    dwcUsers : UInt32
    lptszUserNames : PSTR
    dwcFormats : UInt32
    lprgFormats : DIACTIONFORMATA.Ptr
    hwnd : HWND
    dics : DICOLORSET
    lpUnkDDSTarget : IUnknown
}
struct DICONFIGUREDEVICESPARAMSW {
    dwSize : UInt32
    dwcUsers : UInt32
    lptszUserNames : PWSTR
    dwcFormats : UInt32
    lprgFormats : DIACTIONFORMATW.Ptr
    hwnd : HWND
    dics : DICOLORSET
    lpUnkDDSTarget : IUnknown
}
struct DIDEVICEIMAGEINFOA {
    tszImagePath : CHAR[260]
    dwFlags : UInt32
    dwViewID : UInt32
    rcOverlay : RECT
    dwObjID : UInt32
    dwcValidPts : UInt32
    rgptCalloutLine : POINT[5]
    rcCalloutRect : RECT
    dwTextAlign : UInt32
}
struct DIDEVICEIMAGEINFOW {
    tszImagePath : UInt16[260]
    dwFlags : UInt32
    dwViewID : UInt32
    rcOverlay : RECT
    dwObjID : UInt32
    dwcValidPts : UInt32
    rgptCalloutLine : POINT[5]
    rcCalloutRect : RECT
    dwTextAlign : UInt32
}
struct DIDEVICEIMAGEINFOHEADERA {
    dwSize : UInt32
    dwSizeImageInfo : UInt32
    dwcViews : UInt32
    dwcButtons : UInt32
    dwcAxes : UInt32
    dwcPOVs : UInt32
    dwBufferSize : UInt32
    dwBufferUsed : UInt32
    lprgImageInfoArray : DIDEVICEIMAGEINFOA.Ptr
}
struct DIDEVICEIMAGEINFOHEADERW {
    dwSize : UInt32
    dwSizeImageInfo : UInt32
    dwcViews : UInt32
    dwcButtons : UInt32
    dwcAxes : UInt32
    dwcPOVs : UInt32
    dwBufferSize : UInt32
    dwBufferUsed : UInt32
    lprgImageInfoArray : DIDEVICEIMAGEINFOW.Ptr
}
struct DIDEVICEOBJECTINSTANCE_DX3A {
    dwSize : UInt32
    guidType : GUID
    dwOfs : UInt32
    dwType : UInt32
    dwFlags : UInt32
    tszName : CHAR[260]
}
struct DIDEVICEOBJECTINSTANCE_DX3W {
    dwSize : UInt32
    guidType : GUID
    dwOfs : UInt32
    dwType : UInt32
    dwFlags : UInt32
    tszName : UInt16[260]
}
struct DIDEVICEOBJECTINSTANCEA {
    dwSize : UInt32
    guidType : GUID
    dwOfs : UInt32
    dwType : UInt32
    dwFlags : UInt32
    tszName : CHAR[260]
    dwFFMaxForce : UInt32
    dwFFForceResolution : UInt32
    wCollectionNumber : UInt16
    wDesignatorIndex : UInt16
    wUsagePage : UInt16
    wUsage : UInt16
    dwDimension : UInt32
    wExponent : UInt16
    wReportId : UInt16
}
struct DIDEVICEOBJECTINSTANCEW {
    dwSize : UInt32
    guidType : GUID
    dwOfs : UInt32
    dwType : UInt32
    dwFlags : UInt32
    tszName : UInt16[260]
    dwFFMaxForce : UInt32
    dwFFForceResolution : UInt32
    wCollectionNumber : UInt16
    wDesignatorIndex : UInt16
    wUsagePage : UInt16
    wUsage : UInt16
    dwDimension : UInt32
    wExponent : UInt16
    wReportId : UInt16
}
struct LPDIENUMDEVICEOBJECTSCALLBACKA extends FunctionPointer {
    static Types := [DIDEVICEOBJECTINSTANCEA.Ptr, Struct.Ptr, BOOL]
}
struct LPDIENUMDEVICEOBJECTSCALLBACKW extends FunctionPointer {
    static Types := [DIDEVICEOBJECTINSTANCEW.Ptr, Struct.Ptr, BOOL]
}
struct DIPROPHEADER {
    dwSize : UInt32
    dwHeaderSize : UInt32
    dwObj : UInt32
    dwHow : UInt32
}
struct DIPROPDWORD {
    diph : DIPROPHEADER
    dwData : UInt32
}
struct DIPROPPOINTER {
    diph : DIPROPHEADER
    uData : IntPtr
}
struct DIPROPRANGE {
    diph : DIPROPHEADER
    lMin : Int32
    lMax : Int32
}
struct DIPROPCAL {
    diph : DIPROPHEADER
    lMin : Int32
    lCenter : Int32
    lMax : Int32
}
struct DIPROPCALPOV {
    diph : DIPROPHEADER
    lMin : Int32[5]
    lMax : Int32[5]
}
struct DIPROPGUIDANDPATH {
    diph : DIPROPHEADER
    guidClass : GUID
    wszPath : UInt16[260]
}
struct DIPROPSTRING {
    diph : DIPROPHEADER
    wsz : UInt16[260]
}
struct CPOINT {
    lP : Int32
    dwLog : UInt32
}
struct DIPROPCPOINTS {
    diph : DIPROPHEADER
    dwCPointsNum : UInt32
    cp : CPOINT[8]
}
struct DIDEVICEOBJECTDATA_DX3 {
    dwOfs : UInt32
    dwData : UInt32
    dwTimeStamp : UInt32
    dwSequence : UInt32
}
struct DIDEVICEOBJECTDATA {
    dwOfs : UInt32
    dwData : UInt32
    dwTimeStamp : UInt32
    dwSequence : UInt32
    uAppData : IntPtr
}
struct DIDEVICEINSTANCE_DX3A {
    dwSize : UInt32
    guidInstance : GUID
    guidProduct : GUID
    dwDevType : UInt32
    tszInstanceName : CHAR[260]
    tszProductName : CHAR[260]
}
struct DIDEVICEINSTANCE_DX3W {
    dwSize : UInt32
    guidInstance : GUID
    guidProduct : GUID
    dwDevType : UInt32
    tszInstanceName : UInt16[260]
    tszProductName : UInt16[260]
}
struct DIDEVICEINSTANCEA {
    dwSize : UInt32
    guidInstance : GUID
    guidProduct : GUID
    dwDevType : UInt32
    tszInstanceName : CHAR[260]
    tszProductName : CHAR[260]
    guidFFDriver : GUID
    wUsagePage : UInt16
    wUsage : UInt16
}
struct DIDEVICEINSTANCEW {
    dwSize : UInt32
    guidInstance : GUID
    guidProduct : GUID
    dwDevType : UInt32
    tszInstanceName : UInt16[260]
    tszProductName : UInt16[260]
    guidFFDriver : GUID
    wUsagePage : UInt16
    wUsage : UInt16
}
struct IDirectInputDeviceW extends IUnknown {
    static IID := "{5944E681-C92E-11CF-BFC7-444553540000}"
    GetCapabilities(param0)
      => ComCall(3, this.p, DIDEVCAPS.Ptr, param0)
    EnumObjects(param0, param1, param2)
      => ComCall(4, this.p, LPDIENUMDEVICEOBJECTSCALLBACKW, param0, Struct.Ptr, param1, UInt32, param2)
    GetProperty(param0, param1)
      => ComCall(5, this.p, GUID.Ptr, param0, DIPROPHEADER.Ptr, param1)
    SetProperty(param0, param1)
      => ComCall(6, this.p, GUID.Ptr, param0, DIPROPHEADER.Ptr, param1)
    Acquire()
      => ComCall(7, this.p)
    Unacquire()
      => ComCall(8, this.p)
    GetDeviceState(param0, param1)
      => ComCall(9, this.p, UInt32, param0, Struct.Ptr, param1)
    GetDeviceData(param0, param1, param2, param3)
      => ComCall(10, this.p, UInt32, param0, DIDEVICEOBJECTDATA.Ptr, param1, UInt32.Ptr, param2, UInt32, param3)
    SetDataFormat(param0)
      => ComCall(11, this.p, DIDATAFORMAT.Ptr, param0)
    SetEventNotification(param0)
      => ComCall(12, this.p, HANDLE, param0)
    SetCooperativeLevel(param0, param1)
      => ComCall(13, this.p, HWND, param0, UInt32, param1)
    GetObjectInfo(param0, param1, param2)
      => ComCall(14, this.p, DIDEVICEOBJECTINSTANCEW.Ptr, param0, UInt32, param1, UInt32, param2)
    GetDeviceInfo(param0)
      => ComCall(15, this.p, DIDEVICEINSTANCEW.Ptr, param0)
    RunControlPanel(param0, param1)
      => ComCall(16, this.p, HWND, param0, UInt32, param1)
    Initialize(param0, param1, param2)
      => ComCall(17, this.p, HINSTANCE, param0, UInt32, param1, GUID.Ptr, param2)
}
struct IDirectInputDeviceA extends IUnknown {
    static IID := "{5944E680-C92E-11CF-BFC7-444553540000}"
    GetCapabilities(param0)
      => ComCall(3, this.p, DIDEVCAPS.Ptr, param0)
    EnumObjects(param0, param1, param2)
      => ComCall(4, this.p, LPDIENUMDEVICEOBJECTSCALLBACKA, param0, Struct.Ptr, param1, UInt32, param2)
    GetProperty(param0, param1)
      => ComCall(5, this.p, GUID.Ptr, param0, DIPROPHEADER.Ptr, param1)
    SetProperty(param0, param1)
      => ComCall(6, this.p, GUID.Ptr, param0, DIPROPHEADER.Ptr, param1)
    Acquire()
      => ComCall(7, this.p)
    Unacquire()
      => ComCall(8, this.p)
    GetDeviceState(param0, param1)
      => ComCall(9, this.p, UInt32, param0, Struct.Ptr, param1)
    GetDeviceData(param0, param1, param2, param3)
      => ComCall(10, this.p, UInt32, param0, DIDEVICEOBJECTDATA.Ptr, param1, UInt32.Ptr, param2, UInt32, param3)
    SetDataFormat(param0)
      => ComCall(11, this.p, DIDATAFORMAT.Ptr, param0)
    SetEventNotification(param0)
      => ComCall(12, this.p, HANDLE, param0)
    SetCooperativeLevel(param0, param1)
      => ComCall(13, this.p, HWND, param0, UInt32, param1)
    GetObjectInfo(param0, param1, param2)
      => ComCall(14, this.p, DIDEVICEOBJECTINSTANCEA.Ptr, param0, UInt32, param1, UInt32, param2)
    GetDeviceInfo(param0)
      => ComCall(15, this.p, DIDEVICEINSTANCEA.Ptr, param0)
    RunControlPanel(param0, param1)
      => ComCall(16, this.p, HWND, param0, UInt32, param1)
    Initialize(param0, param1, param2)
      => ComCall(17, this.p, HINSTANCE, param0, UInt32, param1, GUID.Ptr, param2)
}
struct DIEFFECTINFOA {
    dwSize : UInt32
    guid : GUID
    dwEffType : UInt32
    dwStaticParams : UInt32
    dwDynamicParams : UInt32
    tszName : CHAR[260]
}
struct DIEFFECTINFOW {
    dwSize : UInt32
    guid : GUID
    dwEffType : UInt32
    dwStaticParams : UInt32
    dwDynamicParams : UInt32
    tszName : UInt16[260]
}
struct LPDIENUMEFFECTSCALLBACKA extends FunctionPointer {
    static Types := [DIEFFECTINFOA.Ptr, Struct.Ptr, BOOL]
}
struct LPDIENUMEFFECTSCALLBACKW extends FunctionPointer {
    static Types := [DIEFFECTINFOW.Ptr, Struct.Ptr, BOOL]
}
struct LPDIENUMCREATEDEFFECTOBJECTSCALLBACK extends FunctionPointer {
    static Types := [IDirectInputEffect, Struct.Ptr, BOOL]
}
struct IDirectInputDevice2W extends IDirectInputDeviceW {
    static IID := "{5944E683-C92E-11CF-BFC7-444553540000}"
    CreateEffect(param0, param1, param2, param3)
      => ComCall(18, this.p, GUID.Ptr, param0, DIEFFECT.Ptr, param1, IDirectInputEffect.Ptr, param2, IUnknown, param3)
    EnumEffects(param0, param1, param2)
      => ComCall(19, this.p, LPDIENUMEFFECTSCALLBACKW, param0, Struct.Ptr, param1, UInt32, param2)
    GetEffectInfo(param0, param1)
      => ComCall(20, this.p, DIEFFECTINFOW.Ptr, param0, GUID.Ptr, param1)
    GetForceFeedbackState(param0)
      => ComCall(21, this.p, UInt32.Ptr, param0)
    SendForceFeedbackCommand(param0)
      => ComCall(22, this.p, UInt32, param0)
    EnumCreatedEffectObjects(param0, param1, param2)
      => ComCall(23, this.p, LPDIENUMCREATEDEFFECTOBJECTSCALLBACK, param0, Struct.Ptr, param1, UInt32, param2)
    Escape(param0)
      => ComCall(24, this.p, DIEFFESCAPE.Ptr, param0)
    Poll()
      => ComCall(25, this.p)
    SendDeviceData(param0, param1, param2, param3)
      => ComCall(26, this.p, UInt32, param0, DIDEVICEOBJECTDATA.Ptr, param1, UInt32.Ptr, param2, UInt32, param3)
}
struct IDirectInputDevice2A extends IDirectInputDeviceA {
    static IID := "{5944E682-C92E-11CF-BFC7-444553540000}"
    CreateEffect(param0, param1, param2, param3)
      => ComCall(18, this.p, GUID.Ptr, param0, DIEFFECT.Ptr, param1, IDirectInputEffect.Ptr, param2, IUnknown, param3)
    EnumEffects(param0, param1, param2)
      => ComCall(19, this.p, LPDIENUMEFFECTSCALLBACKA, param0, Struct.Ptr, param1, UInt32, param2)
    GetEffectInfo(param0, param1)
      => ComCall(20, this.p, DIEFFECTINFOA.Ptr, param0, GUID.Ptr, param1)
    GetForceFeedbackState(param0)
      => ComCall(21, this.p, UInt32.Ptr, param0)
    SendForceFeedbackCommand(param0)
      => ComCall(22, this.p, UInt32, param0)
    EnumCreatedEffectObjects(param0, param1, param2)
      => ComCall(23, this.p, LPDIENUMCREATEDEFFECTOBJECTSCALLBACK, param0, Struct.Ptr, param1, UInt32, param2)
    Escape(param0)
      => ComCall(24, this.p, DIEFFESCAPE.Ptr, param0)
    Poll()
      => ComCall(25, this.p)
    SendDeviceData(param0, param1, param2, param3)
      => ComCall(26, this.p, UInt32, param0, DIDEVICEOBJECTDATA.Ptr, param1, UInt32.Ptr, param2, UInt32, param3)
}
struct IDirectInputDevice7W extends IDirectInputDevice2W {
    static IID := "{57D7C6BD-2356-11D3-8E9D-00C04F6844AE}"
    EnumEffectsInFile(param0, param1, param2, param3)
      => ComCall(27, this.p, "Str", param0, LPDIENUMEFFECTSINFILECALLBACK, param1, Struct.Ptr, param2, UInt32, param3)
    WriteEffectToFile(param0, param1, param2, param3)
      => ComCall(28, this.p, "Str", param0, UInt32, param1, DIFILEEFFECT.Ptr, param2, UInt32, param3)
}
struct IDirectInputDevice7A extends IDirectInputDevice2A {
    static IID := "{57D7C6BC-2356-11D3-8E9D-00C04F6844AE}"
    EnumEffectsInFile(param0, param1, param2, param3)
      => ComCall(27, this.p, PSTR, param0, LPDIENUMEFFECTSINFILECALLBACK, param1, Struct.Ptr, param2, UInt32, param3)
    WriteEffectToFile(param0, param1, param2, param3)
      => ComCall(28, this.p, PSTR, param0, UInt32, param1, DIFILEEFFECT.Ptr, param2, UInt32, param3)
}
struct IDirectInputDevice8W extends IUnknown {
    static IID := "{54D41081-DC15-4833-A41B-748F73A38179}"
    GetCapabilities(param0)
      => ComCall(3, this.p, DIDEVCAPS.Ptr, param0)
    EnumObjects(param0, param1, param2)
      => ComCall(4, this.p, LPDIENUMDEVICEOBJECTSCALLBACKW, param0, Struct.Ptr, param1, UInt32, param2)
    GetProperty(param0, param1)
      => ComCall(5, this.p, GUID.Ptr, param0, DIPROPHEADER.Ptr, param1)
    SetProperty(param0, param1)
      => ComCall(6, this.p, GUID.Ptr, param0, DIPROPHEADER.Ptr, param1)
    Acquire()
      => ComCall(7, this.p)
    Unacquire()
      => ComCall(8, this.p)
    GetDeviceState(param0, param1)
      => ComCall(9, this.p, UInt32, param0, Struct.Ptr, param1)
    GetDeviceData(param0, param1, param2, param3)
      => ComCall(10, this.p, UInt32, param0, DIDEVICEOBJECTDATA.Ptr, param1, UInt32.Ptr, param2, UInt32, param3)
    SetDataFormat(param0)
      => ComCall(11, this.p, DIDATAFORMAT.Ptr, param0)
    SetEventNotification(param0)
      => ComCall(12, this.p, HANDLE, param0)
    SetCooperativeLevel(param0, param1)
      => ComCall(13, this.p, HWND, param0, UInt32, param1)
    GetObjectInfo(param0, param1, param2)
      => ComCall(14, this.p, DIDEVICEOBJECTINSTANCEW.Ptr, param0, UInt32, param1, UInt32, param2)
    GetDeviceInfo(param0)
      => ComCall(15, this.p, DIDEVICEINSTANCEW.Ptr, param0)
    RunControlPanel(param0, param1)
      => ComCall(16, this.p, HWND, param0, UInt32, param1)
    Initialize(param0, param1, param2)
      => ComCall(17, this.p, HINSTANCE, param0, UInt32, param1, GUID.Ptr, param2)
    CreateEffect(param0, param1, param2, param3)
      => ComCall(18, this.p, GUID.Ptr, param0, DIEFFECT.Ptr, param1, IDirectInputEffect.Ptr, param2, IUnknown, param3)
    EnumEffects(param0, param1, param2)
      => ComCall(19, this.p, LPDIENUMEFFECTSCALLBACKW, param0, Struct.Ptr, param1, UInt32, param2)
    GetEffectInfo(param0, param1)
      => ComCall(20, this.p, DIEFFECTINFOW.Ptr, param0, GUID.Ptr, param1)
    GetForceFeedbackState(param0)
      => ComCall(21, this.p, UInt32.Ptr, param0)
    SendForceFeedbackCommand(param0)
      => ComCall(22, this.p, UInt32, param0)
    EnumCreatedEffectObjects(param0, param1, param2)
      => ComCall(23, this.p, LPDIENUMCREATEDEFFECTOBJECTSCALLBACK, param0, Struct.Ptr, param1, UInt32, param2)
    Escape(param0)
      => ComCall(24, this.p, DIEFFESCAPE.Ptr, param0)
    Poll()
      => ComCall(25, this.p)
    SendDeviceData(param0, param1, param2, param3)
      => ComCall(26, this.p, UInt32, param0, DIDEVICEOBJECTDATA.Ptr, param1, UInt32.Ptr, param2, UInt32, param3)
    EnumEffectsInFile(param0, param1, param2, param3)
      => ComCall(27, this.p, "Str", param0, LPDIENUMEFFECTSINFILECALLBACK, param1, Struct.Ptr, param2, UInt32, param3)
    WriteEffectToFile(param0, param1, param2, param3)
      => ComCall(28, this.p, "Str", param0, UInt32, param1, DIFILEEFFECT.Ptr, param2, UInt32, param3)
    BuildActionMap(param0, param1, param2)
      => ComCall(29, this.p, DIACTIONFORMATW.Ptr, param0, "Str", param1, UInt32, param2)
    SetActionMap(param0, param1, param2)
      => ComCall(30, this.p, DIACTIONFORMATW.Ptr, param0, "Str", param1, UInt32, param2)
    GetImageInfo(param0)
      => ComCall(31, this.p, DIDEVICEIMAGEINFOHEADERW.Ptr, param0)
}
struct IDirectInputDevice8A extends IUnknown {
    static IID := "{54D41080-DC15-4833-A41B-748F73A38179}"
    GetCapabilities(param0)
      => ComCall(3, this.p, DIDEVCAPS.Ptr, param0)
    EnumObjects(param0, param1, param2)
      => ComCall(4, this.p, LPDIENUMDEVICEOBJECTSCALLBACKA, param0, Struct.Ptr, param1, UInt32, param2)
    GetProperty(param0, param1)
      => ComCall(5, this.p, GUID.Ptr, param0, DIPROPHEADER.Ptr, param1)
    SetProperty(param0, param1)
      => ComCall(6, this.p, GUID.Ptr, param0, DIPROPHEADER.Ptr, param1)
    Acquire()
      => ComCall(7, this.p)
    Unacquire()
      => ComCall(8, this.p)
    GetDeviceState(param0, param1)
      => ComCall(9, this.p, UInt32, param0, Struct.Ptr, param1)
    GetDeviceData(param0, param1, param2, param3)
      => ComCall(10, this.p, UInt32, param0, DIDEVICEOBJECTDATA.Ptr, param1, UInt32.Ptr, param2, UInt32, param3)
    SetDataFormat(param0)
      => ComCall(11, this.p, DIDATAFORMAT.Ptr, param0)
    SetEventNotification(param0)
      => ComCall(12, this.p, HANDLE, param0)
    SetCooperativeLevel(param0, param1)
      => ComCall(13, this.p, HWND, param0, UInt32, param1)
    GetObjectInfo(param0, param1, param2)
      => ComCall(14, this.p, DIDEVICEOBJECTINSTANCEA.Ptr, param0, UInt32, param1, UInt32, param2)
    GetDeviceInfo(param0)
      => ComCall(15, this.p, DIDEVICEINSTANCEA.Ptr, param0)
    RunControlPanel(param0, param1)
      => ComCall(16, this.p, HWND, param0, UInt32, param1)
    Initialize(param0, param1, param2)
      => ComCall(17, this.p, HINSTANCE, param0, UInt32, param1, GUID.Ptr, param2)
    CreateEffect(param0, param1, param2, param3)
      => ComCall(18, this.p, GUID.Ptr, param0, DIEFFECT.Ptr, param1, IDirectInputEffect.Ptr, param2, IUnknown, param3)
    EnumEffects(param0, param1, param2)
      => ComCall(19, this.p, LPDIENUMEFFECTSCALLBACKA, param0, Struct.Ptr, param1, UInt32, param2)
    GetEffectInfo(param0, param1)
      => ComCall(20, this.p, DIEFFECTINFOA.Ptr, param0, GUID.Ptr, param1)
    GetForceFeedbackState(param0)
      => ComCall(21, this.p, UInt32.Ptr, param0)
    SendForceFeedbackCommand(param0)
      => ComCall(22, this.p, UInt32, param0)
    EnumCreatedEffectObjects(param0, param1, param2)
      => ComCall(23, this.p, LPDIENUMCREATEDEFFECTOBJECTSCALLBACK, param0, Struct.Ptr, param1, UInt32, param2)
    Escape(param0)
      => ComCall(24, this.p, DIEFFESCAPE.Ptr, param0)
    Poll()
      => ComCall(25, this.p)
    SendDeviceData(param0, param1, param2, param3)
      => ComCall(26, this.p, UInt32, param0, DIDEVICEOBJECTDATA.Ptr, param1, UInt32.Ptr, param2, UInt32, param3)
    EnumEffectsInFile(param0, param1, param2, param3)
      => ComCall(27, this.p, PSTR, param0, LPDIENUMEFFECTSINFILECALLBACK, param1, Struct.Ptr, param2, UInt32, param3)
    WriteEffectToFile(param0, param1, param2, param3)
      => ComCall(28, this.p, PSTR, param0, UInt32, param1, DIFILEEFFECT.Ptr, param2, UInt32, param3)
    BuildActionMap(param0, param1, param2)
      => ComCall(29, this.p, DIACTIONFORMATA.Ptr, param0, PSTR, param1, UInt32, param2)
    SetActionMap(param0, param1, param2)
      => ComCall(30, this.p, DIACTIONFORMATA.Ptr, param0, PSTR, param1, UInt32, param2)
    GetImageInfo(param0)
      => ComCall(31, this.p, DIDEVICEIMAGEINFOHEADERA.Ptr, param0)
}
struct DIMOUSESTATE {
    lX : Int32
    lY : Int32
    lZ : Int32
    rgbButtons : UInt8[4]
}
struct DIMOUSESTATE2 {
    lX : Int32
    lY : Int32
    lZ : Int32
    rgbButtons : UInt8[8]
}
struct DIJOYSTATE {
    lX : Int32
    lY : Int32
    lZ : Int32
    lRx : Int32
    lRy : Int32
    lRz : Int32
    rglSlider : Int32[2]
    rgdwPOV : UInt32[4]
    rgbButtons : UInt8[32]
}
struct DIJOYSTATE2 {
    lX : Int32
    lY : Int32
    lZ : Int32
    lRx : Int32
    lRy : Int32
    lRz : Int32
    rglSlider : Int32[2]
    rgdwPOV : UInt32[4]
    rgbButtons : UInt8[128]
    lVX : Int32
    lVY : Int32
    lVZ : Int32
    lVRx : Int32
    lVRy : Int32
    lVRz : Int32
    rglVSlider : Int32[2]
    lAX : Int32
    lAY : Int32
    lAZ : Int32
    lARx : Int32
    lARy : Int32
    lARz : Int32
    rglASlider : Int32[2]
    lFX : Int32
    lFY : Int32
    lFZ : Int32
    lFRx : Int32
    lFRy : Int32
    lFRz : Int32
    rglFSlider : Int32[2]
}
struct LPDIENUMDEVICESCALLBACKA extends FunctionPointer {
    static Types := [DIDEVICEINSTANCEA.Ptr, Struct.Ptr, BOOL]
}
struct LPDIENUMDEVICESCALLBACKW extends FunctionPointer {
    static Types := [DIDEVICEINSTANCEW.Ptr, Struct.Ptr, BOOL]
}
struct LPDICONFIGUREDEVICESCALLBACK extends FunctionPointer {
    static Types := [IUnknown, Struct.Ptr, BOOL]
}
struct LPDIENUMDEVICESBYSEMANTICSCBA extends FunctionPointer {
    static Types := [DIDEVICEINSTANCEA.Ptr, IDirectInputDevice8A, UInt32, UInt32, Struct.Ptr, BOOL]
}
struct LPDIENUMDEVICESBYSEMANTICSCBW extends FunctionPointer {
    static Types := [DIDEVICEINSTANCEW.Ptr, IDirectInputDevice8W, UInt32, UInt32, Struct.Ptr, BOOL]
}
struct IDirectInputW extends IUnknown {
    static IID := "{89521361-AA8A-11CF-BFC7-444553540000}"
    CreateDevice(param0, param1, param2)
      => ComCall(3, this.p, GUID.Ptr, param0, IDirectInputDeviceW.Ptr, param1, IUnknown, param2)
    EnumDevices(param0, param1, param2, param3)
      => ComCall(4, this.p, UInt32, param0, LPDIENUMDEVICESCALLBACKW, param1, Struct.Ptr, param2, UInt32, param3)
    GetDeviceStatus(param0)
      => ComCall(5, this.p, GUID.Ptr, param0)
    RunControlPanel(param0, param1)
      => ComCall(6, this.p, HWND, param0, UInt32, param1)
    Initialize(param0, param1)
      => ComCall(7, this.p, HINSTANCE, param0, UInt32, param1)
}
struct IDirectInputA extends IUnknown {
    static IID := "{89521360-AA8A-11CF-BFC7-444553540000}"
    CreateDevice(param0, param1, param2)
      => ComCall(3, this.p, GUID.Ptr, param0, IDirectInputDeviceA.Ptr, param1, IUnknown, param2)
    EnumDevices(param0, param1, param2, param3)
      => ComCall(4, this.p, UInt32, param0, LPDIENUMDEVICESCALLBACKA, param1, Struct.Ptr, param2, UInt32, param3)
    GetDeviceStatus(param0)
      => ComCall(5, this.p, GUID.Ptr, param0)
    RunControlPanel(param0, param1)
      => ComCall(6, this.p, HWND, param0, UInt32, param1)
    Initialize(param0, param1)
      => ComCall(7, this.p, HINSTANCE, param0, UInt32, param1)
}
struct IDirectInput2W extends IDirectInputW {
    static IID := "{5944E663-AA8A-11CF-BFC7-444553540000}"
    FindDevice(param0, param1, param2)
      => ComCall(8, this.p, GUID.Ptr, param0, "Str", param1, GUID.Ptr, param2)
}
struct IDirectInput2A extends IDirectInputA {
    static IID := "{5944E662-AA8A-11CF-BFC7-444553540000}"
    FindDevice(param0, param1, param2)
      => ComCall(8, this.p, GUID.Ptr, param0, PSTR, param1, GUID.Ptr, param2)
}
struct IDirectInput7W extends IDirectInput2W {
    static IID := "{9A4CB685-236D-11D3-8E9D-00C04F6844AE}"
    CreateDeviceEx(param0, param1, param2, param3)
      => ComCall(9, this.p, GUID.Ptr, param0, GUID.Ptr, param1, Struct.Ptr.Ptr, param2, IUnknown, param3)
}
struct IDirectInput7A extends IDirectInput2A {
    static IID := "{9A4CB684-236D-11D3-8E9D-00C04F6844AE}"
    CreateDeviceEx(param0, param1, param2, param3)
      => ComCall(9, this.p, GUID.Ptr, param0, GUID.Ptr, param1, Struct.Ptr.Ptr, param2, IUnknown, param3)
}
struct IDirectInput8W extends IUnknown {
    static IID := "{BF798031-483A-4DA2-AA99-5D64ED369700}"
    CreateDevice(param0, param1, param2)
      => ComCall(3, this.p, GUID.Ptr, param0, IDirectInputDevice8W.Ptr, param1, IUnknown, param2)
    EnumDevices(param0, param1, param2, param3)
      => ComCall(4, this.p, UInt32, param0, LPDIENUMDEVICESCALLBACKW, param1, Struct.Ptr, param2, UInt32, param3)
    GetDeviceStatus(param0)
      => ComCall(5, this.p, GUID.Ptr, param0)
    RunControlPanel(param0, param1)
      => ComCall(6, this.p, HWND, param0, UInt32, param1)
    Initialize(param0, param1)
      => ComCall(7, this.p, HINSTANCE, param0, UInt32, param1)
    FindDevice(param0, param1, param2)
      => ComCall(8, this.p, GUID.Ptr, param0, "Str", param1, GUID.Ptr, param2)
    EnumDevicesBySemantics(param0, param1, param2, param3, param4)
      => ComCall(9, this.p, "Str", param0, DIACTIONFORMATW.Ptr, param1, LPDIENUMDEVICESBYSEMANTICSCBW, param2, Struct.Ptr, param3, UInt32, param4)
    ConfigureDevices(param0, param1, param2, param3)
      => ComCall(10, this.p, LPDICONFIGUREDEVICESCALLBACK, param0, DICONFIGUREDEVICESPARAMSW.Ptr, param1, UInt32, param2, Struct.Ptr, param3)
}
struct IDirectInput8A extends IUnknown {
    static IID := "{BF798030-483A-4DA2-AA99-5D64ED369700}"
    CreateDevice(param0, param1, param2)
      => ComCall(3, this.p, GUID.Ptr, param0, IDirectInputDevice8A.Ptr, param1, IUnknown, param2)
    EnumDevices(param0, param1, param2, param3)
      => ComCall(4, this.p, UInt32, param0, LPDIENUMDEVICESCALLBACKA, param1, Struct.Ptr, param2, UInt32, param3)
    GetDeviceStatus(param0)
      => ComCall(5, this.p, GUID.Ptr, param0)
    RunControlPanel(param0, param1)
      => ComCall(6, this.p, HWND, param0, UInt32, param1)
    Initialize(param0, param1)
      => ComCall(7, this.p, HINSTANCE, param0, UInt32, param1)
    FindDevice(param0, param1, param2)
      => ComCall(8, this.p, GUID.Ptr, param0, PSTR, param1, GUID.Ptr, param2)
    EnumDevicesBySemantics(param0, param1, param2, param3, param4)
      => ComCall(9, this.p, PSTR, param0, DIACTIONFORMATA.Ptr, param1, LPDIENUMDEVICESBYSEMANTICSCBA, param2, Struct.Ptr, param3, UInt32, param4)
    ConfigureDevices(param0, param1, param2, param3)
      => ComCall(10, this.p, LPDICONFIGUREDEVICESCALLBACK, param0, DICONFIGUREDEVICESPARAMSA.Ptr, param1, UInt32, param2, Struct.Ptr, param3)
}
struct LPFNSHOWJOYCPL extends FunctionPointer {
    static Types := [HWND, "Void"]
}
struct DIOBJECTATTRIBUTES {
    dwFlags : UInt32
    wUsagePage : UInt16
    wUsage : UInt16
}
struct DIFFOBJECTATTRIBUTES {
    dwFFMaxForce : UInt32
    dwFFForceResolution : UInt32
}
struct DIOBJECTCALIBRATION {
    lMin : Int32
    lCenter : Int32
    lMax : Int32
}
struct DIPOVCALIBRATION {
    lMin : Int32[5]
    lMax : Int32[5]
}
struct DIEFFECTATTRIBUTES {
    dwEffectId : UInt32
    dwEffType : UInt32
    dwStaticParams : UInt32
    dwDynamicParams : UInt32
    dwCoords : UInt32
}
struct DIFFDEVICEATTRIBUTES {
    dwFlags : UInt32
    dwFFSamplePeriod : UInt32
    dwFFMinTimeResolution : UInt32
}
struct DIDRIVERVERSIONS {
    dwSize : UInt32
    dwFirmwareRevision : UInt32
    dwHardwareRevision : UInt32
    dwFFDriverVersion : UInt32
}
struct DIDEVICESTATE {
    dwSize : UInt32
    dwState : UInt32
    dwLoad : UInt32
}
struct DIHIDFFINITINFO {
    dwSize : UInt32
    pwszDeviceInterface : PWSTR
    GuidInstance : GUID
}
struct IDirectInputEffectDriver extends IUnknown {
    static IID := "{02538130-898F-11D0-9AD0-00A0C9A06E35}"
    DeviceID(param0, param1, param2, param3, param4)
      => ComCall(3, this.p, UInt32, param0, UInt32, param1, UInt32, param2, UInt32, param3, Struct.Ptr, param4)
    GetVersions(param0)
      => ComCall(4, this.p, DIDRIVERVERSIONS.Ptr, param0)
    Escape(param0, param1, param2)
      => ComCall(5, this.p, UInt32, param0, UInt32, param1, DIEFFESCAPE.Ptr, param2)
    SetGain(param0, param1)
      => ComCall(6, this.p, UInt32, param0, UInt32, param1)
    SendForceFeedbackCommand(param0, param1)
      => ComCall(7, this.p, UInt32, param0, UInt32, param1)
    GetForceFeedbackState(param0, param1)
      => ComCall(8, this.p, UInt32, param0, DIDEVICESTATE.Ptr, param1)
    DownloadEffect(param0, param1, param2, param3, param4)
      => ComCall(9, this.p, UInt32, param0, UInt32, param1, UInt32.Ptr, param2, DIEFFECT.Ptr, param3, UInt32, param4)
    DestroyEffect(param0, param1)
      => ComCall(10, this.p, UInt32, param0, UInt32, param1)
    StartEffect(param0, param1, param2, param3)
      => ComCall(11, this.p, UInt32, param0, UInt32, param1, UInt32, param2, UInt32, param3)
    StopEffect(param0, param1)
      => ComCall(12, this.p, UInt32, param0, UInt32, param1)
    GetEffectStatus(param0, param1, param2)
      => ComCall(13, this.p, UInt32, param0, UInt32, param1, UInt32.Ptr, param2)
}
struct JOYPOS {
    dwX : UInt32
    dwY : UInt32
    dwZ : UInt32
    dwR : UInt32
    dwU : UInt32
    dwV : UInt32
}
struct JOYRANGE {
    jpMin : JOYPOS
    jpMax : JOYPOS
    jpCenter : JOYPOS
}
struct JOYREGUSERVALUES {
    dwTimeOut : UInt32
    jrvRanges : JOYRANGE
    jpDeadZone : JOYPOS
}
struct JOYREGHWSETTINGS {
    dwFlags : UInt32
    dwNumButtons : UInt32
}
struct JOYREGHWVALUES {
    jrvHardware : JOYRANGE
    dwPOVValues : UInt32[4]
    dwCalFlags : UInt32
}
struct JOYREGHWCONFIG {
    hws : JOYREGHWSETTINGS
    dwUsageSettings : UInt32
    hwv : JOYREGHWVALUES
    dwType : UInt32
    dwReserved : UInt32
}
struct JOYCALIBRATE {
    wXbase : UInt32
    wXdelta : UInt32
    wYbase : UInt32
    wYdelta : UInt32
    wZbase : UInt32
    wZdelta : UInt32
}
struct LPDIJOYTYPECALLBACK extends FunctionPointer {
    static Types := [PWSTR, Struct.Ptr, BOOL]
}
struct DIJOYTYPEINFO_DX5 {
    dwSize : UInt32
    hws : JOYREGHWSETTINGS
    clsidConfig : GUID
    wszDisplayName : UInt16[256]
    wszCallout : UInt16[260]
}
struct DIJOYTYPEINFO_DX6 {
    dwSize : UInt32
    hws : JOYREGHWSETTINGS
    clsidConfig : GUID
    wszDisplayName : UInt16[256]
    wszCallout : UInt16[260]
    wszHardwareId : UInt16[256]
    dwFlags1 : UInt32
}
struct DIJOYTYPEINFO {
    dwSize : UInt32
    hws : JOYREGHWSETTINGS
    clsidConfig : GUID
    wszDisplayName : UInt16[256]
    wszCallout : UInt16[260]
    wszHardwareId : UInt16[256]
    dwFlags1 : UInt32
    dwFlags2 : UInt32
    wszMapFile : UInt16[256]
}
struct DIJOYCONFIG_DX5 {
    dwSize : UInt32
    guidInstance : GUID
    hwc : JOYREGHWCONFIG
    dwGain : UInt32
    wszType : UInt16[256]
    wszCallout : UInt16[256]
}
struct DIJOYCONFIG {
    dwSize : UInt32
    guidInstance : GUID
    hwc : JOYREGHWCONFIG
    dwGain : UInt32
    wszType : UInt16[256]
    wszCallout : UInt16[256]
    guidGameport : GUID
}
struct DIJOYUSERVALUES {
    dwSize : UInt32
    ruv : JOYREGUSERVALUES
    wszGlobalDriver : UInt16[256]
    wszGameportEmulator : UInt16[256]
}
struct IDirectInputJoyConfig extends IUnknown {
    static IID := "{1DE12AB1-C9F5-11CF-BFC7-444553540000}"
    Acquire()
      => ComCall(3, this.p)
    Unacquire()
      => ComCall(4, this.p)
    SetCooperativeLevel(param0, param1)
      => ComCall(5, this.p, HWND, param0, UInt32, param1)
    SendNotify()
      => ComCall(6, this.p)
    EnumTypes(param0, param1)
      => ComCall(7, this.p, LPDIJOYTYPECALLBACK, param0, Struct.Ptr, param1)
    GetTypeInfo(param0, param1, param2)
      => ComCall(8, this.p, "Str", param0, DIJOYTYPEINFO.Ptr, param1, UInt32, param2)
    SetTypeInfo(param0, param1, param2)
      => ComCall(9, this.p, "Str", param0, DIJOYTYPEINFO.Ptr, param1, UInt32, param2)
    DeleteType(param0)
      => ComCall(10, this.p, "Str", param0)
    GetConfig(param0, param1, param2)
      => ComCall(11, this.p, UInt32, param0, DIJOYCONFIG.Ptr, param1, UInt32, param2)
    SetConfig(param0, param1, param2)
      => ComCall(12, this.p, UInt32, param0, DIJOYCONFIG.Ptr, param1, UInt32, param2)
    DeleteConfig(param0)
      => ComCall(13, this.p, UInt32, param0)
    GetUserValues(param0, param1)
      => ComCall(14, this.p, DIJOYUSERVALUES.Ptr, param0, UInt32, param1)
    SetUserValues(param0, param1)
      => ComCall(15, this.p, DIJOYUSERVALUES.Ptr, param0, UInt32, param1)
    AddNewHardware(param0, param1)
      => ComCall(16, this.p, HWND, param0, GUID.Ptr, param1)
    OpenTypeKey(param0, param1, param2)
      => ComCall(17, this.p, "Str", param0, UInt32, param1, HKEY.Ptr, param2)
    OpenConfigKey(param0, param1, param2)
      => ComCall(18, this.p, UInt32, param0, UInt32, param1, HKEY.Ptr, param2)
}
struct IDirectInputJoyConfig8 extends IUnknown {
    static IID := "{EB0D7DFA-1990-4F27-B4D6-EDF2EEC4A44C}"
    Acquire()
      => ComCall(3, this.p)
    Unacquire()
      => ComCall(4, this.p)
    SetCooperativeLevel(param0, param1)
      => ComCall(5, this.p, HWND, param0, UInt32, param1)
    SendNotify()
      => ComCall(6, this.p)
    EnumTypes(param0, param1)
      => ComCall(7, this.p, LPDIJOYTYPECALLBACK, param0, Struct.Ptr, param1)
    GetTypeInfo(param0, param1, param2)
      => ComCall(8, this.p, "Str", param0, DIJOYTYPEINFO.Ptr, param1, UInt32, param2)
    SetTypeInfo(param0, param1, param2, param3)
      => ComCall(9, this.p, "Str", param0, DIJOYTYPEINFO.Ptr, param1, UInt32, param2, "Str", param3)
    DeleteType(param0)
      => ComCall(10, this.p, "Str", param0)
    GetConfig(param0, param1, param2)
      => ComCall(11, this.p, UInt32, param0, DIJOYCONFIG.Ptr, param1, UInt32, param2)
    SetConfig(param0, param1, param2)
      => ComCall(12, this.p, UInt32, param0, DIJOYCONFIG.Ptr, param1, UInt32, param2)
    DeleteConfig(param0)
      => ComCall(13, this.p, UInt32, param0)
    GetUserValues(param0, param1)
      => ComCall(14, this.p, DIJOYUSERVALUES.Ptr, param0, UInt32, param1)
    SetUserValues(param0, param1)
      => ComCall(15, this.p, DIJOYUSERVALUES.Ptr, param0, UInt32, param1)
    AddNewHardware(param0, param1)
      => ComCall(16, this.p, HWND, param0, GUID.Ptr, param1)
    OpenTypeKey(param0, param1, param2)
      => ComCall(17, this.p, "Str", param0, UInt32, param1, HKEY.Ptr, param2)
    OpenAppStatusKey(param0)
      => ComCall(18, this.p, HKEY.Ptr, param0)
}
struct KEYBOARD_INPUT_DATA {
    UnitId : UInt16
    MakeCode : UInt16
    Flags : UInt16
    Reserved : UInt16
    ExtraInformation : UInt32
}
struct KEYBOARD_TYPEMATIC_PARAMETERS {
    UnitId : UInt16
    Rate : UInt16
    Delay : UInt16
}
struct KEYBOARD_ID {
    Type : UInt8
    Subtype : UInt8
}
struct KEYBOARD_ATTRIBUTES {
    KeyboardIdentifier : KEYBOARD_ID
    KeyboardMode : UInt16
    NumberOfFunctionKeys : UInt16
    NumberOfIndicators : UInt16
    NumberOfKeysTotal : UInt16
    InputDataQueueLength : UInt32
    KeyRepeatMinimum : KEYBOARD_TYPEMATIC_PARAMETERS
    KeyRepeatMaximum : KEYBOARD_TYPEMATIC_PARAMETERS
}
struct KEYBOARD_EXTENDED_ATTRIBUTES {
    Version : UInt8
    FormFactor : UInt8
    KeyType : UInt8
    PhysicalLayout : UInt8
    VendorSpecificPhysicalLayout : UInt8
    IETFLanguageTagIndex : UInt8
    ImplementedInputAssistControls : UInt8
}
struct KEYBOARD_INDICATOR_PARAMETERS {
    UnitId : UInt16
    LedFlags : UInt16
}
struct INDICATOR_LIST {
    MakeCode : UInt16
    IndicatorFlags : UInt16
}
struct KEYBOARD_INDICATOR_TRANSLATION {
    NumberOfIndicatorKeys : UInt16
    IndicatorList : INDICATOR_LIST[1]
}
struct KEYBOARD_UNIT_ID_PARAMETER {
    UnitId : UInt16
}
struct KEYBOARD_IME_STATUS {
    UnitId : UInt16
    ImeOpen : UInt32
    ImeConvMode : UInt32
}
struct MOUSE_INPUT_DATA {
    UnitId : UInt16
    Flags : UInt16
    Anonymous : this._Anonymous_e__Union
    RawButtons : UInt32
    LastX : Int32
    LastY : Int32
    ExtraInformation : UInt32
    struct _Anonymous_e__Union {
        union {
            Buttons : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            ButtonFlags : UInt16
            ButtonData : UInt16
        }
    }
}
struct MOUSE_ATTRIBUTES {
    MouseIdentifier : UInt16
    NumberOfButtons : UInt16
    SampleRate : UInt16
    InputDataQueueLength : UInt32
}
struct MOUSE_UNIT_ID_PARAMETER {
    UnitId : UInt16
}
struct HIDP_REPORT_TYPE extends Int32 {
    static HidP_Input := 0
    static HidP_Output := 1
    static HidP_Feature := 2
}
struct USAGE_AND_PAGE {
    Usage : UInt16
    UsagePage : UInt16
}
struct HIDP_BUTTON_CAPS {
    UsagePage : UInt16
    ReportID : UInt8
    IsAlias : BOOLEAN
    BitField : UInt16
    LinkCollection : UInt16
    LinkUsage : UInt16
    LinkUsagePage : UInt16
    IsRange : BOOLEAN
    IsStringRange : BOOLEAN
    IsDesignatorRange : BOOLEAN
    IsAbsolute : BOOLEAN
    ReportCount : UInt16
    Reserved2 : UInt16
    Reserved : UInt32[9]
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Range : this._Range_e__Struct
            NotRange : this._NotRange_e__Struct
        }
        struct _Range_e__Struct {
            UsageMin : UInt16
            UsageMax : UInt16
            StringMin : UInt16
            StringMax : UInt16
            DesignatorMin : UInt16
            DesignatorMax : UInt16
            DataIndexMin : UInt16
            DataIndexMax : UInt16
        }
        struct _NotRange_e__Struct {
            Usage : UInt16
            Reserved1 : UInt16
            StringIndex : UInt16
            Reserved2 : UInt16
            DesignatorIndex : UInt16
            Reserved3 : UInt16
            DataIndex : UInt16
            Reserved4 : UInt16
        }
    }
}
struct HIDP_VALUE_CAPS {
    UsagePage : UInt16
    ReportID : UInt8
    IsAlias : BOOLEAN
    BitField : UInt16
    LinkCollection : UInt16
    LinkUsage : UInt16
    LinkUsagePage : UInt16
    IsRange : BOOLEAN
    IsStringRange : BOOLEAN
    IsDesignatorRange : BOOLEAN
    IsAbsolute : BOOLEAN
    HasNull : BOOLEAN
    Reserved : UInt8
    BitSize : UInt16
    ReportCount : UInt16
    Reserved2 : UInt16[5]
    UnitsExp : UInt32
    Units : UInt32
    LogicalMin : Int32
    LogicalMax : Int32
    PhysicalMin : Int32
    PhysicalMax : Int32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Range : this._Range_e__Struct
            NotRange : this._NotRange_e__Struct
        }
        struct _Range_e__Struct {
            UsageMin : UInt16
            UsageMax : UInt16
            StringMin : UInt16
            StringMax : UInt16
            DesignatorMin : UInt16
            DesignatorMax : UInt16
            DataIndexMin : UInt16
            DataIndexMax : UInt16
        }
        struct _NotRange_e__Struct {
            Usage : UInt16
            Reserved1 : UInt16
            StringIndex : UInt16
            Reserved2 : UInt16
            DesignatorIndex : UInt16
            Reserved3 : UInt16
            DataIndex : UInt16
            Reserved4 : UInt16
        }
    }
}
struct HIDP_LINK_COLLECTION_NODE {
    LinkUsage : UInt16
    LinkUsagePage : UInt16
    Parent : UInt16
    NumberOfChildren : UInt16
    NextSibling : UInt16
    FirstChild : UInt16
    _bitfield : UInt32
    UserContext : Struct.Ptr
}
struct HIDP_CAPS {
    Usage : UInt16
    UsagePage : UInt16
    InputReportByteLength : UInt16
    OutputReportByteLength : UInt16
    FeatureReportByteLength : UInt16
    Reserved : UInt16[17]
    NumberLinkCollectionNodes : UInt16
    NumberInputButtonCaps : UInt16
    NumberInputValueCaps : UInt16
    NumberInputDataIndices : UInt16
    NumberOutputButtonCaps : UInt16
    NumberOutputValueCaps : UInt16
    NumberOutputDataIndices : UInt16
    NumberFeatureButtonCaps : UInt16
    NumberFeatureValueCaps : UInt16
    NumberFeatureDataIndices : UInt16
}
struct HIDP_DATA {
    DataIndex : UInt16
    Reserved : UInt16
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            RawValue : UInt32
            On : BOOLEAN
        }
    }
}
struct HIDP_UNKNOWN_TOKEN {
    Token : UInt8
    Reserved : UInt8[3]
    BitField : UInt32
}
struct HIDP_EXTENDED_ATTRIBUTES {
    NumGlobalUnknowns : UInt8
    Reserved : UInt8[3]
    GlobalUnknowns : HIDP_UNKNOWN_TOKEN.Ptr
    Data : UInt32[1]
}
struct HIDP_BUTTON_ARRAY_DATA {
    ArrayIndex : UInt16
    On : BOOLEAN
}
struct HIDP_KEYBOARD_DIRECTION extends Int32 {
    static HidP_Keyboard_Break := 0
    static HidP_Keyboard_Make := 1
}
struct HIDP_KEYBOARD_MODIFIER_STATE {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            ul : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PHIDP_INSERT_SCANCODES extends FunctionPointer {
    static Types := [Struct.Ptr, PSTR, UInt32, BOOLEAN]
}
struct PFN_HidP_GetVersionInternal extends FunctionPointer {
    static Types := [UInt32.Ptr, NTSTATUS]
}
struct HIDD_CONFIGURATION {
    cookie : Struct.Ptr
    size : UInt32
    RingBufferSize : UInt32
}
struct HIDD_ATTRIBUTES {
    Size : UInt32
    VendorID : UInt16
    ProductID : UInt16
    VersionNumber : UInt16
}
struct HID_XFER_PACKET {
    reportBuffer : UInt8.Ptr
    reportBufferLen : UInt32
    reportId : UInt8
}
struct HID_COLLECTION_INFORMATION {
    DescriptorSize : UInt32
    Polled : BOOLEAN
    Reserved1 : UInt8[1]
    VendorID : UInt16
    ProductID : UInt16
    VersionNumber : UInt16
}
struct HID_DRIVER_CONFIG {
    Size : UInt32
    RingBufferSize : UInt32
}
struct GPIOBUTTONS_BUTTON_TYPE extends Int32 {
    static GPIO_BUTTON_POWER := 0
    static GPIO_BUTTON_WINDOWS := 1
    static GPIO_BUTTON_VOLUME_UP := 2
    static GPIO_BUTTON_VOLUME_DOWN := 3
    static GPIO_BUTTON_ROTATION_LOCK := 4
    static GPIO_BUTTON_BACK := 5
    static GPIO_BUTTON_SEARCH := 6
    static GPIO_BUTTON_CAMERA_FOCUS := 7
    static GPIO_BUTTON_CAMERA_SHUTTER := 8
    static GPIO_BUTTON_RINGER_TOGGLE := 9
    static GPIO_BUTTON_HEADSET := 10
    static GPIO_BUTTON_HWKB_DEPLOY := 11
    static GPIO_BUTTON_CAMERA_LENS := 12
    static GPIO_BUTTON_OEM_CUSTOM := 13
    static GPIO_BUTTON_OEM_CUSTOM2 := 14
    static GPIO_BUTTON_OEM_CUSTOM3 := 15
    static GPIO_BUTTON_COUNT_MIN := 5
    static GPIO_BUTTON_COUNT := 16
}
struct INPUT_BUTTON_ENABLE_INFO {
    ButtonType : GPIOBUTTONS_BUTTON_TYPE
    Enabled : BOOLEAN
}
