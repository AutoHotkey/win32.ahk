#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PSTR, PWSTR}
#Import "..\Graphics.Direct3D12\Types.ahk" {ID3D12Device, ID3D12Resource}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct WINML_TENSOR_DATA_TYPE extends Int32 {
    static WINML_TENSOR_UNDEFINED := 0
    static WINML_TENSOR_FLOAT := 1
    static WINML_TENSOR_UINT8 := 2
    static WINML_TENSOR_INT8 := 3
    static WINML_TENSOR_UINT16 := 4
    static WINML_TENSOR_INT16 := 5
    static WINML_TENSOR_INT32 := 6
    static WINML_TENSOR_INT64 := 7
    static WINML_TENSOR_STRING := 8
    static WINML_TENSOR_BOOLEAN := 9
    static WINML_TENSOR_FLOAT16 := 10
    static WINML_TENSOR_DOUBLE := 11
    static WINML_TENSOR_UINT32 := 12
    static WINML_TENSOR_UINT64 := 13
    static WINML_TENSOR_COMPLEX64 := 14
    static WINML_TENSOR_COMPLEX128 := 15
}
struct WINML_FEATURE_TYPE extends Int32 {
    static WINML_FEATURE_UNDEFINED := 0
    static WINML_FEATURE_TENSOR := 1
    static WINML_FEATURE_SEQUENCE := 2
    static WINML_FEATURE_MAP := 3
    static WINML_FEATURE_IMAGE := 4
}
struct WINML_BINDING_TYPE extends Int32 {
    static WINML_BINDING_UNDEFINED := 0
    static WINML_BINDING_TENSOR := 1
    static WINML_BINDING_SEQUENCE := 2
    static WINML_BINDING_MAP := 3
    static WINML_BINDING_IMAGE := 4
    static WINML_BINDING_RESOURCE := 5
}
struct WINML_TENSOR_BINDING_DESC {
    DataType : WINML_TENSOR_DATA_TYPE
    NumDimensions : UInt32
    pShape : Int64.Ptr
    DataSize : UInt32
    pData : Struct.Ptr
}
struct WINML_SEQUENCE_BINDING_DESC {
    ElementCount : UInt32
    ElementType : WINML_TENSOR_DATA_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            pStrings : PWSTR.Ptr
            pInts : Int64.Ptr
            pFloats : Float32.Ptr
            pDoubles : Float64.Ptr
        }
    }
}
struct WINML_MAP_BINDING_DESC {
    ElementCount : UInt32
    KeyType : WINML_TENSOR_DATA_TYPE
    Anonymous1 : this._Anonymous1_e__Union
    Fields : WINML_TENSOR_DATA_TYPE
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            pStringKeys : PWSTR.Ptr
            pIntKeys : Int64.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            pStringFields : PWSTR.Ptr
            pIntFields : Int64.Ptr
            pFloatFields : Float32.Ptr
            pDoubleFields : Float64.Ptr
        }
    }
}
struct WINML_IMAGE_BINDING_DESC {
    ElementType : WINML_TENSOR_DATA_TYPE
    NumDimensions : UInt32
    pShape : Int64.Ptr
    DataSize : UInt32
    pData : Struct.Ptr
}
struct WINML_RESOURCE_BINDING_DESC {
    ElementType : WINML_TENSOR_DATA_TYPE
    NumDimensions : UInt32
    pShape : Int64.Ptr
    pResource : ID3D12Resource
}
struct WINML_BINDING_DESC {
    Name : PWSTR
    BindType : WINML_BINDING_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Tensor : WINML_TENSOR_BINDING_DESC
            Sequence : WINML_SEQUENCE_BINDING_DESC
            Map : WINML_MAP_BINDING_DESC
            Image : WINML_IMAGE_BINDING_DESC
            Resource : WINML_RESOURCE_BINDING_DESC
        }
    }
}
struct WINML_TENSOR_VARIABLE_DESC {
    ElementType : WINML_TENSOR_DATA_TYPE
    NumDimensions : UInt32
    pShape : Int64.Ptr
}
struct WINML_SEQUENCE_VARIABLE_DESC {
    ElementType : WINML_TENSOR_DATA_TYPE
}
struct WINML_MAP_VARIABLE_DESC {
    KeyType : WINML_TENSOR_DATA_TYPE
    Fields : WINML_TENSOR_DATA_TYPE
}
struct WINML_IMAGE_VARIABLE_DESC {
    ElementType : WINML_TENSOR_DATA_TYPE
    NumDimensions : UInt32
    pShape : Int64.Ptr
}
struct WINML_VARIABLE_DESC {
    Name : PWSTR
    Description : PWSTR
    FeatureType : WINML_FEATURE_TYPE
    Required : BOOL
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Tensor : WINML_TENSOR_VARIABLE_DESC
            Sequence : WINML_SEQUENCE_VARIABLE_DESC
            Map : WINML_MAP_VARIABLE_DESC
            Image : WINML_IMAGE_VARIABLE_DESC
        }
    }
}
struct WINML_MODEL_DESC {
    Author : PWSTR
    Name : PWSTR
    Domain : PWSTR
    Description : PWSTR
    Version : IntPtr
}
struct IWinMLModel extends IUnknown {
    static IID := "{E2EEB6A9-F31F-4055-A521-E30B5B33664A}"
    GetDescription(ppDescription)
      => ComCall(3, this.p, WINML_MODEL_DESC.Ptr.Ptr, ppDescription)
    EnumerateMetadata(Index, pKey, pValue)
      => ComCall(4, this.p, UInt32, Index, PWSTR.Ptr, pKey, PWSTR.Ptr, pValue)
    EnumerateModelInputs(Index, ppInputDescriptor)
      => ComCall(5, this.p, UInt32, Index, WINML_VARIABLE_DESC.Ptr.Ptr, ppInputDescriptor)
    EnumerateModelOutputs(Index, ppOutputDescriptor)
      => ComCall(6, this.p, UInt32, Index, WINML_VARIABLE_DESC.Ptr.Ptr, ppOutputDescriptor)
}
struct IWinMLEvaluationContext extends IUnknown {
    static IID := "{95848F9E-583D-4054-AF12-916387CD8426}"
    BindValue(pDescriptor)
      => ComCall(3, this.p, WINML_BINDING_DESC.Ptr, pDescriptor)
    GetValueByName(Name, pDescriptor)
      => ComCall(4, this.p, "Str", Name, WINML_BINDING_DESC.Ptr.Ptr, pDescriptor)
    Clear()
      => ComCall(5, this.p)
}
struct IWinMLRuntime extends IUnknown {
    static IID := "{A0425329-40AE-48D9-BCE3-829EF7B8A41A}"
    LoadModel(Path, ppModel)
      => ComCall(3, this.p, "Str", Path, IWinMLModel.Ptr, ppModel)
    CreateEvaluationContext(device?, ppContext)
      => ComCall(4, this.p, ID3D12Device, device?, IWinMLEvaluationContext.Ptr, ppContext)
    EvaluateModel(pContext)
      => ComCall(5, this.p, IWinMLEvaluationContext, pContext)
}
struct WINML_RUNTIME_TYPE extends Int32 {
    static WINML_RUNTIME_CNTK := 0
}
struct IWinMLRuntimeFactory extends IUnknown {
    static IID := "{A807B84D-4AE5-4BC0-A76A-941AA246BD41}"
    CreateRuntime(RuntimeType, ppRuntime)
      => ComCall(3, this.p, WINML_RUNTIME_TYPE, RuntimeType, IWinMLRuntime.Ptr, ppRuntime)
}
struct MLOperatorAttributeType extends UInt32 {
    static Undefined := 0
    static Float := 2
    static Int := 3
    static String := 4
    static FloatArray := 7
    static IntArray := 8
    static StringArray := 9
}
struct MLOperatorTensorDataType extends UInt32 {
    static Undefined := 0
    static Float := 1
    static UInt8 := 2
    static Int8 := 3
    static UInt16 := 4
    static Int16 := 5
    static Int32 := 6
    static Int64 := 7
    static String := 8
    static Bool := 9
    static Float16 := 10
    static Double := 11
    static UInt32 := 12
    static UInt64 := 13
    static Complex64 := 14
    static Complex128 := 15
}
struct MLOperatorEdgeType extends UInt32 {
    static Undefined := 0
    static Tensor := 1
    static SequenceTensor := 2
    static Primitive := 3
}
struct MLOperatorEdgeDescription {
    edgeType : MLOperatorEdgeType
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            reserved : Int64
            tensorDataType : MLOperatorTensorDataType
        }
    }
}
struct IMLOperatorAttributes extends IUnknown {
    static IID := "{4B1B1759-EC40-466C-AAB4-BEB5347FD24C}"
    GetAttributeElementCount(name, type, elementCount)
      => ComCall(3, this.p, PSTR, name, MLOperatorAttributeType, type, UInt32.Ptr, elementCount)
    GetAttribute(name, type, elementCount, elementByteSize, value)
      => ComCall(4, this.p, PSTR, name, MLOperatorAttributeType, type, UInt32, elementCount, IntPtr, elementByteSize, Struct.Ptr, value)
    GetStringAttributeElementLength(name, elementIndex, attributeElementByteSize)
      => ComCall(5, this.p, PSTR, name, UInt32, elementIndex, UInt32.Ptr, attributeElementByteSize)
    GetStringAttributeElement(name, elementIndex, attributeElement)
      => ComCall(6, this.p, PSTR, name, UInt32, elementIndex, UInt32, attributeElement.Length, PSTR, attributeElement)
}
struct IMLOperatorTensorShapeDescription extends IUnknown {
    static IID := "{F20E8CBE-3B28-4248-BE95-F96FBC6E4643}"
    GetInputTensorDimensionCount(inputIndex, dimensionCount)
      => ComCall(3, this.p, UInt32, inputIndex, UInt32.Ptr, dimensionCount)
    GetInputTensorShape(inputIndex, dimensions)
      => ComCall(4, this.p, UInt32, inputIndex, UInt32, dimensions.Length, UInt32.Ptr, dimensions)
    HasOutputShapeDescription()
      => ComCall(5, this.p, Boolean8)
    GetOutputTensorDimensionCount(outputIndex, dimensionCount)
      => ComCall(6, this.p, UInt32, outputIndex, UInt32.Ptr, dimensionCount)
    GetOutputTensorShape(outputIndex, dimensions)
      => ComCall(7, this.p, UInt32, outputIndex, UInt32, dimensions.Length, UInt32.Ptr, dimensions)
}
struct IMLOperatorKernelCreationContext extends IMLOperatorAttributes {
    static IID := "{5459B53D-A0FC-4665-ADDD-70171EF7E631}"
    GetInputCount()
      => ComCall(7, this.p, UInt32)
    GetOutputCount()
      => ComCall(8, this.p, UInt32)
    IsInputValid(inputIndex)
      => ComCall(9, this.p, UInt32, inputIndex, Boolean8)
    IsOutputValid(outputIndex)
      => ComCall(10, this.p, UInt32, outputIndex, Boolean8)
    GetInputEdgeDescription(inputIndex, edgeDescription)
      => ComCall(11, this.p, UInt32, inputIndex, MLOperatorEdgeDescription.Ptr, edgeDescription)
    GetOutputEdgeDescription(outputIndex, edgeDescription)
      => ComCall(12, this.p, UInt32, outputIndex, MLOperatorEdgeDescription.Ptr, edgeDescription)
    HasTensorShapeDescription()
      => ComCall(13, this.p, Boolean8)
    GetTensorShapeDescription(shapeDescription)
      => ComCall(14, this.p, IMLOperatorTensorShapeDescription.Ptr, shapeDescription)
    GetExecutionInterface(executionObject)
      => ComCall(15, this.p, IUnknown.Ptr, executionObject, "void")
}
struct IMLOperatorTensor extends IUnknown {
    static IID := "{7FE41F41-F430-440E-AECE-54416DC8B9DB}"
    GetDimensionCount()
      => ComCall(3, this.p, UInt32)
    GetShape(dimensions)
      => ComCall(4, this.p, UInt32, dimensions.Length, UInt32.Ptr, dimensions)
    GetTensorDataType()
      => ComCall(5, this.p, MLOperatorTensorDataType)
    IsCpuData()
      => ComCall(6, this.p, Boolean8)
    IsDataInterface()
      => ComCall(7, this.p, Boolean8)
    GetData()
      => ComCall(8, this.p, Struct.Ptr)
    GetDataInterface(dataInterface)
      => ComCall(9, this.p, IUnknown.Ptr, dataInterface, "void")
}
struct IMLOperatorKernelContext extends IUnknown {
    static IID := "{82536A28-F022-4769-9D3F-8B278F84C0C3}"
    GetInputTensor(inputIndex, tensor)
      => ComCall(3, this.p, UInt32, inputIndex, IMLOperatorTensor.Ptr, tensor)
    GetOutputTensor(outputIndex, dimensionSizes, tensor)
      => ComCall(4, this.p, UInt32, outputIndex, UInt32, dimensionSizes.Length, UInt32.Ptr, dimensionSizes, IMLOperatorTensor.Ptr, tensor)
    GetOutputTensor_2(outputIndex, tensor)
      => ComCall(5, this.p, UInt32, outputIndex, IMLOperatorTensor.Ptr, tensor)
    AllocateTemporaryData(size, data)
      => ComCall(6, this.p, IntPtr, size, IUnknown.Ptr, data)
    GetExecutionInterface(executionObject)
      => ComCall(7, this.p, IUnknown.Ptr, executionObject, "void")
}
struct IMLOperatorKernel extends IUnknown {
    static IID := "{11C4B4A0-B467-4EAA-A1A6-B961D8D0ED79}"
    Compute(context)
      => ComCall(3, this.p, IMLOperatorKernelContext, context)
}
struct MLOperatorParameterOptions extends UInt32 {
    static Single := 0
    static Optional := 1
    static Variadic := 2
}
struct MLOperatorSchemaEdgeTypeFormat extends Int32 {
    static EdgeDescription := 0
    static Label := 1
}
struct MLOperatorSchemaEdgeDescription {
    options : MLOperatorParameterOptions
    typeFormat : MLOperatorSchemaEdgeTypeFormat
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            reserved : Struct.Ptr
            typeLabel : PSTR
            edgeDescription : MLOperatorEdgeDescription
        }
    }
}
struct MLOperatorEdgeTypeConstraint {
    typeLabel : PSTR
    allowedTypes : MLOperatorEdgeDescription.Ptr
    allowedTypeCount : UInt32
}
struct IMLOperatorShapeInferenceContext extends IMLOperatorAttributes {
    static IID := "{105B6B29-5408-4A68-9959-09B5955A3492}"
    GetInputCount()
      => ComCall(7, this.p, UInt32)
    GetOutputCount()
      => ComCall(8, this.p, UInt32)
    IsInputValid(inputIndex)
      => ComCall(9, this.p, UInt32, inputIndex, Boolean8)
    IsOutputValid(outputIndex)
      => ComCall(10, this.p, UInt32, outputIndex, Boolean8)
    GetInputEdgeDescription(inputIndex, edgeDescription)
      => ComCall(11, this.p, UInt32, inputIndex, MLOperatorEdgeDescription.Ptr, edgeDescription)
    GetInputTensorDimensionCount(inputIndex, dimensionCount)
      => ComCall(12, this.p, UInt32, inputIndex, UInt32.Ptr, dimensionCount)
    GetInputTensorShape(inputIndex, dimensions)
      => ComCall(13, this.p, UInt32, inputIndex, UInt32, dimensions.Length, UInt32.Ptr, dimensions)
    SetOutputTensorShape(outputIndex, dimensionCount, dimensions)
      => ComCall(14, this.p, UInt32, outputIndex, UInt32, dimensionCount, UInt32.Ptr, dimensions)
}
struct IMLOperatorTypeInferenceContext extends IMLOperatorAttributes {
    static IID := "{EC893BB1-F938-427B-8488-C8DCF775F138}"
    GetInputCount()
      => ComCall(7, this.p, UInt32)
    GetOutputCount()
      => ComCall(8, this.p, UInt32)
    IsInputValid(inputIndex)
      => ComCall(9, this.p, UInt32, inputIndex, Boolean8)
    IsOutputValid(outputIndex)
      => ComCall(10, this.p, UInt32, outputIndex, Boolean8)
    GetInputEdgeDescription(inputIndex, edgeDescription)
      => ComCall(11, this.p, UInt32, inputIndex, MLOperatorEdgeDescription.Ptr, edgeDescription)
    SetOutputEdgeDescription(outputIndex, edgeDescription)
      => ComCall(12, this.p, UInt32, outputIndex, MLOperatorEdgeDescription.Ptr, edgeDescription)
}
struct IMLOperatorTypeInferrer extends IUnknown {
    static IID := "{781AEB48-9BCB-4797-BF77-8BF455217BEB}"
    InferOutputTypes(context)
      => ComCall(3, this.p, IMLOperatorTypeInferenceContext, context)
}
struct IMLOperatorShapeInferrer extends IUnknown {
    static IID := "{540BE5BE-A6C9-40EE-83F6-D2B8B40A7798}"
    InferOutputShapes(context)
      => ComCall(3, this.p, IMLOperatorShapeInferenceContext, context)
}
struct MLOperatorAttribute {
    name : PSTR
    type : MLOperatorAttributeType
    required : UInt8
}
struct MLOperatorAttributeNameValue {
    name : PSTR
    type : MLOperatorAttributeType
    valueCount : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            reserved : Struct.Ptr
            ints : Int64.Ptr
            strings : Int8.Ptr.Ptr
            floats : Float32.Ptr
        }
    }
}
struct MLOperatorSchemaDescription {
    name : PSTR
    operatorSetVersionAtLastChange : Int32
    inputs : MLOperatorSchemaEdgeDescription.Ptr
    inputCount : UInt32
    outputs : MLOperatorSchemaEdgeDescription.Ptr
    outputCount : UInt32
    typeConstraints : MLOperatorEdgeTypeConstraint.Ptr
    typeConstraintCount : UInt32
    attributes : MLOperatorAttribute.Ptr
    attributeCount : UInt32
    defaultAttributes : MLOperatorAttributeNameValue.Ptr
    defaultAttributeCount : UInt32
}
struct MLOperatorSetId {
    domain : PSTR
    version : Int32
}
struct MLOperatorKernelOptions extends UInt32 {
    static None := 0
    static AllowDynamicInputShapes := 1
}
struct MLOperatorExecutionType extends UInt32 {
    static Undefined := 0
    static Cpu := 1
    static D3D12 := 2
}
struct MLOperatorKernelDescription {
    domain : PSTR
    name : PSTR
    minimumOperatorSetVersion : Int32
    executionType : MLOperatorExecutionType
    typeConstraints : MLOperatorEdgeTypeConstraint.Ptr
    typeConstraintCount : UInt32
    defaultAttributes : MLOperatorAttributeNameValue.Ptr
    defaultAttributeCount : UInt32
    options : MLOperatorKernelOptions
    executionOptions : UInt32
}
struct IMLOperatorKernelFactory extends IUnknown {
    static IID := "{EF15AD6F-0DC9-4908-AB35-A575A30DFBF8}"
    CreateKernel(context, kernel)
      => ComCall(3, this.p, IMLOperatorKernelCreationContext, context, IMLOperatorKernel.Ptr, kernel)
}
struct IMLOperatorRegistry extends IUnknown {
    static IID := "{2AF9DD2D-B516-4672-9AB5-530C208493AD}"
    RegisterOperatorSetSchema(operatorSetId, baselineVersion, schema?, typeInferrer?, shapeInferrer?)
      => ComCall(3, this.p, MLOperatorSetId.Ptr, operatorSetId, Int32, baselineVersion, MLOperatorSchemaDescription.Ptr.Ptr, schema?, UInt32, schema?.Length ?? 0, IMLOperatorTypeInferrer, typeInferrer?, IMLOperatorShapeInferrer, shapeInferrer?)
    RegisterOperatorKernel(operatorKernel, operatorKernelFactory, shapeInferrer?)
      => ComCall(4, this.p, MLOperatorKernelDescription.Ptr, operatorKernel, IMLOperatorKernelFactory, operatorKernelFactory, IMLOperatorShapeInferrer, shapeInferrer?)
}
