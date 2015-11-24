//
//  DMDataService.m
//  DMCommonService
//
//  Created by lixiang on 13-12-16.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMDataService.h"

@implementation DMDataService

+ (void)serviceWithParameters:(NSDictionary *)parameters
                      success:(void (^)(id returnData))success
                         fail:(void (^)(NSError *error))fail {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}


+ (void)serviceWithParameters:(NSDictionary *)parameters
                  cachePolicy:(CLCachePolicy *)policy
                      success:(void (^)(id returnData))success
                         fail:(void (^)(NSError *error))fail {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}
@end
