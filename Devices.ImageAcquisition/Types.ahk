#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, FILETIME, HANDLE, HGLOBAL, HRESULT, HWND, PWSTR, RECT}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown, STGMEDIUM}
#Import "..\System.Com.StructuredStorage\Types.ahk" {IEnumSTATPROPSTG, PROPSPEC, PROPVARIANT, STATPROPSETSTG}
#Import "..\System.Variant\Types.ahk" {VARENUM}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HICON}

struct WIA_DITHER_PATTERN_DATA {
    lSize : Int32
    bstrPatternName : BSTR
    lPatternWidth : Int32
    lPatternLength : Int32
    cbPattern : Int32
    pbPattern : UInt8.Ptr
}
struct WIA_PROPID_TO_NAME {
    propid : UInt32
    pszName : PWSTR
}
struct WIA_FORMAT_INFO {
    guidFormatID : GUID
    lTymed : Int32
}
struct WIA_RAW_HEADER {
    Tag : UInt32
    Version : UInt32
    HeaderSize : UInt32
    XRes : UInt32
    YRes : UInt32
    XExtent : UInt32
    YExtent : UInt32
    BytesPerLine : UInt32
    BitsPerPixel : UInt32
    ChannelsPerPixel : UInt32
    DataType : UInt32
    BitsPerChannel : UInt8[8]
    Compression : UInt32
    PhotometricInterp : UInt32
    LineOrder : UInt32
    RawDataOffset : UInt32
    RawDataSize : UInt32
    PaletteOffset : UInt32
    PaletteSize : UInt32
}
struct WIA_BARCODE_INFO {
    Size : UInt32
    Type : UInt32
    Page : UInt32
    Confidence : UInt32
    XOffset : UInt32
    YOffset : UInt32
    Rotation : UInt32
    Length : UInt32
    Text : UInt16[1]
}
struct WIA_BARCODES {
    Tag : UInt32
    Version : UInt32
    Size : UInt32
    Count : UInt32
    Barcodes : WIA_BARCODE_INFO[1]
}
struct WIA_PATCH_CODE_INFO {
    Type : UInt32
}
struct WIA_PATCH_CODES {
    Tag : UInt32
    Version : UInt32
    Size : UInt32
    Count : UInt32
    PatchCodes : WIA_PATCH_CODE_INFO[1]
}
struct WIA_MICR_INFO {
    Size : UInt32
    Page : UInt32
    Length : UInt32
    Text : UInt16[1]
}
struct WIA_MICR {
    Tag : UInt32
    Version : UInt32
    Size : UInt32
    Placeholder : UInt16
    Reserved : UInt16
    Count : UInt32
    Micr : WIA_MICR_INFO[1]
}
struct IWiaDevMgr extends IUnknown {
    static IID := "{5EB2502A-8CF1-11D1-BF92-0060081ED811}"
    EnumDeviceInfo(lFlag, ppIEnum)
      => ComCall(3, this.p, Int32, lFlag, IEnumWIA_DEV_INFO.Ptr, ppIEnum)
    CreateDevice(bstrDeviceID, ppWiaItemRoot)
      => ComCall(4, this.p, BSTR, bstrDeviceID, IWiaItem.Ptr, ppWiaItemRoot)
    SelectDeviceDlg(hwndParent, lDeviceType, lFlags, pbstrDeviceID, ppItemRoot)
      => ComCall(5, this.p, HWND, hwndParent, Int32, lDeviceType, Int32, lFlags, BSTR.Ptr, pbstrDeviceID, IWiaItem.Ptr, ppItemRoot)
    SelectDeviceDlgID(hwndParent, lDeviceType, lFlags, pbstrDeviceID)
      => ComCall(6, this.p, HWND, hwndParent, Int32, lDeviceType, Int32, lFlags, BSTR.Ptr, pbstrDeviceID)
    GetImageDlg(hwndParent, lDeviceType, lFlags, lIntent, pItemRoot, bstrFilename, pguidFormat)
      => ComCall(7, this.p, HWND, hwndParent, Int32, lDeviceType, Int32, lFlags, Int32, lIntent, IWiaItem, pItemRoot, BSTR, bstrFilename, GUID.Ptr, pguidFormat)
    RegisterEventCallbackProgram(lFlags, bstrDeviceID, pEventGUID, bstrCommandline, bstrName, bstrDescription, bstrIcon)
      => ComCall(8, this.p, Int32, lFlags, BSTR, bstrDeviceID, GUID.Ptr, pEventGUID, BSTR, bstrCommandline, BSTR, bstrName, BSTR, bstrDescription, BSTR, bstrIcon)
    RegisterEventCallbackInterface(lFlags, bstrDeviceID, pEventGUID, pIWiaEventCallback, pEventObject)
      => ComCall(9, this.p, Int32, lFlags, BSTR, bstrDeviceID, GUID.Ptr, pEventGUID, IWiaEventCallback, pIWiaEventCallback, IUnknown.Ptr, pEventObject)
    RegisterEventCallbackCLSID(lFlags, bstrDeviceID, pEventGUID, pClsID, bstrName, bstrDescription, bstrIcon)
      => ComCall(10, this.p, Int32, lFlags, BSTR, bstrDeviceID, GUID.Ptr, pEventGUID, GUID.Ptr, pClsID, BSTR, bstrName, BSTR, bstrDescription, BSTR, bstrIcon)
    AddDeviceDlg(hwndParent, lFlags)
      => ComCall(11, this.p, HWND, hwndParent, Int32, lFlags)
}
struct IEnumWIA_DEV_INFO extends IUnknown {
    static IID := "{5E38B83C-8CF1-11D1-BF92-0060081ED811}"
    Next(celt, rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, IWiaPropertyStorage.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppIEnum)
      => ComCall(6, this.p, IEnumWIA_DEV_INFO.Ptr, ppIEnum)
    GetCount(celt)
      => ComCall(7, this.p, UInt32.Ptr, celt)
}
struct IWiaEventCallback extends IUnknown {
    static IID := "{AE6287B0-0084-11D2-973B-00A0C9068F2E}"
    ImageEventCallback(pEventGUID, bstrEventDescription, bstrDeviceID, bstrDeviceDescription, dwDeviceType, bstrFullItemName, pulEventType, ulReserved)
      => ComCall(3, this.p, GUID.Ptr, pEventGUID, BSTR, bstrEventDescription, BSTR, bstrDeviceID, BSTR, bstrDeviceDescription, UInt32, dwDeviceType, BSTR, bstrFullItemName, UInt32.Ptr, pulEventType, UInt32, ulReserved)
}
struct WIA_DATA_CALLBACK_HEADER {
    lSize : Int32
    guidFormatID : GUID
    lBufferSize : Int32
    lPageCount : Int32
}
struct IWiaDataCallback extends IUnknown {
    static IID := "{A558A866-A5B0-11D2-A08F-00C04F72DC3C}"
    BandedDataCallback(lMessage, lStatus, lPercentComplete, lOffset, lLength, lReserved, lResLength, pbBuffer)
      => ComCall(3, this.p, Int32, lMessage, Int32, lStatus, Int32, lPercentComplete, Int32, lOffset, Int32, lLength, Int32, lReserved, Int32, lResLength, UInt8.Ptr, pbBuffer)
}
struct WIA_DATA_TRANSFER_INFO {
    ulSize : UInt32
    ulSection : UInt32
    ulBufferSize : UInt32
    bDoubleBuffer : BOOL
    ulReserved1 : UInt32
    ulReserved2 : UInt32
    ulReserved3 : UInt32
}
struct WIA_EXTENDED_TRANSFER_INFO {
    ulSize : UInt32
    ulMinBufferSize : UInt32
    ulOptimalBufferSize : UInt32
    ulMaxBufferSize : UInt32
    ulNumBuffers : UInt32
}
struct IWiaDataTransfer extends IUnknown {
    static IID := "{A6CEF998-A5B0-11D2-A08F-00C04F72DC3C}"
    idtGetData(pMedium, pIWiaDataCallback)
      => ComCall(3, this.p, STGMEDIUM.Ptr, pMedium, IWiaDataCallback, pIWiaDataCallback)
    idtGetBandedData(pWiaDataTransInfo, pIWiaDataCallback)
      => ComCall(4, this.p, WIA_DATA_TRANSFER_INFO.Ptr, pWiaDataTransInfo, IWiaDataCallback, pIWiaDataCallback)
    idtQueryGetData(pfe?)
      => ComCall(5, this.p, WIA_FORMAT_INFO.Ptr, pfe?)
    idtEnumWIA_FORMAT_INFO(ppEnum)
      => ComCall(6, this.p, IEnumWIA_FORMAT_INFO.Ptr, ppEnum)
    idtGetExtendedTransferInfo(pExtendedTransferInfo)
      => ComCall(7, this.p, WIA_EXTENDED_TRANSFER_INFO.Ptr, pExtendedTransferInfo)
}
struct IWiaItem extends IUnknown {
    static IID := "{4DB1AD10-3391-11D2-9A33-00C04FA36145}"
    GetItemType(pItemType)
      => ComCall(3, this.p, Int32.Ptr, pItemType)
    AnalyzeItem(lFlags)
      => ComCall(4, this.p, Int32, lFlags)
    EnumChildItems(ppIEnumWiaItem)
      => ComCall(5, this.p, IEnumWiaItem.Ptr, ppIEnumWiaItem)
    DeleteItem(lFlags)
      => ComCall(6, this.p, Int32, lFlags)
    CreateChildItem(lFlags, bstrItemName, bstrFullItemName, ppIWiaItem)
      => ComCall(7, this.p, Int32, lFlags, BSTR, bstrItemName, BSTR, bstrFullItemName, IWiaItem.Ptr, ppIWiaItem)
    EnumRegisterEventInfo(lFlags, pEventGUID, ppIEnum)
      => ComCall(8, this.p, Int32, lFlags, GUID.Ptr, pEventGUID, IEnumWIA_DEV_CAPS.Ptr, ppIEnum)
    FindItemByName(lFlags, bstrFullItemName, ppIWiaItem)
      => ComCall(9, this.p, Int32, lFlags, BSTR, bstrFullItemName, IWiaItem.Ptr, ppIWiaItem)
    DeviceDlg(hwndParent, lFlags, lIntent, plItemCount, ppIWiaItem)
      => ComCall(10, this.p, HWND, hwndParent, Int32, lFlags, Int32, lIntent, Int32.Ptr, plItemCount, IWiaItem.Ptr.Ptr, ppIWiaItem)
    DeviceCommand(lFlags, pCmdGUID, pIWiaItem)
      => ComCall(11, this.p, Int32, lFlags, GUID.Ptr, pCmdGUID, IWiaItem.Ptr, pIWiaItem)
    GetRootItem(ppIWiaItem)
      => ComCall(12, this.p, IWiaItem.Ptr, ppIWiaItem)
    EnumDeviceCapabilities(lFlags, ppIEnumWIA_DEV_CAPS)
      => ComCall(13, this.p, Int32, lFlags, IEnumWIA_DEV_CAPS.Ptr, ppIEnumWIA_DEV_CAPS)
    DumpItemData(bstrData)
      => ComCall(14, this.p, BSTR.Ptr, bstrData)
    DumpDrvItemData(bstrData)
      => ComCall(15, this.p, BSTR.Ptr, bstrData)
    DumpTreeItemData(bstrData)
      => ComCall(16, this.p, BSTR.Ptr, bstrData)
    Diagnostic(pBuffer)
      => ComCall(17, this.p, UInt32, pBuffer.Length, UInt8.Ptr, pBuffer)
}
struct IWiaPropertyStorage extends IUnknown {
    static IID := "{98B5E8A0-29CC-491A-AAC0-E6DB4FDCCEB6}"
    ReadMultiple(rgpspec, rgpropvar)
      => ComCall(3, this.p, UInt32, rgpropvar.Length, PROPSPEC.Ptr, rgpspec, PROPVARIANT.Ptr, rgpropvar)
    WriteMultiple(cpspec, rgpspec, rgpropvar, propidNameFirst)
      => ComCall(4, this.p, UInt32, cpspec, PROPSPEC.Ptr, rgpspec, PROPVARIANT.Ptr, rgpropvar, UInt32, propidNameFirst)
    DeleteMultiple(rgpspec)
      => ComCall(5, this.p, UInt32, rgpspec.Length, PROPSPEC.Ptr, rgpspec)
    ReadPropertyNames(rgpropid, rglpwstrName)
      => ComCall(6, this.p, UInt32, rglpwstrName.Length, UInt32.Ptr, rgpropid, PWSTR.Ptr, rglpwstrName)
    WritePropertyNames(rgpropid, rglpwstrName)
      => ComCall(7, this.p, UInt32, rglpwstrName.Length, UInt32.Ptr, rgpropid, PWSTR.Ptr, rglpwstrName)
    DeletePropertyNames(rgpropid)
      => ComCall(8, this.p, UInt32, rgpropid.Length, UInt32.Ptr, rgpropid)
    Commit(grfCommitFlags)
      => ComCall(9, this.p, UInt32, grfCommitFlags)
    Revert()
      => ComCall(10, this.p)
    Enum(ppenum)
      => ComCall(11, this.p, IEnumSTATPROPSTG.Ptr, ppenum)
    SetTimes(pctime, patime, pmtime)
      => ComCall(12, this.p, FILETIME.Ptr, pctime, FILETIME.Ptr, patime, FILETIME.Ptr, pmtime)
    SetClass(clsid)
      => ComCall(13, this.p, GUID.Ptr, clsid)
    Stat(pstatpsstg)
      => ComCall(14, this.p, STATPROPSETSTG.Ptr, pstatpsstg)
    GetPropertyAttributes(rgpspec, rgflags, rgpropvar)
      => ComCall(15, this.p, UInt32, rgpropvar.Length, PROPSPEC.Ptr, rgpspec, UInt32.Ptr, rgflags, PROPVARIANT.Ptr, rgpropvar)
    GetCount(pulNumProps)
      => ComCall(16, this.p, UInt32.Ptr, pulNumProps)
    GetPropertyStream(pCompatibilityId, ppIStream)
      => ComCall(17, this.p, GUID.Ptr, pCompatibilityId, IStream.Ptr, ppIStream)
    SetPropertyStream(pCompatibilityId, pIStream)
      => ComCall(18, this.p, GUID.Ptr, pCompatibilityId, IStream, pIStream)
}
struct IEnumWiaItem extends IUnknown {
    static IID := "{5E8383FC-3391-11D2-9A33-00C04FA36145}"
    Next(celt, ppIWiaItem, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, IWiaItem.Ptr, ppIWiaItem, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppIEnum)
      => ComCall(6, this.p, IEnumWiaItem.Ptr, ppIEnum)
    GetCount(celt)
      => ComCall(7, this.p, UInt32.Ptr, celt)
}
struct WIA_DEV_CAP {
    guid : GUID
    ulFlags : UInt32
    bstrName : BSTR
    bstrDescription : BSTR
    bstrIcon : BSTR
    bstrCommandline : BSTR
}
struct IEnumWIA_DEV_CAPS extends IUnknown {
    static IID := "{1FCC4287-ACA6-11D2-A093-00C04F72DC3C}"
    Next(celt, rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, WIA_DEV_CAP.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppIEnum)
      => ComCall(6, this.p, IEnumWIA_DEV_CAPS.Ptr, ppIEnum)
    GetCount(pcelt)
      => ComCall(7, this.p, UInt32.Ptr, pcelt)
}
struct IEnumWIA_FORMAT_INFO extends IUnknown {
    static IID := "{81BEFC5B-656D-44F1-B24C-D41D51B4DC81}"
    Next(celt, rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, WIA_FORMAT_INFO.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppIEnum)
      => ComCall(6, this.p, IEnumWIA_FORMAT_INFO.Ptr, ppIEnum)
    GetCount(pcelt)
      => ComCall(7, this.p, UInt32.Ptr, pcelt)
}
struct IWiaLog extends IUnknown {
    static IID := "{A00C10B6-82A1-452F-8B6C-86062AAD6890}"
    InitializeLog(hInstance)
      => ComCall(3, this.p, Int32, hInstance)
    hResult(hResult1)
      => ComCall(4, this.p, HRESULT, hResult1)
    Log(lFlags, lResID, lDetail, bstrText)
      => ComCall(5, this.p, Int32, lFlags, Int32, lResID, Int32, lDetail, BSTR, bstrText)
}
struct IWiaLogEx extends IUnknown {
    static IID := "{AF1F22AC-7A40-4787-B421-AEB47A1FBD0B}"
    InitializeLogEx(hInstance)
      => ComCall(3, this.p, UInt8.Ptr, hInstance)
    hResult(hResult1)
      => ComCall(4, this.p, HRESULT, hResult1)
    Log(lFlags, lResID, lDetail, bstrText)
      => ComCall(5, this.p, Int32, lFlags, Int32, lResID, Int32, lDetail, BSTR, bstrText)
    hResultEx(lMethodId, hResult1)
      => ComCall(6, this.p, Int32, lMethodId, HRESULT, hResult1)
    LogEx(lMethodId, lFlags, lResID, lDetail, bstrText)
      => ComCall(7, this.p, Int32, lMethodId, Int32, lFlags, Int32, lResID, Int32, lDetail, BSTR, bstrText)
}
struct IWiaNotifyDevMgr extends IUnknown {
    static IID := "{70681EA0-E7BF-4291-9FB1-4E8813A3F78E}"
    NewDeviceArrival()
      => ComCall(3, this.p)
}
struct IWiaItemExtras extends IUnknown {
    static IID := "{6291EF2C-36EF-4532-876A-8E132593778D}"
    GetExtendedErrorInfo(bstrErrorText)
      => ComCall(3, this.p, BSTR.Ptr, bstrErrorText)
    Escape(dwEscapeCode, lpInData, pOutData, pdwActualDataSize)
      => ComCall(4, this.p, UInt32, dwEscapeCode, UInt8.Ptr, lpInData, UInt32, lpInData.Length, UInt8.Ptr, pOutData, UInt32, pOutData.Length, UInt32.Ptr, pdwActualDataSize)
    CancelPendingIO()
      => ComCall(5, this.p)
}
struct IWiaAppErrorHandler extends IUnknown {
    static IID := "{6C16186C-D0A6-400C-80F4-D26986A0E734}"
    GetWindow(phwnd)
      => ComCall(3, this.p, HWND.Ptr, phwnd)
    ReportStatus(lFlags, pWiaItem2?, hrStatus, lPercentComplete)
      => ComCall(4, this.p, Int32, lFlags, IWiaItem2, pWiaItem2?, HRESULT, hrStatus, Int32, lPercentComplete)
}
struct IWiaErrorHandler extends IUnknown {
    static IID := "{0E4A51B1-BC1F-443D-A835-72E890759EF3}"
    ReportStatus(lFlags, hwndParent, pWiaItem2?, hrStatus, lPercentComplete)
      => ComCall(3, this.p, Int32, lFlags, HWND, hwndParent, IWiaItem2, pWiaItem2?, HRESULT, hrStatus, Int32, lPercentComplete)
    GetStatusDescription(lFlags, pWiaItem2?, hrStatus, pbstrDescription)
      => ComCall(4, this.p, Int32, lFlags, IWiaItem2, pWiaItem2?, HRESULT, hrStatus, BSTR.Ptr, pbstrDescription)
}
struct IWiaTransfer extends IUnknown {
    static IID := "{C39D6942-2F4E-4D04-92FE-4EF4D3A1DE5A}"
    Download(lFlags, pIWiaTransferCallback)
      => ComCall(3, this.p, Int32, lFlags, IWiaTransferCallback, pIWiaTransferCallback)
    Upload(lFlags, pSource, pIWiaTransferCallback)
      => ComCall(4, this.p, Int32, lFlags, IStream, pSource, IWiaTransferCallback, pIWiaTransferCallback)
    Cancel()
      => ComCall(5, this.p)
    EnumWIA_FORMAT_INFO(ppEnum)
      => ComCall(6, this.p, IEnumWIA_FORMAT_INFO.Ptr, ppEnum)
}
struct WiaTransferParams {
    lMessage : Int32
    lPercentComplete : Int32
    ulTransferredBytes : Int64
    hrErrorStatus : HRESULT
}
struct IWiaTransferCallback extends IUnknown {
    static IID := "{27D4EAAF-28A6-4CA5-9AAB-E678168B9527}"
    TransferCallback(lFlags, pWiaTransferParams)
      => ComCall(3, this.p, Int32, lFlags, WiaTransferParams.Ptr, pWiaTransferParams)
    GetNextStream(lFlags, bstrItemName, bstrFullItemName, ppDestination)
      => ComCall(4, this.p, Int32, lFlags, BSTR, bstrItemName, BSTR, bstrFullItemName, IStream.Ptr, ppDestination)
}
struct IWiaSegmentationFilter extends IUnknown {
    static IID := "{EC46A697-AC04-4447-8F65-FF63D5154B21}"
    DetectRegions(lFlags, pInputStream?, pWiaItem2?)
      => ComCall(3, this.p, Int32, lFlags, IStream, pInputStream?, IWiaItem2, pWiaItem2?)
}
struct IWiaImageFilter extends IUnknown {
    static IID := "{A8A79FFA-450B-41F1-8F87-849CCD94EBF6}"
    InitializeFilter(pWiaItem2?, pWiaTransferCallback?)
      => ComCall(3, this.p, IWiaItem2, pWiaItem2?, IWiaTransferCallback, pWiaTransferCallback?)
    SetNewCallback(pWiaTransferCallback?)
      => ComCall(4, this.p, IWiaTransferCallback, pWiaTransferCallback?)
    FilterPreviewImage(lFlags, pWiaChildItem2?, InputImageExtents, pInputStream?)
      => ComCall(5, this.p, Int32, lFlags, IWiaItem2, pWiaChildItem2?, RECT, InputImageExtents, IStream, pInputStream?)
    ApplyProperties(pWiaPropertyStorage?)
      => ComCall(6, this.p, IWiaPropertyStorage, pWiaPropertyStorage?)
}
struct IWiaPreview extends IUnknown {
    static IID := "{95C2B4FD-33F2-4D86-AD40-9431F0DF08F7}"
    GetNewPreview(lFlags, pWiaItem2?, pWiaTransferCallback?)
      => ComCall(3, this.p, Int32, lFlags, IWiaItem2, pWiaItem2?, IWiaTransferCallback, pWiaTransferCallback?)
    UpdatePreview(lFlags, pChildWiaItem2?, pWiaTransferCallback?)
      => ComCall(4, this.p, Int32, lFlags, IWiaItem2, pChildWiaItem2?, IWiaTransferCallback, pWiaTransferCallback?)
    DetectRegions(lFlags)
      => ComCall(5, this.p, Int32, lFlags)
    Clear()
      => ComCall(6, this.p)
}
struct IEnumWiaItem2 extends IUnknown {
    static IID := "{59970AF4-CD0D-44D9-AB24-52295630E582}"
    Next(cElt, ppIWiaItem2, pcEltFetched)
      => ComCall(3, this.p, UInt32, cElt, IWiaItem2.Ptr, ppIWiaItem2, UInt32.Ptr, pcEltFetched)
    Skip(cElt)
      => ComCall(4, this.p, UInt32, cElt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppIEnum)
      => ComCall(6, this.p, IEnumWiaItem2.Ptr, ppIEnum)
    GetCount(cElt)
      => ComCall(7, this.p, UInt32.Ptr, cElt)
}
struct IWiaItem2 extends IUnknown {
    static IID := "{6CBA0075-1287-407D-9B77-CF0E030435CC}"
    CreateChildItem(lItemFlags, lCreationFlags, bstrItemName, ppIWiaItem2)
      => ComCall(3, this.p, Int32, lItemFlags, Int32, lCreationFlags, BSTR, bstrItemName, IWiaItem2.Ptr, ppIWiaItem2)
    DeleteItem(lFlags)
      => ComCall(4, this.p, Int32, lFlags)
    EnumChildItems(pCategoryGUID?, ppIEnumWiaItem2)
      => ComCall(5, this.p, GUID.Ptr, pCategoryGUID?, IEnumWiaItem2.Ptr, ppIEnumWiaItem2)
    FindItemByName(lFlags, bstrFullItemName, ppIWiaItem2)
      => ComCall(6, this.p, Int32, lFlags, BSTR, bstrFullItemName, IWiaItem2.Ptr, ppIWiaItem2)
    GetItemCategory(pItemCategoryGUID)
      => ComCall(7, this.p, GUID.Ptr, pItemCategoryGUID)
    GetItemType(pItemType)
      => ComCall(8, this.p, Int32.Ptr, pItemType)
    DeviceDlg(lFlags, hwndParent, bstrFolderName, bstrFilename, plNumFiles, ppbstrFilePaths, ppItem?)
      => ComCall(9, this.p, Int32, lFlags, HWND, hwndParent, BSTR, bstrFolderName, BSTR, bstrFilename, Int32.Ptr, plNumFiles, BSTR.Ptr.Ptr, ppbstrFilePaths, IWiaItem2.Ptr, ppItem?)
    DeviceCommand(lFlags, pCmdGUID, ppIWiaItem2)
      => ComCall(10, this.p, Int32, lFlags, GUID.Ptr, pCmdGUID, IWiaItem2.Ptr, ppIWiaItem2)
    EnumDeviceCapabilities(lFlags, ppIEnumWIA_DEV_CAPS)
      => ComCall(11, this.p, Int32, lFlags, IEnumWIA_DEV_CAPS.Ptr, ppIEnumWIA_DEV_CAPS)
    CheckExtension(lFlags, bstrName, riidExtensionInterface, pbExtensionExists)
      => ComCall(12, this.p, Int32, lFlags, BSTR, bstrName, GUID.Ptr, riidExtensionInterface, BOOL.Ptr, pbExtensionExists)
    GetExtension(lFlags, bstrName, riidExtensionInterface, ppOut)
      => ComCall(13, this.p, Int32, lFlags, BSTR, bstrName, GUID.Ptr, riidExtensionInterface, Struct.Ptr.Ptr, ppOut)
    GetParentItem(ppIWiaItem2)
      => ComCall(14, this.p, IWiaItem2.Ptr, ppIWiaItem2)
    GetRootItem(ppIWiaItem2)
      => ComCall(15, this.p, IWiaItem2.Ptr, ppIWiaItem2)
    GetPreviewComponent(lFlags, ppWiaPreview)
      => ComCall(16, this.p, Int32, lFlags, IWiaPreview.Ptr, ppWiaPreview)
    EnumRegisterEventInfo(lFlags, pEventGUID, ppIEnum)
      => ComCall(17, this.p, Int32, lFlags, GUID.Ptr, pEventGUID, IEnumWIA_DEV_CAPS.Ptr, ppIEnum)
    Diagnostic(pBuffer)
      => ComCall(18, this.p, UInt32, pBuffer.Length, UInt8.Ptr, pBuffer)
}
struct IWiaDevMgr2 extends IUnknown {
    static IID := "{79C07CF1-CBDD-41EE-8EC3-F00080CADA7A}"
    EnumDeviceInfo(lFlags, ppIEnum)
      => ComCall(3, this.p, Int32, lFlags, IEnumWIA_DEV_INFO.Ptr, ppIEnum)
    CreateDevice(lFlags, bstrDeviceID, ppWiaItem2Root)
      => ComCall(4, this.p, Int32, lFlags, BSTR, bstrDeviceID, IWiaItem2.Ptr, ppWiaItem2Root)
    SelectDeviceDlg(hwndParent, lDeviceType, lFlags, pbstrDeviceID, ppItemRoot)
      => ComCall(5, this.p, HWND, hwndParent, Int32, lDeviceType, Int32, lFlags, BSTR.Ptr, pbstrDeviceID, IWiaItem2.Ptr, ppItemRoot)
    SelectDeviceDlgID(hwndParent, lDeviceType, lFlags, pbstrDeviceID)
      => ComCall(6, this.p, HWND, hwndParent, Int32, lDeviceType, Int32, lFlags, BSTR.Ptr, pbstrDeviceID)
    RegisterEventCallbackInterface(lFlags, bstrDeviceID, pEventGUID, pIWiaEventCallback, pEventObject)
      => ComCall(7, this.p, Int32, lFlags, BSTR, bstrDeviceID, GUID.Ptr, pEventGUID, IWiaEventCallback, pIWiaEventCallback, IUnknown.Ptr, pEventObject)
    RegisterEventCallbackProgram(lFlags, bstrDeviceID, pEventGUID, bstrFullAppName, bstrCommandLineArg, bstrName, bstrDescription, bstrIcon)
      => ComCall(8, this.p, Int32, lFlags, BSTR, bstrDeviceID, GUID.Ptr, pEventGUID, BSTR, bstrFullAppName, BSTR, bstrCommandLineArg, BSTR, bstrName, BSTR, bstrDescription, BSTR, bstrIcon)
    RegisterEventCallbackCLSID(lFlags, bstrDeviceID, pEventGUID, pClsID, bstrName, bstrDescription, bstrIcon)
      => ComCall(9, this.p, Int32, lFlags, BSTR, bstrDeviceID, GUID.Ptr, pEventGUID, GUID.Ptr, pClsID, BSTR, bstrName, BSTR, bstrDescription, BSTR, bstrIcon)
    GetImageDlg(lFlags, bstrDeviceID, hwndParent, bstrFolderName, bstrFilename, plNumFiles, ppbstrFilePaths, ppItem)
      => ComCall(10, this.p, Int32, lFlags, BSTR, bstrDeviceID, HWND, hwndParent, BSTR, bstrFolderName, BSTR, bstrFilename, Int32.Ptr, plNumFiles, BSTR.Ptr.Ptr, ppbstrFilePaths, IWiaItem2.Ptr, ppItem)
}
struct MINIDRV_TRANSFER_CONTEXT {
    lSize : Int32
    lWidthInPixels : Int32
    lLines : Int32
    lDepth : Int32
    lXRes : Int32
    lYRes : Int32
    lCompression : Int32
    guidFormatID : GUID
    tymed : Int32
    hFile : IntPtr
    cbOffset : Int32
    lBufferSize : Int32
    lActiveBuffer : Int32
    lNumBuffers : Int32
    pBaseBuffer : UInt8.Ptr
    pTransferBuffer : UInt8.Ptr
    bTransferDataCB : BOOL
    bClassDrvAllocBuf : BOOL
    lClientAddress : IntPtr
    pIWiaMiniDrvCallBack : IWiaMiniDrvCallBack
    lImageSize : Int32
    lHeaderSize : Int32
    lItemSize : Int32
    cbWidthInBytes : Int32
    lPage : Int32
    lCurIfdOffset : Int32
    lPrevIfdOffset : Int32
}
struct WIA_DEV_CAP_DRV {
    guid : GUID.Ptr
    ulFlags : UInt32
    wszName : PWSTR
    wszDescription : PWSTR
    wszIcon : PWSTR
}
struct IWiaMiniDrv extends IUnknown {
    static IID := "{D8CDEE14-3C6C-11D2-9A35-00C04FA36145}"
    drvInitializeWia(__MIDL__IWiaMiniDrv0000, __MIDL__IWiaMiniDrv0001, __MIDL__IWiaMiniDrv0002, __MIDL__IWiaMiniDrv0003, __MIDL__IWiaMiniDrv0004?, __MIDL__IWiaMiniDrv0005?, __MIDL__IWiaMiniDrv0006, __MIDL__IWiaMiniDrv0007, __MIDL__IWiaMiniDrv0008)
      => ComCall(3, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0000, Int32, __MIDL__IWiaMiniDrv0001, BSTR, __MIDL__IWiaMiniDrv0002, BSTR, __MIDL__IWiaMiniDrv0003, IUnknown, __MIDL__IWiaMiniDrv0004?, IUnknown, __MIDL__IWiaMiniDrv0005?, IWiaDrvItem.Ptr, __MIDL__IWiaMiniDrv0006, IUnknown.Ptr, __MIDL__IWiaMiniDrv0007, Int32.Ptr, __MIDL__IWiaMiniDrv0008)
    drvAcquireItemData(__MIDL__IWiaMiniDrv0009, __MIDL__IWiaMiniDrv0010, __MIDL__IWiaMiniDrv0011, __MIDL__IWiaMiniDrv0012)
      => ComCall(4, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0009, Int32, __MIDL__IWiaMiniDrv0010, MINIDRV_TRANSFER_CONTEXT.Ptr, __MIDL__IWiaMiniDrv0011, Int32.Ptr, __MIDL__IWiaMiniDrv0012)
    drvInitItemProperties(__MIDL__IWiaMiniDrv0013, __MIDL__IWiaMiniDrv0014, __MIDL__IWiaMiniDrv0015)
      => ComCall(5, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0013, Int32, __MIDL__IWiaMiniDrv0014, Int32.Ptr, __MIDL__IWiaMiniDrv0015)
    drvValidateItemProperties(__MIDL__IWiaMiniDrv0016, __MIDL__IWiaMiniDrv0017, __MIDL__IWiaMiniDrv0018, __MIDL__IWiaMiniDrv0019, __MIDL__IWiaMiniDrv0020)
      => ComCall(6, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0016, Int32, __MIDL__IWiaMiniDrv0017, UInt32, __MIDL__IWiaMiniDrv0018, PROPSPEC.Ptr, __MIDL__IWiaMiniDrv0019, Int32.Ptr, __MIDL__IWiaMiniDrv0020)
    drvWriteItemProperties(__MIDL__IWiaMiniDrv0021, __MIDL__IWiaMiniDrv0022, __MIDL__IWiaMiniDrv0023, __MIDL__IWiaMiniDrv0024)
      => ComCall(7, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0021, Int32, __MIDL__IWiaMiniDrv0022, MINIDRV_TRANSFER_CONTEXT.Ptr, __MIDL__IWiaMiniDrv0023, Int32.Ptr, __MIDL__IWiaMiniDrv0024)
    drvReadItemProperties(__MIDL__IWiaMiniDrv0025, __MIDL__IWiaMiniDrv0026, __MIDL__IWiaMiniDrv0027, __MIDL__IWiaMiniDrv0028, __MIDL__IWiaMiniDrv0029)
      => ComCall(8, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0025, Int32, __MIDL__IWiaMiniDrv0026, UInt32, __MIDL__IWiaMiniDrv0027, PROPSPEC.Ptr, __MIDL__IWiaMiniDrv0028, Int32.Ptr, __MIDL__IWiaMiniDrv0029)
    drvLockWiaDevice(__MIDL__IWiaMiniDrv0030, __MIDL__IWiaMiniDrv0031, __MIDL__IWiaMiniDrv0032)
      => ComCall(9, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0030, Int32, __MIDL__IWiaMiniDrv0031, Int32.Ptr, __MIDL__IWiaMiniDrv0032)
    drvUnLockWiaDevice(__MIDL__IWiaMiniDrv0033, __MIDL__IWiaMiniDrv0034, __MIDL__IWiaMiniDrv0035)
      => ComCall(10, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0033, Int32, __MIDL__IWiaMiniDrv0034, Int32.Ptr, __MIDL__IWiaMiniDrv0035)
    drvAnalyzeItem(__MIDL__IWiaMiniDrv0036, __MIDL__IWiaMiniDrv0037, __MIDL__IWiaMiniDrv0038)
      => ComCall(11, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0036, Int32, __MIDL__IWiaMiniDrv0037, Int32.Ptr, __MIDL__IWiaMiniDrv0038)
    drvGetDeviceErrorStr(__MIDL__IWiaMiniDrv0039, __MIDL__IWiaMiniDrv0040, __MIDL__IWiaMiniDrv0041, __MIDL__IWiaMiniDrv0042)
      => ComCall(12, this.p, Int32, __MIDL__IWiaMiniDrv0039, Int32, __MIDL__IWiaMiniDrv0040, PWSTR.Ptr, __MIDL__IWiaMiniDrv0041, Int32.Ptr, __MIDL__IWiaMiniDrv0042)
    drvDeviceCommand(__MIDL__IWiaMiniDrv0043, __MIDL__IWiaMiniDrv0044, __MIDL__IWiaMiniDrv0045, __MIDL__IWiaMiniDrv0046, __MIDL__IWiaMiniDrv0047)
      => ComCall(13, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0043, Int32, __MIDL__IWiaMiniDrv0044, GUID.Ptr, __MIDL__IWiaMiniDrv0045, IWiaDrvItem.Ptr, __MIDL__IWiaMiniDrv0046, Int32.Ptr, __MIDL__IWiaMiniDrv0047)
    drvGetCapabilities(__MIDL__IWiaMiniDrv0048, __MIDL__IWiaMiniDrv0049, __MIDL__IWiaMiniDrv0050, __MIDL__IWiaMiniDrv0051, __MIDL__IWiaMiniDrv0052)
      => ComCall(14, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0048, Int32, __MIDL__IWiaMiniDrv0049, Int32.Ptr, __MIDL__IWiaMiniDrv0050, WIA_DEV_CAP_DRV.Ptr.Ptr, __MIDL__IWiaMiniDrv0051, Int32.Ptr, __MIDL__IWiaMiniDrv0052)
    drvDeleteItem(__MIDL__IWiaMiniDrv0053, __MIDL__IWiaMiniDrv0054, __MIDL__IWiaMiniDrv0055)
      => ComCall(15, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0053, Int32, __MIDL__IWiaMiniDrv0054, Int32.Ptr, __MIDL__IWiaMiniDrv0055)
    drvFreeDrvItemContext(__MIDL__IWiaMiniDrv0056, __MIDL__IWiaMiniDrv0057, __MIDL__IWiaMiniDrv0058)
      => ComCall(16, this.p, Int32, __MIDL__IWiaMiniDrv0056, UInt8.Ptr, __MIDL__IWiaMiniDrv0057, Int32.Ptr, __MIDL__IWiaMiniDrv0058)
    drvGetWiaFormatInfo(__MIDL__IWiaMiniDrv0059, __MIDL__IWiaMiniDrv0060, __MIDL__IWiaMiniDrv0061, __MIDL__IWiaMiniDrv0062, __MIDL__IWiaMiniDrv0063)
      => ComCall(17, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0059, Int32, __MIDL__IWiaMiniDrv0060, Int32.Ptr, __MIDL__IWiaMiniDrv0061, WIA_FORMAT_INFO.Ptr.Ptr, __MIDL__IWiaMiniDrv0062, Int32.Ptr, __MIDL__IWiaMiniDrv0063)
    drvNotifyPnpEvent(pEventGUID, bstrDeviceID, ulReserved)
      => ComCall(18, this.p, GUID.Ptr, pEventGUID, BSTR, bstrDeviceID, UInt32, ulReserved)
    drvUnInitializeWia(__MIDL__IWiaMiniDrv0064)
      => ComCall(19, this.p, UInt8.Ptr, __MIDL__IWiaMiniDrv0064)
}
struct IWiaMiniDrvCallBack extends IUnknown {
    static IID := "{33A57D5A-3DE8-11D2-9A36-00C04FA36145}"
    MiniDrvCallback(lReason, lStatus, lPercentComplete, lOffset, lLength, pTranCtx, lReserved)
      => ComCall(3, this.p, Int32, lReason, Int32, lStatus, Int32, lPercentComplete, Int32, lOffset, Int32, lLength, MINIDRV_TRANSFER_CONTEXT.Ptr, pTranCtx, Int32, lReserved)
}
struct IWiaMiniDrvTransferCallback extends IUnknown {
    static IID := "{A9D2EE89-2CE5-4FF0-8ADB-C961D1D774CA}"
    GetNextStream(lFlags, bstrItemName, bstrFullItemName, ppIStream)
      => ComCall(3, this.p, Int32, lFlags, BSTR, bstrItemName, BSTR, bstrFullItemName, IStream.Ptr, ppIStream)
    SendMessage(lFlags, pWiaTransferParams)
      => ComCall(4, this.p, Int32, lFlags, WiaTransferParams.Ptr, pWiaTransferParams)
}
struct IWiaDrvItem extends IUnknown {
    static IID := "{1F02B5C5-B00C-11D2-A094-00C04F72DC3C}"
    GetItemFlags(__MIDL__IWiaDrvItem0000)
      => ComCall(3, this.p, Int32.Ptr, __MIDL__IWiaDrvItem0000)
    GetDeviceSpecContext(__MIDL__IWiaDrvItem0001)
      => ComCall(4, this.p, UInt8.Ptr.Ptr, __MIDL__IWiaDrvItem0001)
    GetFullItemName(__MIDL__IWiaDrvItem0002)
      => ComCall(5, this.p, BSTR.Ptr, __MIDL__IWiaDrvItem0002)
    GetItemName(__MIDL__IWiaDrvItem0003)
      => ComCall(6, this.p, BSTR.Ptr, __MIDL__IWiaDrvItem0003)
    AddItemToFolder(__MIDL__IWiaDrvItem0004?)
      => ComCall(7, this.p, IWiaDrvItem, __MIDL__IWiaDrvItem0004?)
    UnlinkItemTree(__MIDL__IWiaDrvItem0005)
      => ComCall(8, this.p, Int32, __MIDL__IWiaDrvItem0005)
    RemoveItemFromFolder(__MIDL__IWiaDrvItem0006)
      => ComCall(9, this.p, Int32, __MIDL__IWiaDrvItem0006)
    FindItemByName(__MIDL__IWiaDrvItem0007, __MIDL__IWiaDrvItem0008, __MIDL__IWiaDrvItem0009)
      => ComCall(10, this.p, Int32, __MIDL__IWiaDrvItem0007, BSTR, __MIDL__IWiaDrvItem0008, IWiaDrvItem.Ptr, __MIDL__IWiaDrvItem0009)
    FindChildItemByName(__MIDL__IWiaDrvItem0010, __MIDL__IWiaDrvItem0011)
      => ComCall(11, this.p, BSTR, __MIDL__IWiaDrvItem0010, IWiaDrvItem.Ptr, __MIDL__IWiaDrvItem0011)
    GetParentItem(__MIDL__IWiaDrvItem0012)
      => ComCall(12, this.p, IWiaDrvItem.Ptr, __MIDL__IWiaDrvItem0012)
    GetFirstChildItem(__MIDL__IWiaDrvItem0013)
      => ComCall(13, this.p, IWiaDrvItem.Ptr, __MIDL__IWiaDrvItem0013)
    GetNextSiblingItem(__MIDL__IWiaDrvItem0014)
      => ComCall(14, this.p, IWiaDrvItem.Ptr, __MIDL__IWiaDrvItem0014)
    DumpItemData(__MIDL__IWiaDrvItem0015)
      => ComCall(15, this.p, BSTR.Ptr, __MIDL__IWiaDrvItem0015)
}
struct WIA_PROPERTY_INFO {
    lAccessFlags : UInt32
    vt : VARENUM
    ValidVal : this._ValidVal_e__Union
    struct _ValidVal_e__Union {
        union {
            Range : this._Range_e__Struct
            RangeFloat : this._RangeFloat_e__Struct
            List : this._List_e__Struct
            ListFloat : this._ListFloat_e__Struct
            ListGuid : this._ListGuid_e__Struct
            ListBStr : this._ListBStr_e__Struct
            Flag : this._Flag_e__Struct
            None : this._None_e__Struct
        }
        struct _Range_e__Struct {
            Min : Int32
            Nom : Int32
            Max : Int32
            Inc : Int32
        }
        struct _RangeFloat_e__Struct {
            Min : Float64
            Nom : Float64
            Max : Float64
            Inc : Float64
        }
        struct _List_e__Struct {
            cNumList : Int32
            Nom : Int32
            pList : UInt8.Ptr
        }
        struct _ListFloat_e__Struct {
            cNumList : Int32
            Nom : Float64
            pList : UInt8.Ptr
        }
        struct _ListGuid_e__Struct {
            cNumList : Int32
            Nom : GUID
            pList : GUID.Ptr
        }
        struct _ListBStr_e__Struct {
            cNumList : Int32
            Nom : BSTR
            pList : BSTR.Ptr
        }
        struct _Flag_e__Struct {
            Nom : Int32
            ValidBits : Int32
        }
        struct _None_e__Struct {
            Dummy : Int32
        }
    }
}
struct WIA_PROPERTY_CONTEXT {
    cProps : UInt32
    pProps : UInt32.Ptr
    pChanged : BOOL.Ptr
}
struct WIAS_CHANGED_VALUE_INFO {
    bChanged : BOOL
    vt : Int32
    Old : this._Old_e__Union
    Current : this._Current_e__Union
    struct _Old_e__Union {
        union {
            lVal : Int32
            fltVal : Float32
            bstrVal : BSTR
            guidVal : GUID
        }
    }
    struct _Current_e__Union {
        union {
            lVal : Int32
            fltVal : Float32
            bstrVal : BSTR
            guidVal : GUID
        }
    }
}
struct WIAS_DOWN_SAMPLE_INFO {
    ulOriginalWidth : UInt32
    ulOriginalHeight : UInt32
    ulBitsPerPixel : UInt32
    ulXRes : UInt32
    ulYRes : UInt32
    ulDownSampledWidth : UInt32
    ulDownSampledHeight : UInt32
    ulActualSize : UInt32
    ulDestBufSize : UInt32
    ulSrcBufSize : UInt32
    pSrcBuffer : UInt8.Ptr
    pDestBuffer : UInt8.Ptr
}
struct WIAS_ENDORSER_VALUE {
    wszTokenName : PWSTR
    wszValue : PWSTR
}
struct WIAS_ENDORSER_INFO {
    ulPageCount : UInt32
    ulNumEndorserValues : UInt32
    pEndorserValues : WIAS_ENDORSER_VALUE.Ptr
}
struct WIAVIDEO_STATE extends Int32 {
    static WIAVIDEO_NO_VIDEO := 1
    static WIAVIDEO_CREATING_VIDEO := 2
    static WIAVIDEO_VIDEO_CREATED := 3
    static WIAVIDEO_VIDEO_PLAYING := 4
    static WIAVIDEO_VIDEO_PAUSED := 5
    static WIAVIDEO_DESTROYING_VIDEO := 6
}
struct IWiaVideo extends IUnknown {
    static IID := "{D52920AA-DB88-41F0-946C-E00DC0A19CFA}"
    get_PreviewVisible(pbPreviewVisible)
      => ComCall(3, this.p, BOOL.Ptr, pbPreviewVisible)
    put_PreviewVisible(bPreviewVisible)
      => ComCall(4, this.p, BOOL, bPreviewVisible)
    get_ImagesDirectory(pbstrImageDirectory)
      => ComCall(5, this.p, BSTR.Ptr, pbstrImageDirectory)
    put_ImagesDirectory(bstrImageDirectory)
      => ComCall(6, this.p, BSTR, bstrImageDirectory)
    CreateVideoByWiaDevID(bstrWiaDeviceID, hwndParent, bStretchToFitParent, bAutoBeginPlayback)
      => ComCall(7, this.p, BSTR, bstrWiaDeviceID, HWND, hwndParent, BOOL, bStretchToFitParent, BOOL, bAutoBeginPlayback)
    CreateVideoByDevNum(uiDeviceNumber, hwndParent, bStretchToFitParent, bAutoBeginPlayback)
      => ComCall(8, this.p, UInt32, uiDeviceNumber, HWND, hwndParent, BOOL, bStretchToFitParent, BOOL, bAutoBeginPlayback)
    CreateVideoByName(bstrFriendlyName, hwndParent, bStretchToFitParent, bAutoBeginPlayback)
      => ComCall(9, this.p, BSTR, bstrFriendlyName, HWND, hwndParent, BOOL, bStretchToFitParent, BOOL, bAutoBeginPlayback)
    DestroyVideo()
      => ComCall(10, this.p)
    Play()
      => ComCall(11, this.p)
    Pause()
      => ComCall(12, this.p)
    TakePicture(pbstrNewImageFilename)
      => ComCall(13, this.p, BSTR.Ptr, pbstrNewImageFilename)
    ResizeVideo(bStretchToFitParent)
      => ComCall(14, this.p, BOOL, bStretchToFitParent)
    GetCurrentState(pState)
      => ComCall(15, this.p, WIAVIDEO_STATE.Ptr, pState)
}
struct DEVICEDIALOGDATA2 {
    cbSize : UInt32 := this.Size
    pIWiaItemRoot : IWiaItem2
    dwFlags : UInt32
    hwndParent : HWND
    bstrFolderName : BSTR
    bstrFilename : BSTR
    lNumFiles : Int32
    pbstrFilePaths : BSTR.Ptr
    pWiaItem : IWiaItem2
}
struct IWiaUIExtension2 extends IUnknown {
    static IID := "{305600D7-5088-46D7-9A15-B77B09CDBA7A}"
    DeviceDialog(pDeviceDialogData)
      => ComCall(3, this.p, DEVICEDIALOGDATA2.Ptr, pDeviceDialogData)
    GetDeviceIcon(bstrDeviceId, phIcon, nSize)
      => ComCall(4, this.p, BSTR, bstrDeviceId, HICON.Ptr, phIcon, UInt32, nSize)
}
struct DEVICEDIALOGDATA {
    cbSize : UInt32 := this.Size
    hwndParent : HWND
    pIWiaItemRoot : IWiaItem
    dwFlags : UInt32
    lIntent : Int32
    lItemCount : Int32
    ppWiaItems : IWiaItem.Ptr
}
struct IWiaUIExtension extends IUnknown {
    static IID := "{DA319113-50EE-4C80-B460-57D005D44A2C}"
    DeviceDialog(pDeviceDialogData)
      => ComCall(3, this.p, DEVICEDIALOGDATA.Ptr, pDeviceDialogData)
    GetDeviceIcon(bstrDeviceId, phIcon, nSize)
      => ComCall(4, this.p, BSTR, bstrDeviceId, HICON.Ptr, phIcon, UInt32, nSize)
    GetDeviceBitmapLogo(bstrDeviceId, phBitmap, nMaxWidth, nMaxHeight)
      => ComCall(5, this.p, BSTR, bstrDeviceId, HBITMAP.Ptr, phBitmap, UInt32, nMaxWidth, UInt32, nMaxHeight)
}
struct DeviceDialogFunction extends FunctionPointer {
    static Types := [DEVICEDIALOGDATA.Ptr, HRESULT]
}
struct RANGEVALUE {
    lMin : Int32
    lMax : Int32
    lStep : Int32
}
struct SCANWINDOW {
    xPos : Int32
    yPos : Int32
    xExtent : Int32
    yExtent : Int32
}
struct SCANINFO {
    ADF : Int32
    TPA : Int32
    Endorser : Int32
    OpticalXResolution : Int32
    OpticalYResolution : Int32
    BedWidth : Int32
    BedHeight : Int32
    IntensityRange : RANGEVALUE
    ContrastRange : RANGEVALUE
    SupportedCompressionType : Int32
    SupportedDataTypes : Int32
    WidthPixels : Int32
    WidthBytes : Int32
    Lines : Int32
    DataType : Int32
    PixelBits : Int32
    Intensity : Int32
    Contrast : Int32
    Xresolution : Int32
    Yresolution : Int32
    Window : SCANWINDOW
    DitherPattern : Int32
    Negative : Int32
    Mirror : Int32
    AutoBack : Int32
    ColorDitherPattern : Int32
    ToneMap : Int32
    Compression : Int32
    RawDataFormat : Int32
    RawPixelOrder : Int32
    bNeedDataAlignment : Int32
    DelayBetweenRead : Int32
    MaxBufferSize : Int32
    DeviceIOHandles : HANDLE[16]
    lReserved : Int32[4]
    pMicroDriverContext : Struct.Ptr
}
struct VAL {
    lVal : Int32
    dblVal : Float64
    pGuid : GUID.Ptr
    pScanInfo : SCANINFO.Ptr
    handle : HGLOBAL
    ppButtonNames : UInt16.Ptr.Ptr
    pHandle : HANDLE.Ptr
    lReserved : Int32
    szVal : CHAR[255]
}
struct TWAIN_CAPABILITY {
    lSize : Int32
    lMSG : Int32
    lCapID : Int32
    lConType : Int32
    lRC : Int32
    lCC : Int32
    lDataSize : Int32
    Data : UInt8[1]
}
