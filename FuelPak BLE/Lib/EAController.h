//
//  EAController.h
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/21/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIButton+Glossy.h"


@interface EAController : NSObject
{

}

+(EAController *)sharedController;


//@property (atomic, readonly) EAAccessory *selectedAccessory;
@property (nonatomic, readonly) NSString *protocolString;

@property (retain) NSMutableData *writeDataBuffer;


@property(retain, atomic) NSTimer *timer_live;
@property(retain, nonatomic) NSDictionary *exhaustdict;



@property (strong)    UIImage *themeDataHomeBackgroundImageName;
@property (strong)    UIImage *themeDataHomeBackgroundImageName2;
@property (strong)    UIImage *themeDataBackgroundImageName;


//@property (strong)    NSData *themeDataHomeBackgroundImageName;
//@property (strong)    NSData *themeDataHomeBackgroundImageName2;
//@property (strong)    NSData *themeDataBackgroundImageName;

@property (strong)    NSData *themeDataCellSelectedBackgroundView;
@property (strong)    NSData *themeDataCellBackgroundView;
@property (strong)    NSData *themeDataCellAccessoryViewInitWithImage;
@property (strong)    NSData *themeDataButtonBackgroundImageForControlStateNormal;
@property (strong)    NSData *themeDataButtonBackgroundImageForControlStateHighlighted;

@property (strong)    NSData *themeDataNavBarBackgroundImageForBarMetricsDefaultName;
@property (strong)    NSData *themeDataNavBarBackgroundImageForBarMetricsLandscapePhone;
@property (strong)    NSData *themeDataNavButtonRightBackgroundImageForBarMetricsDefaultName;
@property (strong)    NSData *themeDataNavButtonRightBackgroundImageForBarMetricsLandscapePhone;
@property (strong)    NSData *themeDataNavButtonRightImage;
@property (strong)    NSData *themeDataNavButtonDownImage;

@property (strong)    NSData *themeDataMainMenuCustomerSupportImageName;
@property (strong)    NSData *themeDataMainMenuEditMapsImageName;
@property (strong)    NSData *themeDataMainMenuFP3InfoImageName;
@property (strong)    NSData *themeDataMainMenuSearchMapImageName;
@property (strong)    NSData *themeDataMainMenuDtcCodesImageName;
@property (strong)    NSData *themeDataMainMenuResetStockImageName;
@property (strong)    NSData *themeDataMainMenuLiveDataImageName;
@property (strong)    NSData *themeDataMainMenuAutotuneName;

@property (strong)    NSData *themeDataMainMenuNavBarBtnLeft;
@property (strong)    NSData *themeDataMainMenuNavBarBtnRight;

@property (strong)    NSData *themeDataDemoMenuLinked;
@property (strong)    NSData *themeDataDemoMenuUnLinked;
@property (strong)    NSData *themeDataDemoMenuWifiOn;
@property (strong)    NSData *themeDataDemoMenuWifiOff;
@property (strong)    NSData *themeDataDemoMenuCart;
@property (strong)    NSData *themeDataDemoMenuPairBt;
@property (strong)    NSData *themeDataDemoMenuPairBtVin;
@property (strong)    NSData *themeDataDemoMenuDemo;


@property (strong)    NSData *themeDataLiveCenter;
@property (strong)    NSData *themeDataLiveNeedle;
@property (strong)    NSData *themeDataLiveNeedleGear;
@property (strong)    NSData *themeDataLiveMiniDial1;
@property (strong)    NSData *themeDataLiveMiniDial2;
@property (strong)    NSData *themeDataLiveMiniDial3;
@property (strong)    NSData *themeDataLiveMiniDial4;
@property (strong)    NSData *themeDataLiveMiniDial1feed;
@property (strong)    NSData *themeDataLiveMiniDial2feed;
@property (strong)    NSData *themeDataLiveMiniDial3feed;
@property (strong)    NSData *themeDataLiveMiniDial4feed;

