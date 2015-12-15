//
//  DMUserCenterViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/9.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMUserCenterViewController.h"
#import "DMSettingViewController.h"
#import "DMUserCenterService.h"
#import "DMUserInfo.h"
#import "DMFeedBackViewController.h"
#import "DMUserCollectionListViewController.h"
#import "DMUserLoginViewController.h"
#import "DMUserRegisterViewController.h"

#define KShoucangCell @"我的收藏"
#define KBaoliaoCell @"我的爆料"


#define KXiugaimimaCell @"修改账户密码"


#define KHaopingCell @"给我们好评"
#define KYijianfankuiCell @"意见反馈"
#define KTuijianCell @"推荐给朋友"

@interface DMUserCenterViewController () <UITableViewDataSource, UITableViewDelegate>{
    UIView *_userInfoView;
    UIImageView *_userHeadImageView;
    UILabel *_userNameLabel;
    UIImageView *_iconImageView;
    UILabel *_chengweiLabel;
    UITableView *_tableView;
    NSArray *_tableViewScetion;
    UILabel *_zixunCountLabel;
    UILabel *_zhutiCountLabel;
    UILabel *_huifuCountLabel;
    
    DMUserInfo *_userInfo;
}

@end

@implementation DMUserCenterViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    _tableViewScetion = @[@[KShoucangCell, KBaoliaoCell], @[KXiugaimimaCell], @[KHaopingCell, KYijianfankuiCell, KTuijianCell]];
    [self createSubViews];
    [self createUserInfoViews];
//    [self requestUserInfo];
}

#pragma mark ========== Private Method ==========

#pragma mark -------------createSubViews----------

