//
//  DMActivity.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/24.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMActivity.h"

@implementation DMActivity

- (NSDictionary *)propertyNameMapping {
    return @{
             @"id":@"activityId",
             @"url":@"url",
             @"actimg":@"actimg",
             @"actlogo":@"actlogo",
             @"acttime":@"acttime",
             @"actplace":@"actplace",
             @"acttitle":@"acttitle",
             @"summary":@"summary"
             };
}

- (NSDictionary *)propertyTypeFormat
{
    return nil;
}

@end
