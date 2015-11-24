//
//  UIView+JFAddSeperator.h
//  OpenReminderController
//
//  Created by Joseph Fu on 15/1/5.
//  Copyright (c) 2015年 Joseph Fu. All rights reserved.
//
// Note: 该方法使用的是苹果官方提供demo中的一个方法

#import <UIKit/UIKit.h>

@interface UIView (JFAddSeperator)

/**
 * @abstract 添加分隔线
 * @param edge 边
 * @param color 边的颜色
 * @return 分隔线
 */
- (UIView *)jf_addSeperatorToEdge:(CGRectEdge)edge color:(UIColor *)color;

/**
 * @abstract 添加分隔线
 * @param edge 边
 * @param color 边的颜色
 * @param left 当edge为CGRectMinXEdge或CGRectMaxXEdge时，left相当于top
 * @param right 当edge为CGRectMinYEdge或CGRectMaxYEdge时，right相当于bottom
 * @return 分隔线
 */
- (UIView *)jf_addSeperatorToEdge:(CGRectEdge)edge
                            color:(UIColor *)color
                      paddingLeft:(CGFloat)left
                     paddingRight:(CGFloat)right;
@end
