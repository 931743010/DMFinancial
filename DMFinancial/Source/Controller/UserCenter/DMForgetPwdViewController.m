//
//  DMForgetPwdViewController.m
//  DamaiPlayPhone
//
//  Created by 高李军 on 15-1-21.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMForgetPwdViewController.h"
#import "DMHelper.h"

@interface DMForgetPwdViewController ()
{
	UIView           *_inputBoxBg;//输入框背景
	UITextField      *_phoneConment;//手机号码输入框
	UITextField      *_verificationcodeConment;//验证码输入框
	UIImageView      *_phoneIcon;//用户账号icon
	UIButton         *_reObtainBtn;//重新获取按钮
	UIButton         *_resetPwdBtn;//重置密码

	UIButton         *_chengButton;

	NSTimer          *valiTimer; //倒计时 定时器
	int              valiTime;//60s倒计时

}


@end

@implementation DMForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.view.backgroundColor=[UIColor colorWithHexString:@"fafafa"];
	self.title = @"忘记密码";

	//创建每一个子控件

	[self setUpChildViews];
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[_phoneConment becomeFirstResponder];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//创建每一个子控件
-(void)setUpChildViews{
	//输入框背景色
	_inputBoxBg = [[UIView alloc]initWithFrame:CGRectZero];
	_inputBoxBg.backgroundColor =[UIColor whiteColor];
	[self.view addSubview:_inputBoxBg];
	//右边的图标
	_phoneIcon = [[UIImageView alloc]initWithFrame:CGRectZero];
	_phoneIcon.image = [UIImage imageWithResourcesPathCompontent:@"Login_phone_gray.png"];
	[_inputBoxBg addSubview:_phoneIcon];

	//手机号码输入框
	_phoneConment = [[UITextField alloc]initWithFrame:CGRectZero];
	_phoneConment.backgroundColor =[UIColor clearColor];
	_phoneConment.placeholder =@"请输入手机号或邮箱来获取验证码";
	_phoneConment.font = FONT(15);
	_phoneConment.textColor = kDMDefaultBlackStringColor;
	_phoneConment.returnKeyType = UIReturnKeyDone;
	_phoneConment.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	_phoneConment.keyboardType = UIKeyboardTypeEmailAddress;
	//[_phoneConment becomeFirstResponder];
	[_inputBoxBg addSubview:_phoneConment];

	//验证码输入框
	_verificationcodeConment = [[UITextField alloc]initWithFrame:CGRectZero];
	_verificationcodeConment.backgroundColor =[UIColor clearColor];
	_verificationcodeConment.placeholder =@"请输入验证码";
	_verificationcodeConment.font = FONT(15);
	_verificationcodeConment.textColor = kDMDefaultBlackStringColor;
	_verificationcodeConment.returnKeyType = UIReturnKeyDone;
	_verificationcodeConment.keyboardType = UIKeyboardTypeNumberPad;
	_verificationcodeConment.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	[_inputBoxBg addSubview:_verificationcodeConment];


	//重新获取
	_reObtainBtn = [[UIButton alloc] init];
	_reObtainBtn.titleLabel.font = [UIFont systemFontOfSize:13];
	//_reObtainBtn.backgroundColor = RGBA(222, 0, 55, 1.0);
	_reObtainBtn.layer.borderColor = kDMPinkColor.CGColor;
	_reObtainBtn.layer.borderWidth = 0.5;
	[_reObtainBtn setTitleColor:kDMPinkColor  forState:UIControlStateNormal];
	[_reObtainBtn setTitle:@"获取验证" forState:UIControlStateNormal];
	_reObtainBtn.layer.cornerRadius = 13;
	[_reObtainBtn addTarget:self action:@selector(regetVercode:)
		   forControlEvents:UIControlEventTouchUpInside];
	[_inputBoxBg addSubview:_reObtainBtn];

	//重置密码
	_resetPwdBtn = [[UIButton alloc] init];

	_resetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:15];
	_resetPwdBtn.backgroundColor = kDMPinkColor;
	[_resetPwdBtn setTitleColor:RGBA(255, 255, 255, 1.0)  forState:UIControlStateNormal];
	[_resetPwdBtn setTitle:@"重置密码" forState:UIControlStateNormal];
	_resetPwdBtn.layer.cornerRadius = 20;
    [_resetPwdBtn.titleLabel setFont:BOLDFONT(15)];
	[_resetPwdBtn addTarget:self action:@selector(resetPwd)
			forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_resetPwdBtn];

    [_inputBoxBg drawSolidLineWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    [_inputBoxBg drawSolidLineWithFrame:CGRectMake(15, 118/2 - 0.5, kScreenWidth, 0.5)];
    [_inputBoxBg drawSolidLineWithFrame:CGRectMake(0, 118 - 0.5, kScreenWidth, 0.5)];

    
}

