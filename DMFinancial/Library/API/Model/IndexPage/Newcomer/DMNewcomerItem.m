//
//  DMNewcomerItem.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMNewcomerItem.h"

@implementation DMNewcomerItem

- (NSDictionary *)propertyNameMapping {
    return @{
             @"id":@"itemId",
             @"url1":@"imageUrl",
             @"url1":@"url",
             };
}

- (NSDictionary *)propertyTypeFormat
{
    return nil;
}

@end
