//
//  DMYangmaoItem.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMYangmaoItem.h"

@implementation DMYangmaoItem

- (NSDictionary *)propertyNameMapping {
    return @{
             @"id":@"itemId",
             @"url1":@"imageUrl",
             @"url1":@"url",
             @"url1":@"title",

             };
}

- (NSDictionary *)propertyTypeFormat
{
    return nil;
}

@end
