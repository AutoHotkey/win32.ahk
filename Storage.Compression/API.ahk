#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL}

CloseCompressor(CompressorHandle)
  => DllCall("Cabinet.dll\CloseCompressor", COMPRESSOR_HANDLE, CompressorHandle, BOOL)
CloseDecompressor(DecompressorHandle)
  => DllCall("Cabinet.dll\CloseDecompressor", DECOMPRESSOR_HANDLE, DecompressorHandle, BOOL)
Compress(CompressorHandle, UncompressedData?, CompressedBuffer?, CompressedDataSize)
  => DllCall("Cabinet.dll\Compress", COMPRESSOR_HANDLE, CompressorHandle, Struct.Ptr, UncompressedData?, IntPtr, UncompressedData?.Size ?? 0, Struct.Ptr, CompressedBuffer?, IntPtr, CompressedBuffer?.Size ?? 0, IntPtr.Ptr, CompressedDataSize, BOOL)
CreateCompressor(Algorithm, AllocationRoutines?, CompressorHandle)
  => DllCall("Cabinet.dll\CreateCompressor", COMPRESS_ALGORITHM, Algorithm, COMPRESS_ALLOCATION_ROUTINES.Ptr, AllocationRoutines?, COMPRESSOR_HANDLE.Ptr, CompressorHandle, BOOL)
CreateDecompressor(Algorithm, AllocationRoutines?, DecompressorHandle)
  => DllCall("Cabinet.dll\CreateDecompressor", COMPRESS_ALGORITHM, Algorithm, COMPRESS_ALLOCATION_ROUTINES.Ptr, AllocationRoutines?, DECOMPRESSOR_HANDLE.Ptr, DecompressorHandle, BOOL)
Decompress(DecompressorHandle, CompressedData?, UncompressedBuffer?, UncompressedDataSize?)
  => DllCall("Cabinet.dll\Decompress", DECOMPRESSOR_HANDLE, DecompressorHandle, Struct.Ptr, CompressedData?, IntPtr, CompressedData?.Size ?? 0, Struct.Ptr, UncompressedBuffer?, IntPtr, UncompressedBuffer?.Size ?? 0, IntPtr.Ptr, UncompressedDataSize?, BOOL)
QueryCompressorInformation(CompressorHandle, CompressInformationClass, CompressInformation)
  => DllCall("Cabinet.dll\QueryCompressorInformation", COMPRESSOR_HANDLE, CompressorHandle, COMPRESS_INFORMATION_CLASS, CompressInformationClass, Struct.Ptr, CompressInformation, IntPtr, CompressInformation.Size, BOOL)
QueryDecompressorInformation(DecompressorHandle, CompressInformationClass, CompressInformation)
  => DllCall("Cabinet.dll\QueryDecompressorInformation", DECOMPRESSOR_HANDLE, DecompressorHandle, COMPRESS_INFORMATION_CLASS, CompressInformationClass, Struct.Ptr, CompressInformation, IntPtr, CompressInformation.Size, BOOL)
ResetCompressor(CompressorHandle)
  => DllCall("Cabinet.dll\ResetCompressor", COMPRESSOR_HANDLE, CompressorHandle, BOOL)
ResetDecompressor(DecompressorHandle)
  => DllCall("Cabinet.dll\ResetDecompressor", DECOMPRESSOR_HANDLE, DecompressorHandle, BOOL)
SetCompressorInformation(CompressorHandle, CompressInformationClass, CompressInformation)
  => DllCall("Cabinet.dll\SetCompressorInformation", COMPRESSOR_HANDLE, CompressorHandle, COMPRESS_INFORMATION_CLASS, CompressInformationClass, Struct.Ptr, CompressInformation, IntPtr, CompressInformation.Size, BOOL)
SetDecompressorInformation(DecompressorHandle, CompressInformationClass, CompressInformation)
  => DllCall("Cabinet.dll\SetDecompressorInformation", DECOMPRESSOR_HANDLE, DecompressorHandle, COMPRESS_INFORMATION_CLASS, CompressInformationClass, Struct.Ptr, CompressInformation, IntPtr, CompressInformation.Size, BOOL)
