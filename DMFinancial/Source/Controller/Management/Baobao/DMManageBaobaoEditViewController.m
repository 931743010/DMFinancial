//
//  DMManageBaobaoEditViewController.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/3.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMManageBaobaoEditViewController.h"
#import "DMInfoCell.h"
#import "DMManagementService.h"

@interface DMManageBaobaoEditViewController () <UITableViewDataSource, UITableViewDelegate, DMInfoCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DMManageBaobaoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleString;
    [self createSubViews];
}

#pragma mark-----------------私有方法-------------------

-(void)rightBarButtonAction {
    [self.view endEditing:NO];
//    [self requestData];
    [self dataRequestSuccess:nil];

}

-(void)requestData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"" forKey:@"number"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMManagementService serviceWithParameters:params success:^(id returnData) {
        [self hideLoadingView];
        [self dataRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
}

-(void)dataRequestSuccess:(id)returnData {
    //添加完成后发消息给管理首页刷新数据
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddAssetsNotification object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
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
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = [[UIView alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    
}

#pragma mark-----------------DMInfoCellDelegate-------------------


-(void)textChangeActionWithcell:(DMTableViewCell *)cell string:(NSString *)string {
    if (string.length == 0) {
        return;
    }
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
    DMInfoCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMInfoCell"];
    if (!cell) {
        cell = [[DMInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMInfoCell"];
    }
    
    cell.textLabel.text = @"金额";
    cell.showTextField = YES;
    
    cell.detailText = @"0";
    cell.textLabel.textColor = kDMDefaultBlackStringColor;
    cell.textLabel.font = FONT(15);
    cell.detailTextLabel.textColor = kDMDefaultGrayStringColor;
    cell.detailTextLabel.font = FONT(12);
    cell.delegate = self;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark----------------UITableViewDelegate---------------------

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, 40)];
    label.text = @"添加当前总金额后，会自动跟踪该笔资产的变化，但是如果有新的购买和赎回时，需要您及时修改";
    label.numberOfLines = 0;
    label.font = FONT(13);
    label.textColor = kDMDefaultGrayStringColor;
    [view addSubview:label];
    return view;
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
