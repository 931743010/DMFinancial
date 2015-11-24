//
//  DMRegistViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/9.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMRegistViewController.h"
#import "DMTextField.h"
#import "DMRegistPwdViewController.h"
#import "DMLoginService.h"

@interface DMRegistViewController () {
    UIImageView *_imageView;
    UITextField *_phoneTextField;
    UITextField *_passwordTextField;
    DMButton *_loginButton;
    DMButton *_registButton;
    DMButton *_getCodeButton;
    BOOL _agreedRules;
}

@end

@implementation DMRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    _agreedRules = NO;
    [self createSubViews];
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
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTOSIZE(50), 0, kScreenWidth, AUTOSIZE(60))];
    messageLabel.text = @"为了更好的给您服务,请验证手机";
    messageLabel.font = FONT(18);
    messageLabel.textColor = kDMDefaultBlackStringColor;
    [self.view addSubview:messageLabel];
    
    _phoneTextField = [[DMTextField alloc]initWithFrame:CGRectMake(AUTOSIZE(50), messageLabel.bottom, AUTOSIZE(185), AUTOSIZE(44))];
    _phoneTextField.placeholder =@"请输入手机号";
    _phoneTextField.font = FONT(18);
    _phoneTextField.layer.cornerRadius = 5;
    _phoneTextField.layer.borderColor = kDMPinkColor.CGColor;
    _phoneTextField.layer.borderWidth = 0.5;
    _phoneTextField.textColor = kDMDefaultBlackStringColor;
    _phoneTextField.returnKeyType = UIReturnKeyDone;
    _phoneTextField.keyboardType = UIKeyboardTypeEmailAddress;
    //[_phoneConment becomeFirstResponder];
    [self.view addSubview:_phoneTextField];
    
    //获取验证码
    _getCodeButton = [[DMButton alloc] initWithFrame:CGRectMake(_phoneTextField.right + 10, _phoneTextField.top, AUTOSIZE(107), AUTOSIZE(44))];
    [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getCodeButton.backgroundColor = kDMDefaultBlackStringColor;
    _getCodeButton.layer.cornerRadius = 5;

    [_getCodeButton.titleLabel setFont:FONT(18)];
    [_getCodeButton setTitleColor:kDMPinkColor forState:UIControlStateNormal];
    [_getCodeButton buttonClickedcompletion:^(id returnData) {
        [self getCodeButtonAction];
    }];
    [self.view addSubview:_getCodeButton];
    
    _passwordTextField = [[DMTextField alloc]initWithFrame:CGRectMake(AUTOSIZE(50), _phoneTextField.bottom + 20, self.view.width - AUTOSIZE(100), AUTOSIZE(45))];
    _passwordTextField.placeholder =@"请输入验证码";
    _passwordTextField.font = FONT(18);
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.layer.cornerRadius = 5;
    _passwordTextField.layer.borderColor = kDMPinkColor.CGColor;
    _passwordTextField.layer.borderWidth = 0.5;
    _passwordTextField.textColor = kDMDefaultBlackStringColor;
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    _passwordTextField.keyboardType = UIKeyboardTypeEmailAddress;
    //[_phoneConment becomeFirstResponder];
    [self.view addSubview:_passwordTextField];
    [_passwordTextField drawSolidLineWithFrame:CGRectMake(0, _passwordTextField.height - 0.5, _passwordTextField.width, 0.5)];
    
    //服务条款
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(AUTOSIZE(56), _passwordTextField.bottom + AUTOSIZE(20), 23, 23)];
    _imageView.image = [UIImage imageWithResourcesPathCompontent:@""];
    _imageView.backgroundColor = kDMDefaultBlackStringColor;
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(imageAction)];
    [_imageView addGestureRecognizer:tap];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.right + 14, _imageView.top, 40, _imageView.height)];
    label1.text = @"同意";
    label1.font = FONT(15);
    label1.textColor = kDMDefaultBlackStringColor;
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.right + 2, _imageView.top, 100, _imageView.height)];
    label2.text = @" 服务条款";
    label2.font = FONT(15);
    label2.textColor = kDMPinkColor;
    label2.userInteractionEnabled = YES;
    [self.view addSubview:label2];

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(rulesAction)];
    [label2 addGestureRecognizer:tap1];
    //登录按钮
    _loginButton = [[DMButton alloc] initWithFrame:CGRectMake(AUTOSIZE(80), _imageView.bottom + 20, self.view.width - AUTOSIZE(160), 40)];
    [_loginButton.titleLabel setFont:FONT(21)];
    _loginButton.layer.cornerRadius = 20;
    _loginButton.layer.borderColor = kDMPinkColor.CGColor;
    _loginButton.layer.borderWidth = 0.5;

    [_loginButton setTitle:@"提交" forState:UIControlStateNormal];
    [_loginButton setTitleColor:kDMPinkColor forState:UIControlStateNormal];
    [_loginButton buttonClickedcompletion:^(id returnData) {
        [self registButonAction];
    }];
    [self.view addSubview:_loginButton];
    
}

#pragma mark ---------------request----------------

- (void)requsetCode {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"getcode" forKey:@"action"];
    [params setSafetyObject:_phoneTextField.text forKey:@"phone_num"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMLoginService userRegisterWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self dataUserRegisterSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
}

- (void)requsetSendCode {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"sendcode" forKey:@"action"];
    [params setSafetyObject:_phoneTextField.text forKey:@"phone_num"];
    [params setSafetyObject:_passwordTextField.text forKey:@"code"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMLoginService userRegisterWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        NSString *token = @"";
        NSDictionary *dic = (NSDictionary *)returnData;
        if ([dic isKindOfClass:[NSDictionary class]]) {
            token = dic[@"data"][@"token"];
        }
        //跳转到输入密码页面
        DMRegistPwdViewController *controller = [[DMRegistPwdViewController alloc] init];
        controller.success = self.success;
        controller.fail = self.fail;
        controller.token = token?token:@"";
        [self.navigationController pushViewController:controller animated:YES];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
}

#pragma mark ----------requestSuccess--------------

- (void)dataUserRegisterSuccess:(id)returnData {
    NSDictionary *dic = (NSDictionary *)returnData;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        NSInteger acttime = [dic[@"data"][@"acttime"] integerValue];
        [self beginCountdown:acttime];
    }
}

#pragma mark ----------action--------------

- (void)getCodeButtonAction {
    if ([DMHelper removeSpace:_phoneTextField.text].length == 0) {
        [self showAlertViewWithText:@"请输入手机号!"];
        return;
    }
    [self requsetCode];
}

-(void)rulesAction {

}

-(void)imageAction {
    _agreedRules = !_agreedRules;
    if (_agreedRules) {
        _imageView.backgroundColor = [UIColor redColor];
    } else {
        _imageView.backgroundColor = kDMDefaultBlackStringColor;
    }
}

-(void)registButonAction {
    if ([DMHelper removeSpace:_phoneTextField.text].length == 0) {
        [self showAlertViewWithText:@"请输入手机号!"];
        return;
    }

    if ([DMHelper removeSpace:_passwordTextField.text].length == 0) {
        [self showAlertViewWithText:@"请输入验证码!"];
        return;
    }

    [self requsetSendCode];
}


#pragma mark -------------private methods --------------

- (void)beginCountdown:(NSInteger)time {
    
    [_getCodeButton setEnabled:NO];
    
    __block NSInteger timeout = time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getCodeButton setEnabled:YES];
                [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                
            });
        }else{
            NSString *strTime = [NSString stringWithFormat:@"%@s",@(timeout)];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getCodeButton setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

@end
