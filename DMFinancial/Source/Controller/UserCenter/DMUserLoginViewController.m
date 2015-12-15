//
//  DMUserLoginViewController.m
//  DamaiPlayPhone
//
//  Created by 陈彦岐 on 14/12/24.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMUserLoginViewController.h"
#import "DMUserLoginService.h"
//#import "DMSinaWeiboShare.h"
//#import "DMWeChatShare.h"
//#import "DMTencentShare.h"
#import "DMUserLoginWebViewController.h"
#import "DMUserLoginInfo.h"
#import "UIImage+Blur.h"
#import "UIImageAdditions.h"

#import "DMLoginTextField.h"

#import "DMForgetPwdViewController.h"

#import "DMUserLoginParser.h"
#import "DMRequest.h"
#import "DMUserRegisterViewController.h"

@interface DMUserLoginViewController () {
    
    DMButton *_loginButton;//登录按钮
    DMButton *_registerButton;//注册按钮
    DMButton *_forgotPwdButton;//忘记密码按钮
    UILabel *_remindLabel;//提示
    
    DMLoginTextField *_phoneTextField;
    DMLoginTextField *_passwordTextField;
    UIView *_otherLoginTypeView;
}

@end

@implementation DMUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    //点击空白地方隐藏键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self createSubViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(webLoginNotification:)
                                                 name:@"DMUserLoginWebViewController"
                                               object:nil];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(activityButtonClicked)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}

#pragma mark -------界面布局---------
/**
 *  创建子视图
 */
-(void)createSubViews {
    //标题
    
    _phoneTextField = [[DMLoginTextField alloc]initWithFrame:CGRectMake(40, 20, self.view.width - 80, 44)];
    _phoneTextField.title = @"手机号:";
    //[_phoneConment becomeFirstResponder];
    [self.view addSubview:_phoneTextField];
    
    
    _passwordTextField = [[DMLoginTextField alloc]initWithFrame:CGRectMake(40, _phoneTextField.bottom + 20, self.view.width - 80, 44)];
    _passwordTextField.title = @"密码:";
    [self.view addSubview:_passwordTextField];
    [_passwordTextField drawSolidLineWithFrame:CGRectMake(0, _passwordTextField.height - 0.5, _passwordTextField.width, 0.5)];
    
    
    //忘记密码按钮
    _forgotPwdButton = [[DMButton alloc] initWithFrame:CGRectMake(self.view.width - 82 - 32, _passwordTextField.bottom, 82, 40)];
    [_forgotPwdButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgotPwdButton setTitleColor:kDMPinkColor forState:UIControlStateNormal];
    [_forgotPwdButton buttonClickedcompletion:^(id returnData) {
        [self gotoForgotPwdPage];
    }];
    [_forgotPwdButton.titleLabel setFont:FONT(13)];
    [self.view addSubview:_forgotPwdButton];

    //登录按钮
    _loginButton = [[DMButton alloc] initWithFrame:CGRectMake(40, _passwordTextField.bottom + 50, self.view.width - 80, 40)];
    [_loginButton.titleLabel setFont:BOLDFONT(17)];
    _loginButton.layer.cornerRadius = 3;
    _loginButton.clipsToBounds = YES;
    
    UIImage *normalImage = [UIImage imageWithColor:kDMPinkColor size:_loginButton.frame.size];
    UIImage *selectImage = [UIImage imageWithBaseImage:normalImage superposedImage:[UIImage imageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.1] size:_loginButton.frame.size]];
    [_loginButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:selectImage forState:UIControlStateHighlighted];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton buttonClickedcompletion:^(id returnData) {
        [self loginButonAction];
    }];
    [self.view addSubview:_loginButton];
    
    
    
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"hiddenSomeThings"]) {
//        [self createOtherLoginTypeView];
//    }
    
    [self createOtherLoginTypeView];

}

