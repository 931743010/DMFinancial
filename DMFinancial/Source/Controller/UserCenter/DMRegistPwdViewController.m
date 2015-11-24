//
//  DMRegistPwdViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/9.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMRegistPwdViewController.h"
#import "DMRegistCompleteViewController.h"
#import "DMLoginService.h"

@interface DMRegistPwdViewController () {
    DMTextField *_phoneTextField;
    DMButton *_loginButton;
}

@end

@implementation DMRegistPwdViewController

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
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTOSIZE(50), 0, kScreenWidth - AUTOSIZE(100), AUTOSIZE(60))];
    messageLabel.text = @"设置密码";
    messageLabel.font = FONT(18);
    messageLabel.textColor = kDMDefaultBlackStringColor;
    [self.view addSubview:messageLabel];
    
    _phoneTextField = [[DMTextField alloc]initWithFrame:CGRectMake(AUTOSIZE(50), messageLabel.bottom, self.view.width - AUTOSIZE(100), AUTOSIZE(44))];
    _phoneTextField.placeholder =@"请输入密码";
    _phoneTextField.font = FONT(18);
    _phoneTextField.layer.cornerRadius = 5;
    _phoneTextField.layer.borderColor = kDMPinkColor.CGColor;
    _phoneTextField.layer.borderWidth = 0.5;
    _phoneTextField.textColor = kDMDefaultBlackStringColor;
    _phoneTextField.returnKeyType = UIReturnKeyDone;
    _phoneTextField.keyboardType = UIKeyboardTypeEmailAddress;
    //[_phoneConment becomeFirstResponder];
    [self.view addSubview:_phoneTextField];
    
    //完成注册按钮
    _loginButton = [[DMButton alloc] initWithFrame:CGRectMake(AUTOSIZE(80), _phoneTextField.bottom + 20, self.view.width - AUTOSIZE(160), 40)];
    [_loginButton.titleLabel setFont:FONT(21)];
    _loginButton.layer.cornerRadius = 20;
    _loginButton.layer.borderColor = kDMPinkColor.CGColor;
    _loginButton.layer.borderWidth = 0.5;
    
    [_loginButton setTitle:@"完成注册" forState:UIControlStateNormal];
    [_loginButton setTitleColor:kDMPinkColor forState:UIControlStateNormal];
    [_loginButton buttonClickedcompletion:^(id returnData) {
        [self registButonAction];
    }];
    [self.view addSubview:_loginButton];

}

-(void)registButonAction {
    
    if ([DMHelper removeSpace:_phoneTextField.text].length == 0) {
        [self showAlertViewWithText:@"请输入手机号!"];
        return;
    }
    [self requestSendPassWord];

}

- (void)requestSendPassWord {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"sendpwd" forKey:@"action"];
    [params setSafetyObject:_phoneTextField.text forKey:@"pass"];
    [params setSafetyObject:self.token forKey:@"token"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMLoginService userRegisterWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        
        DMRegistCompleteViewController *controller = [[DMRegistCompleteViewController alloc] init];
        controller.success = self.success;
        controller.fail = self.fail;
        [self.navigationController pushViewController:controller animated:YES];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];

}
@end
