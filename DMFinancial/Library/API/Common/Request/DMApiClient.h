//
//  DMApiClient.h
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "AFHTTPClient.h"

@interface DMApiClient : AFHTTPClient

/**
 *  返回调用接口的单例
 *
 *  @return DMApiClient
 */
+ (instancetype)shareDMApiClient;

@end
