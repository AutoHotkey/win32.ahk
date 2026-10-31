#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {CHAR}

struct CYPHER_BLOCK {
    data : CHAR[8]
}
struct LM_OWF_PASSWORD {
    data : CYPHER_BLOCK[2]
}
struct SAMPR_ENCRYPTED_USER_PASSWORD {
    Buffer : UInt8[516]
}
struct ENCRYPTED_LM_OWF_PASSWORD {
    data : CYPHER_BLOCK[2]
}
