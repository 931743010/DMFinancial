//
//  DMActivityViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/9.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMActivityViewController.h"
#import "DMInformationService.h"
#import "DMActivityCell.h"
#import "DMWebViewController.h"


@interface DMActivityViewController () <UITableViewDataSource, UITableViewDelegate,DMActivityCellDelegate>{
    UITableView *_tableView;
    UIView *_segmentedControlView;
    DMButton *_lingyuButton;//擅长领域
    DMButton *_paixuButton;//排序
    NSArray *_arrayList;

}

@end

@implementation DMActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯活动";
    [self createSegmentedControl];
    [self createSubViews];
    [self requestSplistData];
}

- (void)createSegmentedControl {
    _segmentedControlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    [_segmentedControlView drawSolidLineWithFrame:CGRectMake(0, 0, kScreenWidth, kSeperatorWidth) color:kSeperatorColor];
    _segmentedControlView.backgroundColor = [UIColor colorWithHexString:@"59afdf"];
    [self.view addSubview:_segmentedControlView];
    
    _lingyuButton = [[DMButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 44)];
    [_lingyuButton setTitle:@"行业报告" forState:UIControlStateNormal];
    [_lingyuButton.titleLabel setFont:FONT(15)];
    [_lingyuButton drawSolidLineWithFrame:CGRectMake(_lingyuButton.width - kSeperatorWidth, 0, kSeperatorWidth, _lingyuButton.height) color:[UIColor whiteColor]];
    UIImageView *lingyuIcon = [[UIImageView alloc] initWithFrame:CGRectMake(AUTOSIZE(125), (44 - 5)/2, 10, 5)];
    lingyuIcon.image = [UIImage imageWithResourcesPathCompontent:@"icon_list_down.png"];
    [_lingyuButton addSubview:lingyuIcon];
    [_lingyuButton buttonClickedcompletion:^(id returnData) {
        [_tableView reloadData];
        
    }];
    [_segmentedControlView addSubview:_lingyuButton];
    
    _paixuButton = [[DMButton alloc] initWithFrame:CGRectMake(_lingyuButton.right, 0, kScreenWidth/2, 44)];
    [_paixuButton setTitle:@"线下活动" forState:UIControlStateNormal];
    UIImageView *paixuIcon = [[UIImageView alloc] initWithFrame:CGRectMake(AUTOSIZE(125), (44 - 5)/2, 10, 5)];
    paixuIcon.image = [UIImage imageWithResourcesPathCompontent:@"icon_list_down.png"];
    [_paixuButton addSubview:paixuIcon];
    [_paixuButton.titleLabel setFont:FONT(15)];
    [_paixuButton drawSolidLineWithFrame:CGRectMake(_lingyuButton.width - kSeperatorWidth, 0, kSeperatorWidth, _lingyuButton.height) color:[UIColor whiteColor]];
    [_paixuButton buttonClickedcompletion:^(id returnData) {
        [_tableView reloadData];
    }];
    [_segmentedControlView addSubview:_paixuButton];
    
}

-(void)createSubViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0,
                                                               _segmentedControlView.bottom,
                                                               self.view.width,
                                                               self.view.height - _segmentedControlView.height)
                                              style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

#pragma mark -----------DMActivityCellDelegate--------------

-(void)selecedCellWithItem:(DMActivity *)activity {
    DMWebViewController *controller = [[DMWebViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.httpUrl = activity.url;
    controller.hiddenToolBar = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark -----------requset--------------

-(void)requestSplistData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"list" forKey:@"action"];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00r" forKey:@"token"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMInformationService getInformationListWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self getInformationListRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
    
}

#pragma mark-----------------dataRequestSuccess-------------------
- (void)getInformationListRequestSuccess:(NSArray *)returnData {
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
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMActivityCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMActivityCell"];
    if (!cell) {
        cell = [[DMActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMActivityCell"];
    }
    cell.delegate = self;
    cell.array = _arrayList;
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
    UITableViewCell * cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
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