-(void)createOtherLoginTypeView {
//    int lineWidth = 184;
//    _otherLoginTypeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bottom - 132 - 64, self.view.width, 132)];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 15)];
//    label.text = @"其他方式登录";
//    label.font = FONT(14);
//    label.textColor = kDMDefaultGrayStringColor;
//    label.textAlignment = NSTextAlignmentCenter;
//    [_otherLoginTypeView addSubview:label];
//    
//    //白色的分割线
//    [_otherLoginTypeView drawSolidLineWithFrame:CGRectMake((self.view.width - lineWidth)/2, 30, 184, 1) color:kSeperatorColor];
//    
//    DMButton *sinaButton = [[DMButton alloc] initWithFrame:CGRectMake((self.view.width - lineWidth)/2, 52 + 1, 40, 33)];
//    [sinaButton setImage:[UIImage imageWithResourcesPathCompontent:@"weibo.png"] forState:UIControlStateNormal];
//    [sinaButton setImage:[UIImage imageWithResourcesPathCompontent:@"weibo.png"] forState:UIControlStateHighlighted];
//    [sinaButton buttonClickedcompletion:^(id returnData) {
//        [self otherLoginType:DMOtherLoginTypeSina];
//    }];
//    [_otherLoginTypeView addSubview:sinaButton];
//    
//    DMButton *wxButton = [[DMButton alloc] initWithFrame:CGRectMake(sinaButton.right + 23, 52 + 1, 40, 33)];
//    [wxButton setImage:[UIImage imageWithResourcesPathCompontent:@"weixin.png"] forState:UIControlStateNormal];
//    [wxButton setImage:[UIImage imageWithResourcesPathCompontent:@"weixin.png"] forState:UIControlStateHighlighted];
//    [wxButton buttonClickedcompletion:^(id returnData) {
//        [self otherLoginType:DMOtherLoginTypeWX];
//    }];
//    [_otherLoginTypeView addSubview:wxButton];
//    
//    DMButton *qqButton = [[DMButton alloc] initWithFrame:CGRectMake(wxButton.right + 23, 52 + 1, 40, 33)];
//    [qqButton setImage:[UIImage imageWithResourcesPathCompontent:@"Login_share_qq_normal.png"] forState:UIControlStateNormal];
//    [qqButton setImage:[UIImage imageWithResourcesPathCompontent:@"Login_share_qq_press.png"] forState:UIControlStateHighlighted];
//    [qqButton buttonClickedcompletion:^(id returnData) {
//        [self otherLoginType:DMOtherLoginTypeQQ];
//    }];
//    [_otherLoginTypeView addSubview:qqButton];
//    
//    //选择隐藏那种登录方式
//    sinaButton.hidden = NO;
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kWeiXinUrlScheme]]) {
//        wxButton.hidden = NO;
//    } else {
//        wxButton.hidden = YES;
//    }
//    qqButton.hidden = YES;//暂时不支持QQ联合登录
//    sinaButton.left = kScreenWidth/2 - 20 - sinaButton.width;
//    wxButton.left = kScreenWidth/2 + 20;
//
//    [self.view addSubview:_otherLoginTypeView];
}

- (void)tapAction:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:NO];
}

