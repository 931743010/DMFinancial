//
//  DMSplistService.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/12.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMDataService.h"

/**
 *  专家在线
 */

@interface DMSplistService : DMDataService

/**
 *  专家列表
 */

+ (void)getSplistListWithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail;

/**
 *  获取分类列表
 */

+ (void)getGoodsListWithParams:(NSDictionary *)params
                       success:(void(^)(id returnData))success
                          fail:(void(^)(NSError *error))fail;

/**
 *  专家详细资料
 */

+ (void)getSplistDetailWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail;

/**
 *  关注专家
 */

+ (void)likeSplistListWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail;

/**
 *  举报专家
 */

+ (void)reportSplistListWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail;

@end
