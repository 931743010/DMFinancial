//
//  DMSearchViewController.m
//  DamaiIphone
//
//  Created by lixiang on 13-12-30.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMSearchViewController.h"
#import "DMIndexPageService.h"
#import "DMPageDataInfo.h"
#import "DMGlobalVar.h"
#import "DMProjectListItem.h"
#import "DMSearchBar.h"
#import "DMTextCell.h"
#import "DMRoundLabel.h"
#import "CLCacheService.h"
#import "CLCachePolicy.h"
#import "DMProjectListCell.h"
#import "DMSearchObject.h"
#import "DMTableViewHeaderView.h"

static NSString * const KTitleCellIdentifier = @"KTitleCellIdentifier";
static NSString * const HistorySectionKey = @"HistorySectionKey";
static NSString * const HotSectionKey = @"HotSectionKey";

#define DefaultXMargin 65
#define DefaultYMargin 10
#define ItemCountOfLine 3

@interface DMSearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate, DMSearchBarDelegate> {
    __weak UITableView             *_tableView;
    __weak DMSearchBar             *_searchBar;
    __weak UIButton                *_recentButton;
    __weak UIButton                *_hotButton;
    __weak UIView                  *_segmentedView;
    
    DMProjectListCell         *_sizingCell;
}

@property (nonatomic, strong) DMPageDataInfo    *pageDataInfo;
@property (nonatomic, strong) NSArray           *hotWords;
@property (nonatomic, strong) NSMutableArray    *historyWords;
@property (nonatomic, strong) NSMutableArray    *projects;
@property (nonatomic, assign) BOOL              isRefresh;
@property (nonatomic, assign) long               searchMode;
@property (nonatomic, assign) BOOL              showingResult;

@property (nonatomic, assign) DMSearchViewType currentViewType;

@end

@implementation DMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageDataInfo = [DMPageDataInfo defaultPageDataInfo];
    _searchMode = 1;
   	[self initSubviews];
    self.showingResult = NO;
    self.currentViewType = DMHotSearch;
    [self handleResponseDataOfKeyWords:nil];
}

#pragma mark ========== Private Method ==========
- (void)initSubviews {
    UIView *customerView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    //customerView.backgroundColor = [UIColor redColor];
    DMSearchBar *searchBar = [[DMSearchBar alloc] initWithFrame:CGRectMake(0, 8, kScreenWidth-18-44-8, 27)];
    searchBar.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    searchBar.layer.cornerRadius = 5.0f;
    searchBar.textField.textColor = kDMDefaultBlackStringColor;
    searchBar.textField.font = FONT(13);
    searchBar.delegate = self;
    [customerView addSubview:searchBar];
    _searchBar = searchBar;
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(searchBar.right+14, 0, 44, 44)];
    cancelButton.titleLabel.font = BOLDFONT(14);
    cancelButton.backgroundColor = [UIColor clearColor];
    [cancelButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [cancelButton setTintColor:[UIColor whiteColor]];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonAction:)
           forControlEvents:UIControlEventTouchUpInside];
    [customerView addSubview:cancelButton];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:customerView];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, self.view.height)
                                                          style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];//kTableViewBgColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[DMProjectListCell class] forCellReuseIdentifier:@"DMProjectListCell"];
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    __weak __typeof (&*self)weakSelf = self;
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_refresh_arrow_down.png"]];
    [_tableView addPullToRefreshWithActionHandler:^{
        weakSelf.isRefresh = YES;
        [weakSelf requestProjectListWithKeyWords:_searchBar.text];
    } arrowView:arrowView];
    
    [_tableView addInfiniteScrollingWithActionHandler:^{
        weakSelf.isRefresh = NO;
        [weakSelf requestProjectListWithKeyWords:_searchBar.text];
    }];
    
    //_tableView.infiniteScrollingView.enabled = NO;
    
    self.showingResult = NO;
}

-(void)setShowingResult:(BOOL)showingResult
{
    _showingResult = showingResult;
    if (showingResult)
    {
        _tableView.showsInfiniteScrolling = YES;
        _tableView.showsPullToRefresh = YES;
    }
    else
    {
        _tableView.showsInfiniteScrolling = NO;
        _tableView.showsPullToRefresh = NO;
    }
}

- (NSMutableArray *)projects
{
    if (_projects == nil)
    {
        _projects = [NSMutableArray array];
    }
    return _projects;
}

