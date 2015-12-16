//
//  DMRiskPreferenceTestResultViewController.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/15.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMRiskPreferenceTestResultViewController.h"
#import "DMPageBottomButtonView.h"
#import "DMRiskPreferenceTestView.h"
@interface DMRiskPreferenceTestResultViewController ()

@end

@implementation DMRiskPreferenceTestResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"风险测评";
    [self createSubViews];
}

-(void)createSubViews {
    DMRiskPreferenceTestView *view = [[DMRiskPreferenceTestView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 300)];
    view.backgroundColor = kDMPinkColor;
    [self.view addSubview:view];
    
    DMPageBottomButtonView *_bottomButtonView = [[DMPageBottomButtonView alloc] initWithFrame:CGRectMake(0, self.view.height - DMPageBottomButtonViewHeight, self.view.width, DMPageBottomButtonViewHeight)];
    
    _bottomButtonView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    [_bottomButtonView buttonClickedcompletion:^(id returnData) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"testAgain" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [_bottomButtonView setButtonTitles:@[@"重新测试"] buttonBackgroundColors:@[kDMPinkColor]];
    [self.view addSubview:_bottomButtonView];
    

}

- (void)backButtonAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
