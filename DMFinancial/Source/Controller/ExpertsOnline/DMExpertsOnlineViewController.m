//
//  DMExpertsOnlineViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/9.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMExpertsOnlineViewController.h"
#import "DMExpertsOnlineCell.h"
#import "DMExpertsOnlineConsultCell.h"
#import "DMChooseCategoryView.h"
#import "DMExperstsInfoViewController.h"
#import "DMSplistService.h"
#import "DMRecordsService.h"
#import "DMRecordsViewController.h"
#import "DMRecordsListViewController.h"

@interface DMExpertsOnlineViewController ()<UITableViewDataSource, UITableViewDelegate, DMChooseCategoryViewDelegate, DMExpertsOnlineCellDelegate>{
    UITableView *_tableView;
    NSMutableArray *_array;
    UIView *_segmentedControlView;
    DMButton *_lingyuButton;//擅长领域
    DMButton *_paixuButton;//排序
    DMButton *_zixunButton;//我的咨询
    DMChooseCategoryView *_lingyuCategoryView;
    DMChooseCategoryView *_paixuCategoryView;
    NSInteger _sort;//排序方式
    NSArray *_goodsList;//分类列表
    NSMutableArray *_recordList;//我的咨询列表
}

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) BOOL isRefresh;
@end

@implementation DMExpertsOnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectIndex = 1;
    _isRefresh = NO;
    _sort = [[CommonHelper valueForKey:@"sort"] integerValue];
    self.title = @"专家在线";
    _array = [[NSMutableArray alloc] init];
    _goodsList = [[NSArray alloc] init];
    _recordList = [[NSMutableArray alloc] init];

    [self createSegmentedControl];
    [self createSubViews];
    [self requestSplistData];
    [self getGoodsListData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithResourcesPathCompontent:@"icon_experst_rightBarButton.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];

}

- (void)createSegmentedControl {
    _segmentedControlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    [_segmentedControlView drawSolidLineWithFrame:CGRectMake(0, 0, kScreenWidth, kSeperatorWidth) color:kSeperatorColor];
    _segmentedControlView.backgroundColor = [UIColor colorWithHexString:@"59afdf"];
    [self.view addSubview:_segmentedControlView];
    
    _lingyuButton = [[DMButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 44)];
    [_lingyuButton setTitle:@"擅长领域" forState:UIControlStateNormal];
    [_lingyuButton.titleLabel setFont:FONT(15)];
    [_lingyuButton drawSolidLineWithFrame:CGRectMake(_lingyuButton.width - kSeperatorWidth, 0, kSeperatorWidth, _lingyuButton.height) color:[UIColor whiteColor]];
    UIImageView *lingyuIcon = [[UIImageView alloc] initWithFrame:CGRectMake(AUTOSIZE(130), (44 - 5)/2, 10, 5)];
    lingyuIcon.image = [UIImage imageWithResourcesPathCompontent:@"icon_list_down.png"];
    [_lingyuButton addSubview:lingyuIcon];
    [_lingyuButton buttonClickedcompletion:^(id returnData) {
        [self showLingyuCategoryView];
        self.selectIndex = 1;
        [_tableView reloadData];

    }];
    [_segmentedControlView addSubview:_lingyuButton];
    
    _paixuButton = [[DMButton alloc] initWithFrame:CGRectMake(_lingyuButton.right, 0, kScreenWidth/2, 44)];
    [_paixuButton setTitle:@"排序" forState:UIControlStateNormal];
    UIImageView *paixuIcon = [[UIImageView alloc] initWithFrame:CGRectMake(AUTOSIZE(120), (44 - 5)/2, 10, 5)];
    paixuIcon.image = [UIImage imageWithResourcesPathCompontent:@"icon_list_down.png"];
    [_paixuButton addSubview:paixuIcon];
    [_paixuButton.titleLabel setFont:FONT(15)];
    [_paixuButton drawSolidLineWithFrame:CGRectMake(_lingyuButton.width - kSeperatorWidth, 0, kSeperatorWidth, _lingyuButton.height) color:[UIColor whiteColor]];
    [_paixuButton buttonClickedcompletion:^(id returnData) {
        
        if (self.selectIndex != 1) {
            
        } else {
        
        }
        [self showPaixuCategoryView];
        self.selectIndex = 1;
        [_tableView reloadData];

    }];
    [_segmentedControlView addSubview:_paixuButton];


    
}

