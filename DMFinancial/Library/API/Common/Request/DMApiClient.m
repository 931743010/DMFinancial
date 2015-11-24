//
//  DMApiClient.m
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMApiClient.h"

@implementation DMApiClient

+ (instancetype)shareDMApiClient {
    static DMApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DMApiClient alloc] initWithBaseURL:[NSURL URLWithString:DMAPIBaseURL]];
    });
    
    return _sharedClient;
}

@end
