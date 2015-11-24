//
//  DMBaseViewController.m
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMBaseViewController.h"
#import "AppDelegate.h"
#import "CLProgressHUD.h"
#import "DMAlertView.h"

#define kTouchBackgroundTag 200

@interface DMBaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation DMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = YES;
    }
    if (self.hideBackButton == NO) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icons_back_dark"]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(backButtonAction:)];
    }

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)backButtonAction:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    //收到内存警告时，清除内存中的image

    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)showLoadingViewWithText:(NSString *)text {
    [self hideLoadingView];
    self.hud.text = text;
    [self.hud showWithAnimation:YES];
}

- (void)hideLoadingView {
    [self.hud dismiss];
}

- (CLProgressHUD *)hud {
    if (_hud == nil) {
        CLProgressHUD *hud = [[CLProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        _hud = hud;
    }
    return _hud;
}

- (void)showAlertViewWithText:(NSString *)text {
    DMAlertView *hud = nil;
    hud = [[DMAlertView alloc] initWithView:self.view];
    [self.view addSubview:hud];
    [hud showText:text];
}

- (void)showAlertViewWithText:(NSString *)text duration:(NSTimeInterval)duration {
    DMAlertView *hud = nil;
    hud = [[DMAlertView alloc] initWithView:self.view];
    [self.view addSubview:hud];
    [hud showText:text duration:duration];
}

- (void)showErrorViewWithText:(NSString *)text {
    DMAlertView *hud = nil;
    hud = [[DMAlertView alloc] initWithView:self.view];
    [self.view addSubview:hud];
    [hud showText:text];
}

- (void)addTouchBackroundWithBlock:(TapBlock)block {
    self.block = block;
    
    UIView *touchBackground = [[UIView alloc] initWithFrame:self.view.bounds];
    touchBackground.backgroundColor = RGBA(0, 0, 0, 0.8);
    touchBackground.tag = kTouchBackgroundTag;
    touchBackground.alpha = 0.0f;
    [self.view bringSubviewToFront:self.view];
    [self.view insertSubview:touchBackground belowSubview:self.view];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(backgroundTapAction:)];
    [touchBackground addGestureRecognizer:tap];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         touchBackground.alpha = 1.0f;
                     }];
}

- (void)addTouchBackroundBelowView:(UIView *)view withBlock:(TapBlock)block {
    self.block = block;
    
    UIView *touchBackground = [[UIView alloc] initWithFrame:self.view.bounds];
    touchBackground.backgroundColor = RGBA(0, 0, 0, 0.5);
    touchBackground.tag = kTouchBackgroundTag;
    [self.view insertSubview:touchBackground belowSubview:view];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(backgroundTapAction:)];
    [touchBackground addGestureRecognizer:tap];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         touchBackground.alpha = 1.0f;
                     }];
}

- (void)backgroundTapAction:(UITapGestureRecognizer *)gestureRecognizer {
    _block();
    UIView *touchBackground = [self.view viewWithTag:kTouchBackgroundTag];
    [UIView animateWithDuration:0.3f animations:^{
        touchBackground.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [touchBackground removeFromSuperview];
    }];
}

- (NSString *)descForUmeng {
    return [[self class] description];
}

- (UIViewController *)rootController {
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).tabBarController;
}

@end
