//
//  EAController.h
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/22/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CODE_DEBUG                        // must be off for release
#define HTTP_DEBUG                        // must be off for release
//
#define DEV_SERVER                        // must be off for release
//#define DEV2_SERVER                     // must be off for release
//#define STAGING_SERVER                  // must be off for release

//#define DebugOn false                     // must set to false for release
#define DebugOn true                     // must set to false for release

@interface EAController : NSObject
{
    
}

+(id) sharedController;

@property(retain) NSBundle *langBundle;



- (void) testMethod;

@end
