//
//  TCCellData.h
//  Fuelpak FP3
//
//  Created by Mike Saradeth on 5/11/15.
//  Copyright (c) 2015 Vance & Hines. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCCellData : NSObject

@property(nonatomic, strong) UIImage *icon;
@property(nonatomic, strong) NSString *troubleCode;
@property(nonatomic, strong) NSString *troubleCodeDescription;
@property(nonatomic, assign) BOOL isParent;     //is this a parent or child cell
@property(nonatomic, assign) BOOL isExpanded;   //if parent cell, is the cell expanded
@property(nonatomic, strong) NSString *troubleCodeDescriptionDetail;
@property(nonatomic, strong) NSMutableArray *childItems;
@property(nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic, assign) int row;

- (id)initWithTroubleCode:(NSString *) mTroubleCode;

- (id)initWithTroubleCode:(NSString *) mTroubleCode
   troubleCodeDescription:(NSString *) mTroubleCodeDescription;

- (id)initWithTroubleCode:(NSString *) mTroubleCode
   troubleCodeDescription:(NSString *) mTroubleCodeDescription
                     icon:(UIImage *) mIcon
                 isParent: (BOOL) mIsParent
               isExpanded: (BOOL) mIsExpanded;


- (instancetype)initChild:(NSString *) mTroubleCodeDescriptionDetail;


@end
