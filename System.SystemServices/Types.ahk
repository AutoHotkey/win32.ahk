#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, CHAR, HANDLE, LUID, PSTR, PWSTR}
#Import "..\Graphics.Gdi\Types.ahk" {LOGPALETTE}
#Import "..\Security\Types.ahk" {PSID, SECURITY_CAPABILITIES, SECURITY_IMPERSONATION_LEVEL, SID, SID_AND_ATTRIBUTES, TOKEN_ELEVATION, TOKEN_ELEVATION_TYPE, TOKEN_TYPE, TOKEN_USER}
#Import "..\System.Com\Types.ahk" {BYTE_BLOB, DWORD_BLOB, FLAGGED_BYTE_BLOB}
#Import "..\System.Diagnostics.Debug\Types.ahk" {EXCEPTION_POINTERS, IMAGE_RUNTIME_FUNCTION_ENTRY}
#Import "..\System.Power\Types.ahk" {SYSTEM_BATTERY_STATE}
#Import "..\System.SystemInformation\Types.ahk" {GROUP_AFFINITY}

struct ALERT_SYSTEM_SEV extends UInt32 {
    static ALERT_SYSTEM_INFORMATIONAL := 1
    static ALERT_SYSTEM_WARNING := 2
    static ALERT_SYSTEM_ERROR := 3
    static ALERT_SYSTEM_QUERY := 4
    static ALERT_SYSTEM_CRITICAL := 5
}
struct APPCOMMAND_ID extends UInt32 {
    static APPCOMMAND_BROWSER_BACKWARD := 1
    static APPCOMMAND_BROWSER_FORWARD := 2
    static APPCOMMAND_BROWSER_REFRESH := 3
    static APPCOMMAND_BROWSER_STOP := 4
    static APPCOMMAND_BROWSER_SEARCH := 5
    static APPCOMMAND_BROWSER_FAVORITES := 6
    static APPCOMMAND_BROWSER_HOME := 7
    static APPCOMMAND_VOLUME_MUTE := 8
    static APPCOMMAND_VOLUME_DOWN := 9
    static APPCOMMAND_VOLUME_UP := 10
    static APPCOMMAND_MEDIA_NEXTTRACK := 11
    static APPCOMMAND_MEDIA_PREVIOUSTRACK := 12
    static APPCOMMAND_MEDIA_STOP := 13
    static APPCOMMAND_MEDIA_PLAY_PAUSE := 14
    static APPCOMMAND_LAUNCH_MAIL := 15
    static APPCOMMAND_LAUNCH_MEDIA_SELECT := 16
    static APPCOMMAND_LAUNCH_APP1 := 17
    static APPCOMMAND_LAUNCH_APP2 := 18
    static APPCOMMAND_BASS_DOWN := 19
    static APPCOMMAND_BASS_BOOST := 20
    static APPCOMMAND_BASS_UP := 21
    static APPCOMMAND_TREBLE_DOWN := 22
    static APPCOMMAND_TREBLE_UP := 23
    static APPCOMMAND_MICROPHONE_VOLUME_MUTE := 24
    static APPCOMMAND_MICROPHONE_VOLUME_DOWN := 25
    static APPCOMMAND_MICROPHONE_VOLUME_UP := 26
    static APPCOMMAND_HELP := 27
    static APPCOMMAND_FIND := 28
    static APPCOMMAND_NEW := 29
    static APPCOMMAND_OPEN := 30
    static APPCOMMAND_CLOSE := 31
    static APPCOMMAND_SAVE := 32
    static APPCOMMAND_PRINT := 33
    static APPCOMMAND_UNDO := 34
    static APPCOMMAND_REDO := 35
    static APPCOMMAND_COPY := 36
    static APPCOMMAND_CUT := 37
    static APPCOMMAND_PASTE := 38
    static APPCOMMAND_REPLY_TO_MAIL := 39
    static APPCOMMAND_FORWARD_MAIL := 40
    static APPCOMMAND_SEND_MAIL := 41
    static APPCOMMAND_SPELL_CHECK := 42
    static APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE := 43
    static APPCOMMAND_MIC_ON_OFF_TOGGLE := 44
    static APPCOMMAND_CORRECTION_LIST := 45
    static APPCOMMAND_MEDIA_PLAY := 46
    static APPCOMMAND_MEDIA_PAUSE := 47
    static APPCOMMAND_MEDIA_RECORD := 48
    static APPCOMMAND_MEDIA_FAST_FORWARD := 49
    static APPCOMMAND_MEDIA_REWIND := 50
    static APPCOMMAND_MEDIA_CHANNEL_UP := 51
    static APPCOMMAND_MEDIA_CHANNEL_DOWN := 52
    static APPCOMMAND_DELETE := 53
    static APPCOMMAND_DWM_FLIP3D := 54
}
struct ATF_FLAGS extends UInt32 {
    static ATF_TIMEOUTON := 1
    static ATF_ONOFFFEEDBACK := 2
}
struct GESTURECONFIG_FLAGS extends UInt32 {
    static GC_ALLGESTURES := 1
    static GC_ZOOM := 1
    static GC_PAN := 1
    static GC_PAN_WITH_SINGLE_FINGER_VERTICALLY := 2
    static GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY := 4
    static GC_PAN_WITH_GUTTER := 8
    static GC_PAN_WITH_INERTIA := 16
    static GC_ROTATE := 1
    static GC_TWOFINGERTAP := 1
    static GC_PRESSANDTAP := 1
    static GC_ROLLOVER := 1
}
struct CFE_UNDERLINE extends UInt32 {
    static CFU_CF1UNDERLINE := 255
    static CFU_INVERT := 254
    static CFU_UNDERLINETHICKLONGDASH := 18
    static CFU_UNDERLINETHICKDOTTED := 17
    static CFU_UNDERLINETHICKDASHDOTDOT := 16
    static CFU_UNDERLINETHICKDASHDOT := 15
    static CFU_UNDERLINETHICKDASH := 14
    static CFU_UNDERLINELONGDASH := 13
    static CFU_UNDERLINEHEAVYWAVE := 12
    static CFU_UNDERLINEDOUBLEWAVE := 11
    static CFU_UNDERLINEHAIRLINE := 10
    static CFU_UNDERLINETHICK := 9
    static CFU_UNDERLINEWAVE := 8
    static CFU_UNDERLINEDASHDOTDOT := 7
    static CFU_UNDERLINEDASHDOT := 6
    static CFU_UNDERLINEDASH := 5
    static CFU_UNDERLINEDOTTED := 4
    static CFU_UNDERLINEDOUBLE := 3
    static CFU_UNDERLINEWORD := 2
    static CFU_UNDERLINE := 1
    static CFU_UNDERLINENONE := 0
}
struct IGP_ID extends UInt32 {
    static IGP_GETIMEVERSION := 4294967292
    static IGP_PROPERTY := 4
    static IGP_CONVERSION := 8
    static IGP_SENTENCE := 12
    static IGP_UI := 16
    static IGP_SETCOMPSTR := 20
    static IGP_SELECT := 24
}
struct WORD_WHEEL_OPEN_FLAGS extends UInt32 {
    static ITWW_OPEN_CONNECT := 0
}
struct TAPE_GET_DRIVE_PARAMETERS_FEATURES_HIGH extends UInt32 {
    static TAPE_DRIVE_ABS_BLK_IMMED := 2147491840
    static TAPE_DRIVE_ABSOLUTE_BLK := 2147487744
    static TAPE_DRIVE_END_OF_DATA := 2147549184
    static TAPE_DRIVE_FILEMARKS := 2147745792
    static TAPE_DRIVE_LOAD_UNLOAD := 2147483649
    static TAPE_DRIVE_LOAD_UNLD_IMMED := 2147483680
    static TAPE_DRIVE_LOCK_UNLOCK := 2147483652
    static TAPE_DRIVE_LOCK_UNLK_IMMED := 2147483776
    static TAPE_DRIVE_LOG_BLK_IMMED := 2147516416
    static TAPE_DRIVE_LOGICAL_BLK := 2147500032
    static TAPE_DRIVE_RELATIVE_BLKS := 2147614720
    static TAPE_DRIVE_REVERSE_POSITION := 2151677952
    static TAPE_DRIVE_REWIND_IMMEDIATE := 2147483656
    static TAPE_DRIVE_SEQUENTIAL_FMKS := 2148007936
    static TAPE_DRIVE_SEQUENTIAL_SMKS := 2149580800
    static TAPE_DRIVE_SET_BLOCK_SIZE := 2147483664
    static TAPE_DRIVE_SET_COMPRESSION := 2147484160
    static TAPE_DRIVE_SET_ECC := 2147483904
    static TAPE_DRIVE_SET_PADDING := 2147484672
    static TAPE_DRIVE_SET_REPORT_SMKS := 2147485696
    static TAPE_DRIVE_SETMARKS := 2148532224
    static TAPE_DRIVE_SPACE_IMMEDIATE := 2155872256
    static TAPE_DRIVE_TENSION := 2147483650
    static TAPE_DRIVE_TENSION_IMMED := 2147483712
    static TAPE_DRIVE_WRITE_FILEMARKS := 2181038080
    static TAPE_DRIVE_WRITE_LONG_FMKS := 2281701376
    static TAPE_DRIVE_WRITE_MARK_IMMED := 2415919104
    static TAPE_DRIVE_WRITE_SETMARKS := 2164260864
    static TAPE_DRIVE_WRITE_SHORT_FMKS := 2214592512
}
struct MODIFIERKEYS_FLAGS extends UInt32 {
    static MK_LBUTTON := 1
    static MK_RBUTTON := 2
    static MK_SHIFT := 4
    static MK_CONTROL := 8
    static MK_MBUTTON := 16
    static MK_XBUTTON1 := 32
    static MK_XBUTTON2 := 64
}
struct STATIC_STYLES extends UInt32 {
    static SS_LEFT := 0
    static SS_CENTER := 1
    static SS_RIGHT := 2
    static SS_ICON := 3
    static SS_BLACKRECT := 4
    static SS_GRAYRECT := 5
    static SS_WHITERECT := 6
    static SS_BLACKFRAME := 7
    static SS_GRAYFRAME := 8
    static SS_WHITEFRAME := 9
    static SS_USERITEM := 10
    static SS_SIMPLE := 11
    static SS_LEFTNOWORDWRAP := 12
    static SS_OWNERDRAW := 13
    static SS_BITMAP := 14
    static SS_ENHMETAFILE := 15
    static SS_ETCHEDHORZ := 16
    static SS_ETCHEDVERT := 17
    static SS_ETCHEDFRAME := 18
    static SS_TYPEMASK := 31
    static SS_REALSIZECONTROL := 64
    static SS_NOPREFIX := 128
    static SS_NOTIFY := 256
    static SS_CENTERIMAGE := 512
    static SS_RIGHTJUST := 1024
    static SS_REALSIZEIMAGE := 2048
    static SS_SUNKEN := 4096
    static SS_EDITCONTROL := 8192
    static SS_ENDELLIPSIS := 16384
    static SS_PATHELLIPSIS := 32768
    static SS_WORDELLIPSIS := 49152
    static SS_ELLIPSISMASK := 49152
}
struct RECO_FLAGS extends UInt32 {
    static RECO_PASTE := 0
    static RECO_DROP := 1
    static RECO_COPY := 2
    static RECO_CUT := 3
    static RECO_DRAG := 4
}
struct SFGAO_FLAGS extends UInt32 {
    static SFGAO_CANCOPY := 1
    static SFGAO_CANMOVE := 2
    static SFGAO_CANLINK := 4
    static SFGAO_STORAGE := 8
    static SFGAO_CANRENAME := 16
    static SFGAO_CANDELETE := 32
    static SFGAO_HASPROPSHEET := 64
    static SFGAO_DROPTARGET := 256
    static SFGAO_CAPABILITYMASK := 375
    static SFGAO_PLACEHOLDER := 2048
    static SFGAO_SYSTEM := 4096
    static SFGAO_ENCRYPTED := 8192
    static SFGAO_ISSLOW := 16384
    static SFGAO_GHOSTED := 32768
    static SFGAO_LINK := 65536
    static SFGAO_SHARE := 131072
    static SFGAO_READONLY := 262144
    static SFGAO_HIDDEN := 524288
    static SFGAO_DISPLAYATTRMASK := 1032192
    static SFGAO_FILESYSANCESTOR := 268435456
    static SFGAO_FOLDER := 536870912
    static SFGAO_FILESYSTEM := 1073741824
    static SFGAO_HASSUBFOLDER := 2147483648
    static SFGAO_CONTENTSMASK := 2147483648
    static SFGAO_VALIDATE := 16777216
    static SFGAO_REMOVABLE := 33554432
    static SFGAO_COMPRESSED := 67108864
    static SFGAO_BROWSABLE := 134217728
    static SFGAO_NONENUMERATED := 1048576
    static SFGAO_NEWCONTENT := 2097152
    static SFGAO_CANMONIKER := 4194304
    static SFGAO_HASSTORAGE := 4194304
    static SFGAO_STREAM := 4194304
    static SFGAO_STORAGEANCESTOR := 8388608
    static SFGAO_STORAGECAPMASK := 1891958792
    static SFGAO_PKEYSFGAOMASK := 2164539392
}
struct PUMS_SCHEDULER_ENTRY_POINT extends FunctionPointer {
    static Types := [RTL_UMS_SCHEDULER_REASON, IntPtr, Struct.Ptr, "Void"]
}
struct RemHGLOBAL {
    fNullHGlobal : Int32
    cbData : UInt32
    data : UInt8[1]
}
struct RemHMETAFILEPICT {
    mm : Int32
    xExt : Int32
    yExt : Int32
    cbData : UInt32
    data : UInt8[1]
}
struct RemHENHMETAFILE {
    cbData : UInt32
    data : UInt8[1]
}
struct RemHBITMAP {
    cbData : UInt32
    data : UInt8[1]
}
struct RemHPALETTE {
    cbData : UInt32
    data : UInt8[1]
}
struct RemHBRUSH {
    cbData : UInt32
    data : UInt8[1]
}
struct userCLIPFORMAT {
    fContext : Int32
    u : this._u_e__Struct
    struct _u_e__Struct {
        union {
            dwValue : UInt32
            pwszName : PWSTR
        }
    }
}
struct GDI_NONREMOTE {
    fContext : Int32
    u : this._u_e__Struct
    struct _u_e__Struct {
        union {
            hInproc : Int32
            hRemote : DWORD_BLOB.Ptr
        }
    }
}
struct userHGLOBAL {
    fContext : Int32
    u : this._u_e__Struct
    struct _u_e__Struct {
        union {
            hInproc : Int32
            hRemote : FLAGGED_BYTE_BLOB.Ptr
            hInproc64 : Int64
        }
    }
}
struct userHMETAFILE {
    fContext : Int32
    u : this._u_e__Struct
    struct _u_e__Struct {
        union {
            hInproc : Int32
            hRemote : BYTE_BLOB.Ptr
            hInproc64 : Int64
        }
    }
}
struct remoteMETAFILEPICT {
    mm : Int32
    xExt : Int32
    yExt : Int32
    hMF : userHMETAFILE.Ptr
}
struct userHMETAFILEPICT {
    fContext : Int32
    u : this._u_e__Struct
    struct _u_e__Struct {
        union {
            hInproc : Int32
            hRemote : remoteMETAFILEPICT.Ptr
            hInproc64 : Int64
        }
    }
}
struct userHENHMETAFILE {
    fContext : Int32
    u : this._u_e__Struct
    struct _u_e__Struct {
        union {
            hInproc : Int32
            hRemote : BYTE_BLOB.Ptr
            hInproc64 : Int64
        }
    }
}
struct userBITMAP {
    bmType : Int32
    bmWidth : Int32
    bmHeight : Int32
    bmWidthBytes : Int32
    bmPlanes : UInt16
    bmBitsPixel : UInt16
    cbSize : UInt32 := this.Size
    pBuffer : UInt8[1]
}
struct userHBITMAP {
    fContext : Int32
    u : this._u_e__Struct
    struct _u_e__Struct {
        union {
            hInproc : Int32
            hRemote : userBITMAP.Ptr
            hInproc64 : Int64
        }
    }
}
struct userHPALETTE {
    fContext : Int32
    u : this._u_e__Struct
    struct _u_e__Struct {
        union {
            hInproc : Int32
            hRemote : LOGPALETTE.Ptr
            hInproc64 : Int64
        }
    }
}
struct RemotableHandle {
    fContext : Int32
    u : this._u_e__Struct
    struct _u_e__Struct {
        union {
            hInproc : Int32
            hRemote : Int32
        }
    }
}
struct REDBOOK_DIGITAL_AUDIO_EXTRACTION_INFO {
    Version : UInt32
    Accurate : UInt32
    Supported : UInt32
    AccurateMask0 : UInt32
}
struct POUT_OF_PROCESS_FUNCTION_TABLE_CALLBACK extends FunctionPointer {
    static Types := [HANDLE, Struct.Ptr, UInt32.Ptr, IMAGE_RUNTIME_FUNCTION_ENTRY.Ptr.Ptr, UInt32]
}
struct PEXCEPTION_FILTER extends FunctionPointer {
    static Types := [EXCEPTION_POINTERS.Ptr, Struct.Ptr, Int32]
}
struct PTERMINATION_HANDLER extends FunctionPointer {
    static Types := [BOOLEAN, Struct.Ptr, "Void"]
}
struct REARRANGE_FILE_DATA32 {
    SourceStartingOffset : Int64
    TargetOffset : Int64
    SourceFileHandle : UInt32
    Length : UInt32
    Flags : UInt32
}
struct XSAVE_CET_U_FORMAT {
    Ia32CetUMsr : Int64
    Ia32Pl3SspMsr : Int64
}
struct XSAVE_ARM64_SVE_HEADER {
    VectorLength : UInt32
    VectorRegisterOffset : UInt32
    PredicateRegisterOffset : UInt32
    Anonymous : this._Anonymous_e__Union
    Reserved : UInt32[4]
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct XSAVE_ARM64_SME_ZA_HEADER {
    VectorLength : UInt32
    Anonymous : this._Anonymous_e__Union
    Reserved : UInt32[6]
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct XSAVE_ARM64_SME_TPIDR2_HEADER {
    Reserved : UInt32[8]
}
struct XSAVE_ARM64_SME_ZT_HEADER {
    RegisterCount : UInt32
    Reserved : UInt32[7]
}
struct KERNEL_CET_CONTEXT {
    Ssp : Int64
    Rip : Int64
    SegCs : UInt16
    Anonymous : this._Anonymous_e__Union
    Fill : UInt16[2]
    struct _Anonymous_e__Union {
        union {
            AllFlags : UInt16
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct SCOPE_TABLE_AMD64 {
    Count : UInt32
    ScopeRecord : this._Anonymous_e__Struct[1]
    struct _Anonymous_e__Struct {
        BeginAddress : UInt32
        EndAddress : UInt32
        HandlerAddress : UInt32
        JumpTarget : UInt32
    }
}
struct SCOPE_TABLE_ARM {
    Count : UInt32
    ScopeRecord : this._Anonymous_e__Struct[1]
    struct _Anonymous_e__Struct {
        BeginAddress : UInt32
        EndAddress : UInt32
        HandlerAddress : UInt32
        JumpTarget : UInt32
    }
}
struct SCOPE_TABLE_ARM64 {
    Count : UInt32
    ScopeRecord : this._Anonymous_e__Struct[1]
    struct _Anonymous_e__Struct {
        BeginAddress : UInt32
        EndAddress : UInt32
        HandlerAddress : UInt32
        JumpTarget : UInt32
    }
}
struct DISPATCHER_CONTEXT_NONVOLREG_ARM64 {
    union {
        Buffer : UInt8[152]
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        GpNvRegs : Int64[11]
        FpNvRegs : Float64[8]
    }
}
struct ARM64_TPIDR2_BLOCK {
    ZaSaveBuffer : Struct.Ptr
    NumZaSaveSlices : UInt16
    Reserved1 : UInt16
    Reserved2 : UInt32
}
struct ATTRIBUTES_AND_SID {
    Attributes : UInt32
    SidStart : UInt32
}
struct SECURITY_OBJECT_AI_PARAMS {
    Size : UInt32
    ConstraintMask : UInt32
}
struct ACCESS_REASON_TYPE extends Int32 {
    static AccessReasonNone := 0
    static AccessReasonAllowedAce := 65536
    static AccessReasonDeniedAce := 131072
    static AccessReasonAllowedParentAce := 196608
    static AccessReasonDeniedParentAce := 262144
    static AccessReasonNotGrantedByCape := 327680
    static AccessReasonNotGrantedByParentCape := 393216
    static AccessReasonNotGrantedToAppContainer := 458752
    static AccessReasonMissingPrivilege := 1048576
    static AccessReasonFromPrivilege := 2097152
    static AccessReasonIntegrityLevel := 3145728
    static AccessReasonOwnership := 4194304
    static AccessReasonNullDacl := 5242880
    static AccessReasonEmptyDacl := 6291456
    static AccessReasonNoSD := 7340032
    static AccessReasonNoGrant := 8388608
    static AccessReasonTrustLabel := 9437184
    static AccessReasonFilterAce := 10485760
}
struct SE_TOKEN_USER {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            TokenUser : TOKEN_USER
            User : SID_AND_ATTRIBUTES
        }
    }
    struct _Anonymous2_e__Union {
        union {
            Sid : SID
            Buffer : UInt8[68]
        }
    }
}
struct TOKEN_LOGGING_INFORMATION {
    TokenType : TOKEN_TYPE
    TokenElevation : TOKEN_ELEVATION
    TokenElevationType : TOKEN_ELEVATION_TYPE
    ImpersonationLevel : SECURITY_IMPERSONATION_LEVEL
    IntegrityLevel : UInt32
    User : SID_AND_ATTRIBUTES
    TrustLevelSid : PSID
    SessionId : UInt32
    AppContainerNumber : UInt32
    AuthenticationId : LUID
    GroupCount : UInt32
    GroupsLength : UInt32
    Groups : SID_AND_ATTRIBUTES.Ptr
}
struct TOKEN_SID_INFORMATION {
    Sid : PSID
}
struct TOKEN_BNO_ISOLATION_INFORMATION {
    IsolationPrefix : PWSTR
    IsolationEnabled : BOOLEAN
}
struct SE_IMAGE_SIGNATURE_TYPE extends Int32 {
    static SeImageSignatureNone := 0
    static SeImageSignatureEmbedded := 1
    static SeImageSignatureCache := 2
    static SeImageSignatureCatalogCached := 3
    static SeImageSignatureCatalogNotCached := 4
    static SeImageSignatureCatalogHint := 5
    static SeImageSignaturePackageCatalog := 6
    static SeImageSignaturePplMitigated := 7
}
struct SECURITY_CONTAINMENT_CONFIGURATION {
    Size : UInt32
    Anonymous : this._Anonymous_e__Union
    ExistingTokenHandle : HANDLE
    SecurityCapabilities : SECURITY_CAPABILITIES
    AppContainerIntegrityLevel : UInt32
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct NT_TIB32 {
    ExceptionList : UInt32
    StackBase : UInt32
    StackLimit : UInt32
    SubSystemTib : UInt32
    Anonymous : this._Anonymous_e__Union
    ArbitraryUserPointer : UInt32
    Self : UInt32
    struct _Anonymous_e__Union {
        union {
            FiberData : UInt32
            Version : UInt32
        }
    }
}
struct NT_TIB64 {
    ExceptionList : Int64
    StackBase : Int64
    StackLimit : Int64
    SubSystemTib : Int64
    Anonymous : this._Anonymous_e__Union
    ArbitraryUserPointer : Int64
    Self : Int64
    struct _Anonymous_e__Union {
        union {
            FiberData : Int64
            Version : UInt32
        }
    }
}
struct UMS_CREATE_THREAD_ATTRIBUTES {
    UmsVersion : UInt32
    UmsContext : Struct.Ptr
    UmsCompletionList : Struct.Ptr
}
struct COMPONENT_FILTER {
    ComponentFlags : UInt32
}
struct RATE_QUOTA_LIMIT {
    union {
        RateData : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct QUOTA_LIMITS_EX {
    PagedPoolLimit : IntPtr
    NonPagedPoolLimit : IntPtr
    MinimumWorkingSetSize : IntPtr
    MaximumWorkingSetSize : IntPtr
    PagefileLimit : IntPtr
    TimeLimit : Int64
    WorkingSetLimit : IntPtr
    Reserved2 : IntPtr
    Reserved3 : IntPtr
    Reserved4 : IntPtr
    Flags : UInt32
    CpuRateLimit : RATE_QUOTA_LIMIT
}
struct PROCESS_MITIGATION_ASLR_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_DEP_POLICY {
    Anonymous : this._Anonymous_e__Union
    Permanent : BOOLEAN
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_SEHOP_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_DYNAMIC_CODE_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_CONTROL_FLOW_GUARD_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_BINARY_SIGNATURE_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_FONT_DISABLE_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_IMAGE_LOAD_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_SYSTEM_CALL_FILTER_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_PAYLOAD_RESTRICTION_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_CHILD_PROCESS_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_SIDE_CHANNEL_ISOLATION_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_USER_SHADOW_STACK_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_USER_POINTER_AUTH_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_MITIGATION_REDIRECTION_TRUST_POLICY {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Flags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PROCESS_NETWORK_COUNTERS {
    BytesIn : Int64
    BytesOut : Int64
}
struct JOBOBJECT_NETWORK_ACCOUNTING_INFORMATION {
    DataBytesIn : Int64
    DataBytesOut : Int64
}
struct SILOOBJECT_BASIC_INFORMATION {
    SiloId : UInt32
    SiloParentId : UInt32
    NumberOfProcesses : UInt32
    IsInServerSilo : BOOLEAN
    Reserved : UInt8[3]
}
struct SERVERSILO_STATE extends Int32 {
    static SERVERSILO_INITING := 0
    static SERVERSILO_STARTED := 1
    static SERVERSILO_SHUTTING_DOWN := 2
    static SERVERSILO_TERMINATING := 3
    static SERVERSILO_TERMINATED := 4
}
struct SERVERSILO_BASIC_INFORMATION {
    ServiceSessionId : UInt32
    State : SERVERSILO_STATE
    ExitStatus : UInt32
    Reserved : BOOLEAN
    ApiSetSchema : Struct.Ptr
    HostApiSetSchema : Struct.Ptr
    ContainerBuildNumber : UInt32
    HostBuildNumber : UInt32
}
struct SERVERSILO_DIAGNOSTIC_INFORMATION {
    ReportId : GUID
    ExitStatus : UInt32
    CriticalProcessName : UInt16[15]
}
struct PROCESSOR_SHARED_COMPUTE_UNIT_TYPE extends Int32 {
    static SharedComputeUnitArm64SMCU := 0
}
struct SHARED_COMPUTE_UNIT_RELATIONSHIP {
    Type : UInt32
    ComputeUnitCount : UInt32
    Reserved : UInt8[14]
    GroupCount : UInt16
    GroupMasks : GROUP_AFFINITY[1]
}
struct RUNTIME_REPORT_TYPE extends Int32 {
    static RuntimeReportTypeDriver := 0
    static RuntimeReportTypeCodeIntegrity := 1
    static RuntimeReportTypeMax := 2
}
struct RUNTIME_REPORT_PACKAGE_HEADER {
    Magic : UInt32
    PackageVersion : UInt16
    NumberOfReports : UInt16
    ReportTypesBitmap : Int64
    PackageSize : UInt32
    ReportDigestType : UInt16
    TotalReportDigestsSize : UInt16
    Reserved : UInt16
    SignatureScheme : UInt16
    SignatureSize : UInt32
    TotalAuthenticatedReportsSize : UInt32
}
struct RUNTIME_REPORT_DIGEST_HEADER {
    ReportType : UInt16
    Reserved : UInt16
    ReportDigest : UInt8[64]
}
struct RUNTIME_REPORT_HEADER {
    ReportType : UInt16
    Reserved : UInt16
    ReportSize : UInt32
}
struct DRIVER_INFO_ENTRY {
    InternalName : CHAR[32]
    ImageHashAlgorithm : UInt16
    PublisherThumbprintHashAlgorithm : UInt16
    ImageHashOffset : UInt32
    PublisherThumbprintOffset : UInt32
    NumberOfLoadingTimes : UInt16
    OemNameSize : UInt16
    OemNameOffset : UInt32
    Flags : this._Flags_e__Union
    Padding : UInt16
    struct _Flags_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUInt16 : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct DRIVER_RUNTIME_REPORT {
    Header : RUNTIME_REPORT_HEADER
    NumberOfDrivers : UInt16
    Flags : this._Flags_e__Union
    DriverEntries : DRIVER_INFO_ENTRY[1]
    struct _Flags_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUInt16 : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct CODE_INTEGRITY_RUNTIME_REPORT {
    Header : RUNTIME_REPORT_HEADER
    CurrentGeneration : Int64
    NumberOfGenerations : UInt32
}
struct CODE_INTEGRITY_REPORT_GENERATION_HEADER {
    Version : UInt16
    Reserved : UInt16
    RecordSize : UInt32
    CommitTime : Int64
}
struct CODE_INTEGRITY_REPORT_RECORD_HEADER {
    Version : UInt16
    Reserved : UInt16
    RecordSize : UInt32
    SipaEventCode : UInt32
}
struct FILE_NOTIFY_FULL_INFORMATION {
    NextEntryOffset : UInt32
    Action : UInt32
    CreationTime : Int64
    LastModificationTime : Int64
    LastChangeTime : Int64
    LastAccessTime : Int64
    AllocatedLength : Int64
    FileSize : Int64
    FileAttributes : UInt32
    Anonymous : this._Anonymous_e__Union
    FileId : Int64
    ParentFileId : Int64
    FileNameLength : UInt16
    FileNameFlags : UInt8
    Reserved : UInt8
    FileName : UInt16[1]
    struct _Anonymous_e__Union {
        union {
            ReparsePointTag : UInt32
            EaSize : UInt32
        }
    }
}
struct FILE_STAT_INFORMATION {
    FileId : Int64
    CreationTime : Int64
    LastAccessTime : Int64
    LastWriteTime : Int64
    ChangeTime : Int64
    AllocationSize : Int64
    EndOfFile : Int64
    FileAttributes : UInt32
    ReparseTag : UInt32
    NumberOfLinks : UInt32
    EffectiveAccess : UInt32
}
struct FILE_STAT_LX_INFORMATION {
    FileId : Int64
    CreationTime : Int64
    LastAccessTime : Int64
    LastWriteTime : Int64
    ChangeTime : Int64
    AllocationSize : Int64
    EndOfFile : Int64
    FileAttributes : UInt32
    ReparseTag : UInt32
    NumberOfLinks : UInt32
    EffectiveAccess : UInt32
    LxFlags : UInt32
    LxUid : UInt32
    LxGid : UInt32
    LxMode : UInt32
    LxDeviceIdMajor : UInt32
    LxDeviceIdMinor : UInt32
}
struct FILE_CASE_SENSITIVE_INFORMATION {
    Flags : UInt32
}
struct SCRUB_DATA_INPUT {
    Size : UInt32
    Flags : UInt32
    MaximumIos : UInt32
    ObjectId : UInt32[4]
    StartingByteOffset : Int64
    ByteCount : Int64
    Reserved : UInt32[36]
    ResumeContext : UInt8[1040]
}
struct SCRUB_PARITY_EXTENT {
    Offset : Int64
    Length : Int64
}
struct SCRUB_PARITY_EXTENT_DATA {
    Size : UInt16
    Flags : UInt16
    NumberOfParityExtents : UInt16
    MaximumNumberOfParityExtents : UInt16
    ParityExtents : SCRUB_PARITY_EXTENT[1]
}
struct SCRUB_DATA_OUTPUT {
    Size : UInt32
    Flags : UInt32
    Status : UInt32
    ErrorFileOffset : Int64
    ErrorLength : Int64
    NumberOfBytesRepaired : Int64
    NumberOfBytesFailed : Int64
    InternalFileReference : Int64
    ResumeContextLength : UInt16
    ParityExtentDataOffset : UInt16
    NextStartingByteOffset : Int64
    ValidDataLength : Int64
    Reserved : UInt32[4]
    NumberOfMetadataBytesProcessed : Int64
    NumberOfDataBytesProcessed : Int64
    TotalNumberOfMetadataBytesInUse : Int64
    TotalNumberOfDataBytesInUse : Int64
    DataBytesSkippedDueToNoAllocation : Int64
    DataBytesSkippedDueToInvalidRun : Int64
    DataBytesSkippedDueToIntegrityStream : Int64
    DataBytesSkippedDueToRegionBeingClean : Int64
    DataBytesSkippedDueToLockConflict : Int64
    DataBytesSkippedDueToNoScrubDataFlag : Int64
    DataBytesSkippedDueToNoScrubNonIntegrityStreamFlag : Int64
    DataBytesScrubbed : Int64
    ResumeContext : UInt8[1040]
}
struct SharedVirtualDiskSupportType extends Int32 {
    static SharedVirtualDisksUnsupported := 0
    static SharedVirtualDisksSupported := 1
    static SharedVirtualDiskSnapshotsSupported := 3
    static SharedVirtualDiskCDPSnapshotsSupported := 7
}
struct SharedVirtualDiskHandleState extends Int32 {
    static SharedVirtualDiskHandleStateNone := 0
    static SharedVirtualDiskHandleStateFileShared := 1
    static SharedVirtualDiskHandleStateHandleShared := 3
}
struct SHARED_VIRTUAL_DISK_SUPPORT {
    SharedVirtualDiskSupport : SharedVirtualDiskSupportType
    HandleState : SharedVirtualDiskHandleState
}
struct REARRANGE_FILE_DATA {
    SourceStartingOffset : Int64
    TargetOffset : Int64
    SourceFileHandle : HANDLE
    Length : UInt32
    Flags : UInt32
}
struct SHUFFLE_FILE_DATA {
    StartingOffset : Int64
    Length : Int64
    Flags : UInt32
}
struct NETWORK_APP_INSTANCE_EA {
    AppInstanceID : GUID
    CsvFlags : UInt32
}
struct MONITOR_DISPLAY_STATE extends Int32 {
    static PowerMonitorOff := 0
    static PowerMonitorOn := 1
    static PowerMonitorDim := 2
}
struct ENERGY_SAVER_STATUS extends Int32 {
    static ENERGY_SAVER_OFF := 0
    static ENERGY_SAVER_STANDARD := 1
    static ENERGY_SAVER_HIGH_SAVINGS := 2
}
struct POWER_LIMIT_TYPES extends Int32 {
    static PowerLimitContinuous := 0
    static PowerLimitType1 := 0
    static PowerLimitBurst := 1
    static PowerLimitType2 := 1
    static PowerLimitRapid := 2
    static PowerLimitType3 := 2
    static PowerLimitPreemptive := 3
    static PowerLimitType4 := 3
    static PowerLimitPreemptiveOffset := 4
    static PowerLimitTypeMax := 5
}
struct POWER_LIMIT_ATTRIBUTES {
    Type : POWER_LIMIT_TYPES
    DomainId : UInt32
    MaxValue : UInt32
    MinValue : UInt32
    MinTimeParameter : UInt32
    MaxTimeParameter : UInt32
    DefaultACValue : UInt32
    DefaultDCValue : UInt32
    Flags : this._Flags_e__Union
    struct _Flags_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUlong : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct POWER_LIMIT_VALUE {
    Type : POWER_LIMIT_TYPES
    DomainId : UInt32
    TargetValue : UInt32
    TimeParameter : UInt32
}
struct NOTIFY_USER_POWER_SETTING {
    Guid : GUID
}
struct APPLICATIONLAUNCH_SETTING_VALUE {
    ActivationTime : Int64
    Flags : UInt32
    ButtonInstanceID : UInt32
}
struct PROCESSOR_IDLESTATE_INFO {
    TimeCheck : UInt32
    DemotePercent : UInt8
    PromotePercent : UInt8
    Spare : UInt8[2]
}
struct PROCESSOR_IDLESTATE_POLICY {
    Revision : UInt16
    Flags : this._Flags_e__Union
    PolicyCount : UInt32
    Policy : PROCESSOR_IDLESTATE_INFO[3]
    struct _Flags_e__Union {
        union {
            AsWORD : UInt16
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct PROCESSOR_PERFSTATE_POLICY {
    Revision : UInt32
    MaxThrottle : UInt8
    MinThrottle : UInt8
    BusyAdjThreshold : UInt8
    Anonymous : this._Anonymous_e__Union
    TimeCheck : UInt32
    IncreaseTime : UInt32
    DecreaseTime : UInt32
    IncreasePercent : UInt32
    DecreasePercent : UInt32
    struct _Anonymous_e__Union {
        union {
            Spare : UInt8
            Flags : this._Flags_e__Union
        }
        struct _Flags_e__Union {
            union {
                AsBYTE : UInt8
                Anonymous : this._Anonymous_e__Struct
            }
            struct _Anonymous_e__Struct {
                _bitfield : UInt8
            }
        }
    }
}
struct HIBERFILE_BUCKET_SIZE extends Int32 {
    static HiberFileBucket1GB := 0
    static HiberFileBucket2GB := 1
    static HiberFileBucket4GB := 2
    static HiberFileBucket8GB := 3
    static HiberFileBucket16GB := 4
    static HiberFileBucket32GB := 5
    static HiberFileBucketUnlimited := 6
    static HiberFileBucketMax := 7
}
struct HIBERFILE_BUCKET {
    MaxPhysicalMemory : Int64
    PhysicalMemoryPercent : UInt32[3]
}
struct SYSTEM_POWER_SOURCE_STATE {
    BatteryState : SYSTEM_BATTERY_STATE
    InstantaneousPeakPower : UInt32
    InstantaneousPeakPeriod : UInt32
    SustainablePeakPower : UInt32
    SustainablePeakPeriod : UInt32
    PeakPower : UInt32
    MaxOutputPower : UInt32
    MaxInputPower : UInt32
    BatteryRateInCurrent : Int32
    BatteryVoltage : UInt32
}
struct IMAGE_DOS_HEADER {
    e_magic : UInt16
    e_cblp : UInt16
    e_cp : UInt16
    e_crlc : UInt16
    e_cparhdr : UInt16
    e_minalloc : UInt16
    e_maxalloc : UInt16
    e_ss : UInt16
    e_sp : UInt16
    e_csum : UInt16
    e_ip : UInt16
    e_cs : UInt16
    e_lfarlc : UInt16
    e_ovno : UInt16
    e_res : UInt16[4]
    e_oemid : UInt16
    e_oeminfo : UInt16
    e_res2 : UInt16[10]
    e_lfanew : Int32
}
struct IMAGE_OS2_HEADER {
    ne_magic : UInt16
    ne_ver : CHAR
    ne_rev : CHAR
    ne_enttab : UInt16
    ne_cbenttab : UInt16
    ne_crc : Int32
    ne_flags : UInt16
    ne_autodata : UInt16
    ne_heap : UInt16
    ne_stack : UInt16
    ne_csip : Int32
    ne_sssp : Int32
    ne_cseg : UInt16
    ne_cmod : UInt16
    ne_cbnrestab : UInt16
    ne_segtab : UInt16
    ne_rsrctab : UInt16
    ne_restab : UInt16
    ne_modtab : UInt16
    ne_imptab : UInt16
    ne_nrestab : Int32
    ne_cmovent : UInt16
    ne_align : UInt16
    ne_cres : UInt16
    ne_exetyp : UInt8
    ne_flagsothers : UInt8
    ne_pretthunks : UInt16
    ne_psegrefbytes : UInt16
    ne_swaparea : UInt16
    ne_expver : UInt16
}
struct IMAGE_VXD_HEADER {
    e32_magic : UInt16
    e32_border : UInt8
    e32_worder : UInt8
    e32_level : UInt32
    e32_cpu : UInt16
    e32_os : UInt16
    e32_ver : UInt32
    e32_mflags : UInt32
    e32_mpages : UInt32
    e32_startobj : UInt32
    e32_eip : UInt32
    e32_stackobj : UInt32
    e32_esp : UInt32
    e32_pagesize : UInt32
    e32_lastpagesize : UInt32
    e32_fixupsize : UInt32
    e32_fixupsum : UInt32
    e32_ldrsize : UInt32
    e32_ldrsum : UInt32
    e32_objtab : UInt32
    e32_objcnt : UInt32
    e32_objmap : UInt32
    e32_itermap : UInt32
    e32_rsrctab : UInt32
    e32_rsrccnt : UInt32
    e32_restab : UInt32
    e32_enttab : UInt32
    e32_dirtab : UInt32
    e32_dircnt : UInt32
    e32_fpagetab : UInt32
    e32_frectab : UInt32
    e32_impmod : UInt32
    e32_impmodcnt : UInt32
    e32_impproc : UInt32
    e32_pagesum : UInt32
    e32_datapage : UInt32
    e32_preload : UInt32
    e32_nrestab : UInt32
    e32_cbnrestab : UInt32
    e32_nressum : UInt32
    e32_autodata : UInt32
    e32_debuginfo : UInt32
    e32_debuglen : UInt32
    e32_instpreload : UInt32
    e32_instdemand : UInt32
    e32_heapsize : UInt32
    e32_res3 : UInt8[12]
    e32_winresoff : UInt32
    e32_winreslen : UInt32
    e32_devid : UInt16
    e32_ddkver : UInt16
}
struct ANON_OBJECT_HEADER {
    Sig1 : UInt16
    Sig2 : UInt16
    Version : UInt16
    Machine : UInt16
    TimeDateStamp : UInt32
    ClassID : GUID
    SizeOfData : UInt32
}
struct ANON_OBJECT_HEADER_V2 {
    Sig1 : UInt16
    Sig2 : UInt16
    Version : UInt16
    Machine : UInt16
    TimeDateStamp : UInt32
    ClassID : GUID
    SizeOfData : UInt32
    Flags : UInt32
    MetaDataSize : UInt32
    MetaDataOffset : UInt32
}
struct ANON_OBJECT_HEADER_BIGOBJ {
    Sig1 : UInt16
    Sig2 : UInt16
    Version : UInt16
    Machine : UInt16
    TimeDateStamp : UInt32
    ClassID : GUID
    SizeOfData : UInt32
    Flags : UInt32
    MetaDataSize : UInt32
    MetaDataOffset : UInt32
    NumberOfSections : UInt32
    PointerToSymbolTable : UInt32
    NumberOfSymbols : UInt32
}
struct IMAGE_SYMBOL {
    N : this._N_e__Union
    Value : UInt32
    SectionNumber : Int16
    Type : UInt16
    StorageClass : UInt8
    NumberOfAuxSymbols : UInt8
    struct _N_e__Union {
        union {
            ShortName : UInt8[8]
            Name : this._Name_e__Struct
            LongName : UInt32[2]
        }
        struct _Name_e__Struct {
            Short : UInt32
            Long : UInt32
        }
    }
}
struct IMAGE_SYMBOL_EX {
    N : this._N_e__Union
    Value : UInt32
    SectionNumber : Int32
    Type : UInt16
    StorageClass : UInt8
    NumberOfAuxSymbols : UInt8
    struct _N_e__Union {
        union {
            ShortName : UInt8[8]
            Name : this._Name_e__Struct
            LongName : UInt32[2]
        }
        struct _Name_e__Struct {
            Short : UInt32
            Long : UInt32
        }
    }
}
struct IMAGE_AUX_SYMBOL_TOKEN_DEF {
    bAuxType : UInt8
    bReserved : UInt8
    SymbolTableIndex : UInt32
    rgbReserved : UInt8[12]
}
struct IMAGE_AUX_SYMBOL {
    union {
        Sym : this._Sym_e__Struct
        File : this._File_e__Struct
        Section : this._Section_e__Struct
        TokenDef : IMAGE_AUX_SYMBOL_TOKEN_DEF
        CRC : this._CRC_e__Struct
    }
    struct _Sym_e__Struct {
        TagIndex : UInt32
        Misc : this._Misc_e__Union
        FcnAry : this._FcnAry_e__Union
        TvIndex : UInt16
        struct _Misc_e__Union {
            union {
                LnSz : this._LnSz_e__Struct
                TotalSize : UInt32
            }
            struct _LnSz_e__Struct {
                Linenumber : UInt16
                Size : UInt16
            }
        }
        struct _FcnAry_e__Union {
            union {
                Function : this._Function_e__Struct
                Array : this._Array_e__Struct
            }
            struct _Function_e__Struct {
                PointerToLinenumber : UInt32
                PointerToNextFunction : UInt32
            }
            struct _Array_e__Struct {
                Dimension : UInt16[4]
            }
        }
    }
    struct _File_e__Struct {
        Name : UInt8[18]
    }
    struct _Section_e__Struct {
        Length : UInt32
        NumberOfRelocations : UInt16
        NumberOfLinenumbers : UInt16
        CheckSum : UInt32
        Number : Int16
        Selection : UInt8
        bReserved : UInt8
        HighNumber : Int16
    }
    struct _CRC_e__Struct {
        crc : UInt32
        rgbReserved : UInt8[14]
    }
}
struct IMAGE_AUX_SYMBOL_EX {
    union {
        Sym : this._Sym_e__Struct
        File : this._File_e__Struct
        Section : this._Section_e__Struct
        Anonymous : this._Anonymous_e__Struct
        CRC : this._CRC_e__Struct
    }
    struct _Sym_e__Struct {
        WeakDefaultSymIndex : UInt32
        WeakSearchType : UInt32
        rgbReserved : UInt8[12]
    }
    struct _File_e__Struct {
        Name : UInt8[20]
    }
    struct _Section_e__Struct {
        Length : UInt32
        NumberOfRelocations : UInt16
        NumberOfLinenumbers : UInt16
        CheckSum : UInt32
        Number : Int16
        Selection : UInt8
        bReserved : UInt8
        HighNumber : Int16
        rgbReserved : UInt8[2]
    }
    struct _Anonymous_e__Struct {
        TokenDef : IMAGE_AUX_SYMBOL_TOKEN_DEF
        rgbReserved : UInt8[2]
    }
    struct _CRC_e__Struct {
        crc : UInt32
        rgbReserved : UInt8[16]
    }
}
struct IMAGE_AUX_SYMBOL_TYPE extends Int32 {
    static IMAGE_AUX_SYMBOL_TYPE_TOKEN_DEF := 1
}
struct IMAGE_RELOCATION {
    Anonymous : this._Anonymous_e__Union
    SymbolTableIndex : UInt32
    Type : UInt16
    struct _Anonymous_e__Union {
        union {
            VirtualAddress : UInt32
            RelocCount : UInt32
        }
    }
}
struct IMAGE_LINENUMBER {
    Type : this._Type_e__Union
    Linenumber : UInt16
    struct _Type_e__Union {
        union {
            SymbolTableIndex : UInt32
            VirtualAddress : UInt32
        }
    }
}
struct IMAGE_BASE_RELOCATION {
    VirtualAddress : UInt32
    SizeOfBlock : UInt32
}
struct IMAGE_ARCHIVE_MEMBER_HEADER {
    Name : UInt8[16]
    Date : UInt8[12]
    UserID : UInt8[6]
    GroupID : UInt8[6]
    Mode : UInt8[8]
    Size : UInt8[10]
    EndHeader : UInt8[2]
}
struct IMAGE_EXPORT_DIRECTORY {
    Characteristics : UInt32
    TimeDateStamp : UInt32
    MajorVersion : UInt16
    MinorVersion : UInt16
    Name : UInt32
    Base : UInt32
    NumberOfFunctions : UInt32
    NumberOfNames : UInt32
    AddressOfFunctions : UInt32
    AddressOfNames : UInt32
    AddressOfNameOrdinals : UInt32
}
struct IMAGE_IMPORT_BY_NAME {
    Hint : UInt16
    Name : CHAR[1]
}
struct PIMAGE_TLS_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, Struct.Ptr, "Void"]
}
struct IMAGE_TLS_DIRECTORY64 {
    StartAddressOfRawData : Int64
    EndAddressOfRawData : Int64
    AddressOfIndex : Int64
    AddressOfCallBacks : Int64
    SizeOfZeroFill : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Characteristics : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct IMAGE_TLS_DIRECTORY32 {
    StartAddressOfRawData : UInt32
    EndAddressOfRawData : UInt32
    AddressOfIndex : UInt32
    AddressOfCallBacks : UInt32
    SizeOfZeroFill : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Characteristics : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct IMAGE_IMPORT_DESCRIPTOR {
    Anonymous : this._Anonymous_e__Union
    TimeDateStamp : UInt32
    ForwarderChain : UInt32
    Name : UInt32
    FirstThunk : UInt32
    struct _Anonymous_e__Union {
        union {
            Characteristics : UInt32
            OriginalFirstThunk : UInt32
        }
    }
}
struct IMAGE_BOUND_IMPORT_DESCRIPTOR {
    TimeDateStamp : UInt32
    OffsetModuleName : UInt16
    NumberOfModuleForwarderRefs : UInt16
}
struct IMAGE_BOUND_FORWARDER_REF {
    TimeDateStamp : UInt32
    OffsetModuleName : UInt16
    Reserved : UInt16
}
struct IMAGE_RESOURCE_DIRECTORY {
    Characteristics : UInt32
    TimeDateStamp : UInt32
    MajorVersion : UInt16
    MinorVersion : UInt16
    NumberOfNamedEntries : UInt16
    NumberOfIdEntries : UInt16
}
struct IMAGE_RESOURCE_DIRECTORY_ENTRY {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Name : UInt32
            Id : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            OffsetToData : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct IMAGE_RESOURCE_DIRECTORY_STRING {
    Length : UInt16
    NameString : CHAR[1]
}
struct IMAGE_RESOURCE_DIR_STRING_U {
    Length : UInt16
    NameString : UInt16[1]
}
struct IMAGE_RESOURCE_DATA_ENTRY {
    OffsetToData : UInt32
    Size : UInt32
    CodePage : UInt32
    Reserved : UInt32
}
struct IMAGE_DYNAMIC_RELOCATION_TABLE {
    Version : UInt32
    Size : UInt32
}
struct IMAGE_DYNAMIC_RELOCATION32 {
    Symbol : UInt32
    BaseRelocSize : UInt32
}
struct IMAGE_DYNAMIC_RELOCATION64 {
    Symbol : Int64
    BaseRelocSize : UInt32
}
struct IMAGE_DYNAMIC_RELOCATION32_V2 {
    HeaderSize : UInt32
    FixupInfoSize : UInt32
    Symbol : UInt32
    SymbolGroup : UInt32
    Flags : UInt32
}
struct IMAGE_DYNAMIC_RELOCATION64_V2 {
    HeaderSize : UInt32
    FixupInfoSize : UInt32
    Symbol : Int64
    SymbolGroup : UInt32
    Flags : UInt32
}
struct IMAGE_PROLOGUE_DYNAMIC_RELOCATION_HEADER {
    PrologueByteCount : UInt8
}
struct IMAGE_EPILOGUE_DYNAMIC_RELOCATION_HEADER {
    EpilogueCount : UInt32
    EpilogueByteCount : UInt8
    BranchDescriptorElementSize : UInt8
    BranchDescriptorCount : UInt16
}
struct IMAGE_IMPORT_CONTROL_TRANSFER_DYNAMIC_RELOCATION {
    _bitfield : UInt32
}
struct IMAGE_IMPORT_CONTROL_TRANSFER_ARM64_RELOCATION {
    _bitfield : UInt32
}
struct IMAGE_INDIR_CONTROL_TRANSFER_DYNAMIC_RELOCATION {
    _bitfield : UInt16
}
struct IMAGE_SWITCHTABLE_BRANCH_DYNAMIC_RELOCATION {
    _bitfield : UInt16
}
struct IMAGE_FUNCTION_OVERRIDE_HEADER {
    FuncOverrideSize : UInt32
}
struct IMAGE_FUNCTION_OVERRIDE_DYNAMIC_RELOCATION {
    OriginalRva : UInt32
    BDDOffset : UInt32
    RvaSize : UInt32
    BaseRelocSize : UInt32
}
struct IMAGE_BDD_INFO {
    Version : UInt32
    BDDSize : UInt32
}
struct IMAGE_BDD_DYNAMIC_RELOCATION {
    Left : UInt16
    Right : UInt16
    Value : UInt32
}
struct IMAGE_HOT_PATCH_INFO {
    Version : UInt32
    Size : UInt32
    SequenceNumber : UInt32
    BaseImageList : UInt32
    BaseImageCount : UInt32
    BufferOffset : UInt32
    ExtraPatchSize : UInt32
    MinSequenceNumber : UInt32
    Flags : UInt32
}
struct IMAGE_HOT_PATCH_BASE {
    SequenceNumber : UInt32
    Flags : UInt32
    OriginalTimeDateStamp : UInt32
    OriginalCheckSum : UInt32
    CodeIntegrityInfo : UInt32
    CodeIntegritySize : UInt32
    PatchTable : UInt32
    BufferOffset : UInt32
}
struct IMAGE_HOT_PATCH_MACHINE {
    Anonymous : this._Anonymous_e__Struct
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct IMAGE_HOT_PATCH_HASHES {
    SHA256 : UInt8[32]
    SHA1 : UInt8[20]
}
struct IMAGE_HOTSWAP_ARM64_ENDPOINT_INFO_CC_RETURN extends Int32 {
    static EndpointReturnTypeNone := 0
    static EndpointReturnTypeX0 := 1
    static EndpointReturnTypeX0_X1 := 2
    static EndpointReturnTypeX0_X2 := 3
    static EndpointReturnTypeX0_X3 := 4
    static EndpointReturnTypeQ0 := 5
    static EndpointReturnTypeQ0_Q1 := 6
    static EndpointReturnTypeQ0_Q2 := 7
    static EndpointReturnTypeQ0_Q3 := 8
    static EndpointReturnTypeX8 := 9
}
struct IMAGE_HOTSWAP_X64_ENDPOINT_INFO_CC_REG extends Int32 {
    static EndpointParamRegNone := 0
    static EndpointParamRegRAX := 1
    static EndpointParamRegRCX := 2
    static EndpointParamRegRDX := 3
    static EndpointParamRegR8 := 9
    static EndpointParamRegR9 := 10
    static EndpointParamRegXMM0 := 200
    static EndpointParamRegXMM1 := 201
    static EndpointParamRegXMM2 := 202
    static EndpointParamRegXMM3 := 203
}
struct IMAGE_HOTSWAP_ENDPOINT_INFO_HEADER_COMMON {
    Version : UInt32
    Size : UInt32
}
struct IMAGE_HOTSWAP_ENDPOINT_INFO_ENTRY_COMMON {
    Size : UInt32
    Rva : UInt32
    NameSize : UInt32
    NameOffset : UInt32
}
struct IMAGE_HOTSWAP_X64_ENDPOINT_INFO_ENTRY_V2 {
    Common : IMAGE_HOTSWAP_ENDPOINT_INFO_ENTRY_COMMON
    ArgRegs : IMAGE_HOTSWAP_X64_ENDPOINT_INFO_CC_REG[4]
    ArgStackSize : UInt32
    RetReg : IMAGE_HOTSWAP_X64_ENDPOINT_INFO_CC_REG
    Name : UInt8[1]
}
struct IMAGE_HOTSWAP_ARM64_ENDPOINT_INFO_ENTRY_V2 {
    Common : IMAGE_HOTSWAP_ENDPOINT_INFO_ENTRY_COMMON
    IntArgs : UInt32
    FloatArgs : UInt32
    ArgStackSize : UInt32
    ReturnType : IMAGE_HOTSWAP_ARM64_ENDPOINT_INFO_CC_RETURN
    Name : UInt8[1]
}
struct IMAGE_HOTSWAP_ENDPOINT_INFO_HEADER_V2 {
    Common : IMAGE_HOTSWAP_ENDPOINT_INFO_HEADER_COMMON
    Count : UInt32
}
struct IMAGE_CE_RUNTIME_FUNCTION_ENTRY {
    FuncStart : UInt32
    _bitfield : UInt32
}
struct IMAGE_ARM_RUNTIME_FUNCTION_ENTRY {
    BeginAddress : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            UnwindData : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct ARM64_FNPDATA_FLAGS extends Int32 {
    static PdataRefToFullXdata := 0
    static PdataPackedUnwindFunction := 1
    static PdataPackedUnwindFragment := 2
}
struct ARM64_FNPDATA_CR extends Int32 {
    static PdataCrUnchained := 0
    static PdataCrUnchainedSavedLr := 1
    static PdataCrChainedWithPac := 2
    static PdataCrChained := 3
}
struct IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY_XDATA {
    union {
        HeaderData : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY_XDATA_EXTENDED {
    union {
        ExtendedHeaderData : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY_XDATA_EPILOG_SCOPE {
    union {
        EpilogScopeData : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct IMAGE_ALPHA64_RUNTIME_FUNCTION_ENTRY {
    BeginAddress : Int64
    EndAddress : Int64
    ExceptionHandler : Int64
    HandlerData : Int64
    PrologEndAddress : Int64
}
struct IMAGE_ALPHA_RUNTIME_FUNCTION_ENTRY {
    BeginAddress : UInt32
    EndAddress : UInt32
    ExceptionHandler : UInt32
    HandlerData : UInt32
    PrologEndAddress : UInt32
}
struct IMAGE_DEBUG_MISC {
    DataType : UInt32
    Length : UInt32
    Unicode : BOOLEAN
    Reserved : UInt8[3]
    Data : UInt8[1]
}
struct IMAGE_SEPARATE_DEBUG_HEADER {
    Signature : UInt16
    Flags : UInt16
    Machine : UInt16
    Characteristics : UInt16
    TimeDateStamp : UInt32
    CheckSum : UInt32
    ImageBase : UInt32
    SizeOfImage : UInt32
    NumberOfSections : UInt32
    ExportedNamesSize : UInt32
    DebugDirectorySize : UInt32
    SectionAlignment : UInt32
    Reserved : UInt32[2]
}
struct NON_PAGED_DEBUG_INFO {
    Signature : UInt16
    Flags : UInt16
    Size : UInt32
    Machine : UInt16
    Characteristics : UInt16
    TimeDateStamp : UInt32
    CheckSum : UInt32
    SizeOfImage : UInt32
    ImageBase : Int64
}
struct IMAGE_ARCHITECTURE_HEADER {
    _bitfield : UInt32
    FirstEntryRVA : UInt32
}
struct IMAGE_ARCHITECTURE_ENTRY {
    FixupInstRVA : UInt32
    NewInst : UInt32
}
struct IMPORT_OBJECT_HEADER {
    Sig1 : UInt16
    Sig2 : UInt16
    Version : UInt16
    Machine : UInt16
    TimeDateStamp : UInt32
    SizeOfData : UInt32
    Anonymous : this._Anonymous_e__Union
    _bitfield : UInt16
    struct _Anonymous_e__Union {
        union {
            Ordinal : UInt16
            Hint : UInt16
        }
    }
}
struct IMPORT_OBJECT_TYPE extends Int32 {
    static IMPORT_OBJECT_CODE := 0
    static IMPORT_OBJECT_DATA := 1
    static IMPORT_OBJECT_CONST := 2
}
struct IMPORT_OBJECT_NAME_TYPE extends Int32 {
    static IMPORT_OBJECT_ORDINAL := 0
    static IMPORT_OBJECT_NAME := 1
    static IMPORT_OBJECT_NAME_NO_PREFIX := 2
    static IMPORT_OBJECT_NAME_UNDECORATE := 3
    static IMPORT_OBJECT_NAME_EXPORTAS := 4
}
struct ReplacesCorHdrNumericDefines extends Int32 {
    static COMIMAGE_FLAGS_ILONLY := 1
    static COMIMAGE_FLAGS_32BITREQUIRED := 2
    static COMIMAGE_FLAGS_IL_LIBRARY := 4
    static COMIMAGE_FLAGS_STRONGNAMESIGNED := 8
    static COMIMAGE_FLAGS_NATIVE_ENTRYPOINT := 16
    static COMIMAGE_FLAGS_TRACKDEBUGDATA := 65536
    static COMIMAGE_FLAGS_32BITPREFERRED := 131072
    static COR_VERSION_MAJOR_V2 := 2
    static COR_VERSION_MAJOR := 2
    static COR_VERSION_MINOR := 5
    static COR_DELETED_NAME_LENGTH := 8
    static COR_VTABLEGAP_NAME_LENGTH := 8
    static NATIVE_TYPE_MAX_CB := 1
    static COR_ILMETHOD_SECT_SMALL_MAX_DATASIZE := 255
    static IMAGE_COR_MIH_METHODRVA := 1
    static IMAGE_COR_MIH_EHRVA := 2
    static IMAGE_COR_MIH_BASICBLOCK := 8
    static COR_VTABLE_32BIT := 1
    static COR_VTABLE_64BIT := 2
    static COR_VTABLE_FROM_UNMANAGED := 4
    static COR_VTABLE_FROM_UNMANAGED_RETAIN_APPDOMAIN := 8
    static COR_VTABLE_CALL_MOST_DERIVED := 16
    static IMAGE_COR_EATJ_THUNK_SIZE := 32
    static MAX_CLASS_NAME := 1024
    static MAX_PACKAGE_NAME := 1024
}
struct RTL_UMS_SCHEDULER_REASON extends Int32 {
    static UmsSchedulerStartup := 0
    static UmsSchedulerThreadBlocked := 1
    static UmsSchedulerThreadYield := 2
}
struct IMAGE_POLICY_ENTRY_TYPE extends Int32 {
    static ImagePolicyEntryTypeNone := 0
    static ImagePolicyEntryTypeBool := 1
    static ImagePolicyEntryTypeInt8 := 2
    static ImagePolicyEntryTypeUInt8 := 3
    static ImagePolicyEntryTypeInt16 := 4
    static ImagePolicyEntryTypeUInt16 := 5
    static ImagePolicyEntryTypeInt32 := 6
    static ImagePolicyEntryTypeUInt32 := 7
    static ImagePolicyEntryTypeInt64 := 8
    static ImagePolicyEntryTypeUInt64 := 9
    static ImagePolicyEntryTypeAnsiString := 10
    static ImagePolicyEntryTypeUnicodeString := 11
    static ImagePolicyEntryTypeOverride := 12
    static ImagePolicyEntryTypeMaximum := 13
}
struct IMAGE_POLICY_ID extends Int32 {
    static ImagePolicyIdNone := 0
    static ImagePolicyIdEtw := 1
    static ImagePolicyIdDebug := 2
    static ImagePolicyIdCrashDump := 3
    static ImagePolicyIdCrashDumpKey := 4
    static ImagePolicyIdCrashDumpKeyGuid := 5
    static ImagePolicyIdParentSd := 6
    static ImagePolicyIdParentSdRev := 7
    static ImagePolicyIdSvn := 8
    static ImagePolicyIdDeviceId := 9
    static ImagePolicyIdCapability := 10
    static ImagePolicyIdScenarioId := 11
    static ImagePolicyIdCapabilityOverridable := 12
    static ImagePolicyIdTrustletIdOverridable := 13
    static ImagePolicyIdMaximum := 14
}
struct IMAGE_POLICY_ENTRY {
    Type : IMAGE_POLICY_ENTRY_TYPE
    PolicyId : IMAGE_POLICY_ID
    u : this._u_e__Union
    struct _u_e__Union {
        union {
            None : Struct.Ptr
            BoolValue : BOOLEAN
            Int8Value : Int8
            UInt8Value : UInt8
            Int16Value : Int16
            UInt16Value : UInt16
            Int32Value : Int32
            UInt32Value : UInt32
            Int64Value : Int64
            UInt64Value : Int64
            AnsiStringValue : PSTR
            UnicodeStringValue : PWSTR
        }
    }
}
struct IMAGE_POLICY_METADATA {
    Version : UInt8
    Reserved0 : UInt8[7]
    ApplicationId : Int64
    Policies : IMAGE_POLICY_ENTRY[1]
}
struct HEAP_OPTIMIZE_RESOURCES_INFORMATION {
    Version : UInt32
    Flags : UInt32
}
struct HEAP_MEMORY_USAGE_ENTRY {
    HeapHandle : Struct.Ptr
    TotalCommittedBytes : IntPtr
    TotalReservedBytes : IntPtr
}
struct HEAP_MEMORY_USAGE_INFORMATION {
    Version : UInt16
    EntryCount : IntPtr
    Entries : HEAP_MEMORY_USAGE_ENTRY[1]
}
struct ACTIVATION_CONTEXT_INFO_CLASS extends Int32 {
    static ActivationContextBasicInformation := 1
    static ActivationContextDetailedInformation := 2
    static AssemblyDetailedInformationInActivationContext := 3
    static FileInformationInAssemblyOfAssemblyInActivationContext := 4
    static RunlevelInformationInActivationContext := 5
    static CompatibilityInformationInActivationContext := 6
    static ActivationContextManifestResourceName := 7
    static MaxActivationContextInfoClass := 8
    static AssemblyDetailedInformationInActivationContxt := 3
    static FileInformationInAssemblyOfAssemblyInActivationContxt := 4
}
struct SUPPORTED_OS_INFO {
    MajorVersion : UInt16
    MinorVersion : UInt16
}
struct MAXVERSIONTESTED_INFO {
    MaxVersionTested : Int64
}
struct IMAGE_FILE_MACHINES {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Value : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct PACKEDEVENTINFO {
    ulSize : UInt32
    ulNumEventsForLogFile : UInt32
    ulOffsets : UInt32[1]
}
struct SERVICE_NODE_TYPE extends Int32 {
    static DriverType := 1
    static FileSystemType := 2
    static Win32ServiceOwnProcess := 16
    static Win32ServiceShareProcess := 32
    static AdapterType := 4
    static RecognizerType := 8
}
struct SERVICE_LOAD_TYPE extends Int32 {
    static BootLoad := 0
    static SystemLoad := 1
    static AutoLoad := 2
    static DemandLoad := 3
    static DisableLoad := 4
}
struct SERVICE_ERROR_TYPE extends Int32 {
    static IgnoreError := 0
    static NormalError := 1
    static SevereError := 2
    static CriticalError := 3
}
struct TAPE_GET_DRIVE_PARAMETERS {
    ECC : BOOLEAN
    Compression : BOOLEAN
    DataPadding : BOOLEAN
    ReportSetmarks : BOOLEAN
    DefaultBlockSize : UInt32
    MaximumBlockSize : UInt32
    MinimumBlockSize : UInt32
    MaximumPartitionCount : UInt32
    FeaturesLow : UInt32
    FeaturesHigh : TAPE_GET_DRIVE_PARAMETERS_FEATURES_HIGH
    EOTWarningZoneSize : UInt32
}
struct TAPE_SET_DRIVE_PARAMETERS {
    ECC : BOOLEAN
    Compression : BOOLEAN
    DataPadding : BOOLEAN
    ReportSetmarks : BOOLEAN
    EOTWarningZoneSize : UInt32
}
struct TAPE_GET_MEDIA_PARAMETERS {
    Capacity : Int64
    Remaining : Int64
    BlockSize : UInt32
    PartitionCount : UInt32
    WriteProtected : BOOLEAN
}
struct TAPE_SET_MEDIA_PARAMETERS {
    BlockSize : UInt32
}
struct TAPE_CREATE_PARTITION {
    Method : UInt32
    Count : UInt32
    Size : UInt32
}
struct TAPE_WMI_OPERATIONS {
    Method : UInt32
    DataBufferSize : UInt32
    DataBuffer : Struct.Ptr
}
struct TAPE_DRIVE_PROBLEM_TYPE extends Int32 {
    static TapeDriveProblemNone := 0
    static TapeDriveReadWriteWarning := 1
    static TapeDriveReadWriteError := 2
    static TapeDriveReadWarning := 3
    static TapeDriveWriteWarning := 4
    static TapeDriveReadError := 5
    static TapeDriveWriteError := 6
    static TapeDriveHardwareError := 7
    static TapeDriveUnsupportedMedia := 8
    static TapeDriveScsiConnectionError := 9
    static TapeDriveTimetoClean := 10
    static TapeDriveCleanDriveNow := 11
    static TapeDriveMediaLifeExpired := 12
    static TapeDriveSnappedTape := 13
}
struct TRANSACTION_STATE extends Int32 {
    static TransactionStateNormal := 1
    static TransactionStateIndoubt := 2
    static TransactionStateCommittedNotify := 3
}
struct TRANSACTION_BASIC_INFORMATION {
    TransactionId : GUID
    State : UInt32
    Outcome : UInt32
}
struct TRANSACTIONMANAGER_BASIC_INFORMATION {
    TmIdentity : GUID
    VirtualClock : Int64
}
struct TRANSACTIONMANAGER_LOG_INFORMATION {
    LogIdentity : GUID
}
struct TRANSACTIONMANAGER_LOGPATH_INFORMATION {
    LogPathLength : UInt32
    LogPath : UInt16[1]
}
struct TRANSACTIONMANAGER_RECOVERY_INFORMATION {
    LastRecoveredLsn : Int64
}
struct TRANSACTIONMANAGER_OLDEST_INFORMATION {
    OldestTransactionGuid : GUID
}
struct TRANSACTION_PROPERTIES_INFORMATION {
    IsolationLevel : UInt32
    IsolationFlags : UInt32
    Timeout : Int64
    Outcome : UInt32
    DescriptionLength : UInt32
    Description : UInt16[1]
}
struct TRANSACTION_BIND_INFORMATION {
    TmHandle : HANDLE
}
struct TRANSACTION_ENLISTMENT_PAIR {
    EnlistmentId : GUID
    ResourceManagerId : GUID
}
struct TRANSACTION_ENLISTMENTS_INFORMATION {
    NumberOfEnlistments : UInt32
    EnlistmentPair : TRANSACTION_ENLISTMENT_PAIR[1]
}
struct TRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION {
    SuperiorEnlistmentPair : TRANSACTION_ENLISTMENT_PAIR
}
struct RESOURCEMANAGER_BASIC_INFORMATION {
    ResourceManagerId : GUID
    DescriptionLength : UInt32
    Description : UInt16[1]
}
struct RESOURCEMANAGER_COMPLETION_INFORMATION {
    IoCompletionPortHandle : HANDLE
    CompletionKey : IntPtr
}
struct TRANSACTION_INFORMATION_CLASS extends Int32 {
    static TransactionBasicInformation := 0
    static TransactionPropertiesInformation := 1
    static TransactionEnlistmentInformation := 2
    static TransactionSuperiorEnlistmentInformation := 3
    static TransactionBindInformation := 4
    static TransactionDTCPrivateInformation := 5
}
struct TRANSACTIONMANAGER_INFORMATION_CLASS extends Int32 {
    static TransactionManagerBasicInformation := 0
    static TransactionManagerLogInformation := 1
    static TransactionManagerLogPathInformation := 2
    static TransactionManagerRecoveryInformation := 4
    static TransactionManagerOnlineProbeInformation := 3
    static TransactionManagerOldestTransactionInformation := 5
}
struct RESOURCEMANAGER_INFORMATION_CLASS extends Int32 {
    static ResourceManagerBasicInformation := 0
    static ResourceManagerCompletionInformation := 1
}
struct ENLISTMENT_BASIC_INFORMATION {
    EnlistmentId : GUID
    TransactionId : GUID
    ResourceManagerId : GUID
}
struct ENLISTMENT_CRM_INFORMATION {
    CrmTransactionManagerId : GUID
    CrmResourceManagerId : GUID
    CrmEnlistmentId : GUID
}
struct ENLISTMENT_INFORMATION_CLASS extends Int32 {
    static EnlistmentBasicInformation := 0
    static EnlistmentRecoveryInformation := 1
    static EnlistmentCrmInformation := 2
}
struct TRANSACTION_LIST_ENTRY {
    UOW : GUID
}
struct TRANSACTION_LIST_INFORMATION {
    NumberOfTransactions : UInt32
    TransactionInformation : TRANSACTION_LIST_ENTRY[1]
}
struct KTMOBJECT_TYPE extends Int32 {
    static KTMOBJECT_TRANSACTION := 0
    static KTMOBJECT_TRANSACTION_MANAGER := 1
    static KTMOBJECT_RESOURCE_MANAGER := 2
    static KTMOBJECT_ENLISTMENT := 3
    static KTMOBJECT_INVALID := 4
}
struct KTMOBJECT_CURSOR {
    LastQuery : GUID
    ObjectIdCount : UInt32
    ObjectIds : GUID[1]
}
