#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

WMCreateBackupRestorer(pCallback, ppBackup)
  => DllCall("WMVCore.dll\WMCreateBackupRestorer", IUnknown, pCallback, IWMLicenseBackup.Ptr, ppBackup, "HRESULT")
WMCreateEditor(ppEditor)
  => DllCall("WMVCore.dll\WMCreateEditor", IWMMetadataEditor.Ptr, ppEditor, "HRESULT")
WMCreateIndexer(ppIndexer)
  => DllCall("WMVCore.dll\WMCreateIndexer", IWMIndexer.Ptr, ppIndexer, "HRESULT")
WMCreateProfileManager(ppProfileManager)
  => DllCall("WMVCore.dll\WMCreateProfileManager", IWMProfileManager.Ptr, ppProfileManager, "HRESULT")
WMCreateReader(pUnkCert, dwRights, ppReader)
  => DllCall("WMVCore.dll\WMCreateReader", IUnknown, pUnkCert, UInt32, dwRights, IWMReader.Ptr, ppReader, "HRESULT")
WMCreateSyncReader(pUnkCert, dwRights, ppSyncReader)
  => DllCall("WMVCore.dll\WMCreateSyncReader", IUnknown, pUnkCert, UInt32, dwRights, IWMSyncReader.Ptr, ppSyncReader, "HRESULT")
WMCreateWriter(pUnkCert, ppWriter)
  => DllCall("WMVCore.dll\WMCreateWriter", IUnknown, pUnkCert, IWMWriter.Ptr, ppWriter, "HRESULT")
WMCreateWriterFileSink(ppSink)
  => DllCall("WMVCore.dll\WMCreateWriterFileSink", IWMWriterFileSink.Ptr, ppSink, "HRESULT")
WMCreateWriterNetworkSink(ppSink)
  => DllCall("WMVCore.dll\WMCreateWriterNetworkSink", IWMWriterNetworkSink.Ptr, ppSink, "HRESULT")
WMCreateWriterPushSink(ppSink)
  => DllCall("WMVCore.dll\WMCreateWriterPushSink", IWMWriterPushSink.Ptr, ppSink, "HRESULT")
WMIsContentProtected(pwszFileName, pfIsProtected)
  => DllCall("WMVCore.dll\WMIsContentProtected", "Str", pwszFileName, BOOL.Ptr, pfIsProtected, "HRESULT")
