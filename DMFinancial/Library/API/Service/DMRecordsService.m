//
//  DMRecordsService.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/12.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMRecordsService.h"
#import "DMRequest.h"
#import "DMRecordsParser.h"

@implementation DMRecordsService

/**
 *   咨询id
 */

+ (void)getRecordIdWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kRecords
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
 *   咨询列表
 */

+ (void)getRecordListWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kRecords
                          image:nil
                     parameters:params
                         parser:[DMRecordsListParser new]
                        success:^(id returnData){
                            success(returnData);
                        }
                           fail:^(NSError *error){
                               fail(error);
                           }];
}


/**
 *  咨询历史
 */

+ (void)getHistoryWithParams:(NSDictionary *)params
                     success:(void(^)(id returnData))success
                        fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kRecords
                          image:nil
                     parameters:params
                         parser:[DMRecordsParser new]
                        success:^(id returnData){
                            success(returnData);
                        }
                           fail:^(NSError *error){
                               fail(error);
                           }];
}


/**
 *  发送消息
 */

+ (void)sendmsgWithParams:(NSDictionary *)params
                  success:(void(^)(id returnData))success
                     fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestPostWithUrl:kRecords
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
