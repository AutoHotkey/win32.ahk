#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, FILETIME, HRESULT, PWSTR, VARIANT_BOOL}
#Import "..\System.Com\Types.ahk" {IDispatch, ISequentialStream, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct XML_ERROR {
    _nLine : UInt32
    _pchBuf : BSTR
    _cchBuf : UInt32
    _ich : UInt32
    _pszFound : BSTR
    _pszExpected : BSTR
    _reserved1 : UInt32
    _reserved2 : UInt32
}
struct DOMNodeType extends Int32 {
    static NODE_INVALID := 0
    static NODE_ELEMENT := 1
    static NODE_ATTRIBUTE := 2
    static NODE_TEXT := 3
    static NODE_CDATA_SECTION := 4
    static NODE_ENTITY_REFERENCE := 5
    static NODE_ENTITY := 6
    static NODE_PROCESSING_INSTRUCTION := 7
    static NODE_COMMENT := 8
    static NODE_DOCUMENT := 9
    static NODE_DOCUMENT_TYPE := 10
    static NODE_DOCUMENT_FRAGMENT := 11
    static NODE_NOTATION := 12
}
struct XMLELEM_TYPE extends Int32 {
    static XMLELEMTYPE_ELEMENT := 0
    static XMLELEMTYPE_TEXT := 1
    static XMLELEMTYPE_COMMENT := 2
    static XMLELEMTYPE_DOCUMENT := 3
    static XMLELEMTYPE_DTD := 4
    static XMLELEMTYPE_PI := 5
    static XMLELEMTYPE_OTHER := 6
}
struct IXMLDOMImplementation extends IDispatch {
    static IID := "{2933BF8F-7B36-11D2-B20E-00C04F983E60}"
    hasFeature(feature, version, hasFeature)
      => ComCall(7, this.p, BSTR, feature, BSTR, version, VARIANT_BOOL.Ptr, hasFeature)
}
struct IXMLDOMNode extends IDispatch {
    static IID := "{2933BF80-7B36-11D2-B20E-00C04F983E60}"
    get_nodeName(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    get_nodeValue(value)
      => ComCall(8, this.p, VARIANT.Ptr, value)
    put_nodeValue(value)
      => ComCall(9, this.p, VARIANT, value)
    get_nodeType(type)
      => ComCall(10, this.p, DOMNodeType.Ptr, type)
    get_parentNode(parent)
      => ComCall(11, this.p, IXMLDOMNode.Ptr, parent)
    get_childNodes(childList)
      => ComCall(12, this.p, IXMLDOMNodeList.Ptr, childList)
    get_firstChild(firstChild)
      => ComCall(13, this.p, IXMLDOMNode.Ptr, firstChild)
    get_lastChild(lastChild)
      => ComCall(14, this.p, IXMLDOMNode.Ptr, lastChild)
    get_previousSibling(previousSibling)
      => ComCall(15, this.p, IXMLDOMNode.Ptr, previousSibling)
    get_nextSibling(nextSibling)
      => ComCall(16, this.p, IXMLDOMNode.Ptr, nextSibling)
    get_attributes(attributeMap)
      => ComCall(17, this.p, IXMLDOMNamedNodeMap.Ptr, attributeMap)
    insertBefore(newChild, refChild, outNewChild)
      => ComCall(18, this.p, IXMLDOMNode, newChild, VARIANT, refChild, IXMLDOMNode.Ptr, outNewChild)
    replaceChild(newChild, oldChild, outOldChild)
      => ComCall(19, this.p, IXMLDOMNode, newChild, IXMLDOMNode, oldChild, IXMLDOMNode.Ptr, outOldChild)
    removeChild(childNode, oldChild)
      => ComCall(20, this.p, IXMLDOMNode, childNode, IXMLDOMNode.Ptr, oldChild)
    appendChild(newChild, outNewChild)
      => ComCall(21, this.p, IXMLDOMNode, newChild, IXMLDOMNode.Ptr, outNewChild)
    hasChildNodes(hasChild)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, hasChild)
    get_ownerDocument(XMLDOMDocument)
      => ComCall(23, this.p, IXMLDOMDocument.Ptr, XMLDOMDocument)
    cloneNode(deep, cloneRoot)
      => ComCall(24, this.p, VARIANT_BOOL, deep, IXMLDOMNode.Ptr, cloneRoot)
    get_nodeTypeString(nodeType)
      => ComCall(25, this.p, BSTR.Ptr, nodeType)
    get_text(text)
      => ComCall(26, this.p, BSTR.Ptr, text)
    put_text(text)
      => ComCall(27, this.p, BSTR, text)
    get_specified(isSpecified)
      => ComCall(28, this.p, VARIANT_BOOL.Ptr, isSpecified)
    get_definition(definitionNode)
      => ComCall(29, this.p, IXMLDOMNode.Ptr, definitionNode)
    get_nodeTypedValue(typedValue)
      => ComCall(30, this.p, VARIANT.Ptr, typedValue)
    put_nodeTypedValue(typedValue)
      => ComCall(31, this.p, VARIANT, typedValue)
    get_dataType(dataTypeName)
      => ComCall(32, this.p, VARIANT.Ptr, dataTypeName)
    put_dataType(dataTypeName)
      => ComCall(33, this.p, BSTR, dataTypeName)
    get_xml(xmlString)
      => ComCall(34, this.p, BSTR.Ptr, xmlString)
    transformNode(stylesheet, xmlString)
      => ComCall(35, this.p, IXMLDOMNode, stylesheet, BSTR.Ptr, xmlString)
    selectNodes(queryString, resultList)
      => ComCall(36, this.p, BSTR, queryString, IXMLDOMNodeList.Ptr, resultList)
    selectSingleNode(queryString, resultNode)
      => ComCall(37, this.p, BSTR, queryString, IXMLDOMNode.Ptr, resultNode)
    get_parsed(isParsed)
      => ComCall(38, this.p, VARIANT_BOOL.Ptr, isParsed)
    get_namespaceURI(namespaceURI)
      => ComCall(39, this.p, BSTR.Ptr, namespaceURI)
    get_prefix(prefixString)
      => ComCall(40, this.p, BSTR.Ptr, prefixString)
    get_baseName(nameString)
      => ComCall(41, this.p, BSTR.Ptr, nameString)
    transformNodeToObject(stylesheet, outputObject)
      => ComCall(42, this.p, IXMLDOMNode, stylesheet, VARIANT, outputObject)
}
struct IXMLDOMDocumentFragment extends IXMLDOMNode {
    static IID := "{3EFAA413-272F-11D2-836F-0000F87A7782}"
}
struct IXMLDOMDocument extends IXMLDOMNode {
    static IID := "{2933BF81-7B36-11D2-B20E-00C04F983E60}"
    get_doctype(documentType)
      => ComCall(43, this.p, IXMLDOMDocumentType.Ptr, documentType)
    get_implementation(impl)
      => ComCall(44, this.p, IXMLDOMImplementation.Ptr, impl)
    get_documentElement(DOMElement)
      => ComCall(45, this.p, IXMLDOMElement.Ptr, DOMElement)
    putref_documentElement(DOMElement)
      => ComCall(46, this.p, IXMLDOMElement, DOMElement)
    createElement(tagName, element)
      => ComCall(47, this.p, BSTR, tagName, IXMLDOMElement.Ptr, element)
    createDocumentFragment(docFrag)
      => ComCall(48, this.p, IXMLDOMDocumentFragment.Ptr, docFrag)
    createTextNode(data, text)
      => ComCall(49, this.p, BSTR, data, IXMLDOMText.Ptr, text)
    createComment(data, comment)
      => ComCall(50, this.p, BSTR, data, IXMLDOMComment.Ptr, comment)
    createCDATASection(data, cdata)
      => ComCall(51, this.p, BSTR, data, IXMLDOMCDATASection.Ptr, cdata)
    createProcessingInstruction(target, data, pi)
      => ComCall(52, this.p, BSTR, target, BSTR, data, IXMLDOMProcessingInstruction.Ptr, pi)
    createAttribute(name, attribute)
      => ComCall(53, this.p, BSTR, name, IXMLDOMAttribute.Ptr, attribute)
    createEntityReference(name, entityRef)
      => ComCall(54, this.p, BSTR, name, IXMLDOMEntityReference.Ptr, entityRef)
    getElementsByTagName(tagName, resultList)
      => ComCall(55, this.p, BSTR, tagName, IXMLDOMNodeList.Ptr, resultList)
    createNode(Type, name, namespaceURI, node)
      => ComCall(56, this.p, VARIANT, Type, BSTR, name, BSTR, namespaceURI, IXMLDOMNode.Ptr, node)
    nodeFromID(idString, node)
      => ComCall(57, this.p, BSTR, idString, IXMLDOMNode.Ptr, node)
    load(xmlSource, isSuccessful)
      => ComCall(58, this.p, VARIANT, xmlSource, VARIANT_BOOL.Ptr, isSuccessful)
    get_readyState(value)
      => ComCall(59, this.p, Int32.Ptr, value)
    get_parseError(errorObj)
      => ComCall(60, this.p, IXMLDOMParseError.Ptr, errorObj)
    get_url(urlString)
      => ComCall(61, this.p, BSTR.Ptr, urlString)
    get_async(isAsync)
      => ComCall(62, this.p, VARIANT_BOOL.Ptr, isAsync)
    put_async(isAsync)
      => ComCall(63, this.p, VARIANT_BOOL, isAsync)
    abort()
      => ComCall(64, this.p)
    loadXML(bstrXML, isSuccessful)
      => ComCall(65, this.p, BSTR, bstrXML, VARIANT_BOOL.Ptr, isSuccessful)
    save(destination)
      => ComCall(66, this.p, VARIANT, destination)
    get_validateOnParse(isValidating)
      => ComCall(67, this.p, VARIANT_BOOL.Ptr, isValidating)
    put_validateOnParse(isValidating)
      => ComCall(68, this.p, VARIANT_BOOL, isValidating)
    get_resolveExternals(isResolving)
      => ComCall(69, this.p, VARIANT_BOOL.Ptr, isResolving)
    put_resolveExternals(isResolving)
      => ComCall(70, this.p, VARIANT_BOOL, isResolving)
    get_preserveWhiteSpace(isPreserving)
      => ComCall(71, this.p, VARIANT_BOOL.Ptr, isPreserving)
    put_preserveWhiteSpace(isPreserving)
      => ComCall(72, this.p, VARIANT_BOOL, isPreserving)
    put_onreadystatechange(readystatechangeSink)
      => ComCall(73, this.p, VARIANT, readystatechangeSink)
    put_ondataavailable(ondataavailableSink)
      => ComCall(74, this.p, VARIANT, ondataavailableSink)
    put_ontransformnode(ontransformnodeSink)
      => ComCall(75, this.p, VARIANT, ontransformnodeSink)
}
struct IXMLDOMNodeList extends IDispatch {
    static IID := "{2933BF82-7B36-11D2-B20E-00C04F983E60}"
    get_item(index, listItem)
      => ComCall(7, this.p, Int32, index, IXMLDOMNode.Ptr, listItem)
    get_length(listLength)
      => ComCall(8, this.p, Int32.Ptr, listLength)
    nextNode(nextItem)
      => ComCall(9, this.p, IXMLDOMNode.Ptr, nextItem)
    reset()
      => ComCall(10, this.p)
    get__newEnum(ppUnk)
      => ComCall(11, this.p, IUnknown.Ptr, ppUnk)
}
struct IXMLDOMNamedNodeMap extends IDispatch {
    static IID := "{2933BF83-7B36-11D2-B20E-00C04F983E60}"
    getNamedItem(name, namedItem)
      => ComCall(7, this.p, BSTR, name, IXMLDOMNode.Ptr, namedItem)
    setNamedItem(newItem, nameItem)
      => ComCall(8, this.p, IXMLDOMNode, newItem, IXMLDOMNode.Ptr, nameItem)
    removeNamedItem(name, namedItem)
      => ComCall(9, this.p, BSTR, name, IXMLDOMNode.Ptr, namedItem)
    get_item(index, listItem)
      => ComCall(10, this.p, Int32, index, IXMLDOMNode.Ptr, listItem)
    get_length(listLength)
      => ComCall(11, this.p, Int32.Ptr, listLength)
    getQualifiedItem(baseName, namespaceURI, qualifiedItem)
      => ComCall(12, this.p, BSTR, baseName, BSTR, namespaceURI, IXMLDOMNode.Ptr, qualifiedItem)
    removeQualifiedItem(baseName, namespaceURI, qualifiedItem)
      => ComCall(13, this.p, BSTR, baseName, BSTR, namespaceURI, IXMLDOMNode.Ptr, qualifiedItem)
    nextNode(nextItem)
      => ComCall(14, this.p, IXMLDOMNode.Ptr, nextItem)
    reset()
      => ComCall(15, this.p)
    get__newEnum(ppUnk)
      => ComCall(16, this.p, IUnknown.Ptr, ppUnk)
}
struct IXMLDOMCharacterData extends IXMLDOMNode {
    static IID := "{2933BF84-7B36-11D2-B20E-00C04F983E60}"
    get_data(data)
      => ComCall(43, this.p, BSTR.Ptr, data)
    put_data(data)
      => ComCall(44, this.p, BSTR, data)
    get_length(dataLength)
      => ComCall(45, this.p, Int32.Ptr, dataLength)
    substringData(offset, count, data)
      => ComCall(46, this.p, Int32, offset, Int32, count, BSTR.Ptr, data)
    appendData(data)
      => ComCall(47, this.p, BSTR, data)
    insertData(offset, data)
      => ComCall(48, this.p, Int32, offset, BSTR, data)
    deleteData(offset, count)
      => ComCall(49, this.p, Int32, offset, Int32, count)
    replaceData(offset, count, data)
      => ComCall(50, this.p, Int32, offset, Int32, count, BSTR, data)
}
struct IXMLDOMAttribute extends IXMLDOMNode {
    static IID := "{2933BF85-7B36-11D2-B20E-00C04F983E60}"
    get_name(attributeName)
      => ComCall(43, this.p, BSTR.Ptr, attributeName)
    get_value(attributeValue)
      => ComCall(44, this.p, VARIANT.Ptr, attributeValue)
    put_value(attributeValue)
      => ComCall(45, this.p, VARIANT, attributeValue)
}
struct IXMLDOMElement extends IXMLDOMNode {
    static IID := "{2933BF86-7B36-11D2-B20E-00C04F983E60}"
    get_tagName(tagName)
      => ComCall(43, this.p, BSTR.Ptr, tagName)
    getAttribute(name, value)
      => ComCall(44, this.p, BSTR, name, VARIANT.Ptr, value)
    setAttribute(name, value)
      => ComCall(45, this.p, BSTR, name, VARIANT, value)
    removeAttribute(name)
      => ComCall(46, this.p, BSTR, name)
    getAttributeNode(name, attributeNode)
      => ComCall(47, this.p, BSTR, name, IXMLDOMAttribute.Ptr, attributeNode)
    setAttributeNode(DOMAttribute, attributeNode)
      => ComCall(48, this.p, IXMLDOMAttribute, DOMAttribute, IXMLDOMAttribute.Ptr, attributeNode)
    removeAttributeNode(DOMAttribute, attributeNode)
      => ComCall(49, this.p, IXMLDOMAttribute, DOMAttribute, IXMLDOMAttribute.Ptr, attributeNode)
    getElementsByTagName(tagName, resultList)
      => ComCall(50, this.p, BSTR, tagName, IXMLDOMNodeList.Ptr, resultList)
    normalize()
      => ComCall(51, this.p)
}
struct IXMLDOMText extends IXMLDOMCharacterData {
    static IID := "{2933BF87-7B36-11D2-B20E-00C04F983E60}"
    splitText(offset, rightHandTextNode)
      => ComCall(51, this.p, Int32, offset, IXMLDOMText.Ptr, rightHandTextNode)
}
struct IXMLDOMComment extends IXMLDOMCharacterData {
    static IID := "{2933BF88-7B36-11D2-B20E-00C04F983E60}"
}
struct IXMLDOMProcessingInstruction extends IXMLDOMNode {
    static IID := "{2933BF89-7B36-11D2-B20E-00C04F983E60}"
    get_target(name)
      => ComCall(43, this.p, BSTR.Ptr, name)
    get_data(value)
      => ComCall(44, this.p, BSTR.Ptr, value)
    put_data(value)
      => ComCall(45, this.p, BSTR, value)
}
struct IXMLDOMCDATASection extends IXMLDOMText {
    static IID := "{2933BF8A-7B36-11D2-B20E-00C04F983E60}"
}
struct IXMLDOMDocumentType extends IXMLDOMNode {
    static IID := "{2933BF8B-7B36-11D2-B20E-00C04F983E60}"
    get_name(rootName)
      => ComCall(43, this.p, BSTR.Ptr, rootName)
    get_entities(entityMap)
      => ComCall(44, this.p, IXMLDOMNamedNodeMap.Ptr, entityMap)
    get_notations(notationMap)
      => ComCall(45, this.p, IXMLDOMNamedNodeMap.Ptr, notationMap)
}
struct IXMLDOMNotation extends IXMLDOMNode {
    static IID := "{2933BF8C-7B36-11D2-B20E-00C04F983E60}"
    get_publicId(publicID)
      => ComCall(43, this.p, VARIANT.Ptr, publicID)
    get_systemId(systemID)
      => ComCall(44, this.p, VARIANT.Ptr, systemID)
}
struct IXMLDOMEntity extends IXMLDOMNode {
    static IID := "{2933BF8D-7B36-11D2-B20E-00C04F983E60}"
    get_publicId(publicID)
      => ComCall(43, this.p, VARIANT.Ptr, publicID)
    get_systemId(systemID)
      => ComCall(44, this.p, VARIANT.Ptr, systemID)
    get_notationName(name)
      => ComCall(45, this.p, BSTR.Ptr, name)
}
struct IXMLDOMEntityReference extends IXMLDOMNode {
    static IID := "{2933BF8E-7B36-11D2-B20E-00C04F983E60}"
}
struct IXMLDOMParseError extends IDispatch {
    static IID := "{3EFAA426-272F-11D2-836F-0000F87A7782}"
    get_errorCode(errorCode)
      => ComCall(7, this.p, Int32.Ptr, errorCode)
    get_url(urlString)
      => ComCall(8, this.p, BSTR.Ptr, urlString)
    get_reason(reasonString)
      => ComCall(9, this.p, BSTR.Ptr, reasonString)
    get_srcText(sourceString)
      => ComCall(10, this.p, BSTR.Ptr, sourceString)
    get_line(lineNumber)
      => ComCall(11, this.p, Int32.Ptr, lineNumber)
    get_linepos(linePosition)
      => ComCall(12, this.p, Int32.Ptr, linePosition)
    get_filepos(filePosition)
      => ComCall(13, this.p, Int32.Ptr, filePosition)
}
struct IXTLRuntime extends IXMLDOMNode {
    static IID := "{3EFAA425-272F-11D2-836F-0000F87A7782}"
    uniqueID(pNode, pID)
      => ComCall(43, this.p, IXMLDOMNode, pNode, Int32.Ptr, pID)
    depth(pNode, pDepth)
      => ComCall(44, this.p, IXMLDOMNode, pNode, Int32.Ptr, pDepth)
    childNumber(pNode, pNumber)
      => ComCall(45, this.p, IXMLDOMNode, pNode, Int32.Ptr, pNumber)
    ancestorChildNumber(bstrNodeName, pNode, pNumber)
      => ComCall(46, this.p, BSTR, bstrNodeName, IXMLDOMNode, pNode, Int32.Ptr, pNumber)
    absoluteChildNumber(pNode, pNumber)
      => ComCall(47, this.p, IXMLDOMNode, pNode, Int32.Ptr, pNumber)
    formatIndex(lIndex, bstrFormat, pbstrFormattedString)
      => ComCall(48, this.p, Int32, lIndex, BSTR, bstrFormat, BSTR.Ptr, pbstrFormattedString)
    formatNumber(dblNumber, bstrFormat, pbstrFormattedString)
      => ComCall(49, this.p, Float64, dblNumber, BSTR, bstrFormat, BSTR.Ptr, pbstrFormattedString)
    formatDate(varDate, bstrFormat, varDestLocale, pbstrFormattedString)
      => ComCall(50, this.p, VARIANT, varDate, BSTR, bstrFormat, VARIANT, varDestLocale, BSTR.Ptr, pbstrFormattedString)
    formatTime(varTime, bstrFormat, varDestLocale, pbstrFormattedString)
      => ComCall(51, this.p, VARIANT, varTime, BSTR, bstrFormat, VARIANT, varDestLocale, BSTR.Ptr, pbstrFormattedString)
}
struct XMLDOMDocumentEvents extends IDispatch {
    static IID := "{3EFAA427-272F-11D2-836F-0000F87A7782}"
}
struct IXMLDSOControl extends IDispatch {
    static IID := "{310AFA62-0575-11D2-9CA9-0060B0EC3D39}"
    get_XMLDocument(ppDoc)
      => ComCall(7, this.p, IXMLDOMDocument.Ptr, ppDoc)
    put_XMLDocument(ppDoc)
      => ComCall(8, this.p, IXMLDOMDocument, ppDoc)
    get_JavaDSOCompatible(fJavaDSOCompatible)
      => ComCall(9, this.p, BOOL.Ptr, fJavaDSOCompatible)
    put_JavaDSOCompatible(fJavaDSOCompatible)
      => ComCall(10, this.p, BOOL, fJavaDSOCompatible)
    get_readyState(state)
      => ComCall(11, this.p, Int32.Ptr, state)
}
struct IXMLElementCollection extends IDispatch {
    static IID := "{65725580-9B5D-11D0-9BFE-00C04FC99C8E}"
    put_length(v)
      => ComCall(7, this.p, Int32, v)
    get_length(p)
      => ComCall(8, this.p, Int32.Ptr, p)
    get__newEnum(ppUnk)
      => ComCall(9, this.p, IUnknown.Ptr, ppUnk)
    item(var1, var2, ppDisp)
      => ComCall(10, this.p, VARIANT, var1, VARIANT, var2, IDispatch.Ptr, ppDisp)
}
struct IXMLDocument extends IDispatch {
    static IID := "{F52E2B61-18A1-11D1-B105-00805F49916B}"
    get_root(p)
      => ComCall(7, this.p, IXMLElement.Ptr, p)
    get_fileSize(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_fileModifiedDate(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_fileUpdatedDate(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    get_URL(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_URL(p)
      => ComCall(12, this.p, BSTR, p)
    get_mimeType(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
    get_readyState(pl)
      => ComCall(14, this.p, Int32.Ptr, pl)
    get_charset(p)
      => ComCall(15, this.p, BSTR.Ptr, p)
    put_charset(p)
      => ComCall(16, this.p, BSTR, p)
    get_version(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    get_doctype(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    get_dtdURL(p)
      => ComCall(19, this.p, BSTR.Ptr, p)
    createElement(vType, var1, ppElem)
      => ComCall(20, this.p, VARIANT, vType, VARIANT, var1, IXMLElement.Ptr, ppElem)
}
struct IXMLDocument2 extends IDispatch {
    static IID := "{2B8DE2FE-8D2D-11D1-B2FC-00C04FD915A9}"
    get_root(p)
      => ComCall(7, this.p, IXMLElement2.Ptr, p)
    get_fileSize(p)
      => ComCall(8, this.p, BSTR.Ptr, p)
    get_fileModifiedDate(p)
      => ComCall(9, this.p, BSTR.Ptr, p)
    get_fileUpdatedDate(p)
      => ComCall(10, this.p, BSTR.Ptr, p)
    get_URL(p)
      => ComCall(11, this.p, BSTR.Ptr, p)
    put_URL(p)
      => ComCall(12, this.p, BSTR, p)
    get_mimeType(p)
      => ComCall(13, this.p, BSTR.Ptr, p)
    get_readyState(pl)
      => ComCall(14, this.p, Int32.Ptr, pl)
    get_charset(p)
      => ComCall(15, this.p, BSTR.Ptr, p)
    put_charset(p)
      => ComCall(16, this.p, BSTR, p)
    get_version(p)
      => ComCall(17, this.p, BSTR.Ptr, p)
    get_doctype(p)
      => ComCall(18, this.p, BSTR.Ptr, p)
    get_dtdURL(p)
      => ComCall(19, this.p, BSTR.Ptr, p)
    createElement(vType, var1, ppElem)
      => ComCall(20, this.p, VARIANT, vType, VARIANT, var1, IXMLElement2.Ptr, ppElem)
    get_async(pf)
      => ComCall(21, this.p, VARIANT_BOOL.Ptr, pf)
    put_async(f)
      => ComCall(22, this.p, VARIANT_BOOL, f)
}
struct IXMLElement extends IDispatch {
    static IID := "{3F7F31AC-E15F-11D0-9C25-00C04FC99C8E}"
    get_tagName(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_tagName(p)
      => ComCall(8, this.p, BSTR, p)
    get_parent(ppParent)
      => ComCall(9, this.p, IXMLElement.Ptr, ppParent)
    setAttribute(strPropertyName, PropertyValue)
      => ComCall(10, this.p, BSTR, strPropertyName, VARIANT, PropertyValue)
    getAttribute(strPropertyName, PropertyValue)
      => ComCall(11, this.p, BSTR, strPropertyName, VARIANT.Ptr, PropertyValue)
    removeAttribute(strPropertyName)
      => ComCall(12, this.p, BSTR, strPropertyName)
    get_children(pp)
      => ComCall(13, this.p, IXMLElementCollection.Ptr, pp)
    get_type(plType)
      => ComCall(14, this.p, Int32.Ptr, plType)
    get_text(p)
      => ComCall(15, this.p, BSTR.Ptr, p)
    put_text(p)
      => ComCall(16, this.p, BSTR, p)
    addChild(pChildElem, lIndex, lReserved)
      => ComCall(17, this.p, IXMLElement, pChildElem, Int32, lIndex, Int32, lReserved)
    removeChild(pChildElem)
      => ComCall(18, this.p, IXMLElement, pChildElem)
}
struct IXMLElement2 extends IDispatch {
    static IID := "{2B8DE2FF-8D2D-11D1-B2FC-00C04FD915A9}"
    get_tagName(p)
      => ComCall(7, this.p, BSTR.Ptr, p)
    put_tagName(p)
      => ComCall(8, this.p, BSTR, p)
    get_parent(ppParent)
      => ComCall(9, this.p, IXMLElement2.Ptr, ppParent)
    setAttribute(strPropertyName, PropertyValue)
      => ComCall(10, this.p, BSTR, strPropertyName, VARIANT, PropertyValue)
    getAttribute(strPropertyName, PropertyValue)
      => ComCall(11, this.p, BSTR, strPropertyName, VARIANT.Ptr, PropertyValue)
    removeAttribute(strPropertyName)
      => ComCall(12, this.p, BSTR, strPropertyName)
    get_children(pp)
      => ComCall(13, this.p, IXMLElementCollection.Ptr, pp)
    get_type(plType)
      => ComCall(14, this.p, Int32.Ptr, plType)
    get_text(p)
      => ComCall(15, this.p, BSTR.Ptr, p)
    put_text(p)
      => ComCall(16, this.p, BSTR, p)
    addChild(pChildElem, lIndex, lReserved)
      => ComCall(17, this.p, IXMLElement2, pChildElem, Int32, lIndex, Int32, lReserved)
    removeChild(pChildElem)
      => ComCall(18, this.p, IXMLElement2, pChildElem)
    get_attributes(pp)
      => ComCall(19, this.p, IXMLElementCollection.Ptr, pp)
}
struct IXMLAttribute extends IDispatch {
    static IID := "{D4D4A0FC-3B73-11D1-B2B4-00C04FB92596}"
    get_name(n)
      => ComCall(7, this.p, BSTR.Ptr, n)
    get_value(v)
      => ComCall(8, this.p, BSTR.Ptr, v)
}
struct IXMLError extends IUnknown {
    static IID := "{948C5AD3-C58D-11D0-9C0B-00C04FC99C8E}"
    GetErrorInfo(pErrorReturn)
      => ComCall(3, this.p, XML_ERROR.Ptr, pErrorReturn)
}
struct IXMLDOMDocument2 extends IXMLDOMDocument {
    static IID := "{2933BF95-7B36-11D2-B20E-00C04F983E60}"
    get_namespaces(namespaceCollection)
      => ComCall(76, this.p, IXMLDOMSchemaCollection.Ptr, namespaceCollection)
    get_schemas(otherCollection)
      => ComCall(77, this.p, VARIANT.Ptr, otherCollection)
    putref_schemas(otherCollection)
      => ComCall(78, this.p, VARIANT, otherCollection)
    validate(errorObj)
      => ComCall(79, this.p, IXMLDOMParseError.Ptr, errorObj)
    setProperty(name, value)
      => ComCall(80, this.p, BSTR, name, VARIANT, value)
    getProperty(name, value)
      => ComCall(81, this.p, BSTR, name, VARIANT.Ptr, value)
}
struct IXMLDOMDocument3 extends IXMLDOMDocument2 {
    static IID := "{2933BF96-7B36-11D2-B20E-00C04F983E60}"
    validateNode(node, errorObj)
      => ComCall(82, this.p, IXMLDOMNode, node, IXMLDOMParseError.Ptr, errorObj)
    importNode(node, deep, clone)
      => ComCall(83, this.p, IXMLDOMNode, node, VARIANT_BOOL, deep, IXMLDOMNode.Ptr, clone)
}
struct IXMLDOMSchemaCollection extends IDispatch {
    static IID := "{373984C8-B845-449B-91E7-45AC83036ADE}"
    add(namespaceURI, var)
      => ComCall(7, this.p, BSTR, namespaceURI, VARIANT, var)
    get(namespaceURI, schemaNode)
      => ComCall(8, this.p, BSTR, namespaceURI, IXMLDOMNode.Ptr, schemaNode)
    remove(namespaceURI)
      => ComCall(9, this.p, BSTR, namespaceURI)
    get_length(length)
      => ComCall(10, this.p, Int32.Ptr, length)
    get_namespaceURI(index, length)
      => ComCall(11, this.p, Int32, index, BSTR.Ptr, length)
    addCollection(otherCollection)
      => ComCall(12, this.p, IXMLDOMSchemaCollection, otherCollection)
    get__newEnum(ppUnk)
      => ComCall(13, this.p, IUnknown.Ptr, ppUnk)
}
struct IXMLDOMSelection extends IXMLDOMNodeList {
    static IID := "{AA634FC7-5888-44A7-A257-3A47150D3A0E}"
    get_expr(expression)
      => ComCall(12, this.p, BSTR.Ptr, expression)
    put_expr(expression)
      => ComCall(13, this.p, BSTR, expression)
    get_context(ppNode)
      => ComCall(14, this.p, IXMLDOMNode.Ptr, ppNode)
    putref_context(pNode)
      => ComCall(15, this.p, IXMLDOMNode, pNode)
    peekNode(ppNode)
      => ComCall(16, this.p, IXMLDOMNode.Ptr, ppNode)
    matches(pNode, ppNode)
      => ComCall(17, this.p, IXMLDOMNode, pNode, IXMLDOMNode.Ptr, ppNode)
    removeNext(ppNode)
      => ComCall(18, this.p, IXMLDOMNode.Ptr, ppNode)
    removeAll()
      => ComCall(19, this.p)
    clone(ppNode)
      => ComCall(20, this.p, IXMLDOMSelection.Ptr, ppNode)
    getProperty(name, value)
      => ComCall(21, this.p, BSTR, name, VARIANT.Ptr, value)
    setProperty(name, value)
      => ComCall(22, this.p, BSTR, name, VARIANT, value)
}
struct IXMLDOMParseError2 extends IXMLDOMParseError {
    static IID := "{3EFAA428-272F-11D2-836F-0000F87A7782}"
    get_errorXPath(xpathexpr)
      => ComCall(14, this.p, BSTR.Ptr, xpathexpr)
    get_allErrors(allErrors)
      => ComCall(15, this.p, IXMLDOMParseErrorCollection.Ptr, allErrors)
    errorParameters(index, param1)
      => ComCall(16, this.p, Int32, index, BSTR.Ptr, param1)
    get_errorParametersCount(count)
      => ComCall(17, this.p, Int32.Ptr, count)
}
struct IXMLDOMParseErrorCollection extends IDispatch {
    static IID := "{3EFAA429-272F-11D2-836F-0000F87A7782}"
    get_item(index, error)
      => ComCall(7, this.p, Int32, index, IXMLDOMParseError2.Ptr, error)
    get_length(length)
      => ComCall(8, this.p, Int32.Ptr, length)
    get_next(error)
      => ComCall(9, this.p, IXMLDOMParseError2.Ptr, error)
    reset()
      => ComCall(10, this.p)
    get__newEnum(ppunk)
      => ComCall(11, this.p, IUnknown.Ptr, ppunk)
}
struct IXSLProcessor extends IDispatch {
    static IID := "{2933BF92-7B36-11D2-B20E-00C04F983E60}"
    put_input(var)
      => ComCall(7, this.p, VARIANT, var)
    get_input(pVar)
      => ComCall(8, this.p, VARIANT.Ptr, pVar)
    get_ownerTemplate(ppTemplate)
      => ComCall(9, this.p, IXSLTemplate.Ptr, ppTemplate)
    setStartMode(mode, namespaceURI)
      => ComCall(10, this.p, BSTR, mode, BSTR, namespaceURI)
    get_startMode(mode)
      => ComCall(11, this.p, BSTR.Ptr, mode)
    get_startModeURI(namespaceURI)
      => ComCall(12, this.p, BSTR.Ptr, namespaceURI)
    put_output(output)
      => ComCall(13, this.p, VARIANT, output)
    get_output(pOutput)
      => ComCall(14, this.p, VARIANT.Ptr, pOutput)
    transform(pDone)
      => ComCall(15, this.p, VARIANT_BOOL.Ptr, pDone)
    reset()
      => ComCall(16, this.p)
    get_readyState(pReadyState)
      => ComCall(17, this.p, Int32.Ptr, pReadyState)
    addParameter(baseName, parameter, namespaceURI)
      => ComCall(18, this.p, BSTR, baseName, VARIANT, parameter, BSTR, namespaceURI)
    addObject(obj, namespaceURI)
      => ComCall(19, this.p, IDispatch, obj, BSTR, namespaceURI)
    get_stylesheet(stylesheet)
      => ComCall(20, this.p, IXMLDOMNode.Ptr, stylesheet)
}
struct IXSLTemplate extends IDispatch {
    static IID := "{2933BF93-7B36-11D2-B20E-00C04F983E60}"
    putref_stylesheet(stylesheet)
      => ComCall(7, this.p, IXMLDOMNode, stylesheet)
    get_stylesheet(stylesheet)
      => ComCall(8, this.p, IXMLDOMNode.Ptr, stylesheet)
    createProcessor(ppProcessor)
      => ComCall(9, this.p, IXSLProcessor.Ptr, ppProcessor)
}
struct IXMLHTTPRequest extends IDispatch {
    static IID := "{ED8C108D-4349-11D2-91A4-00C04F7969E8}"
    open(bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword)
      => ComCall(7, this.p, BSTR, bstrMethod, BSTR, bstrUrl, VARIANT, varAsync, VARIANT, bstrUser, VARIANT, bstrPassword)
    setRequestHeader(bstrHeader, bstrValue)
      => ComCall(8, this.p, BSTR, bstrHeader, BSTR, bstrValue)
    getResponseHeader(bstrHeader, pbstrValue)
      => ComCall(9, this.p, BSTR, bstrHeader, BSTR.Ptr, pbstrValue)
    getAllResponseHeaders(pbstrHeaders)
      => ComCall(10, this.p, BSTR.Ptr, pbstrHeaders)
    send(varBody)
      => ComCall(11, this.p, VARIANT, varBody)
    abort()
      => ComCall(12, this.p)
    get_status(plStatus)
      => ComCall(13, this.p, Int32.Ptr, plStatus)
    get_statusText(pbstrStatus)
      => ComCall(14, this.p, BSTR.Ptr, pbstrStatus)
    get_responseXML(ppBody)
      => ComCall(15, this.p, IDispatch.Ptr, ppBody)
    get_responseText(pbstrBody)
      => ComCall(16, this.p, BSTR.Ptr, pbstrBody)
    get_responseBody(pvarBody)
      => ComCall(17, this.p, VARIANT.Ptr, pvarBody)
    get_responseStream(pvarBody)
      => ComCall(18, this.p, VARIANT.Ptr, pvarBody)
    get_readyState(plState)
      => ComCall(19, this.p, Int32.Ptr, plState)
    put_onreadystatechange(pReadyStateSink)
      => ComCall(20, this.p, IDispatch, pReadyStateSink)
}
struct SERVERXMLHTTP_OPTION extends Int32 {
    static SXH_OPTION_URL := -1
    static SXH_OPTION_URL_CODEPAGE := 0
    static SXH_OPTION_ESCAPE_PERCENT_IN_URL := 1
    static SXH_OPTION_IGNORE_SERVER_SSL_CERT_ERROR_FLAGS := 2
    static SXH_OPTION_SELECT_CLIENT_SSL_CERT := 3
}
struct SXH_SERVER_CERT_OPTION extends Int32 {
    static SXH_SERVER_CERT_IGNORE_UNKNOWN_CA := 256
    static SXH_SERVER_CERT_IGNORE_WRONG_USAGE := 512
    static SXH_SERVER_CERT_IGNORE_CERT_CN_INVALID := 4096
    static SXH_SERVER_CERT_IGNORE_CERT_DATE_INVALID := 8192
    static SXH_SERVER_CERT_IGNORE_ALL_SERVER_ERRORS := 13056
}
struct SXH_PROXY_SETTING extends Int32 {
    static SXH_PROXY_SET_DEFAULT := 0
    static SXH_PROXY_SET_PRECONFIG := 0
    static SXH_PROXY_SET_DIRECT := 1
    static SXH_PROXY_SET_PROXY := 2
}
struct IServerXMLHTTPRequest extends IXMLHTTPRequest {
    static IID := "{2E9196BF-13BA-4DD4-91CA-6C571F281495}"
    setTimeouts(resolveTimeout, connectTimeout, sendTimeout, receiveTimeout)
      => ComCall(21, this.p, Int32, resolveTimeout, Int32, connectTimeout, Int32, sendTimeout, Int32, receiveTimeout)
    waitForResponse(timeoutInSeconds, isSuccessful)
      => ComCall(22, this.p, VARIANT, timeoutInSeconds, VARIANT_BOOL.Ptr, isSuccessful)
    getOption(option, value)
      => ComCall(23, this.p, SERVERXMLHTTP_OPTION, option, VARIANT.Ptr, value)
    setOption(option, value)
      => ComCall(24, this.p, SERVERXMLHTTP_OPTION, option, VARIANT, value)
}
struct IServerXMLHTTPRequest2 extends IServerXMLHTTPRequest {
    static IID := "{2E01311B-C322-4B0A-BD77-B90CFDC8DCE7}"
    setProxy(proxySetting, varProxyServer, varBypassList)
      => ComCall(25, this.p, SXH_PROXY_SETTING, proxySetting, VARIANT, varProxyServer, VARIANT, varBypassList)
    setProxyCredentials(bstrUserName, bstrPassword)
      => ComCall(26, this.p, BSTR, bstrUserName, BSTR, bstrPassword)
}
struct ISAXXMLReader extends IUnknown {
    static IID := "{A4F96ED0-F829-476E-81C0-CDC7BD2A0802}"
    getFeature(pwchName, pvfValue)
      => ComCall(3, this.p, "Str", pwchName, VARIANT_BOOL.Ptr, pvfValue)
    putFeature(pwchName, vfValue)
      => ComCall(4, this.p, "Str", pwchName, VARIANT_BOOL, vfValue)
    getProperty(pwchName, pvarValue)
      => ComCall(5, this.p, "Str", pwchName, VARIANT.Ptr, pvarValue)
    putProperty(pwchName, varValue)
      => ComCall(6, this.p, "Str", pwchName, VARIANT, varValue)
    getEntityResolver(ppResolver)
      => ComCall(7, this.p, ISAXEntityResolver.Ptr, ppResolver)
    putEntityResolver(pResolver)
      => ComCall(8, this.p, ISAXEntityResolver, pResolver)
    getContentHandler(ppHandler)
      => ComCall(9, this.p, ISAXContentHandler.Ptr, ppHandler)
    putContentHandler(pHandler)
      => ComCall(10, this.p, ISAXContentHandler, pHandler)
    getDTDHandler(ppHandler)
      => ComCall(11, this.p, ISAXDTDHandler.Ptr, ppHandler)
    putDTDHandler(pHandler)
      => ComCall(12, this.p, ISAXDTDHandler, pHandler)
    getErrorHandler(ppHandler)
      => ComCall(13, this.p, ISAXErrorHandler.Ptr, ppHandler)
    putErrorHandler(pHandler)
      => ComCall(14, this.p, ISAXErrorHandler, pHandler)
    getBaseURL(ppwchBaseUrl)
      => ComCall(15, this.p, UInt16.Ptr.Ptr, ppwchBaseUrl)
    putBaseURL(pwchBaseUrl)
      => ComCall(16, this.p, "Str", pwchBaseUrl)
    getSecureBaseURL(ppwchSecureBaseUrl)
      => ComCall(17, this.p, UInt16.Ptr.Ptr, ppwchSecureBaseUrl)
    putSecureBaseURL(pwchSecureBaseUrl)
      => ComCall(18, this.p, "Str", pwchSecureBaseUrl)
    parse(varInput)
      => ComCall(19, this.p, VARIANT, varInput)
    parseURL(pwchUrl)
      => ComCall(20, this.p, "Str", pwchUrl)
}
struct ISAXXMLFilter extends ISAXXMLReader {
    static IID := "{70409222-CA09-4475-ACB8-40312FE8D145}"
    getParent(ppReader)
      => ComCall(21, this.p, ISAXXMLReader.Ptr, ppReader)
    putParent(pReader)
      => ComCall(22, this.p, ISAXXMLReader, pReader)
}
struct ISAXLocator extends IUnknown {
    static IID := "{9B7E472A-0DE4-4640-BFF3-84D38A051C31}"
    getColumnNumber(pnColumn)
      => ComCall(3, this.p, Int32.Ptr, pnColumn)
    getLineNumber(pnLine)
      => ComCall(4, this.p, Int32.Ptr, pnLine)
    getPublicId(ppwchPublicId)
      => ComCall(5, this.p, UInt16.Ptr.Ptr, ppwchPublicId)
    getSystemId(ppwchSystemId)
      => ComCall(6, this.p, UInt16.Ptr.Ptr, ppwchSystemId)
}
struct ISAXEntityResolver extends IUnknown {
    static IID := "{99BCA7BD-E8C4-4D5F-A0CF-6D907901FF07}"
    resolveEntity(pwchPublicId, pwchSystemId, pvarInput)
      => ComCall(3, this.p, "Str", pwchPublicId, "Str", pwchSystemId, VARIANT.Ptr, pvarInput)
}
struct ISAXContentHandler extends IUnknown {
    static IID := "{1545CDFA-9E4E-4497-A8A4-2BF7D0112C44}"
    putDocumentLocator(pLocator)
      => ComCall(3, this.p, ISAXLocator, pLocator)
    startDocument()
      => ComCall(4, this.p)
    endDocument()
      => ComCall(5, this.p)
    startPrefixMapping(pwchPrefix, cchPrefix, pwchUri, cchUri)
      => ComCall(6, this.p, "Str", pwchPrefix, Int32, cchPrefix, "Str", pwchUri, Int32, cchUri)
    endPrefixMapping(pwchPrefix, cchPrefix)
      => ComCall(7, this.p, "Str", pwchPrefix, Int32, cchPrefix)
    startElement(pwchNamespaceUri, cchNamespaceUri, pwchLocalName, cchLocalName, pwchQName, cchQName, pAttributes)
      => ComCall(8, this.p, "Str", pwchNamespaceUri, Int32, cchNamespaceUri, "Str", pwchLocalName, Int32, cchLocalName, "Str", pwchQName, Int32, cchQName, ISAXAttributes, pAttributes)
    endElement(pwchNamespaceUri, cchNamespaceUri, pwchLocalName, cchLocalName, pwchQName, cchQName)
      => ComCall(9, this.p, "Str", pwchNamespaceUri, Int32, cchNamespaceUri, "Str", pwchLocalName, Int32, cchLocalName, "Str", pwchQName, Int32, cchQName)
    characters(pwchChars, cchChars)
      => ComCall(10, this.p, "Str", pwchChars, Int32, cchChars)
    ignorableWhitespace(pwchChars, cchChars)
      => ComCall(11, this.p, "Str", pwchChars, Int32, cchChars)
    processingInstruction(pwchTarget, cchTarget, pwchData, cchData)
      => ComCall(12, this.p, "Str", pwchTarget, Int32, cchTarget, "Str", pwchData, Int32, cchData)
    skippedEntity(pwchName, cchName)
      => ComCall(13, this.p, "Str", pwchName, Int32, cchName)
}
struct ISAXDTDHandler extends IUnknown {
    static IID := "{E15C1BAF-AFB3-4D60-8C36-19A8C45DEFED}"
    notationDecl(pwchName, cchName, pwchPublicId, cchPublicId, pwchSystemId, cchSystemId)
      => ComCall(3, this.p, "Str", pwchName, Int32, cchName, "Str", pwchPublicId, Int32, cchPublicId, "Str", pwchSystemId, Int32, cchSystemId)
    unparsedEntityDecl(pwchName, cchName, pwchPublicId, cchPublicId, pwchSystemId, cchSystemId, pwchNotationName, cchNotationName)
      => ComCall(4, this.p, "Str", pwchName, Int32, cchName, "Str", pwchPublicId, Int32, cchPublicId, "Str", pwchSystemId, Int32, cchSystemId, "Str", pwchNotationName, Int32, cchNotationName)
}
struct ISAXErrorHandler extends IUnknown {
    static IID := "{A60511C4-CCF5-479E-98A3-DC8DC545B7D0}"
    error(pLocator, pwchErrorMessage, hrErrorCode)
      => ComCall(3, this.p, ISAXLocator, pLocator, "Str", pwchErrorMessage, HRESULT, hrErrorCode)
    fatalError(pLocator, pwchErrorMessage, hrErrorCode)
      => ComCall(4, this.p, ISAXLocator, pLocator, "Str", pwchErrorMessage, HRESULT, hrErrorCode)
    ignorableWarning(pLocator, pwchErrorMessage, hrErrorCode)
      => ComCall(5, this.p, ISAXLocator, pLocator, "Str", pwchErrorMessage, HRESULT, hrErrorCode)
}
struct ISAXLexicalHandler extends IUnknown {
    static IID := "{7F85D5F5-47A8-4497-BDA5-84BA04819EA6}"
    startDTD(pwchName, cchName, pwchPublicId, cchPublicId, pwchSystemId, cchSystemId)
      => ComCall(3, this.p, "Str", pwchName, Int32, cchName, "Str", pwchPublicId, Int32, cchPublicId, "Str", pwchSystemId, Int32, cchSystemId)
    endDTD()
      => ComCall(4, this.p)
    startEntity(pwchName, cchName)
      => ComCall(5, this.p, "Str", pwchName, Int32, cchName)
    endEntity(pwchName, cchName)
      => ComCall(6, this.p, "Str", pwchName, Int32, cchName)
    startCDATA()
      => ComCall(7, this.p)
    endCDATA()
      => ComCall(8, this.p)
    comment(pwchChars, cchChars)
      => ComCall(9, this.p, "Str", pwchChars, Int32, cchChars)
}
struct ISAXDeclHandler extends IUnknown {
    static IID := "{862629AC-771A-47B2-8337-4E6843C1BE90}"
    elementDecl(pwchName, cchName, pwchModel, cchModel)
      => ComCall(3, this.p, "Str", pwchName, Int32, cchName, "Str", pwchModel, Int32, cchModel)
    attributeDecl(pwchElementName, cchElementName, pwchAttributeName, cchAttributeName, pwchType, cchType, pwchValueDefault, cchValueDefault, pwchValue, cchValue)
      => ComCall(4, this.p, "Str", pwchElementName, Int32, cchElementName, "Str", pwchAttributeName, Int32, cchAttributeName, "Str", pwchType, Int32, cchType, "Str", pwchValueDefault, Int32, cchValueDefault, "Str", pwchValue, Int32, cchValue)
    internalEntityDecl(pwchName, cchName, pwchValue, cchValue)
      => ComCall(5, this.p, "Str", pwchName, Int32, cchName, "Str", pwchValue, Int32, cchValue)
    externalEntityDecl(pwchName, cchName, pwchPublicId, cchPublicId, pwchSystemId, cchSystemId)
      => ComCall(6, this.p, "Str", pwchName, Int32, cchName, "Str", pwchPublicId, Int32, cchPublicId, "Str", pwchSystemId, Int32, cchSystemId)
}
struct ISAXAttributes extends IUnknown {
    static IID := "{F078ABE1-45D2-4832-91EA-4466CE2F25C9}"
    getLength(pnLength)
      => ComCall(3, this.p, Int32.Ptr, pnLength)
    getURI(nIndex, ppwchUri, pcchUri)
      => ComCall(4, this.p, Int32, nIndex, UInt16.Ptr.Ptr, ppwchUri, Int32.Ptr, pcchUri)
    getLocalName(nIndex, ppwchLocalName, pcchLocalName)
      => ComCall(5, this.p, Int32, nIndex, UInt16.Ptr.Ptr, ppwchLocalName, Int32.Ptr, pcchLocalName)
    getQName(nIndex, ppwchQName, pcchQName)
      => ComCall(6, this.p, Int32, nIndex, UInt16.Ptr.Ptr, ppwchQName, Int32.Ptr, pcchQName)
    getName(nIndex, ppwchUri, pcchUri, ppwchLocalName, pcchLocalName, ppwchQName, pcchQName)
      => ComCall(7, this.p, Int32, nIndex, UInt16.Ptr.Ptr, ppwchUri, Int32.Ptr, pcchUri, UInt16.Ptr.Ptr, ppwchLocalName, Int32.Ptr, pcchLocalName, UInt16.Ptr.Ptr, ppwchQName, Int32.Ptr, pcchQName)
    getIndexFromName(pwchUri, cchUri, pwchLocalName, cchLocalName, pnIndex)
      => ComCall(8, this.p, "Str", pwchUri, Int32, cchUri, "Str", pwchLocalName, Int32, cchLocalName, Int32.Ptr, pnIndex)
    getIndexFromQName(pwchQName, cchQName, pnIndex)
      => ComCall(9, this.p, "Str", pwchQName, Int32, cchQName, Int32.Ptr, pnIndex)
    getType(nIndex, ppwchType, pcchType)
      => ComCall(10, this.p, Int32, nIndex, UInt16.Ptr.Ptr, ppwchType, Int32.Ptr, pcchType)
    getTypeFromName(pwchUri, cchUri, pwchLocalName, cchLocalName, ppwchType, pcchType)
      => ComCall(11, this.p, "Str", pwchUri, Int32, cchUri, "Str", pwchLocalName, Int32, cchLocalName, UInt16.Ptr.Ptr, ppwchType, Int32.Ptr, pcchType)
    getTypeFromQName(pwchQName, cchQName, ppwchType, pcchType)
      => ComCall(12, this.p, "Str", pwchQName, Int32, cchQName, UInt16.Ptr.Ptr, ppwchType, Int32.Ptr, pcchType)
    getValue(nIndex, ppwchValue, pcchValue)
      => ComCall(13, this.p, Int32, nIndex, UInt16.Ptr.Ptr, ppwchValue, Int32.Ptr, pcchValue)
    getValueFromName(pwchUri, cchUri, pwchLocalName, cchLocalName, ppwchValue, pcchValue)
      => ComCall(14, this.p, "Str", pwchUri, Int32, cchUri, "Str", pwchLocalName, Int32, cchLocalName, UInt16.Ptr.Ptr, ppwchValue, Int32.Ptr, pcchValue)
    getValueFromQName(pwchQName, cchQName, ppwchValue, pcchValue)
      => ComCall(15, this.p, "Str", pwchQName, Int32, cchQName, UInt16.Ptr.Ptr, ppwchValue, Int32.Ptr, pcchValue)
}
struct IVBSAXXMLReader extends IDispatch {
    static IID := "{8C033CAA-6CD6-4F73-B728-4531AF74945F}"
    getFeature(strName, fValue)
      => ComCall(7, this.p, BSTR, strName, VARIANT_BOOL.Ptr, fValue)
    putFeature(strName, fValue)
      => ComCall(8, this.p, BSTR, strName, VARIANT_BOOL, fValue)
    getProperty(strName, varValue)
      => ComCall(9, this.p, BSTR, strName, VARIANT.Ptr, varValue)
    putProperty(strName, varValue)
      => ComCall(10, this.p, BSTR, strName, VARIANT, varValue)
    get_entityResolver(oResolver)
      => ComCall(11, this.p, IVBSAXEntityResolver.Ptr, oResolver)
    putref_entityResolver(oResolver)
      => ComCall(12, this.p, IVBSAXEntityResolver, oResolver)
    get_contentHandler(oHandler)
      => ComCall(13, this.p, IVBSAXContentHandler.Ptr, oHandler)
    putref_contentHandler(oHandler)
      => ComCall(14, this.p, IVBSAXContentHandler, oHandler)
    get_dtdHandler(oHandler)
      => ComCall(15, this.p, IVBSAXDTDHandler.Ptr, oHandler)
    putref_dtdHandler(oHandler)
      => ComCall(16, this.p, IVBSAXDTDHandler, oHandler)
    get_errorHandler(oHandler)
      => ComCall(17, this.p, IVBSAXErrorHandler.Ptr, oHandler)
    putref_errorHandler(oHandler)
      => ComCall(18, this.p, IVBSAXErrorHandler, oHandler)
    get_baseURL(strBaseURL)
      => ComCall(19, this.p, BSTR.Ptr, strBaseURL)
    put_baseURL(strBaseURL)
      => ComCall(20, this.p, BSTR, strBaseURL)
    get_secureBaseURL(strSecureBaseURL)
      => ComCall(21, this.p, BSTR.Ptr, strSecureBaseURL)
    put_secureBaseURL(strSecureBaseURL)
      => ComCall(22, this.p, BSTR, strSecureBaseURL)
    parse(varInput)
      => ComCall(23, this.p, VARIANT, varInput)
    parseURL(strURL)
      => ComCall(24, this.p, BSTR, strURL)
}
struct IVBSAXXMLFilter extends IDispatch {
    static IID := "{1299EB1B-5B88-433E-82DE-82CA75AD4E04}"
    get_parent(oReader)
      => ComCall(7, this.p, IVBSAXXMLReader.Ptr, oReader)
    putref_parent(oReader)
      => ComCall(8, this.p, IVBSAXXMLReader, oReader)
}
struct IVBSAXLocator extends IDispatch {
    static IID := "{796E7AC5-5AA2-4EFF-ACAD-3FAAF01A3288}"
    get_columnNumber(nColumn)
      => ComCall(7, this.p, Int32.Ptr, nColumn)
    get_lineNumber(nLine)
      => ComCall(8, this.p, Int32.Ptr, nLine)
    get_publicId(strPublicId)
      => ComCall(9, this.p, BSTR.Ptr, strPublicId)
    get_systemId(strSystemId)
      => ComCall(10, this.p, BSTR.Ptr, strSystemId)
}
struct IVBSAXEntityResolver extends IDispatch {
    static IID := "{0C05D096-F45B-4ACA-AD1A-AA0BC25518DC}"
    resolveEntity(strPublicId, strSystemId, varInput)
      => ComCall(7, this.p, BSTR.Ptr, strPublicId, BSTR.Ptr, strSystemId, VARIANT.Ptr, varInput)
}
struct IVBSAXContentHandler extends IDispatch {
    static IID := "{2ED7290A-4DD5-4B46-BB26-4E4155E77FAA}"
    putref_documentLocator(oLocator)
      => ComCall(7, this.p, IVBSAXLocator, oLocator)
    startDocument()
      => ComCall(8, this.p)
    endDocument()
      => ComCall(9, this.p)
    startPrefixMapping(strPrefix, strURI)
      => ComCall(10, this.p, BSTR.Ptr, strPrefix, BSTR.Ptr, strURI)
    endPrefixMapping(strPrefix)
      => ComCall(11, this.p, BSTR.Ptr, strPrefix)
    startElement(strNamespaceURI, strLocalName, strQName, oAttributes)
      => ComCall(12, this.p, BSTR.Ptr, strNamespaceURI, BSTR.Ptr, strLocalName, BSTR.Ptr, strQName, IVBSAXAttributes, oAttributes)
    endElement(strNamespaceURI, strLocalName, strQName)
      => ComCall(13, this.p, BSTR.Ptr, strNamespaceURI, BSTR.Ptr, strLocalName, BSTR.Ptr, strQName)
    characters(strChars)
      => ComCall(14, this.p, BSTR.Ptr, strChars)
    ignorableWhitespace(strChars)
      => ComCall(15, this.p, BSTR.Ptr, strChars)
    processingInstruction(strTarget, strData)
      => ComCall(16, this.p, BSTR.Ptr, strTarget, BSTR.Ptr, strData)
    skippedEntity(strName)
      => ComCall(17, this.p, BSTR.Ptr, strName)
}
struct IVBSAXDTDHandler extends IDispatch {
    static IID := "{24FB3297-302D-4620-BA39-3A732D850558}"
    notationDecl(strName, strPublicId, strSystemId)
      => ComCall(7, this.p, BSTR.Ptr, strName, BSTR.Ptr, strPublicId, BSTR.Ptr, strSystemId)
    unparsedEntityDecl(strName, strPublicId, strSystemId, strNotationName)
      => ComCall(8, this.p, BSTR.Ptr, strName, BSTR.Ptr, strPublicId, BSTR.Ptr, strSystemId, BSTR.Ptr, strNotationName)
}
struct IVBSAXErrorHandler extends IDispatch {
    static IID := "{D963D3FE-173C-4862-9095-B92F66995F52}"
    error(oLocator, strErrorMessage, nErrorCode)
      => ComCall(7, this.p, IVBSAXLocator, oLocator, BSTR.Ptr, strErrorMessage, Int32, nErrorCode)
    fatalError(oLocator, strErrorMessage, nErrorCode)
      => ComCall(8, this.p, IVBSAXLocator, oLocator, BSTR.Ptr, strErrorMessage, Int32, nErrorCode)
    ignorableWarning(oLocator, strErrorMessage, nErrorCode)
      => ComCall(9, this.p, IVBSAXLocator, oLocator, BSTR.Ptr, strErrorMessage, Int32, nErrorCode)
}
struct IVBSAXLexicalHandler extends IDispatch {
    static IID := "{032AAC35-8C0E-4D9D-979F-E3B702935576}"
    startDTD(strName, strPublicId, strSystemId)
      => ComCall(7, this.p, BSTR.Ptr, strName, BSTR.Ptr, strPublicId, BSTR.Ptr, strSystemId)
    endDTD()
      => ComCall(8, this.p)
    startEntity(strName)
      => ComCall(9, this.p, BSTR.Ptr, strName)
    endEntity(strName)
      => ComCall(10, this.p, BSTR.Ptr, strName)
    startCDATA()
      => ComCall(11, this.p)
    endCDATA()
      => ComCall(12, this.p)
    comment(strChars)
      => ComCall(13, this.p, BSTR.Ptr, strChars)
}
struct IVBSAXDeclHandler extends IDispatch {
    static IID := "{E8917260-7579-4BE1-B5DD-7AFBFA6F077B}"
    elementDecl(strName, strModel)
      => ComCall(7, this.p, BSTR.Ptr, strName, BSTR.Ptr, strModel)
    attributeDecl(strElementName, strAttributeName, strType, strValueDefault, strValue)
      => ComCall(8, this.p, BSTR.Ptr, strElementName, BSTR.Ptr, strAttributeName, BSTR.Ptr, strType, BSTR.Ptr, strValueDefault, BSTR.Ptr, strValue)
    internalEntityDecl(strName, strValue)
      => ComCall(9, this.p, BSTR.Ptr, strName, BSTR.Ptr, strValue)
    externalEntityDecl(strName, strPublicId, strSystemId)
      => ComCall(10, this.p, BSTR.Ptr, strName, BSTR.Ptr, strPublicId, BSTR.Ptr, strSystemId)
}
struct IVBSAXAttributes extends IDispatch {
    static IID := "{10DC0586-132B-4CAC-8BB3-DB00AC8B7EE0}"
    get_length(nLength)
      => ComCall(7, this.p, Int32.Ptr, nLength)
    getURI(nIndex, strURI)
      => ComCall(8, this.p, Int32, nIndex, BSTR.Ptr, strURI)
    getLocalName(nIndex, strLocalName)
      => ComCall(9, this.p, Int32, nIndex, BSTR.Ptr, strLocalName)
    getQName(nIndex, strQName)
      => ComCall(10, this.p, Int32, nIndex, BSTR.Ptr, strQName)
    getIndexFromName(strURI, strLocalName, nIndex)
      => ComCall(11, this.p, BSTR, strURI, BSTR, strLocalName, Int32.Ptr, nIndex)
    getIndexFromQName(strQName, nIndex)
      => ComCall(12, this.p, BSTR, strQName, Int32.Ptr, nIndex)
    getType(nIndex, strType)
      => ComCall(13, this.p, Int32, nIndex, BSTR.Ptr, strType)
    getTypeFromName(strURI, strLocalName, strType)
      => ComCall(14, this.p, BSTR, strURI, BSTR, strLocalName, BSTR.Ptr, strType)
    getTypeFromQName(strQName, strType)
      => ComCall(15, this.p, BSTR, strQName, BSTR.Ptr, strType)
    getValue(nIndex, strValue)
      => ComCall(16, this.p, Int32, nIndex, BSTR.Ptr, strValue)
    getValueFromName(strURI, strLocalName, strValue)
      => ComCall(17, this.p, BSTR, strURI, BSTR, strLocalName, BSTR.Ptr, strValue)
    getValueFromQName(strQName, strValue)
      => ComCall(18, this.p, BSTR, strQName, BSTR.Ptr, strValue)
}
struct IMXWriter extends IDispatch {
    static IID := "{4D7FF4BA-1565-4EA8-94E1-6E724A46F98D}"
    put_output(varDestination)
      => ComCall(7, this.p, VARIANT, varDestination)
    get_output(varDestination)
      => ComCall(8, this.p, VARIANT.Ptr, varDestination)
    put_encoding(strEncoding)
      => ComCall(9, this.p, BSTR, strEncoding)
    get_encoding(strEncoding)
      => ComCall(10, this.p, BSTR.Ptr, strEncoding)
    put_byteOrderMark(fWriteByteOrderMark)
      => ComCall(11, this.p, VARIANT_BOOL, fWriteByteOrderMark)
    get_byteOrderMark(fWriteByteOrderMark)
      => ComCall(12, this.p, VARIANT_BOOL.Ptr, fWriteByteOrderMark)
    put_indent(fIndentMode)
      => ComCall(13, this.p, VARIANT_BOOL, fIndentMode)
    get_indent(fIndentMode)
      => ComCall(14, this.p, VARIANT_BOOL.Ptr, fIndentMode)
    put_standalone(fValue)
      => ComCall(15, this.p, VARIANT_BOOL, fValue)
    get_standalone(fValue)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, fValue)
    put_omitXMLDeclaration(fValue)
      => ComCall(17, this.p, VARIANT_BOOL, fValue)
    get_omitXMLDeclaration(fValue)
      => ComCall(18, this.p, VARIANT_BOOL.Ptr, fValue)
    put_version(strVersion)
      => ComCall(19, this.p, BSTR, strVersion)
    get_version(strVersion)
      => ComCall(20, this.p, BSTR.Ptr, strVersion)
    put_disableOutputEscaping(fValue)
      => ComCall(21, this.p, VARIANT_BOOL, fValue)
    get_disableOutputEscaping(fValue)
      => ComCall(22, this.p, VARIANT_BOOL.Ptr, fValue)
    flush()
      => ComCall(23, this.p)
}
struct IMXAttributes extends IDispatch {
    static IID := "{F10D27CC-3EC0-415C-8ED8-77AB1C5E7262}"
    addAttribute(strURI, strLocalName, strQName, strType, strValue)
      => ComCall(7, this.p, BSTR, strURI, BSTR, strLocalName, BSTR, strQName, BSTR, strType, BSTR, strValue)
    addAttributeFromIndex(varAtts, nIndex)
      => ComCall(8, this.p, VARIANT, varAtts, Int32, nIndex)
    clear()
      => ComCall(9, this.p)
    removeAttribute(nIndex)
      => ComCall(10, this.p, Int32, nIndex)
    setAttribute(nIndex, strURI, strLocalName, strQName, strType, strValue)
      => ComCall(11, this.p, Int32, nIndex, BSTR, strURI, BSTR, strLocalName, BSTR, strQName, BSTR, strType, BSTR, strValue)
    setAttributes(varAtts)
      => ComCall(12, this.p, VARIANT, varAtts)
    setLocalName(nIndex, strLocalName)
      => ComCall(13, this.p, Int32, nIndex, BSTR, strLocalName)
    setQName(nIndex, strQName)
      => ComCall(14, this.p, Int32, nIndex, BSTR, strQName)
    setType(nIndex, strType)
      => ComCall(15, this.p, Int32, nIndex, BSTR, strType)
    setURI(nIndex, strURI)
      => ComCall(16, this.p, Int32, nIndex, BSTR, strURI)
    setValue(nIndex, strValue)
      => ComCall(17, this.p, Int32, nIndex, BSTR, strValue)
}
struct IMXReaderControl extends IDispatch {
    static IID := "{808F4E35-8D5A-4FBE-8466-33A41279ED30}"
    abort()
      => ComCall(7, this.p)
    resume()
      => ComCall(8, this.p)
    suspend()
      => ComCall(9, this.p)
}
struct IMXSchemaDeclHandler extends IDispatch {
    static IID := "{FA4BB38C-FAF9-4CCA-9302-D1DD0FE520DB}"
    schemaElementDecl(oSchemaElement)
      => ComCall(7, this.p, ISchemaElement, oSchemaElement)
}
struct IMXNamespacePrefixes extends IDispatch {
    static IID := "{C90352F4-643C-4FBC-BB23-E996EB2D51FD}"
    get_item(index, prefix)
      => ComCall(7, this.p, Int32, index, BSTR.Ptr, prefix)
    get_length(length)
      => ComCall(8, this.p, Int32.Ptr, length)
    get__newEnum(ppUnk)
      => ComCall(9, this.p, IUnknown.Ptr, ppUnk)
}
struct IVBMXNamespaceManager extends IDispatch {
    static IID := "{C90352F5-643C-4FBC-BB23-E996EB2D51FD}"
    put_allowOverride(fOverride)
      => ComCall(7, this.p, VARIANT_BOOL, fOverride)
    get_allowOverride(fOverride)
      => ComCall(8, this.p, VARIANT_BOOL.Ptr, fOverride)
    reset()
      => ComCall(9, this.p)
    pushContext()
      => ComCall(10, this.p)
    pushNodeContext(contextNode, fDeep)
      => ComCall(11, this.p, IXMLDOMNode, contextNode, VARIANT_BOOL, fDeep)
    popContext()
      => ComCall(12, this.p)
    declarePrefix(prefix, namespaceURI)
      => ComCall(13, this.p, BSTR, prefix, BSTR, namespaceURI)
    getDeclaredPrefixes(prefixes)
      => ComCall(14, this.p, IMXNamespacePrefixes.Ptr, prefixes)
    getPrefixes(namespaceURI, prefixes)
      => ComCall(15, this.p, BSTR, namespaceURI, IMXNamespacePrefixes.Ptr, prefixes)
    getURI(prefix, uri)
      => ComCall(16, this.p, BSTR, prefix, VARIANT.Ptr, uri)
    getURIFromNode(strPrefix, contextNode, uri)
      => ComCall(17, this.p, BSTR, strPrefix, IXMLDOMNode, contextNode, VARIANT.Ptr, uri)
}
struct IMXNamespaceManager extends IUnknown {
    static IID := "{C90352F6-643C-4FBC-BB23-E996EB2D51FD}"
    putAllowOverride(fOverride)
      => ComCall(3, this.p, VARIANT_BOOL, fOverride)
    getAllowOverride(fOverride)
      => ComCall(4, this.p, VARIANT_BOOL.Ptr, fOverride)
    reset()
      => ComCall(5, this.p)
    pushContext()
      => ComCall(6, this.p)
    pushNodeContext(contextNode, fDeep)
      => ComCall(7, this.p, IXMLDOMNode, contextNode, VARIANT_BOOL, fDeep)
    popContext()
      => ComCall(8, this.p)
    declarePrefix(prefix, namespaceURI)
      => ComCall(9, this.p, "Str", prefix, "Str", namespaceURI)
    getDeclaredPrefix(nIndex, pwchPrefix)
      => ComCall(10, this.p, Int32, nIndex, PWSTR, pwchPrefix, Int32.Ptr, pwchPrefix.Length)
    getPrefix(pwszNamespaceURI, nIndex, pwchPrefix)
      => ComCall(11, this.p, "Str", pwszNamespaceURI, Int32, nIndex, PWSTR, pwchPrefix, Int32.Ptr, pwchPrefix.Length)
    getURI(pwchPrefix, pContextNode, pwchUri)
      => ComCall(12, this.p, "Str", pwchPrefix, IXMLDOMNode, pContextNode, PWSTR, pwchUri, Int32.Ptr, pwchUri.Length)
}
struct IMXXMLFilter extends IDispatch {
    static IID := "{C90352F7-643C-4FBC-BB23-E996EB2D51FD}"
    getFeature(strName, fValue)
      => ComCall(7, this.p, BSTR, strName, VARIANT_BOOL.Ptr, fValue)
    putFeature(strName, fValue)
      => ComCall(8, this.p, BSTR, strName, VARIANT_BOOL, fValue)
    getProperty(strName, varValue)
      => ComCall(9, this.p, BSTR, strName, VARIANT.Ptr, varValue)
    putProperty(strName, varValue)
      => ComCall(10, this.p, BSTR, strName, VARIANT, varValue)
    get_entityResolver(oResolver)
      => ComCall(11, this.p, IUnknown.Ptr, oResolver)
    putref_entityResolver(oResolver)
      => ComCall(12, this.p, IUnknown, oResolver)
    get_contentHandler(oHandler)
      => ComCall(13, this.p, IUnknown.Ptr, oHandler)
    putref_contentHandler(oHandler)
      => ComCall(14, this.p, IUnknown, oHandler)
    get_dtdHandler(oHandler)
      => ComCall(15, this.p, IUnknown.Ptr, oHandler)
    putref_dtdHandler(oHandler)
      => ComCall(16, this.p, IUnknown, oHandler)
    get_errorHandler(oHandler)
      => ComCall(17, this.p, IUnknown.Ptr, oHandler)
    putref_errorHandler(oHandler)
      => ComCall(18, this.p, IUnknown, oHandler)
}
struct SOMITEMTYPE extends Int32 {
    static SOMITEM_SCHEMA := 4096
    static SOMITEM_ATTRIBUTE := 4097
    static SOMITEM_ATTRIBUTEGROUP := 4098
    static SOMITEM_NOTATION := 4099
    static SOMITEM_ANNOTATION := 4100
    static SOMITEM_IDENTITYCONSTRAINT := 4352
    static SOMITEM_KEY := 4353
    static SOMITEM_KEYREF := 4354
    static SOMITEM_UNIQUE := 4355
    static SOMITEM_ANYTYPE := 8192
    static SOMITEM_DATATYPE := 8448
    static SOMITEM_DATATYPE_ANYTYPE := 8449
    static SOMITEM_DATATYPE_ANYURI := 8450
    static SOMITEM_DATATYPE_BASE64BINARY := 8451
    static SOMITEM_DATATYPE_BOOLEAN := 8452
    static SOMITEM_DATATYPE_BYTE := 8453
    static SOMITEM_DATATYPE_DATE := 8454
    static SOMITEM_DATATYPE_DATETIME := 8455
    static SOMITEM_DATATYPE_DAY := 8456
    static SOMITEM_DATATYPE_DECIMAL := 8457
    static SOMITEM_DATATYPE_DOUBLE := 8458
    static SOMITEM_DATATYPE_DURATION := 8459
    static SOMITEM_DATATYPE_ENTITIES := 8460
    static SOMITEM_DATATYPE_ENTITY := 8461
    static SOMITEM_DATATYPE_FLOAT := 8462
    static SOMITEM_DATATYPE_HEXBINARY := 8463
    static SOMITEM_DATATYPE_ID := 8464
    static SOMITEM_DATATYPE_IDREF := 8465
    static SOMITEM_DATATYPE_IDREFS := 8466
    static SOMITEM_DATATYPE_INT := 8467
    static SOMITEM_DATATYPE_INTEGER := 8468
    static SOMITEM_DATATYPE_LANGUAGE := 8469
    static SOMITEM_DATATYPE_LONG := 8470
    static SOMITEM_DATATYPE_MONTH := 8471
    static SOMITEM_DATATYPE_MONTHDAY := 8472
    static SOMITEM_DATATYPE_NAME := 8473
    static SOMITEM_DATATYPE_NCNAME := 8474
    static SOMITEM_DATATYPE_NEGATIVEINTEGER := 8475
    static SOMITEM_DATATYPE_NMTOKEN := 8476
    static SOMITEM_DATATYPE_NMTOKENS := 8477
    static SOMITEM_DATATYPE_NONNEGATIVEINTEGER := 8478
    static SOMITEM_DATATYPE_NONPOSITIVEINTEGER := 8479
    static SOMITEM_DATATYPE_NORMALIZEDSTRING := 8480
    static SOMITEM_DATATYPE_NOTATION := 8481
    static SOMITEM_DATATYPE_POSITIVEINTEGER := 8482
    static SOMITEM_DATATYPE_QNAME := 8483
    static SOMITEM_DATATYPE_SHORT := 8484
    static SOMITEM_DATATYPE_STRING := 8485
    static SOMITEM_DATATYPE_TIME := 8486
    static SOMITEM_DATATYPE_TOKEN := 8487
    static SOMITEM_DATATYPE_UNSIGNEDBYTE := 8488
    static SOMITEM_DATATYPE_UNSIGNEDINT := 8489
    static SOMITEM_DATATYPE_UNSIGNEDLONG := 8490
    static SOMITEM_DATATYPE_UNSIGNEDSHORT := 8491
    static SOMITEM_DATATYPE_YEAR := 8492
    static SOMITEM_DATATYPE_YEARMONTH := 8493
    static SOMITEM_DATATYPE_ANYSIMPLETYPE := 8703
    static SOMITEM_SIMPLETYPE := 8704
    static SOMITEM_COMPLEXTYPE := 9216
    static SOMITEM_PARTICLE := 16384
    static SOMITEM_ANY := 16385
    static SOMITEM_ANYATTRIBUTE := 16386
    static SOMITEM_ELEMENT := 16387
    static SOMITEM_GROUP := 16640
    static SOMITEM_ALL := 16641
    static SOMITEM_CHOICE := 16642
    static SOMITEM_SEQUENCE := 16643
    static SOMITEM_EMPTYPARTICLE := 16644
    static SOMITEM_NULL := 2048
    static SOMITEM_NULL_TYPE := 10240
    static SOMITEM_NULL_ANY := 18433
    static SOMITEM_NULL_ANYATTRIBUTE := 18434
    static SOMITEM_NULL_ELEMENT := 18435
}
struct SCHEMAUSE extends Int32 {
    static SCHEMAUSE_OPTIONAL := 0
    static SCHEMAUSE_PROHIBITED := 1
    static SCHEMAUSE_REQUIRED := 2
}
struct SCHEMADERIVATIONMETHOD extends Int32 {
    static SCHEMADERIVATIONMETHOD_EMPTY := 0
    static SCHEMADERIVATIONMETHOD_SUBSTITUTION := 1
    static SCHEMADERIVATIONMETHOD_EXTENSION := 2
    static SCHEMADERIVATIONMETHOD_RESTRICTION := 4
    static SCHEMADERIVATIONMETHOD_LIST := 8
    static SCHEMADERIVATIONMETHOD_UNION := 16
    static SCHEMADERIVATIONMETHOD_ALL := 255
    static SCHEMADERIVATIONMETHOD_NONE := 256
}
struct SCHEMACONTENTTYPE extends Int32 {
    static SCHEMACONTENTTYPE_EMPTY := 0
    static SCHEMACONTENTTYPE_TEXTONLY := 1
    static SCHEMACONTENTTYPE_ELEMENTONLY := 2
    static SCHEMACONTENTTYPE_MIXED := 3
}
struct SCHEMAPROCESSCONTENTS extends Int32 {
    static SCHEMAPROCESSCONTENTS_NONE := 0
    static SCHEMAPROCESSCONTENTS_SKIP := 1
    static SCHEMAPROCESSCONTENTS_LAX := 2
    static SCHEMAPROCESSCONTENTS_STRICT := 3
}
struct SCHEMAWHITESPACE extends Int32 {
    static SCHEMAWHITESPACE_NONE := -1
    static SCHEMAWHITESPACE_PRESERVE := 0
    static SCHEMAWHITESPACE_REPLACE := 1
    static SCHEMAWHITESPACE_COLLAPSE := 2
}
struct SCHEMATYPEVARIETY extends Int32 {
    static SCHEMATYPEVARIETY_NONE := -1
    static SCHEMATYPEVARIETY_ATOMIC := 0
    static SCHEMATYPEVARIETY_LIST := 1
    static SCHEMATYPEVARIETY_UNION := 2
}
struct IXMLDOMSchemaCollection2 extends IXMLDOMSchemaCollection {
    static IID := "{50EA08B0-DD1B-4664-9A50-C2F40F4BD79A}"
    validate()
      => ComCall(14, this.p)
    put_validateOnLoad(validateOnLoad)
      => ComCall(15, this.p, VARIANT_BOOL, validateOnLoad)
    get_validateOnLoad(validateOnLoad)
      => ComCall(16, this.p, VARIANT_BOOL.Ptr, validateOnLoad)
    getSchema(namespaceURI, schema)
      => ComCall(17, this.p, BSTR, namespaceURI, ISchema.Ptr, schema)
    getDeclaration(node, item)
      => ComCall(18, this.p, IXMLDOMNode, node, ISchemaItem.Ptr, item)
}
struct ISchemaStringCollection extends IDispatch {
    static IID := "{50EA08B1-DD1B-4664-9A50-C2F40F4BD79A}"
    get_item(index, bstr)
      => ComCall(7, this.p, Int32, index, BSTR.Ptr, bstr)
    get_length(length)
      => ComCall(8, this.p, Int32.Ptr, length)
    get__newEnum(ppunk)
      => ComCall(9, this.p, IUnknown.Ptr, ppunk)
}
struct ISchemaItemCollection extends IDispatch {
    static IID := "{50EA08B2-DD1B-4664-9A50-C2F40F4BD79A}"
    get_item(index, item)
      => ComCall(7, this.p, Int32, index, ISchemaItem.Ptr, item)
    itemByName(name, item)
      => ComCall(8, this.p, BSTR, name, ISchemaItem.Ptr, item)
    itemByQName(name, namespaceURI, item)
      => ComCall(9, this.p, BSTR, name, BSTR, namespaceURI, ISchemaItem.Ptr, item)
    get_length(length)
      => ComCall(10, this.p, Int32.Ptr, length)
    get__newEnum(ppunk)
      => ComCall(11, this.p, IUnknown.Ptr, ppunk)
}
struct ISchemaItem extends IDispatch {
    static IID := "{50EA08B3-DD1B-4664-9A50-C2F40F4BD79A}"
    get_name(name)
      => ComCall(7, this.p, BSTR.Ptr, name)
    get_namespaceURI(namespaceURI)
      => ComCall(8, this.p, BSTR.Ptr, namespaceURI)
    get_schema(schema)
      => ComCall(9, this.p, ISchema.Ptr, schema)
    get_id(id)
      => ComCall(10, this.p, BSTR.Ptr, id)
    get_itemType(itemType)
      => ComCall(11, this.p, SOMITEMTYPE.Ptr, itemType)
    get_unhandledAttributes(attributes)
      => ComCall(12, this.p, IVBSAXAttributes.Ptr, attributes)
    writeAnnotation(annotationSink, isWritten)
      => ComCall(13, this.p, IUnknown, annotationSink, VARIANT_BOOL.Ptr, isWritten)
}
struct ISchema extends ISchemaItem {
    static IID := "{50EA08B4-DD1B-4664-9A50-C2F40F4BD79A}"
    get_targetNamespace(targetNamespace)
      => ComCall(14, this.p, BSTR.Ptr, targetNamespace)
    get_version(version)
      => ComCall(15, this.p, BSTR.Ptr, version)
    get_types(types)
      => ComCall(16, this.p, ISchemaItemCollection.Ptr, types)
    get_elements(elements)
      => ComCall(17, this.p, ISchemaItemCollection.Ptr, elements)
    get_attributes(attributes)
      => ComCall(18, this.p, ISchemaItemCollection.Ptr, attributes)
    get_attributeGroups(attributeGroups)
      => ComCall(19, this.p, ISchemaItemCollection.Ptr, attributeGroups)
    get_modelGroups(modelGroups)
      => ComCall(20, this.p, ISchemaItemCollection.Ptr, modelGroups)
    get_notations(notations)
      => ComCall(21, this.p, ISchemaItemCollection.Ptr, notations)
    get_schemaLocations(schemaLocations)
      => ComCall(22, this.p, ISchemaStringCollection.Ptr, schemaLocations)
}
struct ISchemaParticle extends ISchemaItem {
    static IID := "{50EA08B5-DD1B-4664-9A50-C2F40F4BD79A}"
    get_minOccurs(minOccurs)
      => ComCall(14, this.p, VARIANT.Ptr, minOccurs)
    get_maxOccurs(maxOccurs)
      => ComCall(15, this.p, VARIANT.Ptr, maxOccurs)
}
struct ISchemaAttribute extends ISchemaItem {
    static IID := "{50EA08B6-DD1B-4664-9A50-C2F40F4BD79A}"
    get_type(type)
      => ComCall(14, this.p, ISchemaType.Ptr, type)
    get_scope(scope)
      => ComCall(15, this.p, ISchemaComplexType.Ptr, scope)
    get_defaultValue(defaultValue)
      => ComCall(16, this.p, BSTR.Ptr, defaultValue)
    get_fixedValue(fixedValue)
      => ComCall(17, this.p, BSTR.Ptr, fixedValue)
    get_use(use)
      => ComCall(18, this.p, SCHEMAUSE.Ptr, use)
    get_isReference(reference)
      => ComCall(19, this.p, VARIANT_BOOL.Ptr, reference)
}
struct ISchemaElement extends ISchemaParticle {
    static IID := "{50EA08B7-DD1B-4664-9A50-C2F40F4BD79A}"
    get_type(type)
      => ComCall(16, this.p, ISchemaType.Ptr, type)
    get_scope(scope)
      => ComCall(17, this.p, ISchemaComplexType.Ptr, scope)
    get_defaultValue(defaultValue)
      => ComCall(18, this.p, BSTR.Ptr, defaultValue)
    get_fixedValue(fixedValue)
      => ComCall(19, this.p, BSTR.Ptr, fixedValue)
    get_isNillable(nillable)
      => ComCall(20, this.p, VARIANT_BOOL.Ptr, nillable)
    get_identityConstraints(constraints)
      => ComCall(21, this.p, ISchemaItemCollection.Ptr, constraints)
    get_substitutionGroup(element)
      => ComCall(22, this.p, ISchemaElement.Ptr, element)
    get_substitutionGroupExclusions(exclusions)
      => ComCall(23, this.p, SCHEMADERIVATIONMETHOD.Ptr, exclusions)
    get_disallowedSubstitutions(disallowed)
      => ComCall(24, this.p, SCHEMADERIVATIONMETHOD.Ptr, disallowed)
    get_isAbstract(abstract)
      => ComCall(25, this.p, VARIANT_BOOL.Ptr, abstract)
    get_isReference(reference)
      => ComCall(26, this.p, VARIANT_BOOL.Ptr, reference)
}
struct ISchemaType extends ISchemaItem {
    static IID := "{50EA08B8-DD1B-4664-9A50-C2F40F4BD79A}"
    get_baseTypes(baseTypes)
      => ComCall(14, this.p, ISchemaItemCollection.Ptr, baseTypes)
    get_final(final)
      => ComCall(15, this.p, SCHEMADERIVATIONMETHOD.Ptr, final)
    get_variety(variety)
      => ComCall(16, this.p, SCHEMATYPEVARIETY.Ptr, variety)
    get_derivedBy(derivedBy)
      => ComCall(17, this.p, SCHEMADERIVATIONMETHOD.Ptr, derivedBy)
    isValid(data, valid)
      => ComCall(18, this.p, BSTR, data, VARIANT_BOOL.Ptr, valid)
    get_minExclusive(minExclusive)
      => ComCall(19, this.p, BSTR.Ptr, minExclusive)
    get_minInclusive(minInclusive)
      => ComCall(20, this.p, BSTR.Ptr, minInclusive)
    get_maxExclusive(maxExclusive)
      => ComCall(21, this.p, BSTR.Ptr, maxExclusive)
    get_maxInclusive(maxInclusive)
      => ComCall(22, this.p, BSTR.Ptr, maxInclusive)
    get_totalDigits(totalDigits)
      => ComCall(23, this.p, VARIANT.Ptr, totalDigits)
    get_fractionDigits(fractionDigits)
      => ComCall(24, this.p, VARIANT.Ptr, fractionDigits)
    get_length(length)
      => ComCall(25, this.p, VARIANT.Ptr, length)
    get_minLength(minLength)
      => ComCall(26, this.p, VARIANT.Ptr, minLength)
    get_maxLength(maxLength)
      => ComCall(27, this.p, VARIANT.Ptr, maxLength)
    get_enumeration(enumeration)
      => ComCall(28, this.p, ISchemaStringCollection.Ptr, enumeration)
    get_whitespace(whitespace)
      => ComCall(29, this.p, SCHEMAWHITESPACE.Ptr, whitespace)
    get_patterns(patterns)
      => ComCall(30, this.p, ISchemaStringCollection.Ptr, patterns)
}
struct ISchemaComplexType extends ISchemaType {
    static IID := "{50EA08B9-DD1B-4664-9A50-C2F40F4BD79A}"
    get_isAbstract(abstract)
      => ComCall(31, this.p, VARIANT_BOOL.Ptr, abstract)
    get_anyAttribute(anyAttribute)
      => ComCall(32, this.p, ISchemaAny.Ptr, anyAttribute)
    get_attributes(attributes)
      => ComCall(33, this.p, ISchemaItemCollection.Ptr, attributes)
    get_contentType(contentType)
      => ComCall(34, this.p, SCHEMACONTENTTYPE.Ptr, contentType)
    get_contentModel(contentModel)
      => ComCall(35, this.p, ISchemaModelGroup.Ptr, contentModel)
    get_prohibitedSubstitutions(prohibited)
      => ComCall(36, this.p, SCHEMADERIVATIONMETHOD.Ptr, prohibited)
}
struct ISchemaAttributeGroup extends ISchemaItem {
    static IID := "{50EA08BA-DD1B-4664-9A50-C2F40F4BD79A}"
    get_anyAttribute(anyAttribute)
      => ComCall(14, this.p, ISchemaAny.Ptr, anyAttribute)
    get_attributes(attributes)
      => ComCall(15, this.p, ISchemaItemCollection.Ptr, attributes)
}
struct ISchemaModelGroup extends ISchemaParticle {
    static IID := "{50EA08BB-DD1B-4664-9A50-C2F40F4BD79A}"
    get_particles(particles)
      => ComCall(16, this.p, ISchemaItemCollection.Ptr, particles)
}
struct ISchemaAny extends ISchemaParticle {
    static IID := "{50EA08BC-DD1B-4664-9A50-C2F40F4BD79A}"
    get_namespaces(namespaces)
      => ComCall(16, this.p, ISchemaStringCollection.Ptr, namespaces)
    get_processContents(processContents)
      => ComCall(17, this.p, SCHEMAPROCESSCONTENTS.Ptr, processContents)
}
struct ISchemaIdentityConstraint extends ISchemaItem {
    static IID := "{50EA08BD-DD1B-4664-9A50-C2F40F4BD79A}"
    get_selector(selector)
      => ComCall(14, this.p, BSTR.Ptr, selector)
    get_fields(fields)
      => ComCall(15, this.p, ISchemaStringCollection.Ptr, fields)
    get_referencedKey(key)
      => ComCall(16, this.p, ISchemaIdentityConstraint.Ptr, key)
}
struct ISchemaNotation extends ISchemaItem {
    static IID := "{50EA08BE-DD1B-4664-9A50-C2F40F4BD79A}"
    get_systemIdentifier(uri)
      => ComCall(14, this.p, BSTR.Ptr, uri)
    get_publicIdentifier(uri)
      => ComCall(15, this.p, BSTR.Ptr, uri)
}
struct msxml6_ReferenceRemainingTypes__ {
    __tagDomNodeType__ : DOMNodeType
    __domNodeType__ : DOMNodeType
    __serverXmlHttpOptionEnum__ : SERVERXMLHTTP_OPTION
    __serverXmlHttpOption__ : SERVERXMLHTTP_OPTION
    __serverCertOptionEnum__ : SXH_SERVER_CERT_OPTION
    __serverCertOption__ : SXH_SERVER_CERT_OPTION
    __proxySettingEnum__ : SXH_PROXY_SETTING
    __proxySetting__ : SXH_PROXY_SETTING
    __somItemTypeEnum__ : SOMITEMTYPE
    __somItemType__ : SOMITEMTYPE
    __schemaUseEnum__ : SCHEMAUSE
    __schemaUse__ : SCHEMAUSE
    __schemaDerivationMethodEnum__ : SCHEMADERIVATIONMETHOD
    __schemaDerivationMethod__ : SCHEMADERIVATIONMETHOD
    __schemaContentTypeEnum__ : SCHEMACONTENTTYPE
    __schemaContentType__ : SCHEMACONTENTTYPE
    __schemaProcessContentsEnum__ : SCHEMAPROCESSCONTENTS
    __schemaProcessContents__ : SCHEMAPROCESSCONTENTS
    __schemaWhitespaceEnum__ : SCHEMAWHITESPACE
    __schemaWhitespace__ : SCHEMAWHITESPACE
    __schemaTypeVarietyEnum__ : SCHEMATYPEVARIETY
    __schemaTypeVariety__ : SCHEMATYPEVARIETY
}
struct XHR_COOKIE_STATE extends Int32 {
    static XHR_COOKIE_STATE_UNKNOWN := 0
    static XHR_COOKIE_STATE_ACCEPT := 1
    static XHR_COOKIE_STATE_PROMPT := 2
    static XHR_COOKIE_STATE_LEASH := 3
    static XHR_COOKIE_STATE_DOWNGRADE := 4
    static XHR_COOKIE_STATE_REJECT := 5
}
struct XHR_COOKIE_FLAG extends Int32 {
    static XHR_COOKIE_IS_SECURE := 1
    static XHR_COOKIE_IS_SESSION := 2
    static XHR_COOKIE_THIRD_PARTY := 16
    static XHR_COOKIE_PROMPT_REQUIRED := 32
    static XHR_COOKIE_EVALUATE_P3P := 64
    static XHR_COOKIE_APPLY_P3P := 128
    static XHR_COOKIE_P3P_ENABLED := 256
    static XHR_COOKIE_IS_RESTRICTED := 512
    static XHR_COOKIE_IE6 := 1024
    static XHR_COOKIE_IS_LEGACY := 2048
    static XHR_COOKIE_NON_SCRIPT := 4096
    static XHR_COOKIE_HTTPONLY := 8192
}
struct XHR_CRED_PROMPT extends Int32 {
    static XHR_CRED_PROMPT_ALL := 0
    static XHR_CRED_PROMPT_NONE := 1
    static XHR_CRED_PROMPT_PROXY := 2
}
struct XHR_AUTH extends Int32 {
    static XHR_AUTH_ALL := 0
    static XHR_AUTH_NONE := 1
    static XHR_AUTH_PROXY := 2
}
struct XHR_PROPERTY extends Int32 {
    static XHR_PROP_NO_CRED_PROMPT := 0
    static XHR_PROP_NO_AUTH := 1
    static XHR_PROP_TIMEOUT := 2
    static XHR_PROP_NO_DEFAULT_HEADERS := 3
    static XHR_PROP_REPORT_REDIRECT_STATUS := 4
    static XHR_PROP_NO_CACHE := 5
    static XHR_PROP_EXTENDED_ERROR := 6
    static XHR_PROP_QUERY_STRING_UTF8 := 7
    static XHR_PROP_IGNORE_CERT_ERRORS := 8
    static XHR_PROP_ONDATA_THRESHOLD := 9
    static XHR_PROP_SET_ENTERPRISEID := 10
    static XHR_PROP_MAX_CONNECTIONS := 11
}
struct XHR_CERT_IGNORE_FLAG extends UInt32 {
    static XHR_CERT_IGNORE_REVOCATION_FAILED := 128
    static XHR_CERT_IGNORE_UNKNOWN_CA := 256
    static XHR_CERT_IGNORE_CERT_CN_INVALID := 4096
    static XHR_CERT_IGNORE_CERT_DATE_INVALID := 8192
    static XHR_CERT_IGNORE_ALL_SERVER_ERRORS := 12672
}
struct XHR_CERT_ERROR_FLAG extends UInt32 {
    static XHR_CERT_ERROR_REVOCATION_FAILED := 8388608
    static XHR_CERT_ERROR_UNKNOWN_CA := 16777216
    static XHR_CERT_ERROR_CERT_CN_INVALID := 33554432
    static XHR_CERT_ERROR_CERT_DATE_INVALID := 67108864
    static XHR_CERT_ERROR_ALL_SERVER_ERRORS := 125829120
}
struct XHR_COOKIE {
    pwszUrl : PWSTR
    pwszName : PWSTR
    pwszValue : PWSTR
    pwszP3PPolicy : PWSTR
    ftExpires : FILETIME
    dwFlags : UInt32
}
struct IXMLHTTPRequest2Callback extends IUnknown {
    static IID := "{A44A9299-E321-40DE-8866-341B41669162}"
    OnRedirect(pXHR, pwszRedirectUrl)
      => ComCall(3, this.p, IXMLHTTPRequest2, pXHR, "Str", pwszRedirectUrl)
    OnHeadersAvailable(pXHR, dwStatus, pwszStatus)
      => ComCall(4, this.p, IXMLHTTPRequest2, pXHR, UInt32, dwStatus, "Str", pwszStatus)
    OnDataAvailable(pXHR, pResponseStream)
      => ComCall(5, this.p, IXMLHTTPRequest2, pXHR, ISequentialStream, pResponseStream)
    OnResponseReceived(pXHR, pResponseStream)
      => ComCall(6, this.p, IXMLHTTPRequest2, pXHR, ISequentialStream, pResponseStream)
    OnError(pXHR, hrError)
      => ComCall(7, this.p, IXMLHTTPRequest2, pXHR, HRESULT, hrError)
}
struct IXMLHTTPRequest2 extends IUnknown {
    static IID := "{E5D37DC0-552A-4D52-9CC0-A14D546FBD04}"
    Open(pwszMethod, pwszUrl, pStatusCallback, pwszUserName, pwszPassword, pwszProxyUserName, pwszProxyPassword)
      => ComCall(3, this.p, "Str", pwszMethod, "Str", pwszUrl, IXMLHTTPRequest2Callback, pStatusCallback, "Str", pwszUserName, "Str", pwszPassword, "Str", pwszProxyUserName, "Str", pwszProxyPassword)
    Send(pBody, cbBody)
      => ComCall(4, this.p, ISequentialStream, pBody, Int64, cbBody)
    Abort()
      => ComCall(5, this.p)
    SetCookie(pCookie, pdwCookieState)
      => ComCall(6, this.p, XHR_COOKIE.Ptr, pCookie, UInt32.Ptr, pdwCookieState)
    SetCustomResponseStream(pSequentialStream)
      => ComCall(7, this.p, ISequentialStream, pSequentialStream)
    SetProperty(eProperty, ullValue)
      => ComCall(8, this.p, XHR_PROPERTY, eProperty, Int64, ullValue)
    SetRequestHeader(pwszHeader, pwszValue)
      => ComCall(9, this.p, "Str", pwszHeader, "Str", pwszValue)
    GetAllResponseHeaders(ppwszHeaders)
      => ComCall(10, this.p, UInt16.Ptr.Ptr, ppwszHeaders)
    GetCookie(pwszUrl, pwszName, dwFlags, ppCookies)
      => ComCall(11, this.p, "Str", pwszUrl, "Str", pwszName, UInt32, dwFlags, UInt32.Ptr, ppCookies.Length, XHR_COOKIE.Ptr.Ptr, ppCookies)
    GetResponseHeader(pwszHeader, ppwszValue)
      => ComCall(12, this.p, "Str", pwszHeader, UInt16.Ptr.Ptr, ppwszValue)
}
struct XHR_CERT {
    cbCert : UInt32
    pbCert : UInt8.Ptr
}
struct IXMLHTTPRequest3Callback extends IXMLHTTPRequest2Callback {
    static IID := "{B9E57830-8C6C-4A6F-9C13-47772BB047BB}"
    OnServerCertificateReceived(pXHR, dwCertificateErrors, rgServerCertificateChain)
      => ComCall(8, this.p, IXMLHTTPRequest3, pXHR, UInt32, dwCertificateErrors, UInt32, rgServerCertificateChain.Length, XHR_CERT.Ptr, rgServerCertificateChain)
    OnClientCertificateRequested(pXHR, rgpwszIssuerList)
      => ComCall(9, this.p, IXMLHTTPRequest3, pXHR, UInt32, rgpwszIssuerList.Length, UInt16.Ptr.Ptr, rgpwszIssuerList)
}
struct IXMLHTTPRequest3 extends IXMLHTTPRequest2 {
    static IID := "{A1C9FEEE-0617-4F23-9D58-8961EA43567C}"
    SetClientCertificate(pbClientCertificateHash, pwszPin)
      => ComCall(13, this.p, UInt32, pbClientCertificateHash.Length, UInt8.Ptr, pbClientCertificateHash, "Str", pwszPin)
}
