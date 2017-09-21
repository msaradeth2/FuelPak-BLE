//
//  EAController.m
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/21/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

#import "EAController.h"

//@interface EAController ()
//{
//    
//    NSString    *localeAlertTitle;
//    NSString    *localeAlertButtonZero;
//    NSString    *localeAlertButtonOne;
//}
//
//@end


@implementation EAController
{
    
}

@synthesize langBundle;


static EAController *_eaController=nil;

+ (id)sharedController
{
        
    if (_eaController == nil)
    {
        _eaController = [[EAController alloc] init];
        [_eaController initVariables];
    }
    
    return _eaController;
}


- (void) initVariables
{
    printf("EAController init() creating class\n");
    
    
    NSString *languagecode = [[EAController sharedController] getPreferredLanguageCode];
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Localizable" ofType:@"strings" inDirectory:nil forLocalization:languagecode];
    
    if (bundlePath == nil) {
        bundlePath = [[NSBundle mainBundle] pathForResource:@"Localizable" ofType:@"strings" inDirectory:nil forLocalization:@"en"];
    }
    langBundle = [[NSBundle alloc] initWithPath:[bundlePath stringByDeletingLastPathComponent]];
    
    _themeIndex = 0;
    [self initThemeDefault];
    
}


- (NSString*) getPreferredLanguageCode
{
    
    NSString *languagecode = [[NSBundle mainBundle] preferredLocalizations].firstObject;
    
    return languagecode;
}



- (void) initThemeDefault
{
    
    //_themeHomeBackground    = @"background36.png";
    //_themeHomeBackground2   = @"background36_568h.png";
    //_themeGeneralBackground = @"background33.png";
    
    
    _themeGeneralActivityColor   = [[UIColor alloc] initWithRed:0.925 green:0.925 blue:0.925 alpha:1.0];
    
    _themeGeneralActiveTextColor = [[UIColor alloc] initWithRed:0.0 green:0.674 blue:0.923 alpha:1.0];
    _themeGeneralDemoTextColor   = [[UIColor alloc] initWithRed:0.0 green:0.674 blue:0.923 alpha:1.0];
    
    
    _themeCellHeight          = 93.0;
    _themeCellBkgColor        = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    _themeCellBkgView         = @"cellgradient.png";
    _themeCellBkgViewSelected = @"cellgradient-over.png";
    _themeCellTextFontSize      = 17.0;
    _themeCellTextFont          = @"HelveticaNeue";
    _themeCellTextColor         = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    _themeCellTextColorSelected = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    _themeCellTextBkgColor      = [[UIColor alloc] initWithRed:0.0 green:1.0 blue:1.0 alpha:0.0];
    _themeCellTextBkgOpaque     = TRUE;
    
    _themeCellDetailTextColor    = [[UIColor alloc] initWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    _themeCellDetailTextFont     = @"HelveticNeue";
    _themeCellDetailTextFontSize = 17.0;
    _themeCellDetailBkgColor     = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
    _themeCellDisclosure         = @"menu_disclosure.png";
    _themeCellSeparatorColor     = [[UIColor alloc] initWithRed:0.2 green:0.2 blue:0.2 alpha:0.0];
    
    
    _themeButtonColor              = [[UIColor alloc] initWithRed:0.6 green: 0.4 blue:0.2 alpha:1.0];
    _themeButtonTitleColor         = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    _themeButtonTitleColorSelected = [[UIColor alloc] initWithRed:0.2 green: 0.2 blue:0.2 alpha:1.0];
    _themeButtonTextFont           = @"HelveticaNeue-Light";
    _themeButtonTextFontSize       = 16.0;
    _themeButtonBkg                = @"cellgradient.png";
    _themeButtonBkgSelected        = @"cellgradient.png";
    _themeButtonGradientStart      = [[UIColor alloc] initWithRed:1.0 green:0.5 blue:0.3 alpha:0.0];
    _themeButtonGradientEnd        = [[UIColor alloc] initWithRed:0.0 green: 0.0 blue:0.0 alpha:0.0];
    _themeButtonColorOverGradient  = FALSE;
    
    
    _themeBadgeBkgColor         = [[UIColor alloc] initWithRed:0.0 green:0.674 blue:0.923 alpha:1.0];
    _themeBadgeBkgColorSelected = [[UIColor alloc] initWithRed:0.0 green:0.674*0.5 blue:0.923*0.5 alpha:1.0];
    _themeBadgeTextColor        = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    
    _themeNavBarBkg          = @"cellgradient-nav.png";
    _themeNavBarBkgLandscape = @"cellgradient-nav.png";
    _themeNavBarAlpha = 1.0;
    _themeNavBarHidden = FALSE;
    _themeNavBarColorOverGradient = FALSE;
    _themeNavBarTintColor       = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    _themeNavBarTextColor       = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    _themeNavBarTextShadowColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    
    
    
    
    
    _themeNavButtonShape = TRUE;
    _themeNavButtonBkg           = @"nav_clear5e.png";
    _themeNavButtonBkgLandscape  = @"nav_clear5e.png";
    _themeNavButtonTintColor     = [[UIColor alloc] initWithRed:0.745 green:0.118 blue:0.176 alpha:1.0];
    
    
    _themeNavButtonImageRight    = @"nav_right.png";
    _themeNavButtonImageDown     = @"nav_down.png";
    
    _themeLiveMainHomeBtn        = @"nav_home.png";
    _themeMainMenuNavbarbtnRight = @"nav_info.png";
    _themeMainMenuNavbarbtnLeft  = @"nav_back.png";
    _themeEditMainNavbarbtnRight = @"nav_flash.png";
    _themeEditSlotNavbarbtnRight = @"nav_trash.png";
    
    
    _themeMainMenuCustomerSupport = @"icon_customersupport.png";
    _themeMainMenuDtcCodes        = @"icon_readdtccodes.png";
    _themeMainMenuEditMaps        = @"icon_calibrationmaps.png";
    _themeMainMenuFp3Info         = @"icon_readsysteminfo.png";
    _themeMainMenuLivedata        = @"icon_seelivedata.png";
    _themeMainMenuResetStock      = @"icon_resettostock.png";
    _themeMainMenuSearchMap       = @"icon_searchformap.png";
    _themeMainMenuAutotune        = @"icon_autotune.png";
    
    
    _themeDemoMenuLinkOn    =  @"icon_okayon.png";
    _themeDemoMenuLinkOff   =  @"icon_unabletofind.png";
    _themeDemoMenuWifiOn    =  @"icon_internetaccess.png";
    _themeDemoMenuWifiOff   =  @"icon_internetaccess_off.png";
    _themeDemoMenuCart      =  @"icon_cart.png";
    _themeDemoMenuPairBt    =  @"icon_bluetooth.png";
    _themeDemoMenuPairBtVin =  @"icon_vin.png";
    _themeDemoMenuDemo      =  @"icon_demo.png";
    
    
    
    
    _themeLiveCenter     = @"gauge_center.png";
    _themeLiveNeedle     = @"gauge_needle2.png";
    _themeLiveNeedleGear = @"gauge_needlegear2.png";
    
    _themeLiveMiniDial1  = @"cellminidialclear.png";
    _themeLiveMiniDial2  = @"cellminidialclear.png";
    _themeLiveMiniDial3  = @"cellminidialclear.png";
    _themeLiveMiniDial4  = @"cellminidialclear.png";
    
    
    _themeLiveMainDial0  = @"gauge_maindial_rpm.png";  // @"gauge_dial_rpm.png";
    _themeLiveMainDial1  = @"gauge_maindial_batt.png"; // @"gauge_dial_battery.png";
    _themeLiveMainDial2  = @"gauge_maindial_et.png";  //@"gauge_dial_engtemp.png";
    _themeLiveMainDial3  = @"gauge_maindial_mph.png"; //@"gauge_dial_speed_mph.png";
    _themeLiveMainDial4  = @"gauge_maindial_tps.png";  //@"gauge_dial_tps.png";
    _themeLiveMainDial5  = @"gauge_dial_intaketemp.png";
    _themeLiveMainDial6  = @"gauge_maindial_map.png"; //@"gauge_dial_map.png";
    _themeLiveMainDial7  = @"gauge_maindial_fad.png"; //@"gauge_dial_frtsprkadv.png";
    _themeLiveMainDial8  = @"gauge_maindial_rad.png"; //@"gauge_dial_rearsprkadv.png";
    _themeLiveMainDial9  = @"gauge_maindial_gear.png"; //@"gauge_dial_gear.png";
    
    
    _themeLiveMiniDial1feed =  @"cellminidialclear.png";
    _themeLiveMiniDial2feed =  @"cellminidialclear.png";
    _themeLiveMiniDial3feed =  @"cellminidialclear.png";
    _themeLiveMiniDial4feed =  @"cellminidialclear.png";
    
    
    _themeLivePortrait           =  @"wheel_fullbkg.png";    // small screen
    _themeLivePortraitUpsideDown =  @"wheel_fullbkg.png";    // big screen
    _themeLiveLandscapeLeft      =  @"wheel_fullbkg.png";    // small screen
    _themeLiveLandscapeRight     =  @"wheel_fullbkg.png";    // big screen
    
    
    _themeWheelDial       =  @"wheel_bkg2.png";
    _themeWheelCenter     =  @"wheel_center.png";
    _themeWheelCenterFeed =  @"gauge_feedback.png";
    _themeWheelCenterSel  =  @"gauge_feedback.png";
    _themeWheelSegment    =  @"wheel_segment.png";
    
    _themeWheelIcon0  =  @"wheel_icon_rpm.png";
    _themeWheelIcon1  =  @"wheel_icon_battery.png";
    _themeWheelIcon2  =  @"wheel_icon_engtemp.png";
    _themeWheelIcon3  =  @"wheel_icon_speed_mph.png";
    _themeWheelIcon4  =  @"wheel_icon_tps.png";
    _themeWheelIcon5  =  @"wheel_icon_eco.png";
    _themeWheelIcon6  =  @"wheel_icon_map.png";
    _themeWheelIcon7  =  @"wheel_icon_frtsprkadv.png";
    _themeWheelIcon8  =  @"wheel_icon_rearsprkadv.png";
    _themeWheelIcon9  =  @"wheel_icon_gear.png";
    
    _themeWheelIcon10 =  @"wheel_icon10.png";
    _themeWheelIcon11 =  @"wheel_icon11.png";
    _themeWheelIcon12 =  @"wheel_icon12.png";
    _themeWheelIcon13 =  @"wheel_icon_speed_kph.png";
    _themeWheelIcon14 =  @"wheel_icon14.png";
    _themeWheelIcon15 =  @"wheel_icon15.png";
    _themeWheelIcon16 =  @"wheel_icon16.png";
    _themeWheelIcon17 =  @"wheel_icon17.png";
    _themeWheelIcon18 =  @"wheel_icon18.png";
    _themeWheelIcon19 =  @"wheel_icon19.png";
    _themeWheelIcon20 =  @"gauge_maindial_kph.png";  //@"gauge_dial_speed_kph.png";
    _themeWheelIcon21 =  @"gauge_maindial_et_cel.png"; //@"gauge_dial_engtemp_cel.png";
    _themeWheelIcon22 =  @"gauge_dial_intaketemp_cel.png";
    _themeWheelIcon23 =  @"wheel_icon23.png";
    _themeWheelIcon24 =  @"wheel_icon24.png";
    
    
    _themeProgWheelIcon1 =  @"prog_dimple.png";
    _themeProgWheelIcon2 =  @"prog_icon2.png";
    _themeProgWheelIcon3 =  @"prog_icon3.png";
    
    
    _themeWheelMiniDial1feed =  @"gauge_feedback_upperleft.png";
    _themeWheelMiniDial2feed =  @"gauge_feedback_upperright.png";
    _themeWheelMiniDial3feed =  @"gauge_feedback_lowerright.png";
    _themeWheelMiniDial4feed =  @"gauge_feedback_lowerleft.png";
    
    _themeWheelMiniDial1feedp =  @"gauge_feedback.png";
    _themeWheelMiniDial2feedp =  @"gauge_feedback.png";
    _themeWheelMiniDial3feedp =  @"gauge_feedback.png";
    _themeWheelMiniDial4feedp =  @"gauge_feedback.png";
    
    _themeWheelMiniDial1feedn =  @"gauge_feedback.png";
    _themeWheelMiniDial2feedn =  @"gauge_feedback.png";
    _themeWheelMiniDial3feedn =  @"gauge_feedback.png";
    _themeWheelMiniDial4feedn =  @"gauge_feedback.png";
    
    
    _themeWheelDialRectWidth    = 320.0;
    _themeWheelDialRectHeight   = 320.0;
    
    _themeWheelCenterRectWidth  = 100.0;
    _themeWheelCenterRectHeight = 100.0;
    
    _themeWheelCenterFeedRectWidth  = 120.0;
    _themeWheelCenterFeedRectHeight = 120.0;
    
    _themeWheelSegmentRectWidth = 90.0;
    _themeWheelSegmentRectHeight= 150.0;
    
    _themeWheelIconSegments     = 10;
    _themeWheelIconOffsetX      = 7;
    _themeWheelIconOffsetY      = 10.0;
    _themeWheelIconRectWidth    = 75.0;
    _themeWheelIconRectHeight   = 75.0;
    
    
    
    _themeLiveTextMainColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    _themeLiveTextMainFontName = @"DS-Digital";//_themeLiveTextMainFontName = [[NSString alloc] initWithString:@"LEDFixedWidthSemiCondenseBold"];
    _themeLiveTextMainFontSize = 92;//115;// 92.0;
    
    
    _themeLiveTextDescColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    _themeLiveTextDescFontName = @"Acens";//_themeLiveTextDescFontName = [[NSString alloc] initWithString:@"LEDFixedWidthSemiCondenseBold"];
    
    _themeLiveTextDescFontSize = 48.0; //75.0; //48.0;
    
    
    _themeLiveTextMiniColor = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    _themeLiveTextMiniFontName = @"DS-Digital"; //_themeLiveTextMiniFontName = [[NSString alloc] initWithString:@"LEDFixedWidthSemiCondenseBold"];
    _themeLiveTextMiniFontSize = 44.0;
    
    
    _themeDataCellBackgroundView  = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeCellBkgView]];
    _themeDataCellSelectedBackgroundView = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeCellBkgViewSelected]];
    _themeDataCellAccessoryViewInitWithImage = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeCellDisclosure]];
    _themeDataButtonBackgroundImageForControlStateNormal = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeButtonBkg]];
    _themeDataButtonBackgroundImageForControlStateHighlighted = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeButtonBkgSelected]];
    
    
    _themeDataNavBarBackgroundImageForBarMetricsDefaultName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeNavBarBkg]];
    _themeDataNavBarBackgroundImageForBarMetricsLandscapePhone = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeNavBarBkgLandscape]];
    _themeDataNavButtonRightBackgroundImageForBarMetricsDefaultName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeNavButtonBkg]];
    _themeDataNavButtonRightBackgroundImageForBarMetricsLandscapePhone = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeNavButtonBkgLandscape]];
    _themeDataNavButtonRightImage = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeNavButtonImageRight]];
    _themeDataNavButtonDownImage = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeNavButtonImageDown]];
    
    _themeDataMainMenuEditMapsImageName   = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuEditMaps]];
    _themeDataMainMenuFP3InfoImageName    = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuFp3Info]];
    _themeDataMainMenuSearchMapImageName  = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuSearchMap]];
    _themeDataMainMenuDtcCodesImageName   = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuDtcCodes]];
    _themeDataMainMenuResetStockImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuResetStock]];
    _themeDataMainMenuAutotuneName        = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuAutotune]];
    
    _themeDataMainMenuCustomerSupportImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuCustomerSupport]];
    
    _themeDataMainMenuLiveDataImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuLivedata]];
    _themeDataMainMenuNavBarBtnRight = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuNavbarbtnRight]];
    _themeDataMainMenuNavBarBtnLeft  = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuNavbarbtnLeft]];
    
    _themeDataDemoMenuLinked   = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuLinkOn]];
    _themeDataDemoMenuUnLinked = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuLinkOff]];
    _themeDataDemoMenuWifiOn   = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuWifiOn]];
    _themeDataDemoMenuWifiOff  = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuWifiOff]];
    _themeDataDemoMenuCart     = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuCart]];
    
    _themeDataDemoMenuPairBt    = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuPairBt]];
    _themeDataDemoMenuPairBtVin = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuPairBtVin]];
    _themeDataDemoMenuDemo      = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuDemo]];
    
    _themeDataLiveCenter = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveCenter]];
    _themeDataLiveNeedle = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveNeedle]];
    _themeDataLiveNeedleGear = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveNeedleGear]];
    
    _themeDataLiveMiniDial1 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial1]];
    _themeDataLiveMiniDial2 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial2]];
    _themeDataLiveMiniDial3 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial3]];
    _themeDataLiveMiniDial4 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial4]];
    
    _themeDataLiveMiniDial1feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial1feed]];
    _themeDataLiveMiniDial2feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial2feed]];
    _themeDataLiveMiniDial3feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial3feed]];
    _themeDataLiveMiniDial4feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial4feed]];
    
    
    _themeDataLiveMainHomeBtn = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainHomeBtn]];
    
    _themeDataLiveMainDial0 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial0]];
    _themeDataLiveMainDial1 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial1]];
    _themeDataLiveMainDial2 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial2]];
    _themeDataLiveMainDial3 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial3]];
    _themeDataLiveMainDial4 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial4]];
    _themeDataLiveMainDial5 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial5]];
    _themeDataLiveMainDial6 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial6]];
    _themeDataLiveMainDial7 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial7]];
    _themeDataLiveMainDial8 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial8]];
    _themeDataLiveMainDial9 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial9]];
    
    
    _themeDataLivePortrait = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLivePortrait]];
    _themeDataLivePortraitUpsideDown = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLivePortraitUpsideDown]];
    _themeDataLiveLandscapeLeft = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveLandscapeLeft]];
    _themeDataLiveLandscapeRight = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveLandscapeRight]];
    
    _themeDataEditMenuNavBarBtnRight = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeEditMainNavbarbtnRight]];
    _themeDataEditSlotNavBarBtnRight = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeEditSlotNavbarbtnRight]];
    
    
    
    _themeDataWheelDial = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelDial]];
    _themeDataWheelCenter = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelCenter]];
    _themeDataWheelCenterFeed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelCenterFeed]];
    _themeDataWheelCenterSel = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelCenterSel]];
    _themeDataWheelSegment = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelSegment]];
    
    _themeDataWheelIcon0 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon0]];
    _themeDataWheelIcon1 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon1]];
    _themeDataWheelIcon2 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon2]];
    _themeDataWheelIcon3 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon3]];
    _themeDataWheelIcon4 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon4]];
    _themeDataWheelIcon5 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon5]];
    _themeDataWheelIcon6 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon6]];
    _themeDataWheelIcon7 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon7]];
    _themeDataWheelIcon8 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon8]];
    _themeDataWheelIcon9 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon9]];
    
    _themeDataWheelIcon10 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon10]];
    _themeDataWheelIcon11 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon11]];
    _themeDataWheelIcon12 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon12]];
    _themeDataWheelIcon13 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon13]];
    _themeDataWheelIcon14 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon14]];
    _themeDataWheelIcon15 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon15]];
    _themeDataWheelIcon16 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon16]];
    _themeDataWheelIcon17 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon17]];
    _themeDataWheelIcon18 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon18]];
    _themeDataWheelIcon19 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon19]];
    
    _themeDataWheelIcon20 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon20]];
    _themeDataWheelIcon21 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon21]];
    _themeDataWheelIcon22 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon22]];
    _themeDataWheelIcon23 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon23]];
    _themeDataWheelIcon24 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon24]];
    
    
    
    _themeDataProgWheelIcon1 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeProgWheelIcon1]];
    _themeDataProgWheelIcon2 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeProgWheelIcon2]];
    _themeDataProgWheelIcon3 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeProgWheelIcon3]];
    
    
    
    _themeDataWheelMiniDial1feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial1feed]];
    _themeDataWheelMiniDial2feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial2feed]];
    _themeDataWheelMiniDial3feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial3feed]];
    _themeDataWheelMiniDial4feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial4feed]];
    
    
    _themeDataWheelMiniDial1feedp = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial1feedp]];
    _themeDataWheelMiniDial2feedp = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial2feedp]];
    _themeDataWheelMiniDial3feedp = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial3feedp]];
    _themeDataWheelMiniDial4feedp = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial4feedp]];
    
    
    _themeDataWheelMiniDial1feedn = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial1feedn]];
    _themeDataWheelMiniDial2feedn = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial2feedn]];
    _themeDataWheelMiniDial3feedn = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial3feedn]];
    _themeDataWheelMiniDial4feedn = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial4feedn]];
    
    
    _searchMapSearchExhaustManu   = @"";
    _searchMapSearchExhaustType   = @"";
    _searchMapSearchExhaustBaffle = @"";
    _searchMapSearchEngineSize    = @"";
    _searchCalId                  = @"";
    
