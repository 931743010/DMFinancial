//
//  DMDiscoveryDateDetail.m
//  DMPlayCommonService
//
//  Created by Joseph Fu on 14/12/31.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMDiscoveryDateDetail.h"

@implementation DMDiscoveryDateDetail

- (NSString *)description
{
    return [NSString stringWithFormat:@"<date: %@, total count:%ld, remainder count: %ld>", self.dateString, (long)self.totalCount, (long)self.remainderCount];
}

- (NSInteger)remainderCount
{
    return self.totalCount - self.items.count;
}

- (BOOL)isFull
{
    return self.totalCount == self.items.count;
}

@end
