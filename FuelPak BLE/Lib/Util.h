//
//  Util.h
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/21/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Util : NSObject
{
    
}



+(id) shared;

@property(retain) NSBundle *langBundle;



- (void) testMethod;
- (float) getCellHeight;

@end
