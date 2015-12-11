//
//  DMIndexPageViewController.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/24.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMIndexPageViewController.h"
#import "JFSwipeView.h"
#import "DMFindPageView.h"
#import "DMDiscoveryCategory.h"
#import "DMDiscoveryFilterActivityOrder.h"
#import "DMDiscoveryFilterTime.h"
#import "DMProjectListCell.h"
#import "DMBannerCell.h"
#import "DMIndexPageMenuCell.h"

#import "DMMessageListViewController.h"
#import "DMNewcomerViewController.h"
#import "DMYangmaoViewController.h"
#import "DMP2PViewController.h"
#import "DMHotListViewController.h"
#import "DMP2PDetailViewController.h"
#import "DMSearchViewController.h"

#import "DMIndexPageService.h"
#import "DMPageState.h"
typedef NS_ENUM(NSUInteger, DMIndexSwipeViewType) {
    DMIndexSwipeViewTypeHeader,
    DMIndexSwipeViewTypeBody
};
@interface DMIndexPageViewController ()<JFSwipeViewDataSource, JFSwipeViewSwipeDelegate, UITableViewDataSource, UITableViewDelegate, DMBannerCellDelegate, DMIndexPageMenuCellDelegate> {
    NSTimeInterval _expiredTime;

}

@property (strong, nonatomic) JFSwipeView *categoryHeaderView;

@property (strong, nonatomic) JFSwipeView *categoryContentView;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSArray *states;

@end

@implementation DMIndexPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"值得买";
    _expiredTime = 60 * 30;

    _listArray = [[NSMutableArray alloc] init];

    [self.view addSubview:self.categoryContentView];
    [self.view addSubview:self.categoryHeaderView];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"index_search_white.png"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"消息" style:UIBarButtonItemStylePlain target:self action:@selector(messageAction)];

}


-(void)searchAction {
    DMSearchViewController *controller = [[DMSearchViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];

}

-(void)messageAction {
    DMMessageListViewController *controller = [[DMMessageListViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)refreshProjectsData:(BOOL)refresh {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"" forKey:@"1"];
    [self showLoadingViewWithText:kLoadingText];
    
    __block DMIndexPageViewController * weakSelf = self;

    [DMIndexPageService getProjectLibListWithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self dataRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
        DMFindPageView *pageView = (DMFindPageView *)[weakSelf.categoryContentView currentItemView];
        [pageView cancelRequest];

    }];

}

-(void)dataRequestSuccess:(id)returnData {
    DMFindPageView *pageView = (DMFindPageView *)[self.categoryContentView currentItemView];
    [pageView cancelRequest];

}
- (NSDictionary *)createParametersWithCategory:(DMDiscoveryCategory *)category
                                      pageInfo:(DMPageDataInfo *)pageInfo
{
    NSMutableDictionary *infos = [NSMutableDictionary new];
    
    [infos setSafetyObject:category.categoryId forKey:@"cateid"];
    [infos setSafetyObject:@(pageInfo.pageNo) forKey:@"pindex"];
    [infos setSafetyObject:@(pageInfo.size) forKey:@"psize"];
    
    return infos;
}

-(void)getListData {
    [_listArray removeAllObjects];
    NSArray *title = [[NSArray alloc] initWithObjects:@"热门", @"P2P", @"宝宝", @"基金", @"银行理财", @"保险", nil];
    
    for (NSString *string in title) {
        DMProjectListItem *category = [[DMProjectListItem alloc] init];
        category.name = string;
        category.yield = @"4%";
        category.dec = @"贷款金额11111";
        category.url = @"http://img0.imgtn.bdimg.com/it/u=1070902365,2619384777&fm=21&gp=0.jpg";
        [_listArray addObject:category];
    }

}
#pragma mark ------getter add setter---------

-(NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc] init];
        
    }
    return _listArray;

}

