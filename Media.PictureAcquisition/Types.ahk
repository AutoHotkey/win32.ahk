#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HRESULT, HWND, PROPERTYKEY, PWSTR, SIZE}
#Import "..\Graphics.Gdi\Types.ahk" {HBITMAP}
#Import "..\System.Com\Types.ahk" {IEnumString, IStream, IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPVARIANT}
#Import "..\UI.Shell.PropertiesSystem\Types.ahk" {IPropertyStore}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {HICON}

struct IPhotoAcquireItem extends IUnknown {
    static IID := "{00F21C97-28BF-4C02-B842-5E4E90139A30}"
    GetItemName(pbstrItemName)
      => ComCall(3, this.p, BSTR.Ptr, pbstrItemName)
    GetThumbnail(sizeThumbnail, phbmpThumbnail)
      => ComCall(4, this.p, SIZE, sizeThumbnail, HBITMAP.Ptr, phbmpThumbnail)
    GetProperty(key, pv)
      => ComCall(5, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, pv)
    SetProperty(key, pv)
      => ComCall(6, this.p, PROPERTYKEY.Ptr, key, PROPVARIANT.Ptr, pv)
    GetStream(ppStream)
      => ComCall(7, this.p, IStream.Ptr, ppStream)
    CanDelete(pfCanDelete)
      => ComCall(8, this.p, BOOL.Ptr, pfCanDelete)
    Delete()
      => ComCall(9, this.p)
    GetSubItemCount(pnCount)
      => ComCall(10, this.p, UInt32.Ptr, pnCount)
    GetSubItemAt(nItemIndex, ppPhotoAcquireItem)
      => ComCall(11, this.p, UInt32, nItemIndex, IPhotoAcquireItem.Ptr, ppPhotoAcquireItem)
}
struct USER_INPUT_STRING_TYPE extends Int32 {
    static USER_INPUT_DEFAULT := 0
    static USER_INPUT_PATH_ELEMENT := 1
}
struct IUserInputString extends IUnknown {
    static IID := "{00F243A1-205B-45BA-AE26-ABBC53AA7A6F}"
    GetSubmitButtonText(pbstrSubmitButtonText)
      => ComCall(3, this.p, BSTR.Ptr, pbstrSubmitButtonText)
    GetPrompt(pbstrPromptTitle)
      => ComCall(4, this.p, BSTR.Ptr, pbstrPromptTitle)
    GetStringId(pbstrStringId)
      => ComCall(5, this.p, BSTR.Ptr, pbstrStringId)
    GetStringType(pnStringType)
      => ComCall(6, this.p, USER_INPUT_STRING_TYPE.Ptr, pnStringType)
    GetTooltipText(pbstrTooltipText)
      => ComCall(7, this.p, BSTR.Ptr, pbstrTooltipText)
    GetMaxLength(pcchMaxLength)
      => ComCall(8, this.p, UInt32.Ptr, pcchMaxLength)
    GetDefault(pbstrDefault)
      => ComCall(9, this.p, BSTR.Ptr, pbstrDefault)
    GetMruCount(pnMruCount)
      => ComCall(10, this.p, UInt32.Ptr, pnMruCount)
    GetMruEntryAt(nIndex, pbstrMruEntry)
      => ComCall(11, this.p, UInt32, nIndex, BSTR.Ptr, pbstrMruEntry)
    GetImage(nSize, phBitmap?, phIcon?)
      => ComCall(12, this.p, UInt32, nSize, HBITMAP.Ptr, phBitmap?, HICON.Ptr, phIcon?)
}
struct ERROR_ADVISE_MESSAGE_TYPE extends Int32 {
    static PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL := 0
    static PHOTOACQUIRE_ERROR_RETRYCANCEL := 1
    static PHOTOACQUIRE_ERROR_YESNO := 2
    static PHOTOACQUIRE_ERROR_OK := 3
}
struct ERROR_ADVISE_RESULT extends Int32 {
    static PHOTOACQUIRE_RESULT_YES := 0
    static PHOTOACQUIRE_RESULT_NO := 1
    static PHOTOACQUIRE_RESULT_OK := 2
    static PHOTOACQUIRE_RESULT_SKIP := 3
    static PHOTOACQUIRE_RESULT_SKIP_ALL := 4
    static PHOTOACQUIRE_RESULT_RETRY := 5
    static PHOTOACQUIRE_RESULT_ABORT := 6
}
struct IPhotoAcquireProgressCB extends IUnknown {
    static IID := "{00F2CE1E-935E-4248-892C-130F32C45CB4}"
    Cancelled(pfCancelled)
      => ComCall(3, this.p, BOOL.Ptr, pfCancelled)
    StartEnumeration(pPhotoAcquireSource?)
      => ComCall(4, this.p, IPhotoAcquireSource, pPhotoAcquireSource?)
    FoundItem(pPhotoAcquireItem?)
      => ComCall(5, this.p, IPhotoAcquireItem, pPhotoAcquireItem?)
    EndEnumeration(hr)
      => ComCall(6, this.p, HRESULT, hr)
    StartTransfer(pPhotoAcquireSource?)
      => ComCall(7, this.p, IPhotoAcquireSource, pPhotoAcquireSource?)
    StartItemTransfer(nItemIndex, pPhotoAcquireItem?)
      => ComCall(8, this.p, UInt32, nItemIndex, IPhotoAcquireItem, pPhotoAcquireItem?)
    DirectoryCreated(pszDirectory)
      => ComCall(9, this.p, "Str", pszDirectory)
    UpdateTransferPercent(fOverall, nPercent)
      => ComCall(10, this.p, BOOL, fOverall, UInt32, nPercent)
    EndItemTransfer(nItemIndex, pPhotoAcquireItem?, hr)
      => ComCall(11, this.p, UInt32, nItemIndex, IPhotoAcquireItem, pPhotoAcquireItem?, HRESULT, hr)
    EndTransfer(hr)
      => ComCall(12, this.p, HRESULT, hr)
    StartDelete(pPhotoAcquireSource?)
      => ComCall(13, this.p, IPhotoAcquireSource, pPhotoAcquireSource?)
    StartItemDelete(nItemIndex, pPhotoAcquireItem?)
      => ComCall(14, this.p, UInt32, nItemIndex, IPhotoAcquireItem, pPhotoAcquireItem?)
    UpdateDeletePercent(nPercent)
      => ComCall(15, this.p, UInt32, nPercent)
    EndItemDelete(nItemIndex, pPhotoAcquireItem?, hr)
      => ComCall(16, this.p, UInt32, nItemIndex, IPhotoAcquireItem, pPhotoAcquireItem?, HRESULT, hr)
    EndDelete(hr)
      => ComCall(17, this.p, HRESULT, hr)
    EndSession(hr)
      => ComCall(18, this.p, HRESULT, hr)
    GetDeleteAfterAcquire(pfDeleteAfterAcquire)
      => ComCall(19, this.p, BOOL.Ptr, pfDeleteAfterAcquire)
    ErrorAdvise(hr, pszErrorMessage, nMessageType, pnErrorAdviseResult)
      => ComCall(20, this.p, HRESULT, hr, "Str", pszErrorMessage, ERROR_ADVISE_MESSAGE_TYPE, nMessageType, ERROR_ADVISE_RESULT.Ptr, pnErrorAdviseResult)
    GetUserInput(riidType, pUnknown?, pPropVarResult, pPropVarDefault?)
      => ComCall(21, this.p, GUID.Ptr, riidType, IUnknown, pUnknown?, PROPVARIANT.Ptr, pPropVarResult, PROPVARIANT.Ptr, pPropVarDefault?)
}
struct IPhotoProgressActionCB extends IUnknown {
    static IID := "{00F242D0-B206-4E7D-B4C1-4755BCBB9C9F}"
    DoAction(hWndParent)
      => ComCall(3, this.p, HWND, hWndParent)
}
struct PROGRESS_DIALOG_IMAGE_TYPE extends Int32 {
    static PROGRESS_DIALOG_ICON_SMALL := 0
    static PROGRESS_DIALOG_ICON_LARGE := 1
    static PROGRESS_DIALOG_ICON_THUMBNAIL := 2
    static PROGRESS_DIALOG_BITMAP_THUMBNAIL := 3
}
struct PROGRESS_DIALOG_CHECKBOX_ID extends Int32 {
    static PROGRESS_DIALOG_CHECKBOX_ID_DEFAULT := 0
}
struct IPhotoProgressDialog extends IUnknown {
    static IID := "{00F246F9-0750-4F08-9381-2CD8E906A4AE}"
    Create(hwndParent)
      => ComCall(3, this.p, HWND, hwndParent)
    GetWindow(phwndProgressDialog)
      => ComCall(4, this.p, HWND.Ptr, phwndProgressDialog)
    Destroy()
      => ComCall(5, this.p)
    SetTitle(pszTitle)
      => ComCall(6, this.p, "Str", pszTitle)
    ShowCheckbox(nCheckboxId, fShow)
      => ComCall(7, this.p, PROGRESS_DIALOG_CHECKBOX_ID, nCheckboxId, BOOL, fShow)
    SetCheckboxText(nCheckboxId, pszCheckboxText)
      => ComCall(8, this.p, PROGRESS_DIALOG_CHECKBOX_ID, nCheckboxId, "Str", pszCheckboxText)
    SetCheckboxCheck(nCheckboxId, fChecked)
      => ComCall(9, this.p, PROGRESS_DIALOG_CHECKBOX_ID, nCheckboxId, BOOL, fChecked)
    SetCheckboxTooltip(nCheckboxId, pszCheckboxTooltipText)
      => ComCall(10, this.p, PROGRESS_DIALOG_CHECKBOX_ID, nCheckboxId, "Str", pszCheckboxTooltipText)
    IsCheckboxChecked(nCheckboxId, pfChecked)
      => ComCall(11, this.p, PROGRESS_DIALOG_CHECKBOX_ID, nCheckboxId, BOOL.Ptr, pfChecked)
    SetCaption(pszTitle)
      => ComCall(12, this.p, "Str", pszTitle)
    SetImage(nImageType, hIcon1?, hBitmap1?)
      => ComCall(13, this.p, PROGRESS_DIALOG_IMAGE_TYPE, nImageType, HICON, hIcon1?, HBITMAP, hBitmap1?)
    SetPercentComplete(nPercent)
      => ComCall(14, this.p, Int32, nPercent)
    SetProgressText(pszProgressText)
      => ComCall(15, this.p, "Str", pszProgressText)
    SetActionLinkCallback(pPhotoProgressActionCB?)
      => ComCall(16, this.p, IPhotoProgressActionCB, pPhotoProgressActionCB?)
    SetActionLinkText(pszCaption)
      => ComCall(17, this.p, "Str", pszCaption)
    ShowActionLink(fShow)
      => ComCall(18, this.p, BOOL, fShow)
    IsCancelled(pfCancelled)
      => ComCall(19, this.p, BOOL.Ptr, pfCancelled)
    GetUserInput(riidType, pUnknown?, pPropVarResult, pPropVarDefault?)
      => ComCall(20, this.p, GUID.Ptr, riidType, IUnknown, pUnknown?, PROPVARIANT.Ptr, pPropVarResult, PROPVARIANT.Ptr, pPropVarDefault?)
}
struct IPhotoAcquireSource extends IUnknown {
    static IID := "{00F2C703-8613-4282-A53B-6EC59C5883AC}"
    GetFriendlyName(pbstrFriendlyName)
      => ComCall(3, this.p, BSTR.Ptr, pbstrFriendlyName)
    GetDeviceIcons(nSize, phLargeIcon?, phSmallIcon?)
      => ComCall(4, this.p, UInt32, nSize, HICON.Ptr, phLargeIcon?, HICON.Ptr, phSmallIcon?)
    InitializeItemList(fForceEnumeration, pPhotoAcquireProgressCB?, pnItemCount?)
      => ComCall(5, this.p, BOOL, fForceEnumeration, IPhotoAcquireProgressCB, pPhotoAcquireProgressCB?, UInt32.Ptr, pnItemCount?)
    GetItemCount(pnItemCount)
      => ComCall(6, this.p, UInt32.Ptr, pnItemCount)
    GetItemAt(nIndex, ppPhotoAcquireItem)
      => ComCall(7, this.p, UInt32, nIndex, IPhotoAcquireItem.Ptr, ppPhotoAcquireItem)
    GetPhotoAcquireSettings(ppPhotoAcquireSettings)
      => ComCall(8, this.p, IPhotoAcquireSettings.Ptr, ppPhotoAcquireSettings)
    GetDeviceId(pbstrDeviceId)
      => ComCall(9, this.p, BSTR.Ptr, pbstrDeviceId)
    BindToObject(riid, ppv)
      => ComCall(10, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IPhotoAcquire extends IUnknown {
    static IID := "{00F23353-E31B-4955-A8AD-CA5EBF31E2CE}"
    CreatePhotoSource(pszDevice, ppPhotoAcquireSource)
      => ComCall(3, this.p, "Str", pszDevice, IPhotoAcquireSource.Ptr, ppPhotoAcquireSource)
    Acquire(pPhotoAcquireSource?, fShowProgress, hWndParent?, pszApplicationName?, pPhotoAcquireProgressCB?)
      => ComCall(4, this.p, IPhotoAcquireSource, pPhotoAcquireSource?, BOOL, fShowProgress, HWND, hWndParent?, "Str", pszApplicationName?, IPhotoAcquireProgressCB, pPhotoAcquireProgressCB?)
    EnumResults(ppEnumFilePaths)
      => ComCall(5, this.p, IEnumString.Ptr, ppEnumFilePaths)
}
struct IPhotoAcquireSettings extends IUnknown {
    static IID := "{00F2B868-DD67-487C-9553-049240767E91}"
    InitializeFromRegistry(pszRegistryKey)
      => ComCall(3, this.p, "Str", pszRegistryKey)
    SetFlags(dwPhotoAcquireFlags)
      => ComCall(4, this.p, UInt32, dwPhotoAcquireFlags)
    SetOutputFilenameTemplate(pszTemplate)
      => ComCall(5, this.p, "Str", pszTemplate)
    SetSequencePaddingWidth(dwWidth)
      => ComCall(6, this.p, UInt32, dwWidth)
    SetSequenceZeroPadding(fZeroPad)
      => ComCall(7, this.p, BOOL, fZeroPad)
    SetGroupTag(pszGroupTag)
      => ComCall(8, this.p, "Str", pszGroupTag)
    SetAcquisitionTime(pftAcquisitionTime)
      => ComCall(9, this.p, FILETIME.Ptr, pftAcquisitionTime)
    GetFlags(pdwPhotoAcquireFlags)
      => ComCall(10, this.p, UInt32.Ptr, pdwPhotoAcquireFlags)
    GetOutputFilenameTemplate(pbstrTemplate)
      => ComCall(11, this.p, BSTR.Ptr, pbstrTemplate)
    GetSequencePaddingWidth(pdwWidth)
      => ComCall(12, this.p, UInt32.Ptr, pdwWidth)
    GetSequenceZeroPadding(pfZeroPad)
      => ComCall(13, this.p, BOOL.Ptr, pfZeroPad)
    GetGroupTag(pbstrGroupTag)
      => ComCall(14, this.p, BSTR.Ptr, pbstrGroupTag)
    GetAcquisitionTime(pftAcquisitionTime)
      => ComCall(15, this.p, FILETIME.Ptr, pftAcquisitionTime)
}
struct IPhotoAcquireOptionsDialog extends IUnknown {
    static IID := "{00F2B3EE-BF64-47EE-89F4-4DEDD79643F2}"
    Initialize(pszRegistryRoot?)
      => ComCall(3, this.p, "Str", pszRegistryRoot?)
    Create(hWndParent, phWndDialog)
      => ComCall(4, this.p, HWND, hWndParent, HWND.Ptr, phWndDialog)
    Destroy()
      => ComCall(5, this.p)
    DoModal(hWndParent, ppnReturnCode?)
      => ComCall(6, this.p, HWND, hWndParent, IntPtr.Ptr, ppnReturnCode?)
    SaveData()
      => ComCall(7, this.p)
}
struct DEVICE_SELECTION_DEVICE_TYPE extends Int32 {
    static DST_UNKNOWN_DEVICE := 0
    static DST_WPD_DEVICE := 1
    static DST_WIA_DEVICE := 2
    static DST_STI_DEVICE := 3
    static DSF_TWAIN_DEVICE := 4
    static DST_FS_DEVICE := 5
    static DST_DV_DEVICE := 6
}
struct IPhotoAcquireDeviceSelectionDialog extends IUnknown {
    static IID := "{00F28837-55DD-4F37-AAF5-6855A9640467}"
    SetTitle(pszTitle)
      => ComCall(3, this.p, "Str", pszTitle)
    SetSubmitButtonText(pszSubmitButtonText)
      => ComCall(4, this.p, "Str", pszSubmitButtonText)
    DoModal(hWndParent, dwDeviceFlags, pbstrDeviceId?, pnDeviceType?)
      => ComCall(5, this.p, HWND, hWndParent, UInt32, dwDeviceFlags, BSTR.Ptr, pbstrDeviceId?, DEVICE_SELECTION_DEVICE_TYPE.Ptr, pnDeviceType?)
}
struct IPhotoAcquirePlugin extends IUnknown {
    static IID := "{00F2DCEB-ECB8-4F77-8E47-E7A987C83DD0}"
    Initialize(pPhotoAcquireSource?, pPhotoAcquireProgressCB?)
      => ComCall(3, this.p, IPhotoAcquireSource, pPhotoAcquireSource?, IPhotoAcquireProgressCB, pPhotoAcquireProgressCB?)
    ProcessItem(dwAcquireStage, pPhotoAcquireItem?, pOriginalItemStream?, pszFinalFilename, pPropertyStore?)
      => ComCall(4, this.p, UInt32, dwAcquireStage, IPhotoAcquireItem, pPhotoAcquireItem?, IStream, pOriginalItemStream?, "Str", pszFinalFilename, IPropertyStore, pPropertyStore?)
    TransferComplete(hr)
      => ComCall(5, this.p, HRESULT, hr)
    DisplayConfigureDialog(hWndParent)
      => ComCall(6, this.p, HWND, hWndParent)
}
