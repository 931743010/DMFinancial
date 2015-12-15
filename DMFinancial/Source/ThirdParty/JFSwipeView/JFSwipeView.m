//
//  JFSwipeView.m
//  IndexPagesDemo
//
//  Created by Joseph Fu on 14-11-4.
//  Copyright (c) 2014年 Joseph Fu. All rights reserved.
//

#import "JFSwipeView.h"

static inline NSInteger getTagAtIndex(NSInteger index)
{
    return index + 10000000;
}

static inline NSInteger getIndexWithTag(NSInteger tag)
{
    return tag - 10000000;
}

typedef NS_ENUM(NSInteger, JFSwipeTowards) {
    JFSwipeTowardsNone,
    JFSwipeTowardsLeft,
    JFSwipeTowardsRight
};


@interface JFSwipeView ()
{
    CGFloat _preOffsetX;
    CGFloat _currentOffsetX;
    BOOL _animateIndicateView;
    CGFloat _animateDuration;
//    BOOL _inited;
    BOOL _notifiedViewWillShow;
}

@property (nonatomic) JFSwipeTowards towards;

@property (nonatomic, strong) UIView *contentView;
/// 每个项目的宽度，默认60.f
@property (nonatomic) CGFloat itemWidth;

/// 项目数量
@property (nonatomic) NSInteger numberOfItems;

@property (nonatomic, strong) NSMutableDictionary *reuseableViews;
@property (nonatomic, strong) NSMutableDictionary *reuseableClasses;

/// 每个item的X方向上的起点位置缓存，便于之后直接使用
@property (nonatomic, strong) NSMutableArray *originsXForItemsCaches;

@property (nonatomic, strong) NSMutableSet *identifiers;
@property (nonatomic, strong) NSMutableArray *visualItems;

@property (nonatomic, strong) NSMutableDictionary *itemsPool;


/// 内部指示
//@property (nonatomic) NSInteger indexOfSelectedItemView;


/**
 * @abstract 根据点坐标返回对应的view
 * @param point 点坐标
 * @return 对应的view
 */
- (UIView *)itemViewAtPoint:(CGPoint)point;

/**
 * @abstract 点击动作
 * @param tap 手势
 * @return 空
 */
- (void)didTap:(UITapGestureRecognizer *)tap;


/**
 * @abstract 针对offset X 重新添加items
 * @param offsetX 目前的偏移量
 * @return NULL
 */
- (void)tileItemsAtOffetX:(CGFloat)offsetX;

- (void)pushReuseableView:(UIView *)reuseableView;
- (void)popReusedView:(UIView *)reusedView;

@end

@implementation JFSwipeView


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiveMemoryWarningNorification:(NSNotification *)noti
{
    [self.itemsPool removeAllObjects];
}

- (void)releaseUnuseItems
{
   [self.itemsPool removeAllObjects];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMemoryWarningNorification:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:_contentView];
        
        _reuseableViews = [NSMutableDictionary dictionary];
        _reuseableClasses = [NSMutableDictionary dictionary];
        _visualItems = [NSMutableArray array];
        _identifiers = [NSMutableSet set];
        _originsXForItemsCaches = [NSMutableArray array];
        _itemsPool = [NSMutableDictionary dictionary];
        
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        
        _currentIndex = 0;
        _itemWidth = 60.0;
        _currentOffsetX = 0.;
        _preOffsetX = 0.;
        _indicateViewHeight = 2.0;
        _animateDuration = 0.25;
        _notifiedViewWillShow = NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(didTap:)];
        [self addGestureRecognizer:tap];
        _tapGestureRecognizer = tap;
    }
    
    return self;
}

