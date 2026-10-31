#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, PWSTR}

DavAddConnection(ConnectionHandle, RemoteName, UserName?, Password?, ClientCert)
  => DllCall("NETAPI32.dll\DavAddConnection", HANDLE.Ptr, ConnectionHandle, "Str", RemoteName, "Str", UserName?, "Str", Password?, UInt8.Ptr, ClientCert, UInt32, ClientCert.Size, UInt32)
DavCancelConnectionsToServer(lpName, fForce)
  => DllCall("davclnt.dll\DavCancelConnectionsToServer", "Str", lpName, BOOL, fForce, UInt32)
DavDeleteConnection(ConnectionHandle)
  => DllCall("NETAPI32.dll\DavDeleteConnection", HANDLE, ConnectionHandle, UInt32)
DavFlushFile(hFile)
  => DllCall("NETAPI32.dll\DavFlushFile", HANDLE, hFile, UInt32)
DavGetExtendedError(hFile, ExtError, ExtErrorString)
  => DllCall("NETAPI32.dll\DavGetExtendedError", HANDLE, hFile, UInt32.Ptr, ExtError, PWSTR, ExtErrorString, UInt32.Ptr, ExtErrorString.Length, UInt32)
DavGetHTTPFromUNCPath(UncPath, Url?)
  => DllCall("NETAPI32.dll\DavGetHTTPFromUNCPath", "Str", UncPath, PWSTR, Url?, UInt32.Ptr, Url?.Length ?? 0, UInt32)
DavGetTheLockOwnerOfTheFile(FileName, LockOwnerName?, LockOwnerNameLengthInBytes)
  => DllCall("davclnt.dll\DavGetTheLockOwnerOfTheFile", "Str", FileName, PWSTR, LockOwnerName?, UInt32.Ptr, LockOwnerNameLengthInBytes, UInt32)
DavGetUNCFromHTTPPath(Url, UncPath?)
  => DllCall("NETAPI32.dll\DavGetUNCFromHTTPPath", "Str", Url, PWSTR, UncPath?, UInt32.Ptr, UncPath?.Length ?? 0, UInt32)
DavInvalidateCache(URLName)
  => DllCall("davclnt.dll\DavInvalidateCache", "Str", URLName, UInt32)
DavRegisterAuthCallback(CallBack, Version)
  => DllCall("davclnt.dll\DavRegisterAuthCallback", PFNDAVAUTHCALLBACK, CallBack, UInt32, Version, UInt32)
DavUnregisterAuthCallback(hCallback)
  => DllCall("davclnt.dll\DavUnregisterAuthCallback", UInt32, hCallback, "void")