@property (strong)    NSData *themeDataLiveMainHomeBtn;

@property (strong)    NSData *themeDataLiveMainDial0;
@property (strong)    NSData *themeDataLiveMainDial1;
@property (strong)    NSData *themeDataLiveMainDial2;
@property (strong)    NSData *themeDataLiveMainDial3;
@property (strong)    NSData *themeDataLiveMainDial4;
@property (strong)    NSData *themeDataLiveMainDial5;
@property (strong)    NSData *themeDataLiveMainDial6;
@property (strong)    NSData *themeDataLiveMainDial7;
@property (strong)    NSData *themeDataLiveMainDial8;
@property (strong)    NSData *themeDataLiveMainDial9;

@property (strong)    NSData *themeDataLivePortrait;
@property (strong)    NSData *themeDataLivePortraitUpsideDown;
@property (strong)    NSData *themeDataLiveLandscapeLeft;
@property (strong)    NSData *themeDataLiveLandscapeRight;

@property (strong)    NSData *themeDataEditMenuNavBarBtnRight;
@property (strong)    NSData *themeDataEditSlotNavBarBtnRight;


@property (strong)    NSData *themeDataWheelDial;
@property (strong)    NSData *themeDataWheelCenter;
@property (strong)    NSData *themeDataWheelCenterFeed;
@property (strong)    NSData *themeDataWheelCenterSel;
@property (strong)    NSData *themeDataWheelSegment;
@property (strong)    NSData *themeDataWheelIcon0;
@property (strong)    NSData *themeDataWheelIcon1;
@property (strong)    NSData *themeDataWheelIcon2;
@property (strong)    NSData *themeDataWheelIcon3;
@property (strong)    NSData *themeDataWheelIcon4;
@property (strong)    NSData *themeDataWheelIcon5;
@property (strong)    NSData *themeDataWheelIcon6;
@property (strong)    NSData *themeDataWheelIcon7;
@property (strong)    NSData *themeDataWheelIcon8;
@property (strong)    NSData *themeDataWheelIcon9;
@property (strong)    NSData *themeDataWheelIcon10;
@property (strong)    NSData *themeDataWheelIcon11;
@property (strong)    NSData *themeDataWheelIcon12;
@property (strong)    NSData *themeDataWheelIcon13;
@property (strong)    NSData *themeDataWheelIcon14;
@property (strong)    NSData *themeDataWheelIcon15;
@property (strong)    NSData *themeDataWheelIcon16;
@property (strong)    NSData *themeDataWheelIcon17;
@property (strong)    NSData *themeDataWheelIcon18;
@property (strong)    NSData *themeDataWheelIcon19;
@property (strong)    NSData *themeDataWheelIcon20;
@property (strong)    NSData *themeDataWheelIcon21;
@property (strong)    NSData *themeDataWheelIcon22;
@property (strong)    NSData *themeDataWheelIcon23;
@property (strong)    NSData *themeDataWheelIcon24;
@property (strong)    NSData *themeDataWheelMiniDial1feed;
@property (strong)    NSData *themeDataWheelMiniDial2feed;
@property (strong)    NSData *themeDataWheelMiniDial3feed;
@property (strong)    NSData *themeDataWheelMiniDial4feed;
@property (strong)    NSData *themeDataWheelMiniDial1feedp;
@property (strong)    NSData *themeDataWheelMiniDial2feedp;
@property (strong)    NSData *themeDataWheelMiniDial3feedp;
@property (strong)    NSData *themeDataWheelMiniDial4feedp;
@property (strong)    NSData *themeDataWheelMiniDial1feedn;
@property (strong)    NSData *themeDataWheelMiniDial2feedn;
@property (strong)    NSData *themeDataWheelMiniDial3feedn;
@property (strong)    NSData *themeDataWheelMiniDial4feedn;



@property (strong)    NSData *themeDataProgWheelIcon1;
@property (strong)    NSData *themeDataProgWheelIcon2;
@property (strong)    NSData *themeDataProgWheelIcon3;