//- (void)otherLoginType:(DMOtherLoginType)type {
//    
//    if (type == DMOtherLoginTypeSina) {
//        //新浪联合登录
//        [[DMSinaWeiboShare share] loginSuccess:^(id returnData) {
//            [self hideLoadingView];
//            [self handleResponseOfType:DMThirdPartySinaWeibo
//                            returnData:returnData];
//        } fail:^(NSError *error) {
//            [self hideLoadingView];
//            if ([error localizedDescription]) {
//                [self showErrorViewWithText:[error localizedDescription]];
//            }
//        }];
//    } else if (type == DMOtherLoginTypeQQ) {
//        //QQ联合登录
//        if ([TencentOAuth iphoneQQInstalled]) {
//            [[DMTencentShare share] loginSuccess:^(id returnData) {
//                [self hideLoadingView];
//                [self handleResponseOfType:DMThirdPartyTencent
//                                returnData:returnData];
//            } fail:^(NSError *error) {
//                [self hideLoadingView];
//                if ([error localizedDescription]) {
//                    [self showErrorViewWithText:[error localizedDescription]];
//                }
//            }];
//        } else {
//            DMUserLoginWebViewController *controller = [[DMUserLoginWebViewController alloc] init];
//            [self.navigationController pushViewController:controller animated:YES];
//            
//        }
//    } else if (type == DMOtherLoginTypeWX) {
//        //微信联合登录
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kWeiXinUrlScheme]]) {
//            [[DMWeChatShare share] loginSuccess:^(id returnData) {
//                [self hideLoadingView];
//                [self handleResponseOfType:DMThirdPartyWeChat
//                                returnData:returnData];
//            } fail:^(NSError *error) {
//                [self hideLoadingView];
//                if ([error localizedDescription]) {
//                    [self showErrorViewWithText:[error localizedDescription]];
//                }
//            }];
//        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAlertTitle message:@"您没有安装微信,安装后即可使用该功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        
//    } else {
//        
//    }
//}
//
//
//- (void)handleResponseOfType:(DMThirdPartyShareType)type returnData:(id)data {
//    [self getUserInfoByLoginKey:data];
//}

#pragma mark -----------------button响应事件-----------
/**
 *  点击登录按钮的事件
 */
- (void)loginButonAction {
    if (_phoneTextField.textField.text.length == 0) {
        [self showAlertViewWithText:@"请输入账号!"];
        return;
    }
    if (_passwordTextField.textField.text.length == 0) {
        [self showAlertViewWithText:@"请输入密码!"];
        return;
    }
    
    [self requestLogin];
}

/**
 *  进入忘记密码页面
 */
-(void)gotoForgotPwdPage {
    
    DMForgetPwdViewController *controller = [[DMForgetPwdViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)activityButtonClicked {
    DMUserRegisterViewController *controller = [[DMUserRegisterViewController alloc] init];
    controller.fromLogin = YES;
    controller.success = self.success;
    controller.fail = self.fail;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -----------------数据请求-----------------

-(void)requestLogin {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:_phoneTextField.textField.text forKey:@"phone"];
    [params setSafetyObject:_passwordTextField.textField.text forKey:@"passwd"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMUserLoginService serviceUserLoginWithParameters:params success:^(id returnData) {
        [self hideLoadingView];
        [self loginDataRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
    
}


#pragma mark -----------------数据请求成功调用的方法-----------------

-(void)loginDataRequestSuccess:(id)returnData {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
    self.success(@"success");
    
//    if ([DMGlobalVar shareGlobalVar].deviceToken.length > 0) {
//        [DMSendTokenService blindTokenAndMWithParameters:@{@"token": [DMGlobalVar shareGlobalVar].deviceToken,
//                                                           @"platform":@"3",
//                                                           @"m": [DMGlobalVar shareGlobalVar].userLoginInfo.login_m} success:^(id returnData) {
//                                                               
//                                                           } fail:^(NSError *error) {
//                                                               
//                                                           }];
//    }
    
    
    [self backAction];
}


#pragma mark -----------------delegate-----------------

//-(void)selectedTextField:(NSInteger)tag {
//    _currentSelectedTextFieldTag = tag;
//    if (kScreenHeight < 600 && _currentViewType == DMViewTypeRegister) {
//        if ( _currentSelectedTextFieldTag == 3) {
//            self.view.bounds = CGRectMake(0, 100, self.view.width, self.view.height);
//        } else if ( _currentSelectedTextFieldTag == 4) {
//            if (self.view.bounds.origin.y < 50) {
//                self.view.bounds = CGRectMake(0, 50, self.view.width, self.view.height);
//            }
//        } else {
//        }
//    }
//}

- (void)backAction {
    [self.view endEditing:NO];
    if (self.fail) {
        self.fail(nil);
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)webLoginNotification:(NSNotification*)aNotification {
//    NSString *string = [aNotification object];
//    NSDictionary *params = @{@"token" : string?string:@"",@"sourceid" : @"2"};
//    DMUserLoginParser *parser =[[DMUserLoginParser alloc]init];
//    DMRequest *request = [[DMRequest alloc]init];
//    [request requestWithUrl:kLoginthird
//                 parameters:params
//                     parser:parser
//                    success:^(id result){
//                        [self handleResponseOfType:DMThirdPartyTencent returnData:result];
//                    }  fail:^(NSError *error){
//                        self.fail(error);
//                    }];
}

/**
 *  根据用户的loginkey得到用户的信息
 */
-(void)getUserInfoByLoginKey:(DMUserLoginInfo *)returnData
{
    
    [self showLoadingViewWithText:kLoadingText];
    [DMGlobalVar shareGlobalVar].userLoginInfo = (DMUserLoginInfo *)returnData;
    
    //请求用户loginKey
}

@end