- (void)requestHotWordList {
    
    //    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
    //                         [DMGlobalVar shareGlobalVar].currentCity.cityId, @"cityid", nil];
    CLCachePolicy *policy = [CLCachePolicy defaultCachePolicy];
    [DMIndexPageService getSearchHotWordListWithParams:nil
                                           cachePolicy:policy
                                               success:^(id returnData) {
                                                   [self hideLoadingView];
                                                   [self handleResponseDataOfKeyWords:returnData];
                                               } fail:^(NSError *error) {
                                                   [self hideLoadingView];
                                                   [self showErrorViewWithText:[error localizedDescription]];
                                               }];
}

- (void)requestProjectListWithKeyWords:(NSString *)words
{
    if (!words) {
        words = @"";
    }
    
    [self addHistoryWord:words];
    self.currentViewType = DMObjectList;
    
    if (_isRefresh)
    {
        [self showLoadingViewWithText:kLoadingText];
        self.pageDataInfo = [DMPageDataInfo defaultPageDataInfo];
    }
    else
    {
        self.pageDataInfo.pageNo +=1;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         words, @"key",
                         [NSNumber numberWithInteger:_pageDataInfo.pageNo], @"p",
                         [NSNumber numberWithInteger:_pageDataInfo.size],  @"ps",
                         nil];
    [DMIndexPageService getSearchListWithParams:dic
                                    cachePolicy:nil
                                             success:^(id returnData) {
                                            [self hideLoadingView];
                                            [_tableView.pullToRefreshView stopAnimating];
                                            [_tableView.infiniteScrollingView stopAnimating];
                                            [self handleResponseDataOfProjects:returnData];
                                            [_tableView.infiniteScrollingView stopAnimating];
                                        } fail:^(NSError *error) {
                                            [self hideLoadingView];
                                            [_tableView.pullToRefreshView stopAnimating];
                                            [_tableView.infiniteScrollingView stopAnimating];
                                            [self showErrorViewWithText:[error localizedDescription]];
                                            [_tableView.infiniteScrollingView stopAnimating];
                                        }];
}

- (void)handleResponseDataOfKeyWords:(id)data {
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 3; i++) {
        DMSearchHotwordObject *item = [[DMSearchHotwordObject alloc] init];
        item.categoryName = @"基金";
        item.hotwordList = @[@"博时招财一号大数据", @"工银瑞信金融地产", @"积木盒子"];
        [array addObject:item];
    }
    self.hotWords = array;
    self.showingResult = NO;
    [_tableView reloadData];
}

- (void)loadHistorySearchWords {
    
    NSString *path = PATH_AT_CACHEDIR(kHistoryWordsFile);
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    NSMutableArray *historyWords = nil;
    if (isExist) {
        historyWords = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    } else {
        historyWords = [NSMutableArray array];
    }
    if (![historyWords isKindOfClass:[NSArray class]]) {
        NSError *err = nil;
        [[NSFileManager defaultManager] removeItemAtPath:path error:&err];
    } else {
        self.historyWords = historyWords;
    }
}

- (void)saveHistorySearchWords {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.historyWords];
    NSString *path = PATH_AT_CACHEDIR(kHistoryWordsFile);
    [CommonHelper saveData:data toFile:path];
}

- (void)addHistoryWord:(NSString *)word {
    if (self.historyWords == nil) {
        self.historyWords = [NSMutableArray arrayWithObject:word];
    } else {
        if (![_historyWords containsObject:word]) {
            [_historyWords insertObject:word atIndex:0];
            if ([_historyWords count]>9) {
                [_historyWords removeLastObject];
            }
        }
    }
    if (self.historyWords && [self.historyWords count] > 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self saveHistorySearchWords];
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                [_tableView reloadData];
            //            });
        });
    }
}


- (void)handleResponseDataOfProjects:(id)data {
    [self.view endEditing:YES];
    [_searchBar.textField resignFirstResponder];
    self.showingResult = YES;
    
    DMProjectList *projectList = (DMProjectList *)data;
    //如果有数据才保存记录
    NSArray *moreProjects = projectList.projectsData;
    self.pageDataInfo.totalCount = projectList.totalCount;
    
    //如果当前请求是刷新操作，则删除之前的数据
    if (_isRefresh) {
        [self.projects removeAllObjects];
    }
    [self.projects addObjectsFromArray:moreProjects];
    if (self.pageDataInfo.totalCount > self.projects.count) {
        _tableView.showsInfiniteScrolling = YES;
    } else {
        _tableView.showsInfiniteScrolling = NO;
    }
    if (self.pageDataInfo.totalCount == 0) {
        [self.view showWaringViewWithText:@"暂无项目"];
    } else {
        [self.view hideWaringView];
    }
    [_tableView reloadData];
}

