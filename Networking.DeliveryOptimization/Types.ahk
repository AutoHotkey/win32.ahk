#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IEnumUnknown, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct DO_DOWNLOAD_RANGE {
    Offset : Int64
    Length : Int64
}
struct DO_DOWNLOAD_RANGES_INFO {
    RangeCount : UInt32
    Ranges : DO_DOWNLOAD_RANGE[1]
}
struct DODownloadState extends Int32 {
    static DODownloadState_Created := 0
    static DODownloadState_Transferring := 1
    static DODownloadState_Transferred := 2
    static DODownloadState_Finalized := 3
    static DODownloadState_Aborted := 4
    static DODownloadState_Paused := 5
}
struct DO_DOWNLOAD_STATUS {
    BytesTotal : Int64
    BytesTransferred : Int64
    State : DODownloadState
    Error : HRESULT
    ExtendedError : HRESULT
}
struct DODownloadCostPolicy extends Int32 {
    static DODownloadCostPolicy_Always := 0
    static DODownloadCostPolicy_Unrestricted := 1
    static DODownloadCostPolicy_Standard := 2
    static DODownloadCostPolicy_NoRoaming := 3
    static DODownloadCostPolicy_NoSurcharge := 4
    static DODownloadCostPolicy_NoCellular := 5
}
struct DODownloadProperty extends Int32 {
    static DODownloadProperty_Id := 0
    static DODownloadProperty_Uri := 1
    static DODownloadProperty_ContentId := 2
    static DODownloadProperty_DisplayName := 3
    static DODownloadProperty_LocalPath := 4
    static DODownloadProperty_HttpCustomHeaders := 5
    static DODownloadProperty_CostPolicy := 6
    static DODownloadProperty_SecurityFlags := 7
    static DODownloadProperty_CallbackFreqPercent := 8
    static DODownloadProperty_CallbackFreqSeconds := 9
    static DODownloadProperty_NoProgressTimeoutSeconds := 10
    static DODownloadProperty_ForegroundPriority := 11
    static DODownloadProperty_BlockingMode := 12
    static DODownloadProperty_CallbackInterface := 13
    static DODownloadProperty_StreamInterface := 14
    static DODownloadProperty_SecurityContext := 15
    static DODownloadProperty_NetworkToken := 16
    static DODownloadProperty_CorrelationVector := 17
    static DODownloadProperty_DecryptionInfo := 18
    static DODownloadProperty_IntegrityCheckInfo := 19
    static DODownloadProperty_IntegrityCheckMandatory := 20
    static DODownloadProperty_TotalSizeBytes := 21
    static DODownloadProperty_DisallowOnCellular := 22
    static DODownloadProperty_HttpCustomAuthHeaders := 23
    static DODownloadProperty_HttpAllowSecureToNonSecureRedirect := 24
    static DODownloadProperty_NonVolatile := 25
    static DODownloadProperty_HttpRedirectionTarget := 26
    static DODownloadProperty_HttpResponseHeaders := 27
    static DODownloadProperty_HttpServerIPAddress := 28
    static DODownloadProperty_HttpStatusCode := 29
}
struct DO_DOWNLOAD_ENUM_CATEGORY {
    Property : DODownloadProperty
    Value : PWSTR
}
struct IDODownload extends IUnknown {
    static IID := "{FBBD7FC0-C147-4727-A38D-827EF071EE77}"
    Start(ranges)
      => ComCall(3, this.p, DO_DOWNLOAD_RANGES_INFO.Ptr, ranges)
    Pause()
      => ComCall(4, this.p)
    Abort()
      => ComCall(5, this.p)
    Finalize()
      => ComCall(6, this.p)
    GetStatus(status)
      => ComCall(7, this.p, DO_DOWNLOAD_STATUS.Ptr, status)
    GetProperty(propId, propVal)
      => ComCall(8, this.p, DODownloadProperty, propId, VARIANT.Ptr, propVal)
    SetProperty(propId, propVal)
      => ComCall(9, this.p, DODownloadProperty, propId, VARIANT.Ptr, propVal)
}
struct IDODownloadStatusCallback extends IUnknown {
    static IID := "{D166E8E3-A90E-4392-8E87-05E996D3747D}"
    OnStatusChange(download, status)
      => ComCall(3, this.p, IDODownload, download, DO_DOWNLOAD_STATUS.Ptr, status)
}
struct IDOManager extends IUnknown {
    static IID := "{400E2D4A-1431-4C1A-A748-39CA472CFDB1}"
    CreateDownload(download)
      => ComCall(3, this.p, IDODownload.Ptr, download)
    EnumDownloads(category, ppEnum)
      => ComCall(4, this.p, DO_DOWNLOAD_ENUM_CATEGORY.Ptr, category, IEnumUnknown.Ptr, ppEnum)
}
