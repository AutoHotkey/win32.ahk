#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct RDC_ErrorCode extends Int32 {
    static RDC_NoError := 0
    static RDC_HeaderVersionNewer := 1
    static RDC_HeaderVersionOlder := 2
    static RDC_HeaderMissingOrCorrupt := 3
    static RDC_HeaderWrongType := 4
    static RDC_DataMissingOrCorrupt := 5
    static RDC_DataTooManyRecords := 6
    static RDC_FileChecksumMismatch := 7
    static RDC_ApplicationError := 8
    static RDC_Aborted := 9
    static RDC_Win32Error := 10
}
struct GeneratorParametersType extends Int32 {
    static RDCGENTYPE_Unused := 0
    static RDCGENTYPE_FilterMax := 1
}
struct RdcNeedType extends Int32 {
    static RDCNEED_SOURCE := 0
    static RDCNEED_TARGET := 1
    static RDCNEED_SEED := 2
    static RDCNEED_SEED_MAX := 255
}
struct RdcNeed {
    m_BlockType : RdcNeedType
    m_FileOffset : Int64
    m_BlockLength : Int64
}
struct RdcBufferPointer {
    m_Size : UInt32
    m_Used : UInt32
    m_Data : UInt8.Ptr
}
struct RdcNeedPointer {
    m_Size : UInt32
    m_Used : UInt32
    m_Data : RdcNeed.Ptr
}
struct RdcSignature {
    m_Signature : UInt8[16]
    m_BlockLength : UInt16
}
struct RdcSignaturePointer {
    m_Size : UInt32
    m_Used : UInt32
    m_Data : RdcSignature.Ptr
}
struct RdcCreatedTables extends Int32 {
    static RDCTABLE_InvalidOrUnknown := 0
    static RDCTABLE_Existing := 1
    static RDCTABLE_New := 2
}
struct RdcMappingAccessMode extends Int32 {
    static RDCMAPPING_Undefined := 0
    static RDCMAPPING_ReadOnly := 1
    static RDCMAPPING_ReadWrite := 2
}
struct SimilarityMappedViewInfo {
    m_Data : UInt8.Ptr
    m_Length : UInt32
}
struct SimilarityData {
    m_Data : UInt8[16]
}
struct FindSimilarFileIndexResults {
    m_FileIndex : UInt32
    m_MatchCount : UInt32
}
struct SimilarityDumpData {
    m_FileIndex : UInt32
    m_Data : SimilarityData
}
struct SimilarityFileId {
    m_FileId : UInt8[32]
}
struct IRdcGeneratorParameters extends IUnknown {
    static IID := "{96236A71-9DBC-11DA-9E3F-0011114AE311}"
    GetGeneratorParametersType(parametersType)
      => ComCall(3, this.p, GeneratorParametersType.Ptr, parametersType)
    GetParametersVersion(currentVersion, minimumCompatibleAppVersion)
      => ComCall(4, this.p, UInt32.Ptr, currentVersion, UInt32.Ptr, minimumCompatibleAppVersion)
    GetSerializeSize(size)
      => ComCall(5, this.p, UInt32.Ptr, size)
    Serialize(size, parametersBlob, bytesWritten)
      => ComCall(6, this.p, UInt32, size, UInt8.Ptr, parametersBlob, UInt32.Ptr, bytesWritten)
}
struct IRdcGeneratorFilterMaxParameters extends IUnknown {
    static IID := "{96236A72-9DBC-11DA-9E3F-0011114AE311}"
    GetHorizonSize(horizonSize)
      => ComCall(3, this.p, UInt32.Ptr, horizonSize)
    SetHorizonSize(horizonSize)
      => ComCall(4, this.p, UInt32, horizonSize)
    GetHashWindowSize(hashWindowSize)
      => ComCall(5, this.p, UInt32.Ptr, hashWindowSize)
    SetHashWindowSize(hashWindowSize)
      => ComCall(6, this.p, UInt32, hashWindowSize)
}
struct IRdcGenerator extends IUnknown {
    static IID := "{96236A73-9DBC-11DA-9E3F-0011114AE311}"
    GetGeneratorParameters(level, iGeneratorParameters)
      => ComCall(3, this.p, UInt32, level, IRdcGeneratorParameters.Ptr, iGeneratorParameters)
    Process(endOfInput, endOfOutput, inputBuffer, outputBuffers, rdc_ErrorCode)
      => ComCall(4, this.p, BOOL, endOfInput, BOOL.Ptr, endOfOutput, RdcBufferPointer.Ptr, inputBuffer, UInt32, outputBuffers.Length, RdcBufferPointer.Ptr.Ptr, outputBuffers, RDC_ErrorCode.Ptr, rdc_ErrorCode)
}
struct IRdcFileReader extends IUnknown {
    static IID := "{96236A74-9DBC-11DA-9E3F-0011114AE311}"
    GetFileSize(fileSize)
      => ComCall(3, this.p, Int64.Ptr, fileSize)
    Read(offsetFileStart, bytesToRead, bytesActuallyRead, buffer, eof)
      => ComCall(4, this.p, Int64, offsetFileStart, UInt32, bytesToRead, UInt32.Ptr, bytesActuallyRead, UInt8.Ptr, buffer, BOOL.Ptr, eof)
    GetFilePosition(offsetFromStart)
      => ComCall(5, this.p, Int64.Ptr, offsetFromStart)
}
struct IRdcFileWriter extends IRdcFileReader {
    static IID := "{96236A75-9DBC-11DA-9E3F-0011114AE311}"
    Write(offsetFileStart, bytesToWrite, buffer)
      => ComCall(6, this.p, Int64, offsetFileStart, UInt32, bytesToWrite, UInt8.Ptr, buffer)
    Truncate()
      => ComCall(7, this.p)
    DeleteOnClose()
      => ComCall(8, this.p)
}
struct IRdcSignatureReader extends IUnknown {
    static IID := "{96236A76-9DBC-11DA-9E3F-0011114AE311}"
    ReadHeader(rdc_ErrorCode)
      => ComCall(3, this.p, RDC_ErrorCode.Ptr, rdc_ErrorCode)
    ReadSignatures(rdcSignaturePointer, endOfOutput)
      => ComCall(4, this.p, RdcSignaturePointer.Ptr, rdcSignaturePointer, BOOL.Ptr, endOfOutput)
}
struct IRdcComparator extends IUnknown {
    static IID := "{96236A77-9DBC-11DA-9E3F-0011114AE311}"
    Process(endOfInput, endOfOutput, inputBuffer, outputBuffer, rdc_ErrorCode)
      => ComCall(3, this.p, BOOL, endOfInput, BOOL.Ptr, endOfOutput, RdcBufferPointer.Ptr, inputBuffer, RdcNeedPointer.Ptr, outputBuffer, RDC_ErrorCode.Ptr, rdc_ErrorCode)
}
struct IRdcLibrary extends IUnknown {
    static IID := "{96236A78-9DBC-11DA-9E3F-0011114AE311}"
    ComputeDefaultRecursionDepth(fileSize, depth)
      => ComCall(3, this.p, Int64, fileSize, UInt32.Ptr, depth)
    CreateGeneratorParameters(parametersType, level, iGeneratorParameters)
      => ComCall(4, this.p, GeneratorParametersType, parametersType, UInt32, level, IRdcGeneratorParameters.Ptr, iGeneratorParameters)
    OpenGeneratorParameters(size, parametersBlob, iGeneratorParameters)
      => ComCall(5, this.p, UInt32, size, UInt8.Ptr, parametersBlob, IRdcGeneratorParameters.Ptr, iGeneratorParameters)
    CreateGenerator(iGeneratorParametersArray, iGenerator)
      => ComCall(6, this.p, UInt32, iGeneratorParametersArray.Length, IRdcGeneratorParameters.Ptr, iGeneratorParametersArray, IRdcGenerator.Ptr, iGenerator)
    CreateComparator(iSeedSignaturesFile, comparatorBufferSize, iComparator)
      => ComCall(7, this.p, IRdcFileReader, iSeedSignaturesFile, UInt32, comparatorBufferSize, IRdcComparator.Ptr, iComparator)
    CreateSignatureReader(iFileReader, iSignatureReader)
      => ComCall(8, this.p, IRdcFileReader, iFileReader, IRdcSignatureReader.Ptr, iSignatureReader)
    GetRDCVersion(currentVersion, minimumCompatibleAppVersion)
      => ComCall(9, this.p, UInt32.Ptr, currentVersion, UInt32.Ptr, minimumCompatibleAppVersion)
}
struct ISimilarityReportProgress extends IUnknown {
    static IID := "{96236A7A-9DBC-11DA-9E3F-0011114AE311}"
    ReportProgress(percentCompleted)
      => ComCall(3, this.p, UInt32, percentCompleted)
}
struct ISimilarityTableDumpState extends IUnknown {
    static IID := "{96236A7B-9DBC-11DA-9E3F-0011114AE311}"
    GetNextData(resultsSize, resultsUsed, eof, results)
      => ComCall(3, this.p, UInt32, resultsSize, UInt32.Ptr, resultsUsed, BOOL.Ptr, eof, SimilarityDumpData.Ptr, results)
}
struct ISimilarityTraitsMappedView extends IUnknown {
    static IID := "{96236A7C-9DBC-11DA-9E3F-0011114AE311}"
    Flush()
      => ComCall(3, this.p)
    Unmap()
      => ComCall(4, this.p)
    Get(index, dirty, numElements, viewInfo)
      => ComCall(5, this.p, Int64, index, BOOL, dirty, UInt32, numElements, SimilarityMappedViewInfo.Ptr, viewInfo)
    GetView(mappedPageBegin, mappedPageEnd)
      => ComCall(6, this.p, UInt8.Ptr.Ptr, mappedPageBegin, UInt8.Ptr.Ptr, mappedPageEnd, "void")
}
struct ISimilarityTraitsMapping extends IUnknown {
    static IID := "{96236A7D-9DBC-11DA-9E3F-0011114AE311}"
    CloseMapping()
      => ComCall(3, this.p, "void")
    SetFileSize(fileSize)
      => ComCall(4, this.p, Int64, fileSize)
    GetFileSize(fileSize)
      => ComCall(5, this.p, Int64.Ptr, fileSize)
    OpenMapping(accessMode, begin, end, actualEnd)
      => ComCall(6, this.p, RdcMappingAccessMode, accessMode, Int64, begin, Int64, end, Int64.Ptr, actualEnd)
    ResizeMapping(accessMode, begin, end, actualEnd)
      => ComCall(7, this.p, RdcMappingAccessMode, accessMode, Int64, begin, Int64, end, Int64.Ptr, actualEnd)
    GetPageSize(pageSize)
      => ComCall(8, this.p, UInt32.Ptr, pageSize, "void")
    CreateView(minimumMappedPages, accessMode, mappedView)
      => ComCall(9, this.p, UInt32, minimumMappedPages, RdcMappingAccessMode, accessMode, ISimilarityTraitsMappedView.Ptr, mappedView)
}
struct ISimilarityTraitsTable extends IUnknown {
    static IID := "{96236A7E-9DBC-11DA-9E3F-0011114AE311}"
    CreateTable(path, truncate, securityDescriptor, isNew)
      => ComCall(3, this.p, "Str", path, BOOL, truncate, UInt8.Ptr, securityDescriptor, RdcCreatedTables.Ptr, isNew)
    CreateTableIndirect(mapping, truncate, isNew)
      => ComCall(4, this.p, ISimilarityTraitsMapping, mapping, BOOL, truncate, RdcCreatedTables.Ptr, isNew)
    CloseTable(isValid)
      => ComCall(5, this.p, BOOL, isValid)
    Append(data, fileIndex)
      => ComCall(6, this.p, SimilarityData.Ptr, data, UInt32, fileIndex)
    FindSimilarFileIndex(similarityData, numberOfMatchesRequired, findSimilarFileIndexResults, resultsSize, resultsUsed)
      => ComCall(7, this.p, SimilarityData.Ptr, similarityData, UInt16, numberOfMatchesRequired, FindSimilarFileIndexResults.Ptr, findSimilarFileIndexResults, UInt32, resultsSize, UInt32.Ptr, resultsUsed)
    BeginDump(similarityTableDumpState)
      => ComCall(8, this.p, ISimilarityTableDumpState.Ptr, similarityTableDumpState)
    GetLastIndex(fileIndex)
      => ComCall(9, this.p, UInt32.Ptr, fileIndex)
}
struct ISimilarityFileIdTable extends IUnknown {
    static IID := "{96236A7F-9DBC-11DA-9E3F-0011114AE311}"
    CreateTable(path, truncate, securityDescriptor, recordSize, isNew)
      => ComCall(3, this.p, "Str", path, BOOL, truncate, UInt8.Ptr, securityDescriptor, UInt32, recordSize, RdcCreatedTables.Ptr, isNew)
    CreateTableIndirect(fileIdFile, truncate, recordSize, isNew)
      => ComCall(4, this.p, IRdcFileWriter, fileIdFile, BOOL, truncate, UInt32, recordSize, RdcCreatedTables.Ptr, isNew)
    CloseTable(isValid)
      => ComCall(5, this.p, BOOL, isValid)
    Append(similarityFileId, similarityFileIndex)
      => ComCall(6, this.p, SimilarityFileId.Ptr, similarityFileId, UInt32.Ptr, similarityFileIndex)
    Lookup(similarityFileIndex, similarityFileId)
      => ComCall(7, this.p, UInt32, similarityFileIndex, SimilarityFileId.Ptr, similarityFileId)
    Invalidate(similarityFileIndex)
      => ComCall(8, this.p, UInt32, similarityFileIndex)
    GetRecordCount(recordCount)
      => ComCall(9, this.p, UInt32.Ptr, recordCount)
}
struct IRdcSimilarityGenerator extends IUnknown {
    static IID := "{96236A80-9DBC-11DA-9E3F-0011114AE311}"
    EnableSimilarity()
      => ComCall(3, this.p)
    Results(similarityData)
      => ComCall(4, this.p, SimilarityData.Ptr, similarityData)
}
struct IFindSimilarResults extends IUnknown {
    static IID := "{96236A81-9DBC-11DA-9E3F-0011114AE311}"
    GetSize(size)
      => ComCall(3, this.p, UInt32.Ptr, size)
    GetNextFileId(numTraitsMatched, similarityFileId)
      => ComCall(4, this.p, UInt32.Ptr, numTraitsMatched, SimilarityFileId.Ptr, similarityFileId)
}
struct ISimilarity extends IUnknown {
    static IID := "{96236A83-9DBC-11DA-9E3F-0011114AE311}"
    CreateTable(path, truncate, securityDescriptor, recordSize, isNew)
      => ComCall(3, this.p, "Str", path, BOOL, truncate, UInt8.Ptr, securityDescriptor, UInt32, recordSize, RdcCreatedTables.Ptr, isNew)
    CreateTableIndirect(mapping, fileIdFile, truncate, recordSize, isNew)
      => ComCall(4, this.p, ISimilarityTraitsMapping, mapping, IRdcFileWriter, fileIdFile, BOOL, truncate, UInt32, recordSize, RdcCreatedTables.Ptr, isNew)
    CloseTable(isValid)
      => ComCall(5, this.p, BOOL, isValid)
    Append(similarityFileId, similarityData)
      => ComCall(6, this.p, SimilarityFileId.Ptr, similarityFileId, SimilarityData.Ptr, similarityData)
    FindSimilarFileId(similarityData, numberOfMatchesRequired, resultsSize, findSimilarResults)
      => ComCall(7, this.p, SimilarityData.Ptr, similarityData, UInt16, numberOfMatchesRequired, UInt32, resultsSize, IFindSimilarResults.Ptr, findSimilarResults)
    CopyAndSwap(newSimilarityTables, reportProgress)
      => ComCall(8, this.p, ISimilarity, newSimilarityTables, ISimilarityReportProgress, reportProgress)
    GetRecordCount(recordCount)
      => ComCall(9, this.p, UInt32.Ptr, recordCount)
}
