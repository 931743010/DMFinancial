//
//  DMFeedBackService.m
//  DMCommonService
//
//  Created by 陈彦岐 on 13-12-17.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMFeedBackService.h"
#import "DMRequest.h"

@implementation DMFeedBackService

+ (void)serviceWithParameters:(NSDictionary *)parameters
                      success:(void (^)(id returnData))success
                         fail:(void (^)(NSError *error))fail {
    
    DMRequest *request = [DMRequest new];
    [request requestWithUrl:nil
                 parameters:parameters
                     parser:nil
                    success:^(id returnData) {
                        success(returnData);
                    } fail:^(NSError *error) {
                        fail(error);
                    }];
}

@end