@property(assign)       int         themeIndex;

@property(assign)       NSString    *themeHomeBackground;
@property(assign)       NSString    *themeHomeBackground2;
@property(assign)       NSString    *themeGeneralBackground;
@property(strong)       UIColor     *themeGeneralActivityColor;
@property(strong)       UIColor     *themeGeneralActiveTextColor;
@property(strong)       UIColor     *themeGeneralDemoTextColor;

@property(assign)       float        themeCellHeight;
@property(strong)       UIColor     *themeCellBkgColor;
@property(assign)       NSString    *themeCellBkgView;
@property(assign)       NSString    *themeCellBkgViewSelected;

@property(assign)       NSString    *themeCellTextFont;
@property(assign)       float        themeCellTextFontSize;
@property(strong)       UIColor     *themeCellTextColor;
@property(strong)       UIColor     *themeCellTextColorSelected;
@property(strong)       UIColor     *themeCellTextBkgColor;
@property(assign)       BOOL        *themeCellTextBkgOpaque;

@property(strong)       UIColor     *themeCellDetailTextColor;
@property(assign)       NSString    *themeCellDetailTextFont;
@property(assign)       float        themeCellDetailTextFontSize;
@property(strong)       UIColor     *themeCellDetailBkgColor;
@property(strong)       UIColor     *themeCellSeparatorColor;
@property(assign)       NSString    *themeCellDisclosure;



@property(strong)       UIColor     *themeButtonColor;
@property(strong)       UIColor     *themeButtonTitleColor;
@property(strong)       UIColor     *themeButtonTitleColorSelected;
@property(assign)       NSString    *themeButtonTextFont;
@property(assign)       float        themeButtonTextFontSize;
@property(assign)       NSString    *themeButtonBkg;
@property(assign)       NSString    *themeButtonBkgSelected;
@property(strong)       UIColor     *themeButtonGradientStart;
@property(strong)       UIColor     *themeButtonGradientEnd;
@property(assign)       BOOL         themeButtonColorOverGradient;


@property(strong)       UIColor     *themeBadgeBkgColor;
@property(strong)       UIColor     *themeBadgeBkgColorSelected;
@property(strong)       UIColor     *themeBadgeTextColor;


@property(assign)       NSString    *themeNavBarBkg;
@property(assign)       NSString    *themeNavBarBkgLandscape;
@property(strong)       UIColor     *themeNavBarTextColor;
@property(strong)       UIColor     *themeNavBarTextShadowColor;
@property(assign)      float        themeNavBarAlpha;
@property(assign)      BOOL         themeNavBarHidden;
@property(assign)      BOOL         themeNavBarColorOverGradient;
@property(strong)       UIColor     *themeNavBarTintColor;


@property(assign)      NSString    *themeNavButtonBkg;
@property(assign)      NSString    *themeNavButtonBkgLandscape;
@property(assign)      BOOL         themeNavButtonShape;
@property(strong)      UIColor     *themeNavButtonTintColor;
@property(assign)      NSString    *themeNavButtonImageRight;
@property(assign)      NSString    *themeNavButtonImageDown;



@property(assign)      NSString    *themeMainMenuCustomerSupport;
@property(assign)      NSString    *themeMainMenuEditMaps;
@property(assign)      NSString    *themeMainMenuFp3Info;
@property(assign)      NSString    *themeMainMenuSearchMap;
@property(assign)      NSString    *themeMainMenuDtcCodes;
@property(assign)      NSString    *themeMainMenuResetStock;
@property(assign)      NSString    *themeMainMenuAutotune;
@property(assign)      NSString    *themeMainMenuLivedata;
@property(assign)      NSString    *themeMainMenuNavbarbtnLeft;
@property(assign)      NSString    *themeMainMenuNavbarbtnRight;

@property(assign)      NSString    *themeEditMainNavbarbtnRight;
@property(assign)      NSString    *themeEditSlotNavbarbtnRight;