#ifdef DEV_SERVER
    //    _searchMapUrl   = @"https://dev.vhfp3.com/development/Services/api.php";
    _searchMediaUrl = @"https://dev.vhfp3.com";
    _OtaUrl         = @"www.dev.vhfp3.com";
    
#else
    //    _searchMapUrl   = @"https://vhfp3.com/development/Services/api.php";
    _searchMediaUrl = @"https://vhfp3.com";
    _OtaUrl         = @"www.m.vhfp3.com";
    
#endif
    
    //    for (NSString* family in [UIFont familyNames])
    //    {
    //        NSLog(@"%@", family);
    //        for (NSString* name in [UIFont fontNamesForFamilyName: family])
    //        {
    //            NSLog(@"  %@", name);
    //        }
    //    }
    //    
    
}






-(CGFloat) getMaxScreenSize
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGFloat value;
    
    //printf ("Screen size: [w:%.1f h:%.1f]\n\n", screenWidth, screenHeight );
    
    value = MAX( screenHeight, screenWidth);
    
    return (value);
}



-(CGFloat) getMinScreenSize
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGFloat value;
    
    //printf ("Screen size: [w:%.1f h:%.1f]\n\n", screenWidth, screenHeight );
    
    value = MIN( screenHeight, screenWidth);
    
    return (value);
}



#pragma mark -
#pragma mark General


- (NSData *) getBkgDataFromFileName: (NSString*)imagename;
{
    
    NSData  *data;
    
    // ANALYZE: remove questionable path
    //if ( _themeIndex != 0 )
    //{
    //    NSString    *urlpath =@"http://192.168.1.121/fp3";
    //    NSString    *srcUrl = [urlpath stringByAppendingPathComponent:imagename];
    //    NSURL       *aURL = [NSURL URLWithString:srcUrl];
    //    data = [[NSData alloc] initWithContentsOfURL:aURL];
    //}
    //else
    {
        //NSLog(@"%@", imagename);
        NSString *resourceDirectory = [[NSBundle mainBundle] resourcePath];
        NSString *imageFilePath = [resourceDirectory stringByAppendingPathComponent:imagename];
        
        //NSLog (@"imageFilePath\n%@\n", imageFilePath);
        data = [NSData dataWithContentsOfFile:imageFilePath options:0 error:nil];
    }
    
    return data;
}

/*
 - (void) setThemesIndex: (int)index
 {
 _themeIndex = index;
 
 if (index ==0)
 {
 [self initThemeDefault];
 
 }
 
 
 }
 */
- (int) getThemesIndex
{
    return _themeIndex;
}



/*
 - (void) setHomeBackgroundImageName: (NSString*)name
 {
 if ( _themeHomeBackground != nil)
 {
 //[_themeHomeBackground release];
 //_themeHomeBackground = [[NSString alloc] initWithString:name ];
 
 
 //[_themeDataHomeBackgroundImageName  release];
 //_themeDataHomeBackgroundImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeHomeBackground]];
 
 }
 }
 */
- (UIImage *) getHomeBackgroundImageName
{
    return _themeDataHomeBackgroundImageName;
}

/*
 - (void) setHomeBackgroundImageName2: (NSString*)name
 {
 if ( _themeHomeBackground2 != nil)
 {
 //[_themeHomeBackground2 release];
 //_themeHomeBackground2 = [[NSString alloc] initWithString:name ];
 
 
 //[_themeDataHomeBackgroundImageName2  release];
 //_themeDataHomeBackgroundImageName2 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeHomeBackground2]];
 
 }
 }
 */
- (UIImage *) getHomeBackgroundImageName2
{
    return _themeDataHomeBackgroundImageName2;
}


/*
 - (void) setBackgroundImageName: (NSString*)name
 {
 if ( _themeGeneralBackground != nil)
 {
 //[_themeGeneralBackground release];
 //_themeGeneralBackground = [[NSString alloc] initWithString:name ];
 
 //[_themeDataBackgroundImageName release];
 //_themeDataBackgroundImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeGeneralBackground]];
 
 //NSLog(@"SET backimage %@",_themeGeneralBackground);
 }
 }
 */
- (UIImage *) getBackgroundImageName
{
    return _themeDataBackgroundImageName;
}


/*
 - (void) setActivityColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 //NSLog (@"set %@ %f %f %f %f", color, r,g,b,a);
 
 if (_themeGeneralActivityColor != nil)
 {
 //[_themeGeneralActivityColor release];
 //_themeGeneralActivityColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getActivityColor
{
    return _themeGeneralActivityColor;
}



/*
 - (void) setActiveTextLabelTextColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 //NSLog (@"set %@ %f %f %f %f", color, r,g,b,a);
 
 if (_themeGeneralActiveTextColor != nil)
 {
 //[_themeGeneralActiveTextColor release];
 //_themeGeneralActiveTextColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
/*
 - (void) setDemoTextLabelTextColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 //NSLog (@"set %@ %f %f %f %f", color, r,g,b,a);
 
 if (_themeGeneralDemoTextColor != nil)
 {
 //[_themeGeneralDemoTextColor release];
 //_themeGeneralDemoTextColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */





#pragma mark -
#pragma mark Cell

