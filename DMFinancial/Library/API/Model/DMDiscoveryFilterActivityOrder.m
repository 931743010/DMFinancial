//
//  DMDiscoveryFilterActivityOrder.m
//  DMPlayCommonService
//
//  Created by Joseph Fu on 14/12/30.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMDiscoveryFilterActivityOrder.h"

@implementation DMDiscoveryFilterActivityOrder

- (NSDictionary *)propertyNameMapping {
    return @{
             @"name":@"name",
             @"order": @"order",
             @"desc": @"visualName"
             };
}

//- (NSString *)visualName
//{
//    if ([self.name isEqualToString:@"publishtime"]) {
//        return @"最新";
//    }
//    if ([self.name isEqualToString:@"prit"]) {
//        return @"最热";
//    }
//    if ([self.name isEqualToString:@"likercount"]) {
//        return @"离我最近";
//    }
//    return nil;
//}

+ (instancetype)defaultActivityOrder
{
    DMDiscoveryFilterActivityOrder *order = [DMDiscoveryFilterActivityOrder new];
    order.name = @"";
    order.order = @"";
    return order;
}

- (BOOL)isDefaultActivityOrder
{
    return (self.name.length == 0 && self.order.length == 0);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@，order:%@", self.name, self.order];
}
@end
