#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HMODULE, HRESULT, PSTR, PWSTR, RECT, SIZE}
#Import "..\Graphics.Direct3D\Types.ahk" {D3D_CBUFFER_TYPE, D3D_DRIVER_TYPE, D3D_FEATURE_LEVEL, D3D_INTERPOLATION_MODE, D3D_MIN_PRECISION, D3D_NAME, D3D_PARAMETER_FLAGS, D3D_PRIMITIVE, D3D_PRIMITIVE_TOPOLOGY, D3D_REGISTER_COMPONENT_TYPE, D3D_RESOURCE_RETURN_TYPE, D3D_SHADER_INPUT_TYPE, D3D_SHADER_VARIABLE_CLASS, D3D_SHADER_VARIABLE_TYPE, D3D_SRV_DIMENSION, D3D_TESSELLATOR_DOMAIN, D3D_TESSELLATOR_OUTPUT_PRIMITIVE, D3D_TESSELLATOR_PARTITIONING, ID3DBlob}
#Import "..\Graphics.Dxgi\Types.ahk" {DXGI_HDR_METADATA_TYPE, DXGI_SWAP_CHAIN_DESC, IDXGIAdapter, IDXGISwapChain}
#Import "..\Graphics.Dxgi.Common\Types.ahk" {DXGI_COLOR_SPACE_TYPE, DXGI_FORMAT, DXGI_RATIONAL, DXGI_SAMPLE_DESC}
#Import "..\Security\Types.ahk" {SECURITY_ATTRIBUTES}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct D3D11_INPUT_CLASSIFICATION extends Int32 {
    static D3D11_INPUT_PER_VERTEX_DATA := 0
    static D3D11_INPUT_PER_INSTANCE_DATA := 1
}
struct D3D11_INPUT_ELEMENT_DESC {
    SemanticName : PSTR
    SemanticIndex : UInt32
    Format : DXGI_FORMAT
    InputSlot : UInt32
    AlignedByteOffset : UInt32
    InputSlotClass : D3D11_INPUT_CLASSIFICATION
    InstanceDataStepRate : UInt32
}
struct D3D11_FILL_MODE extends Int32 {
    static D3D11_FILL_WIREFRAME := 2
    static D3D11_FILL_SOLID := 3
}
struct D3D11_CULL_MODE extends Int32 {
    static D3D11_CULL_NONE := 1
    static D3D11_CULL_FRONT := 2
    static D3D11_CULL_BACK := 3
}
struct D3D11_SO_DECLARATION_ENTRY {
    Stream : UInt32
    SemanticName : PSTR
    SemanticIndex : UInt32
    StartComponent : UInt8
    ComponentCount : UInt8
    OutputSlot : UInt8
}
struct D3D11_VIEWPORT {
    TopLeftX : Float32
    TopLeftY : Float32
    Width : Float32
    Height : Float32
    MinDepth : Float32
    MaxDepth : Float32
}
struct D3D11_DRAW_INSTANCED_INDIRECT_ARGS {
    VertexCountPerInstance : UInt32
    InstanceCount : UInt32
    StartVertexLocation : UInt32
    StartInstanceLocation : UInt32
}
struct D3D11_DRAW_INDEXED_INSTANCED_INDIRECT_ARGS {
    IndexCountPerInstance : UInt32
    InstanceCount : UInt32
    StartIndexLocation : UInt32
    BaseVertexLocation : Int32
    StartInstanceLocation : UInt32
}
struct D3D11_RESOURCE_DIMENSION extends Int32 {
    static D3D11_RESOURCE_DIMENSION_UNKNOWN := 0
    static D3D11_RESOURCE_DIMENSION_BUFFER := 1
    static D3D11_RESOURCE_DIMENSION_TEXTURE1D := 2
    static D3D11_RESOURCE_DIMENSION_TEXTURE2D := 3
    static D3D11_RESOURCE_DIMENSION_TEXTURE3D := 4
}
struct D3D11_DSV_DIMENSION extends Int32 {
    static D3D11_DSV_DIMENSION_UNKNOWN := 0
    static D3D11_DSV_DIMENSION_TEXTURE1D := 1
    static D3D11_DSV_DIMENSION_TEXTURE1DARRAY := 2
    static D3D11_DSV_DIMENSION_TEXTURE2D := 3
    static D3D11_DSV_DIMENSION_TEXTURE2DARRAY := 4
    static D3D11_DSV_DIMENSION_TEXTURE2DMS := 5
    static D3D11_DSV_DIMENSION_TEXTURE2DMSARRAY := 6
}
struct D3D11_RTV_DIMENSION extends Int32 {
    static D3D11_RTV_DIMENSION_UNKNOWN := 0
    static D3D11_RTV_DIMENSION_BUFFER := 1
    static D3D11_RTV_DIMENSION_TEXTURE1D := 2
    static D3D11_RTV_DIMENSION_TEXTURE1DARRAY := 3
    static D3D11_RTV_DIMENSION_TEXTURE2D := 4
    static D3D11_RTV_DIMENSION_TEXTURE2DARRAY := 5
    static D3D11_RTV_DIMENSION_TEXTURE2DMS := 6
    static D3D11_RTV_DIMENSION_TEXTURE2DMSARRAY := 7
    static D3D11_RTV_DIMENSION_TEXTURE3D := 8
}
struct D3D11_UAV_DIMENSION extends Int32 {
    static D3D11_UAV_DIMENSION_UNKNOWN := 0
    static D3D11_UAV_DIMENSION_BUFFER := 1
    static D3D11_UAV_DIMENSION_TEXTURE1D := 2
    static D3D11_UAV_DIMENSION_TEXTURE1DARRAY := 3
    static D3D11_UAV_DIMENSION_TEXTURE2D := 4
    static D3D11_UAV_DIMENSION_TEXTURE2DARRAY := 5
    static D3D11_UAV_DIMENSION_TEXTURE3D := 8
}
struct D3D11_USAGE extends Int32 {
    static D3D11_USAGE_DEFAULT := 0
    static D3D11_USAGE_IMMUTABLE := 1
    static D3D11_USAGE_DYNAMIC := 2
    static D3D11_USAGE_STAGING := 3
}
struct D3D11_BIND_FLAG extends Int32 {
    static D3D11_BIND_VERTEX_BUFFER := 1
    static D3D11_BIND_INDEX_BUFFER := 2
    static D3D11_BIND_CONSTANT_BUFFER := 4
    static D3D11_BIND_SHADER_RESOURCE := 8
    static D3D11_BIND_STREAM_OUTPUT := 16
    static D3D11_BIND_RENDER_TARGET := 32
    static D3D11_BIND_DEPTH_STENCIL := 64
    static D3D11_BIND_UNORDERED_ACCESS := 128
    static D3D11_BIND_DECODER := 512
    static D3D11_BIND_VIDEO_ENCODER := 1024
}
struct D3D11_CPU_ACCESS_FLAG extends Int32 {
    static D3D11_CPU_ACCESS_WRITE := 65536
    static D3D11_CPU_ACCESS_READ := 131072
}
struct D3D11_RESOURCE_MISC_FLAG extends Int32 {
    static D3D11_RESOURCE_MISC_GENERATE_MIPS := 1
    static D3D11_RESOURCE_MISC_SHARED := 2
    static D3D11_RESOURCE_MISC_TEXTURECUBE := 4
    static D3D11_RESOURCE_MISC_DRAWINDIRECT_ARGS := 16
    static D3D11_RESOURCE_MISC_BUFFER_ALLOW_RAW_VIEWS := 32
    static D3D11_RESOURCE_MISC_BUFFER_STRUCTURED := 64
    static D3D11_RESOURCE_MISC_RESOURCE_CLAMP := 128
    static D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX := 256
    static D3D11_RESOURCE_MISC_GDI_COMPATIBLE := 512
    static D3D11_RESOURCE_MISC_SHARED_NTHANDLE := 2048
    static D3D11_RESOURCE_MISC_RESTRICTED_CONTENT := 4096
    static D3D11_RESOURCE_MISC_RESTRICT_SHARED_RESOURCE := 8192
    static D3D11_RESOURCE_MISC_RESTRICT_SHARED_RESOURCE_DRIVER := 16384
    static D3D11_RESOURCE_MISC_GUARDED := 32768
    static D3D11_RESOURCE_MISC_TILE_POOL := 131072
    static D3D11_RESOURCE_MISC_TILED := 262144
    static D3D11_RESOURCE_MISC_HW_PROTECTED := 524288
    static D3D11_RESOURCE_MISC_SHARED_DISPLAYABLE := 1048576
    static D3D11_RESOURCE_MISC_SHARED_EXCLUSIVE_WRITER := 2097152
    static D3D11_RESOURCE_MISC_NO_SHADER_ACCESS := 4194304
}
struct D3D11_MAP extends Int32 {
    static D3D11_MAP_READ := 1
    static D3D11_MAP_WRITE := 2
    static D3D11_MAP_READ_WRITE := 3
    static D3D11_MAP_WRITE_DISCARD := 4
    static D3D11_MAP_WRITE_NO_OVERWRITE := 5
}
struct D3D11_MAP_FLAG extends Int32 {
    static D3D11_MAP_FLAG_DO_NOT_WAIT := 1048576
}
struct D3D11_RAISE_FLAG extends Int32 {
    static D3D11_RAISE_FLAG_DRIVER_INTERNAL_ERROR := 1
}
struct D3D11_CLEAR_FLAG extends UInt32 {
    static D3D11_CLEAR_DEPTH := 1
    static D3D11_CLEAR_STENCIL := 2
}
struct D3D11_BOX {
    left : UInt32
    top : UInt32
    front : UInt32
    right : UInt32
    bottom : UInt32
    back : UInt32
}
struct ID3D11DeviceChild extends IUnknown {
    static IID := "{1841E5C8-16B0-489B-BCC8-44CFB0D5DEAE}"
    GetDevice(ppDevice)
      => ComCall(3, this.p, ID3D11Device.Ptr, ppDevice, "void")
    GetPrivateData(guid, pDataSize, pData?)
      => ComCall(4, this.p, GUID.Ptr, guid, UInt32.Ptr, pDataSize, Struct.Ptr, pData?)
    SetPrivateData(guid, pData?)
      => ComCall(5, this.p, GUID.Ptr, guid, UInt32, pData?.Size ?? 0, Struct.Ptr, pData?)
    SetPrivateDataInterface(guid, pData?)
      => ComCall(6, this.p, GUID.Ptr, guid, IUnknown, pData?)
}
struct D3D11_COMPARISON_FUNC extends Int32 {
    static D3D11_COMPARISON_NEVER := 1
    static D3D11_COMPARISON_LESS := 2
    static D3D11_COMPARISON_EQUAL := 3
    static D3D11_COMPARISON_LESS_EQUAL := 4
    static D3D11_COMPARISON_GREATER := 5
    static D3D11_COMPARISON_NOT_EQUAL := 6
    static D3D11_COMPARISON_GREATER_EQUAL := 7
    static D3D11_COMPARISON_ALWAYS := 8
}
struct D3D11_DEPTH_WRITE_MASK extends Int32 {
    static D3D11_DEPTH_WRITE_MASK_ZERO := 0
    static D3D11_DEPTH_WRITE_MASK_ALL := 1
}
struct D3D11_STENCIL_OP extends Int32 {
    static D3D11_STENCIL_OP_KEEP := 1
    static D3D11_STENCIL_OP_ZERO := 2
    static D3D11_STENCIL_OP_REPLACE := 3
    static D3D11_STENCIL_OP_INCR_SAT := 4
    static D3D11_STENCIL_OP_DECR_SAT := 5
    static D3D11_STENCIL_OP_INVERT := 6
    static D3D11_STENCIL_OP_INCR := 7
    static D3D11_STENCIL_OP_DECR := 8
}
struct D3D11_DEPTH_STENCILOP_DESC {
    StencilFailOp : D3D11_STENCIL_OP
    StencilDepthFailOp : D3D11_STENCIL_OP
    StencilPassOp : D3D11_STENCIL_OP
    StencilFunc : D3D11_COMPARISON_FUNC
}
struct D3D11_DEPTH_STENCIL_DESC {
    DepthEnable : BOOL
    DepthWriteMask : D3D11_DEPTH_WRITE_MASK
    DepthFunc : D3D11_COMPARISON_FUNC
    StencilEnable : BOOL
    StencilReadMask : UInt8
    StencilWriteMask : UInt8
    FrontFace : D3D11_DEPTH_STENCILOP_DESC
    BackFace : D3D11_DEPTH_STENCILOP_DESC
}
struct ID3D11DepthStencilState extends ID3D11DeviceChild {
    static IID := "{03823EFB-8D8F-4E1C-9AA2-F64BB2CBFDF1}"
    GetDesc(pDesc)
      => ComCall(7, this.p, D3D11_DEPTH_STENCIL_DESC.Ptr, pDesc, "void")
}
struct D3D11_BLEND extends Int32 {
    static D3D11_BLEND_ZERO := 1
    static D3D11_BLEND_ONE := 2
    static D3D11_BLEND_SRC_COLOR := 3
    static D3D11_BLEND_INV_SRC_COLOR := 4
    static D3D11_BLEND_SRC_ALPHA := 5
    static D3D11_BLEND_INV_SRC_ALPHA := 6
    static D3D11_BLEND_DEST_ALPHA := 7
    static D3D11_BLEND_INV_DEST_ALPHA := 8
    static D3D11_BLEND_DEST_COLOR := 9
    static D3D11_BLEND_INV_DEST_COLOR := 10
    static D3D11_BLEND_SRC_ALPHA_SAT := 11
    static D3D11_BLEND_BLEND_FACTOR := 14
    static D3D11_BLEND_INV_BLEND_FACTOR := 15
    static D3D11_BLEND_SRC1_COLOR := 16
    static D3D11_BLEND_INV_SRC1_COLOR := 17
    static D3D11_BLEND_SRC1_ALPHA := 18
    static D3D11_BLEND_INV_SRC1_ALPHA := 19
}
struct D3D11_BLEND_OP extends Int32 {
    static D3D11_BLEND_OP_ADD := 1
    static D3D11_BLEND_OP_SUBTRACT := 2
    static D3D11_BLEND_OP_REV_SUBTRACT := 3
    static D3D11_BLEND_OP_MIN := 4
    static D3D11_BLEND_OP_MAX := 5
}
struct D3D11_COLOR_WRITE_ENABLE extends Int32 {
    static D3D11_COLOR_WRITE_ENABLE_RED := 1
    static D3D11_COLOR_WRITE_ENABLE_GREEN := 2
    static D3D11_COLOR_WRITE_ENABLE_BLUE := 4
    static D3D11_COLOR_WRITE_ENABLE_ALPHA := 8
    static D3D11_COLOR_WRITE_ENABLE_ALL := 15
}
struct D3D11_RENDER_TARGET_BLEND_DESC {
    BlendEnable : BOOL
    SrcBlend : D3D11_BLEND
    DestBlend : D3D11_BLEND
    BlendOp : D3D11_BLEND_OP
    SrcBlendAlpha : D3D11_BLEND
    DestBlendAlpha : D3D11_BLEND
    BlendOpAlpha : D3D11_BLEND_OP
    RenderTargetWriteMask : UInt8
}
struct D3D11_BLEND_DESC {
    AlphaToCoverageEnable : BOOL
    IndependentBlendEnable : BOOL
    RenderTarget : D3D11_RENDER_TARGET_BLEND_DESC[8]
}
struct ID3D11BlendState extends ID3D11DeviceChild {
    static IID := "{75B68FAA-347D-4159-8F45-A0640F01CD9A}"
    GetDesc(pDesc)
      => ComCall(7, this.p, D3D11_BLEND_DESC.Ptr, pDesc, "void")
}
struct D3D11_RASTERIZER_DESC {
    FillMode : D3D11_FILL_MODE
    CullMode : D3D11_CULL_MODE
    FrontCounterClockwise : BOOL
    DepthBias : Int32
    DepthBiasClamp : Float32
    SlopeScaledDepthBias : Float32
    DepthClipEnable : BOOL
    ScissorEnable : BOOL
    MultisampleEnable : BOOL
    AntialiasedLineEnable : BOOL
}
struct ID3D11RasterizerState extends ID3D11DeviceChild {
    static IID := "{9BB4AB81-AB1A-4D8F-B506-FC04200B6EE7}"
    GetDesc(pDesc)
      => ComCall(7, this.p, D3D11_RASTERIZER_DESC.Ptr, pDesc, "void")
}
struct D3D11_SUBRESOURCE_DATA {
    pSysMem : Struct.Ptr
    SysMemPitch : UInt32
    SysMemSlicePitch : UInt32
}
struct D3D11_MAPPED_SUBRESOURCE {
    pData : Struct.Ptr
    RowPitch : UInt32
    DepthPitch : UInt32
}
struct ID3D11Resource extends ID3D11DeviceChild {
    static IID := "{DC8E63F3-D12B-4952-B47B-5E45026A862D}"
    GetType(pResourceDimension)
      => ComCall(7, this.p, D3D11_RESOURCE_DIMENSION.Ptr, pResourceDimension, "void")
    SetEvictionPriority(EvictionPriority)
      => ComCall(8, this.p, UInt32, EvictionPriority, "void")
    GetEvictionPriority()
      => ComCall(9, this.p, UInt32)
}
struct D3D11_BUFFER_DESC {
    ByteWidth : UInt32
    Usage : D3D11_USAGE
    BindFlags : UInt32
    CPUAccessFlags : UInt32
    MiscFlags : UInt32
    StructureByteStride : UInt32
}
struct ID3D11Buffer extends ID3D11Resource {
    static IID := "{48570B85-D1EE-4FCD-A250-EB350722B037}"
    GetDesc(pDesc)
      => ComCall(10, this.p, D3D11_BUFFER_DESC.Ptr, pDesc, "void")
}
struct D3D11_TEXTURE1D_DESC {
    Width : UInt32
    MipLevels : UInt32
    ArraySize : UInt32
    Format : DXGI_FORMAT
    Usage : D3D11_USAGE
    BindFlags : UInt32
    CPUAccessFlags : UInt32
    MiscFlags : UInt32
}
struct ID3D11Texture1D extends ID3D11Resource {
    static IID := "{F8FB5C27-C6B3-4F75-A4C8-439AF2EF564C}"
    GetDesc(pDesc)
      => ComCall(10, this.p, D3D11_TEXTURE1D_DESC.Ptr, pDesc, "void")
}
struct D3D11_TEXTURE2D_DESC {
    Width : UInt32
    Height : UInt32
    MipLevels : UInt32
    ArraySize : UInt32
    Format : DXGI_FORMAT
    SampleDesc : DXGI_SAMPLE_DESC
    Usage : D3D11_USAGE
    BindFlags : UInt32
    CPUAccessFlags : UInt32
    MiscFlags : UInt32
}
struct ID3D11Texture2D extends ID3D11Resource {
    static IID := "{6F15AAF2-D208-4E89-9AB4-489535D34F9C}"
    GetDesc(pDesc)
      => ComCall(10, this.p, D3D11_TEXTURE2D_DESC.Ptr, pDesc, "void")
}
struct D3D11_TEXTURE3D_DESC {
    Width : UInt32
    Height : UInt32
    Depth : UInt32
    MipLevels : UInt32
    Format : DXGI_FORMAT
    Usage : D3D11_USAGE
    BindFlags : UInt32
    CPUAccessFlags : UInt32
    MiscFlags : UInt32
}
struct ID3D11Texture3D extends ID3D11Resource {
    static IID := "{037E866E-F56D-4357-A8AF-9DABBE6E250E}"
    GetDesc(pDesc)
      => ComCall(10, this.p, D3D11_TEXTURE3D_DESC.Ptr, pDesc, "void")
}
struct D3D11_TEXTURECUBE_FACE extends Int32 {
    static D3D11_TEXTURECUBE_FACE_POSITIVE_X := 0
    static D3D11_TEXTURECUBE_FACE_NEGATIVE_X := 1
    static D3D11_TEXTURECUBE_FACE_POSITIVE_Y := 2
    static D3D11_TEXTURECUBE_FACE_NEGATIVE_Y := 3
    static D3D11_TEXTURECUBE_FACE_POSITIVE_Z := 4
    static D3D11_TEXTURECUBE_FACE_NEGATIVE_Z := 5
}
struct ID3D11View extends ID3D11DeviceChild {
    static IID := "{839D1216-BB2E-412B-B7F4-A9DBEBE08ED1}"
    GetResource(ppResource)
      => ComCall(7, this.p, ID3D11Resource.Ptr, ppResource, "void")
}
struct D3D11_BUFFER_SRV {
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
struct D3D11_BUFFEREX_SRV_FLAG extends Int32 {
    static D3D11_BUFFEREX_SRV_FLAG_RAW := 1
}
struct D3D11_BUFFEREX_SRV {
    FirstElement : UInt32
    NumElements : UInt32
    Flags : UInt32
}
struct D3D11_TEX1D_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
}
struct D3D11_TEX1D_ARRAY_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D11_TEX2D_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
}
struct D3D11_TEX2D_ARRAY_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D11_TEX3D_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
}
struct D3D11_TEXCUBE_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
}
struct D3D11_TEXCUBE_ARRAY_SRV {
    MostDetailedMip : UInt32
    MipLevels : UInt32
    First2DArrayFace : UInt32
    NumCubes : UInt32
}
struct D3D11_TEX2DMS_SRV {
    UnusedField_NothingToDefine : UInt32
}
struct D3D11_TEX2DMS_ARRAY_SRV {
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D11_SHADER_RESOURCE_VIEW_DESC {
    Format : DXGI_FORMAT
    ViewDimension : D3D_SRV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Buffer : D3D11_BUFFER_SRV
            Texture1D : D3D11_TEX1D_SRV
            Texture1DArray : D3D11_TEX1D_ARRAY_SRV
            Texture2D : D3D11_TEX2D_SRV
            Texture2DArray : D3D11_TEX2D_ARRAY_SRV
            Texture2DMS : D3D11_TEX2DMS_SRV
            Texture2DMSArray : D3D11_TEX2DMS_ARRAY_SRV
            Texture3D : D3D11_TEX3D_SRV
            TextureCube : D3D11_TEXCUBE_SRV
            TextureCubeArray : D3D11_TEXCUBE_ARRAY_SRV
            BufferEx : D3D11_BUFFEREX_SRV
        }
    }
}
struct ID3D11ShaderResourceView extends ID3D11View {
    static IID := "{B0E06FE0-8192-4E1A-B1CA-36D7414710B2}"
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D11_SHADER_RESOURCE_VIEW_DESC.Ptr, pDesc, "void")
}
struct D3D11_BUFFER_RTV {
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
struct D3D11_TEX1D_RTV {
    MipSlice : UInt32
}
struct D3D11_TEX1D_ARRAY_RTV {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D11_TEX2D_RTV {
    MipSlice : UInt32
}
struct D3D11_TEX2DMS_RTV {
    UnusedField_NothingToDefine : UInt32
}
struct D3D11_TEX2D_ARRAY_RTV {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D11_TEX2DMS_ARRAY_RTV {
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D11_TEX3D_RTV {
    MipSlice : UInt32
    FirstWSlice : UInt32
    WSize : UInt32
}
struct D3D11_RENDER_TARGET_VIEW_DESC {
    Format : DXGI_FORMAT
    ViewDimension : D3D11_RTV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Buffer : D3D11_BUFFER_RTV
            Texture1D : D3D11_TEX1D_RTV
            Texture1DArray : D3D11_TEX1D_ARRAY_RTV
            Texture2D : D3D11_TEX2D_RTV
            Texture2DArray : D3D11_TEX2D_ARRAY_RTV
            Texture2DMS : D3D11_TEX2DMS_RTV
            Texture2DMSArray : D3D11_TEX2DMS_ARRAY_RTV
            Texture3D : D3D11_TEX3D_RTV
        }
    }
}
struct ID3D11RenderTargetView extends ID3D11View {
    static IID := "{DFDBA067-0B8D-4865-875B-D7B4516CC164}"
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D11_RENDER_TARGET_VIEW_DESC.Ptr, pDesc, "void")
}
struct D3D11_TEX1D_DSV {
    MipSlice : UInt32
}
struct D3D11_TEX1D_ARRAY_DSV {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D11_TEX2D_DSV {
    MipSlice : UInt32
}
struct D3D11_TEX2D_ARRAY_DSV {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D11_TEX2DMS_DSV {
    UnusedField_NothingToDefine : UInt32
}
struct D3D11_TEX2DMS_ARRAY_DSV {
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D11_DSV_FLAG extends Int32 {
    static D3D11_DSV_READ_ONLY_DEPTH := 1
    static D3D11_DSV_READ_ONLY_STENCIL := 2
}
struct D3D11_DEPTH_STENCIL_VIEW_DESC {
    Format : DXGI_FORMAT
    ViewDimension : D3D11_DSV_DIMENSION
    Flags : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Texture1D : D3D11_TEX1D_DSV
            Texture1DArray : D3D11_TEX1D_ARRAY_DSV
            Texture2D : D3D11_TEX2D_DSV
            Texture2DArray : D3D11_TEX2D_ARRAY_DSV
            Texture2DMS : D3D11_TEX2DMS_DSV
            Texture2DMSArray : D3D11_TEX2DMS_ARRAY_DSV
        }
    }
}
struct ID3D11DepthStencilView extends ID3D11View {
    static IID := "{9FDAC92A-1876-48C3-AFAD-25B94F84A9B6}"
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D11_DEPTH_STENCIL_VIEW_DESC.Ptr, pDesc, "void")
}
struct D3D11_BUFFER_UAV_FLAG extends Int32 {
    static D3D11_BUFFER_UAV_FLAG_RAW := 1
    static D3D11_BUFFER_UAV_FLAG_APPEND := 2
    static D3D11_BUFFER_UAV_FLAG_COUNTER := 4
}
struct D3D11_BUFFER_UAV {
    FirstElement : UInt32
    NumElements : UInt32
    Flags : UInt32
}
struct D3D11_TEX1D_UAV {
    MipSlice : UInt32
}
struct D3D11_TEX1D_ARRAY_UAV {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D11_TEX2D_UAV {
    MipSlice : UInt32
}
struct D3D11_TEX2D_ARRAY_UAV {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D11_TEX3D_UAV {
    MipSlice : UInt32
    FirstWSlice : UInt32
    WSize : UInt32
}
struct D3D11_UNORDERED_ACCESS_VIEW_DESC {
    Format : DXGI_FORMAT
    ViewDimension : D3D11_UAV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Buffer : D3D11_BUFFER_UAV
            Texture1D : D3D11_TEX1D_UAV
            Texture1DArray : D3D11_TEX1D_ARRAY_UAV
            Texture2D : D3D11_TEX2D_UAV
            Texture2DArray : D3D11_TEX2D_ARRAY_UAV
            Texture3D : D3D11_TEX3D_UAV
        }
    }
}
struct ID3D11UnorderedAccessView extends ID3D11View {
    static IID := "{28ACF509-7F5C-48F6-8611-F316010A6380}"
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D11_UNORDERED_ACCESS_VIEW_DESC.Ptr, pDesc, "void")
}
struct ID3D11VertexShader extends ID3D11DeviceChild {
    static IID := "{3B301D64-D678-4289-8897-22F8928B72F3}"
}
struct ID3D11HullShader extends ID3D11DeviceChild {
    static IID := "{8E5C6061-628A-4C8E-8264-BBE45CB3D5DD}"
}
struct ID3D11DomainShader extends ID3D11DeviceChild {
    static IID := "{F582C508-0F36-490C-9977-31EECE268CFA}"
}
struct ID3D11GeometryShader extends ID3D11DeviceChild {
    static IID := "{38325B96-EFFB-4022-BA02-2E795B70275C}"
}
struct ID3D11PixelShader extends ID3D11DeviceChild {
    static IID := "{EA82E40D-51DC-4F33-93D4-DB7C9125AE8C}"
}
struct ID3D11ComputeShader extends ID3D11DeviceChild {
    static IID := "{4F5B196E-C2BD-495E-BD01-1FDED38E4969}"
}
struct ID3D11InputLayout extends ID3D11DeviceChild {
    static IID := "{E4819DDC-4CF0-4025-BD26-5DE82A3E07B7}"
}
struct D3D11_FILTER extends Int32 {
    static D3D11_FILTER_MIN_MAG_MIP_POINT := 0
    static D3D11_FILTER_MIN_MAG_POINT_MIP_LINEAR := 1
    static D3D11_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT := 4
    static D3D11_FILTER_MIN_POINT_MAG_MIP_LINEAR := 5
    static D3D11_FILTER_MIN_LINEAR_MAG_MIP_POINT := 16
    static D3D11_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR := 17
    static D3D11_FILTER_MIN_MAG_LINEAR_MIP_POINT := 20
    static D3D11_FILTER_MIN_MAG_MIP_LINEAR := 21
    static D3D11_FILTER_ANISOTROPIC := 85
    static D3D11_FILTER_COMPARISON_MIN_MAG_MIP_POINT := 128
    static D3D11_FILTER_COMPARISON_MIN_MAG_POINT_MIP_LINEAR := 129
    static D3D11_FILTER_COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT := 132
    static D3D11_FILTER_COMPARISON_MIN_POINT_MAG_MIP_LINEAR := 133
    static D3D11_FILTER_COMPARISON_MIN_LINEAR_MAG_MIP_POINT := 144
    static D3D11_FILTER_COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR := 145
    static D3D11_FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT := 148
    static D3D11_FILTER_COMPARISON_MIN_MAG_MIP_LINEAR := 149
    static D3D11_FILTER_COMPARISON_ANISOTROPIC := 213
    static D3D11_FILTER_MINIMUM_MIN_MAG_MIP_POINT := 256
    static D3D11_FILTER_MINIMUM_MIN_MAG_POINT_MIP_LINEAR := 257
    static D3D11_FILTER_MINIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT := 260
    static D3D11_FILTER_MINIMUM_MIN_POINT_MAG_MIP_LINEAR := 261
    static D3D11_FILTER_MINIMUM_MIN_LINEAR_MAG_MIP_POINT := 272
    static D3D11_FILTER_MINIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR := 273
    static D3D11_FILTER_MINIMUM_MIN_MAG_LINEAR_MIP_POINT := 276
    static D3D11_FILTER_MINIMUM_MIN_MAG_MIP_LINEAR := 277
    static D3D11_FILTER_MINIMUM_ANISOTROPIC := 341
    static D3D11_FILTER_MAXIMUM_MIN_MAG_MIP_POINT := 384
    static D3D11_FILTER_MAXIMUM_MIN_MAG_POINT_MIP_LINEAR := 385
    static D3D11_FILTER_MAXIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT := 388
    static D3D11_FILTER_MAXIMUM_MIN_POINT_MAG_MIP_LINEAR := 389
    static D3D11_FILTER_MAXIMUM_MIN_LINEAR_MAG_MIP_POINT := 400
    static D3D11_FILTER_MAXIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR := 401
    static D3D11_FILTER_MAXIMUM_MIN_MAG_LINEAR_MIP_POINT := 404
    static D3D11_FILTER_MAXIMUM_MIN_MAG_MIP_LINEAR := 405
    static D3D11_FILTER_MAXIMUM_ANISOTROPIC := 469
}
struct D3D11_FILTER_TYPE extends Int32 {
    static D3D11_FILTER_TYPE_POINT := 0
    static D3D11_FILTER_TYPE_LINEAR := 1
}
struct D3D11_FILTER_REDUCTION_TYPE extends Int32 {
    static D3D11_FILTER_REDUCTION_TYPE_STANDARD := 0
    static D3D11_FILTER_REDUCTION_TYPE_COMPARISON := 1
    static D3D11_FILTER_REDUCTION_TYPE_MINIMUM := 2
    static D3D11_FILTER_REDUCTION_TYPE_MAXIMUM := 3
}
struct D3D11_TEXTURE_ADDRESS_MODE extends Int32 {
    static D3D11_TEXTURE_ADDRESS_WRAP := 1
    static D3D11_TEXTURE_ADDRESS_MIRROR := 2
    static D3D11_TEXTURE_ADDRESS_CLAMP := 3
    static D3D11_TEXTURE_ADDRESS_BORDER := 4
    static D3D11_TEXTURE_ADDRESS_MIRROR_ONCE := 5
}
struct D3D11_SAMPLER_DESC {
    Filter : D3D11_FILTER
    AddressU : D3D11_TEXTURE_ADDRESS_MODE
    AddressV : D3D11_TEXTURE_ADDRESS_MODE
    AddressW : D3D11_TEXTURE_ADDRESS_MODE
    MipLODBias : Float32
    MaxAnisotropy : UInt32
    ComparisonFunc : D3D11_COMPARISON_FUNC
    BorderColor : Float32[4]
    MinLOD : Float32
    MaxLOD : Float32
}
struct ID3D11SamplerState extends ID3D11DeviceChild {
    static IID := "{DA6FEA51-564C-4487-9810-F0D0F9B4E3A5}"
    GetDesc(pDesc)
      => ComCall(7, this.p, D3D11_SAMPLER_DESC.Ptr, pDesc, "void")
}
struct D3D11_FORMAT_SUPPORT extends Int32 {
    static D3D11_FORMAT_SUPPORT_BUFFER := 1
    static D3D11_FORMAT_SUPPORT_IA_VERTEX_BUFFER := 2
    static D3D11_FORMAT_SUPPORT_IA_INDEX_BUFFER := 4
    static D3D11_FORMAT_SUPPORT_SO_BUFFER := 8
    static D3D11_FORMAT_SUPPORT_TEXTURE1D := 16
    static D3D11_FORMAT_SUPPORT_TEXTURE2D := 32
    static D3D11_FORMAT_SUPPORT_TEXTURE3D := 64
    static D3D11_FORMAT_SUPPORT_TEXTURECUBE := 128
    static D3D11_FORMAT_SUPPORT_SHADER_LOAD := 256
    static D3D11_FORMAT_SUPPORT_SHADER_SAMPLE := 512
    static D3D11_FORMAT_SUPPORT_SHADER_SAMPLE_COMPARISON := 1024
    static D3D11_FORMAT_SUPPORT_SHADER_SAMPLE_MONO_TEXT := 2048
    static D3D11_FORMAT_SUPPORT_MIP := 4096
    static D3D11_FORMAT_SUPPORT_MIP_AUTOGEN := 8192
    static D3D11_FORMAT_SUPPORT_RENDER_TARGET := 16384
    static D3D11_FORMAT_SUPPORT_BLENDABLE := 32768
    static D3D11_FORMAT_SUPPORT_DEPTH_STENCIL := 65536
    static D3D11_FORMAT_SUPPORT_CPU_LOCKABLE := 131072
    static D3D11_FORMAT_SUPPORT_MULTISAMPLE_RESOLVE := 262144
    static D3D11_FORMAT_SUPPORT_DISPLAY := 524288
    static D3D11_FORMAT_SUPPORT_CAST_WITHIN_BIT_LAYOUT := 1048576
    static D3D11_FORMAT_SUPPORT_MULTISAMPLE_RENDERTARGET := 2097152
    static D3D11_FORMAT_SUPPORT_MULTISAMPLE_LOAD := 4194304
    static D3D11_FORMAT_SUPPORT_SHADER_GATHER := 8388608
    static D3D11_FORMAT_SUPPORT_BACK_BUFFER_CAST := 16777216
    static D3D11_FORMAT_SUPPORT_TYPED_UNORDERED_ACCESS_VIEW := 33554432
    static D3D11_FORMAT_SUPPORT_SHADER_GATHER_COMPARISON := 67108864
    static D3D11_FORMAT_SUPPORT_DECODER_OUTPUT := 134217728
    static D3D11_FORMAT_SUPPORT_VIDEO_PROCESSOR_OUTPUT := 268435456
    static D3D11_FORMAT_SUPPORT_VIDEO_PROCESSOR_INPUT := 536870912
    static D3D11_FORMAT_SUPPORT_VIDEO_ENCODER := 1073741824
}
struct D3D11_FORMAT_SUPPORT2 extends Int32 {
    static D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_ADD := 1
    static D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_BITWISE_OPS := 2
    static D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_COMPARE_STORE_OR_COMPARE_EXCHANGE := 4
    static D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_EXCHANGE := 8
    static D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_SIGNED_MIN_OR_MAX := 16
    static D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_UNSIGNED_MIN_OR_MAX := 32
    static D3D11_FORMAT_SUPPORT2_UAV_TYPED_LOAD := 64
    static D3D11_FORMAT_SUPPORT2_UAV_TYPED_STORE := 128
    static D3D11_FORMAT_SUPPORT2_OUTPUT_MERGER_LOGIC_OP := 256
    static D3D11_FORMAT_SUPPORT2_TILED := 512
    static D3D11_FORMAT_SUPPORT2_SHAREABLE := 1024
    static D3D11_FORMAT_SUPPORT2_MULTIPLANE_OVERLAY := 16384
    static D3D11_FORMAT_SUPPORT2_DISPLAYABLE := 65536
}
struct ID3D11Asynchronous extends ID3D11DeviceChild {
    static IID := "{4B35D0CD-1E15-4258-9C98-1B1333F6DD3B}"
    GetDataSize()
      => ComCall(7, this.p, UInt32)
}
struct D3D11_ASYNC_GETDATA_FLAG extends Int32 {
    static D3D11_ASYNC_GETDATA_DONOTFLUSH := 1
}
struct D3D11_QUERY extends Int32 {
    static D3D11_QUERY_EVENT := 0
    static D3D11_QUERY_OCCLUSION := 1
    static D3D11_QUERY_TIMESTAMP := 2
    static D3D11_QUERY_TIMESTAMP_DISJOINT := 3
    static D3D11_QUERY_PIPELINE_STATISTICS := 4
    static D3D11_QUERY_OCCLUSION_PREDICATE := 5
    static D3D11_QUERY_SO_STATISTICS := 6
    static D3D11_QUERY_SO_OVERFLOW_PREDICATE := 7
    static D3D11_QUERY_SO_STATISTICS_STREAM0 := 8
    static D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM0 := 9
    static D3D11_QUERY_SO_STATISTICS_STREAM1 := 10
    static D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM1 := 11
    static D3D11_QUERY_SO_STATISTICS_STREAM2 := 12
    static D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM2 := 13
    static D3D11_QUERY_SO_STATISTICS_STREAM3 := 14
    static D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM3 := 15
}
struct D3D11_QUERY_MISC_FLAG extends Int32 {
    static D3D11_QUERY_MISC_PREDICATEHINT := 1
}
struct D3D11_QUERY_DESC {
    Query : D3D11_QUERY
    MiscFlags : UInt32
}
struct ID3D11Query extends ID3D11Asynchronous {
    static IID := "{D6C00747-87B7-425E-B84D-44D108560AFD}"
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D11_QUERY_DESC.Ptr, pDesc, "void")
}
struct ID3D11Predicate extends ID3D11Query {
    static IID := "{9EB576DD-9F77-4D86-81AA-8BAB5FE490E2}"
}
struct D3D11_QUERY_DATA_TIMESTAMP_DISJOINT {
    Frequency : Int64
    Disjoint : BOOL
}
struct D3D11_QUERY_DATA_PIPELINE_STATISTICS {
    IAVertices : Int64
    IAPrimitives : Int64
    VSInvocations : Int64
    GSInvocations : Int64
    GSPrimitives : Int64
    CInvocations : Int64
    CPrimitives : Int64
    PSInvocations : Int64
    HSInvocations : Int64
    DSInvocations : Int64
    CSInvocations : Int64
}
struct D3D11_QUERY_DATA_SO_STATISTICS {
    NumPrimitivesWritten : Int64
    PrimitivesStorageNeeded : Int64
}
struct D3D11_COUNTER extends Int32 {
    static D3D11_COUNTER_DEVICE_DEPENDENT_0 := 1073741824
}
struct D3D11_COUNTER_TYPE extends Int32 {
    static D3D11_COUNTER_TYPE_FLOAT32 := 0
    static D3D11_COUNTER_TYPE_UINT16 := 1
    static D3D11_COUNTER_TYPE_UINT32 := 2
    static D3D11_COUNTER_TYPE_UINT64 := 3
}
struct D3D11_COUNTER_DESC {
    Counter : D3D11_COUNTER
    MiscFlags : UInt32
}
struct D3D11_COUNTER_INFO {
    LastDeviceDependentCounter : D3D11_COUNTER
    NumSimultaneousCounters : UInt32
    NumDetectableParallelUnits : UInt8
}
struct ID3D11Counter extends ID3D11Asynchronous {
    static IID := "{6E8C49FB-A371-4770-B440-29086022B741}"
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D11_COUNTER_DESC.Ptr, pDesc, "void")
}
struct D3D11_STANDARD_MULTISAMPLE_QUALITY_LEVELS extends Int32 {
    static D3D11_STANDARD_MULTISAMPLE_PATTERN := -1
    static D3D11_CENTER_MULTISAMPLE_PATTERN := -2
}
struct D3D11_DEVICE_CONTEXT_TYPE extends Int32 {
    static D3D11_DEVICE_CONTEXT_IMMEDIATE := 0
    static D3D11_DEVICE_CONTEXT_DEFERRED := 1
}
struct D3D11_CLASS_INSTANCE_DESC {
    InstanceId : UInt32
    InstanceIndex : UInt32
    TypeId : UInt32
    ConstantBuffer : UInt32
    BaseConstantBufferOffset : UInt32
    BaseTexture : UInt32
    BaseSampler : UInt32
    Created : BOOL
}
struct ID3D11ClassInstance extends ID3D11DeviceChild {
    static IID := "{A6CD7FAA-B0B7-4A2F-9436-8662A65797CB}"
    GetClassLinkage(ppLinkage)
      => ComCall(7, this.p, ID3D11ClassLinkage.Ptr, ppLinkage, "void")
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D11_CLASS_INSTANCE_DESC.Ptr, pDesc, "void")
    GetInstanceName(pInstanceName?)
      => ComCall(9, this.p, PSTR, pInstanceName?, IntPtr.Ptr, pInstanceName?.Length ?? 0, "void")
    GetTypeName(pTypeName?)
      => ComCall(10, this.p, PSTR, pTypeName?, IntPtr.Ptr, pTypeName?.Length ?? 0, "void")
}
struct ID3D11ClassLinkage extends ID3D11DeviceChild {
    static IID := "{DDF57CBA-9543-46E4-A12B-F207A0FE7FED}"
    GetClassInstance(pClassInstanceName, InstanceIndex, ppInstance)
      => ComCall(7, this.p, PSTR, pClassInstanceName, UInt32, InstanceIndex, ID3D11ClassInstance.Ptr, ppInstance)
    CreateClassInstance(pClassTypeName, ConstantBufferOffset, ConstantVectorOffset, TextureOffset, SamplerOffset, ppInstance)
      => ComCall(8, this.p, PSTR, pClassTypeName, UInt32, ConstantBufferOffset, UInt32, ConstantVectorOffset, UInt32, TextureOffset, UInt32, SamplerOffset, ID3D11ClassInstance.Ptr, ppInstance)
}
struct ID3D11CommandList extends ID3D11DeviceChild {
    static IID := "{A24BC4D1-769E-43F7-8013-98FF566C18E2}"
    GetContextFlags()
      => ComCall(7, this.p, UInt32)
}
struct D3D11_FEATURE extends Int32 {
    static D3D11_FEATURE_THREADING := 0
    static D3D11_FEATURE_DOUBLES := 1
    static D3D11_FEATURE_FORMAT_SUPPORT := 2
    static D3D11_FEATURE_FORMAT_SUPPORT2 := 3
    static D3D11_FEATURE_D3D10_X_HARDWARE_OPTIONS := 4
    static D3D11_FEATURE_D3D11_OPTIONS := 5
    static D3D11_FEATURE_ARCHITECTURE_INFO := 6
    static D3D11_FEATURE_D3D9_OPTIONS := 7
    static D3D11_FEATURE_SHADER_MIN_PRECISION_SUPPORT := 8
    static D3D11_FEATURE_D3D9_SHADOW_SUPPORT := 9
    static D3D11_FEATURE_D3D11_OPTIONS1 := 10
    static D3D11_FEATURE_D3D9_SIMPLE_INSTANCING_SUPPORT := 11
    static D3D11_FEATURE_MARKER_SUPPORT := 12
    static D3D11_FEATURE_D3D9_OPTIONS1 := 13
    static D3D11_FEATURE_D3D11_OPTIONS2 := 14
    static D3D11_FEATURE_D3D11_OPTIONS3 := 15
    static D3D11_FEATURE_GPU_VIRTUAL_ADDRESS_SUPPORT := 16
    static D3D11_FEATURE_D3D11_OPTIONS4 := 17
    static D3D11_FEATURE_SHADER_CACHE := 18
    static D3D11_FEATURE_D3D11_OPTIONS5 := 19
    static D3D11_FEATURE_DISPLAYABLE := 20
    static D3D11_FEATURE_D3D11_OPTIONS6 := 21
}
struct D3D11_FEATURE_DATA_THREADING {
    DriverConcurrentCreates : BOOL
    DriverCommandLists : BOOL
}
struct D3D11_FEATURE_DATA_DOUBLES {
    DoublePrecisionFloatShaderOps : BOOL
}
struct D3D11_FEATURE_DATA_FORMAT_SUPPORT {
    InFormat : DXGI_FORMAT
    OutFormatSupport : UInt32
}
struct D3D11_FEATURE_DATA_FORMAT_SUPPORT2 {
    InFormat : DXGI_FORMAT
    OutFormatSupport2 : UInt32
}
struct D3D11_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS {
    ComputeShaders_Plus_RawAndStructuredBuffers_Via_Shader_4_x : BOOL
}
struct D3D11_FEATURE_DATA_D3D11_OPTIONS {
    OutputMergerLogicOp : BOOL
    UAVOnlyRenderingForcedSampleCount : BOOL
    DiscardAPIsSeenByDriver : BOOL
    FlagsForUpdateAndCopySeenByDriver : BOOL
    ClearView : BOOL
    CopyWithOverlap : BOOL
    ConstantBufferPartialUpdate : BOOL
    ConstantBufferOffsetting : BOOL
    MapNoOverwriteOnDynamicConstantBuffer : BOOL
    MapNoOverwriteOnDynamicBufferSRV : BOOL
    MultisampleRTVWithForcedSampleCountOne : BOOL
    SAD4ShaderInstructions : BOOL
    ExtendedDoublesShaderInstructions : BOOL
    ExtendedResourceSharing : BOOL
}
struct D3D11_FEATURE_DATA_ARCHITECTURE_INFO {
    TileBasedDeferredRenderer : BOOL
}
struct D3D11_FEATURE_DATA_D3D9_OPTIONS {
    FullNonPow2TextureSupport : BOOL
}
struct D3D11_FEATURE_DATA_D3D9_SHADOW_SUPPORT {
    SupportsDepthAsTextureWithLessEqualComparisonFilter : BOOL
}
struct D3D11_SHADER_MIN_PRECISION_SUPPORT extends Int32 {
    static D3D11_SHADER_MIN_PRECISION_10_BIT := 1
    static D3D11_SHADER_MIN_PRECISION_16_BIT := 2
}
struct D3D11_FEATURE_DATA_SHADER_MIN_PRECISION_SUPPORT {
    PixelShaderMinPrecision : UInt32
    AllOtherShaderStagesMinPrecision : UInt32
}
struct D3D11_TILED_RESOURCES_TIER extends Int32 {
    static D3D11_TILED_RESOURCES_NOT_SUPPORTED := 0
    static D3D11_TILED_RESOURCES_TIER_1 := 1
    static D3D11_TILED_RESOURCES_TIER_2 := 2
    static D3D11_TILED_RESOURCES_TIER_3 := 3
}
struct D3D11_FEATURE_DATA_D3D11_OPTIONS1 {
    TiledResourcesTier : D3D11_TILED_RESOURCES_TIER
    MinMaxFiltering : BOOL
    ClearViewAlsoSupportsDepthOnlyFormats : BOOL
    MapOnDefaultBuffers : BOOL
}
struct D3D11_FEATURE_DATA_D3D9_SIMPLE_INSTANCING_SUPPORT {
    SimpleInstancingSupported : BOOL
}
struct D3D11_FEATURE_DATA_MARKER_SUPPORT {
    Profile : BOOL
}
struct D3D11_FEATURE_DATA_D3D9_OPTIONS1 {
    FullNonPow2TextureSupported : BOOL
    DepthAsTextureWithLessEqualComparisonFilterSupported : BOOL
    SimpleInstancingSupported : BOOL
    TextureCubeFaceRenderTargetWithNonCubeDepthStencilSupported : BOOL
}
struct D3D11_CONSERVATIVE_RASTERIZATION_TIER extends Int32 {
    static D3D11_CONSERVATIVE_RASTERIZATION_NOT_SUPPORTED := 0
    static D3D11_CONSERVATIVE_RASTERIZATION_TIER_1 := 1
    static D3D11_CONSERVATIVE_RASTERIZATION_TIER_2 := 2
    static D3D11_CONSERVATIVE_RASTERIZATION_TIER_3 := 3
}
struct D3D11_FEATURE_DATA_D3D11_OPTIONS2 {
    PSSpecifiedStencilRefSupported : BOOL
    TypedUAVLoadAdditionalFormats : BOOL
    ROVsSupported : BOOL
    ConservativeRasterizationTier : D3D11_CONSERVATIVE_RASTERIZATION_TIER
    TiledResourcesTier : D3D11_TILED_RESOURCES_TIER
    MapOnDefaultTextures : BOOL
    StandardSwizzle : BOOL
    UnifiedMemoryArchitecture : BOOL
}
struct D3D11_FEATURE_DATA_D3D11_OPTIONS3 {
    VPAndRTArrayIndexFromAnyShaderFeedingRasterizer : BOOL
}
struct D3D11_FEATURE_DATA_GPU_VIRTUAL_ADDRESS_SUPPORT {
    MaxGPUVirtualAddressBitsPerResource : UInt32
    MaxGPUVirtualAddressBitsPerProcess : UInt32
}
struct D3D11_SHADER_CACHE_SUPPORT_FLAGS extends Int32 {
    static D3D11_SHADER_CACHE_SUPPORT_NONE := 0
    static D3D11_SHADER_CACHE_SUPPORT_AUTOMATIC_INPROC_CACHE := 1
    static D3D11_SHADER_CACHE_SUPPORT_AUTOMATIC_DISK_CACHE := 2
}
struct D3D11_FEATURE_DATA_SHADER_CACHE {
    SupportFlags : UInt32
}
struct D3D11_SHARED_RESOURCE_TIER extends Int32 {
    static D3D11_SHARED_RESOURCE_TIER_0 := 0
    static D3D11_SHARED_RESOURCE_TIER_1 := 1
    static D3D11_SHARED_RESOURCE_TIER_2 := 2
    static D3D11_SHARED_RESOURCE_TIER_3 := 3
}
struct D3D11_FEATURE_DATA_DISPLAYABLE {
    DisplayableTexture : BOOL
    SharedResourceTier : D3D11_SHARED_RESOURCE_TIER
}
struct D3D11_FEATURE_DATA_D3D11_OPTIONS5 {
    SharedResourceTier : D3D11_SHARED_RESOURCE_TIER
}
struct D3D11_SHADER_ACCESS_RESTRICTED_RESOURCE_TIER extends Int32 {
    static D3D11_SHADER_ACCESS_RESTRICTED_RESOURCE_TIER_0 := 0
    static D3D11_SHADER_ACCESS_RESTRICTED_RESOURCE_TIER_1 := 1
}
struct D3D11_FEATURE_DATA_D3D11_OPTIONS6 {
    ShaderAccessRestrictedResourceTier : D3D11_SHADER_ACCESS_RESTRICTED_RESOURCE_TIER
}
struct ID3D11DeviceContext extends ID3D11DeviceChild {
    static IID := "{C0BFA96C-E089-44FB-8EAF-26F8796190DA}"
    VSSetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(7, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, "void")
    PSSetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(8, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D11ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    PSSetShader(pPixelShader?, ppClassInstances?)
      => ComCall(9, this.p, ID3D11PixelShader, pPixelShader?, ID3D11ClassInstance.Ptr, ppClassInstances?, UInt32, ppClassInstances?.Length ?? 0, "void")
    PSSetSamplers(StartSlot, ppSamplers?)
      => ComCall(10, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D11SamplerState.Ptr, ppSamplers?, "void")
    VSSetShader(pVertexShader?, ppClassInstances?)
      => ComCall(11, this.p, ID3D11VertexShader, pVertexShader?, ID3D11ClassInstance.Ptr, ppClassInstances?, UInt32, ppClassInstances?.Length ?? 0, "void")
    DrawIndexed(IndexCount, StartIndexLocation, BaseVertexLocation)
      => ComCall(12, this.p, UInt32, IndexCount, UInt32, StartIndexLocation, Int32, BaseVertexLocation, "void")
    Draw(VertexCount, StartVertexLocation)
      => ComCall(13, this.p, UInt32, VertexCount, UInt32, StartVertexLocation, "void")
    Map(pResource, Subresource, MapType, MapFlags, pMappedResource?)
      => ComCall(14, this.p, ID3D11Resource, pResource, UInt32, Subresource, D3D11_MAP, MapType, UInt32, MapFlags, D3D11_MAPPED_SUBRESOURCE.Ptr, pMappedResource?)
    Unmap(pResource, Subresource)
      => ComCall(15, this.p, ID3D11Resource, pResource, UInt32, Subresource, "void")
    PSSetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(16, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, "void")
    IASetInputLayout(pInputLayout?)
      => ComCall(17, this.p, ID3D11InputLayout, pInputLayout?, "void")
    IASetVertexBuffers(StartSlot, ppVertexBuffers?, pStrides?, pOffsets?)
      => ComCall(18, this.p, UInt32, StartSlot, UInt32, pOffsets?.Length ?? 0, ID3D11Buffer.Ptr, ppVertexBuffers?, UInt32.Ptr, pStrides?, UInt32.Ptr, pOffsets?, "void")
    IASetIndexBuffer(pIndexBuffer?, Format, Offset)
      => ComCall(19, this.p, ID3D11Buffer, pIndexBuffer?, DXGI_FORMAT, Format, UInt32, Offset, "void")
    DrawIndexedInstanced(IndexCountPerInstance, InstanceCount, StartIndexLocation, BaseVertexLocation, StartInstanceLocation)
      => ComCall(20, this.p, UInt32, IndexCountPerInstance, UInt32, InstanceCount, UInt32, StartIndexLocation, Int32, BaseVertexLocation, UInt32, StartInstanceLocation, "void")
    DrawInstanced(VertexCountPerInstance, InstanceCount, StartVertexLocation, StartInstanceLocation)
      => ComCall(21, this.p, UInt32, VertexCountPerInstance, UInt32, InstanceCount, UInt32, StartVertexLocation, UInt32, StartInstanceLocation, "void")
    GSSetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(22, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, "void")
    GSSetShader(pShader?, ppClassInstances?)
      => ComCall(23, this.p, ID3D11GeometryShader, pShader?, ID3D11ClassInstance.Ptr, ppClassInstances?, UInt32, ppClassInstances?.Length ?? 0, "void")
    IASetPrimitiveTopology(Topology)
      => ComCall(24, this.p, D3D_PRIMITIVE_TOPOLOGY, Topology, "void")
    VSSetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(25, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D11ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    VSSetSamplers(StartSlot, ppSamplers?)
      => ComCall(26, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D11SamplerState.Ptr, ppSamplers?, "void")
    Begin(pAsync)
      => ComCall(27, this.p, ID3D11Asynchronous, pAsync, "void")
    End(pAsync)
      => ComCall(28, this.p, ID3D11Asynchronous, pAsync, "void")
    GetData(pAsync, pData?, GetDataFlags)
      => ComCall(29, this.p, ID3D11Asynchronous, pAsync, Struct.Ptr, pData?, UInt32, pData?.Size ?? 0, UInt32, GetDataFlags)
    SetPredication(pPredicate?, PredicateValue)
      => ComCall(30, this.p, ID3D11Predicate, pPredicate?, BOOL, PredicateValue, "void")
    GSSetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(31, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D11ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    GSSetSamplers(StartSlot, ppSamplers?)
      => ComCall(32, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D11SamplerState.Ptr, ppSamplers?, "void")
    OMSetRenderTargets(ppRenderTargetViews?, pDepthStencilView?)
      => ComCall(33, this.p, UInt32, ppRenderTargetViews?.Length ?? 0, ID3D11RenderTargetView.Ptr, ppRenderTargetViews?, ID3D11DepthStencilView, pDepthStencilView?, "void")
    OMSetRenderTargetsAndUnorderedAccessViews(ppRenderTargetViews?, pDepthStencilView?, UAVStartSlot, ppUnorderedAccessViews?, pUAVInitialCounts?)
      => ComCall(34, this.p, UInt32, ppRenderTargetViews?.Length ?? 0, ID3D11RenderTargetView.Ptr, ppRenderTargetViews?, ID3D11DepthStencilView, pDepthStencilView?, UInt32, UAVStartSlot, UInt32, pUAVInitialCounts?.Length ?? 0, ID3D11UnorderedAccessView.Ptr, ppUnorderedAccessViews?, UInt32.Ptr, pUAVInitialCounts?, "void")
    OMSetBlendState(pBlendState?, BlendFactor?, SampleMask)
      => ComCall(35, this.p, ID3D11BlendState, pBlendState?, Float32.Ptr, BlendFactor?, UInt32, SampleMask, "void")
    OMSetDepthStencilState(pDepthStencilState?, StencilRef)
      => ComCall(36, this.p, ID3D11DepthStencilState, pDepthStencilState?, UInt32, StencilRef, "void")
    SOSetTargets(ppSOTargets?, pOffsets?)
      => ComCall(37, this.p, UInt32, pOffsets?.Length ?? 0, ID3D11Buffer.Ptr, ppSOTargets?, UInt32.Ptr, pOffsets?, "void")
    DrawAuto()
      => ComCall(38, this.p, "void")
    DrawIndexedInstancedIndirect(pBufferForArgs, AlignedByteOffsetForArgs)
      => ComCall(39, this.p, ID3D11Buffer, pBufferForArgs, UInt32, AlignedByteOffsetForArgs, "void")
    DrawInstancedIndirect(pBufferForArgs, AlignedByteOffsetForArgs)
      => ComCall(40, this.p, ID3D11Buffer, pBufferForArgs, UInt32, AlignedByteOffsetForArgs, "void")
    Dispatch(ThreadGroupCountX, ThreadGroupCountY, ThreadGroupCountZ)
      => ComCall(41, this.p, UInt32, ThreadGroupCountX, UInt32, ThreadGroupCountY, UInt32, ThreadGroupCountZ, "void")
    DispatchIndirect(pBufferForArgs, AlignedByteOffsetForArgs)
      => ComCall(42, this.p, ID3D11Buffer, pBufferForArgs, UInt32, AlignedByteOffsetForArgs, "void")
    RSSetState(pRasterizerState?)
      => ComCall(43, this.p, ID3D11RasterizerState, pRasterizerState?, "void")
    RSSetViewports(pViewports?)
      => ComCall(44, this.p, UInt32, pViewports?.Length ?? 0, D3D11_VIEWPORT.Ptr, pViewports?, "void")
    RSSetScissorRects(pRects?)
      => ComCall(45, this.p, UInt32, pRects?.Length ?? 0, RECT.Ptr, pRects?, "void")
    CopySubresourceRegion(pDstResource, DstSubresource, DstX, DstY, DstZ, pSrcResource, SrcSubresource, pSrcBox?)
      => ComCall(46, this.p, ID3D11Resource, pDstResource, UInt32, DstSubresource, UInt32, DstX, UInt32, DstY, UInt32, DstZ, ID3D11Resource, pSrcResource, UInt32, SrcSubresource, D3D11_BOX.Ptr, pSrcBox?, "void")
    CopyResource(pDstResource, pSrcResource)
      => ComCall(47, this.p, ID3D11Resource, pDstResource, ID3D11Resource, pSrcResource, "void")
    UpdateSubresource(pDstResource, DstSubresource, pDstBox?, pSrcData, SrcRowPitch, SrcDepthPitch)
      => ComCall(48, this.p, ID3D11Resource, pDstResource, UInt32, DstSubresource, D3D11_BOX.Ptr, pDstBox?, Struct.Ptr, pSrcData, UInt32, SrcRowPitch, UInt32, SrcDepthPitch, "void")
    CopyStructureCount(pDstBuffer, DstAlignedByteOffset, pSrcView)
      => ComCall(49, this.p, ID3D11Buffer, pDstBuffer, UInt32, DstAlignedByteOffset, ID3D11UnorderedAccessView, pSrcView, "void")
    ClearRenderTargetView(pRenderTargetView, ColorRGBA)
      => ComCall(50, this.p, ID3D11RenderTargetView, pRenderTargetView, Float32.Ptr, ColorRGBA, "void")
    ClearUnorderedAccessViewUint(pUnorderedAccessView, Values)
      => ComCall(51, this.p, ID3D11UnorderedAccessView, pUnorderedAccessView, UInt32.Ptr, Values, "void")
    ClearUnorderedAccessViewFloat(pUnorderedAccessView, Values)
      => ComCall(52, this.p, ID3D11UnorderedAccessView, pUnorderedAccessView, Float32.Ptr, Values, "void")
    ClearDepthStencilView(pDepthStencilView, ClearFlags, Depth, Stencil)
      => ComCall(53, this.p, ID3D11DepthStencilView, pDepthStencilView, UInt32, ClearFlags, Float32, Depth, UInt8, Stencil, "void")
    GenerateMips(pShaderResourceView)
      => ComCall(54, this.p, ID3D11ShaderResourceView, pShaderResourceView, "void")
    SetResourceMinLOD(pResource, MinLOD)
      => ComCall(55, this.p, ID3D11Resource, pResource, Float32, MinLOD, "void")
    GetResourceMinLOD(pResource)
      => ComCall(56, this.p, ID3D11Resource, pResource, Float32)
    ResolveSubresource(pDstResource, DstSubresource, pSrcResource, SrcSubresource, Format)
      => ComCall(57, this.p, ID3D11Resource, pDstResource, UInt32, DstSubresource, ID3D11Resource, pSrcResource, UInt32, SrcSubresource, DXGI_FORMAT, Format, "void")
    ExecuteCommandList(pCommandList, RestoreContextState)
      => ComCall(58, this.p, ID3D11CommandList, pCommandList, BOOL, RestoreContextState, "void")
    HSSetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(59, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D11ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    HSSetShader(pHullShader?, ppClassInstances?)
      => ComCall(60, this.p, ID3D11HullShader, pHullShader?, ID3D11ClassInstance.Ptr, ppClassInstances?, UInt32, ppClassInstances?.Length ?? 0, "void")
    HSSetSamplers(StartSlot, ppSamplers?)
      => ComCall(61, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D11SamplerState.Ptr, ppSamplers?, "void")
    HSSetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(62, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, "void")
    DSSetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(63, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D11ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    DSSetShader(pDomainShader?, ppClassInstances?)
      => ComCall(64, this.p, ID3D11DomainShader, pDomainShader?, ID3D11ClassInstance.Ptr, ppClassInstances?, UInt32, ppClassInstances?.Length ?? 0, "void")
    DSSetSamplers(StartSlot, ppSamplers?)
      => ComCall(65, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D11SamplerState.Ptr, ppSamplers?, "void")
    DSSetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(66, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, "void")
    CSSetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(67, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D11ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    CSSetUnorderedAccessViews(StartSlot, ppUnorderedAccessViews?, pUAVInitialCounts?)
      => ComCall(68, this.p, UInt32, StartSlot, UInt32, pUAVInitialCounts?.Length ?? 0, ID3D11UnorderedAccessView.Ptr, ppUnorderedAccessViews?, UInt32.Ptr, pUAVInitialCounts?, "void")
    CSSetShader(pComputeShader?, ppClassInstances?)
      => ComCall(69, this.p, ID3D11ComputeShader, pComputeShader?, ID3D11ClassInstance.Ptr, ppClassInstances?, UInt32, ppClassInstances?.Length ?? 0, "void")
    CSSetSamplers(StartSlot, ppSamplers?)
      => ComCall(70, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D11SamplerState.Ptr, ppSamplers?, "void")
    CSSetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(71, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, "void")
    VSGetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(72, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, "void")
    PSGetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(73, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D11ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    PSGetShader(ppPixelShader, ppClassInstances?)
      => ComCall(74, this.p, ID3D11PixelShader.Ptr, ppPixelShader, ID3D11ClassInstance.Ptr, ppClassInstances?, UInt32.Ptr, ppClassInstances?.Length ?? 0, "void")
    PSGetSamplers(StartSlot, ppSamplers?)
      => ComCall(75, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D11SamplerState.Ptr, ppSamplers?, "void")
    VSGetShader(ppVertexShader, ppClassInstances?)
      => ComCall(76, this.p, ID3D11VertexShader.Ptr, ppVertexShader, ID3D11ClassInstance.Ptr, ppClassInstances?, UInt32.Ptr, ppClassInstances?.Length ?? 0, "void")
    PSGetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(77, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, "void")
    IAGetInputLayout(ppInputLayout)
      => ComCall(78, this.p, ID3D11InputLayout.Ptr, ppInputLayout, "void")
    IAGetVertexBuffers(StartSlot, ppVertexBuffers?, pStrides?, pOffsets?)
      => ComCall(79, this.p, UInt32, StartSlot, UInt32, pOffsets?.Length ?? 0, ID3D11Buffer.Ptr, ppVertexBuffers?, UInt32.Ptr, pStrides?, UInt32.Ptr, pOffsets?, "void")
    IAGetIndexBuffer(pIndexBuffer?, Format?, Offset?)
      => ComCall(80, this.p, ID3D11Buffer.Ptr, pIndexBuffer?, DXGI_FORMAT.Ptr, Format?, UInt32.Ptr, Offset?, "void")
    GSGetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(81, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, "void")
    GSGetShader(ppGeometryShader, ppClassInstances?)
      => ComCall(82, this.p, ID3D11GeometryShader.Ptr, ppGeometryShader, ID3D11ClassInstance.Ptr, ppClassInstances?, UInt32.Ptr, ppClassInstances?.Length ?? 0, "void")
    IAGetPrimitiveTopology(pTopology)
      => ComCall(83, this.p, D3D_PRIMITIVE_TOPOLOGY.Ptr, pTopology, "void")
    VSGetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(84, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D11ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    VSGetSamplers(StartSlot, ppSamplers?)
      => ComCall(85, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D11SamplerState.Ptr, ppSamplers?, "void")
    GetPredication(ppPredicate?, pPredicateValue?)
      => ComCall(86, this.p, ID3D11Predicate.Ptr, ppPredicate?, BOOL.Ptr, pPredicateValue?, "void")
    GSGetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(87, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D11ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    GSGetSamplers(StartSlot, ppSamplers?)
      => ComCall(88, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D11SamplerState.Ptr, ppSamplers?, "void")
    OMGetRenderTargets(ppRenderTargetViews?, ppDepthStencilView?)
      => ComCall(89, this.p, UInt32, ppRenderTargetViews?.Length ?? 0, ID3D11RenderTargetView.Ptr, ppRenderTargetViews?, ID3D11DepthStencilView.Ptr, ppDepthStencilView?, "void")
    OMGetRenderTargetsAndUnorderedAccessViews(ppRenderTargetViews?, ppDepthStencilView?, UAVStartSlot, ppUnorderedAccessViews?)
      => ComCall(90, this.p, UInt32, ppRenderTargetViews?.Length ?? 0, ID3D11RenderTargetView.Ptr, ppRenderTargetViews?, ID3D11DepthStencilView.Ptr, ppDepthStencilView?, UInt32, UAVStartSlot, UInt32, ppUnorderedAccessViews?.Length ?? 0, ID3D11UnorderedAccessView.Ptr, ppUnorderedAccessViews?, "void")
    OMGetBlendState(ppBlendState?, BlendFactor?, pSampleMask?)
      => ComCall(91, this.p, ID3D11BlendState.Ptr, ppBlendState?, Float32.Ptr, BlendFactor?, UInt32.Ptr, pSampleMask?, "void")
    OMGetDepthStencilState(ppDepthStencilState?, pStencilRef?)
      => ComCall(92, this.p, ID3D11DepthStencilState.Ptr, ppDepthStencilState?, UInt32.Ptr, pStencilRef?, "void")
    SOGetTargets(ppSOTargets?)
      => ComCall(93, this.p, UInt32, ppSOTargets?.Length ?? 0, ID3D11Buffer.Ptr, ppSOTargets?, "void")
    RSGetState(ppRasterizerState)
      => ComCall(94, this.p, ID3D11RasterizerState.Ptr, ppRasterizerState, "void")
    RSGetViewports(pViewports?)
      => ComCall(95, this.p, UInt32.Ptr, pViewports?.Length ?? 0, D3D11_VIEWPORT.Ptr, pViewports?, "void")
    RSGetScissorRects(pRects?)
      => ComCall(96, this.p, UInt32.Ptr, pRects?.Length ?? 0, RECT.Ptr, pRects?, "void")
    HSGetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(97, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D11ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    HSGetShader(ppHullShader, ppClassInstances?)
      => ComCall(98, this.p, ID3D11HullShader.Ptr, ppHullShader, ID3D11ClassInstance.Ptr, ppClassInstances?, UInt32.Ptr, ppClassInstances?.Length ?? 0, "void")
    HSGetSamplers(StartSlot, ppSamplers?)
      => ComCall(99, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D11SamplerState.Ptr, ppSamplers?, "void")
    HSGetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(100, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, "void")
    DSGetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(101, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D11ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    DSGetShader(ppDomainShader, ppClassInstances?)
      => ComCall(102, this.p, ID3D11DomainShader.Ptr, ppDomainShader, ID3D11ClassInstance.Ptr, ppClassInstances?, UInt32.Ptr, ppClassInstances?.Length ?? 0, "void")
    DSGetSamplers(StartSlot, ppSamplers?)
      => ComCall(103, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D11SamplerState.Ptr, ppSamplers?, "void")
    DSGetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(104, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, "void")
    CSGetShaderResources(StartSlot, ppShaderResourceViews?)
      => ComCall(105, this.p, UInt32, StartSlot, UInt32, ppShaderResourceViews?.Length ?? 0, ID3D11ShaderResourceView.Ptr, ppShaderResourceViews?, "void")
    CSGetUnorderedAccessViews(StartSlot, ppUnorderedAccessViews?)
      => ComCall(106, this.p, UInt32, StartSlot, UInt32, ppUnorderedAccessViews?.Length ?? 0, ID3D11UnorderedAccessView.Ptr, ppUnorderedAccessViews?, "void")
    CSGetShader(ppComputeShader, ppClassInstances?)
      => ComCall(107, this.p, ID3D11ComputeShader.Ptr, ppComputeShader, ID3D11ClassInstance.Ptr, ppClassInstances?, UInt32.Ptr, ppClassInstances?.Length ?? 0, "void")
    CSGetSamplers(StartSlot, ppSamplers?)
      => ComCall(108, this.p, UInt32, StartSlot, UInt32, ppSamplers?.Length ?? 0, ID3D11SamplerState.Ptr, ppSamplers?, "void")
    CSGetConstantBuffers(StartSlot, ppConstantBuffers?)
      => ComCall(109, this.p, UInt32, StartSlot, UInt32, ppConstantBuffers?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, "void")
    ClearState()
      => ComCall(110, this.p, "void")
    Flush()
      => ComCall(111, this.p, "void")
    GetType()
      => ComCall(112, this.p, D3D11_DEVICE_CONTEXT_TYPE)
    GetContextFlags()
      => ComCall(113, this.p, UInt32)
    FinishCommandList(RestoreDeferredContextState, ppCommandList?)
      => ComCall(114, this.p, BOOL, RestoreDeferredContextState, ID3D11CommandList.Ptr, ppCommandList?)
}
struct D3D11_VIDEO_DECODER_DESC {
    Guid : GUID
    SampleWidth : UInt32
    SampleHeight : UInt32
    OutputFormat : DXGI_FORMAT
}
struct D3D11_VIDEO_DECODER_CONFIG {
    guidConfigBitstreamEncryption : GUID
    guidConfigMBcontrolEncryption : GUID
    guidConfigResidDiffEncryption : GUID
    ConfigBitstreamRaw : UInt32
    ConfigMBcontrolRasterOrder : UInt32
    ConfigResidDiffHost : UInt32
    ConfigSpatialResid8 : UInt32
    ConfigResid8Subtraction : UInt32
    ConfigSpatialHost8or9Clipping : UInt32
    ConfigSpatialResidInterleaved : UInt32
    ConfigIntraResidUnsigned : UInt32
    ConfigResidDiffAccelerator : UInt32
    ConfigHostInverseScan : UInt32
    ConfigSpecificIDCT : UInt32
    Config4GroupedCoefs : UInt32
    ConfigMinRenderTargetBuffCount : UInt16
    ConfigDecoderSpecific : UInt16
}
struct D3D11_VIDEO_DECODER_BUFFER_TYPE extends Int32 {
    static D3D11_VIDEO_DECODER_BUFFER_PICTURE_PARAMETERS := 0
    static D3D11_VIDEO_DECODER_BUFFER_MACROBLOCK_CONTROL := 1
    static D3D11_VIDEO_DECODER_BUFFER_RESIDUAL_DIFFERENCE := 2
    static D3D11_VIDEO_DECODER_BUFFER_DEBLOCKING_CONTROL := 3
    static D3D11_VIDEO_DECODER_BUFFER_INVERSE_QUANTIZATION_MATRIX := 4
    static D3D11_VIDEO_DECODER_BUFFER_SLICE_CONTROL := 5
    static D3D11_VIDEO_DECODER_BUFFER_BITSTREAM := 6
    static D3D11_VIDEO_DECODER_BUFFER_MOTION_VECTOR := 7
    static D3D11_VIDEO_DECODER_BUFFER_FILM_GRAIN := 8
    static D3D11_VIDEO_DECODER_BUFFER_HUFFMAN_TABLE := 9
}
struct D3D11_AES_CTR_IV {
    IV : Int64
    Count : Int64
}
struct D3D11_ENCRYPTED_BLOCK_INFO {
    NumEncryptedBytesAtBeginning : UInt32
    NumBytesInSkipPattern : UInt32
    NumBytesInEncryptPattern : UInt32
}
struct D3D11_VIDEO_DECODER_BUFFER_DESC {
    BufferType : D3D11_VIDEO_DECODER_BUFFER_TYPE
    BufferIndex : UInt32
    DataOffset : UInt32
    DataSize : UInt32
    FirstMBaddress : UInt32
    NumMBsInBuffer : UInt32
    Width : UInt32
    Height : UInt32
    Stride : UInt32
    ReservedBits : UInt32
    pIV : Struct.Ptr
    IVSize : UInt32
    PartialEncryption : BOOL
    EncryptedBlockInfo : D3D11_ENCRYPTED_BLOCK_INFO
}
struct D3D11_VIDEO_DECODER_EXTENSION {
    Function : UInt32
    pPrivateInputData : Struct.Ptr
    PrivateInputDataSize : UInt32
    pPrivateOutputData : Struct.Ptr
    PrivateOutputDataSize : UInt32
    ResourceCount : UInt32
    ppResourceList : ID3D11Resource.Ptr
}
struct ID3D11VideoDecoder extends ID3D11DeviceChild {
    static IID := "{3C9C5B51-995D-48D1-9B8D-FA5CAEDED65C}"
    GetCreationParameters(pVideoDesc, pConfig)
      => ComCall(7, this.p, D3D11_VIDEO_DECODER_DESC.Ptr, pVideoDesc, D3D11_VIDEO_DECODER_CONFIG.Ptr, pConfig)
    GetDriverHandle(pDriverHandle)
      => ComCall(8, this.p, HANDLE.Ptr, pDriverHandle)
}
struct D3D11_VIDEO_PROCESSOR_FORMAT_SUPPORT extends Int32 {
    static D3D11_VIDEO_PROCESSOR_FORMAT_SUPPORT_INPUT := 1
    static D3D11_VIDEO_PROCESSOR_FORMAT_SUPPORT_OUTPUT := 2
}
struct D3D11_VIDEO_PROCESSOR_DEVICE_CAPS extends Int32 {
    static D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_LINEAR_SPACE := 1
    static D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_xvYCC := 2
    static D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_RGB_RANGE_CONVERSION := 4
    static D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_YCbCr_MATRIX_CONVERSION := 8
    static D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_NOMINAL_RANGE := 16
}
struct D3D11_VIDEO_PROCESSOR_FEATURE_CAPS extends Int32 {
    static D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ALPHA_FILL := 1
    static D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_CONSTRICTION := 2
    static D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_LUMA_KEY := 4
    static D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ALPHA_PALETTE := 8
    static D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_LEGACY := 16
    static D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_STEREO := 32
    static D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ROTATION := 64
    static D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ALPHA_STREAM := 128
    static D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_PIXEL_ASPECT_RATIO := 256
    static D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_MIRROR := 512
    static D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_SHADER_USAGE := 1024
    static D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_METADATA_HDR10 := 2048
}
struct D3D11_VIDEO_PROCESSOR_FILTER_CAPS extends Int32 {
    static D3D11_VIDEO_PROCESSOR_FILTER_CAPS_BRIGHTNESS := 1
    static D3D11_VIDEO_PROCESSOR_FILTER_CAPS_CONTRAST := 2
    static D3D11_VIDEO_PROCESSOR_FILTER_CAPS_HUE := 4
    static D3D11_VIDEO_PROCESSOR_FILTER_CAPS_SATURATION := 8
    static D3D11_VIDEO_PROCESSOR_FILTER_CAPS_NOISE_REDUCTION := 16
    static D3D11_VIDEO_PROCESSOR_FILTER_CAPS_EDGE_ENHANCEMENT := 32
    static D3D11_VIDEO_PROCESSOR_FILTER_CAPS_ANAMORPHIC_SCALING := 64
    static D3D11_VIDEO_PROCESSOR_FILTER_CAPS_STEREO_ADJUSTMENT := 128
}
struct D3D11_VIDEO_PROCESSOR_FORMAT_CAPS extends Int32 {
    static D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_RGB_INTERLACED := 1
    static D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_RGB_PROCAMP := 2
    static D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_RGB_LUMA_KEY := 4
    static D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_PALETTE_INTERLACED := 8
}
struct D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS extends Int32 {
    static D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_DENOISE := 1
    static D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_DERINGING := 2
    static D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_EDGE_ENHANCEMENT := 4
    static D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_COLOR_CORRECTION := 8
    static D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_FLESH_TONE_MAPPING := 16
    static D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_IMAGE_STABILIZATION := 32
    static D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_SUPER_RESOLUTION := 64
    static D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_ANAMORPHIC_SCALING := 128
}
struct D3D11_VIDEO_PROCESSOR_STEREO_CAPS extends Int32 {
    static D3D11_VIDEO_PROCESSOR_STEREO_CAPS_MONO_OFFSET := 1
    static D3D11_VIDEO_PROCESSOR_STEREO_CAPS_ROW_INTERLEAVED := 2
    static D3D11_VIDEO_PROCESSOR_STEREO_CAPS_COLUMN_INTERLEAVED := 4
    static D3D11_VIDEO_PROCESSOR_STEREO_CAPS_CHECKERBOARD := 8
    static D3D11_VIDEO_PROCESSOR_STEREO_CAPS_FLIP_MODE := 16
}
struct D3D11_VIDEO_PROCESSOR_CAPS {
    DeviceCaps : UInt32
    FeatureCaps : UInt32
    FilterCaps : UInt32
    InputFormatCaps : UInt32
    AutoStreamCaps : UInt32
    StereoCaps : UInt32
    RateConversionCapsCount : UInt32
    MaxInputStreams : UInt32
    MaxStreamStates : UInt32
}
struct D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS extends Int32 {
    static D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_BLEND := 1
    static D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_BOB := 2
    static D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_ADAPTIVE := 4
    static D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_MOTION_COMPENSATION := 8
    static D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_INVERSE_TELECINE := 16
    static D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_FRAME_RATE_CONVERSION := 32
}
struct D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS extends Int32 {
    static D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_32 := 1
    static D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_22 := 2
    static D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_2224 := 4
    static D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_2332 := 8
    static D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_32322 := 16
    static D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_55 := 32
    static D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_64 := 64
    static D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_87 := 128
    static D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_222222222223 := 256
    static D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_OTHER := -2147483648
}
struct D3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS {
    PastFrames : UInt32
    FutureFrames : UInt32
    ProcessorCaps : UInt32
    ITelecineCaps : UInt32
    CustomRateCount : UInt32
}
struct D3D11_CONTENT_PROTECTION_CAPS extends Int32 {
    static D3D11_CONTENT_PROTECTION_CAPS_SOFTWARE := 1
    static D3D11_CONTENT_PROTECTION_CAPS_HARDWARE := 2
    static D3D11_CONTENT_PROTECTION_CAPS_PROTECTION_ALWAYS_ON := 4
    static D3D11_CONTENT_PROTECTION_CAPS_PARTIAL_DECRYPTION := 8
    static D3D11_CONTENT_PROTECTION_CAPS_CONTENT_KEY := 16
    static D3D11_CONTENT_PROTECTION_CAPS_FRESHEN_SESSION_KEY := 32
    static D3D11_CONTENT_PROTECTION_CAPS_ENCRYPTED_READ_BACK := 64
    static D3D11_CONTENT_PROTECTION_CAPS_ENCRYPTED_READ_BACK_KEY := 128
    static D3D11_CONTENT_PROTECTION_CAPS_SEQUENTIAL_CTR_IV := 256
    static D3D11_CONTENT_PROTECTION_CAPS_ENCRYPT_SLICEDATA_ONLY := 512
    static D3D11_CONTENT_PROTECTION_CAPS_DECRYPTION_BLT := 1024
    static D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_PROTECT_UNCOMPRESSED := 2048
    static D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_PROTECTED_MEMORY_PAGEABLE := 4096
    static D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_TEARDOWN := 8192
    static D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_DRM_COMMUNICATION := 16384
    static D3D11_CONTENT_PROTECTION_CAPS_HARDWARE_DRM_COMMUNICATION_MULTI_THREADED := 32768
}
struct D3D11_VIDEO_CONTENT_PROTECTION_CAPS {
    Caps : UInt32
    KeyExchangeTypeCount : UInt32
    BlockAlignmentSize : UInt32
    ProtectedMemorySize : Int64
}
struct D3D11_VIDEO_PROCESSOR_CUSTOM_RATE {
    CustomRate : DXGI_RATIONAL
    OutputFrames : UInt32
    InputInterlaced : BOOL
    InputFramesOrFields : UInt32
}
struct D3D11_VIDEO_PROCESSOR_FILTER extends Int32 {
    static D3D11_VIDEO_PROCESSOR_FILTER_BRIGHTNESS := 0
    static D3D11_VIDEO_PROCESSOR_FILTER_CONTRAST := 1
    static D3D11_VIDEO_PROCESSOR_FILTER_HUE := 2
    static D3D11_VIDEO_PROCESSOR_FILTER_SATURATION := 3
    static D3D11_VIDEO_PROCESSOR_FILTER_NOISE_REDUCTION := 4
    static D3D11_VIDEO_PROCESSOR_FILTER_EDGE_ENHANCEMENT := 5
    static D3D11_VIDEO_PROCESSOR_FILTER_ANAMORPHIC_SCALING := 6
    static D3D11_VIDEO_PROCESSOR_FILTER_STEREO_ADJUSTMENT := 7
}
struct D3D11_VIDEO_PROCESSOR_FILTER_RANGE {
    Minimum : Int32
    Maximum : Int32
    Default : Int32
    Multiplier : Float32
}
struct D3D11_VIDEO_FRAME_FORMAT extends Int32 {
    static D3D11_VIDEO_FRAME_FORMAT_PROGRESSIVE := 0
    static D3D11_VIDEO_FRAME_FORMAT_INTERLACED_TOP_FIELD_FIRST := 1
    static D3D11_VIDEO_FRAME_FORMAT_INTERLACED_BOTTOM_FIELD_FIRST := 2
}
struct D3D11_VIDEO_USAGE extends Int32 {
    static D3D11_VIDEO_USAGE_PLAYBACK_NORMAL := 0
    static D3D11_VIDEO_USAGE_OPTIMAL_SPEED := 1
    static D3D11_VIDEO_USAGE_OPTIMAL_QUALITY := 2
}
struct D3D11_VIDEO_PROCESSOR_CONTENT_DESC {
    InputFrameFormat : D3D11_VIDEO_FRAME_FORMAT
    InputFrameRate : DXGI_RATIONAL
    InputWidth : UInt32
    InputHeight : UInt32
    OutputFrameRate : DXGI_RATIONAL
    OutputWidth : UInt32
    OutputHeight : UInt32
    Usage : D3D11_VIDEO_USAGE
}
struct ID3D11VideoProcessorEnumerator extends ID3D11DeviceChild {
    static IID := "{31627037-53AB-4200-9061-05FAA9AB45F9}"
    GetVideoProcessorContentDesc(pContentDesc)
      => ComCall(7, this.p, D3D11_VIDEO_PROCESSOR_CONTENT_DESC.Ptr, pContentDesc)
    CheckVideoProcessorFormat(Format, pFlags)
      => ComCall(8, this.p, DXGI_FORMAT, Format, UInt32.Ptr, pFlags)
    GetVideoProcessorCaps(pCaps)
      => ComCall(9, this.p, D3D11_VIDEO_PROCESSOR_CAPS.Ptr, pCaps)
    GetVideoProcessorRateConversionCaps(TypeIndex, pCaps)
      => ComCall(10, this.p, UInt32, TypeIndex, D3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS.Ptr, pCaps)
    GetVideoProcessorCustomRate(TypeIndex, CustomRateIndex, pRate)
      => ComCall(11, this.p, UInt32, TypeIndex, UInt32, CustomRateIndex, D3D11_VIDEO_PROCESSOR_CUSTOM_RATE.Ptr, pRate)
    GetVideoProcessorFilterRange(Filter, pRange)
      => ComCall(12, this.p, D3D11_VIDEO_PROCESSOR_FILTER, Filter, D3D11_VIDEO_PROCESSOR_FILTER_RANGE.Ptr, pRange)
}
struct D3D11_VIDEO_COLOR_RGBA {
    R : Float32
    G : Float32
    B : Float32
    A : Float32
}
struct D3D11_VIDEO_COLOR_YCbCrA {
    Y : Float32
    Cb : Float32
    Cr : Float32
    A : Float32
}
struct D3D11_VIDEO_COLOR {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            YCbCr : D3D11_VIDEO_COLOR_YCbCrA
            RGBA : D3D11_VIDEO_COLOR_RGBA
        }
    }
}
struct D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE extends Int32 {
    static D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE_UNDEFINED := 0
    static D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE_16_235 := 1
    static D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE_0_255 := 2
}
struct D3D11_VIDEO_PROCESSOR_COLOR_SPACE {
    _bitfield : UInt32
}
struct D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE extends Int32 {
    static D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_OPAQUE := 0
    static D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_BACKGROUND := 1
    static D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_DESTINATION := 2
    static D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_SOURCE_STREAM := 3
}
struct D3D11_VIDEO_PROCESSOR_OUTPUT_RATE extends Int32 {
    static D3D11_VIDEO_PROCESSOR_OUTPUT_RATE_NORMAL := 0
    static D3D11_VIDEO_PROCESSOR_OUTPUT_RATE_HALF := 1
    static D3D11_VIDEO_PROCESSOR_OUTPUT_RATE_CUSTOM := 2
}
struct D3D11_VIDEO_PROCESSOR_STEREO_FORMAT extends Int32 {
    static D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_MONO := 0
    static D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_HORIZONTAL := 1
    static D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_VERTICAL := 2
    static D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_SEPARATE := 3
    static D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_MONO_OFFSET := 4
    static D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_ROW_INTERLEAVED := 5
    static D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_COLUMN_INTERLEAVED := 6
    static D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_CHECKERBOARD := 7
}
struct D3D11_VIDEO_PROCESSOR_STEREO_FLIP_MODE extends Int32 {
    static D3D11_VIDEO_PROCESSOR_STEREO_FLIP_NONE := 0
    static D3D11_VIDEO_PROCESSOR_STEREO_FLIP_FRAME0 := 1
    static D3D11_VIDEO_PROCESSOR_STEREO_FLIP_FRAME1 := 2
}
struct D3D11_VIDEO_PROCESSOR_ROTATION extends Int32 {
    static D3D11_VIDEO_PROCESSOR_ROTATION_IDENTITY := 0
    static D3D11_VIDEO_PROCESSOR_ROTATION_90 := 1
    static D3D11_VIDEO_PROCESSOR_ROTATION_180 := 2
    static D3D11_VIDEO_PROCESSOR_ROTATION_270 := 3
}
struct D3D11_VIDEO_PROCESSOR_STREAM {
    Enable : BOOL
    OutputIndex : UInt32
    InputFrameOrField : UInt32
    PastFrames : UInt32
    FutureFrames : UInt32
    ppPastSurfaces : ID3D11VideoProcessorInputView.Ptr
    pInputSurface : ID3D11VideoProcessorInputView
    ppFutureSurfaces : ID3D11VideoProcessorInputView.Ptr
    ppPastSurfacesRight : ID3D11VideoProcessorInputView.Ptr
    pInputSurfaceRight : ID3D11VideoProcessorInputView
    ppFutureSurfacesRight : ID3D11VideoProcessorInputView.Ptr
}
struct ID3D11VideoProcessor extends ID3D11DeviceChild {
    static IID := "{1D7B0652-185F-41C6-85CE-0C5BE3D4AE6C}"
    GetContentDesc(pDesc)
      => ComCall(7, this.p, D3D11_VIDEO_PROCESSOR_CONTENT_DESC.Ptr, pDesc, "void")
    GetRateConversionCaps(pCaps)
      => ComCall(8, this.p, D3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS.Ptr, pCaps, "void")
}
struct D3D11_OMAC {
    Omac : UInt8[16]
}
struct D3D11_AUTHENTICATED_CHANNEL_TYPE extends Int32 {
    static D3D11_AUTHENTICATED_CHANNEL_D3D11 := 1
    static D3D11_AUTHENTICATED_CHANNEL_DRIVER_SOFTWARE := 2
    static D3D11_AUTHENTICATED_CHANNEL_DRIVER_HARDWARE := 3
}
struct ID3D11AuthenticatedChannel extends ID3D11DeviceChild {
    static IID := "{3015A308-DCBD-47AA-A747-192486D14D4A}"
    GetCertificateSize(pCertificateSize)
      => ComCall(7, this.p, UInt32.Ptr, pCertificateSize)
    GetCertificate(pCertificate)
      => ComCall(8, this.p, UInt32, pCertificate.Size, UInt8.Ptr, pCertificate)
    GetChannelHandle(pChannelHandle)
      => ComCall(9, this.p, HANDLE.Ptr, pChannelHandle, "void")
}
struct D3D11_AUTHENTICATED_QUERY_INPUT {
    QueryType : GUID
    hChannel : HANDLE
    SequenceNumber : UInt32
}
struct D3D11_AUTHENTICATED_QUERY_OUTPUT {
    omac : D3D11_OMAC
    QueryType : GUID
    hChannel : HANDLE
    SequenceNumber : UInt32
    ReturnCode : HRESULT
}
struct D3D11_AUTHENTICATED_PROTECTION_FLAGS {
    union {
        Flags : this._Flags_e__Struct
        Value : UInt32
    }
    struct _Flags_e__Struct {
        _bitfield : UInt32
    }
}
struct D3D11_AUTHENTICATED_QUERY_PROTECTION_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    ProtectionFlags : D3D11_AUTHENTICATED_PROTECTION_FLAGS
}
struct D3D11_AUTHENTICATED_QUERY_CHANNEL_TYPE_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    ChannelType : D3D11_AUTHENTICATED_CHANNEL_TYPE
}
struct D3D11_AUTHENTICATED_QUERY_DEVICE_HANDLE_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    DeviceHandle : HANDLE
}
struct D3D11_AUTHENTICATED_QUERY_CRYPTO_SESSION_INPUT {
    Input : D3D11_AUTHENTICATED_QUERY_INPUT
    DecoderHandle : HANDLE
}
struct D3D11_AUTHENTICATED_QUERY_CRYPTO_SESSION_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    DecoderHandle : HANDLE
    CryptoSessionHandle : HANDLE
    DeviceHandle : HANDLE
}
struct D3D11_AUTHENTICATED_QUERY_RESTRICTED_SHARED_RESOURCE_PROCESS_COUNT_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    RestrictedSharedResourceProcessCount : UInt32
}
struct D3D11_AUTHENTICATED_QUERY_RESTRICTED_SHARED_RESOURCE_PROCESS_INPUT {
    Input : D3D11_AUTHENTICATED_QUERY_INPUT
    ProcessIndex : UInt32
}
struct D3D11_AUTHENTICATED_PROCESS_IDENTIFIER_TYPE extends Int32 {
    static D3D11_PROCESSIDTYPE_UNKNOWN := 0
    static D3D11_PROCESSIDTYPE_DWM := 1
    static D3D11_PROCESSIDTYPE_HANDLE := 2
}
struct D3D11_AUTHENTICATED_QUERY_RESTRICTED_SHARED_RESOURCE_PROCESS_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    ProcessIndex : UInt32
    ProcessIdentifier : D3D11_AUTHENTICATED_PROCESS_IDENTIFIER_TYPE
    ProcessHandle : HANDLE
}
struct D3D11_AUTHENTICATED_QUERY_UNRESTRICTED_PROTECTED_SHARED_RESOURCE_COUNT_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    UnrestrictedProtectedSharedResourceCount : UInt32
}
struct D3D11_AUTHENTICATED_QUERY_OUTPUT_ID_COUNT_INPUT {
    Input : D3D11_AUTHENTICATED_QUERY_INPUT
    DeviceHandle : HANDLE
    CryptoSessionHandle : HANDLE
}
struct D3D11_AUTHENTICATED_QUERY_OUTPUT_ID_COUNT_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    DeviceHandle : HANDLE
    CryptoSessionHandle : HANDLE
    OutputIDCount : UInt32
}
struct D3D11_AUTHENTICATED_QUERY_OUTPUT_ID_INPUT {
    Input : D3D11_AUTHENTICATED_QUERY_INPUT
    DeviceHandle : HANDLE
    CryptoSessionHandle : HANDLE
    OutputIDIndex : UInt32
}
struct D3D11_AUTHENTICATED_QUERY_OUTPUT_ID_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    DeviceHandle : HANDLE
    CryptoSessionHandle : HANDLE
    OutputIDIndex : UInt32
    OutputID : Int64
}
struct D3D11_BUS_TYPE extends Int32 {
    static D3D11_BUS_TYPE_OTHER := 0
    static D3D11_BUS_TYPE_PCI := 1
    static D3D11_BUS_TYPE_PCIX := 2
    static D3D11_BUS_TYPE_PCIEXPRESS := 3
    static D3D11_BUS_TYPE_AGP := 4
    static D3D11_BUS_IMPL_MODIFIER_INSIDE_OF_CHIPSET := 65536
    static D3D11_BUS_IMPL_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_CHIP := 131072
    static D3D11_BUS_IMPL_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_SOCKET := 196608
    static D3D11_BUS_IMPL_MODIFIER_DAUGHTER_BOARD_CONNECTOR := 262144
    static D3D11_BUS_IMPL_MODIFIER_DAUGHTER_BOARD_CONNECTOR_INSIDE_OF_NUAE := 327680
    static D3D11_BUS_IMPL_MODIFIER_NON_STANDARD := -2147483648
}
struct D3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    BusType : D3D11_BUS_TYPE
    AccessibleInContiguousBlocks : BOOL
    AccessibleInNonContiguousBlocks : BOOL
}
struct D3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_ENCRYPTION_GUID_COUNT_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    EncryptionGuidCount : UInt32
}
struct D3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_ENCRYPTION_GUID_INPUT {
    Input : D3D11_AUTHENTICATED_QUERY_INPUT
    EncryptionGuidIndex : UInt32
}
struct D3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_ENCRYPTION_GUID_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    EncryptionGuidIndex : UInt32
    EncryptionGuid : GUID
}
struct D3D11_AUTHENTICATED_QUERY_CURRENT_ACCESSIBILITY_ENCRYPTION_OUTPUT {
    Output : D3D11_AUTHENTICATED_QUERY_OUTPUT
    EncryptionGuid : GUID
}
struct D3D11_AUTHENTICATED_CONFIGURE_INPUT {
    omac : D3D11_OMAC
    ConfigureType : GUID
    hChannel : HANDLE
    SequenceNumber : UInt32
}
struct D3D11_AUTHENTICATED_CONFIGURE_OUTPUT {
    omac : D3D11_OMAC
    ConfigureType : GUID
    hChannel : HANDLE
    SequenceNumber : UInt32
    ReturnCode : HRESULT
}
struct D3D11_AUTHENTICATED_CONFIGURE_INITIALIZE_INPUT {
    Parameters : D3D11_AUTHENTICATED_CONFIGURE_INPUT
    StartSequenceQuery : UInt32
    StartSequenceConfigure : UInt32
}
struct D3D11_AUTHENTICATED_CONFIGURE_PROTECTION_INPUT {
    Parameters : D3D11_AUTHENTICATED_CONFIGURE_INPUT
    Protections : D3D11_AUTHENTICATED_PROTECTION_FLAGS
}
struct D3D11_AUTHENTICATED_CONFIGURE_CRYPTO_SESSION_INPUT {
    Parameters : D3D11_AUTHENTICATED_CONFIGURE_INPUT
    DecoderHandle : HANDLE
    CryptoSessionHandle : HANDLE
    DeviceHandle : HANDLE
}
struct D3D11_AUTHENTICATED_CONFIGURE_SHARED_RESOURCE_INPUT {
    Parameters : D3D11_AUTHENTICATED_CONFIGURE_INPUT
    ProcessType : D3D11_AUTHENTICATED_PROCESS_IDENTIFIER_TYPE
    ProcessHandle : HANDLE
    AllowAccess : BOOL
}
struct D3D11_AUTHENTICATED_CONFIGURE_ACCESSIBLE_ENCRYPTION_INPUT {
    Parameters : D3D11_AUTHENTICATED_CONFIGURE_INPUT
    EncryptionGuid : GUID
}
struct ID3D11CryptoSession extends ID3D11DeviceChild {
    static IID := "{9B32F9AD-BDCC-40A6-A39D-D5C865845720}"
    GetCryptoType(pCryptoType)
      => ComCall(7, this.p, GUID.Ptr, pCryptoType, "void")
    GetDecoderProfile(pDecoderProfile)
      => ComCall(8, this.p, GUID.Ptr, pDecoderProfile, "void")
    GetCertificateSize(pCertificateSize)
      => ComCall(9, this.p, UInt32.Ptr, pCertificateSize)
    GetCertificate(pCertificate)
      => ComCall(10, this.p, UInt32, pCertificate.Size, UInt8.Ptr, pCertificate)
    GetCryptoSessionHandle(pCryptoSessionHandle)
      => ComCall(11, this.p, HANDLE.Ptr, pCryptoSessionHandle, "void")
}
struct D3D11_VDOV_DIMENSION extends Int32 {
    static D3D11_VDOV_DIMENSION_UNKNOWN := 0
    static D3D11_VDOV_DIMENSION_TEXTURE2D := 1
}
struct D3D11_TEX2D_VDOV {
    ArraySlice : UInt32
}
struct D3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC {
    DecodeProfile : GUID
    ViewDimension : D3D11_VDOV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Texture2D : D3D11_TEX2D_VDOV
        }
    }
}
struct ID3D11VideoDecoderOutputView extends ID3D11View {
    static IID := "{C2931AEA-2A85-4F20-860F-FBA1FD256E18}"
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC.Ptr, pDesc, "void")
}
struct D3D11_VPIV_DIMENSION extends Int32 {
    static D3D11_VPIV_DIMENSION_UNKNOWN := 0
    static D3D11_VPIV_DIMENSION_TEXTURE2D := 1
}
struct D3D11_TEX2D_VPIV {
    MipSlice : UInt32
    ArraySlice : UInt32
}
struct D3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC {
    FourCC : UInt32
    ViewDimension : D3D11_VPIV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Texture2D : D3D11_TEX2D_VPIV
        }
    }
}
struct ID3D11VideoProcessorInputView extends ID3D11View {
    static IID := "{11EC5A5F-51DC-4945-AB34-6E8C21300EA5}"
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC.Ptr, pDesc, "void")
}
struct D3D11_VPOV_DIMENSION extends Int32 {
    static D3D11_VPOV_DIMENSION_UNKNOWN := 0
    static D3D11_VPOV_DIMENSION_TEXTURE2D := 1
    static D3D11_VPOV_DIMENSION_TEXTURE2DARRAY := 2
}
struct D3D11_TEX2D_VPOV {
    MipSlice : UInt32
}
struct D3D11_TEX2D_ARRAY_VPOV {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
}
struct D3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC {
    ViewDimension : D3D11_VPOV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Texture2D : D3D11_TEX2D_VPOV
            Texture2DArray : D3D11_TEX2D_ARRAY_VPOV
        }
    }
}
struct ID3D11VideoProcessorOutputView extends ID3D11View {
    static IID := "{A048285E-25A9-4527-BD93-D68B68C44254}"
    GetDesc(pDesc)
      => ComCall(8, this.p, D3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC.Ptr, pDesc, "void")
}
struct ID3D11VideoContext extends ID3D11DeviceChild {
    static IID := "{61F21C45-3C0E-4A74-9CEA-67100D9AD5E4}"
    GetDecoderBuffer(pDecoder, Type, pBufferSize, ppBuffer)
      => ComCall(7, this.p, ID3D11VideoDecoder, pDecoder, D3D11_VIDEO_DECODER_BUFFER_TYPE, Type, UInt32.Ptr, pBufferSize, Struct.Ptr.Ptr, ppBuffer)
    ReleaseDecoderBuffer(pDecoder, Type)
      => ComCall(8, this.p, ID3D11VideoDecoder, pDecoder, D3D11_VIDEO_DECODER_BUFFER_TYPE, Type)
    DecoderBeginFrame(pDecoder, pView, pContentKey?)
      => ComCall(9, this.p, ID3D11VideoDecoder, pDecoder, ID3D11VideoDecoderOutputView, pView, UInt32, pContentKey?.Size ?? 0, Struct.Ptr, pContentKey?)
    DecoderEndFrame(pDecoder)
      => ComCall(10, this.p, ID3D11VideoDecoder, pDecoder)
    SubmitDecoderBuffers(pDecoder, pBufferDesc)
      => ComCall(11, this.p, ID3D11VideoDecoder, pDecoder, UInt32, pBufferDesc.Length, D3D11_VIDEO_DECODER_BUFFER_DESC.Ptr, pBufferDesc)
    DecoderExtension(pDecoder, pExtensionData)
      => ComCall(12, this.p, ID3D11VideoDecoder, pDecoder, D3D11_VIDEO_DECODER_EXTENSION.Ptr, pExtensionData, Int32)
    VideoProcessorSetOutputTargetRect(pVideoProcessor, Enable, pRect?)
      => ComCall(13, this.p, ID3D11VideoProcessor, pVideoProcessor, BOOL, Enable, RECT.Ptr, pRect?, "void")
    VideoProcessorSetOutputBackgroundColor(pVideoProcessor, YCbCr, pColor)
      => ComCall(14, this.p, ID3D11VideoProcessor, pVideoProcessor, BOOL, YCbCr, D3D11_VIDEO_COLOR.Ptr, pColor, "void")
    VideoProcessorSetOutputColorSpace(pVideoProcessor, pColorSpace)
      => ComCall(15, this.p, ID3D11VideoProcessor, pVideoProcessor, D3D11_VIDEO_PROCESSOR_COLOR_SPACE.Ptr, pColorSpace, "void")
    VideoProcessorSetOutputAlphaFillMode(pVideoProcessor, AlphaFillMode, StreamIndex)
      => ComCall(16, this.p, ID3D11VideoProcessor, pVideoProcessor, D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE, AlphaFillMode, UInt32, StreamIndex, "void")
    VideoProcessorSetOutputConstriction(pVideoProcessor, Enable, Size1)
      => ComCall(17, this.p, ID3D11VideoProcessor, pVideoProcessor, BOOL, Enable, SIZE, Size1, "void")
    VideoProcessorSetOutputStereoMode(pVideoProcessor, Enable)
      => ComCall(18, this.p, ID3D11VideoProcessor, pVideoProcessor, BOOL, Enable, "void")
    VideoProcessorSetOutputExtension(pVideoProcessor, pExtensionGuid, DataSize, pData)
      => ComCall(19, this.p, ID3D11VideoProcessor, pVideoProcessor, GUID.Ptr, pExtensionGuid, UInt32, DataSize, Struct.Ptr, pData, Int32)
    VideoProcessorGetOutputTargetRect(pVideoProcessor, Enabled, pRect)
      => ComCall(20, this.p, ID3D11VideoProcessor, pVideoProcessor, BOOL.Ptr, Enabled, RECT.Ptr, pRect, "void")
    VideoProcessorGetOutputBackgroundColor(pVideoProcessor, pYCbCr, pColor)
      => ComCall(21, this.p, ID3D11VideoProcessor, pVideoProcessor, BOOL.Ptr, pYCbCr, D3D11_VIDEO_COLOR.Ptr, pColor, "void")
    VideoProcessorGetOutputColorSpace(pVideoProcessor, pColorSpace)
      => ComCall(22, this.p, ID3D11VideoProcessor, pVideoProcessor, D3D11_VIDEO_PROCESSOR_COLOR_SPACE.Ptr, pColorSpace, "void")
    VideoProcessorGetOutputAlphaFillMode(pVideoProcessor, pAlphaFillMode, pStreamIndex)
      => ComCall(23, this.p, ID3D11VideoProcessor, pVideoProcessor, D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE.Ptr, pAlphaFillMode, UInt32.Ptr, pStreamIndex, "void")
    VideoProcessorGetOutputConstriction(pVideoProcessor, pEnabled, pSize)
      => ComCall(24, this.p, ID3D11VideoProcessor, pVideoProcessor, BOOL.Ptr, pEnabled, SIZE.Ptr, pSize, "void")
    VideoProcessorGetOutputStereoMode(pVideoProcessor, pEnabled)
      => ComCall(25, this.p, ID3D11VideoProcessor, pVideoProcessor, BOOL.Ptr, pEnabled, "void")
    VideoProcessorGetOutputExtension(pVideoProcessor, pExtensionGuid, pData)
      => ComCall(26, this.p, ID3D11VideoProcessor, pVideoProcessor, GUID.Ptr, pExtensionGuid, UInt32, pData.Size, Struct.Ptr, pData, Int32)
    VideoProcessorSetStreamFrameFormat(pVideoProcessor, StreamIndex, FrameFormat)
      => ComCall(27, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, D3D11_VIDEO_FRAME_FORMAT, FrameFormat, "void")
    VideoProcessorSetStreamColorSpace(pVideoProcessor, StreamIndex, pColorSpace)
      => ComCall(28, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, D3D11_VIDEO_PROCESSOR_COLOR_SPACE.Ptr, pColorSpace, "void")
    VideoProcessorSetStreamOutputRate(pVideoProcessor, StreamIndex, OutputRate, RepeatFrame, pCustomRate?)
      => ComCall(29, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, D3D11_VIDEO_PROCESSOR_OUTPUT_RATE, OutputRate, BOOL, RepeatFrame, DXGI_RATIONAL.Ptr, pCustomRate?, "void")
    VideoProcessorSetStreamSourceRect(pVideoProcessor, StreamIndex, Enable, pRect?)
      => ComCall(30, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL, Enable, RECT.Ptr, pRect?, "void")
    VideoProcessorSetStreamDestRect(pVideoProcessor, StreamIndex, Enable, pRect?)
      => ComCall(31, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL, Enable, RECT.Ptr, pRect?, "void")
    VideoProcessorSetStreamAlpha(pVideoProcessor, StreamIndex, Enable, Alpha)
      => ComCall(32, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL, Enable, Float32, Alpha, "void")
    VideoProcessorSetStreamPalette(pVideoProcessor, StreamIndex, pEntries?)
      => ComCall(33, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, UInt32, pEntries?.Length ?? 0, UInt32.Ptr, pEntries?, "void")
    VideoProcessorSetStreamPixelAspectRatio(pVideoProcessor, StreamIndex, Enable, pSourceAspectRatio?, pDestinationAspectRatio?)
      => ComCall(34, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL, Enable, DXGI_RATIONAL.Ptr, pSourceAspectRatio?, DXGI_RATIONAL.Ptr, pDestinationAspectRatio?, "void")
    VideoProcessorSetStreamLumaKey(pVideoProcessor, StreamIndex, Enable, Lower, Upper)
      => ComCall(35, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL, Enable, Float32, Lower, Float32, Upper, "void")
    VideoProcessorSetStreamStereoFormat(pVideoProcessor, StreamIndex, Enable, Format, LeftViewFrame0, BaseViewFrame0, FlipMode, MonoOffset)
      => ComCall(36, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL, Enable, D3D11_VIDEO_PROCESSOR_STEREO_FORMAT, Format, BOOL, LeftViewFrame0, BOOL, BaseViewFrame0, D3D11_VIDEO_PROCESSOR_STEREO_FLIP_MODE, FlipMode, Int32, MonoOffset, "void")
    VideoProcessorSetStreamAutoProcessingMode(pVideoProcessor, StreamIndex, Enable)
      => ComCall(37, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL, Enable, "void")
    VideoProcessorSetStreamFilter(pVideoProcessor, StreamIndex, Filter, Enable, Level)
      => ComCall(38, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, D3D11_VIDEO_PROCESSOR_FILTER, Filter, BOOL, Enable, Int32, Level, "void")
    VideoProcessorSetStreamExtension(pVideoProcessor, StreamIndex, pExtensionGuid, DataSize, pData)
      => ComCall(39, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, GUID.Ptr, pExtensionGuid, UInt32, DataSize, Struct.Ptr, pData, Int32)
    VideoProcessorGetStreamFrameFormat(pVideoProcessor, StreamIndex, pFrameFormat)
      => ComCall(40, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, D3D11_VIDEO_FRAME_FORMAT.Ptr, pFrameFormat, "void")
    VideoProcessorGetStreamColorSpace(pVideoProcessor, StreamIndex, pColorSpace)
      => ComCall(41, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, D3D11_VIDEO_PROCESSOR_COLOR_SPACE.Ptr, pColorSpace, "void")
    VideoProcessorGetStreamOutputRate(pVideoProcessor, StreamIndex, pOutputRate, pRepeatFrame, pCustomRate)
      => ComCall(42, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, D3D11_VIDEO_PROCESSOR_OUTPUT_RATE.Ptr, pOutputRate, BOOL.Ptr, pRepeatFrame, DXGI_RATIONAL.Ptr, pCustomRate, "void")
    VideoProcessorGetStreamSourceRect(pVideoProcessor, StreamIndex, pEnabled, pRect)
      => ComCall(43, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL.Ptr, pEnabled, RECT.Ptr, pRect, "void")
    VideoProcessorGetStreamDestRect(pVideoProcessor, StreamIndex, pEnabled, pRect)
      => ComCall(44, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL.Ptr, pEnabled, RECT.Ptr, pRect, "void")
    VideoProcessorGetStreamAlpha(pVideoProcessor, StreamIndex, pEnabled, pAlpha)
      => ComCall(45, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL.Ptr, pEnabled, Float32.Ptr, pAlpha, "void")
    VideoProcessorGetStreamPalette(pVideoProcessor, StreamIndex, pEntries)
      => ComCall(46, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, UInt32, pEntries.Length, UInt32.Ptr, pEntries, "void")
    VideoProcessorGetStreamPixelAspectRatio(pVideoProcessor, StreamIndex, pEnabled, pSourceAspectRatio, pDestinationAspectRatio)
      => ComCall(47, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL.Ptr, pEnabled, DXGI_RATIONAL.Ptr, pSourceAspectRatio, DXGI_RATIONAL.Ptr, pDestinationAspectRatio, "void")
    VideoProcessorGetStreamLumaKey(pVideoProcessor, StreamIndex, pEnabled, pLower, pUpper)
      => ComCall(48, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL.Ptr, pEnabled, Float32.Ptr, pLower, Float32.Ptr, pUpper, "void")
    VideoProcessorGetStreamStereoFormat(pVideoProcessor, StreamIndex, pEnable, pFormat, pLeftViewFrame0, pBaseViewFrame0, pFlipMode, MonoOffset)
      => ComCall(49, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL.Ptr, pEnable, D3D11_VIDEO_PROCESSOR_STEREO_FORMAT.Ptr, pFormat, BOOL.Ptr, pLeftViewFrame0, BOOL.Ptr, pBaseViewFrame0, D3D11_VIDEO_PROCESSOR_STEREO_FLIP_MODE.Ptr, pFlipMode, Int32.Ptr, MonoOffset, "void")
    VideoProcessorGetStreamAutoProcessingMode(pVideoProcessor, StreamIndex, pEnabled)
      => ComCall(50, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL.Ptr, pEnabled, "void")
    VideoProcessorGetStreamFilter(pVideoProcessor, StreamIndex, Filter, pEnabled, pLevel)
      => ComCall(51, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, D3D11_VIDEO_PROCESSOR_FILTER, Filter, BOOL.Ptr, pEnabled, Int32.Ptr, pLevel, "void")
    VideoProcessorGetStreamExtension(pVideoProcessor, StreamIndex, pExtensionGuid, pData)
      => ComCall(52, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, GUID.Ptr, pExtensionGuid, UInt32, pData.Size, Struct.Ptr, pData, Int32)
    VideoProcessorBlt(pVideoProcessor, pView, OutputFrame, pStreams)
      => ComCall(53, this.p, ID3D11VideoProcessor, pVideoProcessor, ID3D11VideoProcessorOutputView, pView, UInt32, OutputFrame, UInt32, pStreams.Length, D3D11_VIDEO_PROCESSOR_STREAM.Ptr, pStreams)
    NegotiateCryptoSessionKeyExchange(pCryptoSession, pData)
      => ComCall(54, this.p, ID3D11CryptoSession, pCryptoSession, UInt32, pData.Size, Struct.Ptr, pData)
    EncryptionBlt(pCryptoSession, pSrcSurface, pDstSurface, pIV?)
      => ComCall(55, this.p, ID3D11CryptoSession, pCryptoSession, ID3D11Texture2D, pSrcSurface, ID3D11Texture2D, pDstSurface, UInt32, pIV?.Size ?? 0, Struct.Ptr, pIV?, "void")
    DecryptionBlt(pCryptoSession, pSrcSurface, pDstSurface, pEncryptedBlockInfo?, pContentKey?, pIV?)
      => ComCall(56, this.p, ID3D11CryptoSession, pCryptoSession, ID3D11Texture2D, pSrcSurface, ID3D11Texture2D, pDstSurface, D3D11_ENCRYPTED_BLOCK_INFO.Ptr, pEncryptedBlockInfo?, UInt32, pContentKey?.Size ?? 0, Struct.Ptr, pContentKey?, UInt32, pIV?.Size ?? 0, Struct.Ptr, pIV?, "void")
    StartSessionKeyRefresh(pCryptoSession, pRandomNumber)
      => ComCall(57, this.p, ID3D11CryptoSession, pCryptoSession, UInt32, pRandomNumber.Size, Struct.Ptr, pRandomNumber, "void")
    FinishSessionKeyRefresh(pCryptoSession)
      => ComCall(58, this.p, ID3D11CryptoSession, pCryptoSession, "void")
    GetEncryptionBltKey(pCryptoSession, pReadbackKey)
      => ComCall(59, this.p, ID3D11CryptoSession, pCryptoSession, UInt32, pReadbackKey.Size, Struct.Ptr, pReadbackKey)
    NegotiateAuthenticatedChannelKeyExchange(pChannel, pData)
      => ComCall(60, this.p, ID3D11AuthenticatedChannel, pChannel, UInt32, pData.Size, Struct.Ptr, pData)
    QueryAuthenticatedChannel(pChannel, pInput, pOutput)
      => ComCall(61, this.p, ID3D11AuthenticatedChannel, pChannel, UInt32, pInput.Size, Struct.Ptr, pInput, UInt32, pOutput.Size, Struct.Ptr, pOutput)
    ConfigureAuthenticatedChannel(pChannel, pInput, pOutput)
      => ComCall(62, this.p, ID3D11AuthenticatedChannel, pChannel, UInt32, pInput.Size, Struct.Ptr, pInput, D3D11_AUTHENTICATED_CONFIGURE_OUTPUT.Ptr, pOutput)
    VideoProcessorSetStreamRotation(pVideoProcessor, StreamIndex, Enable, Rotation)
      => ComCall(63, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL, Enable, D3D11_VIDEO_PROCESSOR_ROTATION, Rotation, "void")
    VideoProcessorGetStreamRotation(pVideoProcessor, StreamIndex, pEnable, pRotation)
      => ComCall(64, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL.Ptr, pEnable, D3D11_VIDEO_PROCESSOR_ROTATION.Ptr, pRotation, "void")
}
struct ID3D11VideoDevice extends IUnknown {
    static IID := "{10EC4D5B-975A-4689-B9E4-D0AAC30FE333}"
    CreateVideoDecoder(pVideoDesc, pConfig, ppDecoder)
      => ComCall(3, this.p, D3D11_VIDEO_DECODER_DESC.Ptr, pVideoDesc, D3D11_VIDEO_DECODER_CONFIG.Ptr, pConfig, ID3D11VideoDecoder.Ptr, ppDecoder)
    CreateVideoProcessor(pEnum, RateConversionIndex, ppVideoProcessor)
      => ComCall(4, this.p, ID3D11VideoProcessorEnumerator, pEnum, UInt32, RateConversionIndex, ID3D11VideoProcessor.Ptr, ppVideoProcessor)
    CreateAuthenticatedChannel(ChannelType, ppAuthenticatedChannel)
      => ComCall(5, this.p, D3D11_AUTHENTICATED_CHANNEL_TYPE, ChannelType, ID3D11AuthenticatedChannel.Ptr, ppAuthenticatedChannel)
    CreateCryptoSession(pCryptoType, pDecoderProfile?, pKeyExchangeType, ppCryptoSession)
      => ComCall(6, this.p, GUID.Ptr, pCryptoType, GUID.Ptr, pDecoderProfile?, GUID.Ptr, pKeyExchangeType, ID3D11CryptoSession.Ptr, ppCryptoSession)
    CreateVideoDecoderOutputView(pResource, pDesc, ppVDOVView?)
      => ComCall(7, this.p, ID3D11Resource, pResource, D3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC.Ptr, pDesc, ID3D11VideoDecoderOutputView.Ptr, ppVDOVView?)
    CreateVideoProcessorInputView(pResource, pEnum, pDesc, ppVPIView?)
      => ComCall(8, this.p, ID3D11Resource, pResource, ID3D11VideoProcessorEnumerator, pEnum, D3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC.Ptr, pDesc, ID3D11VideoProcessorInputView.Ptr, ppVPIView?)
    CreateVideoProcessorOutputView(pResource, pEnum, pDesc, ppVPOView?)
      => ComCall(9, this.p, ID3D11Resource, pResource, ID3D11VideoProcessorEnumerator, pEnum, D3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC.Ptr, pDesc, ID3D11VideoProcessorOutputView.Ptr, ppVPOView?)
    CreateVideoProcessorEnumerator(pDesc, ppEnum)
      => ComCall(10, this.p, D3D11_VIDEO_PROCESSOR_CONTENT_DESC.Ptr, pDesc, ID3D11VideoProcessorEnumerator.Ptr, ppEnum)
    GetVideoDecoderProfileCount()
      => ComCall(11, this.p, UInt32)
    GetVideoDecoderProfile(Index, pDecoderProfile)
      => ComCall(12, this.p, UInt32, Index, GUID.Ptr, pDecoderProfile)
    CheckVideoDecoderFormat(pDecoderProfile, Format, pSupported)
      => ComCall(13, this.p, GUID.Ptr, pDecoderProfile, DXGI_FORMAT, Format, BOOL.Ptr, pSupported)
    GetVideoDecoderConfigCount(pDesc, pCount)
      => ComCall(14, this.p, D3D11_VIDEO_DECODER_DESC.Ptr, pDesc, UInt32.Ptr, pCount)
    GetVideoDecoderConfig(pDesc, Index, pConfig)
      => ComCall(15, this.p, D3D11_VIDEO_DECODER_DESC.Ptr, pDesc, UInt32, Index, D3D11_VIDEO_DECODER_CONFIG.Ptr, pConfig)
    GetContentProtectionCaps(pCryptoType?, pDecoderProfile?, pCaps)
      => ComCall(16, this.p, GUID.Ptr, pCryptoType?, GUID.Ptr, pDecoderProfile?, D3D11_VIDEO_CONTENT_PROTECTION_CAPS.Ptr, pCaps)
    CheckCryptoKeyExchange(pCryptoType, pDecoderProfile?, Index, pKeyExchangeType)
      => ComCall(17, this.p, GUID.Ptr, pCryptoType, GUID.Ptr, pDecoderProfile?, UInt32, Index, GUID.Ptr, pKeyExchangeType)
    SetPrivateData(guid, pData?)
      => ComCall(18, this.p, GUID.Ptr, guid, UInt32, pData?.Size ?? 0, Struct.Ptr, pData?)
    SetPrivateDataInterface(guid, pData?)
      => ComCall(19, this.p, GUID.Ptr, guid, IUnknown, pData?)
}
struct ID3D11Device extends IUnknown {
    static IID := "{DB6F6DDB-AC77-4E88-8253-819DF9BBF140}"
    CreateBuffer(pDesc, pInitialData?, ppBuffer?)
      => ComCall(3, this.p, D3D11_BUFFER_DESC.Ptr, pDesc, D3D11_SUBRESOURCE_DATA.Ptr, pInitialData?, ID3D11Buffer.Ptr, ppBuffer?)
    CreateTexture1D(pDesc, pInitialData?, ppTexture1D?)
      => ComCall(4, this.p, D3D11_TEXTURE1D_DESC.Ptr, pDesc, D3D11_SUBRESOURCE_DATA.Ptr, pInitialData?, ID3D11Texture1D.Ptr, ppTexture1D?)
    CreateTexture2D(pDesc, pInitialData?, ppTexture2D?)
      => ComCall(5, this.p, D3D11_TEXTURE2D_DESC.Ptr, pDesc, D3D11_SUBRESOURCE_DATA.Ptr, pInitialData?, ID3D11Texture2D.Ptr, ppTexture2D?)
    CreateTexture3D(pDesc, pInitialData?, ppTexture3D?)
      => ComCall(6, this.p, D3D11_TEXTURE3D_DESC.Ptr, pDesc, D3D11_SUBRESOURCE_DATA.Ptr, pInitialData?, ID3D11Texture3D.Ptr, ppTexture3D?)
    CreateShaderResourceView(pResource, pDesc?, ppSRView?)
      => ComCall(7, this.p, ID3D11Resource, pResource, D3D11_SHADER_RESOURCE_VIEW_DESC.Ptr, pDesc?, ID3D11ShaderResourceView.Ptr, ppSRView?)
    CreateUnorderedAccessView(pResource, pDesc?, ppUAView?)
      => ComCall(8, this.p, ID3D11Resource, pResource, D3D11_UNORDERED_ACCESS_VIEW_DESC.Ptr, pDesc?, ID3D11UnorderedAccessView.Ptr, ppUAView?)
    CreateRenderTargetView(pResource, pDesc?, ppRTView?)
      => ComCall(9, this.p, ID3D11Resource, pResource, D3D11_RENDER_TARGET_VIEW_DESC.Ptr, pDesc?, ID3D11RenderTargetView.Ptr, ppRTView?)
    CreateDepthStencilView(pResource, pDesc?, ppDepthStencilView?)
      => ComCall(10, this.p, ID3D11Resource, pResource, D3D11_DEPTH_STENCIL_VIEW_DESC.Ptr, pDesc?, ID3D11DepthStencilView.Ptr, ppDepthStencilView?)
    CreateInputLayout(pInputElementDescs, pShaderBytecodeWithInputSignature, ppInputLayout?)
      => ComCall(11, this.p, D3D11_INPUT_ELEMENT_DESC.Ptr, pInputElementDescs, UInt32, pInputElementDescs.Length, Struct.Ptr, pShaderBytecodeWithInputSignature, IntPtr, pShaderBytecodeWithInputSignature.Length, ID3D11InputLayout.Ptr, ppInputLayout?)
    CreateVertexShader(pShaderBytecode, pClassLinkage?, ppVertexShader?)
      => ComCall(12, this.p, Struct.Ptr, pShaderBytecode, IntPtr, pShaderBytecode.Length, ID3D11ClassLinkage, pClassLinkage?, ID3D11VertexShader.Ptr, ppVertexShader?)
    CreateGeometryShader(pShaderBytecode, pClassLinkage?, ppGeometryShader?)
      => ComCall(13, this.p, Struct.Ptr, pShaderBytecode, IntPtr, pShaderBytecode.Length, ID3D11ClassLinkage, pClassLinkage?, ID3D11GeometryShader.Ptr, ppGeometryShader?)
    CreateGeometryShaderWithStreamOutput(pShaderBytecode, pSODeclaration?, pBufferStrides?, RasterizedStream, pClassLinkage?, ppGeometryShader?)
      => ComCall(14, this.p, Struct.Ptr, pShaderBytecode, IntPtr, pShaderBytecode.Length, D3D11_SO_DECLARATION_ENTRY.Ptr, pSODeclaration?, UInt32, pSODeclaration?.Length ?? 0, UInt32.Ptr, pBufferStrides?, UInt32, pBufferStrides?.Length ?? 0, UInt32, RasterizedStream, ID3D11ClassLinkage, pClassLinkage?, ID3D11GeometryShader.Ptr, ppGeometryShader?)
    CreatePixelShader(pShaderBytecode, pClassLinkage?, ppPixelShader?)
      => ComCall(15, this.p, Struct.Ptr, pShaderBytecode, IntPtr, pShaderBytecode.Length, ID3D11ClassLinkage, pClassLinkage?, ID3D11PixelShader.Ptr, ppPixelShader?)
    CreateHullShader(pShaderBytecode, pClassLinkage?, ppHullShader?)
      => ComCall(16, this.p, Struct.Ptr, pShaderBytecode, IntPtr, pShaderBytecode.Length, ID3D11ClassLinkage, pClassLinkage?, ID3D11HullShader.Ptr, ppHullShader?)
    CreateDomainShader(pShaderBytecode, pClassLinkage?, ppDomainShader?)
      => ComCall(17, this.p, Struct.Ptr, pShaderBytecode, IntPtr, pShaderBytecode.Length, ID3D11ClassLinkage, pClassLinkage?, ID3D11DomainShader.Ptr, ppDomainShader?)
    CreateComputeShader(pShaderBytecode, pClassLinkage?, ppComputeShader?)
      => ComCall(18, this.p, Struct.Ptr, pShaderBytecode, IntPtr, pShaderBytecode.Length, ID3D11ClassLinkage, pClassLinkage?, ID3D11ComputeShader.Ptr, ppComputeShader?)
    CreateClassLinkage(ppLinkage)
      => ComCall(19, this.p, ID3D11ClassLinkage.Ptr, ppLinkage)
    CreateBlendState(pBlendStateDesc, ppBlendState?)
      => ComCall(20, this.p, D3D11_BLEND_DESC.Ptr, pBlendStateDesc, ID3D11BlendState.Ptr, ppBlendState?)
    CreateDepthStencilState(pDepthStencilDesc, ppDepthStencilState?)
      => ComCall(21, this.p, D3D11_DEPTH_STENCIL_DESC.Ptr, pDepthStencilDesc, ID3D11DepthStencilState.Ptr, ppDepthStencilState?)
    CreateRasterizerState(pRasterizerDesc, ppRasterizerState?)
      => ComCall(22, this.p, D3D11_RASTERIZER_DESC.Ptr, pRasterizerDesc, ID3D11RasterizerState.Ptr, ppRasterizerState?)
    CreateSamplerState(pSamplerDesc, ppSamplerState?)
      => ComCall(23, this.p, D3D11_SAMPLER_DESC.Ptr, pSamplerDesc, ID3D11SamplerState.Ptr, ppSamplerState?)
    CreateQuery(pQueryDesc, ppQuery?)
      => ComCall(24, this.p, D3D11_QUERY_DESC.Ptr, pQueryDesc, ID3D11Query.Ptr, ppQuery?)
    CreatePredicate(pPredicateDesc, ppPredicate?)
      => ComCall(25, this.p, D3D11_QUERY_DESC.Ptr, pPredicateDesc, ID3D11Predicate.Ptr, ppPredicate?)
    CreateCounter(pCounterDesc, ppCounter?)
      => ComCall(26, this.p, D3D11_COUNTER_DESC.Ptr, pCounterDesc, ID3D11Counter.Ptr, ppCounter?)
    CreateDeferredContext(ContextFlags, ppDeferredContext?)
      => ComCall(27, this.p, UInt32, ContextFlags, ID3D11DeviceContext.Ptr, ppDeferredContext?)
    OpenSharedResource(hResource, ReturnedInterface, ppResource?)
      => ComCall(28, this.p, HANDLE, hResource, GUID.Ptr, ReturnedInterface, Struct.Ptr.Ptr, ppResource?)
    CheckFormatSupport(Format, pFormatSupport)
      => ComCall(29, this.p, DXGI_FORMAT, Format, UInt32.Ptr, pFormatSupport)
    CheckMultisampleQualityLevels(Format, SampleCount, pNumQualityLevels)
      => ComCall(30, this.p, DXGI_FORMAT, Format, UInt32, SampleCount, UInt32.Ptr, pNumQualityLevels)
    CheckCounterInfo(pCounterInfo)
      => ComCall(31, this.p, D3D11_COUNTER_INFO.Ptr, pCounterInfo, "void")
    CheckCounter(pDesc, pType, pActiveCounters, szName?, szUnits?, szDescription?)
      => ComCall(32, this.p, D3D11_COUNTER_DESC.Ptr, pDesc, D3D11_COUNTER_TYPE.Ptr, pType, UInt32.Ptr, pActiveCounters, PSTR, szName?, UInt32.Ptr, szName?.Length ?? 0, PSTR, szUnits?, UInt32.Ptr, szUnits?.Length ?? 0, PSTR, szDescription?, UInt32.Ptr, szDescription?.Length ?? 0)
    CheckFeatureSupport(Feature, pFeatureSupportData)
      => ComCall(33, this.p, D3D11_FEATURE, Feature, Struct.Ptr, pFeatureSupportData, UInt32, pFeatureSupportData.Size)
    GetPrivateData(guid, pDataSize, pData?)
      => ComCall(34, this.p, GUID.Ptr, guid, UInt32.Ptr, pDataSize, Struct.Ptr, pData?)
    SetPrivateData(guid, pData?)
      => ComCall(35, this.p, GUID.Ptr, guid, UInt32, pData?.Size ?? 0, Struct.Ptr, pData?)
    SetPrivateDataInterface(guid, pData?)
      => ComCall(36, this.p, GUID.Ptr, guid, IUnknown, pData?)
    GetFeatureLevel()
      => ComCall(37, this.p, D3D_FEATURE_LEVEL)
    GetCreationFlags()
      => ComCall(38, this.p, UInt32)
    GetDeviceRemovedReason()
      => ComCall(39, this.p)
    GetImmediateContext(ppImmediateContext)
      => ComCall(40, this.p, ID3D11DeviceContext.Ptr, ppImmediateContext, "void")
    SetExceptionMode(RaiseFlags)
      => ComCall(41, this.p, UInt32, RaiseFlags)
    GetExceptionMode()
      => ComCall(42, this.p, UInt32)
}
struct D3D11_CREATE_DEVICE_FLAG extends UInt32 {
    static D3D11_CREATE_DEVICE_SINGLETHREADED := 1
    static D3D11_CREATE_DEVICE_DEBUG := 2
    static D3D11_CREATE_DEVICE_SWITCH_TO_REF := 4
    static D3D11_CREATE_DEVICE_PREVENT_INTERNAL_THREADING_OPTIMIZATIONS := 8
    static D3D11_CREATE_DEVICE_BGRA_SUPPORT := 32
    static D3D11_CREATE_DEVICE_DEBUGGABLE := 64
    static D3D11_CREATE_DEVICE_PREVENT_ALTERING_LAYER_SETTINGS_FROM_REGISTRY := 128
    static D3D11_CREATE_DEVICE_DISABLE_GPU_TIMEOUT := 256
    static D3D11_CREATE_DEVICE_VIDEO_SUPPORT := 2048
}
struct D3D11_RLDO_FLAGS extends Int32 {
    static D3D11_RLDO_SUMMARY := 1
    static D3D11_RLDO_DETAIL := 2
    static D3D11_RLDO_IGNORE_INTERNAL := 4
}
struct ID3D11Debug extends IUnknown {
    static IID := "{79CF2233-7536-4948-9D36-1E4692DC5760}"
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
    ValidateContext(pContext)
      => ComCall(9, this.p, ID3D11DeviceContext, pContext)
    ReportLiveDeviceObjects(Flags)
      => ComCall(10, this.p, D3D11_RLDO_FLAGS, Flags)
    ValidateContextForDispatch(pContext)
      => ComCall(11, this.p, ID3D11DeviceContext, pContext)
}
struct ID3D11SwitchToRef extends IUnknown {
    static IID := "{1EF337E3-58E7-4F83-A692-DB221F5ED47E}"
    SetUseRef(UseRef)
      => ComCall(3, this.p, BOOL, UseRef, BOOL)
    GetUseRef()
      => ComCall(4, this.p, BOOL)
}
struct D3D11_SHADER_TRACKING_RESOURCE_TYPE extends Int32 {
    static D3D11_SHADER_TRACKING_RESOURCE_TYPE_NONE := 0
    static D3D11_SHADER_TRACKING_RESOURCE_TYPE_UAV_DEVICEMEMORY := 1
    static D3D11_SHADER_TRACKING_RESOURCE_TYPE_NON_UAV_DEVICEMEMORY := 2
    static D3D11_SHADER_TRACKING_RESOURCE_TYPE_ALL_DEVICEMEMORY := 3
    static D3D11_SHADER_TRACKING_RESOURCE_TYPE_GROUPSHARED_MEMORY := 4
    static D3D11_SHADER_TRACKING_RESOURCE_TYPE_ALL_SHARED_MEMORY := 5
    static D3D11_SHADER_TRACKING_RESOURCE_TYPE_GROUPSHARED_NON_UAV := 6
    static D3D11_SHADER_TRACKING_RESOURCE_TYPE_ALL := 7
}
struct D3D11_SHADER_TRACKING_OPTIONS extends Int32 {
    static D3D11_SHADER_TRACKING_OPTION_IGNORE := 0
    static D3D11_SHADER_TRACKING_OPTION_TRACK_UNINITIALIZED := 1
    static D3D11_SHADER_TRACKING_OPTION_TRACK_RAW := 2
    static D3D11_SHADER_TRACKING_OPTION_TRACK_WAR := 4
    static D3D11_SHADER_TRACKING_OPTION_TRACK_WAW := 8
    static D3D11_SHADER_TRACKING_OPTION_ALLOW_SAME := 16
    static D3D11_SHADER_TRACKING_OPTION_TRACK_ATOMIC_CONSISTENCY := 32
    static D3D11_SHADER_TRACKING_OPTION_TRACK_RAW_ACROSS_THREADGROUPS := 64
    static D3D11_SHADER_TRACKING_OPTION_TRACK_WAR_ACROSS_THREADGROUPS := 128
    static D3D11_SHADER_TRACKING_OPTION_TRACK_WAW_ACROSS_THREADGROUPS := 256
    static D3D11_SHADER_TRACKING_OPTION_TRACK_ATOMIC_CONSISTENCY_ACROSS_THREADGROUPS := 512
    static D3D11_SHADER_TRACKING_OPTION_UAV_SPECIFIC_FLAGS := 960
    static D3D11_SHADER_TRACKING_OPTION_ALL_HAZARDS := 1006
    static D3D11_SHADER_TRACKING_OPTION_ALL_HAZARDS_ALLOWING_SAME := 1022
    static D3D11_SHADER_TRACKING_OPTION_ALL_OPTIONS := 1023
}
struct ID3D11TracingDevice extends IUnknown {
    static IID := "{1911C771-1587-413E-A7E0-FB26C3DE0268}"
    SetShaderTrackingOptionsByType(ResourceTypeFlags, Options)
      => ComCall(3, this.p, UInt32, ResourceTypeFlags, UInt32, Options)
    SetShaderTrackingOptions(pShader, Options)
      => ComCall(4, this.p, IUnknown, pShader, UInt32, Options)
}
struct ID3D11RefTrackingOptions extends IUnknown {
    static IID := "{193DACDF-0DB2-4C05-A55C-EF06CAC56FD9}"
    SetTrackingOptions(uOptions)
      => ComCall(3, this.p, UInt32, uOptions)
}
struct ID3D11RefDefaultTrackingOptions extends IUnknown {
    static IID := "{03916615-C644-418C-9BF4-75DB5BE63CA0}"
    SetTrackingOptions(ResourceTypeFlags, Options)
      => ComCall(3, this.p, UInt32, ResourceTypeFlags, UInt32, Options)
}
struct D3D11_MESSAGE_CATEGORY extends Int32 {
    static D3D11_MESSAGE_CATEGORY_APPLICATION_DEFINED := 0
    static D3D11_MESSAGE_CATEGORY_MISCELLANEOUS := 1
    static D3D11_MESSAGE_CATEGORY_INITIALIZATION := 2
    static D3D11_MESSAGE_CATEGORY_CLEANUP := 3
    static D3D11_MESSAGE_CATEGORY_COMPILATION := 4
    static D3D11_MESSAGE_CATEGORY_STATE_CREATION := 5
    static D3D11_MESSAGE_CATEGORY_STATE_SETTING := 6
    static D3D11_MESSAGE_CATEGORY_STATE_GETTING := 7
    static D3D11_MESSAGE_CATEGORY_RESOURCE_MANIPULATION := 8
    static D3D11_MESSAGE_CATEGORY_EXECUTION := 9
    static D3D11_MESSAGE_CATEGORY_SHADER := 10
}
struct D3D11_MESSAGE_SEVERITY extends Int32 {
    static D3D11_MESSAGE_SEVERITY_CORRUPTION := 0
    static D3D11_MESSAGE_SEVERITY_ERROR := 1
    static D3D11_MESSAGE_SEVERITY_WARNING := 2
    static D3D11_MESSAGE_SEVERITY_INFO := 3
    static D3D11_MESSAGE_SEVERITY_MESSAGE := 4
}
struct D3D11_MESSAGE_ID extends Int32 {
    static D3D11_MESSAGE_ID_UNKNOWN := 0
    static D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_HAZARD := 1
    static D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_HAZARD := 2
    static D3D11_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_HAZARD := 3
    static D3D11_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_HAZARD := 4
    static D3D11_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_HAZARD := 5
    static D3D11_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_HAZARD := 6
    static D3D11_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_HAZARD := 7
    static D3D11_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_HAZARD := 8
    static D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETS_HAZARD := 9
    static D3D11_MESSAGE_ID_DEVICE_SOSETTARGETS_HAZARD := 10
    static D3D11_MESSAGE_ID_STRING_FROM_APPLICATION := 11
    static D3D11_MESSAGE_ID_CORRUPTED_THIS := 12
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER1 := 13
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER2 := 14
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER3 := 15
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER4 := 16
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER5 := 17
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER6 := 18
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER7 := 19
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER8 := 20
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER9 := 21
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER10 := 22
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER11 := 23
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER12 := 24
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER13 := 25
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER14 := 26
    static D3D11_MESSAGE_ID_CORRUPTED_PARAMETER15 := 27
    static D3D11_MESSAGE_ID_CORRUPTED_MULTITHREADING := 28
    static D3D11_MESSAGE_ID_MESSAGE_REPORTING_OUTOFMEMORY := 29
    static D3D11_MESSAGE_ID_IASETINPUTLAYOUT_UNBINDDELETINGOBJECT := 30
    static D3D11_MESSAGE_ID_IASETVERTEXBUFFERS_UNBINDDELETINGOBJECT := 31
    static D3D11_MESSAGE_ID_IASETINDEXBUFFER_UNBINDDELETINGOBJECT := 32
    static D3D11_MESSAGE_ID_VSSETSHADER_UNBINDDELETINGOBJECT := 33
    static D3D11_MESSAGE_ID_VSSETSHADERRESOURCES_UNBINDDELETINGOBJECT := 34
    static D3D11_MESSAGE_ID_VSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT := 35
    static D3D11_MESSAGE_ID_VSSETSAMPLERS_UNBINDDELETINGOBJECT := 36
    static D3D11_MESSAGE_ID_GSSETSHADER_UNBINDDELETINGOBJECT := 37
    static D3D11_MESSAGE_ID_GSSETSHADERRESOURCES_UNBINDDELETINGOBJECT := 38
    static D3D11_MESSAGE_ID_GSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT := 39
    static D3D11_MESSAGE_ID_GSSETSAMPLERS_UNBINDDELETINGOBJECT := 40
    static D3D11_MESSAGE_ID_SOSETTARGETS_UNBINDDELETINGOBJECT := 41
    static D3D11_MESSAGE_ID_PSSETSHADER_UNBINDDELETINGOBJECT := 42
    static D3D11_MESSAGE_ID_PSSETSHADERRESOURCES_UNBINDDELETINGOBJECT := 43
    static D3D11_MESSAGE_ID_PSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT := 44
    static D3D11_MESSAGE_ID_PSSETSAMPLERS_UNBINDDELETINGOBJECT := 45
    static D3D11_MESSAGE_ID_RSSETSTATE_UNBINDDELETINGOBJECT := 46
    static D3D11_MESSAGE_ID_OMSETBLENDSTATE_UNBINDDELETINGOBJECT := 47
    static D3D11_MESSAGE_ID_OMSETDEPTHSTENCILSTATE_UNBINDDELETINGOBJECT := 48
    static D3D11_MESSAGE_ID_OMSETRENDERTARGETS_UNBINDDELETINGOBJECT := 49
    static D3D11_MESSAGE_ID_SETPREDICATION_UNBINDDELETINGOBJECT := 50
    static D3D11_MESSAGE_ID_GETPRIVATEDATA_MOREDATA := 51
    static D3D11_MESSAGE_ID_SETPRIVATEDATA_INVALIDFREEDATA := 52
    static D3D11_MESSAGE_ID_SETPRIVATEDATA_INVALIDIUNKNOWN := 53
    static D3D11_MESSAGE_ID_SETPRIVATEDATA_INVALIDFLAGS := 54
    static D3D11_MESSAGE_ID_SETPRIVATEDATA_CHANGINGPARAMS := 55
    static D3D11_MESSAGE_ID_SETPRIVATEDATA_OUTOFMEMORY := 56
    static D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDFORMAT := 57
    static D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDSAMPLES := 58
    static D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDUSAGE := 59
    static D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDBINDFLAGS := 60
    static D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDCPUACCESSFLAGS := 61
    static D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDMISCFLAGS := 62
    static D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDCPUACCESSFLAGS := 63
    static D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDBINDFLAGS := 64
    static D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDINITIALDATA := 65
    static D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDDIMENSIONS := 66
    static D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDMIPLEVELS := 67
    static D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDMISCFLAGS := 68
    static D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDARG_RETURN := 69
    static D3D11_MESSAGE_ID_CREATEBUFFER_OUTOFMEMORY_RETURN := 70
    static D3D11_MESSAGE_ID_CREATEBUFFER_NULLDESC := 71
    static D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDCONSTANTBUFFERBINDINGS := 72
    static D3D11_MESSAGE_ID_CREATEBUFFER_LARGEALLOCATION := 73
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDFORMAT := 74
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_UNSUPPORTEDFORMAT := 75
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDSAMPLES := 76
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDUSAGE := 77
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDBINDFLAGS := 78
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDCPUACCESSFLAGS := 79
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDMISCFLAGS := 80
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDCPUACCESSFLAGS := 81
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDBINDFLAGS := 82
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDINITIALDATA := 83
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDDIMENSIONS := 84
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDMIPLEVELS := 85
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDMISCFLAGS := 86
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDARG_RETURN := 87
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_OUTOFMEMORY_RETURN := 88
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_NULLDESC := 89
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_LARGEALLOCATION := 90
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDFORMAT := 91
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_UNSUPPORTEDFORMAT := 92
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDSAMPLES := 93
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDUSAGE := 94
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDBINDFLAGS := 95
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDCPUACCESSFLAGS := 96
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDMISCFLAGS := 97
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDCPUACCESSFLAGS := 98
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDBINDFLAGS := 99
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDINITIALDATA := 100
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDDIMENSIONS := 101
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDMIPLEVELS := 102
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDMISCFLAGS := 103
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDARG_RETURN := 104
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_OUTOFMEMORY_RETURN := 105
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_NULLDESC := 106
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_LARGEALLOCATION := 107
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDFORMAT := 108
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_UNSUPPORTEDFORMAT := 109
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDSAMPLES := 110
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDUSAGE := 111
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDBINDFLAGS := 112
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDCPUACCESSFLAGS := 113
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDMISCFLAGS := 114
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDCPUACCESSFLAGS := 115
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDBINDFLAGS := 116
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDINITIALDATA := 117
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDDIMENSIONS := 118
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDMIPLEVELS := 119
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDMISCFLAGS := 120
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDARG_RETURN := 121
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_OUTOFMEMORY_RETURN := 122
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_NULLDESC := 123
    static D3D11_MESSAGE_ID_CREATETEXTURE3D_LARGEALLOCATION := 124
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_UNRECOGNIZEDFORMAT := 125
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDESC := 126
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFORMAT := 127
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDIMENSIONS := 128
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDRESOURCE := 129
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_TOOMANYOBJECTS := 130
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDARG_RETURN := 131
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_OUTOFMEMORY_RETURN := 132
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_UNRECOGNIZEDFORMAT := 133
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_UNSUPPORTEDFORMAT := 134
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDESC := 135
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDFORMAT := 136
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDIMENSIONS := 137
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDRESOURCE := 138
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_TOOMANYOBJECTS := 139
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDARG_RETURN := 140
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_OUTOFMEMORY_RETURN := 141
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_UNRECOGNIZEDFORMAT := 142
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDESC := 143
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFORMAT := 144
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDIMENSIONS := 145
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDRESOURCE := 146
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_TOOMANYOBJECTS := 147
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDARG_RETURN := 148
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_OUTOFMEMORY_RETURN := 149
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_OUTOFMEMORY := 150
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_TOOMANYELEMENTS := 151
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDFORMAT := 152
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INCOMPATIBLEFORMAT := 153
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOT := 154
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDINPUTSLOTCLASS := 155
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_STEPRATESLOTCLASSMISMATCH := 156
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOTCLASSCHANGE := 157
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSTEPRATECHANGE := 158
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDALIGNMENT := 159
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_DUPLICATESEMANTIC := 160
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_UNPARSEABLEINPUTSIGNATURE := 161
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_NULLSEMANTIC := 162
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_MISSINGELEMENT := 163
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_NULLDESC := 164
    static D3D11_MESSAGE_ID_CREATEVERTEXSHADER_OUTOFMEMORY := 165
    static D3D11_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERBYTECODE := 166
    static D3D11_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERTYPE := 167
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_OUTOFMEMORY := 168
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERBYTECODE := 169
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERTYPE := 170
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTOFMEMORY := 171
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERBYTECODE := 172
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE := 173
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMENTRIES := 174
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSTREAMSTRIDEUNUSED := 175
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDDECL := 176
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_EXPECTEDDECL := 177
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSLOT0EXPECTED := 178
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSLOT := 179
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_ONLYONEELEMENTPERSLOT := 180
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCOMPONENTCOUNT := 181
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTARTCOMPONENTANDCOMPONENTCOUNT := 182
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDGAPDEFINITION := 183
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_REPEATEDOUTPUT := 184
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSTREAMSTRIDE := 185
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGSEMANTIC := 186
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MASKMISMATCH := 187
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_CANTHAVEONLYGAPS := 188
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DECLTOOCOMPLEX := 189
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGOUTPUTSIGNATURE := 190
    static D3D11_MESSAGE_ID_CREATEPIXELSHADER_OUTOFMEMORY := 191
    static D3D11_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERBYTECODE := 192
    static D3D11_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERTYPE := 193
    static D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFILLMODE := 194
    static D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDCULLMODE := 195
    static D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDDEPTHBIASCLAMP := 196
    static D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDSLOPESCALEDDEPTHBIAS := 197
    static D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_TOOMANYOBJECTS := 198
    static D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_NULLDESC := 199
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHWRITEMASK := 200
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHFUNC := 201
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFAILOP := 202
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILZFAILOP := 203
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILPASSOP := 204
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFUNC := 205
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFAILOP := 206
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILZFAILOP := 207
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILPASSOP := 208
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFUNC := 209
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_TOOMANYOBJECTS := 210
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_NULLDESC := 211
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLEND := 212
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLEND := 213
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOP := 214
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLENDALPHA := 215
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLENDALPHA := 216
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOPALPHA := 217
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDRENDERTARGETWRITEMASK := 218
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_TOOMANYOBJECTS := 219
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_NULLDESC := 220
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDFILTER := 221
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSU := 222
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSV := 223
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSW := 224
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMIPLODBIAS := 225
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXANISOTROPY := 226
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDCOMPARISONFUNC := 227
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMINLOD := 228
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXLOD := 229
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_TOOMANYOBJECTS := 230
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_NULLDESC := 231
    static D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDQUERY := 232
    static D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDMISCFLAGS := 233
    static D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_UNEXPECTEDMISCFLAG := 234
    static D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_NULLDESC := 235
    static D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNRECOGNIZED := 236
    static D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNDEFINED := 237
    static D3D11_MESSAGE_ID_IASETVERTEXBUFFERS_INVALIDBUFFER := 238
    static D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_OFFSET_TOO_LARGE := 239
    static D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_BUFFERS_EMPTY := 240
    static D3D11_MESSAGE_ID_IASETINDEXBUFFER_INVALIDBUFFER := 241
    static D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_FORMAT_INVALID := 242
    static D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_TOO_LARGE := 243
    static D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_UNALIGNED := 244
    static D3D11_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_VIEWS_EMPTY := 245
    static D3D11_MESSAGE_ID_VSSETCONSTANTBUFFERS_INVALIDBUFFER := 246
    static D3D11_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_BUFFERS_EMPTY := 247
    static D3D11_MESSAGE_ID_DEVICE_VSSETSAMPLERS_SAMPLERS_EMPTY := 248
    static D3D11_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_VIEWS_EMPTY := 249
    static D3D11_MESSAGE_ID_GSSETCONSTANTBUFFERS_INVALIDBUFFER := 250
    static D3D11_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_BUFFERS_EMPTY := 251
    static D3D11_MESSAGE_ID_DEVICE_GSSETSAMPLERS_SAMPLERS_EMPTY := 252
    static D3D11_MESSAGE_ID_SOSETTARGETS_INVALIDBUFFER := 253
    static D3D11_MESSAGE_ID_DEVICE_SOSETTARGETS_OFFSET_UNALIGNED := 254
    static D3D11_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_VIEWS_EMPTY := 255
    static D3D11_MESSAGE_ID_PSSETCONSTANTBUFFERS_INVALIDBUFFER := 256
    static D3D11_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_BUFFERS_EMPTY := 257
    static D3D11_MESSAGE_ID_DEVICE_PSSETSAMPLERS_SAMPLERS_EMPTY := 258
    static D3D11_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_INVALIDVIEWPORT := 259
    static D3D11_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_INVALIDSCISSOR := 260
    static D3D11_MESSAGE_ID_CLEARRENDERTARGETVIEW_DENORMFLUSH := 261
    static D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_DENORMFLUSH := 262
    static D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_INVALID := 263
    static D3D11_MESSAGE_ID_DEVICE_IAGETVERTEXBUFFERS_BUFFERS_EMPTY := 264
    static D3D11_MESSAGE_ID_DEVICE_VSGETSHADERRESOURCES_VIEWS_EMPTY := 265
    static D3D11_MESSAGE_ID_DEVICE_VSGETCONSTANTBUFFERS_BUFFERS_EMPTY := 266
    static D3D11_MESSAGE_ID_DEVICE_VSGETSAMPLERS_SAMPLERS_EMPTY := 267
    static D3D11_MESSAGE_ID_DEVICE_GSGETSHADERRESOURCES_VIEWS_EMPTY := 268
    static D3D11_MESSAGE_ID_DEVICE_GSGETCONSTANTBUFFERS_BUFFERS_EMPTY := 269
    static D3D11_MESSAGE_ID_DEVICE_GSGETSAMPLERS_SAMPLERS_EMPTY := 270
    static D3D11_MESSAGE_ID_DEVICE_SOGETTARGETS_BUFFERS_EMPTY := 271
    static D3D11_MESSAGE_ID_DEVICE_PSGETSHADERRESOURCES_VIEWS_EMPTY := 272
    static D3D11_MESSAGE_ID_DEVICE_PSGETCONSTANTBUFFERS_BUFFERS_EMPTY := 273
    static D3D11_MESSAGE_ID_DEVICE_PSGETSAMPLERS_SAMPLERS_EMPTY := 274
    static D3D11_MESSAGE_ID_DEVICE_RSGETVIEWPORTS_VIEWPORTS_EMPTY := 275
    static D3D11_MESSAGE_ID_DEVICE_RSGETSCISSORRECTS_RECTS_EMPTY := 276
    static D3D11_MESSAGE_ID_DEVICE_GENERATEMIPS_RESOURCE_INVALID := 277
    static D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSUBRESOURCE := 278
    static D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESUBRESOURCE := 279
    static D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCEBOX := 280
    static D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCE := 281
    static D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSTATE := 282
    static D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESTATE := 283
    static D3D11_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCE := 284
    static D3D11_MESSAGE_ID_COPYRESOURCE_INVALIDDESTINATIONSTATE := 285
    static D3D11_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCESTATE := 286
    static D3D11_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSUBRESOURCE := 287
    static D3D11_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONBOX := 288
    static D3D11_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSTATE := 289
    static D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_INVALID := 290
    static D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_SUBRESOURCE_INVALID := 291
    static D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_INVALID := 292
    static D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_SUBRESOURCE_INVALID := 293
    static D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_FORMAT_INVALID := 294
    static D3D11_MESSAGE_ID_BUFFER_MAP_INVALIDMAPTYPE := 295
    static D3D11_MESSAGE_ID_BUFFER_MAP_INVALIDFLAGS := 296
    static D3D11_MESSAGE_ID_BUFFER_MAP_ALREADYMAPPED := 297
    static D3D11_MESSAGE_ID_BUFFER_MAP_DEVICEREMOVED_RETURN := 298
    static D3D11_MESSAGE_ID_BUFFER_UNMAP_NOTMAPPED := 299
    static D3D11_MESSAGE_ID_TEXTURE1D_MAP_INVALIDMAPTYPE := 300
    static D3D11_MESSAGE_ID_TEXTURE1D_MAP_INVALIDSUBRESOURCE := 301
    static D3D11_MESSAGE_ID_TEXTURE1D_MAP_INVALIDFLAGS := 302
    static D3D11_MESSAGE_ID_TEXTURE1D_MAP_ALREADYMAPPED := 303
    static D3D11_MESSAGE_ID_TEXTURE1D_MAP_DEVICEREMOVED_RETURN := 304
    static D3D11_MESSAGE_ID_TEXTURE1D_UNMAP_INVALIDSUBRESOURCE := 305
    static D3D11_MESSAGE_ID_TEXTURE1D_UNMAP_NOTMAPPED := 306
    static D3D11_MESSAGE_ID_TEXTURE2D_MAP_INVALIDMAPTYPE := 307
    static D3D11_MESSAGE_ID_TEXTURE2D_MAP_INVALIDSUBRESOURCE := 308
    static D3D11_MESSAGE_ID_TEXTURE2D_MAP_INVALIDFLAGS := 309
    static D3D11_MESSAGE_ID_TEXTURE2D_MAP_ALREADYMAPPED := 310
    static D3D11_MESSAGE_ID_TEXTURE2D_MAP_DEVICEREMOVED_RETURN := 311
    static D3D11_MESSAGE_ID_TEXTURE2D_UNMAP_INVALIDSUBRESOURCE := 312
    static D3D11_MESSAGE_ID_TEXTURE2D_UNMAP_NOTMAPPED := 313
    static D3D11_MESSAGE_ID_TEXTURE3D_MAP_INVALIDMAPTYPE := 314
    static D3D11_MESSAGE_ID_TEXTURE3D_MAP_INVALIDSUBRESOURCE := 315
    static D3D11_MESSAGE_ID_TEXTURE3D_MAP_INVALIDFLAGS := 316
    static D3D11_MESSAGE_ID_TEXTURE3D_MAP_ALREADYMAPPED := 317
    static D3D11_MESSAGE_ID_TEXTURE3D_MAP_DEVICEREMOVED_RETURN := 318
    static D3D11_MESSAGE_ID_TEXTURE3D_UNMAP_INVALIDSUBRESOURCE := 319
    static D3D11_MESSAGE_ID_TEXTURE3D_UNMAP_NOTMAPPED := 320
    static D3D11_MESSAGE_ID_CHECKFORMATSUPPORT_FORMAT_DEPRECATED := 321
    static D3D11_MESSAGE_ID_CHECKMULTISAMPLEQUALITYLEVELS_FORMAT_DEPRECATED := 322
    static D3D11_MESSAGE_ID_SETEXCEPTIONMODE_UNRECOGNIZEDFLAGS := 323
    static D3D11_MESSAGE_ID_SETEXCEPTIONMODE_INVALIDARG_RETURN := 324
    static D3D11_MESSAGE_ID_SETEXCEPTIONMODE_DEVICEREMOVED_RETURN := 325
    static D3D11_MESSAGE_ID_REF_SIMULATING_INFINITELY_FAST_HARDWARE := 326
    static D3D11_MESSAGE_ID_REF_THREADING_MODE := 327
    static D3D11_MESSAGE_ID_REF_UMDRIVER_EXCEPTION := 328
    static D3D11_MESSAGE_ID_REF_KMDRIVER_EXCEPTION := 329
    static D3D11_MESSAGE_ID_REF_HARDWARE_EXCEPTION := 330
    static D3D11_MESSAGE_ID_REF_ACCESSING_INDEXABLE_TEMP_OUT_OF_RANGE := 331
    static D3D11_MESSAGE_ID_REF_PROBLEM_PARSING_SHADER := 332
    static D3D11_MESSAGE_ID_REF_OUT_OF_MEMORY := 333
    static D3D11_MESSAGE_ID_REF_INFO := 334
    static D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEXPOS_OVERFLOW := 335
    static D3D11_MESSAGE_ID_DEVICE_DRAWINDEXED_INDEXPOS_OVERFLOW := 336
    static D3D11_MESSAGE_ID_DEVICE_DRAWINSTANCED_VERTEXPOS_OVERFLOW := 337
    static D3D11_MESSAGE_ID_DEVICE_DRAWINSTANCED_INSTANCEPOS_OVERFLOW := 338
    static D3D11_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INSTANCEPOS_OVERFLOW := 339
    static D3D11_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INDEXPOS_OVERFLOW := 340
    static D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_SHADER_NOT_SET := 341
    static D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SEMANTICNAME_NOT_FOUND := 342
    static D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERINDEX := 343
    static D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_COMPONENTTYPE := 344
    static D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERMASK := 345
    static D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SYSTEMVALUE := 346
    static D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_NEVERWRITTEN_ALWAYSREADS := 347
    static D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_NOT_SET := 348
    static D3D11_MESSAGE_ID_DEVICE_DRAW_INPUTLAYOUT_NOT_SET := 349
    static D3D11_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_NOT_SET := 350
    static D3D11_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_TOO_SMALL := 351
    static D3D11_MESSAGE_ID_DEVICE_DRAW_SAMPLER_NOT_SET := 352
    static D3D11_MESSAGE_ID_DEVICE_DRAW_SHADERRESOURCEVIEW_NOT_SET := 353
    static D3D11_MESSAGE_ID_DEVICE_DRAW_VIEW_DIMENSION_MISMATCH := 354
    static D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL := 355
    static D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_TOO_SMALL := 356
    static D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_NOT_SET := 357
    static D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_FORMAT_INVALID := 358
    static D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_TOO_SMALL := 359
    static D3D11_MESSAGE_ID_DEVICE_DRAW_GS_INPUT_PRIMITIVE_MISMATCH := 360
    static D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_RETURN_TYPE_MISMATCH := 361
    static D3D11_MESSAGE_ID_DEVICE_DRAW_POSITION_NOT_PRESENT := 362
    static D3D11_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_NOT_SET := 363
    static D3D11_MESSAGE_ID_DEVICE_DRAW_BOUND_RESOURCE_MAPPED := 364
    static D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_PRIMITIVETOPOLOGY := 365
    static D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_OFFSET_UNALIGNED := 366
    static D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_STRIDE_UNALIGNED := 367
    static D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_OFFSET_UNALIGNED := 368
    static D3D11_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_OFFSET_UNALIGNED := 369
    static D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_LD_UNSUPPORTED := 370
    static D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_UNSUPPORTED := 371
    static D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_C_UNSUPPORTED := 372
    static D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_MULTISAMPLE_UNSUPPORTED := 373
    static D3D11_MESSAGE_ID_DEVICE_DRAW_SO_TARGETS_BOUND_WITHOUT_SOURCE := 374
    static D3D11_MESSAGE_ID_DEVICE_DRAW_SO_STRIDE_LARGER_THAN_BUFFER := 375
    static D3D11_MESSAGE_ID_DEVICE_DRAW_OM_RENDER_TARGET_DOES_NOT_SUPPORT_BLENDING := 376
    static D3D11_MESSAGE_ID_DEVICE_DRAW_OM_DUAL_SOURCE_BLENDING_CAN_ONLY_HAVE_RENDER_TARGET_0 := 377
    static D3D11_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_AT_FAULT := 378
    static D3D11_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_POSSIBLY_AT_FAULT := 379
    static D3D11_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_NOT_AT_FAULT := 380
    static D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_INVALIDARG_RETURN := 381
    static D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_OUTOFMEMORY_RETURN := 382
    static D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_BADINTERFACE_RETURN := 383
    static D3D11_MESSAGE_ID_DEVICE_DRAW_VIEWPORT_NOT_SET := 384
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_TRAILING_DIGIT_IN_SEMANTIC := 385
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_TRAILING_DIGIT_IN_SEMANTIC := 386
    static D3D11_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_DENORMFLUSH := 387
    static D3D11_MESSAGE_ID_OMSETRENDERTARGETS_INVALIDVIEW := 388
    static D3D11_MESSAGE_ID_DEVICE_SETTEXTFILTERSIZE_INVALIDDIMENSIONS := 389
    static D3D11_MESSAGE_ID_DEVICE_DRAW_SAMPLER_MISMATCH := 390
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_TYPE_MISMATCH := 391
    static D3D11_MESSAGE_ID_BLENDSTATE_GETDESC_LEGACY := 392
    static D3D11_MESSAGE_ID_SHADERRESOURCEVIEW_GETDESC_LEGACY := 393
    static D3D11_MESSAGE_ID_CREATEQUERY_OUTOFMEMORY_RETURN := 394
    static D3D11_MESSAGE_ID_CREATEPREDICATE_OUTOFMEMORY_RETURN := 395
    static D3D11_MESSAGE_ID_CREATECOUNTER_OUTOFRANGE_COUNTER := 396
    static D3D11_MESSAGE_ID_CREATECOUNTER_SIMULTANEOUS_ACTIVE_COUNTERS_EXHAUSTED := 397
    static D3D11_MESSAGE_ID_CREATECOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER := 398
    static D3D11_MESSAGE_ID_CREATECOUNTER_OUTOFMEMORY_RETURN := 399
    static D3D11_MESSAGE_ID_CREATECOUNTER_NONEXCLUSIVE_RETURN := 400
    static D3D11_MESSAGE_ID_CREATECOUNTER_NULLDESC := 401
    static D3D11_MESSAGE_ID_CHECKCOUNTER_OUTOFRANGE_COUNTER := 402
    static D3D11_MESSAGE_ID_CHECKCOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER := 403
    static D3D11_MESSAGE_ID_SETPREDICATION_INVALID_PREDICATE_STATE := 404
    static D3D11_MESSAGE_ID_QUERY_BEGIN_UNSUPPORTED := 405
    static D3D11_MESSAGE_ID_PREDICATE_BEGIN_DURING_PREDICATION := 406
    static D3D11_MESSAGE_ID_QUERY_BEGIN_DUPLICATE := 407
    static D3D11_MESSAGE_ID_QUERY_BEGIN_ABANDONING_PREVIOUS_RESULTS := 408
    static D3D11_MESSAGE_ID_PREDICATE_END_DURING_PREDICATION := 409
    static D3D11_MESSAGE_ID_QUERY_END_ABANDONING_PREVIOUS_RESULTS := 410
    static D3D11_MESSAGE_ID_QUERY_END_WITHOUT_BEGIN := 411
    static D3D11_MESSAGE_ID_QUERY_GETDATA_INVALID_DATASIZE := 412
    static D3D11_MESSAGE_ID_QUERY_GETDATA_INVALID_FLAGS := 413
    static D3D11_MESSAGE_ID_QUERY_GETDATA_INVALID_CALL := 414
    static D3D11_MESSAGE_ID_DEVICE_DRAW_PS_OUTPUT_TYPE_MISMATCH := 415
    static D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_GATHER_UNSUPPORTED := 416
    static D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_USE_OF_CENTER_MULTISAMPLE_PATTERN := 417
    static D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_STRIDE_TOO_LARGE := 418
    static D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_INVALIDRANGE := 419
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_EMPTY_LAYOUT := 420
    static D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_SAMPLE_COUNT_MISMATCH := 421
    static D3D11_MESSAGE_ID_LIVE_OBJECT_SUMMARY := 422
    static D3D11_MESSAGE_ID_LIVE_BUFFER := 423
    static D3D11_MESSAGE_ID_LIVE_TEXTURE1D := 424
    static D3D11_MESSAGE_ID_LIVE_TEXTURE2D := 425
    static D3D11_MESSAGE_ID_LIVE_TEXTURE3D := 426
    static D3D11_MESSAGE_ID_LIVE_SHADERRESOURCEVIEW := 427
    static D3D11_MESSAGE_ID_LIVE_RENDERTARGETVIEW := 428
    static D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILVIEW := 429
    static D3D11_MESSAGE_ID_LIVE_VERTEXSHADER := 430
    static D3D11_MESSAGE_ID_LIVE_GEOMETRYSHADER := 431
    static D3D11_MESSAGE_ID_LIVE_PIXELSHADER := 432
    static D3D11_MESSAGE_ID_LIVE_INPUTLAYOUT := 433
    static D3D11_MESSAGE_ID_LIVE_SAMPLER := 434
    static D3D11_MESSAGE_ID_LIVE_BLENDSTATE := 435
    static D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILSTATE := 436
    static D3D11_MESSAGE_ID_LIVE_RASTERIZERSTATE := 437
    static D3D11_MESSAGE_ID_LIVE_QUERY := 438
    static D3D11_MESSAGE_ID_LIVE_PREDICATE := 439
    static D3D11_MESSAGE_ID_LIVE_COUNTER := 440
    static D3D11_MESSAGE_ID_LIVE_DEVICE := 441
    static D3D11_MESSAGE_ID_LIVE_SWAPCHAIN := 442
    static D3D11_MESSAGE_ID_D3D10_MESSAGES_END := 443
    static D3D11_MESSAGE_ID_D3D10L9_MESSAGES_START := 1048576
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_STENCIL_NO_TWO_SIDED := 1048577
    static D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_DepthBiasClamp_NOT_SUPPORTED := 1048578
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_NO_COMPARISON_SUPPORT := 1048579
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_EXCESSIVE_ANISOTROPY := 1048580
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_OUT_OF_RANGE := 1048581
    static D3D11_MESSAGE_ID_VSSETSAMPLERS_NOT_SUPPORTED := 1048582
    static D3D11_MESSAGE_ID_VSSETSAMPLERS_TOO_MANY_SAMPLERS := 1048583
    static D3D11_MESSAGE_ID_PSSETSAMPLERS_TOO_MANY_SAMPLERS := 1048584
    static D3D11_MESSAGE_ID_CREATERESOURCE_NO_ARRAYS := 1048585
    static D3D11_MESSAGE_ID_CREATERESOURCE_NO_VB_AND_IB_BIND := 1048586
    static D3D11_MESSAGE_ID_CREATERESOURCE_NO_TEXTURE_1D := 1048587
    static D3D11_MESSAGE_ID_CREATERESOURCE_DIMENSION_OUT_OF_RANGE := 1048588
    static D3D11_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_SHADER_RESOURCE := 1048589
    static D3D11_MESSAGE_ID_OMSETRENDERTARGETS_TOO_MANY_RENDER_TARGETS := 1048590
    static D3D11_MESSAGE_ID_OMSETRENDERTARGETS_NO_DIFFERING_BIT_DEPTHS := 1048591
    static D3D11_MESSAGE_ID_IASETVERTEXBUFFERS_BAD_BUFFER_INDEX := 1048592
    static D3D11_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_TOO_MANY_VIEWPORTS := 1048593
    static D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_ADJACENCY_UNSUPPORTED := 1048594
    static D3D11_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_TOO_MANY_SCISSORS := 1048595
    static D3D11_MESSAGE_ID_COPYRESOURCE_ONLY_TEXTURE_2D_WITHIN_GPU_MEMORY := 1048596
    static D3D11_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_3D_READBACK := 1048597
    static D3D11_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_ONLY_READBACK := 1048598
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_UNSUPPORTED_FORMAT := 1048599
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_ALPHA_TO_COVERAGE := 1048600
    static D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_DepthClipEnable_MUST_BE_TRUE := 1048601
    static D3D11_MESSAGE_ID_DRAWINDEXED_STARTINDEXLOCATION_MUST_BE_POSITIVE := 1048602
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_MUST_USE_LOWEST_LOD := 1048603
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_MINLOD_MUST_NOT_BE_FRACTIONAL := 1048604
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_MAXLOD_MUST_BE_FLT_MAX := 1048605
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_FIRSTARRAYSLICE_MUST_BE_ZERO := 1048606
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_CUBES_MUST_HAVE_6_SIDES := 1048607
    static D3D11_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_RENDER_TARGET := 1048608
    static D3D11_MESSAGE_ID_CREATERESOURCE_NO_DWORD_INDEX_BUFFER := 1048609
    static D3D11_MESSAGE_ID_CREATERESOURCE_MSAA_PRECLUDES_SHADER_RESOURCE := 1048610
    static D3D11_MESSAGE_ID_CREATERESOURCE_PRESENTATION_PRECLUDES_SHADER_RESOURCE := 1048611
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_BLEND_ENABLE := 1048612
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_WRITE_MASKS := 1048613
    static D3D11_MESSAGE_ID_CREATERESOURCE_NO_STREAM_OUT := 1048614
    static D3D11_MESSAGE_ID_CREATERESOURCE_ONLY_VB_IB_FOR_BUFFERS := 1048615
    static D3D11_MESSAGE_ID_CREATERESOURCE_NO_AUTOGEN_FOR_VOLUMES := 1048616
    static D3D11_MESSAGE_ID_CREATERESOURCE_DXGI_FORMAT_R8G8B8A8_CANNOT_BE_SHARED := 1048617
    static D3D11_MESSAGE_ID_VSSHADERRESOURCES_NOT_SUPPORTED := 1048618
    static D3D11_MESSAGE_ID_GEOMETRY_SHADER_NOT_SUPPORTED := 1048619
    static D3D11_MESSAGE_ID_STREAM_OUT_NOT_SUPPORTED := 1048620
    static D3D11_MESSAGE_ID_TEXT_FILTER_NOT_SUPPORTED := 1048621
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_SEPARATE_ALPHA_BLEND := 1048622
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_MRT_BLEND := 1048623
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_OPERATION_NOT_SUPPORTED := 1048624
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_NO_MIRRORONCE := 1048625
    static D3D11_MESSAGE_ID_DRAWINSTANCED_NOT_SUPPORTED := 1048626
    static D3D11_MESSAGE_ID_DRAWINDEXEDINSTANCED_NOT_SUPPORTED_BELOW_9_3 := 1048627
    static D3D11_MESSAGE_ID_DRAWINDEXED_POINTLIST_UNSUPPORTED := 1048628
    static D3D11_MESSAGE_ID_SETBLENDSTATE_SAMPLE_MASK_CANNOT_BE_ZERO := 1048629
    static D3D11_MESSAGE_ID_CREATERESOURCE_DIMENSION_EXCEEDS_FEATURE_LEVEL_DEFINITION := 1048630
    static D3D11_MESSAGE_ID_CREATERESOURCE_ONLY_SINGLE_MIP_LEVEL_DEPTH_STENCIL_SUPPORTED := 1048631
    static D3D11_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_NEGATIVESCISSOR := 1048632
    static D3D11_MESSAGE_ID_SLOT_ZERO_MUST_BE_D3D10_INPUT_PER_VERTEX_DATA := 1048633
    static D3D11_MESSAGE_ID_CREATERESOURCE_NON_POW_2_MIPMAP := 1048634
    static D3D11_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_NOT_SUPPORTED := 1048635
    static D3D11_MESSAGE_ID_OMSETRENDERTARGETS_NO_SRGB_MRT := 1048636
    static D3D11_MESSAGE_ID_COPYRESOURCE_NO_3D_MISMATCHED_UPDATES := 1048637
    static D3D11_MESSAGE_ID_D3D10L9_MESSAGES_END := 1048638
    static D3D11_MESSAGE_ID_D3D11_MESSAGES_START := 2097152
    static D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFLAGS := 2097153
    static D3D11_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDCLASSLINKAGE := 2097154
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDCLASSLINKAGE := 2097155
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMSTREAMS := 2097156
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAMTORASTERIZER := 2097157
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDSTREAMS := 2097158
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCLASSLINKAGE := 2097159
    static D3D11_MESSAGE_ID_CREATEPIXELSHADER_INVALIDCLASSLINKAGE := 2097160
    static D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_INVALID_COMMANDLISTFLAGS := 2097161
    static D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_SINGLETHREADED := 2097162
    static D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_INVALIDARG_RETURN := 2097163
    static D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_INVALID_CALL_RETURN := 2097164
    static D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_OUTOFMEMORY_RETURN := 2097165
    static D3D11_MESSAGE_ID_FINISHDISPLAYLIST_ONIMMEDIATECONTEXT := 2097166
    static D3D11_MESSAGE_ID_FINISHDISPLAYLIST_OUTOFMEMORY_RETURN := 2097167
    static D3D11_MESSAGE_ID_FINISHDISPLAYLIST_INVALID_CALL_RETURN := 2097168
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAM := 2097169
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDENTRIES := 2097170
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDSTRIDES := 2097171
    static D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMSTRIDES := 2097172
    static D3D11_MESSAGE_ID_DEVICE_HSSETSHADERRESOURCES_HAZARD := 2097173
    static D3D11_MESSAGE_ID_DEVICE_HSSETCONSTANTBUFFERS_HAZARD := 2097174
    static D3D11_MESSAGE_ID_HSSETSHADERRESOURCES_UNBINDDELETINGOBJECT := 2097175
    static D3D11_MESSAGE_ID_HSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT := 2097176
    static D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDCALL := 2097177
    static D3D11_MESSAGE_ID_CREATEHULLSHADER_OUTOFMEMORY := 2097178
    static D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDSHADERBYTECODE := 2097179
    static D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDSHADERTYPE := 2097180
    static D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDCLASSLINKAGE := 2097181
    static D3D11_MESSAGE_ID_DEVICE_HSSETSHADERRESOURCES_VIEWS_EMPTY := 2097182
    static D3D11_MESSAGE_ID_HSSETCONSTANTBUFFERS_INVALIDBUFFER := 2097183
    static D3D11_MESSAGE_ID_DEVICE_HSSETCONSTANTBUFFERS_BUFFERS_EMPTY := 2097184
    static D3D11_MESSAGE_ID_DEVICE_HSSETSAMPLERS_SAMPLERS_EMPTY := 2097185
    static D3D11_MESSAGE_ID_DEVICE_HSGETSHADERRESOURCES_VIEWS_EMPTY := 2097186
    static D3D11_MESSAGE_ID_DEVICE_HSGETCONSTANTBUFFERS_BUFFERS_EMPTY := 2097187
    static D3D11_MESSAGE_ID_DEVICE_HSGETSAMPLERS_SAMPLERS_EMPTY := 2097188
    static D3D11_MESSAGE_ID_DEVICE_DSSETSHADERRESOURCES_HAZARD := 2097189
    static D3D11_MESSAGE_ID_DEVICE_DSSETCONSTANTBUFFERS_HAZARD := 2097190
    static D3D11_MESSAGE_ID_DSSETSHADERRESOURCES_UNBINDDELETINGOBJECT := 2097191
    static D3D11_MESSAGE_ID_DSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT := 2097192
    static D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDCALL := 2097193
    static D3D11_MESSAGE_ID_CREATEDOMAINSHADER_OUTOFMEMORY := 2097194
    static D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDSHADERBYTECODE := 2097195
    static D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDSHADERTYPE := 2097196
    static D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDCLASSLINKAGE := 2097197
    static D3D11_MESSAGE_ID_DEVICE_DSSETSHADERRESOURCES_VIEWS_EMPTY := 2097198
    static D3D11_MESSAGE_ID_DSSETCONSTANTBUFFERS_INVALIDBUFFER := 2097199
    static D3D11_MESSAGE_ID_DEVICE_DSSETCONSTANTBUFFERS_BUFFERS_EMPTY := 2097200
    static D3D11_MESSAGE_ID_DEVICE_DSSETSAMPLERS_SAMPLERS_EMPTY := 2097201
    static D3D11_MESSAGE_ID_DEVICE_DSGETSHADERRESOURCES_VIEWS_EMPTY := 2097202
    static D3D11_MESSAGE_ID_DEVICE_DSGETCONSTANTBUFFERS_BUFFERS_EMPTY := 2097203
    static D3D11_MESSAGE_ID_DEVICE_DSGETSAMPLERS_SAMPLERS_EMPTY := 2097204
    static D3D11_MESSAGE_ID_DEVICE_DRAW_HS_XOR_DS_MISMATCH := 2097205
    static D3D11_MESSAGE_ID_DEFERRED_CONTEXT_REMOVAL_PROCESS_AT_FAULT := 2097206
    static D3D11_MESSAGE_ID_DEVICE_DRAWINDIRECT_INVALID_ARG_BUFFER := 2097207
    static D3D11_MESSAGE_ID_DEVICE_DRAWINDIRECT_OFFSET_UNALIGNED := 2097208
    static D3D11_MESSAGE_ID_DEVICE_DRAWINDIRECT_OFFSET_OVERFLOW := 2097209
    static D3D11_MESSAGE_ID_RESOURCE_MAP_INVALIDMAPTYPE := 2097210
    static D3D11_MESSAGE_ID_RESOURCE_MAP_INVALIDSUBRESOURCE := 2097211
    static D3D11_MESSAGE_ID_RESOURCE_MAP_INVALIDFLAGS := 2097212
    static D3D11_MESSAGE_ID_RESOURCE_MAP_ALREADYMAPPED := 2097213
    static D3D11_MESSAGE_ID_RESOURCE_MAP_DEVICEREMOVED_RETURN := 2097214
    static D3D11_MESSAGE_ID_RESOURCE_MAP_OUTOFMEMORY_RETURN := 2097215
    static D3D11_MESSAGE_ID_RESOURCE_MAP_WITHOUT_INITIAL_DISCARD := 2097216
    static D3D11_MESSAGE_ID_RESOURCE_UNMAP_INVALIDSUBRESOURCE := 2097217
    static D3D11_MESSAGE_ID_RESOURCE_UNMAP_NOTMAPPED := 2097218
    static D3D11_MESSAGE_ID_DEVICE_DRAW_RASTERIZING_CONTROL_POINTS := 2097219
    static D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNSUPPORTED := 2097220
    static D3D11_MESSAGE_ID_DEVICE_DRAW_HS_DS_SIGNATURE_MISMATCH := 2097221
    static D3D11_MESSAGE_ID_DEVICE_DRAW_HULL_SHADER_INPUT_TOPOLOGY_MISMATCH := 2097222
    static D3D11_MESSAGE_ID_DEVICE_DRAW_HS_DS_CONTROL_POINT_COUNT_MISMATCH := 2097223
    static D3D11_MESSAGE_ID_DEVICE_DRAW_HS_DS_TESSELLATOR_DOMAIN_MISMATCH := 2097224
    static D3D11_MESSAGE_ID_CREATE_CONTEXT := 2097225
    static D3D11_MESSAGE_ID_LIVE_CONTEXT := 2097226
    static D3D11_MESSAGE_ID_DESTROY_CONTEXT := 2097227
    static D3D11_MESSAGE_ID_CREATE_BUFFER := 2097228
    static D3D11_MESSAGE_ID_LIVE_BUFFER_WIN7 := 2097229
    static D3D11_MESSAGE_ID_DESTROY_BUFFER := 2097230
    static D3D11_MESSAGE_ID_CREATE_TEXTURE1D := 2097231
    static D3D11_MESSAGE_ID_LIVE_TEXTURE1D_WIN7 := 2097232
    static D3D11_MESSAGE_ID_DESTROY_TEXTURE1D := 2097233
    static D3D11_MESSAGE_ID_CREATE_TEXTURE2D := 2097234
    static D3D11_MESSAGE_ID_LIVE_TEXTURE2D_WIN7 := 2097235
    static D3D11_MESSAGE_ID_DESTROY_TEXTURE2D := 2097236
    static D3D11_MESSAGE_ID_CREATE_TEXTURE3D := 2097237
    static D3D11_MESSAGE_ID_LIVE_TEXTURE3D_WIN7 := 2097238
    static D3D11_MESSAGE_ID_DESTROY_TEXTURE3D := 2097239
    static D3D11_MESSAGE_ID_CREATE_SHADERRESOURCEVIEW := 2097240
    static D3D11_MESSAGE_ID_LIVE_SHADERRESOURCEVIEW_WIN7 := 2097241
    static D3D11_MESSAGE_ID_DESTROY_SHADERRESOURCEVIEW := 2097242
    static D3D11_MESSAGE_ID_CREATE_RENDERTARGETVIEW := 2097243
    static D3D11_MESSAGE_ID_LIVE_RENDERTARGETVIEW_WIN7 := 2097244
    static D3D11_MESSAGE_ID_DESTROY_RENDERTARGETVIEW := 2097245
    static D3D11_MESSAGE_ID_CREATE_DEPTHSTENCILVIEW := 2097246
    static D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILVIEW_WIN7 := 2097247
    static D3D11_MESSAGE_ID_DESTROY_DEPTHSTENCILVIEW := 2097248
    static D3D11_MESSAGE_ID_CREATE_VERTEXSHADER := 2097249
    static D3D11_MESSAGE_ID_LIVE_VERTEXSHADER_WIN7 := 2097250
    static D3D11_MESSAGE_ID_DESTROY_VERTEXSHADER := 2097251
    static D3D11_MESSAGE_ID_CREATE_HULLSHADER := 2097252
    static D3D11_MESSAGE_ID_LIVE_HULLSHADER := 2097253
    static D3D11_MESSAGE_ID_DESTROY_HULLSHADER := 2097254
    static D3D11_MESSAGE_ID_CREATE_DOMAINSHADER := 2097255
    static D3D11_MESSAGE_ID_LIVE_DOMAINSHADER := 2097256
    static D3D11_MESSAGE_ID_DESTROY_DOMAINSHADER := 2097257
    static D3D11_MESSAGE_ID_CREATE_GEOMETRYSHADER := 2097258
    static D3D11_MESSAGE_ID_LIVE_GEOMETRYSHADER_WIN7 := 2097259
    static D3D11_MESSAGE_ID_DESTROY_GEOMETRYSHADER := 2097260
    static D3D11_MESSAGE_ID_CREATE_PIXELSHADER := 2097261
    static D3D11_MESSAGE_ID_LIVE_PIXELSHADER_WIN7 := 2097262
    static D3D11_MESSAGE_ID_DESTROY_PIXELSHADER := 2097263
    static D3D11_MESSAGE_ID_CREATE_INPUTLAYOUT := 2097264
    static D3D11_MESSAGE_ID_LIVE_INPUTLAYOUT_WIN7 := 2097265
    static D3D11_MESSAGE_ID_DESTROY_INPUTLAYOUT := 2097266
    static D3D11_MESSAGE_ID_CREATE_SAMPLER := 2097267
    static D3D11_MESSAGE_ID_LIVE_SAMPLER_WIN7 := 2097268
    static D3D11_MESSAGE_ID_DESTROY_SAMPLER := 2097269
    static D3D11_MESSAGE_ID_CREATE_BLENDSTATE := 2097270
    static D3D11_MESSAGE_ID_LIVE_BLENDSTATE_WIN7 := 2097271
    static D3D11_MESSAGE_ID_DESTROY_BLENDSTATE := 2097272
    static D3D11_MESSAGE_ID_CREATE_DEPTHSTENCILSTATE := 2097273
    static D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILSTATE_WIN7 := 2097274
    static D3D11_MESSAGE_ID_DESTROY_DEPTHSTENCILSTATE := 2097275
    static D3D11_MESSAGE_ID_CREATE_RASTERIZERSTATE := 2097276
    static D3D11_MESSAGE_ID_LIVE_RASTERIZERSTATE_WIN7 := 2097277
    static D3D11_MESSAGE_ID_DESTROY_RASTERIZERSTATE := 2097278
    static D3D11_MESSAGE_ID_CREATE_QUERY := 2097279
    static D3D11_MESSAGE_ID_LIVE_QUERY_WIN7 := 2097280
    static D3D11_MESSAGE_ID_DESTROY_QUERY := 2097281
    static D3D11_MESSAGE_ID_CREATE_PREDICATE := 2097282
    static D3D11_MESSAGE_ID_LIVE_PREDICATE_WIN7 := 2097283
    static D3D11_MESSAGE_ID_DESTROY_PREDICATE := 2097284
    static D3D11_MESSAGE_ID_CREATE_COUNTER := 2097285
    static D3D11_MESSAGE_ID_DESTROY_COUNTER := 2097286
    static D3D11_MESSAGE_ID_CREATE_COMMANDLIST := 2097287
    static D3D11_MESSAGE_ID_LIVE_COMMANDLIST := 2097288
    static D3D11_MESSAGE_ID_DESTROY_COMMANDLIST := 2097289
    static D3D11_MESSAGE_ID_CREATE_CLASSINSTANCE := 2097290
    static D3D11_MESSAGE_ID_LIVE_CLASSINSTANCE := 2097291
    static D3D11_MESSAGE_ID_DESTROY_CLASSINSTANCE := 2097292
    static D3D11_MESSAGE_ID_CREATE_CLASSLINKAGE := 2097293
    static D3D11_MESSAGE_ID_LIVE_CLASSLINKAGE := 2097294
    static D3D11_MESSAGE_ID_DESTROY_CLASSLINKAGE := 2097295
    static D3D11_MESSAGE_ID_LIVE_DEVICE_WIN7 := 2097296
    static D3D11_MESSAGE_ID_LIVE_OBJECT_SUMMARY_WIN7 := 2097297
    static D3D11_MESSAGE_ID_CREATE_COMPUTESHADER := 2097298
    static D3D11_MESSAGE_ID_LIVE_COMPUTESHADER := 2097299
    static D3D11_MESSAGE_ID_DESTROY_COMPUTESHADER := 2097300
    static D3D11_MESSAGE_ID_CREATE_UNORDEREDACCESSVIEW := 2097301
    static D3D11_MESSAGE_ID_LIVE_UNORDEREDACCESSVIEW := 2097302
    static D3D11_MESSAGE_ID_DESTROY_UNORDEREDACCESSVIEW := 2097303
    static D3D11_MESSAGE_ID_DEVICE_SETSHADER_INTERFACES_FEATURELEVEL := 2097304
    static D3D11_MESSAGE_ID_DEVICE_SETSHADER_INTERFACE_COUNT_MISMATCH := 2097305
    static D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE := 2097306
    static D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE_INDEX := 2097307
    static D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE_TYPE := 2097308
    static D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE_DATA := 2097309
    static D3D11_MESSAGE_ID_DEVICE_SETSHADER_UNBOUND_INSTANCE_DATA := 2097310
    static D3D11_MESSAGE_ID_DEVICE_SETSHADER_INSTANCE_DATA_BINDINGS := 2097311
    static D3D11_MESSAGE_ID_DEVICE_CREATESHADER_CLASSLINKAGE_FULL := 2097312
    static D3D11_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_UNRECOGNIZED_FEATURE := 2097313
    static D3D11_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_MISMATCHED_DATA_SIZE := 2097314
    static D3D11_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_INVALIDARG_RETURN := 2097315
    static D3D11_MESSAGE_ID_DEVICE_CSSETSHADERRESOURCES_HAZARD := 2097316
    static D3D11_MESSAGE_ID_DEVICE_CSSETCONSTANTBUFFERS_HAZARD := 2097317
    static D3D11_MESSAGE_ID_CSSETSHADERRESOURCES_UNBINDDELETINGOBJECT := 2097318
    static D3D11_MESSAGE_ID_CSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT := 2097319
    static D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDCALL := 2097320
    static D3D11_MESSAGE_ID_CREATECOMPUTESHADER_OUTOFMEMORY := 2097321
    static D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDSHADERBYTECODE := 2097322
    static D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDSHADERTYPE := 2097323
    static D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDCLASSLINKAGE := 2097324
    static D3D11_MESSAGE_ID_DEVICE_CSSETSHADERRESOURCES_VIEWS_EMPTY := 2097325
    static D3D11_MESSAGE_ID_CSSETCONSTANTBUFFERS_INVALIDBUFFER := 2097326
    static D3D11_MESSAGE_ID_DEVICE_CSSETCONSTANTBUFFERS_BUFFERS_EMPTY := 2097327
    static D3D11_MESSAGE_ID_DEVICE_CSSETSAMPLERS_SAMPLERS_EMPTY := 2097328
    static D3D11_MESSAGE_ID_DEVICE_CSGETSHADERRESOURCES_VIEWS_EMPTY := 2097329
    static D3D11_MESSAGE_ID_DEVICE_CSGETCONSTANTBUFFERS_BUFFERS_EMPTY := 2097330
    static D3D11_MESSAGE_ID_DEVICE_CSGETSAMPLERS_SAMPLERS_EMPTY := 2097331
    static D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_DOUBLEFLOATOPSNOTSUPPORTED := 2097332
    static D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_DOUBLEFLOATOPSNOTSUPPORTED := 2097333
    static D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_DOUBLEFLOATOPSNOTSUPPORTED := 2097334
    static D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_DOUBLEFLOATOPSNOTSUPPORTED := 2097335
    static D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEFLOATOPSNOTSUPPORTED := 2097336
    static D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_DOUBLEFLOATOPSNOTSUPPORTED := 2097337
    static D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_DOUBLEFLOATOPSNOTSUPPORTED := 2097338
    static D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDSTRUCTURESTRIDE := 2097339
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFLAGS := 2097340
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDRESOURCE := 2097341
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDESC := 2097342
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDFORMAT := 2097343
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDIMENSIONS := 2097344
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_UNRECOGNIZEDFORMAT := 2097345
    static D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_HAZARD := 2097346
    static D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_OVERLAPPING_OLD_SLOTS := 2097347
    static D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_NO_OP := 2097348
    static D3D11_MESSAGE_ID_CSSETUNORDEREDACCESSVIEWS_UNBINDDELETINGOBJECT := 2097349
    static D3D11_MESSAGE_ID_PSSETUNORDEREDACCESSVIEWS_UNBINDDELETINGOBJECT := 2097350
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDARG_RETURN := 2097351
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_OUTOFMEMORY_RETURN := 2097352
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_TOOMANYOBJECTS := 2097353
    static D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_HAZARD := 2097354
    static D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEW_DENORMFLUSH := 2097355
    static D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSS_VIEWS_EMPTY := 2097356
    static D3D11_MESSAGE_ID_DEVICE_CSGETUNORDEREDACCESSS_VIEWS_EMPTY := 2097357
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDFLAGS := 2097358
    static D3D11_MESSAGE_ID_CREATESHADERRESESOURCEVIEW_TOOMANYOBJECTS := 2097359
    static D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_INVALID_ARG_BUFFER := 2097360
    static D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_OFFSET_UNALIGNED := 2097361
    static D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_OFFSET_OVERFLOW := 2097362
    static D3D11_MESSAGE_ID_DEVICE_SETRESOURCEMINLOD_INVALIDCONTEXT := 2097363
    static D3D11_MESSAGE_ID_DEVICE_SETRESOURCEMINLOD_INVALIDRESOURCE := 2097364
    static D3D11_MESSAGE_ID_DEVICE_SETRESOURCEMINLOD_INVALIDMINLOD := 2097365
    static D3D11_MESSAGE_ID_DEVICE_GETRESOURCEMINLOD_INVALIDCONTEXT := 2097366
    static D3D11_MESSAGE_ID_DEVICE_GETRESOURCEMINLOD_INVALIDRESOURCE := 2097367
    static D3D11_MESSAGE_ID_OMSETDEPTHSTENCIL_UNBINDDELETINGOBJECT := 2097368
    static D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_DEPTH_READONLY := 2097369
    static D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_STENCIL_READONLY := 2097370
    static D3D11_MESSAGE_ID_CHECKFEATURESUPPORT_FORMAT_DEPRECATED := 2097371
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_RETURN_TYPE_MISMATCH := 2097372
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_NOT_SET := 2097373
    static D3D11_MESSAGE_ID_DEVICE_DRAW_UNORDEREDACCESSVIEW_RENDERTARGETVIEW_OVERLAP := 2097374
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_DIMENSION_MISMATCH := 2097375
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_APPEND_UNSUPPORTED := 2097376
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMICS_UNSUPPORTED := 2097377
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_STRUCTURE_STRIDE_MISMATCH := 2097378
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_BUFFER_TYPE_MISMATCH := 2097379
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_RAW_UNSUPPORTED := 2097380
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_FORMAT_LD_UNSUPPORTED := 2097381
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_FORMAT_STORE_UNSUPPORTED := 2097382
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_ADD_UNSUPPORTED := 2097383
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_BITWISE_OPS_UNSUPPORTED := 2097384
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_CMPSTORE_CMPEXCHANGE_UNSUPPORTED := 2097385
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_EXCHANGE_UNSUPPORTED := 2097386
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_SIGNED_MINMAX_UNSUPPORTED := 2097387
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_UNSIGNED_MINMAX_UNSUPPORTED := 2097388
    static D3D11_MESSAGE_ID_DEVICE_DISPATCH_BOUND_RESOURCE_MAPPED := 2097389
    static D3D11_MESSAGE_ID_DEVICE_DISPATCH_THREADGROUPCOUNT_OVERFLOW := 2097390
    static D3D11_MESSAGE_ID_DEVICE_DISPATCH_THREADGROUPCOUNT_ZERO := 2097391
    static D3D11_MESSAGE_ID_DEVICE_SHADERRESOURCEVIEW_STRUCTURE_STRIDE_MISMATCH := 2097392
    static D3D11_MESSAGE_ID_DEVICE_SHADERRESOURCEVIEW_BUFFER_TYPE_MISMATCH := 2097393
    static D3D11_MESSAGE_ID_DEVICE_SHADERRESOURCEVIEW_RAW_UNSUPPORTED := 2097394
    static D3D11_MESSAGE_ID_DEVICE_DISPATCH_UNSUPPORTED := 2097395
    static D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_UNSUPPORTED := 2097396
    static D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_INVALIDOFFSET := 2097397
    static D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_LARGEOFFSET := 2097398
    static D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_INVALIDDESTINATIONSTATE := 2097399
    static D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_INVALIDSOURCESTATE := 2097400
    static D3D11_MESSAGE_ID_CHECKFORMATSUPPORT_FORMAT_NOT_SUPPORTED := 2097401
    static D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_INVALIDVIEW := 2097402
    static D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_INVALIDOFFSET := 2097403
    static D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_TOOMANYVIEWS := 2097404
    static D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEWFLOAT_INVALIDFORMAT := 2097405
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_COUNTER_UNSUPPORTED := 2097406
    static D3D11_MESSAGE_ID_REF_WARNING := 2097407
    static D3D11_MESSAGE_ID_DEVICE_DRAW_PIXEL_SHADER_WITHOUT_RTV_OR_DSV := 2097408
    static D3D11_MESSAGE_ID_SHADER_ABORT := 2097409
    static D3D11_MESSAGE_ID_SHADER_MESSAGE := 2097410
    static D3D11_MESSAGE_ID_SHADER_ERROR := 2097411
    static D3D11_MESSAGE_ID_OFFERRESOURCES_INVALIDRESOURCE := 2097412
    static D3D11_MESSAGE_ID_HSSETSAMPLERS_UNBINDDELETINGOBJECT := 2097413
    static D3D11_MESSAGE_ID_DSSETSAMPLERS_UNBINDDELETINGOBJECT := 2097414
    static D3D11_MESSAGE_ID_CSSETSAMPLERS_UNBINDDELETINGOBJECT := 2097415
    static D3D11_MESSAGE_ID_HSSETSHADER_UNBINDDELETINGOBJECT := 2097416
    static D3D11_MESSAGE_ID_DSSETSHADER_UNBINDDELETINGOBJECT := 2097417
    static D3D11_MESSAGE_ID_CSSETSHADER_UNBINDDELETINGOBJECT := 2097418
    static D3D11_MESSAGE_ID_ENQUEUESETEVENT_INVALIDARG_RETURN := 2097419
    static D3D11_MESSAGE_ID_ENQUEUESETEVENT_OUTOFMEMORY_RETURN := 2097420
    static D3D11_MESSAGE_ID_ENQUEUESETEVENT_ACCESSDENIED_RETURN := 2097421
    static D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_NUMUAVS_INVALIDRANGE := 2097422
    static D3D11_MESSAGE_ID_USE_OF_ZERO_REFCOUNT_OBJECT := 2097423
    static D3D11_MESSAGE_ID_D3D11_MESSAGES_END := 2097424
    static D3D11_MESSAGE_ID_D3D11_1_MESSAGES_START := 3145728
    static D3D11_MESSAGE_ID_CREATE_VIDEODECODER := 3145729
    static D3D11_MESSAGE_ID_CREATE_VIDEOPROCESSORENUM := 3145730
    static D3D11_MESSAGE_ID_CREATE_VIDEOPROCESSOR := 3145731
    static D3D11_MESSAGE_ID_CREATE_DECODEROUTPUTVIEW := 3145732
    static D3D11_MESSAGE_ID_CREATE_PROCESSORINPUTVIEW := 3145733
    static D3D11_MESSAGE_ID_CREATE_PROCESSOROUTPUTVIEW := 3145734
    static D3D11_MESSAGE_ID_CREATE_DEVICECONTEXTSTATE := 3145735
    static D3D11_MESSAGE_ID_LIVE_VIDEODECODER := 3145736
    static D3D11_MESSAGE_ID_LIVE_VIDEOPROCESSORENUM := 3145737
    static D3D11_MESSAGE_ID_LIVE_VIDEOPROCESSOR := 3145738
    static D3D11_MESSAGE_ID_LIVE_DECODEROUTPUTVIEW := 3145739
    static D3D11_MESSAGE_ID_LIVE_PROCESSORINPUTVIEW := 3145740
    static D3D11_MESSAGE_ID_LIVE_PROCESSOROUTPUTVIEW := 3145741
    static D3D11_MESSAGE_ID_LIVE_DEVICECONTEXTSTATE := 3145742
    static D3D11_MESSAGE_ID_DESTROY_VIDEODECODER := 3145743
    static D3D11_MESSAGE_ID_DESTROY_VIDEOPROCESSORENUM := 3145744
    static D3D11_MESSAGE_ID_DESTROY_VIDEOPROCESSOR := 3145745
    static D3D11_MESSAGE_ID_DESTROY_DECODEROUTPUTVIEW := 3145746
    static D3D11_MESSAGE_ID_DESTROY_PROCESSORINPUTVIEW := 3145747
    static D3D11_MESSAGE_ID_DESTROY_PROCESSOROUTPUTVIEW := 3145748
    static D3D11_MESSAGE_ID_DESTROY_DEVICECONTEXTSTATE := 3145749
    static D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_INVALIDFLAGS := 3145750
    static D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_INVALIDFEATURELEVEL := 3145751
    static D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_FEATURELEVELS_NOT_SUPPORTED := 3145752
    static D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_INVALIDREFIID := 3145753
    static D3D11_MESSAGE_ID_DEVICE_DISCARDVIEW_INVALIDVIEW := 3145754
    static D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION1_INVALIDCOPYFLAGS := 3145755
    static D3D11_MESSAGE_ID_UPDATESUBRESOURCE1_INVALIDCOPYFLAGS := 3145756
    static D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFORCEDSAMPLECOUNT := 3145757
    static D3D11_MESSAGE_ID_CREATEVIDEODECODER_OUTOFMEMORY_RETURN := 3145758
    static D3D11_MESSAGE_ID_CREATEVIDEODECODER_NULLPARAM := 3145759
    static D3D11_MESSAGE_ID_CREATEVIDEODECODER_INVALIDFORMAT := 3145760
    static D3D11_MESSAGE_ID_CREATEVIDEODECODER_ZEROWIDTHHEIGHT := 3145761
    static D3D11_MESSAGE_ID_CREATEVIDEODECODER_DRIVER_INVALIDBUFFERSIZE := 3145762
    static D3D11_MESSAGE_ID_CREATEVIDEODECODER_DRIVER_INVALIDBUFFERUSAGE := 3145763
    static D3D11_MESSAGE_ID_GETVIDEODECODERPROFILECOUNT_OUTOFMEMORY := 3145764
    static D3D11_MESSAGE_ID_GETVIDEODECODERPROFILE_NULLPARAM := 3145765
    static D3D11_MESSAGE_ID_GETVIDEODECODERPROFILE_INVALIDINDEX := 3145766
    static D3D11_MESSAGE_ID_GETVIDEODECODERPROFILE_OUTOFMEMORY_RETURN := 3145767
    static D3D11_MESSAGE_ID_CHECKVIDEODECODERFORMAT_NULLPARAM := 3145768
    static D3D11_MESSAGE_ID_CHECKVIDEODECODERFORMAT_OUTOFMEMORY_RETURN := 3145769
    static D3D11_MESSAGE_ID_GETVIDEODECODERCONFIGCOUNT_NULLPARAM := 3145770
    static D3D11_MESSAGE_ID_GETVIDEODECODERCONFIGCOUNT_OUTOFMEMORY_RETURN := 3145771
    static D3D11_MESSAGE_ID_GETVIDEODECODERCONFIG_NULLPARAM := 3145772
    static D3D11_MESSAGE_ID_GETVIDEODECODERCONFIG_INVALIDINDEX := 3145773
    static D3D11_MESSAGE_ID_GETVIDEODECODERCONFIG_OUTOFMEMORY_RETURN := 3145774
    static D3D11_MESSAGE_ID_GETDECODERCREATIONPARAMS_NULLPARAM := 3145775
    static D3D11_MESSAGE_ID_GETDECODERDRIVERHANDLE_NULLPARAM := 3145776
    static D3D11_MESSAGE_ID_GETDECODERBUFFER_NULLPARAM := 3145777
    static D3D11_MESSAGE_ID_GETDECODERBUFFER_INVALIDBUFFER := 3145778
    static D3D11_MESSAGE_ID_GETDECODERBUFFER_INVALIDTYPE := 3145779
    static D3D11_MESSAGE_ID_GETDECODERBUFFER_LOCKED := 3145780
    static D3D11_MESSAGE_ID_RELEASEDECODERBUFFER_NULLPARAM := 3145781
    static D3D11_MESSAGE_ID_RELEASEDECODERBUFFER_INVALIDTYPE := 3145782
    static D3D11_MESSAGE_ID_RELEASEDECODERBUFFER_NOTLOCKED := 3145783
    static D3D11_MESSAGE_ID_DECODERBEGINFRAME_NULLPARAM := 3145784
    static D3D11_MESSAGE_ID_DECODERBEGINFRAME_HAZARD := 3145785
    static D3D11_MESSAGE_ID_DECODERENDFRAME_NULLPARAM := 3145786
    static D3D11_MESSAGE_ID_SUBMITDECODERBUFFERS_NULLPARAM := 3145787
    static D3D11_MESSAGE_ID_SUBMITDECODERBUFFERS_INVALIDTYPE := 3145788
    static D3D11_MESSAGE_ID_DECODEREXTENSION_NULLPARAM := 3145789
    static D3D11_MESSAGE_ID_DECODEREXTENSION_INVALIDRESOURCE := 3145790
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_OUTOFMEMORY_RETURN := 3145791
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_NULLPARAM := 3145792
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDFRAMEFORMAT := 3145793
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDUSAGE := 3145794
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDINPUTFRAMERATE := 3145795
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDOUTPUTFRAMERATE := 3145796
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDWIDTHHEIGHT := 3145797
    static D3D11_MESSAGE_ID_GETVIDEOPROCESSORCONTENTDESC_NULLPARAM := 3145798
    static D3D11_MESSAGE_ID_CHECKVIDEOPROCESSORFORMAT_NULLPARAM := 3145799
    static D3D11_MESSAGE_ID_GETVIDEOPROCESSORCAPS_NULLPARAM := 3145800
    static D3D11_MESSAGE_ID_GETVIDEOPROCESSORRATECONVERSIONCAPS_NULLPARAM := 3145801
    static D3D11_MESSAGE_ID_GETVIDEOPROCESSORRATECONVERSIONCAPS_INVALIDINDEX := 3145802
    static D3D11_MESSAGE_ID_GETVIDEOPROCESSORCUSTOMRATE_NULLPARAM := 3145803
    static D3D11_MESSAGE_ID_GETVIDEOPROCESSORCUSTOMRATE_INVALIDINDEX := 3145804
    static D3D11_MESSAGE_ID_GETVIDEOPROCESSORFILTERRANGE_NULLPARAM := 3145805
    static D3D11_MESSAGE_ID_GETVIDEOPROCESSORFILTERRANGE_UNSUPPORTED := 3145806
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOR_OUTOFMEMORY_RETURN := 3145807
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOR_NULLPARAM := 3145808
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTTARGETRECT_NULLPARAM := 3145809
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTBACKGROUNDCOLOR_NULLPARAM := 3145810
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTBACKGROUNDCOLOR_INVALIDALPHA := 3145811
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCOLORSPACE_NULLPARAM := 3145812
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_NULLPARAM := 3145813
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_UNSUPPORTED := 3145814
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_INVALIDSTREAM := 3145815
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_INVALIDFILLMODE := 3145816
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCONSTRICTION_NULLPARAM := 3145817
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTSTEREOMODE_NULLPARAM := 3145818
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTSTEREOMODE_UNSUPPORTED := 3145819
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTEXTENSION_NULLPARAM := 3145820
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTTARGETRECT_NULLPARAM := 3145821
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTBACKGROUNDCOLOR_NULLPARAM := 3145822
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTCOLORSPACE_NULLPARAM := 3145823
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTALPHAFILLMODE_NULLPARAM := 3145824
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTCONSTRICTION_NULLPARAM := 3145825
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCONSTRICTION_UNSUPPORTED := 3145826
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCONSTRICTION_INVALIDSIZE := 3145827
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTSTEREOMODE_NULLPARAM := 3145828
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTEXTENSION_NULLPARAM := 3145829
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFRAMEFORMAT_NULLPARAM := 3145830
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFRAMEFORMAT_INVALIDFORMAT := 3145831
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFRAMEFORMAT_INVALIDSTREAM := 3145832
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMCOLORSPACE_NULLPARAM := 3145833
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMCOLORSPACE_INVALIDSTREAM := 3145834
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_NULLPARAM := 3145835
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_INVALIDRATE := 3145836
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_INVALIDFLAG := 3145837
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_INVALIDSTREAM := 3145838
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSOURCERECT_NULLPARAM := 3145839
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSOURCERECT_INVALIDSTREAM := 3145840
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSOURCERECT_INVALIDRECT := 3145841
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMDESTRECT_NULLPARAM := 3145842
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMDESTRECT_INVALIDSTREAM := 3145843
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMDESTRECT_INVALIDRECT := 3145844
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_NULLPARAM := 3145845
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_INVALIDSTREAM := 3145846
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_INVALIDALPHA := 3145847
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_NULLPARAM := 3145848
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_INVALIDSTREAM := 3145849
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_INVALIDCOUNT := 3145850
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_INVALIDALPHA := 3145851
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_NULLPARAM := 3145852
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_INVALIDSTREAM := 3145853
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_INVALIDRATIO := 3145854
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_NULLPARAM := 3145855
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_INVALIDSTREAM := 3145856
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_INVALIDRANGE := 3145857
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_UNSUPPORTED := 3145858
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_NULLPARAM := 3145859
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_INVALIDSTREAM := 3145860
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_UNSUPPORTED := 3145861
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_FLIPUNSUPPORTED := 3145862
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_MONOOFFSETUNSUPPORTED := 3145863
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_FORMATUNSUPPORTED := 3145864
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_INVALIDFORMAT := 3145865
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMAUTOPROCESSINGMODE_NULLPARAM := 3145866
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMAUTOPROCESSINGMODE_INVALIDSTREAM := 3145867
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_NULLPARAM := 3145868
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_INVALIDSTREAM := 3145869
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_INVALIDFILTER := 3145870
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_UNSUPPORTED := 3145871
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_INVALIDLEVEL := 3145872
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMEXTENSION_NULLPARAM := 3145873
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMEXTENSION_INVALIDSTREAM := 3145874
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMFRAMEFORMAT_NULLPARAM := 3145875
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMCOLORSPACE_NULLPARAM := 3145876
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMOUTPUTRATE_NULLPARAM := 3145877
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMSOURCERECT_NULLPARAM := 3145878
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMDESTRECT_NULLPARAM := 3145879
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMALPHA_NULLPARAM := 3145880
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMPALETTE_NULLPARAM := 3145881
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMPIXELASPECTRATIO_NULLPARAM := 3145882
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMLUMAKEY_NULLPARAM := 3145883
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMSTEREOFORMAT_NULLPARAM := 3145884
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMAUTOPROCESSINGMODE_NULLPARAM := 3145885
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMFILTER_NULLPARAM := 3145886
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMEXTENSION_NULLPARAM := 3145887
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMEXTENSION_INVALIDSTREAM := 3145888
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_NULLPARAM := 3145889
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDSTREAMCOUNT := 3145890
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_TARGETRECT := 3145891
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDOUTPUT := 3145892
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDPASTFRAMES := 3145893
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDFUTUREFRAMES := 3145894
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDSOURCERECT := 3145895
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDDESTRECT := 3145896
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDINPUTRESOURCE := 3145897
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDARRAYSIZE := 3145898
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDARRAY := 3145899
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_RIGHTEXPECTED := 3145900
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_RIGHTNOTEXPECTED := 3145901
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_STEREONOTENABLED := 3145902
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDRIGHTRESOURCE := 3145903
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_NOSTEREOSTREAMS := 3145904
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INPUTHAZARD := 3145905
    static D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_OUTPUTHAZARD := 3145906
    static D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_OUTOFMEMORY_RETURN := 3145907
    static D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_NULLPARAM := 3145908
    static D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDTYPE := 3145909
    static D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDBIND := 3145910
    static D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_UNSUPPORTEDFORMAT := 3145911
    static D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDMIP := 3145912
    static D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_UNSUPPORTEMIP := 3145913
    static D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDARRAYSIZE := 3145914
    static D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDARRAY := 3145915
    static D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDDIMENSION := 3145916
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_OUTOFMEMORY_RETURN := 3145917
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_NULLPARAM := 3145918
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDTYPE := 3145919
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDBIND := 3145920
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDMISC := 3145921
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDUSAGE := 3145922
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDFORMAT := 3145923
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDFOURCC := 3145924
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDMIP := 3145925
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_UNSUPPORTEDMIP := 3145926
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDARRAYSIZE := 3145927
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDARRAY := 3145928
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDDIMENSION := 3145929
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_OUTOFMEMORY_RETURN := 3145930
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_NULLPARAM := 3145931
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDTYPE := 3145932
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDBIND := 3145933
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDFORMAT := 3145934
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDMIP := 3145935
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_UNSUPPORTEDMIP := 3145936
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_UNSUPPORTEDARRAY := 3145937
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDARRAY := 3145938
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDDIMENSION := 3145939
    static D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_USE_OF_FORCED_SAMPLE_COUNT := 3145940
    static D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDLOGICOPS := 3145941
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDARRAYWITHDECODER := 3145942
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDARRAYWITHDECODER := 3145943
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDARRAYWITHDECODER := 3145944
    static D3D11_MESSAGE_ID_DEVICE_LOCKEDOUT_INTERFACE := 3145945
    static D3D11_MESSAGE_ID_REF_WARNING_ATOMIC_INCONSISTENT := 3145946
    static D3D11_MESSAGE_ID_REF_WARNING_READING_UNINITIALIZED_RESOURCE := 3145947
    static D3D11_MESSAGE_ID_REF_WARNING_RAW_HAZARD := 3145948
    static D3D11_MESSAGE_ID_REF_WARNING_WAR_HAZARD := 3145949
    static D3D11_MESSAGE_ID_REF_WARNING_WAW_HAZARD := 3145950
    static D3D11_MESSAGE_ID_CREATECRYPTOSESSION_NULLPARAM := 3145951
    static D3D11_MESSAGE_ID_CREATECRYPTOSESSION_OUTOFMEMORY_RETURN := 3145952
    static D3D11_MESSAGE_ID_GETCRYPTOTYPE_NULLPARAM := 3145953
    static D3D11_MESSAGE_ID_GETDECODERPROFILE_NULLPARAM := 3145954
    static D3D11_MESSAGE_ID_GETCRYPTOSESSIONCERTIFICATESIZE_NULLPARAM := 3145955
    static D3D11_MESSAGE_ID_GETCRYPTOSESSIONCERTIFICATE_NULLPARAM := 3145956
    static D3D11_MESSAGE_ID_GETCRYPTOSESSIONCERTIFICATE_WRONGSIZE := 3145957
    static D3D11_MESSAGE_ID_GETCRYPTOSESSIONHANDLE_WRONGSIZE := 3145958
    static D3D11_MESSAGE_ID_NEGOTIATECRPYTOSESSIONKEYEXCHANGE_NULLPARAM := 3145959
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_UNSUPPORTED := 3145960
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_NULLPARAM := 3145961
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_WRONGDEVICE := 3145962
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_WRONGDEVICE := 3145963
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_FORMAT_MISMATCH := 3145964
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_SIZE_MISMATCH := 3145965
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_MULTISAMPLED := 3145966
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_NOT_STAGING := 3145967
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_MAPPED := 3145968
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_MAPPED := 3145969
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_OFFERED := 3145970
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_OFFERED := 3145971
    static D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_CONTENT_UNDEFINED := 3145972
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_UNSUPPORTED := 3145973
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_NULLPARAM := 3145974
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_WRONGDEVICE := 3145975
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_WRONGDEVICE := 3145976
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_FORMAT_MISMATCH := 3145977
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_SIZE_MISMATCH := 3145978
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_MULTISAMPLED := 3145979
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_NOT_STAGING := 3145980
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_NOT_RENDER_TARGET := 3145981
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_MAPPED := 3145982
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_MAPPED := 3145983
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_OFFERED := 3145984
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_OFFERED := 3145985
    static D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_CONTENT_UNDEFINED := 3145986
    static D3D11_MESSAGE_ID_STARTSESSIONKEYREFRESH_NULLPARAM := 3145987
    static D3D11_MESSAGE_ID_STARTSESSIONKEYREFRESH_INVALIDSIZE := 3145988
    static D3D11_MESSAGE_ID_FINISHSESSIONKEYREFRESH_NULLPARAM := 3145989
    static D3D11_MESSAGE_ID_GETENCRYPTIONBLTKEY_NULLPARAM := 3145990
    static D3D11_MESSAGE_ID_GETENCRYPTIONBLTKEY_INVALIDSIZE := 3145991
    static D3D11_MESSAGE_ID_GETCONTENTPROTECTIONCAPS_NULLPARAM := 3145992
    static D3D11_MESSAGE_ID_CHECKCRYPTOKEYEXCHANGE_NULLPARAM := 3145993
    static D3D11_MESSAGE_ID_CHECKCRYPTOKEYEXCHANGE_INVALIDINDEX := 3145994
    static D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_NULLPARAM := 3145995
    static D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_UNSUPPORTED := 3145996
    static D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_INVALIDTYPE := 3145997
    static D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_OUTOFMEMORY_RETURN := 3145998
    static D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATESIZE_INVALIDCHANNEL := 3145999
    static D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATESIZE_NULLPARAM := 3146000
    static D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATE_INVALIDCHANNEL := 3146001
    static D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATE_NULLPARAM := 3146002
    static D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATE_WRONGSIZE := 3146003
    static D3D11_MESSAGE_ID_NEGOTIATEAUTHENTICATEDCHANNELKEYEXCHANGE_INVALIDCHANNEL := 3146004
    static D3D11_MESSAGE_ID_NEGOTIATEAUTHENTICATEDCHANNELKEYEXCHANGE_NULLPARAM := 3146005
    static D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_NULLPARAM := 3146006
    static D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_WRONGCHANNEL := 3146007
    static D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_UNSUPPORTEDQUERY := 3146008
    static D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_WRONGSIZE := 3146009
    static D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_INVALIDPROCESSINDEX := 3146010
    static D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_NULLPARAM := 3146011
    static D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_WRONGCHANNEL := 3146012
    static D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_UNSUPPORTEDCONFIGURE := 3146013
    static D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_WRONGSIZE := 3146014
    static D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_INVALIDPROCESSIDTYPE := 3146015
    static D3D11_MESSAGE_ID_VSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT := 3146016
    static D3D11_MESSAGE_ID_DSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT := 3146017
    static D3D11_MESSAGE_ID_HSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT := 3146018
    static D3D11_MESSAGE_ID_GSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT := 3146019
    static D3D11_MESSAGE_ID_PSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT := 3146020
    static D3D11_MESSAGE_ID_CSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT := 3146021
    static D3D11_MESSAGE_ID_NEGOTIATECRPYTOSESSIONKEYEXCHANGE_INVALIDSIZE := 3146022
    static D3D11_MESSAGE_ID_NEGOTIATEAUTHENTICATEDCHANNELKEYEXCHANGE_INVALIDSIZE := 3146023
    static D3D11_MESSAGE_ID_OFFERRESOURCES_INVALIDPRIORITY := 3146024
    static D3D11_MESSAGE_ID_GETCRYPTOSESSIONHANDLE_OUTOFMEMORY := 3146025
    static D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_NULLPARAM := 3146026
    static D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_INVALIDTYPE := 3146027
    static D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_INVALIDBIND := 3146028
    static D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_INVALIDARRAY := 3146029
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_NULLPARAM := 3146030
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_INVALIDSTREAM := 3146031
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_INVALID := 3146032
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_UNSUPPORTED := 3146033
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMROTATION_NULLPARAM := 3146034
    static D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDVIEW := 3146035
    static D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_DOUBLEEXTENSIONSNOTSUPPORTED := 3146036
    static D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_SHADEREXTENSIONSNOTSUPPORTED := 3146037
    static D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_DOUBLEEXTENSIONSNOTSUPPORTED := 3146038
    static D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_SHADEREXTENSIONSNOTSUPPORTED := 3146039
    static D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_DOUBLEEXTENSIONSNOTSUPPORTED := 3146040
    static D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_SHADEREXTENSIONSNOTSUPPORTED := 3146041
    static D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_DOUBLEEXTENSIONSNOTSUPPORTED := 3146042
    static D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_SHADEREXTENSIONSNOTSUPPORTED := 3146043
    static D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEEXTENSIONSNOTSUPPORTED := 3146044
    static D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_SHADEREXTENSIONSNOTSUPPORTED := 3146045
    static D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_DOUBLEEXTENSIONSNOTSUPPORTED := 3146046
    static D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_SHADEREXTENSIONSNOTSUPPORTED := 3146047
    static D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_DOUBLEEXTENSIONSNOTSUPPORTED := 3146048
    static D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_SHADEREXTENSIONSNOTSUPPORTED := 3146049
    static D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_MINPRECISION := 3146050
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_UNSUPPORTED := 3146051
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_UNSUPPORTED := 3146052
    static D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_UAVSNOTSUPPORTED := 3146053
    static D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_UAVSNOTSUPPORTED := 3146054
    static D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_UAVSNOTSUPPORTED := 3146055
    static D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_UAVSNOTSUPPORTED := 3146056
    static D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UAVSNOTSUPPORTED := 3146057
    static D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_UAVSNOTSUPPORTED := 3146058
    static D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_UAVSNOTSUPPORTED := 3146059
    static D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_INVALIDOFFSET := 3146060
    static D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_TOOMANYVIEWS := 3146061
    static D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_NOTSUPPORTED := 3146062
    static D3D11_MESSAGE_ID_SWAPDEVICECONTEXTSTATE_NOTSUPPORTED := 3146063
    static D3D11_MESSAGE_ID_UPDATESUBRESOURCE_PREFERUPDATESUBRESOURCE1 := 3146064
    static D3D11_MESSAGE_ID_GETDC_INACCESSIBLE := 3146065
    static D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDRECT := 3146066
    static D3D11_MESSAGE_ID_DEVICE_DRAW_SAMPLE_MASK_IGNORED_ON_FL9 := 3146067
    static D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE1_NOT_SUPPORTED := 3146068
    static D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_BY_NAME_NOT_SUPPORTED := 3146069
    static D3D11_MESSAGE_ID_ENQUEUESETEVENT_NOT_SUPPORTED := 3146070
    static D3D11_MESSAGE_ID_OFFERRELEASE_NOT_SUPPORTED := 3146071
    static D3D11_MESSAGE_ID_OFFERRESOURCES_INACCESSIBLE := 3146072
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDMSAA := 3146073
    static D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDMSAA := 3146074
    static D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDSOURCERECT := 3146075
    static D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_EMPTYRECT := 3146076
    static D3D11_MESSAGE_ID_UPDATESUBRESOURCE_EMPTYDESTBOX := 3146077
    static D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_EMPTYSOURCEBOX := 3146078
    static D3D11_MESSAGE_ID_DEVICE_DRAW_OM_RENDER_TARGET_DOES_NOT_SUPPORT_LOGIC_OPS := 3146079
    static D3D11_MESSAGE_ID_DEVICE_DRAW_DEPTHSTENCILVIEW_NOT_SET := 3146080
    static D3D11_MESSAGE_ID_DEVICE_DRAW_RENDERTARGETVIEW_NOT_SET := 3146081
    static D3D11_MESSAGE_ID_DEVICE_DRAW_RENDERTARGETVIEW_NOT_SET_DUE_TO_FLIP_PRESENT := 3146082
    static D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_NOT_SET_DUE_TO_FLIP_PRESENT := 3146083
    static D3D11_MESSAGE_ID_GETDATAFORNEWHARDWAREKEY_NULLPARAM := 3146084
    static D3D11_MESSAGE_ID_CHECKCRYPTOSESSIONSTATUS_NULLPARAM := 3146085
    static D3D11_MESSAGE_ID_GETCRYPTOSESSIONPRIVATEDATASIZE_NULLPARAM := 3146086
    static D3D11_MESSAGE_ID_GETVIDEODECODERCAPS_NULLPARAM := 3146087
    static D3D11_MESSAGE_ID_GETVIDEODECODERCAPS_ZEROWIDTHHEIGHT := 3146088
    static D3D11_MESSAGE_ID_CHECKVIDEODECODERDOWNSAMPLING_NULLPARAM := 3146089
    static D3D11_MESSAGE_ID_CHECKVIDEODECODERDOWNSAMPLING_INVALIDCOLORSPACE := 3146090
    static D3D11_MESSAGE_ID_CHECKVIDEODECODERDOWNSAMPLING_ZEROWIDTHHEIGHT := 3146091
    static D3D11_MESSAGE_ID_VIDEODECODERENABLEDOWNSAMPLING_NULLPARAM := 3146092
    static D3D11_MESSAGE_ID_VIDEODECODERENABLEDOWNSAMPLING_UNSUPPORTED := 3146093
    static D3D11_MESSAGE_ID_VIDEODECODERUPDATEDOWNSAMPLING_NULLPARAM := 3146094
    static D3D11_MESSAGE_ID_VIDEODECODERUPDATEDOWNSAMPLING_UNSUPPORTED := 3146095
    static D3D11_MESSAGE_ID_CHECKVIDEOPROCESSORFORMATCONVERSION_NULLPARAM := 3146096
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCOLORSPACE1_NULLPARAM := 3146097
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTCOLORSPACE1_NULLPARAM := 3146098
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMCOLORSPACE1_NULLPARAM := 3146099
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMCOLORSPACE1_INVALIDSTREAM := 3146100
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMMIRROR_NULLPARAM := 3146101
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMMIRROR_INVALIDSTREAM := 3146102
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMMIRROR_UNSUPPORTED := 3146103
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMCOLORSPACE1_NULLPARAM := 3146104
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMMIRROR_NULLPARAM := 3146105
    static D3D11_MESSAGE_ID_RECOMMENDVIDEODECODERDOWNSAMPLING_NULLPARAM := 3146106
    static D3D11_MESSAGE_ID_RECOMMENDVIDEODECODERDOWNSAMPLING_INVALIDCOLORSPACE := 3146107
    static D3D11_MESSAGE_ID_RECOMMENDVIDEODECODERDOWNSAMPLING_ZEROWIDTHHEIGHT := 3146108
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTSHADERUSAGE_NULLPARAM := 3146109
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTSHADERUSAGE_NULLPARAM := 3146110
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETBEHAVIORHINTS_NULLPARAM := 3146111
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETBEHAVIORHINTS_INVALIDSTREAMCOUNT := 3146112
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETBEHAVIORHINTS_TARGETRECT := 3146113
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETBEHAVIORHINTS_INVALIDSOURCERECT := 3146114
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETBEHAVIORHINTS_INVALIDDESTRECT := 3146115
    static D3D11_MESSAGE_ID_GETCRYPTOSESSIONPRIVATEDATASIZE_INVALID_KEY_EXCHANGE_TYPE := 3146116
    static D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE1_ACCESS_DENIED := 3146117
    static D3D11_MESSAGE_ID_D3D11_1_MESSAGES_END := 3146118
    static D3D11_MESSAGE_ID_D3D11_2_MESSAGES_START := 3146119
    static D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDUSAGE := 3146120
    static D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDUSAGE := 3146121
    static D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDUSAGE := 3146122
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_LEVEL9_STEPRATE_NOT_1 := 3146123
    static D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_LEVEL9_INSTANCING_NOT_SUPPORTED := 3146124
    static D3D11_MESSAGE_ID_UPDATETILEMAPPINGS_INVALID_PARAMETER := 3146125
    static D3D11_MESSAGE_ID_COPYTILEMAPPINGS_INVALID_PARAMETER := 3146126
    static D3D11_MESSAGE_ID_COPYTILES_INVALID_PARAMETER := 3146127
    static D3D11_MESSAGE_ID_UPDATETILES_INVALID_PARAMETER := 3146128
    static D3D11_MESSAGE_ID_RESIZETILEPOOL_INVALID_PARAMETER := 3146129
    static D3D11_MESSAGE_ID_TILEDRESOURCEBARRIER_INVALID_PARAMETER := 3146130
    static D3D11_MESSAGE_ID_NULL_TILE_MAPPING_ACCESS_WARNING := 3146131
    static D3D11_MESSAGE_ID_NULL_TILE_MAPPING_ACCESS_ERROR := 3146132
    static D3D11_MESSAGE_ID_DIRTY_TILE_MAPPING_ACCESS := 3146133
    static D3D11_MESSAGE_ID_DUPLICATE_TILE_MAPPINGS_IN_COVERED_AREA := 3146134
    static D3D11_MESSAGE_ID_TILE_MAPPINGS_IN_COVERED_AREA_DUPLICATED_OUTSIDE := 3146135
    static D3D11_MESSAGE_ID_TILE_MAPPINGS_SHARED_BETWEEN_INCOMPATIBLE_RESOURCES := 3146136
    static D3D11_MESSAGE_ID_TILE_MAPPINGS_SHARED_BETWEEN_INPUT_AND_OUTPUT := 3146137
    static D3D11_MESSAGE_ID_CHECKMULTISAMPLEQUALITYLEVELS_INVALIDFLAGS := 3146138
    static D3D11_MESSAGE_ID_GETRESOURCETILING_NONTILED_RESOURCE := 3146139
    static D3D11_MESSAGE_ID_RESIZETILEPOOL_SHRINK_WITH_MAPPINGS_STILL_DEFINED_PAST_END := 3146140
    static D3D11_MESSAGE_ID_NEED_TO_CALL_TILEDRESOURCEBARRIER := 3146141
    static D3D11_MESSAGE_ID_CREATEDEVICE_INVALIDARGS := 3146142
    static D3D11_MESSAGE_ID_CREATEDEVICE_WARNING := 3146143
    static D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEWUINT_HAZARD := 3146144
    static D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEWFLOAT_HAZARD := 3146145
    static D3D11_MESSAGE_ID_TILED_RESOURCE_TIER_1_BUFFER_TEXTURE_MISMATCH := 3146146
    static D3D11_MESSAGE_ID_CREATE_CRYPTOSESSION := 3146147
    static D3D11_MESSAGE_ID_CREATE_AUTHENTICATEDCHANNEL := 3146148
    static D3D11_MESSAGE_ID_LIVE_CRYPTOSESSION := 3146149
    static D3D11_MESSAGE_ID_LIVE_AUTHENTICATEDCHANNEL := 3146150
    static D3D11_MESSAGE_ID_DESTROY_CRYPTOSESSION := 3146151
    static D3D11_MESSAGE_ID_DESTROY_AUTHENTICATEDCHANNEL := 3146152
    static D3D11_MESSAGE_ID_D3D11_2_MESSAGES_END := 3146153
    static D3D11_MESSAGE_ID_D3D11_3_MESSAGES_START := 3146154
    static D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALID_CONSERVATIVERASTERMODE := 3146155
    static D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_SYSTEMVALUE := 3146156
    static D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDCONTEXTTYPE := 3146157
    static D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_DECODENOTSUPPORTED := 3146158
    static D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_ENCODENOTSUPPORTED := 3146159
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDPLANEINDEX := 3146160
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDVIDEOPLANEINDEX := 3146161
    static D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_AMBIGUOUSVIDEOPLANEINDEX := 3146162
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDPLANEINDEX := 3146163
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDVIDEOPLANEINDEX := 3146164
    static D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_AMBIGUOUSVIDEOPLANEINDEX := 3146165
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDPLANEINDEX := 3146166
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDVIDEOPLANEINDEX := 3146167
    static D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_AMBIGUOUSVIDEOPLANEINDEX := 3146168
    static D3D11_MESSAGE_ID_JPEGDECODE_INVALIDSCANDATAOFFSET := 3146169
    static D3D11_MESSAGE_ID_JPEGDECODE_NOTSUPPORTED := 3146170
    static D3D11_MESSAGE_ID_JPEGDECODE_DIMENSIONSTOOLARGE := 3146171
    static D3D11_MESSAGE_ID_JPEGDECODE_INVALIDCOMPONENTS := 3146172
    static D3D11_MESSAGE_ID_JPEGDECODE_DESTINATIONNOT2D := 3146173
    static D3D11_MESSAGE_ID_JPEGDECODE_TILEDRESOURCESUNSUPPORTED := 3146174
    static D3D11_MESSAGE_ID_JPEGDECODE_GUARDRECTSUNSUPPORTED := 3146175
    static D3D11_MESSAGE_ID_JPEGDECODE_FORMATUNSUPPORTED := 3146176
    static D3D11_MESSAGE_ID_JPEGDECODE_INVALIDSUBRESOURCE := 3146177
    static D3D11_MESSAGE_ID_JPEGDECODE_INVALIDMIPLEVEL := 3146178
    static D3D11_MESSAGE_ID_JPEGDECODE_EMPTYDESTBOX := 3146179
    static D3D11_MESSAGE_ID_JPEGDECODE_DESTBOXNOT2D := 3146180
    static D3D11_MESSAGE_ID_JPEGDECODE_DESTBOXNOTSUB := 3146181
    static D3D11_MESSAGE_ID_JPEGDECODE_DESTBOXESINTERSECT := 3146182
    static D3D11_MESSAGE_ID_JPEGDECODE_XSUBSAMPLEMISMATCH := 3146183
    static D3D11_MESSAGE_ID_JPEGDECODE_YSUBSAMPLEMISMATCH := 3146184
    static D3D11_MESSAGE_ID_JPEGDECODE_XSUBSAMPLEODD := 3146185
    static D3D11_MESSAGE_ID_JPEGDECODE_YSUBSAMPLEODD := 3146186
    static D3D11_MESSAGE_ID_JPEGDECODE_OUTPUTDIMENSIONSTOOLARGE := 3146187
    static D3D11_MESSAGE_ID_JPEGDECODE_NONPOW2SCALEUNSUPPORTED := 3146188
    static D3D11_MESSAGE_ID_JPEGDECODE_FRACTIONALDOWNSCALETOLARGE := 3146189
    static D3D11_MESSAGE_ID_JPEGDECODE_CHROMASIZEMISMATCH := 3146190
    static D3D11_MESSAGE_ID_JPEGDECODE_LUMACHROMASIZEMISMATCH := 3146191
    static D3D11_MESSAGE_ID_JPEGDECODE_INVALIDNUMDESTINATIONS := 3146192
    static D3D11_MESSAGE_ID_JPEGDECODE_SUBBOXUNSUPPORTED := 3146193
    static D3D11_MESSAGE_ID_JPEGDECODE_1DESTUNSUPPORTEDFORMAT := 3146194
    static D3D11_MESSAGE_ID_JPEGDECODE_3DESTUNSUPPORTEDFORMAT := 3146195
    static D3D11_MESSAGE_ID_JPEGDECODE_SCALEUNSUPPORTED := 3146196
    static D3D11_MESSAGE_ID_JPEGDECODE_INVALIDSOURCESIZE := 3146197
    static D3D11_MESSAGE_ID_JPEGDECODE_INVALIDCOPYFLAGS := 3146198
    static D3D11_MESSAGE_ID_JPEGDECODE_HAZARD := 3146199
    static D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPORTEDSRCBUFFERUSAGE := 3146200
    static D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPORTEDSRCBUFFERMISCFLAGS := 3146201
    static D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPORTEDDSTTEXTUREUSAGE := 3146202
    static D3D11_MESSAGE_ID_JPEGDECODE_BACKBUFFERNOTSUPPORTED := 3146203
    static D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPRTEDCOPYFLAGS := 3146204
    static D3D11_MESSAGE_ID_JPEGENCODE_NOTSUPPORTED := 3146205
    static D3D11_MESSAGE_ID_JPEGENCODE_INVALIDSCANDATAOFFSET := 3146206
    static D3D11_MESSAGE_ID_JPEGENCODE_INVALIDCOMPONENTS := 3146207
    static D3D11_MESSAGE_ID_JPEGENCODE_SOURCENOT2D := 3146208
    static D3D11_MESSAGE_ID_JPEGENCODE_TILEDRESOURCESUNSUPPORTED := 3146209
    static D3D11_MESSAGE_ID_JPEGENCODE_GUARDRECTSUNSUPPORTED := 3146210
    static D3D11_MESSAGE_ID_JPEGENCODE_XSUBSAMPLEMISMATCH := 3146211
    static D3D11_MESSAGE_ID_JPEGENCODE_YSUBSAMPLEMISMATCH := 3146212
    static D3D11_MESSAGE_ID_JPEGENCODE_FORMATUNSUPPORTED := 3146213
    static D3D11_MESSAGE_ID_JPEGENCODE_INVALIDSUBRESOURCE := 3146214
    static D3D11_MESSAGE_ID_JPEGENCODE_INVALIDMIPLEVEL := 3146215
    static D3D11_MESSAGE_ID_JPEGENCODE_DIMENSIONSTOOLARGE := 3146216
    static D3D11_MESSAGE_ID_JPEGENCODE_HAZARD := 3146217
    static D3D11_MESSAGE_ID_JPEGENCODE_UNSUPPORTEDDSTBUFFERUSAGE := 3146218
    static D3D11_MESSAGE_ID_JPEGENCODE_UNSUPPORTEDDSTBUFFERMISCFLAGS := 3146219
    static D3D11_MESSAGE_ID_JPEGENCODE_UNSUPPORTEDSRCTEXTUREUSAGE := 3146220
    static D3D11_MESSAGE_ID_JPEGENCODE_BACKBUFFERNOTSUPPORTED := 3146221
    static D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_UNSUPPORTEDCONTEXTTTYPEFORQUERY := 3146222
    static D3D11_MESSAGE_ID_FLUSH1_INVALIDCONTEXTTYPE := 3146223
    static D3D11_MESSAGE_ID_DEVICE_SETHARDWAREPROTECTION_INVALIDCONTEXT := 3146224
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTHDRMETADATA_NULLPARAM := 3146225
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTHDRMETADATA_INVALIDSIZE := 3146226
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTHDRMETADATA_NULLPARAM := 3146227
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTHDRMETADATA_INVALIDSIZE := 3146228
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMHDRMETADATA_NULLPARAM := 3146229
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMHDRMETADATA_INVALIDSTREAM := 3146230
    static D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMHDRMETADATA_INVALIDSIZE := 3146231
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMHDRMETADATA_NULLPARAM := 3146232
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMHDRMETADATA_INVALIDSTREAM := 3146233
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMHDRMETADATA_INVALIDSIZE := 3146234
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMFRAMEFORMAT_INVALIDSTREAM := 3146235
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMCOLORSPACE_INVALIDSTREAM := 3146236
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMOUTPUTRATE_INVALIDSTREAM := 3146237
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMSOURCERECT_INVALIDSTREAM := 3146238
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMDESTRECT_INVALIDSTREAM := 3146239
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMALPHA_INVALIDSTREAM := 3146240
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMPALETTE_INVALIDSTREAM := 3146241
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMPIXELASPECTRATIO_INVALIDSTREAM := 3146242
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMLUMAKEY_INVALIDSTREAM := 3146243
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMSTEREOFORMAT_INVALIDSTREAM := 3146244
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMAUTOPROCESSINGMODE_INVALIDSTREAM := 3146245
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMFILTER_INVALIDSTREAM := 3146246
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMROTATION_INVALIDSTREAM := 3146247
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMCOLORSPACE1_INVALIDSTREAM := 3146248
    static D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMMIRROR_INVALIDSTREAM := 3146249
    static D3D11_MESSAGE_ID_CREATE_FENCE := 3146250
    static D3D11_MESSAGE_ID_LIVE_FENCE := 3146251
    static D3D11_MESSAGE_ID_DESTROY_FENCE := 3146252
    static D3D11_MESSAGE_ID_CREATE_SYNCHRONIZEDCHANNEL := 3146253
    static D3D11_MESSAGE_ID_LIVE_SYNCHRONIZEDCHANNEL := 3146254
    static D3D11_MESSAGE_ID_DESTROY_SYNCHRONIZEDCHANNEL := 3146255
    static D3D11_MESSAGE_ID_CREATEFENCE_INVALIDFLAGS := 3146256
    static D3D11_MESSAGE_ID_D3D11_3_MESSAGES_END := 3146257
    static D3D11_MESSAGE_ID_D3D11_5_MESSAGES_START := 3146258
    static D3D11_MESSAGE_ID_NEGOTIATECRYPTOSESSIONKEYEXCHANGEMT_INVALIDKEYEXCHANGETYPE := 3146259
    static D3D11_MESSAGE_ID_NEGOTIATECRYPTOSESSIONKEYEXCHANGEMT_NOT_SUPPORTED := 3146260
    static D3D11_MESSAGE_ID_DECODERBEGINFRAME_INVALID_HISTOGRAM_COMPONENT_COUNT := 3146261
    static D3D11_MESSAGE_ID_DECODERBEGINFRAME_INVALID_HISTOGRAM_COMPONENT := 3146262
    static D3D11_MESSAGE_ID_DECODERBEGINFRAME_INVALID_HISTOGRAM_BUFFER_SIZE := 3146263
    static D3D11_MESSAGE_ID_DECODERBEGINFRAME_INVALID_HISTOGRAM_BUFFER_USAGE := 3146264
    static D3D11_MESSAGE_ID_DECODERBEGINFRAME_INVALID_HISTOGRAM_BUFFER_MISC_FLAGS := 3146265
    static D3D11_MESSAGE_ID_DECODERBEGINFRAME_INVALID_HISTOGRAM_BUFFER_OFFSET := 3146266
    static D3D11_MESSAGE_ID_CREATE_TRACKEDWORKLOAD := 3146267
    static D3D11_MESSAGE_ID_LIVE_TRACKEDWORKLOAD := 3146268
    static D3D11_MESSAGE_ID_DESTROY_TRACKEDWORKLOAD := 3146269
    static D3D11_MESSAGE_ID_CREATE_TRACKED_WORKLOAD_NULLPARAM := 3146270
    static D3D11_MESSAGE_ID_CREATE_TRACKED_WORKLOAD_INVALID_MAX_INSTANCES := 3146271
    static D3D11_MESSAGE_ID_CREATE_TRACKED_WORKLOAD_INVALID_DEADLINE_TYPE := 3146272
    static D3D11_MESSAGE_ID_CREATE_TRACKED_WORKLOAD_INVALID_ENGINE_TYPE := 3146273
    static D3D11_MESSAGE_ID_MULTIPLE_TRACKED_WORKLOADS := 3146274
    static D3D11_MESSAGE_ID_MULTIPLE_TRACKED_WORKLOAD_PAIRS := 3146275
    static D3D11_MESSAGE_ID_INCOMPLETE_TRACKED_WORKLOAD_PAIR := 3146276
    static D3D11_MESSAGE_ID_OUT_OF_ORDER_TRACKED_WORKLOAD_PAIR := 3146277
    static D3D11_MESSAGE_ID_CANNOT_ADD_TRACKED_WORKLOAD := 3146278
    static D3D11_MESSAGE_ID_TRACKED_WORKLOAD_NOT_SUPPORTED := 3146279
    static D3D11_MESSAGE_ID_TRACKED_WORKLOAD_ENGINE_TYPE_NOT_FOUND := 3146280
    static D3D11_MESSAGE_ID_NO_TRACKED_WORKLOAD_SLOT_AVAILABLE := 3146281
    static D3D11_MESSAGE_ID_END_TRACKED_WORKLOAD_INVALID_ARG := 3146282
    static D3D11_MESSAGE_ID_TRACKED_WORKLOAD_DISJOINT_FAILURE := 3146283
    static D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_AND_WRITE_MASK_MISMATCH := 3146284
    static D3D11_MESSAGE_ID_D3D11_5_MESSAGES_END := 3146285
}
struct D3D11_MESSAGE {
    Category : D3D11_MESSAGE_CATEGORY
    Severity : D3D11_MESSAGE_SEVERITY
    ID : D3D11_MESSAGE_ID
    pDescription : UInt8.Ptr
    DescriptionByteLength : IntPtr
}
struct D3D11_INFO_QUEUE_FILTER_DESC {
    NumCategories : UInt32
    pCategoryList : D3D11_MESSAGE_CATEGORY.Ptr
    NumSeverities : UInt32
    pSeverityList : D3D11_MESSAGE_SEVERITY.Ptr
    NumIDs : UInt32
    pIDList : D3D11_MESSAGE_ID.Ptr
}
struct D3D11_INFO_QUEUE_FILTER {
    AllowList : D3D11_INFO_QUEUE_FILTER_DESC
    DenyList : D3D11_INFO_QUEUE_FILTER_DESC
}
struct ID3D11InfoQueue extends IUnknown {
    static IID := "{6543DBB6-1B48-42F5-AB82-E97EC74326F6}"
    SetMessageCountLimit(MessageCountLimit)
      => ComCall(3, this.p, Int64, MessageCountLimit)
    ClearStoredMessages()
      => ComCall(4, this.p, "void")
    GetMessage(MessageIndex, pMessage?, pMessageByteLength)
      => ComCall(5, this.p, Int64, MessageIndex, D3D11_MESSAGE.Ptr, pMessage?, IntPtr.Ptr, pMessageByteLength)
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
      => ComCall(12, this.p, D3D11_INFO_QUEUE_FILTER.Ptr, pFilter)
    GetStorageFilter(pFilter?, pFilterByteLength)
      => ComCall(13, this.p, D3D11_INFO_QUEUE_FILTER.Ptr, pFilter?, IntPtr.Ptr, pFilterByteLength)
    ClearStorageFilter()
      => ComCall(14, this.p, "void")
    PushEmptyStorageFilter()
      => ComCall(15, this.p)
    PushCopyOfStorageFilter()
      => ComCall(16, this.p)
    PushStorageFilter(pFilter)
      => ComCall(17, this.p, D3D11_INFO_QUEUE_FILTER.Ptr, pFilter)
    PopStorageFilter()
      => ComCall(18, this.p, "void")
    GetStorageFilterStackSize()
      => ComCall(19, this.p, UInt32)
    AddRetrievalFilterEntries(pFilter)
      => ComCall(20, this.p, D3D11_INFO_QUEUE_FILTER.Ptr, pFilter)
    GetRetrievalFilter(pFilter?, pFilterByteLength)
      => ComCall(21, this.p, D3D11_INFO_QUEUE_FILTER.Ptr, pFilter?, IntPtr.Ptr, pFilterByteLength)
    ClearRetrievalFilter()
      => ComCall(22, this.p, "void")
    PushEmptyRetrievalFilter()
      => ComCall(23, this.p)
    PushCopyOfRetrievalFilter()
      => ComCall(24, this.p)
    PushRetrievalFilter(pFilter)
      => ComCall(25, this.p, D3D11_INFO_QUEUE_FILTER.Ptr, pFilter)
    PopRetrievalFilter()
      => ComCall(26, this.p, "void")
    GetRetrievalFilterStackSize()
      => ComCall(27, this.p, UInt32)
    AddMessage(Category, Severity, ID, pDescription)
      => ComCall(28, this.p, D3D11_MESSAGE_CATEGORY, Category, D3D11_MESSAGE_SEVERITY, Severity, D3D11_MESSAGE_ID, ID, PSTR, pDescription)
    AddApplicationMessage(Severity, pDescription)
      => ComCall(29, this.p, D3D11_MESSAGE_SEVERITY, Severity, PSTR, pDescription)
    SetBreakOnCategory(Category, bEnable)
      => ComCall(30, this.p, D3D11_MESSAGE_CATEGORY, Category, BOOL, bEnable)
    SetBreakOnSeverity(Severity, bEnable)
      => ComCall(31, this.p, D3D11_MESSAGE_SEVERITY, Severity, BOOL, bEnable)
    SetBreakOnID(ID, bEnable)
      => ComCall(32, this.p, D3D11_MESSAGE_ID, ID, BOOL, bEnable)
    GetBreakOnCategory(Category)
      => ComCall(33, this.p, D3D11_MESSAGE_CATEGORY, Category, BOOL)
    GetBreakOnSeverity(Severity)
      => ComCall(34, this.p, D3D11_MESSAGE_SEVERITY, Severity, BOOL)
    GetBreakOnID(ID)
      => ComCall(35, this.p, D3D11_MESSAGE_ID, ID, BOOL)
    SetMuteDebugOutput(bMute)
      => ComCall(36, this.p, BOOL, bMute, "void")
    GetMuteDebugOutput()
      => ComCall(37, this.p, BOOL)
}
struct PFN_D3D11_CREATE_DEVICE extends FunctionPointer {
    static Types := [IDXGIAdapter, D3D_DRIVER_TYPE, HMODULE, UInt32, D3D_FEATURE_LEVEL.Ptr, UInt32, UInt32, ID3D11Device.Ptr, D3D_FEATURE_LEVEL.Ptr, ID3D11DeviceContext.Ptr, HRESULT]
}
struct PFN_D3D11_CREATE_DEVICE_AND_SWAP_CHAIN extends FunctionPointer {
    static Types := [IDXGIAdapter, D3D_DRIVER_TYPE, HMODULE, UInt32, D3D_FEATURE_LEVEL.Ptr, UInt32, UInt32, DXGI_SWAP_CHAIN_DESC.Ptr, IDXGISwapChain.Ptr, ID3D11Device.Ptr, D3D_FEATURE_LEVEL.Ptr, ID3D11DeviceContext.Ptr, HRESULT]
}
struct D3D11_COPY_FLAGS extends Int32 {
    static D3D11_COPY_NO_OVERWRITE := 1
    static D3D11_COPY_DISCARD := 2
}
struct D3D11_LOGIC_OP extends Int32 {
    static D3D11_LOGIC_OP_CLEAR := 0
    static D3D11_LOGIC_OP_SET := 1
    static D3D11_LOGIC_OP_COPY := 2
    static D3D11_LOGIC_OP_COPY_INVERTED := 3
    static D3D11_LOGIC_OP_NOOP := 4
    static D3D11_LOGIC_OP_INVERT := 5
    static D3D11_LOGIC_OP_AND := 6
    static D3D11_LOGIC_OP_NAND := 7
    static D3D11_LOGIC_OP_OR := 8
    static D3D11_LOGIC_OP_NOR := 9
    static D3D11_LOGIC_OP_XOR := 10
    static D3D11_LOGIC_OP_EQUIV := 11
    static D3D11_LOGIC_OP_AND_REVERSE := 12
    static D3D11_LOGIC_OP_AND_INVERTED := 13
    static D3D11_LOGIC_OP_OR_REVERSE := 14
    static D3D11_LOGIC_OP_OR_INVERTED := 15
}
struct D3D11_RENDER_TARGET_BLEND_DESC1 {
    BlendEnable : BOOL
    LogicOpEnable : BOOL
    SrcBlend : D3D11_BLEND
    DestBlend : D3D11_BLEND
    BlendOp : D3D11_BLEND_OP
    SrcBlendAlpha : D3D11_BLEND
    DestBlendAlpha : D3D11_BLEND
    BlendOpAlpha : D3D11_BLEND_OP
    LogicOp : D3D11_LOGIC_OP
    RenderTargetWriteMask : UInt8
}
struct D3D11_BLEND_DESC1 {
    AlphaToCoverageEnable : BOOL
    IndependentBlendEnable : BOOL
    RenderTarget : D3D11_RENDER_TARGET_BLEND_DESC1[8]
}
struct ID3D11BlendState1 extends ID3D11BlendState {
    static IID := "{CC86FABE-DA55-401D-85E7-E3C9DE2877E9}"
    GetDesc1(pDesc)
      => ComCall(8, this.p, D3D11_BLEND_DESC1.Ptr, pDesc, "void")
}
struct D3D11_RASTERIZER_DESC1 {
    FillMode : D3D11_FILL_MODE
    CullMode : D3D11_CULL_MODE
    FrontCounterClockwise : BOOL
    DepthBias : Int32
    DepthBiasClamp : Float32
    SlopeScaledDepthBias : Float32
    DepthClipEnable : BOOL
    ScissorEnable : BOOL
    MultisampleEnable : BOOL
    AntialiasedLineEnable : BOOL
    ForcedSampleCount : UInt32
}
struct ID3D11RasterizerState1 extends ID3D11RasterizerState {
    static IID := "{1217D7A6-5039-418C-B042-9CBE256AFD6E}"
    GetDesc1(pDesc)
      => ComCall(8, this.p, D3D11_RASTERIZER_DESC1.Ptr, pDesc, "void")
}
struct D3D11_1_CREATE_DEVICE_CONTEXT_STATE_FLAG extends Int32 {
    static D3D11_1_CREATE_DEVICE_CONTEXT_STATE_SINGLETHREADED := 1
}
struct ID3DDeviceContextState extends ID3D11DeviceChild {
    static IID := "{5C1E0D8A-7C23-48F9-8C59-A92958CEFF11}"
}
struct ID3D11DeviceContext1 extends ID3D11DeviceContext {
    static IID := "{BB2C6FAA-B5FB-4082-8E6B-388B8CFA90E1}"
    CopySubresourceRegion1(pDstResource, DstSubresource, DstX, DstY, DstZ, pSrcResource, SrcSubresource, pSrcBox?, CopyFlags)
      => ComCall(115, this.p, ID3D11Resource, pDstResource, UInt32, DstSubresource, UInt32, DstX, UInt32, DstY, UInt32, DstZ, ID3D11Resource, pSrcResource, UInt32, SrcSubresource, D3D11_BOX.Ptr, pSrcBox?, UInt32, CopyFlags, "void")
    UpdateSubresource1(pDstResource, DstSubresource, pDstBox?, pSrcData, SrcRowPitch, SrcDepthPitch, CopyFlags)
      => ComCall(116, this.p, ID3D11Resource, pDstResource, UInt32, DstSubresource, D3D11_BOX.Ptr, pDstBox?, Struct.Ptr, pSrcData, UInt32, SrcRowPitch, UInt32, SrcDepthPitch, UInt32, CopyFlags, "void")
    DiscardResource(pResource)
      => ComCall(117, this.p, ID3D11Resource, pResource, "void")
    DiscardView(pResourceView)
      => ComCall(118, this.p, ID3D11View, pResourceView, "void")
    VSSetConstantBuffers1(StartSlot, ppConstantBuffers?, pFirstConstant?, pNumConstants?)
      => ComCall(119, this.p, UInt32, StartSlot, UInt32, pNumConstants?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, UInt32.Ptr, pFirstConstant?, UInt32.Ptr, pNumConstants?, "void")
    HSSetConstantBuffers1(StartSlot, ppConstantBuffers?, pFirstConstant?, pNumConstants?)
      => ComCall(120, this.p, UInt32, StartSlot, UInt32, pNumConstants?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, UInt32.Ptr, pFirstConstant?, UInt32.Ptr, pNumConstants?, "void")
    DSSetConstantBuffers1(StartSlot, ppConstantBuffers?, pFirstConstant?, pNumConstants?)
      => ComCall(121, this.p, UInt32, StartSlot, UInt32, pNumConstants?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, UInt32.Ptr, pFirstConstant?, UInt32.Ptr, pNumConstants?, "void")
    GSSetConstantBuffers1(StartSlot, ppConstantBuffers?, pFirstConstant?, pNumConstants?)
      => ComCall(122, this.p, UInt32, StartSlot, UInt32, pNumConstants?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, UInt32.Ptr, pFirstConstant?, UInt32.Ptr, pNumConstants?, "void")
    PSSetConstantBuffers1(StartSlot, ppConstantBuffers?, pFirstConstant?, pNumConstants?)
      => ComCall(123, this.p, UInt32, StartSlot, UInt32, pNumConstants?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, UInt32.Ptr, pFirstConstant?, UInt32.Ptr, pNumConstants?, "void")
    CSSetConstantBuffers1(StartSlot, ppConstantBuffers?, pFirstConstant?, pNumConstants?)
      => ComCall(124, this.p, UInt32, StartSlot, UInt32, pNumConstants?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, UInt32.Ptr, pFirstConstant?, UInt32.Ptr, pNumConstants?, "void")
    VSGetConstantBuffers1(StartSlot, ppConstantBuffers?, pFirstConstant?, pNumConstants?)
      => ComCall(125, this.p, UInt32, StartSlot, UInt32, pNumConstants?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, UInt32.Ptr, pFirstConstant?, UInt32.Ptr, pNumConstants?, "void")
    HSGetConstantBuffers1(StartSlot, ppConstantBuffers?, pFirstConstant?, pNumConstants?)
      => ComCall(126, this.p, UInt32, StartSlot, UInt32, pNumConstants?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, UInt32.Ptr, pFirstConstant?, UInt32.Ptr, pNumConstants?, "void")
    DSGetConstantBuffers1(StartSlot, ppConstantBuffers?, pFirstConstant?, pNumConstants?)
      => ComCall(127, this.p, UInt32, StartSlot, UInt32, pNumConstants?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, UInt32.Ptr, pFirstConstant?, UInt32.Ptr, pNumConstants?, "void")
    GSGetConstantBuffers1(StartSlot, ppConstantBuffers?, pFirstConstant?, pNumConstants?)
      => ComCall(128, this.p, UInt32, StartSlot, UInt32, pNumConstants?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, UInt32.Ptr, pFirstConstant?, UInt32.Ptr, pNumConstants?, "void")
    PSGetConstantBuffers1(StartSlot, ppConstantBuffers?, pFirstConstant?, pNumConstants?)
      => ComCall(129, this.p, UInt32, StartSlot, UInt32, pNumConstants?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, UInt32.Ptr, pFirstConstant?, UInt32.Ptr, pNumConstants?, "void")
    CSGetConstantBuffers1(StartSlot, ppConstantBuffers?, pFirstConstant?, pNumConstants?)
      => ComCall(130, this.p, UInt32, StartSlot, UInt32, pNumConstants?.Length ?? 0, ID3D11Buffer.Ptr, ppConstantBuffers?, UInt32.Ptr, pFirstConstant?, UInt32.Ptr, pNumConstants?, "void")
    SwapDeviceContextState(pState, ppPreviousState?)
      => ComCall(131, this.p, ID3DDeviceContextState, pState, ID3DDeviceContextState.Ptr, ppPreviousState?, "void")
    ClearView(pView, Color, pRect?)
      => ComCall(132, this.p, ID3D11View, pView, Float32.Ptr, Color, RECT.Ptr, pRect?, UInt32, pRect?.Length ?? 0, "void")
    DiscardView1(pResourceView, pRects?)
      => ComCall(133, this.p, ID3D11View, pResourceView, RECT.Ptr, pRects?, UInt32, pRects?.Length ?? 0, "void")
}
struct D3D11_VIDEO_DECODER_SUB_SAMPLE_MAPPING_BLOCK {
    ClearSize : UInt32
    EncryptedSize : UInt32
}
struct D3D11_VIDEO_DECODER_BUFFER_DESC1 {
    BufferType : D3D11_VIDEO_DECODER_BUFFER_TYPE
    DataOffset : UInt32
    DataSize : UInt32
    pIV : Struct.Ptr
    IVSize : UInt32
    pSubSampleMappingBlock : D3D11_VIDEO_DECODER_SUB_SAMPLE_MAPPING_BLOCK.Ptr
    SubSampleMappingCount : UInt32
}
struct D3D11_VIDEO_DECODER_BEGIN_FRAME_CRYPTO_SESSION {
    pCryptoSession : ID3D11CryptoSession
    BlobSize : UInt32
    pBlob : Struct.Ptr
    pKeyInfoId : GUID.Ptr
    PrivateDataSize : UInt32
    pPrivateData : Struct.Ptr
}
struct D3D11_VIDEO_DECODER_CAPS extends Int32 {
    static D3D11_VIDEO_DECODER_CAPS_DOWNSAMPLE := 1
    static D3D11_VIDEO_DECODER_CAPS_NON_REAL_TIME := 2
    static D3D11_VIDEO_DECODER_CAPS_DOWNSAMPLE_DYNAMIC := 4
    static D3D11_VIDEO_DECODER_CAPS_DOWNSAMPLE_REQUIRED := 8
    static D3D11_VIDEO_DECODER_CAPS_UNSUPPORTED := 16
}
struct D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINTS extends Int32 {
    static D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINT_MULTIPLANE_OVERLAY_ROTATION := 1
    static D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINT_MULTIPLANE_OVERLAY_RESIZE := 2
    static D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINT_MULTIPLANE_OVERLAY_COLOR_SPACE_CONVERSION := 4
    static D3D11_VIDEO_PROCESSOR_BEHAVIOR_HINT_TRIPLE_BUFFER_OUTPUT := 8
}
struct D3D11_VIDEO_PROCESSOR_STREAM_BEHAVIOR_HINT {
    Enable : BOOL
    Width : UInt32
    Height : UInt32
    Format : DXGI_FORMAT
}
struct D3D11_CRYPTO_SESSION_STATUS extends Int32 {
    static D3D11_CRYPTO_SESSION_STATUS_OK := 0
    static D3D11_CRYPTO_SESSION_STATUS_KEY_LOST := 1
    static D3D11_CRYPTO_SESSION_STATUS_KEY_AND_CONTENT_LOST := 2
}
struct D3D11_KEY_EXCHANGE_HW_PROTECTION_INPUT_DATA {
    PrivateDataSize : UInt32
    HWProtectionDataSize : UInt32
    pbInput : UInt8[4]
}
struct D3D11_KEY_EXCHANGE_HW_PROTECTION_OUTPUT_DATA {
    PrivateDataSize : UInt32
    MaxHWProtectionDataSize : UInt32
    HWProtectionDataSize : UInt32
    TransportTime : Int64
    ExecutionTime : Int64
    pbOutput : UInt8[4]
}
struct D3D11_KEY_EXCHANGE_HW_PROTECTION_DATA {
    HWProtectionFunctionID : UInt32
    pInputData : D3D11_KEY_EXCHANGE_HW_PROTECTION_INPUT_DATA.Ptr
    pOutputData : D3D11_KEY_EXCHANGE_HW_PROTECTION_OUTPUT_DATA.Ptr
    Status : HRESULT
}
struct D3D11_VIDEO_SAMPLE_DESC {
    Width : UInt32
    Height : UInt32
    Format : DXGI_FORMAT
    ColorSpace : DXGI_COLOR_SPACE_TYPE
}
struct ID3D11VideoContext1 extends ID3D11VideoContext {
    static IID := "{A7F026DA-A5F8-4487-A564-15E34357651E}"
    SubmitDecoderBuffers1(pDecoder, pBufferDesc)
      => ComCall(65, this.p, ID3D11VideoDecoder, pDecoder, UInt32, pBufferDesc.Length, D3D11_VIDEO_DECODER_BUFFER_DESC1.Ptr, pBufferDesc)
    GetDataForNewHardwareKey(pCryptoSession, pPrivatInputData, pPrivateOutputData)
      => ComCall(66, this.p, ID3D11CryptoSession, pCryptoSession, UInt32, pPrivatInputData.Length, Struct.Ptr, pPrivatInputData, Int64.Ptr, pPrivateOutputData)
    CheckCryptoSessionStatus(pCryptoSession, pStatus)
      => ComCall(67, this.p, ID3D11CryptoSession, pCryptoSession, D3D11_CRYPTO_SESSION_STATUS.Ptr, pStatus)
    DecoderEnableDownsampling(pDecoder, InputColorSpace, pOutputDesc, ReferenceFrameCount)
      => ComCall(68, this.p, ID3D11VideoDecoder, pDecoder, DXGI_COLOR_SPACE_TYPE, InputColorSpace, D3D11_VIDEO_SAMPLE_DESC.Ptr, pOutputDesc, UInt32, ReferenceFrameCount)
    DecoderUpdateDownsampling(pDecoder, pOutputDesc)
      => ComCall(69, this.p, ID3D11VideoDecoder, pDecoder, D3D11_VIDEO_SAMPLE_DESC.Ptr, pOutputDesc)
    VideoProcessorSetOutputColorSpace1(pVideoProcessor, ColorSpace)
      => ComCall(70, this.p, ID3D11VideoProcessor, pVideoProcessor, DXGI_COLOR_SPACE_TYPE, ColorSpace, "void")
    VideoProcessorSetOutputShaderUsage(pVideoProcessor, ShaderUsage)
      => ComCall(71, this.p, ID3D11VideoProcessor, pVideoProcessor, BOOL, ShaderUsage, "void")
    VideoProcessorGetOutputColorSpace1(pVideoProcessor, pColorSpace)
      => ComCall(72, this.p, ID3D11VideoProcessor, pVideoProcessor, DXGI_COLOR_SPACE_TYPE.Ptr, pColorSpace, "void")
    VideoProcessorGetOutputShaderUsage(pVideoProcessor, pShaderUsage)
      => ComCall(73, this.p, ID3D11VideoProcessor, pVideoProcessor, BOOL.Ptr, pShaderUsage, "void")
    VideoProcessorSetStreamColorSpace1(pVideoProcessor, StreamIndex, ColorSpace)
      => ComCall(74, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, DXGI_COLOR_SPACE_TYPE, ColorSpace, "void")
    VideoProcessorSetStreamMirror(pVideoProcessor, StreamIndex, Enable, FlipHorizontal, FlipVertical)
      => ComCall(75, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL, Enable, BOOL, FlipHorizontal, BOOL, FlipVertical, "void")
    VideoProcessorGetStreamColorSpace1(pVideoProcessor, StreamIndex, pColorSpace)
      => ComCall(76, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, DXGI_COLOR_SPACE_TYPE.Ptr, pColorSpace, "void")
    VideoProcessorGetStreamMirror(pVideoProcessor, StreamIndex, pEnable, pFlipHorizontal, pFlipVertical)
      => ComCall(77, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, BOOL.Ptr, pEnable, BOOL.Ptr, pFlipHorizontal, BOOL.Ptr, pFlipVertical, "void")
    VideoProcessorGetBehaviorHints(pVideoProcessor, OutputWidth, OutputHeight, OutputFormat, pStreams, pBehaviorHints)
      => ComCall(78, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, OutputWidth, UInt32, OutputHeight, DXGI_FORMAT, OutputFormat, UInt32, pStreams.Length, D3D11_VIDEO_PROCESSOR_STREAM_BEHAVIOR_HINT.Ptr, pStreams, UInt32.Ptr, pBehaviorHints)
}
struct ID3D11VideoDevice1 extends ID3D11VideoDevice {
    static IID := "{29DA1D51-1321-4454-804B-F5FC9F861F0F}"
    GetCryptoSessionPrivateDataSize(pCryptoType, pDecoderProfile?, pKeyExchangeType, pPrivateInputSize, pPrivateOutputSize)
      => ComCall(20, this.p, GUID.Ptr, pCryptoType, GUID.Ptr, pDecoderProfile?, GUID.Ptr, pKeyExchangeType, UInt32.Ptr, pPrivateInputSize, UInt32.Ptr, pPrivateOutputSize)
    GetVideoDecoderCaps(pDecoderProfile, SampleWidth, SampleHeight, pFrameRate, BitRate, pCryptoType?, pDecoderCaps)
      => ComCall(21, this.p, GUID.Ptr, pDecoderProfile, UInt32, SampleWidth, UInt32, SampleHeight, DXGI_RATIONAL.Ptr, pFrameRate, UInt32, BitRate, GUID.Ptr, pCryptoType?, UInt32.Ptr, pDecoderCaps)
    CheckVideoDecoderDownsampling(pInputDesc, InputColorSpace, pInputConfig, pFrameRate, pOutputDesc, pSupported, pRealTimeHint)
      => ComCall(22, this.p, D3D11_VIDEO_DECODER_DESC.Ptr, pInputDesc, DXGI_COLOR_SPACE_TYPE, InputColorSpace, D3D11_VIDEO_DECODER_CONFIG.Ptr, pInputConfig, DXGI_RATIONAL.Ptr, pFrameRate, D3D11_VIDEO_SAMPLE_DESC.Ptr, pOutputDesc, BOOL.Ptr, pSupported, BOOL.Ptr, pRealTimeHint)
    RecommendVideoDecoderDownsampleParameters(pInputDesc, InputColorSpace, pInputConfig, pFrameRate, pRecommendedOutputDesc)
      => ComCall(23, this.p, D3D11_VIDEO_DECODER_DESC.Ptr, pInputDesc, DXGI_COLOR_SPACE_TYPE, InputColorSpace, D3D11_VIDEO_DECODER_CONFIG.Ptr, pInputConfig, DXGI_RATIONAL.Ptr, pFrameRate, D3D11_VIDEO_SAMPLE_DESC.Ptr, pRecommendedOutputDesc)
}
struct ID3D11VideoProcessorEnumerator1 extends ID3D11VideoProcessorEnumerator {
    static IID := "{465217F2-5568-43CF-B5B9-F61D54531CA1}"
    CheckVideoProcessorFormatConversion(InputFormat, InputColorSpace, OutputFormat, OutputColorSpace, pSupported)
      => ComCall(13, this.p, DXGI_FORMAT, InputFormat, DXGI_COLOR_SPACE_TYPE, InputColorSpace, DXGI_FORMAT, OutputFormat, DXGI_COLOR_SPACE_TYPE, OutputColorSpace, BOOL.Ptr, pSupported)
}
struct ID3D11Device1 extends ID3D11Device {
    static IID := "{A04BFB29-08EF-43D6-A49C-A9BDBDCBE686}"
    GetImmediateContext1(ppImmediateContext)
      => ComCall(43, this.p, ID3D11DeviceContext1.Ptr, ppImmediateContext, "void")
    CreateDeferredContext1(ContextFlags, ppDeferredContext?)
      => ComCall(44, this.p, UInt32, ContextFlags, ID3D11DeviceContext1.Ptr, ppDeferredContext?)
    CreateBlendState1(pBlendStateDesc, ppBlendState?)
      => ComCall(45, this.p, D3D11_BLEND_DESC1.Ptr, pBlendStateDesc, ID3D11BlendState1.Ptr, ppBlendState?)
    CreateRasterizerState1(pRasterizerDesc, ppRasterizerState?)
      => ComCall(46, this.p, D3D11_RASTERIZER_DESC1.Ptr, pRasterizerDesc, ID3D11RasterizerState1.Ptr, ppRasterizerState?)
    CreateDeviceContextState(Flags, pFeatureLevels, SDKVersion, EmulatedInterface, pChosenFeatureLevel?, ppContextState?)
      => ComCall(47, this.p, UInt32, Flags, D3D_FEATURE_LEVEL.Ptr, pFeatureLevels, UInt32, pFeatureLevels.Length, UInt32, SDKVersion, GUID.Ptr, EmulatedInterface, D3D_FEATURE_LEVEL.Ptr, pChosenFeatureLevel?, ID3DDeviceContextState.Ptr, ppContextState?)
    OpenSharedResource1(hResource, returnedInterface, ppResource)
      => ComCall(48, this.p, HANDLE, hResource, GUID.Ptr, returnedInterface, Struct.Ptr.Ptr, ppResource)
    OpenSharedResourceByName(lpName, dwDesiredAccess, returnedInterface, ppResource)
      => ComCall(49, this.p, "Str", lpName, UInt32, dwDesiredAccess, GUID.Ptr, returnedInterface, Struct.Ptr.Ptr, ppResource)
}
struct ID3DUserDefinedAnnotation extends IUnknown {
    static IID := "{B2DAAD8B-03D4-4DBF-95EB-32AB4B63D0AB}"
    BeginEvent(Name)
      => ComCall(3, this.p, "Str", Name, Int32)
    EndEvent()
      => ComCall(4, this.p, Int32)
    SetMarker(Name)
      => ComCall(5, this.p, "Str", Name, "void")
    GetStatus()
      => ComCall(6, this.p, BOOL)
}
struct D3D11_TILED_RESOURCE_COORDINATE {
    X : UInt32
    Y : UInt32
    Z : UInt32
    Subresource : UInt32
}
struct D3D11_TILE_REGION_SIZE {
    NumTiles : UInt32
    bUseBox : BOOL
    Width : UInt32
    Height : UInt16
    Depth : UInt16
}
struct D3D11_TILE_MAPPING_FLAG extends Int32 {
    static D3D11_TILE_MAPPING_NO_OVERWRITE := 1
}
struct D3D11_TILE_RANGE_FLAG extends Int32 {
    static D3D11_TILE_RANGE_NULL := 1
    static D3D11_TILE_RANGE_SKIP := 2
    static D3D11_TILE_RANGE_REUSE_SINGLE_TILE := 4
}
struct D3D11_SUBRESOURCE_TILING {
    WidthInTiles : UInt32
    HeightInTiles : UInt16
    DepthInTiles : UInt16
    StartTileIndexInOverallResource : UInt32
}
struct D3D11_TILE_SHAPE {
    WidthInTexels : UInt32
    HeightInTexels : UInt32
    DepthInTexels : UInt32
}
struct D3D11_PACKED_MIP_DESC {
    NumStandardMips : UInt8
    NumPackedMips : UInt8
    NumTilesForPackedMips : UInt32
    StartTileIndexInOverallResource : UInt32
}
struct D3D11_CHECK_MULTISAMPLE_QUALITY_LEVELS_FLAG extends Int32 {
    static D3D11_CHECK_MULTISAMPLE_QUALITY_LEVELS_TILED_RESOURCE := 1
}
struct D3D11_TILE_COPY_FLAG extends Int32 {
    static D3D11_TILE_COPY_NO_OVERWRITE := 1
    static D3D11_TILE_COPY_LINEAR_BUFFER_TO_SWIZZLED_TILED_RESOURCE := 2
    static D3D11_TILE_COPY_SWIZZLED_TILED_RESOURCE_TO_LINEAR_BUFFER := 4
}
struct ID3D11DeviceContext2 extends ID3D11DeviceContext1 {
    static IID := "{420D5B32-B90C-4DA4-BEF0-359F6A24A83A}"
    UpdateTileMappings(pTiledResource, pTiledResourceRegionStartCoordinates?, pTiledResourceRegionSizes?, pTilePool?, pRangeFlags?, pTilePoolStartOffsets?, pRangeTileCounts?, Flags)
      => ComCall(134, this.p, ID3D11Resource, pTiledResource, UInt32, pTiledResourceRegionSizes?.Length ?? 0, D3D11_TILED_RESOURCE_COORDINATE.Ptr, pTiledResourceRegionStartCoordinates?, D3D11_TILE_REGION_SIZE.Ptr, pTiledResourceRegionSizes?, ID3D11Buffer, pTilePool?, UInt32, pRangeTileCounts?.Length ?? 0, UInt32.Ptr, pRangeFlags?, UInt32.Ptr, pTilePoolStartOffsets?, UInt32.Ptr, pRangeTileCounts?, UInt32, Flags)
    CopyTileMappings(pDestTiledResource, pDestRegionStartCoordinate, pSourceTiledResource, pSourceRegionStartCoordinate, pTileRegionSize, Flags)
      => ComCall(135, this.p, ID3D11Resource, pDestTiledResource, D3D11_TILED_RESOURCE_COORDINATE.Ptr, pDestRegionStartCoordinate, ID3D11Resource, pSourceTiledResource, D3D11_TILED_RESOURCE_COORDINATE.Ptr, pSourceRegionStartCoordinate, D3D11_TILE_REGION_SIZE.Ptr, pTileRegionSize, UInt32, Flags)
    CopyTiles(pTiledResource, pTileRegionStartCoordinate, pTileRegionSize, pBuffer, BufferStartOffsetInBytes, Flags)
      => ComCall(136, this.p, ID3D11Resource, pTiledResource, D3D11_TILED_RESOURCE_COORDINATE.Ptr, pTileRegionStartCoordinate, D3D11_TILE_REGION_SIZE.Ptr, pTileRegionSize, ID3D11Buffer, pBuffer, Int64, BufferStartOffsetInBytes, UInt32, Flags, "void")
    UpdateTiles(pDestTiledResource, pDestTileRegionStartCoordinate, pDestTileRegionSize, pSourceTileData, Flags)
      => ComCall(137, this.p, ID3D11Resource, pDestTiledResource, D3D11_TILED_RESOURCE_COORDINATE.Ptr, pDestTileRegionStartCoordinate, D3D11_TILE_REGION_SIZE.Ptr, pDestTileRegionSize, Struct.Ptr, pSourceTileData, UInt32, Flags, "void")
    ResizeTilePool(pTilePool, NewSizeInBytes)
      => ComCall(138, this.p, ID3D11Buffer, pTilePool, Int64, NewSizeInBytes)
    TiledResourceBarrier(pTiledResourceOrViewAccessBeforeBarrier?, pTiledResourceOrViewAccessAfterBarrier?)
      => ComCall(139, this.p, ID3D11DeviceChild, pTiledResourceOrViewAccessBeforeBarrier?, ID3D11DeviceChild, pTiledResourceOrViewAccessAfterBarrier?, "void")
    IsAnnotationEnabled()
      => ComCall(140, this.p, BOOL)
    SetMarkerInt(pLabel, Data)
      => ComCall(141, this.p, "Str", pLabel, Int32, Data, "void")
    BeginEventInt(pLabel, Data)
      => ComCall(142, this.p, "Str", pLabel, Int32, Data, "void")
    EndEvent()
      => ComCall(143, this.p, "void")
}
struct ID3D11Device2 extends ID3D11Device1 {
    static IID := "{9D06DFFA-D1E5-4D07-83A8-1BB123F2F841}"
    GetImmediateContext2(ppImmediateContext)
      => ComCall(50, this.p, ID3D11DeviceContext2.Ptr, ppImmediateContext, "void")
    CreateDeferredContext2(ContextFlags, ppDeferredContext?)
      => ComCall(51, this.p, UInt32, ContextFlags, ID3D11DeviceContext2.Ptr, ppDeferredContext?)
    GetResourceTiling(pTiledResource, pNumTilesForEntireResource?, pPackedMipDesc?, pStandardTileShapeForNonPackedMips?, FirstSubresourceTilingToGet, pSubresourceTilingsForNonPackedMips)
      => ComCall(52, this.p, ID3D11Resource, pTiledResource, UInt32.Ptr, pNumTilesForEntireResource?, D3D11_PACKED_MIP_DESC.Ptr, pPackedMipDesc?, D3D11_TILE_SHAPE.Ptr, pStandardTileShapeForNonPackedMips?, UInt32.Ptr, pSubresourceTilingsForNonPackedMips.Length, UInt32, FirstSubresourceTilingToGet, D3D11_SUBRESOURCE_TILING.Ptr, pSubresourceTilingsForNonPackedMips, "void")
    CheckMultisampleQualityLevels1(Format, SampleCount, Flags, pNumQualityLevels)
      => ComCall(53, this.p, DXGI_FORMAT, Format, UInt32, SampleCount, UInt32, Flags, UInt32.Ptr, pNumQualityLevels)
}
struct D3D11_CONTEXT_TYPE extends Int32 {
    static D3D11_CONTEXT_TYPE_ALL := 0
    static D3D11_CONTEXT_TYPE_3D := 1
    static D3D11_CONTEXT_TYPE_COMPUTE := 2
    static D3D11_CONTEXT_TYPE_COPY := 3
    static D3D11_CONTEXT_TYPE_VIDEO := 4
}
struct D3D11_TEXTURE_LAYOUT extends Int32 {
    static D3D11_TEXTURE_LAYOUT_UNDEFINED := 0
    static D3D11_TEXTURE_LAYOUT_ROW_MAJOR := 1
    static D3D11_TEXTURE_LAYOUT_64K_STANDARD_SWIZZLE := 2
}
struct D3D11_TEXTURE2D_DESC1 {
    Width : UInt32
    Height : UInt32
    MipLevels : UInt32
    ArraySize : UInt32
    Format : DXGI_FORMAT
    SampleDesc : DXGI_SAMPLE_DESC
    Usage : D3D11_USAGE
    BindFlags : UInt32
    CPUAccessFlags : UInt32
    MiscFlags : UInt32
    TextureLayout : D3D11_TEXTURE_LAYOUT
}
struct ID3D11Texture2D1 extends ID3D11Texture2D {
    static IID := "{51218251-1E33-4617-9CCB-4D3A4367E7BB}"
    GetDesc1(pDesc)
      => ComCall(11, this.p, D3D11_TEXTURE2D_DESC1.Ptr, pDesc, "void")
}
struct D3D11_TEXTURE3D_DESC1 {
    Width : UInt32
    Height : UInt32
    Depth : UInt32
    MipLevels : UInt32
    Format : DXGI_FORMAT
    Usage : D3D11_USAGE
    BindFlags : UInt32
    CPUAccessFlags : UInt32
    MiscFlags : UInt32
    TextureLayout : D3D11_TEXTURE_LAYOUT
}
struct ID3D11Texture3D1 extends ID3D11Texture3D {
    static IID := "{0C711683-2853-4846-9BB0-F3E60639E46A}"
    GetDesc1(pDesc)
      => ComCall(11, this.p, D3D11_TEXTURE3D_DESC1.Ptr, pDesc, "void")
}
struct D3D11_CONSERVATIVE_RASTERIZATION_MODE extends Int32 {
    static D3D11_CONSERVATIVE_RASTERIZATION_MODE_OFF := 0
    static D3D11_CONSERVATIVE_RASTERIZATION_MODE_ON := 1
}
struct D3D11_RASTERIZER_DESC2 {
    FillMode : D3D11_FILL_MODE
    CullMode : D3D11_CULL_MODE
    FrontCounterClockwise : BOOL
    DepthBias : Int32
    DepthBiasClamp : Float32
    SlopeScaledDepthBias : Float32
    DepthClipEnable : BOOL
    ScissorEnable : BOOL
    MultisampleEnable : BOOL
    AntialiasedLineEnable : BOOL
    ForcedSampleCount : UInt32
    ConservativeRaster : D3D11_CONSERVATIVE_RASTERIZATION_MODE
}
struct ID3D11RasterizerState2 extends ID3D11RasterizerState1 {
    static IID := "{6FBD02FB-209F-46C4-B059-2ED15586A6AC}"
    GetDesc2(pDesc)
      => ComCall(9, this.p, D3D11_RASTERIZER_DESC2.Ptr, pDesc, "void")
}
struct D3D11_TEX2D_SRV1 {
    MostDetailedMip : UInt32
    MipLevels : UInt32
    PlaneSlice : UInt32
}
struct D3D11_TEX2D_ARRAY_SRV1 {
    MostDetailedMip : UInt32
    MipLevels : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
    PlaneSlice : UInt32
}
struct D3D11_SHADER_RESOURCE_VIEW_DESC1 {
    Format : DXGI_FORMAT
    ViewDimension : D3D_SRV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Buffer : D3D11_BUFFER_SRV
            Texture1D : D3D11_TEX1D_SRV
            Texture1DArray : D3D11_TEX1D_ARRAY_SRV
            Texture2D : D3D11_TEX2D_SRV1
            Texture2DArray : D3D11_TEX2D_ARRAY_SRV1
            Texture2DMS : D3D11_TEX2DMS_SRV
            Texture2DMSArray : D3D11_TEX2DMS_ARRAY_SRV
            Texture3D : D3D11_TEX3D_SRV
            TextureCube : D3D11_TEXCUBE_SRV
            TextureCubeArray : D3D11_TEXCUBE_ARRAY_SRV
            BufferEx : D3D11_BUFFEREX_SRV
        }
    }
}
struct ID3D11ShaderResourceView1 extends ID3D11ShaderResourceView {
    static IID := "{91308B87-9040-411D-8C67-C39253CE3802}"
    GetDesc1(pDesc1)
      => ComCall(9, this.p, D3D11_SHADER_RESOURCE_VIEW_DESC1.Ptr, pDesc1, "void")
}
struct D3D11_TEX2D_RTV1 {
    MipSlice : UInt32
    PlaneSlice : UInt32
}
struct D3D11_TEX2D_ARRAY_RTV1 {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
    PlaneSlice : UInt32
}
struct D3D11_RENDER_TARGET_VIEW_DESC1 {
    Format : DXGI_FORMAT
    ViewDimension : D3D11_RTV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Buffer : D3D11_BUFFER_RTV
            Texture1D : D3D11_TEX1D_RTV
            Texture1DArray : D3D11_TEX1D_ARRAY_RTV
            Texture2D : D3D11_TEX2D_RTV1
            Texture2DArray : D3D11_TEX2D_ARRAY_RTV1
            Texture2DMS : D3D11_TEX2DMS_RTV
            Texture2DMSArray : D3D11_TEX2DMS_ARRAY_RTV
            Texture3D : D3D11_TEX3D_RTV
        }
    }
}
struct ID3D11RenderTargetView1 extends ID3D11RenderTargetView {
    static IID := "{FFBE2E23-F011-418A-AC56-5CEED7C5B94B}"
    GetDesc1(pDesc1)
      => ComCall(9, this.p, D3D11_RENDER_TARGET_VIEW_DESC1.Ptr, pDesc1, "void")
}
struct D3D11_TEX2D_UAV1 {
    MipSlice : UInt32
    PlaneSlice : UInt32
}
struct D3D11_TEX2D_ARRAY_UAV1 {
    MipSlice : UInt32
    FirstArraySlice : UInt32
    ArraySize : UInt32
    PlaneSlice : UInt32
}
struct D3D11_UNORDERED_ACCESS_VIEW_DESC1 {
    Format : DXGI_FORMAT
    ViewDimension : D3D11_UAV_DIMENSION
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Buffer : D3D11_BUFFER_UAV
            Texture1D : D3D11_TEX1D_UAV
            Texture1DArray : D3D11_TEX1D_ARRAY_UAV
            Texture2D : D3D11_TEX2D_UAV1
            Texture2DArray : D3D11_TEX2D_ARRAY_UAV1
            Texture3D : D3D11_TEX3D_UAV
        }
    }
}
struct ID3D11UnorderedAccessView1 extends ID3D11UnorderedAccessView {
    static IID := "{7B3B6153-A886-4544-AB37-6537C8500403}"
    GetDesc1(pDesc1)
      => ComCall(9, this.p, D3D11_UNORDERED_ACCESS_VIEW_DESC1.Ptr, pDesc1, "void")
}
struct D3D11_QUERY_DESC1 {
    Query : D3D11_QUERY
    MiscFlags : UInt32
    ContextType : D3D11_CONTEXT_TYPE
}
struct ID3D11Query1 extends ID3D11Query {
    static IID := "{631B4766-36DC-461D-8DB6-C47E13E60916}"
    GetDesc1(pDesc1)
      => ComCall(9, this.p, D3D11_QUERY_DESC1.Ptr, pDesc1, "void")
}
struct D3D11_FENCE_FLAG extends Int32 {
    static D3D11_FENCE_FLAG_NONE := 0
    static D3D11_FENCE_FLAG_SHARED := 2
    static D3D11_FENCE_FLAG_SHARED_CROSS_ADAPTER := 4
    static D3D11_FENCE_FLAG_NON_MONITORED := 8
}
struct ID3D11DeviceContext3 extends ID3D11DeviceContext2 {
    static IID := "{B4E3C01D-E79E-4637-91B2-510E9F4C9B8F}"
    Flush1(ContextType, hEvent?)
      => ComCall(144, this.p, D3D11_CONTEXT_TYPE, ContextType, HANDLE, hEvent?, "void")
    SetHardwareProtectionState(HwProtectionEnable)
      => ComCall(145, this.p, BOOL, HwProtectionEnable, "void")
    GetHardwareProtectionState(pHwProtectionEnable)
      => ComCall(146, this.p, BOOL.Ptr, pHwProtectionEnable, "void")
}
struct ID3D11Fence extends ID3D11DeviceChild {
    static IID := "{AFFDE9D1-1DF7-4BB7-8A34-0F46251DAB80}"
    CreateSharedHandle(pAttributes?, dwAccess, lpName?, pHandle)
      => ComCall(7, this.p, SECURITY_ATTRIBUTES.Ptr, pAttributes?, UInt32, dwAccess, "Str", lpName?, HANDLE.Ptr, pHandle)
    GetCompletedValue()
      => ComCall(8, this.p, Int64)
    SetEventOnCompletion(Value, hEvent)
      => ComCall(9, this.p, Int64, Value, HANDLE, hEvent)
}
struct ID3D11DeviceContext4 extends ID3D11DeviceContext3 {
    static IID := "{917600DA-F58C-4C33-98D8-3E15B390FA24}"
    Signal(pFence, Value)
      => ComCall(147, this.p, ID3D11Fence, pFence, Int64, Value)
    Wait(pFence, Value)
      => ComCall(148, this.p, ID3D11Fence, pFence, Int64, Value)
}
struct ID3D11Device3 extends ID3D11Device2 {
    static IID := "{A05C8C37-D2C6-4732-B3A0-9CE0B0DC9AE6}"
    CreateTexture2D1(pDesc1, pInitialData?, ppTexture2D?)
      => ComCall(54, this.p, D3D11_TEXTURE2D_DESC1.Ptr, pDesc1, D3D11_SUBRESOURCE_DATA.Ptr, pInitialData?, ID3D11Texture2D1.Ptr, ppTexture2D?)
    CreateTexture3D1(pDesc1, pInitialData?, ppTexture3D?)
      => ComCall(55, this.p, D3D11_TEXTURE3D_DESC1.Ptr, pDesc1, D3D11_SUBRESOURCE_DATA.Ptr, pInitialData?, ID3D11Texture3D1.Ptr, ppTexture3D?)
    CreateRasterizerState2(pRasterizerDesc, ppRasterizerState?)
      => ComCall(56, this.p, D3D11_RASTERIZER_DESC2.Ptr, pRasterizerDesc, ID3D11RasterizerState2.Ptr, ppRasterizerState?)
    CreateShaderResourceView1(pResource, pDesc1?, ppSRView1?)
      => ComCall(57, this.p, ID3D11Resource, pResource, D3D11_SHADER_RESOURCE_VIEW_DESC1.Ptr, pDesc1?, ID3D11ShaderResourceView1.Ptr, ppSRView1?)
    CreateUnorderedAccessView1(pResource, pDesc1?, ppUAView1?)
      => ComCall(58, this.p, ID3D11Resource, pResource, D3D11_UNORDERED_ACCESS_VIEW_DESC1.Ptr, pDesc1?, ID3D11UnorderedAccessView1.Ptr, ppUAView1?)
    CreateRenderTargetView1(pResource, pDesc1?, ppRTView1?)
      => ComCall(59, this.p, ID3D11Resource, pResource, D3D11_RENDER_TARGET_VIEW_DESC1.Ptr, pDesc1?, ID3D11RenderTargetView1.Ptr, ppRTView1?)
    CreateQuery1(pQueryDesc1, ppQuery1?)
      => ComCall(60, this.p, D3D11_QUERY_DESC1.Ptr, pQueryDesc1, ID3D11Query1.Ptr, ppQuery1?)
    GetImmediateContext3(ppImmediateContext)
      => ComCall(61, this.p, ID3D11DeviceContext3.Ptr, ppImmediateContext, "void")
    CreateDeferredContext3(ContextFlags, ppDeferredContext?)
      => ComCall(62, this.p, UInt32, ContextFlags, ID3D11DeviceContext3.Ptr, ppDeferredContext?)
    WriteToSubresource(pDstResource, DstSubresource, pDstBox?, pSrcData, SrcRowPitch, SrcDepthPitch)
      => ComCall(63, this.p, ID3D11Resource, pDstResource, UInt32, DstSubresource, D3D11_BOX.Ptr, pDstBox?, Struct.Ptr, pSrcData, UInt32, SrcRowPitch, UInt32, SrcDepthPitch, "void")
    ReadFromSubresource(pDstData, DstRowPitch, DstDepthPitch, pSrcResource, SrcSubresource, pSrcBox?)
      => ComCall(64, this.p, Struct.Ptr, pDstData, UInt32, DstRowPitch, UInt32, DstDepthPitch, ID3D11Resource, pSrcResource, UInt32, SrcSubresource, D3D11_BOX.Ptr, pSrcBox?, "void")
}
struct ID3D11Device4 extends ID3D11Device3 {
    static IID := "{8992AB71-02E6-4B8D-BA48-B056DCDA42C4}"
    RegisterDeviceRemovedEvent(hEvent, pdwCookie)
      => ComCall(65, this.p, HANDLE, hEvent, UInt32.Ptr, pdwCookie)
    UnregisterDeviceRemoved(dwCookie)
      => ComCall(66, this.p, UInt32, dwCookie, "void")
}
struct ID3D11Device5 extends ID3D11Device4 {
    static IID := "{8FFDE202-A0E7-45DF-9E01-E837801B5EA0}"
    OpenSharedFence(hFence, ReturnedInterface, ppFence?)
      => ComCall(67, this.p, HANDLE, hFence, GUID.Ptr, ReturnedInterface, Struct.Ptr.Ptr, ppFence?)
    CreateFence(InitialValue, Flags, ReturnedInterface, ppFence?)
      => ComCall(68, this.p, Int64, InitialValue, D3D11_FENCE_FLAG, Flags, GUID.Ptr, ReturnedInterface, Struct.Ptr.Ptr, ppFence?)
}
struct ID3D11Multithread extends IUnknown {
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
struct ID3D11VideoContext2 extends ID3D11VideoContext1 {
    static IID := "{C4E7374C-6243-4D1B-AE87-52B4F740E261}"
    VideoProcessorSetOutputHDRMetaData(pVideoProcessor, Type, pHDRMetaData?)
      => ComCall(79, this.p, ID3D11VideoProcessor, pVideoProcessor, DXGI_HDR_METADATA_TYPE, Type, UInt32, pHDRMetaData?.Size ?? 0, Struct.Ptr, pHDRMetaData?, "void")
    VideoProcessorGetOutputHDRMetaData(pVideoProcessor, pType, pMetaData?)
      => ComCall(80, this.p, ID3D11VideoProcessor, pVideoProcessor, DXGI_HDR_METADATA_TYPE.Ptr, pType, UInt32, pMetaData?.Size ?? 0, Struct.Ptr, pMetaData?, "void")
    VideoProcessorSetStreamHDRMetaData(pVideoProcessor, StreamIndex, Type, pHDRMetaData?)
      => ComCall(81, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, DXGI_HDR_METADATA_TYPE, Type, UInt32, pHDRMetaData?.Size ?? 0, Struct.Ptr, pHDRMetaData?, "void")
    VideoProcessorGetStreamHDRMetaData(pVideoProcessor, StreamIndex, pType, pMetaData?)
      => ComCall(82, this.p, ID3D11VideoProcessor, pVideoProcessor, UInt32, StreamIndex, DXGI_HDR_METADATA_TYPE.Ptr, pType, UInt32, pMetaData?.Size ?? 0, Struct.Ptr, pMetaData?, "void")
}
struct D3D11_FEATURE_VIDEO extends Int32 {
    static D3D11_FEATURE_VIDEO_DECODER_HISTOGRAM := 0
}
struct D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT extends Int32 {
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_Y := 0
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_U := 1
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_V := 2
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_R := 0
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_G := 1
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_B := 2
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_A := 3
}
struct D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAGS extends Int32 {
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_NONE := 0
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_Y := 1
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_U := 2
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_V := 4
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_R := 1
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_G := 2
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_B := 4
    static D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAG_A := 8
}
struct D3D11_FEATURE_DATA_VIDEO_DECODER_HISTOGRAM {
    DecoderDesc : D3D11_VIDEO_DECODER_DESC
    Components : D3D11_VIDEO_DECODER_HISTOGRAM_COMPONENT_FLAGS
    BinCount : UInt32
    CounterBitDepth : UInt32
}
struct D3D11_CRYPTO_SESSION_KEY_EXCHANGE_FLAGS extends Int32 {
    static D3D11_CRYPTO_SESSION_KEY_EXCHANGE_FLAG_NONE := 0
}
struct ID3D11VideoDevice2 extends ID3D11VideoDevice1 {
    static IID := "{59C0CB01-35F0-4A70-8F67-87905C906A53}"
    CheckFeatureSupport(Feature, pFeatureSupportData)
      => ComCall(24, this.p, D3D11_FEATURE_VIDEO, Feature, Struct.Ptr, pFeatureSupportData, UInt32, pFeatureSupportData.Size)
    NegotiateCryptoSessionKeyExchangeMT(pCryptoSession, flags, pData)
      => ComCall(25, this.p, ID3D11CryptoSession, pCryptoSession, D3D11_CRYPTO_SESSION_KEY_EXCHANGE_FLAGS, flags, UInt32, pData.Size, Struct.Ptr, pData)
}
struct D3D11_VIDEO_DECODER_BUFFER_DESC2 {
    BufferType : D3D11_VIDEO_DECODER_BUFFER_TYPE
    DataOffset : UInt32
    DataSize : UInt32
    pIV : Struct.Ptr
    IVSize : UInt32
    pSubSampleMappingBlock : D3D11_VIDEO_DECODER_SUB_SAMPLE_MAPPING_BLOCK.Ptr
    SubSampleMappingCount : UInt32
    cBlocksStripeEncrypted : UInt32
    cBlocksStripeClear : UInt32
}
struct ID3D11VideoContext3 extends ID3D11VideoContext2 {
    static IID := "{A9E2FAA0-CB39-418F-A0B7-D8AAD4DE672E}"
    DecoderBeginFrame1(pDecoder, pView, pContentKey?, pHistogramOffsets?, ppHistogramBuffers?)
      => ComCall(83, this.p, ID3D11VideoDecoder, pDecoder, ID3D11VideoDecoderOutputView, pView, UInt32, pContentKey?.Size ?? 0, Struct.Ptr, pContentKey?, UInt32, ppHistogramBuffers?.Length ?? 0, UInt32.Ptr, pHistogramOffsets?, ID3D11Buffer.Ptr, ppHistogramBuffers?)
    SubmitDecoderBuffers2(pDecoder, pBufferDesc)
      => ComCall(84, this.p, ID3D11VideoDecoder, pDecoder, UInt32, pBufferDesc.Length, D3D11_VIDEO_DECODER_BUFFER_DESC2.Ptr, pBufferDesc)
}
struct D3D11_FEATURE_DATA_D3D11_OPTIONS4 {
    ExtendedNV12SharedTextureSupported : BOOL
}
struct D3D11_SHADER_VERSION_TYPE extends Int32 {
    static D3D11_SHVER_PIXEL_SHADER := 0
    static D3D11_SHVER_VERTEX_SHADER := 1
    static D3D11_SHVER_GEOMETRY_SHADER := 2
    static D3D11_SHVER_HULL_SHADER := 3
    static D3D11_SHVER_DOMAIN_SHADER := 4
    static D3D11_SHVER_COMPUTE_SHADER := 5
    static D3D11_SHVER_RESERVED0 := 65520
}
struct D3D11_SIGNATURE_PARAMETER_DESC {
    SemanticName : PSTR
    SemanticIndex : UInt32
    Register : UInt32
    SystemValueType : D3D_NAME
    ComponentType : D3D_REGISTER_COMPONENT_TYPE
    Mask : UInt8
    ReadWriteMask : UInt8
    Stream : UInt32
    MinPrecision : D3D_MIN_PRECISION
}
struct D3D11_SHADER_BUFFER_DESC {
    Name : PSTR
    Type : D3D_CBUFFER_TYPE
    Variables : UInt32
    Size : UInt32
    uFlags : UInt32
}
struct D3D11_SHADER_VARIABLE_DESC {
    Name : PSTR
    StartOffset : UInt32
    Size : UInt32
    uFlags : UInt32
    DefaultValue : Struct.Ptr
    StartTexture : UInt32
    TextureSize : UInt32
    StartSampler : UInt32
    SamplerSize : UInt32
}
struct D3D11_SHADER_TYPE_DESC {
    Class : D3D_SHADER_VARIABLE_CLASS
    Type : D3D_SHADER_VARIABLE_TYPE
    Rows : UInt32
    Columns : UInt32
    Elements : UInt32
    Members : UInt32
    Offset : UInt32
    Name : PSTR
}
struct D3D11_SHADER_DESC {
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
    InputPrimitive : D3D_PRIMITIVE
    PatchConstantParameters : UInt32
    cGSInstanceCount : UInt32
    cControlPoints : UInt32
    HSOutputPrimitive : D3D_TESSELLATOR_OUTPUT_PRIMITIVE
    HSPartitioning : D3D_TESSELLATOR_PARTITIONING
    TessellatorDomain : D3D_TESSELLATOR_DOMAIN
    cBarrierInstructions : UInt32
    cInterlockedInstructions : UInt32
    cTextureStoreInstructions : UInt32
}
struct D3D11_SHADER_INPUT_BIND_DESC {
    Name : PSTR
    Type : D3D_SHADER_INPUT_TYPE
    BindPoint : UInt32
    BindCount : UInt32
    uFlags : UInt32
    ReturnType : D3D_RESOURCE_RETURN_TYPE
    Dimension : D3D_SRV_DIMENSION
    NumSamples : UInt32
}
struct D3D11_LIBRARY_DESC {
    Creator : PSTR
    Flags : UInt32
    FunctionCount : UInt32
}
struct D3D11_FUNCTION_DESC {
    Version : UInt32
    Creator : PSTR
    Flags : UInt32
    ConstantBuffers : UInt32
    BoundResources : UInt32
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
    MovInstructionCount : UInt32
    MovcInstructionCount : UInt32
    ConversionInstructionCount : UInt32
    BitwiseInstructionCount : UInt32
    MinFeatureLevel : D3D_FEATURE_LEVEL
    RequiredFeatureFlags : Int64
    Name : PSTR
    FunctionParameterCount : Int32
    HasReturn : BOOL
    Has10Level9VertexShader : BOOL
    Has10Level9PixelShader : BOOL
}
struct D3D11_PARAMETER_DESC {
    Name : PSTR
    SemanticName : PSTR
    Type : D3D_SHADER_VARIABLE_TYPE
    Class : D3D_SHADER_VARIABLE_CLASS
    Rows : UInt32
    Columns : UInt32
    InterpolationMode : D3D_INTERPOLATION_MODE
    Flags : D3D_PARAMETER_FLAGS
    FirstInRegister : UInt32
    FirstInComponent : UInt32
    FirstOutRegister : UInt32
    FirstOutComponent : UInt32
}
struct ID3D11ShaderReflectionType extends InterfacePointer {
    static IID := "{6E6FFA6A-9BAE-4613-A51E-91652D508C21}"
    GetDesc(pDesc)
      => ComCall(0, this.p, D3D11_SHADER_TYPE_DESC.Ptr, pDesc)
    GetMemberTypeByIndex(Index)
      => ComCall(1, this.p, UInt32, Index, ID3D11ShaderReflectionType)
    GetMemberTypeByName(Name)
      => ComCall(2, this.p, PSTR, Name, ID3D11ShaderReflectionType)
    GetMemberTypeName(Index)
      => ComCall(3, this.p, UInt32, Index, PSTR)
    IsEqual(pType)
      => ComCall(4, this.p, ID3D11ShaderReflectionType, pType)
    GetSubType()
      => ComCall(5, this.p, ID3D11ShaderReflectionType)
    GetBaseClass()
      => ComCall(6, this.p, ID3D11ShaderReflectionType)
    GetNumInterfaces()
      => ComCall(7, this.p, UInt32)
    GetInterfaceByIndex(uIndex)
      => ComCall(8, this.p, UInt32, uIndex, ID3D11ShaderReflectionType)
    IsOfType(pType)
      => ComCall(9, this.p, ID3D11ShaderReflectionType, pType)
    ImplementsInterface(pBase)
      => ComCall(10, this.p, ID3D11ShaderReflectionType, pBase)
}
struct ID3D11ShaderReflectionVariable extends InterfacePointer {
    static IID := "{51F23923-F3E5-4BD1-91CB-606177D8DB4C}"
    GetDesc(pDesc)
      => ComCall(0, this.p, D3D11_SHADER_VARIABLE_DESC.Ptr, pDesc)
    GetType()
      => ComCall(1, this.p, ID3D11ShaderReflectionType)
    GetBuffer()
      => ComCall(2, this.p, ID3D11ShaderReflectionConstantBuffer)
    GetInterfaceSlot(uArrayIndex)
      => ComCall(3, this.p, UInt32, uArrayIndex, UInt32)
}
struct ID3D11ShaderReflectionConstantBuffer extends InterfacePointer {
    static IID := "{EB62D63D-93DD-4318-8AE8-C6F83AD371B8}"
    GetDesc(pDesc)
      => ComCall(0, this.p, D3D11_SHADER_BUFFER_DESC.Ptr, pDesc)
    GetVariableByIndex(Index)
      => ComCall(1, this.p, UInt32, Index, ID3D11ShaderReflectionVariable)
    GetVariableByName(Name)
      => ComCall(2, this.p, PSTR, Name, ID3D11ShaderReflectionVariable)
}
struct ID3D11ShaderReflection extends IUnknown {
    static IID := "{8D536CA1-0CCA-4956-A837-786963755584}"
    GetDesc(pDesc)
      => ComCall(3, this.p, D3D11_SHADER_DESC.Ptr, pDesc)
    GetConstantBufferByIndex(Index)
      => ComCall(4, this.p, UInt32, Index, ID3D11ShaderReflectionConstantBuffer)
    GetConstantBufferByName(Name)
      => ComCall(5, this.p, PSTR, Name, ID3D11ShaderReflectionConstantBuffer)
    GetResourceBindingDesc(ResourceIndex, pDesc)
      => ComCall(6, this.p, UInt32, ResourceIndex, D3D11_SHADER_INPUT_BIND_DESC.Ptr, pDesc)
    GetInputParameterDesc(ParameterIndex, pDesc)
      => ComCall(7, this.p, UInt32, ParameterIndex, D3D11_SIGNATURE_PARAMETER_DESC.Ptr, pDesc)
    GetOutputParameterDesc(ParameterIndex, pDesc)
      => ComCall(8, this.p, UInt32, ParameterIndex, D3D11_SIGNATURE_PARAMETER_DESC.Ptr, pDesc)
    GetPatchConstantParameterDesc(ParameterIndex, pDesc)
      => ComCall(9, this.p, UInt32, ParameterIndex, D3D11_SIGNATURE_PARAMETER_DESC.Ptr, pDesc)
    GetVariableByName(Name)
      => ComCall(10, this.p, PSTR, Name, ID3D11ShaderReflectionVariable)
    GetResourceBindingDescByName(Name, pDesc)
      => ComCall(11, this.p, PSTR, Name, D3D11_SHADER_INPUT_BIND_DESC.Ptr, pDesc)
    GetMovInstructionCount()
      => ComCall(12, this.p, UInt32)
    GetMovcInstructionCount()
      => ComCall(13, this.p, UInt32)
    GetConversionInstructionCount()
      => ComCall(14, this.p, UInt32)
    GetBitwiseInstructionCount()
      => ComCall(15, this.p, UInt32)
    GetGSInputPrimitive()
      => ComCall(16, this.p, D3D_PRIMITIVE)
    IsSampleFrequencyShader()
      => ComCall(17, this.p, BOOL)
    GetNumInterfaceSlots()
      => ComCall(18, this.p, UInt32)
    GetMinFeatureLevel(pLevel)
      => ComCall(19, this.p, D3D_FEATURE_LEVEL.Ptr, pLevel)
    GetThreadGroupSize(pSizeX?, pSizeY?, pSizeZ?)
      => ComCall(20, this.p, UInt32.Ptr, pSizeX?, UInt32.Ptr, pSizeY?, UInt32.Ptr, pSizeZ?, UInt32)
    GetRequiresFlags()
      => ComCall(21, this.p, Int64)
}
struct ID3D11LibraryReflection extends IUnknown {
    static IID := "{54384F1B-5B3E-4BB7-AE01-60BA3097CBB6}"
    GetDesc(pDesc)
      => ComCall(3, this.p, D3D11_LIBRARY_DESC.Ptr, pDesc)
    GetFunctionByIndex(FunctionIndex)
      => ComCall(4, this.p, Int32, FunctionIndex, ID3D11FunctionReflection)
}
struct ID3D11FunctionReflection extends InterfacePointer {
    static IID := "{207BCECB-D683-4A06-A8A3-9B149B9F73A4}"
    GetDesc(pDesc)
      => ComCall(0, this.p, D3D11_FUNCTION_DESC.Ptr, pDesc)
    GetConstantBufferByIndex(BufferIndex)
      => ComCall(1, this.p, UInt32, BufferIndex, ID3D11ShaderReflectionConstantBuffer)
    GetConstantBufferByName(Name)
      => ComCall(2, this.p, PSTR, Name, ID3D11ShaderReflectionConstantBuffer)
    GetResourceBindingDesc(ResourceIndex, pDesc)
      => ComCall(3, this.p, UInt32, ResourceIndex, D3D11_SHADER_INPUT_BIND_DESC.Ptr, pDesc)
    GetVariableByName(Name)
      => ComCall(4, this.p, PSTR, Name, ID3D11ShaderReflectionVariable)
    GetResourceBindingDescByName(Name, pDesc)
      => ComCall(5, this.p, PSTR, Name, D3D11_SHADER_INPUT_BIND_DESC.Ptr, pDesc)
    GetFunctionParameter(ParameterIndex)
      => ComCall(6, this.p, Int32, ParameterIndex, ID3D11FunctionParameterReflection)
}
struct ID3D11FunctionParameterReflection extends InterfacePointer {
    static IID := "{42757488-334F-47FE-982E-1A65D08CC462}"
    GetDesc(pDesc)
      => ComCall(0, this.p, D3D11_PARAMETER_DESC.Ptr, pDesc)
}
struct ID3D11ModuleInstance extends IUnknown {
    static IID := "{469E07F7-045A-48D5-AA12-68A478CDF75D}"
    BindConstantBuffer(uSrcSlot, uDstSlot, cbDstOffset)
      => ComCall(3, this.p, UInt32, uSrcSlot, UInt32, uDstSlot, UInt32, cbDstOffset)
    BindConstantBufferByName(pName, uDstSlot, cbDstOffset)
      => ComCall(4, this.p, PSTR, pName, UInt32, uDstSlot, UInt32, cbDstOffset)
    BindResource(uSrcSlot, uDstSlot, uCount)
      => ComCall(5, this.p, UInt32, uSrcSlot, UInt32, uDstSlot, UInt32, uCount)
    BindResourceByName(pName, uDstSlot, uCount)
      => ComCall(6, this.p, PSTR, pName, UInt32, uDstSlot, UInt32, uCount)
    BindSampler(uSrcSlot, uDstSlot, uCount)
      => ComCall(7, this.p, UInt32, uSrcSlot, UInt32, uDstSlot, UInt32, uCount)
    BindSamplerByName(pName, uDstSlot, uCount)
      => ComCall(8, this.p, PSTR, pName, UInt32, uDstSlot, UInt32, uCount)
    BindUnorderedAccessView(uSrcSlot, uDstSlot, uCount)
      => ComCall(9, this.p, UInt32, uSrcSlot, UInt32, uDstSlot, UInt32, uCount)
    BindUnorderedAccessViewByName(pName, uDstSlot, uCount)
      => ComCall(10, this.p, PSTR, pName, UInt32, uDstSlot, UInt32, uCount)
    BindResourceAsUnorderedAccessView(uSrcSrvSlot, uDstUavSlot, uCount)
      => ComCall(11, this.p, UInt32, uSrcSrvSlot, UInt32, uDstUavSlot, UInt32, uCount)
    BindResourceAsUnorderedAccessViewByName(pSrvName, uDstUavSlot, uCount)
      => ComCall(12, this.p, PSTR, pSrvName, UInt32, uDstUavSlot, UInt32, uCount)
}
struct ID3D11Module extends IUnknown {
    static IID := "{CAC701EE-80FC-4122-8242-10B39C8CEC34}"
    CreateInstance(pNamespace?, ppModuleInstance)
      => ComCall(3, this.p, PSTR, pNamespace?, ID3D11ModuleInstance.Ptr, ppModuleInstance)
}
struct ID3D11Linker extends IUnknown {
    static IID := "{59A6CD0E-E10D-4C1F-88C0-63ABA1DAF30E}"
    Link(pEntry, pEntryName, pTargetName, uFlags, ppShaderBlob, ppErrorBuffer?)
      => ComCall(3, this.p, ID3D11ModuleInstance, pEntry, PSTR, pEntryName, PSTR, pTargetName, UInt32, uFlags, ID3DBlob.Ptr, ppShaderBlob, ID3DBlob.Ptr, ppErrorBuffer?)
    UseLibrary(pLibraryMI)
      => ComCall(4, this.p, ID3D11ModuleInstance, pLibraryMI)
    AddClipPlaneFromCBuffer(uCBufferSlot, uCBufferEntry)
      => ComCall(5, this.p, UInt32, uCBufferSlot, UInt32, uCBufferEntry)
}
struct ID3D11LinkingNode extends IUnknown {
    static IID := "{D80DD70C-8D2F-4751-94A1-03C79B3556DB}"
}
struct ID3D11FunctionLinkingGraph extends IUnknown {
    static IID := "{54133220-1CE8-43D3-8236-9855C5CEECFF}"
    CreateModuleInstance(ppModuleInstance, ppErrorBuffer?)
      => ComCall(3, this.p, ID3D11ModuleInstance.Ptr, ppModuleInstance, ID3DBlob.Ptr, ppErrorBuffer?)
    SetInputSignature(pInputParameters, ppInputNode)
      => ComCall(4, this.p, D3D11_PARAMETER_DESC.Ptr, pInputParameters, UInt32, pInputParameters.Length, ID3D11LinkingNode.Ptr, ppInputNode)
    SetOutputSignature(pOutputParameters, ppOutputNode)
      => ComCall(5, this.p, D3D11_PARAMETER_DESC.Ptr, pOutputParameters, UInt32, pOutputParameters.Length, ID3D11LinkingNode.Ptr, ppOutputNode)
    CallFunction(pModuleInstanceNamespace?, pModuleWithFunctionPrototype, pFunctionName, ppCallNode)
      => ComCall(6, this.p, PSTR, pModuleInstanceNamespace?, ID3D11Module, pModuleWithFunctionPrototype, PSTR, pFunctionName, ID3D11LinkingNode.Ptr, ppCallNode)
    PassValue(pSrcNode, SrcParameterIndex, pDstNode, DstParameterIndex)
      => ComCall(7, this.p, ID3D11LinkingNode, pSrcNode, Int32, SrcParameterIndex, ID3D11LinkingNode, pDstNode, Int32, DstParameterIndex)
    PassValueWithSwizzle(pSrcNode, SrcParameterIndex, pSrcSwizzle, pDstNode, DstParameterIndex, pDstSwizzle)
      => ComCall(8, this.p, ID3D11LinkingNode, pSrcNode, Int32, SrcParameterIndex, PSTR, pSrcSwizzle, ID3D11LinkingNode, pDstNode, Int32, DstParameterIndex, PSTR, pDstSwizzle)
    GetLastError(ppErrorBuffer?)
      => ComCall(9, this.p, ID3DBlob.Ptr, ppErrorBuffer?)
    GenerateHlsl(uFlags, ppBuffer)
      => ComCall(10, this.p, UInt32, uFlags, ID3DBlob.Ptr, ppBuffer)
}
struct D3D11_SHADER_TYPE extends Int32 {
    static D3D11_VERTEX_SHADER := 1
    static D3D11_HULL_SHADER := 2
    static D3D11_DOMAIN_SHADER := 3
    static D3D11_GEOMETRY_SHADER := 4
    static D3D11_PIXEL_SHADER := 5
    static D3D11_COMPUTE_SHADER := 6
}
struct D3D11_VERTEX_SHADER_TRACE_DESC {
    Invocation : Int64
}
struct D3D11_HULL_SHADER_TRACE_DESC {
    Invocation : Int64
}
struct D3D11_DOMAIN_SHADER_TRACE_DESC {
    Invocation : Int64
}
struct D3D11_GEOMETRY_SHADER_TRACE_DESC {
    Invocation : Int64
}
struct D3D11_PIXEL_SHADER_TRACE_DESC {
    Invocation : Int64
    X : Int32
    Y : Int32
    SampleMask : Int64
}
struct D3D11_COMPUTE_SHADER_TRACE_DESC {
    Invocation : Int64
    ThreadIDInGroup : UInt32[3]
    ThreadGroupID : UInt32[3]
}
struct D3D11_SHADER_TRACE_DESC {
    Type : D3D11_SHADER_TYPE
    Flags : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            VertexShaderTraceDesc : D3D11_VERTEX_SHADER_TRACE_DESC
            HullShaderTraceDesc : D3D11_HULL_SHADER_TRACE_DESC
            DomainShaderTraceDesc : D3D11_DOMAIN_SHADER_TRACE_DESC
            GeometryShaderTraceDesc : D3D11_GEOMETRY_SHADER_TRACE_DESC
            PixelShaderTraceDesc : D3D11_PIXEL_SHADER_TRACE_DESC
            ComputeShaderTraceDesc : D3D11_COMPUTE_SHADER_TRACE_DESC
        }
    }
}
struct D3D11_TRACE_GS_INPUT_PRIMITIVE extends Int32 {
    static D3D11_TRACE_GS_INPUT_PRIMITIVE_UNDEFINED := 0
    static D3D11_TRACE_GS_INPUT_PRIMITIVE_POINT := 1
    static D3D11_TRACE_GS_INPUT_PRIMITIVE_LINE := 2
    static D3D11_TRACE_GS_INPUT_PRIMITIVE_TRIANGLE := 3
    static D3D11_TRACE_GS_INPUT_PRIMITIVE_LINE_ADJ := 6
    static D3D11_TRACE_GS_INPUT_PRIMITIVE_TRIANGLE_ADJ := 7
}
struct D3D11_TRACE_STATS {
    TraceDesc : D3D11_SHADER_TRACE_DESC
    NumInvocationsInStamp : UInt8
    TargetStampIndex : UInt8
    NumTraceSteps : UInt32
    InputMask : UInt8[32]
    OutputMask : UInt8[32]
    NumTemps : UInt16
    MaxIndexableTempIndex : UInt16
    IndexableTempSize : UInt16[4096]
    ImmediateConstantBufferSize : UInt16
    PixelPosition : UInt32[8]
    PixelCoverageMask : Int64[4]
    PixelDiscardedMask : Int64[4]
    PixelCoverageMaskAfterShader : Int64[4]
    PixelCoverageMaskAfterA2CSampleMask : Int64[4]
    PixelCoverageMaskAfterA2CSampleMaskDepth : Int64[4]
    PixelCoverageMaskAfterA2CSampleMaskDepthStencil : Int64[4]
    PSOutputsDepth : BOOL
    PSOutputsMask : BOOL
    GSInputPrimitive : D3D11_TRACE_GS_INPUT_PRIMITIVE
    GSInputsPrimitiveID : BOOL
    HSOutputPatchConstantMask : UInt8[32]
    DSInputPatchConstantMask : UInt8[32]
}
struct D3D11_TRACE_VALUE {
    Bits : UInt32[4]
    ValidMask : UInt8
}
struct D3D11_TRACE_REGISTER_TYPE extends Int32 {
    static D3D11_TRACE_OUTPUT_NULL_REGISTER := 0
    static D3D11_TRACE_INPUT_REGISTER := 1
    static D3D11_TRACE_INPUT_PRIMITIVE_ID_REGISTER := 2
    static D3D11_TRACE_IMMEDIATE_CONSTANT_BUFFER := 3
    static D3D11_TRACE_TEMP_REGISTER := 4
    static D3D11_TRACE_INDEXABLE_TEMP_REGISTER := 5
    static D3D11_TRACE_OUTPUT_REGISTER := 6
    static D3D11_TRACE_OUTPUT_DEPTH_REGISTER := 7
    static D3D11_TRACE_CONSTANT_BUFFER := 8
    static D3D11_TRACE_IMMEDIATE32 := 9
    static D3D11_TRACE_SAMPLER := 10
    static D3D11_TRACE_RESOURCE := 11
    static D3D11_TRACE_RASTERIZER := 12
    static D3D11_TRACE_OUTPUT_COVERAGE_MASK := 13
    static D3D11_TRACE_STREAM := 14
    static D3D11_TRACE_THIS_POINTER := 15
    static D3D11_TRACE_OUTPUT_CONTROL_POINT_ID_REGISTER := 16
    static D3D11_TRACE_INPUT_FORK_INSTANCE_ID_REGISTER := 17
    static D3D11_TRACE_INPUT_JOIN_INSTANCE_ID_REGISTER := 18
    static D3D11_TRACE_INPUT_CONTROL_POINT_REGISTER := 19
    static D3D11_TRACE_OUTPUT_CONTROL_POINT_REGISTER := 20
    static D3D11_TRACE_INPUT_PATCH_CONSTANT_REGISTER := 21
    static D3D11_TRACE_INPUT_DOMAIN_POINT_REGISTER := 22
    static D3D11_TRACE_UNORDERED_ACCESS_VIEW := 23
    static D3D11_TRACE_THREAD_GROUP_SHARED_MEMORY := 24
    static D3D11_TRACE_INPUT_THREAD_ID_REGISTER := 25
    static D3D11_TRACE_INPUT_THREAD_GROUP_ID_REGISTER := 26
    static D3D11_TRACE_INPUT_THREAD_ID_IN_GROUP_REGISTER := 27
    static D3D11_TRACE_INPUT_COVERAGE_MASK_REGISTER := 28
    static D3D11_TRACE_INPUT_THREAD_ID_IN_GROUP_FLATTENED_REGISTER := 29
    static D3D11_TRACE_INPUT_GS_INSTANCE_ID_REGISTER := 30
    static D3D11_TRACE_OUTPUT_DEPTH_GREATER_EQUAL_REGISTER := 31
    static D3D11_TRACE_OUTPUT_DEPTH_LESS_EQUAL_REGISTER := 32
    static D3D11_TRACE_IMMEDIATE64 := 33
    static D3D11_TRACE_INPUT_CYCLE_COUNTER_REGISTER := 34
    static D3D11_TRACE_INTERFACE_POINTER := 35
}
struct D3D11_TRACE_REGISTER {
    RegType : D3D11_TRACE_REGISTER_TYPE
    Anonymous : this._Anonymous_e__Union
    OperandIndex : UInt8
    Flags : UInt8
    struct _Anonymous_e__Union {
        union {
            Index1D : UInt16
            Index2D : UInt16[2]
        }
    }
}
struct D3D11_TRACE_STEP {
    ID : UInt32
    InstructionActive : BOOL
    NumRegistersWritten : UInt8
    NumRegistersRead : UInt8
    MiscOperations : UInt16
    OpcodeType : UInt32
    CurrentGlobalCycle : Int64
}
struct ID3D11ShaderTrace extends IUnknown {
    static IID := "{36B013E6-2811-4845-BAA7-D623FE0DF104}"
    TraceReady(pTestCount?)
      => ComCall(3, this.p, Int64.Ptr, pTestCount?)
    ResetTrace()
      => ComCall(4, this.p, "void")
    GetTraceStats(pTraceStats)
      => ComCall(5, this.p, D3D11_TRACE_STATS.Ptr, pTraceStats)
    PSSelectStamp(stampIndex)
      => ComCall(6, this.p, UInt32, stampIndex)
    GetInitialRegisterContents(pRegister, pValue)
      => ComCall(7, this.p, D3D11_TRACE_REGISTER.Ptr, pRegister, D3D11_TRACE_VALUE.Ptr, pValue)
    GetStep(stepIndex, pTraceStep)
      => ComCall(8, this.p, UInt32, stepIndex, D3D11_TRACE_STEP.Ptr, pTraceStep)
    GetWrittenRegister(stepIndex, writtenRegisterIndex, pRegister, pValue)
      => ComCall(9, this.p, UInt32, stepIndex, UInt32, writtenRegisterIndex, D3D11_TRACE_REGISTER.Ptr, pRegister, D3D11_TRACE_VALUE.Ptr, pValue)
    GetReadRegister(stepIndex, readRegisterIndex, pRegister, pValue)
      => ComCall(10, this.p, UInt32, stepIndex, UInt32, readRegisterIndex, D3D11_TRACE_REGISTER.Ptr, pRegister, D3D11_TRACE_VALUE.Ptr, pValue)
}
struct ID3D11ShaderTraceFactory extends IUnknown {
    static IID := "{1FBAD429-66AB-41CC-9617-667AC10E4459}"
    CreateShaderTrace(pShader, pTraceDesc, ppShaderTrace)
      => ComCall(3, this.p, IUnknown, pShader, D3D11_SHADER_TRACE_DESC.Ptr, pTraceDesc, ID3D11ShaderTrace.Ptr, ppShaderTrace)
}
struct D3DX11_SCAN_DATA_TYPE extends Int32 {
    static D3DX11_SCAN_DATA_TYPE_FLOAT := 1
    static D3DX11_SCAN_DATA_TYPE_INT := 2
    static D3DX11_SCAN_DATA_TYPE_UINT := 3
}
struct D3DX11_SCAN_OPCODE extends Int32 {
    static D3DX11_SCAN_OPCODE_ADD := 1
    static D3DX11_SCAN_OPCODE_MIN := 2
    static D3DX11_SCAN_OPCODE_MAX := 3
    static D3DX11_SCAN_OPCODE_MUL := 4
    static D3DX11_SCAN_OPCODE_AND := 5
    static D3DX11_SCAN_OPCODE_OR := 6
    static D3DX11_SCAN_OPCODE_XOR := 7
}
struct D3DX11_SCAN_DIRECTION extends Int32 {
    static D3DX11_SCAN_DIRECTION_FORWARD := 1
    static D3DX11_SCAN_DIRECTION_BACKWARD := 2
}
struct ID3DX11Scan extends IUnknown {
    static IID := "{5089B68F-E71D-4D38-BE8E-F363B95A9405}"
    SetScanDirection(Direction)
      => ComCall(3, this.p, D3DX11_SCAN_DIRECTION, Direction)
    Scan(ElementType, OpCode, ElementScanSize, pSrc, pDst)
      => ComCall(4, this.p, D3DX11_SCAN_DATA_TYPE, ElementType, D3DX11_SCAN_OPCODE, OpCode, UInt32, ElementScanSize, ID3D11UnorderedAccessView, pSrc, ID3D11UnorderedAccessView, pDst)
    Multiscan(ElementType, OpCode, ElementScanSize, ElementScanPitch, ScanCount, pSrc, pDst)
      => ComCall(5, this.p, D3DX11_SCAN_DATA_TYPE, ElementType, D3DX11_SCAN_OPCODE, OpCode, UInt32, ElementScanSize, UInt32, ElementScanPitch, UInt32, ScanCount, ID3D11UnorderedAccessView, pSrc, ID3D11UnorderedAccessView, pDst)
}
struct ID3DX11SegmentedScan extends IUnknown {
    static IID := "{A915128C-D954-4C79-BFE1-64DB923194D6}"
    SetScanDirection(Direction)
      => ComCall(3, this.p, D3DX11_SCAN_DIRECTION, Direction)
    SegScan(ElementType, OpCode, ElementScanSize, pSrc?, pSrcElementFlags, pDst)
      => ComCall(4, this.p, D3DX11_SCAN_DATA_TYPE, ElementType, D3DX11_SCAN_OPCODE, OpCode, UInt32, ElementScanSize, ID3D11UnorderedAccessView, pSrc?, ID3D11UnorderedAccessView, pSrcElementFlags, ID3D11UnorderedAccessView, pDst)
}
struct ID3DX11FFT extends IUnknown {
    static IID := "{B3F7A938-4C93-4310-A675-B30D6DE50553}"
    SetForwardScale(ForwardScale)
      => ComCall(3, this.p, Float32, ForwardScale)
    GetForwardScale()
      => ComCall(4, this.p, Float32)
    SetInverseScale(InverseScale)
      => ComCall(5, this.p, Float32, InverseScale)
    GetInverseScale()
      => ComCall(6, this.p, Float32)
    AttachBuffersAndPrecompute(ppTempBuffers, ppPrecomputeBufferSizes)
      => ComCall(7, this.p, UInt32, ppTempBuffers.Length, ID3D11UnorderedAccessView.Ptr, ppTempBuffers, UInt32, ppPrecomputeBufferSizes.Length, ID3D11UnorderedAccessView.Ptr, ppPrecomputeBufferSizes)
    ForwardTransform(pInputBuffer, ppOutputBuffer)
      => ComCall(8, this.p, ID3D11UnorderedAccessView, pInputBuffer, ID3D11UnorderedAccessView.Ptr, ppOutputBuffer)
    InverseTransform(pInputBuffer, ppOutputBuffer)
      => ComCall(9, this.p, ID3D11UnorderedAccessView, pInputBuffer, ID3D11UnorderedAccessView.Ptr, ppOutputBuffer)
}
struct D3DX11_FFT_DATA_TYPE extends Int32 {
    static D3DX11_FFT_DATA_TYPE_REAL := 0
    static D3DX11_FFT_DATA_TYPE_COMPLEX := 1
}
struct D3DX11_FFT_DIM_MASK extends Int32 {
    static D3DX11_FFT_DIM_MASK_1D := 1
    static D3DX11_FFT_DIM_MASK_2D := 3
    static D3DX11_FFT_DIM_MASK_3D := 7
}
struct D3DX11_FFT_DESC {
    NumDimensions : UInt32
    ElementLengths : UInt32[32]
    DimensionMask : UInt32
    Type : D3DX11_FFT_DATA_TYPE
}
struct D3DX11_FFT_BUFFER_INFO {
    NumTempBufferSizes : UInt32
    TempBufferFloatSizes : UInt32[4]
    NumPrecomputeBufferSizes : UInt32
    PrecomputeBufferFloatSizes : UInt32[4]
}
struct D3DX11_FFT_CREATE_FLAG extends Int32 {
    static D3DX11_FFT_CREATE_FLAG_NO_PRECOMPUTE_BUFFERS := 1
}
