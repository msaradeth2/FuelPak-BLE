//
//  EAController.h
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/22/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EAController : NSObject
{
    
}

+(id) sharedController;

@property(retain) NSBundle *langBundle;



- (void) testMethod;

@end
