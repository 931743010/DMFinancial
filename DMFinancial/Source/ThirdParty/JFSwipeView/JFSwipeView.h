//
//  JFSwipeView.h
//  IndexPagesDemo
//
//  Created by Joseph Fu on 14-11-4.
//  Copyright (c) 2014年 Joseph Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFSwipeItemView.h"
#import "JFSwipeUnderneathIndicateView.h"
#import "JFSwipeLineIndicateView.h"

@protocol JFSwipeViewDataSource, JFSwipeViewSwipeDelegate;

@interface JFSwipeView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, weak) id <JFSwipeViewDataSource> dataSource;
@property (nonatomic, weak) id <JFSwipeViewSwipeDelegate> swipeDelegate;

@property (nonatomic, getter=isShowBottomLine) BOOL showBottomLine;

/// 显示指示器
@property (nonatomic, getter=isShowIndicateView) BOOL showIndicateView;
@property (nonatomic) float indicateViewHeight;
@property (nonatomic, strong) JFSwipeIndicateView *indicateView;



/// 这个属性，在调用方法scrollToItemAtIndex:animated:时才用的到
@property (nonatomic) NSInteger gap;

/// 当前itemView的index
@property (nonatomic) NSInteger currentIndex;

@property (nonatomic, readonly) UITapGestureRecognizer *tapGestureRecognizer;

- (void)reloadData;

/**
 * @abstract 出列一个item view
 * @param identifier itemView的标识符，暂时没有使用
 * @return itemView，如果队列里没有，则返回nil
 */
- (UIView *)dequeueViewWithIdentifier:(NSString *)identifier;
- (void)registerClass:(Class)viewClass widthViewReuseIdentifier:(NSString *)identifier;

/**
 * @abstract 滚动到索引为index的itemview处
 * 这个方法配合着属性gap一起工作
 * @param index itemView的索引，
 */
- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated;

- (void)scrollIndicateViewFromIndex:(NSInteger)index progress:(CGFloat)progress;
- (void)scrollIndicateViewToIndex:(NSInteger)index animate:(BOOL)animate;

- (UIView *)itemViewAtIndex:(NSInteger)index;
- (NSInteger)indexOfItemView:(UIView *)itemView;
- (UIView *)currentItemView;

- (void)releaseUnuseItems;

@end

@protocol JFSwipeViewDataSource <NSObject>

- (NSInteger)numberOfItemViewsInSwipeView:(JFSwipeView *)swipeView;

- (UIView *)swipeView:(JFSwipeView *)swipeView itemViewAtIndex:(NSInteger)index;

@end

@protocol JFSwipeViewSwipeDelegate <NSObject>

- (CGFloat)swipeView:(JFSwipeView *)swipeView widthForItemAtIndex:(NSInteger)index;

@optional

- (CGFloat)swipeView:(JFSwipeView *)swipeView widthForIndicatorAtIndex:(NSInteger)index;

- (void)swipeView:(JFSwipeView *)swipeView didSelectedAtIndex:(NSInteger)index;
- (void)swipeView:(JFSwipeView *)swipeView deSelectedAtIndex:(NSInteger)index;

//如果JFSwipeView实例的delegate默认是其自身，则会调用下面的代理方法
- (void)swipeViewDidScroll:(JFSwipeView *)swipeView;

// 如果设定了pagingEnabled为YES，则在滚动时会调用这个方法
- (void)swipeViewDidChangeCurrentIndex:(NSInteger)currentIndex;

- (void)swipeView:(JFSwipeView *)swipeView endDisplayView:(UIView *)view atIndex:(NSInteger)index;
- (void)swipeView:(JFSwipeView *)swipeView willDisplayView:(UIView *)view atIndex:(NSInteger)index;

@end