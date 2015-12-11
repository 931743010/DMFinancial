//
//  DMWebViewController.h
//  DamaiIphone
//
//  Created by lixiang on 14-1-13.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMBaseViewController.h"

@interface DMWebViewController : DMBaseViewController

@property (nonatomic, strong) NSString *htmlStr;
@property (nonatomic, strong) NSString *httpUrl;
@property (nonatomic, assign) BOOL needLogin;
@property (nonatomic, assign) BOOL showShare;

//web页面的标题,如果为空就显示网页本身的标题
@property (nonatomic, strong) NSString *titleString;

//分享相关
@property (nonatomic, strong) NSDictionary *shareDic;

@end
