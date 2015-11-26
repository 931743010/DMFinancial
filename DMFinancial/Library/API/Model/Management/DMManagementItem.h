//
//  DMManagementItem.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/25.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMObject.h"

@interface DMManagementItem : DMObject

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, assign) BOOL hasNew;
@property (nonatomic, strong) NSString *yield;
@property (nonatomic, strong) NSString *dayGains;
@property (nonatomic, strong) NSString *url;

@end   