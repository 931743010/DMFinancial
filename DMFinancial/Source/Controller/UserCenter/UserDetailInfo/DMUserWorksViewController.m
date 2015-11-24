//
//  DMUserWorksViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/20.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMUserWorksViewController.h"
#import "DMUserCenterService.h"

@interface DMUserWorksViewController () <UITableViewDataSource, UITableViewDelegate>{
    UITableView *_tableView;
    NSArray *_arrayList;

}

@end

@implementation DMUserWorksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的工作经历";
    _arrayList = [[NSArray alloc] init];
    [self createSubViews];
    [self requestWorklistData];

}

-(void)createSubViews {
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
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AUTOSIZE(80))];
    
    DMButton *logout = [[DMButton alloc] initWithFrame:CGRectMake((kScreenWidth - AUTOSIZE(210))/2, footView.bottom - AUTOSIZE(45), AUTOSIZE(210), AUTOSIZE(45))];
    [logout.titleLabel setFont:BOLDFONT(21)];
    logout.layer.cornerRadius = AUTOSIZE(22);
    logout.layer.borderColor = kDMPinkColor.CGColor;
    logout.layer.borderWidth = 0.5;
    [logout setTitleColor:kDMPinkColor forState:UIControlStateNormal];
    [logout setTitle:@"增加工作经历" forState:UIControlStateNormal];
    [logout buttonClickedcompletion:^(id returnData) {
        [self addWorkButonAction];
    }];
    [footView addSubview:logout];
    [footView drawSolidLineWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5) color:kSeperatorColor];
    _tableView.tableFooterView = footView;
    [self.view addSubview:_tableView];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)addWorkButonAction {
    
}
#pragma mark -----------requset--------------

-(void)requestWorklistData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"getworklist" forKey:@"action"];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00r" forKey:@"token"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMUserCenterService getUserWorkWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self getUserWorkListRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
    
}

#pragma mark-----------------dataRequestSuccess-------------------
- (void)getUserWorkListRequestSuccess:(NSArray *)returnData {
    if (!returnData) {
        return;
    }
    _arrayList = returnData;
    [_tableView reloadData];
}

#pragma mark-----------------UITableViewDataSource-------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMExpertsOnlineCell"];
    if (!cell) {
        cell = [[DMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMExpertsOnlineCell"];
    }
    
    //    cell.myAttentionItem = [_array objectAt:indexPath.row];
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
    return 95;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *key = [_tableViewScetion objectAtIndex:indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //    DMExperstsInfoViewController *controller = [[DMExperstsInfoViewController alloc] init];
    //    controller.hidesBottomBarWhenPushed = YES;
    //    controller.item = [_array objectAt:indexPath.row];
    //    [self.navigationController pushViewController:controller animated:YES];
}


@end
