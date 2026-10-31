#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, LUID, PSTR, PWSTR}
#Import "..\Networking.WinSock\Types.ahk" {ADDRESS_FAMILY}

struct WHV_PARTITION_HANDLE {
    Value : IntPtr
}
struct WHV_REGISTER_NAME extends Int32 {
    static WHvX64RegisterRax := 0
    static WHvX64RegisterRcx := 1
    static WHvX64RegisterRdx := 2
    static WHvX64RegisterRbx := 3
    static WHvX64RegisterRsp := 4
    static WHvX64RegisterRbp := 5
    static WHvX64RegisterRsi := 6
    static WHvX64RegisterRdi := 7
    static WHvX64RegisterR8 := 8
    static WHvX64RegisterR9 := 9
    static WHvX64RegisterR10 := 10
    static WHvX64RegisterR11 := 11
    static WHvX64RegisterR12 := 12
    static WHvX64RegisterR13 := 13
    static WHvX64RegisterR14 := 14
    static WHvX64RegisterR15 := 15
    static WHvX64RegisterRip := 16
    static WHvX64RegisterRflags := 17
    static WHvX64RegisterEs := 18
    static WHvX64RegisterCs := 19
    static WHvX64RegisterSs := 20
    static WHvX64RegisterDs := 21
    static WHvX64RegisterFs := 22
    static WHvX64RegisterGs := 23
    static WHvX64RegisterLdtr := 24
    static WHvX64RegisterTr := 25
    static WHvX64RegisterIdtr := 26
    static WHvX64RegisterGdtr := 27
    static WHvX64RegisterCr0 := 28
    static WHvX64RegisterCr2 := 29
    static WHvX64RegisterCr3 := 30
    static WHvX64RegisterCr4 := 31
    static WHvX64RegisterCr8 := 32
    static WHvX64RegisterDr0 := 33
    static WHvX64RegisterDr1 := 34
    static WHvX64RegisterDr2 := 35
    static WHvX64RegisterDr3 := 36
    static WHvX64RegisterDr6 := 37
    static WHvX64RegisterDr7 := 38
    static WHvX64RegisterXCr0 := 39
    static WHvX64RegisterVirtualCr0 := 40
    static WHvX64RegisterVirtualCr3 := 41
    static WHvX64RegisterVirtualCr4 := 42
    static WHvX64RegisterVirtualCr8 := 43
    static WHvX64RegisterXmm0 := 4096
    static WHvX64RegisterXmm1 := 4097
    static WHvX64RegisterXmm2 := 4098
    static WHvX64RegisterXmm3 := 4099
    static WHvX64RegisterXmm4 := 4100
    static WHvX64RegisterXmm5 := 4101
    static WHvX64RegisterXmm6 := 4102
    static WHvX64RegisterXmm7 := 4103
    static WHvX64RegisterXmm8 := 4104
    static WHvX64RegisterXmm9 := 4105
    static WHvX64RegisterXmm10 := 4106
    static WHvX64RegisterXmm11 := 4107
    static WHvX64RegisterXmm12 := 4108
    static WHvX64RegisterXmm13 := 4109
    static WHvX64RegisterXmm14 := 4110
    static WHvX64RegisterXmm15 := 4111
    static WHvX64RegisterFpMmx0 := 4112
    static WHvX64RegisterFpMmx1 := 4113
    static WHvX64RegisterFpMmx2 := 4114
    static WHvX64RegisterFpMmx3 := 4115
    static WHvX64RegisterFpMmx4 := 4116
    static WHvX64RegisterFpMmx5 := 4117
    static WHvX64RegisterFpMmx6 := 4118
    static WHvX64RegisterFpMmx7 := 4119
    static WHvX64RegisterFpControlStatus := 4120
    static WHvX64RegisterXmmControlStatus := 4121
    static WHvX64RegisterTsc := 8192
    static WHvX64RegisterEfer := 8193
    static WHvX64RegisterKernelGsBase := 8194
    static WHvX64RegisterApicBase := 8195
    static WHvX64RegisterPat := 8196
    static WHvX64RegisterSysenterCs := 8197
    static WHvX64RegisterSysenterEip := 8198
    static WHvX64RegisterSysenterEsp := 8199
    static WHvX64RegisterStar := 8200
    static WHvX64RegisterLstar := 8201
    static WHvX64RegisterCstar := 8202
    static WHvX64RegisterSfmask := 8203
    static WHvX64RegisterInitialApicId := 8204
    static WHvX64RegisterMsrMtrrCap := 8205
    static WHvX64RegisterMsrMtrrDefType := 8206
    static WHvX64RegisterMsrMtrrPhysBase0 := 8208
    static WHvX64RegisterMsrMtrrPhysBase1 := 8209
    static WHvX64RegisterMsrMtrrPhysBase2 := 8210
    static WHvX64RegisterMsrMtrrPhysBase3 := 8211
    static WHvX64RegisterMsrMtrrPhysBase4 := 8212
    static WHvX64RegisterMsrMtrrPhysBase5 := 8213
    static WHvX64RegisterMsrMtrrPhysBase6 := 8214
    static WHvX64RegisterMsrMtrrPhysBase7 := 8215
    static WHvX64RegisterMsrMtrrPhysBase8 := 8216
    static WHvX64RegisterMsrMtrrPhysBase9 := 8217
    static WHvX64RegisterMsrMtrrPhysBaseA := 8218
    static WHvX64RegisterMsrMtrrPhysBaseB := 8219
    static WHvX64RegisterMsrMtrrPhysBaseC := 8220
    static WHvX64RegisterMsrMtrrPhysBaseD := 8221
    static WHvX64RegisterMsrMtrrPhysBaseE := 8222
    static WHvX64RegisterMsrMtrrPhysBaseF := 8223
    static WHvX64RegisterMsrMtrrPhysMask0 := 8256
    static WHvX64RegisterMsrMtrrPhysMask1 := 8257
    static WHvX64RegisterMsrMtrrPhysMask2 := 8258
    static WHvX64RegisterMsrMtrrPhysMask3 := 8259
    static WHvX64RegisterMsrMtrrPhysMask4 := 8260
    static WHvX64RegisterMsrMtrrPhysMask5 := 8261
    static WHvX64RegisterMsrMtrrPhysMask6 := 8262
    static WHvX64RegisterMsrMtrrPhysMask7 := 8263
    static WHvX64RegisterMsrMtrrPhysMask8 := 8264
    static WHvX64RegisterMsrMtrrPhysMask9 := 8265
    static WHvX64RegisterMsrMtrrPhysMaskA := 8266
    static WHvX64RegisterMsrMtrrPhysMaskB := 8267
    static WHvX64RegisterMsrMtrrPhysMaskC := 8268
    static WHvX64RegisterMsrMtrrPhysMaskD := 8269
    static WHvX64RegisterMsrMtrrPhysMaskE := 8270
    static WHvX64RegisterMsrMtrrPhysMaskF := 8271
    static WHvX64RegisterMsrMtrrFix64k00000 := 8304
    static WHvX64RegisterMsrMtrrFix16k80000 := 8305
    static WHvX64RegisterMsrMtrrFix16kA0000 := 8306
    static WHvX64RegisterMsrMtrrFix4kC0000 := 8307
    static WHvX64RegisterMsrMtrrFix4kC8000 := 8308
    static WHvX64RegisterMsrMtrrFix4kD0000 := 8309
    static WHvX64RegisterMsrMtrrFix4kD8000 := 8310
    static WHvX64RegisterMsrMtrrFix4kE0000 := 8311
    static WHvX64RegisterMsrMtrrFix4kE8000 := 8312
    static WHvX64RegisterMsrMtrrFix4kF0000 := 8313
    static WHvX64RegisterMsrMtrrFix4kF8000 := 8314
    static WHvX64RegisterTscAux := 8315
    static WHvX64RegisterBndcfgs := 8316
    static WHvX64RegisterMCount := 8318
    static WHvX64RegisterACount := 8319
    static WHvX64RegisterSpecCtrl := 8324
    static WHvX64RegisterPredCmd := 8325
    static WHvX64RegisterTscVirtualOffset := 8327
    static WHvX64RegisterTsxCtrl := 8328
    static WHvX64RegisterXss := 8331
    static WHvX64RegisterUCet := 8332
    static WHvX64RegisterSCet := 8333
    static WHvX64RegisterSsp := 8334
    static WHvX64RegisterPl0Ssp := 8335
    static WHvX64RegisterPl1Ssp := 8336
    static WHvX64RegisterPl2Ssp := 8337
    static WHvX64RegisterPl3Ssp := 8338
    static WHvX64RegisterInterruptSspTableAddr := 8339
    static WHvX64RegisterTscDeadline := 8341
    static WHvX64RegisterTscAdjust := 8342
    static WHvX64RegisterUmwaitControl := 8344
    static WHvX64RegisterXfd := 8345
    static WHvX64RegisterXfdErr := 8346
    static WHvX64RegisterMsrIa32MiscEnable := 8352
    static WHvX64RegisterIa32FeatureControl := 8353
    static WHvX64RegisterIa32VmxBasic := 8354
    static WHvX64RegisterIa32VmxPinbasedCtls := 8355
    static WHvX64RegisterIa32VmxProcbasedCtls := 8356
    static WHvX64RegisterIa32VmxExitCtls := 8357
    static WHvX64RegisterIa32VmxEntryCtls := 8358
    static WHvX64RegisterIa32VmxMisc := 8359
    static WHvX64RegisterIa32VmxCr0Fixed0 := 8360
    static WHvX64RegisterIa32VmxCr0Fixed1 := 8361
    static WHvX64RegisterIa32VmxCr4Fixed0 := 8362
    static WHvX64RegisterIa32VmxCr4Fixed1 := 8363
    static WHvX64RegisterIa32VmxVmcsEnum := 8364
    static WHvX64RegisterIa32VmxProcbasedCtls2 := 8365
    static WHvX64RegisterIa32VmxEptVpidCap := 8366
    static WHvX64RegisterIa32VmxTruePinbasedCtls := 8367
    static WHvX64RegisterIa32VmxTrueProcbasedCtls := 8368
    static WHvX64RegisterIa32VmxTrueExitCtls := 8369
    static WHvX64RegisterIa32VmxTrueEntryCtls := 8370
    static WHvX64RegisterAmdVmHsavePa := 8371
    static WHvX64RegisterAmdVmCr := 8372
    static WHvX64RegisterApicId := 12290
    static WHvX64RegisterApicVersion := 12291
    static WHvX64RegisterApicTpr := 12296
    static WHvX64RegisterApicPpr := 12298
    static WHvX64RegisterApicEoi := 12299
    static WHvX64RegisterApicLdr := 12301
    static WHvX64RegisterApicSpurious := 12303
    static WHvX64RegisterApicIsr0 := 12304
    static WHvX64RegisterApicIsr1 := 12305
    static WHvX64RegisterApicIsr2 := 12306
    static WHvX64RegisterApicIsr3 := 12307
    static WHvX64RegisterApicIsr4 := 12308
    static WHvX64RegisterApicIsr5 := 12309
    static WHvX64RegisterApicIsr6 := 12310
    static WHvX64RegisterApicIsr7 := 12311
    static WHvX64RegisterApicTmr0 := 12312
    static WHvX64RegisterApicTmr1 := 12313
    static WHvX64RegisterApicTmr2 := 12314
    static WHvX64RegisterApicTmr3 := 12315
    static WHvX64RegisterApicTmr4 := 12316
    static WHvX64RegisterApicTmr5 := 12317
    static WHvX64RegisterApicTmr6 := 12318
    static WHvX64RegisterApicTmr7 := 12319
    static WHvX64RegisterApicIrr0 := 12320
    static WHvX64RegisterApicIrr1 := 12321
    static WHvX64RegisterApicIrr2 := 12322
    static WHvX64RegisterApicIrr3 := 12323
    static WHvX64RegisterApicIrr4 := 12324
    static WHvX64RegisterApicIrr5 := 12325
    static WHvX64RegisterApicIrr6 := 12326
    static WHvX64RegisterApicIrr7 := 12327
    static WHvX64RegisterApicEse := 12328
    static WHvX64RegisterApicIcr := 12336
    static WHvX64RegisterApicLvtTimer := 12338
    static WHvX64RegisterApicLvtThermal := 12339
    static WHvX64RegisterApicLvtPerfmon := 12340
    static WHvX64RegisterApicLvtLint0 := 12341
    static WHvX64RegisterApicLvtLint1 := 12342
    static WHvX64RegisterApicLvtError := 12343
    static WHvX64RegisterApicInitCount := 12344
    static WHvX64RegisterApicCurrentCount := 12345
    static WHvX64RegisterApicDivide := 12350
    static WHvX64RegisterApicSelfIpi := 12351
    static WHvRegisterSint0 := 16384
    static WHvRegisterSint1 := 16385
    static WHvRegisterSint2 := 16386
    static WHvRegisterSint3 := 16387
    static WHvRegisterSint4 := 16388
    static WHvRegisterSint5 := 16389
    static WHvRegisterSint6 := 16390
    static WHvRegisterSint7 := 16391
    static WHvRegisterSint8 := 16392
    static WHvRegisterSint9 := 16393
    static WHvRegisterSint10 := 16394
    static WHvRegisterSint11 := 16395
    static WHvRegisterSint12 := 16396
    static WHvRegisterSint13 := 16397
    static WHvRegisterSint14 := 16398
    static WHvRegisterSint15 := 16399
    static WHvRegisterScontrol := 16400
    static WHvRegisterSversion := 16401
    static WHvRegisterSiefp := 16402
    static WHvRegisterSimp := 16403
    static WHvRegisterEom := 16404
    static WHvRegisterVpRuntime := 20480
    static WHvX64RegisterHypercall := 20481
    static WHvRegisterGuestOsId := 20482
    static WHvRegisterVpAssistPage := 20499
    static WHvRegisterReferenceTsc := 20503
    static WHvRegisterReferenceTscSequence := 20506
    static WHvX64RegisterNestedGuestState := 20560
    static WHvX64RegisterNestedCurrentVmGpa := 20561
    static WHvX64RegisterNestedVmxInvEpt := 20562
    static WHvX64RegisterNestedVmxInvVpid := 20563
    static WHvRegisterPendingInterruption := -2147483648
    static WHvRegisterInterruptState := -2147483647
    static WHvRegisterPendingEvent := -2147483646
    static WHvRegisterPendingEvent1 := -2147483645
    static WHvX64RegisterDeliverabilityNotifications := -2147483644
    static WHvRegisterDeliverabilityNotifications := -2147483644
    static WHvRegisterInternalActivityState := -2147483643
    static WHvX64RegisterPendingDebugException := -2147483642
    static WHvRegisterPendingEvent2 := -2147483641
    static WHvRegisterPendingEvent3 := -2147483640
}
struct WHV_UINT128 {
    union {
        Anonymous : this._Anonymous_e__Struct
        Dword : UInt32[4]
    }
    struct _Anonymous_e__Struct {
        Low64 : Int64
        High64 : Int64
    }
}
struct WHV_X64_FP_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        Mantissa : Int64
        _bitfield : Int64
    }
}
struct WHV_X64_FP_CONTROL_STATUS_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        FpControl : UInt16
        FpStatus : UInt16
        FpTag : UInt8
        Reserved : UInt8
        LastFpOp : UInt16
        Anonymous : this._Anonymous_e__Union
        struct _Anonymous_e__Union {
            union {
                LastFpRip : Int64
                Anonymous : this._Anonymous_e__Struct
            }
            struct _Anonymous_e__Struct {
                LastFpEip : UInt32
                LastFpCs : UInt16
                Reserved2 : UInt16
            }
        }
    }
}
struct WHV_X64_XMM_CONTROL_STATUS_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        Anonymous : this._Anonymous_e__Union
        XmmStatusControl : UInt32
        XmmStatusControlMask : UInt32
        struct _Anonymous_e__Union {
            union {
                LastFpRdp : Int64
                Anonymous : this._Anonymous_e__Struct
            }
            struct _Anonymous_e__Struct {
                LastFpDp : UInt32
                LastFpDs : UInt16
                Reserved : UInt16
            }
        }
    }
}
struct WHV_X64_SEGMENT_REGISTER {
    Base : Int64
    Limit : UInt32
    Selector : UInt16
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Attributes : UInt16
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt16
        }
    }
}
struct WHV_X64_TABLE_REGISTER {
    Pad : UInt16[3]
    Limit : UInt16
    Base : Int64
}
struct WHV_X64_INTERRUPT_STATE_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_X64_PENDING_INTERRUPTION_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
        ErrorCode : UInt32
    }
}
struct WHV_X64_PENDING_EVENT_TYPE extends Int32 {
    static WHvX64PendingEventException := 0
    static WHvX64PendingEventExtInt := 5
    static WHvX64PendingEventSvmNestedExit := 7
    static WHvX64PendingEventVmxNestedExit := 8
}
struct WHV_X64_PENDING_EXCEPTION_EVENT {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
        ErrorCode : UInt32
        ExceptionParameter : Int64
    }
}
struct WHV_X64_PENDING_EXT_INT_EVENT {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
        Reserved2 : Int64
    }
}
struct WHV_X64_PENDING_SVM_NESTED_EXIT_EVENT0 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
        ExitCode : Int64
    }
}
struct WHV_X64_PENDING_SVM_NESTED_EXIT_EVENT1 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        ExitInfo1 : Int64
        ExitInfo2 : Int64
    }
}
struct WHV_X64_PENDING_SVM_NESTED_EXIT_EVENT2 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        NextRip : Int64
        InstructionBytesFetchedCount : UInt8
        InstructionBytes : UInt8[7]
    }
}
struct WHV_X64_PENDING_SVM_NESTED_EXIT_EVENT3 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        InstructionBytes : UInt8[8]
        Reserved2 : Int64
    }
}
struct WHV_X64_PENDING_VMX_NESTED_EXIT_EVENT0 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
        ExitReason : UInt32
        ExitQualification : Int64
    }
}
struct WHV_X64_PENDING_VMX_NESTED_EXIT_EVENT1 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        InstructionLength : UInt32
        InstructionInfo : UInt32
        ExitInterruptionInfo : UInt32
        ExitExceptionErrorCode : UInt32
    }
}
struct WHV_X64_PENDING_VMX_NESTED_EXIT_EVENT2 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        GuestLinearAddress : Int64
        GuestPhysicalAddress : Int64
    }
}
struct WHV_X64_PENDING_VMX_NESTED_EXIT_EVENT3 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        MsrData : Int64
    }
}
struct WHV_X64_NESTED_INVEPT_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        Type : UInt8
        Reserved : UInt8[7]
        Eptp : Int64
    }
}
struct WHV_X64_NESTED_INVVPID_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        Type : UInt8
        Reserved : UInt8[3]
        Vpid : UInt32
        LinearAddress : Int64
    }
}
struct WHV_X64_NESTED_GUEST_STATE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT128 : WHV_UINT128
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
        Reserved1 : Int64
    }
}
struct WHV_DELIVERABILITY_NOTIFICATIONS_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_INTERNAL_ACTIVITY_REGISTER {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_X64_PENDING_DEBUG_EXCEPTION {
    union {
        AsUINT64 : Int64
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_REGISTER_VALUE {
    union {
        Reg128 : WHV_UINT128
        Reg64 : Int64
        Reg32 : UInt32
        Reg16 : UInt16
        Reg8 : UInt8
        InternalActivity : WHV_INTERNAL_ACTIVITY_REGISTER
        DeliverabilityNotifications : WHV_DELIVERABILITY_NOTIFICATIONS_REGISTER
        Fp : WHV_X64_FP_REGISTER
        FpControlStatus : WHV_X64_FP_CONTROL_STATUS_REGISTER
        XmmControlStatus : WHV_X64_XMM_CONTROL_STATUS_REGISTER
        Segment : WHV_X64_SEGMENT_REGISTER
        Table : WHV_X64_TABLE_REGISTER
        InterruptState : WHV_X64_INTERRUPT_STATE_REGISTER
        PendingInterruption : WHV_X64_PENDING_INTERRUPTION_REGISTER
        ExceptionEvent : WHV_X64_PENDING_EXCEPTION_EVENT
        ExtIntEvent : WHV_X64_PENDING_EXT_INT_EVENT
        PendingDebugException : WHV_X64_PENDING_DEBUG_EXCEPTION
        NestedState : WHV_X64_NESTED_GUEST_STATE
        InvEpt : WHV_X64_NESTED_INVEPT_REGISTER
        InvVpid : WHV_X64_NESTED_INVVPID_REGISTER
        SvmNestedExit0 : WHV_X64_PENDING_SVM_NESTED_EXIT_EVENT0
        SvmNestedExit1 : WHV_X64_PENDING_SVM_NESTED_EXIT_EVENT1
        SvmNestedExit2 : WHV_X64_PENDING_SVM_NESTED_EXIT_EVENT2
        SvmNestedExit3 : WHV_X64_PENDING_SVM_NESTED_EXIT_EVENT3
        VmxNestedExit0 : WHV_X64_PENDING_VMX_NESTED_EXIT_EVENT0
        VmxNestedExit1 : WHV_X64_PENDING_VMX_NESTED_EXIT_EVENT1
        VmxNestedExit2 : WHV_X64_PENDING_VMX_NESTED_EXIT_EVENT2
        VmxNestedExit3 : WHV_X64_PENDING_VMX_NESTED_EXIT_EVENT3
    }
}
struct WHV_CAPABILITY_CODE extends Int32 {
    static WHvCapabilityCodeHypervisorPresent := 0
    static WHvCapabilityCodeFeatures := 1
    static WHvCapabilityCodeExtendedVmExits := 2
    static WHvCapabilityCodeExceptionExitBitmap := 3
    static WHvCapabilityCodeX64MsrExitBitmap := 4
    static WHvCapabilityCodeGpaRangePopulateFlags := 5
    static WHvCapabilityCodeSchedulerFeatures := 6
    static WHvCapabilityCodeProcessorVendor := 4096
    static WHvCapabilityCodeProcessorFeatures := 4097
    static WHvCapabilityCodeProcessorClFlushSize := 4098
    static WHvCapabilityCodeProcessorXsaveFeatures := 4099
    static WHvCapabilityCodeProcessorClockFrequency := 4100
    static WHvCapabilityCodeInterruptClockFrequency := 4101
    static WHvCapabilityCodeProcessorFeaturesBanks := 4102
    static WHvCapabilityCodeProcessorFrequencyCap := 4103
    static WHvCapabilityCodeSyntheticProcessorFeaturesBanks := 4104
    static WHvCapabilityCodeProcessorPerfmonFeatures := 4105
    static WHvCapabilityCodePhysicalAddressWidth := 4106
    static WHvCapabilityCodeVmxBasic := 8192
    static WHvCapabilityCodeVmxPinbasedCtls := 8193
    static WHvCapabilityCodeVmxProcbasedCtls := 8194
    static WHvCapabilityCodeVmxExitCtls := 8195
    static WHvCapabilityCodeVmxEntryCtls := 8196
    static WHvCapabilityCodeVmxMisc := 8197
    static WHvCapabilityCodeVmxCr0Fixed0 := 8198
    static WHvCapabilityCodeVmxCr0Fixed1 := 8199
    static WHvCapabilityCodeVmxCr4Fixed0 := 8200
    static WHvCapabilityCodeVmxCr4Fixed1 := 8201
    static WHvCapabilityCodeVmxVmcsEnum := 8202
    static WHvCapabilityCodeVmxProcbasedCtls2 := 8203
    static WHvCapabilityCodeVmxEptVpidCap := 8204
    static WHvCapabilityCodeVmxTruePinbasedCtls := 8205
    static WHvCapabilityCodeVmxTrueProcbasedCtls := 8206
    static WHvCapabilityCodeVmxTrueExitCtls := 8207
    static WHvCapabilityCodeVmxTrueEntryCtls := 8208
}
struct WHV_CAPABILITY_FEATURES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_EXTENDED_VM_EXITS {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_PROCESSOR_VENDOR extends Int32 {
    static WHvProcessorVendorAmd := 0
    static WHvProcessorVendorIntel := 1
    static WHvProcessorVendorHygon := 2
    static WHvProcessorVendorArm := 16
}
struct WHV_X64_PROCESSOR_FEATURES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_X64_PROCESSOR_FEATURES1 {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_PROCESSOR_FEATURES_BANKS {
    BanksCount : UInt32
    Reserved0 : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUINT64 : Int64[2]
        }
        struct _Anonymous_e__Struct {
            Bank0 : WHV_X64_PROCESSOR_FEATURES
            Bank1 : WHV_X64_PROCESSOR_FEATURES1
        }
    }
}
struct WHV_SYNTHETIC_PROCESSOR_FEATURES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS {
    BanksCount : UInt32
    Reserved0 : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            AsUINT64 : Int64[1]
        }
        struct _Anonymous_e__Struct {
            Bank0 : WHV_SYNTHETIC_PROCESSOR_FEATURES
        }
    }
}
struct WHV_INPUT_VTL {
    union {
        AsUINT8 : UInt8
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt8
    }
}
struct WHV_ENABLE_PARTITION_VTL_FLAGS {
    union {
        AsUINT8 : UInt8
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt8
    }
}
struct WHV_DISABLE_PARTITION_VTL_FLAGS {
    union {
        AsUINT8 : UInt8
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt8
    }
}
struct WHV_INITIAL_VP_CONTEXT {
    Rip : Int64
    Rsp : Int64
    Rflags : Int64
    Cs : WHV_X64_SEGMENT_REGISTER
    Ds : WHV_X64_SEGMENT_REGISTER
    Es : WHV_X64_SEGMENT_REGISTER
    Fs : WHV_X64_SEGMENT_REGISTER
    Gs : WHV_X64_SEGMENT_REGISTER
    Ss : WHV_X64_SEGMENT_REGISTER
    Tr : WHV_X64_SEGMENT_REGISTER
    Ldtr : WHV_X64_SEGMENT_REGISTER
    Idtr : WHV_X64_TABLE_REGISTER
    Gdtr : WHV_X64_TABLE_REGISTER
    Efer : Int64
    Cr0 : Int64
    Cr3 : Int64
    Cr4 : Int64
    MsrCrPat : Int64
}
struct WHV_DISABLE_VP_VTL_FLAGS {
    union {
        AsUINT8 : UInt8
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt8
    }
}
struct WHV_PARTITION_PROPERTY_CODE extends Int32 {
    static WHvPartitionPropertyCodeExtendedVmExits := 1
    static WHvPartitionPropertyCodeExceptionExitBitmap := 2
    static WHvPartitionPropertyCodeSeparateSecurityDomain := 3
    static WHvPartitionPropertyCodeNestedVirtualization := 4
    static WHvPartitionPropertyCodeX64MsrExitBitmap := 5
    static WHvPartitionPropertyCodePrimaryNumaNode := 6
    static WHvPartitionPropertyCodeCpuReserve := 7
    static WHvPartitionPropertyCodeCpuCap := 8
    static WHvPartitionPropertyCodeCpuWeight := 9
    static WHvPartitionPropertyCodeCpuGroupId := 10
    static WHvPartitionPropertyCodeProcessorFrequencyCap := 11
    static WHvPartitionPropertyCodeAllowDeviceAssignment := 12
    static WHvPartitionPropertyCodeDisableSmt := 13
    static WHvPartitionPropertyCodeProcessorFeatures := 4097
    static WHvPartitionPropertyCodeProcessorClFlushSize := 4098
    static WHvPartitionPropertyCodeCpuidExitList := 4099
    static WHvPartitionPropertyCodeCpuidResultList := 4100
    static WHvPartitionPropertyCodeLocalApicEmulationMode := 4101
    static WHvPartitionPropertyCodeProcessorXsaveFeatures := 4102
    static WHvPartitionPropertyCodeProcessorClockFrequency := 4103
    static WHvPartitionPropertyCodeInterruptClockFrequency := 4104
    static WHvPartitionPropertyCodeApicRemoteReadSupport := 4105
    static WHvPartitionPropertyCodeProcessorFeaturesBanks := 4106
    static WHvPartitionPropertyCodeReferenceTime := 4107
    static WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks := 4108
    static WHvPartitionPropertyCodeCpuidResultList2 := 4109
    static WHvPartitionPropertyCodeProcessorPerfmonFeatures := 4110
    static WHvPartitionPropertyCodeMsrActionList := 4111
    static WHvPartitionPropertyCodeUnimplementedMsrAction := 4112
    static WHvPartitionPropertyCodePhysicalAddressWidth := 4113
    static WHvPartitionPropertyCodeProcessorCount := 8191
}
struct WHV_PROCESSOR_XSAVE_FEATURES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_PROCESSOR_PERFMON_FEATURES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_X64_MSR_EXIT_BITMAP {
    union {
        AsUINT64 : Int64
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_MAP_GPA_RANGE_FLAGS extends Int32 {
    static WHvMapGpaRangeFlagNone := 0
    static WHvMapGpaRangeFlagRead := 1
    static WHvMapGpaRangeFlagWrite := 2
    static WHvMapGpaRangeFlagExecute := 4
    static WHvMapGpaRangeFlagTrackDirtyPages := 8
}
struct WHV_TRANSLATE_GVA_FLAGS extends Int32 {
    static WHvTranslateGvaFlagNone := 0
    static WHvTranslateGvaFlagValidateRead := 1
    static WHvTranslateGvaFlagValidateWrite := 2
    static WHvTranslateGvaFlagValidateExecute := 4
    static WHvTranslateGvaFlagPrivilegeExempt := 8
    static WHvTranslateGvaFlagSetPageTableBits := 16
    static WHvTranslateGvaFlagEnforceSmap := 256
    static WHvTranslateGvaFlagOverrideSmap := 512
}
struct WHV_TRANSLATE_GVA_2_FLAGS {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_TRANSLATE_GVA_RESULT_CODE extends Int32 {
    static WHvTranslateGvaResultSuccess := 0
    static WHvTranslateGvaResultPageNotPresent := 1
    static WHvTranslateGvaResultPrivilegeViolation := 2
    static WHvTranslateGvaResultInvalidPageTableFlags := 3
    static WHvTranslateGvaResultGpaUnmapped := 4
    static WHvTranslateGvaResultGpaNoReadAccess := 5
    static WHvTranslateGvaResultGpaNoWriteAccess := 6
    static WHvTranslateGvaResultGpaIllegalOverlayAccess := 7
    static WHvTranslateGvaResultIntercept := 8
}
struct WHV_TRANSLATE_GVA_RESULT {
    ResultCode : WHV_TRANSLATE_GVA_RESULT_CODE
    Reserved : UInt32
}
struct WHV_MEMORY_RANGE_ENTRY {
    GuestAddress : Int64
    SizeInBytes : Int64
}
struct WHV_ADVISE_GPA_RANGE_POPULATE_FLAGS {
    union {
        AsUINT32 : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct WHV_MEMORY_ACCESS_TYPE extends Int32 {
    static WHvMemoryAccessRead := 0
    static WHvMemoryAccessWrite := 1
    static WHvMemoryAccessExecute := 2
}
struct WHV_ADVISE_GPA_RANGE_POPULATE {
    Flags : WHV_ADVISE_GPA_RANGE_POPULATE_FLAGS
    AccessType : WHV_MEMORY_ACCESS_TYPE
}
struct WHV_ADVISE_GPA_RANGE {
    union {
        Populate : WHV_ADVISE_GPA_RANGE_POPULATE
    }
}
struct WHV_CACHE_TYPE extends Int32 {
    static WHvCacheTypeUncached := 0
    static WHvCacheTypeWriteCombining := 1
    static WHvCacheTypeWriteThrough := 4
    static WHvCacheTypeWriteProtected := 5
    static WHvCacheTypeWriteBack := 6
}
struct WHV_ACCESS_GPA_CONTROLS {
    union {
        AsUINT64 : Int64
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        CacheType : WHV_CACHE_TYPE
        InputVtl : WHV_INPUT_VTL
        Reserved : UInt8
        Reserved1 : UInt16
    }
}
struct WHV_CAPABILITY_PROCESSOR_FREQUENCY_CAP {
    _bitfield : UInt32
    HighestFrequencyMhz : UInt32
    NominalFrequencyMhz : UInt32
    LowestFrequencyMhz : UInt32
    FrequencyStepMhz : UInt32
}
struct WHV_SCHEDULER_FEATURES {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_CAPABILITY {
    union {
        HypervisorPresent : BOOL
        Features : WHV_CAPABILITY_FEATURES
        ExtendedVmExits : WHV_EXTENDED_VM_EXITS
        ProcessorVendor : WHV_PROCESSOR_VENDOR
        ProcessorFeatures : WHV_X64_PROCESSOR_FEATURES
        SyntheticProcessorFeaturesBanks : WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS
        ProcessorClFlushSize : UInt8
        ProcessorClockFrequency : Int64
        ProcessorFeaturesBanks : WHV_PROCESSOR_FEATURES_BANKS
        GpaRangePopulateFlags : WHV_ADVISE_GPA_RANGE_POPULATE_FLAGS
        ProcessorFrequencyCap : WHV_CAPABILITY_PROCESSOR_FREQUENCY_CAP
        SchedulerFeatures : WHV_SCHEDULER_FEATURES
        PhysicalAddressWidth : UInt32
        NestedFeatureRegister : Int64
        ProcessorXsaveFeatures : WHV_PROCESSOR_XSAVE_FEATURES
        InterruptClockFrequency : Int64
        ProcessorPerfmonFeatures : WHV_PROCESSOR_PERFMON_FEATURES
        X64MsrExitBitmap : WHV_X64_MSR_EXIT_BITMAP
        ExceptionExitBitmap : Int64
    }
}
struct WHV_X64_CPUID_RESULT {
    Function : UInt32
    Reserved : UInt32[3]
    Eax : UInt32
    Ebx : UInt32
    Ecx : UInt32
    Edx : UInt32
}
struct WHV_X64_CPUID_RESULT2_FLAGS extends Int32 {
    static WHvX64CpuidResult2FlagSubleafSpecific := 1
    static WHvX64CpuidResult2FlagVpSpecific := 2
}
struct WHV_CPUID_OUTPUT {
    Eax : UInt32
    Ebx : UInt32
    Ecx : UInt32
    Edx : UInt32
}
struct WHV_X64_CPUID_RESULT2 {
    Function : UInt32
    Index : UInt32
    VpIndex : UInt32
    Flags : WHV_X64_CPUID_RESULT2_FLAGS
    Output : WHV_CPUID_OUTPUT
    Mask : WHV_CPUID_OUTPUT
}
struct WHV_MSR_ACTION_ENTRY {
    Index : UInt32
    ReadAction : UInt8
    WriteAction : UInt8
    Reserved : UInt16
}
struct WHV_MSR_ACTION extends Int32 {
    static WHvMsrActionArchitectureDefault := 0
    static WHvMsrActionIgnoreWriteReadZero := 1
    static WHvMsrActionExit := 2
}
struct WHV_EXCEPTION_TYPE extends Int32 {
    static WHvX64ExceptionTypeDivideErrorFault := 0
    static WHvX64ExceptionTypeDebugTrapOrFault := 1
    static WHvX64ExceptionTypeBreakpointTrap := 3
    static WHvX64ExceptionTypeOverflowTrap := 4
    static WHvX64ExceptionTypeBoundRangeFault := 5
    static WHvX64ExceptionTypeInvalidOpcodeFault := 6
    static WHvX64ExceptionTypeDeviceNotAvailableFault := 7
    static WHvX64ExceptionTypeDoubleFaultAbort := 8
    static WHvX64ExceptionTypeInvalidTaskStateSegmentFault := 10
    static WHvX64ExceptionTypeSegmentNotPresentFault := 11
    static WHvX64ExceptionTypeStackFault := 12
    static WHvX64ExceptionTypeGeneralProtectionFault := 13
    static WHvX64ExceptionTypePageFault := 14
    static WHvX64ExceptionTypeFloatingPointErrorFault := 16
    static WHvX64ExceptionTypeAlignmentCheckFault := 17
    static WHvX64ExceptionTypeMachineCheckAbort := 18
    static WHvX64ExceptionTypeSimdFloatingPointFault := 19
    static WHvX64ExceptionTypeControlProtectionFault := 21
}
struct WHV_X64_LOCAL_APIC_EMULATION_MODE extends Int32 {
    static WHvX64LocalApicEmulationModeNone := 0
    static WHvX64LocalApicEmulationModeXApic := 1
    static WHvX64LocalApicEmulationModeX2Apic := 2
}
struct WHV_PARTITION_PROPERTY {
    union {
        ExtendedVmExits : WHV_EXTENDED_VM_EXITS
        ProcessorFeatures : WHV_X64_PROCESSOR_FEATURES
        SyntheticProcessorFeaturesBanks : WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS
        ProcessorClFlushSize : UInt8
        ProcessorCount : UInt32
        SeparateSecurityDomain : BOOL
        NestedVirtualization : BOOL
        ProcessorClockFrequency : Int64
        ProcessorFeaturesBanks : WHV_PROCESSOR_FEATURES_BANKS
        ReferenceTime : Int64
        PrimaryNumaNode : UInt16
        CpuReserve : UInt32
        CpuCap : UInt32
        CpuWeight : UInt32
        CpuGroupId : Int64
        ProcessorFrequencyCap : UInt32
        AllowDeviceAssignment : BOOL
        DisableSmt : BOOL
        PhysicalAddressWidth : UInt32
        ProcessorXsaveFeatures : WHV_PROCESSOR_XSAVE_FEATURES
        CpuidExitList : UInt32[1]
        ExceptionExitBitmap : Int64
        ApicRemoteRead : BOOL
        X64MsrExitBitmap : WHV_X64_MSR_EXIT_BITMAP
        ProcessorPerfmonFeatures : WHV_PROCESSOR_PERFMON_FEATURES
        InterruptClockFrequency : Int64
        CpuidResultList : WHV_X64_CPUID_RESULT[1]
        CpuidResultList2 : WHV_X64_CPUID_RESULT2[1]
        MsrActionList : WHV_MSR_ACTION_ENTRY[1]
        UnimplementedMsrAction : WHV_MSR_ACTION
        LocalApicEmulationMode : WHV_X64_LOCAL_APIC_EMULATION_MODE
    }
}
struct WHV_RUN_VP_EXIT_REASON extends Int32 {
    static WHvRunVpExitReasonNone := 0
    static WHvRunVpExitReasonMemoryAccess := 1
    static WHvRunVpExitReasonX64IoPortAccess := 2
    static WHvRunVpExitReasonUnrecoverableException := 4
    static WHvRunVpExitReasonInvalidVpRegisterValue := 5
    static WHvRunVpExitReasonUnsupportedFeature := 6
    static WHvRunVpExitReasonX64InterruptWindow := 7
    static WHvRunVpExitReasonX64Halt := 8
    static WHvRunVpExitReasonX64ApicEoi := 9
    static WHvRunVpExitReasonSynicSintDeliverable := 10
    static WHvRunVpExitReasonX64MsrAccess := 4096
    static WHvRunVpExitReasonX64Cpuid := 4097
    static WHvRunVpExitReasonException := 4098
    static WHvRunVpExitReasonX64Rdtsc := 4099
    static WHvRunVpExitReasonX64ApicSmiTrap := 4100
    static WHvRunVpExitReasonHypercall := 4101
    static WHvRunVpExitReasonX64ApicInitSipiTrap := 4102
    static WHvRunVpExitReasonX64ApicWriteTrap := 4103
    static WHvRunVpExitReasonCanceled := 8193
}
struct WHV_X64_VP_EXECUTION_STATE {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT16 : UInt16
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt16
    }
}
struct WHV_X64_VP_EXIT_CONTEXT {
    ExecutionState : WHV_X64_VP_EXECUTION_STATE
    _bitfield : UInt8
    Reserved : UInt8
    Reserved2 : UInt32
    Cs : WHV_X64_SEGMENT_REGISTER
    Rip : Int64
    Rflags : Int64
}
struct WHV_SYNIC_SINT_DELIVERABLE_CONTEXT {
    DeliverableSints : UInt16
    Reserved1 : UInt16
    Reserved2 : UInt32
}
struct WHV_MEMORY_ACCESS_INFO {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT32 : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct WHV_MEMORY_ACCESS_CONTEXT {
    InstructionByteCount : UInt8
    Reserved : UInt8[3]
    InstructionBytes : UInt8[16]
    AccessInfo : WHV_MEMORY_ACCESS_INFO
    Gpa : Int64
    Gva : Int64
}
struct WHV_X64_IO_PORT_ACCESS_INFO {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT32 : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct WHV_X64_IO_PORT_ACCESS_CONTEXT {
    InstructionByteCount : UInt8
    Reserved : UInt8[3]
    InstructionBytes : UInt8[16]
    AccessInfo : WHV_X64_IO_PORT_ACCESS_INFO
    PortNumber : UInt16
    Reserved2 : UInt16[3]
    Rax : Int64
    Rcx : Int64
    Rsi : Int64
    Rdi : Int64
    Ds : WHV_X64_SEGMENT_REGISTER
    Es : WHV_X64_SEGMENT_REGISTER
}
struct WHV_X64_MSR_ACCESS_INFO {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT32 : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct WHV_X64_MSR_ACCESS_CONTEXT {
    AccessInfo : WHV_X64_MSR_ACCESS_INFO
    MsrNumber : UInt32
    Rax : Int64
    Rdx : Int64
}
struct WHV_X64_CPUID_ACCESS_CONTEXT {
    Rax : Int64
    Rcx : Int64
    Rdx : Int64
    Rbx : Int64
    DefaultResultRax : Int64
    DefaultResultRcx : Int64
    DefaultResultRdx : Int64
    DefaultResultRbx : Int64
}
struct WHV_VP_EXCEPTION_INFO {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT32 : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct WHV_VP_EXCEPTION_CONTEXT {
    InstructionByteCount : UInt8
    Reserved : UInt8[3]
    InstructionBytes : UInt8[16]
    ExceptionInfo : WHV_VP_EXCEPTION_INFO
    ExceptionType : UInt8
    Reserved2 : UInt8[3]
    ErrorCode : UInt32
    ExceptionParameter : Int64
}
struct WHV_X64_UNSUPPORTED_FEATURE_CODE extends Int32 {
    static WHvUnsupportedFeatureIntercept := 1
    static WHvUnsupportedFeatureTaskSwitchTss := 2
}
struct WHV_X64_UNSUPPORTED_FEATURE_CONTEXT {
    FeatureCode : WHV_X64_UNSUPPORTED_FEATURE_CODE
    Reserved : UInt32
    FeatureParameter : Int64
}
struct WHV_RUN_VP_CANCEL_REASON extends Int32 {
    static WHvRunVpCancelReasonUser := 0
}
struct WHV_RUN_VP_CANCELED_CONTEXT {
    CancelReason : WHV_RUN_VP_CANCEL_REASON
}
struct WHV_X64_PENDING_INTERRUPTION_TYPE extends Int32 {
    static WHvX64PendingInterrupt := 0
    static WHvX64PendingNmi := 2
    static WHvX64PendingException := 3
}
struct WHV_X64_INTERRUPTION_DELIVERABLE_CONTEXT {
    DeliverableType : WHV_X64_PENDING_INTERRUPTION_TYPE
}
struct WHV_X64_APIC_EOI_CONTEXT {
    InterruptVector : UInt32
}
struct WHV_X64_RDTSC_INFO {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT64 : Int64
    }
    struct _Anonymous_e__Struct {
        _bitfield : Int64
    }
}
struct WHV_X64_RDTSC_CONTEXT {
    TscAux : Int64
    VirtualOffset : Int64
    Tsc : Int64
    ReferenceTime : Int64
    RdtscInfo : WHV_X64_RDTSC_INFO
}
struct WHV_X64_APIC_SMI_CONTEXT {
    ApicIcr : Int64
}
struct WHV_X64_HYPERCALL_CONTEXT {
    Rax : Int64
    Rbx : Int64
    Rcx : Int64
    Rdx : Int64
    R8 : Int64
    Rsi : Int64
    Rdi : Int64
    Reserved0 : Int64
    XmmRegisters : WHV_UINT128[6]
    Reserved1 : Int64[2]
}
struct WHV_X64_APIC_INIT_SIPI_CONTEXT {
    ApicIcr : Int64
}
struct WHV_X64_APIC_WRITE_TYPE extends Int32 {
    static WHvX64ApicWriteTypeLdr := 208
    static WHvX64ApicWriteTypeDfr := 224
    static WHvX64ApicWriteTypeSvr := 240
    static WHvX64ApicWriteTypeLint0 := 848
    static WHvX64ApicWriteTypeLint1 := 864
}
struct WHV_X64_APIC_WRITE_CONTEXT {
    Type : WHV_X64_APIC_WRITE_TYPE
    Reserved : UInt32
    WriteValue : Int64
}
struct WHV_RUN_VP_EXIT_CONTEXT {
    ExitReason : WHV_RUN_VP_EXIT_REASON
    Reserved : UInt32
    VpContext : WHV_X64_VP_EXIT_CONTEXT
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            MemoryAccess : WHV_MEMORY_ACCESS_CONTEXT
            CancelReason : WHV_RUN_VP_CANCELED_CONTEXT
            Hypercall : WHV_X64_HYPERCALL_CONTEXT
            SynicSintDeliverable : WHV_SYNIC_SINT_DELIVERABLE_CONTEXT
            IoPortAccess : WHV_X64_IO_PORT_ACCESS_CONTEXT
            MsrAccess : WHV_X64_MSR_ACCESS_CONTEXT
            CpuidAccess : WHV_X64_CPUID_ACCESS_CONTEXT
            VpException : WHV_VP_EXCEPTION_CONTEXT
            InterruptWindow : WHV_X64_INTERRUPTION_DELIVERABLE_CONTEXT
            UnsupportedFeature : WHV_X64_UNSUPPORTED_FEATURE_CONTEXT
            ApicEoi : WHV_X64_APIC_EOI_CONTEXT
            ReadTsc : WHV_X64_RDTSC_CONTEXT
            ApicSmi : WHV_X64_APIC_SMI_CONTEXT
            ApicInitSipi : WHV_X64_APIC_INIT_SIPI_CONTEXT
            ApicWrite : WHV_X64_APIC_WRITE_CONTEXT
            AsUINT64 : Int64[22]
        }
    }
}
struct WHV_INTERRUPT_TYPE extends Int32 {
    static WHvX64InterruptTypeFixed := 0
    static WHvX64InterruptTypeLowestPriority := 1
    static WHvX64InterruptTypeNmi := 4
    static WHvX64InterruptTypeInit := 5
    static WHvX64InterruptTypeSipi := 6
    static WHvX64InterruptTypeLocalInt1 := 9
}
struct WHV_INTERRUPT_DESTINATION_MODE extends Int32 {
    static WHvX64InterruptDestinationModePhysical := 0
    static WHvX64InterruptDestinationModeLogical := 1
}
struct WHV_INTERRUPT_TRIGGER_MODE extends Int32 {
    static WHvX64InterruptTriggerModeEdge := 0
    static WHvX64InterruptTriggerModeLevel := 1
}
struct WHV_INTERRUPT_CONTROL {
    _bitfield : Int64
    Destination : UInt32
    Vector : UInt32
}
struct WHV_DOORBELL_MATCH_DATA {
    GuestAddress : Int64
    Value : Int64
    Length : UInt32
    _bitfield : UInt32
}
struct WHV_PARTITION_COUNTER_SET extends Int32 {
    static WHvPartitionCounterSetMemory := 0
}
struct WHV_PARTITION_MEMORY_COUNTERS {
    Mapped4KPageCount : Int64
    Mapped2MPageCount : Int64
    Mapped1GPageCount : Int64
}
struct WHV_PROCESSOR_COUNTER_SET extends Int32 {
    static WHvProcessorCounterSetRuntime := 0
    static WHvProcessorCounterSetIntercepts := 1
    static WHvProcessorCounterSetEvents := 2
    static WHvProcessorCounterSetApic := 3
    static WHvProcessorCounterSetSyntheticFeatures := 4
}
struct WHV_PROCESSOR_RUNTIME_COUNTERS {
    TotalRuntime100ns : Int64
    HypervisorRuntime100ns : Int64
}
struct WHV_PROCESSOR_INTERCEPT_COUNTER {
    Count : Int64
    Time100ns : Int64
}
struct WHV_PROCESSOR_INTERCEPT_COUNTERS {
    PageInvalidations : WHV_PROCESSOR_INTERCEPT_COUNTER
    ControlRegisterAccesses : WHV_PROCESSOR_INTERCEPT_COUNTER
    IoInstructions : WHV_PROCESSOR_INTERCEPT_COUNTER
    HaltInstructions : WHV_PROCESSOR_INTERCEPT_COUNTER
    CpuidInstructions : WHV_PROCESSOR_INTERCEPT_COUNTER
    MsrAccesses : WHV_PROCESSOR_INTERCEPT_COUNTER
    OtherIntercepts : WHV_PROCESSOR_INTERCEPT_COUNTER
    PendingInterrupts : WHV_PROCESSOR_INTERCEPT_COUNTER
    EmulatedInstructions : WHV_PROCESSOR_INTERCEPT_COUNTER
    DebugRegisterAccesses : WHV_PROCESSOR_INTERCEPT_COUNTER
    PageFaultIntercepts : WHV_PROCESSOR_INTERCEPT_COUNTER
    NestedPageFaultIntercepts : WHV_PROCESSOR_INTERCEPT_COUNTER
    Hypercalls : WHV_PROCESSOR_INTERCEPT_COUNTER
    RdpmcInstructions : WHV_PROCESSOR_INTERCEPT_COUNTER
}
struct WHV_PROCESSOR_EVENT_COUNTERS {
    PageFaultCount : Int64
    ExceptionCount : Int64
    InterruptCount : Int64
}
struct WHV_PROCESSOR_APIC_COUNTERS {
    MmioAccessCount : Int64
    EoiAccessCount : Int64
    TprAccessCount : Int64
    SentIpiCount : Int64
    SelfIpiCount : Int64
}
struct WHV_PROCESSOR_SYNTHETIC_FEATURES_COUNTERS {
    SyntheticInterruptsCount : Int64
    LongSpinWaitHypercallsCount : Int64
    OtherHypercallsCount : Int64
    SyntheticInterruptHypercallsCount : Int64
    VirtualInterruptHypercallsCount : Int64
    VirtualMmuHypercallsCount : Int64
}
struct WHV_VTL_PERMISSION_SET {
    union {
        AsUINT32 : UInt32
        Anonymous : this._Anonymous_e__Struct
    }
    struct _Anonymous_e__Struct {
        VtlPermissionFrom1 : UInt16[2]
    }
}
struct WHV_ADVISE_GPA_RANGE_CODE extends Int32 {
    static WHvAdviseGpaRangeCodePopulate := 0
    static WHvAdviseGpaRangeCodePin := 1
    static WHvAdviseGpaRangeCodeUnpin := 2
}
struct WHV_VIRTUAL_PROCESSOR_STATE_TYPE extends Int32 {
    static WHvVirtualProcessorStateTypeSynicMessagePage := 0
    static WHvVirtualProcessorStateTypeSynicEventFlagPage := 1
    static WHvVirtualProcessorStateTypeSynicTimerState := 2
    static WHvVirtualProcessorStateTypeInterruptControllerState2 := 4096
    static WHvVirtualProcessorStateTypeXsaveState := 4097
    static WHvVirtualProcessorStateTypeNestedState := 4098
}
struct WHV_NESTED_STATE_TYPE extends Int32 {
    static WHvNestedStateTypeVmx := 0
    static WHvNestedStateTypeSvm := 1
}
struct WHV_NESTED_ENLIGHTENMENTS_CONTROL {
    Features : this._Features_e__Union
    HypercallControls : this._HypercallControls_e__Union
    struct _Features_e__Union {
        union {
            AsUINT32 : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
    struct _HypercallControls_e__Union {
        union {
            AsUINT32 : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct WHV_X64_VMX_NESTED_STATE {
    Vendor : WHV_NESTED_STATE_TYPE
    Flags : this._Flags_e__Struct
    NestedEnlightenmentsControl : WHV_NESTED_ENLIGHTENMENTS_CONTROL
    Pdpt : Int64[4]
    VmxonRegionGpa : Int64
    VmcsGpa : Int64
    CurrentEnlightenedVmcs : Int64
    VirtualApicRegs : this._VirtualApicRegs_e__Struct
    Reserved : UInt8[3944]
    VmcsBytes : UInt8[4096]
    struct _Flags_e__Struct {
        _bitfield : UInt32
    }
    struct _VirtualApicRegs_e__Struct {
        Tpr : UInt32
        Ppr : UInt32
        Isr : UInt32[8]
        Irr : UInt32[8]
        IcrLow : UInt32
        IcrHigh : UInt32
    }
}
struct WHV_SVM_VMCB_SELECTOR {
    Selector : UInt16
    Attrib : UInt16
    Limit : UInt32
    Base : Int64
}
struct WHV_SVM_NESTED_HOST_STATE {
    Rip : Int64
    Rsp : Int64
    Rflags : Int64
    Rax : Int64
    Es : WHV_SVM_VMCB_SELECTOR
    Cs : WHV_SVM_VMCB_SELECTOR
    Ss : WHV_SVM_VMCB_SELECTOR
    Ds : WHV_SVM_VMCB_SELECTOR
    Gdtr : WHV_SVM_VMCB_SELECTOR
    Idtr : WHV_SVM_VMCB_SELECTOR
    Efer : Int64
    Cr0 : Int64
    Cr3 : Int64
    Cr4 : Int64
    VirtualTpr : Int64
    Reserved : Int64[6]
}
struct WHV_X64_SVM_NESTED_STATE {
    Vendor : WHV_NESTED_STATE_TYPE
    Flags : this._Flags_e__Struct
    NestedEnlightenmentsControl : WHV_NESTED_ENLIGHTENMENTS_CONTROL
    HostSaveGpa : Int64
    VmControlMsr : Int64
    VirtualTscRatioMsr : Int64
    VmcbGpa : Int64
    HostState : WHV_SVM_NESTED_HOST_STATE
    Reserved : UInt8[3832]
    VmcbBytes : UInt8[4096]
    struct _Flags_e__Struct {
        _bitfield : UInt32
    }
}
struct WHV_X64_NESTED_STATE {
    union {
        Vmx : WHV_X64_VMX_NESTED_STATE
        Svm : WHV_X64_SVM_NESTED_STATE
    }
}
struct WHV_SYNIC_EVENT_PARAMETERS {
    VpIndex : UInt32
    TargetSint : UInt8
    TargetVtl : UInt8
    FlagNumber : UInt16
}
struct WHV_ALLOCATE_VPCI_RESOURCE_FLAGS extends Int32 {
    static WHvAllocateVpciResourceFlagNone := 0
    static WHvAllocateVpciResourceFlagAllowDirectP2P := 1
}
struct WHV_SRIOV_RESOURCE_DESCRIPTOR {
    PnpInstanceId : UInt16[200]
    VirtualFunctionId : LUID
    VirtualFunctionIndex : UInt16
    Reserved : UInt16
}
struct WHV_VPCI_DEVICE_NOTIFICATION_TYPE extends Int32 {
    static WHvVpciDeviceNotificationUndefined := 0
    static WHvVpciDeviceNotificationMmioRemapping := 1
    static WHvVpciDeviceNotificationSurpriseRemoval := 2
}
struct WHV_VPCI_DEVICE_NOTIFICATION {
    NotificationType : WHV_VPCI_DEVICE_NOTIFICATION_TYPE
    Reserved1 : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Reserved2 : Int64
        }
    }
}
struct WHV_CREATE_VPCI_DEVICE_FLAGS extends Int32 {
    static WHvCreateVpciDeviceFlagNone := 0
    static WHvCreateVpciDeviceFlagPhysicallyBacked := 1
    static WHvCreateVpciDeviceFlagUseLogicalInterrupts := 2
}
struct WHV_VPCI_DEVICE_PROPERTY_CODE extends Int32 {
    static WHvVpciDevicePropertyCodeUndefined := 0
    static WHvVpciDevicePropertyCodeHardwareIDs := 1
    static WHvVpciDevicePropertyCodeProbedBARs := 2
}
struct WHV_VPCI_HARDWARE_IDS {
    VendorID : UInt16
    DeviceID : UInt16
    RevisionID : UInt8
    ProgIf : UInt8
    SubClass : UInt8
    BaseClass : UInt8
    SubVendorID : UInt16
    SubSystemID : UInt16
}
struct WHV_VPCI_PROBED_BARS {
    Value : UInt32[6]
}
struct WHV_VPCI_MMIO_RANGE_FLAGS extends Int32 {
    static WHvVpciMmioRangeFlagReadAccess := 1
    static WHvVpciMmioRangeFlagWriteAccess := 2
}
struct WHV_VPCI_DEVICE_REGISTER_SPACE extends Int32 {
    static WHvVpciConfigSpace := -1
    static WHvVpciBar0 := 0
    static WHvVpciBar1 := 1
    static WHvVpciBar2 := 2
    static WHvVpciBar3 := 3
    static WHvVpciBar4 := 4
    static WHvVpciBar5 := 5
}
struct WHV_VPCI_MMIO_MAPPING {
    Location : WHV_VPCI_DEVICE_REGISTER_SPACE
    Flags : WHV_VPCI_MMIO_RANGE_FLAGS
    SizeInBytes : Int64
    OffsetInBytes : Int64
    VirtualAddress : Struct.Ptr
}
struct WHV_VPCI_DEVICE_REGISTER {
    Location : WHV_VPCI_DEVICE_REGISTER_SPACE
    SizeInBytes : UInt32
    OffsetInBytes : Int64
}
struct WHV_VPCI_INTERRUPT_TARGET_FLAGS extends Int32 {
    static WHvVpciInterruptTargetFlagNone := 0
    static WHvVpciInterruptTargetFlagMulticast := 1
}
struct WHV_VPCI_INTERRUPT_TARGET {
    Vector : UInt32
    Flags : WHV_VPCI_INTERRUPT_TARGET_FLAGS
    ProcessorCount : UInt32
    Processors : UInt32[1]
}
struct WHV_TRIGGER_TYPE extends Int32 {
    static WHvTriggerTypeInterrupt := 0
    static WHvTriggerTypeSynicEvent := 1
    static WHvTriggerTypeDeviceInterrupt := 2
}
struct WHV_TRIGGER_PARAMETERS {
    TriggerType : WHV_TRIGGER_TYPE
    Reserved : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Interrupt : WHV_INTERRUPT_CONTROL
            SynicEvent : WHV_SYNIC_EVENT_PARAMETERS
            DeviceInterrupt : this._DeviceInterrupt_e__Struct
        }
        struct _DeviceInterrupt_e__Struct {
            LogicalDeviceId : Int64
            MsiAddress : Int64
            MsiData : UInt32
            Reserved : UInt32
        }
    }
}
struct WHV_VIRTUAL_PROCESSOR_PROPERTY_CODE extends Int32 {
    static WHvVirtualProcessorPropertyCodeNumaNode := 0
}
struct WHV_VIRTUAL_PROCESSOR_PROPERTY {
    PropertyCode : WHV_VIRTUAL_PROCESSOR_PROPERTY_CODE
    Reserved : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            NumaNode : UInt16
            Padding : Int64
        }
    }
}
struct WHV_NOTIFICATION_PORT_TYPE extends Int32 {
    static WHvNotificationPortTypeEvent := 2
    static WHvNotificationPortTypeDoorbell := 4
}
struct WHV_NOTIFICATION_PORT_PARAMETERS {
    NotificationPortType : WHV_NOTIFICATION_PORT_TYPE
    Reserved : UInt16
    Reserved1 : UInt8
    ConnectionVtl : UInt8
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Doorbell : WHV_DOORBELL_MATCH_DATA
            Event : this._Event_e__Struct
        }
        struct _Event_e__Struct {
            ConnectionId : UInt32
        }
    }
}
struct WHV_NOTIFICATION_PORT_PROPERTY_CODE extends Int32 {
    static WHvNotificationPortPropertyPreferredTargetVp := 1
    static WHvNotificationPortPropertyPreferredTargetDuration := 5
}
struct WHV_EMULATOR_STATUS {
    union {
        Anonymous : this._Anonymous_e__Struct
        AsUINT32 : UInt32
    }
    struct _Anonymous_e__Struct {
        _bitfield : UInt32
    }
}
struct WHV_EMULATOR_MEMORY_ACCESS_INFO {
    GpaAddress : Int64
    Direction : UInt8
    AccessSize : UInt8
    Data : UInt8[8]
}
struct WHV_EMULATOR_IO_ACCESS_INFO {
    Direction : UInt8
    Port : UInt16
    AccessSize : UInt16
    Data : UInt32
}
struct WHV_EMULATOR_IO_PORT_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, WHV_EMULATOR_IO_ACCESS_INFO.Ptr, HRESULT]
}
struct WHV_EMULATOR_MEMORY_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, WHV_EMULATOR_MEMORY_ACCESS_INFO.Ptr, HRESULT]
}
struct WHV_EMULATOR_GET_VIRTUAL_PROCESSOR_REGISTERS_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, WHV_REGISTER_NAME.Ptr, UInt32, WHV_REGISTER_VALUE.Ptr, HRESULT]
}
struct WHV_EMULATOR_SET_VIRTUAL_PROCESSOR_REGISTERS_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, WHV_REGISTER_NAME.Ptr, UInt32, WHV_REGISTER_VALUE.Ptr, HRESULT]
}
struct WHV_EMULATOR_TRANSLATE_GVA_PAGE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, Int64, WHV_TRANSLATE_GVA_FLAGS, WHV_TRANSLATE_GVA_RESULT_CODE.Ptr, Int64.Ptr, HRESULT]
}
struct WHV_EMULATOR_CALLBACKS {
    Size : UInt32
    Reserved : UInt32
    WHvEmulatorIoPortCallback : WHV_EMULATOR_IO_PORT_CALLBACK
    WHvEmulatorMemoryCallback : WHV_EMULATOR_MEMORY_CALLBACK
    WHvEmulatorGetVirtualProcessorRegisters : WHV_EMULATOR_GET_VIRTUAL_PROCESSOR_REGISTERS_CALLBACK
    WHvEmulatorSetVirtualProcessorRegisters : WHV_EMULATOR_SET_VIRTUAL_PROCESSOR_REGISTERS_CALLBACK
    WHvEmulatorTranslateGvaPage : WHV_EMULATOR_TRANSLATE_GVA_PAGE_CALLBACK
}
struct SOCKADDR_HV {
    Family : ADDRESS_FAMILY
    Reserved : UInt16
    VmId : GUID
    ServiceId : GUID
}
struct HVSOCKET_ADDRESS_INFO {
    SystemId : GUID
    VirtualMachineId : GUID
    SiloId : GUID
    Flags : UInt32
}
struct VM_GENCOUNTER {
    GenerationCount : Int64
    GenerationCountHigh : Int64
}
struct HDV_DEVICE_TYPE extends Int32 {
    static HdvDeviceTypeUndefined := 0
    static HdvDeviceTypePCI := 1
}
struct HDV_DEVICE_HOST_FLAGS extends Int32 {
    static HdvDeviceHostFlagNone := 0
    static HdvDeviceHostFlagInitializeComSecurity := 1
}
struct HDV_PCI_PNP_ID {
    VendorID : UInt16
    DeviceID : UInt16
    RevisionID : UInt8
    ProgIf : UInt8
    SubClass : UInt8
    BaseClass : UInt8
    SubVendorID : UInt16
    SubSystemID : UInt16
}
struct HDV_PCI_BAR_SELECTOR extends Int32 {
    static HDV_PCI_BAR0 := 0
    static HDV_PCI_BAR1 := 1
    static HDV_PCI_BAR2 := 2
    static HDV_PCI_BAR3 := 3
    static HDV_PCI_BAR4 := 4
    static HDV_PCI_BAR5 := 5
}
struct HDV_DOORBELL_FLAGS extends Int32 {
    static HDV_DOORBELL_FLAG_TRIGGER_SIZE_ANY := 0
    static HDV_DOORBELL_FLAG_TRIGGER_SIZE_BYTE := 1
    static HDV_DOORBELL_FLAG_TRIGGER_SIZE_WORD := 2
    static HDV_DOORBELL_FLAG_TRIGGER_SIZE_DWORD := 3
    static HDV_DOORBELL_FLAG_TRIGGER_SIZE_QWORD := 4
    static HDV_DOORBELL_FLAG_TRIGGER_ANY_VALUE := -2147483648
}
struct HDV_MMIO_MAPPING_FLAGS extends Int32 {
    static HdvMmioMappingFlagNone := 0
    static HdvMmioMappingFlagWriteable := 1
    static HdvMmioMappingFlagExecutable := 2
}
struct HDV_PCI_DEVICE_INITIALIZE extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT]
}
struct HDV_PCI_DEVICE_TEARDOWN extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct HDV_PCI_DEVICE_SET_CONFIGURATION extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, PWSTR.Ptr, HRESULT]
}
struct HDV_PCI_DEVICE_GET_DETAILS extends FunctionPointer {
    static Types := [Struct.Ptr, HDV_PCI_PNP_ID.Ptr, UInt32, UInt32.Ptr, HRESULT]
}
struct HDV_PCI_DEVICE_START extends FunctionPointer {
    static Types := [Struct.Ptr, HRESULT]
}
struct HDV_PCI_DEVICE_STOP extends FunctionPointer {
    static Types := [Struct.Ptr, "Void"]
}
struct HDV_PCI_READ_CONFIG_SPACE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, UInt32.Ptr, HRESULT]
}
struct HDV_PCI_WRITE_CONFIG_SPACE extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, UInt32, HRESULT]
}
struct HDV_PCI_READ_INTERCEPTED_MEMORY extends FunctionPointer {
    static Types := [Struct.Ptr, HDV_PCI_BAR_SELECTOR, Int64, Int64, UInt8.Ptr, HRESULT]
}
struct HDV_PCI_WRITE_INTERCEPTED_MEMORY extends FunctionPointer {
    static Types := [Struct.Ptr, HDV_PCI_BAR_SELECTOR, Int64, Int64, UInt8.Ptr, HRESULT]
}
struct HDV_PCI_INTERFACE_VERSION extends Int32 {
    static HdvPciDeviceInterfaceVersionInvalid := 0
    static HdvPciDeviceInterfaceVersion1 := 1
}
struct HDV_PCI_DEVICE_INTERFACE {
    Version : HDV_PCI_INTERFACE_VERSION
    Initialize : HDV_PCI_DEVICE_INITIALIZE
    Teardown : HDV_PCI_DEVICE_TEARDOWN
    SetConfiguration : HDV_PCI_DEVICE_SET_CONFIGURATION
    GetDetails : HDV_PCI_DEVICE_GET_DETAILS
    Start : HDV_PCI_DEVICE_START
    Stop : HDV_PCI_DEVICE_STOP
    ReadConfigSpace : HDV_PCI_READ_CONFIG_SPACE
    WriteConfigSpace : HDV_PCI_WRITE_CONFIG_SPACE
    ReadInterceptedMemory : HDV_PCI_READ_INTERCEPTED_MEMORY
    WriteInterceptedMemory : HDV_PCI_WRITE_INTERCEPTED_MEMORY
}
struct PAGING_MODE extends Int32 {
    static Paging_Invalid := 0
    static Paging_NonPaged := 1
    static Paging_32Bit := 2
    static Paging_Pae := 3
    static Paging_Long := 4
    static Paging_Armv8 := 5
}
struct GPA_MEMORY_CHUNK {
    GuestPhysicalStartPageIndex : Int64
    PageCount : Int64
}
struct VIRTUAL_PROCESSOR_ARCH extends Int32 {
    static Arch_Unknown := 0
    static Arch_x86 := 1
    static Arch_x64 := 2
    static Arch_Armv8 := 3
}
struct VIRTUAL_PROCESSOR_VENDOR extends Int32 {
    static ProcessorVendor_Unknown := 0
    static ProcessorVendor_Amd := 1
    static ProcessorVendor_Intel := 2
    static ProcessorVendor_Hygon := 3
    static ProcessorVendor_Arm := 4
}
struct GUEST_OS_VENDOR extends Int32 {
    static GuestOsVendorUndefined := 0
    static GuestOsVendorMicrosoft := 1
    static GuestOsVendorHPE := 2
    static GuestOsVendorLANCOM := 512
}
struct GUEST_OS_MICROSOFT_IDS extends Int32 {
    static GuestOsMicrosoftUndefined := 0
    static GuestOsMicrosoftMSDOS := 1
    static GuestOsMicrosoftWindows3x := 2
    static GuestOsMicrosoftWindows9x := 3
    static GuestOsMicrosoftWindowsNT := 4
    static GuestOsMicrosoftWindowsCE := 5
}
struct GUEST_OS_OPENSOURCE_IDS extends Int32 {
    static GuestOsOpenSourceUndefined := 0
    static GuestOsOpenSourceLinux := 1
    static GuestOsOpenSourceFreeBSD := 2
    static GuestOsOpenSourceXen := 3
    static GuestOsOpenSourceIllumos := 4
}
struct GUEST_OS_INFO {
    union {
        AsUINT64 : Int64
        ClosedSource : this._ClosedSource_e__Struct
        OpenSource : this._OpenSource_e__Struct
    }
    struct _ClosedSource_e__Struct {
        _bitfield : Int64
    }
    struct _OpenSource_e__Struct {
        _bitfield : Int64
    }
}
struct REGISTER_ID extends Int32 {
    static X64_RegisterRax := 0
    static X64_RegisterRcx := 1
    static X64_RegisterRdx := 2
    static X64_RegisterRbx := 3
    static X64_RegisterRsp := 4
    static X64_RegisterRbp := 5
    static X64_RegisterRsi := 6
    static X64_RegisterRdi := 7
    static X64_RegisterR8 := 8
    static X64_RegisterR9 := 9
    static X64_RegisterR10 := 10
    static X64_RegisterR11 := 11
    static X64_RegisterR12 := 12
    static X64_RegisterR13 := 13
    static X64_RegisterR14 := 14
    static X64_RegisterR15 := 15
    static X64_RegisterRip := 16
    static X64_RegisterRFlags := 17
    static X64_RegisterXmm0 := 18
    static X64_RegisterXmm1 := 19
    static X64_RegisterXmm2 := 20
    static X64_RegisterXmm3 := 21
    static X64_RegisterXmm4 := 22
    static X64_RegisterXmm5 := 23
    static X64_RegisterXmm6 := 24
    static X64_RegisterXmm7 := 25
    static X64_RegisterXmm8 := 26
    static X64_RegisterXmm9 := 27
    static X64_RegisterXmm10 := 28
    static X64_RegisterXmm11 := 29
    static X64_RegisterXmm12 := 30
    static X64_RegisterXmm13 := 31
    static X64_RegisterXmm14 := 32
    static X64_RegisterXmm15 := 33
    static X64_RegisterFpMmx0 := 34
    static X64_RegisterFpMmx1 := 35
    static X64_RegisterFpMmx2 := 36
    static X64_RegisterFpMmx3 := 37
    static X64_RegisterFpMmx4 := 38
    static X64_RegisterFpMmx5 := 39
    static X64_RegisterFpMmx6 := 40
    static X64_RegisterFpMmx7 := 41
    static X64_RegisterFpControlStatus := 42
    static X64_RegisterXmmControlStatus := 43
    static X64_RegisterCr0 := 44
    static X64_RegisterCr2 := 45
    static X64_RegisterCr3 := 46
    static X64_RegisterCr4 := 47
    static X64_RegisterCr8 := 48
    static X64_RegisterEfer := 49
    static X64_RegisterDr0 := 50
    static X64_RegisterDr1 := 51
    static X64_RegisterDr2 := 52
    static X64_RegisterDr3 := 53
    static X64_RegisterDr6 := 54
    static X64_RegisterDr7 := 55
    static X64_RegisterEs := 56
    static X64_RegisterCs := 57
    static X64_RegisterSs := 58
    static X64_RegisterDs := 59
    static X64_RegisterFs := 60
    static X64_RegisterGs := 61
    static X64_RegisterLdtr := 62
    static X64_RegisterTr := 63
    static X64_RegisterIdtr := 64
    static X64_RegisterGdtr := 65
    static X64_RegisterMax := 66
    static ARM64_RegisterX0 := 67
    static ARM64_RegisterX1 := 68
    static ARM64_RegisterX2 := 69
    static ARM64_RegisterX3 := 70
    static ARM64_RegisterX4 := 71
    static ARM64_RegisterX5 := 72
    static ARM64_RegisterX6 := 73
    static ARM64_RegisterX7 := 74
    static ARM64_RegisterX8 := 75
    static ARM64_RegisterX9 := 76
    static ARM64_RegisterX10 := 77
    static ARM64_RegisterX11 := 78
    static ARM64_RegisterX12 := 79
    static ARM64_RegisterX13 := 80
    static ARM64_RegisterX14 := 81
    static ARM64_RegisterX15 := 82
    static ARM64_RegisterX16 := 83
    static ARM64_RegisterX17 := 84
    static ARM64_RegisterX18 := 85
    static ARM64_RegisterX19 := 86
    static ARM64_RegisterX20 := 87
    static ARM64_RegisterX21 := 88
    static ARM64_RegisterX22 := 89
    static ARM64_RegisterX23 := 90
    static ARM64_RegisterX24 := 91
    static ARM64_RegisterX25 := 92
    static ARM64_RegisterX26 := 93
    static ARM64_RegisterX27 := 94
    static ARM64_RegisterX28 := 95
    static ARM64_RegisterXFp := 96
    static ARM64_RegisterXLr := 97
    static ARM64_RegisterPc := 98
    static ARM64_RegisterSpEl0 := 99
    static ARM64_RegisterSpEl1 := 100
    static ARM64_RegisterCpsr := 101
    static ARM64_RegisterQ0 := 102
    static ARM64_RegisterQ1 := 103
    static ARM64_RegisterQ2 := 104
    static ARM64_RegisterQ3 := 105
    static ARM64_RegisterQ4 := 106
    static ARM64_RegisterQ5 := 107
    static ARM64_RegisterQ6 := 108
    static ARM64_RegisterQ7 := 109
    static ARM64_RegisterQ8 := 110
    static ARM64_RegisterQ9 := 111
    static ARM64_RegisterQ10 := 112
    static ARM64_RegisterQ11 := 113
    static ARM64_RegisterQ12 := 114
    static ARM64_RegisterQ13 := 115
    static ARM64_RegisterQ14 := 116
    static ARM64_RegisterQ15 := 117
    static ARM64_RegisterQ16 := 118
    static ARM64_RegisterQ17 := 119
    static ARM64_RegisterQ18 := 120
    static ARM64_RegisterQ19 := 121
    static ARM64_RegisterQ20 := 122
    static ARM64_RegisterQ21 := 123
    static ARM64_RegisterQ22 := 124
    static ARM64_RegisterQ23 := 125
    static ARM64_RegisterQ24 := 126
    static ARM64_RegisterQ25 := 127
    static ARM64_RegisterQ26 := 128
    static ARM64_RegisterQ27 := 129
    static ARM64_RegisterQ28 := 130
    static ARM64_RegisterQ29 := 131
    static ARM64_RegisterQ30 := 132
    static ARM64_RegisterQ31 := 133
    static ARM64_RegisterFpStatus := 134
    static ARM64_RegisterFpControl := 135
    static ARM64_RegisterEsrEl1 := 136
    static ARM64_RegisterSpsrEl1 := 137
    static ARM64_RegisterFarEl1 := 138
    static ARM64_RegisterParEl1 := 139
    static ARM64_RegisterElrEl1 := 140
    static ARM64_RegisterTtbr0El1 := 141
    static ARM64_RegisterTtbr1El1 := 142
    static ARM64_RegisterVbarEl1 := 143
    static ARM64_RegisterSctlrEl1 := 144
    static ARM64_RegisterActlrEl1 := 145
    static ARM64_RegisterTcrEl1 := 146
    static ARM64_RegisterMairEl1 := 147
    static ARM64_RegisterAmairEl1 := 148
    static ARM64_RegisterTpidrEl0 := 149
    static ARM64_RegisterTpidrroEl0 := 150
    static ARM64_RegisterTpidrEl1 := 151
    static ARM64_RegisterContextIdrEl1 := 152
    static ARM64_RegisterCpacrEl1 := 153
    static ARM64_RegisterCsselrEl1 := 154
    static ARM64_RegisterCntkctlEl1 := 155
    static ARM64_RegisterCntvCvalEl0 := 156
    static ARM64_RegisterCntvCtlEl0 := 157
    static ARM64_RegisterMax := 158
}
struct VIRTUAL_PROCESSOR_REGISTER {
    union {
        Reg64 : Int64
        Reg32 : UInt32
        Reg16 : UInt16
        Reg8 : UInt8
        Reg128 : this._Reg128_e__Struct
        X64 : this._X64_e__Union
    }
    struct _Reg128_e__Struct {
        Low64 : Int64
        High64 : Int64
    }
    struct _X64_e__Union {
        union {
            Segment : this._Segment_e__Struct
            Table : this._Table_e__Struct
            FpControlStatus : this._FpControlStatus_e__Struct
            XmmControlStatus : this._XmmControlStatus_e__Struct
        }
        struct _Segment_e__Struct {
            Base : Int64
            Limit : UInt32
            Selector : UInt16
            Anonymous : this._Anonymous_e__Union
            struct _Anonymous_e__Union {
                union {
                    Attributes : UInt16
                    Anonymous : this._Anonymous_e__Struct
                }
                struct _Anonymous_e__Struct {
                    _bitfield : UInt16
                }
            }
        }
        struct _Table_e__Struct {
            Limit : UInt16
            Base : Int64
        }
        struct _FpControlStatus_e__Struct {
            FpControl : UInt16
            FpStatus : UInt16
            FpTag : UInt8
            Reserved : UInt8
            LastFpOp : UInt16
            Anonymous : this._Anonymous_e__Union
            struct _Anonymous_e__Union {
                union {
                    LastFpRip : Int64
                    Anonymous : this._Anonymous_e__Struct
                }
                struct _Anonymous_e__Struct {
                    LastFpEip : UInt32
                    LastFpCs : UInt16
                }
            }
        }
        struct _XmmControlStatus_e__Struct {
            Anonymous : this._Anonymous_e__Union
            XmmStatusControl : UInt32
            XmmStatusControlMask : UInt32
            struct _Anonymous_e__Union {
                union {
                    LastFpRdp : Int64
                    Anonymous : this._Anonymous_e__Struct
                }
                struct _Anonymous_e__Struct {
                    LastFpDp : UInt32
                    LastFpDs : UInt16
                }
            }
        }
    }
}
struct DOS_IMAGE_INFO {
    PdbName : PSTR
    ImageBaseAddress : Int64
    ImageSize : UInt32
    Timestamp : UInt32
}
struct GUEST_SYMBOLS_PROVIDER_DEBUG_INFO_CALLBACK extends FunctionPointer {
    static Types := [PSTR, "Void"]
}
struct FOUND_IMAGE_CALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, DOS_IMAGE_INFO.Ptr, BOOL]
}
struct MODULE_INFO {
    ProcessImageName : PSTR
    Image : DOS_IMAGE_INFO
}