/*
 - (void) setCellBackgroundColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeCellBkgColor != nil)
 {
 //[_themeCellBkgColor release];
 //_themeCellBkgColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getCellBackgroundColor
{
    return _themeCellBkgColor;
}


/*
 - (void) setCellBackgroundView: (NSString*)name
 {
 if ( _themeCellBkgView != nil)
 {
 //[_themeCellBkgView release];
 //_themeCellBkgView = [[NSString alloc] initWithString:name ];
 
 //[_themeDataCellBackgroundView release];
 //_themeDataCellBackgroundView = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeCellBkgView]];
 
 }
 }
 */
- (NSData *) getCellBackgroundView
{
    return _themeDataCellBackgroundView;
}


/*
 - (void) setCellSelectedBackgroundView: (NSString*)name
 {
 if ( _themeCellBkgViewSelected != nil)
 {
 //[_themeCellBkgViewSelected release];
 //_themeCellBkgViewSelected = [[NSString alloc] initWithString:name ];
 
 //[_themeDataCellSelectedBackgroundView release];
 //_themeDataCellSelectedBackgroundView = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeCellBkgViewSelected]];
 
 }
 }
 */
- (NSData *) getCellSelectedBackgroundView
{
    return _themeDataCellSelectedBackgroundView;
}


/*
 - (void) setCellSelectedTextLabelTextColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeCellTextColorSelected != nil)
 {
 //[_themeCellTextColorSelected release];
 //_themeCellTextColorSelected = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getCellSelectedTextLabelTextColor
{
    return _themeCellTextColorSelected;
}


/*
 - (void) setCellAccessoryViewInitWithImage: (NSString*)name
 {
 if ( _themeCellDisclosure != nil)
 {
 //[_themeCellDisclosure release];
 //_themeCellDisclosure = [[NSString alloc] initWithString:name ];
 
 //[_themeDataCellAccessoryViewInitWithImage release];
 //_themeDataCellAccessoryViewInitWithImage = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeCellDisclosure]];
 
 }
 }
 */
- (NSData *) getCellAccessoryViewInitWithImage
{
    return _themeDataCellAccessoryViewInitWithImage;
}


/*
 - (void) setCellHeight: (float)value
 {
 _themeCellHeight = value;
 }
 */
- ( float ) getCellHeight
{
    return _themeCellHeight;
}


/*
 - (void) setCellTextLabelTextColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeCellTextColor != nil)
 {
 //[_themeCellTextColor release];
 //_themeCellTextColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getCellTextLabelTextColor
{
    return _themeCellTextColor;
}


/*
 - (void) setCellTextLabelBackgroundColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeCellTextBkgColor != nil)
 {
 //[_themeCellTextBkgColor release];
 //_themeCellTextBkgColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getCellTextLabelBackgroundColor
{
    return _themeCellTextBkgColor;
}


/*
 - (void) setCellTextLabelOpaque: (BOOL)state
 {
 _themeCellTextBkgOpaque = state;
 }
 */
- ( BOOL ) getCellTextLabelOpaque
{
    return _themeCellTextBkgOpaque;
    //return ( TRUE );
}


/*
 - (void) setCellTextLabelFontName: (NSString*)name
 {
 if ( _themeCellTextFont != nil)
 {
 //[_themeCellTextFont release];
 //_themeCellTextFont = [[NSString alloc] initWithString:name ];
 }
 }
 */
- (NSString *) getCellTextLabelFontName
{
    return _themeCellTextFont;
}


/*
 - (void) setCellTextLabelFontSize: (float)value
 {
 _themeCellTextFontSize = value;
 }
 */
- ( float ) getCellTextLabelFontSize
{
    return _themeCellTextFontSize;
}



/*
 - (void) setCellDetailTextLabelTextColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeCellDetailTextColor != nil)
 {
 //[_themeCellDetailTextColor release];
 //_themeCellDetailTextColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getCellDetailTextLabelTextColor
{
    return _themeCellDetailTextColor;
}


/*
 - (void) setCellDetailTextLabelBackgroundColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeCellDetailBkgColor != nil)
 {
 //[_themeCellDetailBkgColor release];
 //_themeCellDetailBkgColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getCellDetailTextLabelBackgroundColor
{
    return _themeCellDetailBkgColor;
}



/*
 - (void) setCellDetailTextLabelFontName: (NSString*)name
 {
 if ( _themeCellDetailTextFont != nil)
 {
 //[_themeCellDetailTextFont release];
 //_themeCellDetailTextFont = [[NSString alloc] initWithString:name ];
 }
 }
 */
- (NSString *) getCellDetailTextLabelFontName
{
    return _themeCellDetailTextFont;
}

/*
 - (void) setCellDetailTextLabelFontSize: (float)value
 {
 _themeCellDetailTextFontSize = value;
 }
 */
- ( float ) getCellDetailTextLabelFontSize
{
    return _themeCellDetailTextFontSize;
}


/*
 - (void) setCellSeparatorColor: (UIColor*)color;
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeCellSeparatorColor != nil)
 {
 //[_themeCellSeparatorColor release];
 //_themeCellSeparatorColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getCellSeparatorColor
{
    return _themeCellSeparatorColor;
}


#pragma mark -
#pragma mark Button
/*
 -(void) setButtonColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeButtonColor != nil)
 {
 //[_themeButtonColor release];
 //_themeButtonColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getButtonColor
{
    return _themeButtonColor;
}


/*
 - (void) setButtonTitleColorForControlStateNormal: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeButtonTitleColor != nil)
 {
 //[_themeButtonTitleColor release];
 //_themeButtonTitleColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getButtonTitleColorForControlStateNormal
{
    return _themeButtonTitleColor;
}


/*
 - (void) setButtonTitleColorForControlStateSelected: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeButtonTitleColorSelected != nil)
 {
 //[_themeButtonTitleColorSelected release];
 //_themeButtonTitleColorSelected = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getButtonTitleColorForControlStateSelected
{
    return _themeButtonTitleColorSelected;
}


/*
 - (void) setButtonTitleLabelFontName: (NSString*)name
 {
 if ( _themeButtonTextFont != nil)
 {
 //[_themeButtonTextFont release];
 //_themeButtonTextFont = [[NSString alloc] initWithString:name ];
 }
 }
 */
- ( NSString *) getButtonTitleLabelFontName
{
    return _themeButtonTextFont;
}



/*
 - (void) setButtonTitleLabelFontSize: (float)value
 {
 _themeButtonTextFontSize = value;
 }
 */
- ( float ) getButtonTitleLabelFontSize
{
    return _themeButtonTextFontSize;
}


/*
 - (void) setButtonBackgroundImageForControlStateNormal: (NSString*)name
 {
 if ( _themeButtonBkg != nil)
 {
 //[_themeButtonBkg release];
 //_themeButtonBkg = [[NSString alloc] initWithString:name ];
 
 //[_themeDataButtonBackgroundImageForControlStateNormal release];
 //_themeDataButtonBackgroundImageForControlStateNormal = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeButtonBkg]];
 
 }
 }
 */
- (NSData *) getButtonBackgroundImageForControlStateNormal
{
    return _themeDataButtonBackgroundImageForControlStateNormal;
}



/*
 - (void) setButtonBackgroundImageForControlStateHighlighted: (NSString*)name
 {
 if ( _themeButtonBkgSelected != nil)
 {
 //[_themeButtonBkgSelected release];
 //_themeButtonBkgSelected = [[NSString alloc] initWithString:name ];
 
 //[_themeDataButtonBackgroundImageForControlStateHighlighted release];
 //_themeDataButtonBackgroundImageForControlStateHighlighted = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeButtonBkgSelected]];
 
 }
 }
 */
- (NSData *) getButtonBackgroundImageForControlStateHighlighted
{
    return _themeDataButtonBackgroundImageForControlStateHighlighted;
}



/*
 - (void) setButtonGradientStart: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeButtonGradientStart != nil)
 {
 //[_themeButtonGradientStart release];
 //_themeButtonGradientStart = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getButtonGradientStart
{
    return _themeButtonGradientStart;
}


/*
 - (void) setButtonGradientEnd: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeButtonGradientEnd != nil)
 {
 //[_themeButtonGradientEnd release];
 //_themeButtonGradientEnd = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getButtonGradientEnd
{
    return _themeButtonGradientEnd;
}


/*
 - (void) setButtonColorOverwritesGradient: (BOOL)state
 {
 _themeButtonColorOverGradient  = state;
 }
 */
- (BOOL) getButtonColorOverwritesGradient
{
    return _themeButtonColorOverGradient;
}






#pragma mark -
#pragma mark Badge

/*
 - (void) setBadgeBackgroundColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeBadgeBkgColor != nil)
 {
 //[_themeBadgeBkgColor release];
 //_themeBadgeBkgColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getBadgeBackgroundColor
{
    return _themeBadgeBkgColor;
}


/*
 -(void) setBadgeTextColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeBadgeTextColor != nil)
 {
 //[_themeBadgeTextColor release];
 //_themeBadgeTextColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getBadgeTextColor
{
    return _themeBadgeTextColor;
}


/*
 - (void) setBadgeSelectedBackgroundColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeBadgeBkgColorSelected != nil)
 {
 //[_themeBadgeBkgColorSelected release];
 //_themeBadgeBkgColorSelected = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getBadgeSelectedBackgroundColor
{
    return _themeBadgeBkgColorSelected;
}



#pragma mark -
#pragma mark Navigation Bar

/*
 - (void) setNavBarBackgroundImageForBarMetricsDefaultName: (NSString*)name
 {
 if ( _themeNavBarBkg != nil)
 {
 //[_themeNavBarBkg release];
 //_themeNavBarBkg = [[NSString alloc] initWithString:name ];
 
 //[_themeDataNavBarBackgroundImageForBarMetricsDefaultName release];
 //_themeDataNavBarBackgroundImageForBarMetricsDefaultName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeNavBarBkg]];
 
 }
 }
 */
- ( NSData *) getNavBarBackgroundImageForBarMetricsDefaultName
{
    return _themeDataNavBarBackgroundImageForBarMetricsDefaultName;
}


/*
 - (void) setNavBarBackgroundImageForBarMetricsLandscapePhone: (NSString*)name
 {
 if ( _themeNavBarBkgLandscape != nil)
 {
 //[_themeNavBarBkgLandscape release];
 //_themeNavBarBkgLandscape = [[NSString alloc] initWithString:name ];
 
 //[_themeDataNavBarBackgroundImageForBarMetricsLandscapePhone release];
 //_themeDataNavBarBackgroundImageForBarMetricsLandscapePhone = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeNavBarBkgLandscape]];
 
 }
 }
 */
- ( NSData *) getNavBarBackgroundImageForBarMetricsLandscapePhone
{
    return _themeDataNavBarBackgroundImageForBarMetricsLandscapePhone;
}


/*
 - (void) setNavBarAlpha: (float)value
 {
 _themeNavBarAlpha = value;
 }
 */
- (float) getNavBarAlpha
{
    return _themeNavBarAlpha;
}


/*
 - (void) setNavBarHidden: (BOOL)state
 {
 _themeNavBarHidden = state;
 }
 */
- (BOOL) getNavBarHidden
{
    return _themeNavBarHidden;
}


/*
 - (void) setNavBarColorOverwritesGradient: (BOOL)state
 {
 _themeNavBarColorOverGradient  = state;
 }
 */
- (BOOL) getNavBarColorOverwritesGradient
{
    return _themeNavBarColorOverGradient;
}



/*
 - (void) setNavBarTintColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeNavBarTintColor != nil)
 {
 //[_themeNavBarTintColor release];
 //_themeNavBarTintColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- (UIColor *) getNavBarTintColor
{
    return _themeNavBarTintColor;
}



/*
 - (void) setNavBarTitleTextColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeNavBarTextColor != nil)
 {
 //[_themeNavBarTextColor release];
 //_themeNavBarTextColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- (UIColor *) getNavBarTitleTextColor
{
    return _themeNavBarTextColor;
}



/*
 - (void) setNavBarTitleTextColorShadow: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeNavBarTextShadowColor != nil)
 {
 //[_themeNavBarTextShadowColor release];
 //_themeNavBarTextShadowColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- (UIColor *) getNavBarTitleTextColorShadow
{
    return _themeNavBarTextShadowColor;
}




#pragma mark -
#pragma mark Navigation Button


/*
 - (void) setNavButtonRightBackgroundImageForBarMetricsDefaultName: (NSString*)name
 {
 if ( _themeNavButtonBkg != nil)
 {
 //[_themeNavButtonBkg release];
 //_themeNavButtonBkg = [[NSString alloc] initWithString:name ];
 
 //[_themeDataNavButtonRightBackgroundImageForBarMetricsDefaultName release];
 //_themeDataNavButtonRightBackgroundImageForBarMetricsDefaultName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeNavButtonBkg]];
 
 }
 }
 */
- ( NSData *) getNavButtonRightBackgroundImageForBarMetricsDefaultName
{
    return _themeDataNavButtonRightBackgroundImageForBarMetricsDefaultName;
}


