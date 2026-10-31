#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {HANDLE}

PssCaptureSnapshot(ProcessHandle, CaptureFlags, ThreadContextFlags?, SnapshotHandle)
  => DllCall("KERNEL32.dll\PssCaptureSnapshot", HANDLE, ProcessHandle, PSS_CAPTURE_FLAGS, CaptureFlags, UInt32, ThreadContextFlags?, HPSS.Ptr, SnapshotHandle, UInt32)
PssDuplicateSnapshot(SourceProcessHandle, SnapshotHandle, TargetProcessHandle, TargetSnapshotHandle, Flags?)
  => DllCall("KERNEL32.dll\PssDuplicateSnapshot", HANDLE, SourceProcessHandle, HPSS, SnapshotHandle, HANDLE, TargetProcessHandle, HPSS.Ptr, TargetSnapshotHandle, PSS_DUPLICATE_FLAGS, Flags?, UInt32)
PssFreeSnapshot(ProcessHandle, SnapshotHandle)
  => DllCall("KERNEL32.dll\PssFreeSnapshot", HANDLE, ProcessHandle, HPSS, SnapshotHandle, UInt32)
PssQuerySnapshot(SnapshotHandle, InformationClass, Buffer)
  => DllCall("KERNEL32.dll\PssQuerySnapshot", HPSS, SnapshotHandle, PSS_QUERY_INFORMATION_CLASS, InformationClass, Struct.Ptr, Buffer, UInt32, Buffer.Size, UInt32)
PssWalkMarkerCreate(Allocator?, WalkMarkerHandle)
  => DllCall("KERNEL32.dll\PssWalkMarkerCreate", PSS_ALLOCATOR.Ptr, Allocator?, HPSSWALK.Ptr, WalkMarkerHandle, UInt32)
PssWalkMarkerFree(WalkMarkerHandle)
  => DllCall("KERNEL32.dll\PssWalkMarkerFree", HPSSWALK, WalkMarkerHandle, UInt32)
PssWalkMarkerGetPosition(WalkMarkerHandle, Position)
  => DllCall("KERNEL32.dll\PssWalkMarkerGetPosition", HPSSWALK, WalkMarkerHandle, IntPtr.Ptr, Position, UInt32)
PssWalkMarkerSeekToBeginning(WalkMarkerHandle)
  => DllCall("KERNEL32.dll\PssWalkMarkerSeekToBeginning", HPSSWALK, WalkMarkerHandle, UInt32)
PssWalkMarkerSetPosition(WalkMarkerHandle, Position)
  => DllCall("KERNEL32.dll\PssWalkMarkerSetPosition", HPSSWALK, WalkMarkerHandle, IntPtr, Position, UInt32)
PssWalkSnapshot(SnapshotHandle, InformationClass, WalkMarkerHandle, Buffer?)
  => DllCall("KERNEL32.dll\PssWalkSnapshot", HPSS, SnapshotHandle, PSS_WALK_INFORMATION_CLASS, InformationClass, HPSSWALK, WalkMarkerHandle, Struct.Ptr, Buffer?, UInt32, Buffer?.Length ?? 0, UInt32)
