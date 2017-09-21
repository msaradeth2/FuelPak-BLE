//
//  DTCViewController.h
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/21/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDiscreetNotificationView.h"

@interface DTCViewController : UIViewController
{
    NSMutableArray  *listOfItems;
    NSMutableArray  *listOfKeyItems;
}

@property (nonatomic, strong) IBOutlet UILabel *uilblDTCWarning;
@property (nonatomic, strong) IBOutlet UITableView *uitableviewDTCcode;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *uinavbtnRefresh;

@property (nonatomic, strong) IBOutlet UINavigationBar *uinavbarMain;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *uinavbtnBack;

@property (nonatomic, strong) IBOutlet UINavigationItem *uinavitemMainTitle;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *uibtnClear;
//@property (nonatomic, strong) IBOutlet UIButton *uibtnClear;

@property (nonatomic, strong) GCDiscreetNotificationView *notificationView;
@property(nonatomic, strong) NSDictionary *dtcdict;

@property (strong) UIImage *uiimageBackground;

@property (nonatomic, strong) NSBundle *langBundle;

@end
