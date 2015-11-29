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

typedef NS_ENUM(NSUInteger, DMIndexSwipeViewType) {
    DMIndexSwipeViewTypeHeader,
    DMIndexSwipeViewTypeBody
};
@interface DMIndexPageViewController ()<JFSwipeViewDataSource, JFSwipeViewSwipeDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) JFSwipeView *categoryHeaderView;

@property (strong, nonatomic) JFSwipeView *categoryContentView;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UIView  *menuView;

@end

@implementation DMIndexPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"值得买";

    [self.view addSubview:self.categoryContentView];
    [self.view addSubview:self.categoryHeaderView];

    
}


-(void)refreshProjectsData:(BOOL)refresh {
    
}
- (NSDictionary *)createParametersWithCategory:(DMDiscoveryCategory *)category
                                    filterTime:(DMDiscoveryFilterTime *)filterTime
                                   filterOrder:(DMDiscoveryFilterActivityOrder *)filterOrder
                                      pageInfo:(DMPageDataInfo *)pageInfo
{
    NSMutableDictionary *infos = [NSMutableDictionary new];
    
    [infos setSafetyObject:category.categoryId forKey:@"cateid"];
    [infos setSafetyObject:filterTime.startTime forKey:@"stime"];
    [infos setSafetyObject:filterTime.endTime forKey:@"etime"];
    [infos setSafetyObject:@(pageInfo.pageNo) forKey:@"pindex"];
    [infos setSafetyObject:@(pageInfo.size) forKey:@"psize"];
    [infos setSafetyObject:filterOrder.name forKey:@"order"];
    
    return infos;
}

#pragma mark ------getter add setter---------
-(UIView *)menuView{
    if (!_menuView) {
        _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        NSArray *title = [[NSArray alloc] initWithObjects:@"新手入门", @"薅羊毛", @"P2P产品库", @"排行榜", nil];
        CGFloat left = 10;
        CGFloat top = 10;
        CGFloat width = (kScreenWidth - left*5)/4;

        for (NSUInteger i = 0; i < title.count; i++) {
            DMButton *button = [[DMButton alloc] initWithFrame:CGRectMake(left, top, width, width)];
            [button setTitle:[title objectAt:i] forState:UIControlStateNormal];
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColor grayColor].CGColor;
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [button buttonClickedcompletion:^(id returnData) {
                DMButton *button = (DMButton *)returnData;
                if ([button.titleLabel.text isEqualToString:@"新手入门"]) {
                    
                } else if ([button.titleLabel.text isEqualToString:@"薅羊毛"]) {
                
                } else if ([button.titleLabel.text isEqualToString:@"P2P产品库"]) {
                    
                } else if ([button.titleLabel.text isEqualToString:@"排行榜"]) {
                    
                }
            }];
            [_menuView addSubview:button];
            left += width + 10;
        }
    }
    
    return _menuView;
}
-(NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc] init];
        NSArray *title = [[NSArray alloc] initWithObjects:@"热门", @"P2P", @"宝宝", @"基金", @"银行理财", @"保险", nil];
        
        for (NSString *string in title) {
            DMProjectListItem *category = [[DMProjectListItem alloc] init];
            category.name = string;
            [_listArray addObject:category];
        }
        
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
        _categoryContentView.tapGestureRecognizer.enabled = NO;
        _categoryContentView.backgroundColor = kTableViewBgColor;
        
        [_categoryContentView registerClass:[DMFindPageView class] widthViewReuseIdentifier:@"pageView"];
        [_categoryContentView registerClass:[UICollectionView class] widthViewReuseIdentifier:@"collectionView"];
    }
    return _categoryContentView;
}

