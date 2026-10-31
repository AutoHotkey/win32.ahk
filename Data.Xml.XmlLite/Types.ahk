#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct XmlNodeType extends Int32 {
    static XmlNodeType_None := 0
    static XmlNodeType_Element := 1
    static XmlNodeType_Attribute := 2
    static XmlNodeType_Text := 3
    static XmlNodeType_CDATA := 4
    static XmlNodeType_ProcessingInstruction := 7
    static XmlNodeType_Comment := 8
    static XmlNodeType_DocumentType := 10
    static XmlNodeType_Whitespace := 13
    static XmlNodeType_EndElement := 15
    static XmlNodeType_XmlDeclaration := 17
    static _XmlNodeType_Last := 17
}
struct XmlConformanceLevel extends Int32 {
    static XmlConformanceLevel_Auto := 0
    static XmlConformanceLevel_Fragment := 1
    static XmlConformanceLevel_Document := 2
    static _XmlConformanceLevel_Last := 2
}
struct DtdProcessing extends Int32 {
    static DtdProcessing_Prohibit := 0
    static DtdProcessing_Parse := 1
    static _DtdProcessing_Last := 1
}
struct XmlReadState extends Int32 {
    static XmlReadState_Initial := 0
    static XmlReadState_Interactive := 1
    static XmlReadState_Error := 2
    static XmlReadState_EndOfFile := 3
    static XmlReadState_Closed := 4
}
struct XmlReaderProperty extends Int32 {
    static XmlReaderProperty_MultiLanguage := 0
    static XmlReaderProperty_ConformanceLevel := 1
    static XmlReaderProperty_RandomAccess := 2
    static XmlReaderProperty_XmlResolver := 3
    static XmlReaderProperty_DtdProcessing := 4
    static XmlReaderProperty_ReadState := 5
    static XmlReaderProperty_MaxElementDepth := 6
    static XmlReaderProperty_MaxEntityExpansion := 7
    static _XmlReaderProperty_Last := 7
}
struct XmlError extends Int32 {
    static MX_E_MX := -1072894464
    static MX_E_INPUTEND := -1072894463
    static MX_E_ENCODING := -1072894462
    static MX_E_ENCODINGSWITCH := -1072894461
    static MX_E_ENCODINGSIGNATURE := -1072894460
    static WC_E_WC := -1072894432
    static WC_E_WHITESPACE := -1072894431
    static WC_E_SEMICOLON := -1072894430
    static WC_E_GREATERTHAN := -1072894429
    static WC_E_QUOTE := -1072894428
    static WC_E_EQUAL := -1072894427
    static WC_E_LESSTHAN := -1072894426
    static WC_E_HEXDIGIT := -1072894425
    static WC_E_DIGIT := -1072894424
    static WC_E_LEFTBRACKET := -1072894423
    static WC_E_LEFTPAREN := -1072894422
    static WC_E_XMLCHARACTER := -1072894421
    static WC_E_NAMECHARACTER := -1072894420
    static WC_E_SYNTAX := -1072894419
    static WC_E_CDSECT := -1072894418
    static WC_E_COMMENT := -1072894417
    static WC_E_CONDSECT := -1072894416
    static WC_E_DECLATTLIST := -1072894415
    static WC_E_DECLDOCTYPE := -1072894414
    static WC_E_DECLELEMENT := -1072894413
    static WC_E_DECLENTITY := -1072894412
    static WC_E_DECLNOTATION := -1072894411
    static WC_E_NDATA := -1072894410
    static WC_E_PUBLIC := -1072894409
    static WC_E_SYSTEM := -1072894408
    static WC_E_NAME := -1072894407
    static WC_E_ROOTELEMENT := -1072894406
    static WC_E_ELEMENTMATCH := -1072894405
    static WC_E_UNIQUEATTRIBUTE := -1072894404
    static WC_E_TEXTXMLDECL := -1072894403
    static WC_E_LEADINGXML := -1072894402
    static WC_E_TEXTDECL := -1072894401
    static WC_E_XMLDECL := -1072894400
    static WC_E_ENCNAME := -1072894399
    static WC_E_PUBLICID := -1072894398
    static WC_E_PESINTERNALSUBSET := -1072894397
    static WC_E_PESBETWEENDECLS := -1072894396
    static WC_E_NORECURSION := -1072894395
    static WC_E_ENTITYCONTENT := -1072894394
    static WC_E_UNDECLAREDENTITY := -1072894393
    static WC_E_PARSEDENTITY := -1072894392
    static WC_E_NOEXTERNALENTITYREF := -1072894391
    static WC_E_PI := -1072894390
    static WC_E_SYSTEMID := -1072894389
    static WC_E_QUESTIONMARK := -1072894388
    static WC_E_CDSECTEND := -1072894387
    static WC_E_MOREDATA := -1072894386
    static WC_E_DTDPROHIBITED := -1072894385
    static WC_E_INVALIDXMLSPACE := -1072894384
    static NC_E_NC := -1072894368
    static NC_E_QNAMECHARACTER := -1072894367
    static NC_E_QNAMECOLON := -1072894366
    static NC_E_NAMECOLON := -1072894365
    static NC_E_DECLAREDPREFIX := -1072894364
    static NC_E_UNDECLAREDPREFIX := -1072894363
    static NC_E_EMPTYURI := -1072894362
    static NC_E_XMLPREFIXRESERVED := -1072894361
    static NC_E_XMLNSPREFIXRESERVED := -1072894360
    static NC_E_XMLURIRESERVED := -1072894359
    static NC_E_XMLNSURIRESERVED := -1072894358
    static SC_E_SC := -1072894336
    static SC_E_MAXELEMENTDEPTH := -1072894335
    static SC_E_MAXENTITYEXPANSION := -1072894334
    static WR_E_WR := -1072894208
    static WR_E_NONWHITESPACE := -1072894207
    static WR_E_NSPREFIXDECLARED := -1072894206
    static WR_E_NSPREFIXWITHEMPTYNSURI := -1072894205
    static WR_E_DUPLICATEATTRIBUTE := -1072894204
    static WR_E_XMLNSPREFIXDECLARATION := -1072894203
    static WR_E_XMLPREFIXDECLARATION := -1072894202
    static WR_E_XMLURIDECLARATION := -1072894201
    static WR_E_XMLNSURIDECLARATION := -1072894200
    static WR_E_NAMESPACEUNDECLARED := -1072894199
    static WR_E_INVALIDXMLSPACE := -1072894198
    static WR_E_INVALIDACTION := -1072894197
    static WR_E_INVALIDSURROGATEPAIR := -1072894196
    static XML_E_INVALID_DECIMAL := -1072898019
    static XML_E_INVALID_HEXIDECIMAL := -1072898018
    static XML_E_INVALID_UNICODE := -1072898017
    static XML_E_INVALIDENCODING := -1072897938
}
struct XmlStandalone extends Int32 {
    static XmlStandalone_Omit := 0
    static XmlStandalone_Yes := 1
    static XmlStandalone_No := 2
    static _XmlStandalone_Last := 2
}
struct XmlWriterProperty extends Int32 {
    static XmlWriterProperty_MultiLanguage := 0
    static XmlWriterProperty_Indent := 1
    static XmlWriterProperty_ByteOrderMark := 2
    static XmlWriterProperty_OmitXmlDeclaration := 3
    static XmlWriterProperty_ConformanceLevel := 4
    static XmlWriterProperty_CompactEmptyElement := 5
    static _XmlWriterProperty_Last := 5
}
struct IXmlReader extends IUnknown {
    static IID := "{7279FC81-709D-4095-B63D-69FE4B0D9030}"
    SetInput(pInput?)
      => ComCall(3, this.p, IUnknown, pInput?)
    GetProperty(nProperty, ppValue)
      => ComCall(4, this.p, UInt32, nProperty, IntPtr.Ptr, ppValue)
    SetProperty(nProperty, pValue?)
      => ComCall(5, this.p, UInt32, nProperty, IntPtr, pValue?)
    Read(pNodeType?)
      => ComCall(6, this.p, XmlNodeType.Ptr, pNodeType?)
    GetNodeType(pNodeType)
      => ComCall(7, this.p, XmlNodeType.Ptr, pNodeType)
    MoveToFirstAttribute()
      => ComCall(8, this.p)
    MoveToNextAttribute()
      => ComCall(9, this.p)
    MoveToAttributeByName(pwszLocalName, pwszNamespaceUri?)
      => ComCall(10, this.p, "Str", pwszLocalName, "Str", pwszNamespaceUri?)
    MoveToElement()
      => ComCall(11, this.p)
    GetQualifiedName(ppwszQualifiedName, pcwchQualifiedName?)
      => ComCall(12, this.p, PWSTR.Ptr, ppwszQualifiedName, UInt32.Ptr, pcwchQualifiedName?)
    GetNamespaceUri(ppwszNamespaceUri, pcwchNamespaceUri?)
      => ComCall(13, this.p, PWSTR.Ptr, ppwszNamespaceUri, UInt32.Ptr, pcwchNamespaceUri?)
    GetLocalName(ppwszLocalName, pcwchLocalName?)
      => ComCall(14, this.p, PWSTR.Ptr, ppwszLocalName, UInt32.Ptr, pcwchLocalName?)
    GetPrefix(ppwszPrefix, pcwchPrefix?)
      => ComCall(15, this.p, PWSTR.Ptr, ppwszPrefix, UInt32.Ptr, pcwchPrefix?)
    GetValue(ppwszValue, pcwchValue?)
      => ComCall(16, this.p, PWSTR.Ptr, ppwszValue, UInt32.Ptr, pcwchValue?)
    ReadValueChunk(pwchBuffer, pcwchRead)
      => ComCall(17, this.p, PWSTR, pwchBuffer, UInt32, pwchBuffer.Length, UInt32.Ptr, pcwchRead)
    GetBaseUri(ppwszBaseUri, pcwchBaseUri?)
      => ComCall(18, this.p, PWSTR.Ptr, ppwszBaseUri, UInt32.Ptr, pcwchBaseUri?)
    IsDefault()
      => ComCall(19, this.p, BOOL)
    IsEmptyElement()
      => ComCall(20, this.p, BOOL)
    GetLineNumber(pnLineNumber)
      => ComCall(21, this.p, UInt32.Ptr, pnLineNumber)
    GetLinePosition(pnLinePosition)
      => ComCall(22, this.p, UInt32.Ptr, pnLinePosition)
    GetAttributeCount(pnAttributeCount)
      => ComCall(23, this.p, UInt32.Ptr, pnAttributeCount)
    GetDepth(pnDepth)
      => ComCall(24, this.p, UInt32.Ptr, pnDepth)
    IsEOF()
      => ComCall(25, this.p, BOOL)
}
struct IXmlResolver extends IUnknown {
    static IID := "{7279FC82-709D-4095-B63D-69FE4B0D9030}"
    ResolveUri(pwszBaseUri?, pwszPublicIdentifier?, pwszSystemIdentifier?, ppResolvedInput)
      => ComCall(3, this.p, "Str", pwszBaseUri?, "Str", pwszPublicIdentifier?, "Str", pwszSystemIdentifier?, IUnknown.Ptr, ppResolvedInput)
}
struct IXmlWriter extends IUnknown {
    static IID := "{7279FC88-709D-4095-B63D-69FE4B0D9030}"
    SetOutput(pOutput?)
      => ComCall(3, this.p, IUnknown, pOutput?)
    GetProperty(nProperty, ppValue)
      => ComCall(4, this.p, UInt32, nProperty, IntPtr.Ptr, ppValue)
    SetProperty(nProperty, pValue?)
      => ComCall(5, this.p, UInt32, nProperty, IntPtr, pValue?)
    WriteAttributes(pReader, fWriteDefaultAttributes)
      => ComCall(6, this.p, IXmlReader, pReader, BOOL, fWriteDefaultAttributes)
    WriteAttributeString(pwszPrefix?, pwszLocalName?, pwszNamespaceUri?, pwszValue?)
      => ComCall(7, this.p, "Str", pwszPrefix?, "Str", pwszLocalName?, "Str", pwszNamespaceUri?, "Str", pwszValue?)
    WriteCData(pwszText?)
      => ComCall(8, this.p, "Str", pwszText?)
    WriteCharEntity(wch)
      => ComCall(9, this.p, UInt16, wch)
    WriteChars(pwch?)
      => ComCall(10, this.p, "Str", pwch?, UInt32, pwch?.Length ?? 0)
    WriteComment(pwszComment?)
      => ComCall(11, this.p, "Str", pwszComment?)
    WriteDocType(pwszName?, pwszPublicId?, pwszSystemId?, pwszSubset?)
      => ComCall(12, this.p, "Str", pwszName?, "Str", pwszPublicId?, "Str", pwszSystemId?, "Str", pwszSubset?)
    WriteElementString(pwszPrefix?, pwszLocalName, pwszNamespaceUri?, pwszValue?)
      => ComCall(13, this.p, "Str", pwszPrefix?, "Str", pwszLocalName, "Str", pwszNamespaceUri?, "Str", pwszValue?)
    WriteEndDocument()
      => ComCall(14, this.p)
    WriteEndElement()
      => ComCall(15, this.p)
    WriteEntityRef(pwszName)
      => ComCall(16, this.p, "Str", pwszName)
    WriteFullEndElement()
      => ComCall(17, this.p)
    WriteName(pwszName)
      => ComCall(18, this.p, "Str", pwszName)
    WriteNmToken(pwszNmToken)
      => ComCall(19, this.p, "Str", pwszNmToken)
    WriteNode(pReader, fWriteDefaultAttributes)
      => ComCall(20, this.p, IXmlReader, pReader, BOOL, fWriteDefaultAttributes)
    WriteNodeShallow(pReader, fWriteDefaultAttributes)
      => ComCall(21, this.p, IXmlReader, pReader, BOOL, fWriteDefaultAttributes)
    WriteProcessingInstruction(pwszName, pwszText?)
      => ComCall(22, this.p, "Str", pwszName, "Str", pwszText?)
    WriteQualifiedName(pwszLocalName, pwszNamespaceUri?)
      => ComCall(23, this.p, "Str", pwszLocalName, "Str", pwszNamespaceUri?)
    WriteRaw(pwszData?)
      => ComCall(24, this.p, "Str", pwszData?)
    WriteRawChars(pwch?)
      => ComCall(25, this.p, "Str", pwch?, UInt32, pwch?.Length ?? 0)
    WriteStartDocument(standalone)
      => ComCall(26, this.p, XmlStandalone, standalone)
    WriteStartElement(pwszPrefix?, pwszLocalName, pwszNamespaceUri?)
      => ComCall(27, this.p, "Str", pwszPrefix?, "Str", pwszLocalName, "Str", pwszNamespaceUri?)
    WriteString(pwszText?)
      => ComCall(28, this.p, "Str", pwszText?)
    WriteSurrogateCharEntity(wchLow, wchHigh)
      => ComCall(29, this.p, UInt16, wchLow, UInt16, wchHigh)
    WriteWhitespace(pwszWhitespace?)
      => ComCall(30, this.p, "Str", pwszWhitespace?)
    Flush()
      => ComCall(31, this.p)
}
struct IXmlWriterLite extends IUnknown {
    static IID := "{862494C6-1310-4AAD-B3CD-2DBEEBF670D3}"
    SetOutput(pOutput?)
      => ComCall(3, this.p, IUnknown, pOutput?)
    GetProperty(nProperty, ppValue)
      => ComCall(4, this.p, UInt32, nProperty, IntPtr.Ptr, ppValue)
    SetProperty(nProperty, pValue?)
      => ComCall(5, this.p, UInt32, nProperty, IntPtr, pValue?)
    WriteAttributes(pReader, fWriteDefaultAttributes)
      => ComCall(6, this.p, IXmlReader, pReader, BOOL, fWriteDefaultAttributes)
    WriteAttributeString(pwszQName, pwszValue?)
      => ComCall(7, this.p, "Str", pwszQName, UInt32, pwszQName.Length, "Str", pwszValue?, UInt32, pwszValue?.Length ?? 0)
    WriteCData(pwszText?)
      => ComCall(8, this.p, "Str", pwszText?)
    WriteCharEntity(wch)
      => ComCall(9, this.p, UInt16, wch)
    WriteChars(pwch?)
      => ComCall(10, this.p, "Str", pwch?, UInt32, pwch?.Length ?? 0)
    WriteComment(pwszComment?)
      => ComCall(11, this.p, "Str", pwszComment?)
    WriteDocType(pwszName?, pwszPublicId?, pwszSystemId?, pwszSubset?)
      => ComCall(12, this.p, "Str", pwszName?, "Str", pwszPublicId?, "Str", pwszSystemId?, "Str", pwszSubset?)
    WriteElementString(pwszQName, pwszValue?)
      => ComCall(13, this.p, "Str", pwszQName, UInt32, pwszQName.Length, "Str", pwszValue?)
    WriteEndDocument()
      => ComCall(14, this.p)
    WriteEndElement(pwszQName)
      => ComCall(15, this.p, "Str", pwszQName, UInt32, pwszQName.Length)
    WriteEntityRef(pwszName)
      => ComCall(16, this.p, "Str", pwszName)
    WriteFullEndElement(pwszQName)
      => ComCall(17, this.p, "Str", pwszQName, UInt32, pwszQName.Length)
    WriteName(pwszName)
      => ComCall(18, this.p, "Str", pwszName)
    WriteNmToken(pwszNmToken)
      => ComCall(19, this.p, "Str", pwszNmToken)
    WriteNode(pReader, fWriteDefaultAttributes)
      => ComCall(20, this.p, IXmlReader, pReader, BOOL, fWriteDefaultAttributes)
    WriteNodeShallow(pReader, fWriteDefaultAttributes)
      => ComCall(21, this.p, IXmlReader, pReader, BOOL, fWriteDefaultAttributes)
    WriteProcessingInstruction(pwszName, pwszText?)
      => ComCall(22, this.p, "Str", pwszName, "Str", pwszText?)
    WriteRaw(pwszData?)
      => ComCall(23, this.p, "Str", pwszData?)
    WriteRawChars(pwch?)
      => ComCall(24, this.p, "Str", pwch?, UInt32, pwch?.Length ?? 0)
    WriteStartDocument(standalone)
      => ComCall(25, this.p, XmlStandalone, standalone)
    WriteStartElement(pwszQName)
      => ComCall(26, this.p, "Str", pwszQName, UInt32, pwszQName.Length)
    WriteString(pwszText?)
      => ComCall(27, this.p, "Str", pwszText?)
    WriteSurrogateCharEntity(wchLow, wchHigh)
      => ComCall(28, this.p, UInt16, wchLow, UInt16, wchHigh)
    WriteWhitespace(pwszWhitespace?)
      => ComCall(29, this.p, "Str", pwszWhitespace?)
    Flush()
      => ComCall(30, this.p)
}
