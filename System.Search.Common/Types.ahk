#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"

struct CONDITION_TYPE extends Int32 {
    static CT_AND_CONDITION := 0
    static CT_OR_CONDITION := 1
    static CT_NOT_CONDITION := 2
    static CT_LEAF_CONDITION := 3
}
struct CONDITION_OPERATION extends Int32 {
    static COP_IMPLICIT := 0
    static COP_EQUAL := 1
    static COP_NOTEQUAL := 2
    static COP_LESSTHAN := 3
    static COP_GREATERTHAN := 4
    static COP_LESSTHANOREQUAL := 5
    static COP_GREATERTHANOREQUAL := 6
    static COP_VALUE_STARTSWITH := 7
    static COP_VALUE_ENDSWITH := 8
    static COP_VALUE_CONTAINS := 9
    static COP_VALUE_NOTCONTAINS := 10
    static COP_DOSWILDCARDS := 11
    static COP_WORD_EQUAL := 12
    static COP_WORD_STARTSWITH := 13
    static COP_APPLICATION_SPECIFIC := 14
}
