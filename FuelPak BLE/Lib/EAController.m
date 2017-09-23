//
//  EAController.m
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/22/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

#import "EAController.h"

@implementation EAController

static EAController *_eaController = nil;


+(id)sharedController
{
    if (_eaController == nil) {
        _eaController = [[EAController alloc] init];
        [_eaController initVariables];
    }
    
    return _eaController;
}




- (void)initVariables
{
    
    printf("Util init() creating class\n");
    
    NSString *languagecode = [self getPreferredLanguageCode];
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





@end
