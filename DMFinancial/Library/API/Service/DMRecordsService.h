//
//  DMRecordsService.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/12.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMDataService.h"

@interface DMRecordsService : DMDataService

/**
 *   咨询Id
 */

+ (void)getRecordIdWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail;

/**
 *   咨询列表
 */

+ (void)getRecordListWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail;

/**
 *  咨询历史
 */

+ (void)getHistoryWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail;

/**
 *  发送消息
 */

+ (void)sendmsgWithParams:(NSDictionary *)params
                        success:(void(^)(id returnData))success
                           fail:(void(^)(NSError *error))fail;

@end
