//
//  DMUserLoginService.m
//  DMPlayCommonService
//
//  Created by 陈彦岐 on 14/12/29.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMUserLoginService.h"
#import "DMRequest.h"
#import "DMUserLoginParser.h"
#import "DMGlobalVar.h"
#import "DMUserLoginInfo.h"
#import "NSMutableDictionary+Addition.h"

@implementation DMUserLoginService

+ (void)serviceUserLoginWithParameters:(NSDictionary *)parameters
                               success:(void (^)(id returnData))success
                                  fail:(void (^)(NSError *error))fail {
    DMRequest *request = [[DMRequest alloc] init];
    DMUserLoginParser *parser = [[DMUserLoginParser alloc] init];
    [request requestWithUrl:kUserLogin
                 parameters:parameters
                     parser:parser
                    success:^(id returnData) {
                        [DMGlobalVar shareGlobalVar].userLoginInfo = (DMUserLoginInfo *)returnData;
                    } fail:^(NSError *error) {
                        fail(error);
                    }];
}

+ (void)serviceUserRegbycodeWithParameters:(NSDictionary *)parameters
                                   success:(void (^)(id returnData))success
                                      fail:(void (^)(NSError *error))fail {
    DMRequest *request = [[DMRequest alloc] init];
    //    DMWeixinAuthParser *parser = [[DMWeixinAuthParser alloc] init];
    [request requestWithUrl:kUserRegbycode
                 parameters:parameters
                     parser:nil
                    success:^(id returnData) {
                        success(returnData);
                    } fail:^(NSError *error) {
                        fail(error);
                    }];
}

+ (void)serviceUserRegisterWithParameters:(NSDictionary *)parameters
                                  success:(void (^)(id returnData))success
                                     fail:(void (^)(NSError *error))fail {
    DMRequest *request = [[DMRequest alloc] init];
    DMUserLoginParser *parser = [[DMUserLoginParser alloc] init];
    [request requestWithUrl:kRegister
                     parameters:parameters
                         parser:parser
                        success:^(id returnData) {
                            success(returnData);
                        } fail:^(NSError *error) {
                            fail(error);
                        }];
}

@end
