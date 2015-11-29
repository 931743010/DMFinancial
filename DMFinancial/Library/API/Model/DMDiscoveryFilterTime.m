//
//  DMDiscoveryFilterTime.m
//  DMPlayCommonService
//
//  Created by Joseph Fu on 14/12/30.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMDiscoveryFilterTime.h"

@implementation DMDiscoveryFilterTime

- (NSDictionary *)propertyNameMapping {
    return @{
             @"stime":@"startTime",
             @"etime": @"endTime"
             };
}

- (NSDictionary *)propertyTypeFormat {
    return nil;
}

+ (instancetype)defaultFilterTime
{
    DMDiscoveryFilterTime *filterTime = [DMDiscoveryFilterTime new];
    filterTime.name = @"全部时间";
    filterTime.startTime = @"";
    filterTime.endTime = @"";
    return filterTime;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@，startTime:%@, endTime:%@", self.name, self.startTime, self.endTime];
}

- (BOOL)isDefaultFilterTime
{
    return (self.startTime.length == 0 && self.endTime.length == 0);
}

@end
