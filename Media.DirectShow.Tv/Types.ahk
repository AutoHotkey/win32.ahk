#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, HANDLE, HRESULT, HWND, PWSTR, RECT, SIZE, VARIANT_BOOL}
#Import "..\Graphics.Gdi\Types.ahk" {HDC}
#Import "..\Media.DirectShow\Types.ahk" {AnalogVideoStandard, BinaryConvolutionCodeRate, ComponentCategory, ComponentStatus, DVBSystemType, FECMethod, GuardInterval, HierarchyAlpha, IESEvent, IESEvents, IEnumFilters, IFilterGraph, IGraphBuilder, IMediaSeeking, IPin, IVMRImageCompositor, IVMRMixerBitmap, IVMRSurfaceAllocator, LNB_Source, MPEG2StreamType, ModulationType, Pilot, Polarisation, RollOff, SpectralInversion, TVAudioMode, TransmissionMode, TunerInputType, VMRALPHABITMAP}
#Import "..\Media.KernelStreaming\Types.ahk" {KSDATAFORMAT, KSEVENTDATA, KSIDENTIFIER, KSM_NODE, KSP_NODE}
#Import "..\Media.MediaFoundation\Types.ahk" {AM_MEDIA_TYPE, IMFVideoPresenter}
#Import "..\Security\Types.ahk" {PSID}
#Import "..\System.Com\Types.ahk" {IDispatch, IEnumGUID, IEnumMoniker, IPersist, IUnknown, SAFEARRAY}
#Import "..\System.Ole\Types.ahk" {IEnumVARIANT, IPictureDisp}
#Import "..\System.Registry\Types.ahk" {HKEY}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct ICreatePropBagOnRegKey extends IUnknown {
    static IID := "{8A674B48-1F63-11D3-B64C-00C04F79498E}"
    Create(hkey1, subkey, ulOptions, samDesired, iid, ppBag)
      => ComCall(3, this.p, HKEY, hkey1, "Str", subkey, UInt32, ulOptions, UInt32, samDesired, GUID.Ptr, iid, Struct.Ptr.Ptr, ppBag)
}
struct DISPID_TUNER extends Int32 {
    static DISPID_TUNER_TS_UNIQUENAME := 1
    static DISPID_TUNER_TS_FRIENDLYNAME := 2
    static DISPID_TUNER_TS_CLSID := 3
    static DISPID_TUNER_TS_NETWORKTYPE := 4
    static DISPID_TUNER_TS__NETWORKTYPE := 5
    static DISPID_TUNER_TS_CREATETUNEREQUEST := 6
    static DISPID_TUNER_TS_ENUMCATEGORYGUIDS := 7
    static DISPID_TUNER_TS_ENUMDEVICEMONIKERS := 8
    static DISPID_TUNER_TS_DEFAULTPREFERREDCOMPONENTTYPES := 9
    static DISPID_TUNER_TS_FREQMAP := 10
    static DISPID_TUNER_TS_DEFLOCATOR := 11
    static DISPID_TUNER_TS_CLONE := 12
    static DISPID_TUNER_TR_TUNINGSPACE := 1
    static DISPID_TUNER_TR_COMPONENTS := 2
    static DISPID_TUNER_TR_CLONE := 3
    static DISPID_TUNER_TR_LOCATOR := 4
    static DISPID_TUNER_CT_CATEGORY := 1
    static DISPID_TUNER_CT_MEDIAMAJORTYPE := 2
    static DISPID_TUNER_CT__MEDIAMAJORTYPE := 3
    static DISPID_TUNER_CT_MEDIASUBTYPE := 4
    static DISPID_TUNER_CT__MEDIASUBTYPE := 5
    static DISPID_TUNER_CT_MEDIAFORMATTYPE := 6
    static DISPID_TUNER_CT__MEDIAFORMATTYPE := 7
    static DISPID_TUNER_CT_MEDIATYPE := 8
    static DISPID_TUNER_CT_CLONE := 9
    static DISPID_TUNER_LCT_LANGID := 100
    static DISPID_TUNER_MP2CT_TYPE := 200
    static DISPID_TUNER_ATSCCT_FLAGS := 300
    static DISPID_TUNER_L_CARRFREQ := 1
    static DISPID_TUNER_L_INNERFECMETHOD := 2
    static DISPID_TUNER_L_INNERFECRATE := 3
    static DISPID_TUNER_L_OUTERFECMETHOD := 4
    static DISPID_TUNER_L_OUTERFECRATE := 5
    static DISPID_TUNER_L_MOD := 6
    static DISPID_TUNER_L_SYMRATE := 7
    static DISPID_TUNER_L_CLONE := 8
    static DISPID_TUNER_L_ATSC_PHYS_CHANNEL := 201
    static DISPID_TUNER_L_ATSC_TSID := 202
    static DISPID_TUNER_L_ATSC_MP2_PROGNO := 203
    static DISPID_TUNER_L_DVBT_BANDWIDTH := 301
    static DISPID_TUNER_L_DVBT_LPINNERFECMETHOD := 302
    static DISPID_TUNER_L_DVBT_LPINNERFECRATE := 303
    static DISPID_TUNER_L_DVBT_GUARDINTERVAL := 304
    static DISPID_TUNER_L_DVBT_HALPHA := 305
    static DISPID_TUNER_L_DVBT_TRANSMISSIONMODE := 306
    static DISPID_TUNER_L_DVBT_INUSE := 307
    static DISPID_TUNER_L_DVBT2_PHYSICALLAYERPIPEID := 351
    static DISPID_TUNER_L_DVBS_POLARISATION := 401
    static DISPID_TUNER_L_DVBS_WEST := 402
    static DISPID_TUNER_L_DVBS_ORBITAL := 403
    static DISPID_TUNER_L_DVBS_AZIMUTH := 404
    static DISPID_TUNER_L_DVBS_ELEVATION := 405
    static DISPID_TUNER_L_DVBS2_DISEQ_LNB_SOURCE := 406
    static DISPID_TUNER_TS_DVBS2_LOW_OSC_FREQ_OVERRIDE := 407
    static DISPID_TUNER_TS_DVBS2_HI_OSC_FREQ_OVERRIDE := 408
    static DISPID_TUNER_TS_DVBS2_LNB_SWITCH_FREQ_OVERRIDE := 409
    static DISPID_TUNER_TS_DVBS2_SPECTRAL_INVERSION_OVERRIDE := 410
    static DISPID_TUNER_L_DVBS2_ROLLOFF := 411
    static DISPID_TUNER_L_DVBS2_PILOT := 412
    static DISPID_TUNER_L_ANALOG_STANDARD := 601
    static DISPID_TUNER_L_DTV_O_MAJOR_CHANNEL := 701
    static DISPID_TUNER_C_TYPE := 1
    static DISPID_TUNER_C_STATUS := 2
    static DISPID_TUNER_C_LANGID := 3
    static DISPID_TUNER_C_DESCRIPTION := 4
    static DISPID_TUNER_C_CLONE := 5
    static DISPID_TUNER_C_MP2_PID := 101
    static DISPID_TUNER_C_MP2_PCRPID := 102
    static DISPID_TUNER_C_MP2_PROGNO := 103
    static DISPID_TUNER_C_ANALOG_AUDIO := 201
    static DISPID_TUNER_TS_DVB_SYSTEMTYPE := 101
    static DISPID_TUNER_TS_DVB2_NETWORK_ID := 102
    static DISPID_TUNER_TS_DVBS_LOW_OSC_FREQ := 1001
    static DISPID_TUNER_TS_DVBS_HI_OSC_FREQ := 1002
    static DISPID_TUNER_TS_DVBS_LNB_SWITCH_FREQ := 1003
    static DISPID_TUNER_TS_DVBS_INPUT_RANGE := 1004
    static DISPID_TUNER_TS_DVBS_SPECTRAL_INVERSION := 1005
    static DISPID_TUNER_TS_AR_MINFREQUENCY := 101
    static DISPID_TUNER_TS_AR_MAXFREQUENCY := 102
    static DISPID_TUNER_TS_AR_STEP := 103
    static DISPID_TUNER_TS_AR_COUNTRYCODE := 104
    static DISPID_TUNER_TS_AUX_COUNTRYCODE := 101
    static DISPID_TUNER_TS_ATV_MINCHANNEL := 101
    static DISPID_TUNER_TS_ATV_MAXCHANNEL := 102
    static DISPID_TUNER_TS_ATV_INPUTTYPE := 103
    static DISPID_TUNER_TS_ATV_COUNTRYCODE := 104
    static DISPID_TUNER_TS_ATSC_MINMINORCHANNEL := 201
    static DISPID_TUNER_TS_ATSC_MAXMINORCHANNEL := 202
    static DISPID_TUNER_TS_ATSC_MINPHYSCHANNEL := 203
    static DISPID_TUNER_TS_ATSC_MAXPHYSCHANNEL := 204
    static DISPID_TUNER_TS_DC_MINMAJORCHANNEL := 301
    static DISPID_TUNER_TS_DC_MAXMAJORCHANNEL := 302
    static DISPID_TUNER_TS_DC_MINSOURCEID := 303
    static DISPID_TUNER_TS_DC_MAXSOURCEID := 304
    static DISPID_CHTUNER_ATVAC_CHANNEL := 101
    static DISPID_CHTUNER_ATVDC_SYSTEM := 101
    static DISPID_CHTUNER_ATVDC_CONTENT := 102
    static DISPID_CHTUNER_CIDTR_CHANNELID := 101
    static DISPID_CHTUNER_CTR_CHANNEL := 101
    static DISPID_CHTUNER_ACTR_MINOR_CHANNEL := 201
    static DISPID_CHTUNER_DCTR_MAJOR_CHANNEL := 301
    static DISPID_CHTUNER_DCTR_SRCID := 302
    static DISPID_DVBTUNER_DVBC_ATTRIBUTESVALID := 101
    static DISPID_DVBTUNER_DVBC_PID := 102
    static DISPID_DVBTUNER_DVBC_TAG := 103
    static DISPID_DVBTUNER_DVBC_COMPONENTTYPE := 104
    static DISPID_DVBTUNER_ONID := 101
    static DISPID_DVBTUNER_TSID := 102
    static DISPID_DVBTUNER_SID := 103
    static DISPID_MP2TUNER_TSID := 101
    static DISPID_MP2TUNER_PROGNO := 102
    static DISPID_MP2TUNERFACTORY_CREATETUNEREQUEST := 1
}
struct ITuningSpaces extends IDispatch {
    static IID := "{901284E4-33FE-4B69-8D63-634A596F3756}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(NewEnum)
      => ComCall(8, this.p, IEnumVARIANT.Ptr, NewEnum)
    get_Item(varIndex, TuningSpace)
      => ComCall(9, this.p, VARIANT, varIndex, ITuningSpace.Ptr, TuningSpace)
    get_EnumTuningSpaces(NewEnum)
      => ComCall(10, this.p, IEnumTuningSpaces.Ptr, NewEnum)
}
struct ITuningSpaceContainer extends IDispatch {
    static IID := "{5B692E84-E2F1-11D2-9493-00C04F72D980}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(NewEnum)
      => ComCall(8, this.p, IEnumVARIANT.Ptr, NewEnum)
    get_Item(varIndex, TuningSpace)
      => ComCall(9, this.p, VARIANT, varIndex, ITuningSpace.Ptr, TuningSpace)
    put_Item(varIndex, TuningSpace)
      => ComCall(10, this.p, VARIANT, varIndex, ITuningSpace, TuningSpace)
    TuningSpacesForCLSID(SpaceCLSID, NewColl)
      => ComCall(11, this.p, BSTR, SpaceCLSID, ITuningSpaces.Ptr, NewColl)
    _TuningSpacesForCLSID2(SpaceCLSID, NewColl)
      => ComCall(12, this.p, GUID.Ptr, SpaceCLSID, ITuningSpaces.Ptr, NewColl)
    TuningSpacesForName(Name, NewColl)
      => ComCall(13, this.p, BSTR, Name, ITuningSpaces.Ptr, NewColl)
    FindID(TuningSpace, ID)
      => ComCall(14, this.p, ITuningSpace, TuningSpace, Int32.Ptr, ID)
    Add(TuningSpace, NewIndex)
      => ComCall(15, this.p, ITuningSpace, TuningSpace, VARIANT.Ptr, NewIndex)
    get_EnumTuningSpaces(ppEnum)
      => ComCall(16, this.p, IEnumTuningSpaces.Ptr, ppEnum)
    Remove(Index)
      => ComCall(17, this.p, VARIANT, Index)
    get_MaxCount(MaxCount)
      => ComCall(18, this.p, Int32.Ptr, MaxCount)
    put_MaxCount(MaxCount)
      => ComCall(19, this.p, Int32, MaxCount)
}
struct ITuningSpace extends IDispatch {
    static IID := "{061C6E30-E622-11D2-9493-00C04F72D980}"
    get_UniqueName(Name)
      => ComCall(7, this.p, BSTR.Ptr, Name)
    put_UniqueName(Name)
      => ComCall(8, this.p, BSTR, Name)
    get_FriendlyName(Name)
      => ComCall(9, this.p, BSTR.Ptr, Name)
    put_FriendlyName(Name)
      => ComCall(10, this.p, BSTR, Name)
    get_CLSID(SpaceCLSID)
      => ComCall(11, this.p, BSTR.Ptr, SpaceCLSID)
    get_NetworkType(NetworkTypeGuid)
      => ComCall(12, this.p, BSTR.Ptr, NetworkTypeGuid)
    put_NetworkType(NetworkTypeGuid)
      => ComCall(13, this.p, BSTR, NetworkTypeGuid)
    get__NetworkType(NetworkTypeGuid)
      => ComCall(14, this.p, GUID.Ptr, NetworkTypeGuid)
    put__NetworkType(NetworkTypeGuid)
      => ComCall(15, this.p, GUID.Ptr, NetworkTypeGuid)
    CreateTuneRequest(TuneRequest)
      => ComCall(16, this.p, ITuneRequest.Ptr, TuneRequest)
    EnumCategoryGUIDs(ppEnum)
      => ComCall(17, this.p, IEnumGUID.Ptr, ppEnum)
    EnumDeviceMonikers(ppEnum)
      => ComCall(18, this.p, IEnumMoniker.Ptr, ppEnum)
    get_DefaultPreferredComponentTypes(ComponentTypes)
      => ComCall(19, this.p, IComponentTypes.Ptr, ComponentTypes)
    put_DefaultPreferredComponentTypes(NewComponentTypes)
      => ComCall(20, this.p, IComponentTypes, NewComponentTypes)
    get_FrequencyMapping(pMapping)
      => ComCall(21, this.p, BSTR.Ptr, pMapping)
    put_FrequencyMapping(Mapping)
      => ComCall(22, this.p, BSTR, Mapping)
    get_DefaultLocator(LocatorVal)
      => ComCall(23, this.p, ILocator.Ptr, LocatorVal)
    put_DefaultLocator(LocatorVal)
      => ComCall(24, this.p, ILocator, LocatorVal)
    Clone(NewTS)
      => ComCall(25, this.p, ITuningSpace.Ptr, NewTS)
}
struct IEnumTuningSpaces extends IUnknown {
    static IID := "{8B8EB248-FC2B-11D2-9D8C-00C04F72D980}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, ITuningSpace.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumTuningSpaces.Ptr, ppEnum)
}
struct IDVBTuningSpace extends ITuningSpace {
    static IID := "{ADA0B268-3B19-4E5B-ACC4-49F852BE13BA}"
    get_SystemType(SysType)
      => ComCall(26, this.p, DVBSystemType.Ptr, SysType)
    put_SystemType(SysType)
      => ComCall(27, this.p, DVBSystemType, SysType)
}
struct IDVBTuningSpace2 extends IDVBTuningSpace {
    static IID := "{843188B4-CE62-43DB-966B-8145A094E040}"
    get_NetworkID(NetworkID)
      => ComCall(28, this.p, Int32.Ptr, NetworkID)
    put_NetworkID(NetworkID)
      => ComCall(29, this.p, Int32, NetworkID)
}
struct IDVBSTuningSpace extends IDVBTuningSpace2 {
    static IID := "{CDF7BE60-D954-42FD-A972-78971958E470}"
    get_LowOscillator(LowOscillator)
      => ComCall(30, this.p, Int32.Ptr, LowOscillator)
    put_LowOscillator(LowOscillator)
      => ComCall(31, this.p, Int32, LowOscillator)
    get_HighOscillator(HighOscillator)
      => ComCall(32, this.p, Int32.Ptr, HighOscillator)
    put_HighOscillator(HighOscillator)
      => ComCall(33, this.p, Int32, HighOscillator)
    get_LNBSwitch(LNBSwitch)
      => ComCall(34, this.p, Int32.Ptr, LNBSwitch)
    put_LNBSwitch(LNBSwitch)
      => ComCall(35, this.p, Int32, LNBSwitch)
    get_InputRange(InputRange)
      => ComCall(36, this.p, BSTR.Ptr, InputRange)
    put_InputRange(InputRange)
      => ComCall(37, this.p, BSTR, InputRange)
    get_SpectralInversion(SpectralInversionVal)
      => ComCall(38, this.p, SpectralInversion.Ptr, SpectralInversionVal)
    put_SpectralInversion(SpectralInversionVal)
      => ComCall(39, this.p, SpectralInversion, SpectralInversionVal)
}
struct IAuxInTuningSpace extends ITuningSpace {
    static IID := "{E48244B8-7E17-4F76-A763-5090FF1E2F30}"
}
struct IAuxInTuningSpace2 extends IAuxInTuningSpace {
    static IID := "{B10931ED-8BFE-4AB0-9DCE-E469C29A9729}"
    get_CountryCode(CountryCodeVal)
      => ComCall(26, this.p, Int32.Ptr, CountryCodeVal)
    put_CountryCode(NewCountryCodeVal)
      => ComCall(27, this.p, Int32, NewCountryCodeVal)
}
struct IAnalogTVTuningSpace extends ITuningSpace {
    static IID := "{2A6E293C-2595-11D3-B64C-00C04F79498E}"
    get_MinChannel(MinChannelVal)
      => ComCall(26, this.p, Int32.Ptr, MinChannelVal)
    put_MinChannel(NewMinChannelVal)
      => ComCall(27, this.p, Int32, NewMinChannelVal)
    get_MaxChannel(MaxChannelVal)
      => ComCall(28, this.p, Int32.Ptr, MaxChannelVal)
    put_MaxChannel(NewMaxChannelVal)
      => ComCall(29, this.p, Int32, NewMaxChannelVal)
    get_InputType(InputTypeVal)
      => ComCall(30, this.p, TunerInputType.Ptr, InputTypeVal)
    put_InputType(NewInputTypeVal)
      => ComCall(31, this.p, TunerInputType, NewInputTypeVal)
    get_CountryCode(CountryCodeVal)
      => ComCall(32, this.p, Int32.Ptr, CountryCodeVal)
    put_CountryCode(NewCountryCodeVal)
      => ComCall(33, this.p, Int32, NewCountryCodeVal)
}
struct IATSCTuningSpace extends IAnalogTVTuningSpace {
    static IID := "{0369B4E2-45B6-11D3-B650-00C04F79498E}"
    get_MinMinorChannel(MinMinorChannelVal)
      => ComCall(34, this.p, Int32.Ptr, MinMinorChannelVal)
    put_MinMinorChannel(NewMinMinorChannelVal)
      => ComCall(35, this.p, Int32, NewMinMinorChannelVal)
    get_MaxMinorChannel(MaxMinorChannelVal)
      => ComCall(36, this.p, Int32.Ptr, MaxMinorChannelVal)
    put_MaxMinorChannel(NewMaxMinorChannelVal)
      => ComCall(37, this.p, Int32, NewMaxMinorChannelVal)
    get_MinPhysicalChannel(MinPhysicalChannelVal)
      => ComCall(38, this.p, Int32.Ptr, MinPhysicalChannelVal)
    put_MinPhysicalChannel(NewMinPhysicalChannelVal)
      => ComCall(39, this.p, Int32, NewMinPhysicalChannelVal)
    get_MaxPhysicalChannel(MaxPhysicalChannelVal)
      => ComCall(40, this.p, Int32.Ptr, MaxPhysicalChannelVal)
    put_MaxPhysicalChannel(NewMaxPhysicalChannelVal)
      => ComCall(41, this.p, Int32, NewMaxPhysicalChannelVal)
}
struct IDigitalCableTuningSpace extends IATSCTuningSpace {
    static IID := "{013F9F9C-B449-4EC7-A6D2-9D4F2FC70AE5}"
    get_MinMajorChannel(MinMajorChannelVal)
      => ComCall(42, this.p, Int32.Ptr, MinMajorChannelVal)
    put_MinMajorChannel(NewMinMajorChannelVal)
      => ComCall(43, this.p, Int32, NewMinMajorChannelVal)
    get_MaxMajorChannel(MaxMajorChannelVal)
      => ComCall(44, this.p, Int32.Ptr, MaxMajorChannelVal)
    put_MaxMajorChannel(NewMaxMajorChannelVal)
      => ComCall(45, this.p, Int32, NewMaxMajorChannelVal)
    get_MinSourceID(MinSourceIDVal)
      => ComCall(46, this.p, Int32.Ptr, MinSourceIDVal)
    put_MinSourceID(NewMinSourceIDVal)
      => ComCall(47, this.p, Int32, NewMinSourceIDVal)
    get_MaxSourceID(MaxSourceIDVal)
      => ComCall(48, this.p, Int32.Ptr, MaxSourceIDVal)
    put_MaxSourceID(NewMaxSourceIDVal)
      => ComCall(49, this.p, Int32, NewMaxSourceIDVal)
}
struct IAnalogRadioTuningSpace extends ITuningSpace {
    static IID := "{2A6E293B-2595-11D3-B64C-00C04F79498E}"
    get_MinFrequency(MinFrequencyVal)
      => ComCall(26, this.p, Int32.Ptr, MinFrequencyVal)
    put_MinFrequency(NewMinFrequencyVal)
      => ComCall(27, this.p, Int32, NewMinFrequencyVal)
    get_MaxFrequency(MaxFrequencyVal)
      => ComCall(28, this.p, Int32.Ptr, MaxFrequencyVal)
    put_MaxFrequency(NewMaxFrequencyVal)
      => ComCall(29, this.p, Int32, NewMaxFrequencyVal)
    get_Step(StepVal)
      => ComCall(30, this.p, Int32.Ptr, StepVal)
    put_Step(NewStepVal)
      => ComCall(31, this.p, Int32, NewStepVal)
}
struct IAnalogRadioTuningSpace2 extends IAnalogRadioTuningSpace {
    static IID := "{39DD45DA-2DA8-46BA-8A8A-87E2B73D983A}"
    get_CountryCode(CountryCodeVal)
      => ComCall(32, this.p, Int32.Ptr, CountryCodeVal)
    put_CountryCode(NewCountryCodeVal)
      => ComCall(33, this.p, Int32, NewCountryCodeVal)
}
struct ITuneRequest extends IDispatch {
    static IID := "{07DDC146-FC3D-11D2-9D8C-00C04F72D980}"
    get_TuningSpace(TuningSpace)
      => ComCall(7, this.p, ITuningSpace.Ptr, TuningSpace)
    get_Components(Components)
      => ComCall(8, this.p, IComponents.Ptr, Components)
    Clone(NewTuneRequest)
      => ComCall(9, this.p, ITuneRequest.Ptr, NewTuneRequest)
    get_Locator(Locator)
      => ComCall(10, this.p, ILocator.Ptr, Locator)
    put_Locator(Locator)
      => ComCall(11, this.p, ILocator, Locator)
}
struct IChannelIDTuneRequest extends ITuneRequest {
    static IID := "{156EFF60-86F4-4E28-89FC-109799FD57EE}"
    get_ChannelID(ChannelID)
      => ComCall(12, this.p, BSTR.Ptr, ChannelID)
    put_ChannelID(ChannelID)
      => ComCall(13, this.p, BSTR, ChannelID)
}
struct IChannelTuneRequest extends ITuneRequest {
    static IID := "{0369B4E0-45B6-11D3-B650-00C04F79498E}"
    get_Channel(Channel)
      => ComCall(12, this.p, Int32.Ptr, Channel)
    put_Channel(Channel)
      => ComCall(13, this.p, Int32, Channel)
}
struct IATSCChannelTuneRequest extends IChannelTuneRequest {
    static IID := "{0369B4E1-45B6-11D3-B650-00C04F79498E}"
    get_MinorChannel(MinorChannel)
      => ComCall(14, this.p, Int32.Ptr, MinorChannel)
    put_MinorChannel(MinorChannel)
      => ComCall(15, this.p, Int32, MinorChannel)
}
struct IDigitalCableTuneRequest extends IATSCChannelTuneRequest {
    static IID := "{BAD7753B-6B37-4810-AE57-3CE0C4A9E6CB}"
    get_MajorChannel(pMajorChannel)
      => ComCall(16, this.p, Int32.Ptr, pMajorChannel)
    put_MajorChannel(MajorChannel)
      => ComCall(17, this.p, Int32, MajorChannel)
    get_SourceID(pSourceID)
      => ComCall(18, this.p, Int32.Ptr, pSourceID)
    put_SourceID(SourceID)
      => ComCall(19, this.p, Int32, SourceID)
}
struct IDVBTuneRequest extends ITuneRequest {
    static IID := "{0D6F567E-A636-42BB-83BA-CE4C1704AFA2}"
    get_ONID(ONID)
      => ComCall(12, this.p, Int32.Ptr, ONID)
    put_ONID(ONID)
      => ComCall(13, this.p, Int32, ONID)
    get_TSID(TSID)
      => ComCall(14, this.p, Int32.Ptr, TSID)
    put_TSID(TSID)
      => ComCall(15, this.p, Int32, TSID)
    get_SID(SID)
      => ComCall(16, this.p, Int32.Ptr, SID)
    put_SID(SID)
      => ComCall(17, this.p, Int32, SID)
}
struct IMPEG2TuneRequest extends ITuneRequest {
    static IID := "{EB7D987F-8A01-42AD-B8AE-574DEEE44D1A}"
    get_TSID(TSID)
      => ComCall(12, this.p, Int32.Ptr, TSID)
    put_TSID(TSID)
      => ComCall(13, this.p, Int32, TSID)
    get_ProgNo(ProgNo)
      => ComCall(14, this.p, Int32.Ptr, ProgNo)
    put_ProgNo(ProgNo)
      => ComCall(15, this.p, Int32, ProgNo)
}
struct IMPEG2TuneRequestFactory extends IDispatch {
    static IID := "{14E11ABD-EE37-4893-9EA1-6964DE933E39}"
    CreateTuneRequest(TuningSpace, TuneRequest)
      => ComCall(7, this.p, ITuningSpace, TuningSpace, IMPEG2TuneRequest.Ptr, TuneRequest)
}
struct IMPEG2TuneRequestSupport extends IUnknown {
    static IID := "{1B9D5FC3-5BBC-4B6C-BB18-B9D10E3EEEBF}"
}
struct ITunerCap extends IUnknown {
    static IID := "{E60DFA45-8D56-4E65-A8AB-D6BE9412C249}"
    get_SupportedNetworkTypes(ulcNetworkTypesMax, pulcNetworkTypes, pguidNetworkTypes)
      => ComCall(3, this.p, UInt32, ulcNetworkTypesMax, UInt32.Ptr, pulcNetworkTypes, GUID.Ptr, pguidNetworkTypes)
    get_SupportedVideoFormats(pulAMTunerModeType, pulAnalogVideoStandard)
      => ComCall(4, this.p, UInt32.Ptr, pulAMTunerModeType, UInt32.Ptr, pulAnalogVideoStandard)
    get_AuxInputCount(pulCompositeCount, pulSvideoCount)
      => ComCall(5, this.p, UInt32.Ptr, pulCompositeCount, UInt32.Ptr, pulSvideoCount)
}
struct ITunerCapEx extends IUnknown {
    static IID := "{ED3E0C66-18C8-4EA6-9300-F6841FDD35DC}"
    get_Has608_708Caption(pbHasCaption)
      => ComCall(3, this.p, VARIANT_BOOL.Ptr, pbHasCaption)
}
struct ITuner extends IUnknown {
    static IID := "{28C52640-018A-11D3-9D8E-00C04F72D980}"
    get_TuningSpace(TuningSpace)
      => ComCall(3, this.p, ITuningSpace.Ptr, TuningSpace)
    put_TuningSpace(TuningSpace)
      => ComCall(4, this.p, ITuningSpace, TuningSpace)
    EnumTuningSpaces(ppEnum)
      => ComCall(5, this.p, IEnumTuningSpaces.Ptr, ppEnum)
    get_TuneRequest(TuneRequest)
      => ComCall(6, this.p, ITuneRequest.Ptr, TuneRequest)
    put_TuneRequest(TuneRequest)
      => ComCall(7, this.p, ITuneRequest, TuneRequest)
    Validate(TuneRequest)
      => ComCall(8, this.p, ITuneRequest, TuneRequest)
    get_PreferredComponentTypes(ComponentTypes)
      => ComCall(9, this.p, IComponentTypes.Ptr, ComponentTypes)
    put_PreferredComponentTypes(ComponentTypes)
      => ComCall(10, this.p, IComponentTypes, ComponentTypes)
    get_SignalStrength(Strength)
      => ComCall(11, this.p, Int32.Ptr, Strength)
    TriggerSignalEvents(Interval)
      => ComCall(12, this.p, Int32, Interval)
}
struct IScanningTuner extends ITuner {
    static IID := "{1DFD0A5C-0284-11D3-9D8E-00C04F72D980}"
    SeekUp()
      => ComCall(13, this.p)
    SeekDown()
      => ComCall(14, this.p)
    ScanUp(MillisecondsPause)
      => ComCall(15, this.p, Int32, MillisecondsPause)
    ScanDown(MillisecondsPause)
      => ComCall(16, this.p, Int32, MillisecondsPause)
    AutoProgram()
      => ComCall(17, this.p)
}
struct IScanningTunerEx extends IScanningTuner {
    static IID := "{04BBD195-0E2D-4593-9BD5-4F908BC33CF5}"
    GetCurrentLocator(pILocator)
      => ComCall(18, this.p, ILocator.Ptr, pILocator)
    PerformExhaustiveScan(dwLowerFreq, dwHigherFreq, bFineTune, hEvent)
      => ComCall(19, this.p, Int32, dwLowerFreq, Int32, dwHigherFreq, VARIANT_BOOL, bFineTune, IntPtr, hEvent)
    TerminateCurrentScan(pcurrentFreq)
      => ComCall(20, this.p, Int32.Ptr, pcurrentFreq)
    ResumeCurrentScan(hEvent)
      => ComCall(21, this.p, IntPtr, hEvent)
    GetTunerScanningCapability(HardwareAssistedScanning, NumStandardsSupported, BroadcastStandards)
      => ComCall(22, this.p, Int32.Ptr, HardwareAssistedScanning, Int32.Ptr, NumStandardsSupported, GUID.Ptr, BroadcastStandards)
    GetTunerStatus(SecondsLeft, CurrentLockType, AutoDetect, CurrentFreq)
      => ComCall(23, this.p, Int32.Ptr, SecondsLeft, Int32.Ptr, CurrentLockType, Int32.Ptr, AutoDetect, Int32.Ptr, CurrentFreq)
    GetCurrentTunerStandardCapability(CurrentBroadcastStandard, SettlingTime, TvStandardsSupported)
      => ComCall(24, this.p, GUID, CurrentBroadcastStandard, Int32.Ptr, SettlingTime, Int32.Ptr, TvStandardsSupported)
    SetScanSignalTypeFilter(ScanModulationTypes, AnalogVideoStandard)
      => ComCall(25, this.p, Int32, ScanModulationTypes, Int32, AnalogVideoStandard)
}
struct IComponentType extends IDispatch {
    static IID := "{6A340DC0-0311-11D3-9D8E-00C04F72D980}"
    get_Category(Category)
      => ComCall(7, this.p, ComponentCategory.Ptr, Category)
    put_Category(Category)
      => ComCall(8, this.p, ComponentCategory, Category)
    get_MediaMajorType(MediaMajorType)
      => ComCall(9, this.p, BSTR.Ptr, MediaMajorType)
    put_MediaMajorType(MediaMajorType)
      => ComCall(10, this.p, BSTR, MediaMajorType)
    get__MediaMajorType(MediaMajorTypeGuid)
      => ComCall(11, this.p, GUID.Ptr, MediaMajorTypeGuid)
    put__MediaMajorType(MediaMajorTypeGuid)
      => ComCall(12, this.p, GUID.Ptr, MediaMajorTypeGuid)
    get_MediaSubType(MediaSubType)
      => ComCall(13, this.p, BSTR.Ptr, MediaSubType)
    put_MediaSubType(MediaSubType)
      => ComCall(14, this.p, BSTR, MediaSubType)
    get__MediaSubType(MediaSubTypeGuid)
      => ComCall(15, this.p, GUID.Ptr, MediaSubTypeGuid)
    put__MediaSubType(MediaSubTypeGuid)
      => ComCall(16, this.p, GUID.Ptr, MediaSubTypeGuid)
    get_MediaFormatType(MediaFormatType)
      => ComCall(17, this.p, BSTR.Ptr, MediaFormatType)
    put_MediaFormatType(MediaFormatType)
      => ComCall(18, this.p, BSTR, MediaFormatType)
    get__MediaFormatType(MediaFormatTypeGuid)
      => ComCall(19, this.p, GUID.Ptr, MediaFormatTypeGuid)
    put__MediaFormatType(MediaFormatTypeGuid)
      => ComCall(20, this.p, GUID.Ptr, MediaFormatTypeGuid)
    get_MediaType(MediaType)
      => ComCall(21, this.p, AM_MEDIA_TYPE.Ptr, MediaType)
    put_MediaType(MediaType)
      => ComCall(22, this.p, AM_MEDIA_TYPE.Ptr, MediaType)
    Clone(NewCT)
      => ComCall(23, this.p, IComponentType.Ptr, NewCT)
}
struct ILanguageComponentType extends IComponentType {
    static IID := "{B874C8BA-0FA2-11D3-9D8E-00C04F72D980}"
    get_LangID(LangID)
      => ComCall(24, this.p, Int32.Ptr, LangID)
    put_LangID(LangID)
      => ComCall(25, this.p, Int32, LangID)
}
struct IMPEG2ComponentType extends ILanguageComponentType {
    static IID := "{2C073D84-B51C-48C9-AA9F-68971E1F6E38}"
    get_StreamType(MP2StreamType)
      => ComCall(26, this.p, MPEG2StreamType.Ptr, MP2StreamType)
    put_StreamType(MP2StreamType)
      => ComCall(27, this.p, MPEG2StreamType, MP2StreamType)
}
struct IATSCComponentType extends IMPEG2ComponentType {
    static IID := "{FC189E4D-7BD4-4125-B3B3-3A76A332CC96}"
    get_Flags(Flags)
      => ComCall(28, this.p, Int32.Ptr, Flags)
    put_Flags(flags)
      => ComCall(29, this.p, Int32, flags)
}
struct IEnumComponentTypes extends IUnknown {
    static IID := "{8A674B4A-1F63-11D3-B64C-00C04F79498E}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, IComponentType.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumComponentTypes.Ptr, ppEnum)
}
struct IComponentTypes extends IDispatch {
    static IID := "{0DC13D4A-0313-11D3-9D8E-00C04F72D980}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(ppNewEnum)
      => ComCall(8, this.p, IEnumVARIANT.Ptr, ppNewEnum)
    EnumComponentTypes(ppNewEnum)
      => ComCall(9, this.p, IEnumComponentTypes.Ptr, ppNewEnum)
    get_Item(Index, ComponentType)
      => ComCall(10, this.p, VARIANT, Index, IComponentType.Ptr, ComponentType)
    put_Item(Index, ComponentType)
      => ComCall(11, this.p, VARIANT, Index, IComponentType, ComponentType)
    Add(ComponentType, NewIndex)
      => ComCall(12, this.p, IComponentType, ComponentType, VARIANT.Ptr, NewIndex)
    Remove(Index)
      => ComCall(13, this.p, VARIANT, Index)
    Clone(NewList)
      => ComCall(14, this.p, IComponentTypes.Ptr, NewList)
}
struct IComponent extends IDispatch {
    static IID := "{1A5576FC-0E19-11D3-9D8E-00C04F72D980}"
    get_Type(CT)
      => ComCall(7, this.p, IComponentType.Ptr, CT)
    put_Type(CT)
      => ComCall(8, this.p, IComponentType, CT)
    get_DescLangID(LangID)
      => ComCall(9, this.p, Int32.Ptr, LangID)
    put_DescLangID(LangID)
      => ComCall(10, this.p, Int32, LangID)
    get_Status(Status)
      => ComCall(11, this.p, ComponentStatus.Ptr, Status)
    put_Status(Status)
      => ComCall(12, this.p, ComponentStatus, Status)
    get_Description(Description)
      => ComCall(13, this.p, BSTR.Ptr, Description)
    put_Description(Description)
      => ComCall(14, this.p, BSTR, Description)
    Clone(NewComponent)
      => ComCall(15, this.p, IComponent.Ptr, NewComponent)
}
struct IAnalogAudioComponentType extends IComponentType {
    static IID := "{2CFEB2A8-1787-4A24-A941-C6EAEC39C842}"
    get_AnalogAudioMode(Mode)
      => ComCall(24, this.p, TVAudioMode.Ptr, Mode)
    put_AnalogAudioMode(Mode)
      => ComCall(25, this.p, TVAudioMode, Mode)
}
struct IMPEG2Component extends IComponent {
    static IID := "{1493E353-1EB6-473C-802D-8E6B8EC9D2A9}"
    get_PID(PID)
      => ComCall(16, this.p, Int32.Ptr, PID)
    put_PID(PID)
      => ComCall(17, this.p, Int32, PID)
    get_PCRPID(PCRPID)
      => ComCall(18, this.p, Int32.Ptr, PCRPID)
    put_PCRPID(PCRPID)
      => ComCall(19, this.p, Int32, PCRPID)
    get_ProgramNumber(ProgramNumber)
      => ComCall(20, this.p, Int32.Ptr, ProgramNumber)
    put_ProgramNumber(ProgramNumber)
      => ComCall(21, this.p, Int32, ProgramNumber)
}
struct IEnumComponents extends IUnknown {
    static IID := "{2A6E2939-2595-11D3-B64C-00C04F79498E}"
    Next(rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, rgelt.Length, IComponent.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppEnum)
      => ComCall(6, this.p, IEnumComponents.Ptr, ppEnum)
}
struct IComponents extends IDispatch {
    static IID := "{39A48091-FFFE-4182-A161-3FF802640E26}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(ppNewEnum)
      => ComCall(8, this.p, IEnumVARIANT.Ptr, ppNewEnum)
    EnumComponents(ppNewEnum)
      => ComCall(9, this.p, IEnumComponents.Ptr, ppNewEnum)
    get_Item(Index, ppComponent)
      => ComCall(10, this.p, VARIANT, Index, IComponent.Ptr, ppComponent)
    Add(Component, NewIndex)
      => ComCall(11, this.p, IComponent, Component, VARIANT.Ptr, NewIndex)
    Remove(Index)
      => ComCall(12, this.p, VARIANT, Index)
    Clone(NewList)
      => ComCall(13, this.p, IComponents.Ptr, NewList)
    put_Item(Index, ppComponent)
      => ComCall(14, this.p, VARIANT, Index, IComponent, ppComponent)
}
struct IComponentsOld extends IDispatch {
    static IID := "{FCD01846-0E19-11D3-9D8E-00C04F72D980}"
    get_Count(Count)
      => ComCall(7, this.p, Int32.Ptr, Count)
    get__NewEnum(ppNewEnum)
      => ComCall(8, this.p, IEnumVARIANT.Ptr, ppNewEnum)
    EnumComponents(ppNewEnum)
      => ComCall(9, this.p, IEnumComponents.Ptr, ppNewEnum)
    get_Item(Index, ppComponent)
      => ComCall(10, this.p, VARIANT, Index, IComponent.Ptr, ppComponent)
    Add(Component, NewIndex)
      => ComCall(11, this.p, IComponent, Component, VARIANT.Ptr, NewIndex)
    Remove(Index)
      => ComCall(12, this.p, VARIANT, Index)
    Clone(NewList)
      => ComCall(13, this.p, IComponents.Ptr, NewList)
}
struct ILocator extends IDispatch {
    static IID := "{286D7F89-760C-4F89-80C4-66841D2507AA}"
    get_CarrierFrequency(Frequency)
      => ComCall(7, this.p, Int32.Ptr, Frequency)
    put_CarrierFrequency(Frequency)
      => ComCall(8, this.p, Int32, Frequency)
    get_InnerFEC(FEC)
      => ComCall(9, this.p, FECMethod.Ptr, FEC)
    put_InnerFEC(FEC)
      => ComCall(10, this.p, FECMethod, FEC)
    get_InnerFECRate(FEC)
      => ComCall(11, this.p, BinaryConvolutionCodeRate.Ptr, FEC)
    put_InnerFECRate(FEC)
      => ComCall(12, this.p, BinaryConvolutionCodeRate, FEC)
    get_OuterFEC(FEC)
      => ComCall(13, this.p, FECMethod.Ptr, FEC)
    put_OuterFEC(FEC)
      => ComCall(14, this.p, FECMethod, FEC)
    get_OuterFECRate(FEC)
      => ComCall(15, this.p, BinaryConvolutionCodeRate.Ptr, FEC)
    put_OuterFECRate(FEC)
      => ComCall(16, this.p, BinaryConvolutionCodeRate, FEC)
    get_Modulation(Modulation)
      => ComCall(17, this.p, ModulationType.Ptr, Modulation)
    put_Modulation(Modulation)
      => ComCall(18, this.p, ModulationType, Modulation)
    get_SymbolRate(Rate)
      => ComCall(19, this.p, Int32.Ptr, Rate)
    put_SymbolRate(Rate)
      => ComCall(20, this.p, Int32, Rate)
    Clone(NewLocator)
      => ComCall(21, this.p, ILocator.Ptr, NewLocator)
}
struct IAnalogLocator extends ILocator {
    static IID := "{34D1F26B-E339-430D-ABCE-738CB48984DC}"
    get_VideoStandard(AVS)
      => ComCall(22, this.p, AnalogVideoStandard.Ptr, AVS)
    put_VideoStandard(AVS)
      => ComCall(23, this.p, AnalogVideoStandard, AVS)
}
struct IDigitalLocator extends ILocator {
    static IID := "{19B595D8-839A-47F0-96DF-4F194F3C768C}"
}
struct IATSCLocator extends IDigitalLocator {
    static IID := "{BF8D986F-8C2B-4131-94D7-4D3D9FCC21EF}"
    get_PhysicalChannel(PhysicalChannel)
      => ComCall(22, this.p, Int32.Ptr, PhysicalChannel)
    put_PhysicalChannel(PhysicalChannel)
      => ComCall(23, this.p, Int32, PhysicalChannel)
    get_TSID(TSID)
      => ComCall(24, this.p, Int32.Ptr, TSID)
    put_TSID(TSID)
      => ComCall(25, this.p, Int32, TSID)
}
struct IATSCLocator2 extends IATSCLocator {
    static IID := "{612AA885-66CF-4090-BA0A-566F5312E4CA}"
    get_ProgramNumber(ProgramNumber)
      => ComCall(26, this.p, Int32.Ptr, ProgramNumber)
    put_ProgramNumber(ProgramNumber)
      => ComCall(27, this.p, Int32, ProgramNumber)
}
struct IDigitalCableLocator extends IATSCLocator2 {
    static IID := "{48F66A11-171A-419A-9525-BEEECD51584C}"
}
struct IDVBTLocator extends IDigitalLocator {
    static IID := "{8664DA16-DDA2-42AC-926A-C18F9127C302}"
    get_Bandwidth(BandWidthVal)
      => ComCall(22, this.p, Int32.Ptr, BandWidthVal)
    put_Bandwidth(BandwidthVal)
      => ComCall(23, this.p, Int32, BandwidthVal)
    get_LPInnerFEC(FEC)
      => ComCall(24, this.p, FECMethod.Ptr, FEC)
    put_LPInnerFEC(FEC)
      => ComCall(25, this.p, FECMethod, FEC)
    get_LPInnerFECRate(FEC)
      => ComCall(26, this.p, BinaryConvolutionCodeRate.Ptr, FEC)
    put_LPInnerFECRate(FEC)
      => ComCall(27, this.p, BinaryConvolutionCodeRate, FEC)
    get_HAlpha(Alpha)
      => ComCall(28, this.p, HierarchyAlpha.Ptr, Alpha)
    put_HAlpha(Alpha)
      => ComCall(29, this.p, HierarchyAlpha, Alpha)
    get_Guard(GI)
      => ComCall(30, this.p, GuardInterval.Ptr, GI)
    put_Guard(GI)
      => ComCall(31, this.p, GuardInterval, GI)
    get_Mode(mode)
      => ComCall(32, this.p, TransmissionMode.Ptr, mode)
    put_Mode(mode)
      => ComCall(33, this.p, TransmissionMode, mode)
    get_OtherFrequencyInUse(OtherFrequencyInUseVal)
      => ComCall(34, this.p, VARIANT_BOOL.Ptr, OtherFrequencyInUseVal)
    put_OtherFrequencyInUse(OtherFrequencyInUseVal)
      => ComCall(35, this.p, VARIANT_BOOL, OtherFrequencyInUseVal)
}
struct IDVBTLocator2 extends IDVBTLocator {
    static IID := "{448A2EDF-AE95-4B43-A3CC-747843C453D4}"
    get_PhysicalLayerPipeId(PhysicalLayerPipeIdVal)
      => ComCall(36, this.p, Int32.Ptr, PhysicalLayerPipeIdVal)
    put_PhysicalLayerPipeId(PhysicalLayerPipeIdVal)
      => ComCall(37, this.p, Int32, PhysicalLayerPipeIdVal)
}
struct IDVBSLocator extends IDigitalLocator {
    static IID := "{3D7C353C-0D04-45F1-A742-F97CC1188DC8}"
    get_SignalPolarisation(PolarisationVal)
      => ComCall(22, this.p, Polarisation.Ptr, PolarisationVal)
    put_SignalPolarisation(PolarisationVal)
      => ComCall(23, this.p, Polarisation, PolarisationVal)
    get_WestPosition(WestLongitude)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, WestLongitude)
    put_WestPosition(WestLongitude)
      => ComCall(25, this.p, VARIANT_BOOL, WestLongitude)
    get_OrbitalPosition(longitude)
      => ComCall(26, this.p, Int32.Ptr, longitude)
    put_OrbitalPosition(longitude)
      => ComCall(27, this.p, Int32, longitude)
    get_Azimuth(Azimuth)
      => ComCall(28, this.p, Int32.Ptr, Azimuth)
    put_Azimuth(Azimuth)
      => ComCall(29, this.p, Int32, Azimuth)
    get_Elevation(Elevation)
      => ComCall(30, this.p, Int32.Ptr, Elevation)
    put_Elevation(Elevation)
      => ComCall(31, this.p, Int32, Elevation)
}
struct IDVBSLocator2 extends IDVBSLocator {
    static IID := "{6044634A-1733-4F99-B982-5FB12AFCE4F0}"
    get_DiseqLNBSource(DiseqLNBSourceVal)
      => ComCall(32, this.p, LNB_Source.Ptr, DiseqLNBSourceVal)
    put_DiseqLNBSource(DiseqLNBSourceVal)
      => ComCall(33, this.p, LNB_Source, DiseqLNBSourceVal)
    get_LocalOscillatorOverrideLow(LocalOscillatorOverrideLowVal)
      => ComCall(34, this.p, Int32.Ptr, LocalOscillatorOverrideLowVal)
    put_LocalOscillatorOverrideLow(LocalOscillatorOverrideLowVal)
      => ComCall(35, this.p, Int32, LocalOscillatorOverrideLowVal)
    get_LocalOscillatorOverrideHigh(LocalOscillatorOverrideHighVal)
      => ComCall(36, this.p, Int32.Ptr, LocalOscillatorOverrideHighVal)
    put_LocalOscillatorOverrideHigh(LocalOscillatorOverrideHighVal)
      => ComCall(37, this.p, Int32, LocalOscillatorOverrideHighVal)
    get_LocalLNBSwitchOverride(LocalLNBSwitchOverrideVal)
      => ComCall(38, this.p, Int32.Ptr, LocalLNBSwitchOverrideVal)
    put_LocalLNBSwitchOverride(LocalLNBSwitchOverrideVal)
      => ComCall(39, this.p, Int32, LocalLNBSwitchOverrideVal)
    get_LocalSpectralInversionOverride(LocalSpectralInversionOverrideVal)
      => ComCall(40, this.p, SpectralInversion.Ptr, LocalSpectralInversionOverrideVal)
    put_LocalSpectralInversionOverride(LocalSpectralInversionOverrideVal)
      => ComCall(41, this.p, SpectralInversion, LocalSpectralInversionOverrideVal)
    get_SignalRollOff(RollOffVal)
      => ComCall(42, this.p, RollOff.Ptr, RollOffVal)
    put_SignalRollOff(RollOffVal)
      => ComCall(43, this.p, RollOff, RollOffVal)
    get_SignalPilot(PilotVal)
      => ComCall(44, this.p, Pilot.Ptr, PilotVal)
    put_SignalPilot(PilotVal)
      => ComCall(45, this.p, Pilot, PilotVal)
}
struct IDVBCLocator extends IDigitalLocator {
    static IID := "{6E42F36E-1DD2-43C4-9F78-69D25AE39034}"
}
struct IISDBSLocator extends IDVBSLocator {
    static IID := "{C9897087-E29C-473F-9E4B-7072123DEA14}"
}
struct IESOpenMmiEvent extends IESEvent {
    static IID := "{BA4B6526-1A35-4635-8B56-3EC612746A8C}"
    GetDialogNumber(pDialogRequest, pDialogNumber)
      => ComCall(8, this.p, UInt32.Ptr, pDialogRequest, UInt32.Ptr, pDialogNumber)
    GetDialogType(guidDialogType)
      => ComCall(9, this.p, GUID.Ptr, guidDialogType)
    GetDialogData(pbData)
      => ComCall(10, this.p, SAFEARRAY.Ptr.Ptr, pbData)
    GetDialogStringData(pbstrBaseUrl, pbstrData)
      => ComCall(11, this.p, BSTR.Ptr, pbstrBaseUrl, BSTR.Ptr, pbstrData)
}
struct IESCloseMmiEvent extends IESEvent {
    static IID := "{6B80E96F-55E2-45AA-B754-0C23C8E7D5C1}"
    GetDialogNumber(pDialogNumber)
      => ComCall(8, this.p, UInt32.Ptr, pDialogNumber)
}
struct IESValueUpdatedEvent extends IESEvent {
    static IID := "{8A24C46E-BB63-4664-8602-5D9C718C146D}"
    GetValueNames(pbstrNames)
      => ComCall(8, this.p, SAFEARRAY.Ptr.Ptr, pbstrNames)
}
struct IESRequestTunerEvent extends IESEvent {
    static IID := "{54C7A5E8-C3BB-4F51-AF14-E0E2C0E34C6D}"
    GetPriority(pbyPriority)
      => ComCall(8, this.p, UInt8.Ptr, pbyPriority)
    GetReason(pbyReason)
      => ComCall(9, this.p, UInt8.Ptr, pbyReason)
    GetConsequences(pbyConsequences)
      => ComCall(10, this.p, UInt8.Ptr, pbyConsequences)
    GetEstimatedTime(pdwEstimatedTime)
      => ComCall(11, this.p, UInt32.Ptr, pdwEstimatedTime)
}
struct IESIsdbCasResponseEvent extends IESEvent {
    static IID := "{2017CB03-DC0F-4C24-83CA-36307B2CD19F}"
    GetRequestId(pRequestId)
      => ComCall(8, this.p, UInt32.Ptr, pRequestId)
    GetStatus(pStatus)
      => ComCall(9, this.p, UInt32.Ptr, pStatus)
    GetDataLength(pRequestLength)
      => ComCall(10, this.p, UInt32.Ptr, pRequestLength)
    GetResponseData(pbData)
      => ComCall(11, this.p, SAFEARRAY.Ptr.Ptr, pbData)
}
struct IGpnvsCommonBase extends IUnknown {
    static IID := "{907E0B5C-E42D-4F04-91F0-26F401F36907}"
    GetValueUpdateName(pbstrName)
      => ComCall(3, this.p, BSTR.Ptr, pbstrName)
}
struct IESEventFactory extends IUnknown {
    static IID := "{506A09B8-7F86-4E04-AC05-3303BFE8FC49}"
    CreateESEvent(pServiceProvider, dwEventId, guidEventType, pEventData, bstrBaseUrl, pInitContext, ppESEvent)
      => ComCall(3, this.p, IUnknown, pServiceProvider, UInt32, dwEventId, GUID, guidEventType, UInt32, pEventData.Length, UInt8.Ptr, pEventData, BSTR, bstrBaseUrl, IUnknown, pInitContext, IESEvent.Ptr, ppESEvent)
}
struct IESLicenseRenewalResultEvent extends IESEvent {
    static IID := "{D5A48EF5-A81B-4DF0-ACAA-5E35E7EA45D4}"
    GetCallersId(pdwCallersId)
      => ComCall(8, this.p, UInt32.Ptr, pdwCallersId)
    GetFileName(pbstrFilename)
      => ComCall(9, this.p, BSTR.Ptr, pbstrFilename)
    IsRenewalSuccessful(pfRenewalSuccessful)
      => ComCall(10, this.p, BOOL.Ptr, pfRenewalSuccessful)
    IsCheckEntitlementCallRequired(pfCheckEntTokenCallNeeded)
      => ComCall(11, this.p, BOOL.Ptr, pfCheckEntTokenCallNeeded)
    GetDescrambledStatus(pDescrambledStatus)
      => ComCall(12, this.p, UInt32.Ptr, pDescrambledStatus)
    GetRenewalResultCode(pdwRenewalResultCode)
      => ComCall(13, this.p, UInt32.Ptr, pdwRenewalResultCode)
    GetCASFailureCode(pdwCASFailureCode)
      => ComCall(14, this.p, UInt32.Ptr, pdwCASFailureCode)
    GetRenewalHResult(phr)
      => ComCall(15, this.p, HRESULT.Ptr, phr)
    GetEntitlementTokenLength(pdwLength)
      => ComCall(16, this.p, UInt32.Ptr, pdwLength)
    GetEntitlementToken(pbData)
      => ComCall(17, this.p, SAFEARRAY.Ptr.Ptr, pbData)
    GetExpiryDate(pqwExpiryDate)
      => ComCall(18, this.p, Int64.Ptr, pqwExpiryDate)
}
struct IESFileExpiryDateEvent extends IESEvent {
    static IID := "{BA9EDCB6-4D36-4CFE-8C56-87A6B0CA48E1}"
    GetTunerId(pguidTunerId)
      => ComCall(8, this.p, GUID.Ptr, pguidTunerId)
    GetExpiryDate(pqwExpiryDate)
      => ComCall(9, this.p, Int64.Ptr, pqwExpiryDate)
    GetFinalExpiryDate(pqwExpiryDate)
      => ComCall(10, this.p, Int64.Ptr, pqwExpiryDate)
    GetMaxRenewalCount(dwMaxRenewalCount)
      => ComCall(11, this.p, UInt32.Ptr, dwMaxRenewalCount)
    IsEntitlementTokenPresent(pfEntTokenPresent)
      => ComCall(12, this.p, BOOL.Ptr, pfEntTokenPresent)
    DoesExpireAfterFirstUse(pfExpireAfterFirstUse)
      => ComCall(13, this.p, BOOL.Ptr, pfExpireAfterFirstUse)
}
struct IESEventService extends IUnknown {
    static IID := "{ED89A619-4C06-4B2F-99EB-C7669B13047C}"
    FireESEvent(pESEvent?)
      => ComCall(3, this.p, IESEvent, pESEvent?)
}
struct IESEventServiceConfiguration extends IUnknown {
    static IID := "{33B9DAAE-9309-491D-A051-BCAD2A70CD66}"
    SetParent(pEventService?)
      => ComCall(3, this.p, IESEventService, pEventService?)
    RemoveParent()
      => ComCall(4, this.p)
    SetOwner(pESEvents?)
      => ComCall(5, this.p, IESEvents, pESEvents?)
    RemoveOwner()
      => ComCall(6, this.p)
    SetGraph(pGraph?)
      => ComCall(7, this.p, IFilterGraph, pGraph?)
    RemoveGraph(pGraph?)
      => ComCall(8, this.p, IFilterGraph, pGraph?)
}
struct IRegisterTuner extends IUnknown {
    static IID := "{359B3901-572C-4854-BB49-CDEF66606A25}"
    Register(pTuner, pGraph)
      => ComCall(3, this.p, ITuner, pTuner, IGraphBuilder, pGraph)
    Unregister()
      => ComCall(4, this.p)
}
struct IBDAComparable extends IUnknown {
    static IID := "{B34505E0-2F0E-497B-80BC-D43F3B24ED7F}"
    CompareExact(CompareTo, Result)
      => ComCall(3, this.p, IDispatch, CompareTo, Int32.Ptr, Result)
    CompareEquivalent(CompareTo, dwFlags, Result)
      => ComCall(4, this.p, IDispatch, CompareTo, UInt32, dwFlags, Int32.Ptr, Result)
    HashExact(Result)
      => ComCall(5, this.p, Int64.Ptr, Result)
    HashExactIncremental(PartialResult, Result)
      => ComCall(6, this.p, Int64, PartialResult, Int64.Ptr, Result)
    HashEquivalent(dwFlags, Result)
      => ComCall(7, this.p, UInt32, dwFlags, Int64.Ptr, Result)
    HashEquivalentIncremental(PartialResult, dwFlags, Result)
      => ComCall(8, this.p, Int64, PartialResult, UInt32, dwFlags, Int64.Ptr, Result)
}
struct IPersistTuneXml extends IPersist {
    static IID := "{0754CD31-8D15-47A9-8215-D20064157244}"
    InitNew()
      => ComCall(4, this.p)
    Load(varValue)
      => ComCall(5, this.p, VARIANT, varValue)
    Save(pvarFragment)
      => ComCall(6, this.p, VARIANT.Ptr, pvarFragment)
}
struct IPersistTuneXmlUtility extends IUnknown {
    static IID := "{990237AE-AC11-4614-BE8F-DD217A4CB4CB}"
    Deserialize(varValue, ppObject)
      => ComCall(3, this.p, VARIANT, varValue, IUnknown.Ptr, ppObject)
}
struct IPersistTuneXmlUtility2 extends IPersistTuneXmlUtility {
    static IID := "{992E165F-EA24-4B2F-9A1D-009D92120451}"
    Serialize(piTuneRequest, pString)
      => ComCall(4, this.p, ITuneRequest, piTuneRequest, BSTR.Ptr, pString)
}
struct IBDACreateTuneRequestEx extends IUnknown {
    static IID := "{C0A4A1D4-2B3C-491A-BA22-499FBADD4D12}"
    CreateTuneRequestEx(TuneRequestIID, TuneRequest)
      => ComCall(3, this.p, GUID.Ptr, TuneRequestIID, ITuneRequest.Ptr, TuneRequest)
}
struct EnTvRat_System extends Int32 {
    static MPAA := 0
    static US_TV := 1
    static Canadian_English := 2
    static Canadian_French := 3
    static Reserved4 := 4
    static System5 := 5
    static System6 := 6
    static Reserved7 := 7
    static PBDA := 8
    static AgeBased := 9
    static TvRat_kSystems := 10
    static TvRat_SystemDontKnow := 255
}
struct EnTvRat_GenericLevel extends Int32 {
    static TvRat_0 := 0
    static TvRat_1 := 1
    static TvRat_2 := 2
    static TvRat_3 := 3
    static TvRat_4 := 4
    static TvRat_5 := 5
    static TvRat_6 := 6
    static TvRat_7 := 7
    static TvRat_8 := 8
    static TvRat_9 := 9
    static TvRat_10 := 10
    static TvRat_11 := 11
    static TvRat_12 := 12
    static TvRat_13 := 13
    static TvRat_14 := 14
    static TvRat_15 := 15
    static TvRat_16 := 16
    static TvRat_17 := 17
    static TvRat_18 := 18
    static TvRat_19 := 19
    static TvRat_20 := 20
    static TvRat_21 := 21
    static TvRat_kLevels := 22
    static TvRat_Unblock := -1
    static TvRat_LevelDontKnow := 255
}
struct EnTvRat_MPAA extends Int32 {
    static MPAA_NotApplicable := 0
    static MPAA_G := 1
    static MPAA_PG := 2
    static MPAA_PG13 := 3
    static MPAA_R := 4
    static MPAA_NC17 := 5
    static MPAA_X := 6
    static MPAA_NotRated := 7
}
struct EnTvRat_US_TV extends Int32 {
    static US_TV_None := 0
    static US_TV_Y := 1
    static US_TV_Y7 := 2
    static US_TV_G := 3
    static US_TV_PG := 4
    static US_TV_14 := 5
    static US_TV_MA := 6
    static US_TV_None7 := 7
}
struct EnTvRat_CAE_TV extends Int32 {
    static CAE_TV_Exempt := 0
    static CAE_TV_C := 1
    static CAE_TV_C8 := 2
    static CAE_TV_G := 3
    static CAE_TV_PG := 4
    static CAE_TV_14 := 5
    static CAE_TV_18 := 6
    static CAE_TV_Reserved := 7
}
struct EnTvRat_CAF_TV extends Int32 {
    static CAF_TV_Exempt := 0
    static CAF_TV_G := 1
    static CAF_TV_8 := 2
    static CAF_TV_13 := 3
    static CAF_TV_16 := 4
    static CAF_TV_18 := 5
    static CAF_TV_Reserved6 := 6
    static CAF_TV_Reserved := 7
}
struct BfEnTvRat_GenericAttributes extends Int32 {
    static BfAttrNone := 0
    static BfIsBlocked := 1
    static BfIsAttr_1 := 2
    static BfIsAttr_2 := 4
    static BfIsAttr_3 := 8
    static BfIsAttr_4 := 16
    static BfIsAttr_5 := 32
    static BfIsAttr_6 := 64
    static BfIsAttr_7 := 128
    static BfValidAttrSubmask := 255
}
struct BfEnTvRat_Attributes_US_TV extends Int32 {
    static US_TV_IsBlocked := 1
    static US_TV_IsViolent := 2
    static US_TV_IsSexualSituation := 4
    static US_TV_IsAdultLanguage := 8
    static US_TV_IsSexuallySuggestiveDialog := 16
    static US_TV_ValidAttrSubmask := 31
}
struct BfEnTvRat_Attributes_MPAA extends Int32 {
    static MPAA_IsBlocked := 1
    static MPAA_ValidAttrSubmask := 1
}
struct BfEnTvRat_Attributes_CAE_TV extends Int32 {
    static CAE_IsBlocked := 1
    static CAE_ValidAttrSubmask := 1
}
struct BfEnTvRat_Attributes_CAF_TV extends Int32 {
    static CAF_IsBlocked := 1
    static CAF_ValidAttrSubmask := 1
}
struct FormatNotSupportedEvents extends Int32 {
    static FORMATNOTSUPPORTED_CLEAR := 0
    static FORMATNOTSUPPORTED_NOTSUPPORTED := 1
}
struct WMDRMProtectionInfo {
    wszKID : UInt16[25]
    qwCounter : Int64
    qwIndex : Int64
    bOffset : UInt8
}
struct BadSampleInfo {
    hrReason : HRESULT
}
struct ProtType extends Int32 {
    static PROT_COPY_FREE := 1
    static PROT_COPY_ONCE := 2
    static PROT_COPY_NEVER := 3
    static PROT_COPY_NEVER_REALLY := 4
    static PROT_COPY_NO_MORE := 5
    static PROT_COPY_FREE_CIT := 6
    static PROT_COPY_BF := 7
    static PROT_COPY_CN_RECORDING_STOP := 8
    static PROT_COPY_FREE_SECURE := 9
    static PROT_COPY_INVALID := 50
}
struct EncDecEvents extends Int32 {
    static ENCDEC_CPEVENT := 0
    static ENCDEC_RECORDING_STATUS := 1
}
struct CPRecordingStatus extends Int32 {
    static RECORDING_STOPPED := 0
    static RECORDING_STARTED := 1
}
struct CPEventBitShift extends Int32 {
    static CPEVENT_BITSHIFT_RATINGS := 0
    static CPEVENT_BITSHIFT_COPP := 1
    static CPEVENT_BITSHIFT_LICENSE := 2
    static CPEVENT_BITSHIFT_ROLLBACK := 3
    static CPEVENT_BITSHIFT_SAC := 4
    static CPEVENT_BITSHIFT_DOWNRES := 5
    static CPEVENT_BITSHIFT_STUBLIB := 6
    static CPEVENT_BITSHIFT_UNTRUSTEDGRAPH := 7
    static CPEVENT_BITSHIFT_PENDING_CERTIFICATE := 8
    static CPEVENT_BITSHIFT_NO_PLAYREADY := 9
}
struct CPEvents extends Int32 {
    static CPEVENT_NONE := 0
    static CPEVENT_RATINGS := 1
    static CPEVENT_COPP := 2
    static CPEVENT_LICENSE := 3
    static CPEVENT_ROLLBACK := 4
    static CPEVENT_SAC := 5
    static CPEVENT_DOWNRES := 6
    static CPEVENT_STUBLIB := 7
    static CPEVENT_UNTRUSTEDGRAPH := 8
    static CPEVENT_PROTECTWINDOWED := 9
}
struct RevokedComponent extends Int32 {
    static REVOKED_COPP := 0
    static REVOKED_SAC := 1
    static REVOKED_APP_STUB := 2
    static REVOKED_SECURE_PIPELINE := 3
    static REVOKED_MAX_TYPES := 4
}
struct EnTag_Mode extends Int32 {
    static EnTag_Remove := 0
    static EnTag_Once := 1
    static EnTag_Repeat := 2
}
struct COPPEventBlockReason extends Int32 {
    static COPP_Unknown := -1
    static COPP_BadDriver := 0
    static COPP_NoCardHDCPSupport := 1
    static COPP_NoMonitorHDCPSupport := 2
    static COPP_BadCertificate := 3
    static COPP_InvalidBusProtection := 4
    static COPP_AeroGlassOff := 5
    static COPP_RogueApp := 6
    static COPP_ForbiddenVideo := 7
    static COPP_Activate := 8
    static COPP_DigitalAudioUnprotected := 9
}
struct LicenseEventBlockReason extends Int32 {
    static LIC_BadLicense := 0
    static LIC_NeedIndiv := 1
    static LIC_Expired := 2
    static LIC_NeedActivation := 3
    static LIC_ExtenderBlocked := 4
}
struct DownResEventParam extends Int32 {
    static DOWNRES_Always := 0
    static DOWNRES_InWindowOnly := 1
    static DOWNRES_Undefined := 2
}
struct IETFilterConfig extends IUnknown {
    static IID := "{C4C4C4D1-0049-4E2B-98FB-9537F6CE516D}"
    InitLicense(LicenseId)
      => ComCall(3, this.p, Int32, LicenseId)
    GetSecureChannelObject(ppUnkDRMSecureChannel)
      => ComCall(4, this.p, IUnknown.Ptr, ppUnkDRMSecureChannel)
}
struct IDTFilterConfig extends IUnknown {
    static IID := "{C4C4C4D2-0049-4E2B-98FB-9537F6CE516D}"
    GetSecureChannelObject(ppUnkDRMSecureChannel)
      => ComCall(3, this.p, IUnknown.Ptr, ppUnkDRMSecureChannel)
}
struct IXDSCodecConfig extends IUnknown {
    static IID := "{C4C4C4D3-0049-4E2B-98FB-9537F6CE516D}"
    GetSecureChannelObject(ppUnkDRMSecureChannel)
      => ComCall(3, this.p, IUnknown.Ptr, ppUnkDRMSecureChannel)
    SetPauseBufferTime(dwPauseBufferTime)
      => ComCall(4, this.p, UInt32, dwPauseBufferTime)
}
struct IDTFilterLicenseRenewal extends IUnknown {
    static IID := "{8A78B317-E405-4A43-994A-620D8F5CE25E}"
    GetLicenseRenewalData(ppwszFileName, ppwszExpiredKid, ppwszTunerId)
      => ComCall(3, this.p, PWSTR.Ptr, ppwszFileName, PWSTR.Ptr, ppwszExpiredKid, PWSTR.Ptr, ppwszTunerId)
}
struct IPTFilterLicenseRenewal extends IUnknown {
    static IID := "{26D836A5-0C15-44C7-AC59-B0DA8728F240}"
    RenewLicenses(wszFileName, wszExpiredKid, dwCallersId, bHighPriority)
      => ComCall(3, this.p, "Str", wszFileName, "Str", wszExpiredKid, UInt32, dwCallersId, BOOL, bHighPriority)
    CancelLicenseRenewal()
      => ComCall(4, this.p)
}
struct IMceBurnerControl extends IUnknown {
    static IID := "{5A86B91A-E71E-46C1-88A9-9BB338710552}"
    GetBurnerNoDecryption()
      => ComCall(3, this.p)
}
struct IETFilter extends IUnknown {
    static IID := "{C4C4C4B1-0049-4E2B-98FB-9537F6CE516D}"
    get_EvalRatObjOK(pHrCoCreateRetVal)
      => ComCall(3, this.p, HRESULT.Ptr, pHrCoCreateRetVal)
    GetCurrRating(pEnSystem, pEnRating, plbfEnAttr)
      => ComCall(4, this.p, EnTvRat_System.Ptr, pEnSystem, EnTvRat_GenericLevel.Ptr, pEnRating, Int32.Ptr, plbfEnAttr)
    GetCurrLicenseExpDate(protType, lpDateTime)
      => ComCall(5, this.p, ProtType.Ptr, protType, Int32.Ptr, lpDateTime)
    GetLastErrorCode()
      => ComCall(6, this.p)
    SetRecordingOn(fRecState)
      => ComCall(7, this.p, BOOL, fRecState)
}
struct IETFilterEvents extends IDispatch {
    static IID := "{C4C4C4C1-0049-4E2B-98FB-9537F6CE516D}"
}
struct IDTFilter extends IUnknown {
    static IID := "{C4C4C4B2-0049-4E2B-98FB-9537F6CE516D}"
    get_EvalRatObjOK(pHrCoCreateRetVal)
      => ComCall(3, this.p, HRESULT.Ptr, pHrCoCreateRetVal)
    GetCurrRating(pEnSystem, pEnRating, plbfEnAttr)
      => ComCall(4, this.p, EnTvRat_System.Ptr, pEnSystem, EnTvRat_GenericLevel.Ptr, pEnRating, Int32.Ptr, plbfEnAttr)
    get_BlockedRatingAttributes(enSystem, enLevel, plbfEnAttr)
      => ComCall(5, this.p, EnTvRat_System, enSystem, EnTvRat_GenericLevel, enLevel, Int32.Ptr, plbfEnAttr)
    put_BlockedRatingAttributes(enSystem, enLevel, lbfAttrs)
      => ComCall(6, this.p, EnTvRat_System, enSystem, EnTvRat_GenericLevel, enLevel, Int32, lbfAttrs)
    get_BlockUnRated(pfBlockUnRatedShows)
      => ComCall(7, this.p, BOOL.Ptr, pfBlockUnRatedShows)
    put_BlockUnRated(fBlockUnRatedShows)
      => ComCall(8, this.p, BOOL, fBlockUnRatedShows)
    get_BlockUnRatedDelay(pmsecsDelayBeforeBlock)
      => ComCall(9, this.p, Int32.Ptr, pmsecsDelayBeforeBlock)
    put_BlockUnRatedDelay(msecsDelayBeforeBlock)
      => ComCall(10, this.p, Int32, msecsDelayBeforeBlock)
}
struct IDTFilter2 extends IDTFilter {
    static IID := "{C4C4C4B4-0049-4E2B-98FB-9537F6CE516D}"
    get_ChallengeUrl(pbstrChallengeUrl)
      => ComCall(11, this.p, BSTR.Ptr, pbstrChallengeUrl)
    GetCurrLicenseExpDate(protType, lpDateTime)
      => ComCall(12, this.p, ProtType.Ptr, protType, Int32.Ptr, lpDateTime)
    GetLastErrorCode()
      => ComCall(13, this.p)
}
struct IDTFilter3 extends IDTFilter2 {
    static IID := "{513998CC-E929-4CDF-9FBD-BAD1E0314866}"
    GetProtectionType(pProtectionType)
      => ComCall(14, this.p, ProtType.Ptr, pProtectionType)
    LicenseHasExpirationDate(pfLicenseHasExpirationDate)
      => ComCall(15, this.p, BOOL.Ptr, pfLicenseHasExpirationDate)
    SetRights(bstrRights)
      => ComCall(16, this.p, BSTR, bstrRights)
}
struct IDTFilterEvents extends IDispatch {
    static IID := "{C4C4C4C2-0049-4E2B-98FB-9537F6CE516D}"
}
struct IXDSCodec extends IUnknown {
    static IID := "{C4C4C4B3-0049-4E2B-98FB-9537F6CE516D}"
    get_XDSToRatObjOK(pHrCoCreateRetVal)
      => ComCall(3, this.p, HRESULT.Ptr, pHrCoCreateRetVal)
    put_CCSubstreamService(SubstreamMask)
      => ComCall(4, this.p, Int32, SubstreamMask)
    get_CCSubstreamService(pSubstreamMask)
      => ComCall(5, this.p, Int32.Ptr, pSubstreamMask)
    GetContentAdvisoryRating(pRat, pPktSeqID, pCallSeqID, pTimeStart, pTimeEnd)
      => ComCall(6, this.p, Int32.Ptr, pRat, Int32.Ptr, pPktSeqID, Int32.Ptr, pCallSeqID, Int64.Ptr, pTimeStart, Int64.Ptr, pTimeEnd)
    GetXDSPacket(pXDSClassPkt, pXDSTypePkt, pBstrXDSPkt, pPktSeqID, pCallSeqID, pTimeStart, pTimeEnd)
      => ComCall(7, this.p, Int32.Ptr, pXDSClassPkt, Int32.Ptr, pXDSTypePkt, BSTR.Ptr, pBstrXDSPkt, Int32.Ptr, pPktSeqID, Int32.Ptr, pCallSeqID, Int64.Ptr, pTimeStart, Int64.Ptr, pTimeEnd)
    GetCurrLicenseExpDate(protType, lpDateTime)
      => ComCall(8, this.p, ProtType.Ptr, protType, Int32.Ptr, lpDateTime)
    GetLastErrorCode()
      => ComCall(9, this.p)
}
struct IXDSCodecEvents extends IDispatch {
    static IID := "{C4C4C4C3-0049-4E2B-98FB-9537F6CE516D}"
}
struct IXDSToRat extends IDispatch {
    static IID := "{C5C5C5B0-3ABC-11D6-B25B-00C04FA0C026}"
    Init()
      => ComCall(7, this.p)
    ParseXDSBytePair(byte1, byte2, pEnSystem, pEnLevel, plBfEnAttributes)
      => ComCall(8, this.p, UInt8, byte1, UInt8, byte2, EnTvRat_System.Ptr, pEnSystem, EnTvRat_GenericLevel.Ptr, pEnLevel, Int32.Ptr, plBfEnAttributes)
}
struct IEvalRat extends IDispatch {
    static IID := "{C5C5C5B1-3ABC-11D6-B25B-00C04FA0C026}"
    get_BlockedRatingAttributes(enSystem, enLevel, plbfAttrs)
      => ComCall(7, this.p, EnTvRat_System, enSystem, EnTvRat_GenericLevel, enLevel, Int32.Ptr, plbfAttrs)
    put_BlockedRatingAttributes(enSystem, enLevel, lbfAttrs)
      => ComCall(8, this.p, EnTvRat_System, enSystem, EnTvRat_GenericLevel, enLevel, Int32, lbfAttrs)
    get_BlockUnRated(pfBlockUnRatedShows)
      => ComCall(9, this.p, BOOL.Ptr, pfBlockUnRatedShows)
    put_BlockUnRated(fBlockUnRatedShows)
      => ComCall(10, this.p, BOOL, fBlockUnRatedShows)
    MostRestrictiveRating(enSystem1, enEnLevel1, lbfEnAttr1, enSystem2, enEnLevel2, lbfEnAttr2, penSystem, penEnLevel, plbfEnAttr)
      => ComCall(11, this.p, EnTvRat_System, enSystem1, EnTvRat_GenericLevel, enEnLevel1, Int32, lbfEnAttr1, EnTvRat_System, enSystem2, EnTvRat_GenericLevel, enEnLevel2, Int32, lbfEnAttr2, EnTvRat_System.Ptr, penSystem, EnTvRat_GenericLevel.Ptr, penEnLevel, Int32.Ptr, plbfEnAttr)
    TestRating(enShowSystem, enShowLevel, lbfEnShowAttributes)
      => ComCall(12, this.p, EnTvRat_System, enShowSystem, EnTvRat_GenericLevel, enShowLevel, Int32, lbfEnShowAttributes)
}
struct SegDispidList extends Int32 {
    static dispidName := 0
    static dispidStatus := 1
    static dispidDevImageSourceWidth := 2
    static dispidDevImageSourceHeight := 3
    static dispidDevCountryCode := 4
    static dispidDevOverScan := 5
    static dispidSegment := 6
    static dispidDevVolume := 7
    static dispidDevBalance := 8
    static dispidDevPower := 9
    static dispidTuneChan := 10
    static dispidDevVideoSubchannel := 11
    static dispidDevAudioSubchannel := 12
    static dispidChannelAvailable := 13
    static dispidDevVideoFrequency := 14
    static dispidDevAudioFrequency := 15
    static dispidCount := 16
    static dispidDevFileName := 17
    static dispidVisible := 18
    static dispidOwner := 19
    static dispidMessageDrain := 20
    static dispidViewable := 21
    static dispidDevView := 22
    static dispidKSCat := 23
    static dispidCLSID := 24
    static dispid_KSCat := 25
    static dispid_CLSID := 26
    static dispidTune := 27
    static dispidTS := 28
    static dispidDevSAP := 29
    static dispidClip := 30
    static dispidRequestedClipRect := 31
    static dispidClippedSourceRect := 32
    static dispidAvailableSourceRect := 33
    static dispidMediaPosition := 34
    static dispidDevRun := 35
    static dispidDevPause := 36
    static dispidDevStop := 37
    static dispidCCEnable := 38
    static dispidDevStep := 39
    static dispidDevCanStep := 40
    static dispidSourceSize := 41
    static dispid_playtitle := 42
    static dispid_playchapterintitle := 43
    static dispid_playchapter := 44
    static dispid_playchaptersautostop := 45
    static dispid_playattime := 46
    static dispid_playattimeintitle := 47
    static dispid_playperiodintitleautostop := 48
    static dispid_replaychapter := 49
    static dispid_playprevchapter := 50
    static dispid_playnextchapter := 51
    static dispid_playforwards := 52
    static dispid_playbackwards := 53
    static dispid_stilloff := 54
    static dispid_audiolanguage := 55
    static dispid_showmenu := 56
    static dispid_resume := 57
    static dispid_returnfromsubmenu := 58
    static dispid_buttonsavailable := 59
    static dispid_currentbutton := 60
    static dispid_SelectAndActivateButton := 61
    static dispid_ActivateButton := 62
    static dispid_SelectRightButton := 63
    static dispid_SelectLeftButton := 64
    static dispid_SelectLowerButton := 65
    static dispid_SelectUpperButton := 66
    static dispid_ActivateAtPosition := 67
    static dispid_SelectAtPosition := 68
    static dispid_ButtonAtPosition := 69
    static dispid_NumberOfChapters := 70
    static dispid_TotalTitleTime := 71
    static dispid_TitlesAvailable := 72
    static dispid_VolumesAvailable := 73
    static dispid_CurrentVolume := 74
    static dispid_CurrentDiscSide := 75
    static dispid_CurrentDomain := 76
    static dispid_CurrentChapter := 77
    static dispid_CurrentTitle := 78
    static dispid_CurrentTime := 79
    static dispid_FramesPerSecond := 80
    static dispid_DVDTimeCode2bstr := 81
    static dispid_DVDDirectory := 82
    static dispid_IsSubpictureStreamEnabled := 83
    static dispid_IsAudioStreamEnabled := 84
    static dispid_CurrentSubpictureStream := 85
    static dispid_SubpictureLanguage := 86
    static dispid_CurrentAudioStream := 87
    static dispid_AudioStreamsAvailable := 88
    static dispid_AnglesAvailable := 89
    static dispid_CurrentAngle := 90
    static dispid_CCActive := 91
    static dispid_CurrentCCService := 92
    static dispid_SubpictureStreamsAvailable := 93
    static dispid_SubpictureOn := 94
    static dispid_DVDUniqueID := 95
    static dispid_EnableResetOnStop := 96
    static dispid_AcceptParentalLevelChange := 97
    static dispid_NotifyParentalLevelChange := 98
    static dispid_SelectParentalCountry := 99
    static dispid_SelectParentalLevel := 100
    static dispid_TitleParentalLevels := 101
    static dispid_PlayerParentalCountry := 102
    static dispid_PlayerParentalLevel := 103
    static dispid_Eject := 104
    static dispid_UOPValid := 105
    static dispid_SPRM := 106
    static dispid_GPRM := 107
    static dispid_DVDTextStringType := 108
    static dispid_DVDTextString := 109
    static dispid_DVDTextNumberOfStrings := 110
    static dispid_DVDTextNumberOfLanguages := 111
    static dispid_DVDTextLanguageLCID := 112
    static dispid_RegionChange := 113
    static dispid_DVDAdm := 114
    static dispid_DeleteBookmark := 115
    static dispid_RestoreBookmark := 116
    static dispid_SaveBookmark := 117
    static dispid_SelectDefaultAudioLanguage := 118
    static dispid_SelectDefaultSubpictureLanguage := 119
    static dispid_PreferredSubpictureStream := 120
    static dispid_DefaultMenuLanguage := 121
    static dispid_DefaultSubpictureLanguage := 122
    static dispid_DefaultAudioLanguage := 123
    static dispid_DefaultSubpictureLanguageExt := 124
    static dispid_DefaultAudioLanguageExt := 125
    static dispid_LanguageFromLCID := 126
    static dispid_KaraokeAudioPresentationMode := 127
    static dispid_KaraokeChannelContent := 128
    static dispid_KaraokeChannelAssignment := 129
    static dispid_RestorePreferredSettings := 130
    static dispid_ButtonRect := 131
    static dispid_DVDScreenInMouseCoordinates := 132
    static dispid_CustomCompositorClass := 133
    static dispidCustomCompositorClass := 134
    static dispid_CustomCompositor := 135
    static dispidMixerBitmap := 136
    static dispid_MixerBitmap := 137
    static dispidMixerBitmapOpacity := 138
    static dispidMixerBitmapRect := 139
    static dispidSetupMixerBitmap := 140
    static dispidUsingOverlay := 141
    static dispidDisplayChange := 142
    static dispidRePaint := 143
    static dispid_IsEqualDevice := 144
    static dispidrate := 145
    static dispidposition := 146
    static dispidpositionmode := 147
    static dispidlength := 148
    static dispidChangePassword := 149
    static dispidSaveParentalLevel := 150
    static dispidSaveParentalCountry := 151
    static dispidConfirmPassword := 152
    static dispidGetParentalLevel := 153
    static dispidGetParentalCountry := 154
    static dispidDefaultAudioLCID := 155
    static dispidDefaultSubpictureLCID := 156
    static dispidDefaultMenuLCID := 157
    static dispidBookmarkOnStop := 158
    static dispidMaxVidRect := 159
    static dispidMinVidRect := 160
    static dispidCapture := 161
    static dispid_DecimateInput := 162
    static dispidAlloctor := 163
    static dispid_Allocator := 164
    static dispidAllocPresentID := 165
    static dispidSetAllocator := 166
    static dispid_SetAllocator := 167
    static dispidStreamBufferSinkName := 168
    static dispidStreamBufferSourceName := 169
    static dispidStreamBufferContentRecording := 170
    static dispidStreamBufferReferenceRecording := 171
    static dispidstarttime := 172
    static dispidstoptime := 173
    static dispidrecordingstopped := 174
    static dispidrecordingstarted := 175
    static dispidNameSetLock := 176
    static dispidrecordingtype := 177
    static dispidstart := 178
    static dispidRecordingAttribute := 179
    static dispid_RecordingAttribute := 180
    static dispidSBEConfigure := 181
    static dispid_CurrentRatings := 182
    static dispid_MaxRatingsLevel := 183
    static dispid_audioencoderint := 184
    static dispid_videoencoderint := 185
    static dispidService := 186
    static dispid_BlockUnrated := 187
    static dispid_UnratedDelay := 188
    static dispid_SuppressEffects := 189
    static dispidsbesource := 190
    static dispidSetSinkFilter := 191
    static dispid_SinkStreams := 192
    static dispidTVFormats := 193
    static dispidModes := 194
    static dispidAuxInputs := 195
    static dispidTeleTextFilter := 196
    static dispid_channelchangeint := 197
    static dispidUnlockProfile := 198
    static dispid_AddFilter := 199
    static dispidSetMinSeek := 200
    static dispidRateEx := 201
    static dispidaudiocounter := 202
    static dispidvideocounter := 203
    static dispidcccounter := 204
    static dispidwstcounter := 205
    static dispid_audiocounter := 206
    static dispid_videocounter := 207
    static dispid_cccounter := 208
    static dispid_wstcounter := 209
    static dispidaudioanalysis := 210
    static dispidvideoanalysis := 211
    static dispiddataanalysis := 212
    static dispidaudio_analysis := 213
    static dispidvideo_analysis := 214
    static dispiddata_analysis := 215
    static dispid_resetFilterList := 216
    static dispidDevicePath := 217
    static dispid_SourceFilter := 218
    static dispid__SourceFilter := 219
    static dispidUserEvent := 220
    static dispid_Bookmark := 221
    static LastReservedDeviceDispid := 16383
}
struct SegEventidList extends Int32 {
    static eventidStateChange := 0
    static eventidOnTuneChanged := 1
    static eventidEndOfMedia := 2
    static eventidDVDNotify := 3
    static eventidPlayForwards := 4
    static eventidPlayBackwards := 5
    static eventidShowMenu := 6
    static eventidResume := 7
    static eventidSelectOrActivateButton := 8
    static eventidStillOff := 9
    static eventidPauseOn := 10
    static eventidChangeCurrentAudioStream := 11
    static eventidChangeCurrentSubpictureStream := 12
    static eventidChangeCurrentAngle := 13
    static eventidPlayAtTimeInTitle := 14
    static eventidPlayAtTime := 15
    static eventidPlayChapterInTitle := 16
    static eventidPlayChapter := 17
    static eventidReplayChapter := 18
    static eventidPlayNextChapter := 19
    static eventidStop := 20
    static eventidReturnFromSubmenu := 21
    static eventidPlayTitle := 22
    static eventidPlayPrevChapter := 23
    static eventidChangeKaraokePresMode := 24
    static eventidChangeVideoPresMode := 25
    static eventidOverlayUnavailable := 26
    static eventidSinkCertificateFailure := 27
    static eventidSinkCertificateSuccess := 28
    static eventidSourceCertificateFailure := 29
    static eventidSourceCertificateSuccess := 30
    static eventidRatingsBlocked := 31
    static eventidRatingsUnlocked := 32
    static eventidRatingsChanged := 33
    static eventidWriteFailure := 34
    static eventidTimeHole := 35
    static eventidStaleDataRead := 36
    static eventidContentBecomingStale := 37
    static eventidStaleFileDeleted := 38
    static eventidEncryptionOn := 39
    static eventidEncryptionOff := 40
    static eventidRateChange := 41
    static eventidLicenseChange := 42
    static eventidCOPPBlocked := 43
    static eventidCOPPUnblocked := 44
    static dispidlicenseerrorcode := 45
    static eventidBroadcastEvent := 46
    static eventidBroadcastEventEx := 47
    static eventidContentPrimarilyAudio := 48
    static dispidAVDecAudioDualMonoEvent := 49
    static dispidAVAudioSampleRateEvent := 50
    static dispidAVAudioChannelConfigEvent := 51
    static dispidAVAudioChannelCountEvent := 52
    static dispidAVDecCommonMeanBitRateEvent := 53
    static dispidAVDDSurroundModeEvent := 54
    static dispidAVDecCommonInputFormatEvent := 55
    static dispidAVDecCommonOutputFormatEvent := 56
    static eventidWriteFailureClear := 57
    static LastReservedDeviceEvent := 16383
}
struct PositionModeList extends Int32 {
    static FrameMode := 0
    static TenthsSecondsMode := 1
}
struct RecordingType extends Int32 {
    static CONTENT := 0
    static REFERENCE := 1
}
struct MSVidCCService extends Int32 {
    static None := 0
    static Caption1 := 1
    static Caption2 := 2
    static Text1 := 3
    static Text2 := 4
    static XDS := 5
}
struct MSVidSinkStreams extends Int32 {
    static MSVidSink_Video := 1
    static MSVidSink_Audio := 2
    static MSVidSink_Other := 4
}
struct IMSVidRect extends IDispatch {
    static IID := "{7F5000A6-A440-47CA-8ACC-C0E75531A2C2}"
    get_Top(TopVal)
      => ComCall(7, this.p, Int32.Ptr, TopVal)
    put_Top(TopVal)
      => ComCall(8, this.p, Int32, TopVal)
    get_Left(LeftVal)
      => ComCall(9, this.p, Int32.Ptr, LeftVal)
    put_Left(LeftVal)
      => ComCall(10, this.p, Int32, LeftVal)
    get_Width(WidthVal)
      => ComCall(11, this.p, Int32.Ptr, WidthVal)
    put_Width(WidthVal)
      => ComCall(12, this.p, Int32, WidthVal)
    get_Height(HeightVal)
      => ComCall(13, this.p, Int32.Ptr, HeightVal)
    put_Height(HeightVal)
      => ComCall(14, this.p, Int32, HeightVal)
    get_HWnd(HWndVal)
      => ComCall(15, this.p, HWND.Ptr, HWndVal)
    put_HWnd(HWndVal)
      => ComCall(16, this.p, HWND, HWndVal)
    put_Rect(RectVal)
      => ComCall(17, this.p, IMSVidRect, RectVal)
}
struct IMSVidGraphSegmentContainer extends IUnknown {
    static IID := "{3DD2903D-E0AA-11D2-B63A-00C04F79498E}"
    get_Graph(ppGraph)
      => ComCall(3, this.p, IGraphBuilder.Ptr, ppGraph)
    get_Input(ppInput)
      => ComCall(4, this.p, IMSVidGraphSegment.Ptr, ppInput)
    get_Outputs(ppOutputs)
      => ComCall(5, this.p, IEnumMSVidGraphSegment.Ptr, ppOutputs)
    get_VideoRenderer(ppVR)
      => ComCall(6, this.p, IMSVidGraphSegment.Ptr, ppVR)
    get_AudioRenderer(ppAR)
      => ComCall(7, this.p, IMSVidGraphSegment.Ptr, ppAR)
    get_Features(ppFeatures)
      => ComCall(8, this.p, IEnumMSVidGraphSegment.Ptr, ppFeatures)
    get_Composites(ppComposites)
      => ComCall(9, this.p, IEnumMSVidGraphSegment.Ptr, ppComposites)
    get_ParentContainer(ppContainer)
      => ComCall(10, this.p, IUnknown.Ptr, ppContainer)
    Decompose(pSegment?)
      => ComCall(11, this.p, IMSVidGraphSegment, pSegment?)
    IsWindowless()
      => ComCall(12, this.p)
    GetFocus()
      => ComCall(13, this.p)
}
struct MSVidSegmentType extends Int32 {
    static MSVidSEG_SOURCE := 0
    static MSVidSEG_XFORM := 1
    static MSVidSEG_DEST := 2
}
struct IMSVidGraphSegment extends IPersist {
    static IID := "{238DEC54-ADEB-4005-A349-F772B9AFEBC4}"
    get_Init(pInit)
      => ComCall(4, this.p, IUnknown.Ptr, pInit)
    put_Init(pInit)
      => ComCall(5, this.p, IUnknown, pInit)
    EnumFilters(pNewEnum)
      => ComCall(6, this.p, IEnumFilters.Ptr, pNewEnum)
    get_Container(ppCtl)
      => ComCall(7, this.p, IMSVidGraphSegmentContainer.Ptr, ppCtl)
    put_Container(pCtl)
      => ComCall(8, this.p, IMSVidGraphSegmentContainer, pCtl)
    get_Type(pType)
      => ComCall(9, this.p, MSVidSegmentType.Ptr, pType)
    get_Category(pGuid)
      => ComCall(10, this.p, GUID.Ptr, pGuid)
    Build()
      => ComCall(11, this.p)
    PostBuild()
      => ComCall(12, this.p)
    PreRun()
      => ComCall(13, this.p)
    PostRun()
      => ComCall(14, this.p)
    PreStop()
      => ComCall(15, this.p)
    PostStop()
      => ComCall(16, this.p)
    OnEventNotify(lEventCode, lEventParm1, lEventParm2)
      => ComCall(17, this.p, Int32, lEventCode, IntPtr, lEventParm1, IntPtr, lEventParm2)
    Decompose()
      => ComCall(18, this.p)
}
struct MSVidCtlButtonstate extends Int32 {
    static MSVIDCTL_LEFT_BUTTON := 1
    static MSVIDCTL_RIGHT_BUTTON := 2
    static MSVIDCTL_MIDDLE_BUTTON := 4
    static MSVIDCTL_X_BUTTON1 := 8
    static MSVIDCTL_X_BUTTON2 := 16
    static MSVIDCTL_SHIFT := 1
    static MSVIDCTL_CTRL := 2
    static MSVIDCTL_ALT := 4
}
struct IMSVidGraphSegmentUserInput extends IUnknown {
    static IID := "{301C060E-20D9-4587-9B03-F82ED9A9943C}"
    Click()
      => ComCall(3, this.p)
    DblClick()
      => ComCall(4, this.p)
    KeyDown(KeyCode, ShiftState)
      => ComCall(5, this.p, Int16.Ptr, KeyCode, Int16, ShiftState)
    KeyPress(KeyAscii)
      => ComCall(6, this.p, Int16.Ptr, KeyAscii)
    KeyUp(KeyCode, ShiftState)
      => ComCall(7, this.p, Int16.Ptr, KeyCode, Int16, ShiftState)
    MouseDown(ButtonState, ShiftState, x, y)
      => ComCall(8, this.p, Int16, ButtonState, Int16, ShiftState, Int32, x, Int32, y)
    MouseMove(ButtonState, ShiftState, x, y)
      => ComCall(9, this.p, Int16, ButtonState, Int16, ShiftState, Int32, x, Int32, y)
    MouseUp(ButtonState, ShiftState, x, y)
      => ComCall(10, this.p, Int16, ButtonState, Int16, ShiftState, Int32, x, Int32, y)
}
struct IMSVidCompositionSegment extends IMSVidGraphSegment {
    static IID := "{1C15D483-911D-11D2-B632-00C04F79498E}"
    Compose(upstream, downstream)
      => ComCall(19, this.p, IMSVidGraphSegment, upstream, IMSVidGraphSegment, downstream)
    get_Up(upstream)
      => ComCall(20, this.p, IMSVidGraphSegment.Ptr, upstream)
    get_Down(downstream)
      => ComCall(21, this.p, IMSVidGraphSegment.Ptr, downstream)
}
struct IEnumMSVidGraphSegment extends IUnknown {
    static IID := "{3DD2903E-E0AA-11D2-B63A-00C04F79498E}"
    Next(celt, rgelt, pceltFetched)
      => ComCall(3, this.p, UInt32, celt, IMSVidGraphSegment.Ptr, rgelt, UInt32.Ptr, pceltFetched)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumMSVidGraphSegment.Ptr, ppenum)
}
struct IMSVidVRGraphSegment extends IMSVidGraphSegment {
    static IID := "{DD47DE3F-9874-4F7B-8B22-7CB2688461E7}"
    put__VMRendererMode(dwMode)
      => ComCall(19, this.p, Int32, dwMode)
    put_Owner(Window)
      => ComCall(20, this.p, HWND, Window)
    get_Owner(Window)
      => ComCall(21, this.p, HWND.Ptr, Window)
    get_UseOverlay(UseOverlayVal)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, UseOverlayVal)
    put_UseOverlay(UseOverlayVal)
      => ComCall(23, this.p, VARIANT_BOOL, UseOverlayVal)
    get_Visible(Visible)
      => ComCall(24, this.p, VARIANT_BOOL.Ptr, Visible)
    put_Visible(Visible)
      => ComCall(25, this.p, VARIANT_BOOL, Visible)
    get_ColorKey(ColorKey)
      => ComCall(26, this.p, UInt32.Ptr, ColorKey)
    put_ColorKey(ColorKey)
      => ComCall(27, this.p, UInt32, ColorKey)
    get_Source(r)
      => ComCall(28, this.p, RECT.Ptr, r)
    put_Source(r)
      => ComCall(29, this.p, RECT, r)
    get_Destination(r)
      => ComCall(30, this.p, RECT.Ptr, r)
    put_Destination(r)
      => ComCall(31, this.p, RECT, r)
    get_NativeSize(sizeval, aspectratio)
      => ComCall(32, this.p, SIZE.Ptr, sizeval, SIZE.Ptr, aspectratio)
    get_BorderColor(color)
      => ComCall(33, this.p, UInt32.Ptr, color)
    put_BorderColor(color)
      => ComCall(34, this.p, UInt32, color)
    get_MaintainAspectRatio(fMaintain)
      => ComCall(35, this.p, VARIANT_BOOL.Ptr, fMaintain)
    put_MaintainAspectRatio(fMaintain)
      => ComCall(36, this.p, VARIANT_BOOL, fMaintain)
    Refresh()
      => ComCall(37, this.p)
    DisplayChange()
      => ComCall(38, this.p)
    RePaint(hdc1)
      => ComCall(39, this.p, HDC, hdc1)
}
struct IMSVidDevice extends IDispatch {
    static IID := "{1C15D47C-911D-11D2-B632-00C04F79498E}"
    get_Name(Name)
      => ComCall(7, this.p, BSTR.Ptr, Name)
    get_Status(Status)
      => ComCall(8, this.p, Int32.Ptr, Status)
    put_Power(Power)
      => ComCall(9, this.p, VARIANT_BOOL, Power)
    get_Power(Power)
      => ComCall(10, this.p, VARIANT_BOOL.Ptr, Power)
    get_Category(Guid)
      => ComCall(11, this.p, BSTR.Ptr, Guid)
    get_ClassID(Clsid)
      => ComCall(12, this.p, BSTR.Ptr, Clsid)
    get__Category(Guid)
      => ComCall(13, this.p, GUID.Ptr, Guid)
    get__ClassID(Clsid)
      => ComCall(14, this.p, GUID.Ptr, Clsid)
    IsEqualDevice(Device, IsEqual)
      => ComCall(15, this.p, IMSVidDevice, Device, VARIANT_BOOL.Ptr, IsEqual)
}
struct IMSVidDevice2 extends IUnknown {
    static IID := "{87BD2783-EBC0-478C-B4A0-E8E7F43AB78E}"
    get_DevicePath(DevPath)
      => ComCall(3, this.p, BSTR.Ptr, DevPath)
}
struct IMSVidInputDevice extends IMSVidDevice {
    static IID := "{37B0353D-A4C8-11D2-B634-00C04F79498E}"
    IsViewable(v, pfViewable)
      => ComCall(16, this.p, VARIANT.Ptr, v, VARIANT_BOOL.Ptr, pfViewable)
    View(v)
      => ComCall(17, this.p, VARIANT.Ptr, v)
}
struct IMSVidDeviceEvent extends IDispatch {
    static IID := "{1C15D480-911D-11D2-B632-00C04F79498E}"
    StateChange(lpd, oldState, newState)
      => ComCall(7, this.p, IMSVidDevice, lpd, Int32, oldState, Int32, newState)
}
struct IMSVidInputDeviceEvent extends IDispatch {
    static IID := "{37B0353E-A4C8-11D2-B634-00C04F79498E}"
}
struct IMSVidVideoInputDevice extends IMSVidInputDevice {
    static IID := "{1C15D47F-911D-11D2-B632-00C04F79498E}"
}
struct IMSVidPlayback extends IMSVidInputDevice {
    static IID := "{37B03538-A4C8-11D2-B634-00C04F79498E}"
    get_EnableResetOnStop(pVal)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, pVal)
    put_EnableResetOnStop(newVal)
      => ComCall(19, this.p, VARIANT_BOOL, newVal)
    Run()
      => ComCall(20, this.p)
    Pause()
      => ComCall(21, this.p)
    Stop()
      => ComCall(22, this.p)
    get_CanStep(fBackwards, pfCan)
      => ComCall(23, this.p, VARIANT_BOOL, fBackwards, VARIANT_BOOL.Ptr, pfCan)
    Step(lStep)
      => ComCall(24, this.p, Int32, lStep)
    put_Rate(plRate)
      => ComCall(25, this.p, Float64, plRate)
    get_Rate(plRate)
      => ComCall(26, this.p, Float64.Ptr, plRate)
    put_CurrentPosition(lPosition)
      => ComCall(27, this.p, Int32, lPosition)
    get_CurrentPosition(lPosition)
      => ComCall(28, this.p, Int32.Ptr, lPosition)
    put_PositionMode(lPositionMode)
      => ComCall(29, this.p, PositionModeList, lPositionMode)
    get_PositionMode(lPositionMode)
      => ComCall(30, this.p, PositionModeList.Ptr, lPositionMode)
    get_Length(lLength)
      => ComCall(31, this.p, Int32.Ptr, lLength)
}
struct IMSVidPlaybackEvent extends IMSVidInputDeviceEvent {
    static IID := "{37B0353B-A4C8-11D2-B634-00C04F79498E}"
    EndOfMedia(lpd)
      => ComCall(7, this.p, IMSVidPlayback, lpd)
}
struct IMSVidTuner extends IMSVidVideoInputDevice {
    static IID := "{1C15D47D-911D-11D2-B632-00C04F79498E}"
    get_Tune(ppTR)
      => ComCall(18, this.p, ITuneRequest.Ptr, ppTR)
    put_Tune(pTR)
      => ComCall(19, this.p, ITuneRequest, pTR)
    get_TuningSpace(plTS)
      => ComCall(20, this.p, ITuningSpace.Ptr, plTS)
    put_TuningSpace(plTS)
      => ComCall(21, this.p, ITuningSpace, plTS)
}
struct IMSVidTunerEvent extends IMSVidInputDeviceEvent {
    static IID := "{1C15D485-911D-11D2-B632-00C04F79498E}"
    TuneChanged(lpd)
      => ComCall(7, this.p, IMSVidTuner, lpd)
}
struct IMSVidAnalogTuner extends IMSVidTuner {
    static IID := "{1C15D47E-911D-11D2-B632-00C04F79498E}"
    get_Channel(Channel)
      => ComCall(22, this.p, Int32.Ptr, Channel)
    put_Channel(Channel)
      => ComCall(23, this.p, Int32, Channel)
    get_VideoFrequency(lcc)
      => ComCall(24, this.p, Int32.Ptr, lcc)
    get_AudioFrequency(lcc)
      => ComCall(25, this.p, Int32.Ptr, lcc)
    get_CountryCode(lcc)
      => ComCall(26, this.p, Int32.Ptr, lcc)
    put_CountryCode(lcc)
      => ComCall(27, this.p, Int32, lcc)
    get_SAP(pfSapOn)
      => ComCall(28, this.p, VARIANT_BOOL.Ptr, pfSapOn)
    put_SAP(fSapOn)
      => ComCall(29, this.p, VARIANT_BOOL, fSapOn)
    ChannelAvailable(nChannel, SignalStrength, fSignalPresent)
      => ComCall(30, this.p, Int32, nChannel, Int32.Ptr, SignalStrength, VARIANT_BOOL.Ptr, fSignalPresent)
}
struct IMSVidAnalogTuner2 extends IMSVidAnalogTuner {
    static IID := "{37647BF7-3DDE-4CC8-A4DC-0D534D3D0037}"
    get_TVFormats(Formats)
      => ComCall(31, this.p, Int32.Ptr, Formats)
    get_TunerModes(Modes)
      => ComCall(32, this.p, Int32.Ptr, Modes)
    get_NumAuxInputs(Inputs)
      => ComCall(33, this.p, Int32.Ptr, Inputs)
}
struct IMSVidAnalogTunerEvent extends IMSVidTunerEvent {
    static IID := "{1C15D486-911D-11D2-B632-00C04F79498E}"
}
struct IMSVidFilePlayback extends IMSVidPlayback {
    static IID := "{37B03539-A4C8-11D2-B634-00C04F79498E}"
    get_FileName(FileName)
      => ComCall(32, this.p, BSTR.Ptr, FileName)
    put_FileName(FileName)
      => ComCall(33, this.p, BSTR, FileName)
}
struct IMSVidFilePlayback2 extends IMSVidFilePlayback {
    static IID := "{2F7E44AF-6E52-4660-BC08-D8D542587D72}"
    put__SourceFilter(FileName)
      => ComCall(34, this.p, BSTR, FileName)
    put___SourceFilter(FileName)
      => ComCall(35, this.p, GUID, FileName)
}
struct IMSVidFilePlaybackEvent extends IMSVidPlaybackEvent {
    static IID := "{37B0353A-A4C8-11D2-B634-00C04F79498E}"
}
struct DVDMenuIDConstants extends Int32 {
    static dvdMenu_Title := 2
    static dvdMenu_Root := 3
    static dvdMenu_Subpicture := 4
    static dvdMenu_Audio := 5
    static dvdMenu_Angle := 6
    static dvdMenu_Chapter := 7
}
struct DVDFilterState extends Int32 {
    static dvdState_Undefined := -2
    static dvdState_Unitialized := -1
    static dvdState_Stopped := 0
    static dvdState_Paused := 1
    static dvdState_Running := 2
}
struct DVDTextStringType extends Int32 {
    static dvdStruct_Volume := 1
    static dvdStruct_Title := 2
    static dvdStruct_ParentalID := 3
    static dvdStruct_PartOfTitle := 4
    static dvdStruct_Cell := 5
    static dvdStream_Audio := 16
    static dvdStream_Subpicture := 17
    static dvdStream_Angle := 18
    static dvdChannel_Audio := 32
    static dvdGeneral_Name := 48
    static dvdGeneral_Comments := 49
    static dvdTitle_Series := 56
    static dvdTitle_Movie := 57
    static dvdTitle_Video := 58
    static dvdTitle_Album := 59
    static dvdTitle_Song := 60
    static dvdTitle_Other := 63
    static dvdTitle_Sub_Series := 64
    static dvdTitle_Sub_Movie := 65
    static dvdTitle_Sub_Video := 66
    static dvdTitle_Sub_Album := 67
    static dvdTitle_Sub_Song := 68
    static dvdTitle_Sub_Other := 71
    static dvdTitle_Orig_Series := 72
    static dvdTitle_Orig_Movie := 73
    static dvdTitle_Orig_Video := 74
    static dvdTitle_Orig_Album := 75
    static dvdTitle_Orig_Song := 76
    static dvdTitle_Orig_Other := 79
    static dvdOther_Scene := 80
    static dvdOther_Cut := 81
    static dvdOther_Take := 82
}
struct DVDSPExt extends Int32 {
    static dvdSPExt_NotSpecified := 0
    static dvdSPExt_Caption_Normal := 1
    static dvdSPExt_Caption_Big := 2
    static dvdSPExt_Caption_Children := 3
    static dvdSPExt_CC_Normal := 5
    static dvdSPExt_CC_Big := 6
    static dvdSPExt_CC_Children := 7
    static dvdSPExt_Forced := 9
    static dvdSPExt_DirectorComments_Normal := 13
    static dvdSPExt_DirectorComments_Big := 14
    static dvdSPExt_DirectorComments_Children := 15
}
struct IMSVidWebDVD extends IMSVidPlayback {
    static IID := "{CF45F88B-AC56-4EE2-A73A-ED04E2885D3C}"
    OnDVDEvent(lEvent, lParam1, lParam2)
      => ComCall(32, this.p, Int32, lEvent, IntPtr, lParam1, IntPtr, lParam2)
    PlayTitle(lTitle)
      => ComCall(33, this.p, Int32, lTitle)
    PlayChapterInTitle(lTitle, lChapter)
      => ComCall(34, this.p, Int32, lTitle, Int32, lChapter)
    PlayChapter(lChapter)
      => ComCall(35, this.p, Int32, lChapter)
    PlayChaptersAutoStop(lTitle, lstrChapter, lChapterCount)
      => ComCall(36, this.p, Int32, lTitle, Int32, lstrChapter, Int32, lChapterCount)
    PlayAtTime(strTime)
      => ComCall(37, this.p, BSTR, strTime)
    PlayAtTimeInTitle(lTitle, strTime)
      => ComCall(38, this.p, Int32, lTitle, BSTR, strTime)
    PlayPeriodInTitleAutoStop(lTitle, strStartTime, strEndTime)
      => ComCall(39, this.p, Int32, lTitle, BSTR, strStartTime, BSTR, strEndTime)
    ReplayChapter()
      => ComCall(40, this.p)
    PlayPrevChapter()
      => ComCall(41, this.p)
    PlayNextChapter()
      => ComCall(42, this.p)
    StillOff()
      => ComCall(43, this.p)
    get_AudioLanguage(lStream, fFormat, strAudioLang)
      => ComCall(44, this.p, Int32, lStream, VARIANT_BOOL, fFormat, BSTR.Ptr, strAudioLang)
    ShowMenu(MenuID)
      => ComCall(45, this.p, DVDMenuIDConstants, MenuID)
    Resume()
      => ComCall(46, this.p)
    ReturnFromSubmenu()
      => ComCall(47, this.p)
    get_ButtonsAvailable(pVal)
      => ComCall(48, this.p, Int32.Ptr, pVal)
    get_CurrentButton(pVal)
      => ComCall(49, this.p, Int32.Ptr, pVal)
    SelectAndActivateButton(lButton)
      => ComCall(50, this.p, Int32, lButton)
    ActivateButton()
      => ComCall(51, this.p)
    SelectRightButton()
      => ComCall(52, this.p)
    SelectLeftButton()
      => ComCall(53, this.p)
    SelectLowerButton()
      => ComCall(54, this.p)
    SelectUpperButton()
      => ComCall(55, this.p)
    ActivateAtPosition(xPos, yPos)
      => ComCall(56, this.p, Int32, xPos, Int32, yPos)
    SelectAtPosition(xPos, yPos)
      => ComCall(57, this.p, Int32, xPos, Int32, yPos)
    get_ButtonAtPosition(xPos, yPos, plButton)
      => ComCall(58, this.p, Int32, xPos, Int32, yPos, Int32.Ptr, plButton)
    get_NumberOfChapters(lTitle, pVal)
      => ComCall(59, this.p, Int32, lTitle, Int32.Ptr, pVal)
    get_TotalTitleTime(pVal)
      => ComCall(60, this.p, BSTR.Ptr, pVal)
    get_TitlesAvailable(pVal)
      => ComCall(61, this.p, Int32.Ptr, pVal)
    get_VolumesAvailable(pVal)
      => ComCall(62, this.p, Int32.Ptr, pVal)
    get_CurrentVolume(pVal)
      => ComCall(63, this.p, Int32.Ptr, pVal)
    get_CurrentDiscSide(pVal)
      => ComCall(64, this.p, Int32.Ptr, pVal)
    get_CurrentDomain(pVal)
      => ComCall(65, this.p, Int32.Ptr, pVal)
    get_CurrentChapter(pVal)
      => ComCall(66, this.p, Int32.Ptr, pVal)
    get_CurrentTitle(pVal)
      => ComCall(67, this.p, Int32.Ptr, pVal)
    get_CurrentTime(pVal)
      => ComCall(68, this.p, BSTR.Ptr, pVal)
    DVDTimeCode2bstr(timeCode, pTimeStr)
      => ComCall(69, this.p, Int32, timeCode, BSTR.Ptr, pTimeStr)
    get_DVDDirectory(pVal)
      => ComCall(70, this.p, BSTR.Ptr, pVal)
    put_DVDDirectory(newVal)
      => ComCall(71, this.p, BSTR, newVal)
    IsSubpictureStreamEnabled(lstream, fEnabled)
      => ComCall(72, this.p, Int32, lstream, VARIANT_BOOL.Ptr, fEnabled)
    IsAudioStreamEnabled(lstream, fEnabled)
      => ComCall(73, this.p, Int32, lstream, VARIANT_BOOL.Ptr, fEnabled)
    get_CurrentSubpictureStream(pVal)
      => ComCall(74, this.p, Int32.Ptr, pVal)
    put_CurrentSubpictureStream(newVal)
      => ComCall(75, this.p, Int32, newVal)
    get_SubpictureLanguage(lStream, strLanguage)
      => ComCall(76, this.p, Int32, lStream, BSTR.Ptr, strLanguage)
    get_CurrentAudioStream(pVal)
      => ComCall(77, this.p, Int32.Ptr, pVal)
    put_CurrentAudioStream(newVal)
      => ComCall(78, this.p, Int32, newVal)
    get_AudioStreamsAvailable(pVal)
      => ComCall(79, this.p, Int32.Ptr, pVal)
    get_AnglesAvailable(pVal)
      => ComCall(80, this.p, Int32.Ptr, pVal)
    get_CurrentAngle(pVal)
      => ComCall(81, this.p, Int32.Ptr, pVal)
    put_CurrentAngle(newVal)
      => ComCall(82, this.p, Int32, newVal)
    get_SubpictureStreamsAvailable(pVal)
      => ComCall(83, this.p, Int32.Ptr, pVal)
    get_SubpictureOn(pVal)
      => ComCall(84, this.p, VARIANT_BOOL.Ptr, pVal)
    put_SubpictureOn(newVal)
      => ComCall(85, this.p, VARIANT_BOOL, newVal)
    get_DVDUniqueID(pVal)
      => ComCall(86, this.p, BSTR.Ptr, pVal)
    AcceptParentalLevelChange(fAccept, strUserName, strPassword)
      => ComCall(87, this.p, VARIANT_BOOL, fAccept, BSTR, strUserName, BSTR, strPassword)
    NotifyParentalLevelChange(newVal)
      => ComCall(88, this.p, VARIANT_BOOL, newVal)
    SelectParentalCountry(lCountry, strUserName, strPassword)
      => ComCall(89, this.p, Int32, lCountry, BSTR, strUserName, BSTR, strPassword)
    SelectParentalLevel(lParentalLevel, strUserName, strPassword)
      => ComCall(90, this.p, Int32, lParentalLevel, BSTR, strUserName, BSTR, strPassword)
    get_TitleParentalLevels(lTitle, plParentalLevels)
      => ComCall(91, this.p, Int32, lTitle, Int32.Ptr, plParentalLevels)
    get_PlayerParentalCountry(plCountryCode)
      => ComCall(92, this.p, Int32.Ptr, plCountryCode)
    get_PlayerParentalLevel(plParentalLevel)
      => ComCall(93, this.p, Int32.Ptr, plParentalLevel)
    Eject()
      => ComCall(94, this.p)
    UOPValid(lUOP, pfValid)
      => ComCall(95, this.p, Int32, lUOP, VARIANT_BOOL.Ptr, pfValid)
    get_SPRM(lIndex, psSPRM)
      => ComCall(96, this.p, Int32, lIndex, Int16.Ptr, psSPRM)
    get_GPRM(lIndex, psSPRM)
      => ComCall(97, this.p, Int32, lIndex, Int16.Ptr, psSPRM)
    put_GPRM(lIndex, sValue)
      => ComCall(98, this.p, Int32, lIndex, Int16, sValue)
    get_DVDTextStringType(lLangIndex, lStringIndex, pType)
      => ComCall(99, this.p, Int32, lLangIndex, Int32, lStringIndex, DVDTextStringType.Ptr, pType)
    get_DVDTextString(lLangIndex, lStringIndex, pstrText)
      => ComCall(100, this.p, Int32, lLangIndex, Int32, lStringIndex, BSTR.Ptr, pstrText)
    get_DVDTextNumberOfStrings(lLangIndex, plNumOfStrings)
      => ComCall(101, this.p, Int32, lLangIndex, Int32.Ptr, plNumOfStrings)
    get_DVDTextNumberOfLanguages(plNumOfLangs)
      => ComCall(102, this.p, Int32.Ptr, plNumOfLangs)
    get_DVDTextLanguageLCID(lLangIndex, lcid)
      => ComCall(103, this.p, Int32, lLangIndex, Int32.Ptr, lcid)
    RegionChange()
      => ComCall(104, this.p)
    get_DVDAdm(pVal)
      => ComCall(105, this.p, IDispatch.Ptr, pVal)
    DeleteBookmark()
      => ComCall(106, this.p)
    RestoreBookmark()
      => ComCall(107, this.p)
    SaveBookmark()
      => ComCall(108, this.p)
    SelectDefaultAudioLanguage(lang, ext)
      => ComCall(109, this.p, Int32, lang, Int32, ext)
    SelectDefaultSubpictureLanguage(lang, ext)
      => ComCall(110, this.p, Int32, lang, DVDSPExt, ext)
    get_PreferredSubpictureStream(pVal)
      => ComCall(111, this.p, Int32.Ptr, pVal)
    get_DefaultMenuLanguage(lang)
      => ComCall(112, this.p, Int32.Ptr, lang)
    put_DefaultMenuLanguage(lang)
      => ComCall(113, this.p, Int32, lang)
    get_DefaultSubpictureLanguage(lang)
      => ComCall(114, this.p, Int32.Ptr, lang)
    get_DefaultAudioLanguage(lang)
      => ComCall(115, this.p, Int32.Ptr, lang)
    get_DefaultSubpictureLanguageExt(ext)
      => ComCall(116, this.p, DVDSPExt.Ptr, ext)
    get_DefaultAudioLanguageExt(ext)
      => ComCall(117, this.p, Int32.Ptr, ext)
    get_LanguageFromLCID(lcid, lang)
      => ComCall(118, this.p, Int32, lcid, BSTR.Ptr, lang)
    get_KaraokeAudioPresentationMode(pVal)
      => ComCall(119, this.p, Int32.Ptr, pVal)
    put_KaraokeAudioPresentationMode(newVal)
      => ComCall(120, this.p, Int32, newVal)
    get_KaraokeChannelContent(lStream, lChan, lContent)
      => ComCall(121, this.p, Int32, lStream, Int32, lChan, Int32.Ptr, lContent)
    get_KaraokeChannelAssignment(lStream, lChannelAssignment)
      => ComCall(122, this.p, Int32, lStream, Int32.Ptr, lChannelAssignment)
    RestorePreferredSettings()
      => ComCall(123, this.p)
    get_ButtonRect(lButton, pRect)
      => ComCall(124, this.p, Int32, lButton, IMSVidRect.Ptr, pRect)
    get_DVDScreenInMouseCoordinates(ppRect)
      => ComCall(125, this.p, IMSVidRect.Ptr, ppRect)
    put_DVDScreenInMouseCoordinates(pRect)
      => ComCall(126, this.p, IMSVidRect, pRect)
}
struct IMSVidWebDVD2 extends IMSVidWebDVD {
    static IID := "{7027212F-EE9A-4A7C-8B67-F023714CDAFF}"
    get_Bookmark(ppData)
      => ComCall(127, this.p, UInt8.Ptr.Ptr, ppData, UInt32.Ptr, ppData.Length)
    put_Bookmark(pData, dwDataLength)
      => ComCall(128, this.p, UInt8.Ptr, pData, UInt32, dwDataLength)
}
struct IMSVidWebDVDEvent extends IMSVidPlaybackEvent {
    static IID := "{B4F7A674-9B83-49CB-A357-C63B871BE958}"
    DVDNotify(lEventCode, lParam1, lParam2)
      => ComCall(8, this.p, Int32, lEventCode, VARIANT, lParam1, VARIANT, lParam2)
    PlayForwards(bEnabled)
      => ComCall(9, this.p, VARIANT_BOOL, bEnabled)
    PlayBackwards(bEnabled)
      => ComCall(10, this.p, VARIANT_BOOL, bEnabled)
    ShowMenu(MenuID, bEnabled)
      => ComCall(11, this.p, DVDMenuIDConstants, MenuID, VARIANT_BOOL, bEnabled)
    Resume(bEnabled)
      => ComCall(12, this.p, VARIANT_BOOL, bEnabled)
    SelectOrActivateButton(bEnabled)
      => ComCall(13, this.p, VARIANT_BOOL, bEnabled)
    StillOff(bEnabled)
      => ComCall(14, this.p, VARIANT_BOOL, bEnabled)
    PauseOn(bEnabled)
      => ComCall(15, this.p, VARIANT_BOOL, bEnabled)
    ChangeCurrentAudioStream(bEnabled)
      => ComCall(16, this.p, VARIANT_BOOL, bEnabled)
    ChangeCurrentSubpictureStream(bEnabled)
      => ComCall(17, this.p, VARIANT_BOOL, bEnabled)
    ChangeCurrentAngle(bEnabled)
      => ComCall(18, this.p, VARIANT_BOOL, bEnabled)
    PlayAtTimeInTitle(bEnabled)
      => ComCall(19, this.p, VARIANT_BOOL, bEnabled)
    PlayAtTime(bEnabled)
      => ComCall(20, this.p, VARIANT_BOOL, bEnabled)
    PlayChapterInTitle(bEnabled)
      => ComCall(21, this.p, VARIANT_BOOL, bEnabled)
    PlayChapter(bEnabled)
      => ComCall(22, this.p, VARIANT_BOOL, bEnabled)
    ReplayChapter(bEnabled)
      => ComCall(23, this.p, VARIANT_BOOL, bEnabled)
    PlayNextChapter(bEnabled)
      => ComCall(24, this.p, VARIANT_BOOL, bEnabled)
    Stop(bEnabled)
      => ComCall(25, this.p, VARIANT_BOOL, bEnabled)
    ReturnFromSubmenu(bEnabled)
      => ComCall(26, this.p, VARIANT_BOOL, bEnabled)
    PlayTitle(bEnabled)
      => ComCall(27, this.p, VARIANT_BOOL, bEnabled)
    PlayPrevChapter(bEnabled)
      => ComCall(28, this.p, VARIANT_BOOL, bEnabled)
    ChangeKaraokePresMode(bEnabled)
      => ComCall(29, this.p, VARIANT_BOOL, bEnabled)
    ChangeVideoPresMode(bEnabled)
      => ComCall(30, this.p, VARIANT_BOOL, bEnabled)
}
struct IMSVidWebDVDAdm extends IDispatch {
    static IID := "{B8BE681A-EB2C-47F0-B415-94D5452F0E05}"
    ChangePassword(strUserName, strOld, strNew)
      => ComCall(7, this.p, BSTR, strUserName, BSTR, strOld, BSTR, strNew)
    SaveParentalLevel(level, strUserName, strPassword)
      => ComCall(8, this.p, Int32, level, BSTR, strUserName, BSTR, strPassword)
    SaveParentalCountry(country, strUserName, strPassword)
      => ComCall(9, this.p, Int32, country, BSTR, strUserName, BSTR, strPassword)
    ConfirmPassword(strUserName, strPassword, pVal)
      => ComCall(10, this.p, BSTR, strUserName, BSTR, strPassword, VARIANT_BOOL.Ptr, pVal)
    GetParentalLevel(lLevel)
      => ComCall(11, this.p, Int32.Ptr, lLevel)
    GetParentalCountry(lCountry)
      => ComCall(12, this.p, Int32.Ptr, lCountry)
    get_DefaultAudioLCID(pVal)
      => ComCall(13, this.p, Int32.Ptr, pVal)
    put_DefaultAudioLCID(newVal)
      => ComCall(14, this.p, Int32, newVal)
    get_DefaultSubpictureLCID(pVal)
      => ComCall(15, this.p, Int32.Ptr, pVal)
    put_DefaultSubpictureLCID(newVal)
      => ComCall(16, this.p, Int32, newVal)
    get_DefaultMenuLCID(pVal)
      => ComCall(17, this.p, Int32.Ptr, pVal)
    put_DefaultMenuLCID(newVal)
      => ComCall(18, this.p, Int32, newVal)
    get_BookmarkOnStop(pVal)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, pVal)
    put_BookmarkOnStop(newVal)
      => ComCall(20, this.p, VARIANT_BOOL, newVal)
}
struct IMSVidOutputDevice extends IMSVidDevice {
    static IID := "{37B03546-A4C8-11D2-B634-00C04F79498E}"
}
struct IMSVidOutputDeviceEvent extends IMSVidDeviceEvent {
    static IID := "{2E6A14E2-571C-11D3-B652-00C04F79498E}"
}
struct IMSVidFeature extends IMSVidDevice {
    static IID := "{37B03547-A4C8-11D2-B634-00C04F79498E}"
}
struct IMSVidFeatureEvent extends IMSVidDeviceEvent {
    static IID := "{3DD2903C-E0AA-11D2-B63A-00C04F79498E}"
}
struct IMSVidEncoder extends IMSVidFeature {
    static IID := "{C0020FD4-BEE7-43D9-A495-9F213117103D}"
    get_VideoEncoderInterface(ppEncInt)
      => ComCall(16, this.p, IUnknown.Ptr, ppEncInt)
    get_AudioEncoderInterface(ppEncInt)
      => ComCall(17, this.p, IUnknown.Ptr, ppEncInt)
}
struct IMSVidClosedCaptioning extends IMSVidFeature {
    static IID := "{99652EA1-C1F7-414F-BB7B-1C967DE75983}"
    get_Enable(On)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, On)
    put_Enable(On)
      => ComCall(17, this.p, VARIANT_BOOL, On)
}
struct IMSVidClosedCaptioning2 extends IMSVidClosedCaptioning {
    static IID := "{E00CB864-A029-4310-9987-A873F5887D97}"
    get_Service(On)
      => ComCall(18, this.p, MSVidCCService.Ptr, On)
    put_Service(On)
      => ComCall(19, this.p, MSVidCCService, On)
}
struct IMSVidClosedCaptioning3 extends IMSVidClosedCaptioning2 {
    static IID := "{C8638E8A-7625-4C51-9366-2F40A9831FC0}"
    get_TeleTextFilter(punkTTFilter)
      => ComCall(20, this.p, IUnknown.Ptr, punkTTFilter)
}
struct IMSVidXDS extends IMSVidFeature {
    static IID := "{11EBC158-E712-4D1F-8BB3-01ED5274C4CE}"
    get_ChannelChangeInterface(punkCC)
      => ComCall(16, this.p, IUnknown.Ptr, punkCC)
}
struct IMSVidXDSEvent extends IMSVidFeatureEvent {
    static IID := "{6DB2317D-3B23-41EC-BA4B-701F407EAF3A}"
    RatingChange(PrevRatingSystem, PrevLevel, PrevAttributes, NewRatingSystem, NewLevel, NewAttributes)
      => ComCall(8, this.p, EnTvRat_System, PrevRatingSystem, EnTvRat_GenericLevel, PrevLevel, BfEnTvRat_GenericAttributes, PrevAttributes, EnTvRat_System, NewRatingSystem, EnTvRat_GenericLevel, NewLevel, BfEnTvRat_GenericAttributes, NewAttributes)
}
struct IMSVidDataServices extends IMSVidFeature {
    static IID := "{334125C1-77E5-11D3-B653-00C04F79498E}"
}
struct IMSVidDataServicesEvent extends IMSVidDeviceEvent {
    static IID := "{334125C2-77E5-11D3-B653-00C04F79498E}"
}
struct SourceSizeList extends Int32 {
    static sslFullSize := 0
    static sslClipByOverScan := 1
    static sslClipByClipRect := 2
}
struct IMSVidVideoRenderer extends IMSVidOutputDevice {
    static IID := "{37B03540-A4C8-11D2-B634-00C04F79498E}"
    get_CustomCompositorClass(CompositorCLSID)
      => ComCall(16, this.p, BSTR.Ptr, CompositorCLSID)
    put_CustomCompositorClass(CompositorCLSID)
      => ComCall(17, this.p, BSTR, CompositorCLSID)
    get__CustomCompositorClass(CompositorCLSID)
      => ComCall(18, this.p, GUID.Ptr, CompositorCLSID)
    put__CustomCompositorClass(CompositorCLSID)
      => ComCall(19, this.p, GUID.Ptr, CompositorCLSID)
    get__CustomCompositor(Compositor)
      => ComCall(20, this.p, IVMRImageCompositor.Ptr, Compositor)
    put__CustomCompositor(Compositor)
      => ComCall(21, this.p, IVMRImageCompositor, Compositor)
    get_MixerBitmap(MixerPictureDisp)
      => ComCall(22, this.p, IPictureDisp.Ptr, MixerPictureDisp)
    get__MixerBitmap(MixerPicture)
      => ComCall(23, this.p, IVMRMixerBitmap.Ptr, MixerPicture)
    put_MixerBitmap(MixerPictureDisp)
      => ComCall(24, this.p, IPictureDisp, MixerPictureDisp)
    put__MixerBitmap(MixerPicture)
      => ComCall(25, this.p, VMRALPHABITMAP.Ptr, MixerPicture)
    get_MixerBitmapPositionRect(rDest)
      => ComCall(26, this.p, IMSVidRect.Ptr, rDest)
    put_MixerBitmapPositionRect(rDest)
      => ComCall(27, this.p, IMSVidRect, rDest)
    get_MixerBitmapOpacity(opacity)
      => ComCall(28, this.p, Int32.Ptr, opacity)
    put_MixerBitmapOpacity(opacity)
      => ComCall(29, this.p, Int32, opacity)
    SetupMixerBitmap(MixerPictureDisp, Opacity, rDest)
      => ComCall(30, this.p, IPictureDisp, MixerPictureDisp, Int32, Opacity, IMSVidRect, rDest)
    get_SourceSize(CurrentSize)
      => ComCall(31, this.p, SourceSizeList.Ptr, CurrentSize)
    put_SourceSize(NewSize)
      => ComCall(32, this.p, SourceSizeList, NewSize)
    get_OverScan(plPercent)
      => ComCall(33, this.p, Int32.Ptr, plPercent)
    put_OverScan(lPercent)
      => ComCall(34, this.p, Int32, lPercent)
    get_AvailableSourceRect(pRect)
      => ComCall(35, this.p, IMSVidRect.Ptr, pRect)
    get_MaxVidRect(ppVidRect)
      => ComCall(36, this.p, IMSVidRect.Ptr, ppVidRect)
    get_MinVidRect(ppVidRect)
      => ComCall(37, this.p, IMSVidRect.Ptr, ppVidRect)
    get_ClippedSourceRect(pRect)
      => ComCall(38, this.p, IMSVidRect.Ptr, pRect)
    put_ClippedSourceRect(pRect)
      => ComCall(39, this.p, IMSVidRect, pRect)
    get_UsingOverlay(UseOverlayVal)
      => ComCall(40, this.p, VARIANT_BOOL.Ptr, UseOverlayVal)
    put_UsingOverlay(UseOverlayVal)
      => ComCall(41, this.p, VARIANT_BOOL, UseOverlayVal)
    Capture(currentImage)
      => ComCall(42, this.p, IPictureDisp.Ptr, currentImage)
    get_FramesPerSecond(pVal)
      => ComCall(43, this.p, Int32.Ptr, pVal)
    get_DecimateInput(pDeci)
      => ComCall(44, this.p, VARIANT_BOOL.Ptr, pDeci)
    put_DecimateInput(pDeci)
      => ComCall(45, this.p, VARIANT_BOOL, pDeci)
}
struct IMSVidVideoRendererEvent extends IMSVidOutputDeviceEvent {
    static IID := "{37B03545-A4C8-11D2-B634-00C04F79498E}"
    OverlayUnavailable()
      => ComCall(8, this.p)
}
struct IMSVidGenericSink extends IMSVidOutputDevice {
    static IID := "{6C29B41D-455B-4C33-963A-0D28E5E555EA}"
    SetSinkFilter(bstrName)
      => ComCall(16, this.p, BSTR, bstrName)
    get_SinkStreams(pStreams)
      => ComCall(17, this.p, MSVidSinkStreams.Ptr, pStreams)
    put_SinkStreams(Streams)
      => ComCall(18, this.p, MSVidSinkStreams, Streams)
}
struct IMSVidGenericSink2 extends IMSVidGenericSink {
    static IID := "{6B5A28F3-47F1-4092-B168-60CABEC08F1C}"
    AddFilter(bstrName)
      => ComCall(19, this.p, BSTR, bstrName)
    ResetFilterList()
      => ComCall(20, this.p)
}
struct IMSVidStreamBufferRecordingControl extends IDispatch {
    static IID := "{160621AA-BBBC-4326-A824-C395AEBC6E74}"
    get_StartTime(rtStart)
      => ComCall(7, this.p, Int32.Ptr, rtStart)
    put_StartTime(rtStart)
      => ComCall(8, this.p, Int32, rtStart)
    get_StopTime(rtStop)
      => ComCall(9, this.p, Int32.Ptr, rtStop)
    put_StopTime(rtStop)
      => ComCall(10, this.p, Int32, rtStop)
    get_RecordingStopped(phResult)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, phResult)
    get_RecordingStarted(phResult)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, phResult)
    get_RecordingType(dwType)
      => ComCall(13, this.p, RecordingType.Ptr, dwType)
    get_RecordingAttribute(pRecordingAttribute)
      => ComCall(14, this.p, IUnknown.Ptr, pRecordingAttribute)
}
struct IMSVidStreamBufferSink extends IMSVidOutputDevice {
    static IID := "{159DBB45-CD1B-4DAB-83EA-5CB1F4F21D07}"
    get_ContentRecorder(pszFilename, pRecordingIUnknown)
      => ComCall(16, this.p, BSTR, pszFilename, IMSVidStreamBufferRecordingControl.Ptr, pRecordingIUnknown)
    get_ReferenceRecorder(pszFilename, pRecordingIUnknown)
      => ComCall(17, this.p, BSTR, pszFilename, IMSVidStreamBufferRecordingControl.Ptr, pRecordingIUnknown)
    get_SinkName(pName)
      => ComCall(18, this.p, BSTR.Ptr, pName)
    put_SinkName(Name)
      => ComCall(19, this.p, BSTR, Name)
    NameSetLock()
      => ComCall(20, this.p)
    get_SBESink(sbeConfig)
      => ComCall(21, this.p, IUnknown.Ptr, sbeConfig)
}
struct IMSVidStreamBufferSink2 extends IMSVidStreamBufferSink {
    static IID := "{2CA9FC63-C131-4E5A-955A-544A47C67146}"
    UnlockProfile()
      => ComCall(22, this.p)
}
struct IMSVidStreamBufferSink3 extends IMSVidStreamBufferSink2 {
    static IID := "{4F8721D7-7D59-4D8B-99F5-A77775586BD5}"
    SetMinSeek(pdwMin)
      => ComCall(23, this.p, Int32.Ptr, pdwMin)
    get_AudioCounter(ppUnk)
      => ComCall(24, this.p, IUnknown.Ptr, ppUnk)
    get_VideoCounter(ppUnk)
      => ComCall(25, this.p, IUnknown.Ptr, ppUnk)
    get_CCCounter(ppUnk)
      => ComCall(26, this.p, IUnknown.Ptr, ppUnk)
    get_WSTCounter(ppUnk)
      => ComCall(27, this.p, IUnknown.Ptr, ppUnk)
    put_AudioAnalysisFilter(szCLSID)
      => ComCall(28, this.p, BSTR, szCLSID)
    get_AudioAnalysisFilter(pszCLSID)
      => ComCall(29, this.p, BSTR.Ptr, pszCLSID)
    put__AudioAnalysisFilter(guid1)
      => ComCall(30, this.p, GUID, guid1)
    get__AudioAnalysisFilter(pGuid)
      => ComCall(31, this.p, GUID.Ptr, pGuid)
    put_VideoAnalysisFilter(szCLSID)
      => ComCall(32, this.p, BSTR, szCLSID)
    get_VideoAnalysisFilter(pszCLSID)
      => ComCall(33, this.p, BSTR.Ptr, pszCLSID)
    put__VideoAnalysisFilter(guid1)
      => ComCall(34, this.p, GUID, guid1)
    get__VideoAnalysisFilter(pGuid)
      => ComCall(35, this.p, GUID.Ptr, pGuid)
    put_DataAnalysisFilter(szCLSID)
      => ComCall(36, this.p, BSTR, szCLSID)
    get_DataAnalysisFilter(pszCLSID)
      => ComCall(37, this.p, BSTR.Ptr, pszCLSID)
    put__DataAnalysisFilter(guid1)
      => ComCall(38, this.p, GUID, guid1)
    get__DataAnalysisFilter(pGuid)
      => ComCall(39, this.p, GUID.Ptr, pGuid)
    get_LicenseErrorCode(hres)
      => ComCall(40, this.p, HRESULT.Ptr, hres)
}
struct IMSVidStreamBufferSinkEvent extends IMSVidOutputDeviceEvent {
    static IID := "{F798A36B-B05B-4BBE-9703-EAEA7D61CD51}"
    CertificateFailure()
      => ComCall(8, this.p)
    CertificateSuccess()
      => ComCall(9, this.p)
    WriteFailure()
      => ComCall(10, this.p)
}
struct IMSVidStreamBufferSinkEvent2 extends IMSVidStreamBufferSinkEvent {
    static IID := "{3D7A5166-72D7-484B-A06F-286187B80CA1}"
    EncryptionOn()
      => ComCall(11, this.p)
    EncryptionOff()
      => ComCall(12, this.p)
}
struct IMSVidStreamBufferSinkEvent3 extends IMSVidStreamBufferSinkEvent2 {
    static IID := "{735AD8D5-C259-48E9-81E7-D27953665B23}"
    LicenseChange(dwProt)
      => ComCall(13, this.p, Int32, dwProt)
}
struct IMSVidStreamBufferSinkEvent4 extends IMSVidStreamBufferSinkEvent3 {
    static IID := "{1B01DCB0-DAF0-412C-A5D1-590C7F62E2B8}"
    WriteFailureClear()
      => ComCall(14, this.p)
}
struct IMSVidStreamBufferSource extends IMSVidFilePlayback {
    static IID := "{EB0C8CF9-6950-4772-87B1-47D11CF3A02F}"
    get_Start(lStart)
      => ComCall(34, this.p, Int32.Ptr, lStart)
    get_RecordingAttribute(pRecordingAttribute)
      => ComCall(35, this.p, IUnknown.Ptr, pRecordingAttribute)
    CurrentRatings(pEnSystem, pEnRating, pBfEnAttr)
      => ComCall(36, this.p, EnTvRat_System.Ptr, pEnSystem, EnTvRat_GenericLevel.Ptr, pEnRating, Int32.Ptr, pBfEnAttr)
    MaxRatingsLevel(enSystem, enRating, lbfEnAttr)
      => ComCall(37, this.p, EnTvRat_System, enSystem, EnTvRat_GenericLevel, enRating, Int32, lbfEnAttr)
    put_BlockUnrated(bBlock)
      => ComCall(38, this.p, VARIANT_BOOL, bBlock)
    put_UnratedDelay(dwDelay)
      => ComCall(39, this.p, Int32, dwDelay)
    get_SBESource(sbeFilter)
      => ComCall(40, this.p, IUnknown.Ptr, sbeFilter)
}
struct IMSVidStreamBufferSource2 extends IMSVidStreamBufferSource {
    static IID := "{E4BA9059-B1CE-40D8-B9A0-D4EA4A9989D3}"
    put_RateEx(dwRate, dwFramesPerSecond)
      => ComCall(41, this.p, Float64, dwRate, UInt32, dwFramesPerSecond)
    get_AudioCounter(ppUnk)
      => ComCall(42, this.p, IUnknown.Ptr, ppUnk)
    get_VideoCounter(ppUnk)
      => ComCall(43, this.p, IUnknown.Ptr, ppUnk)
    get_CCCounter(ppUnk)
      => ComCall(44, this.p, IUnknown.Ptr, ppUnk)
    get_WSTCounter(ppUnk)
      => ComCall(45, this.p, IUnknown.Ptr, ppUnk)
}
struct IMSVidStreamBufferSourceEvent extends IMSVidFilePlaybackEvent {
    static IID := "{50CE8A7D-9C28-4DA8-9042-CDFA7116F979}"
    CertificateFailure()
      => ComCall(8, this.p)
    CertificateSuccess()
      => ComCall(9, this.p)
    RatingsBlocked()
      => ComCall(10, this.p)
    RatingsUnblocked()
      => ComCall(11, this.p)
    RatingsChanged()
      => ComCall(12, this.p)
    TimeHole(StreamOffsetMS, SizeMS)
      => ComCall(13, this.p, Int32, StreamOffsetMS, Int32, SizeMS)
    StaleDataRead()
      => ComCall(14, this.p)
    ContentBecomingStale()
      => ComCall(15, this.p)
    StaleFileDeleted()
      => ComCall(16, this.p)
}
struct IMSVidStreamBufferSourceEvent2 extends IMSVidStreamBufferSourceEvent {
    static IID := "{7AEF50CE-8E22-4BA8-BC06-A92A458B4EF2}"
    RateChange(qwNewRate, qwOldRate)
      => ComCall(17, this.p, Float64, qwNewRate, Float64, qwOldRate)
}
struct IMSVidStreamBufferSourceEvent3 extends IMSVidStreamBufferSourceEvent2 {
    static IID := "{CEABD6AB-9B90-4570-ADF1-3CE76E00A763}"
    BroadcastEvent(Guid)
      => ComCall(18, this.p, BSTR, Guid)
    BroadcastEventEx(Guid, Param1, Param2, Param3, Param4)
      => ComCall(19, this.p, BSTR, Guid, UInt32, Param1, UInt32, Param2, UInt32, Param3, UInt32, Param4)
    COPPBlocked()
      => ComCall(20, this.p)
    COPPUnblocked()
      => ComCall(21, this.p)
    ContentPrimarilyAudio()
      => ComCall(22, this.p)
}
struct IMSVidStreamBufferV2SourceEvent extends IMSVidFilePlaybackEvent {
    static IID := "{49C771F9-41B2-4CF7-9F9A-A313A8F6027E}"
    RatingsChanged()
      => ComCall(8, this.p)
    TimeHole(StreamOffsetMS, SizeMS)
      => ComCall(9, this.p, Int32, StreamOffsetMS, Int32, SizeMS)
    StaleDataRead()
      => ComCall(10, this.p)
    ContentBecomingStale()
      => ComCall(11, this.p)
    StaleFileDeleted()
      => ComCall(12, this.p)
    RateChange(qwNewRate, qwOldRate)
      => ComCall(13, this.p, Float64, qwNewRate, Float64, qwOldRate)
    BroadcastEvent(Guid)
      => ComCall(14, this.p, BSTR, Guid)
    BroadcastEventEx(Guid, Param1, Param2, Param3, Param4)
      => ComCall(15, this.p, BSTR, Guid, UInt32, Param1, UInt32, Param2, UInt32, Param3, UInt32, Param4)
    ContentPrimarilyAudio()
      => ComCall(16, this.p)
}
struct IMSVidVideoRenderer2 extends IMSVidVideoRenderer {
    static IID := "{6BDD5C1E-2810-4159-94BC-05511AE8549B}"
    get_Allocator(AllocPresent)
      => ComCall(46, this.p, IUnknown.Ptr, AllocPresent)
    get__Allocator(AllocPresent)
      => ComCall(47, this.p, IVMRSurfaceAllocator.Ptr, AllocPresent)
    get_Allocator_ID(ID)
      => ComCall(48, this.p, Int32.Ptr, ID)
    SetAllocator(AllocPresent, ID)
      => ComCall(49, this.p, IUnknown, AllocPresent, Int32, ID)
    _SetAllocator2(AllocPresent, ID)
      => ComCall(50, this.p, IVMRSurfaceAllocator, AllocPresent, Int32, ID)
    put_SuppressEffects(bSuppress)
      => ComCall(51, this.p, VARIANT_BOOL, bSuppress)
    get_SuppressEffects(bSuppress)
      => ComCall(52, this.p, VARIANT_BOOL.Ptr, bSuppress)
}
struct IMSVidVideoRendererEvent2 extends IMSVidOutputDeviceEvent {
    static IID := "{7145ED66-4730-4FDB-8A53-FDE7508D3E5E}"
    OverlayUnavailable()
      => ComCall(8, this.p)
}
struct IMSVidVMR9 extends IMSVidVideoRenderer {
    static IID := "{D58B0015-EBEF-44BB-BBDD-3F3699D76EA1}"
    get_Allocator_ID(ID)
      => ComCall(46, this.p, Int32.Ptr, ID)
    SetAllocator(AllocPresent, ID)
      => ComCall(47, this.p, IUnknown, AllocPresent, Int32, ID)
    put_SuppressEffects(bSuppress)
      => ComCall(48, this.p, VARIANT_BOOL, bSuppress)
    get_SuppressEffects(bSuppress)
      => ComCall(49, this.p, VARIANT_BOOL.Ptr, bSuppress)
    get_Allocator(AllocPresent)
      => ComCall(50, this.p, IUnknown.Ptr, AllocPresent)
}
struct IMSVidEVR extends IMSVidVideoRenderer {
    static IID := "{15E496AE-82A8-4CF9-A6B6-C561DC60398F}"
    get_Presenter(ppAllocPresent)
      => ComCall(46, this.p, IMFVideoPresenter.Ptr, ppAllocPresent)
    put_Presenter(pAllocPresent)
      => ComCall(47, this.p, IMFVideoPresenter, pAllocPresent)
    put_SuppressEffects(bSuppress)
      => ComCall(48, this.p, VARIANT_BOOL, bSuppress)
    get_SuppressEffects(bSuppress)
      => ComCall(49, this.p, VARIANT_BOOL.Ptr, bSuppress)
}
struct IMSVidEVREvent extends IMSVidOutputDeviceEvent {
    static IID := "{349ABB10-883C-4F22-8714-CECAEEE45D62}"
    OnUserEvent(lEventCode)
      => ComCall(8, this.p, Int32, lEventCode)
}
struct IMSVidAudioRenderer extends IMSVidOutputDevice {
    static IID := "{37B0353F-A4C8-11D2-B634-00C04F79498E}"
    put_Volume(lVol)
      => ComCall(16, this.p, Int32, lVol)
    get_Volume(lVol)
      => ComCall(17, this.p, Int32.Ptr, lVol)
    put_Balance(lBal)
      => ComCall(18, this.p, Int32, lBal)
    get_Balance(lBal)
      => ComCall(19, this.p, Int32.Ptr, lBal)
}
struct IMSVidAudioRendererEvent extends IMSVidOutputDeviceEvent {
    static IID := "{37B03541-A4C8-11D2-B634-00C04F79498E}"
}
struct IMSVidAudioRendererEvent2 extends IMSVidAudioRendererEvent {
    static IID := "{E3F55729-353B-4C43-A028-50F79AA9A907}"
    AVDecAudioDualMono()
      => ComCall(8, this.p)
    AVAudioSampleRate()
      => ComCall(9, this.p)
    AVAudioChannelConfig()
      => ComCall(10, this.p)
    AVAudioChannelCount()
      => ComCall(11, this.p)
    AVDecCommonMeanBitRate()
      => ComCall(12, this.p)
    AVDDSurroundMode()
      => ComCall(13, this.p)
    AVDecCommonInputFormat()
      => ComCall(14, this.p)
    AVDecCommonOutputFormat()
      => ComCall(15, this.p)
}
struct IMSVidInputDevices extends IDispatch {
    static IID := "{C5702CD1-9B79-11D3-B654-00C04F79498E}"
    get_Count(lCount)
      => ComCall(7, this.p, Int32.Ptr, lCount)
    get__NewEnum(pD)
      => ComCall(8, this.p, IEnumVARIANT.Ptr, pD)
    get_Item(v, pDB)
      => ComCall(9, this.p, VARIANT, v, IMSVidInputDevice.Ptr, pDB)
    Add(pDB)
      => ComCall(10, this.p, IMSVidInputDevice, pDB)
    Remove(v)
      => ComCall(11, this.p, VARIANT, v)
}
struct IMSVidOutputDevices extends IDispatch {
    static IID := "{C5702CD2-9B79-11D3-B654-00C04F79498E}"
    get_Count(lCount)
      => ComCall(7, this.p, Int32.Ptr, lCount)
    get__NewEnum(pD)
      => ComCall(8, this.p, IEnumVARIANT.Ptr, pD)
    get_Item(v, pDB)
      => ComCall(9, this.p, VARIANT, v, IMSVidOutputDevice.Ptr, pDB)
    Add(pDB)
      => ComCall(10, this.p, IMSVidOutputDevice, pDB)
    Remove(v)
      => ComCall(11, this.p, VARIANT, v)
}
struct IMSVidVideoRendererDevices extends IDispatch {
    static IID := "{C5702CD3-9B79-11D3-B654-00C04F79498E}"
    get_Count(lCount)
      => ComCall(7, this.p, Int32.Ptr, lCount)
    get__NewEnum(pD)
      => ComCall(8, this.p, IEnumVARIANT.Ptr, pD)
    get_Item(v, pDB)
      => ComCall(9, this.p, VARIANT, v, IMSVidVideoRenderer.Ptr, pDB)
    Add(pDB)
      => ComCall(10, this.p, IMSVidVideoRenderer, pDB)
    Remove(v)
      => ComCall(11, this.p, VARIANT, v)
}
struct IMSVidAudioRendererDevices extends IDispatch {
    static IID := "{C5702CD4-9B79-11D3-B654-00C04F79498E}"
    get_Count(lCount)
      => ComCall(7, this.p, Int32.Ptr, lCount)
    get__NewEnum(pD)
      => ComCall(8, this.p, IEnumVARIANT.Ptr, pD)
    get_Item(v, pDB)
      => ComCall(9, this.p, VARIANT, v, IMSVidAudioRenderer.Ptr, pDB)
    Add(pDB)
      => ComCall(10, this.p, IMSVidAudioRenderer, pDB)
    Remove(v)
      => ComCall(11, this.p, VARIANT, v)
}
struct IMSVidFeatures extends IDispatch {
    static IID := "{C5702CD5-9B79-11D3-B654-00C04F79498E}"
    get_Count(lCount)
      => ComCall(7, this.p, Int32.Ptr, lCount)
    get__NewEnum(pD)
      => ComCall(8, this.p, IEnumVARIANT.Ptr, pD)
    get_Item(v, pDB)
      => ComCall(9, this.p, VARIANT, v, IMSVidFeature.Ptr, pDB)
    Add(pDB)
      => ComCall(10, this.p, IMSVidFeature, pDB)
    Remove(v)
      => ComCall(11, this.p, VARIANT, v)
}
struct MSViddispidList extends Int32 {
    static dispidInputs := 0
    static dispidOutputs := 1
    static dispid_Inputs := 2
    static dispid_Outputs := 3
    static dispidVideoRenderers := 4
    static dispidAudioRenderers := 5
    static dispidFeatures := 6
    static dispidInput := 7
    static dispidOutput := 8
    static dispidVideoRenderer := 9
    static dispidAudioRenderer := 10
    static dispidSelectedFeatures := 11
    static dispidView := 12
    static dispidBuild := 13
    static dispidPause := 14
    static dispidRun := 15
    static dispidStop := 16
    static dispidDecompose := 17
    static dispidDisplaySize := 18
    static dispidMaintainAspectRatio := 19
    static dispidColorKey := 20
    static dispidStateChange := 21
    static dispidgetState := 22
    static dispidunbind := 23
    static dispidbind := 24
    static dispidDisableVideo := 25
    static dispidDisableAudio := 26
    static dispidViewNext := 27
    static dispidServiceP := 28
}
struct DisplaySizeList extends Int32 {
    static dslDefaultSize := 0
    static dslSourceSize := 0
    static dslHalfSourceSize := 1
    static dslDoubleSourceSize := 2
    static dslFullScreen := 3
    static dslHalfScreen := 4
    static dslQuarterScreen := 5
    static dslSixteenthScreen := 6
}
struct MSVidCtlStateList extends Int32 {
    static STATE_UNBUILT := -1
    static STATE_STOP := 0
    static STATE_PAUSE := 1
    static STATE_PLAY := 2
}
struct IMSVidCtl extends IDispatch {
    static IID := "{B0EDF162-910A-11D2-B632-00C04F79498E}"
    get_AutoSize(pbool)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pbool)
    put_AutoSize(vbool)
      => ComCall(8, this.p, VARIANT_BOOL, vbool)
    get_BackColor(backcolor)
      => ComCall(9, this.p, UInt32.Ptr, backcolor)
    put_BackColor(backcolor)
      => ComCall(10, this.p, UInt32, backcolor)
    get_Enabled(pbool)
      => ComCall(11, this.p, VARIANT_BOOL.Ptr, pbool)
    put_Enabled(vbool)
      => ComCall(12, this.p, VARIANT_BOOL, vbool)
    get_TabStop(pbool)
      => ComCall(13, this.p, VARIANT_BOOL.Ptr, pbool)
    put_TabStop(vbool)
      => ComCall(14, this.p, VARIANT_BOOL, vbool)
    get_Window(phwnd)
      => ComCall(15, this.p, HWND.Ptr, phwnd)
    Refresh()
      => ComCall(16, this.p)
    get_DisplaySize(CurrentValue)
      => ComCall(17, this.p, DisplaySizeList.Ptr, CurrentValue)
    put_DisplaySize(NewValue)
      => ComCall(18, this.p, DisplaySizeList, NewValue)
    get_MaintainAspectRatio(CurrentValue)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, CurrentValue)
    put_MaintainAspectRatio(NewValue)
      => ComCall(20, this.p, VARIANT_BOOL, NewValue)
    get_ColorKey(CurrentValue)
      => ComCall(21, this.p, UInt32.Ptr, CurrentValue)
    put_ColorKey(NewValue)
      => ComCall(22, this.p, UInt32, NewValue)
    get_InputsAvailable(CategoryGuid, pVal)
      => ComCall(23, this.p, BSTR, CategoryGuid, IMSVidInputDevices.Ptr, pVal)
    get_OutputsAvailable(CategoryGuid, pVal)
      => ComCall(24, this.p, BSTR, CategoryGuid, IMSVidOutputDevices.Ptr, pVal)
    get__InputsAvailable(CategoryGuid, pVal)
      => ComCall(25, this.p, GUID.Ptr, CategoryGuid, IMSVidInputDevices.Ptr, pVal)
    get__OutputsAvailable(CategoryGuid, pVal)
      => ComCall(26, this.p, GUID.Ptr, CategoryGuid, IMSVidOutputDevices.Ptr, pVal)
    get_VideoRenderersAvailable(pVal)
      => ComCall(27, this.p, IMSVidVideoRendererDevices.Ptr, pVal)
    get_AudioRenderersAvailable(pVal)
      => ComCall(28, this.p, IMSVidAudioRendererDevices.Ptr, pVal)
    get_FeaturesAvailable(pVal)
      => ComCall(29, this.p, IMSVidFeatures.Ptr, pVal)
    get_InputActive(pVal)
      => ComCall(30, this.p, IMSVidInputDevice.Ptr, pVal)
    put_InputActive(pVal)
      => ComCall(31, this.p, IMSVidInputDevice, pVal)
    get_OutputsActive(pVal)
      => ComCall(32, this.p, IMSVidOutputDevices.Ptr, pVal)
    put_OutputsActive(pVal)
      => ComCall(33, this.p, IMSVidOutputDevices, pVal)
    get_VideoRendererActive(pVal)
      => ComCall(34, this.p, IMSVidVideoRenderer.Ptr, pVal)
    put_VideoRendererActive(pVal)
      => ComCall(35, this.p, IMSVidVideoRenderer, pVal)
    get_AudioRendererActive(pVal)
      => ComCall(36, this.p, IMSVidAudioRenderer.Ptr, pVal)
    put_AudioRendererActive(pVal)
      => ComCall(37, this.p, IMSVidAudioRenderer, pVal)
    get_FeaturesActive(pVal)
      => ComCall(38, this.p, IMSVidFeatures.Ptr, pVal)
    put_FeaturesActive(pVal)
      => ComCall(39, this.p, IMSVidFeatures, pVal)
    get_State(lState)
      => ComCall(40, this.p, MSVidCtlStateList.Ptr, lState)
    View(v)
      => ComCall(41, this.p, VARIANT.Ptr, v)
    Build()
      => ComCall(42, this.p)
    Pause()
      => ComCall(43, this.p)
    Run()
      => ComCall(44, this.p)
    Stop()
      => ComCall(45, this.p)
    Decompose()
      => ComCall(46, this.p)
    DisableVideo()
      => ComCall(47, this.p)
    DisableAudio()
      => ComCall(48, this.p)
    ViewNext(v)
      => ComCall(49, this.p, VARIANT.Ptr, v)
}
struct IMSEventBinder extends IDispatch {
    static IID := "{C3A9F406-2222-436D-86D5-BA3229279EFB}"
    Bind(pEventObject, EventName, EventHandler, CancelID)
      => ComCall(7, this.p, IDispatch, pEventObject, BSTR, EventName, BSTR, EventHandler, Int32.Ptr, CancelID)
    Unbind(CancelCookie)
      => ComCall(8, this.p, UInt32, CancelCookie)
}
struct IMSVidCtlEvents extends IDispatch {
    static IID := "{B0EDF164-910A-11D2-B632-00C04F79498E}"
}
struct IStreamBufferInitialize extends IUnknown {
    static IID := "{9CE50F2D-6BA7-40FB-A034-50B1A674EC78}"
    SetHKEY(hkeyRoot)
      => ComCall(3, this.p, HKEY, hkeyRoot)
    SetSIDs(cSIDs, ppSID)
      => ComCall(4, this.p, UInt32, cSIDs, PSID.Ptr, ppSID)
}
struct RECORDING_TYPE extends Int32 {
    static RECORDING_TYPE_CONTENT := 0
    static RECORDING_TYPE_REFERENCE := 1
}
struct IStreamBufferSink extends IUnknown {
    static IID := "{AFD1F242-7EFD-45EE-BA4E-407A25C9A77A}"
    LockProfile(pszStreamBufferFilename)
      => ComCall(3, this.p, "Str", pszStreamBufferFilename)
    CreateRecorder(pszFilename, dwRecordType, pRecordingIUnknown)
      => ComCall(4, this.p, "Str", pszFilename, UInt32, dwRecordType, IUnknown.Ptr, pRecordingIUnknown)
    IsProfileLocked()
      => ComCall(5, this.p)
}
struct IStreamBufferSink2 extends IStreamBufferSink {
    static IID := "{DB94A660-F4FB-4BFA-BCC6-FE159A4EEA93}"
    UnlockProfile()
      => ComCall(6, this.p)
}
struct IStreamBufferSink3 extends IStreamBufferSink2 {
    static IID := "{974723F2-887A-4452-9366-2CFF3057BC8F}"
    SetAvailableFilter(prtMin)
      => ComCall(7, this.p, Int64.Ptr, prtMin)
}
struct IStreamBufferSource extends IUnknown {
    static IID := "{1C5BD776-6CED-4F44-8164-5EAB0E98DB12}"
    SetStreamSink(pIStreamBufferSink)
      => ComCall(3, this.p, IStreamBufferSink, pIStreamBufferSink)
}
struct IStreamBufferRecordControl extends IUnknown {
    static IID := "{BA9B6C99-F3C7-4FF2-92DB-CFDD4851BF31}"
    Start(prtStart)
      => ComCall(3, this.p, Int64.Ptr, prtStart)
    Stop(rtStop)
      => ComCall(4, this.p, Int64, rtStop)
    GetRecordingStatus(phResult, pbStarted, pbStopped)
      => ComCall(5, this.p, HRESULT.Ptr, phResult, BOOL.Ptr, pbStarted, BOOL.Ptr, pbStopped)
}
struct IStreamBufferRecComp extends IUnknown {
    static IID := "{9E259A9B-8815-42AE-B09F-221970B154FD}"
    Initialize(pszTargetFilename, pszSBRecProfileRef)
      => ComCall(3, this.p, "Str", pszTargetFilename, "Str", pszSBRecProfileRef)
    Append(pszSBRecording)
      => ComCall(4, this.p, "Str", pszSBRecording)
    AppendEx(pszSBRecording, rtStart, rtStop)
      => ComCall(5, this.p, "Str", pszSBRecording, Int64, rtStart, Int64, rtStop)
    GetCurrentLength(pcSeconds)
      => ComCall(6, this.p, UInt32.Ptr, pcSeconds)
    Close()
      => ComCall(7, this.p)
    Cancel()
      => ComCall(8, this.p)
}
struct STREAMBUFFER_ATTR_DATATYPE extends Int32 {
    static STREAMBUFFER_TYPE_DWORD := 0
    static STREAMBUFFER_TYPE_STRING := 1
    static STREAMBUFFER_TYPE_BINARY := 2
    static STREAMBUFFER_TYPE_BOOL := 3
    static STREAMBUFFER_TYPE_QWORD := 4
    static STREAMBUFFER_TYPE_WORD := 5
    static STREAMBUFFER_TYPE_GUID := 6
}
struct IStreamBufferRecordingAttribute extends IUnknown {
    static IID := "{16CA4E03-FE69-4705-BD41-5B7DFC0C95F3}"
    SetAttribute(ulReserved, pszAttributeName, StreamBufferAttributeType, pbAttribute)
      => ComCall(3, this.p, UInt32, ulReserved, "Str", pszAttributeName, STREAMBUFFER_ATTR_DATATYPE, StreamBufferAttributeType, UInt8.Ptr, pbAttribute, UInt16, pbAttribute.Length)
    GetAttributeCount(ulReserved, pcAttributes)
      => ComCall(4, this.p, UInt32, ulReserved, UInt16.Ptr, pcAttributes)
    GetAttributeByName(pszAttributeName, pulReserved, pStreamBufferAttributeType, pbAttribute)
      => ComCall(5, this.p, "Str", pszAttributeName, UInt32.Ptr, pulReserved, STREAMBUFFER_ATTR_DATATYPE.Ptr, pStreamBufferAttributeType, UInt8.Ptr, pbAttribute, UInt16.Ptr, pbAttribute.Length)
    GetAttributeByIndex(wIndex, pulReserved, pszAttributeName, pcchNameLength, pStreamBufferAttributeType, pbAttribute)
      => ComCall(6, this.p, UInt16, wIndex, UInt32.Ptr, pulReserved, PWSTR, pszAttributeName, UInt16.Ptr, pcchNameLength, STREAMBUFFER_ATTR_DATATYPE.Ptr, pStreamBufferAttributeType, UInt8.Ptr, pbAttribute, UInt16.Ptr, pbAttribute.Length)
    EnumAttributes(ppIEnumStreamBufferAttrib)
      => ComCall(7, this.p, IEnumStreamBufferRecordingAttrib.Ptr, ppIEnumStreamBufferAttrib)
}
struct STREAMBUFFER_ATTRIBUTE {
    pszName : PWSTR
    StreamBufferAttributeType : STREAMBUFFER_ATTR_DATATYPE
    pbAttribute : UInt8.Ptr
    cbLength : UInt16
}
struct IEnumStreamBufferRecordingAttrib extends IUnknown {
    static IID := "{C18A9162-1E82-4142-8C73-5690FA62FE33}"
    Next(pStreamBufferAttribute, pcReceived)
      => ComCall(3, this.p, UInt32, pStreamBufferAttribute.Length, STREAMBUFFER_ATTRIBUTE.Ptr, pStreamBufferAttribute, UInt32.Ptr, pcReceived)
    Skip(cRecords)
      => ComCall(4, this.p, UInt32, cRecords)
    Reset()
      => ComCall(5, this.p)
    Clone(ppIEnumStreamBufferAttrib)
      => ComCall(6, this.p, IEnumStreamBufferRecordingAttrib.Ptr, ppIEnumStreamBufferAttrib)
}
struct IStreamBufferConfigure extends IUnknown {
    static IID := "{CE14DFAE-4098-4AF7-BBF7-D6511F835414}"
    SetDirectory(pszDirectoryName)
      => ComCall(3, this.p, "Str", pszDirectoryName)
    GetDirectory(ppszDirectoryName)
      => ComCall(4, this.p, PWSTR.Ptr, ppszDirectoryName)
    SetBackingFileCount(dwMin, dwMax)
      => ComCall(5, this.p, UInt32, dwMin, UInt32, dwMax)
    GetBackingFileCount(pdwMin, pdwMax)
      => ComCall(6, this.p, UInt32.Ptr, pdwMin, UInt32.Ptr, pdwMax)
    SetBackingFileDuration(dwSeconds)
      => ComCall(7, this.p, UInt32, dwSeconds)
    GetBackingFileDuration(pdwSeconds)
      => ComCall(8, this.p, UInt32.Ptr, pdwSeconds)
}
struct IStreamBufferConfigure2 extends IStreamBufferConfigure {
    static IID := "{53E037BF-3992-4282-AE34-2487B4DAE06B}"
    SetMultiplexedPacketSize(cbBytesPerPacket)
      => ComCall(9, this.p, UInt32, cbBytesPerPacket)
    GetMultiplexedPacketSize(pcbBytesPerPacket)
      => ComCall(10, this.p, UInt32.Ptr, pcbBytesPerPacket)
    SetFFTransitionRates(dwMaxFullFrameRate, dwMaxNonSkippingRate)
      => ComCall(11, this.p, UInt32, dwMaxFullFrameRate, UInt32, dwMaxNonSkippingRate)
    GetFFTransitionRates(pdwMaxFullFrameRate, pdwMaxNonSkippingRate)
      => ComCall(12, this.p, UInt32.Ptr, pdwMaxFullFrameRate, UInt32.Ptr, pdwMaxNonSkippingRate)
}
struct IStreamBufferConfigure3 extends IStreamBufferConfigure2 {
    static IID := "{7E2D2A1E-7192-4BD7-80C1-061FD1D10402}"
    SetStartRecConfig(fStartStopsCur)
      => ComCall(13, this.p, BOOL, fStartStopsCur)
    GetStartRecConfig(pfStartStopsCur)
      => ComCall(14, this.p, BOOL.Ptr, pfStartStopsCur)
    SetNamespace(pszNamespace)
      => ComCall(15, this.p, "Str", pszNamespace)
    GetNamespace(ppszNamespace)
      => ComCall(16, this.p, PWSTR.Ptr, ppszNamespace)
}
struct IStreamBufferMediaSeeking extends IMediaSeeking {
    static IID := "{F61F5C26-863D-4AFA-B0BA-2F81DC978596}"
}
struct IStreamBufferMediaSeeking2 extends IStreamBufferMediaSeeking {
    static IID := "{3A439AB0-155F-470A-86A6-9EA54AFD6EAF}"
    SetRateEx(dRate, dwFramesPerSec)
      => ComCall(20, this.p, Float64, dRate, UInt32, dwFramesPerSec)
}
struct SBE_PIN_DATA {
    cDataBytes : Int64
    cSamplesProcessed : Int64
    cDiscontinuities : Int64
    cSyncPoints : Int64
    cTimestamps : Int64
}
struct IStreamBufferDataCounters extends IUnknown {
    static IID := "{9D2A2563-31AB-402E-9A6B-ADB903489440}"
    GetData(pPinData)
      => ComCall(3, this.p, SBE_PIN_DATA.Ptr, pPinData)
    ResetData()
      => ComCall(4, this.p)
}
struct CROSSBAR_DEFAULT_FLAGS extends Int32 {
    static DEF_MODE_PROFILE := 1
    static DEF_MODE_STREAMS := 2
}
struct SBE2_STREAM_DESC {
    Version : UInt32
    StreamId : UInt32
    Default : UInt32
    Reserved : UInt32
}
struct DVR_STREAM_DESC {
    Version : UInt32
    StreamId : UInt32
    Default : BOOL
    Creation : BOOL
    Reserved : UInt32
    guidSubMediaType : GUID
    guidFormatType : GUID
    MediaType : AM_MEDIA_TYPE
}
struct ISBE2GlobalEvent extends IUnknown {
    static IID := "{CAEDE759-B6B1-11DB-A578-0018F3FA24C6}"
    GetEvent(idEvt, param1, param2, param3, param4, pSpanning, pcb, pb)
      => ComCall(3, this.p, GUID.Ptr, idEvt, UInt32, param1, UInt32, param2, UInt32, param3, UInt32, param4, BOOL.Ptr, pSpanning, UInt32.Ptr, pcb, UInt8.Ptr, pb)
}
struct ISBE2GlobalEvent2 extends ISBE2GlobalEvent {
    static IID := "{6D8309BF-00FE-4506-8B03-F8C65B5C9B39}"
    GetEventEx(idEvt, param1, param2, param3, param4, pSpanning, pcb, pb, pStreamTime)
      => ComCall(4, this.p, GUID.Ptr, idEvt, UInt32, param1, UInt32, param2, UInt32, param3, UInt32, param4, BOOL.Ptr, pSpanning, UInt32.Ptr, pcb, UInt8.Ptr, pb, Int64.Ptr, pStreamTime)
}
struct ISBE2SpanningEvent extends IUnknown {
    static IID := "{CAEDE760-B6B1-11DB-A578-0018F3FA24C6}"
    GetEvent(idEvt, streamId, pcb, pb)
      => ComCall(3, this.p, GUID.Ptr, idEvt, UInt32, streamId, UInt32.Ptr, pcb, UInt8.Ptr, pb)
}
struct ISBE2Crossbar extends IUnknown {
    static IID := "{547B6D26-3226-487E-8253-8AA168749434}"
    EnableDefaultMode(DefaultFlags)
      => ComCall(3, this.p, UInt32, DefaultFlags)
    GetInitialProfile(ppProfile)
      => ComCall(4, this.p, ISBE2MediaTypeProfile.Ptr, ppProfile)
    SetOutputProfile(pProfile, pcOutputPins, ppOutputPins)
      => ComCall(5, this.p, ISBE2MediaTypeProfile, pProfile, UInt32.Ptr, pcOutputPins, IPin.Ptr, ppOutputPins)
    EnumStreams(ppStreams)
      => ComCall(6, this.p, ISBE2EnumStream.Ptr, ppStreams)
}
struct ISBE2StreamMap extends IUnknown {
    static IID := "{667C7745-85B1-4C55-AE55-4E25056159FC}"
    MapStream(Stream)
      => ComCall(3, this.p, UInt32, Stream)
    UnmapStream(Stream)
      => ComCall(4, this.p, UInt32, Stream)
    EnumMappedStreams(ppStreams)
      => ComCall(5, this.p, ISBE2EnumStream.Ptr, ppStreams)
}
struct ISBE2EnumStream extends IUnknown {
    static IID := "{F7611092-9FBC-46EC-A7C7-548EA78B71A4}"
    Next(pStreamDesc, pcReceived)
      => ComCall(3, this.p, UInt32, pStreamDesc.Length, SBE2_STREAM_DESC.Ptr, pStreamDesc, UInt32.Ptr, pcReceived)
    Skip(cRecords)
      => ComCall(4, this.p, UInt32, cRecords)
    Reset()
      => ComCall(5, this.p)
    Clone(ppIEnumStream)
      => ComCall(6, this.p, ISBE2EnumStream.Ptr, ppIEnumStream)
}
struct ISBE2MediaTypeProfile extends IUnknown {
    static IID := "{F238267D-4671-40D7-997E-25DC32CFED2A}"
    GetStreamCount(pCount)
      => ComCall(3, this.p, UInt32.Ptr, pCount)
    GetStream(Index, ppMediaType)
      => ComCall(4, this.p, UInt32, Index, AM_MEDIA_TYPE.Ptr.Ptr, ppMediaType)
    AddStream(pMediaType)
      => ComCall(5, this.p, AM_MEDIA_TYPE.Ptr, pMediaType)
    DeleteStream(Index)
      => ComCall(6, this.p, UInt32, Index)
}
struct ISBE2FileScan extends IUnknown {
    static IID := "{3E2BF5A5-4F96-4899-A1A3-75E8BE9A5AC0}"
    RepairFile(filename)
      => ComCall(3, this.p, "Str", filename)
}
struct PID_BITS_MIDL {
    Bits : UInt16
}
struct MPEG_HEADER_BITS_MIDL {
    Bits : UInt16
}
struct MPEG_HEADER_VERSION_BITS_MIDL {
    Bits : UInt8
}
struct MPEG_CURRENT_NEXT_BIT extends Int32 {
    static MPEG_SECTION_IS_NEXT := 0
    static MPEG_SECTION_IS_CURRENT := 1
}
struct TID_EXTENSION {
    wTidExt : UInt16
    wCount : UInt16
}
struct SECTION {
    TableId : UInt8
    Header : this._Header_e__Union
    SectionData : UInt8[1]
    struct _Header_e__Union {
        union {
            S : MPEG_HEADER_BITS_MIDL
            W : UInt16
        }
    }
}
struct LONG_SECTION {
    TableId : UInt8
    Header : this._Header_e__Union
    TableIdExtension : UInt16
    Version : this._Version_e__Union
    SectionNumber : UInt8
    LastSectionNumber : UInt8
    RemainingData : UInt8[1]
    struct _Header_e__Union {
        union {
            S : MPEG_HEADER_BITS_MIDL
            W : UInt16
        }
    }
    struct _Version_e__Union {
        union {
            S : MPEG_HEADER_VERSION_BITS_MIDL
            B : UInt8
        }
    }
}
struct DSMCC_SECTION {
    TableId : UInt8
    Header : this._Header_e__Union
    TableIdExtension : UInt16
    Version : this._Version_e__Union
    SectionNumber : UInt8
    LastSectionNumber : UInt8
    ProtocolDiscriminator : UInt8
    DsmccType : UInt8
    MessageId : UInt16
    TransactionId : UInt32
    Reserved : UInt8
    AdaptationLength : UInt8
    MessageLength : UInt16
    RemainingData : UInt8[1]
    struct _Header_e__Union {
        union {
            S : MPEG_HEADER_BITS_MIDL
            W : UInt16
        }
    }
    struct _Version_e__Union {
        union {
            S : MPEG_HEADER_VERSION_BITS_MIDL
            B : UInt8
        }
    }
}
struct MPEG_RQST_PACKET {
    dwLength : UInt32
    pSection : SECTION.Ptr
}
struct MPEG_PACKET_LIST {
    wPacketCount : UInt16
    PacketList : MPEG_RQST_PACKET.Ptr[1]
}
struct DSMCC_FILTER_OPTIONS {
    fSpecifyProtocol : BOOL
    Protocol : UInt8
    fSpecifyType : BOOL
    Type : UInt8
    fSpecifyMessageId : BOOL
    MessageId : UInt16
    fSpecifyTransactionId : BOOL
    fUseTrxIdMessageIdMask : BOOL
    TransactionId : UInt32
    fSpecifyModuleVersion : BOOL
    ModuleVersion : UInt8
    fSpecifyBlockNumber : BOOL
    BlockNumber : UInt16
    fGetModuleCall : BOOL
    NumberOfBlocksInModule : UInt16
}
struct ATSC_FILTER_OPTIONS {
    fSpecifyEtmId : BOOL
    EtmId : UInt32
}
struct DVB_EIT_FILTER_OPTIONS {
    fSpecifySegment : BOOL
    bSegment : UInt8
}
struct MPEG2_FILTER {
    bVersionNumber : UInt8
    wFilterSize : UInt16
    fUseRawFilteringBits : BOOL
    Filter : UInt8[16]
    Mask : UInt8[16]
    fSpecifyTableIdExtension : BOOL
    TableIdExtension : UInt16
    fSpecifyVersion : BOOL
    Version : UInt8
    fSpecifySectionNumber : BOOL
    SectionNumber : UInt8
    fSpecifyCurrentNext : BOOL
    fNext : BOOL
    fSpecifyDsmccOptions : BOOL
    Dsmcc : DSMCC_FILTER_OPTIONS
    fSpecifyAtscOptions : BOOL
    Atsc : ATSC_FILTER_OPTIONS
}
struct MPEG2_FILTER2 {
    Anonymous : this._Anonymous_e__Union
    fSpecifyDvbEitOptions : BOOL
    DvbEit : DVB_EIT_FILTER_OPTIONS
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            bVersion1Bytes : UInt8[124]
        }
        struct _Anonymous_e__Struct {
            bVersionNumber : UInt8
            wFilterSize : UInt16
            fUseRawFilteringBits : BOOL
            Filter : UInt8[16]
            Mask : UInt8[16]
            fSpecifyTableIdExtension : BOOL
            TableIdExtension : UInt16
            fSpecifyVersion : BOOL
            Version : UInt8
            fSpecifySectionNumber : BOOL
            SectionNumber : UInt8
            fSpecifyCurrentNext : BOOL
            fNext : BOOL
            fSpecifyDsmccOptions : BOOL
            Dsmcc : DSMCC_FILTER_OPTIONS
            fSpecifyAtscOptions : BOOL
            Atsc : ATSC_FILTER_OPTIONS
        }
    }
}
struct MPEG_STREAM_BUFFER {
    hr : HRESULT
    dwDataBufferSize : UInt32
    dwSizeOfDataRead : UInt32
    pDataBuffer : UInt8.Ptr
}
struct MPEG_TIME {
    Hours : UInt8
    Minutes : UInt8
    Seconds : UInt8
}
struct MPEG_DATE {
    Date : UInt8
    Month : UInt8
    Year : UInt16
}
struct MPEG_DATE_AND_TIME {
    D : MPEG_DATE
    T : MPEG_TIME
}
struct MPEG_CONTEXT_TYPE extends Int32 {
    static MPEG_CONTEXT_BCS_DEMUX := 0
    static MPEG_CONTEXT_WINSOCK := 1
}
struct MPEG_BCS_DEMUX {
    AVMGraphId : UInt32
}
struct MPEG_WINSOCK {
    AVMGraphId : UInt32
}
struct MPEG_CONTEXT {
    Type : MPEG_CONTEXT_TYPE
    U : this._U_e__Union
    struct _U_e__Union {
        union {
            Demux : MPEG_BCS_DEMUX
            Winsock : MPEG_WINSOCK
        }
    }
}
struct MPEG_REQUEST_TYPE extends Int32 {
    static MPEG_RQST_UNKNOWN := 0
    static MPEG_RQST_GET_SECTION := 1
    static MPEG_RQST_GET_SECTION_ASYNC := 2
    static MPEG_RQST_GET_TABLE := 3
    static MPEG_RQST_GET_TABLE_ASYNC := 4
    static MPEG_RQST_GET_SECTIONS_STREAM := 5
    static MPEG_RQST_GET_PES_STREAM := 6
    static MPEG_RQST_GET_TS_STREAM := 7
    static MPEG_RQST_START_MPE_STREAM := 8
}
struct MPEG_SERVICE_REQUEST {
    Type : MPEG_REQUEST_TYPE
    Context : MPEG_CONTEXT
    Pid : UInt16
    TableId : UInt8
    Filter : MPEG2_FILTER
    Flags : UInt32
}
struct MPEG_SERVICE_RESPONSE {
    IPAddress : UInt32
    Port : UInt16
}
struct DSMCC_ELEMENT {
    pid : UInt16
    bComponentTag : UInt8
    dwCarouselId : UInt32
    dwTransactionId : UInt32
    pNext : DSMCC_ELEMENT.Ptr
}
struct MPE_ELEMENT {
    pid : UInt16
    bComponentTag : UInt8
    pNext : MPE_ELEMENT.Ptr
}
struct MPEG_STREAM_FILTER {
    wPidValue : UInt16
    dwFilterSize : UInt32
    fCrcEnabled : BOOL
    rgchFilter : UInt8[16]
    rgchMask : UInt8[16]
}
struct IMpeg2TableFilter extends IUnknown {
    static IID := "{BDCDD913-9ECD-4FB2-81AE-ADF747EA75A5}"
    AddPID(p)
      => ComCall(3, this.p, UInt16, p)
    AddTable(p, t)
      => ComCall(4, this.p, UInt16, p, UInt8, t)
    AddExtension(p, t, e)
      => ComCall(5, this.p, UInt16, p, UInt8, t, UInt16, e)
    RemovePID(p)
      => ComCall(6, this.p, UInt16, p)
    RemoveTable(p, t)
      => ComCall(7, this.p, UInt16, p, UInt8, t)
    RemoveExtension(p, t, e)
      => ComCall(8, this.p, UInt16, p, UInt8, t, UInt16, e)
}
struct Mpeg2TableSampleHdr {
    SectionCount : UInt8
    Reserved : UInt8[3]
    SectionOffsets : Int32[1]
}
struct IMpeg2Data extends IUnknown {
    static IID := "{9B396D40-F380-4E3C-A514-1A82BF6EBFE6}"
    GetSection(pid, tid, pFilter, dwTimeout, ppSectionList)
      => ComCall(3, this.p, UInt16, pid, UInt8, tid, MPEG2_FILTER.Ptr, pFilter, UInt32, dwTimeout, ISectionList.Ptr, ppSectionList)
    GetTable(pid, tid, pFilter, dwTimeout, ppSectionList)
      => ComCall(4, this.p, UInt16, pid, UInt8, tid, MPEG2_FILTER.Ptr, pFilter, UInt32, dwTimeout, ISectionList.Ptr, ppSectionList)
    GetStreamOfSections(pid, tid, pFilter, hDataReadyEvent, ppMpegStream)
      => ComCall(5, this.p, UInt16, pid, UInt8, tid, MPEG2_FILTER.Ptr, pFilter, HANDLE, hDataReadyEvent, IMpeg2Stream.Ptr, ppMpegStream)
}
struct ISectionList extends IUnknown {
    static IID := "{AFEC1EB5-2A64-46C6-BF4B-AE3CCB6AFDB0}"
    Initialize(requestType, pMpeg2Data, pContext, pid, tid, pFilter, timeout, hDoneEvent)
      => ComCall(3, this.p, MPEG_REQUEST_TYPE, requestType, IMpeg2Data, pMpeg2Data, MPEG_CONTEXT.Ptr, pContext, UInt16, pid, UInt8, tid, MPEG2_FILTER.Ptr, pFilter, UInt32, timeout, HANDLE, hDoneEvent)
    InitializeWithRawSections(pmplSections)
      => ComCall(4, this.p, MPEG_PACKET_LIST.Ptr, pmplSections)
    CancelPendingRequest()
      => ComCall(5, this.p)
    GetNumberOfSections(pCount)
      => ComCall(6, this.p, UInt16.Ptr, pCount)
    GetSectionData(sectionNumber, pdwRawPacketLength, ppSection)
      => ComCall(7, this.p, UInt16, sectionNumber, UInt32.Ptr, pdwRawPacketLength, SECTION.Ptr.Ptr, ppSection)
    GetProgramIdentifier(pPid)
      => ComCall(8, this.p, UInt16.Ptr, pPid)
    GetTableIdentifier(pTableId)
      => ComCall(9, this.p, UInt8.Ptr, pTableId)
}
struct IMpeg2Stream extends IUnknown {
    static IID := "{400CC286-32A0-4CE4-9041-39571125A635}"
    Initialize(requestType, pMpeg2Data, pContext, pid, tid, pFilter, hDataReadyEvent)
      => ComCall(3, this.p, MPEG_REQUEST_TYPE, requestType, IMpeg2Data, pMpeg2Data, MPEG_CONTEXT.Ptr, pContext, UInt16, pid, UInt8, tid, MPEG2_FILTER.Ptr, pFilter, HANDLE, hDataReadyEvent)
    SupplyDataBuffer(pStreamBuffer)
      => ComCall(4, this.p, MPEG_STREAM_BUFFER.Ptr, pStreamBuffer)
}
struct IGenericDescriptor extends IUnknown {
    static IID := "{6A5918F8-A77A-4F61-AED0-5702BDCDA3E6}"
    Initialize(pbDesc, bCount)
      => ComCall(3, this.p, UInt8.Ptr, pbDesc, Int32, bCount)
    GetTag(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetBody(ppbVal)
      => ComCall(6, this.p, UInt8.Ptr.Ptr, ppbVal)
}
struct IGenericDescriptor2 extends IGenericDescriptor {
    static IID := "{BF02FB7E-9792-4E10-A68D-033A2CC246A5}"
    Initialize(pbDesc, wCount)
      => ComCall(7, this.p, UInt8.Ptr, pbDesc, UInt16, wCount)
    GetLength(pwVal)
      => ComCall(8, this.p, UInt16.Ptr, pwVal)
}
struct ProgramElement {
    wProgramNumber : UInt16
    wProgramMapPID : UInt16
}
struct IPAT extends IUnknown {
    static IID := "{6623B511-4B5F-43C3-9A01-E8FF84188060}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetTransportStreamId(pwVal)
      => ComCall(4, this.p, UInt16.Ptr, pwVal)
    GetVersionNumber(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pdwVal)
      => ComCall(6, this.p, UInt32.Ptr, pdwVal)
    GetRecordProgramNumber(dwIndex, pwVal)
      => ComCall(7, this.p, UInt32, dwIndex, UInt16.Ptr, pwVal)
    GetRecordProgramMapPid(dwIndex, pwVal)
      => ComCall(8, this.p, UInt32, dwIndex, UInt16.Ptr, pwVal)
    FindRecordProgramMapPid(wProgramNumber, pwVal)
      => ComCall(9, this.p, UInt16, wProgramNumber, UInt16.Ptr, pwVal)
    RegisterForNextTable(hNextTableAvailable)
      => ComCall(10, this.p, HANDLE, hNextTableAvailable)
    GetNextTable(ppPAT)
      => ComCall(11, this.p, IPAT.Ptr, ppPAT)
    RegisterForWhenCurrent(hNextTableIsCurrent)
      => ComCall(12, this.p, HANDLE, hNextTableIsCurrent)
    ConvertNextToCurrent()
      => ComCall(13, this.p)
}
struct ICAT extends IUnknown {
    static IID := "{7C6995FB-2A31-4BD7-953E-B1AD7FB7D31C}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(5, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(6, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie, ppDescriptor)
      => ComCall(7, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie, IGenericDescriptor.Ptr, ppDescriptor)
    RegisterForNextTable(hNextTableAvailable)
      => ComCall(8, this.p, HANDLE, hNextTableAvailable)
    GetNextTable(dwTimeout, ppCAT)
      => ComCall(9, this.p, UInt32, dwTimeout, ICAT.Ptr, ppCAT)
    RegisterForWhenCurrent(hNextTableIsCurrent)
      => ComCall(10, this.p, HANDLE, hNextTableIsCurrent)
    ConvertNextToCurrent()
      => ComCall(11, this.p)
}
struct IPMT extends IUnknown {
    static IID := "{01F3B398-9527-4736-94DB-5195878E97A8}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetProgramNumber(pwVal)
      => ComCall(4, this.p, UInt16.Ptr, pwVal)
    GetVersionNumber(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetPcrPid(pPidVal)
      => ComCall(6, this.p, UInt16.Ptr, pPidVal)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(7, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(8, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie, ppDescriptor)
      => ComCall(9, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie, IGenericDescriptor.Ptr, ppDescriptor)
    GetCountOfRecords(pwVal)
      => ComCall(10, this.p, UInt16.Ptr, pwVal)
    GetRecordStreamType(dwRecordIndex, pbVal)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordElementaryPid(dwRecordIndex, pPidVal)
      => ComCall(12, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pPidVal)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(13, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwDescIndex, ppDescriptor)
      => ComCall(14, this.p, UInt32, dwRecordIndex, UInt32, dwDescIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie, ppDescriptor)
      => ComCall(15, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie, IGenericDescriptor.Ptr, ppDescriptor)
    QueryServiceGatewayInfo(ppDSMCCList, puiCount)
      => ComCall(16, this.p, DSMCC_ELEMENT.Ptr.Ptr, ppDSMCCList, UInt32.Ptr, puiCount)
    QueryMPEInfo(ppMPEList, puiCount)
      => ComCall(17, this.p, MPE_ELEMENT.Ptr.Ptr, ppMPEList, UInt32.Ptr, puiCount)
    RegisterForNextTable(hNextTableAvailable)
      => ComCall(18, this.p, HANDLE, hNextTableAvailable)
    GetNextTable(ppPMT)
      => ComCall(19, this.p, IPMT.Ptr, ppPMT)
    RegisterForWhenCurrent(hNextTableIsCurrent)
      => ComCall(20, this.p, HANDLE, hNextTableIsCurrent)
    ConvertNextToCurrent()
      => ComCall(21, this.p)
}
struct ITSDT extends IUnknown {
    static IID := "{D19BDB43-405B-4A7C-A791-C89110C33165}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(5, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(6, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie, ppDescriptor)
      => ComCall(7, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie, IGenericDescriptor.Ptr, ppDescriptor)
    RegisterForNextTable(hNextTableAvailable)
      => ComCall(8, this.p, HANDLE, hNextTableAvailable)
    GetNextTable(ppTSDT)
      => ComCall(9, this.p, ITSDT.Ptr, ppTSDT)
    RegisterForWhenCurrent(hNextTableIsCurrent)
      => ComCall(10, this.p, HANDLE, hNextTableIsCurrent)
    ConvertNextToCurrent()
      => ComCall(11, this.p)
}
struct IPSITables extends IUnknown {
    static IID := "{919F24C5-7B14-42AC-A4B0-2AE08DAF00AC}"
    GetTable(dwTSID, dwTID_PID, dwHashedVer, dwPara4, ppIUnknown)
      => ComCall(3, this.p, UInt32, dwTSID, UInt32, dwTID_PID, UInt32, dwHashedVer, UInt32, dwPara4, IUnknown.Ptr, ppIUnknown)
}
struct IAtscPsipParser extends IUnknown {
    static IID := "{B2C98995-5EB2-4FB1-B406-F3E8E2026A9A}"
    Initialize(punkMpeg2Data?)
      => ComCall(3, this.p, IUnknown, punkMpeg2Data?)
    GetPAT(ppPAT)
      => ComCall(4, this.p, IPAT.Ptr, ppPAT)
    GetCAT(dwTimeout, ppCAT)
      => ComCall(5, this.p, UInt32, dwTimeout, ICAT.Ptr, ppCAT)
    GetPMT(pid, pwProgramNumber, ppPMT)
      => ComCall(6, this.p, UInt16, pid, UInt16.Ptr, pwProgramNumber, IPMT.Ptr, ppPMT)
    GetTSDT(ppTSDT)
      => ComCall(7, this.p, ITSDT.Ptr, ppTSDT)
    GetMGT(ppMGT)
      => ComCall(8, this.p, IATSC_MGT.Ptr, ppMGT)
    GetVCT(tableId, fGetNextTable, ppVCT)
      => ComCall(9, this.p, UInt8, tableId, BOOL, fGetNextTable, IATSC_VCT.Ptr, ppVCT)
    GetEIT(pid, pwSourceId, dwTimeout, ppEIT)
      => ComCall(10, this.p, UInt16, pid, UInt16.Ptr, pwSourceId, UInt32, dwTimeout, IATSC_EIT.Ptr, ppEIT)
    GetETT(pid, wSourceId, pwEventId, ppETT)
      => ComCall(11, this.p, UInt16, pid, UInt16.Ptr, wSourceId, UInt16.Ptr, pwEventId, IATSC_ETT.Ptr, ppETT)
    GetSTT(ppSTT)
      => ComCall(12, this.p, IATSC_STT.Ptr, ppSTT)
    GetEAS(pid, ppEAS)
      => ComCall(13, this.p, UInt16, pid, ISCTE_EAS.Ptr, ppEAS)
}
struct IATSC_MGT extends IUnknown {
    static IID := "{8877DABD-C137-4073-97E3-779407A5D87A}"
    Initialize(pSectionList?, pMPEGData?)
      => ComCall(3, this.p, ISectionList, pSectionList?, IMpeg2Data, pMPEGData?)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetProtocolVersion(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pdwVal)
      => ComCall(6, this.p, UInt32.Ptr, pdwVal)
    GetRecordType(dwRecordIndex, pwVal)
      => ComCall(7, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordTypePid(dwRecordIndex, ppidVal)
      => ComCall(8, this.p, UInt32, dwRecordIndex, UInt16.Ptr, ppidVal)
    GetRecordVersionNumber(dwRecordIndex, pbVal)
      => ComCall(9, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(10, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie, ppDescriptor)
      => ComCall(12, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie, IGenericDescriptor.Ptr, ppDescriptor)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(13, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(14, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie, ppDescriptor)
      => ComCall(15, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie, IGenericDescriptor.Ptr, ppDescriptor)
}
struct IATSC_VCT extends IUnknown {
    static IID := "{26879A18-32F9-46C6-91F0-FB6479270E8C}"
    Initialize(pSectionList?, pMPEGData?)
      => ComCall(3, this.p, ISectionList, pSectionList?, IMpeg2Data, pMPEGData?)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetTransportStreamId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetProtocolVersion(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pdwVal)
      => ComCall(7, this.p, UInt32.Ptr, pdwVal)
    GetRecordName(dwRecordIndex, pwsName)
      => ComCall(8, this.p, UInt32, dwRecordIndex, PWSTR.Ptr, pwsName)
    GetRecordMajorChannelNumber(dwRecordIndex, pwVal)
      => ComCall(9, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordMinorChannelNumber(dwRecordIndex, pwVal)
      => ComCall(10, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordModulationMode(dwRecordIndex, pbVal)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordCarrierFrequency(dwRecordIndex, pdwVal)
      => ComCall(12, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordTransportStreamId(dwRecordIndex, pwVal)
      => ComCall(13, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordProgramNumber(dwRecordIndex, pwVal)
      => ComCall(14, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordEtmLocation(dwRecordIndex, pbVal)
      => ComCall(15, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordIsAccessControlledBitSet(dwRecordIndex, pfVal)
      => ComCall(16, this.p, UInt32, dwRecordIndex, BOOL.Ptr, pfVal)
    GetRecordIsHiddenBitSet(dwRecordIndex, pfVal)
      => ComCall(17, this.p, UInt32, dwRecordIndex, BOOL.Ptr, pfVal)
    GetRecordIsPathSelectBitSet(dwRecordIndex, pfVal)
      => ComCall(18, this.p, UInt32, dwRecordIndex, BOOL.Ptr, pfVal)
    GetRecordIsOutOfBandBitSet(dwRecordIndex, pfVal)
      => ComCall(19, this.p, UInt32, dwRecordIndex, BOOL.Ptr, pfVal)
    GetRecordIsHideGuideBitSet(dwRecordIndex, pfVal)
      => ComCall(20, this.p, UInt32, dwRecordIndex, BOOL.Ptr, pfVal)
    GetRecordServiceType(dwRecordIndex, pbVal)
      => ComCall(21, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordSourceId(dwRecordIndex, pwVal)
      => ComCall(22, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(23, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(24, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie, ppDescriptor)
      => ComCall(25, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie, IGenericDescriptor.Ptr, ppDescriptor)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(26, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(27, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie, ppDescriptor)
      => ComCall(28, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie, IGenericDescriptor.Ptr, ppDescriptor)
}
struct IATSC_EIT extends IUnknown {
    static IID := "{D7C212D7-76A2-4B4B-AA56-846879A80096}"
    Initialize(pSectionList?, pMPEGData?)
      => ComCall(3, this.p, ISectionList, pSectionList?, IMpeg2Data, pMPEGData?)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetSourceId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetProtocolVersion(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pdwVal)
      => ComCall(7, this.p, UInt32.Ptr, pdwVal)
    GetRecordEventId(dwRecordIndex, pwVal)
      => ComCall(8, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordStartTime(dwRecordIndex, pmdtVal)
      => ComCall(9, this.p, UInt32, dwRecordIndex, MPEG_DATE_AND_TIME.Ptr, pmdtVal)
    GetRecordEtmLocation(dwRecordIndex, pbVal)
      => ComCall(10, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordDuration(dwRecordIndex, pmdVal)
      => ComCall(11, this.p, UInt32, dwRecordIndex, MPEG_TIME.Ptr, pmdVal)
    GetRecordTitleText(dwRecordIndex, pdwLength, ppText)
      => ComCall(12, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwLength, UInt8.Ptr.Ptr, ppText)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(13, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(14, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie, ppDescriptor)
      => ComCall(15, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie, IGenericDescriptor.Ptr, ppDescriptor)
}
struct IATSC_ETT extends IUnknown {
    static IID := "{5A142CC9-B8CF-4A86-A040-E9CADF3EF3E7}"
    Initialize(pSectionList?, pMPEGData?)
      => ComCall(3, this.p, ISectionList, pSectionList?, IMpeg2Data, pMPEGData?)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetProtocolVersion(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetEtmId(pdwVal)
      => ComCall(6, this.p, UInt32.Ptr, pdwVal)
    GetExtendedMessageText(pdwLength, ppText)
      => ComCall(7, this.p, UInt32.Ptr, pdwLength, UInt8.Ptr.Ptr, ppText)
}
struct IATSC_STT extends IUnknown {
    static IID := "{6BF42423-217D-4D6F-81E1-3A7B360EC896}"
    Initialize(pSectionList?, pMPEGData?)
      => ComCall(3, this.p, ISectionList, pSectionList?, IMpeg2Data, pMPEGData?)
    GetProtocolVersion(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetSystemTime(pmdtSystemTime)
      => ComCall(5, this.p, MPEG_DATE_AND_TIME.Ptr, pmdtSystemTime)
    GetGpsUtcOffset(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetDaylightSavings(pwVal)
      => ComCall(7, this.p, UInt16.Ptr, pwVal)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(8, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(9, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie, ppDescriptor)
      => ComCall(10, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie, IGenericDescriptor.Ptr, ppDescriptor)
}
struct ISCTE_EAS extends IUnknown {
    static IID := "{1FF544D6-161D-4FAE-9FAA-4F9F492AE999}"
    Initialize(pSectionList?, pMPEGData?)
      => ComCall(3, this.p, ISectionList, pSectionList?, IMpeg2Data, pMPEGData?)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetSequencyNumber(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetProtocolVersion(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetEASEventID(pwVal)
      => ComCall(7, this.p, UInt16.Ptr, pwVal)
    GetOriginatorCode(pbVal)
      => ComCall(8, this.p, UInt8.Ptr, pbVal)
    GetEASEventCodeLen(pbVal)
      => ComCall(9, this.p, UInt8.Ptr, pbVal)
    GetEASEventCode(pbVal)
      => ComCall(10, this.p, UInt8.Ptr, pbVal)
    GetRawNatureOfActivationTextLen(pbVal)
      => ComCall(11, this.p, UInt8.Ptr, pbVal)
    GetRawNatureOfActivationText(pbVal)
      => ComCall(12, this.p, UInt8.Ptr, pbVal)
    GetNatureOfActivationText(bstrIS0639code, pbstrString)
      => ComCall(13, this.p, BSTR, bstrIS0639code, BSTR.Ptr, pbstrString)
    GetTimeRemaining(pbVal)
      => ComCall(14, this.p, UInt8.Ptr, pbVal)
    GetStartTime(pdwVal)
      => ComCall(15, this.p, UInt32.Ptr, pdwVal)
    GetDuration(pwVal)
      => ComCall(16, this.p, UInt16.Ptr, pwVal)
    GetAlertPriority(pbVal)
      => ComCall(17, this.p, UInt8.Ptr, pbVal)
    GetDetailsOOBSourceID(pwVal)
      => ComCall(18, this.p, UInt16.Ptr, pwVal)
    GetDetailsMajor(pwVal)
      => ComCall(19, this.p, UInt16.Ptr, pwVal)
    GetDetailsMinor(pwVal)
      => ComCall(20, this.p, UInt16.Ptr, pwVal)
    GetDetailsAudioOOBSourceID(pwVal)
      => ComCall(21, this.p, UInt16.Ptr, pwVal)
    GetAlertText(bstrIS0639code, pbstrString)
      => ComCall(22, this.p, BSTR, bstrIS0639code, BSTR.Ptr, pbstrString)
    GetRawAlertTextLen(pwVal)
      => ComCall(23, this.p, UInt16.Ptr, pwVal)
    GetRawAlertText(pbVal)
      => ComCall(24, this.p, UInt8.Ptr, pbVal)
    GetLocationCount(pbVal)
      => ComCall(25, this.p, UInt8.Ptr, pbVal)
    GetLocationCodes(bIndex, pbState, pbCountySubdivision, pwCounty)
      => ComCall(26, this.p, UInt8, bIndex, UInt8.Ptr, pbState, UInt8.Ptr, pbCountySubdivision, UInt16.Ptr, pwCounty)
    GetExceptionCount(pbVal)
      => ComCall(27, this.p, UInt8.Ptr, pbVal)
    GetExceptionService(bIndex, pbIBRef, pwFirst, pwSecond)
      => ComCall(28, this.p, UInt8, bIndex, UInt8.Ptr, pbIBRef, UInt16.Ptr, pwFirst, UInt16.Ptr, pwSecond)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(29, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(30, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie, ppDescriptor)
      => ComCall(31, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie, IGenericDescriptor.Ptr, ppDescriptor)
}
struct IAtscContentAdvisoryDescriptor extends IUnknown {
    static IID := "{FF76E60C-0283-43EA-BA32-B422238547EE}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetRatingRegionCount(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetRecordRatingRegion(bIndex, pbVal)
      => ComCall(6, this.p, UInt8, bIndex, UInt8.Ptr, pbVal)
    GetRecordRatedDimensions(bIndex, pbVal)
      => ComCall(7, this.p, UInt8, bIndex, UInt8.Ptr, pbVal)
    GetRecordRatingDimension(bIndexOuter, bIndexInner, pbVal)
      => ComCall(8, this.p, UInt8, bIndexOuter, UInt8, bIndexInner, UInt8.Ptr, pbVal)
    GetRecordRatingValue(bIndexOuter, bIndexInner, pbVal)
      => ComCall(9, this.p, UInt8, bIndexOuter, UInt8, bIndexInner, UInt8.Ptr, pbVal)
    GetRecordRatingDescriptionText(bIndex, pbLength, ppText)
      => ComCall(10, this.p, UInt8, bIndex, UInt8.Ptr, pbLength, UInt8.Ptr.Ptr, ppText)
}
struct ICaptionServiceDescriptor extends IUnknown {
    static IID := "{40834007-6834-46F0-BD45-D5F6A6BE258C}"
    GetNumberOfServices(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLanguageCode(bIndex, LangCode)
      => ComCall(4, this.p, UInt8, bIndex, UInt8.Ptr, LangCode)
    GetCaptionServiceNumber(bIndex, pbVal)
      => ComCall(5, this.p, UInt8, bIndex, UInt8.Ptr, pbVal)
    GetCCType(bIndex, pbVal)
      => ComCall(6, this.p, UInt8, bIndex, UInt8.Ptr, pbVal)
    GetEasyReader(bIndex, pbVal)
      => ComCall(7, this.p, UInt8, bIndex, UInt8.Ptr, pbVal)
    GetWideAspectRatio(bIndex, pbVal)
      => ComCall(8, this.p, UInt8, bIndex, UInt8.Ptr, pbVal)
}
struct IServiceLocationDescriptor extends IUnknown {
    static IID := "{58C3C827-9D91-4215-BFF3-820A49F0904C}"
    GetPCR_PID(pwVal)
      => ComCall(3, this.p, UInt16.Ptr, pwVal)
    GetNumberOfElements(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetElementStreamType(bIndex, pbVal)
      => ComCall(5, this.p, UInt8, bIndex, UInt8.Ptr, pbVal)
    GetElementPID(bIndex, pwVal)
      => ComCall(6, this.p, UInt8, bIndex, UInt16.Ptr, pwVal)
    GetElementLanguageCode(bIndex, LangCode)
      => ComCall(7, this.p, UInt8, bIndex, UInt8.Ptr, LangCode)
}
struct IAttributeSet extends IUnknown {
    static IID := "{583EC3CC-4960-4857-982B-41A33EA0A006}"
    SetAttrib(guidAttribute, pbAttribute, dwAttributeLength)
      => ComCall(3, this.p, GUID, guidAttribute, UInt8.Ptr, pbAttribute, UInt32, dwAttributeLength)
}
struct IAttributeGet extends IUnknown {
    static IID := "{52DBD1EC-E48F-4528-9232-F442A68F0AE1}"
    GetCount(plCount)
      => ComCall(3, this.p, Int32.Ptr, plCount)
    GetAttribIndexed(lIndex, pguidAttribute, pbAttribute, pdwAttributeLength)
      => ComCall(4, this.p, Int32, lIndex, GUID.Ptr, pguidAttribute, UInt8.Ptr, pbAttribute, UInt32.Ptr, pdwAttributeLength)
    GetAttrib(guidAttribute, pbAttribute, pdwAttributeLength)
      => ComCall(5, this.p, GUID, guidAttribute, UInt8.Ptr, pbAttribute, UInt32.Ptr, pdwAttributeLength)
}
struct UDCR_TAG {
    bVersion : UInt8
    KID : UInt8[25]
    ullBaseCounter : Int64
    ullBaseCounterRange : Int64
    fScrambled : BOOL
    bStreamMark : UInt8
    dwReserved1 : UInt32
    dwReserved2 : UInt32
}
struct PIC_SEQ_SAMPLE {
    _bitfield : UInt32
}
struct SAMPLE_SEQ_OFFSET {
    _bitfield : UInt32
}
struct VA_VIDEO_FORMAT extends Int32 {
    static VA_VIDEO_COMPONENT := 0
    static VA_VIDEO_PAL := 1
    static VA_VIDEO_NTSC := 2
    static VA_VIDEO_SECAM := 3
    static VA_VIDEO_MAC := 4
    static VA_VIDEO_UNSPECIFIED := 5
}
struct VA_COLOR_PRIMARIES extends Int32 {
    static VA_PRIMARIES_ITU_R_BT_709 := 1
    static VA_PRIMARIES_UNSPECIFIED := 2
    static VA_PRIMARIES_ITU_R_BT_470_SYSTEM_M := 4
    static VA_PRIMARIES_ITU_R_BT_470_SYSTEM_B_G := 5
    static VA_PRIMARIES_SMPTE_170M := 6
    static VA_PRIMARIES_SMPTE_240M := 7
    static VA_PRIMARIES_H264_GENERIC_FILM := 8
}
struct VA_TRANSFER_CHARACTERISTICS extends Int32 {
    static VA_TRANSFER_CHARACTERISTICS_ITU_R_BT_709 := 1
    static VA_TRANSFER_CHARACTERISTICS_UNSPECIFIED := 2
    static VA_TRANSFER_CHARACTERISTICS_ITU_R_BT_470_SYSTEM_M := 4
    static VA_TRANSFER_CHARACTERISTICS_ITU_R_BT_470_SYSTEM_B_G := 5
    static VA_TRANSFER_CHARACTERISTICS_SMPTE_170M := 6
    static VA_TRANSFER_CHARACTERISTICS_SMPTE_240M := 7
    static VA_TRANSFER_CHARACTERISTICS_LINEAR := 8
    static VA_TRANSFER_CHARACTERISTICS_H264_LOG_100_TO_1 := 9
    static VA_TRANSFER_CHARACTERISTICS_H264_LOG_316_TO_1 := 10
}
struct VA_MATRIX_COEFFICIENTS extends Int32 {
    static VA_MATRIX_COEFF_H264_RGB := 0
    static VA_MATRIX_COEFF_ITU_R_BT_709 := 1
    static VA_MATRIX_COEFF_UNSPECIFIED := 2
    static VA_MATRIX_COEFF_FCC := 4
    static VA_MATRIX_COEFF_ITU_R_BT_470_SYSTEM_B_G := 5
    static VA_MATRIX_COEFF_SMPTE_170M := 6
    static VA_MATRIX_COEFF_SMPTE_240M := 7
    static VA_MATRIX_COEFF_H264_YCgCo := 8
}
struct VA_OPTIONAL_VIDEO_PROPERTIES {
    dwPictureHeight : UInt16
    dwPictureWidth : UInt16
    dwAspectRatioX : UInt16
    dwAspectRatioY : UInt16
    VAVideoFormat : VA_VIDEO_FORMAT
    VAColorPrimaries : VA_COLOR_PRIMARIES
    VATransferCharacteristics : VA_TRANSFER_CHARACTERISTICS
    VAMatrixCoefficients : VA_MATRIX_COEFFICIENTS
}
struct TRANSPORT_PROPERTIES {
    PID : UInt32
    PCR : Int64
    Fields : this._Fields_e__Union
    struct _Fields_e__Union {
        union {
            Others : this._Others
            Value : Int64
        }
        struct _Others {
            _bitfield : Int64
        }
    }
}
struct PBDA_TAG_ATTRIBUTE {
    TableUUId : GUID
    TableId : UInt8
    VersionNo : UInt16
    TableDataSize : UInt32
    TableData : UInt8[1]
}
struct CAPTURE_STREAMTIME {
    StreamTime : Int64
}
struct DSHOW_STREAM_DESC {
    VersionNo : UInt32
    StreamId : UInt32
    Default : BOOL
    Creation : BOOL
    Reserved : UInt32
}
struct SAMPLE_LIVE_STREAM_TIME {
    qwStreamTime : Int64
    qwLiveTime : Int64
}
struct DVB_STRCONV_MODE extends Int32 {
    static STRCONV_MODE_DVB := 0
    static STRCONV_MODE_DVB_EMPHASIS := 1
    static STRCONV_MODE_DVB_WITHOUT_EMPHASIS := 2
    static STRCONV_MODE_ISDB := 3
}
struct IDvbSiParser extends IUnknown {
    static IID := "{B758A7BD-14DC-449D-B828-35909ACB3B1E}"
    Initialize(punkMpeg2Data)
      => ComCall(3, this.p, IUnknown, punkMpeg2Data)
    GetPAT(ppPAT)
      => ComCall(4, this.p, IPAT.Ptr, ppPAT)
    GetCAT(dwTimeout, ppCAT)
      => ComCall(5, this.p, UInt32, dwTimeout, ICAT.Ptr, ppCAT)
    GetPMT(pid, pwProgramNumber?, ppPMT)
      => ComCall(6, this.p, UInt16, pid, UInt16.Ptr, pwProgramNumber?, IPMT.Ptr, ppPMT)
    GetTSDT(ppTSDT)
      => ComCall(7, this.p, ITSDT.Ptr, ppTSDT)
    GetNIT(tableId, pwNetworkId?, ppNIT)
      => ComCall(8, this.p, UInt8, tableId, UInt16.Ptr, pwNetworkId?, IDVB_NIT.Ptr, ppNIT)
    GetSDT(tableId, pwTransportStreamId?, ppSDT)
      => ComCall(9, this.p, UInt8, tableId, UInt16.Ptr, pwTransportStreamId?, IDVB_SDT.Ptr, ppSDT)
    GetEIT(tableId, pwServiceId?, ppEIT)
      => ComCall(10, this.p, UInt8, tableId, UInt16.Ptr, pwServiceId?, IDVB_EIT.Ptr, ppEIT)
    GetBAT(pwBouquetId?, ppBAT)
      => ComCall(11, this.p, UInt16.Ptr, pwBouquetId?, IDVB_BAT.Ptr, ppBAT)
    GetRST(dwTimeout, ppRST)
      => ComCall(12, this.p, UInt32, dwTimeout, IDVB_RST.Ptr, ppRST)
    GetST(pid, dwTimeout, ppST)
      => ComCall(13, this.p, UInt16, pid, UInt32, dwTimeout, IDVB_ST.Ptr, ppST)
    GetTDT(ppTDT)
      => ComCall(14, this.p, IDVB_TDT.Ptr, ppTDT)
    GetTOT(ppTOT)
      => ComCall(15, this.p, IDVB_TOT.Ptr, ppTOT)
    GetDIT(dwTimeout, ppDIT)
      => ComCall(16, this.p, UInt32, dwTimeout, IDVB_DIT.Ptr, ppDIT)
    GetSIT(dwTimeout, ppSIT)
      => ComCall(17, this.p, UInt32, dwTimeout, IDVB_SIT.Ptr, ppSIT)
}
struct IDvbSiParser2 extends IDvbSiParser {
    static IID := "{0AC5525F-F816-42F4-93BA-4C0F32F46E54}"
    GetEIT2(tableId, pwServiceId?, pbSegment?, ppEIT)
      => ComCall(18, this.p, UInt8, tableId, UInt16.Ptr, pwServiceId?, UInt8.Ptr, pbSegment?, IDVB_EIT2.Ptr, ppEIT)
}
struct IIsdbSiParser2 extends IDvbSiParser2 {
    static IID := "{900E4BB7-18CD-453F-98BE-3BE6AA211772}"
    GetSDT(tableId, pwTransportStreamId?, ppSDT)
      => ComCall(19, this.p, UInt8, tableId, UInt16.Ptr, pwTransportStreamId?, IISDB_SDT.Ptr, ppSDT)
    GetBIT(tableId, pwOriginalNetworkId?, ppBIT)
      => ComCall(20, this.p, UInt8, tableId, UInt16.Ptr, pwOriginalNetworkId?, IISDB_BIT.Ptr, ppBIT)
    GetNBIT(tableId, pwOriginalNetworkId?, ppNBIT)
      => ComCall(21, this.p, UInt8, tableId, UInt16.Ptr, pwOriginalNetworkId?, IISDB_NBIT.Ptr, ppNBIT)
    GetLDT(tableId, pwOriginalServiceId?, ppLDT)
      => ComCall(22, this.p, UInt8, tableId, UInt16.Ptr, pwOriginalServiceId?, IISDB_LDT.Ptr, ppLDT)
    GetSDTT(tableId, pwTableIdExt?, ppSDTT)
      => ComCall(23, this.p, UInt8, tableId, UInt16.Ptr, pwTableIdExt?, IISDB_SDTT.Ptr, ppSDTT)
    GetCDT(tableId, bSectionNumber, pwDownloadDataId?, ppCDT)
      => ComCall(24, this.p, UInt8, tableId, UInt8, bSectionNumber, UInt16.Ptr, pwDownloadDataId?, IISDB_CDT.Ptr, ppCDT)
    GetEMM(pid, wTableIdExt, ppEMM)
      => ComCall(25, this.p, UInt16, pid, UInt16, wTableIdExt, IISDB_EMM.Ptr, ppEMM)
}
struct IDVB_NIT extends IUnknown {
    static IID := "{C64935F4-29E4-4E22-911A-63F7F55CB097}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetNetworkId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(6, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(7, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie?, ppDescriptor)
      => ComCall(8, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    GetCountOfRecords(pdwVal)
      => ComCall(9, this.p, UInt32.Ptr, pdwVal)
    GetRecordTransportStreamId(dwRecordIndex, pwVal)
      => ComCall(10, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordOriginalNetworkId(dwRecordIndex, pwVal)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(12, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(13, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie?, ppDescriptor)
      => ComCall(14, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    RegisterForNextTable(hNextTableAvailable)
      => ComCall(15, this.p, HANDLE, hNextTableAvailable)
    GetNextTable(ppNIT)
      => ComCall(16, this.p, IDVB_NIT.Ptr, ppNIT)
    RegisterForWhenCurrent(hNextTableIsCurrent)
      => ComCall(17, this.p, HANDLE, hNextTableIsCurrent)
    ConvertNextToCurrent()
      => ComCall(18, this.p)
    GetVersionHash(pdwVersionHash)
      => ComCall(19, this.p, UInt32.Ptr, pdwVersionHash)
}
struct IDVB_SDT extends IUnknown {
    static IID := "{02CAD8D3-FE43-48E2-90BD-450ED9A8A5FD}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetTransportStreamId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetOriginalNetworkId(pwVal)
      => ComCall(6, this.p, UInt16.Ptr, pwVal)
    GetCountOfRecords(pdwVal)
      => ComCall(7, this.p, UInt32.Ptr, pdwVal)
    GetRecordServiceId(dwRecordIndex, pwVal)
      => ComCall(8, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordEITScheduleFlag(dwRecordIndex, pfVal)
      => ComCall(9, this.p, UInt32, dwRecordIndex, BOOL.Ptr, pfVal)
    GetRecordEITPresentFollowingFlag(dwRecordIndex, pfVal)
      => ComCall(10, this.p, UInt32, dwRecordIndex, BOOL.Ptr, pfVal)
    GetRecordRunningStatus(dwRecordIndex, pbVal)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordFreeCAMode(dwRecordIndex, pfVal)
      => ComCall(12, this.p, UInt32, dwRecordIndex, BOOL.Ptr, pfVal)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(13, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(14, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie?, ppDescriptor)
      => ComCall(15, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    RegisterForNextTable(hNextTableAvailable)
      => ComCall(16, this.p, HANDLE, hNextTableAvailable)
    GetNextTable(ppSDT)
      => ComCall(17, this.p, IDVB_SDT.Ptr, ppSDT)
    RegisterForWhenCurrent(hNextTableIsCurrent)
      => ComCall(18, this.p, HANDLE, hNextTableIsCurrent)
    ConvertNextToCurrent()
      => ComCall(19, this.p)
    GetVersionHash(pdwVersionHash)
      => ComCall(20, this.p, UInt32.Ptr, pdwVersionHash)
}
struct IISDB_SDT extends IDVB_SDT {
    static IID := "{3F3DC9A2-BB32-4FB9-AE9E-D856848927A3}"
    GetRecordEITUserDefinedFlags(dwRecordIndex, pbVal)
      => ComCall(21, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
}
struct IDVB_EIT extends IUnknown {
    static IID := "{442DB029-02CB-4495-8B92-1C13375BCE99}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetServiceId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetTransportStreamId(pwVal)
      => ComCall(6, this.p, UInt16.Ptr, pwVal)
    GetOriginalNetworkId(pwVal)
      => ComCall(7, this.p, UInt16.Ptr, pwVal)
    GetSegmentLastSectionNumber(pbVal)
      => ComCall(8, this.p, UInt8.Ptr, pbVal)
    GetLastTableId(pbVal)
      => ComCall(9, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pdwVal)
      => ComCall(10, this.p, UInt32.Ptr, pdwVal)
    GetRecordEventId(dwRecordIndex, pwVal)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordStartTime(dwRecordIndex, pmdtVal)
      => ComCall(12, this.p, UInt32, dwRecordIndex, MPEG_DATE_AND_TIME.Ptr, pmdtVal)
    GetRecordDuration(dwRecordIndex, pmdVal)
      => ComCall(13, this.p, UInt32, dwRecordIndex, MPEG_TIME.Ptr, pmdVal)
    GetRecordRunningStatus(dwRecordIndex, pbVal)
      => ComCall(14, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordFreeCAMode(dwRecordIndex, pfVal)
      => ComCall(15, this.p, UInt32, dwRecordIndex, BOOL.Ptr, pfVal)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(16, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(17, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie?, ppDescriptor)
      => ComCall(18, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    RegisterForNextTable(hNextTableAvailable)
      => ComCall(19, this.p, HANDLE, hNextTableAvailable)
    GetNextTable(ppEIT)
      => ComCall(20, this.p, IDVB_EIT.Ptr, ppEIT)
    RegisterForWhenCurrent(hNextTableIsCurrent)
      => ComCall(21, this.p, HANDLE, hNextTableIsCurrent)
    ConvertNextToCurrent()
      => ComCall(22, this.p)
    GetVersionHash(pdwVersionHash)
      => ComCall(23, this.p, UInt32.Ptr, pdwVersionHash)
}
struct IDVB_EIT2 extends IDVB_EIT {
    static IID := "{61A389E0-9B9E-4BA0-AEEA-5DDD159820EA}"
    GetSegmentInfo(pbTid, pbSegment)
      => ComCall(24, this.p, UInt8.Ptr, pbTid, UInt8.Ptr, pbSegment)
    GetRecordSection(dwRecordIndex, pbVal)
      => ComCall(25, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
}
struct IDVB_BAT extends IUnknown {
    static IID := "{ECE9BB0C-43B6-4558-A0EC-1812C34CD6CA}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetBouquetId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(6, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(7, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie?, ppDescriptor)
      => ComCall(8, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    GetCountOfRecords(pdwVal)
      => ComCall(9, this.p, UInt32.Ptr, pdwVal)
    GetRecordTransportStreamId(dwRecordIndex, pwVal)
      => ComCall(10, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordOriginalNetworkId(dwRecordIndex, pwVal)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(12, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(13, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie?, ppDescriptor)
      => ComCall(14, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    RegisterForNextTable(hNextTableAvailable)
      => ComCall(15, this.p, HANDLE, hNextTableAvailable)
    GetNextTable(ppBAT)
      => ComCall(16, this.p, IDVB_BAT.Ptr, ppBAT)
    RegisterForWhenCurrent(hNextTableIsCurrent)
      => ComCall(17, this.p, HANDLE, hNextTableIsCurrent)
    ConvertNextToCurrent()
      => ComCall(18, this.p)
}
struct IDVB_RST extends IUnknown {
    static IID := "{F47DCD04-1E23-4FB7-9F96-B40EEAD10B2B}"
    Initialize(pSectionList)
      => ComCall(3, this.p, ISectionList, pSectionList)
    GetCountOfRecords(pdwVal)
      => ComCall(4, this.p, UInt32.Ptr, pdwVal)
    GetRecordTransportStreamId(dwRecordIndex, pwVal)
      => ComCall(5, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordOriginalNetworkId(dwRecordIndex, pwVal)
      => ComCall(6, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordServiceId(dwRecordIndex, pwVal)
      => ComCall(7, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordEventId(dwRecordIndex, pwVal)
      => ComCall(8, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordRunningStatus(dwRecordIndex, pbVal)
      => ComCall(9, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
}
struct IDVB_ST extends IUnknown {
    static IID := "{4D5B9F23-2A02-45DE-BCDA-5D5DBFBFBE62}"
    Initialize(pSectionList)
      => ComCall(3, this.p, ISectionList, pSectionList)
    GetDataLength(pwVal)
      => ComCall(4, this.p, UInt16.Ptr, pwVal)
    GetData(ppData)
      => ComCall(5, this.p, UInt8.Ptr.Ptr, ppData)
}
struct IDVB_TDT extends IUnknown {
    static IID := "{0780DC7D-D55C-4AEF-97E6-6B75906E2796}"
    Initialize(pSectionList)
      => ComCall(3, this.p, ISectionList, pSectionList)
    GetUTCTime(pmdtVal)
      => ComCall(4, this.p, MPEG_DATE_AND_TIME.Ptr, pmdtVal)
}
struct IDVB_TOT extends IUnknown {
    static IID := "{83295D6A-FABA-4EE1-9B15-8067696910AE}"
    Initialize(pSectionList)
      => ComCall(3, this.p, ISectionList, pSectionList)
    GetUTCTime(pmdtVal)
      => ComCall(4, this.p, MPEG_DATE_AND_TIME.Ptr, pmdtVal)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(5, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(6, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie?, ppDescriptor)
      => ComCall(7, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
}
struct IDVB_DIT extends IUnknown {
    static IID := "{91BFFDF9-9432-410F-86EF-1C228ED0AD70}"
    Initialize(pSectionList)
      => ComCall(3, this.p, ISectionList, pSectionList)
    GetTransitionFlag(pfVal)
      => ComCall(4, this.p, BOOL.Ptr, pfVal)
}
struct IDVB_SIT extends IUnknown {
    static IID := "{68CDCE53-8BEA-45C2-9D9D-ACF575A089B5}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(5, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(6, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie?, ppDescriptor)
      => ComCall(7, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    GetCountOfRecords(pdwVal)
      => ComCall(8, this.p, UInt32.Ptr, pdwVal)
    GetRecordServiceId(dwRecordIndex, pwVal)
      => ComCall(9, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordRunningStatus(dwRecordIndex, pbVal)
      => ComCall(10, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(12, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie?, ppDescriptor)
      => ComCall(13, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    RegisterForNextTable(hNextTableAvailable)
      => ComCall(14, this.p, HANDLE, hNextTableAvailable)
    GetNextTable(dwTimeout, ppSIT)
      => ComCall(15, this.p, UInt32, dwTimeout, IDVB_SIT.Ptr, ppSIT)
    RegisterForWhenCurrent(hNextTableIsCurrent)
      => ComCall(16, this.p, HANDLE, hNextTableIsCurrent)
    ConvertNextToCurrent()
      => ComCall(17, this.p)
}
struct IISDB_BIT extends IUnknown {
    static IID := "{537CD71E-0E46-4173-9001-BA043F3E49E2}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetOriginalNetworkId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetBroadcastViewPropriety(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(7, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(8, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie?, ppDescriptor)
      => ComCall(9, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    GetCountOfRecords(pdwVal)
      => ComCall(10, this.p, UInt32.Ptr, pdwVal)
    GetRecordBroadcasterId(dwRecordIndex, pbVal)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(12, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(13, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie?, ppDescriptor)
      => ComCall(14, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    GetVersionHash(pdwVersionHash)
      => ComCall(15, this.p, UInt32.Ptr, pdwVersionHash)
}
struct IISDB_NBIT extends IUnknown {
    static IID := "{1B1863EF-08F1-40B7-A559-3B1EFF8CAFA6}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetOriginalNetworkId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetCountOfRecords(pdwVal)
      => ComCall(6, this.p, UInt32.Ptr, pdwVal)
    GetRecordInformationId(dwRecordIndex, pwVal)
      => ComCall(7, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordInformationType(dwRecordIndex, pbVal)
      => ComCall(8, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordDescriptionBodyLocation(dwRecordIndex, pbVal)
      => ComCall(9, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordMessageSectionNumber(dwRecordIndex, pbVal)
      => ComCall(10, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordUserDefined(dwRecordIndex, pbVal)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordNumberOfKeys(dwRecordIndex, pbVal)
      => ComCall(12, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordKeys(dwRecordIndex, pbKeys)
      => ComCall(13, this.p, UInt32, dwRecordIndex, UInt8.Ptr.Ptr, pbKeys)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(14, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(15, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie?, ppDescriptor)
      => ComCall(16, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    GetVersionHash(pdwVersionHash)
      => ComCall(17, this.p, UInt32.Ptr, pdwVersionHash)
}
struct IISDB_LDT extends IUnknown {
    static IID := "{141A546B-02FF-4FB9-A3A3-2F074B74A9A9}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetOriginalServiceId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetTransportStreamId(pwVal)
      => ComCall(6, this.p, UInt16.Ptr, pwVal)
    GetOriginalNetworkId(pwVal)
      => ComCall(7, this.p, UInt16.Ptr, pwVal)
    GetCountOfRecords(pdwVal)
      => ComCall(8, this.p, UInt32.Ptr, pdwVal)
    GetRecordDescriptionId(dwRecordIndex, pwVal)
      => ComCall(9, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(10, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie?, ppDescriptor)
      => ComCall(12, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    GetVersionHash(pdwVersionHash)
      => ComCall(13, this.p, UInt32.Ptr, pdwVersionHash)
}
struct IISDB_SDTT extends IUnknown {
    static IID := "{EE60EF2D-813A-4DC7-BF92-EA13DAC85313}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetTableIdExt(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetTransportStreamId(pwVal)
      => ComCall(6, this.p, UInt16.Ptr, pwVal)
    GetOriginalNetworkId(pwVal)
      => ComCall(7, this.p, UInt16.Ptr, pwVal)
    GetServiceId(pwVal)
      => ComCall(8, this.p, UInt16.Ptr, pwVal)
    GetCountOfRecords(pdwVal)
      => ComCall(9, this.p, UInt32.Ptr, pdwVal)
    GetRecordGroup(dwRecordIndex, pbVal)
      => ComCall(10, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordTargetVersion(dwRecordIndex, pwVal)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordNewVersion(dwRecordIndex, pwVal)
      => ComCall(12, this.p, UInt32, dwRecordIndex, UInt16.Ptr, pwVal)
    GetRecordDownloadLevel(dwRecordIndex, pbVal)
      => ComCall(13, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordVersionIndicator(dwRecordIndex, pbVal)
      => ComCall(14, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordScheduleTimeShiftInformation(dwRecordIndex, pbVal)
      => ComCall(15, this.p, UInt32, dwRecordIndex, UInt8.Ptr, pbVal)
    GetRecordCountOfSchedules(dwRecordIndex, pdwVal)
      => ComCall(16, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordStartTimeByIndex(dwRecordIndex, dwIndex, pmdtVal)
      => ComCall(17, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, MPEG_DATE_AND_TIME.Ptr, pmdtVal)
    GetRecordDurationByIndex(dwRecordIndex, dwIndex, pmdVal)
      => ComCall(18, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, MPEG_TIME.Ptr, pmdVal)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(19, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(20, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie?, ppDescriptor)
      => ComCall(21, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    GetVersionHash(pdwVersionHash)
      => ComCall(22, this.p, UInt32.Ptr, pdwVersionHash)
}
struct IISDB_CDT extends IUnknown {
    static IID := "{25FA92C2-8B80-4787-A841-3A0E8F17984B}"
    Initialize(pSectionList, pMPEGData, bSectionNumber)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData, UInt8, bSectionNumber)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetDownloadDataId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetSectionNumber(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetOriginalNetworkId(pwVal)
      => ComCall(7, this.p, UInt16.Ptr, pwVal)
    GetDataType(pbVal)
      => ComCall(8, this.p, UInt8.Ptr, pbVal)
    GetCountOfTableDescriptors(pdwVal)
      => ComCall(9, this.p, UInt32.Ptr, pdwVal)
    GetTableDescriptorByIndex(dwIndex, ppDescriptor)
      => ComCall(10, this.p, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetTableDescriptorByTag(bTag, pdwCookie?, ppDescriptor)
      => ComCall(11, this.p, UInt8, bTag, UInt32.Ptr, pdwCookie?, IGenericDescriptor.Ptr, ppDescriptor)
    GetSizeOfDataModule(pdwVal)
      => ComCall(12, this.p, UInt32.Ptr, pdwVal)
    GetDataModule(pbData)
      => ComCall(13, this.p, UInt8.Ptr.Ptr, pbData)
    GetVersionHash(pdwVersionHash)
      => ComCall(14, this.p, UInt32.Ptr, pdwVersionHash)
}
struct IISDB_EMM extends IUnknown {
    static IID := "{0EDB556D-43AD-4938-9668-321B2FFECFD3}"
    Initialize(pSectionList, pMPEGData)
      => ComCall(3, this.p, ISectionList, pSectionList, IMpeg2Data, pMPEGData)
    GetVersionNumber(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetTableIdExtension(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetDataBytes(pwBufferLength, pbBuffer)
      => ComCall(6, this.p, UInt16.Ptr, pwBufferLength, UInt8.Ptr, pbBuffer)
    GetSharedEmmMessage(pwLength, ppbMessage)
      => ComCall(7, this.p, UInt16.Ptr, pwLength, UInt8.Ptr.Ptr, ppbMessage)
    GetIndividualEmmMessage(pUnknown, pwLength, ppbMessage)
      => ComCall(8, this.p, IUnknown, pUnknown, UInt16.Ptr, pwLength, UInt8.Ptr.Ptr, ppbMessage)
    GetVersionHash(pdwVersionHash)
      => ComCall(9, this.p, UInt32.Ptr, pdwVersionHash)
}
struct IDvbServiceAttributeDescriptor extends IUnknown {
    static IID := "{0F37BD92-D6A1-4854-B950-3A969D27F30E}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetRecordServiceId(bRecordIndex, pwVal)
      => ComCall(6, this.p, UInt8, bRecordIndex, UInt16.Ptr, pwVal)
    GetRecordNumericSelectionFlag(bRecordIndex, pfVal)
      => ComCall(7, this.p, UInt8, bRecordIndex, BOOL.Ptr, pfVal)
    GetRecordVisibleServiceFlag(bRecordIndex, pfVal)
      => ComCall(8, this.p, UInt8, bRecordIndex, BOOL.Ptr, pfVal)
}
struct CRID_LOCATION extends Int32 {
    static CRID_LOCATION_IN_DESCRIPTOR := 0
    static CRID_LOCATION_IN_CIT := 1
    static CRID_LOCATION_DVB_RESERVED1 := 2
    static CRID_LOCATION_DVB_RESERVED2 := 3
}
struct IDvbContentIdentifierDescriptor extends IUnknown {
    static IID := "{05E0C1EA-F661-4053-9FBF-D93B28359838}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetRecordCrid(bRecordIndex, pbType, pbLocation, ppbBytes)
      => ComCall(6, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbType, UInt8.Ptr, pbLocation, UInt8.Ptr, ppbBytes.Length, UInt8.Ptr.Ptr, ppbBytes)
}
struct IDvbDefaultAuthorityDescriptor extends IUnknown {
    static IID := "{05EC24D1-3A31-44E7-B408-67C60A352276}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetDefaultAuthority(ppbBytes)
      => ComCall(5, this.p, UInt8.Ptr, ppbBytes.Length, UInt8.Ptr.Ptr, ppbBytes)
}
struct IDvbSatelliteDeliverySystemDescriptor extends IUnknown {
    static IID := "{02F2225A-805B-4EC5-A9A6-F9B5913CD470}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetFrequency(pdwVal)
      => ComCall(5, this.p, UInt32.Ptr, pdwVal)
    GetOrbitalPosition(pwVal)
      => ComCall(6, this.p, UInt16.Ptr, pwVal)
    GetWestEastFlag(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetPolarization(pbVal)
      => ComCall(8, this.p, UInt8.Ptr, pbVal)
    GetModulation(pbVal)
      => ComCall(9, this.p, UInt8.Ptr, pbVal)
    GetSymbolRate(pdwVal)
      => ComCall(10, this.p, UInt32.Ptr, pdwVal)
    GetFECInner(pbVal)
      => ComCall(11, this.p, UInt8.Ptr, pbVal)
}
struct IDvbCableDeliverySystemDescriptor extends IUnknown {
    static IID := "{DFB98E36-9E1A-4862-9946-993A4E59017B}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetFrequency(pdwVal)
      => ComCall(5, this.p, UInt32.Ptr, pdwVal)
    GetFECOuter(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetModulation(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetSymbolRate(pdwVal)
      => ComCall(8, this.p, UInt32.Ptr, pdwVal)
    GetFECInner(pbVal)
      => ComCall(9, this.p, UInt8.Ptr, pbVal)
}
struct IDvbTerrestrialDeliverySystemDescriptor extends IUnknown {
    static IID := "{ED7E1B91-D12E-420C-B41D-A49D84FE1823}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCentreFrequency(pdwVal)
      => ComCall(5, this.p, UInt32.Ptr, pdwVal)
    GetBandwidth(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetConstellation(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetHierarchyInformation(pbVal)
      => ComCall(8, this.p, UInt8.Ptr, pbVal)
    GetCodeRateHPStream(pbVal)
      => ComCall(9, this.p, UInt8.Ptr, pbVal)
    GetCodeRateLPStream(pbVal)
      => ComCall(10, this.p, UInt8.Ptr, pbVal)
    GetGuardInterval(pbVal)
      => ComCall(11, this.p, UInt8.Ptr, pbVal)
    GetTransmissionMode(pbVal)
      => ComCall(12, this.p, UInt8.Ptr, pbVal)
    GetOtherFrequencyFlag(pbVal)
      => ComCall(13, this.p, UInt8.Ptr, pbVal)
}
struct IDvbTerrestrial2DeliverySystemDescriptor extends IUnknown {
    static IID := "{20EE9BE9-CD57-49AB-8F6E-1D07AEB8E482}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetTagExtension(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetCentreFrequency(pdwVal)
      => ComCall(6, this.p, UInt32.Ptr, pdwVal)
    GetPLPId(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetT2SystemId(pwVal)
      => ComCall(8, this.p, UInt16.Ptr, pwVal)
    GetMultipleInputMode(pbVal)
      => ComCall(9, this.p, UInt8.Ptr, pbVal)
    GetBandwidth(pbVal)
      => ComCall(10, this.p, UInt8.Ptr, pbVal)
    GetGuardInterval(pbVal)
      => ComCall(11, this.p, UInt8.Ptr, pbVal)
    GetTransmissionMode(pbVal)
      => ComCall(12, this.p, UInt8.Ptr, pbVal)
    GetCellId(pwVal)
      => ComCall(13, this.p, UInt16.Ptr, pwVal)
    GetOtherFrequencyFlag(pbVal)
      => ComCall(14, this.p, UInt8.Ptr, pbVal)
    GetTFSFlag(pbVal)
      => ComCall(15, this.p, UInt8.Ptr, pbVal)
}
struct IDvbFrequencyListDescriptor extends IUnknown {
    static IID := "{1CADB613-E1DD-4512-AFA8-BB7A007EF8B1}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCodingType(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetRecordCentreFrequency(bRecordIndex, pdwVal)
      => ComCall(7, this.p, UInt8, bRecordIndex, UInt32.Ptr, pdwVal)
}
struct IDvbPrivateDataSpecifierDescriptor extends IUnknown {
    static IID := "{5660A019-E75A-4B82-9B4C-ED2256D165A2}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetPrivateDataSpecifier(pdwVal)
      => ComCall(5, this.p, UInt32.Ptr, pdwVal)
}
struct IDvbLogicalChannelDescriptor extends IUnknown {
    static IID := "{CF1EDAFF-3FFD-4CF7-8201-35756ACBF85F}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetRecordServiceId(bRecordIndex, pwVal)
      => ComCall(6, this.p, UInt8, bRecordIndex, UInt16.Ptr, pwVal)
    GetRecordLogicalChannelNumber(bRecordIndex, pwVal)
      => ComCall(7, this.p, UInt8, bRecordIndex, UInt16.Ptr, pwVal)
}
struct IDvbLogicalChannelDescriptor2 extends IDvbLogicalChannelDescriptor {
    static IID := "{43ACA974-4BE8-4B98-BC17-9EAFD788B1D7}"
    GetRecordLogicalChannelAndVisibility(bRecordIndex, pwVal)
      => ComCall(8, this.p, UInt8, bRecordIndex, UInt16.Ptr, pwVal)
}
struct IDvbLogicalChannel2Descriptor extends IDvbLogicalChannelDescriptor2 {
    static IID := "{F69C3747-8A30-4980-998C-01FE7F0BA35A}"
    GetCountOfLists(pbVal)
      => ComCall(9, this.p, UInt8.Ptr, pbVal)
    GetListId(bListIndex, pbVal)
      => ComCall(10, this.p, UInt8, bListIndex, UInt8.Ptr, pbVal)
    GetListNameW(bListIndex, convMode, pbstrName)
      => ComCall(11, this.p, UInt8, bListIndex, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrName)
    GetListCountryCode(bListIndex, pszCode)
      => ComCall(12, this.p, UInt8, bListIndex, UInt8.Ptr, pszCode)
    GetListCountOfRecords(bChannelListIndex, pbVal)
      => ComCall(13, this.p, UInt8, bChannelListIndex, UInt8.Ptr, pbVal)
    GetListRecordServiceId(bListIndex, bRecordIndex, pwVal)
      => ComCall(14, this.p, UInt8, bListIndex, UInt8, bRecordIndex, UInt16.Ptr, pwVal)
    GetListRecordLogicalChannelNumber(bListIndex, bRecordIndex, pwVal)
      => ComCall(15, this.p, UInt8, bListIndex, UInt8, bRecordIndex, UInt16.Ptr, pwVal)
    GetListRecordLogicalChannelAndVisibility(bListIndex, bRecordIndex, pwVal)
      => ComCall(16, this.p, UInt8, bListIndex, UInt8, bRecordIndex, UInt16.Ptr, pwVal)
}
struct IDvbHDSimulcastLogicalChannelDescriptor extends IDvbLogicalChannelDescriptor2 {
    static IID := "{1EA8B738-A307-4680-9E26-D0A908C824F4}"
}
struct IDvbDataBroadcastIDDescriptor extends IUnknown {
    static IID := "{5F26F518-65C8-4048-91F2-9290F59F7B90}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetDataBroadcastID(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetIDSelectorBytes(pbLen, pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbLen, UInt8.Ptr, pbVal)
}
struct IDvbDataBroadcastDescriptor extends IUnknown {
    static IID := "{D1EBC1D6-8B60-4C20-9CAF-E59382E7C400}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetDataBroadcastID(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetComponentTag(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetSelectorLength(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetSelectorBytes(pbLen, pbVal)
      => ComCall(8, this.p, UInt8.Ptr, pbLen, UInt8.Ptr, pbVal)
    GetLangID(pulVal)
      => ComCall(9, this.p, UInt32.Ptr, pulVal)
    GetTextLength(pbVal)
      => ComCall(10, this.p, UInt8.Ptr, pbVal)
    GetText(pbLen, pbVal)
      => ComCall(11, this.p, UInt8.Ptr, pbLen, UInt8.Ptr, pbVal)
}
struct DESC_LINKAGE_TYPE extends Int32 {
    static DESC_LINKAGE_RESERVED0 := 0
    static DESC_LINKAGE_INFORMATION := 1
    static DESC_LINKAGE_EPG := 2
    static DESC_LINKAGE_CA_REPLACEMENT := 3
    static DESC_LINKAGE_COMPLETE_NET_BOUQUET_SI := 4
    static DESC_LINKAGE_REPLACEMENT := 5
    static DESC_LINKAGE_DATA := 6
    static DESC_LINKAGE_RESERVED1 := 7
    static DESC_LINKAGE_USER := 8
    static DESC_LINKAGE_RESERVED2 := 255
}
struct IDvbLinkageDescriptor extends IUnknown {
    static IID := "{1CDF8B31-994A-46FC-ACFD-6A6BE8934DD5}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetTSId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetONId(pwVal)
      => ComCall(6, this.p, UInt16.Ptr, pwVal)
    GetServiceId(pwVal)
      => ComCall(7, this.p, UInt16.Ptr, pwVal)
    GetLinkageType(pbVal)
      => ComCall(8, this.p, UInt8.Ptr, pbVal)
    GetPrivateDataLength(pbVal)
      => ComCall(9, this.p, UInt8.Ptr, pbVal)
    GetPrivateData(pbLen, pbData)
      => ComCall(10, this.p, UInt8.Ptr, pbLen, UInt8.Ptr, pbData)
}
struct IDvbTeletextDescriptor extends IUnknown {
    static IID := "{9CD29D47-69C6-4F92-98A9-210AF1B7303A}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetRecordLangId(bRecordIndex, pulVal)
      => ComCall(6, this.p, UInt8, bRecordIndex, UInt32.Ptr, pulVal)
    GetRecordTeletextType(bRecordIndex, pbVal)
      => ComCall(7, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetRecordMagazineNumber(bRecordIndex, pbVal)
      => ComCall(8, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetRecordPageNumber(bRecordIndex, pbVal)
      => ComCall(9, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
}
struct IDvbSubtitlingDescriptor extends IUnknown {
    static IID := "{9B25FE1D-FA23-4E50-9784-6DF8B26F8A49}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetRecordLangId(bRecordIndex, pulVal)
      => ComCall(6, this.p, UInt8, bRecordIndex, UInt32.Ptr, pulVal)
    GetRecordSubtitlingType(bRecordIndex, pbVal)
      => ComCall(7, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetRecordCompositionPageID(bRecordIndex, pwVal)
      => ComCall(8, this.p, UInt8, bRecordIndex, UInt16.Ptr, pwVal)
    GetRecordAncillaryPageID(bRecordIndex, pwVal)
      => ComCall(9, this.p, UInt8, bRecordIndex, UInt16.Ptr, pwVal)
}
struct IDvbServiceDescriptor extends IUnknown {
    static IID := "{F9C7FBCF-E2D6-464D-B32D-2EF526E49290}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetServiceType(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetServiceProviderName(pszName)
      => ComCall(6, this.p, UInt8.Ptr.Ptr, pszName)
    GetServiceProviderNameW(pbstrName)
      => ComCall(7, this.p, BSTR.Ptr, pbstrName)
    GetServiceName(pszName)
      => ComCall(8, this.p, UInt8.Ptr.Ptr, pszName)
    GetProcessedServiceName(pbstrName)
      => ComCall(9, this.p, BSTR.Ptr, pbstrName)
    GetServiceNameEmphasized(pbstrName)
      => ComCall(10, this.p, BSTR.Ptr, pbstrName)
}
struct IDvbServiceDescriptor2 extends IDvbServiceDescriptor {
    static IID := "{D6C76506-85AB-487C-9B2B-36416511E4A2}"
    GetServiceProviderNameW(convMode, pbstrName)
      => ComCall(11, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrName)
    GetServiceNameW(convMode, pbstrName)
      => ComCall(12, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrName)
}
struct IDvbServiceListDescriptor extends IUnknown {
    static IID := "{05DB0D8F-6008-491A-ACD3-7090952707D0}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetRecordServiceId(bRecordIndex, pwVal)
      => ComCall(6, this.p, UInt8, bRecordIndex, UInt16.Ptr, pwVal)
    GetRecordServiceType(bRecordIndex, pbVal)
      => ComCall(7, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
}
struct IDvbMultilingualServiceNameDescriptor extends IUnknown {
    static IID := "{2D80433B-B32C-47EF-987F-E78EBB773E34}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetRecordLangId(bRecordIndex, ulVal)
      => ComCall(6, this.p, UInt8, bRecordIndex, UInt32.Ptr, ulVal)
    GetRecordServiceProviderNameW(bRecordIndex, convMode, pbstrName)
      => ComCall(7, this.p, UInt8, bRecordIndex, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrName)
    GetRecordServiceNameW(bRecordIndex, convMode, pbstrName)
      => ComCall(8, this.p, UInt8, bRecordIndex, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrName)
}
struct IDvbNetworkNameDescriptor extends IUnknown {
    static IID := "{5B2A80CF-35B9-446C-B3E4-048B761DBC51}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetNetworkName(pszName)
      => ComCall(5, this.p, UInt8.Ptr.Ptr, pszName)
    GetNetworkNameW(convMode, pbstrName)
      => ComCall(6, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrName)
}
struct IDvbShortEventDescriptor extends IUnknown {
    static IID := "{B170BE92-5B75-458E-9C6E-B0008231491A}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetLanguageCode(pszCode)
      => ComCall(5, this.p, UInt8.Ptr, pszCode)
    GetEventNameW(convMode, pbstrName)
      => ComCall(6, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrName)
    GetTextW(convMode, pbstrText)
      => ComCall(7, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrText)
}
struct IDvbExtendedEventDescriptor extends IUnknown {
    static IID := "{C9B22ECA-85F4-499F-B1DB-EFA93A91EE57}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetDescriptorNumber(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetLastDescriptorNumber(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetLanguageCode(pszCode)
      => ComCall(7, this.p, UInt8.Ptr, pszCode)
    GetCountOfRecords(pbVal)
      => ComCall(8, this.p, UInt8.Ptr, pbVal)
    GetRecordItemW(bRecordIndex, convMode, pbstrDesc, pbstrItem)
      => ComCall(9, this.p, UInt8, bRecordIndex, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrDesc, BSTR.Ptr, pbstrItem)
    GetConcatenatedItemW(pFollowingDescriptor, convMode, pbstrDesc, pbstrItem)
      => ComCall(10, this.p, IDvbExtendedEventDescriptor, pFollowingDescriptor, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrDesc, BSTR.Ptr, pbstrItem)
    GetTextW(convMode, pbstrText)
      => ComCall(11, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrText)
    GetConcatenatedTextW(FollowingDescriptor, convMode, pbstrText)
      => ComCall(12, this.p, IDvbExtendedEventDescriptor, FollowingDescriptor, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrText)
    GetRecordItemRawBytes(bRecordIndex, ppbRawItem, pbItemLength)
      => ComCall(13, this.p, UInt8, bRecordIndex, UInt8.Ptr.Ptr, ppbRawItem, UInt8.Ptr, pbItemLength)
}
struct IDvbComponentDescriptor extends IUnknown {
    static IID := "{91E405CF-80E7-457F-9096-1B9D1CE32141}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetStreamContent(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetComponentType(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetComponentTag(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetLanguageCode(pszCode)
      => ComCall(8, this.p, UInt8.Ptr, pszCode)
    GetTextW(convMode, pbstrText)
      => ComCall(9, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrText)
}
struct IDvbContentDescriptor extends IUnknown {
    static IID := "{2E883881-A467-412A-9D63-6F2B6DA05BF0}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetRecordContentNibbles(bRecordIndex, pbValLevel1, pbValLevel2)
      => ComCall(6, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbValLevel1, UInt8.Ptr, pbValLevel2)
    GetRecordUserNibbles(bRecordIndex, pbVal1, pbVal2)
      => ComCall(7, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal1, UInt8.Ptr, pbVal2)
}
struct IDvbParentalRatingDescriptor extends IUnknown {
    static IID := "{3AD9DDE1-FB1B-4186-937F-22E6B5A72A10}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetRecordRating(bRecordIndex, pszCountryCode, pbVal)
      => ComCall(6, this.p, UInt8, bRecordIndex, UInt8.Ptr, pszCountryCode, UInt8.Ptr, pbVal)
}
struct IIsdbTerrestrialDeliverySystemDescriptor extends IUnknown {
    static IID := "{39FAE0A6-D151-44DD-A28A-765DE5991670}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetAreaCode(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetGuardInterval(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetTransmissionMode(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(8, this.p, UInt8.Ptr, pbVal)
    GetRecordFrequency(bRecordIndex, pdwVal)
      => ComCall(9, this.p, UInt8, bRecordIndex, UInt32.Ptr, pdwVal)
}
struct IIsdbTSInformationDescriptor extends IUnknown {
    static IID := "{D7AD183E-38F5-4210-B55F-EC8D601BBD47}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetRemoteControlKeyId(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetTSNameW(convMode, pbstrName)
      => ComCall(6, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrName)
    GetCountOfRecords(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetRecordTransmissionTypeInfo(bRecordIndex, pbVal)
      => ComCall(8, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetRecordNumberOfServices(bRecordIndex, pbVal)
      => ComCall(9, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetRecordServiceIdByIndex(bRecordIndex, bServiceIndex, pdwVal)
      => ComCall(10, this.p, UInt8, bRecordIndex, UInt8, bServiceIndex, UInt16.Ptr, pdwVal)
}
struct IIsdbDigitalCopyControlDescriptor extends IUnknown {
    static IID := "{1A28417E-266A-4BB8-A4BD-D782BCFB8161}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCopyControl(pbDigitalRecordingControlData, pbCopyControlType, pbAPSControlData, pbMaximumBitrate)
      => ComCall(5, this.p, UInt8.Ptr, pbDigitalRecordingControlData, UInt8.Ptr, pbCopyControlType, UInt8.Ptr, pbAPSControlData, UInt8.Ptr, pbMaximumBitrate)
    GetCountOfRecords(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetRecordCopyControl(bRecordIndex, pbComponentTag, pbDigitalRecordingControlData, pbCopyControlType, pbAPSControlData, pbMaximumBitrate)
      => ComCall(7, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbComponentTag, UInt8.Ptr, pbDigitalRecordingControlData, UInt8.Ptr, pbCopyControlType, UInt8.Ptr, pbAPSControlData, UInt8.Ptr, pbMaximumBitrate)
}
struct IIsdbAudioComponentDescriptor extends IUnknown {
    static IID := "{679D2002-2425-4BE4-A4C7-D6632A574F4D}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetStreamContent(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetComponentType(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetComponentTag(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetStreamType(pbVal)
      => ComCall(8, this.p, UInt8.Ptr, pbVal)
    GetSimulcastGroupTag(pbVal)
      => ComCall(9, this.p, UInt8.Ptr, pbVal)
    GetESMultiLingualFlag(pfVal)
      => ComCall(10, this.p, BOOL.Ptr, pfVal)
    GetMainComponentFlag(pfVal)
      => ComCall(11, this.p, BOOL.Ptr, pfVal)
    GetQualityIndicator(pbVal)
      => ComCall(12, this.p, UInt8.Ptr, pbVal)
    GetSamplingRate(pbVal)
      => ComCall(13, this.p, UInt8.Ptr, pbVal)
    GetLanguageCode(pszCode)
      => ComCall(14, this.p, UInt8.Ptr, pszCode)
    GetLanguageCode2(pszCode)
      => ComCall(15, this.p, UInt8.Ptr, pszCode)
    GetTextW(convMode, pbstrText)
      => ComCall(16, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrText)
}
struct IIsdbDataContentDescriptor extends IUnknown {
    static IID := "{A428100A-E646-4BD6-AA14-6087BDC08CD5}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetDataComponentId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetEntryComponent(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetSelectorLength(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetSelectorBytes(bBufLength, pbBuf)
      => ComCall(8, this.p, UInt8, bBufLength, UInt8.Ptr, pbBuf)
    GetCountOfRecords(pbVal)
      => ComCall(9, this.p, UInt8.Ptr, pbVal)
    GetRecordComponentRef(bRecordIndex, pbVal)
      => ComCall(10, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetLanguageCode(pszCode)
      => ComCall(11, this.p, UInt8.Ptr, pszCode)
    GetTextW(convMode, pbstrText)
      => ComCall(12, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrText)
}
struct IIsdbCAContractInformationDescriptor extends IUnknown {
    static IID := "{08E18B25-A28F-4E92-821E-4FCED5CC2291}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCASystemId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetCAUnitId(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetRecordComponentTag(bRecordIndex, pbVal)
      => ComCall(8, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetContractVerificationInfoLength(pbVal)
      => ComCall(9, this.p, UInt8.Ptr, pbVal)
    GetContractVerificationInfo(bBufLength, pbBuf)
      => ComCall(10, this.p, UInt8, bBufLength, UInt8.Ptr, pbBuf)
    GetFeeNameW(convMode, pbstrName)
      => ComCall(11, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrName)
}
struct IIsdbEventGroupDescriptor extends IUnknown {
    static IID := "{94B06780-2E2A-44DC-A966-CC56FDABC6C2}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetGroupType(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetRecordEvent(bRecordIndex, pwServiceId, pwEventId)
      => ComCall(7, this.p, UInt8, bRecordIndex, UInt16.Ptr, pwServiceId, UInt16.Ptr, pwEventId)
    GetCountOfRefRecords(pbVal)
      => ComCall(8, this.p, UInt8.Ptr, pbVal)
    GetRefRecordEvent(bRecordIndex, pwOriginalNetworkId, pwTransportStreamId, pwServiceId, pwEventId)
      => ComCall(9, this.p, UInt8, bRecordIndex, UInt16.Ptr, pwOriginalNetworkId, UInt16.Ptr, pwTransportStreamId, UInt16.Ptr, pwServiceId, UInt16.Ptr, pwEventId)
}
struct IIsdbComponentGroupDescriptor extends IUnknown {
    static IID := "{A494F17F-C592-47D8-8943-64C9A34BE7B9}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetComponentGroupType(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetRecordGroupId(bRecordIndex, pbVal)
      => ComCall(7, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetRecordNumberOfCAUnit(bRecordIndex, pbVal)
      => ComCall(8, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetRecordCAUnitCAUnitId(bRecordIndex, bCAUnitIndex, pbVal)
      => ComCall(9, this.p, UInt8, bRecordIndex, UInt8, bCAUnitIndex, UInt8.Ptr, pbVal)
    GetRecordCAUnitNumberOfComponents(bRecordIndex, bCAUnitIndex, pbVal)
      => ComCall(10, this.p, UInt8, bRecordIndex, UInt8, bCAUnitIndex, UInt8.Ptr, pbVal)
    GetRecordCAUnitComponentTag(bRecordIndex, bCAUnitIndex, bComponentIndex, pbVal)
      => ComCall(11, this.p, UInt8, bRecordIndex, UInt8, bCAUnitIndex, UInt8, bComponentIndex, UInt8.Ptr, pbVal)
    GetRecordTotalBitRate(bRecordIndex, pbVal)
      => ComCall(12, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetRecordTextW(bRecordIndex, convMode, pbstrText)
      => ComCall(13, this.p, UInt8, bRecordIndex, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrText)
}
struct IIsdbSeriesDescriptor extends IUnknown {
    static IID := "{07EF6370-1660-4F26-87FC-614ADAB24B11}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetSeriesId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetRepeatLabel(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetProgramPattern(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetExpireDate(pfValid, pmdtVal)
      => ComCall(8, this.p, BOOL.Ptr, pfValid, MPEG_DATE_AND_TIME.Ptr, pmdtVal)
    GetEpisodeNumber(pwVal)
      => ComCall(9, this.p, UInt16.Ptr, pwVal)
    GetLastEpisodeNumber(pwVal)
      => ComCall(10, this.p, UInt16.Ptr, pwVal)
    GetSeriesNameW(convMode, pbstrName)
      => ComCall(11, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrName)
}
struct IIsdbDownloadContentDescriptor extends IUnknown {
    static IID := "{5298661E-CB88-4F5F-A1DE-5F440C185B92}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetFlags(pfReboot, pfAddOn, pfCompatibility, pfModuleInfo, pfTextInfo)
      => ComCall(5, this.p, BOOL.Ptr, pfReboot, BOOL.Ptr, pfAddOn, BOOL.Ptr, pfCompatibility, BOOL.Ptr, pfModuleInfo, BOOL.Ptr, pfTextInfo)
    GetComponentSize(pdwVal)
      => ComCall(6, this.p, UInt32.Ptr, pdwVal)
    GetDownloadId(pdwVal)
      => ComCall(7, this.p, UInt32.Ptr, pdwVal)
    GetTimeOutValueDII(pdwVal)
      => ComCall(8, this.p, UInt32.Ptr, pdwVal)
    GetLeakRate(pdwVal)
      => ComCall(9, this.p, UInt32.Ptr, pdwVal)
    GetComponentTag(pbVal)
      => ComCall(10, this.p, UInt8.Ptr, pbVal)
    GetCompatiblityDescriptorLength(pwLength)
      => ComCall(11, this.p, UInt16.Ptr, pwLength)
    GetCompatiblityDescriptor(ppbData)
      => ComCall(12, this.p, UInt8.Ptr.Ptr, ppbData)
    GetCountOfRecords(pwVal)
      => ComCall(13, this.p, UInt16.Ptr, pwVal)
    GetRecordModuleId(wRecordIndex, pwVal)
      => ComCall(14, this.p, UInt16, wRecordIndex, UInt16.Ptr, pwVal)
    GetRecordModuleSize(wRecordIndex, pdwVal)
      => ComCall(15, this.p, UInt16, wRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordModuleInfoLength(wRecordIndex, pbVal)
      => ComCall(16, this.p, UInt16, wRecordIndex, UInt8.Ptr, pbVal)
    GetRecordModuleInfo(wRecordIndex, ppbData)
      => ComCall(17, this.p, UInt16, wRecordIndex, UInt8.Ptr.Ptr, ppbData)
    GetTextLanguageCode(szCode)
      => ComCall(18, this.p, UInt8.Ptr, szCode)
    GetTextW(convMode, pbstrName)
      => ComCall(19, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrName)
}
struct IIsdbLogoTransmissionDescriptor extends IUnknown {
    static IID := "{E0103F49-4AE1-4F07-9098-756DB1FA88CD}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetLogoTransmissionType(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetLogoId(pwVal)
      => ComCall(6, this.p, UInt16.Ptr, pwVal)
    GetLogoVersion(pwVal)
      => ComCall(7, this.p, UInt16.Ptr, pwVal)
    GetDownloadDataId(pwVal)
      => ComCall(8, this.p, UInt16.Ptr, pwVal)
    GetLogoCharW(convMode, pbstrChar)
      => ComCall(9, this.p, DVB_STRCONV_MODE, convMode, BSTR.Ptr, pbstrChar)
}
struct IIsdbSIParameterDescriptor extends IUnknown {
    static IID := "{F837DC36-867C-426A-9111-F62093951A45}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetParameterVersion(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetUpdateTime(pVal)
      => ComCall(6, this.p, MPEG_DATE.Ptr, pVal)
    GetRecordNumberOfTable(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetTableId(bRecordIndex, pbVal)
      => ComCall(8, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetTableDescriptionLength(bRecordIndex, pbVal)
      => ComCall(9, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetTableDescriptionBytes(bRecordIndex, pbBufferLength, pbBuffer)
      => ComCall(10, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbBufferLength, UInt8.Ptr, pbBuffer)
}
struct IIsdbEmergencyInformationDescriptor extends IUnknown {
    static IID := "{BA6FA681-B973-4DA1-9207-AC3E7F0341EB}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCountOfRecords(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetServiceId(bRecordIndex, pwVal)
      => ComCall(6, this.p, UInt8, bRecordIndex, UInt16.Ptr, pwVal)
    GetStartEndFlag(bRecordIndex, pVal)
      => ComCall(7, this.p, UInt8, bRecordIndex, UInt8.Ptr, pVal)
    GetSignalLevel(bRecordIndex, pbVal)
      => ComCall(8, this.p, UInt8, bRecordIndex, UInt8.Ptr, pbVal)
    GetAreaCode(bRecordIndex, ppwVal, pbNumAreaCodes)
      => ComCall(9, this.p, UInt8, bRecordIndex, UInt16.Ptr.Ptr, ppwVal, UInt8.Ptr, pbNumAreaCodes)
}
struct IIsdbCADescriptor extends IUnknown {
    static IID := "{0570AA47-52BC-42AE-8CA5-969F41E81AEA}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCASystemId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetReservedBits(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetCAPID(pwVal)
      => ComCall(7, this.p, UInt16.Ptr, pwVal)
    GetPrivateDataBytes(pbBufferLength, pbBuffer)
      => ComCall(8, this.p, UInt8.Ptr, pbBufferLength, UInt8.Ptr, pbBuffer)
}
struct IIsdbCAServiceDescriptor extends IUnknown {
    static IID := "{39CBEB97-FF0B-42A7-9AB9-7B9CFE70A77A}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetCASystemId(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetCABroadcasterGroupId(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetMessageControl(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetServiceIds(pbNumServiceIds, pwServiceIds)
      => ComCall(8, this.p, UInt8.Ptr, pbNumServiceIds, UInt16.Ptr, pwServiceIds)
}
struct IIsdbHierarchicalTransmissionDescriptor extends IUnknown {
    static IID := "{B7B3AE90-EE0B-446D-8769-F7E2AA266AA6}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetFutureUse1(pbVal)
      => ComCall(5, this.p, UInt8.Ptr, pbVal)
    GetQualityLevel(pbVal)
      => ComCall(6, this.p, UInt8.Ptr, pbVal)
    GetFutureUse2(pbVal)
      => ComCall(7, this.p, UInt8.Ptr, pbVal)
    GetReferencePid(pwVal)
      => ComCall(8, this.p, UInt16.Ptr, pwVal)
}
struct IPBDASiParser extends IUnknown {
    static IID := "{9DE49A74-ABA2-4A18-93E1-21F17F95C3C3}"
    Initialize(punk)
      => ComCall(3, this.p, IUnknown, punk)
    GetEIT(dwSize, pBuffer, ppEIT)
      => ComCall(4, this.p, UInt32, dwSize, UInt8.Ptr, pBuffer, IPBDA_EIT.Ptr, ppEIT)
    GetServices(dwSize, pBuffer, ppServices)
      => ComCall(5, this.p, UInt32, dwSize, UInt8.Ptr, pBuffer, IPBDA_Services.Ptr, ppServices)
}
struct IPBDA_EIT extends IUnknown {
    static IID := "{A35F2DEA-098F-4EBD-984C-2BD4C3C8CE0A}"
    Initialize(pBuffer)
      => ComCall(3, this.p, UInt32, pBuffer.Length, UInt8.Ptr, pBuffer)
    GetTableId(pbVal)
      => ComCall(4, this.p, UInt8.Ptr, pbVal)
    GetVersionNumber(pwVal)
      => ComCall(5, this.p, UInt16.Ptr, pwVal)
    GetServiceIdx(plwVal)
      => ComCall(6, this.p, Int64.Ptr, plwVal)
    GetCountOfRecords(pdwVal)
      => ComCall(7, this.p, UInt32.Ptr, pdwVal)
    GetRecordEventId(dwRecordIndex, plwVal)
      => ComCall(8, this.p, UInt32, dwRecordIndex, Int64.Ptr, plwVal)
    GetRecordStartTime(dwRecordIndex, pmdtVal)
      => ComCall(9, this.p, UInt32, dwRecordIndex, MPEG_DATE_AND_TIME.Ptr, pmdtVal)
    GetRecordDuration(dwRecordIndex, pmdVal)
      => ComCall(10, this.p, UInt32, dwRecordIndex, MPEG_TIME.Ptr, pmdVal)
    GetRecordCountOfDescriptors(dwRecordIndex, pdwVal)
      => ComCall(11, this.p, UInt32, dwRecordIndex, UInt32.Ptr, pdwVal)
    GetRecordDescriptorByIndex(dwRecordIndex, dwIndex, ppDescriptor)
      => ComCall(12, this.p, UInt32, dwRecordIndex, UInt32, dwIndex, IGenericDescriptor.Ptr, ppDescriptor)
    GetRecordDescriptorByTag(dwRecordIndex, bTag, pdwCookie, ppDescriptor)
      => ComCall(13, this.p, UInt32, dwRecordIndex, UInt8, bTag, UInt32.Ptr, pdwCookie, IGenericDescriptor.Ptr, ppDescriptor)
}
struct IPBDA_Services extends IUnknown {
    static IID := "{944EAB37-EED4-4850-AFD2-77E7EFEB4427}"
    Initialize(pBuffer)
      => ComCall(3, this.p, UInt32, pBuffer.Length, UInt8.Ptr, pBuffer)
    GetCountOfRecords(pdwVal)
      => ComCall(4, this.p, UInt32.Ptr, pdwVal)
    GetRecordByIndex(dwRecordIndex, pul64ServiceIdx)
      => ComCall(5, this.p, UInt32, dwRecordIndex, Int64.Ptr, pul64ServiceIdx)
}
struct IPBDAEntitlementDescriptor extends IUnknown {
    static IID := "{22632497-0DE3-4587-AADC-D8D99017E760}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pwVal)
      => ComCall(4, this.p, UInt16.Ptr, pwVal)
    GetToken(ppbTokenBuffer, pdwTokenLength)
      => ComCall(5, this.p, UInt8.Ptr.Ptr, ppbTokenBuffer, UInt32.Ptr, pdwTokenLength)
}
struct IPBDAAttributesDescriptor extends IUnknown {
    static IID := "{313B3620-3263-45A6-9533-968BEFBEAC03}"
    GetTag(pbVal)
      => ComCall(3, this.p, UInt8.Ptr, pbVal)
    GetLength(pwVal)
      => ComCall(4, this.p, UInt16.Ptr, pwVal)
    GetAttributePayload(ppbAttributeBuffer, pdwAttributeLength)
      => ComCall(5, this.p, UInt8.Ptr.Ptr, ppbAttributeBuffer, UInt32.Ptr, pdwAttributeLength)
}
struct IBDA_TIF_REGISTRATION extends IUnknown {
    static IID := "{DFEF4A68-EE61-415F-9CCB-CD95F2F98A3A}"
    RegisterTIFEx(pTIFInputPin, ppvRegistrationContext, ppMpeg2DataControl)
      => ComCall(3, this.p, IPin, pTIFInputPin, UInt32.Ptr, ppvRegistrationContext, IUnknown.Ptr, ppMpeg2DataControl)
    UnregisterTIF(pvRegistrationContext)
      => ComCall(4, this.p, UInt32, pvRegistrationContext)
}
struct IMPEG2_TIF_CONTROL extends IUnknown {
    static IID := "{F9BAC2F9-4149-4916-B2EF-FAA202326862}"
    RegisterTIF(pUnkTIF, ppvRegistrationContext)
      => ComCall(3, this.p, IUnknown, pUnkTIF, UInt32.Ptr, ppvRegistrationContext)
    UnregisterTIF(pvRegistrationContext)
      => ComCall(4, this.p, UInt32, pvRegistrationContext)
    AddPIDs(ulcPIDs, pulPIDs)
      => ComCall(5, this.p, UInt32, ulcPIDs, UInt32.Ptr, pulPIDs)
    DeletePIDs(ulcPIDs, pulPIDs)
      => ComCall(6, this.p, UInt32, ulcPIDs, UInt32.Ptr, pulPIDs)
    GetPIDCount(pulcPIDs)
      => ComCall(7, this.p, UInt32.Ptr, pulcPIDs)
    GetPIDs(pulcPIDs, pulPIDs)
      => ComCall(8, this.p, UInt32.Ptr, pulcPIDs, UInt32.Ptr, pulPIDs)
}
struct ITuneRequestInfo extends IUnknown {
    static IID := "{A3B152DF-7A90-4218-AC54-9830BEE8C0B6}"
    GetLocatorData(Request)
      => ComCall(3, this.p, ITuneRequest, Request)
    GetComponentData(CurrentRequest)
      => ComCall(4, this.p, ITuneRequest, CurrentRequest)
    CreateComponentList(CurrentRequest)
      => ComCall(5, this.p, ITuneRequest, CurrentRequest)
    GetNextProgram(CurrentRequest, TuneRequest)
      => ComCall(6, this.p, ITuneRequest, CurrentRequest, ITuneRequest.Ptr, TuneRequest)
    GetPreviousProgram(CurrentRequest, TuneRequest)
      => ComCall(7, this.p, ITuneRequest, CurrentRequest, ITuneRequest.Ptr, TuneRequest)
    GetNextLocator(CurrentRequest, TuneRequest)
      => ComCall(8, this.p, ITuneRequest, CurrentRequest, ITuneRequest.Ptr, TuneRequest)
    GetPreviousLocator(CurrentRequest, TuneRequest)
      => ComCall(9, this.p, ITuneRequest, CurrentRequest, ITuneRequest.Ptr, TuneRequest)
}
struct ITuneRequestInfoEx extends ITuneRequestInfo {
    static IID := "{EE957C52-B0D0-4E78-8DD1-B87A08BFD893}"
    CreateComponentListEx(CurrentRequest, ppCurPMT)
      => ComCall(10, this.p, ITuneRequest, CurrentRequest, IUnknown.Ptr, ppCurPMT)
}
struct ISIInbandEPGEvent extends IUnknown {
    static IID := "{7E47913A-5A89-423D-9A2B-E15168858934}"
    SIObjectEvent(pIDVB_EIT, dwTable_ID, dwService_ID)
      => ComCall(3, this.p, IDVB_EIT2, pIDVB_EIT, UInt32, dwTable_ID, UInt32, dwService_ID)
}
struct ISIInbandEPG extends IUnknown {
    static IID := "{F90AD9D0-B854-4B68-9CC1-B2CC96119D85}"
    StartSIEPGScan()
      => ComCall(3, this.p)
    StopSIEPGScan()
      => ComCall(4, this.p)
    IsSIEPGScanRunning(bRunning)
      => ComCall(5, this.p, BOOL.Ptr, bRunning)
}
struct IGuideDataEvent extends IUnknown {
    static IID := "{EFDA0C80-F395-42C3-9B3C-56B37DEC7BB7}"
    GuideDataAcquired()
      => ComCall(3, this.p)
    ProgramChanged(varProgramDescriptionID)
      => ComCall(4, this.p, VARIANT, varProgramDescriptionID)
    ServiceChanged(varServiceDescriptionID)
      => ComCall(5, this.p, VARIANT, varServiceDescriptionID)
    ScheduleEntryChanged(varScheduleEntryDescriptionID)
      => ComCall(6, this.p, VARIANT, varScheduleEntryDescriptionID)
    ProgramDeleted(varProgramDescriptionID)
      => ComCall(7, this.p, VARIANT, varProgramDescriptionID)
    ServiceDeleted(varServiceDescriptionID)
      => ComCall(8, this.p, VARIANT, varServiceDescriptionID)
    ScheduleDeleted(varScheduleEntryDescriptionID)
      => ComCall(9, this.p, VARIANT, varScheduleEntryDescriptionID)
}
struct IGuideDataProperty extends IUnknown {
    static IID := "{88EC5E58-BB73-41D6-99CE-66C524B8B591}"
    get_Name(pbstrName)
      => ComCall(3, this.p, BSTR.Ptr, pbstrName)
    get_Language(idLang)
      => ComCall(4, this.p, Int32.Ptr, idLang)
    get_Value(pvar)
      => ComCall(5, this.p, VARIANT.Ptr, pvar)
}
struct IEnumGuideDataProperties extends IUnknown {
    static IID := "{AE44423B-4571-475C-AD2C-F40A771D80EF}"
    Next(celt, ppprop, pcelt)
      => ComCall(3, this.p, UInt32, celt, IGuideDataProperty.Ptr, ppprop, UInt32.Ptr, pcelt)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumGuideDataProperties.Ptr, ppenum)
}
struct IEnumTuneRequests extends IUnknown {
    static IID := "{1993299C-CED6-4788-87A3-420067DCE0C7}"
    Next(celt, ppprop, pcelt)
      => ComCall(3, this.p, UInt32, celt, ITuneRequest.Ptr, ppprop, UInt32.Ptr, pcelt)
    Skip(celt)
      => ComCall(4, this.p, UInt32, celt)
    Reset()
      => ComCall(5, this.p)
    Clone(ppenum)
      => ComCall(6, this.p, IEnumTuneRequests.Ptr, ppenum)
}
struct IGuideData extends IUnknown {
    static IID := "{61571138-5B01-43CD-AEAF-60B784A0BF93}"
    GetServices(ppEnumTuneRequests)
      => ComCall(3, this.p, IEnumTuneRequests.Ptr, ppEnumTuneRequests)
    GetServiceProperties(pTuneRequest, ppEnumProperties)
      => ComCall(4, this.p, ITuneRequest, pTuneRequest, IEnumGuideDataProperties.Ptr, ppEnumProperties)
    GetGuideProgramIDs(pEnumPrograms)
      => ComCall(5, this.p, IEnumVARIANT.Ptr, pEnumPrograms)
    GetProgramProperties(varProgramDescriptionID, ppEnumProperties)
      => ComCall(6, this.p, VARIANT, varProgramDescriptionID, IEnumGuideDataProperties.Ptr, ppEnumProperties)
    GetScheduleEntryIDs(pEnumScheduleEntries)
      => ComCall(7, this.p, IEnumVARIANT.Ptr, pEnumScheduleEntries)
    GetScheduleEntryProperties(varScheduleEntryDescriptionID, ppEnumProperties)
      => ComCall(8, this.p, VARIANT, varScheduleEntryDescriptionID, IEnumGuideDataProperties.Ptr, ppEnumProperties)
}
struct IGuideDataLoader extends IUnknown {
    static IID := "{4764FF7C-FA95-4525-AF4D-D32236DB9E38}"
    Init(pGuideStore)
      => ComCall(3, this.p, IGuideData, pGuideStore)
    Terminate()
      => ComCall(4, this.p)
}
struct KSP_BDA_NODE_PIN {
    Property : KSIDENTIFIER
    ulNodeType : UInt32
    ulInputPinId : UInt32
    ulOutputPinId : UInt32
}
struct KSM_BDA_PIN {
    Method : KSIDENTIFIER
    Anonymous : this._Anonymous_e__Union
    Reserved : UInt32
    struct _Anonymous_e__Union {
        union {
            PinId : UInt32
            PinType : UInt32
        }
    }
}
struct KSM_BDA_PIN_PAIR {
    Method : KSIDENTIFIER
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            InputPinId : UInt32
            InputPinType : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            OutputPinId : UInt32
            OutputPinType : UInt32
        }
    }
}
struct KSP_NODE_ESPID {
    Property : KSP_NODE
    EsPid : UInt32
}
struct KSM_BDA_DEBUG_LEVEL {
    Method : KSIDENTIFIER
    ucDebugLevel : UInt8
    ulDebugStringSize : UInt32
    argbDebugString : UInt8[1]
}
struct BDA_DEBUG_DATA {
    lResult : Int32
    uuidDebugDataType : GUID
    ulDataSize : UInt32
    argbDebugData : UInt8[1]
}
struct BDA_EVENT_DATA {
    lResult : Int32
    ulEventID : UInt32
    uuidEventType : GUID
    ulEventDataLength : UInt32
    argbEventData : UInt8[1]
}
struct KSM_BDA_EVENT_COMPLETE {
    Method : KSIDENTIFIER
    ulEventID : UInt32
    ulEventResult : UInt32
}
struct KSM_BDA_DRM_SETDRM {
    NodeMethod : KSM_NODE
    NewDRMuuid : GUID
}
struct KSM_BDA_BUFFER {
    NodeMethod : KSM_NODE
    ulBufferSize : UInt32
    argbBuffer : UInt8[1]
}
struct KSM_BDA_WMDRM_LICENSE {
    NodeMethod : KSM_NODE
    uuidKeyID : GUID
}
struct KSM_BDA_WMDRM_RENEWLICENSE {
    NodeMethod : KSM_NODE
    ulXMRLicenseLength : UInt32
    ulEntitlementTokenLength : UInt32
    argbDataBuffer : UInt8[1]
}
struct KSM_BDA_WMDRMTUNER_PURCHASEENTITLEMENT {
    NodeMethod : KSM_NODE
    ulDialogRequest : UInt32
    cLanguage : CHAR[12]
    ulPurchaseTokenLength : UInt32
    argbDataBuffer : UInt8[1]
}
struct KSM_BDA_WMDRMTUNER_SETPIDPROTECTION {
    NodeMethod : KSM_NODE
    ulPID : UInt32
    uuidKeyID : GUID
}
struct KSM_BDA_WMDRMTUNER_GETPIDPROTECTION {
    NodeMethod : KSM_NODE
    ulPID : UInt32
}
struct KSM_BDA_WMDRMTUNER_SYNCVALUE {
    NodeMethod : KSM_NODE
    ulSyncValue : UInt32
}
struct KSM_BDA_TUNER_TUNEREQUEST {
    Method : KSIDENTIFIER
    ulTuneLength : UInt32
    argbTuneData : UInt8[1]
}
struct KSM_BDA_GPNV_GETVALUE {
    Method : KSIDENTIFIER
    ulNameLength : UInt32
    cLanguage : CHAR[12]
    argbData : UInt8[1]
}
struct KSM_BDA_GPNV_SETVALUE {
    Method : KSIDENTIFIER
    ulDialogRequest : UInt32
    cLanguage : CHAR[12]
    ulNameLength : UInt32
    ulValueLength : UInt32
    argbName : UInt8[1]
}
struct KSM_BDA_GPNV_NAMEINDEX {
    Method : KSIDENTIFIER
    ulValueNameIndex : UInt32
}
struct KSM_BDA_SCAN_CAPABILTIES {
    Method : KSIDENTIFIER
    uuidBroadcastStandard : GUID
}
struct KSM_BDA_SCAN_FILTER {
    Method : KSIDENTIFIER
    ulScanModulationTypeSize : UInt32
    AnalogVideoStandards : Int64
    argbScanModulationTypes : UInt8[1]
}
struct KSM_BDA_SCAN_START {
    Method : KSIDENTIFIER
    LowerFrequency : UInt32
    HigherFrequency : UInt32
}
struct KSM_BDA_GDDS_TUNEXMLFROMIDX {
    Method : KSIDENTIFIER
    ulIdx : Int64
}
struct KSM_BDA_GDDS_SERVICEFROMTUNEXML {
    Method : KSIDENTIFIER
    ulTuneXmlLength : UInt32
    argbTuneXml : UInt8[1]
}
struct KSM_BDA_USERACTIVITY_USEREASON {
    Method : KSIDENTIFIER
    ulUseReason : UInt32
}
struct KSM_BDA_CAS_ENTITLEMENTTOKEN {
    NodeMethod : KSM_NODE
    ulDialogRequest : UInt32
    cLanguage : CHAR[12]
    ulRequestType : UInt32
    ulEntitlementTokenLen : UInt32
    argbEntitlementToken : UInt8[1]
}
struct KSM_BDA_CAS_CAPTURETOKEN {
    NodeMethod : KSM_NODE
    ulTokenLength : UInt32
    argbToken : UInt8[1]
}
struct KSM_BDA_CAS_OPENBROADCASTMMI {
    NodeMethod : KSM_NODE
    ulDialogRequest : UInt32
    cLanguage : CHAR[12]
    ulEventId : UInt32
}
struct KSM_BDA_CAS_CLOSEMMIDIALOG {
    NodeMethod : KSM_NODE
    ulDialogRequest : UInt32
    cLanguage : CHAR[12]
    ulDialogNumber : UInt32
    ulReason : UInt32
}
struct KSM_BDA_ISDBCAS_REQUEST {
    NodeMethod : KSM_NODE
    ulRequestID : UInt32
    ulIsdbCommandSize : UInt32
    argbIsdbCommandData : UInt8[1]
}
struct KSM_BDA_TS_SELECTOR_SETTSID {
    NodeMethod : KSM_NODE
    usTSID : UInt16
}
struct KS_DATARANGE_BDA_ANTENNA {
    DataRange : KSDATAFORMAT
}
struct BDA_TRANSPORT_INFO {
    ulcbPhyiscalPacket : UInt32
    ulcbPhyiscalFrame : UInt32
    ulcbPhyiscalFrameAlignment : UInt32
    AvgTimePerFrame : Int64
}
struct KS_DATARANGE_BDA_TRANSPORT {
    DataRange : KSDATAFORMAT
    BdaTransportInfo : BDA_TRANSPORT_INFO
}
struct ChannelChangeSpanningEvent_State extends Int32 {
    static ChannelChangeSpanningEvent_Start := 0
    static ChannelChangeSpanningEvent_End := 2
}
struct ChannelChangeInfo {
    state : ChannelChangeSpanningEvent_State
    TimeStamp : Int64
}
struct ChannelType extends Int32 {
    static ChannelTypeNone := 0
    static ChannelTypeOther := 1
    static ChannelTypeVideo := 2
    static ChannelTypeAudio := 4
    static ChannelTypeText := 8
    static ChannelTypeSubtitles := 16
    static ChannelTypeCaptions := 32
    static ChannelTypeSuperimpose := 64
    static ChannelTypeData := 128
}
struct ChannelTypeInfo {
    channelType : ChannelType
    timeStamp : Int64
}
struct ChannelInfo {
    lFrequency : Int32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            DVB : this._DVB_e__Struct
            DC : this._DC_e__Struct
            ATSC : this._ATSC_e__Struct
        }
        struct _DVB_e__Struct {
            lONID : Int32
            lTSID : Int32
            lSID : Int32
        }
        struct _DC_e__Struct {
            lProgNumber : Int32
        }
        struct _ATSC_e__Struct {
            lProgNumber : Int32
        }
    }
}
struct SpanningEventDescriptor {
    wDataLen : UInt16
    wProgNumber : UInt16
    wSID : UInt16
    bDescriptor : UInt8[1]
}
struct DVBScramblingControlSpanningEvent {
    ulPID : UInt32
    fScrambled : BOOL
}
struct SignalAndServiceStatusSpanningEvent_State extends Int32 {
    static SignalAndServiceStatusSpanningEvent_None := -1
    static SignalAndServiceStatusSpanningEvent_Clear := 0
    static SignalAndServiceStatusSpanningEvent_NoTVSignal := 1
    static SignalAndServiceStatusSpanningEvent_ServiceOffAir := 2
    static SignalAndServiceStatusSpanningEvent_WeakTVSignal := 3
    static SignalAndServiceStatusSpanningEvent_NoSubscription := 4
    static SignalAndServiceStatusSpanningEvent_AllAVScrambled := 5
}
struct SpanningEventEmmMessage {
    bCAbroadcasterGroupId : UInt8
    bMessageControl : UInt8
    wServiceId : UInt16
    wTableIdExtension : UInt16
    bDeletionStatus : UInt8
    bDisplayingDuration1 : UInt8
    bDisplayingDuration2 : UInt8
    bDisplayingDuration3 : UInt8
    bDisplayingCycle : UInt8
    bFormatVersion : UInt8
    bDisplayPosition : UInt8
    wMessageLength : UInt16
    szMessageArea : UInt16[1]
}
struct LanguageInfo {
    LangID : UInt16
    lISOLangCode : Int32
}
struct DualMonoInfo {
    LangID1 : UInt16
    LangID2 : UInt16
    lISOLangCode1 : Int32
    lISOLangCode2 : Int32
}
struct PIDListSpanningEvent {
    wPIDCount : UInt16
    pulPIDs : UInt32[1]
}
struct RATING_ATTRIBUTE {
    rating_attribute_id : UInt32
    rating_attribute_value : UInt32
}
struct RATING_SYSTEM {
    rating_system_id : GUID
    _bitfield : UInt8
    country_code : UInt8[3]
    rating_attribute_count : UInt32
    lpratingattrib : RATING_ATTRIBUTE.Ptr
}
struct RATING_INFO {
    rating_system_count : UInt32
    lpratingsystem : RATING_SYSTEM.Ptr
}
struct PBDAParentalControl {
    rating_system_count : UInt32
    rating_systems : RATING_SYSTEM.Ptr
}
struct DvbParentalRatingParam {
    szCountryCode : CHAR[4]
    bRating : UInt8
}
struct DvbParentalRatingDescriptor {
    ulNumParams : UInt32
    pParams : DvbParentalRatingParam[1]
}
struct KSPROPERTY_BDA_ETHERNET_FILTER extends Int32 {
    static KSPROPERTY_BDA_ETHERNET_FILTER_MULTICAST_LIST_SIZE := 0
    static KSPROPERTY_BDA_ETHERNET_FILTER_MULTICAST_LIST := 1
    static KSPROPERTY_BDA_ETHERNET_FILTER_MULTICAST_MODE := 2
}
struct KSPROPERTY_BDA_IPv4_FILTER extends Int32 {
    static KSPROPERTY_BDA_IPv4_FILTER_MULTICAST_LIST_SIZE := 0
    static KSPROPERTY_BDA_IPv4_FILTER_MULTICAST_LIST := 1
    static KSPROPERTY_BDA_IPv4_FILTER_MULTICAST_MODE := 2
}
struct KSPROPERTY_BDA_IPv6_FILTER extends Int32 {
    static KSPROPERTY_BDA_IPv6_FILTER_MULTICAST_LIST_SIZE := 0
    static KSPROPERTY_BDA_IPv6_FILTER_MULTICAST_LIST := 1
    static KSPROPERTY_BDA_IPv6_FILTER_MULTICAST_MODE := 2
}
struct KSPROPERTY_BDA_SIGNAL_STATS extends Int32 {
    static KSPROPERTY_BDA_SIGNAL_STRENGTH := 0
    static KSPROPERTY_BDA_SIGNAL_QUALITY := 1
    static KSPROPERTY_BDA_SIGNAL_PRESENT := 2
    static KSPROPERTY_BDA_SIGNAL_LOCKED := 3
    static KSPROPERTY_BDA_SAMPLE_TIME := 4
    static KSPROPERTY_BDA_SIGNAL_LOCK_CAPS := 5
    static KSPROPERTY_BDA_SIGNAL_LOCK_TYPE := 6
}
struct BDA_LockType extends Int32 {
    static Bda_LockType_None := 0
    static Bda_LockType_PLL := 1
    static Bda_LockType_DecoderDemod := 2
    static Bda_LockType_Complete := 128
}
struct KSMETHOD_BDA_CHANGE_SYNC extends Int32 {
    static KSMETHOD_BDA_START_CHANGES := 0
    static KSMETHOD_BDA_CHECK_CHANGES := 1
    static KSMETHOD_BDA_COMMIT_CHANGES := 2
    static KSMETHOD_BDA_GET_CHANGE_STATE := 3
}
struct KSMETHOD_BDA_DEVICE_CONFIGURATION extends Int32 {
    static KSMETHOD_BDA_CREATE_PIN_FACTORY := 0
    static KSMETHOD_BDA_DELETE_PIN_FACTORY := 1
    static KSMETHOD_BDA_CREATE_TOPOLOGY := 2
}
struct KSPROPERTY_BDA_TOPOLOGY extends Int32 {
    static KSPROPERTY_BDA_NODE_TYPES := 0
    static KSPROPERTY_BDA_PIN_TYPES := 1
    static KSPROPERTY_BDA_TEMPLATE_CONNECTIONS := 2
    static KSPROPERTY_BDA_NODE_METHODS := 3
    static KSPROPERTY_BDA_NODE_PROPERTIES := 4
    static KSPROPERTY_BDA_NODE_EVENTS := 5
    static KSPROPERTY_BDA_CONTROLLING_PIN_ID := 6
    static KSPROPERTY_BDA_NODE_DESCRIPTORS := 7
}
struct KSPROPERTY_BDA_PIN_CONTROL extends Int32 {
    static KSPROPERTY_BDA_PIN_ID := 0
    static KSPROPERTY_BDA_PIN_TYPE := 1
}
struct KSPROPERTY_BDA_PIN_EVENT extends Int32 {
    static KSEVENT_BDA_PIN_CONNECTED := 0
    static KSEVENT_BDA_PIN_DISCONNECTED := 1
}
struct KSPROPERTY_BDA_VOID_TRANSFORM extends Int32 {
    static KSPROPERTY_BDA_VOID_TRANSFORM_START := 0
    static KSPROPERTY_BDA_VOID_TRANSFORM_STOP := 1
}
struct KSPROPERTY_BDA_NULL_TRANSFORM extends Int32 {
    static KSPROPERTY_BDA_NULL_TRANSFORM_START := 0
    static KSPROPERTY_BDA_NULL_TRANSFORM_STOP := 1
}
struct KSPROPERTY_BDA_FREQUENCY_FILTER extends Int32 {
    static KSPROPERTY_BDA_RF_TUNER_FREQUENCY := 0
    static KSPROPERTY_BDA_RF_TUNER_POLARITY := 1
    static KSPROPERTY_BDA_RF_TUNER_RANGE := 2
    static KSPROPERTY_BDA_RF_TUNER_TRANSPONDER := 3
    static KSPROPERTY_BDA_RF_TUNER_BANDWIDTH := 4
    static KSPROPERTY_BDA_RF_TUNER_FREQUENCY_MULTIPLIER := 5
    static KSPROPERTY_BDA_RF_TUNER_CAPS := 6
    static KSPROPERTY_BDA_RF_TUNER_SCAN_STATUS := 7
    static KSPROPERTY_BDA_RF_TUNER_STANDARD := 8
    static KSPROPERTY_BDA_RF_TUNER_STANDARD_MODE := 9
}
struct BDA_SignalType extends Int32 {
    static Bda_SignalType_Unknown := 0
    static Bda_SignalType_Analog := 1
    static Bda_SignalType_Digital := 2
}
struct BDA_DigitalSignalStandard extends Int32 {
    static Bda_DigitalStandard_None := 0
    static Bda_DigitalStandard_DVB_T := 1
    static Bda_DigitalStandard_DVB_S := 2
    static Bda_DigitalStandard_DVB_C := 4
    static Bda_DigitalStandard_ATSC := 8
    static Bda_DigitalStandard_ISDB_T := 16
    static Bda_DigitalStandard_ISDB_S := 32
    static Bda_DigitalStandard_ISDB_C := 64
}
struct KSPROPERTY_BDA_RF_TUNER_CAPS_S {
    Property : KSP_NODE
    Mode : UInt32
    AnalogStandardsSupported : UInt32
    DigitalStandardsSupported : UInt32
    MinFrequency : UInt32
    MaxFrequency : UInt32
    SettlingTime : UInt32
    AnalogSensingRange : UInt32
    DigitalSensingRange : UInt32
    MilliSecondsPerMHz : UInt32
}
struct KSPROPERTY_BDA_RF_TUNER_SCAN_STATUS_S {
    Property : KSP_NODE
    CurrentFrequency : UInt32
    FrequencyRangeMin : UInt32
    FrequencyRangeMax : UInt32
    MilliSecondsLeft : UInt32
}
struct KSPROPERTY_BDA_RF_TUNER_STANDARD_S {
    Property : KSP_NODE
    SignalType : BDA_SignalType
    SignalStandard : UInt32
}
struct KSPROPERTY_BDA_RF_TUNER_STANDARD_MODE_S {
    Property : KSP_NODE
    AutoDetect : BOOL
}
struct KSEVENT_BDA_TUNER extends Int32 {
    static KSEVENT_BDA_TUNER_SCAN := 0
}
struct KSEVENTDATA_BDA_RF_TUNER_SCAN_S {
    EventData : KSEVENTDATA
    StartFrequency : UInt32
    EndFrequency : UInt32
    LockRequested : BDA_LockType
}
struct KSPROPERTY_BDA_LNB_INFO extends Int32 {
    static KSPROPERTY_BDA_LNB_LOF_LOW_BAND := 0
    static KSPROPERTY_BDA_LNB_LOF_HIGH_BAND := 1
    static KSPROPERTY_BDA_LNB_SWITCH_FREQUENCY := 2
}
struct KSPROPERTY_BDA_DISEQC_COMMAND extends Int32 {
    static KSPROPERTY_BDA_DISEQC_ENABLE := 0
    static KSPROPERTY_BDA_DISEQC_LNB_SOURCE := 1
    static KSPROPERTY_BDA_DISEQC_USETONEBURST := 2
    static KSPROPERTY_BDA_DISEQC_REPEATS := 3
    static KSPROPERTY_BDA_DISEQC_SEND := 4
    static KSPROPERTY_BDA_DISEQC_RESPONSE := 5
}
struct KSPROPERTY_BDA_DISEQC_EVENT extends Int32 {
    static KSEVENT_BDA_DISEQC_DATA_RECEIVED := 0
}
struct KSPROPERTY_BDA_DIGITAL_DEMODULATOR extends Int32 {
    static KSPROPERTY_BDA_MODULATION_TYPE := 0
    static KSPROPERTY_BDA_INNER_FEC_TYPE := 1
    static KSPROPERTY_BDA_INNER_FEC_RATE := 2
    static KSPROPERTY_BDA_OUTER_FEC_TYPE := 3
    static KSPROPERTY_BDA_OUTER_FEC_RATE := 4
    static KSPROPERTY_BDA_SYMBOL_RATE := 5
    static KSPROPERTY_BDA_SPECTRAL_INVERSION := 6
    static KSPROPERTY_BDA_GUARD_INTERVAL := 7
    static KSPROPERTY_BDA_TRANSMISSION_MODE := 8
    static KSPROPERTY_BDA_ROLL_OFF := 9
    static KSPROPERTY_BDA_PILOT := 10
    static KSPROPERTY_BDA_SIGNALTIMEOUTS := 11
    static KSPROPERTY_BDA_PLP_NUMBER := 12
}
struct KSPROPERTY_BDA_AUTODEMODULATE extends Int32 {
    static KSPROPERTY_BDA_AUTODEMODULATE_START := 0
    static KSPROPERTY_BDA_AUTODEMODULATE_STOP := 1
}
struct KSPROPERTY_IDS_BDA_TABLE extends Int32 {
    static KSPROPERTY_BDA_TABLE_SECTION := 0
}
struct KSPROPERTY_BDA_PIDFILTER extends Int32 {
    static KSPROPERTY_BDA_PIDFILTER_MAP_PIDS := 0
    static KSPROPERTY_BDA_PIDFILTER_UNMAP_PIDS := 1
    static KSPROPERTY_BDA_PIDFILTER_LIST_PIDS := 2
}
struct KSPROPERTY_BDA_CA extends Int32 {
    static KSPROPERTY_BDA_ECM_MAP_STATUS := 0
    static KSPROPERTY_BDA_CA_MODULE_STATUS := 1
    static KSPROPERTY_BDA_CA_SMART_CARD_STATUS := 2
    static KSPROPERTY_BDA_CA_MODULE_UI := 3
    static KSPROPERTY_BDA_CA_SET_PROGRAM_PIDS := 4
    static KSPROPERTY_BDA_CA_REMOVE_PROGRAM := 5
}
struct KSPROPERTY_BDA_CA_EVENT extends Int32 {
    static KSEVENT_BDA_PROGRAM_FLOW_STATUS_CHANGED := 0
    static KSEVENT_BDA_CA_MODULE_STATUS_CHANGED := 1
    static KSEVENT_BDA_CA_SMART_CARD_STATUS_CHANGED := 2
    static KSEVENT_BDA_CA_MODULE_UI_REQUESTED := 3
}
struct KSMETHOD_BDA_DRM extends Int32 {
    static KSMETHOD_BDA_DRM_CURRENT := 0
    static KSMETHOD_BDA_DRM_DRMSTATUS := 1
}
struct KSMETHOD_BDA_WMDRM extends Int32 {
    static KSMETHOD_BDA_WMDRM_STATUS := 0
    static KSMETHOD_BDA_WMDRM_REVINFO := 1
    static KSMETHOD_BDA_WMDRM_CRL := 2
    static KSMETHOD_BDA_WMDRM_MESSAGE := 3
    static KSMETHOD_BDA_WMDRM_REISSUELICENSE := 4
    static KSMETHOD_BDA_WMDRM_RENEWLICENSE := 5
    static KSMETHOD_BDA_WMDRM_LICENSE := 6
    static KSMETHOD_BDA_WMDRM_KEYINFO := 7
}
struct KSMETHOD_BDA_WMDRM_TUNER extends Int32 {
    static KSMETHOD_BDA_WMDRMTUNER_CANCELCAPTURETOKEN := 0
    static KSMETHOD_BDA_WMDRMTUNER_SETPIDPROTECTION := 1
    static KSMETHOD_BDA_WMDRMTUNER_GETPIDPROTECTION := 2
    static KSMETHOD_BDA_WMDRMTUNER_SETSYNCVALUE := 3
    static KSMETHOD_BDA_WMDRMTUNER_STARTCODEPROFILE := 4
    static KSMETHOD_BDA_WMDRMTUNER_PURCHASE_ENTITLEMENT := 5
}
struct KSMETHOD_BDA_EVENTING_SERVICE extends Int32 {
    static KSMETHOD_BDA_EVENT_DATA := 0
    static KSMETHOD_BDA_EVENT_COMPLETE := 1
}
struct KSEVENT_BDA_EVENT_TYPE extends Int32 {
    static KSEVENT_BDA_EVENT_PENDINGEVENT := 0
}
struct KSMETHOD_BDA_DEBUG_SERVICE extends Int32 {
    static KSMETHOD_BDA_DEBUG_LEVEL := 0
    static KSMETHOD_BDA_DEBUG_DATA := 1
}
struct KSMETHOD_BDA_TUNER_SERVICE extends Int32 {
    static KSMETHOD_BDA_TUNER_SETTUNER := 0
    static KSMETHOD_BDA_TUNER_GETTUNERSTATE := 1
    static KSMETHOD_BDA_TUNER_SIGNALNOISERATIO := 2
}
struct KSMETHOD_BDA_GPNV_SERVICE extends Int32 {
    static KSMETHOD_BDA_GPNV_GETVALUE := 0
    static KSMETHOD_BDA_GPNV_SETVALUE := 1
    static KSMETHOD_BDA_GPNV_NAMEFROMINDEX := 2
    static KSMETHOD_BDA_GPNV_GETVALUEUPDATENAME := 3
}
struct KSMETHOD_BDA_MUX_SERVICE extends Int32 {
    static KSMETHOD_BDA_MUX_GETPIDLIST := 0
    static KSMETHOD_BDA_MUX_SETPIDLIST := 1
}
struct KSMETHOD_BDA_SCAN_SERVICE extends Int32 {
    static KSMETHOD_BDA_SCAN_CAPABILTIES := 0
    static KSMETHOD_BDA_SCANNING_STATE := 1
    static KSMETHOD_BDA_SCAN_FILTER := 2
    static KSMETHOD_BDA_SCAN_START := 3
    static KSMETHOD_BDA_SCAN_RESUME := 4
    static KSMETHOD_BDA_SCAN_STOP := 5
}
struct KSMETHOD_BDA_GDDS_SERVICE extends Int32 {
    static KSMETHOD_BDA_GDDS_DATATYPE := 0
    static KSMETHOD_BDA_GDDS_DATA := 1
    static KSMETHOD_BDA_GDDS_TUNEXMLFROMIDX := 2
    static KSMETHOD_BDA_GDDS_GETSERVICES := 3
    static KSMETHOD_BDA_GDDS_SERVICEFROMTUNEXML := 4
    static KSMETHOD_BDA_GDDS_DATAUPDATE := 5
}
struct KSMETHOD_BDA_CAS_SERVICE extends Int32 {
    static KSMETHOD_BDA_CAS_CHECKENTITLEMENTTOKEN := 0
    static KSMETHOD_BDA_CAS_SETCAPTURETOKEN := 1
    static KSMETHOD_BDA_CAS_OPENBROADCASTMMI := 2
    static KSMETHOD_BDA_CAS_CLOSEMMIDIALOG := 3
}
struct KSMETHOD_BDA_ISDB_CAS extends Int32 {
    static KSMETHOD_BDA_ISDBCAS_SETREQUEST := 0
    static KSMETHOD_BDA_ISDBCAS_RESPONSEDATA := 1
}
struct KSMETHOD_BDA_TS_SELECTOR extends Int32 {
    static KSMETHOD_BDA_TS_SELECTOR_SETTSID := 0
    static KSMETHOD_BDA_TS_SELECTOR_GETTSINFORMATION := 1
}
struct KSMETHOD_BDA_USERACTIVITY_SERVICE extends Int32 {
    static KSMETHOD_BDA_USERACTIVITY_USEREASON := 0
    static KSMETHOD_BDA_USERACTIVITY_INTERVAL := 1
    static KSMETHOD_BDA_USERACTIVITY_DETECTED := 2
}
struct PID_BITS {
    _bitfield : UInt16
}
struct MPEG_HEADER_BITS {
    _bitfield : UInt16
}
struct MPEG_HEADER_VERSION_BITS {
    _bitfield : UInt8
}
