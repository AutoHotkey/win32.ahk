#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOLEAN, HRESULT, PWSTR}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct IWsbApplicationBackupSupport extends IUnknown {
    static IID := "{1EFF3510-4A27-46AD-B9E0-08332F0F4F6D}"
    CheckConsistency(wszWriterMetadata, wszComponentName, wszComponentLogicalPath, rgwszSourceVolumePath, rgwszSnapshotVolumePath, ppAsync)
      => ComCall(3, this.p, "Str", wszWriterMetadata, "Str", wszComponentName, "Str", wszComponentLogicalPath, UInt32, rgwszSnapshotVolumePath.Length, PWSTR.Ptr, rgwszSourceVolumePath, PWSTR.Ptr, rgwszSnapshotVolumePath, IWsbApplicationAsync.Ptr, ppAsync)
}
struct IWsbApplicationRestoreSupport extends IUnknown {
    static IID := "{8D3BDB38-4EE8-4718-85F9-C7DBC4AB77AA}"
    PreRestore(wszWriterMetadata, wszComponentName, wszComponentLogicalPath, bNoRollForward)
      => ComCall(3, this.p, "Str", wszWriterMetadata, "Str", wszComponentName, "Str", wszComponentLogicalPath, BOOLEAN, bNoRollForward)
    PostRestore(wszWriterMetadata, wszComponentName, wszComponentLogicalPath, bNoRollForward)
      => ComCall(4, this.p, "Str", wszWriterMetadata, "Str", wszComponentName, "Str", wszComponentLogicalPath, BOOLEAN, bNoRollForward)
    OrderComponents(rgComponentName, rgComponentLogicalPaths, prgComponentName, prgComponentLogicalPath)
      => ComCall(5, this.p, UInt32, prgComponentLogicalPath.Length, PWSTR.Ptr, rgComponentName, PWSTR.Ptr, rgComponentLogicalPaths, PWSTR.Ptr.Ptr, prgComponentName, PWSTR.Ptr.Ptr, prgComponentLogicalPath)
    IsRollForwardSupported(pbRollForwardSupported)
      => ComCall(6, this.p, UInt8.Ptr, pbRollForwardSupported)
}
struct IWsbApplicationAsync extends IUnknown {
    static IID := "{0843F6F7-895C-44A6-B0C2-05A5022AA3A1}"
    QueryStatus(phrResult)
      => ComCall(3, this.p, HRESULT.Ptr, phrResult)
    Abort()
      => ComCall(4, this.p)
}
struct WSB_OB_STATUS_ENTRY_PAIR_TYPE extends Int32 {
    static WSB_OB_ET_UNDEFINED := 0
    static WSB_OB_ET_STRING := 1
    static WSB_OB_ET_NUMBER := 2
    static WSB_OB_ET_DATETIME := 3
    static WSB_OB_ET_TIME := 4
    static WSB_OB_ET_SIZE := 5
    static WSB_OB_ET_MAX := 6
}
struct WSB_OB_STATUS_ENTRY_VALUE_TYPE_PAIR {
    m_wszObStatusEntryPairValue : PWSTR
    m_ObStatusEntryPairType : WSB_OB_STATUS_ENTRY_PAIR_TYPE
}
struct WSB_OB_STATUS_ENTRY {
    m_dwIcon : UInt32
    m_dwStatusEntryName : UInt32
    m_dwStatusEntryValue : UInt32
    m_cValueTypePair : UInt32
    m_rgValueTypePair : WSB_OB_STATUS_ENTRY_VALUE_TYPE_PAIR.Ptr
}
struct WSB_OB_STATUS_INFO {
    m_guidSnapinId : GUID
    m_cStatusEntry : UInt32
    m_rgStatusEntry : WSB_OB_STATUS_ENTRY.Ptr
}
struct WSB_OB_REGISTRATION_INFO {
    m_wszResourceDLL : PWSTR
    m_guidSnapinId : GUID
    m_dwProviderName : UInt32
    m_dwProviderIcon : UInt32
    m_bSupportsRemoting : BOOLEAN
}
