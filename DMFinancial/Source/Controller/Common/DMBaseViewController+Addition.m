//
//  DMBaseViewController+Addition.m
//  DamaiIphone
//
//  Created by lixiang on 13-12-27.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMBaseViewController+Addition.h"
#import "DMUserLoginViewController.h"
#import "DMWebViewController.h"



@implementation DMBaseViewController (Addition)

//登录统一入口
- (void)userLoginWithDelegate:(UIViewController *)target
                      success:(void (^)(id returnData))success
                         fail:(void (^)(NSError *error))fail
{
    DMUserLoginViewController *loginCtrl = [[DMUserLoginViewController alloc]init];
    loginCtrl.success  =success;
    loginCtrl.fail = fail;
    UINavigationController *naviCtrl = [[UINavigationController alloc] initWithRootViewController:loginCtrl];
    [self.rootController presentViewController:naviCtrl animated:YES completion:^{}];
}

- (void)pushWithSubjectType:(DMSubjectType)type params:(NSDictionary *)params {
    switch (type) {
        case DMSubjectCommon:
        {
            
        }
            break;
        case DMSubjectWeb:
        {
            NSString *httpURL = params[@"url"];
            DMWebViewController *ctl = [[DMWebViewController alloc] init];
            ctl.httpUrl = httpURL;
            ctl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ctl
                                                 animated:YES];
        }
            break;
                default:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
    }

}

@end