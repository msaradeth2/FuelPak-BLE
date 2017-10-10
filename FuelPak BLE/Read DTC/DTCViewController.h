//
//  DTCViewController.h
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/21/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "TCCellData.h"
//#import "EAController.h"
//#import "FuelPak BLE-Bridging-Header.h"


@interface DTCViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate>
{
    NSMutableArray  *listOfButtonTitles;
    
    NSMutableArray  *listOfItems;
    NSMutableArray  *listOfKeyItems;
    
    NSArray         *listOfIparseditems;
    NSArray         *listOfIparsedfields;
    
    NSDictionary    *dtcdict;
    
    NSTimeInterval  timerWait;
    //NSInteger       progresscnt;
    //NSInteger       progretrycnt;
    
//    T_TRANSFERMAC   mac;
    
    
    UIInterfaceOrientation  currinterfaceOrientation;
    UIInterfaceOrientation  previnterfaceOrientation;
    UIInterfaceOrientation  prevDialogOrientation;
    
    
    NSString        *localeConnectedApp;
    NSString        *localeDisconnectedApp;
    NSString        *localeUnknownDevice;
    NSString        *localeDemoMode;
    NSString        *localeUnableToReadDtc;
    
    //NSString        *localeTitle;
    NSString        *localeTitle1;
    NSString        *localeTitle2;
    NSString        *localeTitle3;
    NSString        *localeTitle4;
    
    NSString        *localeSubTitle;
    NSString        *localeDialogCancel;
    NSString        *localeNotFound;
    
    
    unsigned int    notification_flag;
    unsigned int    tsb_hideanimatedflag;
    float           tsb_hidedelayvalue;
    
    
    unsigned int    prev_conn;
    NSString        *fp3EAdevicename;
    
    unsigned int    dtcstate[4];
    
    CGFloat         demoprogress;
    CGFloat         liveprogress;
    
    NSMutableData *_responseData;
    TCCellData *currCellData;
    
    NSBundle *langBundle;
    
}

@property (nonatomic, strong) IBOutlet UILabel *uilblDTCWarning;
@property (nonatomic, strong) IBOutlet UITableView *uitableviewDTCcode;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *uinavbtnRefresh;

@property (nonatomic, strong) IBOutlet UINavigationBar *uinavbarMain;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *uinavbtnBack;

@property (nonatomic, strong) IBOutlet UINavigationItem *uinavitemMainTitle;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *uibtnClear;
//@property (nonatomic, strong) IBOutlet UIButton *uibtnClear;

//@property (atomic, strong) CODialog *dialog;

@property(atomic, strong) NSTimer *timer_live;
//@property (nonatomic, strong) GCDiscreetNotificationView *notificationView;

@property(nonatomic, strong) NSDictionary *dtcdict;

@property (strong) UIImage *uiimageBackground;

@property (nonatomic, strong) UITableViewCell *cellTable;
@property (nonatomic, strong) NSMutableArray  *cellPtr;
//@property (nonatomic, strong) NSBundle *langBundle;

- (void) updateUI:(TCCellData *)cellData;
- (void) showErrorDialog;


@end
