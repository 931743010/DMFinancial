//
//  DMPageBottomButtonView.h
//  DamaiIphone
//
//  Created by 陈彦岐 on 14-10-15.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct DMVerticalInsets {
    CGFloat top;
    CGFloat bottom;
}DMVerticalInsets;


static inline DMVerticalInsets DMVerticalInsetsMake(CGFloat top, CGFloat bottom) {
    DMVerticalInsets insets = {top, bottom};
    return insets;
}

static const DMVerticalInsets DMVerticalInsetsZero = {0, 0};

typedef void(^ButtonSelectedAction)(id returnData);

@interface DMPageBottomButtonView : UIView


/**
 *  初始化空间
 *
 *  @param items 按钮上的文字数组. 根据数组的数量创建按钮个数. 最多两个
 *
 *  @return
 */
-(instancetype)initWithButtonTitles:(NSArray *)buttonTitles;

/**
 *  点击按钮后的回调
 *
 *  @param action block。在这个block中添加点击按钮后的操作代码
 */
- (void)buttonClickedcompletion:(ButtonSelectedAction)action;


/**
 *  设置按钮的文字和背景颜色
 *
 *  @param buttonTitles           按钮文字数组
 *  @param buttonBackgroundColors 背景颜色数组
 */
-(void)setButtonTitles:(NSArray *)buttonTitles buttonBackgroundColors:(NSArray *)buttonBackgroundColors;

/**
 * 启用所有button
 * 
 * @param enable 是否启用
 */
- (void)enableAllButtons:(BOOL)enable;

/**
 * 启用button
 *
 * @param enable 是否启用
 * @param index  button的索引
 */
- (void)enableButton:(BOOL)enable atIndex:(NSInteger)index;

- (void)changeButtonTitle:(NSString *)title atIndex:(NSInteger)index;

- (UIButton *)buttonAtIndex:(NSInteger)index;

@property (nonatomic, copy) void(^configButtonBlock)(UIButton *button, NSInteger index);
@property (nonatomic) BOOL showSeperator;
@property (nonatomic) DMVerticalInsets seperatorInsets;

@end
