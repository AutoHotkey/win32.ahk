#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Devices.Properties\Types.ahk" {DEVPROPCOMPKEY, DEVPROPERTY, DEVPROPSTORE}
#Import "..\Foundation\Types.ahk" {DEVPROPKEY, HRESULT, PWSTR}

DevCloseObjectQuery(hDevQuery1)
  => DllCall("api-ms-win-devices-query-l1-1-0.dll\DevCloseObjectQuery", HDEVQUERY, hDevQuery1, "void")
DevCreateObjectQuery(ObjectType, QueryFlags, pRequestedProperties?, pFilter?, pCallback, pContext?, phDevQuery)
  => DllCall("api-ms-win-devices-query-l1-1-0.dll\DevCreateObjectQuery", DEV_OBJECT_TYPE, ObjectType, UInt32, QueryFlags, UInt32, pRequestedProperties?.Length ?? 0, DEVPROPCOMPKEY.Ptr, pRequestedProperties?, UInt32, pFilter?.Length ?? 0, DEVPROP_FILTER_EXPRESSION.Ptr, pFilter?, PDEV_QUERY_RESULT_CALLBACK, pCallback, Struct.Ptr, pContext?, HDEVQUERY.Ptr, phDevQuery, "HRESULT")
DevCreateObjectQueryEx(ObjectType, QueryFlags, pRequestedProperties?, pFilter?, pExtendedParameters?, pCallback, pContext?, phDevQuery)
  => DllCall("api-ms-win-devices-query-l1-1-1.dll\DevCreateObjectQueryEx", DEV_OBJECT_TYPE, ObjectType, UInt32, QueryFlags, UInt32, pRequestedProperties?.Length ?? 0, DEVPROPCOMPKEY.Ptr, pRequestedProperties?, UInt32, pFilter?.Length ?? 0, DEVPROP_FILTER_EXPRESSION.Ptr, pFilter?, UInt32, pExtendedParameters?.Length ?? 0, DEV_QUERY_PARAMETER.Ptr, pExtendedParameters?, PDEV_QUERY_RESULT_CALLBACK, pCallback, Struct.Ptr, pContext?, HDEVQUERY.Ptr, phDevQuery, "HRESULT")
DevCreateObjectQueryFromId(ObjectType, pszObjectId, QueryFlags, pRequestedProperties?, pFilter?, pCallback, pContext?, phDevQuery)
  => DllCall("api-ms-win-devices-query-l1-1-0.dll\DevCreateObjectQueryFromId", DEV_OBJECT_TYPE, ObjectType, "Str", pszObjectId, UInt32, QueryFlags, UInt32, pRequestedProperties?.Length ?? 0, DEVPROPCOMPKEY.Ptr, pRequestedProperties?, UInt32, pFilter?.Length ?? 0, DEVPROP_FILTER_EXPRESSION.Ptr, pFilter?, PDEV_QUERY_RESULT_CALLBACK, pCallback, Struct.Ptr, pContext?, HDEVQUERY.Ptr, phDevQuery, "HRESULT")
DevCreateObjectQueryFromIdEx(ObjectType, pszObjectId, QueryFlags, pRequestedProperties?, pFilter?, pExtendedParameters?, pCallback, pContext?, phDevQuery)
  => DllCall("api-ms-win-devices-query-l1-1-1.dll\DevCreateObjectQueryFromIdEx", DEV_OBJECT_TYPE, ObjectType, "Str", pszObjectId, UInt32, QueryFlags, UInt32, pRequestedProperties?.Length ?? 0, DEVPROPCOMPKEY.Ptr, pRequestedProperties?, UInt32, pFilter?.Length ?? 0, DEVPROP_FILTER_EXPRESSION.Ptr, pFilter?, UInt32, pExtendedParameters?.Length ?? 0, DEV_QUERY_PARAMETER.Ptr, pExtendedParameters?, PDEV_QUERY_RESULT_CALLBACK, pCallback, Struct.Ptr, pContext?, HDEVQUERY.Ptr, phDevQuery, "HRESULT")
DevCreateObjectQueryFromIds(ObjectType, pszzObjectIds, QueryFlags, pRequestedProperties?, pFilter?, pCallback, pContext?, phDevQuery)
  => DllCall("api-ms-win-devices-query-l1-1-0.dll\DevCreateObjectQueryFromIds", DEV_OBJECT_TYPE, ObjectType, "Str", pszzObjectIds, UInt32, QueryFlags, UInt32, pRequestedProperties?.Length ?? 0, DEVPROPCOMPKEY.Ptr, pRequestedProperties?, UInt32, pFilter?.Length ?? 0, DEVPROP_FILTER_EXPRESSION.Ptr, pFilter?, PDEV_QUERY_RESULT_CALLBACK, pCallback, Struct.Ptr, pContext?, HDEVQUERY.Ptr, phDevQuery, "HRESULT")
