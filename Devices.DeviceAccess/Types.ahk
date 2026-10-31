#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct IDeviceRequestCompletionCallback extends IUnknown {
    static IID := "{999BAD24-9ACD-45BB-8669-2A2FC0288B04}"
    Invoke(requestResult, bytesReturned)
      => ComCall(3, this.p, HRESULT, requestResult, UInt32, bytesReturned)
}
struct IDeviceIoControl extends IUnknown {
    static IID := "{9EEFE161-23AB-4F18-9B49-991B586AE970}"
    DeviceIoControlSync(ioControlCode, inputBuffer?, outputBuffer?, bytesReturned)
      => ComCall(3, this.p, UInt32, ioControlCode, UInt8.Ptr, inputBuffer?, UInt32, inputBuffer?.Length ?? 0, UInt8.Ptr, outputBuffer?, UInt32, outputBuffer?.Length ?? 0, UInt32.Ptr, bytesReturned)
    DeviceIoControlAsync(ioControlCode, inputBuffer?, outputBuffer?, requestCompletionCallback, cancelContext?)
      => ComCall(4, this.p, UInt32, ioControlCode, UInt8.Ptr, inputBuffer?, UInt32, inputBuffer?.Length ?? 0, UInt8.Ptr, outputBuffer?, UInt32, outputBuffer?.Length ?? 0, IDeviceRequestCompletionCallback, requestCompletionCallback, IntPtr.Ptr, cancelContext?)
    CancelOperation(cancelContext)
      => ComCall(5, this.p, IntPtr, cancelContext)
}
struct ICreateDeviceAccessAsync extends IUnknown {
    static IID := "{3474628F-683D-42D2-ABCB-DB018C6503BC}"
    Cancel()
      => ComCall(3, this.p)
    Wait(timeout)
      => ComCall(4, this.p, UInt32, timeout)
    Close()
      => ComCall(5, this.p)
    GetResult(riid, deviceAccess)
      => ComCall(6, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, deviceAccess)
}
