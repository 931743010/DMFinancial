//
//  DMGlobalVar.m
//  DamaiHD
//
//  Created by lixiang on 13-10-15.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMGlobalVar.h"

static NSString * const kCurrentCity        = @"CurrentCity";
static NSString * const kWeather            = @"kWeather";
static NSString * const kChooseCategoryArray            = @"kChooseCategoryArray";

static NSString * const kCurrentCategory    = @"CurrentCategory";
static NSString * const kDeviceToken        = @"DeviceToken";
static NSString * const KCurrentUser        = @"CurrentUser";
static NSString * const kLaunchImageName    = @"LaunchImageName";
static NSString * const kHasUsedApp         = @"hasUsedApp";
static NSString * const kHasUsedIDFA     = @"hasUsedIDFA";
static NSString * const kHasUsedMaiTian     = @"hasUsedMaiTian";
static NSString * const kLastAppVersion     = @"lastAppVersion";
static NSString * const kOpenActivityPush           = @"kOpenActivityPush";
static NSString * const kOpenSponsorPush           = @"kOpenSponsorPush";
static NSString * const kOpenStarPush           = @"kOpenStarPush";
static NSString * const kOpenVenuePush           = @"kOpenVenuePush";
static NSString * const kAddToSystemCalendar    = @"kAddToSystemCalendar";

static NSString * const kPrivilegeNumDic    = @"kPrivilegeNumDic";
static NSString * const kSupportTopicDic    = @"supportTopicDic";
static NSString * const kIsLoadedIndexPage  = @"isLoadedIndexPage";
static NSString * const kIsLoadedClubindex  = @"isLoadedClubindex";

@implementation DMGlobalVar

@synthesize deviceToken         = _deviceToken;
@synthesize launchImageName     = _launchImageName;
@synthesize hasUsedApp          = _hasUsedApp;
@synthesize userLoginInfo             = _userLoginInfo;


@synthesize isLoadedIndexPage   = _isLoadedIndexPage;

+ (instancetype)shareGlobalVar {
    static DMGlobalVar *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self configWithDefaults];
    }
    return self;
}

- (void)configWithDefaults {

}

-(DMUserLoginInfo *)userLoginInfo {
    _userLoginInfo = (DMUserLoginInfo *)[CommonHelper objectForKey:@"kUserLoginInfo"];
    return _userLoginInfo;
}

-(void)setUserLoginInfo:(DMUserLoginInfo *)userLoginInfo {
    _userLoginInfo = userLoginInfo;
    [CommonHelper setObject:_userLoginInfo forKey:@"kUserLoginInfo"];
}

- (NSString *)deviceToken {
    _deviceToken = (NSString *)[CommonHelper objectForKey:kDeviceToken];
    return _deviceToken;
}

- (void)setDeviceToken:(NSString *)deviceToken {
    if (deviceToken != _deviceToken) {
        _deviceToken = deviceToken;
    }
    [CommonHelper setObject:deviceToken forKey:kDeviceToken];
}



+ (BOOL)userLoginState{
//    DMUserLoginInfo *user = [DMGlobalVar shareGlobalVar].userLoginInfo;
//    if(user.login_m != nil && user.login_m.length > 0){
//        return YES;
//    }
    return NO;
}

- (void)setLaunchImageName:(NSString *)launchImageName {
    if (launchImageName != _launchImageName) {
        _launchImageName = launchImageName;
    }
    [CommonHelper setObject:launchImageName forKey:kLaunchImageName];
}

- (NSString *)launchImageName {
    _launchImageName = (NSString *)[CommonHelper objectForKey:kLaunchImageName];
    return _launchImageName;
}


- (void)setHasUsedApp:(BOOL)hasUsedApp {
    _hasUsedApp = hasUsedApp;
    [CommonHelper setValue:[NSNumber numberWithBool:hasUsedApp] forKey:kHasUsedApp];
}

- (BOOL)isHasUsedApp {
    _hasUsedApp = [[CommonHelper valueForKey:kHasUsedApp] boolValue];
    return _hasUsedApp;
}


@end
