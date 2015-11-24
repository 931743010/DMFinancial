//
//  NSArray+Additions.m
//  CommonLibrary
//
//  Created by 陈彦岐 on 14-7-23.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

/**
 *  功能同objectAtIndex，添加了防数组越界
 */
- (id)objectAt:(NSUInteger)index {
    @synchronized (self) {
        NSUInteger count =[self count];
        if (index < count) {
            return [self objectAtIndex:index];
        }
        return nil;
    }
}

/**
 *  从数组中获得第一个对象，或者从空数组中返回零
 *
 *  @return 数组中的第一个元素
 */
- (id)firstObject
{
    return self.count > 0 ? self[ 0 ] : nil;
}

@end
