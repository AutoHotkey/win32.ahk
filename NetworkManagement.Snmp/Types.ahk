#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, HANDLE, HWND, LPARAM, WPARAM}

struct SNMP_PDU_TYPE extends UInt32 {
    static SNMP_PDU_GET := 160
    static SNMP_PDU_GETNEXT := 161
    static SNMP_PDU_RESPONSE := 162
    static SNMP_PDU_SET := 163
    static SNMP_PDU_GETBULK := 165
    static SNMP_PDU_TRAP := 167
}
struct SNMP_EXTENSION_REQUEST_TYPE extends UInt32 {
    static SNMP_EXTENSION_GET := 160
    static SNMP_EXTENSION_GET_NEXT := 161
    static SNMP_EXTENSION_SET_TEST := 224
    static SNMP_EXTENSION_SET_COMMIT := 163
    static SNMP_EXTENSION_SET_UNDO := 225
    static SNMP_EXTENSION_SET_CLEANUP := 226
}
struct SNMP_API_TRANSLATE_MODE extends UInt32 {
    static SNMPAPI_TRANSLATED := 0
    static SNMPAPI_UNTRANSLATED_V1 := 1
    static SNMPAPI_UNTRANSLATED_V2 := 2
}
struct SNMP_GENERICTRAP extends UInt32 {
    static SNMP_GENERICTRAP_COLDSTART := 0
    static SNMP_GENERICTRAP_WARMSTART := 1
    static SNMP_GENERICTRAP_LINKDOWN := 2
    static SNMP_GENERICTRAP_LINKUP := 3
    static SNMP_GENERICTRAP_AUTHFAILURE := 4
    static SNMP_GENERICTRAP_EGPNEIGHLOSS := 5
    static SNMP_GENERICTRAP_ENTERSPECIFIC := 6
}
struct SNMP_ERROR_STATUS extends UInt32 {
    static SNMP_ERRORSTATUS_NOERROR := 0
    static SNMP_ERRORSTATUS_TOOBIG := 1
    static SNMP_ERRORSTATUS_NOSUCHNAME := 2
    static SNMP_ERRORSTATUS_BADVALUE := 3
    static SNMP_ERRORSTATUS_READONLY := 4
    static SNMP_ERRORSTATUS_GENERR := 5
    static SNMP_ERRORSTATUS_NOACCESS := 6
    static SNMP_ERRORSTATUS_WRONGTYPE := 7
    static SNMP_ERRORSTATUS_WRONGLENGTH := 8
    static SNMP_ERRORSTATUS_WRONGENCODING := 9
    static SNMP_ERRORSTATUS_WRONGVALUE := 10
    static SNMP_ERRORSTATUS_NOCREATION := 11
    static SNMP_ERRORSTATUS_INCONSISTENTVALUE := 12
    static SNMP_ERRORSTATUS_RESOURCEUNAVAILABLE := 13
    static SNMP_ERRORSTATUS_COMMITFAILED := 14
    static SNMP_ERRORSTATUS_UNDOFAILED := 15
    static SNMP_ERRORSTATUS_AUTHORIZATIONERROR := 16
    static SNMP_ERRORSTATUS_NOTWRITABLE := 17
    static SNMP_ERRORSTATUS_INCONSISTENTNAME := 18
}
struct SNMP_STATUS extends UInt32 {
    static SNMPAPI_ON := 1
    static SNMPAPI_OFF := 0
}
struct SNMP_OUTPUT_LOG_TYPE extends UInt32 {
    static SNMP_OUTPUT_TO_CONSOLE := 1
    static SNMP_OUTPUT_TO_LOGFILE := 2
    static SNMP_OUTPUT_TO_DEBUGGER := 8
}
struct SNMP_LOG extends Int32 {
    static SNMP_LOG_SILENT := 0
    static SNMP_LOG_FATAL := 1
    static SNMP_LOG_ERROR := 2
    static SNMP_LOG_WARNING := 3
    static SNMP_LOG_TRACE := 4
    static SNMP_LOG_VERBOSE := 5
}
struct SNMP_ERROR extends UInt32 {
    static SNMP_ERROR_NOERROR := 0
    static SNMP_ERROR_TOOBIG := 1
    static SNMP_ERROR_NOSUCHNAME := 2
    static SNMP_ERROR_BADVALUE := 3
    static SNMP_ERROR_READONLY := 4
    static SNMP_ERROR_GENERR := 5
    static SNMP_ERROR_NOACCESS := 6
    static SNMP_ERROR_WRONGTYPE := 7
    static SNMP_ERROR_WRONGLENGTH := 8
    static SNMP_ERROR_WRONGENCODING := 9
    static SNMP_ERROR_WRONGVALUE := 10
    static SNMP_ERROR_NOCREATION := 11
    static SNMP_ERROR_INCONSISTENTVALUE := 12
    static SNMP_ERROR_RESOURCEUNAVAILABLE := 13
    static SNMP_ERROR_COMMITFAILED := 14
    static SNMP_ERROR_UNDOFAILED := 15
    static SNMP_ERROR_AUTHORIZATIONERROR := 16
    static SNMP_ERROR_NOTWRITABLE := 17
    static SNMP_ERROR_INCONSISTENTNAME := 18
}
struct AsnOctetString {
    stream : UInt8.Ptr
    length : UInt32
    dynamic : BOOL
}
struct AsnObjectIdentifier {
    idLength : UInt32
    ids : UInt32.Ptr
}
struct SnmpVarBindList {
    list : SnmpVarBind.Ptr
    len : UInt32
}
struct AsnAny {
    asnType : UInt8
    asnValue : this._asnValue_e__Union
    struct _asnValue_e__Union {
        union {
            number : Int32
            unsigned32 : UInt32
            counter64 : Int64
            string : AsnOctetString
            bits : AsnOctetString
            object : AsnObjectIdentifier
            sequence : AsnOctetString
            address : AsnOctetString
            counter : UInt32
            gauge : UInt32
            ticks : UInt32
            arbitrary : AsnOctetString
        }
    }
}
struct SnmpVarBind {
    name : AsnObjectIdentifier
    value : AsnAny
}
struct PFNSNMPEXTENSIONINIT extends FunctionPointer {
    static Types := [UInt32, HANDLE.Ptr, AsnObjectIdentifier.Ptr, BOOL]
}
struct PFNSNMPEXTENSIONINITEX extends FunctionPointer {
    static Types := [AsnObjectIdentifier.Ptr, BOOL]
}
struct PFNSNMPEXTENSIONMONITOR extends FunctionPointer {
    static Types := [Struct.Ptr, BOOL]
}
struct PFNSNMPEXTENSIONQUERY extends FunctionPointer {
    static Types := [UInt8, SnmpVarBindList.Ptr, Int32.Ptr, Int32.Ptr, BOOL]
}
struct PFNSNMPEXTENSIONQUERYEX extends FunctionPointer {
    static Types := [UInt32, UInt32, SnmpVarBindList.Ptr, AsnOctetString.Ptr, Int32.Ptr, Int32.Ptr, BOOL]
}
struct PFNSNMPEXTENSIONTRAP extends FunctionPointer {
    static Types := [AsnObjectIdentifier.Ptr, Int32.Ptr, Int32.Ptr, UInt32.Ptr, SnmpVarBindList.Ptr, BOOL]
}
struct PFNSNMPEXTENSIONCLOSE extends FunctionPointer {
    static Types := ["Void"]
}
struct smiOCTETS {
    len : UInt32
    ptr : UInt8.Ptr
}
struct smiOID {
    len : UInt32
    ptr : UInt32.Ptr
}
struct smiCNTR64 {
    hipart : UInt32
    lopart : UInt32
}
struct smiVALUE {
    syntax : UInt32
    value : this._value_e__Union
    struct _value_e__Union {
        union {
            sNumber : Int32
            uNumber : UInt32
            hNumber : smiCNTR64
            string : smiOCTETS
            oid : smiOID
            empty : UInt8
        }
    }
}
struct smiVENDORINFO {
    vendorName : CHAR[64]
    vendorContact : CHAR[64]
    vendorVersionId : CHAR[32]
    vendorVersionDate : CHAR[32]
    vendorEnterprise : UInt32
}
struct SNMPAPI_CALLBACK extends FunctionPointer {
    static Types := [IntPtr, HWND, UInt32, WPARAM, LPARAM, Struct.Ptr, UInt32]
}
struct PFNSNMPSTARTUPEX extends FunctionPointer {
    static Types := [UInt32.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32.Ptr, UInt32]
}
struct PFNSNMPCLEANUPEX extends FunctionPointer {
    static Types := [UInt32]
}