/*
 - (void) setNavButtonRightBackgroundImageForBarMetricsLandscapePhone: (NSString*)name
 {
 if ( _themeNavButtonBkgLandscape != nil)
 {
 //[_themeNavButtonBkgLandscape release];
 //_themeNavButtonBkgLandscape = [[NSString alloc] initWithString:name ];
 
 //[_themeDataNavButtonRightBackgroundImageForBarMetricsLandscapePhone release];
 //_themeDataNavButtonRightBackgroundImageForBarMetricsLandscapePhone = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeNavButtonBkgLandscape]];
 }
 }
 */
- ( NSData *) getNavButtonRightBackgroundImageForBarMetricsLandscapePhone
{
    return _themeDataNavButtonRightBackgroundImageForBarMetricsLandscapePhone;
}


/*
 - (void) setNavButtonRightDefaultButtonShape: (BOOL)state
 {
 _themeNavButtonShape = state;
 }
 */
- (BOOL) getNavButtonRightDefaultButtonShape
{
    return _themeNavButtonShape;
}


/*
 - (void) setNavButtonRightTintColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeNavButtonTintColor != nil)
 {
 //[_themeNavButtonTintColor release];
 //_themeNavButtonTintColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- (UIColor *) getNavButtonRightTintColor
{
    return _themeNavButtonTintColor;
}


/*
 - (void) setNavButtonRightImage: (NSString*)name
 {
 if ( _themeNavButtonImageRight != nil)
 {
 //[_themeNavButtonImageRight release];
 //_themeNavButtonImageRight = [[NSString alloc] initWithString:name ];
 
 //[_themeDataNavButtonRightImage release];
 //_themeDataNavButtonRightImage = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeNavButtonImageRight]];
 
 }
 }
 */
- ( NSData *) getNavButtonRightImage
{
    return _themeDataNavButtonRightImage;
}



/*
 - (void) setNavButtonDownImage: (NSString*)name
 {
 if ( _themeNavButtonImageDown != nil)
 {
 //[_themeNavButtonImageDown release];
 //_themeNavButtonImageDown = [[NSString alloc] initWithString:name ];
 
 //[_themeDataNavButtonDownImage release];
 //_themeDataNavButtonDownImage = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeNavButtonImageDown]];
 
 }
 }
 */
- ( NSData *) getNavButtonDownImage
{
    return _themeDataNavButtonDownImage;
}


#pragma mark -
#pragma mark View background colorset


- (void) setViewBackgroundColor: (UIView*) uiView {
    
    NSString *resourceDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *imageName  = [resourceDirectory stringByAppendingPathComponent:@"background33.png"];
    [uiView setBackgroundColor:[UIColor colorWithPatternImage:  [UIImage imageWithContentsOfFile: imageName]   ]];
    
}




#pragma mark -
#pragma mark Main Menu Images


/*
 - (void) setMainMenuCustomerSupportImageName: (NSString*)name
 {
 if ( _themeMainMenuCustomerSupport != nil)
 {
 //[_themeMainMenuCustomerSupport release];
 //_themeMainMenuCustomerSupport = [[NSString alloc] initWithString:name ];
 
 //[_themeDataMainMenuCustomerSupportImageName release];
 //_themeDataMainMenuCustomerSupportImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuCustomerSupport]];
 
 }
 }
 */
- ( NSData *) getMainMenuCustomerSupportImageName
{
    return _themeDataMainMenuCustomerSupportImageName;
}


/*
 - (void) setMainMenuEditMapsImageName: (NSString*)name
 {
 if ( _themeMainMenuEditMaps != nil)
 {
 //[_themeMainMenuEditMaps release];
 //_themeMainMenuEditMaps = [[NSString alloc] initWithString:name ];
 
 //[_themeDataMainMenuEditMapsImageName release];
 //_themeDataMainMenuEditMapsImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuEditMaps]];
 
 }
 }
 */
- ( NSData *) getMainMenuEditMapsImageName
{
    return _themeDataMainMenuEditMapsImageName;
}



/*
 - (void) setMainMenuFP3InfoImageName: (NSString*)name
 {
 if ( _themeMainMenuFp3Info != nil)
 {
 //[_themeMainMenuFp3Info release];
 //_themeMainMenuFp3Info = [[NSString alloc] initWithString:name ];
 
 //[_themeDataMainMenuFP3InfoImageName release];
 //_themeDataMainMenuFP3InfoImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuFp3Info]];
 
 }
 }
 */
- ( NSData *) getMainMenuFP3InfoImageName
{
    return _themeDataMainMenuFP3InfoImageName;
}



/*
 - (void) setMainMenuSearchMapImageName: (NSString*)name
 {
 if ( _themeMainMenuSearchMap != nil)
 {
 //[_themeMainMenuSearchMap release];
 //_themeMainMenuSearchMap = [[NSString alloc] initWithString:name ];
 
 //[_themeDataMainMenuSearchMapImageName release];
 //_themeDataMainMenuSearchMapImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuSearchMap]];
 
 }
 }
 */
- ( NSData *) getMainMenuSearchMapImageName
{
    return _themeDataMainMenuSearchMapImageName;
}


/*
 - (void) setMainMenuDtcCodesImageName: (NSString*)name
 {
 if ( _themeMainMenuDtcCodes != nil)
 {
 //[_themeMainMenuDtcCodes release];
 //_themeMainMenuDtcCodes = [[NSString alloc] initWithString:name ];
 
 //[_themeDataMainMenuDtcCodesImageName release];
 //_themeDataMainMenuDtcCodesImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuDtcCodes]];
 
 }
 }
 */
- ( NSData *) getMainMenuDtcCodesImageName
{
    return _themeDataMainMenuDtcCodesImageName;
}

/*
 - (void) setMainMenuResetStockImageName: (NSString*)name
 {
 if ( _themeMainMenuResetStock != nil)
 {
 //[_themeMainMenuResetStock release];
 //_themeMainMenuResetStock = [[NSString alloc] initWithString:name ];
 
 //[_themeDataMainMenuResetStockImageName release];
 //_themeDataMainMenuResetStockImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuResetStock]];
 
 }
 }
 */
- ( NSData *) getMainMenuResetStockImageName
{
    return _themeDataMainMenuResetStockImageName;
}





- ( NSData *) getMainMenuAutotuneName
{
    return _themeDataMainMenuAutotuneName;
}


/*
 - (void) setMainMenuLiveDataImageName: (NSString*)name
 {
 if ( _themeMainMenuLivedata != nil)
 {
 //[_themeMainMenuLivedata release];
 //_themeMainMenuLivedata = [[NSString alloc] initWithString:name ];
 
 //[_themeDataMainMenuLiveDataImageName release];
 //_themeDataMainMenuLiveDataImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuLivedata]];
 
 }
 }
 */
- ( NSData *) getMainMenuLiveDataImageName
{
    return _themeDataMainMenuLiveDataImageName;
}



/*
 - (void) setMainMenuNavBarBtnLeft:(NSString*)name
 {
 if ( _themeMainMenuNavbarbtnLeft != nil)
 {
 //[_themeMainMenuNavbarbtnLeft release];
 //_themeMainMenuNavbarbtnLeft = [[NSString alloc] initWithString:name ];
 
 //[_themeDataMainMenuNavBarBtnLeft release];
 //_themeDataMainMenuNavBarBtnLeft = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuNavbarbtnLeft]];
 
 }
 }
 */
- ( NSData *) getMainMenuNavBarBtnLeft
{
    return _themeDataMainMenuNavBarBtnLeft;
}


/*
 - (void) setMainMenuNavBarBtnRight:(NSString*)name
 {
 if ( _themeMainMenuNavbarbtnRight != nil)
 {
 //[_themeMainMenuNavbarbtnRight release];
 //_themeMainMenuNavbarbtnRight = [[NSString alloc] initWithString:name ];
 
 //[_themeDataMainMenuNavBarBtnRight release];
 //_themeDataMainMenuNavBarBtnRight = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeMainMenuNavbarbtnRight]];
 
 }
 }
 */
- ( NSData *) getMainMenuNavBarBtnRight
{
    return _themeDataMainMenuNavBarBtnRight;
}


#pragma mark -
#pragma mark Demo Menu Images


/*
 - (void) setDemoMenuLinked: (NSString*)name
 {
 if ( _themeDemoMenuLinkOn != nil)
 {
 //[_themeDemoMenuLinkOn release];
 //_themeDemoMenuLinkOn = [[NSString alloc] initWithString:name ];
 
 //[_themeDataDemoMenuLinked release];
 //_themeDataDemoMenuLinked = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuLinkOn]];
 
 }
 }
 */
- ( NSData *) getDemoMenuLinked
{
    return _themeDataDemoMenuLinked;
}


/*
 - (void) setDemoMenuUnLinked: (NSString*)name
 {
 if ( _themeDemoMenuLinkOff != nil)
 {
 //[_themeDemoMenuLinkOff release];
 //_themeDemoMenuLinkOff = [[NSString alloc] initWithString:name ];
 
 //[_themeDataDemoMenuUnLinked release];
 //_themeDataDemoMenuUnLinked = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuLinkOff]];
 
 }
 }
 */
- ( NSData *) getDemoMenuUnLinked
{
    return _themeDataDemoMenuUnLinked;
}


/*
 - (void) setDemoMenuWifiOn: (NSString*)name
 {
 if ( _themeDemoMenuWifiOn != nil)
 {
 //[_themeDemoMenuWifiOn release];
 //_themeDemoMenuWifiOn = [[NSString alloc] initWithString:name ];
 
 //[_themeDataDemoMenuWifiOn release];
 //_themeDataDemoMenuWifiOn = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuWifiOn]];
 
 }
 }
 */
- ( NSData *) getDemoMenuWifiOn
{
    return _themeDataDemoMenuWifiOn;
}



/*
 - (void) setDemoMenuWifiOff: (NSString*)name
 {
 if ( _themeDemoMenuWifiOff != nil)
 {
 //[_themeDemoMenuWifiOff release];
 //_themeDemoMenuWifiOff = [[NSString alloc] initWithString:name ];
 
 //[_themeDataDemoMenuWifiOff release];
 //_themeDataDemoMenuWifiOff = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuWifiOff]];
 
 }
 }
 */
- ( NSData *) getDemoMenuWifiOff
{
    return _themeDataDemoMenuWifiOff;
}



/*
 - (void) setDemoMenuCart: (NSString*)name
 {
 if ( _themeDemoMenuCart != nil)
 {
 //[_themeDemoMenuCart release];
 //_themeDemoMenuCart = [[NSString alloc] initWithString:name ];
 
 //[_themeDataDemoMenuCart release];
 //_themeDataDemoMenuCart = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuCart]];
 
 }
 }
 */
- ( NSData *) getDemoMenuCart
{
    return _themeDataDemoMenuCart;
}



/*
 - (void) setDemoMenuPairBt: (NSString*)name
 {
 if ( _themeDemoMenuPairBt != nil)
 {
 //[_themeDemoMenuPairBt release];
 //_themeDemoMenuPairBt = [[NSString alloc] initWithString:name ];
 
 //[_themeDataDemoMenuPairBt release];
 //_themeDataDemoMenuPairBt = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuPairBt]];
 
 }
 }
 */
- ( NSData *) getDemoMenuPairBt
{
    return _themeDataDemoMenuPairBt;
}

/*
 - (void) setDemoMenuPairBtVin: (NSString*)name
 {
 if ( _themeDemoMenuPairBtVin != nil)
 {
 //[_themeDemoMenuPairBtVin release];
 //_themeDemoMenuPairBtVin = [[NSString alloc] initWithString:name ];
 
 //[_themeDataDemoMenuPairBtVin release];
 //_themeDataDemoMenuPairBtVin = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuPairBtVin]];
 
 }
 }
 */
- ( NSData *) getDemoMenuPairBtVin
{
    return _themeDataDemoMenuPairBtVin;
}


/*
 - (void) setDemoMenuDemo: (NSString*)name
 {
 if ( _themeDemoMenuDemo != nil)
 {
 //[_themeDemoMenuDemo release];
 //_themeDemoMenuDemo = [[NSString alloc] initWithString:name ];
 
 //[_themeDataDemoMenuDemo release];
 //_themeDataDemoMenuDemo = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeDemoMenuDemo]];
 
 }
 }
 */
- ( NSData *) getDemoMenuDemo
{
    return _themeDataDemoMenuDemo;
}



#pragma mark -
#pragma mark LiveData Images

/*
 - (void) setLiveCenter: (NSString*)name
 {
 if ( _themeLiveCenter != nil)
 {
 //[_themeLiveCenter release];
 //_themeLiveCenter = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveCenter release];
 //_themeDataLiveCenter = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveCenter]];
 }
 }
 */
- ( NSData *) getLiveCenter
{
    return _themeDataLiveCenter;
}



/*
 - (void) setLiveNeedle: (NSString*)name
 {
 if ( _themeLiveNeedle != nil)
 {
 //[_themeLiveNeedle release];
 //_themeLiveNeedle = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveNeedle release];
 //_themeDataLiveNeedle = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveNeedle]];
 
 }
 }
 */
- ( NSData *) getLiveNeedle
{
    return _themeDataLiveNeedle;
}


