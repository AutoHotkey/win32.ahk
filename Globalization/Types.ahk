#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, CHAR, HRESULT, HWND, LPARAM, PSTR, PWSTR}
#Import "..\Graphics.Gdi\Types.ahk" {AXESLISTA, AXESLISTW, HDC, HFONT, NEWTEXTMETRICA, NEWTEXTMETRICW}
#Import "..\System.Com\Types.ahk" {IEnumString, IStream, IUnknown}

struct FOLD_STRING_MAP_FLAGS extends UInt32 {
    static MAP_COMPOSITE := 64
    static MAP_EXPAND_LIGATURES := 8192
    static MAP_FOLDCZONE := 16
    static MAP_FOLDDIGITS := 128
    static MAP_PRECOMPOSED := 32
}
struct ENUM_DATE_FORMATS_FLAGS extends UInt32 {
    static DATE_SHORTDATE := 1
    static DATE_LONGDATE := 2
    static DATE_YEARMONTH := 8
    static DATE_MONTHDAY := 128
    static DATE_AUTOLAYOUT := 64
    static DATE_LTRREADING := 16
    static DATE_RTLREADING := 32
    static DATE_USE_ALT_CALENDAR := 4
}
struct TRANSLATE_CHARSET_INFO_FLAGS extends UInt32 {
    static TCI_SRCCHARSET := 1
    static TCI_SRCCODEPAGE := 2
    static TCI_SRCFONTSIG := 3
    static TCI_SRCLOCALE := 4096
}
struct TIME_FORMAT_FLAGS extends UInt32 {
    static TIME_NOMINUTESORSECONDS := 1
    static TIME_NOSECONDS := 2
    static TIME_NOTIMEMARKER := 4
    static TIME_FORCE24HOURFORMAT := 8
}
struct ENUM_SYSTEM_LANGUAGE_GROUPS_FLAGS extends UInt32 {
    static LGRPID_INSTALLED := 1
    static LGRPID_SUPPORTED := 2
}
struct MULTI_BYTE_TO_WIDE_CHAR_FLAGS extends UInt32 {
    static MB_COMPOSITE := 2
    static MB_ERR_INVALID_CHARS := 8
    static MB_PRECOMPOSED := 1
    static MB_USEGLYPHCHARS := 4
}
struct COMPARE_STRING_FLAGS extends UInt32 {
    static LINGUISTIC_IGNORECASE := 16
    static LINGUISTIC_IGNOREDIACRITIC := 32
    static NORM_IGNORECASE := 1
    static NORM_IGNOREKANATYPE := 65536
    static NORM_IGNORENONSPACE := 2
    static NORM_IGNORESYMBOLS := 4
    static NORM_IGNOREWIDTH := 131072
    static NORM_LINGUISTIC_CASING := 134217728
    static SORT_DIGITSASNUMBERS := 8
    static SORT_STRINGSORT := 4096
}
struct IS_VALID_LOCALE_FLAGS extends UInt32 {
    static LCID_INSTALLED := 1
    static LCID_SUPPORTED := 2
}
struct ENUM_SYSTEM_CODE_PAGES_FLAGS extends UInt32 {
    static CP_INSTALLED := 1
    static CP_SUPPORTED := 2
}
struct SCRIPT_IS_COMPLEX_FLAGS extends UInt32 {
    static SIC_ASCIIDIGIT := 2
    static SIC_COMPLEX := 1
    static SIC_NEUTRAL := 4
}
struct IS_TEXT_UNICODE_RESULT extends UInt32 {
    static IS_TEXT_UNICODE_ASCII16 := 1
    static IS_TEXT_UNICODE_REVERSE_ASCII16 := 16
    static IS_TEXT_UNICODE_STATISTICS := 2
    static IS_TEXT_UNICODE_REVERSE_STATISTICS := 32
    static IS_TEXT_UNICODE_CONTROLS := 4
    static IS_TEXT_UNICODE_REVERSE_CONTROLS := 64
    static IS_TEXT_UNICODE_SIGNATURE := 8
    static IS_TEXT_UNICODE_REVERSE_SIGNATURE := 128
    static IS_TEXT_UNICODE_ILLEGAL_CHARS := 256
    static IS_TEXT_UNICODE_ODD_LENGTH := 512
    static IS_TEXT_UNICODE_NULL_BYTES := 4096
    static IS_TEXT_UNICODE_UNICODE_MASK := 15
    static IS_TEXT_UNICODE_REVERSE_MASK := 240
    static IS_TEXT_UNICODE_NOT_UNICODE_MASK := 3840
    static IS_TEXT_UNICODE_NOT_ASCII_MASK := 61440
}
struct COMPARESTRING_RESULT extends Int32 {
    static CSTR_LESS_THAN := 1
    static CSTR_EQUAL := 2
    static CSTR_GREATER_THAN := 3
}
struct HSAVEDUILANGUAGES {
    Value : IntPtr
}
struct UBiDi {
    Value : IntPtr
}
struct UBiDiTransform {
    Value : IntPtr
}
struct UBreakIterator {
    Value : IntPtr
}
struct UCaseMap {
    Value : IntPtr
}
struct UCharsetDetector {
    Value : IntPtr
}
struct UCharsetMatch {
    Value : IntPtr
}
struct UCollationElements {
    Value : IntPtr
}
struct UCollator {
    Value : IntPtr
}
struct UConstrainedFieldPosition {
    Value : IntPtr
}
struct UConverter {
    Value : IntPtr
}
struct UConverterSelector {
    Value : IntPtr
}
struct UCPMap {
    Value : IntPtr
}
struct UDateFormatSymbols {
    Value : IntPtr
}
struct UDateIntervalFormat {
    Value : IntPtr
}
struct UEnumeration {
    Value : IntPtr
}
struct UFieldPositionIterator {
    Value : IntPtr
}
struct UFormattedDateInterval {
    Value : IntPtr
}
struct UFormattedList {
    Value : IntPtr
}
struct UFormattedNumber {
    Value : IntPtr
}
struct UFormattedNumberRange {
    Value : IntPtr
}
struct UFormattedRelativeDateTime {
    Value : IntPtr
}
struct UFormattedValue {
    Value : IntPtr
}
struct UGenderInfo {
    Value : IntPtr
}
struct UHashtable {
    Value : IntPtr
}
struct UIDNA {
    Value : IntPtr
}
struct UListFormatter {
    Value : IntPtr
}
struct ULocaleData {
    Value : IntPtr
}
struct ULocaleDisplayNames {
    Value : IntPtr
}
struct UMutableCPTrie {
    Value : IntPtr
}
struct UNormalizer2 {
    Value : IntPtr
}
struct UNumberFormatter {
    Value : IntPtr
}
struct UNumberRangeFormatter {
    Value : IntPtr
}
struct UNumberingSystem {
    Value : IntPtr
}
struct UPluralRules {
    Value : IntPtr
}
struct URegion {
    Value : IntPtr
}
struct URegularExpression {
    Value : IntPtr
}
struct URelativeDateTimeFormatter {
    Value : IntPtr
}
struct UResourceBundle {
    Value : IntPtr
}
struct USearch {
    Value : IntPtr
}
struct USet {
    Value : IntPtr
}
struct USpoofChecker {
    Value : IntPtr
}
struct USpoofCheckResult {
    Value : IntPtr
}
struct UStringPrepProfile {
    Value : IntPtr
}
struct UStringSearch {
    Value : IntPtr
}
struct FONTSIGNATURE {
    fsUsb : UInt32[4]
    fsCsb : UInt32[2]
}
struct CHARSETINFO {
    ciCharset : UInt32
    ciACP : UInt32
    fs : FONTSIGNATURE
}
struct LOCALESIGNATURE {
    lsUsb : UInt32[4]
    lsCsbDefault : UInt32[2]
    lsCsbSupported : UInt32[2]
}
struct NEWTEXTMETRICEXA {
    ntmTm : NEWTEXTMETRICA
    ntmFontSig : FONTSIGNATURE
}
struct NEWTEXTMETRICEXW {
    ntmTm : NEWTEXTMETRICW
    ntmFontSig : FONTSIGNATURE
}
struct ENUMTEXTMETRICA {
    etmNewTextMetricEx : NEWTEXTMETRICEXA
    etmAxesList : AXESLISTA
}
struct ENUMTEXTMETRICW {
    etmNewTextMetricEx : NEWTEXTMETRICEXW
    etmAxesList : AXESLISTW
}
struct CPINFO {
    MaxCharSize : UInt32
    DefaultChar : UInt8[2]
    LeadByte : UInt8[12]
}
struct CPINFOEXA {
    MaxCharSize : UInt32
    DefaultChar : UInt8[2]
    LeadByte : UInt8[12]
    UnicodeDefaultChar : UInt16
    CodePage : UInt32
    CodePageName : CHAR[260]
}
struct CPINFOEXW {
    MaxCharSize : UInt32
    DefaultChar : UInt8[2]
    LeadByte : UInt8[12]
    UnicodeDefaultChar : UInt16
    CodePage : UInt32
    CodePageName : UInt16[260]
}
struct NUMBERFMTA {
    NumDigits : UInt32
    LeadingZero : UInt32
    Grouping : UInt32
    lpDecimalSep : PSTR
    lpThousandSep : PSTR
    NegativeOrder : UInt32
}
struct NUMBERFMTW {
    NumDigits : UInt32
    LeadingZero : UInt32
    Grouping : UInt32
    lpDecimalSep : PWSTR
    lpThousandSep : PWSTR
    NegativeOrder : UInt32
}
struct CURRENCYFMTA {
    NumDigits : UInt32
    LeadingZero : UInt32
    Grouping : UInt32
    lpDecimalSep : PSTR
    lpThousandSep : PSTR
    NegativeOrder : UInt32
    PositiveOrder : UInt32
    lpCurrencySymbol : PSTR
}
struct CURRENCYFMTW {
    NumDigits : UInt32
    LeadingZero : UInt32
    Grouping : UInt32
    lpDecimalSep : PWSTR
    lpThousandSep : PWSTR
    NegativeOrder : UInt32
    PositiveOrder : UInt32
    lpCurrencySymbol : PWSTR
}
struct SYSNLS_FUNCTION extends Int32 {
    static COMPARE_STRING := 1
}
struct NLSVERSIONINFO {
    dwNLSVersionInfoSize : UInt32
    dwNLSVersion : UInt32
    dwDefinedVersion : UInt32
    dwEffectiveId : UInt32
    guidCustomVersion : GUID
}
struct NLSVERSIONINFOEX {
    dwNLSVersionInfoSize : UInt32
    dwNLSVersion : UInt32
    dwDefinedVersion : UInt32
    dwEffectiveId : UInt32
    guidCustomVersion : GUID
}
struct SYSGEOTYPE extends Int32 {
    static GEO_NATION := 1
    static GEO_LATITUDE := 2
    static GEO_LONGITUDE := 3
    static GEO_ISO2 := 4
    static GEO_ISO3 := 5
    static GEO_RFC1766 := 6
    static GEO_LCID := 7
    static GEO_FRIENDLYNAME := 8
    static GEO_OFFICIALNAME := 9
    static GEO_TIMEZONES := 10
    static GEO_OFFICIALLANGUAGES := 11
    static GEO_ISO_UN_NUMBER := 12
    static GEO_PARENT := 13
    static GEO_DIALINGCODE := 14
    static GEO_CURRENCYCODE := 15
    static GEO_CURRENCYSYMBOL := 16
    static GEO_NAME := 17
    static GEO_ID := 18
}
struct SYSGEOCLASS extends Int32 {
    static GEOCLASS_NATION := 16
    static GEOCLASS_REGION := 14
    static GEOCLASS_ALL := 0
}
struct LOCALE_ENUMPROCA extends FunctionPointer {
    static Types := [PSTR, BOOL]
}
struct LOCALE_ENUMPROCW extends FunctionPointer {
    static Types := [PWSTR, BOOL]
}
struct NORM_FORM extends Int32 {
    static NormalizationOther := 0
    static NormalizationC := 1
    static NormalizationD := 2
    static NormalizationKC := 5
    static NormalizationKD := 6
}
struct LANGUAGEGROUP_ENUMPROCA extends FunctionPointer {
    static Types := [UInt32, PSTR, PSTR, UInt32, IntPtr, BOOL]
}
struct LANGGROUPLOCALE_ENUMPROCA extends FunctionPointer {
    static Types := [UInt32, UInt32, PSTR, IntPtr, BOOL]
}
struct UILANGUAGE_ENUMPROCA extends FunctionPointer {
    static Types := [PSTR, IntPtr, BOOL]
}
struct CODEPAGE_ENUMPROCA extends FunctionPointer {
    static Types := [PSTR, BOOL]
}
struct DATEFMT_ENUMPROCA extends FunctionPointer {
    static Types := [PSTR, BOOL]
}
struct DATEFMT_ENUMPROCEXA extends FunctionPointer {
    static Types := [PSTR, UInt32, BOOL]
}
struct TIMEFMT_ENUMPROCA extends FunctionPointer {
    static Types := [PSTR, BOOL]
}
struct CALINFO_ENUMPROCA extends FunctionPointer {
    static Types := [PSTR, BOOL]
}
struct CALINFO_ENUMPROCEXA extends FunctionPointer {
    static Types := [PSTR, UInt32, BOOL]
}
struct LANGUAGEGROUP_ENUMPROCW extends FunctionPointer {
    static Types := [UInt32, PWSTR, PWSTR, UInt32, IntPtr, BOOL]
}
struct LANGGROUPLOCALE_ENUMPROCW extends FunctionPointer {
    static Types := [UInt32, UInt32, PWSTR, IntPtr, BOOL]
}
struct UILANGUAGE_ENUMPROCW extends FunctionPointer {
    static Types := [PWSTR, IntPtr, BOOL]
}
struct CODEPAGE_ENUMPROCW extends FunctionPointer {
    static Types := [PWSTR, BOOL]
}
struct DATEFMT_ENUMPROCW extends FunctionPointer {
    static Types := [PWSTR, BOOL]
}
struct DATEFMT_ENUMPROCEXW extends FunctionPointer {
    static Types := [PWSTR, UInt32, BOOL]
}
struct TIMEFMT_ENUMPROCW extends FunctionPointer {
    static Types := [PWSTR, BOOL]
}
struct CALINFO_ENUMPROCW extends FunctionPointer {
    static Types := [PWSTR, BOOL]
}
struct CALINFO_ENUMPROCEXW extends FunctionPointer {
    static Types := [PWSTR, UInt32, BOOL]
}
struct GEO_ENUMPROC extends FunctionPointer {
    static Types := [Int32, BOOL]
}
struct GEO_ENUMNAMEPROC extends FunctionPointer {
    static Types := [PWSTR, LPARAM, BOOL]
}
struct FILEMUIINFO {
    dwSize : UInt32
    dwVersion : UInt32
    dwFileType : UInt32
    pChecksum : UInt8[16]
    pServiceChecksum : UInt8[16]
    dwLanguageNameOffset : UInt32
    dwTypeIDMainSize : UInt32
    dwTypeIDMainOffset : UInt32
    dwTypeNameMainOffset : UInt32
    dwTypeIDMUISize : UInt32
    dwTypeIDMUIOffset : UInt32
    dwTypeNameMUIOffset : UInt32
    abBuffer : UInt8[8]
}
struct CALINFO_ENUMPROCEXEX extends FunctionPointer {
    static Types := [PWSTR, UInt32, PWSTR, LPARAM, BOOL]
}
struct DATEFMT_ENUMPROCEXEX extends FunctionPointer {
    static Types := [PWSTR, UInt32, LPARAM, BOOL]
}
struct TIMEFMT_ENUMPROCEX extends FunctionPointer {
    static Types := [PWSTR, LPARAM, BOOL]
}
struct LOCALE_ENUMPROCEX extends FunctionPointer {
    static Types := [PWSTR, UInt32, LPARAM, BOOL]
}
struct PFN_MAPPINGCALLBACKPROC extends FunctionPointer {
    static Types := [MAPPING_PROPERTY_BAG.Ptr, Struct.Ptr, UInt32, HRESULT, "Void"]
}
struct MAPPING_SERVICE_INFO {
    Size : IntPtr
    pszCopyright : PWSTR
    wMajorVersion : UInt16
    wMinorVersion : UInt16
    wBuildVersion : UInt16
    wStepVersion : UInt16
    dwInputContentTypesCount : UInt32
    prgInputContentTypes : PWSTR.Ptr
    dwOutputContentTypesCount : UInt32
    prgOutputContentTypes : PWSTR.Ptr
    dwInputLanguagesCount : UInt32
    prgInputLanguages : PWSTR.Ptr
    dwOutputLanguagesCount : UInt32
    prgOutputLanguages : PWSTR.Ptr
    dwInputScriptsCount : UInt32
    prgInputScripts : PWSTR.Ptr
    dwOutputScriptsCount : UInt32
    prgOutputScripts : PWSTR.Ptr
    guid : GUID
    pszCategory : PWSTR
    pszDescription : PWSTR
    dwPrivateDataSize : UInt32
    pPrivateData : Struct.Ptr
    pContext : Struct.Ptr
    _bitfield : UInt32
}
struct MAPPING_ENUM_OPTIONS {
    Size : IntPtr
    pszCategory : PWSTR
    pszInputLanguage : PWSTR
    pszOutputLanguage : PWSTR
    pszInputScript : PWSTR
    pszOutputScript : PWSTR
    pszInputContentType : PWSTR
    pszOutputContentType : PWSTR
    pGuid : GUID.Ptr
    _bitfield : UInt32
}
struct MAPPING_OPTIONS {
    Size : IntPtr
    pszInputLanguage : PWSTR
    pszOutputLanguage : PWSTR
    pszInputScript : PWSTR
    pszOutputScript : PWSTR
    pszInputContentType : PWSTR
    pszOutputContentType : PWSTR
    pszUILanguage : PWSTR
    pfnRecognizeCallback : PFN_MAPPINGCALLBACKPROC
    pRecognizeCallerData : Struct.Ptr
    dwRecognizeCallerDataSize : UInt32
    pfnActionCallback : PFN_MAPPINGCALLBACKPROC
    pActionCallerData : Struct.Ptr
    dwActionCallerDataSize : UInt32
    dwServiceFlag : UInt32
    _bitfield : UInt32
}
struct MAPPING_DATA_RANGE {
    dwStartIndex : UInt32
    dwEndIndex : UInt32
    pszDescription : PWSTR
    dwDescriptionLength : UInt32
    pData : Struct.Ptr
    dwDataSize : UInt32
    pszContentType : PWSTR
    prgActionIds : PWSTR.Ptr
    dwActionsCount : UInt32
    prgActionDisplayNames : PWSTR.Ptr
}
struct MAPPING_PROPERTY_BAG {
    Size : IntPtr
    prgResultRanges : MAPPING_DATA_RANGE.Ptr
    dwRangesCount : UInt32
    pServiceData : Struct.Ptr
    dwServiceDataSize : UInt32
    pCallerData : Struct.Ptr
    dwCallerDataSize : UInt32
    pContext : Struct.Ptr
}
struct WORDLIST_TYPE extends Int32 {
    static WORDLIST_TYPE_IGNORE := 0
    static WORDLIST_TYPE_ADD := 1
    static WORDLIST_TYPE_EXCLUDE := 2
    static WORDLIST_TYPE_AUTOCORRECT := 3
}
struct CORRECTIVE_ACTION extends Int32 {
    static CORRECTIVE_ACTION_NONE := 0
    static CORRECTIVE_ACTION_GET_SUGGESTIONS := 1
    static CORRECTIVE_ACTION_REPLACE := 2
    static CORRECTIVE_ACTION_DELETE := 3
}
struct ISpellingError extends IUnknown {
    static IID := "{B7C82D61-FBE8-4B47-9B27-6C0D2E0DE0A3}"
    get_StartIndex(value)
      => ComCall(3, this.p, UInt32.Ptr, value)
    get_Length(value)
      => ComCall(4, this.p, UInt32.Ptr, value)
    get_CorrectiveAction(value)
      => ComCall(5, this.p, CORRECTIVE_ACTION.Ptr, value)
    get_Replacement(value)
      => ComCall(6, this.p, PWSTR.Ptr, value)
}
struct IEnumSpellingError extends IUnknown {
    static IID := "{803E3BD4-2828-4410-8290-418D1D73C762}"
    Next(value)
      => ComCall(3, this.p, ISpellingError.Ptr, value)
}
struct IOptionDescription extends IUnknown {
    static IID := "{432E5F85-35CF-4606-A801-6F70277E1D7A}"
    get_Id(value)
      => ComCall(3, this.p, PWSTR.Ptr, value)
    get_Heading(value)
      => ComCall(4, this.p, PWSTR.Ptr, value)
    get_Description(value)
      => ComCall(5, this.p, PWSTR.Ptr, value)
    get_Labels(value)
      => ComCall(6, this.p, IEnumString.Ptr, value)
}
struct ISpellCheckerChangedEventHandler extends IUnknown {
    static IID := "{0B83A5B0-792F-4EAB-9799-ACF52C5ED08A}"
    Invoke(sender)
      => ComCall(3, this.p, ISpellChecker, sender)
}
struct ISpellChecker extends IUnknown {
    static IID := "{B6FD0B71-E2BC-4653-8D05-F197E412770B}"
    get_LanguageTag(value)
      => ComCall(3, this.p, PWSTR.Ptr, value)
    Check(text, value)
      => ComCall(4, this.p, "Str", text, IEnumSpellingError.Ptr, value)
    Suggest(word, value)
      => ComCall(5, this.p, "Str", word, IEnumString.Ptr, value)
    Add(word)
      => ComCall(6, this.p, "Str", word)
    Ignore(word)
      => ComCall(7, this.p, "Str", word)
    AutoCorrect(from, to)
      => ComCall(8, this.p, "Str", from, "Str", to)
    GetOptionValue(optionId, value)
      => ComCall(9, this.p, "Str", optionId, UInt8.Ptr, value)
    get_OptionIds(value)
      => ComCall(10, this.p, IEnumString.Ptr, value)
    get_Id(value)
      => ComCall(11, this.p, PWSTR.Ptr, value)
    get_LocalizedName(value)
      => ComCall(12, this.p, PWSTR.Ptr, value)
    add_SpellCheckerChanged(handler, eventCookie)
      => ComCall(13, this.p, ISpellCheckerChangedEventHandler, handler, UInt32.Ptr, eventCookie)
    remove_SpellCheckerChanged(eventCookie)
      => ComCall(14, this.p, UInt32, eventCookie)
    GetOptionDescription(optionId, value)
      => ComCall(15, this.p, "Str", optionId, IOptionDescription.Ptr, value)
    ComprehensiveCheck(text, value)
      => ComCall(16, this.p, "Str", text, IEnumSpellingError.Ptr, value)
}
struct ISpellChecker2 extends ISpellChecker {
    static IID := "{E7ED1C71-87F7-4378-A840-C9200DACEE47}"
    Remove(word)
      => ComCall(17, this.p, "Str", word)
}
struct ISpellCheckerFactory extends IUnknown {
    static IID := "{8E018A9D-2415-4677-BF08-794EA61F94BB}"
    get_SupportedLanguages(value)
      => ComCall(3, this.p, IEnumString.Ptr, value)
    IsSupported(languageTag, value)
      => ComCall(4, this.p, "Str", languageTag, BOOL.Ptr, value)
    CreateSpellChecker(languageTag, value)
      => ComCall(5, this.p, "Str", languageTag, ISpellChecker.Ptr, value)
}
struct IUserDictionariesRegistrar extends IUnknown {
    static IID := "{AA176B85-0E12-4844-8E1A-EEF1DA77F586}"
    RegisterUserDictionary(dictionaryPath, languageTag)
      => ComCall(3, this.p, "Str", dictionaryPath, "Str", languageTag)
    UnregisterUserDictionary(dictionaryPath, languageTag)
      => ComCall(4, this.p, "Str", dictionaryPath, "Str", languageTag)
}
struct ISpellCheckProvider extends IUnknown {
    static IID := "{73E976E0-8ED4-4EB1-80D7-1BE0A16B0C38}"
    get_LanguageTag(value)
      => ComCall(3, this.p, PWSTR.Ptr, value)
    Check(text, value)
      => ComCall(4, this.p, "Str", text, IEnumSpellingError.Ptr, value)
    Suggest(word, value)
      => ComCall(5, this.p, "Str", word, IEnumString.Ptr, value)
    GetOptionValue(optionId, value)
      => ComCall(6, this.p, "Str", optionId, UInt8.Ptr, value)
    SetOptionValue(optionId, value)
      => ComCall(7, this.p, "Str", optionId, UInt8, value)
    get_OptionIds(value)
      => ComCall(8, this.p, IEnumString.Ptr, value)
    get_Id(value)
      => ComCall(9, this.p, PWSTR.Ptr, value)
    get_LocalizedName(value)
      => ComCall(10, this.p, PWSTR.Ptr, value)
    GetOptionDescription(optionId, value)
      => ComCall(11, this.p, "Str", optionId, IOptionDescription.Ptr, value)
    InitializeWordlist(wordlistType, words)
      => ComCall(12, this.p, WORDLIST_TYPE, wordlistType, IEnumString, words)
}
struct IComprehensiveSpellCheckProvider extends IUnknown {
    static IID := "{0C58F8DE-8E94-479E-9717-70C42C4AD2C3}"
    ComprehensiveCheck(text, value)
      => ComCall(3, this.p, "Str", text, IEnumSpellingError.Ptr, value)
}
struct ISpellCheckProviderFactory extends IUnknown {
    static IID := "{9F671E11-77D6-4C92-AEFB-615215E3A4BE}"
    get_SupportedLanguages(value)
      => ComCall(3, this.p, IEnumString.Ptr, value)
    IsSupported(languageTag, value)
      => ComCall(4, this.p, "Str", languageTag, BOOL.Ptr, value)
    CreateSpellCheckProvider(languageTag, value)
      => ComCall(5, this.p, "Str", languageTag, ISpellCheckProvider.Ptr, value)
}
struct SCRIPT_CONTROL {
    _bitfield : UInt32
}
struct SCRIPT_STATE {
    _bitfield : UInt16
}
struct SCRIPT_ANALYSIS {
    _bitfield : UInt16
    s : SCRIPT_STATE
}
struct SCRIPT_ITEM {
    iCharPos : Int32
    a : SCRIPT_ANALYSIS
}
struct SCRIPT_JUSTIFY extends Int32 {
    static SCRIPT_JUSTIFY_NONE := 0
    static SCRIPT_JUSTIFY_ARABIC_BLANK := 1
    static SCRIPT_JUSTIFY_CHARACTER := 2
    static SCRIPT_JUSTIFY_RESERVED1 := 3
    static SCRIPT_JUSTIFY_BLANK := 4
    static SCRIPT_JUSTIFY_RESERVED2 := 5
    static SCRIPT_JUSTIFY_RESERVED3 := 6
    static SCRIPT_JUSTIFY_ARABIC_NORMAL := 7
    static SCRIPT_JUSTIFY_ARABIC_KASHIDA := 8
    static SCRIPT_JUSTIFY_ARABIC_ALEF := 9
    static SCRIPT_JUSTIFY_ARABIC_HA := 10
    static SCRIPT_JUSTIFY_ARABIC_RA := 11
    static SCRIPT_JUSTIFY_ARABIC_BA := 12
    static SCRIPT_JUSTIFY_ARABIC_BARA := 13
    static SCRIPT_JUSTIFY_ARABIC_SEEN := 14
    static SCRIPT_JUSTIFY_ARABIC_SEEN_M := 15
}
struct SCRIPT_VISATTR {
    _bitfield : UInt16
}
struct GOFFSET {
    du : Int32
    dv : Int32
}
struct SCRIPT_LOGATTR {
    _bitfield : UInt8
}
struct SCRIPT_PROPERTIES {
    _bitfield1 : UInt32
    _bitfield2 : UInt32
}
struct SCRIPT_FONTPROPERTIES {
    cBytes : Int32
    wgBlank : UInt16
    wgDefault : UInt16
    wgInvalid : UInt16
    wgKashida : UInt16
    iKashidaWidth : Int32
}
struct SCRIPT_TABDEF {
    cTabStops : Int32
    iScale : Int32
    pTabStops : Int32.Ptr
    iTabOrigin : Int32
}
struct SCRIPT_DIGITSUBSTITUTE {
    _bitfield1 : UInt32
    _bitfield2 : UInt32
    dwReserved : UInt32
}
struct OPENTYPE_FEATURE_RECORD {
    tagFeature : UInt32
    lParameter : Int32
}
struct TEXTRANGE_PROPERTIES {
    potfRecords : OPENTYPE_FEATURE_RECORD.Ptr
    cotfRecords : Int32
}
struct SCRIPT_CHARPROP {
    _bitfield : UInt16
}
struct SCRIPT_GLYPHPROP {
    sva : SCRIPT_VISATTR
    reserved : UInt16
}
struct UErrorCode extends Int32 {
    static U_USING_FALLBACK_WARNING := -128
    static U_ERROR_WARNING_START := -128
    static U_USING_DEFAULT_WARNING := -127
    static U_SAFECLONE_ALLOCATED_WARNING := -126
    static U_STATE_OLD_WARNING := -125
    static U_STRING_NOT_TERMINATED_WARNING := -124
    static U_SORT_KEY_TOO_SHORT_WARNING := -123
    static U_AMBIGUOUS_ALIAS_WARNING := -122
    static U_DIFFERENT_UCA_VERSION := -121
    static U_PLUGIN_CHANGED_LEVEL_WARNING := -120
    static U_ZERO_ERROR := 0
    static U_ILLEGAL_ARGUMENT_ERROR := 1
    static U_MISSING_RESOURCE_ERROR := 2
    static U_INVALID_FORMAT_ERROR := 3
    static U_FILE_ACCESS_ERROR := 4
    static U_INTERNAL_PROGRAM_ERROR := 5
    static U_MESSAGE_PARSE_ERROR := 6
    static U_MEMORY_ALLOCATION_ERROR := 7
    static U_INDEX_OUTOFBOUNDS_ERROR := 8
    static U_PARSE_ERROR := 9
    static U_INVALID_CHAR_FOUND := 10
    static U_TRUNCATED_CHAR_FOUND := 11
    static U_ILLEGAL_CHAR_FOUND := 12
    static U_INVALID_TABLE_FORMAT := 13
    static U_INVALID_TABLE_FILE := 14
    static U_BUFFER_OVERFLOW_ERROR := 15
    static U_UNSUPPORTED_ERROR := 16
    static U_RESOURCE_TYPE_MISMATCH := 17
    static U_ILLEGAL_ESCAPE_SEQUENCE := 18
    static U_UNSUPPORTED_ESCAPE_SEQUENCE := 19
    static U_NO_SPACE_AVAILABLE := 20
    static U_CE_NOT_FOUND_ERROR := 21
    static U_PRIMARY_TOO_LONG_ERROR := 22
    static U_STATE_TOO_OLD_ERROR := 23
    static U_TOO_MANY_ALIASES_ERROR := 24
    static U_ENUM_OUT_OF_SYNC_ERROR := 25
    static U_INVARIANT_CONVERSION_ERROR := 26
    static U_INVALID_STATE_ERROR := 27
    static U_COLLATOR_VERSION_MISMATCH := 28
    static U_USELESS_COLLATOR_ERROR := 29
    static U_NO_WRITE_PERMISSION := 30
    static U_INPUT_TOO_LONG_ERROR := 31
    static U_BAD_VARIABLE_DEFINITION := 65536
    static U_PARSE_ERROR_START := 65536
    static U_MALFORMED_RULE := 65537
    static U_MALFORMED_SET := 65538
    static U_MALFORMED_SYMBOL_REFERENCE := 65539
    static U_MALFORMED_UNICODE_ESCAPE := 65540
    static U_MALFORMED_VARIABLE_DEFINITION := 65541
    static U_MALFORMED_VARIABLE_REFERENCE := 65542
    static U_MISMATCHED_SEGMENT_DELIMITERS := 65543
    static U_MISPLACED_ANCHOR_START := 65544
    static U_MISPLACED_CURSOR_OFFSET := 65545
    static U_MISPLACED_QUANTIFIER := 65546
    static U_MISSING_OPERATOR := 65547
    static U_MISSING_SEGMENT_CLOSE := 65548
    static U_MULTIPLE_ANTE_CONTEXTS := 65549
    static U_MULTIPLE_CURSORS := 65550
    static U_MULTIPLE_POST_CONTEXTS := 65551
    static U_TRAILING_BACKSLASH := 65552
    static U_UNDEFINED_SEGMENT_REFERENCE := 65553
    static U_UNDEFINED_VARIABLE := 65554
    static U_UNQUOTED_SPECIAL := 65555
    static U_UNTERMINATED_QUOTE := 65556
    static U_RULE_MASK_ERROR := 65557
    static U_MISPLACED_COMPOUND_FILTER := 65558
    static U_MULTIPLE_COMPOUND_FILTERS := 65559
    static U_INVALID_RBT_SYNTAX := 65560
    static U_INVALID_PROPERTY_PATTERN := 65561
    static U_MALFORMED_PRAGMA := 65562
    static U_UNCLOSED_SEGMENT := 65563
    static U_ILLEGAL_CHAR_IN_SEGMENT := 65564
    static U_VARIABLE_RANGE_EXHAUSTED := 65565
    static U_VARIABLE_RANGE_OVERLAP := 65566
    static U_ILLEGAL_CHARACTER := 65567
    static U_INTERNAL_TRANSLITERATOR_ERROR := 65568
    static U_INVALID_ID := 65569
    static U_INVALID_FUNCTION := 65570
    static U_UNEXPECTED_TOKEN := 65792
    static U_FMT_PARSE_ERROR_START := 65792
    static U_MULTIPLE_DECIMAL_SEPARATORS := 65793
    static U_MULTIPLE_DECIMAL_SEPERATORS := 65793
    static U_MULTIPLE_EXPONENTIAL_SYMBOLS := 65794
    static U_MALFORMED_EXPONENTIAL_PATTERN := 65795
    static U_MULTIPLE_PERCENT_SYMBOLS := 65796
    static U_MULTIPLE_PERMILL_SYMBOLS := 65797
    static U_MULTIPLE_PAD_SPECIFIERS := 65798
    static U_PATTERN_SYNTAX_ERROR := 65799
    static U_ILLEGAL_PAD_POSITION := 65800
    static U_UNMATCHED_BRACES := 65801
    static U_UNSUPPORTED_PROPERTY := 65802
    static U_UNSUPPORTED_ATTRIBUTE := 65803
    static U_ARGUMENT_TYPE_MISMATCH := 65804
    static U_DUPLICATE_KEYWORD := 65805
    static U_UNDEFINED_KEYWORD := 65806
    static U_DEFAULT_KEYWORD_MISSING := 65807
    static U_DECIMAL_NUMBER_SYNTAX_ERROR := 65808
    static U_FORMAT_INEXACT_ERROR := 65809
    static U_NUMBER_ARG_OUTOFBOUNDS_ERROR := 65810
    static U_NUMBER_SKELETON_SYNTAX_ERROR := 65811
    static U_BRK_INTERNAL_ERROR := 66048
    static U_BRK_ERROR_START := 66048
    static U_BRK_HEX_DIGITS_EXPECTED := 66049
    static U_BRK_SEMICOLON_EXPECTED := 66050
    static U_BRK_RULE_SYNTAX := 66051
    static U_BRK_UNCLOSED_SET := 66052
    static U_BRK_ASSIGN_ERROR := 66053
    static U_BRK_VARIABLE_REDFINITION := 66054
    static U_BRK_MISMATCHED_PAREN := 66055
    static U_BRK_NEW_LINE_IN_QUOTED_STRING := 66056
    static U_BRK_UNDEFINED_VARIABLE := 66057
    static U_BRK_INIT_ERROR := 66058
    static U_BRK_RULE_EMPTY_SET := 66059
    static U_BRK_UNRECOGNIZED_OPTION := 66060
    static U_BRK_MALFORMED_RULE_TAG := 66061
    static U_REGEX_INTERNAL_ERROR := 66304
    static U_REGEX_ERROR_START := 66304
    static U_REGEX_RULE_SYNTAX := 66305
    static U_REGEX_INVALID_STATE := 66306
    static U_REGEX_BAD_ESCAPE_SEQUENCE := 66307
    static U_REGEX_PROPERTY_SYNTAX := 66308
    static U_REGEX_UNIMPLEMENTED := 66309
    static U_REGEX_MISMATCHED_PAREN := 66310
    static U_REGEX_NUMBER_TOO_BIG := 66311
    static U_REGEX_BAD_INTERVAL := 66312
    static U_REGEX_MAX_LT_MIN := 66313
    static U_REGEX_INVALID_BACK_REF := 66314
    static U_REGEX_INVALID_FLAG := 66315
    static U_REGEX_LOOK_BEHIND_LIMIT := 66316
    static U_REGEX_SET_CONTAINS_STRING := 66317
    static U_REGEX_MISSING_CLOSE_BRACKET := 66319
    static U_REGEX_INVALID_RANGE := 66320
    static U_REGEX_STACK_OVERFLOW := 66321
    static U_REGEX_TIME_OUT := 66322
    static U_REGEX_STOPPED_BY_CALLER := 66323
    static U_REGEX_PATTERN_TOO_BIG := 66324
    static U_REGEX_INVALID_CAPTURE_GROUP_NAME := 66325
    static U_IDNA_PROHIBITED_ERROR := 66560
    static U_IDNA_ERROR_START := 66560
    static U_IDNA_UNASSIGNED_ERROR := 66561
    static U_IDNA_CHECK_BIDI_ERROR := 66562
    static U_IDNA_STD3_ASCII_RULES_ERROR := 66563
    static U_IDNA_ACE_PREFIX_ERROR := 66564
    static U_IDNA_VERIFICATION_ERROR := 66565
    static U_IDNA_LABEL_TOO_LONG_ERROR := 66566
    static U_IDNA_ZERO_LENGTH_LABEL_ERROR := 66567
    static U_IDNA_DOMAIN_NAME_TOO_LONG_ERROR := 66568
    static U_STRINGPREP_PROHIBITED_ERROR := 66560
    static U_STRINGPREP_UNASSIGNED_ERROR := 66561
    static U_STRINGPREP_CHECK_BIDI_ERROR := 66562
    static U_PLUGIN_ERROR_START := 66816
    static U_PLUGIN_TOO_HIGH := 66816
    static U_PLUGIN_DIDNT_SET_LEVEL := 66817
}
struct UTraceLevel extends Int32 {
    static UTRACE_OFF := -1
    static UTRACE_ERROR := 0
    static UTRACE_WARNING := 3
    static UTRACE_OPEN_CLOSE := 5
    static UTRACE_INFO := 7
    static UTRACE_VERBOSE := 9
}
struct UTraceFunctionNumber extends Int32 {
    static UTRACE_FUNCTION_START := 0
    static UTRACE_U_INIT := 0
    static UTRACE_U_CLEANUP := 1
    static UTRACE_CONVERSION_START := 4096
    static UTRACE_UCNV_OPEN := 4096
    static UTRACE_UCNV_OPEN_PACKAGE := 4097
    static UTRACE_UCNV_OPEN_ALGORITHMIC := 4098
    static UTRACE_UCNV_CLONE := 4099
    static UTRACE_UCNV_CLOSE := 4100
    static UTRACE_UCNV_FLUSH_CACHE := 4101
    static UTRACE_UCNV_LOAD := 4102
    static UTRACE_UCNV_UNLOAD := 4103
    static UTRACE_COLLATION_START := 8192
    static UTRACE_UCOL_OPEN := 8192
    static UTRACE_UCOL_CLOSE := 8193
    static UTRACE_UCOL_STRCOLL := 8194
    static UTRACE_UCOL_GET_SORTKEY := 8195
    static UTRACE_UCOL_GETLOCALE := 8196
    static UTRACE_UCOL_NEXTSORTKEYPART := 8197
    static UTRACE_UCOL_STRCOLLITER := 8198
    static UTRACE_UCOL_OPEN_FROM_SHORT_STRING := 8199
    static UTRACE_UCOL_STRCOLLUTF8 := 8200
    static UTRACE_UDATA_START := 12288
    static UTRACE_UDATA_RESOURCE := 12288
    static UTRACE_UDATA_BUNDLE := 12289
    static UTRACE_UDATA_DATA_FILE := 12290
    static UTRACE_UDATA_RES_FILE := 12291
}
struct UTraceEntry extends FunctionPointer {
    static Types := [Struct.Ptr, Int32, "Void"]
    static Options := "C"
}
struct UTraceExit extends FunctionPointer {
    static Types := [Struct.Ptr, Int32, PSTR, Int8.Ptr, "Void"]
    static Options := "C"
}
struct UTraceData extends FunctionPointer {
    static Types := [Struct.Ptr, Int32, Int32, PSTR, Int8.Ptr, "Void"]
    static Options := "C"
}
struct UStringTrieResult extends Int32 {
    static USTRINGTRIE_NO_MATCH := 0
    static USTRINGTRIE_NO_VALUE := 1
    static USTRINGTRIE_FINAL_VALUE := 2
    static USTRINGTRIE_INTERMEDIATE_VALUE := 3
}
struct UScriptCode extends Int32 {
    static USCRIPT_INVALID_CODE := -1
    static USCRIPT_COMMON := 0
    static USCRIPT_INHERITED := 1
    static USCRIPT_ARABIC := 2
    static USCRIPT_ARMENIAN := 3
    static USCRIPT_BENGALI := 4
    static USCRIPT_BOPOMOFO := 5
    static USCRIPT_CHEROKEE := 6
    static USCRIPT_COPTIC := 7
    static USCRIPT_CYRILLIC := 8
    static USCRIPT_DESERET := 9
    static USCRIPT_DEVANAGARI := 10
    static USCRIPT_ETHIOPIC := 11
    static USCRIPT_GEORGIAN := 12
    static USCRIPT_GOTHIC := 13
    static USCRIPT_GREEK := 14
    static USCRIPT_GUJARATI := 15
    static USCRIPT_GURMUKHI := 16
    static USCRIPT_HAN := 17
    static USCRIPT_HANGUL := 18
    static USCRIPT_HEBREW := 19
    static USCRIPT_HIRAGANA := 20
    static USCRIPT_KANNADA := 21
    static USCRIPT_KATAKANA := 22
    static USCRIPT_KHMER := 23
    static USCRIPT_LAO := 24
    static USCRIPT_LATIN := 25
    static USCRIPT_MALAYALAM := 26
    static USCRIPT_MONGOLIAN := 27
    static USCRIPT_MYANMAR := 28
    static USCRIPT_OGHAM := 29
    static USCRIPT_OLD_ITALIC := 30
    static USCRIPT_ORIYA := 31
    static USCRIPT_RUNIC := 32
    static USCRIPT_SINHALA := 33
    static USCRIPT_SYRIAC := 34
    static USCRIPT_TAMIL := 35
    static USCRIPT_TELUGU := 36
    static USCRIPT_THAANA := 37
    static USCRIPT_THAI := 38
    static USCRIPT_TIBETAN := 39
    static USCRIPT_CANADIAN_ABORIGINAL := 40
    static USCRIPT_UCAS := 40
    static USCRIPT_YI := 41
    static USCRIPT_TAGALOG := 42
    static USCRIPT_HANUNOO := 43
    static USCRIPT_BUHID := 44
    static USCRIPT_TAGBANWA := 45
    static USCRIPT_BRAILLE := 46
    static USCRIPT_CYPRIOT := 47
    static USCRIPT_LIMBU := 48
    static USCRIPT_LINEAR_B := 49
    static USCRIPT_OSMANYA := 50
    static USCRIPT_SHAVIAN := 51
    static USCRIPT_TAI_LE := 52
    static USCRIPT_UGARITIC := 53
    static USCRIPT_KATAKANA_OR_HIRAGANA := 54
    static USCRIPT_BUGINESE := 55
    static USCRIPT_GLAGOLITIC := 56
    static USCRIPT_KHAROSHTHI := 57
    static USCRIPT_SYLOTI_NAGRI := 58
    static USCRIPT_NEW_TAI_LUE := 59
    static USCRIPT_TIFINAGH := 60
    static USCRIPT_OLD_PERSIAN := 61
    static USCRIPT_BALINESE := 62
    static USCRIPT_BATAK := 63
    static USCRIPT_BLISSYMBOLS := 64
    static USCRIPT_BRAHMI := 65
    static USCRIPT_CHAM := 66
    static USCRIPT_CIRTH := 67
    static USCRIPT_OLD_CHURCH_SLAVONIC_CYRILLIC := 68
    static USCRIPT_DEMOTIC_EGYPTIAN := 69
    static USCRIPT_HIERATIC_EGYPTIAN := 70
    static USCRIPT_EGYPTIAN_HIEROGLYPHS := 71
    static USCRIPT_KHUTSURI := 72
    static USCRIPT_SIMPLIFIED_HAN := 73
    static USCRIPT_TRADITIONAL_HAN := 74
    static USCRIPT_PAHAWH_HMONG := 75
    static USCRIPT_OLD_HUNGARIAN := 76
    static USCRIPT_HARAPPAN_INDUS := 77
    static USCRIPT_JAVANESE := 78
    static USCRIPT_KAYAH_LI := 79
    static USCRIPT_LATIN_FRAKTUR := 80
    static USCRIPT_LATIN_GAELIC := 81
    static USCRIPT_LEPCHA := 82
    static USCRIPT_LINEAR_A := 83
    static USCRIPT_MANDAIC := 84
    static USCRIPT_MANDAEAN := 84
    static USCRIPT_MAYAN_HIEROGLYPHS := 85
    static USCRIPT_MEROITIC_HIEROGLYPHS := 86
    static USCRIPT_MEROITIC := 86
    static USCRIPT_NKO := 87
    static USCRIPT_ORKHON := 88
    static USCRIPT_OLD_PERMIC := 89
    static USCRIPT_PHAGS_PA := 90
    static USCRIPT_PHOENICIAN := 91
    static USCRIPT_MIAO := 92
    static USCRIPT_PHONETIC_POLLARD := 92
    static USCRIPT_RONGORONGO := 93
    static USCRIPT_SARATI := 94
    static USCRIPT_ESTRANGELO_SYRIAC := 95
    static USCRIPT_WESTERN_SYRIAC := 96
    static USCRIPT_EASTERN_SYRIAC := 97
    static USCRIPT_TENGWAR := 98
    static USCRIPT_VAI := 99
    static USCRIPT_VISIBLE_SPEECH := 100
    static USCRIPT_CUNEIFORM := 101
    static USCRIPT_UNWRITTEN_LANGUAGES := 102
    static USCRIPT_UNKNOWN := 103
    static USCRIPT_CARIAN := 104
    static USCRIPT_JAPANESE := 105
    static USCRIPT_LANNA := 106
    static USCRIPT_LYCIAN := 107
    static USCRIPT_LYDIAN := 108
    static USCRIPT_OL_CHIKI := 109
    static USCRIPT_REJANG := 110
    static USCRIPT_SAURASHTRA := 111
    static USCRIPT_SIGN_WRITING := 112
    static USCRIPT_SUNDANESE := 113
    static USCRIPT_MOON := 114
    static USCRIPT_MEITEI_MAYEK := 115
    static USCRIPT_IMPERIAL_ARAMAIC := 116
    static USCRIPT_AVESTAN := 117
    static USCRIPT_CHAKMA := 118
    static USCRIPT_KOREAN := 119
    static USCRIPT_KAITHI := 120
    static USCRIPT_MANICHAEAN := 121
    static USCRIPT_INSCRIPTIONAL_PAHLAVI := 122
    static USCRIPT_PSALTER_PAHLAVI := 123
    static USCRIPT_BOOK_PAHLAVI := 124
    static USCRIPT_INSCRIPTIONAL_PARTHIAN := 125
    static USCRIPT_SAMARITAN := 126
    static USCRIPT_TAI_VIET := 127
    static USCRIPT_MATHEMATICAL_NOTATION := 128
    static USCRIPT_SYMBOLS := 129
    static USCRIPT_BAMUM := 130
    static USCRIPT_LISU := 131
    static USCRIPT_NAKHI_GEBA := 132
    static USCRIPT_OLD_SOUTH_ARABIAN := 133
    static USCRIPT_BASSA_VAH := 134
    static USCRIPT_DUPLOYAN := 135
    static USCRIPT_ELBASAN := 136
    static USCRIPT_GRANTHA := 137
    static USCRIPT_KPELLE := 138
    static USCRIPT_LOMA := 139
    static USCRIPT_MENDE := 140
    static USCRIPT_MEROITIC_CURSIVE := 141
    static USCRIPT_OLD_NORTH_ARABIAN := 142
    static USCRIPT_NABATAEAN := 143
    static USCRIPT_PALMYRENE := 144
    static USCRIPT_KHUDAWADI := 145
    static USCRIPT_SINDHI := 145
    static USCRIPT_WARANG_CITI := 146
    static USCRIPT_AFAKA := 147
    static USCRIPT_JURCHEN := 148
    static USCRIPT_MRO := 149
    static USCRIPT_NUSHU := 150
    static USCRIPT_SHARADA := 151
    static USCRIPT_SORA_SOMPENG := 152
    static USCRIPT_TAKRI := 153
    static USCRIPT_TANGUT := 154
    static USCRIPT_WOLEAI := 155
    static USCRIPT_ANATOLIAN_HIEROGLYPHS := 156
    static USCRIPT_KHOJKI := 157
    static USCRIPT_TIRHUTA := 158
    static USCRIPT_CAUCASIAN_ALBANIAN := 159
    static USCRIPT_MAHAJANI := 160
    static USCRIPT_AHOM := 161
    static USCRIPT_HATRAN := 162
    static USCRIPT_MODI := 163
    static USCRIPT_MULTANI := 164
    static USCRIPT_PAU_CIN_HAU := 165
    static USCRIPT_SIDDHAM := 166
    static USCRIPT_ADLAM := 167
    static USCRIPT_BHAIKSUKI := 168
    static USCRIPT_MARCHEN := 169
    static USCRIPT_NEWA := 170
    static USCRIPT_OSAGE := 171
    static USCRIPT_HAN_WITH_BOPOMOFO := 172
    static USCRIPT_JAMO := 173
    static USCRIPT_SYMBOLS_EMOJI := 174
    static USCRIPT_MASARAM_GONDI := 175
    static USCRIPT_SOYOMBO := 176
    static USCRIPT_ZANABAZAR_SQUARE := 177
    static USCRIPT_DOGRA := 178
    static USCRIPT_GUNJALA_GONDI := 179
    static USCRIPT_MAKASAR := 180
    static USCRIPT_MEDEFAIDRIN := 181
    static USCRIPT_HANIFI_ROHINGYA := 182
    static USCRIPT_SOGDIAN := 183
    static USCRIPT_OLD_SOGDIAN := 184
    static USCRIPT_ELYMAIC := 185
    static USCRIPT_NYIAKENG_PUACHUE_HMONG := 186
    static USCRIPT_NANDINAGARI := 187
    static USCRIPT_WANCHO := 188
    static USCRIPT_CHORASMIAN := 189
    static USCRIPT_DIVES_AKURU := 190
    static USCRIPT_KHITAN_SMALL_SCRIPT := 191
    static USCRIPT_YEZIDI := 192
}
struct UScriptUsage extends Int32 {
    static USCRIPT_USAGE_NOT_ENCODED := 0
    static USCRIPT_USAGE_UNKNOWN := 1
    static USCRIPT_USAGE_EXCLUDED := 2
    static USCRIPT_USAGE_LIMITED_USE := 3
    static USCRIPT_USAGE_ASPIRATIONAL := 4
    static USCRIPT_USAGE_RECOMMENDED := 5
}
struct UReplaceableCallbacks {
    length : IntPtr
    charAt : IntPtr
    char32At : IntPtr
    replace : IntPtr
    extract : IntPtr
    copy : IntPtr
}
struct UFieldPosition {
    field : Int32
    beginIndex : Int32
    endIndex : Int32
}
struct UCharIteratorOrigin extends Int32 {
    static UITER_START := 0
    static UITER_CURRENT := 1
    static UITER_LIMIT := 2
    static UITER_ZERO := 3
    static UITER_LENGTH := 4
}
struct UCharIteratorGetIndex extends FunctionPointer {
    static Types := [UCharIterator.Ptr, UCharIteratorOrigin, Int32]
    static Options := "C"
}
struct UCharIteratorMove extends FunctionPointer {
    static Types := [UCharIterator.Ptr, Int32, UCharIteratorOrigin, Int32]
    static Options := "C"
}
struct UCharIteratorHasNext extends FunctionPointer {
    static Types := [UCharIterator.Ptr, Int8]
    static Options := "C"
}
struct UCharIteratorHasPrevious extends FunctionPointer {
    static Types := [UCharIterator.Ptr, Int8]
    static Options := "C"
}
struct UCharIteratorCurrent extends FunctionPointer {
    static Types := [UCharIterator.Ptr, Int32]
    static Options := "C"
}
struct UCharIteratorNext extends FunctionPointer {
    static Types := [UCharIterator.Ptr, Int32]
    static Options := "C"
}
struct UCharIteratorPrevious extends FunctionPointer {
    static Types := [UCharIterator.Ptr, Int32]
    static Options := "C"
}
struct UCharIteratorReserved extends FunctionPointer {
    static Types := [UCharIterator.Ptr, Int32, Int32]
    static Options := "C"
}
struct UCharIteratorGetState extends FunctionPointer {
    static Types := [UCharIterator.Ptr, UInt32]
    static Options := "C"
}
struct UCharIteratorSetState extends FunctionPointer {
    static Types := [UCharIterator.Ptr, UInt32, UErrorCode.Ptr, "Void"]
    static Options := "C"
}
struct UCharIterator {
    context : Struct.Ptr
    length : Int32
    start : Int32
    index : Int32
    limit : Int32
    reservedField : Int32
    getIndex : UCharIteratorGetIndex
    move : UCharIteratorMove
    hasNext : UCharIteratorHasNext
    hasPrevious : UCharIteratorHasPrevious
    current : UCharIteratorCurrent
    next : UCharIteratorNext
    previous : UCharIteratorPrevious
    reservedFn : UCharIteratorReserved
    getState : UCharIteratorGetState
    setState : UCharIteratorSetState
}
struct ULocDataLocaleType extends Int32 {
    static ULOC_ACTUAL_LOCALE := 0
    static ULOC_VALID_LOCALE := 1
}
struct ULocAvailableType extends Int32 {
    static ULOC_AVAILABLE_DEFAULT := 0
    static ULOC_AVAILABLE_ONLY_LEGACY_ALIASES := 1
    static ULOC_AVAILABLE_WITH_LEGACY_ALIASES := 2
}
struct ULayoutType extends Int32 {
    static ULOC_LAYOUT_LTR := 0
    static ULOC_LAYOUT_RTL := 1
    static ULOC_LAYOUT_TTB := 2
    static ULOC_LAYOUT_BTT := 3
    static ULOC_LAYOUT_UNKNOWN := 4
}
struct UAcceptResult extends Int32 {
    static ULOC_ACCEPT_FAILED := 0
    static ULOC_ACCEPT_VALID := 1
    static ULOC_ACCEPT_FALLBACK := 2
}
struct UResType extends Int32 {
    static URES_NONE := -1
    static URES_STRING := 0
    static URES_BINARY := 1
    static URES_TABLE := 2
    static URES_ALIAS := 3
    static URES_INT := 7
    static URES_ARRAY := 8
    static URES_INT_VECTOR := 14
}
struct UDisplayContextType extends Int32 {
    static UDISPCTX_TYPE_DIALECT_HANDLING := 0
    static UDISPCTX_TYPE_CAPITALIZATION := 1
    static UDISPCTX_TYPE_DISPLAY_LENGTH := 2
    static UDISPCTX_TYPE_SUBSTITUTE_HANDLING := 3
}
struct UDisplayContext extends Int32 {
    static UDISPCTX_STANDARD_NAMES := 0
    static UDISPCTX_DIALECT_NAMES := 1
    static UDISPCTX_CAPITALIZATION_NONE := 256
    static UDISPCTX_CAPITALIZATION_FOR_MIDDLE_OF_SENTENCE := 257
    static UDISPCTX_CAPITALIZATION_FOR_BEGINNING_OF_SENTENCE := 258
    static UDISPCTX_CAPITALIZATION_FOR_UI_LIST_OR_MENU := 259
    static UDISPCTX_CAPITALIZATION_FOR_STANDALONE := 260
    static UDISPCTX_LENGTH_FULL := 512
    static UDISPCTX_LENGTH_SHORT := 513
    static UDISPCTX_SUBSTITUTE := 768
    static UDISPCTX_NO_SUBSTITUTE := 769
}
struct UDialectHandling extends Int32 {
    static ULDN_STANDARD_NAMES := 0
    static ULDN_DIALECT_NAMES := 1
}
struct UCurrencyUsage extends Int32 {
    static UCURR_USAGE_STANDARD := 0
    static UCURR_USAGE_CASH := 1
}
struct UCurrNameStyle extends Int32 {
    static UCURR_SYMBOL_NAME := 0
    static UCURR_LONG_NAME := 1
    static UCURR_NARROW_SYMBOL_NAME := 2
    static UCURR_VARIANT_SYMBOL_NAME := 3
}
struct UCurrCurrencyType extends Int32 {
    static UCURR_ALL := 2147483647
    static UCURR_COMMON := 1
    static UCURR_UNCOMMON := 2
    static UCURR_DEPRECATED := 4
    static UCURR_NON_DEPRECATED := 8
}
struct UCPMapRangeOption extends Int32 {
    static UCPMAP_RANGE_NORMAL := 0
    static UCPMAP_RANGE_FIXED_LEAD_SURROGATES := 1
    static UCPMAP_RANGE_FIXED_ALL_SURROGATES := 2
}
struct UCPMapValueFilter extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, UInt32]
    static Options := "C"
}
struct UCPTrieData {
    union {
        ptr0 : Struct.Ptr
        ptr16 : UInt16.Ptr
        ptr32 : UInt32.Ptr
        ptr8 : UInt8.Ptr
    }
}
struct UCPTrie {
    index : UInt16.Ptr
    data : UCPTrieData
    indexLength : Int32
    dataLength : Int32
    highStart : Int32
    shifted12HighStart : UInt16
    type : Int8
    valueWidth : Int8
    reserved32 : UInt32
    reserved16 : UInt16
    index3NullOffset : UInt16
    dataNullOffset : Int32
    nullValue : UInt32
}
struct UCPTrieType extends Int32 {
    static UCPTRIE_TYPE_ANY := -1
    static UCPTRIE_TYPE_FAST := 0
    static UCPTRIE_TYPE_SMALL := 1
}
struct UCPTrieValueWidth extends Int32 {
    static UCPTRIE_VALUE_BITS_ANY := -1
    static UCPTRIE_VALUE_BITS_16 := 0
    static UCPTRIE_VALUE_BITS_32 := 1
    static UCPTRIE_VALUE_BITS_8 := 2
}
struct UConverterCallbackReason extends Int32 {
    static UCNV_UNASSIGNED := 0
    static UCNV_ILLEGAL := 1
    static UCNV_IRREGULAR := 2
    static UCNV_RESET := 3
    static UCNV_CLOSE := 4
    static UCNV_CLONE := 5
}
struct UConverterFromUnicodeArgs {
    size : UInt16
    flush : Int8
    converter : UConverter.Ptr
    source : UInt16.Ptr
    sourceLimit : UInt16.Ptr
    target : PSTR
    targetLimit : PSTR
    offsets : Int32.Ptr
}
struct UConverterToUnicodeArgs {
    size : UInt16
    flush : Int8
    converter : UConverter.Ptr
    source : PSTR
    sourceLimit : PSTR
    target : UInt16.Ptr
    targetLimit : UInt16.Ptr
    offsets : Int32.Ptr
}
struct UConverterType extends Int32 {
    static UCNV_UNSUPPORTED_CONVERTER := -1
    static UCNV_SBCS := 0
    static UCNV_DBCS := 1
    static UCNV_MBCS := 2
    static UCNV_LATIN_1 := 3
    static UCNV_UTF8 := 4
    static UCNV_UTF16_BigEndian := 5
    static UCNV_UTF16_LittleEndian := 6
    static UCNV_UTF32_BigEndian := 7
    static UCNV_UTF32_LittleEndian := 8
    static UCNV_EBCDIC_STATEFUL := 9
    static UCNV_ISO_2022 := 10
    static UCNV_LMBCS_1 := 11
    static UCNV_LMBCS_2 := 12
    static UCNV_LMBCS_3 := 13
    static UCNV_LMBCS_4 := 14
    static UCNV_LMBCS_5 := 15
    static UCNV_LMBCS_6 := 16
    static UCNV_LMBCS_8 := 17
    static UCNV_LMBCS_11 := 18
    static UCNV_LMBCS_16 := 19
    static UCNV_LMBCS_17 := 20
    static UCNV_LMBCS_18 := 21
    static UCNV_LMBCS_19 := 22
    static UCNV_LMBCS_LAST := 22
    static UCNV_HZ := 23
    static UCNV_SCSU := 24
    static UCNV_ISCII := 25
    static UCNV_US_ASCII := 26
    static UCNV_UTF7 := 27
    static UCNV_BOCU1 := 28
    static UCNV_UTF16 := 29
    static UCNV_UTF32 := 30
    static UCNV_CESU8 := 31
    static UCNV_IMAP_MAILBOX := 32
    static UCNV_COMPOUND_TEXT := 33
    static UCNV_NUMBER_OF_SUPPORTED_CONVERTER_TYPES := 34
}
struct UConverterPlatform extends Int32 {
    static UCNV_UNKNOWN := -1
    static UCNV_IBM := 0
}
struct UConverterToUCallback extends FunctionPointer {
    static Types := [Struct.Ptr, UConverterToUnicodeArgs.Ptr, PSTR, Int32, UConverterCallbackReason, UErrorCode.Ptr, "Void"]
    static Options := "C"
}
struct UConverterFromUCallback extends FunctionPointer {
    static Types := [Struct.Ptr, UConverterFromUnicodeArgs.Ptr, UInt16.Ptr, Int32, Int32, UConverterCallbackReason, UErrorCode.Ptr, "Void"]
    static Options := "C"
}
struct UConverterUnicodeSet extends Int32 {
    static UCNV_ROUNDTRIP_SET := 0
    static UCNV_ROUNDTRIP_AND_FALLBACK_SET := 1
}
struct UMemAllocFn extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, Struct.Ptr]
    static Options := "C"
}
struct UMemReallocFn extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, IntPtr, Struct.Ptr]
    static Options := "C"
}
struct UMemFreeFn extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, "Void"]
    static Options := "C"
}
struct UProperty extends Int32 {
    static UCHAR_ALPHABETIC := 0
    static UCHAR_BINARY_START := 0
    static UCHAR_ASCII_HEX_DIGIT := 1
    static UCHAR_BIDI_CONTROL := 2
    static UCHAR_BIDI_MIRRORED := 3
    static UCHAR_DASH := 4
    static UCHAR_DEFAULT_IGNORABLE_CODE_POINT := 5
    static UCHAR_DEPRECATED := 6
    static UCHAR_DIACRITIC := 7
    static UCHAR_EXTENDER := 8
    static UCHAR_FULL_COMPOSITION_EXCLUSION := 9
    static UCHAR_GRAPHEME_BASE := 10
    static UCHAR_GRAPHEME_EXTEND := 11
    static UCHAR_GRAPHEME_LINK := 12
    static UCHAR_HEX_DIGIT := 13
    static UCHAR_HYPHEN := 14
    static UCHAR_ID_CONTINUE := 15
    static UCHAR_ID_START := 16
    static UCHAR_IDEOGRAPHIC := 17
    static UCHAR_IDS_BINARY_OPERATOR := 18
    static UCHAR_IDS_TRINARY_OPERATOR := 19
    static UCHAR_JOIN_CONTROL := 20
    static UCHAR_LOGICAL_ORDER_EXCEPTION := 21
    static UCHAR_LOWERCASE := 22
    static UCHAR_MATH := 23
    static UCHAR_NONCHARACTER_CODE_POINT := 24
    static UCHAR_QUOTATION_MARK := 25
    static UCHAR_RADICAL := 26
    static UCHAR_SOFT_DOTTED := 27
    static UCHAR_TERMINAL_PUNCTUATION := 28
    static UCHAR_UNIFIED_IDEOGRAPH := 29
    static UCHAR_UPPERCASE := 30
    static UCHAR_WHITE_SPACE := 31
    static UCHAR_XID_CONTINUE := 32
    static UCHAR_XID_START := 33
    static UCHAR_CASE_SENSITIVE := 34
    static UCHAR_S_TERM := 35
    static UCHAR_VARIATION_SELECTOR := 36
    static UCHAR_NFD_INERT := 37
    static UCHAR_NFKD_INERT := 38
    static UCHAR_NFC_INERT := 39
    static UCHAR_NFKC_INERT := 40
    static UCHAR_SEGMENT_STARTER := 41
    static UCHAR_PATTERN_SYNTAX := 42
    static UCHAR_PATTERN_WHITE_SPACE := 43
    static UCHAR_POSIX_ALNUM := 44
    static UCHAR_POSIX_BLANK := 45
    static UCHAR_POSIX_GRAPH := 46
    static UCHAR_POSIX_PRINT := 47
    static UCHAR_POSIX_XDIGIT := 48
    static UCHAR_CASED := 49
    static UCHAR_CASE_IGNORABLE := 50
    static UCHAR_CHANGES_WHEN_LOWERCASED := 51
    static UCHAR_CHANGES_WHEN_UPPERCASED := 52
    static UCHAR_CHANGES_WHEN_TITLECASED := 53
    static UCHAR_CHANGES_WHEN_CASEFOLDED := 54
    static UCHAR_CHANGES_WHEN_CASEMAPPED := 55
    static UCHAR_CHANGES_WHEN_NFKC_CASEFOLDED := 56
    static UCHAR_EMOJI := 57
    static UCHAR_EMOJI_PRESENTATION := 58
    static UCHAR_EMOJI_MODIFIER := 59
    static UCHAR_EMOJI_MODIFIER_BASE := 60
    static UCHAR_EMOJI_COMPONENT := 61
    static UCHAR_REGIONAL_INDICATOR := 62
    static UCHAR_PREPENDED_CONCATENATION_MARK := 63
    static UCHAR_EXTENDED_PICTOGRAPHIC := 64
    static UCHAR_BIDI_CLASS := 4096
    static UCHAR_INT_START := 4096
    static UCHAR_BLOCK := 4097
    static UCHAR_CANONICAL_COMBINING_CLASS := 4098
    static UCHAR_DECOMPOSITION_TYPE := 4099
    static UCHAR_EAST_ASIAN_WIDTH := 4100
    static UCHAR_GENERAL_CATEGORY := 4101
    static UCHAR_JOINING_GROUP := 4102
    static UCHAR_JOINING_TYPE := 4103
    static UCHAR_LINE_BREAK := 4104
    static UCHAR_NUMERIC_TYPE := 4105
    static UCHAR_SCRIPT := 4106
    static UCHAR_HANGUL_SYLLABLE_TYPE := 4107
    static UCHAR_NFD_QUICK_CHECK := 4108
    static UCHAR_NFKD_QUICK_CHECK := 4109
    static UCHAR_NFC_QUICK_CHECK := 4110
    static UCHAR_NFKC_QUICK_CHECK := 4111
    static UCHAR_LEAD_CANONICAL_COMBINING_CLASS := 4112
    static UCHAR_TRAIL_CANONICAL_COMBINING_CLASS := 4113
    static UCHAR_GRAPHEME_CLUSTER_BREAK := 4114
    static UCHAR_SENTENCE_BREAK := 4115
    static UCHAR_WORD_BREAK := 4116
    static UCHAR_BIDI_PAIRED_BRACKET_TYPE := 4117
    static UCHAR_INDIC_POSITIONAL_CATEGORY := 4118
    static UCHAR_INDIC_SYLLABIC_CATEGORY := 4119
    static UCHAR_VERTICAL_ORIENTATION := 4120
    static UCHAR_GENERAL_CATEGORY_MASK := 8192
    static UCHAR_MASK_START := 8192
    static UCHAR_NUMERIC_VALUE := 12288
    static UCHAR_DOUBLE_START := 12288
    static UCHAR_AGE := 16384
    static UCHAR_STRING_START := 16384
    static UCHAR_BIDI_MIRRORING_GLYPH := 16385
    static UCHAR_CASE_FOLDING := 16386
    static UCHAR_LOWERCASE_MAPPING := 16388
    static UCHAR_NAME := 16389
    static UCHAR_SIMPLE_CASE_FOLDING := 16390
    static UCHAR_SIMPLE_LOWERCASE_MAPPING := 16391
    static UCHAR_SIMPLE_TITLECASE_MAPPING := 16392
    static UCHAR_SIMPLE_UPPERCASE_MAPPING := 16393
    static UCHAR_TITLECASE_MAPPING := 16394
    static UCHAR_UPPERCASE_MAPPING := 16396
    static UCHAR_BIDI_PAIRED_BRACKET := 16397
    static UCHAR_SCRIPT_EXTENSIONS := 28672
    static UCHAR_OTHER_PROPERTY_START := 28672
    static UCHAR_INVALID_CODE := -1
}
struct UCharCategory extends Int32 {
    static U_UNASSIGNED := 0
    static U_GENERAL_OTHER_TYPES := 0
    static U_UPPERCASE_LETTER := 1
    static U_LOWERCASE_LETTER := 2
    static U_TITLECASE_LETTER := 3
    static U_MODIFIER_LETTER := 4
    static U_OTHER_LETTER := 5
    static U_NON_SPACING_MARK := 6
    static U_ENCLOSING_MARK := 7
    static U_COMBINING_SPACING_MARK := 8
    static U_DECIMAL_DIGIT_NUMBER := 9
    static U_LETTER_NUMBER := 10
    static U_OTHER_NUMBER := 11
    static U_SPACE_SEPARATOR := 12
    static U_LINE_SEPARATOR := 13
    static U_PARAGRAPH_SEPARATOR := 14
    static U_CONTROL_CHAR := 15
    static U_FORMAT_CHAR := 16
    static U_PRIVATE_USE_CHAR := 17
    static U_SURROGATE := 18
    static U_DASH_PUNCTUATION := 19
    static U_START_PUNCTUATION := 20
    static U_END_PUNCTUATION := 21
    static U_CONNECTOR_PUNCTUATION := 22
    static U_OTHER_PUNCTUATION := 23
    static U_MATH_SYMBOL := 24
    static U_CURRENCY_SYMBOL := 25
    static U_MODIFIER_SYMBOL := 26
    static U_OTHER_SYMBOL := 27
    static U_INITIAL_PUNCTUATION := 28
    static U_FINAL_PUNCTUATION := 29
    static U_CHAR_CATEGORY_COUNT := 30
}
struct UCharDirection extends Int32 {
    static U_LEFT_TO_RIGHT := 0
    static U_RIGHT_TO_LEFT := 1
    static U_EUROPEAN_NUMBER := 2
    static U_EUROPEAN_NUMBER_SEPARATOR := 3
    static U_EUROPEAN_NUMBER_TERMINATOR := 4
    static U_ARABIC_NUMBER := 5
    static U_COMMON_NUMBER_SEPARATOR := 6
    static U_BLOCK_SEPARATOR := 7
    static U_SEGMENT_SEPARATOR := 8
    static U_WHITE_SPACE_NEUTRAL := 9
    static U_OTHER_NEUTRAL := 10
    static U_LEFT_TO_RIGHT_EMBEDDING := 11
    static U_LEFT_TO_RIGHT_OVERRIDE := 12
    static U_RIGHT_TO_LEFT_ARABIC := 13
    static U_RIGHT_TO_LEFT_EMBEDDING := 14
    static U_RIGHT_TO_LEFT_OVERRIDE := 15
    static U_POP_DIRECTIONAL_FORMAT := 16
    static U_DIR_NON_SPACING_MARK := 17
    static U_BOUNDARY_NEUTRAL := 18
    static U_FIRST_STRONG_ISOLATE := 19
    static U_LEFT_TO_RIGHT_ISOLATE := 20
    static U_RIGHT_TO_LEFT_ISOLATE := 21
    static U_POP_DIRECTIONAL_ISOLATE := 22
}
struct UBidiPairedBracketType extends Int32 {
    static U_BPT_NONE := 0
    static U_BPT_OPEN := 1
    static U_BPT_CLOSE := 2
}
struct UBlockCode extends Int32 {
    static UBLOCK_NO_BLOCK := 0
    static UBLOCK_BASIC_LATIN := 1
    static UBLOCK_LATIN_1_SUPPLEMENT := 2
    static UBLOCK_LATIN_EXTENDED_A := 3
    static UBLOCK_LATIN_EXTENDED_B := 4
    static UBLOCK_IPA_EXTENSIONS := 5
    static UBLOCK_SPACING_MODIFIER_LETTERS := 6
    static UBLOCK_COMBINING_DIACRITICAL_MARKS := 7
    static UBLOCK_GREEK := 8
    static UBLOCK_CYRILLIC := 9
    static UBLOCK_ARMENIAN := 10
    static UBLOCK_HEBREW := 11
    static UBLOCK_ARABIC := 12
    static UBLOCK_SYRIAC := 13
    static UBLOCK_THAANA := 14
    static UBLOCK_DEVANAGARI := 15
    static UBLOCK_BENGALI := 16
    static UBLOCK_GURMUKHI := 17
    static UBLOCK_GUJARATI := 18
    static UBLOCK_ORIYA := 19
    static UBLOCK_TAMIL := 20
    static UBLOCK_TELUGU := 21
    static UBLOCK_KANNADA := 22
    static UBLOCK_MALAYALAM := 23
    static UBLOCK_SINHALA := 24
    static UBLOCK_THAI := 25
    static UBLOCK_LAO := 26
    static UBLOCK_TIBETAN := 27
    static UBLOCK_MYANMAR := 28
    static UBLOCK_GEORGIAN := 29
    static UBLOCK_HANGUL_JAMO := 30
    static UBLOCK_ETHIOPIC := 31
    static UBLOCK_CHEROKEE := 32
    static UBLOCK_UNIFIED_CANADIAN_ABORIGINAL_SYLLABICS := 33
    static UBLOCK_OGHAM := 34
    static UBLOCK_RUNIC := 35
    static UBLOCK_KHMER := 36
    static UBLOCK_MONGOLIAN := 37
    static UBLOCK_LATIN_EXTENDED_ADDITIONAL := 38
    static UBLOCK_GREEK_EXTENDED := 39
    static UBLOCK_GENERAL_PUNCTUATION := 40
    static UBLOCK_SUPERSCRIPTS_AND_SUBSCRIPTS := 41
    static UBLOCK_CURRENCY_SYMBOLS := 42
    static UBLOCK_COMBINING_MARKS_FOR_SYMBOLS := 43
    static UBLOCK_LETTERLIKE_SYMBOLS := 44
    static UBLOCK_NUMBER_FORMS := 45
    static UBLOCK_ARROWS := 46
    static UBLOCK_MATHEMATICAL_OPERATORS := 47
    static UBLOCK_MISCELLANEOUS_TECHNICAL := 48
    static UBLOCK_CONTROL_PICTURES := 49
    static UBLOCK_OPTICAL_CHARACTER_RECOGNITION := 50
    static UBLOCK_ENCLOSED_ALPHANUMERICS := 51
    static UBLOCK_BOX_DRAWING := 52
    static UBLOCK_BLOCK_ELEMENTS := 53
    static UBLOCK_GEOMETRIC_SHAPES := 54
    static UBLOCK_MISCELLANEOUS_SYMBOLS := 55
    static UBLOCK_DINGBATS := 56
    static UBLOCK_BRAILLE_PATTERNS := 57
    static UBLOCK_CJK_RADICALS_SUPPLEMENT := 58
    static UBLOCK_KANGXI_RADICALS := 59
    static UBLOCK_IDEOGRAPHIC_DESCRIPTION_CHARACTERS := 60
    static UBLOCK_CJK_SYMBOLS_AND_PUNCTUATION := 61
    static UBLOCK_HIRAGANA := 62
    static UBLOCK_KATAKANA := 63
    static UBLOCK_BOPOMOFO := 64
    static UBLOCK_HANGUL_COMPATIBILITY_JAMO := 65
    static UBLOCK_KANBUN := 66
    static UBLOCK_BOPOMOFO_EXTENDED := 67
    static UBLOCK_ENCLOSED_CJK_LETTERS_AND_MONTHS := 68
    static UBLOCK_CJK_COMPATIBILITY := 69
    static UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_A := 70
    static UBLOCK_CJK_UNIFIED_IDEOGRAPHS := 71
    static UBLOCK_YI_SYLLABLES := 72
    static UBLOCK_YI_RADICALS := 73
    static UBLOCK_HANGUL_SYLLABLES := 74
    static UBLOCK_HIGH_SURROGATES := 75
    static UBLOCK_HIGH_PRIVATE_USE_SURROGATES := 76
    static UBLOCK_LOW_SURROGATES := 77
    static UBLOCK_PRIVATE_USE_AREA := 78
    static UBLOCK_PRIVATE_USE := 78
    static UBLOCK_CJK_COMPATIBILITY_IDEOGRAPHS := 79
    static UBLOCK_ALPHABETIC_PRESENTATION_FORMS := 80
    static UBLOCK_ARABIC_PRESENTATION_FORMS_A := 81
    static UBLOCK_COMBINING_HALF_MARKS := 82
    static UBLOCK_CJK_COMPATIBILITY_FORMS := 83
    static UBLOCK_SMALL_FORM_VARIANTS := 84
    static UBLOCK_ARABIC_PRESENTATION_FORMS_B := 85
    static UBLOCK_SPECIALS := 86
    static UBLOCK_HALFWIDTH_AND_FULLWIDTH_FORMS := 87
    static UBLOCK_OLD_ITALIC := 88
    static UBLOCK_GOTHIC := 89
    static UBLOCK_DESERET := 90
    static UBLOCK_BYZANTINE_MUSICAL_SYMBOLS := 91
    static UBLOCK_MUSICAL_SYMBOLS := 92
    static UBLOCK_MATHEMATICAL_ALPHANUMERIC_SYMBOLS := 93
    static UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_B := 94
    static UBLOCK_CJK_COMPATIBILITY_IDEOGRAPHS_SUPPLEMENT := 95
    static UBLOCK_TAGS := 96
    static UBLOCK_CYRILLIC_SUPPLEMENT := 97
    static UBLOCK_CYRILLIC_SUPPLEMENTARY := 97
    static UBLOCK_TAGALOG := 98
    static UBLOCK_HANUNOO := 99
    static UBLOCK_BUHID := 100
    static UBLOCK_TAGBANWA := 101
    static UBLOCK_MISCELLANEOUS_MATHEMATICAL_SYMBOLS_A := 102
    static UBLOCK_SUPPLEMENTAL_ARROWS_A := 103
    static UBLOCK_SUPPLEMENTAL_ARROWS_B := 104
    static UBLOCK_MISCELLANEOUS_MATHEMATICAL_SYMBOLS_B := 105
    static UBLOCK_SUPPLEMENTAL_MATHEMATICAL_OPERATORS := 106
    static UBLOCK_KATAKANA_PHONETIC_EXTENSIONS := 107
    static UBLOCK_VARIATION_SELECTORS := 108
    static UBLOCK_SUPPLEMENTARY_PRIVATE_USE_AREA_A := 109
    static UBLOCK_SUPPLEMENTARY_PRIVATE_USE_AREA_B := 110
    static UBLOCK_LIMBU := 111
    static UBLOCK_TAI_LE := 112
    static UBLOCK_KHMER_SYMBOLS := 113
    static UBLOCK_PHONETIC_EXTENSIONS := 114
    static UBLOCK_MISCELLANEOUS_SYMBOLS_AND_ARROWS := 115
    static UBLOCK_YIJING_HEXAGRAM_SYMBOLS := 116
    static UBLOCK_LINEAR_B_SYLLABARY := 117
    static UBLOCK_LINEAR_B_IDEOGRAMS := 118
    static UBLOCK_AEGEAN_NUMBERS := 119
    static UBLOCK_UGARITIC := 120
    static UBLOCK_SHAVIAN := 121
    static UBLOCK_OSMANYA := 122
    static UBLOCK_CYPRIOT_SYLLABARY := 123
    static UBLOCK_TAI_XUAN_JING_SYMBOLS := 124
    static UBLOCK_VARIATION_SELECTORS_SUPPLEMENT := 125
    static UBLOCK_ANCIENT_GREEK_MUSICAL_NOTATION := 126
    static UBLOCK_ANCIENT_GREEK_NUMBERS := 127
    static UBLOCK_ARABIC_SUPPLEMENT := 128
    static UBLOCK_BUGINESE := 129
    static UBLOCK_CJK_STROKES := 130
    static UBLOCK_COMBINING_DIACRITICAL_MARKS_SUPPLEMENT := 131
    static UBLOCK_COPTIC := 132
    static UBLOCK_ETHIOPIC_EXTENDED := 133
    static UBLOCK_ETHIOPIC_SUPPLEMENT := 134
    static UBLOCK_GEORGIAN_SUPPLEMENT := 135
    static UBLOCK_GLAGOLITIC := 136
    static UBLOCK_KHAROSHTHI := 137
    static UBLOCK_MODIFIER_TONE_LETTERS := 138
    static UBLOCK_NEW_TAI_LUE := 139
    static UBLOCK_OLD_PERSIAN := 140
    static UBLOCK_PHONETIC_EXTENSIONS_SUPPLEMENT := 141
    static UBLOCK_SUPPLEMENTAL_PUNCTUATION := 142
    static UBLOCK_SYLOTI_NAGRI := 143
    static UBLOCK_TIFINAGH := 144
    static UBLOCK_VERTICAL_FORMS := 145
    static UBLOCK_NKO := 146
    static UBLOCK_BALINESE := 147
    static UBLOCK_LATIN_EXTENDED_C := 148
    static UBLOCK_LATIN_EXTENDED_D := 149
    static UBLOCK_PHAGS_PA := 150
    static UBLOCK_PHOENICIAN := 151
    static UBLOCK_CUNEIFORM := 152
    static UBLOCK_CUNEIFORM_NUMBERS_AND_PUNCTUATION := 153
    static UBLOCK_COUNTING_ROD_NUMERALS := 154
    static UBLOCK_SUNDANESE := 155
    static UBLOCK_LEPCHA := 156
    static UBLOCK_OL_CHIKI := 157
    static UBLOCK_CYRILLIC_EXTENDED_A := 158
    static UBLOCK_VAI := 159
    static UBLOCK_CYRILLIC_EXTENDED_B := 160
    static UBLOCK_SAURASHTRA := 161
    static UBLOCK_KAYAH_LI := 162
    static UBLOCK_REJANG := 163
    static UBLOCK_CHAM := 164
    static UBLOCK_ANCIENT_SYMBOLS := 165
    static UBLOCK_PHAISTOS_DISC := 166
    static UBLOCK_LYCIAN := 167
    static UBLOCK_CARIAN := 168
    static UBLOCK_LYDIAN := 169
    static UBLOCK_MAHJONG_TILES := 170
    static UBLOCK_DOMINO_TILES := 171
    static UBLOCK_SAMARITAN := 172
    static UBLOCK_UNIFIED_CANADIAN_ABORIGINAL_SYLLABICS_EXTENDED := 173
    static UBLOCK_TAI_THAM := 174
    static UBLOCK_VEDIC_EXTENSIONS := 175
    static UBLOCK_LISU := 176
    static UBLOCK_BAMUM := 177
    static UBLOCK_COMMON_INDIC_NUMBER_FORMS := 178
    static UBLOCK_DEVANAGARI_EXTENDED := 179
    static UBLOCK_HANGUL_JAMO_EXTENDED_A := 180
    static UBLOCK_JAVANESE := 181
    static UBLOCK_MYANMAR_EXTENDED_A := 182
    static UBLOCK_TAI_VIET := 183
    static UBLOCK_MEETEI_MAYEK := 184
    static UBLOCK_HANGUL_JAMO_EXTENDED_B := 185
    static UBLOCK_IMPERIAL_ARAMAIC := 186
    static UBLOCK_OLD_SOUTH_ARABIAN := 187
    static UBLOCK_AVESTAN := 188
    static UBLOCK_INSCRIPTIONAL_PARTHIAN := 189
    static UBLOCK_INSCRIPTIONAL_PAHLAVI := 190
    static UBLOCK_OLD_TURKIC := 191
    static UBLOCK_RUMI_NUMERAL_SYMBOLS := 192
    static UBLOCK_KAITHI := 193
    static UBLOCK_EGYPTIAN_HIEROGLYPHS := 194
    static UBLOCK_ENCLOSED_ALPHANUMERIC_SUPPLEMENT := 195
    static UBLOCK_ENCLOSED_IDEOGRAPHIC_SUPPLEMENT := 196
    static UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_C := 197
    static UBLOCK_MANDAIC := 198
    static UBLOCK_BATAK := 199
    static UBLOCK_ETHIOPIC_EXTENDED_A := 200
    static UBLOCK_BRAHMI := 201
    static UBLOCK_BAMUM_SUPPLEMENT := 202
    static UBLOCK_KANA_SUPPLEMENT := 203
    static UBLOCK_PLAYING_CARDS := 204
    static UBLOCK_MISCELLANEOUS_SYMBOLS_AND_PICTOGRAPHS := 205
    static UBLOCK_EMOTICONS := 206
    static UBLOCK_TRANSPORT_AND_MAP_SYMBOLS := 207
    static UBLOCK_ALCHEMICAL_SYMBOLS := 208
    static UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_D := 209
    static UBLOCK_ARABIC_EXTENDED_A := 210
    static UBLOCK_ARABIC_MATHEMATICAL_ALPHABETIC_SYMBOLS := 211
    static UBLOCK_CHAKMA := 212
    static UBLOCK_MEETEI_MAYEK_EXTENSIONS := 213
    static UBLOCK_MEROITIC_CURSIVE := 214
    static UBLOCK_MEROITIC_HIEROGLYPHS := 215
    static UBLOCK_MIAO := 216
    static UBLOCK_SHARADA := 217
    static UBLOCK_SORA_SOMPENG := 218
    static UBLOCK_SUNDANESE_SUPPLEMENT := 219
    static UBLOCK_TAKRI := 220
    static UBLOCK_BASSA_VAH := 221
    static UBLOCK_CAUCASIAN_ALBANIAN := 222
    static UBLOCK_COPTIC_EPACT_NUMBERS := 223
    static UBLOCK_COMBINING_DIACRITICAL_MARKS_EXTENDED := 224
    static UBLOCK_DUPLOYAN := 225
    static UBLOCK_ELBASAN := 226
    static UBLOCK_GEOMETRIC_SHAPES_EXTENDED := 227
    static UBLOCK_GRANTHA := 228
    static UBLOCK_KHOJKI := 229
    static UBLOCK_KHUDAWADI := 230
    static UBLOCK_LATIN_EXTENDED_E := 231
    static UBLOCK_LINEAR_A := 232
    static UBLOCK_MAHAJANI := 233
    static UBLOCK_MANICHAEAN := 234
    static UBLOCK_MENDE_KIKAKUI := 235
    static UBLOCK_MODI := 236
    static UBLOCK_MRO := 237
    static UBLOCK_MYANMAR_EXTENDED_B := 238
    static UBLOCK_NABATAEAN := 239
    static UBLOCK_OLD_NORTH_ARABIAN := 240
    static UBLOCK_OLD_PERMIC := 241
    static UBLOCK_ORNAMENTAL_DINGBATS := 242
    static UBLOCK_PAHAWH_HMONG := 243
    static UBLOCK_PALMYRENE := 244
    static UBLOCK_PAU_CIN_HAU := 245
    static UBLOCK_PSALTER_PAHLAVI := 246
    static UBLOCK_SHORTHAND_FORMAT_CONTROLS := 247
    static UBLOCK_SIDDHAM := 248
    static UBLOCK_SINHALA_ARCHAIC_NUMBERS := 249
    static UBLOCK_SUPPLEMENTAL_ARROWS_C := 250
    static UBLOCK_TIRHUTA := 251
    static UBLOCK_WARANG_CITI := 252
    static UBLOCK_AHOM := 253
    static UBLOCK_ANATOLIAN_HIEROGLYPHS := 254
    static UBLOCK_CHEROKEE_SUPPLEMENT := 255
    static UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_E := 256
    static UBLOCK_EARLY_DYNASTIC_CUNEIFORM := 257
    static UBLOCK_HATRAN := 258
    static UBLOCK_MULTANI := 259
    static UBLOCK_OLD_HUNGARIAN := 260
    static UBLOCK_SUPPLEMENTAL_SYMBOLS_AND_PICTOGRAPHS := 261
    static UBLOCK_SUTTON_SIGNWRITING := 262
    static UBLOCK_ADLAM := 263
    static UBLOCK_BHAIKSUKI := 264
    static UBLOCK_CYRILLIC_EXTENDED_C := 265
    static UBLOCK_GLAGOLITIC_SUPPLEMENT := 266
    static UBLOCK_IDEOGRAPHIC_SYMBOLS_AND_PUNCTUATION := 267
    static UBLOCK_MARCHEN := 268
    static UBLOCK_MONGOLIAN_SUPPLEMENT := 269
    static UBLOCK_NEWA := 270
    static UBLOCK_OSAGE := 271
    static UBLOCK_TANGUT := 272
    static UBLOCK_TANGUT_COMPONENTS := 273
    static UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_F := 274
    static UBLOCK_KANA_EXTENDED_A := 275
    static UBLOCK_MASARAM_GONDI := 276
    static UBLOCK_NUSHU := 277
    static UBLOCK_SOYOMBO := 278
    static UBLOCK_SYRIAC_SUPPLEMENT := 279
    static UBLOCK_ZANABAZAR_SQUARE := 280
    static UBLOCK_CHESS_SYMBOLS := 281
    static UBLOCK_DOGRA := 282
    static UBLOCK_GEORGIAN_EXTENDED := 283
    static UBLOCK_GUNJALA_GONDI := 284
    static UBLOCK_HANIFI_ROHINGYA := 285
    static UBLOCK_INDIC_SIYAQ_NUMBERS := 286
    static UBLOCK_MAKASAR := 287
    static UBLOCK_MAYAN_NUMERALS := 288
    static UBLOCK_MEDEFAIDRIN := 289
    static UBLOCK_OLD_SOGDIAN := 290
    static UBLOCK_SOGDIAN := 291
    static UBLOCK_EGYPTIAN_HIEROGLYPH_FORMAT_CONTROLS := 292
    static UBLOCK_ELYMAIC := 293
    static UBLOCK_NANDINAGARI := 294
    static UBLOCK_NYIAKENG_PUACHUE_HMONG := 295
    static UBLOCK_OTTOMAN_SIYAQ_NUMBERS := 296
    static UBLOCK_SMALL_KANA_EXTENSION := 297
    static UBLOCK_SYMBOLS_AND_PICTOGRAPHS_EXTENDED_A := 298
    static UBLOCK_TAMIL_SUPPLEMENT := 299
    static UBLOCK_WANCHO := 300
    static UBLOCK_CHORASMIAN := 301
    static UBLOCK_CJK_UNIFIED_IDEOGRAPHS_EXTENSION_G := 302
    static UBLOCK_DIVES_AKURU := 303
    static UBLOCK_KHITAN_SMALL_SCRIPT := 304
    static UBLOCK_LISU_SUPPLEMENT := 305
    static UBLOCK_SYMBOLS_FOR_LEGACY_COMPUTING := 306
    static UBLOCK_TANGUT_SUPPLEMENT := 307
    static UBLOCK_YEZIDI := 308
    static UBLOCK_INVALID_CODE := -1
}
struct UEastAsianWidth extends Int32 {
    static U_EA_NEUTRAL := 0
    static U_EA_AMBIGUOUS := 1
    static U_EA_HALFWIDTH := 2
    static U_EA_FULLWIDTH := 3
    static U_EA_NARROW := 4
    static U_EA_WIDE := 5
}
struct UCharNameChoice extends Int32 {
    static U_UNICODE_CHAR_NAME := 0
    static U_EXTENDED_CHAR_NAME := 2
    static U_CHAR_NAME_ALIAS := 3
}
struct UPropertyNameChoice extends Int32 {
    static U_SHORT_PROPERTY_NAME := 0
    static U_LONG_PROPERTY_NAME := 1
}
struct UDecompositionType extends Int32 {
    static U_DT_NONE := 0
    static U_DT_CANONICAL := 1
    static U_DT_COMPAT := 2
    static U_DT_CIRCLE := 3
    static U_DT_FINAL := 4
    static U_DT_FONT := 5
    static U_DT_FRACTION := 6
    static U_DT_INITIAL := 7
    static U_DT_ISOLATED := 8
    static U_DT_MEDIAL := 9
    static U_DT_NARROW := 10
    static U_DT_NOBREAK := 11
    static U_DT_SMALL := 12
    static U_DT_SQUARE := 13
    static U_DT_SUB := 14
    static U_DT_SUPER := 15
    static U_DT_VERTICAL := 16
    static U_DT_WIDE := 17
}
struct UJoiningType extends Int32 {
    static U_JT_NON_JOINING := 0
    static U_JT_JOIN_CAUSING := 1
    static U_JT_DUAL_JOINING := 2
    static U_JT_LEFT_JOINING := 3
    static U_JT_RIGHT_JOINING := 4
    static U_JT_TRANSPARENT := 5
}
struct UJoiningGroup extends Int32 {
    static U_JG_NO_JOINING_GROUP := 0
    static U_JG_AIN := 1
    static U_JG_ALAPH := 2
    static U_JG_ALEF := 3
    static U_JG_BEH := 4
    static U_JG_BETH := 5
    static U_JG_DAL := 6
    static U_JG_DALATH_RISH := 7
    static U_JG_E := 8
    static U_JG_FEH := 9
    static U_JG_FINAL_SEMKATH := 10
    static U_JG_GAF := 11
    static U_JG_GAMAL := 12
    static U_JG_HAH := 13
    static U_JG_TEH_MARBUTA_GOAL := 14
    static U_JG_HAMZA_ON_HEH_GOAL := 14
    static U_JG_HE := 15
    static U_JG_HEH := 16
    static U_JG_HEH_GOAL := 17
    static U_JG_HETH := 18
    static U_JG_KAF := 19
    static U_JG_KAPH := 20
    static U_JG_KNOTTED_HEH := 21
    static U_JG_LAM := 22
    static U_JG_LAMADH := 23
    static U_JG_MEEM := 24
    static U_JG_MIM := 25
    static U_JG_NOON := 26
    static U_JG_NUN := 27
    static U_JG_PE := 28
    static U_JG_QAF := 29
    static U_JG_QAPH := 30
    static U_JG_REH := 31
    static U_JG_REVERSED_PE := 32
    static U_JG_SAD := 33
    static U_JG_SADHE := 34
    static U_JG_SEEN := 35
    static U_JG_SEMKATH := 36
    static U_JG_SHIN := 37
    static U_JG_SWASH_KAF := 38
    static U_JG_SYRIAC_WAW := 39
    static U_JG_TAH := 40
    static U_JG_TAW := 41
    static U_JG_TEH_MARBUTA := 42
    static U_JG_TETH := 43
    static U_JG_WAW := 44
    static U_JG_YEH := 45
    static U_JG_YEH_BARREE := 46
    static U_JG_YEH_WITH_TAIL := 47
    static U_JG_YUDH := 48
    static U_JG_YUDH_HE := 49
    static U_JG_ZAIN := 50
    static U_JG_FE := 51
    static U_JG_KHAPH := 52
    static U_JG_ZHAIN := 53
    static U_JG_BURUSHASKI_YEH_BARREE := 54
    static U_JG_FARSI_YEH := 55
    static U_JG_NYA := 56
    static U_JG_ROHINGYA_YEH := 57
    static U_JG_MANICHAEAN_ALEPH := 58
    static U_JG_MANICHAEAN_AYIN := 59
    static U_JG_MANICHAEAN_BETH := 60
    static U_JG_MANICHAEAN_DALETH := 61
    static U_JG_MANICHAEAN_DHAMEDH := 62
    static U_JG_MANICHAEAN_FIVE := 63
    static U_JG_MANICHAEAN_GIMEL := 64
    static U_JG_MANICHAEAN_HETH := 65
    static U_JG_MANICHAEAN_HUNDRED := 66
    static U_JG_MANICHAEAN_KAPH := 67
    static U_JG_MANICHAEAN_LAMEDH := 68
    static U_JG_MANICHAEAN_MEM := 69
    static U_JG_MANICHAEAN_NUN := 70
    static U_JG_MANICHAEAN_ONE := 71
    static U_JG_MANICHAEAN_PE := 72
    static U_JG_MANICHAEAN_QOPH := 73
    static U_JG_MANICHAEAN_RESH := 74
    static U_JG_MANICHAEAN_SADHE := 75
    static U_JG_MANICHAEAN_SAMEKH := 76
    static U_JG_MANICHAEAN_TAW := 77
    static U_JG_MANICHAEAN_TEN := 78
    static U_JG_MANICHAEAN_TETH := 79
    static U_JG_MANICHAEAN_THAMEDH := 80
    static U_JG_MANICHAEAN_TWENTY := 81
    static U_JG_MANICHAEAN_WAW := 82
    static U_JG_MANICHAEAN_YODH := 83
    static U_JG_MANICHAEAN_ZAYIN := 84
    static U_JG_STRAIGHT_WAW := 85
    static U_JG_AFRICAN_FEH := 86
    static U_JG_AFRICAN_NOON := 87
    static U_JG_AFRICAN_QAF := 88
    static U_JG_MALAYALAM_BHA := 89
    static U_JG_MALAYALAM_JA := 90
    static U_JG_MALAYALAM_LLA := 91
    static U_JG_MALAYALAM_LLLA := 92
    static U_JG_MALAYALAM_NGA := 93
    static U_JG_MALAYALAM_NNA := 94
    static U_JG_MALAYALAM_NNNA := 95
    static U_JG_MALAYALAM_NYA := 96
    static U_JG_MALAYALAM_RA := 97
    static U_JG_MALAYALAM_SSA := 98
    static U_JG_MALAYALAM_TTA := 99
    static U_JG_HANIFI_ROHINGYA_KINNA_YA := 100
    static U_JG_HANIFI_ROHINGYA_PA := 101
    static U_JG_THIN_YEH := 102
    static U_JG_VERTICAL_TAIL := 103
}
struct UGraphemeClusterBreak extends Int32 {
    static U_GCB_OTHER := 0
    static U_GCB_CONTROL := 1
    static U_GCB_CR := 2
    static U_GCB_EXTEND := 3
    static U_GCB_L := 4
    static U_GCB_LF := 5
    static U_GCB_LV := 6
    static U_GCB_LVT := 7
    static U_GCB_T := 8
    static U_GCB_V := 9
    static U_GCB_SPACING_MARK := 10
    static U_GCB_PREPEND := 11
    static U_GCB_REGIONAL_INDICATOR := 12
    static U_GCB_E_BASE := 13
    static U_GCB_E_BASE_GAZ := 14
    static U_GCB_E_MODIFIER := 15
    static U_GCB_GLUE_AFTER_ZWJ := 16
    static U_GCB_ZWJ := 17
}
struct UWordBreakValues extends Int32 {
    static U_WB_OTHER := 0
    static U_WB_ALETTER := 1
    static U_WB_FORMAT := 2
    static U_WB_KATAKANA := 3
    static U_WB_MIDLETTER := 4
    static U_WB_MIDNUM := 5
    static U_WB_NUMERIC := 6
    static U_WB_EXTENDNUMLET := 7
    static U_WB_CR := 8
    static U_WB_EXTEND := 9
    static U_WB_LF := 10
    static U_WB_MIDNUMLET := 11
    static U_WB_NEWLINE := 12
    static U_WB_REGIONAL_INDICATOR := 13
    static U_WB_HEBREW_LETTER := 14
    static U_WB_SINGLE_QUOTE := 15
    static U_WB_DOUBLE_QUOTE := 16
    static U_WB_E_BASE := 17
    static U_WB_E_BASE_GAZ := 18
    static U_WB_E_MODIFIER := 19
    static U_WB_GLUE_AFTER_ZWJ := 20
    static U_WB_ZWJ := 21
    static U_WB_WSEGSPACE := 22
}
struct USentenceBreak extends Int32 {
    static U_SB_OTHER := 0
    static U_SB_ATERM := 1
    static U_SB_CLOSE := 2
    static U_SB_FORMAT := 3
    static U_SB_LOWER := 4
    static U_SB_NUMERIC := 5
    static U_SB_OLETTER := 6
    static U_SB_SEP := 7
    static U_SB_SP := 8
    static U_SB_STERM := 9
    static U_SB_UPPER := 10
    static U_SB_CR := 11
    static U_SB_EXTEND := 12
    static U_SB_LF := 13
    static U_SB_SCONTINUE := 14
}
struct ULineBreak extends Int32 {
    static U_LB_UNKNOWN := 0
    static U_LB_AMBIGUOUS := 1
    static U_LB_ALPHABETIC := 2
    static U_LB_BREAK_BOTH := 3
    static U_LB_BREAK_AFTER := 4
    static U_LB_BREAK_BEFORE := 5
    static U_LB_MANDATORY_BREAK := 6
    static U_LB_CONTINGENT_BREAK := 7
    static U_LB_CLOSE_PUNCTUATION := 8
    static U_LB_COMBINING_MARK := 9
    static U_LB_CARRIAGE_RETURN := 10
    static U_LB_EXCLAMATION := 11
    static U_LB_GLUE := 12
    static U_LB_HYPHEN := 13
    static U_LB_IDEOGRAPHIC := 14
    static U_LB_INSEPARABLE := 15
    static U_LB_INSEPERABLE := 15
    static U_LB_INFIX_NUMERIC := 16
    static U_LB_LINE_FEED := 17
    static U_LB_NONSTARTER := 18
    static U_LB_NUMERIC := 19
    static U_LB_OPEN_PUNCTUATION := 20
    static U_LB_POSTFIX_NUMERIC := 21
    static U_LB_PREFIX_NUMERIC := 22
    static U_LB_QUOTATION := 23
    static U_LB_COMPLEX_CONTEXT := 24
    static U_LB_SURROGATE := 25
    static U_LB_SPACE := 26
    static U_LB_BREAK_SYMBOLS := 27
    static U_LB_ZWSPACE := 28
    static U_LB_NEXT_LINE := 29
    static U_LB_WORD_JOINER := 30
    static U_LB_H2 := 31
    static U_LB_H3 := 32
    static U_LB_JL := 33
    static U_LB_JT := 34
    static U_LB_JV := 35
    static U_LB_CLOSE_PARENTHESIS := 36
    static U_LB_CONDITIONAL_JAPANESE_STARTER := 37
    static U_LB_HEBREW_LETTER := 38
    static U_LB_REGIONAL_INDICATOR := 39
    static U_LB_E_BASE := 40
    static U_LB_E_MODIFIER := 41
    static U_LB_ZWJ := 42
}
struct UNumericType extends Int32 {
    static U_NT_NONE := 0
    static U_NT_DECIMAL := 1
    static U_NT_DIGIT := 2
    static U_NT_NUMERIC := 3
}
struct UHangulSyllableType extends Int32 {
    static U_HST_NOT_APPLICABLE := 0
    static U_HST_LEADING_JAMO := 1
    static U_HST_VOWEL_JAMO := 2
    static U_HST_TRAILING_JAMO := 3
    static U_HST_LV_SYLLABLE := 4
    static U_HST_LVT_SYLLABLE := 5
}
struct UIndicPositionalCategory extends Int32 {
    static U_INPC_NA := 0
    static U_INPC_BOTTOM := 1
    static U_INPC_BOTTOM_AND_LEFT := 2
    static U_INPC_BOTTOM_AND_RIGHT := 3
    static U_INPC_LEFT := 4
    static U_INPC_LEFT_AND_RIGHT := 5
    static U_INPC_OVERSTRUCK := 6
    static U_INPC_RIGHT := 7
    static U_INPC_TOP := 8
    static U_INPC_TOP_AND_BOTTOM := 9
    static U_INPC_TOP_AND_BOTTOM_AND_RIGHT := 10
    static U_INPC_TOP_AND_LEFT := 11
    static U_INPC_TOP_AND_LEFT_AND_RIGHT := 12
    static U_INPC_TOP_AND_RIGHT := 13
    static U_INPC_VISUAL_ORDER_LEFT := 14
    static U_INPC_TOP_AND_BOTTOM_AND_LEFT := 15
}
struct UIndicSyllabicCategory extends Int32 {
    static U_INSC_OTHER := 0
    static U_INSC_AVAGRAHA := 1
    static U_INSC_BINDU := 2
    static U_INSC_BRAHMI_JOINING_NUMBER := 3
    static U_INSC_CANTILLATION_MARK := 4
    static U_INSC_CONSONANT := 5
    static U_INSC_CONSONANT_DEAD := 6
    static U_INSC_CONSONANT_FINAL := 7
    static U_INSC_CONSONANT_HEAD_LETTER := 8
    static U_INSC_CONSONANT_INITIAL_POSTFIXED := 9
    static U_INSC_CONSONANT_KILLER := 10
    static U_INSC_CONSONANT_MEDIAL := 11
    static U_INSC_CONSONANT_PLACEHOLDER := 12
    static U_INSC_CONSONANT_PRECEDING_REPHA := 13
    static U_INSC_CONSONANT_PREFIXED := 14
    static U_INSC_CONSONANT_SUBJOINED := 15
    static U_INSC_CONSONANT_SUCCEEDING_REPHA := 16
    static U_INSC_CONSONANT_WITH_STACKER := 17
    static U_INSC_GEMINATION_MARK := 18
    static U_INSC_INVISIBLE_STACKER := 19
    static U_INSC_JOINER := 20
    static U_INSC_MODIFYING_LETTER := 21
    static U_INSC_NON_JOINER := 22
    static U_INSC_NUKTA := 23
    static U_INSC_NUMBER := 24
    static U_INSC_NUMBER_JOINER := 25
    static U_INSC_PURE_KILLER := 26
    static U_INSC_REGISTER_SHIFTER := 27
    static U_INSC_SYLLABLE_MODIFIER := 28
    static U_INSC_TONE_LETTER := 29
    static U_INSC_TONE_MARK := 30
    static U_INSC_VIRAMA := 31
    static U_INSC_VISARGA := 32
    static U_INSC_VOWEL := 33
    static U_INSC_VOWEL_DEPENDENT := 34
    static U_INSC_VOWEL_INDEPENDENT := 35
}
struct UVerticalOrientation extends Int32 {
    static U_VO_ROTATED := 0
    static U_VO_TRANSFORMED_ROTATED := 1
    static U_VO_TRANSFORMED_UPRIGHT := 2
    static U_VO_UPRIGHT := 3
}
struct UCharEnumTypeRange extends FunctionPointer {
    static Types := [Struct.Ptr, Int32, Int32, UCharCategory, Int8]
    static Options := "C"
}
struct UEnumCharNamesFn extends FunctionPointer {
    static Types := [Struct.Ptr, Int32, UCharNameChoice, PSTR, Int32, Int8]
    static Options := "C"
}
struct UBiDiDirection extends Int32 {
    static UBIDI_LTR := 0
    static UBIDI_RTL := 1
    static UBIDI_MIXED := 2
    static UBIDI_NEUTRAL := 3
}
struct UBiDiReorderingMode extends Int32 {
    static UBIDI_REORDER_DEFAULT := 0
    static UBIDI_REORDER_NUMBERS_SPECIAL := 1
    static UBIDI_REORDER_GROUP_NUMBERS_WITH_R := 2
    static UBIDI_REORDER_RUNS_ONLY := 3
    static UBIDI_REORDER_INVERSE_NUMBERS_AS_L := 4
    static UBIDI_REORDER_INVERSE_LIKE_DIRECT := 5
    static UBIDI_REORDER_INVERSE_FOR_NUMBERS_SPECIAL := 6
}
struct UBiDiReorderingOption extends Int32 {
    static UBIDI_OPTION_DEFAULT := 0
    static UBIDI_OPTION_INSERT_MARKS := 1
    static UBIDI_OPTION_REMOVE_CONTROLS := 2
    static UBIDI_OPTION_STREAMING := 4
}
struct UBiDiClassCallback extends FunctionPointer {
    static Types := [Struct.Ptr, Int32, UCharDirection]
    static Options := "C"
}
struct UBiDiOrder extends Int32 {
    static UBIDI_LOGICAL := 0
    static UBIDI_VISUAL := 1
}
struct UBiDiMirroring extends Int32 {
    static UBIDI_MIRRORING_OFF := 0
    static UBIDI_MIRRORING_ON := 1
}
struct UTextClone extends FunctionPointer {
    static Types := [UText.Ptr, UText.Ptr, Int8, UErrorCode.Ptr, UText.Ptr]
    static Options := "C"
}
struct UTextNativeLength extends FunctionPointer {
    static Types := [UText.Ptr, Int64]
    static Options := "C"
}
struct UTextAccess extends FunctionPointer {
    static Types := [UText.Ptr, Int64, Int8, Int8]
    static Options := "C"
}
struct UTextExtract extends FunctionPointer {
    static Types := [UText.Ptr, Int64, Int64, UInt16.Ptr, Int32, UErrorCode.Ptr, Int32]
    static Options := "C"
}
struct UTextReplace extends FunctionPointer {
    static Types := [UText.Ptr, Int64, Int64, UInt16.Ptr, Int32, UErrorCode.Ptr, Int32]
    static Options := "C"
}
struct UTextCopy extends FunctionPointer {
    static Types := [UText.Ptr, Int64, Int64, Int64, Int8, UErrorCode.Ptr, "Void"]
    static Options := "C"
}
struct UTextMapOffsetToNative extends FunctionPointer {
    static Types := [UText.Ptr, Int64]
    static Options := "C"
}
struct UTextMapNativeIndexToUTF16 extends FunctionPointer {
    static Types := [UText.Ptr, Int64, Int32]
    static Options := "C"
}
struct UTextClose extends FunctionPointer {
    static Types := [UText.Ptr, "Void"]
    static Options := "C"
}
struct UTextFuncs {
    tableSize : Int32
    reserved1 : Int32
    reserved2 : Int32
    reserved3 : Int32
    clone : UTextClone
    nativeLength : UTextNativeLength
    access : UTextAccess
    extract : UTextExtract
    replace : UTextReplace
    copy : UTextCopy
    mapOffsetToNative : UTextMapOffsetToNative
    mapNativeIndexToUTF16 : UTextMapNativeIndexToUTF16
    close : UTextClose
    spare1 : UTextClose
    spare2 : UTextClose
    spare3 : UTextClose
}
struct UText {
    magic : UInt32
    flags : Int32
    providerProperties : Int32
    sizeOfStruct : Int32
    chunkNativeLimit : Int64
    extraSize : Int32
    nativeIndexingLimit : Int32
    chunkNativeStart : Int64
    chunkOffset : Int32
    chunkLength : Int32
    chunkContents : UInt16.Ptr
    pFuncs : UTextFuncs.Ptr
    pExtra : Struct.Ptr
    context : Struct.Ptr
    p : Struct.Ptr
    q : Struct.Ptr
    r : Struct.Ptr
    privP : Struct.Ptr
    a : Int64
    b : Int32
    c : Int32
    privA : Int64
    privB : Int32
    privC : Int32
}
struct USetSpanCondition extends Int32 {
    static USET_SPAN_NOT_CONTAINED := 0
    static USET_SPAN_CONTAINED := 1
    static USET_SPAN_SIMPLE := 2
}
struct USerializedSet {
    array : UInt16.Ptr
    bmpLength : Int32
    length : Int32
    staticArray : UInt16[8]
}
struct UNormalization2Mode extends Int32 {
    static UNORM2_COMPOSE := 0
    static UNORM2_DECOMPOSE := 1
    static UNORM2_FCD := 2
    static UNORM2_COMPOSE_CONTIGUOUS := 3
}
struct UNormalizationCheckResult extends Int32 {
    static UNORM_NO := 0
    static UNORM_YES := 1
    static UNORM_MAYBE := 2
}
struct UNormalizationMode extends Int32 {
    static UNORM_NONE := 1
    static UNORM_NFD := 2
    static UNORM_NFKD := 3
    static UNORM_NFC := 4
    static UNORM_DEFAULT := 4
    static UNORM_NFKC := 5
    static UNORM_FCD := 6
    static UNORM_MODE_COUNT := 7
}
struct UNESCAPE_CHAR_AT extends FunctionPointer {
    static Types := [Int32, Struct.Ptr, UInt16]
    static Options := "C"
}
struct UParseError {
    line : Int32
    offset : Int32
    preContext : UInt16[16]
    postContext : UInt16[16]
}
struct UStringPrepProfileType extends Int32 {
    static USPREP_RFC3491_NAMEPREP := 0
    static USPREP_RFC3530_NFS4_CS_PREP := 1
    static USPREP_RFC3530_NFS4_CS_PREP_CI := 2
    static USPREP_RFC3530_NFS4_CIS_PREP := 3
    static USPREP_RFC3530_NFS4_MIXED_PREP_PREFIX := 4
    static USPREP_RFC3530_NFS4_MIXED_PREP_SUFFIX := 5
    static USPREP_RFC3722_ISCSI := 6
    static USPREP_RFC3920_NODEPREP := 7
    static USPREP_RFC3920_RESOURCEPREP := 8
    static USPREP_RFC4011_MIB := 9
    static USPREP_RFC4013_SASLPREP := 10
    static USPREP_RFC4505_TRACE := 11
    static USPREP_RFC4518_LDAP := 12
    static USPREP_RFC4518_LDAP_CI := 13
}
struct UIDNAInfo {
    size : Int16
    isTransitionalDifferent : Int8
    reservedB3 : Int8
    errors : UInt32
    reservedI2 : Int32
    reservedI3 : Int32
}
struct UBreakIteratorType extends Int32 {
    static UBRK_CHARACTER := 0
    static UBRK_WORD := 1
    static UBRK_LINE := 2
    static UBRK_SENTENCE := 3
}
struct UWordBreak extends Int32 {
    static UBRK_WORD_NONE := 0
    static UBRK_WORD_NONE_LIMIT := 100
    static UBRK_WORD_NUMBER := 100
    static UBRK_WORD_NUMBER_LIMIT := 200
    static UBRK_WORD_LETTER := 200
    static UBRK_WORD_LETTER_LIMIT := 300
    static UBRK_WORD_KANA := 300
    static UBRK_WORD_KANA_LIMIT := 400
    static UBRK_WORD_IDEO := 400
    static UBRK_WORD_IDEO_LIMIT := 500
}
struct ULineBreakTag extends Int32 {
    static UBRK_LINE_SOFT := 0
    static UBRK_LINE_SOFT_LIMIT := 100
    static UBRK_LINE_HARD := 100
    static UBRK_LINE_HARD_LIMIT := 200
}
struct USentenceBreakTag extends Int32 {
    static UBRK_SENTENCE_TERM := 0
    static UBRK_SENTENCE_TERM_LIMIT := 100
    static UBRK_SENTENCE_SEP := 100
    static UBRK_SENTENCE_SEP_LIMIT := 200
}
struct UCalendarType extends Int32 {
    static UCAL_TRADITIONAL := 0
    static UCAL_DEFAULT := 0
    static UCAL_GREGORIAN := 1
}
struct UCalendarDateFields extends Int32 {
    static UCAL_ERA := 0
    static UCAL_YEAR := 1
    static UCAL_MONTH := 2
    static UCAL_WEEK_OF_YEAR := 3
    static UCAL_WEEK_OF_MONTH := 4
    static UCAL_DATE := 5
    static UCAL_DAY_OF_YEAR := 6
    static UCAL_DAY_OF_WEEK := 7
    static UCAL_DAY_OF_WEEK_IN_MONTH := 8
    static UCAL_AM_PM := 9
    static UCAL_HOUR := 10
    static UCAL_HOUR_OF_DAY := 11
    static UCAL_MINUTE := 12
    static UCAL_SECOND := 13
    static UCAL_MILLISECOND := 14
    static UCAL_ZONE_OFFSET := 15
    static UCAL_DST_OFFSET := 16
    static UCAL_YEAR_WOY := 17
    static UCAL_DOW_LOCAL := 18
    static UCAL_EXTENDED_YEAR := 19
    static UCAL_JULIAN_DAY := 20
    static UCAL_MILLISECONDS_IN_DAY := 21
    static UCAL_IS_LEAP_MONTH := 22
    static UCAL_FIELD_COUNT := 23
    static UCAL_DAY_OF_MONTH := 5
}
struct UCalendarDaysOfWeek extends Int32 {
    static UCAL_SUNDAY := 1
    static UCAL_MONDAY := 2
    static UCAL_TUESDAY := 3
    static UCAL_WEDNESDAY := 4
    static UCAL_THURSDAY := 5
    static UCAL_FRIDAY := 6
    static UCAL_SATURDAY := 7
}
struct UCalendarMonths extends Int32 {
    static UCAL_JANUARY := 0
    static UCAL_FEBRUARY := 1
    static UCAL_MARCH := 2
    static UCAL_APRIL := 3
    static UCAL_MAY := 4
    static UCAL_JUNE := 5
    static UCAL_JULY := 6
    static UCAL_AUGUST := 7
    static UCAL_SEPTEMBER := 8
    static UCAL_OCTOBER := 9
    static UCAL_NOVEMBER := 10
    static UCAL_DECEMBER := 11
    static UCAL_UNDECIMBER := 12
}
struct UCalendarAMPMs extends Int32 {
    static UCAL_AM := 0
    static UCAL_PM := 1
}
struct USystemTimeZoneType extends Int32 {
    static UCAL_ZONE_TYPE_ANY := 0
    static UCAL_ZONE_TYPE_CANONICAL := 1
    static UCAL_ZONE_TYPE_CANONICAL_LOCATION := 2
}
struct UCalendarDisplayNameType extends Int32 {
    static UCAL_STANDARD := 0
    static UCAL_SHORT_STANDARD := 1
    static UCAL_DST := 2
    static UCAL_SHORT_DST := 3
}
struct UCalendarAttribute extends Int32 {
    static UCAL_LENIENT := 0
    static UCAL_FIRST_DAY_OF_WEEK := 1
    static UCAL_MINIMAL_DAYS_IN_FIRST_WEEK := 2
    static UCAL_REPEATED_WALL_TIME := 3
    static UCAL_SKIPPED_WALL_TIME := 4
}
struct UCalendarWallTimeOption extends Int32 {
    static UCAL_WALLTIME_LAST := 0
    static UCAL_WALLTIME_FIRST := 1
    static UCAL_WALLTIME_NEXT_VALID := 2
}
struct UCalendarLimitType extends Int32 {
    static UCAL_MINIMUM := 0
    static UCAL_MAXIMUM := 1
    static UCAL_GREATEST_MINIMUM := 2
    static UCAL_LEAST_MAXIMUM := 3
    static UCAL_ACTUAL_MINIMUM := 4
    static UCAL_ACTUAL_MAXIMUM := 5
}
struct UCalendarWeekdayType extends Int32 {
    static UCAL_WEEKDAY := 0
    static UCAL_WEEKEND := 1
    static UCAL_WEEKEND_ONSET := 2
    static UCAL_WEEKEND_CEASE := 3
}
struct UTimeZoneTransitionType extends Int32 {
    static UCAL_TZ_TRANSITION_NEXT := 0
    static UCAL_TZ_TRANSITION_NEXT_INCLUSIVE := 1
    static UCAL_TZ_TRANSITION_PREVIOUS := 2
    static UCAL_TZ_TRANSITION_PREVIOUS_INCLUSIVE := 3
}
struct UTimeZoneLocalOption extends Int32 {
    static UCAL_TZ_LOCAL_FORMER := 4
    static UCAL_TZ_LOCAL_LATTER := 12
    static UCAL_TZ_LOCAL_STANDARD_FORMER := 5
    static UCAL_TZ_LOCAL_STANDARD_LATTER := 13
    static UCAL_TZ_LOCAL_DAYLIGHT_FORMER := 7
    static UCAL_TZ_LOCAL_DAYLIGHT_LATTER := 15
}
struct UCollationResult extends Int32 {
    static UCOL_EQUAL := 0
    static UCOL_GREATER := 1
    static UCOL_LESS := -1
}
struct UColAttributeValue extends Int32 {
    static UCOL_DEFAULT := -1
    static UCOL_PRIMARY := 0
    static UCOL_SECONDARY := 1
    static UCOL_TERTIARY := 2
    static UCOL_DEFAULT_STRENGTH := 2
    static UCOL_CE_STRENGTH_LIMIT := 3
    static UCOL_QUATERNARY := 3
    static UCOL_IDENTICAL := 15
    static UCOL_STRENGTH_LIMIT := 16
    static UCOL_OFF := 16
    static UCOL_ON := 17
    static UCOL_SHIFTED := 20
    static UCOL_NON_IGNORABLE := 21
    static UCOL_LOWER_FIRST := 24
    static UCOL_UPPER_FIRST := 25
}
struct UColReorderCode extends Int32 {
    static UCOL_REORDER_CODE_DEFAULT := -1
    static UCOL_REORDER_CODE_NONE := 103
    static UCOL_REORDER_CODE_OTHERS := 103
    static UCOL_REORDER_CODE_SPACE := 4096
    static UCOL_REORDER_CODE_FIRST := 4096
    static UCOL_REORDER_CODE_PUNCTUATION := 4097
    static UCOL_REORDER_CODE_SYMBOL := 4098
    static UCOL_REORDER_CODE_CURRENCY := 4099
    static UCOL_REORDER_CODE_DIGIT := 4100
}
struct UColAttribute extends Int32 {
    static UCOL_FRENCH_COLLATION := 0
    static UCOL_ALTERNATE_HANDLING := 1
    static UCOL_CASE_FIRST := 2
    static UCOL_CASE_LEVEL := 3
    static UCOL_NORMALIZATION_MODE := 4
    static UCOL_DECOMPOSITION_MODE := 4
    static UCOL_STRENGTH := 5
    static UCOL_NUMERIC_COLLATION := 7
    static UCOL_ATTRIBUTE_COUNT := 8
}
struct UColRuleOption extends Int32 {
    static UCOL_TAILORING_ONLY := 0
    static UCOL_FULL_RULES := 1
}
struct UColBoundMode extends Int32 {
    static UCOL_BOUND_LOWER := 0
    static UCOL_BOUND_UPPER := 1
    static UCOL_BOUND_UPPER_LONG := 2
}
struct UFormattableType extends Int32 {
    static UFMT_DATE := 0
    static UFMT_DOUBLE := 1
    static UFMT_LONG := 2
    static UFMT_STRING := 3
    static UFMT_ARRAY := 4
    static UFMT_INT64 := 5
    static UFMT_OBJECT := 6
}
struct UFieldCategory extends Int32 {
    static UFIELD_CATEGORY_UNDEFINED := 0
    static UFIELD_CATEGORY_DATE := 1
    static UFIELD_CATEGORY_NUMBER := 2
    static UFIELD_CATEGORY_LIST := 3
    static UFIELD_CATEGORY_RELATIVE_DATETIME := 4
    static UFIELD_CATEGORY_DATE_INTERVAL := 5
    static UFIELD_CATEGORY_LIST_SPAN := 4099
    static UFIELD_CATEGORY_DATE_INTERVAL_SPAN := 4101
    static UFIELD_CATEGORY_NUMBER_RANGE_SPAN := 4098
}
struct UGender extends Int32 {
    static UGENDER_MALE := 0
    static UGENDER_FEMALE := 1
    static UGENDER_OTHER := 2
}
struct UListFormatterField extends Int32 {
    static ULISTFMT_LITERAL_FIELD := 0
    static ULISTFMT_ELEMENT_FIELD := 1
}
struct UListFormatterType extends Int32 {
    static ULISTFMT_TYPE_AND := 0
    static ULISTFMT_TYPE_OR := 1
    static ULISTFMT_TYPE_UNITS := 2
}
struct UListFormatterWidth extends Int32 {
    static ULISTFMT_WIDTH_WIDE := 0
    static ULISTFMT_WIDTH_SHORT := 1
    static ULISTFMT_WIDTH_NARROW := 2
}
struct ULocaleDataExemplarSetType extends Int32 {
    static ULOCDATA_ES_STANDARD := 0
    static ULOCDATA_ES_AUXILIARY := 1
    static ULOCDATA_ES_INDEX := 2
    static ULOCDATA_ES_PUNCTUATION := 3
}
struct ULocaleDataDelimiterType extends Int32 {
    static ULOCDATA_QUOTATION_START := 0
    static ULOCDATA_QUOTATION_END := 1
    static ULOCDATA_ALT_QUOTATION_START := 2
    static ULOCDATA_ALT_QUOTATION_END := 3
}
struct UMeasurementSystem extends Int32 {
    static UMS_SI := 0
    static UMS_US := 1
    static UMS_UK := 2
}
struct UNumberFormatStyle extends Int32 {
    static UNUM_PATTERN_DECIMAL := 0
    static UNUM_DECIMAL := 1
    static UNUM_CURRENCY := 2
    static UNUM_PERCENT := 3
    static UNUM_SCIENTIFIC := 4
    static UNUM_SPELLOUT := 5
    static UNUM_ORDINAL := 6
    static UNUM_DURATION := 7
    static UNUM_NUMBERING_SYSTEM := 8
    static UNUM_PATTERN_RULEBASED := 9
    static UNUM_CURRENCY_ISO := 10
    static UNUM_CURRENCY_PLURAL := 11
    static UNUM_CURRENCY_ACCOUNTING := 12
    static UNUM_CASH_CURRENCY := 13
    static UNUM_DECIMAL_COMPACT_SHORT := 14
    static UNUM_DECIMAL_COMPACT_LONG := 15
    static UNUM_CURRENCY_STANDARD := 16
    static UNUM_DEFAULT := 1
    static UNUM_IGNORE := 0
}
struct UNumberFormatRoundingMode extends Int32 {
    static UNUM_ROUND_CEILING := 0
    static UNUM_ROUND_FLOOR := 1
    static UNUM_ROUND_DOWN := 2
    static UNUM_ROUND_UP := 3
    static UNUM_ROUND_HALFEVEN := 4
    static UNUM_ROUND_HALFDOWN := 5
    static UNUM_ROUND_HALFUP := 6
    static UNUM_ROUND_UNNECESSARY := 7
    static UNUM_ROUND_HALF_ODD := 8
    static UNUM_ROUND_HALF_CEILING := 9
    static UNUM_ROUND_HALF_FLOOR := 10
}
struct UNumberFormatPadPosition extends Int32 {
    static UNUM_PAD_BEFORE_PREFIX := 0
    static UNUM_PAD_AFTER_PREFIX := 1
    static UNUM_PAD_BEFORE_SUFFIX := 2
    static UNUM_PAD_AFTER_SUFFIX := 3
}
struct UNumberCompactStyle extends Int32 {
    static UNUM_SHORT := 0
    static UNUM_LONG := 1
}
struct UCurrencySpacing extends Int32 {
    static UNUM_CURRENCY_MATCH := 0
    static UNUM_CURRENCY_SURROUNDING_MATCH := 1
    static UNUM_CURRENCY_INSERT := 2
    static UNUM_CURRENCY_SPACING_COUNT := 3
}
struct UNumberFormatFields extends Int32 {
    static UNUM_INTEGER_FIELD := 0
    static UNUM_FRACTION_FIELD := 1
    static UNUM_DECIMAL_SEPARATOR_FIELD := 2
    static UNUM_EXPONENT_SYMBOL_FIELD := 3
    static UNUM_EXPONENT_SIGN_FIELD := 4
    static UNUM_EXPONENT_FIELD := 5
    static UNUM_GROUPING_SEPARATOR_FIELD := 6
    static UNUM_CURRENCY_FIELD := 7
    static UNUM_PERCENT_FIELD := 8
    static UNUM_PERMILL_FIELD := 9
    static UNUM_SIGN_FIELD := 10
    static UNUM_MEASURE_UNIT_FIELD := 11
    static UNUM_COMPACT_FIELD := 12
}
struct UNumberFormatMinimumGroupingDigits extends Int32 {
    static UNUM_MINIMUM_GROUPING_DIGITS_AUTO := -2
    static UNUM_MINIMUM_GROUPING_DIGITS_MIN2 := -3
}
struct UNumberFormatAttributeValue extends Int32 {
    static UNUM_FORMAT_ATTRIBUTE_VALUE_HIDDEN := 0
}
struct UNumberFormatAttribute extends Int32 {
    static UNUM_PARSE_INT_ONLY := 0
    static UNUM_GROUPING_USED := 1
    static UNUM_DECIMAL_ALWAYS_SHOWN := 2
    static UNUM_MAX_INTEGER_DIGITS := 3
    static UNUM_MIN_INTEGER_DIGITS := 4
    static UNUM_INTEGER_DIGITS := 5
    static UNUM_MAX_FRACTION_DIGITS := 6
    static UNUM_MIN_FRACTION_DIGITS := 7
    static UNUM_FRACTION_DIGITS := 8
    static UNUM_MULTIPLIER := 9
    static UNUM_GROUPING_SIZE := 10
    static UNUM_ROUNDING_MODE := 11
    static UNUM_ROUNDING_INCREMENT := 12
    static UNUM_FORMAT_WIDTH := 13
    static UNUM_PADDING_POSITION := 14
    static UNUM_SECONDARY_GROUPING_SIZE := 15
    static UNUM_SIGNIFICANT_DIGITS_USED := 16
    static UNUM_MIN_SIGNIFICANT_DIGITS := 17
    static UNUM_MAX_SIGNIFICANT_DIGITS := 18
    static UNUM_LENIENT_PARSE := 19
    static UNUM_PARSE_ALL_INPUT := 20
    static UNUM_SCALE := 21
    static UNUM_MINIMUM_GROUPING_DIGITS := 22
    static UNUM_CURRENCY_USAGE := 23
    static UNUM_FORMAT_FAIL_IF_MORE_THAN_MAX_DIGITS := 4096
    static UNUM_PARSE_NO_EXPONENT := 4097
    static UNUM_PARSE_DECIMAL_MARK_REQUIRED := 4098
    static UNUM_PARSE_CASE_SENSITIVE := 4099
    static UNUM_SIGN_ALWAYS_SHOWN := 4100
}
struct UNumberFormatTextAttribute extends Int32 {
    static UNUM_POSITIVE_PREFIX := 0
    static UNUM_POSITIVE_SUFFIX := 1
    static UNUM_NEGATIVE_PREFIX := 2
    static UNUM_NEGATIVE_SUFFIX := 3
    static UNUM_PADDING_CHARACTER := 4
    static UNUM_CURRENCY_CODE := 5
    static UNUM_DEFAULT_RULESET := 6
    static UNUM_PUBLIC_RULESETS := 7
}
struct UNumberFormatSymbol extends Int32 {
    static UNUM_DECIMAL_SEPARATOR_SYMBOL := 0
    static UNUM_GROUPING_SEPARATOR_SYMBOL := 1
    static UNUM_PATTERN_SEPARATOR_SYMBOL := 2
    static UNUM_PERCENT_SYMBOL := 3
    static UNUM_ZERO_DIGIT_SYMBOL := 4
    static UNUM_DIGIT_SYMBOL := 5
    static UNUM_MINUS_SIGN_SYMBOL := 6
    static UNUM_PLUS_SIGN_SYMBOL := 7
    static UNUM_CURRENCY_SYMBOL := 8
    static UNUM_INTL_CURRENCY_SYMBOL := 9
    static UNUM_MONETARY_SEPARATOR_SYMBOL := 10
    static UNUM_EXPONENTIAL_SYMBOL := 11
    static UNUM_PERMILL_SYMBOL := 12
    static UNUM_PAD_ESCAPE_SYMBOL := 13
    static UNUM_INFINITY_SYMBOL := 14
    static UNUM_NAN_SYMBOL := 15
    static UNUM_SIGNIFICANT_DIGIT_SYMBOL := 16
    static UNUM_MONETARY_GROUPING_SEPARATOR_SYMBOL := 17
    static UNUM_ONE_DIGIT_SYMBOL := 18
    static UNUM_TWO_DIGIT_SYMBOL := 19
    static UNUM_THREE_DIGIT_SYMBOL := 20
    static UNUM_FOUR_DIGIT_SYMBOL := 21
    static UNUM_FIVE_DIGIT_SYMBOL := 22
    static UNUM_SIX_DIGIT_SYMBOL := 23
    static UNUM_SEVEN_DIGIT_SYMBOL := 24
    static UNUM_EIGHT_DIGIT_SYMBOL := 25
    static UNUM_NINE_DIGIT_SYMBOL := 26
    static UNUM_EXPONENT_MULTIPLICATION_SYMBOL := 27
}
struct UDateFormatStyle extends Int32 {
    static UDAT_FULL := 0
    static UDAT_LONG := 1
    static UDAT_MEDIUM := 2
    static UDAT_SHORT := 3
    static UDAT_DEFAULT := 2
    static UDAT_RELATIVE := 128
    static UDAT_FULL_RELATIVE := 128
    static UDAT_LONG_RELATIVE := 129
    static UDAT_MEDIUM_RELATIVE := 130
    static UDAT_SHORT_RELATIVE := 131
    static UDAT_NONE := -1
    static UDAT_PATTERN := -2
}
struct UDateFormatField extends Int32 {
    static UDAT_ERA_FIELD := 0
    static UDAT_YEAR_FIELD := 1
    static UDAT_MONTH_FIELD := 2
    static UDAT_DATE_FIELD := 3
    static UDAT_HOUR_OF_DAY1_FIELD := 4
    static UDAT_HOUR_OF_DAY0_FIELD := 5
    static UDAT_MINUTE_FIELD := 6
    static UDAT_SECOND_FIELD := 7
    static UDAT_FRACTIONAL_SECOND_FIELD := 8
    static UDAT_DAY_OF_WEEK_FIELD := 9
    static UDAT_DAY_OF_YEAR_FIELD := 10
    static UDAT_DAY_OF_WEEK_IN_MONTH_FIELD := 11
    static UDAT_WEEK_OF_YEAR_FIELD := 12
    static UDAT_WEEK_OF_MONTH_FIELD := 13
    static UDAT_AM_PM_FIELD := 14
    static UDAT_HOUR1_FIELD := 15
    static UDAT_HOUR0_FIELD := 16
    static UDAT_TIMEZONE_FIELD := 17
    static UDAT_YEAR_WOY_FIELD := 18
    static UDAT_DOW_LOCAL_FIELD := 19
    static UDAT_EXTENDED_YEAR_FIELD := 20
    static UDAT_JULIAN_DAY_FIELD := 21
    static UDAT_MILLISECONDS_IN_DAY_FIELD := 22
    static UDAT_TIMEZONE_RFC_FIELD := 23
    static UDAT_TIMEZONE_GENERIC_FIELD := 24
    static UDAT_STANDALONE_DAY_FIELD := 25
    static UDAT_STANDALONE_MONTH_FIELD := 26
    static UDAT_QUARTER_FIELD := 27
    static UDAT_STANDALONE_QUARTER_FIELD := 28
    static UDAT_TIMEZONE_SPECIAL_FIELD := 29
    static UDAT_YEAR_NAME_FIELD := 30
    static UDAT_TIMEZONE_LOCALIZED_GMT_OFFSET_FIELD := 31
    static UDAT_TIMEZONE_ISO_FIELD := 32
    static UDAT_TIMEZONE_ISO_LOCAL_FIELD := 33
    static UDAT_AM_PM_MIDNIGHT_NOON_FIELD := 35
    static UDAT_FLEXIBLE_DAY_PERIOD_FIELD := 36
}
struct UDateFormatBooleanAttribute extends Int32 {
    static UDAT_PARSE_ALLOW_WHITESPACE := 0
    static UDAT_PARSE_ALLOW_NUMERIC := 1
    static UDAT_PARSE_PARTIAL_LITERAL_MATCH := 2
    static UDAT_PARSE_MULTIPLE_PATTERNS_FOR_MATCH := 3
    static UDAT_BOOLEAN_ATTRIBUTE_COUNT := 4
}
struct UDateFormatHourCycle extends Int32 {
    static UDAT_HOUR_CYCLE_11 := 0
    static UDAT_HOUR_CYCLE_12 := 1
    static UDAT_HOUR_CYCLE_23 := 2
    static UDAT_HOUR_CYCLE_24 := 3
}
struct UDateFormatSymbolType extends Int32 {
    static UDAT_ERAS := 0
    static UDAT_MONTHS := 1
    static UDAT_SHORT_MONTHS := 2
    static UDAT_WEEKDAYS := 3
    static UDAT_SHORT_WEEKDAYS := 4
    static UDAT_AM_PMS := 5
    static UDAT_LOCALIZED_CHARS := 6
    static UDAT_ERA_NAMES := 7
    static UDAT_NARROW_MONTHS := 8
    static UDAT_NARROW_WEEKDAYS := 9
    static UDAT_STANDALONE_MONTHS := 10
    static UDAT_STANDALONE_SHORT_MONTHS := 11
    static UDAT_STANDALONE_NARROW_MONTHS := 12
    static UDAT_STANDALONE_WEEKDAYS := 13
    static UDAT_STANDALONE_SHORT_WEEKDAYS := 14
    static UDAT_STANDALONE_NARROW_WEEKDAYS := 15
    static UDAT_QUARTERS := 16
    static UDAT_SHORT_QUARTERS := 17
    static UDAT_STANDALONE_QUARTERS := 18
    static UDAT_STANDALONE_SHORT_QUARTERS := 19
    static UDAT_SHORTER_WEEKDAYS := 20
    static UDAT_STANDALONE_SHORTER_WEEKDAYS := 21
    static UDAT_CYCLIC_YEARS_WIDE := 22
    static UDAT_CYCLIC_YEARS_ABBREVIATED := 23
    static UDAT_CYCLIC_YEARS_NARROW := 24
    static UDAT_ZODIAC_NAMES_WIDE := 25
    static UDAT_ZODIAC_NAMES_ABBREVIATED := 26
    static UDAT_ZODIAC_NAMES_NARROW := 27
    static UDAT_NARROW_QUARTERS := 28
    static UDAT_STANDALONE_NARROW_QUARTERS := 29
}
struct UDateTimePatternField extends Int32 {
    static UDATPG_ERA_FIELD := 0
    static UDATPG_YEAR_FIELD := 1
    static UDATPG_QUARTER_FIELD := 2
    static UDATPG_MONTH_FIELD := 3
    static UDATPG_WEEK_OF_YEAR_FIELD := 4
    static UDATPG_WEEK_OF_MONTH_FIELD := 5
    static UDATPG_WEEKDAY_FIELD := 6
    static UDATPG_DAY_OF_YEAR_FIELD := 7
    static UDATPG_DAY_OF_WEEK_IN_MONTH_FIELD := 8
    static UDATPG_DAY_FIELD := 9
    static UDATPG_DAYPERIOD_FIELD := 10
    static UDATPG_HOUR_FIELD := 11
    static UDATPG_MINUTE_FIELD := 12
    static UDATPG_SECOND_FIELD := 13
    static UDATPG_FRACTIONAL_SECOND_FIELD := 14
    static UDATPG_ZONE_FIELD := 15
    static UDATPG_FIELD_COUNT := 16
}
struct UDateTimePGDisplayWidth extends Int32 {
    static UDATPG_WIDE := 0
    static UDATPG_ABBREVIATED := 1
    static UDATPG_NARROW := 2
}
struct UDateTimePatternMatchOptions extends Int32 {
    static UDATPG_MATCH_NO_OPTIONS := 0
    static UDATPG_MATCH_HOUR_FIELD_LENGTH := 2048
    static UDATPG_MATCH_ALL_FIELDS_LENGTH := 65535
}
struct UDateTimePatternConflict extends Int32 {
    static UDATPG_NO_CONFLICT := 0
    static UDATPG_BASE_CONFLICT := 1
    static UDATPG_CONFLICT := 2
}
struct UNumberUnitWidth extends Int32 {
    static UNUM_UNIT_WIDTH_NARROW := 0
    static UNUM_UNIT_WIDTH_SHORT := 1
    static UNUM_UNIT_WIDTH_FULL_NAME := 2
    static UNUM_UNIT_WIDTH_ISO_CODE := 3
    static UNUM_UNIT_WIDTH_FORMAL := 4
    static UNUM_UNIT_WIDTH_VARIANT := 5
    static UNUM_UNIT_WIDTH_HIDDEN := 6
    static UNUM_UNIT_WIDTH_COUNT := 7
}
struct UNumberGroupingStrategy extends Int32 {
    static UNUM_GROUPING_OFF := 0
    static UNUM_GROUPING_MIN2 := 1
    static UNUM_GROUPING_AUTO := 2
    static UNUM_GROUPING_ON_ALIGNED := 3
    static UNUM_GROUPING_THOUSANDS := 4
}
struct UNumberSignDisplay extends Int32 {
    static UNUM_SIGN_AUTO := 0
    static UNUM_SIGN_ALWAYS := 1
    static UNUM_SIGN_NEVER := 2
    static UNUM_SIGN_ACCOUNTING := 3
    static UNUM_SIGN_ACCOUNTING_ALWAYS := 4
    static UNUM_SIGN_EXCEPT_ZERO := 5
    static UNUM_SIGN_ACCOUNTING_EXCEPT_ZERO := 6
    static UNUM_SIGN_NEGATIVE := 7
    static UNUM_SIGN_ACCOUNTING_NEGATIVE := 8
    static UNUM_SIGN_COUNT := 9
}
struct UNumberDecimalSeparatorDisplay extends Int32 {
    static UNUM_DECIMAL_SEPARATOR_AUTO := 0
    static UNUM_DECIMAL_SEPARATOR_ALWAYS := 1
    static UNUM_DECIMAL_SEPARATOR_COUNT := 2
}
struct UNumberTrailingZeroDisplay extends Int32 {
    static UNUM_TRAILING_ZERO_AUTO := 0
    static UNUM_TRAILING_ZERO_HIDE_IF_WHOLE := 1
}
struct UNumberRangeCollapse extends Int32 {
    static UNUM_RANGE_COLLAPSE_AUTO := 0
    static UNUM_RANGE_COLLAPSE_NONE := 1
    static UNUM_RANGE_COLLAPSE_UNIT := 2
    static UNUM_RANGE_COLLAPSE_ALL := 3
}
struct UNumberRangeIdentityFallback extends Int32 {
    static UNUM_IDENTITY_FALLBACK_SINGLE_VALUE := 0
    static UNUM_IDENTITY_FALLBACK_APPROXIMATELY_OR_SINGLE_VALUE := 1
    static UNUM_IDENTITY_FALLBACK_APPROXIMATELY := 2
    static UNUM_IDENTITY_FALLBACK_RANGE := 3
}
struct UNumberRangeIdentityResult extends Int32 {
    static UNUM_IDENTITY_RESULT_EQUAL_BEFORE_ROUNDING := 0
    static UNUM_IDENTITY_RESULT_EQUAL_AFTER_ROUNDING := 1
    static UNUM_IDENTITY_RESULT_NOT_EQUAL := 2
}
struct UPluralType extends Int32 {
    static UPLURAL_TYPE_CARDINAL := 0
    static UPLURAL_TYPE_ORDINAL := 1
}
struct URegexpFlag extends Int32 {
    static UREGEX_CASE_INSENSITIVE := 2
    static UREGEX_COMMENTS := 4
    static UREGEX_DOTALL := 32
    static UREGEX_LITERAL := 16
    static UREGEX_MULTILINE := 8
    static UREGEX_UNIX_LINES := 1
    static UREGEX_UWORD := 256
    static UREGEX_ERROR_ON_UNKNOWN_ESCAPES := 512
}
struct URegexMatchCallback extends FunctionPointer {
    static Types := [Struct.Ptr, Int32, Int8]
    static Options := "C"
}
struct URegexFindProgressCallback extends FunctionPointer {
    static Types := [Struct.Ptr, Int64, Int8]
    static Options := "C"
}
struct URegionType extends Int32 {
    static URGN_UNKNOWN := 0
    static URGN_TERRITORY := 1
    static URGN_WORLD := 2
    static URGN_CONTINENT := 3
    static URGN_SUBCONTINENT := 4
    static URGN_GROUPING := 5
    static URGN_DEPRECATED := 6
}
struct UDateRelativeDateTimeFormatterStyle extends Int32 {
    static UDAT_STYLE_LONG := 0
    static UDAT_STYLE_SHORT := 1
    static UDAT_STYLE_NARROW := 2
}
struct URelativeDateTimeUnit extends Int32 {
    static UDAT_REL_UNIT_YEAR := 0
    static UDAT_REL_UNIT_QUARTER := 1
    static UDAT_REL_UNIT_MONTH := 2
    static UDAT_REL_UNIT_WEEK := 3
    static UDAT_REL_UNIT_DAY := 4
    static UDAT_REL_UNIT_HOUR := 5
    static UDAT_REL_UNIT_MINUTE := 6
    static UDAT_REL_UNIT_SECOND := 7
    static UDAT_REL_UNIT_SUNDAY := 8
    static UDAT_REL_UNIT_MONDAY := 9
    static UDAT_REL_UNIT_TUESDAY := 10
    static UDAT_REL_UNIT_WEDNESDAY := 11
    static UDAT_REL_UNIT_THURSDAY := 12
    static UDAT_REL_UNIT_FRIDAY := 13
    static UDAT_REL_UNIT_SATURDAY := 14
}
struct URelativeDateTimeFormatterField extends Int32 {
    static UDAT_REL_LITERAL_FIELD := 0
    static UDAT_REL_NUMERIC_FIELD := 1
}
struct USearchAttribute extends Int32 {
    static USEARCH_OVERLAP := 0
    static USEARCH_ELEMENT_COMPARISON := 2
}
struct USearchAttributeValue extends Int32 {
    static USEARCH_DEFAULT := -1
    static USEARCH_OFF := 0
    static USEARCH_ON := 1
    static USEARCH_STANDARD_ELEMENT_COMPARISON := 2
    static USEARCH_PATTERN_BASE_WEIGHT_IS_WILDCARD := 3
    static USEARCH_ANY_BASE_WEIGHT_IS_WILDCARD := 4
}
struct USpoofChecks extends Int32 {
    static USPOOF_SINGLE_SCRIPT_CONFUSABLE := 1
    static USPOOF_MIXED_SCRIPT_CONFUSABLE := 2
    static USPOOF_WHOLE_SCRIPT_CONFUSABLE := 4
    static USPOOF_CONFUSABLE := 7
    static USPOOF_RESTRICTION_LEVEL := 16
    static USPOOF_INVISIBLE := 32
    static USPOOF_CHAR_LIMIT := 64
    static USPOOF_MIXED_NUMBERS := 128
    static USPOOF_HIDDEN_OVERLAY := 256
    static USPOOF_ALL_CHECKS := 65535
    static USPOOF_AUX_INFO := 1073741824
}
struct URestrictionLevel extends Int32 {
    static USPOOF_ASCII := 268435456
    static USPOOF_SINGLE_SCRIPT_RESTRICTIVE := 536870912
    static USPOOF_HIGHLY_RESTRICTIVE := 805306368
    static USPOOF_MODERATELY_RESTRICTIVE := 1073741824
    static USPOOF_MINIMALLY_RESTRICTIVE := 1342177280
    static USPOOF_UNRESTRICTIVE := 1610612736
    static USPOOF_RESTRICTION_LEVEL_MASK := 2130706432
}
struct UDateTimeScale extends Int32 {
    static UDTS_JAVA_TIME := 0
    static UDTS_UNIX_TIME := 1
    static UDTS_ICU4C_TIME := 2
    static UDTS_WINDOWS_FILE_TIME := 3
    static UDTS_DOTNET_DATE_TIME := 4
    static UDTS_MAC_OLD_TIME := 5
    static UDTS_MAC_TIME := 6
    static UDTS_EXCEL_TIME := 7
    static UDTS_DB2_TIME := 8
    static UDTS_UNIX_MICROSECONDS_TIME := 9
}
struct UTimeScaleValue extends Int32 {
    static UTSV_UNITS_VALUE := 0
    static UTSV_EPOCH_OFFSET_VALUE := 1
    static UTSV_FROM_MIN_VALUE := 2
    static UTSV_FROM_MAX_VALUE := 3
    static UTSV_TO_MIN_VALUE := 4
    static UTSV_TO_MAX_VALUE := 5
}
struct UTransDirection extends Int32 {
    static UTRANS_FORWARD := 0
    static UTRANS_REVERSE := 1
}
struct UTransPosition {
    contextStart : Int32
    contextLimit : Int32
    start : Int32
    limit : Int32
}
struct UStringTrieBuildOption extends Int32 {
    static USTRINGTRIE_BUILD_FAST := 0
    static USTRINGTRIE_BUILD_SMALL := 1
}
struct UStringCaseMapper extends FunctionPointer {
    static Types := [UCaseMap.Ptr, UInt16.Ptr, Int32, UInt16.Ptr, Int32, UErrorCode.Ptr, Int32]
    static Options := "C"
}
struct UMessagePatternApostropheMode extends Int32 {
    static UMSGPAT_APOS_DOUBLE_OPTIONAL := 0
    static UMSGPAT_APOS_DOUBLE_REQUIRED := 1
}
struct UMessagePatternPartType extends Int32 {
    static UMSGPAT_PART_TYPE_MSG_START := 0
    static UMSGPAT_PART_TYPE_MSG_LIMIT := 1
    static UMSGPAT_PART_TYPE_SKIP_SYNTAX := 2
    static UMSGPAT_PART_TYPE_INSERT_CHAR := 3
    static UMSGPAT_PART_TYPE_REPLACE_NUMBER := 4
    static UMSGPAT_PART_TYPE_ARG_START := 5
    static UMSGPAT_PART_TYPE_ARG_LIMIT := 6
    static UMSGPAT_PART_TYPE_ARG_NUMBER := 7
    static UMSGPAT_PART_TYPE_ARG_NAME := 8
    static UMSGPAT_PART_TYPE_ARG_TYPE := 9
    static UMSGPAT_PART_TYPE_ARG_STYLE := 10
    static UMSGPAT_PART_TYPE_ARG_SELECTOR := 11
    static UMSGPAT_PART_TYPE_ARG_INT := 12
    static UMSGPAT_PART_TYPE_ARG_DOUBLE := 13
}
struct UMessagePatternArgType extends Int32 {
    static UMSGPAT_ARG_TYPE_NONE := 0
    static UMSGPAT_ARG_TYPE_SIMPLE := 1
    static UMSGPAT_ARG_TYPE_CHOICE := 2
    static UMSGPAT_ARG_TYPE_PLURAL := 3
    static UMSGPAT_ARG_TYPE_SELECT := 4
    static UMSGPAT_ARG_TYPE_SELECTORDINAL := 5
}
struct UAlphabeticIndexLabelType extends Int32 {
    static U_ALPHAINDEX_NORMAL := 0
    static U_ALPHAINDEX_UNDERFLOW := 1
    static U_ALPHAINDEX_INFLOW := 2
    static U_ALPHAINDEX_OVERFLOW := 3
}
struct UTimeZoneNameType extends Int32 {
    static UTZNM_UNKNOWN := 0
    static UTZNM_LONG_GENERIC := 1
    static UTZNM_LONG_STANDARD := 2
    static UTZNM_LONG_DAYLIGHT := 4
    static UTZNM_SHORT_GENERIC := 8
    static UTZNM_SHORT_STANDARD := 16
    static UTZNM_SHORT_DAYLIGHT := 32
    static UTZNM_EXEMPLAR_LOCATION := 64
}
struct UTimeZoneFormatStyle extends Int32 {
    static UTZFMT_STYLE_GENERIC_LOCATION := 0
    static UTZFMT_STYLE_GENERIC_LONG := 1
    static UTZFMT_STYLE_GENERIC_SHORT := 2
    static UTZFMT_STYLE_SPECIFIC_LONG := 3
    static UTZFMT_STYLE_SPECIFIC_SHORT := 4
    static UTZFMT_STYLE_LOCALIZED_GMT := 5
    static UTZFMT_STYLE_LOCALIZED_GMT_SHORT := 6
    static UTZFMT_STYLE_ISO_BASIC_SHORT := 7
    static UTZFMT_STYLE_ISO_BASIC_LOCAL_SHORT := 8
    static UTZFMT_STYLE_ISO_BASIC_FIXED := 9
    static UTZFMT_STYLE_ISO_BASIC_LOCAL_FIXED := 10
    static UTZFMT_STYLE_ISO_BASIC_FULL := 11
    static UTZFMT_STYLE_ISO_BASIC_LOCAL_FULL := 12
    static UTZFMT_STYLE_ISO_EXTENDED_FIXED := 13
    static UTZFMT_STYLE_ISO_EXTENDED_LOCAL_FIXED := 14
    static UTZFMT_STYLE_ISO_EXTENDED_FULL := 15
    static UTZFMT_STYLE_ISO_EXTENDED_LOCAL_FULL := 16
    static UTZFMT_STYLE_ZONE_ID := 17
    static UTZFMT_STYLE_ZONE_ID_SHORT := 18
    static UTZFMT_STYLE_EXEMPLAR_LOCATION := 19
}
struct UTimeZoneFormatGMTOffsetPatternType extends Int32 {
    static UTZFMT_PAT_POSITIVE_HM := 0
    static UTZFMT_PAT_POSITIVE_HMS := 1
    static UTZFMT_PAT_NEGATIVE_HM := 2
    static UTZFMT_PAT_NEGATIVE_HMS := 3
    static UTZFMT_PAT_POSITIVE_H := 4
    static UTZFMT_PAT_NEGATIVE_H := 5
    static UTZFMT_PAT_COUNT := 6
}
struct UTimeZoneFormatTimeType extends Int32 {
    static UTZFMT_TIME_TYPE_UNKNOWN := 0
    static UTZFMT_TIME_TYPE_STANDARD := 1
    static UTZFMT_TIME_TYPE_DAYLIGHT := 2
}
struct UTimeZoneFormatParseOption extends Int32 {
    static UTZFMT_PARSE_OPTION_NONE := 0
    static UTZFMT_PARSE_OPTION_ALL_STYLES := 1
    static UTZFMT_PARSE_OPTION_TZ_DATABASE_ABBREVIATIONS := 2
}
struct UMeasureFormatWidth extends Int32 {
    static UMEASFMT_WIDTH_WIDE := 0
    static UMEASFMT_WIDTH_SHORT := 1
    static UMEASFMT_WIDTH_NARROW := 2
    static UMEASFMT_WIDTH_NUMERIC := 3
    static UMEASFMT_WIDTH_COUNT := 4
}
struct UDateRelativeUnit extends Int32 {
    static UDAT_RELATIVE_SECONDS := 0
    static UDAT_RELATIVE_MINUTES := 1
    static UDAT_RELATIVE_HOURS := 2
    static UDAT_RELATIVE_DAYS := 3
    static UDAT_RELATIVE_WEEKS := 4
    static UDAT_RELATIVE_MONTHS := 5
    static UDAT_RELATIVE_YEARS := 6
    static UDAT_RELATIVE_UNIT_COUNT := 7
}
struct UDateAbsoluteUnit extends Int32 {
    static UDAT_ABSOLUTE_SUNDAY := 0
    static UDAT_ABSOLUTE_MONDAY := 1
    static UDAT_ABSOLUTE_TUESDAY := 2
    static UDAT_ABSOLUTE_WEDNESDAY := 3
    static UDAT_ABSOLUTE_THURSDAY := 4
    static UDAT_ABSOLUTE_FRIDAY := 5
    static UDAT_ABSOLUTE_SATURDAY := 6
    static UDAT_ABSOLUTE_DAY := 7
    static UDAT_ABSOLUTE_WEEK := 8
    static UDAT_ABSOLUTE_MONTH := 9
    static UDAT_ABSOLUTE_YEAR := 10
    static UDAT_ABSOLUTE_NOW := 11
    static UDAT_ABSOLUTE_UNIT_COUNT := 12
}
struct UDateDirection extends Int32 {
    static UDAT_DIRECTION_LAST_2 := 0
    static UDAT_DIRECTION_LAST := 1
    static UDAT_DIRECTION_THIS := 2
    static UDAT_DIRECTION_NEXT := 3
    static UDAT_DIRECTION_NEXT_2 := 4
    static UDAT_DIRECTION_PLAIN := 5
    static UDAT_DIRECTION_COUNT := 6
}
struct IMLangStringBufW extends IUnknown {
    static IID := "{D24ACD21-BA72-11D0-B188-00AA0038C969}"
    GetStatus(plFlags?, pcchBuf?)
      => ComCall(3, this.p, Int32.Ptr, plFlags?, Int32.Ptr, pcchBuf?)
    LockBuf(cchOffset, cchMaxLock, ppszBuf, pcchBuf?)
      => ComCall(4, this.p, Int32, cchOffset, Int32, cchMaxLock, UInt16.Ptr.Ptr, ppszBuf, Int32.Ptr, pcchBuf?)
    UnlockBuf(pszBuf, cchOffset, cchWrite)
      => ComCall(5, this.p, "Str", pszBuf, Int32, cchOffset, Int32, cchWrite)
    Insert(cchOffset, cchMaxInsert, pcchActual?)
      => ComCall(6, this.p, Int32, cchOffset, Int32, cchMaxInsert, Int32.Ptr, pcchActual?)
    Delete(cchOffset, cchDelete)
      => ComCall(7, this.p, Int32, cchOffset, Int32, cchDelete)
}
struct IMLangStringBufA extends IUnknown {
    static IID := "{D24ACD23-BA72-11D0-B188-00AA0038C969}"
    GetStatus(plFlags?, pcchBuf?)
      => ComCall(3, this.p, Int32.Ptr, plFlags?, Int32.Ptr, pcchBuf?)
    LockBuf(cchOffset, cchMaxLock, ppszBuf, pcchBuf?)
      => ComCall(4, this.p, Int32, cchOffset, Int32, cchMaxLock, CHAR.Ptr.Ptr, ppszBuf, Int32.Ptr, pcchBuf?)
    UnlockBuf(pszBuf, cchOffset, cchWrite)
      => ComCall(5, this.p, PSTR, pszBuf, Int32, cchOffset, Int32, cchWrite)
    Insert(cchOffset, cchMaxInsert, pcchActual?)
      => ComCall(6, this.p, Int32, cchOffset, Int32, cchMaxInsert, Int32.Ptr, pcchActual?)
    Delete(cchOffset, cchDelete)
      => ComCall(7, this.p, Int32, cchOffset, Int32, cchDelete)
}
struct IMLangString extends IUnknown {
    static IID := "{C04D65CE-B70D-11D0-B188-00AA0038C969}"
    Sync(fNoAccess)
      => ComCall(3, this.p, BOOL, fNoAccess)
    GetLength(plLen?)
      => ComCall(4, this.p, Int32.Ptr, plLen?)
    SetMLStr(lDestPos, lDestLen, pSrcMLStr, lSrcPos, lSrcLen)
      => ComCall(5, this.p, Int32, lDestPos, Int32, lDestLen, IUnknown, pSrcMLStr, Int32, lSrcPos, Int32, lSrcLen)
    GetMLStr(lSrcPos, lSrcLen, pUnkOuter, dwClsContext, piid, ppDestMLStr, plDestPos?, plDestLen?)
      => ComCall(6, this.p, Int32, lSrcPos, Int32, lSrcLen, IUnknown, pUnkOuter, UInt32, dwClsContext, GUID.Ptr, piid, IUnknown.Ptr, ppDestMLStr, Int32.Ptr, plDestPos?, Int32.Ptr, plDestLen?)
}
struct IMLangStringWStr extends IMLangString {
    static IID := "{C04D65D0-B70D-11D0-B188-00AA0038C969}"
    SetWStr(lDestPos, lDestLen, pszSrc, pcchActual?, plActualLen?)
      => ComCall(7, this.p, Int32, lDestPos, Int32, lDestLen, "Str", pszSrc, Int32, pszSrc.Length, Int32.Ptr, pcchActual?, Int32.Ptr, plActualLen?)
    SetStrBufW(lDestPos, lDestLen, pSrcBuf?, pcchActual?, plActualLen?)
      => ComCall(8, this.p, Int32, lDestPos, Int32, lDestLen, IMLangStringBufW, pSrcBuf?, Int32.Ptr, pcchActual?, Int32.Ptr, plActualLen?)
    GetWStr(lSrcPos, lSrcLen, pszDest?, pcchActual?, plActualLen?)
      => ComCall(9, this.p, Int32, lSrcPos, Int32, lSrcLen, PWSTR, pszDest?, Int32, pszDest?.Length ?? 0, Int32.Ptr, pcchActual?, Int32.Ptr, plActualLen?)
    GetStrBufW(lSrcPos, lSrcMaxLen, ppDestBuf, plDestLen?)
      => ComCall(10, this.p, Int32, lSrcPos, Int32, lSrcMaxLen, IMLangStringBufW.Ptr, ppDestBuf, Int32.Ptr, plDestLen?)
    LockWStr(lSrcPos, lSrcLen, lFlags, cchRequest, ppszDest?, pcchDest?, plDestLen?)
      => ComCall(11, this.p, Int32, lSrcPos, Int32, lSrcLen, Int32, lFlags, Int32, cchRequest, PWSTR.Ptr, ppszDest?, Int32.Ptr, pcchDest?, Int32.Ptr, plDestLen?)
    UnlockWStr(pszSrc, pcchActual?, plActualLen?)
      => ComCall(12, this.p, "Str", pszSrc, Int32, pszSrc.Length, Int32.Ptr, pcchActual?, Int32.Ptr, plActualLen?)
    SetLocale(lDestPos, lDestLen, locale)
      => ComCall(13, this.p, Int32, lDestPos, Int32, lDestLen, UInt32, locale)
    GetLocale(lSrcPos, lSrcMaxLen, plocale?, plLocalePos?, plLocaleLen?)
      => ComCall(14, this.p, Int32, lSrcPos, Int32, lSrcMaxLen, UInt32.Ptr, plocale?, Int32.Ptr, plLocalePos?, Int32.Ptr, plLocaleLen?)
}
struct IMLangStringAStr extends IMLangString {
    static IID := "{C04D65D2-B70D-11D0-B188-00AA0038C969}"
    SetAStr(lDestPos, lDestLen, uCodePage, pszSrc, pcchActual?, plActualLen?)
      => ComCall(7, this.p, Int32, lDestPos, Int32, lDestLen, UInt32, uCodePage, PSTR, pszSrc, Int32, pszSrc.Length, Int32.Ptr, pcchActual?, Int32.Ptr, plActualLen?)
    SetStrBufA(lDestPos, lDestLen, uCodePage, pSrcBuf?, pcchActual?, plActualLen?)
      => ComCall(8, this.p, Int32, lDestPos, Int32, lDestLen, UInt32, uCodePage, IMLangStringBufA, pSrcBuf?, Int32.Ptr, pcchActual?, Int32.Ptr, plActualLen?)
    GetAStr(lSrcPos, lSrcLen, uCodePageIn, pszDest?, pcchActual?, plActualLen?)
      => ComCall(9, this.p, Int32, lSrcPos, Int32, lSrcLen, UInt32, uCodePageIn, "Ptr", 0, PSTR, pszDest?, Int32, pszDest?.Length ?? 0, Int32.Ptr, pcchActual?, Int32.Ptr, plActualLen?)
    GetStrBufA(lSrcPos, lSrcMaxLen, puDestCodePage?, ppDestBuf, plDestLen?)
      => ComCall(10, this.p, Int32, lSrcPos, Int32, lSrcMaxLen, UInt32.Ptr, puDestCodePage?, IMLangStringBufA.Ptr, ppDestBuf, Int32.Ptr, plDestLen?)
    LockAStr(lSrcPos, lSrcLen, lFlags, uCodePageIn, cchRequest, puCodePageOut?, ppszDest?, pcchDest?, plDestLen?)
      => ComCall(11, this.p, Int32, lSrcPos, Int32, lSrcLen, Int32, lFlags, UInt32, uCodePageIn, Int32, cchRequest, UInt32.Ptr, puCodePageOut?, PSTR.Ptr, ppszDest?, Int32.Ptr, pcchDest?, Int32.Ptr, plDestLen?)
    UnlockAStr(pszSrc, pcchActual?, plActualLen?)
      => ComCall(12, this.p, PSTR, pszSrc, Int32, pszSrc.Length, Int32.Ptr, pcchActual?, Int32.Ptr, plActualLen?)
    SetLocale(lDestPos, lDestLen, locale)
      => ComCall(13, this.p, Int32, lDestPos, Int32, lDestLen, UInt32, locale)
    GetLocale(lSrcPos, lSrcMaxLen, plocale?, plLocalePos?, plLocaleLen?)
      => ComCall(14, this.p, Int32, lSrcPos, Int32, lSrcMaxLen, UInt32.Ptr, plocale?, Int32.Ptr, plLocalePos?, Int32.Ptr, plLocaleLen?)
}
struct IMLangLineBreakConsole extends IUnknown {
    static IID := "{F5BE2EE1-BFD7-11D0-B188-00AA0038C969}"
    BreakLineML(pSrcMLStr, lSrcPos, lSrcLen, cMinColumns, cMaxColumns, plLineLen?, plSkipLen?)
      => ComCall(3, this.p, IMLangString, pSrcMLStr, Int32, lSrcPos, Int32, lSrcLen, Int32, cMinColumns, Int32, cMaxColumns, Int32.Ptr, plLineLen?, Int32.Ptr, plSkipLen?)
    BreakLineW(locale, pszSrc, cMaxColumns, pcchLine?, pcchSkip?)
      => ComCall(4, this.p, UInt32, locale, "Str", pszSrc, Int32, pszSrc.Length, Int32, cMaxColumns, Int32.Ptr, pcchLine?, Int32.Ptr, pcchSkip?)
    BreakLineA(locale, uCodePage, pszSrc, cMaxColumns, pcchLine?, pcchSkip?)
      => ComCall(5, this.p, UInt32, locale, UInt32, uCodePage, PSTR, pszSrc, Int32, pszSrc.Length, Int32, cMaxColumns, Int32.Ptr, pcchLine?, Int32.Ptr, pcchSkip?)
}
struct MIMECONTF extends Int32 {
    static MIMECONTF_MAILNEWS := 1
    static MIMECONTF_BROWSER := 2
    static MIMECONTF_MINIMAL := 4
    static MIMECONTF_IMPORT := 8
    static MIMECONTF_SAVABLE_MAILNEWS := 256
    static MIMECONTF_SAVABLE_BROWSER := 512
    static MIMECONTF_EXPORT := 1024
    static MIMECONTF_PRIVCONVERTER := 65536
    static MIMECONTF_VALID := 131072
    static MIMECONTF_VALID_NLS := 262144
    static MIMECONTF_MIME_IE4 := 268435456
    static MIMECONTF_MIME_LATEST := 536870912
    static MIMECONTF_MIME_REGISTRY := 1073741824
}
struct MIMECPINFO {
    dwFlags : UInt32
    uiCodePage : UInt32
    uiFamilyCodePage : UInt32
    wszDescription : UInt16[64]
    wszWebCharset : UInt16[50]
    wszHeaderCharset : UInt16[50]
    wszBodyCharset : UInt16[50]
    wszFixedWidthFont : UInt16[32]
    wszProportionalFont : UInt16[32]
    bGDICharset : UInt8
}
struct MIMECSETINFO {
    uiCodePage : UInt32
    uiInternetEncoding : UInt32
    wszCharset : UInt16[50]
}
struct IEnumCodePage extends IUnknown {
    static IID := "{275C23E3-3747-11D0-9FEA-00AA003F8646}"
    Clone()
      => ComCall(3, this.p, "Ptr", 0)
    Next(celt, rgelt, pceltFetched?)
      => ComCall(4, this.p, UInt32, celt, MIMECPINFO.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(5, this.p)
    Skip(celt)
      => ComCall(6, this.p, UInt32, celt)
}
struct RFC1766INFO {
    lcid : UInt32
    wszRfc1766 : UInt16[6]
    wszLocaleName : UInt16[32]
}
struct IEnumRfc1766 extends IUnknown {
    static IID := "{3DC39D1D-C030-11D0-B81B-00C04FC9B31F}"
    Clone()
      => ComCall(3, this.p, "Ptr", 0)
    Next(celt, rgelt, pceltFetched?)
      => ComCall(4, this.p, UInt32, celt, RFC1766INFO.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(5, this.p)
    Skip(celt)
      => ComCall(6, this.p, UInt32, celt)
}
struct SCRIPTCONTF extends Int32 {
    static sidDefault := 0
    static sidMerge := 1
    static sidAsciiSym := 2
    static sidAsciiLatin := 3
    static sidLatin := 4
    static sidGreek := 5
    static sidCyrillic := 6
    static sidArmenian := 7
    static sidHebrew := 8
    static sidArabic := 9
    static sidDevanagari := 10
    static sidBengali := 11
    static sidGurmukhi := 12
    static sidGujarati := 13
    static sidOriya := 14
    static sidTamil := 15
    static sidTelugu := 16
    static sidKannada := 17
    static sidMalayalam := 18
    static sidThai := 19
    static sidLao := 20
    static sidTibetan := 21
    static sidGeorgian := 22
    static sidHangul := 23
    static sidKana := 24
    static sidBopomofo := 25
    static sidHan := 26
    static sidEthiopic := 27
    static sidCanSyllabic := 28
    static sidCherokee := 29
    static sidYi := 30
    static sidBraille := 31
    static sidRunic := 32
    static sidOgham := 33
    static sidSinhala := 34
    static sidSyriac := 35
    static sidBurmese := 36
    static sidKhmer := 37
    static sidThaana := 38
    static sidMongolian := 39
    static sidUserDefined := 40
    static sidLim := 41
    static sidFEFirst := 23
    static sidFELast := 26
}
struct SCRIPTINFO {
    ScriptId : UInt8
    uiCodePage : UInt32
    wszDescription : UInt16[48]
    wszFixedWidthFont : UInt16[32]
    wszProportionalFont : UInt16[32]
}
struct IEnumScript extends IUnknown {
    static IID := "{AE5F1430-388B-11D2-8380-00C04F8F5DA1}"
    Clone()
      => ComCall(3, this.p, "Ptr", 0)
    Next(celt, rgelt, pceltFetched?)
      => ComCall(4, this.p, UInt32, celt, SCRIPTINFO.Ptr, rgelt, UInt32.Ptr, pceltFetched?)
    Reset()
      => ComCall(5, this.p)
    Skip(celt)
      => ComCall(6, this.p, UInt32, celt)
}
struct MLCONVCHAR extends Int32 {
    static MLCONVCHARF_AUTODETECT := 1
    static MLCONVCHARF_ENTITIZE := 2
    static MLCONVCHARF_NCR_ENTITIZE := 2
    static MLCONVCHARF_NAME_ENTITIZE := 4
    static MLCONVCHARF_USEDEFCHAR := 8
    static MLCONVCHARF_NOBESTFITCHARS := 16
    static MLCONVCHARF_DETECTJPN := 32
}
struct MLCP extends Int32 {
    static MLDETECTF_MAILNEWS := 1
    static MLDETECTF_BROWSER := 2
    static MLDETECTF_VALID := 4
    static MLDETECTF_VALID_NLS := 8
    static MLDETECTF_PRESERVE_ORDER := 16
    static MLDETECTF_PREFERRED_ONLY := 32
    static MLDETECTF_FILTER_SPECIALCHAR := 64
    static MLDETECTF_EURO_UTF8 := 128
}
struct IMLangConvertCharset extends IUnknown {
    static IID := "{D66D6F98-CDAA-11D0-B822-00C04FC9B31F}"
    Initialize(uiSrcCodePage, uiDstCodePage, dwProperty)
      => ComCall(3, this.p, UInt32, uiSrcCodePage, UInt32, uiDstCodePage, UInt32, dwProperty)
    GetSourceCodePage(puiSrcCodePage)
      => ComCall(4, this.p, UInt32.Ptr, puiSrcCodePage)
    GetDestinationCodePage(puiDstCodePage)
      => ComCall(5, this.p, UInt32.Ptr, puiDstCodePage)
    GetProperty(pdwProperty)
      => ComCall(6, this.p, UInt32.Ptr, pdwProperty)
    DoConversion(pSrcStr, pcSrcSize := pSrcStr.Size, pDstStr, pcDstSize := pDstStr.Size)
      => ComCall(7, this.p, UInt8.Ptr, pSrcStr, UInt32.Ptr, pcSrcSize?, UInt8.Ptr, pDstStr, UInt32.Ptr, pcDstSize?)
    DoConversionToUnicode(pSrcStr, pcSrcSize := pSrcStr.Size, pDstStr)
      => ComCall(8, this.p, PSTR, pSrcStr, UInt32.Ptr, pcSrcSize?, PWSTR, pDstStr, UInt32.Ptr, pDstStr.Length)
    DoConversionFromUnicode(pSrcStr, pDstStr, pcDstSize := pDstStr.Size)
      => ComCall(9, this.p, "Str", pSrcStr, UInt32.Ptr, pSrcStr.Length, PSTR, pDstStr, UInt32.Ptr, pcDstSize?)
}
struct IMultiLanguage extends IUnknown {
    static IID := "{275C23E1-3747-11D0-9FEA-00AA003F8646}"
    GetNumberOfCodePageInfo(pcCodePage)
      => ComCall(3, this.p, UInt32.Ptr, pcCodePage)
    GetCodePageInfo(uiCodePage, pCodePageInfo)
      => ComCall(4, this.p, UInt32, uiCodePage, MIMECPINFO.Ptr, pCodePageInfo)
    GetFamilyCodePage(uiCodePage, puiFamilyCodePage)
      => ComCall(5, this.p, UInt32, uiCodePage, UInt32.Ptr, puiFamilyCodePage)
    EnumCodePages(grfFlags, ppEnumCodePage)
      => ComCall(6, this.p, UInt32, grfFlags, IEnumCodePage.Ptr, ppEnumCodePage)
    GetCharsetInfo(Charset, pCharsetInfo)
      => ComCall(7, this.p, BSTR, Charset, MIMECSETINFO.Ptr, pCharsetInfo)
    IsConvertible(dwSrcEncoding, dwDstEncoding)
      => ComCall(8, this.p, UInt32, dwSrcEncoding, UInt32, dwDstEncoding)
    ConvertString(pdwMode?, dwSrcEncoding, dwDstEncoding, pSrcStr?, pcSrcSize := pSrcStr.Size, pDstStr?, pcDstSize := pDstStr.Size)
      => ComCall(9, this.p, UInt32.Ptr, pdwMode?, UInt32, dwSrcEncoding, UInt32, dwDstEncoding, UInt8.Ptr, pSrcStr?, UInt32.Ptr, pcSrcSize?, UInt8.Ptr, pDstStr?, UInt32.Ptr, pcDstSize?)
    ConvertStringToUnicode(pdwMode?, dwEncoding, pSrcStr?, pcSrcSize := pSrcStr.Size, pDstStr?)
      => ComCall(10, this.p, UInt32.Ptr, pdwMode?, UInt32, dwEncoding, PSTR, pSrcStr?, UInt32.Ptr, pcSrcSize?, PWSTR, pDstStr?, UInt32.Ptr, pDstStr?.Length ?? 0)
    ConvertStringFromUnicode(pdwMode?, dwEncoding, pSrcStr?, pDstStr?, pcDstSize := pDstStr.Size)
      => ComCall(11, this.p, UInt32.Ptr, pdwMode?, UInt32, dwEncoding, "Str", pSrcStr?, UInt32.Ptr, pSrcStr?.Length ?? 0, PSTR, pDstStr?, UInt32.Ptr, pcDstSize?)
    ConvertStringReset()
      => ComCall(12, this.p)
    GetRfc1766FromLcid(Locale, pbstrRfc1766)
      => ComCall(13, this.p, UInt32, Locale, BSTR.Ptr, pbstrRfc1766)
    GetLcidFromRfc1766(pLocale, bstrRfc1766)
      => ComCall(14, this.p, UInt32.Ptr, pLocale, BSTR, bstrRfc1766)
    EnumRfc1766(ppEnumRfc1766)
      => ComCall(15, this.p, IEnumRfc1766.Ptr, ppEnumRfc1766)
    GetRfc1766Info(Locale, pRfc1766Info)
      => ComCall(16, this.p, UInt32, Locale, RFC1766INFO.Ptr, pRfc1766Info)
    CreateConvertCharset(uiSrcCodePage, uiDstCodePage, dwProperty, ppMLangConvertCharset)
      => ComCall(17, this.p, UInt32, uiSrcCodePage, UInt32, uiDstCodePage, UInt32, dwProperty, IMLangConvertCharset.Ptr, ppMLangConvertCharset)
}
struct MLDETECTCP extends Int32 {
    static MLDETECTCP_NONE := 0
    static MLDETECTCP_7BIT := 1
    static MLDETECTCP_8BIT := 2
    static MLDETECTCP_DBCS := 4
    static MLDETECTCP_HTML := 8
    static MLDETECTCP_NUMBER := 16
}
struct DetectEncodingInfo {
    nLangID : UInt32
    nCodePage : UInt32
    nDocPercent : Int32
    nConfidence : Int32
}
struct SCRIPTFONTCONTF extends Int32 {
    static SCRIPTCONTF_FIXED_FONT := 1
    static SCRIPTCONTF_PROPORTIONAL_FONT := 2
    static SCRIPTCONTF_SCRIPT_USER := 65536
    static SCRIPTCONTF_SCRIPT_HIDE := 131072
    static SCRIPTCONTF_SCRIPT_SYSTEM := 262144
}
struct SCRIPTFONTINFO {
    scripts : Int64
    wszFont : UInt16[32]
}
struct IMultiLanguage2 extends IUnknown {
    static IID := "{DCCFC164-2B38-11D2-B7EC-00C04F8F5D9A}"
    GetNumberOfCodePageInfo(pcCodePage)
      => ComCall(3, this.p, UInt32.Ptr, pcCodePage)
    GetCodePageInfo(uiCodePage, LangId, pCodePageInfo)
      => ComCall(4, this.p, UInt32, uiCodePage, UInt16, LangId, MIMECPINFO.Ptr, pCodePageInfo)
    GetFamilyCodePage(uiCodePage, puiFamilyCodePage)
      => ComCall(5, this.p, UInt32, uiCodePage, UInt32.Ptr, puiFamilyCodePage)
    EnumCodePages(grfFlags, LangId, ppEnumCodePage)
      => ComCall(6, this.p, UInt32, grfFlags, UInt16, LangId, IEnumCodePage.Ptr, ppEnumCodePage)
    GetCharsetInfo(Charset, pCharsetInfo)
      => ComCall(7, this.p, BSTR, Charset, MIMECSETINFO.Ptr, pCharsetInfo)
    IsConvertible(dwSrcEncoding, dwDstEncoding)
      => ComCall(8, this.p, UInt32, dwSrcEncoding, UInt32, dwDstEncoding)
    ConvertString(pdwMode?, dwSrcEncoding, dwDstEncoding, pSrcStr?, pcSrcSize := pSrcStr.Size, pDstStr?, pcDstSize := pDstStr.Size)
      => ComCall(9, this.p, UInt32.Ptr, pdwMode?, UInt32, dwSrcEncoding, UInt32, dwDstEncoding, UInt8.Ptr, pSrcStr?, UInt32.Ptr, pcSrcSize?, UInt8.Ptr, pDstStr?, UInt32.Ptr, pcDstSize?)
    ConvertStringToUnicode(pdwMode?, dwEncoding, pSrcStr?, pcSrcSize := pSrcStr.Size, pDstStr?)
      => ComCall(10, this.p, UInt32.Ptr, pdwMode?, UInt32, dwEncoding, PSTR, pSrcStr?, UInt32.Ptr, pcSrcSize?, PWSTR, pDstStr?, UInt32.Ptr, pDstStr?.Length ?? 0)
    ConvertStringFromUnicode(pdwMode?, dwEncoding, pSrcStr?, pDstStr?, pcDstSize := pDstStr.Size)
      => ComCall(11, this.p, UInt32.Ptr, pdwMode?, UInt32, dwEncoding, "Str", pSrcStr?, UInt32.Ptr, pSrcStr?.Length ?? 0, PSTR, pDstStr?, UInt32.Ptr, pcDstSize?)
    ConvertStringReset()
      => ComCall(12, this.p)
    GetRfc1766FromLcid(Locale, pbstrRfc1766)
      => ComCall(13, this.p, UInt32, Locale, BSTR.Ptr, pbstrRfc1766)
    GetLcidFromRfc1766(pLocale, bstrRfc1766)
      => ComCall(14, this.p, UInt32.Ptr, pLocale, BSTR, bstrRfc1766)
    EnumRfc1766(LangId, ppEnumRfc1766)
      => ComCall(15, this.p, UInt16, LangId, IEnumRfc1766.Ptr, ppEnumRfc1766)
    GetRfc1766Info(Locale, LangId, pRfc1766Info)
      => ComCall(16, this.p, UInt32, Locale, UInt16, LangId, RFC1766INFO.Ptr, pRfc1766Info)
    CreateConvertCharset(uiSrcCodePage, uiDstCodePage, dwProperty, ppMLangConvertCharset)
      => ComCall(17, this.p, UInt32, uiSrcCodePage, UInt32, uiDstCodePage, UInt32, dwProperty, IMLangConvertCharset.Ptr, ppMLangConvertCharset)
    ConvertStringInIStream(pdwMode?, dwFlag, lpFallBack?, dwSrcEncoding, dwDstEncoding, pstmIn, pstmOut)
      => ComCall(18, this.p, UInt32.Ptr, pdwMode?, UInt32, dwFlag, "Str", lpFallBack?, UInt32, dwSrcEncoding, UInt32, dwDstEncoding, IStream, pstmIn, IStream, pstmOut)
    ConvertStringToUnicodeEx(pdwMode?, dwEncoding, pSrcStr, pcSrcSize := pSrcStr.Size, pDstStr, dwFlag, lpFallBack?)
      => ComCall(19, this.p, UInt32.Ptr, pdwMode?, UInt32, dwEncoding, PSTR, pSrcStr, UInt32.Ptr, pcSrcSize?, PWSTR, pDstStr, UInt32.Ptr, pDstStr.Length, UInt32, dwFlag, "Str", lpFallBack?)
    ConvertStringFromUnicodeEx(pdwMode?, dwEncoding, pSrcStr, pDstStr, pcDstSize := pDstStr.Size, dwFlag, lpFallBack?)
      => ComCall(20, this.p, UInt32.Ptr, pdwMode?, UInt32, dwEncoding, "Str", pSrcStr, UInt32.Ptr, pSrcStr.Length, PSTR, pDstStr, UInt32.Ptr, pcDstSize?, UInt32, dwFlag, "Str", lpFallBack?)
    DetectCodepageInIStream(dwFlag, dwPrefWinCodePage, pstmIn, lpEncoding, pnScores)
      => ComCall(21, this.p, UInt32, dwFlag, UInt32, dwPrefWinCodePage, IStream, pstmIn, DetectEncodingInfo.Ptr, lpEncoding, Int32.Ptr, pnScores)
    DetectInputCodepage(dwFlag, dwPrefWinCodePage, pSrcStr, pcSrcSize, lpEncoding, pnScores)
      => ComCall(22, this.p, UInt32, dwFlag, UInt32, dwPrefWinCodePage, PSTR, pSrcStr, Int32.Ptr, pcSrcSize, DetectEncodingInfo.Ptr, lpEncoding, Int32.Ptr, pnScores)
    ValidateCodePage(uiCodePage, hwnd1)
      => ComCall(23, this.p, UInt32, uiCodePage, HWND, hwnd1)
    GetCodePageDescription(uiCodePage, lcid, lpWideCharStr)
      => ComCall(24, this.p, UInt32, uiCodePage, UInt32, lcid, PWSTR, lpWideCharStr, Int32, lpWideCharStr.Length)
    IsCodePageInstallable(uiCodePage)
      => ComCall(25, this.p, UInt32, uiCodePage)
    SetMimeDBSource(dwSource)
      => ComCall(26, this.p, MIMECONTF, dwSource)
    GetNumberOfScripts(pnScripts)
      => ComCall(27, this.p, UInt32.Ptr, pnScripts)
    EnumScripts(dwFlags, LangId, ppEnumScript)
      => ComCall(28, this.p, UInt32, dwFlags, UInt16, LangId, IEnumScript.Ptr, ppEnumScript)
    ValidateCodePageEx(uiCodePage, hwnd1, dwfIODControl)
      => ComCall(29, this.p, UInt32, uiCodePage, HWND, hwnd1, UInt32, dwfIODControl)
}
struct IMLangCodePages extends IUnknown {
    static IID := "{359F3443-BD4A-11D0-B188-00AA0038C969}"
    GetCharCodePages(chSrc, pdwCodePages)
      => ComCall(3, this.p, UInt16, chSrc, UInt32.Ptr, pdwCodePages)
    GetStrCodePages(pszSrc, dwPriorityCodePages, pdwCodePages?, pcchCodePages?)
      => ComCall(4, this.p, "Str", pszSrc, Int32, pszSrc.Length, UInt32, dwPriorityCodePages, UInt32.Ptr, pdwCodePages?, Int32.Ptr, pcchCodePages?)
    CodePageToCodePages(uCodePage, pdwCodePages)
      => ComCall(5, this.p, UInt32, uCodePage, UInt32.Ptr, pdwCodePages)
    CodePagesToCodePage(dwCodePages, uDefaultCodePage, puCodePage)
      => ComCall(6, this.p, UInt32, dwCodePages, UInt32, uDefaultCodePage, UInt32.Ptr, puCodePage)
}
struct IMLangFontLink extends IMLangCodePages {
    static IID := "{359F3441-BD4A-11D0-B188-00AA0038C969}"
    GetFontCodePages(hDC1, hFont1, pdwCodePages?)
      => ComCall(7, this.p, HDC, hDC1, HFONT, hFont1, UInt32.Ptr, pdwCodePages?)
    MapFont(hDC1, dwCodePages, hSrcFont, phDestFont?)
      => ComCall(8, this.p, HDC, hDC1, UInt32, dwCodePages, HFONT, hSrcFont, HFONT.Ptr, phDestFont?)
    ReleaseFont(hFont1)
      => ComCall(9, this.p, HFONT, hFont1)
    ResetFontMapping()
      => ComCall(10, this.p)
}
struct UNICODERANGE {
    wcFrom : UInt16
    wcTo : UInt16
}
struct IMLangFontLink2 extends IMLangCodePages {
    static IID := "{DCCFC162-2B38-11D2-B7EC-00C04F8F5D9A}"
    GetFontCodePages(hDC1, hFont1, pdwCodePages?)
      => ComCall(7, this.p, HDC, hDC1, HFONT, hFont1, UInt32.Ptr, pdwCodePages?)
    ReleaseFont(hFont1)
      => ComCall(8, this.p, HFONT, hFont1)
    ResetFontMapping()
      => ComCall(9, this.p)
    MapFont(hDC1, dwCodePages, chSrc, pFont?)
      => ComCall(10, this.p, HDC, hDC1, UInt32, dwCodePages, UInt16, chSrc, HFONT.Ptr, pFont?)
    GetFontUnicodeRanges(hDC1, puiRanges, pUranges?)
      => ComCall(11, this.p, HDC, hDC1, UInt32.Ptr, puiRanges, UNICODERANGE.Ptr, pUranges?)
    GetScriptFontInfo(sid, dwFlags, puiFonts, pScriptFont?)
      => ComCall(12, this.p, UInt8, sid, UInt32, dwFlags, UInt32.Ptr, puiFonts, SCRIPTFONTINFO.Ptr, pScriptFont?)
    CodePageToScriptID(uiCodePage, pSid)
      => ComCall(13, this.p, UInt32, uiCodePage, UInt8.Ptr, pSid)
}
struct IMultiLanguage3 extends IMultiLanguage2 {
    static IID := "{4E5868AB-B157-4623-9ACC-6A1D9CAEBE04}"
    DetectOutboundCodePage(dwFlags, lpWideCharStr, puiPreferredCodePages?, puiDetectedCodePages, lpSpecialChar?)
      => ComCall(30, this.p, UInt32, dwFlags, "Str", lpWideCharStr, UInt32, lpWideCharStr.Length, UInt32.Ptr, puiPreferredCodePages?, UInt32, puiPreferredCodePages?.Length ?? 0, UInt32.Ptr, puiDetectedCodePages, UInt32.Ptr, puiDetectedCodePages.Length, "Str", lpSpecialChar?)
    DetectOutboundCodePageInIStream(dwFlags, pStrIn, puiPreferredCodePages?, puiDetectedCodePages, lpSpecialChar?)
      => ComCall(31, this.p, UInt32, dwFlags, IStream, pStrIn, UInt32.Ptr, puiPreferredCodePages?, UInt32, puiPreferredCodePages?.Length ?? 0, UInt32.Ptr, puiDetectedCodePages, UInt32.Ptr, puiDetectedCodePages.Length, "Str", lpSpecialChar?)
}
struct MLSTR_FLAGS extends Int32 {
    static MLSTR_READ := 1
    static MLSTR_WRITE := 2
}
struct CALDATETIME_DATEUNIT extends Int32 {
    static EraUnit := 0
    static YearUnit := 1
    static MonthUnit := 2
    static WeekUnit := 3
    static DayUnit := 4
    static HourUnit := 5
    static MinuteUnit := 6
    static SecondUnit := 7
    static TickUnit := 8
}
struct CALDATETIME {
    CalId : UInt32
    Era : UInt32
    Year : UInt32
    Month : UInt32
    Day : UInt32
    DayOfWeek : UInt32
    Hour : UInt32
    Minute : UInt32
    Second : UInt32
    Tick : UInt32
}
