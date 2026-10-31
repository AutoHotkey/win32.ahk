#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN}

struct HCOMDB {
    Value : IntPtr
}
struct SERIALPERF_STATS {
    ReceivedCount : UInt32
    TransmittedCount : UInt32
    FrameErrorCount : UInt32
    SerialOverrunErrorCount : UInt32
    BufferOverrunErrorCount : UInt32
    ParityErrorCount : UInt32
}
struct SERIALCONFIG {
    Size : UInt32
    Version : UInt16
    SubType : UInt32
    ProvOffset : UInt32
    ProviderSize : UInt32
    ProviderData : UInt16[1]
}
struct SERIAL_LINE_CONTROL {
    StopBits : UInt8
    Parity : UInt8
    WordLength : UInt8
}
struct SERIAL_TIMEOUTS {
    ReadIntervalTimeout : UInt32
    ReadTotalTimeoutMultiplier : UInt32
    ReadTotalTimeoutConstant : UInt32
    WriteTotalTimeoutMultiplier : UInt32
    WriteTotalTimeoutConstant : UInt32
}
struct SERIAL_QUEUE_SIZE {
    InSize : UInt32
    OutSize : UInt32
}
struct SERIAL_BAUD_RATE {
    BaudRate : UInt32
}
struct SERIAL_CHARS {
    EofChar : UInt8
    ErrorChar : UInt8
    BreakChar : UInt8
    EventChar : UInt8
    XonChar : UInt8
    XoffChar : UInt8
}
struct SERIAL_HANDFLOW {
    ControlHandShake : UInt32
    FlowReplace : UInt32
    XonLimit : Int32
    XoffLimit : Int32
}
struct SERIAL_BASIC_SETTINGS {
    Timeouts : SERIAL_TIMEOUTS
    HandFlow : SERIAL_HANDFLOW
    RxFifo : UInt32
    TxFifo : UInt32
}
struct SERIAL_STATUS {
    Errors : UInt32
    HoldReasons : UInt32
    AmountInInQueue : UInt32
    AmountInOutQueue : UInt32
    EofReceived : BOOLEAN
    WaitForImmediate : BOOLEAN
}
struct SERIAL_XOFF_COUNTER {
    Timeout : UInt32
    Counter : Int32
    XoffChar : UInt8
}
struct SERIAL_COMMPROP {
    PacketLength : UInt16
    PacketVersion : UInt16
    ServiceMask : UInt32
    Reserved1 : UInt32
    MaxTxQueue : UInt32
    MaxRxQueue : UInt32
    MaxBaud : UInt32
    ProvSubType : UInt32
    ProvCapabilities : UInt32
    SettableParams : UInt32
    SettableBaud : UInt32
    SettableData : UInt16
    SettableStopParity : UInt16
    CurrentTxQueue : UInt32
    CurrentRxQueue : UInt32
    ProvSpec1 : UInt32
    ProvSpec2 : UInt32
    ProvChar : UInt16[1]
}
struct SERENUM_PORT_DESC {
    Size : UInt32
    PortHandle : Struct.Ptr
    PortAddress : Int64
    Reserved : UInt16[1]
}
struct PSERENUM_READPORT extends FunctionPointer {
    static Types := [Struct.Ptr, UInt8]
}
struct PSERENUM_WRITEPORT extends FunctionPointer {
    static Types := [Struct.Ptr, UInt8, "Void"]
}
struct SERENUM_PORTION extends Int32 {
    static SerenumFirstHalf := 0
    static SerenumSecondHalf := 1
    static SerenumWhole := 2
}
struct SERENUM_PORT_PARAMETERS {
    Size : UInt32
    ReadAccessor : PSERENUM_READPORT
    WriteAccessor : PSERENUM_WRITEPORT
    SerPortAddress : Struct.Ptr
    HardwareHandle : Struct.Ptr
    Portion : SERENUM_PORTION
    NumberAxis : UInt16
    Reserved : UInt16[3]
}
