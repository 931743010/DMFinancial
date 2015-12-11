//
//  DMUserRegisterViewController.m
//  DamaiPlayPhone
//
//  Created by 陈彦岐 on 15/4/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMUserRegisterViewController.h"
#import "DMUserLoginService.h"
#define kGenderSheet 0x1001
#define kCameraSheet 0x1002

@interface DMUserRegisterViewController () <UITextFieldDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIView *_bgView;
    DMButton *_registerButton;//注册按钮
    UILabel *_remindLabel;//提示
    
    UIImageView *_headImageView;//头像
    UITextField *_niceNameTextField;//昵称
    UITextField *_phoneTextField;//手机号
    UITextField *_codeTextField;//验证码;
    UITextField *_passwordTextField;//密码

    DMButton *_manIcon;//男性图标
    DMButton *_womanIcon;//女性图标
    NSUInteger _sex;//性别 1:男 2:女
    
    DMButton *_getCodeButton;//获取验证码按钮
    DMButton *_showPwButton;//明文显示密码
    BOOL _showPw;//是否显示明文密码
    NSInteger _currentSelectedTextFieldTag;
    BOOL _hasSetHeadImageView;//是否已经选择头像
    NSString *_headImageUrl;//头像url
}

@end

@implementation DMUserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    _sex = 1;
    _hasSetHeadImageView = NO;
    //点击空白地方隐藏键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self createSubViews];
    
    if (!_fromLogin) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Login_close.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];

    }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(webLoginNotification:)
//                                                 name:@"DMUserLoginWebViewController"
//                                               object:nil];
}

//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
//}
//
//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
//        self.edgesForExtendedLayout = UIRectEdgeAll;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -----------界面布局-----------

