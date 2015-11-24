//
//  DMSplist.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMSplist.h"

@implementation DMSplist
- (NSDictionary *)propertyNameMapping {
    return @{
             @"spid":@"spid",
             @"city":@"city",
             @"name":@"name",
             @"level":@"level",
             @"leveltitle":@"leveltitle",
             @"cert":@"cert",
             @"title":@"title",
             @"goods":@"goods",
             @"signa":@"signa",
             @"description":@"desc",
             @"State":@"State"
             };
}

- (NSDictionary *)propertyTypeFormat
{
    return nil;
}

@end

@implementation DMGoodsItem
- (NSDictionary *)propertyNameMapping {
    return @{
             @"id":@"goodsId",
             @"goods":@"goods"
             };
}

- (NSDictionary *)propertyTypeFormat
{
    return nil;
}

@end
