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
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[DMMessageCell class] forCellReuseIdentifier:@"DMMessageCell"];
    [self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMMessageCell *cell =[tableView dequeueReusableCellWithIdentifier:@"DMMessageCell"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.item = [self.dataArray objectAt:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //刷新列表 点击后的消息取消小红点
    DMMessageItem *item = [self.dataArray objectAt:indexPath.row];
    item.isNewMessage = NO;
    [_tableView reloadData];
}

@end
