//
//  DMBannerCell.h
//  DamaiIphone
//
//  Created by SongDong on 15-3-10.
//  Copyright (c) 2015年 damai. All rights reserved.
//  首页轮播图cell

#import <UIKit/UIKit.h>
#import "DMSubject.h"
#import "DMTableViewCell.h"
#import "DMProjectListItem.h"
#import "SwipeView.h"

@class DMBannerModel;
@protocol DMBannerCellDelegate <NSObject>

@optional
-(void)DMBannerImageClickWithSubject:(DMBannerModel *)subject;
- (void)selectedType:(NSString *)type param:(NSDictionary *)param;

@end

@interface DMBannerCell : DMTableViewCell<SwipeViewDataSource, SwipeViewDelegate>

@property(nonatomic, assign) id<DMBannerCellDelegate> delegate;
/**
 *  启动定时器
 */
- (void)startTimer;

/**
 *  停止计时器销毁
 */
- (void)stopTimer;

/**
 *  刷新banner
 *
 *  @param subjects     banner 数据对象 数组 只支持DMBannerModel类型
 */
-(void)reloadBannerWithSubjects:(NSArray *)subjects;

@end

@interface DMBannerModel : DMObject

@property (nonatomic, strong) NSString *type;//类型
@property (nonatomic, strong) NSString *picUrl;//展示的图片的url
@property (nonatomic, strong) NSString *param;//参数

@end