-(NSMutableArray *)categories {
    if (!_categories) {
        _categories = [[NSMutableArray alloc] init];
        NSArray *title = [[NSArray alloc] initWithObjects:@"热门", @"P2P", @"宝宝", @"基金", @"银行理财", @"保险", nil];
        
        for (NSString *string in title) {
            DMDiscoveryCategory *category = [[DMDiscoveryCategory alloc] init];
            category.categoryName = string;
            [_categories addObject:category];
        }

    }
    return _categories;
}
- (JFSwipeView *)categoryHeaderView
{
    if (!_categoryHeaderView) {
        _categoryHeaderView = [[JFSwipeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        _categoryHeaderView.backgroundColor = [UIColor whiteColor];
        _categoryHeaderView.tag = DMIndexSwipeViewTypeHeader;
        _categoryHeaderView.gap = 2;
        _categoryHeaderView.contentInset = UIEdgeInsetsMake(0, AUTOSIZE(2), 0, AUTOSIZE(2));
        _categoryHeaderView.dataSource = self;
        _categoryHeaderView.swipeDelegate = self;
        [_categoryHeaderView registerClass:[JFSwipeItemView class] widthViewReuseIdentifier:@"header"];
    }
    return _categoryHeaderView;
}

- (JFSwipeView *)categoryContentView
{
    if (!_categoryContentView) {
        _categoryContentView = [[JFSwipeView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, self.view.height - 44)];
        _categoryContentView.tag = DMIndexSwipeViewTypeBody;
        _categoryContentView.dataSource = self;
        _categoryContentView.pagingEnabled = YES;
        _categoryContentView.swipeDelegate = self;
        _categoryContentView.dataSource = self;
        _categoryContentView.tapGestureRecognizer.enabled = NO;
        _categoryContentView.backgroundColor = kTableViewBgColor;
//        _categoryHeaderView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _categoryContentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;

        [_categoryContentView registerClass:[DMFindPageView class] widthViewReuseIdentifier:@"pageView"];
        [_categoryContentView registerClass:[UICollectionView class] widthViewReuseIdentifier:@"collectionView"];
    }
    return _categoryContentView;
}

- (DMFindPageView *)pageView
{
    DMFindPageView *pageView = [[DMFindPageView alloc] initWithFrame:CGRectMake(0, 0, _categoryContentView.width, _categoryContentView.height)];
    pageView.backgroundColor = kTableViewBgColor;
    pageView.tableView.backgroundColor = kTableViewBgColor;
    [pageView.tableView registerClass:[DMProjectListCell class] forCellReuseIdentifier:@"DMProjectListCell"];
    [pageView.tableView registerClass:[DMBannerCell class] forCellReuseIdentifier:@"DMBannerCell"];
    [pageView.tableView registerClass:[DMIndexPageMenuCell class] forCellReuseIdentifier:@"DMIndexPageMenuCell"];
    pageView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    pageView.tableView.delegate = self;
    pageView.tableView.dataSource = self;
    pageView.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //    pageView.tableView.scrollIndicatorInsets = UIEdgeInsetsMake([self topInset], 0, 0, 0);
//    pageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    __weak __typeof (&*self)weakSelf = self;
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_refresh_arrow_down.png"]];
    
    [pageView.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf refreshProjectsData:YES];
    } arrowView:arrowView];
    
    [pageView.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf refreshProjectsData:NO];
    }];
    pageView.tableView.pullToRefreshView.backgroundColor = kTableViewBgColor;
    return pageView;
}

#pragma mark ------DMIndexPageMenuCellDelegate----------

