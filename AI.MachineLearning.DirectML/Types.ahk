#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PSTR, PWSTR}
#Import "..\Graphics.Direct3D12\Types.ahk" {D3D12_CPU_DESCRIPTOR_HANDLE, D3D12_GPU_DESCRIPTOR_HANDLE, ID3D12CommandList, ID3D12Resource}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct DML_TENSOR_DATA_TYPE extends Int32 {
    static DML_TENSOR_DATA_TYPE_UNKNOWN := 0
    static DML_TENSOR_DATA_TYPE_FLOAT32 := 1
    static DML_TENSOR_DATA_TYPE_FLOAT16 := 2
    static DML_TENSOR_DATA_TYPE_UINT32 := 3
    static DML_TENSOR_DATA_TYPE_UINT16 := 4
    static DML_TENSOR_DATA_TYPE_UINT8 := 5
    static DML_TENSOR_DATA_TYPE_INT32 := 6
    static DML_TENSOR_DATA_TYPE_INT16 := 7
    static DML_TENSOR_DATA_TYPE_INT8 := 8
    static DML_TENSOR_DATA_TYPE_FLOAT64 := 9
    static DML_TENSOR_DATA_TYPE_UINT64 := 10
    static DML_TENSOR_DATA_TYPE_INT64 := 11
}
struct DML_TENSOR_TYPE extends Int32 {
    static DML_TENSOR_TYPE_INVALID := 0
    static DML_TENSOR_TYPE_BUFFER := 1
}
struct DML_TENSOR_FLAGS extends Int32 {
    static DML_TENSOR_FLAG_NONE := 0
    static DML_TENSOR_FLAG_OWNED_BY_DML := 1
}
struct DML_BUFFER_TENSOR_DESC {
    DataType : DML_TENSOR_DATA_TYPE
    Flags : DML_TENSOR_FLAGS
    DimensionCount : UInt32
    Sizes : UInt32.Ptr
    Strides : UInt32.Ptr
    TotalTensorSizeInBytes : Int64
    GuaranteedBaseOffsetAlignment : UInt32
}
struct DML_TENSOR_DESC {
    Type : DML_TENSOR_TYPE
    Desc : Struct.Ptr
}
struct DML_OPERATOR_TYPE extends Int32 {
    static DML_OPERATOR_INVALID := 0
    static DML_OPERATOR_ELEMENT_WISE_IDENTITY := 1
    static DML_OPERATOR_ELEMENT_WISE_ABS := 2
    static DML_OPERATOR_ELEMENT_WISE_ACOS := 3
    static DML_OPERATOR_ELEMENT_WISE_ADD := 4
    static DML_OPERATOR_ELEMENT_WISE_ASIN := 5
    static DML_OPERATOR_ELEMENT_WISE_ATAN := 6
    static DML_OPERATOR_ELEMENT_WISE_CEIL := 7
    static DML_OPERATOR_ELEMENT_WISE_CLIP := 8
    static DML_OPERATOR_ELEMENT_WISE_COS := 9
    static DML_OPERATOR_ELEMENT_WISE_DIVIDE := 10
    static DML_OPERATOR_ELEMENT_WISE_EXP := 11
    static DML_OPERATOR_ELEMENT_WISE_FLOOR := 12
    static DML_OPERATOR_ELEMENT_WISE_LOG := 13
    static DML_OPERATOR_ELEMENT_WISE_LOGICAL_AND := 14
    static DML_OPERATOR_ELEMENT_WISE_LOGICAL_EQUALS := 15
    static DML_OPERATOR_ELEMENT_WISE_LOGICAL_GREATER_THAN := 16
    static DML_OPERATOR_ELEMENT_WISE_LOGICAL_LESS_THAN := 17
    static DML_OPERATOR_ELEMENT_WISE_LOGICAL_NOT := 18
    static DML_OPERATOR_ELEMENT_WISE_LOGICAL_OR := 19
    static DML_OPERATOR_ELEMENT_WISE_LOGICAL_XOR := 20
    static DML_OPERATOR_ELEMENT_WISE_MAX := 21
    static DML_OPERATOR_ELEMENT_WISE_MEAN := 22
    static DML_OPERATOR_ELEMENT_WISE_MIN := 23
    static DML_OPERATOR_ELEMENT_WISE_MULTIPLY := 24
    static DML_OPERATOR_ELEMENT_WISE_POW := 25
    static DML_OPERATOR_ELEMENT_WISE_CONSTANT_POW := 26
    static DML_OPERATOR_ELEMENT_WISE_RECIP := 27
    static DML_OPERATOR_ELEMENT_WISE_SIN := 28
    static DML_OPERATOR_ELEMENT_WISE_SQRT := 29
    static DML_OPERATOR_ELEMENT_WISE_SUBTRACT := 30
    static DML_OPERATOR_ELEMENT_WISE_TAN := 31
    static DML_OPERATOR_ELEMENT_WISE_THRESHOLD := 32
    static DML_OPERATOR_ELEMENT_WISE_QUANTIZE_LINEAR := 33
    static DML_OPERATOR_ELEMENT_WISE_DEQUANTIZE_LINEAR := 34
    static DML_OPERATOR_ACTIVATION_ELU := 35
    static DML_OPERATOR_ACTIVATION_HARDMAX := 36
    static DML_OPERATOR_ACTIVATION_HARD_SIGMOID := 37
    static DML_OPERATOR_ACTIVATION_IDENTITY := 38
    static DML_OPERATOR_ACTIVATION_LEAKY_RELU := 39
    static DML_OPERATOR_ACTIVATION_LINEAR := 40
    static DML_OPERATOR_ACTIVATION_LOG_SOFTMAX := 41
    static DML_OPERATOR_ACTIVATION_PARAMETERIZED_RELU := 42
    static DML_OPERATOR_ACTIVATION_PARAMETRIC_SOFTPLUS := 43
    static DML_OPERATOR_ACTIVATION_RELU := 44
    static DML_OPERATOR_ACTIVATION_SCALED_ELU := 45
    static DML_OPERATOR_ACTIVATION_SCALED_TANH := 46
    static DML_OPERATOR_ACTIVATION_SIGMOID := 47
    static DML_OPERATOR_ACTIVATION_SOFTMAX := 48
    static DML_OPERATOR_ACTIVATION_SOFTPLUS := 49
    static DML_OPERATOR_ACTIVATION_SOFTSIGN := 50
    static DML_OPERATOR_ACTIVATION_TANH := 51
    static DML_OPERATOR_ACTIVATION_THRESHOLDED_RELU := 52
    static DML_OPERATOR_CONVOLUTION := 53
    static DML_OPERATOR_GEMM := 54
    static DML_OPERATOR_REDUCE := 55
    static DML_OPERATOR_AVERAGE_POOLING := 56
    static DML_OPERATOR_LP_POOLING := 57
    static DML_OPERATOR_MAX_POOLING := 58
    static DML_OPERATOR_ROI_POOLING := 59
    static DML_OPERATOR_SLICE := 60
    static DML_OPERATOR_CAST := 61
    static DML_OPERATOR_SPLIT := 62
    static DML_OPERATOR_JOIN := 63
    static DML_OPERATOR_PADDING := 64
    static DML_OPERATOR_VALUE_SCALE_2D := 65
    static DML_OPERATOR_UPSAMPLE_2D := 66
    static DML_OPERATOR_GATHER := 67
    static DML_OPERATOR_SPACE_TO_DEPTH := 68
    static DML_OPERATOR_DEPTH_TO_SPACE := 69
    static DML_OPERATOR_TILE := 70
    static DML_OPERATOR_TOP_K := 71
    static DML_OPERATOR_BATCH_NORMALIZATION := 72
    static DML_OPERATOR_MEAN_VARIANCE_NORMALIZATION := 73
    static DML_OPERATOR_LOCAL_RESPONSE_NORMALIZATION := 74
    static DML_OPERATOR_LP_NORMALIZATION := 75
    static DML_OPERATOR_RNN := 76
    static DML_OPERATOR_LSTM := 77
    static DML_OPERATOR_GRU := 78
    static DML_OPERATOR_ELEMENT_WISE_SIGN := 79
    static DML_OPERATOR_ELEMENT_WISE_IS_NAN := 80
    static DML_OPERATOR_ELEMENT_WISE_ERF := 81
    static DML_OPERATOR_ELEMENT_WISE_SINH := 82
    static DML_OPERATOR_ELEMENT_WISE_COSH := 83
    static DML_OPERATOR_ELEMENT_WISE_TANH := 84
    static DML_OPERATOR_ELEMENT_WISE_ASINH := 85
    static DML_OPERATOR_ELEMENT_WISE_ACOSH := 86
    static DML_OPERATOR_ELEMENT_WISE_ATANH := 87
    static DML_OPERATOR_ELEMENT_WISE_IF := 88
    static DML_OPERATOR_ELEMENT_WISE_ADD1 := 89
    static DML_OPERATOR_ACTIVATION_SHRINK := 90
    static DML_OPERATOR_MAX_POOLING1 := 91
    static DML_OPERATOR_MAX_UNPOOLING := 92
    static DML_OPERATOR_DIAGONAL_MATRIX := 93
    static DML_OPERATOR_SCATTER_ELEMENTS := 94
    static DML_OPERATOR_SCATTER := 94
    static DML_OPERATOR_ONE_HOT := 95
    static DML_OPERATOR_RESAMPLE := 96
    static DML_OPERATOR_ELEMENT_WISE_BIT_SHIFT_LEFT := 97
    static DML_OPERATOR_ELEMENT_WISE_BIT_SHIFT_RIGHT := 98
    static DML_OPERATOR_ELEMENT_WISE_ROUND := 99
    static DML_OPERATOR_ELEMENT_WISE_IS_INFINITY := 100
    static DML_OPERATOR_ELEMENT_WISE_MODULUS_TRUNCATE := 101
    static DML_OPERATOR_ELEMENT_WISE_MODULUS_FLOOR := 102
    static DML_OPERATOR_FILL_VALUE_CONSTANT := 103
    static DML_OPERATOR_FILL_VALUE_SEQUENCE := 104
    static DML_OPERATOR_CUMULATIVE_SUMMATION := 105
    static DML_OPERATOR_REVERSE_SUBSEQUENCES := 106
    static DML_OPERATOR_GATHER_ELEMENTS := 107
    static DML_OPERATOR_GATHER_ND := 108
    static DML_OPERATOR_SCATTER_ND := 109
    static DML_OPERATOR_MAX_POOLING2 := 110
    static DML_OPERATOR_SLICE1 := 111
    static DML_OPERATOR_TOP_K1 := 112
    static DML_OPERATOR_DEPTH_TO_SPACE1 := 113
    static DML_OPERATOR_SPACE_TO_DEPTH1 := 114
    static DML_OPERATOR_MEAN_VARIANCE_NORMALIZATION1 := 115
    static DML_OPERATOR_RESAMPLE1 := 116
    static DML_OPERATOR_MATRIX_MULTIPLY_INTEGER := 117
    static DML_OPERATOR_QUANTIZED_LINEAR_MATRIX_MULTIPLY := 118
    static DML_OPERATOR_CONVOLUTION_INTEGER := 119
    static DML_OPERATOR_QUANTIZED_LINEAR_CONVOLUTION := 120
    static DML_OPERATOR_ELEMENT_WISE_BIT_AND := 121
    static DML_OPERATOR_ELEMENT_WISE_BIT_OR := 122
    static DML_OPERATOR_ELEMENT_WISE_BIT_XOR := 123
    static DML_OPERATOR_ELEMENT_WISE_BIT_NOT := 124
    static DML_OPERATOR_ELEMENT_WISE_BIT_COUNT := 125
    static DML_OPERATOR_ELEMENT_WISE_LOGICAL_GREATER_THAN_OR_EQUAL := 126
    static DML_OPERATOR_ELEMENT_WISE_LOGICAL_LESS_THAN_OR_EQUAL := 127
    static DML_OPERATOR_ACTIVATION_CELU := 128
    static DML_OPERATOR_ACTIVATION_RELU_GRAD := 129
    static DML_OPERATOR_AVERAGE_POOLING_GRAD := 130
    static DML_OPERATOR_MAX_POOLING_GRAD := 131
    static DML_OPERATOR_RANDOM_GENERATOR := 132
    static DML_OPERATOR_NONZERO_COORDINATES := 133
    static DML_OPERATOR_RESAMPLE_GRAD := 134
    static DML_OPERATOR_SLICE_GRAD := 135
    static DML_OPERATOR_ADAM_OPTIMIZER := 136
    static DML_OPERATOR_ARGMIN := 137
    static DML_OPERATOR_ARGMAX := 138
    static DML_OPERATOR_ROI_ALIGN := 139
    static DML_OPERATOR_GATHER_ND1 := 140
    static DML_OPERATOR_ELEMENT_WISE_ATAN_YX := 141
    static DML_OPERATOR_ELEMENT_WISE_CLIP_GRAD := 142
    static DML_OPERATOR_ELEMENT_WISE_DIFFERENCE_SQUARE := 143
    static DML_OPERATOR_LOCAL_RESPONSE_NORMALIZATION_GRAD := 144
    static DML_OPERATOR_CUMULATIVE_PRODUCT := 145
    static DML_OPERATOR_BATCH_NORMALIZATION_GRAD := 146
    static DML_OPERATOR_ELEMENT_WISE_QUANTIZED_LINEAR_ADD := 147
    static DML_OPERATOR_DYNAMIC_QUANTIZE_LINEAR := 148
    static DML_OPERATOR_ROI_ALIGN1 := 149
    static DML_OPERATOR_ROI_ALIGN_GRAD := 150
    static DML_OPERATOR_BATCH_NORMALIZATION_TRAINING := 151
    static DML_OPERATOR_BATCH_NORMALIZATION_TRAINING_GRAD := 152
    static DML_OPERATOR_ELEMENT_WISE_CLIP1 := 153
    static DML_OPERATOR_ELEMENT_WISE_CLIP_GRAD1 := 154
    static DML_OPERATOR_PADDING1 := 155
    static DML_OPERATOR_ELEMENT_WISE_NEGATE := 156
}
struct DML_REDUCE_FUNCTION extends Int32 {
    static DML_REDUCE_FUNCTION_ARGMAX := 0
    static DML_REDUCE_FUNCTION_ARGMIN := 1
    static DML_REDUCE_FUNCTION_AVERAGE := 2
    static DML_REDUCE_FUNCTION_L1 := 3
    static DML_REDUCE_FUNCTION_L2 := 4
    static DML_REDUCE_FUNCTION_LOG_SUM := 5
    static DML_REDUCE_FUNCTION_LOG_SUM_EXP := 6
    static DML_REDUCE_FUNCTION_MAX := 7
    static DML_REDUCE_FUNCTION_MIN := 8
    static DML_REDUCE_FUNCTION_MULTIPLY := 9
    static DML_REDUCE_FUNCTION_SUM := 10
    static DML_REDUCE_FUNCTION_SUM_SQUARE := 11
}
struct DML_MATRIX_TRANSFORM extends Int32 {
    static DML_MATRIX_TRANSFORM_NONE := 0
    static DML_MATRIX_TRANSFORM_TRANSPOSE := 1
}
struct DML_CONVOLUTION_MODE extends Int32 {
    static DML_CONVOLUTION_MODE_CONVOLUTION := 0
    static DML_CONVOLUTION_MODE_CROSS_CORRELATION := 1
}
struct DML_CONVOLUTION_DIRECTION extends Int32 {
    static DML_CONVOLUTION_DIRECTION_FORWARD := 0
    static DML_CONVOLUTION_DIRECTION_BACKWARD := 1
}
struct DML_PADDING_MODE extends Int32 {
    static DML_PADDING_MODE_CONSTANT := 0
    static DML_PADDING_MODE_EDGE := 1
    static DML_PADDING_MODE_REFLECTION := 2
    static DML_PADDING_MODE_SYMMETRIC := 3
}
struct DML_INTERPOLATION_MODE extends Int32 {
    static DML_INTERPOLATION_MODE_NEAREST_NEIGHBOR := 0
    static DML_INTERPOLATION_MODE_LINEAR := 1
}
struct DML_SCALE_BIAS {
    Scale : Float32
    Bias : Float32
}
struct DML_SIZE_2D {
    Width : UInt32
    Height : UInt32
}
struct DML_RECURRENT_NETWORK_DIRECTION extends Int32 {
    static DML_RECURRENT_NETWORK_DIRECTION_FORWARD := 0
    static DML_RECURRENT_NETWORK_DIRECTION_BACKWARD := 1
    static DML_RECURRENT_NETWORK_DIRECTION_BIDIRECTIONAL := 2
}
struct DML_ROUNDING_MODE extends Int32 {
    static DML_ROUNDING_MODE_HALVES_TO_NEAREST_EVEN := 0
    static DML_ROUNDING_MODE_TOWARD_ZERO := 1
    static DML_ROUNDING_MODE_TOWARD_INFINITY := 2
}
struct DML_IS_INFINITY_MODE extends Int32 {
    static DML_IS_INFINITY_MODE_EITHER := 0
    static DML_IS_INFINITY_MODE_POSITIVE := 1
    static DML_IS_INFINITY_MODE_NEGATIVE := 2
}
struct DML_AXIS_DIRECTION extends Int32 {
    static DML_AXIS_DIRECTION_INCREASING := 0
    static DML_AXIS_DIRECTION_DECREASING := 1
}
struct DML_DEPTH_SPACE_ORDER extends Int32 {
    static DML_DEPTH_SPACE_ORDER_DEPTH_COLUMN_ROW := 0
    static DML_DEPTH_SPACE_ORDER_COLUMN_ROW_DEPTH := 1
}
struct DML_SCALAR_UNION {
    union {
        Bytes : UInt8[8]
        Int8 : Int8
        UInt8 : UInt8
        Int16 : Int16
        UInt16 : UInt16
        Int32 : Int32
        UInt32 : UInt32
        Int64 : Int64
        UInt64 : Int64
        Float32 : Float32
        Float64 : Float64
    }
}
struct DML_RANDOM_GENERATOR_TYPE extends Int32 {
    static DML_RANDOM_GENERATOR_TYPE_PHILOX_4X32_10 := 0
}
struct DML_OPERATOR_DESC {
    Type : DML_OPERATOR_TYPE
    Desc : Struct.Ptr
}
struct DML_ELEMENT_WISE_IDENTITY_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_ABS_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_ACOS_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_ADD_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_ADD1_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    FusedActivation : DML_OPERATOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_ASIN_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_ATAN_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_CEIL_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_CLIP_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
    Min : Float32
    Max : Float32
}
struct DML_ELEMENT_WISE_COS_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_DIVIDE_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_EXP_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_FLOOR_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_LOG_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_LOGICAL_AND_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_LOGICAL_EQUALS_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_LOGICAL_GREATER_THAN_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_LOGICAL_LESS_THAN_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_LOGICAL_NOT_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_LOGICAL_OR_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_LOGICAL_XOR_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_MAX_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_MEAN_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_MIN_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_MULTIPLY_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_POW_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    ExponentTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_CONSTANT_POW_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
    Exponent : Float32
}
struct DML_ELEMENT_WISE_RECIP_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_SIN_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_SQRT_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_SUBTRACT_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_TAN_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_THRESHOLD_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
    Min : Float32
}
struct DML_ELEMENT_WISE_QUANTIZE_LINEAR_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    ScaleTensor : DML_TENSOR_DESC.Ptr
    ZeroPointTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_DEQUANTIZE_LINEAR_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    ScaleTensor : DML_TENSOR_DESC.Ptr
    ZeroPointTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ACTIVATION_ELU_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Alpha : Float32
}
struct DML_ACTIVATION_HARDMAX_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ACTIVATION_HARD_SIGMOID_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Alpha : Float32
    Beta : Float32
}
struct DML_ACTIVATION_IDENTITY_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ACTIVATION_LEAKY_RELU_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Alpha : Float32
}
struct DML_ACTIVATION_LINEAR_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Alpha : Float32
    Beta : Float32
}
struct DML_ACTIVATION_LOG_SOFTMAX_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ACTIVATION_PARAMETERIZED_RELU_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    SlopeTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ACTIVATION_PARAMETRIC_SOFTPLUS_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Alpha : Float32
    Beta : Float32
}
struct DML_ACTIVATION_RELU_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ACTIVATION_SCALED_ELU_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Alpha : Float32
    Gamma : Float32
}
struct DML_ACTIVATION_SCALED_TANH_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Alpha : Float32
    Beta : Float32
}
struct DML_ACTIVATION_SIGMOID_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ACTIVATION_SOFTMAX_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ACTIVATION_SOFTPLUS_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Steepness : Float32
}
struct DML_ACTIVATION_SOFTSIGN_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ACTIVATION_TANH_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ACTIVATION_THRESHOLDED_RELU_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Alpha : Float32
}
struct DML_CONVOLUTION_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    FilterTensor : DML_TENSOR_DESC.Ptr
    BiasTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Mode : DML_CONVOLUTION_MODE
    Direction : DML_CONVOLUTION_DIRECTION
    DimensionCount : UInt32
    Strides : UInt32.Ptr
    Dilations : UInt32.Ptr
    StartPadding : UInt32.Ptr
    EndPadding : UInt32.Ptr
    OutputPadding : UInt32.Ptr
    GroupCount : UInt32
    FusedActivation : DML_OPERATOR_DESC.Ptr
}
struct DML_GEMM_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    CTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    TransA : DML_MATRIX_TRANSFORM
    TransB : DML_MATRIX_TRANSFORM
    Alpha : Float32
    Beta : Float32
    FusedActivation : DML_OPERATOR_DESC.Ptr
}
struct DML_REDUCE_OPERATOR_DESC {
    Function : DML_REDUCE_FUNCTION
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    AxisCount : UInt32
    Axes : UInt32.Ptr
}
struct DML_AVERAGE_POOLING_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    DimensionCount : UInt32
    Strides : UInt32.Ptr
    WindowSize : UInt32.Ptr
    StartPadding : UInt32.Ptr
    EndPadding : UInt32.Ptr
    IncludePadding : BOOL
}
struct DML_LP_POOLING_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    DimensionCount : UInt32
    Strides : UInt32.Ptr
    WindowSize : UInt32.Ptr
    StartPadding : UInt32.Ptr
    EndPadding : UInt32.Ptr
    P : UInt32
}
struct DML_MAX_POOLING_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    DimensionCount : UInt32
    Strides : UInt32.Ptr
    WindowSize : UInt32.Ptr
    StartPadding : UInt32.Ptr
    EndPadding : UInt32.Ptr
}
struct DML_ROI_POOLING_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    ROITensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    SpatialScale : Float32
    PooledSize : DML_SIZE_2D
}
struct DML_SLICE_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    DimensionCount : UInt32
    Offsets : UInt32.Ptr
    Sizes : UInt32.Ptr
    Strides : UInt32.Ptr
}
struct DML_CAST_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_SPLIT_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputCount : UInt32
    OutputTensors : DML_TENSOR_DESC.Ptr
    Axis : UInt32
}
struct DML_JOIN_OPERATOR_DESC {
    InputCount : UInt32
    InputTensors : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Axis : UInt32
}
struct DML_PADDING_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    PaddingMode : DML_PADDING_MODE
    PaddingValue : Float32
    DimensionCount : UInt32
    StartPadding : UInt32.Ptr
    EndPadding : UInt32.Ptr
}
struct DML_VALUE_SCALE_2D_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Scale : Float32
    ChannelCount : UInt32
    Bias : Float32.Ptr
}
struct DML_UPSAMPLE_2D_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleSize : DML_SIZE_2D
    InterpolationMode : DML_INTERPOLATION_MODE
}
struct DML_GATHER_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    IndicesTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Axis : UInt32
    IndexDimensions : UInt32
}
struct DML_SPACE_TO_DEPTH_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    BlockSize : UInt32
}
struct DML_DEPTH_TO_SPACE_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    BlockSize : UInt32
}
struct DML_TILE_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    RepeatsCount : UInt32
    Repeats : UInt32.Ptr
}
struct DML_TOP_K_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputValueTensor : DML_TENSOR_DESC.Ptr
    OutputIndexTensor : DML_TENSOR_DESC.Ptr
    Axis : UInt32
    K : UInt32
}
struct DML_BATCH_NORMALIZATION_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    MeanTensor : DML_TENSOR_DESC.Ptr
    VarianceTensor : DML_TENSOR_DESC.Ptr
    ScaleTensor : DML_TENSOR_DESC.Ptr
    BiasTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Spatial : BOOL
    Epsilon : Float32
    FusedActivation : DML_OPERATOR_DESC.Ptr
}
struct DML_MEAN_VARIANCE_NORMALIZATION_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    ScaleTensor : DML_TENSOR_DESC.Ptr
    BiasTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    CrossChannel : BOOL
    NormalizeVariance : BOOL
    Epsilon : Float32
    FusedActivation : DML_OPERATOR_DESC.Ptr
}
struct DML_LOCAL_RESPONSE_NORMALIZATION_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    CrossChannel : BOOL
    LocalSize : UInt32
    Alpha : Float32
    Beta : Float32
    Bias : Float32
}
struct DML_LP_NORMALIZATION_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Axis : UInt32
    Epsilon : Float32
    P : UInt32
}
struct DML_RNN_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    WeightTensor : DML_TENSOR_DESC.Ptr
    RecurrenceTensor : DML_TENSOR_DESC.Ptr
    BiasTensor : DML_TENSOR_DESC.Ptr
    HiddenInitTensor : DML_TENSOR_DESC.Ptr
    SequenceLengthsTensor : DML_TENSOR_DESC.Ptr
    OutputSequenceTensor : DML_TENSOR_DESC.Ptr
    OutputSingleTensor : DML_TENSOR_DESC.Ptr
    ActivationDescCount : UInt32
    ActivationDescs : DML_OPERATOR_DESC.Ptr
    Direction : DML_RECURRENT_NETWORK_DIRECTION
}
struct DML_LSTM_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    WeightTensor : DML_TENSOR_DESC.Ptr
    RecurrenceTensor : DML_TENSOR_DESC.Ptr
    BiasTensor : DML_TENSOR_DESC.Ptr
    HiddenInitTensor : DML_TENSOR_DESC.Ptr
    CellMemInitTensor : DML_TENSOR_DESC.Ptr
    SequenceLengthsTensor : DML_TENSOR_DESC.Ptr
    PeepholeTensor : DML_TENSOR_DESC.Ptr
    OutputSequenceTensor : DML_TENSOR_DESC.Ptr
    OutputSingleTensor : DML_TENSOR_DESC.Ptr
    OutputCellSingleTensor : DML_TENSOR_DESC.Ptr
    ActivationDescCount : UInt32
    ActivationDescs : DML_OPERATOR_DESC.Ptr
    Direction : DML_RECURRENT_NETWORK_DIRECTION
    ClipThreshold : Float32
    UseClipThreshold : BOOL
    CoupleInputForget : BOOL
}
struct DML_GRU_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    WeightTensor : DML_TENSOR_DESC.Ptr
    RecurrenceTensor : DML_TENSOR_DESC.Ptr
    BiasTensor : DML_TENSOR_DESC.Ptr
    HiddenInitTensor : DML_TENSOR_DESC.Ptr
    SequenceLengthsTensor : DML_TENSOR_DESC.Ptr
    OutputSequenceTensor : DML_TENSOR_DESC.Ptr
    OutputSingleTensor : DML_TENSOR_DESC.Ptr
    ActivationDescCount : UInt32
    ActivationDescs : DML_OPERATOR_DESC.Ptr
    Direction : DML_RECURRENT_NETWORK_DIRECTION
    LinearBeforeReset : BOOL
}
struct DML_ELEMENT_WISE_SIGN_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_IS_NAN_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_ERF_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_SINH_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_COSH_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_TANH_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_ASINH_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_ACOSH_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_ATANH_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
}
struct DML_ELEMENT_WISE_IF_OPERATOR_DESC {
    ConditionTensor : DML_TENSOR_DESC.Ptr
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ACTIVATION_SHRINK_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Bias : Float32
    Threshold : Float32
}
struct DML_MAX_POOLING1_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    OutputIndicesTensor : DML_TENSOR_DESC.Ptr
    DimensionCount : UInt32
    Strides : UInt32.Ptr
    WindowSize : UInt32.Ptr
    StartPadding : UInt32.Ptr
    EndPadding : UInt32.Ptr
}
struct DML_MAX_UNPOOLING_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    IndicesTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_DIAGONAL_MATRIX_OPERATOR_DESC {
    OutputTensor : DML_TENSOR_DESC.Ptr
    Offset : Int32
    Value : Float32
}
struct DML_SCATTER_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    IndicesTensor : DML_TENSOR_DESC.Ptr
    UpdatesTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Axis : UInt32
}
struct DML_ONE_HOT_OPERATOR_DESC {
    IndicesTensor : DML_TENSOR_DESC.Ptr
    ValuesTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Axis : UInt32
}
struct DML_RESAMPLE_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    InterpolationMode : DML_INTERPOLATION_MODE
    ScaleCount : UInt32
    Scales : Float32.Ptr
}
struct DML_ELEMENT_WISE_BIT_SHIFT_LEFT_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_BIT_SHIFT_RIGHT_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_ROUND_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    RoundingMode : DML_ROUNDING_MODE
}
struct DML_ELEMENT_WISE_IS_INFINITY_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    InfinityMode : DML_IS_INFINITY_MODE
}
struct DML_ELEMENT_WISE_MODULUS_TRUNCATE_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_MODULUS_FLOOR_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_FILL_VALUE_CONSTANT_OPERATOR_DESC {
    OutputTensor : DML_TENSOR_DESC.Ptr
    ValueDataType : DML_TENSOR_DATA_TYPE
    Value : DML_SCALAR_UNION
}
struct DML_FILL_VALUE_SEQUENCE_OPERATOR_DESC {
    OutputTensor : DML_TENSOR_DESC.Ptr
    ValueDataType : DML_TENSOR_DATA_TYPE
    ValueStart : DML_SCALAR_UNION
    ValueDelta : DML_SCALAR_UNION
}
struct DML_CUMULATIVE_SUMMATION_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Axis : UInt32
    AxisDirection : DML_AXIS_DIRECTION
    HasExclusiveSum : BOOL
}
struct DML_REVERSE_SUBSEQUENCES_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    SequenceLengthsTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Axis : UInt32
}
struct DML_GATHER_ELEMENTS_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    IndicesTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Axis : UInt32
}
struct DML_GATHER_ND_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    IndicesTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    InputDimensionCount : UInt32
    IndicesDimensionCount : UInt32
}
struct DML_SCATTER_ND_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    IndicesTensor : DML_TENSOR_DESC.Ptr
    UpdatesTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    InputDimensionCount : UInt32
    IndicesDimensionCount : UInt32
}
struct DML_MAX_POOLING2_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    OutputIndicesTensor : DML_TENSOR_DESC.Ptr
    DimensionCount : UInt32
    Strides : UInt32.Ptr
    WindowSize : UInt32.Ptr
    StartPadding : UInt32.Ptr
    EndPadding : UInt32.Ptr
    Dilations : UInt32.Ptr
}
struct DML_SLICE1_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    DimensionCount : UInt32
    InputWindowOffsets : UInt32.Ptr
    InputWindowSizes : UInt32.Ptr
    InputWindowStrides : Int32.Ptr
}
struct DML_TOP_K1_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputValueTensor : DML_TENSOR_DESC.Ptr
    OutputIndexTensor : DML_TENSOR_DESC.Ptr
    Axis : UInt32
    K : UInt32
    AxisDirection : DML_AXIS_DIRECTION
}
struct DML_DEPTH_TO_SPACE1_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    BlockSize : UInt32
    Order : DML_DEPTH_SPACE_ORDER
}
struct DML_SPACE_TO_DEPTH1_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    BlockSize : UInt32
    Order : DML_DEPTH_SPACE_ORDER
}
struct DML_MEAN_VARIANCE_NORMALIZATION1_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    ScaleTensor : DML_TENSOR_DESC.Ptr
    BiasTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    AxisCount : UInt32
    Axes : UInt32.Ptr
    NormalizeVariance : BOOL
    Epsilon : Float32
    FusedActivation : DML_OPERATOR_DESC.Ptr
}
struct DML_RESAMPLE1_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    InterpolationMode : DML_INTERPOLATION_MODE
    DimensionCount : UInt32
    Scales : Float32.Ptr
    InputPixelOffsets : Float32.Ptr
    OutputPixelOffsets : Float32.Ptr
}
struct DML_MATRIX_MULTIPLY_INTEGER_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    AZeroPointTensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    BZeroPointTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_QUANTIZED_LINEAR_MATRIX_MULTIPLY_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    AScaleTensor : DML_TENSOR_DESC.Ptr
    AZeroPointTensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    BScaleTensor : DML_TENSOR_DESC.Ptr
    BZeroPointTensor : DML_TENSOR_DESC.Ptr
    OutputScaleTensor : DML_TENSOR_DESC.Ptr
    OutputZeroPointTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_CONVOLUTION_INTEGER_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    InputZeroPointTensor : DML_TENSOR_DESC.Ptr
    FilterTensor : DML_TENSOR_DESC.Ptr
    FilterZeroPointTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    DimensionCount : UInt32
    Strides : UInt32.Ptr
    Dilations : UInt32.Ptr
    StartPadding : UInt32.Ptr
    EndPadding : UInt32.Ptr
    GroupCount : UInt32
}
struct DML_QUANTIZED_LINEAR_CONVOLUTION_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    InputScaleTensor : DML_TENSOR_DESC.Ptr
    InputZeroPointTensor : DML_TENSOR_DESC.Ptr
    FilterTensor : DML_TENSOR_DESC.Ptr
    FilterScaleTensor : DML_TENSOR_DESC.Ptr
    FilterZeroPointTensor : DML_TENSOR_DESC.Ptr
    BiasTensor : DML_TENSOR_DESC.Ptr
    OutputScaleTensor : DML_TENSOR_DESC.Ptr
    OutputZeroPointTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    DimensionCount : UInt32
    Strides : UInt32.Ptr
    Dilations : UInt32.Ptr
    StartPadding : UInt32.Ptr
    EndPadding : UInt32.Ptr
    GroupCount : UInt32
}
struct DML_ELEMENT_WISE_BIT_AND_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_BIT_OR_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_BIT_XOR_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_BIT_NOT_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_BIT_COUNT_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_LOGICAL_GREATER_THAN_OR_EQUAL_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_LOGICAL_LESS_THAN_OR_EQUAL_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ACTIVATION_CELU_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Alpha : Float32
}
struct DML_ACTIVATION_RELU_GRAD_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    InputGradientTensor : DML_TENSOR_DESC.Ptr
    OutputGradientTensor : DML_TENSOR_DESC.Ptr
}
struct DML_AVERAGE_POOLING_GRAD_OPERATOR_DESC {
    InputGradientTensor : DML_TENSOR_DESC.Ptr
    OutputGradientTensor : DML_TENSOR_DESC.Ptr
    DimensionCount : UInt32
    Strides : UInt32.Ptr
    WindowSize : UInt32.Ptr
    StartPadding : UInt32.Ptr
    EndPadding : UInt32.Ptr
    IncludePadding : BOOL
}
struct DML_MAX_POOLING_GRAD_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    InputGradientTensor : DML_TENSOR_DESC.Ptr
    OutputGradientTensor : DML_TENSOR_DESC.Ptr
    DimensionCount : UInt32
    Strides : UInt32.Ptr
    WindowSize : UInt32.Ptr
    StartPadding : UInt32.Ptr
    EndPadding : UInt32.Ptr
    Dilations : UInt32.Ptr
}
struct DML_RANDOM_GENERATOR_OPERATOR_DESC {
    InputStateTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    OutputStateTensor : DML_TENSOR_DESC.Ptr
    Type : DML_RANDOM_GENERATOR_TYPE
}
struct DML_NONZERO_COORDINATES_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputCountTensor : DML_TENSOR_DESC.Ptr
    OutputCoordinatesTensor : DML_TENSOR_DESC.Ptr
}
struct DML_RESAMPLE_GRAD_OPERATOR_DESC {
    InputGradientTensor : DML_TENSOR_DESC.Ptr
    OutputGradientTensor : DML_TENSOR_DESC.Ptr
    InterpolationMode : DML_INTERPOLATION_MODE
    DimensionCount : UInt32
    Scales : Float32.Ptr
    InputPixelOffsets : Float32.Ptr
    OutputPixelOffsets : Float32.Ptr
}
struct DML_SLICE_GRAD_OPERATOR_DESC {
    InputGradientTensor : DML_TENSOR_DESC.Ptr
    OutputGradientTensor : DML_TENSOR_DESC.Ptr
    DimensionCount : UInt32
    InputWindowOffsets : UInt32.Ptr
    InputWindowSizes : UInt32.Ptr
    InputWindowStrides : Int32.Ptr
}
struct DML_ADAM_OPTIMIZER_OPERATOR_DESC {
    InputParametersTensor : DML_TENSOR_DESC.Ptr
    InputFirstMomentTensor : DML_TENSOR_DESC.Ptr
    InputSecondMomentTensor : DML_TENSOR_DESC.Ptr
    GradientTensor : DML_TENSOR_DESC.Ptr
    TrainingStepTensor : DML_TENSOR_DESC.Ptr
    OutputParametersTensor : DML_TENSOR_DESC.Ptr
    OutputFirstMomentTensor : DML_TENSOR_DESC.Ptr
    OutputSecondMomentTensor : DML_TENSOR_DESC.Ptr
    LearningRate : Float32
    Beta1 : Float32
    Beta2 : Float32
    Epsilon : Float32
}
struct DML_ARGMIN_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    AxisCount : UInt32
    Axes : UInt32.Ptr
    AxisDirection : DML_AXIS_DIRECTION
}
struct DML_ARGMAX_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    AxisCount : UInt32
    Axes : UInt32.Ptr
    AxisDirection : DML_AXIS_DIRECTION
}
struct DML_ROI_ALIGN_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    ROITensor : DML_TENSOR_DESC.Ptr
    BatchIndicesTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ReductionFunction : DML_REDUCE_FUNCTION
    InterpolationMode : DML_INTERPOLATION_MODE
    SpatialScaleX : Float32
    SpatialScaleY : Float32
    OutOfBoundsInputValue : Float32
    MinimumSamplesPerOutput : UInt32
    MaximumSamplesPerOutput : UInt32
}
struct DML_GATHER_ND1_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    IndicesTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    InputDimensionCount : UInt32
    IndicesDimensionCount : UInt32
    BatchDimensionCount : UInt32
}
struct DML_ELEMENT_WISE_ATAN_YX_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ELEMENT_WISE_CLIP_GRAD_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    InputGradientTensor : DML_TENSOR_DESC.Ptr
    OutputGradientTensor : DML_TENSOR_DESC.Ptr
    Min : Float32
    Max : Float32
}
struct DML_ELEMENT_WISE_DIFFERENCE_SQUARE_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_LOCAL_RESPONSE_NORMALIZATION_GRAD_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    InputGradientTensor : DML_TENSOR_DESC.Ptr
    OutputGradientTensor : DML_TENSOR_DESC.Ptr
    CrossChannel : BOOL
    LocalSize : UInt32
    Alpha : Float32
    Beta : Float32
    Bias : Float32
}
struct DML_CUMULATIVE_PRODUCT_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    Axis : UInt32
    AxisDirection : DML_AXIS_DIRECTION
    HasExclusiveProduct : BOOL
}
struct DML_BATCH_NORMALIZATION_GRAD_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    InputGradientTensor : DML_TENSOR_DESC.Ptr
    MeanTensor : DML_TENSOR_DESC.Ptr
    VarianceTensor : DML_TENSOR_DESC.Ptr
    ScaleTensor : DML_TENSOR_DESC.Ptr
    OutputGradientTensor : DML_TENSOR_DESC.Ptr
    OutputScaleGradientTensor : DML_TENSOR_DESC.Ptr
    OutputBiasGradientTensor : DML_TENSOR_DESC.Ptr
    Epsilon : Float32
}
struct DML_ELEMENT_WISE_QUANTIZED_LINEAR_ADD_OPERATOR_DESC {
    ATensor : DML_TENSOR_DESC.Ptr
    AScaleTensor : DML_TENSOR_DESC.Ptr
    AZeroPointTensor : DML_TENSOR_DESC.Ptr
    BTensor : DML_TENSOR_DESC.Ptr
    BScaleTensor : DML_TENSOR_DESC.Ptr
    BZeroPointTensor : DML_TENSOR_DESC.Ptr
    OutputScaleTensor : DML_TENSOR_DESC.Ptr
    OutputZeroPointTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_DYNAMIC_QUANTIZE_LINEAR_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    OutputScaleTensor : DML_TENSOR_DESC.Ptr
    OutputZeroPointTensor : DML_TENSOR_DESC.Ptr
}
struct DML_ROI_ALIGN1_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    ROITensor : DML_TENSOR_DESC.Ptr
    BatchIndicesTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ReductionFunction : DML_REDUCE_FUNCTION
    InterpolationMode : DML_INTERPOLATION_MODE
    SpatialScaleX : Float32
    SpatialScaleY : Float32
    InputPixelOffset : Float32
    OutputPixelOffset : Float32
    OutOfBoundsInputValue : Float32
    MinimumSamplesPerOutput : UInt32
    MaximumSamplesPerOutput : UInt32
    AlignRegionsToCorners : BOOL
}
struct DML_ROI_ALIGN_GRAD_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    InputGradientTensor : DML_TENSOR_DESC.Ptr
    ROITensor : DML_TENSOR_DESC.Ptr
    BatchIndicesTensor : DML_TENSOR_DESC.Ptr
    OutputGradientTensor : DML_TENSOR_DESC.Ptr
    OutputROIGradientTensor : DML_TENSOR_DESC.Ptr
    ReductionFunction : DML_REDUCE_FUNCTION
    InterpolationMode : DML_INTERPOLATION_MODE
    SpatialScaleX : Float32
    SpatialScaleY : Float32
    InputPixelOffset : Float32
    OutputPixelOffset : Float32
    MinimumSamplesPerOutput : UInt32
    MaximumSamplesPerOutput : UInt32
    AlignRegionsToCorners : BOOL
}
struct DML_BATCH_NORMALIZATION_TRAINING_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    ScaleTensor : DML_TENSOR_DESC.Ptr
    BiasTensor : DML_TENSOR_DESC.Ptr
    FusedAddTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    OutputMeanTensor : DML_TENSOR_DESC.Ptr
    OutputVarianceTensor : DML_TENSOR_DESC.Ptr
    Epsilon : Float32
    FusedActivation : DML_OPERATOR_DESC.Ptr
}
struct DML_BATCH_NORMALIZATION_TRAINING_GRAD_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    InputGradientTensor : DML_TENSOR_DESC.Ptr
    MeanTensor : DML_TENSOR_DESC.Ptr
    VarianceTensor : DML_TENSOR_DESC.Ptr
    ScaleTensor : DML_TENSOR_DESC.Ptr
    OutputGradientTensor : DML_TENSOR_DESC.Ptr
    OutputScaleGradientTensor : DML_TENSOR_DESC.Ptr
    OutputBiasGradientTensor : DML_TENSOR_DESC.Ptr
    Epsilon : Float32
}
struct DML_ELEMENT_WISE_CLIP1_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    ScaleBias : DML_SCALE_BIAS.Ptr
    MinMaxDataType : DML_TENSOR_DATA_TYPE
    Min : DML_SCALAR_UNION
    Max : DML_SCALAR_UNION
}
struct DML_ELEMENT_WISE_CLIP_GRAD1_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    InputGradientTensor : DML_TENSOR_DESC.Ptr
    OutputGradientTensor : DML_TENSOR_DESC.Ptr
    MinMaxDataType : DML_TENSOR_DATA_TYPE
    Min : DML_SCALAR_UNION
    Max : DML_SCALAR_UNION
}
struct DML_PADDING1_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
    PaddingMode : DML_PADDING_MODE
    PaddingValueDataType : DML_TENSOR_DATA_TYPE
    PaddingValue : DML_SCALAR_UNION
    DimensionCount : UInt32
    StartPadding : UInt32.Ptr
    EndPadding : UInt32.Ptr
}
struct DML_ELEMENT_WISE_NEGATE_OPERATOR_DESC {
    InputTensor : DML_TENSOR_DESC.Ptr
    OutputTensor : DML_TENSOR_DESC.Ptr
}
struct DML_FEATURE_LEVEL extends Int32 {
    static DML_FEATURE_LEVEL_1_0 := 4096
    static DML_FEATURE_LEVEL_2_0 := 8192
    static DML_FEATURE_LEVEL_2_1 := 8448
    static DML_FEATURE_LEVEL_3_0 := 12288
    static DML_FEATURE_LEVEL_3_1 := 12544
    static DML_FEATURE_LEVEL_4_0 := 16384
    static DML_FEATURE_LEVEL_4_1 := 16640
    static DML_FEATURE_LEVEL_5_0 := 20480
    static DML_FEATURE_LEVEL_5_1 := 20736
    static DML_FEATURE_LEVEL_5_2 := 20992
    static DML_FEATURE_LEVEL_6_0 := 24576
    static DML_FEATURE_LEVEL_6_1 := 24832
    static DML_FEATURE_LEVEL_6_2 := 25088
    static DML_FEATURE_LEVEL_6_3 := 25344
    static DML_FEATURE_LEVEL_6_4 := 25600
}
struct DML_FEATURE extends Int32 {
    static DML_FEATURE_TENSOR_DATA_TYPE_SUPPORT := 0
    static DML_FEATURE_FEATURE_LEVELS := 1
}
struct DML_FEATURE_QUERY_TENSOR_DATA_TYPE_SUPPORT {
    DataType : DML_TENSOR_DATA_TYPE
}
struct DML_FEATURE_DATA_TENSOR_DATA_TYPE_SUPPORT {
    IsSupported : BOOL
}
struct DML_FEATURE_QUERY_FEATURE_LEVELS {
    RequestedFeatureLevelCount : UInt32
    RequestedFeatureLevels : DML_FEATURE_LEVEL.Ptr
}
struct DML_FEATURE_DATA_FEATURE_LEVELS {
    MaxSupportedFeatureLevel : DML_FEATURE_LEVEL
}
struct DML_BINDING_TABLE_DESC {
    Dispatchable : IDMLDispatchable
    CPUDescriptorHandle : D3D12_CPU_DESCRIPTOR_HANDLE
    GPUDescriptorHandle : D3D12_GPU_DESCRIPTOR_HANDLE
    SizeInDescriptors : UInt32
}
struct DML_EXECUTION_FLAGS extends Int32 {
    static DML_EXECUTION_FLAG_NONE := 0
    static DML_EXECUTION_FLAG_ALLOW_HALF_PRECISION_COMPUTATION := 1
    static DML_EXECUTION_FLAG_DISABLE_META_COMMANDS := 2
    static DML_EXECUTION_FLAG_DESCRIPTORS_VOLATILE := 4
}
struct DML_CREATE_DEVICE_FLAGS extends Int32 {
    static DML_CREATE_DEVICE_FLAG_NONE := 0
    static DML_CREATE_DEVICE_FLAG_DEBUG := 1
}
struct IDMLObject extends IUnknown {
    static IID := "{C8263AAC-9E0C-4A2D-9B8E-007521A3317C}"
    GetPrivateData(guid, dataSize, data?)
      => ComCall(3, this.p, GUID.Ptr, guid, UInt32.Ptr, dataSize, Struct.Ptr, data?)
    SetPrivateData(guid, data?)
      => ComCall(4, this.p, GUID.Ptr, guid, UInt32, data?.Size ?? 0, Struct.Ptr, data?)
    SetPrivateDataInterface(guid, data?)
      => ComCall(5, this.p, GUID.Ptr, guid, IUnknown, data?)
    SetName(name)
      => ComCall(6, this.p, "Str", name)
}
struct IDMLDevice extends IDMLObject {
    static IID := "{6DBD6437-96FD-423F-A98C-AE5E7C2A573F}"
    CheckFeatureSupport(feature, featureQueryData?, featureSupportData)
      => ComCall(7, this.p, DML_FEATURE, feature, UInt32, featureQueryData?.Size ?? 0, Struct.Ptr, featureQueryData?, UInt32, featureSupportData.Size, Struct.Ptr, featureSupportData)
    CreateOperator(desc, riid, ppv?)
      => ComCall(8, this.p, DML_OPERATOR_DESC.Ptr, desc, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv?)
    CompileOperator(op, flags, riid, ppv?)
      => ComCall(9, this.p, IDMLOperator, op, DML_EXECUTION_FLAGS, flags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv?)
    CreateOperatorInitializer(operators?, riid, ppv)
      => ComCall(10, this.p, UInt32, operators?.Length ?? 0, IDMLCompiledOperator.Ptr, operators?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateCommandRecorder(riid, ppv)
      => ComCall(11, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    CreateBindingTable(desc?, riid, ppv)
      => ComCall(12, this.p, DML_BINDING_TABLE_DESC.Ptr, desc?, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
    Evict(ppObjects)
      => ComCall(13, this.p, UInt32, ppObjects.Length, IDMLPageable.Ptr, ppObjects)
    MakeResident(ppObjects)
      => ComCall(14, this.p, UInt32, ppObjects.Length, IDMLPageable.Ptr, ppObjects)
    GetDeviceRemovedReason()
      => ComCall(15, this.p)
    GetParentDevice(riid, ppv)
      => ComCall(16, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IDMLDeviceChild extends IDMLObject {
    static IID := "{27E83142-8165-49E3-974E-2FD66E4CB69D}"
    GetDevice(riid, ppv)
      => ComCall(7, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv)
}
struct IDMLPageable extends IDMLDeviceChild {
    static IID := "{B1AB0825-4542-4A4B-8617-6DDE6E8F6201}"
}
struct IDMLOperator extends IDMLDeviceChild {
    static IID := "{26CAAE7A-3081-4633-9581-226FBE57695D}"
}
struct DML_BINDING_PROPERTIES {
    RequiredDescriptorCount : UInt32
    TemporaryResourceSize : Int64
    PersistentResourceSize : Int64
}
struct IDMLDispatchable extends IDMLPageable {
    static IID := "{DCB821A8-1039-441E-9F1C-B1759C2F3CEC}"
    GetBindingProperties()
      => ComCall(8, this.p, DML_BINDING_PROPERTIES)
}
struct IDMLCompiledOperator extends IDMLDispatchable {
    static IID := "{6B15E56A-BF5C-4902-92D8-DA3A650AFEA4}"
}
struct IDMLOperatorInitializer extends IDMLDispatchable {
    static IID := "{427C1113-435C-469C-8676-4D5DD072F813}"
    Reset(operators?)
      => ComCall(9, this.p, UInt32, operators?.Length ?? 0, IDMLCompiledOperator.Ptr, operators?)
}
struct DML_BINDING_TYPE extends Int32 {
    static DML_BINDING_TYPE_NONE := 0
    static DML_BINDING_TYPE_BUFFER := 1
    static DML_BINDING_TYPE_BUFFER_ARRAY := 2
}
struct DML_BINDING_DESC {
    Type : DML_BINDING_TYPE
    Desc : Struct.Ptr
}
struct DML_BUFFER_BINDING {
    Buffer : ID3D12Resource
    Offset : Int64
    SizeInBytes : Int64
}
struct DML_BUFFER_ARRAY_BINDING {
    BindingCount : UInt32
    Bindings : DML_BUFFER_BINDING.Ptr
}
struct IDMLBindingTable extends IDMLDeviceChild {
    static IID := "{29C687DC-DE74-4E3B-AB00-1168F2FC3CFC}"
    BindInputs(bindings?)
      => ComCall(8, this.p, UInt32, bindings?.Length ?? 0, DML_BINDING_DESC.Ptr, bindings?, "void")
    BindOutputs(bindings?)
      => ComCall(9, this.p, UInt32, bindings?.Length ?? 0, DML_BINDING_DESC.Ptr, bindings?, "void")
    BindTemporaryResource(binding?)
      => ComCall(10, this.p, DML_BINDING_DESC.Ptr, binding?, "void")
    BindPersistentResource(binding?)
      => ComCall(11, this.p, DML_BINDING_DESC.Ptr, binding?, "void")
    Reset(desc?)
      => ComCall(12, this.p, DML_BINDING_TABLE_DESC.Ptr, desc?)
}
struct IDMLCommandRecorder extends IDMLDeviceChild {
    static IID := "{E6857A76-2E3E-4FDD-BFF4-5D2BA10FB453}"
    RecordDispatch(commandList, dispatchable, bindings)
      => ComCall(8, this.p, ID3D12CommandList, commandList, IDMLDispatchable, dispatchable, IDMLBindingTable, bindings, "void")
}
struct IDMLDebugDevice extends IUnknown {
    static IID := "{7D6F3AC9-394A-4AC3-92A7-390CC57A8217}"
    SetMuteDebugOutput(mute)
      => ComCall(3, this.p, BOOL, mute, "void")
}
struct DML_GRAPH_EDGE_TYPE extends Int32 {
    static DML_GRAPH_EDGE_TYPE_INVALID := 0
    static DML_GRAPH_EDGE_TYPE_INPUT := 1
    static DML_GRAPH_EDGE_TYPE_OUTPUT := 2
    static DML_GRAPH_EDGE_TYPE_INTERMEDIATE := 3
}
struct DML_GRAPH_EDGE_DESC {
    Type : DML_GRAPH_EDGE_TYPE
    Desc : Struct.Ptr
}
struct DML_INPUT_GRAPH_EDGE_DESC {
    GraphInputIndex : UInt32
    ToNodeIndex : UInt32
    ToNodeInputIndex : UInt32
    Name : PSTR
}
struct DML_OUTPUT_GRAPH_EDGE_DESC {
    FromNodeIndex : UInt32
    FromNodeOutputIndex : UInt32
    GraphOutputIndex : UInt32
    Name : PSTR
}
struct DML_INTERMEDIATE_GRAPH_EDGE_DESC {
    FromNodeIndex : UInt32
    FromNodeOutputIndex : UInt32
    ToNodeIndex : UInt32
    ToNodeInputIndex : UInt32
    Name : PSTR
}
struct DML_GRAPH_NODE_TYPE extends Int32 {
    static DML_GRAPH_NODE_TYPE_INVALID := 0
    static DML_GRAPH_NODE_TYPE_OPERATOR := 1
}
struct DML_GRAPH_NODE_DESC {
    Type : DML_GRAPH_NODE_TYPE
    Desc : Struct.Ptr
}
struct DML_OPERATOR_GRAPH_NODE_DESC {
    Operator : IDMLOperator
    Name : PSTR
}
struct DML_GRAPH_DESC {
    InputCount : UInt32
    OutputCount : UInt32
    NodeCount : UInt32
    Nodes : DML_GRAPH_NODE_DESC.Ptr
    InputEdgeCount : UInt32
    InputEdges : DML_GRAPH_EDGE_DESC.Ptr
    OutputEdgeCount : UInt32
    OutputEdges : DML_GRAPH_EDGE_DESC.Ptr
    IntermediateEdgeCount : UInt32
    IntermediateEdges : DML_GRAPH_EDGE_DESC.Ptr
}
struct IDMLDevice1 extends IDMLDevice {
    static IID := "{A0884F9A-D2BE-4355-AA5D-5901281AD1D2}"
    CompileGraph(desc, flags, riid, ppv?)
      => ComCall(17, this.p, DML_GRAPH_DESC.Ptr, desc, DML_EXECUTION_FLAGS, flags, GUID.Ptr, riid, Struct.Ptr.Ptr, ppv?)
}
