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
@end
