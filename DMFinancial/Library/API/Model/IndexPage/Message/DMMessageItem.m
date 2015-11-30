//
//  DMMessageItem.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMMessageItem.h"

@implementation DMMessageItem

- (NSDictionary *)propertyNameMapping {
    return @{
             @"id":@"title",
             @"url1":@"time",
             @"actimg":@"contents",
             @"isNewMessage":@"isNewMessage"
             };
}

- (NSDictionary *)propertyTypeFormat
{
    return nil;
}

@end