/*
 - (void) setLiveNeedleGear: (NSString*)name
 {
 if ( _themeLiveNeedleGear != nil)
 {
 //[_themeLiveNeedleGear release];
 //_themeLiveNeedleGear = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveNeedleGear release];
 //_themeDataLiveNeedleGear = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveNeedleGear]];
 
 }
 }
 */
- ( NSData *) getLiveNeedleGear
{
    return _themeDataLiveNeedleGear;
}




/*
 - (void) setLiveMiniDial1: (NSString*)name
 {
 if ( _themeLiveMiniDial1 != nil)
 {
 //[_themeLiveMiniDial1 release];
 //_themeLiveMiniDial1 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMiniDial1 release];
 //_themeDataLiveMiniDial1 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial1]];
 
 }
 }
 */
- ( NSData *) getLiveMiniDial1
{
    return _themeDataLiveMiniDial1;
}


/*
 - (void) setLiveMiniDial2: (NSString*)name
 {
 if ( _themeLiveMiniDial2 != nil)
 {
 //[_themeLiveMiniDial2 release];
 //_themeLiveMiniDial2 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMiniDial2 release];
 //_themeDataLiveMiniDial2 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial2]];
 
 }
 }
 */
- ( NSData *) getLiveMiniDial2
{
    return _themeDataLiveMiniDial2;
}


/*
 - (void) setLiveMiniDial3: (NSString*)name
 {
 if ( _themeLiveMiniDial3 != nil)
 {
 //[_themeLiveMiniDial3 release];
 //_themeLiveMiniDial3 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMiniDial3 release];
 //_themeDataLiveMiniDial3 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial3]];
 
 }
 }
 */
- ( NSData *) getLiveMiniDial3
{
    return _themeDataLiveMiniDial3;
}


/*
 - (void) setLiveMiniDial4: (NSString*)name
 {
 if ( _themeLiveMiniDial4 != nil)
 {
 //[_themeLiveMiniDial4 release];
 //_themeLiveMiniDial4 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMiniDial4 release];
 //_themeDataLiveMiniDial4 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial4]];
 
 }
 }
 */
- ( NSData *) getLiveMiniDial4
{
    return _themeDataLiveMiniDial4;
}


/*
 - (void) setLiveMiniDial1feed: (NSString*)name
 {
 if ( _themeLiveMiniDial1feed != nil)
 {
 //[_themeLiveMiniDial1feed release];
 //_themeLiveMiniDial1feed = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMiniDial1feed release];
 //_themeDataLiveMiniDial1feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial1feed]];
 
 }
 }
 */
- ( NSData *) getLiveMiniDial1feed
{
    return _themeDataLiveMiniDial1feed;
}


/*
 - (void) setLiveMiniDial2feed: (NSString*)name
 {
 if ( _themeLiveMiniDial2feed != nil)
 {
 //[_themeLiveMiniDial2feed release];
 //_themeLiveMiniDial2feed = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMiniDial2feed release];
 //_themeDataLiveMiniDial2feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial2feed]];
 
 }
 }
 */
- ( NSData *) getLiveMiniDial2feed
{
    return _themeDataLiveMiniDial2feed;
}


/*
 - (void) setLiveMiniDial3feed: (NSString*)name
 {
 if ( _themeLiveMiniDial3feed != nil)
 {
 //[_themeLiveMiniDial3feed release];
 //_themeLiveMiniDial3feed = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMiniDial3feed release];
 //_themeDataLiveMiniDial3feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial3feed]];
 
 }
 }
 */
- ( NSData *) getLiveMiniDial3feed
{
    return _themeDataLiveMiniDial3feed;
}


/*
 - (void) setLiveMiniDial4feed: (NSString*)name
 {
 if ( _themeLiveMiniDial4feed != nil)
 {
 //[_themeLiveMiniDial4feed release];
 //_themeLiveMiniDial4feed = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMiniDial4feed release];
 //_themeDataLiveMiniDial4feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMiniDial4feed]];
 
 }
 }
 */
- ( NSData *) getLiveMiniDial4feed
{
    return _themeDataLiveMiniDial4feed;
}




/*
 - (void) setLiveMainHomeBtn: (NSString*)name
 {
 if ( _themeLiveMainHomeBtn != nil)
 {
 //[_themeLiveMainHomeBtn release];
 //_themeLiveMainHomeBtn = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMainHomeBtn release];
 //_themeDataLiveMainHomeBtn = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainHomeBtn]];
 
 }
 }
 */
- ( NSData *) getLiveMainHomeBtn
{
    return _themeDataLiveMainHomeBtn;
}




/*
 - (void) setLiveMainDial0: (NSString*)name
 {
 if ( _themeLiveMainDial0 != nil)
 {
 //[_themeLiveMainDial0 release];
 //_themeLiveMainDial0 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMainDial0 release];
 //_themeDataLiveMainDial0 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial0]];
 
 }
 }
 */
- ( NSData *) getLiveMainDial0
{
    return _themeDataLiveMainDial0;
}

/*
 - (void) setLiveMainDial1: (NSString*)name
 {
 if ( _themeLiveMainDial1 != nil)
 {
 //[_themeLiveMainDial1 release];
 //_themeLiveMainDial1 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMainDial1 release];
 //_themeDataLiveMainDial1 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial1]];
 
 }
 }
 */
- ( NSData *) getLiveMainDial1
{
    return _themeDataLiveMainDial1;
}

/*
 - (void) setLiveMainDial2: (NSString*)name
 {
 if ( _themeLiveMainDial2 != nil)
 {
 //[_themeLiveMainDial2 release];
 //_themeLiveMainDial2 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMainDial2 release];
 //_themeDataLiveMainDial2 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial2]];
 
 }
 }
 */
- ( NSData *) getLiveMainDial2
{
    return _themeDataLiveMainDial2;
}


/*
 - (void) setLiveMainDial3: (NSString*)name
 {
 if ( _themeLiveMainDial3 != nil)
 {
 //[_themeLiveMainDial3 release];
 //_themeLiveMainDial3 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMainDial3 release];
 //_themeDataLiveMainDial3 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial3]];
 
 }
 }
 */
- ( NSData *) getLiveMainDial3
{
    return _themeDataLiveMainDial3;
}


/*
 - (void) setLiveMainDial4: (NSString*)name
 {
 if ( _themeLiveMainDial4 != nil)
 {
 //[_themeLiveMainDial4 release];
 //_themeLiveMainDial4 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMainDial4 release];
 //_themeDataLiveMainDial4 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial4]];
 
 }
 }
 */
- ( NSData *) getLiveMainDial4
{
    return _themeDataLiveMainDial4;
}


/*
 - (void) setLiveMainDial5: (NSString*)name
 {
 if ( _themeLiveMainDial5 != nil)
 {
 //[_themeLiveMainDial5 release];
 //_themeLiveMainDial5 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMainDial5 release];
 //_themeDataLiveMainDial5 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial5]];
 
 }
 }
 */
- ( NSData *) getLiveMainDial5
{
    return _themeDataLiveMainDial5;
}


/*
 - (void) setLiveMainDial6: (NSString*)name
 {
 if ( _themeLiveMainDial6 != nil)
 {
 //[_themeLiveMainDial6 release];
 //_themeLiveMainDial6 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMainDial6 release];
 //_themeDataLiveMainDial6 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial6]];
 
 }
 }
 */
- ( NSData *) getLiveMainDial6
{
    return _themeDataLiveMainDial6;
}


/*
 - (void) setLiveMainDial7: (NSString*)name
 {
 if ( _themeLiveMainDial7 != nil)
 {
 //[_themeLiveMainDial7 release];
 //_themeLiveMainDial7 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMainDial7 release];
 //_themeDataLiveMainDial7 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial7]];
 
 }
 }
 */
- ( NSData *) getLiveMainDial7
{
    return _themeDataLiveMainDial7;
}


/*
 - (void) setLiveMainDial8: (NSString*)name
 {
 if ( _themeLiveMainDial8 != nil)
 {
 //[_themeLiveMainDial8 release];
 //_themeLiveMainDial8 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMainDial8 release];
 //_themeDataLiveMainDial8 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial8]];
 
 }
 }
 */
- ( NSData *) getLiveMainDial8
{
    return _themeDataLiveMainDial8;
}


/*
 - (void) setLiveMainDial9: (NSString*)name
 {
 if ( _themeLiveMainDial9 != nil)
 {
 //[_themeLiveMainDial9 release];
 //_themeLiveMainDial9 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveMainDial9 release];
 //_themeDataLiveMainDial9 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveMainDial9]];
 
 }
 }
 */
- ( NSData *) getLiveMainDial9
{
    return _themeDataLiveMainDial9;
}





/*
 - (void) setLivePortrait: (NSString*)name
 {
 if ( _themeLivePortrait != nil)
 {
 //[_themeLivePortrait release];
 //_themeLivePortrait = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLivePortrait release];
 //_themeDataLivePortrait = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLivePortrait]];
 
 }
 }
 */
- ( NSData *) getLivePortrait
{
    return _themeDataLivePortrait;
}


/*
 - (void) setLivePortraitUpsideDown: (NSString*)name
 {
 if ( _themeLivePortraitUpsideDown != nil)
 {
 //[_themeLivePortraitUpsideDown release];
 //_themeLivePortraitUpsideDown = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLivePortraitUpsideDown release];
 //_themeDataLivePortraitUpsideDown = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLivePortraitUpsideDown]];
 
 }
 }
 */
- ( NSData *) getLivePortraitUpsideDown
{
    return _themeDataLivePortraitUpsideDown;
}


/*
 - (void) setLiveLandscapeLeft: (NSString*)name
 {
 if ( _themeLiveLandscapeLeft != nil)
 {
 //[_themeLiveLandscapeLeft release];
 //_themeLiveLandscapeLeft = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveLandscapeLeft release];
 //_themeDataLiveLandscapeLeft = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveLandscapeLeft]];
 
 }
 }
 */
- ( NSData *) getLiveLandscapeLeft
{
    return _themeDataLiveLandscapeLeft;
}


/*
 - (void) setLiveLandscapeRight: (NSString*)name
 {
 if ( _themeLiveLandscapeRight != nil)
 {
 //[_themeLiveLandscapeRight release];
 //_themeLiveLandscapeRight = [[NSString alloc] initWithString:name ];
 
 //[_themeDataLiveLandscapeRight release];
 //_themeDataLiveLandscapeRight = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeLiveLandscapeRight]];
 
 }
 }
 */
- ( NSData *) getLiveLandscapeRight
{
    return _themeDataLiveLandscapeRight;
}







/*
 - (void) setEditMenuNavBarBtnRight:(NSString*)name
 {
 if ( _themeEditMainNavbarbtnRight  != nil)
 {
 //[_themeEditMainNavbarbtnRight release];
 //_themeEditMainNavbarbtnRight = [[NSString alloc] initWithString:name ];
 
 //[_themeDataEditMenuNavBarBtnRight release];
 //_themeDataEditMenuNavBarBtnRight = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeEditMainNavbarbtnRight]];
 
 }
 }
 */
- ( NSData *) getEditMenuNavBarBtnRight
{
    return _themeDataEditMenuNavBarBtnRight;
}



/*
 - (void) setEditSlotNavBarBtnRight:(NSString*)name
 {
 if ( _themeEditSlotNavbarbtnRight  != nil)
 {
 //[_themeEditSlotNavbarbtnRight release];
 //_themeEditSlotNavbarbtnRight = [[NSString alloc] initWithString:name ];
 
 //[_themeDataEditSlotNavBarBtnRight release];
 //_themeDataEditSlotNavBarBtnRight = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeEditSlotNavbarbtnRight]];
 
 }
 }
 */
- ( NSData *) getEditSlotMenuNavBarBtnRight
{
    return _themeDataEditSlotNavBarBtnRight;
}




#pragma mark -
#pragma mark Wheel Images

/*
 - (void) setWheelDial: (NSString*)name
 {
 if ( _themeWheelDial != nil)
 {
 //[_themeWheelDial release];
 //_themeWheelDial = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelDial release];
 //_themeDataWheelDial = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelDial]];
 }
 }
 */
- ( NSData *) getWheelDial
{
    return _themeDataWheelDial;
}

/*
 - (void) setWheelCenter: (NSString*)name
 {
 if ( _themeWheelCenter != nil)
 {
 //[_themeWheelCenter release];
 //_themeWheelCenter = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelCenter release];
 //_themeDataWheelCenter = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelCenter]];
 }
 }
 */
- ( NSData *) getWheelCenter
{
    return _themeDataWheelCenter;
}


/*
 - (void) setWheelCenterFeed: (NSString*)name
 {
 if ( _themeWheelCenterFeed != nil)
 {
 //[_themeWheelCenterFeed release];
 //_themeWheelCenterFeed = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelCenterFeed release];
 //_themeDataWheelCenterFeed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelCenterFeed]];
 }
 }
 */
- ( NSData *) getWheelCenterFeed
{
    return _themeDataWheelCenterFeed;
}




/*
 - (void) setWheelCenterSel: (NSString*)name
 {
 if ( _themeWheelCenterSel != nil)
 {
 //[_themeWheelCenterSel release];
 //_themeWheelCenterSel = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelCenterSel release];
 //_themeDataWheelCenterSel = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelCenterSel]];
 }
 }
 */
