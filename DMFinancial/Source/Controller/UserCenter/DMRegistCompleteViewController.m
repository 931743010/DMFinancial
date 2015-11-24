//
//  DMRegistCompleteViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/9.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMRegistCompleteViewController.h"

@interface DMRegistCompleteViewController () {
    DMTextField *_phoneTextField;
    DMButton *_loginButton;
}

@end

@implementation DMRegistCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self createSubViews];
}


#pragma mark -------界面布局---------
/**
 *  创建子视图
 */
-(void)createSubViews {
    //标题
    
    UIImageView *_imageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.center = CGPointMake(kScreenWidth/2, 190/2);
    [self.view addSubview:_imageView];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTOSIZE(50), _imageView.bottom + 20, kScreenWidth - AUTOSIZE(100), AUTOSIZE(60))];
    messageLabel.text = @"恭喜您注册成功，系统已赠送您 50积分作为奖励";
    messageLabel.font = FONT(18);
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = kDMDefaultBlackStringColor;
    [self.view addSubview:messageLabel];
    
    //完成注册按钮
    _loginButton = [[DMButton alloc] initWithFrame:CGRectMake(AUTOSIZE(80), messageLabel.bottom + 20, self.view.width - AUTOSIZE(160), 40)];
    [_loginButton.titleLabel setFont:FONT(21)];
    _loginButton.layer.cornerRadius = 20;
    _loginButton.layer.borderColor = kDMPinkColor.CGColor;
    _loginButton.layer.borderWidth = 0.5;
    
    [_loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:kDMPinkColor forState:UIControlStateNormal];
    [_loginButton buttonClickedcompletion:^(id returnData) {
        [self registButonAction];
    }];
    [self.view addSubview:_loginButton];
    
}

-(void)registButonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
