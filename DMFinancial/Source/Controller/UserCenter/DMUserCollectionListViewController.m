//
//  DMUserCollectionListViewController.m
//  DamaiIphone
//
//  Created by 陈作斌 on 13-12-31.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMUserCollectionListViewController.h"

static NSString * const ProjectItemCellKey = @"kProjectItemCellIdentifier";

@interface DMUserCollectionListViewController () <UITableViewDelegate> {
    UITableView                 *_tableView;
}

//@property (nonatomic, strong) DMPageDataInfo *pageData;
//@property (nonatomic, strong) DMCollectListDataSource *dataSource;
@property (nonatomic, strong) NSMutableArray *projects;
@property (nonatomic, assign) BOOL           isRefresh;

@end

@implementation DMUserCollectionListViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.title = NSLocalizedString(@"我的收藏", nil);
    self.view.backgroundColor = kTableViewBgColor;
    
//    self.pageData = [DMPageDataInfo defaultPageDataInfo];
//    [self initSubviews];
    [self showLoadingViewWithText:kLoadingText];
    self.isRefresh = YES;
//    [self requestProjectList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldRequsetData) name:@"shouldRequsetFavoriteData" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)descForUmeng {
    return NSLocalizedString(@"我的收藏", nil);
}

- (void)shouldRequsetData {
    self.isRefresh = YES;
//    [self requestProjectList];
}
//#pragma mark ========== Private Method ==========
//- (void)initSubviews {
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)
//                                                          style:UITableViewStylePlain];
//    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    tableView.dataSource = self.dataSource;
//    tableView.delegate = self;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.backgroundColor = kTableViewBgColor;
//    [self.view addSubview:tableView];
//    [tableView registerNib:[UINib nibWithNibName:@"DMProjectItemCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ProjectItemCellKey];
//    _tableView = tableView;
//    
//    __weak __typeof(&*self)weakSelf = self;
////    [_tableView addPullToRefreshWithActionHandler:^{
////        weakSelf.isRefresh = YES;
////        [weakSelf requestProjectList];
////    }];
//    
//    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_refresh_arrow_down.png"]];
//    [_tableView addPullToRefreshWithActionHandler:^{
//        weakSelf.isRefresh = YES;
//        [weakSelf requestProjectList];
//    } arrowView:arrowView];
//    
//    [tableView addInfiniteScrollingWithActionHandler:^{
//        weakSelf.isRefresh = NO;
//        [weakSelf requestProjectList];
//    }];
//}
//
//
//- (NSMutableArray *)projects {
//    if (_projects == nil) {
//        _projects = [NSMutableArray array];
//    }
//    return _projects;
//}
//
//- (void)requestProjectList {
//    if (self.isRefresh) {
//        self.pageData = [DMPageDataInfo defaultPageDataInfo];
//    } else {
//        self.pageData.pageNo+=1;
//    }
//
//    NSDictionary *params = @{@"p" : @(self.pageData.pageNo),
//                             @"ps" : @(self.pageData.size),
//                             @"loginKey" : [DMGlobalVar shareGlobalVar].currentUser.loginKey};
//    
//    [DMUserCollectionService serviceWithParameters:params
//                                           success:^(id returnData) {
//                                               [self hideLoadingView];
//                                               [self handleResponseData:returnData];
//                                               [_tableView.pullToRefreshView stopAnimating];
//                                               [_tableView.infiniteScrollingView stopAnimating];
//                                           } fail:^(NSError *error) {
//                                               [self hideLoadingView];
//                                              
//                                               [_tableView.pullToRefreshView stopAnimating];
//                                               [_tableView.infiniteScrollingView stopAnimating];
//                                               
//                                               if (self.projects.count<1)
//                                               {
//                                                   [_tableView showWaringViewWithText:kWaringOfFailure iconImageNamed:kWaringOfFailureIcon];
//                                               }
//                                               else
//                                               {
//                                                   [_tableView hideWaringView];
//                                               }
//                                               
//                                                [self showErrorViewWithText:[error localizedDescription]];
//                                           }];
//}
//
//- (void)handleResponseData:(id)data {
//    DMUserCollectionList *projectList = (DMUserCollectionList *)data;
//    NSArray *moreProjects = projectList.list;
//    self.pageData.totalCount = projectList.count;
//    //如果是刷新数据，则删除之前的数据
//    if (self.isRefresh) {
//        [self.projects removeAllObjects];
//    }
//    [self.projects addObjectsFromArray:moreProjects];
//    if (self.pageData.totalCount == 0) {
//        [self.view showWaringViewWithText:kWaringOfNoCollect];
//    } else {
//        [self.view hideWaringView];
//    }
//    [_tableView reloadData];
//    if (self.pageData.totalCount > [self.projects count]) {
//        _tableView.infiniteScrollingView.enabled = YES;
//        _tableView.showsInfiniteScrolling = YES;
//    } else {
//        _tableView.infiniteScrollingView.enabled = NO;
//        _tableView.showsInfiniteScrolling = NO;
//    }
//}
//-(void)delCollection:(NSInteger)pickId andIndex:(NSInteger)index
//{
//    NSMutableDictionary *params =[[NSMutableDictionary alloc]init];
//    [params setObject:[NSNumber numberWithInt:pickId] forKey:@"pkid"];
//    [params setObject:[DMGlobalVar shareGlobalVar].currentUser.loginKey forKey:@"loginKey"];
//    
//    [DMUserCollectionService delUserCollectionInfoWithParams:params success:^(id returnData) {
//        [self.projects removeObjectAtIndex:index];
//        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]]
//                          withRowAnimation:UITableViewRowAnimationFade];
//    } fail:^(NSError *error) {
//        [self hideLoadingView];
//        NSString *errorMsg = error.localizedDescription;
//        [self showErrorViewWithText:errorMsg];
//    }];
//}
//#pragma mark ========== UITableViewDelegate ==========
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    DMProjectListItem *item = self.projects[indexPath.row];
//    return [item heightForProjectItemCell] + 9;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    DMProjectListItem *item = nil;
//    NSInteger row = indexPath.row;
//    item = self.projects[row];
//    DMNewDetailViewController *controller = [[DMNewDetailViewController alloc] init];
//    controller.projectId = item.projectID;
//    controller.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:controller animated:YES];
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return NSLocalizedString(@"删除", nil);
//}

@end
