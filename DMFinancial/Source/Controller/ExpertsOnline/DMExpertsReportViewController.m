//
//  DMExpertsReportViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/17.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMExpertsReportViewController.h"
#import "DMSplistService.h"

@interface DMExpertsReportViewController () {
    UIView *_userInfoView;
    UIImageView *_userHeadImageView;
    UILabel *_userNameLabel;
    UIImageView *_iconImageView;
    UILabel *_chengweiLabel;
    UITextView *_textView;
    DMButton *_submitButton;
}

@end

@implementation DMExpertsReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"举报";
    [self createSubViews];

}

-(void)createSubViews {
    _userInfoView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AUTOSIZE(143))];
    _userInfoView.backgroundColor = kDMPinkColor;
    
    
    _userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - AUTOSIZE(64))/2, (_userInfoView.height - AUTOSIZE(60) - AUTOSIZE(65))/2, AUTOSIZE(64), AUTOSIZE(64))];
    _userHeadImageView.backgroundColor = kDMDefaultBlackStringColor;
    _userHeadImageView.layer.cornerRadius = AUTOSIZE(64)/2;
    _userHeadImageView.clipsToBounds = YES;
    [_userInfoView addSubview:_userHeadImageView];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2, _userHeadImageView.bottom + AUTOSIZE(11), 100, AUTOSIZE(14))];
    _userNameLabel.font = FONT(12);
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    _userNameLabel.text = _item.name;
    [_userInfoView addSubview:_userNameLabel];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_userNameLabel.left, _userInfoView.bottom - AUTOSIZE(30), AUTOSIZE(12), AUTOSIZE(12))];
    _iconImageView.image = [UIImage imageWithResourcesPathCompontent:@"icon_biaoshi.png"];
    [_userInfoView addSubview:_iconImageView];
    
    
    _chengweiLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + AUTOSIZE(2), _iconImageView.top + AUTOSIZE(1), kScreenWidth - _userHeadImageView.right - AUTOSIZE(24 - AUTOSIZE(10)), AUTOSIZE(10))];
    _chengweiLabel.font = FONT(9);
    _chengweiLabel.text = _item.leveltitle;
    [_chengweiLabel adjustFontWithMaxSize:CGSizeMake(70, _chengweiLabel.height)];
    [_userInfoView addSubview:_chengweiLabel];
    
    _iconImageView.left = (kScreenWidth - _iconImageView.width - AUTOSIZE(2) - _chengweiLabel.width)/2;
    _chengweiLabel.left = _iconImageView.right + AUTOSIZE(2);
    
    [self.view addSubview:_userInfoView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(AUTOSIZE(24), _userInfoView.bottom + AUTOSIZE(24), kScreenWidth - AUTOSIZE(48), AUTOSIZE(368/2))];
    _textView.layer.borderColor = [UIColor colorWithHexString:@"f46c6b"].CGColor;
    _textView.layer.borderWidth = 0.5;
    [self.view addSubview:_textView];
    
    _submitButton = [[DMButton alloc] initWithFrame:CGRectMake((kScreenWidth - AUTOSIZE(112))/2, _textView.bottom + AUTOSIZE(20), AUTOSIZE(112), AUTOSIZE(30))];
    _submitButton.backgroundColor = [UIColor colorWithHexString:@"5e8397"];
    [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [_submitButton.titleLabel setFont:FONT(AUTOSIZE(12))];
    _submitButton.layer.cornerRadius = AUTOSIZE(20)/2;
    
    [_submitButton buttonClickedcompletion:^(id returnData) {
        if (_textView.text.length == 0) {
            [self showAlertViewWithText:@"请输入内容"];
        } else {
            [self requestReportData];
        }
    }];
    [self.view addSubview:_submitButton];
    
}

-(void)requestReportData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"report" forKey:@"action"];
    [params setSafetyObject:_textView.text forKey:@"remarks"];

    [params setSafetyObject:_item.spid forKey:@"spid"];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00r" forKey:@"token"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMSplistService reportSplistListWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self showAlertViewWithText:@"举报成功"];
        [self performSelector:@selector(backAction) withObject:nil afterDelay:1];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];

}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