-(void)viewDidLayoutSubviews{

	[super viewDidLayoutSubviews];
	CGFloat topMargin = 20;
	CGFloat mainViewWidth = self.view.width;

	//背景
	CGFloat boxbgX = 0;
	CGFloat boxbgY = topMargin;
	CGFloat boxbgW = mainViewWidth;
	CGFloat boxbgH = 118;
	_inputBoxBg.frame =CGRectMake(boxbgX, boxbgY, boxbgW,boxbgH);

	//手机号码
	CGFloat phoneConmentX = 20;
	CGFloat phoneConmentY = 0;
	CGFloat phoneConmentW = 260;
	CGFloat phoneConmentH = boxbgH * 0.5;
	_phoneConment.frame = CGRectMake(phoneConmentX, phoneConmentY, phoneConmentW, phoneConmentH);
	//验证码
	_verificationcodeConment.frame = CGRectMake(20, _phoneConment.bottom, 260, phoneConmentH);
	//手机图标
	CGFloat iconH = 18;
	CGFloat iconW = 18;
	CGFloat iconX = mainViewWidth - 20 - iconW;
	CGFloat iconY = (_phoneConment.height - 18)/2;
	_phoneIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);

	//重新获取
	CGFloat btnH = 26;
	CGFloat btnW = 80;
	CGFloat btnX = self.view.width - 20 - btnW;
	CGFloat btnY = _phoneConment.bottom + (_phoneConment.height - 26)/2;
	_reObtainBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);

	//重置密码
	_resetPwdBtn.frame =CGRectMake(40, CGRectGetMaxY(_inputBoxBg.frame) + 20,mainViewWidth - 80, 40);

}

//重置密码
-(void)resetPwd{


	NSString *account = _phoneConment.text;
	NSString *code = _verificationcodeConment.text;

	if (account.length == 0){
		[self showErrorViewWithText:@"请输入手机号或邮箱"];
		return;
	}
	if (code.length == 0){
		[self showErrorViewWithText:@"请输入验证码"];
		return;
	}


	[self showLoadingViewWithText:kLoadingText];
	NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:account,@"name",code,@"code", nil];
//	[DMFindUserPassWordService findPwdTwoUserWithParams:param success:^(id returnData) {
//		[self hideLoadingView];
//		NSDictionary *result = (NSDictionary *)returnData;
//		NSNumber *us = (NSNumber*)[result objectForKey:@"us"];
//		BOOL b = [us boolValue];
//		if(b){
//			DMResetPwdViewController *resetVc = [[DMResetPwdViewController alloc]init];
//			resetVc.hidesBottomBarWhenPushed = YES;
//			resetVc.account = account;
//			resetVc.valiCode = code;
//			[self.navigationController pushViewController:resetVc animated:YES];
//		}else{
//			NSString *error = [result objectForKey:@"error"];
//			[self showErrorViewWithText:error];
//		}
//	} fail:^(NSError *error) {
//		[self hideLoadingView];
//        [self showErrorViewWithText:[error localizedDescription]];
//	}];
}

//获取验证码
-(void)regetVercode:(UIButton *)regetBtn{

	NSString *account = _phoneConment.text;
	if (account.length == 0){
		[self showErrorViewWithText:@"请输入手机号或邮箱"];
		return;
	}

	regetBtn.enabled = NO;
	regetBtn.layer.borderColor = [RGBA(154, 154, 154, 1.0) CGColor];
	regetBtn.layer.borderWidth = 0.5;
	[regetBtn setTitleColor:RGBA(154, 154, 154, 1.0)  forState:UIControlStateNormal];

	//创建计时器



	//数据请求
	[self showLoadingViewWithText:kLoadingText];
	NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:account,@"account", nil];

//	[DMFindUserPassWordService findPwdOneUserWithParams:param success:^(id returnData) {
//		[self hideLoadingView];
//		NSDictionary *result = (NSDictionary *)returnData;
//		NSNumber *us = (NSNumber*)[result objectForKey:@"us"];
//		BOOL b = [us boolValue];
//		if(b){
//			[self showAlertViewWithText:@"已发送,注意查收"];
//			valiTime = 59;
//			valiTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
//			[valiTimer setFireDate:[NSDate distantPast]];
//		}else{
//			NSString *error = [result objectForKey:@"error"];
//			[self showErrorViewWithText:error];
//		}
//	} fail:^(NSError *error) {
//		[self hideLoadingView];
//		DMLOG(@"%@",[error localizedDescription]);
//        [self showErrorViewWithText:[error localizedDescription]];
//		_reObtainBtn.enabled = YES;
//		_reObtainBtn.layer.borderColor = kDMPinkColor.CGColor;
//		_reObtainBtn.layer.borderWidth = 0.5;
//		[_reObtainBtn setTitleColor:kDMPinkColor  forState:UIControlStateNormal];
//		[valiTimer setFireDate:[NSDate distantFuture]];
//		[_reObtainBtn setTitle:@"获取验证" forState:UIControlStateNormal];
//	}];
//
}


-(void)timerFired:(NSTimer*)time
{
	[_reObtainBtn setTitle:[NSString stringWithFormat:@"%ds",valiTime] forState:UIControlStateNormal];
	valiTime--;
	if (valiTime<0) {
		_reObtainBtn.enabled = YES;
		_reObtainBtn.layer.borderColor = kDMPinkColor.CGColor;
		_reObtainBtn.layer.borderWidth = 0.5;
		[_reObtainBtn setTitleColor:kDMPinkColor  forState:UIControlStateNormal];
		[valiTimer setFireDate:[NSDate distantFuture]];
		[_reObtainBtn setTitle:@"重新获取" forState:UIControlStateNormal];
	}
}

-(void)viewDidDisappear:(BOOL)animated{
	[super viewDidDisappear:animated];
	[self.view endEditing:YES];
}

@end
