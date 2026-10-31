#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT}
#Import "..\System.Com\Types.ahk" {IDispatch}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct IChannelCredentials extends IDispatch {
    static IID := "{181B448C-C17C-4B17-AC6D-06699B93198F}"
    SetWindowsCredential(domain, username, password, impersonationLevel, allowNtlm)
      => ComCall(7, this.p, BSTR, domain, BSTR, username, BSTR, password, Int32, impersonationLevel, BOOL, allowNtlm)
    SetUserNameCredential(username, password)
      => ComCall(8, this.p, BSTR, username, BSTR, password)
    SetClientCertificateFromStore(storeLocation, storeName, findYype, findValue)
      => ComCall(9, this.p, BSTR, storeLocation, BSTR, storeName, BSTR, findYype, VARIANT, findValue)
    SetClientCertificateFromStoreByName(subjectName, storeLocation, storeName)
      => ComCall(10, this.p, BSTR, subjectName, BSTR, storeLocation, BSTR, storeName)
    SetClientCertificateFromFile(filename, password, keystorageFlags)
      => ComCall(11, this.p, BSTR, filename, BSTR, password, BSTR, keystorageFlags)
    SetDefaultServiceCertificateFromStore(storeLocation, storeName, findType, findValue)
      => ComCall(12, this.p, BSTR, storeLocation, BSTR, storeName, BSTR, findType, VARIANT, findValue)
    SetDefaultServiceCertificateFromStoreByName(subjectName, storeLocation, storeName)
      => ComCall(13, this.p, BSTR, subjectName, BSTR, storeLocation, BSTR, storeName)
    SetDefaultServiceCertificateFromFile(filename, password, keystorageFlags)
      => ComCall(14, this.p, BSTR, filename, BSTR, password, BSTR, keystorageFlags)
    SetServiceCertificateAuthentication(storeLocation, revocationMode, certificateValidationMode)
      => ComCall(15, this.p, BSTR, storeLocation, BSTR, revocationMode, BSTR, certificateValidationMode)
    SetIssuedToken(localIssuerAddres, localIssuerBindingType, localIssuerBinding)
      => ComCall(16, this.p, BSTR, localIssuerAddres, BSTR, localIssuerBindingType, BSTR, localIssuerBinding)
}
