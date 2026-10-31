#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, PWSTR}
#Import "..\Security.Cryptography\Types.ahk" {CERT_QUERY_ENCODING_TYPE}

CryptSIPAddProvider(psNewProv)
  => DllCall("CRYPT32.dll\CryptSIPAddProvider", SIP_ADD_NEWPROVIDER.Ptr, psNewProv, BOOL)
CryptSIPCreateIndirectData(pSubjectInfo, pcbIndirectData, pIndirectData)
  => DllCall("WINTRUST.dll\CryptSIPCreateIndirectData", SIP_SUBJECTINFO.Ptr, pSubjectInfo, UInt32.Ptr, pcbIndirectData, SIP_INDIRECT_DATA.Ptr, pIndirectData, BOOL)
CryptSIPGetCaps(pSubjInfo, pCaps)
  => DllCall("WINTRUST.dll\CryptSIPGetCaps", SIP_SUBJECTINFO.Ptr, pSubjInfo, SIP_CAP_SET_V3.Ptr, pCaps, BOOL)
CryptSIPGetSealedDigest(pSubjectInfo, pSig?, pbDigest?)
  => DllCall("WINTRUST.dll\CryptSIPGetSealedDigest", SIP_SUBJECTINFO.Ptr, pSubjectInfo, UInt8.Ptr, pSig?, UInt32, pSig?.Length ?? 0, UInt8.Ptr, pbDigest?, UInt32.Ptr, pbDigest?.Length ?? 0, BOOL)
CryptSIPGetSignedDataMsg(pSubjectInfo, pdwEncodingType, dwIndex, pcbSignedDataMsg, pbSignedDataMsg)
  => DllCall("WINTRUST.dll\CryptSIPGetSignedDataMsg", SIP_SUBJECTINFO.Ptr, pSubjectInfo, CERT_QUERY_ENCODING_TYPE.Ptr, pdwEncodingType, UInt32, dwIndex, UInt32.Ptr, pcbSignedDataMsg, UInt8.Ptr, pbSignedDataMsg, BOOL)
CryptSIPLoad(pgSubject, dwFlags, pSipDispatch)
  => DllCall("CRYPT32.dll\CryptSIPLoad", GUID.Ptr, pgSubject, UInt32, dwFlags, SIP_DISPATCH_INFO.Ptr, pSipDispatch, BOOL)
CryptSIPPutSignedDataMsg(pSubjectInfo, dwEncodingType, pdwIndex, cbSignedDataMsg, pbSignedDataMsg)
  => DllCall("WINTRUST.dll\CryptSIPPutSignedDataMsg", SIP_SUBJECTINFO.Ptr, pSubjectInfo, CERT_QUERY_ENCODING_TYPE, dwEncodingType, UInt32.Ptr, pdwIndex, UInt32, cbSignedDataMsg, UInt8.Ptr, pbSignedDataMsg, BOOL)
CryptSIPRemoveProvider(pgProv)
  => DllCall("CRYPT32.dll\CryptSIPRemoveProvider", GUID.Ptr, pgProv, BOOL)
CryptSIPRemoveSignedDataMsg(pSubjectInfo, dwIndex)
  => DllCall("WINTRUST.dll\CryptSIPRemoveSignedDataMsg", SIP_SUBJECTINFO.Ptr, pSubjectInfo, UInt32, dwIndex, BOOL)
CryptSIPRetrieveSubjectGuid(FileName, hFileIn, pgSubject)
  => DllCall("CRYPT32.dll\CryptSIPRetrieveSubjectGuid", "Str", FileName, HANDLE, hFileIn, GUID.Ptr, pgSubject, BOOL)
CryptSIPRetrieveSubjectGuidForCatalogFile(FileName, hFileIn, pgSubject)
  => DllCall("CRYPT32.dll\CryptSIPRetrieveSubjectGuidForCatalogFile", "Str", FileName, HANDLE, hFileIn, GUID.Ptr, pgSubject, BOOL)
CryptSIPVerifyIndirectData(pSubjectInfo, pIndirectData)
  => DllCall("WINTRUST.dll\CryptSIPVerifyIndirectData", SIP_SUBJECTINFO.Ptr, pSubjectInfo, SIP_INDIRECT_DATA.Ptr, pIndirectData, BOOL)
