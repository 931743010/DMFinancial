//
//  DMJijinDetailViewController.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/9.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMJijinDetailViewController.h"
#import "DMDetailTopView.h"
#import "DMManagementService.h"
#import "DMDetailPageCell.h"
#import "DMWebViewController.h"
#import "DMPageBottomButtonView.h"
#import "DMJijinDetailChartsCell.h"

@interface DMJijinDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DMDetailTopView *detailTopView;
@end

@implementation DMJijinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _detailTopView = [[DMDetailTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kDetailTopViewHight)];
    _detailTopView.item = self.item;
    
    
    self.title = self.item.name;
    [self createSubViews];
    DMPageBottomButtonView *_bottomButtonView = [[DMPageBottomButtonView alloc] initWithFrame:CGRectMake(0, self.view.height - DMPageBottomButtonViewHeight, self.view.width, DMPageBottomButtonViewHeight)];
    
    _bottomButtonView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    __weak typeof(&*self) weakSelf = self;
    [_bottomButtonView buttonClickedcompletion:^(id returnData) {
        DMWebViewController *controller = [[DMWebViewController alloc] init];
        controller.httpUrl = @"http://www.damai.cn";
        [weakSelf.navigationController pushViewController:controller animated:YES];
    }];
    [_bottomButtonView setButtonTitles:@[@"购买方式"] buttonBackgroundColors:nil];
    [self.view addSubview:_bottomButtonView];
    
}

- (void)createSubViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0,
                                                               0,
                                                               self.view.width,
                                                               self.view.height - DMPageBottomButtonViewHeight)
                                              style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableView setSeparatorColor:kSeperatorColor];
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[DMJijinDetailChartsCell class] forCellReuseIdentifier:@"DMJijinDetailChartsCell"];
    [_tableView registerClass:[DMDetailPageCell class] forCellReuseIdentifier:@"DMDetailPageCell"];

    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _tableView.tableHeaderView = _detailTopView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    
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

#pragma mark-----------------DMInfoCellDelegate-------------------


-(void)textChangeActionWithcell:(DMTableViewCell *)cell string:(NSString *)string {
    if (string.length == 0) {
        return;
    }
}


#pragma mark-----------------UITableViewDataSource-------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 5;
            break;
        case 3:
            return 1;
            break;

        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        DMJijinDetailChartsCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMJijinDetailChartsCell"];
        cell.item = @"";
        return cell;
    }
    DMDetailPageCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMDetailPageCell"];
    
    cell.textLabel.textColor = kDMDefaultBlackStringColor;
    cell.textLabel.font = FONT(13);
    cell.detailTextLabel.textColor = kDMDefaultGrayStringColor;
    cell.detailTextLabel.font = FONT(12);
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"收费方式";
                cell.detailTextLabel.text = @"红岭创投";
                break;
            case 1:
                cell.textLabel.text = @"起购金额";
                cell.detailTextLabel.text = @"按月等额";
                break;
            case 2:
                cell.textLabel.text = @"赎回到账时间";
                cell.detailTextLabel.text = @"500";
                break;
            case 3:
                cell.textLabel.text = @"最低赎回份额";
                cell.detailTextLabel.text = @"500";
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"基金规模";
                cell.detailTextLabel.text = @"红岭创投";
                break;
            case 1:
                cell.textLabel.text = @"成立时间";
                cell.detailTextLabel.text = @"按月等额";
                break;
            case 2:
                cell.textLabel.text = @"资产配置";
                cell.detailTextLabel.text = @"500";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 3:
                cell.textLabel.text = @"基金经理";
                cell.detailTextLabel.text = @"500";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 4:
                cell.textLabel.text = @"基金公司";
                cell.detailTextLabel.text = @"500";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
                
            default:
                break;
        }
    } else {
        cell.textLabel.text = @"金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额额金额金额金额金额金额金额金额金额金额金额金额金额金额";
        cell.textLabel.numberOfLines = 0;
    }
    
    return cell;
}

#pragma mark----------------UITableViewDelegate---------------------

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return kTableViewHeaderViewHight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DMTableViewHeaderView *view = [[DMTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeaderViewHight)];
    if (section == 1) {
        view.title = @"买入须知";
    } else if (section == 2) {
        view.title = @"基金档案";
    } else if (section == 3) {
        view.title = @"理财师点评";
    } else {
        view.title = @"";
    }
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 380;
    }
    if (indexPath.section == 3) {
        NSString *content = @"金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额额金额金额金额金额金额金额金额金额金额金额金额金额金额金额金额额金额金额金额金额金额金额金额金额金额金额金额金额金额";
        CGSize size = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 111111) options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: FONT(13)} context:nil].size;
        
        return ceil(size.height) + AUTOSIZE(11.5*2);
        
    }
    return AUTOSIZE(50);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 0) {
        DMWebViewController *controller = [[DMWebViewController alloc] init];
        controller.httpUrl = @"http://www.damai.cn";
        [self.navigationController pushViewController:controller animated:YES];
    }
}@end
