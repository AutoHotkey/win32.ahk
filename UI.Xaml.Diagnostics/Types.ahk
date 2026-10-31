#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, BSTR, HRESULT, PWSTR, RECT}
#Import "..\Graphics.Dxgi.Common\Types.ahk" {DXGI_ALPHA_MODE, DXGI_FORMAT}
#Import "..\System.Com\Types.ahk" {IUnknown, SAFEARRAY}
#Import "..\System.WinRT\Types.ahk" {IInspectable}

struct VisualMutationType extends Int32 {
    static Add := 0
    static Remove := 1
}
struct BaseValueSource extends Int32 {
    static BaseValueSourceUnknown := 0
    static BaseValueSourceDefault := 1
    static BaseValueSourceBuiltInStyle := 2
    static BaseValueSourceStyle := 3
    static BaseValueSourceLocal := 4
    static Inherited := 5
    static DefaultStyleTrigger := 6
    static TemplateTrigger := 7
    static StyleTrigger := 8
    static ImplicitStyleReference := 9
    static ParentTemplate := 10
    static ParentTemplateTrigger := 11
    static Animation := 12
    static Coercion := 13
    static BaseValueSourceVisualState := 14
}
struct SourceInfo {
    FileName : BSTR
    LineNumber : UInt32
    ColumnNumber : UInt32
    CharPosition : UInt32
    Hash : BSTR
}
struct ParentChildRelation {
    Parent : Int64
    Child : Int64
    ChildIndex : UInt32
}
struct VisualElement {
    Handle : Int64
    SrcInfo : SourceInfo
    Type : BSTR
    Name : BSTR
    NumChildren : UInt32
}
struct PropertyChainSource {
    Handle : Int64
    TargetType : BSTR
    Name : BSTR
    Source : BaseValueSource
    SrcInfo : SourceInfo
}
struct MetadataBit extends Int32 {
    static None := 0
    static IsValueHandle := 1
    static IsPropertyReadOnly := 2
    static IsValueCollection := 4
    static IsValueCollectionReadOnly := 8
    static IsValueBindingExpression := 16
    static IsValueNull := 32
    static IsValueHandleAndEvaluatedValue := 64
}
struct PropertyChainValue {
    Index : UInt32
    Type : BSTR
    DeclaringType : BSTR
    ValueType : BSTR
    ItemType : BSTR
    Value : BSTR
    Overridden : BOOL
    MetadataBits : Int64
    PropertyName : BSTR
    PropertyChainIndex : UInt32
}
struct EnumType {
    Name : BSTR
    ValueInts : SAFEARRAY.Ptr
    ValueStrings : SAFEARRAY.Ptr
}
struct CollectionElementValue {
    Index : UInt32
    ValueType : BSTR
    Value : BSTR
    MetadataBits : Int64
}
struct RenderTargetBitmapOptions extends Int32 {
    static RenderTarget := 0
    static RenderTargetAndChildren := 1
}
struct BitmapDescription {
    Width : UInt32
    Height : UInt32
    Format : DXGI_FORMAT
    AlphaMode : DXGI_ALPHA_MODE
}
struct ResourceType extends Int32 {
    static ResourceTypeStatic := 0
    static ResourceTypeTheme := 1
}
struct VisualElementState extends Int32 {
    static ErrorResolved := 0
    static ErrorResourceNotFound := 1
    static ErrorInvalidResource := 2
}
struct IVisualTreeServiceCallback extends IUnknown {
    static IID := "{AA7A8931-80E4-4FEC-8F3B-553F87B4966E}"
    OnVisualTreeChange(relation, element, mutationType)
      => ComCall(3, this.p, ParentChildRelation, relation, VisualElement, element, VisualMutationType, mutationType)
}
struct IVisualTreeServiceCallback2 extends IVisualTreeServiceCallback {
    static IID := "{BAD9EB88-AE77-4397-B948-5FA2DB0A19EA}"
    OnElementStateChanged(element, elementState, context)
      => ComCall(4, this.p, Int64, element, VisualElementState, elementState, "Str", context)
}
struct IVisualTreeService extends IUnknown {
    static IID := "{A593B11A-D17F-48BB-8F66-83910731C8A5}"
    AdviseVisualTreeChange(pCallback)
      => ComCall(3, this.p, IVisualTreeServiceCallback, pCallback)
    UnadviseVisualTreeChange(pCallback)
      => ComCall(4, this.p, IVisualTreeServiceCallback, pCallback)
    GetEnums(ppEnums)
      => ComCall(5, this.p, UInt32.Ptr, ppEnums.Length, EnumType.Ptr.Ptr, ppEnums)
    CreateInstance(typeName, value, pInstanceHandle)
      => ComCall(6, this.p, BSTR, typeName, BSTR, value, Int64.Ptr, pInstanceHandle)
    GetPropertyValuesChain(instanceHandle, ppPropertySources, ppPropertyValues)
      => ComCall(7, this.p, Int64, instanceHandle, UInt32.Ptr, ppPropertySources.Length, PropertyChainSource.Ptr.Ptr, ppPropertySources, UInt32.Ptr, ppPropertyValues.Length, PropertyChainValue.Ptr.Ptr, ppPropertyValues)
    SetProperty(instanceHandle, value, propertyIndex)
      => ComCall(8, this.p, Int64, instanceHandle, Int64, value, UInt32, propertyIndex)
    ClearProperty(instanceHandle, propertyIndex)
      => ComCall(9, this.p, Int64, instanceHandle, UInt32, propertyIndex)
    GetCollectionCount(instanceHandle, pCollectionSize)
      => ComCall(10, this.p, Int64, instanceHandle, UInt32.Ptr, pCollectionSize)
    GetCollectionElements(instanceHandle, startIndex, ppElementValues)
      => ComCall(11, this.p, Int64, instanceHandle, UInt32, startIndex, UInt32.Ptr, ppElementValues.Length, CollectionElementValue.Ptr.Ptr, ppElementValues)
    AddChild(parent, child, index)
      => ComCall(12, this.p, Int64, parent, Int64, child, UInt32, index)
    RemoveChild(parent, index)
      => ComCall(13, this.p, Int64, parent, UInt32, index)
    ClearChildren(parent)
      => ComCall(14, this.p, Int64, parent)
}
struct IXamlDiagnostics extends IUnknown {
    static IID := "{18C9E2B6-3F43-4116-9F2B-FF935D7770D2}"
    GetDispatcher(ppDispatcher)
      => ComCall(3, this.p, IInspectable.Ptr, ppDispatcher)
    GetUiLayer(ppLayer)
      => ComCall(4, this.p, IInspectable.Ptr, ppLayer)
    GetApplication(ppApplication)
      => ComCall(5, this.p, IInspectable.Ptr, ppApplication)
    GetIInspectableFromHandle(instanceHandle, ppInstance)
      => ComCall(6, this.p, Int64, instanceHandle, IInspectable.Ptr, ppInstance)
    GetHandleFromIInspectable(pInstance, pHandle)
      => ComCall(7, this.p, IInspectable, pInstance, Int64.Ptr, pHandle)
    HitTest(rect1, ppInstanceHandles)
      => ComCall(8, this.p, RECT, rect1, UInt32.Ptr, ppInstanceHandles.Length, Int64.Ptr.Ptr, ppInstanceHandles)
    RegisterInstance(pInstance, pInstanceHandle)
      => ComCall(9, this.p, IInspectable, pInstance, Int64.Ptr, pInstanceHandle)
    GetInitializationData(pInitializationData)
      => ComCall(10, this.p, BSTR.Ptr, pInitializationData)
}
struct IBitmapData extends IUnknown {
    static IID := "{D1A34EF2-CAD8-4635-A3D2-FCDA8D3F3CAF}"
    CopyBytesTo(sourceOffsetInBytes, pvBytes, numberOfBytesCopied)
      => ComCall(3, this.p, UInt32, sourceOffsetInBytes, UInt32, pvBytes.Length, UInt8.Ptr, pvBytes, UInt32.Ptr, numberOfBytesCopied)
    GetStride(pStride)
      => ComCall(4, this.p, UInt32.Ptr, pStride)
    GetBitmapDescription(pBitmapDescription)
      => ComCall(5, this.p, BitmapDescription.Ptr, pBitmapDescription)
    GetSourceBitmapDescription(pBitmapDescription)
      => ComCall(6, this.p, BitmapDescription.Ptr, pBitmapDescription)
}
struct IVisualTreeService2 extends IVisualTreeService {
    static IID := "{130F5136-EC43-4F61-89C7-9801A36D2E95}"
    GetPropertyIndex(object, propertyName, pPropertyIndex)
      => ComCall(15, this.p, Int64, object, "Str", propertyName, UInt32.Ptr, pPropertyIndex)
    GetProperty(object, propertyIndex, pValue)
      => ComCall(16, this.p, Int64, object, UInt32, propertyIndex, Int64.Ptr, pValue)
    ReplaceResource(resourceDictionary, key, newValue)
      => ComCall(17, this.p, Int64, resourceDictionary, Int64, key, Int64, newValue)
    RenderTargetBitmap(handle, options, maxPixelWidth, maxPixelHeight, ppBitmapData)
      => ComCall(18, this.p, Int64, handle, RenderTargetBitmapOptions, options, UInt32, maxPixelWidth, UInt32, maxPixelHeight, IBitmapData.Ptr, ppBitmapData)
}
struct IVisualTreeService3 extends IVisualTreeService2 {
    static IID := "{0E79C6E0-85A0-4BE8-B41A-655CF1FD19BD}"
    ResolveResource(resourceContext, resourceName, resourceType1, propertyIndex)
      => ComCall(19, this.p, Int64, resourceContext, "Str", resourceName, ResourceType, resourceType1, UInt32, propertyIndex)
    GetDictionaryItem(dictionaryHandle, resourceName, resourceIsImplicitStyle, resourceHandle)
      => ComCall(20, this.p, Int64, dictionaryHandle, "Str", resourceName, BOOL, resourceIsImplicitStyle, Int64.Ptr, resourceHandle)
    AddDictionaryItem(dictionaryHandle, resourceKey, resourceHandle)
      => ComCall(21, this.p, Int64, dictionaryHandle, Int64, resourceKey, Int64, resourceHandle)
    RemoveDictionaryItem(dictionaryHandle, resourceKey)
      => ComCall(22, this.p, Int64, dictionaryHandle, Int64, resourceKey)
}