- (void)reloadData
{
    // 清理之前的视图
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    // 恢复初始
    self.contentOffset = CGPointZero;
    self.contentSize = CGSizeZero;
    [self.visualItems removeAllObjects];
    [self.reuseableViews removeAllObjects];
    [self.identifiers removeAllObjects];
    [self.originsXForItemsCaches removeAllObjects];
    
//    _inited = NO;
    
    if (nil == self.dataSource) {
        return;
    }
    
    // 获取项目数
    if ([self.dataSource respondsToSelector:@selector(numberOfItemViewsInSwipeView:)]) {
        self.numberOfItems = [self.dataSource numberOfItemViewsInSwipeView:self];
    }
    
    if (0 == self.numberOfItems) {
        return;
    }
    
    // 缓存每个item的宽度
    CGFloat totalWidth = 0.0;
    for (NSInteger i=0; i<self.numberOfItems; i++) {

        [self.originsXForItemsCaches addObject:@(totalWidth)];
        totalWidth += self.swipeDelegate?[self.swipeDelegate swipeView:self
                                                   widthForItemAtIndex:i]:CGRectGetWidth(self.bounds);

    }
    // 最后一个
    [self.originsXForItemsCaches addObject:@(totalWidth)];

    // 设置scrollview的contentSize
    self.contentSize = CGSizeMake(totalWidth + self.contentInset.left + self.contentInset.right, 0);
    
    self.contentView.frame = CGRectMake(0, 0, totalWidth + self.contentInset.left + self.contentInset.right, CGRectGetHeight(self.bounds));
    
    if (self.isShowIndicateView) {

        self.indicateView.frame = [self frameForIndicateViewAtIndex:self.currentIndex];
        [self.contentView addSubview:self.indicateView];
    }
    
//    if (self.contentInset.left != 0) {
    self.contentOffset = CGPointMake(-self.contentInset.left, 0);
//    }

//    [self setNeedsLayout];
}

- (void)didMoveToSuperview
{
    [self reloadData];
}

- (void)setShowBottomLine:(BOOL)showBottomLine
{
    if (_showBottomLine != showBottomLine) {
        _showBottomLine = showBottomLine;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    if (self.isShowBottomLine) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        static UIColor *bottomLineColor;
        if (!bottomLineColor) {
            bottomLineColor = [UIColor colorWithHexString:@"dddddd"];
        }
        
        CGContextSetStrokeColorWithColor(context, bottomLineColor.CGColor);
        CGContextSetLineWidth(context, 1.0/ [UIScreen mainScreen].scale);
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(context);
    }
}

#pragma mark - 重用相关方法
- (void)pushReuseableView:(UIView *)reuseableView
{
    
}
- (void)popReusedView:(UIView *)reusedView
{
    
}
- (void)registerClass:(Class)viewClass widthViewReuseIdentifier:(NSString *)identifier
{
    self.reuseableClasses[NSStringFromClass(viewClass)] = identifier;
}

- (NSString *)identifierForClass:(Class)viewClass
{
    return nil;
}

- (UIView *)dequeueViewWithIdentifier:(NSString *)identifier
{
    NSMutableArray *items = self.itemsPool[identifier];
    if (items == nil) {
        items = [NSMutableArray array];
        self.itemsPool[identifier] = items;
    }
    
    if ([items count] == 0) {
        return nil;
    }
    
    UIView *view = [items lastObject];
    if (view) {
        if ([view isKindOfClass:[JFSwipeItemView class]]) {
            [(JFSwipeItemView *)view prepareForReuse];
        }
        [items removeLastObject];
    }
    return view;
}


#pragma mark - 获取item view

- (UIView *)itemViewAtIndex:(NSInteger)index
{
    NSInteger tag = getTagAtIndex(index);
    
    UIView *view = [self.contentView viewWithTag:tag];

    return view;
}

- (UIView *)itemViewAtPoint:(CGPoint)point
{
    for (UIView *view in self.contentView.subviews) {
        
        // 测试
        if ([view.layer hitTest:point]) {
            return view;
        }
    }
    return nil;
}

- (NSInteger)indexOfItemView:(UIView *)itemView
{
    return getIndexWithTag(itemView.tag);
}

