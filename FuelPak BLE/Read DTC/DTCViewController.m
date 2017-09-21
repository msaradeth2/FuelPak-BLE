//
//  DTCViewController.m
//  FuelPak BLE
//
//  Created by Mike Saradeth on 9/21/17.
//  Copyright © 2017 Mike Saradeth. All rights reserved.
//

#import "DTCViewController.h"
#import "EAController.h"

@interface DTCViewController ()

@end

@implementation DTCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self updateTheme];
}


- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










#pragma mark - Update Theme

- (void) updateTheme
{
    
    NSString *resourceDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *imageName  = [resourceDirectory stringByAppendingPathComponent:@"background33.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:  [UIImage imageWithContentsOfFile: imageName]   ]];
    
    
    [self.uinavbarMain setAlpha:  [[EAController sharedController] getNavBarAlpha]];
    [self.uinavbarMain setHidden: [[EAController sharedController] getNavBarHidden]];
    
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [self.uinavbtnBack setTintColor: [UIColor whiteColor] ];
        [self.uinavbtnRefresh setTintColor: [UIColor whiteColor] ];
        
    }
    else
    {
        [self.uinavbtnBack setTintColor: [UIColor clearColor] ];
        [self.uinavbtnRefresh setTintColor: [UIColor clearColor] ];
    }
    
    
    
    BOOL navflag = [[EAController sharedController] getNavBarColorOverwritesGradient];
    if ( navflag==TRUE )
    {
        [self.uinavbarMain setTintColor: [[EAController sharedController] getNavBarTintColor]];
        
        [self.uinavbarMain setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.uinavbarMain setBackgroundImage:nil forBarMetrics:UIBarMetricsLandscapePhone];
        
    }
    else
    {
        UIImage *gradientImage44 = [[UIImage imageWithData:[[EAController sharedController] getNavBarBackgroundImageForBarMetricsDefaultName]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        UIImage *gradientImage32 = [[UIImage imageWithData:[[EAController sharedController] getNavBarBackgroundImageForBarMetricsLandscapePhone]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        [self.uinavbarMain setBackgroundImage:gradientImage44 forBarMetrics:UIBarMetricsDefault];
        [self.uinavbarMain setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsLandscapePhone];
    }
    
    
    [self.uinavbarMain setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [[EAController sharedController] getNavBarTitleTextColor],          UITextAttributeTextColor,
      [[EAController sharedController] getNavBarTitleTextColorShadow],    UITextAttributeTextShadowColor,
      nil]];
    
    
    
    [self.uitableviewDTCcode setSeparatorColor:[[EAController sharedController] getCellSeparatorColor] ];
    
    


    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
