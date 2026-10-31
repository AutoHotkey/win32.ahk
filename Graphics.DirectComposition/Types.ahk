#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, HANDLE, HRESULT, HWND, LUID, POINT, RECT}
#Import "..\Graphics.Direct2D.Common\Types.ahk" {D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE, D2D1_BLEND_MODE, D2D1_BORDER_MODE, D2D1_COLORMATRIX_ALPHA_MODE, D2D1_COLOR_F, D2D1_COMPOSITE_MODE, D2D1_TURBULENCE_NOISE, D2D_MATRIX_3X2_F, D2D_MATRIX_4X4_F, D2D_MATRIX_5X4_F, D2D_RECT_F, D2D_RECT_U, D2D_VECTOR_2F, D2D_VECTOR_4F}
#Import "..\Graphics.Direct3D\Types.ahk" {D3DMATRIX}
#Import "..\Graphics.Dxgi.Common\Types.ahk" {DXGI_ALPHA_MODE, DXGI_COLOR_SPACE_TYPE, DXGI_FORMAT, DXGI_RATIONAL}
#Import "..\System.Com\Types.ahk" {IUnknown}

struct DCOMPOSITION_BITMAP_INTERPOLATION_MODE extends Int32 {
    static DCOMPOSITION_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR := 0
    static DCOMPOSITION_BITMAP_INTERPOLATION_MODE_LINEAR := 1
    static DCOMPOSITION_BITMAP_INTERPOLATION_MODE_INHERIT := -1
}
struct DCOMPOSITION_BORDER_MODE extends Int32 {
    static DCOMPOSITION_BORDER_MODE_SOFT := 0
    static DCOMPOSITION_BORDER_MODE_HARD := 1
    static DCOMPOSITION_BORDER_MODE_INHERIT := -1
}
struct DCOMPOSITION_COMPOSITE_MODE extends Int32 {
    static DCOMPOSITION_COMPOSITE_MODE_SOURCE_OVER := 0
    static DCOMPOSITION_COMPOSITE_MODE_DESTINATION_INVERT := 1
    static DCOMPOSITION_COMPOSITE_MODE_MIN_BLEND := 2
    static DCOMPOSITION_COMPOSITE_MODE_INHERIT := -1
}
struct DCOMPOSITION_BACKFACE_VISIBILITY extends Int32 {
    static DCOMPOSITION_BACKFACE_VISIBILITY_VISIBLE := 0
    static DCOMPOSITION_BACKFACE_VISIBILITY_HIDDEN := 1
    static DCOMPOSITION_BACKFACE_VISIBILITY_INHERIT := -1
}
struct DCOMPOSITION_OPACITY_MODE extends Int32 {
    static DCOMPOSITION_OPACITY_MODE_LAYER := 0
    static DCOMPOSITION_OPACITY_MODE_MULTIPLY := 1
    static DCOMPOSITION_OPACITY_MODE_INHERIT := -1
}
struct DCOMPOSITION_DEPTH_MODE extends Int32 {
    static DCOMPOSITION_DEPTH_MODE_TREE := 0
    static DCOMPOSITION_DEPTH_MODE_SPATIAL := 1
    static DCOMPOSITION_DEPTH_MODE_SORTED := 3
    static DCOMPOSITION_DEPTH_MODE_INHERIT := -1
}
struct DCOMPOSITION_FRAME_STATISTICS {
    lastFrameTime : Int64
    currentCompositionRate : DXGI_RATIONAL
    currentTime : Int64
    timeFrequency : Int64
    nextEstimatedFrameTime : Int64
}
struct COMPOSITION_FRAME_ID_TYPE extends Int32 {
    static COMPOSITION_FRAME_ID_CREATED := 0
    static COMPOSITION_FRAME_ID_CONFIRMED := 1
    static COMPOSITION_FRAME_ID_COMPLETED := 2
}
struct COMPOSITION_FRAME_STATS {
    startTime : Int64
    targetTime : Int64
    framePeriod : Int64
}
struct COMPOSITION_TARGET_ID {
    displayAdapterLuid : LUID
    renderAdapterLuid : LUID
    vidPnSourceId : UInt32
    vidPnTargetId : UInt32
    uniqueId : UInt32
}
struct COMPOSITION_STATS {
    presentCount : UInt32
    refreshCount : UInt32
    virtualRefreshCount : UInt32
    time : Int64
}
struct COMPOSITION_TARGET_STATS {
    outstandingPresents : UInt32
    presentTime : Int64
    vblankDuration : Int64
    presentedStats : COMPOSITION_STATS
    completedStats : COMPOSITION_STATS
}
struct IDCompositionAnimation extends IUnknown {
    static IID := "{CBFD91D9-51B2-45E4-B3DE-D19CCFB863C5}"
    Reset()
      => ComCall(3, this.p)
    SetAbsoluteBeginTime(beginTime)
      => ComCall(4, this.p, Int64, beginTime)
    AddCubic(beginOffset, constantCoefficient, linearCoefficient, quadraticCoefficient, cubicCoefficient)
      => ComCall(5, this.p, Float64, beginOffset, Float32, constantCoefficient, Float32, linearCoefficient, Float32, quadraticCoefficient, Float32, cubicCoefficient)
    AddSinusoidal(beginOffset, bias, amplitude, frequency, phase)
      => ComCall(6, this.p, Float64, beginOffset, Float32, bias, Float32, amplitude, Float32, frequency, Float32, phase)
    AddRepeat(beginOffset, durationToRepeat)
      => ComCall(7, this.p, Float64, beginOffset, Float64, durationToRepeat)
    End(endOffset, endValue)
      => ComCall(8, this.p, Float64, endOffset, Float32, endValue)
}
struct IDCompositionDevice extends IUnknown {
    static IID := "{C37EA93A-E7AA-450D-B16F-9746CB0407F3}"
    Commit()
      => ComCall(3, this.p)
    WaitForCommitCompletion()
      => ComCall(4, this.p)
    GetFrameStatistics(statistics)
      => ComCall(5, this.p, DCOMPOSITION_FRAME_STATISTICS.Ptr, statistics)
    CreateTargetForHwnd(hwnd1, topmost, target)
      => ComCall(6, this.p, HWND, hwnd1, BOOL, topmost, IDCompositionTarget.Ptr, target)
    CreateVisual(visual)
      => ComCall(7, this.p, IDCompositionVisual.Ptr, visual)
    CreateSurface(width, height, pixelFormat, alphaMode, surface)
      => ComCall(8, this.p, UInt32, width, UInt32, height, DXGI_FORMAT, pixelFormat, DXGI_ALPHA_MODE, alphaMode, IDCompositionSurface.Ptr, surface)
    CreateVirtualSurface(initialWidth, initialHeight, pixelFormat, alphaMode, virtualSurface)
      => ComCall(9, this.p, UInt32, initialWidth, UInt32, initialHeight, DXGI_FORMAT, pixelFormat, DXGI_ALPHA_MODE, alphaMode, IDCompositionVirtualSurface.Ptr, virtualSurface)
    CreateSurfaceFromHandle(handle1, surface)
      => ComCall(10, this.p, HANDLE, handle1, IUnknown.Ptr, surface)
    CreateSurfaceFromHwnd(hwnd1, surface)
      => ComCall(11, this.p, HWND, hwnd1, IUnknown.Ptr, surface)
    CreateTranslateTransform(translateTransform)
      => ComCall(12, this.p, IDCompositionTranslateTransform.Ptr, translateTransform)
    CreateScaleTransform(scaleTransform)
      => ComCall(13, this.p, IDCompositionScaleTransform.Ptr, scaleTransform)
    CreateRotateTransform(rotateTransform)
      => ComCall(14, this.p, IDCompositionRotateTransform.Ptr, rotateTransform)
    CreateSkewTransform(skewTransform)
      => ComCall(15, this.p, IDCompositionSkewTransform.Ptr, skewTransform)
    CreateMatrixTransform(matrixTransform)
      => ComCall(16, this.p, IDCompositionMatrixTransform.Ptr, matrixTransform)
    CreateTransformGroup(transforms, transformGroup)
      => ComCall(17, this.p, IDCompositionTransform.Ptr, transforms, UInt32, transforms.Length, IDCompositionTransform.Ptr, transformGroup)
    CreateTranslateTransform3D(translateTransform3D)
      => ComCall(18, this.p, IDCompositionTranslateTransform3D.Ptr, translateTransform3D)
    CreateScaleTransform3D(scaleTransform3D)
      => ComCall(19, this.p, IDCompositionScaleTransform3D.Ptr, scaleTransform3D)
    CreateRotateTransform3D(rotateTransform3D)
      => ComCall(20, this.p, IDCompositionRotateTransform3D.Ptr, rotateTransform3D)
    CreateMatrixTransform3D(matrixTransform3D)
      => ComCall(21, this.p, IDCompositionMatrixTransform3D.Ptr, matrixTransform3D)
    CreateTransform3DGroup(transforms3D, transform3DGroup)
      => ComCall(22, this.p, IDCompositionTransform3D.Ptr, transforms3D, UInt32, transforms3D.Length, IDCompositionTransform3D.Ptr, transform3DGroup)
    CreateEffectGroup(effectGroup)
      => ComCall(23, this.p, IDCompositionEffectGroup.Ptr, effectGroup)
    CreateRectangleClip(clip)
      => ComCall(24, this.p, IDCompositionRectangleClip.Ptr, clip)
    CreateAnimation(animation)
      => ComCall(25, this.p, IDCompositionAnimation.Ptr, animation)
    CheckDeviceState(pfValid)
      => ComCall(26, this.p, BOOL.Ptr, pfValid)
}
struct IDCompositionTarget extends IUnknown {
    static IID := "{EACDD04C-117E-4E17-88F4-D1B12B0E3D89}"
    SetRoot(visual?)
      => ComCall(3, this.p, IDCompositionVisual, visual?)
}
struct IDCompositionVisual extends IUnknown {
    static IID := "{4D93059D-097B-4651-9A60-F0F25116E2F3}"
    SetOffsetX(animation)
      => ComCall(3, this.p, IDCompositionAnimation, animation)
    SetOffsetX_2(offsetX)
      => ComCall(4, this.p, Float32, offsetX)
    SetOffsetY(animation)
      => ComCall(5, this.p, IDCompositionAnimation, animation)
    SetOffsetY_2(offsetY)
      => ComCall(6, this.p, Float32, offsetY)
    SetTransform(transform?)
      => ComCall(7, this.p, IDCompositionTransform, transform?)
    SetTransform_2(matrix)
      => ComCall(8, this.p, D2D_MATRIX_3X2_F.Ptr, matrix)
    SetTransformParent(visual?)
      => ComCall(9, this.p, IDCompositionVisual, visual?)
    SetEffect(effect?)
      => ComCall(10, this.p, IDCompositionEffect, effect?)
    SetBitmapInterpolationMode(interpolationMode)
      => ComCall(11, this.p, DCOMPOSITION_BITMAP_INTERPOLATION_MODE, interpolationMode)
    SetBorderMode(borderMode)
      => ComCall(12, this.p, DCOMPOSITION_BORDER_MODE, borderMode)
    SetClip(clip?)
      => ComCall(13, this.p, IDCompositionClip, clip?)
    SetClip_2(rect)
      => ComCall(14, this.p, D2D_RECT_F.Ptr, rect)
    SetContent(content?)
      => ComCall(15, this.p, IUnknown, content?)
    AddVisual(visual, insertAbove, referenceVisual?)
      => ComCall(16, this.p, IDCompositionVisual, visual, BOOL, insertAbove, IDCompositionVisual, referenceVisual?)
    RemoveVisual(visual)
      => ComCall(17, this.p, IDCompositionVisual, visual)
    RemoveAllVisuals()
      => ComCall(18, this.p)
    SetCompositeMode(compositeMode)
      => ComCall(19, this.p, DCOMPOSITION_COMPOSITE_MODE, compositeMode)
}
struct IDCompositionEffect extends IUnknown {
    static IID := "{EC81B08F-BFCB-4E8D-B193-A915587999E8}"
}
struct IDCompositionTransform3D extends IDCompositionEffect {
    static IID := "{71185722-246B-41F2-AAD1-0443F7F4BFC2}"
}
struct IDCompositionTransform extends IDCompositionTransform3D {
    static IID := "{FD55FAA7-37E0-4C20-95D2-9BE45BC33F55}"
}
struct IDCompositionTranslateTransform extends IDCompositionTransform {
    static IID := "{06791122-C6F0-417D-8323-269E987F5954}"
    SetOffsetX(animation)
      => ComCall(3, this.p, IDCompositionAnimation, animation)
    SetOffsetX_2(offsetX)
      => ComCall(4, this.p, Float32, offsetX)
    SetOffsetY(animation)
      => ComCall(5, this.p, IDCompositionAnimation, animation)
    SetOffsetY_2(offsetY)
      => ComCall(6, this.p, Float32, offsetY)
}
struct IDCompositionScaleTransform extends IDCompositionTransform {
    static IID := "{71FDE914-40EF-45EF-BD51-68B037C339F9}"
    SetScaleX(animation)
      => ComCall(3, this.p, IDCompositionAnimation, animation)
    SetScaleX_2(scaleX)
      => ComCall(4, this.p, Float32, scaleX)
    SetScaleY(animation)
      => ComCall(5, this.p, IDCompositionAnimation, animation)
    SetScaleY_2(scaleY)
      => ComCall(6, this.p, Float32, scaleY)
    SetCenterX(animation)
      => ComCall(7, this.p, IDCompositionAnimation, animation)
    SetCenterX_2(centerX)
      => ComCall(8, this.p, Float32, centerX)
    SetCenterY(animation)
      => ComCall(9, this.p, IDCompositionAnimation, animation)
    SetCenterY_2(centerY)
      => ComCall(10, this.p, Float32, centerY)
}
struct IDCompositionRotateTransform extends IDCompositionTransform {
    static IID := "{641ED83C-AE96-46C5-90DC-32774CC5C6D5}"
    SetAngle(animation)
      => ComCall(3, this.p, IDCompositionAnimation, animation)
    SetAngle_2(angle)
      => ComCall(4, this.p, Float32, angle)
    SetCenterX(animation)
      => ComCall(5, this.p, IDCompositionAnimation, animation)
    SetCenterX_2(centerX)
      => ComCall(6, this.p, Float32, centerX)
    SetCenterY(animation)
      => ComCall(7, this.p, IDCompositionAnimation, animation)
    SetCenterY_2(centerY)
      => ComCall(8, this.p, Float32, centerY)
}
struct IDCompositionSkewTransform extends IDCompositionTransform {
    static IID := "{E57AA735-DCDB-4C72-9C61-0591F58889EE}"
    SetAngleX(animation)
      => ComCall(3, this.p, IDCompositionAnimation, animation)
    SetAngleX_2(angleX)
      => ComCall(4, this.p, Float32, angleX)
    SetAngleY(animation)
      => ComCall(5, this.p, IDCompositionAnimation, animation)
    SetAngleY_2(angleY)
      => ComCall(6, this.p, Float32, angleY)
    SetCenterX(animation)
      => ComCall(7, this.p, IDCompositionAnimation, animation)
    SetCenterX_2(centerX)
      => ComCall(8, this.p, Float32, centerX)
    SetCenterY(animation)
      => ComCall(9, this.p, IDCompositionAnimation, animation)
    SetCenterY_2(centerY)
      => ComCall(10, this.p, Float32, centerY)
}
struct IDCompositionMatrixTransform extends IDCompositionTransform {
    static IID := "{16CDFF07-C503-419C-83F2-0965C7AF1FA6}"
    SetMatrix(matrix)
      => ComCall(3, this.p, D2D_MATRIX_3X2_F.Ptr, matrix)
    SetMatrixElement(row, column, animation)
      => ComCall(4, this.p, Int32, row, Int32, column, IDCompositionAnimation, animation)
    SetMatrixElement_2(row, column, value)
      => ComCall(5, this.p, Int32, row, Int32, column, Float32, value)
}
struct IDCompositionEffectGroup extends IDCompositionEffect {
    static IID := "{A7929A74-E6B2-4BD6-8B95-4040119CA34D}"
    SetOpacity(animation)
      => ComCall(3, this.p, IDCompositionAnimation, animation)
    SetOpacity_2(opacity)
      => ComCall(4, this.p, Float32, opacity)
    SetTransform3D(transform3D?)
      => ComCall(5, this.p, IDCompositionTransform3D, transform3D?)
}
struct IDCompositionTranslateTransform3D extends IDCompositionTransform3D {
    static IID := "{91636D4B-9BA1-4532-AAF7-E3344994D788}"
    SetOffsetX(animation)
      => ComCall(3, this.p, IDCompositionAnimation, animation)
    SetOffsetX_2(offsetX)
      => ComCall(4, this.p, Float32, offsetX)
    SetOffsetY(animation)
      => ComCall(5, this.p, IDCompositionAnimation, animation)
    SetOffsetY_2(offsetY)
      => ComCall(6, this.p, Float32, offsetY)
    SetOffsetZ(animation)
      => ComCall(7, this.p, IDCompositionAnimation, animation)
    SetOffsetZ_2(offsetZ)
      => ComCall(8, this.p, Float32, offsetZ)
}
struct IDCompositionScaleTransform3D extends IDCompositionTransform3D {
    static IID := "{2A9E9EAD-364B-4B15-A7C4-A1997F78B389}"
    SetScaleX(animation)
      => ComCall(3, this.p, IDCompositionAnimation, animation)
    SetScaleX_2(scaleX)
      => ComCall(4, this.p, Float32, scaleX)
    SetScaleY(animation)
      => ComCall(5, this.p, IDCompositionAnimation, animation)
    SetScaleY_2(scaleY)
      => ComCall(6, this.p, Float32, scaleY)
    SetScaleZ(animation)
      => ComCall(7, this.p, IDCompositionAnimation, animation)
    SetScaleZ_2(scaleZ)
      => ComCall(8, this.p, Float32, scaleZ)
    SetCenterX(animation)
      => ComCall(9, this.p, IDCompositionAnimation, animation)
    SetCenterX_2(centerX)
      => ComCall(10, this.p, Float32, centerX)
    SetCenterY(animation)
      => ComCall(11, this.p, IDCompositionAnimation, animation)
    SetCenterY_2(centerY)
      => ComCall(12, this.p, Float32, centerY)
    SetCenterZ(animation)
      => ComCall(13, this.p, IDCompositionAnimation, animation)
    SetCenterZ_2(centerZ)
      => ComCall(14, this.p, Float32, centerZ)
}
struct IDCompositionRotateTransform3D extends IDCompositionTransform3D {
    static IID := "{D8F5B23F-D429-4A91-B55A-D2F45FD75B18}"
    SetAngle(animation)
      => ComCall(3, this.p, IDCompositionAnimation, animation)
    SetAngle_2(angle)
      => ComCall(4, this.p, Float32, angle)
    SetAxisX(animation)
      => ComCall(5, this.p, IDCompositionAnimation, animation)
    SetAxisX_2(axisX)
      => ComCall(6, this.p, Float32, axisX)
    SetAxisY(animation)
      => ComCall(7, this.p, IDCompositionAnimation, animation)
    SetAxisY_2(axisY)
      => ComCall(8, this.p, Float32, axisY)
    SetAxisZ(animation)
      => ComCall(9, this.p, IDCompositionAnimation, animation)
    SetAxisZ_2(axisZ)
      => ComCall(10, this.p, Float32, axisZ)
    SetCenterX(animation)
      => ComCall(11, this.p, IDCompositionAnimation, animation)
    SetCenterX_2(centerX)
      => ComCall(12, this.p, Float32, centerX)
    SetCenterY(animation)
      => ComCall(13, this.p, IDCompositionAnimation, animation)
    SetCenterY_2(centerY)
      => ComCall(14, this.p, Float32, centerY)
    SetCenterZ(animation)
      => ComCall(15, this.p, IDCompositionAnimation, animation)
    SetCenterZ_2(centerZ)
      => ComCall(16, this.p, Float32, centerZ)
}
struct IDCompositionMatrixTransform3D extends IDCompositionTransform3D {
    static IID := "{4B3363F0-643B-41B7-B6E0-CCF22D34467C}"
    SetMatrix(matrix)
      => ComCall(3, this.p, D3DMATRIX.Ptr, matrix)
    SetMatrixElement(row, column, animation)
      => ComCall(4, this.p, Int32, row, Int32, column, IDCompositionAnimation, animation)
    SetMatrixElement_2(row, column, value)
      => ComCall(5, this.p, Int32, row, Int32, column, Float32, value)
}
struct IDCompositionClip extends IUnknown {
    static IID := "{64AC3703-9D3F-45EC-A109-7CAC0E7A13A7}"
}
struct IDCompositionRectangleClip extends IDCompositionClip {
    static IID := "{9842AD7D-D9CF-4908-AED7-48B51DA5E7C2}"
    SetLeft(animation)
      => ComCall(3, this.p, IDCompositionAnimation, animation)
    SetLeft_2(left)
      => ComCall(4, this.p, Float32, left)
    SetTop(animation)
      => ComCall(5, this.p, IDCompositionAnimation, animation)
    SetTop_2(top)
      => ComCall(6, this.p, Float32, top)
    SetRight(animation)
      => ComCall(7, this.p, IDCompositionAnimation, animation)
    SetRight_2(right)
      => ComCall(8, this.p, Float32, right)
    SetBottom(animation)
      => ComCall(9, this.p, IDCompositionAnimation, animation)
    SetBottom_2(bottom)
      => ComCall(10, this.p, Float32, bottom)
    SetTopLeftRadiusX(animation)
      => ComCall(11, this.p, IDCompositionAnimation, animation)
    SetTopLeftRadiusX_2(radius)
      => ComCall(12, this.p, Float32, radius)
    SetTopLeftRadiusY(animation)
      => ComCall(13, this.p, IDCompositionAnimation, animation)
    SetTopLeftRadiusY_2(radius)
      => ComCall(14, this.p, Float32, radius)
    SetTopRightRadiusX(animation)
      => ComCall(15, this.p, IDCompositionAnimation, animation)
    SetTopRightRadiusX_2(radius)
      => ComCall(16, this.p, Float32, radius)
    SetTopRightRadiusY(animation)
      => ComCall(17, this.p, IDCompositionAnimation, animation)
    SetTopRightRadiusY_2(radius)
      => ComCall(18, this.p, Float32, radius)
    SetBottomLeftRadiusX(animation)
      => ComCall(19, this.p, IDCompositionAnimation, animation)
    SetBottomLeftRadiusX_2(radius)
      => ComCall(20, this.p, Float32, radius)
    SetBottomLeftRadiusY(animation)
      => ComCall(21, this.p, IDCompositionAnimation, animation)
    SetBottomLeftRadiusY_2(radius)
      => ComCall(22, this.p, Float32, radius)
    SetBottomRightRadiusX(animation)
      => ComCall(23, this.p, IDCompositionAnimation, animation)
    SetBottomRightRadiusX_2(radius)
      => ComCall(24, this.p, Float32, radius)
    SetBottomRightRadiusY(animation)
      => ComCall(25, this.p, IDCompositionAnimation, animation)
    SetBottomRightRadiusY_2(radius)
      => ComCall(26, this.p, Float32, radius)
}
struct IDCompositionSurface extends IUnknown {
    static IID := "{BB8A4953-2C99-4F5A-96F5-4819027FA3AC}"
    BeginDraw(updateRect?, iid, updateObject, updateOffset)
      => ComCall(3, this.p, RECT.Ptr, updateRect?, GUID.Ptr, iid, Struct.Ptr.Ptr, updateObject, POINT.Ptr, updateOffset)
    EndDraw()
      => ComCall(4, this.p)
    SuspendDraw()
      => ComCall(5, this.p)
    ResumeDraw()
      => ComCall(6, this.p)
    Scroll(scrollRect?, clipRect?, offsetX, offsetY)
      => ComCall(7, this.p, RECT.Ptr, scrollRect?, RECT.Ptr, clipRect?, Int32, offsetX, Int32, offsetY)
}
struct IDCompositionVirtualSurface extends IDCompositionSurface {
    static IID := "{AE471C51-5F53-4A24-8D3E-D0C39C30B3F0}"
    Resize(width, height)
      => ComCall(8, this.p, UInt32, width, UInt32, height)
    Trim(rectangles?)
      => ComCall(9, this.p, RECT.Ptr, rectangles?, UInt32, rectangles?.Length ?? 0)
}
struct IDCompositionDevice2 extends IUnknown {
    static IID := "{75F6468D-1B8E-447C-9BC6-75FEA80B5B25}"
    Commit()
      => ComCall(3, this.p)
    WaitForCommitCompletion()
      => ComCall(4, this.p)
    GetFrameStatistics(statistics)
      => ComCall(5, this.p, DCOMPOSITION_FRAME_STATISTICS.Ptr, statistics)
    CreateVisual(visual)
      => ComCall(6, this.p, IDCompositionVisual2.Ptr, visual)
    CreateSurfaceFactory(renderingDevice, surfaceFactory)
      => ComCall(7, this.p, IUnknown, renderingDevice, IDCompositionSurfaceFactory.Ptr, surfaceFactory)
    CreateSurface(width, height, pixelFormat, alphaMode, surface)
      => ComCall(8, this.p, UInt32, width, UInt32, height, DXGI_FORMAT, pixelFormat, DXGI_ALPHA_MODE, alphaMode, IDCompositionSurface.Ptr, surface)
    CreateVirtualSurface(initialWidth, initialHeight, pixelFormat, alphaMode, virtualSurface)
      => ComCall(9, this.p, UInt32, initialWidth, UInt32, initialHeight, DXGI_FORMAT, pixelFormat, DXGI_ALPHA_MODE, alphaMode, IDCompositionVirtualSurface.Ptr, virtualSurface)
    CreateTranslateTransform(translateTransform)
      => ComCall(10, this.p, IDCompositionTranslateTransform.Ptr, translateTransform)
    CreateScaleTransform(scaleTransform)
      => ComCall(11, this.p, IDCompositionScaleTransform.Ptr, scaleTransform)
    CreateRotateTransform(rotateTransform)
      => ComCall(12, this.p, IDCompositionRotateTransform.Ptr, rotateTransform)
    CreateSkewTransform(skewTransform)
      => ComCall(13, this.p, IDCompositionSkewTransform.Ptr, skewTransform)
    CreateMatrixTransform(matrixTransform)
      => ComCall(14, this.p, IDCompositionMatrixTransform.Ptr, matrixTransform)
    CreateTransformGroup(transforms, transformGroup)
      => ComCall(15, this.p, IDCompositionTransform.Ptr, transforms, UInt32, transforms.Length, IDCompositionTransform.Ptr, transformGroup)
    CreateTranslateTransform3D(translateTransform3D)
      => ComCall(16, this.p, IDCompositionTranslateTransform3D.Ptr, translateTransform3D)
    CreateScaleTransform3D(scaleTransform3D)
      => ComCall(17, this.p, IDCompositionScaleTransform3D.Ptr, scaleTransform3D)
    CreateRotateTransform3D(rotateTransform3D)
      => ComCall(18, this.p, IDCompositionRotateTransform3D.Ptr, rotateTransform3D)
    CreateMatrixTransform3D(matrixTransform3D)
      => ComCall(19, this.p, IDCompositionMatrixTransform3D.Ptr, matrixTransform3D)
    CreateTransform3DGroup(transforms3D, transform3DGroup)
      => ComCall(20, this.p, IDCompositionTransform3D.Ptr, transforms3D, UInt32, transforms3D.Length, IDCompositionTransform3D.Ptr, transform3DGroup)
    CreateEffectGroup(effectGroup)
      => ComCall(21, this.p, IDCompositionEffectGroup.Ptr, effectGroup)
    CreateRectangleClip(clip)
      => ComCall(22, this.p, IDCompositionRectangleClip.Ptr, clip)
    CreateAnimation(animation)
      => ComCall(23, this.p, IDCompositionAnimation.Ptr, animation)
}
struct IDCompositionDesktopDevice extends IDCompositionDevice2 {
    static IID := "{5F4633FE-1E08-4CB8-8C75-CE24333F5602}"
    CreateTargetForHwnd(hwnd1, topmost, target)
      => ComCall(24, this.p, HWND, hwnd1, BOOL, topmost, IDCompositionTarget.Ptr, target)
    CreateSurfaceFromHandle(handle1, surface)
      => ComCall(25, this.p, HANDLE, handle1, IUnknown.Ptr, surface)
    CreateSurfaceFromHwnd(hwnd1, surface)
      => ComCall(26, this.p, HWND, hwnd1, IUnknown.Ptr, surface)
}
struct IDCompositionDeviceDebug extends IUnknown {
    static IID := "{A1A3C64A-224F-4A81-9773-4F03A89D3C6C}"
    EnableDebugCounters()
      => ComCall(3, this.p)
    DisableDebugCounters()
      => ComCall(4, this.p)
}
struct IDCompositionSurfaceFactory extends IUnknown {
    static IID := "{E334BC12-3937-4E02-85EB-FCF4EB30D2C8}"
    CreateSurface(width, height, pixelFormat, alphaMode, surface)
      => ComCall(3, this.p, UInt32, width, UInt32, height, DXGI_FORMAT, pixelFormat, DXGI_ALPHA_MODE, alphaMode, IDCompositionSurface.Ptr, surface)
    CreateVirtualSurface(initialWidth, initialHeight, pixelFormat, alphaMode, virtualSurface)
      => ComCall(4, this.p, UInt32, initialWidth, UInt32, initialHeight, DXGI_FORMAT, pixelFormat, DXGI_ALPHA_MODE, alphaMode, IDCompositionVirtualSurface.Ptr, virtualSurface)
}
struct IDCompositionVisual2 extends IDCompositionVisual {
    static IID := "{E8DE1639-4331-4B26-BC5F-6A321D347A85}"
    SetOpacityMode(mode)
      => ComCall(20, this.p, DCOMPOSITION_OPACITY_MODE, mode)
    SetBackFaceVisibility(visibility)
      => ComCall(21, this.p, DCOMPOSITION_BACKFACE_VISIBILITY, visibility)
}
struct IDCompositionVisualDebug extends IDCompositionVisual2 {
    static IID := "{FED2B808-5EB4-43A0-AEA3-35F65280F91B}"
    EnableHeatMap(color)
      => ComCall(22, this.p, D2D1_COLOR_F.Ptr, color)
    DisableHeatMap()
      => ComCall(23, this.p)
    EnableRedrawRegions()
      => ComCall(24, this.p)
    DisableRedrawRegions()
      => ComCall(25, this.p)
}
struct IDCompositionVisual3 extends IDCompositionVisualDebug {
    static IID := "{2775F462-B6C1-4015-B0BE-B3E7D6A4976D}"
    SetDepthMode(mode)
      => ComCall(26, this.p, DCOMPOSITION_DEPTH_MODE, mode)
    SetOffsetZ(animation)
      => ComCall(27, this.p, IDCompositionAnimation, animation)
    SetOffsetZ_2(offsetZ)
      => ComCall(28, this.p, Float32, offsetZ)
    SetOpacity(animation)
      => ComCall(29, this.p, IDCompositionAnimation, animation)
    SetOpacity_2(opacity)
      => ComCall(30, this.p, Float32, opacity)
    SetTransform(transform?)
      => ComCall(31, this.p, IDCompositionTransform3D, transform?)
    SetTransform_2(matrix)
      => ComCall(32, this.p, D2D_MATRIX_4X4_F.Ptr, matrix)
    SetVisible(visible)
      => ComCall(33, this.p, BOOL, visible)
}
struct IDCompositionDevice3 extends IDCompositionDevice2 {
    static IID := "{0987CB06-F916-48BF-8D35-CE7641781BD9}"
    CreateGaussianBlurEffect(gaussianBlurEffect)
      => ComCall(24, this.p, IDCompositionGaussianBlurEffect.Ptr, gaussianBlurEffect)
    CreateBrightnessEffect(brightnessEffect)
      => ComCall(25, this.p, IDCompositionBrightnessEffect.Ptr, brightnessEffect)
    CreateColorMatrixEffect(colorMatrixEffect)
      => ComCall(26, this.p, IDCompositionColorMatrixEffect.Ptr, colorMatrixEffect)
    CreateShadowEffect(shadowEffect)
      => ComCall(27, this.p, IDCompositionShadowEffect.Ptr, shadowEffect)
    CreateHueRotationEffect(hueRotationEffect)
      => ComCall(28, this.p, IDCompositionHueRotationEffect.Ptr, hueRotationEffect)
    CreateSaturationEffect(saturationEffect)
      => ComCall(29, this.p, IDCompositionSaturationEffect.Ptr, saturationEffect)
    CreateTurbulenceEffect(turbulenceEffect)
      => ComCall(30, this.p, IDCompositionTurbulenceEffect.Ptr, turbulenceEffect)
    CreateLinearTransferEffect(linearTransferEffect)
      => ComCall(31, this.p, IDCompositionLinearTransferEffect.Ptr, linearTransferEffect)
    CreateTableTransferEffect(tableTransferEffect)
      => ComCall(32, this.p, IDCompositionTableTransferEffect.Ptr, tableTransferEffect)
    CreateCompositeEffect(compositeEffect)
      => ComCall(33, this.p, IDCompositionCompositeEffect.Ptr, compositeEffect)
    CreateBlendEffect(blendEffect)
      => ComCall(34, this.p, IDCompositionBlendEffect.Ptr, blendEffect)
    CreateArithmeticCompositeEffect(arithmeticCompositeEffect)
      => ComCall(35, this.p, IDCompositionArithmeticCompositeEffect.Ptr, arithmeticCompositeEffect)
    CreateAffineTransform2DEffect(affineTransform2dEffect)
      => ComCall(36, this.p, IDCompositionAffineTransform2DEffect.Ptr, affineTransform2dEffect)
}
struct IDCompositionFilterEffect extends IDCompositionEffect {
    static IID := "{30C421D5-8CB2-4E9F-B133-37BE270D4AC2}"
    SetInput(index, input?, flags)
      => ComCall(3, this.p, UInt32, index, IUnknown, input?, UInt32, flags)
}
struct IDCompositionGaussianBlurEffect extends IDCompositionFilterEffect {
    static IID := "{45D4D0B7-1BD4-454E-8894-2BFA68443033}"
    SetStandardDeviation(animation)
      => ComCall(4, this.p, IDCompositionAnimation, animation)
    SetStandardDeviation_2(amount)
      => ComCall(5, this.p, Float32, amount)
    SetBorderMode(mode)
      => ComCall(6, this.p, D2D1_BORDER_MODE, mode)
}
struct IDCompositionBrightnessEffect extends IDCompositionFilterEffect {
    static IID := "{6027496E-CB3A-49AB-934F-D798DA4F7DA6}"
    SetWhitePoint(whitePoint)
      => ComCall(4, this.p, D2D_VECTOR_2F.Ptr, whitePoint)
    SetBlackPoint(blackPoint)
      => ComCall(5, this.p, D2D_VECTOR_2F.Ptr, blackPoint)
    SetWhitePointX(animation)
      => ComCall(6, this.p, IDCompositionAnimation, animation)
    SetWhitePointX_2(whitePointX)
      => ComCall(7, this.p, Float32, whitePointX)
    SetWhitePointY(animation)
      => ComCall(8, this.p, IDCompositionAnimation, animation)
    SetWhitePointY_2(whitePointY)
      => ComCall(9, this.p, Float32, whitePointY)
    SetBlackPointX(animation)
      => ComCall(10, this.p, IDCompositionAnimation, animation)
    SetBlackPointX_2(blackPointX)
      => ComCall(11, this.p, Float32, blackPointX)
    SetBlackPointY(animation)
      => ComCall(12, this.p, IDCompositionAnimation, animation)
    SetBlackPointY_2(blackPointY)
      => ComCall(13, this.p, Float32, blackPointY)
}
struct IDCompositionColorMatrixEffect extends IDCompositionFilterEffect {
    static IID := "{C1170A22-3CE2-4966-90D4-55408BFC84C4}"
    SetMatrix(matrix)
      => ComCall(4, this.p, D2D_MATRIX_5X4_F.Ptr, matrix)
    SetMatrixElement(row, column, animation)
      => ComCall(5, this.p, Int32, row, Int32, column, IDCompositionAnimation, animation)
    SetMatrixElement_2(row, column, value)
      => ComCall(6, this.p, Int32, row, Int32, column, Float32, value)
    SetAlphaMode(mode)
      => ComCall(7, this.p, D2D1_COLORMATRIX_ALPHA_MODE, mode)
    SetClampOutput(clamp)
      => ComCall(8, this.p, BOOL, clamp)
}
struct IDCompositionShadowEffect extends IDCompositionFilterEffect {
    static IID := "{4AD18AC0-CFD2-4C2F-BB62-96E54FDB6879}"
    SetStandardDeviation(animation)
      => ComCall(4, this.p, IDCompositionAnimation, animation)
    SetStandardDeviation_2(amount)
      => ComCall(5, this.p, Float32, amount)
    SetColor(color)
      => ComCall(6, this.p, D2D_VECTOR_4F.Ptr, color)
    SetRed(animation)
      => ComCall(7, this.p, IDCompositionAnimation, animation)
    SetRed_2(amount)
      => ComCall(8, this.p, Float32, amount)
    SetGreen(animation)
      => ComCall(9, this.p, IDCompositionAnimation, animation)
    SetGreen_2(amount)
      => ComCall(10, this.p, Float32, amount)
    SetBlue(animation)
      => ComCall(11, this.p, IDCompositionAnimation, animation)
    SetBlue_2(amount)
      => ComCall(12, this.p, Float32, amount)
    SetAlpha(animation)
      => ComCall(13, this.p, IDCompositionAnimation, animation)
    SetAlpha_2(amount)
      => ComCall(14, this.p, Float32, amount)
}
struct IDCompositionHueRotationEffect extends IDCompositionFilterEffect {
    static IID := "{6DB9F920-0770-4781-B0C6-381912F9D167}"
    SetAngle(animation)
      => ComCall(4, this.p, IDCompositionAnimation, animation)
    SetAngle_2(amountDegrees)
      => ComCall(5, this.p, Float32, amountDegrees)
}
struct IDCompositionSaturationEffect extends IDCompositionFilterEffect {
    static IID := "{A08DEBDA-3258-4FA4-9F16-9174D3FE93B1}"
    SetSaturation(animation)
      => ComCall(4, this.p, IDCompositionAnimation, animation)
    SetSaturation_2(ratio)
      => ComCall(5, this.p, Float32, ratio)
}
struct IDCompositionTurbulenceEffect extends IDCompositionFilterEffect {
    static IID := "{A6A55BDA-C09C-49F3-9193-A41922C89715}"
    SetOffset(offset)
      => ComCall(4, this.p, D2D_VECTOR_2F.Ptr, offset)
    SetBaseFrequency(frequency)
      => ComCall(5, this.p, D2D_VECTOR_2F.Ptr, frequency)
    SetSize(size)
      => ComCall(6, this.p, D2D_VECTOR_2F.Ptr, size)
    SetNumOctaves(numOctaves)
      => ComCall(7, this.p, UInt32, numOctaves)
    SetSeed(seed)
      => ComCall(8, this.p, UInt32, seed)
    SetNoise(noise)
      => ComCall(9, this.p, D2D1_TURBULENCE_NOISE, noise)
    SetStitchable(stitchable)
      => ComCall(10, this.p, BOOL, stitchable)
}
struct IDCompositionLinearTransferEffect extends IDCompositionFilterEffect {
    static IID := "{4305EE5B-C4A0-4C88-9385-67124E017683}"
    SetRedYIntercept(animation)
      => ComCall(4, this.p, IDCompositionAnimation, animation)
    SetRedYIntercept_2(redYIntercept)
      => ComCall(5, this.p, Float32, redYIntercept)
    SetRedSlope(animation)
      => ComCall(6, this.p, IDCompositionAnimation, animation)
    SetRedSlope_2(redSlope)
      => ComCall(7, this.p, Float32, redSlope)
    SetRedDisable(redDisable)
      => ComCall(8, this.p, BOOL, redDisable)
    SetGreenYIntercept(animation)
      => ComCall(9, this.p, IDCompositionAnimation, animation)
    SetGreenYIntercept_2(greenYIntercept)
      => ComCall(10, this.p, Float32, greenYIntercept)
    SetGreenSlope(animation)
      => ComCall(11, this.p, IDCompositionAnimation, animation)
    SetGreenSlope_2(greenSlope)
      => ComCall(12, this.p, Float32, greenSlope)
    SetGreenDisable(greenDisable)
      => ComCall(13, this.p, BOOL, greenDisable)
    SetBlueYIntercept(animation)
      => ComCall(14, this.p, IDCompositionAnimation, animation)
    SetBlueYIntercept_2(blueYIntercept)
      => ComCall(15, this.p, Float32, blueYIntercept)
    SetBlueSlope(animation)
      => ComCall(16, this.p, IDCompositionAnimation, animation)
    SetBlueSlope_2(blueSlope)
      => ComCall(17, this.p, Float32, blueSlope)
    SetBlueDisable(blueDisable)
      => ComCall(18, this.p, BOOL, blueDisable)
    SetAlphaYIntercept(animation)
      => ComCall(19, this.p, IDCompositionAnimation, animation)
    SetAlphaYIntercept_2(alphaYIntercept)
      => ComCall(20, this.p, Float32, alphaYIntercept)
    SetAlphaSlope(animation)
      => ComCall(21, this.p, IDCompositionAnimation, animation)
    SetAlphaSlope_2(alphaSlope)
      => ComCall(22, this.p, Float32, alphaSlope)
    SetAlphaDisable(alphaDisable)
      => ComCall(23, this.p, BOOL, alphaDisable)
    SetClampOutput(clampOutput)
      => ComCall(24, this.p, BOOL, clampOutput)
}
struct IDCompositionTableTransferEffect extends IDCompositionFilterEffect {
    static IID := "{9B7E82E2-69C5-4EB4-A5F5-A7033F5132CD}"
    SetRedTable(tableValues)
      => ComCall(4, this.p, Float32.Ptr, tableValues, UInt32, tableValues.Length)
    SetGreenTable(tableValues)
      => ComCall(5, this.p, Float32.Ptr, tableValues, UInt32, tableValues.Length)
    SetBlueTable(tableValues)
      => ComCall(6, this.p, Float32.Ptr, tableValues, UInt32, tableValues.Length)
    SetAlphaTable(tableValues)
      => ComCall(7, this.p, Float32.Ptr, tableValues, UInt32, tableValues.Length)
    SetRedDisable(redDisable)
      => ComCall(8, this.p, BOOL, redDisable)
    SetGreenDisable(greenDisable)
      => ComCall(9, this.p, BOOL, greenDisable)
    SetBlueDisable(blueDisable)
      => ComCall(10, this.p, BOOL, blueDisable)
    SetAlphaDisable(alphaDisable)
      => ComCall(11, this.p, BOOL, alphaDisable)
    SetClampOutput(clampOutput)
      => ComCall(12, this.p, BOOL, clampOutput)
    SetRedTableValue(index, animation)
      => ComCall(13, this.p, UInt32, index, IDCompositionAnimation, animation)
    SetRedTableValue_2(index, value)
      => ComCall(14, this.p, UInt32, index, Float32, value)
    SetGreenTableValue(index, animation)
      => ComCall(15, this.p, UInt32, index, IDCompositionAnimation, animation)
    SetGreenTableValue_2(index, value)
      => ComCall(16, this.p, UInt32, index, Float32, value)
    SetBlueTableValue(index, animation)
      => ComCall(17, this.p, UInt32, index, IDCompositionAnimation, animation)
    SetBlueTableValue_2(index, value)
      => ComCall(18, this.p, UInt32, index, Float32, value)
    SetAlphaTableValue(index, animation)
      => ComCall(19, this.p, UInt32, index, IDCompositionAnimation, animation)
    SetAlphaTableValue_2(index, value)
      => ComCall(20, this.p, UInt32, index, Float32, value)
}
struct IDCompositionCompositeEffect extends IDCompositionFilterEffect {
    static IID := "{576616C0-A231-494D-A38D-00FD5EC4DB46}"
    SetMode(mode)
      => ComCall(4, this.p, D2D1_COMPOSITE_MODE, mode)
}
struct IDCompositionBlendEffect extends IDCompositionFilterEffect {
    static IID := "{33ECDC0A-578A-4A11-9C14-0CB90517F9C5}"
    SetMode(mode)
      => ComCall(4, this.p, D2D1_BLEND_MODE, mode)
}
struct IDCompositionArithmeticCompositeEffect extends IDCompositionFilterEffect {
    static IID := "{3B67DFA8-E3DD-4E61-B640-46C2F3D739DC}"
    SetCoefficients(coefficients)
      => ComCall(4, this.p, D2D_VECTOR_4F.Ptr, coefficients)
    SetClampOutput(clampoutput)
      => ComCall(5, this.p, BOOL, clampoutput)
    SetCoefficient1(animation)
      => ComCall(6, this.p, IDCompositionAnimation, animation)
    SetCoefficient1_2(Coeffcient1)
      => ComCall(7, this.p, Float32, Coeffcient1)
    SetCoefficient2(animation)
      => ComCall(8, this.p, IDCompositionAnimation, animation)
    SetCoefficient2_2(Coefficient2)
      => ComCall(9, this.p, Float32, Coefficient2)
    SetCoefficient3(animation)
      => ComCall(10, this.p, IDCompositionAnimation, animation)
    SetCoefficient3_2(Coefficient3)
      => ComCall(11, this.p, Float32, Coefficient3)
    SetCoefficient4(animation)
      => ComCall(12, this.p, IDCompositionAnimation, animation)
    SetCoefficient4_2(Coefficient4)
      => ComCall(13, this.p, Float32, Coefficient4)
}
struct IDCompositionAffineTransform2DEffect extends IDCompositionFilterEffect {
    static IID := "{0B74B9E8-CDD6-492F-BBBC-5ED32157026D}"
    SetInterpolationMode(interpolationMode)
      => ComCall(4, this.p, D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE, interpolationMode)
    SetBorderMode(borderMode)
      => ComCall(5, this.p, D2D1_BORDER_MODE, borderMode)
    SetTransformMatrix(transformMatrix)
      => ComCall(6, this.p, D2D_MATRIX_3X2_F.Ptr, transformMatrix)
    SetTransformMatrixElement(row, column, animation)
      => ComCall(7, this.p, Int32, row, Int32, column, IDCompositionAnimation, animation)
    SetTransformMatrixElement_2(row, column, value)
      => ComCall(8, this.p, Int32, row, Int32, column, Float32, value)
    SetSharpness(animation)
      => ComCall(9, this.p, IDCompositionAnimation, animation)
    SetSharpness_2(sharpness)
      => ComCall(10, this.p, Float32, sharpness)
}
struct DCompositionInkTrailPoint {
    x : Float32
    y : Float32
    radius : Float32
}
struct IDCompositionDelegatedInkTrail extends IUnknown {
    static IID := "{C2448E9B-547D-4057-8CF5-8144EDE1C2DA}"
    AddTrailPoints(inkPoints, generationId)
      => ComCall(3, this.p, DCompositionInkTrailPoint.Ptr, inkPoints, UInt32, inkPoints.Length, UInt32.Ptr, generationId)
    AddTrailPointsWithPrediction(inkPoints, predictedInkPoints, generationId)
      => ComCall(4, this.p, DCompositionInkTrailPoint.Ptr, inkPoints, UInt32, inkPoints.Length, DCompositionInkTrailPoint.Ptr, predictedInkPoints, UInt32, predictedInkPoints.Length, UInt32.Ptr, generationId)
    RemoveTrailPoints(generationId)
      => ComCall(5, this.p, UInt32, generationId)
    StartNewTrail(color)
      => ComCall(6, this.p, D2D1_COLOR_F.Ptr, color)
}
struct IDCompositionInkTrailDevice extends IUnknown {
    static IID := "{DF0C7CEC-CDEB-4D4A-B91C-721BF22F4E6C}"
    CreateDelegatedInkTrail(inkTrail)
      => ComCall(3, this.p, IDCompositionDelegatedInkTrail.Ptr, inkTrail)
    CreateDelegatedInkTrailForSwapChain(swapChain, inkTrail)
      => ComCall(4, this.p, IUnknown, swapChain, IDCompositionDelegatedInkTrail.Ptr, inkTrail)
}
struct IDCompositionTexture extends IUnknown {
    static IID := "{929BB1AA-725F-433B-ABD7-273075A835F2}"
    SetSourceRect(sourceRect)
      => ComCall(3, this.p, D2D_RECT_U.Ptr, sourceRect)
    SetColorSpace(colorSpace)
      => ComCall(4, this.p, DXGI_COLOR_SPACE_TYPE, colorSpace)
    SetAlphaMode(alphaMode)
      => ComCall(5, this.p, DXGI_ALPHA_MODE, alphaMode)
    GetAvailableFence(fenceValue, iid, availableFence)
      => ComCall(6, this.p, Int64.Ptr, fenceValue, GUID.Ptr, iid, Struct.Ptr.Ptr, availableFence)
}
struct IDCompositionDevice4 extends IDCompositionDevice3 {
    static IID := "{85FC5CCA-2DA6-494C-86B6-4A775C049B8A}"
    CheckCompositionTextureSupport(renderingDevice, supportsCompositionTextures)
      => ComCall(37, this.p, IUnknown, renderingDevice, BOOL.Ptr, supportsCompositionTextures)
    CreateCompositionTexture(d3dTexture, compositionTexture)
      => ComCall(38, this.p, IUnknown, d3dTexture, IDCompositionTexture.Ptr, compositionTexture)
}
struct IDCompositionDynamicTexture extends IUnknown {
    static IID := "{A1DE1D3F-6405-447F-8E95-1383A34B0277}"
    SetTexture(pTexture, pRects)
      => ComCall(3, this.p, IDCompositionTexture, pTexture, RECT.Ptr, pRects, IntPtr, pRects.Length)
    SetTexture_2(pTexture)
      => ComCall(4, this.p, IDCompositionTexture, pTexture)
}
struct IDCompositionDevice5 extends IDCompositionDevice4 {
    static IID := "{2C6BEBFE-A603-472F-AF34-D2443356E61B}"
    CreateDynamicTexture(compositionDynamicTexture)
      => ComCall(39, this.p, IDCompositionDynamicTexture.Ptr, compositionDynamicTexture)
}
