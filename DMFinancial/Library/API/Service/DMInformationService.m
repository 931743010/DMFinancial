//
//  DMInformationService.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/12.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMInformationService.h"
#import "DMRequest.h"
#import "DMActivityParser.h"

@implementation DMInformationService


/**
 *  资讯列表
 */

+ (void)getInformationListWithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestWithUrl:kInformation1
                     parameters:params
                         parser:[DMActivityParser new]
                        success:^(id returnData){
                            success(returnData);
                        }
                           fail:^(NSError *error){
                               fail(error);
                           }];
}


/**
 *  资讯明细
 */

+ (void)getInformationDetailWithParams:(NSDictionary *)params
                               success:(void(^)(id returnData))success
                                  fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kInformation1
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
 *  参加活动、感兴趣 按钮
 */

+ (void)getInformationJoinWithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kInformation1
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
