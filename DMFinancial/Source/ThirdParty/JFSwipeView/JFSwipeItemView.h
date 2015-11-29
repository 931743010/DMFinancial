//
//  JFSwipeItemView.h
//  IndexPagesDemo
//
//  Created by Joseph Fu on 14/11/7.
//  Copyright (c) 2014年 Joseph Fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFSwipeItemView : UIView
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) CGFloat alphaOfNormalColor;
@property (nonatomic, strong) NSArray *selectedColorElements;
@property (nonatomic, strong) NSArray *normalColorElements;

@property (nonatomic, getter=isSelected) BOOL selected;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@property (nonatomic) CGFloat progressForWillSelected;
@property (nonatomic) CGFloat maxFontSize;
@property (nonatomic) CGFloat minFontSize;

@property (nonatomic) UIFont *selectedFont;
@property (nonatomic) UIFont *normalFont;

- (void)prepareForReuse;
- (void)makeScale:(float)scale;
- (UIColor *)colorWithPercent:(CGFloat)percent;

- (CGFloat)valueWithPercent:(CGFloat)percent
                   minValue:(CGFloat)min
                   maxValue:(CGFloat)max;
@end
