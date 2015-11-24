//
//  DMLoginService.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/12.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMDataService.h"

@interface DMLoginService : DMDataService

/**
 *  登录
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)userLoginWithParams:(NSDictionary *)params
                    success:(void(^)(id returnData))success
                       fail:(void(^)(NSError *error))fail;


/**
 *  注册
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */

+ (void)userRegisterWithParams:(NSDictionary *)params
                       success:(void(^)(id returnData))success
                          fail:(void(^)(NSError *error))fail;


@end