-(void)menuAction:(DMIndexPageMenuType)type {
    if (type == DMIndexPageMenuTypeNewcomer) {
        DMNewcomerViewController *controller = [[DMNewcomerViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    } else if (type == DMIndexPageMenuTypeYangmao) {
        DMYangmaoViewController *controller = [[DMYangmaoViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    } else if (type == DMIndexPageMenuTypeP2P) {
        DMP2PViewController *controller = [[DMP2PViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    } else if (type == DMIndexPageMenuTypeHotList) {
        DMHotListViewController *controller = [[DMHotListViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - DMBannerCellDelegate
- (void)selectedType:(NSString *)type param:(NSDictionary *)param {

}


- (NSInteger)numberOfItemViewsInSwipeView:(JFSwipeView *)swipeView
{
    return [self.categories count];
}

#pragma mark - JFSwipeViewDelegate

- (CGFloat)swipeView:(JFSwipeView *)swipeView widthForItemAtIndex:(NSInteger)index
{
    if (swipeView.tag == DMIndexSwipeViewTypeHeader) {
        static UIFont *font;
        if (!font) {
            font = FONT(14);
        }
        DMDiscoveryCategory *category = [self.categories objectAt:index];
        NSString *content = category.categoryName;
        CGSize size = [content sizeWithAttributes:@{NSFontAttributeName: font}];
        
        return ceil(size.width) + AUTOSIZE(11.5*2);
        
    }else{
        return CGRectGetWidth(swipeView.bounds);
    }

}

- (CGFloat)swipeView:(JFSwipeView *)swipeView widthForIndicatorAtIndex:(NSInteger)index
{
    return 0;
}

- (void)swipeViewDidChangeCurrentIndex:(NSInteger)currentIndex
{
    [self.categoryHeaderView scrollToItemAtIndex:currentIndex animated:YES];

    //    DMFindPageView *pageView = (DMFindPageView *)[self.categoryContentView currentItemView];
    //    pageView.tableView.scrollsToTop = YES;

//    if (currentIndex == DMIndexPageTypeCommon) {
//        [_jingxuanView startTimer];
//        if (!self.jingxuanView.isLoaded) {
//            [self.jingxuanView requestCommonData];
//        }
//    } else if (currentIndex == DMIndexPageTypeToday) {
//        if (!self.todayView.isLoaded) {
//            [self.todayView requestTodayListData];
//        }
//    } else if (currentIndex == DMIndexPageTypeStory) {
//        if (!self.storyView.isLoaded) {
//            self.storyView.isRefresh = YES;
//            [self.storyView reloadData];
//        }
//    }
}

- (void)swipeViewDidScroll:(JFSwipeView *)swipeView
{
    [self.view endEditing:YES];
}


#pragma mark - SwipeView Delegate
#pragma mark - SwipeView Datasource


- (void)swipeView:(JFSwipeView *)swipeView willDisplayView:(UIView *)view atIndex:(NSInteger)index
{
    
}

- (void)swipeView:(JFSwipeView *)swipeView endDisplayView:(UIView *)view atIndex:(NSInteger)index
{
    if (swipeView.tag == DMIndexSwipeViewTypeBody) {
        //        if ([view isKindOfClass:[DMFindPageView class]]) {
        //            DMFindPageView *pageView = (DMFindPageView *)view;
        //            [pageView cancelRequest];
        //            [pageView.tableView hideWaringView];
        //
        //            //            [self updateScrollView:pageView.tableView contentInsetTop:64.0];
        //
        //            UITableView *tableView = pageView.tableView;
        //            DMPageState *state = self.states[index];
        //            state.offsetY = tableView.contentOffset.y;
        //        }
    }
}

- (UIView *)swipeView:(JFSwipeView *)swipeView itemViewAtIndex:(NSInteger)index
{
    if (swipeView.tag == DMIndexSwipeViewTypeHeader) {
        
        JFSwipeItemView *item = (JFSwipeItemView *)[swipeView dequeueViewWithIdentifier:@"header"];
        if (!item) {
            item = [[JFSwipeItemView alloc] initWithFrame:CGRectMake(0, 0, 60, 34)];
            item.backgroundColor = [UIColor clearColor];
//            item.titleLabel.textColor = [UIColor redColor];
//            item.titleLabel.font = font;
            item.alphaOfNormalColor = 1;
            item.normalColorElements = @[@174, @167, @170];
            item.selectedColorElements = @[@219, @73, @58];
            item.normalFont = FONT(14.0);
            item.selectedFont = FONT(14.0);
        }
        
        static UIColor *color;
        if (color == nil) {
            color = [item colorWithPercent:0];
        }
        
        DMDiscoveryCategory *category = [self.categories objectAt:index];
        NSString *title = category.categoryName;
        
        item.titleLabel.text = title;
        
        item.titleLabel.textColor = color;
        return item;
    } else if (swipeView.tag == DMIndexSwipeViewTypeBody) {
        DMFindPageView *pageView = (DMFindPageView *)[swipeView dequeueViewWithIdentifier:@"pageView"];
        if (!pageView) {
            
            // 生成新的pagevie
            pageView = [self pageView];
        }
        pageView.index = index;
        
        // 距离当前近的才进行一系列操作
        if (labs(index - swipeView.currentIndex) <= 1) {

            DMPageState *state = self.states[index];

            DMDiscoveryCategory *category = [self.categories objectAt:index];
            DMPageDataInfo *pageInfo = [DMPageDataInfo defaultPageDataInfo];
            NSMutableArray *cacheItems = [NSMutableArray array];
            for (int i=0; i<= state.pageInfo.pageNo; i++) {
                pageInfo.pageNo = i;
                NSDictionary *parameters = [self createParametersWithCategory:category
                                                                     pageInfo:pageInfo];
                NSArray *items = [DMIndexPageService fetchCacheWithParameters:parameters];
                if ([_listArray count]) {
                    [cacheItems addObjectsFromArray:_listArray];
                }
            }
            if (cacheItems.count > 0) {//有缓存
                self.listArray = cacheItems;
                [pageView.tableView reloadData];
                if (state.offsetY == 0) {
                    [pageView.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 0) animated:NO];

                } else {
                    CGFloat offset = pageView.tableView.contentSize.height - pageView.tableView.frame.size.height;
                    [pageView.tableView setContentOffset:CGPointMake(0, MIN(offset, state.offsetY)) animated:NO];
                }
            }
            else {//没有缓存
                _expiredTime = 1;
                [self.listArray removeAllObjects];
                [pageView.tableView reloadData];
                [pageView.tableView setContentOffset:CGPointMake(0, 0)];
            }
        }
        
        
        //        [pageView showFilterView];
        
        [self getListData];
        if (index == 0) {
            [self.listArray insertObject:@"menu" atIndex:0];
            [self.listArray insertObject:@"banner" atIndex:0];
        }
        [pageView.tableView reloadData];
        return pageView;
    }
    return nil;
}

#pragma mark -  UITableViewDataSource -----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id obj = [self.listArray objectAt:indexPath.row];
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)obj;
        if ([string isEqualToString:@"banner"]) {
            DMBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMBannerCell"];
            cell.delegate = self;
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (NSUInteger i = 0; i < 10; i++) {
                DMBannerModel *model = [[DMBannerModel alloc] init];
                model.picUrl = @"http://ww1.sinaimg.cn/bmiddle/74f67c55jw1eykcwjnpusj20sg0k0jwe.jpg";
                [array addObject:model];
            }
            [cell reloadBannerWithSubjects:array];
            return cell;
        } else if ([string isEqualToString:@"menu"]) {
            DMIndexPageMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMIndexPageMenuCell"];
            cell.delegate = self;
            return cell;
        }
    }
    DMProjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMProjectListCell"];
    cell.item = [self.listArray objectAt:indexPath.row];
    return cell;
}


#pragma mark -  UITableViewDelegate --------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DMP2PDetailViewController *controller = [[DMP2PDetailViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.item = [_listArray objectAt:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = [self.listArray objectAt:indexPath.row];
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)obj;
        if ([string isEqualToString:@"banner"]) {
            return 200;
        } else if ([string isEqualToString:@"menu"]) {
            return 100;
        }
    }
    return 100;
}
@end
