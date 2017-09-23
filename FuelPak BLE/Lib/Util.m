//
//  Util.m
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/21/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

#import "Util.h"

@implementation Util
static Util *util = nil;


+(id)shared
{
    if (util == nil) {
        util = [[Util alloc] init];
        [util initVariables];
    }
    
    return util;
}




- (void)initVariables
{
    
    printf("Util init() creating class\n");

    NSString *languagecode = [[Util shared] getPreferredLanguageCode];
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Localizable" ofType:@"strings" inDirectory:nil forLocalization:languagecode];

    if (bundlePath == nil) {
        bundlePath = [[NSBundle mainBundle] pathForResource:@"Localizable" ofType:@"strings" inDirectory:nil forLocalization:@"en"];
    }
    self.langBundle = [[NSBundle alloc] initWithPath:[bundlePath stringByDeletingLastPathComponent]];
    
    
}


- (NSString*) getPreferredLanguageCode
{
    
    NSString *languagecode = [[NSBundle mainBundle] preferredLocalizations].firstObject;
    
    return languagecode;
}


- (void) testMethod
{
    printf("testMethod ... \n");
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
    CGFloat screenWidth = 0.0;
    
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
