//
//  DMUserCenterService.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/12.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMDataService.h"

@interface DMUserCenterService : DMDataService

/**
 *  完善用户资料
 */
+ (void)getUserInformation1WithParams:(NSDictionary *)params
                    success:(void(^)(id returnData))success
                       fail:(void(^)(NSError *error))fail;

/**
 *  完善用户资料
 */
+ (void)getUserInformation2WithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail;

/**
 *  完善用户资料
 */
+ (void)setUserInformation1WithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail;

/**
 *  完善用户资料
 */
+ (void)setUserInformation2WithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail;

/**
 *  获取用户信息
 */
+ (void)getUserInforWithParams:(NSDictionary *)params
                          success:(void(^)(id returnData))success
                             fail:(void(^)(NSError *error))fail;

/**
 *  我的镖银
 */
+ (void)getUserscoreWithParams:(NSDictionary *)params
                          success:(void(^)(id returnData))success
                             fail:(void(^)(NSError *error))fail;

/**
 *  我的关注
 */
+ (void)getUserlikeWithParams:(NSDictionary *)params
                          success:(void(^)(id returnData))success
                             fail:(void(^)(NSError *error))fail;

/**
 *  我的工作经历
 */
+ (void)getUserWorkWithParams:(NSDictionary *)params
                          success:(void(^)(id returnData))success
                             fail:(void(^)(NSError *error))fail;

/**
 *  我的教育经历
 */
+ (void)getUserDoWithParams:(NSDictionary *)params
                          success:(void(^)(id returnData))success
                             fail:(void(^)(NSError *error))fail;


@end