- ( NSData *) getWheelCenterSel
{
    return _themeDataWheelCenterSel;
}


/*
 - (void) setWheelSegment: (NSString*)name
 {
 if ( _themeWheelSegment != nil)
 {
 //[_themeWheelSegment release];
 //_themeWheelSegment = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelSegment release];
 //_themeDataWheelSegment = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelSegment]];
 }
 }
 */
- ( NSData *) getWheelSegment
{
    return _themeDataWheelSegment;
}


/*
 - (void) setWheelIcon0: (NSString*)name
 {
 if ( _themeWheelIcon0 != nil)
 {
 //[_themeWheelIcon0 release];
 //_themeWheelIcon0 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon0 release];
 //_themeDataWheelIcon0 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon0]];
 }
 }
 */
- ( NSData *) getWheelIcon0
{
    return _themeDataWheelIcon0;
}

/*
 - (void) setWheelIcon1: (NSString*)name
 {
 if ( _themeWheelIcon1 != nil)
 {
 //[_themeWheelIcon1 release];
 //_themeWheelIcon1 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon1 release];
 //_themeDataWheelIcon1 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon1]];
 }
 }
 */
- ( NSData *) getWheelIcon1
{
    return _themeDataWheelIcon1;
}

/*
 - (void) setWheelIcon2: (NSString*)name
 {
 if ( _themeWheelIcon2 != nil)
 {
 //[_themeWheelIcon2 release];
 //_themeWheelIcon2 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon2 release];
 //_themeDataWheelIcon2 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon2]];
 }
 }
 */
- ( NSData *) getWheelIcon2
{
    return _themeDataWheelIcon2;
}

/*
 - (void) setWheelIcon3: (NSString*)name
 {
 if ( _themeWheelIcon3 != nil)
 {
 //[_themeWheelIcon3 release];
 //_themeWheelIcon3 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon3 release];
 //_themeDataWheelIcon3 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon3]];
 }
 }
 */
- ( NSData *) getWheelIcon3
{
    return _themeDataWheelIcon3;
}

/*
 - (void) setWheelIcon4: (NSString*)name
 {
 if ( _themeWheelIcon4 != nil)
 {
 //[_themeWheelIcon4 release];
 //_themeWheelIcon4 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon4 release];
 //_themeDataWheelIcon4 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon4]];
 }
 }
 */
- ( NSData *) getWheelIcon4
{
    return _themeDataWheelIcon4;
}

/*
 - (void) setWheelIcon5: (NSString*)name
 {
 if ( _themeWheelIcon5 != nil)
 {
 //[_themeWheelIcon5 release];
 //_themeWheelIcon5 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon5 release];
 //_themeDataWheelIcon5 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon5]];
 }
 }
 */
- ( NSData *) getWheelIcon5
{
    return _themeDataWheelIcon5;
}

/*
 - (void) setWheelIcon6: (NSString*)name
 {
 if ( _themeWheelIcon6 != nil)
 {
 //[_themeWheelIcon6 release];
 //_themeWheelIcon6 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon6 release];
 //_themeDataWheelIcon6 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon6]];
 }
 }
 */
- ( NSData *) getWheelIcon6
{
    return _themeDataWheelIcon6;
}
/*
 - (void) setWheelIcon7: (NSString*)name
 {
 if ( _themeWheelIcon7 != nil)
 {
 //[_themeWheelIcon7 release];
 //_themeWheelIcon7 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon7 release];
 // _themeDataWheelIcon7 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon7]];
 }
 }
 */
- ( NSData *) getWheelIcon7
{
    return _themeDataWheelIcon7;
}

/*
 - (void) setWheelIcon8: (NSString*)name
 {
 if ( _themeWheelIcon8 != nil)
 {
 //[_themeWheelIcon8 release];
 //_themeWheelIcon8 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon8 release];
 //_themeDataWheelIcon8 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon8]];
 }
 }
 */
- ( NSData *) getWheelIcon8
{
    return _themeDataWheelIcon8;
}

/*
 - (void) setWheelIcon9: (NSString*)name
 {
 if ( _themeWheelIcon9 != nil)
 {
 //[_themeWheelIcon9 release];
 //_themeWheelIcon9 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon9 release];
 //_themeDataWheelIcon9 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon9]];
 }
 }
 */
- ( NSData *) getWheelIcon9
{
    return _themeDataWheelIcon9;
}

/*
 - (void) setWheelIcon10: (NSString*)name
 {
 if ( _themeWheelIcon10 != nil)
 {
 //[_themeWheelIcon10 release];
 //_themeWheelIcon10 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon10 release];
 //_themeDataWheelIcon10 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon10]];
 }
 }
 */
- ( NSData *) getWheelIcon10
{
    return _themeDataWheelIcon10;
}

/*
 - (void) setWheelIcon11: (NSString*)name
 {
 if ( _themeWheelIcon11 != nil)
 {
 //[_themeWheelIcon11 release];
 //_themeWheelIcon11 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon11 release];
 //_themeDataWheelIcon11 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon11]];
 }
 }
 */
- ( NSData *) getWheelIcon11
{
    return _themeDataWheelIcon11;
}

/*
 - (void) setWheelIcon12: (NSString*)name
 {
 if ( _themeWheelIcon12 != nil)
 {
 //[_themeWheelIcon12 release];
 //_themeWheelIcon12 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon12 release];
 //_themeDataWheelIcon12 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon12]];
 }
 }
 */
- ( NSData *) getWheelIcon12
{
    return _themeDataWheelIcon12;
}

/*
 - (void) setWheelIcon13: (NSString*)name
 {
 if ( _themeWheelIcon13 != nil)
 {
 //[_themeWheelIcon13 release];
 //_themeWheelIcon13 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon13 release];
 //_themeDataWheelIcon13 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon13]];
 }
 }
 */
- ( NSData *) getWheelIcon13
{
    return _themeDataWheelIcon13;
}

/*
 - (void) setWheelIcon14: (NSString*)name
 {
 if ( _themeWheelIcon14 != nil)
 {
 //[_themeWheelIcon14 release];
 //_themeWheelIcon14 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon14 release];
 //_themeDataWheelIcon14 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon14]];
 }
 }
 */
- ( NSData *) getWheelIcon14
{
    return _themeDataWheelIcon14;
}

/*
 - (void) setWheelIcon15: (NSString*)name
 {
 if ( _themeWheelIcon15 != nil)
 {
 //[_themeWheelIcon15 release];
 //_themeWheelIcon15 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon15 release];
 //_themeDataWheelIcon15 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon15]];
 }
 }
 */
- ( NSData *) getWheelIcon15
{
    return _themeDataWheelIcon15;
}

/*
 - (void) setWheelIcon16: (NSString*)name
 {
 if ( _themeWheelIcon16 != nil)
 {
 //[_themeWheelIcon16 release];
 //_themeWheelIcon16 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon16 release];
 //_themeDataWheelIcon16 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon16]];
 }
 }
 */
- ( NSData *) getWheelIcon16
{
    return _themeDataWheelIcon16;
}

/*
 - (void) setWheelIcon17: (NSString*)name
 {
 if ( _themeWheelIcon17 != nil)
 {
 //[_themeWheelIcon17 release];
 //_themeWheelIcon17 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon17 release];
 //_themeDataWheelIcon17 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon17]];
 }
 }
 */
- ( NSData *) getWheelIcon17
{
    return _themeDataWheelIcon17;
}

/*
 - (void) setWheelIcon18: (NSString*)name
 {
 if ( _themeWheelIcon18 != nil)
 {
 //[_themeWheelIcon18 release];
 //_themeWheelIcon18 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon18 release];
 //_themeDataWheelIcon18 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon18]];
 }
 }
 */
- ( NSData *) getWheelIcon18
{
    return _themeDataWheelIcon18;
}

/*
 - (void) setWheelIcon19: (NSString*)name
 {
 if ( _themeWheelIcon19 != nil)
 {
 //[_themeWheelIcon19 release];
 //_themeWheelIcon19 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon19 release];
 //_themeDataWheelIcon19 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon19]];
 }
 }
 */
- ( NSData *) getWheelIcon19
{
    return _themeDataWheelIcon19;
}


/*
 - (void) setWheelIcon20: (NSString*)name
 {
 if ( _themeWheelIcon20 != nil)
 {
 //[_themeWheelIcon20 release];
 //_themeWheelIcon20 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon20 release];
 //_themeDataWheelIcon20 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon20]];
 }
 }
 */
- ( NSData *) getWheelIcon20
{
    return _themeDataWheelIcon20;
}

/*
 - (void) setWheelIcon21: (NSString*)name
 {
 if ( _themeWheelIcon21 != nil)
 {
 //[_themeWheelIcon21 release];
 //_themeWheelIcon21 = [[NSString alloc] initWithString:name ];
 
 // [_themeDataWheelIcon21 release];
 //_themeDataWheelIcon21 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon21]];
 }
 }
 */
- ( NSData *) getWheelIcon21
{
    return _themeDataWheelIcon21;
}

/*
 - (void) setWheelIcon22: (NSString*)name
 {
 if ( _themeWheelIcon22 != nil)
 {
 //[_themeWheelIcon22 release];
 //_themeWheelIcon22 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon22 release];
 //_themeDataWheelIcon22 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon22]];
 }
 }
 */
- ( NSData *) getWheelIcon22
{
    return _themeDataWheelIcon22;
}
/*
 - (void) setWheelIcon23: (NSString*)name
 {
 if ( _themeWheelIcon23 != nil)
 {
 //[_themeWheelIcon23 release];
 //_themeWheelIcon23 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon23 release];
 //_themeDataWheelIcon23 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon23]];
 }
 }
 */
- ( NSData *) getWheelIcon23
{
    return _themeDataWheelIcon23;
}

/*
 - (void) setWheelIcon24: (NSString*)name
 {
 if ( _themeWheelIcon24 != nil)
 {
 //[_themeWheelIcon24 release];
 //_themeWheelIcon24 = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelIcon24 release];
 //_themeDataWheelIcon24 = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelIcon24]];
 }
 }
 */
- ( NSData *) getWheelIcon24
{
    return _themeDataWheelIcon24;
}


/*
 - (void) setWheelMiniDial1feed: (NSString*)name
 {
 if ( _themeWheelMiniDial1feed != nil)
 {
 //[_themeWheelMiniDial1feed release];
 //_themeWheelMiniDial1feed = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelMiniDial1feed release];
 //_themeDataWheelMiniDial1feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial1feed]];
 
 }
 }
 */
- ( NSData *) getWheelMiniDial1feed
{
    return _themeDataWheelMiniDial1feed;
}

/*
 - (void) setWheelMiniDial2feed: (NSString*)name
 {
 if ( _themeWheelMiniDial2feed != nil)
 {
 //[_themeWheelMiniDial2feed release];
 //_themeWheelMiniDial2feed = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelMiniDial2feed release];
 //_themeDataWheelMiniDial2feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial2feed]];
 
 }
 }
 */
- ( NSData *) getWheelMiniDial2feed
{
    return _themeDataWheelMiniDial2feed;
}


/*
 - (void) setWheelMiniDial3feed: (NSString*)name
 {
 if ( _themeWheelMiniDial3feed != nil)
 {
 //[_themeWheelMiniDial3feed release];
 //_themeWheelMiniDial3feed = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelMiniDial3feed release];
 //_themeDataWheelMiniDial3feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial3feed]];
 
 }
 }
 */
- ( NSData *) getWheelMiniDial3feed
{
    return _themeDataWheelMiniDial3feed;
}


/*
 - (void) setWheelMiniDial4feed: (NSString*)name
 {
 if ( _themeWheelMiniDial4feed != nil)
 {
 //[_themeWheelMiniDial4feed release];
 //_themeWheelMiniDial4feed = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelMiniDial4feed release];
 //_themeDataWheelMiniDial4feed = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial4feed]];
 
 }
 }
 */
- ( NSData *) getWheelMiniDial4feed
{
    return _themeDataWheelMiniDial4feed;
}


/*
 - (void) setWheelMiniDial1feedp: (NSString*)name
 {
 if ( _themeWheelMiniDial1feedp != nil)
 {
 //[_themeWheelMiniDial1feedp release];
 //_themeWheelMiniDial1feedp = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelMiniDial1feedp release];
 //_themeDataWheelMiniDial1feedp = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial1feedp]];
 
 }
 }
 */
- ( NSData *) getWheelMiniDial1feedp
{
    return _themeDataWheelMiniDial1feedp;
}


/*
 - (void) setWheelMiniDial2feedp: (NSString*)name
 {
 if ( _themeWheelMiniDial2feedp != nil)
 {
 //[_themeWheelMiniDial2feedp release];
 //_themeWheelMiniDial2feedp = [[NSString alloc] initWithString:name ];
 
 ///[_themeDataWheelMiniDial2feedp release];
 //_themeDataWheelMiniDial2feedp = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial2feedp]];
 
 }
 }
 */
- ( NSData *) getWheelMiniDial2feedp
{
    return _themeDataWheelMiniDial2feedp;
}


/*
 - (void) setWheelMiniDial3feedp: (NSString*)name
 {
 if ( _themeWheelMiniDial3feedp != nil)
 {
 //[_themeWheelMiniDial3feedp release];
 //_themeWheelMiniDial3feedp = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelMiniDial3feedp release];
 //_themeDataWheelMiniDial3feedp = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial3feedp]];
 
 }
 }
 */
