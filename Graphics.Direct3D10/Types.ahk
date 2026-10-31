#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HMODULE, HRESULT, PSTR, RECT}
#Import "..\Graphics.Direct3D\Types.ahk" {D3D_CBUFFER_TYPE, D3D_NAME, D3D_PRIMITIVE, D3D_PRIMITIVE_TOPOLOGY, D3D_REGISTER_COMPONENT_TYPE, D3D_RESOURCE_RETURN_TYPE, D3D_SHADER_INPUT_TYPE, D3D_SHADER_VARIABLE_CLASS, D3D_SHADER_VARIABLE_TYPE, D3D_SRV_DIMENSION}
#Import "..\Graphics.Dxgi\Types.ahk" {DXGI_SWAP_CHAIN_DESC, IDXGIAdapter, IDXGISwapChain}
#Import "..\Graphics.Dxgi.Common\Types.ahk" {DXGI_FORMAT, DXGI_SAMPLE_DESC}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct D3D10_INPUT_CLASSIFICATION extends Int32 {
    static D3D10_INPUT_PER_VERTEX_DATA := 0
    static D3D10_INPUT_PER_INSTANCE_DATA := 1
}
struct D3D10_INPUT_ELEMENT_DESC {
    SemanticName : PSTR
    SemanticIndex : UInt32
    Format : DXGI_FORMAT
    InputSlot : UInt32
    AlignedByteOffset : UInt32
    InputSlotClass : D3D10_INPUT_CLASSIFICATION
    InstanceDataStepRate : UInt32
}
struct D3D10_FILL_MODE extends Int32 {
    static D3D10_FILL_WIREFRAME := 2
    static D3D10_FILL_SOLID := 3
}
struct D3D10_CULL_MODE extends Int32 {
    static D3D10_CULL_NONE := 1
    static D3D10_CULL_FRONT := 2
    static D3D10_CULL_BACK := 3
}
struct D3D10_SO_DECLARATION_ENTRY {
    SemanticName : PSTR
    SemanticIndex : UInt32
    StartComponent : UInt8
    ComponentCount : UInt8
    OutputSlot : UInt8
}
struct D3D10_VIEWPORT {
    TopLeftX : Int32
    TopLeftY : Int32
    Width : UInt32
    Height : UInt32
    MinDepth : Float32
    MaxDepth : Float32
}
struct D3D10_RESOURCE_DIMENSION extends Int32 {
    static D3D10_RESOURCE_DIMENSION_UNKNOWN := 0
    static D3D10_RESOURCE_DIMENSION_BUFFER := 1
    static D3D10_RESOURCE_DIMENSION_TEXTURE1D := 2
    static D3D10_RESOURCE_DIMENSION_TEXTURE2D := 3
    static D3D10_RESOURCE_DIMENSION_TEXTURE3D := 4
}
struct D3D10_DSV_DIMENSION extends Int32 {
    static D3D10_DSV_DIMENSION_UNKNOWN := 0
    static D3D10_DSV_DIMENSION_TEXTURE1D := 1
    static D3D10_DSV_DIMENSION_TEXTURE1DARRAY := 2
    static D3D10_DSV_DIMENSION_TEXTURE2D := 3
    static D3D10_DSV_DIMENSION_TEXTURE2DARRAY := 4
    static D3D10_DSV_DIMENSION_TEXTURE2DMS := 5
    static D3D10_DSV_DIMENSION_TEXTURE2DMSARRAY := 6
}
struct D3D10_RTV_DIMENSION extends Int32 {
    static D3D10_RTV_DIMENSION_UNKNOWN := 0
    static D3D10_RTV_DIMENSION_BUFFER := 1
    static D3D10_RTV_DIMENSION_TEXTURE1D := 2
    static D3D10_RTV_DIMENSION_TEXTURE1DARRAY := 3
    static D3D10_RTV_DIMENSION_TEXTURE2D := 4
    static D3D10_RTV_DIMENSION_TEXTURE2DARRAY := 5
    static D3D10_RTV_DIMENSION_TEXTURE2DMS := 6
    static D3D10_RTV_DIMENSION_TEXTURE2DMSARRAY := 7
    static D3D10_RTV_DIMENSION_TEXTURE3D := 8
}
struct D3D10_USAGE extends Int32 {
    static D3D10_USAGE_DEFAULT := 0
    static D3D10_USAGE_IMMUTABLE := 1
    static D3D10_USAGE_DYNAMIC := 2
    static D3D10_USAGE_STAGING := 3
}
struct D3D10_BIND_FLAG extends Int32 {
    static D3D10_BIND_VERTEX_BUFFER := 1
    static D3D10_BIND_INDEX_BUFFER := 2
    static D3D10_BIND_CONSTANT_BUFFER := 4
    static D3D10_BIND_SHADER_RESOURCE := 8
    static D3D10_BIND_STREAM_OUTPUT := 16
    static D3D10_BIND_RENDER_TARGET := 32
    static D3D10_BIND_DEPTH_STENCIL := 64
}
struct D3D10_CPU_ACCESS_FLAG extends Int32 {
    static D3D10_CPU_ACCESS_WRITE := 65536
    static D3D10_CPU_ACCESS_READ := 131072
}
struct D3D10_RESOURCE_MISC_FLAG extends Int32 {
    static D3D10_RESOURCE_MISC_GENERATE_MIPS := 1
    static D3D10_RESOURCE_MISC_SHARED := 2
    static D3D10_RESOURCE_MISC_TEXTURECUBE := 4
    static D3D10_RESOURCE_MISC_SHARED_KEYEDMUTEX := 16
    static D3D10_RESOURCE_MISC_GDI_COMPATIBLE := 32
}
struct D3D10_MAP extends Int32 {
    static D3D10_MAP_READ := 1
    static D3D10_MAP_WRITE := 2
    static D3D10_MAP_READ_WRITE := 3
    static D3D10_MAP_WRITE_DISCARD := 4
    static D3D10_MAP_WRITE_NO_OVERWRITE := 5
}
struct D3D10_MAP_FLAG extends Int32 {
    static D3D10_MAP_FLAG_DO_NOT_WAIT := 1048576
}
struct D3D10_RAISE_FLAG extends Int32 {
    static D3D10_RAISE_FLAG_DRIVER_INTERNAL_ERROR := 1
}
struct D3D10_CLEAR_FLAG extends Int32 {
    static D3D10_CLEAR_DEPTH := 1
    static D3D10_CLEAR_STENCIL := 2
}
struct D3D10_BOX {
    left : UInt32
    top : UInt32
    front : UInt32
    right : UInt32
    bottom : UInt32
    back : UInt32
}
struct ID3D10DeviceChild extends IUnknown {
    static IID := "{9B7E4C00-342C-4106-A19F-4F2704F689F0}"
    GetDevice(ppDevice)
      => ComCall(3, this.p, ID3D10Device.Ptr, ppDevice, "void")
    GetPrivateData(guid, pDataSize, pData?)
      => ComCall(4, this.p, GUID.Ptr, guid, UInt32.Ptr, pDataSize, Struct.Ptr, pData?)
    SetPrivateData(guid, pData?)
      => ComCall(5, this.p, GUID.Ptr, guid, UInt32, pData?.Size ?? 0, Struct.Ptr, pData?)
    SetPrivateDataInterface(guid, pData?)
      => ComCall(6, this.p, GUID.Ptr, guid, IUnknown, pData?)
}
struct D3D10_COMPARISON_FUNC extends Int32 {
    static D3D10_COMPARISON_NEVER := 1
    static D3D10_COMPARISON_LESS := 2
    static D3D10_COMPARISON_EQUAL := 3
    static D3D10_COMPARISON_LESS_EQUAL := 4
    static D3D10_COMPARISON_GREATER := 5
    static D3D10_COMPARISON_NOT_EQUAL := 6
    static D3D10_COMPARISON_GREATER_EQUAL := 7
    static D3D10_COMPARISON_ALWAYS := 8
}
struct D3D10_DEPTH_WRITE_MASK extends Int32 {
    static D3D10_DEPTH_WRITE_MASK_ZERO := 0
    static D3D10_DEPTH_WRITE_MASK_ALL := 1
}
struct D3D10_STENCIL_OP extends Int32 {
    static D3D10_STENCIL_OP_KEEP := 1
    static D3D10_STENCIL_OP_ZERO := 2
    static D3D10_STENCIL_OP_REPLACE := 3
    static D3D10_STENCIL_OP_INCR_SAT := 4
    static D3D10_STENCIL_OP_DECR_SAT := 5
    static D3D10_STENCIL_OP_INVERT := 6
    static D3D10_STENCIL_OP_INCR := 7
    static D3D10_STENCIL_OP_DECR := 8
}
struct D3D10_DEPTH_STENCILOP_DESC {
    StencilFailOp : D3D10_STENCIL_OP
    StencilDepthFailOp : D3D10_STENCIL_OP
    StencilPassOp : D3D10_STENCIL_OP
    StencilFunc : D3D10_COMPARISON_FUNC
}
struct D3D10_DEPTH_STENCIL_DESC {
    DepthEnable : BOOL
    DepthWriteMask : D3D10_DEPTH_WRITE_MASK
    DepthFunc : D3D10_COMPARISON_FUNC
    StencilEnable : BOOL
    StencilReadMask : UInt8
    StencilWriteMask : UInt8
    FrontFace : D3D10_DEPTH_STENCILOP_DESC
    BackFace : D3D10_DEPTH_STENCILOP_DESC
}
struct ID3D10DepthStencilState extends ID3D10DeviceChild {
    static IID := "{2B4B1CC8-A4AD-41F8-8322-CA86FC3EC675}"
    GetDesc(pDesc)
      => ComCall(7, this.p, D3D10_DEPTH_STENCIL_DESC.Ptr, pDesc, "void")
}
struct D3D10_BLEND extends Int32 {
    static D3D10_BLEND_ZERO := 1
    static D3D10_BLEND_ONE := 2
    static D3D10_BLEND_SRC_COLOR := 3
    static D3D10_BLEND_INV_SRC_COLOR := 4
    static D3D10_BLEND_SRC_ALPHA := 5
    static D3D10_BLEND_INV_SRC_ALPHA := 6
    static D3D10_BLEND_DEST_ALPHA := 7
    static D3D10_BLEND_INV_DEST_ALPHA := 8
    static D3D10_BLEND_DEST_COLOR := 9
    static D3D10_BLEND_INV_DEST_COLOR := 10
    static D3D10_BLEND_SRC_ALPHA_SAT := 11
    static D3D10_BLEND_BLEND_FACTOR := 14
    static D3D10_BLEND_INV_BLEND_FACTOR := 15
    static D3D10_BLEND_SRC1_COLOR := 16
    static D3D10_BLEND_INV_SRC1_COLOR := 17
    static D3D10_BLEND_SRC1_ALPHA := 18
    static D3D10_BLEND_INV_SRC1_ALPHA := 19
}
struct D3D10_BLEND_OP extends Int32 {
    static D3D10_BLEND_OP_ADD := 1
    static D3D10_BLEND_OP_SUBTRACT := 2
    static D3D10_BLEND_OP_REV_SUBTRACT := 3
    static D3D10_BLEND_OP_MIN := 4
    static D3D10_BLEND_OP_MAX := 5
}
struct D3D10_COLOR_WRITE_ENABLE extends Int32 {
    static D3D10_COLOR_WRITE_ENABLE_RED := 1
    static D3D10_COLOR_WRITE_ENABLE_GREEN := 2
    static D3D10_COLOR_WRITE_ENABLE_BLUE := 4
    static D3D10_COLOR_WRITE_ENABLE_ALPHA := 8
    static D3D10_COLOR_WRITE_ENABLE_ALL := 15
}
struct D3D10_BLEND_DESC {
    AlphaToCoverageEnable : BOOL
    BlendEnable : BOOL[8]
    SrcBlend : D3D10_BLEND
    DestBlend : D3D10_BLEND
    BlendOp : D3D10_BLEND_OP
    SrcBlendAlpha : D3D10_BLEND
    DestBlendAlpha : D3D10_BLEND
    BlendOpAlpha : D3D10_BLEND_OP
    RenderTargetWriteMask : UInt8[8]
}
struct ID3D10BlendState extends ID3D10DeviceChild {
    static IID := "{EDAD8D19-8A35-4D6D-8566-2EA276CDE161}"
    GetDesc(pDesc)
      => ComCall(7, this.p, D3D10_BLEND_DESC.Ptr, pDesc, "void")
}
struct D3D10_RASTERIZER_DESC {
    FillMode : D3D10_FILL_MODE
    CullMode : D3D10_CULL_MODE
    FrontCounterClockwise : BOOL
    DepthBias : Int32
    DepthBiasClamp : Float32
    SlopeScaledDepthBias : Float32
    DepthClipEnable : BOOL
    ScissorEnable : BOOL
    MultisampleEnable : BOOL
    AntialiasedLineEnable : BOOL
}
struct ID3D10RasterizerState extends ID3D10DeviceChild {
    static IID := "{A2A07292-89AF-4345-BE2E-C53D9FBB6E9F}"
    GetDesc(pDesc)
      => ComCall(7, this.p, D3D10_RASTERIZER_DESC.Ptr, pDesc, "void")
}
struct D3D10_SUBRESOURCE_DATA {
    pSysMem : Struct.Ptr
    SysMemPitch : UInt32
    SysMemSlicePitch : UInt32
}
struct ID3D10Resource extends ID3D10DeviceChild {
    static IID := "{9B7E4C01-342C-4106-A19F-4F2704F689F0}"
    GetType(rType)
      => ComCall(7, this.p, D3D10_RESOURCE_DIMENSION.Ptr, rType, "void")
    SetEvictionPriority(EvictionPriority)
      => ComCall(8, this.p, UInt32, EvictionPriority, "void")
    GetEvictionPriority()
      => ComCall(9, this.p, UInt32)
}
struct D3D10_BUFFER_DESC {
    ByteWidth : UInt32
    Usage : D3D10_USAGE
    BindFlags : UInt32
    CPUAccessFlags : UInt32
    MiscFlags : UInt32
}
struct ID3D10Buffer extends ID3D10Resource {
    static IID := "{9B7E4C02-342C-4106-A19F-4F2704F689F0}"
    Map(MapType, MapFlags, ppData)
      => ComCall(10, this.p, D3D10_MAP, MapType, UInt32, MapFlags, Struct.Ptr.Ptr, ppData)
    Unmap()
      => ComCall(11, this.p, "void")
    GetDesc(pDesc)
      => ComCall(12, this.p, D3D10_BUFFER_DESC.Ptr, pDesc, "void")
}
struct D3D10_TEXTURE1D_DESC {
    Width : UInt32
    MipLevels : UInt32
    ArraySize : UInt32
    Format : DXGI_FORMAT
    Usage : D3D10_USAGE
    BindFlags : UInt32
    CPUAccessFlags : UInt32
    MiscFlags : UInt32
}
struct ID3D10Texture1D extends ID3D10Resource {
    static IID := "{9B7E4C03-342C-4106-A19F-4F2704F689F0}"
    Map(Subresource, MapType, MapFlags, ppData)
      => ComCall(10, this.p, UInt32, Subresource, D3D10_MAP, MapType, UInt32, MapFlags, Struct.Ptr.Ptr, ppData)
    Unmap(Subresource)
      => ComCall(11, this.p, UInt32, Subresource, "void")
    GetDesc(pDesc)
      => ComCall(12, this.p, D3D10_TEXTURE1D_DESC.Ptr, pDesc, "void")
}
struct D3D10_TEXTURE2D_DESC {
    Width : UInt32
    Height : UInt32
    MipLevels : UInt32
    ArraySize : UInt32
    Format : DXGI_FORMAT
    SampleDesc : DXGI_SAMPLE_DESC
    Usage : D3D10_USAGE
    BindFlags : UInt32
    CPUAccessFlags : UInt32
    MiscFlags : UInt32
}
struct D3D10_MAPPED_TEXTURE2D {
    pData : Struct.Ptr
    RowPitch : UInt32
}
struct ID3D10Texture2D extends ID3D10Resource {
    static IID := "{9B7E4C04-342C-4106-A19F-4F2704F689F0}"
    Map(Subresource, MapType, MapFlags, pMappedTex2D)
      => ComCall(10, this.p, UInt32, Subresource, D3D10_MAP, MapType, UInt32, MapFlags, D3D10_MAPPED_TEXTURE2D.Ptr, pMappedTex2D)
    Unmap(Subresource)
      => ComCall(11, this.p, UInt32, Subresource, "void")
    GetDesc(pDesc)
      => ComCall(12, this.p, D3D10_TEXTURE2D_DESC.Ptr, pDesc, "void")
}
struct D3D10_TEXTURE3D_DESC {
    Width : UInt32
    Height : UInt32
    Depth : UInt32
    MipLevels : UInt32
    Format : DXGI_FORMAT
    Usage : D3D10_USAGE
    BindFlags : UInt32
    CPUAccessFlags : UInt32
    MiscFlags : UInt32
}
struct D3D10_MAPPED_TEXTURE3D {
    pData : Struct.Ptr
    RowPitch : UInt32
    DepthPitch : UInt32
}
struct ID3D10Texture3D extends ID3D10Resource {
    static IID := "{9B7E4C05-342C-4106-A19F-4F2704F689F0}"
    Map(Subresource, MapType, MapFlags, pMappedTex3D)
      => ComCall(10, this.p, UInt32, Subresource, D3D10_MAP, MapType, UInt32, MapFlags, D3D10_MAPPED_TEXTURE3D.Ptr, pMappedTex3D)
    Unmap(Subresource)
      => ComCall(11, this.p, UInt32, Subresource, "void")
    GetDesc(pDesc)
      => ComCall(12, this.p, D3D10_TEXTURE3D_DESC.Ptr, pDesc, "void")
}
struct D3D10_TEXTURECUBE_FACE extends Int32 {
    static D3D10_TEXTURECUBE_FACE_POSITIVE_X := 0
    static D3D10_TEXTURECUBE_FACE_NEGATIVE_X := 1
    static D3D10_TEXTURECUBE_FACE_POSITIVE_Y := 2
    static D3D10_TEXTURECUBE_FACE_NEGATIVE_Y := 3
    static D3D10_TEXTURECUBE_FACE_POSITIVE_Z := 4
    static D3D10_TEXTURECUBE_FACE_NEGATIVE_Z := 5
}
struct ID3D10View extends ID3D10DeviceChild {
    static IID := "{C902B03F-60A7-49BA-9936-2A3AB37A7E33}"
    GetResource(ppResource)
      => ComCall(7, this.p, ID3D10Resource.Ptr, ppResource, "void")
}
struct D3D10_BUFFER_SRV {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            FirstElement : UInt32
            ElementOffset : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            NumElements : UInt32
            ElementWidth : UInt32
        }
    }
}
struct D3D10_TEX1D_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
}
struct D3D10_TEX1D_ARRAY_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D10_TEX2D_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
}
struct D3D10_TEX2D_ARRAY_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D10_TEX3D_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
}
struct D3D10_TEXCUBE_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
}
struct D3D10_TEX2DMS_SRV {
    UnusedField_NothingToDefine : UInt32
}
struct D3D10_TEX2DMS_ARRAY_SRV {
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D10_SHADER_RESOURCE_VIEW_DESC {
    Format : DXGI_FORMAT
    ViewDimension : D3D_SRV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Buffer : D3D10_BUFFER_SRV
            Texture1D : D3D10_TEX1D_SRV
            Texture1DArray : D3D10_TEX1D_ARRAY_SRV
            Texture2D : D3D10_TEX2D_SRV
            Texture2DArray : D3D10_TEX2D_ARRAY_SRV
            Texture2DMS : D3D10_TEX2DMS_SRV
            Texture2DMSArray : D3D10_TEX2DMS_ARRAY_SRV
            Texture3D : D3D10_TEX3D_SRV
            TextureCube : D3D10_TEXCUBE_SRV
        }
    }
}
struct ID3D10ShaderResourceView extends ID3D10View {
    static IID := "{9B7E4C07-342C-4106-A19F-4F2704F689F0}"
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D10_SHADER_RESOURCE_VIEW_DESC.Ptr, pDesc, "void")
}
struct D3D10_BUFFER_RTV {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            FirstElement : UInt32
            ElementOffset : UInt32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            NumElements : UInt32
            ElementWidth : UInt32
        }
    }
}
struct D3D10_TEX1D_RTV {
    MipSlice : UInt32
}
struct D3D10_TEX1D_ARRAY_RTV {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D10_TEX2D_RTV {
    MipSlice : UInt32
}
struct D3D10_TEX2DMS_RTV {
    UnusedField_NothingToDefine : UInt32
}
struct D3D10_TEX2D_ARRAY_RTV {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D10_TEX2DMS_ARRAY_RTV {
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D10_TEX3D_RTV {
    MipSlice : UInt32
    FirstWSlice : UInt32
    WSize : UInt32
}
struct D3D10_RENDER_TARGET_VIEW_DESC {
    Format : DXGI_FORMAT
    ViewDimension : D3D10_RTV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Buffer : D3D10_BUFFER_RTV
            Texture1D : D3D10_TEX1D_RTV
            Texture1DArray : D3D10_TEX1D_ARRAY_RTV
            Texture2D : D3D10_TEX2D_RTV
            Texture2DArray : D3D10_TEX2D_ARRAY_RTV
            Texture2DMS : D3D10_TEX2DMS_RTV
            Texture2DMSArray : D3D10_TEX2DMS_ARRAY_RTV
            Texture3D : D3D10_TEX3D_RTV
        }
    }
}
struct ID3D10RenderTargetView extends ID3D10View {
    static IID := "{9B7E4C08-342C-4106-A19F-4F2704F689F0}"
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D10_RENDER_TARGET_VIEW_DESC.Ptr, pDesc, "void")
}
struct D3D10_TEX1D_DSV {
    MipSlice : UInt32
}
struct D3D10_TEX1D_ARRAY_DSV {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D10_TEX2D_DSV {
    MipSlice : UInt32
}
struct D3D10_TEX2D_ARRAY_DSV {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D10_TEX2DMS_DSV {
    UnusedField_NothingToDefine : UInt32
}
struct D3D10_TEX2DMS_ARRAY_DSV {
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D10_DEPTH_STENCIL_VIEW_DESC {
    Format : DXGI_FORMAT
    ViewDimension : D3D10_DSV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Texture1D : D3D10_TEX1D_DSV
            Texture1DArray : D3D10_TEX1D_ARRAY_DSV
            Texture2D : D3D10_TEX2D_DSV
            Texture2DArray : D3D10_TEX2D_ARRAY_DSV
            Texture2DMS : D3D10_TEX2DMS_DSV
            Texture2DMSArray : D3D10_TEX2DMS_ARRAY_DSV
        }
    }
}
struct ID3D10DepthStencilView extends ID3D10View {
    static IID := "{9B7E4C09-342C-4106-A19F-4F2704F689F0}"
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D10_DEPTH_STENCIL_VIEW_DESC.Ptr, pDesc, "void")
}
struct ID3D10VertexShader extends ID3D10DeviceChild {
    static IID := "{9B7E4C0A-342C-4106-A19F-4F2704F689F0}"
}
struct ID3D10GeometryShader extends ID3D10DeviceChild {
    static IID := "{6316BE88-54CD-4040-AB44-20461BC81F68}"
}
struct ID3D10PixelShader extends ID3D10DeviceChild {
    static IID := "{4968B601-9D00-4CDE-8346-8E7F675819B6}"
}
struct ID3D10InputLayout extends ID3D10DeviceChild {
    static IID := "{9B7E4C0B-342C-4106-A19F-4F2704F689F0}"
}
struct D3D10_FILTER extends Int32 {
    static D3D10_FILTER_MIN_MAG_MIP_POINT := 0
    static D3D10_FILTER_MIN_MAG_POINT_MIP_LINEAR := 1
    static D3D10_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT := 4
    static D3D10_FILTER_MIN_POINT_MAG_MIP_LINEAR := 5
    static D3D10_FILTER_MIN_LINEAR_MAG_MIP_POINT := 16
    static D3D10_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR := 17
    static D3D10_FILTER_MIN_MAG_LINEAR_MIP_POINT := 20
    static D3D10_FILTER_MIN_MAG_MIP_LINEAR := 21
    static D3D10_FILTER_ANISOTROPIC := 85
    static D3D10_FILTER_COMPARISON_MIN_MAG_MIP_POINT := 128
    static D3D10_FILTER_COMPARISON_MIN_MAG_POINT_MIP_LINEAR := 129
    static D3D10_FILTER_COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT := 132
    static D3D10_FILTER_COMPARISON_MIN_POINT_MAG_MIP_LINEAR := 133
    static D3D10_FILTER_COMPARISON_MIN_LINEAR_MAG_MIP_POINT := 144
    static D3D10_FILTER_COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR := 145
    static D3D10_FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT := 148
    static D3D10_FILTER_COMPARISON_MIN_MAG_MIP_LINEAR := 149
    static D3D10_FILTER_COMPARISON_ANISOTROPIC := 213
    static D3D10_FILTER_TEXT_1BIT := -2147483648
}
struct D3D10_FILTER_TYPE extends Int32 {
    static D3D10_FILTER_TYPE_POINT := 0
    static D3D10_FILTER_TYPE_LINEAR := 1
}
struct D3D10_TEXTURE_ADDRESS_MODE extends Int32 {
    static D3D10_TEXTURE_ADDRESS_WRAP := 1
    static D3D10_TEXTURE_ADDRESS_MIRROR := 2
    static D3D10_TEXTURE_ADDRESS_CLAMP := 3
    static D3D10_TEXTURE_ADDRESS_BORDER := 4
    static D3D10_TEXTURE_ADDRESS_MIRROR_ONCE := 5
}
struct D3D10_SAMPLER_DESC {
    Filter : D3D10_FILTER
    AddressU : D3D10_TEXTURE_ADDRESS_MODE
    AddressV : D3D10_TEXTURE_ADDRESS_MODE
    AddressW : D3D10_TEXTURE_ADDRESS_MODE
    MipLODBias : Float32
    MaxAnisotropy : UInt32
    ComparisonFunc : D3D10_COMPARISON_FUNC
    BorderColor : Float32[4]
    MinLOD : Float32
    MaxLOD : Float32
}
struct ID3D10SamplerState extends ID3D10DeviceChild {
    static IID := "{9B7E4C0C-342C-4106-A19F-4F2704F689F0}"
    GetDesc(pDesc)
      => ComCall(7, this.p, D3D10_SAMPLER_DESC.Ptr, pDesc, "void")
}
struct D3D10_FORMAT_SUPPORT extends Int32 {
    static D3D10_FORMAT_SUPPORT_BUFFER := 1
    static D3D10_FORMAT_SUPPORT_IA_VERTEX_BUFFER := 2
    static D3D10_FORMAT_SUPPORT_IA_INDEX_BUFFER := 4
    static D3D10_FORMAT_SUPPORT_SO_BUFFER := 8
    static D3D10_FORMAT_SUPPORT_TEXTURE1D := 16
    static D3D10_FORMAT_SUPPORT_TEXTURE2D := 32
    static D3D10_FORMAT_SUPPORT_TEXTURE3D := 64
    static D3D10_FORMAT_SUPPORT_TEXTURECUBE := 128
    static D3D10_FORMAT_SUPPORT_SHADER_LOAD := 256
    static D3D10_FORMAT_SUPPORT_SHADER_SAMPLE := 512
    static D3D10_FORMAT_SUPPORT_SHADER_SAMPLE_COMPARISON := 1024
    static D3D10_FORMAT_SUPPORT_SHADER_SAMPLE_MONO_TEXT := 2048
    static D3D10_FORMAT_SUPPORT_MIP := 4096
    static D3D10_FORMAT_SUPPORT_MIP_AUTOGEN := 8192
    static D3D10_FORMAT_SUPPORT_RENDER_TARGET := 16384
    static D3D10_FORMAT_SUPPORT_BLENDABLE := 32768
    static D3D10_FORMAT_SUPPORT_DEPTH_STENCIL := 65536
    static D3D10_FORMAT_SUPPORT_CPU_LOCKABLE := 131072
    static D3D10_FORMAT_SUPPORT_MULTISAMPLE_RESOLVE := 262144
    static D3D10_FORMAT_SUPPORT_DISPLAY := 524288
    static D3D10_FORMAT_SUPPORT_CAST_WITHIN_BIT_LAYOUT := 1048576
    static D3D10_FORMAT_SUPPORT_MULTISAMPLE_RENDERTARGET := 2097152
    static D3D10_FORMAT_SUPPORT_MULTISAMPLE_LOAD := 4194304
    static D3D10_FORMAT_SUPPORT_SHADER_GATHER := 8388608
    static D3D10_FORMAT_SUPPORT_BACK_BUFFER_CAST := 16777216
}
struct ID3D10Asynchronous extends ID3D10DeviceChild {
    static IID := "{9B7E4C0D-342C-4106-A19F-4F2704F689F0}"
    Begin()
      => ComCall(7, this.p, "void")
    End()
      => ComCall(8, this.p, "void")
    GetData(pData?, GetDataFlags)
      => ComCall(9, this.p, Struct.Ptr, pData?, UInt32, pData?.Size ?? 0, UInt32, GetDataFlags)
    GetDataSize()
      => ComCall(10, this.p, UInt32)
}
struct D3D10_ASYNC_GETDATA_FLAG extends Int32 {
    static D3D10_ASYNC_GETDATA_DONOTFLUSH := 1
}
struct D3D10_QUERY extends Int32 {
    static D3D10_QUERY_EVENT := 0
    static D3D10_QUERY_OCCLUSION := 1
    static D3D10_QUERY_TIMESTAMP := 2
    static D3D10_QUERY_TIMESTAMP_DISJOINT := 3
    static D3D10_QUERY_PIPELINE_STATISTICS := 4
    static D3D10_QUERY_OCCLUSION_PREDICATE := 5
    static D3D10_QUERY_SO_STATISTICS := 6
    static D3D10_QUERY_SO_OVERFLOW_PREDICATE := 7
}
struct D3D10_QUERY_MISC_FLAG extends Int32 {
    static D3D10_QUERY_MISC_PREDICATEHINT := 1
}
struct D3D10_QUERY_DESC {
    Query : D3D10_QUERY
    MiscFlags : UInt32
}
struct ID3D10Query extends ID3D10Asynchronous {
    static IID := "{9B7E4C0E-342C-4106-A19F-4F2704F689F0}"
    GetDesc(pDesc)
      => ComCall(11, this.p, D3D10_QUERY_DESC.Ptr, pDesc, "void")
}
struct ID3D10Predicate extends ID3D10Query {
    static IID := "{9B7E4C10-342C-4106-A19F-4F2704F689F0}"
}
struct D3D10_QUERY_DATA_TIMESTAMP_DISJOINT {
    Frequency : Int64
    Disjoint : BOOL
}
struct D3D10_QUERY_DATA_PIPELINE_STATISTICS {
    IAVertices : Int64
    IAPrimitives : Int64
    VSInvocations : Int64
    GSInvocations : Int64
    GSPrimitives : Int64
    CInvocations : Int64
    CPrimitives : Int64
    PSInvocations : Int64
}
struct D3D10_QUERY_DATA_SO_STATISTICS {
    NumPrimitivesWritten : Int64
    PrimitivesStorageNeeded : Int64
}
struct D3D10_COUNTER extends Int32 {
    static D3D10_COUNTER_GPU_IDLE := 0
    static D3D10_COUNTER_VERTEX_PROCESSING := 1
    static D3D10_COUNTER_GEOMETRY_PROCESSING := 2
    static D3D10_COUNTER_PIXEL_PROCESSING := 3
    static D3D10_COUNTER_OTHER_GPU_PROCESSING := 4
    static D3D10_COUNTER_HOST_ADAPTER_BANDWIDTH_UTILIZATION := 5
    static D3D10_COUNTER_LOCAL_VIDMEM_BANDWIDTH_UTILIZATION := 6
    static D3D10_COUNTER_VERTEX_THROUGHPUT_UTILIZATION := 7
    static D3D10_COUNTER_TRIANGLE_SETUP_THROUGHPUT_UTILIZATION := 8
    static D3D10_COUNTER_FILLRATE_THROUGHPUT_UTILIZATION := 9
    static D3D10_COUNTER_VS_MEMORY_LIMITED := 10
    static D3D10_COUNTER_VS_COMPUTATION_LIMITED := 11
    static D3D10_COUNTER_GS_MEMORY_LIMITED := 12
    static D3D10_COUNTER_GS_COMPUTATION_LIMITED := 13
    static D3D10_COUNTER_PS_MEMORY_LIMITED := 14
    static D3D10_COUNTER_PS_COMPUTATION_LIMITED := 15
    static D3D10_COUNTER_POST_TRANSFORM_CACHE_HIT_RATE := 16
    static D3D10_COUNTER_TEXTURE_CACHE_HIT_RATE := 17
    static D3D10_COUNTER_DEVICE_DEPENDENT_0 := 1073741824
}
struct D3D10_COUNTER_TYPE extends Int32 {
    static D3D10_COUNTER_TYPE_FLOAT32 := 0
    static D3D10_COUNTER_TYPE_UINT16 := 1
    static D3D10_COUNTER_TYPE_UINT32 := 2
    static D3D10_COUNTER_TYPE_UINT64 := 3
}
struct D3D10_COUNTER_DESC {
    Counter : D3D10_COUNTER
    MiscFlags : UInt32
}
struct D3D10_COUNTER_INFO {
    LastDeviceDependentCounter : D3D10_COUNTER
    NumSimultaneousCounters : UInt32
    NumDetectableParallelUnits : UInt8
}
struct ID3D10Counter extends ID3D10Asynchronous {
    static IID := "{9B7E4C11-342C-4106-A19F-4F2704F689F0}"
    GetDesc(pDesc)
      => ComCall(11, this.p, D3D10_COUNTER_DESC.Ptr, pDesc, "void")
}
struct ID3D10Device extends IUnknown {
    static IID := "{9B7E4C0F-342C-4106-A19F-4F2704F689F0}"
    VSSetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(3, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D10Buffer.Ptr, ppConstantBuffers?, "void")
    PSSetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(4, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D10ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    PSSetShader(pPixelShader?)
      => ComCall(5, this.p, ID3D10PixelShader, pPixelShader?, "void")
    PSSetSamplers(StartSlot, ppSamplers?)
      => ComCall(6, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D10SamplerState.Ptr, ppSamplers?, "void")
    VSSetShader(pVertexShader?)
      => ComCall(7, this.p, ID3D10VertexShader, pVertexShader?, "void")
    DrawIndexed(IndexCount, StartIndexLocation, BaseVertexLocation)
      => ComCall(8, this.p, UInt32, IndexCount, UInt32, StartIndexLocation, Int32, BaseVertexLocation, "void")
    Draw(VertexCount, StartVertexLocation)
      => ComCall(9, this.p, UInt32, VertexCount, UInt32, StartVertexLocation, "void")
    PSSetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(10, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D10Buffer.Ptr, ppConstantBuffers?, "void")
    IASetInputLayout(pInputLayout?)
      => ComCall(11, this.p, ID3D10InputLayout, pInputLayout?, "void")
    IASetVertexBuffers(StartSlot, ppVertexBuffers?, pStrides?, pOffsets?)
      => ComCall(12, this.p, UInt32, StartSlot, UInt32, pOffsets?.Length ?? 0, ID3D10Buffer.Ptr, ppVertexBuffers?, UInt32.Ptr, pStrides?, UInt32.Ptr, pOffsets?, "void")
    IASetIndexBuffer(pIndexBuffer?, Format, Offset)
      => ComCall(13, this.p, ID3D10Buffer, pIndexBuffer?, DXGI_FORMAT, Format, UInt32, Offset, "void")
    DrawIndexedInstanced(IndexCountPerInstance, InstanceCount, StartIndexLocation, BaseVertexLocation, StartInstanceLocation)
      => ComCall(14, this.p, UInt32, IndexCountPerInstance, UInt32, InstanceCount, UInt32, StartIndexLocation, Int32, BaseVertexLocation, UInt32, StartInstanceLocation, "void")
    DrawInstanced(VertexCountPerInstance, InstanceCount, StartVertexLocation, StartInstanceLocation)
      => ComCall(15, this.p, UInt32, VertexCountPerInstance, UInt32, InstanceCount, UInt32, StartVertexLocation, UInt32, StartInstanceLocation, "void")
    GSSetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(16, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D10Buffer.Ptr, ppConstantBuffers?, "void")
    GSSetShader(pShader?)
      => ComCall(17, this.p, ID3D10GeometryShader, pShader?, "void")
    IASetPrimitiveTopology(Topology)
      => ComCall(18, this.p, D3D_PRIMITIVE_TOPOLOGY, Topology, "void")
    VSSetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(19, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D10ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    VSSetSamplers(StartSlot, ppSamplers?)
      => ComCall(20, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D10SamplerState.Ptr, ppSamplers?, "void")
    SetPredication(pPredicate?, PredicateValue)
      => ComCall(21, this.p, ID3D10Predicate, pPredicate?, BOOL, PredicateValue, "void")
    GSSetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(22, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D10ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    GSSetSamplers(StartSlot, ppSamplers?)
      => ComCall(23, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D10SamplerState.Ptr, ppSamplers?, "void")
    OMSetRenderTargets(ppRenderTargetViews?, pDepthStencilView?)
      => ComCall(24, this.p, UInt32, ppRenderTargetViews?.Length ?? 0, ID3D10RenderTargetView.Ptr, ppRenderTargetViews?, ID3D10DepthStencilView, pDepthStencilView?, "void")
    OMSetBlendState(pBlendState?, BlendFactor, SampleMask)
      => ComCall(25, this.p, ID3D10BlendState, pBlendState?, Float32.Ptr, BlendFactor, UInt32, SampleMask, "void")
    OMSetDepthStencilState(pDepthStencilState?, StencilRef)
      => ComCall(26, this.p, ID3D10DepthStencilState, pDepthStencilState?, UInt32, StencilRef, "void")
    SOSetTargets(ppSOTargets?, pOffsets?)
      => ComCall(27, this.p, UInt32, pOffsets?.Length ?? 0, ID3D10Buffer.Ptr, ppSOTargets?, UInt32.Ptr, pOffsets?, "void")
    DrawAuto()
      => ComCall(28, this.p, "void")
    RSSetState(pRasterizerState?)
      => ComCall(29, this.p, ID3D10RasterizerState, pRasterizerState?, "void")
    RSSetViewports(pViewports?)
      => ComCall(30, this.p, UInt32, pViewports?.Length ?? 0, D3D10_VIEWPORT.Ptr, pViewports?, "void")
    RSSetScissorRects(pRects?)
      => ComCall(31, this.p, UInt32, pRects?.Length ?? 0, RECT.Ptr, pRects?, "void")
    CopySubresourceRegion(pDstResource, DstSubresource, DstX, DstY, DstZ, pSrcResource, SrcSubresource, pSrcBox?)
      => ComCall(32, this.p, ID3D10Resource, pDstResource, UInt32, DstSubresource, UInt32, DstX, UInt32, DstY, UInt32, DstZ, ID3D10Resource, pSrcResource, UInt32, SrcSubresource, D3D10_BOX.Ptr, pSrcBox?, "void")
    CopyResource(pDstResource, pSrcResource)
      => ComCall(33, this.p, ID3D10Resource, pDstResource, ID3D10Resource, pSrcResource, "void")
    UpdateSubresource(pDstResource, DstSubresource, pDstBox?, pSrcData, SrcRowPitch, SrcDepthPitch)
      => ComCall(34, this.p, ID3D10Resource, pDstResource, UInt32, DstSubresource, D3D10_BOX.Ptr, pDstBox?, Struct.Ptr, pSrcData, UInt32, SrcRowPitch, UInt32, SrcDepthPitch, "void")
    ClearRenderTargetView(pRenderTargetView, ColorRGBA)
      => ComCall(35, this.p, ID3D10RenderTargetView, pRenderTargetView, Float32.Ptr, ColorRGBA, "void")
    ClearDepthStencilView(pDepthStencilView, ClearFlags, Depth, Stencil)
      => ComCall(36, this.p, ID3D10DepthStencilView, pDepthStencilView, UInt32, ClearFlags, Float32, Depth, UInt8, Stencil, "void")
    GenerateMips(pShaderResourceView)
      => ComCall(37, this.p, ID3D10ShaderResourceView, pShaderResourceView, "void")
    ResolveSubresource(pDstResource, DstSubresource, pSrcResource, SrcSubresource, Format)
      => ComCall(38, this.p, ID3D10Resource, pDstResource, UInt32, DstSubresource, ID3D10Resource, pSrcResource, UInt32, SrcSubresource, DXGI_FORMAT, Format, "void")
    VSGetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(39, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D10Buffer.Ptr, ppConstantBuffers?, "void")
    PSGetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(40, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D10ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    PSGetShader(ppPixelShader)
      => ComCall(41, this.p, ID3D10PixelShader.Ptr, ppPixelShader, "void")
    PSGetSamplers(StartSlot, ppSamplers?)
      => ComCall(42, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D10SamplerState.Ptr, ppSamplers?, "void")
    VSGetShader(ppVertexShader)
      => ComCall(43, this.p, ID3D10VertexShader.Ptr, ppVertexShader, "void")
    PSGetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(44, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D10Buffer.Ptr, ppConstantBuffers?, "void")
    IAGetInputLayout(ppInputLayout)
      => ComCall(45, this.p, ID3D10InputLayout.Ptr, ppInputLayout, "void")
    IAGetVertexBuffers(StartSlot, ppVertexBuffers?, pStrides?, pOffsets?)
      => ComCall(46, this.p, UInt32, StartSlot, UInt32, pOffsets?.Length ?? 0, ID3D10Buffer.Ptr, ppVertexBuffers?, UInt32.Ptr, pStrides?, UInt32.Ptr, pOffsets?, "void")
    IAGetIndexBuffer(pIndexBuffer?, Format?, Offset?)
      => ComCall(47, this.p, ID3D10Buffer.Ptr, pIndexBuffer?, DXGI_FORMAT.Ptr, Format?, UInt32.Ptr, Offset?, "void")
    GSGetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(48, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D10Buffer.Ptr, ppConstantBuffers?, "void")
    GSGetShader(ppGeometryShader)
      => ComCall(49, this.p, ID3D10GeometryShader.Ptr, ppGeometryShader, "void")
    IAGetPrimitiveTopology(pTopology)
      => ComCall(50, this.p, D3D_PRIMITIVE_TOPOLOGY.Ptr, pTopology, "void")
    VSGetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(51, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D10ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    VSGetSamplers(StartSlot, ppSamplers?)
      => ComCall(52, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D10SamplerState.Ptr, ppSamplers?, "void")
    GetPredication(ppPredicate?, pPredicateValue?)
      => ComCall(53, this.p, ID3D10Predicate.Ptr, ppPredicate?, BOOL.Ptr, pPredicateValue?, "void")
    GSGetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(54, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D10ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    GSGetSamplers(StartSlot, ppSamplers?)
      => ComCall(55, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D10SamplerState.Ptr, ppSamplers?, "void")
    OMGetRenderTargets(ppRenderTargetViews?, ppDepthStencilView?)
      => ComCall(56, this.p, UInt32, ppRenderTargetViews?.Length ?? 0, ID3D10RenderTargetView.Ptr, ppRenderTargetViews?, ID3D10DepthStencilView.Ptr, ppDepthStencilView?, "void")
    OMGetBlendState(ppBlendState?, BlendFactor?, pSampleMask?)
      => ComCall(57, this.p, ID3D10BlendState.Ptr, ppBlendState?, Float32.Ptr, BlendFactor?, UInt32.Ptr, pSampleMask?, "void")
    OMGetDepthStencilState(ppDepthStencilState?, pStencilRef?)
      => ComCall(58, this.p, ID3D10DepthStencilState.Ptr, ppDepthStencilState?, UInt32.Ptr, pStencilRef?, "void")
    SOGetTargets(ppSOTargets?, pOffsets?)
      => ComCall(59, this.p, UInt32, pOffsets?.Length ?? 0, ID3D10Buffer.Ptr, ppSOTargets?, UInt32.Ptr, pOffsets?, "void")
    RSGetState(ppRasterizerState)
      => ComCall(60, this.p, ID3D10RasterizerState.Ptr, ppRasterizerState, "void")
    RSGetViewports(pViewports?)
      => ComCall(61, this.p, UInt32.Ptr, pViewports?.Length ?? 0, D3D10_VIEWPORT.Ptr, pViewports?, "void")
    RSGetScissorRects(pRects?)
      => ComCall(62, this.p, UInt32.Ptr, pRects?.Length ?? 0, RECT.Ptr, pRects?, "void")
    GetDeviceRemovedReason()
      => ComCall(63, this.p)
    SetExceptionMode(RaiseFlags)
      => ComCall(64, this.p, UInt32, RaiseFlags)
    GetExceptionMode()
      => ComCall(65, this.p, UInt32)
    GetPrivateData(guid, pDataSize, pData?)
      => ComCall(66, this.p, GUID.Ptr, guid, UInt32.Ptr, pDataSize, Struct.Ptr, pData?)
    SetPrivateData(guid, pData?)
      => ComCall(67, this.p, GUID.Ptr, guid, UInt32, pData?.Size ?? 0, Struct.Ptr, pData?)
    SetPrivateDataInterface(guid, pData?)
      => ComCall(68, this.p, GUID.Ptr, guid, IUnknown, pData?)
    ClearState()
      => ComCall(69, this.p, "void")
    Flush()
      => ComCall(70, this.p, "void")
    CreateBuffer(pDesc, pInitialData?, ppBuffer?)
      => ComCall(71, this.p, D3D10_BUFFER_DESC.Ptr, pDesc, D3D10_SUBRESOURCE_DATA.Ptr, pInitialData?, ID3D10Buffer.Ptr, ppBuffer?)
    CreateTexture1D(pDesc, pInitialData?, ppTexture1D)
      => ComCall(72, this.p, D3D10_TEXTURE1D_DESC.Ptr, pDesc, D3D10_SUBRESOURCE_DATA.Ptr, pInitialData?, ID3D10Texture1D.Ptr, ppTexture1D)
    CreateTexture2D(pDesc, pInitialData?, ppTexture2D)
      => ComCall(73, this.p, D3D10_TEXTURE2D_DESC.Ptr, pDesc, D3D10_SUBRESOURCE_DATA.Ptr, pInitialData?, ID3D10Texture2D.Ptr, ppTexture2D)
    CreateTexture3D(pDesc, pInitialData?, ppTexture3D)
      => ComCall(74, this.p, D3D10_TEXTURE3D_DESC.Ptr, pDesc, D3D10_SUBRESOURCE_DATA.Ptr, pInitialData?, ID3D10Texture3D.Ptr, ppTexture3D)
    CreateShaderResourceView(pResource, pDesc?, ppSRView?)
      => ComCall(75, this.p, ID3D10Resource, pResource, D3D10_SHADER_RESOURCE_VIEW_DESC.Ptr, pDesc?, ID3D10ShaderResourceView.Ptr, ppSRView?)
    CreateRenderTargetView(pResource, pDesc?, ppRTView?)
      => ComCall(76, this.p, ID3D10Resource, pResource, D3D10_RENDER_TARGET_VIEW_DESC.Ptr, pDesc?, ID3D10RenderTargetView.Ptr, ppRTView?)
    CreateDepthStencilView(pResource, pDesc?, ppDepthStencilView?)
      => ComCall(77, this.p, ID3D10Resource, pResource, D3D10_DEPTH_STENCIL_VIEW_DESC.Ptr, pDesc?, ID3D10DepthStencilView.Ptr, ppDepthStencilView?)
    CreateInputLayout(pInputElementDescs, pShaderBytecodeWithInputSignature, ppInputLayout?)
      => ComCall(78, this.p, D3D10_INPUT_ELEMENT_DESC.Ptr, pInputElementDescs, UInt32, pInputElementDescs.Length, Struct.Ptr, pShaderBytecodeWithInputSignature, IntPtr, pShaderBytecodeWithInputSignature.Length, ID3D10InputLayout.Ptr, ppInputLayout?)
    CreateVertexShader(pShaderBytecode, ppVertexShader?)
      => ComCall(79, this.p, Struct.Ptr, pShaderBytecode, IntPtr, pShaderBytecode.Length, ID3D10VertexShader.Ptr, ppVertexShader?)
    CreateGeometryShader(pShaderBytecode, ppGeometryShader?)
      => ComCall(80, this.p, Struct.Ptr, pShaderBytecode, IntPtr, pShaderBytecode.Length, ID3D10GeometryShader.Ptr, ppGeometryShader?)
    CreateGeometryShaderWithStreamOutput(pShaderBytecode, pSODeclaration?, OutputStreamStride, ppGeometryShader?)
      => ComCall(81, this.p, Struct.Ptr, pShaderBytecode, IntPtr, pShaderBytecode.Length, D3D10_SO_DECLARATION_ENTRY.Ptr, pSODeclaration?, UInt32, pSODeclaration?.Length ?? 0, UInt32, OutputStreamStride, ID3D10GeometryShader.Ptr, ppGeometryShader?)
    CreatePixelShader(pShaderBytecode, ppPixelShader?)
      => ComCall(82, this.p, Struct.Ptr, pShaderBytecode, IntPtr, pShaderBytecode.Length, ID3D10PixelShader.Ptr, ppPixelShader?)
    CreateBlendState(pBlendStateDesc, ppBlendState?)
      => ComCall(83, this.p, D3D10_BLEND_DESC.Ptr, pBlendStateDesc, ID3D10BlendState.Ptr, ppBlendState?)
    CreateDepthStencilState(pDepthStencilDesc, ppDepthStencilState?)
      => ComCall(84, this.p, D3D10_DEPTH_STENCIL_DESC.Ptr, pDepthStencilDesc, ID3D10DepthStencilState.Ptr, ppDepthStencilState?)
    CreateRasterizerState(pRasterizerDesc, ppRasterizerState?)
      => ComCall(85, this.p, D3D10_RASTERIZER_DESC.Ptr, pRasterizerDesc, ID3D10RasterizerState.Ptr, ppRasterizerState?)
    CreateSamplerState(pSamplerDesc, ppSamplerState?)
      => ComCall(86, this.p, D3D10_SAMPLER_DESC.Ptr, pSamplerDesc, ID3D10SamplerState.Ptr, ppSamplerState?)
    CreateQuery(pQueryDesc, ppQuery?)
      => ComCall(87, this.p, D3D10_QUERY_DESC.Ptr, pQueryDesc, ID3D10Query.Ptr, ppQuery?)
    CreatePredicate(pPredicateDesc, ppPredicate?)
      => ComCall(88, this.p, D3D10_QUERY_DESC.Ptr, pPredicateDesc, ID3D10Predicate.Ptr, ppPredicate?)
    CreateCounter(pCounterDesc, ppCounter?)
      => ComCall(89, this.p, D3D10_COUNTER_DESC.Ptr, pCounterDesc, ID3D10Counter.Ptr, ppCounter?)
    CheckFormatSupport(Format, pFormatSupport)
      => ComCall(90, this.p, DXGI_FORMAT, Format, UInt32.Ptr, pFormatSupport)
    CheckMultisampleQualityLevels(Format, SampleCount, pNumQualityLevels)
      => ComCall(91, this.p, DXGI_FORMAT, Format, UInt32, SampleCount, UInt32.Ptr, pNumQualityLevels)
    CheckCounterInfo(pCounterInfo)
      => ComCall(92, this.p, D3D10_COUNTER_INFO.Ptr, pCounterInfo, "void")
    CheckCounter(pDesc, pType, pActiveCounters, szName?, szUnits?, szDescription?)
      => ComCall(93, this.p, D3D10_COUNTER_DESC.Ptr, pDesc, D3D10_COUNTER_TYPE.Ptr, pType, UInt32.Ptr, pActiveCounters, PSTR, szName?, UInt32.Ptr, szName?.Length ?? 0, PSTR, szUnits?, UInt32.Ptr, szUnits?.Length ?? 0, PSTR, szDescription?, UInt32.Ptr, szDescription?.Length ?? 0)
    GetCreationFlags()
      => ComCall(94, this.p, UInt32)
    OpenSharedResource(hResource, ReturnedInterface, ppResource?)
      => ComCall(95, this.p, HANDLE, hResource, GUID.Ptr, ReturnedInterface, Struct.Ptr.Ptr, ppResource?)
    SetTextFilterSize(Width, Height)
      => ComCall(96, this.p, UInt32, Width, UInt32, Height, "void")
    GetTextFilterSize(pWidth?, pHeight?)
      => ComCall(97, this.p, UInt32.Ptr, pWidth?, UInt32.Ptr, pHeight?, "void")
}
struct ID3D10Multithread extends IUnknown {
    static IID := "{9B7E4E00-342C-4106-A19F-4F2704F689F0}"
    Enter()
      => ComCall(3, this.p, "void")
    Leave()
      => ComCall(4, this.p, "void")
    SetMultithreadProtected(bMTProtect)
      => ComCall(5, this.p, BOOL, bMTProtect, BOOL)
    GetMultithreadProtected()
      => ComCall(6, this.p, BOOL)
}
struct D3D10_CREATE_DEVICE_FLAG extends Int32 {
    static D3D10_CREATE_DEVICE_SINGLETHREADED := 1
    static D3D10_CREATE_DEVICE_DEBUG := 2
    static D3D10_CREATE_DEVICE_SWITCH_TO_REF := 4
    static D3D10_CREATE_DEVICE_PREVENT_INTERNAL_THREADING_OPTIMIZATIONS := 8
    static D3D10_CREATE_DEVICE_ALLOW_NULL_FROM_MAP := 16
    static D3D10_CREATE_DEVICE_BGRA_SUPPORT := 32
    static D3D10_CREATE_DEVICE_PREVENT_ALTERING_LAYER_SETTINGS_FROM_REGISTRY := 128
    static D3D10_CREATE_DEVICE_STRICT_VALIDATION := 512
    static D3D10_CREATE_DEVICE_DEBUGGABLE := 1024
}
struct ID3D10Debug extends IUnknown {
    static IID := "{9B7E4E01-342C-4106-A19F-4F2704F689F0}"
    SetFeatureMask(Mask)
      => ComCall(3, this.p, UInt32, Mask)
    GetFeatureMask()
      => ComCall(4, this.p, UInt32)
    SetPresentPerRenderOpDelay(Milliseconds)
      => ComCall(5, this.p, UInt32, Milliseconds)
    GetPresentPerRenderOpDelay()
      => ComCall(6, this.p, UInt32)
    SetSwapChain(pSwapChain?)
      => ComCall(7, this.p, IDXGISwapChain, pSwapChain?)
    GetSwapChain(ppSwapChain)
      => ComCall(8, this.p, IDXGISwapChain.Ptr, ppSwapChain)
    Validate()
      => ComCall(9, this.p)
}
struct ID3D10SwitchToRef extends IUnknown {
    static IID := "{9B7E4E02-342C-4106-A19F-4F2704F689F0}"
    SetUseRef(UseRef)
      => ComCall(3, this.p, BOOL, UseRef, BOOL)
    GetUseRef()
      => ComCall(4, this.p, BOOL)
}
struct D3D10_MESSAGE_CATEGORY extends Int32 {
    static D3D10_MESSAGE_CATEGORY_APPLICATION_DEFINED := 0
    static D3D10_MESSAGE_CATEGORY_MISCELLANEOUS := 1
    static D3D10_MESSAGE_CATEGORY_INITIALIZATION := 2
    static D3D10_MESSAGE_CATEGORY_CLEANUP := 3
    static D3D10_MESSAGE_CATEGORY_COMPILATION := 4
    static D3D10_MESSAGE_CATEGORY_STATE_CREATION := 5
    static D3D10_MESSAGE_CATEGORY_STATE_SETTING := 6
    static D3D10_MESSAGE_CATEGORY_STATE_GETTING := 7
    static D3D10_MESSAGE_CATEGORY_RESOURCE_MANIPULATION := 8
    static D3D10_MESSAGE_CATEGORY_EXECUTION := 9
    static D3D10_MESSAGE_CATEGORY_SHADER := 10
}
struct D3D10_MESSAGE_SEVERITY extends Int32 {
    static D3D10_MESSAGE_SEVERITY_CORRUPTION := 0
    static D3D10_MESSAGE_SEVERITY_ERROR := 1
    static D3D10_MESSAGE_SEVERITY_WARNING := 2
    static D3D10_MESSAGE_SEVERITY_INFO := 3
    static D3D10_MESSAGE_SEVERITY_MESSAGE := 4
}
struct D3D10_MESSAGE_ID extends Int32 {
    static D3D10_MESSAGE_ID_UNKNOWN := 0
    static D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_HAZARD := 1
    static D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_HAZARD := 2
    static D3D10_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_HAZARD := 3
    static D3D10_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_HAZARD := 4
    static D3D10_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_HAZARD := 5
    static D3D10_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_HAZARD := 6
    static D3D10_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_HAZARD := 7
    static D3D10_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_HAZARD := 8
    static D3D10_MESSAGE_ID_DEVICE_OMSETRENDERTARGETS_HAZARD := 9
    static D3D10_MESSAGE_ID_DEVICE_SOSETTARGETS_HAZARD := 10
    static D3D10_MESSAGE_ID_STRING_FROM_APPLICATION := 11
    static D3D10_MESSAGE_ID_CORRUPTED_THIS := 12
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER1 := 13
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER2 := 14
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER3 := 15
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER4 := 16
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER5 := 17
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER6 := 18
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER7 := 19
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER8 := 20
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER9 := 21
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER10 := 22
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER11 := 23
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER12 := 24
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER13 := 25
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER14 := 26
    static D3D10_MESSAGE_ID_CORRUPTED_PARAMETER15 := 27
    static D3D10_MESSAGE_ID_CORRUPTED_MULTITHREADING := 28
    static D3D10_MESSAGE_ID_MESSAGE_REPORTING_OUTOFMEMORY := 29
    static D3D10_MESSAGE_ID_IASETINPUTLAYOUT_UNBINDDELETINGOBJECT := 30
    static D3D10_MESSAGE_ID_IASETVERTEXBUFFERS_UNBINDDELETINGOBJECT := 31
    static D3D10_MESSAGE_ID_IASETINDEXBUFFER_UNBINDDELETINGOBJECT := 32
    static D3D10_MESSAGE_ID_VSSETSHADER_UNBINDDELETINGOBJECT := 33
    static D3D10_MESSAGE_ID_VSSETSHADERRESOURCES_UNBINDDELETINGOBJECT := 34
    static D3D10_MESSAGE_ID_VSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT := 35
    static D3D10_MESSAGE_ID_VSSETSAMPLERS_UNBINDDELETINGOBJECT := 36
    static D3D10_MESSAGE_ID_GSSETSHADER_UNBINDDELETINGOBJECT := 37
    static D3D10_MESSAGE_ID_GSSETSHADERRESOURCES_UNBINDDELETINGOBJECT := 38
    static D3D10_MESSAGE_ID_GSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT := 39
    static D3D10_MESSAGE_ID_GSSETSAMPLERS_UNBINDDELETINGOBJECT := 40
    static D3D10_MESSAGE_ID_SOSETTARGETS_UNBINDDELETINGOBJECT := 41
    static D3D10_MESSAGE_ID_PSSETSHADER_UNBINDDELETINGOBJECT := 42
    static D3D10_MESSAGE_ID_PSSETSHADERRESOURCES_UNBINDDELETINGOBJECT := 43
    static D3D10_MESSAGE_ID_PSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT := 44
    static D3D10_MESSAGE_ID_PSSETSAMPLERS_UNBINDDELETINGOBJECT := 45
    static D3D10_MESSAGE_ID_RSSETSTATE_UNBINDDELETINGOBJECT := 46
    static D3D10_MESSAGE_ID_OMSETBLENDSTATE_UNBINDDELETINGOBJECT := 47
    static D3D10_MESSAGE_ID_OMSETDEPTHSTENCILSTATE_UNBINDDELETINGOBJECT := 48
    static D3D10_MESSAGE_ID_OMSETRENDERTARGETS_UNBINDDELETINGOBJECT := 49
    static D3D10_MESSAGE_ID_SETPREDICATION_UNBINDDELETINGOBJECT := 50
    static D3D10_MESSAGE_ID_GETPRIVATEDATA_MOREDATA := 51
    static D3D10_MESSAGE_ID_SETPRIVATEDATA_INVALIDFREEDATA := 52
    static D3D10_MESSAGE_ID_SETPRIVATEDATA_INVALIDIUNKNOWN := 53
    static D3D10_MESSAGE_ID_SETPRIVATEDATA_INVALIDFLAGS := 54
    static D3D10_MESSAGE_ID_SETPRIVATEDATA_CHANGINGPARAMS := 55
    static D3D10_MESSAGE_ID_SETPRIVATEDATA_OUTOFMEMORY := 56
    static D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDFORMAT := 57
    static D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDSAMPLES := 58
    static D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDUSAGE := 59
    static D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDBINDFLAGS := 60
    static D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDCPUACCESSFLAGS := 61
    static D3D10_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDMISCFLAGS := 62
    static D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDCPUACCESSFLAGS := 63
    static D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDBINDFLAGS := 64
    static D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDINITIALDATA := 65
    static D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDDIMENSIONS := 66
    static D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDMIPLEVELS := 67
    static D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDMISCFLAGS := 68
    static D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDARG_RETURN := 69
    static D3D10_MESSAGE_ID_CREATEBUFFER_OUTOFMEMORY_RETURN := 70
    static D3D10_MESSAGE_ID_CREATEBUFFER_NULLDESC := 71
    static D3D10_MESSAGE_ID_CREATEBUFFER_INVALIDCONSTANTBUFFERBINDINGS := 72
    static D3D10_MESSAGE_ID_CREATEBUFFER_LARGEALLOCATION := 73
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDFORMAT := 74
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_UNSUPPORTEDFORMAT := 75
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDSAMPLES := 76
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDUSAGE := 77
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDBINDFLAGS := 78
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDCPUACCESSFLAGS := 79
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDMISCFLAGS := 80
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDCPUACCESSFLAGS := 81
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDBINDFLAGS := 82
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDINITIALDATA := 83
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDDIMENSIONS := 84
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDMIPLEVELS := 85
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDMISCFLAGS := 86
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_INVALIDARG_RETURN := 87
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_OUTOFMEMORY_RETURN := 88
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_NULLDESC := 89
    static D3D10_MESSAGE_ID_CREATETEXTURE1D_LARGEALLOCATION := 90
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDFORMAT := 91
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_UNSUPPORTEDFORMAT := 92
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDSAMPLES := 93
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDUSAGE := 94
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDBINDFLAGS := 95
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDCPUACCESSFLAGS := 96
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDMISCFLAGS := 97
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDCPUACCESSFLAGS := 98
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDBINDFLAGS := 99
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDINITIALDATA := 100
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDDIMENSIONS := 101
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDMIPLEVELS := 102
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDMISCFLAGS := 103
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_INVALIDARG_RETURN := 104
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_OUTOFMEMORY_RETURN := 105
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_NULLDESC := 106
    static D3D10_MESSAGE_ID_CREATETEXTURE2D_LARGEALLOCATION := 107
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDFORMAT := 108
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_UNSUPPORTEDFORMAT := 109
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDSAMPLES := 110
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDUSAGE := 111
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDBINDFLAGS := 112
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDCPUACCESSFLAGS := 113
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDMISCFLAGS := 114
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDCPUACCESSFLAGS := 115
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDBINDFLAGS := 116
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDINITIALDATA := 117
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDDIMENSIONS := 118
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDMIPLEVELS := 119
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDMISCFLAGS := 120
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_INVALIDARG_RETURN := 121
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_OUTOFMEMORY_RETURN := 122
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_NULLDESC := 123
    static D3D10_MESSAGE_ID_CREATETEXTURE3D_LARGEALLOCATION := 124
    static D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_UNRECOGNIZEDFORMAT := 125
    static D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDESC := 126
    static D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFORMAT := 127
    static D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDIMENSIONS := 128
    static D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDRESOURCE := 129
    static D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_TOOMANYOBJECTS := 130
    static D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDARG_RETURN := 131
    static D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_OUTOFMEMORY_RETURN := 132
    static D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_UNRECOGNIZEDFORMAT := 133
    static D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_UNSUPPORTEDFORMAT := 134
    static D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDESC := 135
    static D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDFORMAT := 136
    static D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDIMENSIONS := 137
    static D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDRESOURCE := 138
    static D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_TOOMANYOBJECTS := 139
    static D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDARG_RETURN := 140
    static D3D10_MESSAGE_ID_CREATERENDERTARGETVIEW_OUTOFMEMORY_RETURN := 141
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_UNRECOGNIZEDFORMAT := 142
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDESC := 143
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFORMAT := 144
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDIMENSIONS := 145
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDRESOURCE := 146
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_TOOMANYOBJECTS := 147
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDARG_RETURN := 148
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_OUTOFMEMORY_RETURN := 149
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_OUTOFMEMORY := 150
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_TOOMANYELEMENTS := 151
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDFORMAT := 152
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INCOMPATIBLEFORMAT := 153
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOT := 154
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDINPUTSLOTCLASS := 155
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_STEPRATESLOTCLASSMISMATCH := 156
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOTCLASSCHANGE := 157
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSTEPRATECHANGE := 158
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDALIGNMENT := 159
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_DUPLICATESEMANTIC := 160
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_UNPARSEABLEINPUTSIGNATURE := 161
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_NULLSEMANTIC := 162
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_MISSINGELEMENT := 163
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_NULLDESC := 164
    static D3D10_MESSAGE_ID_CREATEVERTEXSHADER_OUTOFMEMORY := 165
    static D3D10_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERBYTECODE := 166
    static D3D10_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERTYPE := 167
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADER_OUTOFMEMORY := 168
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERBYTECODE := 169
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERTYPE := 170
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTOFMEMORY := 171
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERBYTECODE := 172
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE := 173
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMENTRIES := 174
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSTREAMSTRIDEUNUSED := 175
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDDECL := 176
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_EXPECTEDDECL := 177
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSLOT0EXPECTED := 178
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSLOT := 179
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_ONLYONEELEMENTPERSLOT := 180
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCOMPONENTCOUNT := 181
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTARTCOMPONENTANDCOMPONENTCOUNT := 182
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDGAPDEFINITION := 183
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_REPEATEDOUTPUT := 184
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSTREAMSTRIDE := 185
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGSEMANTIC := 186
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MASKMISMATCH := 187
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_CANTHAVEONLYGAPS := 188
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DECLTOOCOMPLEX := 189
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGOUTPUTSIGNATURE := 190
    static D3D10_MESSAGE_ID_CREATEPIXELSHADER_OUTOFMEMORY := 191
    static D3D10_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERBYTECODE := 192
    static D3D10_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERTYPE := 193
    static D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFILLMODE := 194
    static D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDCULLMODE := 195
    static D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDDEPTHBIASCLAMP := 196
    static D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDSLOPESCALEDDEPTHBIAS := 197
    static D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_TOOMANYOBJECTS := 198
    static D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_NULLDESC := 199
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHWRITEMASK := 200
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHFUNC := 201
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFAILOP := 202
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILZFAILOP := 203
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILPASSOP := 204
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFUNC := 205
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFAILOP := 206
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILZFAILOP := 207
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILPASSOP := 208
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFUNC := 209
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_TOOMANYOBJECTS := 210
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_NULLDESC := 211
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLEND := 212
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLEND := 213
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOP := 214
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLENDALPHA := 215
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLENDALPHA := 216
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOPALPHA := 217
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_INVALIDRENDERTARGETWRITEMASK := 218
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_TOOMANYOBJECTS := 219
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_NULLDESC := 220
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDFILTER := 221
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSU := 222
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSV := 223
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSW := 224
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMIPLODBIAS := 225
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXANISOTROPY := 226
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDCOMPARISONFUNC := 227
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMINLOD := 228
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXLOD := 229
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_TOOMANYOBJECTS := 230
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_NULLDESC := 231
    static D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDQUERY := 232
    static D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDMISCFLAGS := 233
    static D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_UNEXPECTEDMISCFLAG := 234
    static D3D10_MESSAGE_ID_CREATEQUERYORPREDICATE_NULLDESC := 235
    static D3D10_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNRECOGNIZED := 236
    static D3D10_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNDEFINED := 237
    static D3D10_MESSAGE_ID_IASETVERTEXBUFFERS_INVALIDBUFFER := 238
    static D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_OFFSET_TOO_LARGE := 239
    static D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_BUFFERS_EMPTY := 240
    static D3D10_MESSAGE_ID_IASETINDEXBUFFER_INVALIDBUFFER := 241
    static D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_FORMAT_INVALID := 242
    static D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_TOO_LARGE := 243
    static D3D10_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_UNALIGNED := 244
    static D3D10_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_VIEWS_EMPTY := 245
    static D3D10_MESSAGE_ID_VSSETCONSTANTBUFFERS_INVALIDBUFFER := 246
    static D3D10_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_BUFFERS_EMPTY := 247
    static D3D10_MESSAGE_ID_DEVICE_VSSETSAMPLERS_SAMPLERS_EMPTY := 248
    static D3D10_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_VIEWS_EMPTY := 249
    static D3D10_MESSAGE_ID_GSSETCONSTANTBUFFERS_INVALIDBUFFER := 250
    static D3D10_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_BUFFERS_EMPTY := 251
    static D3D10_MESSAGE_ID_DEVICE_GSSETSAMPLERS_SAMPLERS_EMPTY := 252
    static D3D10_MESSAGE_ID_SOSETTARGETS_INVALIDBUFFER := 253
    static D3D10_MESSAGE_ID_DEVICE_SOSETTARGETS_OFFSET_UNALIGNED := 254
    static D3D10_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_VIEWS_EMPTY := 255
    static D3D10_MESSAGE_ID_PSSETCONSTANTBUFFERS_INVALIDBUFFER := 256
    static D3D10_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_BUFFERS_EMPTY := 257
    static D3D10_MESSAGE_ID_DEVICE_PSSETSAMPLERS_SAMPLERS_EMPTY := 258
    static D3D10_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_INVALIDVIEWPORT := 259
    static D3D10_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_INVALIDSCISSOR := 260
    static D3D10_MESSAGE_ID_CLEARRENDERTARGETVIEW_DENORMFLUSH := 261
    static D3D10_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_DENORMFLUSH := 262
    static D3D10_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_INVALID := 263
    static D3D10_MESSAGE_ID_DEVICE_IAGETVERTEXBUFFERS_BUFFERS_EMPTY := 264
    static D3D10_MESSAGE_ID_DEVICE_VSGETSHADERRESOURCES_VIEWS_EMPTY := 265
    static D3D10_MESSAGE_ID_DEVICE_VSGETCONSTANTBUFFERS_BUFFERS_EMPTY := 266
    static D3D10_MESSAGE_ID_DEVICE_VSGETSAMPLERS_SAMPLERS_EMPTY := 267
    static D3D10_MESSAGE_ID_DEVICE_GSGETSHADERRESOURCES_VIEWS_EMPTY := 268
    static D3D10_MESSAGE_ID_DEVICE_GSGETCONSTANTBUFFERS_BUFFERS_EMPTY := 269
    static D3D10_MESSAGE_ID_DEVICE_GSGETSAMPLERS_SAMPLERS_EMPTY := 270
    static D3D10_MESSAGE_ID_DEVICE_SOGETTARGETS_BUFFERS_EMPTY := 271
    static D3D10_MESSAGE_ID_DEVICE_PSGETSHADERRESOURCES_VIEWS_EMPTY := 272
    static D3D10_MESSAGE_ID_DEVICE_PSGETCONSTANTBUFFERS_BUFFERS_EMPTY := 273
    static D3D10_MESSAGE_ID_DEVICE_PSGETSAMPLERS_SAMPLERS_EMPTY := 274
    static D3D10_MESSAGE_ID_DEVICE_RSGETVIEWPORTS_VIEWPORTS_EMPTY := 275
    static D3D10_MESSAGE_ID_DEVICE_RSGETSCISSORRECTS_RECTS_EMPTY := 276
    static D3D10_MESSAGE_ID_DEVICE_GENERATEMIPS_RESOURCE_INVALID := 277
    static D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSUBRESOURCE := 278
    static D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESUBRESOURCE := 279
    static D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCEBOX := 280
    static D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCE := 281
    static D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSTATE := 282
    static D3D10_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESTATE := 283
    static D3D10_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCE := 284
    static D3D10_MESSAGE_ID_COPYRESOURCE_INVALIDDESTINATIONSTATE := 285
    static D3D10_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCESTATE := 286
    static D3D10_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSUBRESOURCE := 287
    static D3D10_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONBOX := 288
    static D3D10_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSTATE := 289
    static D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_INVALID := 290
    static D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_SUBRESOURCE_INVALID := 291
    static D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_INVALID := 292
    static D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_SUBRESOURCE_INVALID := 293
    static D3D10_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_FORMAT_INVALID := 294
    static D3D10_MESSAGE_ID_BUFFER_MAP_INVALIDMAPTYPE := 295
    static D3D10_MESSAGE_ID_BUFFER_MAP_INVALIDFLAGS := 296
    static D3D10_MESSAGE_ID_BUFFER_MAP_ALREADYMAPPED := 297
    static D3D10_MESSAGE_ID_BUFFER_MAP_DEVICEREMOVED_RETURN := 298
    static D3D10_MESSAGE_ID_BUFFER_UNMAP_NOTMAPPED := 299
    static D3D10_MESSAGE_ID_TEXTURE1D_MAP_INVALIDMAPTYPE := 300
    static D3D10_MESSAGE_ID_TEXTURE1D_MAP_INVALIDSUBRESOURCE := 301
    static D3D10_MESSAGE_ID_TEXTURE1D_MAP_INVALIDFLAGS := 302
    static D3D10_MESSAGE_ID_TEXTURE1D_MAP_ALREADYMAPPED := 303
    static D3D10_MESSAGE_ID_TEXTURE1D_MAP_DEVICEREMOVED_RETURN := 304
    static D3D10_MESSAGE_ID_TEXTURE1D_UNMAP_INVALIDSUBRESOURCE := 305
    static D3D10_MESSAGE_ID_TEXTURE1D_UNMAP_NOTMAPPED := 306
    static D3D10_MESSAGE_ID_TEXTURE2D_MAP_INVALIDMAPTYPE := 307
    static D3D10_MESSAGE_ID_TEXTURE2D_MAP_INVALIDSUBRESOURCE := 308
    static D3D10_MESSAGE_ID_TEXTURE2D_MAP_INVALIDFLAGS := 309
    static D3D10_MESSAGE_ID_TEXTURE2D_MAP_ALREADYMAPPED := 310
    static D3D10_MESSAGE_ID_TEXTURE2D_MAP_DEVICEREMOVED_RETURN := 311
    static D3D10_MESSAGE_ID_TEXTURE2D_UNMAP_INVALIDSUBRESOURCE := 312
    static D3D10_MESSAGE_ID_TEXTURE2D_UNMAP_NOTMAPPED := 313
    static D3D10_MESSAGE_ID_TEXTURE3D_MAP_INVALIDMAPTYPE := 314
    static D3D10_MESSAGE_ID_TEXTURE3D_MAP_INVALIDSUBRESOURCE := 315
    static D3D10_MESSAGE_ID_TEXTURE3D_MAP_INVALIDFLAGS := 316
    static D3D10_MESSAGE_ID_TEXTURE3D_MAP_ALREADYMAPPED := 317
    static D3D10_MESSAGE_ID_TEXTURE3D_MAP_DEVICEREMOVED_RETURN := 318
    static D3D10_MESSAGE_ID_TEXTURE3D_UNMAP_INVALIDSUBRESOURCE := 319
    static D3D10_MESSAGE_ID_TEXTURE3D_UNMAP_NOTMAPPED := 320
    static D3D10_MESSAGE_ID_CHECKFORMATSUPPORT_FORMAT_DEPRECATED := 321
    static D3D10_MESSAGE_ID_CHECKMULTISAMPLEQUALITYLEVELS_FORMAT_DEPRECATED := 322
    static D3D10_MESSAGE_ID_SETEXCEPTIONMODE_UNRECOGNIZEDFLAGS := 323
    static D3D10_MESSAGE_ID_SETEXCEPTIONMODE_INVALIDARG_RETURN := 324
    static D3D10_MESSAGE_ID_SETEXCEPTIONMODE_DEVICEREMOVED_RETURN := 325
    static D3D10_MESSAGE_ID_REF_SIMULATING_INFINITELY_FAST_HARDWARE := 326
    static D3D10_MESSAGE_ID_REF_THREADING_MODE := 327
    static D3D10_MESSAGE_ID_REF_UMDRIVER_EXCEPTION := 328
    static D3D10_MESSAGE_ID_REF_KMDRIVER_EXCEPTION := 329
    static D3D10_MESSAGE_ID_REF_HARDWARE_EXCEPTION := 330
    static D3D10_MESSAGE_ID_REF_ACCESSING_INDEXABLE_TEMP_OUT_OF_RANGE := 331
    static D3D10_MESSAGE_ID_REF_PROBLEM_PARSING_SHADER := 332
    static D3D10_MESSAGE_ID_REF_OUT_OF_MEMORY := 333
    static D3D10_MESSAGE_ID_REF_INFO := 334
    static D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEXPOS_OVERFLOW := 335
    static D3D10_MESSAGE_ID_DEVICE_DRAWINDEXED_INDEXPOS_OVERFLOW := 336
    static D3D10_MESSAGE_ID_DEVICE_DRAWINSTANCED_VERTEXPOS_OVERFLOW := 337
    static D3D10_MESSAGE_ID_DEVICE_DRAWINSTANCED_INSTANCEPOS_OVERFLOW := 338
    static D3D10_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INSTANCEPOS_OVERFLOW := 339
    static D3D10_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INDEXPOS_OVERFLOW := 340
    static D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_SHADER_NOT_SET := 341
    static D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SEMANTICNAME_NOT_FOUND := 342
    static D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERINDEX := 343
    static D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_COMPONENTTYPE := 344
    static D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERMASK := 345
    static D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SYSTEMVALUE := 346
    static D3D10_MESSAGE_ID_DEVICE_SHADER_LINKAGE_NEVERWRITTEN_ALWAYSREADS := 347
    static D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_NOT_SET := 348
    static D3D10_MESSAGE_ID_DEVICE_DRAW_INPUTLAYOUT_NOT_SET := 349
    static D3D10_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_NOT_SET := 350
    static D3D10_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_TOO_SMALL := 351
    static D3D10_MESSAGE_ID_DEVICE_DRAW_SAMPLER_NOT_SET := 352
    static D3D10_MESSAGE_ID_DEVICE_DRAW_SHADERRESOURCEVIEW_NOT_SET := 353
    static D3D10_MESSAGE_ID_DEVICE_DRAW_VIEW_DIMENSION_MISMATCH := 354
    static D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL := 355
    static D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_TOO_SMALL := 356
    static D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_NOT_SET := 357
    static D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_FORMAT_INVALID := 358
    static D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_TOO_SMALL := 359
    static D3D10_MESSAGE_ID_DEVICE_DRAW_GS_INPUT_PRIMITIVE_MISMATCH := 360
    static D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_RETURN_TYPE_MISMATCH := 361
    static D3D10_MESSAGE_ID_DEVICE_DRAW_POSITION_NOT_PRESENT := 362
    static D3D10_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_NOT_SET := 363
    static D3D10_MESSAGE_ID_DEVICE_DRAW_BOUND_RESOURCE_MAPPED := 364
    static D3D10_MESSAGE_ID_DEVICE_DRAW_INVALID_PRIMITIVETOPOLOGY := 365
    static D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_OFFSET_UNALIGNED := 366
    static D3D10_MESSAGE_ID_DEVICE_DRAW_VERTEX_STRIDE_UNALIGNED := 367
    static D3D10_MESSAGE_ID_DEVICE_DRAW_INDEX_OFFSET_UNALIGNED := 368
    static D3D10_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_OFFSET_UNALIGNED := 369
    static D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_LD_UNSUPPORTED := 370
    static D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_UNSUPPORTED := 371
    static D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_C_UNSUPPORTED := 372
    static D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_MULTISAMPLE_UNSUPPORTED := 373
    static D3D10_MESSAGE_ID_DEVICE_DRAW_SO_TARGETS_BOUND_WITHOUT_SOURCE := 374
    static D3D10_MESSAGE_ID_DEVICE_DRAW_SO_STRIDE_LARGER_THAN_BUFFER := 375
    static D3D10_MESSAGE_ID_DEVICE_DRAW_OM_RENDER_TARGET_DOES_NOT_SUPPORT_BLENDING := 376
    static D3D10_MESSAGE_ID_DEVICE_DRAW_OM_DUAL_SOURCE_BLENDING_CAN_ONLY_HAVE_RENDER_TARGET_0 := 377
    static D3D10_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_AT_FAULT := 378
    static D3D10_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_POSSIBLY_AT_FAULT := 379
    static D3D10_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_NOT_AT_FAULT := 380
    static D3D10_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_INVALIDARG_RETURN := 381
    static D3D10_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_OUTOFMEMORY_RETURN := 382
    static D3D10_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_BADINTERFACE_RETURN := 383
    static D3D10_MESSAGE_ID_DEVICE_DRAW_VIEWPORT_NOT_SET := 384
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_TRAILING_DIGIT_IN_SEMANTIC := 385
    static D3D10_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_TRAILING_DIGIT_IN_SEMANTIC := 386
    static D3D10_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_DENORMFLUSH := 387
    static D3D10_MESSAGE_ID_OMSETRENDERTARGETS_INVALIDVIEW := 388
    static D3D10_MESSAGE_ID_DEVICE_SETTEXTFILTERSIZE_INVALIDDIMENSIONS := 389
    static D3D10_MESSAGE_ID_DEVICE_DRAW_SAMPLER_MISMATCH := 390
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_TYPE_MISMATCH := 391
    static D3D10_MESSAGE_ID_BLENDSTATE_GETDESC_LEGACY := 392
    static D3D10_MESSAGE_ID_SHADERRESOURCEVIEW_GETDESC_LEGACY := 393
    static D3D10_MESSAGE_ID_CREATEQUERY_OUTOFMEMORY_RETURN := 394
    static D3D10_MESSAGE_ID_CREATEPREDICATE_OUTOFMEMORY_RETURN := 395
    static D3D10_MESSAGE_ID_CREATECOUNTER_OUTOFRANGE_COUNTER := 396
    static D3D10_MESSAGE_ID_CREATECOUNTER_SIMULTANEOUS_ACTIVE_COUNTERS_EXHAUSTED := 397
    static D3D10_MESSAGE_ID_CREATECOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER := 398
    static D3D10_MESSAGE_ID_CREATECOUNTER_OUTOFMEMORY_RETURN := 399
    static D3D10_MESSAGE_ID_CREATECOUNTER_NONEXCLUSIVE_RETURN := 400
    static D3D10_MESSAGE_ID_CREATECOUNTER_NULLDESC := 401
    static D3D10_MESSAGE_ID_CHECKCOUNTER_OUTOFRANGE_COUNTER := 402
    static D3D10_MESSAGE_ID_CHECKCOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER := 403
    static D3D10_MESSAGE_ID_SETPREDICATION_INVALID_PREDICATE_STATE := 404
    static D3D10_MESSAGE_ID_QUERY_BEGIN_UNSUPPORTED := 405
    static D3D10_MESSAGE_ID_PREDICATE_BEGIN_DURING_PREDICATION := 406
    static D3D10_MESSAGE_ID_QUERY_BEGIN_DUPLICATE := 407
    static D3D10_MESSAGE_ID_QUERY_BEGIN_ABANDONING_PREVIOUS_RESULTS := 408
    static D3D10_MESSAGE_ID_PREDICATE_END_DURING_PREDICATION := 409
    static D3D10_MESSAGE_ID_QUERY_END_ABANDONING_PREVIOUS_RESULTS := 410
    static D3D10_MESSAGE_ID_QUERY_END_WITHOUT_BEGIN := 411
    static D3D10_MESSAGE_ID_QUERY_GETDATA_INVALID_DATASIZE := 412
    static D3D10_MESSAGE_ID_QUERY_GETDATA_INVALID_FLAGS := 413
    static D3D10_MESSAGE_ID_QUERY_GETDATA_INVALID_CALL := 414
    static D3D10_MESSAGE_ID_DEVICE_DRAW_PS_OUTPUT_TYPE_MISMATCH := 415
    static D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_GATHER_UNSUPPORTED := 416
    static D3D10_MESSAGE_ID_DEVICE_DRAW_INVALID_USE_OF_CENTER_MULTISAMPLE_PATTERN := 417
    static D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_STRIDE_TOO_LARGE := 418
    static D3D10_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_INVALIDRANGE := 419
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_EMPTY_LAYOUT := 420
    static D3D10_MESSAGE_ID_DEVICE_DRAW_RESOURCE_SAMPLE_COUNT_MISMATCH := 421
    static D3D10_MESSAGE_ID_LIVE_OBJECT_SUMMARY := 422
    static D3D10_MESSAGE_ID_LIVE_BUFFER := 423
    static D3D10_MESSAGE_ID_LIVE_TEXTURE1D := 424
    static D3D10_MESSAGE_ID_LIVE_TEXTURE2D := 425
    static D3D10_MESSAGE_ID_LIVE_TEXTURE3D := 426
    static D3D10_MESSAGE_ID_LIVE_SHADERRESOURCEVIEW := 427
    static D3D10_MESSAGE_ID_LIVE_RENDERTARGETVIEW := 428
    static D3D10_MESSAGE_ID_LIVE_DEPTHSTENCILVIEW := 429
    static D3D10_MESSAGE_ID_LIVE_VERTEXSHADER := 430
    static D3D10_MESSAGE_ID_LIVE_GEOMETRYSHADER := 431
    static D3D10_MESSAGE_ID_LIVE_PIXELSHADER := 432
    static D3D10_MESSAGE_ID_LIVE_INPUTLAYOUT := 433
    static D3D10_MESSAGE_ID_LIVE_SAMPLER := 434
    static D3D10_MESSAGE_ID_LIVE_BLENDSTATE := 435
    static D3D10_MESSAGE_ID_LIVE_DEPTHSTENCILSTATE := 436
    static D3D10_MESSAGE_ID_LIVE_RASTERIZERSTATE := 437
    static D3D10_MESSAGE_ID_LIVE_QUERY := 438
    static D3D10_MESSAGE_ID_LIVE_PREDICATE := 439
    static D3D10_MESSAGE_ID_LIVE_COUNTER := 440
    static D3D10_MESSAGE_ID_LIVE_DEVICE := 441
    static D3D10_MESSAGE_ID_LIVE_SWAPCHAIN := 442
    static D3D10_MESSAGE_ID_D3D10_MESSAGES_END := 443
    static D3D10_MESSAGE_ID_D3D10L9_MESSAGES_START := 1048576
    static D3D10_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_STENCIL_NO_TWO_SIDED := 1048577
    static D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_DepthBiasClamp_NOT_SUPPORTED := 1048578
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_NO_COMPARISON_SUPPORT := 1048579
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_EXCESSIVE_ANISOTROPY := 1048580
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_OUT_OF_RANGE := 1048581
    static D3D10_MESSAGE_ID_VSSETSAMPLERS_NOT_SUPPORTED := 1048582
    static D3D10_MESSAGE_ID_VSSETSAMPLERS_TOO_MANY_SAMPLERS := 1048583
    static D3D10_MESSAGE_ID_PSSETSAMPLERS_TOO_MANY_SAMPLERS := 1048584
    static D3D10_MESSAGE_ID_CREATERESOURCE_NO_ARRAYS := 1048585
    static D3D10_MESSAGE_ID_CREATERESOURCE_NO_VB_AND_IB_BIND := 1048586
    static D3D10_MESSAGE_ID_CREATERESOURCE_NO_TEXTURE_1D := 1048587
    static D3D10_MESSAGE_ID_CREATERESOURCE_DIMENSION_OUT_OF_RANGE := 1048588
    static D3D10_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_SHADER_RESOURCE := 1048589
    static D3D10_MESSAGE_ID_OMSETRENDERTARGETS_TOO_MANY_RENDER_TARGETS := 1048590
    static D3D10_MESSAGE_ID_OMSETRENDERTARGETS_NO_DIFFERING_BIT_DEPTHS := 1048591
    static D3D10_MESSAGE_ID_IASETVERTEXBUFFERS_BAD_BUFFER_INDEX := 1048592
    static D3D10_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_TOO_MANY_VIEWPORTS := 1048593
    static D3D10_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_ADJACENCY_UNSUPPORTED := 1048594
    static D3D10_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_TOO_MANY_SCISSORS := 1048595
    static D3D10_MESSAGE_ID_COPYRESOURCE_ONLY_TEXTURE_2D_WITHIN_GPU_MEMORY := 1048596
    static D3D10_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_3D_READBACK := 1048597
    static D3D10_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_ONLY_READBACK := 1048598
    static D3D10_MESSAGE_ID_CREATEINPUTLAYOUT_UNSUPPORTED_FORMAT := 1048599
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_ALPHA_TO_COVERAGE := 1048600
    static D3D10_MESSAGE_ID_CREATERASTERIZERSTATE_DepthClipEnable_MUST_BE_TRUE := 1048601
    static D3D10_MESSAGE_ID_DRAWINDEXED_STARTINDEXLOCATION_MUST_BE_POSITIVE := 1048602
    static D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_MUST_USE_LOWEST_LOD := 1048603
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_MINLOD_MUST_NOT_BE_FRACTIONAL := 1048604
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_MAXLOD_MUST_BE_FLT_MAX := 1048605
    static D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_FIRSTARRAYSLICE_MUST_BE_ZERO := 1048606
    static D3D10_MESSAGE_ID_CREATESHADERRESOURCEVIEW_CUBES_MUST_HAVE_6_SIDES := 1048607
    static D3D10_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_RENDER_TARGET := 1048608
    static D3D10_MESSAGE_ID_CREATERESOURCE_NO_DWORD_INDEX_BUFFER := 1048609
    static D3D10_MESSAGE_ID_CREATERESOURCE_MSAA_PRECLUDES_SHADER_RESOURCE := 1048610
    static D3D10_MESSAGE_ID_CREATERESOURCE_PRESENTATION_PRECLUDES_SHADER_RESOURCE := 1048611
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_BLEND_ENABLE := 1048612
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_WRITE_MASKS := 1048613
    static D3D10_MESSAGE_ID_CREATERESOURCE_NO_STREAM_OUT := 1048614
    static D3D10_MESSAGE_ID_CREATERESOURCE_ONLY_VB_IB_FOR_BUFFERS := 1048615
    static D3D10_MESSAGE_ID_CREATERESOURCE_NO_AUTOGEN_FOR_VOLUMES := 1048616
    static D3D10_MESSAGE_ID_CREATERESOURCE_DXGI_FORMAT_R8G8B8A8_CANNOT_BE_SHARED := 1048617
    static D3D10_MESSAGE_ID_VSSHADERRESOURCES_NOT_SUPPORTED := 1048618
    static D3D10_MESSAGE_ID_GEOMETRY_SHADER_NOT_SUPPORTED := 1048619
    static D3D10_MESSAGE_ID_STREAM_OUT_NOT_SUPPORTED := 1048620
    static D3D10_MESSAGE_ID_TEXT_FILTER_NOT_SUPPORTED := 1048621
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_SEPARATE_ALPHA_BLEND := 1048622
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_NO_MRT_BLEND := 1048623
    static D3D10_MESSAGE_ID_CREATEBLENDSTATE_OPERATION_NOT_SUPPORTED := 1048624
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_NO_MIRRORONCE := 1048625
    static D3D10_MESSAGE_ID_DRAWINSTANCED_NOT_SUPPORTED := 1048626
    static D3D10_MESSAGE_ID_DRAWINDEXEDINSTANCED_NOT_SUPPORTED_BELOW_9_3 := 1048627
    static D3D10_MESSAGE_ID_DRAWINDEXED_POINTLIST_UNSUPPORTED := 1048628
    static D3D10_MESSAGE_ID_SETBLENDSTATE_SAMPLE_MASK_CANNOT_BE_ZERO := 1048629
    static D3D10_MESSAGE_ID_CREATERESOURCE_DIMENSION_EXCEEDS_FEATURE_LEVEL_DEFINITION := 1048630
    static D3D10_MESSAGE_ID_CREATERESOURCE_ONLY_SINGLE_MIP_LEVEL_DEPTH_STENCIL_SUPPORTED := 1048631
    static D3D10_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_NEGATIVESCISSOR := 1048632
    static D3D10_MESSAGE_ID_SLOT_ZERO_MUST_BE_D3D10_INPUT_PER_VERTEX_DATA := 1048633
    static D3D10_MESSAGE_ID_CREATERESOURCE_NON_POW_2_MIPMAP := 1048634
    static D3D10_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_NOT_SUPPORTED := 1048635
    static D3D10_MESSAGE_ID_OMSETRENDERTARGETS_NO_SRGB_MRT := 1048636
    static D3D10_MESSAGE_ID_COPYRESOURCE_NO_3D_MISMATCHED_UPDATES := 1048637
    static D3D10_MESSAGE_ID_D3D10L9_MESSAGES_END := 1048638
}
struct D3D10_MESSAGE {
    Category : D3D10_MESSAGE_CATEGORY
    Severity : D3D10_MESSAGE_SEVERITY
    ID : D3D10_MESSAGE_ID
    pDescription : UInt8.Ptr
    DescriptionByteLength : IntPtr
}
struct D3D10_INFO_QUEUE_FILTER_DESC {
    NumCategories : UInt32
    pCategoryList : D3D10_MESSAGE_CATEGORY.Ptr
    NumSeverities : UInt32
    pSeverityList : D3D10_MESSAGE_SEVERITY.Ptr
    NumIDs : UInt32
    pIDList : D3D10_MESSAGE_ID.Ptr
}
struct D3D10_INFO_QUEUE_FILTER {
    AllowList : D3D10_INFO_QUEUE_FILTER_DESC
    DenyList : D3D10_INFO_QUEUE_FILTER_DESC
}
struct ID3D10InfoQueue extends IUnknown {
    static IID := "{1B940B17-2642-4D1F-AB1F-B99BAD0C395F}"
    SetMessageCountLimit(MessageCountLimit)
      => ComCall(3, this.p, Int64, MessageCountLimit)
    ClearStoredMessages()
      => ComCall(4, this.p, "void")
    GetMessage(MessageIndex, pMessage?, pMessageByteLength)
      => ComCall(5, this.p, Int64, MessageIndex, D3D10_MESSAGE.Ptr, pMessage?, IntPtr.Ptr, pMessageByteLength)
    GetNumMessagesAllowedByStorageFilter()
      => ComCall(6, this.p, Int64)
    GetNumMessagesDeniedByStorageFilter()
      => ComCall(7, this.p, Int64)
    GetNumStoredMessages()
      => ComCall(8, this.p, Int64)
    GetNumStoredMessagesAllowedByRetrievalFilter()
      => ComCall(9, this.p, Int64)
    GetNumMessagesDiscardedByMessageCountLimit()
      => ComCall(10, this.p, Int64)
    GetMessageCountLimit()
      => ComCall(11, this.p, Int64)
    AddStorageFilterEntries(pFilter)
      => ComCall(12, this.p, D3D10_INFO_QUEUE_FILTER.Ptr, pFilter)
    GetStorageFilter(pFilter?, pFilterByteLength)
      => ComCall(13, this.p, D3D10_INFO_QUEUE_FILTER.Ptr, pFilter?, IntPtr.Ptr, pFilterByteLength)
    ClearStorageFilter()
      => ComCall(14, this.p, "void")
    PushEmptyStorageFilter()
      => ComCall(15, this.p)
    PushCopyOfStorageFilter()
      => ComCall(16, this.p)
    PushStorageFilter(pFilter)
      => ComCall(17, this.p, D3D10_INFO_QUEUE_FILTER.Ptr, pFilter)
    PopStorageFilter()
      => ComCall(18, this.p, "void")
    GetStorageFilterStackSize()
      => ComCall(19, this.p, UInt32)
    AddRetrievalFilterEntries(pFilter)
      => ComCall(20, this.p, D3D10_INFO_QUEUE_FILTER.Ptr, pFilter)
    GetRetrievalFilter(pFilter?, pFilterByteLength)
      => ComCall(21, this.p, D3D10_INFO_QUEUE_FILTER.Ptr, pFilter?, IntPtr.Ptr, pFilterByteLength)
    ClearRetrievalFilter()
      => ComCall(22, this.p, "void")
    PushEmptyRetrievalFilter()
      => ComCall(23, this.p)
    PushCopyOfRetrievalFilter()
      => ComCall(24, this.p)
    PushRetrievalFilter(pFilter)
      => ComCall(25, this.p, D3D10_INFO_QUEUE_FILTER.Ptr, pFilter)
    PopRetrievalFilter()
      => ComCall(26, this.p, "void")
    GetRetrievalFilterStackSize()
      => ComCall(27, this.p, UInt32)
    AddMessage(Category, Severity, ID, pDescription)
      => ComCall(28, this.p, D3D10_MESSAGE_CATEGORY, Category, D3D10_MESSAGE_SEVERITY, Severity, D3D10_MESSAGE_ID, ID, PSTR, pDescription)
    AddApplicationMessage(Severity, pDescription)
      => ComCall(29, this.p, D3D10_MESSAGE_SEVERITY, Severity, PSTR, pDescription)
    SetBreakOnCategory(Category, bEnable)
      => ComCall(30, this.p, D3D10_MESSAGE_CATEGORY, Category, BOOL, bEnable)
    SetBreakOnSeverity(Severity, bEnable)
      => ComCall(31, this.p, D3D10_MESSAGE_SEVERITY, Severity, BOOL, bEnable)
    SetBreakOnID(ID, bEnable)
      => ComCall(32, this.p, D3D10_MESSAGE_ID, ID, BOOL, bEnable)
    GetBreakOnCategory(Category)
      => ComCall(33, this.p, D3D10_MESSAGE_CATEGORY, Category, BOOL)
    GetBreakOnSeverity(Severity)
      => ComCall(34, this.p, D3D10_MESSAGE_SEVERITY, Severity, BOOL)
    GetBreakOnID(ID)
      => ComCall(35, this.p, D3D10_MESSAGE_ID, ID, BOOL)
    SetMuteDebugOutput(bMute)
      => ComCall(36, this.p, BOOL, bMute, "void")
    GetMuteDebugOutput()
      => ComCall(37, this.p, BOOL)
}
struct D3D10_DRIVER_TYPE extends Int32 {
    static D3D10_DRIVER_TYPE_HARDWARE := 0
    static D3D10_DRIVER_TYPE_REFERENCE := 1
    static D3D10_DRIVER_TYPE_NULL := 2
    static D3D10_DRIVER_TYPE_SOFTWARE := 3
    static D3D10_DRIVER_TYPE_WARP := 5
}
struct D3D10_SHADER_DESC {
    Version : UInt32
    Creator : PSTR
    Flags : UInt32
    ConstantBuffers : UInt32
    BoundResources : UInt32
    InputParameters : UInt32
    OutputParameters : UInt32
    InstructionCount : UInt32
    TempRegisterCount : UInt32
    TempArrayCount : UInt32
    DefCount : UInt32
    DclCount : UInt32
    TextureNormalInstructions : UInt32
    TextureLoadInstructions : UInt32
    TextureCompInstructions : UInt32
    TextureBiasInstructions : UInt32
    TextureGradientInstructions : UInt32
    FloatInstructionCount : UInt32
    IntInstructionCount : UInt32
    UintInstructionCount : UInt32
    StaticFlowControlCount : UInt32
    DynamicFlowControlCount : UInt32
    MacroInstructionCount : UInt32
    ArrayInstructionCount : UInt32
    CutInstructionCount : UInt32
    EmitInstructionCount : UInt32
    GSOutputTopology : D3D_PRIMITIVE_TOPOLOGY
    GSMaxOutputVertexCount : UInt32
}
struct D3D10_SHADER_BUFFER_DESC {
    Name : PSTR
    Type : D3D_CBUFFER_TYPE
    Variables : UInt32
    Size : UInt32
    uFlags : UInt32
}
struct D3D10_SHADER_VARIABLE_DESC {
    Name : PSTR
    StartOffset : UInt32
    Size : UInt32
    uFlags : UInt32
    DefaultValue : Struct.Ptr
}
struct D3D10_SHADER_TYPE_DESC {
    Class : D3D_SHADER_VARIABLE_CLASS
    Type : D3D_SHADER_VARIABLE_TYPE
    Rows : UInt32
    Columns : UInt32
    Elements : UInt32
    Members : UInt32
    Offset : UInt32
}
struct D3D10_SHADER_INPUT_BIND_DESC {
    Name : PSTR
    Type : D3D_SHADER_INPUT_TYPE
    BindPoint : UInt32
    BindCount : UInt32
    uFlags : UInt32
    ReturnType : D3D_RESOURCE_RETURN_TYPE
    Dimension : D3D_SRV_DIMENSION
    NumSamples : UInt32
}
struct D3D10_SIGNATURE_PARAMETER_DESC {
    SemanticName : PSTR
    SemanticIndex : UInt32
    Register : UInt32
    SystemValueType : D3D_NAME
    ComponentType : D3D_REGISTER_COMPONENT_TYPE
    Mask : UInt8
    ReadWriteMask : UInt8
}
struct ID3D10ShaderReflectionType extends InterfacePointer {
    static IID := "{C530AD7D-9B16-4395-A979-BA2ECFF83ADD}"
    GetDesc(pDesc)
      => ComCall(0, this.p, D3D10_SHADER_TYPE_DESC.Ptr, pDesc)
    GetMemberTypeByIndex(Index)
      => ComCall(1, this.p, UInt32, Index, ID3D10ShaderReflectionType)
    GetMemberTypeByName(Name)
      => ComCall(2, this.p, PSTR, Name, ID3D10ShaderReflectionType)
    GetMemberTypeName(Index)
      => ComCall(3, this.p, UInt32, Index, PSTR)
}
struct ID3D10ShaderReflectionVariable extends InterfacePointer {
    static IID := "{1BF63C95-2650-405D-99C1-3636BD1DA0A1}"
    GetDesc(pDesc)
      => ComCall(0, this.p, D3D10_SHADER_VARIABLE_DESC.Ptr, pDesc)
    GetType()
      => ComCall(1, this.p, ID3D10ShaderReflectionType)
}
struct ID3D10ShaderReflectionConstantBuffer extends InterfacePointer {
    static IID := "{66C66A94-DDDD-4B62-A66A-F0DA33C2B4D0}"
    GetDesc(pDesc)
      => ComCall(0, this.p, D3D10_SHADER_BUFFER_DESC.Ptr, pDesc)
    GetVariableByIndex(Index)
      => ComCall(1, this.p, UInt32, Index, ID3D10ShaderReflectionVariable)
    GetVariableByName(Name)
      => ComCall(2, this.p, PSTR, Name, ID3D10ShaderReflectionVariable)
}
struct ID3D10ShaderReflection extends IUnknown {
    static IID := "{D40E20B6-F8F7-42AD-AB20-4BAF8F15DFAA}"
    GetDesc(pDesc)
      => ComCall(3, this.p, D3D10_SHADER_DESC.Ptr, pDesc)
    GetConstantBufferByIndex(Index)
      => ComCall(4, this.p, UInt32, Index, ID3D10ShaderReflectionConstantBuffer)
    GetConstantBufferByName(Name)
      => ComCall(5, this.p, PSTR, Name, ID3D10ShaderReflectionConstantBuffer)
    GetResourceBindingDesc(ResourceIndex, pDesc)
      => ComCall(6, this.p, UInt32, ResourceIndex, D3D10_SHADER_INPUT_BIND_DESC.Ptr, pDesc)
    GetInputParameterDesc(ParameterIndex, pDesc)
      => ComCall(7, this.p, UInt32, ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC.Ptr, pDesc)
    GetOutputParameterDesc(ParameterIndex, pDesc)
      => ComCall(8, this.p, UInt32, ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC.Ptr, pDesc)
}
struct D3D10_DEVICE_STATE_TYPES extends Int32 {
    static D3D10_DST_SO_BUFFERS := 1
    static D3D10_DST_OM_RENDER_TARGETS := 2
    static D3D10_DST_OM_DEPTH_STENCIL_STATE := 3
    static D3D10_DST_OM_BLEND_STATE := 4
    static D3D10_DST_VS := 5
    static D3D10_DST_VS_SAMPLERS := 6
    static D3D10_DST_VS_SHADER_RESOURCES := 7
    static D3D10_DST_VS_CONSTANT_BUFFERS := 8
    static D3D10_DST_GS := 9
    static D3D10_DST_GS_SAMPLERS := 10
    static D3D10_DST_GS_SHADER_RESOURCES := 11
    static D3D10_DST_GS_CONSTANT_BUFFERS := 12
    static D3D10_DST_PS := 13
    static D3D10_DST_PS_SAMPLERS := 14
    static D3D10_DST_PS_SHADER_RESOURCES := 15
    static D3D10_DST_PS_CONSTANT_BUFFERS := 16
    static D3D10_DST_IA_VERTEX_BUFFERS := 17
    static D3D10_DST_IA_INDEX_BUFFER := 18
    static D3D10_DST_IA_INPUT_LAYOUT := 19
    static D3D10_DST_IA_PRIMITIVE_TOPOLOGY := 20
    static D3D10_DST_RS_VIEWPORTS := 21
    static D3D10_DST_RS_SCISSOR_RECTS := 22
    static D3D10_DST_RS_RASTERIZER_STATE := 23
    static D3D10_DST_PREDICATION := 24
}
struct D3D10_STATE_BLOCK_MASK {
    VS : UInt8
    VSSamplers : UInt8[2]
    VSShaderResources : UInt8[16]
    VSConstantBuffers : UInt8[2]
    GS : UInt8
    GSSamplers : UInt8[2]
    GSShaderResources : UInt8[16]
    GSConstantBuffers : UInt8[2]
    PS : UInt8
    PSSamplers : UInt8[2]
    PSShaderResources : UInt8[16]
    PSConstantBuffers : UInt8[2]
    IAVertexBuffers : UInt8[2]
    IAIndexBuffer : UInt8
    IAInputLayout : UInt8
    IAPrimitiveTopology : UInt8
    OMRenderTargets : UInt8
    OMDepthStencilState : UInt8
    OMBlendState : UInt8
    RSViewports : UInt8
    RSScissorRects : UInt8
    RSRasterizerState : UInt8
    SOBuffers : UInt8
    Predication : UInt8
}
struct ID3D10StateBlock extends IUnknown {
    static IID := "{0803425A-57F5-4DD6-9465-A87570834A08}"
    Capture()
      => ComCall(3, this.p)
    Apply()
      => ComCall(4, this.p)
    ReleaseAllDeviceObjects()
      => ComCall(5, this.p)
    GetDevice(ppDevice)
      => ComCall(6, this.p, ID3D10Device.Ptr, ppDevice)
}
struct D3D10_EFFECT_TYPE_DESC {
    TypeName : PSTR
    Class : D3D_SHADER_VARIABLE_CLASS
    Type : D3D_SHADER_VARIABLE_TYPE
    Elements : UInt32
    Members : UInt32
    Rows : UInt32
    Columns : UInt32
    PackedSize : UInt32
    UnpackedSize : UInt32
    Stride : UInt32
}
struct ID3D10EffectType extends InterfacePointer {
    static IID := "{4E9E1DDC-CD9D-4772-A837-00180B9B88FD}"
    IsValid()
      => ComCall(0, this.p, BOOL)
    GetDesc(pDesc)
      => ComCall(1, this.p, D3D10_EFFECT_TYPE_DESC.Ptr, pDesc)
    GetMemberTypeByIndex(Index)
      => ComCall(2, this.p, UInt32, Index, ID3D10EffectType)
    GetMemberTypeByName(Name)
      => ComCall(3, this.p, PSTR, Name, ID3D10EffectType)
    GetMemberTypeBySemantic(Semantic)
      => ComCall(4, this.p, PSTR, Semantic, ID3D10EffectType)
    GetMemberName(Index)
      => ComCall(5, this.p, UInt32, Index, PSTR)
    GetMemberSemantic(Index)
      => ComCall(6, this.p, UInt32, Index, PSTR)
}
struct D3D10_EFFECT_VARIABLE_DESC {
    Name : PSTR
    Semantic : PSTR
    Flags : UInt32
    Annotations : UInt32
    BufferOffset : UInt32
    ExplicitBindPoint : UInt32
}
struct ID3D10EffectVariable extends InterfacePointer {
    static IID := "{AE897105-00E6-45BF-BB8E-281DD6DB8E1B}"
    IsValid()
      => ComCall(0, this.p, BOOL)
    GetType()
      => ComCall(1, this.p, ID3D10EffectType)
    GetDesc(pDesc)
      => ComCall(2, this.p, D3D10_EFFECT_VARIABLE_DESC.Ptr, pDesc)
    GetAnnotationByIndex(Index)
      => ComCall(3, this.p, UInt32, Index, ID3D10EffectVariable)
    GetAnnotationByName(Name)
      => ComCall(4, this.p, PSTR, Name, ID3D10EffectVariable)
    GetMemberByIndex(Index)
      => ComCall(5, this.p, UInt32, Index, ID3D10EffectVariable)
    GetMemberByName(Name)
      => ComCall(6, this.p, PSTR, Name, ID3D10EffectVariable)
    GetMemberBySemantic(Semantic)
      => ComCall(7, this.p, PSTR, Semantic, ID3D10EffectVariable)
    GetElement(Index)
      => ComCall(8, this.p, UInt32, Index, ID3D10EffectVariable)
    GetParentConstantBuffer()
      => ComCall(9, this.p, ID3D10EffectConstantBuffer)
    AsScalar()
      => ComCall(10, this.p, ID3D10EffectScalarVariable)
    AsVector()
      => ComCall(11, this.p, ID3D10EffectVectorVariable)
    AsMatrix()
      => ComCall(12, this.p, ID3D10EffectMatrixVariable)
    AsString()
      => ComCall(13, this.p, ID3D10EffectStringVariable)
    AsShaderResource()
      => ComCall(14, this.p, ID3D10EffectShaderResourceVariable)
    AsRenderTargetView()
      => ComCall(15, this.p, ID3D10EffectRenderTargetViewVariable)
    AsDepthStencilView()
      => ComCall(16, this.p, ID3D10EffectDepthStencilViewVariable)
    AsConstantBuffer()
      => ComCall(17, this.p, ID3D10EffectConstantBuffer)
    AsShader()
      => ComCall(18, this.p, ID3D10EffectShaderVariable)
    AsBlend()
      => ComCall(19, this.p, ID3D10EffectBlendVariable)
    AsDepthStencil()
      => ComCall(20, this.p, ID3D10EffectDepthStencilVariable)
    AsRasterizer()
      => ComCall(21, this.p, ID3D10EffectRasterizerVariable)
    AsSampler()
      => ComCall(22, this.p, ID3D10EffectSamplerVariable)
    SetRawValue(pData, Offset)
      => ComCall(23, this.p, Struct.Ptr, pData, UInt32, Offset, UInt32, pData.Size)
    GetRawValue(pData, Offset)
      => ComCall(24, this.p, Struct.Ptr, pData, UInt32, Offset, UInt32, pData.Size)
}
struct ID3D10EffectScalarVariable extends ID3D10EffectVariable {
    static IID := "{00E48F7B-D2C8-49E8-A86C-022DEE53431F}"
    SetFloat(Value)
      => ComCall(25, this.p, Float32, Value)
    GetFloat(pValue)
      => ComCall(26, this.p, Float32.Ptr, pValue)
    SetFloatArray(pData, Offset)
      => ComCall(27, this.p, Float32.Ptr, pData, UInt32, Offset, UInt32, pData.Length)
    GetFloatArray(pData, Offset)
      => ComCall(28, this.p, Float32.Ptr, pData, UInt32, Offset, UInt32, pData.Length)
    SetInt(Value)
      => ComCall(29, this.p, Int32, Value)
    GetInt(pValue)
      => ComCall(30, this.p, Int32.Ptr, pValue)
    SetIntArray(pData, Offset)
      => ComCall(31, this.p, Int32.Ptr, pData, UInt32, Offset, UInt32, pData.Length)
    GetIntArray(pData, Offset)
      => ComCall(32, this.p, Int32.Ptr, pData, UInt32, Offset, UInt32, pData.Length)
    SetBool(Value)
      => ComCall(33, this.p, BOOL, Value)
    GetBool(pValue)
      => ComCall(34, this.p, BOOL.Ptr, pValue)
    SetBoolArray(pData, Offset)
      => ComCall(35, this.p, BOOL.Ptr, pData, UInt32, Offset, UInt32, pData.Length)
    GetBoolArray(pData, Offset)
      => ComCall(36, this.p, BOOL.Ptr, pData, UInt32, Offset, UInt32, pData.Length)
}
struct ID3D10EffectVectorVariable extends ID3D10EffectVariable {
    static IID := "{62B98C44-1F82-4C67-BCD0-72CF8F217E81}"
    SetBoolVector(pData)
      => ComCall(25, this.p, BOOL.Ptr, pData)
    SetIntVector(pData)
      => ComCall(26, this.p, Int32.Ptr, pData)
    SetFloatVector(pData)
      => ComCall(27, this.p, Float32.Ptr, pData)
    GetBoolVector(pData)
      => ComCall(28, this.p, BOOL.Ptr, pData)
    GetIntVector(pData)
      => ComCall(29, this.p, Int32.Ptr, pData)
    GetFloatVector(pData)
      => ComCall(30, this.p, Float32.Ptr, pData)
    SetBoolVectorArray(pData, Offset, Count)
      => ComCall(31, this.p, BOOL.Ptr, pData, UInt32, Offset, UInt32, Count)
    SetIntVectorArray(pData, Offset, Count)
      => ComCall(32, this.p, Int32.Ptr, pData, UInt32, Offset, UInt32, Count)
    SetFloatVectorArray(pData, Offset, Count)
      => ComCall(33, this.p, Float32.Ptr, pData, UInt32, Offset, UInt32, Count)
    GetBoolVectorArray(pData, Offset, Count)
      => ComCall(34, this.p, BOOL.Ptr, pData, UInt32, Offset, UInt32, Count)
    GetIntVectorArray(pData, Offset, Count)
      => ComCall(35, this.p, Int32.Ptr, pData, UInt32, Offset, UInt32, Count)
    GetFloatVectorArray(pData, Offset, Count)
      => ComCall(36, this.p, Float32.Ptr, pData, UInt32, Offset, UInt32, Count)
}
struct ID3D10EffectMatrixVariable extends ID3D10EffectVariable {
    static IID := "{50666C24-B82F-4EED-A172-5B6E7E8522E0}"
    SetMatrix(pData)
      => ComCall(25, this.p, Float32.Ptr, pData)
    GetMatrix(pData)
      => ComCall(26, this.p, Float32.Ptr, pData)
    SetMatrixArray(pData, Offset, Count)
      => ComCall(27, this.p, Float32.Ptr, pData, UInt32, Offset, UInt32, Count)
    GetMatrixArray(pData, Offset, Count)
      => ComCall(28, this.p, Float32.Ptr, pData, UInt32, Offset, UInt32, Count)
    SetMatrixTranspose(pData)
      => ComCall(29, this.p, Float32.Ptr, pData)
    GetMatrixTranspose(pData)
      => ComCall(30, this.p, Float32.Ptr, pData)
    SetMatrixTransposeArray(pData, Offset, Count)
      => ComCall(31, this.p, Float32.Ptr, pData, UInt32, Offset, UInt32, Count)
    GetMatrixTransposeArray(pData, Offset, Count)
      => ComCall(32, this.p, Float32.Ptr, pData, UInt32, Offset, UInt32, Count)
}
struct ID3D10EffectStringVariable extends ID3D10EffectVariable {
    static IID := "{71417501-8DF9-4E0A-A78A-255F9756BAFF}"
    GetString(ppString)
      => ComCall(25, this.p, PSTR.Ptr, ppString)
    GetStringArray(ppStrings, Offset)
      => ComCall(26, this.p, PSTR.Ptr, ppStrings, UInt32, Offset, UInt32, ppStrings.Length)
}
struct ID3D10EffectShaderResourceVariable extends ID3D10EffectVariable {
    static IID := "{C0A7157B-D872-4B1D-8073-EFC2ACD4B1FC}"
    SetResource(pResource?)
      => ComCall(25, this.p, ID3D10ShaderResourceView, pResource?)
    GetResource(ppResource)
      => ComCall(26, this.p, ID3D10ShaderResourceView.Ptr, ppResource)
    SetResourceArray(ppResources, Offset)
      => ComCall(27, this.p, ID3D10ShaderResourceView.Ptr, ppResources, UInt32, Offset, UInt32, ppResources.Length)
    GetResourceArray(ppResources, Offset)
      => ComCall(28, this.p, ID3D10ShaderResourceView.Ptr, ppResources, UInt32, Offset, UInt32, ppResources.Length)
}
struct ID3D10EffectRenderTargetViewVariable extends ID3D10EffectVariable {
    static IID := "{28CA0CC3-C2C9-40BB-B57F-67B737122B17}"
    SetRenderTarget(pResource?)
      => ComCall(25, this.p, ID3D10RenderTargetView, pResource?)
    GetRenderTarget(ppResource)
      => ComCall(26, this.p, ID3D10RenderTargetView.Ptr, ppResource)
    SetRenderTargetArray(ppResources, Offset)
      => ComCall(27, this.p, ID3D10RenderTargetView.Ptr, ppResources, UInt32, Offset, UInt32, ppResources.Length)
    GetRenderTargetArray(ppResources, Offset)
      => ComCall(28, this.p, ID3D10RenderTargetView.Ptr, ppResources, UInt32, Offset, UInt32, ppResources.Length)
}
struct ID3D10EffectDepthStencilViewVariable extends ID3D10EffectVariable {
    static IID := "{3E02C918-CC79-4985-B622-2D92AD701623}"
    SetDepthStencil(pResource?)
      => ComCall(25, this.p, ID3D10DepthStencilView, pResource?)
    GetDepthStencil(ppResource)
      => ComCall(26, this.p, ID3D10DepthStencilView.Ptr, ppResource)
    SetDepthStencilArray(ppResources, Offset)
      => ComCall(27, this.p, ID3D10DepthStencilView.Ptr, ppResources, UInt32, Offset, UInt32, ppResources.Length)
    GetDepthStencilArray(ppResources, Offset)
      => ComCall(28, this.p, ID3D10DepthStencilView.Ptr, ppResources, UInt32, Offset, UInt32, ppResources.Length)
}
struct ID3D10EffectConstantBuffer extends ID3D10EffectVariable {
    static IID := "{56648F4D-CC8B-4444-A5AD-B5A3D76E91B3}"
    SetConstantBuffer(pConstantBuffer?)
      => ComCall(25, this.p, ID3D10Buffer, pConstantBuffer?)
    GetConstantBuffer(ppConstantBuffer)
      => ComCall(26, this.p, ID3D10Buffer.Ptr, ppConstantBuffer)
    SetTextureBuffer(pTextureBuffer?)
      => ComCall(27, this.p, ID3D10ShaderResourceView, pTextureBuffer?)
    GetTextureBuffer(ppTextureBuffer)
      => ComCall(28, this.p, ID3D10ShaderResourceView.Ptr, ppTextureBuffer)
}
struct D3D10_EFFECT_SHADER_DESC {
    pInputSignature : UInt8.Ptr
    IsInline : BOOL
    pBytecode : UInt8.Ptr
    BytecodeLength : UInt32
    SODecl : PSTR
    NumInputSignatureEntries : UInt32
    NumOutputSignatureEntries : UInt32
}
struct ID3D10EffectShaderVariable extends ID3D10EffectVariable {
    static IID := "{80849279-C799-4797-8C33-0407A07D9E06}"
    GetShaderDesc(ShaderIndex, pDesc)
      => ComCall(25, this.p, UInt32, ShaderIndex, D3D10_EFFECT_SHADER_DESC.Ptr, pDesc)
    GetVertexShader(ShaderIndex, ppVS)
      => ComCall(26, this.p, UInt32, ShaderIndex, ID3D10VertexShader.Ptr, ppVS)
    GetGeometryShader(ShaderIndex, ppGS)
      => ComCall(27, this.p, UInt32, ShaderIndex, ID3D10GeometryShader.Ptr, ppGS)
    GetPixelShader(ShaderIndex, ppPS)
      => ComCall(28, this.p, UInt32, ShaderIndex, ID3D10PixelShader.Ptr, ppPS)
    GetInputSignatureElementDesc(ShaderIndex, Element, pDesc)
      => ComCall(29, this.p, UInt32, ShaderIndex, UInt32, Element, D3D10_SIGNATURE_PARAMETER_DESC.Ptr, pDesc)
    GetOutputSignatureElementDesc(ShaderIndex, Element, pDesc)
      => ComCall(30, this.p, UInt32, ShaderIndex, UInt32, Element, D3D10_SIGNATURE_PARAMETER_DESC.Ptr, pDesc)
}
struct ID3D10EffectBlendVariable extends ID3D10EffectVariable {
    static IID := "{1FCD2294-DF6D-4EAE-86B3-0E9160CFB07B}"
    GetBlendState(Index, ppBlendState)
      => ComCall(25, this.p, UInt32, Index, ID3D10BlendState.Ptr, ppBlendState)
    GetBackingStore(Index, pBlendDesc)
      => ComCall(26, this.p, UInt32, Index, D3D10_BLEND_DESC.Ptr, pBlendDesc)
}
struct ID3D10EffectDepthStencilVariable extends ID3D10EffectVariable {
    static IID := "{AF482368-330A-46A5-9A5C-01C71AF24C8D}"
    GetDepthStencilState(Index, ppDepthStencilState)
      => ComCall(25, this.p, UInt32, Index, ID3D10DepthStencilState.Ptr, ppDepthStencilState)
    GetBackingStore(Index, pDepthStencilDesc)
      => ComCall(26, this.p, UInt32, Index, D3D10_DEPTH_STENCIL_DESC.Ptr, pDepthStencilDesc)
}
struct ID3D10EffectRasterizerVariable extends ID3D10EffectVariable {
    static IID := "{21AF9F0E-4D94-4EA9-9785-2CB76B8C0B34}"
    GetRasterizerState(Index, ppRasterizerState)
      => ComCall(25, this.p, UInt32, Index, ID3D10RasterizerState.Ptr, ppRasterizerState)
    GetBackingStore(Index, pRasterizerDesc)
      => ComCall(26, this.p, UInt32, Index, D3D10_RASTERIZER_DESC.Ptr, pRasterizerDesc)
}
struct ID3D10EffectSamplerVariable extends ID3D10EffectVariable {
    static IID := "{6530D5C7-07E9-4271-A418-E7CE4BD1E480}"
    GetSampler(Index, ppSampler)
      => ComCall(25, this.p, UInt32, Index, ID3D10SamplerState.Ptr, ppSampler)
    GetBackingStore(Index, pSamplerDesc)
      => ComCall(26, this.p, UInt32, Index, D3D10_SAMPLER_DESC.Ptr, pSamplerDesc)
}
struct D3D10_PASS_DESC {
    Name : PSTR
    Annotations : UInt32
    pIAInputSignature : UInt8.Ptr
    IAInputSignatureSize : IntPtr
    StencilRef : UInt32
    SampleMask : UInt32
    BlendFactor : Float32[4]
}
struct D3D10_PASS_SHADER_DESC {
    pShaderVariable : ID3D10EffectShaderVariable
    ShaderIndex : UInt32
}
struct ID3D10EffectPass extends InterfacePointer {
    static IID := "{5CFBEB89-1A06-46E0-B282-E3F9BFA36A54}"
    IsValid()
      => ComCall(0, this.p, BOOL)
    GetDesc(pDesc)
      => ComCall(1, this.p, D3D10_PASS_DESC.Ptr, pDesc)
    GetVertexShaderDesc(pDesc)
      => ComCall(2, this.p, D3D10_PASS_SHADER_DESC.Ptr, pDesc)
    GetGeometryShaderDesc(pDesc)
      => ComCall(3, this.p, D3D10_PASS_SHADER_DESC.Ptr, pDesc)
    GetPixelShaderDesc(pDesc)
      => ComCall(4, this.p, D3D10_PASS_SHADER_DESC.Ptr, pDesc)
    GetAnnotationByIndex(Index)
      => ComCall(5, this.p, UInt32, Index, ID3D10EffectVariable)
    GetAnnotationByName(Name)
      => ComCall(6, this.p, PSTR, Name, ID3D10EffectVariable)
    Apply(Flags)
      => ComCall(7, this.p, UInt32, Flags)
    ComputeStateBlockMask(pStateBlockMask)
      => ComCall(8, this.p, D3D10_STATE_BLOCK_MASK.Ptr, pStateBlockMask)
}
struct D3D10_TECHNIQUE_DESC {
    Name : PSTR
    Passes : UInt32
    Annotations : UInt32
}
struct ID3D10EffectTechnique extends InterfacePointer {
    static IID := "{DB122CE8-D1C9-4292-B237-24ED3DE8B175}"
    IsValid()
      => ComCall(0, this.p, BOOL)
    GetDesc(pDesc)
      => ComCall(1, this.p, D3D10_TECHNIQUE_DESC.Ptr, pDesc)
    GetAnnotationByIndex(Index)
      => ComCall(2, this.p, UInt32, Index, ID3D10EffectVariable)
    GetAnnotationByName(Name)
      => ComCall(3, this.p, PSTR, Name, ID3D10EffectVariable)
    GetPassByIndex(Index)
      => ComCall(4, this.p, UInt32, Index, ID3D10EffectPass)
    GetPassByName(Name)
      => ComCall(5, this.p, PSTR, Name, ID3D10EffectPass)
    ComputeStateBlockMask(pStateBlockMask)
      => ComCall(6, this.p, D3D10_STATE_BLOCK_MASK.Ptr, pStateBlockMask)
}
struct D3D10_EFFECT_DESC {
    IsChildEffect : BOOL
    ConstantBuffers : UInt32
    SharedConstantBuffers : UInt32
    GlobalVariables : UInt32
    SharedGlobalVariables : UInt32
    Techniques : UInt32
}
struct ID3D10Effect extends IUnknown {
    static IID := "{51B0CA8B-EC0B-4519-870D-8EE1CB5017C7}"
    IsValid()
      => ComCall(3, this.p, BOOL)
    IsPool()
      => ComCall(4, this.p, BOOL)
    GetDevice(ppDevice)
      => ComCall(5, this.p, ID3D10Device.Ptr, ppDevice)
    GetDesc(pDesc)
      => ComCall(6, this.p, D3D10_EFFECT_DESC.Ptr, pDesc)
    GetConstantBufferByIndex(Index)
      => ComCall(7, this.p, UInt32, Index, ID3D10EffectConstantBuffer)
    GetConstantBufferByName(Name)
      => ComCall(8, this.p, PSTR, Name, ID3D10EffectConstantBuffer)
    GetVariableByIndex(Index)
      => ComCall(9, this.p, UInt32, Index, ID3D10EffectVariable)
    GetVariableByName(Name)
      => ComCall(10, this.p, PSTR, Name, ID3D10EffectVariable)
    GetVariableBySemantic(Semantic)
      => ComCall(11, this.p, PSTR, Semantic, ID3D10EffectVariable)
    GetTechniqueByIndex(Index)
      => ComCall(12, this.p, UInt32, Index, ID3D10EffectTechnique)
    GetTechniqueByName(Name)
      => ComCall(13, this.p, PSTR, Name, ID3D10EffectTechnique)
    Optimize()
      => ComCall(14, this.p)
    IsOptimized()
      => ComCall(15, this.p, BOOL)
}
struct ID3D10EffectPool extends IUnknown {
    static IID := "{9537AB04-3250-412E-8213-FCD2F8677933}"
    AsEffect()
      => ComCall(3, this.p, ID3D10Effect)
}
struct D3D10_FEATURE_LEVEL1 extends Int32 {
    static D3D10_FEATURE_LEVEL_10_0 := 40960
    static D3D10_FEATURE_LEVEL_10_1 := 41216
    static D3D10_FEATURE_LEVEL_9_1 := 37120
    static D3D10_FEATURE_LEVEL_9_2 := 37376
    static D3D10_FEATURE_LEVEL_9_3 := 37632
}
struct D3D10_RENDER_TARGET_BLEND_DESC1 {
    BlendEnable : BOOL
    SrcBlend : D3D10_BLEND
    DestBlend : D3D10_BLEND
    BlendOp : D3D10_BLEND_OP
    SrcBlendAlpha : D3D10_BLEND
    DestBlendAlpha : D3D10_BLEND
    BlendOpAlpha : D3D10_BLEND_OP
    RenderTargetWriteMask : UInt8
}
struct D3D10_BLEND_DESC1 {
    AlphaToCoverageEnable : BOOL
    IndependentBlendEnable : BOOL
    RenderTarget : D3D10_RENDER_TARGET_BLEND_DESC1[8]
}
struct ID3D10BlendState1 extends ID3D10BlendState {
    static IID := "{EDAD8D99-8A35-4D6D-8566-2EA276CDE161}"
    GetDesc1(pDesc)
      => ComCall(8, this.p, D3D10_BLEND_DESC1.Ptr, pDesc, "void")
}
struct D3D10_TEXCUBE_ARRAY_SRV1 {
    MostDetailedMip : UInt32
    MipLevels : UInt32
    First2DArrayFace : UInt32
    NumCubes : UInt32
}
struct D3D10_SHADER_RESOURCE_VIEW_DESC1 {
    Format : DXGI_FORMAT
    ViewDimension : D3D_SRV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Buffer : D3D10_BUFFER_SRV
            Texture1D : D3D10_TEX1D_SRV
            Texture1DArray : D3D10_TEX1D_ARRAY_SRV
            Texture2D : D3D10_TEX2D_SRV
            Texture2DArray : D3D10_TEX2D_ARRAY_SRV
            Texture2DMS : D3D10_TEX2DMS_SRV
            Texture2DMSArray : D3D10_TEX2DMS_ARRAY_SRV
            Texture3D : D3D10_TEX3D_SRV
            TextureCube : D3D10_TEXCUBE_SRV
            TextureCubeArray : D3D10_TEXCUBE_ARRAY_SRV1
        }
    }
}
struct ID3D10ShaderResourceView1 extends ID3D10ShaderResourceView {
    static IID := "{9B7E4C87-342C-4106-A19F-4F2704F689F0}"
    GetDesc1(pDesc)
      => ComCall(9, this.p, D3D10_SHADER_RESOURCE_VIEW_DESC1.Ptr, pDesc, "void")
}
struct D3D10_STANDARD_MULTISAMPLE_QUALITY_LEVELS extends Int32 {
    static D3D10_STANDARD_MULTISAMPLE_PATTERN := -1
    static D3D10_CENTER_MULTISAMPLE_PATTERN := -2
}
struct ID3D10Device1 extends ID3D10Device {
    static IID := "{9B7E4C8F-342C-4106-A19F-4F2704F689F0}"
    CreateShaderResourceView1(pResource, pDesc?, ppSRView?)
      => ComCall(98, this.p, ID3D10Resource, pResource, D3D10_SHADER_RESOURCE_VIEW_DESC1.Ptr, pDesc?, ID3D10ShaderResourceView1.Ptr, ppSRView?)
    CreateBlendState1(pBlendStateDesc, ppBlendState?)
      => ComCall(99, this.p, D3D10_BLEND_DESC1.Ptr, pBlendStateDesc, ID3D10BlendState1.Ptr, ppBlendState?)
    GetFeatureLevel()
      => ComCall(100, this.p, D3D10_FEATURE_LEVEL1)
}
struct D3D10_SHADER_DEBUG_REGTYPE extends Int32 {
    static D3D10_SHADER_DEBUG_REG_INPUT := 0
    static D3D10_SHADER_DEBUG_REG_OUTPUT := 1
    static D3D10_SHADER_DEBUG_REG_CBUFFER := 2
    static D3D10_SHADER_DEBUG_REG_TBUFFER := 3
    static D3D10_SHADER_DEBUG_REG_TEMP := 4
    static D3D10_SHADER_DEBUG_REG_TEMPARRAY := 5
    static D3D10_SHADER_DEBUG_REG_TEXTURE := 6
    static D3D10_SHADER_DEBUG_REG_SAMPLER := 7
    static D3D10_SHADER_DEBUG_REG_IMMEDIATECBUFFER := 8
    static D3D10_SHADER_DEBUG_REG_LITERAL := 9
    static D3D10_SHADER_DEBUG_REG_UNUSED := 10
    static D3D11_SHADER_DEBUG_REG_INTERFACE_POINTERS := 11
    static D3D11_SHADER_DEBUG_REG_UAV := 12
}
struct D3D10_SHADER_DEBUG_SCOPETYPE extends Int32 {
    static D3D10_SHADER_DEBUG_SCOPE_GLOBAL := 0
    static D3D10_SHADER_DEBUG_SCOPE_BLOCK := 1
    static D3D10_SHADER_DEBUG_SCOPE_FORLOOP := 2
    static D3D10_SHADER_DEBUG_SCOPE_STRUCT := 3
    static D3D10_SHADER_DEBUG_SCOPE_FUNC_PARAMS := 4
    static D3D10_SHADER_DEBUG_SCOPE_STATEBLOCK := 5
    static D3D10_SHADER_DEBUG_SCOPE_NAMESPACE := 6
    static D3D10_SHADER_DEBUG_SCOPE_ANNOTATION := 7
}
struct D3D10_SHADER_DEBUG_VARTYPE extends Int32 {
    static D3D10_SHADER_DEBUG_VAR_VARIABLE := 0
    static D3D10_SHADER_DEBUG_VAR_FUNCTION := 1
}
struct D3D10_SHADER_DEBUG_TOKEN_INFO {
    File : UInt32
    Line : UInt32
    Column : UInt32
    TokenLength : UInt32
    TokenId : UInt32
}
struct D3D10_SHADER_DEBUG_VAR_INFO {
    TokenId : UInt32
    Type : D3D_SHADER_VARIABLE_TYPE
    Register : UInt32
    Component : UInt32
    ScopeVar : UInt32
    ScopeVarOffset : UInt32
}
struct D3D10_SHADER_DEBUG_INPUT_INFO {
    Var : UInt32
    InitialRegisterSet : D3D10_SHADER_DEBUG_REGTYPE
    InitialBank : UInt32
    InitialRegister : UInt32
    InitialComponent : UInt32
    InitialValue : UInt32
}
struct D3D10_SHADER_DEBUG_SCOPEVAR_INFO {
    TokenId : UInt32
    VarType : D3D10_SHADER_DEBUG_VARTYPE
    Class : D3D_SHADER_VARIABLE_CLASS
    Rows : UInt32
    Columns : UInt32
    StructMemberScope : UInt32
    uArrayIndices : UInt32
    ArrayElements : UInt32
    ArrayStrides : UInt32
    uVariables : UInt32
    uFirstVariable : UInt32
}
struct D3D10_SHADER_DEBUG_SCOPE_INFO {
    ScopeType : D3D10_SHADER_DEBUG_SCOPETYPE
    Name : UInt32
    uNameLen : UInt32
    uVariables : UInt32
    VariableData : UInt32
}
struct D3D10_SHADER_DEBUG_OUTPUTVAR {
    Var : UInt32
    uValueMin : UInt32
    uValueMax : UInt32
    iValueMin : Int32
    iValueMax : Int32
    fValueMin : Float32
    fValueMax : Float32
    bNaNPossible : BOOL
    bInfPossible : BOOL
}
struct D3D10_SHADER_DEBUG_OUTPUTREG_INFO {
    OutputRegisterSet : D3D10_SHADER_DEBUG_REGTYPE
    OutputReg : UInt32
    TempArrayReg : UInt32
    OutputComponents : UInt32[4]
    OutputVars : D3D10_SHADER_DEBUG_OUTPUTVAR[4]
    IndexReg : UInt32
    IndexComp : UInt32
}
struct D3D10_SHADER_DEBUG_INST_INFO {
    Id : UInt32
    Opcode : UInt32
    uOutputs : UInt32
    pOutputs : D3D10_SHADER_DEBUG_OUTPUTREG_INFO[2]
    TokenId : UInt32
    NestingLevel : UInt32
    Scopes : UInt32
    ScopeInfo : UInt32
    AccessedVars : UInt32
    AccessedVarsInfo : UInt32
}
struct D3D10_SHADER_DEBUG_FILE_INFO {
    FileName : UInt32
    FileNameLen : UInt32
    FileData : UInt32
    FileLen : UInt32
}
struct D3D10_SHADER_DEBUG_INFO {
    Size : UInt32
    Creator : UInt32
    EntrypointName : UInt32
    ShaderTarget : UInt32
    CompileFlags : UInt32
    Files : UInt32
    FileInfo : UInt32
    Instructions : UInt32
    InstructionInfo : UInt32
    Variables : UInt32
    VariableInfo : UInt32
    InputVariables : UInt32
    InputVariableInfo : UInt32
    Tokens : UInt32
    TokenInfo : UInt32
    Scopes : UInt32
    ScopeInfo : UInt32
    ScopeVariables : UInt32
    ScopeVariableInfo : UInt32
    UintOffset : UInt32
    StringOffset : UInt32
}
struct ID3D10ShaderReflection1 extends IUnknown {
    static IID := "{C3457783-A846-47CE-9520-CEA6F66E7447}"
    GetDesc(pDesc)
      => ComCall(3, this.p, D3D10_SHADER_DESC.Ptr, pDesc)
    GetConstantBufferByIndex(Index)
      => ComCall(4, this.p, UInt32, Index, ID3D10ShaderReflectionConstantBuffer)
    GetConstantBufferByName(Name)
      => ComCall(5, this.p, PSTR, Name, ID3D10ShaderReflectionConstantBuffer)
    GetResourceBindingDesc(ResourceIndex, pDesc)
      => ComCall(6, this.p, UInt32, ResourceIndex, D3D10_SHADER_INPUT_BIND_DESC.Ptr, pDesc)
    GetInputParameterDesc(ParameterIndex, pDesc)
      => ComCall(7, this.p, UInt32, ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC.Ptr, pDesc)
    GetOutputParameterDesc(ParameterIndex, pDesc)
      => ComCall(8, this.p, UInt32, ParameterIndex, D3D10_SIGNATURE_PARAMETER_DESC.Ptr, pDesc)
    GetVariableByName(Name)
      => ComCall(9, this.p, PSTR, Name, ID3D10ShaderReflectionVariable)
    GetResourceBindingDescByName(Name, pDesc)
      => ComCall(10, this.p, PSTR, Name, D3D10_SHADER_INPUT_BIND_DESC.Ptr, pDesc)
    GetMovInstructionCount(pCount)
      => ComCall(11, this.p, UInt32.Ptr, pCount)
    GetMovcInstructionCount(pCount)
      => ComCall(12, this.p, UInt32.Ptr, pCount)
    GetConversionInstructionCount(pCount)
      => ComCall(13, this.p, UInt32.Ptr, pCount)
    GetBitwiseInstructionCount(pCount)
      => ComCall(14, this.p, UInt32.Ptr, pCount)
    GetGSInputPrimitive(pPrim)
      => ComCall(15, this.p, D3D_PRIMITIVE.Ptr, pPrim)
    IsLevel9Shader(pbLevel9Shader)
      => ComCall(16, this.p, BOOL.Ptr, pbLevel9Shader)
    IsSampleFrequencyShader(pbSampleFrequency)
      => ComCall(17, this.p, BOOL.Ptr, pbSampleFrequency)
}
struct PFN_D3D10_CREATE_DEVICE1 extends FunctionPointer {
    static Types := [IDXGIAdapter, D3D10_DRIVER_TYPE, HMODULE, UInt32, D3D10_FEATURE_LEVEL1, UInt32, ID3D10Device1.Ptr, HRESULT]
}
struct PFN_D3D10_CREATE_DEVICE_AND_SWAP_CHAIN1 extends FunctionPointer {
    static Types := [IDXGIAdapter, D3D10_DRIVER_TYPE, HMODULE, UInt32, D3D10_FEATURE_LEVEL1, UInt32, DXGI_SWAP_CHAIN_DESC.Ptr, IDXGISwapChain.Ptr, ID3D10Device1.Ptr, HRESULT]
}
