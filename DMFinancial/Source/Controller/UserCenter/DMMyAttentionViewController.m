//
//  DMMyAttentionViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/10.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMMyAttentionViewController.h"
#import "DMUserCenterService.h"
#import "DMExpertsOnlineCell.h"
#import "DMExperstsInfoViewController.h"
#import "DMRecordsViewController.h"

@interface DMMyAttentionViewController ()<UITableViewDataSource, UITableViewDelegate,DMExpertsOnlineCellDelegate>{
    UITableView *_tableView;
    NSMutableArray *_array;
}


@end

@implementation DMMyAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    _array = [[NSMutableArray alloc] init];
    [self createSubViews];
    [self requestData];

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
    [DMUserCenterService getUserlikeWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self dataRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
    
}

-(void)dataRequestSuccess:(NSArray *)returnData {
    if (!returnData) {
        return;
    }
    [_array removeAllObjects];
    [_array addObjectsFromArray:returnData];
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
    return _array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMExpertsOnlineCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMExpertsOnlineCell"];
    if (!cell) {
        cell = [[DMExpertsOnlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMExpertsOnlineCell"];
    }
    cell.myAttentionItem = [_array objectAt:indexPath.row];
    cell.delegate = self;
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
    return 108;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *key = [_tableViewScetion objectAtIndex:indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DMExperstsInfoViewController *controller = [[DMExperstsInfoViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.item = [_array objectAt:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];

}

@end
