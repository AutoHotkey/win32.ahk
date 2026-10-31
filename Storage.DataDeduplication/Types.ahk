#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT}
#Import "..\System.Com\Types.ahk" {IStream, IUnknown}
#Import "..\System.Variant\Types.ahk" {VARIANT}

struct DEDUP_CONTAINER_EXTENT {
    ContainerIndex : UInt32
    StartOffset : Int64
    Length : Int64
}
struct DDP_FILE_EXTENT {
    Length : Int64
    Offset : Int64
}
struct DEDUP_BACKUP_SUPPORT_PARAM_TYPE extends Int32 {
    static DEDUP_RECONSTRUCT_UNOPTIMIZED := 1
    static DEDUP_RECONSTRUCT_OPTIMIZED := 2
}
struct IDedupReadFileCallback extends IUnknown {
    static IID := "{7BACC67A-2F1D-42D0-897E-6FF62DD533BB}"
    ReadBackupFile(FileFullPath, FileOffset, FileBuffer, ReturnedSize, Flags)
      => ComCall(3, this.p, BSTR, FileFullPath, Int64, FileOffset, UInt32, FileBuffer.Length, UInt8.Ptr, FileBuffer, UInt32.Ptr, ReturnedSize, UInt32, Flags)
    OrderContainersRestore(ContainerPaths, ReadPlan)
      => ComCall(4, this.p, UInt32, ContainerPaths.Length, BSTR.Ptr, ContainerPaths, UInt32.Ptr, ReadPlan.Length, DEDUP_CONTAINER_EXTENT.Ptr.Ptr, ReadPlan)
    PreviewContainerRead(FileFullPath, ReadOffsets)
      => ComCall(5, this.p, BSTR, FileFullPath, UInt32, ReadOffsets.Length, DDP_FILE_EXTENT.Ptr, ReadOffsets)
}
struct IDedupBackupSupport extends IUnknown {
    static IID := "{C719D963-2B2D-415E-ACF7-7EB7CA596FF4}"
    RestoreFiles(FileFullPaths, Store, Flags, FileResults)
      => ComCall(3, this.p, UInt32, FileResults.Length, BSTR.Ptr, FileFullPaths, IDedupReadFileCallback, Store, UInt32, Flags, HRESULT.Ptr, FileResults)
}
struct DEDUP_SET_PARAM_TYPE extends Int32 {
    static DEDUP_PT_MinChunkSizeBytes := 1
    static DEDUP_PT_MaxChunkSizeBytes := 2
    static DEDUP_PT_AvgChunkSizeBytes := 3
    static DEDUP_PT_InvariantChunking := 4
    static DEDUP_PT_DisableStrongHashComputation := 5
}
struct DEDUP_CHUNK_INFO_HASH32 {
    ChunkFlags : UInt32
    ChunkOffsetInStream : Int64
    ChunkSize : Int64
    HashVal : UInt8[32]
}
struct IDedupChunkLibrary extends IUnknown {
    static IID := "{BB5144D7-2720-4DCC-8777-78597416EC23}"
    InitializeForPushBuffers()
      => ComCall(3, this.p)
    Uninitialize()
      => ComCall(4, this.p)
    SetParameter(dwParamType, vParamValue)
      => ComCall(5, this.p, UInt32, dwParamType, VARIANT, vParamValue)
    StartChunking(iidIteratorInterfaceID, ppChunksEnum)
      => ComCall(6, this.p, GUID, iidIteratorInterfaceID, IUnknown.Ptr, ppChunksEnum)
}
struct IDedupIterateChunksHash32 extends IUnknown {
    static IID := "{90B584D3-72AA-400F-9767-CAD866A5A2D8}"
    PushBuffer(pBuffer)
      => ComCall(3, this.p, UInt8.Ptr, pBuffer, UInt32, pBuffer.Length)
    Next(pArrChunks, pulFetched)
      => ComCall(4, this.p, UInt32, pArrChunks.Length, DEDUP_CHUNK_INFO_HASH32.Ptr, pArrChunks, UInt32.Ptr, pulFetched)
    Drain()
      => ComCall(5, this.p)
    Reset()
      => ComCall(6, this.p)
}
struct DedupDataPortManagerOption extends Int32 {
    static DedupDataPortManagerOption_None := 0
    static DedupDataPortManagerOption_AutoStart := 1
    static DedupDataPortManagerOption_SkipReconciliation := 2
}
struct DedupDataPortVolumeStatus extends Int32 {
    static DedupDataPortVolumeStatus_Unknown := 0
    static DedupDataPortVolumeStatus_NotEnabled := 1
    static DedupDataPortVolumeStatus_NotAvailable := 2
    static DedupDataPortVolumeStatus_Initializing := 3
    static DedupDataPortVolumeStatus_Ready := 4
    static DedupDataPortVolumeStatus_Maintenance := 5
    static DedupDataPortVolumeStatus_Shutdown := 6
}
struct DedupDataPortRequestStatus extends Int32 {
    static DedupDataPortRequestStatus_Unknown := 0
    static DedupDataPortRequestStatus_Queued := 1
    static DedupDataPortRequestStatus_Processing := 2
    static DedupDataPortRequestStatus_Partial := 3
    static DedupDataPortRequestStatus_Complete := 4
    static DedupDataPortRequestStatus_Failed := 5
}
struct DedupChunkFlags extends Int32 {
    static DedupChunkFlags_None := 0
    static DedupChunkFlags_Compressed := 1
}
struct DedupHash {
    Hash : UInt8[32]
}
struct DedupChunk {
    Hash : DedupHash
    Flags : DedupChunkFlags
    LogicalSize : UInt32
    DataSize : UInt32
}
struct DedupStreamEntry {
    Hash : DedupHash
    LogicalSize : UInt32
    Offset : Int64
}
struct DedupStream {
    Path : BSTR
    Offset : Int64
    Length : Int64
    ChunkCount : UInt32
}
struct DedupChunkingAlgorithm extends Int32 {
    static DedupChunkingAlgorithm_Unknonwn := 0
    static DedupChunkingAlgorithm_V1 := 1
}
struct DedupHashingAlgorithm extends Int32 {
    static DedupHashingAlgorithm_Unknonwn := 0
    static DedupHashingAlgorithm_V1 := 1
}
struct DedupCompressionAlgorithm extends Int32 {
    static DedupCompressionAlgorithm_Unknonwn := 0
    static DedupCompressionAlgorithm_Xpress := 1
}
struct IDedupDataPort extends IUnknown {
    static IID := "{7963D734-40A9-4EA3-BBF6-5A89D26F7AE8}"
    GetStatus(pStatus, pDataHeadroomMb)
      => ComCall(3, this.p, DedupDataPortVolumeStatus.Ptr, pStatus, UInt32.Ptr, pDataHeadroomMb)
    LookupChunks(pHashes, pRequestId)
      => ComCall(4, this.p, UInt32, pHashes.Length, DedupHash.Ptr, pHashes, GUID.Ptr, pRequestId)
    InsertChunks(pChunkMetadata, pChunkData, pRequestId)
      => ComCall(5, this.p, UInt32, pChunkMetadata.Length, DedupChunk.Ptr, pChunkMetadata, UInt32, pChunkData.Length, UInt8.Ptr, pChunkData, GUID.Ptr, pRequestId)
    InsertChunksWithStream(pChunkMetadata, DataByteCount, pChunkDataStream, pRequestId)
      => ComCall(6, this.p, UInt32, pChunkMetadata.Length, DedupChunk.Ptr, pChunkMetadata, UInt32, DataByteCount, IStream, pChunkDataStream, GUID.Ptr, pRequestId)
    CommitStreams(pStreams, pEntries, pRequestId)
      => ComCall(7, this.p, UInt32, pStreams.Length, DedupStream.Ptr, pStreams, UInt32, pEntries.Length, DedupStreamEntry.Ptr, pEntries, GUID.Ptr, pRequestId)
    CommitStreamsWithStream(pStreams, EntryCount, pEntriesStream, pRequestId)
      => ComCall(8, this.p, UInt32, pStreams.Length, DedupStream.Ptr, pStreams, UInt32, EntryCount, IStream, pEntriesStream, GUID.Ptr, pRequestId)
    GetStreams(pStreamPaths, pRequestId)
      => ComCall(9, this.p, UInt32, pStreamPaths.Length, BSTR.Ptr, pStreamPaths, GUID.Ptr, pRequestId)
    GetStreamsResults(RequestId, MaxWaitMs, StreamEntryIndex, ppStreams, ppEntries, pStatus, ppItemResults)
      => ComCall(10, this.p, GUID, RequestId, UInt32, MaxWaitMs, UInt32, StreamEntryIndex, UInt32.Ptr, ppItemResults.Length, DedupStream.Ptr.Ptr, ppStreams, UInt32.Ptr, ppEntries.Length, DedupStreamEntry.Ptr.Ptr, ppEntries, DedupDataPortRequestStatus.Ptr, pStatus, HRESULT.Ptr.Ptr, ppItemResults)
    GetChunks(pHashes, pRequestId)
      => ComCall(11, this.p, UInt32, pHashes.Length, DedupHash.Ptr, pHashes, GUID.Ptr, pRequestId)
    GetChunksResults(RequestId, MaxWaitMs, ChunkIndex, ppChunkMetadata, ppChunkData, pStatus, ppItemResults)
      => ComCall(12, this.p, GUID, RequestId, UInt32, MaxWaitMs, UInt32, ChunkIndex, UInt32.Ptr, ppItemResults.Length, DedupChunk.Ptr.Ptr, ppChunkMetadata, UInt32.Ptr, ppChunkData.Length, UInt8.Ptr.Ptr, ppChunkData, DedupDataPortRequestStatus.Ptr, pStatus, HRESULT.Ptr.Ptr, ppItemResults)
    GetRequestStatus(RequestId, pStatus)
      => ComCall(13, this.p, GUID, RequestId, DedupDataPortRequestStatus.Ptr, pStatus)
    GetRequestResults(RequestId, MaxWaitMs, pBatchResult, pStatus, ppItemResults)
      => ComCall(14, this.p, GUID, RequestId, UInt32, MaxWaitMs, HRESULT.Ptr, pBatchResult, UInt32.Ptr, ppItemResults.Length, DedupDataPortRequestStatus.Ptr, pStatus, HRESULT.Ptr.Ptr, ppItemResults)
}
struct IDedupDataPortManager extends IUnknown {
    static IID := "{44677452-B90A-445E-8192-CDCFE81511FB}"
    GetConfiguration(pMinChunkSize, pMaxChunkSize, pChunkingAlgorithm, pHashingAlgorithm, pCompressionAlgorithm)
      => ComCall(3, this.p, UInt32.Ptr, pMinChunkSize, UInt32.Ptr, pMaxChunkSize, DedupChunkingAlgorithm.Ptr, pChunkingAlgorithm, DedupHashingAlgorithm.Ptr, pHashingAlgorithm, DedupCompressionAlgorithm.Ptr, pCompressionAlgorithm)
    GetVolumeStatus(Options, Path, pStatus)
      => ComCall(4, this.p, UInt32, Options, BSTR, Path, DedupDataPortVolumeStatus.Ptr, pStatus)
    GetVolumeDataPort(Options, Path, ppDataPort)
      => ComCall(5, this.p, UInt32, Options, BSTR, Path, IDedupDataPort.Ptr, ppDataPort)
}