@property(assign)      NSString    *themeDemoMenuLinkOn;
@property(assign)      NSString    *themeDemoMenuLinkOff;
@property(assign)      NSString    *themeDemoMenuWifiOn;
@property(assign)      NSString    *themeDemoMenuWifiOff;
@property(assign)      NSString    *themeDemoMenuCart;
@property(assign)      NSString    *themeDemoMenuPairBt;
@property(assign)      NSString    *themeDemoMenuPairBtVin;
@property(assign)      NSString    *themeDemoMenuDemo;


@property(assign)      NSString    *themeLiveCenter;
@property(assign)      NSString    *themeLiveNeedle;
@property(assign)      NSString    *themeLiveNeedleGear;

@property(assign)      NSString    *themeLiveMiniDial1;
@property(assign)      NSString    *themeLiveMiniDial2;
@property(assign)      NSString    *themeLiveMiniDial3;
@property(assign)      NSString    *themeLiveMiniDial4;
@property(assign)      NSString    *themeLiveMiniDial1feed;
@property(assign)      NSString    *themeLiveMiniDial2feed;
@property(assign)      NSString    *themeLiveMiniDial3feed;
@property(assign)      NSString    *themeLiveMiniDial4feed;

@property(assign)      NSString    *themeLiveMainHomeBtn;

@property(assign)      NSString    *themeLiveMainDial0;
@property(assign)      NSString    *themeLiveMainDial1;
@property(assign)      NSString    *themeLiveMainDial2;
@property(assign)      NSString    *themeLiveMainDial3;
@property(assign)      NSString    *themeLiveMainDial4;
@property(assign)      NSString    *themeLiveMainDial5;
@property(assign)      NSString    *themeLiveMainDial6;
@property(assign)      NSString    *themeLiveMainDial7;
@property(assign)      NSString    *themeLiveMainDial8;
@property(assign)      NSString    *themeLiveMainDial9;

@property(assign)      NSString    *themeLivePortrait;
@property(assign)      NSString    *themeLivePortraitUpsideDown;
@property(assign)      NSString    *themeLiveLandscapeLeft;
@property(assign)      NSString    *themeLiveLandscapeRight;


@property(assign)      NSString    *themeWheelDial;
@property(assign)      NSString    *themeWheelCenter;
@property(assign)      NSString    *themeWheelCenterFeed;
@property(assign)      NSString    *themeWheelCenterSel;
@property(assign)      NSString    *themeWheelSegment;
@property(assign)      NSString    *themeWheelIcon0;
@property(assign)      NSString    *themeWheelIcon1;
@property(assign)      NSString    *themeWheelIcon2;
@property(assign)      NSString    *themeWheelIcon3;
@property(assign)      NSString    *themeWheelIcon4;
@property(assign)      NSString    *themeWheelIcon5;
@property(assign)      NSString    *themeWheelIcon6;
@property(assign)      NSString    *themeWheelIcon7;
@property(assign)      NSString    *themeWheelIcon8;
@property(assign)      NSString    *themeWheelIcon9;
@property(assign)      NSString    *themeWheelIcon10;
@property(assign)      NSString    *themeWheelIcon11;
@property(assign)      NSString    *themeWheelIcon12;
@property(assign)      NSString    *themeWheelIcon13;
@property(assign)      NSString    *themeWheelIcon14;
@property(assign)      NSString    *themeWheelIcon15;
@property(assign)      NSString    *themeWheelIcon16;
@property(assign)      NSString    *themeWheelIcon17;
@property(assign)      NSString    *themeWheelIcon18;
@property(assign)      NSString    *themeWheelIcon19;
@property(assign)      NSString    *themeWheelIcon20;
@property(assign)      NSString    *themeWheelIcon21;
@property(assign)      NSString    *themeWheelIcon22;
@property(assign)      NSString    *themeWheelIcon23;
@property(assign)      NSString    *themeWheelIcon24;
@property(assign)      NSString    *themeWheelMiniDial1feed;
@property(assign)      NSString    *themeWheelMiniDial2feed;
@property(assign)      NSString    *themeWheelMiniDial3feed;
@property(assign)      NSString    *themeWheelMiniDial4feed;
@property(assign)      NSString    *themeWheelMiniDial1feedp;
@property(assign)      NSString    *themeWheelMiniDial2feedp;
@property(assign)      NSString    *themeWheelMiniDial3feedp;
@property(assign)      NSString    *themeWheelMiniDial4feedp;
@property(assign)      NSString    *themeWheelMiniDial1feedn;
@property(assign)      NSString    *themeWheelMiniDial2feedn;
@property(assign)      NSString    *themeWheelMiniDial3feedn;
@property(assign)      NSString    *themeWheelMiniDial4feedn;

