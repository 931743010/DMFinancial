//
//  DMLoginViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/9.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMLoginViewController.h"
#import "DMTextField.h"
#import "DMRegistViewController.h"
#import "DMLoginService.h"

@interface DMLoginViewController () {
    UITextField *_phoneTextField;
    UITextField *_passwordTextField;
    DMButton *_loginButton;
    DMButton *_registButton;
}

@end

@implementation DMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self createSubViews];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------界面布局---------
/**
 *  创建子视图
 */
-(void)createSubViews {
    //标题
    
    _phoneTextField = [[DMTextField alloc]initWithFrame:CGRectMake(AUTOSIZE(50), AUTOSIZE(30), self.view.width - AUTOSIZE(100), AUTOSIZE(44))];
    _phoneTextField.placeholder =@"请输入手机号";
    _phoneTextField.font = FONT(21);
    _phoneTextField.layer.cornerRadius = 5;
    _phoneTextField.layer.borderColor = kDMPinkColor.CGColor;
    _phoneTextField.layer.borderWidth = 0.5;
    _phoneTextField.textColor = kDMDefaultBlackStringColor;
    _phoneTextField.returnKeyType = UIReturnKeyDone;
    _phoneTextField.keyboardType = UIKeyboardTypeEmailAddress;
    //[_phoneConment becomeFirstResponder];
    [self.view addSubview:_phoneTextField];
    
    
    _passwordTextField = [[DMTextField alloc]initWithFrame:CGRectMake(_phoneTextField.left, _phoneTextField.bottom + 20, _phoneTextField.width, _phoneTextField.height)];
    _passwordTextField.placeholder =@"请输入密码";
    _passwordTextField.font = FONT(21);
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.layer.cornerRadius = 5;
    _passwordTextField.layer.borderColor = kDMPinkColor.CGColor;
    _passwordTextField.layer.borderWidth = 0.5;
    _passwordTextField.textColor = kDMDefaultBlackStringColor;
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    _passwordTextField.keyboardType = UIKeyboardTypeEmailAddress;
    //[_phoneConment becomeFirstResponder];
    [self.view addSubview:_passwordTextField];
    
    //登录按钮
    _loginButton = [[DMButton alloc] initWithFrame:CGRectMake(AUTOSIZE(80), _passwordTextField.bottom + 20, self.view.width - AUTOSIZE(160), AUTOSIZE(44))];
    [_loginButton.titleLabel setFont:BOLDFONT(21)];
    _loginButton.layer.cornerRadius = AUTOSIZE(22);
    _loginButton.layer.borderColor = kDMPinkColor.CGColor;
    _loginButton.layer.borderWidth = 0.5;
    [_loginButton setTitleColor:kDMPinkColor forState:UIControlStateNormal];
    [_loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    [_loginButton buttonClickedcompletion:^(id returnData) {
        [self loginButonAction];
    }];
    [self.view addSubview:_loginButton];
    
    //注册按钮
    _registButton = [[DMButton alloc] initWithFrame:CGRectMake(AUTOSIZE(80), _loginButton.bottom + 20, self.view.width - AUTOSIZE(160), AUTOSIZE(44))];
    [_registButton.titleLabel setFont:BOLDFONT(21)];
    _registButton.layer.cornerRadius = AUTOSIZE(22);
    _registButton.layer.borderColor = kDMPinkColor.CGColor;
    _registButton.layer.borderWidth = 0.5;
    [_registButton setTitleColor:kDMPinkColor forState:UIControlStateNormal];
    [_registButton setTitle:@"注 册" forState:UIControlStateNormal];
    [_registButton buttonClickedcompletion:^(id returnData) {
        [self registButonAction];
    }];
    [self.view addSubview:_registButton];
}

#pragma mark ---------action-------

-(void)leftBarButtonAction {
    [self.view endEditing:NO];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}

-(void)loginButonAction {
    if ([DMHelper removeSpace:_phoneTextField.text].length == 0) {
        [self showAlertViewWithText:@"请输入手机号!"];
        return;
    }
    if ([DMHelper removeSpace:_passwordTextField.text].length == 0) {
        [self showAlertViewWithText:@"请输入密码!"];
        return;
    }
    [self requsetLogin];
}

-(void)registButonAction {
    DMRegistViewController *controller = [[DMRegistViewController alloc] init];
    controller.success = self.success;
    controller.fail = self.fail;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark ----------requset-------------

-(void)requsetLogin {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:_phoneTextField.text forKey:@"phone_num"];
    [params setSafetyObject:_passwordTextField.text forKey:@"pass"];

    [self showLoadingViewWithText:kLoadingText];
    [DMLoginService userLoginWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self dataRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];

}

-(void)dataRequestSuccess:(DMUserLoginInfo *)returnData {
    [DMGlobalVar shareGlobalVar].userLoginInfo = returnData;;
    [self dismissViewControllerAnimated:YES completion:nil];
    self.success(@"success");
}
@end