-(void)createUserInfoViews {
    if (_userInfoView) {
        [_userInfoView removeFromSuperview];
        _userInfoView = nil;
    }
    _userInfoView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 95)];
    _userInfoView.backgroundColor = kDMPinkColor;

    _userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width - 48)/2, _userInfoView.bottom - 48 - 25, 48, 48)];
    _userHeadImageView.backgroundColor = kDMDefaultBlackStringColor;
    _userHeadImageView.clipsToBounds = YES;
    _userHeadImageView.userInteractionEnabled = YES;
    [_userInfoView addSubview:_userHeadImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(gotoUserDetailInfo)];
    [_userHeadImageView addGestureRecognizer:tap];
    
    if ([DMHelper isLogin]) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _userHeadImageView.bottom, kScreenWidth, 38)];
        _userNameLabel.font = FONT(12);
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
        _userNameLabel.text = @"13651052254";
        _userNameLabel.textColor = [UIColor whiteColor];
        [_userInfoView addSubview:_userNameLabel];
    } else {
        DMButton *loginButton = [[DMButton alloc] initWithFrame:CGRectMake(186/2, _userHeadImageView.bottom + 5, AUTOSIZE(70), AUTOSIZE(60))];
        loginButton.bottom = _userInfoView.bottom;
        loginButton.right = _userHeadImageView.left;
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton.titleLabel setFont:BOLDFONT(20)];
        [loginButton buttonClickedcompletion:^(id returnData) {
            DMUserLoginViewController *controller = [[DMUserLoginViewController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            controller.success = ^(id returnData) {
            
            };
            UINavigationController *naviCtrl = [[UINavigationController alloc]initWithRootViewController:controller];
            [self presentViewController:naviCtrl animated:YES completion:nil];
        }];

        [_userInfoView addSubview:loginButton];
        
        DMButton *registButton = [[DMButton alloc] initWithFrame:CGRectMake(self.view.width/2 + 40, _userHeadImageView.bottom + 5, AUTOSIZE(70), AUTOSIZE(60))];
        registButton.left = _userHeadImageView.right;
        registButton.bottom = _userInfoView.bottom;
        [registButton setTitle:@"注册" forState:UIControlStateNormal];
        [registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [registButton.titleLabel setFont:BOLDFONT(20)];
        [registButton buttonClickedcompletion:^(id returnData) {
            DMUserRegisterViewController *controller = [[DMUserRegisterViewController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            UINavigationController *naviCtrl = [[UINavigationController alloc]initWithRootViewController:controller];
            [self presentViewController:naviCtrl animated:YES completion:nil];
        }];
        [_userInfoView addSubview:registButton];

    }

    [self.view addSubview:_userInfoView];
}

- (void)createSubViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0,
                                                               0,
                                                               self.view.width,
                                                               self.view.height)
                                              style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled = YES;
    _tableView.sectionFooterHeight = 0.1;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(95, 0, 0, 0);
    [self.view addSubview:_tableView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    label.text = [NSString stringWithFormat:@"当前版本:%@",[@"V" stringByAppendingString:[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]]];
    label.textColor = kDMDefaultBlackStringColor;
    label.font = FONT(12);
    label.textAlignment = NSTextAlignmentCenter;
    _tableView.tableFooterView = label;
}

#pragma mark-----------------私有方法-------------------

- (void)updateUserInfoView {
    _userNameLabel.text = _userInfo.name;
    _chengweiLabel.text = _userInfo.leveltitle;
    _zhutiCountLabel.text = [NSString stringWithFormat:@"%@",(_userInfo.subject.integerValue > 99)?@"99+":_userInfo.subject];
    _zixunCountLabel.text = (_userInfo.consults.integerValue > 99)?@"99+":_userInfo.consults;
    _huifuCountLabel.text = [NSString stringWithFormat:@"%@",(_userInfo.answer.integerValue > 99)?@"99+":_userInfo.answer];
    [_zhutiCountLabel adjustFontWithMaxSize:CGSizeMake(40, AUTOSIZE(14))];
    _zhutiCountLabel.width += AUTOSIZE(15);
    _zhutiCountLabel.height = AUTOSIZE(14);
    
    [_zixunCountLabel adjustFontWithMaxSize:CGSizeMake(40, AUTOSIZE(14))];
    _zixunCountLabel.width += AUTOSIZE(15);
    _zixunCountLabel.height = AUTOSIZE(14);

    [_huifuCountLabel adjustFontWithMaxSize:CGSizeMake(40, AUTOSIZE(14))];
    _huifuCountLabel.width += AUTOSIZE(15);
    _huifuCountLabel.height = AUTOSIZE(14);

}
#pragma mark -----------------request--------------------

/**
 *  请求用户信息
 */
-(void)requestUserInfo {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00rcG9UQkt1VlhaMmxWblE" forKey:@"token"];

    [self showLoadingViewWithText:kLoadingText];
//    [DMUserCenterService getUserInforWithParams:params success:^(id returnData) {
//        [self hideLoadingView];
//        [self userInfoRequestSuccess:returnData];
//    } fail:^(NSError *error) {
//        [self hideLoadingView];
//        [self showErrorViewWithText:[error localizedDescription]];
//    }];

}

#pragma mark -------------dataRequestSuccess----------------

-(void)userInfoRequestSuccess:(DMUserInfo *)returnData {
    _userInfo = returnData;
    [self updateUserInfoView];
    [_tableView reloadData];
}
#pragma mark-----------------UITableViewDataSource-------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _tableViewScetion.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [_tableViewScetion objectAt:section];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *section = [_tableViewScetion objectAt:indexPath.section];
    DMTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMTableViewCell"];
    if (!cell) {
        cell = [[DMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMTableViewCell"];
    }
    cell.textLabel.text = [section objectAt:indexPath.row];
    cell.textLabel.textColor = kDMDefaultBlackStringColor;
    cell.textLabel.font = FONT(14);
    cell.imageView.image = [UIImage imageWithSize:CGSizeMake(15, 15) color:[UIColor redColor]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth, 30)];
    switch (section) {
        case 0:
            label.text = @"     我的";
            break;
        case 1:
            label.text = @"     账户安全";
            break;
        case 2:
            label.text = @"     其他";
            break;
        default:
            label.text = @"";
            break;
    }
    label.backgroundColor = kTableViewBgColor;
    label.textColor = kDMDefaultBlackStringColor;
    label.font = FONT(12);
    return label;
}

#pragma mark----------------UITableViewDelegate---------------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSArray *section = [_tableViewScetion objectAt:indexPath.section];
    NSString *string = [section objectAt:indexPath.row];

    if ([string isEqualToString:KShoucangCell]) {
        DMUserCollectionListViewController *controller =[[DMUserCollectionListViewController alloc]init];
        [controller setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
    } else if ([string isEqualToString:KBaoliaoCell]) {
    
    } else if ([string isEqualToString:KXiugaimimaCell]) {
        
    } else if ([string isEqualToString:KHaopingCell]) {
        [WCAlertView showAlertWithTitle:@"陛下，赏本宫五颗❤️？"
                                message:nil
                     customizationBlock:nil
                        completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
                            if (buttonIndex != alertView.cancelButtonIndex) {
                                if ([UIDevice currentDevice].systemVersion.floatValue >=7.0) {
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id962201805"]];
                                }
                            }
                        } cancelButtonTitle:@"退下" otherButtonTitles:@"恩准", nil];

    } else if ([string isEqualToString:KYijianfankuiCell]) {
        DMFeedBackViewController *controller =[[DMFeedBackViewController alloc]init];
        [controller setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];

    } else if ([string isEqualToString:KTuijianCell]) {
        
    } else {
        
    }
}

@end
