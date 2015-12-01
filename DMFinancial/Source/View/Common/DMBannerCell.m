//
//  DMBannerCell.m
//  DamaiIphone
//
//  Created by SongDong on 15-3-10.
//  Copyright (c) 2015年 damai. All rights reserved.
//  首页轮播图cell

#import "DMBannerCell.h"
#import "StyledPageControl.h"

@implementation DMBannerModel

@end

@interface DMBannerCell()
{
    SwipeView *_bannerView;
    StyledPageControl *_pageControl;
    
    CGFloat _bannerHeight;
}

@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic, strong) NSArray *subjectArray;

@end

@implementation DMBannerCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initSubViews];
        //[self startTimer];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews
{
    SwipeView *bannerView = [[SwipeView alloc] initWithFrame:self.bounds];
    //bannerView.height = _bannerHeight;
    bannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bannerView.dataSource = self;
    bannerView.delegate = self;
    bannerView.alignment = SwipeViewAlignmentCenter;
    bannerView.pagingEnabled = YES;
    bannerView.wrapEnabled = YES;
    bannerView.truncateFinalPage = YES;
    [self.contentView addSubview:bannerView];
    _bannerView = bannerView;
    
    StyledPageControl *pageControl = [[StyledPageControl alloc]
                                      initWithFrame:CGRectZero];
    pageControl.gapWidth = 3.0f;
    pageControl.pageControlStyle = PageControlStyleThumb;
    pageControl.thumbImage = [UIImage imageWithResourcesPathCompontent:@"icon_pagecontrol_normal.png"];
    pageControl.selectedThumbImage = [UIImage imageWithResourcesPathCompontent:@"icon_pagecontrol_selected.png"];
    [self.contentView insertSubview:pageControl aboveSubview:bannerView];
    _pageControl = pageControl;
}

- (void)startTimer
{
    [self stopTimer];
    self.timer = [NSTimer timerWithTimeInterval:5.0
                                         target:self
                                       selector:@selector(timerFired:)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerFired:(NSTimer *)timer
{
    [_bannerView scrollToItemAtIndex:_bannerView.currentItemIndex+1 duration:0.5];
}

/**
 *  刷新banner
 *
 *  @param subjects     banner 数据对象 数组
 */
-(void)reloadBannerWithSubjects:(NSArray *)subjects
{
    self.subjectArray = subjects;
    _pageControl.numberOfPages = self.subjectArray.count;
    _pageControl.frame = CGRectMake(0, self.height - 10, kScreenWidth, 5);
    [_bannerView reloadData];

}

-(void)layoutSubviews {
    [super layoutSubviews];
    _pageControl.frame = CGRectMake(0, self.height - 10, kScreenWidth, 5);
}
#pragma mark ========== SwipeViewDataSource ==========

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.subjectArray.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView
   viewForItemAtIndex:(NSInteger)index
          reusingView:(UIView *)view
{
    UIImageView *subjectView = (UIImageView *)view;
    if (!view)
    {
        subjectView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    self.width,
                                                                    self.height)];
    }
//    subjectView.height = _bannerHeight;
    DMBannerModel *subject = [self.subjectArray objectAt:index];
    if (subject && [subject isKindOfClass:[DMBannerModel class]]) {        
        [subjectView sd_setImageWithURL:[NSURL URLWithString:subject.picUrl]
                       placeholderImage:[[UIImage imageNamed:kPanePlaceHolder]
                                         scaleToCenterSize:CGSizeMake(self.width,
                                                                      self.height)]];
        subjectView.attachment = subject;
    }

    return subjectView;
}

#pragma mark ========== SwipeViewDelegate ==========

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return CGSizeMake(swipeView.width, swipeView.height);
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    _pageControl.currentPage = swipeView.currentPage;
}

-(void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    UIView *view = [swipeView itemViewAtIndex:index];
    DMBannerModel *subject = (DMBannerModel *)view.attachment;
    if (subject && [subject isKindOfClass:[DMBannerModel class]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedType:param:)]) {
            [self.delegate selectedType:subject.type param:@{@"param":subject.param}];
        }
    }

}

//- (BOOL)swipeView:(SwipeView *)swipeView shouldSelectItemAtIndex:(NSInteger)index
//{
//    UICollectionView *currentPageView = (UICollectionView *)[_indexPageView currentItemView];
//    [currentPageView.pullToRefreshView stopAnimating];
//    [currentPageView.infiniteScrollingView stopAnimating];
//    //[self hiddenNoticeView];
//
//    return YES;
//}


@end
