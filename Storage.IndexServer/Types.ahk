#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, PWSTR, RECT}
#Import "..\System.Com\Types.ahk" {IUnknown}
#Import "..\System.Com.StructuredStorage\Types.ahk" {PROPSPEC, PROPVARIANT}

struct CI_STATE {
    cbStruct : UInt32
    cWordList : UInt32
    cPersistentIndex : UInt32
    cQueries : UInt32
    cDocuments : UInt32
    cFreshTest : UInt32
    dwMergeProgress : UInt32
    eState : UInt32
    cFilteredDocuments : UInt32
    cTotalDocuments : UInt32
    cPendingScans : UInt32
    dwIndexSize : UInt32
    cUniqueKeys : UInt32
    cSecQDocuments : UInt32
    dwPropCacheSize : UInt32
}
struct FULLPROPSPEC {
    guidPropSet : GUID
    psProperty : PROPSPEC
}
struct IFILTER_INIT extends Int32 {
    static IFILTER_INIT_CANON_PARAGRAPHS := 1
    static IFILTER_INIT_HARD_LINE_BREAKS := 2
    static IFILTER_INIT_CANON_HYPHENS := 4
    static IFILTER_INIT_CANON_SPACES := 8
    static IFILTER_INIT_APPLY_INDEX_ATTRIBUTES := 16
    static IFILTER_INIT_APPLY_OTHER_ATTRIBUTES := 32
    static IFILTER_INIT_APPLY_CRAWL_ATTRIBUTES := 256
    static IFILTER_INIT_INDEXING_ONLY := 64
    static IFILTER_INIT_SEARCH_LINKS := 128
    static IFILTER_INIT_FILTER_OWNED_VALUE_OK := 512
    static IFILTER_INIT_FILTER_AGGRESSIVE_BREAK := 1024
    static IFILTER_INIT_DISABLE_EMBEDDED := 2048
    static IFILTER_INIT_EMIT_FORMATTING := 4096
}
struct IFILTER_FLAGS extends Int32 {
    static IFILTER_FLAGS_OLE_PROPERTIES := 1
}
struct CHUNKSTATE extends Int32 {
    static CHUNK_TEXT := 1
    static CHUNK_VALUE := 2
    static CHUNK_FILTER_OWNED_VALUE := 4
    static CHUNK_IMAGE := 8
}
struct CHUNK_BREAKTYPE extends Int32 {
    static CHUNK_NO_BREAK := 0
    static CHUNK_EOW := 1
    static CHUNK_EOS := 2
    static CHUNK_EOP := 3
    static CHUNK_EOC := 4
}
struct FILTERREGION {
    idChunk : UInt32
    cwcStart : UInt32
    cwcExtent : UInt32
}
struct STAT_CHUNK {
    idChunk : UInt32
    breakType : CHUNK_BREAKTYPE
    flags : CHUNKSTATE
    locale : UInt32
    attribute : FULLPROPSPEC
    idChunkSource : UInt32
    cwcStartSource : UInt32
    cwcLenSource : UInt32
}
struct IFilter extends IUnknown {
    static IID := "{89BCB740-6119-101A-BCB7-00DD010655AF}"
    Init(grfFlags, aAttributes, pFlags)
      => ComCall(3, this.p, UInt32, grfFlags, UInt32, aAttributes.Length, FULLPROPSPEC.Ptr, aAttributes, UInt32.Ptr, pFlags, Int32)
    GetChunk(pStat)
      => ComCall(4, this.p, STAT_CHUNK.Ptr, pStat, Int32)
    GetText(awcBuffer)
      => ComCall(5, this.p, UInt32.Ptr, awcBuffer.Length, PWSTR, awcBuffer, Int32)
    GetValue(ppPropValue)
      => ComCall(6, this.p, PROPVARIANT.Ptr.Ptr, ppPropValue, Int32)
    BindRegion(origPos, riid, ppunk)
      => ComCall(7, this.p, FILTERREGION, origPos, GUID.Ptr, riid, Struct.Ptr.Ptr, ppunk, Int32)
}
struct IMAGE_PIXELFORMAT extends Int32 {
    static FILTER_PIXELFORMAT_BGRA8 := 0
    static FILTER_PIXELFORMAT_PBGRA8 := 1
    static FILTER_PIXELFORMAT_BGR8 := 2
}
struct IMAGE_INFO {
    Width : UInt32
    Height : UInt32
    Format : IMAGE_PIXELFORMAT
}
struct IPixelFilter extends IFilter {
    static IID := "{3D7DF9A7-8DA6-4FBF-A45B-7592F06D93A9}"
    GetImageInfo(imageInfo)
      => ComCall(8, this.p, IMAGE_INFO.Ptr, imageInfo)
    GetPixelsForImage(scalingFactor, sourceRect, pixelBuffer)
      => ComCall(9, this.p, Float32, scalingFactor, RECT.Ptr, sourceRect, UInt32, pixelBuffer.Length, UInt8.Ptr, pixelBuffer)
}
struct DBID {
    uGuid : this._uGuid_e__Union
    eKind : UInt32
    uName : this._uName_e__Union
    struct _uGuid_e__Union {
        union {
            guid : GUID
            pguid : GUID.Ptr
        }
    }
    struct _uName_e__Union {
        union {
            pwszName : PWSTR
            ulPropid : UInt32
        }
    }
}
struct IPhraseSink extends IUnknown {
    static IID := "{CC906FF0-C058-101A-B554-08002B33B0E6}"
    PutSmallPhrase(pwcNoun, cwcNoun, pwcModifier, cwcModifier, ulAttachmentType)
      => ComCall(3, this.p, "Str", pwcNoun, UInt32, cwcNoun, "Str", pwcModifier, UInt32, cwcModifier, UInt32, ulAttachmentType)
    PutPhrase(pwcPhrase, cwcPhrase)
      => ComCall(4, this.p, "Str", pwcPhrase, UInt32, cwcPhrase)
}
struct WORDREP_BREAK_TYPE extends Int32 {
    static WORDREP_BREAK_EOW := 0
    static WORDREP_BREAK_EOS := 1
    static WORDREP_BREAK_EOP := 2
    static WORDREP_BREAK_EOC := 3
}
struct DBKINDENUM extends Int32 {
    static DBKIND_GUID_NAME := 0
    static DBKIND_GUID_PROPID := 1
    static DBKIND_NAME := 2
    static DBKIND_PGUID_NAME := 3
    static DBKIND_PGUID_PROPID := 4
    static DBKIND_PROPID := 5
    static DBKIND_GUID := 6
}
