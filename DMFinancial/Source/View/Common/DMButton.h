//
//  DMButton.h
//  CommonLibrary
//
//  Created by 陈彦岐 on 14/11/3.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ButtonSelectedAction)(id returnData);

@interface DMButton : UIButton

/**
 *  设置圆角
 */
@property (nonatomic, assign) CGFloat radius;


/**
 *  点击按钮后的回调
 *
 *  @param action block。在这个block中添加点击按钮后的操作代码
 */
- (void)buttonClickedcompletion:(ButtonSelectedAction)action;

/**
 *  是否有点击效果 (适用于纯色按钮的点击效果)
 *
 *  @param color       button的背景颜色
 *  @param selectAlpha 点击效果的黑色透明度
 */
- (void)setButtonBackGroundColor:(UIColor *)color selectAlpha:(CGFloat)selectAlpha;

@end
