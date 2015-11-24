//
//  DMUserCenterService.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/12.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMUserCenterService.h"
#import "DMRequest.h"
#import "DMUserCenterParser.h"
#import "DMSplistParser.h"
#import "DMUserCenterParser.h"

@implementation DMUserCenterService

/**
 *  完善用户资料
 */
+ (void)getUserInformation1WithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kInformation
                          image:nil
                     parameters:params
                         parser:[DMUserInfoDetailParser new]
                        success:^(id returnData){
                            success(returnData);
                        }
                           fail:^(NSError *error){
                               fail(error);
                           }];
}

/**
 *  完善用户资料
 */
+ (void)getUserInformation2WithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kInformation
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

/**
 *  完善用户资料
 */
+ (void)setUserInformation1WithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kInformation
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

/**
 *  完善用户资料
 */
+ (void)setUserInformation2WithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kInformation
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

/**
 *  获取用户信息
 */
+ (void)getUserInforWithParams:(NSDictionary *)params
                       success:(void(^)(id returnData))success
                          fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kUser
                          image:nil
                     parameters:params
                         parser:[DMUserInfoParser new]
                        success:^(id returnData){
                            success(returnData);
                        }
                           fail:^(NSError *error){
                               fail(error);
                           }];
}

/**
 *  我的镖银
 */
+ (void)getUserscoreWithParams:(NSDictionary *)params
                       success:(void(^)(id returnData))success
                          fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kUserscore
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

/**
 *  我的关注
 */
+ (void)getUserlikeWithParams:(NSDictionary *)params
                      success:(void(^)(id returnData))success
                         fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kUserlike
                          image:nil
                     parameters:params
                         parser:[DMSplistParser new]
                        success:^(id returnData){
                            success(returnData);
                        }
                           fail:^(NSError *error){
                               fail(error);
                           }];
}

/**
 *  我的工作经历
 */
+ (void)getUserWorkWithParams:(NSDictionary *)params
                      success:(void(^)(id returnData))success
                         fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kUserwork
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

/**
 *  我的教育经历
 */
+ (void)getUserDoWithParams:(NSDictionary *)params
                    success:(void(^)(id returnData))success
                       fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kUseredu
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
