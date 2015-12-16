//
//  DMMessageListViewController.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMMessageListViewController.h"
#import "DMMessageCell.h"
#import "DMMessageItem.h"

@interface DMMessageListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation DMMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    self.view.backgroundColor = kTableViewBgColor;
    [self createSubViews];
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < 10; i++) {
            DMMessageItem *item = [[DMMessageItem alloc] init];
            item.title = [NSString stringWithFormat:@"第%@条消息",@(i)];
            item.time = @"2015.11.30";
            item.contents = @"这是一条消息";
            item.isNewMessage = YES;
            [_dataArray addObject:item];
        }
    }
    return _dataArray;
}

-(void)createSubViews {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kTableViewBgColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[DMMessageCell class] forCellReuseIdentifier:@"DMMessageCell"];
    [self.view addSubview:_tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 108;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMMessageCell *cell =[tableView dequeueReusableCellWithIdentifier:@"DMMessageCell"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.item = [self.dataArray objectAt:indexPath.section];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //刷新列表 点击后的消息取消小红点
    DMMessageItem *item = [self.dataArray objectAt:indexPath.section];
    item.isNewMessage = NO;
    [_tableView reloadData];
}

@end
