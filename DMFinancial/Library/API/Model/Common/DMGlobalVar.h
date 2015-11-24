//
//  DMGlobalVar.h
//  DamaiHD
//
//  Created by lixiang on 13-10-15.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMObject.h"
#import "DMUserLoginInfo.h"

/**
 *  全局变量类
 */
@interface DMGlobalVar : NSObject

/**
 *    设置用户token,在切换城市与登录后使用
 */
@property (nonatomic, strong) NSString *deviceToken;
/**
 *  启动图片的名字
 */
@property (nonatomic, strong) NSString *launchImageName;
/**
 *  是否第一次使用软件
 */
@property (nonatomic, assign, getter = isHasUsedApp) BOOL      hasUsedApp;

/**
 *  是否加载过首页
 */
@property (nonatomic, assign) BOOL isLoadedIndexPage;

/**
 *  用户登录状态
 */
@property (nonatomic, strong) DMUserLoginInfo *userLoginInfo;

/**
 *  获取全局变量
 *
 *  @return 返回全局变量的单例
 */
+ (instancetype)shareGlobalVar;

/**
 *  返回用户的登录状态
 *
 *  @return 是否登录
 */
+ (BOOL)userLoginState;



@end
