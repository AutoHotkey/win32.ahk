#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {RECT}

struct MF_TRANSFER_VIDEO_FRAME_FLAGS extends Int32 {
    static MF_TRANSFER_VIDEO_FRAME_DEFAULT := 0
    static MF_TRANSFER_VIDEO_FRAME_STRETCH := 1
    static MF_TRANSFER_VIDEO_FRAME_IGNORE_PAR := 2
}
struct MF_MEDIASOURCE_STATUS_INFO extends Int32 {
    static MF_MEDIASOURCE_STATUS_INFO_FULLYSUPPORTED := 0
    static MF_MEDIASOURCE_STATUS_INFO_UNKNOWN := 1
}
struct FaceRectInfoBlobHeader {
    Size : UInt32
    Count : UInt32
}
struct FaceRectInfo {
    Region : RECT
    confidenceLevel : Int32
}
struct FaceCharacterizationBlobHeader {
    Size : UInt32
    Count : UInt32
}
struct FaceCharacterization {
    BlinkScoreLeft : UInt32
    BlinkScoreRight : UInt32
    FacialExpression : UInt32
    FacialExpressionScore : UInt32
}
struct CapturedMetadataExposureCompensation {
    Flags : Int64
    Value : Int32
}
struct CapturedMetadataISOGains {
    AnalogGain : Float32
    DigitalGain : Float32
}
struct CapturedMetadataWhiteBalanceGains {
    R : Float32
    G : Float32
    B : Float32
}
struct MetadataTimeStamps {
    Flags : UInt32
    Device : Int64
    Presentation : Int64
}
struct HistogramGrid {
    Width : UInt32
    Height : UInt32
    Region : RECT
}
struct HistogramBlobHeader {
    Size : UInt32
    Histograms : UInt32
}
struct HistogramHeader {
    Size : UInt32
    Bins : UInt32
    FourCC : UInt32
    ChannelMasks : UInt32
    Grid : HistogramGrid
}
struct HistogramDataHeader {
    Size : UInt32
    ChannelMask : UInt32
    Linear : UInt32
}
