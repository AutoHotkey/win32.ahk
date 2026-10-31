#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {PSTR}
#Import "..\System.Diagnostics.Debug\Types.ahk" {CONTEXT, EXCEPTION_RECORD}

struct EXCEPTION_DISPOSITION extends Int32 {
    static ExceptionContinueExecution := 0
    static ExceptionContinueSearch := 1
    static ExceptionNestedException := 2
    static ExceptionCollidedUnwind := 3
}
struct SLIST_ENTRY {
    Next : SLIST_ENTRY.Ptr
}
struct QUAD {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            UseThisFieldToCopy : Int64
            DoNotUseThisField : Float64
        }
    }
}
struct PROCESSOR_NUMBER {
    Group : UInt16
    Number : UInt8
    Reserved : UInt8
}
struct EVENT_TYPE extends Int32 {
    static NotificationEvent := 0
    static SynchronizationEvent := 1
}
struct TIMER_TYPE extends Int32 {
    static NotificationTimer := 0
    static SynchronizationTimer := 1
}
struct WAIT_TYPE extends Int32 {
    static WaitAll := 0
    static WaitAny := 1
    static WaitNotification := 2
    static WaitDequeue := 3
    static WaitDpc := 4
}
struct STRING {
    Length : UInt16
    MaximumLength : UInt16
    Buffer : PSTR
}
struct CSTRING {
    Length : UInt16
    MaximumLength : UInt16
    Buffer : PSTR
}
struct LIST_ENTRY {
    Flink : LIST_ENTRY.Ptr
    Blink : LIST_ENTRY.Ptr
}
struct SINGLE_LIST_ENTRY {
    Next : SINGLE_LIST_ENTRY.Ptr
}
struct RTL_BALANCED_NODE {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            Children : RTL_BALANCED_NODE.Ptr[2]
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Left : RTL_BALANCED_NODE.Ptr
            Right : RTL_BALANCED_NODE.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            _bitfield : UInt8
            ParentValue : IntPtr
        }
    }
}
struct LIST_ENTRY32 {
    Flink : UInt32
    Blink : UInt32
}
struct LIST_ENTRY64 {
    Flink : Int64
    Blink : Int64
}
struct SINGLE_LIST_ENTRY32 {
    Next : UInt32
}
struct WNF_STATE_NAME {
    Data : UInt32[2]
}
struct STRING32 {
    Length : UInt16
    MaximumLength : UInt16
    Buffer : UInt32
}
struct STRING64 {
    Length : UInt16
    MaximumLength : UInt16
    Buffer : Int64
}
struct OBJECTID {
    Lineage : GUID
    Uniquifier : UInt32
}
struct EXCEPTION_ROUTINE extends FunctionPointer {
    static Types := [EXCEPTION_RECORD.Ptr, Struct.Ptr, CONTEXT.Ptr, Struct.Ptr, EXCEPTION_DISPOSITION]
}
struct NT_PRODUCT_TYPE extends Int32 {
    static NtProductWinNt := 1
    static NtProductLanManNt := 2
    static NtProductServer := 3
}
struct SUITE_TYPE extends Int32 {
    static SmallBusiness := 0
    static Enterprise := 1
    static BackOffice := 2
    static CommunicationServer := 3
    static TerminalServer := 4
    static SmallBusinessRestricted := 5
    static EmbeddedNT := 6
    static DataCenter := 7
    static SingleUserTS := 8
    static Personal := 9
    static Blade := 10
    static EmbeddedRestricted := 11
    static SecurityAppliance := 12
    static StorageServer := 13
    static ComputeServer := 14
    static WHServer := 15
    static PhoneNT := 16
    static MultiUserTS := 17
    static MaxSuiteType := 18
}
struct SLIST_HEADER {
    union {
        Anonymous : this._Anonymous_e__Struct
        HeaderX64 : this._HeaderX64_e__Struct
    }
    struct _Anonymous_e__Struct {
        Alignment : Int64
        Region : Int64
    }
    struct _HeaderX64_e__Struct {
        _bitfield1 : Int64
        _bitfield2 : Int64
    }
}
struct FLOATING_SAVE_AREA {
    ControlWord : UInt32
    StatusWord : UInt32
    TagWord : UInt32
    ErrorOffset : UInt32
    ErrorSelector : UInt32
    DataOffset : UInt32
    DataSelector : UInt32
    RegisterArea : UInt8[80]
    Cr0NpxState : UInt32
}
struct COMPARTMENT_ID extends Int32 {
    static UNSPECIFIED_COMPARTMENT_ID := 0
    static DEFAULT_COMPARTMENT_ID := 1
}
struct EXCEPTION_REGISTRATION_RECORD {
    Next : EXCEPTION_REGISTRATION_RECORD.Ptr
    Handler : EXCEPTION_ROUTINE
}
struct NT_TIB {
    ExceptionList : EXCEPTION_REGISTRATION_RECORD.Ptr
    StackBase : Struct.Ptr
    StackLimit : Struct.Ptr
    SubSystemTib : Struct.Ptr
    Anonymous : this._Anonymous_e__Union
    ArbitraryUserPointer : Struct.Ptr
    Self : NT_TIB.Ptr
    struct _Anonymous_e__Union {
        union {
            FiberData : Struct.Ptr
            Version : UInt32
        }
    }
}
