//
//  DMDataService.h
//  DMCommonService
//
//  Created by lixiang on 13-12-16.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLCachePolicy;
@interface DMDataService : NSObject

/**
 *
 *
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param fail       失败回调
 */
+ (void)serviceWithParameters:(NSDictionary *)parameters
                      success:(void (^)(id returnData))success
                         fail:(void (^)(NSError *error))fail;

/**
 *  含缓存和过期时间
 *
 *  @param parameters 参数
 *  @param policy     缓存策略
 *  @param expireTime 过期时间
 *  @param success    成功回调
 *  @param fail       失败回调
 */
+ (void)serviceWithParameters:(NSDictionary *)parameters
                  cachePolicy:(CLCachePolicy *)policy
                      success:(void (^)(id returnData))success
                         fail:(void (^)(NSError *error))fail;
@end
