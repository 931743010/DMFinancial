//
//  DMInformationService.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/12.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMDataService.h"

/**
 *  资讯活动
 */
@interface DMInformationService : DMDataService

/**
 *  资讯列表
 */

+ (void)getInformationListWithParams:(NSDictionary *)params
                     success:(void(^)(id returnData))success
                        fail:(void(^)(NSError *error))fail;

/**
 *  资讯明细
 */

+ (void)getInformationDetailWithParams:(NSDictionary *)params
                     success:(void(^)(id returnData))success
                        fail:(void(^)(NSError *error))fail;


/**
 *  参加活动、感兴趣 按钮
 */

+ (void)getInformationJoinWithParams:(NSDictionary *)params
                     success:(void(^)(id returnData))success
                        fail:(void(^)(NSError *error))fail;


@end