#pragma mark - 布局

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGPoint currentOffset = self.contentOffset;
    [self tileItemsAtOffetX:currentOffset.x ];
    
    UIView *selectedItemView = [self itemViewAtIndex:self.currentIndex];
    if ([selectedItemView isKindOfClass:[JFSwipeItemView class]]) {
        [(JFSwipeItemView *)selectedItemView setSelected:YES animated:NO];
    }
}

- (void)placeView:(UIView *)view withIndex:(NSInteger)index
{
    view.tag = getTagAtIndex(index);
    view.frame = [self frameForItemViewAtIndex:index];
    
    [self.contentView addSubview:view];
}

- (void)tileItemsAtOffetX:(CGFloat)offsetX
{
    if (!self.dataSource) {
        return;
    }
    
    if (0 == self.numberOfItems) {
        return;
    }
    
//    CGFloat minVisibleX = offsetX;
//    CGFloat maxVisibleX = offsetX + CGRectGetMaxX(self.frame);
    
    [self tileViewsFromMinX:CGRectGetMinX(self.bounds) toMaxX:CGRectGetMaxX(self.bounds)];
}

- (void)tileViewsFromMinX:(CGFloat)minVisibleX toMaxX:(CGFloat)maxVisibleX
{
    
    if ([self.visualItems count] == 0) {
        UIView *view = [self.dataSource swipeView:self
                                      itemViewAtIndex:self.currentIndex];
        NSParameterAssert(view);
        [self placeView:view withIndex:self.currentIndex];
        [self.visualItems addObject:view];
        if (self.swipeDelegate && [self.swipeDelegate respondsToSelector:@selector(swipeView:willDisplayView:atIndex:)]) {
            [self.swipeDelegate swipeView:self willDisplayView:view atIndex:[self indexOfItemView:view]];
        }
    }
    
    UIView *lastView = [self.visualItems lastObject];
    while (CGRectGetMaxX(lastView.frame) < maxVisibleX) {
        NSInteger index = getIndexWithTag(lastView.tag);
        NSInteger nextIndex = index + 1;
        
        if (nextIndex >= self.numberOfItems) {
            break;
        }
        
        UIView *view = [self.dataSource swipeView:self
                                      itemViewAtIndex:nextIndex];
        
        [self placeView:view withIndex:nextIndex];
        [self.visualItems addObject:view];
        
        lastView = [self.visualItems lastObject];
        
        // 存在一种可能：外界对view有强引用，那么在itemsPool中去掉
        for (NSString *key in self.itemsPool) {
            NSMutableArray *items = self.itemsPool[key];
            if ([items containsObject:view]) {
                [items removeObject:view];
                break;
            }
        }
    }
    
    UIView *firstView = self.visualItems[0];
    while (CGRectGetMinX(firstView.frame) > minVisibleX) {
        NSInteger index = getIndexWithTag(firstView.tag);
        NSInteger preIndex = index - 1;
        
        if (preIndex < 0) {
            break;
        }
        
        UIView *view = [self.dataSource swipeView:self
                                      itemViewAtIndex:preIndex];
        
        [self placeView:view withIndex:preIndex];
        [self.visualItems insertObject:view atIndex:0];
        
        firstView = self.visualItems[0];
        
        // 存在一种可能：外界对view有强引用，那么在itemsPool中去掉
        for (NSString *key in self.itemsPool) {
            NSMutableArray *items = self.itemsPool[key];
            if ([items containsObject:view]) {
                [items removeObject:view];
                break;
            }
        }
    }
    
    lastView = [self.visualItems lastObject];
    while (CGRectGetMinX(lastView.frame) > maxVisibleX) {
        
        // 存放到回收池中
        
        NSString *identifier = self.reuseableClasses[NSStringFromClass([lastView class])];
        
        NSMutableArray *items = self.itemsPool[identifier];
        if (items == nil) {
            items = [NSMutableArray array];
            self.itemsPool[identifier] = items;
        }
        [items addObject:lastView];
        
        if (self.swipeDelegate && [self.swipeDelegate respondsToSelector:@selector(swipeView:endDisplayView:atIndex:)]) {
            [self.swipeDelegate swipeView:self endDisplayView:lastView atIndex:[self indexOfItemView:lastView]];
        }
        
        [lastView removeFromSuperview];
        [self.visualItems removeLastObject];
        lastView = [self.visualItems lastObject];
        
        
    }
    
    firstView = self.visualItems[0];
    while (CGRectGetMaxX(firstView.frame) < minVisibleX) {
        
        // 存放到回收池中
        
        NSString *identifier = self.reuseableClasses[NSStringFromClass([firstView class])];

        NSMutableArray *items = self.itemsPool[identifier];
        if (items == nil) {
            items = [NSMutableArray array];
            self.itemsPool[identifier] = items;
        }
        [items addObject:firstView];
        
        if (self.swipeDelegate && [self.swipeDelegate respondsToSelector:@selector(swipeView:endDisplayView:atIndex:)]) {
            [self.swipeDelegate swipeView:self endDisplayView:firstView atIndex:[self indexOfItemView:firstView]];
        }

        
        [firstView removeFromSuperview];
        [self.visualItems removeObjectAtIndex:0];
        firstView = self.visualItems[0];
    }
    
    if (!_notifiedViewWillShow) {
        for (UIView *view in self.visualItems) {
            if (self.towards == JFSwipeTowardsLeft) {
                if ((CGRectGetMinX(view.frame) < maxVisibleX && CGRectGetMaxX(view.frame) > maxVisibleX)) {
                    if (self.swipeDelegate && [self.swipeDelegate respondsToSelector:@selector(swipeView:willDisplayView:atIndex:)]) {
                        [self.swipeDelegate swipeView:self willDisplayView:view atIndex:[self indexOfItemView:view]];
                    }
                    _notifiedViewWillShow = YES;
                }
            }
            else if (self.towards == JFSwipeTowardsRight) {
                if (CGRectGetMinX(view.frame) < minVisibleX && CGRectGetMaxX(view.frame) > minVisibleX) {
                    if (self.swipeDelegate && [self.swipeDelegate respondsToSelector:@selector(swipeView:willDisplayView:atIndex:)]) {
                        [self.swipeDelegate swipeView:self willDisplayView:view atIndex:[self indexOfItemView:view]];
                    }
                    _notifiedViewWillShow = YES;
                }
            }
        }
    }
}


