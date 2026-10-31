#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

CreateVssBackupComponentsInternal(ppBackup)
  => DllCall("VSSAPI.dll\CreateVssBackupComponentsInternal", IVssBackupComponents.Ptr, ppBackup, "HRESULT")
CreateVssExamineWriterMetadataInternal(bstrXML, ppMetadata)
  => DllCall("VSSAPI.dll\CreateVssExamineWriterMetadataInternal", BSTR, bstrXML, IVssExamineWriterMetadata.Ptr, ppMetadata, "HRESULT")
CreateVssExpressWriterInternal(ppWriter)
  => DllCall("VSSAPI.dll\CreateVssExpressWriterInternal", IVssExpressWriter.Ptr, ppWriter, "HRESULT")
GetProviderMgmtInterfaceInternal(ProviderId, InterfaceId, ppItf)
  => DllCall("VSSAPI.dll\GetProviderMgmtInterfaceInternal", GUID, ProviderId, GUID, InterfaceId, IUnknown.Ptr, ppItf, "HRESULT")
IsVolumeSnapshottedInternal(pwszVolumeName, pbSnapshotsPresent, plSnapshotCapability)
  => DllCall("VSSAPI.dll\IsVolumeSnapshottedInternal", UInt16.Ptr, pwszVolumeName, BOOL.Ptr, pbSnapshotsPresent, Int32.Ptr, plSnapshotCapability, "HRESULT")
ShouldBlockRevertInternal(wszVolumeName, pbBlock)
  => DllCall("VSSAPI.dll\ShouldBlockRevertInternal", "Str", wszVolumeName, Boolean8.Ptr, pbBlock, "HRESULT")
VssFreeSnapshotPropertiesInternal(pProp)
  => DllCall("VSSAPI.dll\VssFreeSnapshotPropertiesInternal", VSS_SNAPSHOT_PROP.Ptr, pProp, "void")
