//
//  DMCustomizeViewController.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/6.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMCustomizeViewController.h"
#import "DMCustomizeSliderView.h"
#import "DMProjectListCell.h"
#import "DMRiskPreferenceTestViewController.h"

@interface DMCustomizeViewController () <UITableViewDataSource, UITableViewDelegate, DMCustomizeSliderViewDelegate> {
    NSArray *_options;
    NSArray *_optionsTitle;
    NSMutableDictionary *_selectOptionDic;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UIView *optionsView;
@end

@implementation DMCustomizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"量身定制";
    _selectOptionDic = [[NSMutableDictionary alloc] init];
    _options = @[@[@"不限", @"5万", @"10万", @"20万", @"30万", @"50万以上"],@[@"不限", @"1个月", @"3个月", @"半年", @"1年", @"2年以上"],@[@"不限", @"3%", @"5%", @"10%", @"15%", @"20%以上"],@[@"不限", @"保守型", @"稳健型", @"平衡型", @"积极型", @"进取型"],];
    _optionsTitle = @[@"投资金额:", @"投资期限:", @"预期收益:", @"风险偏好:"];
    [self getListData];
    [self createSubViews];
}

-(void)selectedOption:(NSString *)option index:(NSInteger)index {
    [_selectOptionDic setSafetyObject:option forKey:[NSString stringWithFormat:@"%@",@(index)]];
    
    DMLOG(@"%@",_selectOptionDic);
}

#pragma mark-----------------私有方法-------------------

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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    [_tableView registerClass:[DMProjectListCell class] forCellReuseIdentifier:@"DMProjectListCell"];
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = [[UIView alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    
    _optionsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    _optionsView.backgroundColor = kDMPinkColor;
    CGFloat top = 10;
    for (NSUInteger i = 0; i < 4; i++) {
        DMCustomizeSliderView *view = [[DMCustomizeSliderView alloc] initWithFrame:CGRectMake(70 - 10, top, kScreenWidth - 70, 50)];
        view.delegate = self;
        view.optionsArray = [_options objectAt:i];
        [_optionsView addSubview:view];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, top, 60, 20)];
        label.textColor = [UIColor whiteColor];
        label.text = [_optionsTitle objectAt:i];
        label.font = FONT(12);
        [_optionsView addSubview:label];

        top += view.height + 5;
    }
    _optionsView.height = top;
    _tableView.tableHeaderView = _optionsView;
}

-(void)rightBarButtonAction {
    DMRiskPreferenceTestViewController *controller = [[DMRiskPreferenceTestViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark-----------------request-------------------

-(void)requestData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"" forKey:@"number"];
    [self showLoadingViewWithText:kLoadingText];
//    [DMManagementService serviceWithParameters:params success:^(id returnData) {
//        [self hideLoadingView];
//        [self dataRequestSuccess:returnData];
//    } fail:^(NSError *error) {
//        [self hideLoadingView];
//        [self showErrorViewWithText:[error localizedDescription]];
//    }];
}

-(void)getListData {
    _listArray = [[NSMutableArray alloc] init];
    [_listArray removeAllObjects];
    NSArray *title = [[NSArray alloc] initWithObjects:@"热门", @"P2P", @"宝宝", @"基金", @"银行理财", @"保险", nil];
    
    for (NSString *string in title) {
        DMProjectListItem *category = [[DMProjectListItem alloc] init];
        category.name = string;
        category.yield = @"4%";
        category.url = @"http://img0.imgtn.bdimg.com/it/u=1070902365,2619384777&fm=21&gp=0.jpg";
        [_listArray addObject:category];
    }
    
}

-(void)dataRequestSuccess:(id)returnData {
    [self getListData];
}

#pragma mark-----------------UITableViewDataSource-------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMProjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMProjectListCell"];
    cell.item = [self.listArray objectAt:indexPath.row];
    return cell;
}

#pragma mark----------------UITableViewDelegate---------------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