- (DMFindPageView *)pageView
{
    DMFindPageView *pageView = [[DMFindPageView alloc] initWithFrame:self.categoryContentView.bounds];
    pageView.backgroundColor = kTableViewBgColor;
    pageView.tableView.backgroundColor = kTableViewBgColor;
    [pageView.tableView registerClass:[DMProjectListCell class]
               forCellReuseIdentifier:@"DMProjectListCell"];
    pageView.tableView.delegate = self;
    pageView.tableView.dataSource = self;
//    pageView.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
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

#pragma mark - ScrollView Delegate

#pragma mark - SwipeView Delegate

- (CGFloat)swipeView:(JFSwipeView *)swipeView widthForItemAtIndex:(NSInteger)index
{
    if (swipeView.tag == DMIndexSwipeViewTypeHeader) {
        static UIFont *font;
        if (!font) {
            font = BOLDFONT(16);
        }
        DMDiscoveryCategory *category = [self.categories objectAt:index];
        NSString *content = category.categoryName;
        CGSize size = [content sizeWithAttributes:@{NSFontAttributeName: font}];
        
        return ceil(size.width) + AUTOSIZE(11.5*2);
        
    }else{
        CGFloat width = CGRectGetWidth(self.view.frame);
        return width;
    }
}

- (void)swipeViewDidScroll:(JFSwipeView *)swipeView
{
    //    if (swipeView.tag == DMFindCategoryViewTypeContent) {
    //        // [self changeViewWithOffsetX:swipeView.contentOffset.x];
    //    }
}

- (void)swipeViewDidChangeCurrentIndex:(NSInteger)currentIndex
{
    //    [self setScrollToTopFalse:self.view];
    [self.categoryHeaderView scrollToItemAtIndex:currentIndex animated:YES];
    
    DMFindPageView *pageView = (DMFindPageView *)[self.categoryContentView currentItemView];
    pageView.tableView.scrollsToTop = YES;
    
    //    [pageView.filterView reloadData];
    //
    //    [self refreshIfNeedWithCategory:self.currentCategory
    //                         filterTime:self.currentFilterTime
    //                        filterOrder:self.currentFilterOrder
    //                           pageInfo:[DMPageDataInfo defaultPageDataInfo]];
}

#pragma mark - Helper method

- (void)changeViewWithOffsetX:(CGFloat)offsetX
{
    CGFloat width = CGRectGetWidth(self.categoryContentView.bounds);
    CGFloat pageNumber = floorf(offsetX / width);
    CGFloat already = offsetX - pageNumber * width - 1;
    CGFloat percent = fabs(already / width);
    
    JFSwipeItemView *preItemView = (JFSwipeItemView *)[self.categoryHeaderView itemViewAtIndex:pageNumber];
    JFSwipeItemView *nextItemView = (JFSwipeItemView *)[self.categoryHeaderView itemViewAtIndex:pageNumber+1];
    
    preItemView.progressForWillSelected = 1- percent;
    nextItemView.progressForWillSelected = percent;
    
    //    float preFontPercent = ((DMFindCategoryHeaderMaxFontSize - DMFindCategoryHeaderMinFontSize) * (1 - percent) + DMFindCategoryHeaderMinFontSize) / DMFindCategoryHeaderMaxFontSize;
    //    float nextFontPercent = ((DMFindCategoryHeaderMaxFontSize - DMFindCategoryHeaderMinFontSize) * percent + DMFindCategoryHeaderMinFontSize) / DMFindCategoryHeaderMaxFontSize;
    //    [preItemView makeScale:preFontPercent];
    //    [nextItemView makeScale:nextFontPercent];
    
    [self.categoryHeaderView scrollIndicateViewFromIndex:pageNumber
                                                progress:percent];
    
}

#pragma mark - SwipeView Datasource

- (NSInteger)numberOfItemViewsInSwipeView:(JFSwipeView *)swipeView
{
    return [self.categories count];
}

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
            //item.titleLabel.textColor = [UIColor redColor];
            //            item.titleLabel.font = font;
            item.alphaOfNormalColor = 0.6;
            item.normalColorElements = @[@174, @167, @170];
            item.selectedColorElements = @[@81, @70, @71];
            item.normalFont = FONT(16.0);
            item.selectedFont = FONT(16.0);
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
            
            // 生成新的pageview
            pageView = [self pageView];
        }
        if (index == 0) {
            pageView.tableView.tableHeaderView = self.menuView;
        } else {
            pageView.tableView.tableHeaderView = nil;
        }
        pageView.index = index;
        
        //        // 距离当前近的才进行一系列操作
        //        if (labs(index - swipeView.currentIndex) <= 1) {
        //
        //            DMDiscoveryCategory *category = [self.categories objectAt:index];
        //            DMPageDataInfo *pageInfo = [DMPageDataInfo defaultPageDataInfo];
        //            NSMutableArray *cacheItems = [NSMutableArray array];
        //            for (int i=0; i<= state.pageInfo.pageNo; i++) {
        //                pageInfo.pageNo = i;
        //                NSDictionary *parameters = [self createParametersWithCategory:category
        //                                                                   filterTime:[DMDiscoveryFilterTime defaultFilterTime]
        //                                                                  filterOrder:self.categoryList.orders[0]
        //                                                                     pageInfo:pageInfo];
        //                NSArray *items = [DMDiscoveryService fetchCacheWithParameters:parameters];
        //                if ([items count]) {
        //                    [cacheItems addObjectsFromArray:items];
        //                }
        //            }
        //            if (cacheItems.count > 0) {//有缓存
        //                pageView.dataSource.items = cacheItems;
        //                [pageView.tableView reloadData];
        //                if (state.offsetY == 0) {
        //                    [pageView.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 0) animated:NO];
        //
        //                } else {
        //                    CGFloat offset = pageView.tableView.contentSize.height - pageView.tableView.frame.size.height;
        //                    [pageView.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
        //                }
        //            }
        //            else {//没有缓存
        //                _expiredTime = 1;
        //                pageView.dataSource.items = nil;
        //                [pageView.tableView reloadData];
        //                [pageView.tableView setContentOffset:CGPointMake(0, 0)];
        //            }
        //        }
        //        
        
        //        [pageView showFilterView];
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
    DMProjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMProjectListCell"];
    cell.item = [self.listArray objectAt:indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


#pragma mark -  UITableViewDelegate --------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