- ( NSData *) getWheelMiniDial3feedp
{
    return _themeDataWheelMiniDial3feedp;
}


/*
 - (void) setWheelMiniDial4feedp: (NSString*)name
 {
 if ( _themeWheelMiniDial4feedp != nil)
 {
 //[_themeWheelMiniDial4feedp release];
 //_themeWheelMiniDial4feedp = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelMiniDial4feedp release];
 //_themeDataWheelMiniDial4feedp = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial4feedp]];
 
 }
 }
 */
- ( NSData *) getWheelMiniDial4feedp
{
    return _themeDataWheelMiniDial4feedp;
}


/*
 - (void) setWheelMiniDial1feedn: (NSString*)name
 {
 if ( _themeWheelMiniDial1feedn != nil)
 {
 //[_themeWheelMiniDial1feedn release];
 //_themeWheelMiniDial1feedn = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelMiniDial1feedn release];
 //_themeDataWheelMiniDial1feedn = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial1feedn]];
 
 }
 }
 */
- ( NSData *) getWheelMiniDial1feedn
{
    return _themeDataWheelMiniDial1feedn;
}


/*
 - (void) setWheelMiniDial2feedn: (NSString*)name
 {
 if ( _themeWheelMiniDial2feedn != nil)
 {
 //[_themeWheelMiniDial2feedn release];
 //_themeWheelMiniDial2feedn = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelMiniDial2feedn release];
 //_themeDataWheelMiniDial2feedn = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial2feedn]];
 
 }
 }
 */
- ( NSData *) getWheelMiniDial2feedn
{
    return _themeDataWheelMiniDial2feedn;
}


/*
 - (void) setWheelMiniDial3feedn: (NSString*)name
 {
 if ( _themeWheelMiniDial3feedn != nil)
 {
 //[_themeWheelMiniDial3feedn release];
 //_themeWheelMiniDial3feedn = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelMiniDial3feedn release];
 //_themeDataWheelMiniDial3feedn = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial3feedn]];
 
 }
 }
 */
- ( NSData *) getWheelMiniDial3feedn
{
    return _themeDataWheelMiniDial3feedn;
}


/*
 - (void) setWheelMiniDial4feedn: (NSString*)name
 {
 if ( _themeWheelMiniDial4feedn != nil)
 {
 //[_themeWheelMiniDial4feedn release];
 //_themeWheelMiniDial4feedn = [[NSString alloc] initWithString:name ];
 
 //[_themeDataWheelMiniDial4feedn release];
 //_themeDataWheelMiniDial4feedn = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeWheelMiniDial4feedn]];
 
 }
 }
 */
- ( NSData *) getWheelMiniDial4feedn
{
    return _themeDataWheelMiniDial4feedn;
}


/*
 - (void)   setWheelDialRectWidth: (float)value
 {
 _themeWheelDialRectWidth = value;
 }
 */
- ( float) getWheelDialRectWidth
{
    return _themeWheelDialRectWidth;
}

/*
 - (void)   setWheelDialRectHeight: (float)value
 {
 _themeWheelDialRectHeight = value;
 }
 */
- ( float) getWheelDialRectHeight
{
    return _themeWheelDialRectHeight;
}

/*
 - (void)   setWheelCenterRectWidth: (float)value
 {
 _themeWheelCenterRectWidth = value;
 }
 */
- ( float) getWheelCenterRectWidth
{
    return _themeWheelCenterRectWidth;
}

/*
 - (void)   setWheelCenterRectHeight: (float)value
 {
 _themeWheelCenterRectHeight = value;
 }
 */
- ( float) getWheelCenterRectHeight
{
    return _themeWheelCenterRectHeight;
}

/*
 - (void)   setWheelCenterFeedRectWidth: (float)value
 {
 _themeWheelCenterFeedRectWidth = value;
 }
 */
- ( float) getWheelCenterFeedRectWidth
{
    return _themeWheelCenterFeedRectWidth;
}

/*
 - (void)   setWheelCenterFeedRectHeight: (float)value
 {
 _themeWheelCenterFeedRectHeight = value;
 }
 */
- ( float) getWheelCenterFeedRectHeight
{
    return _themeWheelCenterFeedRectHeight;
}


/*
 - (void)   setWheelSegmentRectWidth: (float)value
 {
 _themeWheelSegmentRectWidth = value;
 }
 */
- ( float) getWheelSegmentRectWidth
{
    return _themeWheelSegmentRectWidth;
}

/*
 - (void)   setWheelSegmentRectHeight: (float)value
 {
 _themeWheelSegmentRectHeight = value;
 }
 */
- ( float) getWheelSegmentRectHeight
{
    return _themeWheelSegmentRectHeight;
}

/*
 - (void)   setWheelIconSegment: (float)value
 {
 _themeWheelIconSegments = value;
 }
 */
- ( float) getWheelIconSegment
{
    return _themeWheelIconSegments;
}

/*
 - (void)   setWheelIconOffsetX: (float)value
 {
 _themeWheelIconOffsetX = value;
 }
 */
- ( float) getWheelIconOffsetX
{
    return _themeWheelIconOffsetX;
}
/*
 - (void)   setWheelIconOffsetY: (float)value
 {
 _themeWheelIconOffsetY = value;
 }
 */
- ( float) getWheelIconOffsetY
{
    return _themeWheelIconOffsetY;
}
/*
 - (void)   setWheelIconRectWidth: (float)value
 {
 _themeWheelIconRectWidth = value;
 }
 */
- ( float) getWheelIconRectWidth
{
    return _themeWheelIconRectWidth;
}
/*
 - (void)   setWheelIconRectHeight: (float)value
 {
 _themeWheelIconRectHeight = value;
 }
 */
- ( float) getWheelIconRectHeight
{
    return _themeWheelIconRectHeight;
}




#pragma mark -
#pragma mark LIVE Text

/*
 - (void) setLiveTextMainFontName: (NSString*)name
 {
 if ( _themeLiveTextMainFontName != nil)
 {
 //[_themeLiveTextMainFontName release];
 //_themeLiveTextMainFontName = [[NSString alloc] initWithString:name ];
 }
 }
 */
- (NSString *) getLiveTextMainFontName
{
    return _themeLiveTextMainFontName;
}

/*
 - (void) setLiveTextMainColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeLiveTextMainColor != nil)
 {
 //[_themeLiveTextMainColor release];
 //_themeLiveTextMainColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getLiveTextMainColor
{
    return _themeLiveTextMainColor;
}


/*
 - (void) setLiveTextMainFontSize: (float)value
 {
 _themeLiveTextMainFontSize  = value;
 }
 */
- ( float )    getLiveTextMainFontSize
{
    return _themeLiveTextMainFontSize;
}


/*
 - (void) setLiveTextDescFontName: (NSString*)name
 {
 if ( _themeLiveTextDescFontName != nil)
 {
 //[_themeLiveTextDescFontName release];
 //_themeLiveTextDescFontName = [[NSString alloc] initWithString:name ];
 }
 }
 */
- (NSString *) getLiveTextDescFontName
{
    return _themeLiveTextDescFontName;
}

/*
 - (void) setLiveTextDescColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeLiveTextDescColor != nil)
 {
 //[_themeLiveTextDescColor release];
 //_themeLiveTextDescColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getLiveTextDescColor
{
    return _themeLiveTextDescColor;
}


/*
 - (void) setLiveTextDescFontSize: (float)value
 {
 _themeLiveTextDescFontSize  = value;
 }
 */
- ( float )    getLiveTextDescFontSize
{
    return _themeLiveTextDescFontSize;
}


/*
 - (void) setLiveTextMiniFontName: (NSString*)name
 {
 if ( _themeLiveTextMiniFontName != nil)
 {
 //[_themeLiveTextMiniFontName release];
 //_themeLiveTextMiniFontName = [[NSString alloc] initWithString:name ];
 }
 }
 */
- (NSString *) getLiveTextMiniFontName
{
    return _themeLiveTextMiniFontName;
}

/*
 - (void) setLiveTextMiniColor: (UIColor*)color
 {
 CGFloat r;
 CGFloat g;
 CGFloat b;
 CGFloat a;
 CGColorRef rgbcolor = [color CGColor];
 
 const CGFloat *components = CGColorGetComponents(rgbcolor);
 
 r = components[0];
 g = components[1];
 b = components[2];
 a = components[3];
 
 if (_themeLiveTextMiniColor != nil)
 {
 //[_themeLiveTextMiniColor release];
 //_themeLiveTextMiniColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a];
 }
 }
 */
- ( UIColor *) getLiveTextMiniColor
{
    return _themeLiveTextMiniColor;
}


/*
 - (void) setLiveTextMiniFontSize: (float)value
 {
 _themeLiveTextMiniFontSize  = value;
 }
 */
- ( float )    getLiveTextMiniFontSize
{
    return _themeLiveTextMiniFontSize;
}


#pragma mark -
#pragma mark Search Map


- (void) setSearchMapExhaustManu: (NSString*)name
{
    if ( _searchMapSearchExhaustManu != nil)
    {
        //[_searchMapSearchExhaustManu release];
        //_searchMapSearchExhaustManu = [[NSString alloc] initWithString:name ];
        _searchMapSearchExhaustManu = name;
    }
    //NSLog(@"set %@",_searchMapSearchExhaustManu);
}
- (NSString *) getSearchMapExhaustManu
{
    //NSLog(@"get %@",_searchMapSearchExhaustManu);
    return _searchMapSearchExhaustManu;
}




- (void) setSearchMapExhaustType: (NSString*)name
{
    if ( _searchMapSearchExhaustType != nil)
    {
        //[_searchMapSearchExhaustType release];
        //_searchMapSearchExhaustType = [[NSString alloc] initWithString:name ];
        
        _searchMapSearchExhaustType = name;
    }
    //NSLog(@"set %@",_searchMapSearchExhaustType);
}
- (NSString *) getSearchMapExhaustType
{
    //NSLog(@"get %@",_searchMapSearchExhaustType);
    return _searchMapSearchExhaustType;
}




- (void) setSearchMapExhaustBaffle: (NSString*)name
{
    if ( _searchMapSearchExhaustBaffle != nil)
    {
        //[_searchMapSearchExhaustBaffle release];
        //_searchMapSearchExhaustBaffle = [[NSString alloc] initWithString:name ];
        _searchMapSearchExhaustBaffle = name;
    }
    //NSLog(@"set %@",_searchMapSearchExhaustBaffle);
}

- (NSString *) getSearchMapExhaustBaflle
{
    //NSLog(@"get %@",_searchMapSearchExhaustBaffle);
    return _searchMapSearchExhaustBaffle;
}




- (void) setSearchMapEngineSize: (NSString*)name
{
    if ( _searchMapSearchEngineSize != nil)
    {
        //[_searchMapSearchEngineSize release];
        //_searchMapSearchEngineSize = [[NSString alloc] initWithString:name ];
        _searchMapSearchEngineSize = name;
    }
    //NSLog(@"set %@",_searchMapSearchEngineSize);
}

- (NSString *) getSearchMapEngineSize
{
    //NSLog(@"get %@",_searchMapSearchEngineSize);
    return _searchMapSearchEngineSize;
}



- (void) setSearchMapCalId: (NSString*)name
{
    if ( _searchCalId != nil)
    {
        //[_searchCalId release];
        //_searchCalId = [[NSString alloc] initWithString:name ];
        _searchCalId = name;
    }
    //NSLog(@"set %@",_searchMapSearchEngineSize);
}

- (NSString *) getSearchMapCalId
{
    //NSLog(@"get %@",_searchMapSearchEngineSize);
    return _searchCalId;
}







/*
 - (void) setSearchMapUrl: (NSString*)name
 {
 if ( _searchMapUrl != nil)
 {
 //[_searchMapUrl release];
 //_searchMapUrl = [[NSString alloc] initWithString:name ];
 }
 NSLog(@"set %@",_searchMapUrl);
 }
 */
//- (NSString *) getSearchMapUrl
//{
//    //NSLog(@"get %@",_searchMapUrl);
////    return _searchMapUrl;
//}

/*
 - (void) setSearchMediaUrl: (NSString*)name
 {
 if ( _searchMediaUrl != nil)
 {
 //[_searchMediaUrl release];
 //_searchMediaUrl = [[NSString alloc] initWithString:name ];
 }
 NSLog(@"set %@",_searchMediaUrl);
 }
 */
- (NSString *) getSearchMediaUrl
{
    //NSLog(@"get %@",_searchMediaUrl);
    return _searchMediaUrl;
}

/*
 - (void) setOtaUrl: (NSString*)name
 {
 if ( _OtaUrl != nil)
 {
 //[_OtaUrl release];
 //_OtaUrl = [[NSString alloc] initWithString:name ];
 }
 NSLog(@"set %@",_OtaUrl);
 }
 */
- (NSString *) getOtaUrl
{
    //NSLog(@"get %@",_OtaUrl);
    return _OtaUrl;
}



