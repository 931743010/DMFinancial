//
//  DMBaseViewController+Addition.h
//  DamaiIphone
//
//  Created by lixiang on 13-12-27.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMBaseViewController.h"

@interface DMBaseViewController (Addition)

- (void)pushWithSubjectType:(DMSubjectType)type params:(NSDictionary *)params;

//登录统一入口
- (void)userLoginWithDelegate:(UIViewController *)target
                 success:(void (^)(id returnData))success
                    fail:(void (^)(NSError *error))fail;
////注册统一入口
//- (void)userRegisterWithDelegate:(UIViewController *)target
//                 success:(void (^)(id returnData))success
//                    fail:(void (^)(NSError *error))fail;

@end
