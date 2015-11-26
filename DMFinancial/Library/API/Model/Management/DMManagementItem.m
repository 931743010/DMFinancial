//
//  DMManagementItem.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/25.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMManagementItem.h"

@implementation DMManagementItem

- (NSDictionary *)propertyNameMapping {
    return @{
             @"id":@"itemId",
             @"url1":@"name",
             @"actimg":@"number",
             @"actlogo":@"hasNew",
             @"acttime":@"yield",
             @"actplace":@"dayGains",
             @"url":@"url",

             };
}

- (NSDictionary *)propertyTypeFormat
{
    return nil;
}

@end