@property(assign)      NSString    *themeProgWheelIcon1;
@property(assign)      NSString    *themeProgWheelIcon2;
@property(assign)      NSString    *themeProgWheelIcon3;

@property(assign)      float        themeWheelDialRectWidth;
@property(assign)      float        themeWheelDialRectHeight;
@property(assign)      float        themeWheelCenterRectWidth;
@property(assign)      float        themeWheelCenterRectHeight;
@property(assign)      float        themeWheelCenterFeedRectWidth;
@property(assign)      float        themeWheelCenterFeedRectHeight;
@property(assign)      float        themeWheelSegmentRectWidth;
@property(assign)      float        themeWheelSegmentRectHeight;
@property(assign)      float        themeWheelIconSegments;
@property(assign)      float        themeWheelIconOffsetX;
@property(assign)      float        themeWheelIconOffsetY;
@property(assign)      float        themeWheelIconRectWidth;
@property(assign)      float        themeWheelIconRectHeight;

@property(assign)       NSString    *themeLiveTextMainFontName;
@property(assign)       float        themeLiveTextMainFontSize;
@property(strong)       UIColor     *themeLiveTextMainColor;

@property(assign)       NSString    *themeLiveTextDescFontName;
@property(assign)       float        themeLiveTextDescFontSize;
@property(strong)       UIColor     *themeLiveTextDescColor;

@property(assign)       NSString    *themeLiveTextMiniFontName;
@property(assign)       float        themeLiveTextMiniFontSize;
@property(strong)       UIColor     *themeLiveTextMiniColor;

@property(assign)       NSString    *searchMapSearchExhaustManu;
@property(assign)       NSString    *searchMapSearchExhaustType;
@property(assign)       NSString    *searchMapSearchExhaustBaffle;
@property(assign)       NSString    *searchMapSearchEngineSize;
@property(assign)       NSString    *searchCalId;

//@property(assign,nonatomic)       NSString    *searchMapUrl;
@property(assign,nonatomic)       NSString    *searchMediaUrl;
@property(assign,nonatomic)       NSString    *OtaUrl;

@property(strong,nonatomic)       NSString    *eacName;
@property(strong,nonatomic)       NSString    *resourceDirectory;

@property(strong,nonatomic)   UIImageView    *imageView;
@property(strong,nonatomic)   UIImageView    *im;
@property(strong,nonatomic)   UIImageView    *imageView2;
@property(strong,nonatomic)     NSString     *fileLocation;





@property(retain) NSBundle *langBundle;




- (UIColor *)  getActivityColor;



- ( UIColor *) getCellBackgroundColor;
- ( UIColor *) getCellTextLabelTextColor;
- ( UIColor *) getCellTextLabelBackgroundColor;
- ( BOOL )     getCellTextLabelOpaque;
- (NSString *) getCellTextLabelFontName;
- ( float )    getCellTextLabelFontSize;

- ( float )    getCellHeight;
- ( UIColor *) getActiveTextLabelTextColor;
- (NSData *)   getCellSelectedBackgroundView;
- (NSData *)   getCellBackgroundView;
- (NSData *)   getCellAccessoryViewInitWithImage;
- ( UIColor *) getCellSelectedTextLabelTextColor;

