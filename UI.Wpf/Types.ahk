#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BSTR, HRESULT, VARIANT_BOOL}
#Import "..\Graphics.Dwm\Types.ahk" {MilMatrix3x2D}
#Import "..\Graphics.Imaging\Types.ahk" {IWICBitmapSource}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct MilRectD {
    left : Float64
    top : Float64
    right : Float64
    bottom : Float64
}
struct MilPoint2D {
    X : Float64
    Y : Float64
}
struct MILMatrixF {
    _11 : Float64
    _12 : Float64
    _13 : Float64
    _14 : Float64
    _21 : Float64
    _22 : Float64
    _23 : Float64
    _24 : Float64
    _31 : Float64
    _32 : Float64
    _33 : Float64
    _34 : Float64
    _41 : Float64
    _42 : Float64
    _43 : Float64
    _44 : Float64
}
struct IMILBitmapEffectConnectorInfo extends IUnknown {
    static IID := "{F66D2E4B-B46B-42FC-859E-3DA0ECDB3C43}"
    GetIndex(puiIndex)
      => ComCall(3, this.p, UInt32.Ptr, puiIndex)
    GetOptimalFormat(pFormat)
      => ComCall(4, this.p, GUID.Ptr, pFormat)
    GetNumberFormats(pulNumberFormats)
      => ComCall(5, this.p, UInt32.Ptr, pulNumberFormats)
    GetFormat(ulIndex, pFormat)
      => ComCall(6, this.p, UInt32, ulIndex, GUID.Ptr, pFormat)
}
struct IMILBitmapEffectConnectionsInfo extends IUnknown {
    static IID := "{476B538A-C765-4237-BA4A-D6A880FF0CFC}"
    GetNumberInputs(puiNumInputs)
      => ComCall(3, this.p, UInt32.Ptr, puiNumInputs)
    GetNumberOutputs(puiNumOutputs)
      => ComCall(4, this.p, UInt32.Ptr, puiNumOutputs)
    GetInputConnectorInfo(uiIndex, ppConnectorInfo)
      => ComCall(5, this.p, UInt32, uiIndex, IMILBitmapEffectConnectorInfo.Ptr, ppConnectorInfo)
    GetOutputConnectorInfo(uiIndex, ppConnectorInfo)
      => ComCall(6, this.p, UInt32, uiIndex, IMILBitmapEffectConnectorInfo.Ptr, ppConnectorInfo)
}
struct IMILBitmapEffectConnections extends IUnknown {
    static IID := "{C2B5D861-9B1A-4374-89B0-DEC4874D6A81}"
    GetInputConnector(uiIndex, ppConnector)
      => ComCall(3, this.p, UInt32, uiIndex, IMILBitmapEffectInputConnector.Ptr, ppConnector)
    GetOutputConnector(uiIndex, ppConnector)
      => ComCall(4, this.p, UInt32, uiIndex, IMILBitmapEffectOutputConnector.Ptr, ppConnector)
}
struct IMILBitmapEffect extends IUnknown {
    static IID := "{8A6FF321-C944-4A1B-9944-9954AF301258}"
    GetOutput(uiIndex, pContext, ppBitmapSource)
      => ComCall(3, this.p, UInt32, uiIndex, IMILBitmapEffectRenderContext, pContext, IWICBitmapSource.Ptr, ppBitmapSource)
    GetParentEffect(ppParentEffect)
      => ComCall(4, this.p, IMILBitmapEffectGroup.Ptr, ppParentEffect)
    SetInputSource(uiIndex, pBitmapSource)
      => ComCall(5, this.p, UInt32, uiIndex, IWICBitmapSource, pBitmapSource)
}
struct IMILBitmapEffectImpl extends IUnknown {
    static IID := "{CC2468F2-9936-47BE-B4AF-06B5DF5DBCBB}"
    IsInPlaceModificationAllowed(pOutputConnector, pfModifyInPlace)
      => ComCall(3, this.p, IMILBitmapEffectOutputConnector, pOutputConnector, VARIANT_BOOL.Ptr, pfModifyInPlace)
    SetParentEffect(pParentEffect)
      => ComCall(4, this.p, IMILBitmapEffectGroup, pParentEffect)
    GetInputSource(uiIndex, ppBitmapSource)
      => ComCall(5, this.p, UInt32, uiIndex, IWICBitmapSource.Ptr, ppBitmapSource)
    GetInputSourceBounds(uiIndex, pRect)
      => ComCall(6, this.p, UInt32, uiIndex, MilRectD.Ptr, pRect)
    GetInputBitmapSource(uiIndex, pRenderContext, pfModifyInPlace, ppBitmapSource)
      => ComCall(7, this.p, UInt32, uiIndex, IMILBitmapEffectRenderContext, pRenderContext, VARIANT_BOOL.Ptr, pfModifyInPlace, IWICBitmapSource.Ptr, ppBitmapSource)
    GetOutputBitmapSource(uiIndex, pRenderContext, pfModifyInPlace, ppBitmapSource)
      => ComCall(8, this.p, UInt32, uiIndex, IMILBitmapEffectRenderContext, pRenderContext, VARIANT_BOOL.Ptr, pfModifyInPlace, IWICBitmapSource.Ptr, ppBitmapSource)
    Initialize(pInner)
      => ComCall(9, this.p, IUnknown, pInner)
}
struct IMILBitmapEffectGroup extends IUnknown {
    static IID := "{2F952360-698A-4AC6-81A1-BCFDF08EB8E8}"
    GetInteriorInputConnector(uiIndex, ppConnector)
      => ComCall(3, this.p, UInt32, uiIndex, IMILBitmapEffectOutputConnector.Ptr, ppConnector)
    GetInteriorOutputConnector(uiIndex, ppConnector)
      => ComCall(4, this.p, UInt32, uiIndex, IMILBitmapEffectInputConnector.Ptr, ppConnector)
    Add(pEffect)
      => ComCall(5, this.p, IMILBitmapEffect, pEffect)
}
struct IMILBitmapEffectGroupImpl extends IUnknown {
    static IID := "{78FED518-1CFC-4807-8B85-6B6E51398F62}"
    Preprocess(pContext)
      => ComCall(3, this.p, IMILBitmapEffectRenderContext, pContext)
    GetNumberChildren(puiNumberChildren)
      => ComCall(4, this.p, UInt32.Ptr, puiNumberChildren)
    GetChildren(pChildren)
      => ComCall(5, this.p, IMILBitmapEffects.Ptr, pChildren)
}
struct IMILBitmapEffectRenderContext extends IUnknown {
    static IID := "{12A2EC7E-2D33-44B2-B334-1ABB7846E390}"
    SetOutputPixelFormat(format)
      => ComCall(3, this.p, GUID.Ptr, format)
    GetOutputPixelFormat(pFormat)
      => ComCall(4, this.p, GUID.Ptr, pFormat)
    SetUseSoftwareRenderer(fSoftware)
      => ComCall(5, this.p, VARIANT_BOOL, fSoftware)
    SetInitialTransform(pMatrix)
      => ComCall(6, this.p, MILMatrixF.Ptr, pMatrix)
    GetFinalTransform(pMatrix)
      => ComCall(7, this.p, MILMatrixF.Ptr, pMatrix)
    SetOutputDPI(dblDpiX, dblDpiY)
      => ComCall(8, this.p, Float64, dblDpiX, Float64, dblDpiY)
    GetOutputDPI(pdblDpiX, pdblDpiY)
      => ComCall(9, this.p, Float64.Ptr, pdblDpiX, Float64.Ptr, pdblDpiY)
    SetRegionOfInterest(pRect)
      => ComCall(10, this.p, MilRectD.Ptr, pRect)
}
struct IMILBitmapEffectRenderContextImpl extends IUnknown {
    static IID := "{4D25ACCB-797D-4FD2-B128-DFFEFF84FCC3}"
    GetUseSoftwareRenderer(pfSoftware)
      => ComCall(3, this.p, VARIANT_BOOL.Ptr, pfSoftware)
    GetTransform(pMatrix)
      => ComCall(4, this.p, MILMatrixF.Ptr, pMatrix)
    UpdateTransform(pMatrix)
      => ComCall(5, this.p, MILMatrixF.Ptr, pMatrix)
    GetOutputBounds(pRect)
      => ComCall(6, this.p, MilRectD.Ptr, pRect)
    UpdateOutputBounds(pRect)
      => ComCall(7, this.p, MilRectD.Ptr, pRect)
}
struct IMILBitmapEffectFactory extends IUnknown {
    static IID := "{33A9DF34-A403-4EC7-B07E-BC0682370845}"
    CreateEffect(pguidEffect, ppEffect)
      => ComCall(3, this.p, GUID.Ptr, pguidEffect, IMILBitmapEffect.Ptr, ppEffect)
    CreateContext(ppContext)
      => ComCall(4, this.p, IMILBitmapEffectRenderContext.Ptr, ppContext)
    CreateEffectOuter(ppEffect)
      => ComCall(5, this.p, IMILBitmapEffect.Ptr, ppEffect)
}
struct IMILBitmapEffectPrimitive extends IUnknown {
    static IID := "{67E31025-3091-4DFC-98D6-DD494551461D}"
    GetOutput(uiIndex, pContext, pfModifyInPlace, ppBitmapSource)
      => ComCall(3, this.p, UInt32, uiIndex, IMILBitmapEffectRenderContext, pContext, VARIANT_BOOL.Ptr, pfModifyInPlace, IWICBitmapSource.Ptr, ppBitmapSource)
    TransformPoint(uiIndex, p, fForwardTransform, pContext, pfPointTransformed)
      => ComCall(4, this.p, UInt32, uiIndex, MilPoint2D.Ptr, p, VARIANT_BOOL, fForwardTransform, IMILBitmapEffectRenderContext, pContext, VARIANT_BOOL.Ptr, pfPointTransformed)
    TransformRect(uiIndex, p, fForwardTransform, pContext)
      => ComCall(5, this.p, UInt32, uiIndex, MilRectD.Ptr, p, VARIANT_BOOL, fForwardTransform, IMILBitmapEffectRenderContext, pContext)
    HasAffineTransform(uiIndex, pfAffine)
      => ComCall(6, this.p, UInt32, uiIndex, VARIANT_BOOL.Ptr, pfAffine)
    HasInverseTransform(uiIndex, pfHasInverse)
      => ComCall(7, this.p, UInt32, uiIndex, VARIANT_BOOL.Ptr, pfHasInverse)
    GetAffineMatrix(uiIndex, pMatrix)
      => ComCall(8, this.p, UInt32, uiIndex, MilMatrix3x2D.Ptr, pMatrix)
}
struct IMILBitmapEffectPrimitiveImpl extends IUnknown {
    static IID := "{CE41E00B-EFA6-44E7-B007-DD042E3AE126}"
    IsDirty(uiOutputIndex, pfDirty)
      => ComCall(3, this.p, UInt32, uiOutputIndex, VARIANT_BOOL.Ptr, pfDirty)
    IsVolatile(uiOutputIndex, pfVolatile)
      => ComCall(4, this.p, UInt32, uiOutputIndex, VARIANT_BOOL.Ptr, pfVolatile)
}
struct IMILBitmapEffects extends IUnknown {
    static IID := "{51AC3DCE-67C5-448B-9180-AD3EABDDD5DD}"
    _NewEnum(ppiuReturn)
      => ComCall(3, this.p, IUnknown.Ptr, ppiuReturn)
    get_Parent(ppEffect)
      => ComCall(4, this.p, IMILBitmapEffectGroup.Ptr, ppEffect)
    Item(uindex, ppEffect)
      => ComCall(5, this.p, UInt32, uindex, IMILBitmapEffect.Ptr, ppEffect)
    get_Count(puiCount)
      => ComCall(6, this.p, UInt32.Ptr, puiCount)
}
struct IMILBitmapEffectConnector extends IMILBitmapEffectConnectorInfo {
    static IID := "{F59567B3-76C1-4D47-BA1E-79F955E350EF}"
    IsConnected(pfConnected)
      => ComCall(7, this.p, VARIANT_BOOL.Ptr, pfConnected)
    GetBitmapEffect(ppEffect)
      => ComCall(8, this.p, IMILBitmapEffect.Ptr, ppEffect)
}
struct IMILBitmapEffectInputConnector extends IMILBitmapEffectConnector {
    static IID := "{A9B4ECAA-7A3C-45E7-8573-F4B81B60DD6C}"
    ConnectTo(pConnector)
      => ComCall(9, this.p, IMILBitmapEffectOutputConnector, pConnector)
    GetConnection(ppConnector)
      => ComCall(10, this.p, IMILBitmapEffectOutputConnector.Ptr, ppConnector)
}
struct IMILBitmapEffectOutputConnector extends IMILBitmapEffectConnector {
    static IID := "{92957AAD-841B-4866-82EC-8752468B07FD}"
    GetNumberConnections(puiNumberConnections)
      => ComCall(9, this.p, UInt32.Ptr, puiNumberConnections)
    GetConnection(uiIndex, ppConnection)
      => ComCall(10, this.p, UInt32, uiIndex, IMILBitmapEffectInputConnector.Ptr, ppConnection)
}
struct IMILBitmapEffectOutputConnectorImpl extends IUnknown {
    static IID := "{21FAE777-8B39-4BFA-9F2D-F3941ED36913}"
    AddBackLink(pConnection)
      => ComCall(3, this.p, IMILBitmapEffectInputConnector, pConnection)
    RemoveBackLink(pConnection)
      => ComCall(4, this.p, IMILBitmapEffectInputConnector, pConnection)
}
struct IMILBitmapEffectInteriorInputConnector extends IUnknown {
    static IID := "{20287E9E-86A2-4E15-953D-EB1438A5B842}"
    GetInputConnector(pInputConnector)
      => ComCall(3, this.p, IMILBitmapEffectInputConnector.Ptr, pInputConnector)
}
struct IMILBitmapEffectInteriorOutputConnector extends IUnknown {
    static IID := "{00BBB6DC-ACC9-4BFC-B344-8BEE383DFEFA}"
    GetOutputConnector(pOutputConnector)
      => ComCall(3, this.p, IMILBitmapEffectOutputConnector.Ptr, pOutputConnector)
}
struct IMILBitmapEffectEvents extends IUnknown {
    static IID := "{2E880DD8-F8CE-457B-8199-D60BB3D7EF98}"
    PropertyChange(pEffect, bstrPropertyName)
      => ComCall(3, this.p, IMILBitmapEffect, pEffect, BSTR, bstrPropertyName)
    DirtyRegion(pEffect, pRect)
      => ComCall(4, this.p, IMILBitmapEffect, pEffect, MilRectD.Ptr, pRect)
}
