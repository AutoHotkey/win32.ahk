#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IDispatch, ISequentialStream, IStream, IUnknown}

struct XPS_JOB_COMPLETION extends Int32 {
    static XPS_JOB_IN_PROGRESS := 0
    static XPS_JOB_COMPLETED := 1
    static XPS_JOB_CANCELLED := 2
    static XPS_JOB_FAILED := 3
}
struct XPS_JOB_STATUS {
    jobId : UInt32
    currentDocument : Int32
    currentPage : Int32
    currentPageTotal : Int32
    completion : XPS_JOB_COMPLETION
    jobStatus : HRESULT
}
struct IXpsPrintJobStream extends ISequentialStream {
    static IID := "{7A77DC5F-45D6-4DFF-9307-D8CB846347CA}"
    Close()
      => ComCall(5, this.p)
}
struct IXpsPrintJob extends IUnknown {
    static IID := "{5AB89B06-8194-425F-AB3B-D7A96E350161}"
    Cancel()
      => ComCall(3, this.p)
    GetJobStatus(jobStatus)
      => ComCall(4, this.p, XPS_JOB_STATUS.Ptr, jobStatus)
}
struct IPrintDocumentPackageTarget extends IUnknown {
    static IID := "{1B8EFEC4-3019-4C27-964E-367202156906}"
    GetPackageTargetTypes(targetTypes)
      => ComCall(3, this.p, UInt32.Ptr, targetTypes.Length, GUID.Ptr.Ptr, targetTypes)
    GetPackageTarget(guidTargetType, riid, ppvTarget)
      => ComCall(4, this.p, GUID.Ptr, guidTargetType, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvTarget)
    Cancel()
      => ComCall(5, this.p)
}
struct IPrintDocumentPackageTarget2 extends IUnknown {
    static IID := "{C560298A-535C-48F9-866A-632540660CB4}"
    GetIsTargetIppPrinter(isIppPrinter)
      => ComCall(3, this.p, BOOL.Ptr, isIppPrinter)
    GetTargetIppPrintDevice(riid, ppvTarget)
      => ComCall(4, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppvTarget)
}
struct PrintDocumentPackageCompletion extends Int32 {
    static PrintDocumentPackageCompletion_InProgress := 0
    static PrintDocumentPackageCompletion_Completed := 1
    static PrintDocumentPackageCompletion_Canceled := 2
    static PrintDocumentPackageCompletion_Failed := 3
}
struct PrintDocumentPackageStatus {
    JobId : UInt32
    CurrentDocument : Int32
    CurrentPage : Int32
    CurrentPageTotal : Int32
    Completion : PrintDocumentPackageCompletion
    PackageStatus : HRESULT
}
struct IPrintDocumentPackageStatusEvent extends IDispatch {
    static IID := "{ED90C8AD-5C34-4D05-A1EC-0E8A9B3AD7AF}"
    PackageStatusUpdated(packageStatus)
      => ComCall(7, this.p, PrintDocumentPackageStatus.Ptr, packageStatus)
}
struct IPrintDocumentPackageTargetFactory extends IUnknown {
    static IID := "{D2959BF7-B31B-4A3D-9600-712EB1335BA4}"
    CreateDocumentPackageTargetForPrintJob(printerName, jobName, jobOutputStream, jobPrintTicketStream, docPackageTarget)
      => ComCall(3, this.p, "Str", printerName, "Str", jobName, IStream, jobOutputStream, IStream, jobPrintTicketStream, IPrintDocumentPackageTarget.Ptr, docPackageTarget)
}