#pragma mark - 覆写父类方法
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
	return YES;
}


- (CGFloat)widthForItemAtIndex:(NSInteger)index
{
    return [self.originsXForItemsCaches[index+1] floatValue] - [self.originsXForItemsCaches[index] floatValue];
}

- (CGFloat)widthForIndicatorAtIndex:(NSInteger)index
{
    if ([self.swipeDelegate respondsToSelector:@selector(swipeView:widthForIndicatorAtIndex:)]) {
        return [self.swipeDelegate swipeView:self widthForIndicatorAtIndex:index];
    }
    
    // 与item同宽
    return [self widthForItemAtIndex:index];
}

- (CGRect)frameForItemViewAtIndex:(NSInteger)index {
    CGFloat originX = [self.originsXForItemsCaches[index] floatValue];
    CGFloat nextOriginX = [self.originsXForItemsCaches[index+1] floatValue];
    
    CGRect rect = CGRectZero;
    rect.size.height = CGRectGetHeight(self.frame);
    rect.size.width = nextOriginX-originX;
    rect.origin.x = originX + self.contentInset.left;
    rect.origin.y = (CGRectGetHeight(self.frame) - CGRectGetHeight(rect)) / 2.0;
    
    return rect;
}

- (CGRect)frameForIndicateViewAtIndex:(NSInteger)index
{
    if (index+1 >= self.originsXForItemsCaches.count || index < 0) {
        return CGRectZero;
    }
    CGRect frame;
    
    frame.origin.x = [self.originsXForItemsCaches[index] floatValue] + ([self widthForItemAtIndex:index] - [self widthForIndicatorAtIndex:index]) / 2.0 + self.contentInset.left;
    // 距离底部0.5
    frame.origin.y = CGRectGetHeight(self.frame) - self.indicateViewHeight - 0.5;
    CGFloat width = [self widthForIndicatorAtIndex:index];
    frame.size.width = width;
    frame.size.height = self.indicateViewHeight;
    
    return frame;
}

