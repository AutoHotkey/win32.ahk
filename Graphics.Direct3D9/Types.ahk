#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, CHAR, HANDLE, HRESULT, HWND, LUID, POINT, PSTR, RECT}
#Import "..\Graphics.Direct3D\Types.ahk" {D3DMATRIX, D3DVECTOR}
#Import "..\Graphics.DirectDraw\Types.ahk" {DDPIXELFORMAT, DDSURFACEDESC}
#Import "..\Graphics.Gdi\Types.ahk" {HDC, HMONITOR, PALETTEENTRY, RGNDATA}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct D3DADAPTER_IDENTIFIER9 {
    Driver : CHAR[512]
    Description : CHAR[512]
    DeviceName : CHAR[32]
    DriverVersion : Int64
    VendorId : UInt32
    DeviceId : UInt32
    SubSysId : UInt32
    Revision : UInt32
    DeviceIdentifier : GUID
    WHQLLevel : UInt32
}
struct D3DMEMORYPRESSURE {
    BytesEvictedFromProcess : Int64
    SizeOfInefficientAllocation : Int64
    LevelOfEfficiency : UInt32
}
struct D3DPRESENTSTATS {
    PresentCount : UInt32
    PresentRefreshCount : UInt32
    SyncRefreshCount : UInt32
    SyncQPCTime : Int64
    SyncGPUTime : Int64
}
struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTID_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    DeviceHandle : HANDLE
    CryptoSessionHandle : HANDLE
    OutputIDIndex : UInt32
    OutputID : Int64
}
struct D3DAES_CTR_IV {
    IV : Int64
    Count : Int64
}
struct D3DCOLORVALUE {
    r : Float32
    g : Float32
    b : Float32
    a : Float32
}
struct D3DRECT {
    x1 : Int32
    y1 : Int32
    x2 : Int32
    y2 : Int32
}
struct D3DVIEWPORT9 {
    X : UInt32
    Y : UInt32
    Width : UInt32
    Height : UInt32
    MinZ : Float32
    MaxZ : Float32
}
struct D3DCLIPSTATUS9 {
    ClipUnion : UInt32
    ClipIntersection : UInt32
}
struct D3DMATERIAL9 {
    Diffuse : D3DCOLORVALUE
    Ambient : D3DCOLORVALUE
    Specular : D3DCOLORVALUE
    Emissive : D3DCOLORVALUE
    Power : Float32
}
struct D3DLIGHTTYPE extends Int32 {
    static D3DLIGHT_POINT := 1
    static D3DLIGHT_SPOT := 2
    static D3DLIGHT_DIRECTIONAL := 3
}
struct D3DLIGHT9 {
    Type : D3DLIGHTTYPE
    Diffuse : D3DCOLORVALUE
    Specular : D3DCOLORVALUE
    Ambient : D3DCOLORVALUE
    Position : D3DVECTOR
    Direction : D3DVECTOR
    Range : Float32
    Falloff : Float32
    Attenuation0 : Float32
    Attenuation1 : Float32
    Attenuation2 : Float32
    Theta : Float32
    Phi : Float32
}
struct D3DSHADEMODE extends Int32 {
    static D3DSHADE_FLAT := 1
    static D3DSHADE_GOURAUD := 2
    static D3DSHADE_PHONG := 3
}
struct D3DFILLMODE extends Int32 {
    static D3DFILL_POINT := 1
    static D3DFILL_WIREFRAME := 2
    static D3DFILL_SOLID := 3
}
struct D3DBLEND extends Int32 {
    static D3DBLEND_ZERO := 1
    static D3DBLEND_ONE := 2
    static D3DBLEND_SRCCOLOR := 3
    static D3DBLEND_INVSRCCOLOR := 4
    static D3DBLEND_SRCALPHA := 5
    static D3DBLEND_INVSRCALPHA := 6
    static D3DBLEND_DESTALPHA := 7
    static D3DBLEND_INVDESTALPHA := 8
    static D3DBLEND_DESTCOLOR := 9
    static D3DBLEND_INVDESTCOLOR := 10
    static D3DBLEND_SRCALPHASAT := 11
    static D3DBLEND_BOTHSRCALPHA := 12
    static D3DBLEND_BOTHINVSRCALPHA := 13
    static D3DBLEND_BLENDFACTOR := 14
    static D3DBLEND_INVBLENDFACTOR := 15
    static D3DBLEND_SRCCOLOR2 := 16
    static D3DBLEND_INVSRCCOLOR2 := 17
}
struct D3DBLENDOP extends Int32 {
    static D3DBLENDOP_ADD := 1
    static D3DBLENDOP_SUBTRACT := 2
    static D3DBLENDOP_REVSUBTRACT := 3
    static D3DBLENDOP_MIN := 4
    static D3DBLENDOP_MAX := 5
}
struct D3DTEXTUREADDRESS extends Int32 {
    static D3DTADDRESS_WRAP := 1
    static D3DTADDRESS_MIRROR := 2
    static D3DTADDRESS_CLAMP := 3
    static D3DTADDRESS_BORDER := 4
    static D3DTADDRESS_MIRRORONCE := 5
}
struct D3DCULL extends Int32 {
    static D3DCULL_NONE := 1
    static D3DCULL_CW := 2
    static D3DCULL_CCW := 3
}
struct D3DCMPFUNC extends Int32 {
    static D3DCMP_NEVER := 1
    static D3DCMP_LESS := 2
    static D3DCMP_EQUAL := 3
    static D3DCMP_LESSEQUAL := 4
    static D3DCMP_GREATER := 5
    static D3DCMP_NOTEQUAL := 6
    static D3DCMP_GREATEREQUAL := 7
    static D3DCMP_ALWAYS := 8
}
struct D3DSTENCILOP extends Int32 {
    static D3DSTENCILOP_KEEP := 1
    static D3DSTENCILOP_ZERO := 2
    static D3DSTENCILOP_REPLACE := 3
    static D3DSTENCILOP_INCRSAT := 4
    static D3DSTENCILOP_DECRSAT := 5
    static D3DSTENCILOP_INVERT := 6
    static D3DSTENCILOP_INCR := 7
    static D3DSTENCILOP_DECR := 8
}
struct D3DFOGMODE extends Int32 {
    static D3DFOG_NONE := 0
    static D3DFOG_EXP := 1
    static D3DFOG_EXP2 := 2
    static D3DFOG_LINEAR := 3
}
struct D3DZBUFFERTYPE extends Int32 {
    static D3DZB_FALSE := 0
    static D3DZB_TRUE := 1
    static D3DZB_USEW := 2
}
struct D3DPRIMITIVETYPE extends Int32 {
    static D3DPT_POINTLIST := 1
    static D3DPT_LINELIST := 2
    static D3DPT_LINESTRIP := 3
    static D3DPT_TRIANGLELIST := 4
    static D3DPT_TRIANGLESTRIP := 5
    static D3DPT_TRIANGLEFAN := 6
}
struct D3DTRANSFORMSTATETYPE extends Int32 {
    static D3DTS_VIEW := 2
    static D3DTS_PROJECTION := 3
    static D3DTS_TEXTURE0 := 16
    static D3DTS_TEXTURE1 := 17
    static D3DTS_TEXTURE2 := 18
    static D3DTS_TEXTURE3 := 19
    static D3DTS_TEXTURE4 := 20
    static D3DTS_TEXTURE5 := 21
    static D3DTS_TEXTURE6 := 22
    static D3DTS_TEXTURE7 := 23
}
struct D3DRENDERSTATETYPE extends Int32 {
    static D3DRS_ZENABLE := 7
    static D3DRS_FILLMODE := 8
    static D3DRS_SHADEMODE := 9
    static D3DRS_ZWRITEENABLE := 14
    static D3DRS_ALPHATESTENABLE := 15
    static D3DRS_LASTPIXEL := 16
    static D3DRS_SRCBLEND := 19
    static D3DRS_DESTBLEND := 20
    static D3DRS_CULLMODE := 22
    static D3DRS_ZFUNC := 23
    static D3DRS_ALPHAREF := 24
    static D3DRS_ALPHAFUNC := 25
    static D3DRS_DITHERENABLE := 26
    static D3DRS_ALPHABLENDENABLE := 27
    static D3DRS_FOGENABLE := 28
    static D3DRS_SPECULARENABLE := 29
    static D3DRS_FOGCOLOR := 34
    static D3DRS_FOGTABLEMODE := 35
    static D3DRS_FOGSTART := 36
    static D3DRS_FOGEND := 37
    static D3DRS_FOGDENSITY := 38
    static D3DRS_RANGEFOGENABLE := 48
    static D3DRS_STENCILENABLE := 52
    static D3DRS_STENCILFAIL := 53
    static D3DRS_STENCILZFAIL := 54
    static D3DRS_STENCILPASS := 55
    static D3DRS_STENCILFUNC := 56
    static D3DRS_STENCILREF := 57
    static D3DRS_STENCILMASK := 58
    static D3DRS_STENCILWRITEMASK := 59
    static D3DRS_TEXTUREFACTOR := 60
    static D3DRS_WRAP0 := 128
    static D3DRS_WRAP1 := 129
    static D3DRS_WRAP2 := 130
    static D3DRS_WRAP3 := 131
    static D3DRS_WRAP4 := 132
    static D3DRS_WRAP5 := 133
    static D3DRS_WRAP6 := 134
    static D3DRS_WRAP7 := 135
    static D3DRS_CLIPPING := 136
    static D3DRS_LIGHTING := 137
    static D3DRS_AMBIENT := 139
    static D3DRS_FOGVERTEXMODE := 140
    static D3DRS_COLORVERTEX := 141
    static D3DRS_LOCALVIEWER := 142
    static D3DRS_NORMALIZENORMALS := 143
    static D3DRS_DIFFUSEMATERIALSOURCE := 145
    static D3DRS_SPECULARMATERIALSOURCE := 146
    static D3DRS_AMBIENTMATERIALSOURCE := 147
    static D3DRS_EMISSIVEMATERIALSOURCE := 148
    static D3DRS_VERTEXBLEND := 151
    static D3DRS_CLIPPLANEENABLE := 152
    static D3DRS_POINTSIZE := 154
    static D3DRS_POINTSIZE_MIN := 155
    static D3DRS_POINTSPRITEENABLE := 156
    static D3DRS_POINTSCALEENABLE := 157
    static D3DRS_POINTSCALE_A := 158
    static D3DRS_POINTSCALE_B := 159
    static D3DRS_POINTSCALE_C := 160
    static D3DRS_MULTISAMPLEANTIALIAS := 161
    static D3DRS_MULTISAMPLEMASK := 162
    static D3DRS_PATCHEDGESTYLE := 163
    static D3DRS_DEBUGMONITORTOKEN := 165
    static D3DRS_POINTSIZE_MAX := 166
    static D3DRS_INDEXEDVERTEXBLENDENABLE := 167
    static D3DRS_COLORWRITEENABLE := 168
    static D3DRS_TWEENFACTOR := 170
    static D3DRS_BLENDOP := 171
    static D3DRS_POSITIONDEGREE := 172
    static D3DRS_NORMALDEGREE := 173
    static D3DRS_SCISSORTESTENABLE := 174
    static D3DRS_SLOPESCALEDEPTHBIAS := 175
    static D3DRS_ANTIALIASEDLINEENABLE := 176
    static D3DRS_MINTESSELLATIONLEVEL := 178
    static D3DRS_MAXTESSELLATIONLEVEL := 179
    static D3DRS_ADAPTIVETESS_X := 180
    static D3DRS_ADAPTIVETESS_Y := 181
    static D3DRS_ADAPTIVETESS_Z := 182
    static D3DRS_ADAPTIVETESS_W := 183
    static D3DRS_ENABLEADAPTIVETESSELLATION := 184
    static D3DRS_TWOSIDEDSTENCILMODE := 185
    static D3DRS_CCW_STENCILFAIL := 186
    static D3DRS_CCW_STENCILZFAIL := 187
    static D3DRS_CCW_STENCILPASS := 188
    static D3DRS_CCW_STENCILFUNC := 189
    static D3DRS_COLORWRITEENABLE1 := 190
    static D3DRS_COLORWRITEENABLE2 := 191
    static D3DRS_COLORWRITEENABLE3 := 192
    static D3DRS_BLENDFACTOR := 193
    static D3DRS_SRGBWRITEENABLE := 194
    static D3DRS_DEPTHBIAS := 195
    static D3DRS_WRAP8 := 198
    static D3DRS_WRAP9 := 199
    static D3DRS_WRAP10 := 200
    static D3DRS_WRAP11 := 201
    static D3DRS_WRAP12 := 202
    static D3DRS_WRAP13 := 203
    static D3DRS_WRAP14 := 204
    static D3DRS_WRAP15 := 205
    static D3DRS_SEPARATEALPHABLENDENABLE := 206
    static D3DRS_SRCBLENDALPHA := 207
    static D3DRS_DESTBLENDALPHA := 208
    static D3DRS_BLENDOPALPHA := 209
}
struct D3DMATERIALCOLORSOURCE extends Int32 {
    static D3DMCS_MATERIAL := 0
    static D3DMCS_COLOR1 := 1
    static D3DMCS_COLOR2 := 2
}
struct D3DTEXTURESTAGESTATETYPE extends Int32 {
    static D3DTSS_COLOROP := 1
    static D3DTSS_COLORARG1 := 2
    static D3DTSS_COLORARG2 := 3
    static D3DTSS_ALPHAOP := 4
    static D3DTSS_ALPHAARG1 := 5
    static D3DTSS_ALPHAARG2 := 6
    static D3DTSS_BUMPENVMAT00 := 7
    static D3DTSS_BUMPENVMAT01 := 8
    static D3DTSS_BUMPENVMAT10 := 9
    static D3DTSS_BUMPENVMAT11 := 10
    static D3DTSS_TEXCOORDINDEX := 11
    static D3DTSS_BUMPENVLSCALE := 22
    static D3DTSS_BUMPENVLOFFSET := 23
    static D3DTSS_TEXTURETRANSFORMFLAGS := 24
    static D3DTSS_COLORARG0 := 26
    static D3DTSS_ALPHAARG0 := 27
    static D3DTSS_RESULTARG := 28
    static D3DTSS_CONSTANT := 32
}
struct D3DSAMPLERSTATETYPE extends Int32 {
    static D3DSAMP_ADDRESSU := 1
    static D3DSAMP_ADDRESSV := 2
    static D3DSAMP_ADDRESSW := 3
    static D3DSAMP_BORDERCOLOR := 4
    static D3DSAMP_MAGFILTER := 5
    static D3DSAMP_MINFILTER := 6
    static D3DSAMP_MIPFILTER := 7
    static D3DSAMP_MIPMAPLODBIAS := 8
    static D3DSAMP_MAXMIPLEVEL := 9
    static D3DSAMP_MAXANISOTROPY := 10
    static D3DSAMP_SRGBTEXTURE := 11
    static D3DSAMP_ELEMENTINDEX := 12
    static D3DSAMP_DMAPOFFSET := 13
}
struct D3DTEXTUREOP extends Int32 {
    static D3DTOP_DISABLE := 1
    static D3DTOP_SELECTARG1 := 2
    static D3DTOP_SELECTARG2 := 3
    static D3DTOP_MODULATE := 4
    static D3DTOP_MODULATE2X := 5
    static D3DTOP_MODULATE4X := 6
    static D3DTOP_ADD := 7
    static D3DTOP_ADDSIGNED := 8
    static D3DTOP_ADDSIGNED2X := 9
    static D3DTOP_SUBTRACT := 10
    static D3DTOP_ADDSMOOTH := 11
    static D3DTOP_BLENDDIFFUSEALPHA := 12
    static D3DTOP_BLENDTEXTUREALPHA := 13
    static D3DTOP_BLENDFACTORALPHA := 14
    static D3DTOP_BLENDTEXTUREALPHAPM := 15
    static D3DTOP_BLENDCURRENTALPHA := 16
    static D3DTOP_PREMODULATE := 17
    static D3DTOP_MODULATEALPHA_ADDCOLOR := 18
    static D3DTOP_MODULATECOLOR_ADDALPHA := 19
    static D3DTOP_MODULATEINVALPHA_ADDCOLOR := 20
    static D3DTOP_MODULATEINVCOLOR_ADDALPHA := 21
    static D3DTOP_BUMPENVMAP := 22
    static D3DTOP_BUMPENVMAPLUMINANCE := 23
    static D3DTOP_DOTPRODUCT3 := 24
    static D3DTOP_MULTIPLYADD := 25
    static D3DTOP_LERP := 26
}
struct D3DTEXTUREFILTERTYPE extends Int32 {
    static D3DTEXF_NONE := 0
    static D3DTEXF_POINT := 1
    static D3DTEXF_LINEAR := 2
    static D3DTEXF_ANISOTROPIC := 3
    static D3DTEXF_PYRAMIDALQUAD := 6
    static D3DTEXF_GAUSSIANQUAD := 7
    static D3DTEXF_CONVOLUTIONMONO := 8
}
struct D3DDECLUSAGE extends Int32 {
    static D3DDECLUSAGE_POSITION := 0
    static D3DDECLUSAGE_BLENDWEIGHT := 1
    static D3DDECLUSAGE_BLENDINDICES := 2
    static D3DDECLUSAGE_NORMAL := 3
    static D3DDECLUSAGE_PSIZE := 4
    static D3DDECLUSAGE_TEXCOORD := 5
    static D3DDECLUSAGE_TANGENT := 6
    static D3DDECLUSAGE_BINORMAL := 7
    static D3DDECLUSAGE_TESSFACTOR := 8
    static D3DDECLUSAGE_POSITIONT := 9
    static D3DDECLUSAGE_COLOR := 10
    static D3DDECLUSAGE_FOG := 11
    static D3DDECLUSAGE_DEPTH := 12
    static D3DDECLUSAGE_SAMPLE := 13
}
struct D3DDECLMETHOD extends Int32 {
    static D3DDECLMETHOD_DEFAULT := 0
    static D3DDECLMETHOD_PARTIALU := 1
    static D3DDECLMETHOD_PARTIALV := 2
    static D3DDECLMETHOD_CROSSUV := 3
    static D3DDECLMETHOD_UV := 4
    static D3DDECLMETHOD_LOOKUP := 5
    static D3DDECLMETHOD_LOOKUPPRESAMPLED := 6
}
struct D3DDECLTYPE extends Int32 {
    static D3DDECLTYPE_FLOAT1 := 0
    static D3DDECLTYPE_FLOAT2 := 1
    static D3DDECLTYPE_FLOAT3 := 2
    static D3DDECLTYPE_FLOAT4 := 3
    static D3DDECLTYPE_D3DCOLOR := 4
    static D3DDECLTYPE_UBYTE4 := 5
    static D3DDECLTYPE_SHORT2 := 6
    static D3DDECLTYPE_SHORT4 := 7
    static D3DDECLTYPE_UBYTE4N := 8
    static D3DDECLTYPE_SHORT2N := 9
    static D3DDECLTYPE_SHORT4N := 10
    static D3DDECLTYPE_USHORT2N := 11
    static D3DDECLTYPE_USHORT4N := 12
    static D3DDECLTYPE_UDEC3 := 13
    static D3DDECLTYPE_DEC3N := 14
    static D3DDECLTYPE_FLOAT16_2 := 15
    static D3DDECLTYPE_FLOAT16_4 := 16
    static D3DDECLTYPE_UNUSED := 17
}
struct D3DVERTEXELEMENT9 {
    Stream : UInt16
    Offset : UInt16
    Type : UInt8
    Method : UInt8
    Usage : UInt8
    UsageIndex : UInt8
}
struct D3DSHADER_INSTRUCTION_OPCODE_TYPE extends Int32 {
    static D3DSIO_NOP := 0
    static D3DSIO_MOV := 1
    static D3DSIO_ADD := 2
    static D3DSIO_SUB := 3
    static D3DSIO_MAD := 4
    static D3DSIO_MUL := 5
    static D3DSIO_RCP := 6
    static D3DSIO_RSQ := 7
    static D3DSIO_DP3 := 8
    static D3DSIO_DP4 := 9
    static D3DSIO_MIN := 10
    static D3DSIO_MAX := 11
    static D3DSIO_SLT := 12
    static D3DSIO_SGE := 13
    static D3DSIO_EXP := 14
    static D3DSIO_LOG := 15
    static D3DSIO_LIT := 16
    static D3DSIO_DST := 17
    static D3DSIO_LRP := 18
    static D3DSIO_FRC := 19
    static D3DSIO_M4x4 := 20
    static D3DSIO_M4x3 := 21
    static D3DSIO_M3x4 := 22
    static D3DSIO_M3x3 := 23
    static D3DSIO_M3x2 := 24
    static D3DSIO_CALL := 25
    static D3DSIO_CALLNZ := 26
    static D3DSIO_LOOP := 27
    static D3DSIO_RET := 28
    static D3DSIO_ENDLOOP := 29
    static D3DSIO_LABEL := 30
    static D3DSIO_DCL := 31
    static D3DSIO_POW := 32
    static D3DSIO_CRS := 33
    static D3DSIO_SGN := 34
    static D3DSIO_ABS := 35
    static D3DSIO_NRM := 36
    static D3DSIO_SINCOS := 37
    static D3DSIO_REP := 38
    static D3DSIO_ENDREP := 39
    static D3DSIO_IF := 40
    static D3DSIO_IFC := 41
    static D3DSIO_ELSE := 42
    static D3DSIO_ENDIF := 43
    static D3DSIO_BREAK := 44
    static D3DSIO_BREAKC := 45
    static D3DSIO_MOVA := 46
    static D3DSIO_DEFB := 47
    static D3DSIO_DEFI := 48
    static D3DSIO_TEXCOORD := 64
    static D3DSIO_TEXKILL := 65
    static D3DSIO_TEX := 66
    static D3DSIO_TEXBEM := 67
    static D3DSIO_TEXBEML := 68
    static D3DSIO_TEXREG2AR := 69
    static D3DSIO_TEXREG2GB := 70
    static D3DSIO_TEXM3x2PAD := 71
    static D3DSIO_TEXM3x2TEX := 72
    static D3DSIO_TEXM3x3PAD := 73
    static D3DSIO_TEXM3x3TEX := 74
    static D3DSIO_RESERVED0 := 75
    static D3DSIO_TEXM3x3SPEC := 76
    static D3DSIO_TEXM3x3VSPEC := 77
    static D3DSIO_EXPP := 78
    static D3DSIO_LOGP := 79
    static D3DSIO_CND := 80
    static D3DSIO_DEF := 81
    static D3DSIO_TEXREG2RGB := 82
    static D3DSIO_TEXDP3TEX := 83
    static D3DSIO_TEXM3x2DEPTH := 84
    static D3DSIO_TEXDP3 := 85
    static D3DSIO_TEXM3x3 := 86
    static D3DSIO_TEXDEPTH := 87
    static D3DSIO_CMP := 88
    static D3DSIO_BEM := 89
    static D3DSIO_DP2ADD := 90
    static D3DSIO_DSX := 91
    static D3DSIO_DSY := 92
    static D3DSIO_TEXLDD := 93
    static D3DSIO_SETP := 94
    static D3DSIO_TEXLDL := 95
    static D3DSIO_BREAKP := 96
    static D3DSIO_PHASE := 65533
    static D3DSIO_COMMENT := 65534
    static D3DSIO_END := 65535
}
struct D3DSHADER_COMPARISON extends Int32 {
    static D3DSPC_RESERVED0 := 0
    static D3DSPC_GT := 1
    static D3DSPC_EQ := 2
    static D3DSPC_GE := 3
    static D3DSPC_LT := 4
    static D3DSPC_NE := 5
    static D3DSPC_LE := 6
    static D3DSPC_RESERVED1 := 7
}
struct D3DSAMPLER_TEXTURE_TYPE extends Int32 {
    static D3DSTT_UNKNOWN := 0
    static D3DSTT_2D := 268435456
    static D3DSTT_CUBE := 402653184
    static D3DSTT_VOLUME := 536870912
}
struct D3DSHADER_PARAM_REGISTER_TYPE extends Int32 {
    static D3DSPR_TEMP := 0
    static D3DSPR_INPUT := 1
    static D3DSPR_CONST := 2
    static D3DSPR_ADDR := 3
    static D3DSPR_TEXTURE := 3
    static D3DSPR_RASTOUT := 4
    static D3DSPR_ATTROUT := 5
    static D3DSPR_TEXCRDOUT := 6
    static D3DSPR_OUTPUT := 6
    static D3DSPR_CONSTINT := 7
    static D3DSPR_COLOROUT := 8
    static D3DSPR_DEPTHOUT := 9
    static D3DSPR_SAMPLER := 10
    static D3DSPR_CONST2 := 11
    static D3DSPR_CONST3 := 12
    static D3DSPR_CONST4 := 13
    static D3DSPR_CONSTBOOL := 14
    static D3DSPR_LOOP := 15
    static D3DSPR_TEMPFLOAT16 := 16
    static D3DSPR_MISCTYPE := 17
    static D3DSPR_LABEL := 18
    static D3DSPR_PREDICATE := 19
}
struct D3DSHADER_MISCTYPE_OFFSETS extends Int32 {
    static D3DSMO_POSITION := 0
    static D3DSMO_FACE := 1
}
struct D3DVS_RASTOUT_OFFSETS extends Int32 {
    static D3DSRO_POSITION := 0
    static D3DSRO_FOG := 1
    static D3DSRO_POINT_SIZE := 2
}
struct D3DVS_ADDRESSMODE_TYPE extends Int32 {
    static D3DVS_ADDRMODE_ABSOLUTE := 0
    static D3DVS_ADDRMODE_RELATIVE := 8192
}
struct D3DSHADER_ADDRESSMODE_TYPE extends Int32 {
    static D3DSHADER_ADDRMODE_ABSOLUTE := 0
    static D3DSHADER_ADDRMODE_RELATIVE := 8192
}
struct D3DSHADER_PARAM_SRCMOD_TYPE extends Int32 {
    static D3DSPSM_NONE := 0
    static D3DSPSM_NEG := 16777216
    static D3DSPSM_BIAS := 33554432
    static D3DSPSM_BIASNEG := 50331648
    static D3DSPSM_SIGN := 67108864
    static D3DSPSM_SIGNNEG := 83886080
    static D3DSPSM_COMP := 100663296
    static D3DSPSM_X2 := 117440512
    static D3DSPSM_X2NEG := 134217728
    static D3DSPSM_DZ := 150994944
    static D3DSPSM_DW := 167772160
    static D3DSPSM_ABS := 184549376
    static D3DSPSM_ABSNEG := 201326592
    static D3DSPSM_NOT := 218103808
}
struct D3DSHADER_MIN_PRECISION extends Int32 {
    static D3DMP_DEFAULT := 0
    static D3DMP_16 := 1
    static D3DMP_2_8 := 2
}
struct D3DBASISTYPE extends Int32 {
    static D3DBASIS_BEZIER := 0
    static D3DBASIS_BSPLINE := 1
    static D3DBASIS_CATMULL_ROM := 2
}
struct D3DDEGREETYPE extends Int32 {
    static D3DDEGREE_LINEAR := 1
    static D3DDEGREE_QUADRATIC := 2
    static D3DDEGREE_CUBIC := 3
    static D3DDEGREE_QUINTIC := 5
}
struct D3DPATCHEDGESTYLE extends Int32 {
    static D3DPATCHEDGE_DISCRETE := 0
    static D3DPATCHEDGE_CONTINUOUS := 1
}
struct D3DSTATEBLOCKTYPE extends Int32 {
    static D3DSBT_ALL := 1
    static D3DSBT_PIXELSTATE := 2
    static D3DSBT_VERTEXSTATE := 3
}
struct D3DVERTEXBLENDFLAGS extends Int32 {
    static D3DVBF_DISABLE := 0
    static D3DVBF_1WEIGHTS := 1
    static D3DVBF_2WEIGHTS := 2
    static D3DVBF_3WEIGHTS := 3
    static D3DVBF_TWEENING := 255
    static D3DVBF_0WEIGHTS := 256
}
struct D3DTEXTURETRANSFORMFLAGS extends Int32 {
    static D3DTTFF_DISABLE := 0
    static D3DTTFF_COUNT1 := 1
    static D3DTTFF_COUNT2 := 2
    static D3DTTFF_COUNT3 := 3
    static D3DTTFF_COUNT4 := 4
    static D3DTTFF_PROJECTED := 256
}
struct D3DDEVTYPE extends Int32 {
    static D3DDEVTYPE_HAL := 1
    static D3DDEVTYPE_REF := 2
    static D3DDEVTYPE_SW := 3
    static D3DDEVTYPE_NULLREF := 4
}
struct D3DMULTISAMPLE_TYPE extends Int32 {
    static D3DMULTISAMPLE_NONE := 0
    static D3DMULTISAMPLE_NONMASKABLE := 1
    static D3DMULTISAMPLE_2_SAMPLES := 2
    static D3DMULTISAMPLE_3_SAMPLES := 3
    static D3DMULTISAMPLE_4_SAMPLES := 4
    static D3DMULTISAMPLE_5_SAMPLES := 5
    static D3DMULTISAMPLE_6_SAMPLES := 6
    static D3DMULTISAMPLE_7_SAMPLES := 7
    static D3DMULTISAMPLE_8_SAMPLES := 8
    static D3DMULTISAMPLE_9_SAMPLES := 9
    static D3DMULTISAMPLE_10_SAMPLES := 10
    static D3DMULTISAMPLE_11_SAMPLES := 11
    static D3DMULTISAMPLE_12_SAMPLES := 12
    static D3DMULTISAMPLE_13_SAMPLES := 13
    static D3DMULTISAMPLE_14_SAMPLES := 14
    static D3DMULTISAMPLE_15_SAMPLES := 15
    static D3DMULTISAMPLE_16_SAMPLES := 16
}
struct D3DFORMAT extends UInt32 {
    static D3DFMT_UNKNOWN := 0
    static D3DFMT_R8G8B8 := 20
    static D3DFMT_A8R8G8B8 := 21
    static D3DFMT_X8R8G8B8 := 22
    static D3DFMT_R5G6B5 := 23
    static D3DFMT_X1R5G5B5 := 24
    static D3DFMT_A1R5G5B5 := 25
    static D3DFMT_A4R4G4B4 := 26
    static D3DFMT_R3G3B2 := 27
    static D3DFMT_A8 := 28
    static D3DFMT_A8R3G3B2 := 29
    static D3DFMT_X4R4G4B4 := 30
    static D3DFMT_A2B10G10R10 := 31
    static D3DFMT_A8B8G8R8 := 32
    static D3DFMT_X8B8G8R8 := 33
    static D3DFMT_G16R16 := 34
    static D3DFMT_A2R10G10B10 := 35
    static D3DFMT_A16B16G16R16 := 36
    static D3DFMT_A8P8 := 40
    static D3DFMT_P8 := 41
    static D3DFMT_L8 := 50
    static D3DFMT_A8L8 := 51
    static D3DFMT_A4L4 := 52
    static D3DFMT_V8U8 := 60
    static D3DFMT_L6V5U5 := 61
    static D3DFMT_X8L8V8U8 := 62
    static D3DFMT_Q8W8V8U8 := 63
    static D3DFMT_V16U16 := 64
    static D3DFMT_A2W10V10U10 := 67
    static D3DFMT_UYVY := 1498831189
    static D3DFMT_R8G8_B8G8 := 1195525970
    static D3DFMT_YUY2 := 844715353
    static D3DFMT_G8R8_G8B8 := 1111970375
    static D3DFMT_DXT1 := 827611204
    static D3DFMT_DXT2 := 844388420
    static D3DFMT_DXT3 := 861165636
    static D3DFMT_DXT4 := 877942852
    static D3DFMT_DXT5 := 894720068
    static D3DFMT_D16_LOCKABLE := 70
    static D3DFMT_D32 := 71
    static D3DFMT_D15S1 := 73
    static D3DFMT_D24S8 := 75
    static D3DFMT_D24X8 := 77
    static D3DFMT_D24X4S4 := 79
    static D3DFMT_D16 := 80
    static D3DFMT_D32F_LOCKABLE := 82
    static D3DFMT_D24FS8 := 83
    static D3DFMT_D32_LOCKABLE := 84
    static D3DFMT_S8_LOCKABLE := 85
    static D3DFMT_L16 := 81
    static D3DFMT_VERTEXDATA := 100
    static D3DFMT_INDEX16 := 101
    static D3DFMT_INDEX32 := 102
    static D3DFMT_Q16W16V16U16 := 110
    static D3DFMT_MULTI2_ARGB8 := 827606349
    static D3DFMT_R16F := 111
    static D3DFMT_G16R16F := 112
    static D3DFMT_A16B16G16R16F := 113
    static D3DFMT_R32F := 114
    static D3DFMT_G32R32F := 115
    static D3DFMT_A32B32G32R32F := 116
    static D3DFMT_CxV8U8 := 117
    static D3DFMT_A1 := 118
    static D3DFMT_A2B10G10R10_XR_BIAS := 119
    static D3DFMT_BINARYBUFFER := 199
}
struct D3DDISPLAYMODE {
    Width : UInt32
    Height : UInt32
    RefreshRate : UInt32
    Format : D3DFORMAT
}
struct D3DDEVICE_CREATION_PARAMETERS {
    AdapterOrdinal : UInt32
    DeviceType : D3DDEVTYPE
    hFocusWindow : HWND
    BehaviorFlags : UInt32
}
struct D3DSWAPEFFECT extends Int32 {
    static D3DSWAPEFFECT_DISCARD := 1
    static D3DSWAPEFFECT_FLIP := 2
    static D3DSWAPEFFECT_COPY := 3
    static D3DSWAPEFFECT_OVERLAY := 4
    static D3DSWAPEFFECT_FLIPEX := 5
}
struct D3DPOOL extends Int32 {
    static D3DPOOL_DEFAULT := 0
    static D3DPOOL_MANAGED := 1
    static D3DPOOL_SYSTEMMEM := 2
    static D3DPOOL_SCRATCH := 3
}
struct D3DPRESENT_PARAMETERS {
    BackBufferWidth : UInt32
    BackBufferHeight : UInt32
    BackBufferFormat : D3DFORMAT
    BackBufferCount : UInt32
    MultiSampleType : D3DMULTISAMPLE_TYPE
    MultiSampleQuality : UInt32
    SwapEffect : D3DSWAPEFFECT
    hDeviceWindow : HWND
    Windowed : BOOL
    EnableAutoDepthStencil : BOOL
    AutoDepthStencilFormat : D3DFORMAT
    Flags : UInt32
    FullScreen_RefreshRateInHz : UInt32
    PresentationInterval : UInt32
}
struct D3DGAMMARAMP {
    red : UInt16[256]
    green : UInt16[256]
    blue : UInt16[256]
}
struct D3DBACKBUFFER_TYPE extends Int32 {
    static D3DBACKBUFFER_TYPE_MONO := 0
    static D3DBACKBUFFER_TYPE_LEFT := 1
    static D3DBACKBUFFER_TYPE_RIGHT := 2
}
struct D3DRESOURCETYPE extends Int32 {
    static D3DRTYPE_SURFACE := 1
    static D3DRTYPE_VOLUME := 2
    static D3DRTYPE_TEXTURE := 3
    static D3DRTYPE_VOLUMETEXTURE := 4
    static D3DRTYPE_CUBETEXTURE := 5
    static D3DRTYPE_VERTEXBUFFER := 6
    static D3DRTYPE_INDEXBUFFER := 7
}
struct D3DCUBEMAP_FACES extends Int32 {
    static D3DCUBEMAP_FACE_POSITIVE_X := 0
    static D3DCUBEMAP_FACE_NEGATIVE_X := 1
    static D3DCUBEMAP_FACE_POSITIVE_Y := 2
    static D3DCUBEMAP_FACE_NEGATIVE_Y := 3
    static D3DCUBEMAP_FACE_POSITIVE_Z := 4
    static D3DCUBEMAP_FACE_NEGATIVE_Z := 5
}
struct D3DVERTEXBUFFER_DESC {
    Format : D3DFORMAT
    Type : D3DRESOURCETYPE
    Usage : UInt32
    Pool : D3DPOOL
    Size : UInt32
    FVF : UInt32
}
struct D3DINDEXBUFFER_DESC {
    Format : D3DFORMAT
    Type : D3DRESOURCETYPE
    Usage : UInt32
    Pool : D3DPOOL
    Size : UInt32
}
struct D3DSURFACE_DESC {
    Format : D3DFORMAT
    Type : D3DRESOURCETYPE
    Usage : UInt32
    Pool : D3DPOOL
    MultiSampleType : D3DMULTISAMPLE_TYPE
    MultiSampleQuality : UInt32
    Width : UInt32
    Height : UInt32
}
struct D3DVOLUME_DESC {
    Format : D3DFORMAT
    Type : D3DRESOURCETYPE
    Usage : UInt32
    Pool : D3DPOOL
    Width : UInt32
    Height : UInt32
    Depth : UInt32
}
struct D3DLOCKED_RECT {
    Pitch : Int32
    pBits : Struct.Ptr
}
struct D3DBOX {
    Left : UInt32
    Top : UInt32
    Right : UInt32
    Bottom : UInt32
    Front : UInt32
    Back : UInt32
}
struct D3DLOCKED_BOX {
    RowPitch : Int32
    SlicePitch : Int32
    pBits : Struct.Ptr
}
struct D3DRANGE {
    Offset : UInt32
    Size : UInt32
}
struct D3DRECTPATCH_INFO {
    StartVertexOffsetWidth : UInt32
    StartVertexOffsetHeight : UInt32
    Width : UInt32
    Height : UInt32
    Stride : UInt32
    Basis : D3DBASISTYPE
    Degree : D3DDEGREETYPE
}
struct D3DTRIPATCH_INFO {
    StartVertexOffset : UInt32
    NumVertices : UInt32
    Basis : D3DBASISTYPE
    Degree : D3DDEGREETYPE
}
struct D3DRASTER_STATUS {
    InVBlank : BOOL
    ScanLine : UInt32
}
struct D3DDEBUGMONITORTOKENS extends Int32 {
    static D3DDMT_ENABLE := 0
    static D3DDMT_DISABLE := 1
}
struct D3DQUERYTYPE extends Int32 {
    static D3DQUERYTYPE_VCACHE := 4
    static D3DQUERYTYPE_RESOURCEMANAGER := 5
    static D3DQUERYTYPE_VERTEXSTATS := 6
    static D3DQUERYTYPE_EVENT := 8
    static D3DQUERYTYPE_OCCLUSION := 9
    static D3DQUERYTYPE_TIMESTAMP := 10
    static D3DQUERYTYPE_TIMESTAMPDISJOINT := 11
    static D3DQUERYTYPE_TIMESTAMPFREQ := 12
    static D3DQUERYTYPE_PIPELINETIMINGS := 13
    static D3DQUERYTYPE_INTERFACETIMINGS := 14
    static D3DQUERYTYPE_VERTEXTIMINGS := 15
    static D3DQUERYTYPE_PIXELTIMINGS := 16
    static D3DQUERYTYPE_BANDWIDTHTIMINGS := 17
    static D3DQUERYTYPE_CACHEUTILIZATION := 18
    static D3DQUERYTYPE_MEMORYPRESSURE := 19
}
struct D3DRESOURCESTATS {
    bThrashing : BOOL
    ApproxBytesDownloaded : UInt32
    NumEvicts : UInt32
    NumVidCreates : UInt32
    LastPri : UInt32
    NumUsed : UInt32
    NumUsedInVidMem : UInt32
    WorkingSet : UInt32
    WorkingSetBytes : UInt32
    TotalManaged : UInt32
    TotalBytes : UInt32
}
struct D3DDEVINFO_RESOURCEMANAGER {
    stats : D3DRESOURCESTATS[8]
}
struct D3DDEVINFO_D3DVERTEXSTATS {
    NumRenderedTriangles : UInt32
    NumExtraClippingTriangles : UInt32
}
struct D3DDEVINFO_VCACHE {
    Pattern : UInt32
    OptMethod : UInt32
    CacheSize : UInt32
    MagicNumber : UInt32
}
struct D3DDEVINFO_D3D9PIPELINETIMINGS {
    VertexProcessingTimePercent : Float32
    PixelProcessingTimePercent : Float32
    OtherGPUProcessingTimePercent : Float32
    GPUIdleTimePercent : Float32
}
struct D3DDEVINFO_D3D9INTERFACETIMINGS {
    WaitingForGPUToUseApplicationResourceTimePercent : Float32
    WaitingForGPUToAcceptMoreCommandsTimePercent : Float32
    WaitingForGPUToStayWithinLatencyTimePercent : Float32
    WaitingForGPUExclusiveResourceTimePercent : Float32
    WaitingForGPUOtherTimePercent : Float32
}
struct D3DDEVINFO_D3D9STAGETIMINGS {
    MemoryProcessingPercent : Float32
    ComputationProcessingPercent : Float32
}
struct D3DDEVINFO_D3D9BANDWIDTHTIMINGS {
    MaxBandwidthUtilized : Float32
    FrontEndUploadMemoryUtilizedPercent : Float32
    VertexRateUtilizedPercent : Float32
    TriangleSetupRateUtilizedPercent : Float32
    FillRateUtilizedPercent : Float32
}
struct D3DDEVINFO_D3D9CACHEUTILIZATION {
    TextureCacheHitRate : Float32
    PostTransformVertexCacheHitRate : Float32
}
struct D3DCOMPOSERECTSOP extends Int32 {
    static D3DCOMPOSERECTS_COPY := 1
    static D3DCOMPOSERECTS_OR := 2
    static D3DCOMPOSERECTS_AND := 3
    static D3DCOMPOSERECTS_NEG := 4
}
struct D3DCOMPOSERECTDESC {
    X : UInt16
    Y : UInt16
    Width : UInt16
    Height : UInt16
}
struct D3DCOMPOSERECTDESTINATION {
    SrcRectIndex : UInt16
    Reserved : UInt16
    X : Int16
    Y : Int16
}
struct D3DSCANLINEORDERING extends Int32 {
    static D3DSCANLINEORDERING_UNKNOWN := 0
    static D3DSCANLINEORDERING_PROGRESSIVE := 1
    static D3DSCANLINEORDERING_INTERLACED := 2
}
struct D3DDISPLAYMODEEX {
    Size : UInt32
    Width : UInt32
    Height : UInt32
    RefreshRate : UInt32
    Format : D3DFORMAT
    ScanLineOrdering : D3DSCANLINEORDERING
}
struct D3DDISPLAYMODEFILTER {
    Size : UInt32
    Format : D3DFORMAT
    ScanLineOrdering : D3DSCANLINEORDERING
}
struct D3DDISPLAYROTATION extends Int32 {
    static D3DDISPLAYROTATION_IDENTITY := 1
    static D3DDISPLAYROTATION_90 := 2
    static D3DDISPLAYROTATION_180 := 3
    static D3DDISPLAYROTATION_270 := 4
}
struct D3D_OMAC {
    Omac : UInt8[16]
}
struct D3DAUTHENTICATEDCHANNELTYPE extends Int32 {
    static D3DAUTHENTICATEDCHANNEL_D3D9 := 1
    static D3DAUTHENTICATEDCHANNEL_DRIVER_SOFTWARE := 2
    static D3DAUTHENTICATEDCHANNEL_DRIVER_HARDWARE := 3
}
struct D3DAUTHENTICATEDCHANNEL_QUERY_INPUT {
    QueryType : GUID
    hChannel : HANDLE
    SequenceNumber : UInt32
}
struct D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT {
    omac : D3D_OMAC
    QueryType : GUID
    hChannel : HANDLE
    SequenceNumber : UInt32
    ReturnCode : HRESULT
}
struct D3DAUTHENTICATEDCHANNEL_PROTECTION_FLAGS {
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous : this._Anonymous_e__Struct
            Value : UInt32
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct D3DAUTHENTICATEDCHANNEL_QUERYPROTECTION_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    ProtectionFlags : D3DAUTHENTICATEDCHANNEL_PROTECTION_FLAGS
}
struct D3DAUTHENTICATEDCHANNEL_QUERYCHANNELTYPE_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    ChannelType : D3DAUTHENTICATEDCHANNELTYPE
}
struct D3DAUTHENTICATEDCHANNEL_QUERYDEVICEHANDLE_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    DeviceHandle : HANDLE
}
struct D3DAUTHENTICATEDCHANNEL_QUERYCRYPTOSESSION_INPUT {
    Input : D3DAUTHENTICATEDCHANNEL_QUERY_INPUT
    DXVA2DecodeHandle : HANDLE
}
struct D3DAUTHENTICATEDCHANNEL_QUERYCRYPTOSESSION_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    DXVA2DecodeHandle : HANDLE
    CryptoSessionHandle : HANDLE
    DeviceHandle : HANDLE
}
struct D3DAUTHENTICATEDCHANNEL_QUERYRESTRICTEDSHAREDRESOURCEPROCESSCOUNT_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    NumRestrictedSharedResourceProcesses : UInt32
}
struct D3DAUTHENTICATEDCHANNEL_QUERYRESTRICTEDSHAREDRESOURCEPROCESS_INPUT {
    Input : D3DAUTHENTICATEDCHANNEL_QUERY_INPUT
    ProcessIndex : UInt32
}
struct D3DAUTHENTICATEDCHANNEL_PROCESSIDENTIFIERTYPE extends Int32 {
    static PROCESSIDTYPE_UNKNOWN := 0
    static PROCESSIDTYPE_DWM := 1
    static PROCESSIDTYPE_HANDLE := 2
}
struct D3DAUTHENTICATEDCHANNEL_QUERYRESTRICTEDSHAREDRESOURCEPROCESS_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    ProcessIndex : UInt32
    ProcessIdentifer : D3DAUTHENTICATEDCHANNEL_PROCESSIDENTIFIERTYPE
    ProcessHandle : HANDLE
}
struct D3DAUTHENTICATEDCHANNEL_QUERYUNRESTRICTEDPROTECTEDSHAREDRESOURCECOUNT_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    NumUnrestrictedProtectedSharedResources : UInt32
}
struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTIDCOUNT_INPUT {
    Input : D3DAUTHENTICATEDCHANNEL_QUERY_INPUT
    DeviceHandle : HANDLE
    CryptoSessionHandle : HANDLE
}
struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTIDCOUNT_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    DeviceHandle : HANDLE
    CryptoSessionHandle : HANDLE
    NumOutputIDs : UInt32
}
struct D3DAUTHENTICATEDCHANNEL_QUERYOUTPUTID_INPUT {
    Input : D3DAUTHENTICATEDCHANNEL_QUERY_INPUT
    DeviceHandle : HANDLE
    CryptoSessionHandle : HANDLE
    OutputIDIndex : UInt32
}
struct D3DBUSTYPE extends Int32 {
    static D3DBUSTYPE_OTHER := 0
    static D3DBUSTYPE_PCI := 1
    static D3DBUSTYPE_PCIX := 2
    static D3DBUSTYPE_PCIEXPRESS := 3
    static D3DBUSTYPE_AGP := 4
    static D3DBUSIMPL_MODIFIER_INSIDE_OF_CHIPSET := 65536
    static D3DBUSIMPL_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_CHIP := 131072
    static D3DBUSIMPL_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_SOCKET := 196608
    static D3DBUSIMPL_MODIFIER_DAUGHTER_BOARD_CONNECTOR := 262144
    static D3DBUSIMPL_MODIFIER_DAUGHTER_BOARD_CONNECTOR_INSIDE_OF_NUAE := 327680
    static D3DBUSIMPL_MODIFIER_NON_STANDARD := -2147483648
}
struct D3DAUTHENTICATEDCHANNEL_QUERYINFOBUSTYPE_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    BusType : D3DBUSTYPE
    bAccessibleInContiguousBlocks : BOOL
    bAccessibleInNonContiguousBlocks : BOOL
}
struct D3DAUTHENTICATEDCHANNEL_QUERYEVICTIONENCRYPTIONGUIDCOUNT_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    NumEncryptionGuids : UInt32
}
struct D3DAUTHENTICATEDCHANNEL_QUERYEVICTIONENCRYPTIONGUID_INPUT {
    Input : D3DAUTHENTICATEDCHANNEL_QUERY_INPUT
    EncryptionGuidIndex : UInt32
}
struct D3DAUTHENTICATEDCHANNEL_QUERYEVICTIONENCRYPTIONGUID_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    EncryptionGuidIndex : UInt32
    EncryptionGuid : GUID
}
struct D3DAUTHENTICATEDCHANNEL_QUERYUNCOMPRESSEDENCRYPTIONLEVEL_OUTPUT {
    Output : D3DAUTHENTICATEDCHANNEL_QUERY_OUTPUT
    EncryptionGuid : GUID
}
struct D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT {
    omac : D3D_OMAC
    ConfigureType : GUID
    hChannel : HANDLE
    SequenceNumber : UInt32
}
struct D3DAUTHENTICATEDCHANNEL_CONFIGURE_OUTPUT {
    omac : D3D_OMAC
    ConfigureType : GUID
    hChannel : HANDLE
    SequenceNumber : UInt32
    ReturnCode : HRESULT
}
struct D3DAUTHENTICATEDCHANNEL_CONFIGUREINITIALIZE {
    Parameters : D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT
    StartSequenceQuery : UInt32
    StartSequenceConfigure : UInt32
}
struct D3DAUTHENTICATEDCHANNEL_CONFIGUREPROTECTION {
    Parameters : D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT
    Protections : D3DAUTHENTICATEDCHANNEL_PROTECTION_FLAGS
}
struct D3DAUTHENTICATEDCHANNEL_CONFIGURECRYPTOSESSION {
    Parameters : D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT
    DXVA2DecodeHandle : HANDLE
    CryptoSessionHandle : HANDLE
    DeviceHandle : HANDLE
}
struct D3DAUTHENTICATEDCHANNEL_CONFIGURESHAREDRESOURCE {
    Parameters : D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT
    ProcessIdentiferType : D3DAUTHENTICATEDCHANNEL_PROCESSIDENTIFIERTYPE
    ProcessHandle : HANDLE
    AllowAccess : BOOL
}
struct D3DAUTHENTICATEDCHANNEL_CONFIGUREUNCOMPRESSEDENCRYPTION {
    Parameters : D3DAUTHENTICATEDCHANNEL_CONFIGURE_INPUT
    EncryptionGuid : GUID
}
struct D3DENCRYPTED_BLOCK_INFO {
    NumEncryptedBytesAtBeginning : UInt32
    NumBytesInSkipPattern : UInt32
    NumBytesInEncryptPattern : UInt32
}
struct D3DVSHADERCAPS2_0 {
    Caps : UInt32
    DynamicFlowControlDepth : Int32
    NumTemps : Int32
    StaticFlowControlDepth : Int32
}
struct D3DPSHADERCAPS2_0 {
    Caps : UInt32
    DynamicFlowControlDepth : Int32
    NumTemps : Int32
    StaticFlowControlDepth : Int32
    NumInstructionSlots : Int32
}
struct D3DCAPS9 {
    DeviceType : D3DDEVTYPE
    AdapterOrdinal : UInt32
    Caps : UInt32
    Caps2 : UInt32
    Caps3 : UInt32
    PresentationIntervals : UInt32
    CursorCaps : UInt32
    DevCaps : UInt32
    PrimitiveMiscCaps : UInt32
    RasterCaps : UInt32
    ZCmpCaps : UInt32
    SrcBlendCaps : UInt32
    DestBlendCaps : UInt32
    AlphaCmpCaps : UInt32
    ShadeCaps : UInt32
    TextureCaps : UInt32
    TextureFilterCaps : UInt32
    CubeTextureFilterCaps : UInt32
    VolumeTextureFilterCaps : UInt32
    TextureAddressCaps : UInt32
    VolumeTextureAddressCaps : UInt32
    LineCaps : UInt32
    MaxTextureWidth : UInt32
    MaxTextureHeight : UInt32
    MaxVolumeExtent : UInt32
    MaxTextureRepeat : UInt32
    MaxTextureAspectRatio : UInt32
    MaxAnisotropy : UInt32
    MaxVertexW : Float32
    GuardBandLeft : Float32
    GuardBandTop : Float32
    GuardBandRight : Float32
    GuardBandBottom : Float32
    ExtentsAdjust : Float32
    StencilCaps : UInt32
    FVFCaps : UInt32
    TextureOpCaps : UInt32
    MaxTextureBlendStages : UInt32
    MaxSimultaneousTextures : UInt32
    VertexProcessingCaps : UInt32
    MaxActiveLights : UInt32
    MaxUserClipPlanes : UInt32
    MaxVertexBlendMatrices : UInt32
    MaxVertexBlendMatrixIndex : UInt32
    MaxPointSize : Float32
    MaxPrimitiveCount : UInt32
    MaxVertexIndex : UInt32
    MaxStreams : UInt32
    MaxStreamStride : UInt32
    VertexShaderVersion : UInt32
    MaxVertexShaderConst : UInt32
    PixelShaderVersion : UInt32
    PixelShader1xMaxValue : Float32
    DevCaps2 : UInt32
    MaxNpatchTessellationLevel : Float32
    Reserved5 : UInt32
    MasterAdapterOrdinal : UInt32
    AdapterOrdinalInGroup : UInt32
    NumberOfAdaptersInGroup : UInt32
    DeclTypes : UInt32
    NumSimultaneousRTs : UInt32
    StretchRectFilterCaps : UInt32
    VS20Caps : D3DVSHADERCAPS2_0
    PS20Caps : D3DPSHADERCAPS2_0
    VertexTextureFilterCaps : UInt32
    MaxVShaderInstructionsExecuted : UInt32
    MaxPShaderInstructionsExecuted : UInt32
    MaxVertexShader30InstructionSlots : UInt32
    MaxPixelShader30InstructionSlots : UInt32
}
struct IDirect3D9 extends IUnknown {
    static IID := "{81BDCBCA-64D4-426D-AE8D-AD0147F4275C}"
    RegisterSoftwareDevice(pInitializeFunction)
      => ComCall(3, this.p, Struct.Ptr, pInitializeFunction)
    GetAdapterCount()
      => ComCall(4, this.p, UInt32)
    GetAdapterIdentifier(Adapter, Flags, pIdentifier)
      => ComCall(5, this.p, UInt32, Adapter, UInt32, Flags, D3DADAPTER_IDENTIFIER9.Ptr, pIdentifier)
    GetAdapterModeCount(Adapter, Format)
      => ComCall(6, this.p, UInt32, Adapter, D3DFORMAT, Format, UInt32)
    EnumAdapterModes(Adapter, Format, Mode, pMode)
      => ComCall(7, this.p, UInt32, Adapter, D3DFORMAT, Format, UInt32, Mode, D3DDISPLAYMODE.Ptr, pMode)
    GetAdapterDisplayMode(Adapter, pMode)
      => ComCall(8, this.p, UInt32, Adapter, D3DDISPLAYMODE.Ptr, pMode)
    CheckDeviceType(Adapter, DevType, AdapterFormat, BackBufferFormat, bWindowed)
      => ComCall(9, this.p, UInt32, Adapter, D3DDEVTYPE, DevType, D3DFORMAT, AdapterFormat, D3DFORMAT, BackBufferFormat, BOOL, bWindowed)
    CheckDeviceFormat(Adapter, DeviceType, AdapterFormat, Usage, RType, CheckFormat)
      => ComCall(10, this.p, UInt32, Adapter, D3DDEVTYPE, DeviceType, D3DFORMAT, AdapterFormat, UInt32, Usage, D3DRESOURCETYPE, RType, D3DFORMAT, CheckFormat)
    CheckDeviceMultiSampleType(Adapter, DeviceType, SurfaceFormat, Windowed, MultiSampleType, pQualityLevels)
      => ComCall(11, this.p, UInt32, Adapter, D3DDEVTYPE, DeviceType, D3DFORMAT, SurfaceFormat, BOOL, Windowed, D3DMULTISAMPLE_TYPE, MultiSampleType, UInt32.Ptr, pQualityLevels)
    CheckDepthStencilMatch(Adapter, DeviceType, AdapterFormat, RenderTargetFormat, DepthStencilFormat)
      => ComCall(12, this.p, UInt32, Adapter, D3DDEVTYPE, DeviceType, D3DFORMAT, AdapterFormat, D3DFORMAT, RenderTargetFormat, D3DFORMAT, DepthStencilFormat)
    CheckDeviceFormatConversion(Adapter, DeviceType, SourceFormat, TargetFormat)
      => ComCall(13, this.p, UInt32, Adapter, D3DDEVTYPE, DeviceType, D3DFORMAT, SourceFormat, D3DFORMAT, TargetFormat)
    GetDeviceCaps(Adapter, DeviceType, pCaps)
      => ComCall(14, this.p, UInt32, Adapter, D3DDEVTYPE, DeviceType, D3DCAPS9.Ptr, pCaps)
    GetAdapterMonitor(Adapter)
      => ComCall(15, this.p, UInt32, Adapter, HMONITOR)
    CreateDevice(Adapter, DeviceType, hFocusWindow, BehaviorFlags, pPresentationParameters, ppReturnedDeviceInterface)
      => ComCall(16, this.p, UInt32, Adapter, D3DDEVTYPE, DeviceType, HWND, hFocusWindow, UInt32, BehaviorFlags, D3DPRESENT_PARAMETERS.Ptr, pPresentationParameters, IDirect3DDevice9.Ptr, ppReturnedDeviceInterface)
}
struct IDirect3DDevice9 extends IUnknown {
    static IID := "{D0223B96-BF7A-43FD-92BD-A43B0D82B9EB}"
    TestCooperativeLevel()
      => ComCall(3, this.p)
    GetAvailableTextureMem()
      => ComCall(4, this.p, UInt32)
    EvictManagedResources()
      => ComCall(5, this.p)
    GetDirect3D(ppD3D9)
      => ComCall(6, this.p, IDirect3D9.Ptr, ppD3D9)
    GetDeviceCaps(pCaps)
      => ComCall(7, this.p, D3DCAPS9.Ptr, pCaps)
    GetDisplayMode(iSwapChain, pMode)
      => ComCall(8, this.p, UInt32, iSwapChain, D3DDISPLAYMODE.Ptr, pMode)
    GetCreationParameters(pParameters)
      => ComCall(9, this.p, D3DDEVICE_CREATION_PARAMETERS.Ptr, pParameters)
    SetCursorProperties(XHotSpot, YHotSpot, pCursorBitmap)
      => ComCall(10, this.p, UInt32, XHotSpot, UInt32, YHotSpot, IDirect3DSurface9, pCursorBitmap)
    SetCursorPosition(X, Y, Flags)
      => ComCall(11, this.p, Int32, X, Int32, Y, UInt32, Flags, "void")
    ShowCursor(bShow)
      => ComCall(12, this.p, BOOL, bShow, BOOL)
    CreateAdditionalSwapChain(pPresentationParameters, pSwapChain)
      => ComCall(13, this.p, D3DPRESENT_PARAMETERS.Ptr, pPresentationParameters, IDirect3DSwapChain9.Ptr, pSwapChain)
    GetSwapChain(iSwapChain, pSwapChain)
      => ComCall(14, this.p, UInt32, iSwapChain, IDirect3DSwapChain9.Ptr, pSwapChain)
    GetNumberOfSwapChains()
      => ComCall(15, this.p, UInt32)
    Reset(pPresentationParameters)
      => ComCall(16, this.p, D3DPRESENT_PARAMETERS.Ptr, pPresentationParameters)
    Present(pSourceRect, pDestRect, hDestWindowOverride, pDirtyRegion)
      => ComCall(17, this.p, RECT.Ptr, pSourceRect, RECT.Ptr, pDestRect, HWND, hDestWindowOverride, RGNDATA.Ptr, pDirtyRegion)
    GetBackBuffer(iSwapChain, iBackBuffer, Type, ppBackBuffer)
      => ComCall(18, this.p, UInt32, iSwapChain, UInt32, iBackBuffer, D3DBACKBUFFER_TYPE, Type, IDirect3DSurface9.Ptr, ppBackBuffer)
    GetRasterStatus(iSwapChain, pRasterStatus)
      => ComCall(19, this.p, UInt32, iSwapChain, D3DRASTER_STATUS.Ptr, pRasterStatus)
    SetDialogBoxMode(bEnableDialogs)
      => ComCall(20, this.p, BOOL, bEnableDialogs)
    SetGammaRamp(iSwapChain, Flags, pRamp)
      => ComCall(21, this.p, UInt32, iSwapChain, UInt32, Flags, D3DGAMMARAMP.Ptr, pRamp, "void")
    GetGammaRamp(iSwapChain, pRamp)
      => ComCall(22, this.p, UInt32, iSwapChain, D3DGAMMARAMP.Ptr, pRamp, "void")
    CreateTexture(Width, Height, Levels, Usage, Format, Pool, ppTexture, pSharedHandle)
      => ComCall(23, this.p, UInt32, Width, UInt32, Height, UInt32, Levels, UInt32, Usage, D3DFORMAT, Format, D3DPOOL, Pool, IDirect3DTexture9.Ptr, ppTexture, HANDLE.Ptr, pSharedHandle)
    CreateVolumeTexture(Width, Height, Depth, Levels, Usage, Format, Pool, ppVolumeTexture, pSharedHandle)
      => ComCall(24, this.p, UInt32, Width, UInt32, Height, UInt32, Depth, UInt32, Levels, UInt32, Usage, D3DFORMAT, Format, D3DPOOL, Pool, IDirect3DVolumeTexture9.Ptr, ppVolumeTexture, HANDLE.Ptr, pSharedHandle)
    CreateCubeTexture(EdgeLength, Levels, Usage, Format, Pool, ppCubeTexture, pSharedHandle)
      => ComCall(25, this.p, UInt32, EdgeLength, UInt32, Levels, UInt32, Usage, D3DFORMAT, Format, D3DPOOL, Pool, IDirect3DCubeTexture9.Ptr, ppCubeTexture, HANDLE.Ptr, pSharedHandle)
    CreateVertexBuffer(Length, Usage, FVF, Pool, ppVertexBuffer, pSharedHandle)
      => ComCall(26, this.p, UInt32, Length, UInt32, Usage, UInt32, FVF, D3DPOOL, Pool, IDirect3DVertexBuffer9.Ptr, ppVertexBuffer, HANDLE.Ptr, pSharedHandle)
    CreateIndexBuffer(Length, Usage, Format, Pool, ppIndexBuffer, pSharedHandle)
      => ComCall(27, this.p, UInt32, Length, UInt32, Usage, D3DFORMAT, Format, D3DPOOL, Pool, IDirect3DIndexBuffer9.Ptr, ppIndexBuffer, HANDLE.Ptr, pSharedHandle)
    CreateRenderTarget(Width, Height, Format, MultiSample, MultisampleQuality, Lockable, ppSurface, pSharedHandle)
      => ComCall(28, this.p, UInt32, Width, UInt32, Height, D3DFORMAT, Format, D3DMULTISAMPLE_TYPE, MultiSample, UInt32, MultisampleQuality, BOOL, Lockable, IDirect3DSurface9.Ptr, ppSurface, HANDLE.Ptr, pSharedHandle)
    CreateDepthStencilSurface(Width, Height, Format, MultiSample, MultisampleQuality, Discard, ppSurface, pSharedHandle)
      => ComCall(29, this.p, UInt32, Width, UInt32, Height, D3DFORMAT, Format, D3DMULTISAMPLE_TYPE, MultiSample, UInt32, MultisampleQuality, BOOL, Discard, IDirect3DSurface9.Ptr, ppSurface, HANDLE.Ptr, pSharedHandle)
    UpdateSurface(pSourceSurface, pSourceRect, pDestinationSurface, pDestPoint)
      => ComCall(30, this.p, IDirect3DSurface9, pSourceSurface, RECT.Ptr, pSourceRect, IDirect3DSurface9, pDestinationSurface, POINT.Ptr, pDestPoint)
    UpdateTexture(pSourceTexture, pDestinationTexture)
      => ComCall(31, this.p, IDirect3DBaseTexture9, pSourceTexture, IDirect3DBaseTexture9, pDestinationTexture)
    GetRenderTargetData(pRenderTarget, pDestSurface)
      => ComCall(32, this.p, IDirect3DSurface9, pRenderTarget, IDirect3DSurface9, pDestSurface)
    GetFrontBufferData(iSwapChain, pDestSurface)
      => ComCall(33, this.p, UInt32, iSwapChain, IDirect3DSurface9, pDestSurface)
    StretchRect(pSourceSurface, pSourceRect, pDestSurface, pDestRect, Filter)
      => ComCall(34, this.p, IDirect3DSurface9, pSourceSurface, RECT.Ptr, pSourceRect, IDirect3DSurface9, pDestSurface, RECT.Ptr, pDestRect, D3DTEXTUREFILTERTYPE, Filter)
    ColorFill(pSurface, pRect, color)
      => ComCall(35, this.p, IDirect3DSurface9, pSurface, RECT.Ptr, pRect, UInt32, color)
    CreateOffscreenPlainSurface(Width, Height, Format, Pool, ppSurface, pSharedHandle)
      => ComCall(36, this.p, UInt32, Width, UInt32, Height, D3DFORMAT, Format, D3DPOOL, Pool, IDirect3DSurface9.Ptr, ppSurface, HANDLE.Ptr, pSharedHandle)
    SetRenderTarget(RenderTargetIndex, pRenderTarget)
      => ComCall(37, this.p, UInt32, RenderTargetIndex, IDirect3DSurface9, pRenderTarget)
    GetRenderTarget(RenderTargetIndex, ppRenderTarget)
      => ComCall(38, this.p, UInt32, RenderTargetIndex, IDirect3DSurface9.Ptr, ppRenderTarget)
    SetDepthStencilSurface(pNewZStencil)
      => ComCall(39, this.p, IDirect3DSurface9, pNewZStencil)
    GetDepthStencilSurface(ppZStencilSurface)
      => ComCall(40, this.p, IDirect3DSurface9.Ptr, ppZStencilSurface)
    BeginScene()
      => ComCall(41, this.p)
    EndScene()
      => ComCall(42, this.p)
    Clear(Count, pRects, Flags, Color, Z, Stencil)
      => ComCall(43, this.p, UInt32, Count, D3DRECT.Ptr, pRects, UInt32, Flags, UInt32, Color, Float32, Z, UInt32, Stencil)
    SetTransform(State, pMatrix)
      => ComCall(44, this.p, D3DTRANSFORMSTATETYPE, State, D3DMATRIX.Ptr, pMatrix)
    GetTransform(State, pMatrix)
      => ComCall(45, this.p, D3DTRANSFORMSTATETYPE, State, D3DMATRIX.Ptr, pMatrix)
    MultiplyTransform(param0, param1)
      => ComCall(46, this.p, D3DTRANSFORMSTATETYPE, param0, D3DMATRIX.Ptr, param1)
    SetViewport(pViewport)
      => ComCall(47, this.p, D3DVIEWPORT9.Ptr, pViewport)
    GetViewport(pViewport)
      => ComCall(48, this.p, D3DVIEWPORT9.Ptr, pViewport)
    SetMaterial(pMaterial)
      => ComCall(49, this.p, D3DMATERIAL9.Ptr, pMaterial)
    GetMaterial(pMaterial)
      => ComCall(50, this.p, D3DMATERIAL9.Ptr, pMaterial)
    SetLight(Index, param1)
      => ComCall(51, this.p, UInt32, Index, D3DLIGHT9.Ptr, param1)
    GetLight(Index, param1)
      => ComCall(52, this.p, UInt32, Index, D3DLIGHT9.Ptr, param1)
    LightEnable(Index, Enable)
      => ComCall(53, this.p, UInt32, Index, BOOL, Enable)
    GetLightEnable(Index, pEnable)
      => ComCall(54, this.p, UInt32, Index, BOOL.Ptr, pEnable)
    SetClipPlane(Index, pPlane)
      => ComCall(55, this.p, UInt32, Index, Float32.Ptr, pPlane)
    GetClipPlane(Index, pPlane)
      => ComCall(56, this.p, UInt32, Index, Float32.Ptr, pPlane)
    SetRenderState(State, Value)
      => ComCall(57, this.p, D3DRENDERSTATETYPE, State, UInt32, Value)
    GetRenderState(State, pValue)
      => ComCall(58, this.p, D3DRENDERSTATETYPE, State, UInt32.Ptr, pValue)
    CreateStateBlock(Type, ppSB)
      => ComCall(59, this.p, D3DSTATEBLOCKTYPE, Type, IDirect3DStateBlock9.Ptr, ppSB)
    BeginStateBlock()
      => ComCall(60, this.p)
    EndStateBlock(ppSB)
      => ComCall(61, this.p, IDirect3DStateBlock9.Ptr, ppSB)
    SetClipStatus(pClipStatus)
      => ComCall(62, this.p, D3DCLIPSTATUS9.Ptr, pClipStatus)
    GetClipStatus(pClipStatus)
      => ComCall(63, this.p, D3DCLIPSTATUS9.Ptr, pClipStatus)
    GetTexture(Stage, ppTexture)
      => ComCall(64, this.p, UInt32, Stage, IDirect3DBaseTexture9.Ptr, ppTexture)
    SetTexture(Stage, pTexture)
      => ComCall(65, this.p, UInt32, Stage, IDirect3DBaseTexture9, pTexture)
    GetTextureStageState(Stage, Type, pValue)
      => ComCall(66, this.p, UInt32, Stage, D3DTEXTURESTAGESTATETYPE, Type, UInt32.Ptr, pValue)
    SetTextureStageState(Stage, Type, Value)
      => ComCall(67, this.p, UInt32, Stage, D3DTEXTURESTAGESTATETYPE, Type, UInt32, Value)
    GetSamplerState(Sampler, Type, pValue)
      => ComCall(68, this.p, UInt32, Sampler, D3DSAMPLERSTATETYPE, Type, UInt32.Ptr, pValue)
    SetSamplerState(Sampler, Type, Value)
      => ComCall(69, this.p, UInt32, Sampler, D3DSAMPLERSTATETYPE, Type, UInt32, Value)
    ValidateDevice(pNumPasses)
      => ComCall(70, this.p, UInt32.Ptr, pNumPasses)
    SetPaletteEntries(PaletteNumber, pEntries)
      => ComCall(71, this.p, UInt32, PaletteNumber, PALETTEENTRY.Ptr, pEntries)
    GetPaletteEntries(PaletteNumber, pEntries)
      => ComCall(72, this.p, UInt32, PaletteNumber, PALETTEENTRY.Ptr, pEntries)
    SetCurrentTexturePalette(PaletteNumber)
      => ComCall(73, this.p, UInt32, PaletteNumber)
    GetCurrentTexturePalette(PaletteNumber)
      => ComCall(74, this.p, UInt32.Ptr, PaletteNumber)
    SetScissorRect(pRect)
      => ComCall(75, this.p, RECT.Ptr, pRect)
    GetScissorRect(pRect)
      => ComCall(76, this.p, RECT.Ptr, pRect)
    SetSoftwareVertexProcessing(bSoftware)
      => ComCall(77, this.p, BOOL, bSoftware)
    GetSoftwareVertexProcessing()
      => ComCall(78, this.p, BOOL)
    SetNPatchMode(nSegments)
      => ComCall(79, this.p, Float32, nSegments)
    GetNPatchMode()
      => ComCall(80, this.p, Float32)
    DrawPrimitive(PrimitiveType, StartVertex, PrimitiveCount)
      => ComCall(81, this.p, D3DPRIMITIVETYPE, PrimitiveType, UInt32, StartVertex, UInt32, PrimitiveCount)
    DrawIndexedPrimitive(param0, BaseVertexIndex, MinVertexIndex, NumVertices, startIndex, primCount)
      => ComCall(82, this.p, D3DPRIMITIVETYPE, param0, Int32, BaseVertexIndex, UInt32, MinVertexIndex, UInt32, NumVertices, UInt32, startIndex, UInt32, primCount)
    DrawPrimitiveUP(PrimitiveType, PrimitiveCount, pVertexStreamZeroData, VertexStreamZeroStride)
      => ComCall(83, this.p, D3DPRIMITIVETYPE, PrimitiveType, UInt32, PrimitiveCount, Struct.Ptr, pVertexStreamZeroData, UInt32, VertexStreamZeroStride)
    DrawIndexedPrimitiveUP(PrimitiveType, MinVertexIndex, NumVertices, PrimitiveCount, pIndexData, IndexDataFormat, pVertexStreamZeroData, VertexStreamZeroStride)
      => ComCall(84, this.p, D3DPRIMITIVETYPE, PrimitiveType, UInt32, MinVertexIndex, UInt32, NumVertices, UInt32, PrimitiveCount, Struct.Ptr, pIndexData, D3DFORMAT, IndexDataFormat, Struct.Ptr, pVertexStreamZeroData, UInt32, VertexStreamZeroStride)
    ProcessVertices(SrcStartIndex, DestIndex, VertexCount, pDestBuffer, pVertexDecl, Flags)
      => ComCall(85, this.p, UInt32, SrcStartIndex, UInt32, DestIndex, UInt32, VertexCount, IDirect3DVertexBuffer9, pDestBuffer, IDirect3DVertexDeclaration9, pVertexDecl, UInt32, Flags)
    CreateVertexDeclaration(pVertexElements, ppDecl)
      => ComCall(86, this.p, D3DVERTEXELEMENT9.Ptr, pVertexElements, IDirect3DVertexDeclaration9.Ptr, ppDecl)
    SetVertexDeclaration(pDecl)
      => ComCall(87, this.p, IDirect3DVertexDeclaration9, pDecl)
    GetVertexDeclaration(ppDecl)
      => ComCall(88, this.p, IDirect3DVertexDeclaration9.Ptr, ppDecl)
    SetFVF(FVF)
      => ComCall(89, this.p, UInt32, FVF)
    GetFVF(pFVF)
      => ComCall(90, this.p, UInt32.Ptr, pFVF)
    CreateVertexShader(pFunction, ppShader)
      => ComCall(91, this.p, UInt32.Ptr, pFunction, IDirect3DVertexShader9.Ptr, ppShader)
    SetVertexShader(pShader)
      => ComCall(92, this.p, IDirect3DVertexShader9, pShader)
    GetVertexShader(ppShader)
      => ComCall(93, this.p, IDirect3DVertexShader9.Ptr, ppShader)
    SetVertexShaderConstantF(StartRegister, pConstantData, Vector4fCount)
      => ComCall(94, this.p, UInt32, StartRegister, Float32.Ptr, pConstantData, UInt32, Vector4fCount)
    GetVertexShaderConstantF(StartRegister, pConstantData, Vector4fCount)
      => ComCall(95, this.p, UInt32, StartRegister, Float32.Ptr, pConstantData, UInt32, Vector4fCount)
    SetVertexShaderConstantI(StartRegister, pConstantData, Vector4iCount)
      => ComCall(96, this.p, UInt32, StartRegister, Int32.Ptr, pConstantData, UInt32, Vector4iCount)
    GetVertexShaderConstantI(StartRegister, pConstantData, Vector4iCount)
      => ComCall(97, this.p, UInt32, StartRegister, Int32.Ptr, pConstantData, UInt32, Vector4iCount)
    SetVertexShaderConstantB(StartRegister, pConstantData, BoolCount)
      => ComCall(98, this.p, UInt32, StartRegister, BOOL.Ptr, pConstantData, UInt32, BoolCount)
    GetVertexShaderConstantB(StartRegister, pConstantData, BoolCount)
      => ComCall(99, this.p, UInt32, StartRegister, BOOL.Ptr, pConstantData, UInt32, BoolCount)
    SetStreamSource(StreamNumber, pStreamData, OffsetInBytes, Stride)
      => ComCall(100, this.p, UInt32, StreamNumber, IDirect3DVertexBuffer9, pStreamData, UInt32, OffsetInBytes, UInt32, Stride)
    GetStreamSource(StreamNumber, ppStreamData, pOffsetInBytes, pStride)
      => ComCall(101, this.p, UInt32, StreamNumber, IDirect3DVertexBuffer9.Ptr, ppStreamData, UInt32.Ptr, pOffsetInBytes, UInt32.Ptr, pStride)
    SetStreamSourceFreq(StreamNumber, Setting)
      => ComCall(102, this.p, UInt32, StreamNumber, UInt32, Setting)
    GetStreamSourceFreq(StreamNumber, pSetting)
      => ComCall(103, this.p, UInt32, StreamNumber, UInt32.Ptr, pSetting)
    SetIndices(pIndexData)
      => ComCall(104, this.p, IDirect3DIndexBuffer9, pIndexData)
    GetIndices(ppIndexData)
      => ComCall(105, this.p, IDirect3DIndexBuffer9.Ptr, ppIndexData)
    CreatePixelShader(pFunction, ppShader)
      => ComCall(106, this.p, UInt32.Ptr, pFunction, IDirect3DPixelShader9.Ptr, ppShader)
    SetPixelShader(pShader)
      => ComCall(107, this.p, IDirect3DPixelShader9, pShader)
    GetPixelShader(ppShader)
      => ComCall(108, this.p, IDirect3DPixelShader9.Ptr, ppShader)
    SetPixelShaderConstantF(StartRegister, pConstantData, Vector4fCount)
      => ComCall(109, this.p, UInt32, StartRegister, Float32.Ptr, pConstantData, UInt32, Vector4fCount)
    GetPixelShaderConstantF(StartRegister, pConstantData, Vector4fCount)
      => ComCall(110, this.p, UInt32, StartRegister, Float32.Ptr, pConstantData, UInt32, Vector4fCount)
    SetPixelShaderConstantI(StartRegister, pConstantData, Vector4iCount)
      => ComCall(111, this.p, UInt32, StartRegister, Int32.Ptr, pConstantData, UInt32, Vector4iCount)
    GetPixelShaderConstantI(StartRegister, pConstantData, Vector4iCount)
      => ComCall(112, this.p, UInt32, StartRegister, Int32.Ptr, pConstantData, UInt32, Vector4iCount)
    SetPixelShaderConstantB(StartRegister, pConstantData, BoolCount)
      => ComCall(113, this.p, UInt32, StartRegister, BOOL.Ptr, pConstantData, UInt32, BoolCount)
    GetPixelShaderConstantB(StartRegister, pConstantData, BoolCount)
      => ComCall(114, this.p, UInt32, StartRegister, BOOL.Ptr, pConstantData, UInt32, BoolCount)
    DrawRectPatch(Handle, pNumSegs, pRectPatchInfo)
      => ComCall(115, this.p, UInt32, Handle, Float32.Ptr, pNumSegs, D3DRECTPATCH_INFO.Ptr, pRectPatchInfo)
    DrawTriPatch(Handle, pNumSegs, pTriPatchInfo)
      => ComCall(116, this.p, UInt32, Handle, Float32.Ptr, pNumSegs, D3DTRIPATCH_INFO.Ptr, pTriPatchInfo)
    DeletePatch(Handle)
      => ComCall(117, this.p, UInt32, Handle)
    CreateQuery(Type, ppQuery)
      => ComCall(118, this.p, D3DQUERYTYPE, Type, IDirect3DQuery9.Ptr, ppQuery)
}
struct IDirect3DStateBlock9 extends IUnknown {
    static IID := "{B07C4FE5-310D-4BA8-A23C-4F0F206F218B}"
    GetDevice(ppDevice)
      => ComCall(3, this.p, IDirect3DDevice9.Ptr, ppDevice)
    Capture()
      => ComCall(4, this.p)
    Apply()
      => ComCall(5, this.p)
}
struct IDirect3DSwapChain9 extends IUnknown {
    static IID := "{794950F2-ADFC-458A-905E-10A10B0B503B}"
    Present(pSourceRect, pDestRect, hDestWindowOverride, pDirtyRegion, dwFlags)
      => ComCall(3, this.p, RECT.Ptr, pSourceRect, RECT.Ptr, pDestRect, HWND, hDestWindowOverride, RGNDATA.Ptr, pDirtyRegion, UInt32, dwFlags)
    GetFrontBufferData(pDestSurface)
      => ComCall(4, this.p, IDirect3DSurface9, pDestSurface)
    GetBackBuffer(iBackBuffer, Type, ppBackBuffer)
      => ComCall(5, this.p, UInt32, iBackBuffer, D3DBACKBUFFER_TYPE, Type, IDirect3DSurface9.Ptr, ppBackBuffer)
    GetRasterStatus(pRasterStatus)
      => ComCall(6, this.p, D3DRASTER_STATUS.Ptr, pRasterStatus)
    GetDisplayMode(pMode)
      => ComCall(7, this.p, D3DDISPLAYMODE.Ptr, pMode)
    GetDevice(ppDevice)
      => ComCall(8, this.p, IDirect3DDevice9.Ptr, ppDevice)
    GetPresentParameters(pPresentationParameters)
      => ComCall(9, this.p, D3DPRESENT_PARAMETERS.Ptr, pPresentationParameters)
}
struct IDirect3DResource9 extends IUnknown {
    static IID := "{05EEC05D-8F7D-4362-B999-D1BAF357C704}"
    GetDevice(ppDevice)
      => ComCall(3, this.p, IDirect3DDevice9.Ptr, ppDevice)
    SetPrivateData(refguid, pData, SizeOfData, Flags)
      => ComCall(4, this.p, GUID.Ptr, refguid, Struct.Ptr, pData, UInt32, SizeOfData, UInt32, Flags)
    GetPrivateData(refguid, pData, pSizeOfData)
      => ComCall(5, this.p, GUID.Ptr, refguid, Struct.Ptr, pData, UInt32.Ptr, pSizeOfData)
    FreePrivateData(refguid)
      => ComCall(6, this.p, GUID.Ptr, refguid)
    SetPriority(PriorityNew)
      => ComCall(7, this.p, UInt32, PriorityNew, UInt32)
    GetPriority()
      => ComCall(8, this.p, UInt32)
    PreLoad()
      => ComCall(9, this.p, "void")
    GetType()
      => ComCall(10, this.p, D3DRESOURCETYPE)
}
struct IDirect3DVertexDeclaration9 extends IUnknown {
    static IID := "{DD13C59C-36FA-4098-A8FB-C7ED39DC8546}"
    GetDevice(ppDevice)
      => ComCall(3, this.p, IDirect3DDevice9.Ptr, ppDevice)
    GetDeclaration(pElement, pNumElements)
      => ComCall(4, this.p, D3DVERTEXELEMENT9.Ptr, pElement, UInt32.Ptr, pNumElements)
}
struct IDirect3DVertexShader9 extends IUnknown {
    static IID := "{EFC5557E-6265-4613-8A94-43857889EB36}"
    GetDevice(ppDevice)
      => ComCall(3, this.p, IDirect3DDevice9.Ptr, ppDevice)
    GetFunction(param0, pSizeOfData)
      => ComCall(4, this.p, Struct.Ptr, param0, UInt32.Ptr, pSizeOfData)
}
struct IDirect3DPixelShader9 extends IUnknown {
    static IID := "{6D3BDBDC-5B02-4415-B852-CE5E8BCCB289}"
    GetDevice(ppDevice)
      => ComCall(3, this.p, IDirect3DDevice9.Ptr, ppDevice)
    GetFunction(param0, pSizeOfData)
      => ComCall(4, this.p, Struct.Ptr, param0, UInt32.Ptr, pSizeOfData)
}
struct IDirect3DBaseTexture9 extends IDirect3DResource9 {
    static IID := "{580CA87E-1D3C-4D54-991D-B7D3E3C298CE}"
    SetLOD(LODNew)
      => ComCall(11, this.p, UInt32, LODNew, UInt32)
    GetLOD()
      => ComCall(12, this.p, UInt32)
    GetLevelCount()
      => ComCall(13, this.p, UInt32)
    SetAutoGenFilterType(FilterType)
      => ComCall(14, this.p, D3DTEXTUREFILTERTYPE, FilterType)
    GetAutoGenFilterType()
      => ComCall(15, this.p, D3DTEXTUREFILTERTYPE)
    GenerateMipSubLevels()
      => ComCall(16, this.p, "void")
}
struct IDirect3DTexture9 extends IDirect3DBaseTexture9 {
    static IID := "{85C31227-3DE5-4F00-9B3A-F11AC38C18B5}"
    GetLevelDesc(Level, pDesc)
      => ComCall(17, this.p, UInt32, Level, D3DSURFACE_DESC.Ptr, pDesc)
    GetSurfaceLevel(Level, ppSurfaceLevel)
      => ComCall(18, this.p, UInt32, Level, IDirect3DSurface9.Ptr, ppSurfaceLevel)
    LockRect(Level, pLockedRect, pRect, Flags)
      => ComCall(19, this.p, UInt32, Level, D3DLOCKED_RECT.Ptr, pLockedRect, RECT.Ptr, pRect, UInt32, Flags)
    UnlockRect(Level)
      => ComCall(20, this.p, UInt32, Level)
    AddDirtyRect(pDirtyRect)
      => ComCall(21, this.p, RECT.Ptr, pDirtyRect)
}
struct IDirect3DVolumeTexture9 extends IDirect3DBaseTexture9 {
    static IID := "{2518526C-E789-4111-A7B9-47EF328D13E6}"
    GetLevelDesc(Level, pDesc)
      => ComCall(17, this.p, UInt32, Level, D3DVOLUME_DESC.Ptr, pDesc)
    GetVolumeLevel(Level, ppVolumeLevel)
      => ComCall(18, this.p, UInt32, Level, IDirect3DVolume9.Ptr, ppVolumeLevel)
    LockBox(Level, pLockedVolume, pBox, Flags)
      => ComCall(19, this.p, UInt32, Level, D3DLOCKED_BOX.Ptr, pLockedVolume, D3DBOX.Ptr, pBox, UInt32, Flags)
    UnlockBox(Level)
      => ComCall(20, this.p, UInt32, Level)
    AddDirtyBox(pDirtyBox)
      => ComCall(21, this.p, D3DBOX.Ptr, pDirtyBox)
}
struct IDirect3DCubeTexture9 extends IDirect3DBaseTexture9 {
    static IID := "{FFF32F81-D953-473A-9223-93D652ABA93F}"
    GetLevelDesc(Level, pDesc)
      => ComCall(17, this.p, UInt32, Level, D3DSURFACE_DESC.Ptr, pDesc)
    GetCubeMapSurface(FaceType, Level, ppCubeMapSurface)
      => ComCall(18, this.p, D3DCUBEMAP_FACES, FaceType, UInt32, Level, IDirect3DSurface9.Ptr, ppCubeMapSurface)
    LockRect(FaceType, Level, pLockedRect, pRect, Flags)
      => ComCall(19, this.p, D3DCUBEMAP_FACES, FaceType, UInt32, Level, D3DLOCKED_RECT.Ptr, pLockedRect, RECT.Ptr, pRect, UInt32, Flags)
    UnlockRect(FaceType, Level)
      => ComCall(20, this.p, D3DCUBEMAP_FACES, FaceType, UInt32, Level)
    AddDirtyRect(FaceType, pDirtyRect)
      => ComCall(21, this.p, D3DCUBEMAP_FACES, FaceType, RECT.Ptr, pDirtyRect)
}
struct IDirect3DVertexBuffer9 extends IDirect3DResource9 {
    static IID := "{B64BB1B5-FD70-4DF6-BF91-19D0A12455E3}"
    Lock(OffsetToLock, SizeToLock, ppbData, Flags)
      => ComCall(11, this.p, UInt32, OffsetToLock, UInt32, SizeToLock, Struct.Ptr.Ptr, ppbData, UInt32, Flags)
    Unlock()
      => ComCall(12, this.p)
    GetDesc(pDesc)
      => ComCall(13, this.p, D3DVERTEXBUFFER_DESC.Ptr, pDesc)
}
struct IDirect3DIndexBuffer9 extends IDirect3DResource9 {
    static IID := "{7C9DD65E-D3F7-4529-ACEE-785830ACDE35}"
    Lock(OffsetToLock, SizeToLock, ppbData, Flags)
      => ComCall(11, this.p, UInt32, OffsetToLock, UInt32, SizeToLock, Struct.Ptr.Ptr, ppbData, UInt32, Flags)
    Unlock()
      => ComCall(12, this.p)
    GetDesc(pDesc)
      => ComCall(13, this.p, D3DINDEXBUFFER_DESC.Ptr, pDesc)
}
struct IDirect3DSurface9 extends IDirect3DResource9 {
    static IID := "{0CFBAF3A-9FF6-429A-99B3-A2796AF8B89B}"
    GetContainer(riid, ppContainer)
      => ComCall(11, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppContainer)
    GetDesc(pDesc)
      => ComCall(12, this.p, D3DSURFACE_DESC.Ptr, pDesc)
    LockRect(pLockedRect, pRect, Flags)
      => ComCall(13, this.p, D3DLOCKED_RECT.Ptr, pLockedRect, RECT.Ptr, pRect, UInt32, Flags)
    UnlockRect()
      => ComCall(14, this.p)
    GetDC(phdc)
      => ComCall(15, this.p, HDC.Ptr, phdc)
    ReleaseDC(hdc1)
      => ComCall(16, this.p, HDC, hdc1)
}
struct IDirect3DVolume9 extends IUnknown {
    static IID := "{24F416E6-1F67-4AA7-B88E-D33F6F3128A1}"
    GetDevice(ppDevice)
      => ComCall(3, this.p, IDirect3DDevice9.Ptr, ppDevice)
    SetPrivateData(refguid, pData, SizeOfData, Flags)
      => ComCall(4, this.p, GUID.Ptr, refguid, Struct.Ptr, pData, UInt32, SizeOfData, UInt32, Flags)
    GetPrivateData(refguid, pData, pSizeOfData)
      => ComCall(5, this.p, GUID.Ptr, refguid, Struct.Ptr, pData, UInt32.Ptr, pSizeOfData)
    FreePrivateData(refguid)
      => ComCall(6, this.p, GUID.Ptr, refguid)
    GetContainer(riid, ppContainer)
      => ComCall(7, this.p, GUID.Ptr, riid, Struct.Ptr.Ptr, ppContainer)
    GetDesc(pDesc)
      => ComCall(8, this.p, D3DVOLUME_DESC.Ptr, pDesc)
    LockBox(pLockedVolume, pBox, Flags)
      => ComCall(9, this.p, D3DLOCKED_BOX.Ptr, pLockedVolume, D3DBOX.Ptr, pBox, UInt32, Flags)
    UnlockBox()
      => ComCall(10, this.p)
}
struct IDirect3DQuery9 extends IUnknown {
    static IID := "{D9771460-A695-4F26-BBD3-27B840B541CC}"
    GetDevice(ppDevice)
      => ComCall(3, this.p, IDirect3DDevice9.Ptr, ppDevice)
    GetType()
      => ComCall(4, this.p, D3DQUERYTYPE)
    GetDataSize()
      => ComCall(5, this.p, UInt32)
    Issue(dwIssueFlags)
      => ComCall(6, this.p, UInt32, dwIssueFlags)
    GetData(pData, dwSize, dwGetDataFlags)
      => ComCall(7, this.p, Struct.Ptr, pData, UInt32, dwSize, UInt32, dwGetDataFlags)
}
struct IDirect3D9Ex extends IDirect3D9 {
    static IID := "{02177241-69FC-400C-8FF1-93A44DF6861D}"
    GetAdapterModeCountEx(Adapter, pFilter)
      => ComCall(17, this.p, UInt32, Adapter, D3DDISPLAYMODEFILTER.Ptr, pFilter, UInt32)
    EnumAdapterModesEx(Adapter, pFilter, Mode, pMode)
      => ComCall(18, this.p, UInt32, Adapter, D3DDISPLAYMODEFILTER.Ptr, pFilter, UInt32, Mode, D3DDISPLAYMODEEX.Ptr, pMode)
    GetAdapterDisplayModeEx(Adapter, pMode, pRotation)
      => ComCall(19, this.p, UInt32, Adapter, D3DDISPLAYMODEEX.Ptr, pMode, D3DDISPLAYROTATION.Ptr, pRotation)
    CreateDeviceEx(Adapter, DeviceType, hFocusWindow, BehaviorFlags, pPresentationParameters, pFullscreenDisplayMode, ppReturnedDeviceInterface)
      => ComCall(20, this.p, UInt32, Adapter, D3DDEVTYPE, DeviceType, HWND, hFocusWindow, UInt32, BehaviorFlags, D3DPRESENT_PARAMETERS.Ptr, pPresentationParameters, D3DDISPLAYMODEEX.Ptr, pFullscreenDisplayMode, IDirect3DDevice9Ex.Ptr, ppReturnedDeviceInterface)
    GetAdapterLUID(Adapter, pLUID)
      => ComCall(21, this.p, UInt32, Adapter, LUID.Ptr, pLUID)
}
struct IDirect3DDevice9Ex extends IDirect3DDevice9 {
    static IID := "{B18B10CE-2649-405A-870F-95F777D4313A}"
    SetConvolutionMonoKernel(width, height, rows, columns)
      => ComCall(119, this.p, UInt32, width, UInt32, height, Float32.Ptr, rows, Float32.Ptr, columns)
    ComposeRects(pSrc, pDst, pSrcRectDescs, NumRects, pDstRectDescs, Operation, Xoffset, Yoffset)
      => ComCall(120, this.p, IDirect3DSurface9, pSrc, IDirect3DSurface9, pDst, IDirect3DVertexBuffer9, pSrcRectDescs, UInt32, NumRects, IDirect3DVertexBuffer9, pDstRectDescs, D3DCOMPOSERECTSOP, Operation, Int32, Xoffset, Int32, Yoffset)
    PresentEx(pSourceRect, pDestRect, hDestWindowOverride, pDirtyRegion, dwFlags)
      => ComCall(121, this.p, RECT.Ptr, pSourceRect, RECT.Ptr, pDestRect, HWND, hDestWindowOverride, RGNDATA.Ptr, pDirtyRegion, UInt32, dwFlags)
    GetGPUThreadPriority(pPriority)
      => ComCall(122, this.p, Int32.Ptr, pPriority)
    SetGPUThreadPriority(Priority)
      => ComCall(123, this.p, Int32, Priority)
    WaitForVBlank(iSwapChain)
      => ComCall(124, this.p, UInt32, iSwapChain)
    CheckResourceResidency(pResourceArray, NumResources)
      => ComCall(125, this.p, IDirect3DResource9.Ptr, pResourceArray, UInt32, NumResources)
    SetMaximumFrameLatency(MaxLatency)
      => ComCall(126, this.p, UInt32, MaxLatency)
    GetMaximumFrameLatency(pMaxLatency)
      => ComCall(127, this.p, UInt32.Ptr, pMaxLatency)
    CheckDeviceState(hDestinationWindow)
      => ComCall(128, this.p, HWND, hDestinationWindow)
    CreateRenderTargetEx(Width, Height, Format, MultiSample, MultisampleQuality, Lockable, ppSurface, pSharedHandle, Usage)
      => ComCall(129, this.p, UInt32, Width, UInt32, Height, D3DFORMAT, Format, D3DMULTISAMPLE_TYPE, MultiSample, UInt32, MultisampleQuality, BOOL, Lockable, IDirect3DSurface9.Ptr, ppSurface, HANDLE.Ptr, pSharedHandle, UInt32, Usage)
    CreateOffscreenPlainSurfaceEx(Width, Height, Format, Pool, ppSurface, pSharedHandle, Usage)
      => ComCall(130, this.p, UInt32, Width, UInt32, Height, D3DFORMAT, Format, D3DPOOL, Pool, IDirect3DSurface9.Ptr, ppSurface, HANDLE.Ptr, pSharedHandle, UInt32, Usage)
    CreateDepthStencilSurfaceEx(Width, Height, Format, MultiSample, MultisampleQuality, Discard, ppSurface, pSharedHandle, Usage)
      => ComCall(131, this.p, UInt32, Width, UInt32, Height, D3DFORMAT, Format, D3DMULTISAMPLE_TYPE, MultiSample, UInt32, MultisampleQuality, BOOL, Discard, IDirect3DSurface9.Ptr, ppSurface, HANDLE.Ptr, pSharedHandle, UInt32, Usage)
    ResetEx(pPresentationParameters, pFullscreenDisplayMode)
      => ComCall(132, this.p, D3DPRESENT_PARAMETERS.Ptr, pPresentationParameters, D3DDISPLAYMODEEX.Ptr, pFullscreenDisplayMode)
    GetDisplayModeEx(iSwapChain, pMode, pRotation)
      => ComCall(133, this.p, UInt32, iSwapChain, D3DDISPLAYMODEEX.Ptr, pMode, D3DDISPLAYROTATION.Ptr, pRotation)
}
struct IDirect3DSwapChain9Ex extends IDirect3DSwapChain9 {
    static IID := "{91886CAF-1C3D-4D2E-A0AB-3E4C7D8D3303}"
    GetLastPresentCount(pLastPresentCount)
      => ComCall(10, this.p, UInt32.Ptr, pLastPresentCount)
    GetPresentStats(pPresentationStatistics)
      => ComCall(11, this.p, D3DPRESENTSTATS.Ptr, pPresentationStatistics)
    GetDisplayModeEx(pMode, pRotation)
      => ComCall(12, this.p, D3DDISPLAYMODEEX.Ptr, pMode, D3DDISPLAYROTATION.Ptr, pRotation)
}
struct LPD3DVALIDATECALLBACK extends FunctionPointer {
    static Types := [Struct.Ptr, UInt32, HRESULT]
}
struct LPD3DENUMTEXTUREFORMATSCALLBACK extends FunctionPointer {
    static Types := [DDSURFACEDESC.Ptr, Struct.Ptr, HRESULT]
}
struct LPD3DENUMPIXELFORMATSCALLBACK extends FunctionPointer {
    static Types := [DDPIXELFORMAT.Ptr, Struct.Ptr, HRESULT]
}
struct D3DHVERTEX {
    dwFlags : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    struct _Anonymous1_e__Union {
        union {
            hx : Float32
            dvHX : Float32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            hy : Float32
            dvHY : Float32
        }
    }
    struct _Anonymous3_e__Union {
        union {
            hz : Float32
            dvHZ : Float32
        }
    }
}
struct D3DTLVERTEX {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    Anonymous4 : this._Anonymous4_e__Union
    Anonymous5 : this._Anonymous5_e__Union
    Anonymous6 : this._Anonymous6_e__Union
    Anonymous7 : this._Anonymous7_e__Union
    Anonymous8 : this._Anonymous8_e__Union
    struct _Anonymous1_e__Union {
        union {
            sx : Float32
            dvSX : Float32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            sy : Float32
            dvSY : Float32
        }
    }
    struct _Anonymous3_e__Union {
        union {
            sz : Float32
            dvSZ : Float32
        }
    }
    struct _Anonymous4_e__Union {
        union {
            rhw : Float32
            dvRHW : Float32
        }
    }
    struct _Anonymous5_e__Union {
        union {
            color : UInt32
            dcColor : UInt32
        }
    }
    struct _Anonymous6_e__Union {
        union {
            specular : UInt32
            dcSpecular : UInt32
        }
    }
    struct _Anonymous7_e__Union {
        union {
            tu : Float32
            dvTU : Float32
        }
    }
    struct _Anonymous8_e__Union {
        union {
            tv : Float32
            dvTV : Float32
        }
    }
}
struct D3DLVERTEX {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    dwReserved : UInt32
    Anonymous4 : this._Anonymous4_e__Union
    Anonymous5 : this._Anonymous5_e__Union
    Anonymous6 : this._Anonymous6_e__Union
    Anonymous7 : this._Anonymous7_e__Union
    struct _Anonymous1_e__Union {
        union {
            x : Float32
            dvX : Float32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            y : Float32
            dvY : Float32
        }
    }
    struct _Anonymous3_e__Union {
        union {
            z : Float32
            dvZ : Float32
        }
    }
    struct _Anonymous4_e__Union {
        union {
            color : UInt32
            dcColor : UInt32
        }
    }
    struct _Anonymous5_e__Union {
        union {
            specular : UInt32
            dcSpecular : UInt32
        }
    }
    struct _Anonymous6_e__Union {
        union {
            tu : Float32
            dvTU : Float32
        }
    }
    struct _Anonymous7_e__Union {
        union {
            tv : Float32
            dvTV : Float32
        }
    }
}
struct D3DVERTEX {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    Anonymous4 : this._Anonymous4_e__Union
    Anonymous5 : this._Anonymous5_e__Union
    Anonymous6 : this._Anonymous6_e__Union
    Anonymous7 : this._Anonymous7_e__Union
    Anonymous8 : this._Anonymous8_e__Union
    struct _Anonymous1_e__Union {
        union {
            x : Float32
            dvX : Float32
        }
    }
    struct _Anonymous2_e__Union {
        union {
            y : Float32
            dvY : Float32
        }
    }
    struct _Anonymous3_e__Union {
        union {
            z : Float32
            dvZ : Float32
        }
    }
    struct _Anonymous4_e__Union {
        union {
            nx : Float32
            dvNX : Float32
        }
    }
    struct _Anonymous5_e__Union {
        union {
            ny : Float32
            dvNY : Float32
        }
    }
    struct _Anonymous6_e__Union {
        union {
            nz : Float32
            dvNZ : Float32
        }
    }
    struct _Anonymous7_e__Union {
        union {
            tu : Float32
            dvTU : Float32
        }
    }
    struct _Anonymous8_e__Union {
        union {
            tv : Float32
            dvTV : Float32
        }
    }
}
struct D3DVIEWPORT {
    dwSize : UInt32
    dwX : UInt32
    dwY : UInt32
    dwWidth : UInt32
    dwHeight : UInt32
    dvScaleX : Float32
    dvScaleY : Float32
    dvMaxX : Float32
    dvMaxY : Float32
    dvMinZ : Float32
    dvMaxZ : Float32
}
struct D3DVIEWPORT2 {
    dwSize : UInt32
    dwX : UInt32
    dwY : UInt32
    dwWidth : UInt32
    dwHeight : UInt32
    dvClipX : Float32
    dvClipY : Float32
    dvClipWidth : Float32
    dvClipHeight : Float32
    dvMinZ : Float32
    dvMaxZ : Float32
}
struct D3DVIEWPORT7 {
    dwX : UInt32
    dwY : UInt32
    dwWidth : UInt32
    dwHeight : UInt32
    dvMinZ : Float32
    dvMaxZ : Float32
}
struct D3DTRANSFORMDATA {
    dwSize : UInt32
    lpIn : Struct.Ptr
    dwInSize : UInt32
    lpOut : Struct.Ptr
    dwOutSize : UInt32
    lpHOut : D3DHVERTEX.Ptr
    dwClip : UInt32
    dwClipIntersection : UInt32
    dwClipUnion : UInt32
    drExtent : D3DRECT
}
struct D3DLIGHTINGELEMENT {
    dvPosition : D3DVECTOR
    dvNormal : D3DVECTOR
}
struct D3DMATERIAL {
    dwSize : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    Anonymous4 : this._Anonymous4_e__Union
    Anonymous5 : this._Anonymous5_e__Union
    hTexture : UInt32
    dwRampSize : UInt32
    struct _Anonymous1_e__Union {
        union {
            diffuse : D3DCOLORVALUE
            dcvDiffuse : D3DCOLORVALUE
        }
    }
    struct _Anonymous2_e__Union {
        union {
            ambient : D3DCOLORVALUE
            dcvAmbient : D3DCOLORVALUE
        }
    }
    struct _Anonymous3_e__Union {
        union {
            specular : D3DCOLORVALUE
            dcvSpecular : D3DCOLORVALUE
        }
    }
    struct _Anonymous4_e__Union {
        union {
            emissive : D3DCOLORVALUE
            dcvEmissive : D3DCOLORVALUE
        }
    }
    struct _Anonymous5_e__Union {
        union {
            power : Float32
            dvPower : Float32
        }
    }
}
struct D3DMATERIAL7 {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    Anonymous4 : this._Anonymous4_e__Union
    Anonymous5 : this._Anonymous5_e__Union
    struct _Anonymous1_e__Union {
        union {
            diffuse : D3DCOLORVALUE
            dcvDiffuse : D3DCOLORVALUE
        }
    }
    struct _Anonymous2_e__Union {
        union {
            ambient : D3DCOLORVALUE
            dcvAmbient : D3DCOLORVALUE
        }
    }
    struct _Anonymous3_e__Union {
        union {
            specular : D3DCOLORVALUE
            dcvSpecular : D3DCOLORVALUE
        }
    }
    struct _Anonymous4_e__Union {
        union {
            emissive : D3DCOLORVALUE
            dcvEmissive : D3DCOLORVALUE
        }
    }
    struct _Anonymous5_e__Union {
        union {
            power : Float32
            dvPower : Float32
        }
    }
}
struct D3DLIGHT {
    dwSize : UInt32
    dltType : D3DLIGHTTYPE
    dcvColor : D3DCOLORVALUE
    dvPosition : D3DVECTOR
    dvDirection : D3DVECTOR
    dvRange : Float32
    dvFalloff : Float32
    dvAttenuation0 : Float32
    dvAttenuation1 : Float32
    dvAttenuation2 : Float32
    dvTheta : Float32
    dvPhi : Float32
}
struct D3DLIGHT7 {
    dltType : D3DLIGHTTYPE
    dcvDiffuse : D3DCOLORVALUE
    dcvSpecular : D3DCOLORVALUE
    dcvAmbient : D3DCOLORVALUE
    dvPosition : D3DVECTOR
    dvDirection : D3DVECTOR
    dvRange : Float32
    dvFalloff : Float32
    dvAttenuation0 : Float32
    dvAttenuation1 : Float32
    dvAttenuation2 : Float32
    dvTheta : Float32
    dvPhi : Float32
}
struct D3DLIGHT2 {
    dwSize : UInt32
    dltType : D3DLIGHTTYPE
    dcvColor : D3DCOLORVALUE
    dvPosition : D3DVECTOR
    dvDirection : D3DVECTOR
    dvRange : Float32
    dvFalloff : Float32
    dvAttenuation0 : Float32
    dvAttenuation1 : Float32
    dvAttenuation2 : Float32
    dvTheta : Float32
    dvPhi : Float32
    dwFlags : UInt32
}
struct D3DLIGHTDATA {
    dwSize : UInt32
    lpIn : D3DLIGHTINGELEMENT.Ptr
    dwInSize : UInt32
    lpOut : D3DTLVERTEX.Ptr
    dwOutSize : UInt32
}
struct D3DOPCODE extends Int32 {
    static D3DOP_POINT := 1
    static D3DOP_LINE := 2
    static D3DOP_TRIANGLE := 3
    static D3DOP_MATRIXLOAD := 4
    static D3DOP_MATRIXMULTIPLY := 5
    static D3DOP_STATETRANSFORM := 6
    static D3DOP_STATELIGHT := 7
    static D3DOP_STATERENDER := 8
    static D3DOP_PROCESSVERTICES := 9
    static D3DOP_TEXTURELOAD := 10
    static D3DOP_EXIT := 11
    static D3DOP_BRANCHFORWARD := 12
    static D3DOP_SPAN := 13
    static D3DOP_SETSTATUS := 14
}
struct D3DINSTRUCTION {
    bOpcode : UInt8
    bSize : UInt8
    wCount : UInt16
}
struct D3DTEXTURELOAD {
    hDestTexture : UInt32
    hSrcTexture : UInt32
}
struct D3DPICKRECORD {
    bOpcode : UInt8
    bPad : UInt8
    dwOffset : UInt32
    dvZ : Float32
}
struct D3DTEXTUREFILTER extends Int32 {
    static D3DFILTER_NEAREST := 1
    static D3DFILTER_LINEAR := 2
    static D3DFILTER_MIPNEAREST := 3
    static D3DFILTER_MIPLINEAR := 4
    static D3DFILTER_LINEARMIPNEAREST := 5
    static D3DFILTER_LINEARMIPLINEAR := 6
}
struct D3DTEXTUREBLEND extends Int32 {
    static D3DTBLEND_DECAL := 1
    static D3DTBLEND_MODULATE := 2
    static D3DTBLEND_DECALALPHA := 3
    static D3DTBLEND_MODULATEALPHA := 4
    static D3DTBLEND_DECALMASK := 5
    static D3DTBLEND_MODULATEMASK := 6
    static D3DTBLEND_COPY := 7
    static D3DTBLEND_ADD := 8
}
struct D3DANTIALIASMODE extends Int32 {
    static D3DANTIALIAS_NONE := 0
    static D3DANTIALIAS_SORTDEPENDENT := 1
    static D3DANTIALIAS_SORTINDEPENDENT := 2
}
struct D3DVERTEXTYPE extends Int32 {
    static D3DVT_VERTEX := 1
    static D3DVT_LVERTEX := 2
    static D3DVT_TLVERTEX := 3
}
struct D3DLIGHTSTATETYPE extends Int32 {
    static D3DLIGHTSTATE_MATERIAL := 1
    static D3DLIGHTSTATE_AMBIENT := 2
    static D3DLIGHTSTATE_COLORMODEL := 3
    static D3DLIGHTSTATE_FOGMODE := 4
    static D3DLIGHTSTATE_FOGSTART := 5
    static D3DLIGHTSTATE_FOGEND := 6
    static D3DLIGHTSTATE_FOGDENSITY := 7
    static D3DLIGHTSTATE_COLORVERTEX := 8
}
struct D3DSTATE {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            dlstLightStateType : D3DLIGHTSTATETYPE
            drstRenderStateType : D3DRENDERSTATETYPE
        }
    }
    struct _Anonymous2_e__Union {
        union {
            dwArg : UInt32[1]
            dvArg : Float32[1]
        }
    }
}
struct D3DMATRIXLOAD {
    hDestMatrix : UInt32
    hSrcMatrix : UInt32
}
struct D3DMATRIXMULTIPLY {
    hDestMatrix : UInt32
    hSrcMatrix1 : UInt32
    hSrcMatrix2 : UInt32
}
struct D3DPROCESSVERTICES {
    dwFlags : UInt32
    wStart : UInt16
    wDest : UInt16
    dwCount : UInt32
    dwReserved : UInt32
}
struct D3DTEXTUREMAGFILTER extends Int32 {
    static D3DTFG_POINT := 1
    static D3DTFG_LINEAR := 2
    static D3DTFG_FLATCUBIC := 3
    static D3DTFG_GAUSSIANCUBIC := 4
    static D3DTFG_ANISOTROPIC := 5
}
struct D3DTEXTUREMINFILTER extends Int32 {
    static D3DTFN_POINT := 1
    static D3DTFN_LINEAR := 2
    static D3DTFN_ANISOTROPIC := 3
}
struct D3DTEXTUREMIPFILTER extends Int32 {
    static D3DTFP_NONE := 1
    static D3DTFP_POINT := 2
    static D3DTFP_LINEAR := 3
}
struct D3DTRIANGLE {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    Anonymous3 : this._Anonymous3_e__Union
    wFlags : UInt16
    struct _Anonymous1_e__Union {
        union {
            v1 : UInt16
            wV1 : UInt16
        }
    }
    struct _Anonymous2_e__Union {
        union {
            v2 : UInt16
            wV2 : UInt16
        }
    }
    struct _Anonymous3_e__Union {
        union {
            v3 : UInt16
            wV3 : UInt16
        }
    }
}
struct D3DLINE {
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            v1 : UInt16
            wV1 : UInt16
        }
    }
    struct _Anonymous2_e__Union {
        union {
            v2 : UInt16
            wV2 : UInt16
        }
    }
}
struct D3DSPAN {
    wCount : UInt16
    wFirst : UInt16
}
struct D3DPOINT {
    wCount : UInt16
    wFirst : UInt16
}
struct D3DBRANCH {
    dwMask : UInt32
    dwValue : UInt32
    bNegate : BOOL
    dwOffset : UInt32
}
struct D3DSTATUS {
    dwFlags : UInt32
    dwStatus : UInt32
    drExtent : D3DRECT
}
struct D3DCLIPSTATUS {
    dwFlags : UInt32
    dwStatus : UInt32
    minx : Float32
    maxx : Float32
    miny : Float32
    maxy : Float32
    minz : Float32
    maxz : Float32
}
struct D3DSTATS {
    dwSize : UInt32
    dwTrianglesDrawn : UInt32
    dwLinesDrawn : UInt32
    dwPointsDrawn : UInt32
    dwSpansDrawn : UInt32
    dwVerticesProcessed : UInt32
}
struct D3DEXECUTEDATA {
    dwSize : UInt32
    dwVertexOffset : UInt32
    dwVertexCount : UInt32
    dwInstructionOffset : UInt32
    dwInstructionLength : UInt32
    dwHVertexOffset : UInt32
    dsStatus : D3DSTATUS
}
struct D3DVERTEXBUFFERDESC {
    dwSize : UInt32
    dwCaps : UInt32
    dwFVF : UInt32
    dwNumVertices : UInt32
}
struct D3DDP_PTRSTRIDE {
    lpvData : Struct.Ptr
    dwStride : UInt32
}
struct D3DDRAWPRIMITIVESTRIDEDDATA {
    position : D3DDP_PTRSTRIDE
    normal : D3DDP_PTRSTRIDE
    diffuse : D3DDP_PTRSTRIDE
    specular : D3DDP_PTRSTRIDE
    textureCoords : D3DDP_PTRSTRIDE[8]
}
struct D3DTRANSFORMCAPS {
    dwSize : UInt32
    dwCaps : UInt32
}
struct D3DLIGHTINGCAPS {
    dwSize : UInt32
    dwCaps : UInt32
    dwLightingModel : UInt32
    dwNumLights : UInt32
}
struct D3DPRIMCAPS {
    dwSize : UInt32
    dwMiscCaps : UInt32
    dwRasterCaps : UInt32
    dwZCmpCaps : UInt32
    dwSrcBlendCaps : UInt32
    dwDestBlendCaps : UInt32
    dwAlphaCmpCaps : UInt32
    dwShadeCaps : UInt32
    dwTextureCaps : UInt32
    dwTextureFilterCaps : UInt32
    dwTextureBlendCaps : UInt32
    dwTextureAddressCaps : UInt32
    dwStippleWidth : UInt32
    dwStippleHeight : UInt32
}
struct D3DDEVICEDESC {
    dwSize : UInt32
    dwFlags : UInt32
    dcmColorModel : UInt32
    dwDevCaps : UInt32
    dtcTransformCaps : D3DTRANSFORMCAPS
    bClipping : BOOL
    dlcLightingCaps : D3DLIGHTINGCAPS
    dpcLineCaps : D3DPRIMCAPS
    dpcTriCaps : D3DPRIMCAPS
    dwDeviceRenderBitDepth : UInt32
    dwDeviceZBufferBitDepth : UInt32
    dwMaxBufferSize : UInt32
    dwMaxVertexCount : UInt32
    dwMinTextureWidth : UInt32
    dwMinTextureHeight : UInt32
    dwMaxTextureWidth : UInt32
    dwMaxTextureHeight : UInt32
    dwMinStippleWidth : UInt32
    dwMaxStippleWidth : UInt32
    dwMinStippleHeight : UInt32
    dwMaxStippleHeight : UInt32
    dwMaxTextureRepeat : UInt32
    dwMaxTextureAspectRatio : UInt32
    dwMaxAnisotropy : UInt32
    dvGuardBandLeft : Float32
    dvGuardBandTop : Float32
    dvGuardBandRight : Float32
    dvGuardBandBottom : Float32
    dvExtentsAdjust : Float32
    dwStencilCaps : UInt32
    dwFVFCaps : UInt32
    dwTextureOpCaps : UInt32
    wMaxTextureBlendStages : UInt16
    wMaxSimultaneousTextures : UInt16
}
struct D3DDEVICEDESC7 {
    dwDevCaps : UInt32
    dpcLineCaps : D3DPRIMCAPS
    dpcTriCaps : D3DPRIMCAPS
    dwDeviceRenderBitDepth : UInt32
    dwDeviceZBufferBitDepth : UInt32
    dwMinTextureWidth : UInt32
    dwMinTextureHeight : UInt32
    dwMaxTextureWidth : UInt32
    dwMaxTextureHeight : UInt32
    dwMaxTextureRepeat : UInt32
    dwMaxTextureAspectRatio : UInt32
    dwMaxAnisotropy : UInt32
    dvGuardBandLeft : Float32
    dvGuardBandTop : Float32
    dvGuardBandRight : Float32
    dvGuardBandBottom : Float32
    dvExtentsAdjust : Float32
    dwStencilCaps : UInt32
    dwFVFCaps : UInt32
    dwTextureOpCaps : UInt32
    wMaxTextureBlendStages : UInt16
    wMaxSimultaneousTextures : UInt16
    dwMaxActiveLights : UInt32
    dvMaxVertexW : Float32
    deviceGUID : GUID
    wMaxUserClipPlanes : UInt16
    wMaxVertexBlendMatrices : UInt16
    dwVertexProcessingCaps : UInt32
    dwReserved1 : UInt32
    dwReserved2 : UInt32
    dwReserved3 : UInt32
    dwReserved4 : UInt32
}
struct LPD3DENUMDEVICESCALLBACK extends FunctionPointer {
    static Types := [GUID.Ptr, PSTR, PSTR, D3DDEVICEDESC.Ptr, D3DDEVICEDESC.Ptr, Struct.Ptr, HRESULT]
}
struct LPD3DENUMDEVICESCALLBACK7 extends FunctionPointer {
    static Types := [PSTR, PSTR, D3DDEVICEDESC7.Ptr, Struct.Ptr, HRESULT]
}
struct D3DFINDDEVICESEARCH {
    dwSize : UInt32
    dwFlags : UInt32
    bHardware : BOOL
    dcmColorModel : UInt32
    guid : GUID
    dwCaps : UInt32
    dpcPrimCaps : D3DPRIMCAPS
}
struct D3DFINDDEVICERESULT {
    dwSize : UInt32
    guid : GUID
    ddHwDesc : D3DDEVICEDESC
    ddSwDesc : D3DDEVICEDESC
}
struct D3DEXECUTEBUFFERDESC {
    dwSize : UInt32
    dwFlags : UInt32
    dwCaps : UInt32
    dwBufferSize : UInt32
    lpData : Struct.Ptr
}
