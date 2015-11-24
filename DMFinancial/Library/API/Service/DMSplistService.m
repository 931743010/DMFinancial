//
//  DMSplistService.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/12.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMSplistService.h"
#import "DMRequest.h"
#import "DMSplistParser.h"


@implementation DMSplistService

/**
 *  专家列表
 */

+ (void)getSplistListWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kSplist
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
 *  获取分类列表
 */

+ (void)getGoodsListWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kSplist
                          image:nil
                     parameters:params
                         parser:[DMGoodsListParser new]
                        success:^(id returnData){
                            success(returnData);
                        }
                           fail:^(NSError *error){
                               fail(error);
                           }];
}

/**
 *  专家详细资料
 */

+ (void)getSplistDetailWithParams:(NSDictionary *)params
                          success:(void(^)(id returnData))success
                             fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kSplist
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
 *  关注专家
 */

+ (void)likeSplistListWithParams:(NSDictionary *)params
                         success:(void(^)(id returnData))success
                            fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kSplist
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
 *  举报专家
 */

+ (void)reportSplistListWithParams:(NSDictionary *)params
                           success:(void(^)(id returnData))success
                              fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kSplist
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