- (CGFloat)valueWithPercent:(CGFloat)percent
                   minValue:(CGFloat)min
                   maxValue:(CGFloat)max
{
    return min + (max - min) * percent;
}

- (void)scrollIndicateViewFromIndex:(NSInteger)index progress:(CGFloat)progress
{
//    printf("%ld - %.2f\n", (long)index, progress);
    if (index< 0 || index+1 > [self.originsXForItemsCaches count]) {
        return;
    }
    CGRect previousRect = [self frameForIndicateViewAtIndex:index];
    CGRect nextRect = [self frameForIndicateViewAtIndex:index+1];

    CGRect currentRect = previousRect;
    
    currentRect.origin.x = CGRectGetWidth(previousRect) * progress + CGRectGetMinX(previousRect);
    
    currentRect.size.width = [self valueWithPercent:progress
                                           minValue:CGRectGetWidth(previousRect)
                                           maxValue:CGRectGetWidth(nextRect)];
    
    self.indicateView.frame = currentRect;
}

#pragma mark - 点击手势

- (void)changeSelectedItemToIndex:(NSInteger)toIndex animated:(BOOL)animated
{
    // 跟当前index不同，需要做一些改变
    if (toIndex != self.currentIndex) {
        
        UIView *currentView = [self currentItemView];
        
        if ([currentView isKindOfClass:[JFSwipeItemView class]]) {
            [(JFSwipeItemView *)currentView setSelected:NO animated:animated];
        }
        
        UIView *toView = [self itemViewAtIndex:toIndex];
        if ([toView isKindOfClass:[JFSwipeItemView class]]) {
            [(JFSwipeItemView *)toView setSelected:YES animated:animated];
        }
        
        _currentIndex = toIndex;
        if (self.pagingEnabled && [self.swipeDelegate respondsToSelector:@selector(swipeViewDidChangeCurrentIndex:)]) {
            [self.swipeDelegate swipeViewDidChangeCurrentIndex:_currentIndex];
        }
    }
}

// 点击
- (void)didTap:(UITapGestureRecognizer *)tap
{
    // 被点击的视图
    UIView *view = [self itemViewAtPoint:[tap locationInView:self]];
    if (![view isKindOfClass:[JFSwipeItemView class]]) {
        return;
    }
    // 被点击视图的index
    NSInteger indexOfView = [self indexOfItemView:view];
    
    // 滚动
    [self scrollIndicateViewToIndex:indexOfView animate:YES];
    [self scrollToItemAtIndex:indexOfView animated:YES];
    
    // 回调
    if (self.swipeDelegate &&
        [self.swipeDelegate respondsToSelector:@selector(swipeView:didSelectedAtIndex:)]) {
        [self.swipeDelegate swipeView:self didSelectedAtIndex:indexOfView];
    }
}

- (void)scrollIndicateViewToIndex:(NSInteger)index animate:(BOOL)animate
{
    // 显示下方的指示图片
    if (self.isShowIndicateView && [self.originsXForItemsCaches count]) {
        if (_animateIndicateView) {
            printf("---------------已经是在动画中\n");
        }

        CGRect rect = [self frameForIndicateViewAtIndex:index];
        if (!CGRectEqualToRect(rect, self.indicateView.frame)) {
            if (animate) {
                _animateIndicateView = YES;
                [UIView animateWithDuration:_animateDuration
                                 animations:^{
                                     self.indicateView.frame = rect;
                                 } completion:^(BOOL finished) {
                                     if (finished) {
                                         _animateIndicateView = NO;
                                     }
                                 }];
            } else {
                self.indicateView.frame = rect;
            }
        }
    }
}

