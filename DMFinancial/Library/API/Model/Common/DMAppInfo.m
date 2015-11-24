//
//  DMAppInfo.m
//  DMCommonService
//
//  Created by lixiang on 14-1-10.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMAppInfo.h"

@implementation DMAppInfo

+ (DMAppInfo *)shareAppInfo {
    
    static DMAppInfo *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DMAppInfo alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AppInfo" ofType:@"plist"];
        NSDictionary *appInfoDic = [[NSDictionary alloc] initWithContentsOfFile:path];
        _appUpdateTime = appInfoDic[@"AppUpdateTime"];
        _phoneNumber = appInfoDic[@"iOS_PhoneNum"];
        _callNumber = appInfoDic[@"iOS_CallNum"];
        _uMengAppKey = appInfoDic[@"uMengAppKey"];
        _uMengChannel = appInfoDic[@"uMengChannel"];
    }
    return self;
}

@end
