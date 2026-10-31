#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HRESULT, PSTR}
#Import "..\Graphics.Direct3D\Types.ahk" {D3D_SHADER_MACRO, ID3DBlob, ID3DInclude}

struct pD3DCompile extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, PSTR, D3D_SHADER_MACRO.Ptr, ID3DInclude, PSTR, PSTR, UInt32, UInt32, ID3DBlob.Ptr, ID3DBlob.Ptr, HRESULT]
}
struct pD3DPreprocess extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, PSTR, D3D_SHADER_MACRO.Ptr, ID3DInclude, ID3DBlob.Ptr, ID3DBlob.Ptr, HRESULT]
}
struct pD3DDisassemble extends FunctionPointer {
    static Types := [Struct.Ptr, IntPtr, UInt32, PSTR, ID3DBlob.Ptr, HRESULT]
}
struct D3DCOMPILER_STRIP_FLAGS extends Int32 {
    static D3DCOMPILER_STRIP_REFLECTION_DATA := 1
    static D3DCOMPILER_STRIP_DEBUG_INFO := 2
    static D3DCOMPILER_STRIP_TEST_BLOBS := 4
    static D3DCOMPILER_STRIP_PRIVATE_DATA := 8
    static D3DCOMPILER_STRIP_ROOT_SIGNATURE := 16
}
struct D3D_BLOB_PART extends Int32 {
    static D3D_BLOB_INPUT_SIGNATURE_BLOB := 0
    static D3D_BLOB_OUTPUT_SIGNATURE_BLOB := 1
    static D3D_BLOB_INPUT_AND_OUTPUT_SIGNATURE_BLOB := 2
    static D3D_BLOB_PATCH_CONSTANT_SIGNATURE_BLOB := 3
    static D3D_BLOB_ALL_SIGNATURE_BLOB := 4
    static D3D_BLOB_DEBUG_INFO := 5
    static D3D_BLOB_LEGACY_SHADER := 6
    static D3D_BLOB_XNA_PREPASS_SHADER := 7
    static D3D_BLOB_XNA_SHADER := 8
    static D3D_BLOB_PDB := 9
    static D3D_BLOB_PRIVATE_DATA := 10
    static D3D_BLOB_ROOT_SIGNATURE := 11
    static D3D_BLOB_DEBUG_NAME := 12
    static D3D_BLOB_TEST_ALTERNATE_SHADER := 32768
    static D3D_BLOB_TEST_COMPILE_DETAILS := 32769
    static D3D_BLOB_TEST_COMPILE_PERF := 32770
    static D3D_BLOB_TEST_COMPILE_REPORT := 32771
}
struct D3D_SHADER_DATA {
    pBytecode : Struct.Ptr
    BytecodeLength : IntPtr
}
