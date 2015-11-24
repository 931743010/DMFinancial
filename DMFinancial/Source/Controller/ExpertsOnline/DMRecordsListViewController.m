//
//  DMRecordsListViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/31.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMRecordsListViewController.h"
#import "DMRecordsService.h"
#import "DMExpertsOnlineConsultCell.h"
#import "DMRecordsViewController.h"

@interface DMRecordsListViewController () <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *_arrayList;
    UITableView *_tableView;
    BOOL _isRefresh;
    NSInteger _pageCount;
    NSInteger _pageSize;
}

@end

@implementation DMRecordsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的咨询";
    _arrayList = [[NSMutableArray alloc] init];
    _isRefresh = YES;
    _pageCount = 1;
    _pageSize = 10;
    [self createSubViews];
    [self requsetRecordList];
    
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
    [self.view addSubview:_tableView];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    __weak __typeof (&*self)weakSelf = self;
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_refresh_arrow_down.png"]];
    
    [_tableView addPullToRefreshWithActionHandler:^{
        _isRefresh = YES;
        _pageCount = 1;
        [weakSelf requsetRecordList];
    } arrowView:arrowView];
    
    [_tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf requsetRecordList];
    }];

}

-(void)addWorkButonAction {
    
}
#pragma mark -----------requset--------------

-(void)requsetRecordList {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"list" forKey:@"action"];
    [params setSafetyObject:@"1" forKey:@"page"];
    [params setSafetyObject:@"10" forKey:@"size"];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00r" forKey:@"token"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMRecordsService getRecordListWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self getRecordListRequestSuccess:returnData];
        [_tableView.pullToRefreshView stopAnimating];
        [_tableView.infiniteScrollingView stopAnimating];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        _isRefresh = NO;
        [self showErrorViewWithText:[error localizedDescription]];
        [_tableView.pullToRefreshView stopAnimating];
        [_tableView.infiniteScrollingView stopAnimating];
    }];
    
}

#pragma mark-----------------dataRequestSuccess-------------------
-(void)getRecordListRequestSuccess:(NSArray *)returnData {
    if (!returnData) {
        return;
    }
    if (_isRefresh) {
        [_arrayList removeAllObjects];
        _isRefresh = NO;
    }
    if (returnData.count < 10) {
        _tableView.showsInfiniteScrolling = NO;
    } else {
        _tableView.showsInfiniteScrolling = YES;
    }

    [_arrayList addObjectsFromArray:returnData];
    [_tableView reloadData];
}

-(void)recordsWithSpid:(NSString *)spid {
    DMRecordsViewController *controller = [[DMRecordsViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.spid = spid;
    [self.navigationController pushViewController:controller animated:YES];
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
    DMExpertsOnlineConsultCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMExpertsOnlineConsultCell"];
    if (!cell) {
        cell = [[DMExpertsOnlineConsultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMExpertsOnlineConsultCell"];
    }
    
    cell.item = [_arrayList objectAt:indexPath.row];
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
    
    DMRecordsListItem *item = [_arrayList objectAt:indexPath.row];
    [self recordsWithSpid:[NSString stringWithFormat:@"%@",item.recordsId]];
}



@end