- (void)createSubViews {
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


-(void)rightBarButtonAction {
    DMRecordsListViewController *controller = [[DMRecordsListViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];

}

- (void)showLingyuCategoryView {
    if (!_lingyuCategoryView) {
        _lingyuCategoryView = [[DMChooseCategoryView alloc] initWithWindow:[UIApplication sharedApplication].keyWindow columnCount:2];
    }
    _lingyuCategoryView.hasDoneButton = YES;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (DMGoodsItem *item in _goodsList) {
        [array addObject:item.goods];
    }
    _lingyuCategoryView.categoryArray = array;
    _lingyuCategoryView.selectCategoryArray = [CommonHelper valueForKey:@"selectedGoods"];
    [_lingyuCategoryView.doneButton buttonClickedcompletion:^(id returnData) {
        [_lingyuCategoryView removeFromSuperview];
        

        [CommonHelper setValue:_lingyuCategoryView.selectCategoryArray forKey:@"selectedGoods"];
        
        NSMutableArray *array = [NSMutableArray new];
        for (NSString *string in [CommonHelper valueForKey:@"selectedGoods"]) {
            for (DMGoodsItem *item in _goodsList) {
                if ([string isEqualToString:item.goods]) {
                    [array addObject:item.goodsId];
                }
            }
        }
        [CommonHelper setValue:array forKey:@"selectedGoodsId"];

        [self requestSplistData];
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_lingyuCategoryView];
}

- (void)showPaixuCategoryView {
    if (!_paixuCategoryView) {
        _paixuCategoryView = [[DMChooseCategoryView alloc] initWithWindow:[UIApplication sharedApplication].keyWindow columnCount:1];
    }
    _paixuCategoryView.delegate = self;
    [_paixuCategoryView.doneButton buttonClickedcompletion:^(id returnData) {
        [_paixuCategoryView removeFromSuperview];
        [self requestSplistData];
    }];
    NSArray *array = @[@"默认排序",@"级别由高到低",@"由空闲到忙碌"];

    _paixuCategoryView.categoryArray = array;
    _paixuCategoryView.selectCategoryArray = @[[NSString stringWithFormat:@"%@",[array objectAt:_sort]]];

    [[UIApplication sharedApplication].keyWindow addSubview:_paixuCategoryView];

}

#pragma mark -----------delegate--------------

-(void)recordsWithSpid:(NSString *)spid {
    DMRecordsViewController *controller = [[DMRecordsViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.spid = spid;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)selectedActionWithCategoryName:(NSString *)categoryName {
    [_paixuCategoryView removeFromSuperview];

    if (!categoryName) {
        return;
    }
    if ([categoryName isEqualToString:[_paixuCategoryView.categoryArray objectAt:0]]) {
        _sort = 0;
    } else if ([categoryName isEqualToString:[_paixuCategoryView.categoryArray objectAt:1]]) {
        _sort = 1;
    } else if ([categoryName isEqualToString:[_paixuCategoryView.categoryArray objectAt:2]]) {
        _sort = 2;
    } else {
        _sort = 0;
    }
    [CommonHelper setValue:@(_sort) forKey:@"sort"];
}

#pragma mark -----------requset--------------

-(void)getGoodsListData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"getgoodslist" forKey:@"action"];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00r" forKey:@"token"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMSplistService getGoodsListWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self getGoodsListRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];

}
-(void)requestSplistData {
    NSString *field = [[CommonHelper valueForKey:@"selectedGoodsId"] componentsJoinedByString:@","];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"getsplist" forKey:@"action"];
    [params setSafetyObject:field forKey:@"field"];
    [params setSafetyObject:@(_sort) forKey:@"sort"];
    [params setSafetyObject:@"1" forKey:@"page"];
    [params setSafetyObject:@"10" forKey:@"size"];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00r" forKey:@"token"];

    [self showLoadingViewWithText:kLoadingText];
    [DMSplistService getSplistListWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self splistDataRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];

}

-(void)requsetRecordList {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"list" forKey:@"action"];
    [params setSafetyObject:@(_sort) forKey:@"sort"];
    [params setSafetyObject:@"1" forKey:@"page"];
    [params setSafetyObject:@"10" forKey:@"size"];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00r" forKey:@"token"];

    [self showLoadingViewWithText:kLoadingText];
    [DMRecordsService getRecordListWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self getRecordListRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];

}
#pragma mark-----------------dataRequestSuccess-------------------

-(void)getGoodsListRequestSuccess:(NSArray *)returnData {
    _goodsList = returnData;
}

- (void)splistDataRequestSuccess:(NSArray *)returnData {
    if (!returnData) {
        return;
    }
    if (_isRefresh) {
        [_array removeAllObjects];
        _isRefresh = NO;
    }
    [_array addObjectsFromArray:returnData];
    [_tableView reloadData];
}

-(void)getRecordListRequestSuccess:(NSArray *)returnData {
    if (!returnData) {
        return;
    }
    if (_isRefresh) {
        [_recordList removeAllObjects];
        _isRefresh = NO;
    }
    [_recordList addObjectsFromArray:returnData];
    [_tableView reloadData];

}


#pragma mark-----------------UITableViewDataSource-------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_selectIndex == 1) {
        return _array.count;
    }
    return _recordList.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectIndex == 1) {
        DMExpertsOnlineCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMExpertsOnlineCell"];
        if (!cell) {
            cell = [[DMExpertsOnlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMExpertsOnlineCell"];
        }
        cell.delegate = self;
        cell.myAttentionItem = [_array objectAt:indexPath.row];
        return cell;
    } else {
        DMExpertsOnlineConsultCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMExpertsOnlineConsultCell"];
        if (!cell) {
            cell = [[DMExpertsOnlineConsultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMExpertsOnlineConsultCell"];
        }
        
        cell.item = [_recordList objectAt:indexPath.row];
        return cell;
    }
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
    if (_selectIndex == 1) {
        return 108;
    } else {
        return 95;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *key = [_tableViewScetion objectAtIndex:indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_selectIndex == 1) {
        DMExperstsInfoViewController *controller = [[DMExperstsInfoViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        controller.item = [_array objectAt:indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        DMRecordsListItem *item = [_recordList objectAt:indexPath.row];
        [self recordsWithSpid:[NSString stringWithFormat:@"%@",item.recordsId]];
    }
}

@end
