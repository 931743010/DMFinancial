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
    [request requestPostWithUrl:kP2PLib
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

@end
