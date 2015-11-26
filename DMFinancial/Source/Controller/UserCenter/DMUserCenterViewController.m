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

#define KMineActivitySection @"我的镖银" //活动section
#define KMineSponsorSection @"我的关注"   //主办section
#define KSettingSection @"设置"         //明星section

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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    _tableViewScetion = @[KMineActivitySection, KMineSponsorSection,KSettingSection];

    [self createUserInfoViews];
    [self createSubViews];
    [self requestUserInfo];

}

#pragma mark -------------createSubViews----------

-(void)createUserInfoViews {
    _userInfoView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AUTOSIZE(140))];
    _userInfoView.backgroundColor = kDMPinkColor;
    DMButton *zixunButton = [[DMButton alloc] initWithFrame:CGRectMake(0, _userInfoView.bottom - AUTOSIZE(35), kScreenWidth/3, AUTOSIZE(35))];
    zixunButton.backgroundColor = [UIColor colorWithHexString:@"3a444f"];
    [zixunButton setTitle:@"咨询" forState:UIControlStateNormal];
    [zixunButton.titleLabel setFont:FONT(AUTOSIZE(12))];
    [zixunButton buttonClickedcompletion:^(id returnData) {
        
    }];
    [zixunButton drawSolidLineWithFrame:CGRectMake(zixunButton.width - 0.5, 0, 0.5, zixunButton.height) color:[UIColor whiteColor]];
    [_userInfoView addSubview:zixunButton];
    
    DMButton *zhutiButton = [[DMButton alloc] initWithFrame:CGRectMake(zixunButton.right, _userInfoView.bottom - AUTOSIZE(35), kScreenWidth/3, AUTOSIZE(35))];
    zhutiButton.backgroundColor = [UIColor colorWithHexString:@"3a444f"];
    [zhutiButton setTitle:@"主题" forState:UIControlStateNormal];
    [zhutiButton.titleLabel setFont:FONT(AUTOSIZE(12))];
    [zhutiButton buttonClickedcompletion:^(id returnData) {
        
    }];
    [zhutiButton drawSolidLineWithFrame:CGRectMake(zixunButton.width - 0.5, 0, 0.5, zixunButton.height) color:[UIColor whiteColor]];
    [_userInfoView addSubview:zhutiButton];

    DMButton *huifuButton = [[DMButton alloc] initWithFrame:CGRectMake(zhutiButton.right, _userInfoView.bottom - AUTOSIZE(35), kScreenWidth/3, AUTOSIZE(35))];
    huifuButton.backgroundColor = [UIColor colorWithHexString:@"3a444f"];
    [huifuButton setTitle:@"回复" forState:UIControlStateNormal];
    [huifuButton.titleLabel setFont:FONT(AUTOSIZE(12))];
    [huifuButton buttonClickedcompletion:^(id returnData) {
        
    }];
    [_userInfoView addSubview:huifuButton];

    _userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AUTOSIZE(50), (_userInfoView.height - zixunButton.height - AUTOSIZE(65))/2, AUTOSIZE(64), AUTOSIZE(64))];
    _userHeadImageView.backgroundColor = kDMDefaultBlackStringColor;
    _userHeadImageView.layer.cornerRadius = AUTOSIZE(64)/2;
    _userHeadImageView.clipsToBounds = YES;
    _userHeadImageView.userInteractionEnabled = YES;
    [_userInfoView addSubview:_userHeadImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(gotoUserDetailInfo)];
    [_userHeadImageView addGestureRecognizer:tap];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userHeadImageView.right + AUTOSIZE(24), _userHeadImageView.top + 15, kScreenWidth - _userHeadImageView.right - AUTOSIZE(24 - AUTOSIZE(10)), AUTOSIZE(14))];
    _userNameLabel.font = FONT(12);
    [_userInfoView addSubview:_userNameLabel];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_userNameLabel.left, _userNameLabel.bottom + AUTOSIZE(8), AUTOSIZE(12), AUTOSIZE(12))];
    _iconImageView.backgroundColor = kDMDefaultBlackStringColor;
    [_userInfoView addSubview:_iconImageView];

    //称谓
    _chengweiLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + AUTOSIZE(2), _iconImageView.top + AUTOSIZE(5), kScreenWidth - _userHeadImageView.right - AUTOSIZE(24 - AUTOSIZE(10)), AUTOSIZE(7))];
    _chengweiLabel.font = FONT(10);
    [_userInfoView addSubview:_chengweiLabel];

    //咨询数量
    _zixunCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(zhutiButton.width - AUTOSIZE(40) - AUTOSIZE(8), AUTOSIZE(5), 0, AUTOSIZE(14))];
    _zixunCountLabel.font = FONT(10);
    _zixunCountLabel.backgroundColor = [UIColor colorWithHexString:@"f46c6b"];
    _zixunCountLabel.clipsToBounds = YES;
    _zixunCountLabel.textAlignment = NSTextAlignmentCenter;
    _zixunCountLabel.textColor = [UIColor whiteColor];
    _zixunCountLabel.layer.cornerRadius = AUTOSIZE(14)/2;
    [zixunButton addSubview:_zixunCountLabel];
    
    //主题数量
    _zhutiCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(zhutiButton.width - AUTOSIZE(40) - AUTOSIZE(8), AUTOSIZE(5), 0, AUTOSIZE(14))];
    _zhutiCountLabel.font = FONT(10);
    _zhutiCountLabel.backgroundColor = [UIColor colorWithHexString:@"f46c6b"];
    _zhutiCountLabel.clipsToBounds = YES;
    _zhutiCountLabel.textAlignment = NSTextAlignmentCenter;
    _zhutiCountLabel.textColor = [UIColor whiteColor];
    _zhutiCountLabel.layer.cornerRadius = AUTOSIZE(14)/2;
    [zhutiButton addSubview:_zhutiCountLabel];
    
    //回复数量
    _huifuCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(zhutiButton.width - AUTOSIZE(40) - AUTOSIZE(8), AUTOSIZE(5), 0, AUTOSIZE(14))];
    _huifuCountLabel.font = FONT(10);
    _huifuCountLabel.backgroundColor = [UIColor colorWithHexString:@"f46c6b"];
    _huifuCountLabel.clipsToBounds = YES;
    _huifuCountLabel.textAlignment = NSTextAlignmentCenter;
    _huifuCountLabel.textColor = [UIColor whiteColor];
    _huifuCountLabel.layer.cornerRadius = AUTOSIZE(14)/2;
    [huifuButton addSubview:_huifuCountLabel];

}

- (void)createSubViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0,
                                                               0,
                                                               self.view.width,
                                                               self.view.height)
                                              style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled = YES;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:_tableView];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    _tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark-----------------私有方法-------------------


//- (void)gotoUserDetailInfo {
//    DMUserDetailInfoViewController *controller = [[DMUserDetailInfoViewController alloc] init];
//    controller.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:controller animated:YES];
//
//}

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
    [DMUserCenterService getUserInforWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self userInfoRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];

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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewScetion.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMTableViewCell"];
    if (!cell) {
        cell = [[DMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMTableViewCell"];
    }
    cell.textLabel.text = [_tableViewScetion objectAt:indexPath.row];
    cell.textLabel.textColor = kDMDefaultBlackStringColor;
    cell.textLabel.font = FONT(AUTOSIZE(15));
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _userInfoView.height;
}
#pragma mark----------------UITableViewDelegate---------------------


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _userInfoView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AUTOSIZE(50);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *key = [_tableViewScetion objectAtIndex:indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
