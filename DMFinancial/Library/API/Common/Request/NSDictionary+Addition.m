//
//  NSDictionary+Addition.m
//  CLCommonLib
//
//  Created by lixiang on 13-12-26.
//  Copyright (c) 2013年 cleexiang. All rights reserved.
//

#import "NSDictionary+Addition.h"

@implementation NSDictionary (Addition)

- (NSString *)toString {
    NSArray *keys = [self allKeys];
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    NSMutableString *str = [NSMutableString string];
    for (NSString *key in keys) {
        [str appendFormat:@"%@%@", key, [self objectForKey:key]];
    }
    return [str lowercaseString];
}

@end
