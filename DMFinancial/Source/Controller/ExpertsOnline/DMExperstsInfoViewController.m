//
//  DMExperstsInfoViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMExperstsInfoViewController.h"

#import "DMMyMoneyViewController.h"
#import "DMMyAttentionViewController.h"
#import "DMSettingViewController.h"
#import "DMSplistService.h"
#import "DMExpertsReportViewController.h"

#define KMineActivitySection @"     地区:" //活动section
#define KMineSponsorSection @"个性签名:"   //主办section
#define KSettingSection @"个人领域:"         //明星section

@interface DMExperstsInfoViewController () <UITableViewDataSource, UITableViewDelegate>{
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
    UIView *_footView;
    DMButton *_zixunButton;
}

@end

@implementation DMExperstsInfoViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专家在线";
    _tableViewScetion = @[KMineActivitySection, KMineSponsorSection,KSettingSection];
    
//    [self userLoginWithDelegate:self success:^(id returnData) {
//        
//    } fail:^(NSError *error) {
//        
//    }];
    [self createUserInfoViews];
    [self createSubViews];
}

#pragma mark -------------createSubViews----------

-(void)createUserInfoViews {
    _userInfoView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AUTOSIZE(143))];
    _userInfoView.backgroundColor = kDMPinkColor;
    _zixunButton = [[DMButton alloc] initWithFrame:CGRectMake(AUTOSIZE(36), _userInfoView.bottom - AUTOSIZE(30), AUTOSIZE(95), AUTOSIZE(20))];
    _zixunButton.backgroundColor = [UIColor colorWithHexString:@"5e8397"];
    [_zixunButton setTitle:@"关注" forState:UIControlStateNormal];
    [_zixunButton.titleLabel setFont:FONT(AUTOSIZE(12))];
    _zixunButton.layer.cornerRadius = AUTOSIZE(20)/2;

    [_zixunButton buttonClickedcompletion:^(id returnData) {
        [self requestLikeData];
    }];
    [_userInfoView addSubview:_zixunButton];
    
    DMButton *zhutiButton = [[DMButton alloc] initWithFrame:CGRectMake(kScreenWidth - _zixunButton.width - AUTOSIZE(36), _zixunButton.top, _zixunButton.width, _zixunButton.height)];
    zhutiButton.backgroundColor = [UIColor colorWithHexString:@"5e8397"];
    [zhutiButton setTitle:@"立即咨询" forState:UIControlStateNormal];
    [zhutiButton.titleLabel setFont:FONT(AUTOSIZE(12))];
    zhutiButton.layer.cornerRadius = AUTOSIZE(20)/2;
    [zhutiButton buttonClickedcompletion:^(id returnData) {
        
    }];
    [_userInfoView addSubview:zhutiButton];
    
    
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
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_userNameLabel.left, _zixunButton.top + AUTOSIZE(2), AUTOSIZE(12), AUTOSIZE(12))];
    _iconImageView.image = [UIImage imageWithResourcesPathCompontent:@"icon_biaoshi.png"];
    [_userInfoView addSubview:_iconImageView];
    
    
    _chengweiLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + AUTOSIZE(2), _iconImageView.top + AUTOSIZE(1), kScreenWidth - _userHeadImageView.right - AUTOSIZE(24 - AUTOSIZE(10)), AUTOSIZE(10))];
    _chengweiLabel.font = FONT(9);
    _chengweiLabel.text = _item.leveltitle;
    [_chengweiLabel adjustFontWithMaxSize:CGSizeMake(70, _chengweiLabel.height)];
    [_userInfoView addSubview:_chengweiLabel];
    
    _iconImageView.left = (kScreenWidth - _iconImageView.width - AUTOSIZE(2) - _chengweiLabel.width)/2;
    _chengweiLabel.left = _iconImageView.right + AUTOSIZE(2);
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
    
    _tableView.tableFooterView = [self getFootView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithResourcesPathCompontent:@"icon_experst_rightBarButton.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
}

