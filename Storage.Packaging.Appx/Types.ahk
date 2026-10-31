#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Data.Xml.MsXml\Types.ahk" {IXMLDOMDocument}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PSTR, PWSTR}
#Import "..\Security\Types.ahk" {PSID}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown, IUri}

struct PACKAGE_VIRTUALIZATION_CONTEXT_HANDLE {
    Value : Struct.Ptr
}
struct PACKAGEDEPENDENCY_CONTEXT {
    Value : Struct.Ptr
}
struct PACKAGE_ID {
    reserved : UInt32
    processorArchitecture : UInt32
    version : PACKAGE_VERSION
    name : PWSTR
    publisher : PWSTR
    resourceId : PWSTR
    publisherId : PWSTR
}
struct PACKAGE_INFO {
    reserved : UInt32
    flags : UInt32
    path : PWSTR
    packageFullName : PWSTR
    packageFamilyName : PWSTR
    packageId : PACKAGE_ID
}
struct APPX_PACKAGE_SETTINGS {
    forceZip32 : BOOL
    hashMethod : IUri
}
struct APPX_COMPRESSION_OPTION extends Int32 {
    static APPX_COMPRESSION_OPTION_NONE := 0
    static APPX_COMPRESSION_OPTION_NORMAL := 1
    static APPX_COMPRESSION_OPTION_MAXIMUM := 2
    static APPX_COMPRESSION_OPTION_FAST := 3
    static APPX_COMPRESSION_OPTION_SUPERFAST := 4
}
struct APPX_PACKAGE_WRITER_PAYLOAD_STREAM {
    inputStream : IStream
    fileName : PWSTR
    contentType : PWSTR
    compressionOption : APPX_COMPRESSION_OPTION
}
struct APPX_FOOTPRINT_FILE_TYPE extends Int32 {
    static APPX_FOOTPRINT_FILE_TYPE_MANIFEST := 0
    static APPX_FOOTPRINT_FILE_TYPE_BLOCKMAP := 1
    static APPX_FOOTPRINT_FILE_TYPE_SIGNATURE := 2
    static APPX_FOOTPRINT_FILE_TYPE_CODEINTEGRITY := 3
    static APPX_FOOTPRINT_FILE_TYPE_CONTENTGROUPMAP := 4
}
struct APPX_BUNDLE_FOOTPRINT_FILE_TYPE extends Int32 {
    static APPX_BUNDLE_FOOTPRINT_FILE_TYPE_FIRST := 0
    static APPX_BUNDLE_FOOTPRINT_FILE_TYPE_MANIFEST := 0
    static APPX_BUNDLE_FOOTPRINT_FILE_TYPE_BLOCKMAP := 1
    static APPX_BUNDLE_FOOTPRINT_FILE_TYPE_SIGNATURE := 2
    static APPX_BUNDLE_FOOTPRINT_FILE_TYPE_LAST := 2
}
struct APPX_CAPABILITIES extends Int32 {
    static APPX_CAPABILITY_INTERNET_CLIENT := 1
    static APPX_CAPABILITY_INTERNET_CLIENT_SERVER := 2
    static APPX_CAPABILITY_PRIVATE_NETWORK_CLIENT_SERVER := 4
    static APPX_CAPABILITY_DOCUMENTS_LIBRARY := 8
    static APPX_CAPABILITY_PICTURES_LIBRARY := 16
    static APPX_CAPABILITY_VIDEOS_LIBRARY := 32
    static APPX_CAPABILITY_MUSIC_LIBRARY := 64
    static APPX_CAPABILITY_ENTERPRISE_AUTHENTICATION := 128
    static APPX_CAPABILITY_SHARED_USER_CERTIFICATES := 256
    static APPX_CAPABILITY_REMOVABLE_STORAGE := 512
    static APPX_CAPABILITY_APPOINTMENTS := 1024
    static APPX_CAPABILITY_CONTACTS := 2048
}
struct APPX_PACKAGE_ARCHITECTURE extends Int32 {
    static APPX_PACKAGE_ARCHITECTURE_X86 := 0
    static APPX_PACKAGE_ARCHITECTURE_ARM := 5
    static APPX_PACKAGE_ARCHITECTURE_X64 := 9
    static APPX_PACKAGE_ARCHITECTURE_NEUTRAL := 11
    static APPX_PACKAGE_ARCHITECTURE_ARM64 := 12
}
struct APPX_PACKAGE_ARCHITECTURE2 extends Int32 {
    static APPX_PACKAGE_ARCHITECTURE2_X86 := 0
    static APPX_PACKAGE_ARCHITECTURE2_ARM := 5
    static APPX_PACKAGE_ARCHITECTURE2_X64 := 9
    static APPX_PACKAGE_ARCHITECTURE2_NEUTRAL := 11
    static APPX_PACKAGE_ARCHITECTURE2_ARM64 := 12
    static APPX_PACKAGE_ARCHITECTURE2_X86_ON_ARM64 := 14
    static APPX_PACKAGE_ARCHITECTURE2_UNKNOWN := 65535
}
struct APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE extends Int32 {
    static APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE_APPLICATION := 0
    static APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE_RESOURCE := 1
}
struct DX_FEATURE_LEVEL extends Int32 {
    static DX_FEATURE_LEVEL_UNSPECIFIED := 0
    static DX_FEATURE_LEVEL_9 := 1
    static DX_FEATURE_LEVEL_10 := 2
    static DX_FEATURE_LEVEL_11 := 3
}
struct APPX_CAPABILITY_CLASS_TYPE extends Int32 {
    static APPX_CAPABILITY_CLASS_DEFAULT := 0
    static APPX_CAPABILITY_CLASS_GENERAL := 1
    static APPX_CAPABILITY_CLASS_RESTRICTED := 2
    static APPX_CAPABILITY_CLASS_WINDOWS := 4
    static APPX_CAPABILITY_CLASS_ALL := 7
    static APPX_CAPABILITY_CLASS_CUSTOM := 8
}
struct APPX_PACKAGING_CONTEXT_CHANGE_TYPE extends Int32 {
    static APPX_PACKAGING_CONTEXT_CHANGE_TYPE_START := 0
    static APPX_PACKAGING_CONTEXT_CHANGE_TYPE_CHANGE := 1
    static APPX_PACKAGING_CONTEXT_CHANGE_TYPE_DETAILS := 2
    static APPX_PACKAGING_CONTEXT_CHANGE_TYPE_END := 3
}
struct IAppxFactory extends IUnknown {
    static IID := "{BEB94909-E451-438B-B5A7-D79E767B75D8}"
    CreatePackageWriter(outputStream, settings, packageWriter)
      => ComCall(3, this.p, IStream, outputStream, APPX_PACKAGE_SETTINGS.Ptr, settings, IAppxPackageWriter.Ptr, packageWriter)
    CreatePackageReader(inputStream, packageReader)
      => ComCall(4, this.p, IStream, inputStream, IAppxPackageReader.Ptr, packageReader)
    CreateManifestReader(inputStream, manifestReader)
      => ComCall(5, this.p, IStream, inputStream, IAppxManifestReader.Ptr, manifestReader)
    CreateBlockMapReader(inputStream, blockMapReader)
      => ComCall(6, this.p, IStream, inputStream, IAppxBlockMapReader.Ptr, blockMapReader)
    CreateValidatedBlockMapReader(blockMapStream, signatureFileName, blockMapReader)
      => ComCall(7, this.p, IStream, blockMapStream, "Str", signatureFileName, IAppxBlockMapReader.Ptr, blockMapReader)
}
struct IAppxFactory2 extends IUnknown {
    static IID := "{F1346DF2-C282-4E22-B918-743A929A8D55}"
    CreateContentGroupMapReader(inputStream, contentGroupMapReader)
      => ComCall(3, this.p, IStream, inputStream, IAppxContentGroupMapReader.Ptr, contentGroupMapReader)
    CreateSourceContentGroupMapReader(inputStream, reader)
      => ComCall(4, this.p, IStream, inputStream, IAppxSourceContentGroupMapReader.Ptr, reader)
    CreateContentGroupMapWriter(stream, contentGroupMapWriter)
      => ComCall(5, this.p, IStream, stream, IAppxContentGroupMapWriter.Ptr, contentGroupMapWriter)
}
struct IAppxFactory3 extends IUnknown {
    static IID := "{776B2C05-E21D-4E24-BA1A-CD529A8BFDBB}"
    CreatePackageReader2(inputStream, expectedDigest, packageReader)
      => ComCall(3, this.p, IStream, inputStream, "Str", expectedDigest, IAppxPackageReader.Ptr, packageReader)
    CreateManifestReader2(inputStream, expectedDigest, manifestReader)
      => ComCall(4, this.p, IStream, inputStream, "Str", expectedDigest, IAppxManifestReader.Ptr, manifestReader)
    CreateAppInstallerReader(inputStream, expectedDigest, appInstallerReader)
      => ComCall(5, this.p, IStream, inputStream, "Str", expectedDigest, IAppxAppInstallerReader.Ptr, appInstallerReader)
}
struct IAppxFactory4 extends IUnknown {
    static IID := "{92E50000-6934-4C8D-B472-229D431DADDF}"
    CreatePackageReaderFromSourceUri(uri, expectedDigest, packageReader)
      => ComCall(3, this.p, "Str", uri, "Str", expectedDigest, IAppxPackageReader.Ptr, packageReader)
}
struct IAppxPackageReader extends IUnknown {
    static IID := "{B5C49650-99BC-481C-9A34-3D53A4106708}"
    GetBlockMap(blockMapReader)
      => ComCall(3, this.p, IAppxBlockMapReader.Ptr, blockMapReader)
    GetFootprintFile(type, file)
      => ComCall(4, this.p, APPX_FOOTPRINT_FILE_TYPE, type, IAppxFile.Ptr, file)
    GetPayloadFile(fileName, file)
      => ComCall(5, this.p, "Str", fileName, IAppxFile.Ptr, file)
    GetPayloadFiles(filesEnumerator)
      => ComCall(6, this.p, IAppxFilesEnumerator.Ptr, filesEnumerator)
    GetManifest(manifestReader)
      => ComCall(7, this.p, IAppxManifestReader.Ptr, manifestReader)
}
struct IAppxPackageWriter extends IUnknown {
    static IID := "{9099E33B-246F-41E4-881A-008EB613F858}"
    AddPayloadFile(fileName, contentType, compressionOption, inputStream)
      => ComCall(3, this.p, "Str", fileName, "Str", contentType, APPX_COMPRESSION_OPTION, compressionOption, IStream, inputStream)
    Close(manifest)
      => ComCall(4, this.p, IStream, manifest)
}
struct IAppxPackageWriter2 extends IUnknown {
    static IID := "{2CF5C4FD-E54C-4EA5-BA4E-F8C4B105A8C8}"
    Close(manifest, contentGroupMap)
      => ComCall(3, this.p, IStream, manifest, IStream, contentGroupMap)
}
struct IAppxPackageWriter3 extends IUnknown {
    static IID := "{A83AACD3-41C0-4501-B8A3-74164F50B2FD}"
    AddPayloadFiles(payloadFiles, memoryLimit)
      => ComCall(3, this.p, UInt32, payloadFiles.Length, APPX_PACKAGE_WRITER_PAYLOAD_STREAM.Ptr, payloadFiles, Int64, memoryLimit)
}
struct IAppxFile extends IUnknown {
    static IID := "{91DF827B-94FD-468F-827B-57F41B2F6F2E}"
    GetCompressionOption(compressionOption)
      => ComCall(3, this.p, APPX_COMPRESSION_OPTION.Ptr, compressionOption)
    GetContentType(contentType)
      => ComCall(4, this.p, PWSTR.Ptr, contentType)
    GetName(fileName)
      => ComCall(5, this.p, PWSTR.Ptr, fileName)
    GetSize(size)
      => ComCall(6, this.p, Int64.Ptr, size)
    GetStream(stream)
      => ComCall(7, this.p, IStream.Ptr, stream)
}
struct IAppxFile2 extends IAppxFile {
    static IID := "{0C830B3C-40E9-11EE-BE56-0242AC120002}"
    GetBlockSize(blockSize)
      => ComCall(8, this.p, Int64.Ptr, blockSize)
}
struct IAppxFilesEnumerator extends IUnknown {
    static IID := "{F007EEAF-9831-411C-9847-917CDC62D1FE}"
    GetCurrent(file)
      => ComCall(3, this.p, IAppxFile.Ptr, file)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxBlockMapReader extends IUnknown {
    static IID := "{5EFEC991-BCA3-42D1-9EC2-E92D609EC22A}"
    GetFile(filename, file)
      => ComCall(3, this.p, "Str", filename, IAppxBlockMapFile.Ptr, file)
    GetFiles(enumerator)
      => ComCall(4, this.p, IAppxBlockMapFilesEnumerator.Ptr, enumerator)
    GetHashMethod(hashMethod)
      => ComCall(5, this.p, IUri.Ptr, hashMethod)
    GetStream(blockMapStream)
      => ComCall(6, this.p, IStream.Ptr, blockMapStream)
}
struct IAppxBlockMapFile extends IUnknown {
    static IID := "{277672AC-4F63-42C1-8ABC-BEAE3600EB59}"
    GetBlocks(blocks)
      => ComCall(3, this.p, IAppxBlockMapBlocksEnumerator.Ptr, blocks)
    GetLocalFileHeaderSize(lfhSize)
      => ComCall(4, this.p, UInt32.Ptr, lfhSize)
    GetName(name)
      => ComCall(5, this.p, PWSTR.Ptr, name)
    GetUncompressedSize(size)
      => ComCall(6, this.p, Int64.Ptr, size)
    ValidateFileHash(fileStream, isValid)
      => ComCall(7, this.p, IStream, fileStream, BOOL.Ptr, isValid)
}
struct IAppxBlockMapFile2 extends IAppxBlockMapFile {
    static IID := "{54785F78-40E9-11EE-BE56-0242AC120002}"
    GetBlockSize(blockSize)
      => ComCall(8, this.p, Int64.Ptr, blockSize)
}
struct IAppxBlockMapFilesEnumerator extends IUnknown {
    static IID := "{02B856A2-4262-4070-BACB-1A8CBBC42305}"
    GetCurrent(file)
      => ComCall(3, this.p, IAppxBlockMapFile.Ptr, file)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasCurrent)
      => ComCall(5, this.p, BOOL.Ptr, hasCurrent)
}
struct IAppxBlockMapBlock extends IUnknown {
    static IID := "{75CF3930-3244-4FE0-A8C8-E0BCB270B889}"
    GetHash(bufferSize, buffer)
      => ComCall(3, this.p, UInt32.Ptr, bufferSize, UInt8.Ptr.Ptr, buffer)
    GetCompressedSize(size)
      => ComCall(4, this.p, UInt32.Ptr, size)
}
struct IAppxBlockMapBlocksEnumerator extends IUnknown {
    static IID := "{6B429B5B-36EF-479E-B9EB-0C1482B49E16}"
    GetCurrent(block)
      => ComCall(3, this.p, IAppxBlockMapBlock.Ptr, block)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestReader extends IUnknown {
    static IID := "{4E1BD148-55A0-4480-A3D1-15544710637C}"
    GetPackageId(packageId)
      => ComCall(3, this.p, IAppxManifestPackageId.Ptr, packageId)
    GetProperties(packageProperties)
      => ComCall(4, this.p, IAppxManifestProperties.Ptr, packageProperties)
    GetPackageDependencies(dependencies)
      => ComCall(5, this.p, IAppxManifestPackageDependenciesEnumerator.Ptr, dependencies)
    GetCapabilities(capabilities)
      => ComCall(6, this.p, APPX_CAPABILITIES.Ptr, capabilities)
    GetResources(resources)
      => ComCall(7, this.p, IAppxManifestResourcesEnumerator.Ptr, resources)
    GetDeviceCapabilities(deviceCapabilities)
      => ComCall(8, this.p, IAppxManifestDeviceCapabilitiesEnumerator.Ptr, deviceCapabilities)
    GetPrerequisite(name, value)
      => ComCall(9, this.p, "Str", name, Int64.Ptr, value)
    GetApplications(applications)
      => ComCall(10, this.p, IAppxManifestApplicationsEnumerator.Ptr, applications)
    GetStream(manifestStream)
      => ComCall(11, this.p, IStream.Ptr, manifestStream)
}
struct IAppxManifestReader2 extends IAppxManifestReader {
    static IID := "{D06F67BC-B31D-4EBA-A8AF-638E73E77B4D}"
    GetQualifiedResources(resources)
      => ComCall(12, this.p, IAppxManifestQualifiedResourcesEnumerator.Ptr, resources)
}
struct IAppxManifestReader3 extends IAppxManifestReader2 {
    static IID := "{C43825AB-69B7-400A-9709-CC37F5A72D24}"
    GetCapabilitiesByCapabilityClass(capabilityClass, capabilities)
      => ComCall(13, this.p, APPX_CAPABILITY_CLASS_TYPE, capabilityClass, IAppxManifestCapabilitiesEnumerator.Ptr, capabilities)
    GetTargetDeviceFamilies(targetDeviceFamilies)
      => ComCall(14, this.p, IAppxManifestTargetDeviceFamiliesEnumerator.Ptr, targetDeviceFamilies)
}
struct IAppxManifestReader4 extends IAppxManifestReader3 {
    static IID := "{4579BB7C-741D-4161-B5A1-47BD3B78AD9B}"
    GetOptionalPackageInfo(optionalPackageInfo)
      => ComCall(15, this.p, IAppxManifestOptionalPackageInfo.Ptr, optionalPackageInfo)
}
struct IAppxManifestReader5 extends IUnknown {
    static IID := "{8D7AE132-A690-4C00-B75A-6AAE1FEAAC80}"
    GetMainPackageDependencies(mainPackageDependencies)
      => ComCall(3, this.p, IAppxManifestMainPackageDependenciesEnumerator.Ptr, mainPackageDependencies)
}
struct IAppxManifestReader6 extends IUnknown {
    static IID := "{34DEACA4-D3C0-4E3E-B312-E42625E3807E}"
    GetIsNonQualifiedResourcePackage(isNonQualifiedResourcePackage)
      => ComCall(3, this.p, BOOL.Ptr, isNonQualifiedResourcePackage)
}
struct IAppxManifestReader7 extends IUnknown {
    static IID := "{8EFE6F27-0CE0-4988-B32D-738EB63DB3B7}"
    GetDriverDependencies(driverDependencies)
      => ComCall(3, this.p, IAppxManifestDriverDependenciesEnumerator.Ptr, driverDependencies)
    GetOSPackageDependencies(osPackageDependencies)
      => ComCall(4, this.p, IAppxManifestOSPackageDependenciesEnumerator.Ptr, osPackageDependencies)
    GetHostRuntimeDependencies(hostRuntimeDependencies)
      => ComCall(5, this.p, IAppxManifestHostRuntimeDependenciesEnumerator.Ptr, hostRuntimeDependencies)
}
struct IAppxManifestDriverDependenciesEnumerator extends IUnknown {
    static IID := "{FE039DB2-467F-4755-8404-8F5EB6865B33}"
    GetCurrent(driverDependency)
      => ComCall(3, this.p, IAppxManifestDriverDependency.Ptr, driverDependency)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestDriverDependency extends IUnknown {
    static IID := "{1210CB94-5A92-4602-BE24-79F318AF4AF9}"
    GetDriverConstraints(driverConstraints)
      => ComCall(3, this.p, IAppxManifestDriverConstraintsEnumerator.Ptr, driverConstraints)
}
struct IAppxManifestDriverConstraintsEnumerator extends IUnknown {
    static IID := "{D402B2D1-F600-49E0-95E6-975D8DA13D89}"
    GetCurrent(driverConstraint)
      => ComCall(3, this.p, IAppxManifestDriverConstraint.Ptr, driverConstraint)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestDriverConstraint extends IUnknown {
    static IID := "{C031BEE4-BBCC-48EA-A237-C34045C80A07}"
    GetName(name)
      => ComCall(3, this.p, PWSTR.Ptr, name)
    GetMinVersion(minVersion)
      => ComCall(4, this.p, Int64.Ptr, minVersion)
    GetMinDate(minDate)
      => ComCall(5, this.p, PWSTR.Ptr, minDate)
}
struct IAppxManifestOSPackageDependenciesEnumerator extends IUnknown {
    static IID := "{B84E2FC3-F8EC-4BC1-8AE2-156346F5FFEA}"
    GetCurrent(osPackageDependency)
      => ComCall(3, this.p, IAppxManifestOSPackageDependency.Ptr, osPackageDependency)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestOSPackageDependency extends IUnknown {
    static IID := "{154995EE-54A6-4F14-AC97-D8CF0519644B}"
    GetName(name)
      => ComCall(3, this.p, PWSTR.Ptr, name)
    GetVersion(version)
      => ComCall(4, this.p, Int64.Ptr, version)
}
struct IAppxManifestHostRuntimeDependenciesEnumerator extends IUnknown {
    static IID := "{6427A646-7F49-433E-B1A6-0DA309F6885A}"
    GetCurrent(hostRuntimeDependency)
      => ComCall(3, this.p, IAppxManifestHostRuntimeDependency.Ptr, hostRuntimeDependency)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestHostRuntimeDependency extends IUnknown {
    static IID := "{3455D234-8414-410D-95C7-7B35255B8391}"
    GetName(name)
      => ComCall(3, this.p, PWSTR.Ptr, name)
    GetPublisher(publisher)
      => ComCall(4, this.p, PWSTR.Ptr, publisher)
    GetMinVersion(minVersion)
      => ComCall(5, this.p, Int64.Ptr, minVersion)
}
struct IAppxManifestHostRuntimeDependency2 extends IUnknown {
    static IID := "{C26F23A8-EE10-4AD6-B898-2B4D7AEBFE6A}"
    GetPackageFamilyName(packageFamilyName)
      => ComCall(3, this.p, PWSTR.Ptr, packageFamilyName)
}
struct IAppxManifestOptionalPackageInfo extends IUnknown {
    static IID := "{2634847D-5B5D-4FE5-A243-002FF95EDC7E}"
    GetIsOptionalPackage(isOptionalPackage)
      => ComCall(3, this.p, BOOL.Ptr, isOptionalPackage)
    GetMainPackageName(mainPackageName)
      => ComCall(4, this.p, PWSTR.Ptr, mainPackageName)
}
struct IAppxManifestMainPackageDependenciesEnumerator extends IUnknown {
    static IID := "{A99C4F00-51D2-4F0F-BA46-7ED5255EBDFF}"
    GetCurrent(mainPackageDependency)
      => ComCall(3, this.p, IAppxManifestMainPackageDependency.Ptr, mainPackageDependency)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestMainPackageDependency extends IUnknown {
    static IID := "{05D0611C-BC29-46D5-97E2-84B9C79BD8AE}"
    GetName(name)
      => ComCall(3, this.p, PWSTR.Ptr, name)
    GetPublisher(publisher)
      => ComCall(4, this.p, PWSTR.Ptr, publisher)
    GetPackageFamilyName(packageFamilyName)
      => ComCall(5, this.p, PWSTR.Ptr, packageFamilyName)
}
struct IAppxManifestPackageId extends IUnknown {
    static IID := "{283CE2D7-7153-4A91-9649-7A0F7240945F}"
    GetName(name)
      => ComCall(3, this.p, PWSTR.Ptr, name)
    GetArchitecture(architecture)
      => ComCall(4, this.p, APPX_PACKAGE_ARCHITECTURE.Ptr, architecture)
    GetPublisher(publisher)
      => ComCall(5, this.p, PWSTR.Ptr, publisher)
    GetVersion(packageVersion)
      => ComCall(6, this.p, Int64.Ptr, packageVersion)
    GetResourceId(resourceId)
      => ComCall(7, this.p, PWSTR.Ptr, resourceId)
    ComparePublisher(other, isSame)
      => ComCall(8, this.p, "Str", other, BOOL.Ptr, isSame)
    GetPackageFullName(packageFullName)
      => ComCall(9, this.p, PWSTR.Ptr, packageFullName)
    GetPackageFamilyName(packageFamilyName)
      => ComCall(10, this.p, PWSTR.Ptr, packageFamilyName)
}
struct IAppxManifestPackageId2 extends IAppxManifestPackageId {
    static IID := "{2256999D-D617-42F1-880E-0BA4542319D5}"
    GetArchitecture2(architecture)
      => ComCall(11, this.p, APPX_PACKAGE_ARCHITECTURE2.Ptr, architecture)
}
struct IAppxManifestProperties extends IUnknown {
    static IID := "{03FAF64D-F26F-4B2C-AAF7-8FE7789B8BCA}"
    GetBoolValue(name, value)
      => ComCall(3, this.p, "Str", name, BOOL.Ptr, value)
    GetStringValue(name, value)
      => ComCall(4, this.p, "Str", name, PWSTR.Ptr, value)
}
struct IAppxManifestTargetDeviceFamiliesEnumerator extends IUnknown {
    static IID := "{36537F36-27A4-4788-88C0-733819575017}"
    GetCurrent(targetDeviceFamily)
      => ComCall(3, this.p, IAppxManifestTargetDeviceFamily.Ptr, targetDeviceFamily)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestTargetDeviceFamily extends IUnknown {
    static IID := "{9091B09B-C8D5-4F31-8687-A338259FAEFB}"
    GetName(name)
      => ComCall(3, this.p, PWSTR.Ptr, name)
    GetMinVersion(minVersion)
      => ComCall(4, this.p, Int64.Ptr, minVersion)
    GetMaxVersionTested(maxVersionTested)
      => ComCall(5, this.p, Int64.Ptr, maxVersionTested)
}
struct IAppxManifestPackageDependenciesEnumerator extends IUnknown {
    static IID := "{B43BBCF9-65A6-42DD-BAC0-8C6741E7F5A4}"
    GetCurrent(dependency)
      => ComCall(3, this.p, IAppxManifestPackageDependency.Ptr, dependency)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestPackageDependency extends IUnknown {
    static IID := "{E4946B59-733E-43F0-A724-3BDE4C1285A0}"
    GetName(name)
      => ComCall(3, this.p, PWSTR.Ptr, name)
    GetPublisher(publisher)
      => ComCall(4, this.p, PWSTR.Ptr, publisher)
    GetMinVersion(minVersion)
      => ComCall(5, this.p, Int64.Ptr, minVersion)
}
struct IAppxManifestPackageDependency2 extends IAppxManifestPackageDependency {
    static IID := "{DDA0B713-F3FF-49D3-898A-2786780C5D98}"
    GetMaxMajorVersionTested(maxMajorVersionTested)
      => ComCall(6, this.p, UInt16.Ptr, maxMajorVersionTested)
}
struct IAppxManifestPackageDependency3 extends IUnknown {
    static IID := "{1AC56374-6198-4D6B-92E4-749D5AB8A895}"
    GetIsOptional(isOptional)
      => ComCall(3, this.p, BOOL.Ptr, isOptional)
}
struct IAppxManifestResourcesEnumerator extends IUnknown {
    static IID := "{DE4DFBBD-881A-48BB-858C-D6F2BAEAE6ED}"
    GetCurrent(resource)
      => ComCall(3, this.p, PWSTR.Ptr, resource)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestDeviceCapabilitiesEnumerator extends IUnknown {
    static IID := "{30204541-427B-4A1C-BACF-655BF463A540}"
    GetCurrent(deviceCapability)
      => ComCall(3, this.p, PWSTR.Ptr, deviceCapability)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestCapabilitiesEnumerator extends IUnknown {
    static IID := "{11D22258-F470-42C1-B291-8361C5437E41}"
    GetCurrent(capability)
      => ComCall(3, this.p, PWSTR.Ptr, capability)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestApplicationsEnumerator extends IUnknown {
    static IID := "{9EB8A55A-F04B-4D0D-808D-686185D4847A}"
    GetCurrent(application)
      => ComCall(3, this.p, IAppxManifestApplication.Ptr, application)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestApplication extends IUnknown {
    static IID := "{5DA89BF4-3773-46BE-B650-7E744863B7E8}"
    GetStringValue(name, value)
      => ComCall(3, this.p, "Str", name, PWSTR.Ptr, value)
    GetAppUserModelId(appUserModelId)
      => ComCall(4, this.p, PWSTR.Ptr, appUserModelId)
}
struct IAppxManifestQualifiedResourcesEnumerator extends IUnknown {
    static IID := "{8EF6ADFE-3762-4A8F-9373-2FC5D444C8D2}"
    GetCurrent(resource)
      => ComCall(3, this.p, IAppxManifestQualifiedResource.Ptr, resource)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxManifestQualifiedResource extends IUnknown {
    static IID := "{3B53A497-3C5C-48D1-9EA3-BB7EAC8CD7D4}"
    GetLanguage(language)
      => ComCall(3, this.p, PWSTR.Ptr, language)
    GetScale(scale)
      => ComCall(4, this.p, UInt32.Ptr, scale)
    GetDXFeatureLevel(dxFeatureLevel)
      => ComCall(5, this.p, DX_FEATURE_LEVEL.Ptr, dxFeatureLevel)
}
struct IAppxBundleFactory extends IUnknown {
    static IID := "{BBA65864-965F-4A5F-855F-F074BDBF3A7B}"
    CreateBundleWriter(outputStream, bundleVersion, bundleWriter)
      => ComCall(3, this.p, IStream, outputStream, Int64, bundleVersion, IAppxBundleWriter.Ptr, bundleWriter)
    CreateBundleReader(inputStream, bundleReader)
      => ComCall(4, this.p, IStream, inputStream, IAppxBundleReader.Ptr, bundleReader)
    CreateBundleManifestReader(inputStream, manifestReader)
      => ComCall(5, this.p, IStream, inputStream, IAppxBundleManifestReader.Ptr, manifestReader)
}
struct IAppxBundleFactory2 extends IUnknown {
    static IID := "{7325B83D-0185-42C4-82AC-BE34AB1A2A8A}"
    CreateBundleReader2(inputStream, expectedDigest, bundleReader)
      => ComCall(3, this.p, IStream, inputStream, "Str", expectedDigest, IAppxBundleReader.Ptr, bundleReader)
}
struct IAppxBundleFactory3 extends IUnknown {
    static IID := "{D11EA6B6-3909-4376-B7C4-10D50F5CF3AE}"
    CreateBundleReaderFromSourceUri(uri, expectedDigest, bundleReader)
      => ComCall(3, this.p, "Str", uri, "Str", expectedDigest, IAppxBundleReader.Ptr, bundleReader)
}
struct IAppxBundleWriter extends IUnknown {
    static IID := "{EC446FE8-BFEC-4C64-AB4F-49F038F0C6D2}"
    AddPayloadPackage(fileName, packageStream)
      => ComCall(3, this.p, "Str", fileName, IStream, packageStream)
    Close()
      => ComCall(4, this.p)
}
struct IAppxBundleWriter2 extends IUnknown {
    static IID := "{6D8FE971-01CC-49A0-B685-233851279962}"
    AddExternalPackageReference(fileName, inputStream)
      => ComCall(3, this.p, "Str", fileName, IStream, inputStream)
}
struct IAppxBundleWriter3 extends IUnknown {
    static IID := "{AD711152-F969-4193-82D5-9DDF2786D21A}"
    AddPackageReference(fileName, inputStream)
      => ComCall(3, this.p, "Str", fileName, IStream, inputStream)
    Close(hashMethodString)
      => ComCall(4, this.p, "Str", hashMethodString)
}
struct IAppxBundleWriter4 extends IUnknown {
    static IID := "{9CD9D523-5009-4C01-9882-DC029FBD47A3}"
    AddPayloadPackage(fileName, packageStream, isDefaultApplicablePackage)
      => ComCall(3, this.p, "Str", fileName, IStream, packageStream, BOOL, isDefaultApplicablePackage)
    AddPackageReference(fileName, inputStream, isDefaultApplicablePackage)
      => ComCall(4, this.p, "Str", fileName, IStream, inputStream, BOOL, isDefaultApplicablePackage)
    AddExternalPackageReference(fileName, inputStream, isDefaultApplicablePackage)
      => ComCall(5, this.p, "Str", fileName, IStream, inputStream, BOOL, isDefaultApplicablePackage)
}
struct IAppxBundleReader extends IUnknown {
    static IID := "{DD75B8C0-BA76-43B0-AE0F-68656A1DC5C8}"
    GetFootprintFile(fileType, footprintFile)
      => ComCall(3, this.p, APPX_BUNDLE_FOOTPRINT_FILE_TYPE, fileType, IAppxFile.Ptr, footprintFile)
    GetBlockMap(blockMapReader)
      => ComCall(4, this.p, IAppxBlockMapReader.Ptr, blockMapReader)
    GetManifest(manifestReader)
      => ComCall(5, this.p, IAppxBundleManifestReader.Ptr, manifestReader)
    GetPayloadPackages(payloadPackages)
      => ComCall(6, this.p, IAppxFilesEnumerator.Ptr, payloadPackages)
    GetPayloadPackage(fileName, payloadPackage)
      => ComCall(7, this.p, "Str", fileName, IAppxFile.Ptr, payloadPackage)
}
struct IAppxBundleReader2 extends IUnknown {
    static IID := "{98262195-D63A-4C10-B4CF-DD72E061BA87}"
    GetPayloadPackageReader(fileName, payloadPackageReader)
      => ComCall(3, this.p, "Str", fileName, IAppxPackageReader.Ptr, payloadPackageReader)
}
struct IAppxBundleManifestReader extends IUnknown {
    static IID := "{CF0EBBC1-CC99-4106-91EB-E67462E04FB0}"
    GetPackageId(packageId)
      => ComCall(3, this.p, IAppxManifestPackageId.Ptr, packageId)
    GetPackageInfoItems(packageInfoItems)
      => ComCall(4, this.p, IAppxBundleManifestPackageInfoEnumerator.Ptr, packageInfoItems)
    GetStream(manifestStream)
      => ComCall(5, this.p, IStream.Ptr, manifestStream)
}
struct IAppxBundleManifestReader2 extends IUnknown {
    static IID := "{5517DF70-033F-4AF2-8213-87D766805C02}"
    GetOptionalBundles(optionalBundles)
      => ComCall(3, this.p, IAppxBundleManifestOptionalBundleInfoEnumerator.Ptr, optionalBundles)
}
struct IAppxBundleManifestPackageInfoEnumerator extends IUnknown {
    static IID := "{F9B856EE-49A6-4E19-B2B0-6A2406D63A32}"
    GetCurrent(packageInfo)
      => ComCall(3, this.p, IAppxBundleManifestPackageInfo.Ptr, packageInfo)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxBundleManifestPackageInfo extends IUnknown {
    static IID := "{54CD06C1-268F-40BB-8ED2-757A9EBAEC8D}"
    GetPackageType(packageType)
      => ComCall(3, this.p, APPX_BUNDLE_PAYLOAD_PACKAGE_TYPE.Ptr, packageType)
    GetPackageId(packageId)
      => ComCall(4, this.p, IAppxManifestPackageId.Ptr, packageId)
    GetFileName(fileName)
      => ComCall(5, this.p, PWSTR.Ptr, fileName)
    GetOffset(offset)
      => ComCall(6, this.p, Int64.Ptr, offset)
    GetSize(size)
      => ComCall(7, this.p, Int64.Ptr, size)
    GetResources(resources)
      => ComCall(8, this.p, IAppxManifestQualifiedResourcesEnumerator.Ptr, resources)
}
struct IAppxBundleManifestPackageInfo2 extends IUnknown {
    static IID := "{44C2ACBC-B2CF-4CCB-BBDB-9C6DA8C3BC9E}"
    GetIsPackageReference(isPackageReference)
      => ComCall(3, this.p, BOOL.Ptr, isPackageReference)
    GetIsNonQualifiedResourcePackage(isNonQualifiedResourcePackage)
      => ComCall(4, this.p, BOOL.Ptr, isNonQualifiedResourcePackage)
    GetIsDefaultApplicablePackage(isDefaultApplicablePackage)
      => ComCall(5, this.p, BOOL.Ptr, isDefaultApplicablePackage)
}
struct IAppxBundleManifestPackageInfo3 extends IUnknown {
    static IID := "{6BA74B98-BB74-4296-80D0-5F4256A99675}"
    GetTargetDeviceFamilies(targetDeviceFamilies)
      => ComCall(3, this.p, IAppxManifestTargetDeviceFamiliesEnumerator.Ptr, targetDeviceFamilies)
}
struct IAppxBundleManifestPackageInfo4 extends IUnknown {
    static IID := "{5DA6F13D-A8A7-4532-857C-1393D659371D}"
    GetIsStub(isStub)
      => ComCall(3, this.p, BOOL.Ptr, isStub)
}
struct IAppxBundleManifestOptionalBundleInfoEnumerator extends IUnknown {
    static IID := "{9A178793-F97E-46AC-AACA-DD5BA4C177C8}"
    GetCurrent(optionalBundle)
      => ComCall(3, this.p, IAppxBundleManifestOptionalBundleInfo.Ptr, optionalBundle)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxBundleManifestOptionalBundleInfo extends IUnknown {
    static IID := "{515BF2E8-BCB0-4D69-8C48-E383147B6E12}"
    GetPackageId(packageId)
      => ComCall(3, this.p, IAppxManifestPackageId.Ptr, packageId)
    GetFileName(fileName)
      => ComCall(4, this.p, PWSTR.Ptr, fileName)
    GetPackageInfoItems(packageInfoItems)
      => ComCall(5, this.p, IAppxBundleManifestPackageInfoEnumerator.Ptr, packageInfoItems)
}
struct IAppxContentGroupFilesEnumerator extends IUnknown {
    static IID := "{1A09A2FD-7440-44EB-8C84-848205A6A1CC}"
    GetCurrent(file)
      => ComCall(3, this.p, PWSTR.Ptr, file)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxContentGroup extends IUnknown {
    static IID := "{328F6468-C04F-4E3C-B6FA-6B8D27F3003A}"
    GetName(groupName)
      => ComCall(3, this.p, PWSTR.Ptr, groupName)
    GetFiles(enumerator)
      => ComCall(4, this.p, IAppxContentGroupFilesEnumerator.Ptr, enumerator)
}
struct IAppxContentGroupsEnumerator extends IUnknown {
    static IID := "{3264E477-16D1-4D63-823E-7D2984696634}"
    GetCurrent(stream)
      => ComCall(3, this.p, IAppxContentGroup.Ptr, stream)
    GetHasCurrent(hasCurrent)
      => ComCall(4, this.p, BOOL.Ptr, hasCurrent)
    MoveNext(hasNext)
      => ComCall(5, this.p, BOOL.Ptr, hasNext)
}
struct IAppxContentGroupMapReader extends IUnknown {
    static IID := "{418726D8-DD99-4F5D-9886-157ADD20DE01}"
    GetRequiredGroup(requiredGroup)
      => ComCall(3, this.p, IAppxContentGroup.Ptr, requiredGroup)
    GetAutomaticGroups(automaticGroupsEnumerator)
      => ComCall(4, this.p, IAppxContentGroupsEnumerator.Ptr, automaticGroupsEnumerator)
}
struct IAppxSourceContentGroupMapReader extends IUnknown {
    static IID := "{F329791D-540B-4A9F-BC75-3282B7D73193}"
    GetRequiredGroup(requiredGroup)
      => ComCall(3, this.p, IAppxContentGroup.Ptr, requiredGroup)
    GetAutomaticGroups(automaticGroupsEnumerator)
      => ComCall(4, this.p, IAppxContentGroupsEnumerator.Ptr, automaticGroupsEnumerator)
}
struct IAppxContentGroupMapWriter extends IUnknown {
    static IID := "{D07AB776-A9DE-4798-8C14-3DB31E687C78}"
    AddAutomaticGroup(groupName)
      => ComCall(3, this.p, "Str", groupName)
    AddAutomaticFile(fileName)
      => ComCall(4, this.p, "Str", fileName)
    Close()
      => ComCall(5, this.p)
}
struct IAppxPackagingDiagnosticEventSink extends IUnknown {
    static IID := "{17239D47-6ADB-45D2-80F6-F9CBC3BF059D}"
    ReportContextChange(changeType, contextId, contextName, contextMessage, detailsMessage)
      => ComCall(3, this.p, APPX_PACKAGING_CONTEXT_CHANGE_TYPE, changeType, Int32, contextId, PSTR, contextName, "Str", contextMessage, "Str", detailsMessage)
    ReportError(errorMessage)
      => ComCall(4, this.p, "Str", errorMessage)
}
struct IAppxPackagingDiagnosticEventSinkManager extends IUnknown {
    static IID := "{369648FA-A7EB-4909-A15D-6954A078F18A}"
    SetSinkForProcess(sink)
      => ComCall(3, this.p, IAppxPackagingDiagnosticEventSink, sink)
}
struct IAppxAppInstallerReader extends IUnknown {
    static IID := "{F35BC38C-1D2F-43DB-A1F4-586430D1FED2}"
    GetXmlDom(dom)
      => ComCall(3, this.p, IXMLDOMDocument.Ptr, dom)
}
struct IAppxDigestProvider extends IUnknown {
    static IID := "{9FE2702B-7640-4659-8E6C-349E43C4CDBD}"
    GetDigest(digest)
      => ComCall(3, this.p, PWSTR.Ptr, digest)
}
struct APPX_ENCRYPTED_PACKAGE_SETTINGS {
    keyLength : UInt32
    encryptionAlgorithm : PWSTR
    useDiffusion : BOOL
    blockMapHashAlgorithm : IUri
}
struct APPX_ENCRYPTED_PACKAGE_OPTIONS extends Int32 {
    static APPX_ENCRYPTED_PACKAGE_OPTION_NONE := 0
    static APPX_ENCRYPTED_PACKAGE_OPTION_DIFFUSION := 1
    static APPX_ENCRYPTED_PACKAGE_OPTION_PAGE_HASHING := 2
}
struct APPX_ENCRYPTED_PACKAGE_SETTINGS2 {
    keyLength : UInt32
    encryptionAlgorithm : PWSTR
    blockMapHashAlgorithm : IUri
    options : UInt32
}
struct APPX_KEY_INFO {
    keyLength : UInt32
    keyIdLength : UInt32
    key : UInt8.Ptr
    keyId : UInt8.Ptr
}
struct APPX_ENCRYPTED_EXEMPTIONS {
    count : UInt32
    plainTextFiles : PWSTR.Ptr
}
struct IAppxEncryptionFactory extends IUnknown {
    static IID := "{80E8E04D-8C88-44AE-A011-7CADF6FB2E72}"
    EncryptPackage(inputStream, outputStream, settings, keyInfo, exemptedFiles)
      => ComCall(3, this.p, IStream, inputStream, IStream, outputStream, APPX_ENCRYPTED_PACKAGE_SETTINGS.Ptr, settings, APPX_KEY_INFO.Ptr, keyInfo, APPX_ENCRYPTED_EXEMPTIONS.Ptr, exemptedFiles)
    DecryptPackage(inputStream, outputStream, keyInfo)
      => ComCall(4, this.p, IStream, inputStream, IStream, outputStream, APPX_KEY_INFO.Ptr, keyInfo)
    CreateEncryptedPackageWriter(outputStream, manifestStream, settings, keyInfo, exemptedFiles, packageWriter)
      => ComCall(5, this.p, IStream, outputStream, IStream, manifestStream, APPX_ENCRYPTED_PACKAGE_SETTINGS.Ptr, settings, APPX_KEY_INFO.Ptr, keyInfo, APPX_ENCRYPTED_EXEMPTIONS.Ptr, exemptedFiles, IAppxEncryptedPackageWriter.Ptr, packageWriter)
    CreateEncryptedPackageReader(inputStream, keyInfo, packageReader)
      => ComCall(6, this.p, IStream, inputStream, APPX_KEY_INFO.Ptr, keyInfo, IAppxPackageReader.Ptr, packageReader)
    EncryptBundle(inputStream, outputStream, settings, keyInfo, exemptedFiles)
      => ComCall(7, this.p, IStream, inputStream, IStream, outputStream, APPX_ENCRYPTED_PACKAGE_SETTINGS.Ptr, settings, APPX_KEY_INFO.Ptr, keyInfo, APPX_ENCRYPTED_EXEMPTIONS.Ptr, exemptedFiles)
    DecryptBundle(inputStream, outputStream, keyInfo)
      => ComCall(8, this.p, IStream, inputStream, IStream, outputStream, APPX_KEY_INFO.Ptr, keyInfo)
    CreateEncryptedBundleWriter(outputStream, bundleVersion, settings, keyInfo, exemptedFiles, bundleWriter)
      => ComCall(9, this.p, IStream, outputStream, Int64, bundleVersion, APPX_ENCRYPTED_PACKAGE_SETTINGS.Ptr, settings, APPX_KEY_INFO.Ptr, keyInfo, APPX_ENCRYPTED_EXEMPTIONS.Ptr, exemptedFiles, IAppxEncryptedBundleWriter.Ptr, bundleWriter)
    CreateEncryptedBundleReader(inputStream, keyInfo, bundleReader)
      => ComCall(10, this.p, IStream, inputStream, APPX_KEY_INFO.Ptr, keyInfo, IAppxBundleReader.Ptr, bundleReader)
}
struct IAppxEncryptionFactory2 extends IUnknown {
    static IID := "{C1B11EEE-C4BA-4AB2-A55D-D015FE8FF64F}"
    CreateEncryptedPackageWriter(outputStream, manifestStream, contentGroupMapStream, settings, keyInfo, exemptedFiles, packageWriter)
      => ComCall(3, this.p, IStream, outputStream, IStream, manifestStream, IStream, contentGroupMapStream, APPX_ENCRYPTED_PACKAGE_SETTINGS.Ptr, settings, APPX_KEY_INFO.Ptr, keyInfo, APPX_ENCRYPTED_EXEMPTIONS.Ptr, exemptedFiles, IAppxEncryptedPackageWriter.Ptr, packageWriter)
}
struct IAppxEncryptionFactory3 extends IUnknown {
    static IID := "{09EDCA37-CD64-47D6-B7E8-1CB11D4F7E05}"
    EncryptPackage(inputStream, outputStream, settings, keyInfo, exemptedFiles)
      => ComCall(3, this.p, IStream, inputStream, IStream, outputStream, APPX_ENCRYPTED_PACKAGE_SETTINGS2.Ptr, settings, APPX_KEY_INFO.Ptr, keyInfo, APPX_ENCRYPTED_EXEMPTIONS.Ptr, exemptedFiles)
    CreateEncryptedPackageWriter(outputStream, manifestStream, contentGroupMapStream, settings, keyInfo, exemptedFiles, packageWriter)
      => ComCall(4, this.p, IStream, outputStream, IStream, manifestStream, IStream, contentGroupMapStream, APPX_ENCRYPTED_PACKAGE_SETTINGS2.Ptr, settings, APPX_KEY_INFO.Ptr, keyInfo, APPX_ENCRYPTED_EXEMPTIONS.Ptr, exemptedFiles, IAppxEncryptedPackageWriter.Ptr, packageWriter)
    EncryptBundle(inputStream, outputStream, settings, keyInfo, exemptedFiles)
      => ComCall(5, this.p, IStream, inputStream, IStream, outputStream, APPX_ENCRYPTED_PACKAGE_SETTINGS2.Ptr, settings, APPX_KEY_INFO.Ptr, keyInfo, APPX_ENCRYPTED_EXEMPTIONS.Ptr, exemptedFiles)
    CreateEncryptedBundleWriter(outputStream, bundleVersion, settings, keyInfo, exemptedFiles, bundleWriter)
      => ComCall(6, this.p, IStream, outputStream, Int64, bundleVersion, APPX_ENCRYPTED_PACKAGE_SETTINGS2.Ptr, settings, APPX_KEY_INFO.Ptr, keyInfo, APPX_ENCRYPTED_EXEMPTIONS.Ptr, exemptedFiles, IAppxEncryptedBundleWriter.Ptr, bundleWriter)
}
struct IAppxEncryptionFactory4 extends IUnknown {
    static IID := "{A879611F-12FD-41FE-85D5-06AE779BBAF5}"
    EncryptPackage(inputStream, outputStream, settings, keyInfo, exemptedFiles, memoryLimit)
      => ComCall(3, this.p, IStream, inputStream, IStream, outputStream, APPX_ENCRYPTED_PACKAGE_SETTINGS2.Ptr, settings, APPX_KEY_INFO.Ptr, keyInfo, APPX_ENCRYPTED_EXEMPTIONS.Ptr, exemptedFiles, Int64, memoryLimit)
}
struct IAppxEncryptionFactory5 extends IUnknown {
    static IID := "{68D6E77A-F446-480F-B0F0-D91A24C60746}"
    CreateEncryptedPackageReader2(inputStream, keyInfo, expectedDigest, packageReader)
      => ComCall(3, this.p, IStream, inputStream, APPX_KEY_INFO.Ptr, keyInfo, "Str", expectedDigest, IAppxPackageReader.Ptr, packageReader)
    CreateEncryptedBundleReader2(inputStream, keyInfo, expectedDigest, bundleReader)
      => ComCall(4, this.p, IStream, inputStream, APPX_KEY_INFO.Ptr, keyInfo, "Str", expectedDigest, IAppxBundleReader.Ptr, bundleReader)
}
struct IAppxEncryptedPackageWriter extends IUnknown {
    static IID := "{F43D0B0B-1379-40E2-9B29-682EA2BF42AF}"
    AddPayloadFileEncrypted(fileName, compressionOption, inputStream)
      => ComCall(3, this.p, "Str", fileName, APPX_COMPRESSION_OPTION, compressionOption, IStream, inputStream)
    Close()
      => ComCall(4, this.p)
}
struct IAppxEncryptedPackageWriter2 extends IUnknown {
    static IID := "{3E475447-3A25-40B5-8AD2-F953AE50C92D}"
    AddPayloadFilesEncrypted(payloadFiles, memoryLimit)
      => ComCall(3, this.p, UInt32, payloadFiles.Length, APPX_PACKAGE_WRITER_PAYLOAD_STREAM.Ptr, payloadFiles, Int64, memoryLimit)
}
struct IAppxEncryptedBundleWriter extends IUnknown {
    static IID := "{80B0902F-7BF0-4117-B8C6-4279EF81EE77}"
    AddPayloadPackageEncrypted(fileName, packageStream)
      => ComCall(3, this.p, "Str", fileName, IStream, packageStream)
    Close()
      => ComCall(4, this.p)
}
struct IAppxEncryptedBundleWriter2 extends IUnknown {
    static IID := "{E644BE82-F0FA-42B8-A956-8D1CB48EE379}"
    AddExternalPackageReference(fileName, inputStream)
      => ComCall(3, this.p, "Str", fileName, IStream, inputStream)
}
struct APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION extends Int32 {
    static APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION_APPEND_DELTA := 0
}
struct APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTIONS extends Int32 {
    static APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_NONE := 0
    static APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_SKIP_VALIDATION := 1
    static APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTION_LOCALIZED := 2
}
struct IAppxEncryptedBundleWriter3 extends IUnknown {
    static IID := "{0D34DEB3-5CAE-4DD3-977C-504932A51D31}"
    AddPayloadPackageEncrypted(fileName, packageStream, isDefaultApplicablePackage)
      => ComCall(3, this.p, "Str", fileName, IStream, packageStream, BOOL, isDefaultApplicablePackage)
    AddExternalPackageReference(fileName, inputStream, isDefaultApplicablePackage)
      => ComCall(4, this.p, "Str", fileName, IStream, inputStream, BOOL, isDefaultApplicablePackage)
}
struct IAppxPackageEditor extends IUnknown {
    static IID := "{E2ADB6DC-5E71-4416-86B6-86E5F5291A6B}"
    SetWorkingDirectory(workingDirectory)
      => ComCall(3, this.p, "Str", workingDirectory)
    CreateDeltaPackage(updatedPackageStream, baselinePackageStream, deltaPackageStream)
      => ComCall(4, this.p, IStream, updatedPackageStream, IStream, baselinePackageStream, IStream, deltaPackageStream)
    CreateDeltaPackageUsingBaselineBlockMap(updatedPackageStream, baselineBlockMapStream, baselinePackageFullName, deltaPackageStream)
      => ComCall(5, this.p, IStream, updatedPackageStream, IStream, baselineBlockMapStream, "Str", baselinePackageFullName, IStream, deltaPackageStream)
    UpdatePackage(baselinePackageStream, deltaPackageStream, updateOption)
      => ComCall(6, this.p, IStream, baselinePackageStream, IStream, deltaPackageStream, APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION, updateOption)
    UpdateEncryptedPackage(baselineEncryptedPackageStream, deltaPackageStream, updateOption, settings, keyInfo)
      => ComCall(7, this.p, IStream, baselineEncryptedPackageStream, IStream, deltaPackageStream, APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_OPTION, updateOption, APPX_ENCRYPTED_PACKAGE_SETTINGS2.Ptr, settings, APPX_KEY_INFO.Ptr, keyInfo)
    UpdatePackageManifest(packageStream, updatedManifestStream, isPackageEncrypted, options)
      => ComCall(8, this.p, IStream, packageStream, IStream, updatedManifestStream, BOOL, isPackageEncrypted, APPX_PACKAGE_EDITOR_UPDATE_PACKAGE_MANIFEST_OPTIONS, options)
}
struct PACKAGE_VERSION {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Version : Int64
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            Revision : UInt16
            Build : UInt16
            Minor : UInt16
            Major : UInt16
        }
    }
}
struct PackagePathType extends Int32 {
    static PackagePathType_Install := 0
    static PackagePathType_Mutable := 1
    static PackagePathType_Effective := 2
    static PackagePathType_MachineExternal := 3
    static PackagePathType_UserExternal := 4
    static PackagePathType_EffectiveExternal := 5
}
struct PackageOrigin extends Int32 {
    static PackageOrigin_Unknown := 0
    static PackageOrigin_Unsigned := 1
    static PackageOrigin_Inbox := 2
    static PackageOrigin_Store := 3
    static PackageOrigin_DeveloperUnsigned := 4
    static PackageOrigin_DeveloperSigned := 5
    static PackageOrigin_LineOfBusiness := 6
    static PackageOrigin_SignedSBOM := 7
}
struct PackageOrigin2 extends Int32 {
    static PackageOrigin2_Unknown := 0
    static PackageOrigin2_Unsigned := 1
    static PackageOrigin2_Inbox := 2
    static PackageOrigin2_Store := 3
    static PackageOrigin2_DeveloperUnsigned := 4
    static PackageOrigin2_DeveloperSigned := 5
    static PackageOrigin2_LineOfBusiness := 6
    static PackageOrigin2_SignedSBOM := 7
}
struct AppModelPackageFeature extends Int32 {
    static AppModelPackageFeature_SignedSBOM := 1
}
struct PACKAGE_INFO_REFERENCE {
    reserved : Struct.Ptr
}
struct CreatePackageDependencyOptions extends Int32 {
    static CreatePackageDependencyOptions_None := 0
    static CreatePackageDependencyOptions_DoNotVerifyDependencyResolution := 1
    static CreatePackageDependencyOptions_ScopeIsSystem := 2
}
struct PackageDependencyLifetimeKind extends Int32 {
    static PackageDependencyLifetimeKind_Process := 0
    static PackageDependencyLifetimeKind_FilePath := 1
    static PackageDependencyLifetimeKind_RegistryKey := 2
}
struct AddPackageDependencyOptions extends Int32 {
    static AddPackageDependencyOptions_None := 0
    static AddPackageDependencyOptions_PrependIfRankCollision := 1
}
struct AddPackageDependencyOptions2 extends Int32 {
    static AddPackageDependencyOptions2_None := 0
    static AddPackageDependencyOptions2_PrependIfRankCollision := 1
    static AddPackageDependencyOptions2_SpecifiedPackageFamilyOnly := 2
}
struct PackageDependencyProcessorArchitectures extends Int32 {
    static PackageDependencyProcessorArchitectures_None := 0
    static PackageDependencyProcessorArchitectures_Neutral := 1
    static PackageDependencyProcessorArchitectures_X86 := 2
    static PackageDependencyProcessorArchitectures_X64 := 4
    static PackageDependencyProcessorArchitectures_Arm := 8
    static PackageDependencyProcessorArchitectures_Arm64 := 16
    static PackageDependencyProcessorArchitectures_X86A64 := 32
}
struct FindPackageDependencyCriteria {
    User : PSID
    ScopeIsSystem : BOOL
    PackageFamilyName : PWSTR
}
struct AppPolicyLifecycleManagement extends Int32 {
    static AppPolicyLifecycleManagement_Unmanaged := 0
    static AppPolicyLifecycleManagement_Managed := 1
}
struct AppPolicyWindowingModel extends Int32 {
    static AppPolicyWindowingModel_None := 0
    static AppPolicyWindowingModel_Universal := 1
    static AppPolicyWindowingModel_ClassicDesktop := 2
    static AppPolicyWindowingModel_ClassicPhone := 3
}
struct AppPolicyMediaFoundationCodecLoading extends Int32 {
    static AppPolicyMediaFoundationCodecLoading_All := 0
    static AppPolicyMediaFoundationCodecLoading_InboxOnly := 1
}
struct AppPolicyClrCompat extends Int32 {
    static AppPolicyClrCompat_Other := 0
    static AppPolicyClrCompat_ClassicDesktop := 1
    static AppPolicyClrCompat_Universal := 2
    static AppPolicyClrCompat_PackagedDesktop := 3
}
struct AppPolicyThreadInitializationType extends Int32 {
    static AppPolicyThreadInitializationType_None := 0
    static AppPolicyThreadInitializationType_InitializeWinRT := 1
}
struct AppPolicyShowDeveloperDiagnostic extends Int32 {
    static AppPolicyShowDeveloperDiagnostic_None := 0
    static AppPolicyShowDeveloperDiagnostic_ShowUI := 1
}
struct AppPolicyProcessTerminationMethod extends Int32 {
    static AppPolicyProcessTerminationMethod_ExitProcess := 0
    static AppPolicyProcessTerminationMethod_TerminateProcess := 1
}
struct AppPolicyCreateFileAccess extends Int32 {
    static AppPolicyCreateFileAccess_Full := 0
    static AppPolicyCreateFileAccess_Limited := 1
}
struct PackageInfo3Type extends Int32 {
    static PackageInfo3Type_PackageInfoGeneration := 16
}
