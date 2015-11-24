//
//  DMRecordsViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/23.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMRecordsViewController.h"
#import "DMRecordsService.h"
#import "DMExpertsReportViewController.h"
#import "DMChatMineCell.h"
#import "DMChatOtherCell.h"
#import "DMChatEnterView.h"
#import "DMRecords.h"
#import "UIView+JFLayout.h"

@interface DMRecordsViewController () <UITableViewDataSource, UITableViewDelegate,DMChatEnterViewDelegate>{
    UITableView *_tableView;
    NSString *_caseId;//咨询id
    NSMutableArray *_messageList;
    NSInteger _page;
}
@property (nonatomic, weak) NSLayoutConstraint *bottomConstraint;
@property (nonatomic, strong) DMChatEnterView *enterView;
@property (nonatomic, assign) NSInteger page;
@end

@implementation DMRecordsViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _messageList = [[NSMutableArray alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithResourcesPathCompontent:@"icon_experst_rightBarButton.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    
    [self createSubViews];
    [self requestLikeData];
    _page = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

#pragma mark - 监听键盘


- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect frame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 输入框上移
    self.bottomConstraint.constant = -CGRectGetHeight(frame);
    
    // 重新设置tableview的offset
    CGPoint offset = _tableView.contentOffset;
    offset.y += CGRectGetHeight(frame);
    
    // 在该应用每次启用时（不是从后台恢复到前台），会弹出几次键盘，造成offset.y累加
    // 如果offset.y超过了或等于contentSize的高度，那么需要减去键盘的高度
    if (offset.y >= _tableView.contentSize.height) {
        offset.y = _tableView.contentSize.height - CGRectGetHeight(frame);
    }
    
    [UIView animateWithDuration:duration animations:^{
        [_tableView setContentOffset:offset animated:NO];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.bottomConstraint.constant = 0;
    NSDictionary *userInfo = notification.userInfo;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        [self.enterView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.enterView.textView.text.length == 0) {
            self.enterView.placeholderLabel.hidden = NO;
        }
    }];
}

#pragma mark -------------createSubViews----------

- (void)createSubViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0,
                                                               0,
                                                               self.view.width,
                                                               self.view.height - 50)
                                              style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"fffce9"];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:_tableView];
    [_tableView jf_pinEdgesToSuperviewWithInsets:UIEdgeInsetsZero exclude:JFEdgeBottom];

    __weak typeof(self) weakself = self;
    [_tableView addPullToRefreshWithActionHandler:^{
        weakself.page ++;
        [weakself requestGetmsgData];
    }];
    
    _enterView = [[DMChatEnterView alloc] initWithFrame:CGRectZero];
    _enterView.delegate = self;
    [self.view addSubview:_enterView];
    
    [_enterView jf_pinEdgeToSuperviewEdge:JFEdgeLeft withInset:0];
    [_enterView jf_pinEdgeToSuperviewEdge:JFEdgeRight withInset:0];
    self.bottomConstraint = [_enterView jf_pinEdgeToSuperviewEdge:JFEdgeBottom withInset:0];
    
    [_tableView jf_pinEdge:JFEdgeBottom toEdge:JFEdgeTop ofView:_enterView];
    [_tableView jf_pinEdgeToSuperviewEdge:JFEdgeLeft withInset:0];
    [_tableView jf_pinEdgeToSuperviewEdge:JFEdgeRight withInset:0];
    [_tableView jf_pinEdgeToSuperviewEdge:JFEdgeTop withInset:0];
}


-(void)rightBarButtonAction {
    DMExpertsReportViewController *controller = [[DMExpertsReportViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.item = self.item;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)enterView:(DMChatEnterView *)enterView sendText:(NSString *)text
{
    NSLog(@"将要发送的消息: %@", text);
    [self sendMessage:text];
}

#pragma mark -----------requset--------------
-(void)sendMessage:(NSString *)text {

}
-(void)requestLikeData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"getcaseid" forKey:@"action"];
    [params setSafetyObject:self.spid forKey:@"spid"];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00r" forKey:@"token"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMRecordsService getRecordIdWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        NSDictionary *dic = (NSDictionary *)returnData;
        NSString *string = dic[@"data"][@"caseid"];
        if (string.length > 0) {
            _caseId = string;
            [self requestGetmsgData];
        }
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
}

-(void)requestGetmsgData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"getmsg" forKey:@"action"];
    [params setSafetyObject:_caseId forKey:@"caseid"];
    [params setSafetyObject:[NSNumber numberWithInteger:_page] forKey:@"page"];
    [params setSafetyObject:@"10" forKey:@"size"];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00r" forKey:@"token"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMRecordsService getHistoryWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [_tableView.pullToRefreshView stopAnimating];
        [self splistDataRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [_tableView.pullToRefreshView stopAnimating];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
    
}

#pragma mark-----------------dataRequestSuccess-------------------
- (void)splistDataRequestSuccess:(NSArray *)returnData {
    if (!returnData) {
        return;
    }
    for (id obj in returnData) {
        [_messageList insertObject:obj atIndex:0];
    }
    //    [_messageList addObjectsFromArray:returnData];
    [_tableView reloadData];
}


#pragma mark-----------------UITableViewDataSource-------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messageList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMRecords *item = [_messageList objectAt:indexPath.row];
    
    if ([item.type isEqualToString:@"0"]) {
        
        DMChatMineCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMChatMineCell"];
        if (!cell) {
            cell = [[DMChatMineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DMChatMineCell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell blindModel:item loadImage:YES previousDate:nil];
        
        return cell;
        
    } else if ([item.type isEqualToString:@"1"]) {
        DMChatOtherCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMChatOtherCell"];
        if (!cell) {
            cell = [[DMChatOtherCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DMChatOtherCell"];
        }
        
        [cell blindModel:item loadImage:YES previousDate:nil];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        
        return cell;
        
    } else {
        DMTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMTableViewCell"];
        if (!cell) {
            cell = [[DMTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DMTableViewCell"];
        }
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
    return AUTOSIZE(50);
}

@end