- ( UIColor *) getCellDetailTextLabelTextColor;
- ( UIColor *) getCellDetailTextLabelBackgroundColor;
- (NSString *) getCellDetailTextLabelFontName;
- ( float )    getCellDetailTextLabelFontSize;
- ( UIColor *) getCellSeparatorColor;


- ( UIColor *) getBadgeBackgroundColor;
- ( UIColor *) getBadgeTextColor;
- ( UIColor *) getBadgeSelectedBackgroundColor;


- ( UIColor *) getButtonGradientStart;
- ( UIColor *) getButtonGradientEnd;
- ( UIColor *) getButtonColor;
- ( UIColor *) getButtonTitleColorForControlStateNormal;
- ( UIColor *) getButtonTitleColorForControlStateSelected;
- ( NSString *) getButtonTitleLabelFontName;
- ( float )     getButtonTitleLabelFontSize;
- ( NSData *)   getButtonBackgroundImageForControlStateNormal;
- ( NSData *)   getButtonBackgroundImageForControlStateHighlighted;
- ( BOOL)       getButtonColorOverwritesGradient;


- ( NSData *) getNavBarBackgroundImageForBarMetricsDefaultName;
- ( NSData *) getNavBarBackgroundImageForBarMetricsLandscapePhone;
- ( float)       c;
- ( BOOL)        getNavBarHidden;
- ( UIColor *)   getNavBarTintColor;
- ( BOOL)        getNavBarColorOverwritesGradient;
- ( UIColor *)   getNavBarTitleTextColor;
- ( UIColor *)   getNavBarTitleTextColorShadow;

- ( NSData *) getNavButtonRightBackgroundImageForBarMetricsDefaultName;
- ( NSData *) getNavButtonRightBackgroundImageForBarMetricsLandscapePhone;
- ( BOOL)        getNavButtonRightDefaultButtonShape;
- ( UIColor *)   getNavButtonRightTintColor;
- ( NSData *) getNavButtonRightImage;
- ( NSData *) getNavButtonDownImage;
- (int)         getThemesIndex;

- ( NSData *) getMainMenuCustomerSupportImageName;
- ( NSData *) getMainMenuEditMapsImageName;
- ( NSData *) getMainMenuFP3InfoImageName;
- ( NSData *) getMainMenuSearchMapImageName;
- ( NSData *) getMainMenuDtcCodesImageName;
- ( NSData *) getMainMenuResetStockImageName;
- ( NSData *) getMainMenuAutotuneName;
- ( NSData *) getMainMenuLiveDataImageName;
- ( NSData *) getMainMenuNavBarBtnLeft;
- ( NSData *) getMainMenuNavBarBtnRight;

- ( NSData *) getEditMenuNavBarBtnRight;
- ( NSData *) getEditSlotMenuNavBarBtnRight;


- ( NSData *) getDemoMenuLinked;
- ( NSData *) getDemoMenuUnLinked;
- ( NSData *) getDemoMenuWifiOn;
- ( NSData *) getDemoMenuWifiOff;
- ( NSData *) getDemoMenuCart;
- ( NSData *) getDemoMenuPairBt;
- ( NSData *) getDemoMenuPairBtVin;
- ( NSData *) getDemoMenuDemo;


- ( NSData *) getLiveCenter;
- ( NSData *) getLiveNeedle;
- ( NSData *) getLiveNeedleGear;

- ( NSData *) getLiveMiniDial1;
- ( NSData *) getLiveMiniDial2;
- ( NSData *) getLiveMiniDial3;
- ( NSData *) getLiveMiniDial4;
- ( NSData *) getLiveMiniDial1feed;
- ( NSData *) getLiveMiniDial2feed;
- ( NSData *) getLiveMiniDial3feed;
- ( NSData *) getLiveMiniDial4feed;

- ( NSData *) getLiveMainHomeBtn;

