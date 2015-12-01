//
//  DMLoginService.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/12.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMLoginService.h"
#import "DMRequest.h"
#import "DMUserLoginParser.h"

@implementation DMLoginService

+ (void)userLoginWithParams:(NSDictionary *)params
                    success:(void(^)(id returnData))success
                       fail:(void(^)(NSError *error))fail
{
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kP2PLib
                          image:nil
                 parameters:params
                     parser:[DMUserLoginParser new]
                    success:^(id returnData){
                        success(returnData);
                    }
                       fail:^(NSError *error){
                           fail(error);
                       }];
}

+ (void)userRegisterWithParams:(NSDictionary *)params
                    success:(void(^)(id returnData))success
                       fail:(void(^)(NSError *error))fail
{
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kP2PLib
                          image:nil
                     parameters:params
                         parser:nil
                        success:^(id returnData){
                            success(returnData);
                        }
                           fail:^(NSError *error){
                               fail(error);
                           }];
}

@end

