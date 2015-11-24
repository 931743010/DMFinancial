//
//  DMSettingViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/10.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMSettingViewController.h"

@interface DMSettingViewController  ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_array;
    BOOL _isLogin;//是否登录
}


@end

@implementation DMSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    _isLogin = NO;
    _array = [[NSMutableArray alloc] initWithCapacity:10];
    [_array addObjectsFromArray:@[@"账号与安全",@"关于职场保镖",@"去评分",@"分享应用得镖银",@"帮我们做的更好"]];
    [self createSubViews];
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
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    if (_isLogin) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AUTOSIZE(80))];
        
        DMButton *logout = [[DMButton alloc] initWithFrame:CGRectMake((kScreenWidth - AUTOSIZE(210))/2, footView.bottom - AUTOSIZE(45), AUTOSIZE(210), AUTOSIZE(45))];
        [logout.titleLabel setFont:BOLDFONT(21)];
        logout.layer.cornerRadius = AUTOSIZE(22);
        logout.layer.borderColor = kDMPinkColor.CGColor;
        logout.layer.borderWidth = 0.5;
        [logout setTitleColor:kDMPinkColor forState:UIControlStateNormal];
        [logout setTitle:@"退出登录" forState:UIControlStateNormal];
        [logout buttonClickedcompletion:^(id returnData) {
            [self logoutButonAction];
        }];
        [footView addSubview:logout];
        [footView drawSolidLineWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5) color:kSeperatorColor];
        _tableView.tableFooterView = footView;
    } else {
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        _tableView.tableFooterView.backgroundColor = kSeperatorColor;

    }
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


-(void)logoutButonAction{
    [WCAlertView showAlertWithTitle:nil message:@"是否退出登录" customizationBlock:nil completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
            _tableView.tableFooterView.backgroundColor = kSeperatorColor;
            [self performSelector:@selector(backButtonAction) withObject:nil afterDelay:0.1];
        }
    } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
}

- (void) backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark-----------------UITableViewDataSource-------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMTableViewCell"];
    if (!cell) {
        cell = [[DMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMTableViewCell"];
    }
    cell.textLabel.text = [_array objectAt:indexPath.row];
    cell.textLabel.textColor = kDMDefaultBlackStringColor;
    cell.textLabel.font = FONT(AUTOSIZE(15));
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AUTOSIZE(53);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *key = [_tableViewScetion objectAtIndex:indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
            
        case 2:
            
            break;
            
        case 3:
            
            break;
            
        case 4:
            
            break;
            

        default:
            break;
    }
}

@end