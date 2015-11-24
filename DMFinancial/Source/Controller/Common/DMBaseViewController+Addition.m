//
//  DMBaseViewController+Addition.m
//  DamaiIphone
//
//  Created by lixiang on 13-12-27.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMBaseViewController+Addition.h"
#import "DMLoginViewController.h"



@implementation DMBaseViewController (Addition)

//登录统一入口
- (void)userLoginWithDelegate:(UIViewController *)target
                      success:(void (^)(id returnData))success
                         fail:(void (^)(NSError *error))fail
{
    DMLoginViewController *loginCtrl = [[DMLoginViewController alloc]init];
    loginCtrl.success  =success;
    loginCtrl.fail = fail;
    UINavigationController *naviCtrl = [[UINavigationController alloc] initWithRootViewController:loginCtrl];
    [self.rootController presentViewController:naviCtrl animated:YES completion:^{}];
}

@end