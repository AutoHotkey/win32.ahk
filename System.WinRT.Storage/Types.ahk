#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HANDLE, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct IRandomAccessStreamFileAccessMode extends IUnknown {
    static IID := "{332E5848-2E15-458E-85C4-C911C0C3D6F4}"
    GetMode(fileAccessMode)
      => ComCall(3, this.p, UInt32.Ptr, fileAccessMode)
}
struct IUnbufferedFileHandleOplockCallback extends IUnknown {
    static IID := "{D1019A0E-6243-4329-8497-2E75894D7710}"
    OnBrokenCallback()
      => ComCall(3, this.p)
}
struct IUnbufferedFileHandleProvider extends IUnknown {
    static IID := "{A65C9109-42AB-4B94-A7B1-DD2E4E68515E}"
    OpenUnbufferedFileHandle(oplockBreakCallback, fileHandle)
      => ComCall(3, this.p, IUnbufferedFileHandleOplockCallback, oplockBreakCallback, IntPtr.Ptr, fileHandle)
    CloseUnbufferedFileHandle()
      => ComCall(4, this.p)
}
struct HANDLE_OPTIONS extends UInt32 {
    static HO_NONE := 0
    static HO_OPEN_REQUIRING_OPLOCK := 262144
    static HO_DELETE_ON_CLOSE := 67108864
    static HO_SEQUENTIAL_SCAN := 134217728
    static HO_RANDOM_ACCESS := 268435456
    static HO_NO_BUFFERING := 536870912
    static HO_OVERLAPPED := 1073741824
    static HO_WRITE_THROUGH := 2147483648
}
struct HANDLE_ACCESS_OPTIONS extends Int32 {
    static HAO_NONE := 0
    static HAO_READ_ATTRIBUTES := 128
    static HAO_READ := 1179785
    static HAO_WRITE := 1179926
    static HAO_DELETE := 65536
}
struct HANDLE_SHARING_OPTIONS extends Int32 {
    static HSO_SHARE_NONE := 0
    static HSO_SHARE_READ := 1
    static HSO_SHARE_WRITE := 2
    static HSO_SHARE_DELETE := 4
}
struct HANDLE_CREATION_OPTIONS extends Int32 {
    static HCO_CREATE_NEW := 1
    static HCO_CREATE_ALWAYS := 2
    static HCO_OPEN_EXISTING := 3
    static HCO_OPEN_ALWAYS := 4
    static HCO_TRUNCATE_EXISTING := 5
}
struct IOplockBreakingHandler extends IUnknown {
    static IID := "{826ABE3D-3ACD-47D3-84F2-88AAEDCF6304}"
    OplockBreaking()
      => ComCall(3, this.p)
}
struct IStorageItemHandleAccess extends IUnknown {
    static IID := "{5CA296B2-2C25-4D22-B785-B885C8201E6A}"
    Create(accessOptions, sharingOptions, options, oplockBreakingHandler?, interopHandle)
      => ComCall(3, this.p, HANDLE_ACCESS_OPTIONS, accessOptions, HANDLE_SHARING_OPTIONS, sharingOptions, HANDLE_OPTIONS, options, IOplockBreakingHandler, oplockBreakingHandler?, HANDLE.Ptr, interopHandle)
}
struct IStorageFolderHandleAccess extends IUnknown {
    static IID := "{DF19938F-5462-48A0-BE65-D2A3271A08D6}"
    Create(fileName, creationOptions, accessOptions, sharingOptions, options, oplockBreakingHandler?, interopHandle)
      => ComCall(3, this.p, "Str", fileName, HANDLE_CREATION_OPTIONS, creationOptions, HANDLE_ACCESS_OPTIONS, accessOptions, HANDLE_SHARING_OPTIONS, sharingOptions, HANDLE_OPTIONS, options, IOplockBreakingHandler, oplockBreakingHandler?, HANDLE.Ptr, interopHandle)
}
