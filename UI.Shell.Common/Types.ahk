#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct SHITEMID {
    cb : UInt16
    abID : UInt8[1]
}
struct ITEMIDLIST {
    mkid : SHITEMID
}
struct STRRET_TYPE extends Int32 {
    static STRRET_WSTR := 0
    static STRRET_OFFSET := 1
    static STRRET_CSTR := 2
}
struct STRRET {
    uType : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pOleStr : PWSTR
            uOffset : UInt32
            cStr : UInt8[260]
        }
    }
}
struct SHELLDETAILS {
    fmt : Int32
    cxChar : Int32
    str : STRRET
}
struct PERCEIVED extends Int32 {
    static PERCEIVED_TYPE_FIRST := -3
    static PERCEIVED_TYPE_CUSTOM := -3
    static PERCEIVED_TYPE_UNSPECIFIED := -2
    static PERCEIVED_TYPE_FOLDER := -1
    static PERCEIVED_TYPE_UNKNOWN := 0
    static PERCEIVED_TYPE_TEXT := 1
    static PERCEIVED_TYPE_IMAGE := 2
    static PERCEIVED_TYPE_AUDIO := 3
    static PERCEIVED_TYPE_VIDEO := 4
    static PERCEIVED_TYPE_COMPRESSED := 5
    static PERCEIVED_TYPE_DOCUMENT := 6
    static PERCEIVED_TYPE_SYSTEM := 7
    static PERCEIVED_TYPE_APPLICATION := 8
    static PERCEIVED_TYPE_GAMEMEDIA := 9
    static PERCEIVED_TYPE_CONTACTS := 10
    static PERCEIVED_TYPE_LAST := 10
}
struct COMDLG_FILTERSPEC {
    pszName : PWSTR
    pszSpec : PWSTR
}
struct SHCOLSTATE extends Int32 {
    static SHCOLSTATE_DEFAULT := 0
    static SHCOLSTATE_TYPE_STR := 1
    static SHCOLSTATE_TYPE_INT := 2
    static SHCOLSTATE_TYPE_DATE := 3
    static SHCOLSTATE_TYPEMASK := 15
    static SHCOLSTATE_ONBYDEFAULT := 16
    static SHCOLSTATE_SLOW := 32
    static SHCOLSTATE_EXTENDED := 64
    static SHCOLSTATE_SECONDARYUI := 128
    static SHCOLSTATE_HIDDEN := 256
    static SHCOLSTATE_PREFER_VARCMP := 512
    static SHCOLSTATE_PREFER_FMTCMP := 1024
    static SHCOLSTATE_NOSORTBYFOLDERNESS := 2048
    static SHCOLSTATE_VIEWONLY := 65536
    static SHCOLSTATE_BATCHREAD := 131072
    static SHCOLSTATE_NO_GROUPBY := 262144
    static SHCOLSTATE_FIXED_WIDTH := 4096
    static SHCOLSTATE_NODPISCALE := 8192
    static SHCOLSTATE_FIXED_RATIO := 16384
    static SHCOLSTATE_DISPLAYMASK := 61440
}
struct DEVICE_SCALE_FACTOR extends Int32 {
    static DEVICE_SCALE_FACTOR_INVALID := 0
    static SCALE_100_PERCENT := 100
    static SCALE_120_PERCENT := 120
    static SCALE_125_PERCENT := 125
    static SCALE_140_PERCENT := 140
    static SCALE_150_PERCENT := 150
    static SCALE_160_PERCENT := 160
    static SCALE_175_PERCENT := 175
    static SCALE_180_PERCENT := 180
    static SCALE_200_PERCENT := 200
    static SCALE_225_PERCENT := 225
    static SCALE_250_PERCENT := 250
    static SCALE_300_PERCENT := 300
    static SCALE_350_PERCENT := 350
    static SCALE_400_PERCENT := 400
    static SCALE_450_PERCENT := 450
    static SCALE_500_PERCENT := 500
}
struct IObjectArray extends IUnknown {
    static IID := "{92CA9DCD-5622-4BBA-A805-5E9F541BD8C9}"
    GetCount(pcObjects)
      => ComCall(3, this.p, UInt32.Ptr, pcObjects)
    GetAt(uiIndex, riid, ppv)
      => ComCall(4, this.p, UInt32, uiIndex, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IObjectCollection extends IObjectArray {
    static IID := "{5632B1A4-E38A-400A-928A-D4CD63230295}"
    AddObject(punk)
      => ComCall(5, this.p, IUnknown, punk)
    AddFromArray(poaSource)
      => ComCall(6, this.p, IObjectArray, poaSource)
    RemoveObjectAt(uiIndex)
      => ComCall(7, this.p, UInt32, uiIndex)
    Clear()
      => ComCall(8, this.p)
}