DevCreateObjectQueryFromIdsEx(ObjectType, pszzObjectIds, QueryFlags, pRequestedProperties?, pFilter?, pExtendedParameters?, pCallback, pContext?, phDevQuery)
  => DllCall("api-ms-win-devices-query-l1-1-1.dll\DevCreateObjectQueryFromIdsEx", DEV_OBJECT_TYPE, ObjectType, "Str", pszzObjectIds, UInt32, QueryFlags, UInt32, pRequestedProperties?.Length ?? 0, DEVPROPCOMPKEY.Ptr, pRequestedProperties?, UInt32, pFilter?.Length ?? 0, DEVPROP_FILTER_EXPRESSION.Ptr, pFilter?, UInt32, pExtendedParameters?.Length ?? 0, DEV_QUERY_PARAMETER.Ptr, pExtendedParameters?, PDEV_QUERY_RESULT_CALLBACK, pCallback, Struct.Ptr, pContext?, HDEVQUERY.Ptr, phDevQuery, "HRESULT")
DevFindProperty(pKey, Store, pszLocaleName, pProperties?)
  => DllCall("api-ms-win-devices-query-l1-1-0.dll\DevFindProperty", DEVPROPKEY.Ptr, pKey, DEVPROPSTORE, Store, "Str", pszLocaleName, UInt32, pProperties?.Length ?? 0, DEVPROPERTY.Ptr, pProperties?, DEVPROPERTY.Ptr)
DevFreeObjectProperties(pProperties)
  => DllCall("api-ms-win-devices-query-l1-1-0.dll\DevFreeObjectProperties", UInt32, pProperties.Length, DEVPROPERTY.Ptr, pProperties, "void")
DevFreeObjects(pObjects)
  => DllCall("api-ms-win-devices-query-l1-1-0.dll\DevFreeObjects", UInt32, pObjects.Length, DEV_OBJECT.Ptr, pObjects, "void")
DevGetObjectProperties(ObjectType, pszObjectId, QueryFlags, pRequestedProperties, pcPropertyCount, ppProperties)
  => DllCall("api-ms-win-devices-query-l1-1-0.dll\DevGetObjectProperties", DEV_OBJECT_TYPE, ObjectType, "Str", pszObjectId, UInt32, QueryFlags, UInt32, pRequestedProperties.Length, DEVPROPCOMPKEY.Ptr, pRequestedProperties, UInt32.Ptr, pcPropertyCount, DEVPROPERTY.Ptr.Ptr, ppProperties, "HRESULT")
DevGetObjectPropertiesEx(ObjectType, pszObjectId, QueryFlags, pRequestedProperties, pExtendedParameters?, pcPropertyCount, ppProperties)
  => DllCall("api-ms-win-devices-query-l1-1-1.dll\DevGetObjectPropertiesEx", DEV_OBJECT_TYPE, ObjectType, "Str", pszObjectId, UInt32, QueryFlags, UInt32, pRequestedProperties.Length, DEVPROPCOMPKEY.Ptr, pRequestedProperties, UInt32, pExtendedParameters?.Length ?? 0, DEV_QUERY_PARAMETER.Ptr, pExtendedParameters?, UInt32.Ptr, pcPropertyCount, DEVPROPERTY.Ptr.Ptr, ppProperties, "HRESULT")
DevGetObjects(ObjectType, QueryFlags, pRequestedProperties?, pFilter?, pcObjectCount, ppObjects)
  => DllCall("api-ms-win-devices-query-l1-1-0.dll\DevGetObjects", DEV_OBJECT_TYPE, ObjectType, UInt32, QueryFlags, UInt32, pRequestedProperties?.Length ?? 0, DEVPROPCOMPKEY.Ptr, pRequestedProperties?, UInt32, pFilter?.Length ?? 0, DEVPROP_FILTER_EXPRESSION.Ptr, pFilter?, UInt32.Ptr, pcObjectCount, DEV_OBJECT.Ptr.Ptr, ppObjects, "HRESULT")
DevGetObjectsEx(ObjectType, QueryFlags, pRequestedProperties?, pFilter?, pExtendedParameters?, pcObjectCount, ppObjects)
  => DllCall("api-ms-win-devices-query-l1-1-1.dll\DevGetObjectsEx", DEV_OBJECT_TYPE, ObjectType, UInt32, QueryFlags, UInt32, pRequestedProperties?.Length ?? 0, DEVPROPCOMPKEY.Ptr, pRequestedProperties?, UInt32, pFilter?.Length ?? 0, DEVPROP_FILTER_EXPRESSION.Ptr, pFilter?, UInt32, pExtendedParameters?.Length ?? 0, DEV_QUERY_PARAMETER.Ptr, pExtendedParameters?, UInt32.Ptr, pcObjectCount, DEV_OBJECT.Ptr.Ptr, ppObjects, "HRESULT")
