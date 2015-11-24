//
//  DMMyMoneyViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/10.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMMyMoneyViewController.h"
#import "DMMyMoneyCell.h"
#import "DMUserCenterService.h"

@interface DMMyMoneyViewController () <UITableViewDataSource, UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_array;
    UIView *_topView;
    UILabel *_currentMoneyLabel;
    UILabel *_moneyLabel;
    DMButton *_duihuanButton;
}

@end

@implementation DMMyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的镖银";
    _array = [[NSMutableArray alloc] init];
    [self createSubViews];
    [self requestData];
}

- (void)createSubViews {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AUTOSIZE(80))];
    _currentMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTOSIZE(40), 0, 100, _topView.height)];
    _currentMoneyLabel.text = @"当前镖银:";
    _currentMoneyLabel.textColor = kDMDefaultBlackStringColor;
    _currentMoneyLabel.font = FONT(15);
    [_topView addSubview:_currentMoneyLabel];
    
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(_currentMoneyLabel.right + 15, 0, 200, _topView.height)];
    _moneyLabel.textColor = kDMDefaultBlackStringColor;
    _moneyLabel.font = FONT(23);
    [_topView addSubview:_moneyLabel];

    _duihuanButton = [[DMButton alloc] initWithFrame:CGRectMake(kScreenWidth - AUTOSIZE(120), (_topView.height - AUTOSIZE(35))/2, AUTOSIZE(66), AUTOSIZE(35))];
    [_duihuanButton setTitle:@"充值" forState:UIControlStateNormal];
    [_duihuanButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
    [_duihuanButton buttonClickedcompletion:^(id returnData) {
        
    }];
    [_duihuanButton.titleLabel setFont:FONT(15)];
    _duihuanButton.layer.cornerRadius = 2;
    _duihuanButton.layer.borderWidth = 0.5;
    _duihuanButton.layer.borderColor = kDMPinkColor.CGColor;
    [_topView addSubview:_duihuanButton];
    
    [_topView drawSolidLineWithFrame:CGRectMake(0, _topView.bottom - 0.5, kScreenWidth, 0.5) color:kSeperatorColor];
    [self.view addSubview:_topView];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0,
                                                               AUTOSIZE(80),
                                                               self.view.width,
                                                               self.view.height - AUTOSIZE(80))
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
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }

}

#pragma mark -----------------request----------------

-(void)requestData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00rcG9UQkt1VlhaMmxWblE" forKey:@"token"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMUserCenterService getUserscoreWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self dataRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];

}

-(void)dataRequestSuccess:(id)returnData {
    NSDictionary *dic = (NSDictionary *)returnData;
    if ([dic isKindOfClass:[NSDictionary class]]) {
        _moneyLabel.text = dic[@"data"][@"sum"];
        _array = dic[@"data"][@"history"];
        [_tableView reloadData];
    }
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
    DMMyMoneyCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMMyMoneyCell"];
    if (!cell) {
        cell = [[DMMyMoneyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMMyMoneyCell"];
    }
    cell.moneyItem = [_array objectAt:indexPath.row];
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
    return AUTOSIZE(60);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *key = [_tableViewScetion objectAtIndex:indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        
    } else if (indexPath.row == 1) {
        
    } else if (indexPath.row == 2) {
        
    }
}
@end