- ( NSData *) getLiveMainDial0;
- ( NSData *) getLiveMainDial1;
- ( NSData *) getLiveMainDial2;
- ( NSData *) getLiveMainDial3;
- ( NSData *) getLiveMainDial4;
- ( NSData *) getLiveMainDial5;
- ( NSData *) getLiveMainDial6;
- ( NSData *) getLiveMainDial7;
- ( NSData *) getLiveMainDial8;
- ( NSData *) getLiveMainDial9;

- ( NSData *) getLivePortrait;
- ( NSData *) getLivePortraitUpsideDown;
- ( NSData *) getLiveLandscapeLeft;
- ( NSData *) getLiveLandscapeRight;


- ( NSData *) getWheelDial;
- ( NSData *) getWheelCenter;
- ( NSData *) getWheelCenterFeed;
- ( NSData *) getWheelCenterSel;
- ( NSData *) getWheelSegment;
//- ( NSData *) getWheelSegmentSel;
- ( NSData *) getWheelIcon0;
- ( NSData *) getWheelIcon1;
- ( NSData *) getWheelIcon2;
- ( NSData *) getWheelIcon3;
- ( NSData *) getWheelIcon4;
- ( NSData *) getWheelIcon5;
- ( NSData *) getWheelIcon6;
- ( NSData *) getWheelIcon7;
- ( NSData *) getWheelIcon8;
- ( NSData *) getWheelIcon9;
- ( NSData *) getWheelIcon10;
- ( NSData *) getWheelIcon11;
- ( NSData *) getWheelIcon12;
- ( NSData *) getWheelIcon13;
- ( NSData *) getWheelIcon14;
- ( NSData *) getWheelIcon15;
- ( NSData *) getWheelIcon16;
- ( NSData *) getWheelIcon17;
- ( NSData *) getWheelIcon18;
- ( NSData *) getWheelIcon19;
- ( NSData *) getWheelIcon20;
- ( NSData *) getWheelIcon21;
- ( NSData *) getWheelIcon22;
- ( NSData *) getWheelIcon23;
- ( NSData *) getWheelIcon24;

- ( NSData *) getWheelMiniDial1feed;
- ( NSData *) getWheelMiniDial2feed;
- ( NSData *) getWheelMiniDial3feed;
- ( NSData *) getWheelMiniDial4feed;

- ( NSData *) getWheelMiniDial1feedp;
- ( NSData *) getWheelMiniDial2feedp;
- ( NSData *) getWheelMiniDial3feedp;
- ( NSData *) getWheelMiniDial4feedp;

- ( NSData *) getWheelMiniDial1feedn;
- ( NSData *) getWheelMiniDial2feedn;
- ( NSData *) getWheelMiniDial3feedn;
- ( NSData *) getWheelMiniDial4feedn;




- ( NSData *) getProgWheelIcon1;
- ( NSData *) getProgWheelIcon2;
- ( NSData *) getProgWheelIcon3;





- ( float)       getWheelDialRectWidth;
- ( float)       getWheelDialRectHeight;
- ( float)       getWheelCenterRectWidth;
- ( float)       getWheelCenterRectHeight;
- ( float)       getWheelCenterFeedRectWidth;
- ( float)       getWheelCenterFeedRectHeight;
- ( float)       getWheelSegmentRectWidth;
- ( float)       getWheelSegmentRectHeight;
- ( float)       getWheelIconSegment;
- ( float)       getWheelIconOffsetX;
- ( float)       getWheelIconOffsetY;
- ( float)       getWheelIconRectWidth;
- ( float)       getWheelIconRectHeight;


- (NSString *) getLiveTextMainFontName;
- ( float )    getLiveTextMainFontSize;
- ( UIColor *) getLiveTextMainColor;


- (NSString *) getLiveTextDescFontName;
- ( float )    getLiveTextDescFontSize;
- ( UIColor *) getLiveTextDescColor;

- (NSString *) getLiveTextMiniFontName;
- ( float )    getLiveTextMiniFontSize;
- ( UIColor *) getLiveTextMiniColor;
- (float) getNavBarAlpha;



@end