- (void)createSubViews {
    
    __weak typeof(&*self) weakSelf = self;
    
    _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_bgView];
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width - 80)/2, AUTOSIZE(10), AUTOSIZE(80), AUTOSIZE(80))];
    _headImageView.image = [UIImage imageNamed:@"login_yonghu_boy.png"];
    _headImageView.layer.cornerRadius = AUTOSIZE(40);
    _headImageView.clipsToBounds = YES;
    _headImageView.userInteractionEnabled = YES;
    [_bgView addSubview:_headImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(headImageViewAction)];
    [_headImageView addGestureRecognizer:tap];
    //昵称
    _niceNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(32, AUTOSIZE(100), self.view.width - 62 - 90, AUTOSIZE(44))];
    _niceNameTextField.placeholder =@"昵    称";
    _niceNameTextField.font = FONT(14);
    _niceNameTextField.tag = 1;
    _niceNameTextField.textColor = kDMDefaultBlackStringColor;
    _niceNameTextField.returnKeyType = UIReturnKeyDone;
    _niceNameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    _niceNameTextField.delegate = self;
    [_bgView addSubview:_niceNameTextField];
    [_niceNameTextField drawSolidLineWithFrame:CGRectMake(0, _niceNameTextField.height - 0.5, _niceNameTextField.width + 90, 0.5)];

    //性别
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"hiddenSomeThings"]) {
        UIView *sexView = [[UIView alloc] initWithFrame:CGRectMake(_niceNameTextField.right + 10, _niceNameTextField.top, 80, AUTOSIZE(44))];
        [_bgView addSubview:sexView];
        
        _manIcon = [[DMButton alloc] initWithFrame:CGRectMake(0, 0, 40, AUTOSIZE(44))];
        [_manIcon setImage:[UIImage imageNamed:@"login_male.png"] forState:UIControlStateNormal];
        [_manIcon setImage:[UIImage imageNamed:@"login_male.png"] forState:UIControlStateHighlighted];
        
        _manIcon.tag = 1;
        [_manIcon buttonClickedcompletion:^(id returnData) {
            [weakSelf chooseSex:returnData];
        }];
        [sexView addSubview:_manIcon];
        
        _womanIcon = [[DMButton alloc] initWithFrame:CGRectMake(40, 0, 40, AUTOSIZE(44))];
        [_womanIcon setImage:[UIImage imageNamed:@"login_female_gary.png"] forState:UIControlStateNormal];
        [_womanIcon setImage:[UIImage imageNamed:@"login_female_gary.png"] forState:UIControlStateHighlighted];
        _womanIcon.tag = 2;
        [_womanIcon buttonClickedcompletion:^(id returnData) {
            [weakSelf chooseSex:returnData];
        }];
        [sexView addSubview:_womanIcon];
        
        [sexView drawSolidLineWithFrame:CGRectMake(40, (sexView.height - 16)/2, 0.5, 16)];    } else {
        }
    
    
    //手机号
    _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(32, _niceNameTextField.bottom, self.view.width - 62, AUTOSIZE(44))];
    _phoneTextField.placeholder =@"手机号";
    _phoneTextField.font = FONT(14);
    _phoneTextField.tag = 2;
    _phoneTextField.textColor = kDMDefaultBlackStringColor;
    _phoneTextField.returnKeyType = UIReturnKeyDone;
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextField.delegate = self;
    [_bgView addSubview:_phoneTextField];
    [_phoneTextField drawSolidLineWithFrame:CGRectMake(0, _phoneTextField.height - 0.5, _phoneTextField.width, 0.5)];
    
    //验证码
    _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(32, _phoneTextField.bottom, self.view.width - 62 - 80, AUTOSIZE(44))];
    _codeTextField.placeholder =@"验证码";
    _codeTextField.font = FONT(14);
    _codeTextField.tag = 3;
    _codeTextField.textColor = kDMDefaultBlackStringColor;
    _codeTextField.returnKeyType = UIReturnKeyDone;
    _codeTextField.keyboardType = UIKeyboardTypePhonePad;
    _codeTextField.delegate = self;
    [_bgView addSubview:_codeTextField];
    
    UIView *getCodeView = [[UIView alloc] initWithFrame:CGRectMake(_codeTextField.right, _codeTextField.top, 80, AUTOSIZE(44))];
    [_bgView addSubview:getCodeView];
    //获取验证码
    _getCodeButton = [[DMButton alloc] initWithFrame:CGRectMake(0, 0, 80, AUTOSIZE(44))];
    [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeButton.titleLabel setFont:FONT(14)];
    [_getCodeButton setTitleColor:kDMPinkColor forState:UIControlStateNormal];
    [_getCodeButton buttonClickedcompletion:^(id returnData) {
        [weakSelf getCodeAction];
    }];
    [_getCodeButton drawSolidLineWithFrame:CGRectMake(0, (_getCodeButton.height - 16)/2, 0.5, 16)];
    [getCodeView addSubview:_getCodeButton];

    [_bgView drawSolidLineWithFrame:CGRectMake(_codeTextField.left, _codeTextField.bottom - 0.5, _codeTextField.width + 80, 0.5)];
    //密码
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(32, _codeTextField.bottom, self.view.width - 62 - 41, AUTOSIZE(44))];
    _passwordTextField.placeholder =@"密    码";
    _passwordTextField.font = FONT(14);
    _passwordTextField.tag = 4;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.textColor = kDMDefaultBlackStringColor;
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _passwordTextField.delegate = self;
    [_bgView addSubview:_passwordTextField];
    [_bgView drawSolidLineWithFrame:CGRectMake(_passwordTextField.left, _passwordTextField.bottom - 0.5, _passwordTextField.width + 41, 0.5)];
    //明文显示密码
    _showPw = NO;
    _showPwButton = [[DMButton alloc] initWithFrame:CGRectMake(_passwordTextField.right, _passwordTextField.top, 41, AUTOSIZE(44))];
    [_showPwButton setImage:[UIImage imageNamed:@"login_mima_gary.png"] forState:UIControlStateNormal];
    [_showPwButton setImage:[UIImage imageNamed:@"login_mima_gary.png"] forState:UIControlStateHighlighted];
    [_showPwButton buttonClickedcompletion:^(id returnData) {
        _showPw = !_showPw;
        _passwordTextField.secureTextEntry = !_showPw;

        if (_showPw) {
            [_showPwButton setImage:[UIImage imageNamed:@"login_mima_green.png"] forState:UIControlStateNormal];
            [_showPwButton setImage:[UIImage imageNamed:@"login_mima_green.png"] forState:UIControlStateHighlighted];
        } else {
            [_showPwButton setImage:[UIImage imageNamed:@"login_mima_gary.png"] forState:UIControlStateNormal];
            [_showPwButton setImage:[UIImage imageNamed:@"login_mima_gary.png"] forState:UIControlStateHighlighted];

        }
    }];
    [_bgView addSubview:_showPwButton];

    //登录按钮
    _registerButton = [[DMButton alloc] initWithFrame:CGRectMake(32, _passwordTextField.bottom + AUTOSIZE(14), self.view.width - 64, 40)];
    [_registerButton.titleLabel setFont:BOLDFONT(17)];
    _registerButton.layer.cornerRadius = 20;
    _registerButton.clipsToBounds = YES;
    
    UIImage *normalImage = [UIImage imageWithColor:kDMPinkColor size:_registerButton.frame.size];
    UIImage *selectImage = [UIImage imageWithBaseImage:normalImage superposedImage:[UIImage imageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.1] size:_registerButton.frame.size]];
    [_registerButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [_registerButton setBackgroundImage:selectImage forState:UIControlStateHighlighted];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];

    [_registerButton buttonClickedcompletion:^(id returnData) {
        [weakSelf registerButonAction];
    }];
    [_bgView addSubview:_registerButton];
    
    _remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(32 + 16, _registerButton.bottom + AUTOSIZE(7), self.view.width, 40)];
    _remindLabel.text = @"大麦网账号可直接登录";
    _remindLabel.textColor = kDMDefaultGrayStringColor;
    _remindLabel.font = FONT(14);
    _remindLabel.textAlignment = NSTextAlignmentLeft;
    _remindLabel.backgroundColor = [UIColor clearColor];
    [_bgView addSubview:_remindLabel];

}

#pragma mark -----------点击事件-----------

- (void)backAction {
    [self.view endEditing:NO];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [self uploadAvatarWithImage:image];
    }];
}


