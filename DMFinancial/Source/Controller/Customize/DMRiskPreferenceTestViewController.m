//
//  DMRiskPreferenceTestViewController.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/7.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMRiskPreferenceTestViewController.h"
#import "DMRiskPreferenceTestView.h"
#import "DMPageBottomButtonView.h"
#import "DMRiskPreferenceTestResultViewController.h"

@interface DMRiskPreferenceTestViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) DMRiskPreferenceTestView *riskPreferenceTestView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, strong) NSMutableDictionary *selectedDic;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DMRiskPreferenceTestViewController

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"testAgain" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"风险偏好测试";
    
    _currentIndex = 0;
    _selectedDic = [[NSMutableDictionary alloc] init];
    [self createSubViews];
    [self getModel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testAgain) name:@"testAgain" object:nil];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.height - DMPageBottomButtonViewHeight);
}

-(void)testAgain {
    for (DMRiskPreferenceTestItem *item in self.modelArray) {
        item.selectedAnswer = @"";
    }
    if (_tableView) {
        [_tableView scrollRectToVisible:CGRectMake(0, 0, _tableView.width, _tableView.height) animated:NO];
        [_tableView reloadData];
    }
}

-(void)createSubViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - DMPageBottomButtonViewHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kTableViewBgColor;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:_tableView];
    DMPageBottomButtonView *_bottomButtonView = [[DMPageBottomButtonView alloc] initWithFrame:CGRectMake(0, self.view.height - DMPageBottomButtonViewHeight, self.view.width, DMPageBottomButtonViewHeight)];
    
    _bottomButtonView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    [_bottomButtonView buttonClickedcompletion:^(id returnData) {
        [self requestData];
    }];
    [_bottomButtonView setButtonTitles:@[@"完成提交"] buttonBackgroundColors:@[kDMPinkColor]];
    [self.view addSubview:_bottomButtonView];
}

#pragma mark ------------request--------------

-(void)requestData {
    DMRiskPreferenceTestResultViewController *controller = [[DMRiskPreferenceTestResultViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DMRiskPreferenceTestItem *item = [self.modelArray objectAt:section];

    DMTableViewHeaderView *view = [[DMTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    view.title = item.question;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.modelArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DMRiskPreferenceTestItem *item = [self.modelArray objectAt:section];

    return item.answerList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.backgroundColor = [UIColor whiteColor];
    DMRiskPreferenceTestItem *item = [self.modelArray objectAt:indexPath.section];
    cell.textLabel.text = [item.answerList objectAt:indexPath.row];
    if ([cell.textLabel.text isEqualToString:item.selectedAnswer]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.backgroundColor = [UIColor redColor];
        cell.accessoryView = imageView;
        
    } else {
        cell.accessoryView = nil;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DMRiskPreferenceTestItem *item = [self.modelArray objectAt:indexPath.section];
    item.selectedAnswer = [item.answerList objectAt:indexPath.row];
    [_tableView reloadData];
}


-(void)selectedAnswer:(NSInteger)index tag:(NSInteger)tag {
    [_selectedDic setSafetyObject:[NSString stringWithFormat:@"%@",@(index)] forKey:[NSString stringWithFormat:@"%@",@(tag)]];
}

-(void)doneText {
    DMLOG(@"%@",_selectedDic);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getModel {
    DMRiskPreferenceTestItem *item1 = [[DMRiskPreferenceTestItem alloc] init];
    item1.question = @"1、您的年龄是:( )";
    item1.answerList = @[@"A.30岁以下",@"B.30岁至39岁",@"C.40岁至49岁",@"D.50岁至59岁",@"E.60岁以上",];
    
    DMRiskPreferenceTestItem *item2 = [[DMRiskPreferenceTestItem alloc] init];
    item2.question = @"2、您所供养的人数:( )";
    item2.answerList = @[@"A.未婚",@"B.双薪无子女",@"C.1-2人",@"D.3-4人",@"E.4人以上",];

    DMRiskPreferenceTestItem *item3 = [[DMRiskPreferenceTestItem alloc] init];
    item3.question = @"3、您投资于有风险的投资品的经验如何:( )";
    item3.answerList = @[@"A.8年以上",@"B.4至8年",@"C.1至4年",@"D.1年以内",@"E.无",];

    DMRiskPreferenceTestItem *item4 = [[DMRiskPreferenceTestItem alloc] init];
    item4.question = @"4、以下几种投资模式，您更偏好哪种模式:( )";
    item4.answerList = @[@"A.收益100%，但可能亏损 60%",@"B.收益50%，但可能亏损30%",@"C.收益是30%，但可能亏损15%",@"D.收益15%，但可能亏损5%",@"E.收益只有5%，但不亏损",];

    DMRiskPreferenceTestItem *item5 = [[DMRiskPreferenceTestItem alloc] init];
    item5.question = @"5、假设您的某项投资突然亏损15%以上,你将:( )";
    item5.answerList = @[@"A.买入更多",@"B.等待反弹",@"C.卖掉一部分",@"D.全部卖掉",@"E.预设停损点",];

    DMRiskPreferenceTestItem *item6 = [[DMRiskPreferenceTestItem alloc] init];
    item6.question = @"6、您的投资目标是什么:( )";
    item6.answerList = @[@"A.长期投资赚取高收益",@"B.短期投资赚取价差",@"C.保证每年有一定的现金收益",@"D.投资收益率只要能抵御通货膨胀就行",@"E.只要投资能够保本保息，即使低于通胀率也行",];

    _modelArray = @[item1, item2, item3, item4, item5, item6];
}
@end
