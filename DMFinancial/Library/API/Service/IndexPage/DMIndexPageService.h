//
//  DMIndexPageService.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMDataService.h"

@interface DMIndexPageService : DMDataService

+ (id)fetchCacheWithParameters:(NSDictionary *)parameters;

/**
 *  消息
 */

+ (void)getMessageListWithParams:(NSDictionary *)params
                         success:(void(^)(id returnData))success
                            fail:(void(^)(NSError *error))fail;

/**
 *  排行榜
 */

+ (void)getHotListWithParams:(NSDictionary *)params
                     success:(void(^)(id returnData))success
                        fail:(void(^)(NSError *error))fail;

/**
 *  羊毛
 */

+ (void)getYangmaoListWithParams:(NSDictionary *)params
                         success:(void(^)(id returnData))success
                            fail:(void(^)(NSError *error))fail;

/**
 *  新手入门
 */

+ (void)getNewcomerListWithParams:(NSDictionary *)params
                          success:(void(^)(id returnData))success
                             fail:(void(^)(NSError *error))fail;

/**
 *  P2P产品库
 */

+ (void)getP2PLibListWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail;
/**
 *  首页列表
 */

+ (void)getProjectLibListWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail;

/**
 *  获取搜索结果
 */
+ (void)getSearchListWithParams:(NSDictionary *)params
                    cachePolicy:(CLCachePolicy *)policy
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail;

/**
 *  获取热门搜索
 */

+ (void)getSearchHotWordListWithParams:(NSDictionary *)params
                           cachePolicy:(CLCachePolicy *)policy
                               success:(void(^)(id returnData))success
                                  fail:(void(^)(NSError *error))fail;

@end