- (void)uploadAvatarWithImage:(UIImage *)image
{
    [self showLoadingViewWithText:@"上传头像中..."];
    
}

- (void)headImageViewAction {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册选择", nil];
    actionSheet.tag = kCameraSheet;
    [actionSheet showFromBarButtonItem:self.navigationItem.leftBarButtonItem animated:YES];
}

- (void)getCodeAction {
    NSString *mobile = _phoneTextField.text;
    if (mobile.length == 0) {
        [self showAlertViewWithText:@"请输入手机号!"];
        return;
    }
    
    if (![mobile hasPrefix:@"1"] || mobile.length > 11) {
        [self showAlertViewWithText:@"请输入正确手机号!"];
        return;
    }
    
    [self requestVerificationCode];
}

- (void)chooseSex:(DMButton *)button {
    _sex = button.tag;
    if (_sex == 1) {
        if (!_hasSetHeadImageView) {
            _headImageView.image = [UIImage imageNamed:@"login_yonghu_boy.png"];
        }
        [_manIcon setImage:[UIImage imageNamed:@"login_male.png"] forState:UIControlStateNormal];
        [_manIcon setImage:[UIImage imageNamed:@"login_male.png"] forState:UIControlStateNormal];
        [_womanIcon setImage:[UIImage imageNamed:@"login_female_gary.png"] forState:UIControlStateNormal];
        [_womanIcon setImage:[UIImage imageNamed:@"login_female_gary.png"] forState:UIControlStateNormal];
    } else {
        if (!_hasSetHeadImageView) {
            _headImageView.image = [UIImage imageNamed:@"login_yonghu_girl.png"];
        }
        [_manIcon setImage:[UIImage imageNamed:@"login_male_gary.png"] forState:UIControlStateNormal];
        [_manIcon setImage:[UIImage imageNamed:@"login_male_gary.png"] forState:UIControlStateNormal];
        [_womanIcon setImage:[UIImage imageNamed:@"login_female.png"] forState:UIControlStateNormal];
        [_womanIcon setImage:[UIImage imageNamed:@"login_female.png"] forState:UIControlStateNormal];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:NO];
}

- (void)registerButonAction {
    if (_niceNameTextField.text.length == 0) {
        [self showAlertViewWithText:@"请输入昵称!"];
        return;
    }
    
    if (_niceNameTextField.text.length < 2 || _niceNameTextField.text.length > 16) {
        [self showAlertViewWithText:@"请输入2~16位昵称"];
        return;
    }
    
    if (_phoneTextField.text.length == 0) {
        [self showAlertViewWithText:@"请输入账号!"];
        return;
    }

    if (_codeTextField.text.length == 0) {
        [self showAlertViewWithText:@"请输入验证码!"];
        return;
    }
    if (_passwordTextField.text.length == 0) {
        [self showAlertViewWithText:@"请输入密码!"];
        return;
    }
    
    if (_passwordTextField.text.length < 6 || _passwordTextField.text.length > 16) {
        [self showAlertViewWithText:@"请输入6~16位密码"];
        return;
    }
    
    [self requestRegister];
    [self.view endEditing:NO];
}

#pragma mark -----------request-----------

-(void)requestRegister {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:_phoneTextField.text forKey:@"phone"];
    [params setSafetyObject:_passwordTextField.text forKey:@"passwd"];
    [params setSafetyObject:_niceNameTextField.text forKey:@"nickname"];
    [params setSafetyObject:_headImageUrl forKey:@"avatar"];
    [params setSafetyObject:_codeTextField.text forKey:@"code"];
    [params setSafetyObject:[NSNumber numberWithInteger:_sex] forKey:@"gender"];

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
    [params setSafetyObject:_phoneTextField.text forKey:@"phone"];

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
    [params setSafetyObject:_phoneTextField.text forKey:@"phone"];
    [params setSafetyObject:_passwordTextField.text forKey:@"passwd"];
    
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

#pragma mark - Actionsheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
    else if (buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
}


#pragma mark -----------------NSNotification-----------------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _currentSelectedTextFieldTag = textField.tag;
    if (kScreenHeight < 500) {
        if ( _currentSelectedTextFieldTag == 3) {
            _bgView.frame = CGRectMake(0, -100, self.view.width, self.view.height);
        } else if ( _currentSelectedTextFieldTag == 4) {
            _bgView.frame = CGRectMake(0, -100, self.view.width, self.view.height);
        } else {
            _bgView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        }
    }

    return YES;
}

#pragma mark -----------------NSNotification-----------------

- (void)keyboardWillShow:(NSNotification*)aNotification {
//    if (kScreenHeight < 500) {
//        if ( _currentSelectedTextFieldTag == 3) {
//            self.view.bounds = CGRectMake(0, 100, self.view.width, self.view.height);
//        } else if ( _currentSelectedTextFieldTag == 4) {
//            self.view.bounds = CGRectMake(0, 100, self.view.width, self.view.height);
//        } else {
//            self.view.bounds = CGRectMake(0, 0, self.view.width, self.view.height);
//        }
//    }
}

- (void)keyboardWillHide:(NSNotification*)aNotification {
    _bgView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}

@end
