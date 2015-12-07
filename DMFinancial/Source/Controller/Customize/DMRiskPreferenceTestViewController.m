//
//  DMRiskPreferenceTestViewController.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/7.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMRiskPreferenceTestViewController.h"
#import "DMRiskPreferenceTestView.h"

@interface DMRiskPreferenceTestViewController ()<DMRiskPreferenceTestViewDelegate>

@property (nonatomic, strong) DMRiskPreferenceTestView *riskPreferenceTestView;
@property (nonatomic, strong) DMButton *nextButton;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, strong) NSMutableDictionary *selectedDic;
@end

@implementation DMRiskPreferenceTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"风险偏好测试";
    
    _currentIndex = 0;
    _selectedDic = [[NSMutableDictionary alloc] init];
    [self getModel];
    
    _riskPreferenceTestView = [[DMRiskPreferenceTestView alloc] initWithFrame:CGRectMake(20, 20, kScreenWidth - 40, 300)];
    _riskPreferenceTestView.item = [_modelArray objectAt:_currentIndex];
    _riskPreferenceTestView.delegate = self;
    [self.view addSubview:_riskPreferenceTestView];
    
    _nextButton = [[DMButton alloc] initWithFrame:CGRectMake(20, _riskPreferenceTestView.bottom + 20, _riskPreferenceTestView.width, 40)];
    _nextButton.backgroundColor = [UIColor blueColor];
    _nextButton.enabled = NO;
    [_nextButton setTitle:@"下一题" forState:UIControlStateNormal];
    [_nextButton buttonClickedcompletion:^(id returnData) {
        if ([_nextButton.titleLabel.text isEqualToString:@"完成"]) {
            [self doneText];
        } else {
            _currentIndex++;
            if (_currentIndex >= _modelArray.count-1) {
                [_nextButton setTitle:@"完成" forState:UIControlStateNormal];
            } else {
            }
            _riskPreferenceTestView.item = [_modelArray objectAt:_currentIndex];
            _nextButton.enabled = NO;
        }
    }];
    [self.view addSubview:_nextButton];
}

-(void)selectedAnswer:(NSInteger)index tag:(NSInteger)tag {
    _nextButton.enabled = YES;
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
    item1.index = @"1";
    
    DMRiskPreferenceTestItem *item2 = [[DMRiskPreferenceTestItem alloc] init];
    item2.question = @"2、您所供养的人数:( )";
    item2.answerList = @[@"A.未婚",@"B.双薪无子女",@"C.1-2人",@"D.3-4人",@"E.4人以上",];
    item2.index = @"2";

    DMRiskPreferenceTestItem *item3 = [[DMRiskPreferenceTestItem alloc] init];
    item3.question = @"3、您投资于有风险的投资品的经验如何:( )";
    item3.answerList = @[@"A.8年以上",@"B.4至8年",@"C.1至4年",@"D.1年以内",@"E.无",];
    item3.index = @"3";

    DMRiskPreferenceTestItem *item4 = [[DMRiskPreferenceTestItem alloc] init];
    item4.question = @"4、以下几种投资模式，您更偏好哪种模式:( )";
    item4.answerList = @[@"A.收益100%，但可能亏损 60%",@"B.收益50%，但可能亏损30%",@"C.收益是30%，但可能亏损15%",@"D.收益15%，但可能亏损5%",@"E.收益只有5%，但不亏损",];
    item4.index = @"4";

    DMRiskPreferenceTestItem *item5 = [[DMRiskPreferenceTestItem alloc] init];
    item5.question = @"5、假设您的某项投资突然亏损15%以上,你将:( )";
    item5.answerList = @[@"A.买入更多",@"B.等待反弹",@"C.卖掉一部分",@"D.全部卖掉",@"E.预设停损点",];
    item5.index = @"5";

    DMRiskPreferenceTestItem *item6 = [[DMRiskPreferenceTestItem alloc] init];
    item6.question = @"6、您的投资目标是什么:( )";
    item6.answerList = @[@"A.长期投资赚取高收益",@"B.短期投资赚取价差",@"C.保证每年有一定的现金收益",@"D.投资收益率只要能抵御通货膨胀就行",@"E.只要投资能够保本保息，即使低于通胀率也行",];
    item6.index = @"6";

    _modelArray = @[item1, item2, item3, item4, item5, item6];
}
@end
