//
//  DMUserLoginService.h
//  DMPlayCommonService
//
//  Created by 陈彦岐 on 14/12/29.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMDataService.h"

@interface DMUserLoginService : DMDataService

/**
 *  登录
 *
 */
+ (void)serviceUserLoginWithParameters:(NSDictionary *)parameters
                               success:(void (^)(id returnData))success
                                  fail:(void (^)(NSError *error))fail;

/**
 *  用户手机注册前获取验证码
 *
 */
+ (void)serviceUserRegbycodeWithParameters:(NSDictionary *)parameters
                                   success:(void (^)(id returnData))success
                                      fail:(void (^)(NSError *error))fail;

/**
 *  用户注册
 *
 */
+ (void)serviceUserRegisterWithParameters:(NSDictionary *)parameters
                                  success:(void (^)(id returnData))success
                                     fail:(void (^)(NSError *error))fail;
@end
