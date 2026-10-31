#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}
#Import "..\Security\Types.ahk" {SECURITY_ATTRIBUTES}
#Import "..\Security.Cryptography\Types.ahk" {CERT_CONTEXT}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown, IUri}

struct IOpcUri extends IUri {
    static IID := "{BC9C1B9B-D62C-49EB-AEF0-3B4E0B28EBED}"
    GetRelationshipsPartUri(relationshipPartUri)
      => ComCall(28, this.p, IOpcPartUri.Ptr, relationshipPartUri)
    GetRelativeUri(targetPartUri, relativeUri)
      => ComCall(29, this.p, IOpcPartUri, targetPartUri, IUri.Ptr, relativeUri)
    CombinePartUri(relativeUri, combinedUri)
      => ComCall(30, this.p, IUri, relativeUri, IOpcPartUri.Ptr, combinedUri)
}
struct IOpcPartUri extends IOpcUri {
    static IID := "{7D3BABE7-88B2-46BA-85CB-4203CB016C87}"
    ComparePartUri(partUri, comparisonResult)
      => ComCall(31, this.p, IOpcPartUri, partUri, Int32.Ptr, comparisonResult)
    GetSourceUri(sourceUri)
      => ComCall(32, this.p, IOpcUri.Ptr, sourceUri)
    IsRelationshipsPartUri(isRelationshipUri)
      => ComCall(33, this.p, BOOL.Ptr, isRelationshipUri)
}
struct OPC_URI_TARGET_MODE extends Int32 {
    static OPC_URI_TARGET_MODE_INTERNAL := 0
    static OPC_URI_TARGET_MODE_EXTERNAL := 1
}
struct OPC_COMPRESSION_OPTIONS extends Int32 {
    static OPC_COMPRESSION_NONE := -1
    static OPC_COMPRESSION_NORMAL := 0
    static OPC_COMPRESSION_MAXIMUM := 1
    static OPC_COMPRESSION_FAST := 2
    static OPC_COMPRESSION_SUPERFAST := 3
}
struct OPC_STREAM_IO_MODE extends Int32 {
    static OPC_STREAM_IO_READ := 1
    static OPC_STREAM_IO_WRITE := 2
}
struct OPC_READ_FLAGS extends Int32 {
    static OPC_READ_DEFAULT := 0
    static OPC_VALIDATE_ON_LOAD := 1
    static OPC_CACHE_ON_ACCESS := 2
}
struct OPC_WRITE_FLAGS extends Int32 {
    static OPC_WRITE_DEFAULT := 0
    static OPC_WRITE_FORCE_ZIP32 := 1
}
struct OPC_SIGNATURE_VALIDATION_RESULT extends Int32 {
    static OPC_SIGNATURE_VALID := 0
    static OPC_SIGNATURE_INVALID := -1
}
struct OPC_CANONICALIZATION_METHOD extends Int32 {
    static OPC_CANONICALIZATION_NONE := 0
    static OPC_CANONICALIZATION_C14N := 1
    static OPC_CANONICALIZATION_C14N_WITH_COMMENTS := 2
}
struct OPC_RELATIONSHIP_SELECTOR extends Int32 {
    static OPC_RELATIONSHIP_SELECT_BY_ID := 0
    static OPC_RELATIONSHIP_SELECT_BY_TYPE := 1
}
struct OPC_RELATIONSHIPS_SIGNING_OPTION extends Int32 {
    static OPC_RELATIONSHIP_SIGN_USING_SELECTORS := 0
    static OPC_RELATIONSHIP_SIGN_PART := 1
}
struct OPC_CERTIFICATE_EMBEDDING_OPTION extends Int32 {
    static OPC_CERTIFICATE_IN_CERTIFICATE_PART := 0
    static OPC_CERTIFICATE_IN_SIGNATURE_PART := 1
    static OPC_CERTIFICATE_NOT_EMBEDDED := 2
}
struct OPC_SIGNATURE_TIME_FORMAT extends Int32 {
    static OPC_SIGNATURE_TIME_FORMAT_MILLISECONDS := 0
    static OPC_SIGNATURE_TIME_FORMAT_SECONDS := 1
    static OPC_SIGNATURE_TIME_FORMAT_MINUTES := 2
    static OPC_SIGNATURE_TIME_FORMAT_DAYS := 3
    static OPC_SIGNATURE_TIME_FORMAT_MONTHS := 4
    static OPC_SIGNATURE_TIME_FORMAT_YEARS := 5
}
struct IOpcPackage extends IUnknown {
    static IID := "{42195949-3B79-4FC8-89C6-FC7FB979EE70}"
    GetPartSet(partSet)
      => ComCall(3, this.p, IOpcPartSet.Ptr, partSet)
    GetRelationshipSet(relationshipSet)
      => ComCall(4, this.p, IOpcRelationshipSet.Ptr, relationshipSet)
}
struct IOpcPart extends IUnknown {
    static IID := "{42195949-3B79-4FC8-89C6-FC7FB979EE71}"
    GetRelationshipSet(relationshipSet)
      => ComCall(3, this.p, IOpcRelationshipSet.Ptr, relationshipSet)
    GetContentStream(stream)
      => ComCall(4, this.p, IStream.Ptr, stream)
    GetName(name)
      => ComCall(5, this.p, IOpcPartUri.Ptr, name)
    GetContentType(contentType)
      => ComCall(6, this.p, PWSTR.Ptr, contentType)
    GetCompressionOptions(compressionOptions)
      => ComCall(7, this.p, OPC_COMPRESSION_OPTIONS.Ptr, compressionOptions)
}
struct IOpcRelationship extends IUnknown {
    static IID := "{42195949-3B79-4FC8-89C6-FC7FB979EE72}"
    GetId(relationshipIdentifier)
      => ComCall(3, this.p, PWSTR.Ptr, relationshipIdentifier)
    GetRelationshipType(relationshipType)
      => ComCall(4, this.p, PWSTR.Ptr, relationshipType)
    GetSourceUri(sourceUri)
      => ComCall(5, this.p, IOpcUri.Ptr, sourceUri)
    GetTargetUri(targetUri)
      => ComCall(6, this.p, IUri.Ptr, targetUri)
    GetTargetMode(targetMode)
      => ComCall(7, this.p, OPC_URI_TARGET_MODE.Ptr, targetMode)
}
struct IOpcPartSet extends IUnknown {
    static IID := "{42195949-3B79-4FC8-89C6-FC7FB979EE73}"
    GetPart(name, part)
      => ComCall(3, this.p, IOpcPartUri, name, IOpcPart.Ptr, part)
    CreatePart(name, contentType, compressionOptions, part)
      => ComCall(4, this.p, IOpcPartUri, name, "Str", contentType, OPC_COMPRESSION_OPTIONS, compressionOptions, IOpcPart.Ptr, part)
    DeletePart(name)
      => ComCall(5, this.p, IOpcPartUri, name)
    PartExists(name, partExists)
      => ComCall(6, this.p, IOpcPartUri, name, BOOL.Ptr, partExists)
    GetEnumerator(partEnumerator)
      => ComCall(7, this.p, IOpcPartEnumerator.Ptr, partEnumerator)
}
struct IOpcRelationshipSet extends IUnknown {
    static IID := "{42195949-3B79-4FC8-89C6-FC7FB979EE74}"
    GetRelationship(relationshipIdentifier, relationship)
      => ComCall(3, this.p, "Str", relationshipIdentifier, IOpcRelationship.Ptr, relationship)
    CreateRelationship(relationshipIdentifier, relationshipType, targetUri, targetMode, relationship)
      => ComCall(4, this.p, "Str", relationshipIdentifier, "Str", relationshipType, IUri, targetUri, OPC_URI_TARGET_MODE, targetMode, IOpcRelationship.Ptr, relationship)
    DeleteRelationship(relationshipIdentifier)
      => ComCall(5, this.p, "Str", relationshipIdentifier)
    RelationshipExists(relationshipIdentifier, relationshipExists)
      => ComCall(6, this.p, "Str", relationshipIdentifier, BOOL.Ptr, relationshipExists)
    GetEnumerator(relationshipEnumerator)
      => ComCall(7, this.p, IOpcRelationshipEnumerator.Ptr, relationshipEnumerator)
    GetEnumeratorForType(relationshipType, relationshipEnumerator)
      => ComCall(8, this.p, "Str", relationshipType, IOpcRelationshipEnumerator.Ptr, relationshipEnumerator)
    GetRelationshipsContentStream(contents)
      => ComCall(9, this.p, IStream.Ptr, contents)
}
struct IOpcPartEnumerator extends IUnknown {
    static IID := "{42195949-3B79-4FC8-89C6-FC7FB979EE75}"
    MoveNext(hasNext)
      => ComCall(3, this.p, BOOL.Ptr, hasNext)
    MovePrevious(hasPrevious)
      => ComCall(4, this.p, BOOL.Ptr, hasPrevious)
    GetCurrent(part)
      => ComCall(5, this.p, IOpcPart.Ptr, part)
    Clone(copy)
      => ComCall(6, this.p, IOpcPartEnumerator.Ptr, copy)
}
struct IOpcRelationshipEnumerator extends IUnknown {
    static IID := "{42195949-3B79-4FC8-89C6-FC7FB979EE76}"
    MoveNext(hasNext)
      => ComCall(3, this.p, BOOL.Ptr, hasNext)
    MovePrevious(hasPrevious)
      => ComCall(4, this.p, BOOL.Ptr, hasPrevious)
    GetCurrent(relationship)
      => ComCall(5, this.p, IOpcRelationship.Ptr, relationship)
    Clone(copy)
      => ComCall(6, this.p, IOpcRelationshipEnumerator.Ptr, copy)
}
struct IOpcSignaturePartReference extends IUnknown {
    static IID := "{E24231CA-59F4-484E-B64B-36EEDA36072C}"
    GetPartName(partName)
      => ComCall(3, this.p, IOpcPartUri.Ptr, partName)
    GetContentType(contentType)
      => ComCall(4, this.p, PWSTR.Ptr, contentType)
    GetDigestMethod(digestMethod)
      => ComCall(5, this.p, PWSTR.Ptr, digestMethod)
    GetDigestValue(digestValue)
      => ComCall(6, this.p, UInt8.Ptr.Ptr, digestValue, UInt32.Ptr, digestValue.Length)
    GetTransformMethod(transformMethod)
      => ComCall(7, this.p, OPC_CANONICALIZATION_METHOD.Ptr, transformMethod)
}
struct IOpcSignatureRelationshipReference extends IUnknown {
    static IID := "{57BABAC6-9D4A-4E50-8B86-E5D4051EAE7C}"
    GetSourceUri(sourceUri)
      => ComCall(3, this.p, IOpcUri.Ptr, sourceUri)
    GetDigestMethod(digestMethod)
      => ComCall(4, this.p, PWSTR.Ptr, digestMethod)
    GetDigestValue(digestValue)
      => ComCall(5, this.p, UInt8.Ptr.Ptr, digestValue, UInt32.Ptr, digestValue.Length)
    GetTransformMethod(transformMethod)
      => ComCall(6, this.p, OPC_CANONICALIZATION_METHOD.Ptr, transformMethod)
    GetRelationshipSigningOption(relationshipSigningOption)
      => ComCall(7, this.p, OPC_RELATIONSHIPS_SIGNING_OPTION.Ptr, relationshipSigningOption)
    GetRelationshipSelectorEnumerator(selectorEnumerator)
      => ComCall(8, this.p, IOpcRelationshipSelectorEnumerator.Ptr, selectorEnumerator)
}
struct IOpcRelationshipSelector extends IUnknown {
    static IID := "{F8F26C7F-B28F-4899-84C8-5D5639EDE75F}"
    GetSelectorType(selector)
      => ComCall(3, this.p, OPC_RELATIONSHIP_SELECTOR.Ptr, selector)
    GetSelectionCriterion(selectionCriterion)
      => ComCall(4, this.p, PWSTR.Ptr, selectionCriterion)
}
struct IOpcSignatureReference extends IUnknown {
    static IID := "{1B47005E-3011-4EDC-BE6F-0F65E5AB0342}"
    GetId(referenceId)
      => ComCall(3, this.p, PWSTR.Ptr, referenceId)
    GetUri(referenceUri)
      => ComCall(4, this.p, IUri.Ptr, referenceUri)
    GetType(type)
      => ComCall(5, this.p, PWSTR.Ptr, type)
    GetTransformMethod(transformMethod)
      => ComCall(6, this.p, OPC_CANONICALIZATION_METHOD.Ptr, transformMethod)
    GetDigestMethod(digestMethod)
      => ComCall(7, this.p, PWSTR.Ptr, digestMethod)
    GetDigestValue(digestValue)
      => ComCall(8, this.p, UInt8.Ptr.Ptr, digestValue, UInt32.Ptr, digestValue.Length)
}
struct IOpcSignatureCustomObject extends IUnknown {
    static IID := "{5D77A19E-62C1-44E7-BECD-45DA5AE51A56}"
    GetXml(xmlMarkup)
      => ComCall(3, this.p, UInt8.Ptr.Ptr, xmlMarkup, UInt32.Ptr, xmlMarkup.Length)
}
struct IOpcDigitalSignature extends IUnknown {
    static IID := "{52AB21DD-1CD0-4949-BC80-0C1232D00CB4}"
    GetNamespaces(prefixes, namespaces, count)
      => ComCall(3, this.p, PWSTR.Ptr.Ptr, prefixes, PWSTR.Ptr.Ptr, namespaces, UInt32.Ptr, count)
    GetSignatureId(signatureId)
      => ComCall(4, this.p, PWSTR.Ptr, signatureId)
    GetSignaturePartName(signaturePartName)
      => ComCall(5, this.p, IOpcPartUri.Ptr, signaturePartName)
    GetSignatureMethod(signatureMethod)
      => ComCall(6, this.p, PWSTR.Ptr, signatureMethod)
    GetCanonicalizationMethod(canonicalizationMethod)
      => ComCall(7, this.p, OPC_CANONICALIZATION_METHOD.Ptr, canonicalizationMethod)
    GetSignatureValue(signatureValue, count)
      => ComCall(8, this.p, UInt8.Ptr.Ptr, signatureValue, UInt32.Ptr, count)
    GetSignaturePartReferenceEnumerator(partReferenceEnumerator)
      => ComCall(9, this.p, IOpcSignaturePartReferenceEnumerator.Ptr, partReferenceEnumerator)
    GetSignatureRelationshipReferenceEnumerator(relationshipReferenceEnumerator)
      => ComCall(10, this.p, IOpcSignatureRelationshipReferenceEnumerator.Ptr, relationshipReferenceEnumerator)
    GetSigningTime(signingTime)
      => ComCall(11, this.p, PWSTR.Ptr, signingTime)
    GetTimeFormat(timeFormat)
      => ComCall(12, this.p, OPC_SIGNATURE_TIME_FORMAT.Ptr, timeFormat)
    GetPackageObjectReference(packageObjectReference)
      => ComCall(13, this.p, IOpcSignatureReference.Ptr, packageObjectReference)
    GetCertificateEnumerator(certificateEnumerator)
      => ComCall(14, this.p, IOpcCertificateEnumerator.Ptr, certificateEnumerator)
    GetCustomReferenceEnumerator(customReferenceEnumerator)
      => ComCall(15, this.p, IOpcSignatureReferenceEnumerator.Ptr, customReferenceEnumerator)
    GetCustomObjectEnumerator(customObjectEnumerator)
      => ComCall(16, this.p, IOpcSignatureCustomObjectEnumerator.Ptr, customObjectEnumerator)
    GetSignatureXml(signatureXml)
      => ComCall(17, this.p, UInt8.Ptr.Ptr, signatureXml, UInt32.Ptr, signatureXml.Length)
}
struct IOpcSigningOptions extends IUnknown {
    static IID := "{50D2D6A5-7AEB-46C0-B241-43AB0E9B407E}"
    GetSignatureId(signatureId)
      => ComCall(3, this.p, PWSTR.Ptr, signatureId)
    SetSignatureId(signatureId)
      => ComCall(4, this.p, "Str", signatureId)
    GetSignatureMethod(signatureMethod)
      => ComCall(5, this.p, PWSTR.Ptr, signatureMethod)
    SetSignatureMethod(signatureMethod)
      => ComCall(6, this.p, "Str", signatureMethod)
    GetDefaultDigestMethod(digestMethod)
      => ComCall(7, this.p, PWSTR.Ptr, digestMethod)
    SetDefaultDigestMethod(digestMethod)
      => ComCall(8, this.p, "Str", digestMethod)
    GetCertificateEmbeddingOption(embeddingOption)
      => ComCall(9, this.p, OPC_CERTIFICATE_EMBEDDING_OPTION.Ptr, embeddingOption)
    SetCertificateEmbeddingOption(embeddingOption)
      => ComCall(10, this.p, OPC_CERTIFICATE_EMBEDDING_OPTION, embeddingOption)
    GetTimeFormat(timeFormat)
      => ComCall(11, this.p, OPC_SIGNATURE_TIME_FORMAT.Ptr, timeFormat)
    SetTimeFormat(timeFormat)
      => ComCall(12, this.p, OPC_SIGNATURE_TIME_FORMAT, timeFormat)
    GetSignaturePartReferenceSet(partReferenceSet)
      => ComCall(13, this.p, IOpcSignaturePartReferenceSet.Ptr, partReferenceSet)
    GetSignatureRelationshipReferenceSet(relationshipReferenceSet)
      => ComCall(14, this.p, IOpcSignatureRelationshipReferenceSet.Ptr, relationshipReferenceSet)
    GetCustomObjectSet(customObjectSet)
      => ComCall(15, this.p, IOpcSignatureCustomObjectSet.Ptr, customObjectSet)
    GetCustomReferenceSet(customReferenceSet)
      => ComCall(16, this.p, IOpcSignatureReferenceSet.Ptr, customReferenceSet)
    GetCertificateSet(certificateSet)
      => ComCall(17, this.p, IOpcCertificateSet.Ptr, certificateSet)
    GetSignaturePartName(signaturePartName)
      => ComCall(18, this.p, IOpcPartUri.Ptr, signaturePartName)
    SetSignaturePartName(signaturePartName)
      => ComCall(19, this.p, IOpcPartUri, signaturePartName)
}
struct IOpcDigitalSignatureManager extends IUnknown {
    static IID := "{D5E62A0B-696D-462F-94DF-72E33CEF2659}"
    GetSignatureOriginPartName(signatureOriginPartName)
      => ComCall(3, this.p, IOpcPartUri.Ptr, signatureOriginPartName)
    SetSignatureOriginPartName(signatureOriginPartName)
      => ComCall(4, this.p, IOpcPartUri, signatureOriginPartName)
    GetSignatureEnumerator(signatureEnumerator)
      => ComCall(5, this.p, IOpcDigitalSignatureEnumerator.Ptr, signatureEnumerator)
    RemoveSignature(signaturePartName)
      => ComCall(6, this.p, IOpcPartUri, signaturePartName)
    CreateSigningOptions(signingOptions)
      => ComCall(7, this.p, IOpcSigningOptions.Ptr, signingOptions)
    Validate(signature, certificate, validationResult)
      => ComCall(8, this.p, IOpcDigitalSignature, signature, CERT_CONTEXT.Ptr, certificate, OPC_SIGNATURE_VALIDATION_RESULT.Ptr, validationResult)
    Sign(certificate, signingOptions, digitalSignature)
      => ComCall(9, this.p, CERT_CONTEXT.Ptr, certificate, IOpcSigningOptions, signingOptions, IOpcDigitalSignature.Ptr, digitalSignature)
    ReplaceSignatureXml(signaturePartName, newSignatureXml, digitalSignature)
      => ComCall(10, this.p, IOpcPartUri, signaturePartName, UInt8.Ptr, newSignatureXml, UInt32, newSignatureXml.Length, IOpcDigitalSignature.Ptr, digitalSignature)
}
struct IOpcSignaturePartReferenceEnumerator extends IUnknown {
    static IID := "{80EB1561-8C77-49CF-8266-459B356EE99A}"
    MoveNext(hasNext)
      => ComCall(3, this.p, BOOL.Ptr, hasNext)
    MovePrevious(hasPrevious)
      => ComCall(4, this.p, BOOL.Ptr, hasPrevious)
    GetCurrent(partReference)
      => ComCall(5, this.p, IOpcSignaturePartReference.Ptr, partReference)
    Clone(copy)
      => ComCall(6, this.p, IOpcSignaturePartReferenceEnumerator.Ptr, copy)
}
struct IOpcSignatureRelationshipReferenceEnumerator extends IUnknown {
    static IID := "{773BA3E4-F021-48E4-AA04-9816DB5D3495}"
    MoveNext(hasNext)
      => ComCall(3, this.p, BOOL.Ptr, hasNext)
    MovePrevious(hasPrevious)
      => ComCall(4, this.p, BOOL.Ptr, hasPrevious)
    GetCurrent(relationshipReference)
      => ComCall(5, this.p, IOpcSignatureRelationshipReference.Ptr, relationshipReference)
    Clone(copy)
      => ComCall(6, this.p, IOpcSignatureRelationshipReferenceEnumerator.Ptr, copy)
}
struct IOpcRelationshipSelectorEnumerator extends IUnknown {
    static IID := "{5E50A181-A91B-48AC-88D2-BCA3D8F8C0B1}"
    MoveNext(hasNext)
      => ComCall(3, this.p, BOOL.Ptr, hasNext)
    MovePrevious(hasPrevious)
      => ComCall(4, this.p, BOOL.Ptr, hasPrevious)
    GetCurrent(relationshipSelector)
      => ComCall(5, this.p, IOpcRelationshipSelector.Ptr, relationshipSelector)
    Clone(copy)
      => ComCall(6, this.p, IOpcRelationshipSelectorEnumerator.Ptr, copy)
}
struct IOpcSignatureReferenceEnumerator extends IUnknown {
    static IID := "{CFA59A45-28B1-4868-969E-FA8097FDC12A}"
    MoveNext(hasNext)
      => ComCall(3, this.p, BOOL.Ptr, hasNext)
    MovePrevious(hasPrevious)
      => ComCall(4, this.p, BOOL.Ptr, hasPrevious)
    GetCurrent(reference)
      => ComCall(5, this.p, IOpcSignatureReference.Ptr, reference)
    Clone(copy)
      => ComCall(6, this.p, IOpcSignatureReferenceEnumerator.Ptr, copy)
}
struct IOpcSignatureCustomObjectEnumerator extends IUnknown {
    static IID := "{5EE4FE1D-E1B0-4683-8079-7EA0FCF80B4C}"
    MoveNext(hasNext)
      => ComCall(3, this.p, BOOL.Ptr, hasNext)
    MovePrevious(hasPrevious)
      => ComCall(4, this.p, BOOL.Ptr, hasPrevious)
    GetCurrent(customObject)
      => ComCall(5, this.p, IOpcSignatureCustomObject.Ptr, customObject)
    Clone(copy)
      => ComCall(6, this.p, IOpcSignatureCustomObjectEnumerator.Ptr, copy)
}
struct IOpcCertificateEnumerator extends IUnknown {
    static IID := "{85131937-8F24-421F-B439-59AB24D140B8}"
    MoveNext(hasNext)
      => ComCall(3, this.p, BOOL.Ptr, hasNext)
    MovePrevious(hasPrevious)
      => ComCall(4, this.p, BOOL.Ptr, hasPrevious)
    GetCurrent(certificate)
      => ComCall(5, this.p, CERT_CONTEXT.Ptr.Ptr, certificate)
    Clone(copy)
      => ComCall(6, this.p, IOpcCertificateEnumerator.Ptr, copy)
}
struct IOpcDigitalSignatureEnumerator extends IUnknown {
    static IID := "{967B6882-0BA3-4358-B9E7-B64C75063C5E}"
    MoveNext(hasNext)
      => ComCall(3, this.p, BOOL.Ptr, hasNext)
    MovePrevious(hasPrevious)
      => ComCall(4, this.p, BOOL.Ptr, hasPrevious)
    GetCurrent(digitalSignature)
      => ComCall(5, this.p, IOpcDigitalSignature.Ptr, digitalSignature)
    Clone(copy)
      => ComCall(6, this.p, IOpcDigitalSignatureEnumerator.Ptr, copy)
}
struct IOpcSignaturePartReferenceSet extends IUnknown {
    static IID := "{6C9FE28C-ECD9-4B22-9D36-7FDDE670FEC0}"
    Create(partUri, digestMethod, transformMethod, partReference)
      => ComCall(3, this.p, IOpcPartUri, partUri, "Str", digestMethod, OPC_CANONICALIZATION_METHOD, transformMethod, IOpcSignaturePartReference.Ptr, partReference)
    Delete(partReference)
      => ComCall(4, this.p, IOpcSignaturePartReference, partReference)
    GetEnumerator(partReferenceEnumerator)
      => ComCall(5, this.p, IOpcSignaturePartReferenceEnumerator.Ptr, partReferenceEnumerator)
}
struct IOpcSignatureRelationshipReferenceSet extends IUnknown {
    static IID := "{9F863CA5-3631-404C-828D-807E0715069B}"
    Create(sourceUri, digestMethod, relationshipSigningOption, selectorSet, transformMethod, relationshipReference)
      => ComCall(3, this.p, IOpcUri, sourceUri, "Str", digestMethod, OPC_RELATIONSHIPS_SIGNING_OPTION, relationshipSigningOption, IOpcRelationshipSelectorSet, selectorSet, OPC_CANONICALIZATION_METHOD, transformMethod, IOpcSignatureRelationshipReference.Ptr, relationshipReference)
    CreateRelationshipSelectorSet(selectorSet)
      => ComCall(4, this.p, IOpcRelationshipSelectorSet.Ptr, selectorSet)
    Delete(relationshipReference)
      => ComCall(5, this.p, IOpcSignatureRelationshipReference, relationshipReference)
    GetEnumerator(relationshipReferenceEnumerator)
      => ComCall(6, this.p, IOpcSignatureRelationshipReferenceEnumerator.Ptr, relationshipReferenceEnumerator)
}
struct IOpcRelationshipSelectorSet extends IUnknown {
    static IID := "{6E34C269-A4D3-47C0-B5C4-87FF2B3B6136}"
    Create(selector, selectionCriterion, relationshipSelector)
      => ComCall(3, this.p, OPC_RELATIONSHIP_SELECTOR, selector, "Str", selectionCriterion, IOpcRelationshipSelector.Ptr, relationshipSelector)
    Delete(relationshipSelector)
      => ComCall(4, this.p, IOpcRelationshipSelector, relationshipSelector)
    GetEnumerator(relationshipSelectorEnumerator)
      => ComCall(5, this.p, IOpcRelationshipSelectorEnumerator.Ptr, relationshipSelectorEnumerator)
}
struct IOpcSignatureReferenceSet extends IUnknown {
    static IID := "{F3B02D31-AB12-42DD-9E2F-2B16761C3C1E}"
    Create(referenceUri, referenceId, type, digestMethod, transformMethod, reference)
      => ComCall(3, this.p, IUri, referenceUri, "Str", referenceId, "Str", type, "Str", digestMethod, OPC_CANONICALIZATION_METHOD, transformMethod, IOpcSignatureReference.Ptr, reference)
    Delete(reference)
      => ComCall(4, this.p, IOpcSignatureReference, reference)
    GetEnumerator(referenceEnumerator)
      => ComCall(5, this.p, IOpcSignatureReferenceEnumerator.Ptr, referenceEnumerator)
}
struct IOpcSignatureCustomObjectSet extends IUnknown {
    static IID := "{8F792AC5-7947-4E11-BC3D-2659FF046AE1}"
    Create(xmlMarkup, customObject)
      => ComCall(3, this.p, UInt8.Ptr, xmlMarkup, UInt32, xmlMarkup.Length, IOpcSignatureCustomObject.Ptr, customObject)
    Delete(customObject)
      => ComCall(4, this.p, IOpcSignatureCustomObject, customObject)
    GetEnumerator(customObjectEnumerator)
      => ComCall(5, this.p, IOpcSignatureCustomObjectEnumerator.Ptr, customObjectEnumerator)
}
struct IOpcCertificateSet extends IUnknown {
    static IID := "{56EA4325-8E2D-4167-B1A4-E486D24C8FA7}"
    Add(certificate)
      => ComCall(3, this.p, CERT_CONTEXT.Ptr, certificate)
    Remove(certificate)
      => ComCall(4, this.p, CERT_CONTEXT.Ptr, certificate)
    GetEnumerator(certificateEnumerator)
      => ComCall(5, this.p, IOpcCertificateEnumerator.Ptr, certificateEnumerator)
}
struct IOpcFactory extends IUnknown {
    static IID := "{6D0B4446-CD73-4AB3-94F4-8CCDF6116154}"
    CreatePackageRootUri(rootUri)
      => ComCall(3, this.p, IOpcUri.Ptr, rootUri)
    CreatePartUri(pwzUri, partUri)
      => ComCall(4, this.p, "Str", pwzUri, IOpcPartUri.Ptr, partUri)
    CreateStreamOnFile(filename, ioMode, securityAttributes, dwFlagsAndAttributes, stream)
      => ComCall(5, this.p, "Str", filename, OPC_STREAM_IO_MODE, ioMode, SECURITY_ATTRIBUTES.Ptr, securityAttributes, UInt32, dwFlagsAndAttributes, IStream.Ptr, stream)
    CreatePackage(package)
      => ComCall(6, this.p, IOpcPackage.Ptr, package)
    ReadPackageFromStream(stream, flags, package)
      => ComCall(7, this.p, IStream, stream, OPC_READ_FLAGS, flags, IOpcPackage.Ptr, package)
    WritePackageToStream(package, flags, stream)
      => ComCall(8, this.p, IOpcPackage, package, OPC_WRITE_FLAGS, flags, IStream, stream)
    CreateDigitalSignatureManager(package, signatureManager)
      => ComCall(9, this.p, IOpcPackage, package, IOpcDigitalSignatureManager.Ptr, signatureManager)
}
