//
//  UIView+Common.h
//  DamaiHD
//
//  Created by lixiang on 13-11-25.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)
/**
 *  显示警告信息
 *
 *  @param text
 */
- (void)showWaringViewWithText:(NSString *)text;
/**
 *
 *
 *  @param text 
 */
- (void)showWaringViewWithText:(NSString *)text detail:(NSString *)detail;

- (void)showWaringViewWithText:(NSString *)text iconImageNamed:(NSString *)iconImageName;
/**
 *  隐藏警告信息
 */
- (void)hideWaringView;

@end
