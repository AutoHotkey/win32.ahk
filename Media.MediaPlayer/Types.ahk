#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, HWND, LPARAM, LRESULT, PWSTR, RECT, SIZE, SYSTEMTIME, VARIANT_BOOL, WPARAM}
#Import "..\Graphics.Gdi\Types.ahk" {HDC}
#Import "..\Media.MediaFoundation\Types.ahk" {IMFActivate}
#Import "..\System.Com\Types.ahk" {BLOB, IDispatch, IStream, IUnknown}
#Import "..\System.Ole\Types.ahk" {IEnumVARIANT}
#Import "..\System.Variant\Types.ahk" {VARIANT}
#Import "..\UI.WindowsAndMessaging\Types.ahk" {MSG}

struct WMPOpenState extends Int32 {
    static wmposUndefined := 0
    static wmposPlaylistChanging := 1
    static wmposPlaylistLocating := 2
    static wmposPlaylistConnecting := 3
    static wmposPlaylistLoading := 4
    static wmposPlaylistOpening := 5
    static wmposPlaylistOpenNoMedia := 6
    static wmposPlaylistChanged := 7
    static wmposMediaChanging := 8
    static wmposMediaLocating := 9
    static wmposMediaConnecting := 10
    static wmposMediaLoading := 11
    static wmposMediaOpening := 12
    static wmposMediaOpen := 13
    static wmposBeginCodecAcquisition := 14
    static wmposEndCodecAcquisition := 15
    static wmposBeginLicenseAcquisition := 16
    static wmposEndLicenseAcquisition := 17
    static wmposBeginIndividualization := 18
    static wmposEndIndividualization := 19
    static wmposMediaWaiting := 20
    static wmposOpeningUnknownURL := 21
}
struct WMPPlayState extends Int32 {
    static wmppsUndefined := 0
    static wmppsStopped := 1
    static wmppsPaused := 2
    static wmppsPlaying := 3
    static wmppsScanForward := 4
    static wmppsScanReverse := 5
    static wmppsBuffering := 6
    static wmppsWaiting := 7
    static wmppsMediaEnded := 8
    static wmppsTransitioning := 9
    static wmppsReady := 10
    static wmppsReconnecting := 11
    static wmppsLast := 12
}
struct WMPPlaylistChangeEventType extends Int32 {
    static wmplcUnknown := 0
    static wmplcClear := 1
    static wmplcInfoChange := 2
    static wmplcMove := 3
    static wmplcDelete := 4
    static wmplcInsert := 5
    static wmplcAppend := 6
    static wmplcPrivate := 7
    static wmplcNameChange := 8
    static wmplcMorph := 9
    static wmplcSort := 10
    static wmplcLast := 11
}
struct IWMPErrorItem extends IDispatch {
    static IID := "{3614C646-3B3B-4DE7-A81E-930E3F2127B3}"
    get_errorCode(phr)
      => ComCall(7, this.p, Int32.Ptr, phr)
    get_errorDescription(pbstrDescription)
      => ComCall(8, this.p, BSTR.Ptr, pbstrDescription)
    get_errorContext(pvarContext)
      => ComCall(9, this.p, VARIANT.Ptr, pvarContext)
    get_remedy(plRemedy)
      => ComCall(10, this.p, Int32.Ptr, plRemedy)
    get_customUrl(pbstrCustomUrl)
      => ComCall(11, this.p, BSTR.Ptr, pbstrCustomUrl)
}
struct IWMPError extends IDispatch {
    static IID := "{A12DCF7D-14AB-4C1B-A8CD-63909F06025B}"
    clearErrorQueue()
      => ComCall(7, this.p)
    get_errorCount(plNumErrors)
      => ComCall(8, this.p, Int32.Ptr, plNumErrors)
    get_item(dwIndex, ppErrorItem)
      => ComCall(9, this.p, Int32, dwIndex, IWMPErrorItem.Ptr, ppErrorItem)
    webHelp()
      => ComCall(10, this.p)
}
struct IWMPMedia extends IDispatch {
    static IID := "{94D55E95-3FAC-11D3-B155-00C04F79FAA6}"
    get_isIdentical(pIWMPMedia, pvbool)
      => ComCall(7, this.p, IWMPMedia, pIWMPMedia, VARIANT_BOOL.Ptr, pvbool)
    get_sourceURL(pbstrSourceURL)
      => ComCall(8, this.p, BSTR.Ptr, pbstrSourceURL)
    get_name(pbstrName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrName)
    put_name(bstrName)
      => ComCall(10, this.p, BSTR, bstrName)
    get_imageSourceWidth(pWidth)
      => ComCall(11, this.p, Int32.Ptr, pWidth)
    get_imageSourceHeight(pHeight)
      => ComCall(12, this.p, Int32.Ptr, pHeight)
    get_markerCount(pMarkerCount)
      => ComCall(13, this.p, Int32.Ptr, pMarkerCount)
    getMarkerTime(MarkerNum, pMarkerTime)
      => ComCall(14, this.p, Int32, MarkerNum, Float64.Ptr, pMarkerTime)
    getMarkerName(MarkerNum, pbstrMarkerName)
      => ComCall(15, this.p, Int32, MarkerNum, BSTR.Ptr, pbstrMarkerName)
    get_duration(pDuration)
      => ComCall(16, this.p, Float64.Ptr, pDuration)
    get_durationString(pbstrDuration)
      => ComCall(17, this.p, BSTR.Ptr, pbstrDuration)
    get_attributeCount(plCount)
      => ComCall(18, this.p, Int32.Ptr, plCount)
    getAttributeName(lIndex, pbstrItemName)
      => ComCall(19, this.p, Int32, lIndex, BSTR.Ptr, pbstrItemName)
    getItemInfo(bstrItemName, pbstrVal)
      => ComCall(20, this.p, BSTR, bstrItemName, BSTR.Ptr, pbstrVal)
    setItemInfo(bstrItemName, bstrVal)
      => ComCall(21, this.p, BSTR, bstrItemName, BSTR, bstrVal)
    getItemInfoByAtom(lAtom, pbstrVal)
      => ComCall(22, this.p, Int32, lAtom, BSTR.Ptr, pbstrVal)
    isMemberOf(pPlaylist, pvarfIsMemberOf)
      => ComCall(23, this.p, IWMPPlaylist, pPlaylist, VARIANT_BOOL.Ptr, pvarfIsMemberOf)
    isReadOnlyItem(bstrItemName, pvarfIsReadOnly)
      => ComCall(24, this.p, BSTR, bstrItemName, VARIANT_BOOL.Ptr, pvarfIsReadOnly)
}
struct IWMPControls extends IDispatch {
    static IID := "{74C09E02-F828-11D2-A74B-00A0C905F36E}"
    get_isAvailable(bstrItem, pIsAvailable)
      => ComCall(7, this.p, BSTR, bstrItem, VARIANT_BOOL.Ptr, pIsAvailable)
    play()
      => ComCall(8, this.p)
    stop()
      => ComCall(9, this.p)
    pause()
      => ComCall(10, this.p)
    fastForward()
      => ComCall(11, this.p)
    fastReverse()
      => ComCall(12, this.p)
    get_currentPosition(pdCurrentPosition)
      => ComCall(13, this.p, Float64.Ptr, pdCurrentPosition)
    put_currentPosition(dCurrentPosition)
      => ComCall(14, this.p, Float64, dCurrentPosition)
    get_currentPositionString(pbstrCurrentPosition)
      => ComCall(15, this.p, BSTR.Ptr, pbstrCurrentPosition)
    next()
      => ComCall(16, this.p)
    previous()
      => ComCall(17, this.p)
    get_currentItem(ppIWMPMedia)
      => ComCall(18, this.p, IWMPMedia.Ptr, ppIWMPMedia)
    put_currentItem(pIWMPMedia)
      => ComCall(19, this.p, IWMPMedia, pIWMPMedia)
    get_currentMarker(plMarker)
      => ComCall(20, this.p, Int32.Ptr, plMarker)
    put_currentMarker(lMarker)
      => ComCall(21, this.p, Int32, lMarker)
    playItem(pIWMPMedia)
      => ComCall(22, this.p, IWMPMedia, pIWMPMedia)
}
struct IWMPSettings extends IDispatch {
    static IID := "{9104D1AB-80C9-4FED-ABF0-2E6417A6DF14}"
    get_isAvailable(bstrItem, pIsAvailable)
      => ComCall(7, this.p, BSTR, bstrItem, VARIANT_BOOL.Ptr, pIsAvailable)
    get_autoStart(pfAutoStart)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, pfAutoStart)
    put_autoStart(fAutoStart)
      => ComCall(9, this.p, VARIANT_BOOL, fAutoStart)
    get_baseURL(pbstrBaseURL)
      => ComCall(10, this.p, BSTR.Ptr, pbstrBaseURL)
    put_baseURL(bstrBaseURL)
      => ComCall(11, this.p, BSTR, bstrBaseURL)
    get_defaultFrame(pbstrDefaultFrame)
      => ComCall(12, this.p, BSTR.Ptr, pbstrDefaultFrame)
    put_defaultFrame(bstrDefaultFrame)
      => ComCall(13, this.p, BSTR, bstrDefaultFrame)
    get_invokeURLs(pfInvokeURLs)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, pfInvokeURLs)
    put_invokeURLs(fInvokeURLs)
      => ComCall(15, this.p, VARIANT_BOOL, fInvokeURLs)
    get_mute(pfMute)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, pfMute)
    put_mute(fMute)
      => ComCall(17, this.p, VARIANT_BOOL, fMute)
    get_playCount(plCount)
      => ComCall(18, this.p, Int32.Ptr, plCount)
    put_playCount(lCount)
      => ComCall(19, this.p, Int32, lCount)
    get_rate(pdRate)
      => ComCall(20, this.p, Float64.Ptr, pdRate)
    put_rate(dRate)
      => ComCall(21, this.p, Float64, dRate)
    get_balance(plBalance)
      => ComCall(22, this.p, Int32.Ptr, plBalance)
    put_balance(lBalance)
      => ComCall(23, this.p, Int32, lBalance)
    get_volume(plVolume)
      => ComCall(24, this.p, Int32.Ptr, plVolume)
    put_volume(lVolume)
      => ComCall(25, this.p, Int32, lVolume)
    getMode(bstrMode, pvarfMode)
      => ComCall(26, this.p, BSTR, bstrMode, VARIANT_BOOL.Ptr, pvarfMode)
    setMode(bstrMode, varfMode)
      => ComCall(27, this.p, BSTR, bstrMode, VARIANT_BOOL, varfMode)
    get_enableErrorDialogs(pfEnableErrorDialogs)
      => ComCall(28, this.p, VARIANT_BOOL.Ptr, pfEnableErrorDialogs)
    put_enableErrorDialogs(fEnableErrorDialogs)
      => ComCall(29, this.p, VARIANT_BOOL, fEnableErrorDialogs)
}
struct IWMPClosedCaption extends IDispatch {
    static IID := "{4F2DF574-C588-11D3-9ED0-00C04FB6E937}"
    get_SAMIStyle(pbstrSAMIStyle)
      => ComCall(7, this.p, BSTR.Ptr, pbstrSAMIStyle)
    put_SAMIStyle(bstrSAMIStyle)
      => ComCall(8, this.p, BSTR, bstrSAMIStyle)
    get_SAMILang(pbstrSAMILang)
      => ComCall(9, this.p, BSTR.Ptr, pbstrSAMILang)
    put_SAMILang(bstrSAMILang)
      => ComCall(10, this.p, BSTR, bstrSAMILang)
    get_SAMIFileName(pbstrSAMIFileName)
      => ComCall(11, this.p, BSTR.Ptr, pbstrSAMIFileName)
    put_SAMIFileName(bstrSAMIFileName)
      => ComCall(12, this.p, BSTR, bstrSAMIFileName)
    get_captioningId(pbstrCaptioningID)
      => ComCall(13, this.p, BSTR.Ptr, pbstrCaptioningID)
    put_captioningId(bstrCaptioningID)
      => ComCall(14, this.p, BSTR, bstrCaptioningID)
}
struct IWMPPlaylist extends IDispatch {
    static IID := "{D5F0F4F1-130C-11D3-B14E-00C04F79FAA6}"
    get_count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    get_name(pbstrName)
      => ComCall(8, this.p, BSTR.Ptr, pbstrName)
    put_name(bstrName)
      => ComCall(9, this.p, BSTR, bstrName)
    get_attributeCount(plCount)
      => ComCall(10, this.p, Int32.Ptr, plCount)
    get_attributeName(lIndex, pbstrAttributeName)
      => ComCall(11, this.p, Int32, lIndex, BSTR.Ptr, pbstrAttributeName)
    get_item(lIndex, ppIWMPMedia)
      => ComCall(12, this.p, Int32, lIndex, IWMPMedia.Ptr, ppIWMPMedia)
    getItemInfo(bstrName, pbstrVal)
      => ComCall(13, this.p, BSTR, bstrName, BSTR.Ptr, pbstrVal)
    setItemInfo(bstrName, bstrValue)
      => ComCall(14, this.p, BSTR, bstrName, BSTR, bstrValue)
    get_isIdentical(pIWMPPlaylist, pvbool)
      => ComCall(15, this.p, IWMPPlaylist, pIWMPPlaylist, VARIANT_BOOL.Ptr, pvbool)
    clear()
      => ComCall(16, this.p)
    insertItem(lIndex, pIWMPMedia)
      => ComCall(17, this.p, Int32, lIndex, IWMPMedia, pIWMPMedia)
    appendItem(pIWMPMedia)
      => ComCall(18, this.p, IWMPMedia, pIWMPMedia)
    removeItem(pIWMPMedia)
      => ComCall(19, this.p, IWMPMedia, pIWMPMedia)
    moveItem(lIndexOld, lIndexNew)
      => ComCall(20, this.p, Int32, lIndexOld, Int32, lIndexNew)
}
struct IWMPCdrom extends IDispatch {
    static IID := "{CFAB6E98-8730-11D3-B388-00C04F68574B}"
    get_driveSpecifier(pbstrDrive)
      => ComCall(7, this.p, BSTR.Ptr, pbstrDrive)
    get_playlist(ppPlaylist)
      => ComCall(8, this.p, IWMPPlaylist.Ptr, ppPlaylist)
    eject()
      => ComCall(9, this.p)
}
struct IWMPCdromCollection extends IDispatch {
    static IID := "{EE4C8FE2-34B2-11D3-A3BF-006097C9B344}"
    get_count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    item(lIndex, ppItem)
      => ComCall(8, this.p, Int32, lIndex, IWMPCdrom.Ptr, ppItem)
    getByDriveSpecifier(bstrDriveSpecifier, ppCdrom)
      => ComCall(9, this.p, BSTR, bstrDriveSpecifier, IWMPCdrom.Ptr, ppCdrom)
}
struct IWMPStringCollection extends IDispatch {
    static IID := "{4A976298-8C0D-11D3-B389-00C04F68574B}"
    get_count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    item(lIndex, pbstrString)
      => ComCall(8, this.p, Int32, lIndex, BSTR.Ptr, pbstrString)
}
struct IWMPMediaCollection extends IDispatch {
    static IID := "{8363BC22-B4B4-4B19-989D-1CD765749DD1}"
    add(bstrURL, ppItem)
      => ComCall(7, this.p, BSTR, bstrURL, IWMPMedia.Ptr, ppItem)
    getAll(ppMediaItems)
      => ComCall(8, this.p, IWMPPlaylist.Ptr, ppMediaItems)
    getByName(bstrName, ppMediaItems)
      => ComCall(9, this.p, BSTR, bstrName, IWMPPlaylist.Ptr, ppMediaItems)
    getByGenre(bstrGenre, ppMediaItems)
      => ComCall(10, this.p, BSTR, bstrGenre, IWMPPlaylist.Ptr, ppMediaItems)
    getByAuthor(bstrAuthor, ppMediaItems)
      => ComCall(11, this.p, BSTR, bstrAuthor, IWMPPlaylist.Ptr, ppMediaItems)
    getByAlbum(bstrAlbum, ppMediaItems)
      => ComCall(12, this.p, BSTR, bstrAlbum, IWMPPlaylist.Ptr, ppMediaItems)
    getByAttribute(bstrAttribute, bstrValue, ppMediaItems)
      => ComCall(13, this.p, BSTR, bstrAttribute, BSTR, bstrValue, IWMPPlaylist.Ptr, ppMediaItems)
    remove(pItem, varfDeleteFile)
      => ComCall(14, this.p, IWMPMedia, pItem, VARIANT_BOOL, varfDeleteFile)
    getAttributeStringCollection(bstrAttribute, bstrMediaType, ppStringCollection)
      => ComCall(15, this.p, BSTR, bstrAttribute, BSTR, bstrMediaType, IWMPStringCollection.Ptr, ppStringCollection)
    getMediaAtom(bstrItemName, plAtom)
      => ComCall(16, this.p, BSTR, bstrItemName, Int32.Ptr, plAtom)
    setDeleted(pItem, varfIsDeleted)
      => ComCall(17, this.p, IWMPMedia, pItem, VARIANT_BOOL, varfIsDeleted)
    isDeleted(pItem, pvarfIsDeleted)
      => ComCall(18, this.p, IWMPMedia, pItem, VARIANT_BOOL.Ptr, pvarfIsDeleted)
}
struct IWMPPlaylistArray extends IDispatch {
    static IID := "{679409C0-99F7-11D3-9FB7-00105AA620BB}"
    get_count(plCount)
      => ComCall(7, this.p, Int32.Ptr, plCount)
    item(lIndex, ppItem)
      => ComCall(8, this.p, Int32, lIndex, IWMPPlaylist.Ptr, ppItem)
}
struct IWMPPlaylistCollection extends IDispatch {
    static IID := "{10A13217-23A7-439B-B1C0-D847C79B7774}"
    newPlaylist(bstrName, ppItem)
      => ComCall(7, this.p, BSTR, bstrName, IWMPPlaylist.Ptr, ppItem)
    getAll(ppPlaylistArray)
      => ComCall(8, this.p, IWMPPlaylistArray.Ptr, ppPlaylistArray)
    getByName(bstrName, ppPlaylistArray)
      => ComCall(9, this.p, BSTR, bstrName, IWMPPlaylistArray.Ptr, ppPlaylistArray)
    remove(pItem)
      => ComCall(10, this.p, IWMPPlaylist, pItem)
    setDeleted(pItem, varfIsDeleted)
      => ComCall(11, this.p, IWMPPlaylist, pItem, VARIANT_BOOL, varfIsDeleted)
    isDeleted(pItem, pvarfIsDeleted)
      => ComCall(12, this.p, IWMPPlaylist, pItem, VARIANT_BOOL.Ptr, pvarfIsDeleted)
    importPlaylist(pItem, ppImportedItem)
      => ComCall(13, this.p, IWMPPlaylist, pItem, IWMPPlaylist.Ptr, ppImportedItem)
}
struct IWMPNetwork extends IDispatch {
    static IID := "{EC21B779-EDEF-462D-BBA4-AD9DDE2B29A7}"
    get_bandWidth(plBandwidth)
      => ComCall(7, this.p, Int32.Ptr, plBandwidth)
    get_recoveredPackets(plRecoveredPackets)
      => ComCall(8, this.p, Int32.Ptr, plRecoveredPackets)
    get_sourceProtocol(pbstrSourceProtocol)
      => ComCall(9, this.p, BSTR.Ptr, pbstrSourceProtocol)
    get_receivedPackets(plReceivedPackets)
      => ComCall(10, this.p, Int32.Ptr, plReceivedPackets)
    get_lostPackets(plLostPackets)
      => ComCall(11, this.p, Int32.Ptr, plLostPackets)
    get_receptionQuality(plReceptionQuality)
      => ComCall(12, this.p, Int32.Ptr, plReceptionQuality)
    get_bufferingCount(plBufferingCount)
      => ComCall(13, this.p, Int32.Ptr, plBufferingCount)
    get_bufferingProgress(plBufferingProgress)
      => ComCall(14, this.p, Int32.Ptr, plBufferingProgress)
    get_bufferingTime(plBufferingTime)
      => ComCall(15, this.p, Int32.Ptr, plBufferingTime)
    put_bufferingTime(lBufferingTime)
      => ComCall(16, this.p, Int32, lBufferingTime)
    get_frameRate(plFrameRate)
      => ComCall(17, this.p, Int32.Ptr, plFrameRate)
    get_maxBitRate(plBitRate)
      => ComCall(18, this.p, Int32.Ptr, plBitRate)
    get_bitRate(plBitRate)
      => ComCall(19, this.p, Int32.Ptr, plBitRate)
    getProxySettings(bstrProtocol, plProxySetting)
      => ComCall(20, this.p, BSTR, bstrProtocol, Int32.Ptr, plProxySetting)
    setProxySettings(bstrProtocol, lProxySetting)
      => ComCall(21, this.p, BSTR, bstrProtocol, Int32, lProxySetting)
    getProxyName(bstrProtocol, pbstrProxyName)
      => ComCall(22, this.p, BSTR, bstrProtocol, BSTR.Ptr, pbstrProxyName)
    setProxyName(bstrProtocol, bstrProxyName)
      => ComCall(23, this.p, BSTR, bstrProtocol, BSTR, bstrProxyName)
    getProxyPort(bstrProtocol, lProxyPort)
      => ComCall(24, this.p, BSTR, bstrProtocol, Int32.Ptr, lProxyPort)
    setProxyPort(bstrProtocol, lProxyPort)
      => ComCall(25, this.p, BSTR, bstrProtocol, Int32, lProxyPort)
    getProxyExceptionList(bstrProtocol, pbstrExceptionList)
      => ComCall(26, this.p, BSTR, bstrProtocol, BSTR.Ptr, pbstrExceptionList)
    setProxyExceptionList(bstrProtocol, pbstrExceptionList)
      => ComCall(27, this.p, BSTR, bstrProtocol, BSTR, pbstrExceptionList)
    getProxyBypassForLocal(bstrProtocol, pfBypassForLocal)
      => ComCall(28, this.p, BSTR, bstrProtocol, VARIANT_BOOL.Ptr, pfBypassForLocal)
    setProxyBypassForLocal(bstrProtocol, fBypassForLocal)
      => ComCall(29, this.p, BSTR, bstrProtocol, VARIANT_BOOL, fBypassForLocal)
    get_maxBandwidth(lMaxBandwidth)
      => ComCall(30, this.p, Int32.Ptr, lMaxBandwidth)
    put_maxBandwidth(lMaxBandwidth)
      => ComCall(31, this.p, Int32, lMaxBandwidth)
    get_downloadProgress(plDownloadProgress)
      => ComCall(32, this.p, Int32.Ptr, plDownloadProgress)
    get_encodedFrameRate(plFrameRate)
      => ComCall(33, this.p, Int32.Ptr, plFrameRate)
    get_framesSkipped(plFrames)
      => ComCall(34, this.p, Int32.Ptr, plFrames)
}
struct IWMPCore extends IDispatch {
    static IID := "{D84CCA99-CCE2-11D2-9ECC-0000F8085981}"
    close()
      => ComCall(7, this.p)
    get_URL(pbstrURL)
      => ComCall(8, this.p, BSTR.Ptr, pbstrURL)
    put_URL(bstrURL)
      => ComCall(9, this.p, BSTR, bstrURL)
    get_openState(pwmpos)
      => ComCall(10, this.p, WMPOpenState.Ptr, pwmpos)
    get_playState(pwmpps)
      => ComCall(11, this.p, WMPPlayState.Ptr, pwmpps)
    get_controls(ppControl)
      => ComCall(12, this.p, IWMPControls.Ptr, ppControl)
    get_settings(ppSettings)
      => ComCall(13, this.p, IWMPSettings.Ptr, ppSettings)
    get_currentMedia(ppMedia)
      => ComCall(14, this.p, IWMPMedia.Ptr, ppMedia)
    put_currentMedia(pMedia)
      => ComCall(15, this.p, IWMPMedia, pMedia)
    get_mediaCollection(ppMediaCollection)
      => ComCall(16, this.p, IWMPMediaCollection.Ptr, ppMediaCollection)
    get_playlistCollection(ppPlaylistCollection)
      => ComCall(17, this.p, IWMPPlaylistCollection.Ptr, ppPlaylistCollection)
    get_versionInfo(pbstrVersionInfo)
      => ComCall(18, this.p, BSTR.Ptr, pbstrVersionInfo)
    launchURL(bstrURL)
      => ComCall(19, this.p, BSTR, bstrURL)
    get_network(ppQNI)
      => ComCall(20, this.p, IWMPNetwork.Ptr, ppQNI)
    get_currentPlaylist(ppPL)
      => ComCall(21, this.p, IWMPPlaylist.Ptr, ppPL)
    put_currentPlaylist(pPL)
      => ComCall(22, this.p, IWMPPlaylist, pPL)
    get_cdromCollection(ppCdromCollection)
      => ComCall(23, this.p, IWMPCdromCollection.Ptr, ppCdromCollection)
    get_closedCaption(ppClosedCaption)
      => ComCall(24, this.p, IWMPClosedCaption.Ptr, ppClosedCaption)
    get_isOnline(pfOnline)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, pfOnline)
    get_error(ppError)
      => ComCall(26, this.p, IWMPError.Ptr, ppError)
    get_status(pbstrStatus)
      => ComCall(27, this.p, BSTR.Ptr, pbstrStatus)
}
struct IWMPPlayer extends IWMPCore {
    static IID := "{6BF52A4F-394A-11D3-B153-00C04F79FAA6}"
    get_enabled(pbEnabled)
      => ComCall(28, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_enabled(bEnabled)
      => ComCall(29, this.p, VARIANT_BOOL, bEnabled)
    get_fullScreen(pbFullScreen)
      => ComCall(30, this.p, VARIANT_BOOL.Ptr, pbFullScreen)
    put_fullScreen(bFullScreen)
      => ComCall(31, this.p, VARIANT_BOOL, bFullScreen)
    get_enableContextMenu(pbEnableContextMenu)
      => ComCall(32, this.p, VARIANT_BOOL.Ptr, pbEnableContextMenu)
    put_enableContextMenu(bEnableContextMenu)
      => ComCall(33, this.p, VARIANT_BOOL, bEnableContextMenu)
    put_uiMode(bstrMode)
      => ComCall(34, this.p, BSTR, bstrMode)
    get_uiMode(pbstrMode)
      => ComCall(35, this.p, BSTR.Ptr, pbstrMode)
}
struct IWMPPlayer2 extends IWMPCore {
    static IID := "{0E6B01D1-D407-4C85-BF5F-1C01F6150280}"
    get_enabled(pbEnabled)
      => ComCall(28, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_enabled(bEnabled)
      => ComCall(29, this.p, VARIANT_BOOL, bEnabled)
    get_fullScreen(pbFullScreen)
      => ComCall(30, this.p, VARIANT_BOOL.Ptr, pbFullScreen)
    put_fullScreen(bFullScreen)
      => ComCall(31, this.p, VARIANT_BOOL, bFullScreen)
    get_enableContextMenu(pbEnableContextMenu)
      => ComCall(32, this.p, VARIANT_BOOL.Ptr, pbEnableContextMenu)
    put_enableContextMenu(bEnableContextMenu)
      => ComCall(33, this.p, VARIANT_BOOL, bEnableContextMenu)
    put_uiMode(bstrMode)
      => ComCall(34, this.p, BSTR, bstrMode)
    get_uiMode(pbstrMode)
      => ComCall(35, this.p, BSTR.Ptr, pbstrMode)
    get_stretchToFit(pbEnabled)
      => ComCall(36, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_stretchToFit(bEnabled)
      => ComCall(37, this.p, VARIANT_BOOL, bEnabled)
    get_windowlessVideo(pbEnabled)
      => ComCall(38, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_windowlessVideo(bEnabled)
      => ComCall(39, this.p, VARIANT_BOOL, bEnabled)
}
struct IWMPMedia2 extends IWMPMedia {
    static IID := "{AB7C88BB-143E-4EA4-ACC3-E4350B2106C3}"
    get_error(ppIWMPErrorItem)
      => ComCall(25, this.p, IWMPErrorItem.Ptr, ppIWMPErrorItem)
}
struct IWMPControls2 extends IWMPControls {
    static IID := "{6F030D25-0890-480F-9775-1F7E40AB5B8E}"
    step(lStep)
      => ComCall(23, this.p, Int32, lStep)
}
struct IWMPDVD extends IDispatch {
    static IID := "{8DA61686-4668-4A5C-AE5D-803193293DBE}"
    get_isAvailable(bstrItem, pIsAvailable)
      => ComCall(7, this.p, BSTR, bstrItem, VARIANT_BOOL.Ptr, pIsAvailable)
    get_domain(strDomain)
      => ComCall(8, this.p, BSTR.Ptr, strDomain)
    topMenu()
      => ComCall(9, this.p)
    titleMenu()
      => ComCall(10, this.p)
    back()
      => ComCall(11, this.p)
    resume()
      => ComCall(12, this.p)
}
struct IWMPCore2 extends IWMPCore {
    static IID := "{BC17E5B7-7561-4C18-BB90-17D485775659}"
    get_dvd(ppDVD)
      => ComCall(28, this.p, IWMPDVD.Ptr, ppDVD)
}
struct IWMPPlayer3 extends IWMPCore2 {
    static IID := "{54062B68-052A-4C25-A39F-8B63346511D4}"
    get_enabled(pbEnabled)
      => ComCall(29, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_enabled(bEnabled)
      => ComCall(30, this.p, VARIANT_BOOL, bEnabled)
    get_fullScreen(pbFullScreen)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, pbFullScreen)
    put_fullScreen(bFullScreen)
      => ComCall(32, this.p, VARIANT_BOOL, bFullScreen)
    get_enableContextMenu(pbEnableContextMenu)
      => ComCall(33, this.p, VARIANT_BOOL.Ptr, pbEnableContextMenu)
    put_enableContextMenu(bEnableContextMenu)
      => ComCall(34, this.p, VARIANT_BOOL, bEnableContextMenu)
    put_uiMode(bstrMode)
      => ComCall(35, this.p, BSTR, bstrMode)
    get_uiMode(pbstrMode)
      => ComCall(36, this.p, BSTR.Ptr, pbstrMode)
    get_stretchToFit(pbEnabled)
      => ComCall(37, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_stretchToFit(bEnabled)
      => ComCall(38, this.p, VARIANT_BOOL, bEnabled)
    get_windowlessVideo(pbEnabled)
      => ComCall(39, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_windowlessVideo(bEnabled)
      => ComCall(40, this.p, VARIANT_BOOL, bEnabled)
}
struct IWMPErrorItem2 extends IWMPErrorItem {
    static IID := "{F75CCEC0-C67C-475C-931E-8719870BEE7D}"
    get_condition(plCondition)
      => ComCall(12, this.p, Int32.Ptr, plCondition)
}
struct IWMPRemoteMediaServices extends IUnknown {
    static IID := "{CBB92747-741F-44FE-AB5B-F1A48F3B2A59}"
    GetServiceType(pbstrType)
      => ComCall(3, this.p, BSTR.Ptr, pbstrType)
    GetApplicationName(pbstrName)
      => ComCall(4, this.p, BSTR.Ptr, pbstrName)
    GetScriptableObject(pbstrName, ppDispatch)
      => ComCall(5, this.p, BSTR.Ptr, pbstrName, IDispatch.Ptr, ppDispatch)
    GetCustomUIMode(pbstrFile)
      => ComCall(6, this.p, BSTR.Ptr, pbstrFile)
}
struct IWMPSkinManager extends IUnknown {
    static IID := "{076F2FA6-ED30-448B-8CC5-3F3EF3529C7A}"
    SetVisualStyle(bstrPath)
      => ComCall(3, this.p, BSTR, bstrPath)
}
struct IWMPMetadataPicture extends IDispatch {
    static IID := "{5C29BBE0-F87D-4C45-AA28-A70F0230FFA9}"
    get_mimeType(pbstrMimeType)
      => ComCall(7, this.p, BSTR.Ptr, pbstrMimeType)
    get_pictureType(pbstrPictureType)
      => ComCall(8, this.p, BSTR.Ptr, pbstrPictureType)
    get_description(pbstrDescription)
      => ComCall(9, this.p, BSTR.Ptr, pbstrDescription)
    get_URL(pbstrURL)
      => ComCall(10, this.p, BSTR.Ptr, pbstrURL)
}
struct IWMPMetadataText extends IDispatch {
    static IID := "{769A72DB-13D2-45E2-9C48-53CA9D5B7450}"
    get_description(pbstrDescription)
      => ComCall(7, this.p, BSTR.Ptr, pbstrDescription)
    get_text(pbstrText)
      => ComCall(8, this.p, BSTR.Ptr, pbstrText)
}
struct IWMPMedia3 extends IWMPMedia2 {
    static IID := "{F118EFC7-F03A-4FB4-99C9-1C02A5C1065B}"
    getAttributeCountByType(bstrType, bstrLanguage, plCount)
      => ComCall(26, this.p, BSTR, bstrType, BSTR, bstrLanguage, Int32.Ptr, plCount)
    getItemInfoByType(bstrType, bstrLanguage, lIndex, pvarValue)
      => ComCall(27, this.p, BSTR, bstrType, BSTR, bstrLanguage, Int32, lIndex, VARIANT.Ptr, pvarValue)
}
struct IWMPSettings2 extends IWMPSettings {
    static IID := "{FDA937A4-EECE-4DA5-A0B6-39BF89ADE2C2}"
    get_defaultAudioLanguage(plLangID)
      => ComCall(30, this.p, Int32.Ptr, plLangID)
    get_mediaAccessRights(pbstrRights)
      => ComCall(31, this.p, BSTR.Ptr, pbstrRights)
    requestMediaAccessRights(bstrDesiredAccess, pvbAccepted)
      => ComCall(32, this.p, BSTR, bstrDesiredAccess, VARIANT_BOOL.Ptr, pvbAccepted)
}
struct IWMPControls3 extends IWMPControls2 {
    static IID := "{A1D1110E-D545-476A-9A78-AC3E4CB1E6BD}"
    get_audioLanguageCount(plCount)
      => ComCall(24, this.p, Int32.Ptr, plCount)
    getAudioLanguageID(lIndex, plLangID)
      => ComCall(25, this.p, Int32, lIndex, Int32.Ptr, plLangID)
    getAudioLanguageDescription(lIndex, pbstrLangDesc)
      => ComCall(26, this.p, Int32, lIndex, BSTR.Ptr, pbstrLangDesc)
    get_currentAudioLanguage(plLangID)
      => ComCall(27, this.p, Int32.Ptr, plLangID)
    put_currentAudioLanguage(lLangID)
      => ComCall(28, this.p, Int32, lLangID)
    get_currentAudioLanguageIndex(plIndex)
      => ComCall(29, this.p, Int32.Ptr, plIndex)
    put_currentAudioLanguageIndex(lIndex)
      => ComCall(30, this.p, Int32, lIndex)
    getLanguageName(lLangID, pbstrLangName)
      => ComCall(31, this.p, Int32, lLangID, BSTR.Ptr, pbstrLangName)
    get_currentPositionTimecode(bstrTimecode)
      => ComCall(32, this.p, BSTR.Ptr, bstrTimecode)
    put_currentPositionTimecode(bstrTimecode)
      => ComCall(33, this.p, BSTR, bstrTimecode)
}
struct IWMPClosedCaption2 extends IWMPClosedCaption {
    static IID := "{350BA78B-6BC8-4113-A5F5-312056934EB6}"
    get_SAMILangCount(plCount)
      => ComCall(15, this.p, Int32.Ptr, plCount)
    getSAMILangName(nIndex, pbstrName)
      => ComCall(16, this.p, Int32, nIndex, BSTR.Ptr, pbstrName)
    getSAMILangID(nIndex, plLangID)
      => ComCall(17, this.p, Int32, nIndex, Int32.Ptr, plLangID)
    get_SAMIStyleCount(plCount)
      => ComCall(18, this.p, Int32.Ptr, plCount)
    getSAMIStyleName(nIndex, pbstrName)
      => ComCall(19, this.p, Int32, nIndex, BSTR.Ptr, pbstrName)
}
struct IWMPPlayerApplication extends IDispatch {
    static IID := "{40897764-CEAB-47BE-AD4A-8E28537F9BBF}"
    switchToPlayerApplication()
      => ComCall(7, this.p)
    switchToControl()
      => ComCall(8, this.p)
    get_playerDocked(pbPlayerDocked)
      => ComCall(9, this.p, VARIANT_BOOL.Ptr, pbPlayerDocked)
    get_hasDisplay(pbHasDisplay)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, pbHasDisplay)
}
struct IWMPCore3 extends IWMPCore2 {
    static IID := "{7587C667-628F-499F-88E7-6A6F4E888464}"
    newPlaylist(bstrName, bstrURL, ppPlaylist)
      => ComCall(29, this.p, BSTR, bstrName, BSTR, bstrURL, IWMPPlaylist.Ptr, ppPlaylist)
    newMedia(bstrURL, ppMedia)
      => ComCall(30, this.p, BSTR, bstrURL, IWMPMedia.Ptr, ppMedia)
}
struct IWMPPlayer4 extends IWMPCore3 {
    static IID := "{6C497D62-8919-413C-82DB-E935FB3EC584}"
    get_enabled(pbEnabled)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_enabled(bEnabled)
      => ComCall(32, this.p, VARIANT_BOOL, bEnabled)
    get_fullScreen(pbFullScreen)
      => ComCall(33, this.p, VARIANT_BOOL.Ptr, pbFullScreen)
    put_fullScreen(bFullScreen)
      => ComCall(34, this.p, VARIANT_BOOL, bFullScreen)
    get_enableContextMenu(pbEnableContextMenu)
      => ComCall(35, this.p, VARIANT_BOOL.Ptr, pbEnableContextMenu)
    put_enableContextMenu(bEnableContextMenu)
      => ComCall(36, this.p, VARIANT_BOOL, bEnableContextMenu)
    put_uiMode(bstrMode)
      => ComCall(37, this.p, BSTR, bstrMode)
    get_uiMode(pbstrMode)
      => ComCall(38, this.p, BSTR.Ptr, pbstrMode)
    get_stretchToFit(pbEnabled)
      => ComCall(39, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_stretchToFit(bEnabled)
      => ComCall(40, this.p, VARIANT_BOOL, bEnabled)
    get_windowlessVideo(pbEnabled)
      => ComCall(41, this.p, VARIANT_BOOL.Ptr, pbEnabled)
    put_windowlessVideo(bEnabled)
      => ComCall(42, this.p, VARIANT_BOOL, bEnabled)
    get_isRemote(pvarfIsRemote)
      => ComCall(43, this.p, VARIANT_BOOL.Ptr, pvarfIsRemote)
    get_playerApplication(ppIWMPPlayerApplication)
      => ComCall(44, this.p, IWMPPlayerApplication.Ptr, ppIWMPPlayerApplication)
    openPlayer(bstrURL)
      => ComCall(45, this.p, BSTR, bstrURL)
}
struct IWMPPlayerServices extends IUnknown {
    static IID := "{1D01FBDB-ADE2-4C8D-9842-C190B95C3306}"
    activateUIPlugin(bstrPlugin)
      => ComCall(3, this.p, BSTR, bstrPlugin)
    setTaskPane(bstrTaskPane)
      => ComCall(4, this.p, BSTR, bstrTaskPane)
    setTaskPaneURL(bstrTaskPane, bstrURL, bstrFriendlyName)
      => ComCall(5, this.p, BSTR, bstrTaskPane, BSTR, bstrURL, BSTR, bstrFriendlyName)
}
struct WMPSyncState extends Int32 {
    static wmpssUnknown := 0
    static wmpssSynchronizing := 1
    static wmpssStopped := 2
    static wmpssEstimating := 3
    static wmpssLast := 4
}
struct WMPDeviceStatus extends Int32 {
    static wmpdsUnknown := 0
    static wmpdsPartnershipExists := 1
    static wmpdsPartnershipDeclined := 2
    static wmpdsPartnershipAnother := 3
    static wmpdsManualDevice := 4
    static wmpdsNewDevice := 5
    static wmpdsLast := 6
}
struct IWMPSyncDevice extends IUnknown {
    static IID := "{82A2986C-0293-4FD0-B279-B21B86C058BE}"
    get_friendlyName(pbstrName)
      => ComCall(3, this.p, BSTR.Ptr, pbstrName)
    put_friendlyName(bstrName)
      => ComCall(4, this.p, BSTR, bstrName)
    get_deviceName(pbstrName)
      => ComCall(5, this.p, BSTR.Ptr, pbstrName)
    get_deviceId(pbstrDeviceId)
      => ComCall(6, this.p, BSTR.Ptr, pbstrDeviceId)
    get_partnershipIndex(plIndex)
      => ComCall(7, this.p, Int32.Ptr, plIndex)
    get_connected(pvbConnected)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, pvbConnected)
    get_status(pwmpds)
      => ComCall(9, this.p, WMPDeviceStatus.Ptr, pwmpds)
    get_syncState(pwmpss)
      => ComCall(10, this.p, WMPSyncState.Ptr, pwmpss)
    get_progress(plProgress)
      => ComCall(11, this.p, Int32.Ptr, plProgress)
    getItemInfo(bstrItemName, pbstrVal)
      => ComCall(12, this.p, BSTR, bstrItemName, BSTR.Ptr, pbstrVal)
    createPartnership(vbShowUI)
      => ComCall(13, this.p, VARIANT_BOOL, vbShowUI)
    deletePartnership()
      => ComCall(14, this.p)
    start()
      => ComCall(15, this.p)
    stop()
      => ComCall(16, this.p)
    showSettings()
      => ComCall(17, this.p)
    isIdentical(pDevice, pvbool)
      => ComCall(18, this.p, IWMPSyncDevice, pDevice, VARIANT_BOOL.Ptr, pvbool)
}
struct IWMPSyncServices extends IUnknown {
    static IID := "{8B5050FF-E0A4-4808-B3A8-893A9E1ED894}"
    get_deviceCount(plCount)
      => ComCall(3, this.p, Int32.Ptr, plCount)
    getDevice(lIndex, ppDevice)
      => ComCall(4, this.p, Int32, lIndex, IWMPSyncDevice.Ptr, ppDevice)
}
struct IWMPPlayerServices2 extends IWMPPlayerServices {
    static IID := "{1BB1592F-F040-418A-9F71-17C7512B4D70}"
    setBackgroundProcessingPriority(bstrPriority)
      => ComCall(6, this.p, BSTR, bstrPriority)
}
struct WMPRipState extends Int32 {
    static wmprsUnknown := 0
    static wmprsRipping := 1
    static wmprsStopped := 2
}
struct WMPBurnFormat extends Int32 {
    static wmpbfAudioCD := 0
    static wmpbfDataCD := 1
}
struct WMPBurnState extends Int32 {
    static wmpbsUnknown := 0
    static wmpbsBusy := 1
    static wmpbsReady := 2
    static wmpbsWaitingForDisc := 3
    static wmpbsRefreshStatusPending := 4
    static wmpbsPreparingToBurn := 5
    static wmpbsBurning := 6
    static wmpbsStopped := 7
    static wmpbsErasing := 8
    static wmpbsDownloading := 9
}
struct WMPStringCollectionChangeEventType extends Int32 {
    static wmpsccetUnknown := 0
    static wmpsccetInsert := 1
    static wmpsccetChange := 2
    static wmpsccetDelete := 3
    static wmpsccetClear := 4
    static wmpsccetBeginUpdates := 5
    static wmpsccetEndUpdates := 6
}
struct IWMPCdromRip extends IUnknown {
    static IID := "{56E2294F-69ED-4629-A869-AEA72C0DCC2C}"
    get_ripState(pwmprs)
      => ComCall(3, this.p, WMPRipState.Ptr, pwmprs)
    get_ripProgress(plProgress)
      => ComCall(4, this.p, Int32.Ptr, plProgress)
    startRip()
      => ComCall(5, this.p)
    stopRip()
      => ComCall(6, this.p)
}
struct IWMPCdromBurn extends IUnknown {
    static IID := "{BD94DBEB-417F-4928-AA06-087D56ED9B59}"
    isAvailable(bstrItem, pIsAvailable)
      => ComCall(3, this.p, BSTR, bstrItem, VARIANT_BOOL.Ptr, pIsAvailable)
    getItemInfo(bstrItem, pbstrVal)
      => ComCall(4, this.p, BSTR, bstrItem, BSTR.Ptr, pbstrVal)
    get_label(pbstrLabel)
      => ComCall(5, this.p, BSTR.Ptr, pbstrLabel)
    put_label(bstrLabel)
      => ComCall(6, this.p, BSTR, bstrLabel)
    get_burnFormat(pwmpbf)
      => ComCall(7, this.p, WMPBurnFormat.Ptr, pwmpbf)
    put_burnFormat(wmpbf)
      => ComCall(8, this.p, WMPBurnFormat, wmpbf)
    get_burnPlaylist(ppPlaylist)
      => ComCall(9, this.p, IWMPPlaylist.Ptr, ppPlaylist)
    put_burnPlaylist(pPlaylist)
      => ComCall(10, this.p, IWMPPlaylist, pPlaylist)
    refreshStatus()
      => ComCall(11, this.p)
    get_burnState(pwmpbs)
      => ComCall(12, this.p, WMPBurnState.Ptr, pwmpbs)
    get_burnProgress(plProgress)
      => ComCall(13, this.p, Int32.Ptr, plProgress)
    startBurn()
      => ComCall(14, this.p)
    stopBurn()
      => ComCall(15, this.p)
    erase()
      => ComCall(16, this.p)
}
struct IWMPQuery extends IDispatch {
    static IID := "{A00918F3-A6B0-4BFB-9189-FD834C7BC5A5}"
    addCondition(bstrAttribute, bstrOperator, bstrValue)
      => ComCall(7, this.p, BSTR, bstrAttribute, BSTR, bstrOperator, BSTR, bstrValue)
    beginNextGroup()
      => ComCall(8, this.p)
}
struct IWMPMediaCollection2 extends IWMPMediaCollection {
    static IID := "{8BA957F5-FD8C-4791-B82D-F840401EE474}"
    createQuery(ppQuery)
      => ComCall(19, this.p, IWMPQuery.Ptr, ppQuery)
    getPlaylistByQuery(pQuery, bstrMediaType, bstrSortAttribute, fSortAscending, ppPlaylist)
      => ComCall(20, this.p, IWMPQuery, pQuery, BSTR, bstrMediaType, BSTR, bstrSortAttribute, VARIANT_BOOL, fSortAscending, IWMPPlaylist.Ptr, ppPlaylist)
    getStringCollectionByQuery(bstrAttribute, pQuery, bstrMediaType, bstrSortAttribute, fSortAscending, ppStringCollection)
      => ComCall(21, this.p, BSTR, bstrAttribute, IWMPQuery, pQuery, BSTR, bstrMediaType, BSTR, bstrSortAttribute, VARIANT_BOOL, fSortAscending, IWMPStringCollection.Ptr, ppStringCollection)
    getByAttributeAndMediaType(bstrAttribute, bstrValue, bstrMediaType, ppMediaItems)
      => ComCall(22, this.p, BSTR, bstrAttribute, BSTR, bstrValue, BSTR, bstrMediaType, IWMPPlaylist.Ptr, ppMediaItems)
}
struct IWMPStringCollection2 extends IWMPStringCollection {
    static IID := "{46AD648D-53F1-4A74-92E2-2A1B68D63FD4}"
    isIdentical(pIWMPStringCollection2, pvbool)
      => ComCall(9, this.p, IWMPStringCollection2, pIWMPStringCollection2, VARIANT_BOOL.Ptr, pvbool)
    getItemInfo(lCollectionIndex, bstrItemName, pbstrValue)
      => ComCall(10, this.p, Int32, lCollectionIndex, BSTR, bstrItemName, BSTR.Ptr, pbstrValue)
    getAttributeCountByType(lCollectionIndex, bstrType, bstrLanguage, plCount)
      => ComCall(11, this.p, Int32, lCollectionIndex, BSTR, bstrType, BSTR, bstrLanguage, Int32.Ptr, plCount)
    getItemInfoByType(lCollectionIndex, bstrType, bstrLanguage, lAttributeIndex, pvarValue)
      => ComCall(12, this.p, Int32, lCollectionIndex, BSTR, bstrType, BSTR, bstrLanguage, Int32, lAttributeIndex, VARIANT.Ptr, pvarValue)
}
struct WMPLibraryType extends Int32 {
    static wmpltUnknown := 0
    static wmpltAll := 1
    static wmpltLocal := 2
    static wmpltRemote := 3
    static wmpltDisc := 4
    static wmpltPortableDevice := 5
}
struct IWMPLibrary extends IUnknown {
    static IID := "{3DF47861-7DF1-4C1F-A81B-4C26F0F7A7C6}"
    get_name(pbstrName)
      => ComCall(3, this.p, BSTR.Ptr, pbstrName)
    get_type(pwmplt)
      => ComCall(4, this.p, WMPLibraryType.Ptr, pwmplt)
    get_mediaCollection(ppIWMPMediaCollection)
      => ComCall(5, this.p, IWMPMediaCollection.Ptr, ppIWMPMediaCollection)
    isIdentical(pIWMPLibrary, pvbool)
      => ComCall(6, this.p, IWMPLibrary, pIWMPLibrary, VARIANT_BOOL.Ptr, pvbool)
}
struct IWMPLibraryServices extends IUnknown {
    static IID := "{39C2F8D5-1CF2-4D5E-AE09-D73492CF9EAA}"
    getCountByType(wmplt, plCount)
      => ComCall(3, this.p, WMPLibraryType, wmplt, Int32.Ptr, plCount)
    getLibraryByType(wmplt, lIndex, ppIWMPLibrary)
      => ComCall(4, this.p, WMPLibraryType, wmplt, Int32, lIndex, IWMPLibrary.Ptr, ppIWMPLibrary)
}
struct IWMPLibrarySharingServices extends IUnknown {
    static IID := "{82CBA86B-9F04-474B-A365-D6DD1466E541}"
    isLibraryShared(pvbShared)
      => ComCall(3, this.p, VARIANT_BOOL.Ptr, pvbShared)
    isLibrarySharingEnabled(pvbEnabled)
      => ComCall(4, this.p, VARIANT_BOOL.Ptr, pvbEnabled)
    showLibrarySharing()
      => ComCall(5, this.p)
}
struct WMPFolderScanState extends Int32 {
    static wmpfssUnknown := 0
    static wmpfssScanning := 1
    static wmpfssUpdating := 2
    static wmpfssStopped := 3
}
struct IWMPFolderMonitorServices extends IUnknown {
    static IID := "{788C8743-E57F-439D-A468-5BC77F2E59C6}"
    get_count(plCount)
      => ComCall(3, this.p, Int32.Ptr, plCount)
    item(lIndex, pbstrFolder)
      => ComCall(4, this.p, Int32, lIndex, BSTR.Ptr, pbstrFolder)
    add(bstrFolder)
      => ComCall(5, this.p, BSTR, bstrFolder)
    remove(lIndex)
      => ComCall(6, this.p, Int32, lIndex)
    get_scanState(pwmpfss)
      => ComCall(7, this.p, WMPFolderScanState.Ptr, pwmpfss)
    get_currentFolder(pbstrFolder)
      => ComCall(8, this.p, BSTR.Ptr, pbstrFolder)
    get_scannedFilesCount(plCount)
      => ComCall(9, this.p, Int32.Ptr, plCount)
    get_addedFilesCount(plCount)
      => ComCall(10, this.p, Int32.Ptr, plCount)
    get_updateProgress(plProgress)
      => ComCall(11, this.p, Int32.Ptr, plProgress)
    startScan()
      => ComCall(12, this.p)
    stopScan()
      => ComCall(13, this.p)
}
struct IWMPSyncDevice2 extends IWMPSyncDevice {
    static IID := "{88AFB4B2-140A-44D2-91E6-4543DA467CD1}"
    setItemInfo(bstrItemName, bstrVal)
      => ComCall(19, this.p, BSTR, bstrItemName, BSTR, bstrVal)
}
struct IWMPSyncDevice3 extends IWMPSyncDevice2 {
    static IID := "{B22C85F9-263C-4372-A0DA-B518DB9B4098}"
    estimateSyncSize(pNonRulePlaylist, pRulesPlaylist)
      => ComCall(20, this.p, IWMPPlaylist, pNonRulePlaylist, IWMPPlaylist, pRulesPlaylist)
    cancelEstimation()
      => ComCall(21, this.p)
}
struct IWMPLibrary2 extends IWMPLibrary {
    static IID := "{DD578A4E-79B1-426C-BF8F-3ADD9072500B}"
    getItemInfo(bstrItemName, pbstrVal)
      => ComCall(7, this.p, BSTR, bstrItemName, BSTR.Ptr, pbstrVal)
}
struct IWMPEvents extends IUnknown {
    static IID := "{19A6627B-DA9E-47C1-BB23-00B5E668236A}"
    OpenStateChange(NewState)
      => ComCall(3, this.p, Int32, NewState, "void")
    PlayStateChange(NewState)
      => ComCall(4, this.p, Int32, NewState, "void")
    AudioLanguageChange(LangID)
      => ComCall(5, this.p, Int32, LangID, "void")
    StatusChange()
      => ComCall(6, this.p, "void")
    ScriptCommand(scType, Param)
      => ComCall(7, this.p, BSTR, scType, BSTR, Param, "void")
    NewStream()
      => ComCall(8, this.p, "void")
    Disconnect(Result)
      => ComCall(9, this.p, Int32, Result, "void")
    Buffering(Start)
      => ComCall(10, this.p, VARIANT_BOOL, Start, "void")
    Error()
      => ComCall(11, this.p, "void")
    Warning(WarningType, Param, Description)
      => ComCall(12, this.p, Int32, WarningType, Int32, Param, BSTR, Description, "void")
    EndOfStream(Result)
      => ComCall(13, this.p, Int32, Result, "void")
    PositionChange(oldPosition, newPosition)
      => ComCall(14, this.p, Float64, oldPosition, Float64, newPosition, "void")
    MarkerHit(MarkerNum)
      => ComCall(15, this.p, Int32, MarkerNum, "void")
    DurationUnitChange(NewDurationUnit)
      => ComCall(16, this.p, Int32, NewDurationUnit, "void")
    CdromMediaChange(CdromNum)
      => ComCall(17, this.p, Int32, CdromNum, "void")
    PlaylistChange(Playlist, change)
      => ComCall(18, this.p, IDispatch, Playlist, WMPPlaylistChangeEventType, change, "void")
    CurrentPlaylistChange(change)
      => ComCall(19, this.p, WMPPlaylistChangeEventType, change, "void")
    CurrentPlaylistItemAvailable(bstrItemName)
      => ComCall(20, this.p, BSTR, bstrItemName, "void")
    MediaChange(Item)
      => ComCall(21, this.p, IDispatch, Item, "void")
    CurrentMediaItemAvailable(bstrItemName)
      => ComCall(22, this.p, BSTR, bstrItemName, "void")
    CurrentItemChange(pdispMedia)
      => ComCall(23, this.p, IDispatch, pdispMedia, "void")
    MediaCollectionChange()
      => ComCall(24, this.p, "void")
    MediaCollectionAttributeStringAdded(bstrAttribName, bstrAttribVal)
      => ComCall(25, this.p, BSTR, bstrAttribName, BSTR, bstrAttribVal, "void")
    MediaCollectionAttributeStringRemoved(bstrAttribName, bstrAttribVal)
      => ComCall(26, this.p, BSTR, bstrAttribName, BSTR, bstrAttribVal, "void")
    MediaCollectionAttributeStringChanged(bstrAttribName, bstrOldAttribVal, bstrNewAttribVal)
      => ComCall(27, this.p, BSTR, bstrAttribName, BSTR, bstrOldAttribVal, BSTR, bstrNewAttribVal, "void")
    PlaylistCollectionChange()
      => ComCall(28, this.p, "void")
    PlaylistCollectionPlaylistAdded(bstrPlaylistName)
      => ComCall(29, this.p, BSTR, bstrPlaylistName, "void")
    PlaylistCollectionPlaylistRemoved(bstrPlaylistName)
      => ComCall(30, this.p, BSTR, bstrPlaylistName, "void")
    PlaylistCollectionPlaylistSetAsDeleted(bstrPlaylistName, varfIsDeleted)
      => ComCall(31, this.p, BSTR, bstrPlaylistName, VARIANT_BOOL, varfIsDeleted, "void")
    ModeChange(ModeName, NewValue)
      => ComCall(32, this.p, BSTR, ModeName, VARIANT_BOOL, NewValue, "void")
    MediaError(pMediaObject)
      => ComCall(33, this.p, IDispatch, pMediaObject, "void")
    OpenPlaylistSwitch(pItem)
      => ComCall(34, this.p, IDispatch, pItem, "void")
    DomainChange(strDomain)
      => ComCall(35, this.p, BSTR, strDomain, "void")
    SwitchedToPlayerApplication()
      => ComCall(36, this.p, "void")
    SwitchedToControl()
      => ComCall(37, this.p, "void")
    PlayerDockedStateChange()
      => ComCall(38, this.p, "void")
    PlayerReconnect()
      => ComCall(39, this.p, "void")
    Click(nButton, nShiftState, fX, fY)
      => ComCall(40, this.p, Int16, nButton, Int16, nShiftState, Int32, fX, Int32, fY, "void")
    DoubleClick(nButton, nShiftState, fX, fY)
      => ComCall(41, this.p, Int16, nButton, Int16, nShiftState, Int32, fX, Int32, fY, "void")
    KeyDown(nKeyCode, nShiftState)
      => ComCall(42, this.p, Int16, nKeyCode, Int16, nShiftState, "void")
    KeyPress(nKeyAscii)
      => ComCall(43, this.p, Int16, nKeyAscii, "void")
    KeyUp(nKeyCode, nShiftState)
      => ComCall(44, this.p, Int16, nKeyCode, Int16, nShiftState, "void")
    MouseDown(nButton, nShiftState, fX, fY)
      => ComCall(45, this.p, Int16, nButton, Int16, nShiftState, Int32, fX, Int32, fY, "void")
    MouseMove(nButton, nShiftState, fX, fY)
      => ComCall(46, this.p, Int16, nButton, Int16, nShiftState, Int32, fX, Int32, fY, "void")
    MouseUp(nButton, nShiftState, fX, fY)
      => ComCall(47, this.p, Int16, nButton, Int16, nShiftState, Int32, fX, Int32, fY, "void")
}
struct IWMPEvents2 extends IWMPEvents {
    static IID := "{1E7601FA-47EA-4107-9EA9-9004ED9684FF}"
    DeviceConnect(pDevice)
      => ComCall(48, this.p, IWMPSyncDevice, pDevice, "void")
    DeviceDisconnect(pDevice)
      => ComCall(49, this.p, IWMPSyncDevice, pDevice, "void")
    DeviceStatusChange(pDevice, NewStatus)
      => ComCall(50, this.p, IWMPSyncDevice, pDevice, WMPDeviceStatus, NewStatus, "void")
    DeviceSyncStateChange(pDevice, NewState)
      => ComCall(51, this.p, IWMPSyncDevice, pDevice, WMPSyncState, NewState, "void")
    DeviceSyncError(pDevice, pMedia)
      => ComCall(52, this.p, IWMPSyncDevice, pDevice, IDispatch, pMedia, "void")
    CreatePartnershipComplete(pDevice, hrResult)
      => ComCall(53, this.p, IWMPSyncDevice, pDevice, HRESULT, hrResult, "void")
}
struct IWMPEvents3 extends IWMPEvents2 {
    static IID := "{1F504270-A66B-4223-8E96-26A06C63D69F}"
    CdromRipStateChange(pCdromRip, wmprs)
      => ComCall(54, this.p, IWMPCdromRip, pCdromRip, WMPRipState, wmprs, "void")
    CdromRipMediaError(pCdromRip, pMedia)
      => ComCall(55, this.p, IWMPCdromRip, pCdromRip, IDispatch, pMedia, "void")
    CdromBurnStateChange(pCdromBurn, wmpbs)
      => ComCall(56, this.p, IWMPCdromBurn, pCdromBurn, WMPBurnState, wmpbs, "void")
    CdromBurnMediaError(pCdromBurn, pMedia)
      => ComCall(57, this.p, IWMPCdromBurn, pCdromBurn, IDispatch, pMedia, "void")
    CdromBurnError(pCdromBurn, hrError)
      => ComCall(58, this.p, IWMPCdromBurn, pCdromBurn, HRESULT, hrError, "void")
    LibraryConnect(pLibrary)
      => ComCall(59, this.p, IWMPLibrary, pLibrary, "void")
    LibraryDisconnect(pLibrary)
      => ComCall(60, this.p, IWMPLibrary, pLibrary, "void")
    FolderScanStateChange(wmpfss)
      => ComCall(61, this.p, WMPFolderScanState, wmpfss, "void")
    StringCollectionChange(pdispStringCollection, change, lCollectionIndex)
      => ComCall(62, this.p, IDispatch, pdispStringCollection, WMPStringCollectionChangeEventType, change, Int32, lCollectionIndex, "void")
    MediaCollectionMediaAdded(pdispMedia)
      => ComCall(63, this.p, IDispatch, pdispMedia, "void")
    MediaCollectionMediaRemoved(pdispMedia)
      => ComCall(64, this.p, IDispatch, pdispMedia, "void")
}
struct IWMPEvents4 extends IWMPEvents3 {
    static IID := "{26DABCFA-306B-404D-9A6F-630A8405048D}"
    DeviceEstimation(pDevice, hrResult, qwEstimatedUsedSpace, qwEstimatedSpace)
      => ComCall(65, this.p, IWMPSyncDevice, pDevice, HRESULT, hrResult, Int64, qwEstimatedUsedSpace, Int64, qwEstimatedSpace, "void")
}
struct WMPOCXEvents extends IDispatch {
    static IID := "{6BF52A51-394A-11D3-B153-00C04F79FAA6}"
}
struct IWMPNodeRealEstate extends IUnknown {
    static IID := "{42751198-5A50-4460-BCB4-709F8BDC8E59}"
    GetDesiredSize(pSize)
      => ComCall(3, this.p, SIZE.Ptr, pSize)
    SetRects(pSrc, pDest, pClip)
      => ComCall(4, this.p, RECT.Ptr, pSrc, RECT.Ptr, pDest, RECT.Ptr, pClip)
    GetRects(pSrc, pDest, pClip)
      => ComCall(5, this.p, RECT.Ptr, pSrc, RECT.Ptr, pDest, RECT.Ptr, pClip)
    SetWindowless(fWindowless)
      => ComCall(6, this.p, BOOL, fWindowless)
    GetWindowless(pfWindowless)
      => ComCall(7, this.p, BOOL.Ptr, pfWindowless)
    SetFullScreen(fFullScreen)
      => ComCall(8, this.p, BOOL, fFullScreen)
    GetFullScreen(pfFullScreen)
      => ComCall(9, this.p, BOOL.Ptr, pfFullScreen)
}
struct IWMPNodeRealEstateHost extends IUnknown {
    static IID := "{1491087D-2C6B-44C8-B019-B3C929D2ADA9}"
    OnDesiredSizeChange(pSize)
      => ComCall(3, this.p, SIZE.Ptr, pSize)
    OnFullScreenTransition(fFullScreen)
      => ComCall(4, this.p, BOOL, fFullScreen)
}
struct IWMPNodeWindowed extends IUnknown {
    static IID := "{96740BFA-C56A-45D1-A3A4-762914D4ADE9}"
    SetOwnerWindow(hwnd)
      => ComCall(3, this.p, IntPtr, hwnd)
    GetOwnerWindow(phwnd)
      => ComCall(4, this.p, IntPtr.Ptr, phwnd)
}
struct IWMPNodeWindowedHost extends IUnknown {
    static IID := "{A300415A-54AA-4081-ADBF-3B13610D8958}"
    OnWindowMessageFromRenderer(uMsg, wparam1, lparam1, plRet, pfHandled)
      => ComCall(3, this.p, UInt32, uMsg, WPARAM, wparam1, LPARAM, lparam1, LRESULT.Ptr, plRet, BOOL.Ptr, pfHandled)
}
struct IWMPWindowMessageSink extends IUnknown {
    static IID := "{3A0DAA30-908D-4789-BA87-AED879B5C49B}"
    OnWindowMessage(uMsg, wparam1, lparam1, plRet, pfHandled)
      => ComCall(3, this.p, UInt32, uMsg, WPARAM, wparam1, LPARAM, lparam1, LRESULT.Ptr, plRet, BOOL.Ptr, pfHandled)
}
struct IWMPNodeWindowless extends IWMPWindowMessageSink {
    static IID := "{9B9199AD-780C-4EDA-B816-261EBA5D1575}"
    OnDraw(hdc, prcDraw)
      => ComCall(4, this.p, IntPtr, hdc, RECT.Ptr, prcDraw)
}
struct IWMPNodeWindowlessHost extends IUnknown {
    static IID := "{BE7017C6-CE34-4901-8106-770381AA6E3E}"
    InvalidateRect(prc, fErase)
      => ComCall(3, this.p, RECT.Ptr, prc, BOOL, fErase)
}
struct IWMPVideoRenderConfig extends IUnknown {
    static IID := "{6D6CF803-1EC0-4C8D-B3CA-F18E27282074}"
    put_presenterActivate(pActivate)
      => ComCall(3, this.p, IMFActivate, pActivate)
}
struct IWMPAudioRenderConfig extends IUnknown {
    static IID := "{E79C6349-5997-4CE4-917C-22A3391EC564}"
    get_audioOutputDevice(pbstrOutputDevice)
      => ComCall(3, this.p, BSTR.Ptr, pbstrOutputDevice)
    put_audioOutputDevice(bstrOutputDevice)
      => ComCall(4, this.p, BSTR, bstrOutputDevice)
}
struct IWMPRenderConfig extends IUnknown {
    static IID := "{959506C1-0314-4EC5-9E61-8528DB5E5478}"
    put_inProcOnly(fInProc)
      => ComCall(3, this.p, BOOL, fInProc)
    get_inProcOnly(pfInProc)
      => ComCall(4, this.p, BOOL.Ptr, pfInProc)
}
struct WMPServices_StreamState extends Int32 {
    static WMPServices_StreamState_Stop := 0
    static WMPServices_StreamState_Pause := 1
    static WMPServices_StreamState_Play := 2
}
struct IWMPServices extends IUnknown {
    static IID := "{AFB6B76B-1E20-4198-83B3-191DB6E0B149}"
    GetStreamTime(prt)
      => ComCall(3, this.p, Int64.Ptr, prt)
    GetStreamState(pState)
      => ComCall(4, this.p, WMPServices_StreamState.Ptr, pState)
}
struct IWMPMediaPluginRegistrar extends IUnknown {
    static IID := "{68E27045-05BD-40B2-9720-23088C78E390}"
    WMPRegisterPlayerPlugin(pwszFriendlyName, pwszDescription, pwszUninstallString, dwPriority, guidPluginType, clsid, cMediaTypes, pMediaTypes)
      => ComCall(3, this.p, "Str", pwszFriendlyName, "Str", pwszDescription, "Str", pwszUninstallString, UInt32, dwPriority, GUID, guidPluginType, GUID, clsid, UInt32, cMediaTypes, Struct.Ptr, pMediaTypes)
    WMPUnRegisterPlayerPlugin(guidPluginType, clsid)
      => ComCall(4, this.p, GUID, guidPluginType, GUID, clsid)
}
struct WMPPlugin_Caps extends Int32 {
    static WMPPlugin_Caps_CannotConvertFormats := 1
}
struct IWMPPlugin extends IUnknown {
    static IID := "{F1392A70-024C-42BB-A998-73DFDFE7D5A7}"
    Init(dwPlaybackContext)
      => ComCall(3, this.p, IntPtr, dwPlaybackContext)
    Shutdown()
      => ComCall(4, this.p)
    GetID(pGUID)
      => ComCall(5, this.p, GUID.Ptr, pGUID)
    GetCaps(pdwFlags)
      => ComCall(6, this.p, UInt32.Ptr, pdwFlags)
    AdviseWMPServices(pWMPServices)
      => ComCall(7, this.p, IWMPServices, pWMPServices)
    UnAdviseWMPServices()
      => ComCall(8, this.p)
}
struct IWMPPluginEnable extends IUnknown {
    static IID := "{5FCA444C-7AD1-479D-A4EF-40566A5309D6}"
    SetEnable(fEnable)
      => ComCall(3, this.p, BOOL, fEnable)
    GetEnable(pfEnable)
      => ComCall(4, this.p, BOOL.Ptr, pfEnable)
}
struct IWMPGraphCreation extends IUnknown {
    static IID := "{BFB377E5-C594-4369-A970-DE896D5ECE74}"
    GraphCreationPreRender(pFilterGraph, pReserved)
      => ComCall(3, this.p, IUnknown, pFilterGraph, IUnknown, pReserved)
    GraphCreationPostRender(pFilterGraph)
      => ComCall(4, this.p, IUnknown, pFilterGraph)
    GetGraphCreationFlags(pdwFlags)
      => ComCall(5, this.p, UInt32.Ptr, pdwFlags)
}
struct IWMPConvert extends IUnknown {
    static IID := "{D683162F-57D4-4108-8373-4A9676D1C2E9}"
    ConvertFile(bstrInputFile, bstrDestinationFolder, pbstrOutputFile)
      => ComCall(3, this.p, BSTR, bstrInputFile, BSTR, bstrDestinationFolder, BSTR.Ptr, pbstrOutputFile)
    GetErrorURL(pbstrURL)
      => ComCall(4, this.p, BSTR.Ptr, pbstrURL)
}
struct IWMPTranscodePolicy extends IUnknown {
    static IID := "{B64CBAC3-401C-4327-A3E8-B9FEB3A8C25C}"
    allowTranscode(pvbAllow)
      => ComCall(3, this.p, VARIANT_BOOL.Ptr, pvbAllow)
}
struct IWMPUserEventSink extends IUnknown {
    static IID := "{CFCCFA72-C343-48C3-A2DE-B7A4402E39F2}"
    NotifyUserEvent(EventCode)
      => ComCall(3, this.p, Int32, EventCode)
}
struct FEEDS_BACKGROUNDSYNC_ACTION extends Int32 {
    static FBSA_DISABLE := 0
    static FBSA_ENABLE := 1
    static FBSA_RUNNOW := 2
}
struct FEEDS_BACKGROUNDSYNC_STATUS extends Int32 {
    static FBSS_DISABLED := 0
    static FBSS_ENABLED := 1
}
struct FEEDS_EVENTS_SCOPE extends Int32 {
    static FES_ALL := 0
    static FES_SELF_ONLY := 1
    static FES_SELF_AND_CHILDREN_ONLY := 2
}
struct FEEDS_EVENTS_MASK extends Int32 {
    static FEM_FOLDEREVENTS := 1
    static FEM_FEEDEVENTS := 2
}
struct FEEDS_XML_SORT_PROPERTY extends Int32 {
    static FXSP_NONE := 0
    static FXSP_PUBDATE := 1
    static FXSP_DOWNLOADTIME := 2
}
struct FEEDS_XML_SORT_ORDER extends Int32 {
    static FXSO_NONE := 0
    static FXSO_ASCENDING := 1
    static FXSO_DESCENDING := 2
}
struct FEEDS_XML_FILTER_FLAGS extends Int32 {
    static FXFF_ALL := 0
    static FXFF_UNREAD := 1
    static FXFF_READ := 2
}
struct FEEDS_XML_INCLUDE_FLAGS extends Int32 {
    static FXIF_NONE := 0
    static FXIF_CF_EXTENSIONS := 1
}
struct FEEDS_DOWNLOAD_STATUS extends Int32 {
    static FDS_NONE := 0
    static FDS_PENDING := 1
    static FDS_DOWNLOADING := 2
    static FDS_DOWNLOADED := 3
    static FDS_DOWNLOAD_FAILED := 4
}
struct FEEDS_SYNC_SETTING extends Int32 {
    static FSS_DEFAULT := 0
    static FSS_INTERVAL := 1
    static FSS_MANUAL := 2
    static FSS_SUGGESTED := 3
}
struct FEEDS_DOWNLOAD_ERROR extends Int32 {
    static FDE_NONE := 0
    static FDE_DOWNLOAD_FAILED := 1
    static FDE_INVALID_FEED_FORMAT := 2
    static FDE_NORMALIZATION_FAILED := 3
    static FDE_PERSISTENCE_FAILED := 4
    static FDE_DOWNLOAD_BLOCKED := 5
    static FDE_CANCELED := 6
    static FDE_UNSUPPORTED_AUTH := 7
    static FDE_BACKGROUND_DOWNLOAD_DISABLED := 8
    static FDE_NOT_EXIST := 9
    static FDE_UNSUPPORTED_MSXML := 10
    static FDE_UNSUPPORTED_DTD := 11
    static FDE_DOWNLOAD_SIZE_LIMIT_EXCEEDED := 12
    static FDE_ACCESS_DENIED := 13
    static FDE_AUTH_FAILED := 14
    static FDE_INVALID_AUTH := 15
}
struct FEEDS_EVENTS_ITEM_COUNT_FLAGS extends Int32 {
    static FEICF_READ_ITEM_COUNT_CHANGED := 1
    static FEICF_UNREAD_ITEM_COUNT_CHANGED := 2
}
struct FEEDS_ERROR_CODE extends Int32 {
    static FEC_E_ERRORBASE := -1073479168
    static FEC_E_INVALIDMSXMLPROPERTY := -1073479168
    static FEC_E_DOWNLOADSIZELIMITEXCEEDED := -1073479167
}
struct IXFeedsManager extends IUnknown {
    static IID := "{5357E238-FB12-4ACA-A930-CAB7832B84BF}"
    RootFolder(riid, ppv)
      => ComCall(3, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    IsSubscribed(pszUrl, pbSubscribed)
      => ComCall(4, this.p, "Str", pszUrl, BOOL.Ptr, pbSubscribed)
    ExistsFeed(pszPath, pbFeedExists)
      => ComCall(5, this.p, "Str", pszPath, BOOL.Ptr, pbFeedExists)
    GetFeed(pszPath, riid, ppv)
      => ComCall(6, this.p, "Str", pszPath, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetFeedByUrl(pszUrl, riid, ppv)
      => ComCall(7, this.p, "Str", pszUrl, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    ExistsFolder(pszPath, pbFolderExists)
      => ComCall(8, this.p, "Str", pszPath, BOOL.Ptr, pbFolderExists)
    GetFolder(pszPath, riid, ppv)
      => ComCall(9, this.p, "Str", pszPath, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    DeleteFeed(pszPath)
      => ComCall(10, this.p, "Str", pszPath)
    DeleteFolder(pszPath)
      => ComCall(11, this.p, "Str", pszPath)
    BackgroundSync(fbsa)
      => ComCall(12, this.p, FEEDS_BACKGROUNDSYNC_ACTION, fbsa)
    BackgroundSyncStatus(pfbss)
      => ComCall(13, this.p, FEEDS_BACKGROUNDSYNC_STATUS.Ptr, pfbss)
    DefaultInterval(puiInterval)
      => ComCall(14, this.p, UInt32.Ptr, puiInterval)
    SetDefaultInterval(uiInterval)
      => ComCall(15, this.p, UInt32, uiInterval)
    AsyncSyncAll()
      => ComCall(16, this.p)
    Normalize(pStreamIn, ppStreamOut)
      => ComCall(17, this.p, IStream, pStreamIn, IStream.Ptr, ppStreamOut)
    ItemCountLimit(puiItemCountLimit)
      => ComCall(18, this.p, UInt32.Ptr, puiItemCountLimit)
}
struct IXFeedsEnum extends IUnknown {
    static IID := "{DC43A9D5-5015-4301-8C96-A47434B4D658}"
    Count(puiCount)
      => ComCall(3, this.p, UInt32.Ptr, puiCount)
    Item(uiIndex, riid, ppv)
      => ComCall(4, this.p, UInt32, uiIndex, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IXFeedFolder extends IUnknown {
    static IID := "{4C963678-3A51-4B88-8531-98B90B6508F2}"
    Feeds(ppfe)
      => ComCall(3, this.p, IXFeedsEnum.Ptr, ppfe)
    Subfolders(ppfe)
      => ComCall(4, this.p, IXFeedsEnum.Ptr, ppfe)
    CreateFeed(pszName, pszUrl, riid, ppv)
      => ComCall(5, this.p, "Str", pszName, "Str", pszUrl, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateSubfolder(pszName, riid, ppv)
      => ComCall(6, this.p, "Str", pszName, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    ExistsFeed(pszName, pbFeedExists)
      => ComCall(7, this.p, "Str", pszName, BOOL.Ptr, pbFeedExists)
    ExistsSubfolder(pszName, pbSubfolderExists)
      => ComCall(8, this.p, "Str", pszName, BOOL.Ptr, pbSubfolderExists)
    GetFeed(pszName, riid, ppv)
      => ComCall(9, this.p, "Str", pszName, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    GetSubfolder(pszName, riid, ppv)
      => ComCall(10, this.p, "Str", pszName, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    Delete()
      => ComCall(11, this.p)
    Name(ppszName)
      => ComCall(12, this.p, PWSTR.Ptr, ppszName)
    Rename(pszName)
      => ComCall(13, this.p, "Str", pszName)
    Path(ppszPath)
      => ComCall(14, this.p, PWSTR.Ptr, ppszPath)
    Move(pszPath)
      => ComCall(15, this.p, "Str", pszPath)
    Parent(riid, ppv)
      => ComCall(16, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    IsRoot(pbIsRootFeedFolder)
      => ComCall(17, this.p, BOOL.Ptr, pbIsRootFeedFolder)
    GetWatcher(scope, mask, riid, ppv)
      => ComCall(18, this.p, FEEDS_EVENTS_SCOPE, scope, FEEDS_EVENTS_MASK, mask, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    TotalUnreadItemCount(puiTotalUnreadItemCount)
      => ComCall(19, this.p, UInt32.Ptr, puiTotalUnreadItemCount)
    TotalItemCount(puiTotalItemCount)
      => ComCall(20, this.p, UInt32.Ptr, puiTotalItemCount)
}
struct IXFeedFolderEvents extends IUnknown {
    static IID := "{7964B769-234A-4BB1-A5F4-90454C8AD07E}"
    Error()
      => ComCall(3, this.p)
    FolderAdded(pszPath)
      => ComCall(4, this.p, "Str", pszPath)
    FolderDeleted(pszPath)
      => ComCall(5, this.p, "Str", pszPath)
    FolderRenamed(pszPath, pszOldPath)
      => ComCall(6, this.p, "Str", pszPath, "Str", pszOldPath)
    FolderMovedFrom(pszPath, pszOldPath)
      => ComCall(7, this.p, "Str", pszPath, "Str", pszOldPath)
    FolderMovedTo(pszPath, pszOldPath)
      => ComCall(8, this.p, "Str", pszPath, "Str", pszOldPath)
    FolderItemCountChanged(pszPath, feicfFlags)
      => ComCall(9, this.p, "Str", pszPath, Int32, feicfFlags)
    FeedAdded(pszPath)
      => ComCall(10, this.p, "Str", pszPath)
    FeedDeleted(pszPath)
      => ComCall(11, this.p, "Str", pszPath)
    FeedRenamed(pszPath, pszOldPath)
      => ComCall(12, this.p, "Str", pszPath, "Str", pszOldPath)
    FeedUrlChanged(pszPath)
      => ComCall(13, this.p, "Str", pszPath)
    FeedMovedFrom(pszPath, pszOldPath)
      => ComCall(14, this.p, "Str", pszPath, "Str", pszOldPath)
    FeedMovedTo(pszPath, pszOldPath)
      => ComCall(15, this.p, "Str", pszPath, "Str", pszOldPath)
    FeedDownloading(pszPath)
      => ComCall(16, this.p, "Str", pszPath)
    FeedDownloadCompleted(pszPath, fde)
      => ComCall(17, this.p, "Str", pszPath, FEEDS_DOWNLOAD_ERROR, fde)
    FeedItemCountChanged(pszPath, feicfFlags)
      => ComCall(18, this.p, "Str", pszPath, Int32, feicfFlags)
}
struct IXFeed extends IUnknown {
    static IID := "{A44179A4-E0F6-403B-AF8D-D080F425A451}"
    Xml(uiItemCount, sortProperty, sortOrder, filterFlags, includeFlags, pps)
      => ComCall(3, this.p, UInt32, uiItemCount, FEEDS_XML_SORT_PROPERTY, sortProperty, FEEDS_XML_SORT_ORDER, sortOrder, FEEDS_XML_FILTER_FLAGS, filterFlags, FEEDS_XML_INCLUDE_FLAGS, includeFlags, IStream.Ptr, pps)
    Name(ppszName)
      => ComCall(4, this.p, PWSTR.Ptr, ppszName)
    Rename(pszName)
      => ComCall(5, this.p, "Str", pszName)
    Url(ppszUrl)
      => ComCall(6, this.p, PWSTR.Ptr, ppszUrl)
    SetUrl(pszUrl)
      => ComCall(7, this.p, "Str", pszUrl)
    LocalId(pguid)
      => ComCall(8, this.p, GUID.Ptr, pguid)
    Path(ppszPath)
      => ComCall(9, this.p, PWSTR.Ptr, ppszPath)
    Move(pszPath)
      => ComCall(10, this.p, "Str", pszPath)
    Parent(riid, ppv)
      => ComCall(11, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    LastWriteTime(pstLastWriteTime)
      => ComCall(12, this.p, SYSTEMTIME.Ptr, pstLastWriteTime)
    Delete()
      => ComCall(13, this.p)
    Download()
      => ComCall(14, this.p)
    AsyncDownload()
      => ComCall(15, this.p)
    CancelAsyncDownload()
      => ComCall(16, this.p)
    SyncSetting(pfss)
      => ComCall(17, this.p, FEEDS_SYNC_SETTING.Ptr, pfss)
    SetSyncSetting(fss)
      => ComCall(18, this.p, FEEDS_SYNC_SETTING, fss)
    Interval(puiInterval)
      => ComCall(19, this.p, UInt32.Ptr, puiInterval)
    SetInterval(uiInterval)
      => ComCall(20, this.p, UInt32, uiInterval)
    LastDownloadTime(pstLastDownloadTime)
      => ComCall(21, this.p, SYSTEMTIME.Ptr, pstLastDownloadTime)
    LocalEnclosurePath(ppszPath)
      => ComCall(22, this.p, PWSTR.Ptr, ppszPath)
    Items(ppfe)
      => ComCall(23, this.p, IXFeedsEnum.Ptr, ppfe)
    GetItem(uiId, riid, ppv)
      => ComCall(24, this.p, UInt32, uiId, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    MarkAllItemsRead()
      => ComCall(25, this.p)
    MaxItemCount(puiMaxItemCount)
      => ComCall(26, this.p, UInt32.Ptr, puiMaxItemCount)
    SetMaxItemCount(uiMaxItemCount)
      => ComCall(27, this.p, UInt32, uiMaxItemCount)
    DownloadEnclosuresAutomatically(pbDownloadEnclosuresAutomatically)
      => ComCall(28, this.p, BOOL.Ptr, pbDownloadEnclosuresAutomatically)
    SetDownloadEnclosuresAutomatically(bDownloadEnclosuresAutomatically)
      => ComCall(29, this.p, BOOL, bDownloadEnclosuresAutomatically)
    DownloadStatus(pfds)
      => ComCall(30, this.p, FEEDS_DOWNLOAD_STATUS.Ptr, pfds)
    LastDownloadError(pfde)
      => ComCall(31, this.p, FEEDS_DOWNLOAD_ERROR.Ptr, pfde)
    Merge(pStream, pszUrl)
      => ComCall(32, this.p, IStream, pStream, "Str", pszUrl)
    DownloadUrl(ppszUrl)
      => ComCall(33, this.p, PWSTR.Ptr, ppszUrl)
    Title(ppszTitle)
      => ComCall(34, this.p, PWSTR.Ptr, ppszTitle)
    Description(ppszDescription)
      => ComCall(35, this.p, PWSTR.Ptr, ppszDescription)
    Link(ppszHomePage)
      => ComCall(36, this.p, PWSTR.Ptr, ppszHomePage)
    Image(ppszImageUrl)
      => ComCall(37, this.p, PWSTR.Ptr, ppszImageUrl)
    LastBuildDate(pstLastBuildDate)
      => ComCall(38, this.p, SYSTEMTIME.Ptr, pstLastBuildDate)
    PubDate(pstPubDate)
      => ComCall(39, this.p, SYSTEMTIME.Ptr, pstPubDate)
    Ttl(puiTtl)
      => ComCall(40, this.p, UInt32.Ptr, puiTtl)
    Language(ppszLanguage)
      => ComCall(41, this.p, PWSTR.Ptr, ppszLanguage)
    Copyright(ppszCopyright)
      => ComCall(42, this.p, PWSTR.Ptr, ppszCopyright)
    IsList(pbIsList)
      => ComCall(43, this.p, BOOL.Ptr, pbIsList)
    GetWatcher(scope, mask, riid, ppv)
      => ComCall(44, this.p, FEEDS_EVENTS_SCOPE, scope, FEEDS_EVENTS_MASK, mask, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    UnreadItemCount(puiUnreadItemCount)
      => ComCall(45, this.p, UInt32.Ptr, puiUnreadItemCount)
    ItemCount(puiItemCount)
      => ComCall(46, this.p, UInt32.Ptr, puiItemCount)
}
struct IXFeed2 extends IXFeed {
    static IID := "{CE528E77-3716-4EB7-956D-F5E37502E12A}"
    GetItemByEffectiveId(uiEffectiveId, riid, ppv)
      => ComCall(47, this.p, UInt32, uiEffectiveId, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    LastItemDownloadTime(pstLastItemDownloadTime)
      => ComCall(48, this.p, SYSTEMTIME.Ptr, pstLastItemDownloadTime)
    Username(ppszUsername)
      => ComCall(49, this.p, PWSTR.Ptr, ppszUsername)
    Password(ppszPassword)
      => ComCall(50, this.p, PWSTR.Ptr, ppszPassword)
    SetCredentials(pszUsername, pszPassword)
      => ComCall(51, this.p, "Str", pszUsername, "Str", pszPassword)
    ClearCredentials()
      => ComCall(52, this.p)
}
struct IXFeedEvents extends IUnknown {
    static IID := "{1630852E-1263-465B-98E5-FE60FFEC4AC2}"
    Error()
      => ComCall(3, this.p)
    FeedDeleted(pszPath)
      => ComCall(4, this.p, "Str", pszPath)
    FeedRenamed(pszPath, pszOldPath)
      => ComCall(5, this.p, "Str", pszPath, "Str", pszOldPath)
    FeedUrlChanged(pszPath)
      => ComCall(6, this.p, "Str", pszPath)
    FeedMoved(pszPath, pszOldPath)
      => ComCall(7, this.p, "Str", pszPath, "Str", pszOldPath)
    FeedDownloading(pszPath)
      => ComCall(8, this.p, "Str", pszPath)
    FeedDownloadCompleted(pszPath, fde)
      => ComCall(9, this.p, "Str", pszPath, FEEDS_DOWNLOAD_ERROR, fde)
    FeedItemCountChanged(pszPath, feicfFlags)
      => ComCall(10, this.p, "Str", pszPath, Int32, feicfFlags)
}
struct IXFeedItem extends IUnknown {
    static IID := "{E757B2F5-E73E-434E-A1BF-2BD7C3E60FCB}"
    Xml(fxif, pps)
      => ComCall(3, this.p, FEEDS_XML_INCLUDE_FLAGS, fxif, IStream.Ptr, pps)
    Title(ppszTitle)
      => ComCall(4, this.p, PWSTR.Ptr, ppszTitle)
    Link(ppszUrl)
      => ComCall(5, this.p, PWSTR.Ptr, ppszUrl)
    Guid(ppszGuid)
      => ComCall(6, this.p, PWSTR.Ptr, ppszGuid)
    Description(ppszDescription)
      => ComCall(7, this.p, PWSTR.Ptr, ppszDescription)
    PubDate(pstPubDate)
      => ComCall(8, this.p, SYSTEMTIME.Ptr, pstPubDate)
    Comments(ppszUrl)
      => ComCall(9, this.p, PWSTR.Ptr, ppszUrl)
    Author(ppszAuthor)
      => ComCall(10, this.p, PWSTR.Ptr, ppszAuthor)
    Enclosure(riid, ppv)
      => ComCall(11, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    IsRead(pbIsRead)
      => ComCall(12, this.p, BOOL.Ptr, pbIsRead)
    SetIsRead(bIsRead)
      => ComCall(13, this.p, BOOL, bIsRead)
    LocalId(puiId)
      => ComCall(14, this.p, UInt32.Ptr, puiId)
    Parent(riid, ppv)
      => ComCall(15, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    Delete()
      => ComCall(16, this.p)
    DownloadUrl(ppszUrl)
      => ComCall(17, this.p, PWSTR.Ptr, ppszUrl)
    LastDownloadTime(pstLastDownloadTime)
      => ComCall(18, this.p, SYSTEMTIME.Ptr, pstLastDownloadTime)
    Modified(pstModifiedTime)
      => ComCall(19, this.p, SYSTEMTIME.Ptr, pstModifiedTime)
}
struct IXFeedItem2 extends IXFeedItem {
    static IID := "{6CDA2DC7-9013-4522-9970-2A9DD9EAD5A3}"
    EffectiveId(puiEffectiveId)
      => ComCall(20, this.p, UInt32.Ptr, puiEffectiveId)
}
struct IXFeedEnclosure extends IUnknown {
    static IID := "{BFBFB953-644F-4792-B69C-DFACA4CBF89A}"
    Url(ppszUrl)
      => ComCall(3, this.p, PWSTR.Ptr, ppszUrl)
    Type(ppszMimeType)
      => ComCall(4, this.p, PWSTR.Ptr, ppszMimeType)
    Length(puiLength)
      => ComCall(5, this.p, UInt32.Ptr, puiLength)
    AsyncDownload()
      => ComCall(6, this.p)
    CancelAsyncDownload()
      => ComCall(7, this.p)
    DownloadStatus(pfds)
      => ComCall(8, this.p, FEEDS_DOWNLOAD_STATUS.Ptr, pfds)
    LastDownloadError(pfde)
      => ComCall(9, this.p, FEEDS_DOWNLOAD_ERROR.Ptr, pfde)
    LocalPath(ppszPath)
      => ComCall(10, this.p, PWSTR.Ptr, ppszPath)
    Parent(riid, ppv)
      => ComCall(11, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    DownloadUrl(ppszUrl)
      => ComCall(12, this.p, PWSTR.Ptr, ppszUrl)
    DownloadMimeType(ppszMimeType)
      => ComCall(13, this.p, PWSTR.Ptr, ppszMimeType)
    RemoveFile()
      => ComCall(14, this.p)
    SetFile(pszDownloadUrl, pszDownloadFilePath, pszDownloadMimeType, pszEnclosureFilename)
      => ComCall(15, this.p, "Str", pszDownloadUrl, "Str", pszDownloadFilePath, "Str", pszDownloadMimeType, "Str", pszEnclosureFilename)
}
struct IFeedsManager extends IDispatch {
    static IID := "{A74029CC-1F1A-4906-88F0-810638D86591}"
    get_RootFolder(disp)
      => ComCall(7, this.p, IDispatch.Ptr, disp)
    IsSubscribed(feedUrl, subscribed)
      => ComCall(8, this.p, BSTR, feedUrl, VARIANT_BOOL.Ptr, subscribed)
    ExistsFeed(feedPath, exists)
      => ComCall(9, this.p, BSTR, feedPath, VARIANT_BOOL.Ptr, exists)
    GetFeed(feedPath, disp)
      => ComCall(10, this.p, BSTR, feedPath, IDispatch.Ptr, disp)
    GetFeedByUrl(feedUrl, disp)
      => ComCall(11, this.p, BSTR, feedUrl, IDispatch.Ptr, disp)
    ExistsFolder(folderPath, exists)
      => ComCall(12, this.p, BSTR, folderPath, VARIANT_BOOL.Ptr, exists)
    GetFolder(folderPath, disp)
      => ComCall(13, this.p, BSTR, folderPath, IDispatch.Ptr, disp)
    DeleteFeed(feedPath)
      => ComCall(14, this.p, BSTR, feedPath)
    DeleteFolder(folderPath)
      => ComCall(15, this.p, BSTR, folderPath)
    BackgroundSync(action)
      => ComCall(16, this.p, FEEDS_BACKGROUNDSYNC_ACTION, action)
    get_BackgroundSyncStatus(status)
      => ComCall(17, this.p, FEEDS_BACKGROUNDSYNC_STATUS.Ptr, status)
    get_DefaultInterval(minutes)
      => ComCall(18, this.p, Int32.Ptr, minutes)
    put_DefaultInterval(minutes)
      => ComCall(19, this.p, Int32, minutes)
    AsyncSyncAll()
      => ComCall(20, this.p)
    Normalize(feedXmlIn, feedXmlOut)
      => ComCall(21, this.p, BSTR, feedXmlIn, BSTR.Ptr, feedXmlOut)
    get_ItemCountLimit(itemCountLimit)
      => ComCall(22, this.p, Int32.Ptr, itemCountLimit)
}
struct IFeedsEnum extends IDispatch {
    static IID := "{E3CD0028-2EED-4C60-8FAE-A3225309A836}"
    get_Count(count)
      => ComCall(7, this.p, Int32.Ptr, count)
    Item(index, disp)
      => ComCall(8, this.p, Int32, index, IDispatch.Ptr, disp)
    get__NewEnum(enumVar)
      => ComCall(9, this.p, IEnumVARIANT.Ptr, enumVar)
}
struct IFeedFolder extends IDispatch {
    static IID := "{81F04AD1-4194-4D7D-86D6-11813CEC163C}"
    get_Feeds(disp)
      => ComCall(7, this.p, IDispatch.Ptr, disp)
    get_Subfolders(disp)
      => ComCall(8, this.p, IDispatch.Ptr, disp)
    CreateFeed(feedName, feedUrl, disp)
      => ComCall(9, this.p, BSTR, feedName, BSTR, feedUrl, IDispatch.Ptr, disp)
    CreateSubfolder(folderName, disp)
      => ComCall(10, this.p, BSTR, folderName, IDispatch.Ptr, disp)
    ExistsFeed(feedName, exists)
      => ComCall(11, this.p, BSTR, feedName, VARIANT_BOOL.Ptr, exists)
    GetFeed(feedName, disp)
      => ComCall(12, this.p, BSTR, feedName, IDispatch.Ptr, disp)
    ExistsSubfolder(folderName, exists)
      => ComCall(13, this.p, BSTR, folderName, VARIANT_BOOL.Ptr, exists)
    GetSubfolder(folderName, disp)
      => ComCall(14, this.p, BSTR, folderName, IDispatch.Ptr, disp)
    Delete()
      => ComCall(15, this.p)
    get_Name(folderName)
      => ComCall(16, this.p, BSTR.Ptr, folderName)
    Rename(folderName)
      => ComCall(17, this.p, BSTR, folderName)
    get_Path(folderPath)
      => ComCall(18, this.p, BSTR.Ptr, folderPath)
    Move(newParentPath)
      => ComCall(19, this.p, BSTR, newParentPath)
    get_Parent(disp)
      => ComCall(20, this.p, IDispatch.Ptr, disp)
    get_IsRoot(isRoot)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, isRoot)
    get_TotalUnreadItemCount(count)
      => ComCall(22, this.p, Int32.Ptr, count)
    get_TotalItemCount(count)
      => ComCall(23, this.p, Int32.Ptr, count)
    GetWatcher(scope, mask, disp)
      => ComCall(24, this.p, FEEDS_EVENTS_SCOPE, scope, FEEDS_EVENTS_MASK, mask, IDispatch.Ptr, disp)
}
struct IFeedFolderEvents extends IDispatch {
    static IID := "{20A59FA6-A844-4630-9E98-175F70B4D55B}"
    Error()
      => ComCall(7, this.p)
    FolderAdded(path)
      => ComCall(8, this.p, BSTR, path)
    FolderDeleted(path)
      => ComCall(9, this.p, BSTR, path)
    FolderRenamed(path, oldPath)
      => ComCall(10, this.p, BSTR, path, BSTR, oldPath)
    FolderMovedFrom(path, oldPath)
      => ComCall(11, this.p, BSTR, path, BSTR, oldPath)
    FolderMovedTo(path, oldPath)
      => ComCall(12, this.p, BSTR, path, BSTR, oldPath)
    FolderItemCountChanged(path, itemCountType)
      => ComCall(13, this.p, BSTR, path, Int32, itemCountType)
    FeedAdded(path)
      => ComCall(14, this.p, BSTR, path)
    FeedDeleted(path)
      => ComCall(15, this.p, BSTR, path)
    FeedRenamed(path, oldPath)
      => ComCall(16, this.p, BSTR, path, BSTR, oldPath)
    FeedUrlChanged(path)
      => ComCall(17, this.p, BSTR, path)
    FeedMovedFrom(path, oldPath)
      => ComCall(18, this.p, BSTR, path, BSTR, oldPath)
    FeedMovedTo(path, oldPath)
      => ComCall(19, this.p, BSTR, path, BSTR, oldPath)
    FeedDownloading(path)
      => ComCall(20, this.p, BSTR, path)
    FeedDownloadCompleted(path, error)
      => ComCall(21, this.p, BSTR, path, FEEDS_DOWNLOAD_ERROR, error)
    FeedItemCountChanged(path, itemCountType)
      => ComCall(22, this.p, BSTR, path, Int32, itemCountType)
}
struct IFeed extends IDispatch {
    static IID := "{F7F915D8-2EDE-42BC-98E7-A5D05063A757}"
    Xml(count, sortProperty, sortOrder, filterFlags, includeFlags, xml)
      => ComCall(7, this.p, Int32, count, FEEDS_XML_SORT_PROPERTY, sortProperty, FEEDS_XML_SORT_ORDER, sortOrder, FEEDS_XML_FILTER_FLAGS, filterFlags, FEEDS_XML_INCLUDE_FLAGS, includeFlags, BSTR.Ptr, xml)
    get_Name(name)
      => ComCall(8, this.p, BSTR.Ptr, name)
    Rename(name)
      => ComCall(9, this.p, BSTR, name)
    get_Url(feedUrl)
      => ComCall(10, this.p, BSTR.Ptr, feedUrl)
    put_Url(feedUrl)
      => ComCall(11, this.p, BSTR, feedUrl)
    get_LocalId(feedGuid)
      => ComCall(12, this.p, BSTR.Ptr, feedGuid)
    get_Path(path)
      => ComCall(13, this.p, BSTR.Ptr, path)
    Move(newParentPath)
      => ComCall(14, this.p, BSTR, newParentPath)
    get_Parent(disp)
      => ComCall(15, this.p, IDispatch.Ptr, disp)
    get_LastWriteTime(lastWrite)
      => ComCall(16, this.p, Float64.Ptr, lastWrite)
    Delete()
      => ComCall(17, this.p)
    Download()
      => ComCall(18, this.p)
    AsyncDownload()
      => ComCall(19, this.p)
    CancelAsyncDownload()
      => ComCall(20, this.p)
    get_SyncSetting(syncSetting)
      => ComCall(21, this.p, FEEDS_SYNC_SETTING.Ptr, syncSetting)
    put_SyncSetting(syncSetting)
      => ComCall(22, this.p, FEEDS_SYNC_SETTING, syncSetting)
    get_Interval(minutes)
      => ComCall(23, this.p, Int32.Ptr, minutes)
    put_Interval(minutes)
      => ComCall(24, this.p, Int32, minutes)
    get_LastDownloadTime(lastDownload)
      => ComCall(25, this.p, Float64.Ptr, lastDownload)
    get_LocalEnclosurePath(path)
      => ComCall(26, this.p, BSTR.Ptr, path)
    get_Items(disp)
      => ComCall(27, this.p, IDispatch.Ptr, disp)
    GetItem(itemId, disp)
      => ComCall(28, this.p, Int32, itemId, IDispatch.Ptr, disp)
    get_Title(title)
      => ComCall(29, this.p, BSTR.Ptr, title)
    get_Description(description)
      => ComCall(30, this.p, BSTR.Ptr, description)
    get_Link(homePage)
      => ComCall(31, this.p, BSTR.Ptr, homePage)
    get_Image(imageUrl)
      => ComCall(32, this.p, BSTR.Ptr, imageUrl)
    get_LastBuildDate(lastBuildDate)
      => ComCall(33, this.p, Float64.Ptr, lastBuildDate)
    get_PubDate(lastPopulateDate)
      => ComCall(34, this.p, Float64.Ptr, lastPopulateDate)
    get_Ttl(ttl)
      => ComCall(35, this.p, Int32.Ptr, ttl)
    get_Language(language)
      => ComCall(36, this.p, BSTR.Ptr, language)
    get_Copyright(copyright)
      => ComCall(37, this.p, BSTR.Ptr, copyright)
    get_MaxItemCount(count)
      => ComCall(38, this.p, Int32.Ptr, count)
    put_MaxItemCount(count)
      => ComCall(39, this.p, Int32, count)
    get_DownloadEnclosuresAutomatically(downloadEnclosuresAutomatically)
      => ComCall(40, this.p, VARIANT_BOOL.Ptr, downloadEnclosuresAutomatically)
    put_DownloadEnclosuresAutomatically(downloadEnclosuresAutomatically)
      => ComCall(41, this.p, VARIANT_BOOL, downloadEnclosuresAutomatically)
    get_DownloadStatus(status)
      => ComCall(42, this.p, FEEDS_DOWNLOAD_STATUS.Ptr, status)
    get_LastDownloadError(error)
      => ComCall(43, this.p, FEEDS_DOWNLOAD_ERROR.Ptr, error)
    Merge(feedXml, feedUrl)
      => ComCall(44, this.p, BSTR, feedXml, BSTR, feedUrl)
    get_DownloadUrl(feedUrl)
      => ComCall(45, this.p, BSTR.Ptr, feedUrl)
    get_IsList(isList)
      => ComCall(46, this.p, VARIANT_BOOL.Ptr, isList)
    MarkAllItemsRead()
      => ComCall(47, this.p)
    GetWatcher(scope, mask, disp)
      => ComCall(48, this.p, FEEDS_EVENTS_SCOPE, scope, FEEDS_EVENTS_MASK, mask, IDispatch.Ptr, disp)
    get_UnreadItemCount(count)
      => ComCall(49, this.p, Int32.Ptr, count)
    get_ItemCount(count)
      => ComCall(50, this.p, Int32.Ptr, count)
}
struct IFeed2 extends IFeed {
    static IID := "{33F2EA09-1398-4AB9-B6A4-F94B49D0A42E}"
    GetItemByEffectiveId(itemEffectiveId, disp)
      => ComCall(51, this.p, Int32, itemEffectiveId, IDispatch.Ptr, disp)
    get_LastItemDownloadTime(lastItemDownloadTime)
      => ComCall(52, this.p, Float64.Ptr, lastItemDownloadTime)
    get_Username(username)
      => ComCall(53, this.p, BSTR.Ptr, username)
    get_Password(password)
      => ComCall(54, this.p, BSTR.Ptr, password)
    SetCredentials(username, password)
      => ComCall(55, this.p, BSTR, username, BSTR, password)
    ClearCredentials()
      => ComCall(56, this.p)
}
struct IFeedEvents extends IDispatch {
    static IID := "{ABF35C99-0681-47EA-9A8C-1436A375A99E}"
    Error()
      => ComCall(7, this.p)
    FeedDeleted(path)
      => ComCall(8, this.p, BSTR, path)
    FeedRenamed(path, oldPath)
      => ComCall(9, this.p, BSTR, path, BSTR, oldPath)
    FeedUrlChanged(path)
      => ComCall(10, this.p, BSTR, path)
    FeedMoved(path, oldPath)
      => ComCall(11, this.p, BSTR, path, BSTR, oldPath)
    FeedDownloading(path)
      => ComCall(12, this.p, BSTR, path)
    FeedDownloadCompleted(path, error)
      => ComCall(13, this.p, BSTR, path, FEEDS_DOWNLOAD_ERROR, error)
    FeedItemCountChanged(path, itemCountType)
      => ComCall(14, this.p, BSTR, path, Int32, itemCountType)
}
struct IFeedItem extends IDispatch {
    static IID := "{0A1E6CAD-0A47-4DA2-A13D-5BAAA5C8BD4F}"
    Xml(includeFlags, xml)
      => ComCall(7, this.p, FEEDS_XML_INCLUDE_FLAGS, includeFlags, BSTR.Ptr, xml)
    get_Title(title)
      => ComCall(8, this.p, BSTR.Ptr, title)
    get_Link(linkUrl)
      => ComCall(9, this.p, BSTR.Ptr, linkUrl)
    get_Guid(itemGuid)
      => ComCall(10, this.p, BSTR.Ptr, itemGuid)
    get_Description(description)
      => ComCall(11, this.p, BSTR.Ptr, description)
    get_PubDate(pubDate)
      => ComCall(12, this.p, Float64.Ptr, pubDate)
    get_Comments(comments)
      => ComCall(13, this.p, BSTR.Ptr, comments)
    get_Author(author)
      => ComCall(14, this.p, BSTR.Ptr, author)
    get_Enclosure(disp)
      => ComCall(15, this.p, IDispatch.Ptr, disp)
    get_IsRead(isRead)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, isRead)
    put_IsRead(isRead)
      => ComCall(17, this.p, VARIANT_BOOL, isRead)
    get_LocalId(itemId)
      => ComCall(18, this.p, Int32.Ptr, itemId)
    get_Parent(disp)
      => ComCall(19, this.p, IDispatch.Ptr, disp)
    Delete()
      => ComCall(20, this.p)
    get_DownloadUrl(itemUrl)
      => ComCall(21, this.p, BSTR.Ptr, itemUrl)
    get_LastDownloadTime(lastDownload)
      => ComCall(22, this.p, Float64.Ptr, lastDownload)
    get_Modified(modified)
      => ComCall(23, this.p, Float64.Ptr, modified)
}
struct IFeedItem2 extends IFeedItem {
    static IID := "{79AC9EF4-F9C1-4D2B-A50B-A7FFBA4DCF37}"
    get_EffectiveId(effectiveId)
      => ComCall(24, this.p, Int32.Ptr, effectiveId)
}
struct IFeedEnclosure extends IDispatch {
    static IID := "{361C26F7-90A4-4E67-AE09-3A36A546436A}"
    get_Url(enclosureUrl)
      => ComCall(7, this.p, BSTR.Ptr, enclosureUrl)
    get_Type(mimeType)
      => ComCall(8, this.p, BSTR.Ptr, mimeType)
    get_Length(length)
      => ComCall(9, this.p, Int32.Ptr, length)
    AsyncDownload()
      => ComCall(10, this.p)
    CancelAsyncDownload()
      => ComCall(11, this.p)
    get_DownloadStatus(status)
      => ComCall(12, this.p, FEEDS_DOWNLOAD_STATUS.Ptr, status)
    get_LastDownloadError(error)
      => ComCall(13, this.p, FEEDS_DOWNLOAD_ERROR.Ptr, error)
    get_LocalPath(localPath)
      => ComCall(14, this.p, BSTR.Ptr, localPath)
    get_Parent(disp)
      => ComCall(15, this.p, IDispatch.Ptr, disp)
    get_DownloadUrl(enclosureUrl)
      => ComCall(16, this.p, BSTR.Ptr, enclosureUrl)
    get_DownloadMimeType(mimeType)
      => ComCall(17, this.p, BSTR.Ptr, mimeType)
    RemoveFile()
      => ComCall(18, this.p)
    SetFile(downloadUrl, downloadFilePath, downloadMimeType, enclosureFilename)
      => ComCall(19, this.p, BSTR, downloadUrl, BSTR, downloadFilePath, BSTR, downloadMimeType, BSTR, enclosureFilename)
}
struct PlayerState extends Int32 {
    static stop_state := 0
    static pause_state := 1
    static play_state := 2
}
struct TimedLevel {
    frequency : UInt8[2048]
    waveform : UInt8[2048]
    state : Int32
    timeStamp : Int64
}
struct IWMPEffects extends IUnknown {
    static IID := "{D3984C13-C3CB-48E2-8BE5-5168340B4F35}"
    Render(pLevels, hdc1, prc)
      => ComCall(3, this.p, TimedLevel.Ptr, pLevels, HDC, hdc1, RECT.Ptr, prc)
    MediaInfo(lChannelCount, lSampleRate, bstrTitle)
      => ComCall(4, this.p, Int32, lChannelCount, Int32, lSampleRate, BSTR, bstrTitle)
    GetCapabilities(pdwCapabilities)
      => ComCall(5, this.p, UInt32.Ptr, pdwCapabilities)
    GetTitle(bstrTitle)
      => ComCall(6, this.p, BSTR.Ptr, bstrTitle)
    GetPresetTitle(nPreset, bstrPresetTitle)
      => ComCall(7, this.p, Int32, nPreset, BSTR.Ptr, bstrPresetTitle)
    GetPresetCount(pnPresetCount)
      => ComCall(8, this.p, Int32.Ptr, pnPresetCount)
    SetCurrentPreset(nPreset)
      => ComCall(9, this.p, Int32, nPreset)
    GetCurrentPreset(pnPreset)
      => ComCall(10, this.p, Int32.Ptr, pnPreset)
    DisplayPropertyPage(hwndOwner)
      => ComCall(11, this.p, HWND, hwndOwner)
    GoFullscreen(fFullScreen)
      => ComCall(12, this.p, BOOL, fFullScreen)
    RenderFullScreen(pLevels)
      => ComCall(13, this.p, TimedLevel.Ptr, pLevels)
}
struct IWMPEffects2 extends IWMPEffects {
    static IID := "{695386EC-AA3C-4618-A5E1-DD9A8B987632}"
    SetCore(pPlayer)
      => ComCall(14, this.p, IWMPCore, pPlayer)
    Create(hwndParent)
      => ComCall(15, this.p, HWND, hwndParent)
    Destroy()
      => ComCall(16, this.p)
    NotifyNewMedia(pMedia)
      => ComCall(17, this.p, IWMPMedia, pMedia)
    OnWindowMessage(msg, WParam1, LParam1, plResultParam)
      => ComCall(18, this.p, UInt32, msg, WPARAM, WParam1, LPARAM, LParam1, LRESULT.Ptr, plResultParam)
    RenderWindowed(pData, fRequiredRender)
      => ComCall(19, this.p, TimedLevel.Ptr, pData, BOOL, fRequiredRender)
}
struct IWMPPluginUI extends IUnknown {
    static IID := "{4C5E8F9F-AD3E-4BF9-9753-FCD30D6D38DD}"
    SetCore(pCore)
      => ComCall(3, this.p, IWMPCore, pCore)
    Create(hwndParent, phwndWindow)
      => ComCall(4, this.p, HWND, hwndParent, HWND.Ptr, phwndWindow)
    Destroy()
      => ComCall(5, this.p)
    DisplayPropertyPage(hwndParent)
      => ComCall(6, this.p, HWND, hwndParent)
    GetProperty(pwszName, pvarProperty)
      => ComCall(7, this.p, "Str", pwszName, VARIANT.Ptr, pvarProperty)
    SetProperty(pwszName, pvarProperty)
      => ComCall(8, this.p, "Str", pwszName, VARIANT.Ptr, pvarProperty)
    TranslateAccelerator(lpmsg)
      => ComCall(9, this.p, MSG.Ptr, lpmsg)
}
struct WMPPartnerNotification extends Int32 {
    static wmpsnBackgroundProcessingBegin := 1
    static wmpsnBackgroundProcessingEnd := 2
    static wmpsnCatalogDownloadFailure := 3
    static wmpsnCatalogDownloadComplete := 4
}
struct WMPCallbackNotification extends Int32 {
    static wmpcnLoginStateChange := 1
    static wmpcnAuthResult := 2
    static wmpcnLicenseUpdated := 3
    static wmpcnNewCatalogAvailable := 4
    static wmpcnNewPluginAvailable := 5
    static wmpcnDisableRadioSkipping := 6
}
struct WMPTaskType extends Int32 {
    static wmpttBrowse := 1
    static wmpttSync := 2
    static wmpttBurn := 3
    static wmpttCurrent := 4
}
struct WMPContextMenuInfo {
    dwID : UInt32
    bstrMenuText : BSTR
    bstrHelpText : BSTR
}
struct IWMPContentContainer extends IUnknown {
    static IID := "{AD7F4D9C-1A9F-4ED2-9815-ECC0B58CB616}"
    GetID(pContentID)
      => ComCall(3, this.p, UInt32.Ptr, pContentID)
    GetPrice(pbstrPrice)
      => ComCall(4, this.p, BSTR.Ptr, pbstrPrice)
    GetType(pbstrType)
      => ComCall(5, this.p, BSTR.Ptr, pbstrType)
    GetContentCount(pcContent)
      => ComCall(6, this.p, UInt32.Ptr, pcContent)
    GetContentPrice(idxContent, pbstrPrice)
      => ComCall(7, this.p, UInt32, idxContent, BSTR.Ptr, pbstrPrice)
    GetContentID(idxContent, pContentID)
      => ComCall(8, this.p, UInt32, idxContent, UInt32.Ptr, pContentID)
}
struct WMPTransactionType extends Int32 {
    static wmpttNoTransaction := 0
    static wmpttDownload := 1
    static wmpttBuy := 2
}
struct IWMPContentContainerList extends IUnknown {
    static IID := "{A9937F78-0802-4AF8-8B8D-E3F045BC8AB5}"
    GetTransactionType(pwmptt)
      => ComCall(3, this.p, WMPTransactionType.Ptr, pwmptt)
    GetContainerCount(pcContainer)
      => ComCall(4, this.p, UInt32.Ptr, pcContainer)
    GetContainer(idxContainer, ppContent)
      => ComCall(5, this.p, UInt32, idxContainer, IWMPContentContainer.Ptr, ppContent)
}
struct WMPTemplateSize extends Int32 {
    static wmptsSmall := 0
    static wmptsMedium := 1
    static wmptsLarge := 2
}
struct WMPStreamingType extends Int32 {
    static wmpstUnknown := 0
    static wmpstMusic := 1
    static wmpstVideo := 2
    static wmpstRadio := 3
}
struct WMPAccountType extends Int32 {
    static wmpatBuyOnly := 1
    static wmpatSubscription := 2
    static wmpatJanus := 3
}
struct IWMPContentPartnerCallback extends IUnknown {
    static IID := "{9E8F7DA2-0695-403C-B697-DA10FAFAA676}"
    Notify(type, pContext)
      => ComCall(3, this.p, WMPCallbackNotification, type, VARIANT.Ptr, pContext)
    BuyComplete(hrResult, dwBuyCookie)
      => ComCall(4, this.p, HRESULT, hrResult, UInt32, dwBuyCookie)
    DownloadTrack(cookie, bstrTrackURL, dwServiceTrackID, bstrDownloadParams, hrDownload)
      => ComCall(5, this.p, UInt32, cookie, BSTR, bstrTrackURL, UInt32, dwServiceTrackID, BSTR, bstrDownloadParams, HRESULT, hrDownload)
    GetCatalogVersion(pdwVersion, pdwSchemaVersion, plcid)
      => ComCall(6, this.p, UInt32.Ptr, pdwVersion, UInt32.Ptr, pdwSchemaVersion, UInt32.Ptr, plcid)
    UpdateDeviceComplete(bstrDeviceName)
      => ComCall(7, this.p, BSTR, bstrDeviceName)
    ChangeView(bstrType, bstrID, bstrFilter)
      => ComCall(8, this.p, BSTR, bstrType, BSTR, bstrID, BSTR, bstrFilter)
    AddListContents(dwListCookie, prgItems)
      => ComCall(9, this.p, UInt32, dwListCookie, UInt32, prgItems.Length, UInt32.Ptr, prgItems)
    ListContentsComplete(dwListCookie, hrSuccess)
      => ComCall(10, this.p, UInt32, dwListCookie, HRESULT, hrSuccess)
    SendMessageComplete(bstrMsg, bstrParam, bstrResult)
      => ComCall(11, this.p, BSTR, bstrMsg, BSTR, bstrParam, BSTR, bstrResult)
    GetContentIDsInLibrary(pcContentIDs, pprgIDs)
      => ComCall(12, this.p, UInt32.Ptr, pcContentIDs, UInt32.Ptr.Ptr, pprgIDs)
    RefreshLicenseComplete(dwCookie, contentID, hrRefresh)
      => ComCall(13, this.p, UInt32, dwCookie, UInt32, contentID, HRESULT, hrRefresh)
    ShowPopup(lIndex, bstrParameters)
      => ComCall(14, this.p, Int32, lIndex, BSTR, bstrParameters)
    VerifyPermissionComplete(bstrPermission, pContext, hrPermission)
      => ComCall(15, this.p, BSTR, bstrPermission, VARIANT.Ptr, pContext, HRESULT, hrPermission)
}
struct IWMPContentPartner extends IUnknown {
    static IID := "{55455073-41B5-4E75-87B8-F13BDB291D08}"
    SetCallback(pCallback?)
      => ComCall(3, this.p, IWMPContentPartnerCallback, pCallback?)
    Notify(type, pContext)
      => ComCall(4, this.p, WMPPartnerNotification, type, VARIANT.Ptr, pContext)
    GetItemInfo(bstrInfoName, pContext, pData)
      => ComCall(5, this.p, BSTR, bstrInfoName, VARIANT.Ptr, pContext, VARIANT.Ptr, pData)
    GetContentPartnerInfo(bstrInfoName, pData)
      => ComCall(6, this.p, BSTR, bstrInfoName, VARIANT.Ptr, pData)
    GetCommands(location, pLocationContext, itemLocation, prgItemIDs, pcItemIDs, pprgItems)
      => ComCall(7, this.p, BSTR, location, VARIANT.Ptr, pLocationContext, BSTR, itemLocation, UInt32, prgItemIDs.Length, UInt32.Ptr, prgItemIDs, UInt32.Ptr, pcItemIDs, WMPContextMenuInfo.Ptr.Ptr, pprgItems)
    InvokeCommand(dwCommandID, location, pLocationContext, itemLocation, rgItemIDs)
      => ComCall(8, this.p, UInt32, dwCommandID, BSTR, location, VARIANT.Ptr, pLocationContext, BSTR, itemLocation, UInt32, rgItemIDs.Length, UInt32.Ptr, rgItemIDs)
    CanBuySilent(pInfo?, pbstrTotalPrice, pSilentOK)
      => ComCall(9, this.p, IWMPContentContainerList, pInfo?, BSTR.Ptr, pbstrTotalPrice, VARIANT_BOOL.Ptr, pSilentOK)
    Buy(pInfo?, cookie)
      => ComCall(10, this.p, IWMPContentContainerList, pInfo?, UInt32, cookie)
    GetStreamingURL(st, pStreamContext, pbstrURL)
      => ComCall(11, this.p, WMPStreamingType, st, VARIANT.Ptr, pStreamContext, BSTR.Ptr, pbstrURL)
    Download(pInfo?, cookie)
      => ComCall(12, this.p, IWMPContentContainerList, pInfo?, UInt32, cookie)
    DownloadTrackComplete(hrResult, contentID, downloadTrackParam)
      => ComCall(13, this.p, HRESULT, hrResult, UInt32, contentID, BSTR, downloadTrackParam)
    RefreshLicense(dwCookie, fLocal, bstrURL?, type, contentID, bstrRefreshReason, pReasonContext)
      => ComCall(14, this.p, UInt32, dwCookie, VARIANT_BOOL, fLocal, BSTR, bstrURL?, WMPStreamingType, type, UInt32, contentID, BSTR, bstrRefreshReason, VARIANT.Ptr, pReasonContext)
    GetCatalogURL(dwCatalogVersion, dwCatalogSchemaVersion, catalogLCID, pdwNewCatalogVersion, pbstrCatalogURL, pExpirationDate)
      => ComCall(15, this.p, UInt32, dwCatalogVersion, UInt32, dwCatalogSchemaVersion, UInt32, catalogLCID, UInt32.Ptr, pdwNewCatalogVersion, BSTR.Ptr, pbstrCatalogURL, VARIANT.Ptr, pExpirationDate)
    GetTemplate(task, location, pContext, clickLocation, pClickContext, bstrFilter, bstrViewParams, pbstrTemplateURL, pTemplateSize)
      => ComCall(16, this.p, WMPTaskType, task, BSTR, location, VARIANT.Ptr, pContext, BSTR, clickLocation, VARIANT.Ptr, pClickContext, BSTR, bstrFilter, BSTR, bstrViewParams, BSTR.Ptr, pbstrTemplateURL, WMPTemplateSize.Ptr, pTemplateSize)
    UpdateDevice(bstrDeviceName)
      => ComCall(17, this.p, BSTR, bstrDeviceName)
    GetListContents(location, pContext, bstrListType, bstrParams, dwListCookie)
      => ComCall(18, this.p, BSTR, location, VARIANT.Ptr, pContext, BSTR, bstrListType, BSTR, bstrParams, UInt32, dwListCookie)
    Login(userInfo, pwdInfo, fUsedCachedCreds, fOkToCache)
      => ComCall(19, this.p, BLOB, userInfo, BLOB, pwdInfo, VARIANT_BOOL, fUsedCachedCreds, VARIANT_BOOL, fOkToCache)
    Authenticate(userInfo, pwdInfo)
      => ComCall(20, this.p, BLOB, userInfo, BLOB, pwdInfo)
    Logout()
      => ComCall(21, this.p)
    SendMessage(bstrMsg, bstrParam)
      => ComCall(22, this.p, BSTR, bstrMsg, BSTR, bstrParam)
    StationEvent(bstrStationEventType, StationId, PlaylistIndex, TrackID, TrackData, dwSecondsPlayed)
      => ComCall(23, this.p, BSTR, bstrStationEventType, UInt32, StationId, UInt32, PlaylistIndex, UInt32, TrackID, BSTR, TrackData, UInt32, dwSecondsPlayed)
    CompareContainerListPrices(pListBase?, pListCompare?, pResult)
      => ComCall(24, this.p, IWMPContentContainerList, pListBase?, IWMPContentContainerList, pListCompare?, Int32.Ptr, pResult)
    VerifyPermission(bstrPermission, pContext)
      => ComCall(25, this.p, BSTR, bstrPermission, VARIANT.Ptr, pContext)
}
struct WMPSubscriptionServiceEvent extends Int32 {
    static wmpsseCurrentBegin := 1
    static wmpsseCurrentEnd := 2
    static wmpsseFullBegin := 3
    static wmpsseFullEnd := 4
}
struct IWMPSubscriptionService extends IUnknown {
    static IID := "{376055F8-2A59-4A73-9501-DCA5273A7A10}"
    allowPlay(hwnd1, pMedia, pfAllowPlay)
      => ComCall(3, this.p, HWND, hwnd1, IWMPMedia, pMedia, BOOL.Ptr, pfAllowPlay)
    allowCDBurn(hwnd1, pPlaylist, pfAllowBurn)
      => ComCall(4, this.p, HWND, hwnd1, IWMPPlaylist, pPlaylist, BOOL.Ptr, pfAllowBurn)
    allowPDATransfer(hwnd1, pPlaylist, pfAllowTransfer)
      => ComCall(5, this.p, HWND, hwnd1, IWMPPlaylist, pPlaylist, BOOL.Ptr, pfAllowTransfer)
    startBackgroundProcessing(hwnd1)
      => ComCall(6, this.p, HWND, hwnd1)
}
struct IWMPSubscriptionServiceCallback extends IUnknown {
    static IID := "{DD01D127-2DC2-4C3A-876E-63312079F9B0}"
    onComplete(hrResult)
      => ComCall(3, this.p, HRESULT, hrResult)
}
struct IWMPSubscriptionService2 extends IWMPSubscriptionService {
    static IID := "{A94C120E-D600-4EC6-B05E-EC9D56D84DE0}"
    stopBackgroundProcessing()
      => ComCall(7, this.p)
    serviceEvent(event)
      => ComCall(8, this.p, WMPSubscriptionServiceEvent, event)
    deviceAvailable(bstrDeviceName, pCB)
      => ComCall(9, this.p, BSTR, bstrDeviceName, IWMPSubscriptionServiceCallback, pCB)
    prepareForSync(bstrFilename, bstrDeviceName, pCB)
      => ComCall(10, this.p, BSTR, bstrFilename, BSTR, bstrDeviceName, IWMPSubscriptionServiceCallback, pCB)
}
struct WMPSubscriptionDownloadState extends Int32 {
    static wmpsdlsDownloading := 0
    static wmpsdlsPaused := 1
    static wmpsdlsProcessing := 2
    static wmpsdlsCompleted := 3
    static wmpsdlsCancelled := 4
}
struct IWMPDownloadItem extends IDispatch {
    static IID := "{C9470E8E-3F6B-46A9-A0A9-452815C34297}"
    get_sourceURL(pbstrURL)
      => ComCall(7, this.p, BSTR.Ptr, pbstrURL)
    get_size(plSize)
      => ComCall(8, this.p, Int32.Ptr, plSize)
    get_type(pbstrType)
      => ComCall(9, this.p, BSTR.Ptr, pbstrType)
    get_progress(plProgress)
      => ComCall(10, this.p, Int32.Ptr, plProgress)
    get_downloadState(pwmpsdls)
      => ComCall(11, this.p, WMPSubscriptionDownloadState.Ptr, pwmpsdls)
    pause()
      => ComCall(12, this.p)
    resume()
      => ComCall(13, this.p)
    cancel()
      => ComCall(14, this.p)
}
struct IWMPDownloadItem2 extends IWMPDownloadItem {
    static IID := "{9FBB3336-6DA3-479D-B8FF-67D46E20A987}"
    getItemInfo(bstrItemName, pbstrVal)
      => ComCall(15, this.p, BSTR, bstrItemName, BSTR.Ptr, pbstrVal)
}
struct IWMPDownloadCollection extends IDispatch {
    static IID := "{0A319C7F-85F9-436C-B88E-82FD88000E1C}"
    get_id(plId)
      => ComCall(7, this.p, Int32.Ptr, plId)
    get_count(plCount)
      => ComCall(8, this.p, Int32.Ptr, plCount)
    item(lItem, ppDownload)
      => ComCall(9, this.p, Int32, lItem, IWMPDownloadItem2.Ptr, ppDownload)
    startDownload(bstrSourceURL, bstrType, ppDownload)
      => ComCall(10, this.p, BSTR, bstrSourceURL, BSTR, bstrType, IWMPDownloadItem2.Ptr, ppDownload)
    removeItem(lItem)
      => ComCall(11, this.p, Int32, lItem)
    Clear()
      => ComCall(12, this.p)
}
struct IWMPDownloadManager extends IDispatch {
    static IID := "{E15E9AD1-8F20-4CC4-9EC7-1A328CA86A0D}"
    getDownloadCollection(lCollectionId, ppCollection)
      => ComCall(7, this.p, Int32, lCollectionId, IWMPDownloadCollection.Ptr, ppCollection)
    createDownloadCollection(ppCollection)
      => ComCall(8, this.p, IWMPDownloadCollection.Ptr, ppCollection)
}
struct WMP_WMDM_METADATA_ROUND_TRIP_PC2DEVICE {
    dwChangesSinceTransactionID : UInt32
    dwResultSetStartingIndex : UInt32
}
struct WMP_WMDM_METADATA_ROUND_TRIP_DEVICE2PC {
    dwCurrentTransactionID : UInt32
    dwReturnedObjectCount : UInt32
    dwUnretrievedObjectCount : UInt32
    dwDeletedObjectStartingOffset : UInt32
    dwFlags : UInt32
    wsObjectPathnameList : UInt16[1]
}
