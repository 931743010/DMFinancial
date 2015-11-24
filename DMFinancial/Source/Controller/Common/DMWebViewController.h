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
@property (nonatomic, assign) BOOL externalNet;
@property (nonatomic, assign) BOOL hiddenToolBar;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSDictionary *objectDic;

@end
