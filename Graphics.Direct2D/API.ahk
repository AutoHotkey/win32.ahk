#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "Types.ahk" {*}
#Import "..\Foundation\Types.ahk" {BOOL, HRESULT}
#Import "..\Graphics.Direct2D.Common\Types.ahk" {D2D1_COLOR_F, D2D_MATRIX_3X2_F, D2D_POINT_2F}
#Import "..\Graphics.Dxgi\Types.ahk" {IDXGIDevice, IDXGISurface}

D2D1ComputeMaximumScaleFactor(matrix)
  => DllCall("d2d1.dll\D2D1ComputeMaximumScaleFactor", D2D_MATRIX_3X2_F.Ptr, matrix, Float32)
D2D1ConvertColorSpace(sourceColorSpace, destinationColorSpace, color)
  => DllCall("d2d1.dll\D2D1ConvertColorSpace", D2D1_COLOR_SPACE, sourceColorSpace, D2D1_COLOR_SPACE, destinationColorSpace, D2D1_COLOR_F.Ptr, color, D2D1_COLOR_F)
D2D1CreateDevice(dxgiDevice, creationProperties?, d2dDevice)
  => DllCall("d2d1.dll\D2D1CreateDevice", IDXGIDevice, dxgiDevice, D2D1_CREATION_PROPERTIES.Ptr, creationProperties?, ID2D1Device.Ptr, d2dDevice, "HRESULT")
D2D1CreateDeviceContext(dxgiSurface, creationProperties?, d2dDeviceContext)
  => DllCall("d2d1.dll\D2D1CreateDeviceContext", IDXGISurface, dxgiSurface, D2D1_CREATION_PROPERTIES.Ptr, creationProperties?, ID2D1DeviceContext.Ptr, d2dDeviceContext, "HRESULT")
D2D1CreateFactory(factoryType, riid, pFactoryOptions?, ppIFactory)
  => DllCall("d2d1.dll\D2D1CreateFactory", D2D1_FACTORY_TYPE, factoryType, GUID.Ptr, riid, D2D1_FACTORY_OPTIONS.Ptr, pFactoryOptions?, Struct.Ptr.Ptr, ppIFactory, "HRESULT")
D2D1GetGradientMeshInteriorPointsFromCoonsPatch(pPoint0, pPoint1, pPoint2, pPoint3, pPoint4, pPoint5, pPoint6, pPoint7, pPoint8, pPoint9, pPoint10, pPoint11, pTensorPoint11, pTensorPoint12, pTensorPoint21, pTensorPoint22)
  => DllCall("d2d1.dll\D2D1GetGradientMeshInteriorPointsFromCoonsPatch", D2D_POINT_2F.Ptr, pPoint0, D2D_POINT_2F.Ptr, pPoint1, D2D_POINT_2F.Ptr, pPoint2, D2D_POINT_2F.Ptr, pPoint3, D2D_POINT_2F.Ptr, pPoint4, D2D_POINT_2F.Ptr, pPoint5, D2D_POINT_2F.Ptr, pPoint6, D2D_POINT_2F.Ptr, pPoint7, D2D_POINT_2F.Ptr, pPoint8, D2D_POINT_2F.Ptr, pPoint9, D2D_POINT_2F.Ptr, pPoint10, D2D_POINT_2F.Ptr, pPoint11, D2D_POINT_2F.Ptr, pTensorPoint11, D2D_POINT_2F.Ptr, pTensorPoint12, D2D_POINT_2F.Ptr, pTensorPoint21, D2D_POINT_2F.Ptr, pTensorPoint22, "void")
D2D1InvertMatrix(matrix)
  => DllCall("d2d1.dll\D2D1InvertMatrix", D2D_MATRIX_3X2_F.Ptr, matrix, BOOL)
D2D1IsMatrixInvertible(matrix)
  => DllCall("d2d1.dll\D2D1IsMatrixInvertible", D2D_MATRIX_3X2_F.Ptr, matrix, BOOL)
D2D1MakeRotateMatrix(angle, center, matrix)
  => DllCall("d2d1.dll\D2D1MakeRotateMatrix", Float32, angle, D2D_POINT_2F, center, D2D_MATRIX_3X2_F.Ptr, matrix, "void")
D2D1MakeSkewMatrix(angleX, angleY, center, matrix)
  => DllCall("d2d1.dll\D2D1MakeSkewMatrix", Float32, angleX, Float32, angleY, D2D_POINT_2F, center, D2D_MATRIX_3X2_F.Ptr, matrix, "void")
D2D1SinCos(angle, s, c)
  => DllCall("d2d1.dll\D2D1SinCos", Float32, angle, Float32.Ptr, s, Float32.Ptr, c, "void")
D2D1Tan(angle)
  => DllCall("d2d1.dll\D2D1Tan", Float32, angle, Float32)
D2D1Vec3Length(x, y, z)
  => DllCall("d2d1.dll\D2D1Vec3Length", Float32, x, Float32, y, Float32, z, Float32)
