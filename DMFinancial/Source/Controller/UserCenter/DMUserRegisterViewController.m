//
//  DMUserRegisterViewController.m
//  DamaiPlayPhone
//
//  Created by 陈彦岐 on 15/4/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMUserRegisterViewController.h"
#import "DMUserLoginService.h"
#import "DMLoginTextField.h"

#define kGenderSheet 0x1001
#define kCameraSheet 0x1002

@interface DMUserRegisterViewController (){
    DMButton *_registerButton;//注册按钮
    DMButton *_getCodeButton;//获取验证码按钮
    DMLoginTextField *_textField;
    UILabel *_messageLable;
    
}

@property (nonatomic, assign) NSInteger step;
@end

@implementation DMUserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubViews];
    self.step = 1;

    if (!_fromLogin) {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Login_close.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];

    }
}

-(void)setStep:(NSInteger)step {
    _step = step;
    if (step == 1) {
        self.title = @"注册1/3";

        _messageLable.hidden = YES;
        _getCodeButton.hidden = YES;

        _textField.frame = CGRectMake(40, 20, self.view.width - 80, 44);
        _textField.title = @"输入手机号:";
        _textField.textField.placeholder = @"请输入您的手机号";
        _registerButton.frame = CGRectMake(40, _textField.bottom + 26, self.view.width - 80, 40);
        [_registerButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else if (step == 2) {
        self.title = @"注册2/3";

        _messageLable.hidden = NO;
        _getCodeButton.hidden = NO;
        _messageLable.frame = CGRectMake(40, 35, kScreenWidth - 80, 24);
        
        _textField.frame = CGRectMake(40, _messageLable.bottom + 15, self.view.width - 80, 44);
        _textField.title = @"输入验证码:";
        _textField.textField.placeholder = @"请输入短信中的验证码";
        _registerButton.frame = CGRectMake(40, _textField.bottom + 26, self.view.width - 80, 40);
        [_registerButton setTitle:@"提交验证码" forState:UIControlStateNormal];
        
        _getCodeButton.frame = CGRectMake(_textField.width - 30, 0, 30, _registerButton.height);

    } else if (step == 3) {
        self.title = @"注册3/3";

        _messageLable.hidden = YES;
        _getCodeButton.hidden = YES;
        
        _textField.frame = CGRectMake(40, 20, self.view.width - 80, 44);
        _textField.title = @"设置密码:";
        _textField.textField.placeholder = @"请输入密码";
        _registerButton.frame = CGRectMake(40, _textField.bottom + 26, self.view.width - 80, 40);
        [_registerButton setTitle:@"确定" forState:UIControlStateNormal];
    } else {
    
    }
}
#pragma mark -----------界面布局-----------

- (void)createSubViews {
    _textField = [[DMLoginTextField alloc] initWithFrame:CGRectMake(40, 20, self.view.width - 80, 44)];
    _textField.title = @"输入手机号:";
    _textField.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_textField];

    __weak typeof(&*self) weakSelf = self;
    
    //登录按钮
    _registerButton = [[DMButton alloc] initWithFrame:CGRectMake(40, _textField.bottom + 14, self.view.width - 80, 40)];
    [_registerButton.titleLabel setFont:BOLDFONT(17)];
    _registerButton.layer.cornerRadius = 3;
    _registerButton.clipsToBounds = YES;
    
    UIImage *normalImage = [UIImage imageWithColor:kDMPinkColor size:_registerButton.frame.size];
    UIImage *selectImage = [UIImage imageWithBaseImage:normalImage superposedImage:[UIImage imageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.1] size:_registerButton.frame.size]];
    [_registerButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [_registerButton setBackgroundImage:selectImage forState:UIControlStateHighlighted];
    
    [_registerButton buttonClickedcompletion:^(id returnData) {
        [weakSelf registerButonAction];
    }];
    [self.view addSubview:_registerButton];

    //获取验证码
    _getCodeButton = [[DMButton alloc] initWithFrame:CGRectMake(0, 0, 80, AUTOSIZE(44))];
    [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeButton.titleLabel setFont:FONT(14)];
    [_getCodeButton setTitleColor:kDMPinkColor forState:UIControlStateNormal];
    [_getCodeButton buttonClickedcompletion:^(id returnData) {
        [weakSelf getCodeAction];
    }];
    [_getCodeButton drawSolidLineWithFrame:CGRectMake(0, (_getCodeButton.height - 16)/2, 0.5, 16)];
    [_textField addSubview:_getCodeButton];
    
    _messageLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _messageLable.textColor = kDMDefaultGrayStringColor;
    _messageLable.font = FONT(13);
    [self.view addSubview:_messageLable];
}

#pragma mark -----------点击事件-----------

-(void)registerButonAction {
    
    
    if (self.step == 1) {
        [self getCodeAction];
    } else if (self.step == 2) {
        [self sendCode];
    } else if (self.step == 3) {
        [self sendRegister];
    }
}

- (void)backAction {
    [self.view endEditing:NO];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}

//获取验证码
- (void)getCodeAction {
    NSString *mobile = _textField.textField.text;
    if (mobile.length == 0) {
        [self showAlertViewWithText:@"请输入手机号!"];
        return;
    }
    self.step = 2;
    _messageLable.text = [NSString stringWithFormat:@"验证码短信已发送至%@",_textField.textField.text];
    _textField.textField.text = @"";

//    [self requestVerificationCode];
}

//提交验证码
-(void)sendCode {
    NSString *mobile = _textField.textField.text;
    if (mobile.length == 0) {
        [self showAlertViewWithText:@"请输入验证码!"];
        return;
    }
    self.step = 3;
    _textField.textField.text = @"";
    _textField.textField.keyboardType = UIKeyboardTypeDefault;

//    [self requestVerificationCode];

}

//注册
-(void)sendRegister {
    NSString *mobile = _textField.textField.text;
    if (mobile.length == 0) {
        [self showAlertViewWithText:@"请输入密码!"];
        return;
    }
    [self requestRegister];
    
}

#pragma mark -----------request-----------

-(void)requestRegister {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:_textField.textField.text forKey:@"phone"];

    [self showLoadingViewWithText:kLoadingText];
    [DMUserLoginService serviceUserRegisterWithParameters:params success:^(id returnData) {
        
        // 统计用户注册
        [self hideLoadingView];
        [self registerDataRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];

}

-(void)requestVerificationCode {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:_textField.textField.text forKey:@"phone"];

    [self showLoadingViewWithText:kLoadingText];
    [DMUserLoginService serviceUserRegbycodeWithParameters:params success:^(id returnData) {
        [self hideLoadingView];
        [self verificationCodeDataRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
}

-(void)registerDataRequestSuccess:(id)returnData {
    [self requestLogin];
}
-(void)requestLogin {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMUserLoginService serviceUserLoginWithParameters:params success:^(id returnData) {
        
        [self hideLoadingView];
        [self loginDataRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
    
}
-(void)loginDataRequestSuccess:(id)returnData {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
    self.success(@"success");
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}

-(void)verificationCodeDataRequestSuccess:(id)returnData {
    [_getCodeButton setEnabled:NO];

    __block int timeout=60; //倒计时时间
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
            NSString *strTime = [NSString stringWithFormat:@"%ds",timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getCodeButton setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);

//    [_codeView beginVerificationCodeCountdown];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:NO];
    return  YES;
}
@end