- (UIView *)getFootView {
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    }
    [_footView removeSubviews];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - 0.5, kScreenWidth, 0.5)];
    line.backgroundColor = kSeperatorColor;
    [_footView addSubview:line];

    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, AUTOSIZE(13) - 0.5, kScreenWidth, 0.5)];
    line1.backgroundColor = kSeperatorColor;
    [_footView addSubview:line1];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTOSIZE(32), AUTOSIZE(13), AUTOSIZE(105), AUTOSIZE(35))];
    titleLabel.text = @"个性签名:";
    titleLabel.textColor = kDMDefaultBlackStringColor;
    titleLabel.font = FONT(15);
    [_footView addSubview:titleLabel];
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTOSIZE(32), titleLabel.bottom, kScreenWidth - AUTOSIZE(64), 0)];
    descLabel.text = _item.desc;
    descLabel.textColor = kDMDefaultGrayStringColor;
    descLabel.font = FONT(10);

    descLabel.numberOfLines = 0;
    [descLabel adjustFontWithMaxSize:CGSizeMake(descLabel.width, 11111)];
    [_footView addSubview:descLabel];
    _footView.height = descLabel.bottom + 13;
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _footView.bottom - 0.5, kScreenWidth, 0.5)];
    line2.backgroundColor = kSeperatorColor;
    [_footView addSubview:line2];

    return _footView;
}

#pragma mark -----------requset--------------

-(void)requestLikeData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"like" forKey:@"action"];
    [params setSafetyObject:_item.spid forKey:@"spid"];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00r" forKey:@"token"];

    [self showLoadingViewWithText:kLoadingText];
    [DMSplistService likeSplistListWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self showAlertViewWithText:@"关注成功"];
        [_zixunButton setTitle:@"已关注" forState:UIControlStateNormal];

    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
}

//-(void)requestSplistData {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setSafetyObject:@"getsplist" forKey:@"action"];
//    [params setSafetyObject:@"" forKey:@"field"];
//    [params setSafetyObject:@"1" forKey:@"sort"];
//    [params setSafetyObject:@"1" forKey:@"page"];
//    [params setSafetyObject:@"10" forKey:@"size"];
//    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
//    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00r" forKey:@"token"];
//    
//    [self showLoadingViewWithText:kLoadingText];
//    [DMSplistService getSplistListWithParams:params success:^(id returnData) {
//        [self hideLoadingView];
//        [self splistDataRequestSuccess:returnData];
//    } fail:^(NSError *error) {
//        [self hideLoadingView];
//        [self showErrorViewWithText:[error localizedDescription]];
//    }];
//    
//}
//
//#pragma mark-----------------dataRequestSuccess-------------------
//- (void)splistDataRequestSuccess:(NSArray *)returnData {
//    if (!returnData) {
//        return;
//    }
//    if (_isRefresh) {
//        [_array removeAllObjects];
//        _isRefresh = NO;
//    }
//    [_array addObjectsFromArray:returnData];
//    [_tableView reloadData];
//}


-(void)rightBarButtonAction {
    DMExpertsReportViewController *controller = [[DMExpertsReportViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.item = self.item;
    [self.navigationController pushViewController:controller animated:YES];
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
        cell = [[DMTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DMTableViewCell"];
    }
    cell.textLabel.text = [_tableViewScetion objectAt:indexPath.row];
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = _item.city;
    } else if (indexPath.row == 1) {
        cell.detailTextLabel.text = _item.signa;
    } else if (indexPath.row == 2) {
        cell.detailTextLabel.text = _item.goods;
    }
    cell.textLabel.textColor = kDMDefaultBlackStringColor;
    cell.textLabel.font = FONT(AUTOSIZE(15));
    cell.detailTextLabel.font = FONT(AUTOSIZE(12));

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
    
    if (indexPath.row == 0)
    {
        DMMyMoneyViewController *controller = [[DMMyMoneyViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    } else if (indexPath.row == 1) {
        DMMyAttentionViewController *controller = [[DMMyAttentionViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    } else if (indexPath.row == 2) {
        DMSettingViewController *controller = [[DMSettingViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}


@end
