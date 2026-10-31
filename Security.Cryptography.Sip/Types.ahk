#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, PWSTR}
#Import "..\Security.Cryptography\Types.ahk" {CRYPT_ALGORITHM_IDENTIFIER, CRYPT_ATTRIBUTE_TYPE_VALUE, CRYPT_INTEGER_BLOB}
#Import "..\Security.Cryptography.Catalog\Types.ahk" {MS_ADDINFO_CATALOGMEMBER}

struct SIP_SUBJECTINFO {
    cbSize : UInt32 := this.Size
    pgSubjectType : GUID.Ptr
    hFile : HANDLE
    pwsFileName : PWSTR
    pwsDisplayName : PWSTR
    dwReserved1 : UInt32
    dwIntVersion : UInt32
    hProv : IntPtr
    DigestAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    dwFlags : UInt32
    dwEncodingType : UInt32
    dwReserved2 : UInt32
    fdwCAPISettings : UInt32
    fdwSecuritySettings : UInt32
    dwIndex : UInt32
    dwUnionChoice : UInt32
    Anonymous : this._Anonymous_e__Union
    pClientData : Struct.Ptr
    struct _Anonymous_e__Union {
        union {
            psFlat : MS_ADDINFO_FLAT.Ptr
            psCatMember : MS_ADDINFO_CATALOGMEMBER.Ptr
            psBlob : MS_ADDINFO_BLOB.Ptr
            psDetachedSig : MS_ADDINFO_DETACHEDSIG.Ptr
        }
    }
}
struct MS_ADDINFO_FLAT {
    cbStruct : UInt32
    pIndirectData : SIP_INDIRECT_DATA.Ptr
}
struct MS_ADDINFO_BLOB {
    cbStruct : UInt32
    cbMemObject : UInt32
    pbMemObject : UInt8.Ptr
    cbMemSignedMsg : UInt32
    pbMemSignedMsg : UInt8.Ptr
}
struct MS_ADDINFO_DETACHEDSIG {
    cbStruct : UInt32
    hSignatureFile : HANDLE
    cbSignatureObject : UInt32
    pbSignatureObject : UInt8.Ptr
}
struct SIP_CAP_SET_V2 {
    cbSize : UInt32 := this.Size
    dwVersion : UInt32
    isMultiSign : BOOL
    dwReserved : UInt32
}
struct SIP_CAP_SET_V3 {
    cbSize : UInt32 := this.Size
    dwVersion : UInt32
    isMultiSign : BOOL
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            dwFlags : UInt32
            dwReserved : UInt32
        }
    }
}
struct SIP_INDIRECT_DATA {
    Data : CRYPT_ATTRIBUTE_TYPE_VALUE
    DigestAlgorithm : CRYPT_ALGORITHM_IDENTIFIER
    Digest : CRYPT_INTEGER_BLOB
}
struct pCryptSIPGetSignedDataMsg extends FunctionPointer {
    static Types := [SIP_SUBJECTINFO.Ptr, UInt32.Ptr, UInt32, UInt32.Ptr, UInt8.Ptr, BOOL]
}
struct pCryptSIPPutSignedDataMsg extends FunctionPointer {
    static Types := [SIP_SUBJECTINFO.Ptr, UInt32, UInt32.Ptr, UInt32, UInt8.Ptr, BOOL]
}
struct pCryptSIPCreateIndirectData extends FunctionPointer {
    static Types := [SIP_SUBJECTINFO.Ptr, UInt32.Ptr, SIP_INDIRECT_DATA.Ptr, BOOL]
}
struct pCryptSIPVerifyIndirectData extends FunctionPointer {
    static Types := [SIP_SUBJECTINFO.Ptr, SIP_INDIRECT_DATA.Ptr, BOOL]
}
struct pCryptSIPRemoveSignedDataMsg extends FunctionPointer {
    static Types := [SIP_SUBJECTINFO.Ptr, UInt32, BOOL]
}
struct SIP_DISPATCH_INFO {
    cbSize : UInt32 := this.Size
    hSIP : HANDLE
    pfGet : pCryptSIPGetSignedDataMsg
    pfPut : pCryptSIPPutSignedDataMsg
    pfCreate : pCryptSIPCreateIndirectData
    pfVerify : pCryptSIPVerifyIndirectData
    pfRemove : pCryptSIPRemoveSignedDataMsg
}
struct pfnIsFileSupported extends FunctionPointer {
    static Types := [HANDLE, GUID.Ptr, BOOL]
}
struct pfnIsFileSupportedName extends FunctionPointer {
    static Types := [PWSTR, GUID.Ptr, BOOL]
}
struct SIP_ADD_NEWPROVIDER {
    cbStruct : UInt32
    pgSubject : GUID.Ptr
    pwszDLLFileName : PWSTR
    pwszMagicNumber : PWSTR
    pwszIsFunctionName : PWSTR
    pwszGetFuncName : PWSTR
    pwszPutFuncName : PWSTR
    pwszCreateFuncName : PWSTR
    pwszVerifyFuncName : PWSTR
    pwszRemoveFuncName : PWSTR
    pwszIsFunctionNameFmt2 : PWSTR
    pwszGetCapFuncName : PWSTR
}
struct pCryptSIPGetCaps extends FunctionPointer {
    static Types := [SIP_SUBJECTINFO.Ptr, SIP_CAP_SET_V3.Ptr, BOOL]
}
struct pCryptSIPGetSealedDigest extends FunctionPointer {
    static Types := [SIP_SUBJECTINFO.Ptr, UInt8.Ptr, UInt32, UInt8.Ptr, UInt32.Ptr, BOOL]
}
