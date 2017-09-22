//
//  TCCellData.m
//  Fuelpak FP3
//
//  Created by Mike Saradeth on 5/11/15.
//  Copyright (c) 2015 Vance & Hines. All rights reserved.
//

#import "TCCellData.h"

@implementation TCCellData

@synthesize troubleCode;
@synthesize troubleCodeDescription;
@synthesize troubleCodeDescriptionDetail;
@synthesize icon;
@synthesize isParent;
@synthesize isExpanded;
@synthesize childItems;
@synthesize indexPath;
@synthesize row;


-(instancetype)init
{
    self = [super init];
    self.icon = [UIImage imageNamed: @"nav_right"];
    self.isParent=YES;
    self.isExpanded=NO;
    self.childItems = [[NSMutableArray alloc] init];
    self.row=-1;
    
    return self;
}

- (id)initWithTroubleCode:(NSString *) mTroubleCode
{
    if( self = [super init] )
    {
        self.troubleCode = mTroubleCode;
        self.troubleCodeDescription = nil;
        self.icon = [UIImage imageNamed: @"nav_right"];
        self.isParent = YES;
        self.isExpanded = NO;
        self.childItems = [[NSMutableArray alloc] init];
        self.row=-1;
    }
    
    return self;
}


- (id)initWithTroubleCode:(NSString *) mTroubleCode
   troubleCodeDescription:(NSString *) mTroubleCodeDescription
{
    if( self = [super init] )
    {
        self.troubleCode = mTroubleCode;
        self.troubleCodeDescription = mTroubleCodeDescription;
        self.icon = [UIImage imageNamed: @"nav_right"];
        self.isParent = YES;
        self.isExpanded = NO;
        self.childItems = [[NSMutableArray alloc] init];
        self.row=-1;
    }
    
    return self;
}


- (id)initWithTroubleCode:(NSString *) mTroubleCode
   troubleCodeDescription:(NSString *) mTroubleCodeDescription
                     icon:(UIImage *) mIcon
                 isParent: (BOOL) mIsParent
               isExpanded: (BOOL) mIsExpanded
{
    if( self = [super init] )
    {
        self.troubleCode = mTroubleCode;
        self.troubleCodeDescription = mTroubleCodeDescription;
        self.icon = mIcon;
        self.isParent = mIsParent;
        self.isExpanded = mIsExpanded;
        self.childItems = [[NSMutableArray alloc] init];
        self.row=-1;
    }
    
    return self;
}


- (instancetype)initChild:(NSString *) mTroubleCodeDescriptionDetail {
    
    if( self = [super init] ) {
        self.troubleCode = nil;
        self.troubleCodeDescription = nil;
        self.icon = nil;
        self.isParent=NO;
        self.isExpanded=NO;
        self.childItems = nil;
        self.troubleCodeDescriptionDetail = mTroubleCodeDescriptionDetail;
        self.row=-1;
    }
    
    return self;
    
}

@end

