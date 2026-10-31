#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {CHAR}

struct MODEM_STATUS_FLAGS extends UInt32 {
    static MS_CTS_ON := 16
    static MS_DSR_ON := 32
    static MS_RING_ON := 64
    static MS_RLSD_ON := 128
}
struct CLEAR_COMM_ERROR_FLAGS extends UInt32 {
    static CE_BREAK := 16
    static CE_FRAME := 8
    static CE_OVERRUN := 2
    static CE_RXOVER := 1
    static CE_RXPARITY := 4
}
struct PURGE_COMM_FLAGS extends UInt32 {
    static PURGE_RXABORT := 2
    static PURGE_RXCLEAR := 8
    static PURGE_TXABORT := 1
    static PURGE_TXCLEAR := 4
}
struct COMM_EVENT_MASK extends UInt32 {
    static EV_BREAK := 64
    static EV_CTS := 8
    static EV_DSR := 16
    static EV_ERR := 128
    static EV_EVENT1 := 2048
    static EV_EVENT2 := 4096
    static EV_PERR := 512
    static EV_RING := 256
    static EV_RLSD := 32
    static EV_RX80FULL := 1024
    static EV_RXCHAR := 1
    static EV_RXFLAG := 2
    static EV_TXEMPTY := 4
}
struct ESCAPE_COMM_FUNCTION extends UInt32 {
    static CLRBREAK := 9
    static CLRDTR := 6
    static CLRRTS := 4
    static SETBREAK := 8
    static SETDTR := 5
    static SETRTS := 3
    static SETXOFF := 1
    static SETXON := 2
}
struct MODEMDEVCAPS_DIAL_OPTIONS extends UInt32 {
    static DIALOPTION_BILLING := 64
    static DIALOPTION_DIALTONE := 256
    static DIALOPTION_QUIET := 128
}
struct MODEMSETTINGS_SPEAKER_MODE extends UInt32 {
    static MDMSPKR_CALLSETUP := 8
    static MDMSPKR_DIAL := 2
    static MDMSPKR_OFF := 1
    static MDMSPKR_ON := 4
}
struct COMMPROP_STOP_PARITY extends UInt16 {
    static STOPBITS_10 := 1
    static STOPBITS_15 := 2
    static STOPBITS_20 := 4
    static PARITY_NONE := 256
    static PARITY_ODD := 512
    static PARITY_EVEN := 1024
    static PARITY_MARK := 2048
    static PARITY_SPACE := 4096
}
struct MODEM_SPEAKER_VOLUME extends UInt32 {
    static MDMVOL_HIGH := 2
    static MDMVOL_LOW := 0
    static MDMVOL_MEDIUM := 1
}
struct MODEMDEVCAPS_SPEAKER_VOLUME extends UInt32 {
    static MDMVOLFLAG_HIGH := 4
    static MDMVOLFLAG_LOW := 1
    static MDMVOLFLAG_MEDIUM := 2
}
struct MODEMDEVCAPS_SPEAKER_MODE extends UInt32 {
    static MDMSPKRFLAG_CALLSETUP := 8
    static MDMSPKRFLAG_DIAL := 2
    static MDMSPKRFLAG_OFF := 1
    static MDMSPKRFLAG_ON := 4
}
struct DCB_STOP_BITS extends UInt8 {
    static ONESTOPBIT := 0
    static ONE5STOPBITS := 1
    static TWOSTOPBITS := 2
}
struct DCB_PARITY extends UInt8 {
    static EVENPARITY := 2
    static MARKPARITY := 3
    static NOPARITY := 0
    static ODDPARITY := 1
    static SPACEPARITY := 4
}
struct MODEMDEVCAPS {
    dwActualSize : UInt32
    dwRequiredSize : UInt32
    dwDevSpecificOffset : UInt32
    dwDevSpecificSize : UInt32
    dwModemProviderVersion : UInt32
    dwModemManufacturerOffset : UInt32
    dwModemManufacturerSize : UInt32
    dwModemModelOffset : UInt32
    dwModemModelSize : UInt32
    dwModemVersionOffset : UInt32
    dwModemVersionSize : UInt32
    dwDialOptions : MODEMDEVCAPS_DIAL_OPTIONS
    dwCallSetupFailTimer : UInt32
    dwInactivityTimeout : UInt32
    dwSpeakerVolume : MODEMDEVCAPS_SPEAKER_VOLUME
    dwSpeakerMode : MODEMDEVCAPS_SPEAKER_MODE
    dwModemOptions : UInt32
    dwMaxDTERate : UInt32
    dwMaxDCERate : UInt32
    abVariablePortion : UInt8[1]
}
struct MODEMSETTINGS {
    dwActualSize : UInt32
    dwRequiredSize : UInt32
    dwDevSpecificOffset : UInt32
    dwDevSpecificSize : UInt32
    dwCallSetupFailTimer : UInt32
    dwInactivityTimeout : UInt32
    dwSpeakerVolume : MODEM_SPEAKER_VOLUME
    dwSpeakerMode : MODEMSETTINGS_SPEAKER_MODE
    dwPreferredModemOptions : UInt32
    dwNegotiatedModemOptions : UInt32
    dwNegotiatedDCERate : UInt32
    abVariablePortion : UInt8[1]
}
struct COMMPROP {
    wPacketLength : UInt16
    wPacketVersion : UInt16
    dwServiceMask : UInt32
    dwReserved1 : UInt32
    dwMaxTxQueue : UInt32
    dwMaxRxQueue : UInt32
    dwMaxBaud : UInt32
    dwProvSubType : UInt32
    dwProvCapabilities : UInt32
    dwSettableParams : UInt32
    dwSettableBaud : UInt32
    wSettableData : UInt16
    wSettableStopParity : COMMPROP_STOP_PARITY
    dwCurrentTxQueue : UInt32
    dwCurrentRxQueue : UInt32
    dwProvSpec1 : UInt32
    dwProvSpec2 : UInt32
    wcProvChar : UInt16[1]
}
struct COMSTAT {
    _bitfield : UInt32
    cbInQue : UInt32
    cbOutQue : UInt32
}
struct DCB {
    DCBlength : UInt32
    BaudRate : UInt32
    _bitfield : UInt32
    wReserved : UInt16
    XonLim : UInt16
    XoffLim : UInt16
    ByteSize : UInt8
    Parity : DCB_PARITY
    StopBits : DCB_STOP_BITS
    XonChar : CHAR
    XoffChar : CHAR
    ErrorChar : CHAR
    EofChar : CHAR
    EvtChar : CHAR
    wReserved1 : UInt16
}
struct COMMTIMEOUTS {
    ReadIntervalTimeout : UInt32
    ReadTotalTimeoutMultiplier : UInt32
    ReadTotalTimeoutConstant : UInt32
    WriteTotalTimeoutMultiplier : UInt32
    WriteTotalTimeoutConstant : UInt32
}
struct COMMCONFIG {
    dwSize : UInt32
    wVersion : UInt16
    wReserved : UInt16
    dcb : DCB
    dwProviderSubType : UInt32
    dwProviderOffset : UInt32
    dwProviderSize : UInt32
    wcProviderData : UInt16[1]
}