- (UITableViewCell *)createCellWithWords:(DMSearchHotwordObject *)item {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"WordscellIdentifier"];
    CGFloat x = DefaultXMargin;
    CGFloat y = DefaultYMargin;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, y, 100, 32)];
    titleLabel.text = item.categoryName;
    titleLabel.textColor = kDMDefaultGrayStringColor;
    titleLabel.font = FONT(13);
    [cell.contentView addSubview:titleLabel];
    for (int i = 0; i < item.hotwordList.count; i++) {
        NSString *word = [item.hotwordList objectAt:i];
        DMRoundLabel *wordLabel = [[DMRoundLabel alloc] init];
        wordLabel.width = 95;
        wordLabel.height = 32;
        wordLabel.attachment = word;
        wordLabel.bgColor = RGBA(242, 242, 242, 1);
        wordLabel.contentColor = kDMDefaultBlackStringColor;
        wordLabel.content = word;
        wordLabel.fontSize = 13;
        if ((x + wordLabel.estimateWidth) > kScreenWidth) {
            y += 40;
            x = DefaultXMargin;
        }
        //如果高度大于cell的高度 则后面的不显示
        if (y > 280) {
            break;
        }
        [cell.contentView addSubview:wordLabel];
        wordLabel.left = x;
        wordLabel.top = y;
        x += wordLabel.estimateWidth + 10;
        
        UITapGestureRecognizer *wordTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(wordTapAction:)];
        [wordLabel addGestureRecognizer:wordTap];
        
    }
    cell.height = y + 40;
    return cell;
}

- (void)wordSelected:(UIButton *)sender {
    NSString *word = (NSString *)sender.attachment;
    _searchBar.text = word;
    _isRefresh = YES;
    //self.showingResult = YES;
    [self requestProjectListWithKeyWords:word];
}

- (void)wordTapAction:(UITapGestureRecognizer *)reg
{
    DMRoundLabel *label = (DMRoundLabel *)reg.view;
    
    _searchBar.text = label.content;
    
    _isRefresh = YES;
    
    //self.showingResult = YES;
    
    [self requestProjectListWithKeyWords:label.content];
}

#pragma mark ========== Action Method ==========

- (void)cancelButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ========== DMSearchBarDelegate ==========
- (void)clearButtonAction:(DMSearchBar *)searchBar {
    _searchBar.text = @"";
    [self.view hideWaringView];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:kPlaceholderOfSearchBar]) {
        textField.text = @"";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    _isRefresh = YES;
    //self.showingResult = YES;
    [self requestProjectListWithKeyWords:textField.text];
    return YES;
}

#pragma mark ========== UIScrollViewDelegate ==========
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    [_searchBar resignFirstResponder];
}

#pragma mark ========== UITableViewDelegate ==========
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float height;
    NSInteger row = indexPath.row;
    if (_currentViewType == DMRecentSearch)
    {
        height = 55;
    }
    else if(_currentViewType == DMHotSearch)
    {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        height = cell.height;
    }
    else
    {
       
        return 100;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSInteger row = indexPath.row;
    if (_currentViewType == DMRecentSearch)
    {
        if (row == self.historyWords.count)
        {
            [self.historyWords removeAllObjects];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self saveHistorySearchWords];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            });
        }
        else
        {
            NSString *word = [self.historyWords objectAt:row];
            _searchBar.text = word;
            _isRefresh = YES;
            //self.showingResult = YES;
            [self requestProjectListWithKeyWords:word];
        }
    }
    else if(_currentViewType == DMObjectList)
    {
        DMProjectListItem *item = [self.projects objectAt:row];
        [self pushWithSubjectType:DMSubjectCommon params:@{@"":@""}];
    }
}

#pragma mark ========== UITableViewDataSource ==========

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_currentViewType == DMHotSearch) {
        return kTableViewHeaderViewHight;
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_currentViewType == DMHotSearch) {
        DMTableViewHeaderView *view = [[DMTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeaderViewHight)];
        view.title = @"热门搜索";
        return view;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentViewType == DMObjectList)
    {
        return self.projects.count;
    }
    else if (_currentViewType == DMHotSearch)
    {
        return self.hotWords.count;
    }

    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (_currentViewType == DMHotSearch)
    {
        DMSearchHotwordObject *item = [self.hotWords objectAt:indexPath.row ];
        cell = [self createCellWithWords:item];
    }
    else
    {
        DMProjectListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DMProjectListCell"];
        if (!cell)
        {
            cell = [[DMProjectListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMProjectListCell"];
        }
//        [cell configForProject:[self.projects objectAt:indexPath.row]
//                          from:2
//                  loadingImage:YES];
        return cell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
