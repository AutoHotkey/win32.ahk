#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Devices.Properties\Types.ahk" {DEVPROPERTY}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT, PWSTR}

SwDeviceClose(hSwDevice1)
  => DllCall("CFGMGR32.dll\SwDeviceClose", HSWDEVICE, hSwDevice1, "void")
SwDeviceCreate(pszEnumeratorName, pszParentDeviceInstance, pCreateInfo, pProperties?, pCallback, pContext?, phSwDevice)
  => DllCall("CFGMGR32.dll\SwDeviceCreate", "Str", pszEnumeratorName, "Str", pszParentDeviceInstance, SW_DEVICE_CREATE_INFO.Ptr, pCreateInfo, UInt32, pProperties?.Length ?? 0, DEVPROPERTY.Ptr, pProperties?, SW_DEVICE_CREATE_CALLBACK, pCallback, Struct.Ptr, pContext?, HSWDEVICE.Ptr, phSwDevice, "HRESULT")
SwDeviceGetLifetime(hSwDevice1, pLifetime)
  => DllCall("CFGMGR32.dll\SwDeviceGetLifetime", HSWDEVICE, hSwDevice1, SW_DEVICE_LIFETIME.Ptr, pLifetime, "HRESULT")
SwDeviceInterfacePropertySet(hSwDevice1, pszDeviceInterfaceId, pProperties)
  => DllCall("CFGMGR32.dll\SwDeviceInterfacePropertySet", HSWDEVICE, hSwDevice1, "Str", pszDeviceInterfaceId, UInt32, pProperties.Length, DEVPROPERTY.Ptr, pProperties, "HRESULT")
SwDeviceInterfaceRegister(hSwDevice1, pInterfaceClassGuid, pszReferenceString?, pProperties?, fEnabled, ppszDeviceInterfaceId)
  => DllCall("CFGMGR32.dll\SwDeviceInterfaceRegister", HSWDEVICE, hSwDevice1, GUID.Ptr, pInterfaceClassGuid, "Str", pszReferenceString?, UInt32, pProperties?.Length ?? 0, DEVPROPERTY.Ptr, pProperties?, BOOL, fEnabled, PWSTR.Ptr, ppszDeviceInterfaceId, "HRESULT")
SwDeviceInterfaceSetState(hSwDevice1, pszDeviceInterfaceId, fEnabled)
  => DllCall("CFGMGR32.dll\SwDeviceInterfaceSetState", HSWDEVICE, hSwDevice1, "Str", pszDeviceInterfaceId, BOOL, fEnabled, "HRESULT")
SwDevicePropertySet(hSwDevice1, pProperties)
  => DllCall("CFGMGR32.dll\SwDevicePropertySet", HSWDEVICE, hSwDevice1, UInt32, pProperties.Length, DEVPROPERTY.Ptr, pProperties, "HRESULT")
SwDeviceSetLifetime(hSwDevice1, Lifetime)
  => DllCall("CFGMGR32.dll\SwDeviceSetLifetime", HSWDEVICE, hSwDevice1, SW_DEVICE_LIFETIME, Lifetime, "HRESULT")
SwMemFree(pMem)
  => DllCall("CFGMGR32.dll\SwMemFree", Struct.Ptr, pMem, "void")