- ( NSData *) getProgWheelIcon1
{
    return _themeDataProgWheelIcon1;
}
- ( NSData *) getProgWheelIcon2
{
    return _themeDataProgWheelIcon2;
}
- ( NSData *) getProgWheelIcon3
{
    return _themeDataProgWheelIcon3;
}


- (BOOL*) isDevServer
{
#ifdef DEV_SERVER
    return YES;
#endif
    
#ifdef DEV2_SERVER
    return YES;
#endif
    
#ifdef STAGING_SERVER
    return YES;
#endif
    
    return NO;  //is Production server
    
}

- (NSString*) getServer
{
    
    NSString *server;
    
    server = [NSString stringWithFormat:@"%@%@", [self getServerPrefix], @"vhfp3.com/development/Services/api.php"];
    
    return server;
    
    
}

- (NSString*) getServerPrefix
{
    
#ifdef DEV_SERVER
    return @"https://dev.";  //Development Server
#endif
    
#ifdef DEV2_SERVER
    return @"http://dev2.";   //Development Server2
#endif
    
#ifdef STAGING_SERVER
    return @"http://staging.";   //Staging
#endif
    
    return @"https://";       //Production Server
    
}

//Use in serch map
- (NSString*) getServerHttp
{
    
#ifdef DEV_SERVER
    return @"https://";  //Development Server
#endif
    
#ifdef DEV2_SERVER
    return @"http://";   //Development Server2
#endif
    
#ifdef STAGING_SERVER
    return @"http://";   //Staging
#endif
    
    return @"https://";       //Production Server
    
}




#pragma mark -
#pragma mark Helper Methods
//- (void) updateTheme
//{
//
//    //init variables
//    NSString *resourceDirectory = [[NSBundle mainBundle] resourcePath];
//    NSString *imageName  = [resourceDirectory stringByAppendingPathComponent:@"background33.png"];
//    //    UIColor  *themeCellTextColor        = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
//    //    UIColor  *themeCellTextBkgColor     = [[UIColor alloc] initWithRed:0.0 green:1.0 blue:1.0 alpha:0.0];
//    //UIColor  *themeCellTextColorSelected= [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
//
//    //set Viewcontroller background
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:  [UIImage imageWithContentsOfFile: imageName]   ]];
//
//
//    //Set button Attributes
//    [[EAController sharedController] setButtonAttributes: self.buttonCancel];
//    [[EAController sharedController] setButtonAttributes: self.buttonSave];
//    [[EAController sharedController] setViewBackgroundColor:self.uiButtonContainer];
//
//
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//    {
//        [self.uiLeftNavBarButton setTintColor: [UIColor whiteColor] ];
//        //[self.barButtomRight setTintColor: [UIColor whiteColor] ];
//    }
//    else
//    {
//        [self.uiLeftNavBarButton setTintColor: [UIColor clearColor] ];
//        //[self.barButtomRight setTintColor: [UIColor clearColor] ];
//    }
//
//
//
//
//    [self.uiNavBar setAlpha:  [[EAController sharedController] getNavBarAlpha]];
//    [self.uiNavBar setHidden: [[EAController sharedController] getNavBarHidden]];
//
//    BOOL navflag = [[EAController sharedController] getNavBarColorOverwritesGradient];
//    if ( navflag==TRUE )
//    {
//        [self.uiNavBar setTintColor: [[EAController sharedController] getNavBarTintColor]];
//
//        [self.uiNavBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//        [self.uiNavBar setBackgroundImage:nil forBarMetrics:UIBarMetricsLandscapePhone];
//
//    }
//    else
//    {
//        UIImage *gradientImage44 = [[UIImage imageWithData:[[EAController sharedController] getNavBarBackgroundImageForBarMetricsDefaultName]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//        UIImage *gradientImage32 = [[UIImage imageWithData:[[EAController sharedController] getNavBarBackgroundImageForBarMetricsLandscapePhone]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//
//        [self.uiNavBar setBackgroundImage:gradientImage44 forBarMetrics:UIBarMetricsDefault];
//        [self.uiNavBar setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsLandscapePhone];
//    }
//
//
//    [self.uiNavBar setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [[EAController sharedController] getNavBarTitleTextColor],          UITextAttributeTextColor,
//      [[EAController sharedController] getNavBarTitleTextColorShadow],    UITextAttributeTextShadowColor,
//      nil]];
//
//
//}

// Mike 06/12/15 - Helper method to set button attributes
// Set Button Type in Storyboard to Custom
- (void) setButtonAttributes: (UIButton*) btn
{
    // Set the button Text Color
    [btn setTitleColor:[[EAController sharedController] getButtonTitleColorForControlStateNormal]   forState:UIControlStateNormal];
    [btn setTitleColor:[[EAController sharedController] getButtonTitleColorForControlStateSelected] forState:UIControlStateHighlighted];
    
    [btn.titleLabel setLineBreakMode: NSLineBreakByTruncatingTail];
    
    // Set default background color
    BOOL btnflagColorOverGradient = [[EAController sharedController] getButtonColorOverwritesGradient];
    
    if ( btnflagColorOverGradient == TRUE)
    {
        [btn setBackgroundColor:[[EAController sharedController] getButtonColor] ];
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageWithData: [[EAController sharedController] getButtonBackgroundImageForControlStateNormal]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithData: [[EAController sharedController] getButtonBackgroundImageForControlStateHighlighted]] forState:UIControlStateHighlighted];
    }
    
    
    // Add Custom Font
    [[btn titleLabel] setFont:[UIFont fontWithName:[[EAController sharedController] getButtonTitleLabelFontName] size:[[EAController sharedController] getButtonTitleLabelFontSize]  ]];
    
    
    [btn makeGlossy];
    
    // Draw a custom gradient
    CAGradientLayer *btnGradient = [CAGradientLayer layer];
    btnGradient.frame = btn.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)[ [[EAController sharedController] getButtonGradientStart] CGColor],
                          (id)[ [[EAController sharedController] getButtonGradientEnd] CGColor],
                          nil];
    [btn.layer insertSublayer:btnGradient atIndex:0];
    
    [[EAController sharedController] addBorder:btn :5.0f :[UIColor blackColor] ];
    
    [[EAController sharedController] addRoundedCorners:btn :1.0f];
    
    //    // Round button corners
    //    CALayer *btnLayer = [btn layer];
    //    [btnLayer setMasksToBounds:YES];
    //    [btnLayer setCornerRadius:5.0f];
    
    //    // Apply a 1 pixel, black border around Button
    //    [btnLayer setBorderWidth:1.0f];
    //    [btnLayer setBorderColor:[[UIColor blackColor] CGColor]];
    
}

- (void) setNavBarAttributes:(UINavigationBar*)uiNavBar
{
    
    [uiNavBar setAlpha:  [[EAController sharedController] getNavBarAlpha]];
    [uiNavBar setHidden: [[EAController sharedController] getNavBarHidden]];
    
    BOOL navflag = [[EAController sharedController] getNavBarColorOverwritesGradient];
    if ( navflag==TRUE )
    {
        [uiNavBar setTintColor: [[EAController sharedController] getNavBarTintColor]];
        
        [uiNavBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [uiNavBar setBackgroundImage:nil forBarMetrics:UIBarMetricsLandscapePhone];
        
    }
    else
    {
        UIImage *gradientImage44 = [[UIImage imageWithData:[[EAController sharedController] getNavBarBackgroundImageForBarMetricsDefaultName]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        UIImage *gradientImage32 = [[UIImage imageWithData:[[EAController sharedController] getNavBarBackgroundImageForBarMetricsLandscapePhone]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        [uiNavBar setBackgroundImage:gradientImage44 forBarMetrics:UIBarMetricsDefault];
        [uiNavBar setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsLandscapePhone];
    }
    
    
    [uiNavBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [[EAController sharedController] getNavBarTitleTextColor],          UITextAttributeTextColor,
      [[EAController sharedController] getNavBarTitleTextColorShadow],    UITextAttributeTextShadowColor,
      nil]];
    
}


- (void) setNavBarButtonAttributes:(UIBarButtonItem*)uiBarButtonItem
{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [uiBarButtonItem setTintColor: [UIColor whiteColor] ];
    }
    else
    {
        [uiBarButtonItem setTintColor: [UIColor clearColor] ];
    }
}


- (void) setDefaultBackgroundColor:(UIView*)view
{
    
    NSString *resourceDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *imageName  = [resourceDirectory stringByAppendingPathComponent:@"background33.png"];
    
    //set Viewcontroller background
    [view setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageWithContentsOfFile: imageName]]];
}

- (void) setBackgroundColor:(UIView*)view :(NSString*)imageFile
{
    
    NSString *resourceDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *imageName  = [resourceDirectory stringByAppendingPathComponent:imageFile];
    
    //set Viewcontroller background
    [view setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageWithContentsOfFile: imageName]]];
}

/*
 - (void) setBackgroundImageName: (NSString*)name
 {
 if ( _themeGeneralBackground != nil)
 {
 //[_themeGeneralBackground release];
 //_themeGeneralBackground = [[NSString alloc] initWithString:name ];
 
 //[_themeDataBackgroundImageName release];
 //_themeDataBackgroundImageName = [[NSData alloc] initWithData: [ self getBkgDataFromFileName:_themeGeneralBackground]];
 
 //NSLog(@"SET backimage %@",_themeGeneralBackground);
 }
 }
 */

- (void) addBorder:(UIView*)view :(float)borderWidth :(UIColor*)borderColor
{
    // Add border to view
    CALayer *btnLayer = [view layer];
    [btnLayer setBorderWidth:borderWidth];
    [btnLayer setBorderColor:[borderColor CGColor]];
    
}

- (void) addRoundedCorners:(UIView*)view :(float)cornerRadius
{
    // Round button corners
    CALayer *btnLayer = [view layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:cornerRadius];
    
}


- (void) addBorderAndRoundedCorners:(UIView*)view :(float)cornerRadius :(float)borderWidth :(UIColor*)borderColor
{
    // Add Round corners
    [[EAController sharedController] addRoundedCorners:view :cornerRadius];
    
    // Add Border
    [[EAController sharedController] addBorder:view :borderWidth :borderColor];
}



- (CAGradientLayer*) getCellBackgroundColor2
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, [[EAController sharedController] getMaxScreenSize], 93/2);
    gradient.colors = [NSArray arrayWithObjects:(id)[[[UIColor alloc] initWithRed:0.120 green:0.118 blue:0.118 alpha:1.0]CGColor],(id)[[UIColor clearColor]CGColor], (id)[[UIColor clearColor]CGColor],(id)[[UIColor clearColor]CGColor], (id)[[UIColor clearColor]CGColor], nil];
    
    return gradient;
}

- (void) setCellBackgroundColor:(CALayer*)layer
{
    [layer addSublayer: [[EAController sharedController] getCellBackgroundColor2] ];
    
}


- (UIView*) getCellSelectedBackgroundColor
{
    NSString *resourceDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *themeCellBkgViewSelected  = @"cellgradient-over.png";
    NSString *res = [resourceDirectory stringByAppendingPathComponent:themeCellBkgViewSelected];
    
    UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:res] ];
    
    return view;
    
}



- (BOOL) isPortrait {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        return true;
    }else {
        return false;
    }
}

- (BOOL) isLandscape {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return true;
    }else {
        return false;
    }
}

- (BOOL) isIpad {
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return true;
    }else {
        return false;
    }
}

- (CGFloat) getScreenWidth
{
    CGFloat screenWidth;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad || [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 || TARGET_IPHONE_SIMULATOR) {
        screenWidth = [[UIScreen mainScreen] bounds].size.width;
        //        NSLog(@"getScreenWidth is iPad or Simulator ---------->Lanscapse  --> = %2f", screenWidth);
    }else {
        
        
        if ([self isLandscape]) {
            screenWidth = [[UIScreen mainScreen] bounds].size.height;
            //            NSLog(@"getScreenWidth ---------->Lanscapse  --> %2f", screenWidth);
        }
        
        
        if ([self isPortrait]) {
            screenWidth = [[UIScreen mainScreen] bounds].size.width;
            //            NSLog(@"getScreenWidth ---------->Portrait  --> %2f", screenWidth);
        }
    }
    
    
    return screenWidth;
    
}

- (CGFloat) getScreenHeight
{
    CGFloat screenHeight=0;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad || [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 || TARGET_IPHONE_SIMULATOR){
        screenHeight = [[UIScreen mainScreen] bounds].size.height;
    }else {
        
        if ([self isLandscape]) {
            screenHeight = [[UIScreen mainScreen] bounds].size.width;
            //            NSLog(@"getScreenHeight ---------->Lanscapse  --> %2f", screenHeight);
        }
        
        if ([self isPortrait]) {
            screenHeight = [[UIScreen mainScreen] bounds].size.height;
            //            NSLog(@"getScreenHeight ---------->Portrait  --> %2f", screenHeight);
        }
    }
    
    
    return screenHeight;
    
}


- (CGFloat) getStatusBarHeight
{
    CGFloat height=20;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        height = [UIApplication sharedApplication].statusBarFrame.size.height;
    }else {
        if ([self isPortrait]) {
            height = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
        
        if ([self isLandscape]) {
            height = [UIApplication sharedApplication].statusBarFrame.size.width;
        }
    }
    
    return height;
}


@end
