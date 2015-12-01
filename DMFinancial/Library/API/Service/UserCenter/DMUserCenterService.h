//
//  DMUserCenterService.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/12.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMDataService.h"

@interface DMUserCenterService : DMDataService

/**
 *  完善用户资料
 */
+ (void)getUserInformation1WithParams:(NSDictionary *)params
                    success:(void(^)(id returnData))success
                       fail:(void(^)(NSError *error))fail;


@end
