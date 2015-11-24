//
//  DMNewbieGuideView.h
//  DamaiIphone
//
//  Created by SongDong on 14-7-29.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dismissGuideViewBlock)();

@interface DMNewbieGuideView : UIView

@property (nonatomic, copy) dismissGuideViewBlock dismissblock;
@property (nonatomic, strong) NSArray *imageNameArray;
@property (nonatomic, strong) UIImageView *guideImageView;

/**
 *  显示新手引导view
 *  imageName新手引导界面背景图片名称（xxx.ipg/png)  view要加到的view
 */
-(void)showNewbieGuideViewWithImageName:(NSString *)imageName
                                 inView:(UIView *)view
                          dismissbBlock:(dismissGuideViewBlock)block;
/**
 *  显示新手引导view
 *  imageNameArray新手引导界面背景图片名称（xxx.ipg/png）数组  view要加到的view
 */
-(void)showNewbieGuideViewWithImageNames:(NSArray *)imageNameArray
                                  inView:(UIView *)view
                           dismissbBlock:(dismissGuideViewBlock)block;

@end
