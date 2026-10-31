#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, RECT}
#Import "..\Graphics.Gdi\Types.ahk" {HRGN}

struct DWM_BLURBEHIND {
    dwFlags : UInt32
    fEnable : BOOL
    hRgnBlur : HRGN
    fTransitionOnMaximized : BOOL
}
struct DWMWINDOWATTRIBUTE extends Int32 {
    static DWMWA_NCRENDERING_ENABLED := 1
    static DWMWA_NCRENDERING_POLICY := 2
    static DWMWA_TRANSITIONS_FORCEDISABLED := 3
    static DWMWA_ALLOW_NCPAINT := 4
    static DWMWA_CAPTION_BUTTON_BOUNDS := 5
    static DWMWA_NONCLIENT_RTL_LAYOUT := 6
    static DWMWA_FORCE_ICONIC_REPRESENTATION := 7
    static DWMWA_FLIP3D_POLICY := 8
    static DWMWA_EXTENDED_FRAME_BOUNDS := 9
    static DWMWA_HAS_ICONIC_BITMAP := 10
    static DWMWA_DISALLOW_PEEK := 11
    static DWMWA_EXCLUDED_FROM_PEEK := 12
    static DWMWA_CLOAK := 13
    static DWMWA_CLOAKED := 14
    static DWMWA_FREEZE_REPRESENTATION := 15
    static DWMWA_PASSIVE_UPDATE_MODE := 16
    static DWMWA_USE_HOSTBACKDROPBRUSH := 17
    static DWMWA_USE_IMMERSIVE_DARK_MODE := 20
    static DWMWA_WINDOW_CORNER_PREFERENCE := 33
    static DWMWA_BORDER_COLOR := 34
    static DWMWA_CAPTION_COLOR := 35
    static DWMWA_TEXT_COLOR := 36
    static DWMWA_VISIBLE_FRAME_BORDER_THICKNESS := 37
    static DWMWA_SYSTEMBACKDROP_TYPE := 38
    static DWMWA_REDIRECTIONBITMAP_ALPHA := 39
    static DWMWA_BORDER_MARGINS := 40
    static DWMWA_LAST := 41
}
struct DWM_WINDOW_CORNER_PREFERENCE extends Int32 {
    static DWMWCP_DEFAULT := 0
    static DWMWCP_DONOTROUND := 1
    static DWMWCP_ROUND := 2
    static DWMWCP_ROUNDSMALL := 3
}
struct DWM_SYSTEMBACKDROP_TYPE extends Int32 {
    static DWMSBT_AUTO := 0
    static DWMSBT_NONE := 1
    static DWMSBT_MAINWINDOW := 2
    static DWMSBT_TRANSIENTWINDOW := 3
    static DWMSBT_TABBEDWINDOW := 4
}
struct DWMNCRENDERINGPOLICY extends Int32 {
    static DWMNCRP_USEWINDOWSTYLE := 0
    static DWMNCRP_DISABLED := 1
    static DWMNCRP_ENABLED := 2
    static DWMNCRP_LAST := 3
}
struct DWMFLIP3DWINDOWPOLICY extends Int32 {
    static DWMFLIP3D_DEFAULT := 0
    static DWMFLIP3D_EXCLUDEBELOW := 1
    static DWMFLIP3D_EXCLUDEABOVE := 2
    static DWMFLIP3D_LAST := 3
}
struct DWM_THUMBNAIL_PROPERTIES {
    dwFlags : UInt32
    rcDestination : RECT
    rcSource : RECT
    opacity : UInt8
    fVisible : BOOL
    fSourceClientAreaOnly : BOOL
}
struct UNSIGNED_RATIO {
    uiNumerator : UInt32
    uiDenominator : UInt32
}
struct DWM_TIMING_INFO {
    cbSize : UInt32 := this.Size
    rateRefresh : UNSIGNED_RATIO
    qpcRefreshPeriod : Int64
    rateCompose : UNSIGNED_RATIO
    qpcVBlank : Int64
    cRefresh : Int64
    cDXRefresh : UInt32
    qpcCompose : Int64
    cFrame : Int64
    cDXPresent : UInt32
    cRefreshFrame : Int64
    cFrameSubmitted : Int64
    cDXPresentSubmitted : UInt32
    cFrameConfirmed : Int64
    cDXPresentConfirmed : UInt32
    cRefreshConfirmed : Int64
    cDXRefreshConfirmed : UInt32
    cFramesLate : Int64
    cFramesOutstanding : UInt32
    cFrameDisplayed : Int64
    qpcFrameDisplayed : Int64
    cRefreshFrameDisplayed : Int64
    cFrameComplete : Int64
    qpcFrameComplete : Int64
    cFramePending : Int64
    qpcFramePending : Int64
    cFramesDisplayed : Int64
    cFramesComplete : Int64
    cFramesPending : Int64
    cFramesAvailable : Int64
    cFramesDropped : Int64
    cFramesMissed : Int64
    cRefreshNextDisplayed : Int64
    cRefreshNextPresented : Int64
    cRefreshesDisplayed : Int64
    cRefreshesPresented : Int64
    cRefreshStarted : Int64
    cPixelsReceived : Int64
    cPixelsDrawn : Int64
    cBuffersEmpty : Int64
}
struct DWM_SOURCE_FRAME_SAMPLING extends Int32 {
    static DWM_SOURCE_FRAME_SAMPLING_POINT := 0
    static DWM_SOURCE_FRAME_SAMPLING_COVERAGE := 1
    static DWM_SOURCE_FRAME_SAMPLING_LAST := 2
}
struct DWM_PRESENT_PARAMETERS {
    cbSize : UInt32 := this.Size
    fQueue : BOOL
    cRefreshStart : Int64
    cBuffer : UInt32
    fUseSourceRate : BOOL
    rateSource : UNSIGNED_RATIO
    cRefreshesPerFrame : UInt32
    eSampling : DWM_SOURCE_FRAME_SAMPLING
}
struct MilMatrix3x2D {
    S_11 : Float64
    S_12 : Float64
    S_21 : Float64
    S_22 : Float64
    DX : Float64
    DY : Float64
}
struct DWMTRANSITION_OWNEDWINDOW_TARGET extends Int32 {
    static DWMTRANSITION_OWNEDWINDOW_NULL := -1
    static DWMTRANSITION_OWNEDWINDOW_REPOSITION := 0
}
struct GESTURE_TYPE extends Int32 {
    static GT_PEN_TAP := 0
    static GT_PEN_DOUBLETAP := 1
    static GT_PEN_RIGHTTAP := 2
    static GT_PEN_PRESSANDHOLD := 3
    static GT_PEN_PRESSANDHOLDABORT := 4
    static GT_TOUCH_TAP := 5
    static GT_TOUCH_DOUBLETAP := 6
    static GT_TOUCH_RIGHTTAP := 7
    static GT_TOUCH_PRESSANDHOLD := 8
    static GT_TOUCH_PRESSANDHOLDABORT := 9
    static GT_TOUCH_PRESSANDTAP := 10
}
struct DWM_SHOWCONTACT extends UInt32 {
    static DWMSC_DOWN := 1
    static DWMSC_UP := 2
    static DWMSC_DRAG := 4
    static DWMSC_HOLD := 8
    static DWMSC_PENBARREL := 16
    static DWMSC_NONE := 0
    static DWMSC_ALL := 4294967295
}
struct DWM_TAB_WINDOW_REQUIREMENTS extends Int32 {
    static DWMTWR_NONE := 0
    static DWMTWR_IMPLEMENTED_BY_SYSTEM := 1
    static DWMTWR_WINDOW_RELATIONSHIP := 2
    static DWMTWR_WINDOW_STYLES := 4
    static DWMTWR_WINDOW_REGION := 8
    static DWMTWR_WINDOW_DWM_ATTRIBUTES := 16
    static DWMTWR_WINDOW_MARGINS := 32
    static DWMTWR_TABBING_ENABLED := 64
    static DWMTWR_USER_POLICY := 128
    static DWMTWR_GROUP_POLICY := 256
    static DWMTWR_APP_COMPAT := 512
}
