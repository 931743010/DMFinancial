//
//  DMBaseViewController.h
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLProgressHUD.h"

typedef void(^TapBlock)();
/**
 *  所有控制器类的父类
 */
@interface DMBaseViewController : UIViewController
{

}


@property (nonatomic, weak) CLProgressHUD *hud;
@property (nonatomic, copy) TapBlock block;
@property (nonatomic, readonly, weak) UIViewController *rootController;
@property (nonatomic, assign) BOOL hideBackButton;

- (void)addTouchBackroundWithBlock:(TapBlock)block;
- (void)addTouchBackroundBelowView:(UIView *)view withBlock:(TapBlock)block;
/**
 *  友盟统计需要的界面名称
 *
 *  @return
 */
- (NSString *)descForUmeng;
- (void)showLoadingViewWithText:(NSString *)text;
- (void)hideLoadingView;


/**
 *  显示错误提示框
 *
 *  @param text 错误信息
 */
- (void)showErrorViewWithText:(NSString *)text;

/**
 *  显示提示信息
 *
 *  @param text 信息
 */
- (void)showAlertViewWithText:(NSString *)text;
/**
 *  显示提示信息
 *
 *  @param text 信息
 */
- (void)showAlertViewWithText:(NSString *)text duration:(NSTimeInterval)duration;

@end