#pragma mark - 滚动到index
- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated
{
    CGFloat gapDistance;
    if (self.gap < self.originsXForItemsCaches.count) {
        gapDistance = [self.originsXForItemsCaches[self.gap] floatValue];
    } else {
        gapDistance = 0;
    }
    
    CGFloat offsetXAtIndex = [self.originsXForItemsCaches[index] floatValue];
    CGFloat offsetX = offsetXAtIndex - gapDistance - self.contentInset.left;
    
    CGPoint offset = CGPointZero;
    offset.x -= self.contentInset.left;
    
    CGFloat width = CGRectGetWidth(self.frame);
    if (self.contentSize.width > width) {
        if (offsetX > fabs(self.contentSize.width - CGRectGetWidth(self.frame) - self.contentInset.left)) {
            offset = CGPointMake(self.contentSize.width - CGRectGetWidth(self.frame) - - self.contentInset.left, 0);
        } else if (offsetX >= 0) {
            offset = CGPointMake(offsetX, 0);
        } 
    }
    
    [self scrollToOffset:offset animated:animated];
    [self changeSelectedItemToIndex:index animated:animated];
    [self scrollIndicateViewToIndex:index animate:animated];
}

- (void)scrollToOffset:(CGPoint)offset animated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:_animateDuration animations:^{
            [self setContentOffset:offset];
        } completion:^(BOOL finished) {
        }];
    } else {
        [self setContentOffset:offset];
    }
}

#pragma mark - ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _preOffsetX = scrollView.contentOffset.x;
    _currentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentOffsetX = scrollView.contentOffset.x;
    CGFloat distance = _currentOffsetX - _preOffsetX;
    if ( distance > 0) {
        if(self.towards != JFSwipeTowardsLeft) {
            self.towards = JFSwipeTowardsLeft;
            _notifiedViewWillShow = NO;
        }
        
    } else if (distance < 0){
        if (self.towards != JFSwipeTowardsRight) {
            self.towards = JFSwipeTowardsRight;
            _notifiedViewWillShow = NO;
        }
    } else {
        self.towards = JFSwipeTowardsNone;
    }
    _preOffsetX = _currentOffsetX;
    
    if ([self.swipeDelegate respondsToSelector:@selector(swipeViewDidScroll:)]) {
        [self.swipeDelegate swipeViewDidScroll:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.towards = JFSwipeTowardsNone;
    _notifiedViewWillShow = NO;
    
    if (self.pagingEnabled) {
        NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds);
//        if (_currentIndex != page) {
        _currentIndex = page;
        if ([self.swipeDelegate respondsToSelector:@selector(swipeViewDidChangeCurrentIndex:)]) {
            [self.swipeDelegate swipeViewDidChangeCurrentIndex:page];
        }
//        }
    }

}

#pragma mark - Getter And Setter

- (JFSwipeIndicateView *)indicateView
{
    if (!_indicateView) {
        _indicateView = [[JFSwipeIndicateView alloc] initWithFrame:CGRectZero];
    }
    return _indicateView;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    if (![self.originsXForItemsCaches count]) {
        return;
    }
    
    [self scrollToItemAtIndex:currentIndex animated:YES];
//    [self scrollIndicateViewToIndex:currentIndex animate:NO];
    
//    CGFloat offsetX = [self.originsXForItemsCaches[_currentIndex] floatValue];
//    [self setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    
    // 强制刷新，因为此时的可见区域可能没有视图，强制刷新后则会显示
    if (!self.currentItemView) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
    
    if (self.pagingEnabled && [self.swipeDelegate respondsToSelector:@selector(swipeViewDidChangeCurrentIndex:)]) {
        [self.swipeDelegate swipeViewDidChangeCurrentIndex:_currentIndex];
    }
    
}

- (UIView *)currentItemView
{
    return [self itemViewAtIndex:_currentIndex];
}
@end
