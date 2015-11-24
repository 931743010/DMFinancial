//
//  DMAppInfo.h
//  DMCommonService
//
//  Created by lixiang on 14-1-10.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMAppInfo : NSObject

@property (nonatomic, strong) NSString *appUpdateTime;
@property (nonatomic, strong) NSString *phoneNumber;
/**
 *  被叫号
 */
@property (nonatomic, strong) NSString *callNumber;
/**
 *  友盟Appkey
 */
@property (nonatomic, strong) NSString *uMengAppKey;
/**
 *  友盟渠道号
 */
@property (nonatomic, strong) NSString *uMengChannel;

+ (DMAppInfo *)shareAppInfo;

@end
