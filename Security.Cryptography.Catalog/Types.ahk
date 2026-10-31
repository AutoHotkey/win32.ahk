#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, PWSTR}
#Import "..\Security.Cryptography\Types.ahk" {CRYPT_INTEGER_BLOB}
#Import "..\Security.Cryptography.Sip\Types.ahk" {SIP_INDIRECT_DATA}

struct CRYPTCAT_VERSION extends UInt32 {
    static CRYPTCAT_VERSION_1 := 256
    static CRYPTCAT_VERSION_2 := 512
}
struct CRYPTCAT_OPEN_FLAGS extends UInt32 {
    static CRYPTCAT_OPEN_ALWAYS := 2
    static CRYPTCAT_OPEN_CREATENEW := 1
    static CRYPTCAT_OPEN_EXISTING := 4
    static CRYPTCAT_OPEN_EXCLUDE_PAGE_HASHES := 65536
    static CRYPTCAT_OPEN_INCLUDE_PAGE_HASHES := 131072
    static CRYPTCAT_OPEN_VERIFYSIGHASH := 268435456
    static CRYPTCAT_OPEN_NO_CONTENT_HCRYPTMSG := 536870912
    static CRYPTCAT_OPEN_SORTED := 1073741824
    static CRYPTCAT_OPEN_FLAGS_MASK := 4294901760
}
struct CRYPTCATATTRIBUTE_FLAGS extends UInt32 {
    static CRYPTCAT_ATTR_AUTHENTICATED := 268435456
    static CRYPTCAT_ATTR_UNAUTHENTICATED := 536870912
    static CRYPTCAT_ATTR_NAMEASCII := 1
    static CRYPTCAT_ATTR_NAMEOBJID := 2
    static CRYPTCAT_ATTR_DATAASCII := 65536
    static CRYPTCAT_ATTR_DATABASE64 := 131072
    static CRYPTCAT_ATTR_DATAREPLACE := 262144
    static CRYPTCAT_ATTR_NO_AUTO_COMPAT_ENTRY := 16777216
}
struct CRYPTCATSTORE {
    cbStruct : UInt32
    dwPublicVersion : UInt32
    pwszP7File : PWSTR
    hProv : IntPtr
    dwEncodingType : UInt32
    fdwStoreFlags : CRYPTCAT_OPEN_FLAGS
    hReserved : HANDLE
    hAttrs : HANDLE
    hCryptMsg : Struct.Ptr
    hSorted : HANDLE
}
struct CRYPTCATMEMBER {
    cbStruct : UInt32
    pwszReferenceTag : PWSTR
    pwszFileName : PWSTR
    gSubjectType : GUID
    fdwMemberFlags : UInt32
    pIndirectData : SIP_INDIRECT_DATA.Ptr
    dwCertVersion : UInt32
    dwReserved : UInt32
    hReserved : HANDLE
    sEncodedIndirectData : CRYPT_INTEGER_BLOB
    sEncodedMemberInfo : CRYPT_INTEGER_BLOB
}
struct CRYPTCATATTRIBUTE {
    cbStruct : UInt32
    pwszReferenceTag : PWSTR
    dwAttrTypeAndAction : CRYPTCATATTRIBUTE_FLAGS
    cbValue : UInt32
    pbValue : UInt8.Ptr
    dwReserved : UInt32
}
struct CRYPTCATCDF {
    cbStruct : UInt32
    hFile : HANDLE
    dwCurFilePos : UInt32
    dwLastMemberOffset : UInt32
    fEOF : BOOL
    pwszResultDir : PWSTR
    hCATStore : HANDLE
}
struct CATALOG_INFO {
    cbStruct : UInt32
    wszCatalogFile : UInt16[260]
}
struct PFN_CDF_PARSE_ERROR_CALLBACK extends FunctionPointer {
    static Types := [UInt32, UInt32, PWSTR, "Void"]
}
struct MS_ADDINFO_CATALOGMEMBER {
    cbStruct : UInt32
    pStore : CRYPTCATSTORE.Ptr
    pMember : CRYPTCATMEMBER.Ptr
}
