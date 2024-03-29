//
//  DMProjectListItem.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/26.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMProjectListItem.h"

@implementation DMProjectList

- (NSDictionary *)propertyNameMapping {
    return @{
             @"id":@"projectsData",
             @"url1":@"totalCount",
             };
}

- (NSDictionary *)propertyTypeFormat
{
    return @{
             @"projectsData":@"DMProjectListItem",
             };
}

@end

@implementation DMProjectListItem

- (NSDictionary *)propertyNameMapping {
    return @{
             @"id":@"itemId",
             @"url1":@"name",
             @"actimg":@"dec",
             @"actlogo":@"assetsType",
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
