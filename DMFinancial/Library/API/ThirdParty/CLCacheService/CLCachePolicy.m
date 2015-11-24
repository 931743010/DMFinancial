//
//  CLCachePolicy.m
//  DMCommonService
//
//  Created by lixiang on 14-1-7.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "CLCachePolicy.h"

@implementation CLCachePolicy

+ (instancetype)defaultCachePolicy {
    CLCachePolicy *policy = [[CLCachePolicy alloc] init];
    return policy;
}

- (id)init {
    self = [super init];
    if (self) {
        self.isCache = YES;
        self.isRefresh = NO;
        self.expireTime = 120;
        self.policyLevel = CLCachePolicyDisk;
    }
    
    return self;
}

@end
